########################################################################
#
# FMake File Control Class
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
########################################################################
#
#  Module Name : FMakeFile
#   
########################################################################
require "FMakeMessage"
require 'FICE_DB'
require 'XMLParse'
require 'common'
require 'fileutils'

module FMakeFileControl
  def make_FileName(outdir,product_name,dev_ver,ice_ver,suffix)
    file_name = nil
    if outdir != nil
      if ice_ver == nil
        file_name = outdir + "/" + product_name + "_" + dev_ver + suffix
      else
        file_name = outdir + "/" + product_name + "_" + dev_ver + "_" + ice_ver + suffix
      end
    else
      if ice_ver == nil
        file_name = product_name + "_" + dev_ver + suffix
      else
        file_name = product_name + "_" + dev_ver + "_" + ice_ver + suffix
      end      
    end
    return file_name
  end

  module Verilog
    # SYNTHESIS_FILES
    SYNTHESIS_FILES = Array.new
    def generate_from_xml(xml_file,verilog_file,data)
      XMLParse::save(data,xml_file)
      printf("@I:generate %s.\n",verilog_file)
      result = `#{FICE_DB::XML2V} #{xml_file} > #{verilog_file}`
      self.add(verilog_file)
    end
    def add(file)
      SYNTHESIS_FILES << file
    end
    def get
      SYNTHESIS_FILES.uniq!
      return SYNTHESIS_FILES
    end
    module_function :generate_from_xml
    module_function :add
    module_function :get
  end

  module List
    def generate(define,file)
      printf "@I:generate list file for V2XML.\n"
      if define != nil && define.size != 0
        define.each do |def_file|
          printf "\t using  define file(%s)\n", def_file
        end
      end
      file_name = "tmp.list"
      f = open(file_name,"w")
      if define != nil && define.size != 0
        define.each do |def_file|      
          f.printf("`include \"%s\"\n",def_file)
        end
      end
      f.printf("`include \"%s\"\n",file)
      f.close
      return file_name
    end
    module_function :generate
  end

  module XML
    def generate(file,data)
      XMLParse::save(logic,xml)
    end
  end

  module HTML
    def generate(top_module,verilog_list,html)
      verilog_list.generate_HierHtml(top_module,html)
    end
    module_function :generate
  end

  module Analyze
    def generate_List(list,def_file,conf_db)
      printf("@I:Generate List File(%s) for FMake Analyze.\n",list)
      f = open(list,"w")
      # file header message
      $SUB_TOOL = "FMake"
#      Common.print_file_header(f, "Synthesis Project File for Synplify Pro",$SUB_TOOL,$VERSION,"##")
      verilog_files = Array.new
      edif_files = Array.new
      # Verilog Files
#      f.printf("\n#project files\n")
      verilog_files << def_file unless def_file.nil?

      # Add ICE Sub Module Files
      ice_flag = false
      conf_db.INST.each do |name,inf|
        ice_flag = true if /ICE_TOP/ =~ inf.ModuleName
      end
      if ice_flag
        ice_macro_path = conf_db.SET["ICE_MACRO_PATH"]
        if ice_macro_path.nil?
          ice_macro_path = conf_db.SET["IM"]
        end
        if ice_macro_path.nil?
          ice_macro_path = "/home/product/div-micom-ice/data/proj/78K0R/Common/ICEMacroSuite/ICEMacro/current"
        end
        replace_macro_path = conf_db.SET["REPLACE_MACRO_PATH"]
        if replace_macro_path.nil?
          replace_macro_path = conf_db.SET["RE"]
        end
#        verilog_files << "/home/product/div-micom-ice/data/proj/RL78/Common/Settings/FPGA_ICE_V5_def.v"
        verilog_files << "/design01/iecube_rl78/Common/FMakeFiles/HDL/latest/ice.def"
        verilog_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/QLK0RMULDIV1V1_MUL_ICE_bb.v"
        verilog_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/QLK0RMULDIV2V1_MUL_ICE_bb.v"
        edif_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/QLK0RMULDIV1V1_MUL.edf"
        edif_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/QLK0RMULDIV2V1_MUL.edf"
        verilog_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/ierl78prtyerrv1.v"
        if  ice_macro_path != nil
          Dir.glob("#{ice_macro_path}/*.v") do |path|
            verilog_files << path
