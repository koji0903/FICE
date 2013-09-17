#!/bin/sh
#############################################################
#
# make_chip exection script
#
#   Author  : Koji Hijikuro
#   Date    : Dec 14, 2009
#   Version : 0.0.1
#
############################################################

# Command
POPD=popd
PUSHD=pushd
LN='/bin/ln -s'
LL='/bin/ls -al'
LT='/bin/ls -alt'
CP='/bin/cp -rf'
MV='mv'
RM='rm -rf'


# Base path ( chagne to match your environment )
WORK=/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/MyProj
FICE=${WORK}/FICE/bin
DB_COMMON=${WORK}/Common
DB_DEVICE=${WORK}/DeviceMacro
DB_ICE=${WORK}/ICEMacro

# For make_chip 
MAKE_CHIP=_make_chip
PRE_CHIP=_pre_chip
CHIP=_chip
CHIPTOP=_chiptop
EVATOP=_evatop
PARA=_para
DOC=_doc
LIBRARY=_library
UPCONV_CSH=upconv.csh
MAKE_CHIP_CSH=make_chip.csh

# for make_chip
PRODUCT_CONF=${WORK}/Product/FX3/conf

# For mkparts
MKPARTS=${FICE}/mkparts.rb
ORG_PARTS=${PRODUCT_CONF}/${PRE_CHIP}/parts.para
NEW_PARTS=${WORK}/${MAKE_CHIP}/${PRE_CHIP}/${PARA}/parts.para

# For mkice
MKICE=${FICE}/mkice.rb
CHANGE_CONNECT=${FICE}/change_connect.rb

############################################################
# Make WorkDirectory
############################################################
# make "_pre_chip" directory
if [ ! -d ${PRE_CHIP} ]
then
	echo "make ${PRE_CHIP} directory"
	mkdir ${PRE_CHIP}
fi
# make "_para, _doc, _library"directory
if [ ! -d ${PRE_CHIP}/${PARA} ]
then
	echo "make ${PRE_CHIP}/${PARA} directory"
	mkdir ${PRE_CHIP}/${PARA}
fi
if [ ! -d ${PRE_CHIP}/${DOC} ]
then
	echo "make ${PRE_CHIP}/${DOC} directory"
	mkdir ${PRE_CHIP}/${DOC}
fi
if [ ! -d ${PRE_CHIP}/${LIBRARY} ]
then
	echo "make ${PRE_CHIP}/${LIBRARY} directory"
	mkdir ${PRE_CHIP}/${LIBRARY}
fi
# make "_para, _doc, _library"directory
if [ ! -d ${CHIP} ]
then
	echo "make ${CHIP} directory"
	mkdir ${CHIP}
fi
if [ ! -d ${CHIP}/${PARA} ]
then
	echo "make ${CHIP}/${PARA} directory"
	mkdir ${CHIP}/${PARA}
fi
if [ ! -d ${CHIP}/${DOC} ]
then
	echo "make ${CHIP}/${DOC} directory"
	mkdir ${CHIP}/${DOC}
fi
if [ ! -d ${CHIP}/${LIBRARY} ]
then
	echo "make ${CHIP}/${LIBRARY} directory"
	mkdir ${CHIP}/${LIBRARY}
fi
# make "_para, _doc, _library"directory
if [ ! -d ${CHIPTOP} ]
then
	echo "make ${CHIPTOP} directory"
	mkdir ${CHIPTOP}
fi
if [ ! -d ${CHIPTOP}/${PARA} ]
then
	echo "make ${CHIPTOP}/${PARA} directory"
	mkdir ${CHIPTOP}/${PARA}
fi
if [ ! -d ${CHIPTOP}/${DOC} ]
then
	echo "make ${CHIPTOP}/${DOC} directory"
	mkdir ${CHIPTOP}/${DOC}
