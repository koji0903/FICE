#!/usr/bin/ruby
#############################################################
#
#=mkPin : generate Pin-related files(Verilog,SDC,UCF,para)
#  
#Authors::   Koji HIJIKURO<koji.hijikuro.rj@rms.renesas.com>
#Copyright:: Copyright (c) 2009,2010 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
#===Function detail
#* Analyze CT-IO Pin information.
#* Generate Pin-related files
#  * Verilog-HDL : Fixed-Output signals
#  * SDC         : Pin Loacation constraints for synthesis
#  * UCF         : Pin volatage constraints for P&R
#  * PARA        : make_chip addtional information
#
#===Usage
#%ruby mkPin.rb --pin Pin-File --pull Pull-File
#  If you want to get more information. plese use "--help" option.
#  Pin-File(CSV)  : CT-IO Pin inforamtion
#  Pull-File(CSV) : Pulldown/Pullup defined information
#
#===EXAMPLE
#%ruby mkPin.rb -port CN1-5.csv -pull Pullup.csv
#
#===Output Files
# * .v
# * .sdc
# * .ucf
# * .para
#
#===History
#* Please see the RedMine Project Web Page<http://nqjpc147:1030/redmine>
#
#############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"
require "optparse"
#require "fileutils"
require "getCSV"
require "pp"

#
# Global Setting
#
$SUB_TOOL        = "mkPin" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION # For OptParse
$TEST_MODE = false

$KCODE = "SJIS"

#
# Main Class
#
class MkPin
  
  def initialize
    # Port Infomation from Option
    @PortFile = nil
    # Pulldown/Pullup Infomation from Option
    @PullFile = nil
    # CT Informatin from Option
    @CTFile = nil

    # File Detail from PortFile
    @PortFileInf = nil
    # File Detail from PullFile
    @PullFileInf = nil
    # File Detail from CTFile
    @CTFileInf = nil

    # Header Data of Port CSV
    @HeaderInf = nil 
    # Port Data of Port CSV
    @PortInf = nil
    # Pull Data of Pull CSV
    @PullInf = nil  
    # CT Data of CT CSV
    @CTInf = nil

    @OutDir = "."

    # Verilog
    @HDL_file_name = nil # Output Verilog file name

    @PUCTL_module = "ierl78puctl7v1"

    @PIO = Array.new
    @PORTEN = Array.new
    @PTTL = Array.new
  end

  #
  # Print Base Information( Tool name, Version, Copyright )
  #
  private
  def print_base
    print <<EOB
#{$TOOL}(#{$SUB_TOOL}) ver:#{Version}
Copyright (c) 2009,2010 NEC MicroSystem. All rights reserved.
EOB
  end
  

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  public
  def get_argument
    opt = OptionParser.new
    begin
      opt.on('--verbose',"verbose mode"){|v| $VERBOSE = true}
      opt.on('--port Pin-inf','pin information at CVS'){|v| @PortFile = v}
      opt.on('--pull PullDown/PullUp inf','pulldown/pullup information at CVS'){|v| @PullFile = v}
      opt.on('--ct CT inf','CT Port Setting information at CVS'){|v| @CTFile = v}
      opt.on('--outdir DirName','file output directory name'){|v| @OutDir = v}
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:"#{$!}" 
EOB
      exit
      return false
    end

    #  - Port File("--port") dont have to need generating files.
    #    If speciefd, add this infomation in files.
    if @PortFile == nil
      $ERROR_CNT += 1
      printf("@E:Not find \"--port\" option for Port Information CSV\n")      
      Common.print_summary
      exit
    else
      # Get file detail information
      @PortFileInf = File::stat("#{@PortFile}")
    end

    #  - Pull File("--pull") dont have to need generating files.
    #    If speciefd, add this infomation in files.
    if @PullFile == nil
      $WARNING_CNT += 1
      printf("@W:Not find \"-pull\" option for Pull Information CSV\n")      
    else
      # Get file detail information
      @PullFileInf = File::stat("#{@PullFile}")
    end

    #  - CT File("--ct") dont have to need generating files.
    #    If speciefd, add this infomation in files.
    if @CTFile == nil
      $WARNING_CNT += 1
      printf("@W:Not find \"--ct\" option for Port Information CSV\n")      
    else
      # Get file detail information
      @CTFileInf = File::stat("#{@CTFile}")
    end

    return true
  end

  #
  # Generate Expect File for each Instance
  #
  def generate_Expect(connect)
    out_dir = @OutDir + "/expect"
    Common.make_dir_with_delete(out_dir)
    inst_list = Array.new

    # Get Instance Name for Expect File Name
    connect.each do |line|
      # Get Source Instance Name
      src_inst_tmp = line.split[0]
      src_inst_tmp2 = src_inst_tmp.split(".")
      src_inst_tmp2.pop
      src_inst_name = src_inst_tmp2.join(".")
      inst_list << src_inst_name
    end
    inst_list.uniq!

    # Generate Expect File
    inst_list.each do |inst|
      file = out_dir + "/" + inst + ".expect"
      printf("@I:generate Expect file(%s)\n",file)
      f = open(file,"w")
