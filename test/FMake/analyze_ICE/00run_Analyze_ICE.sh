#!/bin/sh
#############################################################
#
# FMake Analyze Run-Script
#  - Analyze Mode for ICE
#
#############################################################

## BASE SETTING #################

FICE=/home/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk
FMAKE=${FICE}/bin/FMake.rb

RUBY=/home/product/div-micom-ice/data/proj/RL78/Common/local/ruby/bin/ruby
MV=mv

#################################

CONF=FMakeConfigTest_ICE_df0.1_rev001.conf

${RUBY} ${FMAKE} --analyze ${CONF} > analyze_ICE.log  2>&1
${MV} connection.report connection_ICE.report


