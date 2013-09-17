################################################################
#
# Conformal
#
#   Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
###############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'FICE_def'
require 'common'
require 'fileutils'
module Conformal
  
  #
  # Setting
  # - Parsing SettingFile
  #
  class Setting
    attr_accessor :ModuleName
    attr_accessor :PortDiff
    def initialize(file)
      @file = file
      
      # for Other
      @ModuleName = nil
      @PortDiff = Array.new
    end

    def parse
      printf "@I:Parsing #{@file}\n"
      open("#{@file}").each{|line|
        line = line.strip
        # comment line
        unless line[0] == ?#  || line == ""
          token = line.split(":")
          case token[0]
          when "GenerateSubModuleConformal"
            @ModuleName = token[1].to_s
            printf " - GenerateSubModuleConformal:#{@ModuleName}\n"
          when "PortDiff"
            target = token[1].split(",")
            @PortDiff << target
            printf " - PortDiff:#{target}\n"
          else
            $ERROR_CNT += 1
            printf "@E:Found unexpected Identifier \"#{line}\" in #{@file}\n"
            Common.print_summary
            exit
          end
        end
      }
    end

    def main
      parse
    end
  end

  #
  # RunScript
  #
  class RunScript
    def initialize(dir)
      @dir = dir
    end
    def generate
      file_name = @dir + "/00runAll.csh" 
      printf("@I:generate %s\n",file_name)
      f = open("#{file_name}","w")
      f.print <<EOB
#!/bin/sh
#################################################################
#
# Run Conformal for ALL SubModule
#
#################################################################

# Command
PUSHD='pushd'
POPD='popd'
LSF='l5batch2'
# for Conformal
RUN_SHELL='conformal.csh'

#
# Execute
#
DIR_LIST=`ls -F | grep /`
for dir in $DIR_LIST
do
	# move SubModule directory
	${PUSHD} $dir
	# Run Conformal RunScript
	${LSF} -J ${dir} ${RUN_SHELL}
	# return current directory
	${POPD}
done
EOB
      f.close
      File.chmod(0755,"#{file_name}")
    end
  end

  #
  # RunEnvironment
  # - Genearete RunScript and Dofile for Conformal
  #
  class RunEnvironment
    def initialize( dir, module_name)

      @ReplaceModule = { 
        "QAHIOS0BN32MV2" => "QAHIOS0BN32MV2_ICE",
        "QAHIOS1BN15KV1" => "QAHIOS1BN15KV1_ICE",
        "QAHREGOHNMAINV2" => "QAHREGOHNMAINV2_ICE",
        "QAHREGPHNMAINV1" => "QAHREGPHNMAINV1_ICE",
        "QAHREGOHNMAINV1" => "QAHREGOHNMAINV1_ICE",
        "QAHSOS1HNV1" => "QAHSOS1HNV1_ICE",
        "QAHPLMF3MPLLV1" => "QAHPLMF3MPLLV1_ICE",
        "QID04005" => "QID04005_ICE",
        "QAHMOS0HNV1" => "QAHMOS0HNV1_ICE",
        "QID0400SF5" => "QID0400SF5_ICE",
      }

      @GOLDEN_ROOT = module_name
      unless @ReplaceModule["#{module_name}"].nil?
        @REVISED_ROOT = @ReplaceModule["#{module_name}"]
      else
        @REVISED_ROOT = module_name
      end


      @GOLDEN_LIST = "/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/Conformal/Conformal_dev_ice/GOLDEN.list"
      @REVISED_LIST = "/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/Conformal/Conformal_dev_ice/REVISED.list"
      @dir = "#{dir}/#{@GOLDEN_ROOT}"


      @ExceptModule = [
                       "DMYA",
                       "KX4_NF",
                       "KX4_PORT0_IOBUF",
                       "KX4_PORT1_IOBUF",
                       "KX4_PORT2_IOBUF",
                       "KX4_PORT3_IOBUF",
                       "KX4_PORT4_IOBUF",
                       "KX4_PORT5_IOBUF",
                       "KX4_PORT6_IOBUF",
                       "KX4_PORT7_IOBUF",
                       "KX4_PORT8_IOBUF",
                       "KX4_PORT9_IOBUF",
                       "KX4_PORT10_IOBUF",
                       "KX4_PORT11_IOBUF",
                       "KX4_PORT12_IOBUF",
                       "KX4_PORT13_IOBUF",
                       "KX4_PORT14_IOBUF",
                       "KX4_RAMCLK_DLY",
                       "OWSRAM130W2048B18C4B9",
                       "QAHAD20SW16V1",
                       "QAHAD20SW17V1",
                       "QAHAD20SW18V1",
                       "QAHAD20SW19V1",
                       "QAHAD20SWL1V1",
                       "QAHADA20HN0V1",
                       "QAHREGOHNDRVV2",
                       "QICTRBG5A",
                       "QIVG0005",
                       "QLK0RRAMIF04KV1",
                       "QNSA3N064K0V2",
                       "QNSB3N004K0V2",
                       "TBCLH",
                       "TBCLL",
                      ]

      # generate HardMacro List      
      file_name = dir + "/HardMacroList.txt" 
      printf("@I:generate %s\n",file_name)
      f = open("#{file_name}","w")
      @ExceptModule.each do |mod|
        f.printf "#{mod}\n"
      end
      f.close
      File.chmod(0666,"#{file_name}")

    end

    def main
      if @ExceptModule.index("#{@REVISED_ROOT}").nil?
        generate_RunScript
        generate_Dofile
      else
        $NOTE_CNT += 1
        printf "@N:NOT Generate Conformal Files for HardMacro [#{@REVISED_ROOT}]\n"
      end
    end

    def generate_RunScript
      Common.make_dir("#{@dir}")
      file_name = @dir + "/conformal.csh" 
      printf("@I:generate %s\n",file_name)
      f = open("#{file_name}","w")
      f.print <<EOB
