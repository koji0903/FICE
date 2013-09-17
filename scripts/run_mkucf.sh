#!/bin/sh
FICE=/home/product/ice/work/koji-h/work/MyProj/FICE/trunk
MKUCF=${FICE}/bin/mkucf.rb
UDEF=${FICE}/conf/kx4.udef

RM="rm -rf"
CP="cp -r"

for FREQ in 32
  do
#  ${MKUCF} -iucf synplicity.ucf -oucf ./EVA_TOP.ucf -udef ${UDEF} -freq ${FREQ} -duty FCLK 42
  ${MKUCF} -iucf synplicity.ucf -oucf ./EVA_TOP_${FREQ}MHz.ucf -udef ${UDEF} -freq ${FREQ} 
done


