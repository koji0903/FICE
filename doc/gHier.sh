#!/bin/sh
TOOL=gHier
MAIN=GHier
OPT="-a -S -N -m ${MAIN}"

rdoc  \
	../bin/gHier.rb \
	../lib/FICE_def.rb \
	../lib/common.rb \
    --main ${MAIN} ${OPT}

rm -rf ~/doc/${TOOL}
mv ./doc ~/doc/${TOOL}
 
