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

#ORG=~/work/ICEMacro/tags/test/ice_top_SS3rd.v
ORG=/home/product/div-micom-ice/data/proj/78K0R/Common/ReplaceMacro/current/ierl78prtyerrv1.v
#ORG=./a.v
MODULE=IERL78PRTYERRV1
SIGNAL=A,D

${RUBY} -d -W ${MakeWrapper} --verilog ${ORG} --module ${MODULE} --bus ${SIGNAL}