fi
if [ ! -d ${CHIPTOP}/${LIBRARY} ]
then
	echo "make ${CHIPTOP}/${LIBRARY} directory"
	mkdir ${CHIPTOP}/${LIBRARY}
fi
# make "_para, _doc, _library"directory
if [ ! -d ${EVATOP} ]
then
	echo "make ${EVATOP} directory"
	mkdir ${EVATOP}
fi
if [ ! -d ${EVATOP}/${PARA} ]
then
	echo "make ${EVATOP}/${PARA} directory"
	mkdir ${EVATOP}/${PARA}
fi
if [ ! -d ${EVATOP}/${DOC} ]
then
	echo "make ${EVATOP}/${DOC} directory"
	mkdir ${EVATOP}/${DOC}
fi
if [ ! -d ${EVATOP}/${LIBRARY} ]
then
	echo "make ${EVATOP}/${LIBRARY} directory"
	mkdir ${EVATOP}/${LIBRARY}
fi


############################################################
# Step 1 - Make parts file for ICE
############################################################
echo ""
echo "*Step 1 - Make parts file for ICE"
echo ""

# execute mkparts
ruby ${MKPARTS} -I ${ORG_PARTS} -O ${NEW_PARTS} 
if [ $? -eq 1 ]
then
	echo ""
	echo "Execution finished abnormally."
	exit
fi

echo "Step 1 finished successfully"

############################################################
# Step 2 - _pre_chip
############################################################
echo ""
echo "*Step 2 - _pre_chip"
echo ""

# copy other files
${LN} ${PRODUCT_CONF}/${PRE_CHIP}/main.para ${PRE_CHIP}/${PARA} &> /dev/null
${LN} ${PRODUCT_CONF}/${PRE_CHIP}/chip.para ${PRE_CHIP}/${PARA} &> /dev/null
${LN} ${PRODUCT_CONF}/${PRE_CHIP}/pins.para ${PRE_CHIP}/${PARA} &> /dev/null
${LN} ${PRODUCT_CONF}/${PRE_CHIP}/connect.para ${PRE_CHIP}/${PARA} &> /dev/null

# execute upconv
echo ""
echo "Execute upconv"
${PUSHD} ${PRE_CHIP}/${PARA}
if [ ! -x ${UPCONV_CSH} ]
then
	echo "copy ${UPCONV_CSH}"
	${LN} ${FICE}/${UPCONV_CSH} ${UPCONV_CSH}
fi
./${UPCONV_CSH}
if [ $? -eq 1 ]
then
	echo ""
	echo "upconv execution finished abnormally. please see ${PRE_CHIP}/${PARA}/upconv.log"
	${POPD}
	exit
fi
${POPD}

#execute make_chip
echo ""
echo "Execute make_chip"
${PUSHD} ${PRE_CHIP}/${DOC}
if [ ! -x ${MAKE_CHIP_CSH} ]
then
	echo "copy ${MAKE_CHIP_CSH}"
	${LN} ${FICE}/${MAKE_CHIP_CSH} ${MAKE_CHIP_CSH}
fi
./${MAKE_CHIP_CSH}
echo "make_chip execution finished abnormally. But, its expected."
${POPD}

echo "Step 2 finished successfully"

############################################################
# Step 3 - _chip
############################################################
echo ""
echo "*Step 3 - _chip"
echo ""

# execute mkice
PRODUCT=FX3
TOP=chip

REPORT1=${PRODUCT_CONF}/${CHIP}/make_chip.report_device  # make_chip report for Device
REPORT2=${WORK}/${MAKE_CHIP}/${PRE_CHIP}/${DOC}/make_chip.report   # make_chip report for ICE pre-operation
PINLIST=${PRODUCT_CONF}/${CHIP}/chip.plist
CONNECT=${PRODUCT_CONF}/${PRE_CHIP}/connect.para

${LL} ${REPORT1}
${LL} ${REPORT2}
${LL} ${PINLIST}
${LL} ${CONNECT}

