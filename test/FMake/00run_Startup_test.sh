#!/bin/sh
#############################################################
#
# FMake-Startup Run-Script
#
#  - Product : FMake test
#
#############################################################
## BASE SETTING #################

FICE=/home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk
FMAKE=${FICE}/bin/FMake.rb

RUBY=/home/product/div-micom-ice/data/proj/RL78/Common/local/ruby/bin/ruby

#################################

VERILOG_LIST=./test.list
TOP_MODULE=R5F10PMFJ
PRODUCT=FMakeTest
DEV_VER=df0.1
ICE_VER=
#ADD_MODIFY_INST=cspf,cspf.mc200,pericore,pericore.mp200,pericore.portiotop,pericore.portiotop.port*_iobuf
ADD_MODIFY_INST=cspf,cspf.mc200,pericore,pericore.mp200,pericore.portiotop,pericore.portiotop.port*_iobuf

${RUBY} -W ${FMAKE} --startup ${VERILOG_LIST} --top_module ${TOP_MODULE} --product ${PRODUCT} --dev_ver ${DEV_VER} --ice_ver ${ICE_VER} --add_modify_inst ${ADD_MODIFY_INST} --verbose


rm -rf FMakeConfigTest_df0.1_rev001_hier.html
rm -rf test_v2xml.v
rm -rf FMakeConfigTest_df0.1_rev001_ICE.xml
