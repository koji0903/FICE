//-----------------------------------------------------------------------------
// Title         : iePortControl_FMakeTest
// Project       : FPGA-ICE
//-----------------------------------------------------------------------------
// File          : iePortControl_FMakeTest.v
// Author        : Author-Name
// Created       : DD.MM.YYYY
// Last modified : DD.MM.YYYY
//-----------------------------------------------------------------------------
// Description : Port signal switch interconnection.
//   1. Bus <-> single signal switcher.
//   2. A/D alternate port enable control. 
//      refer to mkpin Excel to confirm alternate specification.
//
//      VDD category
//        P20/ANI0   -- PORTEN_B0
//        P21/ANI1   -- PORTEN_B1
//        P22/ANI2   -- PORTEN_B2
//        P23/ANI3   -- PORTEN_B3
//        P24/ANI4   -- PORTEN_B4
//        P25/ANI5   -- PORTEN_B5
//        P26/ANI6   -- PORTEN_B6
//        P27/ANI7   -- PORTEN_B7
//        P150/ANI8  -- PORTEN_B8
//        P151/ANI9  -- PORTEN_B9
//        P152/ANI10 -- PORTEN_B10
//        P153/ANI11 -- PORTEN_B11
//        P154/ANI12 -- PORTEN_B12
//        P155/ANI13 -- PORTEN_B13
//        P156/ANI14 -- PORTEN_B14
//      EVDD category
//        P03/ANI16  -- PORTEN_B16
//        P02/ANI17  -- PORTEN_B17
//        P147/ANI18 -- PORTEN_B18
//        P120/ANI19 -- PORTEN_B19
//        P100/ANI20 -- PORTEN_B20
//-----------------------------------------------------------------------------
// Copyright (c) 2012 by Renesas Electronics This model is the confidential and
// proprietary property of Renesas Electronics and the possession or use of this
// file requires a written license from Renesas Electronics.
//------------------------------------------------------------------------------
// Modification history :
// 01.11.2012 : This is EN2-based prototype. Tomonori Tsunoda
//-----------------------------------------------------------------------------

