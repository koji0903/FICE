#!/usr/bin/ruby
#############################################################
#
# MySTA
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 NEC MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# -Analyze TWR file which is ISE STA report, and Generate analized report file. 
#
# [Usage]
# -%ruby MySTA.rb -twr [TWR File] -d [ISE Working Directory] -o [Report File] -udef [UDEF File]
# If you want to get more information. plese use "-h" option.
#
# [EXAMPLE]
# -%ruby MySTA.rb EVA_TOP.twr -o Kx4_v5_ISE11.rep -udef ~/${FICE}/conf/kx4.udef
#
# [Output]
# -Report File
#
# [History]
# ver 0.4.xxx - New
#
#############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"

#
# Global Setting
#
$SUB_TOOL            = "MySTA" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$MESSAGE         = false



#
# Main Class
#
class MySTA

  #- Database for Constrait Informatin
  class ConstInfo
    # Const line
    attr_accessor :Const
    # Const Nae
    attr_accessor :ConstName
    # the number of "paths analyzed"
    attr_accessor :PathsAnalyzed
    # the number of "endpoints analyzed"
    attr_accessor :EndpointsAnalyzed
    # the number of "failing endpoints" 
    attr_accessor :FailingEndpoints
    # the number of "failing endpoints"
    attr_accessor :TimingError
    # the number of "setup error"
    attr_accessor :SetupError
    # the number of "hold error"
    attr_accessor :HoldError
    # the number of "switching limit error"
    attr_accessor :SwitchingLimitError
    # the value of "worst slack" when setup error
    attr_accessor :WorstSlack
    # the value of "hold violation" whhen hold error
    attr_accessor :HoldViolation
    # Source in Timing Error
    attr_accessor :CriticalPathSource
    # Destination in TimingError
    attr_accessor :CriticalPathDestination
    # Source Clock
    attr_accessor :CriticalPathSourceClock
    # Destination Clock
    attr_accessor :CriticalPathDestinationClock
    def initialize
      @Const = nil
      @ConstName = nil
      @PathsAnalyzed = 0
      @EndpointsAnalyzed = 0
      @FailingEndpoints = 0
      @TimingError = 0
      @SetupError = 0
      @HoldError = 0
      @SwitchingLimitError = 0
      @WorstSlack = nil
      @HoldViolation = nil
      @CriticalPathSource = nil
      @CriticalPathDestination = nil
      @CriticalPathSourceClock = nil
      @CriticalPathDestinationClock = nil
    end
  end


  def initialize
    @TWR = nil
    @TWR_DATA = Array.new
    @UDEF = nil

    # ISE Working Directory name
    @ISE_WORK_DIR = nil
    @BLD = nil
    @MAP = nil
    @PAR = nil
    @BLD_DATA = Array.new
    @MAP_DATA = Array.new
    @PAR_DATA = Array.new
    @BLD_CMD = nil
    @MAP_CMD = nil
    @PAR_CMD = nil
    
    # For output
    @TWR_INF = Hash.new
    
    # TWRInformation
    @ISEVersion = nil
    @Device = nil
    @TimingError = 0
    @ConstraintCover = 0

    # CheckConst for System Freq
    @CheckConst = Array.new

    # Report
    @ReportFileName = nil
    @TimingErrorFlag = false
    @ROUTED = false
  end

  #
  # Print Base Information( Tool name, Version, Copyright )
  #
  private
  def print_base
    printf("FICE(%s) ver:%s\n",$TOOL,$VERSION)
    printf("Copyright (c) 2009,2010 NEC MicroSystem. All rights reserved.\n\n")
  end

  #
  # Print Tool Usage
  #
  private
  def print_usage
    printf("\n")
    printf("Usage :  %s.rb [twr file]\n",$TOOL)
    printf(" OPTION\n")
    printf("\t-h/-help         : print help message\n")
    printf("\t-v/-version      : print version\n")
    printf("\t-verbose         : execute on verbose mode\n")
    printf("\t-twr             : TWR file name\n")
    printf("\t-d               : ISE Working Directory\n")
    printf("\t-o               : Output report file name\n")
    printf("\t-udef            : UDEF File\n")
    printf("    \n")
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  private
  def get_argument
    size = ARGV.size
    size -= 1
    for i in 0..size
      case ARGV[i]
      when '-h','-help' then
        print_base
        print_usage
        exit
      when '-v','-version' then
        print_base
        printf("")
        exit
      when '-verbose' then
        $VERBOSE = true
      when '-o' then
        @ReportFileName = ARGV[i+1]
        i += 1
      when '-twr' then
        @TWR = ARGV[i+1]
        i += 1
      when '-udef' then
        @UDEF = ARGV[i+1]
        i += 1
      when '-d' then
        @ISE_WORK_DIR = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        else
