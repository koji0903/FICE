#!/usr/bin/ruby
#############################################################
#
# ConnectChecker
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 Renesas Micro Systems Co.,Ltd. All rights reserved.
#
#############################################################
#
# [Function]
# - Descripton of this tool
#
# [Usage]
# -%ruby ConnectChecker.rb -expect [EptFile] -device [Report] -ice [Report]
# If you want to get more information. plese use "-h" option.
#
# [EXAMPLE]
# -example
#
# [Output]
# -filename
#
# [History]
# -history
#
#############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib") # add lib path
require "FICE_def"
require "system"
require "common"
require "report"

#
# Global Setting
#
$COMMAND         = ""
$SUB_TOOL        = "ConnectChecker" # Tool Name
$VERBOSE         = false   # Verbose Mode

$INTERNAL_ERROR_CNT  = 0   # Internal Error Count for Tool Bug
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary

$MESSAGE         = false


$Socket_flag = false
$Socket_org_signal = nil

$LimitedCompare = Array.new

#
# Main Class
#
class ConnectChecker
  def initialize(expect=nil,device=nil,ice=Array.new,product=nil)
    # "-expect"
    @Expect = expect
    @ExpectData = Array.new
    @ExpectInf = Hash.new  # {inst_name,[pin data]}
    @ModuleInf = Hash.new  # {inst_name,module_name}
    # "-device"
    @Rep_DEV = device
    @RepData_DEV = Array.new
    # "-ice"
    @Rep_ICE = ice
    @Rep_FileList = Array.new
    @RepData_ICE = Array.new
    # "Product.expect" Data
    @ProductExpectData = product
    # Secret
    @Golden = false
    
    # ICE Report File Hier Information
    @ICEHier = Hash.new

    # For Compare {file_name,{InstName,{InstPinName,ConnectInfo}}}
    @DEV_ReportData = Hash.new
    @ICE_ReportData = Hash.new

    @ORG_DIRECTION = nil
    @ORG_SIGNAL = nil
    @ExpectedInSignal = Array.new
    @ExpectedOutSignal = Array.new

    @UnusedExpectedConnection = nil

    @LowestModuleName = nil

    # For Output report
    @ERROR_LIST = Array.new

    @ICEDeletedInst = Hash.new
    @DeletedList = Hash.new
    @ModifiedList = Hash.new
    @ExpectedList = Hash.new
    @ICEOnlyList = Hash.new

    @DeviceInstList = Hash.new
    @ICEInstList = Hash.new

    @Target = nil
    @ICEOnlySignal = Hash.new

    @ICEOnlyPortList = Hash.new
    @DeviceOnlyPortList = Hash.new


    @OperationFlag = true

    # UnChecked Infomation
    @UnChecked = Hash.new

    # for searching socket
    @SOCKET_SIGNAL = nil
  end

  #
  # HierClass for Hierarchy Search
  #
  class Hier
    attr_accessor :ModuleName
    attr_accessor :FullPath
    attr_accessor :Upper
    attr_accessor :Lower
    attr_accessor :LowestFlag
    def initialize
      @ModuleName = nil
      @FullPath = nil
      @Upper = nil
      @Lower = Array.new
      @LowestFlag = true # change false in hier operation
    end
  end

  #
  # ConnectInfo
  #
  class ConnectInfo
    attr_accessor :Type
    attr_accessor :Source
    attr_accessor :Dest
    attr_accessor :Direction
    attr_accessor :DeviceSignal
    attr_accessor :ICEOnlyFlag
    def initialize
      @Type   = nil
      @Source = nil
      @Dest   = nil
      @Direction = nil
      @DeviceSignal = nil
      @ICEOnlyFlag = false
    end
  end

  class DefinedConnection
    attr_accessor :Flag
    attr_accessor :ExpectFile
    attr_accessor :No
    attr_accessor :Line
    def initialize(file,no,line)
      @Flag = false
      @ExpectFile = file
      @No = no
      @Line = line
    end
  end

  #
  # Expected Signal List
  #
  class SignalList
    attr_accessor :Modified
    attr_accessor :Removed
    attr_accessor :ModifiedPull
    attr_accessor :ModifiedOther
    def initialize
      @Modified = Hash.new
      @Removed = Hash.new
      @ModifiedPull = Hash.new
      @ModifiedOther = Hash.new
    end
    def add_m(a,b,expect_file,line_num,line)
      defined_connection = DefinedConnection.new(expect_file,line_num,line)
      if @Modified["#{a}"] != nil
        tmp = Array.new
        tmp = @Modified["#{a}"]
        tmp.each{|b_already|
          expect_already_defined(expect_file,line_num,line) if b.to_s == b_already.to_s
        }
        tmp << [b,defined_connection]
        @Modified["#{a}"] = tmp
      else
        tmp = Array.new
        tmp << [b,defined_connection]
        @Modified["#{a}"] = tmp
      end
    end    
    def add_mp(a,b,expect_file,line_num,line)
      defined_connection = DefinedConnection.new(expect_file,line_num,line)
      if /pull/ =~ b
        if @ModifiedPull["#{a}"] != nil
          tmp = Array.new
          tmp = @ModifiedPull["#{a}"]
          tmp.each{|b_already|
            expect_already_defined(expect_file,line_num,line) if b.to_s == b_already.to_s
          }
          tmp << [b,defined_connection]
          @ModifiedPull["#{a}"] = tmp
        else
          tmp = Array.new
          tmp << [b,defined_connection]
          @ModifiedPull["#{a}"] = tmp
        end          
      elsif b == "opennet" || /_PIN/ =~ b
        if @ModifiedOther["#{a}"] != nil
          tmp = Array.new
          tmp = @ModifiedOther["#{a}"]
          tmp.each{|b_already|
            expect_already_defined(expect_file,line_num,line) if b.to_s == b_already.to_s
          }
          tmp << [b,defined_connection]
          @ModifiedOther["#{a}"] = tmp
        else
          tmp = Array.new
          tmp << [b,defined_connection]
          @ModifiedOther["#{a}"] = tmp
        end
      else
        p line
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit        
      end
    end

    def expect_already_defined(expect_file,line_num,line)
      $WARNING_CNT += 1
      printf("@W:Found already expected connection\n")
      printf("   [%s:%d] %s\n",expect_file,line_num,line)
    end

  end
  
  #
  # Print Base Information( Tool name, Version, Copyright )
  #
  private
  def print_base
    printf("%s(%s) ver:%s\n",$TOOL,$SUB_TOOL,$VERSION)
    printf("Copyright (c) 2009,2010 Renesas Micro Systems Co.,Ltd. All rights reserved.\n\n")
  end

  #
  # Print Tool Usage
  #
  private
  def print_usage
    printf("\n")
    printf("Usage :  %s.rb -expect [ExpectFile] -device [Report File] -ice [Report File]\n",$SUB_TOOL)
    printf(" OPTION\n")
    printf("\t-h/-help         : print help message\n")
    printf("\t-v/-version      : print version\n")
    printf("\t-verbose         : execute on verbose mode\n")
    printf("\t-expect          : expect file\n")
    printf("\t-device          : make_chip report file for device\n")
    printf("\t-ice             : make_chip report fiel for ICE\n")
    printf("    \n")
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  private
  def get_argument

    ice_flag = false
    size = ARGV.size
    # make cmd
    $COMMAND = "ruby " + __FILE__ + " "
    i = 0
    while i < size
      cmd = ARGV[i] + " "
      $COMMAND.concat("#{cmd}")
      i += 1
    end
    i = 0
    while i < size
      case ARGV[i]
      when '-h','-help' then
        print_usage
        exit
      when '-v','-version' then
        printf("")
        exit
      when '-verbose' then
        ice_flag = false
        $VERBOSE = true
      when '-device' then
        ice_flag = false
        @Rep_DEV << ARGV[i+1].split(",")
        i += 1
      when '-ice' then
        ice_flag = true
        @Rep_ICE << ARGV[i+1] # for multiple file
        i += 1
      when '-expect' then
        ice_flag = false
        @Expect = ARGV[i+1]
        i += 1
      when '-golden' then
        @Golden = true
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        else
          @Rep_ICE << ARGV[i] if ice_flag
        end
      end
      i += 1
    end 
    
    # Error Check
    if Common.chk_file("-expect",@Expect) == 1
      print_usage
      Common.print_summary
      exit
    end

    if Common.chk_file("-device",@Rep_DEV) == 1
      print_usage
      Common.print_summary
      exit
    end

  end

  def make_FileList
    @Rep_ICE.each{|rep_ice|
      if rep_ice != nil
        hier = rep_ice.split(":") 
        @Rep_FileList << hier[0]
      else
        $ERROR_CNT += 1
        printf("@E:Need specify ice-file after \"-ice\" option")
        Common.print_summary
        exit
      end
    } 
    @Rep_FileList.each{|file|
      if Common.chk_file("-ice",file) == 1
        print_usage
        Common.print_summary
        exit
      end
    }
  end
  
  #
  # Get ICE Hier
  #  - Get Hierachy information from "-ice" option
  def get_ice_hier
    printf("Make Hierarchy Information from \"-ice\" option\n")
    @Rep_ICE.each{|rep_ice|
      i = 0
      file = rep_ice.split(":")
      if @ICEHier["#{file[0]}"] == nil
        hier_info = file[1].split(",")
        case hier_info.size
        when 1 # Top
          hier = Hier.new
          hier.ModuleName = hier_info[0]
          @ICEHier["#{file[0]}"] = hier
        when 2 # Child module
          hier = Hier.new
          hier.Upper = hier_info[0]
          hier.ModuleName = hier_info[1]
          @ICEHier["#{file[0]}"] = hier
        end
      else
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
      end
    }

    # combination & and upper name from module name to file name
    @ICEHier.each{|key,value|
      @ICEHier.each{|key2,value2|
        if value.ModuleName == value2.Upper
          tmp = value.Lower
          tmp << key2
          value.Lower = tmp
          value2.Upper = key
          @ICEHier["#{key}"].LowestFlag = false
        end
      }
    }

    # make full-path Information
    @ICEHier.each{|key,value|
      path_name = value.ModuleName
      tmp = @ICEHier["#{value.Upper}"]
      while tmp != nil
        path_name = tmp.ModuleName + "." + path_name
        tmp = @ICEHier["#{tmp.Upper}"]
      end
      value.FullPath = path_name
    }

    # get Lowest Module
    @ICEHier.each_value{|value|
      @LowestModuleName = value.ModuleName if value.LowestFlag
    }

   
end

  private
  def make_pull(str)
    if /pullup/ =~ str
      return "pullup"
    elsif /pulldown/ =~ str
      return "pulldown"
    end
  end

  #
  # Get Expect Data
  #
  private
  def get_expect
    if @ProductExpectData == nil
      printf("Get Expect Data\n")
      # Expect File Read
      @ProductExpectData = Common.file_read(@Expect)
    end
    # operation
    name = nil
    scope = "NONE"
    line_num = 1
    signal = SignalList.new # for Modified Signal
    @ProductExpectData.each{|line|
      line = line.strip
      if line == "" || line[0] == 35 # Skip escape and comment line
        line_num += 1
        next
      end
      line = Common.remove_after(line,"#")
      info = line.split(":")
      case info[0]
      when "I" # Instance
        if scope == "NONE"
          signal = SignalList.new # for Modified Signal
          if info[1] == nil
            $ERROR_CNT += 1
            printf("@E: Found unexpected format line.([num:%s]%s). please check it.\n",line_num,line)
            Common.print_summary
            exit
          else
            name = info[1].split
            if name.size > 2
              $ERROR_CNT += 1
              printf("@E:Found unexpeted format on \"I\" line[(file:%s,line:%d)%s]\n",@Expect,line_num,line)
              Common.print_summary
              exit
            end
          end
          @ExpectInf["#{name[0]}"] = nil
          @ModuleInf["#{name[0]}"] = name[1]
          scope = "I"
        else
          $ERROR_CNT += 1
          printf("@E:Found \"I\" line in unexpected scope[(file:%s,line:%d)%s]\n",@Expect,line_num,line)
          Common.print_summary
          exit
        end
      when "M" # Modified Signal
        if scope == "I"
          if info[1] == nil
            $ERROR_CNT += 1
            printf("@E: Found unexpected format line.([num:%s]%s). please check it.\n",line_num,line)
            Common.print_summary
            exit
          else
            tmp = info[1].split
            if tmp.size != 3
              $ERROR_CNT += 1
              printf("@E:Found unexpeted format on \"M\" line[(file:%s,line:%d)%s]\n",@Expect,line_num,line)
              Common.print_summary
              exit
            end
          end
          if tmp[1] == "->"
            if /pull/ =~ tmp[0] || /opennet/ =~ tmp[2] || /_PIN/ =~ tmp[2]
              signal.add_mp(tmp[0],tmp[2],@Expect,line_num,line)
            else
              signal.add_m(tmp[0],tmp[2],@Expect,line_num,line)
            end
          elsif tmp[1] == "<-"
            if /pull/ =~ tmp[2] 
              signal.add_mp(tmp[0],tmp[2],@Expect,line_num,line)
            elsif /opennet/ =~ tmp[2] || /_PIN/ =~ tmp[2]
              signal.add_mp(tmp[0],tmp[2],@Expect,line_num,line)
            else
              signal.add_m(tmp[0],tmp[2],@Expect,line_num,line)
            end
          elsif tmp[1] == nil && tmp[2] == nil
            signal.add_m(tmp[0],"",@Expect,line_num,line)
          else
            $ERROR_CNT += 1
            printf("@E:Found unexpeted format on \"M\" line[(file:%s,line:%d)%s]\n",@Expect,line_num,line)
            Common.print_summary
            exit
          end
        else
          $ERROR_CNT += 1
          printf("@E:Found \"I\" line in unexpected scope[(file:%s,line:%d)%s]\n",@Expect,line_num,line)
          Common.print_summary
          exit
        end
      when "E"
        if info[1] != nil
          $ERROR_CNT += 1
          printf("@E:Found unexpected format[(file:%s,line:%d)%s]\n",@Expect,line_num,line)
          Common.print_summary
          exit
        end
        if scope == "I"
          @ExpectInf["#{name[0]}"] = signal
          scope = "NONE"
        else
          $ERROR_CNT += 1
          printf("@E:Found \"I\" line in unexpected scope[(file:%s,line:%d)%s]\n",@Expect,line_num,line)
          Common.print_summary
          exit
        end
      else
        $ERROR_CNT += 1
        printf("@E: Cannot recognize a line of Expect file. please check it.\n")
        printf("    [%s:%d] : %s\n",@Expect,line_num,line)
        Common.print_summary
        exit
      end
      line_num += 1
    }
  end


  #
  # get_report_data
  #
  private
  def get_report_data
    dev_inf = Hash.new
    ice_inf = Hash.new
    printf("Get Report Data\n")
    tmp = Array.new
    inst_list = Array.new
    @Rep_DEV.each{|dev_file|
      tmp = Array.new
      inst_list = Array.new
      printf("\t%s\n",dev_file)
      tmp[0],tmp[1],inst_list = get_connect_inf(dev_file)
      @DEV_ReportData["#{dev_file}"] = tmp
      inst_list.each{|inst|
        @DeviceInstList["#{inst}"] = nil
      }
    }

    @Rep_FileList.each{|ice_file|
      next if @ICE_ReportData["#{ice_file}"] != nil
      tmp = Array.new
      inst_list = Array.new
      inst_list = Array.new
      tmp[0],tmp[1], inst_list = get_connect_inf(ice_file)
      inst_list.each{|inst|
        @ICEInstList["#{inst}"] = nil
      }      
      @ICE_ReportData["#{ice_file}"] = tmp
    }
    printf("\n")
  end

  #
  # Get Connect Information about Instance
  #  Param[1] : report file
  #  Param[2] : instance name
  #  return   : Connect Information
  private
  def get_connect_inf(file)
    rep = Report.new(file,"all")
    rep.relation
    return rep.ConnectRelation, rep.NetNameList, rep.InstList
  end


  #
  # Compare
  #
  def compare
    printf("Analize each connection path\n")
    # For ReportFile
    #    file_name = "connection.report" 
    result_dir = "result"
    Common.make_dir("#{result_dir}")
    file_name = result_dir + "/connection_" + File.basename("#{@Expect}",".expect") + ".report" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Connection Detail" 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##",$COMMAND)
    
    # Scope to Device
    @ExpectInf.each{|inst_name,signal|
      unchecked_flag = false
      ice_deleted_flag = true
      printf("\tcomparing %-20s ... ",inst_name)
      f.printf("##################################################\n")
      f.printf("# %s\n",inst_name)
      f.printf("##################################################\n")
      f.printf("\n")
      f.printf("#\n")
      f.printf("# Search Device Signal for %s\n",inst_name)
      f.printf("#\n")
      device = Hash.new
      @Rep_DEV.each{|dev_file|
        connect_inf =  GetReportInf.get_inst_inf(inst_name,@DEV_ReportData["#{dev_file}"][0]) 
        if connect_inf.size != 0
          if device.size == 0
            device = connect_inf
          else
            # Socket and Plug use same instance name. Now, this type is Limited Function.
            # Output "UnChecked" Module about this module 
            @UnChecked["#{inst_name}"] = nil
            device.clear
            unchecked_flag = true
            printf(" UnChecked(Found Multiple same name instances)\n")
            $WARNING_CNT += 1
            printf("@W: Not support analyzing connection-path for multiple same name instances.\n")
            f.printf("\n/")
          end
        end
      }
      next if unchecked_flag == true # Limit
      device.each{|inst_pin_name,dev_connect_inf|
        f.printf("-----------------------------------------------------\n")
        @OperationFlag = false
        f.printf("[DEV]%s:%s(%s)\n",inst_pin_name,dev_connect_inf.Direction,@Rep_DEV)
        connect_sig = nil
        @ExpectedInSignal.clear
        @ExpectedOutSignal.clear
        out_pin_flag = false
        dev_connect_inf.OUT.each{|out_sig|
          if out_sig != "OUT_PIN"
            f.printf("     <- [%s]\n",out_sig)
          else
            f.printf("     -> [%s]\n",out_sig)
            out_pin_flag = true
          end
          @ExpectedOutSignal << out_sig
        }
        dev_connect_inf.IN.each{|in_sig|
          if in_sig != "IN_PIN"
            f.printf("     -> [%s]\n",in_sig)
          else
            f.printf("     <- [%s]\n",in_sig) 
         end
          @ExpectedInSignal << in_sig
        }
        dev_connect_inf.INOUT.each{|inout_sig|
          f.printf("     <-> %s[I/O Port]\n",inout_sig)
          @ExpectedInSignal << inout_sig
          @ExpectedOutSignal << inout_sig
        }
        f.printf("     opennet\n") if out_pin_flag == false && dev_connect_inf.IN.size == 0 && dev_connect_inf.Direction == "OUT"
        search_ice(f,inst_pin_name,dev_connect_inf,inst_name)
        judge_operation(inst_pin_name,dev_connect_inf,1)
      } if device.size != 0
      

      # Scope to ICE
      f.printf("\n")
      f.printf("#\n")
      f.printf("# Search ICE Signal for %s\n",inst_name)
      f.printf("#\n")
      device = Hash.new
      @Rep_DEV.each{|dev_file|
        connect_inf =  GetReportInf.get_inst_inf(inst_name,@DEV_ReportData["#{dev_file}"][0]) 
        if connect_inf.size != 0
          if device.size == 0
            device = connect_inf
          else
            # Socket and Plug use same instance name. Now, this type is Limited Function.
            # Output "UnChecked" Module about this module 
            @UnChecked["#{inst_name}"] = nil
            device.clear
          end
        end
      }
      flag = false
      signal_cnt = 0
      @Rep_FileList.each{|ice_file|
        $Socket_flag = false
        @ICE_ReportData["#{ice_file}"][0].each{|inst_pin_name,ice_connect_inf|
          $Socket_flag = false
          if inst_pin_name.split(".")[0] == inst_name
            ice_deleted_flag = false
            # ICE-Only Pin
            if device.key?("#{inst_pin_name}") == false
              signal_cnt += 1
              flag = true
              f.printf("-----------------------------------------------------\n")
              @OperationFlag = false
              #### Socket ###############################################
              # SPECIAL OPERATION for "scokect" module
              ###########################################################
              # If "socket" instance, search lower hierarchy information.
              # and get lower connect information, comparete this signal.
              $Socket_flag = false
              $Socket_org_signal = nil
              if inst_name == "socket"
                $Socket_flag = true
                socket_pin_name = inst_pin_name.split(".")[1]
                socket_file_name =  @ICEHier["#{ice_file}"].Lower
                if socket_file_name == nil
                  $ERROR_CNT += 1
                  f.printf("@E: Cant get socket information about ICE Environment.")
                  exit
                end
                if @ICE_ReportData["#{socket_file_name}"] == nil
                  $Socket_flag = false
                  break
                end
                socket_name_list = @ICE_ReportData["#{socket_file_name}"][1]
                if socket_name_list == nil
                  $ERROR_CNT += 1
                  f.printf("@E: Cant get socket information about ICE Environment.")
                  exit
                end
                search_flag = false
                socket_name_list.each{|key,value|
                  if key == socket_pin_name
                    case ice_connect_inf.Direction
                    when "IN"
                      value.ConnectInfo.each{|data|
                        if data.InstPinName == "IN_PIN"
                          search_flag = true
                        else
                          $Socket_org_signal = data.InstPinName if data.Direction == "IN" || data.Direction == "I/O"
                        end
                      }
                    when "OUT"
                      value.ConnectInfo.each{|data|
                        if data.InstPinName == "OUT_PIN"
                          search_flag = true 
                        else
                          $Socket_org_signal = data.InstPinName if data.Direction == "OUT" || data.Direction == "I/O"
                        end
                      }
                    when "I/O"
                      value.ConnectInfo.each{|data|
                        if data.InstPinName == "IO_PIN"
                          search_flag = true 
                        else
                          $Socket_org_signal = data.InstPinName 
                        end
                      }
                    else
                      $ERROR_CNT += 1
                      f.printf("internale error(%s[%d])\n",__FILE__,__LINE__)
                      exit
                    end
                    if search_flag == false
                      $ERROR_CNT += 1
                      f.printf("internale error(%s[%d])\n",__FILE__,__LINE__)
                      exit                      
                    end
                  end
                }
              else
                tmp = Array.new
                tmp = @ICEOnlyPortList["#{inst_pin_name.split(".")[0]}"] if @ICEOnlyPortList["#{inst_pin_name.split(".")[0]}"] != nil 
                tmp << inst_pin_name.split(".")[1] if inst_pin_name.split(".")[1] != nil
                @ICEOnlyPortList["#{inst_pin_name.split(".")[0]}"] = tmp
              end
              ###########################################################
              f.printf("[ICE_001]%s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,inst_pin_name,ice_connect_inf.Direction,ice_file)
              f.printf("\n")
              if $Socket_flag == true 
                f.printf("     Lower connect signal:%s\n",$Socket_org_signal)
                f.printf("\nSearch device conection.\n")
                # Search Device Connect
                dev_inst_name = $Socket_org_signal.split(".")[0]
                device = Hash.new
                @Rep_DEV.each{|dev_file|
                  connect_inf =  GetReportInf.get_inst_inf(dev_inst_name,@DEV_ReportData["#{dev_file}"][0]) 
                  if connect_inf.size != 0
                    if device.size == 0
                      device = connect_inf
                    end
                  end
                }
                next if unchecked_flag == true # Limit
                device.each{|dev_inst_pin_name,dev_connect_inf|
                  if dev_inst_pin_name == $Socket_org_signal
                    @OperationFlag = false
                    f.printf("[DEV]%s:%s(%s)\n",dev_inst_pin_name,dev_connect_inf.Direction,@Rep_DEV)
                    connect_sig = nil
                    @ExpectedInSignal.clear
                    @ExpectedOutSignal.clear
                    dev_connect_inf.OUT.each{|out_sig|
                      if out_sig != "OUT_PIN"
                        f.printf("     <- [%s]\n",out_sig)
                      else
                        f.printf("     -> [%s]\n",out_sig)
                      end
                      @ExpectedOutSignal << out_sig
                    }
                    dev_connect_inf.IN.each{|in_sig|
                      if in_sig != "IN_PIN"
                        f.printf("     -> [%s]\n",in_sig)
                      else
                        f.printf("    < - [%s]\n",in_sig)
                      end
                      @ExpectedInSignal << in_sig
                    }
                    dev_connect_inf.INOUT.each{|inout_sig|
                      f.printf("     <-> %s[I/O Port]\n",inout_sig)
                    }
                    f.printf("     opennet\n") if dev_connect_inf.IN.size == 0 && dev_connect_inf.Direction == "OUT"
                    #                  search_ice(f,inst_pin_name,dev_connect_inf)
                    #                  judge_operation(inst_pin_name,dev_connect_inf,1)
                  end
                } if device.size != 0
              end
              f.printf("     * Search ICE Connection(ICE-Only Pin) *\n")
              f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,inst_pin_name,ice_connect_inf.Direction,ice_file)
              @ORG_DIRECTION = ice_connect_inf.Direction 
              if $Socket_org_signal != nil
                @SOCKET_SIGNAL = @ICEHier["#{ice_file}"].FullPath + ".socket." + $Socket_org_signal 
              else
                @SOCKET_SIGNAL = nil
              end
              @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
              @TARGET = "ICE"
              
              case ice_connect_inf.Direction
              when "IN"
                if ice_connect_inf.OUT.size == 1 && /pull/ =~ ice_connect_inf.OUT.to_s 
                  # pulldown/pullup
                  f.printf("     *pullup/pulldown*\n")
                  f.printf("     @N:Cannot get more connect information\n\n")
                  f.printf("     Final Connection:%s\n",ice_connect_inf.OUT.to_s)
                  f.printf("\n")
                  f.printf("     000:Searching in Expect File(%s) ... ",@Expect)
                  @ORG_DIRECTION = "IN"
                  @TARGET = "ICE"
                  f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
                  search_expect_file(f,ice_connect_inf.OUT.to_s,2)
                else
                  f.printf("\tSearching other module...\n") if $VERBOSE
                  # Other Module
                  hier_flag = false
                  ice_connect_inf.IN.each{|signal|
                    if /IN_PIN/ =~ signal
                      hier_flag = true
                    end
                  }
                  if hier_flag == true
                    f.printf("search to upper\n") if $VERBOSE
                    f.printf("001-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
                    search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,ice_connect_inf)
                  end
                  lower_module_name = nil
                  net_name = nil
                  if @ICEHier["#{ice_file}"].Lower.size != 0
                    lower_module_name = @ICEHier["#{@ICEHier["#{ice_file}"].Lower}"].ModuleName
                  end
                  ice_connect_inf.OUT.each{|signal|
                    if signal.split(".")[0] == lower_module_name
                      net_name = signal.split(".")[1]
                    end
                  }
                  if net_name != nil
                    f.printf("search to lower\n") if $VERBOSE
                    f.printf("002-search_connection_from_net - net_name : %s\n",net_name) if $VERBOSE
                    search_connection_from_net(f,"lower",ice_file,net_name,ice_connect_inf)
                  end
                  ice_connect_inf.OUT.each{|signal|
                    next if signal =~ /OUT_PIN/
                    if @ICEHier["#{ice_file}"].Lower != nil
                      file = @ICEHier["#{ice_file}"].Lower
                      if @ICEHier["#{file}"] != nil
                        next if /#{@ICEHier["#{file}"].ModuleName}/ =~ signal
                      end
                    end
                    f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
                    f.printf("\n")
                    f.printf("     001:Searching in Expect File(%s) ... ",@Expect)
                    other_connect = @ICEHier["#{ice_file}"].FullPath + "." + signal
                    f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
                    search_expect_file(f,other_connect,0)
                  }
                end
              when "OUT"
                if ice_connect_inf.OUT.size == 0 && ice_connect_inf.IN.size == 0
                  # opennet
                  f.printf("     opennet\n")
                  f.printf("     @M:006-Cannot get more connect information\n\n")
                  f.printf("     Final Connection:%s\n","opennet")
                  f.printf("\n")
                  f.printf("     002:Searching in Expect File(%s) ... ",@Expect)
                  @ORG_DIRECTION = "OUT"
                  @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
                  @TARGET = "ICE"
                  f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
                  search_expect_file(f,"opennet",2)
                else
                  # Other Module
                  f.printf("\tSearching other module...\n") if $VERBOSE
                  hier_flag = false
                  ice_connect_inf.OUT.each{|signal|
                    if /OUT_PIN/ =~ signal
                      hier_flag = true
                    end
                  }
                  if hier_flag == true
                    f.printf("search to upper\n") if $VERBOSE
                    f.printf("003-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
                    search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,ice_connect_inf)
                  end
                  lower_module_name = nil
                  net_name = nil
                  if @ICEHier["#{ice_file}"].Lower.size != 0
                    lower_module_name = @ICEHier["#{@ICEHier["#{ice_file}"].Lower}"].ModuleName
                    f.printf("Lower Module Name: %s\n",lower_module_name) if $VERBOSE
                  end
                  ice_connect_inf.IN.each{|signal|
                    if signal.split(".")[0] == lower_module_name
                      net_name = signal.split(".")[1]
                      f.printf("net_name: %s\n",net_name) if $VERBOSE
                    end
                  }
                  if net_name != nil
                    f.printf("search to lower\n") if $VERBOSE
                    f.printf("004-search_connection_from_net - net_name : %s\n",net_name) if $VERBOSE
                    search_connection_from_net(f,"lower",ice_file,net_name,ice_connect_inf)
                  end
                  ice_connect_inf.IN.each{|signal|
                    next if signal =~ /IN_PIN/
                    if @ICEHier["#{ice_file}"].Lower != nil
                      file = @ICEHier["#{ice_file}"].Lower
                      if @ICEHier["#{file}"] != nil
                        next if /#{@ICEHier["#{file}"].ModuleName}/ =~ signal
                      end
                    end
                    f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
                    f.printf("\n")
                    f.printf("     003:Searching in Expect File(%s) ... ",@Expect)
                    other_connect = @ICEHier["#{ice_file}"].FullPath + "." + signal
                    f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
                    search_expect_file(f,other_connect,0)
                  }
                end
              when "I/O"
                # Other Module
                f.printf("\tSearching other module...\n") if $VERBOSE
                hier_flag = false
                ice_connect_inf.OUT.each{|signal|
                  if /OUT_PIN/ =~ signal
                    hier_flag = true
                  end
                }
                ice_connect_inf.IN.each{|signal|
                  if /IN_PIN/ =~ signal
                    hier_flag = true
                  end
                }
                if hier_flag == true
                  f.printf("005-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
                  search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,ice_connect_inf)
                end
                
                f.printf("006-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
                search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,ice_connect_inf)
                lower_module_name = nil
                net_name = nil
                if @ICEHier["#{ice_file}"].Lower.size != 0
                  lower_module_name = @ICEHier["#{@ICEHier["#{ice_file}"].Lower}"].ModuleName
                end
                ice_connect_inf.OUT.each{|signal|
                  if signal.split(".")[0] == lower_module_name
                    net_name = signal.split(".")[1]
                  end
                }
                if net_name != nil
                  f.printf("007-search_connection_from_net - net_name : %s\n",net_name) if $VERBOSE
                  search_connection_from_net(f,"lower",ice_file,net_name,ice_connect_inf)
                end
              else
                printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
                exit            
              end
            end
          end
          judge_operation(inst_pin_name,ice_connect_inf,2)
        }
      }
      @ICEOnlySignal["#{inst_name}"] = signal_cnt
      if flag == false
        f.printf("\n")
        f.printf("\n@N: Not found ICE-only signal\n")
        f.printf("\n\n")
      end
      @ICEDeletedInst["#{inst_name}"] = inst_name if ice_deleted_flag
      printf(" done\n")
    }
    
    
    f.printf("\n")
    f.printf("end\n")
    f.close
  end

  #
  # search_ice
  #
  def search_ice(f,inst_pin_name,dev_connect_inf,inst_name)
    flag = false
    # Get Connect Information from ICE
    @Rep_FileList.each{|ice_file|
      # Search signal same as device each ICE report file
      if @ICE_ReportData["#{ice_file}"][0].key?("#{inst_pin_name}") 
        ice_connect_inf = @ICE_ReportData["#{ice_file}"][0]["#{inst_pin_name}"]
        # Skip
        if ice_connect_inf == nil 
          next
        end
        diff_flag = false
        if ( dev_connect_inf.Direction == ice_connect_inf.Direction ) || dev_connect_inf.Direction == "I/O"
          f.printf("\n")
          f.printf("[ICE_002]%s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,inst_pin_name,ice_connect_inf.Direction,ice_file)
          # same connection
          case ice_connect_inf.Direction
          when "IN"
            @ORG_DIRECTION = "IN"
            @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
            @TARGET = "Device"
            result = same_connection_for_IN(f,ice_file,dev_connect_inf,ice_connect_inf)
            if result
              flag = true
              next
            end
          when "OUT"   
            @ORG_DIRECTION = "OUT"
            @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
            @TARGET = "Device"
            result = same_connection_for_OUT(f,ice_file,dev_connect_inf,ice_connect_inf)
            if result
              flag = true
              next
            end
          when "I/O"
            @ORG_DIRECTION = "I/O"
            @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
            @TARGET = "Device"
            result = same_connection_for_INOUT(f,ice_file,dev_connect_inf,ice_connect_inf)
            if result
              flag = true
              next
            end
          else
            printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
            exit            
          end
          
          #
          # Different Connection
          #
          ice_connect_inf.OUT.each{|out_sig|
            if out_sig == "OUT_PIN"
              f.printf("     -> %s.[%s]\n",@ICEHier["#{ice_file}"].FullPath,out_sig)
            else
              f.printf("     <- %s.[%s]\n",@ICEHier["#{ice_file}"].FullPath,out_sig)
            end
          }
          ice_connect_inf.IN.each{|in_sig|
            if in_sig == "IN_PIN"
              f.printf("     <- %s.[%s]\n",@ICEHier["#{ice_file}"].FullPath,in_sig)
            else
              f.printf("     -> %s.[%s]\n",@ICEHier["#{ice_file}"].FullPath,in_sig)
            end  
          }
          ice_connect_inf.INOUT.each{|inout_sig|
            if inout_sig == "IO_PIN"
              f.printf("     <-> %s.[%s]\n",@ICEHier["#{ice_file}"].FullPath,inout_sig)
            elsif inout_sig == "OUT_PIN"
              f.printf("     -> %s.[%s]\n",@ICEHier["#{ice_file}"].FullPath,inout_sig)
            elsif inout_sig == "IN_PIN"
              f.printf("     <- %s.[%s]\n",@ICEHier["#{ice_file}"].FullPath,inout_sig)
            else
              f.printf("     <-> %s.[%s]\n",@ICEHier["#{ice_file}"].FullPath,inout_sig)
            end
          }
          f.printf("\n")

          f.printf("     * Search ICE Connection *\n")          
          case dev_connect_inf.Direction            
          when "IN"
            flag = different_connection_for_IN(f,ice_file,dev_connect_inf,ice_connect_inf,inst_pin_name)
          when "OUT"
            flag = different_connection_for_OUT(f,ice_file,dev_connect_inf,ice_connect_inf,inst_pin_name)
          when "I/O"
            flag = different_connection_for_IN(f,ice_file,dev_connect_inf,ice_connect_inf,inst_pin_name)
            flag = different_connection_for_OUT(f,ice_file,dev_connect_inf,ice_connect_inf,inst_pin_name)
          end
          flag = true
        elsif dev_connect_inf.Direction != ice_connect_inf.Direction 
          printf("\n")
          printf("@ConnectError: PortDirection Mismatch about \"%s.%s\" between Device Port and ICE Port.\nThis type was not supported in this version, So not-compare about this connction.\n",inst_name,ice_connect_inf.NetName)
          printf("\tDirection - Device : %s, ICE: %s\n",dev_connect_inf.Direction,ice_connect_inf.Direction)
          $LimitedCompare << inst_name + "." + dev_connect_inf.NetName
        else
          # !!CAUTION!! Maybe, Its illegal case The direction ICE and Device are different.
          if  (ice_connect_inf.OUT.size == 0 && (( /IN_PIN/ =~ ice_connect_inf.IN.to_s) == nil ))||
              (ice_connect_inf.IN.size == 0 && (( /OUT_PIN/ =~ ice_connect_inf.OUT.to_s) == nil ))
            f.printf("\n")
            f.printf("[ICE_003]%s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,inst_pin_name,ice_connect_inf.Direction,ice_file)
            f.printf("\n")
            f.printf("     opennet\n")
            f.printf("     @M:007-Cannot get more connect information\n\n")
            f.printf("     Final Connection:%s\n","opennet")
            f.printf("\n")
            f.printf("     004:Searching in Expect File(%s) ... ",@Expect)
            @ORG_DIRECTION = "OUT"
            @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
            @TARGET = "Device"
            f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
            search_expect_file(f,"opennet",2)
            flag = true
          else
            printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
            exit
          end          
        end
      end
    }
    
    if flag == false
      f.printf("@I: Not found %s in all report file in ICE\n", inst_pin_name)
      @OperationFlag = true
      err = ConnectInfo.new
      if dev_connect_inf.Direction == "OUT"
        err.Source = inst_pin_name
      elsif dev_connect_inf.Direction  == "IN"
        err.Dest   = inst_pin_name
      else
        err.Source = inst_pin_name
      end
      err.Direction = dev_connect_inf.Direction
      err.DeviceSignal = inst_pin_name
      err.Type= "None"
      @ERROR_LIST << err
      
      tmp = Array.new
      tmp = @DeviceOnlyPortList["#{inst_pin_name.split(".")[0]}"] if @DeviceOnlyPortList["#{inst_pin_name.split(".")[0]}"]!= nil    
      tmp << inst_pin_name.split(".")[1] if inst_pin_name.split(".")[1] != nil
      @DeviceOnlyPortList["#{inst_pin_name.split(".")[0]}"] = tmp      
    end
    f.printf("\n")
  end

  def same_connection_for_IN(f,ice_file,dev_connect_inf,ice_connect_inf)
    ice_connect_inf_tmp = ice_connect_inf.OUT - ["OUT_PIN"]
    dev_connect_inf.OUT = dev_connect_inf.OUT - ["OUT_PIN"]
    return false if ice_connect_inf_tmp.size == 0
    if ( dev_connect_inf.OUT == ice_connect_inf_tmp ) #|| ( ice_connect_inf.IN == dev_connect_inf.IN )
      ice_connect_inf.IN.each{|in_sig|
        if in_sig == "IN_PIN"
          f.printf("     <- %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,in_sig,ice_file)
        else
          f.printf("     -> %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,in_sig,ice_file)
        end
      }
      ice_connect_inf.OUT.each{|out_sig|
        if out_sig == "OUT_PIN"
          f.printf("     -> %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,out_sig,ice_file)
        else
          f.printf("     <- %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,out_sig,ice_file)
        end
      }
      f.printf("\n")
      @OperationFlag = true
      if ice_connect_inf_tmp.size != 0
        ice_connect_inf_tmp.each{|sig|
          f.printf("@I:Device and ICE Environment is same connection to ")      
          f.printf("%s ",sig)
          @ORG_DIRECTION = "IN"
          @TARGET = "Device"
          f.printf("\n")
          f.printf("     005:Searching in Expect File about %s(%s) ... ",@ORG_SIGNAL,@Expect)
          other_connect = @ICEHier["#{ice_file}"].FullPath + "." + sig
          f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
          search_expect_file(f,other_connect,2,1)
          f.printf("\n")
        }
      else
        ice_connect_inf.IN.each{|sig|
          if sig == "IN_PIN"
            f.printf("@I:Device and ICE Environment is same connection to ")
            f.printf("%s ",sig)
            @ORG_DIRECTION = "IN"
            @TARGET = "Device"
            f.printf("\n")
            f.printf("     006:Searching in Expect File about %s(%s) ... ",@ORG_SIGNAL,@Expect)
            other_connect = @ICEHier["#{ice_file}"].FullPath + "." + sig
            f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
            search_expect_file(f,other_connect,2,1)
            f.printf("\n")
          end
        }
      end
  
      f.printf("\n")
      flag = true
      return true
    end
  end
  
  def same_connection_for_OUT(f,ice_file,dev_connect_inf,ice_connect_inf)
    ice_connect_inf_tmp = ice_connect_inf.IN - ["IN_PIN"]
    if ((( dev_connect_inf.IN == ice_connect_inf.IN ) && !(dev_connect_inf.IN.size == 0 && dev_connect_inf.Direction == "OUT") && (dev_connect_inf.OUT == ice_connect_inf.OUT)))
 #|| ((dev_connect_inf.IN == ice_connect_inf.IN) && (dev_connect_inf.OUT == dev_connect_inf.OUT )))
      ice_connect_inf.IN.each{|in_sig|
        if in_sig == "IN_PIN"
          f.printf("     <- %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,in_sig,ice_file)
        else
          f.printf("     -> %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,in_sig,ice_file)
        end
      }
      ice_connect_inf.OUT.each{|out_sig|
        if out_sig == "OUT_PIN"
          f.printf("     -> %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,out_sig,ice_file)
        else
          f.printf("     <- %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,out_sig,ice_file)
        end
      }
      f.printf("\n")
      @OperationFlag = true
      if ((dev_connect_inf.IN == ice_connect_inf.IN) && (ice_connect_inf.OUT.index("OUT_PIN") != nil && dev_connect_inf.OUT.index("OUT_PIN") != nil))
        ice_connect_inf_tmp << "OUT_PIN"
      end
      ice_connect_inf_tmp.each{|sig|
        if sig != "OUT_PIN"
          f.printf("@I:Device and ICE Environment is same connection to ")
          f.printf("%s ",sig)
          @ORG_DIRECTION = "OUT"
          @TARGET = "Device"
          f.printf("\n")
          f.printf("     007:Searching in Expect File(%s) ... ",@Expect)
          f.printf("\n\tsearch_expect_file(line:%d) about %s\n",__LINE__,sig) if $VERBOSE
          search_expect_file(f,sig,2,2)        
          f.printf("\n")
        else
          # search other hierchy from net name
          f.printf("\n\t*ICE Connect Information*\n\n") if $VERBOSE
          f.printf("\tModuleName:%s, NetName:%s, type:%s\n",@ICEHier["#{ice_file}"].ModuleName,ice_connect_inf.NetName,sig) if $VERBOSE
          f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,sig,ice_connect_inf.Direction,ice_file)
          @ORG_DIRECTION = "OUT"
          @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + sig
          @TARGET = "Device"
          f.printf("012-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
          search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,dev_connect_inf)
        end
      }
      if dev_connect_inf.IN.size == 0 && ice_connect_inf.IN.size == 0 && ice_connect_inf.OUT.size == 0
        f.printf("     opennet\n\n")
        sig = "opennet"
        f.printf("@I:Device and ICE Environment is same connection to ")
        f.printf("%s ",sig)
        @ORG_DIRECTION = "OUT"
        @TARGET = "Device"
        f.printf("\n")
        f.printf("     008:Searching in Expect File(%s) ... ",@Expect)
        f.printf("\n\tsearch_expect_file(line:%d) about %s\n",__LINE__,sig) if $VERBOSE
        search_expect_file(f,sig,2,2)        
        f.printf("\n")
      end
      
      flag = true
      return true
    end
  end
  
  def same_connection_for_INOUT(f,ice_file,dev_connect_inf,ice_connect_inf)
    ice_connect_inf_tmp = ice_connect_inf.IN
    if ((( dev_connect_inf.INOUT == ice_connect_inf.INOUT ) && !(dev_connect_inf.INOUT.size == 0 && dev_connect_inf.Direction == "I/O")) ||
         (dev_connect_inf.OUT == ["OUT_PIN"] && ice_connect_inf.OUT == ["OUT_PIN"]))
      ice_connect_inf.IN.each{|in_sig|
        if in_sig == "IN_PIN"
          f.printf("     <- %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,in_sig,ice_file)
        else
          f.printf("     -> %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,in_sig,ice_file)
        end
      }
      ice_connect_inf.OUT.each{|out_sig|
        if out_sig == "OUT_PIN"
          f.printf("     -> %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,out_sig,ice_file)
        else
          f.printf("     <- %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,out_sig,ice_file)
        end
      }
      ice_connect_inf.INOUT.each{|inout_sig|
        if inout_sig == "OUT_PIN"
          f.printf("     -> %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,inout_sig,ice_file)
        elsif inout_sig == "IN_PIN"
          f.printf("     <- %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,inout_sig,ice_file)
        elsif inout_sig == "IO_PIN"
          f.printf("     <-> %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,inout_sig,ice_file)
        else
          f.printf("     <-> %s.[%s](%s)\n",@ICEHier["#{ice_file}"].FullPath,inout_sig,ice_file)
        end
      }
      f.printf("\n")
      @OperationFlag = true
      ice_connect_inf_tmp.each{|sig|
        f.printf("@I:Device and ICE Environment is same connection to ")
        f.printf("%s ",sig)
        @ORG_DIRECTION = "INOUT"
        @TARGET = "Device"
        f.printf("\n")
        f.printf("     009:Searching in Expect File(%s) ... ",@Expect)
        f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
        search_expect_file(f,sig,2,1)
        f.printf("\n")
      }
      f.printf("\n")
      flag = true
      return true
    end
  end

  def different_connection_for_IN(f,ice_file,dev_connect_inf,ice_connect_inf,inst_pin_name)
    flag = false
    dev_pull_flag = 0
    ice_pull_flag = 0
    pull_signal = ""

    (dev_connect_inf.OUT & ice_connect_inf.OUT).each{|signal|
      @ORG_DIRECTION = "IN"
      @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
      other_connect = @ICEHier["#{ice_file}"].FullPath + "." + signal
      @TARGET = "Device"
      f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
      f.printf("\n")
      f.printf("     010:Searching in Expect File(%s) ... ",@Expect)
      f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
      search_expect_file(f,other_connect,0,2)      
    }

    (dev_connect_inf.OUT-ice_connect_inf.OUT).each{|signal|
      dev_pull_flag += 1 if ( /pull/ =~ signal ) != nil
    }
    (ice_connect_inf.OUT-dev_connect_inf.OUT).each{|signal|
      # connect other hierarchy module
      if signal == "IN_PIN"
        f.printf("\n  [ice-only signal] -> %s\n",signal) if $VERBOSE
        f.printf("\n\t*ICE Connect Information*\n") if $VERBOSE
        f.printf("\tModuleName:%s, NetName:%s, type:%s\n",@ICEHier["#{ice_file}"].ModuleName,ice_connect_inf.NetName,signal) if $VERBOSE
        f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
        @ORG_DIRECTION = "OUT"
        @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
        @TARGET = "Device"
        f.printf("008-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
        search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,dev_connect_inf)
      else
        if ( /pull/ =~ signal ) != nil
          pull_signal = signal
          ice_pull_flag += 1
          @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
        else          
          if @ICEHier["#{@ICEHier["#{ice_file}"].Lower}"] != nil 
            if /#{@ICEHier["#{@ICEHier["#{ice_file}"].Lower}"].ModuleName}/ =~ signal
              @ORG_DIRECTION = "IN"
              @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
              @TARGET = "Device"
              f.printf("009-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
              search_connection_from_net(f,"lower",ice_file,ice_connect_inf.NetName,dev_connect_inf,signal)
            elsif signal == "IN_PIN"
              @ORG_DIRECTION = "IN"
              @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
              @TARGET = "Device"
              f.printf("010-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
              search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,dev_connect_inf,signal)
            elsif signal == "OUT_PIN"
              # SKIP              
            else
              @ORG_DIRECTION = "IN"
              @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
              other_connect = @ICEHier["#{ice_file}"].FullPath + "." + signal
              @TARGET = "Device"
              f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
              f.printf("\n")
              f.printf("     011:Searching in Expect File(%s) ... ",@Expect)
              f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
              search_expect_file(f,other_connect,0)
=begin
              $ERROR_CNT += 1
              printf("@E:Found unrecognized connection about %s\n",@ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name)
              printf("   please check it.")
              Common.print_summary
              exit
=end
#              @ORG_DIRECTION = "IN"
#              @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
#              other_connect = @ICEHier["#{ice_file}"].FullPath + "." + signal
#              @TARGET = "Device"
#              f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
#              f.printf("\n")
#              f.printf("     Searching in Expect File(%s) ... ",@Expect)
#              search_expect_file(f,other_connect,0)
            end
          else
            if signal != "IN_PIN" && signal != "OUT_PIN"
              @ORG_DIRECTION = "IN"
              @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
              other_connect = @ICEHier["#{ice_file}"].FullPath + "." + signal
              @TARGET = "Device"
              f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
              f.printf("\n")
              f.printf("     012:Searching in Expect File(%s) ... ",@Expect)
              f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
              search_expect_file(f,other_connect,0)
            end
          end
        end
      end
    }
    
    ice_connect_inf.IN.each{|signal|
      if signal == "IN_PIN"
        f.printf("\n  [ice-only signal] -> %s\n",signal) if $VERBOSE
        f.printf("\n\t*ICE Connect Information*\n") if $VERBOSE
        f.printf("\tModuleName:%s, NetName:%s, type:%s\n",@ICEHier["#{ice_file}"].ModuleName,ice_connect_inf.NetName,signal) if $VERBOSE
        f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
        @ORG_DIRECTION = "IN"
        @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
        @TARGET = "Device"
        f.printf("008-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
        search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,dev_connect_inf)
        ice_connect_inf.IN.delete("#{signal}")
      end
    }
    
    # check pull
    if dev_pull_flag != 0 && ice_pull_flag != 0 && ( dev_pull_flag == ice_pull_flag )
      f.printf("\n")
      @OperationFlag = true
      f.printf("@I:Device and ICE Environment is same connection(pulldown/pullup)\n")
      flag = true
      @ORG_DIRECTION = "IN"
      @TARGET = "Device"
      f.printf("\n")
      f.printf("     013:Searching in Expect File(%s) ... ",@Expect)
      f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
      search_expect_file(f,pull_signal,2,1)
#      exit
    elsif ice_pull_flag != 0
      f.printf("     *pullup/pulldown*\n")
      f.printf("     @N:Cannot get more connect information\n\n")
      f.printf("     Final Connection:%s\n", pull_signal)
      f.printf("\n")
      f.printf("     014:Searching in Expect File(%s) ... ",@Expect)
      @ORG_DIRECTION = "IN"
      @TARGET = "Device"
      f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
      search_expect_file(f,pull_signal,2)
      flag = true
    end
    
    # "IN_PIN"
=begin
    (dev_connect_inf.IN-ice_connect_inf.IN).each{|signal|
      if signal == "IN_PIN"
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
      end
    }
=end
    (ice_connect_inf.IN-dev_connect_inf.IN).each{|signal|
      if signal == "IN_PIN"
        # search other hierchy from net name
        f.printf("\n\t*ICE Connect Information*\n\n") if $VERBOSE
        f.printf("\tModuleName:%s, NetName:%s, type:%s\n",@ICEHier["#{ice_file}"].ModuleName,ice_connect_inf.NetName,signal) if $VERBOSE
        f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
        @ORG_DIRECTION = "IN"
        @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
        @TARGET = "Device"
        f.printf("011-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
        search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,dev_connect_inf)        
      end
    }
    return flag
  end
  
  def different_connection_for_OUT(f,ice_file,dev_connect_inf,ice_connect_inf,inst_pin_name)
    flag = false
    diff_flag = false

    (dev_connect_inf.IN & ice_connect_inf.IN).each{|signal|
      @ORG_DIRECTION = "OUT"
      @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
      other_connect = @ICEHier["#{ice_file}"].FullPath + "." + signal
      @TARGET = "Device"
      f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
      f.printf("\n")
      f.printf("     015:Searching in Expect File(%s) ... ",@Expect)
      f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
      search_expect_file(f,other_connect,0,2)      
    }

    if ice_connect_inf.IN.size == 0 && ice_connect_inf.OUT.size == 0
      diff_flag = true
      f.printf("     opennet\n") if ice_connect_inf.IN.size == 0 && ice_connect_inf.Direction == "OUT"
      if dev_connect_inf.IN.size == 0 && dev_connect_inf.OUT.size == 0
        f.printf("\n")
        if ice_connect_inf.IN.size == 0 && ice_connect_inf.Direction == "OUT"
          f.printf("@I:Device and ICE Environment is same connection(opennet)\n")
          @ORG_DIRECTION = "OUT"
          @TARGET = "Device"
          f.printf("\n")
          f.printf("     016:Searching in Expect File about %s(%s) ... ",@ORG_SIGNAL,@Expect)
          f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
          search_expect_file(f,"opennet",0,1)
        else
          f.printf("@I:Device and ICE Environment is same connection(pulldown/pullup)\n")
          @ORG_DIRECTION = "IN"
          @TARGET = "Device"
          f.printf("\n")
          f.printf("     017:Searching in Expect File about %s(%s) ... ",@ORG_SIGNAL,@Expect)
          f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
          search_expect_file(f,"pullup/pulldown",2,1)
        end
        @OperationFlag = true
        flag = true
      else
        f.printf("\n")
        @ORG_DIRECTION = "OUT"
        @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
        @TARGET = "Device"
        f.printf("\n")
        f.printf("     018:Searching in Expect File(%s) ... ",@Expect)
        f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
        search_expect_file(f,"opennet",0)
      end
    end

    (ice_connect_inf.IN-dev_connect_inf.IN).each{|signal|
      diff_flag = true
      f.printf("\n  [ice-only signal] -> %s\n",signal)  if $VERBOSE
      if signal == "OUT_PIN"
        # search other hierchy from net name
        f.printf("\n\t*ICE Connect Information*\n\n") if $VERBOSE
        f.printf("\tModuleName:%s, NetName:%s, type:%s\n",@ICEHier["#{ice_file}"].ModuleName,ice_connect_inf.NetName,signal) if $VERBOSE
        f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,file)
        @ORG_DIRECTION = "OUT"
        @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
        @TARGET = "Device"
        f.printf("012-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
        search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,dev_connect_inf)
      else
        if @ICEHier["#{@ICEHier["#{ice_file}"].Lower}"] != nil 
          if /#{@ICEHier["#{@ICEHier["#{ice_file}"].Lower}"].ModuleName}/ =~ signal
            @ORG_DIRECTION = "OUT"
            @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
            @TARGET = "Device"
            f.printf("013-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
            search_connection_from_net(f,"lower",ice_file,ice_connect_inf.NetName,dev_connect_inf,signal)
            ice_connect_inf.IN.delete("#{signal}")
          elsif signal == "OUT_PIN"
            @ORG_DIRECTION = "OUT"
            @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
            @TARGET = "Device"
            f.printf("014-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
            search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,dev_connect_inf,signal)
            ice_conect_inf.IN.delete("#{signal}")
          elsif signal == "IN_PIN"
            # SKIP              
          else
            @ORG_DIRECTION = "OUT"
            @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
            other_connect = @ICEHier["#{ice_file}"].FullPath + "." + signal
            @TARGET = "Device"
            f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
            f.printf("\n")
            f.printf("     019:Searching in Expect File(%s) ... ",@Expect)
            f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
            search_expect_file(f,other_connect,0)
=begin
            $ERROR_CNT += 1
            printf("@E:Found unrecognized connection about %s\n",@ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name)
            printf("   please check it.")
            Common.print_summary
            exit
=end
          end
        else
          if signal != "IN_PIN" && signal != "OUT_PIN"
            @ORG_DIRECTION = "OUT"
            @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
            other_connect = @ICEHier["#{ice_file}"].FullPath + "." + signal
            @TARGET = "Device"
            f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
            f.printf("\n")
            f.printf("     020:Searching in Expect File(%s) ... ",@Expect)
            f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
            search_expect_file(f,other_connect,0)
          end
        end
      end
    }
    (ice_connect_inf.OUT-dev_connect_inf.OUT).each{|signal|
      diff_flag = true
      f.printf("\n  [ice-only signal] -> %s\n",signal)  if $VERBOSE
      if signal == "OUT_PIN"
        # search other hierchy from net name
        f.printf("\n\t*ICE Connect Information*\n\n") if $VERBOSE
        f.printf("\tModuleName:%s, NetName:%s, type:%s\n",@ICEHier["#{ice_file}"].ModuleName,ice_connect_inf.NetName,signal) if $VERBOSE
        f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
        @ORG_DIRECTION = "OUT"
        @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
        @TARGET = "Device"
        f.printf("015-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
        search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,dev_connect_inf)
        ice_connect_inf.OUT.delete("#{signal}")
      else
        @ORG_DIRECTION = "OUT"
        @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
        @TARGET = "Device"
        f.printf("\n")
        f.printf("     021:Searching in Expect File about %s(%s) ... ",@ORG_SIGNAL,@Expect)
        f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
        search_expect_file(f,signal,0,1)
      end
    }
    (dev_connect_inf.IN-ice_connect_inf.IN).each{|signal|
      if signal == "OUT_PIN"
        # search other hierchy from net name
        f.printf("\n\t*ICE Connect Information*\n\n") if $VERBOSE
        f.printf("\tModuleName:%s, NetName:%s, type:%s\n",@ICEHier["#{ice_file}"].ModuleName,ice_connect_inf.NetName,signal) if $VERBOSE
        f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,file)
        @ORG_DIRECTION = "OUT"
        @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
        @TARGET = "Device"
        f.printf("016-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
        search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,dev_connect_inf)
        ice_conect_inf.OUT.delete("#{signal}")
      else
        if diff_flag == false
          f.printf("@I:Device and ICE Environment is same connection. ( include having Device only connection )\n")
          f.printf("   %s cannnot check these connection to whether removed instance.please check yourself.\n",$SUB_TOOL)
          @OperationFlag = true
          break
        else
        end
      end
    }
    if ice_connect_inf.OUT.size == 1 && ice_connect_inf.OUT == ["OUT_PIN"]
      ice_connect_inf.OUT.each{|signal|
        # search other hierchy from net name
        f.printf("\n\t*ICE Connect Information*\n\n") if $VERBOSE
        f.printf("\tModuleName:%s, NetName:%s, type:%s\n",@ICEHier["#{ice_file}"].ModuleName,ice_connect_inf.NetName,signal) if $VERBOSE
        f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{ice_file}"].FullPath,signal,ice_connect_inf.Direction,ice_file)
        @ORG_DIRECTION = "OUT"
        @ORG_SIGNAL = @ICEHier["#{ice_file}"].FullPath + "." + inst_pin_name
        @TARGET = "Device"
        f.printf("016-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
        search_connection_from_net(f,"upper",ice_file,ice_connect_inf.NetName,dev_connect_inf)        
        ice_connect_inf.OUT.delete("#{signal}")
      }
    end
    return flag
  end
  
  #
  # Search connection from different hierarchy
  #
  def search_connection_from_net(f,hier,ice_file,net_name,dev_connect_inf=nil,other_connect=nil)    
    # Chang net_name if original net name and connection net name are different
    f.printf("search_connection_from_net - other_connct:%s\n",other_connect) if $VERBOSE
    f.printf("search_connection_from_net - net_name    :%s\n",net_name) if $VERBOSE
    if other_connect != nil
      if other_connect.split(".").size == 2
        if hier == "lower"
          net_name = other_connect.split(".")[1] 
          f.printf("search_connection_from_net - net_name:%s[Modified]\n",net_name) if $VERBOSE
        end
      end
    end


    f.printf("\tSearch Connection to %s\n",hier) if $VERBOSE
    # get above hierarchy report_file
    if hier == "upper"
      file = @ICEHier["#{ice_file}"].Upper.to_s
    elsif hier == "lower"
      file = @ICEHier["#{ice_file}"].Lower.to_s
      return if file == nil || file == ""
    else
      file = ""
    end
    
    if file.size != 0
      f.printf("\tScope Change:from %s to %s\n",@ICEHier["#{ice_file}"].ModuleName,@ICEHier["#{file}"].ModuleName) if $VERBOSE
      # Check Upper Level connecting net_name
      module_name =  @ICEHier["#{ice_file}"].ModuleName
      if @ICE_ReportData["#{file}"] == nil
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        p file
        exit
      end
      net_name_list = @ICE_ReportData["#{file}"][1]

      net_name_org = net_name
      target_net = module_name + "." + net_name 
      net_name_list.each{|key,value|
        flag = false
        value.ConnectInfo.each{|data|
          if data.InstPinName == target_net
            net_name = key
            f.printf("     changed net_name from %s to %s\n",net_name_org,net_name)
            flag = true
          end
        }
        break if flag
      } 

      f.printf("\tfile:%s\n",file)
      f.printf("\tNet name:%s\n",net_name)
      if net_name_list["#{net_name}"] == nil
        inst_net_name = module_name + "." + net_name 
        ice_connect_inf = @ICE_ReportData["#{file}"][0]["#{inst_net_name}"]
        if ice_connect_inf != nil
          f.printf("\tsearch_ice_connect\n") if $VERBOSE
          search_ice_connect(f,file,dev_connect_inf,ice_connect_inf,other_connect)
        else          
          if hier == "upper" && @TARGET == "Device"
            @OperationFlag = true
            f.printf("\n")
            f.printf("\n")
            f.printf("     022:Searching in Expect File about %s(%s) ... ",@ORG_SIGNAL,@Expect)
            if /pull/ =~ inst_net_name
              f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
              search_expect_file(f,inst_net_name,2,1)
            else
              f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
              search_expect_file(f,inst_net_name,0,1)
            end
            return true
=begin
            $ERROR_CNT += 1
            printf("\n@E:Not Found expected Connection in current hierarchy\n")
            printf("It was unrecognized make_chip connection. Is this correct?\n")
            printf("(file:%s,inst_net_name:%s)\n",ice_file,inst_net_name)
            Common.print_summary
            exit
=end
          end
        end
        return
      else
        f.printf("\tsearch_other_hier_ice_connect\n") if $VERBOSE
        search_other_hier_ice_connect(f,ice_file,file,net_name,hier,dev_connect_inf,other_connect)
      end
    else
      f.printf("\treport_final_connection\n") if $VERBOSE
      report_final_connection(f,other_connect)
    end    
  end

  
  def search_ice_connect(f,file,dev_connect_inf,ice_connect_inf,other_connect)
    ice_connect_inf.OUT.each{|inst_pin_name|
      f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{file}"].FullPath,inst_pin_name,"OUT",file)
      f.printf("     @M:001-Cannot get more connect information\n\n")
      f.printf("     Final Connection:%s\n",inst_pin_name)
      f.printf("\n")
      f.printf("     024:Searching in Expect File(%s) ... ",@Expect)
      if /pull/ =~ inst_pin_name
        f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
        search_expect_file(f,inst_pin_name,2)
      else
        f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
        search_expect_file(f,inst_pin_name,0)
      end
      return true
    } 
    
    ice_connect_inf.IN.each{|inst_pin_name|
      f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{file}"].FullPath,inst_pin_name,"IN",file)
    } 
    
    ice_connect_inf.INOUT.each{|inst_pin_name|
      f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{file}"].FullPath,inst_pin_name,"IO",file)
      f.printf("     @M:002-Cannot get more connect information\n\n")
      f.printf("     Final Connection:%s\n",inst_pin_name)
      f.printf("\n")
      f.printf("     025:Searching in Expect File(%s) ... ",@Expect)
      if /pull/ =~ inst_pin_name
        f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
        search_expect_file(f,inst_pin_name,2)
      else
        f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
        search_expect_file(f,inst_pin_name,0)
      end
      return true
    } 

    if ice_connect_inf.OUT.size == 0 && ice_connect_inf.IN.size == 0 && (( /OUT_PIN/ =~ ice_connect_inf.OUT.to_s) == nil )
      f.printf("     opennet\n")
      f.printf("     @M:003-Cannot get more connect information\n\n")
      f.printf("     Final Connection:%s\n","opennet")
      f.printf("\n")
      f.printf("     026:Searching in Expect File(%s) ... ",@Expect)
      f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
      search_expect_file(f,"opennet",2)
    else
      @TARGET = "Device"
      if other_connect == ""
        other_connect = nil 
      end
      case ice_connect_inf.Direction
      when "IN"
        if ice_connect_inf.OUT != []
          ice_connect_inf.OUT.each{|other_connect|
            f.printf("017-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
            search_connection_from_net(f,"upper",file,ice_connect_inf.NetName,dev_connect_inf,other_connect)
          } 
        else
          f.printf("018-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
          search_connection_from_net(f,"upper",file,ice_connect_inf.NetName,dev_connect_inf,ice_connect_inf.OUT.to_s)
        end
      when "OUT"
        if ice_connect_inf.IN != []
          ice_connect_inf.IN.each{|other_connect|
            f.printf("019-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
            search_connection_from_net(f,"upper",file,ice_connect_inf.NetName,dev_connect_inf,other_connect)
          } 
        else
          f.printf("020-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
          search_connection_from_net(f,"upper",file,ice_connect_inf.NetName,dev_connect_inf,"")
        end
      when "I/O"
        if ice_connect_inf.INOUT != []
          ice_connect_inf.INOUT.each{|other_connect|
            f.printf("021-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
            search_connection_from_net(f,"upper",file,ice_connect_inf.NetName,dev_connect_inf,other_connect)
          } 
        else
          f.printf("022-search_connection_from_net - net_name : %s\n",ice_connect_inf.NetName) if $VERBOSE
          search_connection_from_net(f,"upper",file,ice_connect_inf.NetName,dev_connect_inf,"")
        end
      end
    end     
  end

  def search_other_hier_ice_connect(f,ice_file,file,net_name,hier,dev_connect_inf,other_connect)
    
    module_name =  @ICEHier["#{ice_file}"].ModuleName
    # get NetName     
    net_name_list = @ICE_ReportData["#{file}"][1]


    inout = nil
    inout_flag = false
    # Search Connect Information
    scope_flag = "other"
    f.printf("\t%s Level Information(%s)\n",hier,file) if $VERBOSE
    if @ICEHier["#{@ICEHier["#{file}"].Lower}"] != nil
      f.printf("     Searching about net name : %s.%s\n",@ICEHier["#{@ICEHier["#{file}"].Lower}"].ModuleName,net_name) if $VERBOSE
    end
    net_name_org = net_name
    # Changing net_name from connect information. net_name and real pin name is different
    if hier != "upper"
      if @ICEHier["#{@ICEHier["#{file}"].Lower}"] != nil
        target_net = @ICEHier["#{@ICEHier["#{file}"].Lower}"].ModuleName + "." + net_name
        net_name_list.each{|key,value|
          value.ConnectInfo.each{|data|
            if data.InstPinName == target_net
              net_name = key
              f.printf("     changed net_name from %s to %s\n",net_name_org,net_name)
            end
          }
        }
      end
    end

    
    i = 1    
    net_name_list["#{net_name}"].ConnectInfo.each{|data|
      f.printf("\t%s\n",data) if $VERBOSE
      f.printf("\t\t%s:%s\n",data.InstPinName,data.Direction) if $VERBOSE
      
      f.printf("hier        : %s\n",hier) if $VERBOSE
      f.printf("InstPinName : %s\n",data.InstPinName) if $VERBOSE
      return if ( data.InstPinName == "IN_PIN" || data.InstPinName == "OUT_PIN" ) && hier != "upper"
      if hier == "lower"
        next if data.InstPinName == "IN_PIN" 
        next if data.InstPinName == "OUT_PIN"
      end

      if data.InstPinName != "OUT_PIN" && data.InstPinName != "IN_PIN" && data.InstPinName != "IO_PIN"
        f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{file}"].FullPath,data.InstPinName,data.Direction,file)
      end
      inout = data.Direction
      
      if @ORG_DIRECTION != data.Direction 
        
        ice_connect = nil
        same_connect_flag = false
        other_connect = @ICEHier["#{file}"].FullPath + "." + data.InstPinName 
        if other_connect != nil
          tmp = other_connect.split(".")
          ice_connect= tmp[tmp.size-2] + "." + tmp[tmp.size-1]
        else
          other_connect = "opennet"
          ice_connect = "opennet"
        end
        
        @ExpectedInSignal.each{|signal|
          same_connect_flag = true if  signal == ice_connect
          f.printf("Judgement[%s]: expect signal - %s, ice_connect - %s\n",same_connect_flag,signal,ice_connect) if $VERBOSE
        }
        @ExpectedOutSignal.each{|signal|
          same_connect_flag = true if  signal == ice_connect
          f.printf("Judgement[%s]: expect signal - %s, ice_connect - %s\n",same_connect_flag,signal,ice_connect) if $VERBOSE
        }
        
        if same_connect_flag
          f.printf("     Same Connection\n\n")
          f.printf("@I:Device and ICE Environment is same connection to %s\n",ice_connect)
          @OperationFlag = true
          f.printf("\n")
          f.printf("     027:Searching in Expect File about %s(%s) ... ",@ORG_SIGNAL,@Expect)
          f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
          f.printf("\tother_connect : %s\n",other_connect)
          search_expect_file(f,other_connect,0,1)
          next
        elsif data.InstPinName != "OUT_PIN" && data.InstPinName != "IN_PIN" && data.InstPinName != "IO_PIN"
          inst_name = data.InstPinName.split(".")[0]
          net_name_mod = data.InstPinName.split(".")[1]
          if @ICEHier["#{@ICEHier["#{file}"].Lower}"] != nil
            if inst_name == @ICEHier["#{@ICEHier["#{file}"].Lower}"].ModuleName
              f.printf("101-search_connection_from_net - net_name : %s\n",net_name_mod) if $VERBOSE
              search_connection_from_net(f,"lower",file,net_name_mod,dev_connect_inf)
            else
              f.printf("     @M:Found ICE Only Connection.\n\n")
              f.printf("     028:Searching in Expect File(%s) ... for %s",@Expect,other_connect)
              @OperationFlag = true
              f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE 
              if /pull/ =~ other_connect
                search_expect_file(f,other_connect,2)
              else
                search_expect_file(f,other_connect,0)
              end
            end
          else
            f.printf("     @M:Found ICE Only Connection.\n\n")
            f.printf("     029:Searching in Expect File(%s) ... ",@Expect)
            @OperationFlag = true
            f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE 
            search_expect_file(f,other_connect,0)
          end
          next
        end
      end
      i += 1
      
      inout_flag = true if data.InstPinName == "OUT_PIN" || data.InstPinName == "IN_PIN" || data.InstPinName == "IO_PIN"
      
      if hier == "upper"
        scope_flag = "upper" if inout_flag
        case @ORG_DIRECTION
        when "OUT"
          if data.InstPinName == "OUT_PIN"              
            other_connect = data.InstPinName
          elsif data.Direction != @ORG_DIRECTION
            other_connect = @ICEHier["#{file}"].FullPath + "." + data.InstPinName  
          end
        when "IN"
          if data.InstPinName == "IN_PIN"
            other_connect = data.InstPinName
          elsif data.Direction != @ORG_DIRECTION
            other_connect = @ICEHier["#{file}"].FullPath + "." + data.InstPinName  
          end
        when "IO"
          if "_PIN" =~ data.InstPinName
            other_connect = data.InstPinName
          elsif data.Direction != @ORG_DIRECTION
            other_connect = @ICEHier["#{file}"].FullPath + "." + data.InstPinName  
          end
        end
        
      elsif hier == "lower"
        scope_flag = "lower"            
        if data.InstPinName != "OUT_PIN" && data.InstPinName != "IN_PIN"  && data.InstPinName != "IO_PIN"
          case @ORG_DIRECTION
          when "IN"
            if data.Direction == "OUT"
              other_connect = @ICEHier["#{file}"].FullPath + "." + data.InstPinName 
              f.printf("022-search_connection_from_net - net_name : %s\n",net_name_list["#{net_name}"].NetName) if $VERBOSE
              search_connection_from_net(f,scope_flag,file,net_name_list["#{net_name}"].NetName,dev_connect_inf,other_connect)
            end
          when "OUT"
            if data.Direction == "IN"
              other_connect = @ICEHier["#{file}"].FullPath + "." + data.InstPinName 
              f.printf("023-search_connection_from_net - net_name : %s\n",net_name_list["#{net_name}"].NetName) if $VERBOSE
              search_connection_from_net(f,scope_flag,file,net_name_list["#{net_name}"].NetName,dev_connect_inf,other_connect)
            end
          when "IO"
            other_connect = @ICEHier["#{file}"].FullPath + "." + data.InstPinName 
            f.printf("024-search_connection_from_net - net_name : %s\n",net_name_list["#{net_name}"].NetName) if $VERBOSE
            search_connection_from_net(f,scope_flag,file,net_name_list["#{net_name}"].NetName,dev_connect_inf,other_connect)
          else
            printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
            exit
          end
        end
      else
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
      end      
    }
    
    # opennet
    if net_name_list["#{net_name}"].ConnectInfo.size == 1 
      if dev_connect_inf.OUT.size == 0 && dev_connect_inf.IN.size == 0
        f.printf("     Same Connection to other hierarchy module\n\n")
        f.printf("@I:Device and ICE Environment is same connection to %s\n","opennet")
        @OperationFlag = true
        @ORG_DIRECTION = "OUT"
        @TARGET = "Device"
        f.printf("\n")
        f.printf("     030:Searching in Expect File about %s(%s) ... ",@ORG_SIGNAL,@Expect)
        f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
        search_expect_file(f,"opennet",2,1)
      else
        net_name_list["#{net_name}"].ConnectInfo.each{|data|
          if data.Direction == "OUT" && data.InstPinName != "OUT_PIN"
            f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{file}"].FullPath,net_name,data.Direction,file)
            f.printf("     opennet\n")
            f.printf("     @M:004-Cannot get more connect information\n\n")
            f.printf("     Final Connection:%s\n","opennet")
            f.printf("\n")
            f.printf("     031:Searching in Expect File(%s) ... ",@Expect)
            @ORG_DIRECTION = "OUT"
            @TARGET = "Device"
            f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
            search_expect_file(f,"opennet",2)
          end
        }
#      else
#        net_name_list["#{net_name}"].ConnectInfo.each{|data|
#          if data.Direction == "OUT" && data.InstPinName != "OUT_PIN"
#            f.printf("     %s.[%s]:%s(%s)\n",@ICEHier["#{file}"].FullPath,net_name,data.Direction,file)
#            f.printf("     opennet\n")
#            f.printf("     @M:Cannot get more connect information\n\n")
#            f.printf("     Final Connection:%s\n","opennet")
#            f.printf("\n")
#            f.printf("     Searching in Expect File(%s) ... ",@Expect)
#            @ORG_DIRECTION = "OUT"
#            @TARGET = "Device"
#            search_expect_file(f,"opennet",2)
#          end
#        }
      end
    end

    return if scope_flag == "other"
    if scope_flag == "lower"
      f.printf("025-search_connection_from_net - net_name : %s\n",net_name_list["#{net_name}"].NetName) if $VERBOSE
      search_connection_from_net(f,scope_flag,file,net_name_list["#{net_name}"].NetName,dev_connect_inf,other_connect) if @ORG_DIRECTION != inout  || inout_flag  
    else
      f.printf("026-search_connection_from_net - net_name : %s\n",net_name_org) if $VERBOSE
      f.printf("026-search_connection_from_net - NetNme   : %s\n",net_name_list["#{net_name}"].NetName) if $VERBOSE
      f.printf("026-search_connection_from_net - other_connect : %s\n",other_connect) if $VERBOSE
      search_connection_from_net(f,scope_flag,file,net_name_org,dev_connect_inf,other_connect) if @ORG_DIRECTION != inout  || inout_flag  
    end
  end

  def report_final_connection(f,other_connect)
    if other_connect != nil
      if /_PIN/ =~ other_connect
        tmp = other_connect.split(".")
        ice_connect= tmp[tmp.size-1]
      else
        tmp = other_connect.split(".")
        ice_connect= tmp[tmp.size-2] + "." + tmp[tmp.size-1]
      end
    else
      other_connect = "opennet"
      ice_connect = "opennet"
    end
    
    other_connect = "evatop." + other_connect if /_PIN/ !~ other_connect
    same_connect_flag = false
    f.printf("     @M:005-Cannot get more connect information\n\n")
    f.printf("     Final Connection:%s\n",other_connect)
    
    @ExpectedInSignal.each{|signal|
      signal = "IN_PIN" if signal == "IO_PIN"
      f.printf("for IN: %s %s\n",signal,ice_connect)
      same_connect_flag = true if  signal == ice_connect
    }
    f.printf("\n")
    @ExpectedOutSignal.each{|signal|
      f.printf("for OUT: %s %s\n",signal,ice_connect)
      same_connect_flag = true if  signal == ice_connect
    }
    f.printf("\n")
    
    if same_connect_flag
      f.printf("     Same Connection to other hierarchy module\n\n")
      f.printf("@I:Device and ICE Environment is same connection to %s\n",ice_connect)
      @OperationFlag = true
      f.printf("\n")
      f.printf("     032:Searching in Expect File about %s(%s) ... ",@ORG_SIGNAL,@Expect)
      f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
      search_expect_file(f,other_connect,0,1)
    else
      f.printf("     033:Searching in Expect File(%s) ... ",@Expect)
      @OperationFlag = true
      f.printf("\tsearch_expect_file(line:%d)\n",__LINE__) if $VERBOSE
      search_expect_file(f,other_connect,0)
    end
  end
  
  
  #
  # num  0 : Modify
  #      1 : Remove
  #      2 : ModifyPull
  #
  # match : 0 : Source - diff, Destination - diff
  #         1 : Source - same, Destination - diff
  #         2 : Source - same, Destination - same
  #
  def search_expect_file(f,other_connect,num,same_flag = 0)
    match = 0

    if @ORG_DIRECTION == "IN"
      match = search_expect_file_for_IN(f,other_connect,num,same_flag)
    elsif @ORG_DIRECTION == "OUT"
      match = search_expect_file_for_OUT(f,other_connect,num,same_flag)
    else
      printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
      exit
    end
    return match
  end
  
  def search_expect_file_for_IN(f,other_connect,num,same_flag)
    match = 0
    @ExpectInf.each_value{|each_inf|
      next if each_inf == nil


      if same_flag == 0
        # Full Path
        if num == 0
          if /_PIN/ =~ other_connect
            match =  search_ModifiedOther(match,each_inf,other_connect,same_flag,f)
          else
            sig = nil
            if $Socket_flag == true
              sig = each_inf.Modified["#{@SOCKET_SIGNAL}"]
            else
              sig = each_inf.Modified["#{@ORG_SIGNAL}"]
            end
            sig.each{|sig_name|
              if sig_name[0] == other_connect
                match = 2 
                sig_name[1].Flag = true
              end
            } if sig != nil
          end
        elsif num == 2
          if /pull/ =~ other_connect
            match =  search_ModifiedPull(match,each_inf,other_connect,same_flag,f)
          elsif /opennet/ =~ other_connect || /_PIN/ =~ other_connect
            match =  search_ModifiedOther(match,each_inf,other_connect,same_flag,f)
          end
        end
        
        
        # One inst name & signal
        if $Socket_flag == true
          tmp = @SOCKET_SIGNAL.split(".")
        else
          tmp = @ORG_SIGNAL.split(".")
        end
        size = tmp.size
        new_name = tmp[size-2] + "." + tmp[size-1]
        if num == 0
          sig = each_inf.Modified["#{new_name}"]
        end
        tmp = other_connect.split(".")
        size = tmp.size
        new_name = tmp[size-2] + "." + tmp[size-1]
        sig.each{|sig_name|
          if sig_name[0] == new_name
            match = 2           
            sig_name[1].Flag = true
          end
        } if sig != nil
      else
        match = search_Modified(match,each_inf,other_connect,same_flag,f)
        match = search_ModifiedOther(match,each_inf,other_connect,same_flag,f)
        match = search_ModifiedPull(match,each_inf,other_connect,same_flag,f)
      end
    }
      
    if $Socket_org_signal != nil
      err = ConnectInfo.new
      err.Source = other_connect
      err.Dest   = @ORG_SIGNAL
      err.Direction = "IN"
      err.DeviceSignal = @ORG_SIGNAL
      err.Type = "Socket"
      @ERROR_LIST << err
      @OperationFlag = true
    elsif same_flag == 0
      err = ConnectInfo.new
      err.Source = other_connect
      err.Dest   = @ORG_SIGNAL
      err.Direction = "IN"
      err.DeviceSignal = @ORG_SIGNAL
      if match == 2
        f.printf("OK\n\n")
        err.Type = "Expect"
        if @TARGET == "ICE"
          err.ICEOnlyFlag = true
        end 
        @OperationFlag = true
      else
        f.printf("NG\n\n")
        if @TARGET == "ICE"
          f.printf("@E:There is ice-only pin( %s <- %s ) in target instance, Add connect inf to expect file.\n\n",@ORG_SIGNAL,other_connect)
          @OperationFlag = true
          err.Type = "ICE-Only"
          err.ICEOnlyFlag = true
        else
          f.printf("@E:There is ice-modified connection( %s <- %s ), Add connect inf to expect file.\n\n",@ORG_SIGNAL,other_connect)
          @OperationFlag = true
          err.Type = "Unmatched"
        end
      end
      @ERROR_LIST << err
    elsif same_flag == 1
      if match == 0
        f.printf("Nothing\n\n")
      elsif match == 2
        f.printf("Found(Same Connection)\n\n")
      else
        err = ConnectInfo.new
        err.Source = other_connect
        err.Dest   = @ORG_SIGNAL
        err.Direction = "IN"
        err.DeviceSignal = @ORG_SIGNAL
        err.Type = "Unmatched(or Changed Port)"
        @ERROR_LIST << err
        f.printf("Found(Different Connection).\n\n")
        f.printf("@E:There is unexpected ice connection( %s <- %s ), please modify ice-connection or change Expect file.\n\n",@ORG_SIGNAL,other_connect)
        f.printf("[Unused Expected-connection]%s\n",@UnusedExpectedConnection)
      end
    elsif same_flag == 2
      if match == 2
        f.printf("Found(Same Connection)\n\n")
      else
        f.printf("Not Found(no-need in Expect File)\n\n")
      end
    end
    return match
  end

  def search_expect_file_for_OUT(f,other_connect,num,same_flag)
    match = 0
    @ExpectInf.each_value{|each_inf|
      next if each_inf == nil
      # Full Path
      if num == 0
        if /_PIN/ =~ other_connect
          match = search_ModifiedOther(match,each_inf,other_connect,same_flag,f)
        elsif /opennet/ =~ other_connect || /_PIN/ =~ other_connect
          match = search_ModifiedOther(match,each_inf,other_connect,same_flag,f)
        else
          sig = nil
          if $Socket_flag == true
            sig = each_inf.Modified["#{@SOCKET_SIGNAL}"]
          else
            sig = each_inf.Modified["#{@ORG_SIGNAL}"]
          end
        end
      elsif num == 2
        org_signal = nil
        if $Socket_flag == true
          org_signal = @SOCKET_SIGNAL
        else
          org_signal = @ORG_SIGNAL
        end
        if /pull/ =~ org_signal
          match = search_ModifiedPull(match,each_inf,other_connect,same_flag,f)
        elsif /opennet/ =~ other_connect || /_PIN/ =~ other_connect
          match = search_ModifiedOther(match,each_inf,other_connect,same_flag,f)
        end
      end

      if same_flag == 1 || same_flag == 2
        match = search_Modified(match,each_inf,other_connect,same_flag,f)
        match = search_ModifiedOther(match,each_inf,other_connect,same_flag,f)
        match = search_ModifiedPull(match,each_inf,other_connect,same_flag,f)
      end
      
      sig.each{|sig_name|
        if sig_name[0] == other_connect
          match = 2 
          sig_name[1].Flag = true
        end
      } if sig != nil
      
      # One inst name & signal
      if $Socket_flag == true
        tmp = @SOCKET_SIGNAL.split(".")
      else
        tmp = @ORG_SIGNAL.split(".")
      end
      size = tmp.size
      new_name = tmp[size-2] + "." + tmp[size-1]
      if num == 0
        sig = each_inf.Modified["#{new_name}"]
      end
      tmp = other_connect.split(".")
      size = tmp.size
      ### 20101018 #####  Tempolary Changed. Check it port6.PSEL
      #      new_name = tmp[size-2] + "." + tmp[size-1]
      if tmp[size-1] != nil && tmp[size-1] != nil
        new_name = tmp[size-2] + "." + tmp[size-1]
      else
        f.printf("@@CHECK@ @ORG_SIGNAL:%s\n",@ORG_SIGNAL)
        f.printf("@@CHECK@ other_connect:%s\n",other_connect)
        new_name = other_connect
      end
      ###########################
      sig.each{|sig_name|
        if sig_name[0] == new_name
          match = 2 
          sig_name[1].Flag = true
        end
      } if sig != nil
      }

    if $Socket_org_signal != nil
      err = ConnectInfo.new
      err.Source = other_connect
      err.Dest   = @ORG_SIGNAL
      err.Direction = "IN"
      err.DeviceSignal = @ORG_SIGNAL
      err.Type = "Socket"
      @ERROR_LIST << err
      @OperationFlag = true
    elsif same_flag == 0
      err = ConnectInfo.new
      err.Source = @ORG_SIGNAL
      err.Dest   = other_connect
      err.Direction = "OUT"
      err.DeviceSignal = @ORG_SIGNAL
      if match == 2
        f.printf("OK\n\n")          
        err.Type = "Expect"
        err.ICEOnlyFlag = true if @TARGET == "ICE"
        @OperationFlag = true
      else
        f.printf("NG\n\n")
        if @TARGET == "ICE"
          f.printf("@E:There is ice-only pin( %s -> %s ) in target instance, Add connect inf to expect file.\n\n",@ORG_SIGNAL,other_connect)
          @OperationFlag = true
          err.Type = "ICE-Only"
          err.ICEOnlyFlag = true
        else
          f.printf("@E:There is ice-modified connection( %s -> %s ), Add connect inf to expect file.\n\n",@ORG_SIGNAL,other_connect)
          @OperationFlag = true
          err.Type = "Unmatched"
        end
      end
      @ERROR_LIST << err
    elsif same_flag == 1
      if match == 0
        f.printf("Nothing\n\n")
      elsif match == 2
        f.printf("Found(Same Connection)\n\n")
      else
        err = ConnectInfo.new
        err.Source = @ORG_SIGNAL
        err.Dest   = other_connect
        err.Direction = "OUT"
        err.DeviceSignal = @ORG_SIGNAL
        err.Type = "Unmatched(or Changed Port)"
        @ERROR_LIST << err
        f.printf("Found(Different Connection).\n\n")
        f.printf("@E:There is unexpected ice connection( %s -> %s ), please modified ice-connection or change Expect file.\n\n",@ORG_SIGNAL,other_connect)
        f.printf("[Unused Expected-connection]%s\n",@UnusedExpectedConnection)
      end        
    elsif same_flag == 2
      if match == 2
        f.printf("Found(Same Connection)\n\n")
      else
        f.printf("Not Found(no-need in Expect File)\n\n")
      end
    end
    return match
  end
  
  def search_Modified(match,each_inf,other_connect,same_flag = 0,f = nil)
    other_tmp = other_connect.split(".")
    other_path = other_tmp[other_tmp.size-2] + "." + other_tmp[other_tmp.size-1]

    if same_flag == 0
      org_signal = nil
      if $Socket_flag == true
        org_signal = @SOCKET_SIGNAL
      else
        org_signal = @ORG_SIGNAL
      end
      each_inf.Modified["#{org_signal}"].each{|sig_name|
        if sig_name[0] == other_connect
          match = 2 
          sig_name[1].Flag = true
        end
      } if each_inf.Modified["#{org_signal}"] != nil
      
      if $Socket_flag == true
        tmp = @SOCKET_SIGNAL.split(".")
      else
        tmp = @ORG_SIGNAL.split(".")
      end
      size = tmp.size
      new_name = tmp[size-2] + "." + tmp[size-1]
      each_inf.Modified["#{new_name}"].each{|sig_name|
        if sig_name[0] == other_connect
          match = 2 
          sig_name[1].Flag = true
        end
      } if each_inf.Modified["#{new_name}"] != nil
    elsif same_flag == 1 || same_flag == 2
      org_signal = nil
      if $Socket_flag == true
        org_signal = @SOCKET_SIGNAL
      else
        org_signal = @ORG_SIGNAL
      end
      if each_inf.Modified["#{org_signal}"] != nil
        f.printf("001-org_signal : %s\n",org_signal) if $VERBOSE
        each_inf.Modified["#{org_signal}"].each{|c|
          @UnusedExpectedConnection = c[1].Line
        }
      end
      if $Socket_flag == true
        tmp = @SOCKET_SIGNAL.split(".")
      else
        tmp = @ORG_SIGNAL.split(".")
      end
      size = tmp.size
      new_name = tmp[size-2] + "." + tmp[size-1]
      if each_inf.Modified["#{new_name}"] != nil
        f.printf("002-new_name : %s (other_path:%s)\n",new_name,other_path) if $VERBOSE
        each_inf.Modified["#{new_name}"].each{|c|
          if c[0] == other_path
            f.printf("002-c : %s (other_path:%s)\n",c[0],other_path) if $VERBOSE
            match = 2
            c[1].Flag = true
            f.printf("@N:Found same Expect-Connection about \"%s\"\n",c[1].Line)
          else
            match = 1
            @UnusedExpectedConnection = c[1].Line
          end
        }
      end
      org_signal = nil
      if $Socket_flag == true
        org_signal = @SOCKET_SIGNAL
      else
        org_signal = @ORG_SIGNAL
      end
      each_inf.Modified["#{org_signal}"].each{|sig_name|
        if sig_name[0] == other_connect
          match = 2 
          sig_name[1].Flag = true
        end
      } if each_inf.Modified["#{org_signal}"] != nil
      
      if $Socket_flag == true
        tmp = @SOCKET_SIGNAL.split(".")
      else
        tmp = @ORG_SIGNAL.split(".")
      end
      size = tmp.size
      new_name = tmp[size-2] + "." + tmp[size-1]
      each_inf.Modified["#{new_name}"].each{|sig_name|
        if sig_name[0] == other_connect
          match = 2 
          sig_name[1].Flag = true
        end
      } if each_inf.Modified["#{new_name}"] != nil
    end
    return match
  end

  def search_ModifiedOther(match,each_inf,other_connect,same_flag = 0, f = nil)
    other_tmp = other_connect.split(".")
    other_path = other_tmp[other_tmp.size-2] + "." + other_tmp[other_tmp.size-1]

    if same_flag == 0
      org_signal = nil
      if $Socket_flag == true
        org_signal = @SOCKET_SIGNAL
      else
        org_signal = @ORG_SIGNAL
      end
      each_inf.ModifiedOther["#{org_signal}"].each{|sig_name|
        if sig_name[0] == other_connect
          match = 2 
          sig_name[1].Flag = true
        end
      } if each_inf.ModifiedOther["#{org_signal}"] != nil
      if $Socket_flag == true
        tmp = @SOCKET_SIGNAL.split(".")
      else
        tmp = @ORG_SIGNAL.split(".")
      end
      size = tmp.size
      new_name = tmp[size-2] + "." + tmp[size-1]
      each_inf.ModifiedOther["#{new_name}"].each{|sig_name|
        if sig_name[0] == other_connect
          match = 2 
          sig_name[1].Flag = true
        end
      } if each_inf.ModifiedOther["#{new_name}"] != nil
    elsif same_flag == 1 || same_flag == 2
      org_signal = nil
      if $Socket_flag == true
        org_signal = @SOCKET_SIGNAL
      else
        org_signal = @ORG_SIGNAL
      end
      if each_inf.ModifiedOther["#{org_signal}"] != nil
        f.printf("003-org_signal : %s\n",org_signal) if $VERBOSE
        if new_name != other_path
          match = 1
          each_inf.ModifiedOther["#{org_signal}"].each{|c|
            @UnusedExpectedConnection = c[1].Line
          }
        else
          f.printf("@N:Found same Expect-Connection about %s\n",net_name)
        end
      end
      if $Socket_flag == true
        tmp = @SOCKET_SIGNAL.split(".")
      else
        tmp = @ORG_SIGNAL.split(".")
      end
      size = tmp.size
      new_name = tmp[size-2] + "." + tmp[size-1]
      if each_inf.ModifiedOther["#{new_name}"] != nil
        f.printf("004-new_name : %s\n",new_name) if $VERBOSE
        if new_name != other_path
          match = 1
          each_inf.ModifiedOther["#{new_name}"].each{|c|
            @UnusedExpectedConnection = c[1].Line
          }
        else
          f.printf("@N:Found same Expect-Connection about %s\n",net_name)
        end
      end
      org_signal = nil
      if $Socket_flag == true
        org_signal = @SOCKET_SIGNAL
      else
        org_signal = @ORG_SIGNAL
      end
      each_inf.ModifiedOther["#{org_signal}"].each{|sig_name|
        if sig_name[0] == other_connect
          match = 2 
          sig_name[1].Flag = true
        end
      } if each_inf.ModifiedOther["#{org_signal}"] != nil
      if $Socket_flag == true
        tmp = @SOCKET_SIGNAL.split(".")
      else
        tmp = @ORG_SIGNAL.split(".")
      end
      size = tmp.size
      new_name = tmp[size-2] + "." + tmp[size-1]
      each_inf.ModifiedOther["#{new_name}"].each{|sig_name|
        if sig_name[0] == other_connect
          match = 2 
          sig_name[1].Flag = true
        end
      } if each_inf.ModifiedOther["#{new_name}"] != nil
    end
    return match
  end

  def search_ModifiedPull(match,each_inf,other_connect,same_flag = 0, f = nil)
    other_tmp = other_connect.split(".")
    other_path = other_tmp[other_tmp.size-2] + "." + other_tmp[other_tmp.size-1]

    if same_flag == 0 
      org_signal = nil
      if $Socket_flag == true
        org_signal = @SOCKET_SIGNAL
      else
        org_signal = @ORG_SIGNAL
      end
      each_inf.ModifiedPull["#{org_signal}"].each{|sig_name|
        if /pull/ =~ sig_name[0]       
          match = 2
          sig_name[1].Flag = true
        end
      } if each_inf.ModifiedPull["#{org_signal}"] != nil
      if $Socket_flag == true
        tmp = @SOCKET_SIGNAL.split(".")
      else
        tmp = @ORG_SIGNAL.split(".")
      end
      size = tmp.size
      new_name = tmp[size-2] + "." + tmp[size-1]
      each_inf.ModifiedPull["#{new_name}"].each{|sig_name|
        if /pull/ =~ sig_name[0]
          match = 2 
          sig_name[1].Flag = true
        end
      } if each_inf.ModifiedPull["#{new_name}"] != nil
    elsif same_flag == 1 || same_flag == 2
      org_signal = nil
      if $Socket_flag == true
        org_signal = @SOCKET_SIGNAL
      else
        org_signal = @ORG_SIGNAL
      end
      if each_inf.ModifiedPull["#{org_signal}"] != nil
        f.printf("005-org_signal : %s\n",org_signal) if $VERBOSE
        match = 1
        each_inf.ModifiedPull["#{org_signal}"].each{|c|
          @UnusedExpectedConnection = c[1].Line
        }
      end
      if $Socket_flag == true
        tmp = @SOCKET_SIGNAL.split(".")
      else
        tmp = @ORG_SIGNAL.split(".")
      end
      size = tmp.size
      new_name = tmp[size-2] + "." + tmp[size-1]
      if each_inf.ModifiedPull["#{new_name}"] != nil
        f.printf("006-new_name : %s\n",new_name) if $VERBOSE
        match = 1
        each_inf.ModifiedPull["#{new_name}"].each{|c|
          @UnusedExpectedConnection = c[1].Line
        }
      end
      org_signal = nil
      if $Socket_flag == true
        org_signal = @SOCKET_SIGNAL
      else
        org_signal = @ORG_SIGNAL
      end
      each_inf.ModifiedPull["#{org_signal}"].each{|sig_name|
        if /pull/ =~ sig_name[0] && /pull/ =~ other_connect
          match = 2
          sig_name[1].Flag = true
        end
      } if each_inf.ModifiedPull["#{org_signal}"] != nil
      if $Socket_flag == true
        tmp = @SOCKET_SIGNAL.split(".")
      else
        tmp = @ORG_SIGNAL.split(".")
      end
      size = tmp.size
      new_name = tmp[size-2] + "." + tmp[size-1]
      each_inf.ModifiedPull["#{new_name}"].each{|sig_name|
        if /pull/ =~ sig_name[0] && /pull/ =~ other_connect
          match = 2 
          sig_name[1].Flag = true
        end
      } if each_inf.ModifiedPull["#{new_name}"] != nil
    end

    return match
  end
  
  #
  # generate error report
  #
  private
  def generate_error_report
    printf("Generate Error Report\n")
    # For ReportFile
    result_dir = "result"
    Common.make_dir("#{result_dir}")                      
    file_name = result_dir + "/connection_" + File.basename("#{@Expect}",".expect") +".summary" 
    if @Golden
      golden_dir = "CCGolden_Example"
      Common.make_dir("#{golden_dir}")                      
      golden = golden_dir + "/" + File.basename("#{@Expect}")
      g = open("#{golden}","w")
    end
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Connection Summary" 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##",$COMMAND)
    
    # filter
    printf("\tmaking product information summary\n")
    f.printf("###############################################\n")
    f.printf("#\n")
    f.printf("# Product information summary\n")
    f.printf("#\n")
    f.printf("###############################################\n")
    f.printf("\n")


    unused_cnt = 0

    @ExpectInf.sort_by{|key,value|
      key
    }.each{|inst_name,value|

      # Tool Limitatin, Multiple Same name instance
      next if @UnChecked.key?("#{inst_name}") == true


      unused_cnt = 0
      value.Modified.each{|a,b|
        b.each{|c|
          if c[1].Flag == false
            unused_cnt += 1
          end
        }
      }
      value.ModifiedPull.each{|a,b|
        b.each{|c|
          if c[1].Flag == false
            unused_cnt += 1
          end
        }
      } 
      value.ModifiedOther.each{|a,b|
        b.each{|c|
          if c[1].Flag == false
            unused_cnt += 1
          end
        }
      }

      err_cnt = 0
      exp_cnt = 0
      none_cnt = 0
      socket_cnt = 0

      error_list = Array.new
      @ERROR_LIST.each{|list|
        tmp = list.DeviceSignal.split(".")
        size = tmp.size
        if inst_name == tmp[size-2]
          error_list << list
        end
      }
      
      # Summary
      error_list.each{|list|
        case list.Type
        when "Device-Only"
          err_cnt += 1
        when "ICE-Only"
          err_cnt += 1
        when "Unmatched", "Unmatched(or Changed Port)"
          err_cnt += 1
        when "Expect"
          exp_cnt += 1
        when "None"
          none_cnt += 1
        when "Removed"
          err_cnt += 1
        when "Socket"
          socket_cnt += 1
        else
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      }
      
      device = 0
      @Rep_DEV.each{|dev_file|
        device +=  GetReportInf.get_inst_inf(inst_name,@DEV_ReportData["#{dev_file}"][0]).size
      }      

      removed_inst = Array.new
      @DeviceInstList.each{|dev_inst_name,value|
        if @ICEInstList.key?("#{dev_inst_name}") == false 
          removed_inst << dev_inst_name
          @DeviceInstList["#{dev_inst_name}"] = "Removed"
        else
          @DeviceInstList["#{dev_inst_name}"] = "Used"
        end
      }

      module_type = nil
      if device == none_cnt
        if inst_name.to_a && removed_inst
          module_type = "Removed"
          tmp = Array.new
          if device != 0
            tmp << device
            tmp << @ICEOnlySignal["#{inst_name}"]
            tmp << err_cnt
            tmp << exp_cnt
            tmp << module_type
            tmp << unused_cnt
            @DeletedList["#{inst_name}"] = tmp
          else
            tmp << device
            tmp << @ICEOnlySignal["#{inst_name}"]
            tmp << err_cnt
            tmp << exp_cnt
            module_type = "UnChecked"
            tmp << module_type
            tmp << unused_cnt
            @ICEOnlyList["#{inst_name}"] = tmp
          end
        else
          module_type = "Modified"
          tmp = Array.new
          tmp << device
          tmp << @ICEOnlySignal["#{inst_name}"]
          tmp << err_cnt
          tmp << exp_cnt
          tmp << module_type
          tmp << unused_cnt
          @ModifiedList["#{inst_name}"] = tmp
        end
      elsif err_cnt == 0 && unused_cnt == 0
        module_type = "Expected"
        tmp = Array.new
        tmp << device
        tmp << @ICEOnlySignal["#{inst_name}"]
        tmp << err_cnt
        tmp << exp_cnt
        tmp << module_type
        tmp << unused_cnt
        @ExpectedList["#{inst_name}"] = tmp
      else
        module_type = "Modified"
        tmp = Array.new
        tmp << device
        tmp << @ICEOnlySignal["#{inst_name}"]
        tmp << err_cnt
        tmp << exp_cnt
        tmp << module_type
        tmp << unused_cnt
        @ModifiedList["#{inst_name}"] = tmp
#      else
#        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
#        exit
      end
      
      err_cnt = 0
      exp_cnt = 0
      none_cnt = 0
    }
    
    total_error_num = 0
    total_unused_expected_num = 0
    @ModifiedList.sort_by{|key|
      key
    }.each{|key,value|
      total_error_num += value[2]
      total_unused_expected_num += value[5]
    }
    f.printf("Final Judgement : ")
    if total_error_num == 0 && total_unused_expected_num == 0
      f.printf("OK ( There is no-modified instances )\n")
    else
      f.printf("NG ( There are modified instances )\n")
      f.printf("   - the number of different connection is %d\n",total_error_num)
      f.printf("   - the number of unused expected connection is %d\n",total_unused_expected_num)
    end
    f.printf("\n")
    

    #
    # Expect
    #
    f.printf("+---+-----------------+-------+-------+-------+-------+-------+-----------+\n")
    f.printf("| No|       Inst name |   all |   ice |   exp | unuse | error | Inst Type |(*)\n")
    f.printf("+---+-----------------+-------+-------+-------+-------+-------+-----------+\n")

    i = 1
    print_flag = false
    @ExpectedList.sort_by{|key|
      key
    }.each{|key,value|     
      print_flag = true
      f.printf("|%3d| %-15s | %5d | %5d | %5d | %5d | %5d | %9s |\n",
               i,
               key,
               value[0],
               value[1],
               value[3],
               value[5],
               value[2],
               value[4]
               )
      i+=1
    }
            

    #
    # Modified
    #
    if print_flag
      f.printf("+---+-----------------+-------+-------+-------+-------+-------+-----------+\n")
      f.printf("| No|       Inst name |   all |   ice |   exp | unuse | error | Inst Type |\n")
      f.printf("+---+-----------------+-------+-------+-------+-------+-------+-----------+\n")
    end
    i = 1
    print_flag = false
    @ModifiedList.sort_by{|key|
      key
    }.each{|key,value|
      print_flag = true
      f.printf("|%3d| %-15s | %5d | %5d | %5d | %5d | %5d | %9s |\n",
               i,
               key,
               value[0],
               value[1],
               value[3],
               value[5],
               value[2],
               value[4]
               )
      i+=1
    }
    

    #
    # Removed
    # 
    if @DeletedList.size != 0
      f.printf("+---+-----------------+-------+-------+-------+-------+-------+-----------+\n") 
      f.printf("| No|       Inst name |   all |   ice |   exp | unuse | error | Inst Type |\n")
      f.printf("+---+-----------------+-------+-------+-------+-------+-------+-----------+\n")
    end

    i = 1
    print_flag = false
    @DeletedList.sort_by{|key|
      key
    }.each{|key,value|
      print_flag = true
      f.printf("|%3d| %-15s | %5d | %5d | %5d | %5d | %5d | %9s |\n",
               i,
               key,
               value[0],
               value[1],
               value[3],
               value[5],
               value[2],
               value[4]
               )
      i+=1
    }


    #
    # UnChecked
    # 
    if @ICEOnlyList.size != 0 || @UnChecked.size != 0
      f.printf("+---+-----------------+-------+-------+-------+-------+-------+-----------+\n") 
      f.printf("| No|       Inst name |   all |   ice |   exp | unuse | error | Inst Type |\n")
      f.printf("+---+-----------------+-------+-------+-------+-------+-------+-----------+\n")
    end

    i = 1
    print_flag = false
    @ICEOnlyList.sort_by{|key|
      key
    }.each{|key,value|
      $WARNING_CNT += 1
      printf("@W: Found Expect-file for \"%s\", but not found about \"%s\" information in device-report.\n",key,key)
      print_flag = true
#      f.printf("|%3d| %-15s | %5d | %5d | %5d | %5d | %5d | %9s |\n",
#               i,
#               key,
#               value[0],
#               value[1],
#               value[3],
#               value[5],
#               value[2],
#               value[4]
#               )
      f.printf("|%3d| %-15s |     - |     - |     - |     - |     - | UnChecked |\n",i,key)
      i+=1
    }

    @UnChecked.sort_by{|key|
      key
    }.each{|key,value|
      f.printf("|%3d| %-15s |     - |     - |     - |     - |     - | UnChecked |\n",i,key)
      i+=1
    }

    # End
    f.printf("+---+-----------------+-------+-------+-------+-------+-------+-----------+\n") 
    f.printf("[(*)Explanation of Table's item ]\n")
    f.printf(" Inst name : Instance Name using target product\n")
    f.printf(" all       : The number of all-connection about Target Instance\n")
    f.printf(" ice       : The number of ice-only connection about Target Instance\n")
    f.printf(" exp       : The number of expected connection under differrent it comparing Device and FPGA-ICE\n")
    f.printf(" unuse     : THe number of Unused Expected Conection\n")
    f.printf(" err       : The number of ERROR connection comparing Device and FPGA-ICE connection\n")
    f.printf(" Inst Type : Instance type after Judgemet(Expected/Modified/Removed)\n")
    f.printf("\n")


    if $LimitedCompare != []
      f.printf("\n[Limited Compare] Cannot compare connection because direction mismatch between Device and ICE\n\n")
      $LimitedCompare.each do |path|
        f.printf(" - %s\n",path)
      end
      f.printf("\n")
    end
    

    @ExpectInf.sort_by{|key,value|
      key
    }.each{|key,value|
      
      next if @DeviceInstList["#{key}"] != "Used"

      if @Golden
        g.printf("####################################################\n")
        g.printf("#\n")
        g.printf("# Expect file for %s(%s)\n",key,@ModuleInf["#{key}"])
        g.printf("#\n")
        g.printf("####################################################\n")
        g.printf("\n")
        g.printf("I:%s %s\n",key,@ModuleInf["#{key}"]) 
      end
      
      error_list = Array.new
      @ERROR_LIST.each{|list|
        tmp = list.DeviceSignal.split(".")
        size = tmp.size
        if key == tmp[size-2]
          error_list << list
        end
      }
      # Summary
      err_cnt = 0
      exp_cnt = 0
      none_cnt = 0
      socket_cnt = 0
      error_list.each{|list|
        case list.Type
        when "Device-Only"
          err_cnt += 1
        when "ICE-Only"
          err_cnt += 1
        when "Unmatched", "Unmatched(or Changed Port)"
          err_cnt += 1
        when "Expect"
          exp_cnt += 1
        when "None"
          none_cnt += 1
#          p list
        when "Removed"
          err_cnt += 1
        when "Socket"
          socket_cnt += 1
        else
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      }

      printf("\t%s summary\n",key)
      f.printf("###############################################\n")
      f.printf("#\n")
      f.printf("# %s\n",key)
      f.printf("#\n")
      f.printf("###############################################\n")
      f.printf("\n")

      # Unchecked
      if @UnChecked.key?("#{key}") == true
        f.printf("Unchecked insance. Because multiple instances in Device-report\n\n")
        next
      end

      f.printf("# summary\n")
      device = 0
      @Rep_DEV.each{|dev_file|
        device +=  GetReportInf.get_inst_inf(key,@DEV_ReportData["#{dev_file}"][0]).size
      }
#      f.printf("The number of connection for %s are %d, ( + ICE Only Pin: %d )\n",key,(GetReportInf.get_inst_inf(key,@DEV_ReportData["#{@Rep_DEV}"][0]).size),@ICEOnlySignal["#{key}"])
      f.printf("The number of connection for %s are %d, ( + ICE Only Pin: %d )\n",key,device,@ICEOnlySignal["#{key}"])
      f.printf("   Error Connection    : %d\n",err_cnt)
      f.printf("   Expected Connection : %d\n",exp_cnt)
      f.printf("\n")
      if @DeviceInstList["#{key}"] == "Used"
        if @ICEOnlyPortList["#{key}"] != nil
          f.printf("ICE Only Port List\n")
          tmp = @ICEOnlyPortList["#{key}"].sort 
          tmp.each{|list|
            f.printf("   - %s\n",list)
          }
          f.printf("\n")
        end
        if @DeviceOnlyPortList["#{key}"] != nil
          f.printf("Device Only Port List\n")
          tmp = @DeviceOnlyPortList["#{key}"].sort
          tmp.each{|list|
            f.printf("   - %s\n",list)
          }
          f.printf("\n")
        end
      end
      if @DeviceInstList["#{key}"] == "Used"
        # Connection Detail
        f.printf("# Different Connection detail for each signals\n")
        if error_list.size == 0
          f.printf("\nNONE\n\n")
        end
        
        print_flag = false
        # Expected
        error_list.sort_by{|a|
          a.DeviceSignal
        }.each{|list|
          case list.Type
          when "Expect"
            print_flag = true
            if list.Direction == "IN"
              f.printf("%-40s <- %-40s # Expected\n",list.Dest,list.Source) if list.ICEOnlyFlag == false
            elsif list.Direction == "OUT"
              f.printf("%-40s -> %-40s # Expected\n",list.Source,list.Dest) if list.ICEOnlyFlag == false
            else
              printf("@internal error %s\n",list)
              exit
            end
          end
        }
        f.printf("\n")
        print_flag = false

        # Expected(ICE-Only)
        error_list.sort_by{|a|
          a.DeviceSignal
        }.each{|list|
          case list.Type
          when "Expect"
            print_flag = true
            if list.Direction == "IN"
              f.printf("%-40s <- %-40s # Expected(ICE-Only Pin)\n",list.Dest,list.Source) if list.ICEOnlyFlag == true
            elsif list.Direction == "OUT"
              f.printf("%-40s -> %-40s # Expected(ICE-Only Pin)\n",list.Source,list.Dest) if list.ICEOnlyFlag == true
            else
              printf("@internal error %s\n",list)
              exit              
            end
          end
        }
        f.printf("\n") if print_flag
        
        # For Device-Only/Unmatched
        error_list.sort_by{|a|
          a.DeviceSignal
        }.each{|list|
          case list.Type
          when "Unmatched"
            print_flag = true
            if list.Direction == "IN"
              f.printf("%-40s <- %-40s # Unmatched\n",list.Dest,list.Source)
              dest = nil
              source = nil 
              tmp = list.Dest.split(".")
              if tmp.size > 1
                dest = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                dest = list.Dest
              end
              tmp = list.Source.split(".")
              if tmp.size > 1
                source = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                source = list.Source
              end
              g.printf("M:%-40s <- %-40s\n",dest,source) if @Golden
            elsif list.Direction == "OUT"
              f.printf("%-40s -> %-40s # Unmatched\n",list.Source,list.Dest)
              dest = nil
              source = nil 
              tmp = list.Dest.split(".")
              if tmp.size > 1
                dest = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                dest = list.Dest
              end
              tmp = list.Source.split(".")
              if tmp.size > 1
                source = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                source = list.Source
              end
              g.printf("M:%-40s -> %-40s\n",source,dest) if @Golden
            end
          when "Unmatched(or Changed Port)"
            print_flag = true
            if list.Direction == "IN"
              f.printf("%-40s <- %-40s # Unmatched(or Changed Port)\n",list.Dest,list.Source)
              dest = nil
              source = nil 
              tmp = list.Dest.split(".")
              if tmp.size > 1
                dest = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                dest = list.Dest
              end
              tmp = list.Source.split(".")
              if tmp.size > 1
                source = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                source = list.Source
              end
              g.printf("M:%-40s <- %-40s\n",dest,source) if @Golden
            elsif list.Direction == "OUT"
              f.printf("%-40s -> %-40s # Unmatched(or Changed Port)\n",list.Source,list.Dest)
              dest = nil
              source = nil 
              tmp = list.Dest.split(".")
              if tmp.size > 1
                dest = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                dest = list.Dest
              end
              tmp = list.Source.split(".")
              if tmp.size > 1
                source = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                source = list.Source
              end
              g.printf("M:%-40s -> %-40s\n",source,dest) if @Golden
            end
        end
        }   
        
        # For Device-Only/Unmatched
        error_list.sort_by{|a|
          a.DeviceSignal
        }.each{|list|
          case list.Type
          when "Device-Only"
            f.printf("%-40s                                             # Device-Only Pin\n",list.DeviceSignal)
          when "ICE-Only"
            print_flag = true
            if list.Direction == "IN"
              f.printf("%-40s <- %-40s # Unmatched(ICE-Only Pin)\n",list.Dest,list.Source)
              dest = nil
              source = nil 
              tmp = list.Dest.split(".")
              if tmp.size > 1
                dest = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                dest = list.Dest
              end
              tmp = list.Source.split(".")
              if tmp.size > 1
                source = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                source = list.Source
              end
              g.printf("M:%-40s <- %-40s\n",dest,source) if @Golden
            elsif list.Direction == "OUT"
              f.printf("%-40s -> %-40s # Unmatched(ICE-Only Pin)\n",list.Source,list.Dest)
              dest = nil
              source = nil 
              tmp = list.Dest.split(".")
              if tmp.size > 1
                dest = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                dest = list.Dest
              end
              tmp = list.Source.split(".")
              if tmp.size > 1
                source = tmp[tmp.size-2] + "." + tmp[tmp.size-1]
              else
                source = list.Source
              end
              g.printf("M:%-40s -> %-40s\n",source,dest) if @Golden
            end

        end
        }   
        f.printf("\n")

      else
        f.printf("Removed Instance\n\n")
      end

      f.printf("# Unused Expected Connection\n")
      unused_flag = false
      if value != nil
        value.Modified.each{|a,b|
          b.each{|c|
            if c[1].Flag == false
              f.printf("[%s:%3d]%s\n",c[1].ExpectFile,c[1].No,c[1].Line)
              unused_flag = true            
            end
          }
        }
        value.ModifiedPull.each{|a,b|
          b.each{|c|
            if c[1].Flag == false
              f.printf("[%s:%3d]%s\n",c[1].ExpectFile,c[1].No,c[1].Line)
              unused_flag = true            
            end
          }
        } 
        value.ModifiedOther.each{|a,b|
          b.each{|c|
            if c[1].Flag == false
              f.printf("[%s:%3d]%s\n",c[1].ExpectFile,c[1].No,c[1].Line)
              unused_flag = true            
            end
          }
        }
      end 
      f.printf("   NONE\n") if unused_flag == false
      f.printf("\n")

      if @Golden
        g.printf("E\n")
        g.printf("\n\n")
      end
    }
    f.close
    g.close if @Golden
  end


  def judge_operation(inst_pin_name,dev_connect_inf,num=0)
    if @OperationFlag == false
      printf("\n")
      printf("%d\n",num)
      printf("%s\n",inst_pin_name)
      printf("%s\n",dev_connect_inf)
      dev_connect_inf.OUT.each{|out_sig|
        printf("     <- [%s]\n",out_sig)
      }
      dev_connect_inf.IN.each{|in_sig|
        printf("     -> [%s]\n",in_sig)
      }
      printf("or, The report file that you specified was wrong. please check report file\n")
      $INTERNAL_ERROR_CNT += 1
      Common.internal_error(__FILE__,__LINE__)
      exit
    end
  end
  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    # Ruby Version Judgment
    if RUBY_VERSION < "1.9"
      printf("@E:%s only support Ruby ver : 1.8.X ( Now, executed %s )\n",$SUB_TOOL,RUBY_VERSION)
      printf("   please check your ruby execute setting.")
      $ERROR_CNT += 1
      Common.print_summary
      exit
    end

    Common.print_base
    get_argument
    make_FileList
    get_ice_hier
    get_expect
    get_report_data
    compare
    generate_error_report
    Common.print_summary
  end

  public
  def run
    make_FileList
    get_ice_hier
    get_expect
    get_report_data
    compare
    generate_error_report
  end
  
end


if __FILE__ == $0
  chk = ConnectChecker.new
  chk.main
end