module iePortControl_FMakeTest (/*AUTOARG*/
   // Outputs
   PIO07, PIO06, PIO05, PIO04, PIO03, PIO02, PIO01, PIO00, PIO17,
   PIO16, PIO15, PIO14, PIO13, PIO12, PIO11, PIO10, PIO27, PIO26,
   PIO25, PIO24, PIO23, PIO22, PIO21, PIO20, PIO37, PIO36, PIO35,
   PIO34, PIO33, PIO32, PIO31, PIO30, PIO47, PIO46, PIO45, PIO44,
   PIO43, PIO42, PIO41, PIO40, PIO57, PIO56, PIO55, PIO54, PIO53,
   PIO52, PIO51, PIO50, PIO67, PIO66, PIO65, PIO64, PIO63, PIO62,
   PIO61, PIO60, PIO77, PIO76, PIO75, PIO74, PIO73, PIO72, PIO71,
   PIO70, PIO87, PIO86, PIO85, PIO84, PIO83, PIO82, PIO81, PIO80,
   PIO97, PIO96, PIO95, PIO94, PIO93, PIO92, PIO91, PIO90, PIO102,
   PIO101, PIO100, PIO114, PIO113, PIO112, PIO111, PIO110, PIO127,
   PIO126, PIO125, PIO124, PIO123, PIO122, PIO121, PIO120, PIO137,
   PIO130, PIO147, PIO146, PIO145, PIO144, PIO143, PIO142, PIO141,
   PIO140, PIO156, PIO155, PIO154, PIO153, PIO152, PIO151, PIO150,
   PORTEN_B0, PORTEN_B1, PORTEN_B2, PORTEN_B3, PORTEN_B4, PORTEN_B5,
   PORTEN_B6, PORTEN_B7, PORTEN_B8, PORTEN_B9, PORTEN_B10, PORTEN_B11,
   PORTEN_B12, PORTEN_B13, PORTEN_B14, PORTEN_B16, PORTEN_B17,
   PORTEN_B18, PORTEN_B19, PORTEN_B20, SI00_P11OEB,
   // Inputs
   fpga_pio0, fpga_pio1, fpga_pio2, fpga_pio3, fpga_pio4, fpga_pio5,
   fpga_pio6, fpga_pio7, fpga_pio8, fpga_pio9, fpga_pio10, fpga_pio11,
   fpga_pio12, fpga_pio13_7, fpga_pio13_0, fpga_pio14, fpga_pio15,
   p2eni, p15eni, p0eni, p14eni, p12eni_0, p10eni, SI00_P11, PONRESB
   );
   
   input [7:0] fpga_pio0;
   input [7:0] fpga_pio1;
   input [7:0] fpga_pio2;
   input [7:0] fpga_pio3;
   input [7:0] fpga_pio4;
   input [7:0] fpga_pio5;
   input [7:0] fpga_pio6;
   input [7:0] fpga_pio7;
   input [7:0] fpga_pio8;
   input [7:0] fpga_pio9;
   input [2:0] fpga_pio10;
   input [4:0] fpga_pio11;
   input [7:0] fpga_pio12;
   input       fpga_pio13_7;
   input       fpga_pio13_0;
   input [7:0] fpga_pio14;
   input [6:0] fpga_pio15;
   output      PIO07;
   output      PIO06;
   output      PIO05;
   output      PIO04;
   output      PIO03;
   output      PIO02;
   output      PIO01;
   output      PIO00;
   output      PIO17;
   output      PIO16;
   output      PIO15;
   output      PIO14;
   output      PIO13;
   output      PIO12;
   output      PIO11;
   output      PIO10;
   output      PIO27;
   output      PIO26;
   output      PIO25;
   output      PIO24;
   output      PIO23;
   output      PIO22;
   output      PIO21;
   output      PIO20;
   output      PIO37;
   output      PIO36;
   output      PIO35;
   output      PIO34;
   output      PIO33;
   output      PIO32;
   output      PIO31;
   output      PIO30;
   output      PIO47;
   output      PIO46;
   output      PIO45;
   output      PIO44;
   output      PIO43;
   output      PIO42;
   output      PIO41;
   output      PIO40;
   output      PIO57;
   output      PIO56;
   output      PIO55;
   output      PIO54;
   output      PIO53;
   output      PIO52;
   output      PIO51;
   output      PIO50;
   output      PIO67;
   output      PIO66;
   output      PIO65;
   output      PIO64;
   output      PIO63;
   output      PIO62;
   output      PIO61;
   output      PIO60;
   output      PIO77;
   output      PIO76;
   output      PIO75;
   output      PIO74;
   output      PIO73;
   output      PIO72;
   output      PIO71;
   output      PIO70;
   output      PIO87;
   output      PIO86;
   output      PIO85;
   output      PIO84;
   output      PIO83;
   output      PIO82;
   output      PIO81;
   output      PIO80;
   output      PIO97;
   output      PIO96;
   output      PIO95;
   output      PIO94;
   output      PIO93;
   output      PIO92;
   output      PIO91;
   output      PIO90;
   output      PIO102;
   output      PIO101;
   output      PIO100;
   output      PIO114;
   output      PIO113;
   output      PIO112;
   output      PIO111;
   output      PIO110;
   output      PIO127;
   output      PIO126;
   output      PIO125;
   output      PIO124;
   output      PIO123;
   output      PIO122;
   output      PIO121;
   output      PIO120;
   output      PIO137;
   output      PIO130;
   output      PIO147;
   output      PIO146;
   output      PIO145;
   output      PIO144;
   output      PIO143;
   output      PIO142;
   output      PIO141;
   output      PIO140;
   output      PIO156;
   output      PIO155;
   output      PIO154;
   output      PIO153;
   output      PIO152;
   output      PIO151;
   output      PIO150;
   input [7:0] p2eni;
   input [6:0] p15eni;
   input [7:0] p0eni;
   input [7:0] p14eni;
//   input [7:0] p12eni;
   input       p12eni_0;
   input [2:0] p10eni;
   output      PORTEN_B0;
   output      PORTEN_B1;
   output      PORTEN_B2;
   output      PORTEN_B3;
   output      PORTEN_B4;
   output      PORTEN_B5;
   output      PORTEN_B6;
   output      PORTEN_B7;
   output      PORTEN_B8;
   output      PORTEN_B9;
   output      PORTEN_B10;
   output      PORTEN_B11;
   output      PORTEN_B12;
   output      PORTEN_B13;
   output      PORTEN_B14;
   output      PORTEN_B16;
   output      PORTEN_B17;
   output      PORTEN_B18;
   output      PORTEN_B19;
   output      PORTEN_B20;
   input       SI00_P11;
   output      SI00_P11OEB;
   input       PONRESB;
   
   
   assign SI00_P11OEB = SI00_P11 | PONRESB;
   
   assign {PIO07,
           PIO06,
           PIO05,
           PIO04,
           PIO03,
           PIO02,
           PIO01,
           PIO00} = fpga_pio0;
   
   assign {PIO17,
           PIO16,
           PIO15,
           PIO14,
           PIO13,
           PIO12,
           PIO11,
           PIO10} = fpga_pio1;
   
   assign {PIO27,
           PIO26,
           PIO25,
           PIO24,
           PIO23,
           PIO22,
           PIO21,
           PIO20} = fpga_pio2;
   
   assign {PIO37,
           PIO36,
           PIO35,
           PIO34,
           PIO33,
           PIO32,
           PIO31,
           PIO30} = fpga_pio3;
   
   assign {PIO47,
           PIO46,
           PIO45,
           PIO44,
           PIO43,
           PIO42,
           PIO41,
           PIO40} = fpga_pio4;
   
   assign {PIO57,
           PIO56,
           PIO55,
           PIO54,
           PIO53,
           PIO52,
           PIO51,
           PIO50} = fpga_pio5;
   
   assign {PIO67,
           PIO66,
           PIO65,
           PIO64,
           PIO63,
           PIO62,
           PIO61,
           PIO60} = fpga_pio6;
   
   assign {PIO77,
           PIO76,
           PIO75,
           PIO74,
           PIO73,
           PIO72,
           PIO71,
           PIO70} = fpga_pio7;
   
   assign {PIO87,
           PIO86,
           PIO85,
           PIO84,
           PIO83,
           PIO82,
           PIO81,
           PIO80} = fpga_pio8;
   
   assign {PIO97,
           PIO96,
           PIO95,
           PIO94,
           PIO93,
           PIO92,
           PIO91,
           PIO90} = fpga_pio9;
   
   assign {PIO102,
           PIO101,
           PIO100} = fpga_pio10;
   
   assign {PIO114,
           PIO113,
           PIO112,
           PIO111,
           PIO110} = fpga_pio11;
   
   assign {PIO127,
           PIO126,
           PIO125,
           PIO124,
           PIO123,
           PIO122,
           PIO121,
           PIO120} = fpga_pio12;
   
   assign PIO137 = fpga_pio13_7;
   assign PIO130 = fpga_pio13_0;
   
   assign {PIO147,
           PIO146,
           PIO145,
           PIO144,
           PIO143,
           PIO142,
           PIO141,
           PIO140} = fpga_pio14;
   
   assign {PIO156,
           PIO155,
           PIO154,
           PIO153,
           PIO152,
           PIO151,
           PIO150} = fpga_pio15;
   
   assign PORTEN_B0  = ~p2eni[0];
   assign PORTEN_B1  = ~p2eni[1];
   assign PORTEN_B2  = ~p2eni[2];
   assign PORTEN_B3  = ~p2eni[3];
   assign PORTEN_B4  = ~p2eni[4];
   assign PORTEN_B5  = ~p2eni[5];
   assign PORTEN_B6  = ~p2eni[6];
   assign PORTEN_B7  = ~p2eni[7];
   assign PORTEN_B8  = ~p15eni[0];
   assign PORTEN_B9  = ~p15eni[1];
   assign PORTEN_B10 = ~p15eni[2];
   assign PORTEN_B11 = ~p15eni[3];
   assign PORTEN_B12 = ~p15eni[4];
   assign PORTEN_B13 = ~p15eni[5];
   assign PORTEN_B14 = ~p15eni[6];
   assign PORTEN_B16 = ~p0eni[3];
   assign PORTEN_B17 = ~p0eni[2];
   assign PORTEN_B18 = ~p14eni[7];
   assign PORTEN_B19 = ~p12eni_0;
   assign PORTEN_B20 = ~p10eni[0];
   
endmodule // iePortControl_FMakeTest
