#!/bin/csh -f

setenv CHIP_TOP /proj/78k0r_5/fx3/d78f1845
setenv CMB_TOOL ${CHIP_TOP}/_cmb_tools

time ${CMB_TOOL}/1chip_maker_2.1_linux/pre_mkchip \
-p make_chip.para \
-makechip \
-op /dev/null \
-out /dev/null \
-scr /dev/null \
-log make_chip.log \
-dcsh \
-pullup TBCLH \
-pulldown TBCLL 

grep fanin make_chip.report > nofanin_ice
grep open  make_chip.report > open_ice
grep short make_chip.report > short_ice
