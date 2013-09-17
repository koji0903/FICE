#!/usr/bin/ruby
##################################################################
#
#  gen_fconf
#
#  Function : Analize *.hier which is described Circuite hierarchy
#             Generate fmake_conf file for FMake 
#
#  Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date     : 2009/09/02
#  Version  : 1.1-beta
#
#  History
#    0.1-beta(09/09/02) : New Release
#
###################################################################
#
# [INPUT]
#   * Hierarchy File(*.hier) 
#      - Original file formato for Circuit Hierarchy
#
# [OUTPUT]
#   * Configuration File for FMake
#
# [OPERATION]
#
###################################################################
require "common"
require "message"

$TOOL      = "gen_fconf"
$VERSION   = "0.1-beta"
$VERBOSE   = false

$CONF_DIR  = "./conf"
$HIER_CNT  = 1


$NOTE_CNT    = 0
$WARNING_CNT = 0
$ERROR_CNT   = 0


$MAX_HIER_CNT = 0  # Maximum hierarchy count


class Module 
  attr_accessor :ModuleName
  attr_accessor :InstName
  attr_accessor :FileName
  attr_accessor :HierNum
  attr_accessor :UpperModule
  attr_accessor :LowerModule
  #
  # initialize
  #
  def initialize
    @ModuleName = nil
    @InstName = nil
    @FileName = nil
    @HierarchyNum = 0
    @UpperModule = nil
    @LowerModule = Array.new
  end

end

