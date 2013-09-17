//
// Copyright (C) 2010 Renesas Electronics Corporation. All rights reserved.
// Verilog-Model
// v1.0     2010.07.22 T.Kawano
//                     New Create
//
/*
##################################################################
#   PDB Version : v1.0
#   LIB Version : v1.0
#   MF3_SS3rd Series Capacitance Macro for Flash
#   Macro Name : QNSC3NCPDC0V1
##################################################################
*/

`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module QNSC3NCPDC0V1 ( VCPHV );

input   VCPHV;

buf (_VCPHV, VCPHV);

endmodule

`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine

