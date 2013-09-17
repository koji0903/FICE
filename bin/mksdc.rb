#!/usr/bin/ruby
#############################################################
#
# mksdc
#= mksdc: Generate SDC File, and Analize the detail of constraint
#   generate constraints files for synplify pro using Device Constraints
#   analize applied constarints rate using Synplify Pro report
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 Renesas Micro Systems. All rights reserved.
#
#############################################################
#
#==OPERATION
#
#==USAGE
#* %mksdc.rb -set_max_delay <ON(default)/OFF>-osdc <Output SDC Name> -scr_dir <SCR Directory> 
#  -srr <Synplify Srr> rpt <Synplify Rpt> -iucf <UCF report> -rmlist <RemoveList> -scope <ScopeInstance>
#
#==EXAMPLE
#* DeviceMode( Generate sdc file / Analize )
#  * %mksdc.rb -osdc Fx3_const -scr_dir _scr -srr Fx3.srr -rpt Fx3.rpt
#
#* FPGAMode( Analize ONLY )
#  * %mksdc.rb -isdc Fx3_const.sdc -srr Fx3.srr -rpt Fx3.rpt
#
#==OUTPUT
#* <SDC Name>.sdc <DeviceMode>
#  * report
#    * constraint.summary
#    * name_change.txt
#    * remove_const_list.txt 
#
#
#############################################################
#require "runit/assert"
#include RUNIT::AssertMixin

$:.unshift(File.dirname(__FILE__) + "/../lib")

require 'FICE_def'
require "system"
require "common"

require "constraint"
require "synplify_rpt"
require "synplify_srr"
require "synplify_ucf"
require "synplify_sdc"
require "gen_summary_scr"
require "gen_summary_sdc"
require "device_scr"


#
# Global Setting
#
$SUB_TOOL            = "mksdc" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$MESSAGE         = false
$MODE            = "custom"  # normal,custom
$TEST_MODE = false

#
# Tool Setting
#
$EXE_MODE        = nil     # [DeviceMode/FPGAMode]


# for separating socket/plug 
$TARGET = "plug"
# for generating constant constraint
$CONSTANT = "on"
# Scope Instance
$SCOPE = nil

$CLOCK_INF = {
  "DRDCLK" => "dummy",
  "R64MCLK_DIV" => "",
  "FCLK_PLUG" => "",
}   # Clock Information

$RESERVED = [
             "get_clock",
             "get_pins",
             "\\[\\s+",
             "\\s+\\]",
             "\\.-through",
             "\\.-thr",
             "\\.-from",
             "\\.-to",
            ]

