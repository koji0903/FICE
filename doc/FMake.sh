#!/bin/sh
TOOL=FMake
MAIN=FMake
OPT="-a -m ${MAIN} "

pushd ../bin
rdoc  \
	FICE.rdoc \
	FMake.rb \
	../lib/FICE_DB.rb \
	../lib/FMakeMessage.rb \
	../lib/FMakeLogic.rb \
	../lib/XMLParse.rb \
	../lib/FMakeConnect.rb \
	../lib/FMakeConf.rb \
	../lib/FICE_DB.rb \
	../test/FMake/test_FMake.rb \
	../test/FMake/test_XMLParse.rb \
	../test/FMake/test_FMakeLogic.rb \
	../test/FMake/test_FMakeConf.rb \
	../test/FMake/test_FMakeConnect.rb \
    --main ${MAIN} ${OPT}
DOC=/home/product/div-micom-ice/data/proj/RL78/Common/doc
rm -rf ${DOC}/${TOOL}
mv ./doc ${DOC}/${TOOL}


popd


echo ""
echo "Generated Doc Files saved following path"
echo  ${DOC}/${TOOL}
echo ""
