#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-

#############################################################
#
#=PinChecker
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
#===Function
#* Check SDC Pin Location and HDL Port List
#
#===Usage
#* %ruby PinChecker.rb --pin Pin file --hdl Verilog File [--ct CT File]
#  * If you want to get more information. plese use "--help" option.
#
#===EXAMPLE
#* %ruby PinChecker.rb -port CN1-5.csv -hdl eva_top.v
#
#===Output
#* result
#
#===History
#* history
#
#############################################################
$GEM_HOME_PATH = "/home/product/div-micom-ice/data/proj/RL78/Common/local/gems/1.8"
ENV["GEM_HOME"] = $GEM_HOME_PATH
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"
require "optparse"
require "getCSV"
require "verilog"

#
# Global Setting
#
$SUB_TOOL        = "PinChecker" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION # For OptParse
$TEST_MODE = false


#
# Main Class
#
class PinChecker
  ICE_COMMON_FILE = File.dirname(__FILE__) + "/../conf/ICECommonSignal.lst"

  def initialize
    # from Option
    @PortFile = nil
    @HDLFile = nil
    @XMLFile = nil
    @CTFile = nil
    @SDCFile = nil
    @TopModuleName = "EVA_TOP"
    # FileInformation
    @PortFileInf = nil
    @HDLFileInf = nil
    @CTFileInf = nil
    # CSV Data
    @CSV_PortInf = Array.new   # from Port CSV
    @CSV_signal = Array.new
    @CT_PortInf = Array.new
    # Verilog
    # HDL Data
    @HDL_PortInf = Array.new
    # ICE Common Signal List from Conf
    @ICECommonSignal = Array.new
    # ICE Common Signal List from CT
    @ICECommonSignal_CT = Array.new

    @IgnoredPin = Array.new
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
  # read_ICECommon
  #  If "-ct" option was described, Use CT File
  #  Otherelse, Use ICE_COMMON_FILE save in conf directory
  #
  def read_ICECommon
    # ICE_COMMON_FILE
    if @CTFile == nil
      ice_common_data = Common.file_read("#{ICE_COMMON_FILE}")
      ice_common_data.each{|line|
        if line[0] != 35 && line.size != 0 # Comment Line
          @ICECommonSignal << line.split[0].strip
        end
      }
      @ICECommonSignal.uniq.compact
    else
      # "-ct" option
      get_csv = GetCSV.new
      @CT_PortInf = get_csv.reader_CT(@CTFile)
      @CT_PortInf.each{|data|
        # get Pin Name
        if data.FPGASignal != nil
          @ICECommonSignal_CT << data.FPGASignal
        end
      }

    end
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
      opt.on('--port Pin-inf','pin information at CSV'){|v| @PortFile = v}
      opt.on('--ct CT file','CT information file at CSV'){|v| @CTFile = v}
      opt.on('--sdc SDC file','SDC File'){|v| @SDCFile = v}
      opt.on('--hdl Verilog HDL','Top Module Verilog HDL'){|v| @HDLFile = v}
      opt.on('--xml XML File','Top Module Verilog XML'){|v| @XMLFile = v}
      opt.on('--module ModuleName','Top Modoule Name'){|v| @TopModuleName = v}
      opt.on('--ignore PinName','Ignore comparing Pin Name'){|v| @IgnoredPin = v.split(",")}
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:"#{$!}" 
EOB
      return false
    end

    # Error Check
    #  - Port File("-port") have to  need generating files.
    if @PortFile == nil && @SDCFile == nil
      $ERROR_CNT += 1
      printf("@E:You must specify \"--port\" or \"--sdc\" option for Port Information CSV\n")
      Common.print_summary
      exit 1
    else
      # Get file detail information
      if @PortFile != nil
        if FileTest.readable?(@PortFile)
          @PortFileInf = File::stat("#{@PortFile}") 
        else
          $ERROR_CNT += 1
          printf "@E:Cannot read \"#{@PortFile}\". Please Check File.\n"
          Common.print_summary
          exit 1
        end
      end
      if @SDCFile != nil
        if FileTest.readable?(@SDCFile)        
          @SDCFileInf = File::stat("#{@SDCFile}")
        else
          $ERROR_CNT += 1
          printf "@E:Cannot read \"#{@SDCFile}\". Please Check File.\n"
          Common.print_summary
          exit 1
        end
      end
    end
    # Error Check
    #  - HDL File("--hdl") dont have to need generating files.
    #    If speciefd, add this infomation in files.
    if @HDLFile == nil && @XMLFile == nil
      $ERROR_CNT += 1
      printf("@E:You must specify \"--hdl\" or \"--xml\" option for HDL Information\n")
      Common.print_summary
      exit 1
    else
      # Get file detail information
      if @HDLFile != nil
        if FileTest.readable?(@HDLFile)        
          @HDLFileInf = File::stat("#{@HDLFile}") 
        else
          $ERROR_CNT += 1
          printf "@E:Cannot read \"#{@HDLFile}\". Please Check File.\n"
          Common.print_summary
          exit 1
        end
      end
      if @XMLFile != nil
        if FileTest.readable?(@XMLFile)        
          @XMLFileInf = File::stat("#{@XMLFile}") 
        else
          $ERROR_CNT += 1
          printf "@E:Cannot read \"#{@XMLFile}\". Please Check File.\n"
          Common.print_summary
          exit 1
        end
      end
    end
    # Warning Check
    #  - CT File("--ct") dont have to need generating files.
    #    If speciefd, add this infomation in files.
    if @CTFile == nil && @SDCFile == nil
      $WARNING_CNT += 1
      printf("@W:Not Found \"--ct\" or \"--sdc\" option for CT Information, So, use ICECommon File saved in conf directory\n")
    else
      # Get file detail information
      @CTFileInf = File::stat("#{@CTFile}") if @CTFile != nil
    end
    return true
  end
  
  #
  # Operation
  #
  def operation
    # From CSV File
    if @PortFile != nil
      get_csv = GetCSV.new
      @CSV_PortInf = get_csv.reader_CN(@PortFile)[1]
      @CSV_PortInf.each{|data|
        @CSV_signal << data.FPGASignal
      }
    end
    # From SDC File
    if @SDCFile != nil
      @CSV_signal,@CSV_PortInf = get_SDCInf(@SDCFile)
    end

    # From HDL File
    if @HDLFile != nil
      verilog = Verilog.new
      @HDL_PortInf = verilog.analyze(@HDLFile).Port
    end
    # From XML File
    if @XMLFile != nil
      verilog = Verilog.new
      @HDL_PortInf = verilog.analyze_xml(@XMLFile,@TopModuleName).Port
    end
  end

  public
  def get_SDCInf(sdc)
    csv_PortInf = Array.new
    csv_Signal = Array.new
    if FileTest::readable?(sdc) == false
      $ERROR_CNT += 1
      printf("@E:Cannot read %s\n",sdc)      
      Common.print_summary
      exit 1
    end

    if sdc != nil
      open(sdc).each do |line|
        /^\s*define_attribute\s+\{(.*)\}\s+xc_loc\s+\{.*\}/ =~ line
        if $1 != nil
          csv_Signal << $1.sub("p:","")
        end
        /^\s*define_attribute\s+\{(.*)\}\s+xc_loc\s+\{(.*)\}\;\s*\#\s*CN(\d+)-(\d+)/ =~ line
        #        /^\s*define_attribute\s+\{(.*)\}\s+xc_loc\s+\{.*\}\;\s*#\*CN\:\*(\d+),\*Pin\:(\d+)/ =~ line
        if $1 != nil && $2 != nil && $3 != nil && $4 != nil
          csv_inf = CSVPinInf.new
          csv_inf.ConnectorNo = $3.to_i
          csv_inf.PinNo = $4.to_i
          csv_inf.PinLocAttribute = $2
          csv_inf.FPGASignal = $1.sub("p:","")
          csv_PortInf << csv_inf
        else
          /^\s*define_attribute\s+\{(.*)\}\s+xc_loc\s+\{(.*)\}\;/ =~ line
          if $1 != nil && $2 != nil
            csv_inf = CSVPinInf.new
            csv_inf.PinLocAttribute = $2
            csv_inf.FPGASignal = $1.sub("p:","")
            csv_PortInf << csv_inf
          elsif /xc_loc/ =~ line
            p "Unanalyze:" + line
          end
        end
      end
    end
    return csv_Signal,csv_PortInf
  end
  
  #
  # Compare
  #
  def compare
    result_dir = "result"
    Common.make_dir("#{result_dir}")
    file_name = result_dir + "/PinChecker.report" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Comparing Pin Infomation" 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
    f.printf("[Port]%s (%s)\n",@PortFile,@PortFileInf.mtime) if @PortFile != nil
    f.printf("[SDC ]%s (%s)\n",@SDCFile,@SDCFileInf.mtime) if @SDCFile != nil
    f.printf("[HDL ]%s (%s)\n",@HDLFile,@HDLFileInf.mtime) if @HDLFile != nil
    f.printf("[XML ]%s (%s)\n",@XMLFile,@XMLFileInf.mtime) if @XMLFile != nil
    f.printf("[CT  ]%s (%s)\n",@CTFile,@CTFileInf.mtime) if @CTFile != nil
    f.printf("\n")
    f.printf("\n")

    sdc_error_cnt = 0
    @CSV_PortInf.each{|data|
      if data.FPGASignal != nil
        if @HDL_PortInf.index("#{data.FPGASignal}") == nil
          sdc_error_cnt += 1
        end
      end
    }
    @CT_PortInf.each{|data|
      if data.FPGASignal != nil
        if @HDL_PortInf.index("#{data.FPGASignal}") == nil
          sdc_error_cnt += 1
        end
      end
    }

    verilog_error_cnt = 0
    if @CTFile == nil
      (@HDL_PortInf - @CSV_signal - @ICECommonSignal - @IgnoredPin).each{|signal|
        verilog_error_cnt += 1
      }
    else
      (@HDL_PortInf - @CSV_signal - @ICECommonSignal_CT - @IgnoredPin).each{|signal|
        verilog_error_cnt += 1        
      }
    end

    f.printf("#\n")
    f.printf("# Summary\n")
    f.printf("#\n")
    f.printf("\n")
    if sdc_error_cnt == 0 && verilog_error_cnt == 0
      f.printf("Judgement : OK (SDC and Verilog have same Pin/Signal Information)\n")
    else
      f.printf("Judgement : NG (SDC and Verilog have different Pin/Signal Information)\n")
    end
    f.printf("  The number of additional information in SDC     : %3d\n",sdc_error_cnt)
    f.printf("  The number of additional information in Verilog : %3d\n",verilog_error_cnt)
    f.printf("\n\n")
    f.printf("#\n")
    f.printf("# Error List\n")
    f.printf("#\n")
    f.printf("\n")
    f.printf("# %s\n",@PortFile)
    @CSV_PortInf.each{|data|
      if @HDL_PortInf.index("#{data.FPGASignal}") == nil
        f.printf("%-20s (%s # CN:%2d, Pin:%2d)\n",
                 data.FPGASignal,
                 data.PinLocAttribute.strip,
                 data.ConnectorNo,
                 data.PinNo) if data.PinLocAttribute != nil        
      end
    }
    if @CTFile != nil
      f.printf("\n")
      f.printf("# %s\n",@CTFile) 
      @CT_PortInf.each{|data|
        if @HDL_PortInf.index("#{data.FPGASignal}") == nil
          f.printf("%-50s\n",
                   data.PinLocAttribute.strip
                   ) if data.PinLocAttribute != nil        
        end
      }
    end
    
    f.printf("\n\n")
    f.printf("#\n")
    f.printf("# Details\n")
    f.printf("#\n")
    f.printf("[HDL]\n")
    f.printf("O : Pin Name found same name in %s\n",@HDLFile)
    f.printf("X : Pin Name does not find same name in %s, You must change Veriog or Excel.\n",@HDLFile)
    f.printf("\n## CT-IO File (%s)\n", @PortFile)
    f.printf("+-----+----+-----+----------------------+------+\n")
    f.printf("|  No | CN | Pin |             Pin Name |  HDL |\n")
    f.printf("+-----+----+-----+----------------------+------+\n")
    n  = 1
    @CSV_PortInf.each{|data|
      if data.FPGASignal != nil
        cmp = ""
        if @HDL_PortInf.index("#{data.FPGASignal}")
          cmp = "O"
        else
          cmp = "X"
        end
        f.printf("| %3d | %2s | %3s | %20s |    %s |\n",
                 n,
                 data.ConnectorNo,
                 data.PinNo,
                 data.FPGASignal,
                 cmp
                 ) 
        n += 1 
      end
    }
    f.printf("+-----+----+-----+----------------------+------+\n")
    if @CTFile != nil
      f.printf("\n## CT Inf (%s)\n", @CTFile)
      f.printf("+-----+-----+----------------------+------+\n")
      f.printf("|  No |  ID |             Pin Name |  HDL |\n")
      f.printf("+-----+-----+----------------------+------+\n")
      n = 1
      @CT_PortInf.each{|data|
        if data.FPGASignal != nil
          cmp = ""
          if @HDL_PortInf.index("#{data.FPGASignal}")
            cmp = "O"
          else
            cmp = "X"
          end
          f.printf("| %3d | %3d | %20s |    %s |\n",
                   n,
                   data.Id,
                   data.FPGASignal,
                   cmp
                   ) 
          n += 1
        end
      }
      f.printf("+-----+-----+----------------------+------+\n")
    end
    f.printf("\n\n")
    f.printf("#\n")
    if @CTFile == nil
      f.printf("# Found Verilog-only Signal except ICE Common Signal(*)\n")
      f.printf("#   (*) ICE Common Signal : see ../conf/ICECommonSignal.lst\n")
    else
      f.printf("# Found Verilog-only Signal\n")
    end
    f.printf("#\n")
    f.printf("\n")
    if @CTFile == nil
      (@HDL_PortInf - @CSV_signal - @ICECommonSignal).each{|signal|
        if @IgnoredPin.index(signal) == nil
          f.printf("%s\n",signal)
        else
          f.printf("%s # Ignored(FMake Limitation)\n",signal)
        end
      }
    else
      (@HDL_PortInf - @CSV_signal - @ICECommonSignal_CT).each{|signal|
        if @IgnoredPin.index(signal) == nil
          f.printf("%s\n",signal)
        else
          f.printf("%s # Ignored(FMake Limitaion)\n",signal)
        end
      }
    end
    f.printf("\n")
    f.printf("#\n")
    f.printf("# End of report\n")
    f.printf("#\n")
    f.close
