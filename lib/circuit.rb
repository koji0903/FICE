################################################################
#
# Curcuit Data Base
#
#   Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
###############################################################
#
$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'FICE_def'
require 'common'
require 'conformal'
module Circuit
  include Conformal
  # ----------------------------------------------------------------------------
  # All Information
  #  Circuit{ModuelName} = [ModuleInf](PortName)
  # ----------------------------------------------------------------------------
  class Circuit
    # Array : [File A, File B, File C, ...]
    attr_reader :FileList
    # Hash  : {ModuleName => HDL FileName}
    attr_reader :ModuleHDL
    # Module Infomation
    attr_reader :Module
    # Top Module Name
    attr_reader :TopModule
    # Hier Information
    attr_reader :Hier
    # For Conformal
    attr_accessor :Conformal
    def initialize
      # Module List saved all module information
      @Module = Hash.new
      # Module Name and HDL File
      @ModuleHDL = Hash.new
      # Generate result directory name
      @dir = "result"
      # Specified file name
      @FileList = nil
      # Top Module Name
      @TopModule = nil
      # Hierarchy
      @Hier = Hash.new
      # Setting File for Conformal
      @Conformal = nil
    end

    #
    # make_TopModule
    def make_TopModule
      if @Module.size != 1
        $ERROR_CNT += 1
        printf("@E:CT101:Cannot Analyze TopModule Name\n")
        Common.print_summary
        exit
      else
        @Module.each_key{|key|
          @TopModule = key
        }
      end
    end

    #
    #
    # make_FileList(file_list)
    def make_FileList(file_list)
      @FileList = file_list
    end

    #
    #
    #
    def make_ModuleHDL(module_name,file_list)
      if @ModuleHDL["#{module_name}"] == nil
        tmp = file_list
        tmp.delete("")
        @ModuleHDL["#{module_name}"] = tmp
      else
        @ModuleHDL["#{module_name}"].each{|saved_file|
          file_list.each{|new_file|
            if saved_file == new_file
              $ERROR_CNT += 1
              printf("@E:CT102: different file name(%s,%s) was described to same module(%s) in HDLList File\n",new_file,save_file,module_name)
              Common.print_summary
              exit
            end
          }
        }
        tmp = @ModuleHDL["#{module_name}"]
        tmp = tmp + file_list
        tmp.delete("")
        @ModuleHDL["#{module_name}"] = tmp
      end
    end

    #
    #
    # Make New Module
    #
    def make_module(module_name)
      if @Module["#{module_name}"] != nil
        $WARNING_CNT += 1
        printf("@W:CT100:%s module was multiple defined\n",module_name)
      else
        @Module["#{module_name}"] = ModuleInf.new
        printf("Module:%s\n",module_name) if $VERBOSE
        @Module["#{module_name}"]
      end
    end
    
    #
    # Add Signal-List in target module
    # 
    def add_signal(module_name,signal_name)
      module_inf = @Module["#{module_name}"]
      module_inf.SignalList << signal_name
      printf(" - signal : %s\n",signal_name) if $VERBOSE
      @Module["#{module_name}"] = module_inf
    end

    #
    # Add Each Port in taget module
    #
    def add_port(module_name,direction,port_name,msb,lsb)
      module_inf = @Module["#{module_name}"]
      module_inf.make_port(direction,port_name,msb,lsb)
      printf(" - port : [%3s] name - %15s, msb - %2d, lsb - %2d\n",direction,port_name,msb,lsb) if $VERBOSE
    end

    #
    # Add Each wire in taget module
    #
    def add_wire(module_name,port_name,msb,lsb)
      module_inf = @Module["#{module_name}"]
      module_inf.make_wire(port_name,msb,lsb)
      printf(" - wire : name - %15s, msb - %2d, lsb - %2d\n",port_name,msb,lsb) if $VERBOSE
    end

    #
    #
    #
    def add_instance(module_name,inst_module_name,inst_name)
      module_inf = @Module["#{module_name}"]
      module_inf.make_inst(inst_name,inst_module_name)
      printf(" - instance : module_name - %15s, inst_name - %15s\n",inst_module_name,inst_name) if $VERBOSE
        
      # Without REL Primitive module
