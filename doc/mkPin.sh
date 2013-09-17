#!/bin/sh
TOOL=mkPin
MAIN=MkPin
OPT="-a -S -N -m ${MAIN}"

rdoc  \
	../bin/mkPin.rb \
	../lib/FICE_def.rb \
	../lib/common.rb \
	../lib/getCSV.rb \
    --main ${MAIN} ${OPT}

DOC=/home/m0002/rc3090/product/div-micom-ice/data/proj/78K0R/Common/doc
rm -rf ${DOC}/${TOOL}
mv ./doc ${DOC}/${TOOL}
 