#
# Main Class
#
class MkSDC  
  def initialize
    # for SDC File Name
    @OUT_SDC = nil
    # for SDC File Name
    @IN_SDC  = nil
    # for SCR Directory Name
    @SCR_DIR = nil
    # for UCF File Name
    @UCF     = nil
    # for Synplify Report File Name
    @RPT     = nil
    # for Synplify SRR File Name
    @SRR     = nil
    # for Rmlist File Name
    @RMLIST  = nil
    # for Removing Macro Name
    @RM_MACRO = Hash.new
    # SCR file list under directory(full path)
    @file_list = Array.new  
    # for all scr data {file_name,[scr_data]}
    @scr_data  = Hash.new  
    # for set_max_delay attribute
    @SetMaxDelay = "ON"
    
    # for report of RPT Error List
    @RptErrorList = Array.new
    @SRRNoApplyList = Array.new
    #
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
    @NoNeedAttributeList = Array.new
  end


  #
  # * Print Base Information( Tool name, Version, Copyright )
  #
  private
  def print_base
    printf("%s\(%s\) ver:%s\n",$TOOL,$SUB_TOOL,$VERSION)
    printf("Copyright (c) 2009,2010 NEC MicroSystem. All rights reserved.\n\n")
  end

  #
  # * Print Tool Usage
  #
  private
  def print_usage
    printf("\n")
    printf("Usage :  %s.rb [OPTION] -osdc <Output SDCFileName> -scr_dir <SCR Dirctory> -rmlist <RemoveFileList> -target <Socket/Plug> -constant <ON/OFF>\n",$SUB_TOOL)
    printf(" OPTION\n")
    printf("\t-h/-help         : print help message\n")
    printf("\t-v/-version      : print version\n")
    printf("\t-verbose         : execute on verbose mode\n")
    printf("\t-osdc [SDC]      : SDC File for Synplify Pro\n")
    printf("\t-iucf [UCF]      : UCF File generated by Synplify Pro\n")
    printf("\t-rpt [RPT]       : RPT File generated by Synplify Pro\n")
    printf("\t-srr [SRR]       : SRR File generated by Synplify Pro\n")
    printf("\t-mode [MODE]     : custom - Change Constraint for ICE Customize\n")
    printf("\t-rmlist [RMLIST] : Macro remove list file\n")
    printf("\t-target [socket/plug(default)] : target module\n")
    printf("\t\tSocket : add hierarchy name \"chiptop.chip.socket.\" in each constraint\n")
    printf("\t\tPlug   : add hierarchy name \"chiptop.chip.\" in each constraint\n")
    printf("\t-constant [ON(default)/OFF)] : generate constant constraint on header\n") 
    printf("\t-scope [ScopeInstance] : change instance path to ScopeInstance\n") 
    printf("\t-set_max_delay [ON/OFF] : Enable/Disenable \"set_max_delay\" attribute\n")
    printf("    \n")
  end

  # 
  #* Get argument from prompt, Select Mode and Check argument Error. 
  #  Execute error operation, if user sets unexpected option.
  #
  private
  def get_argument
    size = ARGV.size
    size -= 1
    for i in 0..size
      case ARGV[i]
      when '-h','-help' then