#            f.printf("add_file -verilog \"%s\"\n",path)
          end
        end
      end
      if replace_macro_path != nil
        Dir.glob("#{replace_macro_path}/MF3_Prim.v") do |path|
          verilog_files << path
        end
        Dir.glob("#{replace_macro_path}/ieCommon.v") do |path|
          verilog_files << path
        end
      end
      Verilog::get.sort.each do |verilog|
        verilog_files << verilog
#        f.printf("add_file -verilog \"%s\"\n",verilog)
      end

      verilog_files.uniq.each do |file|
        f.printf("%s\n",file)
      end
    end
    def generate_Conf(conf_file,list,conf_db)
      conf_file = File.expand_path(conf_file)
      printf("@I:Generate Conf File(%s) for FMake Analyze.\n",conf_file)
      f = open(conf_file,"w")
      # file header message
      $SUB_TOOL = "FMake"
      Common.print_file_header(f, "Configuration file for FMake Analyze",$SUB_TOOL,$VERSION,"##")
      conf_db.PRODUCT = conf_db.PRODUCT + "_ICE"
      conf_db.TOP_MODULE = conf_db.TOP_MODULE + "_EVA"
      conf_db.VERILOG_LIST = "./" + list.split("/").last

      f.print <<EOB
# Product Name
PRODUCT: #{conf_db.PRODUCT}
# Product Version
PRODUCT_VER: #{conf_db.PRODUCT_VER}
# ICE Version
ICE_VER: #{conf_db.ICE_VER}

# Circuit Information
TOP_MODULE: #{conf_db.TOP_MODULE}

# Verilog List File
VERILOG_LIST: #{conf_db.VERILOG_LIST}


EOB
      conf_db.INST.each do |key,value|
        f.print "INS:\t#{value.InstName}\t#{value.ModuleName}\tTYPE\tKeepKeep\tEND_INS:\n"
      end
      f.print "\n"

      f.close
    end
    def generate_Sh(sh,conf_file)
      printf("@I:Generate Sh File(%s) for FMake Analyze.\n",sh)
      f = open(sh,"w")

      if $TEST_MODE
        fice_path = "trunk"
      else
        fice_path = "latest"
      end
      

      f.print <<EOB
#!/bin/sh
#############################################################
#
# FMake Analyze Run-Script
#  - Analyze Mode for ICE
#
#############################################################

## BASE SETTING #################

FICE=/home/product/div-micom-ice/data/proj/RL78/Common/FICE/#{fice_path}
FMAKE=${FICE}/bin/FMake.rb

RUBY=/home/product/div-micom-ice/data/proj/RL78/Common/local/ruby/bin/ruby
MV=mv

#################################

CONF=#{conf_file.split("/").last}

${RUBY} ${FMAKE} --analyze ${CONF} > analyze_ICE.log  2>&1
${MV} connection.report connection_ICE.report


EOB
      f.close
    end
    module_function :generate_List
    module_function :generate_Sh
    module_function :generate_Conf
  end

  module SynplifyPrj
    def generate(prj,top_module,conf_db,def_file=nil)
      printf("@I:Generate Prj File(%s) for Synplify Pro Synthesis.\n",prj)
      f = open(prj,"w")
      # file header message
      $SUB_TOOL = "FMake"
      Common.print_file_header(f, "Synthesis Project File for Synplify Pro",$SUB_TOOL,$VERSION,"##")
      verilog_files = Array.new
      edif_files = Array.new
      # Verilog Files
      f.printf("\n#project files\n")

      def_file.each do |d|
        verilog_files << d
      end unless def_file.size == 0
      verilog_files << "/design01/iecube_rl78/Common/FMakeFiles/HDL/latest/ice.def"
      # Add ICE Sub Module Files
      ice_flag = false
      conf_db.INST.each do |name,inf|
        ice_flag = true if /ICE_TOP/ =~ inf.ModuleName
      end
#      if ice_flag
      ice_macro_path = conf_db.SET["ICE_MACRO_PATH"]
      if ice_macro_path.nil?
        ice_macro_path = conf_db.SET["IM"]
      end
      if ice_macro_path.nil?
        ice_macro_path = "/home/product/div-micom-ice/data/proj/78K0R/Common/ICEMacroSuite/ICEMacro/current"
      end
