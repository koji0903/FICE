#!/usr/bin/ruby
#############################################################
#
# Templete
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Descripton of this tool
#
# [Usage]
# -%ruby ConstChecker.rb -u(--ucf) [UCF File] -d(--udef) [UDEF File] -i(--ise) [ISE WorkingDir]
# If you want to get more information. plese use "--help" option.
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
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"
require "optparse"
require "bld_report"
require "map_report"
require "par_report"
require "synplicity_ucf"

#
# Global Setting
#
$SUB_TOOL        = "ConstChecker" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION # For OptParse



#
# Main Class
#
class ConstChecker

  include ISEPar
  include ISEMap
  include ISEBld
  include UCF

  attr_reader :SDC
  attr_reader :UCF
  attr_reader :ISE
  attr_reader :UDEF
  attr_reader :PAR

  EXCEPT_CONST = ["define_attribute",
                  "define_global_attribute",
                  "define_clock",
                  "define_clock_delay",
                 ]

  def initialize
    @SDC = nil   # SDC File from option
    @UCF = nil   # UCF File from option
    @ISE = nil   # ISE Working Directory
    @UDEF = nil  # UDEF File form option
    @BLD = nil   # ISE Bld report
    @MAP = nil   # ISE Map report
    @PAR = nil   # ISE Par report
    @TWR = nil   # ISE Twr report
    @AnalyzedData = Array.new
    
    # UnknownSDC ( not found constraint in UCF File )
    @UnknownSDC = Array.new
    
    # bld analyzed data
    @bld_inf = nil
    # map analyzed data
    @map_inf = nil
    # par analyzed data
    @par_inf = nil
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
      opt.on('--verbose',"verbose mode"){|v| $VERBOSE = v}
      opt.on('-s SDC','--sdc SDC','specify SDC file'){|v| @SDC = v}
      opt.on('-u UCF','--ucf UCF','specify UCF file'){|v| @UCF = v}
      opt.on('-i ISEDir','--ise ISEDir','specify ISE Working Directory path'){|v| @ISE = v}
      opt.on('-d UDEF','--udef UDEF','specify UDEF file'){|v| @UDEF = v}
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:Not support  "#{ARGV}" option or need argument using this option.
EOB
      return false
    end
  end
  
  def check_argument
    # Option user defined is enough? or not?
    if @SDC == nil || @UCF == nil || @ISE == nil || @UDEF == nil
      error(1)
      return false
    end
    # File Check for SDC
    return false if Common.chk_file("-s/--sdc",@SDC) == 1 # Error
    # File Check for UCF
    return false if Common.chk_file("-u/--ucf",@UCF) == 1 # Error
    # File Check for UDEF
    return false if Common.chk_file("-d/--udef",@UDEF) == 1 # Error

    # File Check for ISE working directory
    @BLD = @ISE + "/" + "#{$TOP_MODULE}.bld"
    @MAP = @ISE + "/" + "#{$TOP_MODULE}_map.map"
    @PAR = @ISE + "/" + "#{$TOP_MODULE}.par"
    @TWR = @ISE + "/" + "#{$TOP_MODULE}.twr"

    # File Check
    return false if Common.chk_file("-ise",@BLD) == 1 # Error
    return false if Common.chk_file("-ise",@MAP) == 1 # Error
    return false if Common.chk_file("-ise",@PAR) == 1 # Error
    return false if Common.chk_file("-ise",@TWR) == 1 # Error

    return true
  end

  #
  # Get SDC Information
  #  
  def get_SDCInfo(sdc_file)
    obj = MksdcSDC.new(sdc_file)
    return obj.main
  end
  
  #
  # Get UCF UsedConstraintList
  #
  def get_UCFConstraint(ucf_file)
    obj = MkUCF.new(ucf_file)
    return obj.main
  end

  #
  # Analyze ISE Files(bld,par,map)
  #
  def get_ISEInfo(bld_file,map_file,par_file,udef_file)
    # bld
    bld = BldReport.new(bld_file)
    @bld_inf = bld.main
    # map
    map = MapReport.new(map_file)
    @map_inf = map.main
    # par
    par = ParReport.new(par_file,udef_file)
    @par_inf = par.main

    return @bld_inf, @map_inf, @par_inf
  end 

  #
  # Make merge data for analyzed_data
  #  analyzed_data : Use generating report
  #
  def make_merge_data(sdc_inf,ucf_inf,ise_inf=nil)
    obj = ConstCompare.new(sdc_inf,ucf_inf)
    # Make apanlized_data
    analyzed_data,total_num,@UnknownSDC = obj.main
    # Update analyzed_data using Bld information
    obj = AddBldResult.new(analyzed_data,ise_inf[0])
    analyzed_data = obj.main
    # Update analyzed_data using Map information
    obj = AddMapResult.new(analyzed_data,ise_inf[1])
    analyzed_data = obj.main
    # Update analyzd_data using Par information(TS Inf)
    obj = AddParResult.new(analyzed_data,ise_inf[2])
    analyzed_data = obj.main
    return analyzed_data,total_num
  end

  #
  # Generate Report file
  #
  def generate_report(all_ana,total_num)
    # make output directory
    dir_name = "result"
    Common.make_dir_with_delete("#{dir_name}")
    file_name = dir_name + "/" + $SUB_TOOL + ".rep"
    f = open("#{file_name}","w")
    comment = "Constraint Report from SDC/UCF/ISE Report" 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
    
    # Calcurate "conv attr"
    num_unconv_attr = 0
    num_ana_attr = 0
    all_ana.each{|attr,sdc|
      next if EXCEPT_CONST.index("#{attr}") != nil
      num_ana_attr += sdc.size
      unused_num = 0
      sdc.each{|each_sdc|
        unused_num += 1 if each_sdc.syn_flag == "unused"
      }
      num_unconv_attr += unused_num
    }
    
    # calcurate inogred constraint
    ignored_const = 0
    all_ana.each{|attr,sdc|
      next if EXCEPT_CONST.index("#{attr}") != nil
      sdc.each{|each_sdc|
        if each_sdc.syn_flag == "used" && each_sdc.ise_flag == "IgnoredConstraint"
          ignored_const += 1
        end
      }
    }

    # calcurate constraint with ignored
    with_ignored_const = 0
    all_ana.each{|attr,sdc|
      next if EXCEPT_CONST.index("#{attr}") != nil
      sdc.each{|each_sdc|
        if each_sdc.syn_flag == "used" && each_sdc.ise_flag == "IncludeIgnoredConstraint"
          with_ignored_const += 1
        end
      }
    }


    f.print <<EOB