#!/bin/csh -f

#--------------------------------------------------
#setenv VERPLEX_HOME    /eda_tools/cadence/Conformal/5.2USR1
#setenv VERPLEX_HOME    /eda_tools/cadence/Conformal/7.1
# setenv VERPLEX_HOME    /eda_tools/cadence/Conformal/8.1
#setenv VERPLEX_HOME    /eda_tools/cadence/Conformal/8.1-p100
#setenv VERPLEX_HOME    /eda_tools/cadence/Conformal/9.1-s180
setenv VERPLEX_HOME    /eda_tools/cadence/Conformal/10.1-s220

set path=( $VERPLEX_HOME/bin $path )

setenv CDS_LIC_ONLY 1
# setenv CDS_LIC_FILE 5280@cf6cs1:5280@nktcs150:5280@nqpcs8:5280@cf1cs11:5280@cf1cs12:5052@cfycs226:5052@cfycs227:5052@cfycs228
# setenv CDS_LIC_FILE 5280@cf6cs1:5280@nktcs150:5280@nqpcs8:5280@cf1cs12
setenv CDS_LIC_FILE 5280@cf1cs12:5280@cf9cs193:5280@mw_lsv4:5280@mw_lsv5:5280@mw_lsv6

#--------------------------------------------------
lec -xl -nogui -dofile conformal.dofile

EOB
      FileUtils.chmod(0744,"#{file_name}")
    end
    
    def generate_Dofile
      file_name = @dir + "/conformal.dofile" 
      printf("@I:generate %s\n",file_name)
      f = open("#{file_name}","w")
      f.print <<EOB
setenv  GOLDEN          #{@GOLDEN_LIST}
setenv  REVISED         #{@REVISED_LIST}
setenv  LIB_HARD        ./_library_hard

setenv  GOLDEN_ROOT     #{@GOLDEN_ROOT}
setenv  REVISED_ROOT    #{@REVISED_ROOT}
setenv  LOG             $REVISED_ROOT

// =============== Setup Mode ===================

set log file -replace $LOG.log

set dofile abort off
set flatten model -latch_transparent 
set flatten model -seq_constant
set flatten model -lib_seq_redundant
set flatten model -gated_clock
set flatten model -nodff_to_dlat_zero
set flatten model -nodff_to_dlat_feedback
set undriven signal Z -both
set mapping method -unreach

// --------------- Read Libraries ------------

// MF3 Tamagawa
add notranslate module RAMB* -both

add notranslate module -library QB20HKASAG_ICE -revised
add notranslate module -library QB20GKASAG_ICE -revised
add notranslate module -library QAHAB2000HNV1_ICE -revised
add notranslate module -library QAHAB2001HNV1_ICE -revised
add notranslate module -library QAHAB2002HNV1_ICE -revised
add notranslate module -library QAHAB2003HNV1_ICE -revised
add notranslate module -library QAHAB2004HNV1_ICE -revised
add notranslate module -library QAHAB2005HNV1_ICE -revised
add notranslate module -library QAHAB2006HNV1_ICE -revised
add notranslate module -library QAHAB2007HNV1_ICE -revised
add notranslate module -library QB003F0G_ICE  -revised
add notranslate module -library QO200KALZ_ICE -revised
add notranslate module -library QIFLVPP15_ICE -revised

read library -verilog2k -golden \
/cadtools/nec/opencad/OpenCAD-LINUX-MF3_1.6.0.1/lib/MF3/cmos1_2.1V/verilog/primitive/TB*.v \
/cadtools/nec/opencad/OpenCAD-LINUX-MF3_1.6.0.1/lib/MF3/cmos1_2.1V/verilog/verilog_udp/*.v \
-f $LIB_HARD

read library -verilog2k -revised \
/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/Xilinx/conformallibs/xeclib/unisims/*.v \
/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/Xilinx/conformallibs/xeclib/simprims/*.v


///**/
// --- Specify all undefined cells as black boxes ---
set undefined cell  black_box -both

// ----------------- Read Design --------------------
read design -verilog2k -golden  -f $GOLDEN      -root $GOLDEN_ROOT
read design -verilog2k -revised -f $REVISED     -root $REVISED_ROOT
set analyze option -auto

//report rule check -design
//report floating signals -undriven -all

