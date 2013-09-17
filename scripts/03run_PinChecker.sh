#!/bin/sh
########################################################################
#
# Run script for mkPin
#
#  Author : Koji HIJIKURO<koji.hijkuro.rj@rmn.renesas.com>
#
########################################################################

#
# TOOLs
# 
FICE=/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/MyProj/FICE/trunk
PIN_CHECKER=${FICE}/bin/PinChecker.rb

#
# INPUT FILEs
#
PORT_FILE=../pin/CN1-5.csv
#CT_FILE=../pin/CT4.csv
#SDC_FILE=./local/F14_128_pin_1.00.sdc
SDC_FILE=./local/f14_g14_2_pin.sdc

#HDL_FILE=l13_df0.2_rev001_ICE.v
XML_FILE=f14_cf1.0_rev001_ICE.xml
TOP_MODULE=R5F10PMFJ_EVA

## Execute ####
${PIN_CHECKER} --sdc ${SDC_FILE} --xml ${XML_FILE} --module ${TOP_MODULE}