#      comment = "Common Expect File for #{inst}" 
#      Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
      time = Time.now.strftime("%Y-%m-%d")

      # get PTTL Infotmation
      /port(\d+)_iobuf\.iobuf(\d+)/ =~ inst
      ttl = nil
      unless $1.nil? || $2.nil?
        ttl = "PTTL#{$1}#{$2}"
      end

      f.print <<EOB
#######################################################################
##
## Expect File
##  Target Instance : #{inst}
##
#######################################################################
## [History]
## #{time} : Automatically generated by #{$SUB_TOOL} ver #{$VERSION}
#######################################################################

EOB
      str_size = 0
      connect_each = Array.new
      connect.each do |line|
        # Get Source Instance Name
        src_inst_tmp = line.split[0]
        src_inst_tmp2 = src_inst_tmp.split(".")
        src_inst_tmp2.pop
        src_inst_name = src_inst_tmp2.join(".")

        if src_inst_name == inst
          if str_size < src_inst_tmp.size
            str_size = src_inst_tmp.size + 3
          end
          connect_each << line
#          f.printf "#{line.gsub("\s","\t")}\n"
        end
      end
      connect_each.each do |line|
        f.printf "%-#{str_size}s %s   %s\n",line.split[0],line.split[1],line.split[2]
      end
      unless ttl.nil? || @PTTL.index(ttl).nil?
        str = inst + ".PTTL"
        f.printf "%-#{str_size}s <-   %s",str,ttl
      end
      f.close
    end
    
    # for iePortControl
    inst = "iePortControl"
    file = out_dir + "/" + inst + ".expect"
    f = open(file,"w")
    time = Time.now.strftime("%Y-%m-%d")
    
    f.print <<EOB
#######################################################################
##
## Expect File
##  Target Instance : #{inst}
##
#######################################################################
## [History]
## #{time} : Automatically generated by #{$SUB_TOOL} ver #{$VERSION}
#######################################################################

EOB
    f.printf "# PIO\n"
    @PIO.sort.each do |name|
      f.printf("%s.%s\t->\t%s\n",inst,name,name)
    end
    f.printf "\n"
    f.printf "# PORTEN_Bxx\n"
    @PORTEN.sort.each do |name|
      f.printf("%s.%s\t->\t%s\n",inst,name,name)
    end

    f.close
    
    printf "Total related mkPin Connection is #{connect.size+@PIO.size+@PORTEN.size+@PTTL.size}\n"
  end
  
  #
  # Operation
  #  Read Each CSV Information and SAVE local data
  #
  def operation
    get_csv = GetCSV.new
    # Read Port Information file
    @HeaderInf, @PortInf = get_csv.reader_CN(@PortFile) if @PortFile != nil
    # Read Pull Informatin file
    @PullInf = get_csv.reader_PULL(@PullFile) if @PullFile != nil
    # Read CT Information
    @CTInf = get_csv.reader_CT(@CTFile) if @CTFile != nil
  end


  #
  # Generate
  # * genrate each files(SDC/UCF/HDL/PARA)
  #
  def generate
    # Generate File
    generate_SDC
    generate_UCF
    generate_HDL
    connect = Array.new
    connect = generate_FixedPin_CON(connect)
