#!/bin/csh -f

time /proj/78k0r_5/fx3/d78f1845/_cmb_tools/upconv_2.41_linux/upconv_2.41 -parameter ./main.para \
  -makechip ../_doc/make_chip.para \
  -nofilechk \
  -trace \
  -j \
  -hdl \
  -log upconv.log
