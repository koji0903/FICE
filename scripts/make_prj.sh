#!/bin/sh -f

CP='cp -rf'
LIB_ANA='/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/MyProj/FICE/bin/libanalize.rb'

LIB_FILE='_library_file_cf2.v'
TOP_FILE='d78f1845_cf2.0.hdl'
MODULE='D78F1845_EVA'

${CP} _library_file_cf2.0_hdl ${LIB_FILE}

${LIB_ANA} -lib ${LIB_FILE} -top ${TOP_FILE} -prj ${MODULE}

