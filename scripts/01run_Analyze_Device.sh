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
MV=mv

#################################

CONF=./f14_Config.conf

${RUBY} -d ${FMAKE} --analyze ${CONF} --verbose
${MV} connection.report connection_Device.report