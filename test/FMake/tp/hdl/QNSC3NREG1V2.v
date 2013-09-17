//
// Copyright (C) 2010 Renesas Electronics Corporation. All rights reserved.
// Verilog-Model
// DF3.0    2010.06.30 Takashi.Kawano
//                     New Create
// v1.0     2010.07.22 T.Kawano
//                     Version change
// v1.01    2010.08.19 R.Arakawa
//                     POCREL5V changed.
//
/*
##################################################################
#   PDB Version : v1.01
#   LIB Version : v1.01
#   MF3_SS3rd Series Regulator Macro for Flash
#   Macro Name : QNSC3NREG1V2
##################################################################
*/

`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module QNSC3NREG1V2 ( POCREL5V, FLREGENB, VCPRGWE );

output  VCPRGWE;
input   POCREL5V;
input   FLREGENB;

buf (_FLREGENB, FLREGENB);
buf (_POCREL5V, POCREL5V);
buf (VCPRGWE, _VCPRGWE);

assign _VCPRGWE = _POCREL5V & ~_FLREGENB;

`ifdef QNSXXXX_ASSERT_ON
`include "./ast/sv_file/QNSC3NREG1V2.sv"
`endif

endmodule

`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine

