#!/usr/bin/ruby
##################################################################
#
#  Memory
#
#  Function : Generate Memory Using Xilinx CoreGenerator
#
#  Author   : Koji HIJIKURO
#
###################################################################
require "common"

class CoregenTest
  def initialize(mem_name)
    @MEM_NAME = mem_name
    @LSF = "l4batch2"
  end

  def generate_prj

    file_name = "test/" + @MEM_NAME + ".prj" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = @MEM_NAME + " Prj File for Synthesis" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")

    f.printf("#project files\n")
    f.printf("add_file -verilog \"../mem/%s.v\"\n",@MEM_NAME)
    f.printf("\n")
    f.printf("\n")
    f.printf("#implementation: \"rev_%s\"\n",@MEM_NAME)
    f.printf("impl -add rev_1 -type fpga\n")
    f.printf("\n")
    f.printf("#\n")
    f.printf("#implementation attributes\n")
    f.printf("\n")
    f.printf("set_option -vlog_std v2001\n")
    f.printf("set_option -project_relative_includes 1\n")
    f.printf("\n")
    f.printf("#device options\n")
    f.printf("set_option -technology Virtex5\n")
    f.printf("set_option -part XC5VLX110\n")
    f.printf("set_option -package FF676\n")
    f.printf("set_option -speed_grade -2\n")
    f.printf("set_option -part_companion \"\"\n")
    f.printf("\n")
    f.printf("#compilation/mapping options\n")
    f.printf("set_option -use_fsm_explorer 0\n")
    f.printf("set_option -top_module \"%s\"\n",@MEM_NAME)
    f.printf("\n")
    f.printf("# mapper_options\n")
    f.printf("set_option -frequency auto\n")
    f.printf("set_option -write_verilog 1\n")
    f.printf("set_option -write_vhdl 0\n")
    f.printf("\n")
    f.printf("# Xilinx Virtex2\n")
    f.printf("set_option -run_prop_extract 1\n")
    f.printf("set_option -maxfan 10000\n")
    f.printf("set_option -disable_io_insertion 1\n")
    f.printf("set_option -pipe 1\n")
    f.printf("set_option -update_models_cp 0\n")
    f.printf("set_option -retiming 0\n")
    f.printf("set_option -no_sequential_opt 0\n")
    f.printf("set_option -fixgatedclocks 3\n")
    f.printf("set_option -fixgeneratedclocks 0\n")
    f.printf("\n")
    f.printf("# Xilinx Virtex6\n")
    f.printf("set_option -enable_prepacking 1\n")
    f.printf("\n")
    f.printf("# NFilter\n")
    f.printf("set_option -popfeed 0\n")
    f.printf("set_option -constprop 0\n")
    f.printf("set_option -createhierarchy 0\n")
    f.printf("\n")
    f.printf("# sequential_optimization_options\n")
    f.printf("set_option -symbolic_fsm_compiler 1\n")
    f.printf("\n")
    f.printf("# Compiler Options\n")
    f.printf("set_option -compiler_compatible 0\n")
    f.printf("set_option -resource_sharing 1\n")
    f.printf("\n")
    f.printf("#VIF options\n")
    f.printf("set_option -write_vif 1\n")
    f.printf("\n")
    f.printf("#automatic place and route (vendor) options\n")
    f.printf("set_option -write_apr_constraint 1\n")
    f.printf("\n")
    f.printf("#set result format/file last\n")
    f.printf("project -result_file \"./rev_%s/%s.edf\"\n",@MEM_NAME,@MEM_NAME)
    f.printf("impl -active \"rev_%s\"\n",@MEM_NAME)        
  end
  
  #
  # synthesis
  #
  def synthesis
    printf("@I:Synthesis")
    command = @LSF + " synplify_pro -batch " + "test/" + @MEM_NAME + ".prj"
    system("#{command}")
  end

  def main
    Common.make_dir("test")
    generate_prj
#    synthesis
  end
end
