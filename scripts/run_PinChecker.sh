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
PORT_FILE=CN1-5.csv
CT_FILE=CT4.csv
HDL_FILE=eva_top.v

## Execute ####
ruby -w ${PIN_CHECKER} --port ${PORT_FILE} --ct ${CT_FILE} --hdl ${HDL_FILE}
