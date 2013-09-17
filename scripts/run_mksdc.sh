#!/bin/sh
###################################################################
#
# Example Script for running mksdc
#
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2011 NEC MicroSystem. All rights reserved.
#
##################################################################

## You MUST Change following Variable ############################

# Your FICE Environment Path
FICE=/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/MyProj/FICE/current

# For Product
PRODUCT_NAME=g13
PRODUCT_VER=CF1.0

# Output SDC Name
OUTPUT_SDC=rl78-${PRODUCT_NAME}_${PRODUCT_VER}_timing.sdc
# Directory name saved Device Constraint that you got from device group
DEVICE_CONST_DIR=_device_scr
# RmList for your product ( check ${FICE}/conf directory )
RMLIST=${FICE}/conf/Kx4.rmlist

##################################################################
MKSDC=${FICE}/bin/mksdc.rb

/usr/bin/ruby ${MKSDC} \
	-osdc ${OUTPUT_SDC} \
	-scr_dir ${DEVICE_CONST_DIR} \
	-rmlist ${RMLIST} \
	-verbose