#      unless /^TB\w*/ =~ inst_module_name
        inst_list = @Hier["#{module_name}"]
        if inst_list.nil?
          inst_list = Hash.new
        end
        inst_list["#{inst_name}"] = inst_module_name
        @Hier["#{module_name}"] = inst_list
#      end

    end    

    #
    #
    #
    def add_inst_port(module_name,inst_name,signal_name,wire_name)
      module_inf = @Module["#{module_name}"]

      printf("    - inst_port : inst_name - %15s ( %15s -> %15s )\n",inst_name,signal_name,wire_name) if $VERBOSE

      # make ConnectionList
      inst_inf = module_inf.InstanceList["#{inst_name}"]
      if inst_inf != nil
        inst_inf.ConnectionList["#{signal_name}"] = wire_name
      else
        $ERROR_CNT += 1
        Common.internal_error(__FILE__,__LINE__)
        exit
      end

      # make WireConnect
      wire_name.each{|wire_each|
        wire_connect  = module_inf.WireConnect
        tmp = Array.new
        unless wire_connect.nil?
          unless wire_connect["#{wire_each}"].nil?
            tmp = wire_connect["#{wire_each}"]
          end
        end
        each_inf = Hash.new
        each_inf["#{inst_name}"] = [inst_inf.ModuleName,signal_name]
        tmp << each_inf
        wire_connect["#{wire_each}"] = tmp
      }
    end
      
    #
    #
    #
    def add_gate(module_name,gate_name)
      module_inf = @Module["#{module_name}"]
      module_inf.make_gate(gate_name)
      printf(" - gate  : name - %15s\n",gate_name) if $VERBOSE
    end
    
    #
    #
    #
    def add_gate_port(module_name,gate_name,signal_name)
      module_inf = @Module["#{module_name}"]

      # make ConnectionList
      printf("    - gate_port : gate_name - %15s ( %15s  )\n",gate_name,signal_name) if $VERBOSE
      gate_inf = module_inf.GateList["#{gate_name}"]
    end

    #
    # make Connect Informaion
    #
    def make_connect_inf
      @Module.each{|module_name,module_inf|
        wire_base = Hash.new
        module_inf.WireConnect.each{|wire,value|
          in_list = Array.new
          out_list = Array.new
          inout_list = Array.new
          value.each{|con|
            con.each{|inst_name,port_inf| # port_inf[0]:ModuleName, port_inf[1]:SignalName
              # get input/output inf
              mod_name = port_inf[0]
              port_name = port_inf[1]
              mod_inf = @Module["#{mod_name}"]
              unless mod_inf.nil?
                in_list << [inst_name,mod_name,port_name] if mod_inf.InputPort["#{port_name}"]
                out_list << [inst_name,mod_name,port_name] if mod_inf.OutputPort["#{port_name}"]
                inout_list << [inst_name,mod_name,port_name] if mod_inf.InoutPort["#{port_name}"]
                # special case
                if mod_name == "TBCLH" || mod_name == "TBCLL"
                  out_list << [inst_name,mod_name,port_name]
                end
              end
            } # con.each
          } # value.each
          wire_base["#{wire}"] = [in_list,out_list,inout_list]
        } # module_inf.WireConnect.each        
        # Save
        module_inf.make_connect(wire_base)
      } # @Module.each
    end
    
    #
    # Display
    #
    public
    def display
      print <<EOB

-------------------------------------
Print created Module Database
-------------------------------------
EOB

