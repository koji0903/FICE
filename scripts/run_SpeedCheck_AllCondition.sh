#!/bin/sh

echo ""
echo " Run Parametrising ISE executeion"
echo ""

PUSHD=pushd
POPD=popd
RM="rm -rf"

LSF=l5batch8

CURRENT=`pwd`


#
# IMPORTANT!!
#   EFFORT = HIGH or NORMAL or LOW
#
EFFORT=NORMAL


RUN_ISE=${CURRENT}/run_ise.sh 


########## MUST CHANGE #############
####################################


echo "# Execute for Virtex-5"
XILINX=/eda_tools/xilinx/ise/11.5
source ${XILINX}/settings64.sh
ISE=ISE11

FPGA=V5

for SPEED_GRADE in 1 2
  do
  PARTS=xc5vlx110-ff1153-${SPEED_GRADE}
  EDF=${CURRENT}/../../_files/${FPGA}-${SPEED_GRADE}/EVA_TOP.edf

  for FREQ in 25 26 27 28 29 30 31 32 33 34 35
	do
	# OPERATION
	WORK_DIR=Kx4_${FPGA}-${SPEED_GRADE}_${ISE}_${FREQ}MHz
	UCF=${CURRENT}/../../_files/${FPGA}-${SPEED_GRADE}/EVA_TOP_${FREQ}MHz.ucf
	if [ -d ${WORK_DIR} ]
		then
		${RM} ${WORK_DIR}
	fi
	mkdir ${WORK_DIR}
	pushd ${WORK_DIR}
	${LSF} ${RUN_ISE} ${FPGA} ${ISE} ${PARTS} ${UCF} ${EDF} ${EFFORT} ${FREQ}MHz ${SPEED_GRADE}
	${POPD}	
  done
done