// ----------- Constraints on primary inputs --------
//add primary input -net SCANMODE -cut -golden
//add pin constraint 0 SCANMODE -golden
//add primary input -net SCANCLK -cut -golden
//add pin constraint 0 SCANCLK -golden
//add primary input -net SCANRESZ -cut -golden
//add pin constraint 0 SCANRESZ -golden
//add primary input -net SCANEN -cut -golden
//add pin constraint 0 SCANEN -golden

// Add black box ------------------------------------

set system mode LEC      

report unmapped points -extra -notmapped 

// =============== LEC Mode =====================
add compared points -all

compare

//usage
report compare data -noneq
report compare data -abort
report statistics
diagnose -noneq > diagnose_noneq.txt
diagnose -summary > diagnose_summary.txt

save session phase_comp

exit -force

EOB
    end
  end # Class Conformal

  #
  # PortDiff
  # - Compare Port Difference between Module
  class PortDiff
    def initialize(dir,pair,data)
      @dir = dir
      @pair = pair
      @data = data
    end
    def report
      file_name = @dir + "/" + @pair[0] + "_" + @pair[1] + ".port_diff" 
      printf("@I:generate %s\n",file_name)
      f = open("#{file_name}","w")
      data_a = @data["#{@pair[0]}"]
      data_b = @data["#{@pair[1]}"]

      if data_a.nil?
        $ERROR_CNT += 1
        printf "@E:Cannot found circuit information about #{@pair[0]}"
        Common.print_summary
        exit
      end
      if data_b.nil?
        $ERROR_CNT += 1
        printf "@E:Cannot found circuit information about #{@pair[1]}"
        Common.print_summary
        exit
      end

      inf_A0 = [], inf_A1 = [], inf_A2 = []
      inf_B0 = [], inf_B1 = [], inf_B2 = []
      inf_A0 = data_a.InputPort.keys unless data_a.InputPort.nil?
      inf_A1 = data_a.OutputPort.keys unless data_a.OutputPort.nil?
      inf_A2 = data_a.InoutPort.keys unless data_a.InoutPort.nil?

      inf_B0 = data_b.InputPort.keys unless data_b.InputPort.nil?
      inf_B1 = data_b.OutputPort.keys unless data_b.OutputPort.nil?
      inf_B2 = data_b.InoutPort.keys unless data_b.InoutPort.nil?

      inf_A = [inf_A0,inf_A1,inf_A2]
      inf_B = [inf_B0,inf_B1,inf_B2]

      f.printf "\/\/\n\/\/ Common Signal \n\/\/\n"
      f.printf "\n\/\/ -- INPUT --\n\n"
      (inf_A[0] & inf_B[0]).sort_by do |signal| signal end.each do |signal| 
        f.printf "#{signal}\n" 
      end
      f.printf "\n\/\/ -- OUTPUT --\n\n"
      (inf_A[1] & inf_B[1]).sort_by do |signal| signal end.each do |signal| 
        f.printf "#{signal}\n" 
      end
      f.printf "\n\/\/ -- INOUT --\n\n"
      (inf_A[2] & inf_B[2]).sort_by do |signal| signal end.each do |signal| 
        f.printf "#{signal}\n" 
      end

      f.printf "\n\/\/\n\/\/ Only #{@pair[0]} \n\/\/\n"
      f.printf "\n\/\/ -- INPUT --\n\n"
      (inf_A[0] - inf_B[0]).sort_by do |signal| signal end.each do |signal| 
        f.printf "add ignored input #{signal} -module #{@pair[0]} -golden\n" 
      end
      f.printf "\n\/\/ -- OUTPUT --\n\n"
      (inf_A[1] - inf_B[1]).sort_by do |signal| signal end.each do |signal| 
        f.printf "add ignored output #{signal} -module #{@pair[0]} -golden\n" 
      end
      f.printf "\n\/\/ -- INOUT --\n\n"
      (inf_A[2] - inf_B[2]).sort_by do |signal| signal end.each do |signal| 
        f.printf "assign pin direction OUT #{@pair[0]} #{signal} -golden -from_dir IO\n"
        f.printf "add ignored output #{signal} -module #{@pair[0]} -golden\n" 
      end

      f.printf "\n\/\/\n\/\/ Only #{@pair[1]} \n\/\/\n"
      f.printf "\n\/\/ -- INPUT --\n\n"
      (inf_B[0] - inf_A[0]).sort_by do |signal| signal end.each do |signal| 
        f.printf "add ignored input #{signal} -module #{@pair[1]} -revised\n" 
      end
      f.printf "\n\/\/ -- OUTPUT --\n\n"
      (inf_B[1] - inf_A[1]).sort_by do |signal| signal end.each do |signal| 
        f.printf "add ignored output #{signal} -module #{@pair[1]} -revised\n" 
      end
      f.printf "\n\/\/ -- INOUT --\n\n"
      (inf_B[2] - inf_A[2]).sort_by do |signal| signal end.each do |signal| 
        f.printf "assign pin direction OUT #{@pair[1]} #{signal} -revised -from_dir IO\n"
        f.printf "add ignored output #{signal} -module #{@pair[1]} -revised\n" 
      end
      f.close
    end
  end # Class PortDiff

end