#        print_base
        print_usage
        exit
      when '-v','-version' then
        print_base
        printf("")
        exit
      when '-verbose' then
        $VERBOSE = true
      when '-osdc' then
        @OUT_SDC = ARGV[i+1]
        i += 1
      when '-isdc' then
        @IN_SDC = ARGV[i+1]
        i += 1
      when '-scr_dir' then
        @SCR_DIR = ARGV[i+1]
        i += 1
      when '-iucf' then
        @UCF = ARGV[i+1]
        i +=1
      when '-rpt' then
        @RPT = ARGV[i+1]
        i += 1
      when '-srr' then
        @SRR = ARGV[i+1]
        i += 1
      when '-rmlist' then
        @RMLIST = ARGV[i+1]
        i += 1
      when '-mode' then
        $MODE = ARGV[i+1]
        i += 1
      when '-target' then
        $TARGET = ARGV[i+1].downcase.to_s
        i += 1
      when '-scope' then
        $SCOPE = ARGV[i+1]
        i += 1
      when '-constant' then
        $CONSTANT = ARGV[i+1].downcase.to_s
        i += 1
        # Opt Check
        if $CONSTANT != "on" && $CONSTANT != "off"
          printf("[E] -constant option expect \"ON\" or \"OFF\".\n",ARGV[i])
          print_usage
          exit
        end          
      when '-set_max_delay' then
        @SetMaxDelay = ARGV[i+1]
        i += 1
        # Opt Check
        if @SetMaxDelay != "ON" && @SetMaxDelay != "OFF"
          printf("[E] -set_max_delay option expect \"ON\" or \"OFF\".\n",ARGV[i])
          print_usage
          exit
        end          
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        end
      end
    end 

    # * Mode Select using @SCR_DIR and @IN_SDC
    #   If non-support combination was described, execute error operation.
    if @SCR_DIR != nil && @IN_SDC == nil 
      $EXE_MODE = "DeviceMode"
      printf("@I:execute under \"DeviceMode\"\n")
    elsif @SCR_DIR == nil && @IN_SDC != nil 
      $EXE_MODE = "FPGAMode"
      printf("@I:execute under \"FPGAMode\"\n")
      printf("@E:Now not support this mode.\n")
      error
    elsif @SCR_DIR == nil && @IN_SDC == nil
      $ERROR_CNT += 1
      printf("@E:mode error. Have to input either SCR_DIR or IN_SDC\n")
      error
    else
      $ERROR_CNT += 1
      printf("@E:mode error. Not support input file combination\n")
      printf("    Generate SDC File mode : need -scr_dir,-osdc,-rmlist\n")
      printf("    Check    SDC File mode : need -isdc,-rpt,-srr\n")
      error
    end

    # * Argument Check
    case $EXE_MODE
    when "DeviceMode"
      if @OUT_SDC == nil
        $ERROR_CNT += 1
        printf("@E:\"SDC NAME\" is not specified.\n")
        print_usage
        error
      end
      if @SCR_DIR == nil
        $ERROR_CNT += 1
        printf("@E:\"SCR DIRECTORY\" is not specified.\n")
        print_usage
        error
      end
    when "FPGAMode"
      if @IN_SDC != nil
        if Common.chk_file("-isdc",@IN_SDC) == true
          $ERROR_CNT += 1
          printf("@E:\"\" file doesnt find.\n",@IN_SDC)
          print_usage
          error
        end
      end
    else
      printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
      exit
    end

    # File check only
    if @UCF != nil
      if Common.chk_file("-ucf",@UCF) == true
        $ERROR_CNT += 1
        printf("@E:\"\" file doesnt find.\n",@UCF)
        print_usage
        error
      end
    end
    if @RPT != nil
      if Common.chk_file("-rpt",@RPT) == true
        $ERROR_CNT += 1
        printf("@E:\"\" file doesnt find.\n",@RPT)
        print_usage
        error
      end
    end
    if @SRR != nil
      if Common.chk_file("-ucf",@SRR) == true
        $ERROR_CNT += 1
        printf("@E:\"\" file doesnt find.\n",@SRR)
        print_usage
        error
      end
    end
    if @RMLIST != nil
      if Common.chk_file("-rmlist",@RMLIST) == true
        $ERROR_CNT += 1
        printf("@E:\"\" file doesnt find.\n",@RMLIST)
        print_usage
        error
      end
    end

    if $MODE != "normal" && $MODE != "custom"
      printf("[E] -mode option expect \"normal\" or \"custom\".\n",ARGV[i])
      print_usage
      exit          
    end

    # Error Check for target
