#!/bin/sh
########################################################################
#
# Run script for mkUDEF
#
#  Author : Koji HIJIKURO<koji.hijkuro.rj@rmn.renesas.com>
#
########################################################################

#
# TOOLs
# 
FICE=/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/MyProj/FICE/trunk
MK_UDEF=${FICE}/bin/mkUDEF.rb

#
# INPUT FILEs
#
SDC=./timing.sdc
TWR=./clock_topology.twr
## Execute ####
${MK_UDEF} --sdc ${SDC} --twr ${TWR} --freq FCLK:FIHP3:FIHP1 --duty FCLK
