#!/bin/sh
#############################################################
#
# FMake-Startup Run-Script
#
#  - Product : FMake test
#
#############################################################
## BASE SETTING #################

FICE=/home/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk
FMAKE=${FICE}/bin/FMake.rb

RUBY=/home/product/div-micom-ice/data/proj/RL78/Common/local/ruby/bin/ruby

#################################

VERILOG_LIST=./tp/RESB.list
TOP_MODULE=TOP
PRODUCT=FMakeTest_RESB
DEV_VER=df0.1
ICE_VER=
#ADD_MODIFY_INST=cspf,cspf.mc200,pericore,pericore.mp200,pericore.portiotop,pericore.portiotop.port*_iobuf
ADD_MODIFY_INST=cspf,cspf.mp200

${RUBY} -W ${FMAKE} --startup ${VERILOG_LIST} --top_module ${TOP_MODULE} --product ${PRODUCT} --dev_ver ${DEV_VER} --ice_ver ${ICE_VER} --add_modify_inst ${ADD_MODIFY_INST} --verbose


rm -rf RESB_v2xml_define.v
rm -rf RESB_v2xml.v
rm -rf HDLList.txt
rm -rf MacroList.txt
