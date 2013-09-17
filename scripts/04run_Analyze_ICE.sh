#!/bin/sh
#############################################################
#
# FICE 2.0 Trial Environment using L13
#  - Analyze Mode for ICE
#
#############################################################
PUSHD=pushd
POPD=popd

EXE_DIR=analyze_ICE
EXE=00run_Analyze_ICE.sh


${PUSHD} ${EXE_DIR}
${EXE}
${POPD}



## BASE SETTING #################

#FICE=/home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk
#FMAKE=${FICE}/bin/FMake.rb

#RUBY=/home/product/div-micom-ice/data/proj/RL78/Common/local/ruby/bin/ruby
#MV=mv

#################################

#CONF=./f14_Config_ICE.conf
#
#${RUBY} -d ${FMAKE} --analyze ${CONF} --verbose
#${MV} connection.report connection_ICE.report