//
// Copyright (C) 2010 Renesas Electronics Corporation. All rights reserved.
// Verilog-Model
// DF1.0    2010.04.23 Takashi.Kawano
//                     New Create
// DF1.6    2010.06.08 R.Arakawa
//                     LIB Version were changed.
// DF2.0    2010.06.30 R.Arakawa
//                     Logic were changed.
//                     RTL-net were changed.
//                     FLREGENB/VCPRGWE were added.
// v1.0     2010.07.22 R.Arakawa
//                     Logic were changed.
//                     RTL-net were changed.
// v1.01    2010.08.19 R.Arakawa
//                     DIS-Mode change.
//                     REG125ST change.
//                     RTL-net were change.
//                     RESB added.
//                     POCREL5V changed.
//                     CE Hold Spec Modify
// v1.02    2010.08.30 R.Arakawa
//                     RTL-net were change.
//                     RESET-Check Modify
// v1.03    2010.09.07 R.Arakawa
//                     RTL-net were change.
//                     FIHFL/RDSETUP IOPATH add.
// v1.04    2010.09.15 T.Kawano
//                     DualCheck change (intdce=H/L) NG!!
// v1.05    2010.09.16 T.Kawano
//                     DualCheck change (intdce=H/L)
// v1.06    2010.09.24 R.Arakawa
//                     IDIS/IDDIS change
//                     DualCheck change (READ@LP/DREAD@LP)
//                     TCLKHls 55ns -> 50ns
//
/*
##################################################################
#   PDB Version : v1.07
#   LIB Version : v1.06
#   MF3_SS3rd Series Charge Pump Macro for Flash
#   Macro Name : QNSC3NCP1V2
##################################################################
*/

`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module QNSC3NCP1V2 ( BG1ST, HVPPTS1, FLREGENB,
     OSCOUT, REQFL, RDSETUP, REG125ST, SRCUT, SRCUTCP, TRMRD1, TRMRD2, TRMRD1CK, TRMRD2CK, VBRESZCP,
     VCPHV, VPBIAS, VREGMV, VREGRMV, VPPTS1, CE, CER, CLKSEL1,
     CPBT, CPT, CWEE, DCE, DCER, DCLKSEL1, DDIS, DFLSTOP, DIS, DMRG00,
     DMRG01, DMRG10, DMRG11, DMRG12, DRDCLKC1, DREAD, DSER, DWED, DWWR,
     EXER, EXTVPP1, EXTVPP2, FCLK1, FLSTOP, HISPEED,
     IONCHK1, IREFT, LOWPOWER, LOWSPY, MEOC, MEOR, MRG00, MRG01, MRG10,
     MRG11, MRG12, MSWR, OSCNOSTP, OSCOUTEN, POCREL, PROGI, RDCLKC1,
     RDCLKP1, RDMRG0, RDMRG1, RDMRGC, FIHFL, RDT, READ, POCREL5V,
     RLOWSPY, RTRMCP15, RTRMCP16, RTRMCP17, RTRMCP18, RTRMCP19,
     RTRMCP20, SCANMODE, SER, STCHK, SUB, TESDBT, TRMCP0, TRMCP1,
     TRMCP2, TRMCP3, TRMCP4, TRMCP5, TRMCP6, TRMCP7, TRMCP8, TRMCP9,
     TRMCP15, TRMCP16, TRMCP17,
     VBRESZ, VREG, WDT1, WDT2, WDT3, WDT4, WED, WWR, VCPRGWE, RESB );

output  BG1ST, HVPPTS1, OSCOUT, FLREGENB,
     REQFL, RDSETUP, REG125ST, SRCUTCP, TRMRD1, TRMRD2, TRMRD1CK, TRMRD2CK, VBRESZCP,
     VCPHV, VPBIAS, VREGMV, VREGRMV;

inout  VPPTS1;

input  CE, CER, CLKSEL1, CPBT, CPT, CWEE, DCE, DCER, DCLKSEL1,
     DDIS, DFLSTOP, DIS, DMRG00, DMRG01, DMRG10, DMRG11, DMRG12,
     DRDCLKC1, DREAD, DSER, DWED, DWWR, EXER, EXTVPP1, EXTVPP2, FCLK1,
     FLSTOP, HISPEED, IONCHK1, IREFT, LOWPOWER, LOWSPY, MEOC,
     MEOR, MRG00, MRG01, MRG10, MRG11, MRG12, MSWR, OSCNOSTP, OSCOUTEN,
     POCREL, PROGI, RDCLKC1, RDCLKP1, RDMRG0, RDMRG1, RDMRGC, FIHFL,
     RDT, READ, POCREL5V, RLOWSPY, RTRMCP15, RTRMCP16, RTRMCP17,
     RTRMCP18, RTRMCP19, RTRMCP20, SCANMODE, SER, SRCUT, STCHK, SUB, TESDBT,
     TRMCP0, TRMCP1, TRMCP2, TRMCP3, TRMCP4, TRMCP5, TRMCP6, TRMCP7,
     TRMCP8, TRMCP9, TRMCP15, TRMCP16, TRMCP17, VBRESZ, VREG, WDT1, WDT2,
     WDT3, WDT4, WED, WWR, VCPRGWE, RESB;


/*-----parameter-----*/
// Parameter Mode Control
  parameter M_DIS     = 23'b10000000000000000000000; //22
  parameter M_WWR     = 23'b01000000000000000000000; //21
  parameter M_MSWR    = 23'b00100000000000000000000; //20
  parameter M_SER     = 23'b00010000000000000000000; //19
  parameter M_CER     = 23'b00001000000000000000000; //18
  parameter M_EXER    = 23'b00000100000000000000000; //17
  parameter M_MRG00   = 23'b00000010000000000000000; //16
  parameter M_MRG01   = 23'b00000001000000000000000; //15
  parameter M_MRG10   = 23'b00000000100000000000000; //14
  parameter M_MRG11   = 23'b00000000010000000000000; //13
  parameter M_MRG12   = 23'b00000000001000000000000; //12
  parameter M_READ    = 23'b00000000000100000000000; //11
  parameter M_IONCHK1 = 23'b00000000000010000000000; //10
  parameter M_CPBT    = 23'b00000000000001000000000; //9
  parameter M_WDT1    = 23'b00000000000000100000000; //8
  parameter M_WDT2    = 23'b00000000000000010000000; //7
  parameter M_WDT3    = 23'b00000000000000001000000; //6
  parameter M_WDT4    = 23'b00000000000000000100000; //5
  parameter M_RDT     = 23'b00000000000000000010000; //4
  parameter M_RDMRG0  = 23'b00000000000000000001000; //3
  parameter M_RDMRG1  = 23'b00000000000000000000100; //2
  parameter M_RDMRGC  = 23'b00000000000000000000010; //1
  parameter M_STCHK   = 23'b00000000000000000000001; //0

  parameter M_ALL0    = 23'b00000000000000000000000;
  parameter M_M01M11  = 23'b00000001010000000000000;
  parameter M_M01M12  = 23'b00000001001000000000000;
  parameter M_MRG     = 23'b00000011111000000000000;
  parameter M_RDMRG01 = 23'b00000000000000000001100;
  parameter M_WDT     = 23'b00000000000000111100000;
  parameter M_STOP    = 23'b00000000000100000000000; // For READ=H DCE=L v1.04 DualCheck error
//  parameter M_ERR     = 23'b11111111111111111111111; // v1.04 For DualCheck error

//                         EE
//                         XX
//                         TT I
//                         VV RC
//                         PPCEW
//                         PPPFE
//                         12TTE
  parameter M_INTVPP  = 5'b00000;
  parameter M_INT_CWEE= 5'b00001;  // CWEE=H
  parameter M_EXTVPP1 = 5'b10000;
  parameter M_EX1_CWEE= 5'b10001;  // EXTVPP1=H & CWEE=H
  parameter M_EXTVPP2 = 5'b01000;
  parameter M_EX2_CWEE= 5'b01001;  // EXTVPP2=H & CWEE=H
  parameter M_CPT     = 5'b00100;
  parameter M_CPT_CWEE= 5'b00101;  // CWEE=H
  parameter M_CPT_EX1 = 5'b10100;  // CPT=H & EXTVPP1=H
  parameter M_CPT_EX1C= 5'b10101;  // CPT=H & EXTVPP1=H & CWEE=H
  parameter M_CPT_EX2 = 5'b01100;  // CPT=H & EXTVPP2=H
  parameter M_CPT_EX2C= 5'b01101;  // CPT=H & EXTVPP2=H & CWEE=H
  parameter M_IREFT   = 5'b00010;
  parameter M_IRE_CWEE= 5'b00011;  // IREFT=H & CWEE=H

// READ REQFL & RDSETUP Contorl Time
  parameter TTRMRD1toTRMRD3    =   10000000;
  parameter TTRMRD3toHS        =    5000000;
  parameter TTRMRD3toLS        =    3000000;
  parameter TTRMRD3toLP        =    3000000;
  parameter TSTOPtoHS          =    5000000;
  parameter TSTOPtoLS          =     720000;
  parameter TSTOPtoLV          =   10000000;
  parameter TSTOPtoLP          =     720000;
  parameter TSRCUTStoHS        =     720000;
  parameter TSRCUTStoLS        =     720000;
  parameter TSRCUTStoLV        =     720000;
  parameter TSRCUTStoLP        =     720000;

  parameter TMS_DIStoHS        =    5000000;
  parameter TMS_DIStoLS        =    3000000;
  parameter TMS_DIStoLV        =   10000000;
  parameter TMS_DIStoLP        =    5000000;

// SPEC param
  parameter TMS2_TRMRD2        =    5050000;   // TRIMING READ2 tMS2
  parameter TMS_TRMRDCLK       =    5000000;   // TRMRDCLK=H WaitTime
  parameter TTRMCLKW           =      31250;   // FIHFL@32MHz
  parameter TMS_FCLK1          =   10000000;   // FCLK1 REQFL tMS
  parameter TSRCUTH            =      10000;   // SRCUTCP tSRCUTH

// OSCOUT Freq
  parameter OSCF_101 = 227520;
  parameter OSCF_110 = 211200;
  parameter OSCF_111 = 200800;
  parameter OSCF_000 = 190720;
  parameter OSCF_001 = 177600;
  parameter OSCF_010 = 159056;
  parameter OSCF_011 = 145184;
  parameter OSCF_100 = 128032;

// RESET Signal State
//                                                                         DD        L       OOS
//                                             I          EE              DRC  RRC   OHR     SSC
//                                             O       RRRXX       DDDDD  FDL  DDL   WILL    CCAT
//                                      MMMMM  NS      DDDTT I     MMMMM DLCK  CCK   PSOOSFP ONNE
//                                  M  ERRRRR RCTCWWWW MMMVV RMMDDDRRRRRDRSLS DLLS C OPWWRCR UOMS
//                                 WSCSXGGGGGDEHCPDDDDRRRRPPCEEEWCSGGGGGDETKEDWKKE WSWESSCLOWTSOD
//                                 WWEEE00111IAKHBTTTTDGGGPPPFOOWEE00111IAOCLCECPLCEUEEPPUKGEETDB
//                                 RRRRR01012SD1KT1234T01C12TTRCRRR01012SDP11ED111EEBRDYYT1IDNPET
  parameter [61:0] RESET_chk = 62'b00000000000100000000000000000000000001011001010000001000010000;

`ifndef FPGA_ICE  //## For FPGA_ICE Switch_1

/*-----event-----*/
  event ActSet_TTRMRD1toTRMRD3;
  event ActSet_TTRMRD3toHS;
  event ActSet_TTRMRD3toLS;
  event ActSet_TTRMRD3toLP;
  event ActSet_TSTOPtoHS;
  event ActSet_TSTOPtoLS;
  event ActSet_TSTOPtoLV;
  event ActSet_TSTOPtoLP;
  event ActSet_TSRCUTStoHS;
  event ActSet_TSRCUTStoLS;
  event ActSet_TSRCUTStoLV;
  event ActSet_TSRCUTStoLP;

  event ActSet_TMS_DIStoHS;
  event ActSet_TMS_DIStoLS;
  event ActSet_TMS_DIStoLV;
  event ActSet_TMS_DIStoLP;

  event ActSet_TMS2_TRMRD2;
  event ActSet_TMS_TRMRDCLK;
  event ActSet_TMS_FCLK1;
  event ActSet_TSRCUTH;

/*----- time -----*/
//  time FIHFLposetime,pre_FIHFLposetime;
//  time FIHFLnegetime,pre_FIHFLnegetime;
//  time FIHFLcycle,FIHFLwidth;
//  time TTRMCLKwidth;
//  time TSRCUTwidth;

`endif  //## For FPGA_ICE Switch_1

/*-----flash interface setting-----*/
  integer i,j,k,l,m,n,o,p,q,r,s,t,u;
//  integer FIHFL_cnt;
  integer progi_cnt;
  integer xz_aa,xz_bb,xz_cc,xz_dd,xz_ee;
  reg pre_RDCLKC1, pre_RDCLKP1, pre_DRDCLKC1;
  reg pre_PROGI, pre_VBRESZ, pre_POCREL, pre_FIHFL;
  reg pre_HISPEED, pre_LOWPOWER, pre_RLOWSPY, pre_SUB, pre_LOWSPY;
  reg pre_SRCUT, pre_FLSTOP, pre_DFLSTOP, pre_FCLK1, pre_DFCLK1;
  reg pre_IDIS, pre_IDDIS;
  reg [3:1] pre_TRMREAD_act;
  reg intce, intdce, inthispeed, intlowpower, intsub, intrlowspy;
  reg [3:0] intrdctrl_c1, prevRDCTRL_C1;
  reg [3:0] intrdctrl_p1, prevRDCTRL_P1;
  reg prevCE,prevDCE,prevHISPEED,prevLOWPOWER,prevRLOWSPY,prevSUB;
  reg PROGD;
  reg [120:1] VIOLATE_sig,XZ_sig;
  reg [22:0] MODE,pre_MODE,MODE_dop;
  reg [22:0] DMODE,pre_DMODE,DMODE_dop;
  reg [5:0] MODE_IV,pre_MODE_IV;  // InternalVerify
  reg [5:0] DMODE_IV,pre_DMODE_IV;  // InternalVerify
  reg CIBRead_act,FCBRead_act,MRG_act,WR_act,
      WDT_act,ION_act,RDMRG_act;  // CODE-Flash
  reg DCIBRead_act,DFCBRead_act,DMRG_act,DWR_act,
      DWDT_act,DION_act,DRDMRG_act;  // DATA-Flash
  reg IDIS, IDDIS;
  reg Error_flag;
  reg Error_flag_XZ;
  reg Error_flag_DOP;
  reg [4:0] MODE2,pre_MODE2;
  reg pre_SCANMODE,pre_TESDBT;
  reg pre_TRMRD2L,TRMRD2L;  // For RESET Timing
  reg SRCUTCP_act;
  reg RESETCHK_act;
  reg tmp_OSCOUT;  // For OSCOUT Control
  reg [61:0] RESET_st;
  reg pre_CWEE;

  wire [9:0] TRMCP9_0;
  wire [17:15] TRMCP17_15;
  wire [20:15] RTRMCP;
  wire EWR_act;  // Mode Function Action!!
  wire BTmode_act;  // BT-Mode
  wire OSCOUT_act;
  wire ts1_outcnt,ts1_incnt;
  wire cpt1_act,cpt2_act,cpt3_act,cpt4_act,cpt5_act;
  wire Cex1_act,Dex1_act;
  wire Cint_act,Dint_act,Cireft_act,Direft_act;
//  wire Cex2_act,Dex2_act;
  wire pow_sig=1'b1;

/*-----For Specify Flag-----*/
  reg SUBRDCLK,DSUBRDCLK;
  integer EdgeLCount,DEdgeLCount;
  wire RDCLK,DRDCLK;

/*-----DummyBuff-----*/
buf (_RESB, RESB);  // v1.01_add
buf (FLREGENB, _FLREGENB);
buf (_VCPRGWE, VCPRGWE);
buf (OSCOUT, _OSCOUT);
buf (_DMRG10, DMRG10);
buf (_DMRG00, DMRG00);
buf (_TRMCP2, TRMCP2);
buf (_TRMCP1, TRMCP1);
buf (_TRMCP0, TRMCP0);
buf (_WED, WED);
buf (_PROGI, PROGI);
buf (_EXTVPP1, EXTVPP1);
buf (_CPT, CPT);
buf (_EXTVPP2, EXTVPP2);
buf (_CER, CER);
buf (_WWR, WWR);
buf (_MSWR, MSWR);
buf (_DWED, DWED);
buf (TRMRD1, _TRMRD1);
buf (TRMRD2, _TRMRD2);
buf (_VREG, VREG);
buf (_DDIS, DDIS);
buf (_DMRG12, DMRG12);
buf (_DMRG11, DMRG11);
buf (SRCUTCP, _SRCUTCP);
buf (RDSETUP, _RDSETUP);
buf (VREGMV, _VREGMV);
buf (REG125ST, _REG125ST);
buf (VCPHV, _VCPHV);
buf (BG1ST, _BG1ST);
buf (HVPPTS1, _HVPPTS1);
buf (VPBIAS, _VPBIAS);
buf (_DWWR, DWWR);
buf (_DCER, DCER);
buf (_DSER, DSER);
buf (_DMRG01, DMRG01);
buf (_OSCNOSTP, OSCNOSTP);
buf (_DREAD, DREAD);
buf (_TRMCP4, TRMCP4);
buf (_TRMCP3, TRMCP3);
buf (_OSCOUTEN, OSCOUTEN);
buf (_FIHFL, FIHFL);
buf (_RTRMCP16, RTRMCP16);
buf (_POCREL5V, POCREL5V);
buf (_RTRMCP15, RTRMCP15);
buf (_MEOC, MEOC);
buf (_MEOR, MEOR);
buf (_TESDBT, TESDBT);
buf (_SCANMODE, SCANMODE);
buf (_POCREL, POCREL);
buf (REQFL, _REQFL);
buf (_CWEE, CWEE);
buf (_SUB, SUB);
buf (_LOWPOWER, LOWPOWER);
buf (_CE, CE);
buf (_CLKSEL1, CLKSEL1);
buf (_RDCLKP1, RDCLKP1);
buf (_RDCLKC1, RDCLKC1);
buf (_VBRESZ, VBRESZ);
buf (_FLSTOP, FLSTOP);
buf (_IREFT, IREFT);
buf (_READ, READ);
buf (_CPBT, CPBT);
buf (_WDT1, WDT1);
buf (_STCHK, STCHK);
buf (_IONCHK1, IONCHK1);
buf (_MRG11, MRG11);
buf (_MRG12, MRG12);
buf (_DIS, DIS);
buf (_EXER, EXER);
buf (_MRG00, MRG00);
buf (_MRG10, MRG10);
buf (_MRG01, MRG01);
buf (_SER, SER);
buf (_DFLSTOP, DFLSTOP);
buf (_DRDCLKC1, DRDCLKC1);
buf (VREGRMV, _VREGRMV);
buf (_DCLKSEL1, DCLKSEL1);
buf (_DCE, DCE);
buf (_TRMCP7, TRMCP7);
buf (_TRMCP6, TRMCP6);
buf (_TRMCP5, TRMCP5);
buf (_RTRMCP19, RTRMCP19);
buf (_RTRMCP20, RTRMCP20);
buf (_TRMCP9, TRMCP9);
buf (_TRMCP8, TRMCP8);
buf (_RTRMCP18, RTRMCP18);
buf (_FCLK1, FCLK1);
buf (_RTRMCP17, RTRMCP17);
buf (_HISPEED, HISPEED);
buf (_LOWSPY, LOWSPY);
buf (_RLOWSPY, RLOWSPY);
buf (_RDMRGC, RDMRGC);
buf (_RDMRG1, RDMRG1);
buf (_RDMRG0, RDMRG0);
buf (_WDT2, WDT2);
buf (_WDT3, WDT3);
buf (_RDT, RDT);
buf (_WDT4, WDT4);
buf (_TRMCP15, TRMCP15);
buf (_TRMCP16, TRMCP16);
buf (_TRMCP17, TRMCP17);
buf (_SRCUT, SRCUT);
buf (TRMRD1CK, _TRMRD1CK);
buf (TRMRD2CK, _TRMRD2CK);
buf (VBRESZCP, _VBRESZCP);

`ifndef FPGA_ICE  //## For FPGA_ICE Switch_2

nmos (VPPTS1, _VPPTS1, ts1_outcnt);
nmos (_VPPTS1, VPPTS1, ts1_incnt);

/*-----Create Signals-----*/
////////////////////////////////////
// DualOpFunc Add
////////////////////////////////////
assign _VCPHV= (IDIS!==1'bx && IDDIS!==1'bx) && Error_flag_DOP!==1'b1 && _POCREL5V===1'b1 && _POCREL===1'b1 ? 1'b1 : 1'b0;
assign _VREGMV= (IDIS!==1'bx && IDDIS!==1'bx) && Error_flag_DOP!==1'b1 && _POCREL5V===1'b1 && _POCREL===1'b1 ? 1'b1 : 1'b0;
assign _VREGRMV= (IDIS!==1'bx && IDDIS!==1'bx) && Error_flag_DOP!==1'b1 && _POCREL5V===1'b1 && _POCREL===1'b1 ? 1'b1 : 1'b0;
assign _HVPPTS1= (IDIS===1'b0 || IDDIS===1'b0) && Error_flag_DOP!==1'b1 && _POCREL5V===1'b1 && _POCREL===1'b1 ? 1'b1 : 1'b0;
assign _VPBIAS= (IDIS===1'b0 || IDDIS===1'b0) && Error_flag_DOP!==1'b1 && _POCREL5V===1'b1 && _POCREL===1'b1 ? 1'b1 : 1'b0;

/*-----Create IntNode-----*/
buf (TRMCP9_0[9], _TRMCP9);
buf (TRMCP9_0[8], _TRMCP8);
buf (TRMCP9_0[7], _TRMCP7);
buf (TRMCP9_0[6], _TRMCP6);
buf (TRMCP9_0[5], _TRMCP5);
buf (TRMCP9_0[4], _TRMCP4);
buf (TRMCP9_0[3], _TRMCP3);
buf (TRMCP9_0[2], _TRMCP2);
buf (TRMCP9_0[1], _TRMCP1);
buf (TRMCP9_0[0], _TRMCP0);
buf (TRMCP17_15[17], _TRMCP17);
buf (TRMCP17_15[16], _TRMCP16);
buf (TRMCP17_15[15], _TRMCP15);
buf (RTRMCP[20], _RTRMCP20);
buf (RTRMCP[19], _RTRMCP19);
buf (RTRMCP[18], _RTRMCP18);
buf (RTRMCP[17], _RTRMCP17);
buf (RTRMCP[16], _RTRMCP16);
buf (RTRMCP[15], _RTRMCP15);

buf (_OSCOUT, tmp_OSCOUT);

/*-----VPPTS1 Control-----*/
bufif1 (_VPPTS1, 1'b1, ts1_outcnt);

assign ts1_incnt = (|{Cint_act,Dint_act,Cex1_act,Dex1_act,Cireft_act,Direft_act}===1'b1) && EWR_act===1'b1 &&
                    _TRMRD1===1'b0 && _TRMRD2===1'b0 ? 1'b1 : 1'b0;
assign ts1_outcnt = (|{cpt1_act,cpt2_act,cpt3_act,cpt4_act,cpt5_act}===1'b1) && EWR_act===1'b1 &&
                     _TRMRD1===1'b0 && _TRMRD2===1'b0 ? 1'b1 : 1'b0;

//##INTVPP Control
assign Cint_act = MODE===M_WDT1 && MODE2===M_INT_CWEE ? 1'b1 : 1'b0;
assign Dint_act = DMODE===M_WDT1 ? 1'b1 : 1'b0;

//##EXTVPP1 Control
assign Cex1_act = intce===1'b1 &&
                  (((MODE===M_WWR || MODE===M_MSWR || MODE===M_SER || MODE===M_CER || MODE===M_EXER ||
                     MODE===M_MRG00 || MODE===M_MRG01 || MODE===M_MRG10 || MODE===M_MRG11 || MODE===M_MRG12 ||
                     MODE===M_READ || MODE===M_IONCHK1 || MODE===M_CPBT || MODE===M_WDT1 || MODE===M_WDT2 || MODE===M_WDT3 ||
                     MODE===M_WDT4 || MODE===M_RDT || MODE===M_RDMRG0 || MODE===M_RDMRG1 || MODE===M_RDMRGC ||
                     MODE===M_STCHK) && MODE2===M_EX1_CWEE) ||
                   ((MODE===M_READ || MODE===M_IONCHK1 || MODE===M_STCHK ||
                     MODE===M_RDMRG0 || MODE===M_RDMRG1 || MODE===M_RDMRGC) && MODE2===M_EXTVPP1)) ? 1'b1 : 1'b0;
assign Dex1_act = intdce===1'b1 &&
                  (((DMODE===M_WWR || DMODE===M_MSWR || DMODE===M_SER || DMODE===M_CER || DMODE===M_EXER ||
                     DMODE===M_MRG00 || DMODE===M_MRG01 || DMODE===M_MRG10 || DMODE===M_MRG11 || DMODE===M_MRG12 ||
                     DMODE===M_READ || DMODE===M_IONCHK1 || DMODE===M_WDT1 || DMODE===M_WDT2 || DMODE===M_WDT3 ||
                     DMODE===M_WDT4 || DMODE===M_RDT || DMODE===M_RDMRG0 || DMODE===M_RDMRG1 || DMODE===M_RDMRGC ||
                     DMODE===M_STCHK) && MODE2===M_EXTVPP1) ||
                   ((DMODE===M_READ || DMODE===M_IONCHK1 || DMODE===M_STCHK || DMODE===M_RDMRG0 || DMODE===M_RDMRG1 ||
                     DMODE===M_RDMRGC || MODE===M_WDT1 || MODE===M_WDT2 || MODE===M_WDT3 ||MODE===M_WDT4 || MODE===M_CPBT || 
		     DMODE===M_MSWR || DMODE===M_EXER || DMODE===M_RDT) && MODE2===M_EX1_CWEE)) ? 1'b1 : 1'b0;
//##EXTVPP2 Control
//assign Cex2_act = 1'b0;
//assign Dex2_act = 1'b0;

//##CPT Control
assign cpt1_act = intce===1'b1 && MODE2===M_CPT_CWEE && _OSCNOSTP===1'b0 &&
                  (IDIS===1'b1 || MODE===M_WWR || MODE===M_MSWR || MODE===M_SER || MODE===M_CER || MODE===M_EXER ||
                   MODE===M_MRG00 || MODE===M_MRG01 || MODE===M_MRG10 || MODE===M_MRG11 || MODE===M_MRG12 ||
                   MODE===M_READ || MODE===M_IONCHK1 || MODE===M_CPBT || MODE===M_WDT1 || MODE===M_WDT2 ||
                   MODE===M_WDT3 || MODE===M_WDT4 || MODE===M_RDT || MODE===M_RDMRG0 || MODE===M_RDMRG1 ||
                   MODE===M_RDMRGC || MODE===M_STCHK) ? 1'b1 : 1'b0;
assign cpt2_act = intce===1'b1 && MODE2===M_CPT && _OSCNOSTP===1'b0 &&
                  (MODE===M_READ || MODE===M_RDT || MODE===M_STCHK || MODE===M_RDMRG0 || MODE===M_RDMRG1 ||
                   MODE===M_RDMRGC) ? 1'b1 : 1'b0;
assign cpt3_act = intce===1'b1 && MODE2===M_CPT_EX1C && _OSCNOSTP===1'b0 &&
                  (MODE===M_WWR || MODE===M_MSWR || MODE===M_SER || MODE===M_CER || MODE===M_EXER ||
                   MODE===M_CPBT || MODE===M_WDT1 || MODE===M_WDT2 || MODE===M_WDT3 || MODE===M_WDT4) ? 1'b1 : 1'b0;
assign cpt4_act = intce===1'b1 && MODE2===M_CPT_EX1C && _OSCNOSTP===1'b1 &&
                  (MODE===M_WWR || MODE===M_CER) ? 1'b1 : 1'b0;
assign cpt5_act = intce===1'b1 && MODE2===M_CPT_EX2C && _OSCNOSTP===1'b0 &&
                  (MODE===M_WWR || MODE===M_MSWR || MODE===M_WDT1 || MODE===M_WDT2 ||
                   MODE===M_WDT3 || MODE===M_WDT4) ? 1'b1 : 1'b0;

//##IREFT Contorol
assign Cireft_act = intce===1'b1 &&
                    (((MODE===M_WWR || MODE===M_MSWR || MODE===M_MRG00 || MODE===M_MRG01 ||
                       MODE===M_MRG10 || MODE===M_MRG11 || MODE===M_MRG12 || MODE===M_READ ||
                       MODE===M_STCHK || MODE===M_RDMRG0 || MODE===M_RDMRG1) && MODE2===M_IRE_CWEE) ||
                     ((MODE===M_READ || MODE===M_STCHK || MODE===M_RDMRG0 || MODE===M_RDMRG1) && MODE2===M_IREFT)) ? 1'b1 : 1'b0;
assign Direft_act = intdce===1'b1 &&
                    (((DMODE===M_WWR || DMODE===M_MSWR || DMODE===M_READ ||
                       DMODE===M_STCHK || DMODE===M_RDMRG0 || DMODE===M_RDMRG1) && MODE2===M_IRE_CWEE) ||
                     ((DMODE===M_MRG00 || DMODE===M_MRG01 || DMODE===M_MRG10 || DMODE===M_MRG11 || DMODE===M_MRG12 ||
                       DMODE===M_READ || DMODE===M_STCHK || DMODE===M_RDMRG0 || DMODE===M_RDMRG1) && MODE2===M_IREFT)) ? 1'b1 : 1'b0;
//-----MODE_act
buf (EWR_act,(_VBRESZ===1'b1 && _SCANMODE===1'b0 && _TESDBT===1'b0) ? 1'b1 : 1'b0);  // Zantei
buf (BTmode_act,(_VBRESZ===1'b1 && _SCANMODE===1'b1 && _TESDBT===1'b1) ? 1'b1 : 1'b0);  // BT-Node
buf (OSCOUT_act,IDIS===1'b0 && intce===1'b1 &&
                (((|{_WWR,_MSWR}===1'b1) && PROGD===1'b1) || ((|{_SER,_CER,_EXER}===1'b1) && _FCLK1===1'b1) || _CPBT===1'b1 ) &&
                _CPT===1'b1 && _FLSTOP===1'b0 && _OSCOUTEN===1'b1 ? 1'b1 : 1'b0);

/*-----CP Function-----*/
always @ (_DIS or _WWR or _MSWR or _SER or _CER or _EXER or
          _MRG00 or _MRG01 or _MRG10 or _MRG11 or _MRG12 or _READ or _IONCHK1 or
          _CPBT or _WDT1 or _WDT2 or _WDT3 or _WDT4 or _RDT or
          _RDMRG0 or _RDMRG1 or _RDMRGC or _STCHK or
          _DDIS or _DWWR or _DSER or _DCER or _DREAD or
          _DMRG00 or _DMRG01 or _DMRG10 or _DMRG11 or _DMRG12 or
          _CLKSEL1 or _DCLKSEL1 or
          _EXTVPP1 or _EXTVPP2 or _CPT or _IREFT or _CWEE or
          _WED or _DWED or _SCANMODE or _TESDBT or intce or intdce or _VBRESZCP) begin  // v1.06_modefiy

//### XZ Check
//  if (EWR_act===1'b1 || BTmode_act===1'b1) QNS_MODE_XZ_CHK;

//### DIS-Code
//v1.01  if ((_DIS===1'b1 || ((_WED===1'b1 || _CWEE===1'b0) &&            //##### Data-Flash _CWEE===1'b1 #####//
//v1.01      ((_WWR===1'b1 || _CER===1'b1 || _SER===1'b1) && _EXTVPP1===1'b0 && _EXTVPP2===1'b0)) ||
  if ((_DIS===1'b1 || (_WED===1'b1 &&
      (|{_WWR,_MSWR,_SER,_CER,_EXER,_CPBT,_WDT1,_WDT2,_WDT3,_WDT4,_RDT}===1'b1)) ||
      ({_WWR,_MSWR,_SER,_CER,_EXER,
        _MRG00,_MRG01,_MRG10,_MRG11,_MRG12,_READ,_IONCHK1,
        _CPBT,_WDT1,_WDT2,_WDT3,_WDT4,_RDT,_RDMRG0,_RDMRG1,_RDMRGC,_STCHK}===22'h0) ||
      ({intce,_MRG00,_MRG01,_MRG10,_MRG11,_MRG12,_READ,_CPBT,_WDT4,_RDT,_RDMRG0,_RDMRG1}===12'h0) ||
       (_SCANMODE===1'b1 && _TESDBT===1'b0) || _VBRESZCP===1'b0) &&
       ~(_SCANMODE===1'b1 && _TESDBT===1'b1)) IDIS=1'b1;
  else IDIS=1'b0;

//### DDIS-Data
//v1.01  if ((_DDIS===1'b1 || ((_DWED===1'b1 || _CWEE===1'b1) &&            //##### Data-Flash _CWEE===1'b1 #####//
//v1.01      ((_DWWR===1'b1 || _DCER===1'b1 || _DSER===1'b1) && _EXTVPP1===1'b0 && _EXTVPP2===1'b0)) ||
  if ((_DDIS===1'b1 || (_DWED===1'b1 &&
      (|{_DWWR,_MSWR,_DSER,_DCER,_EXER,_CPBT,_WDT1,_WDT2,_WDT3,_WDT4,_RDT}===1'b1)) ||
      ({_DWWR,_MSWR,_DSER,_DCER,_EXER,
        _DMRG00,_DMRG01,_DMRG10,_DMRG11,_DMRG12,_DREAD,_IONCHK1,
        _CPBT,_WDT1,_WDT2,_WDT3,_WDT4,_RDT,_RDMRG0,_RDMRG1,_RDMRGC,_STCHK}===22'h0) ||
      ({intdce,_DMRG00,_DMRG01,_DMRG10,_DMRG11,_DMRG12,_DREAD,_CPBT,_WDT4,_RDT,_RDMRG0,_RDMRG1}===12'h0) ||
       (_SCANMODE===1'b1 && _TESDBT===1'b0) || _VBRESZCP===1'b0) &&
       ~(_SCANMODE===1'b1 && _TESDBT===1'b1)) IDDIS=1'b1;
  else IDDIS=1'b0;

//### MODE-Code
  MODE = {IDIS,_WWR,_MSWR,_SER,_CER,_EXER,
        _MRG00,_MRG01,_MRG10,_MRG11,_MRG12,_READ,_IONCHK1,
        _CPBT,_WDT1,_WDT2,_WDT3,_WDT4,_RDT,_RDMRG0,_RDMRG1,_RDMRGC,_STCHK};
  MODE_IV = {IDIS,_MRG00,_MRG01,_MRG10,_MRG11,_MRG12};

//### MODE-Data
  DMODE = {IDDIS,_DWWR,_MSWR,_DSER,_DCER,_EXER,
        _DMRG00,_DMRG01,_DMRG10,_DMRG11,_DMRG12,_DREAD,_IONCHK1,
        _CPBT,_WDT1,_WDT2,_WDT3,_WDT4,_RDT,_RDMRG0,_RDMRG1,_RDMRGC,_STCHK};
  DMODE_IV = {IDDIS,_DMRG00,_DMRG01,_DMRG10,_DMRG11,_DMRG12};

//### MODE2
  MODE2 = {_EXTVPP1,_EXTVPP2,_CPT,_IREFT,_CWEE};

//### CodeFlash MODE_FLAG 100724
  if (IDIS!==1'b1 && MODE===M_READ && _CLKSEL1===1'b1 && _SCANMODE===1'b0 &&
     (MODE2===M_INTVPP || MODE2===M_INT_CWEE || MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE ||
      MODE2===M_CPT || MODE2===M_CPT_CWEE || MODE2===M_IREFT || MODE2===M_IRE_CWEE)) CIBRead_act=1'b1;
  else CIBRead_act=1'b0;
  if (IDIS!==1'b1 && MODE===M_READ && _CLKSEL1===1'b0 && _SCANMODE===1'b0 &&
     (MODE2===M_INTVPP || MODE2===M_INT_CWEE || MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE ||
      MODE2===M_CPT || MODE2===M_CPT_CWEE || MODE2===M_IREFT || MODE2===M_IRE_CWEE)) FCBRead_act=1'b1;
  else FCBRead_act=1'b0;
  if ((IDIS!==1'b1 && _CLKSEL1===1'b0 && _SCANMODE===1'b0 && (MODE===M_WWR || MODE===M_MSWR) &&
     (MODE2===M_INT_CWEE || MODE2===M_EX1_CWEE || MODE2===M_EX2_CWEE ||
      MODE2===M_CPT_CWEE || MODE2===M_CPT_EX1C || MODE2===M_CPT_EX2C || MODE2===M_IRE_CWEE)) && pow_sig===1'b1) WR_act=1'b1;
  else WR_act=1'b0;
  if (IDIS!==1'b1 && _SCANMODE===1'b0 && (MODE===M_MRG00 || MODE===M_MRG01 || MODE===M_MRG10 ||
      MODE===M_MRG11 || MODE===M_MRG12) &&
      (MODE2===M_INT_CWEE || MODE2===M_EX1_CWEE || MODE2===M_CPT_CWEE || MODE2===M_IRE_CWEE)) MRG_act=1'b1;
  else MRG_act=1'b0;
  if (IDIS!==1'b1 && _SCANMODE===1'b0 && MODE===M_IONCHK1 &&
     (MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE || MODE2===M_EXTVPP2 || MODE2===M_EX2_CWEE ||
      MODE2===M_CPT_CWEE)) ION_act=1'b1;
  else ION_act=1'b0;
  if (((IDIS!==1'b1 && _SCANMODE===1'b0 && (MODE===M_WDT1 || MODE===M_WDT2) &&
      (MODE2===M_INT_CWEE || MODE2===M_EX1_CWEE || MODE2===M_EX2_CWEE || MODE2===M_CPT_CWEE || MODE2===M_CPT_EX1C || MODE2===M_CPT_EX2C)) ||
      (IDIS!==1'b1 && _SCANMODE===1'b0 && (MODE===M_WDT3 || MODE===M_WDT4) &&
      (MODE2===M_INT_CWEE || MODE2===M_EX1_CWEE || MODE2===M_CPT_CWEE || MODE2===M_CPT_EX1C || MODE2===M_CPT_EX2C))) && pow_sig===1'b1) WDT_act=1'b1;
  else WDT_act=1'b0;
  if ((IDIS!==1'b1 && _SCANMODE===1'b0 && (MODE===M_RDMRG0 || MODE===M_RDMRG1) &&
      (MODE2===M_INTVPP || MODE2===M_INT_CWEE || MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE ||
       MODE2===M_CPT || MODE2===M_CPT_CWEE || MODE2===M_IREFT || MODE2===M_IRE_CWEE)) ||
      (IDIS!==1'b1 && _SCANMODE===1'b0 && MODE===M_RDMRGC &&
      (MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE ||MODE2===M_EXTVPP2 || MODE2===M_EX2_CWEE ||
       MODE2===M_CPT || MODE2===M_CPT_CWEE))) RDMRG_act=1'b1;
  else RDMRG_act=1'b0;

//### DataFlash MODE_FLAG 100724
  if (IDDIS!==1'b1 && DMODE===M_READ && _DCLKSEL1===1'b1 && _SCANMODE===1'b0 &&
     (MODE2===M_INTVPP || MODE2===M_INT_CWEE || MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE ||
      MODE2===M_IREFT || MODE2===M_IRE_CWEE)) DCIBRead_act=1'b1;
  else DCIBRead_act=1'b0;
  if (IDDIS!==1'b1 && DMODE===M_READ && _DCLKSEL1===1'b0 && _SCANMODE===1'b0 &&
     (MODE2===M_INTVPP || MODE2===M_INT_CWEE || MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE || 
      MODE2===M_IREFT || MODE2===M_IRE_CWEE)) DFCBRead_act=1'b1;  
  else DFCBRead_act=1'b0;
  if (IDDIS!==1'b1 && _DCLKSEL1===1'b0 && _SCANMODE===1'b0 && (((DMODE===M_WWR || DMODE===M_MSWR) &&
     (MODE2===M_INTVPP || MODE2===M_EXTVPP1 || MODE2===M_EXTVPP2)) || (DMODE===M_WWR && (MODE2===M_EX2_CWEE || MODE2===M_IRE_CWEE)) ||
      (DMODE===M_MSWR && (MODE2===M_EX1_CWEE || MODE2===M_EX2_CWEE || MODE2===M_IRE_CWEE))) && pow_sig===1'b1) DWR_act=1'b1;
  else DWR_act=1'b0; 
  if (IDDIS!==1'b1 && _SCANMODE===1'b0 && (DMODE===M_MRG00 || DMODE===M_MRG01 || DMODE===M_MRG10 ||
      DMODE===M_MRG11 || DMODE===M_MRG12) &&
     (MODE2===M_INTVPP || MODE2===M_EXTVPP1 || MODE2===M_IREFT)) DMRG_act=1'b1;
  else DMRG_act=1'b0;
  if (IDDIS!==1'b1 && _SCANMODE===1'b0 && DMODE===M_IONCHK1 &&
     (MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE || MODE2===M_EXTVPP2 || MODE2===M_EX2_CWEE)) DION_act=1'b1;
  else DION_act=1'b0;
  if (((IDDIS!==1'b1 && _SCANMODE===1'b0 && (DMODE===M_WDT1 || DMODE===M_WDT2) &&
      (MODE2===M_INTVPP || MODE2===M_INT_CWEE || MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE || MODE2===M_EXTVPP2 || MODE2===M_EX2_CWEE)) ||
      (IDDIS!==1'b1 && _SCANMODE===1'b0 && (DMODE===M_WDT3 || DMODE===M_WDT4) &&
      (MODE2===M_INTVPP || MODE2===M_INT_CWEE || MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE))) && pow_sig===1'b1) DWDT_act=1'b1;
  else DWDT_act=1'b0;
  if ((IDDIS!==1'b1 && _SCANMODE===1'b0 && (DMODE===M_RDMRG0 || DMODE===M_RDMRG1) &&
      (MODE2===M_INTVPP || MODE2===M_INT_CWEE || MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE ||
       MODE2===M_IREFT || MODE2===M_IRE_CWEE)) ||
      (IDDIS!==1'b1 && _SCANMODE===1'b0 && DMODE===M_RDMRGC) &&
      (MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE || MODE2===M_EXTVPP2 || MODE2===M_EX2_CWEE)) DRDMRG_act=1'b1;
  else DRDMRG_act=1'b0;

end

//-----RDCLKC1 Func
always @ ( _RDCLKC1 ) begin
  if (_CLKSEL1===1'b1 && pre_RDCLKC1!==1'bx) begin
    QNS_LATCH_CODE;
    if (_RDCLKC1===1'b1) QNS_LATSIG_XZ_CHK;
  end
  else if (_RDCLKC1===1'bx) begin
    XZ_sig = "RDCLKC1";
    QNS_XZ_INPUT_pri;
  end
  else if (_RDCLKC1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'RDCLKC1' signal RESET logic.");
`endif
  end
  pre_RDCLKC1 = _RDCLKC1;
end

//-----DRDCLKC1 Func
always @ ( _DRDCLKC1 ) begin
  if (_DCLKSEL1===1'b1 && pre_DRDCLKC1!==1'bx) begin
    QNS_LATCH_DATA;
    if (_DRDCLKC1===1'b1) QNS_LATSIG_XZ_CHK;
  end
  else if (_DRDCLKC1===1'bx) begin
    XZ_sig = "DRDCLKC1";
    QNS_XZ_INPUT_pri;
  end
  else if (_DRDCLKC1!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
     $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DRDCLKC1' signal RESET logic.");
`endif
  end
  pre_DRDCLKC1 = _DRDCLKC1;
end

//-----RDCLKP1 Func
always @ ( _RDCLKP1 ) begin
  if ((_CLKSEL1===1'b0 || _DCLKSEL1===1'b0) && pre_RDCLKP1!==1'bx) begin
    QNS_LATCH_CODE;
    QNS_LATCH_DATA;
    if (_RDCLKP1===1'b1) QNS_LATSIG_XZ_CHK;
  end
  else if (_RDCLKP1===1'bx) begin
    XZ_sig = "RDCLKP1";
    QNS_XZ_INPUT_pri;
  end
  else if (_RDCLKP1!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'RDCLKP1' signal RESET logic.");
`endif
  end
  pre_RDCLKP1 = _RDCLKP1;
end

//-----FCLK1 Func
always @ ( _FCLK1 ) begin
  if ((EWR_act===1'b1 || BTmode_act===1'b1) && _FCLK1===1'bx) begin
    XZ_sig = "FCLK1";
    QNS_XZ_INPUT_pri;
  end
  else if (_FCLK1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'FCLK1' signal RESET logic.");
`endif
  end
  pre_FCLK1 = _FCLK1;
end

//-----VBRESZ Func
always @ ( _VBRESZ ) begin
  if (_VBRESZ===1'b0) begin
    QNS_LATCH_RESET;
    RESETCHK_act = 0;  // RESET CHECK RESET
  end
  else if (_VBRESZ===1'bx) begin
    XZ_sig = "VBRESZ";
    QNS_XZ_INPUT_pri;
  end
  else if (_VBRESZ===1'b1) begin
    EdgeLCount = 0;   //For Specify
    SUBRDCLK = 1'b0;  //For Specify
    DEdgeLCount = 0;   //For Specify
    DSUBRDCLK = 1'b0;  //For Specify
    Error_flag_DOP = 1'b0;
    if (pre_VBRESZ===1'b0 && _SCANMODE===1'b0) RESETCHK_act = 1'b1;  // RESET CHECK SET
  end
  pre_VBRESZ = _VBRESZ;
end

//-----Triming Code Read 1/2
always @ ( _TRMRD2 ) begin
  TRMRD2L = _TRMRD2;  // For RESET Timing
end

always @ ( TRMRD2L ) begin  // For RESET Timing
  #1;  // For Racing
  if (pre_TRMRD2L===1'b1 && TRMRD2L===1'b0) RESETCHK_act = 0;
  pre_TRMRD2L = TRMRD2L;
end 

//-----POCREL Func
always @ ( _POCREL ) begin
  if (_POCREL===1'bx) begin
    XZ_sig = "POCREL";
    QNS_XZ_INPUT_pri;
  end
  else if (pre_POCREL===1'b0 && _POCREL===1'b1) RESETCHK_act = 1'b1;  // RESET CHECK SET v1.01_add
  pre_POCREL = _POCREL;
end

//-----FLSTOP Func
always @ ( _FLSTOP ) begin
  if ((EWR_act===1'b1 || BTmode_act===1'b1) && _FLSTOP===1'bx) begin
    XZ_sig = "FLSTOP";
    QNS_XZ_INPUT_pri;
  end
  pre_FLSTOP = _FLSTOP;
end

always @ ( _DFLSTOP ) begin
  if ((EWR_act===1'b1 || BTmode_act===1'b1) && _DFLSTOP===1'bx) begin
    XZ_sig = "DFLSTOP";
    QNS_XZ_INPUT_pri;
  end
  else if (_DFLSTOP!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DFLSTOP' signal RESET logic.");
`endif
  end
  pre_DFLSTOP = _DFLSTOP;
end

//-----SRCUT Func
always @ ( _SRCUT ) begin
  if ((EWR_act===1'b1 || BTmode_act===1'b1) && _SRCUT===1'bx) begin
    XZ_sig = "SRCUT";
    QNS_XZ_INPUT_pri;
  end
  else if (_SRCUT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'SRCUT' signal RESET logic.");
`endif
  end
  pre_SRCUT = _SRCUT;
end

//-----HISPEED Func
always @ ( _HISPEED ) begin
  intrdctrl_p1[3] = _HISPEED;
  if ((EWR_act===1'b1 || BTmode_act===1'b1) && _HISPEED===1'bx) begin
    XZ_sig = "HISPEED";
    QNS_XZ_INPUT_pri;
  end
  else if (_HISPEED!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'HISPEED' signal RESET logic.");
`endif
  end
  if (TRMRD1===1'b0 && TRMRD2===1'b0 && EWR_act===1'b1) begin
    if ((_CLKSEL1===1'b1 && _RDCLKC1===1'b0 && MODE===M_READ && intce===1'b1) ||
        (_CLKSEL1===1'b0 && _RDCLKP1===1'b0 && MODE===M_READ && intce===1'b1) ||
        (_DCLKSEL1===1'b1 && _DRDCLKC1===1'b0 && DMODE===M_READ && intdce===1'b1) ||
        (_DCLKSEL1===1'b0 && _RDCLKP1===1'b0 && DMODE===M_READ && intdce===1'b1)) begin
      VIOLATE_sig = "HISPEED";
      QNS_RDCTRL_CHK;
    end
  end
  pre_HISPEED = _HISPEED;
end

//-----LOWPOWER Func
always @ ( _LOWPOWER ) begin
  intrdctrl_p1[2] = _LOWPOWER;
  if ((EWR_act===1'b1 || BTmode_act===1'b1) && _LOWPOWER===1'bx) begin
    XZ_sig = "LOWPOWER";
    QNS_XZ_INPUT_pri;
  end
  else if (_LOWPOWER!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'LOWPOWER' signal RESET logic.");
`endif
  end
  if (TRMRD1===1'b0 && TRMRD2===1'b0 && EWR_act===1'b1) begin
    if ((_CLKSEL1===1'b1 && _RDCLKC1===1'b0 && MODE===M_READ && intce===1'b1) ||
        (_CLKSEL1===1'b0 && _RDCLKP1===1'b0 && MODE===M_READ && intce===1'b1) ||
        (_DCLKSEL1===1'b1 && _DRDCLKC1===1'b0 && DMODE===M_READ && intdce===1'b1) ||
        (_DCLKSEL1===1'b0 && _RDCLKP1===1'b0 && DMODE===M_READ && intdce===1'b1)) begin
      VIOLATE_sig = "LOWPOWER";
      QNS_RDCTRL_CHK;
    end
  end
  pre_LOWPOWER = _LOWPOWER;
end

//-----RLOWSPY Func
always @ ( _RLOWSPY ) begin
  intrdctrl_p1[1] = _RLOWSPY;
  if ((EWR_act===1'b1 || BTmode_act===1'b1) && _RLOWSPY===1'bx) begin
    XZ_sig = "RLOWSPY";
    QNS_XZ_INPUT_pri;
  end
  else if (_RLOWSPY!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'RLOWSPY' signal RESET logic.");
`endif
  end
  if (TRMRD1===1'b0 && TRMRD2===1'b0 && EWR_act===1'b1) begin
    if ((_CLKSEL1===1'b1 && _RDCLKC1===1'b0 && MODE===M_READ && intce===1'b1) ||
        (_CLKSEL1===1'b0 && _RDCLKP1===1'b0 && MODE===M_READ && intce===1'b1) ||
        (_DCLKSEL1===1'b1 && _DRDCLKC1===1'b0 && DMODE===M_READ && intdce===1'b1) ||
        (_DCLKSEL1===1'b0 && _RDCLKP1===1'b0 && DMODE===M_READ && intdce===1'b1)) begin
      VIOLATE_sig = "RLOWSPY";
      QNS_RDCTRL_CHK;
    end
  end
  pre_RLOWSPY = _RLOWSPY;
end

//-----SUB Func
always @ ( _SUB ) begin
  intrdctrl_p1[0] = _SUB;
  if ((EWR_act===1'b1 || BTmode_act===1'b1) && _SUB===1'bx) begin
    XZ_sig = "SUB";
    QNS_XZ_INPUT_pri;
  end
  else if (_SUB!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'SUB' signal RESET logic.");
`endif
  end
  if (TRMRD1===1'b0 && TRMRD2===1'b0 && EWR_act===1'b1) begin
    if ((_CLKSEL1===1'b1 && _RDCLKC1===1'b0 && MODE===M_READ && intce===1'b1) ||
        (_CLKSEL1===1'b0 && _RDCLKP1===1'b0 && MODE===M_READ && intce===1'b1) ||
        (_DCLKSEL1===1'b1 && _DRDCLKC1===1'b0 && DMODE===M_READ && intdce===1'b1) ||
        (_DCLKSEL1===1'b0 && _RDCLKP1===1'b0 && DMODE===M_READ && intdce===1'b1)) begin
      VIOLATE_sig = "SUB";
      QNS_RDCTRL_CHK;
    end
  end
  pre_SUB = _SUB;
end

//-----FIHFL Count
always @ ( _FIHFL ) begin
  if ((EWR_act===1'b1 || BTmode_act===1'b1) && _FIHFL===1'bx) begin
    XZ_sig = "FIHFL";
    QNS_XZ_INPUT_pri;
  end
//  if (FIHFL_cnt===1'bx) FIHFL_cnt=0;
//  else if (_FIHFL===1'b1) begin
//    FIHFLposetime = $time;
//    FIHFL_cnt=FIHFL_cnt + 1;
//    FIHFLcycle = FIHFLposetime - pre_FIHFLposetime;
//  end
//  else if (_FIHFL===1'b0) begin
//    FIHFLnegetime = $time;
//    FIHFLcycle = FIHFLnegetime - pre_FIHFLnegetime;
//  end
//  if (FIHFLposetime > FIHFLnegetime) FIHFLwidth = FIHFLposetime - FIHFLnegetime;
//  else FIHFLwidth = FIHFLnegetime - FIHFLposetime;
//
//  pre_FIHFLposetime = FIHFLposetime;
//  pre_FIHFLnegetime = FIHFLnegetime;
  pre_FIHFL = _FIHFL;
end

//-----DIS-Mode Func
always @ ( IDIS ) begin  // Code-Flash
  if ( IDIS===1'b1 ) begin
    PROGD=1'b0;
    progi_cnt=0;
    EdgeLCount = 0;   //For Specify
    SUBRDCLK = 1'b0;  //For Specify
    if (IDDIS===1'b1) Error_flag_DOP = 1'b0;
  end
  pre_IDIS=IDIS;
end

always @ ( IDDIS ) begin  // Data-Flash
  if ( IDDIS===1'b1 ) begin
    DEdgeLCount = 0;   //For Specify
    DSUBRDCLK = 1'b0;  //For Specify
    if (IDIS===1'b1) Error_flag_DOP = 1'b0;
  end
  pre_IDDIS=IDDIS;
end

//-----SCAN & BT Control
always @ ( _SCANMODE ) begin
  if (_SCANMODE===1'bx) begin
    XZ_sig = "SCANMODE";
    QNS_XZ_INPUT_pri;
  end
  else if (_SCANMODE!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'SCANMODE' signal RESET logic.");
`endif
  end
  pre_SCANMODE = _SCANMODE;
end

always @ ( _TESDBT ) begin
  if (_TESDBT===1'bx) begin
    XZ_sig = "TESDBT";
    QNS_XZ_INPUT_pri;
  end
  else if (_TESDBT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'TESDBT' signal RESET logic.");
`endif
  end
  pre_TESDBT = _TESDBT;
end

//-----Mode Signal Check
always @ (_DIS) begin : QNS_DIS_XZ_CHK
  if (_DIS===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DIS";
    QNS_XZ_INPUT_pri;
  end
  else if (_DIS!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DIS' signal RESET logic.");
`endif
  end
end

always @ (_DDIS) begin : QNS_DDIS_XZ_CHK
  if (_DDIS===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DDIS";
    QNS_XZ_INPUT_pri;
  end
  else if (_DDIS!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DDIS' signal RESET logic.");
`endif
  end
end

always @ (_WWR) begin : QNS_WWR_XZ_CHK
  if (_WWR===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "WWR";
    QNS_XZ_INPUT_pri;
  end
  else if (_WWR!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'WWR' signal RESET logic.");
`endif
  end
end

always @ (_DWWR) begin : QNS_DWWR_XZ_CHK
  if (_DWWR===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DWWR";
    QNS_XZ_INPUT_pri;
  end
  else if (_DWWR!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DWWR' signal RESET logic.");
`endif
  end
end

always @ (_MSWR) begin : QNS_MSWR_XZ_CHK
  if (_MSWR===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MSWR";
    QNS_XZ_INPUT_pri;
  end
  else if (_MSWR!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'MSWR' signal RESET logic.");
`endif
  end
end

always @ (_SER) begin : QNS_SER_XZ_CHK
  if (_SER===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "SER";
    QNS_XZ_INPUT_pri;
  end
  else if (_SER!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'SER' signal RESET logic.");
`endif
  end
end

always @ (_DSER) begin : QNS_DSER_XZ_CHK
  if (_DSER===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DSER";
    QNS_XZ_INPUT_pri;
  end
  else if (_DSER!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DSER' signal RESET logic.");
`endif
  end
end

always @ (_CER) begin : QNS_CER_XZ_CHK
  if (_CER===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "CER";
    QNS_XZ_INPUT_pri;
  end
  else if (_CER!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'CER' signal RESET logic.");
`endif
  end
end

always @ (_DCER) begin : QNS_DCER_XZ_CHK
  if (_DCER===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DCER";
    QNS_XZ_INPUT_pri;
  end
  else if (_DCER!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DCER' signal RESET logic.");
`endif
  end
end

always @ (_EXER) begin : QNS_EXER_XZ_CHK
  if (_EXER===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "EXER";
    QNS_XZ_INPUT_pri;
  end
  else if (_EXER!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'EXER' signal RESET logic.");
`endif
  end
end

always @ (_MRG00) begin : QNS_MRG00_XZ_CHK
  if (_MRG00===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MRG00";
    QNS_XZ_INPUT_pri;
  end
  else if (_MRG00!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'MRG00' signal RESET logic.");
`endif
  end
end

always @ (_DMRG00) begin : QNS_DMRG00_XZ_CHK
  if (_DMRG00===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DMRG00";
    QNS_XZ_INPUT_pri;
  end
  else if (_DMRG00!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DMRG00' signal RESET logic.");
`endif
  end
end

always @ (_MRG01) begin : QNS_MRG01_XZ_CHK
  if (_MRG01===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MRG01";
    QNS_XZ_INPUT_pri;
  end
  else if (_MRG01!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'MRG01' signal RESET logic.");
`endif
  end
end

always @ (_DMRG01) begin : QNS_DMRG01_XZ_CHK
  if (_DMRG01===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DMRG01";
    QNS_XZ_INPUT_pri;
  end
  else if (_DMRG01!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DMRG01' signal RESET logic.");
`endif
  end
end

always @ (_MRG10) begin : QNS_MRG10_XZ_CHK
  if (_MRG10===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MRG10";
    QNS_XZ_INPUT_pri;
  end
  else if (_MRG10!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'MRG10' signal RESET logic.");
`endif
  end
end

always @ (_DMRG10) begin : QNS_DMRG10_XZ_CHK
  if (_DMRG10===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DMRG10";
    QNS_XZ_INPUT_pri;
  end
  else if (_DMRG10!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DMRG10' signal RESET logic.");
`endif
  end
end

always @ (_MRG11) begin : QNS_MRG11_XZ_CHK
  if (_MRG11===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MRG11";
    QNS_XZ_INPUT_pri;
  end
  else if (_MRG11!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'MRG11' signal RESET logic.");
`endif
  end
end

always @ (_DMRG11) begin : QNS_DMRG11_XZ_CHK
  if (_DMRG11===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DMRG11";
    QNS_XZ_INPUT_pri;
  end
  else if (_DMRG11!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DMRG11' signal RESET logic.");
`endif
  end
end

always @ (_MRG12) begin : QNS_MRG12_XZ_CHK
  if (_MRG12===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MRG12";
    QNS_XZ_INPUT_pri;
  end
  else if (_MRG12!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'MRG12' signal RESET logic.");
`endif
  end
end

always @ (_DMRG12) begin : QNS_DMRG12_XZ_CHK
  if (_DMRG12===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DMRG12";
    QNS_XZ_INPUT_pri;
  end
  else if (_DMRG12!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DMRG12' signal RESET logic.");
`endif
  end
end

always @ (_READ) begin : QNS_READ_XZ_CHK
  if (_READ===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "READ";
    QNS_XZ_INPUT_pri;
  end
  else if (_READ!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'READ' signal RESET logic.");
`endif
  end
end

always @ (_DREAD) begin : QNS_DREAD_XZ_CHK
  if (_DREAD===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DREAD";
    QNS_XZ_INPUT_pri;
  end
  else if (_DREAD!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DREAD' signal RESET logic.");
`endif
  end
end

always @ (_IONCHK1) begin : QNS_IONCHK1_XZ_CHK
  if (_IONCHK1===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "IONCHK1";
    QNS_XZ_INPUT_pri;
  end
  else if (_IONCHK1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'IONCHK1' signal RESET logic.");
`endif
  end
end

always @ (_CPBT) begin : QNS_CPBT_XZ_CHK
  if (_CPBT===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "CPBT";
    QNS_XZ_INPUT_pri;
  end
  else if (_CPBT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'CPBT' signal RESET logic.");
`endif
  end
end

always @ (_WDT1) begin : QNS_WDT1_XZ_CHK
  if (_WDT1===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "WDT1";
    QNS_XZ_INPUT_pri;
  end
  else if (_WDT1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'WDT1' signal RESET logic.");
`endif
  end
end

always @ (_WDT2) begin : QNS_WDT2_XZ_CHK
  if (_WDT2===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "WDT2";
    QNS_XZ_INPUT_pri;
  end
  else if (_WDT2!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'WDT2' signal RESET logic.");
`endif
  end
end

always @ (_WDT3) begin : QNS_WDT3_XZ_CHK
  if (_WDT3===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "WDT3";
    QNS_XZ_INPUT_pri;
  end
  else if (_WDT3!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'WDT3' signal RESET logic.");
`endif
  end
end

always @ (_WDT4) begin : QNS_WDT4_XZ_CHK
  if (_WDT4===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "WDT4";
    QNS_XZ_INPUT_pri;
  end
  else if (_WDT4!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'WDT4' signal RESET logic.");
`endif
  end
end

always @ (_RDT) begin : QNS_RDT_XZ_CHK
  if (_RDT===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RDT";
    QNS_XZ_INPUT_pri;
  end
  else if (_RDT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'RDT' signal RESET logic.");
`endif
  end
end

always @ (_RDMRG0) begin : QNS_RDMRG0_XZ_CHK
  if (_RDMRG0===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RDMRG0";
    QNS_XZ_INPUT_pri;
  end
  else if (_RDMRG0!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'RDMRG0' signal RESET logic.");
`endif
  end
end

always @ (_RDMRG1) begin : QNS_RDMRG1_XZ_CHK
  if (_RDMRG1===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RDMRG1";
    QNS_XZ_INPUT_pri;
  end
  else if (_RDMRG1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'RDMRG1' signal RESET logic.");
`endif
  end
end

always @ (_RDMRGC) begin : QNS_RDMRGC_XZ_CHK
  if (_RDMRGC===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RDMRGC";
    QNS_XZ_INPUT_pri;
  end
  else if (_RDMRGC!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'RDMRGC' signal RESET logic.");
`endif
  end
end

always @ (_STCHK) begin : QNS_STCHK_XZ_CHK
  if (_STCHK===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "STCHK";
    QNS_XZ_INPUT_pri;
  end
  else if (_STCHK!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'STCHK' signal RESET logic.");
`endif
  end
end

always @ (_EXTVPP1) begin : QNS_EXTVPP1_XZ_CHK
  if (_EXTVPP1===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "EXTVPP1";
    QNS_XZ_INPUT_pri;
  end
  else if (_EXTVPP1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'EXTVPP1' signal RESET logic.");
`endif
  end
end

always @ (_EXTVPP2) begin : QNS_EXTVPP2_XZ_CHK
  if (_EXTVPP2===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "EXTVPP2";
    QNS_XZ_INPUT_pri;
  end
  else if (_EXTVPP2!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'EXTVPP2' signal RESET logic.");
`endif
  end
end

always @ (_CPT) begin : QNS_CPT_XZ_CHK
  if (_CPT===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "CPT";
    QNS_XZ_INPUT_pri;
  end
  else if (_CPT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'CPT' signal RESET logic.");
`endif
  end
end

always @ (_IREFT) begin : QNS_IREFT_XZ_CHK
  if (_IREFT===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "IREFT";
    QNS_XZ_INPUT_pri;
  end
  else if (_IREFT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'IREFT' signal RESET logic.");
`endif
  end
end

always @ (_CWEE) begin : QNS_CWEE_XZ_CHK
  if (_CWEE===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "CWEE";
    QNS_XZ_INPUT_pri;
  end
  else if (_CWEE!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'CWEE' signal RESET logic.");
`endif
  end
  else if (_CWEE!==pre_CWEE && EWR_act===1'b1 && ($time > 0) && _TRMRD1===1'b0 && _TRMRD2===1'b0 &&
           (IDIS!==1'b1 || IDDIS!==1'b1)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'CWEE' signal.");
`endif
  end
  pre_CWEE = _CWEE;
end

//-----Other Signal Check
always @ ( _CE ) begin
  if (_CE!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'CE' signal RESET logic.");
`endif 
  end
end 

always @ ( _DCE ) begin
  if (_DCE!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DCE' signal RESET logic.");
`endif
  end
end

always @ ( _CLKSEL1 ) begin
  if (_CLKSEL1===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "CLKSEL1";
    QNS_XZ_INPUT_pri;
  end
  else if (_CLKSEL1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'CLKSEL1' signal RESET logic.");
`endif
  end
end

always @ ( _DCLKSEL1 ) begin
  if (_DCLKSEL1===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DCLKSEL1";
    QNS_XZ_INPUT_pri;
  end
  else if (_DCLKSEL1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DCLKSEL1' signal RESET logic.");
`endif
  end
end

always @ ( _WED ) begin
  if (_WED===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "WED";
    QNS_XZ_INPUT_pri;
  end
  else if (_WED!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
     $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'WED' signal RESET logic.");
`endif
  end
end

always @ ( _DWED ) begin
  if (_DWED===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DWED";
    QNS_XZ_INPUT_pri;
  end
  else if (_DWED!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
     $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'DWED' signal RESET logic.");
`endif
  end
end

always @ ( _MEOR ) begin
  if (_MEOR===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MEOR";
    QNS_XZ_INPUT_pri;
  end
  else if (_MEOR!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'MEOR' signal RESET logic.");
`endif
  end
end

always @ ( _MEOC ) begin
  if (_MEOC===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MEOC";
    QNS_XZ_INPUT_pri; 
  end
  else if (_MEOC!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'MEOC' signal RESET logic.");
`endif
  end
end

always @ ( _PROGI ) begin
  if (_PROGI===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "PROGI";
    QNS_XZ_INPUT_pri; 
  end
  else if (_PROGI!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'PROGI' signal RESET logic.");
`endif
  end
  else if (EWR_act===1'b1 && BTmode_act!==1'b1) begin
    if (progi_cnt===1'bx) progi_cnt=0;
    #0;  // For Racing
    if (|({WR_act,WDT_act})===1'b1) begin  // For CODE
      casez ({pre_PROGI,_PROGI})
        2'b01 : begin
          progi_cnt = progi_cnt + 1;
          PROGD = 0;
        end
        2'b10 : begin
          progi_cnt = progi_cnt + 1;
          if (progi_cnt===2 && PROGD===1'b0) PROGD = 1'b1;
        end
        default : begin
          progi_cnt = 0;
        end
      endcase
    end
  end
  pre_PROGI=_PROGI;
end

always @ ( _POCREL5V ) begin
  if (_POCREL5V===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "POCREL5V";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _LOWSPY ) begin
  if (_LOWSPY===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "LOWSPY";
    QNS_XZ_INPUT_pri;
  end
  else if (_LOWSPY!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'LOWSPY' signal RESET logic.");
`endif
  end
end

always @ ( _OSCOUTEN ) begin
  if (_OSCOUTEN===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "OSCOUTEN";
    QNS_XZ_INPUT_pri;
  end
  else if (_OSCOUTEN!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'OSCOUTEN' signal RESET logic.");
`endif
  end
end

always @ ( _OSCNOSTP ) begin
  if (_OSCNOSTP===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "OSCNOSTP";
    QNS_XZ_INPUT_pri;
  end
  else if (_OSCNOSTP!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSC_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input 'OSCNOSTP' signal RESET logic.");
`endif
  end
end

always @ ( _VREG ) begin
  if (_VREG===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "VREG";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _VCPRGWE ) begin
  if (_VCPRGWE===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "VCPRGWE";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP17 ) begin
  if ( _TRMCP17===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP17";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP16 ) begin
  if ( _TRMCP16===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP16";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP15 ) begin
  if ( _TRMCP15===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP15";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP9 ) begin
  if ( _TRMCP9===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP9";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP8 ) begin
  if ( _TRMCP8===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP8";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP7 ) begin
  if ( _TRMCP7===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP7";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP6 ) begin
  if ( _TRMCP6===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP6";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP5 ) begin
  if ( _TRMCP5===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP5";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP4 ) begin
  if ( _TRMCP4===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP4";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP3 ) begin
  if ( _TRMCP3===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP3";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP2 ) begin
  if ( _TRMCP2===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP2";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP1 ) begin
  if ( _TRMCP1===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP1";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _TRMCP0 ) begin
  if ( _TRMCP0===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "TRMCP0";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _RTRMCP20 ) begin
  if ( _RTRMCP20===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RTRMCP20";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _RTRMCP19 ) begin
  if ( _RTRMCP19===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RTRMCP19";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _RTRMCP18 ) begin
  if ( _RTRMCP18===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RTRMCP18";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _RTRMCP17 ) begin
  if ( _RTRMCP17===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RTRMCP17";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _RTRMCP16 ) begin
  if ( _RTRMCP16===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RTRMCP16";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _RTRMCP15 ) begin
  if ( _RTRMCP15===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RTRMCP15";
    QNS_XZ_INPUT_pri;
  end
end

// v1.01_add
always @ ( _RESB ) begin
  if (_RESB===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RESB";
    QNS_XZ_INPUT_pri;
  end
end

//-----OSCOUT Func
always @ ( OSCOUT_act) begin : OSCOUT_Fout
  if (EWR_act===1'b1) begin  // v1.01_modify
    while (OSCOUT_act===1'b1) begin
      casez (TRMCP9_0[6:4])
        3'b101 : #(OSCF_101 /2) tmp_OSCOUT = ~tmp_OSCOUT;
        3'b110 : #(OSCF_110 /2) tmp_OSCOUT = ~tmp_OSCOUT;
        3'b111 : #(OSCF_111 /2) tmp_OSCOUT = ~tmp_OSCOUT;
        3'b000 : #(OSCF_000 /2) tmp_OSCOUT = ~tmp_OSCOUT;
        3'b001 : #(OSCF_001 /2) tmp_OSCOUT = ~tmp_OSCOUT;
        3'b010 : #(OSCF_010 /2) tmp_OSCOUT = ~tmp_OSCOUT;
        3'b011 : #(OSCF_011 /2) tmp_OSCOUT = ~tmp_OSCOUT;
        3'b100 : #(OSCF_100 /2) tmp_OSCOUT = ~tmp_OSCOUT;
        default : tmp_OSCOUT = 1'b0;  // Init
      endcase
    end
  end
end

always @ ( OSCOUT_act ) begin
  if (OSCOUT_act===1'bx) tmp_OSCOUT=1'b0;
  else if (OSCOUT_act===1'b0) begin
    disable OSCOUT_Fout;
    tmp_OSCOUT=1'b0;
  end
end

/*-----VPPTS Input Check-----*/
always @ ( ts1_incnt ) begin  // VPPTS1 Check
`ifdef QNSC_ALL_NO_CHECK
// NO Check
`else
  #1;  // SetupWaitTime
  if (ts1_incnt===1'b1 && _VPPTS1!==1'b1 && ($time > 0) && TRMRD1===1'b0 && TRMRD2===1'b0) begin
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : It is necessary to control VPPTS1 by the test mode.");
  end
`endif
end

/*-----RESET Logic Check-----*/
always @ (posedge _TRMRD1 or posedge _TRMRD2) begin  // v1.02_modify
`ifdef QNSC_ALL_NO_CHECK
// NO Check
`else
  RESET_st = {_WWR,_MSWR,_CER,_SER,_EXER,_MRG00,_MRG01,_MRG10,_MRG11,_MRG12,
               _DIS,_READ,_IONCHK1,_STCHK,_CPBT,_WDT1,_WDT2,_WDT3,_WDT4,_RDT,
               _RDMRG0,_RDMRG1,_RDMRGC,_EXTVPP1,_EXTVPP2,_CPT,_IREFT,_MEOR,
               _MEOC,_DWWR,_DCER,_DSER,_DMRG00,_DMRG01,_DMRG10,_DMRG11,_DMRG12,
               _DDIS,_DREAD,_DFLSTOP,_DRDCLKC1,_DCLKSEL1,_DCE,_DWED,_RDCLKC1,_RDCLKP1,
               _CLKSEL1,_CE,_CWEE,_SUB,_LOWPOWER,_HISPEED,_RLOWSPY,_LOWSPY,
               _SRCUT,_FCLK1,_PROGI,_WED,_OSCOUTEN,_OSCNOSTP,_SCANMODE,_TESDBT};
  if (RESET_st!==RESET_chk && ((_VBRESZ===1'b1 && _SCANMODE===1'b0) || (_VBRESZ===1'b1 && _TRMRD1===1'b1) || _TRMRD2===1'b1) && ($time > 0)) begin
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of input signal RESET logic.");
  end
  else if ((|{_FLSTOP, _VBRESZ, _POCREL,_TRMCP17, _TRMCP16, _TRMCP15,
              _TRMCP9, _TRMCP8, _TRMCP7, _TRMCP6, _TRMCP5, _TRMCP4, _TRMCP3, _TRMCP2, _TRMCP1, _TRMCP0,
              _RTRMCP20, _RTRMCP19, _RTRMCP18, _RTRMCP17, _RTRMCP16, _RTRMCP15, _POCREL5V, _FIHFL}===1'bx) &&
          ((_VBRESZ===1'b1 && _SCANMODE===1'b0) || (_VBRESZ===1'b1 && _TRMRD1===1'b1) || _TRMRD2===1'b1) && ($time > 0)) begin
    $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of XZ input signal.");
  end
`endif
end

/*-----Dual Operation Check-----*/
always @ (IDIS or _WWR or _MSWR or _SER or _CER or _EXER or
          _MRG00 or _MRG01 or _MRG10 or _MRG11 or _MRG12 or _READ or _IONCHK1 or
          _CPBT or _WDT1 or _WDT2 or _WDT3 or _WDT4 or _RDT or
          _RDMRG0 or _RDMRG1 or _RDMRGC or _STCHK or
          IDDIS or _DWWR or _DSER or _DCER or _DREAD or
          _DMRG00 or _DMRG01 or _DMRG10 or _DMRG11 or _DMRG12 or
          _EXTVPP1 or _EXTVPP2 or _CPT or _IREFT or _CWEE or
          _HISPEED or _LOWPOWER or _RLOWSPY or _SUB or _OSCNOSTP or
          intdce or _OSCOUTEN or _LOWSPY) begin
  #0;
//For CODE
  if (IDIS===1'b1) MODE_dop = M_DIS;
  else if (|{M_MRG00===MODE,M_MRG01===MODE,M_MRG10===MODE,M_MRG11===MODE,M_MRG12===MODE,
             M_M01M11===MODE,M_M01M12===MODE}===1'b1) MODE_dop = M_MRG;
  else if (|{M_WDT1===MODE,M_WDT2===MODE,M_WDT3===MODE,M_WDT4===MODE}==='b1) MODE_dop = M_WDT;
  else if (|{M_RDMRG0===MODE,M_RDMRG1===MODE}===1'b1) MODE_dop = M_RDMRG01;
  else MODE_dop = MODE;
//For DATA
  if (IDDIS===1'b1) DMODE_dop = M_DIS;
  else if (|{M_MRG00===DMODE,M_MRG01===DMODE,M_MRG10===DMODE,M_MRG11===DMODE,M_MRG12===DMODE,
             M_M01M11===DMODE,M_M01M12===DMODE}===1'b1) DMODE_dop = M_MRG;
  else if (|{M_WDT1===DMODE,M_WDT2===DMODE,M_WDT3===DMODE,M_WDT4===DMODE}==='b1) DMODE_dop = M_WDT;
  else if (|{M_RDMRG0===DMODE,M_RDMRG1===DMODE}===1'b1) DMODE_dop = M_RDMRG01;
//  else if (M_READ===DMODE && intdce===1'b0) DMODE_dop = M_STOP; // del v1.05
//  else if (M_READ===DMODE && intdce===1'b1) DMODE_dop = M_ERR;  // add v1.04// del v1.05
  else DMODE_dop = DMODE;

  if (EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0 && _CLKSEL1===1'b1) QNS_DUAL_OP_MODE_CHECK (inthispeed,intlowpower,intrlowspy,intsub);
  else if (EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0 && _CLKSEL1!==1'b1)  QNS_DUAL_OP_MODE_CHECK (_HISPEED,_LOWPOWER,_RLOWSPY,_SUB);

end

/*-----TASK Family-----*/
//-----Signal Latch
task QNS_LATCH_CODE;
  begin
    //### For CODE-FLASH
    // PREV
    if (_RDCLKC1===1'b1 || _RDCLKP1===1'b1) begin
      prevCE=intce;
    end
    if (_CLKSEL1===1'b1 && _RDCLKC1!==1'bx) begin
      prevHISPEED=inthispeed;
      prevLOWPOWER=intlowpower;
      prevRLOWSPY=intrlowspy;
      prevSUB=intsub;
      prevRDCTRL_C1=intrdctrl_c1;
    end
    // NOW
    if (_RDCLKC1===1'b1 || _RDCLKP1===1'b1) begin
      intce=_CE;
    end
    if (_CLKSEL1===1'b1 && _RDCLKC1!==1'bx) begin
      inthispeed=_HISPEED;
      intlowpower=_LOWPOWER;
      intrlowspy=_RLOWSPY;
      intsub=_SUB;
      intrdctrl_c1={_HISPEED,_LOWPOWER,_RLOWSPY,_SUB};
    end
  end
endtask

task QNS_LATCH_DATA;
  begin
    //### For DATA-FLASH
    if (_DRDCLKC1===1'b1 || _RDCLKP1===1'b1) begin
    // PREV
      prevDCE=intdce;
    // NOW
      intdce=_DCE;
    end
  end
endtask

//-----Signal LatchReset
task QNS_LATCH_RESET;
  begin
    prevHISPEED=0;
    prevLOWPOWER=0;
    prevRLOWSPY=0;
    prevSUB=0;
    prevRDCTRL_C1=0;
    prevRDCTRL_P1=0;
    prevCE=0;
    prevDCE=0;

    inthispeed=0;
    intlowpower=0;
    intrlowspy=0;
    intsub=0;
    intrdctrl_c1=0;
    intrdctrl_p1=0;
    intce=0;
    intdce=0;
  end
endtask

//-----HISPEED/LOWPOWER/RLOWSPY/SUB Check
task QNS_RDCTRL_CHK;
  begin
`ifdef QNSC_ALL_NO_CHECK
// NO Check
`else
    if ( $time > 0 ) $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : The change in the  %0s signal should be 'RDCLK=H'.",VIOLATE_sig);
`endif
  end
endtask

//-----XZ Input Check
task QNS_XZ_INPUT_pri;
  begin
`ifdef QNSC_ALL_NO_CHECK
// NO Check
`else
    if ($time > 0) begin
      $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : Violation of XZ input %0s signal.",XZ_sig);
      // Error_flag_XZ=1'b1;  // CP-Macro NO-flag
    end
`endif
  end
endtask

task QNS_LATSIG_XZ_CHK;
  integer aa,bb,cc,dd,ee,ff;
  begin
    if (intce===1'bx) begin : CE_XZchk
      XZ_sig = "CE";
      QNS_XZ_INPUT_pri;
    end
    if (intdce===1'bx) begin : DCE_XZchk
      XZ_sig = "DCE";
      QNS_XZ_INPUT_pri;
    end
  end
endtask

//-----Dual Operation Check
task QNS_DUAL_OP_MODE_CHECK;
  input hispeed_dp,lowpower_dp,rlowspy_dp,sub_dp;
  begin
    casez ({IDIS,MODE_dop[21:0],  IDDIS,DMODE_dop[21:0],  MODE2,  hispeed_dp,lowpower_dp,rlowspy_dp,sub_dp,_LOWSPY,_OSCOUTEN,_OSCNOSTP})
//      {M_WWR,M_STOP,12'b00001_???0?00}, // del v1.05
      {M_WWR,M_DIS,12'b00001_???0?00},
      {M_WWR,M_DIS,12'b10001_???0?00},
      {M_WWR,M_DIS,12'b00011_???0?00},
      {M_WWR,M_DIS,12'b??101_???0???},
      {M_MSWR,M_MSWR,12'b1000?_???0?00},
      {M_MSWR,M_DIS,12'b00001_???0?00},
      {M_MSWR,M_DIS,12'b10001_???0?00},
      {M_MSWR,M_DIS,12'b00011_???0?00},
      {M_MSWR,M_DIS,12'b??101_???0???},
//      {M_SER,M_STOP,12'b0000?_???0?00}, // del v1.05
      {M_SER,M_DIS,12'b00001_???0?00},
      {M_SER,M_DIS,12'b10001_???0?00},
      {M_SER,M_DIS,12'b00011_???0?00},
      {M_SER,M_DIS,12'b?0101_???0???},
//      {M_CER,M_STOP,12'b0000?_???0?00}, // del v1.05
      {M_CER,M_DIS,12'b00001_???0?00},
      {M_CER,M_DIS,12'b10001_???0?00},
      {M_CER,M_DIS,12'b00011_???0?00},
      {M_CER,M_DIS,12'b?0101_???0???},
      {M_EXER,M_EXER,12'b1000?_???0?00},
//      {M_EXER,M_STOP,12'b0000?_???0?00}, // del v1.05
      {M_EXER,M_DIS,12'b00001_???0?00},
      {M_EXER,M_DIS,12'b10001_???0?00},
      {M_EXER,M_DIS,12'b00011_???0?00},
      {M_EXER,M_DIS,12'b?0101_???0???},
//      {M_MRG,M_STOP,12'b00001_???0?00}, // del v1.05
      {M_MRG,M_DIS,12'b00001_???0?00},
      {M_MRG,M_DIS,12'b10001_???0?00},
      {M_MRG,M_DIS,12'b00011_???0?00},
      {M_MRG,M_DIS,12'b00101_???0?00},
      {M_READ,M_WWR,12'b00000_1000?00},
      {M_READ,M_SER,12'b00000_1000?00},
      {M_READ,M_CER,12'b00000_1000?00},
      {M_READ,M_MRG,12'b00000_1000?00},
      {M_READ,M_READ,12'b0000?_1000?00},
      {M_READ,M_DIS,12'b00000_1000?00},
      {M_READ,M_DIS,12'b00001_1000?00},
      {M_READ,M_DIS,12'b1000?_1000?00},
      {M_READ,M_DIS,12'b0001?_1000?00},
      {M_READ,M_DIS,12'b0010?_1000?00},
      {M_READ,M_STOP,12'b00000_1000?00},
      {M_READ,M_WWR,12'b00000_0100100},
      {M_READ,M_SER,12'b00000_0100100},
      {M_READ,M_CER,12'b00000_0100100},
      {M_READ,M_MRG,12'b00000_0100100},
      {M_READ,M_READ,12'b0000?_0100?00},  // v1.06_Modify
      {M_READ,M_DIS,12'b0000?_0100100},
      {M_READ,M_DIS,12'b1000?_0100100},
      {M_READ,M_DIS,12'b0001?_0100100},
      {M_READ,M_DIS,12'b0010?_0100100},
      {M_READ,M_STOP,12'b00000_0100?00},  // v1.06_Modify
      {M_READ,M_WWR,12'b00000_0010?00},
      {M_READ,M_SER,12'b00000_0010?00},
      {M_READ,M_CER,12'b00000_0010?00},
      {M_READ,M_MRG,12'b00000_0010?00},
      {M_READ,M_READ,12'b0000?_0010?00},
      {M_READ,M_DIS,12'b0000?_0010?00},
      {M_READ,M_DIS,12'b1000?_0010?00},
      {M_READ,M_DIS,12'b0001?_0010?00},
      {M_READ,M_DIS,12'b0010?_0010?00},
      {M_READ,M_STOP,12'b00000_0010?00},
      {M_READ,M_WWR,12'b00000_0000?00},
      {M_READ,M_SER,12'b00000_0000?00},
      {M_READ,M_CER,12'b00000_0000?00},
      {M_READ,M_MRG,12'b00000_0000?00},
      {M_READ,M_READ,12'b0000?_0000?00},
      {M_READ,M_DIS,12'b0000?_0000?00},
      {M_READ,M_DIS,12'b1000?_0000?00},
      {M_READ,M_DIS,12'b0001?_0000?00},
      {M_READ,M_DIS,12'b0010?_0000?00},
      {M_READ,M_STOP,12'b00000_0000?00},
      {M_READ,M_READ,12'b0000?_???1?00},
      {M_READ,M_DIS,12'b0000?_???1?00},
      {M_READ,M_DIS,12'b1000?_???1?00},
      {M_READ,M_DIS,12'b0001?_???1?00},
      {M_READ,M_DIS,12'b0010?_???1?00},
      {M_READ,M_STOP,12'b00000_???1?00},
      {M_IONCHK1,M_DIS,12'b1000?_???0000},
      {M_IONCHK1,M_DIS,12'b0010?_???0000},
      {M_CPBT,M_CPBT,12'b00001_???0?00},
      {M_CPBT,M_DIS,12'b00001_???0?00},
      {M_CPBT,M_DIS,12'b00101_???0??0},
      {M_WDT,M_WDT,12'b00001_???0?00},
      {M_WDT,M_WDT,12'b10001_???0?00},
      {M_WDT,M_DIS,12'b00001_???0?00},
      {M_WDT,M_DIS,12'b10001_???0?00},
      {M_WDT,M_DIS,12'b??101_???0?0?},
      {M_RDT,M_RDT,12'b10001_???0000},
      {M_RDT,M_DIS,12'b10001_???0000},
      {M_RDT,M_DIS,12'b00101_???0000},
      {M_STCHK,M_STCHK,12'b1000?_???0000},
      {M_STCHK,M_DIS,12'b0000?_???0000},
      {M_STCHK,M_DIS,12'b1000?_???0000},
      {M_STCHK,M_DIS,12'b0010?_???0000},
      {M_RDMRG01,M_DIS,12'b0000?_1000000},
      {M_RDMRG01,M_DIS,12'b0001?_1000000},
      {M_RDMRG01,M_DIS,12'b0010?_1000000},
      {M_RDMRG01,M_DIS,12'b0000?_0100000},
      {M_RDMRG01,M_DIS,12'b0001?_0100000},
      {M_RDMRG01,M_DIS,12'b0010?_0100000},
      {M_RDMRG01,M_DIS,12'b0000?_0010000},
      {M_RDMRG01,M_DIS,12'b0001?_0010000},
      {M_RDMRG01,M_DIS,12'b0010?_0010000},
      {M_RDMRG01,M_DIS,12'b0000?_0000000},
      {M_RDMRG01,M_DIS,12'b0001?_0000000},
      {M_RDMRG01,M_DIS,12'b0010?_0000000},
      {M_RDMRG01,M_DIS,12'b0000?_???1000},
      {M_RDMRG01,M_DIS,12'b0001?_???1000},
      {M_RDMRG01,M_DIS,12'b0010?_???1000},
      {M_RDMRGC,M_DIS,12'b1000?_1000000},
      {M_RDMRGC,M_DIS,12'b0010?_1000000},
      {M_RDMRGC,M_DIS,12'b1000?_0100000},
      {M_RDMRGC,M_DIS,12'b0010?_0100000},
      {M_RDMRGC,M_DIS,12'b1000?_0010000},
      {M_RDMRGC,M_DIS,12'b0010?_0010000},
      {M_RDMRGC,M_DIS,12'b1000?_0000000},
      {M_RDMRGC,M_DIS,12'b0010?_0000000},
      {M_RDMRGC,M_DIS,12'b1000?_???1000},
      {M_RDMRGC,M_DIS,12'b0010?_???1000},
      {M_DIS,M_WWR,12'b00000_???0?00},
      {M_DIS,M_WWR,12'b10000_???0?00},
      {M_DIS,M_WWR,12'b00010_???0?00},
      {M_DIS,M_MSWR,12'b00000_???0?00},
      {M_DIS,M_MSWR,12'b10000_???0?00},
      {M_DIS,M_MSWR,12'b00010_???0?00},
      {M_DIS,M_SER,12'b00000_???0?00},
      {M_DIS,M_SER,12'b10000_???0?00},
      {M_DIS,M_SER,12'b00010_???0?00},
      {M_DIS,M_CER,12'b00000_???0?00},
      {M_DIS,M_CER,12'b10000_???0?00},
      {M_DIS,M_CER,12'b00010_???0?00},
      {M_DIS,M_EXER,12'b00000_???0?00},
      {M_DIS,M_EXER,12'b10000_???0?00},
      {M_DIS,M_EXER,12'b00010_???0?00},
      {M_DIS,M_MRG,12'b00000_???0?00},
      {M_DIS,M_MRG,12'b10000_???0?00},
      {M_DIS,M_MRG,12'b00010_???0?00},
      {M_DIS,M_READ,12'b0000?_1000?00},
      {M_DIS,M_READ,12'b1000?_1000?00},
      {M_DIS,M_READ,12'b0001?_1000?00},
      {M_DIS,M_READ,12'b0000?_0100100},
      {M_DIS,M_READ,12'b1000?_0100100},
      {M_DIS,M_READ,12'b0001?_0100100},
      {M_DIS,M_READ,12'b0000?_0010?00},
      {M_DIS,M_READ,12'b1000?_0010?00},
      {M_DIS,M_READ,12'b0001?_0010?00},
      {M_DIS,M_READ,12'b0000?_0000?00},
      {M_DIS,M_READ,12'b1000?_0000?00},
      {M_DIS,M_READ,12'b0001?_0000?00},
      {M_DIS,M_READ,12'b0000?_???1?00},
      {M_DIS,M_READ,12'b1000?_???1?00},
      {M_DIS,M_READ,12'b0001?_???1?00},
      {M_DIS,M_IONCHK1,12'b1000?_???0000},
      {M_DIS,M_WDT,12'b00000_???0?00},
      {M_DIS,M_WDT,12'b10000_???0?00},
      {M_DIS,M_RDT,12'b10000_???0000},
      {M_DIS,M_STCHK,12'b0000?_???0000},
      {M_DIS,M_STCHK,12'b1000?_???0000},
      {M_DIS,M_RDMRG01,12'b00000_1000000},
      {M_DIS,M_RDMRG01,12'b00001_1000000},
      {M_DIS,M_RDMRG01,12'b0001?_1000000},
      {M_DIS,M_RDMRG01,12'b0000?_0100000},
      {M_DIS,M_RDMRG01,12'b0001?_0100000},
      {M_DIS,M_RDMRG01,12'b00000_0010000},
      {M_DIS,M_RDMRG01,12'b00001_0010000},
      {M_DIS,M_RDMRG01,12'b0001?_0010000},
      {M_DIS,M_RDMRG01,12'b0000?_0000000},
      {M_DIS,M_RDMRG01,12'b1000?_0000000},
      {M_DIS,M_RDMRG01,12'b0001?_0000000},
      {M_DIS,M_RDMRG01,12'b0000?_???1000},
      {M_DIS,M_RDMRG01,12'b0001?_???1000},
      {M_DIS,M_RDMRGC,12'b1000?_1000000},
      {M_DIS,M_RDMRGC,12'b1000?_0100000},
      {M_DIS,M_RDMRGC,12'b1000?_0010000},
      {M_DIS,M_RDMRGC,12'b1000?_0000000},
      {M_DIS,M_RDMRGC,12'b1000?_???1000},
      {M_DIS,M_DIS,12'b?????_???????} : begin end //Dual Operation OK
// added v1.05
      {M_WWR,M_STOP,12'b00001_???0?00},
      {M_SER,M_STOP,12'b0000?_???0?00},
      {M_CER,M_STOP,12'b0000?_???0?00},
      {M_EXER,M_STOP,12'b0000?_???0?00},
      {M_MRG,M_STOP,12'b00001_???0?00} : begin
`ifdef QNSC_DUALOP_NO_CHECK
        // NO Check
`else
        if ($time > 0 && intdce ===1'b1 ) begin
          $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : The combination of these modes is a prohibition.");
          Error_flag_DOP = 1'b1;
        end
`endif
      end
// added v1.05
      default : begin  //Dual Operation Error
`ifdef QNSC_DUALOP_NO_CHECK
        // NO Check
`else
        if ($time > 0) begin
          $display ("HM Error  : ",$time,"   QNSC3NCP1V2 %m : The combination of these modes is a prohibition.");
          Error_flag_DOP = 1'b1;
        end
`endif
      end
    endcase
  end
endtask

/*-----Specify-----*/
//#######################
// For poseCLK intce
// For negeCLK CE
//#######################
assign RDCLK = _CLKSEL1 ? _RDCLKC1 : _RDCLKP1;
assign DRDCLK = _DCLKSEL1 ? _DRDCLKC1 : _RDCLKP1;

`ifdef FAST_FUNC
//----- Timing No Check

`else

//----- SPECIFY
reg notifier_ad,notifier_rd;

// CodeFlash READ (SUB SIGNAL CONTOROL)
always @( negedge _SUB ) begin
  if ( ($time > 0) && (CIBRead_act===1'b1 || RDMRG_act===1'b1)) begin
    SUBRDCLK = 1'b1;
  end
end

always @( negedge RDCLK ) begin
  if (($time > 0) && (CIBRead_act===1'b1 || RDMRG_act===1'b1) && SUBRDCLK===1'b1) begin
    EdgeLCount = EdgeLCount + 1;
  end
end

always @( EdgeLCount ) begin
  if (($time > 0) && EdgeLCount >= 2 ) begin
    EdgeLCount = 0;
    #1 SUBRDCLK = 1'b0;
  end
end

// DataFlash READ (SUB SIGNAL CONTOROL)
always @( negedge _SUB ) begin
  if ( ($time > 0) && (DCIBRead_act===1'b1 || DRDMRG_act===1'b1)) begin
    DSUBRDCLK = 1'b1;
  end
end

always @( negedge DRDCLK ) begin
  if (($time > 0) && (DCIBRead_act===1'b1 || DRDMRG_act===1'b1) && DSUBRDCLK===1'b1) begin
    DEdgeLCount = DEdgeLCount + 1;
  end
end

always @( DEdgeLCount ) begin
  if (($time > 0) && DEdgeLCount >= 2 ) begin
    DEdgeLCount = 0;
    #1 DSUBRDCLK = 1'b0;
  end
end


//OTHER
buf (TRMRD12B, _TRMRD1===1'b0 && _TRMRD2===1'b0 && EWR_act===1'b1 ? 1'b1 : 1'b0);
buf (tmpDMY, 1'b0);
and (tmpLSPB, ~_LOWSPY, TRMRD12B);
and (tmpLSP,   _LOWSPY, TRMRD12B);
and (tmpCPTB, ~_CPT, TRMRD12B);

//#######Code
and (tmpCLKSEL,  _CLKSEL1, TRMRD12B);
and (tmpCLKSELB, ~_CLKSEL1, TRMRD12B);
and (tmpCLKSELDIS,  IDIS,  _CLKSEL1, TRMRD12B);
and (tmpCLKSELBDIS, IDIS, ~_CLKSEL1, TRMRD12B);
buf (DISmode, IDIS);
// v1.01
and (tmpCLKSELALLRD,   _CLKSEL1,  ((TRMRD12B & (|{FCBRead_act,CIBRead_act,RDMRG_act,MRG_act,ION_act}===1'b1)) |
     (_TRMRD1===1'b0 & _TRMRD2===1'b0 & BTmode_act===1'b1)));
and (tmpCLKSELBALLRD, ~_CLKSEL1, TRMRD12B, (|{FCBRead_act,CIBRead_act,RDMRG_act,MRG_act,ION_act}===1'b1));

//#######Data
and (tmpDCLKSEL,  _DCLKSEL1, TRMRD12B);
and (tmpDCLKSELB, ~_DCLKSEL1, TRMRD12B);
and (tmpDCLKSELDIS,  IDDIS,  _DCLKSEL1, TRMRD12B);
and (tmpDCLKSELBDIS, IDDIS, ~_DCLKSEL1, TRMRD12B);
buf (DDISmode, IDDIS);
// v1.01
and (tmpDCLKSELALLRD,   _DCLKSEL1,  ((TRMRD12B & (|{DFCBRead_act,DCIBRead_act,DRDMRG_act,DMRG_act,DION_act}===1'b1)) |
     (_TRMRD1===1'b0 & _TRMRD2===1'b0 & BTmode_act===1'b1)));
and (tmpDCLKSELBALLRD, ~_DCLKSEL1, TRMRD12B, (|{DFCBRead_act,DCIBRead_act,DRDMRG_act,DMRG_act,DION_act}===1'b1));

//READ/RDMRG0/RDMRG1/RDMRGC
//#######Code
or (RDorRDM, _READ, _RDMRG0, _RDMRG1, _RDMRGC);
and (rtmpRDorRDM, RDorRDM, TRMRD12B);
and (rtmpRDorRDMCE, RDorRDM, TRMRD12B, _CE);
buf (rtmpRDorRDMHS, ({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===6'b110001 ? 1'b1: 1'b0));
buf (rtmpRDorRDMLS, ({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===6'b100001 ? 1'b1: 1'b0));
buf (rtmpCLKSELRDorRDMHS, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1110001 ? 1'b1: 1'b0));
buf (rtmpCLKSELBRDorRDMHS, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1010001 ? 1'b1: 1'b0));
buf (rtmpCLKSELRDorRDMSUB, ({RDorRDM,_CLKSEL1,_SUB,TRMRD12B}===4'b1111 ? 1'b1: 1'b0));
buf (rtmpRDorRDMLP, ({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===6'b101001 ? 1'b1: 1'b0));
buf (rtmpRDorRDMLV, ({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===6'b100101 ? 1'b1: 1'b0));
buf (rtmpRDorRDMLV2, ({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,(_SUB | SUBRDCLK),TRMRD12B}===6'b100101 ? 1'b1: 1'b0));
//##READ Other
buf (rtmpCLKSELRDLV,({_READ,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1100101 ? 1'b1: 1'b0));
buf (rtmpCLKSELRDCELV,({_READ,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_CE,TRMRD12B}===8'b11001011 ? 1'b1: 1'b0));
buf (rtmpCLKSELRDorRDMLV,({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1100101 ? 1'b1: 1'b0));
buf (rtmpCLKSELBRDorRDMLV,({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1000101 ? 1'b1: 1'b0));
//##From SUB to LV or SUB tAS/tAH/tCES/tCEH Check
buf (rtmpCLKSELRDorRDMLV2, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,(_SUB | SUBRDCLK),TRMRD12B}===7'b1100101 ? 1'b1: 1'b0));
buf (rtmpCLKSELBRDorRDMLV2, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,(_SUB | SUBRDCLK),TRMRD12B}===7'b1000101 ? 1'b1: 1'b0));
//##From SUB to HS/LS/LV/LP
and (rtmpCLKSELRDorRDMSUBtoHS, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1110001 ? 1'b1: 1'b0), SUBRDCLK);
and (rtmpCLKSELRDorRDMSUBtoLS, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1100001 ? 1'b1: 1'b0), SUBRDCLK);
and (rtmpCLKSELRDorRDMSUBtoLP, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1101001 ? 1'b1: 1'b0), SUBRDCLK);
and (rtmpCLKSELRDorRDMSUBtoLV, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1100101 ? 1'b1: 1'b0), SUBRDCLK);

//#######Data
or (DRDorRDM, _DREAD, _RDMRG0, _RDMRG1, _RDMRGC);
and (rtmpDRDorRDM, DRDorRDM, TRMRD12B);
and (rtmpDRDorRDMCE, DRDorRDM, TRMRD12B, _DCE);
buf (rtmpDRDorRDMHS, ({DRDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===6'b110001 ? 1'b1: 1'b0));
buf (rtmpDRDorRDMLS, ({DRDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===6'b100001 ? 1'b1: 1'b0));
buf (rtmpDCLKSELRDorRDMHS, ({DRDorRDM,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1110001 ? 1'b1: 1'b0));
buf (rtmpDCLKSELBRDorRDMHS, ({DRDorRDM,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1010001 ? 1'b1: 1'b0));
buf (rtmpDCLKSELRDorRDMSUB, ({DRDorRDM,_DCLKSEL1,_SUB,TRMRD12B}===4'b1111 ? 1'b1: 1'b0));
buf (rtmpDRDorRDMLP, ({DRDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===6'b101001 ? 1'b1: 1'b0));
buf (rtmpDRDorRDMLV, ({DRDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===6'b100101 ? 1'b1: 1'b0));
buf (rtmpDRDorRDMLV2, ({DRDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,(_SUB | SUBRDCLK),TRMRD12B}===6'b100101 ? 1'b1: 1'b0));
//##READ Other
buf (rtmpDCLKSELRDLV,({_DREAD,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1100101 ? 1'b1: 1'b0));
buf (rtmpDCLKSELRDCELV,({_DREAD,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_DCE,TRMRD12B}===8'b11001011 ? 1'b1: 1'b0));
buf (rtmpDCLKSELRDorRDMLV,({DRDorRDM,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1100101 ? 1'b1: 1'b0));
buf (rtmpDCLKSELBRDorRDMLV,({DRDorRDM,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1000101 ? 1'b1: 1'b0));
//##From SUB to LV or SUB tAS/tAH/tCES/tCEH Check
buf (rtmpDCLKSELRDorRDMLV2, ({DRDorRDM,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,(_SUB | DSUBRDCLK),TRMRD12B}===7'b1100101 ? 1'b1: 1'b0));
buf (rtmpDCLKSELBRDorRDMLV2, ({DRDorRDM,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,(_SUB | DSUBRDCLK),TRMRD12B}===7'b1000101 ? 1'b1: 1'b0));
//##From SUB to HS/LS/LV/LP
and (rtmpDCLKSELRDorRDMSUBtoHS, ({DRDorRDM,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1110001 ? 1'b1: 1'b0), DSUBRDCLK);
and (rtmpDCLKSELRDorRDMSUBtoLS, ({DRDorRDM,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1100001 ? 1'b1: 1'b0), DSUBRDCLK);
and (rtmpDCLKSELRDorRDMSUBtoLP, ({DRDorRDM,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1101001 ? 1'b1: 1'b0), DSUBRDCLK);
and (rtmpDCLKSELRDorRDMSUBtoLV, ({DRDorRDM,_DCLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,TRMRD12B}===7'b1100101 ? 1'b1: 1'b0), DSUBRDCLK);

//##C1/P1 COMMON
//#######Code
and (rtmpRD,       _READ, TRMRD12B);
buf (rtmpRDCEHS,({_READ,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_CE,TRMRD12B}===7'b1100011 ? 1'b1: 1'b0));
buf (rtmpRDCELS,({_READ,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_CE,TRMRD12B}===7'b1000011 ? 1'b1: 1'b0));
buf (rtmpRDCELP,({_READ,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_CE,TRMRD12B}===7'b1010011 ? 1'b1: 1'b0));
buf (rtmpRDCELV,({_READ,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_CE,TRMRD12B}===7'b1001011 ? 1'b1: 1'b0));
buf (rtmpRDCESUB, ({_READ,_CLKSEL1,_SUB,_CE,TRMRD12B}===5'b11111 ? 1'b1: 1'b0));
buf (rtmpRDorRDMCEHS,({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_CE,TRMRD12B}===7'b1100011 ? 1'b1: 1'b0));
buf (rtmpRDorRDMCELS,({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_CE,TRMRD12B}===7'b1000011 ? 1'b1: 1'b0));
buf (rtmpRDorRDMCELP,({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_CE,TRMRD12B}===7'b1010011 ? 1'b1: 1'b0));
buf (rtmpRDorRDMCELV,({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_CE,TRMRD12B}===7'b1001011 ? 1'b1: 1'b0));
buf (rtmpRDorRDMCESUB, ({RDorRDM,_CLKSEL1,_SUB,_CE,TRMRD12B}===5'b11111 ? 1'b1: 1'b0));
//#######Data
and (rtmpDRD,       _DREAD, TRMRD12B);
buf (rtmpDRDCEHS,({_DREAD,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_DCE,TRMRD12B}===7'b1100011 ? 1'b1: 1'b0));
buf (rtmpDRDCELS,({_DREAD,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_DCE,TRMRD12B}===7'b1000011 ? 1'b1: 1'b0));
buf (rtmpDRDCELP,({_DREAD,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_DCE,TRMRD12B}===7'b1010011 ? 1'b1: 1'b0));
buf (rtmpDRDCELV,({_DREAD,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_DCE,TRMRD12B}===7'b1001011 ? 1'b1: 1'b0));
buf (rtmpDRDCESUB, ({_DREAD,_CLKSEL1,_SUB,_DCE,TRMRD12B}===5'b11111 ? 1'b1: 1'b0));
buf (rtmpDRDorRDMCEHS,({DRDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_DCE,TRMRD12B}===7'b1100011 ? 1'b1: 1'b0));
buf (rtmpDRDorRDMCELS,({DRDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_DCE,TRMRD12B}===7'b1000011 ? 1'b1: 1'b0));
buf (rtmpDRDorRDMCELP,({DRDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_DCE,TRMRD12B}===7'b1010011 ? 1'b1: 1'b0));
buf (rtmpDRDorRDMCELV,({DRDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_DCE,TRMRD12B}===7'b1001011 ? 1'b1: 1'b0));
buf (rtmpDRDorRDMCESUB, ({DRDorRDM,_CLKSEL1,_SUB,_DCE,TRMRD12B}===5'b11111 ? 1'b1: 1'b0));

//#######Code
buf (rtmpCLKSELRD,({_READ,_CLKSEL1,TRMRD12B}===3'b111 ? 1'b1: 1'b0));
buf (rtmpCLKSELRDCE,({_READ,_CLKSEL1,_CE,TRMRD12B}===4'b1111 ? 1'b1: 1'b0));
buf (rtmpCLKSELBRD,({_READ,_CLKSEL1,TRMRD12B}===3'b101 ? 1'b1: 1'b0));
//#######Data
buf (rtmpDCLKSELRD,({_DREAD,_DCLKSEL1,TRMRD12B}===3'b111 ? 1'b1: 1'b0));
buf (rtmpDCLKSELRDCE,({_DREAD,_DCLKSEL1,_DCE,TRMRD12B}===4'b1111 ? 1'b1: 1'b0));
buf (rtmpDCLKSELBRD,({_DREAD,_DCLKSEL1,TRMRD12B}===3'b101 ? 1'b1: 1'b0));

//WRITE
//##COMMON
and (wtmpMWLSP,   _MSWR,  _LOWSPY, TRMRD12B);
and (wtmpMWLSPB,  _MSWR, ~_LOWSPY, TRMRD12B);
//#######Code
and (wtmpWRITE_EN, (_WWR | _MSWR), TRMRD12B);
and (wtmpCLKSELBWW,  _WWR, ~_CLKSEL1,TRMRD12B);
and (wtmpCLKSELBMW,  _MSWR,~_CLKSEL1,TRMRD12B);
and (wtmpWWLSP,   _WWR,  _LOWSPY, TRMRD12B);
and (wtmpWWLSPB,  _WWR, ~_LOWSPY, TRMRD12B);
//#######Data
and (wtmpDWRITE_EN, (_DWWR | _MSWR), TRMRD12B);
and (wtmpDCLKSELBWW,  _DWWR,~_DCLKSEL1,TRMRD12B);
and (wtmpDCLKSELBMW,  _MSWR,~_DCLKSEL1,TRMRD12B);
and (wtmpDWWLSP,   _DWWR,  _LOWSPY, TRMRD12B);
and (wtmpDWWLSPB,  _DWWR, ~_LOWSPY, TRMRD12B);

//ERASE
//#######Code
and (etmpERASE_EN, (_SER | _CER | _EXER), TRMRD12B);
and (etmpCLKSELBSER, _SER, ~_CLKSEL1,TRMRD12B);
and (etmpCLKSELBCER, _CER, ~_CLKSEL1,TRMRD12B);
and (etmpCLKSELBEXER,_EXER,~_CLKSEL1,TRMRD12B);
//#######Data
and (etmpDERASE_EN, (_DSER | _DCER | _EXER), TRMRD12B);
and (etmpDCLKSELBSER, _DSER, ~_DCLKSEL1,TRMRD12B);
and (etmpDCLKSELBCER, _DCER, ~_DCLKSEL1,TRMRD12B);
and (etmpDCLKSELBEXER,_EXER, ~_DCLKSEL1,TRMRD12B);

//MRG FCBRead
//#######Code
and (mtmpMRGWVB, (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12), ~_LOWSPY, TRMRD12B);
and (mtmpMRGWV,  (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12),  _LOWSPY, TRMRD12B);
and (mtmpMRGCELWVB, (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12), intce, ~_LOWSPY, TRMRD12B);
and (mtmpMRGCELWV,  (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12), intce,  _LOWSPY, TRMRD12B);
and (mtmpMRG, (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12), TRMRD12B);
and (mtmpMRGCEL, (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12), intce, TRMRD12B);
//#######Data
and (mtmpDMRGWVB, (_DMRG00 | _DMRG01 | _DMRG10 | _DMRG11 | _DMRG12), ~_LOWSPY, TRMRD12B);
and (mtmpDMRGWV,  (_DMRG00 | _DMRG01 | _DMRG10 | _DMRG11 | _DMRG12),  _LOWSPY, TRMRD12B);
and (mtmpDMRGCELWVB, (_DMRG00 | _DMRG01 | _DMRG10 | _DMRG11 | _DMRG12), intdce, ~_LOWSPY, TRMRD12B);
and (mtmpDMRGCELWV,  (_DMRG00 | _DMRG01 | _DMRG10 | _DMRG11 | _DMRG12), intdce,  _LOWSPY, TRMRD12B);
and (mtmpDMRG, (_DMRG00 | _DMRG01 | _DMRG10 | _DMRG11 | _DMRG12), TRMRD12B);
and (mtmpDMRGCEL, (_DMRG00 | _DMRG01 | _DMRG10 | _DMRG11 | _DMRG12), intdce, TRMRD12B);

//READ MARGIN CHECK0/1
//#######Code
//##C1/P1 COMMON
and (rmtmpRDM,    (_RDMRG0 | _RDMRG1), TRMRD12B);
and (rmtmpRDMCE,    (_RDMRG0 | _RDMRG1), TRMRD12B, _CE);
//#######Data
//##C1/P1 COMMON
and (rmtmpDRDM,    (_RDMRG0 | _RDMRG1), TRMRD12B);
and (rmtmpDRDMCE,    (_RDMRG0 | _RDMRG1), TRMRD12B, _DCE);

//ION CHECK1
//#######Code
and (itmpION,    _IONCHK1,     TRMRD12B );
and (itmpIONCE,  _IONCHK1,     _CE,  TRMRD12B );
//#######Data
and (itmpDION,    _IONCHK1,     TRMRD12B );
and (itmpDIONCE,  _IONCHK1,     _DCE,  TRMRD12B );

//READ MARGIN CHECK
//#######Code
//##C1/P1 COMMON
and (rmtmpRDMC,    _RDMRGC, TRMRD12B);
//#######Data
//##C1/P1 COMMON
and (rmtmpDRDMC,    _RDMRGC, TRMRD12B);

//STCHK
//#######Code
and ( sttmpSTC,    _STCHK,     TRMRD12B );
and ( sttmpSTCCE,    _STCHK,     _CE,  TRMRD12B );
//#######Data
and ( sttmpDSTC,    _STCHK,     TRMRD12B );
and ( sttmpDSTCCE,    _STCHK,     _DCE,  TRMRD12B );

//WDT1/2/3/4
//##COMMON
and (dtmpWDT4, _WDT4, TRMRD12B);
//#######Code
and (dtmpCLKSELBWDT1, _WDT1, ~_CLKSEL1, TRMRD12B);
and (dtmpCLKSELBWDT2, _WDT2, ~_CLKSEL1, TRMRD12B);
and (dtmpCLKSELBWDT3, _WDT3, ~_CLKSEL1, TRMRD12B);
//#######Data
and (dtmpDCLKSELBWDT1, _WDT1, ~_DCLKSEL1, TRMRD12B);
and (dtmpDCLKSELBWDT2, _WDT2, ~_DCLKSEL1, TRMRD12B);
and (dtmpDCLKSELBWDT3, _WDT3, ~_DCLKSEL1, TRMRD12B);

//RDT
//##COMMON
and (dtmpRDT, _RDT, TRMRD12B);

//BT-mode
and (btmpBT, _SCANMODE, _TESDBT);

//SCAN-mode
and (stmpSCAN, _SCANMODE, ~_TESDBT);

//SPECIFY Start
specify
/*-----SPECPARAM-----*/

//DUMMY VALUE
specparam _DMY =1:1:1;

//READ
//#COMMON
specparam _TAS = 1:1:1;
specparam _TEXAS = 1:1:1;
specparam _TCES = 1:1:1;
specparam _TOH = 0:0:0;
specparam _TTRMCPSrd = 1000000:1000000:1000000;
specparam _TCLKSEL1S = 10000:10000:10000;
//#Vdd=16v
specparam _TAH16v = 3000:3000:3000;
specparam _TEXAH16v = 3000:3000:3000;
specparam _TCEH16v = 3000:3000:3000;
specparam _TOD16v = 15000:15000:15000;
//#Vdd=18v
specparam _TAH18v = 2100:2100:2100;
specparam _TEXAH18v = 2100:2100:2100;
specparam _TCEH18v = 2100:2100:2100;
specparam _TOD18v = 12000:12000:12000;
//#Vdd=21v
specparam _TAH21v = 1900:1900:1900;
specparam _TEXAH21v = 1900:1900:1900;
specparam _TCEH21v = 1900:1900:1900;
specparam _TOD21v = 4000:4000:4000;

//##LowSpeed
specparam _TCLKLls = 55000:55000:55000;
specparam _TCLKHls = 50000:50000:50000;   //v1.06 55ns -> 50ns
specparam _TCYCls = 110000:110000:110000;

//##HiSpeed
//#Fmax 32MHz
specparam _TCLKLhs32 = 14500:14500:14500;
specparam _TCLKHhs32 = 14500:14500:14500;
specparam _TCYChs32 = 29000:29000:29000;
//#Fmax 24MHz
specparam _TCLKLhs24 = 19000:19000:19000;
specparam _TCLKHhs24 = 19000:19000:19000;
specparam _TCYChs24 = 38000:38000:38000;
//#Fmax 16MHz
specparam _TCLKLhs16 = 29000:29000:29000;
specparam _TCLKHhs16 = 29000:29000:29000;
specparam _TCYChs16 = 58000:58000:58000;
//#VDD 18V
specparam _TCLKLhs18v = 55000:55000:55000;
specparam _TCLKHhs18v = 55000:55000:55000;
specparam _TCYChs18v = 110000:110000:110000;

//##Sub
specparam _TCLKLsub =11200000:11200000:11200000;
specparam _TCLKHsub =11200000:11200000:11200000;
specparam _TCYCsub =22400000:22400000:22400000;

//##LowPower
specparam _TCLKLlp = 440000:440000:440000;
specparam _TCLKHlp = 440000:440000:440000;
specparam _TCYClp = 880000:880000:880000;

//##LowVoltage
specparam _TCLKLlv = 440000:440000:440000;
specparam _TCLKHlv = 440000:440000:440000;
specparam _TCYClv = 880000:880000:880000;

//##Triming Code Read 1/2/3
specparam _TMStrm = 10000000:10000000:10000000;
specparam _TTRMCPStrm = 10000:10000:10000;
specparam _TSRCUTHtrm = 1:1:1;
specparam _TSRCUTWtrm = 50000:50000:50000;
specparam _TREQFLStrm = 10000:10000:10000;
specparam _TSRCUTStrm = 1000000:1000000:1000000;
specparam _TFIHFLStrm = 10000:10000:10000;

//##Reset Release
specparam _TRDNS = 85000:85000:85000;
specparam _TRDNH = 1000:1000:1000;
specparam _THISPEEDS = 5010000:5010000:5010000;  // THISPEEDS + THSPDS
specparam _THSPDS = 10000:10000:10000;
specparam _TRLSPYS = 10000:10000:10000;
specparam _TLSPDS = 3010000:3010000:3010000;  // TLSPDS + TRLSPYS
specparam _TLOWPOWERS = 730000:730000:730000;  // TLOWPOWERS(720ns) + TLPWRS
specparam _TLPWRS = 10000:10000:10000;

//##STOP Control
specparam _TSTOPhs = 5000000:5000000:5000000;
specparam _TSTOPlv = 10000000:10000000:10000000;
specparam _TSTOPls = 720000:720000:720000;
specparam _TSTOPlp = 720000:720000:720000;
specparam _TSTOPsub = 1:1:1;

//##DIS => READ
specparam _TMShs = 5000000:5000000:5000000;
specparam _TMSlv = 10000000:10000000:10000000;
specparam _TMSls = 720000:720000:720000;
specparam _TMSlp = 720000:720000:720000;
specparam _TLSPYS = 10010000:10010000:10010000;  // TLSPYS + TRLSPYS

//##HS/LV/LS/LP => Sub
specparam _TSUBT = 10000:10000:10000;

//##SRCUT Control
specparam _TSRCUTSrd21v = 160000:160000:160000;
specparam _TSRCUTSrd18v = 720000:720000:720000;
specparam _TSRCUTHrd = 1:1:1;

//##SACEEN Control
specparam _TCLKLsac = 500000:500000:500000;
specparam _TCLKHsac = 500000:500000:500000;
specparam _TASsac = 1:1:1;
specparam _TAHsac = 20000:20000:20000;
specparam _TSACEENSsac = 500000:500000:500000;
specparam _TSACEENHsac = 20000:20000:20000;
specparam _TTRMCPSsac = 1500000:1500000:1500000;
specparam _TTRMCPHsac = 1000:1000:1000;
specparam _TRDNSsac = 85000:85000:85000;
specparam _TRDNHsac = 1000:1000:1000;

//CWEE Control
specparam _TCWEES = 10000:10000:10000;
specparam _TCWEEH = 10000:10000:10000;

//WR/ER/OTHER COMMON
specparam _TLOWSPYS = 10000:10000:10000;
specparam _TLOWSPYH = 10000:10000:10000;
specparam _TBEUS = 20000:20000:20000;
specparam _TBEUH = 5000:5000:5000;

//WORD WRITE
specparam _TMSww = 1000000:1000000:1000000;
specparam _TDWSww = 30000:30000:30000;
specparam _TDWHww = 30000:30000:30000;
specparam _TMHww = 30000:30000:30000;
specparam _TCLKLww = 30000:30000:30000;
specparam _TRDWww = 10000:10000:10000;
specparam _TCESww = 20000:20000:20000;
specparam _TCEHww = 5000:5000:5000;
specparam _TASww = 20000:20000:20000;
specparam _TAHww = 5000:5000:5000;
specparam _TPWww = 10000000:10000000:10000000;
specparam _TPWLww = 1000000:1000000:1000000;
specparam _TPROGIww = 200000:200000:200000;
specparam _TPROGISww =1:1:1;
specparam _TPROGIWPww = 10000000:10000000:10000000;
specparam _TTRMCPSww = 1000000:1000000:1000000;
specparam _TPROGIWPww18v = 20000000:20000000:20000000;
specparam _TTRMCPSww18v = 10000000:10000000:10000000;
specparam _TTRMCPHww = 20000:20000:20000;

//##WORD WRITE (Add change amang this mode)
specparam _TCESww2 = 20000:20000:20000;
specparam _TASww2 = 20000:20000:20000;
specparam _TALWPww = 30000:30000:30000;
specparam _TWPRDww = 2000000:2000000:2000000;

//MULTI SELECT WRITE
specparam _TMHm =30000:30000:30000;
specparam _TRDWm =10000:10000:10000;
specparam _TBEUSm =20000:20000:20000;
specparam _TBEUHm =5000:5000:5000;
specparam _TPWm =10000000:10000000:10000000;
specparam _TPWLm =1000000:1000000:1000000;
specparam _TPROGIm =200000:200000:200000;
specparam _TPROGISm =1:1:1;
specparam _TPROGIWPm = 10000000:10000000:10000000;
specparam _TPROGIWPm18v = 20000000:20000000:20000000;

//##MULTI SELECT WRITE (Add change amang this mode)
specparam _TCLKLm =30000:30000:30000;
specparam _TCESm2 =20000:20000:20000;
specparam _TCEHm =5000:5000:5000;
specparam _TASm2 =20000:20000:20000;
specparam _TAHm =5000:5000:5000;
specparam _TBEUSm2 =20000:20000:20000;
specparam _TALWPm =30000:30000:30000;
specparam _TWPRDm =2000000:2000000:2000000;

//##MSWR CLAMP WRITE
specparam _TEXTVPP1S =1:1:1;
specparam _TVPPTS1S =500000:500000:500000;
specparam _TVPPTS2S =500000:500000:500000;
specparam _TMEOCS =500000:500000:500000;
specparam _TEXTVPP1H =1:1:1;
specparam _TVPPTS1H =200000:200000:200000;
specparam _TVPPTS2H =200000:200000:200000;
specparam _TMEOCH =20000:20000:20000;

//CHIP ERASE/EXTRA ERASE
specparam _TMSer = 10000000:10000000:10000000;
specparam _TMHer = 30000:30000:30000;
specparam _TRDEer = 10000:10000:10000;
specparam _TPEer = 1000000000:1000000000:1000000000;  // 1ms
specparam _TTRMCPSer = 1000000:1000000:1000000;
specparam _TTRMCPSer18v = 10000000:10000000:10000000;
specparam _TTRMCPHer = 20000:20000:20000;

//##CHIP ERASE/EXTRA ERASE (SACEEN signal control)
specparam _TRDEersac = 100000:100000:100000;  //Add Spec
specparam _TSACEENSer = 1:1:1;
specparam _TSACEENHer = 10000000:10000000:10000000;

//## EXTRA ERASE (MEOR signal control)
specparam _TMEORS = 500000:500000:500000;
specparam _TMEORH = 20000:20000:20000;

//SECTOR ERASE
specparam _TMSse = 10000000:10000000:10000000;
specparam _TMHse = 30000:30000:30000;
specparam _TRDEse = 10000:10000:10000;
specparam _TPEse = 1000000000:1000000000:1000000000;  // 1ms
specparam _TTRMCPSse = 1000000:1000000:1000000;
specparam _TTRMCPSse18v = 10000000:10000000:10000000;
specparam _TTRMCPHse = 20000:20000:20000;

//MARGIN CHECK00/01/10/11/12 FromFCB-Read
specparam _TMSmr = 10000000:10000000:10000000;
specparam _TMSmr18v = 40000000:40000000:40000000;
specparam _TMHmr = 30000:30000:30000;
specparam _TCEHmr = 20000:20000:20000;
specparam _TAHmr = 20000:20000:20000;
specparam _TEXAHmr = 20000:20000:20000;
specparam _TCLKLmr = 200000:200000:200000;
specparam _TCLKLmr18v = 500000:500000:500000;
specparam _TCLKHmr = 200000:200000:200000;
specparam _TCLKHmr18v = 500000:500000:500000;
specparam _TTRMCPSmr = 1500000:1500000:1500000;
specparam _TTRMCPHmr = 1000:1000:1000;

//READ MARGIN CHECK0/1
specparam _TMSrdm = 20000000:20000000:20000000;
specparam _TMHrdm = 30000:30000:30000;
specparam _TTRMCPSrdm = 10000000:10000000:10000000;
specparam _TTRMCPHrdm = 1000:1000:1000;

//ION CHECK1
specparam _TVPPSion =500000:500000:500000;
specparam _TVPPHion =200000:200000:200000;
specparam _TAH1ion =1:1:1;
specparam _TCEHion =1:1:1;
specparam _TMSion =10000000:10000000:10000000;
specparam _TMHion =200000:200000:200000;
specparam _TAH2ion =5000:5000:5000;
specparam _TRDIONion =10000:10000:10000;
specparam _TCLKLion =200000:200000:200000;
specparam _TCLKHion =200000:200000:200000;
specparam _TMUTESTSion =10000:10000:10000;

//READ MARGIN CHECK
specparam _TMSrdmc = 14000000:14000000:14000000;
specparam _TMHrdmc = 200000:200000:200000;
specparam _TCEHrdmc = 1:1:1;
specparam _TAH1rdmc = 1:1:1;
// specparam _TRDRrdmc =10000:10000:10000;  //v2 delete

//SELECT Tr. CHECK
specparam _TMSstc =20000000:20000000:20000000;
specparam _TMHstc =200000:200000:200000;
specparam _TCESstc =20000:20000:20000;
specparam _TCEHstc =1:1:1;
specparam _TAHstc =5000:5000:5000;
specparam _TRDSTstc =10000:10000:10000;
specparam _TCLKLstc =500000:500000:500000;
specparam _TCLKHstc =500000:500000:500000;

//CHARGE PUMP BT
specparam _TCPBT =1000000000:1000000000:1000000000;  // 1ms
specparam _TRDMcpb =10000:10000:10000;
specparam _TTRMCPScpb =10000000:10000000:10000000;
specparam _TTRMCPHcpb =20000:20000:20000;

//WRITE DISTRUB TEST1/2/3/4
specparam _TRDWwd =10000:10000:10000;
specparam _TMHwd =30000:30000:30000;
specparam _TPROGISwd =1:1:1;
specparam _TPROGIwd =200000:200000:200000;
specparam _TPROGIwdt1 =10000000:10000000:10000000;
specparam _TPROGIwdt2 =10000000:10000000:10000000;
specparam _TTRMCPSwd =1000000:1000000:1000000;
specparam _TTRMCPHwd =20000:20000:20000;
specparam _TRDNSwd =1000000:1000000:1000000;
specparam _TRDNHwd =20000:20000:20000;

//READ DISTURB TEST
specparam _TRDT =1000000000:1000000000:1000000000;  // 1ms
specparam _TMS1rdt =10000000:10000000:10000000;
specparam _TMH1rdt =50000:50000:50000;
specparam _TRDTL =1000000000:1000000000:1000000000;  // 1ms
specparam _TRDTH =1000000000:1000000000:1000000000;  // 1ms
specparam _TRDNSrdt =1000000:1000000:1000000;
specparam _TRDNHrdt =20000:20000:20000;
specparam _TRDRrdt =10000:10000:10000;

//EXTERNAL VPP1/2
specparam _TVPPS =500000:500000:500000;
specparam _TVPPH =200000:200000:200000;
specparam _TEXT1S =1:1:1; //TMS
specparam _TEXT1H =1:1:1; //TMH
specparam _TEXT2S =1:1:1; //TMS
specparam _TEXT2H =1:1:1; //TMH

//CHARGE PUMP TEST
specparam _TRDMcpt =10000:10000:10000;
specparam _TCPTS =1:1:1;  
specparam _TCPTH =1:1:1;
  
//SENSE AMP REFERENCE TEST
specparam _TIREFTS =1:1:1;
specparam _TIREFTH =1:1:1;

//BT-mode
specparam _TMSbt = 11000000:11000000:11000000;
specparam _TVBZ  = 10000:10000:10000;

//SCAN-mode
specparam _TSCNMDS = 50000:50000:50000;
specparam _TSCNMDH = 50000:50000:50000;
specparam _TSCNIS = 2000:2000:2000;
specparam _TSCNIH = 2000:2000:2000;

// VBREAZ=>RESB  v1.01_add
specparam _TVBRESB = 3500:3500:3500;

// FIHFL=>RDSETUP v1.03_add For CP-Macro Only
specparam _TRDSET = 1600:1600:1600;

/*-----TimingArc-----*/
//For Annotate Block

// FIHFL=>RDSETUP v1.03_add For CP-Macro Only
  ( negedge FIHFL => ( RDSETUP : FIHFL ) ) = ( _TRDSET, _TRDSET );

`ifdef QNSC_USE_VDD_18V
//##READ HiSpeed
  $width ( negedge RDCLK &&& rtmpRDorRDMHS , _TCLKLhs18v, 0, notifier_rd );
  $width ( posedge RDCLK &&& rtmpRDorRDMHS , _TCLKHhs18v, 0, notifier_rd );
  $period ( posedge RDCLK &&& rtmpRDorRDMHS , _TCYChs18v, notifier_rd );
  $period ( negedge RDCLK &&& rtmpRDorRDMHS , _TCYChs18v, notifier_rd );
  $width ( negedge DRDCLK &&& rtmpDRDorRDMHS , _TCLKLhs18v, 0, notifier_rd );
  $width ( posedge DRDCLK &&& rtmpDRDorRDMHS , _TCLKHhs18v, 0, notifier_rd );
  $period ( posedge DRDCLK &&& rtmpDRDorRDMHS , _TCYChs18v, notifier_rd );
  $period ( negedge DRDCLK &&& rtmpDRDorRDMHS , _TCYChs18v, notifier_rd );

`else
//##READ HiSpeed
  $width ( negedge RDCLK &&& rtmpRDorRDMHS , _TCLKLhs32, 0, notifier_rd );
  $width ( posedge RDCLK &&& rtmpRDorRDMHS , _TCLKHhs32, 0, notifier_rd );
  $period ( posedge RDCLK &&& rtmpRDorRDMHS , _TCYChs32, notifier_rd );
  $period ( negedge RDCLK &&& rtmpRDorRDMHS , _TCYChs32, notifier_rd );
  $width ( negedge DRDCLK &&& rtmpDRDorRDMHS , _TCLKLhs16, 0, notifier_rd );
  $width ( posedge DRDCLK &&& rtmpDRDorRDMHS , _TCLKHhs16, 0, notifier_rd );
  $period ( posedge DRDCLK &&& rtmpDRDorRDMHS , _TCYChs16, notifier_rd );
  $period ( negedge DRDCLK &&& rtmpDRDorRDMHS , _TCYChs16, notifier_rd );

`endif

//##READ LowVoltage tCLKL/tCLKH/tCYC Check
  $width ( negedge RDCLK &&&  rtmpRDorRDMLV , _TCLKLlv, 0, notifier_rd );
  $width ( posedge RDCLK &&&  rtmpRDorRDMLV , _TCLKHlv, 0, notifier_rd );
  $period ( posedge RDCLK &&& rtmpRDorRDMLV , _TCYClv, notifier_rd );
  $period ( negedge RDCLK &&& rtmpRDorRDMLV , _TCYClv, notifier_rd );
  $width ( negedge DRDCLK &&&  rtmpDRDorRDMLV , _TCLKLlv, 0, notifier_rd );
  $width ( posedge DRDCLK &&&  rtmpDRDorRDMLV , _TCLKHlv, 0, notifier_rd );
  $period ( posedge DRDCLK &&& rtmpDRDorRDMLV , _TCYClv, notifier_rd );
  $period ( negedge DRDCLK &&& rtmpDRDorRDMLV , _TCYClv, notifier_rd );

//COMMON ##Dummy SDF Annotate
  $width ( negedge RDCLKC1 &&&  tmpDMY , _TCLKLhs32, 0, notifier_rd );
  $width ( posedge RDCLKC1 &&&  tmpDMY , _TCLKHhs32, 0, notifier_rd );
  $period ( posedge RDCLKC1 &&& tmpDMY , _TCYChs32, notifier_rd );
  $period ( negedge RDCLKC1 &&& tmpDMY , _TCYChs32, notifier_rd );

  $width ( negedge DRDCLKC1 &&&  tmpDMY , _TCLKLhs32, 0, notifier_rd );
  $width ( posedge DRDCLKC1 &&&  tmpDMY , _TCLKHhs32, 0, notifier_rd );
  $period ( posedge DRDCLKC1 &&& tmpDMY , _TCYChs32, notifier_rd );
  $period ( negedge DRDCLKC1 &&& tmpDMY , _TCYChs32, notifier_rd );

  $width ( negedge RDCLKP1 &&&  tmpDMY , _TCLKLhs32, 0, notifier_rd );
  $width ( posedge RDCLKP1 &&&  tmpDMY , _TCLKHhs32, 0, notifier_rd );
  $period ( posedge RDCLKP1 &&& tmpDMY , _TCYChs32, notifier_rd );
  $period ( negedge RDCLKP1 &&& tmpDMY , _TCYChs32, notifier_rd );

//COMMON ##SDF Annotate  v1.01
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge CE, _TCES, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge CE, _TCES, _DMY, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge CE, _DMY, _TCEH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge CE, _DMY, _TCEH21v, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpDCLKSELBALLRD , negedge DCE, _TCES, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpDCLKSELBALLRD , posedge DCE, _TCES, _DMY, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpDCLKSELBALLRD , negedge DCE, _DMY, _TCEH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpDCLKSELBALLRD , posedge DCE, _DMY, _TCEH21v, notifier_ad );

  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge CE, _TCES, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge CE, _TCES, _DMY, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge CE, _DMY, _TCEH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge CE, _DMY, _TCEH21v, notifier_ad );
  $setuphold ( negedge DRDCLKC1 &&& tmpDCLKSELALLRD , negedge DCE, _TCES, _DMY, notifier_ad );
  $setuphold ( negedge DRDCLKC1 &&& tmpDCLKSELALLRD , posedge DCE, _TCES, _DMY, notifier_ad );
  $setuphold ( posedge DRDCLKC1 &&& tmpDCLKSELALLRD , negedge DCE, _DMY, _TCEH21v, notifier_ad );
  $setuphold ( posedge DRDCLKC1 &&& tmpDCLKSELALLRD , posedge DCE, _DMY, _TCEH21v, notifier_ad );

//READ
//##COMMON
  $setuphold ( negedge _RDCLKP1 &&& rtmpCLKSELBRD, negedge _CLKSEL1, _TCLKSEL1S , _DMY, notifier_rd );
  $setuphold ( negedge _RDCLKC1 &&& rtmpCLKSELRD, posedge _CLKSEL1, _TCLKSEL1S , _DMY, notifier_rd );
  $setuphold ( negedge _RDCLKP1 &&& rtmpDCLKSELBRD, negedge _DCLKSEL1, _TCLKSEL1S , _DMY, notifier_rd );
  $setuphold ( negedge _DRDCLKC1 &&& rtmpDCLKSELRD, posedge _DCLKSEL1, _TCLKSEL1S , _DMY, notifier_rd );

//##LowSpeed
  $width ( negedge RDCLK &&& rtmpRDorRDMLS , _TCLKLls, 0, notifier_rd );
  $width ( posedge RDCLK &&& rtmpRDorRDMLS , _TCLKHls, 0, notifier_rd );
  $period ( posedge RDCLK &&& rtmpRDorRDMLS , _TCYCls, notifier_rd );
  $period ( negedge RDCLK &&& rtmpRDorRDMLS , _TCYCls, notifier_rd );
  $width ( negedge DRDCLK &&& rtmpDRDorRDMLS , _TCLKLls, 0, notifier_rd );
  $width ( posedge DRDCLK &&& rtmpDRDorRDMLS , _TCLKHls, 0, notifier_rd );
  $period ( posedge DRDCLK &&& rtmpDRDorRDMLS , _TCYCls, notifier_rd );
  $period ( negedge DRDCLK &&& rtmpDRDorRDMLS , _TCYCls, notifier_rd );

//##HiSpeed ##SDF Annotate
// 

//##Sub ##NoCheck

//##LowPower
  $width ( negedge RDCLK &&& rtmpRDorRDMLP , _TCLKLlp, 0, notifier_rd );
  $width ( posedge RDCLK &&& rtmpRDorRDMLP , _TCLKHlp, 0, notifier_rd );
  $period ( posedge RDCLK &&& rtmpRDorRDMLP , _TCYClp, notifier_rd );
  $period ( negedge RDCLK &&& rtmpRDorRDMLP , _TCYClp, notifier_rd );
  $width ( negedge DRDCLK &&& rtmpDRDorRDMLP , _TCLKLlp, 0, notifier_rd );
  $width ( posedge DRDCLK &&& rtmpDRDorRDMLP , _TCLKHlp, 0, notifier_rd );
  $period ( posedge DRDCLK &&& rtmpDRDorRDMLP , _TCYClp, notifier_rd );
  $period ( negedge DRDCLK &&& rtmpDRDorRDMLP , _TCYClp, notifier_rd );

//##LowVoltage ##SDF Annotate
//

//##Triming Code Read 1/2/3
  $setuphold (negedge _RDCLKC1 &&& rtmpCLKSELRDLV, negedge _TRMRD2, _TMStrm, _DMY);
  
  $setuphold (negedge _TRMRD2, _RTRMCP18, _TTRMCPStrm, _DMY);
  $setuphold (negedge _TRMRD2, _RTRMCP19, _TTRMCPStrm, _DMY);
  $setuphold (negedge _TRMRD2, _RTRMCP20, _TTRMCPStrm, _DMY);
  
  $setuphold (negedge RDCLK &&& rtmpRDCELV, negedge _SRCUTCP, _TSRCUTStrm, _DMY);

//##Reset Release Timing
  $width (posedge _SRCUT &&& rtmpRD, _TSRCUTWtrm, 0, notifier_rd );  //Code Only

  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP0, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP1, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP2, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP3, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP4, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP5, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP6, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP7, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP8, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP9, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP15, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP16, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _TRMCP17, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _RTRMCP15, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _RTRMCP16, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _RTRMCP17, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _RTRMCP18, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _RTRMCP19, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCE, _RTRMCP20, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP0, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP1, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP2, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP3, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP4, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP5, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP6, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP7, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP8, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP9, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP15, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP16, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _TRMCP17, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _RTRMCP15, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _RTRMCP16, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _RTRMCP17, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _RTRMCP18, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _RTRMCP19, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCE, _RTRMCP20, _TTRMCPSrd, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rtmpRDCEHS, posedge _HISPEED, _THISPEEDS, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCELS, negedge _RLOWSPY, _TLSPDS, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCELP, posedge _LOWPOWER, _TLOWPOWERS, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDCEHS, posedge _HISPEED, _THISPEEDS, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDCELS, negedge _RLOWSPY, _TLSPDS, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDCELP, posedge _LOWPOWER, _TLOWPOWERS, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _HISPEED, _THSPDS, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _RLOWSPY, _TRLSPYS, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _LOWPOWER, _TLPWRS, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _HISPEED, _THSPDS, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _RLOWSPY, _TRLSPYS, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _LOWPOWER, _TLPWRS, _DMY, notifier_rd);

//##STOP Control
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCEHS, negedge _FLSTOP, _TSTOPhs, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCELV, negedge _FLSTOP, _TSTOPlv, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCELS, negedge _FLSTOP, _TSTOPls, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCELP, negedge _FLSTOP, _TSTOPlp, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCEHS, negedge _DFLSTOP, _TSTOPhs, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCELV, negedge _DFLSTOP, _TSTOPlv, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCELS, negedge _DFLSTOP, _TSTOPls, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCELP, negedge _DFLSTOP, _TSTOPlp, _DMY, notifier_rd);

//##DIS => READ
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCEHS, negedge DISmode, _TMShs, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCELV, negedge DISmode, _TMSlv, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCELS, negedge DISmode, _TMSls, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCELP, negedge DISmode, _TMSlp, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCEHS, negedge DDISmode, _TMShs, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCELV, negedge DDISmode, _TMSlv, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCELS, negedge DDISmode, _TMSls, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCELP, negedge DDISmode, _TMSlp, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rtmpRDorRDMCELV, posedge _RLOWSPY, _TLSPYS, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDMCELV, posedge _RLOWSPY, _TLSPYS, _DMY, notifier_rd);

//##HS/LV/LS/LP => Sub
//NO Check

//##SRCUT Control  ##Code Only
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCEHS, negedge _SRCUT, _TSRCUTSrd21v, _DMY, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCELS, negedge _SRCUT, _TSRCUTSrd18v, _DMY, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCELP, negedge _SRCUT, _TSRCUTSrd18v, _DMY, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCESUB, negedge _SRCUT, _TSRCUTSrd18v, _DMY, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCEHS,  posedge _SRCUT, _DMY, _TSRCUTHrd, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCELS,  posedge _SRCUT, _DMY, _TSRCUTHrd, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCELP,  posedge _SRCUT, _DMY, _TSRCUTHrd, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDorRDMCESUB, posedge _SRCUT, _DMY, _TSRCUTHrd, notifier_rd );

//##SACEEN Control
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP0, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP1, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP2, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP3, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP4, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP5, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP6, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP7, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP8, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP9, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP15, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP16, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _TRMCP17, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _RTRMCP15, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _RTRMCP16, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _RTRMCP17, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _RTRMCP18, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _RTRMCP19, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDorRDM, _RTRMCP20, _DMY, _TTRMCPHsac, notifier_rd);

  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP0, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP1, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP2, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP3, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP4, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP5, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP6, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP7, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP8, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP9, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP15, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP16, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _TRMCP17, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _RTRMCP15, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _RTRMCP16, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _RTRMCP17, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _RTRMCP18, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _RTRMCP19, _DMY, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge DRDCLK &&& rtmpDRDorRDM, _RTRMCP20, _DMY, _TTRMCPHsac, notifier_rd);

//CWEE Control
  $setuphold (negedge DISmode, _CWEE, _TCWEES, _DMY);
  $setuphold (posedge DISmode, _CWEE, _DMY, _TCWEEH);
  $setuphold (negedge DDISmode, _CWEE, _TCWEES, _DMY);
  $setuphold (posedge DDISmode, _CWEE, _DMY, _TCWEEH);

//WR/ER/OTHER COMMON
  $setuphold (negedge DISmode, _LOWSPY, _TLOWSPYS, _DMY);
  $setuphold (posedge DISmode, _LOWSPY, _DMY, _TLOWSPYH);
  $setuphold (negedge DDISmode, _LOWSPY, _TLOWSPYS, _DMY);
  $setuphold (posedge DDISmode, _LOWSPY, _DMY, _TLOWSPYH);

//WORD WRITE
  $setuphold (negedge _RDCLKP1 &&& tmpCLKSELB, posedge DISmode, _TMSww, _DMY);
  $setuphold (negedge _RDCLKP1 &&& tmpDCLKSELB, posedge DDISmode, _TMSww, _DMY );

  $setuphold (negedge _FCLK1 &&& TRMRD12B, negedge _WWR, _DMY, _TMHww );
  $setuphold (negedge _FCLK1 &&& TRMRD12B, negedge _DWWR, _DMY, _TMHww );

  $width (negedge _RDCLKP1 &&& tmpCLKSELBDIS, _TCLKLww );
  $width (negedge _RDCLKP1 &&& tmpDCLKSELBDIS, _TCLKLww );

  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELB, posedge _WWR, _DMY, _TRDWww );
  $setuphold (posedge _RDCLKP1 &&& tmpDCLKSELB, posedge _DWWR, _DMY, _TRDWww );

  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _CE, _TCESww, _TCEHww);
  $setuphold (posedge _RDCLKP1 &&& tmpDCLKSELBDIS, _DCE, _TCESww, _TCEHww);

  $width (posedge _FCLK1 &&& wtmpCLKSELBWW, _TPWww);
  $width (posedge _FCLK1 &&& wtmpDCLKSELBWW, _TPWww);

  $width (posedge _PROGI &&& wtmpCLKSELBWW, _TPROGIww );
  $setuphold (posedge _PROGI &&& TRMRD12B, posedge _WWR, _TPROGISww, _DMY ); //1ps
  $setuphold (posedge _PROGI &&& wtmpCLKSELBWW, negedge DISmode, _TPROGISww, _DMY ); //1ps
  $setuphold (posedge _FCLK1 &&& wtmpWWLSPB, negedge _PROGI, _TPROGIWPww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWWLSP, negedge _PROGI, _TPROGIWPww18v, _DMY );

  $width (posedge _PROGI &&& wtmpDCLKSELBWW, _TPROGIww );
  $setuphold (posedge _PROGI &&& TRMRD12B, posedge _DWWR, _TPROGISww, _DMY ); //1ps
  $setuphold (posedge _PROGI &&& wtmpDCLKSELBWW, negedge DDISmode, _TPROGISww, _DMY ); //1ps
  $setuphold (posedge _FCLK1 &&& wtmpDWWLSPB, negedge _PROGI, _TPROGIWPww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpDWWLSP, negedge _PROGI, _TPROGIWPww18v, _DMY );

  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP0, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP1, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP2, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP3, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP4, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP5, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP6, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP7, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP8, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP9, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP15, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP16, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP17, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP0, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP1, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP2, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP3, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP4, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP5, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP6, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP7, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP8, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP9, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP15, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP16, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP17, _TTRMCPSww18v, _DMY);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHww);

  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP0, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP1, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP2, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP3, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP4, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP5, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP6, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP7, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP8, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP9, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP15, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP16, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _TRMCP17, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP0, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP1, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP2, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP3, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP4, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP5, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP6, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP7, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP8, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP9, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP15, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP16, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _TRMCP17, _TTRMCPSww18v, _DMY);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHww);

  $setuphold (posedge _WWR &&& tmpLSPB, _RTRMCP15, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _RTRMCP16, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _RTRMCP17, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _RTRMCP18, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _RTRMCP19, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _RTRMCP20, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _RTRMCP15, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _RTRMCP16, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _RTRMCP17, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _RTRMCP18, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _RTRMCP19, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _RTRMCP20, _TTRMCPSww18v, _DMY);
  $setuphold (negedge _WWR &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHww);

  $setuphold (posedge _DWWR &&& tmpLSPB, _RTRMCP15, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _RTRMCP16, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _RTRMCP17, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _RTRMCP18, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _RTRMCP19, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSPB, _RTRMCP20, _TTRMCPSww, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _RTRMCP15, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _RTRMCP16, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _RTRMCP17, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _RTRMCP18, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _RTRMCP19, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _DWWR &&& tmpLSP, _RTRMCP20, _TTRMCPSww18v, _DMY);
  $setuphold (negedge _DWWR &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHww);
  $setuphold (negedge _DWWR &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHww);

//## WORD WRITE(Add change amang this mode)
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _CE , _TCESww2, _DMY ); //Tces2=20ns
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _CE, _DMY, _TCEHww );
  $setuphold (negedge _RDCLKP1 &&& wtmpDCLKSELBWW, _DCE , _TCESww2, _DMY ); //Tces2=20ns
  $setuphold ( posedge _RDCLKP1 &&& wtmpDCLKSELBWW, _DCE, _DMY, _TCEHww );

  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, posedge _FCLK1, _DMY, _TALWPww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpDCLKSELBWW, posedge _FCLK1, _DMY, _TALWPww );

  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, negedge _FCLK1, _TWPRDww, _DMY );
  $setuphold (negedge _RDCLKP1 &&& wtmpDCLKSELBWW, negedge _FCLK1, _TWPRDww, _DMY );

  $width ( negedge _RDCLKP1 &&& wtmpCLKSELBWW, _TCLKLww );
  $width ( negedge _RDCLKP1 &&& wtmpDCLKSELBWW, _TCLKLww );

//MULTI SELECT WRITE
  $setuphold (negedge _FCLK1 &&& TRMRD12B, negedge _MSWR, _DMY, _TMHm );

  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELB, posedge _MSWR, _DMY, _TRDWm );
  $setuphold (posedge _RDCLKP1 &&& tmpDCLKSELB, posedge _MSWR, _DMY, _TRDWm );

  $width (posedge _FCLK1 &&& wtmpCLKSELBMW, _TPWm);
  $width (posedge _FCLK1 &&& wtmpDCLKSELBMW, _TPWm);

  $width (posedge _PROGI &&& wtmpCLKSELBMW, _TPROGIm );
  $width (posedge _PROGI &&& wtmpDCLKSELBMW, _TPROGIm );
  $setuphold (posedge _PROGI &&& TRMRD12B, posedge _MSWR, _TPROGISm, _DMY ); //1ps Code&Data Common Line
  $setuphold (posedge _PROGI &&& wtmpCLKSELBMW, negedge DISmode, _TPROGISm, _DMY ); //1ps
  $setuphold (posedge _PROGI &&& wtmpDCLKSELBMW, negedge DDISmode, _TPROGISm, _DMY ); //1ps
  $setuphold (posedge _FCLK1 &&& wtmpMWLSPB, negedge _PROGI, _TPROGIWPm, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpMWLSP, negedge _PROGI, _TPROGIWPm18v, _DMY );

  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP0, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP1, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP2, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP3, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP4, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP5, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP6, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP7, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP8, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP9, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP15, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP16, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP17, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP0, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP1, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP2, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP3, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP4, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP5, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP6, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP7, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP8, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP9, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP15, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP16, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP17, _TTRMCPSww18v, _DMY);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHww);

  $setuphold (posedge _MSWR &&& tmpLSPB, _RTRMCP15, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _RTRMCP16, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _RTRMCP17, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _RTRMCP18, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _RTRMCP19, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _RTRMCP20, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _RTRMCP15, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _RTRMCP16, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _RTRMCP17, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _RTRMCP18, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _RTRMCP19, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _RTRMCP20, _TTRMCPSww18v, _DMY);
  $setuphold (negedge _MSWR &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHww);

//##MULTI SELECT WRITE(Add change amang this mode)
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _CE , _TCESm2, _DMY ); //Tces2=20ns
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _CE, _DMY, _TCEHm );
  $setuphold (negedge _RDCLKP1 &&& wtmpDCLKSELBMW, _DCE , _TCESm2, _DMY ); //Tces2=20ns
  $setuphold ( posedge _RDCLKP1 &&& wtmpDCLKSELBMW, _DCE, _DMY, _TCEHm );

  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, posedge _FCLK1, _DMY, _TALWPm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpDCLKSELBMW, posedge _FCLK1, _DMY, _TALWPm );

  $setuphold ( negedge _FCLK1, negedge _RDCLKP1 &&& wtmpCLKSELBMW, _TWPRDm, _DMY );
  $setuphold ( negedge _FCLK1, negedge _RDCLKP1 &&& wtmpDCLKSELBMW, _TWPRDm, _DMY );

  $width ( negedge _RDCLKP1 &&& wtmpCLKSELBMW, _TCLKLm );
  $width ( negedge _RDCLKP1 &&& wtmpDCLKSELBMW, _TCLKLm );

  $setuphold ( posedge _MSWR &&& TRMRD12B, _MEOC , _TMEOCS, _DMY );
  $setuphold ( negedge _MSWR &&& TRMRD12B, _MEOC, _DMY, _TMEOCH );

//CHIP ERASE/EXTRA ERASE
  $setuphold ( posedge _FCLK1 &&& TRMRD12B, posedge _CER, _TMSer, _DMY );
  $setuphold ( posedge _FCLK1 &&& TRMRD12B, posedge _DCER, _TMSer, _DMY );
  $setuphold ( posedge _FCLK1 &&& TRMRD12B, posedge _EXER, _TMSer, _DMY );

  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _CER, _DMY, _TMHer );
  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _DCER, _DMY, _TMHer );
  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _EXER, _DMY, _TMHer );

  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _CER, _DMY, _TRDEer );
  $setuphold ( posedge _RDCLKP1 &&& tmpDCLKSELB, posedge _DCER, _DMY, _TRDEer );
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _EXER, _DMY, _TRDEer );
  $setuphold ( posedge _RDCLKP1 &&& tmpDCLKSELB, posedge _EXER, _DMY, _TRDEer );

//  $width ( posedge _FCLK1 &&& _CER, _TPEer );
//  $width ( posedge _FCLK1 &&& _DCER, _TPEer );
//  $width ( posedge _FCLK1 &&& _EXER, _TPEer );

  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP0, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP1, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP2, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP3, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP4, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP5, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP6, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP7, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP8, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP9, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP15, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP16, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP17, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP0, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP1, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP2, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP3, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP4, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP5, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP6, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP7, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP8, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP9, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP15, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP16, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP17, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHer);

  $setuphold (posedge _CER &&& tmpLSPB, _RTRMCP15, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _RTRMCP16, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _RTRMCP17, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _RTRMCP18, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _RTRMCP19, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _RTRMCP20, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _RTRMCP15, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _RTRMCP16, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _RTRMCP17, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _RTRMCP18, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _RTRMCP19, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _RTRMCP20, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _CER &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHer);

  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP0, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP1, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP2, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP3, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP4, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP5, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP6, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP7, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP8, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP9, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP15, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP16, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _TRMCP17, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP0, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP1, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP2, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP3, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP4, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP5, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP6, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP7, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP8, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP9, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP15, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP16, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _TRMCP17, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHer);
  
  $setuphold (posedge _DCER &&& tmpLSPB, _RTRMCP15, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _RTRMCP16, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _RTRMCP17, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _RTRMCP18, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _RTRMCP19, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSPB, _RTRMCP20, _TTRMCPSer, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _RTRMCP15, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _RTRMCP16, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _RTRMCP17, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _RTRMCP18, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _RTRMCP19, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DCER &&& tmpLSP, _RTRMCP20, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _DCER &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHer);
  $setuphold (negedge _DCER &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHer);

  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP0, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP1, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP2, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP3, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP4, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP5, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP6, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP7, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP8, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP9, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP15, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP16, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP17, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP0, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP1, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP2, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP3, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP4, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP5, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP6, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP7, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP8, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP9, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP15, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP16, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP17, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHer);

  $setuphold (posedge _EXER &&& tmpLSPB, _RTRMCP15, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _RTRMCP16, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _RTRMCP17, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _RTRMCP18, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _RTRMCP19, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _RTRMCP20, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _RTRMCP15, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _RTRMCP16, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _RTRMCP17, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _RTRMCP18, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _RTRMCP19, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _RTRMCP20, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _EXER &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHer);

//## CHIP ERASE/EXTRA ERASE (SACEEN signal control)
//NO Check

//## EXTRA ERASE (MEOR signal control)
  $setuphold ( posedge _EXER &&& TRMRD12B, _MEOR, _TMEORS , _DMY);
  $setuphold ( negedge _EXER &&& TRMRD12B, _MEOR, _DMY , _TMEORH);

//SECTOR ERASE
  $setuphold ( posedge _FCLK1 &&& TRMRD12B, posedge _SER, _TMSse, _DMY );
  $setuphold ( posedge _FCLK1 &&& TRMRD12B, posedge _DSER, _TMSse, _DMY );

  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _SER, _DMY, _TMHse );
  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _DSER, _DMY, _TMHse );

  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _SER, _DMY, _TRDEse );  
  $setuphold ( posedge _RDCLKP1 &&& tmpDCLKSELB, posedge _DSER, _DMY, _TRDEse );  

//  $width ( posedge _FCLK1 &&& _SER, _TPEse );
//  $width ( posedge _FCLK1 &&& _DSER, _TPEse );

  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP0, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP1, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP2, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP3, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP4, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP5, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP6, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP7, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP8, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP9, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP15, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP16, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP17, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP0, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP1, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP2, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP3, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP4, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP5, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP6, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP7, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP8, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP9, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP15, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP16, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP17, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHer);
  
  $setuphold (posedge _SER &&& tmpLSPB, _RTRMCP15, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _RTRMCP16, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _RTRMCP17, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _RTRMCP18, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _RTRMCP19, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _RTRMCP20, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _RTRMCP15, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _RTRMCP16, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _RTRMCP17, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _RTRMCP18, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _RTRMCP19, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _RTRMCP20, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _SER &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHer);

  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP0, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP1, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP2, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP3, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP4, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP5, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP6, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP7, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP8, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP9, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP15, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP16, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _TRMCP17, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP0, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP1, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP2, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP3, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP4, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP5, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP6, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP7, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP8, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP9, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP15, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP16, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _TRMCP17, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHer);
  
  $setuphold (posedge _DSER &&& tmpLSPB, _RTRMCP15, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _RTRMCP16, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _RTRMCP17, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _RTRMCP18, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _RTRMCP19, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSPB, _RTRMCP20, _TTRMCPSer, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _RTRMCP15, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _RTRMCP16, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _RTRMCP17, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _RTRMCP18, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _RTRMCP19, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _DSER &&& tmpLSP, _RTRMCP20, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _DSER &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHer);
  $setuphold (negedge _DSER &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHer);

//MARGIN CHECK 00/01/10/11/12 & FCBRead
//## tMS Check Memory Only

  $setuphold ( posedge RDCLK &&& rtmpRD, negedge _READ, _DMY,  _TMHmr );
  $setuphold ( posedge RDCLK &&& mtmpMRG, negedge _MRG00, _DMY, _TMHmr );
  $setuphold ( posedge RDCLK &&& mtmpMRG, negedge _MRG01, _DMY, _TMHmr );
  $setuphold ( posedge RDCLK &&& mtmpMRG, negedge _MRG10, _DMY, _TMHmr );
  $setuphold ( posedge RDCLK &&& mtmpMRG, negedge _MRG11, _DMY, _TMHmr );
  $setuphold ( posedge RDCLK &&& mtmpMRG, negedge _MRG12, _DMY, _TMHmr );
  $setuphold ( posedge DRDCLK &&& rtmpDRD, negedge _DREAD, _DMY,  _TMHmr );
  $setuphold ( posedge DRDCLK &&& mtmpDMRG, negedge _DMRG00, _DMY, _TMHmr );
  $setuphold ( posedge DRDCLK &&& mtmpDMRG, negedge _DMRG01, _DMY, _TMHmr );
  $setuphold ( posedge DRDCLK &&& mtmpDMRG, negedge _DMRG10, _DMY, _TMHmr );
  $setuphold ( posedge DRDCLK &&& mtmpDMRG, negedge _DMRG11, _DMY, _TMHmr );
  $setuphold ( posedge DRDCLK &&& mtmpDMRG, negedge _DMRG12, _DMY, _TMHmr );

  $width ( negedge RDCLK &&& mtmpMRGWVB, _TCLKLmr, 0, notifier_rd);
  $width ( posedge RDCLK &&& mtmpMRGWVB, _TCLKHmr, 0, notifier_rd);
  $width ( negedge RDCLK &&& mtmpMRGWV, _TCLKLmr18v, 0, notifier_rd);
  $width ( posedge RDCLK &&& mtmpMRGWV, _TCLKHmr18v, 0, notifier_rd);
  $width ( negedge DRDCLK &&& mtmpDMRGWVB, _TCLKLmr, 0, notifier_rd);
  $width ( posedge DRDCLK &&& mtmpDMRGWVB, _TCLKHmr, 0, notifier_rd);
  $width ( negedge DRDCLK &&& mtmpDMRGWV, _TCLKLmr18v, 0, notifier_rd);
  $width ( posedge DRDCLK &&& mtmpDMRGWV, _TCLKHmr18v, 0, notifier_rd);

  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP0, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP1, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP2, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP3, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP4, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP5, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP6, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP7, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP8, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP9, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP0, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP1, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP2, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP3, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP4, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP5, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP6, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP7, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP8, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP9, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP17, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP0, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP1, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP2, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP3, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP4, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP5, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP6, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP7, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP8, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP9, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _TRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP0, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP1, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP2, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP3, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP4, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP5, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP6, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP7, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP8, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP9, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _TRMCP17, _DMY, _TTRMCPHmr, notifier_rd);

  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _RTRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _RTRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _RTRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _RTRMCP18, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _RTRMCP19, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _RTRMCP20, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _RTRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _RTRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _RTRMCP17, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _RTRMCP18, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _RTRMCP19, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _RTRMCP20, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _RTRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _RTRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _RTRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _RTRMCP18, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _RTRMCP19, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& mtmpDMRGCEL, _RTRMCP20, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _RTRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _RTRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _RTRMCP17, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _RTRMCP18, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _RTRMCP19, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& mtmpDMRG, _RTRMCP20, _DMY, _TTRMCPHmr, notifier_rd);

//READ MARGIN CHECK0/1
//##COMMON
//  $setuphold ( posedge RDCLK &&& rmtmpRDM, posedge _RDMRG0, _TMSrdm, _DMY, notifier_rd );  // Memory HDL Check
//  $setuphold ( posedge RDCLK &&& rmtmpRDM, posedge _RDMRG1, _TMSrdm, _DMY, notifier_rd );  // Memory HDL Check
  $setuphold ( negedge RDCLK &&& rmtmpRDM, negedge _RDMRG0, _DMY, _TMHrdm );
  $setuphold ( negedge RDCLK &&& rmtmpRDM, negedge _RDMRG1, _DMY, _TMHrdm );

//  $setuphold ( posedge DRDCLK &&& rmtmpDRDM, posedge _RDMRG0, _TMSrdm, _DMY, notifier_rd );  // Memory HDL Check
//  $setuphold ( posedge DRDCLK &&& rmtmpDRDM, posedge _RDMRG1, _TMSrdm, _DMY, notifier_rd );  // Memory HDL Check
  $setuphold ( negedge DRDCLK &&& rmtmpDRDM, negedge _RDMRG0, _DMY, _TMHrdm );
  $setuphold ( negedge DRDCLK &&& rmtmpDRDM, negedge _RDMRG1, _DMY, _TMHrdm );

  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP0, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP1, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP2, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP3, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP4, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP5, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP6, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP7, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP8, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP9, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP15, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP16, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _TRMCP17, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _RTRMCP15, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _RTRMCP16, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _RTRMCP17, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _RTRMCP18, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _RTRMCP19, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCE, _RTRMCP20, _TTRMCPSrdm, _DMY, notifier_rd);

  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP0, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP1, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP2, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP3, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP4, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP5, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP6, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP7, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP8, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP9, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP15, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP16, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _TRMCP17, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _RTRMCP15, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _RTRMCP16, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _RTRMCP17, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _RTRMCP18, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _RTRMCP19, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMCE, _RTRMCP20, _TTRMCPSrdm, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP0, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP1, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP2, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP3, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP4, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP5, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP6, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP7, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP8, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP9, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP15, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP16, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _TRMCP17, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _RTRMCP15, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _RTRMCP16, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _RTRMCP17, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _RTRMCP18, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _RTRMCP19, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _RTRMCP20, _DMY, _TTRMCPHrdm, notifier_rd);

  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP0, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP1, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP2, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP3, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP4, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP5, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP6, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP7, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP8, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP9, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP15, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP16, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _TRMCP17, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _RTRMCP15, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _RTRMCP16, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _RTRMCP17, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _RTRMCP18, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _RTRMCP19, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDM, _RTRMCP20, _DMY, _TTRMCPHrdm, notifier_rd);

//COMMON READ
//##LowSpeed
//##HiSpeed
//##Sub ## NoCheck
//##LowPower
//##LowVoltage

//##HS/LV/LS/LP => Sub
//NO Check

//##SACEEN Control
//NO Check

//ION CHECK1
//  $setuphold ( negedge RDCLK &&& itmpIONCE, posedge _IONCHK1, _TMSion, _DMY, notifier_rd  );  // Memory HDL Check
//  $setuphold ( negedge DRDCLK &&& itmpDIONCE, posedge _IONCHK1, _TMSion, _DMY, notifier_rd  );  // Memory HDL Check
  $setuphold ( posedge RDCLK &&& itmpION, negedge _IONCHK1, _DMY, _TMHion );
  $setuphold ( posedge DRDCLK &&& itmpDION, negedge _IONCHK1, _DMY, _TMHion );
  $setuphold ( negedge _IONCHK1 &&& TRMRD12B, _CE , _DMY, _TCEHion );
  $setuphold ( negedge _IONCHK1 &&& TRMRD12B, _DCE , _DMY, _TCEHion );

  $setuphold ( posedge RDCLK &&& TRMRD12B, posedge _IONCHK1, _DMY, _TRDIONion );
  $setuphold ( posedge DRDCLK &&& TRMRD12B, posedge _IONCHK1, _DMY, _TRDIONion );

  $width ( negedge RDCLK &&& itmpION , _TCLKLion, 0, notifier_rd );
  $width ( posedge RDCLK &&& itmpION , _TCLKHion, 0, notifier_rd );
  $width ( negedge RDCLK &&& itmpDION , _TCLKLion, 0, notifier_rd );
  $width ( posedge RDCLK &&& itmpDION , _TCLKHion, 0, notifier_rd );

  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP0, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP1, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP2, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP3, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP4, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP5, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP6, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP7, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP8, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP9, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _RTRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _RTRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _RTRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _RTRMCP18, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _RTRMCP19, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _RTRMCP20, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP0, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP1, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP2, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP3, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP4, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP5, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP6, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP7, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP8, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP9, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _TRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _RTRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _RTRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _RTRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _RTRMCP18, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _RTRMCP19, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& itmpDIONCE, _RTRMCP20, _TTRMCPSmr, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& itmpION, _TRMCP0, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP1, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP2, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP3, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP4, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP5, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP6, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP7, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP8, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP9, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP17, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _RTRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _RTRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _RTRMCP17, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _RTRMCP18, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _RTRMCP19, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _RTRMCP20, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP0, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP1, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP2, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP3, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP4, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP5, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP6, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP7, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP8, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP9, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _TRMCP17, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _RTRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _RTRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _RTRMCP17, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _RTRMCP18, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _RTRMCP19, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& itmpDION, _RTRMCP20, _DMY, _TTRMCPHmr, notifier_rd);

//READ MARGIN CHECK
//##COMMON
//  $setuphold ( negedge RDCLK &&& rmtmpRDMC, posedge _RDMRGC, _TMSrdmc, _DMY, notifier_rd );  // Memory HDL Check
  $setuphold ( posedge RDCLK &&& rmtmpRDMC, negedge _RDMRGC, _DMY, _TMHrdmc );
//  $setuphold ( negedge DRDCLK &&& rmtmpDRDMC, posedge _RDMRGC, _TMSrdmc, _DMY, notifier_rd );  // Memory HDL Check
  $setuphold ( posedge DRDCLK &&& rmtmpDRDMC, negedge _RDMRGC, _DMY, _TMHrdmc );

  $setuphold ( negedge _RDMRGC &&& TRMRD12B, _CE , _DMY, _TCEHrdmc );
  $setuphold ( negedge _RDMRGC &&& TRMRD12B, _DCE , _DMY, _TCEHrdmc );

//v2 deleta  $setuphold (posedge RDCLK &&& TRMRD12B, posedge _RDMRGC, _DMY, _TRDRrdmc );
//v2 deleta  $setuphold (posedge DRDCLK &&& TRMRD12B, posedge _RDMRGC, _DMY, _TRDRrdmc );

  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP0, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP1, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP2, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP3, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP4, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP5, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP6, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP7, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP8, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP9, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP15, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP16, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _TRMCP17, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _RTRMCP15, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _RTRMCP16, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _RTRMCP17, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _RTRMCP18, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _RTRMCP19, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMC, _RTRMCP20, _TTRMCPSrdm, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP0, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP1, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP2, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP3, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP4, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP5, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP6, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP7, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP8, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP9, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP15, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP16, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _TRMCP17, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _RTRMCP15, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _RTRMCP16, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _RTRMCP17, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _RTRMCP18, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _RTRMCP19, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _RTRMCP20, _DMY, _TTRMCPHrdm, notifier_rd);

  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP0, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP1, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP2, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP3, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP4, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP5, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP6, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP7, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP8, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP9, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP15, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP16, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _TRMCP17, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _RTRMCP15, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _RTRMCP16, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _RTRMCP17, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _RTRMCP18, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _RTRMCP19, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& rmtmpDRDMC, _RTRMCP20, _TTRMCPSrdm, _DMY, notifier_rd);

  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP0, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP1, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP2, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP3, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP4, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP5, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP6, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP7, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP8, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP9, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP15, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP16, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _TRMCP17, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _RTRMCP15, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _RTRMCP16, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _RTRMCP17, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _RTRMCP18, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _RTRMCP19, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge DRDCLK &&& rmtmpDRDMC, _RTRMCP20, _DMY, _TTRMCPHrdm, notifier_rd);

//COMMON READ
//##LowSpeed
//##HiSpeed
//##Sub  ##NO Check
//##LowPower
//##LowVoltage

//##HS/LV/LS/LP => Sub
//NO Check

//##SACEEN Control
//NO Check

//SELECT Tr CHECK
//  $setuphold  (negedge RDCLK  &&&  sttmpSTCCE, posedge _STCHK, _TMSstc, _DMY);
  $setuphold  (posedge RDCLK  &&&  sttmpSTC, negedge _STCHK, _DMY, _TMHstc);
  $setuphold  (negedge _STCHK  &&&  sttmpSTC, _CE, _DMY, _TCEHstc);
//  $setuphold  (negedge DRDCLK  &&&  sttmpDSTCCE, posedge _STCHK, _TMSstc, _DMY);
  $setuphold  (posedge DRDCLK  &&&  sttmpDSTC, negedge _STCHK, _DMY, _TMHstc);
  $setuphold  (negedge _STCHK  &&&  sttmpDSTC, _DCE, _DMY, _TCEHstc);

  $width ( negedge RDCLK &&& sttmpSTC , _TCLKLstc, 0, notifier_rd );
  $width ( posedge RDCLK &&& sttmpSTC , _TCLKHstc, 0, notifier_rd );
  $width ( negedge DRDCLK &&& sttmpDSTC , _TCLKLstc, 0, notifier_rd );
  $width ( posedge DRDCLK &&& sttmpDSTC , _TCLKHstc, 0, notifier_rd );

  $setuphold (posedge RDCLK &&& TRMRD12B, posedge _STCHK, _DMY, _TRDSTstc );
  $setuphold (posedge DRDCLK &&& TRMRD12B, posedge _STCHK, _DMY, _TRDSTstc );

  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP0, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP1, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP2, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP3, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP4, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP5, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP6, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP7, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP8, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP9, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _RTRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _RTRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _RTRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _RTRMCP18, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _RTRMCP19, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _RTRMCP20, _TTRMCPSmr, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP0, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP1, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP2, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP3, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP4, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP5, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP6, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP7, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP8, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP9, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP17, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _RTRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _RTRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _RTRMCP17, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _RTRMCP18, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _RTRMCP19, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _RTRMCP20, _DMY, _TTRMCPHmr, notifier_rd);

  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP0, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP1, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP2, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP3, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP4, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP5, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP6, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP7, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP8, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP9, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _TRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _RTRMCP15, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _RTRMCP16, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _RTRMCP17, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _RTRMCP18, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _RTRMCP19, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge DRDCLK &&& sttmpDSTCCE, _RTRMCP20, _TTRMCPSmr, _DMY, notifier_rd);

  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP0, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP1, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP2, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP3, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP4, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP5, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP6, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP7, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP8, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP9, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _TRMCP17, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _RTRMCP15, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _RTRMCP16, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _RTRMCP17, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _RTRMCP18, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _RTRMCP19, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge DRDCLK &&& sttmpDSTC, _RTRMCP20, _DMY, _TTRMCPHmr, notifier_rd);

//CHARGE PUMP BT
  $width ( posedge _CPBT &&& TRMRD12B, _TCPBT );  // 1ms

  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP0, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP1, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP2, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP3, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP4, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP5, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP6, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP7, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP8, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP9, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP15, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP16, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP17, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _RTRMCP15, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _RTRMCP16, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _RTRMCP17, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _RTRMCP18, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _RTRMCP19, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _RTRMCP20, _TTRMCPScpb, _DMY);

  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHcpb);

  $setuphold (posedge _RDCLKP1 &&& TRMRD12B, posedge _CPBT, _DMY, _TRDMcpb );
  $setuphold (posedge _RDCLKP1 &&& TRMRD12B, posedge _CPBT, _DMY, _TRDMcpb );

//WRITE DISTRUB TEST1/2/3/4
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _WDT1, _DMY, _TRDWwd );
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _WDT2, _DMY, _TRDWwd );
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _WDT3, _DMY, _TRDWwd );
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _WDT4, _DMY, _TRDWwd );
  $setuphold ( posedge _RDCLKP1 &&& tmpDCLKSELB, posedge _WDT1, _DMY, _TRDWwd );
  $setuphold ( posedge _RDCLKP1 &&& tmpDCLKSELB, posedge _WDT2, _DMY, _TRDWwd );
  $setuphold ( posedge _RDCLKP1 &&& tmpDCLKSELB, posedge _WDT3, _DMY, _TRDWwd );
  $setuphold ( posedge _RDCLKP1 &&& tmpDCLKSELB, posedge _WDT4, _DMY, _TRDWwd );

  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _WDT1, _DMY, _TMHwd );
  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _WDT2, _DMY, _TMHwd );
  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _WDT3, _DMY, _TMHwd );
  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _WDT4, _DMY, _TMHwd );

  $setuphold ( posedge PROGI &&& TRMRD12B, posedge _WDT1, _TPROGISwd, _DMY );
  $setuphold ( posedge PROGI &&& TRMRD12B, posedge _WDT2, _TPROGISwd, _DMY );
  $setuphold ( posedge PROGI &&& TRMRD12B, posedge _WDT3, _TPROGISwd, _DMY );
  $setuphold ( posedge PROGI &&& TRMRD12B, posedge _WDT4, _TPROGISwd, _DMY );
  $width ( posedge _PROGI &&& dtmpCLKSELBWDT1, _TPROGIwd );
  $width ( posedge _PROGI &&& dtmpCLKSELBWDT2, _TPROGIwd );
  $width ( posedge _PROGI &&& dtmpCLKSELBWDT3, _TPROGIwd );
  $width ( posedge _PROGI &&& dtmpDCLKSELBWDT1, _TPROGIwd );
  $width ( posedge _PROGI &&& dtmpDCLKSELBWDT2, _TPROGIwd );
  $width ( posedge _PROGI &&& dtmpDCLKSELBWDT3, _TPROGIwd );
  $width ( posedge _PROGI &&& dtmpWDT4, _TPROGIwd );
  $setuphold ( negedge _PROGI &&& dtmpCLKSELBWDT1, posedge _FCLK1, _DMY, _TPROGIwdt1 );
  $setuphold ( negedge _PROGI &&& dtmpCLKSELBWDT2, posedge _FCLK1, _DMY, _TPROGIwdt2 );
  $setuphold ( negedge _PROGI &&& dtmpDCLKSELBWDT1, posedge _FCLK1, _DMY, _TPROGIwdt1 );
  $setuphold ( negedge _PROGI &&& dtmpDCLKSELBWDT2, posedge _FCLK1, _DMY, _TPROGIwdt2 );

  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP0, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP0, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP0, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP0, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP1, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP1, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP1, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP1, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP2, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP2, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP2, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP2, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP3, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP3, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP3, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP3, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP4, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP4, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP4, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP4, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP5, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP5, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP5, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP5, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP6, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP6, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP6, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP6, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP7, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP7, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP7, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP7, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP8, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP8, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP8, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP8, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP9, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP9, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP9, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP9, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP15, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP15, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP15, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP15, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP16, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP16, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP16, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP16, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP17, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP17, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP17, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP17, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _RTRMCP15, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _RTRMCP15, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _RTRMCP15, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _RTRMCP15, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _RTRMCP16, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _RTRMCP16, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _RTRMCP16, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _RTRMCP16, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _RTRMCP17, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _RTRMCP17, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _RTRMCP17, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _RTRMCP17, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _RTRMCP18, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _RTRMCP18, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _RTRMCP18, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _RTRMCP18, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _RTRMCP19, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _RTRMCP19, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _RTRMCP19, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _RTRMCP19, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _RTRMCP20, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _RTRMCP20, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _RTRMCP20, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _RTRMCP20, _TTRMCPSwd, _DMY);

  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP0, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP1, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP2, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP3, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP4, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP5, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP6, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP7, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP8, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP9, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP15, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP16, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP17, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _RTRMCP15, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _RTRMCP16, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _RTRMCP17, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _RTRMCP18, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _RTRMCP19, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _RTRMCP20, _DMY, _TTRMCPHwd);

  $setuphold ( posedge _WDT1 &&& TRMRD12B, _MEOC , _TMEOCS, _DMY );
  $setuphold ( negedge _WDT1 &&& TRMRD12B, _MEOC , _DMY, _TMEOCH );
  $setuphold ( posedge _WDT4 &&& TRMRD12B, _MEOC , _TMEOCS, _DMY );
  $setuphold ( negedge _WDT4 &&& TRMRD12B, _MEOC , _DMY, _TMEOCH );

  $setuphold ( posedge _WDT1 &&& TRMRD12B, _MEOR , _TMEORS, _DMY );
  $setuphold ( negedge _WDT1 &&& TRMRD12B, _MEOR , _DMY, _TMEORH );
  $setuphold ( posedge _WDT2 &&& TRMRD12B, _MEOR , _TMEORS, _DMY );
  $setuphold ( negedge _WDT2 &&& TRMRD12B, _MEOR , _DMY, _TMEORH );

//READ DISTURB TEST
  $width ( posedge _FCLK1 &&& dtmpRDT, _TRDT );
  $setuphold ( posedge _FCLK1 &&& TRMRD12B, posedge _RDT, _TMS1rdt, _DMY );
  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _RDT, _DMY, _TMH1rdt );

//READ DISTURB TEST (FCLK change)
  $width ( negedge _FCLK1 &&& dtmpRDT, _TRDTL );
  $width ( posedge _FCLK1 &&& dtmpRDT, _TRDTH );

//READ DISTURB TEST (MEOR Control)
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _RDT, _DMY, _TRDRrdt );
  $setuphold ( posedge _RDCLKP1 &&& tmpDCLKSELB, posedge _RDT, _DMY, _TRDRrdt );

  $setuphold ( posedge _RDT &&& TRMRD12B, _MEOR , _TMEORS, _DMY );
  $setuphold ( negedge _RDT &&& TRMRD12B, _MEOR , _DMY, _TMEORH );

//EXTERNAL VPP1/2
  $setuphold ( posedge _WWR &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _CER &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _SER &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _MRG00 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _MRG01 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _MRG10 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _MRG11 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _MRG12 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _READ &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _MSWR &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _EXER &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _IONCHK1 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _CPBT &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _WDT1 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _WDT2 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _WDT3 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _WDT4 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _RDT &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _STCHK &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _RDMRG0 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _RDMRG1 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _RDMRGC &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );

  $setuphold ( posedge _DWWR &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _DCER &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _DSER &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _DMRG00 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _DMRG01 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _DMRG10 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _DMRG11 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _DMRG12 &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );
  $setuphold ( posedge _DREAD &&& tmpCPTB, posedge VPPTS1, _TVPPS, _DMY );

  $setuphold ( negedge _WWR &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _CER &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _SER &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _MRG00 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _MRG01 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _MRG10 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _MRG11 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _MRG12 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _READ &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _MSWR &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _EXER &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _IONCHK1 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _CPBT &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _WDT1 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _WDT2 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _WDT3 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _WDT4 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _RDT &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _STCHK &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _RDMRG0 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _RDMRG1 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _RDMRGC &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );

  $setuphold ( negedge _DWWR &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _DCER &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _DSER &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _DMRG00 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _DMRG01 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _DMRG10 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _DMRG11 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _DMRG12 &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );
  $setuphold ( negedge _DREAD &&& tmpCPTB, negedge VPPTS1, _DMY, _TVPPH );

  $setuphold ( posedge _WWR &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _CER &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _SER &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _MRG00 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _MRG01 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _MRG10 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _MRG11 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _MRG12 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _READ &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _MSWR &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _EXER &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _IONCHK1 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _CPBT &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _WDT1 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _WDT2 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _WDT3 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _WDT4 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _RDT &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _STCHK &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _RDMRG0 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _RDMRG1 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _RDMRGC &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );

  $setuphold ( posedge _DWWR &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _DCER &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _DSER &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _DMRG00 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _DMRG01 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _DMRG10 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _DMRG11 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _DMRG12 &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );
  $setuphold ( posedge _DREAD &&& TRMRD12B, _EXTVPP1, _TEXT1S, _DMY );

  $setuphold ( posedge _WWR &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _CER &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _SER &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _MRG00 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _MRG01 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _MRG10 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _MRG11 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _MRG12 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _READ &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _MSWR &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _EXER &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _IONCHK1 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _CPBT &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _WDT1 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _WDT2 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _WDT3 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _WDT4 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _RDT &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _STCHK &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _RDMRG0 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _RDMRG1 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _RDMRGC &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );

  $setuphold ( posedge _DWWR &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _DCER &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _DSER &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _DMRG00 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _DMRG01 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _DMRG10 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _DMRG11 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _DMRG12 &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );
  $setuphold ( posedge _DREAD &&& TRMRD12B, _EXTVPP2, _TEXT2S, _DMY );

  $setuphold ( negedge _WWR &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _CER &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _SER &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _MRG00 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _MRG01 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _MRG10 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _MRG11 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _MRG12 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _READ &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _MSWR &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _EXER &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _IONCHK1 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _CPBT &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H ); 
  $setuphold ( negedge _WDT1 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _WDT2 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _WDT3 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _WDT4 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _RDT &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _STCHK &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _RDMRG0 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _RDMRG1 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _RDMRGC &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );

  $setuphold ( negedge _DWWR &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _DCER &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _DSER &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _DMRG00 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _DMRG01 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _DMRG10 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _DMRG11 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _DMRG12 &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );
  $setuphold ( negedge _DREAD &&& TRMRD12B, _EXTVPP1, _DMY, _TEXT1H );

  $setuphold ( negedge _WWR &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _CER &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _SER &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _MRG00 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _MRG01 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _MRG10 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _MRG11 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _MRG12 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _READ &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _MSWR &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _EXER &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _IONCHK1 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _CPBT &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _WDT1 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _WDT2 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _WDT3 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _WDT4 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _RDT &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _STCHK &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _RDMRG0 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _RDMRG1 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _RDMRGC &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );

  $setuphold ( negedge _DWWR &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _DCER &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _DSER &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _DMRG00 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _DMRG01 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _DMRG10 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _DMRG11 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _DMRG12 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );
  $setuphold ( negedge _DREAD &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT2H );

//CHARGE PUMP TEST 
  $setuphold ( posedge _WWR &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _CER &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _SER &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _MRG00 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _MRG01 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _MRG10 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _MRG11 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _MRG12 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _READ &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _MSWR &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _EXER &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _IONCHK1 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _CPBT &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _WDT1 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _WDT2 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _WDT3 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _WDT4 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _RDT &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _STCHK &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _RDMRG0 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _RDMRG1 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _RDMRGC &&& TRMRD12B, _CPT, _TCPTS, _DMY );

  $setuphold ( posedge _DWWR &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _DCER &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _DSER &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _DMRG00 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _DMRG01 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _DMRG10 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _DMRG11 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _DMRG12 &&& TRMRD12B, _CPT, _TCPTS, _DMY );
  $setuphold ( posedge _DREAD &&& TRMRD12B, _CPT, _TCPTS, _DMY );

  $setuphold ( negedge _WWR &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _CER &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _SER &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _MRG00 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _MRG01 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _MRG10 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _MRG11 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _MRG12 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _READ &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _MSWR &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _EXER &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _IONCHK1 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _CPBT &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _WDT1 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _WDT2 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _WDT3 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _WDT4 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _RDT &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _STCHK &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _RDMRG0 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _RDMRG1 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _RDMRGC &&& TRMRD12B, _CPT, _DMY, _TCPTH );

  $setuphold ( negedge _DWWR &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _DCER &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _DSER &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _DMRG00 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _DMRG01 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _DMRG10 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _DMRG11 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _DMRG12 &&& TRMRD12B, _CPT, _DMY, _TCPTH );
  $setuphold ( negedge _DREAD &&& TRMRD12B, _CPT, _DMY, _TCPTH );

  $setuphold ( posedge _WWR &&& TRMRD12B, _OSCNOSTP, _TCPTS, _DMY );
  $setuphold ( posedge _CER &&& TRMRD12B, _OSCNOSTP, _TCPTS, _DMY );
  $setuphold ( posedge _SER &&& TRMRD12B, _OSCNOSTP, _TCPTS, _DMY );
  $setuphold ( posedge _MSWR &&& TRMRD12B, _OSCNOSTP, _TCPTS, _DMY );
  $setuphold ( posedge _EXER &&& TRMRD12B, _OSCNOSTP, _TCPTS, _DMY );
  $setuphold ( posedge _CPBT &&& TRMRD12B, _OSCNOSTP, _TCPTS, _DMY ); 

  $setuphold ( posedge _DWWR &&& TRMRD12B, _OSCNOSTP, _TCPTS, _DMY );
  $setuphold ( posedge _DCER &&& TRMRD12B, _OSCNOSTP, _TCPTS, _DMY );
  $setuphold ( posedge _DSER &&& TRMRD12B, _OSCNOSTP, _TCPTS, _DMY );

  $setuphold ( negedge _WWR &&& TRMRD12B, _OSCNOSTP, _DMY, _TCPTH );
  $setuphold ( negedge _CER &&& TRMRD12B, _OSCNOSTP, _DMY, _TCPTH );
  $setuphold ( negedge _SER &&& TRMRD12B, _OSCNOSTP, _DMY, _TCPTH );
  $setuphold ( negedge _MSWR &&& TRMRD12B, _OSCNOSTP, _DMY, _TCPTH );
  $setuphold ( negedge _EXER &&& TRMRD12B, _OSCNOSTP, _DMY, _TCPTH );
  $setuphold ( negedge _CPBT &&& TRMRD12B, _OSCNOSTP, _DMY, _TCPTH ); 

  $setuphold ( negedge _DWWR &&& TRMRD12B, _OSCNOSTP, _DMY, _TCPTH );
  $setuphold ( negedge _DCER &&& TRMRD12B, _OSCNOSTP, _DMY, _TCPTH );
  $setuphold ( negedge _DSER &&& TRMRD12B, _OSCNOSTP, _DMY, _TCPTH );

  $setuphold ( posedge _WWR &&& TRMRD12B, _OSCOUTEN, _TCPTS, _DMY );
  $setuphold ( posedge _CER &&& TRMRD12B, _OSCOUTEN, _TCPTS, _DMY );
  $setuphold ( posedge _SER &&& TRMRD12B, _OSCOUTEN, _TCPTS, _DMY );
  $setuphold ( posedge _MSWR &&& TRMRD12B, _OSCOUTEN, _TCPTS, _DMY );
  $setuphold ( posedge _EXER &&& TRMRD12B, _OSCOUTEN, _TCPTS, _DMY );
  $setuphold ( posedge _CPBT &&& TRMRD12B, _OSCOUTEN, _TCPTS, _DMY );

  $setuphold ( posedge _DWWR &&& TRMRD12B, _OSCOUTEN, _TCPTS, _DMY );
  $setuphold ( posedge _DCER &&& TRMRD12B, _OSCOUTEN, _TCPTS, _DMY );
  $setuphold ( posedge _DSER &&& TRMRD12B, _OSCOUTEN, _TCPTS, _DMY );

  $setuphold ( negedge _WWR &&& TRMRD12B, _OSCOUTEN, _DMY, _TCPTH );
  $setuphold ( negedge _CER &&& TRMRD12B, _OSCOUTEN, _DMY, _TCPTH );
  $setuphold ( negedge _SER &&& TRMRD12B, _OSCOUTEN, _DMY, _TCPTH );
  $setuphold ( negedge _MSWR &&& TRMRD12B, _OSCOUTEN, _DMY, _TCPTH );
  $setuphold ( negedge _EXER &&& TRMRD12B, _OSCOUTEN, _DMY, _TCPTH );
  $setuphold ( negedge _CPBT &&& TRMRD12B, _OSCOUTEN, _DMY, _TCPTH );

  $setuphold ( negedge _DWWR &&& TRMRD12B, _OSCOUTEN, _DMY, _TCPTH );
  $setuphold ( negedge _DCER &&& TRMRD12B, _OSCOUTEN, _DMY, _TCPTH );
  $setuphold ( negedge _DSER &&& TRMRD12B, _OSCOUTEN, _DMY, _TCPTH );

  $setuphold ( posedge _WWR &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _CER &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _SER &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MRG00 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MRG01 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MRG10 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MRG11 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MRG12 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _READ &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MSWR &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _EXER &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _IONCHK1 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _CPBT &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _WDT1 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _WDT2 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _WDT3 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _WDT4 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _RDT &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _STCHK &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _RDMRG0 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _RDMRG1 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _RDMRGC &&& TRMRD12B,_CWEE, _TCWEES, _DMY );

  $setuphold ( posedge _DWWR &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _DCER &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _DSER &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _DMRG00 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _DMRG01 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _DMRG10 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _DMRG11 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _DMRG12 &&& TRMRD12B,_CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _DREAD &&& TRMRD12B,_CWEE, _TCWEES, _DMY );

  $setuphold ( negedge _WWR &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _CER &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _SER &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _MRG00 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _MRG01 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _MRG10 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _MRG11 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _MRG12 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _READ &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _MSWR &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _EXER &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _IONCHK1 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _CPBT &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _WDT1 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _WDT2 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _WDT3 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _WDT4 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _RDT &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _STCHK &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _RDMRG0 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _RDMRG1 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _RDMRGC &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );

  $setuphold ( negedge _DWWR &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _DCER &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _DSER &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _DMRG00 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _DMRG01 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _DMRG10 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _DMRG11 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _DMRG12 &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );
  $setuphold ( negedge _DREAD &&& TRMRD12B, _CWEE, _DMY, _TCWEEH );

//SENSE AMP REFERENSE TEST
  $setuphold ( negedge _IREFT &&& TRMRD12B, negedge VPPTS1, _DMY, _TVPPH );
  
  $setuphold ( posedge _WWR &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MRG00 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MRG01 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MRG10 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MRG11 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MRG12 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY ); 
  $setuphold ( posedge _READ &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MSWR &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _STCHK &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _RDMRG0 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _RDMRG1 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
 
  $setuphold ( posedge _DWWR &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _DMRG00 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _DMRG01 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _DMRG10 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _DMRG11 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _DMRG12 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _DREAD &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
 
  $setuphold ( negedge _WWR &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _MRG00 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH ); 
  $setuphold ( negedge _MRG01 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _MRG10 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH ); 
  $setuphold ( negedge _MRG11 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH ); 
  $setuphold ( negedge _MRG12 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH ); 
  $setuphold ( negedge _READ &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _MSWR &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _STCHK &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _RDMRG0 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _RDMRG1 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH ); 

  $setuphold ( negedge _DWWR &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _DMRG00 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _DMRG01 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _DMRG10 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _DMRG11 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _DMRG12 &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );
  $setuphold ( negedge _DREAD &&& TRMRD12B, _IREFT, _DMY, _TIREFTH );

//BT-mode
//  $setuphold (negedge _RDCLKC1 &&& btmpBT, posedge _SCANMODE, _TMSbt, _DMY);  // Memory HDL Check
//  $setuphold (negedge _RDCLKC1 &&& btmpBT, posedge _TESDBT, _TMSbt, _DMY);  // Memory HDL Check
//  $setuphold (negedge _DRDCLKC1 &&& btmpBT, posedge _SCANMODE, _TMSbt, _DMY);  // Memory HDL Check
//  $setuphold (negedge _DRDCLKC1 &&& btmpBT, posedge _TESDBT, _TMSbt, _DMY);  // Memory HDL Check

  $width ( negedge _RDCLKC1 &&& btmpBT , _TCLKLhs32 );
  $width ( posedge _RDCLKC1 &&& btmpBT , _TCLKHhs32 );

  $width ( negedge _DRDCLKC1 &&& btmpBT , _TCLKLhs32 );
  $width ( posedge _DRDCLKC1 &&& btmpBT , _TCLKHhs32 );

//SCAN-mode
// NO Check

// VBRESZ=>RESB  v1.01_add
// 100824 CommentOut  $setuphold ( negedge _VBRESZ , negedge _RESB, _DMY, _TVBRESB );

endspecify

`endif  // For FAST FUNC

`else  //## For FPGA_ICE Switch_2

  assign VPPTS1=1'b0;
  assign _VCPHV=1'b1;
  assign _VREGMV=1'b1;
  assign _VREGRMV=1'b1;
  assign _HVPPTS1=1'b0;
  assign _VPBIAS=1'b0;
  assign _OSCOUT=1'b0;

`endif  //## For FPGA_ICE Switch_2

//#######################################################
// Block:CPIL RTL-net
//#######################################################
wire D_DETVCP,D_DETVCPR;
//assign D_DETVCP=1'b0;
assign D_DETVCPR=1'b0;

wire	IL_REGREN,
	IL_REGEN,
	IL_WRITE,
	IL_READ,
	IL_ERASE,
	IL_CPEN,
	IL_CPRB,
	IL_CPENR,
	IL_CPRBR,
	IL_CPWESWEN,
	IL_CPRSWEN,
	IL_CPRGVDB,
	IL_DPRSWEN,
        IL_DPRGVDB,
	IL_WRFCLK,
	IL_ERFCLKSET,
	IL_FIHFL,
	IL_VCPDIS,
	IL_VCPDISR,
	IL_PVDDCPSWEN,
	IL_VPTSW1EN,
	IL_VPTSW2EN,
	IL_VPT1SW1EN,
	IL_IVPPTS1DS,
	IL_VCOMPSWEN,
	IL_VCPVD,
	MD_CPT,
	MD_IREFT,
	MD_RLOWSPY,
	MD_LOWSPY,
        MD_CPINTMRG,
        OSCLFREQ;

wire   [7:0] IL_TRMREGRB;
wire   [7:0] IL_TRMREGWB;
wire   [15:0] IL_TRMCPWB;
wire   [7:0] IL_TRMCPOB;
wire   [7:0] IL_TRMCPRB;
wire   [7:0] IL_TRMWIB;

QNSC3NCP1V2_CPIL QNSC3NCP1V2_CPIL (
 .MEOC (_MEOC ), .WWR (_WWR ),
 .DWWR (_DWWR ), .MSWR (_MSWR ), .CER (_CER ), .DCER (_DCER ),
 .SER (_SER ), .DSER (_DSER ), .EXER (_EXER ), .MRG00 (_MRG00 ),
 .DMRG00 (_DMRG00 ), .MRG01 (_MRG01 ), .DMRG01 (_DMRG01 ), .MRG10 (_MRG10 ),
 .DMRG10 (_DMRG10 ), .MRG11 (_MRG11 ), .DMRG11 (_DMRG11 ), .MRG12 (_MRG12 ),
 .DMRG12 (_DMRG12 ), .DIS (_DIS ), .DDIS (_DDIS ), .READ (_READ ),
 .DREAD (_DREAD ), .IONCHK1 (_IONCHK1 ), .STCHK (_STCHK ), .CPBT (_CPBT ),
 .WDT1 (_WDT1 ), .WDT2 (_WDT2 ), .WDT3 (_WDT3 ), .WDT4 (_WDT4 ),
 .RDT (_RDT ), .RDMRG0 (_RDMRG0 ), .RDMRG1 (_RDMRG1 ), .RDMRGC (_RDMRGC ),
 .EXTVPP1 (_EXTVPP1 ), .EXTVPP2 (_EXTVPP2 ), .CPT (_CPT ), .IREFT (_IREFT ),
 .MEOR (_MEOR ), .FLSTOP (_FLSTOP ), .DFLSTOP (_DFLSTOP ), .VBRESZ (_VBRESZ ),
 .RDCLKC1 (_RDCLKC1 ), .DRDCLKC1 (_DRDCLKC1 ), .RDCLKP1 (_RDCLKP1 ), .CLKSEL1 (_CLKSEL1 ),
 .DCLKSEL1 (_DCLKSEL1 ), .CE (_CE ), .DCE (_DCE ), .CWEE (_CWEE ),
 .SUB (_SUB ), .LOWPOWER (_LOWPOWER ), .HISPEED (_HISPEED ), .RLOWSPY (_RLOWSPY ),
 .LOWSPY (_LOWSPY ), .FCLK1 (_FCLK1 ), .PROGI (_PROGI ), .WED (_WED ),
 .DWED (_DWED ), .POCREL (_POCREL ), .SCANMODE (_SCANMODE ), .TESDBT (_TESDBT ),
 .OSCNOSTP (_OSCNOSTP ), .FIHFL (_FIHFL ), .SRCUT (_SRCUT ), .D_DETVCP (D_DETVCP ),
 .D_DETVCPR (D_DETVCPR ), .TRMCP0 (_TRMCP0 ), .TRMCP1 (_TRMCP1 ), .TRMCP2 (_TRMCP2 ),
 .TRMCP3 (_TRMCP3 ), .TRMCP4 (_TRMCP4 ), .TRMCP5 (_TRMCP5 ), .TRMCP6 (_TRMCP6 ),
 .TRMCP7 (_TRMCP7 ), .TRMCP8 (_TRMCP8 ), .TRMCP9 (_TRMCP9 ), .TRMCP15 (_TRMCP15 ),
 .TRMCP16 (_TRMCP16 ), .TRMCP17 (_TRMCP17 ), .RTRMCP15 (_RTRMCP15 ), .RTRMCP16 (_RTRMCP16 ),
 .RTRMCP17 (_RTRMCP17 ), .RTRMCP18 (_RTRMCP18 ), .RTRMCP19 (_RTRMCP19 ), .RTRMCP20 (_RTRMCP20 ),
 .TRMRD1 (_TRMRD1 ), .TRMRD1CK (_TRMRD1CK ), .TRMRD2 (_TRMRD2 ), .TRMRD2CK (_TRMRD2CK ),
 .REQFL (_REQFL ), .RDSETUP (_RDSETUP ), .REG125ST (_REG125ST ), .SRCUTCP (_SRCUTCP ),
 .IL_REGREN (IL_REGREN ), .IL_REGEN (IL_REGEN ), .IL_WRITE (IL_WRITE ), .IL_READ (IL_READ ),
 .IL_ERASE (IL_ERASE ), .IL_CPEN (IL_CPEN ), .IL_CPRB (IL_CPRB ), .IL_CPENR (IL_CPENR ),
 .IL_CPRBR (IL_CPRBR ), .IL_CPWESWEN (IL_CPWESWEN ), .IL_CPRSWEN (IL_CPRSWEN ), .IL_CPRGVDB (IL_CPRGVDB ),
 .IL_DPRSWEN (IL_DPRSWEN ), .IL_DPRGVDB (IL_DPRGVDB ), .IL_WRFCLK (IL_WRFCLK ),
 .IL_ERFCLKSET (IL_ERFCLKSET ), .IL_FIHFL (IL_FIHFL ), .IL_VCPDIS (IL_VCPDIS ), .IL_VCPDISR (IL_VCPDISR ),
 .VBRESZCP (_VBRESZCP ), .IL_PVDDCPSWEN (IL_PVDDCPSWEN ), .IL_VPTSW1EN (IL_VPTSW1EN ), .IL_VPTSW2EN (IL_VPTSW2EN ),
 .IL_VPT1SW1EN (IL_VPT1SW1EN ), .IL_IVPPTS1DS (IL_IVPPTS1DS ), .IL_VCOMPSWEN (IL_VCOMPSWEN ), .IL_VCPVD (IL_VCPVD ),
 .BG1ST (_BG1ST ), .MD_CPT (MD_CPT ), .MD_IREFT (MD_IREFT ), .MD_RLOWSPY (MD_RLOWSPY ),
 .MD_LOWSPY (MD_LOWSPY ), .IL_TRMREGRB (IL_TRMREGRB ), .IL_TRMREGWB (IL_TRMREGWB ), .IL_TRMCPWB (IL_TRMCPWB ),
 .IL_TRMCPOB (IL_TRMCPOB ), .IL_TRMCPRB (IL_TRMCPRB ), .IL_TRMWIB (IL_TRMWIB ), .MD_CPINTMRG (MD_CPINTMRG ),
 .OSCLFREQ (OSCLFREQ ), .RESB (RESB )
);

`ifndef FPGA_ICE  //## For FPGA_ICE Switch_3

reg detvcp;
parameter DETVCPctrl1 = 3000000;
parameter DETVCPctrl2 = 10000;
assign D_DETVCP = detvcp===1'b0 ? 1'b0: 1'b1;

always @(IL_VCPDIS) begin
  detvcp = 1;
  if (QNSC3NCP1V2_CPIL.IL_VCPDIS) begin
    #DETVCPctrl1 detvcp = 0;
    #DETVCPctrl2 detvcp = 1;
  end
  else detvcp = 1;
end

/*-----REG Function-----*/
assign _FLREGENB = {IL_CPEN,IL_WRITE,IL_ERASE} < 5 ? 1'b1 : 1'b0;

`else  //## For FPGA_ICE Switch_3

  assign D_DETVCP =1'b0;
  assign _FLREGENB =1'b0;

`endif  //## For FPGA_ICE Switch_3

`ifdef QNSXXXX_ASSERT_ON
`include "./ast/sv_file/QNSC3NCP1V2.sv"
`endif

endmodule

`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine

`timescale 1ps / 1ps  // For RTL
///=============================================================================
///CPIL
///  Ver2.00 2010/06/10 Renewal from QNSC3NCP0V1 for MTEG
///          2010/06/23 [CPL0] MD_SRCUT --> Low clamp
///          2010/08/10 1st PinReset --> Low power mode after TRMRD1
///          2010/08/10 REG125ST=high for TESDBT
///          2010/08/24 SRCUT circuit delate
///                     TRMRD3 CP wait 10uS -> 250uS (after POC only)
///          2010/08/31 RLOWSPYC signal add
///          2010/09/01 RLOWSPYC --> RLOWSPYNC
///          2010/09/03 RLOWSPYNC signal deleted
///          2011/03/23 1st POR Reset --> TRMRD1,TRMRD2,CPwait is *2
///
///=============================================================================

module QNSC3NCP1V2_CPIL(
//	VDD,
//	GND,
        RESB,
	MEOC,
	WWR,
	DWWR,
	MSWR,
	CER,
	DCER,
	SER,
	DSER,
	EXER,
	MRG00,
	DMRG00,
	MRG01,
	DMRG01,
	MRG10,
	DMRG10,
	MRG11,
	DMRG11,
	MRG12,
	DMRG12,
	DIS,
	DDIS,
	READ,
	DREAD,
	IONCHK1,
	STCHK,
	CPBT,
	WDT1,
	WDT2,
	WDT3,
	WDT4,
	RDT,
	RDMRG0,
	RDMRG1,
	RDMRGC,
	EXTVPP1,
	EXTVPP2,
	CPT,
	IREFT,
	MEOR,
	FLSTOP,
	DFLSTOP,
	VBRESZ,
	RDCLKC1,
	DRDCLKC1,
	RDCLKP1,
	CLKSEL1,
	DCLKSEL1,
	CE,
	DCE,
	CWEE,
	SUB,
	LOWPOWER,
	HISPEED,
	RLOWSPY,
	LOWSPY,
	FCLK1,
	PROGI,
	WED,
	DWED,
	POCREL,
	SCANMODE,
	TESDBT,
	OSCNOSTP,
	FIHFL,
	SRCUT,
	D_DETVCP,
	D_DETVCPR,
	TRMCP0,
	TRMCP1,
	TRMCP2,
	TRMCP3,
	TRMCP4,
	TRMCP5,
	TRMCP6,
	TRMCP7,
	TRMCP8,
	TRMCP9,
	TRMCP15,
	TRMCP16,
	TRMCP17,
	RTRMCP15,
	RTRMCP16,
	RTRMCP17,
	RTRMCP18,
	RTRMCP19,
	RTRMCP20,
	TRMRD1,
	TRMRD1CK,
	TRMRD2,
	TRMRD2CK,
	REQFL,
	RDSETUP,
	REG125ST,
	SRCUTCP,
	IL_REGREN,
	IL_REGEN,
	IL_WRITE,
	IL_READ,
	IL_ERASE,
	IL_CPEN,
	IL_CPRB,
	IL_CPENR,
	IL_CPRBR,
	IL_CPWESWEN,
	IL_CPRSWEN,
	IL_CPRGVDB,
	IL_DPRSWEN,
	IL_DPRGVDB,
	IL_WRFCLK,
	IL_ERFCLKSET,
	IL_FIHFL,
	IL_VCPDIS,
	IL_VCPDISR,
	VBRESZCP,
	IL_PVDDCPSWEN,
	IL_VPTSW1EN,
	IL_VPTSW2EN,
	IL_VPT1SW1EN,
	IL_IVPPTS1DS,
	IL_VCOMPSWEN,
	IL_VCPVD,
	BG1ST,
	MD_CPT,
	MD_IREFT,
	MD_RLOWSPY,
	MD_LOWSPY,
	IL_TRMREGRB,
	IL_TRMREGWB,
	IL_TRMCPWB,
	IL_TRMCPOB,
	IL_TRMCPRB,
	IL_TRMWIB,
	MD_CPINTMRG,
        OSCLFREQ
);

input   RESB,
	MEOC,
//	VDD,
//	GND,
	WWR,
	DWWR,
	MSWR,
	CER,
	DCER,
	SER,
	DSER,
	EXER,
	MRG00,
	DMRG00,
	MRG01,
	DMRG01,
	MRG10,
	DMRG10,
	MRG11,
	DMRG11,
	MRG12,
	DMRG12,
	DIS,
	DDIS,
	READ,
	DREAD,
	IONCHK1,
	STCHK,
	CPBT,
	WDT1,
	WDT2,
	WDT3,
	WDT4,
	RDT,
	RDMRG0,
	RDMRG1,
	RDMRGC,
	EXTVPP1,
	EXTVPP2,
	CPT,
	IREFT,
	MEOR,
	FLSTOP,
	DFLSTOP,
	VBRESZ,
	RDCLKC1,
	DRDCLKC1,
	RDCLKP1,
	CLKSEL1,
	DCLKSEL1,
	CE,
	DCE,
	CWEE,
	SUB,
	LOWPOWER,
	HISPEED,
	RLOWSPY,
	LOWSPY,
	FCLK1,
	PROGI,
	WED,
	DWED,
	POCREL,
	SCANMODE,
	TESDBT,
	OSCNOSTP,
	FIHFL,
	SRCUT,
	D_DETVCP,
	D_DETVCPR,
	TRMCP0,
	TRMCP1,
	TRMCP2,
	TRMCP3,
	TRMCP4,
	TRMCP5,
	TRMCP6,
	TRMCP7,
	TRMCP8,
	TRMCP9,
	TRMCP15,
	TRMCP16,
	TRMCP17,
	RTRMCP15,
	RTRMCP16,
	RTRMCP17,
	RTRMCP18,
	RTRMCP19,
	RTRMCP20;

output	TRMRD1,
	TRMRD1CK,
	TRMRD2,
	TRMRD2CK,
	REQFL,
	RDSETUP,
	REG125ST,
	SRCUTCP,
	IL_REGREN,
	IL_REGEN,
	IL_WRITE,
	IL_READ,
	IL_ERASE,
	IL_CPEN,
	IL_CPRB,
	IL_CPENR,
	IL_CPRBR,
	IL_CPWESWEN,
	IL_CPRSWEN,
	IL_CPRGVDB,
	IL_DPRSWEN,
	IL_DPRGVDB,
	IL_WRFCLK,
	IL_ERFCLKSET,
	IL_FIHFL,
	IL_VCPDIS,
	IL_VCPDISR,
	VBRESZCP,
	IL_PVDDCPSWEN,
	IL_VPTSW1EN,
	IL_VPTSW2EN,
	IL_VPT1SW1EN,
	IL_IVPPTS1DS,
	IL_VCOMPSWEN,
	IL_VCPVD,
	BG1ST,
	MD_CPT,
	MD_IREFT,
	MD_RLOWSPY,
	MD_LOWSPY,
	MD_CPINTMRG;
output [7:0] IL_TRMREGRB;
output [7:0] IL_TRMREGWB;
output [15:0] IL_TRMCPWB;
output [7:0] IL_TRMCPOB;
output [7:0] IL_TRMCPRB;
output [7:0] IL_TRMWIB;

output OSCLFREQ;


// ---- internal ----
wire MD_WWR,   MD_DWWR;
wire MD_MSWR,  MD_DMSWR;
wire MD_CER,   MD_DCER;
wire MD_SER,   MD_DSER;
wire MD_EXER,  MD_DEXER;
wire MD_MRG00, MD_DMRG00;
wire MD_MRG01, MD_DMRG01;
wire MD_MRG10, MD_DMRG10;
wire MD_MRG11, MD_DMRG11;
wire MD_MRG12, MD_DMRG12;
wire MD_DIS,   MD_DDIS;
wire MD_READ,  MD_DREAD;
wire MD_IONCHK1, MD_DIONCHK1;
wire MD_STCHK,   MD_DSTCHK;
wire MD_CPBT,    MD_DCPBT;
wire MD_WDT1,    MD_DWDT1;
wire MD_WDT2,    MD_DWDT2;
wire MD_WDT3,    MD_DWDT3;
wire MD_WDT4,    MD_DWDT4;
wire MD_RDT,     MD_DRDT;
wire MD_RDMRG0,  MD_DRDMRG0;
wire MD_RDMRG1,  MD_DRDMRG1;
wire MD_RDMRGC,  MD_DRDMRGC;
wire MD_EXTVPP1;
wire MD_EXTVPP2;
wire MD_HISPEED;
wire MD_LOWPOWER;
wire MD_SUB;
wire ICWEE;
wire MD_CWEE;
wire MD_FCLK1;
wire MD_FLSTOP, MD_DFLSTOP;
wire MD_MEOC;
wire MD_SRCUT;
wire MD_OSCNOSTP;
wire MD_PROGI;
wire MD_TRMREAD12;
wire IL_VCPDWNL;
wire trmrd1_internal;
wire reset_seq;
wire IL_FIHFL4M;
wire IWRITE;
wire IERASE;
wire IL_VCPDWNLR;




// New VBRESZ for SCAN test
wire VBRESZSCAN;
assign VBRESZSCAN = VBRESZ | SCANMODE;


// input buffer
wire IN_SRCUT;
TBBUFX1 BUF_SRCUT ( .H01(SRCUT), .N01(IN_SRCUT) );




      QNSC3NCP1V2_CPMD cpmd (
		.MD_WWR(MD_WWR),
		.MD_DWWR(MD_DWWR),
		.MD_MSWR(MD_MSWR),
		.MD_DMSWR(MD_DMSWR),
		.MD_CER(MD_CER),
		.MD_DCER(MD_DCER),
		.MD_SER(MD_SER),
		.MD_DSER(MD_DSER),
		.MD_EXER(MD_EXER),
		.MD_DEXER(MD_DEXER),
		.MD_MRG00(MD_MRG00),
		.MD_DMRG00(MD_DMRG00),
		.MD_MRG01(MD_MRG01),
		.MD_DMRG01(MD_DMRG01),
		.MD_MRG10(MD_MRG10),
		.MD_DMRG10(MD_DMRG10),
		.MD_MRG11(MD_MRG11),
		.MD_DMRG11(MD_DMRG11),
		.MD_MRG12(MD_MRG12),
		.MD_DMRG12(MD_DMRG12),
		.MD_DIS(MD_DIS),
		.MD_DDIS(MD_DDIS),
		.MD_READ(MD_READ),
		.MD_DREAD(MD_DREAD),
		.MD_IONCHK1(MD_IONCHK1),
		.MD_DIONCHK1(MD_DIONCHK1),
		.MD_STCHK(MD_STCHK),
		.MD_DSTCHK(MD_DSTCHK),
		.MD_CPBT(MD_CPBT),
		.MD_DCPBT(MD_DCPBT),
		.MD_WDT1(MD_WDT1),
		.MD_DWDT1(MD_DWDT1),
		.MD_WDT2(MD_WDT2),
		.MD_DWDT2(MD_DWDT2),
		.MD_WDT3(MD_WDT3),
		.MD_DWDT3(MD_DWDT3),
		.MD_WDT4(MD_WDT4),
		.MD_DWDT4(MD_DWDT4),
		.MD_RDT(MD_RDT),
		.MD_DRDT(MD_DRDT),
		.MD_RDMRG0(MD_RDMRG0),
		.MD_DRDMRG0(MD_DRDMRG0),
		.MD_RDMRG1(MD_RDMRG1),
		.MD_DRDMRG1(MD_DRDMRG1),
		.MD_RDMRGC(MD_RDMRGC),
		.MD_DRDMRGC(MD_DRDMRGC),
		.MD_EXTVPP1(MD_EXTVPP1),
		.MD_EXTVPP2(MD_EXTVPP2),
		.MD_CPT(MD_CPT),
		.MD_IREFT(MD_IREFT),
		.MD_HISPEED(MD_HISPEED),
		.MD_RLOWSPY(MD_RLOWSPY),
		.MD_LOWPOWER(MD_LOWPOWER),
		.MD_SUB(MD_SUB),
                .ICWEE(ICWEE),
		.MD_CWEE(MD_CWEE),
		.MD_FCLK1(MD_FCLK1),
		.MD_FLSTOP(MD_FLSTOP),
		.MD_DFLSTOP(MD_DFLSTOP),
		.MD_MEOC(MD_MEOC),
		.MD_SRCUT(MD_SRCUT),
		.MD_OSCNOSTP(MD_OSCNOSTP),
		.REG125ST(REG125ST),
		.MD_PROGI(MD_PROGI),
		.MD_TRMREAD12(MD_TRMREAD12),
		.MD_LOWSPY(MD_LOWSPY),
		.RDCLKP1(RDCLKP1),
		.RDCLKC1(RDCLKC1),
		.DRDCLKC1(DRDCLKC1),
		.CLKSEL1(CLKSEL1),
		.DCLKSEL1(DCLKSEL1),
		.CE(CE),
		.DCE(DCE),
		.VBRESZ(VBRESZSCAN),    // VBRESZSCAN
		.HISPEED(HISPEED),
		.RLOWSPY(RLOWSPY),
		.LOWPOWER(LOWPOWER),
		.SUB(SUB),
		.SCANMODE(SCANMODE),
		.TESDBT(TESDBT),
		.TRMRD2(TRMRD2),
		.MSWR(MSWR),
		.EXER(EXER),
		.IONCHK1(IONCHK1),
		.STCHK(STCHK),
		.CPBT(CPBT),
		.WDT1(WDT1),
		.WDT2(WDT2),
		.WDT3(WDT3),
		.WDT4(WDT4),
		.RDT(RDT),
		.RDMRG0(RDMRG0),
		.RDMRG1(RDMRG1),
		.RDMRGC(RDMRGC),
		.EXTVPP1(EXTVPP1),
		.EXTVPP2(EXTVPP2),
		.CPT(CPT),
		.IREFT(IREFT),
		.WWR(WWR),
		.DWWR(DWWR),
		.CER(CER),
		.DCER(DCER),
		.SER(SER),
		.DSER(DSER),
		.MRG00(MRG00),
		.DMRG00(DMRG00),
		.MRG01(MRG01),
		.DMRG01(DMRG01),
		.MRG10(MRG10),
		.DMRG10(DMRG10),
		.MRG11(MRG11),
		.DMRG11(DMRG11),
		.MRG12(MRG12),
		.DMRG12(DMRG12),
		.DIS(DIS),
		.DDIS(DDIS),
		.READ(READ),
		.DREAD(DREAD),
		.CWEE(CWEE),
		.FCLK1(FCLK1),
		.FLSTOP(FLSTOP),
		.DFLSTOP(DFLSTOP),
		.MEOC(MEOC),
		.SRCUT(IN_SRCUT),    // SRCUT --> IN_SRCUT
		.OSCNOSTP(OSCNOSTP),
		.MEOR(MEOR),
		.PROGI(PROGI),
		.WED(WED),
		.DWED(DWED),
		.LOWSPY(LOWSPY),
		.IL_VCPDWNL(IL_VCPDWNL),
		.trmrd1_internal(trmrd1_internal),
		.reset_seq(reset_seq),
		.VBRESZCP(VBRESZCP),
		.MD_CPINTMRG(MD_CPINTMRG));

      QNSC3NCP1V2_CPL0 cpl0 (
                .RESB(RESB),
		.TRMRD1(TRMRD1),
		.TRMRD1CK(TRMRD1CK),
		.trmrd1_internal(trmrd1_internal),
		.TRMRD2(TRMRD2),
		.TRMRD2CK(TRMRD2CK),
		.reset_seq(reset_seq),
		.REQFL(REQFL),
		.RDSETUP(RDSETUP),
		.SRCUTCP(SRCUTCP),
		.IL_ERFCLKSET(IL_ERFCLKSET),
		.IL_FIHFL(IL_FIHFL),
		.IL_FIHFL4M(IL_FIHFL4M),
		.VBRESZ(VBRESZSCAN),         // VBRESZSCAN
		.POCREL(POCREL),
		.FIHFL(FIHFL),
		.MD_HISPEED(MD_HISPEED),
		.MD_RLOWSPY(MD_RLOWSPY),
		.MD_LOWPOWER(MD_LOWPOWER),
		.MD_SUB(MD_SUB),
//		.MD_SRCUT(1'b0),            // MD_SRCUT --> Low	-> delate 2010/08/24
		.MD_FLSTOP(MD_FLSTOP),
		.MD_SER(MD_SER),
		.MD_DSER(MD_DSER),
		.MD_CER(MD_CER),
		.MD_DCER(MD_DCER),
		.MD_EXER(MD_EXER),
		.MD_DEXER(MD_DEXER),
		.MD_FCLK1(MD_FCLK1),
		.MD_IONCHK1(MD_IONCHK1),
		.MD_DIONCHK1(MD_DIONCHK1),
		.MD_RDMRG0(MD_RDMRG0),
		.MD_DRDMRG0(MD_DRDMRG0),
		.MD_RDMRG1(MD_RDMRG1),
		.MD_DRDMRG1(MD_DRDMRG1),
		.MD_RDMRGC(MD_RDMRGC),
		.MD_DRDMRGC(MD_DRDMRGC),
		.MD_MRG00(MD_MRG00),
		.MD_DMRG00(MD_DMRG00),
		.MD_MRG01(MD_MRG01),
		.MD_DMRG01(MD_DMRG01),
		.MD_MRG10(MD_MRG10),
		.MD_DMRG10(MD_DMRG10),
		.MD_MRG11(MD_MRG11),
		.MD_DMRG11(MD_DMRG11),
		.MD_MRG12(MD_MRG12),
		.MD_DMRG12(MD_DMRG12),
		.MD_READ(MD_READ),
		.MD_DREAD(MD_DREAD),
//		.MD_DDIS(MD_DDIS),
		.MD_EXTVPP1(MD_EXTVPP1),
		.MD_CPT(MD_CPT),
		.MD_IREFT(MD_IREFT),
		.MD_DFLSTOP(MD_DFLSTOP),
		.IL_VCPDIS(IL_VCPDIS),
		.IL_ERASE(IL_ERASE),
		.IL_WRITE(IL_WRITE),
		.BG1ST(BG1ST),
		.REG125ST(REG125ST));

      QNSC3NCP1V2_CPL1 cpl1 (
		.IL_REGREN(IL_REGREN),
		.IL_TRMREGRB(IL_TRMREGRB),
		.RTRMCP15(RTRMCP15),
		.RTRMCP16(RTRMCP16),
		.RTRMCP17(RTRMCP17),
		.MD_IONCHK1(MD_IONCHK1),
		.MD_DIONCHK1(MD_DIONCHK1),
		.MD_STCHK(MD_STCHK),
		.MD_DSTCHK(MD_DSTCHK),
		.MD_RDT(MD_RDT),
		.MD_DRDT(MD_DRDT),
		.MD_RDMRG0(MD_RDMRG0),
		.MD_DRDMRG0(MD_DRDMRG0),
		.MD_RDMRG1(MD_RDMRG1),
		.MD_DRDMRG1(MD_DRDMRG1),
		.MD_RDMRGC(MD_RDMRGC),
		.MD_DRDMRGC(MD_DRDMRGC),
		.MD_EXTVPP1(MD_EXTVPP1),
		.MD_CPT(MD_CPT),
		.MD_IREFT(MD_IREFT),
		.MD_CWEE(MD_CWEE),
		.MD_HISPEED(MD_HISPEED),
		.MD_SUB(MD_SUB),
		.MD_WWR(MD_WWR),
		.MD_CER(MD_CER),
		.MD_SER(MD_SER),
		.MD_MRG00(MD_MRG00),
		.MD_MRG01(MD_MRG01),
		.MD_MRG10(MD_MRG10),
		.MD_MRG11(MD_MRG11),
		.MD_MRG12(MD_MRG12),
		.MD_DIS(MD_DIS),
		.MD_READ(MD_READ),
		.MD_DWWR(MD_DWWR),
		.MD_DCER(MD_DCER),
		.MD_DSER(MD_DSER),
		.MD_DMRG00(MD_DMRG00),
		.MD_DMRG01(MD_DMRG01),
		.MD_DMRG10(MD_DMRG10),
		.MD_DMRG11(MD_DMRG11),
		.MD_DMRG12(MD_DMRG12),
		.MD_DDIS(MD_DDIS),
		.MD_DREAD(MD_DREAD),
		.MD_FLSTOP(MD_FLSTOP),
		.MD_DFLSTOP(MD_DFLSTOP),
		.SCANMODE(SCANMODE),
		.TESDBT(TESDBT));

      QNSC3NCP1V2_CPL2 cpl2 (
		.IL_REGEN(IL_REGEN),
		.IL_WRITE(IL_WRITE),
		.IWRITE(IWRITE),
		.IL_TRMREGWB(IL_TRMREGWB),
		.TRMCP15(TRMCP15),
		.TRMCP16(TRMCP16),
		.TRMCP17(TRMCP17),
		.MD_MSWR(MD_MSWR),
		.MD_DMSWR(MD_DMSWR),
		.MD_IONCHK1(MD_IONCHK1),
		.MD_DIONCHK1(MD_DIONCHK1),
		.MD_STCHK(MD_STCHK),
		.MD_DSTCHK(MD_DSTCHK),
		.MD_WDT1(MD_WDT1),
		.MD_DWDT1(MD_DWDT1),
		.MD_WDT2(MD_WDT2),
		.MD_DWDT2(MD_DWDT2),
		.MD_WDT3(MD_WDT3),
		.MD_DWDT3(MD_DWDT3),
		.MD_WDT4(MD_WDT4),
		.MD_DWDT4(MD_DWDT4),
		.MD_RDT(MD_RDT),
		.MD_RDMRG0(MD_RDMRG0),
		.MD_DRDMRG0(MD_DRDMRG0),
		.MD_RDMRG1(MD_RDMRG1),
		.MD_DRDMRG1(MD_DRDMRG1),
		.MD_RDMRGC(MD_RDMRGC),
		.MD_DRDMRGC(MD_DRDMRGC),
		.MD_EXTVPP1(MD_EXTVPP1),
		.MD_EXTVPP2(MD_EXTVPP2),
		.MD_CPT(MD_CPT),
		.MD_IREFT(MD_IREFT),
		.MD_CWEE(MD_CWEE),
		.MD_HISPEED(MD_HISPEED),
		.MD_SUB(MD_SUB),
		.MD_PROGI(MD_PROGI),
		.SCANMODE(SCANMODE),
		.TESDBT(TESDBT),
		.MD_WWR(MD_WWR),
		.MD_DIS(MD_DIS),
		.MD_READ(MD_READ),
		.MD_DWWR(MD_DWWR),
		.MD_DDIS(MD_DDIS),
		.MD_DREAD(MD_DREAD),
		.MD_FLSTOP(MD_FLSTOP),
		.MD_DFLSTOP(MD_DFLSTOP),
		.IL_VCPDWNL(IL_VCPDWNL)
//              ,
//		.IL_CPEN(IL_CPEN)
              );

      QNSC3NCP1V2_CPL3 cpl3 (
		.IL_CPRB(IL_CPRB),
		.IL_CPEN(IL_CPEN),
		.IERASE(IERASE),
		.IL_ERASE(IL_ERASE),
		.IL_READ(IL_READ),
		.IL_TRMCPWB(IL_TRMCPWB),
		.IL_CPWESWEN(IL_CPWESWEN),
		.IL_CPRSWEN(IL_CPRSWEN),
		.IL_CPRGVDB(IL_CPRGVDB),
		.IL_DPRSWEN(IL_DPRSWEN),
		.IL_DPRGVDB(IL_DPRGVDB),
		.MD_MSWR(MD_MSWR),
		.MD_DMSWR(MD_DMSWR),
		.MD_EXER(MD_EXER),
		.MD_DEXER(MD_DEXER),
		.MD_IONCHK1(MD_IONCHK1),
		.MD_DIONCHK1(MD_DIONCHK1),
		.MD_CPBT(MD_CPBT),
		.MD_DCPBT(MD_DCPBT),
		.MD_WDT1(MD_WDT1),
		.MD_DWDT1(MD_DWDT1),
		.MD_WDT2(MD_WDT2),
		.MD_DWDT2(MD_DWDT2),
		.MD_WDT3(MD_WDT3),
		.MD_DWDT3(MD_DWDT3),
		.MD_WDT4(MD_WDT4),
		.MD_DWDT4(MD_DWDT4),
		.MD_RDMRG0(MD_RDMRG0),
		.MD_DRDMRG0(MD_DRDMRG0),
		.MD_RDMRG1(MD_RDMRG1),
		.MD_DRDMRG1(MD_DRDMRG1),
		.MD_RDMRGC(MD_RDMRGC),
		.MD_DRDMRGC(MD_DRDMRGC),
		.MD_WWR(MD_WWR),
		.MD_DWWR(MD_DWWR),
		.MD_STCHK(MD_STCHK),
		.MD_DSTCHK(MD_DSTCHK),
		.MD_RDT(MD_RDT),
		.MD_DRDT(MD_DRDT),
		.MD_CER(MD_CER),
		.MD_DCER(MD_DCER),
		.MD_SER(MD_SER),
		.MD_DSER(MD_DSER),
		.MD_MRG00(MD_MRG00),
		.MD_DMRG00(MD_DMRG00),
		.MD_MRG01(MD_MRG01),
		.MD_DMRG01(MD_DMRG01),
		.MD_MRG10(MD_MRG10),
		.MD_DMRG10(MD_DMRG10),
		.MD_MRG11(MD_MRG11),
		.MD_DMRG11(MD_DMRG11),
		.MD_MRG12(MD_MRG12),
		.MD_DMRG12(MD_DMRG12),
		.MD_READ(MD_READ),
		.MD_DREAD(MD_DREAD),
		.MD_DIS(MD_DIS),
		.MD_DDIS(MD_DDIS),
		.MD_FLSTOP(MD_FLSTOP),
		.MD_DFLSTOP(MD_DFLSTOP),
		.MD_MEOC(MD_MEOC),
		.SCANMODE(SCANMODE),
		.TESDBT(TESDBT),
		.MD_EXTVPP1(MD_EXTVPP1),
		.MD_EXTVPP2(MD_EXTVPP2),
		.MD_CPT(MD_CPT),
		.MD_IREFT(MD_IREFT),
		.MD_CWEE(MD_CWEE),
                .MD_HISPEED(MD_HISPEED),
		.MD_RLOWSPY(MD_RLOWSPY),
		.MD_SUB(MD_SUB),
		.MD_FCLK1(MD_FCLK1),
		.MD_PROGI(MD_PROGI),
		.MD_OSCNOSTP(MD_OSCNOSTP),
		.IWRITE(IWRITE),
		.IL_WRITE(IL_WRITE),
		.IL_VCPDWNL(IL_VCPDWNL),
		.IL_CPENR(IL_CPENR),
		.IL_REGREN(IL_REGREN),
		.IL_VCPDISR(IL_VCPDISR),
		.TRMCP0(TRMCP0),
		.TRMCP1(TRMCP1),
		.TRMCP2(TRMCP2),
		.TRMCP3(TRMCP3),
		.MD_TRMREAD12(MD_TRMREAD12),
                .OSCLFREQ(OSCLFREQ)
        );

      QNSC3NCP1V2_CPL4 cpl4 (
		.IL_CPRBR(IL_CPRBR),
		.IL_CPENR(IL_CPENR),
		.IL_WRFCLK(IL_WRFCLK),
		.IL_TRMCPRB(IL_TRMCPRB),
		.IL_TRMCPOB(IL_TRMCPOB),
		.MD_IONCHK1(MD_IONCHK1),
		.MD_DIONCHK1(MD_DIONCHK1),
//		.MD_CPBT(MD_CPBT),
//		.MD_DCPBT(MD_DCPBT),
		.MD_RDMRG0(MD_RDMRG0),
		.MD_DRDMRG0(MD_DRDMRG0),
		.MD_RDMRG1(MD_RDMRG1),
		.MD_DRDMRG1(MD_DRDMRG1),
		.MD_RDMRGC(MD_RDMRGC),
		.MD_DRDMRGC(MD_DRDMRGC),
		.MD_WWR(MD_WWR),
		.MD_DWWR(MD_DWWR),
//		.MD_CER(MD_CER),
//		.MD_DCER(MD_DCER),
//		.MD_SER(MD_SER),
//		.MD_DSER(MD_DSER),
//		.MD_MRG00(MD_MRG00),
//		.MD_DMRG00(MD_DMRG00),
//		.MD_MRG01(MD_MRG01),
//		.MD_DMRG01(MD_DMRG01),
//		.MD_MRG10(MD_MRG10),
//		.MD_DMRG10(MD_DMRG10),
//		.MD_MRG11(MD_MRG11),
//		.MD_DMRG11(MD_DMRG11),
//		.MD_MRG12(MD_MRG12),
//		.MD_DMRG12(MD_DMRG12),
		.MD_MSWR(MD_MSWR),
		.MD_DMSWR(MD_DMSWR),
		.MD_WDT1(MD_WDT1),
		.MD_DWDT1(MD_DWDT1),
		.MD_WDT2(MD_WDT2),
		.MD_DWDT2(MD_DWDT2),
		.MD_WDT3(MD_WDT3),
		.MD_DWDT3(MD_DWDT3),
		.MD_WDT4(MD_WDT4),
		.MD_DWDT4(MD_DWDT4),
		.MD_FCLK1(MD_FCLK1),
		.MD_READ(MD_READ),
		.MD_DREAD(MD_DREAD),
		.MD_DIS(MD_DIS),
		.MD_DDIS(MD_DDIS),
		.MD_FLSTOP(MD_FLSTOP),
		.MD_DFLSTOP(MD_DFLSTOP),
		.MD_EXTVPP1(MD_EXTVPP1),
		.MD_EXTVPP2(MD_EXTVPP2),
		.MD_CPT(MD_CPT),
		.MD_IREFT(MD_IREFT),
		.MD_CWEE(MD_CWEE),
		.MD_RLOWSPY(MD_RLOWSPY),
		.MD_SUB(MD_SUB),
		.RTRMCP18(RTRMCP18),
		.RTRMCP19(RTRMCP19),
		.RTRMCP20(RTRMCP20),
		.TRMCP4(TRMCP4),
		.TRMCP5(TRMCP5),
		.TRMCP6(TRMCP6),
		.MD_TRMREAD12(MD_TRMREAD12));

      QNSC3NCP1V2_CPL5 cpl5 (
                .IL_ERASE(IL_ERASE),
		.IL_VCPDIS(IL_VCPDIS),
		.IL_VCPDISR(IL_VCPDISR),
		.IL_VCPDWNL(IL_VCPDWNL),
		.IL_VCPDWNLR(IL_VCPDWNLR),
		.VBRESZCP(VBRESZCP),
		.MD_DIS(MD_DIS),
		.MD_DDIS(MD_DDIS),
		.MD_READ(MD_READ),
		.MD_DREAD(MD_DREAD),
		.MD_CER(MD_CER),
		.MD_DCER(MD_DCER),
		.MD_SER(MD_SER),
		.MD_DSER(MD_DSER),
		.MD_EXER(MD_EXER),
		.MD_DEXER(MD_DEXER),
		.MD_CWEE(MD_CWEE),
		.ICWEE(ICWEE),
		.D_DETVCP(D_DETVCP),
		.D_DETVCPR(D_DETVCPR),
		.MD_FLSTOP(MD_FLSTOP),
		.MD_DFLSTOP(MD_DFLSTOP),
		.MD_EXTVPP1(MD_EXTVPP1),
		.MD_CPT(MD_CPT),
		.MD_RLOWSPY(MD_RLOWSPY),
		.MD_SUB(MD_SUB),
		.MD_HISPEED(MD_HISPEED),
		.MD_FCLK1(MD_FCLK1),
		.TRMRD2(TRMRD2),
		.IL_FIHFL4M(IL_FIHFL4M),
		.VBRESZ(VBRESZSCAN));       // VBRESZSCAN

      QNSC3NCP1V2_CPL6 cpl6 (
		.TRMCP7(TRMCP7),
		.TRMCP8(TRMCP8),
		.TRMCP9(TRMCP9),
		.IL_TRMWIB(IL_TRMWIB));


        wire IL_VCPVD_PRE;
        assign IL_VCPVD = IL_VCPVD_PRE & ~IL_VCPDIS;

      QNSC3NCP1V2_CPL7 cpl7 (
		.IL_PVDDCPSWEN(IL_PVDDCPSWEN),
		.IL_VPTSW1EN(IL_VPTSW1EN),
		.IL_VPTSW2EN(IL_VPTSW2EN),
		.IL_VPT1SW1EN(IL_VPT1SW1EN),
		.IL_IVPPTS1DS(IL_IVPPTS1DS),
		.IL_VCOMPSWEN(IL_VCOMPSWEN),
		.IL_VCPVD(IL_VCPVD_PRE),       // IL_VCPVD_PRE
		.MD_IONCHK1(MD_IONCHK1),
		.MD_DIONCHK1(MD_DIONCHK1),
		.MD_STCHK(MD_STCHK),
		.MD_DSTCHK(MD_DSTCHK),
		.MD_WDT1(MD_WDT1),
		.MD_DWDT1(MD_DWDT1),
		.MD_WDT2(MD_WDT2),
		.MD_DWDT2(MD_DWDT2),
		.MD_WDT3(MD_WDT3),
		.MD_DWDT3(MD_DWDT3),
		.MD_WDT4(MD_WDT4),
		.MD_DWDT4(MD_DWDT4),
		.MD_RDT(MD_RDT),
		.MD_DRDT(MD_DRDT),
		.MD_EXER(MD_EXER),
		.MD_DEXER(MD_DEXER),
		.MD_MSWR(MD_MSWR),
		.MD_DMSWR(MD_DMSWR),
		.MD_CPBT(MD_CPBT),
		.MD_DCPBT(MD_DCPBT),
		.MD_CER(MD_CER),
		.MD_DCER(MD_DCER),
		.MD_SER(MD_SER),
		.MD_DSER(MD_DSER),
		.MD_MRG00(MD_MRG00),
		.MD_DMRG00(MD_DMRG00),
		.MD_MRG01(MD_MRG01),
		.MD_DMRG01(MD_DMRG01),
		.MD_MRG10(MD_MRG10),
		.MD_DMRG10(MD_DMRG10),
		.MD_MRG11(MD_MRG11),
		.MD_DMRG11(MD_DMRG11),
		.MD_MRG12(MD_MRG12),
		.MD_DMRG12(MD_DMRG12),
		.MD_RDMRG0(MD_RDMRG0),
		.MD_DRDMRG0(MD_DRDMRG0),
		.MD_RDMRG1(MD_RDMRG1),
		.MD_DRDMRG1(MD_DRDMRG1),
		.MD_RDMRGC(MD_RDMRGC),
		.MD_DRDMRGC(MD_DRDMRGC),
		.MD_EXTVPP1(MD_EXTVPP1),
		.MD_EXTVPP2(MD_EXTVPP2),
		.MD_CPT(MD_CPT),
		.MD_IREFT(MD_IREFT),
		.MD_CWEE(MD_CWEE),
		.SCANMODE(SCANMODE),
		.TESDBT(TESDBT),
		.MD_WWR(MD_WWR),
		.MD_DWWR(MD_DWWR),
		.MD_READ(MD_READ),
		.MD_DREAD(MD_DREAD),
		.MD_DIS(MD_DIS),
		.MD_DDIS(MD_DDIS),
		.MD_FLSTOP(MD_FLSTOP),
		.MD_DFLSTOP(MD_DFLSTOP),
		.trmrd1_internal(trmrd1_internal),
		.TRMRD2(TRMRD2),
		.MD_MEOC(MD_MEOC),
		.MD_OSCNOSTP(MD_OSCNOSTP),
		.IL_VCPDWNL(IL_VCPDWNL),
//		.MD_PROGI(MD_PROGI),
		.IWRITE(IWRITE),
		.IL_WRITE(IL_WRITE),
		.IERASE(IERASE),
		.IL_ERASE(IL_ERASE),
		.MD_FCLK1(MD_FCLK1),
                .MD_HISPEED(MD_HISPEED),
                .MD_RLOWSPY(MD_RLOWSPY),
                .MD_SUB(MD_SUB)
             );

	QNSC3NCP1V2_CPDMY CPDMY();

endmodule

///=============================================================================
///CPMD mode logic
///  Ver2.00 2010/06/10 Renewal from QNSC3NCP0V1 for MTEG
///
///=============================================================================

module QNSC3NCP1V2_CPMD (
	MD_WWR,
	MD_DWWR,
	MD_MSWR,
	MD_DMSWR,
	MD_CER,
	MD_DCER,
	MD_SER,
	MD_DSER,
	MD_EXER,
	MD_DEXER,
	MD_MRG00,
	MD_DMRG00,
	MD_MRG01,
	MD_DMRG01,
	MD_MRG10,
	MD_DMRG10,
	MD_MRG11,
	MD_DMRG11,
	MD_MRG12,
	MD_DMRG12,
	MD_DIS,
	MD_DDIS,
	MD_READ,
	MD_DREAD,
	MD_IONCHK1,
	MD_DIONCHK1,
	MD_STCHK,
	MD_DSTCHK,
	MD_CPBT,
	MD_DCPBT,
	MD_WDT1,
	MD_DWDT1,
	MD_WDT2,
	MD_DWDT2,
	MD_WDT3,
	MD_DWDT3,
	MD_WDT4,
	MD_DWDT4,
	MD_RDT,
	MD_DRDT,
	MD_RDMRG0,
	MD_DRDMRG0,
	MD_RDMRG1,
	MD_DRDMRG1,
	MD_RDMRGC,
	MD_DRDMRGC,
	MD_EXTVPP1,
	MD_EXTVPP2,
	MD_CPT,
	MD_IREFT,
	MD_HISPEED,
	MD_RLOWSPY,
	MD_LOWPOWER,
	MD_SUB,
        ICWEE,
	MD_CWEE,
	MD_FCLK1,
	MD_FLSTOP,
	MD_DFLSTOP,
	MD_MEOC,
	MD_SRCUT,
	MD_OSCNOSTP,
	REG125ST,
	MD_PROGI,
	MD_TRMREAD12,
	MD_LOWSPY,
	RDCLKP1,
	RDCLKC1,
	DRDCLKC1,
	CLKSEL1,
	DCLKSEL1,
	CE,
	DCE,
	VBRESZ,
	HISPEED,
	RLOWSPY,
	LOWPOWER,
	SUB,
	SCANMODE,
	TESDBT,
	TRMRD2,
	MSWR,
	EXER,
	IONCHK1,
	STCHK,
	CPBT,
	WDT1,
	WDT2,
	WDT3,
	WDT4,
	RDT,
	RDMRG0,
	RDMRG1,
	RDMRGC,
	EXTVPP1,
	EXTVPP2,
	CPT,
	IREFT,
	WWR,
	DWWR,
	CER,
	DCER,
	SER,
	DSER,
	MRG00,
	DMRG00,
	MRG01,
	DMRG01,
	MRG10,
	DMRG10,
	MRG11,
	DMRG11,
	MRG12,
	DMRG12,
	DIS,
	DDIS,
	READ,
	DREAD,
	CWEE,
	FCLK1,
	FLSTOP,
	DFLSTOP,
	MEOC,
	SRCUT,
	OSCNOSTP,
	MEOR,
	PROGI,
	WED,
	DWED,
	LOWSPY,
	IL_VCPDWNL,
//	IL_VCPDWNLR,
	trmrd1_internal,
	reset_seq,
	VBRESZCP,
	MD_CPINTMRG
	);

	input
	RDCLKP1,
	RDCLKC1,
	DRDCLKC1,
	CLKSEL1,
	DCLKSEL1,
	CE,
	DCE,
	VBRESZ,
	HISPEED,
	RLOWSPY,
	LOWPOWER,
	SUB,
	SCANMODE,
	TESDBT,
	TRMRD2,
	MSWR,
	EXER,
	IONCHK1,
	STCHK,
	CPBT,
	WDT1,
	WDT2,
	WDT3,
	WDT4,
	RDT,
	RDMRG0,
	RDMRG1,
	RDMRGC,
	EXTVPP1,
	EXTVPP2,
	CPT,
	IREFT,
	WWR,
	DWWR,
	CER,
	DCER,
	SER,
	DSER,
	MRG00,
	DMRG00,
	MRG01,
	DMRG01,
	MRG10,
	DMRG10,
	MRG11,
	DMRG11,
	MRG12,
	DMRG12,
	DIS,
	DDIS,
	READ,
	DREAD,
	CWEE,
	FCLK1,
	FLSTOP,
	DFLSTOP,
	MEOC,
	SRCUT,
	OSCNOSTP,
	MEOR,
	PROGI,
	WED,
	DWED,
	LOWSPY,
	IL_VCPDWNL,
//	IL_VCPDWNLR,
	trmrd1_internal,
	reset_seq,
	VBRESZCP;

	output MD_DIS;
	output MD_DDIS;

	wire ICLKSEL1, RDCLK;
	assign ICLKSEL1 = CLKSEL1 | SCANMODE;
	assign RDCLK = (ICLKSEL1) ? RDCLKC1 : RDCLKP1;

	wire IDCLKSEL1, DRDCLK;
	assign IDCLKSEL1 = DCLKSEL1 | SCANMODE;
	assign DRDCLK = (IDCLKSEL1) ? DRDCLKC1 : RDCLKP1;

	reg CEL;
	//synopsys async_set_reset "VBRESZ"
	always @(RDCLK or VBRESZ or CE) begin
		if (~VBRESZ) CEL = 1'b0;
		else if (~RDCLK) CEL = CE;
	end

	reg DCEL;
	//synopsys async_set_reset "VBRESZ"
	always @(DRDCLK or VBRESZ or DCE) begin
		if (~VBRESZ) DCEL = 1'b0;
		else if (~DRDCLK) DCEL = DCE;
	end


        // gate-clock
        wire RDCLK2;
        QNSC3NCP1V2_CPMD_MASK CPMD_MASK ( .ICLKSEL1(ICLKSEL1), .RDCLK(RDCLK), .RDCLK2(RDCLK2) );


	output MD_HISPEED;
	reg MD_HISPEED;
	wire IHISPEED;
	assign IHISPEED = HISPEED | SCANMODE;
	//synopsys async_set_reset "VBRESZ"
	always @(RDCLK2 or VBRESZ or IHISPEED) begin
		if (~VBRESZ) MD_HISPEED = 1'b0;
		else if (~RDCLK2) MD_HISPEED = IHISPEED;
	end

	output MD_RLOWSPY;
	wire MD_RLOWSPY;
	reg MD_RLOWSPYB;
	wire IRLOWSPY;
	assign IRLOWSPY = RLOWSPY & ~SCANMODE;
	wire IRLOWSPYB;
        assign IRLOWSPYB = ~IRLOWSPY;
	//synopsys async_set_reset "VBRESZ"
	always @(RDCLK2 or VBRESZ or IRLOWSPYB) begin
		if (~VBRESZ)      MD_RLOWSPYB = 1'b0;
		else if (~RDCLK2) MD_RLOWSPYB = IRLOWSPYB;
	end
        assign MD_RLOWSPY = ~MD_RLOWSPYB;

	output MD_LOWPOWER;
	reg MD_LOWPOWER;
	wire ILOWPOWER;
	assign ILOWPOWER = LOWPOWER & ~SCANMODE;
	//synopsys async_set_reset "VBRESZ"
	always @(RDCLK2 or VBRESZ or ILOWPOWER) begin
		if (~VBRESZ) MD_LOWPOWER = 1'b0;
		else if (~RDCLK2) MD_LOWPOWER = ILOWPOWER;
	end

	output MD_SUB;
	reg MD_SUB;
	wire ISUB;
	assign ISUB = SUB & ~SCANMODE;
	//synopsys async_set_reset "VBRESZ"
	always @(RDCLK2 or VBRESZ or ISUB) begin
		if (~VBRESZ) MD_SUB = 1'b0;
		else if (~RDCLK2) MD_SUB = ISUB;
	end


	output MD_TRMREAD12;
	assign MD_TRMREAD12 = trmrd1_internal | TRMRD2;

	wire IWED;
      //assign IWED = WED & ~SCANMODE;
	assign IWED = WED |  SCANMODE;

	wire IDWED;
      //assign IDWED = DWED & ~SCANMODE;
	assign IDWED = DWED |  SCANMODE;

	output ICWEE;
	assign ICWEE = CWEE & ~SCANMODE;

	output MD_CWEE;
	//reg MD_CWEE;
	wire MD_CWEE;
	wire md_cwee_clk;
	assign md_cwee_clk = IL_VCPDWNL;
	//always @(md_cwee_clk or ICWEE) begin
	//	if (~md_cwee_clk) MD_CWEE = ICWEE;
	//end
        QNSC3NCP1V2_CPMAJ3LATT CPMAJ3LATTCWEE ( .CLK(md_cwee_clk), .DIN(ICWEE), .OUTT(MD_CWEE) );

	output MD_MSWR;
	assign MD_MSWR = MSWR & ~MD_DIS & CEL & ~SCANMODE;

	output MD_DMSWR;
	assign MD_DMSWR = MSWR & ~MD_DDIS & DCEL & ~SCANMODE;

	output MD_EXER;
	assign MD_EXER = EXER & ~MD_DIS & CEL & ~SCANMODE;

	output MD_DEXER;
	assign MD_DEXER = EXER & ~MD_DDIS & DCEL & ~SCANMODE;

	output MD_IONCHK1;
	assign MD_IONCHK1 = IONCHK1 & ~MD_DIS & CEL & ~SCANMODE;

	output MD_DIONCHK1;
	assign MD_DIONCHK1 = IONCHK1 & ~MD_DDIS & DCEL & ~SCANMODE;

	output MD_STCHK;
	assign MD_STCHK = STCHK & ~MD_DIS & CEL & ~SCANMODE;

	output MD_DSTCHK;
	assign MD_DSTCHK = STCHK & ~MD_DDIS & DCEL & ~SCANMODE;

	output MD_CPBT;
	assign MD_CPBT = CPBT & ~MD_DIS & ~SCANMODE;

	output MD_DCPBT;
	assign MD_DCPBT = CPBT & ~MD_DDIS & ~SCANMODE;

	output MD_WDT1;
	assign MD_WDT1 = WDT1 & ~MD_DIS & CEL & ~SCANMODE;

	output MD_DWDT1;
	assign MD_DWDT1 = WDT1 & ~MD_DDIS & DCEL & ~SCANMODE;

	output MD_WDT2;
	assign MD_WDT2 = WDT2 & ~MD_DIS & CEL & ~SCANMODE;

	output MD_DWDT2;
	assign MD_DWDT2 = WDT2 & ~MD_DDIS & DCEL & ~SCANMODE;

	output MD_WDT3;
	assign MD_WDT3 = WDT3 & ~MD_DIS & CEL & ~SCANMODE;

	output MD_DWDT3;
	assign MD_DWDT3 = WDT3 & ~MD_DDIS & DCEL & ~SCANMODE;

	output MD_WDT4;
	assign MD_WDT4 = WDT4 & ~MD_DIS & ~SCANMODE;

	output MD_DWDT4;
	assign MD_DWDT4 = WDT4 & ~MD_DDIS & ~SCANMODE;

	output MD_RDT;
	assign MD_RDT = RDT & ~MD_DIS & ~SCANMODE;

	output MD_DRDT;
	assign MD_DRDT = RDT & ~MD_DDIS & ~SCANMODE;

	output MD_RDMRG0;
	assign MD_RDMRG0 = RDMRG0 & ~MD_DIS & ~SCANMODE;

	output MD_DRDMRG0;
	assign MD_DRDMRG0 = RDMRG0 & ~MD_DDIS & ~SCANMODE;

	output MD_RDMRG1;
	assign MD_RDMRG1 = RDMRG1 & ~MD_DIS & ~SCANMODE;

	output MD_DRDMRG1;
	assign MD_DRDMRG1 = RDMRG1 & ~MD_DDIS & ~SCANMODE;

	output MD_RDMRGC;
	assign MD_RDMRGC = RDMRGC & ~MD_DIS & CEL & ~SCANMODE;

	output MD_DRDMRGC;
	assign MD_DRDMRGC = RDMRGC & ~MD_DDIS & DCEL & ~SCANMODE;

	output MD_READ;
	assign MD_READ = (READ & ~MD_DIS) | (SCANMODE & TESDBT);

	output MD_DREAD;
	assign MD_DREAD = (DREAD & ~MD_DDIS) | (SCANMODE & TESDBT);

	output MD_WWR;
	assign MD_WWR = WWR & CEL & ~MD_DIS  & ~SCANMODE;

	output MD_DWWR;
	assign MD_DWWR = DWWR & DCEL & ~MD_DDIS  & ~SCANMODE;

	output MD_CER;
	assign MD_CER = CER & CEL & ~MD_DIS  & ~SCANMODE;

	output MD_DCER;
	assign MD_DCER = DCER & DCEL & ~MD_DDIS  & ~SCANMODE;

	output MD_SER;
	assign MD_SER = SER & CEL & ~MD_DIS  & ~SCANMODE;

	output MD_DSER;
	assign MD_DSER = DSER & DCEL & ~MD_DDIS  & ~SCANMODE;

	output MD_MRG00;
	assign MD_MRG00 = MRG00 & ~MD_DIS  & ~SCANMODE;

	output MD_DMRG00;
	assign MD_DMRG00 = DMRG00 & ~MD_DDIS  & ~SCANMODE;

	output MD_MRG01;
	assign MD_MRG01 = MRG01 & ~MD_DIS  & ~SCANMODE;

	output MD_DMRG01;
	assign MD_DMRG01 = DMRG01 & ~MD_DDIS  & ~SCANMODE;

	output MD_MRG10;
	assign MD_MRG10 = MRG10 & ~MD_DIS  & ~SCANMODE;

	output MD_DMRG10;
	assign MD_DMRG10 = DMRG10 & ~MD_DDIS  & ~SCANMODE;

	output MD_MRG11;
	assign MD_MRG11 = MRG11 & ~MD_DIS  & ~SCANMODE;

	output MD_DMRG11;
	assign MD_DMRG11 = DMRG11 & ~MD_DDIS  & ~SCANMODE;

	output MD_MRG12;
	assign MD_MRG12 = MRG12 & ~MD_DIS  & ~SCANMODE;

	output MD_DMRG12;
	assign MD_DMRG12 = DMRG12 & ~MD_DDIS  & ~SCANMODE;

	output MD_EXTVPP1;
	wire vppmd1, vppmd2;
	assign vppmd1 = MD_READ  | MD_MRG00 | MD_MRG01 | MD_MRG10 | MD_MRG11
			| MD_MRG12 | MD_RDMRG0 | MD_RDMRG1 | MD_RDT | MD_WDT4;
	assign vppmd2 = MD_DREAD | MD_DMRG00  | MD_DMRG01 | MD_DMRG10 | MD_DMRG11
			| MD_DMRG12 | MD_DRDMRG0 | MD_DRDMRG1 | MD_DRDT | MD_WDT4;
	assign MD_EXTVPP1 = EXTVPP1 & (CEL | DCEL | vppmd1 | vppmd2) & ~SCANMODE;

	output MD_EXTVPP2;
	assign MD_EXTVPP2 = EXTVPP2 & (CEL | DCEL) & ~SCANMODE;

	output MD_CPINTMRG;
	assign MD_CPINTMRG = (~MD_EXTVPP1 & ~MD_EXTVPP2 ) &
			     (MD_MRG00  | MD_MRG01  | MD_MRG10  | MD_MRG11  | MD_MRG12 |
			      MD_DMRG00 | MD_DMRG01 | MD_DMRG10 | MD_DMRG11 | MD_DMRG12);

	output MD_CPT;
	assign MD_CPT = CPT & (CEL | MD_RDT | MD_DRDT) & ~SCANMODE;

	output MD_IREFT;
	assign MD_IREFT = IREFT & (CEL | DCEL) & ~SCANMODE;

	wire mdis1, mdis2, mdis3;
	assign mdis1 = WWR | MSWR | CER | SER | EXER | WDT1
			| WDT2 | WDT3 | RDMRGC | IONCHK1 | STCHK;
	assign mdis2 = CPBT | MRG00 | MRG01 | MRG10 | MRG11
			| MRG12 | RDMRG0 | RDMRG1 | RDT | WDT4;
	//assign mdis3 = ( WWR | CER | SER) & ~EXTVPP1 & ~EXTVPP2;
	assign mdis3 = (   WWR | CER | SER
                         | MSWR | EXER
                         | RDT | WDT1 | WDT2 | WDT3 | WDT4 | CPBT
                        );

	assign MD_DIS = (
				DIS
				| ~(READ | mdis1 | mdis2)
				| ~(CEL | READ | mdis2)
				| (SCANMODE & ~TESDBT)
				| ( (IWED     ) & mdis3)
				| ~VBRESZ
				| ~VBRESZCP
			) & ~(SCANMODE & TESDBT);


	wire mddis1, mddis2, mddis3;
	assign mddis1 = DWWR | MSWR | DCER | DSER | EXER | WDT1
			| WDT2 | WDT3 | RDMRGC | IONCHK1 | STCHK;
	assign mddis2 = CPBT | DMRG00 | DMRG01 | DMRG10 | DMRG11
			| DMRG12 | RDMRG0 | RDMRG1 | RDT | WDT4;
	//assign mddis3 = ( DWWR | DCER | DSER) & ~EXTVPP1 & ~EXTVPP2;
	assign mddis3 = (   DWWR | DCER | DSER
                          | MSWR | EXER
                          | RDT | WDT1 | WDT2 | WDT3 | WDT4 | CPBT
                         );

	assign MD_DDIS = (
				DDIS
				| ~(DREAD | mddis1 | mddis2)
				| ~(DCEL | DREAD | mddis2)
				| (SCANMODE & ~TESDBT)
				| ( (IDWED      ) & mddis3)
				| ~VBRESZ
				| ~VBRESZCP
			) & ~(SCANMODE & TESDBT);

	output MD_SRCUT;
	assign MD_SRCUT = SRCUT & ~SCANMODE;

	output MD_OSCNOSTP;
	assign MD_OSCNOSTP = OSCNOSTP & ~SCANMODE;

	output MD_FCLK1;
	assign MD_FCLK1 = FCLK1 & ~SCANMODE;

	output MD_FLSTOP;
	assign MD_FLSTOP = FLSTOP & ~SCANMODE & ~reset_seq;	//2010/08/10

	output MD_DFLSTOP;
	assign MD_DFLSTOP = DFLSTOP & ~SCANMODE;

	output MD_MEOC;
	assign MD_MEOC = MEOC & ~SCANMODE;

	output MD_LOWSPY;
	assign MD_LOWSPY = LOWSPY & ~SCANMODE;

	output MD_PROGI;
	assign MD_PROGI = PROGI & ~SCANMODE;


	output REG125ST;
	wire IMEOR, reg125_1, reg125_2, reg125_3;
	assign IMEOR = MEOR & ~SCANMODE;
	assign reg125_1 = ~MD_HISPEED & ~MD_RLOWSPY & ~MD_LOWPOWER & ~MD_SUB;
	assign reg125_2 = ~MD_HISPEED & ~MD_RLOWSPY &  MD_LOWPOWER & ~MD_SUB;
	assign reg125_3 = MD_SUB;
	assign REG125ST =(  ~(MD_READ & reg125_1 & ~MD_FLSTOP & MD_DFLSTOP) & ~(MD_READ & MD_DREAD & reg125_1)
		          & ~(MD_READ & reg125_2 & ~MD_FLSTOP & MD_DFLSTOP) & ~(MD_READ & MD_DREAD & reg125_2)
		          & ~(MD_READ & reg125_3 & ~MD_FLSTOP & MD_DFLSTOP) & ~(MD_READ & MD_DREAD & reg125_3)
		          & ~trmrd1_internal
		          & ~(MD_FLSTOP & MD_DFLSTOP)
		          & ~(MD_RDT & MD_DRDT & IMEOR)
		          & VBRESZCP
			  & VBRESZ
			) | TESDBT;	//2010/08/10

endmodule

module QNSC3NCP1V2_CPMD_MASK (
    // input port
    ICLKSEL1,
    RDCLK,
    // output port
    RDCLK2
);

input ICLKSEL1;
input RDCLK;

output RDCLK2;
assign RDCLK2 = RDCLK & ICLKSEL1;

endmodule


///=============================================================================
///CPL0 counter
///  Ver2.00 2010/06/10 Renewal from QNSC3NCP0V1 for MTEG
///
///=============================================================================

module QNSC3NCP1V2_CPL0 (
                RESB,
		TRMRD1,
		TRMRD1CK,
		trmrd1_internal,
		TRMRD2,
		TRMRD2CK,
		reset_seq,
		REQFL,
		RDSETUP,
		SRCUTCP,
		IL_ERFCLKSET,
		IL_FIHFL,
		IL_FIHFL4M,
		VBRESZ,
		POCREL,
		FIHFL,
		MD_HISPEED,
		MD_RLOWSPY,
		MD_LOWPOWER,
		MD_SUB,
//		MD_SRCUT,	//2010/08/24
		MD_FLSTOP,
		MD_SER,
		MD_DSER,
		MD_CER,
		MD_DCER,
		MD_EXER,
		MD_DEXER,
		MD_FCLK1,
		MD_IONCHK1,
		MD_DIONCHK1,
		MD_RDMRG0,
		MD_DRDMRG0,
		MD_RDMRG1,
		MD_DRDMRG1,
		MD_RDMRGC,
		MD_DRDMRGC,
		MD_MRG00,
		MD_DMRG00,
		MD_MRG01,
		MD_DMRG01,
		MD_MRG10,
		MD_DMRG10,
		MD_MRG11,
		MD_DMRG11,
		MD_MRG12,
		MD_DMRG12,
		MD_READ,
		MD_DREAD,
		MD_EXTVPP1,
		MD_CPT,
		MD_IREFT,
		MD_DFLSTOP,
//		MD_DDIS,
		IL_VCPDIS,
		IL_ERASE,
		IL_WRITE,
		BG1ST,
		REG125ST
	);
		
	input	RESB,
                VBRESZ,
		POCREL,
		FIHFL,
		MD_HISPEED,
		MD_RLOWSPY,
		MD_LOWPOWER,
		MD_SUB,
//		MD_SRCUT,	//2010/08/24
		MD_FLSTOP,
		MD_SER,
		MD_DSER,
		MD_CER,
		MD_DCER,
		MD_EXER,
		MD_DEXER,
		MD_FCLK1,
		MD_IONCHK1,
		MD_DIONCHK1,
		MD_RDMRG0,
		MD_DRDMRG0,
		MD_RDMRG1,
		MD_DRDMRG1,
		MD_RDMRGC,
		MD_DRDMRGC,
		MD_MRG00,
		MD_DMRG00,
		MD_MRG01,
		MD_DMRG01,
		MD_MRG10,
		MD_DMRG10,
		MD_MRG11,
		MD_DMRG11,
		MD_MRG12,
		MD_DMRG12,
		MD_READ,
		MD_DREAD,
		MD_EXTVPP1,
		MD_CPT,
		MD_IREFT,
		MD_DFLSTOP,
//		MD_DDIS,
		IL_VCPDIS,
		IL_ERASE,
		IL_WRITE,
		REG125ST;

	parameter WAIT_TRM1 =		6'h18;	//5.5uS  (WAIT_TRM1-1)*(1/4MHz)  VBRESZ↑～TRMRD1CK↓
						/// 端子リセット時にTRM1がスキップされた対策としてTRM2と同じ値とする
	parameter WAIT_TRM2 =		6'h17;	//5uS  (WAIT_TRM2-3)*(1/4MHz)  TRMRD2↑～TRMRD2CK↑
	parameter WAIT_TRM3 =		6'h26;	//10uS (WAIT_TRM3+3)*(1/4MHz) TRMRD2↓～RDSETUP↑
	parameter WAIT_MODE_LOWSPEED =	6'h0a;	//3.13uS  (WAIT_MODE_LOWSPEED+2.5)*(1/4MHz) MD_RLOWSPY↓～RDSETUP↑
	parameter WAIT_MODE_HISPEED =	6'h12;	//5.13uS  (WAIT_MODE_HISPEED+2.5)*(1/4MHz) MD_RLOWSPY↓～RDSETUP↑
	parameter WAIT_MODE_LOWPOWER =	6'h0a;	//3.13uS  (WAIT_MODE_LOWPOWER+2.5)*(1/4MHz) MD_RLOWSPY↓～RDSETUP↑
	parameter WAIT_STOP_LOWVOLT =	6'h01;	//17uS  (WAIT_STOP_LOWVOLT+40h+3)*(1/4MHz) FLSTOP↓～RDSETUP↑
	parameter WAIT_STOP_LOWSPEED =	6'h01;	//720nS (WAIT_STOP_LOWSPEED+3)*(1/4MHz) FLSTOP↓～RDSETUP↑
	parameter WAIT_STOP_HISPEED =	6'h12;	//5uS  (WAIT_STOP_HISPEED+2)*(1/4MHz) FLSTOP↓～RDSETUP↑
	parameter WAIT_STOP_LOWPOWER =	6'h01;	//720nS (WAIT_STOP_LOWPOWER+3)*(1/4MHz) FLSTOP↓～RDSETUP↑
	parameter WAIT_FCLK1 =		6'h26;	//10uS (WAIT_FCLK1+3)*(1/4MHz) FCLK1↑～ERFCLKSET↓

	output TRMRD1;
	output TRMRD1CK;
	output trmrd1_internal;
	output TRMRD2;
	output TRMRD2CK;
	output reset_seq;
	reg [5:0] counter;
	reg [1:0] countmode;
	reg [1:0] h_counter;
	output IL_ERFCLKSET;
	reg fclkset;
	output RDSETUP;
	reg RDSETUP;
	output BG1ST;

	//trmrd1_resetb --------------------------------------------------------
	// 2010/08/10 POCREL=High & VBRESZ=Low --> PowerDown
	wire trmrd1_resetb;						//2010/08/10
	assign trmrd1_resetb = VBRESZ | (POCREL & trmrd1_internal);	//2010/08/10

	//mode ----------------------------------------------------------------
	wire main_stop_mode, fclk1_mode;
//	assign main_halt_mode = MD_SRCUT & ~MD_SUB;	//2010/08/24
	assign main_stop_mode = MD_FLSTOP & ~MD_SUB;

	assign fclk1_mode = MD_FCLK1 & (MD_SER | MD_CER | MD_EXER | MD_DSER | MD_DCER | MD_DEXER);

	//clock ---------------------------------------------------------------
	output IL_FIHFL, IL_FIHFL4M;
	wire FIHFL16M, FIHFL8M, FIHFL4M, IL_FIHFL4M, bff_resetb, FIHFL16M_add;
	reg cold_reset, FIHFL_add;

	assign IL_FIHFL = FIHFL;

	assign bff_resetb = trmrd1_resetb & ~main_stop_mode;			//2010/08/10
      QNSC3NCP1V2_CPL0_BFF bff1 (.clk(~FIHFL), .resb(bff_resetb), .out(FIHFL16M));	//FLASH is 32MHz low edge. for async
      QNSC3NCP1V2_CPL0_BFF bff2 (.clk(FIHFL16M_add), .resb(bff_resetb), .out(FIHFL8M));
      QNSC3NCP1V2_CPL0_BFF bff3 (.clk(FIHFL8M), .resb(bff_resetb), .out(FIHFL4M));
      QNSC3NCP1V2_CPL0_DRV clkdrv (.in(FIHFL4M), .out(IL_FIHFL4M));

	///  2011/03/23 add cold_reset
	//synopsys async_set_reset "POCREL"
	always @(RDSETUP or POCREL) begin
		if (~POCREL) cold_reset = 1'b0;
		else if (RDSETUP) cold_reset = 1'b1;
	end

	///  2011/03/23 add FIHFL_add
	//synopsys async_set_reset "bff_resetb"
	always @(posedge FIHFL16M or negedge bff_resetb) begin
		if (~bff_resetb) FIHFL_add <= 1'b0;
		else FIHFL_add <= ~FIHFL_add;
	end

	assign FIHFL16M_add = (cold_reset) ? FIHFL16M : FIHFL_add;

	//async to sync -------------------------------------------------------
	wire rlowspy_sync, rlowspy_async, flstop_sync, fclk1_sync, fclk1_async;
      QNSC3NCP1V2_CPL0_RLOWSPYSYNC rlowsync (.clk(IL_FIHFL4M), .in(MD_RLOWSPY), .resb(VBRESZ), .sync(rlowspy_sync),
						.async(rlowspy_async));
      QNSC3NCP1V2_CPL0_FLSTOPSYNC flstopsync (.clk(IL_FIHFL4M), .in(main_stop_mode), .resb(VBRESZ), .sync(flstop_sync));
//      QNSC3NCP1V2_CPL0_SRCUTSYNC srcutsync (.clk(IL_FIHFL4M), .in(main_halt_mode), .resb(VBRESZ), .srcut_sync(srcut_sync)); //2010/08/24
      QNSC3NCP1V2_CPL0_FCLK1SYNC fclk1sync (.clk(IL_FIHFL4M), .in(fclk1_mode), .resb(VBRESZ), .sync(fclk1_sync),
						.async(fclk1_async));

	//counter -------------------------------------------------------------

	//synopsys async_set_reset "trmrd1_resetb"			//2010/08/10
	always @(posedge IL_FIHFL4M or negedge trmrd1_resetb) begin	//2010/08/10
		if (~trmrd1_resetb) counter <= WAIT_TRM1;		//2010/08/10
		else if (countmode == 2'h0) begin
			if (IL_VCPDIS == 1'b0) begin
				if (counter == 6'h0) begin
					if (trmrd1_internal) counter <= WAIT_TRM2;
					else        counter <= WAIT_TRM3;
				end
				else counter <= counter - 1'b1;
			end
		end
		else if (countmode == 2'h1) begin
			if (counter != 6'h0 || h_counter != 2'h0) counter <= counter - 1'b1;	//2010/08/24
		end
		else if (fclk1_sync) counter <= WAIT_FCLK1;
		else if (countmode == 2'h2 && RDSETUP == 1'b0) begin
			if (rlowspy_sync) begin
				casex ({MD_RLOWSPY, MD_HISPEED, MD_LOWPOWER})
					3'b000 : counter <= WAIT_MODE_LOWSPEED;
					3'b010 : counter <= WAIT_MODE_HISPEED;
					3'b001 : counter <= WAIT_MODE_LOWPOWER;
					default: counter <= 6'h0;
				endcase
			end
			else if (flstop_sync) begin
				casex ({MD_RLOWSPY, MD_HISPEED, MD_LOWPOWER})
					3'b100 : counter <= WAIT_STOP_LOWVOLT;
					3'b000 : counter <= WAIT_STOP_LOWSPEED;
					3'b010 : counter <= WAIT_STOP_HISPEED;
					3'b001 : counter <= WAIT_STOP_LOWPOWER;
					default: counter <= 6'h0;
				endcase
			end
			else if (counter != 6'h0) counter <= counter - 1'b1;
		end
		else if (countmode == 2'h3) begin
			if (counter != 6'h0 || h_counter[0] != 1'b0) counter <= counter - 1'b1; //2010/08/31
		end
	end

	//synopsys async_set_reset "VBRESZ"
	always @(posedge IL_FIHFL4M or negedge VBRESZ) begin
		if (~VBRESZ) countmode <= 2'h0;
		else if (counter == 6'h0 && countmode == 2'h0 && ~trmrd1_internal) countmode <= 2'h1;
		else if (h_counter == 2'h0 && counter == 6'h0 && countmode == 2'h1) countmode <= 2'h2;	//2010/08/24
		else if (fclk1_sync) countmode <= 2'h3;
		else if (countmode == 2'h2 && RDSETUP == 1'b0) begin
			if (rlowspy_sync | flstop_sync) countmode <= 2'h3;
			else countmode <= countmode;
		end
		else if (h_counter[0] == 1'b0 && counter == 6'h0 && countmode == 2'h3) countmode <= 2'h2; //2010/08/31
	end

	wire reset_seq;				//2010/08/10
	assign reset_seq = ~countmode[1];	//2010/08/10

	//2010/08/24 POC level down -> TRMRD3 long wait
	//synopsys async_set_reset "POCREL"
	always @(posedge IL_FIHFL4M or negedge POCREL) begin
		if (~POCREL) h_counter <= 2'h3;
		else if (countmode != 2'b00 && h_counter != 2'h0 && counter == 6'h0)
			h_counter <= h_counter - 1'b1;
		else if (countmode[1] == 1'b1 && flstop_sync & MD_RLOWSPY) h_counter <= 2'h1;
		else if (countmode[1] == 1'b1 && counter == 6'h0) h_counter <= 2'h0;
	end

	//TRM1 triming outut signal ------------------------------------------------

	reg trmrd1_p1;
	//synopsys async_set_reset "POCREL"
	always @(posedge IL_FIHFL4M or negedge POCREL) begin
		if (~POCREL) trmrd1_p1 <= 1'b1;
		else if (countmode != 2'h0) trmrd1_p1 <= 1'b0;	//for noise
		else if (counter == 6'h0) trmrd1_p1 <= 1'b0;
	end

        // delay
        wire RESBDLY0, RESBDLY;
        TBDLY2X2 CPILDLY0 ( .N01(RESBDLY0), .H01(RESB)     );
        TBDLY3X2 CPILDLY1 ( .N01(RESBDLY),  .H01(RESBDLY0) );

	//assign trmrd1_internal = ~IL_VCPDIS & trmrd1_p1_dly2;		/// POCリセット時にヒゲが出る
	assign trmrd1_internal = ~IL_VCPDIS & trmrd1_p1 & ~RESBDLY;

	assign TRMRD1 = ~IL_ERASE & ~IL_WRITE & trmrd1_internal;	/// POCリセット時にヒゲが出ない

	reg trmrd1ck_p;
	//synopsys async_set_reset "POCREL"
	always @(posedge IL_FIHFL4M or negedge POCREL) begin
		if (~POCREL) trmrd1ck_p <= 1'b1;
		else if (countmode != 2'h0) trmrd1ck_p <= 1'b0;	//for noise
		else if (counter == 6'h1) trmrd1ck_p <= 1'b0;
	end
	assign TRMRD1CK = TRMRD1 & trmrd1ck_p;

	//TRM2 triming outut signal ------------------------------------------------

	reg trmrd2_p;
	//synopsys async_set_reset "VBRESZ"
	always @(posedge IL_FIHFL4M or negedge VBRESZ) begin
		if (~VBRESZ) trmrd2_p <= 1'b1;
		else if (countmode != 2'h0)          trmrd2_p <= 1'b0;	//for noise
		else if (~trmrd1_internal && counter == 6'h2) trmrd2_p <= 1'b0;
	end
	assign TRMRD2 = VBRESZ & ~IL_VCPDIS & ~trmrd1_internal & trmrd2_p;

	reg TRMRD2CK;
	//synopsys async_set_reset "VBRESZ"
	always @(posedge IL_FIHFL4M or negedge VBRESZ) begin
		if (~VBRESZ) TRMRD2CK <= 1'b0;
		else if (~trmrd1_internal && counter == 6'h4 && countmode == 2'h0) TRMRD2CK <= 1'b1;
		else TRMRD2CK <= 1'b0;
	end

	output SRCUTCP;
	reg SRCUTCP;
	//synopsys async_set_reset "VBRESZ"
	always @(posedge IL_FIHFL4M or negedge VBRESZ) begin
		if (~VBRESZ) SRCUTCP <= 1'b0;
		else if (~trmrd1_internal && counter == 6'h1 && countmode == 2'h0) SRCUTCP <= 1'b1;
		else SRCUTCP <= 1'b0;
	end

	//RQEFL, RDSETUP triming outut signal ------------------------------------

	output REQFL;
	reg REQFL, reqfl_p1, reqfl_p2;
	wire reqfl_reset = ~VBRESZ | ~RDSETUP | fclk1_async | BG1ST
			| ~(countmode[1] & ~countmode[0]);	//countmode!=2 for noise
	//synopsys async_set_reset "reqfl_reset"
	always @(posedge IL_FIHFL4M or posedge reqfl_reset) begin
		if (reqfl_reset) reqfl_p1 <= 1'b1;
		else if (IL_ERFCLKSET== 1'b1) reqfl_p1 <= 1'b1;
		else                          reqfl_p1 <= 1'b0;
	end

	//synopsys async_set_reset "reqfl_reset"
	always @(negedge FIHFL16M or posedge reqfl_reset) begin
		if (reqfl_reset) reqfl_p2 <= 1'b1;
		else if (~IL_FIHFL4M & ~FIHFL8M) reqfl_p2 <= reqfl_p1;
	end

	wire MD_SRCUT;		//2010/08/24
	assign MD_SRCUT = 1'b0;
	always @(MD_IONCHK1 or MD_DIONCHK1 or MD_RDMRG0 or MD_DRDMRG0 or MD_RDMRG1 or
		MD_DRDMRG1 or MD_RDMRGC or MD_DRDMRGC or MD_MRG00 or MD_DMRG00 or
		MD_MRG01 or MD_DMRG01 or MD_MRG10 or MD_DMRG10 or MD_MRG11 or
		MD_DMRG11 or MD_MRG12 or MD_DMRG12 or MD_READ or MD_DREAD or
		MD_EXTVPP1 or MD_CPT or MD_IREFT or MD_RLOWSPY or MD_SUB or
		MD_SRCUT or MD_FLSTOP or MD_DFLSTOP or trmrd1_resetb or IL_ERFCLKSET or reqfl_p2) begin	//2010/08/10
		casex({
		MD_IONCHK1, MD_DIONCHK1, MD_RDMRG0, MD_DRDMRG0, MD_RDMRG1,
		MD_DRDMRG1, MD_RDMRGC, MD_DRDMRGC, MD_MRG00, MD_DMRG00,
		MD_MRG01, MD_DMRG01, MD_MRG10, MD_DMRG10, MD_MRG11,
		MD_DMRG11, MD_MRG12, MD_DMRG12, MD_READ, MD_DREAD,
		MD_EXTVPP1, MD_CPT, MD_IREFT, MD_RLOWSPY, MD_SUB,
		MD_SRCUT, MD_FLSTOP, MD_DFLSTOP, trmrd1_resetb, IL_ERFCLKSET	//2010/08/10
		})
			  //         111111111122222222223
			  //123456789012345678901234567890
			  //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMI
			  //DDDDDDDDDDDDDDDDDDDDDDDDDDDDDL
			  //______________________________
			  // D D D D D D D D D DECIRSS DVE
			  //IIRRRRRRMMMMMMMMMMRRXPRLURFFBR
			  //OODDDDDDRRRRRRRRRREETTEOBCLLRF
			  //NNMMMMMMGGGGGGGGGGAAV FW USSEC
			  //CCRRRRRR0000111111DDP TS TTTSL
			  //HHGGGGGG0011001122  P  P  OOZK
			  //KK0011CC            1  Y  PP S
			  //11                           E
			30'bxxxxxxxx1xxxxxxxxxxx0xxxxx0x1x : REQFL=1'b1; ///MRG00	-	外部VPP1モード以外	-		
			30'bxxxxxxxxxx1xxxxxxxxx0xxxxx0x1x : REQFL=1'b1; ///MRG01	-	外部VPP1モード以外	-		
			30'bxxxxxxxxxxxx1xxxxxxx0xxxxx0x1x : REQFL=1'b1; ///MRG10	-	外部VPP1モード以外	-		
			30'bxxxxxxxxxxxxxx1xxxxx0xxxxx0x1x : REQFL=1'b1; ///MRG11	-	外部VPP1モード以外	-		
			30'bxxxxxxxxxxxxxxxx1xxx0xxxxx0x1x : REQFL=1'b1; ///MRG12	-	外部VPP1モード以外	-		
			30'bxxxxxxxxx1xxxxxxxxxx0xxxxxx01x : REQFL=1'b1; ///-			MRG00	-	外部VPP1モード以外
			30'bxxxxxxxxxxx1xxxxxxxx0xxxxxx01x : REQFL=1'b1; ///-			MRG01	-	外部VPP1モード以外
			30'bxxxxxxxxxxxxx1xxxxxx0xxxxxx01x : REQFL=1'b1; ///-			MRG10	-	外部VPP1モード以外
			30'bxxxxxxxxxxxxxxx1xxxx0xxxxxx01x : REQFL=1'b1; ///-			MRG11	-	外部VPP1モード以外
			30'bxxxxxxxxxxxxxxxxx1xx0xxxxxx01x : REQFL=1'b1; ///-			MRG12	-	外部VPP1モード以外
			30'bxxxxxxxxxxxxxxxxxxx10xx10xx01x : REQFL=1'b1; ///-			READ	低電圧メインモード	外部VPP1モード以外
			30'bx1xxxxxxxxxxxxxxxxxx1001xxx01x : REQFL=1'b1; ///-			IONCHK1	VWL=CP	外部VPP1モード
			30'bxxx1xxxxxxxxxxxxxxxx0xx10xx01x : REQFL=1'b1; ///-			RDMRG0	低電圧メインモード	外部VPP1モード以外
			30'bxxxxx1xxxxxxxxxxxxxx0xx10xx01x : REQFL=1'b1; ///-			RDMRG1	低電圧メインモード	外部VPP1モード以外
			30'bxxxxxxx1xxxxxxxxxxxx10010xx01x : REQFL=1'b1; ///-			RDMRGC	低電圧メインモード	外部VPP1モード
			30'bxxxxxxxxxxxxxxxxxx1x0xx10x0x1x : REQFL=1'b1; ///READ	低電圧メインモード	外部VPP1モード以外	-		
			30'b1xxxxxxxxxxxxxxxxxxx1001xx0x1x : REQFL=1'b1; ///IONCHK1	VWL=CP出力	外部VPP1モード	-		
			30'b1xxxxxxxxxxxxxxxxxxx0101xx0x1x : REQFL=1'b1; ///		CPTモード	-		
			30'bxx1xxxxxxxxxxxxxxxxx0xx10x0x1x : REQFL=1'b1; ///RDMRG0	低電圧メインモード	外部VPP1モード以外	-		
			30'bxxxx1xxxxxxxxxxxxxxx0xx10x0x1x : REQFL=1'b1; ///RDMRG1	低電圧メインモード	内部モード	-		
			30'bxxxxxx1xxxxxxxxxxxxx10010x0x1x : REQFL=1'b1; ///RDMRGC	低電圧メインモード	外部VPP1モード	-		
			30'bxxxxxx1xxxxxxxxxxxxx01010x0x1x : REQFL=1'b1; ///		CPTモード	-		
			30'bxxxxxxxxxxxxxxxxxxxxxxxx1xxx1x : REQFL=1'b0; ///SUB
			30'bxxxxxxxx0000000000xxxxx0x1xx10 : REQFL=1'b0; ///HALT
			30'bxxxxxxxxxxxxxxxxxxxxxxxxxx111x : REQFL=1'b0; ///STOP
			30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxx0x : REQFL=1'b0; ///RESET
			default                            : REQFL=reqfl_p2;
		endcase
	end

	wire rdsetup_reset;
//	assign rdsetup_reset = ~VBRESZ | rlowspy_async | main_stop_mode | main_halt_mode;
	assign rdsetup_reset = ~VBRESZ | rlowspy_async | main_stop_mode;	//2010/08/24
	//synopsys async_set_reset "rdsetup_reset"
	always @(posedge IL_FIHFL4M or posedge rdsetup_reset) begin
		if (rdsetup_reset) RDSETUP <= 1'b0;
		else if (h_counter == 2'h0 && counter == 6'h0 && countmode == 2'h1) RDSETUP <= 1'b1;	//2010/08/24
		else if (h_counter[0] == 1'b0 && counter == 6'h0 && countmode == 2'h3) RDSETUP <= 1'b1; //2010/08/31
//		else if (srcut_sync && countmode[1] == 1'b1)   RDSETUP <= 1'b1;	//2010/08/24
	end

	//IL_ERFCLKSET timing outut signal ------------------------------------

	wire fclkset_reset;
	assign fclkset_reset = ~VBRESZ | fclk1_async;
	//synopsys async_set_reset "fclkset_reset"
	always @(posedge IL_FIHFL4M or posedge fclkset_reset) begin
		if (fclkset_reset) fclkset <= 1'b1;
		else if (fclk1_sync)      fclkset <= 1'b1;
		else if (counter == 6'h0) fclkset <= 1'b0;
	end
	assign IL_ERFCLKSET = fclkset & fclk1_mode;

	//BG1ST outut signal --------------------------------------------------
      QNSC3NCP1V2_CPL0_REG125STSYNC reg125sync (.clk(IL_FIHFL4M), .REG125ST(REG125ST),
		.resb(VBRESZ), .BG1ST(BG1ST) );

endmodule

//module QNSC3NCP1V2_CPILDELAY (
//        IN, 
//        OUT);
//   input IN;
//   output OUT;
//
//   // Internal wires
//   wire NODE01;
//   wire NODE02;
//   wire NODE03;
//
//   TBBUFX1 BUF01 (.N01(NODE01), .H01(IN));
//   TBBUFX1 BUF02 (.N01(NODE02), .H01(NODE01));
//   TBBUFX1 BUF03 (.N01(NODE03), .H01(NODE02));
//   TBBUFX1 BUF04 (.N01(OUT),    .H01(NODE03));
//endmodule


module QNSC3NCP1V2_CPL0_BFF(clk, resb, out);
	input clk, resb;
	output out;
	reg out;
	//synopsys async_set_reset "resb"
	always @(posedge clk or negedge resb) begin
		if (~resb) out <= 1'b0;
		else       out <= ~out;
	end
endmodule

module QNSC3NCP1V2_CPL0_RLOWSPYSYNC(clk, in, resb, sync, async);
	input clk, in, resb;
	output sync, async;
	reg sync1, sync2, sync3;
	//synopsys async_set_reset "resb"
	always @(negedge clk or negedge resb) begin
		if (~resb) sync1 <= 1'b1;
		else       sync1 <= in;
	end
	//synopsys async_set_reset "resb"
	always @(negedge clk or negedge resb) begin
		if (~resb) sync2 <= 1'b1;
		else       sync2 <= sync1;
	end
	//synopsys async_set_reset "resb"
	always @(negedge clk or negedge resb) begin
		if (~resb) sync3 <= 1'b1;
		else       sync3 <= sync2;
	end
	assign async = ~in & sync3;
	assign sync = ~sync2 & sync3;
endmodule

module QNSC3NCP1V2_CPL0_FLSTOPSYNC(clk, in, resb, sync);
	input clk, in, resb;
	output sync;
	reg sync1, sync2;
	wire sync_reset;
	assign sync_reset = in | ~resb;
	//synopsys async_set_reset "sync_reset"
	always @(negedge clk or posedge sync_reset) begin
		if (sync_reset) sync1 <= 1'b1;
		else       sync1 <= 1'b0;
	end
	//synopsys async_set_reset "sync_reset"
	always @(negedge clk or posedge sync_reset) begin
		if (sync_reset) sync2 <= 1'b1;
		else       sync2 <= sync1;
	end
	assign sync = ~sync1 & sync2;
endmodule

//2010/08/24
/*
module QNSC3NCP1V2_CPL0_SRCUTSYNC(clk, in, resb, srcut_sync);
	input clk, in, resb;
	output srcut_sync;
	reg sync1, sync2, sync3, sync4;
	wire sync_reset;
	assign sync_reset = in | ~resb;
	//synopsys async_set_reset "sync_reset"
	always @(negedge clk or posedge sync_reset) begin
		if (sync_reset) sync1 <= 1'b0;
		else       sync1 <= 1'b1;
	end
	//synopsys async_set_reset "sync_reset"
	always @(negedge clk or posedge sync_reset) begin
		if (sync_reset) sync2 <= 1'b0;
		else       sync2 <= sync1;
	end
	//synopsys async_set_reset "sync_reset"
	always @(negedge clk or posedge sync_reset) begin
		if (sync_reset) sync3 <= 1'b0;
		else       sync3 <= sync2;
	end
	//synopsys async_set_reset "sync_reset"
	always @(negedge clk or posedge sync_reset) begin
		if (sync_reset) sync4 <= 1'b0;
		else       sync4 <= sync3;
	end
	assign srcut_sync = sync3 & ~sync4;
endmodule
*/

module QNSC3NCP1V2_CPL0_FCLK1SYNC(clk, in, resb, sync, async);
	input clk, in, resb;
	output sync, async;
	reg sync1, sync2, sync3;
	//synopsys async_set_reset "resb"
	always @(negedge clk or negedge resb) begin
		if (~resb) sync1 <= 1'b0;
		else       sync1 <= in;
	end
	//synopsys async_set_reset "resb"
	always @(negedge clk or negedge resb) begin
		if (~resb) sync2 <= 1'b0;
		else       sync2 <= sync1;
	end
	//synopsys async_set_reset "resb"
	always @(negedge clk or negedge resb) begin
		if (~resb) sync3 <= 1'b0;
		else       sync3 <= sync2;
	end
	assign async = in & ~sync3;
	assign sync = sync2 & ~sync3;
endmodule

module QNSC3NCP1V2_CPL0_REG125STSYNC(clk, REG125ST, resb, BG1ST);
	input clk, REG125ST, resb;
	output BG1ST;
	reg sync1, sync;
	reg [2:0] counter;
	wire sync_reset;
	assign sync_reset = ~REG125ST | ~resb;
	//synopsys async_set_reset "sync_reset"
	always @(negedge clk or posedge sync_reset) begin
		if (sync_reset) sync1 <= 1'b0;
		else            sync1 <= 1'b1;
	end
	//synopsys async_set_reset "sync_reset"
	always @(negedge clk or posedge sync_reset) begin
		if (sync_reset) counter <= 3'b101;
		else if (counter != 3'b000) counter <= counter - 1'b1;
	end
	//synopsys async_set_reset "sync_reset"
	always @(negedge clk or posedge sync_reset) begin
		if (sync_reset) sync <= 1'b0;
		else if (counter == 3'b000) sync <= 1'b1;
	end
	assign BG1ST = REG125ST & ~sync;
endmodule

module QNSC3NCP1V2_CPL0_DRV(in, out);
	input in;
	output out;
	TBBUFX8 clkdrv (.H01(in), .N01(out));
endmodule



///=============================================================================
///CPL1 READ regulator control
///  Ver2.00 2010/06/10 Renewal from QNSC3NCP0V1 for MTEG
///
///=============================================================================

module QNSC3NCP1V2_CPL1 (
	IL_REGREN, IL_TRMREGRB, RTRMCP15, RTRMCP16, RTRMCP17,
	MD_IONCHK1, MD_DIONCHK1, MD_STCHK, MD_DSTCHK, MD_RDT,
	MD_DRDT, MD_RDMRG0, MD_DRDMRG0, MD_RDMRG1, MD_DRDMRG1,
	MD_RDMRGC, MD_DRDMRGC, MD_EXTVPP1, MD_CPT, MD_IREFT,
	MD_CWEE, MD_HISPEED, MD_SUB, MD_WWR, MD_CER, MD_SER,
	MD_MRG00, MD_MRG01, MD_MRG10, MD_MRG11, MD_MRG12,
	MD_DIS, MD_READ, MD_DWWR, MD_DCER, MD_DSER,
	MD_DMRG00, MD_DMRG01, MD_DMRG10, MD_DMRG11, MD_DMRG12,
	MD_DDIS, MD_DREAD, MD_FLSTOP, MD_DFLSTOP, SCANMODE,
	TESDBT
	);
	input
	RTRMCP15, RTRMCP16, RTRMCP17,
	MD_IONCHK1, MD_DIONCHK1, MD_STCHK, MD_DSTCHK, MD_RDT,
	MD_DRDT, MD_RDMRG0, MD_DRDMRG0, MD_RDMRG1, MD_DRDMRG1,
	MD_RDMRGC, MD_DRDMRGC, MD_EXTVPP1, MD_CPT, MD_IREFT,
	MD_CWEE, MD_HISPEED, MD_SUB, MD_WWR, MD_CER, MD_SER,
	MD_MRG00, MD_MRG01, MD_MRG10, MD_MRG11, MD_MRG12,
	MD_DIS, MD_READ, MD_DWWR, MD_DCER, MD_DSER,
	MD_DMRG00, MD_DMRG01, MD_DMRG10, MD_DMRG11, MD_DMRG12,
	MD_DDIS, MD_DREAD, MD_FLSTOP, MD_DFLSTOP, SCANMODE,
	TESDBT;

	output IL_REGREN;
	output [7:0] IL_TRMREGRB;

	reg IL_REGREN;
	reg [7:0] IL_TRMREGRB;

	always @(
		MD_IONCHK1 or MD_DIONCHK1 or MD_STCHK or MD_DSTCHK or MD_RDT or 
                MD_DRDT or MD_RDMRG0 or MD_DRDMRG0 or MD_RDMRG1 or MD_DRDMRG1 or 
                MD_RDMRGC or MD_DRDMRGC or MD_EXTVPP1 or MD_CPT or MD_IREFT or 
                MD_CWEE or MD_HISPEED or MD_SUB or MD_DIS or MD_READ or MD_DDIS or
                MD_DREAD or MD_FLSTOP or MD_DFLSTOP or SCANMODE or TESDBT
		) begin

		casex ({
			MD_IONCHK1 , MD_DIONCHK1 , MD_STCHK , MD_DSTCHK , MD_RDT , 
                	MD_DRDT , MD_RDMRG0 , MD_DRDMRG0 , MD_RDMRG1 , MD_DRDMRG1 , 
                	MD_RDMRGC , MD_DRDMRGC , MD_EXTVPP1 , MD_CPT , MD_IREFT , 
                	MD_CWEE , MD_HISPEED , MD_SUB , MD_DIS , MD_READ , MD_DDIS ,
                	MD_DREAD , MD_FLSTOP , MD_DFLSTOP , SCANMODE , TESDBT
		})
			  //         11111111112222222
			  //12345678901234567890123456
			  //MMMMMMMMMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDDDDDDDDD
			  //__________________________
			  // D D D D D DECICHSDRDD DST
			  //IISSRRRRRRRRXPRWIUIEDRFFCE
			  //OOTTDDDDDDDDTTEESBSAIELLAS
			  //NNCCTTMMMMMMV FEP  DSASSND
			  //CCHH  RRRRRRP T E    DTTMB
			  //HHKK  GGGGGGP   E     OOOT
			  //KK    0011CC1   D     PPD 
			  //11                      E 
			26'bxxxxxxxxxxxx000110xxx1x0xx: IL_REGREN=1'b1;	//-		Invpp	Read
			26'bxxxxxxxxxxxx0011101xx1x0xx: IL_REGREN=1'b1;	//Invpp	DIS	Ireft	Read
			26'bx1xxxxxxxxxx1001101xxxx0xx: IL_REGREN=1'b1;	//Invpp	DIS	Extvpp1	Ionchk1
			26'bxxx1xxxxxxxx1001xx1xxxx0xx: IL_REGREN=1'b1;	//Invpp	DIS	Extvpp1	Stchk
			26'bxxx1xxxxxxxx0011xx1xxxx0xx: IL_REGREN=1'b1;	//Invpp	DIS	Ireft	Stchk
			26'bxxxxxxx1xxxx0001101xxxx0xx: IL_REGREN=1'b1;	//Invpp	DIS	Invpp	Rdmrg0
			26'bxxxxxxx1xxxx0011101xxxx0xx: IL_REGREN=1'b1;	//Invpp	DIS	Ireft	Rdmrg0
			26'bxxxxxxxxx1xx0001101xxxx0xx: IL_REGREN=1'b1;	//Invpp	DIS	Invpp	Rdmrg1
			26'bxxxxxxxxx1xx0011101xxxx0xx: IL_REGREN=1'b1;	//Invpp	DIS	Ireft	Rdmrg1
			26'bxxxxxxxxxxx11001101xxxx0xx: IL_REGREN=1'b1;	//Invpp	DIS	Extvpp1	Rdmrgc
			26'bxxxxxxxxxxxx000010x1xx0xxx: IL_REGREN=1'b1;	//Invpp	Read	-	1
			26'bxxxxxxxxxxxx001010x11x0xxx: IL_REGREN=1'b1;	//Iref	Read	Invpp	DIS
			26'bxxxxxxxxxxxx010010x11x0xxx: IL_REGREN=1'b1;	//Cpt	Read	Invpp	DIS
			26'b1xxxxxxxxxxx100010xx1x0xxx: IL_REGREN=1'b1;	//Extvpp1	IONCHK1	Invpp	DIS
			26'b1xxxxxxxxxxx010010xx1x0xxx: IL_REGREN=1'b1;	//Cpt	IONCHK1	Invpp	DIS
			26'bxxxx1xxxxxxx0100xxxx1x0xxx: IL_REGREN=1'b1;	//Cpt	RDT	Invpp	DIS
			26'bxx11xxxxxxxx100xxxxxxx00xx: IL_REGREN=1'b1;	//Extvpp1	STCHK	Extvpp1	STCHK
			26'bxx1xxxxxxxxx1000xxxx1x0xxx: IL_REGREN=1'b1;	//Extvpp1	STCHK	Invpp	DIS
			26'bxx1xxxxxxxxx0100xxxx1x0xxx: IL_REGREN=1'b1;	//Cpt	STCHK	Invpp	DIS
			26'bxx1xxxxxxxxx0010xxxx1x0xxx: IL_REGREN=1'b1;	//Iref	STCHK	Invpp	DIS
			26'bxxxxxx1xxxxx000010xx1x0xxx: IL_REGREN=1'b1;	//Invpp	Rdmrg0	Invpp	DIS
			26'bxxxxxx1xxxxx010010xx1x0xxx: IL_REGREN=1'b1;	//Cpt	Rdmrg0	Invpp	DIS
			26'bxxxxxx1xxxxx001010xx1x0xxx: IL_REGREN=1'b1;	//Iref	Rdmrg0	Invpp	DIS
			26'bxxxxxxxx1xxx000010xx1x0xxx: IL_REGREN=1'b1;	//Invpp	Rdmrg1	Invpp	DIS
			26'bxxxxxxxx1xxx010010xx1x0xxx: IL_REGREN=1'b1;	//Cpt	Rdmrg1	Invpp	DIS
			26'bxxxxxxxx1xxx001010xx1x0xxx: IL_REGREN=1'b1;	//Iref	Rdmrg1	Invpp	DIS
			26'bxxxxxxxxxx1x100010xx1x0xxx: IL_REGREN=1'b1;	//Extvpp1	Rdmrgc	Invpp	DIS
			26'bxxxxxxxxxx1x010010xx1x0xxx: IL_REGREN=1'b1;	//Cpt	Rdmrgc	Invpp	DIS
			26'bxxxxxxxxxxxxxxxxxxxxxxxx11: IL_REGREN=1'b1;	//-	BT	-	BT
			default                         IL_REGREN=1'b0;
		endcase
	end

	always @(RTRMCP17 or RTRMCP16 or RTRMCP15) begin
		case ({RTRMCP17, RTRMCP16, RTRMCP15})
			3'b000 : IL_TRMREGRB = 8'b11111110;
			3'b001 : IL_TRMREGRB = 8'b11111101;
			3'b010 : IL_TRMREGRB = 8'b11111011;
			3'b011 : IL_TRMREGRB = 8'b11110111;
			3'b100 : IL_TRMREGRB = 8'b11101111;
			3'b101 : IL_TRMREGRB = 8'b11011111;
			3'b110 : IL_TRMREGRB = 8'b10111111;
			3'b111 : IL_TRMREGRB = 8'b01111111;
		endcase
	end

endmodule

///=============================================================================
///CPL2 READ regulator control
///  Ver2.00 2010/06/10 Renewal from QNSC3NCP0V1 for MTEG
///
///=============================================================================

module QNSC3NCP1V2_CPL2 (
	IL_REGEN, IL_WRITE, IWRITE, IL_TRMREGWB,
	TRMCP15, TRMCP16, TRMCP17,
	MD_MSWR, MD_DMSWR, MD_IONCHK1, MD_DIONCHK1, MD_STCHK,
	MD_DSTCHK, MD_WDT1, MD_DWDT1, MD_WDT2, MD_DWDT2,
	MD_WDT3, MD_DWDT3, MD_WDT4, MD_DWDT4, MD_RDT,
	MD_RDMRG0, MD_DRDMRG0, MD_RDMRG1, MD_DRDMRG1,
	MD_RDMRGC, MD_DRDMRGC, MD_EXTVPP1, MD_EXTVPP2, MD_CPT,
	MD_IREFT, MD_CWEE, MD_HISPEED, SCANMODE, TESDBT,
	MD_WWR, MD_DIS, MD_READ, MD_DWWR, MD_DDIS,
	MD_DREAD, MD_FLSTOP, MD_DFLSTOP,
	IL_VCPDWNL,
//      IL_CPEN,
        MD_SUB,
        MD_PROGI
	);
	input
	TRMCP15, TRMCP16, TRMCP17,
	MD_MSWR, MD_DMSWR, MD_IONCHK1, MD_DIONCHK1, MD_STCHK,
	MD_DSTCHK, MD_WDT1, MD_DWDT1, MD_WDT2, MD_DWDT2,
	MD_WDT3, MD_DWDT3, MD_WDT4, MD_DWDT4, MD_RDT,
	MD_RDMRG0, MD_DRDMRG0, MD_RDMRG1, MD_DRDMRG1,
	MD_RDMRGC, MD_DRDMRGC, MD_EXTVPP1, MD_EXTVPP2, MD_CPT,
	MD_IREFT, MD_CWEE, MD_HISPEED, SCANMODE, TESDBT,
	MD_WWR, MD_DIS, MD_READ, MD_DWWR, MD_DDIS,
	MD_DREAD, MD_FLSTOP, MD_DFLSTOP;
	input IL_VCPDWNL,
//            IL_CPEN,
              MD_SUB,
              MD_PROGI;

	output IL_REGEN;
	output [7:0] IL_TRMREGWB;
	output IWRITE;
	output IL_WRITE;

	reg IL_REGEN;
	reg [7:0] IL_TRMREGWB;
	//reg IL_WRITE;
	wire IL_WRITE;

	always @(
		 MD_MSWR or MD_DMSWR or MD_IONCHK1 or MD_DIONCHK1 or MD_STCHK or 
                 MD_DSTCHK or MD_WDT1 or MD_DWDT1 or MD_WDT2 or MD_DWDT2 or 
                 MD_WDT3 or MD_DWDT3 or MD_WDT4 or MD_DWDT4 or MD_RDT or 
                 MD_RDMRG0 or MD_DRDMRG0 or MD_RDMRG1 or MD_DRDMRG1 or MD_RDMRGC or
                 MD_DRDMRGC or MD_EXTVPP1 or MD_EXTVPP2 or MD_CPT or MD_IREFT or 
                 MD_CWEE or MD_HISPEED or MD_SUB or SCANMODE or TESDBT or 
                 MD_WWR or MD_DIS or MD_READ or MD_DWWR or MD_DDIS or 
                 MD_DREAD or MD_FLSTOP or MD_DFLSTOP
		) begin

		casex ({
		 MD_MSWR , MD_DMSWR , MD_IONCHK1 , MD_DIONCHK1 , MD_STCHK , 
                 MD_DSTCHK , MD_WDT1 , MD_DWDT1 , MD_WDT2 , MD_DWDT2 , 
                 MD_WDT3 , MD_DWDT3 , MD_WDT4 , MD_DWDT4 , MD_RDT , 
                 MD_RDMRG0 , MD_DRDMRG0 , MD_RDMRG1 , MD_DRDMRG1 , MD_RDMRGC ,
                 MD_DRDMRGC , MD_EXTVPP1 , MD_EXTVPP2 , MD_CPT , MD_IREFT , 
                 MD_CWEE , MD_HISPEED , MD_SUB , SCANMODE , TESDBT , 
                 MD_WWR , MD_DIS , MD_READ , MD_DWWR , MD_DDIS , 
                 MD_DREAD , MD_FLSTOP , MD_DFLSTOP
		})
			  //         11111111112222222222333333333
			  //12345678901234567890123456789012345678
			  //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
			  //______________________________________
			  // D D D D D D DD D D DEECICHSSTWDRDDD D
			  //MMIISSWWWWWWWWRRRRRRRXXPRWIUCEWIEWDRFF
			  //SSOOTTDDDDDDDDDDDDDDDTTTEESBASRSAWIELL
			  //WWNNCCTTTTTTTTTMMMMMMVV FEP ND  DRSASS
			  //RRCCHH11223344 RRRRRRPP T E MB     DTT
			  //  HHKK         GGGGGGPP   E OT      OO
			  //  KK           0011CC12   D D       PP
			  //  11                        E         
			38'bxxxxxxxxxxxxxxxxxxxxx00001xxxx1xxxxx0x: IL_REGEN=1'b1; //Invpp	WWR	-	
			38'bxxxxxxxxxxxxxxxxxxxxx10001xxxx1xxx1x0x: IL_REGEN=1'b1; //Extvpp1	WWR	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxxxxxx00101xxxx1xxx1x0x: IL_REGEN=1'b1; //Cpt	WWR	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxxxxxx10101xxxx1xxx1x0x: IL_REGEN=1'b1; //Cpt+Ex1	WWR	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxxxxxx01101xxxx1xxx1x0x: IL_REGEN=1'b1; //Cpt+Ex2	WWR	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxxxxxx00011xxxx1xxx1x0x: IL_REGEN=1'b1; //Ireft	WWR	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxxxxxx00000xxxxxxx1xxx0: IL_REGEN=1'b1; //-		Invpp	WWR
			38'bxxxxxxxxxxxxxxxxxxxxx10000xxxxx1x1xxx0: IL_REGEN=1'b1; //Invpp	DIS	Extvpp1	WWR
			38'bxxxxxxxxxxxxxxxxxxxxx0000010xxxxxxx1x0: IL_REGEN=1'b1; //Invpp	DIS	Invpp	READ
			38'bxxxxxxxxxxxxxxxxxxxxx0001010xxx1xxx1x0: IL_REGEN=1'b1; //Invpp	DIS	Ireft	READ
			38'bx1xxxxxxxxxxxxxxxxxxx00000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Invpp	MSWR
			38'bx1xxxxxxxxxxxxxxxxxxx10000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Extvpp1	MSWR
			38'bxxx1xxxxxxxxxxxxxxxxx1000010xxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Extvpp1	IONC
			38'bxxxxxxx1xxxxxxxxxxxxx00000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Invpp	WDT1
			38'bxxxxxxx1xxxxxxxxxxxxx10000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Extvpp1	WDT1
			38'bxxxxxxx1xxxxxxxxxxxxx01000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Extvpp2	WDT1
			38'bxxxxxxxxx1xxxxxxxxxxx00000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Invpp	WDT2
			38'bxxxxxxxxx1xxxxxxxxxxx10000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Extvpp1	WDT2
			38'bxxxxxxxxxxx1xxxxxxxxx00000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Invpp	WDT3
			38'bxxxxxxxxxxx1xxxxxxxxx10000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Extvpp1	WDT3
			38'bxxxxxxxxxxxxx1xxxxxxx00000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Invpp	WDT4
			38'bxxxxxxxxxxxxx1xxxxxxx10000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Extvpp1	WDT4
			38'bxxxxx1xxxxxxxxxxxxxxx10000xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Extvpp1	STCH
			38'bxxxxx1xxxxxxxxxxxxxxx00010xxxxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Ireft	STCH
			38'bxxxxxxxxxxxxxxxx1xxxx0000010xxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Invpp	RDMR
			38'bxxxxxxxxxxxxxxxx1xxxx0001010xxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Ireft	RDMR
			38'bxxxxxxxxxxxxxxxxxx1xx0000010xxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Invpp	RDMR
			38'bxxxxxxxxxxxxxxxxxx1xx0001010xxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Ireft	RDMR
			38'bxxxxxxxxxxxxxxxxxxxx11000010xxx1xxxxx0: IL_REGEN=1'b1; //Invpp	DIS	Extvpp1	RDMR
			38'bxxxxxxxxxxxxxxxxxxxxx0000110xxxx1xxx0x: IL_REGEN=1'b1; //Invpp	READ	-	
			38'bxxxxxxxxxxxxxxxxxxxxx0010110xxxx1x1x0x: IL_REGEN=1'b1; //Cpt	READ	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxxxxxx0001110xxxx1x1x0x: IL_REGEN=1'b1; //Ireft	READ	Invpp	DIS
			38'b1xxxxxxxxxxxxxxxxxxxx00001xxxxxxxx1x0x: IL_REGEN=1'b1; //Invpp	MSWR	Invpp	DIS
			38'b11xxxxxxxxxxxxxxxxxxx1000xxxxxxxxxxx00: IL_REGEN=1'b1; //Extvpp1	MSWR	Extvpp1	MSWR
			38'b1xxxxxxxxxxxxxxxxxxxx10001xxxxxxxx1x0x: IL_REGEN=1'b1; //Extvpp1	MSWR	Invpp	DIS
			38'b1xxxxxxxxxxxxxxxxxxxx00101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt	MSWR	Invpp	DIS
			38'b1xxxxxxxxxxxxxxxxxxxx10101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt+Ex1	MSWR	Invpp	DIS
			38'b1xxxxxxxxxxxxxxxxxxxx01101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt+Ex2	MSWR	Invpp	DIS
			38'b1xxxxxxxxxxxxxxxxxxxx00011xxxxxxxx1x0x: IL_REGEN=1'b1; //Ireft	MSWR	Invpp	DIS
			38'bxx1xxxxxxxxxxxxxxxxxx1000110xxxxxx1x0x: IL_REGEN=1'b1; //Extvpp1	IONCHK1	Invpp	DIS
			38'bxx1xxxxxxxxxxxxxxxxxx0010110xxxxxx1x0x: IL_REGEN=1'b1; //Cpt	IONCHK1	Invpp	DIS
			38'bxxxxxx11xxxxxxxxxxxxx0000xxxxxxxxxxx00: IL_REGEN=1'b1; //Invpp	WDT1	Invpp	WDT1
			38'bxxxxxx1xxxxxxxxxxxxxx00001xxxxxxxx1x0x: IL_REGEN=1'b1; //Invpp	WDT1	Invpp	DIS
			38'bxxxxxx11xxxxxxxxxxxxx1000xxxxxxxxxxx00: IL_REGEN=1'b1; //Extvpp1	WDT1	Extvpp1	WDT1
			38'bxxxxxx1xxxxxxxxxxxxxx10001xxxxxxxx1x0x: IL_REGEN=1'b1; //Extvpp1	WDT1	Invpp	DIS
			38'bxxxxxx1xxxxxxxxxxxxxx01001xxxxxxxx1x0x: IL_REGEN=1'b1; //Extvpp2	WDT1	Invpp	DIS
			38'bxxxxxx1xxxxxxxxxxxxxx00101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt	WDT1	Invpp	DIS
			38'bxxxxxx1xxxxxxxxxxxxxx10101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt+Ex1	WDT1	Invpp	DIS
			38'bxxxxxx1xxxxxxxxxxxxxx01101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt+Ex2	WDT1	Invpp	DIS
			38'bxxxxxxxx11xxxxxxxxxxx0000xxxxxxxxxxx00: IL_REGEN=1'b1; //Invpp	WDT2	Invpp	WDT2
			38'bxxxxxxxx1xxxxxxxxxxxx00001xxxxxxxx1x0x: IL_REGEN=1'b1; //Invpp	WDT2	Invpp	DIS
			38'bxxxxxxxx11xxxxxxxxxxx1000xxxxxxxxxxx00: IL_REGEN=1'b1; //Extvpp1	WDT2	Extvpp1	WDT2
			38'bxxxxxxxx1xxxxxxxxxxxx10001xxxxxxxx1x0x: IL_REGEN=1'b1; //Extvpp1	WDT2	Invpp	DIS
			38'bxxxxxxxx1xxxxxxxxxxxx00101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt	WDT2	Invpp	DIS
			38'bxxxxxxxx1xxxxxxxxxxxx10101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt+Ex1	WDT2	Invpp	DIS
			38'bxxxxxxxx1xxxxxxxxxxxx01101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt+Ex2	WDT2	Invpp	DIS
			38'bxxxxxxxxxx11xxxxxxxxx0000xxxxxxxxxxx00: IL_REGEN=1'b1; //Invpp	WDT3	Invpp	WDT3
			38'bxxxxxxxxxx1xxxxxxxxxx00001xxxxxxxx1x0x: IL_REGEN=1'b1; //Invpp	WDT3	Invpp	DIS
			38'bxxxxxxxxxx11xxxxxxxxx1000xxxxxxxxxxx00: IL_REGEN=1'b1; //Extvpp1	WDT3	Extvpp1	WDT3
			38'bxxxxxxxxxx1xxxxxxxxxx10001xxxxxxxx1x0x: IL_REGEN=1'b1; //Extvpp1	WDT3	Invpp	DIS
			38'bxxxxxxxxxx1xxxxxxxxxx00101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt	WDT3	Invpp	DIS
			38'bxxxxxxxxxx1xxxxxxxxxx10101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt+Ex1	WDT3	Invpp	DIS
			38'bxxxxxxxxxx1xxxxxxxxxx01101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt+Ex2	WDT3	Invpp	DIS
			38'bxxxxxxxxxxxx11xxxxxxx0000xxxxxxxxxxx00: IL_REGEN=1'b1; //Invpp	WDT4	Invpp	WDT4
			38'bxxxxxxxxxxxx11xxxxxxx1000xxxxxxxxxxx00: IL_REGEN=1'b1; //Extvpp1	WDT4	Extvpp1	WDT4
			38'bxxxxxxxxxxxx1xxxxxxxx00101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt	WDT4	Invpp	DIS
			38'bxxxxxxxxxxxx1xxxxxxxx10101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt+Ex1	WDT4	Invpp	DIS
			38'bxxxxxxxxxxxx1xxxxxxxx01101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt+Ex2	WDT4	Invpp	DIS
			38'bxxxxxxxxxxxxxx1xxxxxx00101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt	RDT	Invpp	DIS
			38'bxxxx11xxxxxxxxxxxxxxx1000xxxxxxxxxxx00: IL_REGEN=1'b1; //Extvpp1	STCHK	Extvpp1	STCH
			38'bxxxx1xxxxxxxxxxxxxxxx10001xxxxxxxx1x0x: IL_REGEN=1'b1; //Extvpp1	STCHK	Invpp	DIS
			38'bxxxx1xxxxxxxxxxxxxxxx00101xxxxxxxx1x0x: IL_REGEN=1'b1; //Cpt	STCHK	Invpp	DIS
			38'bxxxx1xxxxxxxxxxxxxxxx00011xxxxxxxx1x0x: IL_REGEN=1'b1; //Ireft	STCHK	Invpp	DIS
			38'bxxxxxxxxxxxxxxx1xxxxx0000110xxxxxx1x0x: IL_REGEN=1'b1; //Invpp	RDMRG0	Invpp	DIS
			38'bxxxxxxxxxxxxxxx1xxxxx0010110xxxxxx1x0x: IL_REGEN=1'b1; //Cpt	RDMRG0	Invpp	DIS
			38'bxxxxxxxxxxxxxxx1xxxxx0001110xxxxxx1x0x: IL_REGEN=1'b1; //Ireft	RDMRG0	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxx1xxx0000110xxxxxx1x0x: IL_REGEN=1'b1; //Invpp	RDMRG1	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxx1xxx0010110xxxxxx1x0x: IL_REGEN=1'b1; //Cpt	RDMRG1	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxx1xxx0001110xxxxxx1x0x: IL_REGEN=1'b1; //Ireft	RDMRG1	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxxxx1x1000110xxxxxx1x0x: IL_REGEN=1'b1; //Extvpp1	RDMRGC	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxxxx1x0010110xxxxxx1x0x: IL_REGEN=1'b1; //Cpt	RDMRGC	Invpp	DIS
			38'bxxxxxxxxxxxxxxxxxxxxxxxxxxxx11xxxxxxxx: IL_REGEN=1'b1; //-	BT	-	BT
			default                                   : IL_REGEN=1'b0;
		endcase
	end

	always @(TRMCP17 or TRMCP16 or TRMCP15) begin
		case ({TRMCP17, TRMCP16, TRMCP15})
			3'b000 : IL_TRMREGWB = 8'b11111110;
			3'b001 : IL_TRMREGWB = 8'b11111101;
			3'b010 : IL_TRMREGWB = 8'b11111011;
			3'b011 : IL_TRMREGWB = 8'b11110111;
			3'b100 : IL_TRMREGWB = 8'b11101111;
			3'b101 : IL_TRMREGWB = 8'b11011111;
			3'b110 : IL_TRMREGWB = 8'b10111111;
			3'b111 : IL_TRMREGWB = 8'b01111111;
		endcase
	end

	assign IWRITE = MD_MSWR | MD_DMSWR | MD_WDT1 | MD_DWDT1 | MD_WDT2 |
		MD_DWDT2 | MD_WDT3 | MD_DWDT3 | MD_WDT4 | MD_DWDT4 |
		MD_WWR | MD_DWWR;

	//synopsys async_set_reset "IL_VCPDWNL"
	//always @(negedge IL_VCPDWNL or negedge MD_PROGI) begin
	//	if (~IL_VCPDWNL)    IL_WRITE <= 1'b0;
	//	else 		    IL_WRITE <= 1'b1;
	//end
        QNSC3NCP1V2_CPMAJ3LATTR CPMAJ3LATTRWRITE ( .RSTB(IL_VCPDWNL), .CLKB(MD_PROGI), .DIN(1'b1), .OUTT(IL_WRITE) );


endmodule

///=============================================================================
///CPL3 Write/Erase/Read CP control
///  Ver2.00 2010/06/10 Renewal from QNSC3NCP0V1 for MTEG
///
///=============================================================================

module QNSC3NCP1V2_CPL3 (
	IL_CPRB,
	IL_CPEN,
	IERASE,
	IL_ERASE,
	IL_READ,
	IL_TRMCPWB,
	IL_CPWESWEN,
	IL_CPRSWEN,
	IL_CPRGVDB,
	IL_DPRSWEN,
	IL_DPRGVDB,
	MD_MSWR,
	MD_DMSWR,
	MD_EXER,
	MD_DEXER,
	MD_IONCHK1,
	MD_DIONCHK1,
	MD_CPBT,
	MD_DCPBT,
	MD_WDT1,
	MD_DWDT1,
	MD_WDT2,
	MD_DWDT2,
	MD_WDT3,
	MD_DWDT3,
	MD_WDT4,
	MD_DWDT4,
	MD_RDMRG0,
	MD_DRDMRG0,
	MD_RDMRG1,
	MD_DRDMRG1,
	MD_RDMRGC,
	MD_DRDMRGC,
	MD_WWR,
	MD_DWWR,
	MD_STCHK,
	MD_DSTCHK,
	MD_RDT,
	MD_DRDT,
	MD_CER,
	MD_DCER,
	MD_SER,
	MD_DSER,
	MD_MRG00,
	MD_DMRG00,
	MD_MRG01,
	MD_DMRG01,
	MD_MRG10,
	MD_DMRG10,
	MD_MRG11,
	MD_DMRG11,
	MD_MRG12,
	MD_DMRG12,
	MD_READ,
	MD_DREAD,
	MD_DIS,
	MD_DDIS,
	MD_FLSTOP,
	MD_DFLSTOP,
	MD_MEOC,
	SCANMODE,
	TESDBT,
	MD_EXTVPP1,
	MD_EXTVPP2,
	MD_CPT,
	MD_IREFT,
	MD_CWEE,
        MD_HISPEED,
	MD_RLOWSPY,
	MD_SUB,
	MD_FCLK1,
	MD_PROGI,
	MD_OSCNOSTP,
	IWRITE,
	IL_WRITE,
	IL_VCPDWNL,
	IL_CPENR,
	IL_REGREN,
	MD_TRMREAD12,
	IL_VCPDISR,
	TRMCP0,
	TRMCP1,
	TRMCP2,
	TRMCP3,
        OSCLFREQ
	);

	input
	MD_MSWR,
	MD_DMSWR,
	MD_EXER,
	MD_DEXER,
	MD_IONCHK1,
	MD_DIONCHK1,
	MD_CPBT,
	MD_DCPBT,
	MD_WDT1,
	MD_DWDT1,
	MD_WDT2,
	MD_DWDT2,
	MD_WDT3,
	MD_DWDT3,
	MD_WDT4,
	MD_DWDT4,
	MD_RDMRG0,
	MD_DRDMRG0,
	MD_RDMRG1,
	MD_DRDMRG1,
	MD_RDMRGC,
	MD_DRDMRGC,
	MD_WWR,
	MD_DWWR,
	MD_STCHK,
	MD_DSTCHK,
	MD_RDT,
	MD_DRDT,
	MD_CER,
	MD_DCER,
	MD_SER,
	MD_DSER,
	MD_MRG00,
	MD_DMRG00,
	MD_MRG01,
	MD_DMRG01,
	MD_MRG10,
	MD_DMRG10,
	MD_MRG11,
	MD_DMRG11,
	MD_MRG12,
	MD_DMRG12,
	MD_READ,
	MD_DREAD,
	MD_DIS,
	MD_DDIS,
	MD_FLSTOP,
	MD_DFLSTOP,
	MD_MEOC,
	SCANMODE,
	TESDBT,
	MD_EXTVPP1,
	MD_EXTVPP2,
	MD_CPT,
	MD_IREFT,
	MD_CWEE,
        MD_HISPEED,
	MD_RLOWSPY,
	MD_SUB,
	MD_FCLK1,
	MD_PROGI,
	MD_OSCNOSTP,
	IWRITE,
	IL_WRITE,
	IL_VCPDWNL,
	IL_CPENR,
	IL_REGREN,
	MD_TRMREAD12,
	IL_VCPDISR,
	TRMCP0,
	TRMCP1,
	TRMCP2,
	TRMCP3;

	output IERASE;
        output IL_ERASE;


        // IERASE, IL_ERASE
        QNSC3NCP1V2_CPL3_IL_ERASE CPL3_IL_ERASE (
            // input port
            .MD_SER(MD_SER),    .MD_DSER(MD_DSER),
            .MD_CER(MD_CER),    .MD_DCER(MD_DCER),
            .MD_EXER(MD_EXER),  .MD_DEXER(MD_DEXER),
            .MD_CPBT(MD_CPBT),  .MD_DCPBT(MD_DCPBT),
            .MD_FCLK1(MD_FCLK1),
            .IL_VCPDWNL(IL_VCPDWNL),
            // output port
            .IERASE(IERASE),
            .IL_ERASE(IL_ERASE)
        );


	reg ICPRB;
	always @(MD_IONCHK1 or MD_DIONCHK1 or MD_RDMRG0 or MD_DRDMRG0 or MD_RDMRG1 or
		MD_DRDMRG1 or MD_RDMRGC or MD_DRDMRGC or MD_MRG00 or MD_DMRG00 or
		MD_MRG01 or MD_DMRG01 or MD_MRG10 or MD_DMRG10 or MD_MRG11 or
		MD_DMRG11 or MD_MRG12 or MD_DMRG12 or MD_DIS or MD_DDIS or
		MD_READ or MD_DREAD or MD_CWEE or MD_RLOWSPY or MD_SUB or MD_FLSTOP or
		MD_DFLSTOP
		) begin
		casex({
		MD_IONCHK1, MD_DIONCHK1, MD_RDMRG0, MD_DRDMRG0, MD_RDMRG1,
		MD_DRDMRG1, MD_RDMRGC, MD_DRDMRGC, MD_MRG00, MD_DMRG00,
		MD_MRG01, MD_DMRG01, MD_MRG10, MD_DMRG10, MD_MRG11,
		MD_DMRG11, MD_MRG12, MD_DMRG12, MD_DIS, MD_DDIS,
		MD_READ, MD_DREAD, MD_CWEE, MD_RLOWSPY, MD_SUB, MD_FLSTOP,
		MD_DFLSTOP
		})
			  //         111111111122222222
			  //123456789012345678901234567
			  //MMMMMMMMMMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDDDDDDDDDD
			  //___________________________
			  // D D D D D D D D D D DCRS D
			  //IIRRRRRRMMMMMMMMMMDDRRELUFF
			  //OODDDDDDRRRRRRRRRRIIEEWOBLL
			  //NNMMMMMMGGGGGGGGGGSSAAWW SS
			  //CCRRRRRR0000111111  DD S TT
			  //HHGGGGGG0011001122     P OO
			  //KK0011CC               Y PP
			  //11                       
			27'bxxxxxxxx1xxxxxxxxxxxxx1xx0x: ICPRB=1'b0; //All	MRG00	-	-
			27'bxxxxxxxxxx1xxxxxxxxxxx1xx0x: ICPRB=1'b0; //All	MRG01	-	-
			27'bxxxxxxxxxxxx1xxxxxxxxx1xx0x: ICPRB=1'b0; //All	MRG10	-	-
			27'bxxxxxxxxxxxxxx1xxxxxxx1xx0x: ICPRB=1'b0; //All	MRG11	-	-
			27'bxxxxxxxxxxxxxxxx1xxxxx1xx0x: ICPRB=1'b0; //All	MRG12	-	-
			27'bxxxxxxxxx1xxxxxxxxxxxx0xxx0: ICPRB=1'b0; //-		-	All	MRG00
			27'bxxxxxxxxxxx1xxxxxxxxxx0xxx0: ICPRB=1'b0; //-		-	All	MRG01
			27'bxxxxxxxxxxxxx1xxxxxxxx0xxx0: ICPRB=1'b0; //-		-	All	MRG10
			27'bxxxxxxxxxxxxxxx1xxxxxx0xxx0: ICPRB=1'b0; //-		-	All	MRG11
			27'bxxxxxxxxxxxxxxxxx1xxxx0xxx0: ICPRB=1'b0; //-		-	All	MRG12
			27'bxxxxxxxxxxxxxxxxxx1xx1010x0: ICPRB=1'b0; //-		-	All	READ
			27'bx1xxxxxxxxxxxxxxxx1xxx010x0: ICPRB=1'b0; //Invpp	DIS	All	IONCHK1
			27'bxxx1xxxxxxxxxxxxxx1xxx010x0: ICPRB=1'b0; //Invpp	DIS	All	RDMRG0
			27'bxxxxx1xxxxxxxxxxxx1xxx010x0: ICPRB=1'b0; //Invpp	DIS	All	RDMRG1
			27'bxxxxxxx1xxxxxxxxxx1xxx010x0: ICPRB=1'b0; //Invpp	DIS	All	RDMRGC
			27'bxxxxxxxxxxxxxxxxxxxx1111001: ICPRB=1'b0; //All	READ	Invpp	STOP(READ)
			27'bxxxxxxxxxxxxxxxxxxxx11x1000: ICPRB=1'b0; //All	READ	All	READ
			27'bxxxxxxxxxxxxxxxxxxx11x1100x: ICPRB=1'b0; //All	READ	Invpp	DIS
			27'b1xxxxxxxxxxxxxxxxxx1xx1100x: ICPRB=1'b0; //All	IONCHK1	-	-
			27'bxx1xxxxxxxxxxxxxxxx1xx1100x: ICPRB=1'b0; //All	RDMRG0	Invpp	DIS
			27'bxxxx1xxxxxxxxxxxxxx1xx1100x: ICPRB=1'b0; //All	RDMRG1	Invpp	DIS
			27'bxxxxxx1xxxxxxxxxxxx1xx1100x: ICPRB=1'b0; //All	RDMRGC	Invpp	DIS
			default                        : ICPRB=1'b1;
		endcase
	end

	output IL_CPRB;
	assign IL_CPRB = ICPRB & ~IL_WRITE & ~IL_ERASE | MD_CPT & MD_EXTVPP2;

	reg ICPENO;
	always @(MD_IONCHK1 or MD_DIONCHK1 or MD_CPBT or MD_DCPBT or MD_RDMRG0 or
		MD_DRDMRG0 or MD_RDMRG1 or MD_DRDMRG1 or MD_RDMRGC or MD_DRDMRGC or
		MD_MRG00 or MD_DMRG00 or MD_MRG01 or MD_DMRG01 or MD_MRG10 or
		MD_DMRG10 or MD_MRG11 or MD_DMRG11 or MD_MRG12 or MD_DMRG12 or
		MD_READ or MD_DREAD or MD_DIS or MD_DDIS or MD_EXTVPP1 or
		MD_EXTVPP2 or MD_CPT or MD_IREFT or MD_CWEE or MD_RLOWSPY or
		MD_SUB or MD_FLSTOP or MD_DFLSTOP
		) begin
		casex({
		MD_IONCHK1, MD_DIONCHK1, MD_CPBT, MD_DCPBT, MD_RDMRG0,
		MD_DRDMRG0, MD_RDMRG1, MD_DRDMRG1, MD_RDMRGC, MD_DRDMRGC,
		MD_MRG00, MD_DMRG00, MD_MRG01, MD_DMRG01, MD_MRG10,
		MD_DMRG10, MD_MRG11, MD_DMRG11, MD_MRG12, MD_DMRG12,
		MD_READ, MD_DREAD, MD_DIS, MD_DDIS, MD_EXTVPP1,
		MD_EXTVPP2, MD_CPT, MD_IREFT, MD_CWEE, MD_RLOWSPY,
		MD_SUB, MD_FLSTOP, MD_DFLSTOP
		})

			  //         111111111122222222223333
			  //123456789012345678901234567890123
			  //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
			  //_________________________________
			  // D D D D D D D D D D D DEECICRS D
			  //IICCRRRRRRMMMMMMMMMMRRDDXXPRWLUFF
			  //OOPPDDDDDDRRRRRRRRRREEIITTTEEOBLL
			  //NNBBMMMMMMGGGGGGGGGGAASSVV FEW SS
			  //CCTTRRRRRR0000111111DD  PP T S TT
			  //HH  GGGGGG0011001122    PP   P OO
			  //KK  0011CC              12   Y PP
			  //11                               
			33'bxxxxxxxxxx1xxxxxxxxxxxxx00001xx0x : ICPENO=1'b1; //Invpp	MRG00	-	
			33'bxxxxxxxxxx1xxxxxxxxxxxx100101xx0x : ICPENO=1'b1; //Cpt	MRG00	Invpp	DIS
			33'bxxxxxxxxxx1xxxxxxxxxxxx100011xx0x : ICPENO=1'b1; //Ireft	MRG00	Invpp	DIS
			33'bxxxxxxxxxxxx1xxxxxxxxxxx00001xx0x : ICPENO=1'b1; //Invpp	MRG01	-	
			33'bxxxxxxxxxxxx1xxxxxxxxxx100101xx0x : ICPENO=1'b1; //Cpt	MRG01	Invpp	DIS
			33'bxxxxxxxxxxxx1xxxxxxxxxx100011xx0x : ICPENO=1'b1; //Ireft	MRG01	Invpp	DIS
			33'bxxxxxxxxxxxxxx1xxxxxxxxx00001xx0x : ICPENO=1'b1; //Invpp	MRG10	-	
			33'bxxxxxxxxxxxxxx1xxxxxxxx100101xx0x : ICPENO=1'b1; //Cpt	MRG10	Invpp	DIS
			33'bxxxxxxxxxxxxxx1xxxxxxxx100011xx0x : ICPENO=1'b1; //Ireft	MRG10	Invpp	DIS
			33'bxxxxxxxxxxxxxxxx1xxxxxxx00001xx0x : ICPENO=1'b1; //Invpp	MRG11	-	
			33'bxxxxxxxxxxxxxxxx1xxxxxx100101xx0x : ICPENO=1'b1; //Cpt	MRG11	Invpp	DIS
			33'bxxxxxxxxxxxxxxxx1xxxxxx100011xx0x : ICPENO=1'b1; //Ireft	MRG11	Invpp	DIS
			33'bxxxxxxxxxxxxxxxxxx1xxxxx00001xx0x : ICPENO=1'b1; //Invpp	MRG12	-	
			33'bxxxxxxxxxxxxxxxxxx1xxxx100101xx0x : ICPENO=1'b1; //Cpt	MRG12	Invpp	DIS
			33'bxxxxxxxxxxxxxxxxxx1xxxx100011xx0x : ICPENO=1'b1; //Ireft	MRG12	Invpp	DIS
			33'bxxxxxxxxxxx1xxxxxxxxxxxx00000xxx0 : ICPENO=1'b1; //-		Invpp	MRG00
			33'bxxxxxxxxxxx1xxxxxxxxxx1x00010xxx0 : ICPENO=1'b1; //Invpp	DIS	Ireft	MRG00
			33'bxxxxxxxxxxxxx1xxxxxxxxxx00000xxx0 : ICPENO=1'b1; //-		Invpp	MRG01
			33'bxxxxxxxxxxxxx1xxxxxxxx1x00010xxx0 : ICPENO=1'b1; //Invpp	DIS	Ireft	MRG01
			33'bxxxxxxxxxxxxxxx1xxxxxxxx00000xxx0 : ICPENO=1'b1; //-		Invpp	MRG10
			33'bxxxxxxxxxxxxxxx1xxxxxx1x00010xxx0 : ICPENO=1'b1; //Invpp	DIS	Ireft	MRG10
			33'bxxxxxxxxxxxxxxxxx1xxxxxx00000xxx0 : ICPENO=1'b1; //-		Invpp	MRG11
			33'bxxxxxxxxxxxxxxxxx1xxxx1x00010xxx0 : ICPENO=1'b1; //Invpp	DIS	Ireft	MRG11
			33'bxxxxxxxxxxxxxxxxxxx1xxxx00000xxx0 : ICPENO=1'b1; //-		Invpp	MRG12
			33'bxxxxxxxxxxxxxxxxxxx1xx1x00010xxx0 : ICPENO=1'b1; //Invpp	DIS	Ireft	MRG12
			33'bxxxxxxxxxxxxxxxxxxxxx1xx0000010x0 : ICPENO=1'b1; //-		Invpp	READ
			33'bxxxxxxxxxxxxxxxxxxxxx11x0001010x0 : ICPENO=1'b1; //Invpp	DIS	Ireft	READ
			33'bx1xxxxxxxxxxxxxxxxxxxx1x1000010x0 : ICPENO=1'b1; //Invpp	DIS	Extvpp1	IONCHK
			33'bxxxxx1xxxxxxxxxxxxxxxx1x0000010x0 : ICPENO=1'b1; //Invpp	DIS	Invpp	RDMRG0
			33'bxxxxx1xxxxxxxxxxxxxxxx1x0001010x0 : ICPENO=1'b1; //Invpp	DIS	Ireft	RDMRG0
			33'bxxxxxxx1xxxxxxxxxxxxxx1x0000010x0 : ICPENO=1'b1; //Invpp	DIS	Invpp	RDMRG1
			33'bxxxxxxx1xxxxxxxxxxxxxx1x0001010x0 : ICPENO=1'b1; //Invpp	DIS	Ireft	RDMRG1
			33'bxxxxxxxxx1xxxxxxxxxxxx1x1000010x0 : ICPENO=1'b1; //Invpp	DIS	Extvpp1	RDMRGC
			33'bxxxxxxxxxxxxxxxxxxxx1xxx00001100x : ICPENO=1'b1; //Invpp	READ	-	
			33'bxxxxxxxxxxxxxxxxxxxx1xx100101100x : ICPENO=1'b1; //Cpt	READ	Invpp	DIS
			33'bxxxxxxxxxxxxxxxxxxxx1xx100011100x : ICPENO=1'b1; //Ireft	READ	Invpp	DIS
			33'b1xxxxxxxxxxxxxxxxxxxxxx110001100x : ICPENO=1'b1; //Extvpp1	IONCHK1	Invpp	DIS
			33'b1xxxxxxxxxxxxxxxxxxxxxx100101100x : ICPENO=1'b1; //Cpt	IONCHK1	Invpp	DIS
			33'bxx11xxxxxxxxxxxxxxxxxxxx00001xx00 : ICPENO=1'b1; //Invpp	CPBT	Invpp	CPBT
			33'bxx11xxxxxxxxxxxxxxxxxxxx10001xx00 : ICPENO=1'b1; //Extvpp1	CPBT	Extvpp1	CPBT
			33'bxx11xxxxxxxxxxxxxxxxxxxx00101xx00 : ICPENO=1'b1; //Cpt	CPBT	Cpt	CPBT
			33'bxx11xxxxxxxxxxxxxxxxxxxx10101xx00 : ICPENO=1'b1; //Cpt+Ex1	CPBT	Cpt+Ex1	CPBT
			33'bxxxx1xxxxxxxxxxxxxxxxxx1000011000 : ICPENO=1'b1; //Invpp	RDMRG0	Invpp	DIS
			33'bxxxx1xxxxxxxxxxxxxxxxxx1001011000 : ICPENO=1'b1; //Cpt	RDMRG0	Invpp	DIS
			33'bxxxx1xxxxxxxxxxxxxxxxxx1000111000 : ICPENO=1'b1; //Ireft	RDMRG0	Invpp	DIS
			33'bxxxxxx1xxxxxxxxxxxxxxxx1000011000 : ICPENO=1'b1; //Invpp	RDMRG1	Invpp	DIS
			33'bxxxxxx1xxxxxxxxxxxxxxxx1001011000 : ICPENO=1'b1; //Cpt	RDMRG1	Invpp	DIS
			33'bxxxxxx1xxxxxxxxxxxxxxxx1000111000 : ICPENO=1'b1; //Ireft	RDMRG1	Invpp	DIS
			33'bxxxxxxxx1xxxxxxxxxxxxxx1100011000 : ICPENO=1'b1; //Extvpp1	RDMRGC	Invpp	DIS
			33'bxxxxxxxx1xxxxxxxxxxxxxx1001011000 : ICPENO=1'b1; //Cpt	RDMRGC	Invpp	DIS
			default                               : ICPENO=1'b0;
		endcase
	end


        // icpenw_p to ICPENW
        wire ICPENW;
        QNSC3NCP1V2_CPL3_ICPENW CPL3_ICPENW (
            // input port
            .MD_MSWR(MD_MSWR),  .MD_DMSWR(MD_DMSWR),
            .MD_WDT1(MD_WDT1),  .MD_DWDT1(MD_DWDT1),
            .MD_WDT2(MD_WDT2),  .MD_DWDT2(MD_DWDT2),
            .MD_WDT3(MD_WDT3),  .MD_DWDT3(MD_DWDT3),
            .MD_WDT4(MD_WDT4),  .MD_DWDT4(MD_DWDT4),
            .MD_WWR(MD_WWR),    .MD_DWWR(MD_DWWR),
            .MD_READ(MD_READ),  .MD_DREAD(MD_DREAD),
            .MD_DIS(MD_DIS),    .MD_DDIS(MD_DDIS),
            .MD_EXTVPP1(MD_EXTVPP1),
            .MD_EXTVPP2(MD_EXTVPP2),
            .MD_CPT(MD_CPT),
            .MD_IREFT(MD_IREFT),
            .MD_CWEE(MD_CWEE),
            .MD_MEOC(MD_MEOC),
            .MD_FLSTOP(MD_FLSTOP),  .MD_DFLSTOP(MD_DFLSTOP),
            .MD_OSCNOSTP(MD_OSCNOSTP),
            .MD_PROGI(MD_PROGI),
            // output port
            .ICPENW(ICPENW)
        );


	reg ICPENE;
	always @(MD_EXER or MD_DEXER or MD_CER or MD_DCER or MD_SER or
		MD_DSER or MD_READ or MD_DREAD or MD_DIS or MD_DDIS or
		MD_EXTVPP1 or MD_EXTVPP2 or MD_CPT or MD_CWEE or MD_FCLK1 or
		MD_FLSTOP or MD_DFLSTOP or MD_OSCNOSTP
		) begin
		casex({
		MD_EXER, MD_DEXER, MD_CER, MD_DCER, MD_SER,
		MD_DSER, MD_READ, MD_DREAD, MD_DIS, MD_DDIS,
		MD_EXTVPP1, MD_EXTVPP2, MD_CPT, MD_CWEE, MD_FCLK1,
		MD_FLSTOP, MD_DFLSTOP,MD_OSCNOSTP
		})
			  //         111111111
			  //123456789012345678
			  //MMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDD
			  //__________________
			  // D D D D DEECCF DO
			  //EECCSSRRDDXXPWCFFS
			  //XXEEEEEEIITTTELLLC
			  //EERRRRAASSVV EKSSN
			  //RR    DD  PP  1TTO
			  //          PP   OOS
			  //          12   PPT
			  //		     P
			18'bxx1xxxxxxx000110xx : ICPENE=1'b1; //Invpp	CER	-	
			18'bxx1xxxxxx1001110xx : ICPENE=1'b1; //Cpt	CER	Invpp	DIS
			18'bxx1xxxxxx1101110x0 : ICPENE=1'b1; //Cpt+Ex1	CER	Invpp	DIS
			18'bxxxx1xxxxx000110xx : ICPENE=1'b1; //Invpp	SER	-	
			18'bxxxx1xxxx1001110xx : ICPENE=1'b1; //Cpt	SER	Invpp	DIS
			18'bxxxx1xxxx1101110xx : ICPENE=1'b1; //Cpt+Ex1	SER	Invpp	DIS
			18'bxxx1xxxxxx00001x0x : ICPENE=1'b1; //-		Invpp	CER
			18'bxxxxx1xxxx00001x0x : ICPENE=1'b1; //-		Invpp	SER
			18'bx1xxxxxxxx00001x0x : ICPENE=1'b1; //-	---	Invpp	EXER
			18'b1xxxxxxxxx000110xx : ICPENE=1'b1; //Invpp	EXER	-       ---
			18'b1xxxxxxxx1001110xx : ICPENE=1'b1; //Cpt	EXER	Invpp	DIS
			18'b1xxxxxxxx1101110xx : ICPENE=1'b1; //Cpt+Ex1	EXER	Invpp	DIS
			default                : ICPENE=1'b0;
		endcase
	end

	output IL_CPEN;
	assign IL_CPEN = (ICPENO | ICPENW | ICPENE) & ~MD_TRMREAD12;

	output IL_READ;
	reg il_read_r;
	always @(MD_IONCHK1 or MD_DIONCHK1 or MD_STCHK or MD_DSTCHK or MD_RDT or
		MD_DRDT or MD_RDMRG0 or MD_DRDMRG0 or MD_RDMRG1 or MD_DRDMRG1 or
		MD_RDMRGC or MD_DRDMRGC or MD_MRG00 or MD_DMRG00 or MD_MRG01 or
		MD_DMRG01 or MD_MRG10 or MD_DMRG10 or MD_MRG11 or MD_DMRG11 or
		MD_MRG12 or MD_DMRG12 or MD_READ or MD_DREAD or SCANMODE or
		TESDBT
		) begin
		casex({
		MD_IONCHK1, MD_DIONCHK1, MD_STCHK, MD_DSTCHK, MD_RDT,
		MD_DRDT, MD_RDMRG0, MD_DRDMRG0, MD_RDMRG1, MD_DRDMRG1,
		MD_RDMRGC, MD_DRDMRGC, MD_MRG00, MD_DMRG00, MD_MRG01,
		MD_DMRG01, MD_MRG10, MD_DMRG10, MD_MRG11, MD_DMRG11,
		MD_MRG12, MD_DMRG12, MD_READ, MD_DREAD, SCANMODE,
		TESDBT
		})
			  //         11111111112222222
			  //12345678901234567890123456
			  //MMMMMMMMMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDDDDDDDDD
			  //__________________________
			  // D D D D D D D D D D D DST
			  //IISSRRRRRRRRMMMMMMMMMMRRCE
			  //OOTTDDDDDDDDRRRRRRRRRREEAS
			  //NNCCTTMMMMMMGGGGGGGGGGAAND
			  //CCHH  RRRRRR0000111111DDMB
			  //HHKK  GGGGGG0011001122  OT
			  //KK    0011CC            D 
			  //11                      E 
			26'b1xxxxxxxxxxxxxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bx1xxxxxxxxxxxxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxx1xxxxxxxxxxxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxx1xxxxxxxxxxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxx1xxxxxxxxxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxx1xxxxxxxxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxx1xxxxxxxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxx1xxxxxxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxx1xxxxxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxx1xxxxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxx1xxxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxx1xxxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxx1xxxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxx1xxxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxxx1xxxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxxxx1xxxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxxxxx1xxxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxxxxxx1xxxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxxxxxxx1xxxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxxxxxxxx1xxxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxxxxxxxxx1xxxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxxxxxxxxxx1xxxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxxxxxxxxxxx1xxx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxxxxxxxxxxxx1xx : il_read_r=1'b1;
			26'bxxxxxxxxxxxxxxxxxxxxxxxx11 : il_read_r=1'b1;
			default                        : il_read_r=1'b0;
		endcase
	end

	assign IL_READ = il_read_r & ~MD_TRMREAD12;

	output [15:0] IL_TRMCPWB;
	reg [15:0] IL_TRMCPWB;

	always @(TRMCP3 or TRMCP2 or TRMCP1 or TRMCP0) begin
		case ({TRMCP3, TRMCP2, TRMCP1, TRMCP0})
			4'b0000 : IL_TRMCPWB = 16'b1111111111111110;
			4'b0001 : IL_TRMCPWB = 16'b1111111111111101;
			4'b0010 : IL_TRMCPWB = 16'b1111111111111011;
			4'b0011 : IL_TRMCPWB = 16'b1111111111110111;
			4'b0100 : IL_TRMCPWB = 16'b1111111111101111;
			4'b0101 : IL_TRMCPWB = 16'b1111111111011111;
			4'b0110 : IL_TRMCPWB = 16'b1111111110111111;
			4'b0111 : IL_TRMCPWB = 16'b1111111101111111;
			4'b1000 : IL_TRMCPWB = 16'b1111111011111111;
			4'b1001 : IL_TRMCPWB = 16'b1111110111111111;
			4'b1010 : IL_TRMCPWB = 16'b1111101111111111;
			4'b1011 : IL_TRMCPWB = 16'b1111011111111111;
			4'b1100 : IL_TRMCPWB = 16'b1110111111111111;
			4'b1101 : IL_TRMCPWB = 16'b1101111111111111;
			4'b1110 : IL_TRMCPWB = 16'b1011111111111111;
			4'b1111 : IL_TRMCPWB = 16'b0111111111111111;
		endcase
	end

	output IL_CPWESWEN;
        wire il_cpweswen_b;
        QNSC3NCP1V2_CPL3_IL_CPWESWEN CPL3_IL_CPWESWEN (
            // input port
            .MD_MSWR(MD_MSWR),     .MD_DMSWR(MD_DMSWR),
            .MD_EXER(MD_EXER),     .MD_DEXER(MD_DEXER),
            .MD_CPBT(MD_CPBT),     .MD_DCPBT(MD_DCPBT),
            .MD_WDT1(MD_WDT1),     .MD_DWDT1(MD_DWDT1),
            .MD_WDT2(MD_WDT2),     .MD_DWDT2(MD_DWDT2),
            .MD_WDT3(MD_WDT3),     .MD_DWDT3(MD_DWDT3),
            .MD_WDT4(MD_WDT4),     .MD_DWDT4(MD_DWDT4),
            .MD_WWR(MD_WWR),       .MD_DWWR(MD_DWWR),
            .MD_CER(MD_CER),       .MD_DCER(MD_DCER),
            .MD_SER(MD_SER),       .MD_DSER(MD_DSER),
            .MD_EXTVPP1(MD_EXTVPP1),
            .MD_EXTVPP2(MD_EXTVPP2),
            .MD_CPT(MD_CPT),
            .MD_IREFT(MD_IREFT),
            .MD_MEOC(MD_MEOC),
            .MD_OSCNOSTP(MD_OSCNOSTP),
            .IL_VCPDWNL(IL_VCPDWNL),
            // output port
            //.IL_CPWESWEN(IL_CPWESWEN)
            .il_cpweswen_b(il_cpweswen_b)
        );
	assign IL_CPWESWEN = ~il_cpweswen_b;


	wire il_cprgvdb_p1, il_cprgvdb_p3;
        //wire il_cprgvdb_p2;
        //wire il_cprgvdb_p4;
        wire il_cprgvdb_p5;

	output IL_CPRSWEN;
	wire il_cprswen_p1, il_cprswen_p2, il_cprswen_p3;
	assign il_cprswen_p1 = ( MD_CPT & MD_EXTVPP1 & MD_OSCNOSTP | ~MD_CPT & MD_EXTVPP2 ) ;
	assign il_cprswen_p2 = ~MD_CPT & MD_EXTVPP1;
	assign il_cprswen_p3 = ( ~MD_CPT & MD_EXTVPP1 ) & 
     				( MD_CWEE & ( MD_IONCHK1  | MD_RDMRGC  | MD_STCHK  ) |
      				~MD_CWEE & ( MD_DIONCHK1 | MD_DRDMRGC | MD_DSTCHK ));

	assign IL_CPRSWEN = ~IL_CPWESWEN & ~il_cprswen_p1 & ~il_cprswen_p2 | il_cprswen_p3;

	output IL_CPRGVDB;
	assign IL_CPRGVDB = IL_CPRSWEN | IL_WRITE | IWRITE;

//	assign il_cprgvdb_p2 = MD_IONCHK1 | MD_DIONCHK1 | MD_RDMRGC | MD_DRDMRGC | MD_STCHK | MD_DSTCHK;

	output IL_DPRSWEN;
	assign IL_DPRSWEN =   ( ~il_cprgvdb_p5 & ~il_cprgvdb_p1 )
                            | il_cprgvdb_p3;
	assign il_cprgvdb_p1 =
		(
			(~MD_CPT & MD_EXTVPP1) & 
			((~MD_CWEE & (MD_READ  | MD_RDMRG0  | MD_RDMRG1 )) |
			 ( MD_CWEE & (MD_DREAD | MD_DRDMRG0 | MD_DRDMRG1)))
		);
	
	assign il_cprgvdb_p3 = (~MD_CPT & MD_EXTVPP1 & (MD_RDT | MD_DRDT));

        //assign il_cprgvdb_p4 = ~MD_CPT & MD_EXTVPP2 & (   MD_WWR  | MD_DWWR
        //                                                | MD_MSWR | MD_DMSWR
        //                                                | MD_WDT1 | MD_DWDT1
        //                                                | MD_WDT2 | MD_DWDT2 );

        assign il_cprgvdb_p5 = ~MD_CPT & MD_EXTVPP2 & (   (~MD_CWEE & (MD_IONCHK1  | MD_RDMRGC ))
                                                        | ( MD_CWEE & (MD_DIONCHK1 | MD_DRDMRGC)) );


	output IL_DPRGVDB;
        wire ALPHA, MD_LSLPSUBCPT;
	assign IL_DPRGVDB = IL_CPENR | IL_REGREN | IL_VCPDISR | ALPHA;

        assign ALPHA =   ( MD_DIS  & (MD_DREAD | MD_DRDMRG0 | MD_DRDMRG1 | MD_DRDMRGC) &  MD_CWEE & MD_LSLPSUBCPT )
                       | ( MD_DDIS & (MD_READ  | MD_RDMRG0  | MD_RDMRG1  | MD_RDMRGC ) & ~MD_CWEE & MD_LSLPSUBCPT );

        assign MD_LSLPSUBCPT =   (   ((~MD_HISPEED & ~MD_RLOWSPY)         )
                                   | (( MD_HISPEED |  MD_RLOWSPY) & MD_SUB) )
                               & (~MD_EXTVPP1 & ~MD_EXTVPP2 & MD_CPT);


        //
        output OSCLFREQ;
        assign OSCLFREQ = ~(MD_CPBT | MD_DCPBT);

endmodule

module QNSC3NCP1V2_CPL3_ICPENW (
    // input port
    MD_MSWR, MD_DMSWR, MD_WDT1, MD_DWDT1, MD_WDT2,
    MD_DWDT2, MD_WDT3, MD_DWDT3, MD_WDT4, MD_DWDT4,
    MD_WWR, MD_DWWR, MD_READ, MD_DREAD, MD_DIS,
    MD_DDIS, MD_EXTVPP1, MD_EXTVPP2, MD_CPT, MD_IREFT,
    MD_CWEE, MD_MEOC, MD_FLSTOP, MD_DFLSTOP, MD_OSCNOSTP,
    MD_PROGI,
    // output port
    ICPENW
);

input MD_MSWR, MD_DMSWR, MD_WDT1, MD_DWDT1, MD_WDT2,
      MD_DWDT2, MD_WDT3, MD_DWDT3, MD_WDT4, MD_DWDT4,
      MD_WWR, MD_DWWR, MD_READ, MD_DREAD, MD_DIS,
      MD_DDIS, MD_EXTVPP1, MD_EXTVPP2, MD_CPT, MD_IREFT,
      MD_CWEE, MD_MEOC, MD_FLSTOP, MD_DFLSTOP, MD_OSCNOSTP;
input MD_PROGI;

output ICPENW;


	reg icpenw_p;
	always @(MD_MSWR or MD_DMSWR or MD_WDT1 or MD_DWDT1 or MD_WDT2 or
		MD_DWDT2 or MD_WDT3 or MD_DWDT3 or MD_WDT4 or MD_DWDT4 or
		MD_WWR or MD_DWWR or MD_READ or MD_DREAD or MD_DIS or
		MD_DDIS or MD_EXTVPP1 or MD_EXTVPP2 or MD_CPT or MD_IREFT or
		MD_CWEE or MD_MEOC or MD_FLSTOP or MD_DFLSTOP or MD_OSCNOSTP
		) begin
		casex({
		MD_MSWR, MD_DMSWR, MD_WDT1, MD_DWDT1, MD_WDT2,
		MD_DWDT2, MD_WDT3, MD_DWDT3, MD_WDT4, MD_DWDT4,
		MD_WWR, MD_DWWR, MD_READ, MD_DREAD, MD_DIS,
		MD_DDIS, MD_EXTVPP1, MD_EXTVPP2, MD_CPT, MD_IREFT,
		MD_CWEE, MD_MEOC, MD_FLSTOP, MD_DFLSTOP, MD_OSCNOSTP
		})

			  //         1111111111222222
			  //1234567890123456789012345
			  //MMMMMMMMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDDDDDDDD
			  //_________________________
			  // D D D D D D D DEECICM DO
			  //MMWWWWWWWWWWRRDDXXPRWEFFS
			  //SSDDDDDDDDWWEEIITTTEEOLLC
			  //WWTTTTTTTTRRAASSVV FECSSN
			  //RR11223344  DD  PP T  TTO
			  //                PP    OOS
			  //                12    PPT
			  //			    P
			25'bxxxxxxxxxx1xxxxx00001x0xx: icpenw_p=1'b1;/// Invpp	WWR	-	
			25'bxxxxxxxxxx1xxxx100101x0xx: icpenw_p=1'b1;/// Cpt	WWR	Invpp	DIS
			25'bxxxxxxxxxx1xxxx110101x0x0: icpenw_p=1'b1;/// Cpt+Ex1	WWR	Invpp	DIS
			25'bxxxxxxxxxx1xxxx100011x0xx: icpenw_p=1'b1;/// Ireft	WWR	Invpp	DIS
			25'bxxxxxxxxxxx1xxxx00000xx0x: icpenw_p=1'b1;/// -		Invpp	WWR
			25'bx1xxxxxxxxxxxx1x00000xx0x: icpenw_p=1'b1;/// Invpp	DIS	Invpp	MSWR
			25'bx1xxxxxxxxxxxx1x100001x0x: icpenw_p=1'b1;/// Invpp	DIS	Extvpp1	MSWR
			25'bxxx1xxxxxxxxxx1x00000xx0x: icpenw_p=1'b1;/// Invpp	DIS	Invpp	WDT1
			25'bxxxxx1xxxxxxxx1x00000xx0x: icpenw_p=1'b1;/// Invpp	DIS	Invpp	WDT2
			25'bxxxxxxx1xxxxxx1x00000xx0x: icpenw_p=1'b1;/// Invpp	DIS	Invpp	WDT3
			25'bxxxxxxxxx1xxxx1x00000xx0x: icpenw_p=1'b1;/// Invpp	DIS	Invpp	WDT4
			25'b1xxxxxxxxxxxxxx100001x0xx: icpenw_p=1'b1;/// Invpp	MSWR	Invpp	DIS
			25'b1xxxxxxxxxxxxxx100101x0xx: icpenw_p=1'b1;/// Cpt	MSWR	Invpp	DIS
			25'b1xxxxxxxxxxxxxx110101x0xx: icpenw_p=1'b1;/// Cpt+Ex1	MSWR	Invpp	DIS
			25'b1xxxxxxxxxxxxxx100011x0xx: icpenw_p=1'b1;/// Ireft	MSWR	Invpp	DIS
			25'b1xxxxxxxxxxxxxx11000110xx: icpenw_p=1'b1;/// Invpp	MSWR	Invpp	DIS
			25'bxx11xxxxxxxxxxxx00001x00x: icpenw_p=1'b1;/// Invpp	WDT1	Invpp	WDT1
			25'bxx1xxxxxxxxxxxx100001x0xx: icpenw_p=1'b1;/// Invpp	WDT1	Invpp	DIS
			25'bxx1xxxxxxxxxxxx100101x0xx: icpenw_p=1'b1;/// Cpt	WDT1	Invpp	DIS
			25'bxx1xxxxxxxxxxxx110101x0xx: icpenw_p=1'b1;/// Cpt+Ex1	WDT1	Invpp	DIS
			25'bxxxx11xxxxxxxxxx00001x00x: icpenw_p=1'b1;/// Invpp	WDT2	Invpp	WDT2
			25'bxxxx1xxxxxxxxxx100001x0xx: icpenw_p=1'b1;/// Invpp	WDT2	Invpp	DIS
			25'bxxxx1xxxxxxxxxx100101x0xx: icpenw_p=1'b1;/// Cpt	WDT2	Invpp	DIS
			25'bxxxx1xxxxxxxxxx110101x0xx: icpenw_p=1'b1;/// Cpt+Ex1	WDT2	Invpp	DIS
			25'bxxxxxx11xxxxxxxx00001x00x: icpenw_p=1'b1;/// Invpp	WDT3	Invpp	WDT3
			25'bxxxxxx1xxxxxxxx100001x0xx: icpenw_p=1'b1;/// Invpp	WDT3	Invpp	DIS
			25'bxxxxxx1xxxxxxxx100101x0xx: icpenw_p=1'b1;/// Cpt	WDT3	Invpp	DIS
			25'bxxxxxx1xxxxxxxx110101x0xx: icpenw_p=1'b1;/// Cpt+Ex1	WDT3	Invpp	DIS
			25'bxxxxxxxx11xxxxxx00001x00x: icpenw_p=1'b1;/// Invpp	WDT4	Invpp	WDT4
			25'bxxxxxxxx1xxxxxx100101x0xx: icpenw_p=1'b1;/// Cpt	WDT4	Invpp	DIS
			25'bxxxxxxxx1xxxxxx110101x0xx: icpenw_p=1'b1;/// Cpt+Ex1	WDT4	Invpp	DIS
			default                      : icpenw_p=1'b0;
		endcase
	end

	reg ICPENW;
	//synopsys async_set_reset "icpenw_p"
	always @(negedge MD_PROGI or negedge icpenw_p) begin
		if (~icpenw_p) ICPENW <= 1'b0;
		else           ICPENW <= 1'b1;
	end

endmodule

module QNSC3NCP1V2_CPL3_IL_ERASE (
    // input port
    MD_SER, MD_DSER, MD_CER, MD_DCER, MD_EXER, MD_DEXER,
    MD_CPBT, MD_DCPBT,
    MD_FCLK1,
    IL_VCPDWNL,
    // output port
    IERASE,
    IL_ERASE
);

input MD_SER, MD_DSER, MD_CER, MD_DCER, MD_EXER, MD_DEXER,
      MD_CPBT, MD_DCPBT;
input MD_FCLK1;
input IL_VCPDWNL;

output IERASE;
output IL_ERASE;


	wire IERASE;
	assign IERASE = (MD_SER | MD_DSER | MD_CER | MD_DCER | MD_EXER
			| MD_DEXER | MD_CPBT | MD_DCPBT);

	wire IERASES;
	assign IERASES = MD_FCLK1 & IERASE | MD_CPBT | MD_DCPBT;

	wire il_erase_b;
	TBLAHQRBX1 la0 (.H01(1'b1), .H02(~IL_VCPDWNL), .H03(~IERASES), .N01(il_erase_b));
        wire IL_ERASE;
	assign IL_ERASE = ~il_erase_b;

endmodule

module QNSC3NCP1V2_CPL3_IL_CPWESWEN (
    // input port
    MD_MSWR, MD_DMSWR, MD_EXER, MD_DEXER, MD_CPBT,
    MD_DCPBT, MD_WDT1, MD_DWDT1, MD_WDT2, MD_DWDT2,
    MD_WDT3, MD_DWDT3, MD_WDT4, MD_DWDT4, MD_WWR,
    MD_DWWR, MD_CER, MD_DCER, MD_SER, MD_DSER,
    MD_EXTVPP1, MD_EXTVPP2, MD_CPT, MD_IREFT, MD_MEOC,
    MD_OSCNOSTP,
    IL_VCPDWNL,
    // output port
    //IL_CPWESWEN
    il_cpweswen_b
);

input MD_MSWR, MD_DMSWR, MD_EXER, MD_DEXER, MD_CPBT,
      MD_DCPBT, MD_WDT1, MD_DWDT1, MD_WDT2, MD_DWDT2,
      MD_WDT3, MD_DWDT3, MD_WDT4, MD_DWDT4, MD_WWR,
      MD_DWWR, MD_CER, MD_DCER, MD_SER, MD_DSER,
      MD_EXTVPP1, MD_EXTVPP2, MD_CPT, MD_IREFT, MD_MEOC,
      MD_OSCNOSTP;
input IL_VCPDWNL;

//output IL_CPWESWEN;
output il_cpweswen_b;


	reg il_cpweswen_p1;
	always @(MD_MSWR or MD_DMSWR or MD_EXER or MD_DEXER or MD_CPBT or
		MD_DCPBT or MD_WDT1 or MD_DWDT1 or MD_WDT2 or MD_DWDT2 or
		MD_WDT3 or MD_DWDT3 or MD_WDT4 or MD_DWDT4 or MD_WWR or
		MD_DWWR or MD_CER or MD_DCER or MD_SER or MD_DSER or
		MD_EXTVPP1 or MD_EXTVPP2 or MD_CPT or MD_IREFT or MD_MEOC or
		MD_OSCNOSTP
		) begin
		casex({
		MD_MSWR, MD_DMSWR, MD_EXER, MD_DEXER, MD_CPBT,
		MD_DCPBT, MD_WDT1, MD_DWDT1, MD_WDT2, MD_DWDT2,
		MD_WDT3, MD_DWDT3, MD_WDT4, MD_DWDT4, MD_WWR,
		MD_DWWR, MD_CER, MD_DCER, MD_SER, MD_DSER,
		MD_EXTVPP1, MD_EXTVPP2, MD_CPT, MD_IREFT, MD_MEOC,
		MD_OSCNOSTP
		})
			  //         11111111112222222
			  //12345678901234567890123456
			  //MMMMMMMMMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDDDDDDDDD
			  //__________________________
			  // D D D D D D D D D DEECIMO
			  //MMEECCWWWWWWWWWWCCSSXXPRES
			  //SSXXPPDDDDDDDDWWEEEETTTEOC
			  //WWEEBBTTTTTTTTRRRRRRVV FCN
			  //RRRRTT11223344      PP T O
			  //                    PP   S
			  //                    12   T
			  //                         P
			26'bxxxxxxxxxxxxxx1xxxxx000xxx : il_cpweswen_p1=1'b1;///WWR		内部モード/IREFT	-		
			26'bxxxxxxxxxxxxxx1xxxxx001xxx : il_cpweswen_p1=1'b1;///		CPTモード（W/E/R CP）			
			26'bxxxxxxxxxxxxxx1xxxxx101xx0 : il_cpweswen_p1=1'b1;///		CPTモード（分圧レベル）			
			26'bxxxxxxxxxxxxxxxx1xxx000xxx : il_cpweswen_p1=1'b1;///CER		内部モード	-		
			26'bxxxxxxxxxxxxxxxx1xxx001xxx : il_cpweswen_p1=1'b1;///		CPTモード（W/E/R CP）			
			26'bxxxxxxxxxxxxxxxx1xxx101xx0 : il_cpweswen_p1=1'b1;///		CPTモード（分圧レベル）			
			26'bxxxxxxxxxxxxxxxxxx1x000xxx : il_cpweswen_p1=1'b1;///SER		内部モード	-		
			26'bxxxxxxxxxxxxxxxxxx1x001xxx : il_cpweswen_p1=1'b1;///		CPTモード（W/E/R CP）			
			26'bxxxxxxxxxxxxxxxxxx1x101xx0 : il_cpweswen_p1=1'b1;///		CPTモード（分圧レベル）			
			26'b1xxxxxxxxxxxxxxxxxxx000xxx : il_cpweswen_p1=1'b1;///MSWR		内部モード/IREFT	-		
			26'b1xxxxxxxxxxxxxxxxxxx001xxx : il_cpweswen_p1=1'b1;///		CPTモード（W/E/R CP）			
			26'b1xxxxxxxxxxxxxxxxxxx101xx0 : il_cpweswen_p1=1'b1;///		CPTモード（分圧レベル）			
			26'b1xxxxxxxxxxxxxxxxxxx100x1x : il_cpweswen_p1=1'b1;///	ビット線クランプ書込	外部VPP1モード			
			26'bxx1xxxxxxxxxxxxxxxxx000xxx : il_cpweswen_p1=1'b1;///EXER		内部モード	-		
			26'bxx1xxxxxxxxxxxxxxxxx001xxx : il_cpweswen_p1=1'b1;///		CPTモード（W/E/R CP）
			26'bxx1xxxxxxxxxxxxxxxxx101xxx : il_cpweswen_p1=1'b1;///		CPTモード（分圧レベル）			
			26'bxxxx11xxxxxxxxxxxxxxxxxxxx : il_cpweswen_p1=1'b1;///CPBT			CPBT		
			26'bxxxxxx1xxxxxxxxxxxxx000xxx : il_cpweswen_p1=1'b1;///WDT1		内部モード	-		
			26'bxxxxxx1xxxxxxxxxxxxx001xxx : il_cpweswen_p1=1'b1;///		CPTモード（W/E/R CP）			
			26'bxxxxxx1xxxxxxxxxxxxx101xxx : il_cpweswen_p1=1'b1;///		CPTモード（分圧レベル）			
			26'bxxxxxxxx1xxxxxxxxxxx000xxx : il_cpweswen_p1=1'b1;///WDT2		内部モード	-		
			26'bxxxxxxxx1xxxxxxxxxxx001xxx : il_cpweswen_p1=1'b1;///		CPTモード（W/E/R CP）			
			26'bxxxxxxxx1xxxxxxxxxxx101xxx : il_cpweswen_p1=1'b1;///		CPTモード（分圧レベル）			
			26'bxxxxxxxxxx1xxxxxxxxx000xxx : il_cpweswen_p1=1'b1;///WDT3		内部モード	-		
			26'bxxxxxxxxxx1xxxxxxxxx001xxx : il_cpweswen_p1=1'b1;///		CPTモード（W/E/R CP）			
			26'bxxxxxxxxxx1xxxxxxxxx101xxx : il_cpweswen_p1=1'b1;///		CPTモード（分圧レベル）			
			26'bxxxxxxxxxxxx1xxxxxxx000xxx : il_cpweswen_p1=1'b1;///WDT4		内部モード	-		
			26'bxxxxxxxxxxxx1xxxxxxx001xxx : il_cpweswen_p1=1'b1;///		CPTモード（W/E/R CP）			
			26'bxxxxxxxxxxxx1xxxxxxx101xxx : il_cpweswen_p1=1'b1;///		CPTモード（分圧レベル）			
			26'bxxxxxxxxxxxxxxx1xxxx0000xx : il_cpweswen_p1=1'b1;///-			WWR		内部モード
			26'bxxxxxxxxxxxxxxxxx1xx000xxx : il_cpweswen_p1=1'b1;///			CER		内部モード
			26'bxxxxxxxxxxxxxxxxxxx1000xxx : il_cpweswen_p1=1'b1;///			SER		内部モード
			26'bx1xxxxxxxxxxxxxxxxxx0000xx : il_cpweswen_p1=1'b1;///			MSWR		内部モード
			26'bx1xxxxxxxxxxxxxxxxxx100x1x : il_cpweswen_p1=1'b1;///					ビット線クランプ書込
			26'bxxx1xxxxxxxxxxxxxxxx000xxx : il_cpweswen_p1=1'b1;///			EXER		内部モード
			26'bxxxxxxx1xxxxxxxxxxxx000xxx : il_cpweswen_p1=1'b1;///			WDT1		内部モード
			26'bxxxxxxxxx1xxxxxxxxxx000xxx : il_cpweswen_p1=1'b1;///			WDT2		内部モード
			26'bxxxxxxxxxxx1xxxxxxxx000xxx : il_cpweswen_p1=1'b1;///			WDT3		内部モード
			26'bxxxxxxxxxxxxx1xxxxxx000xxx : il_cpweswen_p1=1'b1;///			WDT4		内部モード
			default                        : il_cpweswen_p1=1'b0;
		endcase
	end

	wire il_cpweswen_b;
	wire il_cpweswen_b_1, il_cpweswen_b_2, il_cpweswen_b_3;
	//TBLAHQRBX1 la1 (.H01(1'b1), .H02(~IL_VCPDWNL), .H03(~il_cpweswen_p1), .N01(il_cpweswen_b));
	TBLAHQRBX1 la1_1 (.H01(1'b1), .H02(~IL_VCPDWNL), .H03(~il_cpweswen_p1), .N01(il_cpweswen_b_1));
	TBLAHQRBX1 la1_2 (.H01(1'b1), .H02(~IL_VCPDWNL), .H03(~il_cpweswen_p1), .N01(il_cpweswen_b_2));
	TBLAHQRBX1 la1_3 (.H01(1'b1), .H02(~IL_VCPDWNL), .H03(~il_cpweswen_p1), .N01(il_cpweswen_b_3));
        // 3-bit Majority Gate
        assign il_cpweswen_b = (il_cpweswen_b_1 & il_cpweswen_b_2) | (il_cpweswen_b_2 & il_cpweswen_b_3) | (il_cpweswen_b_1 & il_cpweswen_b_3);
	//assign IL_CPWESWEN = ~il_cpweswen_b;

endmodule


///=============================================================================
///CPL4 READ CP control
///  Ver2.00 2010/06/10 Renewal from QNSC3NCP0V1 for MTEG
///
///=============================================================================

module QNSC3NCP1V2_CPL4 (
	IL_CPRBR,
	IL_CPENR,
	IL_WRFCLK,
	IL_TRMCPRB,
	IL_TRMCPOB,
	MD_IONCHK1,
	MD_DIONCHK1,
//	MD_CPBT,
//	MD_DCPBT,
	MD_RDMRG0,
	MD_DRDMRG0,
	MD_RDMRG1,
	MD_DRDMRG1,
	MD_RDMRGC,
	MD_DRDMRGC,
	MD_WWR,
	MD_DWWR,
//	MD_CER,
//	MD_DCER,
//	MD_SER,
//	MD_DSER,
//	MD_MRG00,
//	MD_DMRG00,
//	MD_MRG01,
//	MD_DMRG01,
//	MD_MRG10,
//	MD_DMRG10,
//	MD_MRG11,
//	MD_DMRG11,
//	MD_MRG12,
//	MD_DMRG12,
	MD_MSWR,
	MD_DMSWR,
	MD_WDT1,
	MD_DWDT1,
	MD_WDT2,
	MD_DWDT2,
	MD_WDT3,
	MD_DWDT3,
	MD_WDT4,
	MD_DWDT4,
	MD_FCLK1,
	MD_READ,
	MD_DREAD,
	MD_DIS,
	MD_DDIS,
	MD_FLSTOP,
	MD_DFLSTOP,
	MD_EXTVPP1,
	MD_EXTVPP2,
	MD_CPT,
	MD_IREFT,
	MD_CWEE,
	MD_RLOWSPY,
	MD_SUB,
	RTRMCP18,
	RTRMCP19,
	RTRMCP20,
	MD_TRMREAD12,
	TRMCP4,
	TRMCP5,
	TRMCP6);

output	IL_CPRBR,
	IL_CPENR,
	IL_WRFCLK;
output	[7:0]	IL_TRMCPRB;
output	[7:0]	IL_TRMCPOB;

input	MD_IONCHK1,
	MD_DIONCHK1,
//	MD_CPBT,
//	MD_DCPBT,
	MD_RDMRG0,
	MD_DRDMRG0,
	MD_RDMRG1,
	MD_DRDMRG1,
	MD_RDMRGC,
	MD_DRDMRGC,
	MD_WWR,
	MD_DWWR,
//	MD_CER,
//	MD_DCER,
//	MD_SER,
//	MD_DSER,
//	MD_MRG00,
//	MD_DMRG00,
//	MD_MRG01,
//	MD_DMRG01,
//	MD_MRG10,
//	MD_DMRG10,
//	MD_MRG11,
//	MD_DMRG11,
//	MD_MRG12,
//	MD_DMRG12,
	MD_MSWR,
	MD_DMSWR,
	MD_WDT1,
	MD_DWDT1,
	MD_WDT2,
	MD_DWDT2,
	MD_WDT3,
	MD_DWDT3,
	MD_WDT4,
	MD_DWDT4,
	MD_FCLK1,
	MD_READ,
	MD_DREAD,
	MD_DIS,
	MD_DDIS,
	MD_FLSTOP,
	MD_DFLSTOP,
	MD_EXTVPP1,
	MD_EXTVPP2,
	MD_CPT,
	MD_IREFT,
	MD_CWEE,
	MD_RLOWSPY,
	MD_SUB,
	MD_TRMREAD12,
	RTRMCP18,
	RTRMCP19,
	RTRMCP20,
	TRMCP4,
	TRMCP5,
	TRMCP6;

	reg IL_CPENRDEC;
	always @(
		 MD_IONCHK1 or MD_DIONCHK1 or MD_RDMRG0 or MD_DRDMRG0 or MD_RDMRG1 or
                 MD_DRDMRG1 or MD_RDMRGC or MD_DRDMRGC or MD_EXTVPP1 or MD_CPT or 
                 MD_IREFT or MD_CWEE or MD_RLOWSPY or MD_SUB or MD_DIS or 
                 MD_READ or MD_DDIS or MD_DREAD or MD_FLSTOP or MD_DFLSTOP
		) begin
		casex({
		 MD_IONCHK1 , MD_DIONCHK1 , MD_RDMRG0 , MD_DRDMRG0 , MD_RDMRG1 ,
                 MD_DRDMRG1 , MD_RDMRGC , MD_DRDMRGC , MD_EXTVPP1 , MD_CPT , 
                 MD_IREFT , MD_CWEE , MD_RLOWSPY , MD_SUB , MD_DIS , 
                 MD_READ , MD_DDIS , MD_DREAD , MD_FLSTOP , MD_DFLSTOP
		})
			  //         11111111112
			  //12345678901234567890
			  //MMMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDDD
			  //____________________
			  // D D D DECICRS  DD D
			  //IIRRRRRRXPRWLUDRDRFF
			  //OODDDDDDTTEEOBIEIELL
			  //NNMMMMMMV FEW SASASS
			  //CCRRRRRRP T S  D DTT
			  //HHGGGGGGP   P     OO
			  //KK0011CC1   Y     PP
			  //11                          
			20'bxxxxxxxx000110xxx1x0 : IL_CPENRDEC=1'b1; //-		Invpp	READ
			20'bxxxxxxxx0011101xx1x0 : IL_CPENRDEC=1'b1; //Invpp	DIS	Ireft	READ
			20'bx1xxxxxx1001101xxxx0 : IL_CPENRDEC=1'b1; //Invpp	DIS	Extvpp1	IONCHK1
			20'bxxx1xxxx0001101xxxx0 : IL_CPENRDEC=1'b1; //Invpp	DIS	Invpp	RDMRG0
			20'bxxx1xxxx0011101xxxx0 : IL_CPENRDEC=1'b1; //Invpp	DIS	Ireft	RDMRG0
			20'bxxxxx1xx0001101xxxx0 : IL_CPENRDEC=1'b1; //Invpp	DIS	Invpp	RDMRG1
			20'bxxxxx1xx0011101xxxx0 : IL_CPENRDEC=1'b1; //Invpp	DIS	Ireft	RDMRG1
			20'bxxxxxxx11001101xxxx0 : IL_CPENRDEC=1'b1; //Invpp	DIS	Extvpp1	RDMRGC
			20'bxxxxxxxx000010x1xx0x : IL_CPENRDEC=1'b1; //Invpp	READ	-	
			20'bxxxxxxxx010010x11x0x : IL_CPENRDEC=1'b1; //Cpt	READ	Invpp	DIS
			20'bxxxxxxxx001010x11x0x : IL_CPENRDEC=1'b1; //Ireft	READ	Invpp	DIS
			20'b1xxxxxxx100010xx1x0x : IL_CPENRDEC=1'b1; //Extvpp1	IONCHK1	Invpp	DIS
			20'b1xxxxxxx010010xx1x0x : IL_CPENRDEC=1'b1; //Cpt	IONCHK1	Invpp	DIS
			20'bxx1xxxxx000010xx1x0x : IL_CPENRDEC=1'b1; //Invpp	RDMRG0	Invpp	DIS
			20'bxx1xxxxx010010xx1x0x : IL_CPENRDEC=1'b1; //Cpt	RDMRG0	Invpp	DIS
			20'bxx1xxxxx001010xx1x0x : IL_CPENRDEC=1'b1; //Ireft	RDMRG0	Invpp	DIS
			20'bxxxx1xxx000010xx1x0x : IL_CPENRDEC=1'b1; //Invpp	RDMRG1	Invpp	DIS
			20'bxxxx1xxx010010xx1x0x : IL_CPENRDEC=1'b1; //Cpt	RDMRG1	Invpp	DIS
			20'bxxxx1xxx001010xx1x0x : IL_CPENRDEC=1'b1; //Ireft	RDMRG1	Invpp	DIS
			20'bxxxxxx1x100010xx1x0x : IL_CPENRDEC=1'b1; //Extvpp1	RDMRGC	Invpp	DIS
			20'bxxxxxx1x010010xx1x0x : IL_CPENRDEC=1'b1; //Cpt	RDMRGC	Invpp	DIS
			default                  : IL_CPENRDEC=1'b0;
		endcase
	end

	assign IL_CPENR = IL_CPENRDEC & ~MD_TRMREAD12;


	reg IL_CPRBRDEC;
	always @(
		 MD_IONCHK1 or MD_DIONCHK1 or MD_RDMRG0 or MD_DRDMRG0 or MD_RDMRG1 or
                 MD_DRDMRG1 or MD_RDMRGC or MD_DRDMRGC or MD_EXTVPP1 or MD_EXTVPP2 or
                 MD_CPT or MD_IREFT or MD_CWEE or MD_RLOWSPY or MD_SUB or 
                 MD_DIS or MD_READ or MD_DDIS or MD_DREAD or MD_FLSTOP or MD_DFLSTOP
		) begin
		casex({
		 MD_IONCHK1 , MD_DIONCHK1 , MD_RDMRG0 , MD_DRDMRG0 , MD_RDMRG1 ,
                 MD_DRDMRG1 , MD_RDMRGC , MD_DRDMRGC , MD_EXTVPP1 , MD_EXTVPP2 ,
                 MD_CPT , MD_IREFT , MD_CWEE , MD_RLOWSPY , MD_SUB , 
                 MD_DIS , MD_READ , MD_DDIS , MD_DREAD , MD_FLSTOP , MD_DFLSTOP
		})
			  //         111111111122
			  //123456789012345678901
			  //MMMMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDDDD
			  //_____________________
			  // D D D DEECICRS  DD D
			  //IIRRRRRRXXPRWLUDRDRFF
			  //OODDDDDDTTTEEOBIEIELL
			  //NNMMMMMMVV FEW SASASS
			  //CCRRRRRRPP T S  D DTT
			  //HHGGGGGGPP   P     OO
			  //KK0011CC12   Y     PP
			  //11                                   
			21'bxxxxxxxx0000110xxx1x0 : IL_CPRBRDEC=1'b0; //-		Invpp	READ
			21'bxxxxxxxx10001101xx1x0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Extvpp1	READ
			21'bxxxxxxxx00011101xx1x0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Ireft	READ
		      //21'bxxxxxxxx00001101xx1x0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Invpp	READ  same as line 1
			21'bx1xxxxxx10001101xxxx0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Extvpp1	IONCHK1
			21'bx1xxxxxx01001101xxxx0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Extvpp2	IONCHK1
			21'bxxx1xxxx00001101xxxx0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Invpp	RDMRG0
			21'bxxx1xxxx10001101xxxx0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Extvpp1	RDMRG0
			21'bxxx1xxxx00011101xxxx0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Ireft	RDMRG0
			21'bxxxxx1xx00001101xxxx0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Invpp	RDMRG1
			21'bxxxxx1xx10001101xxxx0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Extvpp1	RDMRG1
			21'bxxxxx1xx00011101xxxx0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Ireft	RDMRG1
			21'bxxxxxxx110001101xxxx0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Extvpp1	RDMRGC
			21'bxxxxxxx101001101xxxx0 : IL_CPRBRDEC=1'b0; //Invpp	DIS	Extvpp2	RDMRGC
			21'bxxxxxxxx0000010x1xx0x : IL_CPRBRDEC=1'b0; //Invpp	READ	-	
			21'bxxxxxxxx1000010x11x0x : IL_CPRBRDEC=1'b0; //Extvpp1	READ	Invpp	DIS
			21'bxxxxxxxx0010010x11x0x : IL_CPRBRDEC=1'b0; //Cpt	READ	Invpp	DIS
			21'bxxxxxxxx0001010x11x0x : IL_CPRBRDEC=1'b0; //Ireft	READ	Invpp	DIS
			21'b1xxxxxxx1000010xx1x0x : IL_CPRBRDEC=1'b0; //Extvpp1	IONCHK1	Invpp	DIS
			21'b1xxxxxxx0100010xx1x0x : IL_CPRBRDEC=1'b0; //Extvpp2	IONCHK1	Invpp	DIS
			21'b1xxxxxxx0010010xx1x0x : IL_CPRBRDEC=1'b0; //Cpt	IONCHK1	Invpp	DIS
			21'bxx1xxxxx0000010xx1x0x : IL_CPRBRDEC=1'b0; //Invpp	RDMRG0	Invpp	DIS
			21'bxx1xxxxx1000010xx1x0x : IL_CPRBRDEC=1'b0; //Extvpp1	RDMRG0	Invpp	DIS
			21'bxx1xxxxx0010010xx1x0x : IL_CPRBRDEC=1'b0; //Cpt	RDMRG0	Invpp	DIS
			21'bxx1xxxxx0001010xx1x0x : IL_CPRBRDEC=1'b0; //Ireft	RDMRG0	Invpp	DIS
			21'bxxxx1xxx0000010xx1x0x : IL_CPRBRDEC=1'b0; //Invpp	RDMRG1	Invpp	DIS
			21'bxxxx1xxx1000010xx1x0x : IL_CPRBRDEC=1'b0; //Extvpp1	RDMRG1	Invpp	DIS
			21'bxxxx1xxx0010010xx1x0x : IL_CPRBRDEC=1'b0; //Cpt	RDMRG1	Invpp	DIS
			21'bxxxx1xxx0001010xx1x0x : IL_CPRBRDEC=1'b0; //Ireft	RDMRG1	Invpp	DIS
			21'bxxxxxx1x1000010xx1x0x : IL_CPRBRDEC=1'b0; //Extvpp1	RDMRGC	Invpp	DIS
			21'bxxxxxx1x0100010xx1x0x : IL_CPRBRDEC=1'b0; //Extvpp2	RDMRGC	Invpp	DIS
			21'bxxxxxx1x0010010xx1x0x : IL_CPRBRDEC=1'b0; //Cpt	RDMRGC	Invpp	DIS
			default                   : IL_CPRBRDEC=1'b1;
		endcase
	end

	assign IL_CPRBR = IL_CPRBRDEC | MD_TRMREAD12;

	reg IL_WRFCLK;
	always @(MD_WWR or MD_DWWR or MD_MSWR or MD_DMSWR or MD_WDT1 or
		MD_DWDT1 or MD_WDT2 or MD_DWDT2 or MD_WDT3 or MD_DWDT3 or
		MD_WDT4 or MD_DWDT4 or MD_FCLK1
		) begin
		casex({
		MD_WWR, MD_DWWR, MD_MSWR, MD_DMSWR, MD_WDT1,
		MD_DWDT1, MD_WDT2, MD_DWDT2, MD_WDT3, MD_DWDT3,
		MD_WDT4, MD_DWDT4, MD_FCLK1
		})
			  //         1111
			  //1234567890123
			  //MMMMMMMMMMMMM
			  //DDDDDDDDDDDDD
			  //_____________
			  // D D D D D DF
			  //WWMMWWWWWWWWC
			  //WWSSDDDDDDDDL
			  //RRWWTTTTTTTTK
			  //  RR112233441
			13'b1xxxxxxxxxxx1 : IL_WRFCLK=1'b1;
			13'bx1xxxxxxxxxx1 : IL_WRFCLK=1'b1;
			13'bxx1xxxxxxxxx1 : IL_WRFCLK=1'b1;
			13'bxxx1xxxxxxxx1 : IL_WRFCLK=1'b1;
			13'bxxxx1xxxxxxx1 : IL_WRFCLK=1'b1;
			13'bxxxxx1xxxxxx1 : IL_WRFCLK=1'b1;
			13'bxxxxxx1xxxxx1 : IL_WRFCLK=1'b1;
			13'bxxxxxxx1xxxx1 : IL_WRFCLK=1'b1;
			13'bxxxxxxxx1xxx1 : IL_WRFCLK=1'b1;
			13'bxxxxxxxxx1xx1 : IL_WRFCLK=1'b1;
			13'bxxxxxxxxxx1x1 : IL_WRFCLK=1'b1;
			13'bxxxxxxxxxxx11 : IL_WRFCLK=1'b1;
			default           : IL_WRFCLK=1'b0;
		endcase
	end

	reg [7:0] IL_TRMCPRB;
	always @(RTRMCP20 or RTRMCP19 or RTRMCP18) begin
		case ({RTRMCP20, RTRMCP19, RTRMCP18})
			3'b000 : IL_TRMCPRB = 8'b11111110;
			3'b001 : IL_TRMCPRB = 8'b11111101;
			3'b010 : IL_TRMCPRB = 8'b11111011;
			3'b011 : IL_TRMCPRB = 8'b11110111;
			3'b100 : IL_TRMCPRB = 8'b11101111;
			3'b101 : IL_TRMCPRB = 8'b11011111;
			3'b110 : IL_TRMCPRB = 8'b10111111;
			3'b111 : IL_TRMCPRB = 8'b01111111;
		endcase
	end

	reg [7:0] IL_TRMCPOB;
	always @(TRMCP6 or TRMCP5 or TRMCP4) begin
		case ({TRMCP6, TRMCP5, TRMCP4})
			3'b000 : IL_TRMCPOB = 8'b11111110;
			3'b001 : IL_TRMCPOB = 8'b11111101;
			3'b010 : IL_TRMCPOB = 8'b11111011;
			3'b011 : IL_TRMCPOB = 8'b11110111;
			3'b100 : IL_TRMCPOB = 8'b11101111;
			3'b101 : IL_TRMCPOB = 8'b11011111;
			3'b110 : IL_TRMCPOB = 8'b10111111;
			3'b111 : IL_TRMCPOB = 8'b01111111;
		endcase
	end

endmodule

///=============================================================================
///CPL5 CP,REG discharge control
///  Ver2.00 2010/06/10 Renewal from QNSC3NCP0V1 for MTEG
///
///=============================================================================

module QNSC3NCP1V2_CPL5 (
        IL_ERASE,
	IL_VCPDIS,
	IL_VCPDISR,
	IL_VCPDWNL,
	IL_VCPDWNLR,
	VBRESZCP,
	MD_DIS,
	MD_DDIS,
	MD_READ,
	MD_DREAD,
	MD_CER,
	MD_DCER,
	MD_SER,
	MD_DSER,
	MD_EXER,
	MD_DEXER,
	MD_CWEE,
	ICWEE,
	D_DETVCP,
	D_DETVCPR,
	MD_FLSTOP,
	MD_DFLSTOP,
	MD_EXTVPP1,
	MD_CPT,
	MD_RLOWSPY,
	MD_SUB,
	MD_HISPEED,
	MD_FCLK1,
	TRMRD2,
	IL_FIHFL4M,
	VBRESZ);

output	IL_VCPDIS,
	IL_VCPDISR,
	IL_VCPDWNL,
	IL_VCPDWNLR,
	VBRESZCP;

input	IL_ERASE,
        MD_DIS,
	MD_DDIS,
	MD_READ,
	MD_DREAD,
	MD_CER,
	MD_DCER,
	MD_SER,
	MD_DSER,
	MD_EXER,
	MD_DEXER,
	MD_CWEE,
	ICWEE,
	D_DETVCP,
	D_DETVCPR,
	MD_FLSTOP,
	MD_DFLSTOP,
	MD_EXTVPP1,
	MD_CPT,
	MD_RLOWSPY,
	MD_SUB,
	MD_HISPEED,
	MD_FCLK1,
	TRMRD2,
	IL_FIHFL4M,
	VBRESZ;

	//wire enable04, act04, enable04_a2, vcpdwnl_4;
	//wire erdis_reset;
        wire enable12_a1;
	wire enable01_dis, enable02_dis, enable02_a1_dis;
	wire enable11_dis, enable12_dis;
        //wire enable12_a1_dis;

	//IL_VCPDWNL ---------------------------------------------------------

        wire vcpdwnl_1;
        //wire enable01;
        QNSC3NCP1V2_CPL5_VCPDWNL_1 CPL5_VCPDWNL_1 (
            // input port
            .MD_HISPEED(MD_HISPEED),
            .MD_RLOWSPY(MD_RLOWSPY),
            .MD_SUB(MD_SUB),
            .ICWEE(ICWEE),
            .MD_FLSTOP(MD_FLSTOP),  .MD_DFLSTOP(MD_DFLSTOP),
            .MD_DIS(MD_DIS),        .MD_DDIS(MD_DDIS),
            .D_DETVCP(D_DETVCP),
            // output port
            .vcpdwnl_1(vcpdwnl_1)
            //.enable01(enable01)
        );

        wire vcpdwnl_2;
        //wire enable02;
        QNSC3NCP1V2_CPL5_VCPDWNL_2 CPL5_VCPDWNL_2 (
            // input port
            .MD_CPT(MD_CPT),
            .MD_EXTVPP1(MD_EXTVPP1),
            .MD_HISPEED(MD_HISPEED),
            .MD_RLOWSPY(MD_RLOWSPY),
            .MD_SUB(MD_SUB),
            .ICWEE(ICWEE),
            .MD_READ(MD_READ),  .MD_DREAD(MD_DREAD),
            .D_DETVCP(D_DETVCP),
            // output port
            .vcpdwnl_2(vcpdwnl_2)
            //.enable02(enable02)
        );

        wire vcpdwnl_3;
        //wire enable03;
        QNSC3NCP1V2_CPL5_VCPDWNL_3 CPL5_VCPDWNL_3 (
            // input port
            .ICWEE(ICWEE),
            .MD_SER(MD_SER),   .MD_DSER(MD_DSER),
            .MD_CER(MD_CER),   .MD_DCER(MD_DCER),
            .MD_EXER(MD_EXER), .MD_DEXER(MD_DEXER),
            .D_DETVCP(D_DETVCP),
            // output port
            .vcpdwnl_3(vcpdwnl_3)
            //.enable03(enable03)
        );

	assign IL_VCPDWNL = vcpdwnl_1 & vcpdwnl_2 & vcpdwnl_3;
        //wire vcpdwnl_123;
        //QNSC3NCP1V2_CPL5_VCPDWNL_123 CPL5_VCPDWNL_123 ( .enable01(enable01), .enable02(enable02), .enable03(enable03),
        //                                    .D_DETVCP(D_DETVCP), .vcpdwnl_123(vcpdwnl_123) );
	//assign IL_VCPDWNL = vcpdwnl_123;




	//IL_VCPDIS ----------------------------------------------------------
	assign enable01_dis = (  (   (MD_HISPEED | MD_RLOWSPY)
				   & ~MD_SUB
				   & ((MD_CWEE & MD_FLSTOP) | (~MD_CWEE & MD_DFLSTOP))
			         )
			       | (MD_CWEE & MD_DIS) | (~MD_CWEE & MD_DDIS)
                              );
	assign enable02_dis = ~MD_CPT & ~MD_EXTVPP1 & enable02_a1_dis;
	assign enable02_a1_dis =   (   (~MD_HISPEED & ~MD_RLOWSPY)
			             | ((MD_HISPEED | MD_RLOWSPY) & MD_SUB)
		                   )
		                 & ( (MD_READ & MD_CWEE) | (MD_DREAD & ~MD_CWEE) );

	//assign enable04 = enable04_a2;
	//assign act04 = ~IL_VCPDWNL;


        // ERDIS
        wire ERDIS;
        QNSC3NCP1V2_CPL5_ERDIS CPL5_ERDIS (
            // input port
            .ICWEE(ICWEE),
            .MD_SER(MD_SER),   .MD_DSER(MD_DSER),
            .MD_CER(MD_CER),   .MD_DCER(MD_DCER),
            .MD_EXER(MD_EXER), .MD_DEXER(MD_DEXER),
            .MD_FCLK1(MD_FCLK1),
            //.IL_VCPDWNL(IL_VCPDWNL),
            .IL_ERASE(IL_ERASE),
            // output port
            .ERDIS(ERDIS)
        );


	wire il_vcpdispf0,il_vcpdispf1,il_vcpdispf,in_vcpdispf;
	reg  rg_vcpdispf0,rg_vcpdispf1;
	assign in_vcpdispf = il_vcpdispf0 & ~TRMRD2;
	//synopsys async_set_reset "VBRESZ"
	always @(posedge IL_FIHFL4M or negedge VBRESZ) begin
		if (~VBRESZ) rg_vcpdispf0 <= 1'b1;
		else         rg_vcpdispf0 <= in_vcpdispf;
	end
	assign il_vcpdispf0 = rg_vcpdispf0;

	//synopsys async_set_reset "il_vcpdispf0"
	always @(D_DETVCP or il_vcpdispf0) begin
		if (~il_vcpdispf0) rg_vcpdispf1 <= 1'b0;
		else if(~D_DETVCP) rg_vcpdispf1 <= il_vcpdispf0;
	end
	assign il_vcpdispf1 = rg_vcpdispf1;
	assign il_vcpdispf = rg_vcpdispf0 & ~rg_vcpdispf1;
	assign IL_VCPDIS = (enable01_dis & vcpdwnl_1) | (enable02_dis & vcpdwnl_2) |
                           ERDIS | il_vcpdispf;
	//assign IL_VCPDIS = (enable01_dis & vcpdwnl_123) | (enable02_dis & vcpdwnl_123) |
        //                   ERDIS | il_vcpdispf;

///	//VBRESZCP ----------------------------------------------------------
	assign VBRESZCP = ~il_vcpdispf;

	//IL_VCPDWNLR --------------------------------------------------------

        wire vcpdwnlr_1;
        //wire enable11;
        QNSC3NCP1V2_CPL5_VCPDWNLR_1 CPL5_VCPDWNLR_1 (
            // input port
            .MD_HISPEED(MD_HISPEED),
            .MD_RLOWSPY(MD_RLOWSPY),
            .MD_SUB(MD_SUB),
            .ICWEE(ICWEE),
            .MD_FLSTOP(MD_FLSTOP),  .MD_DFLSTOP(MD_DFLSTOP),
            .MD_DIS(MD_DIS),        .MD_DDIS(MD_DDIS),
            .D_DETVCPR(D_DETVCPR),
            // output port
            .vcpdwnlr_1(vcpdwnlr_1)
            //.enable11(enable11)
        );

        wire vcpdwnlr_2;
        //wire enable12;
        QNSC3NCP1V2_CPL5_VCPDWNLR_2 CPL5_VCPDWNLR_2 (
            // input port
            .MD_CPT(MD_CPT),
            .MD_EXTVPP1(MD_EXTVPP1),
            .MD_HISPEED(MD_HISPEED),
            .MD_RLOWSPY(MD_RLOWSPY),
            .MD_SUB(MD_SUB),
            .ICWEE(ICWEE),
            .MD_READ(MD_READ),
            .MD_DREAD(MD_DREAD),
            .D_DETVCPR(D_DETVCPR),
            // output port
            .vcpdwnlr_2(vcpdwnlr_2),
            //.enable12(enable12),
            .enable12_a1(enable12_a1)
        );

	assign IL_VCPDWNLR = vcpdwnlr_1 & vcpdwnlr_2;
        //wire vcpdwnlr_12;
        //QNSC3NCP1V2_CPL5_VCPDWNLR_12 CPL5_VCPDWNLR_12 ( .enable11(enable11), .enable12(enable12),
        //                                    .D_DETVCPR(D_DETVCPR), .vcpdwnlr_12(vcpdwnlr_12) );
	//assign IL_VCPDWNLR = vcpdwnlr_12;




	//IL_VCPDISR ---------------------------------------------------------

	assign enable11_dis =
		(
			(
				(MD_HISPEED | MD_RLOWSPY)
				& ~MD_SUB
				& ((~MD_CWEE & MD_FLSTOP) | (MD_CWEE & MD_DFLSTOP))
			)
			| (~MD_CWEE & MD_DIS)
			| (MD_CWEE & MD_DDIS)
		);

	assign enable12_dis = ~MD_CPT & ~MD_EXTVPP1 & enable12_a1;

	//assign enable12_a1_dis =   (   (~MD_HISPEED & ~MD_RLOWSPY)
	//		             | ((MD_HISPEED | MD_RLOWSPY) & MD_SUB)
	//	                   )
	//	                 & ( (MD_READ & ~MD_CWEE) | (MD_DREAD & MD_CWEE) );

	assign IL_VCPDISR = (enable11_dis & vcpdwnlr_1) | (enable12_dis & vcpdwnlr_2);
	//assign IL_VCPDISR = (enable11_dis & vcpdwnlr_12) | (enable12_dis & vcpdwnlr_12);

endmodule

module QNSC3NCP1V2_CPL5_ERDIS (
    // input port
    ICWEE,
    MD_SER,   MD_DSER,
    MD_CER,   MD_DCER,
    MD_EXER,  MD_DEXER,
    MD_FCLK1,
    //IL_VCPDWNL,
    IL_ERASE,
    // output port
    ERDIS
);

input ICWEE;
input MD_SER,   MD_DSER,
      MD_CER,   MD_DCER,
      MD_EXER,  MD_DEXER;
input MD_FCLK1;
//input IL_VCPDWNL;
input IL_ERASE;

output ERDIS;


        wire enable04_a2;
	assign enable04_a2 =   (MD_SER  & ICWEE) | (MD_DSER  & ~ICWEE)
			     | (MD_CER  & ICWEE) | (MD_DCER  & ~ICWEE)
			     | (MD_EXER & ICWEE) | (MD_DEXER & ~ICWEE);

	wire er_fclk1;
	assign er_fclk1 = MD_FCLK1 & enable04_a2;

        reg ERDIS;
	//always @(negedge er_fclk1 or negedge IL_VCPDWNL) begin
	//	if (~IL_VCPDWNL) ERDIS <= 1'b0;
	//	else             ERDIS <= 1'b1;
	//end

	//synopsys async_set_reset "IL_ERASE"
	always @(negedge er_fclk1 or negedge IL_ERASE) begin
		if (~IL_ERASE) ERDIS <= 1'b0;
		else             ERDIS <= 1'b1;
	end

endmodule


//module QNSC3NCP1V2_CPL5_VCPDWNL_123 (
//    // input port
//    enable01,
//    enable02,
//    enable03,
//    D_DETVCP,
//    // output port
//    vcpdwnl_123
//);
//
//input enable01, enable02, enable03;
//input D_DETVCP;
//
//output vcpdwnl_123;
//
//
//    // ==== CPL5_VCPDWNL_123 ====
//    wire enable123;
//    wire act01;
//    assign enable123 = enable01 | enable02 | enable03;
//    assign act01 = ~D_DETVCP;
//
//    wire vcpdwnl_123_1, vcpdwnl_123_2, vcpdwnl_123_3;
//    //QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs123 (.set_b(enable123), .reset(act01), .out(vcpdwnl_123));
//    QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs123_1 (.set_b(enable123), .reset(act01), .out(vcpdwnl_123_1));
//    QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs123_2 (.set_b(enable123), .reset(act01), .out(vcpdwnl_123_2));
//    QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs123_3 (.set_b(enable123), .reset(act01), .out(vcpdwnl_123_3));
//    // 3-bit Majority Gate
//    assign vcpdwnl_123 = (vcpdwnl_123_1 & vcpdwnl_123_2) | (vcpdwnl_123_2 & vcpdwnl_123_3) | (vcpdwnl_123_1 & vcpdwnl_123_3);
//
//endmodule


module QNSC3NCP1V2_CPL5_VCPDWNL_1 (
    // input port
    MD_HISPEED, MD_RLOWSPY, MD_SUB,
    ICWEE,
    MD_FLSTOP, MD_DFLSTOP,
    MD_DIS, MD_DDIS,
    D_DETVCP,
    // output port
    vcpdwnl_1
    //enable01
);

input MD_HISPEED, MD_RLOWSPY, MD_SUB;
input ICWEE;
input MD_FLSTOP, MD_DFLSTOP,
      MD_DIS, MD_DDIS;
input D_DETVCP;

output vcpdwnl_1;
//output enable01;


	wire enable01;
        wire act01;
	assign enable01 = (   (   (MD_HISPEED | MD_RLOWSPY)
			        & ~MD_SUB
			        & ((ICWEE & MD_FLSTOP) | (~ICWEE & MD_DFLSTOP))
		      )
			    | ( ICWEE & MD_DIS) | (~ICWEE & MD_DDIS)
		          );
	assign act01 = ~D_DETVCP;

        wire vcpdwnl_1;
        wire vcpdwnl_1_1, vcpdwnl_1_2, vcpdwnl_1_3;
        //QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs1 (.set_b(enable01), .reset(act01), .out(vcpdwnl_1));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs1_1 (.set_b(enable01), .reset(act01), .out(vcpdwnl_1_1));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs1_2 (.set_b(enable01), .reset(act01), .out(vcpdwnl_1_2));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs1_3 (.set_b(enable01), .reset(act01), .out(vcpdwnl_1_3));
        // 3-bit Majority Gate
        assign vcpdwnl_1 = (vcpdwnl_1_1 & vcpdwnl_1_2) | (vcpdwnl_1_2 & vcpdwnl_1_3) | (vcpdwnl_1_1 & vcpdwnl_1_3);

endmodule

module QNSC3NCP1V2_CPL5_VCPDWNL_2 (
    // input port
    MD_CPT, MD_EXTVPP1,
    MD_HISPEED, MD_RLOWSPY, MD_SUB,
    ICWEE,
    MD_READ, MD_DREAD,
    D_DETVCP,
    // output port
    vcpdwnl_2
    //enable02
);

input MD_CPT, MD_EXTVPP1;
input MD_HISPEED, MD_RLOWSPY, MD_SUB;
input ICWEE;
input MD_READ, MD_DREAD;
input D_DETVCP;

output vcpdwnl_2;
//output enable02;

	wire enable02, enable02_a1, act02;
	assign enable02 = ~MD_CPT & ~MD_EXTVPP1 & enable02_a1;
	assign enable02_a1 =   (   (~MD_HISPEED & ~MD_RLOWSPY)
			         | ((MD_HISPEED | MD_RLOWSPY) & MD_SUB)
		               )
		             & ( (MD_READ & ICWEE) | (MD_DREAD & ~ICWEE) );
	assign act02 = ~D_DETVCP;

        wire vcpdwnl_2;
        wire vcpdwnl_2_1, vcpdwnl_2_2, vcpdwnl_2_3;
        //QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs2 (.set_b(enable02), .reset(act02), .out(vcpdwnl_2));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs2_1 (.set_b(enable02), .reset(act02), .out(vcpdwnl_2_1));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs2_2 (.set_b(enable02), .reset(act02), .out(vcpdwnl_2_2));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs2_3 (.set_b(enable02), .reset(act02), .out(vcpdwnl_2_3));
        // 3-bit Majority Gate
        assign vcpdwnl_2 = (vcpdwnl_2_1 & vcpdwnl_2_2) | (vcpdwnl_2_2 & vcpdwnl_2_3) | (vcpdwnl_2_1 & vcpdwnl_2_3);

endmodule

module QNSC3NCP1V2_CPL5_VCPDWNL_3 (
    // input port
    ICWEE,
    MD_SER,  MD_DSER,
    MD_CER,  MD_DCER,
    MD_EXER, MD_DEXER,
    D_DETVCP,
    // output port
    vcpdwnl_3
    //enable03
);

input ICWEE;
input MD_SER,  MD_DSER,
      MD_CER,  MD_DCER,
      MD_EXER, MD_DEXER;
input D_DETVCP;

output vcpdwnl_3;
//output enable03;

	wire enable03, act03;
        wire enable04_a2;
	assign enable04_a2 =   (MD_SER  & ICWEE) | (MD_DSER  & ~ICWEE)
			     | (MD_CER  & ICWEE) | (MD_DCER  & ~ICWEE)
			     | (MD_EXER & ICWEE) | (MD_DEXER & ~ICWEE);
	assign enable03 = enable04_a2;
	assign act03 = ~D_DETVCP;

        wire vcpdwnl_3;
        wire vcpdwnl_3_1, vcpdwnl_3_2, vcpdwnl_3_3;
        //QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs3 (.set_b(enable03), .reset(act03), .out(vcpdwnl_3));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs3_1 (.set_b(enable03), .reset(act03), .out(vcpdwnl_3_1));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs3_2 (.set_b(enable03), .reset(act03), .out(vcpdwnl_3_2));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs3_3 (.set_b(enable03), .reset(act03), .out(vcpdwnl_3_3));
        // 3-bit Majority Gate
        assign vcpdwnl_3 = (vcpdwnl_3_1 & vcpdwnl_3_2) | (vcpdwnl_3_2 & vcpdwnl_3_3) | (vcpdwnl_3_1 & vcpdwnl_3_3);

endmodule


//module QNSC3NCP1V2_CPL5_VCPDWNLR_12 (
//    // input port
//    enable11,
//    enable12,
//    D_DETVCPR,
//    // output port
//    vcpdwnlr_12
//);
//
//input enable11;
//input enable12;
//input D_DETVCPR;
//
//output vcpdwnlr_12;
//
//   wire enable1112;
//   wire act11;
//   assign enable1112 = enable11 | enable12;
//   assign act11 = ~D_DETVCPR;
//
//   wire vcpdwnlr_12_1, vcpdwnlr_12_2, vcpdwnlr_12_3;
//   //QNSC3NCP1V2_CPL5_RSLATCH vcpdwnlr_rs12 (.set_b(enable1112), .reset(act11), .out(vcpdwnlr_12));
//   QNSC3NCP1V2_CPL5_RSLATCH vcpdwnlr_rs12_1 (.set_b(enable1112), .reset(act11), .out(vcpdwnlr_12_1));
//   QNSC3NCP1V2_CPL5_RSLATCH vcpdwnlr_rs12_2 (.set_b(enable1112), .reset(act11), .out(vcpdwnlr_12_2));
//   QNSC3NCP1V2_CPL5_RSLATCH vcpdwnlr_rs12_3 (.set_b(enable1112), .reset(act11), .out(vcpdwnlr_12_3));
//   // 3-bit Majority Gate
//   assign vcpdwnlr_12 = (vcpdwnlr_12_1 & vcpdwnlr_12_2) | (vcpdwnlr_12_2 & vcpdwnlr_12_3) | (vcpdwnlr_12_1 & vcpdwnlr_12_3);
//
//endmodule

module QNSC3NCP1V2_CPL5_VCPDWNLR_1 (
    // input port
    MD_HISPEED, MD_RLOWSPY, MD_SUB,
    ICWEE,
    MD_FLSTOP, MD_DFLSTOP,
    MD_DIS, MD_DDIS,
    D_DETVCPR,
    // output port
    vcpdwnlr_1
    //enable11
);

input MD_HISPEED, MD_RLOWSPY, MD_SUB;
input ICWEE;
input MD_FLSTOP, MD_DFLSTOP,
      MD_DIS, MD_DDIS;
input D_DETVCPR;

output vcpdwnlr_1;
//output enable11;


	wire enable11, act11;
	assign enable11 = (   (   (MD_HISPEED | MD_RLOWSPY)
			        & ~MD_SUB
			        & ((~ICWEE & MD_FLSTOP) | (ICWEE & MD_DFLSTOP))
			      )
			    | (~ICWEE & MD_DIS) | (ICWEE & MD_DDIS)
		          );
	assign act11 = ~D_DETVCPR;

        wire vcpdwnlr_1;
        wire vcpdwnlr_1_1, vcpdwnlr_1_2, vcpdwnlr_1_3;
        //QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs5 (.set_b(enable11), .reset(act11), .out(vcpdwnlr_1));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnlr_rs1_1 (.set_b(enable11), .reset(act11), .out(vcpdwnlr_1_1));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnlr_rs1_2 (.set_b(enable11), .reset(act11), .out(vcpdwnlr_1_2));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnlr_rs1_3 (.set_b(enable11), .reset(act11), .out(vcpdwnlr_1_3));
        // 3-bit Majority Gate
        assign vcpdwnlr_1 = (vcpdwnlr_1_1 & vcpdwnlr_1_2) | (vcpdwnlr_1_2 & vcpdwnlr_1_3) | (vcpdwnlr_1_1 & vcpdwnlr_1_3);

endmodule

module QNSC3NCP1V2_CPL5_VCPDWNLR_2 (
    // input port
    MD_CPT, MD_EXTVPP1,
    MD_HISPEED, MD_RLOWSPY, MD_SUB,
    ICWEE,
    MD_READ, MD_DREAD,
    D_DETVCPR,
    // output port
    vcpdwnlr_2,
    //enable12,
    enable12_a1
);

input MD_CPT, MD_EXTVPP1;
input MD_HISPEED, MD_RLOWSPY, MD_SUB;
input ICWEE;
input MD_READ, MD_DREAD;
input D_DETVCPR;

output vcpdwnlr_2;
//output enable12;
output enable12_a1;


	wire enable12, enable12_a1, act12;
	assign enable12 = ~MD_CPT & ~MD_EXTVPP1 & enable12_a1;
	assign enable12_a1 =   (   (~MD_HISPEED & ~MD_RLOWSPY)
			         | ((MD_HISPEED | MD_RLOWSPY) & MD_SUB)
		               )
		             & ( (MD_READ & ~ICWEE) | (MD_DREAD & ICWEE) );
	assign act12 = ~D_DETVCPR;

        wire vcpdwnlr_2;
        wire vcpdwnlr_2_1, vcpdwnlr_2_2, vcpdwnlr_2_3;
        //QNSC3NCP1V2_CPL5_RSLATCH vcpdwnl_rs6 (.set_b(enable12), .reset(act12), .out(vcpdwnlr_2));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnlr_rs2_1 (.set_b(enable12), .reset(act12), .out(vcpdwnlr_2_1));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnlr_rs2_2 (.set_b(enable12), .reset(act12), .out(vcpdwnlr_2_2));
        QNSC3NCP1V2_CPL5_RSLATCH vcpdwnlr_rs2_3 (.set_b(enable12), .reset(act12), .out(vcpdwnlr_2_3));
        // 3-bit Majority Gate
        assign vcpdwnlr_2 = (vcpdwnlr_2_1 & vcpdwnlr_2_2) | (vcpdwnlr_2_2 & vcpdwnlr_2_3) | (vcpdwnlr_2_1 & vcpdwnlr_2_3);

endmodule

module QNSC3NCP1V2_CPL5_RSLATCH(set_b, reset, out);
	input set_b, reset;
	output out;

        wire out_b;
	TBLAHQRBX1 la (.H01(1'b1), .H02(reset), .H03(set_b), .N01(out_b));
	assign out = ~out_b;

endmodule

///=============================================================================
///CPL6 write reference current control
///  Ver2.00 2010/06/10 Renewal from QNSC3NCP0V1 for MTEG
///
///=============================================================================

module QNSC3NCP1V2_CPL6 (TRMCP7, TRMCP8, TRMCP9, IL_TRMWIB);
	input TRMCP7, TRMCP8, TRMCP9;
	output	[7:0]	IL_TRMWIB;

	reg [7:0] IL_TRMWIB;
	always @(TRMCP9 or TRMCP8 or TRMCP7) begin
		case ({TRMCP9, TRMCP8, TRMCP7})
			3'b000 : IL_TRMWIB = 8'b11111110;
			3'b001 : IL_TRMWIB = 8'b11111101;
			3'b010 : IL_TRMWIB = 8'b11111011;
			3'b011 : IL_TRMWIB = 8'b11110111;
			3'b100 : IL_TRMWIB = 8'b11101111;
			3'b101 : IL_TRMWIB = 8'b11011111;
			3'b110 : IL_TRMWIB = 8'b10111111;
			3'b111 : IL_TRMWIB = 8'b01111111;
		endcase
	end

endmodule

///=============================================================================
///CPL7 SW control
///  Ver2.00 2010/06/10 Renewal from QNSC3NCP0V1 for MTEG
///
///=============================================================================

module QNSC3NCP1V2_CPL7 (
	IL_PVDDCPSWEN,
	IL_VPTSW1EN,
	IL_VPTSW2EN,
	IL_VPT1SW1EN,
	IL_IVPPTS1DS,
	IL_VCOMPSWEN,
	IL_VCPVD,
	MD_IONCHK1,
	MD_DIONCHK1,
	MD_STCHK,
	MD_DSTCHK,
	MD_WDT1,
	MD_DWDT1,
	MD_WDT2,
	MD_DWDT2,
	MD_WDT3,
	MD_DWDT3,
	MD_WDT4,
	MD_DWDT4,
	MD_RDT,
	MD_DRDT,
	MD_EXER,
	MD_DEXER,
	MD_MSWR,
	MD_DMSWR,
	MD_CPBT,
	MD_DCPBT,
	MD_CER,
	MD_DCER,
	MD_SER,
	MD_DSER,
	MD_MRG00,
	MD_DMRG00,
	MD_MRG01,
	MD_DMRG01,
	MD_MRG10,
	MD_DMRG10,
	MD_MRG11,
	MD_DMRG11,
	MD_MRG12,
	MD_DMRG12,
	MD_RDMRG0,
	MD_DRDMRG0,
	MD_RDMRG1,
	MD_DRDMRG1,
	MD_RDMRGC,
	MD_DRDMRGC,
	MD_EXTVPP1,
	MD_EXTVPP2,
	MD_CPT,
	MD_IREFT,
	MD_CWEE,
	SCANMODE,
	TESDBT,
	MD_WWR,
	MD_DWWR,
	MD_READ,
	MD_DREAD,
	MD_DIS,
	MD_DDIS,
	MD_FLSTOP,
	MD_DFLSTOP,
	trmrd1_internal,
	TRMRD2,
	MD_MEOC,
	MD_OSCNOSTP,
	IL_VCPDWNL,
//	MD_PROGI,
	MD_FCLK1,
	IWRITE,
	IL_WRITE,
	IERASE,
	IL_ERASE,
        MD_HISPEED, MD_RLOWSPY, MD_SUB
);

output	IL_PVDDCPSWEN,
	IL_VPTSW1EN,
	IL_VPTSW2EN,
	IL_VPT1SW1EN,
	IL_IVPPTS1DS,
	IL_VCOMPSWEN,
	IL_VCPVD;

input	MD_IONCHK1,
	MD_DIONCHK1,
	MD_STCHK,
	MD_DSTCHK,
	MD_WDT1,
	MD_DWDT1,
	MD_WDT2,
	MD_DWDT2,
	MD_WDT3,
	MD_DWDT3,
	MD_WDT4,
	MD_DWDT4,
	MD_RDT,
	MD_DRDT,
	MD_EXER,
	MD_DEXER,
	MD_MSWR,
	MD_DMSWR,
	MD_CPBT,
	MD_DCPBT,
	MD_CER,
	MD_DCER,
	MD_SER,
	MD_DSER,
	MD_MRG00,
	MD_DMRG00,
	MD_MRG01,
	MD_DMRG01,
	MD_MRG10,
	MD_DMRG10,
	MD_MRG11,
	MD_DMRG11,
	MD_MRG12,
	MD_DMRG12,
	MD_RDMRG0,
	MD_DRDMRG0,
	MD_RDMRG1,
	MD_DRDMRG1,
	MD_RDMRGC,
	MD_DRDMRGC,
	MD_EXTVPP1,
	MD_EXTVPP2,
	MD_CPT,
	MD_IREFT,
	MD_CWEE,
	SCANMODE,
	TESDBT,
	MD_WWR,
	MD_DWWR,
	MD_READ,
	MD_DREAD,
	MD_DIS,
	MD_DDIS,
	MD_FLSTOP,
	MD_DFLSTOP,
	trmrd1_internal,
	TRMRD2,
	MD_MEOC,
	MD_OSCNOSTP,
	IL_VCPDWNL,
//	MD_PROGI,
	MD_FCLK1,
	IWRITE,
	IL_WRITE,
	IERASE,
	IL_ERASE,
        MD_HISPEED, MD_RLOWSPY, MD_SUB;

	reg il_vcpvd_p;
	always @(MD_IONCHK1 or MD_DIONCHK1 or MD_STCHK or MD_DSTCHK or MD_RDT or
		MD_RDMRG0 or MD_DRDMRG0 or MD_RDMRG1 or MD_DRDMRG1 or MD_RDMRGC or
		MD_DRDMRGC or MD_EXTVPP1 or MD_EXTVPP2 or MD_CPT or MD_IREFT or
		SCANMODE or TESDBT or MD_DIS or MD_READ or MD_FLSTOP or
		trmrd1_internal or TRMRD2 or MD_DDIS or MD_DREAD or
		MD_DFLSTOP or MD_CWEE
		) begin
		casex({
		MD_IONCHK1, MD_DIONCHK1, MD_STCHK, MD_DSTCHK, MD_RDT,
		MD_RDMRG0, MD_DRDMRG0, MD_RDMRG1, MD_DRDMRG1, MD_RDMRGC,
		MD_DRDMRGC, MD_EXTVPP1, MD_EXTVPP2, MD_CPT, MD_IREFT,
		SCANMODE, TESDBT, MD_DIS, MD_READ, MD_FLSTOP,
		trmrd1_internal, TRMRD2, MD_DDIS, MD_DREAD,
		MD_DFLSTOP, MD_CWEE
		})
			  //         11111111112222222
			  //12345678901234567890123456
			  //MMMMMMMMMMMMMMMMMMMMMI MMM
			  //DDDDDDDDDDDDDDDDDDDDDL DDD
			  //______________________ ___
			  // D D  D D DEECIST   TTDDDC
			  //IISSRRRRRRRXXPRCEDRFRRDRFW
			  //OOTTDDDDDDDTTTEASIELMMIELE
			  //NNCCTMMMMMMVV FNDSASRRSASE
			  //CCHH RRRRRRPP TMB DTDD DT 
			  //HHKK GGGGGGPP  OT  O12  O 
			  //KK   0011CC12  D   P    P 
			  //11             E          
			26'bxxxxxxxxxxx0000xx1x0xxx101 : il_vcpvd_p=1'b1; //Invpp	DIS	Invpp	Read
			26'bxxxxxxxxxxx1000xx1x0xxx101 : il_vcpvd_p=1'b1; //Invpp	DIS	Extvpp1	Read
			26'bxxxxxxxxxxx0001xx1x0xxx101 : il_vcpvd_p=1'b1; //Invpp	DIS	Ireft	Read
			26'bx1xxxxxxxxx1000xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Extvpp1	IONCHK1
			26'bx1xxxxxxxxx0100xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Extvpp2	IONCHK1
			26'bxxx1xxxxxxx1000xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Extvpp1	STCHK
			26'bxxx1xxxxxxx0001xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Ireft	STCHK
			26'bxxxxxx1xxxx0000xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Invpp	RDMRG0
			26'bxxxxxx1xxxx1000xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Extvpp1	RDMRG0
			26'bxxxxxx1xxxx0001xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Ireft	RDMRG0
			26'bxxxxxxxx1xx0000xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Invpp	RDMRG1
			26'bxxxxxxxx1xx1000xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Extvpp1	RDMRG1
			26'bxxxxxxxx1xx0001xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Ireft	RDMRG1
			26'bxxxxxxxxxx11000xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Extvpp1	RDMRGC
			26'bxxxxxxxxxx10100xx1x0xxx001 : il_vcpvd_p=1'b1; //Invpp	DIS	Extvpp2	RDMRGC
			26'bxxxxxxxxxxx0000xx1x0xxxx11 : il_vcpvd_p=1'b1; //Invpp	DIS	Invpp	STOP
			26'bxxxxxxxxxxx0000xxx10xxxx10 : il_vcpvd_p=1'b1; //Invpp	READ	Invpp	STOP
			26'bxxxxxxxxxxx0000xxx10xxx100 : il_vcpvd_p=1'b1; //Invpp	READ	Invpp	READ
			26'bxxxxxxxxxxx0000xxx10xx1000 : il_vcpvd_p=1'b1; //Invpp	READ	Invpp	DIS
			26'bxxxxxxxxxxx1000xxx10xx1000 : il_vcpvd_p=1'b1; //Extvpp1	READ	Invpp	DIS
			26'bxxxxxxxxxxx0010xxx10xx1000 : il_vcpvd_p=1'b1; //Cpt	READ	Invpp	DIS
			26'bxxxxxxxxxxx0001xxx10xx1000 : il_vcpvd_p=1'b1; //Ireft	READ	Invpp	DIS
			26'bxxxxxxxxxxxxxxxxxxxx1xxxxx : il_vcpvd_p=1'b1; //Invpp	TRM READ1	Invpp	STOP
			26'bxxxxxxxxxxx0000xxxx1xxxx1x : il_vcpvd_p=1'b1; //Invpp	STOP(READ)	Invpp	STOP
			26'b1xxxxxxxxxx1000xxxx0xx1000 : il_vcpvd_p=1'b1; //Extvpp1	IONCHK1	Invpp	DIS
			26'b1xxxxxxxxxx0100xxxx0xx1000 : il_vcpvd_p=1'b1; //Extvpp2	IONCHK1	Invpp	DIS
			26'b1xxxxxxxxxx0010xxxx0xx1000 : il_vcpvd_p=1'b1; //Cpt	IONCHK1	Invpp	DIS
			26'bxxxx1xxxxxx0010xxxx0xx1000 : il_vcpvd_p=1'b1; //Cpt	RDT	Invpp	DIS
			26'bxx1xxxxxxxx1000xxxx0xx1000 : il_vcpvd_p=1'b1; //Extvpp1	STCHK	Invpp	DIS
			26'bxx1xxxxxxxx0010xxxx0xx1000 : il_vcpvd_p=1'b1; //Cpt	STCHK	Invpp	DIS
			26'bxx1xxxxxxxx0001xxxx0xx1000 : il_vcpvd_p=1'b1; //Ireft	STCHK	Invpp	DIS
			26'bxxxxx1xxxxx0000xxxx0xx1000 : il_vcpvd_p=1'b1; //Invpp	RDMRG0	Invpp	DIS
			26'bxxxxx1xxxxx1000xxxx0xx1000 : il_vcpvd_p=1'b1; //Extvpp1	RDMRG0	Invpp	DIS
			26'bxxxxx1xxxxx0010xxxx0xx1000 : il_vcpvd_p=1'b1; //Cpt	RDMRG0	Invpp	DIS
			26'bxxxxx1xxxxx0001xxxx0xx1000 : il_vcpvd_p=1'b1; //Ireft	RDMRG0	Invpp	DIS
			26'bxxxxxxx1xxx0000xxxx0xx1000 : il_vcpvd_p=1'b1; //Invpp	RDMRG1	Invpp	DIS
			26'bxxxxxxx1xxx1000xxxx0xx1000 : il_vcpvd_p=1'b1; //Extvpp1	RDMRG1	Invpp	DIS
			26'bxxxxxxx1xxx0010xxxx0xx1000 : il_vcpvd_p=1'b1; //Cpt	RDMRG1	Invpp	DIS
			26'bxxxxxxx1xxx0001xxxx0xx1000 : il_vcpvd_p=1'b1; //Ireft	RDMRG1	Invpp	DIS
			26'bxxxxxxxxx1x1000xxxx0xx1000 : il_vcpvd_p=1'b1; //Extvpp1	RDMRGC	Invpp	DIS
			26'bxxxxxxxxx1x0100xxxx0xx1000 : il_vcpvd_p=1'b1; //Extvpp2	RDMRGC	Invpp	DIS
			26'bxxxxxxxxx1x0010xxxx0xx1000 : il_vcpvd_p=1'b1; //Cpt	RDMRGC	Invpp	DIS
			26'bxxxxxxxxxxxxxxx10xxxxxxxxx : il_vcpvd_p=1'b1; //Invpp	SCAN	Invpp	SCAN
			26'bxxxxxxxxxxxxxxx11xxxxxxxxx : il_vcpvd_p=1'b1; //Invpp	BT	Invpp	BT
			default                        : il_vcpvd_p=1'b0;
		endcase
	end

        wire MD_LSLPSUB;
        assign MD_LSLPSUB =   (   ((~MD_HISPEED & ~MD_RLOWSPY)         )
                                | (( MD_HISPEED |  MD_RLOWSPY) & MD_SUB)
                              )
                            & (~MD_EXTVPP1 & ~MD_EXTVPP2 & ~MD_CPT);

        wire il_vcpvd_p2;
        assign il_vcpvd_p2 =   ( MD_DIS  & (MD_DREAD | MD_DRDMRG0 | MD_DRDMRG1 | MD_DRDMRGC) & ~MD_CWEE & MD_LSLPSUB )
                             | ( MD_DDIS & (MD_READ  | MD_RDMRG0  | MD_RDMRG1  | MD_RDMRGC)  &  MD_CWEE & MD_LSLPSUB );

        wire il_vcpvd_p3;
        assign il_vcpvd_p3 =   (MD_DIS & MD_DREAD & MD_DFLSTOP & ~MD_CWEE)
                             & ((MD_HISPEED | MD_RLOWSPY) & ~MD_SUB);

        wire il_vcpvd_p4;
        assign il_vcpvd_p4 =   (MD_READ & MD_DREAD & MD_CWEE)
                             & (   ((~MD_HISPEED & ~MD_RLOWSPY)         )
                                 | (( MD_HISPEED |  MD_RLOWSPY) & MD_SUB) )
                             & (~MD_EXTVPP1 & ~MD_EXTVPP2 & ~MD_CPT & ~MD_IREFT);

	assign IL_VCPVD =   il_vcpvd_p  & ~IL_VCPDWNL
                          | il_vcpvd_p2
                          | il_vcpvd_p3
                          | il_vcpvd_p4
			  | (IWRITE & ~((MD_CPT & MD_EXTVPP1 & MD_OSCNOSTP) | (MD_CPT & MD_EXTVPP2)) &~IL_WRITE) 
			  | (IERASE & ~(MD_CPBT | MD_DCPBT) & ~(MD_CPT & MD_EXTVPP1 & MD_OSCNOSTP) & ~IL_ERASE)
			  | (MD_DIS & MD_DDIS) & ~IL_VCPDWNL;

	reg IL_VCOMPSWEN;
	always @(MD_MSWR or MD_EXER or MD_CPBT or MD_DCPBT or MD_WDT1 or
		MD_WDT2 or MD_WDT3 or MD_WDT4 or MD_EXTVPP1 or MD_CPT or
		MD_WWR or MD_CER or MD_SER or MD_DDIS or MD_OSCNOSTP
		) begin
		casex({
		MD_MSWR, MD_EXER, MD_CPBT, MD_DCPBT, MD_WDT1,
		MD_WDT2, MD_WDT3, MD_WDT4, MD_EXTVPP1, MD_CPT,
		MD_WWR, MD_CER, MD_SER, MD_DDIS, MD_OSCNOSTP
		})
			  //         111111
			  //123456789012345
			  //MMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDD
			  //_______________
			  //ME DWWWWECWCSDO
			  //SXCCDDDDXPWEEDS
			  //WEPPTTTTTTRRRIC
			  //RRBB1234V    SN
			  //  TT    P     O
			  //        P     S
			  //        1     T
			  //              P
			15'bxxxxxxxx111xx10 : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	WWR	Invpp	DIS
			15'bxxxxxxxx111xx11 : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	WWR	Invpp	DIS
			15'bxxxxxxxx11x1x10 : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	CER	Invpp	DIS
			15'bxxxxxxxx11x1x11 : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	CER	Invpp	DIS
			15'bxxxxxxxx11xx11x : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	SER	Invpp	DIS
			15'b1xxxxxxx11xxx1x : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	MSWR	Invpp	DIS
			15'bx1xxxxxx11xxx1x : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	EXER	Invpp	DIS
			15'bxx11xxxx11xxxxx : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	CPBT	Cpt+Ex1	CPBT
			15'bxxxx1xxx11xxx1x : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	WDT1	Invpp	DIS
			15'bxxxxx1xx11xxx1x : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	WDT2	Invpp	DIS
			15'bxxxxxx1x11xxx1x : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	WDT3	Invpp	DIS
			15'bxxxxxxx111xxx1x : IL_VCOMPSWEN=1'b1; //Cpt+Ex1	WDT4	Invpp	DIS
			default             : IL_VCOMPSWEN=1'b0;
		endcase
	end

	reg IL_VPT1SW1EN;
	wire il_ivppts1ds_a;
        wire il_ivppts1ds_b;
	assign IL_IVPPTS1DS = (~IL_VPT1SW1EN & ~il_ivppts1ds_b) | il_ivppts1ds_a;
	assign il_ivppts1ds_a = MD_IREFT & ( MD_WWR | MD_MSWR );
        assign il_ivppts1ds_b = ~MD_CPT & MD_EXTVPP2 & (MD_WDT1 | MD_DWDT1);

	always @(
		MD_MSWR or MD_DMSWR or MD_IONCHK1 or MD_DIONCHK1 or MD_STCHK or
		MD_DSTCHK or MD_WDT1 or MD_DWDT1 or MD_RDMRG0 or MD_DRDMRG0 or
		MD_RDMRG1 or MD_DRDMRG1 or MD_RDMRGC or MD_DRDMRGC or MD_WWR or
		MD_MRG00 or MD_DMRG00 or MD_MRG01 or MD_DMRG01 or MD_MRG10 or
		MD_DMRG10 or MD_MRG11 or MD_DMRG11 or MD_MRG12 or MD_DMRG12 or
		MD_DIS or MD_DDIS or MD_READ or MD_DREAD or MD_EXTVPP1 or
		MD_EXTVPP2 or MD_CPT or MD_IREFT or MD_MEOC
		) begin
		casex({
		MD_MSWR, MD_DMSWR, MD_IONCHK1, MD_DIONCHK1, MD_STCHK,
		MD_DSTCHK, MD_WDT1, MD_DWDT1, MD_RDMRG0, MD_DRDMRG0,
		MD_RDMRG1, MD_DRDMRG1, MD_RDMRGC, MD_DRDMRGC, MD_WWR,
		MD_MRG00, MD_DMRG00, MD_MRG01, MD_DMRG01, MD_MRG10,
		MD_DMRG10, MD_MRG11, MD_DMRG11, MD_MRG12, MD_DMRG12,
		MD_DIS, MD_DDIS, MD_READ, MD_DREAD, MD_EXTVPP1,
		MD_EXTVPP2, MD_CPT, MD_IREFT, MD_MEOC
		})
			  //         1111111111222222222233333
			  //1234567890123456789012345678901234
			  //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
			  //__________________________________
			  // D D D D D D D  D D D D D D DEECIM
			  //MMIISSWWRRRRRRWMMMMMMMMMMDDRRXXPRE
			  //SSOOTTDDDDDDDDWRRRRRRRRRRIIEETTTEO
			  //WWNNCCTTMMMMMMRGGGGGGGGGGSSAAVV FC
			  //RRCCHH11RRRRRR 0000111111  DDPP T 
			  //  HHKK  GGGGGG 0011001122    PP   
			  //  KK    0011CC               12   
			  //  11                              
			34'bxxxxxxxxxxxxxx1xxxxxxxxxxx1xx0001x : IL_VPT1SW1EN=1'b1; //Ireft	WWR	Invpp	DIS
			34'bxxxxxxxxxxxxxxx1xxxxxxxxxx1xx0001x : IL_VPT1SW1EN=1'b1; //Ireft	MRG00	Invpp	DIS
			34'bxxxxxxxxxxxxxxxxx1xxxxxxxx1xx0001x : IL_VPT1SW1EN=1'b1; //Ireft	MRG01	Invpp	DIS
			34'bxxxxxxxxxxxxxxxxxxx1xxxxxx1xx0001x : IL_VPT1SW1EN=1'b1; //Ireft	MRG10	Invpp	DIS
			34'bxxxxxxxxxxxxxxxxxxxxx1xxxx1xx0001x : IL_VPT1SW1EN=1'b1; //Ireft	MRG11	Invpp	DIS
			34'bxxxxxxxxxxxxxxxxxxxxxxx1xx1xx0001x : IL_VPT1SW1EN=1'b1; //Ireft	MRG12	Invpp	DIS
			34'bxxxxxxxxxxxxxxxx1xxxxxxxx1xxx0001x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Ireft	MRG00
			34'bxxxxxxxxxxxxxxxxxx1xxxxxx1xxx0001x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Ireft	MRG01
			34'bxxxxxxxxxxxxxxxxxxxx1xxxx1xxx0001x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Ireft	MRG10
			34'bxxxxxxxxxxxxxxxxxxxxxx1xx1xxx0001x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Ireft	MRG11
			34'bxxxxxxxxxxxxxxxxxxxxxxxx11xxx0001x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Ireft	MRG12
			34'bxxxxxxxxxxxxxxxxxxxxxxxxx1xx10001x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Ireft	READ
			34'bx1xxxxxxxxxxxxxxxxxxxxxxx1xxx10001 : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Extvpp1	MSWR
			34'bxxx1xxxxxxxxxxxxxxxxxxxxx1xxx1000x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Extvpp1	IONCHK1
			34'bxxx1xxxxxxxxxxxxxxxxxxxxx1xxx0100x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Extvpp2	IONCHK1
			34'bxxxxxxx1xxxxxxxxxxxxxxxxx1xxx0000x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Invpp	WDT1
			34'bxxxxx1xxxxxxxxxxxxxxxxxxx1xxx1000x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Extvpp1	STCHK
			34'bxxxxx1xxxxxxxxxxxxxxxxxxx1xxx0001x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Ireft	STCHK
			34'bxxxxxxxxx1xxxxxxxxxxxxxxx1xxx0001x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Ireft	RDMRG0
			34'bxxxxxxxxxxx1xxxxxxxxxxxxx1xxx0001x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Ireft	RDMRG1
			34'bxxxxxxxxxxxxx1xxxxxxxxxxx1xxx1000x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Extvpp1	RDMRGC
			34'bxxxxxxxxxxxxx1xxxxxxxxxxx1xxx0100x : IL_VPT1SW1EN=1'b1; //Invpp	DIS	Extvpp2	RDMRGC
			34'bxxxxxxxxxxxxxxxxxxxxxxxxxx11x0001x : IL_VPT1SW1EN=1'b1; //Ireft	READ	Invpp	DIS
			34'b1xxxxxxxxxxxxxxxxxxxxxxxxx1xx0001x : IL_VPT1SW1EN=1'b1; //Ireft	MSWR	Invpp	DIS
			34'b1xxxxxxxxxxxxxxxxxxxxxxxxx1xx10001 : IL_VPT1SW1EN=1'b1; //Extvpp1	MSWR	Invpp	DIS
			34'bxx1xxxxxxxxxxxxxxxxxxxxxxx1xx1000x : IL_VPT1SW1EN=1'b1; //Extvpp1	IONCHK1	Invpp	DIS
			34'bxx1xxxxxxxxxxxxxxxxxxxxxxx1xx0100x : IL_VPT1SW1EN=1'b1; //Extvpp2	IONCHK1	Invpp	DIS
			34'bxxxxxx11xxxxxxxxxxxxxxxxxxxxx0000x : IL_VPT1SW1EN=1'b1; //Invpp	WDT1	Invpp	WDT1
			34'bxxxxxx1xxxxxxxxxxxxxxxxxxx1xx0000x : IL_VPT1SW1EN=1'b1; //Invpp	WDT1	Invpp	DIS
			34'bxxxx11xxxxxxxxxxxxxxxxxxxxxxx1000x : IL_VPT1SW1EN=1'b1; //Extvpp1	STCHK	Extvpp1	STCHK
			34'bxxxx1xxxxxxxxxxxxxxxxxxxxx1xx1000x : IL_VPT1SW1EN=1'b1; //Extvpp1	STCHK	Invpp	DIS
			34'bxxxx1xxxxxxxxxxxxxxxxxxxxx1xx0001x : IL_VPT1SW1EN=1'b1; //Ireft	STCHK	Invpp	DIS
			34'bxxxxxxxx1xxxxxxxxxxxxxxxxx1xx0001x : IL_VPT1SW1EN=1'b1; //Ireft	RDMRG0	Invpp	DIS
			34'bxxxxxxxxxx1xxxxxxxxxxxxxxx1xx0001x : IL_VPT1SW1EN=1'b1; //Ireft	RDMRG1	Invpp	DIS
			34'bxxxxxxxxxxxx1xxxxxxxxxxxxx1xx1000x : IL_VPT1SW1EN=1'b1; //Extvpp1	RDMRGC	Invpp	DIS
			34'bxxxxxxxxxxxx1xxxxxxxxxxxxx1xx0100x : IL_VPT1SW1EN=1'b1; //Extvpp2	RDMRGC	Invpp	DIS
			default                                : IL_VPT1SW1EN=1'b0;
		endcase
	end

	reg IL_VPTSW2EN;
	always @(
		MD_IONCHK1 or MD_STCHK or MD_RDT or MD_RDMRG0 or MD_DRDMRG0 or
		MD_RDMRG1 or MD_DRDMRG1 or MD_RDMRGC or MD_DIS or MD_DDIS or
		MD_READ or MD_DREAD or MD_EXTVPP1 or MD_CPT or MD_CWEE or
		TRMRD2
		) begin
		casex({
		MD_IONCHK1, MD_STCHK, MD_RDT, MD_RDMRG0, MD_DRDMRG0,
		MD_RDMRG1, MD_DRDMRG1, MD_RDMRGC, MD_DIS, MD_DDIS,
		MD_READ, MD_DREAD, MD_EXTVPP1, MD_CPT, MD_CWEE
		})
			  //         111111
			  //123456789012345
			  //MMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDD
			  //_______________
			  //    D D  D DECC
			  //ISRRRRRRDDRRXPW
			  //OTDDDDDDIIEETTE
			  //NCTMMMMMSSAAV E
			  //CH RRRRR  DDP  
			  //HK GGGGG    P  
			  //K  0011C    1   
			  //1               
			15'bxxxxxxxx1xx1101 : IL_VPTSW2EN=1'b1; //Invpp	DIS	Extvpp1	READ
			15'bxxxx1xxx1xxx101 : IL_VPTSW2EN=1'b1; //Invpp	DIS	Extvpp1	RDMRG0
			15'bxxxxxx1x1xxx101 : IL_VPTSW2EN=1'b1; //Invpp	DIS	Extvpp1	RDMRG1

			15'bxxxxxxxxx11x100 : IL_VPTSW2EN=1'b1; //Extvpp1	READ	Invpp	DIS
			15'bxxxxxxxxx11x010 : IL_VPTSW2EN=1'b1; //Cpt		READ	Invpp	DIS

			15'b1xxxxxxxx1xx010 : IL_VPTSW2EN=1'b1; //Cpt		IONCHK1	Invpp	DIS
			15'bxx1xxxxxx1xx010 : IL_VPTSW2EN=1'b1; //Cpt		RDT	Invpp	DIS
			15'bx1xxxxxxx1xx010 : IL_VPTSW2EN=1'b1; //Cpt		STCHK	Invpp	DIS
			15'bxxx1xxxxx1xx100 : IL_VPTSW2EN=1'b1; //Extvpp1	RDMRG0	Invpp	DIS
			15'bxxx1xxxxx1xx010 : IL_VPTSW2EN=1'b1; //Cpt		RDMRG0	Invpp	DIS
			15'bxxxxx1xxx1xx100 : IL_VPTSW2EN=1'b1; //Extvpp1	RDMRG1	Invpp	DIS
			15'bxxxxx1xxx1xx010 : IL_VPTSW2EN=1'b1; //Cpt		RDMRG1	Invpp	DIS
			15'bxxxxxxx1x1xx010 : IL_VPTSW2EN=1'b1; //Cpt		RDMRGC	Invpp	DIS
			default              : IL_VPTSW2EN=1'b0;
		endcase
	end


	reg il_vptsw1en_read;
	always @(
		MD_IONCHK1 or MD_STCHK or MD_RDT or MD_DRDT or MD_RDMRG0 or
		MD_DRDMRG0 or MD_RDMRG1 or MD_DRDMRG1 or MD_RDMRGC or MD_MRG00 or
		MD_DMRG00 or MD_MRG01 or MD_DMRG01 or MD_MRG10 or MD_DMRG10 or
		MD_MRG11 or MD_DMRG11 or MD_MRG12 or MD_DMRG12 or MD_DIS or
		MD_DDIS or MD_READ or MD_DREAD or MD_EXTVPP1 or MD_EXTVPP2 or
		MD_CPT or MD_CWEE or TRMRD2
		) begin
		casex({
		MD_IONCHK1, MD_STCHK, MD_RDT, MD_DRDT, MD_RDMRG0,
		MD_DRDMRG0, MD_RDMRG1, MD_DRDMRG1, MD_RDMRGC, MD_MRG00,
		MD_DMRG00, MD_MRG01, MD_DMRG01, MD_MRG10, MD_DMRG10,
		MD_MRG11, MD_DMRG11, MD_MRG12, MD_DMRG12, MD_DIS,
		MD_DDIS, MD_READ, MD_DREAD, MD_EXTVPP1, MD_EXTVPP2,
		MD_CPT, MD_CWEE, TRMRD2
		})
			  //         1111111111222222222
			  //1234567890123456789012345678
			  //MMMMMMMMMMMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDDDDDDDDDDD
			  //____________________________
			  //   D D D  D D D D D D DEECCT
			  //ISRRRRRRRMMMMMMMMMMDDRRXXPWR
			  //OTDDDDDDDRRRRRRRRRRIIEETTTEM
			  //NCTTMMMMMGGGGGGGGGGSSAAVV ER
			  //CH  RRRRR0000111111  DDPP  D
			  //HK  GGGGG0011001122    PP  2
			  //K   0011C              12   
			  //1                           
			28'bxxxxxxxxx1xxxxxxxxxx1xx1001x : il_vptsw1en_read=1'b1; //Extvpp1	MRG00	Invpp	DIS
			28'bxxxxxxxxx1xxxxxxxxxx1xx0011x : il_vptsw1en_read=1'b1; //Cpt	MRG00	Invpp	DIS
			28'bxxxxxxxxxxx1xxxxxxxx1xx1001x : il_vptsw1en_read=1'b1; //Extvpp1	MRG01	Invpp	DIS
			28'bxxxxxxxxxxx1xxxxxxxx1xx0011x : il_vptsw1en_read=1'b1; //Cpt	MRG01	Invpp	DIS
			28'bxxxxxxxxxxxxx1xxxxxx1xx1001x : il_vptsw1en_read=1'b1; //Extvpp1	MRG10	Invpp	DIS
			28'bxxxxxxxxxxxxx1xxxxxx1xx0011x : il_vptsw1en_read=1'b1; //Cpt	MRG10	Invpp	DIS
			28'bxxxxxxxxxxxxxxx1xxxx1xx1001x : il_vptsw1en_read=1'b1; //Extvpp1	MRG11	Invpp	DIS
			28'bxxxxxxxxxxxxxxx1xxxx1xx0011x : il_vptsw1en_read=1'b1; //Cpt	MRG11	Invpp	DIS
			28'bxxxxxxxxxxxxxxxxx1xx1xx1001x : il_vptsw1en_read=1'b1; //Extvpp1	MRG12	Invpp	DIS
			28'bxxxxxxxxxxxxxxxxx1xx1xx0011x : il_vptsw1en_read=1'b1; //Cpt	MRG12	Invpp	DIS
			28'bxxxxxxxxxx1xxxxxxxx1xxx1000x : il_vptsw1en_read=1'b1; //Invpp	DIS	Extvpp1	MRG00
			28'bxxxxxxxxxxxx1xxxxxx1xxx1000x : il_vptsw1en_read=1'b1; //Invpp	DIS	Extvpp1	MRG01
			28'bxxxxxxxxxxxxxx1xxxx1xxx1000x : il_vptsw1en_read=1'b1; //Invpp	DIS	Extvpp1	MRG10
			28'bxxxxxxxxxxxxxxxx1xx1xxx1000x : il_vptsw1en_read=1'b1; //Invpp	DIS	Extvpp1	MRG11
			28'bxxxxxxxxxxxxxxxxxx11xxx1000x : il_vptsw1en_read=1'b1; //Invpp	DIS	Extvpp1	MRG12
			28'bxxxxxxxxxxxxxxxxxxx1xx11000x : il_vptsw1en_read=1'b1; //Invpp	DIS	Extvpp1	READ
			28'bxxx1xxxxxxxxxxxxxxx1xxx1000x : il_vptsw1en_read=1'b1; //Invpp	DIS	Extvpp1	RDT
			28'bxxxxx1xxxxxxxxxxxxx1xxx1000x : il_vptsw1en_read=1'b1; //Invpp	DIS	Extvpp1	RDMRG0
			28'bxxxxxxx1xxxxxxxxxxx1xxx1000x : il_vptsw1en_read=1'b1; //Invpp	DIS	Extvpp1	RDMRG1
			28'bxxxxxxxxxxxxxxxxxxxx11x1001x : il_vptsw1en_read=1'b1; //Extvpp1	READ	Invpp	DIS
		        28'bxxxxxxxxxxxxxxxxxxxx11x0011x : il_vptsw1en_read=1'b1; //Cpt	READ	Invpp	DIS
			28'bxxxxxxxxxxxxxxxxxxxx11x10011 : il_vptsw1en_read=1'b1; //Extvpp1	TRMREAD2Invpp	DIS
			28'b1xxxxxxxxxxxxxxxxxxx1xx0011x : il_vptsw1en_read=1'b1; //Cpt	IONCHK1	Invpp	DIS
			28'bxx11xxxxxxxxxxxxxxxxxxx1001x : il_vptsw1en_read=1'b1; //Extvpp1	RDT	Extvpp1	RDT
			28'bxx1xxxxxxxxxxxxxxxxx1xx1001x : il_vptsw1en_read=1'b1; //Extvpp1	RDT	Invpp	DIS
			28'bxx1xxxxxxxxxxxxxxxxx1xx0011x : il_vptsw1en_read=1'b1; //Cpt	RDT	Invpp	DIS
			28'bx1xxxxxxxxxxxxxxxxxx1xx0011x : il_vptsw1en_read=1'b1; //Cpt	STCHK	Invpp	DIS
			28'bxxxx1xxxxxxxxxxxxxxx1xx1001x : il_vptsw1en_read=1'b1; //Extvpp1	RDMRG0	Invpp	DIS
			28'bxxxx1xxxxxxxxxxxxxxx1xx0011x : il_vptsw1en_read=1'b1; //Cpt	RDMRG0	Invpp	DIS
			28'bxxxxxx1xxxxxxxxxxxxx1xx1001x : il_vptsw1en_read=1'b1; //Extvpp1	RDMRG1	Invpp	DIS
			28'bxxxxxx1xxxxxxxxxxxxx1xx0011x : il_vptsw1en_read=1'b1; //Cpt	RDMRG1	Invpp	DIS
			28'bxxxxxxxx1xxxxxxxxxxx1xx0011x : il_vptsw1en_read=1'b1; //Cpt	RDMRGC	Invpp	DIS
			default                          : il_vptsw1en_read=1'b0;
		endcase
	end

	reg il_vptsw1en_erase_p;
	always @(
		MD_EXER or MD_DEXER or MD_CER or MD_DCER or MD_SER or
		MD_DSER or MD_DIS or MD_DDIS or MD_EXTVPP1 or MD_EXTVPP2 or
		MD_CPT or MD_CWEE
		) begin
		casex({
		MD_EXER, MD_DEXER, MD_CER, MD_DCER, MD_SER,
		MD_DSER, MD_DIS, MD_DDIS, MD_EXTVPP1, MD_EXTVPP2,
		MD_CPT, MD_CWEE
		})
			  //         111
			  //123456789012
			  //MMMMMMMMMMMM
			  //DDDDDDDDDDDD
			  //____________
			  // D D D DEECC
			  //EECCSSDDXXPW
			  //XXEEEEIITTTE
			  //EERRRRSSVV E
			  //RR      PP  
			  //        PP  
			  //        12  
			12'bxx1xxxx11001 : il_vptsw1en_erase_p=1'b1; //Extvpp1	CER	Invpp	DIS
			12'bxx1xxxx10011 : il_vptsw1en_erase_p=1'b1; //Cpt	CER	Invpp	DIS
			12'bxxxx1xx11001 : il_vptsw1en_erase_p=1'b1; //Extvpp1	SER	Invpp	DIS
			12'bxxxx1xx10011 : il_vptsw1en_erase_p=1'b1; //Cpt	SER	Invpp	DIS
			12'bxxx1xx1x1000 : il_vptsw1en_erase_p=1'b1; //Invpp	DIS	Extvpp1	CER
			12'bxxxxx11x1000 : il_vptsw1en_erase_p=1'b1; //Invpp	DIS	Extvpp1	SER
			12'bx1xxxx1x1000 : il_vptsw1en_erase_p=1'b1; //Invpp	DIS	Extvpp1	EXER
			12'b11xxxxxx1001 : il_vptsw1en_erase_p=1'b1; //Extvpp1	EXER	Extvpp1	EXER
			12'b1xxxxxx11001 : il_vptsw1en_erase_p=1'b1; //Extvpp1	EXER	Invpp	DIS
			12'b1xxxxxx10011 : il_vptsw1en_erase_p=1'b1; //Cpt	EXER	Invpp	DIS
			default          : il_vptsw1en_erase_p=1'b0;
		endcase
	end
	wire il_vptsw1en_erase;
	assign il_vptsw1en_erase = il_vptsw1en_erase_p & MD_FCLK1;

	reg il_vptsw1en_write_p;
	always @(
		MD_MSWR or MD_DMSWR or MD_WDT1 or MD_DWDT1 or MD_WDT2 or
		MD_DWDT2 or MD_WDT3 or MD_DWDT3 or MD_WDT4 or MD_DWDT4 or
		MD_WWR or MD_DWWR or MD_DIS or MD_DDIS or MD_EXTVPP1 or
		MD_EXTVPP2 or MD_CPT or MD_CWEE or MD_MEOC
		) begin
		casex({
		MD_MSWR, MD_DMSWR, MD_WDT1, MD_DWDT1, MD_WDT2,
		MD_DWDT2, MD_WDT3, MD_DWDT3, MD_WDT4, MD_DWDT4,
		MD_WWR, MD_DWWR, MD_DIS, MD_DDIS, MD_EXTVPP1,
		MD_EXTVPP2, MD_CPT, MD_CWEE, MD_MEOC
		})
			  //         1111111111
			  //1234567890123456789
			  //MMMMMMMMMMMMMMMMMMM
			  //DDDDDDDDDDDDDDDDDDD
			  //___________________
			  // D D D D D D DEECCM
			  //MMWWWWWWWWWWDDXXPWE
			  //SSDDDDDDDDWWIITTTEO
			  //WWTTTTTTTTRRSSVV EC
			  //RR11223344    PP  
			  //              PP  
			  //              12  
			19'bxxxxxxxxxx1xx11001x : il_vptsw1en_write_p=1'b1; //Extvpp1	WWR	Invpp	DIS
			19'bxxxxxxxxxx1xx10101x : il_vptsw1en_write_p=1'b1; //Extvpp2	WWR	Invpp	DIS
			19'bxxxxxxxxxx1xx10011x : il_vptsw1en_write_p=1'b1; //Cpt	WWR	Invpp	DIS
			19'bxxxxxxxxxx1xx10111x : il_vptsw1en_write_p=1'b1; //Cpt+Ex2	WWR	Invpp	DIS
			19'bxxxxxxxxxxx11x1000x : il_vptsw1en_write_p=1'b1; //Invpp	DIS	Extvpp1	WWR
			19'bxxxxxxxxxxx11x0100x : il_vptsw1en_write_p=1'b1; //Invpp	DIS	Extvpp2	WWR
			19'bx1xxxxxxxxxx1x10000 : il_vptsw1en_write_p=1'b1; //Invpp	DIS	Extvpp1	MSWR
			19'bx1xxxxxxxxxx1x0100x : il_vptsw1en_write_p=1'b1; //Invpp	DIS	Extvpp2	MSWR
			19'bxxx1xxxxxxxx1x1000x : il_vptsw1en_write_p=1'b1; //Invpp	DIS	Extvpp1	WDT1
			19'bxxx1xxxxxxxx1x0100x : il_vptsw1en_write_p=1'b1; //Invpp	DIS	Extvpp2	WDT1
			19'bxxxxx1xxxxxx1x1000x : il_vptsw1en_write_p=1'b1; //Invpp	DIS	Extvpp1	WDT2
			19'bxxxxx1xxxxxx1x0100x : il_vptsw1en_write_p=1'b1; //Invpp	DIS	Extvpp2	WDT2
			19'bxxxxxxx1xxxx1x1000x : il_vptsw1en_write_p=1'b1; //Invpp	DIS	Extvpp1	WDT3
			19'bxxxxxxxxx1xx1x1000x : il_vptsw1en_write_p=1'b1; //Invpp	DIS	Extvpp1	WDT4
			19'b11xxxxxxxxxxxx10010 : il_vptsw1en_write_p=1'b1; //Extvpp1	MSWR	Extvpp1	MSWR
			19'b1xxxxxxxxxxxx110010 : il_vptsw1en_write_p=1'b1; //Extvpp1	MSWR	Invpp	DIS
			19'b1xxxxxxxxxxxx10101x : il_vptsw1en_write_p=1'b1; //Extvpp2	MSWR	Invpp	DIS
			19'b1xxxxxxxxxxxx10011x : il_vptsw1en_write_p=1'b1; //Cpt	MSWR	Invpp	DIS
			19'b1xxxxxxxxxxxx10111x : il_vptsw1en_write_p=1'b1; //Cpt+Ex2	MSWR	Invpp	DIS
			19'bxx11xxxxxxxxxx1001x : il_vptsw1en_write_p=1'b1; //Extvpp1	WDT1	Extvpp1	WDT1
			19'bxx1xxxxxxxxxx11001x : il_vptsw1en_write_p=1'b1; //Extvpp1	WDT1	Invpp	DIS
			19'bxx1xxxxxxxxxx10101x : il_vptsw1en_write_p=1'b1; //Extvpp2	WDT1	Invpp	DIS
			19'bxx1xxxxxxxxxx10011x : il_vptsw1en_write_p=1'b1; //Cpt	WDT1	Invpp	DIS
			19'bxx1xxxxxxxxxx10111x : il_vptsw1en_write_p=1'b1; //Cpt+Ex2	WDT1	Invpp	DIS
			19'bxx1xxxxxxxxxxx1001x : il_vptsw1en_write_p=1'b1; //Extvpp1	WDT1	Extvpp1	WDT1
			19'bxxxx11xxxxxxxx1001x : il_vptsw1en_write_p=1'b1; //Extvpp1	WDT2	Extvpp1	WDT2
			19'bxxxx1xxxxxxxx11001x : il_vptsw1en_write_p=1'b1; //Extvpp1	WDT2	Invpp	DIS
			19'bxxxx1xxxxxxxx10101x : il_vptsw1en_write_p=1'b1; //Extvpp2	WDT2	Invpp	DIS
			19'bxxxx1xxxxxxxx10011x : il_vptsw1en_write_p=1'b1; //Cpt	WDT2	Invpp	DIS
			19'bxxxx1xxxxxxxx10111x : il_vptsw1en_write_p=1'b1; //Cpt+Ex2	WDT2	Invpp	DIS
			19'bxxxxxx11xxxxxx1001x : il_vptsw1en_write_p=1'b1; //Extvpp1	WDT3	Extvpp1	WDT3
			19'bxxxxxx1xxxxxx11001x : il_vptsw1en_write_p=1'b1; //Extvpp1	WDT3	Invpp	DIS
			19'bxxxxxx1xxxxxx10011x : il_vptsw1en_write_p=1'b1; //Cpt	WDT3	Invpp	DIS
			19'bxxxxxx1xxxxxx10111x : il_vptsw1en_write_p=1'b1; //Cpt+Ex2	WDT3	Invpp	DIS
			19'bxxxxxxxx11xxxx1001x : il_vptsw1en_write_p=1'b1; //Extvpp1	WDT4	Extvpp1	WDT4
			19'bxxxxxxxx1xxxx10011x : il_vptsw1en_write_p=1'b1; //Cpt	WDT4	Invpp	DIS
			19'bxxxxxxxx1xxxx10111x : il_vptsw1en_write_p=1'b1; //Cpt+Ex2	WDT4	Invpp	DIS
			default                 : il_vptsw1en_write_p=1'b0;
		endcase
	end

	wire il_vptsw1en_write;
	assign il_vptsw1en_write = IL_WRITE & il_vptsw1en_write_p;

        wire ivptsw1enct1;
        assign ivptsw1enct1 = MD_CPT & ~MD_EXTVPP1 & ~MD_EXTVPP2 & ( MD_CPBT | MD_DCPBT );

	wire ivptsw1enct;
	assign ivptsw1enct = MD_EXTVPP1 & ~MD_CPT & ( MD_CPBT | MD_DCPBT );

	wire ivptsw1ends;
	assign ivptsw1ends = MD_CPT & ~MD_EXTVPP1 & ~MD_EXTVPP2 & ( MD_CWEE & MD_DIS & MD_DDIS );

	assign IL_VPTSW1EN =   il_vptsw1en_read | il_vptsw1en_erase | il_vptsw1en_write
                             | ivptsw1enct1
                             | ivptsw1enct
			     | ivptsw1ends;

	reg IL_PVDDCPSWEN;
	always @(MD_EXTVPP1 or MD_EXTVPP2 or MD_CPT or MD_IREFT or MD_CWEE or
		MD_WWR or MD_CER or MD_DDIS or MD_OSCNOSTP
		) begin
		casex({
		MD_EXTVPP1, MD_EXTVPP2, MD_CPT, MD_IREFT, MD_CWEE,
		MD_WWR, MD_CER, MD_DDIS, MD_OSCNOSTP
		})
			  //        
			  //123456789
			  //MMMMMMMMM
			  //DDDDDDDDD
			  //_________
			  //EECICWCDO
			  //XXPRWWEDS
			  //TTTEERRIC
			  //VV FE  SN
			  //PP T    O
			  //PP      S
			  //12      T
			  //        P
			 9'b101011x11: IL_PVDDCPSWEN=1'b1; //Cpt+Ex1	WWR	Invpp	DIS
			 9'b10101x111: IL_PVDDCPSWEN=1'b1; //Cpt+Ex1	CER	Invpp	DIS
			default      : IL_PVDDCPSWEN=1'b0;
		endcase
	end

endmodule


//
//  dummy
//

module QNSC3NCP1V2_CPDMY ( );

wire NETHIGH1, NETHIGH2, NETHIGH3, NETHIGH4, NETHIGH5;
wire NETLOW1,  NETLOW2,  NETLOW3,  NETLOW4,  NETLOW5;

wire NINV_DM001, NINV_DM002, NINV_DM003, NINV_DM004, NINV_DM005;
wire NINV_DM006;

wire NETINV001, NETINV002, NETINV003, NETINV004, NETINV005;
wire NETINV006;
wire dmyopen1, dmyopen2, dmyopen3, dmyopen4, dmyopen5, dmyopen6;

// Clump
TBCLH TBCLH01 ( .N01(NETHIGH1) );
TBCLL TBCLL01 ( .N01(NETLOW1)  );

// INV
TBINVX1  XINV001 ( .N01(NINV_DM001), .H01(NETINV001) );
TBINVX1  XINV002 ( .N01(NINV_DM002), .H01(NETINV002) );
TBINVX1  XINV003 ( .N01(NINV_DM003), .H01(NETINV003) );
TBINVX1  XINV004 ( .N01(NINV_DM004), .H01(NETINV004) );
TBINVX1  XINV005 ( .N01(NINV_DM005), .H01(NETINV005) );
TBINVX1  XINV006 ( .N01(NINV_DM006), .H01(NETINV006) );

// NOR2
TBNR2X1  XNOR201 ( .N01(NETINV001), .H01(NETLOW1), .H02(NETLOW1));
TBNR2X1  XNOR202 ( .N01(NETINV002), .H01(NETLOW1), .H02(NETLOW1));


// NOR3
TBNR3X1  XNOR301 ( .N01(NETINV003), .H01(NETLOW1), .H02(NETLOW1), .H03(NETLOW1) );
TBNR3X1  XNOR302 ( .N01(NETINV004), .H01(NETLOW1), .H02(NETLOW1), .H03(NETLOW1) );


// NAND2
TBND2X1  XNAND201 ( .N01(NETINV005), .H01(NETHIGH1), .H02(NETHIGH1) );
TBND2X1  XNAND202 ( .N01(NETINV006), .H01(NETHIGH1), .H02(NETHIGH1) );


// NAND3
TBND3X1  XNAND301 ( .N01(dmyopen1), .H01(NETHIGH1), .H02(NETHIGH1), .H03(NETHIGH1) );
TBND3X1  XNAND302 ( .N01(dmyopen2), .H01(NETHIGH1), .H02(NETHIGH1), .H03(NETHIGH1) );


// NAND4
TBND4X1  XNAND401 ( .N01(dmyopen3), .H01(NETHIGH1), .H02(NETHIGH1), .H03(NETHIGH1), .H04(NETHIGH1) );
TBND4X1  XNAND402 ( .N01(dmyopen4), .H01(NETHIGH1), .H02(NETHIGH1), .H03(NETHIGH1), .H04(NETHIGH1) );

// DFF (CB RB)
TBDFLQRBX1  XDFF501 ( .N01(dmyopen5), .H01(NETLOW1), .H02(NETLOW1), .H03(NETLOW1) );

// D-LATCH
TBLAHQRBX1  XDLA601 ( .N01(dmyopen6), .H01(NETLOW1), .H02(NETLOW1), .H03(NETLOW1) );

endmodule




//
// CPMAJ3LATT.v
//
module QNSC3NCP1V2_CPMAJ3LATT (
    // input port
    CLK,
    DIN,
    // output port
    OUTT
);


input CLK;
input DIN;

output OUTT;


// Level-latch
reg DLAT1, DLAT2, DLAT3;
always @ ( CLK or DIN ) begin
    if ( ~CLK ) DLAT1 = DIN;
end
always @ ( CLK or DIN ) begin
    if ( ~CLK ) DLAT2 = DIN;
end
always @ ( CLK or DIN ) begin
    if ( ~CLK ) DLAT3 = DIN;
end


// 3-bit Majority Gate
assign OUTT = (DLAT1 & DLAT2) | (DLAT2 & DLAT3) | (DLAT1 & DLAT3);

endmodule




//
// CPMAJ3LATTR.v
//
module QNSC3NCP1V2_CPMAJ3LATTR (
    // input port
    RSTB,
    CLKB,
    DIN,
    // output port
    OUTT
);


input RSTB;
input CLKB;
input DIN;

output OUTT;


// Level-latch
reg DREG1, DREG2, DREG3;
always @(negedge RSTB or negedge CLKB) begin
                if (~RSTB)    DREG1 <= 1'b0;
                else          DREG1 <= DIN;
end
always @(negedge RSTB or negedge CLKB) begin
                if (~RSTB)    DREG2 <= 1'b0;
                else          DREG2 <= DIN;
end
always @(negedge RSTB or negedge CLKB) begin
                if (~RSTB)    DREG3 <= 1'b0;
                else          DREG3 <= DIN;
end


// 3-bit Majority Gate
assign OUTT = (DREG1 & DREG2) | (DREG2 & DREG3) | (DREG1 & DREG3);

endmodule

