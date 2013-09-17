#!/bin/sh
#############################################################
#
# FMake-Startup Run-Script
#
#  - Product : F14
#
#############################################################
## BASE SETTING #################

FICE=/home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk
FMAKE=${FICE}/bin/FMake.rb

RUBY=/home/product/div-micom-ice/data/proj/RL78/Common/local/ruby/bin/ruby

#################################

VERILOG_LIST=/design01/iecube_rl78/Products/f14/ice/fmake/list/f14.list
TOP_MODULE=R5F10PMFJ
PRODUCT=f14
DEV_VER=cf1.0
ICE_VER=
#ADD_MODIFY_INST=cspf,cspf.mc200,pericore,pericore.mp200,pericore.portiotop,pericore.portiotop.port*_iobuf
ADD_MODIFY_INST=cspf,cspf.mc200,pericore,pericore.mp200,pericore.portiotop,pericore.portiotop.port*_iobuf

${RUBY} -W ${FMAKE} --startup ${VERILOG_LIST} --top_module ${TOP_MODULE} --product ${PRODUCT} --dev_ver ${DEV_VER} --ice_ver ${ICE_VER} --add_modify_inst ${ADD_MODIFY_INST} --verbose
