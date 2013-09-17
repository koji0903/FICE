#!/bin/sh
########################################################################
#
# Run script for ConstChecker
#
#  Author : Koji HIJIKURO<koji.hijkuro.rj@rmn.renesas.com>
#
########################################################################

#
# TOOLs
# 
FICE=/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/MyProj/FICE/trunk
CONST_CHECKER=${FICE}/bin/ConstChecker.rb

#
# INPUT FILEs
#
SDC=sample.sdc
UCF=EVA_TOP.ucf
ISE_Dir=ISE
UDEF=${FICE}/conf/kx4.udef

## Execute ####
#ruby -w ${MK_PIN} --port ${PORT_FILE} --pull ${PULL_FILE} 
ruby -w ${CONST_CHECKER} --sdc ${SDC} --ucf ${UCF} --ise ${ISE_Dir} --udef ${UDEF}