echo ""
echo "Execute mkice"
ruby ${MKICE} -report1 ${REPORT1} -report2 ${REPORT2} -pinlist ${PINLIST} -connect ${CONNECT} -product ${PRODUCT} -top ${TOP} 
if [ $? -eq 1 ]
then
	exit
fi
echo ""

${MV} connect_ice_chip.para ${CHIP}/${PARA}
${MV} pins_ice_chip.para  ${CHIP}/${PARA}
${MV} connect_mod_chip.para  ${CHIP}/${PARA}
${MV} pins_hrmacro_chip.para  ${CHIP}/${PARA}
${MV} connect_nouse_chip.para  ${CHIPTOP}/${PARA}
${MV} connect_reverse_chip.para  ${CHIPTOP}/${PARA}
${MV} ConnectChList.txt  ${CHIP}
${MV} NameList.txt  ${CHIP}
${MV} other.v  ${CHIP}

# copy other files
${LN} ${PRODUCT_CONF}/${CHIP}/main.para ${CHIP}/${PARA} &> /dev/null
${LN} ${PRODUCT_CONF}/${CHIP}/chip.para ${CHIP}/${PARA} &> /dev/null
${LN} ${WORK}/${MAKE_CHIP}/${PRE_CHIP}/${PARA}/parts.para ${WORK}/${MAKE_CHIP}/${CHIP}/${PARA} &> /dev/null

# execute upconv
echo ""
echo "Execute upconv"
${PUSHD} ${CHIP}/${PARA}
if [ ! -x ${UPCONV_CSH} ]
then
	echo "copy ${UPCONV_CSH}"
	${LN} ${FICE}/${UPCONV_CSH} ${UPCONV_CSH}
fi
./${UPCONV_CSH}
if [ $? -eq 1 ]
then
	echo ""
	echo "upconv execution finished abnormally. please see ${CHIP}/${PARA}/upconv.log"
	${POPD}
	exit
fi
${POPD}

#execute make_chip
echo ""
echo "Execute make_chip"
${PUSHD} ${CHIP}/${DOC}
if [ ! -x ${MAKE_CHIP_CSH} ]
then
	echo "copy ${MAKE_CHIP_CSH}"
	${LN} ${FICE}/${MAKE_CHIP_CSH} ${MAKE_CHIP_CSH}
fi
./${MAKE_CHIP_CSH}
if [ $? -eq 0 ]
then
	echo "make_chip execution finished abnormally. Please see ${CHIP}/${DOC}/make_chip.log"
	${POPD}
	exit
fi
${POPD}

echo "Step 3 finished successfully"


############################################################
# Step 4 - _chiptop
############################################################
echo ""
echo "*Step 4 - _chiptop"
echo ""

# execute mkice
TOP=chiptop
REPORT1=${CHIP}/_doc/make_chip.report  # make_chip report for chip-ice
PINLIST=${PRODUCT_CONF}/${CHIPTOP}/chiptop.plist

echo "Run mkice..."
ruby ${MKICE} -report1 ${REPORT1} -pinlist ${PINLIST} -product ${PRODUCT} -top ${TOP}

${MV} connect_ice_chiptop.para ${CHIPTOP}/${PARA}
${MV} pins_ice_chiptop.para  ${CHIPTOP}/${PARA}
${MV} NameList.txt  ${CHIPTOP}
${LN} ${PRODUCT_CONF}/${CHIPTOP}/main.para ${CHIPTOP}/${PARA}
${LN} ${PRODUCT_CONF}/${CHIPTOP}/chip.para ${CHIPTOP}/${PARA}
${LN} ${PRODUCT_CONF}/${CHIPTOP}/connect_other.para ${CHIPTOP}/${PARA}
${LN} ${PRODUCT_CONF}/${CHIPTOP}/parts.para ${CHIPTOP}/${PARA}


