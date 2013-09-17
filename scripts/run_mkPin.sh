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
FICE=/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/MyProj/FICE/current
MK_PIN=${FICE}/bin/mkPin.rb

#
# INPUT FILEs
#
PORT_FILE=CN1-5.csv
PULL_FILE=PullUp.csv
CT_FILE=CT4.csv

## Execute ####
#ruby -w ${MK_PIN} --port ${PORT_FILE} --pull ${PULL_FILE} 
ruby -w ${MK_PIN} --port ${PORT_FILE} --pull ${PULL_FILE} --ct ${CT_FILE}