p @Module
    end

    #
    # Generate Report
    #   - make "result" directory
    #   - make each report file
    #
    def generate
      Common.del_dir("#{@dir}")
      Common.make_dir("#{@dir}")

      case $MODE
      when "AnalyzeMode"
        generate_module_inf
        generate_hier_inf
        # For Conformal
        unless @Conformal.nil?
          conformal = Conformal::Setting.new(@Conformal)
          conformal.main
          generate_SubModuleConformal(conformal.ModuleName)
          generate_PortDiff(conformal.PortDiff)
        end
      when "StartupMode"
        conf = Conf.new(@dir,@FileList)
        conf.generate
      when "ConnectMode"
        generate_module_inf
        generate_inst_inf
        generate_hier_inf
      end
    end
    
    private
    #
    # Genearte Module Information(ModuleName/Port/Instance)
    #
    def generate_module_inf
      Common.make_dir("#{@dir}/_ModuleInf")
      i = 1
      @Module.each{|module_name,module_inf|
        file_name = @dir + "/_ModuleInf/" + module_name + ".txt" 
        printf("@I:generate %s(%d/%d)\n",file_name,i,$CircuitInf.Module.size)
        f = open("#{file_name}","w")
        comment = "Module Information about " + module_name 
        Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")

        # Print Module Inf
        f.printf("#\n")
        f.printf("# Module Name\n")
        f.printf("#\n")
        f.printf("%s ( has %s instance(s) )\n\n",module_name, module_inf.InstanceList.size)

        # Print Port Inf
        f.printf("#\n")
        f.printf("# Port Infotmaion\n")
        f.printf("#\n")
        f.printf("\n")
        f.printf("# Input-Port\n")
        module_inf.InputPort.sort_by{|port_name,value|
          port_name
        }.each{|port_name,value|
          if value.MSB != 0 && value.LSB != 0
            f.printf(" %s (msb:%d, lsb:%d)\n",value.PortName,value.MSB,value.LSB)
          else
            f.printf(" %s\n",value.PortName)
          end
        } if module_inf.InputPort != nil
        f.printf("\n")
        f.printf("# Output-Port\n")
        module_inf.OutputPort.sort_by{|port_name,value|
          port_name
        }.each{|port_name,value|
          if value.MSB != 0 && value.LSB != 0
            f.printf(" %s (msb:%d, lsb:%d)\n",value.PortName,value.MSB,value.LSB)
          else
            f.printf(" %s\n",value.PortName)
          end
        } if module_inf.OutputPort != nil
        f.printf("\n")
        f.printf("# Inout-Port\n")
        module_inf.InoutPort.sort_by{|port_name,value|
          port_name
        }.each{|port_name,value|
          if value.MSB != 0 && value.LSB != 0
            f.printf(" %s (msb:%d, lsb:%d)\n",value.PortName,value.MSB,value.LSB)
          else
            f.printf(" %s\n",value.PortName)
          end
        } if module_inf.InoutPort != nil
        f.printf("\n")

        # Print Instance Inf
        f.printf("\n")
        f.printf("#\n")
        f.printf("# Instance Information ##\n")
        f.printf("#\n")
        f.printf("\n")
        module_inf.InstanceList.sort_by{|key,value|
          key
        }.each{|inst_name,value|
          # Print Instance Name
          f.printf(" %s (%s)\n",inst_name, value.ModuleName)
        }
=begin
        # Print between instance connection
        f.printf("\n")
        f.printf("#\n")
        f.printf("# Connection Information based on wire\n")
        f.printf("#\n")
        f.printf("\n")
        module_inf.WireConnect.sort_by{|wire_name,value|
          wire_name
        }.each{|wire,value|
          f.printf("%s\n",wire)
          value.each{|con|
            con.each{|inst_name,port_inf| # port_inf[0]:ModuleName, port_inf[1]:SignalName
              direction = nil
              # get input/output inf
              mod_name = port_inf[0]
              port_name = port_inf[1]
              mod_inf = @Module["#{mod_name}"]
              unless mod_inf.nil?
                direction = "IN" if mod_inf.InputPort["#{port_name}"]
                direction = "OUT" if mod_inf.OutputPort["#{port_name}"]
                direction = "INOUT" if mod_inf.InoutPort["#{port_name}"]
              end
              f.printf("\tInstance : %s[%s], Port Name : %s - %s\n ",inst_name,mod_name,port_name,direction)
            }
          }
          f.printf("\n")
        }
=end
        # Print between instance connection
        f.printf("\n")
        f.printf("#\n")
        f.printf("# Connection Information detail\n")
        f.printf("#\n")
        f.printf("\n")
        module_inf.ConnectInf.each{|each_con|
          if each_con.Source != nil
            item = each_con.Source
            if item.Category != nil
              case item.Category
              when "IN","OUT","INPUT"
                f.printf("Source:[%s]%s\n",item.Category,item.SignalName)
              when "INST"
                f.printf("Source:[%s]%s(%s[%s])\n",item.Category,item.SignalName,item.InstName,item.ModuleName)
              end
            else
              f.printf("Source:Nothing\n")
            end
          end
          if each_con.Destination != nil
            each_con.Destination.each{|item|
              if item.Category != nil
                case item.Category
                when "IN","OUT","INPUT"
                  f.printf("Destination:[%s]%s\n",item.Category,item.SignalName)
                when "INST"
                  f.printf("Destination:[%s]%s(%s[%s])\n",item.Category,item.SignalName,item.InstName,item.ModuleName)
                end
              else
                f.printf("Destination:Nothing\n")
              end
            }
          end
#          f.printf("\n")
        }

        # Print Module List
        f.printf("\n")
        f.printf("#\n")
        f.printf("# Instanciated Module List\n")
        f.printf("#\n")
        f.printf("\n")
        module_inf.ModuleList.sort.each{|name|
          f.printf "#{name}\n"
        }

        f.close
        i += 1
      }

    end
    
    #
    # Generate Inst Inf
    #
    def generate_inst_inf
      i = 1
      Common.make_dir("#{@dir}/_InstModuleInf")
      total = 0
      @Module.each{|module_name,module_inf|
#        module_inf.InstanceList.each_value{|inst_inf|
#          next if /^TB\w*/ =~ inst_inf.ModuleName
#          total += 1
#        }
        total += module_inf.InstanceList.size
      }

      @Module.each{|module_name,module_inf|
        module_inf.InstanceList.each{|inst_name,inst_inf|
#          next if /^TB\w*/ =~ inst_inf.ModuleName
          file_name = @dir + "/_InstModuleInf/" + inst_name + ":" + inst_inf.ModuleName + ".inf" 
          printf("@I:generate %s(%d/%d)\n",file_name,i,total)
          f = open("#{file_name}","w")
          comment = "Connect Information about " + inst_name + "(" + inst_inf.ModuleName + ")"
          Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
          f.printf("# %s\n",inst_inf.ModuleName)
          inst_inf.ConnectionList.sort_by{|key|
            key
          }.each{|sig,wire|
            f.printf("C:%s.%s %s\n",inst_name,sig,wire)            
          }
          i += 1
          f.close
        }
      }
    end

    #
    # Generate Hierarchy Inf
    #
    def generate_hier_inf
      file_name = @dir + "/hierarchy.txt"
      printf("@I:generate %s\n",file_name)
      f = open("#{file_name}","w")
      comment = "Hierarchy Information"
      f.printf("%s\n",@TopModule)
      i = 1
      inst_module_name = nil
      @Hier["#{@TopModule}"].each{|inst_name,inst_module_name|
        f.printf("%s+%s[%s]\n"," "*i,inst_name,inst_module_name)
        search_inst(f,inst_module_name,i+1)
      } unless @Hier["#{@TopModule}"].nil?
      f.close
    end
    #
    # Search instance list at one module
    #
    def search_inst(f,inst_module_name,i)
      @Hier["#{inst_module_name}"].each{|inst_name,inst_module_name|
        f.printf("%s+%s[%s]\n"," "*i,inst_name,inst_module_name)
        search_inst(f,inst_module_name,i+1)
      } if !@Hier["#{inst_module_name}"].nil?
    end

    #
    # Genearte Conformal Script
    #
    def generate_SubModuleConformal(target)
      return if target.nil?
      dir = "#{@dir}/_Conformal"      
      Common.make_dir("#{dir}")
      # Generate runAll scrip
      run_all = Conformal::RunScript.new(dir)
      run_all.generate
      # Generate file each SubModule
      @Module.each{|module_name,module_inf|
        if target == module_name
          module_inf.ModuleList.each{|module_name|
            conformal = Conformal::RunEnvironment.new(dir,module_name)
            conformal.main
          }
        end
      }
    end

    #
    # Genearte PortDiff
    #
    def generate_PortDiff(target)
      return if target.nil?
      dir = "#{@dir}/_PortDiff"
      Common.make_dir("#{dir}")
      target.each do |pair|
        port_diff = Conformal::PortDiff.new(dir,pair,@Module)
        port_diff.report
      end
    end


  end # end Class Circuit

  # ----------------------------------------------------------------------------
  # Module Information Class
  # ----------------------------------------------------------------------------
  class ModuleInf
    # Signal List - "module module_name ( XXX );"
    attr_accessor :SignalList
    # Wire List - "wire XXX"
    attr_accessor :WireList
    # Input Port - "input XXX"
    attr_accessor :InputPort
    # Input Port - "output XXX"
    attr_accessor :OutputPort
    # Input Port - "inout XXX"
    attr_accessor :InoutPort
    # InstanceList - Hash{ instance_name => Instance Inf (see Instance class)}
    attr_accessor :InstanceList
    # ModuleList - Array
    attr_accessor :ModuleList
    # Instantiated Gate List
    attr_accessor :GateList
    # Wire Connect ( connect information base on wire )
    attr_accessor :WireConnect
    # Dtail of Connect Information
    attr_accessor :ConnectInf


    def initialize
      @SignalList = Array.new
      @WireList = Hash.new
      @InputPort = Hash.new
      @OutputPort = Hash.new
      @InoutPort = Hash.new
      @InstanceList = Hash.new
      @ModuleList = Array.new
      @GateList = Hash.new
      @WireConnect = Hash.new
      @ConnectInf = Array.new
    end

    def make_port(direction,name,msb,lsb)
      port = Port.new
      port.PortName = name
      port.MSB = msb
      port.LSB = lsb
      case direction
      when "IN"
        @InputPort["#{name}"] = port
      when "OUT"
        @OutputPort["#{name}"] = port
      when "INOUT"
        @InoutPort["#{name}"] = port
      else
        Common.internal_error(__FILE__,__LINE__)
      end
    end

    def make_wire(name,msb,lsb)
      wire = Port.new
      wire.PortName = name
      wire.MSB = msb
      wire.LSB = lsb
      @WireList["#{name}"] = wire
    end
    
    def make_inst(inst_name,module_name)
      inst_inf = Instance.new
      inst_inf.ModuleName = module_name
      @InstanceList["#{inst_name}"] = inst_inf
      @ModuleList << module_name
      @ModuleList = @ModuleList.uniq
    end

    def make_gate(gate_name)
      @GateList["#{gate_name}"] = nil
    end

    def make_connect(wire_base)
      wire_base.each{|wire,value|
        source = nil
        destination = Array.new
        if @InputPort["#{wire}"] != nil
          sig = SignalInf.new
          sig.Category = "IN"
          sig.SignalName = wire
          source = sig
        end
        if @OutputPort["#{wire}"] != nil
          sig = SignalInf.new
          sig.Category = "OUT"
          sig.SignalName = wire
          destination << sig
        end          
        if @InoutPort["#{wire}"] != nil
          sig = SignalInf.new
          sig.Category = "INOUT"
          sig.SignalName = wire
          source = sig
        end
        # Input to Instance
        value[0].each{|list|
          sig = SignalInf.new
          sig.Category = "INST"
          sig.InstName = list[0]
          sig.ModuleName = list[1]
          sig.SignalName = list[2]
          destination << sig
        }
        # Output for Instance
        value[1].each{|list|
          sig = SignalInf.new
          sig.Category = "INST"
          sig.InstName = list[0]
          sig.ModuleName = list[1]
          sig.SignalName = list[2]
          source = sig
        }
        # Inout for Instance
        value[2].each{|list|
          sig = SignalInf.new
          sig.Category = "INST"
          sig.InstName = list[0]
          sig.ModuleName = list[1]
          sig.SignalName = list[2]
          source = sig
        }
        connect = Connect.new
        connect.Source = source
        connect.Destination = destination
        @ConnectInf << connect
      }
      @ConnectInf = @ConnectInf.compact
    end

    #
    # Signal
    #
    class Port
      attr_accessor :PortName
      attr_accessor :MSB
      attr_accessor :LSB
      attr_accessor :BitWidth
      def initialize
        @PortName = nil
        @MSB = 0
        @LSB = 0
        @BitWidth = @MSB - @LSB
      end
    end

    #
    # Insance
    #   {InstanceName => @ModuleName, @ConnectionList:{SignalName=>[WriteName]}}
    #
    class Instance
      attr_accessor :ModuleName
      attr_accessor :ConnectionList
      def initialize
        @ModuleName = nil
        @ConnectionList = Hash.new  # {SignalName => [WireName]}
      end
    end

    #
    # Connect
    #   Save each the detail of Connect Information based on In/Out/Inout/Wire
    #
    class Connect
      # Signal source, only one
      attr_accessor :Source
      # Signal destination, sometimes many
      attr_accessor :Destination
      def initialize
        @Source = nil
        @Destination = Array.new
      end
    end

    class SignalInf
      # IN/OUT/INPUT/INST
      attr_accessor :Category
      # IN/OUT/INPUT : Port, INST : Signal
      attr_accessor :SignalName
      # only when Category == "INST"
      attr_accessor :ModuleName
      # only when Category == "INST"      
      attr_accessor :InstName
      def initialize
        @Category = nil
        @SignalName = nil
        @ModuleName = nil
        @InstName = nil
      end
    end

  end
    
  # ----------------------------------------------------------------------------
  # Conf Class
  # ----------------------------------------------------------------------------
  class Conf

    # Default data
    DEFAULT_INS_ATTRIBUTE = "KeepKeep"
    BASE_PATH = "/home/product/div-micom-ice/data/proj/78K0R"
    ICE_MACRO_VER = "XX # You have to set ICE Macro Version name here"
    PRODUCT_NAME = "verX.Y.Z # You have to set Product name here"
    COMMON_REPLACE_MACRO_PATH = "/Common/ReplaceMacro/current"
    PRODUCT_REPLACE_MACRO_PATH = "/Product/${PRODUCT_NAME}/ReplaceMacro"
    ICE_MACRO_PATH = "/Common/ICEMacro/tags/${ICE_MACRO_VER}"
    MKPIN_PATH = "/Product/${PRODUCT_NAME}/MkPin"

    def initialize(dir,file)
      # output directory
      @dir = dir
      @file = file
    end
    
    def generate
      file_name = @dir + "/mkice.conf" 
      printf("@I:generate %s\n",file_name)
      f = open("#{file_name}","w")
      comment = "mkice Configuration file" 
      Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
      f.print <<EOB