#    generate_PARA
    connect = generate_PUCTL_CON(connect)
    # generate Expect
    generate_Expect(connect)

  end

  private
  #
  # Print File Detail
  #* Output message of file details
  #  * f         :: file pointer 
  #  * delimiter :: comment delimiter
  #  * return    :: nil
  def print_file_detail(f,delimiter="#")
    f.printf("%s [File information]\n",delimiter)
    if @PortFile != nil
      f.printf("%s Port File : %s (%s)\n",delimiter,@PortFile,@PortFileInf.mtime)
    else
      f.printf("%s Port File : Not Use\n")
    end
    if @PullFile != nil
      f.printf("%s Pull File : %s (%s)\n",delimiter,@PullFile,@PullFileInf.mtime)
    else
      f.printf("%s Pull File : Not Use\n")
    end
    if @CTFile != nil
      f.printf("%s CT   File : %s (%s)\n",delimiter,@CTFile,@CTFileInf.mtime)
    else
      f.printf("%s CT   File : Not Use\n",delimiter)
    end
  end

  public
  #
  # generate_SDC
  #  SDC file for Synplify Pro Synthesis
  #  Using PortFile Inf & CTFile Inf
  #
  def generate_SDC

    if @HeaderInf !=  nil
      file_name = @OutDir + "/" + @HeaderInf.ProductName + "_pin.sdc"
    else
      file_name = "Pin.sdc"  
    end
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    if @HeaderInf != nil
      comment = "Pin Constraint for " + @HeaderInf.ProductName 
    else
      comment = "Pin Constraint"
    end
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
    print_file_detail(f)

    #
    # Port File Information
    #
    f.printf("\n\n### From Port File(%s) ###\n",@PortFile)
    # calucurate number
    pin_loc_size = 0
    pin_pull_size = 0
    @PortInf.each{|data| pin_loc_size += 1 if data.PinLocAttribute != nil} if @PortInf != nil
    @PortInf.each{|data| pin_pull_size += 1 if data.PinPullAttribute != nil} if @PortInf != nil
    f.printf("\n")
    f.printf("# Total number of Pin-Location is %4d\n",pin_loc_size)
    f.printf("# Total number of Pin-Pulldown is %4d\n",pin_pull_size)
    f.printf("\n")
    f.printf("# Pin Location\n")
    pin_loc = Array.new
    @PortInf.each{|data|
      if data.PinLocAttribute != nil
        # for iePortControl
        @PIO << $1 if /(PIO\d+)/ =~ data.PinLocAttribute.strip
        @PORTEN << $1 if /(PORTEN_B\d+)/ =~ data.PinLocAttribute.strip
        @PTTL << $1 if /(PTTL\d+)/ =~ data.PinLocAttribute.strip

        f.printf("%-50s # %s, FPGA-Pin:%s (O-%4d)\n",
                 data.PinLocAttribute.strip,
                 data.ConnectorNo,
                 data.PinNo,
                 data.Row)
=begin
        f.printf("%-50s\n",
                 data.PinLocAttribute.strip)
=end
        /\{(.*)\}\s*xc_loc\s*\{(.*)\};/ =~ data.PinLocAttribute.strip
        if $1 != nil
          pin = $1
          if pin_loc.index(pin) != nil
            $ERROR_CNT += 1
            pin = pin.sub("p:","")
            printf("@E:Found duplicate FPGA Terminal(%s). Pleace check Excel File.\n",pin)
          else
            pin_loc << pin
          end
        end
      end
    } if @PortInf != nil
    f.printf("\n\n")
    f.printf("# Pin Fix\n")
    @PortInf.each{|data|
      f.printf("%-50s # %s, FPGA-Pin:%s (P-%4d)\n",
               data.PinPullAttribute.strip,
               data.ConnectorNo,
               data.PinNo,
               data.Row) if data.PinPullAttribute != nil
=begin
      f.printf("%-50s\n",
               data.PinPullAttribute.strip) if data.PinPullAttribute != nil
=end
    } if @PortInf != nil

    #
    # CT File Information
    # 
    if @CTFile != nil
      f.printf("\n\n### From CT File(%s) ###\n",@CTFile)
      pin_loc_size = 0
      pin_pull_size = 0
      buffer_speed_size = 0
      if @CTInf != nil
        @CTInf.each{|data| pin_loc_size += 1 if data.PinLocAttribute != nil}
        @CTInf.each{|data| pin_pull_size += 1 if data.PinPullAttribute != nil}
        @CTInf.each{|data| buffer_speed_size += 1 if data.SDCBufferSpeed != nil}
      end
      f.printf("\n")
      f.printf("# Total number of Pin-Location is %4d\n",pin_loc_size)
      f.printf("# Total number of Pin-Pulldown is %4d\n",pin_pull_size)
      f.printf("# Total number of Buffer-Speed is %4d\n",buffer_speed_size)
      f.printf("\n")
      f.printf("# Pin Location\n")
      @CTInf.each{|data|
        f.printf("%-50s\n",
                 data.PinLocAttribute.strip
                 ) if data.PinLocAttribute != nil
      }
      f.printf("\n\n")
      f.printf("# Pin Fix\n")
      @CTInf.each{|data|
        f.printf("%-50s\n",
                 data.PinPullAttribute.strip
                 ) if data.PinPullAttribute != nil
      }
      f.printf("\n\n")
      f.printf("# Buffer Speed\n")
      @CTInf.each{|data|
        f.printf("%-50s\n",
                 data.SDCBufferSpeed.strip
                 ) if data.SDCBufferSpeed != nil
      }
    end
    f.close
  end


  #
  # generate_UCF
  #
  def generate_UCF
    if @HeaderInf.ProductName != nil
      file_name =  @OutDir + "/" + @HeaderInf.ProductName + "_buffer.ucf"
    else
      file_name = "Buffer.ucf" 
    end
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    if @HeaderInf.ProductName != nil
      comment = "FPGA-Buffer Setting for " + @HeaderInf.ProductName 
    else
      comment = "FPGA-Buffer Setting for " + @HeaderInf.ProductName 
    end
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
    print_file_detail(f)
    f.printf("\n")
    f.printf("\n\n### From Port File(%s) ###\n",@PortFile)
    @PortInf.each{|data|
      f.printf("%-50s # %s, FPGA-Pin:%s (P-%4d)\n",
               data.UCFBufferType.strip,
               data.ConnectorNo,
               data.PinNo,
               data.Row) if data.UCFBufferType != nil
    }