#          @TWR = ARGV[i]
        end
      end
    end 

    if @TWR == nil
      $ERROR_CNT += 1
      printf("@E:\"TWR NAME\" is not specified.\n")
      print_usage
      Common.error
    end
    if @UDEF == nil
      $ERROR_CNT += 1
      printf("@E:\"UDEF NAME\" is not specified.\n")
      print_usage
      Common.error
    end
    
    if Common.chk_file(nil,@TWR) == 1
      Common.error
    end
    if Common.chk_file(nil,@UDEF) == 1
      Common.error
    end

    if @ReportFileName == nil
      $ERROR_CNT += 1
      printf("@E:need to use \"-o\" option.\n")
      print_usage
      Common.error
    end


  end
  
  #
  #- Read twr file
  #
  private
  def read_twr
    @TWR_DATA = Common.file_read(@TWR)
  end

  #
  #- Analize twr file 
  #
  private
  def analize
    printf("@I:analize %s\n",@TWR)
    flag = false
    i = 0
    while i <= @TWR_DATA.size
      # Get System Information
      if /^Release/ =~ @TWR_DATA[i]
        @ISEVersion = @TWR_DATA[i].split[1]
      end
      if /^Device,package,speed/ =~ @TWR_DATA[i]
        @Device = @TWR_DATA[i].split[1].split(",")[0]
      end
      if /^Timing errors:/ =~ @TWR_DATA[i]
        @TimingError = @TWR_DATA[i].split[2].to_i
      end
      if /^Constraints cover/ =~ @TWR_DATA[i]
        @ConstraintCover = @TWR_DATA[i].split[2].to_i
      end
      

      # Start analize after "Timing constraint" line
      if /^Timing constraint/ =~ @TWR_DATA[i]
        each_const = ConstInfo.new
        each_const.Const = @TWR_DATA[i].sub(";","")

        # for multiple description line
        while (/;$/ =~ @TWR_DATA[i]) == nil 
          each_const.Const += @TWR_DATA[i].sub(";","")
          i += 1
        end
        each_const.Const = each_const.Const.sub("Timing constraint: ","")
        each_const.ConstName = each_const.Const.split[0] # Pick-up Constraint Name

        # Get Analyzed summary
        i += 2
        /^ (\d+) path\w* analyzed, (\d+) endpoint\w* analyzed, (\d+) failing endpoint\w*/ =~ @TWR_DATA[i]
        if $1 != nil && $2 != nil && $3 != nil
          each_const.PathsAnalyzed = $1
          each_const.EndpointsAnalyzed = $2
          each_const.FailingEndpoints = $3
        else
          p @TWR_DATA[i]
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end

        # Get detail information
        i += 1
        if ( /^ (\d+) timing error\w* detected. \((\d+) setup error\w*, (\d+) hold error\w*, (\d+) component switching limit error\w*\)$/ =~  @TWR_DATA[i] ) != nil
          if $1 != nil && $2 != nil && $3 != nil && $4 != nil
            each_const.TimingError = $1
            each_const.SetupError = $2
            each_const.HoldError = $3
            each_const.SwitchingLimitError = $4
          end
        end
        if ( /^ (\d+) timing error\w* detected. \((\d+) component switching limit error\w*\)$/ =~  @TWR_DATA[i] ) != nil
          if $1 != nil && $2 != nil
            each_const.TimingError = $1
            each_const.SwitchingLimitError = $4
          end
        end
        if ( /^ (\d+) timing error\w* detected. \((\d+) setup error\w*, (\d+) hold error\w*\)$/ =~  @TWR_DATA[i] ) != nil
          if $1 != nil && $2 != nil && $3 != nil
            each_const.TimingError = $1
            each_const.SetupError = $2
            each_const.HoldError = $3
          end
        end
        if ( /^ (\d+) timing error\w* detected.$/ =~  @TWR_DATA[i] ) != nil
          if $1 != nil 
            each_const.TimingError = $1
          end
        end

        # judge error
        if each_const.TimingError == nil && each_const.SetupError == nil && each_const.HoldError == nil && each_const.SwitchingLimitError == nil
          p @TWR_DATA[i]
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end

        if each_const.ConstName != "PATH"
          @TWR_INF["#{each_const.ConstName}"] = each_const
        else
          @TWR_INF["#{each_const.Const}"] = each_const
        end

        # Get Slack/Hold Violation Information
        if each_const.TimingError != "0"
          @TimingErrorFlag = true
          slack = nil
          source = nil
          destination = nil
          source_clock = nil
          destination_clock = nil
          while slack == nil || source == nil || destination == nil || source_clock == nil || destination_clock == nil
            i += 1
            line = @TWR_DATA[i]
            if /^Slack/ =~ line
              line = line.sub("ns","")
              tmp = line.split[3].to_f
              if tmp == -0.0
                tmp = line.split[1].to_f
              end            
              if tmp < 0 
                slack = tmp
                each_const.WorstSlack = slack
              end
            elsif /^Hold Violation/ =~ line
              tmp = line.split[2].to_f
              if tmp == -0.0
                tmp = line.split[1].to_f
              end            
              if tmp < 0 
                slack = tmp
                each_const.HoldViolation = slack
              end
            elsif /^Delay/ =~ line
              tmp = line.split[3].to_f
              if tmp == -0.0
                tmp = line.split[1].to_f
              end            
              if tmp < 0 
                slack = tmp
                each_const.WorstSlack = slack
              end
            end
            # Get Source/Distination
            if slack != nil
              if /^Source:/ =~ line.strip
                source = line.split[1]
                each_const.CriticalPathSource = source
              end
              if /^Destination:/ =~ line.strip
                destination = line.split[1]
                each_const.CriticalPathDestination = destination
              end
              if /^Source Clock:/ =~ line.strip
                source_clock = line.split[2] + " " + line.split[3]
                each_const.CriticalPathSourceClock = source_clock
              end
              if /^Destination Clock:/ =~ line.strip
                destination_clock = line.split[2] + " " + line.split[3]
                each_const.CriticalPathDestinationClock = destination_clock
              end
            end
          end
        end

      end
      i += 1
    end
  end


  #
  #- Get ISE Information(execute option from BLD,MAP,PAR)
  #
  private
  def getISEInfo
    @BLD = @ISE_WORK_DIR + "/" + "EVA_TOP.bld"
    @MAP = @ISE_WORK_DIR + "/" + "EVA_TOP_map.map"
    @PAR = @ISE_WORK_DIR + "/" + "EVA_TOP.par"

    # File Check
    if Common.chk_file(nil,@BLD) == true
      $ERROR_CNT += 1
      printf("@E:\"\" file doesnt find.\n",@BLD)
      print_usage
      error
    end
    if Common.chk_file(nil,@MAP) == true
      $ERROR_CNT += 1
      printf("@E:\"\" file doesnt find.\n",@MAP)
      print_usage
      error
    end
    if Common.chk_file(nil,@PAR) == true
      $ERROR_CNT += 1
      printf("@E:\"\" file doesnt find.\n",@PAR)
      print_usage
      error
    end

    # Get File Data
    @BLD_DATA = Common.file_read(@BLD)
    @MAP_DATA = Common.file_read(@MAP)
    @PAR_DATA = Common.file_read(@PAR)

    # for BDL
    i = 0
    str = ""
    while i <= @BLD_DATA.size
      line = @BLD_DATA[i]
      if /^Command Line:/ =~ line
        i += 1
        while @BLD_DATA[i].size != 0
          str = str + " " + @BLD_DATA[i].to_s
          i += 1
        end
        /.*(ngdbuild.*)/ =~ str
        @BLD_CMD = $1
      end
      i += 1
    end

    # for MAP
    i = 0
    str = ""
    while i <= @MAP_DATA.size
      line = @MAP_DATA[i]
      if /^Command Line/ =~ line
        str = line.sub("Command Line   : ","")
        i += 1
        while ((/^Target Device/ =~ @MAP_DATA[i]) == nil)
          str = str + " " + @MAP_DATA[i].to_s
          i += 1
        end
        @MAP_CMD = str
      end
      i += 1
    end

    # for PAR
    i = 0
    str = ""
    while i <= @PAR_DATA.size
      line = @PAR_DATA[i]
      if /^par / =~ line
        while @PAR_DATA[i].size != 0
          str = str + " " + @PAR_DATA[i].to_s
          i += 1
        end
        @PAR_CMD = str
      end
      
      # Check "completely routed"
      if /^All signals are completely routed./ =~ line
        @ROUTED = true
      end
      i += 1
    end

    
  end


  #
  #- Generate Report
  #
  public
  def generateReport
    file_name = @ReportFileName
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "TWR Summary Report from ISE TWR file" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")
    # Global Summary
    f.printf("## Global Summary\n\n")
    f.printf("  [Execute Condition]\n")
    f.printf("    Executed ISE Ver : %s\n",@ISEVersion)
    f.printf("    FPGA Package     : %s\n",@Device)
    f.printf("    TWR File         : %s\n",@TWR)
    f.printf("\n")
    if @ISE_WORK_DIR != nil
    f.printf("  [Execute Option]\n")
    f.printf("    ngdbuild :%s\n",@BLD_CMD)
    f.printf("    map      :%s\n",@MAP_CMD)
    f.printf("    par      :%s\n",@PAR_CMD)
    f.printf("\n")
    end

    f.printf("  [STA Result] ")
    if @TimingError == 0 && @ROUTED == true
      if @PAR != nil
        f.printf("    OK (Completely Routed, Timing Error: %d, Constraints cover: %d )\n",@TimingError,@ConstraintCover)
      else
        f.printf("    OK (Timing Error: %d, Constraints cover: %d )\n",@TimingError,@ConstraintCover)
      end
    else
      f.printf("    NG (Timing or Routed Error: %d, Constraints cover: %d )\n",@TimingError,@ConstraintCover)
      if @TimingError != 0
        f.printf("    - please see \"Timing Error Path\"\n")
      end
      if @ROUTED == false
        f.printf("    - please see \"Par report\"\n")
      end