# ***************************************************************
# !! NOTES !!
# This file is the template file for mkice configuration mode.
# You HAVE TO EDIT following setting information before you run mkice.
# 
# After you edit this file, plese run mkice on configuration mode.
# %ruby mkice.rb --config mkice.conf
# ***************************************************************

EOB
      #----------------------
      # Module Information
      #----------------------
      f.print <<EOB
#
# Generating Module Information
#

EOB
      $CircuitInf.Module.each{|module_name,module_inf|
        f.printf("VERILOG_HDL: %s\n",@file)
        f.printf("MODULE_NAME: %s\n",module_name)
        f.printf("\n")
      }
      #----------------------
      # Path Information
      #----------------------
      f.print <<EOB
#
# Path Information
#  * After the followint variable setting, you can use these string
#    as a shell variable
#    ex ) ${COMMON_REPLACE_MACRO}/QLKXX.v
#

# Base Path
SET: BASE_PATH  #{BASE_PATH}

# Product Name
SET: PRODUCT_NAME #{PRODUCT_NAME}

# ICE Macro Vertion
SET: ICE_MACRO_VER #{ICE_MACRO_VER}

# VERILOG and Connect File Path(absolute path) can be used in common accross all products
SET: COMMON_REPLACE_MACRO #{COMMON_REPLACE_MACRO_PATH}

