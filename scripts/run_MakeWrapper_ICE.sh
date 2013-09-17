#!/bin/sh
#############################################################
#
# Make Wrapper
#  - Analyze Mode
#
#############################################################

## BASE SETTING #################

FICE=/home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk
MakeWrapper=${FICE}/bin/MakeWrapper.rb

RUBY=/home/product/div-micom-ice/data/proj/RL78/Common/local/ruby/bin/ruby

ORG=~/work/ICEMacro/current/ice_top_SS3rd.v
MODULE=ICE_TOP

${RUBY} -d -W ${MakeWrapper} --verilog ${ORG} --module ${MODULE} --bus A,AF,BEU,BTBLS,DA,DW,EXMA,MA,MDR_RAM,MDW,PA,RAMSIZE