#    if $TRAGET != "socket" && $TARGET != "plug"
    if $TARGET != "socket" && $TARGET != "plug" &&  $TARGET != "manatiipf" &&  $TARGET != "fmake"
        $ERROR_CNT += 1
        printf("@E:Found unsupported argument(\"%s\") on \"-target\" option\n",$TARGET)
        print_usage
        error      
    end

    if $TARGET == "manatiipf" ||  $TARGET == "fmake" 
      $HIER = ""
    elsif $TARGET == "socket"
      $HIER = "chiptop.chip.socket."
    else
      $HIER = "chiptop.chip."
    end
    if $SCOPE != nil
      $HIER = $HIER + "." + $SCOPE
    end

  end

  #
  #* Analize SCR from Device
  #  * Using @SCR_DIR, @RMLIST
  #  * Get each analize/convert result infomation 
  #
  def deviceSCR
    # Pre-Step
    Common.make_dir_with_delete("tmp",1)

    device_scr = DeviceSCR.new(@SCR_DIR,@RMLIST,@SetMaxDelay)

    # Execute DeviceSCR
    device_scr.main

    # Get Each Data from DeviceSCR to use this class
    @unrecognized_attribute = device_scr.unrecognized_attribute
    @attribute_all = device_scr.attribute_all
    @UnAnalizedAttributeList = device_scr.UnAnalizedAttributeList
    @UnConvertedAttributeList = device_scr.UnConvertedAttributeList
    @NoNeedAttributeList = device_scr.NoNeedAttributeList
    @RM_MACRO = device_scr.RM_MACRO
    @scr_data = device_scr.FILE_LIST
    
  end

  #
  # Analize SDC. Execute only under FPGAMode
  #
  def analize_sdc
    printf("@I:analize SDC file\n")
    sdc = SynplifySDC.new
    sdc.sdc_read(@IN_SDC)
    sdc.analize
    @attribute_all = sdc.attribute_all
  end

  

  #
  # Analize Synplify report file
  #
  def analize_rpt
    rpt = SynplifyRPT.new(@RPT,@attribute_all)
    rpt.main($EXE_MODE) # analize & compare
    @RptErrorList = rpt.RPT_ErrorList
  end

  #
  # analize_srr
  #
  def analize_srr
    srr = SynplifySrr.new(@SRR,@attribute_all)
    srr.main($EXE_MODE) # analize & compare
    @SRRNoApplyList = srr.NoApplyList

  end

  

  #
  # analize_ucf
  #
  def analize_ucf
    from, to, through1, through2 = nil
    ucf = SynplifyUCF.new(@UCF)
    ucf.main
    ucf.Constraint.each_value{|each|
      @attribute_all.each_value{|const|
        const[1].each_value{|data|
          from =  "chiptop_chip_" + data.From_mod.to_s.gsub("/","_").gsub("[","_").gsub("]","") if data.From != nil
          to = "chiptop_chip_" + data.To_mod.to_s.gsub("/","_").gsub("[","_").gsub("]","") if data.To != nil
          through1 = "chiptop_chip_" + data.Through1_mod.to_s.gsub("/","_").gsub("[","_").gsub("]","") if data.Through1 != nil
          through2 = "chiptop_chip_" + data.Through2_mod.to_s.gsub("/","_").gsub("[","_").gsub("]","") if data.Through2 != nil
#          if from == each.From && to == each.To && through1 == each.Through1 && through2 == each.Through2
#            data.ConstCheckFlag = true if data.ConvertFlag == true
#          end
        }
      }
    }
  end



  #
  # generate SDC file
  # 
  def generate_sdc

    # Change List
    list_file = File.dirname("#{__FILE__}") + "/../conf/SDCChange.lst"
    sdc_change, custom_sentence, custom_keyword = name_change(list_file)

    file_name = @OUT_SDC
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    Common.print_file_header(f, "Constraint file for Synplify Pro",$SUB_TOOL,$VERSION,"##")

    # Using File Info
    f.printf("####  Use Following File(s) ####\n")
    Dir::glob("#{@SCR_DIR}/*").each{|name|
      f.printf("# %s\n",name)
    }

    # From constraint templete
    const = ConstCtrl.new
    f.printf("\n")
    f.printf("#\n")
    f.printf("#  Constraint for ICE Macro\n")
    f.printf("#\n")
    f.printf("\n")
    if $CONSTANT == "on"
      const.sdc_templete.each{|line|
        f.printf("%s\n",line)
      } 
    else
      f.printf("#  doesnt generate because mksdc executed under \"-constant off\" option.\n")
    end
    f.printf("\n\n")

    # From Device Constraint Information
    @attribute_all.each{|attribute_name,const|
      if const[0] != "NONEED" && const[1].size != 0
        f.printf("\n")
        f.printf("#\n")
        f.printf("#  %s\n", attribute_name)
        f.printf("#\n")
        f.printf("\n")
        const[1].each{|line,data|
          if data.ModLine != nil
            data.SDC.uniq! if data.SDC != nil
            f.printf("\n")
            f.printf("# %s ( %s L:%d )\n",line,data.FileName,data.LineNo) if data.SDC != nil
            data.SDC.each{|sdc|
              custom_flg = false
              if data.RemoveFlag == true
                f.printf("# Removed because of tool limitation or removed macro on ICE\n")              
                break
              elsif data.LimitFlag == true
#                f.printf("# Limit Constraint. the constraint include \"setup/hold\" option is limited\n",sdc)              
                f.printf("# Limit Constraint. mksdc cannot convert this constrait now.\n")              
                break
              elsif data.ConvertFlag == true && data.RemoveFlag == false && data.LimitFlag == false
                # SDC Change CUSTOM mode
                if $MODE == "custom"
                  if custom_sentence["#{sdc}"] == "match"
                    f.printf("# %s # comment out( Customize for ICE )\n",sdc)
                    custom_flag = true
                  end
                  custom_keyword.each_key{|key|
                    if /#{key}/ =~ sdc
                      f.printf("# %s # comment out( Customize for ICE )\n",sdc)                      
                      custom_flag = true
                    end
                  }
                end

                if custom_flag == true
                  # NONE
                elsif /c\:BBFCLK / =~ sdc
                  f.printf("# %s # force changed\n",sdc)
                  sdc = sdc.gsub("c\:BBFCLK ","c\:FCLK ")
                  f.printf("%s\n",sdc) if sdc_check(f,sdc,line)
                elsif sdc_change["#{sdc}"] == nil
                  f.printf("%s\n",sdc) if sdc_check(f,sdc,line)
                else
                  f.printf("# %s # force changed\n",sdc)
                  f.printf("%s\n",sdc_change["#{sdc}"]) if sdc_check(f,sdc,line)
                end

              elsif data.ConvertFlag == false
                f.printf("# Unconvert constraint\n")                
              else
                printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
                exit
              end
            }if data.SDC != nil
          end
        }
        f.printf("\n\n\n\n")
      end
    } 

    f.printf("#\n")
    f.printf("#  Unrecognized Attribute List\n")
    f.printf("#\n")
    f.printf("\n")
    @unrecognized_attribute.each{|each_const|
      f.printf("# %s ( %s L:%d)\n",each_const[0],each_const[1].FileName,each_const[1].LineNo)
    }

    f.printf("\n")
    f.printf("\n")
    f.printf("#\n")
    f.printf("#  UnAnalized Attribute List\n")
    f.printf("#\n")
    f.printf("\n")
    @UnAnalizedAttributeList.each{|each_const|
      f.printf("# %s ( %s L:%d)\n",each_const[0],each_const[1].FileName,each_const[1].LineNo)
    }


    f.printf("\n")
    f.printf("\n")
    f.printf("#\n")
    f.printf("#  UnConverted Attribute List\n")
    f.printf("#\n")
    f.printf("\n")
    @UnConvertedAttributeList.each{|each_const|
      f.printf("# %s ( %s L:%d)\n",each_const[0],each_const[1].FileName,each_const[1].LineNo)
    }

    f.printf("\n")
    f.printf("\n")
    f.printf("#\n")
    f.printf("#  NoNeed(treating no-need translating for ICE) Attribute List\n")
    f.printf("#\n")
    f.printf("\n")
    @NoNeedAttributeList.each{|each_const|
      f.printf("# %s ( %s L:%d)\n",each_const[0],each_const[1].FileName,each_const[1].LineNo)
    }
   
    f.close
    File::chmod(0100660, "#{file_name}")
  end

  #
  # SDC Check( Exist reserved word ?)
  #  - OK : return true
  #  - NG : return false (displae Error Message)
  def sdc_check(f,sdc,line)
    $RESERVED.each do |reserved|
      if /#{reserved}/ =~ sdc
        $INTERNAL_ERROR_CNT += 1
        printf("@internal_error : found illegal convertd. please check following sdc.\n")
        p sdc
        printf("- Device Constraint\n")
        p line
        Common.print_summary
        exit
      end
    end
    return true
  end


  def name_change(file)
    data = {}
    custom_sentence = {}
    custom_keyword = {}
    File.open("#{file}").each{|line|
      # next
      next if line.strip == "" || line.strip[0] == 35
      tmp = line.strip.split(",")
      id = tmp[0]
      case id
      when "C"
        data["#{tmp[1]}"] = tmp[2]
      when "CC"
        case tmp[1]
        when "sentence"
          custom_sentence["#{tmp[2]}"] = "match"
        when "keyword"
          custom_keyword["#{tmp[2]}"] = "match"
        else
          printf("internal error(%s[%d])\n",__FILE__,__LINE__)
          exit
        end
      end
    }
    return data, custom_sentence, custom_keyword
  end

  #
  # generate SDC file
  # 
