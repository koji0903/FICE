#!/bin/sh
########################################################################
#
# Run script for executing ConnectChecker for Product BB
#
#  Author : Koji HIJIKURO<koji.hijkuro.rj@rmn.renesas.com>
#
########################################################################
RM='rm -rf'
LN='ln -s'

#
# TOOLs
# 
FICE=/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/MyProj/FICE/current
ProductCC=${FICE}/bin/ProductCC.rb


########################################################################
# [IMPORTANT]
#
#   you have to change follwing Variable adapting your project.
#
#   - File Path
#
########################################################################

#
# make_chip files for Device
#
DEV_BASE=/proj/78k0r_19/78k0r_ix4/_ice/_make_chip/_1chip/_chip/_df1.10/_doc/_device
DEV_REP=${DEV_BASE}/make_chip.report_hdl
${RM} device.report
${LN} ${DEV_REP} device.report

# Socket
DEV_SOCKET_BASE=/proj/78k0r_11/78k0r_kx4/_ice/_make_chip/_1chip_v2.0/_chip/_cf1.00/_doc/_device
DEV_SOCKET_REP=${DEV_SOCKET_BASE}/make_chip.report_hdl
${RM} dev_socket.report
${LN} ${DEV_SOCKET_REP} dev_socket.report

#
# make_chip files for ICE
#

# EVATIOP
EVATOP_REP=/proj/78k0r_19/78k0r_ix4/_ice/_make_chip/_eva_top/_chip/_v001/_doc/make_chip.report
EVATOP_MODULE=evatop
${RM} evatop.report
${LN} ${EVATOP_REP} evatop.report

# CHIPTOP
CHIPTOP_REP=/proj/78k0r_19/78k0r_ix4/_ice/_make_chip/_chiptop/_chip/_v001/_doc/make_chip.report
CHIPTOP_MODULE=chiptop
${RM} chiptop.report
${LN} ${CHIPTOP_REP} chiptop.report

#CHIP
CHIP_REP=/proj/78k0r_19/78k0r_ix4/_ice/_make_chip/_1chip/_chip/_df1.10/_doc/make_chip.report
CHIP_MODULE=chip
${RM} chip.report
${LN} ${CHIP_REP} chip.report

#SOCKET
ICE_SOCKET_REP=/proj/78k0r_11/78k0r_kx4/_ice/_make_chip/_socket/_chip/_cf1.0_ipo2/_doc/make_chip.report
ICE_SOCKET_MODULE=socket
${RM} ice_socket.report
${LN} ${ICE_SOCKET_REP} ice_socket.report

###################################################################
#
# EXECUTE
#
###################################################################
OPTION="-device ${DEV_REP},${DEV_SOCKET_REP} \
       -ice  ${EVATOP_REP}:${EVATOP_MODULE} \
             ${CHIPTOP_REP}:${EVATOP_MODULE},${CHIPTOP_MODULE} \
             ${CHIP_REP}:${CHIPTOP_MODULE},${CHIP_MODULE} \
             ${ICE_SOCKET_REP}:${CHIP_MODULE},${ICE_SOCKET_MODULE}" 

#OPTION="-device ${DEV_SOCKET_REP} \
#	   -ice  ${EVATOP_REP}:${EVATOP_MODULE} \
#             ${CHIPTOP_REP}:${EVATOP_MODULE},${CHIPTOP_MODULE} \
#             ${CHIP_REP}:${CHIPTOP_MODULE},${CHIP_MODULE} \
#             ${ICE_SOCKET_REP}:${CHIP_MODULE},${ICE_SOCKET_MODULE}" 

ruby -w ${ProductCC} ${OPTION}