# VERILOG and Connect File Path(absolute path) can be used in one product
SET: PRODUCT_REPLACE_MACRO #{PRODUCT_REPLACE_MACRO_PATH}

# ICE Macro Path(absolute path)
SET: ICE_MACRO #{ICE_MACRO_PATH}

# MKPIN Result directory path ( save *.v *.sdc *.ucf )
SET: MKPIN_RESULT #{MKPIN_PATH}


EOB
      #----------------------
      # Instance Information
      #----------------------
        f.print <<EOB
#
# Instance Information
#
# Form   - 
# -----------------------------------------------
#  INS: [InstanceName] [ModuleName] TYPE [Attribute]
#   [Sub-Attribute]
#  END_INS:
# -----------------------------------------------
#
#  Attribute
#   * KeepKeep   : Keep Macro, Keep Connection (default)
#   * KeepChange : Keep Macro, Change Connection
#   * Replace    : Replace Macro
#   * Add        : Add Macro
#   * Remove     : Remove Macro
#
#  Sub-Attribute
#   * MODULE_NAME: [Macro Module Name]  : on Replace/Add if using differenet Macro Name
#   * VERILOG_HDL: [Macro FileName]     : on Replace/Add
#   * CONNECT_FILE: [Connect FileName] : on KeepChange/Replace/Add
#
# ----
# Example
# INS: h_rosc QAHIOS0BN32MV2 TYPE Replace
#  MODULE_NAME: QAHIOS0BN32MV2_ICE
#  VERILOG_HDL: ${COMMON_REPLACE_MACRO}/QAHIOS0BN32MV2_ICE.v
#  CONNECT_FILE: ${COMMON_REPLACE_MACRO}/QAHIOS0BN32MV2_ICE.con
# END_INS:
# 