#        if  ice_macro_path != nil
      Dir.glob("#{ice_macro_path}/*.v") do |path|
        verilog_files << path
        #            f.printf("add_file -verilog \"%s\"\n",path)
      end
      #        end
      #      end
      verilog_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/ierl78prtyerrv1.v"
      verilog_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/MF3_Prim.v"
      verilog_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/ieCommon.v"
      verilog_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/QLK0RMULDIV1V1_MUL_ICE_bb.v"
      verilog_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/QLK0RMULDIV2V1_MUL_ICE_bb.v"
      edif_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/QLK0RMULDIV1V1_MUL.edf"
      edif_files << "#{FICE_DB::REPLACE_MACRO_CURRENT}/QLK0RMULDIV2V1_MUL.edf"
      Verilog::get.sort.each do |verilog|
        verilog_files << verilog
#        f.printf("add_file -verilog \"%s\"\n",verilog)
      end

      verilog_files.uniq.each do |file|
        f.printf("add_file -verilog \"%s\"\n",file)
      end
      edif_files.uniq.each do |file|
        f.printf("add_file -edif \"%s\"\n",file)
      end
      
      f.printf <<EOB

#implementation: "1_Synthesis"
impl -add 1_Synthesis -type fpga

#
#implementation attributes

set_option -vlog_std v2001
set_option -num_critical_paths 10
set_option -num_startend_points 10
set_option -project_relative_includes 1

#device options
set_option -technology Virtex5
set_option -part XC5VLX110
set_option -package FF1153
set_option -speed_grade -2
set_option -part_companion ""

#compilation/mapping options
set_option -use_fsm_explorer 0
set_option -top_module "#{top_module}"

# mapper_options
set_option -frequency 1.00
set_option -write_verilog 1
set_option -write_vhdl 0

# Xilinx Virtex2
set_option -run_prop_extract 1
set_option -maxfan 500
set_option -disable_io_insertion 0
set_option -pipe 1
set_option -update_models_cp 1
set_option -retiming 0
set_option -no_sequential_opt 0
set_option -fixgatedclocks 3
set_option -fixgeneratedclocks 0

# Xilinx Virtex5
set_option -enable_prepacking 1

# NFilter
set_option -popfeed 0
set_option -constprop 0
set_option -createhierarchy 0

# sequential_optimization_options
set_option -symbolic_fsm_compiler 1

# Compiler Options
set_option -compiler_compatible 0
set_option -resource_sharing 0

#VIF options
set_option -write_vif 1

#automatic place and route (vendor) options
set_option -write_apr_constraint 1

#set result format/file last
project -result_file "./1_Synthesis/#{top_module}.edf"
impl -active "1_Synthesis"

EOB
      f.close
    end
    module_function :generate
  end

  module Conformal
    #
    # Generate GOLDEN.list
    #
    def generate_GoldenList(outdir,list,ignore_list)
      print "@I:generate GoldenList ...\n"
      ignore_files = Array.new
      ignore_list.each do |data|
        ignore_files << data[1]
      end

      file = outdir + "/GOLDEN.list"
      FMakeMessage::PrintError( :category => "FILE", :no => 21, :param => list ) unless FileTest.readable?(list)
      f = open(file,"w")
      open(list).each do |line|
        if line[0] == "#"
          f.printf "//%s\n",line.strip
        elsif ignore_files.index(line.strip) != nil
          f.printf "//%s\n",line.strip
          printf (" - Ignored File : #{line.strip}\n")
        else
          f.printf "%s\n",line.strip
        end
      end
      print "Done\n"
      f.close
    end
    #
    # Generate REVISED.list
    #
    def generate_RevisedList(outdir,verilog,ignore_list)
      print "@I:generate RevisedList ...\n"
      doc = XMLParse.read($TOP_XML_FILE)
      ignore_list.each do |data|
        XMLParse::delete_Module(doc,data[0])
      end
      print " @I:delete Hard Macro\n"
      module_list = XMLParse::delete_HardMacro(doc)
      module_list.each do |mod|
        printf " - #{mod}\n"
      end
      new_xml = $TOP_XML_FILE + ".tmp"

      XMLParse.save(doc,new_xml)

      file = outdir + "/REVISED.list"
      verilog_file = outdir + "/" + verilog.split("/").last

      # Generate Verilog
      t1 = Thread.new do
        printf("To complete this process takes a long time. please wait.\n")
        result = `#{FICE_DB::XML2V} #{new_xml} > #{verilog_file}`
      end
      
      # print "." message while executing V2XML
      t2 = Thread.new do
        while 1 > 0
          printf "."
          sleep 3
        end
      end
      
      # wait for finishing V2XML
      t1.join
      Thread::kill(t2)

      # Remove Temporary XML
      FileUtils.rm(new_xml)
      
      f = open(file,"w")
#      f.printf "/home/product/div-micom-ice/data/proj/RL78/Common/Settings/FPGA_ICE_V5_def.v\n"
      f.printf "%s\n",verilog_file
      f.close
      print "Done\n"

    end
    #
    # Generate DoFile
    #
    def generate_DoFile(outdir)
      file = outdir + "/conformal.dofile"
      f = open(file,"w")
      comment = "Conformal DoFile" 
      Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"\/\/")

      f.printf <<EOB

setenv	GOLDEN		./GOLDEN.list
setenv	REVISED		./REVISED.list
setenv	LIB_HARD	./_library_hard

//setenv  ROOT        crl78hkrif_f14m
//setenv	LOG		conformal

// =============== Setup Mode ===================

set log file -replace result/$ROOT.log

set dofile abort off
set flatten model -latch_transparent 
set flatten model -seq_constant
set flatten model -lib_seq_redundant
set flatten model -gated_clock
set flatten model -nodff_to_dlat_zero
set flatten model -nodff_to_dlat_feedback
set undriven signal Z -both
set mapping method -unreach
set x conversion dc -both
set undefined cell black_box

// ----------------- Read Design --------------------
read design -file xilinx.vlc -verilog2k -golden	-f $GOLDEN	-root $ROOT
read design -file xilinx.vlc -verilog2k -revised -f $REVISED -root $ROOT
set analyze option -auto


//add pin constraints 0 clk_scan -golden
//add pin constraints 0 mod_scanmode -golden
//add pin constraints 0 mod_scanen -golden
//add pin constraints 0 scanclk -golden
//add pin constraints 0 scanmode -golden
//add pin constraints 0 scanen -golden

//report rule check -design
//report floating signals -undriven -all


//////////////////////////////////////////////////////////////
//
// Changint to LEC Mode
//
//////////////////////////////////////////////////////////////
set system mode LEC

report unmapped points -extra -notmapped 

// =============== LEC Mode =====================
add compared points -all

compare

//usage
report compare data -noneq
//report compare data -abort
report compared points
report unmapped points
report statistics

save session phase_comp

exit -force


EOB
      f.close
    end
    #
    # Generate Run-Shell
    #
    def generate_Sh(outdir,module_list,ignore_list)
      ignore_modules = Array.new
      ignore_list.each do |data|
        ignore_modules << data[0]
      end

      file = outdir + "/00run_conformal.csh"
      f = open(file,"w")
      f.printf "#!/bin/csh -f\n"
      comment = "Conformal Run-Script" 
      Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
      f.printf <<EOB

setenv VERPLEX_HOME    /eda_tools/cadence/Conformal/8.1-s480

set path=( $VERPLEX_HOME/bin $path )

setenv CDS_LIC_ONLY 1
setenv CDS_LIC_FILE 5280@cf1cs12:5280@cf9cs193:5280@mw_lsv4:5280@mw_lsv5:5280@mw_lsv6

if (!( -d result )) then
	mkdir result
endif

set modules=( \\
EOB

      module_list.each do |module_name|
        f.printf "\t%s \\\n",module_name if ignore_modules.index(module_name).nil?
      end
      
      f.printf <<EOB
)

foreach module ($modules)
	setenv ROOT $module
	#echo $ROOT
	#--------------------------------------------------
	#rm -rf phase*
   	lec -xl -nogui -dofile conformal.dofile
    # for Multi-Process
   	#bs -M 4000 -os REDHATE5_0 lec -xl -nogui -dofile conformal.dofile > /dev/null &
    rm -rf phase_comp*
end

grep "Nonequivalent" result/*.log > noneq.log
EOB
      f.close
      File.chmod(0777,file)

    end

    module_function :generate_GoldenList
    module_function :generate_RevisedList
    module_function :generate_DoFile
    module_function :generate_Sh
  end

  module_function :make_FileName
end
