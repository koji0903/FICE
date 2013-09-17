#!/bin/sh
TOOL=mkice
MAIN=MkICE
OPT="-a -S -N -m ${MAIN}"

rdoc  \
	../bin/mkice2.rb \
	../lib/FICE_def.rb \
	../lib/common.rb \
	../lib/system.rb \
	../lib/circuit.rb \
	../lib/XMLParse.rb \
    --main ${MAIN} ${OPT}

rm -rf /home/m0002/rc3090/product/div-micom-ice/data/proj/78K0R/Common/doc/${TOOL}
mv ./doc /home/m0002/rc3090/product/div-micom-ice/data/proj/78K0R/Common/doc/${TOOL}
 
