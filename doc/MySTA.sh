#!/bin/sh
TOOL=MySTA
MAIN=MySTA
OPT="-a -S -N -m ${MAIN}"

rdoc  \
	../bin/MySTA.rb \
	../lib/FICE_def.rb \
	../lib/common.rb \
    --main ${MAIN} ${OPT}

rm -rf ~/doc/${TOOL}
mv ./doc ~/doc/${TOOL}
 
