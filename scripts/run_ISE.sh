#!/bin/sh
########################################################
#
# run ISE script for goup P&R
#
# <Execution>
#   1. Generate UCF file using mkucf
#   2. Make ISE work directory
#   3. Copy edif/ucf files to work directory
#   4. Generate run-script for ISE execution
#   5. Delete old files and Run
#
########################################################
RM="rm -rf"
CP="cp -r"
MKDIR="mkdir"
PUSHD="pushd"
POPD="popd"
LSF="l4batch8"
MV="mv -f"
CHMOD="chmod"

FICE=/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/MyProj/FICE/trunk
MKUCF=${FICE}/bin/mkucf.rb
UDEF=${FICE}/conf/kx4.udef

# Virtex4-11
SPEED="11"
FPGA="xc4vlx80-ff1148-${SPEED}"
# Virtex5-1
#SPEED="1"
#FPGA="xc5vlx110-ff1153-${SPEED}"


JOB_NAME="v4-11"

#########################################################
# Setting
#########################################################

FREQ_LIST="10 30 32 34"
DUTY=40


#########################################################
# Execute
#########################################################

for FREQ in ${FREQ_LIST}
  do

#
# generate UCF file
#
  ${MKUCF} -iucf synplicity.ucf -oucf ./EVA_TOP_${FREQ}MHz.ucf -udef ${UDEF} -freq ${FREQ} -duty-all ${DUTY}

#
# make directory
#
  if [ ! -d ISE_${FREQ}MHz ]
	  then
	  echo "make directory"
	  ${MKDIR} ISE_${FREQ}MHz
  else
	  echo "Already exist "  ISE_${FREQ}MHz
  fi

#
# copy files
#
  ${CP} EVA_TOP.edf ISE_${FREQ}MHz
  ${CP} EVA_TOP_${FREQ}MHz.ucf ISE_${FREQ}MHz
  
#
# generete run-script
#
  echo "#!/bin/sh" > 00run.sh
  echo "ngdbuild -intstyle ise -dd _ngo -nt timestamp -p ${FPGA} EVA_TOP.edf EVA_TOP.ngd -uc EVA_TOP_${FREQ}MHz.ucf" >> 00run.sh
  echo "map -intstyle ise -p ${FPGA} -detail -w -t 1 -global_opt off -timing -ol high -cm speed -pr b -power off -o EVA_TOP_map.ncd EVA_TOP.ngd EVA_TOP.pcf" >> 00run.sh 
  echo "par -w -intstyle ise -ol high -t 1 EVA_TOP_map.ncd EVA_TOP.ncd EVA_TOP.pcf" >> 00run.sh
  echo "trce -intstyle ise -v 100 -s ${SPEED} -fastpaths -xml EVA_TOP.twx EVA_TOP.ncd -o EVA_TOP.twr EVA_TOP.pcf -ucf EVA_TOP_${FREQ}MHz.ucf" >> 00run.sh
  ${MV} 00run.sh ISE_${FREQ}MHz

#
# run ISE
#
  ${PUSHD} ISE_${FREQ}MHz 
  ${RM} lsf* *.ngo *.ngd *.ncd *.pcf _ngo EVA_TOP.twx EVA_TOP_par.xrpt EVA_TOP.xpi EVA_TOP.unroutes EVA_TOP_pad.txt EVA_TOP.pad EVA_TOP_pad.csv EVA_TOP.ptwx EVA_TOP_map.xrpt EVA_TOP_clkrgnrpt.xrpt EVA_TOP_summary.xml EVA_TOP_usage.xml EVA_TOP_map.ngm EVA_TOP_ngdbuild.xrpt xlnx_auto_0_xdb
  ${CHMOD} +x ./00run.sh
  ${LSF} -J ${JOB_NAME}_${FREQ}MHz ./00run.sh
  ${POPD}

done

