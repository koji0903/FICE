#!/bin/sh
TOOL=mkucf
MAIN=MkUCF
OPT="-a -U -m ${MAIN}"

rdoc  \
	../bin/mkucf.rb \
	../lib/FICE_def.rb \
	../lib/common.rb \
	../lib/system.rb \
	../lib/ise_ucf.rb \
    --op ./doc \
    --main ${MAIN} ${OPT}

rm -rf ~/doc/${TOOL}
mv ./doc ~/doc/${TOOL}
 