EOB
      $CircuitInf.Module.each{|module_name,module_inf|
        module_inf.InstanceList.sort_by{|key,value|
          value.ModuleName
        }.each{|inst_name,value|
          # Print Instance Name
          case value.ModuleName
          when "TBCLL", "TBCLH"
            # not generate in conf file
          else
            f.printf("INS:    %-20s %-20s TYPE %10s\n",inst_name, value.ModuleName,DEFAULT_INS_ATTRIBUTE)
            $CircuitInf.ModuleHDL["#{value.ModuleName}"].each{|list|
              f.printf("  VERILOG_HDL: %s\n",list)
            } if $CircuitInf.ModuleHDL["#{value.ModuleName}"] != nil
            f.printf("END_INS:\n\n")
          end
        }
      }
      
      #----------------------
      # Port Information
      #----------------------
      f.print <<EOB
#
# Port Information
#
# ----
# Example
# PORT: port_iobuf PORT TYPE Replace
#  HIER_PATH: chip/portxx
#  MODULE_NAME: port_iobuf
#  VERILOG_HDL: ${PRODUCT_REPLACE_MACRO}/port.v
#  CONNECT_FILE: ${PRODUCT_REPLACE_MACRO}/port.con
# PORT_PORT:
#

EOB
      
      #----------------------
      # Pin Information
      #----------------------
      f.print <<EOB
#
# Pin Information
#
# ----
# Example
# PIN: 
#  VERILOG_FILE: ${MKPIN_RESULT}/pin.v
# PIN_END:
#

EOB
      # Instance Information
      f.close
    end
  end

end
