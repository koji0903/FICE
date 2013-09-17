#!/bin/sh
############################################################
#
# Sample Tcl Script for FPGA Synthesis
#  - run Constraint Check for generating RPT file
#  - run Synthesis for generating SRR file
#  - Need RPT/SRR File for executing mksdc
#
# Author : Koji HIJIKURO
# Date   : 2010/07/07
#
############################################################
set PRJ syn.prj
project -load $PRJ
project -run constraint_check
project -run synthesis