#    p @CSV_PortInf & @HDL_PortInf
#    p @CSV_PortInf - @HDL_PortInf
#    p @HDL_PortInf - @CSV_PortInf
    return sdc_error_cnt , verilog_error_cnt 
  end

  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    Common.print_base
    # Ruby Version Judgment
=begin
    if RUBY_VERSION != "1.8.5"
      printf("@E:mksdc only support Ruby ver : 1.8.5 ( Now, executed %s )\n",RUBY_VERSION)
      printf("   please check your ruby execute setting.")
      $ERROR_CNT += 1
      Common.print_summary
      exit
    end
=end

    get_argument
    read_ICECommon
    operation
    sdc_error_cnt, verilog_error_cnt = compare
    Common.print_summary
    printf("\n")
    printf("[Pin Check result]\n")
    if sdc_error_cnt == 0 && verilog_error_cnt == 0
      printf("Judgement : OK (SDC and Verilog have same Pin/Signal Information)\n")
    else
      printf("Judgement : NG (SDC and Verilog have different Pin/Signal Information)\n")
    end
    printf("  The number of additional information in SDC     : %3d\n",sdc_error_cnt)
    printf("  The number of additional information in Verilog : %3d\n",verilog_error_cnt)
    printf("\n\n")
  end
  
end


if __FILE__ == $0
  pin_checker = PinChecker.new
  pin_checker.main
  exit
end
