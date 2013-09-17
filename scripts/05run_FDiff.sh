#!/bin/sh
################################################################################
#
# RunScript for FDIFF
#
#  - FDIFF generate Connection Diff report between two connect files that
#    made by FMake
#
#  Author: Koji HIJIKURO
#
###############################################################################

FICE=/home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk
FDIFF=${FICE}/bin/FDiff.rb

CONF=./f14_Config.conf
GOLDEN=./connection_Device.report
REVISED=./analyze_ICE/connection_ICE.report
EXPECT=./expect
REPORT=connection_DIFF.report

#
# Pre-Processing
#
rm -rf expect_Candidate

#
# Execute
#
ruby -W ${FDIFF} --conf ${CONF} --golden ${GOLDEN} --revised ${REVISED} --expect_dir ${EXPECT} --report ${REPORT} --verbose

