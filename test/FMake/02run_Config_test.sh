#!/bin/sh
#############################################################
#
# FICE 2.0 Trial Environment using G1C
#  - Analyze Mode
#
#############################################################

## BASE SETTING #################

FICE=/home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk
FMAKE=${FICE}/bin/FMake.rb

RUBY=/home/product/div-micom-ice/data/proj/RL78/Common/local/ruby/bin/ruby

#################################

CONF=test.conf

#bs -M 8000 ${RUBY} -d -W ${FMAKE} --config ${CONF} --verbose
${RUBY} -W ${FMAKE} --config ${CONF} --verbose --test

rm test_v2xml.v
rm FMakeConfigTest_df0.1_rev001_hier.html
rm FMakeConfigTest_df0.1_rev001_ICE.xml