######################################
## 1. Constrait Summary
######################################

  * The number of Unknows sdc constraint : #{@UnknownSDC.size}
     * Found SDC file, but not found UCF file.
       - UCF file may be changed after Synthesis, or
       - Cannnot match constraint senthese because of sdc description style.
         (please contact fpga-ice ML<fpga_ice-rms@lm.renesas.com>)    
     * You can get constraint details on "2. Unknown SDC Constraint"

  * The number of Analyzed sdc constraint : #{total_num}

  * The number of sdc constraint with analyzed constraint using synplicity.ucf : #{num_ana_attr}
     * Except following attribute because cannot get from Synplify Report
EOB
    EXCEPT_CONST.each{|attr|
      f.printf("\t%s\n",attr)
    }

    f.print <<EOB

  * The number of Un-used constraint by Synplify Pro: #{num_unconv_attr}
      * You can get constraint details on "4. UnUsed Constraint"

  * The number of ignored constraint on ISE Map/Par : #{ignored_const}
      * You can get constraint details on "5. UnUsed Constraint ( Ignored constarint on map/par )"

  * The number of constraint with ignored constraint on ISE Ngdbuld : #{with_ignored_const}
      * You can get constraint details on "6. Used Constraint ( include ignored constarint on Ngdbuild )"

######################################
## 2. Unknown SDC Constraint 
######################################

EOB
    if @UnknownSDC != nil
      i = 1
      @UnknownSDC.each{|sdc|
        f.printf("[%03d] %s\n",i,sdc)
        i += 1
      }
    else
      f.printf("NONE\n")
    end
      
    f.print <<EOB

######################################
## 3. SDC Analyze table
######################################

+--+-------------------------+----------------+----------------+
|  |               Attribute |    No. of attr | No. of use attr|
+--+-------------------------+----------------+----------------+
EOB
    num = 0
    col2_total = 0
    col3_total = 0
    all_ana.sort_by{|attr,sdc|
      -sdc.size                 # Sort by number of sdc
    }.each{|attr,sdc|
      cnt_rate = sdc.size.to_f/total_num.to_f*100
      cnt_rate_space = ""
      if cnt_rate == 100
        cnt_rate_space = ""
      elsif cnt_rate >= 10
        cnt_rate_space = " "
      else
        cnt_rate_space = "  "
      end

      used_num = 0
      sdc.each{|each_sdc|
        used_num += 1 if each_sdc.syn_flag == "used"
      }
      used_rate = used_num.to_f/sdc.size.to_f*100
      used_rate_space = ""
      if used_rate == 100
        used_rate_space = ""
      elsif used_rate >= 10
        used_rate_space = " "
      else
        used_rate_space = "  "
      end
      next if EXCEPT_CONST.index("#{attr}") != nil
      f.printf("|%2d|%24s |%3d/%3d(%s%3.2f%%)|%3d/%3d(%s%3.2f%%)|\n",
               num,                                        # 0 col
               attr,                                       # 1 col
               sdc.size,num_ana_attr,cnt_rate_space,cnt_rate, # 2 col
               used_num,sdc.size,used_rate_space,used_rate # 3 col
               )
      num += 1
      col2_total += sdc.size
      col3_total += used_num
    }
    f.print <<EOB
+--+-------------------------+----------------+----------------+
EOB
    f.printf("|  |                   TOTAL |%3d/%3d( %3.2f%%)|%3d/%3d( %3.2f%%)|\n",
             col2_total, num_ana_attr, col2_total.to_f/total_num.to_f*100, # 2 col
             col3_total, col2_total, col3_total.to_f/col2_total.to_f*100
             )

    f.print <<EOB
+--+-------------------------+----------------+----------------+

No. of use attr : Used attribte through Synplify Pro synthesis.

    
# Each Attribute Sentence

######################################
## 4. UnUsed Constraint
######################################

EOB
    i = 1
    all_ana.sort_by{|attr,sdc|
      -sdc.size                 # Sort by number of sdc
    }.each{|attr,sdc|
      next if EXCEPT_CONST.index("#{attr}") != nil
      sdc.each{|each_sdc|
        if each_sdc.syn_flag == "unused"
          f.printf("[%03d] %s\n",i, each_sdc.sdc_name)
          i += 1
        end
      }
      f.printf("\n")
    }

    f.print <<EOB

######################################
## 5. UnUsed Constraint ( Ignored constarint on map/par )
######################################

EOB
    i = 1
    print_flag = false
    all_ana.sort_by{|attr,sdc|
      -sdc.size                 # Sort by number of sdc
    }.each{|attr,sdc|
      next if EXCEPT_CONST.index("#{attr}") != nil
      sdc.each{|each_sdc|
        if each_sdc.syn_flag == "used" && each_sdc.ise_flag == "IgnoredConstraint"
          print_flag = true
          f.printf("[%03d]%s\n\n",i,each_sdc.sdc_name)
          i += 1
          each_sdc.ucf_const.each{|each_ucf|
            f.printf("  %s (line:%d)\n",each_ucf[1],each_ucf[0])
          } if each_sdc.ucf_const.size != 0
          if each_sdc.rep_result != nil
            f.printf("  [P&R Result include Timing Constraint] %s\n",each_sdc.rep_result.Result)
          end
          f.printf("\n\n")
        end
      }
    }
    if print_flag == false
      f.printf("NONE\n\n")
    end


    f.print <<EOB

######################################
## 6. Used Constraint ( include ignored constarint on Ngdbuild )
######################################

EOB
    i = 1
    print_flag = false
    all_ana.sort_by{|attr,sdc|
      -sdc.size                 # Sort by number of sdc
    }.each{|attr,sdc|
      next if EXCEPT_CONST.index("#{attr}") != nil
      sdc.each{|each_sdc|
        if each_sdc.syn_flag == "used" && each_sdc.ise_flag == "IncludeIgnoredConstraint"
          print_flag = true
          f.printf("[%03d]%s\n\n",i,each_sdc.sdc_name)
          i += 1
          each_sdc.ucf_const.each{|each_ucf|
            f.printf("  %s (line:%d)\n",each_ucf[1],each_ucf[0])
          } if each_sdc.ucf_const.size != 0
          if each_sdc.rep_result != nil
            f.printf("  [P&R Result include Timing Constraint] %s\n",each_sdc.rep_result.Result)
          end
          f.printf("\n\n")
        end
      }
    }
    if print_flag == false
      f.printf("NONE\n\n")
    end

    f.print <<EOB

######################################
## 7. Used Constraint
######################################

EOB
    i = 1
    print_flag = false
    all_ana.sort_by{|attr,sdc|
      -sdc.size                 # Sort by number of sdc
    }.each{|attr,sdc|
      next if EXCEPT_CONST.index("#{attr}") != nil
      sdc.each{|each_sdc|
        if each_sdc.syn_flag == "used" && each_sdc.ise_flag == "none"
          print_flag = true
          f.printf("[%03d]%s\n\n",i,each_sdc.sdc_name)
          i += 1
          each_sdc.ucf_const.each{|each_ucf|
            f.printf("  %s (line:%d)\n",each_ucf[1],each_ucf[0])
          } if each_sdc.ucf_const.size != 0
          if each_sdc.rep_result != nil
            f.printf("  [P&R Result include Timing Constraint] %s\n",each_sdc.rep_result.Result)
          end
          f.printf("\n\n")
        end
      }
    }
    if print_flag == false
      f.printf("NONE\n\n")
    end

    f.close
    return true
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
    if RUBY_VERSION != "1.8.5"
      printf("@E:mksdc only support Ruby ver : 1.8.5 ( Now, executed %s )\n",RUBY_VERSION)
      printf("   please check your ruby execute setting.")
      $ERROR_CNT += 1
      Common.print_summary
      exit
    end
    get_argument
    # Check Argument
    error if check_argument == false
    # Get SDC Information
    analyzed_data,total_num = make_merge_data(
                                              get_SDCInfo(@SDC),
                                              get_UCFConstraint(@UCF),
                                              get_ISEInfo(@BLD,@MAP,@PAR,@UDEF)
                                              )
    generate_report(analyzed_data,total_num)
    Common.print_summary
  end


  def error(num=0,param=nil)
    printf("@E%03d:",num)
    $ERROR_CNT += 1
    case num
    when 1
      printf("Not enough options was described.see help message\n")
    end
    printf("\n")
    Common.print_summary
    exit
    true
  end  
end


if __FILE__ == $0
  obj = ConstChecker.new
  obj.main
end

