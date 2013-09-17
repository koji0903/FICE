#!/usr/bin/ruby
##################################################################
#
#  XST
#
#  Function : Execute synthesis using Xilinx XST
#
#  Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
###################################################################
#
# [OPERATION]
#   - Execute synthesis using Xilinx ISE
#
# [USAGE]
#   - instance XST.new(@file_name,@module_name,@work_dir)
#      @file_name    : compiled file
#      @module_name  : top module name
#      @work_dir     : save setting file and result file from XST
#
# [OUTPUT]
#   - Each setting file for XST generaeted by xst.rb
#   - Each result file from XST
#
###################################################################
require "common"

class Inst
  attr_accessor  :FileName
  attr_accessor  :ModuleName
  attr_accessor  :InstName
  def initialize
    @FileName   = nil
    @ModuleName = nil
    @InstName   = nil
  end
end

class Report
  attr_accessor  :file_name
  attr_accessor  :module_name
  attr_accessor  :hdl_data
  attr_accessor  :rep_data
  attr_accessor  :inst

  def initialize
    @file_name = Array.new(0){[nil]}
    @module_name = nil
    @hdl_data  = Array.new(0){[nil]}
    @rep_data  = Array.new
    @inst      = Array.new
  end
end

class XST

  attr_accessor :ModuleInfo
  #
  # initialize
  #
  def initialize(file_n=nil,module_n=nil,work_d=nil, modfile=nil)
    @file_name = file_n
    @module_name = module_n
    @work_dir = work_d
    @ModuleInfo = Array.new
    @ModFile = modfile
  end

  #
  # make WorkDir
  #
  def make_dir
    Common.make_dir(@work_dir)
    Common.make_dir("#{@work_dir}/projnav.tmp")
  end

  #
  # generate XST File for XST execution
  #
  def gen_xst
    filename = "#{@work_dir}/#{@module_name}.xst"
    printf("@I:Generate XST File(%s)\n",filename)
    f = File.open("#{filename}","w")

    f.printf("set -tmpdir \"%s/projnav.tmp\"\n",@work_dir)
    f.printf("set -xsthdpdir \"%s\"\n",@work_dir)
    f.printf("run\n")
    f.printf("-ifn %s/%s.prj\n",@work_dir,@module_name)
    f.printf("-ifmt mixed\n")
    f.printf("-ofn %s\n",@module_name)
    f.printf("-ofmt NGC\n")
    f.printf("-p xc4vlx80-10-ff1148\n")
    f.printf("-top %s\n",@module_name)
    f.printf("-opt_mode Speed\n")
    f.printf("-opt_level 1\n")
    f.printf("-power NO\n")
    f.printf("-iuc NO\n")
    f.printf("-lso %s/%s.lso\n",@work_dir,@module_name)
    f.printf("-keep_hierarchy NO\n")
    f.printf("-netlist_hierarchy as_optimized\n")
    f.printf("-rtlview Yes\n")
    f.printf("-glob_opt AllClockNets\n")
    f.printf("-read_cores YES\n")
    f.printf("-write_timing_constraints NO\n")
    f.printf("-cross_clock_analysis YES\n")
    f.printf("-hierarchy_separator /\n")
    f.printf("-bus_delimiter <>\n")
    f.printf("-case maintain\n")
    f.printf("-slice_utilization_ratio 100\n")
    f.printf("-bram_utilization_ratio 100\n")
    f.printf("-dsp_utilization_ratio 100\n")
    f.printf("-verilog2001 YES\n")
    f.printf("-fsm_extract YES -fsm_encoding Auto\n")
    f.printf("-safe_implementation No\n")
    f.printf("-fsm_style lut\n")
    f.printf("-ram_extract Yes\n")
    f.printf("-ram_style Auto\n")
    f.printf("-rom_extract Yes\n")
    f.printf("-mux_style Auto\n")
    f.printf("-decoder_extract YES\n")
    f.printf("-priority_extract YES\n")
    f.printf("-shreg_extract YES\n")
    f.printf("-shift_extract YES\n")
    f.printf("-xor_collapse YES\n")
    f.printf("-rom_style Auto\n")
    f.printf("-auto_bram_packing NO\n")
    f.printf("-mux_extract YES\n")
    f.printf("-resource_sharing YES\n")
    f.printf("-async_to_sync NO\n")
    f.printf("-use_dsp48 auto\n")
    f.printf("-iobuf YES\n")
    f.printf("-bufg 32\n")
    f.printf("-bufr 40\n")
    f.printf("-register_duplication YES\n")
    f.printf("-register_balancing No\n")
    f.printf("-slice_packing YES\n")
    f.printf("-optimize_primitives NO\n")
    f.printf("-use_clock_enable Auto\n")
    f.printf("-use_sync_set Auto\n")
    f.printf("-use_sync_reset Auto\n")
    f.printf("-iob auto\n")
    f.printf("-equivalent_register_removal YES\n")
    f.printf("-slice_utilization_ratio_maxmargin 5\n")

    f.close
  end

  #
  # generate Prj File for XST execution
  #
  def gen_prj
    filename = "#{@work_dir}/#{@module_name}.prj"
    printf("@I:Generate Prj File(%s)\n",filename)
    f = File.open("#{filename}","w")
    tmp = Array.new
    tmp << @file_name
    tmp.uniq!
    tmp.each{|file|
      f.printf("verilog work \"%s\"\n",file)
    }
    f.close
  end

  #
  # generate Lso File for XST execution
  #
  def gen_lso
    filename = "#{@work_dir}/#{@module_name}.lso"
    printf("@I:Generate lso File(%s)\n",filename)
    f = File.open("#{filename}","w")
    f.printf("work\n")
    f.close
  end
  
  #
  # clean
  #
  def clean
    Dir::glob("*.ngc"){|file|
      File.delete("#{file}")
    }
    Dir::glob("*.ngr"){|file|
      File.delete("#{file}")
    }
    Dir::glob("*.xrpt"){|file|
      File.delete("#{file}")
    }
    
    # delte work directory
    delete_dir = "#{@work_dir}/work/"
    dirlist = Dir::glob(delete_dir + "**/").sort {
      |a,b| b.split('/').size <=> a.split('/').size
    }
    dirlist.each {|d|
      Dir::foreach(d) {|f|
        File::delete(d+f) if ! (/\.+$/ =~ f)
      }
      Dir::rmdir(d)
    }
    
  end


  #
  # get_inst
  #
  def get_inst(rep)
    rep_data = rep.rep_data
    hdl_data = rep.hdl_data
    inst_data = Array.new

    rep_data.each{|line|
      # Undefined Module on same file
      if /^ERROR\:HDLCompilers\:87/ =~ line
        inst = Inst.new
        line = line.gsub(" ","") # delte space
        /^\S*\"(\S*)\"line(\d*)\S*\'(\S*)\'/ =~ line # get FileName,LineNumber,ModuleName
        filename = $1
        line_num  = $2.to_i - 1
        module_name = $3
        printf(" %s : %s|%s|%s\n",line,$1,$2,$3) if $VERBOSE == true

        # search hdl file
        if @ModFile["#{module_name}"] == nil
          inst.FileName = "NONE"
        else
          inst.FileName = @ModFile["#{module_name}"] 
        end

        inst.ModuleName = module_name
        # Get InstanceName using FileName & LineNum
        open("#{filename}"){|file|
          line_tmp = file.readlines[line_num]
          printf(" - @1:seach line: %s\n",line_tmp) if $VERBOSE == true
          line_tmp = line_tmp.gsub("\t"," ")
          #          str = Common.remove_after( line_tmp, '\(' )
          if /\(/ =~ line_tmp 
            num = line_tmp.index("\(")
            tt = line_tmp.unpack("a#{num}") # separate after "(" string
            str = tt[0]
          else
            str = line_tmp
          end
          array = str.split(" ")
          if array[1] == nil
            $WARNING_CNT += 1
            printf("@E:Do not recognize Instance name in %s\n",line_tmp)
          end
          inst.InstName = array[1]
        }
        # Add data to Inst Structure
        inst_data << inst
      end

      # Defined Module on same file
      if /^Analyzing\ hierarchy\ for\ module/ =~ line
        module_name_tmp = ""
        line = line.gsub(" ","") # delete space
        line = line.gsub("\t"," ") # delete space
        /^\S*\<(\S*)\>\S*\<(\S*)\>/ =~ line
        module_name_tmp = $1.to_s

        next if module_name_tmp == @module_name
        printf("%s : %s\n",line,module_name_tmp) if $VERBOSE == true

        # Get FileName
        # Get InstanceName
        hdl_data.each{|ll|
          ll = ll.gsub("\t"," ") # delete space          
          ll = ll.gsub("\r","") # delete space          
          if /^\s*#{module_name_tmp}\s+[a-zA-Z]/ =~ ll
            printf(" - @2:seach line: %s\n",ll) if $VERBOSE == true
#            str = Common.remove_after( ll, "\(" )
            if /\(/ =~ ll 
              num = ll.index("\(")
              tt = ll.unpack("a#{num}") # separate after "(" string
              str = tt[0]
            else
              str = ll
            end
            if str.size != 0
              array = str.split(" ")
              inst = Inst.new
              inst.FileName = @file_name
              inst.InstName = array[1].to_s             
              inst.ModuleName = module_name_tmp.to_s
              inst_data << inst
            else
              printf("@E:Unepected operaion. %s\n", ll)
              exit
            end
          end
        }
      end
    }
    inst_data.each{|inst|
      printf("@I:Instance Information\n")
      printf("      - ModuleName : %s\n", inst.ModuleName)
      printf("      - InstName   : %s\n",inst.InstName)
    } if $VERBOSE == true
    
    return inst_data
  end

  #
  #
  # get report file(*.syr)
  #
  def get_report
    syr_file = @work_dir + "/" + @module_name + ".syr"
    printf("@I:Read %s, get File Name and Instance Information\n",syr_file) if $VERBOSE
    rep = Report.new    # Array of Report
    rep.file_name = @file_name
    rep.module_name = @module_name
    rep.hdl_data = Common.file_read(@file_name)

    # trimming only current module description
    hdl_data_tmp = Array.new
    module_in = false
    rep.hdl_data.each{|ll|
      if /^\/\// =~ ll  # skip comment line
        # non-operation
      elsif module_in == true
        hdl_data_tmp << ll
        if /^endmodule/ =~ ll
          module_in == false
          break
        end
      elsif /^module\s*#{@module_name}\s+\w*/ =~ ll
        hdl_data_tmp << ll
        module_in = true
      elsif /^module\s*#{@module_name}\(/ =~ ll
        hdl_data_tmp << ll
        module_in = true
      end
    }

    rep.rep_data = Common.file_read(syr_file)
    rep.inst = get_inst(rep)
    @ModuleInfo = rep 
    
=begin
    Dir::glob("#{@work_dir}/*.syr"){|file|
      printf("@I:Read %s, get Fie Name and Instance Information\n",file)
      rep = Report.new    # Array of Report
      rep.file_name = file
      rep.rep_data = Common.file_read(file)
      rep.inst = get_inst(rep.rep_data)
      @ModuleInfo << rep 
    }
=end
  end

  #
  # Execute
  #
  def exe
    # Make Working Directory
    make_dir

    # Generate Files for xst execution
    syr_file = @work_dir + "/" + @module_name + ".syr"
    
    if FileTest.exists?("#{syr_file}") == true
      printf("@I:XST Synthesis was skipped, because %s is exist\n",syr_file) if $VERBOSE
    else
      gen_xst
      gen_prj
      gen_lso
      
      # Execute XST
      if $VERBOSE == true
        xst_cmd = "xst -ifn #{@work_dir}/#{@module_name}.xst -ofn #{@work_dir}/#{@module_name}.syr"
      else
        xst_cmd = "xst -ifn #{@work_dir}/#{@module_name}.xst -ofn #{@work_dir}/#{@module_name}.syr >& /dev/null"
      end
      printf("@I:Execute xst(%s)\n",xst_cmd) if $VERBOSE
      result = system("#{xst_cmd}")
      
      # Clean tmp file
      clean
      return result
    end

  end

  #
  # method
  #
  def print
    printf("%s\n",@ModuleInfo)
    printf(" - %s\n",@ModuleInfo.file_name)
    inst_array = Array.new
    inst_array = @ModuleInfo.inst
    inst_array.each{|d|
      printf("   - %s\n",d.ModuleName)
      printf("   - %s\n",d.InstName)
      printf("   ------------------------\n")
    }
  end
 
end

