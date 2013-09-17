############################################################
#
#  synthesis.rb for Synplify Pro Synthesis Operation
#
#   Author    : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#   Date      : 2009/08/07
#   Version   : 0.1
#
############################################################
#
# [Operation]
#   This script is for Synplify Pro Synthesis, and you can 
#   use sub-script ( Considerd calling main-script)
#
#   In a main-script, you have to set following varigable
#   before execution.
#     $WORK_DIR    : generate .prj file in this directory
#     $FILE(Array) : HDL Files intended synthesis
#     $SDC(Array)  : Suggest, SDC Files intended synthesis
#
# [Function]
#   gen_prj   : generate project file for synplify pro
#   exe_syn   : execute synthesis
#
############################################################
require "message"
require "system"

class Synthesis < System
 
  def initialize()
  end

  def gen_prj(file_name)
    printf("@I:generate %s/%s\n",$WORK_DIR, file_name)
    f = open("#{$WORK_DIR}/#{file_name}","w")
    print_file_header(f,"Project File for Synpliry Pro")
    f.printf("#project files\n")
    $FILE.each{|file_name|
      f.printf("add_file -verilog \"%s\"\n",file_name)
    }
    if $DB == true
      f.printf("add_file -verilog \"../DB/mf2_prim.v\"\n")
    end
    $SDC.each{|sdc_name|
      f.printf("add_file -constraint \"%s\"\n",sdc_name)
    }
    f.printf("\n")
    f.printf("\n")
    f.printf("#implementation: \"rev_%s\"\n",$PROJECT)
    f.printf("impl -add rev_%s -type fpga\n",$PROJECT)
    f.printf("\n")
    f.printf("#device options\n")
    f.printf("set_option -technology %s\n",$TECHNOLOGY)
    f.printf("set_option -part %s\n",$PART)
    f.printf("set_option -package %s\n",$PACKAGE)
    f.printf("set_option -speed_grade %s\n",$SPEED_GRADE)
    f.printf("set_option -part_companion \"\"\n")
    f.printf("\n")
    f.printf("#compilation/mapping options\n")
    f.printf("set_option -use_fsm_explorer 0\n")
    f.printf("set_option -top_module \"%s\"\n",$TOP_MODULE)
    f.printf("\n")
    f.printf("# sequential_optimization_options\n")
    f.printf("set_option -symbolic_fsm_compiler 0\n")
    f.printf("\n")
    f.printf("# Compiler Options\n")
    f.printf("set_option -compiler_compatible 0\n")
    f.printf("set_option -resource_sharing 1\n")
    f.printf("\n")
    f.printf("# mapper_options\n")
    f.printf("set_option -frequency 40\n")
    f.printf("set_option -write_verilog 1\n")
    f.printf("set_option -write_vhdl 0\n")
    f.printf("\n")
    f.printf("# Xilinx Virtex2\n")
    f.printf("set_option -run_prop_extract 1\n")
    f.printf("set_option -maxfan 10000\n")
    f.printf("set_option -disable_io_insertion 0\n")
    f.printf("set_option -pipe 0\n")
    f.printf("set_option -update_models_cp 0\n")
    f.printf("set_option -retiming 0\n")
    f.printf("set_option -no_sequential_opt 0\n")
    if $FIX_GATED_CLOCK == "ON"
      f.printf("set_option -fixgatedclocks 3\n")
    else
      f.printf("set_option -fixgatedclocks 0\n")
    end
    f.printf("set_option -fixgeneratedclocks 0\n")
    f.printf("\n")
    f.printf("#VIF options\n")
    f.printf("set_option -write_vif 1\n")
    f.printf("\n")
    f.printf("#automatic place and route (vendor) options\n")
    f.printf("set_option -write_apr_constraint 1\n")
    f.printf("\n")
    f.printf("#set result format/file last\n")
    f.printf("project -result_file \"rev_%s/%s.edf\"\n",$PROJECT,$PROJECT)
    f.printf("\n")
    f.printf("#\n")
    f.printf("#implementation attributes\n")
    f.printf("\n")
    f.printf("set_option -vlog_std v2001\n")
    f.printf("set_option -project_relative_includes 1\n")
    f.printf("impl -active \"rev_%s\"\n",$PROJECT)
    f.printf("\n")
    f.close
  end

  def exe_syn
    if $VERBOSE == true
      cmd = "synplify_pro -batch #{$WORK_DIR}/#{$PROJECT}.prj"
    else
      cmd = "synplify_pro -batch #{$WORK_DIR}/#{$PROJECT}.prj >& /dev/null"
    end      
    printf("@I:start synthesis using Synplify Pro(cmd:%s)\n",cmd)
    if system("#{cmd}") == false
      case $?
      when 512 then
        printf("@E: There is compile error on synthesis. please see %s/rev_%s/%s.srr file\n",$WORK_DIR,$PROJECT,$PROJECT)
        $ERROR_CNT += 1
        print_summary
        exit
      when 1024 then
        printf("@N: Cannnot get Synplify Pro license. try get license again after 5sec.\n")
        sleep 5
        exe_syn
      else
        printf("@E:There is some problem on synthesis. Status code is %d.\n",$?)
        $ERROR_CNT += 1
        print_summary
        exit
      end
    else
      printf("@I:Synthesis finished in succesufully. Status code is %d\n", $?)
    end
    
  end
end
