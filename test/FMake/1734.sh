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

CONF=./tp/1734.conf

#bs -M 8000 ${RUBY} -d -W ${FMAKE} --config ${CONF} --verbose
${RUBY} -W ${FMAKE} --config ${CONF} --verbose


rm -rf 1734_001_hier.html
rm -rf 1734_v2xml.v
rm -rf 1734_001_ICE.xml
rm -rf 1734_001_ICE.v
