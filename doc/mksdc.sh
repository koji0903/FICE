#!/bin/sh
TOOL=mksdc
MAIN=MkSDC
OPT="-a -S -N -m ${MAIN}"

rdoc  \
	../bin/mksdc.rb \
	../lib/FICE_def.rb \
	../lib/common.rb \
	../lib/constraint.rb \
	../lib/device_scr.rb \
	../lib/gen_summary_scr.rb \
	../lib/gen_summary_sdc.rb \
	../lib/message.rb \
	../lib/synplify_rpt.rb \
	../lib/synplify_sdc.rb \
    ../lib/synplify_srr.rb \
	../lib/synplify_ucf.rb \
	../lib/system.rb \
    --main ${MAIN} ${OPT}

rm -rf ~/doc/${TOOL}
mv ./doc ~/doc/${TOOL}
 