=begin
      @TWR_INF.each{|key,value|
        if value.TimingError != "0"
          f.printf("     %s\n",value.Const)
        end
      }
=end
    end
    f.printf("\n")

    # Detail of CLOCK 
    f.printf("## Details of Clock Constraint\n\n")
    getCheckConst(f)
    f.printf("\n")

    # Error Path
    if @TimingErrorFlag == true
      f.printf("## Timing Error Path ( display worst path at each constraint )\n\n")
      getTimingErrorInfo(f)
      f.printf("\n")
    end

    # Detail of other Const
    f.printf("## Details of All Constraint\n\n")
    getAllConst(f)
    f.printf("\n")

    f.printf("\n")
    f.printf("Finished Report\n")
    f.close
  end

  #
  #- Get CheckConst Infromation
  #
  private
  def getCheckConst(f)
    @CheckConst.each{|each_const|
      const_inf = @TWR_INF["#{each_const}"]
      if const_inf == nil
#        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
#        exit
        $WARNING_CNT += 1
        printf("@W:Does not found detail information about %s\n",each_const)
        next
      end
      
      if const_inf.PathsAnalyzed == "0"
        error = "Un-matched"
      else
        if const_inf.TimingError == "0"
          error = "Met  "
        else
          error = "UnMet"
        end
      end

      f.printf(" %-15s --- %s [ Freq: %02.2f MHz (%sns) ]\n", 
               each_const,
               error,
               1000/const_inf.Const.split[5].to_f,
               const_inf.Const.split[5]
               )

      # print slack Informaton
      if error == "UnMet"
        if const_inf.WorstSlack != nil
          f.printf("                        * Worst Slack : %s\n",const_inf.WorstSlack)
        elsif const_inf.HoldViolation != nil
          f.printf("                        * Hold Violation : %s\n",const_inf.HoldViolation)
        end
      end
    }
  end

  #
  #- Get Other Constraint result
  #
  private
  def getAllConst(f)
    @TWR_INF.each_value{|value|
      f.printf("-----------------------------------------\n")
      f.printf("%s\n",value.Const)
      f.printf("  - Analized Paths        : %15d\n",value.PathsAnalyzed)
      f.printf("  - Analized Endpoints    : %15d\n",value.EndpointsAnalyzed)
      f.printf("  - Failing Endpoints     : %15d\n",value.FailingEndpoints)
      f.printf("  - Timing Error          : %15d\n",value.TimingError)
      f.printf("  - SetupError            : %15d\n",value.SetupError)
      f.printf("  - HoldError             : %15d\n",value.HoldError)
      f.printf("  - Switching Limit Error : %15d\n",value.SwitchingLimitError)
    }
  end

  #
  #- Get Timing Error Info for output Critical Path
  #
  private
  def getTimingErrorInfo(f)
    @TWR_INF.each_value{|value|
      if value.TimingError != "0"
        f.printf("-----------------------------------------\n")
        f.printf("%s\n",value.Const)
        f.printf("-----------------------------------------\n")
        if value.SetupError != "0"
          f.printf(" -Setup Slack : %s\n",value.WorstSlack)
        elsif value.HoldError != "0"
          f.printf(" -Hold Violation : %s\n",value.HoldViolation)
        end
        f.printf(" -Source            : %s\n",value.CriticalPathSource)
        f.printf(" -Destination       : %s\n",value.CriticalPathDestination)
        f.printf(" -Source Clock      : %s\n",value.CriticalPathSourceClock)
        f.printf(" -Destination Clock : %s\n",value.CriticalPathDestinationClock)
        f.printf("\n")
      end
    }
  end

  public
  def get_udef(data)
    check_const = []
    data.each{|line|
      line = line.strip
      next if line[0] == 35
      tmp = line.split
      check_const << "TS_" + tmp[0] if tmp[0] != nil
    } if data != nil
    check_const
  end

  #
  #- Main Function
  #  1. Get Argument
  #  2. Read TWR
  #  3. Analize TER
  #  4. Get ISE Report if assigned
  #  5. Generate Report file
  #
  public
  def main
    Common.print_base
    get_argument
    read_twr
    @CheckConst = get_udef(Common.file_read(@UDEF)) if @UDEF != nil
    analize
    if @ISE_WORK_DIR != nil
      getISEInfo 
    else
      # Warning! Cannot check "completely routed"
      $WARNING_CNT += 1
      printf("@W:cannot check \"completely routed\" on par operation. please check route report yourself.")
    end
    generateReport
    Common.print_summary
  end
  
end


if __FILE__ == $0
  mysta = MySTA.new
  mysta.main
end