class Hierarchy < System

  #
  # initialize
  #
  def initialize
    @tool = "hierarchy"
    @ver  = "0.1"

    @FileName = nil
    @FileData = Array.new
    @CircuitInfo = Array.new
    @ModuleInfo = Module.new
  end
 
  #
  # read
  def read
    printf("@I:Read %s\n",@FileName)
    @FileData = Common.file_read(@FileName)
    @FileData = Common.data_trim(@FileData)    
  end
  
  def print
    p @FileData
  end

  def print_base
    printf("%s ver:%s\n",$TOOL,$VERSION)
    printf("Copyright (c) 2009 NEC MicroSystem. All rights reserved.\n\n")
  end

  def print_usage
    printf("\n")
    printf("Usage : %s.rb [OPTION] <Hier File>\n",$TOOL)
    printf(" OPTION:\n")
    printf("    -h/-help       : print help message\n")
    printf("    -v/-version    : print version\n")
    printf("    -verbose       : execute on verbose mode\n")
    printf("    -conf CONF_DIR : Output dirctory for ConfFile(default:./conf)\n")
    printf("    -hier_cnt NUM  : target hierarchy(default:1)\n")
    printf("    \n")
  end
  #
  # get argument
  #
  def get_argument
    size = ARGV.size
    size -= 1
    i = 0
    while i <= size
      case ARGV[i]
      when '-h','-help' then
        print_base
        print_usage
        exit
      when '-v','-version' then
        print_base
        printf("")
        exit
      when '-hier_cnt' then
        $HIER_CNT = ARGV[i+1].to_i
        i = i + 1
      when '-verbose' then
        $VERBOSE = true
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        else
          @FileName = ARGV[i]
        end
      end
      i += 1
    end 

    printf("Argument:\n") if $VERBOSE
    printf(" - HIER_CNT  : %d\n",$HIER_CNT) if $VERBOSE
    printf(" - Hier File : %s\n",@FileName) if $VERBOSE
    printf("\n") if $VERBOSE

    #check
    if @FileName == nil
      $ERROR_CNT += 1
      printf("@E:sys00 - please set Hierarchy file\n")
      print_usage
      print_summary
      exit
    end
  end

  #
  # Count "+" Charactor
  #
  def num_analize(line)
    num = 0
    other_char = false
    line.each_byte{|c|
      if c == 43
        if other_char == true
          printf("@E:no support format(%s)\n",line)
          exit
        else
          num += 1
        end
      else
        other_char = true
      end
    }
    return num
  end

  #
  # Analize ModuleName & FileName
  #
  def module_analizer(line)
    
    line = line.gsub("+","") # delete "+" char
    str =  line.scan(/^(\w*)\((\w*)\)\[(\S*)\]/)
    return str
  end

  #
  # Hierarchy Alanize
  #
  def hier_ana
    printf("@I:Analize Hierarchy Information\n")
    num_pre = 0
    module_pre = Array.new
    module_pre[0] = nil
    hiernum_pre = 0
    modulename_pre = nil
    @FileData.each{|line|
      printf("%s\n",line) if $VERBOSE
      @ModuleInfo = Module.new
      @ModuleInfo.HierNum =  num_analize(line) # Hierarchy Number
      $MAX_HIER_CNT = @ModuleInfo.HierNum if $MAX_HIER_CNT < @ModuleInfo.HierNum
      @ModuleInfo.FileName = module_analizer(line)[0][2]
      @ModuleInfo.ModuleName = module_analizer(line)[0][1]
      @ModuleInfo.InstName = module_analizer(line)[0][0]
    
      # The Lower Hier must be only-one lower from previous module
      if ( @ModuleInfo.HierNum - num_pre > 1 )
        printf("@E: Found illegal description!(%s)\n",line)
        exit
      else
        module_pre[@ModuleInfo.HierNum] = @ModuleInfo.ModuleName
      end
      @ModuleInfo.UpperModule = module_pre[@ModuleInfo.HierNum-1]
      num_pre = @ModuleInfo.HierNum

      # Update ArrayData using ModuleInfo
=begin
      if @ModuleInfo.ModuleName == "CHIPTOP"
        printf(" ---------------------------------------\n")
        printf(" - FileName       : %s\n",@ModuleInfo.FileName)
        printf(" - ModuleName     : %s\n",@ModuleInfo.ModuleName)
        printf(" - HierNum        : %s\n",@ModuleInfo.HierNum)
        printf(" - InstName       : %s\n",@ModuleInfo.InstName)
        printf(" - modulename_pre : %s\n",modulename_pre)
        printf(" - hiernum_pre    : %s\n",hiernum_pre)
        exit
      end
=end
#      if (@ModuleInfo.ModuleName != modulename_pre) && ( @ModuleInfo.HierNum != hiernum_pre )
      if (@ModuleInfo.ModuleName != modulename_pre) 
        if @ModuleInfo.FileName != "NONE"
          @CircuitInfo << @ModuleInfo
        end
      end
      hiernum_pre = @ModuleInfo.HierNum
      modulename_pre = @ModuleInfo.ModuleName
    }# @FileData.each

    @CircuitInfo.each{|mod_info|
      printf(" ---------------------------------------\n")
      printf(" - FileName   : %s\n",mod_info.FileName)
      printf(" - ModuleName : %s\n",mod_info.ModuleName)
      printf(" - InstName   : %s\n",mod_info.InstName)
    } if $VERBOSE

    # Make Lower Module info
    ($MAX_HIER_CNT+1).times{
      @CircuitInfo.each{|base|
        @CircuitInfo.each{|target|
          if base.ModuleName == target.UpperModule # be connected base and target module
            base.LowerModule << target.FileName # set LowerModule using FileName
            base.LowerModule += target.LowerModule if target.LowerModule != nil
          end
        }
        base.LowerModule.uniq! # trimming LowerModule
      }
      printf(".")
    }
    printf("\n")

=begin
    while $MAX_HIER_CNT > 0 
      @CircuitInfo.each{|base|
        if base.HierNum == $MAX_HIER_CNT
          @CircuitInfo.each{|target|
            if target.HierNum == $MAX_HIER_CNT - 1
              if base.UpperModule == target.ModuleName   # Lower module
                target.LowerModule << base.FileName      
                if base.LowerModule != nil               # It has more lower module
                  target.LowerModule += base.LowerModule 
                end
              end
            end
            target.LowerModule.uniq!
          }
        end
      }
      $MAX_HIER_CNT -= 1
    end
=end

  end
  
  #
  # fmake_conf
  #
  def fmake_conf(file_name,module_info)
    tmp = Array.new
    i = 0

    f = open("#{file_name}","w")

    print_file_header(f,"FMake-Conf File for FMake", @tool, @ver)
    f.printf("\n")
    f.printf("# PROJECT Name\n")
    f.printf("# This Parameter use synthesis directory name\n")
    f.printf("PROJECT         = %s\n",module_info.ModuleName)
    f.printf("\n")
    f.printf("# Circuit File List\n")
    f.printf("FILE            = ../%s\n",module_info.FileName)
    tmp = module_info.LowerModule
    tmp.each{|name|
      if module_info.FileName != name
        f.printf("FILE            = ../%s\n",name)
        i += 1
      end
    }
    f.printf("FILE            = ./DB/mf2_prim.v\n")
    f.printf("\n")
    f.printf("\n")
    f.printf("# SDC File List\n")
    f.printf("SDC             =\n")
    f.printf("\n")
    f.printf("# Top Module Name\n")
    f.printf("# Synthesis top module as this module\n")
    f.printf("TOP_MODULE      = %s\n",module_info.ModuleName)
    f.printf("\n")
    f.printf("#\n")
    f.printf("# Output root directory\n")
    f.printf("#\n")
    f.printf("WORK_DIR         = 00macro_synthesis\n")
    f.printf("\n")
    f.printf("#\n")
    f.printf("# For Synplify Pro Synthesis OPTION\n")
    f.printf("#\n")
    f.printf("\n")
    f.printf("# Synthesis operation (ON/OFF)\n")
    f.printf("SYNTHESIS       = ON\n")
    f.printf("\n")
    f.printf("# FPGA Thechnology\n")
    f.printf("TECHNOLOGY      = Virtex4\n")
    f.printf("\n")
    f.printf("# FPGA Part\n")
    f.printf("PART            = XC4VLX80\n")
    f.printf("\n")
    f.printf("# FPGA Package\n")
    f.printf("PACKAGE         = FF1148\n")
    f.printf("\n")
    f.printf("# FPGA Speed Grade\n")
    f.printf("SPEED_GRADE     = -10\n")
    f.printf("\n")
    f.printf("# Setting for gated clock (ON/OFF)\n")
    f.printf("FIX_GATED_CLOCK = ON\n")
    f.printf("\n")
    f.printf("#\n")
    f.printf("# For ISE Place & Route OPTION\n")
    f.printf("#\n")
    f.printf("\n")
    f.printf("# ISE Place & Route Operation (ON/OFF)\n")
    f.printf("PLACE_AND_ROUTE = OFF\n")

    f.close
  end

  #
  # Generate FMake-Conf file for each module
  #
  def gen_conf(hier_num)
    @CircuitInfo.each{|module_info|
      if module_info.HierNum == hier_num
        printf("@I:Generate Fmake-Conf File for %s\n",module_info.ModuleName)
        fmake_conf("./conf/#{module_info.ModuleName}.fmake_conf",module_info)
      end
    }
  end

  #
  # print Circuit Information
  #
  def print_info
    mdata = Array.new
    msize = 0
    @CircuitInfo.each{|data|
      printf("%s\n",data)
      printf("  - ModuleName  : %s\n", data.ModuleName)
      printf("  - FileName    : %s\n", data.FileName)
      printf("  - HierNum     : %d\n", data.HierNum)
      printf("  - UpperModule : %s\n", data.UpperModule)
      mdata = data.LowerModule
      if mdata.size != 0   
        printf("  - LowerModule : ")
        p mdata
      end
    }
  end

  def print_summary
    printf("\n")
    printf("Execution summary\n")
    printf("   Note     : %3d\n", $NOTE_CNT)
    printf("   Warning  : %3d\n", $WARNING_CNT)
    printf("   Error    : %3d\n", $ERROR_CNT)
    printf("\n")
    if $ERROR_CNT == 0
      printf("%s finished in successfully.\n",$TOOL)
    else
      printf("%s finished with Errors. please check error message.\n",$TOOL)
    end
  end
  
  def exe
    get_argument
    print_base
    read
    hier_ana
    Common.make_dir($CONF_DIR)
    gen_conf($HIER_CNT)
    print_info if $VERBOSE == true
    print_summary
  end

end

hier = Hierarchy.new
hier.exe