# execute upconv
echo ""
${PUSHD} ${CHIPTOP}/${PARA}
# pre-operation (modify "connect_reverse_chip.para")
echo "Execute ${CHANGE_CONNECT}"
ruby ${CHANGE_CONNECT} -inf ${PRODUCT_CONF}/${CHIPTOP}/connect.inf -connect connect_reverse_chip.para
echo "Execute upconv"
if [ $? -eq 1 ]
then
	echo "${CHANGE_CONNECT} finished with error(s). please check error message."
	${POPD}
	exit
fi
if [ ! -x ${UPCONV_CSH} ]
then
	echo "copy ${UPCONV_CSH}"
	${LN} ${FICE}/${UPCONV_CSH} ${UPCONV_CSH}
fi
./${UPCONV_CSH}
if [ $? -eq 1 ]
then
	echo ""
	echo "upconv execution finished abnormally. please see ${CHIPTOP}/${PARA}/upconv.log"
	${POPD}
	exit
fi
${POPD}

#execute make_chip
echo ""
echo "Execute make_chip"
${PUSHD} ${CHIPTOP}/${DOC}
if [ ! -x ${MAKE_CHIP_CSH} ]
then
	echo "copy ${MAKE_CHIP_CSH}"
	${LN} ${FICE}/${MAKE_CHIP_CSH} ${MAKE_CHIP_CSH}
fi
./${MAKE_CHIP_CSH}
if [ $? -eq 0 ]
then
	echo "make_chip execution finished abnormally. Please see ${CHIPTOP}/${DOC}/make_chip.log"
	${POPD}
	exit
fi
${POPD}

echo "Step 4 finished successfully"

############################################################
# Step 5 - _evatop
############################################################
echo ""
echo "*Step 5 - _evatop"
echo ""

# execute mkice
TOP=evatop
REPORT1=${CHIPTOP}/_doc/make_chip.report  # make_chip report for chip-ice
PINLIST=${PRODUCT_CONF}/${EVATOP}/evatop.plist

echo "Run mkice..."
ruby ${MKICE} -report1 ${REPORT1} -pinlist ${PINLIST} -product ${PRODUCT} -top ${TOP}

${MV} pins_ice_evatop.para ${EVATOP}/${PARA}
${MV} connect_ice_evatop.para ${EVATOP}/${PARA}
${MV} NameList.txt  ${EVATOP}
${LN} ${PRODUCT_CONF}/${EVATOP}/main.para ${EVATOP}/${PARA}
${LN} ${PRODUCT_CONF}/${EVATOP}/chip.para ${EVATOP}/${PARA}
${LN} ${PRODUCT_CONF}/${EVATOP}/parts.para ${EVATOP}/${PARA}
${LN} ${PRODUCT_CONF}/${EVATOP}/connect_other.para ${EVATOP}/${PARA}

# execute upconv
echo ""
${PUSHD} ${EVATOP}/${PARA}
echo "Execute upconv"
if [ ! -x ${UPCONV_CSH} ]
then
	echo "copy ${UPCONV_CSH}"
	${LN} ${FICE}/${UPCONV_CSH} ${UPCONV_CSH}
fi
./${UPCONV_CSH}
if [ $? -eq 1 ]
then
	echo ""
	echo "upconv execution finished abnormally. please see ${CHIPTOP}/${PARA}/upconv.log"
	${POPD}
	exit
fi
${POPD}

#execute make_chip
echo ""
echo "Execute make_chip"
${PUSHD} ${EVATOP}/${DOC}
if [ ! -x ${MAKE_CHIP_CSH} ]
then
	echo "copy ${MAKE_CHIP_CSH}"
	${LN} ${FICE}/${MAKE_CHIP_CSH} ${MAKE_CHIP_CSH}
fi
./${MAKE_CHIP_CSH}
if [ $? -eq 0 ]
then
	echo "make_chip execution finished abnormally. Please see ${EVATOP}/${DOC}/make_chip.log"
	${POPD}
	exit
fi
${POPD}

echo "Step 5 finished successfully"

echo "Done"