=begin
  def gen_ConstraintCheckTable
    file_name = "ConstraintCheck.csv"
    f = open("#{file_name}","w")
    # From constraint templete
    const = ConstCtrl.new

    i = 1
    # Remove Constraint
    @attribute_all.each{|attribute_name,const|
      if const[0] != "NONEED" && const[1].size != 0
        const[1].each{|line,data|
          if data.ModLine != nil
            data.SDC.uniq! if data.SDC != nil
            if data.ConvertFlag == true && data.RemoveFlag == false && data.LimitFlag == false && data.AnalizeFlag == true && data.ConstCheckFlag == 0
              if data.SDC.size == 1
                f.printf("%d,%s,%s,%s\n",i,line,data.SDC.to_s,data.SynthesisReport)
              else
                f.printf("%d,%s,",i,line)
                for i in 0..data.SDC.size - 1
                  if i == 0
                    f.printf("\"%s\n",data.SDC[i])
                  elsif i == data.SDC.size - 1
                    f.printf("%s\",%s\n",data.SDC[i],data.SynthesisReport)
                  else
                    f.printf("%s\n",data.SDC[i])
                  end  
                end
              end
              i = i + 1
            end
          end
        }
      end
    } 
   
    f.close
    File::chmod(0100660, "#{file_name}")
  end
