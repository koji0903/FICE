//                              -*- Mode: Verilog -*-
// Filename        : QLK0RMULDIV0V1_MUL_ICE_bb.v
// Description     : BlackBox module of Mult circuit for ISE using DesignWare
// Author          : Koji HIJIKURO
// Created On      : Tue Nov 17 10:09:25 2009
// Last Modified By: Koji HIJIKURO
// Last Modified On: Tue Nov 26 2009
// Version         : 1.0
// 


module QLK0RMULDIV1V1_MUL(MDSM,MULA,MULB,MULO)/*synthesis syn_black_box*/;
   input	[15:0]	MULA;
   input    [15:0] 	MULB;
   input 			MDSM;
   output   [31:0] 	MULO;
endmodule // QLK0RMULDIV_MUL