=begin
    @PortInf.each{|data|
      f.printf("%-50s\n",
               data.UCFBufferType.strip) if data.UCFBufferType != nil
      }
=end
    if @CTFile != nil
      f.printf("\n\n### From CT File(%s) ###\n",@CTFile)
      f.printf("\n# Voltage\n")
      @CTInf.each{|data|
        f.printf("%-50s\n",
                 data.UCFBufferType.strip
                 ) if data.UCFBufferType != nil
      }
      f.printf("\n# Driver Strength\n")
      @CTInf.each{|data|
        f.printf("%-50s\n",
                 data.UCFDriverStrength.strip
                 ) if data.UCFDriverStrength != nil
      }
    end
    f.close
  end

  #
  # generate_HDL
  #
  def generate_HDL
    @HDL_file_name =  @OutDir + "/" + @HeaderInf.ProductName + "_FixedPin.v"
    module_name = @HeaderInf.ProductName + "_FixedPin" 
    printf("@I:generate %s\n",@HDL_file_name)
    f = open("#{@HDL_file_name}","w")
    comment = "Fixed Pin module for " + @HeaderInf.ProductName 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"\/\/")
    print_file_detail(f,"\/\/")
    f.printf("\n")
    f.printf("module %s (\n",module_name)
    # print terminal
    port_inf = Array.new
    @PortInf.each{|data|
      port_inf << data if data.FixedVerilog != nil
    }
    # Separete 
    if @CTInf == nil
      for i in 0..(port_inf.size-2)
        f.printf("\t\t%s,\n",port_inf[i].FixedVerilog.split[1])
      end
      f.printf("\t\t%s\n",port_inf[port_inf.size-1].FixedVerilog.split[1])
    else
      # for Port
      f.printf("\t\t\/\/ from %s\n",@PortFile)
      for i in 0..(port_inf.size-1)
        f.printf("\t\t%s,\n",port_inf[i].FixedVerilog.split[1])
      end
      # for CT
      ct_inf = Array.new
      @CTInf.each{|data|
        ct_inf << data if data.FixedVerilog != nil
      }
      f.printf("\t\t\/\/ from %s\n",@CTFile)
      for i in 0..(ct_inf.size-2)
        f.printf("\t\t%s,\n",ct_inf[i].FixedVerilog.split[1])
      end
      f.printf("\t\t%s\n",ct_inf[ct_inf.size-1].FixedVerilog.split[1])
    end
    f.printf("\t);\n",module_name)
    f.printf("\n")
    # print output definition
    f.printf("\t\/\/ from %s\n",@PortFile)
    port_inf.each{|data|
      f.printf("\toutput %s;\n",data.FixedVerilog.split[1])
      f.printf("\t%s\n\n",data.FixedVerilog)
    }
    if @CTInf != nil
      f.printf("\t\/\/ from %s\n",@CTFile)
      ct_inf.each{|data|
        f.printf("\toutput %s;\n",data.FixedVerilog.split[1])
        f.printf("\t%s\n\n",data.FixedVerilog)
      }
    end
    f.printf("\n")
    f.printf("endmodule\n")
    f.close
  end

  #
  # generate_CON
  #
  def generate_FixedPin_CON(connect)
    @CON_file_name =  @OutDir + "/" + @HeaderInf.ProductName + "_FixedPin.con"
    fixed_module = @HeaderInf.ProductName + "_FixedPin"
    printf("@I:generate %s\n",@CON_file_name)
    f = open("#{@CON_file_name}","w")
    comment = "Fixed Pin ConnectFile for " + @HeaderInf.ProductName 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"#")
    print_file_detail(f,"#")
    f.printf("\n")
    # print terminal
    port_inf = Array.new
    @PortInf.each{|data|
      port_inf << data if data.FixedVerilog != nil
    }
    f.printf("# From CN1-5 Sheet\n")
    port_inf.each do |pin|
