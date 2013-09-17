//-----------------------------------------------------------------------------
// Title         : ieICEControl
// Project       : FPGA-ICE
//-----------------------------------------------------------------------------
// File          : ieICEControl_FMakeTest.v
// Author        : Author-Name
// Created       : DD.MM.YYYY
// Last modified : DD.MM.YYYY
//-----------------------------------------------------------------------------
// Description : This is a macro making ID-Ver, board control signal and other
// functions.
//-----------------------------------------------------------------------------
// Copyright (c) 2012 by Renesas Electronics This model is the confidential and
// proprietary property of Renesas Electronics and the possession or use of this
// file requires a written license from Renesas Electronics.
//------------------------------------------------------------------------------
// Modification history :
// 01.11.2012 : This is EN2-based prototype. Tomonori Tsunoda
//-----------------------------------------------------------------------------
`define FPGA_ICE_VER 32'h9999_9999
//    You must change !! ^^^^ ^^^^ to your <FPGA-ID>_<FPGA-Version>

module  ieICEControl_FMakeTest (/*AUTOARG*/
   // Outputs
   IDVER31, IDVER30, IDVER29, IDVER28, IDVER27, IDVER26, IDVER25,
   IDVER24, IDVER23, IDVER22, IDVER21, IDVER20, IDVER19, IDVER18,
   IDVER17, IDVER16, IDVER15, IDVER14, IDVER13, IDVER12, IDVER11,
   IDVER10, IDVER9, IDVER8, IDVER7, IDVER6, IDVER5, IDVER4, IDVER3,
   IDVER2, IDVER1, IDVER0, SBANDOCD, LVISEL, FPGA_TCCONNECT_B,
   DISEMVDD, DISEMEVDD,
   // Inputs
   SOFTBRK, OCDMOD, SEL_TCCONNECT_B, PSEUDOON31
   );
   
   output IDVER31;
   output IDVER30;
   output IDVER29;
   output IDVER28;
   output IDVER27;
   output IDVER26;
   output IDVER25;
   output IDVER24;
   output IDVER23;
   output IDVER22;
   output IDVER21;
   output IDVER20;
   output IDVER19;
   output IDVER18;
   output IDVER17;
   output IDVER16;
   output IDVER15;
   output IDVER14;
   output IDVER13;
   output IDVER12;
   output IDVER11;
   output IDVER10;
   output IDVER9;
   output IDVER8;
   output IDVER7;
   output IDVER6;
   output IDVER5;
   output IDVER4;
   output IDVER3;
   output IDVER2;
   output IDVER1;
   output IDVER0;
   input  SOFTBRK;
   input  OCDMOD;
   output SBANDOCD;
   output LVISEL;
   input  SEL_TCCONNECT_B;
   output FPGA_TCCONNECT_B;
   input  PSEUDOON31;
   output DISEMVDD;
   output DISEMEVDD;
   
   /* ----- for OCD ----- */
   assign SBANDOCD = SOFTBRK & ~OCDMOD;

   /* ----- for SG2 ----- */
   assign LVISEL = 1'b0 ;
   
   /* ----- for TCCONNECT ----- */
   assign FPGA_TCCONNECT_B = (SEL_TCCONNECT_B) ? 1'bz : 1'b0 ;

   /* ----- for EMVDD discharge ----- */
   assign DISEMVDD = (PSEUDOON31) ? 1'b0 : 1'bz ;
   assign DISEMEVDD = (PSEUDOON31) ? 1'b0 : 1'bz ;

   /* ----- ID Info., Ver Info. ----- */
   assign {IDVER31, IDVER30, IDVER29, IDVER28, IDVER27, IDVER26, IDVER25, IDVER24,
	       IDVER23, IDVER22, IDVER21, IDVER20, IDVER19, IDVER18, IDVER17, IDVER16,
	       IDVER15, IDVER14, IDVER13, IDVER12, IDVER11, IDVER10, IDVER9,  IDVER8,
	       IDVER7,  IDVER6,  IDVER5,  IDVER4,  IDVER3,  IDVER2,  IDVER1,  IDVER0
	       } = `FPGA_ICE_VER;
   
endmodule // ieICEControl_FMakeTest