=end

  #
  # make_graph
  #
  def make_graph(num)
    str = Array.new
    num.to_i.times{
      str << "#"
    } 
    return str.to_s
  end

  

  #
  # Error operation
  #
  def error
#    print_usage
    Common.print_summary
    exit 1
  end

  #############################
  public
  #############################
  #
  #* execution
  #
  def exe
    # Ruby Version Judgment
    if RUBY_VERSION >= "1.9"
      printf("@E:mksdc only support Ruby ver : 1.8.X ( Now, executed %s )\n",RUBY_VERSION)
      printf("   please check your ruby execute setting.")
      $ERROR_CNT += 1
      Common.print_summary
      exit
    end

    Common.print_base
    get_argument
    if $EXE_MODE == "DeviceMode"
      # Under "DeviceMode" : Analize each scr file and make Data Structure for generating SDC
      deviceSCR
      generate_sdc
    elsif $EXE_MODE == "FPGAMode"
      # Under "FPGAMode"   : Analize sdc file and make Data Structure for analizing report
      analize_sdc
    end

    analize_rpt if @RPT != nil
    analize_srr if @SRR != nil
    #analize_ucf if @UCF != nil

    # generate_summary_report
    Common.make_dir_with_delete("report\/",1)
    if $EXE_MODE == "DeviceMode"
      gen_summary = GenSummarySCR.new("report\/",@attribute_all,@unrecognized_attribute,@UnAnalizedAttributeList,@UnConvertedAttributeList)
      gen_summary.make_AllScrFile(@scr_data)
      gen_summary.summary
      gen_summary.applied_report
      gen_summary.const_detail 
      gen_summary.name_change
      gen_summary.remove_const
      gen_summary.rpt_error(@RptErrorList)
      gen_summary.srr_error(@SRRNoApplyList)
#      gen_ConstraintCheckTable
    elsif $EXE_MODE == "FPGAMode"
      gen_summary = GenSummarySDC.new("report\/",@attribute_all)
      gen_summary.summary
    end
    Common.print_summary
  end
  
end


if __FILE__ == $0
  sdc_gen = MkSDC.new
  sdc_gen.exe
end