#      pin_name = pin.FPGASignal
      f.printf("%s\n",pin.PinsInf.sub(" ","\t"))
      connect << "#{fixed_module}.#{pin.PinsInf.split[0]} -> #{pin.PinsInf.split[1].gsub(":terminal","")}"
    end
    f.printf("\n# From CT4 Sheet\n")
    @CTInf.each do |data|
      next if data.ConInf == nil
      f.printf("%s\n",data.ConInf.sub(" ","\t"))
      connect << "#{fixed_module}.#{data.ConInf.split[0]} -> #{data.ConInf.split[1].gsub(":terminal","")}"
    end
    f.printf("\n")
    f.printf("# END of Connect File\n")
    return connect
  end

  #
  # generate_PUCTL_CON
  #
  def generate_PUCTL_CON(connect)
    @CON_file_name =  @OutDir + "/" + @HeaderInf.ProductName + "_PUCTL.con"
    printf("@I:generate %s\n",@CON_file_name)
    f = open("#{@CON_file_name}","w")
    comment = "Puctl(ierl78puctl7v1) ConnectFile for " + @HeaderInf.ProductName 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"#")
    print_file_detail(f,"#")
    f.printf("\n")
    # Reserved Connect
    f.printf("# Reserved Connection\n")
    f.printf("CLK60MHZ\tice.CLK60MHZ\n")
    connect << "#{@PUCTL_module}.CLK60MHZ <- ice.CLK60MHZ"
    f.printf("CPURSOUTB\tice.SYSRSOUTB\n")
    connect << "#{@PUCTL_module}.CPURSOUTB <- ice.SYSRSOUTB"
    f.printf("\n")
    @PullInf.each do |data|
      next if data.PullControl == nil
      f.printf("%s\n",data.PullControl.gsub(" ","\t"))
      connect << "#{@PUCTL_module}.#{data.PullControl.split[0]} <- #{data.PullControl.split[1]}"
      if /PUONOUT/ =~ data.PullControl
        connect << "#{data.PullControl.split[1]} -> #{@PUCTL_module}.#{data.PullControl.split[0]}"
      end
    end

    f.printf("\n")
    f.printf("# PPUP Connect Information\n")
    @PortInf.each do |inf|
      if inf.PinLocAttribute != nil && ( /^PPUP/ =~ inf.FPGASignal || /^PUPLE/ =~ inf.FPGASignal )
        f.printf("%s\t%s:terminal\n",inf.FPGASignal,inf.FPGASignal)
        connect << "#{@PUCTL_module}.#{inf.FPGASignal} -> #{inf.FPGASignal}"
      end
    end

    f.printf("\n")
    f.printf("# END of Connect File\n")
    f.close
    return connect
  end

  #
  # generate_PARA
  #
  def generate_PARA
    file_name =  @OutDir + "/" + @HeaderInf.ProductName + "_FixedPin.para" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Fixed Pin module for " + @HeaderInf.ProductName 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"\/\/")
    f.printf("\n")
    print_file_detail(f,"\/\/")
    f.printf("\n")
    f.printf("INCLUDE_FILE: %s %s\n\n",@HeaderInf.ProductName,@HeaderInf.Version)
    f.printf("\/\/ HDL for Fixed signals\n")
    f.printf("INS: FIXPIN %s_FixedPin TYPE SOFT\n",@HeaderInf.ProductName)
    f.printf("\tMACRO: VERILOG_HDL ${%sMACRO_PATH}/%s\n",@HeaderInf.ProductName,@HDL_file_name)
    f.printf("END_INS:\n")
    f.printf("\n")
    f.printf("\/\/ Pins for Fixed signals macro\n")
    f.printf("\n")
    # print terminal
    # print Pin
    f.printf("\/\/ from %s\n",@PortFile)
    @PortInf.each{|data|
      if data.PinsInf != nil
        f.printf("PIN: %s\n",data.PinsInf)
        f.printf("END_PIN:\n\n")
      end
    }
    f.printf("\n")
    f.printf("\n")
    f.printf("\/\/ Connection for puctl\n")
    if @PullInf != nil
      f.printf("\/\/ from %s\n",@PullFile)
      @PullInf.each{|data|
        f.printf("%s\n",data.PullControl)
      }
    end
    f.printf("\n")
    if @CTInf != nil
      f.printf("\/\/ from %s\n",@CTFile)
      @CTInf.each{|data|
        if data.PinsInf != nil
          f.printf("PIN: %s\n",data.PinsInf)
          f.printf("END_PIN:\n\n")
        end
      }
    end
    
    f.printf("\n")
    f.printf("END_INCLUDE_FILE:\n")

    f.close
  end

  #
  # Main Function
  #  1. Print Base Message
  #  2. Get Exected Argument
  #  3. Operation(read CSV data)
  #  4. Generate each files
  #  5. Print Summary Message
  #
  public
  def main
    Common.print_base
    # Ruby Version Judgment
    if RUBY_VERSION > "1.9"
      printf("@E:%s only support Ruby ver : 1.8.X ( Now, executed %s )\n",$SUB_TOOL,RUBY_VERSION)
      printf("   please check your ruby execute setting.")
      $ERROR_CNT += 1
      Common.print_summary
      exit
    end

    get_argument
    if @OutDir != "."
      Common.make_dir(@OutDir)
    end
    operation

    # print Header Information
    printf "[CSV Header Information]\n"
    printf " - ProductName : #{@HeaderInf.ProductName}\n"
    printf " - Version     : #{@HeaderInf.Version}\n"


    @OutDir = @OutDir + "/" + @HeaderInf.Version
    Common.make_dir(@OutDir)

    generate


    Common.print_summary
  end
  
end


#
# Execute
#
if __FILE__ == $0
  mkpin = MkPin.new
  mkpin.main
end
