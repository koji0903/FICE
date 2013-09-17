#!/bin/sh
FICE=~/work/MyProj/FICE/trunk
MySTA=${FICE}/bin/MySTA.rb
UDEF=${FICE}/conf/kx4.udef
########################################################
#
# FPGA Setting 
#
########################################################
FPGA=V5

### ISE10 ##############################################
ISE=ISE11
########################################################

#for SPEED_GRADE in 1 2
#  do
#  for FREQ in 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40
#	do
#	ISE_DIR=Kx4_${FPGA}-${SPEED_GRADE}_${ISE}_${FREQ}MHz
#	TWR=${ISE_DIR}/EVA_TOP.twr
#	echo ${MySTA} -twr ${TWR} -o ${ISE_DIR}.txt -d ${ISE_DIR} -udef ${UDEF}
#	${MySTA} -twr ${TWR} -o ${ISE_DIR}.txt -d ${ISE_DIR} -udef ${UDEF}
#  done
#done

	ISE_DIR=.
	TWR=${ISE_DIR}/EVA_TOP.twr
	echo ${MySTA} -twr ${TWR} -o ${ISE_DIR}.txt -d ${ISE_DIR} -udef ${UDEF}
	${MySTA} -twr ${TWR} -o MySTA.txt -d ${ISE_DIR} -udef ${UDEF}

