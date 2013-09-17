#!/bin/sh
########################################################################
#
# Run script for making Expect files for Product Connection Check
#
#  Author : Koji HIJIKURO<koji.hijkuro.rj@rmn.renesas.com>
#
########################################################################
#
# PRE=SETTING
#
COMMON=/home/m0002/rc3090/product/div-micom-ice/data/proj/78K0R/Common
#
# TOOLs
# 
FICE=./FICE
MK_EXPECT=${FICE}/bin/mkExpect.rb

########################################################################
# [IMPORTANT]
#
#   you have to change follwing Variable adapting your project.
#
#   DEV_PARTS_FILE : Parts file from device make_chip
#   CCGolden       : Golden Expect file for ConnectChecker
########################################################################
# PARTS file for making CCExpect file
#
DEV_BASE=/proj/78k0r_11/78k0r_kx4/_ice/_make_chip/_1chip/_chip/_df5.78
DEV_PARTS_FILE=${DEV_BASE}/_para/_device/parts.para_hdl


###################################################################
#
# EXECUTE
#
###################################################################
ruby -w ${MK_EXPECT} -parts ${DEV_PARTS_FILE} 
