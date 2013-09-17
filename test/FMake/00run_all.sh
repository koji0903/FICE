#!/bin/sh

RM="rm -rf"
PUSHD="pushd"
POPD="popd"

#- Pre Setting
${PUSHD} tp
VerilogToXML test_s.v > test_simple.xml
${POPD}



LIST="test_FMakeVerilogList.rb \
      test_XMLParse.rb \
      test_FMakeConf.rb \
      test_FMakeConnect.rb \
      test_FMakeLogic.rb
"



i=0
for FILE in \
	${LIST}
  do
  echo
  echo "============================================================"
  echo "============================================================"
  echo "  Execute " ${FILE}
  echo "============================================================"
  echo "============================================================"
  ruby ${FILE}
  if [ $? -eq 1 ]
	  then
	  echo ""
	  echo ${FILE} "test was abnormally finished. Please check it"
	  echo ""
	  exit
  fi
  i=`expr ${i} + 1`
done

echo ""
echo "-------------------------------------------------"
echo ""
echo "Congraturation! All tests finished successfully."
#echo "   ${i} tests passed"
echo ""
echo "-------------------------------------------------"
echo ""


