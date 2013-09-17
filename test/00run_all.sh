#!/bin/sh

RM="rm -rf"

i=0
ls
for FILE in \
	`ls test_*.rb`
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


${RM} ./product.expect
${RM} ./result

#	test_ISEChecker.rb  \
#	test_ProductCC.rb  \
#	test_par_report.rb \
#   test_MySTA.rb \
#	test_ise_ucf.rb \
#	test_synplicity_ucf.rb
