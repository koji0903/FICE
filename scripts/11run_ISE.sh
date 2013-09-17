#!/bin/sh

#
# Linux Command
#
PUSHD=pushd
POPD=popd

#
# User Command
#
MKUCF=run_mkucf.sh
RUN_ISE=run_ise.sh

SYN_DIR=1_Synthesis



#
# Run mkucf
#
${PUSHD} ${SYN_DIR}
${MKUCF}
${POPD}

source ${XILINX}/settings64.csh

#
# Run ISE
#
for ISE_DIR in ISE_34MHz ISE_32MHz ISE_28MHz ISE_26MHz ISE_24MHz ISE_20MHz ISE_10MHz ISE_4MHz
do
	${PUSHD} ${ISE_DIR}
	bs -M 8000 -J ${ISE_DIR} ./run_ise.sh > ise.log &
	${POPD}
done
