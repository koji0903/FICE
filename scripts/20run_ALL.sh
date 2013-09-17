#!/bin/sh

DEV_VER=cf1.0
ICE_VER=rev003

# FMake Config
bs -M 8000 -J "conf" ./02run_Config.sh > config_${DEV_VER}_${ICE_VER}.log

# FMake Analyze
bs -B -M 8000 -J "analyze" ./04run_Analyze_ICE.sh > analyze_ICE.log

# Synplify
bs -M 8000 -J "syn" synplify_pro -batch syn.prj

# ISE
./11run_ISE.sh
