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
#
# CHECK MODE
#
#################################
CONF_FILE=./1510_Config.conf
OUT_DIR=check_result

${RUBY} -W ${FMAKE} \
	--check ${CONF_FILE} \
	--outdir ${OUT_DIR} \
	--verbose
