#!/bin/sh

MySTA=~/work/MyProj/FICE/trunk/bin/MySTA.rb

########################################################
#
# Virtex4 
#
########################################################
FPGA=V4_0022

### ISE10 ##############################################
ISE=ISE11
########################################################

for FREQ in 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35
do
  ISE_DIR=Kx4_${FPGA}_${ISE}_${FREQ}MHz
  TWR=${ISE_DIR}/EVA_TOP.twr
  ${MySTA} -twr ${TWR} -o ${ISE_DIR}.txt -d ${ISE_DIR}
done

