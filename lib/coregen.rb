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

class CoreGen
  def initialize(work,mem_name,port_size,data_width,depth,type,write_width)
    @coregen_dir = work + "/coregen"
    @MEM_NAME = mem_name
    @port_size = port_size
    @data_width = data_width
    @depth = depth
    @type = type
    @write_width = write_width.to_i

    @LSF = "bs"
    @ISE_path     = "/eda_tools/xilinx/ise/13.1/ISE" # 13.1
    @coregen_path = @ISE_path + "/bin/lin64/coregen"
  end


  #
  # Generate CorGenerator Setting File
  #
  def generate_veo

    file_name = @coregen_dir + "/" + @MEM_NAME + ".veo" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = @MEM_NAME + " CoreGenerator Setting File" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")

    f.printf("# BEGIN Project Options\n")
    f.printf("SET addpads = False\n")
    f.printf("SET asysymbol = True\n")
    f.printf("SET busformat = BusFormatParenNotRipped\n")
    f.printf("SET createndf = False\n")
    f.printf("SET designentry = Verilog\n")
    f.printf("SET device = xc5vlx330\n")
    f.printf("SET devicefamily = virtex5\n")
    f.printf("SET flowvendor = Synplicity\n")
    f.printf("SET formalverification = False\n")
    f.printf("SET foundationsym = False\n")
    f.printf("SET implementationfiletype = Ngc\n")
    f.printf("SET package = ff1760\n")
    f.printf("SET removerpms = False\n")
    f.printf("SET simulationfiles = Behavioral\n")
    f.printf("SET speedgrade = -1\n")
    f.printf("SET verilogsim = True\n")
    f.printf("SET vhdlsim = False\n")
    f.printf("# END Project Options\n")
    f.printf("# BEGIN Select\n")
    f.printf("SELECT Block_Memory_Generator family Xilinx,_Inc. 3.3\n")
    f.printf("# END Select\n")
    f.printf("# BEGIN Parameters\n")
    f.printf("CSET additional_inputs_for_power_estimation=false\n")
    f.printf("CSET algorithm=Minimum_Area\n")
    f.printf("CSET assume_synchronous_clk=false\n")
    f.printf("CSET byte_size=%d\n",@write_width)
    f.printf("CSET coe_file=no_coe_file_loaded\n")
    f.printf("CSET collision_warnings=ALL\n")
    f.printf("CSET component_name=%s_cg\n",@MEM_NAME)
    f.printf("CSET disable_collision_warnings=false\n")
    f.printf("CSET disable_out_of_range_warnings=false\n")
    f.printf("CSET ecc=false\n")
    f.printf("CSET enable_a=Use_ENA_Pin\n")
    if @port_size == 1
      f.printf("CSET enable_b=Always_Enabled\n")
    elsif @port_size == 2
      f.printf("CSET enable_b=Use_ENB_Pin\n")
    end
    f.printf("CSET error_injection_type=Single_Bit_Error_Injection\n")
    f.printf("CSET fill_remaining_memory_locations=false\n")
    f.printf("CSET load_init_file=false\n")
    if @port_size == 1
      f.printf("CSET memory_type=Single_Port_RAM\n")
    elsif @port_size == 2
      f.printf("CSET memory_type=True_Dual_Port_RAM\n")
    end
    f.printf("CSET operating_mode_a=WRITE_FIRST\n")
    f.printf("CSET operating_mode_b=WRITE_FIRST\n")
    f.printf("CSET output_reset_value_a=0\n")
    f.printf("CSET output_reset_value_b=0\n")
    f.printf("CSET pipeline_stages=0\n")
    f.printf("CSET port_a_clock=100\n")
    f.printf("CSET port_a_enable_rate=100\n")
    f.printf("CSET port_a_write_rate=50\n")
    f.printf("CSET port_b_clock=100\n")
    f.printf("CSET port_b_enable_rate=100\n")
    f.printf("CSET port_b_write_rate=50\n")
    f.printf("CSET primitive=8kx2\n")
    f.printf("CSET read_width_a=%d\n",@data_width)
    f.printf("CSET read_width_b=%d\n",@data_width)
    f.printf("CSET register_porta_output_of_memory_core=false\n")
    f.printf("CSET register_porta_output_of_memory_primitives=false\n")
    f.printf("CSET register_portb_output_of_memory_core=false\n")
    f.printf("CSET register_portb_output_of_memory_primitives=false\n")
    f.printf("CSET remaining_memory_locations=0\n")
    f.printf("CSET reset_memory_latch_a=false\n")
    f.printf("CSET reset_memory_latch_b=false\n")
    f.printf("CSET reset_priority_a=CE\n")
    f.printf("CSET reset_priority_b=CE\n")
    f.printf("CSET reset_type=SYNC\n")
    if @type == "ByteWrite"
      f.printf("CSET use_byte_write_enable=true\n")
    else
      f.printf("CSET use_byte_write_enable=false\n")
    end
    f.printf("CSET use_error_injection_pins=false\n")
    f.printf("CSET use_regcea_pin=false\n")
    f.printf("CSET use_regceb_pin=false\n")
    f.printf("CSET use_rsta_pin=false\n")
    f.printf("CSET use_rstb_pin=false\n")
    f.printf("CSET write_depth_a=%d\n",@depth)
    f.printf("CSET write_width_a=%d\n",@data_width)
    f.printf("CSET write_width_b=%d\n",@data_width)
    f.printf("# END Parameters\n")
    f.printf("GENERATE\n")
    
    f.close
  end

  #
  # Run CoreGenerator
  #
  def run_coregen
    printf("@I:Running Coregenerator...\n")
    # Change Directory
    Dir.chdir("./#{@coregen_dir}")
    command = @LSF + " " + @coregen_path + " -b " + @MEM_NAME + ".veo"
    system("#{command}")
    Dir.chdir("../../")
    printf("Done\n")
  end

  #
  # Main
  #
  def main
    generate_veo
    # FileCheck
    verilog_file = @coregen_dir + "/" + @MEM_NAME + "_cg.v"
#    if FileTest.exist?(verilog_file) == false
      run_coregen
#    else
#      printf("@I:Skipped execute CoreGenerator because %s already exist\n",verilog_file)
#    end
  end
end
