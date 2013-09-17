#!/bin/sh
########################################################################
#
# Run script for making Expect files for Product Connection Check
#
#  Author : Koji HIJIKURO<koji.hijkuro.rj@rmn.renesas.com>
#
########################################################################

#
# Product Setting ( You must Change following Setting!! )
#
PRODUCT_DIR_1CHIP=78k0r_19/78k0r_ix4
PRODUCT_VER_1CHIP=_df1.10

PRODUCT_DIR_SOCKET=78k0r_11/78k0r_kx4
PRODUCT_VER_SOCKET=_cf1.00


#
# UNIX Command
#
RM='rm -rf'

#
# TOOLs
# 
FICE=/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/MyProj/FICE/current
MK_EXPECT=${FICE}/bin/mkExpect.rb

########################################################################
# [IMPORTANT]
#
#   you have to change follwing Variable adapting your project.
#
#   DEV_PARTS_FILE : Parts file from device make_chip
#   CCGolden       : Golden Expect file for ConnectChecker
#
########################################################################

${RM} TemplateExpect GoldenExpect

#-----------------------------------------------------------------------
# 1Chip
#-----------------------------------------------------------------------

# PARTS file for making CCExpect file
DEV_BASE=/proj/${PRODUCT_DIR}/_ice/_make_chip/_1chip/_chip/${PRODUCT_VER}/_para/_device
DEV_PARTS_FILE=${DEV_BASE}/parts.para_hdl

# EXECUTE
ruby -w ${MK_EXPECT} -parts ${DEV_PARTS_FILE} 


#-----------------------------------------------------------------------
# Socket
#-----------------------------------------------------------------------

SOCKET_BASE=/proj/${PRODUCT_DIR_SOCKET}/_ice/_make_chip/_1chip_v2.0/_chip/${PRODUCT_VER_SOCKET}/_para/_device
SOCKET_PARTS_FILE=${SOCKET_BASE}/parts.para_hdl

# EXECUTE
ruby -w ${MK_EXPECT} -parts ${SOCKET_PARTS_FILE} 
