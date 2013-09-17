//
// Copyright (C) 2011 Renesas Electronics Corporation. All rights reserved.
// Verilog-Model
// DF1.0    2010.04.23 T.Kawano
//                     New Create
// DF1.6    2010.06.08 T.Kawano
//                     LIB Version were changed.
// DF2.0    2010.06.30 T.Kawano
//                     Logic change
// v1.0     2010.07.22 T.Kawano
//                     Logic change
//                     delete redun pin from QNSA3NxxxK0V2
// v1.01    2010.08.09 R.Arakawa
//                     DIS-Mode change
//                     RESET-Check Modify
//                     A/EXA/BFA/CE Hold Spec Modify
// v1.02    2010.08.30 R.Arakawa
//                     RESET-Check Modify
// v1.03    2010.09.23 T.Kawano
//                     delete space for tmp2_RO
//                     IDIS change
//                     TCLKHls 55ns -> 50ns
// v1.04    2010.10.20 R.Arakawa
//                     BFA access SectorAddress DontCare
//
// v2.00    2011.3.22 A.Furuya
//                     1.Reflected results of spyglass's run
//                     2.Changed intce & read function
//                                into the same action as circuit
//                     3.Changed tMS 10us->0ns in IONCHK1
//                     4.Changed tPE 10ms->5ms in erase
//                     5.Changed tCYC 110ns->105ns in HISPEED/LOWPOWER/RLOWSPY=L/L/L
//                     6.Changed tCLKL/H=440ns->121ns tCYC=880ns->242ns in HISPEED/LOWPOWER/RLOWSPY=L/L/H
//                     7.Added tSRCUTS=2500ns/tSRCUTH=0ns in HISPEED/LOWPOWER/RLOWSPY=L/L/H
//                     8.Changed copyright->use of parameter
//                     9.Deleted Check of address changing after reset
//                     10.Added tRDSTOP=4/12/15ns(2.1/1.8/1.6V)(neg RDCLK~pos FLSTOP)
//                     11.Changed A11 of EXA/BFA into use of parameter
//                     12.Added check of changing A/EXA/BFA/CE
/*
##################################################################
#   PDB Version : v2.00
#   LIB Version : v2.00
#   MF3 Code Flash Macro
#   Macro Name : QNSA3N032K1V2
##################################################################
*/

`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module QNSA3N032K1V2 (
     RO37, RO36, RO35, RO34, RO33, RO32, RO31, RO30,
     RO29, RO28, RO27, RO26, RO25, RO24, RO23, RO22, RO21, RO20,
     RO19, RO18, RO17, RO16, RO15, RO14, RO13, RO12, RO11, RO10,
     RO9, RO8, RO7, RO6, RO5, RO4, RO3, RO2, RO1, RO0,
     DW37, DW36, DW35, DW34, DW33, DW32, DW31, DW30,
     DW29, DW28, DW27, DW26, DW25, DW24, DW23, DW22, DW21, DW20,
     DW19, DW18, DW17, DW16, DW15, DW14, DW13, DW12, DW11, DW10,
     DW9, DW8, DW7, DW6, DW5, DW4, DW3, DW2, DW1, DW0,
     A14, A13, A12, A11, A10, A9, A8, A7, A6, A5, A4, A3, A2,
     BEU0, BEU1, BEU2, BFA,
     CE, CER, CLKSEL1, CPBT, CPT, CWEE, DIS,
     EXA, EXER, EXTVPP1, EXTVPP2, FCLK1, FCLK2,
     FLSTOP, HISPEED, HVPPTS1, IONCHK1, IREFT,
     LOWPOWER, LOWSPY, MEOC, MEOR, MRG00, MRG01, MRG10, MRG11, MRG12,
     MSWR, MUTEST, POCREL, PROGI,
     RDCLKC1, RDCLKP1, RDMRG0, RDMRG1, RDMRGC, RDT, READ,
     RLOWSPY, SACEEN, SCANIN, SCANMODE, SER, SRCUT, SRCUTCP,
     STCHK, SUB, TESDBT, TRMCP10, TRMCP11, TRMCP12, TRMCP13, TRMCP14,
     TRMRD1, TRMRD2, VBRESZ, VBRESZCP, VCPHV, VPBIAS, VREGMV, VREGRMV, WDT1, WDT2,
     WDT3, WDT4, WED, WWR );

output
     RO37, RO36, RO35, RO34, RO33, RO32, RO31, RO30,
     RO29, RO28, RO27, RO26, RO25, RO24, RO23, RO22, RO21, RO20,
     RO19, RO18, RO17, RO16, RO15, RO14, RO13, RO12, RO11, RO10,
     RO9, RO8, RO7, RO6, RO5, RO4, RO3, RO2, RO1, RO0;

input
     DW37, DW36, DW35, DW34, DW33, DW32, DW31, DW30,
     DW29, DW28, DW27, DW26, DW25, DW24, DW23, DW22, DW21, DW20,
     DW19, DW18, DW17, DW16, DW15, DW14, DW13, DW12, DW11, DW10,
     DW9, DW8, DW7, DW6, DW5, DW4, DW3, DW2, DW1, DW0,
     A14, A13, A12, A11, A10, A9, A8, A7, A6, A5, A4, A3, A2,
     BEU0, BEU1, BEU2, BFA, CE, CER, CLKSEL1, CPBT, CPT, CWEE,
     DIS, EXA, EXER, EXTVPP1,
     EXTVPP2, FCLK1, FCLK2, FLSTOP, HISPEED,
     HVPPTS1, IONCHK1, IREFT, LOWPOWER, LOWSPY, MEOC, MEOR, MRG00,
     MRG01, MRG10, MRG11, MRG12, MSWR, MUTEST, POCREL, PROGI,
     RDCLKC1, RDCLKP1, RDMRG0,
     RDMRG1, RDMRGC, RDT, READ, RLOWSPY, SACEEN, SCANIN,
     SCANMODE, SER, SRCUT, SRCUTCP, STCHK, SUB, TESDBT, TRMCP10,
     TRMCP11, TRMCP12, TRMCP13, TRMCP14, TRMRD1, TRMRD2, VBRESZ, VBRESZCP, VCPHV,
     VPBIAS, VREGMV, VREGRMV, WDT1, WDT2, WDT3, WDT4, WED, WWR;

/*-----parameter-----*/
  parameter WORD= 8192;   // USER CODE Size 256KB:65536/128KB:32768/064KB:16384/032KB:8192/016KB:4096
                           // USER DATA Size 016KB:16384/008KB: 8192/004KB: 4096/002KB:2048
  parameter WORDR= 256;   // REDUN 256 x 32 = 1KB
  parameter WORDE= 1024;   // EXTRA 1024 x 32 = 2KB(4KB)
  parameter WORDB= 1024;   // BFA 1024 x 32 = 4KB
  parameter SECTOR= 256;     // Sector CODE  256 x 32 = 1KB
                                 // Sector DATA 1024 x  8 = 1KB
  parameter IOBIT= 38;   // IO Bit Value
  parameter ADBIT= 13;  // Address Bit Value
  parameter RD_ADBIT= 5;  // Redun Address Bit Value
  parameter SECBIT= 5;
  parameter AD_TOP= 14;
  parameter AD_BOTTOM= 2;
  parameter SECAD_BOTTOM= 10;
  parameter SECAD_OTHER_TOP= 9;
  parameter BFA_TOP= 11;  //v2.00
  parameter EXA_TOP= 11;  //v2.00
  parameter all_1={IOBIT{1'b1}}; // all 1
  parameter all_0={IOBIT{1'b0}}; // all 0
  parameter all_X={IOBIT{1'bx}}; // all x
  parameter all_0X={(IOBIT/2){2'b0x}}; // all_0X
  parameter ErMaxRetry = 1;
  parameter WrMaxRetry = 1;
  parameter StchkOut = {IOBIT{1'b0}};  // STCHK
  parameter ReadTest = {IOBIT{1'b0}};  // READ SACEEN=L & CE=L

//Parameter Mode Control
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
  parameter M_ALL0    = 23'b00000000000000000000000; //

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

// Spec
  parameter TCREGS             =          0;  // Zantei
  parameter TSTOPtoHS          =    5000000;
  parameter TSTOPtoLS          =     720000;
  parameter TSTOPtoLV          =   10000000;
  parameter TSTOPtoLP          =     720000;

  parameter TMS_DIStoHS        =    5000000;
  parameter TMS_DIStoLS        =     720000;  // ?????
  parameter TMS_DIStoLV        =   10000000;
  parameter TMS_DIStoLP        =     720000;  // ?????
  parameter TMS_DIStoER        =   10000000;
  parameter TMS_MRG1           =    1000000;  // Internal Verify
  parameter TMS_MRG2           =   10000000;  // LOWSPY=L
  parameter TMS_MRG3           =   40000000;  // LOWSPY=H
  parameter TMS_DIStoRDM       =   20000000;  // RDMRG0/1
  parameter TMS_DIStoRDMC      =   14000000;  // RDMRGC
  parameter TMS_DIStoION       =          0;  //v2.00
  parameter TMS_DIStoST        =   20000000;
  parameter TMS_BT             =   11000000;

  parameter TDIS_fromWWR       =    3000000;
  parameter TDIS_fromMSWR1     =   10000000;  // BEU <= 3
  parameter TDIS_fromMSWR2     =  500000000;  // BEU > 3
  parameter TDIS_fromER1       =   10000000;  // LOWSPY=L
  parameter TDIS_fromER2       =   20000000;  // LOWSPY=H
  parameter TDIS_fromMRG1      =    1000000;  // LOWSPY=L
  parameter TDIS_fromMRG2      =    2000000;  // LOWSPY=H
  parameter TDIS_fromREAD1     =    2000000;  // RLOWSPY=L
  parameter TDIS_fromREAD2     =    3000000;  // RLOWSPY=H
  parameter TDIS_fromION1      =    1000000;  // LOWSPY=L
  parameter TDIS_fromION2      =    2000000;  // LOWSPY=H
  parameter TDIS_fromCPBT1     =   10000000;  // LOWSPY=L
  parameter TDIS_fromCPBT2     =   20000000;  // LOWSPY=H
  parameter TDIS_fromWDT       =  500000000;
  parameter TDIS_fromRDT       =   10000000;
  parameter TDIS_fromST        =    1000000;
  parameter TDIS_fromRDM       =   10000000;
  parameter TDIS_fromDEF       =    1000000;  // DEFAULT SPEC

// Other
  parameter TOH = 1;  //  All Read Mode tOH value
  parameter TOD_TRMRD1 =  4700000;  // Triming Read 1 tOD
  parameter TOD_TRMRD2 =  5000000;  // Triming Read 2 tOD
  parameter TOD_TRMRD3 =  5000000;  // Triming Read 3 tOD
  parameter THISPEEDS  =  5000000;  // HISPEED HS Setup
  parameter TLSPYS     = 10000000;  // RLOWSPY LV Setup
  parameter TLOWPOWERS =  3000000;  // LOWPOWER LP Setup
  parameter TLOWSPEEDS =   720000;  // LOWSPEED LS Setup
  parameter TOD_18V = 12000;  // 18v tOD for LS/LP/SUB/LOWSPY=H
  parameter TPE_TYP = 64'd5000000000;  // tPE = 5ms v2.00
  parameter ModeChangeSpec = 10001;  // 10ns + 1ps

  parameter TRMCP_NG1 =  5'b01101;  //v2.00
  parameter TRMCP_NG2 =  5'b01110;  //v2.00
  parameter TRMCP_NG3 =  5'b01111;  //v2.00


// RESET Signal State (Code)  100724
//                                                                         L             S  
//                                                 I          EE     RRC   OHR           C  
//                                                 O       RRRXX    SDDL   WILL          ATM
//                                          MMMMM  NS      DDDTT I  ACCK   PSOOS     FFP NEU
//                                      M  ERRRRR RCTCWWWW MMMVV RMMCLLS C OPWWR  BBBCCR MST
//                                     WSCSXGGGGGDEHCPDDDDRRRRPPCEEEEKKE WSWESSCEBEEELLOWODE
//                                     WWEEE00111IAKHBTTTTDGGGPPPFOOECPLCEUEEPPUXFUUUKKGEDBS
//                                     RRRRR01012SD1KT1234T01C12TTRCN111EEBRDYYTAA01212IDETT
  parameter [52:0] RESET_chk_pri = 53'b00000000000100000000000000000101000000100000000001000;

  parameter [IOBIT-1:0] RESET_chk_DW = {(IOBIT){1'b0}};
  parameter [(53+IOBIT-1):0] RESET_chk = {RESET_chk_pri,RESET_chk_DW};


/*-----event-----*/
  event ActSet_TSTOPtoHS;
  event ActSet_TSTOPtoLS;
  event ActSet_TSTOPtoLV;
  event ActSet_TSTOPtoLP;

  event ActSet_TMS_DIStoHS;
  event ActSet_TMS_DIStoLS;
  event ActSet_TMS_DIStoLV;
  event ActSet_TMS_DIStoLP;
  event ActSet_TMS_DIStoER;
  event ActSet_TMS_MRG1;
  event ActSet_TMS_MRG2;
  event ActSet_TMS_MRG3;
  event ActSet_TMS_DIStoRDM;
  event ActSet_TMS_DIStoRDMC;
  event ActSet_TMS_DIStoION;
  event ActSet_TMS_DIStoST;
  event ActSet_TMS_BT;
  event ActSet_TMS_TRMRD2toLV;
  event ActSet_THISPEEDS;
  event ActSet_TLSPYS;
  event ActSet_TLOWPOWERS;
  event ActSet_TLOWSPEEDS;

/*----- time -----*/
  time DISposetime;
  time DISnegetime;
  time FCLK1posetime;
  time FCLK1negetime;
  time FCLK2posetime;
  time FCLK2negetime;
  time CPBTposetime;
  time CPBTnegetime;
  time RDCLKC1posetime;
  time RDCLKC1negetime;
  time RDCLKP1posetime;
  time RDCLKP1negetime;

/*-----memory cell-----*/
  reg [IOBIT - 1:0] memF   [0:WORD - 1];
  reg [IOBIT - 1:0] memRD  [0:WORDR - 1];
  reg [IOBIT - 1:0] memEX  [0:WORDE - 1];
  reg [IOBIT - 1:0] memBFA [0:WORDB - 1];

/*-----flash interface setting-----*/
  integer i,j,k,l,m,n,o,p,q,r,s,t,u;
  integer ii,jj,kk,ll,mm,nn,ir;
  integer progi_cnt;
  integer xz_aa,xz_bb,xz_cc,xz_dd,xz_ee;
  reg pre_RDCLKC1, pre_RDCLKP1;
  reg pre_PROGI, pre_FCLK1, pre_FCLK2, pre_FLSTOP;
  reg pre_VBRESZ, pre_POCREL;
  reg pre_HISPEED, pre_LOWPOWER, pre_RLOWSPY, pre_SUB, pre_LOWSPY;
  reg pre_IDIS;
  reg intce;
  reg intexa;
  reg intbfa;
  reg [AD_TOP:AD_BOTTOM] inta;
  reg [2:0] intbeu;
  reg prevCE,prevEXA,prevBFA;
  reg [AD_TOP:AD_BOTTOM] prevA;
  reg [2:0] prevBEU;
  reg [IOBIT - 1 :0] tmp_RO;
  reg [IOBIT - 1 :0] tmp_RO_toh;
  reg [IOBIT - 1 :0] tmp_secdec;
  reg PROGD;
  reg [9:0] Multi1;
  reg [9:0] Multi2;
  reg [AD_TOP:SECAD_BOTTOM] tmp_secadd;
  reg TSTOPtoHS_flag,TSTOPtoLS_flag,TSTOPtoLV_flag,TSTOPtoLP_flag;
  reg TMS_DIStoHS_flag,TMS_DIStoLS_flag,TMS_DIStoLV_flag,TMS_DIStoLP_flag;
  reg TMS_DIStoER_flag,TMS_MRG1_flag,TMS_MRG2_flag,TMS_MRG3_flag,
      TMS_DIStoRDM_flag,TMS_DIStoRDMC_flag,TMS_DIStoION_flag,TMS_DIStoST_flag,
      TMS_BT_flag,TMS_TRMRD2toLV_flag,
      TLSPYS_flag,THISPEEDS_flag,TLOWPOWERS_flag,TLOWSPEEDS_flag;
  reg [22:0] pre_MODE_TDIS;
  reg pre_CE_TDIS1,pre_LOWSPY_TDIS,pre_RLOWSPY_TDIS;  //v2.00
  reg [2:0] pre_BEU_TDIS;
  reg [22:0] MODE,pre_MODE;
  reg [5:0] MODE_IV,pre_MODE_IV;  // InternalVerify
  reg IDIS;
  reg CIBRead_act,FCBRead_act,MRG_act,IV_act,ER_act,WR_act,
      WDT_act,ION_act,ST_act,RDMRG_act,RDT_act,CPBT_act;
  reg [120:1] VIOLATE_sig,VIOLATE_sig2,VIOLATE_sig3,XZ_sig,VIOLATE_mode;
  reg Error_flag_RD;
  reg Error_flag;
  reg Error_flag_XZ;
  reg Error_flag_XWR;
  reg Error_flag_RST;
  reg [4:0] MODE2,pre_MODE2;
  reg [3:0] intrdctrl_c1,prevRDCTRL_C1,intrdctrl_com,prevRDCTRL_COM;
  reg [3:0] intrdctrl_p1,prevRDCTRL_P1;
  reg pre_SCANMODE,pre_TESDBT;
  reg ROX_flag;
  reg ROX_prevDIS_flag;  // Read first prohibition Flag
  reg intce_chk;  // For Timing Check CE Signal RDCLK=L
  reg [AD_TOP:AD_BOTTOM] pre_A;
  reg pre_CE,pre_EXA,pre_BFA;
  reg STOP_release_flag;
  reg RDCLKC1L,pre_RDCLKC1L,RDCLKC1L_flag;  // For RDCLK 0 timing
  reg RDCLKP1L,pre_RDCLKP1L,RDCLKP1L_flag;  // For RDCLK 0 timing
  reg pre_SCANIN;
  reg [(53+IOBIT-1):0] RESET_st;      // v1.01_modify
  reg RESETCHK_act;  // For RESET Timing
  reg pre_TRMRD2L,TRMRD2L;  // For RESET Timing

  wire [AD_TOP:AD_BOTTOM] A;
  wire [IOBIT - 1 :0] DW;
  wire [IOBIT - 1 :0] tmp2_RO;
  wire [IOBIT - 1 :0] RO;
  wire [RD_ADBIT - 1 :0] R0A;
  wire [2:0] BEU;
  wire TSTOP_flag,TMS_flag;
  wire EWR_act;  // Mode Function Action!!
  wire BTmode_act;  // BT-Mode
  wire MCELL_act;
  wire FLSCAN, CLK;
  wire [IOBIT - 1 :0] Shift_RO,SCAN_RO;
  wire [14:10] TRMCP;
  wire CHGMODE,MHIGH,MLOW;
  wire [IOBIT - 1:0] trmrd1_1, trmrd1_2, trmrd1_3, trmrd1_4;
  wire [IOBIT - 1:0] trmrd2_1, trmrd2_2, trmrd2_3, trmrd2_4;
  wire pow_sig;

/*-----Firm Verify Error Check-----*/
  parameter firmtest_fladd_msb = 19;
  parameter firmtest_fladd_lsb = 0;

  reg CON_FL_QNSA_ERR_MRG00;
  reg CON_FL_QNSA_ERR_MRG01;
  reg CON_FL_QNSA_ERR_MRG10;
  reg CON_FL_QNSA_ERR_MRGX;
  reg CON_FL_QNSA_EX_ERR_MRG00;
  reg CON_FL_QNSA_EX_ERR_MRG01;
  reg CON_FL_QNSA_EX_ERR_MRG10;
  reg CON_FL_QNSA_EX_ERR_MRGX;

  reg [firmtest_fladd_msb:firmtest_fladd_lsb] FL_QNSA_ERR_MRG00_tmp;
  reg [firmtest_fladd_msb:firmtest_fladd_lsb] FL_QNSA_ERR_MRG01_tmp;
  reg [firmtest_fladd_msb:firmtest_fladd_lsb] FL_QNSA_ERR_MRG10_tmp;
  reg [firmtest_fladd_msb:firmtest_fladd_lsb] FL_QNSA_EX_ERR_MRG00_tmp;
  reg [firmtest_fladd_msb:firmtest_fladd_lsb] FL_QNSA_EX_ERR_MRG01_tmp;
  reg [firmtest_fladd_msb:firmtest_fladd_lsb] FL_QNSA_EX_ERR_MRG10_tmp;

/*-----For Specify Flag-----*/
  reg SUBRDCLK;
  integer EdgeLCount;
  wire RDCLK;

/*-----DummyBuff-----*/
buf (RO37, _RO37);
buf (RO36, _RO36);
buf (RO35, _RO35);
buf (RO34, _RO34);
buf (RO33, _RO33);
buf (RO32, _RO32);
buf (RO31, _RO31);
buf (RO30, _RO30);
buf (RO29, _RO29);
buf (RO28, _RO28);
buf (RO27, _RO27);
buf (RO26, _RO26);
buf (RO25, _RO25);
buf (RO24, _RO24);
buf (RO23, _RO23);
buf (RO22, _RO22);
buf (RO21, _RO21);
buf (RO20, _RO20);
buf (RO19, _RO19);
buf (RO18, _RO18);
buf (RO17, _RO17);
buf (RO16, _RO16);
buf (RO15, _RO15);
buf (RO14, _RO14);
buf (RO13, _RO13);
buf (RO12, _RO12);
buf (RO11, _RO11);
buf (RO10, _RO10);
buf (RO9, _RO9);
buf (RO8, _RO8);
buf (RO7, _RO7);
buf (RO6, _RO6);
buf (RO5, _RO5);
buf (RO4, _RO4);
buf (RO3, _RO3);
buf (RO2, _RO2);
buf (RO1, _RO1);
buf (RO0, _RO0);

buf (_DW37, DW37);
buf (_DW36, DW36);
buf (_DW35, DW35);
buf (_DW34, DW34);
buf (_DW33, DW33);
buf (_DW32, DW32);
buf (_DW31, DW31);
buf (_DW30, DW30);
buf (_DW29, DW29);
buf (_DW28, DW28);
buf (_DW27, DW27);
buf (_DW26, DW26);
buf (_DW25, DW25);
buf (_DW24, DW24);
buf (_DW23, DW23);
buf (_DW22, DW22);
buf (_DW21, DW21);
buf (_DW20, DW20);
buf (_DW19, DW19);
buf (_DW18, DW18);
buf (_DW17, DW17);
buf (_DW16, DW16);
buf (_DW15, DW15);
buf (_DW14, DW14);
buf (_DW13, DW13);
buf (_DW12, DW12);
buf (_DW11, DW11);
buf (_DW10, DW10);
buf (_DW9, DW9);
buf (_DW8, DW8);
buf (_DW7, DW7);
buf (_DW6, DW6);
buf (_DW5, DW5);
buf (_DW4, DW4);
buf (_DW3, DW3);
buf (_DW2, DW2);
buf (_DW1, DW1);
buf (_DW0, DW0);
buf (_A14, A14);
buf (_A13, A13);
buf (_A12, A12);
buf (_A11, A11);
buf (_A10, A10);
buf (_A9, A9);
buf (_A8, A8);
buf (_A7, A7);
buf (_A6, A6);
buf (_A5, A5);
buf (_A4, A4);
buf (_A3, A3);
buf (_A2, A2);
buf (_R0A4, 1'b0);      // DummyWire
buf (_R0A3, 1'b0);      // DummyWire
buf (_R0A2, 1'b0);      // DummyWire
buf (_R0A1, 1'b0);      // DummyWire
buf (_R0A0, 1'b0);      // DummyWire

buf (_TRMCP14, TRMCP14);
buf (_TRMCP12, TRMCP12);
buf (_TRMCP13, TRMCP13);
buf (_TRMCP11, TRMCP11);
buf (_TRMCP10, TRMCP10);
buf (_BEU2, BEU2);
buf (_BEU1, BEU1);
buf (_CWEE, CWEE);
buf (_SUB, SUB);
buf (_HISPEED, HISPEED);
buf (_LOWPOWER, LOWPOWER);
buf (_SRCUT, SRCUT);
buf (_EXA, EXA);
buf (_LOWSPY, LOWSPY);
buf (_RLOWSPY, RLOWSPY);
buf (_FCLK1, FCLK1);
buf (_FCLK2, FCLK2);
buf (_BEU0, BEU0);
buf (_BFA, BFA);
buf (_WED, WED);
buf (_PROGI, PROGI);
buf (_R0FLAGZ, 1'b1);      // DummyWire
buf (_SRCUTCP, SRCUTCP);
buf (_VCPHV, VCPHV);
buf (_MUTEST, MUTEST);
buf (_VREGRMV, VREGRMV);
buf (_VREGMV, VREGMV);
buf (_SCANIN, SCANIN);
buf (_TESDBT, TESDBT);
buf (_SCANMODE, SCANMODE);
buf (_POCREL, POCREL);
buf (_TRMRD1, TRMRD1);
buf (_TRMRD2, TRMRD2);
buf (_RDCLKP1, RDCLKP1);
buf (_RDCLKC1, RDCLKC1);
buf (_VPBIAS, VPBIAS);
buf (_HVPPTS1, HVPPTS1);
buf (_CE, CE);
buf (_CLKSEL1, CLKSEL1);
buf (_WDT2, WDT2);
buf (_WDT3, WDT3);
buf (_RDT, RDT);
buf (_WDT4, WDT4);
buf (_RDMRGC, RDMRGC);
buf (_EXTVPP1, EXTVPP1);
buf (_RDMRG1, RDMRG1);
buf (_RDMRG0, RDMRG0);
buf (_MEOC, MEOC);
buf (_SACEEN, SACEEN);
buf (_VBRESZ, VBRESZ);
buf (_VBRESZCP, VBRESZCP);
buf (_FLSTOP, FLSTOP);
buf (_IREFT, IREFT);
buf (_MEOR, MEOR);
buf (_CPT, CPT);
buf (_EXTVPP2, EXTVPP2);
buf (_MRG11, MRG11);
buf (_MRG12, MRG12);
buf (_READ, READ);
buf (_DIS, DIS);
buf (_CPBT, CPBT);
buf (_WDT1, WDT1);
buf (_STCHK, STCHK);
buf (_IONCHK1, IONCHK1);
buf (_EXER, EXER);
buf (_MRG00, MRG00);
buf (_MRG10, MRG10);
buf (_MRG01, MRG01);
buf (_CER, CER);
buf (_SER, SER);
buf (_WWR, WWR);
buf (_MSWR, MSWR);

/*-----Create IntNode-----*/
buf (DW[37], _DW37);
buf (DW[36], _DW36);
buf (DW[35], _DW35);
buf (DW[34], _DW34);
buf (DW[33], _DW33);
buf (DW[32], _DW32);
buf (DW[31], _DW31);
buf (DW[30], _DW30);
buf (DW[29], _DW29);
buf (DW[28], _DW28);
buf (DW[27], _DW27);
buf (DW[26], _DW26);
buf (DW[25], _DW25);
buf (DW[24], _DW24);
buf (DW[23], _DW23);
buf (DW[22], _DW22);
buf (DW[21], _DW21);
buf (DW[20], _DW20);
buf (DW[19], _DW19);
buf (DW[18], _DW18);
buf (DW[17], _DW17);
buf (DW[16], _DW16);
buf (DW[15], _DW15);
buf (DW[14], _DW14);
buf (DW[13], _DW13);
buf (DW[12], _DW12);
buf (DW[11], _DW11);
buf (DW[10], _DW10);
buf (DW[9], _DW9);
buf (DW[8], _DW8);
buf (DW[7], _DW7);
buf (DW[6], _DW6);
buf (DW[5], _DW5);
buf (DW[4], _DW4);
buf (DW[3], _DW3);
buf (DW[2], _DW2);
buf (DW[1], _DW1);
buf (DW[0], _DW0);
buf (A[14], _A14);
buf (A[13], _A13);
buf (A[12], _A12);
buf (A[11], _A11);
buf (A[10], _A10);
buf (A[9], _A9);
buf (A[8], _A8);
buf (A[7], _A7);
buf (A[6], _A6);
buf (A[5], _A5);
buf (A[4], _A4);
buf (A[3], _A3);
buf (A[2], _A2);
buf (R0A[4], _R0A4);
buf (R0A[3], _R0A3);
buf (R0A[2], _R0A2);
buf (R0A[1], _R0A1);
buf (R0A[0], _R0A0);
buf (TRMCP[14], _TRMCP14);
buf (TRMCP[13], _TRMCP13);
buf (TRMCP[12], _TRMCP12);
buf (TRMCP[11], _TRMCP11);
buf (TRMCP[10], _TRMCP10);
buf (BEU[2], _BEU2);
buf (BEU[1], _BEU1);
buf (BEU[0], _BEU0);

buf (TSTOP_flag,(TSTOPtoHS_flag===1'b1 || TSTOPtoLS_flag===1'b1 ||
                 TSTOPtoLV_flag===1'b1 || TSTOPtoLP_flag===1'b1) ? 1'b1 : 1'b0);
buf (TMS_flag,(TMS_DIStoHS_flag===1'b1 || TMS_DIStoLS_flag===1'b1 || TMS_DIStoLV_flag===1'b1 ||
               TMS_DIStoLP_flag===1'b1 || TMS_DIStoER_flag===1'b1 || TMS_MRG1_flag===1'b1 || TMS_MRG2_flag===1'b1 ||
               TMS_MRG3_flag===1'b1 || TMS_DIStoRDM_flag===1'b1 || TMS_DIStoRDMC_flag===1'b1 ||
               TMS_DIStoION_flag===1'b1 || TMS_DIStoST_flag===1'b1 || TMS_BT_flag ||
               TLSPYS_flag===1'b1 || THISPEEDS_flag===1'b1 || TLOWPOWERS_flag===1'b1 || TLOWSPEEDS_flag===1'b1 ||
               TMS_TRMRD2toLV_flag===1'b1) ? 1'b1 : 1'b0);

assign {_RO37, _RO36, _RO35, _RO34, _RO33, _RO32, _RO31, _RO30,
        _RO29, _RO28, _RO27, _RO26, _RO25, _RO24, _RO23, _RO22, _RO21, _RO20,
        _RO19, _RO18, _RO17, _RO16, _RO15, _RO14, _RO13, _RO12, _RO11, _RO10,
        _RO9, _RO8, _RO7, _RO6, _RO5, _RO4, _RO3, _RO2, _RO1, _RO0}=RO;
// assign RDCTRL={_HISPEED,_LOWPOWER,_RLOWSPY,_SUB};

or (CHGMODE, _WWR, _CER, _SER, _MRG00, _MRG01, _MRG10, _MRG11, _MRG12, _READ);
and (MHIGH,  CHGMODE,  _DIS);
and (MLOW,  ~CHGMODE, ~_DIS);
and (pow_sig, _VCPHV, _VREGMV, _VREGRMV);

//-----MODE_act
buf (EWR_act,(_VBRESZ===1'b1 && _SCANMODE===1'b0 && _TESDBT===1'b0) ? 1'b1 : 1'b0);  // Zantei
buf (BTmode_act,(_VBRESZ===1'b1 && _SCANMODE===1'b1 && _TESDBT===1'b1) ? 1'b1 : 1'b0);  // BT-Node
buf (MCELL_act,(_CPT===1'b1 || _IREFT===1'b1) ? 1'b0 : 1'b1);  // Non-access or MemoryCell Access

/*-----RO_SELECT-----*/
assign RO = Error_flag_RST===1'b1 ? all_X : tmp2_RO;
assign tmp2_RO = ((_SCANMODE && ~_TESDBT) && (~_TRMRD1 && ~_TRMRD2)) ? //v1.03 del space 20100918
//                  SCAN_RO : (intce===1'b1 && (MODE===M_SER || MODE===M_CER) && {_SACEEN,_FCLK1,_MUTEST}===3'h5 ? tmp_secdec : tmp_RO);
                  SCAN_RO : (intce===1'b1 && ((MODE===M_SER && _SACEEN===1'b1) || (MODE===M_CER && _SACEEN===1'b0)) && {_FCLK1,_MUTEST}===2'h1 ? tmp_secdec : tmp_RO);

/*-----Scan Chain-----*/
TBNR2BX1 CODE_nor ( .H01(_TESDBT), .H02(_SCANMODE), .N01(FLSCAN) );
TBAD2X1  CODE_and ( .H01(FLSCAN), .H02(_RDCLKC1),  .N01(CLK) );

TBMUX2X1 MUX_RO0 ( .H02(Shift_RO[0]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[0]) );
TBMUX2X1 MUX_RO1 ( .H02(Shift_RO[1]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[1]) );
TBMUX2X1 MUX_RO2 ( .H02(Shift_RO[2]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[2]) );
TBMUX2X1 MUX_RO3 ( .H02(Shift_RO[3]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[3]) );
TBMUX2X1 MUX_RO4 ( .H02(Shift_RO[4]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[4]) );
TBMUX2X1 MUX_RO5 ( .H02(Shift_RO[5]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[5]) );
TBMUX2X1 MUX_RO6 ( .H02(Shift_RO[6]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[6]) );
TBMUX2X1 MUX_RO7 ( .H02(Shift_RO[7]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[7]) );
TBMUX2X1 MUX_RO8 ( .H02(Shift_RO[8]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[8]) );
TBMUX2X1 MUX_RO9 ( .H02(Shift_RO[9]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[9]) );
TBMUX2X1 MUX_RO10 ( .H02(Shift_RO[10]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[10]) );
TBMUX2X1 MUX_RO11 ( .H02(Shift_RO[11]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[11]) );
TBMUX2X1 MUX_RO12 ( .H02(Shift_RO[12]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[12]) );
TBMUX2X1 MUX_RO13 ( .H02(Shift_RO[13]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[13]) );
TBMUX2X1 MUX_RO14 ( .H02(Shift_RO[14]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[14]) );
TBMUX2X1 MUX_RO15 ( .H02(Shift_RO[15]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[15]) );
TBMUX2X1 MUX_RO16 ( .H02(Shift_RO[16]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[16]) );
TBMUX2X1 MUX_RO17 ( .H02(Shift_RO[17]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[17]) );
TBMUX2X1 MUX_RO18 ( .H02(Shift_RO[18]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[18]) );
TBMUX2X1 MUX_RO19 ( .H02(Shift_RO[19]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[19]) );
TBMUX2X1 MUX_RO20 ( .H02(Shift_RO[20]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[20]) );
TBMUX2X1 MUX_RO21 ( .H02(Shift_RO[21]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[21]) );
TBMUX2X1 MUX_RO22 ( .H02(Shift_RO[22]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[22]) );
TBMUX2X1 MUX_RO23 ( .H02(Shift_RO[23]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[23]) );
TBMUX2X1 MUX_RO24 ( .H02(Shift_RO[24]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[24]) );
TBMUX2X1 MUX_RO25 ( .H02(Shift_RO[25]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[25]) );
TBMUX2X1 MUX_RO26 ( .H02(Shift_RO[26]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[26]) );
TBMUX2X1 MUX_RO27 ( .H02(Shift_RO[27]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[27]) );
TBMUX2X1 MUX_RO28 ( .H02(Shift_RO[28]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[28]) );
TBMUX2X1 MUX_RO29 ( .H02(Shift_RO[29]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[29]) );
TBMUX2X1 MUX_RO30 ( .H02(Shift_RO[30]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[30]) );
TBMUX2X1 MUX_RO31 ( .H02(Shift_RO[31]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[31]) );
TBMUX2X1 MUX_RO32 ( .H02(Shift_RO[32]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[32]) );
TBMUX2X1 MUX_RO33 ( .H02(Shift_RO[33]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[33]) );
TBMUX2X1 MUX_RO34 ( .H02(Shift_RO[34]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[34]) );
TBMUX2X1 MUX_RO35 ( .H02(Shift_RO[35]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[35]) );
TBMUX2X1 MUX_RO36 ( .H02(Shift_RO[36]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[36]) );
TBMUX2X1 MUX_RO37 ( .H02(Shift_RO[37]), .H01(1'bx), .H03(FLSCAN), .N01(SCAN_RO[37]) );

TBSMDFLQRBX1 CHAIN_RO0 ( .H01(_SCANIN), .H04(_SCANIN), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[0]) );
TBSMDFLQRBX1 CHAIN_RO1 ( .H01(Shift_RO[0]), .H04(Shift_RO[0]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[1]) );
TBSMDFLQRBX1 CHAIN_RO2 ( .H01(Shift_RO[1]), .H04(Shift_RO[1]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[2]) );
TBSMDFLQRBX1 CHAIN_RO3 ( .H01(Shift_RO[2]), .H04(Shift_RO[2]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[3]) );
TBSMDFLQRBX1 CHAIN_RO4 ( .H01(Shift_RO[3]), .H04(Shift_RO[3]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[4]) );
TBSMDFLQRBX1 CHAIN_RO5 ( .H01(Shift_RO[4]), .H04(Shift_RO[4]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[5]) );
TBSMDFLQRBX1 CHAIN_RO6 ( .H01(Shift_RO[5]), .H04(Shift_RO[5]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[6]) );
TBSMDFLQRBX1 CHAIN_RO7 ( .H01(Shift_RO[6]), .H04(Shift_RO[6]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[7]) );
TBSMDFLQRBX1 CHAIN_RO8 ( .H01(Shift_RO[7]), .H04(Shift_RO[7]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[8]) );
TBSMDFLQRBX1 CHAIN_RO9 ( .H01(Shift_RO[8]), .H04(Shift_RO[8]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[9]) );
TBSMDFLQRBX1 CHAIN_RO10 ( .H01(Shift_RO[9]), .H04(Shift_RO[9]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[10]) );
TBSMDFLQRBX1 CHAIN_RO11 ( .H01(Shift_RO[10]), .H04(Shift_RO[10]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[11]) );
TBSMDFLQRBX1 CHAIN_RO12 ( .H01(Shift_RO[11]), .H04(Shift_RO[11]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[12]) );
TBSMDFLQRBX1 CHAIN_RO13 ( .H01(Shift_RO[12]), .H04(Shift_RO[12]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[13]) );
TBSMDFLQRBX1 CHAIN_RO14 ( .H01(Shift_RO[13]), .H04(Shift_RO[13]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[14]) );
TBSMDFLQRBX1 CHAIN_RO15 ( .H01(Shift_RO[14]), .H04(Shift_RO[14]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[15]) );
TBSMDFLQRBX1 CHAIN_RO16 ( .H01(Shift_RO[15]), .H04(Shift_RO[15]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[16]) );
TBSMDFLQRBX1 CHAIN_RO17 ( .H01(Shift_RO[16]), .H04(Shift_RO[16]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[17]) );
TBSMDFLQRBX1 CHAIN_RO18 ( .H01(Shift_RO[17]), .H04(Shift_RO[17]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[18]) );
TBSMDFLQRBX1 CHAIN_RO19 ( .H01(Shift_RO[18]), .H04(Shift_RO[18]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[19]) );
TBSMDFLQRBX1 CHAIN_RO20 ( .H01(Shift_RO[19]), .H04(Shift_RO[19]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[20]) );
TBSMDFLQRBX1 CHAIN_RO21 ( .H01(Shift_RO[20]), .H04(Shift_RO[20]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[21]) );
TBSMDFLQRBX1 CHAIN_RO22 ( .H01(Shift_RO[21]), .H04(Shift_RO[21]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[22]) );
TBSMDFLQRBX1 CHAIN_RO23 ( .H01(Shift_RO[22]), .H04(Shift_RO[22]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[23]) );
TBSMDFLQRBX1 CHAIN_RO24 ( .H01(Shift_RO[23]), .H04(Shift_RO[23]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[24]) );
TBSMDFLQRBX1 CHAIN_RO25 ( .H01(Shift_RO[24]), .H04(Shift_RO[24]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[25]) );
TBSMDFLQRBX1 CHAIN_RO26 ( .H01(Shift_RO[25]), .H04(Shift_RO[25]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[26]) );
TBSMDFLQRBX1 CHAIN_RO27 ( .H01(Shift_RO[26]), .H04(Shift_RO[26]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[27]) );
TBSMDFLQRBX1 CHAIN_RO28 ( .H01(Shift_RO[27]), .H04(Shift_RO[27]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[28]) );
TBSMDFLQRBX1 CHAIN_RO29 ( .H01(Shift_RO[28]), .H04(Shift_RO[28]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[29]) );
TBSMDFLQRBX1 CHAIN_RO30 ( .H01(Shift_RO[29]), .H04(Shift_RO[29]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[30]) );
TBSMDFLQRBX1 CHAIN_RO31 ( .H01(Shift_RO[30]), .H04(Shift_RO[30]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[31]) );
TBSMDFLQRBX1 CHAIN_RO32 ( .H01(Shift_RO[31]), .H04(Shift_RO[31]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[32]) );
TBSMDFLQRBX1 CHAIN_RO33 ( .H01(Shift_RO[32]), .H04(Shift_RO[32]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[33]) );
TBSMDFLQRBX1 CHAIN_RO34 ( .H01(Shift_RO[33]), .H04(Shift_RO[33]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[34]) );
TBSMDFLQRBX1 CHAIN_RO35 ( .H01(Shift_RO[34]), .H04(Shift_RO[34]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[35]) );
TBSMDFLQRBX1 CHAIN_RO36 ( .H01(Shift_RO[35]), .H04(Shift_RO[35]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[36]) );
TBSMDFLQRBX1 CHAIN_RO37 ( .H01(Shift_RO[36]), .H04(Shift_RO[36]), .H02(CLK), .H03(_VBRESZ), .H05(FLSCAN), .N01(Shift_RO[37]) );

/*-----FLASH Function-----*/ 
//-----MODE Create ### For CodeFlash
always @ (_DIS or _WWR or _MSWR or _SER or _CER or _EXER or
          _MRG00 or _MRG01 or _MRG10 or _MRG11 or _MRG12 or _READ or _IONCHK1 or
          _CPBT or _WDT1 or _WDT2 or _WDT3 or _WDT4 or _RDT or
          _RDMRG0 or _RDMRG1 or _RDMRGC or _STCHK or _CLKSEL1 or
          _EXTVPP1 or _EXTVPP2 or _CPT or _IREFT or _CWEE or
          _WED or _SCANMODE or _TESDBT or intce or pow_sig or _VBRESZCP) begin  // 100709  // v1.03_Modify
//### XZ Check
  if (EWR_act===1'b1 || BTmode_act===1'b1) QNS_MODE_XZ_CHK;

//### DIS  v1.01_modify
  if ((_DIS===1'b1 || (_WED===1'b1 &&
      (|{_WWR,_MSWR,_SER,_CER,_EXER,_CPBT,_WDT1,_WDT2,_WDT3,_WDT4,_RDT}===1'b1)) ||
      ({_WWR,_MSWR,_SER,_CER,_EXER,
        _MRG00,_MRG01,_MRG10,_MRG11,_MRG12,_READ,_IONCHK1,
        _CPBT,_WDT1,_WDT2,_WDT3,_WDT4,_RDT,_RDMRG0,_RDMRG1,_RDMRGC,_STCHK}===22'h0) ||
      ({intce,_MRG00,_MRG01,_MRG10,_MRG11,_MRG12,_READ,_CPBT,_WDT4,_RDT,_RDMRG0,_RDMRG1}===12'h0) ||
       (_SCANMODE===1'b1 && _TESDBT===1'b0) || _VBRESZCP===1'b0) &&
       ~(_SCANMODE===1'b1 && _TESDBT===1'b1)) IDIS=1'b1;
  else IDIS=1'b0;

//### MODE
  MODE = {IDIS,_WWR,_MSWR,_SER,_CER,_EXER,
        _MRG00,_MRG01,_MRG10,_MRG11,_MRG12,_READ,_IONCHK1,
        _CPBT,_WDT1,_WDT2,_WDT3,_WDT4,_RDT,_RDMRG0,_RDMRG1,_RDMRGC,_STCHK};
  MODE_IV = {IDIS,_MRG00,_MRG01,_MRG10,_MRG11,_MRG12};
  MODE2 = {_EXTVPP1,_EXTVPP2,_CPT,_IREFT,_CWEE};

//### MODE Set Check
  if ((EWR_act===1'b1) && IDIS!==1'b1) QNS_MODE_SET_CHK;  // v1.01_modify

//### MODE_FLAG
  if (IDIS!==1'b1 && MODE===M_READ && _CLKSEL1===1'b1 && _SCANMODE===1'b0 &&
     (MODE2===M_INTVPP || MODE2===M_INT_CWEE || MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE ||
      MODE2===M_CPT || MODE2===M_CPT_CWEE || MODE2===M_IREFT || MODE2===M_IRE_CWEE)) CIBRead_act=1'b1;
  else CIBRead_act=1'b0;
  if (IDIS!==1'b1 && MODE===M_READ && _CLKSEL1===1'b0 && _SCANMODE===1'b0 &&
     (MODE2===M_INTVPP || MODE2===M_INT_CWEE || MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE ||
      MODE2===M_CPT || MODE2===M_CPT_CWEE || MODE2===M_IREFT || MODE2===M_IRE_CWEE)) FCBRead_act=1'b1;
  else FCBRead_act=1'b0;
  if ((IDIS!==1'b1 && _CLKSEL1===1'b0 && _SCANMODE===1'b0 && (((MODE===M_CER || MODE===M_SER || MODE===M_EXER) &&
     (MODE2===M_INT_CWEE || MODE2===M_EX1_CWEE || MODE2===M_CPT_CWEE || MODE2===M_CPT_EX1C))
      )) && pow_sig===1'b1) ER_act=1'b1;
  else ER_act=1'b0;
  if ((IDIS!==1'b1 && _CLKSEL1===1'b0 && _SCANMODE===1'b0 && (MODE===M_WWR || MODE===M_MSWR) &&
     (MODE2===M_INT_CWEE || MODE2===M_EX1_CWEE || MODE2===M_EX2_CWEE ||
      MODE2===M_CPT_CWEE || MODE2===M_CPT_EX1C || MODE2===M_CPT_EX2C || MODE2===M_IRE_CWEE)) && pow_sig===1'b1) WR_act=1'b1;
  else WR_act=1'b0;
  if (IDIS!==1'b1 && _SCANMODE===1'b0 && (MODE===M_MRG00 || MODE===M_MRG01 || MODE===M_MRG10 ||
      MODE===M_MRG11 || MODE===M_MRG12) &&
      (MODE2===M_INT_CWEE || MODE2===M_EX1_CWEE || MODE2===M_CPT_CWEE || MODE2===M_IRE_CWEE)) MRG_act=1'b1;
  else MRG_act=1'b0;
  //if (IDIS!==1'b1 && _SCANMODE===1'b0 && (MODE===M_MRG00 || MODE===M_MRG01 || MODE===M_MRG10 ||
  //    MODE===M_MRG11 || MODE===M_MRG12)  &&
  //    (MODE2===M_INT_CWEE || MODE2===M_EX1_CWEE || MODE2===M_CPT_CWEE || MODE2===M_IRE_CWEE)) INTVE_act=1'b1;
  //else INTVE_act=1'b0;
  if (IDIS!==1'b1 && _SCANMODE===1'b0 && MODE===M_IONCHK1 &&
     (MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE || MODE2===M_EXTVPP2 || MODE2===M_EX2_CWEE ||
      MODE2===M_CPT_CWEE)) ION_act=1'b1;
  else ION_act=1'b0;
  if (((IDIS!==1'b1 && _SCANMODE===1'b0 && (MODE===M_WDT1 || MODE===M_WDT2) &&
      (MODE2===M_INT_CWEE || MODE2===M_EX1_CWEE || MODE2===M_EX2_CWEE || MODE2===M_CPT_CWEE || MODE2===M_CPT_EX1C || MODE2===M_CPT_EX2C)) ||
      (IDIS!==1'b1 && _SCANMODE===1'b0 && (MODE===M_WDT3 || MODE===M_WDT4) &&
      (MODE2===M_INT_CWEE || MODE2===M_EX1_CWEE || MODE2===M_CPT_CWEE || MODE2===M_CPT_EX1C || MODE2===M_CPT_EX2C))) && pow_sig===1'b1) WDT_act=1'b1;
  else WDT_act=1'b0;
  if ((IDIS!==1'b1 && _SCANMODE===1'b0 && MODE===M_RDT &&
     (MODE2===M_EX1_CWEE || MODE2===M_CPT || MODE2===M_CPT_CWEE)) && pow_sig===1'b1) RDT_act=1'b1;
  else RDT_act=1'b0;
  if (IDIS!==1'b1 && _SCANMODE===1'b0 && MODE===M_STCHK &&
     (MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE || MODE2===M_CPT || MODE2===M_CPT_CWEE ||
      MODE2===M_IREFT || MODE2===M_IRE_CWEE)) ST_act=1'b1;
  else ST_act=1'b0;
  if ((IDIS!==1'b1 && _SCANMODE===1'b0 && (MODE===M_RDMRG0 || MODE===M_RDMRG1) &&
      (MODE2===M_INTVPP || MODE2===M_INT_CWEE || MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE ||
       MODE2===M_CPT || MODE2===M_CPT_CWEE || MODE2===M_IREFT || MODE2===M_IRE_CWEE)) ||
      (IDIS!==1'b1 && _SCANMODE===1'b0 && MODE===M_RDMRGC &&
      (MODE2===M_EXTVPP1 || MODE2===M_EX1_CWEE ||MODE2===M_EXTVPP2 || MODE2===M_EX2_CWEE ||
       MODE2===M_CPT || MODE2===M_CPT_CWEE))) RDMRG_act=1'b1;
  else RDMRG_act=1'b0;
  if ((IDIS!==1'b1 && _SCANMODE===1'b0 && MODE===M_CPBT &&
      (MODE2===M_INT_CWEE || MODE2===M_EX1_CWEE || MODE2===M_CPT_CWEE || MODE2===M_CPT_EX1C)) && pow_sig===1'b1) CPBT_act=1'b1;
  else CPBT_act=1'b0;

  if (pre_MODE===M_DIS && MODE!==pre_MODE) ROX_prevDIS_flag=1'b1;

//### Control Signal Check
  if (pre_MODE!==MODE && IDIS===1'b0 && _TRMRD1===1'b0 && _TRMRD2===1'b0 && EWR_act===1'b1 &&  // v1.01_modify
      (MODE2===M_EXTVPP2 || MODE2===M_EX2_CWEE))begin
    `ifdef NECLIB_ERRMSG_ONLY
    // NO Message
    `else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is EXTVPP2-Mode.");
    `endif
  end
  else
    QNS_MODESET_SIG_CHK;

//### Internal Verify tMS Check
  if (EWR_act===1'b1 && pre_MODE!==MODE && IDIS===1'b0 && _TRMRD1===1'b0 && _TRMRD2===1'b0) QNS_IV_TMS_CTRL;  // v1.01_modify

  pre_MODE=MODE;
  pre_MODE_IV=MODE_IV;
  pre_MODE2=MODE2;
end

//-----RDCLKC1 Func
always @ ( _RDCLKC1 ) begin
  RDCLKC1L = _RDCLKC1;  // For RDCLK 0 timing
  if (_RDCLKC1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)RDCLKC1' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if ( EWR_act===1'b1 ) begin
    if (_RDCLKC1===1'bx) begin
      XZ_sig = "(D)RDCLKC1";
      QNS_XZ_INPUT_pri;
    end
    else if (pow_sig!==1'b1)begin
    QNS_ROX_DIRECT;
    end
    else if (_CLKSEL1===1'b1 && _RDCLKC1===1'b1 && pre_RDCLKC1!==1'bx) begin
      QNS_LATCH;
      QNS_RDCTRL_LATCH;
      QNS_RDCTRL_C1_CHK;
      QNS_LATSIG_XZ_CHK;
      // if (ROX_prevDIS_flag===1'b1) ROX_prevDIS_flag=1'b0;
      if ((MODE===M_RDMRGC || MODE===M_IONCHK1) && intexa!==prevEXA) QNS_EXA_CHK_pri;
      if ((MODE===M_RDMRGC || MODE===M_STCHK || MODE===M_IONCHK1) && intce!==prevCE) QNS_CE_CHK_pri;
    end
    else if (_CLKSEL1===1'b1 && _RDCLKC1===1'b0 && pre_RDCLKC1!==1'bx && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
      QNS_RDCTRL_LATCH;
      QNS_RDCTRL_C1_CHK;
      QNS_RDCTRL_SETUP (intrdctrl_com,prevRDCTRL_COM);
      QNS_READ_FUNC (intrdctrl_c1);
      QNS_LATCH;  //v2.00
      QNS_LATSIG_XZ_CHK;  //v2.00
// v2.00 add
      if ((MODE===M_RDMRGC || MODE===M_IONCHK1) && intexa!==prevEXA) QNS_EXA_CHK_pri;
      if ((MODE===M_RDMRGC || MODE===M_STCHK || MODE===M_IONCHK1) && intce!==prevCE) QNS_CE_CHK_pri;
// v2.00 add end
      QNS_TohFunction;
      if (ROX_flag===1'b1) ROX_flag=1'b0;  // RO=X RESET
    end
  end
  else if (BTmode_act===1'b1) begin
    if (_RDCLKC1===1'bx) begin
      XZ_sig = "(D)RDCLKC1";
      QNS_XZ_INPUT_pri;
    end
    else if (pow_sig!==1'b1)begin
    QNS_ROX_DIRECT;
    end
    else if (_RDCLKC1===1'b1 && pre_RDCLKC1!==1'bx) begin
      QNS_LATCH;
      QNS_RDCTRL_LATCH;
      QNS_LATSIG_XZ_CHK;
      // if (ROX_prevDIS_flag===1'b1) ROX_prevDIS_flag=1'b0;
    end
    else if (_RDCLKC1===1'b0 && pre_RDCLKC1!==1'bx) begin
      QNS_RDCTRL_LATCH;
      QNS_BT_FUNC;
      QNS_LATCH;  //v2.00
      QNS_LATSIG_XZ_CHK;  //v2.00
      QNS_TohFunction;
    end
  end
  pre_RDCLKC1=_RDCLKC1;
end

//-----RDCLKP1 Func
always @ ( _RDCLKP1 ) begin
  RDCLKP1L = _RDCLKP1;  // For RDCLK 0 timing
  if (_RDCLKP1!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'RDCLKP1' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if ( EWR_act===1'b1 || BTmode_act===1'b1 ) begin
    if (_RDCLKP1===1'bx) begin
      XZ_sig = "RDCLKP1";
      QNS_XZ_INPUT_pri;
    end
  end
  if ( EWR_act===1'b1 ) begin
    if (pow_sig!==1'b1)begin
    QNS_ROX_DIRECT;
    end
    else if (_CLKSEL1===1'b0 && _RDCLKP1===1'b1 && pre_RDCLKP1!==1'bx) begin
      QNS_LATCH;
      QNS_LATSIG_XZ_CHK;
      // if (ROX_prevDIS_flag===1'b1) ROX_prevDIS_flag=1'b0;
      if ((MODE===M_RDMRGC || MODE===M_IONCHK1) && intexa!==prevEXA) QNS_EXA_CHK_pri;
      if ((MODE===M_RDMRGC || MODE===M_STCHK || MODE===M_IONCHK1) && intce!==prevCE) QNS_CE_CHK_pri;
      if (IDIS===1'b0 && WR_act===1'b1 && _PROGI===1'b1 && (_FCLK1===1'b1 || _FCLK2===1'b1) && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
        VIOLATE_sig3="(D)RDCLKP1";
        QNS_SIG_CHK_pri (VIOLATE_sig3);
      end
      if (($time > 0) && WR_act===1'b1 && IDIS!==1'b1 && (inta[AD_TOP:SECAD_BOTTOM]!==prevA[AD_TOP:SECAD_BOTTOM] ||
                                                                                   intbfa!==prevBFA || intexa!==prevEXA)) begin
`ifdef QNSA_ALL_NO_CHECK
        // NO Check
`else
        $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : 'A(Sector)orBFAorEXA' cannot change except DIS operation.");
        Error_flag_XWR=1'b1;
`endif
      end
    end
    else if (_CLKSEL1===1'b0 && _RDCLKP1===1'b0 && pre_RDCLKP1!==1'bx && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
      QNS_RDCTRL_LATCH;
      QNS_RDCTRL_SETUP (intrdctrl_com,prevRDCTRL_COM);
      QNS_READ_FUNC (intrdctrl_p1);
      QNS_LATCH;  //v2.00
      QNS_LATSIG_XZ_CHK;  //v2.00
// v2.00 add
      if ((MODE===M_RDMRGC || MODE===M_IONCHK1) && intexa!==prevEXA) QNS_EXA_CHK_pri;
      if ((MODE===M_RDMRGC || MODE===M_STCHK || MODE===M_IONCHK1) && intce!==prevCE) QNS_CE_CHK_pri;
      if (($time > 0) && WR_act===1'b1 && IDIS!==1'b1 && (inta[AD_TOP:SECAD_BOTTOM]!==prevA[AD_TOP:SECAD_BOTTOM] ||
                                                                                   intbfa!==prevBFA || intexa!==prevEXA)) begin
`ifdef QNSA_ALL_NO_CHECK
        // NO Check
`else
        $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : 'A(Sector)orBFAorEXA' cannot change except DIS operation.");
        Error_flag_XWR=1'b1;
`endif
      end
// v2.00 add end
      QNS_TohFunction;
      if (ROX_flag===1'b1) ROX_flag=1'b0;  // RO=X RESET
      if (IDIS===1'b0 && (ER_act===1'b1 || (WDT_act===1'b1 && MODE!==M_WDT4)) && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
        VIOLATE_sig3="(D)RDCLKP1";
        QNS_SIG_CHK_pri (VIOLATE_sig3);
      end
    end
  end
  pre_RDCLKP1=_RDCLKP1;
end

//-----VBRESZ Func
always @ ( _VBRESZ ) begin
  if (_VBRESZ===1'b0) begin
    QNS_ROX_DIRECT;
    QNS_LATCH_RESET;
    RESETCHK_act = 0;  // RESET CHECK RESET
  end
  else if (_VBRESZ===1'bx) begin
    XZ_sig = "VBRESZ";
    QNS_XZ_INPUT_pri;
  end
  else if (_VBRESZ===1'b1) begin  // v1.01_modify
    if (_TESDBT!==1'b1) begin  // v1.02_modify
      TMS_BT_flag=1'b0;
      ROX_prevDIS_flag=1'b0;
    end
    TSTOPtoHS_flag=1'b0;
    TSTOPtoLS_flag=1'b0;
    TSTOPtoLV_flag=1'b0;
    TSTOPtoLP_flag=1'b0;
    TMS_DIStoHS_flag=1'b0;
    TMS_DIStoLS_flag=1'b0;
    TMS_DIStoLV_flag=1'b0;
    TMS_DIStoLP_flag=1'b0;
    TMS_DIStoER_flag=1'b0;
    TMS_DIStoRDM_flag=1'b0;
    TMS_DIStoRDMC_flag=1'b0;
    TMS_DIStoION_flag=1'b0;
    TMS_DIStoST_flag=1'b0;
    TMS_TRMRD2toLV_flag=1'b0;
    TMS_MRG1_flag=1'b0;
    TMS_MRG2_flag=1'b0;
    TMS_MRG3_flag=1'b0;
    TLSPYS_flag=1'b0;
    THISPEEDS_flag=1'b0;
    TLOWPOWERS_flag=1'b0;
    TLOWSPEEDS_flag=1'b0;


    Error_flag_RD=1'b0;
    Error_flag=1'b0;
    Error_flag_XZ=1'b0;
    Error_flag_XWR=1'b0;
    ROX_flag=1'b0;
    STOP_release_flag=1'b0;

    EdgeLCount = 0;   //For Specify
    SUBRDCLK = 1'b0;  //For Specify
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

//-----FCLK1/2 Func
always @ ( _FCLK1 ) begin
  if (_FCLK1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'FCLK1' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if ((EWR_act===1'b1 || BTmode_act===1'b1) && _FCLK1===1'bx) begin
    XZ_sig = "FCLK1";
    QNS_XZ_INPUT_pri;
  end
  else if ((EWR_act===1'b1) && _FCLK1!==1'bx && IDIS===1'b0 && _TRMRD1===1'b0 && _TRMRD2===1'b0 &&  // v1.01_modify
            |{MRG_act,ION_act,CPBT_act,ST_act,RDMRG_act}===1'b1) begin
      VIOLATE_sig3="FCLK1";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
  end
  if ( EWR_act===1'b1 ) begin
    if (_CLKSEL1===1'b0 && _RDCLKP1===1'b1) begin
      case ({pre_FCLK1,_FCLK1,WR_act,ER_act})
        4'b0110 : begin    // Write
          if (_MSWR===1'b1 && _MEOC===1'b1 && _EXTVPP1!==1'b1) begin
            // _EXTVPP1 must be High
          end
          else QNS_WR1_FUNC;
        end
        4'b0101 : begin    // Erase
         if (intce===1'b1) FCLK1posetime = $time;
          if (_EXER===1'b1 && _MEOR===1'b1 && _EXTVPP1!==1'b1) begin
            // _EXTVPP1 must be High
          end
          else QNS_ER_FUNC;
          tmp_secdec=all_X;
        end
        4'b1001 : begin    // Erase
          if (intce===1'b1) begin
            FCLK1negetime = $time;
`ifdef QNSA_ALL_NO_CHECK
            // NO Check
`else
            if ((FCLK1negetime > FCLK1posetime) && ($time > 0) && ((FCLK1negetime - FCLK1posetime) < TPE_TYP)) begin
              $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of FCLK1 width.");
            end
`endif
          end
        end
        default : ;
      endcase
    end
  end
  pre_FCLK1=_FCLK1;
end

always @ ( _FCLK2 ) begin
  if (_FCLK2!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'FCLK2' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if ((EWR_act===1'b1 || BTmode_act===1'b1) && _FCLK2===1'bx) begin
    XZ_sig = "FCLK2";
    QNS_XZ_INPUT_pri;
  end
  else if ((EWR_act===1'b1) && _FCLK2!==1'bx && IDIS===1'b0 && _TRMRD1===1'b0 && _TRMRD2===1'b0 &&  // v1.01_modify
            |{ER_act,MRG_act,ION_act,CPBT_act,RDT_act,ST_act,RDMRG_act}===1'b1) begin
      VIOLATE_sig3="FCLK2";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
  end
  if ( EWR_act===1'b1) begin
    if (_CLKSEL1===1'b0 && _RDCLKP1===1'b1) begin
      case ({pre_FCLK2,_FCLK2,WR_act,ER_act})
        4'b0110 : begin    // Write
          if (_MSWR===1'b1 && _MEOC===1'b1 && _EXTVPP1!==1'b1) begin
            // _EXTVPP1 must be High
          end
          else QNS_WR2_FUNC;
        end
        default : ;
      endcase
    end
  end
  pre_FCLK2=_FCLK2;
end

//-----FLSTOP Func
always @ ( _FLSTOP ) begin
  if ((EWR_act===1'b1 || BTmode_act===1'b1) && _FLSTOP===1'bx) begin
    XZ_sig = "(D)FLSTOP";
    QNS_XZ_INPUT_pri;
  end
  else if (EWR_act===1'b1 && BTmode_act!==1'b1) begin
    if (pre_FLSTOP!==1'bx && _FLSTOP===1'b1 && _TRMRD2===1'b0 && _TRMRD1===1'b0) begin
      if (((_CLKSEL1===1'b1 && _RDCLKC1!==1'bx) || (_CLKSEL1===1'b0 && _RDCLKP1!==1'bx)) && intce===1'b0) begin  //v2.00
        // ReadDataHold
      end
      else tmp_RO_toh=all_X;

      QNS_FLSTOP_Disable;
    end
    else if (pre_FLSTOP!==1'bx && _FLSTOP===1'b0 && _TRMRD2===1'b0 && _TRMRD1===1'b0) begin
      if (_CLKSEL1===1'b1) QNS_TSTOP_CTRL (intrdctrl_c1);
      else if (_CLKSEL1===1'b0) QNS_TSTOP_CTRL (intrdctrl_p1);
    end
    if (pre_FLSTOP!==1'bx && _FLSTOP===1'b1) STOP_release_flag=1'b0;
    else if (pre_FLSTOP!==1'bx && _FLSTOP===1'b0) STOP_release_flag=1'b1;

    QNS_TohFunction;
  end
  pre_FLSTOP = _FLSTOP;
end

//-----PROGI Func
always @ ( _PROGI ) begin
  if (_PROGI!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'PROGI' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if ((EWR_act===1'b1 || BTmode_act===1'b1) && _PROGI===1'bx) begin
    XZ_sig = "PROGI";
    QNS_XZ_INPUT_pri;
  end
  else if (EWR_act===1'b1 && BTmode_act!==1'b1) begin
    if (progi_cnt===1'bx) progi_cnt=0;
    #0;  // For Racing
    if (|({WR_act,WDT_act})===1'b1) begin
      case ({pre_PROGI,_PROGI})
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
    if (_PROGI!==1'bx && EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0 && IDIS===1'b0 &&
      (((WR_act===1'b1 || WDT_act===1'b1) && (_FCLK1===1'b1 || _FCLK2===1'b1)) ||
         |{MRG_act,ER_act,ION_act,ST_act,RDMRG_act,CPBT_act}===1'b1)) begin
      VIOLATE_sig3="PROGI";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
  end
  pre_PROGI=_PROGI;
end

//-----HISPEED Func
always @ ( _HISPEED ) begin
  intrdctrl_p1[3] = _HISPEED;
  if (_HISPEED!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'HISPEED' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_HISPEED===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "HISPEED";
    QNS_XZ_INPUT_pri;
  end
  else if (_TRMRD2===1'b0 && _TRMRD1===1'b0 && EWR_act===1'b1 &&
          ((_CLKSEL1===1'b1 && _RDCLKC1===1'b0) || (_CLKSEL1===1'b0 && _RDCLKP1===1'b0)) && MODE===M_READ && intce===1'b1) begin
    VIOLATE_sig = "HISPEED";
    QNS_RDCTRL_CHK;
    QNS_ROX_DIRECT;
  end
  if (_TRMRD2===1'b0 && _TRMRD1===1'b0 && EWR_act===1'b1) begin
    if (_CLKSEL1===1'b0) QNS_RDCTRL_P1_CHK;
    if (_CLKSEL1===1'b0 && intce===1'b1 && pre_HISPEED!==_HISPEED) QNS_ROX_DIRECT;
    else if (_CLKSEL1===1'b1 && intce===1'b1 && pre_HISPEED!==_HISPEED) ROX_flag=1'b1;
  end
  pre_HISPEED = _HISPEED;
end

//-----LOWPOWER Func
always @ ( _LOWPOWER ) begin
  intrdctrl_p1[2] = _LOWPOWER;
  if (_LOWPOWER!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'LOWPOWER' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_LOWPOWER===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "LOWPOWER";
    QNS_XZ_INPUT_pri;
  end
  else if (_TRMRD2===1'b0 && _TRMRD1===1'b0 && EWR_act===1'b1 &&
          ((_CLKSEL1===1'b1 && _RDCLKC1===1'b0) || (_CLKSEL1===1'b0 && _RDCLKP1===1'b0)) && MODE===M_READ && intce===1'b1) begin
    VIOLATE_sig = "LOWPOWER";
    QNS_RDCTRL_CHK;
    QNS_ROX_DIRECT;
  end
  if (_TRMRD2===1'b0 && _TRMRD1===1'b0 && EWR_act===1'b1) begin
    if (_CLKSEL1===1'b0) QNS_RDCTRL_P1_CHK;
    if (_CLKSEL1===1'b0 && intce===1'b1 && pre_LOWPOWER!==_LOWPOWER) QNS_ROX_DIRECT;
    else if (_CLKSEL1===1'b1 && intce===1'b1 && pre_LOWPOWER!==_LOWPOWER) ROX_flag=1'b1;
  end
  pre_LOWPOWER = _LOWPOWER;
end

//-----RLOWSPY Func
always @ ( _RLOWSPY ) begin
  intrdctrl_p1[1] = _RLOWSPY;
  if (_RLOWSPY!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'RLOWSPY' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_RLOWSPY===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RLOWSPY";
    QNS_XZ_INPUT_pri;
  end
  else if (_TRMRD2===1'b0 && _TRMRD1===1'b0 && EWR_act===1'b1 &&
          ((_CLKSEL1===1'b1 && _RDCLKC1===1'b0) || (_CLKSEL1===1'b0 && _RDCLKP1===1'b0)) && MODE===M_READ && intce===1'b1) begin
    VIOLATE_sig = "RLOWSPY";
    QNS_RDCTRL_CHK;
    QNS_ROX_DIRECT;
  end
  if (_TRMRD2===1'b0 && _TRMRD1===1'b0 && EWR_act===1'b1) begin
    if (_CLKSEL1===1'b0) QNS_RDCTRL_P1_CHK;
    if (_CLKSEL1===1'b0 && intce===1'b1 && pre_RLOWSPY!==_RLOWSPY) QNS_ROX_DIRECT;
    else if (_CLKSEL1===1'b1 && intce===1'b1 && pre_RLOWSPY!==_RLOWSPY) ROX_flag=1'b1;
  end
  pre_RLOWSPY = _RLOWSPY;
end

//-----SUB Func
always @ ( _SUB ) begin
  intrdctrl_p1[0] = _SUB;
  if (_SUB!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'SUB' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_SUB===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "SUB";
    QNS_XZ_INPUT_pri;
  end
  else if (_TRMRD2===1'b0 && _TRMRD1===1'b0 && EWR_act===1'b1 &&
          (_CLKSEL1===1'b1 && _RDCLKC1===1'b0) && MODE===M_READ && intce===1'b1) begin
    VIOLATE_sig = "SUB";
    QNS_RDCTRL_CHK;
    QNS_ROX_DIRECT;
  end
  if (_TRMRD2===1'b0 && _TRMRD1===1'b0 && EWR_act===1'b1) begin
    if (_CLKSEL1===1'b0 && intce===1'b1 && pre_SUB!==_SUB) QNS_ROX_DIRECT;
    // else if (_CLKSEL1===1'b1 && intce===1'b1 && pre_SUB!==_SUB) ROX_flag=1'b1;
  end
  pre_SUB = _SUB;
end

//-----DIS-Mode Func
always @ ( IDIS ) begin
  if (BTmode_act!==1'b1) begin
    if (IDIS!==1'bx && _TRMRD2===1'b0 && _TRMRD1===1'b0) QNS_ROX_DIRECT;
    if ( IDIS===1'b1 ) begin
      DISposetime = $time;
      PROGD=1'b0;
      progi_cnt=0;
      tmp_secdec=all_X;

      QNS_FLSTOP_Disable;
      disable ActSet_TMS_DIStoHS_chk;
      disable ActSet_TMS_DIStoLS_chk;
      disable ActSet_TMS_DIStoLV_chk;
      disable ActSet_TMS_DIStoLP_chk;
      disable ActSet_TMS_DIStoER_chk;
      disable ActSet_TMS_DIStoRDM_chk;
      disable ActSet_TMS_DIStoRDMC_chk;
      disable ActSet_TMS_DIStoION_chk;
      disable ActSet_TMS_DIStoST_chk;
      disable ActSet_TMS_BT_chk;
      disable ActSet_TMS_TRMRD2toLV_chk; 
      disable ActSet_TMS_MRG1_chk;
      disable ActSet_TMS_MRG2_chk;
      disable ActSet_TMS_MRG3_chk;

      TSTOPtoHS_flag=1'b0;
      TSTOPtoLS_flag=1'b0;
      TSTOPtoLV_flag=1'b0;
      TSTOPtoLP_flag=1'b0;
      TMS_DIStoHS_flag=1'b0;
      TMS_DIStoLS_flag=1'b0;
      TMS_DIStoLV_flag=1'b0;
      TMS_DIStoLP_flag=1'b0;
      TMS_DIStoER_flag=1'b0;
      TMS_DIStoRDM_flag=1'b0;
      TMS_DIStoRDMC_flag=1'b0;
      TMS_DIStoION_flag=1'b0;
      TMS_DIStoST_flag=1'b0;
      TMS_BT_flag=1'b0;
      TMS_TRMRD2toLV_flag=1'b0;
      TMS_MRG1_flag=1'b0;
      TMS_MRG2_flag=1'b0;
      TMS_MRG3_flag=1'b0;
      TLSPYS_flag=1'b0;
      THISPEEDS_flag=1'b0;
      TLOWPOWERS_flag=1'b0;
      TLOWSPEEDS_flag=1'b0;


      Error_flag_RD=1'b0;
      Error_flag=1'b0;
      Error_flag_XZ=1'b0;
      Error_flag_XWR=1'b0;
      ROX_flag=1'b0;
      ROX_prevDIS_flag=1'b0;

      STOP_release_flag=1'b0;

      EdgeLCount = 0;   //For Specify
      SUBRDCLK = 1'b0;  //For Specify

      FCLK1posetime = 0;
      FCLK1negetime = 0;

      pre_RLOWSPY_TDIS = _RLOWSPY;  // READ-mode Change Signal
    end
    else if ( IDIS===1'b0 ) begin
      DISnegetime = $time;
      
      if (intce===1'b1 && MODE===M_SER && {_SACEEN,_FCLK1,_MUTEST}===3'h5) QNS_DEC;  //SecDecOut
      else if (intce===1'b1 && MODE===M_CER && {_SACEEN,_FCLK1,_MUTEST,_R0FLAGZ}===4'h2) QNS_REDUN_DEC;  //RedunDecOut
      else tmp_secdec=all_X;
     
      if (_CLKSEL1===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0) QNS_TMS_CTRL (intrdctrl_c1);
      else if (_CLKSEL1===1'b0 && _TRMRD1===1'b0 && _TRMRD2===1'b0) QNS_TMS_CTRL (intrdctrl_p1);

      if (EWR_act===1'b1 && RESETCHK_act===1'b0 && _TRMRD1===1'b0 && _TRMRD2===1'b0) QNS_TDIS_CHK;  // v1.03_Modify
      pre_MODE_TDIS = MODE;
      pre_CE_TDIS1 = intce;
                             //delete v2.00
      pre_BEU_TDIS = intbeu;
      pre_LOWSPY_TDIS = _LOWSPY;
    end
  end
  pre_IDIS = IDIS;
end

//-----Triming Code Read 1
assign trmrd1_1 = memEX[768];
assign trmrd1_2 = memEX[769];
assign trmrd1_3 = memEX[770];
assign trmrd1_4 = memEX[771];
assign trmrd2_1 = memEX[772];
assign trmrd2_2 = memEX[773];
assign trmrd2_3 = memEX[774];
assign trmrd2_4 = memEX[775];

always @ ( posedge _TRMRD1 ) begin : TrimingCodeREAD1_pos
//  if (_TRMRD1===1'bx) begin
//    XZ_sig = "TRMRD1";
//    // QNS_XZ_INPUT_pri;
//`ifdef QNSA_ALL_NO_CHECK
//// NO Check
//`else 
//    if ($time > 0) $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of XZ input %0s signal.",XZ_sig);
//`endif 
//  end
//  else if (_TRMRD1===1'b1) begin
  if (_TRMRD1===1'b1) begin
    tmp_RO = all_X;
    #(TOD_TRMRD1);
    if ((trmrd1_1[10:0] === trmrd1_2[10:0]) && (trmrd1_1[10:0] === trmrd1_3[10:0]) && (trmrd1_1[10:0] === trmrd1_4[10:0])) begin
       tmp_RO_toh = {{(IOBIT-11){1'bx}},trmrd1_1[10:0]};
    end
    else begin
      tmp_RO_toh = all_X;
    end
      tmp_RO=tmp_RO_toh;
  end
end

always @ ( negedge _TRMRD1 ) begin : TrimingCodeREAD1_neg
//  if (_TRMRD1===1'bx) begin
//    XZ_sig = "TRMRD1";
//    // QNS_XZ_INPUT_pri;
//`ifdef QNSA_ALL_NO_CHECK
//// NO Check
//`else
//    if ($time > 0) $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of XZ input %0s signal.",XZ_sig);
//`endif
//  end
//  else if (_TRMRD1===1'b0) begin
  if (_TRMRD1===1'b0) begin
    disable TrimingCodeREAD1_pos;
    tmp_RO_toh = all_X;
    tmp_RO=all_X;
  end
end

//-----Triming Code Read 2
always @ ( posedge _TRMRD2 ) begin : TrimingCodeREAD2_pos
//  if (_TRMRD2===1'bx) begin
//    XZ_sig = "TRMRD2";
//    // QNS_XZ_INPUT_pri;
//`ifdef QNSA_ALL_NO_CHECK
//// NO Check
//`else
//    if ($time > 0) $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of XZ input %0s signal.",XZ_sig);
//`endif
//  end
  if (EWR_act===1'b1 && MCELL_act===1'b1) begin
    if (_TRMRD2===1'b1) begin
      disable TrimingCodeREAD1_pos;
      tmp_RO = all_X;
      #(TOD_TRMRD2);
      if ((trmrd2_1[7:0] === trmrd2_2[7:0]) && (trmrd2_1[7:0] === trmrd2_3[7:0]) && (trmrd2_1[7:0] === trmrd2_4[7:0])) begin
        tmp_RO_toh = {{(IOBIT-8){1'bx}},trmrd2_1[7:0]};
      end
      else begin
        tmp_RO_toh = all_X;
      end
        tmp_RO=tmp_RO_toh;
    end
  end
  else if (($time > 0) && _TRMRD2===1'b1 && _VBRESZ===1'b0 && _SCANMODE===1'b0) begin  //v2.00
`ifdef QNSA_ALL_NO_CHECK
//  NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : VBRESZ=H is necessary for the TRMRD2-Mode.");
`endif
  end
end

always @ ( negedge _TRMRD2 ) begin : TrimingCodeREAD2_neg
//  if (_TRMRD2===1'bx) begin
//    XZ_sig = "TRMRD2";
//    // QNS_XZ_INPUT_pri;
//`ifdef QNSA_ALL_NO_CHECK
//// NO Check
//`else
//    if ($time > 0) $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of XZ input %0s signal.",XZ_sig);
//`endif
//  end
  if (EWR_act===1'b1 && MCELL_act===1'b1) begin
    if (_TRMRD2===1'b0) begin
      prevRDCTRL_COM={_HISPEED,_LOWPOWER,_RLOWSPY,_SUB};
      intrdctrl_com={_HISPEED,_LOWPOWER,_RLOWSPY,_SUB};
      disable  TrimingCodeREAD2_pos;
      tmp_RO_toh = all_X;
      tmp_RO=all_X;

      disable ActSet_TMS_TRMRD2toLV_chk;
      TMS_TRMRD2toLV_flag=1'b1;
      -> ActSet_TMS_TRMRD2toLV;
    end
  end
end

//-----VBRESZCP Check
always @ ( _VBRESZCP ) begin
  if (_VBRESZCP===1'bx) begin
    XZ_sig = "VBRESZCP";
    QNS_XZ_INPUT_pri;
  end
end

//-----SCAN & BT Control
always @ ( _SCANMODE ) begin
  if (_SCANMODE!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'SCANMODE' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_SCANMODE===1'bx) begin
    XZ_sig = "SCANMODE";
    QNS_XZ_INPUT_pri;
  end
  else if (_SCANMODE===1'b1 && pre_SCANMODE!==1'bx && _TESDBT===1'b1) begin
    disable ActSet_TMS_BT_chk;
    ROX_prevDIS_flag=1'b1;
    TMS_BT_flag = 1'b1;
    ->ActSet_TMS_BT;
  end
  else if (_SCANMODE===1'b0 && pre_SCANMODE!==1'bx && _VBRESZ===1'b1) begin
    QNS_ROX_DIRECT;
  end
  pre_SCANMODE = _SCANMODE;
end

always @ ( _TESDBT ) begin
  if (_TESDBT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'TESDBT' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_TESDBT===1'bx) begin
    XZ_sig = "TESDBT";
    QNS_XZ_INPUT_pri;
  end
  else if (_TESDBT===1'b1 && pre_TESDBT!==1'bx && _SCANMODE===1'b1) begin
    disable ActSet_TMS_BT_chk;
    ROX_prevDIS_flag=1'b1;
    TMS_BT_flag = 1'b1;
    ->ActSet_TMS_BT;
  end
  else if (_TESDBT===1'b0 && pre_TESDBT!==1'bx && _VBRESZ===1'b1) begin
    QNS_ROX_DIRECT;
  end
  pre_TESDBT = _TESDBT;
end

//-----Other Signal Check
always @ ( _SRCUT ) begin
  if (_SRCUT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)SRCUT' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_SRCUT===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "(D)SRCUT";
    QNS_XZ_INPUT_pri;
  end
  else if (intce===1'b1 && _SRCUT!==1'bx && (CIBRead_act===1'b1 || FCBRead_act===1'b1) && EWR_act===1'b1) begin  //v2.00
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if ( $time > 0 ) $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : The change in the (D)SRCUT signal should be 'CE(DCE)=L'.");
`endif
  end
  else if (_SRCUT!==1'bx && EWR_act===1'b1 && IDIS===1'b0 &&
          {FCBRead_act,CIBRead_act,RDMRG_act,MRG_act,(WR_act===1'b0 && MODE!==M_WWR),
          (ER_act===1'b0 && MODE!==M_SER && MODE!==M_CER)}===6'b000011 &&
           _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig3="SRCUT";
    QNS_SIG_CHK_pri (VIOLATE_sig3);
  end
end

always @ ( _SRCUTCP ) begin
  if (_SRCUTCP===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "SRCUTCP"; 
    QNS_XZ_INPUT_pri;
  end
  else if (intce===1'b1 && _SRCUTCP!==1'bx && (CIBRead_act===1'b1 || FCBRead_act===1'b1) && EWR_act===1'b1) begin  //v2.00
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if ( $time > 0 ) $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : The change in the SRCUTCP signal should be 'CE(DCE)=L'.");  
`endif
  end
  else if (_SRCUTCP!==1'bx && EWR_act===1'b1 && IDIS===1'b0 && {FCBRead_act,CIBRead_act,RDMRG_act}===3'h0 &&
           _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig3="SRCUTCP";
    QNS_SIG_CHK_pri (VIOLATE_sig3);
  end
end 

always @ ( _CLKSEL1 ) begin
  if (_CLKSEL1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)CLKSEL1' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (EWR_act===1'b1 || BTmode_act===1'b1) begin
    if (_CLKSEL1===1'bx) begin
      XZ_sig = "(D)CLKSEL1";
      QNS_XZ_INPUT_pri;
    end
    else if (_CLKSEL1!==1'bx && (_RDCLKC1!==1'b1 || _RDCLKP1!==1'b1) && MODE===M_READ && EWR_act===1'b1) begin
      QNS_CLKSEL1_CHK1_pri;  // Message Only
    end
    else if (_CLKSEL1!==1'bx && (MODE!==M_READ && IDIS!==1'b1) && EWR_act===1'b1) begin
      #0;  // For Racing
      QNS_CLKSEL1_CHK2_pri;
      //100204 Error_flag=1'b1;
    end
  end
end

always @ ( _WED ) begin
  if (_WED!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)WED' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  if (_WED===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "(D)WED";
    QNS_XZ_INPUT_pri;
  end
  else if (_WED!==1'bx && EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0
             && _WED===1'b0 && (FCBRead_act===1'b1 || CIBRead_act===1'b1)) begin
    `ifdef NECLIB_ERRMSG_ONLY
    // NO Message
    `else
      if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : The (D)WED signal is desirable 'H' at READ.");
    `endif
  end
  else if (_WED!==1'bx && EWR_act===1'b1 && IDIS===1'b0 && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig3="(D)WED";
    QNS_SIG_CHK_pri (VIOLATE_sig3);
  end
end

always @ ( _MEOR ) begin
  if (_MEOR===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MEOR";
    QNS_XZ_INPUT_pri;
  end
  else if (_MEOR!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'MEOR' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_MEOR!==1'bx && EWR_act===1'b1 && IDIS===1'b0 && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig3="MEOR";
    QNS_SIG_CHK_pri (VIOLATE_sig3);
  end
end

always @ ( _MEOC ) begin
  if (_MEOR===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MEOC";
    QNS_XZ_INPUT_pri; 
  end
  else if (_MEOC!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'MEOC' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_MEOC!==1'bx && EWR_act===1'b1 && IDIS===1'b0 && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig3="MEOC";
    QNS_SIG_CHK_pri (VIOLATE_sig3);
  end
end

always @ ( _SACEEN ) begin
  if (_SACEEN===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "SACEEN";
    QNS_XZ_INPUT_pri;
  end
  else if (_SACEEN!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'SACEEN' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_SACEEN!==1'bx && EWR_act===1'b1 && IDIS===1'b0 && |{FCBRead_act,CIBRead_act,RDMRG_act}!==1'b1 &&
           _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig3="SACEEN";
    QNS_SIG_CHK_pri (VIOLATE_sig3);
  end
//  if (_SACEEN===1'b1) tmp_secdec=all_X;
end

always @ ( _MUTEST ) begin
  if (_MUTEST!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'MUTEST' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_MUTEST===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MUTEST";
    QNS_XZ_INPUT_pri; 
  end
  else if (_MUTEST!==1'bx && EWR_act===1'b1 && IDIS===1'b0 && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig3="MUTEST";
    QNS_SIG_CHK_pri (VIOLATE_sig3);
  end
  if (_MUTEST===1'b0) tmp_secdec=all_X;
end

always @ ( TRMCP ) begin
  for (xz_aa=10;xz_aa<=14;xz_aa=xz_aa+1) begin
    if (TRMCP[xz_aa]===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
      XZ_sig = "(D)TRMCP";
      QNS_XZ_INPUT_pri;
    end
  end
end

//v2.00
always @ ( TRMCP ) begin
  if (($time > 0)  && (EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0)
      && (TRMCP === TRMCP_NG1 || TRMCP === TRMCP_NG2 || TRMCP === TRMCP_NG3)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : cannot set TRMCP14-10 code 01101/01110/01111.");
`endif
  end
end

always @ ( _LOWSPY ) begin
  if (_LOWSPY!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'LOWSPY' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if (_LOWSPY===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "LOWSPY";
    QNS_XZ_INPUT_pri;
  end
  else if (_LOWSPY!==1'bx && EWR_act===1'b1 && IDIS===1'b0 && |{ION_act,RDMRG_act}===1'b1 &&

           _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig3="LOWSPY";
    QNS_SIG_CHK_pri (VIOLATE_sig3);
  end
  pre_LOWSPY = _LOWSPY;
end

always @ ( _SCANIN ) begin
  if (pre_SCANIN!==_SCANIN && EWR_act===1'b1 && IDIS!==1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
    if ($time > 0) $display ("HM Warning: ",$time," QNSA3N032K1V2 %m : Violation of SCANIN signal.");
`endif
  end
  pre_SCANIN = _SCANIN;
end

//## For Code-Flash Only
always @ ( _R0FLAGZ ) begin
  if (_R0FLAGZ===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "R0FLAGZ";
    QNS_XZ_INPUT_pri; 
  end
end

always @ ( R0A ) begin
  for (xz_bb=0;xz_bb<=4;xz_bb=xz_bb+1) begin
    if (R0A[xz_bb]===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
      XZ_sig = "R0A(RedunAddress)";
      QNS_XZ_INPUT_pri;
    end
  end
end

//## Analog Terminal between CP and MEMORY Check
always @ ( _VCPHV ) begin
  if (_VCPHV===1'bx) begin
    XZ_sig = "VCPHV";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _VREGMV ) begin
  if (_VREGMV===1'bx) begin
    XZ_sig = "VREGMV";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _VREGRMV ) begin
  if (_VREGRMV===1'bx) begin
    XZ_sig = "VREGRMV";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _HVPPTS1 ) begin
  if (_HVPPTS1===1'bx) begin
    XZ_sig = "HVPPTS1";
    QNS_XZ_INPUT_pri;
  end
end

always @ ( _VPBIAS ) begin
  if (_VPBIAS===1'bx) begin
    XZ_sig = "VPBIAS";
    QNS_XZ_INPUT_pri;
  end
end

//## Ax/CE/EXA/BFA Change Check
always @ ( RDCLKC1L ) begin  // For RDCLK 0 timing
  case ({pre_RDCLKC1L,RDCLKC1L})
    2'b01 : RDCLKC1L_flag = 1'b1;
    2'b10 : RDCLKC1L_flag = 1'b0;
    default : RDCLKC1L_flag = _RDCLKC1;
  endcase
  pre_RDCLKC1L = RDCLKC1L;
end

always @ ( RDCLKP1L ) begin  // For RDCLK 0 timing
  case ({pre_RDCLKP1L,RDCLKP1L})
    2'b01 : RDCLKP1L_flag = 1'b1;
    2'b10 : RDCLKP1L_flag = 1'b0;
    default : RDCLKP1L_flag = _RDCLKP1;
  endcase
  pre_RDCLKP1L = RDCLKP1L;
end

always @ ( A ) begin
//  if (A!=={(ADBIT){1'b0}} && RESETCHK_act===1'b1 && ($time > 0)) begin
//`ifdef QNSA_ALL_NO_CHECK
//    // NO Check
//`else
//    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)A' signal RESET logic.");
//    Error_flag_RST = 1'b1; // RO allX
//`endif
//  end
//  else
  if ((CIBRead_act===1'b1 || FCBRead_act===1'b1 || MRG_act===1'b1 || RDMRG_act===1'b1 || ION_act===1'b1 || ST_act===1'b1) && A!==pre_A &&
     ((_CLKSEL1===1'b1 && RDCLKC1L_flag===1'b0) || (_CLKSEL1===1'b0 && RDCLKP1L_flag===1'b0)) && _FLSTOP===1'b0 &&
       EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig2="(D)Ax";
    QNS_RDCLKL_CHK_pri;
  end
  pre_A = A;
end

always @ ( _CE ) begin
  if (_CE!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)CE' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if ((MODE===M_RDMRGC || MODE===M_STCHK || MODE===M_IONCHK1) && _CE!==pre_CE &&
        EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0) QNS_CE_CHK_pri;
  else if ((CIBRead_act===1'b1 || FCBRead_act===1'b1 || MRG_act===1'b1 || RDMRG_act===1'b1 || ION_act===1'b1 || ST_act===1'b1) && _CE!==pre_CE &&
     ((_CLKSEL1===1'b1 && RDCLKC1L_flag===1'b0) || (_CLKSEL1===1'b0 && RDCLKP1L_flag===1'b0)) && _FLSTOP===1'b0 &&
        EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig2="(D)CE";
    QNS_RDCLKL_CHK_pri;
  end
  pre_CE = _CE;
end

always @ ( _EXA ) begin
  if (_EXA!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'EXA' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if ((MODE===M_RDMRGC || MODE===M_IONCHK1) && _EXA!==pre_EXA &&
      ((_CLKSEL1===1'b1 && _RDCLKC1===1'b0) || (_CLKSEL1===1'b0 && _RDCLKP1===1'b0)) &&
        EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0) QNS_EXA_CHK_pri;
  else if ((CIBRead_act===1'b1 || FCBRead_act===1'b1 || MRG_act===1'b1 || RDMRG_act===1'b1 || ION_act===1'b1 || ST_act===1'b1) && _EXA!==pre_EXA &&
     ((_CLKSEL1===1'b1 && RDCLKC1L_flag===1'b0) || (_CLKSEL1===1'b0 && RDCLKP1L_flag===1'b0)) && _FLSTOP===1'b0 &&
        EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig2="EXA";
    QNS_RDCLKL_CHK_pri;
  end
  pre_EXA = _EXA;
end

always @ ( _BFA ) begin
  if (_BFA!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'BFA' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
  else if ((CIBRead_act===1'b1 || FCBRead_act===1'b1 || MRG_act===1'b1 || RDMRG_act===1'b1 || ION_act===1'b1 || ST_act===1'b1) && _BFA!==pre_BFA &&
     ((_CLKSEL1===1'b1 && RDCLKC1L_flag===1'b0) || (_CLKSEL1===1'b0 && RDCLKP1L_flag===1'b0)) && _FLSTOP===1'b0 &&
        EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    VIOLATE_sig2="BFA";
    QNS_RDCLKL_CHK_pri;
  end
  pre_BFA = _BFA;
end

//-----TSTOP/TMS Control
// FLSTOP=H -> L
always @ ( ActSet_TSTOPtoLV ) begin : ActSet_TSTOPtoLV_chk
  #(TCREGS+TSTOPtoLV) TSTOPtoLV_flag=1'b0;
end

always @ ( ActSet_TSTOPtoLS ) begin : ActSet_TSTOPtoLS_chk
  #(TCREGS+TSTOPtoLS) TSTOPtoLS_flag=1'b0;
end

always @ ( ActSet_TSTOPtoHS ) begin : ActSet_TSTOPtoHS_chk
  #(TCREGS+TSTOPtoHS) TSTOPtoHS_flag=1'b0;
end

always @ ( ActSet_TSTOPtoLP ) begin : ActSet_TSTOPtoLP_chk
  #(TCREGS+TSTOPtoLP) TSTOPtoLP_flag=1'b0;
end

// DIS -> READ tMS
always @ ( ActSet_TMS_DIStoLV ) begin : ActSet_TMS_DIStoLV_chk
  #TMS_DIStoLV TMS_DIStoLV_flag=1'b0;
end

always @ ( ActSet_TMS_DIStoLS ) begin : ActSet_TMS_DIStoLS_chk
  #TMS_DIStoLS TMS_DIStoLS_flag=1'b0;
end

always @ ( ActSet_TMS_DIStoHS ) begin : ActSet_TMS_DIStoHS_chk
  #TMS_DIStoHS TMS_DIStoHS_flag=1'b0;
end

always @ ( ActSet_TMS_DIStoLP ) begin : ActSet_TMS_DIStoLP_chk
  #TMS_DIStoLP TMS_DIStoLP_flag=1'b0;
end

// READ LV/HS/LP/LS Setup
always @ ( ActSet_TLSPYS ) begin : ActSet_TLSPYS_chk
  #(TLSPYS) TLSPYS_flag=1'b0;
end

always @ ( ActSet_TLOWPOWERS ) begin : ActSet_TLOWPOWERS_chk
  #(TLOWPOWERS) TLOWPOWERS_flag=1'b0;
end

always @ ( ActSet_THISPEEDS ) begin : ActSet_THISPEEDS_chk
  #(THISPEEDS) THISPEEDS_flag=1'b0;
end

always @ ( ActSet_TLOWSPEEDS ) begin : ActSet_TLOWSPEEDS_chk
  #(TLOWSPEEDS) TLOWSPEEDS_flag=1'b0;
end

// Other Mode tMS
always @ ( ActSet_TMS_DIStoER) begin : ActSet_TMS_DIStoER_chk
  #TMS_DIStoER TMS_DIStoER_flag=1'b0;
end

always @ ( ActSet_TMS_DIStoRDM) begin : ActSet_TMS_DIStoRDM_chk
  #TMS_DIStoRDM TMS_DIStoRDM_flag=1'b0;
end

always @ ( ActSet_TMS_DIStoRDMC) begin : ActSet_TMS_DIStoRDMC_chk
  #TMS_DIStoRDMC TMS_DIStoRDMC_flag=1'b0;
end

always @ ( ActSet_TMS_DIStoION) begin : ActSet_TMS_DIStoION_chk
  #TMS_DIStoION TMS_DIStoION_flag=1'b0;
end

always @ ( ActSet_TMS_DIStoST) begin : ActSet_TMS_DIStoST_chk
  #TMS_DIStoST TMS_DIStoST_flag=1'b0;
end

always @ ( ActSet_TMS_BT) begin : ActSet_TMS_BT_chk
  #TMS_BT TMS_BT_flag=1'b0;
end

always @ ( ActSet_TMS_TRMRD2toLV) begin : ActSet_TMS_TRMRD2toLV_chk
  #TLSPYS TMS_TRMRD2toLV_flag=1'b0;
end

always @ ( ActSet_TMS_MRG1) begin : ActSet_TMS_MRG1_chk
  #TMS_MRG1 TMS_MRG1_flag=1'b0;
end

always @ ( ActSet_TMS_MRG2) begin : ActSet_TMS_MRG2_chk
  #TMS_MRG2 TMS_MRG2_flag=1'b0;
end

always @ ( ActSet_TMS_MRG3) begin : ActSet_TMS_MRG3_chk
  #TMS_MRG3 TMS_MRG3_flag=1'b0;
end

/*-----Mode Change Check-----*/
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
always @( negedge MHIGH ) disable MODE_H_check;

always @( posedge MHIGH ) begin :MODE_H_check
  #(ModeChangeSpec);
  if (MHIGH === 1'b1 && EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : MODE & DIS timing over");
  end
end

// always @( negedge MLOW ) disable MODE_L_check;

// always @( posedge MLOW ) begin :MODE_L_Check
//   #(ModeChangeSpec);
//   if (MLOW === 1'b1 && EWR_act===1'b1 && _TRMRD1===1'b0 && _TRMRD2===1'b0) begin
//     $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : MODE & DIS timing over");
//   end
// end
`endif

/*-----RESET Logic Check-----*/
always @ (posedge _TRMRD1 or posedge _TRMRD2) begin  // v1.02_modify
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
  RESET_st = {_WWR,_MSWR,_CER,_SER,_EXER,_MRG00,_MRG01,_MRG10,_MRG11,_MRG12,
               _DIS,_READ,_IONCHK1,_STCHK,_CPBT,_WDT1,_WDT2,_WDT3,_WDT4,_RDT,
               _RDMRG0,_RDMRG1,_RDMRGC,_EXTVPP1,_EXTVPP2,_CPT,_IREFT,_MEOR,
               _MEOC,_SACEEN,_RDCLKC1,_RDCLKP1,_CLKSEL1,_CE,_CWEE,_SUB,_LOWPOWER,
               _HISPEED,_RLOWSPY,_LOWSPY,_SRCUT,_EXA,_BFA,
               _BEU0,_BEU1,_BEU2,_FCLK1,_FCLK2,_PROGI,_WED,
               _SCANMODE,_TESDBT,_MUTEST,DW[IOBIT-1:0]};
  if (RESET_st!==RESET_chk && ((_VBRESZ===1'b1 && _SCANMODE===1'b0) || (_VBRESZ===1'b1 && _TRMRD1===1'b1) || _TRMRD2===1'b1) && ($time > 0)) begin
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
  end
`endif
end

/*-----RESET Logic Check-----*/
always @ ( BEU ) begin : QNS_BEU_RST_CHK
  if (BEU!==3'b000 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'BEU' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ ( DW ) begin : QNS_DW_RST_CHK
  if (DW!=={(IOBIT){1'b0}} && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'DW' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_CWEE) begin : QNS_CWEE_RST_CHK
  if (_CWEE!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'CWEE' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_WWR) begin : QNS_WWR_XZ_CHK
  if (_WWR===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "(D)WWR";
    QNS_XZ_INPUT_pri;
  end
  else if (_WWR!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)WWR' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_MSWR) begin : QNS_MSWR_XZ_CHK
  if (_MSWR===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MSWR";
    QNS_XZ_INPUT_pri;
  end
  else if (_MSWR!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'MSWR' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_CER) begin : QNS_CER_XZ_CHK
  if (_CER===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "(D)CER";
    QNS_XZ_INPUT_pri;
  end
  else if (_CER!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)CER' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_SER) begin : QNS_SER_XZ_CHK
  if (_SER===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "(D)SER";
    QNS_XZ_INPUT_pri;
  end
  else if (_SER!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)SER' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_EXER) begin : QNS_EXER_XZ_CHK
  if (_EXER===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "EXER";
    QNS_XZ_INPUT_pri;
  end
  else if (_EXER!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'EXER' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_MRG00) begin : QNS_MRG00_XZ_CHK
  if (_MRG00===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MRG00";
    QNS_XZ_INPUT_pri;
  end
  else if (_MRG00!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)MRG00' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_MRG01) begin : QNS_MRG01_XZ_CHK
  if (_MRG01===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MRG01";
    QNS_XZ_INPUT_pri;
  end
  else if (_MRG01!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)MRG01' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_MRG10) begin : QNS_MRG10_XZ_CHK
  if (_MRG10===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MRG10";
    QNS_XZ_INPUT_pri;
  end
  else if (_MRG10!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)MRG10' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_MRG11) begin : QNS_MRG11_XZ_CHK
  if (_MRG11===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MRG11";
    QNS_XZ_INPUT_pri;
  end
  else if (_MRG11!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)MRG11' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_MRG12) begin : QNS_MRG12_XZ_CHK
  if (_MRG12===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "MRG12";
    QNS_XZ_INPUT_pri;
  end
  else if (_MRG12!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)MRG12' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_DIS) begin : QNS_DIS_XZ_CHK
  if (_DIS===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "DIS";
    QNS_XZ_INPUT_pri;
  end
  else if (_DIS!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)DIS' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_READ) begin : QNS_READ_XZ_CHK
  if (_READ===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "READ";
    QNS_XZ_INPUT_pri;
  end
  else if (_READ!==1'b1 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input '(D)READ' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_IONCHK1) begin : QNS_IONCHK1_XZ_CHK
  if (_IONCHK1===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "IONCHK1";
    QNS_XZ_INPUT_pri;
  end
  else if (_IONCHK1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'IONCHK1' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_STCHK) begin : QNS_STCHK_XZ_CHK
  if (_STCHK===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "STCHK";
    QNS_XZ_INPUT_pri;
  end
  else if (_STCHK!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'STCHK' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_CPBT) begin : QNS_CPBT_XZ_CHK
  if (_CPBT===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "CPBT";
    QNS_XZ_INPUT_pri;
  end
  else if (_CPBT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'CPBT' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_WDT1) begin : QNS_WDT1_XZ_CHK
  if (_WDT1===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "WDT1";
    QNS_XZ_INPUT_pri;
  end
  else if (_WDT1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'WDT1' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_WDT2) begin : QNS_WDT2_XZ_CHK
  if (_WDT2===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "WDT2";
    QNS_XZ_INPUT_pri;
  end
  else if (_WDT2!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'WDT2' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_WDT3) begin : QNS_WDT3_XZ_CHK
  if (_WDT3===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "WDT3";
    QNS_XZ_INPUT_pri;
  end
  else if (_WDT3!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'WDT3' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_WDT4) begin : QNS_WDT4_XZ_CHK
  if (_WDT4===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "WDT4";
    QNS_XZ_INPUT_pri;
  end
  else if (_WDT4!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'WDT4' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_RDT) begin : QNS_RDT_XZ_CHK
  if (_RDT===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RDT";
    QNS_XZ_INPUT_pri;
  end
  else if (_RDT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'RDT' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_RDMRG0) begin : QNS_RDMRG0_XZ_CHK
  if (_RDMRG0===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RDMRG0";
    QNS_XZ_INPUT_pri;
  end
  else if (_RDMRG0!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'RDMRG0' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_RDMRG1) begin : QNS_RDMRG1_XZ_CHK
  if (_RDMRG1===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RDMRG1";
    QNS_XZ_INPUT_pri;
  end
  else if (_RDMRG1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'RDMRG1' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_RDMRGC) begin : QNS_RDMRGC_XZ_CHK
  if (_RDMRGC===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "RDMRGC";
    QNS_XZ_INPUT_pri;
  end
  else if (_RDMRGC!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'RDMRGC' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_EXTVPP1) begin : QNS_EXTVPP1_XZ_CHK
  if (_EXTVPP1===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "EXTVPP1";
    QNS_XZ_INPUT_pri;
  end
  else if (_EXTVPP1!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'EXTVPP1' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_EXTVPP2) begin : QNS_EXTVPP2_XZ_CHK
  if (_EXTVPP2===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "EXTVPP2";
    QNS_XZ_INPUT_pri;
  end
  else if (_EXTVPP2!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'EXTVPP2' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_CPT) begin : QNS_CPT_XZ_CHK
  if (_CPT===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "CPT";
    QNS_XZ_INPUT_pri;
  end
  else if (_CPT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'CPT' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end

always @ (_IREFT) begin : QNS_IREFT_XZ_CHK
  if (_IREFT===1'bx && (EWR_act===1'b1 || BTmode_act===1'b1)) begin
    XZ_sig = "IREFT";
    QNS_XZ_INPUT_pri;
  end
  else if (_IREFT!==1'b0 && RESETCHK_act===1'b1 && ($time > 0)) begin
`ifdef QNSA_ALL_NO_CHECK
    // NO Check
`else
    $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of input 'IREFT' signal RESET logic.");
    Error_flag_RST = 1'b1; // RO allX
`endif
  end
end


/*-----TASK Family-----*/
//----- READ Func
task QNS_READ_FUNC;  // READ ALL
  input [3:0] intrdctrl;
  begin
    if (_MUTEST===1'b0 && _FLSTOP===1'b0 && STOP_release_flag!==1'b1 && TSTOP_flag!==1'b1 && TMS_flag!==1'b1 &&
        Error_flag_XZ!==1'b1 && Error_flag_RD!==1'b1 && Error_flag!==1'b1 && MCELL_act===1'b1) begin
      if ((|{CIBRead_act,(FCBRead_act && _SUB===1'b0),MRG_act,RDMRG_act,(ION_act && (intrdctrl===4'b0010 || intrdctrl===4'b1000))}===1'b1) &&
          intce===1'b1 && _SACEEN===1'b1 && ROX_flag!==1'b1 && ROX_prevDIS_flag!==1'b1) begin
        if (MRG_act===1'b1) QNS_VerifyErrorCheck;
        QNS_READ;
      end
      else if (|{CIBRead_act,(FCBRead_act && _SUB===1'b0),MRG_act,RDMRG_act}===1'b1 && MODE!==M_RDMRGC && intce===1'b0 && _SACEEN===1'b1) begin
        // ReadDataHold
      end
      else if ((ION_act===1'b1 || MODE===M_RDMRGC || ST_act===1'b1) && intce===1'b0 && _SACEEN===1'b1) begin  // CE Signal Violate
        tmp_RO_toh=all_X;
      end
      else if (|{CIBRead_act,(FCBRead_act && _SUB===1'b0),RDMRG_act}===1'b1 && MODE!==M_RDMRGC && intce===1'b0 && _SACEEN===1'b0 && intrdctrl[3]===1'b1 && ROX_flag!==1'b1 && ROX_prevDIS_flag!==1'b1) begin  // CE=L & SACEEN=L Test
        if (intexa===1'b1 || intbfa===1'b1) tmp_RO_toh=all_X;
        else tmp_RO_toh=ReadTest;
      end
      else if (ST_act===1'b1 && intrdctrl===4'h0 && intce===1'b1 && _SACEEN===1'b1 && ROX_flag!==1'b1 && ROX_prevDIS_flag!==1'b1) begin  // STCHK
        if (intexa===1'b1 || intbfa===1'b1) tmp_RO_toh=all_X;
        else tmp_RO_toh=StchkOut;
      end
      else begin
        tmp_RO_toh=all_X;
      end
    end
    else if (_MUTEST===1'b1 && _FLSTOP===1'b0 && STOP_release_flag!==1'b1 && TSTOP_flag!==1'b1 && TMS_flag!==1'b1 &&
           Error_flag_XZ!==1'b1 && Error_flag_RD!==1'b1 && Error_flag!==1'b1 && MCELL_act===1'b1) begin
      if (ION_act===1'b1 && intrdctrl===4'h0 && intce===1'b1 && _SACEEN===1'b1 && ROX_flag!==1'b1 && ROX_prevDIS_flag!==1'b1) begin

        case ({intexa,intbfa})
          2'b10 : begin
            if (inta > (WORDE - 1)) begin
              QNS_ADD_OVER_pri;
              tmp_RO_toh = all_X;
            end
            if (((inta >= 128) && (inta < 256)) || ((inta >= 384) && (inta < 512)) ||
                ((inta >= 640) && (inta < 768)) || ((inta >= 896) && (inta < WORDE))) begin
              tmp_RO_toh = all_1;
            end
//
            if ((inta >= 768) && (inta <= 771)) begin
              if ((memEX[768] === memEX[769]) && (memEX[768] === memEX[770]) && (memEX[768] === memEX[771]))
                tmp_RO_toh = memEX[768];
              else
                tmp_RO_toh = all_X;
            end
            if ((inta >= 772) && (inta <= 775)) begin
              if ((memEX[772] === memEX[773]) && (memEX[772] === memEX[774]) && (memEX[772] === memEX[775]))
                tmp_RO_toh = memEX[772];
              else
                tmp_RO_toh = all_X;
            end
            else
                tmp_RO_toh = memEX[inta];
//            else tmp_RO_toh = memEX[inta];
          end
          default : begin
            tmp_RO_toh=all_X;
          end
        endcase
      end
      else if (ION_act===1'b1 && (intce===1'b0 || _SACEEN===1'b0 || intrdctrl!==4'h0)) begin  // CE or SACEEN Signal Violate
        tmp_RO_toh=all_X;
      end
    end
    else if (Error_flag_XZ===1'b1 || Error_flag_RD===1'b1 || Error_flag===1'b1 || (TMS_flag===1'b1 && intce===1'b1)) tmp_RO_toh=all_X;
    else if (STOP_release_flag===1'b1 && intce===1'b1) tmp_RO_toh=all_X;  //v2.00
    // ROX_flag = 1'b0;  // RO=X RESET
    ROX_prevDIS_flag = 1'b0;  // RO=X RESET
    STOP_release_flag = 1'b0;  // STOP release RESET
    Error_flag_RD = 1'b0;  // Violate RD RESET
  end
endtask

task QNS_BT_FUNC;  // BT Mode
  begin
    if (intce===1'b1 && TMS_flag!==1'b1 && Error_flag_XZ!==1'b1 && ROX_prevDIS_flag!==1'b1) begin
      QNS_READ;
    end
    else if (intce===1'b0 && TMS_flag!==1'b1 && Error_flag_XZ!==1'b1 && ROX_prevDIS_flag!==1'b1) begin
      // ReadDataHold
    end
    else begin
      tmp_RO_toh=all_X;
    end
    ROX_prevDIS_flag = 1'b0;  // RO=X RESET
  end
endtask

task QNS_READ;
  begin
    case ({intexa,intbfa})
      2'b10 : begin
        if (inta > (WORDE - 1)) begin
          QNS_ADD_OVER_pri;
          tmp_RO_toh = all_X;
        end
        if (((inta >= 128) && (inta < 256)) || ((inta >= 384) && (inta < 512)) ||
            ((inta >= 640) && (inta < 768)) || ((inta >= 896) && (inta < WORDE))) begin
          tmp_RO_toh = all_1;
        end
        else if (CON_FL_QNSA_EX_ERR_MRGX===1'b1 && MRG_act===1'b1) tmp_RO_toh=~memEX[inta];  // VerifyError
        else tmp_RO_toh=memEX[inta];
      end
      2'b01 : begin
//101020        if ( &inta[AD_TOP:12]!==1 ) begin
//101020          QNS_ADD_OVER_pri;
//101020          tmp_RO_toh = all_X;
//101020        end
        tmp_RO_toh=memBFA[inta[BFA_TOP:AD_BOTTOM]];  //v2.00
      end
      2'b00 : begin
        if (inta > (WORD - 1)) begin
          QNS_ADD_OVER_pri;
          tmp_RO_toh = all_X;
        end
        else if (inta[AD_TOP:SECAD_BOTTOM]===R0A && _R0FLAGZ===1'b0) begin
          tmp_RO_toh=memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]];
        end
        else if (CON_FL_QNSA_ERR_MRGX===1'b1 && MRG_act===1'b1) tmp_RO_toh=~memF[inta];  // VerifyError
        else tmp_RO_toh=memF[inta];
      end
      default : begin
        tmp_RO_toh=all_X;
      end
    endcase
  end
endtask

//----- Write Function
task QNS_WR1_FUNC;   // For FCLK1  integer:i
  reg [IOBIT - 1 :0] tmp_writeline1;
  reg [IOBIT - 1 :0] tmp_readline1;
  reg [AD_TOP:SECAD_BOTTOM] tmp_secadd1;
  reg [AD_TOP:AD_BOTTOM] tmp_exaadd1;
  begin
    if (TMS_flag!==1'b1 && Error_flag_XZ!==1'b1 && Error_flag!==1'b1 && MCELL_act===1'b1) begin
      if ({intce,_SACEEN,_WED,_SRCUTCP,_MUTEST}===5'b11000 && PROGD===1'b1) begin
        QNS_BEU_Set1;
        casez ({MODE,intexa,intbfa,_MEOC,_MEOR,Error_flag_XWR})
          {M_WWR,2'b??,2'b??,1'b1} : begin
            QNS_WriteAddX;   // Violate WWR/SER/CER-Mode AccessAddress X Write
          end
          {M_WWR,2'b10,2'b00,1'b?} : begin
            if (inta > (WORDE - 1)) begin
              QNS_ADD_OVER_pri;
            end
            else if (((inta >= 0) && (inta < 128)) || ((inta >= 256) && (inta < 384)) ||
                     ((inta >= 512) && (inta < 640)) || ((inta >= 768) && (inta < (WORDE-(SECTOR/2))))) begin
              tmp_readline1 = memEX[inta];
              tmp_writeline1 = memEX[inta];
              for (i=0; i<(IOBIT/2); i=i+1) begin
                tmp_writeline1[i] = tmp_readline1[i] & DW[i];
              end
              memEX[inta] = tmp_writeline1;
            end
          end
          {M_WWR,2'b01,2'b00,1'b?} : begin
//101020            if ( &inta[AD_TOP:12]!==1 ) begin
//101020              QNS_ADD_OVER_pri;
//101020            end
//101020            else begin
              tmp_readline1 = memBFA[inta[BFA_TOP:AD_BOTTOM]];  //v2.00
              tmp_writeline1 = memBFA[inta[BFA_TOP:AD_BOTTOM]];  //v2.00
              for (i=0; i<(IOBIT/2); i=i+1) begin
                tmp_writeline1[i] = tmp_readline1[i] & DW[i];
              end
              memBFA[inta[BFA_TOP:AD_BOTTOM]] = tmp_writeline1;  //v2.00
//101020            end
          end
          {M_WWR,2'b00,2'b00,1'b?} : begin
            if (inta > (WORD - 1)) begin
              QNS_ADD_OVER_pri;
            end
            else if (inta[AD_TOP:SECAD_BOTTOM]===R0A && _R0FLAGZ===1'b0) begin
              tmp_readline1 = memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]];
              tmp_writeline1 = memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]];
              for (i=0; i<(IOBIT/2); i=i+1) begin
                tmp_writeline1[i] = tmp_readline1[i] & DW[i];
              end
              memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_writeline1;
            end
            else begin
              tmp_readline1 = memF[inta];
              tmp_writeline1 = memF[inta];
              for (i=0; i<(IOBIT/2); i=i+1) begin
                tmp_writeline1[i] = tmp_readline1[i] & DW[i];
              end
              memF[inta] = tmp_writeline1;
            end
          end
          {M_MSWR,2'b10,2'b00,1'b?},{M_MSWR,2'b10,2'b10,1'b?} : begin
            if (intbeu >= 3) QNS_BEU_OVER_pri;
            for (ii=0;ii<(1<<Multi1);ii=ii+1) begin
              tmp_secadd1 = (inta[AD_TOP:SECAD_BOTTOM] >> Multi1) * (1 << Multi1) + ii;
              tmp_exaadd1 = tmp_secadd1*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM];
              if (inta > (WORDE - 1)) begin
                QNS_ADD_OVER_pri;
              end
              else if (((tmp_exaadd1[EXA_TOP:AD_BOTTOM] >= 0) && (tmp_exaadd1[EXA_TOP:AD_BOTTOM] < 128)) || ((tmp_exaadd1[EXA_TOP:AD_BOTTOM] >= 256) && (tmp_exaadd1[EXA_TOP:AD_BOTTOM] < 384)) ||
                       ((tmp_exaadd1[EXA_TOP:AD_BOTTOM] >= 512) && (tmp_exaadd1[EXA_TOP:AD_BOTTOM] < 640)) || ((tmp_exaadd1[EXA_TOP:AD_BOTTOM] >= 768) && (tmp_exaadd1[EXA_TOP:AD_BOTTOM] < (WORDE-(SECTOR/2))))) begin  //v2.00
                tmp_readline1 = memEX[tmp_secadd1*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                tmp_writeline1 = memEX[tmp_secadd1*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                for (i=0; i<(IOBIT/2); i=i+1) begin
                  tmp_writeline1[i] = tmp_readline1[i] & DW[i];
                end
                memEX[tmp_secadd1*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_writeline1;
              end
            end
          end
          {M_MSWR,2'b01,2'b00,1'b?},{M_MSWR,2'b01,2'b10,1'b?} : begin
            if (intbeu >= 3) QNS_BEU_OVER_pri;
            for (ii=0;ii<(1<<Multi1);ii=ii+1) begin
              tmp_secadd1 = (inta[BFA_TOP:SECAD_BOTTOM] >> Multi1) * (1 << Multi1) + ii; //v2.00
//101020              if ( &inta[AD_TOP:12]!==1 ) begin
//101020                QNS_ADD_OVER_pri;
//101020              end
//101020              else begin
                tmp_readline1 = memBFA[tmp_secadd1*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                tmp_writeline1 = memBFA[tmp_secadd1*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                for (i=0; i<(IOBIT/2); i=i+1) begin
                  tmp_writeline1[i] = tmp_readline1[i] & DW[i];
                end
                memBFA[tmp_secadd1*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_writeline1;
//101020              end
            end
          end
          {M_MSWR,2'b00,2'b00,1'b?},{M_MSWR,2'b00,2'b10,1'b?} : begin
            if (intbeu >= 3) QNS_BEU_OVER_pri;
            for (ii=0;ii<(1<<Multi1);ii=ii+1) begin
              tmp_secadd1 = (inta[AD_TOP:SECAD_BOTTOM] >> Multi1) * (1 << Multi1) + ii;
              if (inta > (WORD - 1)) begin
                QNS_ADD_OVER_pri;
              end
              else if (tmp_secadd1===R0A && _R0FLAGZ===1'b0) begin
                tmp_readline1 = memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                tmp_writeline1 = memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                for (i=0; i<(IOBIT/2); i=i+1) begin
                  tmp_writeline1[i] = tmp_readline1[i] & DW[i];
                end
                memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_writeline1;
              end
              else begin
                tmp_readline1 = memF[tmp_secadd1*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                tmp_writeline1 = memF[tmp_secadd1*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                for (i=0; i<(IOBIT/2); i=i+1) begin
                  tmp_writeline1[i] = tmp_readline1[i] & DW[i];
                end
                memF[tmp_secadd1*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_writeline1;
              end
            end
          end
          default : ;
        endcase
      end
      else if (intce===1'b1 && MODE===M_WWR && Error_flag_XWR===1'b1) begin
        QNS_WriteAddX;   // Violate WWR/SER/CER-Mode AccessAddress X Write
      end
    end
  end
endtask

task QNS_WR2_FUNC;   // For FCLK2  integer:j
  reg [IOBIT - 1 :0] tmp_writeline2;
  reg [IOBIT - 1 :0] tmp_readline2;
  reg [AD_TOP:SECAD_BOTTOM] tmp_secadd2;
  reg [AD_TOP:AD_BOTTOM] tmp_exaadd2;
  begin
    if (TMS_flag!==1'b1 && Error_flag_XZ!==1'b1 && Error_flag!==1'b1 && MCELL_act===1'b1) begin
      if ({intce,_SACEEN,_WED,_SRCUTCP,_MUTEST}===5'b11000 && PROGD===1'b1) begin
        QNS_BEU_Set2;
        casez ({MODE,intexa,intbfa,_MEOC,_MEOR,Error_flag_XWR})
          {M_WWR,2'b??,2'b??,1'b1} : begin
            QNS_WriteAddX;   // Violate WWR/SER/CER-Mode AccessAddress X Write
          end
          {M_WWR,2'b10,2'b00,1'b?} : begin
            if (inta > (WORDE - 1)) begin
              QNS_ADD_OVER_pri;
            end
            else if (((inta >= 0) && (inta < 128)) || ((inta >= 256) && (inta < 384)) ||
                     ((inta >= 512) && (inta < 640)) || ((inta >= 768) && (inta < (WORDE-(SECTOR/2))))) begin
              tmp_readline2 = memEX[inta];
              tmp_writeline2 = memEX[inta];
              for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
                tmp_writeline2[j] = tmp_readline2[j] & DW[j];
              end
              memEX[inta] = tmp_writeline2;
            end
          end
          {M_WWR,2'b01,2'b00,1'b?} : begin
//101020            if ( &inta[AD_TOP:12]!==1 ) begin
//101020              QNS_ADD_OVER_pri;
//101020            end
//101020            else begin
              tmp_readline2 = memBFA[inta[BFA_TOP:AD_BOTTOM]];  //v2.00
              tmp_writeline2 = memBFA[inta[BFA_TOP:AD_BOTTOM]];  //v2.00
              for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
                tmp_writeline2[j] = tmp_readline2[j] & DW[j];
              end
              memBFA[inta[BFA_TOP:AD_BOTTOM]] = tmp_writeline2;  //v2.00
//101020            end
          end
          {M_WWR,2'b00,2'b00,1'b?} : begin
            if (inta > (WORD - 1)) begin
              QNS_ADD_OVER_pri;
            end
            else if (inta[AD_TOP:SECAD_BOTTOM]===R0A && _R0FLAGZ===1'b0) begin
              tmp_readline2 = memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]];
              tmp_writeline2 = memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]];
              for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
                tmp_writeline2[j] = tmp_readline2[j] & DW[j];
              end
              memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_writeline2;
            end
            else begin
              tmp_readline2 = memF[inta];
              tmp_writeline2 = memF[inta];
              for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
                tmp_writeline2[j] = tmp_readline2[j] & DW[j];
              end
              memF[inta] = tmp_writeline2;
            end
          end
          {M_MSWR,2'b10,2'b00,1'b?},{M_MSWR,2'b10,2'b10,1'b?} : begin
            if (intbeu >= 3) QNS_BEU_OVER_pri;
            for (jj=0;jj<(1<<Multi2);jj=jj+1) begin
              tmp_secadd2 = (inta[AD_TOP:SECAD_BOTTOM] >> Multi2) * (1 << Multi2) + jj;
              tmp_exaadd2 = tmp_secadd2*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM];
              if (inta > (WORDE - 1)) begin
                QNS_ADD_OVER_pri;
              end
              else if (((tmp_exaadd2[EXA_TOP:AD_BOTTOM] >= 0) && (tmp_exaadd2[EXA_TOP:AD_BOTTOM] < 128)) || ((tmp_exaadd2[EXA_TOP:AD_BOTTOM] >= 256) && (tmp_exaadd2[EXA_TOP:AD_BOTTOM] < 384)) ||
                       ((tmp_exaadd2[EXA_TOP:AD_BOTTOM] >= 512) && (tmp_exaadd2[EXA_TOP:AD_BOTTOM] < 640)) || ((tmp_exaadd2[EXA_TOP:AD_BOTTOM] >= 768) && (tmp_exaadd2[EXA_TOP:AD_BOTTOM] < (WORDE-(SECTOR/2))))) begin  //v2.00
                tmp_readline2 = memEX[tmp_secadd2*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                tmp_writeline2 = memEX[tmp_secadd2*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
                  tmp_writeline2[j] = tmp_readline2[j] & DW[j];
                end
                memEX[tmp_secadd2*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_writeline2;
              end
            end
          end
          {M_MSWR,2'b01,2'b00,1'b?},{M_MSWR,2'b01,2'b10,1'b?} : begin
            if (intbeu >= 3) QNS_BEU_OVER_pri;
            for (jj=0;jj<(1<<Multi2);jj=jj+1) begin
              tmp_secadd2 = (inta[BFA_TOP:SECAD_BOTTOM] >> Multi2) * (1 << Multi2) + jj;  //v2.00
//101020              if ( &inta[AD_TOP:12]!==1 ) begin
//101020                QNS_ADD_OVER_pri;
//101020              end
//101020              else begin
                tmp_readline2 = memBFA[tmp_secadd2*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                tmp_writeline2 = memBFA[tmp_secadd2*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
                  tmp_writeline2[j] = tmp_readline2[j] & DW[j];
                end
                memBFA[tmp_secadd2*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_writeline2;
//101020              end
            end
          end
          {M_MSWR,2'b00,2'b00,1'b?},{M_MSWR,2'b00,2'b10,1'b?} : begin
            if (intbeu >= 3) QNS_BEU_OVER_pri;
            for (jj=0;jj<(1<<Multi2);jj=jj+1) begin
              tmp_secadd2 = (inta[AD_TOP:SECAD_BOTTOM] >> Multi2) * (1 << Multi2) + jj;
              if (inta > (WORD - 1)) begin
                QNS_ADD_OVER_pri;
              end
              else if (tmp_secadd2===R0A && _R0FLAGZ===1'b0) begin
                tmp_readline2 = memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                tmp_writeline2 = memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
                  tmp_writeline2[j] = tmp_readline2[j] & DW[j];
                end
                memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_writeline2;
              end
              else begin
                tmp_readline2 = memF[tmp_secadd2*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                tmp_writeline2 = memF[tmp_secadd2*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]];
                for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
                  tmp_writeline2[j] = tmp_readline2[j] & DW[j];
                end
                memF[tmp_secadd2*SECTOR+inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_writeline2;
              end
            end
          end
          default : ;
        endcase
      end
      else if (intce===1'b1 && MODE===M_WWR && Error_flag_XWR===1'b1) begin
        QNS_WriteAddX;   // Violate WWR/SER/CER-Mode AccessAddress X Write
      end
    end
  end
endtask

//----- Erase Function
task QNS_ER_FUNC;  // USER/REDUN:i BFA:j EXTRA:k
  begin
    if (TMS_flag!==1'b1 && Error_flag_XZ!==1'b1 && Error_flag!==1'b1 && MCELL_act===1'b1) begin
      if ({intce,_SACEEN,_WED,_SRCUTCP,_MUTEST}===5'b11000) begin
        QNS_BEU_Set1;  // BEU Set
        casez ({MODE,intexa,intbfa,_MEOC,_MEOR,Error_flag_XWR})
          {M_SER,2'b??,2'b??,1'b1},{M_CER,2'b??,2'b??,1'b1} : begin
            QNS_WriteAddX;   // Violate WWR/SER/CER-Mode AccessAddress X Write
          end
          {M_EXER,2'b??,2'b00,1'b?} : begin  // EXER MEOR=L
            for (i=0; i<WORD; i=i+1) begin  // REDUN & USER
              if (inta[AD_TOP:SECAD_BOTTOM]===R0A && _R0FLAGZ===1'b0 && ({R0A,{(ADBIT-SECBIT){1'b0}}}===(i-(i % SECTOR)))) begin
                memRD[i % SECTOR] = all_1;
              end
              else memF[i] = all_1;
            end
            for (ir=0; ir<SECTOR; ir=ir+1) begin  // REDUN
              if (_R0FLAGZ===1'b1) begin
                memRD[ir] = all_1;
              end
            end
            for (j=0; j<WORDB; j=j+1) begin  // BFA
              memBFA[j] = all_1;
            end
            for (k=0; k<(WORDE/2); k=k+1) begin  // EXTRA0/1
              if (((k >= 0) && (k < 128)) || ((k >= 256) && (k < ((WORDE-SECTOR)/2)))) memEX[k] = all_1;
            end
          end
          {M_EXER,2'b??,2'b01,1'b?} : begin  // EXER MEOR=H
            for (i=0; i<WORD; i=i+1) begin  // REDUN & USER
              if (inta[SECAD_BOTTOM]===1'b0 && ((i % (SECTOR * 2)) >= 0) && ((i % (SECTOR * 2)) < SECTOR)) begin  // Even Sector
                if (inta[AD_TOP:SECAD_BOTTOM]===R0A && _R0FLAGZ===1'b0 && ({R0A,{(ADBIT-SECBIT){1'b0}}}===(i-(i % SECTOR)))) begin
                  memRD[i % SECTOR] = all_1;
                end
                else memF[i] = all_1;
              end
              else if (inta[SECAD_BOTTOM]===1'b1 && ((i % (SECTOR * 2)) >= SECTOR) && ((i % (SECTOR * 2)) < (SECTOR * 2))) begin  // Odd Sector
                if (inta[AD_TOP:SECAD_BOTTOM]===R0A && _R0FLAGZ===1'b0 && ({R0A,{(ADBIT-SECBIT){1'b0}}}===(i-(i % SECTOR)))) begin
                  memRD[i % SECTOR] = all_1;
                end
                else memF[i] = all_1;
              end
            end
            for (ir=0; ir<SECTOR; ir=ir+1) begin  // REDUN(EVEN)
              if (_R0FLAGZ===1'b1 && inta[SECAD_BOTTOM]===1'b0) begin
                memRD[ir] = all_1;
              end
            end
            for (j=0; j<WORDB; j=j+1) begin  // BFA
              if (inta[SECAD_BOTTOM]===1'b0 && ((j % (SECTOR * 2)) >= 0) && ((j % (SECTOR * 2)) < SECTOR)) begin  // Even Sector
                memBFA[j] = all_1;
              end
              else if (inta[SECAD_BOTTOM]===1'b1 && ((j % (SECTOR * 2)) >= SECTOR) && ((j % (SECTOR * 2)) < (SECTOR * 2))) begin  // Odd Sector
                memBFA[j] = all_1;
              end
            end
            for (k=0; k<(WORDE/2); k=k+1) begin  // EXTRA0/1
              if (inta[SECAD_BOTTOM]===1'b0 && ((k % (SECTOR * 2)) >= 0) && ((k % (SECTOR * 2)) < SECTOR)) begin  // Even Sector
                if (((k >= 0) && (k < 128)) || ((k >= 256) && (k < ((WORDE-SECTOR)/2)))) memEX[k] = all_1;
              end
              else if (inta[SECAD_BOTTOM]===1'b1 && ((k % (SECTOR * 2)) >= SECTOR) && ((k % (SECTOR * 2)) < (SECTOR * 2))) begin  // Odd Sector
                if (((k >= 0) && (k < 128)) || ((k >= 256) && (k < ((WORDE-SECTOR)/2)))) memEX[k] = all_1;
              end
            end
          end
          {M_CER,2'b??,2'b00,1'b?} : begin
            for (i=0; i<WORD; i=i+1) begin  // REDUN & USER
              if (inta[AD_TOP:SECAD_BOTTOM]===R0A && _R0FLAGZ===1'b0 && ({R0A,{(ADBIT-SECBIT){1'b0}}}===(i-(i % SECTOR)))) begin
                memRD[i % SECTOR] = all_1;
              end
              else memF[i] = all_1;
            end
          end
          {M_SER,2'b00,2'b00,1'b?} : begin
            if (inta > (WORD - 1)) begin
              QNS_ADD_OVER_pri;
            end
            else begin
              for (i=0; i<SECTOR; i=i+1) begin  // REDUN & USER
                for (ii=0;ii<(1<<Multi1);ii=ii+1) begin
                  tmp_secadd = (inta[AD_TOP:SECAD_BOTTOM] >> Multi1) * (1 << Multi1) + ii;
                  if (tmp_secadd===R0A && _R0FLAGZ===1'b0) begin
                    memRD[i % SECTOR] = all_1;
                  end
                  else memF[tmp_secadd*SECTOR+i] = all_1;
                end
              end
            end
          end
          {M_SER,2'b01,2'b00,1'b?} : begin
//101020            if ( &inta[AD_TOP:12]!==1 ) begin
//101020              QNS_ADD_OVER_pri;
//101020            end
//101020            else begin
              for (j=0; j<SECTOR; j=j+1) begin  // BFA
                for (jj=0;jj<(1<<Multi1);jj=jj+1) begin
                  tmp_secadd = (inta[BFA_TOP:SECAD_BOTTOM] >> Multi1) * (1 << Multi1) + jj;  //v2.00
                  memBFA[tmp_secadd*SECTOR+j] = all_1;
                end
              end
//101020            end
          end
          {M_SER,2'b10,2'b00,1'b?} : begin
            if (inta > (WORDE - 1)) begin
              QNS_ADD_OVER_pri;
            end
            else begin
              for (k=0; k<(SECTOR/2); k=k+1) begin  // EXTRA
                for (kk=0;kk<(1<<Multi1);kk=kk+1) begin
                  tmp_secadd = (inta[AD_TOP:SECAD_BOTTOM] >> Multi1) * (1 << Multi1) + kk;
                  memEX[tmp_secadd*SECTOR+k] = all_1;
                end
              end
            end
          end
          default : ;
        endcase
      end
      else if (intce===1'b1 && (MODE===M_SER || MODE===M_CER) && Error_flag_XWR===1'b1) begin
        QNS_WriteAddX;   // Violate WWR/SER/CER-Mode AccessAddress X Write
      end
    end
  end
endtask

//----- BEU Set
task QNS_BEU_Set1;
  begin
    case(intbeu)
      3'b000  : Multi1=0;
      3'b001  : Multi1=1;
      3'b010  : Multi1=2;
      3'b011  : Multi1=3;
      3'b100  : Multi1=4;
      3'b101  : Multi1=5;
      3'b110  : Multi1=6;
      3'b111  : Multi1=7;
      default :;
    endcase
  end
endtask

task QNS_BEU_Set2;
  begin
    case(intbeu)
      3'b000  : Multi2=0;
      3'b001  : Multi2=1;
      3'b010  : Multi2=2;
      3'b011  : Multi2=3;
      3'b100  : Multi2=4;
      3'b101  : Multi2=5;
      3'b110  : Multi2=6;
      3'b111  : Multi2=7;
      default :;
    endcase
  end
endtask

//----- Sector Decoder Test  ### Code/Data-Flash
//### SECTOR
task QNS_DEC_CALUC;
  input [4:0] ara2;
  input [3:0] ara1;
  reg [15:0] Dec_B;
  reg [7:0] Dec_A;
  integer ii,jj,kk;
  begin
    tmp_secdec=0;
    Dec_A=0;
    Dec_B=0;
    for ( jj=0 ; jj<(1'b1<<ara2) ; jj=jj+1 ) begin
      for ( ii=0 ; ii<(1'b1<<ara1) ; ii=ii+1 ) begin
//      Dec_A[(inta[12:SECAD_BOTTOM]>>ara1)*(1'b1<<ara1)+ii] = 1'b1;      //for code
//      Dec_A[(inta[AD_TOP:SECAD_BOTTOM]>>ara1)*(1'b1<<ara1)+ii] = 1'b1;  //for data
       Dec_A[(inta[12:SECAD_BOTTOM]>>ara1)*(1'b1<<ara1)+ii] = 1'b1;
      end
      Dec_B[(inta[AD_TOP:13]>>ara2)*(1'b1<<ara2)+jj] = 1'b1;
    end
    tmp_secdec = {Dec_B,Dec_A};
  end
endtask

task QNS_DEC_CALUC2;
  input [3:0] ara1;
  reg [3:0] Dec_A;
  integer ii,jj,kk;
  begin
    tmp_secdec=0;
    Dec_A=0;
    for ( ii=0 ; ii<(1'b1<<ara1) ; ii=ii+1 ) begin
      if(intbfa === 1'b1) begin  //v2.00
        Dec_A[(inta[BFA_TOP:SECAD_BOTTOM]>>ara1)*(1'b1<<ara1)+ii] = 1'b1;  //v2.00
      end  //v2.00
      else begin  //v2.00
        Dec_A[(inta[EXA_TOP:SECAD_BOTTOM]>>ara1)*(1'b1<<ara1)+ii] = 1'b1;  //v2.00
      end  //v2.00
    end
    tmp_secdec = {Dec_A};
  end
endtask

task QNS_DEC;
  begin
    case ({intexa,intbfa})
      2'b00 : begin
        case (intbeu)
          3'b000:QNS_DEC_CALUC(0,0);  //QNS_X(ara2,ara1)
          3'b001:QNS_DEC_CALUC(0,1);  //QNS_X(ara2,ara1)
          3'b010:QNS_DEC_CALUC(0,2);  //QNS_X(ara2,ara1)
          3'b011:QNS_DEC_CALUC(0,3);  //QNS_X(ara2,ara1)
          3'b100:QNS_DEC_CALUC(1,3);  //QNS_X(ara2,ara1)
          3'b101:QNS_DEC_CALUC(2,3);  //QNS_X(ara2,ara1)
          3'b110:QNS_DEC_CALUC(3,3);  //QNS_X(ara2,ara1)
          3'b111:QNS_DEC_CALUC(4,3);  //QNS_X(ara2,ara1)
          default: ;
        endcase
      end
      2'b01 : begin
        case (intbeu)
          3'b000:QNS_DEC_CALUC2(0);
          3'b001:QNS_DEC_CALUC2(1);
          3'b010:QNS_DEC_CALUC2(2);
          3'b011:begin QNS_DEC_CALUC2(3); tmp_secdec[7:4] = 4'b1111; end
          3'b100:begin QNS_DEC_CALUC2(3); tmp_secdec[7:4] = 4'b1111; end
          3'b101:begin QNS_DEC_CALUC2(3); tmp_secdec[7:4] = 4'b1111; end
          3'b110:begin QNS_DEC_CALUC2(3); tmp_secdec[7:4] = 4'b1111; end
          3'b111:begin QNS_DEC_CALUC2(3); tmp_secdec[7:4] = 4'b1111; end
          default: ;
        endcase
        tmp_secdec[26] = 1'b1;
      end
      2'b10 : begin
        case (intbeu)
          3'b000:QNS_DEC_CALUC2(0);
          3'b001:QNS_DEC_CALUC2(1);
          3'b010:QNS_DEC_CALUC2(2);
          3'b011:begin QNS_DEC_CALUC2(3); tmp_secdec[7:4] = 4'b1111; end
          3'b100:begin QNS_DEC_CALUC2(3); tmp_secdec[7:4] = 4'b1111; end
          3'b101:begin QNS_DEC_CALUC2(3); tmp_secdec[7:4] = 4'b1111; end
          3'b110:begin QNS_DEC_CALUC2(3); tmp_secdec[7:4] = 4'b1111; end
          3'b111:begin QNS_DEC_CALUC2(3); tmp_secdec[7:4] = 4'b1111; end
          default: ;
        endcase
        if (inta[12]===1'b1 && intexa===1'b1) tmp_secdec = all_X;
        else tmp_secdec[25:24] = 2'b11;
      end
      default : tmp_secdec = all_X;
    endcase
  end
endtask

//### REDUN SECTOR
task QNS_REDUN_DEC;
  reg [7:0] Dec_C;
  reg [3:0] Dec_B;
  reg [3:0] Dec_A;
  begin
    tmp_secdec=0;
    Dec_A=0;
    Dec_B=0;
    Dec_C=0;
    Dec_A[R0A[1:0]] = 1'b1;
    Dec_B[R0A[3:2]] = 1'b1;
//  Dec_C[R0A[4:4]] = 1'b1;  // for CODE16KB
   Dec_C[R0A[4:4]] = 1'b1;
    tmp_secdec = {Dec_C,Dec_B,Dec_A};
  end
endtask

//----- Signal Latch
task QNS_LATCH;
  begin
  // PREV
    prevCE=intce;
    prevEXA=intexa;
    prevBFA=intbfa;
    prevA=inta;
    prevBEU=intbeu;
  // NOW
    intce=_CE;
    intbfa=_BFA;
    intexa=_EXA;
    inta=A;
    intbeu=BEU;
  end
endtask

task QNS_RDCTRL_LATCH;
  begin
    // PREV
    if (_CLKSEL1===1'b1 || BTmode_act===1'b1) prevRDCTRL_C1=intrdctrl_c1;
    if ((_CLKSEL1===1'b1 && _RDCLKC1===1'b0) || (_CLKSEL1===1'b0 && _RDCLKP1===1'b0)) prevRDCTRL_COM=intrdctrl_com;
    // NOW
    if (_CLKSEL1===1'b1 || BTmode_act===1'b1) intrdctrl_c1={_HISPEED,_LOWPOWER,_RLOWSPY,_SUB};
    if ((_CLKSEL1===1'b1 && _RDCLKC1===1'b0) || (_CLKSEL1===1'b0 && _RDCLKP1===1'b0)) intrdctrl_com={_HISPEED,_LOWPOWER,_RLOWSPY,_SUB};
  end
endtask

//-----Signal LatchReset
task QNS_LATCH_RESET;
  begin
    prevRDCTRL_C1=0;
    prevRDCTRL_P1=0;
    prevRDCTRL_COM=0;
    prevCE=0;
    prevEXA=0;
    prevBFA=0;
    prevA=0;
    prevBEU=0;

    intrdctrl_c1=0;
    intrdctrl_p1=0;
    intrdctrl_com=0;
    intce=0;
    intbfa=0;
    intexa=0;
    inta=0; 
    intbeu=0;
  end
endtask

//-----HISPEED/LOWPOWER/RLOWSPY Control Setup
task QNS_RDCTRL_SETUP;
  input [3:0] intrdctrl,prevRDCTRL;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (|{CIBRead_act,FCBRead_act,RDMRG_act}===1'b1) begin
      case ({prevRDCTRL,intrdctrl})
        8'b0010_1000 : begin  // LV -> HS
          disable ActSet_TMS_DIStoLV_chk;
          TMS_DIStoLV_flag=1'b0;
          THISPEEDS_flag = 1'b1;
          -> ActSet_THISPEEDS;
        end
        8'b0010_0100 : begin  // LV -> LP
          disable ActSet_TMS_DIStoLV_chk;
          TMS_DIStoLV_flag=1'b0;
          TLOWPOWERS_flag = 1'b1;
          -> ActSet_TLOWPOWERS;
        end
        8'b0010_0000 : begin  // LV -> LS
          disable ActSet_TMS_DIStoLV_chk;
          TMS_DIStoLV_flag=1'b0;
          TLOWSPEEDS_flag = 1'b1;
          -> ActSet_TLOWSPEEDS;
        end
        default : ;
      endcase
    end
`endif
  end
endtask

//-----tSTOP Control
task QNS_TSTOP_CTRL;
  input [3:0] intrdctrl;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    casez (intrdctrl)  // tSTOP Control
      4'b0010 : begin
        TSTOPtoLV_flag = 1'b1;
        -> ActSet_TSTOPtoLV;
      end
      4'b0000 : begin
        TSTOPtoLS_flag = 1'b1;
        -> ActSet_TSTOPtoLS;
      end
      4'b1000 : begin
        TSTOPtoHS_flag = 1'b1;
        -> ActSet_TSTOPtoHS;
      end
      4'b0100 : begin
        TSTOPtoLP_flag = 1'b1;
        -> ActSet_TSTOPtoLP;
      end
      default : ;
    endcase
`endif
  end
endtask

//-----tMS Cotrol
task QNS_IV_TMS_CTRL;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    case ({pre_MODE_IV[4:0],MODE_IV[4:0]})
      10'b01010_00010 : begin  // MRG01=>MRG11
        QNS_IV_TMS_Set;
      end
      10'b01001_00001 : begin  // MRG01=>MRG12
        QNS_IV_TMS_Set;
      end
      10'b01010_01000 : begin  // MRG11=>MRG01
        QNS_IV_TMS_Set;
      end
      10'b01001_01000 : begin  // MRG12=>MRG01
        QNS_IV_TMS_Set;
      end
      default : ;
    endcase
`endif
  end
endtask

task QNS_IV_TMS_Set;
  begin
    if (_LOWSPY===1'b0) begin
      TMS_MRG1_flag=1'b1;
      -> ActSet_TMS_MRG1;
    end
    else begin
      TMS_MRG2_flag=1'b1;
      -> ActSet_TMS_MRG2;
    end
  end
endtask

task QNS_TMS_CTRL;
  input [3:0] intrdctrl;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    casez ({pre_IDIS,IDIS,intrdctrl,MODE})
      {6'b10_001?,M_READ} : begin  // LV
        TMS_DIStoLV_flag=1'b1;
        -> ActSet_TMS_DIStoLV;
      end
      {6'b10_000?,M_READ} : begin  // LS
        TMS_DIStoLS_flag=1'b1;
        -> ActSet_TMS_DIStoLS;
      end
      {6'b10_100?,M_READ} : begin  // HS
        TMS_DIStoHS_flag=1'b1;
        -> ActSet_TMS_DIStoHS;
      end
      {6'b10_010?,M_READ} : begin  // LP
        TMS_DIStoLP_flag=1'b1;
        -> ActSet_TMS_DIStoLP;
      end
      {6'b10_????,M_MRG00},{6'b10_????,M_MRG01},{6'b10_????,M_MRG10},
      {6'b10_????,M_MRG11},{6'b10_????,M_MRG12} : begin  // MRG
        if (_LOWSPY===1'b0) begin
          TMS_MRG2_flag=1'b1;
          -> ActSet_TMS_MRG2;
        end
        else begin
          TMS_MRG3_flag=1'b1;
          -> ActSet_TMS_MRG3;
        end
      end
      {6'b10_????,M_SER},{6'b10_????,M_CER},{6'b10_????,M_EXER} : begin  // Erase
        if (intce===1'b1) begin
          TMS_DIStoER_flag=1'b1;
          -> ActSet_TMS_DIStoER;
        end
      end
      {6'b10_????,M_RDMRG0},{6'b10_????,M_RDMRG1} : begin  // RDMRG0/1
        TMS_DIStoRDM_flag=1'b1;
        -> ActSet_TMS_DIStoRDM;
      end
      {6'b10_????,M_RDMRGC} : begin  // RDMRGC
        if (intce===1'b1) begin  //v2.00
          TMS_DIStoRDMC_flag=1'b1;
          -> ActSet_TMS_DIStoRDMC;
        end
      end
      {6'b10_????,M_IONCHK1} : begin  // IONCHK1
        if (intce===1'b1) begin  //v2.00
          TMS_DIStoION_flag=1'b1;
          -> ActSet_TMS_DIStoION;
        end
      end
      {6'b10_????,M_STCHK} : begin  // STCHK
        if (intce===1'b1) begin  //v2.00
          TMS_DIStoST_flag=1'b1;
          -> ActSet_TMS_DIStoST;
        end
      end
      default : ;
    endcase
`endif
  end
endtask

//-----FLSTOP-Func-disable
task QNS_FLSTOP_Disable;
  begin
    disable ActSet_TSTOPtoHS_chk;
    disable ActSet_TSTOPtoLS_chk;
    disable ActSet_TSTOPtoLV_chk;
    disable ActSet_TSTOPtoLP_chk;
  end
endtask

//----- tDIS check
task QNS_TDIS_CHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (($time > 0) && (DISnegetime > DISposetime)) begin
      case (pre_MODE_TDIS)
        M_WWR : begin 
          if ((DISnegetime - DISposetime) < TDIS_fromWWR && pre_CE_TDIS1===1'b1) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (WWR->DIS).");
          end
        end
        M_MSWR : begin
          if ((DISnegetime - DISposetime) < TDIS_fromMSWR1 && pre_CE_TDIS1===1'b1 && pre_BEU_TDIS <= 3) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (MSWR(BEU<=3)->DIS).");
          end
          else if ((DISnegetime - DISposetime) < TDIS_fromMSWR2 && pre_CE_TDIS1===1'b1 && pre_BEU_TDIS > 3) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (MSWR(BEU>3)->DIS).");
          end
        end
        M_SER,M_CER,M_EXER : begin 
          if ((DISnegetime - DISposetime) < TDIS_fromER1 && pre_CE_TDIS1===1'b1 && pre_LOWSPY_TDIS===1'b0) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (SER/CER/EXER@LOWSPY=L->DIS).");
          end
          else if ((DISnegetime - DISposetime) < TDIS_fromER2 && pre_CE_TDIS1===1'b1 && pre_LOWSPY_TDIS===1'b1) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (SER/CER/EXER@LOWSPY=H->DIS).");
          end
        end
        M_MRG00,M_MRG10 : begin 
          if ((DISnegetime - DISposetime) < TDIS_fromMRG1 && pre_LOWSPY_TDIS===1'b0) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (MRGxx@LOWSPY=L->DIS).");
          end
          else if ((DISnegetime - DISposetime) < TDIS_fromMRG2 && pre_LOWSPY_TDIS===1'b1) begin 
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (MRGxx@LOWSPY=H->DIS).");
          end
        end
        M_MRG01,M_MRG11,M_MRG12 : begin
`ifdef QNSA_IV_10NS
          //NO Check
`else
          if ((DISnegetime - DISposetime) < TDIS_fromMRG1 && pre_LOWSPY_TDIS===1'b0) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (MRGxx@LOWSPY=L->DIS).");
          end
          else if ((DISnegetime - DISposetime) < TDIS_fromMRG2 && pre_LOWSPY_TDIS===1'b1) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (MRGxx@LOWSPY=H->DIS).");
          end
`endif
        end 
        M_READ : begin 
           if ((DISnegetime - DISposetime) < TDIS_fromREAD1 && pre_RLOWSPY_TDIS===1'b0) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (READ@RLOWSPY=L->DIS).");
          end
          else if ((DISnegetime - DISposetime) < TDIS_fromREAD2 && pre_RLOWSPY_TDIS===1'b1) begin 
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (READ@RLOWSPY=H->DIS).");
          end
        end
        M_IONCHK1 : begin
          if ((DISnegetime - DISposetime) < TDIS_fromION1 && pre_CE_TDIS1===1'b1 && pre_LOWSPY_TDIS===1'b0) begin  //v2.00
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (IONCHK1@LOWSPY=L->DIS).");
          end
          else if ((DISnegetime - DISposetime) < TDIS_fromION2 && pre_CE_TDIS1===1'b1 && pre_LOWSPY_TDIS===1'b1) begin  //v2.00
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (IONCHK1@LOWSPY=H->DIS).");
          end
        end
        M_CPBT : begin
          if ((DISnegetime - DISposetime) < TDIS_fromCPBT1 && pre_LOWSPY_TDIS===1'b0) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (CPBT@LOWSPY=L->DIS).");
          end
          else if ((DISnegetime - DISposetime) < TDIS_fromCPBT2 && pre_LOWSPY_TDIS===1'b1) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (CPBT@LOWSPY=H->DIS).");
          end
        end
        M_WDT1,M_WDT2,M_WDT3 : begin
          if ((DISnegetime - DISposetime) < TDIS_fromWDT && pre_CE_TDIS1===1'b1) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (WDT1/WDT2/WDT3->DIS).");
          end
        end
        M_WDT4 : begin
          if ((DISnegetime - DISposetime) < TDIS_fromWDT) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (WDT4->DIS).");
          end
        end
        M_RDT : begin
          if ((DISnegetime - DISposetime) < TDIS_fromRDT) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (RDT->DIS).");
          end
        end
        M_STCHK : begin 
          if ((DISnegetime - DISposetime) < TDIS_fromST && pre_CE_TDIS1===1'b1) begin  //v2.00
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (STCHK->DIS).");
          end
        end
        M_RDMRG0,M_RDMRG1 : begin 
          if ((DISnegetime - DISposetime) < TDIS_fromRDM) begin
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (RDMRG0/RDMRG1->DIS).");
          end
        end
        M_RDMRGC : begin
          if ((DISnegetime - DISposetime) < TDIS_fromRDM && pre_CE_TDIS1===1'b1) begin  //v2.00
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (RDMRGC->DIS).");
          end
        end
        default : begin
          if ((DISnegetime - DISposetime) < TDIS_fromDEF) begin 
            $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : DIS period is short (tDIS=1us).");
          end
        end
      endcase
    end
`endif
  end
endtask

//----- Add Over Pri
task QNS_ADD_OVER_pri;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if ($time > 0) $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : You are accessing the invalid address.");
`endif
  end
endtask

//----- BEU Note or Warning Pri
task QNS_BEU_OVER_pri;
  begin
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
    if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : The BEU2-0 signal is 3 or more.");
`endif
  end
endtask

//----- CLKSEL1 Check Pri
task QNS_CLKSEL1_CHK1_pri;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if ($time > 0) $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : On (D)CLKSEL1 changing, RDCLKC1 and RDCLKP1 must be both HIGH.");
`endif
  end
endtask

task QNS_CLKSEL1_CHK2_pri;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if ($time > 0) $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : (D)CLKSEL1 can change only in DIS or READ mode.");
`endif
  end
endtask

//-----HISPEED/LOWPOWER/RLOWSPY/SUB Check
task QNS_RDCTRL_CHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if ( $time > 0 ) begin
      $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : The change in the %0s signal should be 'RDCLK=H'.",VIOLATE_sig);
    end
`endif
  end
endtask

//-----EXA/CE Change Check
task QNS_EXA_CHK_pri;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if ($time > 0) begin
      $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : The change in the EXA signal in this mode is prohibited.");
      Error_flag=1'b1;
    end
`endif
  end
endtask

task QNS_CE_CHK_pri;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if ($time > 0) begin
      $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : The change in the (D)CE signal in this mode is prohibited.");
      Error_flag=1'b1;
    end
`endif
  end
endtask

//-----RDCLK=L Prohibit Check
task QNS_RDCLKL_CHK_pri;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if ($time > 0) begin
      $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : The change in the %0s signal is prohibited between RDCLKC1(P1)=L.",VIOLATE_sig2);
      Error_flag_RD=1'b1;
    end
`endif
  end
endtask

//-----Mode Set Check
task QNS_MODE_SET_CHK;
  integer aa,bb,cc;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    bb=0;
    for (aa=0;aa<22;aa=aa+1) begin  // Other IDIS No-Count
      if (MODE[aa]===1'b1) bb=bb+1;
    end
    if (MODE[15]===1'b1 && MODE[13]===1'b1) bb=0;  // IntVerify MRG01=H & MRG11=H
    else if (MODE[15]===1'b1 && MODE[12]===1'b1) bb=0;  // IntVerify MRG01=H & MRG12=H
    else if (($time > 0) && (bb > 1)) begin
      $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Two mode signals or more prohibit 'H'.");
      Error_flag=1'b1;
    end
`endif
  end
endtask

//-----HISPEED/LOWPOWER/RLOWSPY Set Check
task QNS_RDCTRL_C1_CHK;  // RDCLKC1 Select
  integer aa,bb,cc;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    bb=0;
    for (aa=1;aa<4;aa=aa+1) begin  // Other SUB No-Count
      if (intrdctrl_c1[aa]===1'b1) bb=bb+1;
    end
    if (($time > 0) && (bb > 1) && intce===1'b1) begin
      $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Two signals or more of HISPEED and LOWPOWER and RLOWSPY prohibit 'H'.");
      Error_flag=1'b1;
    end
`endif
  end
endtask

task QNS_RDCTRL_P1_CHK;  // RDCLKP1 Select
  integer aa,bb,cc;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    bb=0;
    for (aa=1;aa<4;aa=aa+1) begin  // Other SUB No-Count
      if (intrdctrl_p1[aa]===1'b1) bb=bb+1;
    end
    if (($time > 0) && (bb > 1) && intce===1'b1) begin
      $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Two signals or more of HISPEED and LOWPOWER and RLOWSPY prohibit 'H'.");
      Error_flag=1'b1;
    end
`endif
  end
endtask

//-----Signal Logic Xwrite Check
task QNS_SIG_CHK_pri;
  input [80:1] violate_sig;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (($time > 0) && _TRMRD1===1'b0 && _TRMRD2===1'b0 &&
       ((|{FCBRead_act,CIBRead_act,MRG_act,(WDT_act===1'b1 && MODE===M_WDT4),RDT_act,CPBT_act,(RDMRG_act===1'b1 && MODE!==M_RDMRGC)}===1'b1)||
        (intce===1'b1 && |{WR_act,ER_act,ION_act,ST_act,(WDT_act===1'b1 && MODE!==M_WDT4),(RDMRG_act===1'b1 && MODE===M_RDMRGC)}===1'b1))) begin
      $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of %0s signal.",violate_sig);
      if (intce===1'b1 && (MODE===M_CER || MODE===M_SER || MODE===M_WWR)) Error_flag_XWR=1'b1;
      else if (intce===1'b1 && (MODE===M_EXER || MODE===M_MSWR || MODE===M_WDT1 || MODE===M_WDT2 ||
               MODE===M_WDT3 || MODE===M_IONCHK1 || MODE===M_STCHK || MODE===M_RDMRGC)) Error_flag=1'b1;
    end
`endif
  end
endtask

//-----Mode Set Signal Check & MODE-Infomation
task QNS_MODESET_SIG_CHK;
  begin
    if ($time > 0) begin
      casez ({intce,MODE})
        {1'b1,M_WWR} : begin
          if (WR_act===1'b1) begin
            QNS_SACEEN_LCHK;
            // QNS_SRCUT_HCHK;
            QNS_SRCUTCP_HCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            QNS_MUTEST_HCHK;
            QNS_MEOR_HCHK;
            QNS_MEOC_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is WWR-Mode.");
`endif
          end
        end
        {1'b1,M_MSWR} : begin
          if (WR_act===1'b1) begin
            QNS_SACEEN_LCHK;
            QNS_SRCUT_HCHK;
            QNS_SRCUTCP_HCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            QNS_MUTEST_HCHK;
            QNS_MEOR_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is MSWR-Mode.");
`endif
          end
        end
        {1'b1,M_SER},{1'b1,M_CER},{1'b1,M_EXER} : begin 
          if (ER_act===1'b1) begin
            // if (MODE===M_SER) QNS_SACEEN_LCHK;
            if (MODE===M_EXER) QNS_SRCUT_HCHK;
            QNS_SRCUTCP_HCHK;
            QNS_PROGI_HCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            if (MODE===M_EXER) QNS_MUTEST_HCHK;
            if (MODE===M_SER || MODE===M_CER) QNS_MEOR_HCHK;
            QNS_MEOC_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is SER/CER/EXER-Mode.");
`endif
          end
        end
        {1'b?,M_MRG00},{1'b?,M_MRG01},{1'b?,M_MRG10},{1'b?,M_MRG11},{1'b?,M_MRG12} : begin 
          if (MRG_act===1'b1) begin
            QNS_SACEEN_LCHK;
            // QNS_SRCUT_HCHK;
            QNS_SRCUTCP_HCHK;
            QNS_PROGI_HCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            QNS_MUTEST_HCHK;
            QNS_MEOR_HCHK;
            QNS_MEOC_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is MRG00/01/10/11/12-Mode.");
`endif
          end
        end
        {1'b?,M_READ} : begin
          if (FCBRead_act===1'b1 || CIBRead_act===1'b1) begin
            if (intce===1'b1) QNS_SACEEN_LCHK;
            // QNS_MUTEST_HCHK;  //### For NewMode? 100202
            QNS_MEOR_HCHK;
            QNS_MEOC_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is READ-Mode.");
`endif
          end
        end
        {1'b1,M_IONCHK1} : begin
          if (ION_act===1'b1) begin
            QNS_LOWSPY_HCHK;
            QNS_SACEEN_LCHK;
            QNS_SRCUT_HCHK;
            QNS_SRCUTCP_HCHK;
            QNS_PROGI_HCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            // QNS_MUTEST_HCHK;  //### CodeFL NoCheck
            QNS_MEOR_HCHK;
            QNS_MEOC_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is IONCHK1-Mode.");
`endif
          end
        end
        {1'b?,M_CPBT} : begin
          if (CPBT_act===1'b1) begin
            QNS_SACEEN_LCHK;
            //v1.01_modify QNS_WED_HCHK;
            QNS_SRCUT_HCHK;
            QNS_SRCUTCP_HCHK;
            QNS_PROGI_HCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            QNS_MUTEST_HCHK;
            QNS_MEOR_HCHK;
            QNS_MEOC_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is CPBT-Mode.");
`endif
          end
        end
        {1'b1,M_WDT1},{1'b1,M_WDT2},{1'b1,M_WDT3} : begin
          if (WDT_act===1'b1 && MODE!==M_WDT4) begin
            QNS_SACEEN_LCHK;
            //v1.01_modify QNS_WED_HCHK;
            QNS_SRCUT_HCHK;
            QNS_SRCUTCP_HCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            QNS_MUTEST_HCHK;
            if ((MODE===M_WDT1 && _MEOC===1'b1) || MODE===M_WDT2 || MODE===M_WDT3) QNS_MEOR_HCHK;
            if ((MODE===M_WDT1 && _MEOR===1'b1) || MODE===M_WDT2 || MODE===M_WDT3) QNS_MEOC_HCHK;
            if ( MODE===M_WDT1 && _MEOR===1'b1 && _EXTVPP1!==1'b1) QNS_MEOR_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is WDT1/2/3-Mode.");
`endif
          end
        end
        {1'b?,M_WDT4} : begin
          if (WDT_act===1'b1 && MODE===M_WDT4) begin
            QNS_SACEEN_LCHK;
            //v1.01_modify QNS_WED_HCHK;
            QNS_SRCUT_HCHK;
            QNS_SRCUTCP_HCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            QNS_MUTEST_HCHK;
            QNS_MEOR_HCHK;
            if (MODE===M_WDT4 && _MEOC===1'b1 && (_EXTVPP1===1'b1 || _EXTVPP2===1'b1)) QNS_MEOC_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is WDT4-Mode.");
`endif
          end
        end
        {1'b?,M_RDT} : begin
          if (RDT_act===1'b1) begin
//          QNS_LOWSPY_HCHK;
            QNS_SACEEN_LCHK;
            //v1.01_modify QNS_WED_HCHK;
            QNS_SRCUT_HCHK;
            QNS_SRCUTCP_HCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            QNS_MUTEST_HCHK;
            if (intce===1'b1) QNS_MEOC_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is RDT-Mode.");
`endif
          end
        end
        {1'b1,M_STCHK} : begin
          if (ST_act===1'b1) begin
//          QNS_LOWSPY_HCHK;
            QNS_SACEEN_LCHK;
            QNS_SRCUT_HCHK;
            QNS_SRCUTCP_HCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            QNS_MUTEST_HCHK;
            QNS_MEOR_HCHK;
            QNS_MEOC_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is STCHK-Mode.");
`endif
          end
        end
        {1'b?,M_RDMRG0},{1'b?,M_RDMRG1} : begin
          if (RDMRG_act===1'b1 && MODE!==M_RDMRGC) begin
            QNS_LOWSPY_HCHK;
            if (intce===1'b1) QNS_SACEEN_LCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            QNS_MUTEST_HCHK;
            QNS_MEOR_HCHK;
            QNS_MEOC_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is RDMRG0/RDMRG1-Mode.");
`endif
          end
        end
        {1'b1,M_RDMRGC} : begin
          if (RDMRG_act===1'b1 && MODE===M_RDMRGC) begin
            QNS_LOWSPY_HCHK;
            QNS_SACEEN_LCHK;
            QNS_FCLK1_HCHK;
            QNS_FCLK2_HCHK;
            QNS_MUTEST_HCHK;
            QNS_MEOR_HCHK;
            QNS_MEOC_HCHK;
`ifdef NECLIB_ERRMSG_ONLY
// NO Message
`else
            if ($time > 0) $display ("HM Note   : ",$time," QNSA3N032K1V2 %m : It is RDMRGC-Mode.");
`endif
          end
        end
        default : ;
      endcase
    end
  end
endtask

//### Signal Check task
task QNS_SACEEN_LCHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (_SACEEN===1'b0) begin
      VIOLATE_sig3="SACEEN";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
`endif
  end
endtask

task QNS_LOWSPY_HCHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (_LOWSPY===1'b1) begin
      VIOLATE_sig3="LOWSPY";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
`endif
  end
endtask

task QNS_WED_HCHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (_WED===1'b1) begin
      VIOLATE_sig3="WED";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
`endif
  end
endtask

task QNS_SRCUT_HCHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (_SRCUT===1'b1) begin
      VIOLATE_sig3="SRCUT";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
`endif
  end
endtask

task QNS_SRCUTCP_HCHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (_SRCUTCP===1'b1) begin
      VIOLATE_sig3="SRCUTCP";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
`endif
  end
endtask

task QNS_PROGI_HCHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (_PROGI===1'b1) begin
      VIOLATE_sig3="PROGI";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
`endif
  end
endtask

task QNS_FCLK1_HCHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (_FCLK1===1'b1) begin
      VIOLATE_sig3="FCLK1";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
`endif
  end
endtask

task QNS_FCLK2_HCHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (_FCLK2===1'b1) begin
      VIOLATE_sig3="FCLK2";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
`endif
  end
endtask

task QNS_MUTEST_HCHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (_MUTEST===1'b1) begin
      VIOLATE_sig3="MUTEST";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
`endif
  end
endtask

task QNS_MEOR_HCHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (_MEOR===1'b1) begin
      VIOLATE_sig3="MEOR";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
`endif
  end
endtask

task QNS_MEOC_HCHK;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if (_MEOC===1'b1) begin
      VIOLATE_sig3="MEOC";
      QNS_SIG_CHK_pri (VIOLATE_sig3);
    end
`endif
  end
endtask

//-----MemoryCell AccessAddress X Write
task QNS_WriteAddX;   // WWR/SER/CER-Mode AccessAddress X Write
  integer i,j,k,ii,jj,kk;
  reg [IOBIT -1:0]tmp_X1,tmp_X2;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    QNS_BEU_Set1;  // BEU Set
    casez ({MODE,intexa,intbfa})
      {M_WWR,2'b10} : begin
        if (((inta >= 0) && (inta < 128)) || ((inta >= 256) && (inta < 384)) ||
            ((inta >= 512) && (inta < 640)) || ((inta >= 768) && (inta < (WORDE-(SECTOR/2))))) begin
          if (_FCLK1===1'b1) begin
            tmp_X1 = memEX[inta];
            for (i=0; i<(IOBIT/2); i=i+1) begin
              tmp_X1[i] = 1'bx;
            end
            memEX[inta] = tmp_X1;
          end
          if (_FCLK2===1'b1) begin
            tmp_X2 = memEX[inta];
            for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
              tmp_X2[j] = 1'bx;
            end
            memEX[inta] = tmp_X2;
          end
          VIOLATE_mode="WWR";
          QNS_WriteAddX_pri;
        end
      end
      {M_WWR,2'b01} : begin
        if (_FCLK1===1'b1) begin
          tmp_X1 = memBFA[inta[BFA_TOP:AD_BOTTOM]];  //v2.00
          for (i=0; i<(IOBIT/2); i=i+1) begin
            tmp_X1[i] = 1'bx;
          end
          memBFA[inta[BFA_TOP:AD_BOTTOM]] = tmp_X1;  //v2.00
        end
        if (_FCLK2===1'b1) begin
          tmp_X2 = memBFA[inta[BFA_TOP:AD_BOTTOM]];  //v2.00
          for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
            tmp_X2[j] = 1'bx;
          end
          memBFA[inta[BFA_TOP:AD_BOTTOM]] = tmp_X2;  //v2.00
        end
        VIOLATE_mode="WWR";
        QNS_WriteAddX_pri;
      end
      {M_WWR,2'b00} : begin
        if (inta[AD_TOP:SECAD_BOTTOM]===R0A && _R0FLAGZ===1'b0 && _FCLK1===1'b1) begin
          tmp_X1 = memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]];
          for (i=0; i<(IOBIT/2); i=i+1) begin
            tmp_X1[i] = 1'bx;
          end
          memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_X1;
        end
        else if (_FCLK1===1'b1) begin
          tmp_X1 = memF[inta];
          for (i=0; i<(IOBIT/2); i=i+1) begin
            tmp_X1[i] = 1'bx;
          end
          memF[inta] = tmp_X1;
        end
        if (inta[AD_TOP:SECAD_BOTTOM]===R0A && _R0FLAGZ===1'b0 && _FCLK2===1'b1) begin 
          tmp_X2 = memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]];
          for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
            tmp_X2[j] = 1'bx;
          end
          memRD[inta[SECAD_OTHER_TOP:AD_BOTTOM]] = tmp_X2;
        end
        else if (_FCLK2===1'b1) begin
          tmp_X2 = memF[inta];
          for (j=(IOBIT/2); j<IOBIT; j=j+1) begin
            tmp_X2[j] = 1'bx;
          end
          memF[inta] = tmp_X2;
        end
        VIOLATE_mode="WWR";
        QNS_WriteAddX_pri;
      end
      {M_CER,2'b??} : begin
        for (i=0; i<WORD; i=i+1) begin  // REDUN & USER
          if (inta[AD_TOP:SECAD_BOTTOM]===R0A && _R0FLAGZ===1'b0 &&
              ({R0A,{(ADBIT-SECBIT){1'b0}}}===(i-(i % SECTOR)))) memRD[i % SECTOR] = all_X;
          else memF[i] = all_X;
          if (i===0) begin
            VIOLATE_mode="CER";
            QNS_WriteAddX_pri;
          end
        end
      end
      {M_SER,2'b00} : begin
        for (i=0; i<SECTOR; i=i+1) begin  // REDUN & USER
          for (ii=0;ii<(1<<Multi1);ii=ii+1) begin
            tmp_secadd = (inta[AD_TOP:SECAD_BOTTOM] >> Multi1) * (1 << Multi1) + ii;
            if (tmp_secadd===R0A && _R0FLAGZ===1'b0) memRD[i % SECTOR] = all_X;
            else memF[tmp_secadd*SECTOR+i] = all_X;
          end
          if (i===0) begin
            VIOLATE_mode="SER";
            QNS_WriteAddX_pri;
          end
        end
      end
      {M_SER,2'b01} : begin
        for (j=0; j<SECTOR; j=j+1) begin  // BFA
          for (jj=0;jj<(1<<Multi1);jj=jj+1) begin
            tmp_secadd = (inta[BFA_TOP:SECAD_BOTTOM] >> Multi1) * (1 << Multi1) + jj;  //v2.00
            memBFA[tmp_secadd*SECTOR+j] = all_X;
          end
          if (j===0) begin
            VIOLATE_mode="SER";
            QNS_WriteAddX_pri;
          end
        end
      end
      {M_SER,2'b10} : begin
        for (k=0; k<(SECTOR/2); k=k+1) begin  // EXTRA
          for (kk=0;kk<(1<<Multi1);kk=kk+1) begin
            tmp_secadd = (inta[AD_TOP:SECAD_BOTTOM] >> Multi1) * (1 << Multi1) + kk;
            memEX[tmp_secadd*SECTOR+k] = all_X;
          end
          if (k===0) begin
            VIOLATE_mode="SER";
            QNS_WriteAddX_pri;
          end
        end
      end
      default : ;
    endcase
`endif
    Error_flag_XWR=1'b0;
  end
endtask

task QNS_WriteAddX_pri;  // X-Write Message
  begin
    if ($time > 0) begin
      $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of signal control %0s-mode. 'X' was written at the accessed address.",VIOLATE_mode);
    end
  end
endtask

//-----XZ Input Check
task QNS_XZ_INPUT_pri;
  begin
`ifdef QNSA_ALL_NO_CHECK
// NO Check
`else
    if ($time > 0) begin
      $display ("HM Error  : ",$time," QNSA3N032K1V2 %m : Violation of XZ input %0s signal.",XZ_sig);
      Error_flag_XZ=1'b1;
    end
`endif
  end
endtask

task QNS_MODE_XZ_CHK;
  begin
    if (_DIS===1'bx) begin
      XZ_sig = "(D)DIS";
      QNS_XZ_INPUT_pri;
    end
    if (_WWR===1'bx) begin
      XZ_sig = "(D)WWR";
      QNS_XZ_INPUT_pri;
    end
    if (_MSWR===1'bx) begin
      XZ_sig = "MSWR";
      QNS_XZ_INPUT_pri;
    end
    if (_SER===1'bx) begin
      XZ_sig = "(D)SER";
      QNS_XZ_INPUT_pri;
    end
    if (_CER===1'bx) begin
      XZ_sig = "(D)CER";
      QNS_XZ_INPUT_pri;
    end
    if (_EXER===1'bx) begin
      XZ_sig = "EXER";
      QNS_XZ_INPUT_pri;
    end
    if (_MRG00===1'bx || _MRG01===1'bx || _MRG10===1'bx || _MRG11===1'bx || _MRG12===1'bx) begin
      XZ_sig = "(D)MRGxx";
      QNS_XZ_INPUT_pri;
    end
    if (_READ===1'bx) begin
      XZ_sig = "(D)READ";
      QNS_XZ_INPUT_pri;
    end
    if (_IONCHK1===1'bx) begin
      XZ_sig = "IONCHK1";
      QNS_XZ_INPUT_pri;
    end
    if (_CPBT===1'bx) begin
      XZ_sig = "CPBT";
      QNS_XZ_INPUT_pri;
    end
    if (_WDT1===1'bx || _WDT2===1'bx || _WDT3===1'bx || _WDT4===1'bx) begin
      XZ_sig = "WDTx";
      QNS_XZ_INPUT_pri;
    end
    if (_RDT===1'bx) begin
      XZ_sig = "RDT";
      QNS_XZ_INPUT_pri;
    end
    if (_RDMRG0===1'bx || _RDMRG1===1'bx || _RDMRGC===1'bx) begin
      XZ_sig = "RDMRGx";
      QNS_XZ_INPUT_pri;
    end
    if (_STCHK===1'bx) begin
      XZ_sig = "STCHK";
      QNS_XZ_INPUT_pri;
    end
    if (_EXTVPP1===1'bx) begin
      XZ_sig = "EXTVPP1";
      QNS_XZ_INPUT_pri;
    end
    if (_EXTVPP2===1'bx) begin
      XZ_sig = "EXTVPP2";
      QNS_XZ_INPUT_pri;
    end
    if (_CPT===1'bx) begin
      XZ_sig = "CPT";
      QNS_XZ_INPUT_pri;
    end
    if (_IREFT===1'bx) begin
      XZ_sig = "IREFT";
      QNS_XZ_INPUT_pri;
    end
    if (_CWEE===1'bx) begin
      XZ_sig = "CWEE";
      QNS_XZ_INPUT_pri;
    end
  end
endtask

task QNS_LATSIG_XZ_CHK;
  integer aa,bb,cc,dd,ee,ff;
  begin
    for (aa=AD_BOTTOM;aa<=AD_TOP;aa=aa+1) begin : Address_XZchk
      if (inta[aa]===1'bx) begin
        XZ_sig = "A(Address)";
        QNS_XZ_INPUT_pri;
      end
    end
    for (bb=0;bb<=2;bb=bb+1) begin : BEU_XZchk
      if (intbeu[bb]===1'bx) begin
        XZ_sig = "BEU";
        QNS_XZ_INPUT_pri;
      end
    end
    if (intexa===1'bx) begin : EXA_XZchk
      XZ_sig = "EXA";
      QNS_XZ_INPUT_pri;
    end
    if (intbfa===1'bx) begin : BFA_XZchk
      XZ_sig = "BFA";
      QNS_XZ_INPUT_pri;
    end
    if (intce===1'bx) begin : CE_XZchk
      XZ_sig = "CE";
      QNS_XZ_INPUT_pri;
    end
  end
endtask

//-----RO Data X Output
task QNS_ROX;
  begin
    tmp_RO_toh = all_X;
  end
endtask

task QNS_ROX_DIRECT;
  begin
    tmp_RO = all_X;
    tmp_RO_toh = all_X;
  end
endtask

//----- tOH Func
task QNS_TohFunction;
  integer aa;
  begin
    if (tmp_RO===tmp_RO_toh || tmp_RO_toh===all_X) begin
      tmp_RO=tmp_RO_toh;
    end
    else begin
      if (tmp_RO===all_X) begin
       #(TOH);
        tmp_RO=tmp_RO_toh;
      end
      else begin
        for (aa=0;aa<IOBIT;aa=aa+1) begin
          if (tmp_RO[aa]===tmp_RO_toh[aa]) tmp_RO[aa]=tmp_RO_toh[aa];
          else tmp_RO[aa]=1'bx;
        end
        #(TOH);
        tmp_RO=tmp_RO_toh;
      end
    end
  end
endtask

//----- Firm Verification Error Check
task QNS_VerifyErrorCheck;
  begin
    // USER
    `ifdef FL_QNSA_ERR_MRG00
       FL_QNSA_ERR_MRG00_tmp = `FL_QNSA_ERR_MRG00;
       if (FL_QNSA_ERR_MRG00_tmp[AD_TOP:AD_BOTTOM]===inta && MODE===M_MRG00 && {intexa,intbfa}===2'b00) CON_FL_QNSA_ERR_MRG00 = 1'b1;
       else CON_FL_QNSA_ERR_MRG00 = 1'b0;
    `endif

    `ifdef FL_QNSA_ERR_MRG01
       FL_QNSA_ERR_MRG01_tmp = `FL_QNSA_ERR_MRG01;
       if (FL_QNSA_ERR_MRG01_tmp[AD_TOP:AD_BOTTOM]===inta && MODE===M_MRG01 && {intexa,intbfa}===2'b00) CON_FL_QNSA_ERR_MRG01 = 1'b1;
       else CON_FL_QNSA_ERR_MRG01 = 1'b0;
    `endif

    `ifdef FL_QNSA_ERR_MRG10
       FL_QNSA_ERR_MRG10_tmp = `FL_QNSA_ERR_MRG10;
       if (FL_QNSA_ERR_MRG10_tmp[AD_TOP:AD_BOTTOM]===inta && MODE===M_MRG10 && {intexa,intbfa}===2'b00) CON_FL_QNSA_ERR_MRG10 = 1'b1;
       else CON_FL_QNSA_ERR_MRG10 = 1'b0;
    `endif

    // EXTRA
    `ifdef FL_QNSA_EX_ERR_MRG00
       FL_QNSA_EX_ERR_MRG00_tmp = `FL_QNSA_EX_ERR_MRG00;
       if (FL_QNSA_EX_ERR_MRG00_tmp[AD_TOP:AD_BOTTOM]===inta && MODE===M_MRG00 && {intexa,intbfa}===2'b10) CON_FL_QNSA_EX_ERR_MRG00 = 1'b1;
       else CON_FL_QNSA_EX_ERR_MRG00 = 1'b0;
    `endif

    `ifdef FL_QNSA_EX_ERR_MRG01
       FL_QNSA_EX_ERR_MRG01_tmp = `FL_QNSA_EX_ERR_MRG01;
       if (FL_QNSA_EX_ERR_MRG01_tmp[AD_TOP:AD_BOTTOM]===inta && MODE===M_MRG01 && {intexa,intbfa}===2'b10) CON_FL_QNSA_EX_ERR_MRG01 = 1'b1;
       else CON_FL_QNSA_EX_ERR_MRG01 = 1'b0;
    `endif

    `ifdef FL_QNSA_EX_ERR_MRG10
       FL_QNSA_EX_ERR_MRG10_tmp = `FL_QNSA_EX_ERR_MRG10;
       if (FL_QNSA_EX_ERR_MRG10_tmp[AD_TOP:AD_BOTTOM]===inta && MODE===M_MRG10 && {intexa,intbfa}===2'b10) CON_FL_QNSA_EX_ERR_MRG10 = 1'b1;
       else CON_FL_QNSA_EX_ERR_MRG10 = 1'b0;
    `endif

    // FLAG
    CON_FL_QNSA_ERR_MRGX = ( CON_FL_QNSA_ERR_MRG00===1'b1 | CON_FL_QNSA_ERR_MRG01===1'b1 | CON_FL_QNSA_ERR_MRG10===1'b1 );
    CON_FL_QNSA_EX_ERR_MRGX = ( CON_FL_QNSA_EX_ERR_MRG00===1'b1 |  CON_FL_QNSA_EX_ERR_MRG01===1'b1 |  CON_FL_QNSA_EX_ERR_MRG10===1'b1 );
  end
endtask

/*-----Specify-----*/
//#######################
// For poseCLK intce
// For negeCLK CE
//#######################
assign RDCLK = _CLKSEL1 ? _RDCLKC1 : _RDCLKP1;

`ifdef FAST_FUNC
//----- Timing No Check

`else

//----- RO Control
reg notifier_rd, notifier_ad;

always @ ( notifier_ad ) begin
  QNS_ROX;
  ROX_flag = 1'b1;
end

always @ ( notifier_rd ) begin
  QNS_ROX_DIRECT;
end

//----- SPECIFY

// READ (SUB SIGNAL CONTOROL)
always @( negedge _SUB ) begin
  if ( ($time > 0) && (CIBRead_act===1'b1 || RDMRG_act===1'b1) && _SACEEN===1'b1 ) begin  //v2.00
    SUBRDCLK = 1'b1;
  end
end

//v2.00
//always @( negedge RDCLK ) begin
//  if (($time > 0) && (CIBRead_act===1'b1 || RDMRG_act===1'b1) && SUBRDCLK===1'b1) begin
//    EdgeLCount = EdgeLCount + 1;
//  end
//end

//always @( EdgeLCount ) begin
//  if (($time > 0) && EdgeLCount >= 2 ) begin
//    EdgeLCount = 0;
//    #1 SUBRDCLK = 1'b0;
//  end
//end

//v2.00
always @( negedge RDCLK ) begin
  if (($time > 0) && (CIBRead_act===1'b1 || RDMRG_act===1'b1) && SUBRDCLK===1'b1) begin
    EdgeLCount = EdgeLCount + 1;
  end
  if (($time > 0) && EdgeLCount >= 2 ) begin
    EdgeLCount = 0;
    #1 SUBRDCLK = 1'b0;
  end
end

buf (TRMRD12B, _TRMRD1===1'b0 &&  _TRMRD2===1'b0 && EWR_act===1'b1 ? 1'b1 : 1'b0);

//OTHER
buf (tmpDMY, 1'b0);
and (tmpCLKSEL,  _CLKSEL1, TRMRD12B);
and (tmpCLKSELB, ~_CLKSEL1, TRMRD12B);
and (tmpDIS,  IDIS, TRMRD12B);
and (tmpCLKSELDIS,  IDIS,  _CLKSEL1, TRMRD12B);
and (tmpCLKSELBDIS, IDIS, ~_CLKSEL1, TRMRD12B);
and (tmpLSPB, ~_LOWSPY, TRMRD12B);
and (tmpLSP,   _LOWSPY, TRMRD12B);
and (tmpCPTB, ~_CPT, TRMRD12B);
buf (DISmode, IDIS);

and (tmpCLKSELALLRD,   _CLKSEL1,  ((TRMRD12B & (|{FCBRead_act,CIBRead_act,RDMRG_act,MRG_act,ION_act,ST_act}===1'b1)) |  // v1.01
     (_TRMRD1===1'b0 & _TRMRD2===1'b0 & BTmode_act===1'b1)));
and (tmpCLKSELBALLRD, ~_CLKSEL1, TRMRD12B, (|{FCBRead_act,CIBRead_act,RDMRG_act,MRG_act,ION_act,ST_act}===1'b1));  // v1.01
or (tmpRDCLKC1, tmpCLKSELALLRD, (_TRMRD1===1'b0 & _TRMRD2===1'b0 & (stmpSCAN | btmpBT)));

//READ/RDMRG0/RDMRG1/RDMRGC
or (RDorRDM, _READ, _RDMRG0, _RDMRG1, _RDMRGC);
buf (rtmpRDorRDMHS, ({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===7'b1100011 ? 1'b1: 1'b0));
buf (rtmpRDorRDMLS, ({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===7'b1000011 ? 1'b1: 1'b0));
buf (rtmpCLKSELRDorRDMHS, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===8'b11100011 ? 1'b1: 1'b0));
buf (rtmpCLKSELBRDorRDMHS, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===8'b10100011 ? 1'b1: 1'b0));
buf (rtmpCLKSELRDorRDMSUB, ({RDorRDM,_CLKSEL1,_SUB,_SACEEN,TRMRD12B}===5'b11111 ? 1'b1: 1'b0));
buf (rtmpRDorRDMLP, ({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===7'b1010011 ? 1'b1: 1'b0));
buf (rtmpRDorRDMLV, ({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===7'b1001011 ? 1'b1: 1'b0));
buf (rtmpRDorRDMLV2, ({RDorRDM,_HISPEED,_LOWPOWER,_RLOWSPY,(_SUB | SUBRDCLK),_SACEEN,TRMRD12B}===7'b1001011 ? 1'b1: 1'b0));
//##READ Other
buf (rtmpCLKSELRDLV,({_READ,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===8'b11001011 ? 1'b1: 1'b0));
buf (rtmpCLKSELRDCELV,({_READ,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,_CE,TRMRD12B}===9'b110010111 ? 1'b1: 1'b0));

buf (rtmpCLKSELRDorRDMLV,({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===8'b11001011 ? 1'b1: 1'b0));
buf (rtmpCLKSELBRDorRDMLV,({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===8'b10001011 ? 1'b1: 1'b0));

//##From SUB to LV or SUB tAS/tAH/tCES/tCEH Check
buf (rtmpCLKSELRDorRDMLV2, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,(_SUB | SUBRDCLK),_SACEEN,TRMRD12B}===8'b11001011 ? 1'b1: 1'b0));
buf (rtmpCLKSELBRDorRDMLV2, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,(_SUB | SUBRDCLK),_SACEEN,TRMRD12B}===8'b10001011 ? 1'b1: 1'b0));

//##From SUB to HS/LS/LV/LP
and (rtmpCLKSELRDorRDMSUBtoHS, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===8'b11100011 ? 1'b1: 1'b0), SUBRDCLK);
and (rtmpCLKSELRDorRDMSUBtoLS, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===8'b11000011 ? 1'b1: 1'b0), SUBRDCLK);
and (rtmpCLKSELRDorRDMSUBtoLP, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===8'b11010011 ? 1'b1: 1'b0), SUBRDCLK);
and (rtmpCLKSELRDorRDMSUBtoLV, ({RDorRDM,_CLKSEL1,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,TRMRD12B}===8'b11001011 ? 1'b1: 1'b0), SUBRDCLK);

//## SACEEN=L CE=L
buf (rtmpRDorRDMSACB, ({_READ,_CE,_SACEEN,TRMRD12B}===4'b1001 ? 1'b1: 1'b0));

//##C1/P1 COMMON
and (rtmpRD,       _READ, TRMRD12B);
and (rtmpRDSAC,    _READ, _SACEEN, TRMRD12B);
and (rtmpRDCESAC,  _READ, _CE, _SACEEN, TRMRD12B);

buf (rtmpRDCEHS,({_READ,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,_CE,TRMRD12B}===8'b11000111 ? 1'b1: 1'b0));
buf (rtmpRDCELS,({_READ,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,_CE,TRMRD12B}===8'b10000111 ? 1'b1: 1'b0));
buf (rtmpRDCELP,({_READ,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,_CE,TRMRD12B}===8'b10100111 ? 1'b1: 1'b0));
buf (rtmpRDCELV,({_READ,_HISPEED,_LOWPOWER,_RLOWSPY,_SUB,_SACEEN,_CE,TRMRD12B}===8'b10010111 ? 1'b1: 1'b0));
buf (rtmpRDCESUB, ({_READ,_CLKSEL1,_SUB,_SACEEN,_CE,TRMRD12B}===6'b111111 ? 1'b1: 1'b0));
buf (rtmpRDSACB,({_READ,_CE,_SACEEN,TRMRD12B}===4'b1001 ? 1'b1: 1'b0));

//##COMMON
and (rtmpCLKSELRDSAC,   _CLKSEL1, _READ, _SACEEN, TRMRD12B);
and (rtmpCLKSELBRDSAC, ~_CLKSEL1, _READ, _SACEEN, TRMRD12B);

//WRITE
and (wtmpWRITE_EN, (_WWR | _MSWR), TRMRD12B);
and (wtmpCLKSELBWW,  _WWR, ~_CLKSEL1,TRMRD12B);
and (wtmpCLKSELBMW,  _MSWR,~_CLKSEL1,TRMRD12B);
and (wtmpWWLSP,   _WWR,  _LOWSPY, TRMRD12B);
and (wtmpWWLSPB,  _WWR, ~_LOWSPY, TRMRD12B);
and (wtmpMWLSP,   _MSWR,  _LOWSPY, TRMRD12B);
and (wtmpMWLSPB,  _MSWR, ~_LOWSPY, TRMRD12B);

//ERASE
and (etmpERASE_EN, (_SER | _CER | _EXER), TRMRD12B);
and (etmpCLKSELBSER, _SER, ~_CLKSEL1,TRMRD12B);
and (etmpCLKSELBCER, _CER, ~_CLKSEL1,TRMRD12B);
and (etmpCLKSELBEXER,_EXER,~_CLKSEL1,TRMRD12B);
and (EXERmode_sacb, etmpCLKSELBEXER, ~_SACEEN,  TRMRD12B);
and (CERmode_sacb, etmpCLKSELBCER, ~_SACEEN,  TRMRD12B);

//MRG FCBRead
and (mtmpMRGWVB,  (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12), ~_LOWSPY, TRMRD12B);
and (mtmpMRGWV,   (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12),  _LOWSPY, TRMRD12B);
and (mtmpMRGCELWVB,  (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12), intce, ~_LOWSPY, TRMRD12B);
and (mtmpMRGCELWV,   (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12), intce,  _LOWSPY, TRMRD12B);
and (mtmpMRG,  (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12), TRMRD12B);
and (mtmpMRGCEL,  (_MRG00 | _MRG01 | _MRG10 | _MRG11 | _MRG12), intce, TRMRD12B);

//READ MARGIN CHECK0/1
//##C1/P1 COMMON
and (rmtmpRDM,    (_RDMRG0 | _RDMRG1), TRMRD12B);
and (rmtmpRDMSAC,    (_RDMRG0 | _RDMRG1), _SACEEN, TRMRD12B);
and (rmtmpRDMCESAC,    (_RDMRG0 | _RDMRG1), _CE, _SACEEN, TRMRD12B);
and (rmtmpRDMCEBSACB,    (_RDMRG0 | _RDMRG1), ~_CE, ~_SACEEN, TRMRD12B);

//ION CHECK1
and (itmpION,    _IONCHK1,    TRMRD12B );
and (itmpIONCE,  _IONCHK1,    _CE,  TRMRD12B );

//READ MARGIN CHECK
//##C1/P1 COMMON
and (rmtmpRDMC,    _RDMRGC, TRMRD12B);
and (rmtmpRDMCSAC,    _RDMRGC, _SACEEN, TRMRD12B);
and (rmtmpRDMCCESAC,    _RDMRGC, _CE, _SACEEN, TRMRD12B);
and (rmtmpRDMCCEBSACB,    _RDMRGC, ~_CE, ~_SACEEN, TRMRD12B);

//STCHK
and ( sttmpSTC,    _STCHK,    TRMRD12B );
and ( sttmpSTCCE,    _STCHK,  _CE,  TRMRD12B );
//WDT1/2/3/4
and (dtmpWDT1, _WDT1, TRMRD12B);
and (dtmpWDT2, _WDT2, TRMRD12B);
and (dtmpWDT3, _WDT3, TRMRD12B);
and (dtmpWDT4, _WDT4, TRMRD12B);
//RDT
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
specparam _TCLKHls = 50000:50000:50000;   //v1.03 55ns -> 50ns
specparam _TCYCls = 105000:105000:105000;  //v2.00

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
specparam _TCLKLlv = 121000:121000:121000;  //v2.00
specparam _TCLKHlv = 121000:121000:121000;  //v2.00
specparam _TCYClv = 242000:242000:242000;  //v2.00

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
specparam _TRDSTOP21v = 4000:4000:4000;  //v2.00
specparam _TRDSTOP18v = 12000:12000:12000;  //v2.00
specparam _TRDSTOP16v = 15000:15000:15000;  //v2.00

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
specparam _TSRCUTSrd16v = 2500000:2500000:2500000;  //v2.00
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
specparam _TMSion =0:0:0;  //v2.00
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

/*-----TimingArc-----*/
//COMMON SDF Annotate
//##COMMON tOD/tOH
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO0 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO1 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO2 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO3 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO4 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO5 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO6 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO7 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO8 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO9 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO10 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO11 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO12 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO13 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO14 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO15 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO16 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO17 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO18 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO19 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO20 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO21 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO22 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO23 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO24 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO25 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO26 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO27 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO28 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO29 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO30 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO31 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO32 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO33 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO34 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO35 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO36 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpRDCLKC1) ( negedge RDCLKC1 => ( RO37 : RDCLKC1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );

  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO0 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO1 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO2 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO3 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO4 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO5 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO6 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO7 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO8 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO9 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO10 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO11 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO12 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO13 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO14 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO15 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO16 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO17 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO18 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO19 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO20 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO21 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO22 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO23 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO24 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO25 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO26 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO27 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO28 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO29 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO30 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO31 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO32 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO33 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO34 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO35 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO36 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );
  if(tmpCLKSELBALLRD) ( negedge RDCLKP1 => ( RO37 : RDCLKP1 ) ) = ( _TOD21v, _TOD21v, _TOH, _TOH, _TOH, _TOH );

//##ALL Reading Mode tAS/tEXAS/tCES Check
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A2, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A2, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A3, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A3, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A4, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A4, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A5, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A5, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A6, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A6, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A7, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A7, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A8, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A8, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A9, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A9, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A10, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A10, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A11, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A11, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A12, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A12, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A13, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A13, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A14, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A14, _TAS, _DMY, notifier_ad );

  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A2, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A2, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A3, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A3, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A4, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A4, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A5, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A5, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A6, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A6, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A7, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A7, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A8, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A8, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A9, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A9, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A10, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A10, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A11, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A11, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A12, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A12, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A13, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A13, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A14, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A14, _TAS, _DMY, notifier_ad );

  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge BFA, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge BFA, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge EXA, _TEXAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge EXA, _TEXAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , negedge CE, _TCES, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& tmpCLKSELALLRD , posedge CE, _TCES, _DMY, notifier_ad );

  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge BFA, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge BFA, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge EXA, _TEXAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge EXA, _TEXAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge CE, _TCES, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge CE, _TCES, _DMY, notifier_ad );

//##ALL Reading Mode tAH/tEXAH/tCEH Check
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A2, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A2, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A3, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A3, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A4, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A4, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A5, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A5, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A6, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A6, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A7, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A7, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A8, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A8, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A9, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A9, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A10, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A10, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A11, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A11, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A12, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A12, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A13, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A13, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge A14, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge A14, _DMY, _TAH21v, notifier_ad );

  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A2, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A2, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A3, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A3, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A4, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A4, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A5, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A5, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A6, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A6, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A7, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A7, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A8, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A8, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A9, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A9, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A10, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A10, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A11, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A11, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A12, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A12, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A13, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A13, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge A14, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge A14, _DMY, _TAH21v, notifier_ad );

  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge BFA, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge BFA, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge CE, _DMY, _TCEH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge CE, _DMY, _TCEH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , negedge EXA, _DMY, _TEXAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& tmpCLKSELALLRD , posedge EXA, _DMY, _TEXAH21v, notifier_ad );

  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge BFA, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge BFA, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge CE, _DMY, _TCEH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge CE, _DMY, _TCEH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , negedge EXA, _DMY, _TEXAH21v, notifier_ad );
  $setuphold ( posedge RDCLKP1 &&& tmpCLKSELBALLRD , posedge EXA, _DMY, _TEXAH21v, notifier_ad );

//##SCAN-mode
  $setuphold (negedge RDCLKC1 &&& stmpSCAN, posedge SCANIN, _TSCNIS, _TSCNIH);
  $setuphold (negedge RDCLKC1 &&& stmpSCAN, negedge SCANIN, _TSCNIS, _TSCNIH);

//READ
//##COMMON
  $setuphold ( negedge _RDCLKP1 &&& rtmpCLKSELBRDSAC, negedge _CLKSEL1, _TCLKSEL1S, _DMY, notifier_rd );
  $setuphold ( negedge _RDCLKC1 &&& rtmpCLKSELRDSAC,  posedge _CLKSEL1, _TCLKSEL1S, _DMY, notifier_rd );
//D  $setuphold ( negedge _RDCLKP1 &&& rtmpCLKSELBRDSAC, negedge _DCLKSEL1, _TCLKSEL1S, _DMY, notifier_rd );
//D  $setuphold ( negedge _DRDCLKC1 &&& rtmpCLKSELRDSAC, posedge _DCLKSEL1, _TCLKSEL1S, _DMY, notifier_rd );

//##LowSpeed
  $width ( negedge RDCLK &&& rtmpRDorRDMLS , _TCLKLls, 0, notifier_rd );
  $width ( posedge RDCLK &&& rtmpRDorRDMLS , _TCLKHls, 0, notifier_rd );
  $period ( posedge RDCLK &&& rtmpRDorRDMLS , _TCYCls, notifier_rd );
  $period ( negedge RDCLK &&& rtmpRDorRDMLS , _TCYCls, notifier_rd );

//##HiSpeed ##SDF Annotate
`ifdef QNSA_USE_VDD_18V
//## NO Annotate
  $width ( negedge RDCLK &&& rtmpRDorRDMHS , _TCLKLhs18v, 0, notifier_rd );
  $width ( posedge RDCLK &&& rtmpRDorRDMHS , _TCLKHhs18v, 0, notifier_rd );
  $period ( posedge RDCLK &&& rtmpRDorRDMHS , _TCYChs18v, notifier_rd ); 
  $period ( negedge RDCLK &&& rtmpRDorRDMHS , _TCYChs18v, notifier_rd );
  
`else
  $width ( negedge RDCLKC1 &&& rtmpCLKSELRDorRDMHS , _TCLKLhs32, 0, notifier_rd );
  $width ( posedge RDCLKC1 &&& rtmpCLKSELRDorRDMHS , _TCLKHhs32, 0, notifier_rd );
  $period ( posedge RDCLKC1 &&& rtmpCLKSELRDorRDMHS , _TCYChs32, notifier_rd );
  $period ( negedge RDCLKC1 &&& rtmpCLKSELRDorRDMHS , _TCYChs32, notifier_rd );

//D  $width ( negedge RDCLK &&& rtmpCLKSELRDorRDMHS , _TCLKLhs16, 0, notifier_rd );
//D  $width ( posedge RDCLK &&& rtmpCLKSELRDorRDMHS , _TCLKHhs16, 0, notifier_rd );
//D  $period ( posedge RDCLK &&& rtmpCLKSELRDorRDMHS , _TCYChs16, notifier_rd );
//D  $period ( negedge RDCLK &&& rtmpCLKSELRDorRDMHS , _TCYChs16, notifier_rd );

  $width ( negedge RDCLKP1 &&& rtmpCLKSELBRDorRDMHS , _TCLKLhs32, 0, notifier_rd );
  $width ( posedge RDCLKP1 &&& rtmpCLKSELBRDorRDMHS , _TCLKHhs32, 0, notifier_rd );
  $period ( posedge RDCLKP1 &&& rtmpCLKSELBRDorRDMHS , _TCYChs32, notifier_rd );
  $period ( negedge RDCLKP1 &&& rtmpCLKSELBRDorRDMHS , _TCYChs32, notifier_rd );
`endif

  $width ( negedge RDCLK &&& rtmpRDorRDMHS , _TCLKLhs32, 0, notifier_rd );
  $width ( posedge RDCLK &&& rtmpRDorRDMHS , _TCLKHhs32, 0, notifier_rd );
  $period ( posedge RDCLK &&& rtmpRDorRDMHS , _TCYChs32, notifier_rd );
  $period ( negedge RDCLK &&& rtmpRDorRDMHS , _TCYChs32, notifier_rd );

//##Sub
  $width ( negedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUB , _TCLKLsub, 0, notifier_rd );
  $width ( posedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUB , _TCLKHsub, 0, notifier_rd );
  $period ( posedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUB , _TCYCsub, notifier_rd );
  $period ( negedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUB , _TCYCsub, notifier_rd );

//##LowPower
  $width ( negedge RDCLK &&& rtmpRDorRDMLP , _TCLKLlp, 0, notifier_rd );
  $width ( posedge RDCLK &&& rtmpRDorRDMLP , _TCLKHlp, 0, notifier_rd );
  $period ( posedge RDCLK &&& rtmpRDorRDMLP , _TCYClp, notifier_rd );
  $period ( negedge RDCLK &&& rtmpRDorRDMLP , _TCYClp, notifier_rd );

//##LowVoltage ##SDF Annotate
  $width ( negedge RDCLKC1 &&& rtmpCLKSELRDorRDMLV , _TCLKLlv, 0, notifier_rd );
  $width ( posedge RDCLKC1 &&& rtmpCLKSELRDorRDMLV , _TCLKHlv, 0, notifier_rd );
  $period ( posedge RDCLKC1 &&& rtmpCLKSELRDorRDMLV , _TCYClv, notifier_rd );
  $period ( negedge RDCLKC1 &&& rtmpCLKSELRDorRDMLV , _TCYClv, notifier_rd );

//D  $width ( negedge DRDCLKC1 &&& rtmpCLKSELRDorRDMLV , _TCLKLlv, 0, notifier_rd );
//D  $width ( posedge DRDCLKC1 &&& rtmpCLKSELRDorRDMLV , _TCLKHlv, 0, notifier_rd );
//D  $period ( posedge DRDCLKC1 &&& rtmpCLKSELRDorRDMLV , _TCYClv, notifier_rd );
//D  $period ( negedge DRDCLKC1 &&& rtmpCLKSELRDorRDMLV , _TCYClv, notifier_rd );

  $width ( negedge RDCLKP1 &&& rtmpCLKSELBRDorRDMLV , _TCLKLlv, 0, notifier_rd );
  $width ( posedge RDCLKP1 &&& rtmpCLKSELBRDorRDMLV , _TCLKHlv, 0, notifier_rd );
  $period ( posedge RDCLKP1 &&& rtmpCLKSELBRDorRDMLV , _TCYClv, notifier_rd );
  $period ( negedge RDCLKP1 &&& rtmpCLKSELBRDorRDMLV , _TCYClv, notifier_rd );

  $width ( negedge RDCLK &&& rtmpRDorRDMLV , _TCLKLlv, 0, notifier_rd );
  $width ( posedge RDCLK &&& rtmpRDorRDMLV , _TCLKHlv, 0, notifier_rd );
  $period ( posedge RDCLK &&& rtmpRDorRDMLV , _TCYClv, notifier_rd );
  $period ( negedge RDCLK &&& rtmpRDorRDMLV , _TCYClv, notifier_rd );

//##Triming Code Read 1/2/3  ## For Code FLASH ONLY
  $setuphold (negedge _RDCLKC1 &&& rtmpCLKSELRDLV, negedge _TRMRD2, _TMStrm, _DMY, notifier_rd);

  $setuphold (negedge _TRMRD2, _TRMCP10, _TTRMCPStrm, _DMY, notifier_rd);
  $setuphold (negedge _TRMRD2, _TRMCP11, _TTRMCPStrm, _DMY, notifier_rd);
  $setuphold (negedge _TRMRD2, _TRMCP12, _TTRMCPStrm, _DMY, notifier_rd);
  $setuphold (negedge _TRMRD2, _TRMCP13, _TTRMCPStrm, _DMY, notifier_rd);
  $setuphold (negedge _TRMRD2, _TRMCP14, _TTRMCPStrm, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rtmpRDCELV, negedge _SRCUTCP, _TSRCUTStrm, _DMY, notifier_rd);

//##Reset Release Timing
  $width (posedge _SRCUT &&& rtmpRD, _TSRCUTWtrm, 0, notifier_rd );

  $setuphold (negedge RDCLK &&& rtmpRDCESAC, _TRMCP10, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCESAC, _TRMCP11, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCESAC, _TRMCP12, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCESAC, _TRMCP13, _TTRMCPSrd, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCESAC, _TRMCP14, _TTRMCPSrd, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rtmpRDCESAC, _R0FLAGZ, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rtmpRDCESAC, _R0A0, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rtmpRDCESAC, _R0A1, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rtmpRDCESAC, _R0A2, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rtmpRDCESAC, _R0A3, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rtmpRDCESAC, _R0A4, _TRDNS, _DMY, notifier_ad);

  $setuphold (negedge RDCLK &&& rtmpRDCEHS, posedge _HISPEED, _THISPEEDS, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCELS, negedge _RLOWSPY, _TLSPDS, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCELP, posedge _LOWPOWER, _TLOWPOWERS, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rtmpRDSAC, _HISPEED, _THSPDS, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDSAC, _RLOWSPY, _TRLSPYS, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDSAC, _LOWPOWER, _TLPWRS, _DMY, notifier_rd);

//##STOP Control
  $setuphold (negedge RDCLK &&& rtmpRDCEHS, negedge _FLSTOP, _TSTOPhs, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCELV, negedge _FLSTOP, _TSTOPlv, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCELS, negedge _FLSTOP, _TSTOPls, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCELP, negedge _FLSTOP, _TSTOPlp, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rtmpRDorRDMHS, posedge _FLSTOP, _DMY, _TRDSTOP21v, notifier_rd);  //v2.00
  $setuphold (negedge RDCLK &&& rtmpRDorRDMLS, posedge _FLSTOP, _DMY, _TRDSTOP18v, notifier_rd);  //v2.00
  $setuphold (negedge RDCLK &&& rtmpRDorRDMLP, posedge _FLSTOP, _DMY, _TRDSTOP18v, notifier_rd);  //v2.00
  $setuphold (negedge RDCLK &&& rtmpRDorRDMLV, posedge _FLSTOP, _DMY, _TRDSTOP16v, notifier_rd);  //v2.00

//##DIS => READ
  $setuphold (negedge RDCLK &&& rtmpRDCEHS, negedge DISmode, _TMShs, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCELV, negedge DISmode, _TMSlv, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCELS, negedge DISmode, _TMSls, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDCELP, negedge DISmode, _TMSlp, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rtmpRDCELV, posedge _RLOWSPY, _TLSPYS, _DMY, notifier_rd);

//##HS/LV/LS/LP => Sub
  $setuphold (negedge _RDCLKC1 &&& rtmpCLKSELRDSAC, _SUB, _TSUBT, _DMY, notifier_rd);

  $width (negedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoHS , _TCLKLsub, 0, notifier_rd);  //HS
  $width (posedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoHS , _TCLKHsub, 0, notifier_rd);  //HS
  $period (negedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoHS , _TCYCsub, notifier_rd);  //HS

  $width (negedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoLS , _TCLKLsub, 0, notifier_rd);  //LS
  $width (posedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoLS , _TCLKHsub, 0, notifier_rd);  //LS
  $period (negedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoLS , _TCYCsub, notifier_rd);  //LS

  $width (negedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoLV , _TCLKLsub, 0, notifier_rd);  //LV
  $width (posedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoLV , _TCLKHsub, 0, notifier_rd);  //LV
  $period (negedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoLV , _TCYCsub, notifier_rd);  //LV

  $width (negedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoLP , _TCLKLsub, 0, notifier_rd);  //LP
  $width (posedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoLP , _TCLKHsub, 0, notifier_rd);  //LP
  $period (negedge _RDCLKC1 &&& rtmpCLKSELRDorRDMSUBtoLP , _TCYCsub, notifier_rd);  //LP

//##SRCUT Control
  $setuphold (negedge RDCLK &&& rtmpRDCEHS, negedge _SRCUT, _TSRCUTSrd21v, _DMY, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDCELS, negedge _SRCUT, _TSRCUTSrd18v, _DMY, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDCELP, negedge _SRCUT, _TSRCUTSrd18v, _DMY, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDCESUB, negedge _SRCUT, _TSRCUTSrd18v, _DMY, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDCELV, negedge _SRCUT, _TSRCUTSrd16v, _DMY, notifier_rd );  //v2.00
  $setuphold (negedge RDCLK &&& rtmpRDCEHS,  posedge _SRCUT, _DMY, _TSRCUTHrd, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDCELS,  posedge _SRCUT, _DMY, _TSRCUTHrd, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDCELP,  posedge _SRCUT, _DMY, _TSRCUTHrd, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDCESUB, posedge _SRCUT, _DMY, _TSRCUTHrd, notifier_rd );
  $setuphold (negedge RDCLK &&& rtmpRDCELV,  posedge _SRCUT, _DMY, _TSRCUTHrd, notifier_rd );  //v2.00

//##SACEEN Control
  $width ( negedge RDCLK &&& rtmpRDorRDMSACB , _TCLKLsac, 0, notifier_rd );
  $width ( posedge RDCLK &&& rtmpRDorRDMSACB , _TCLKHsac, 0, notifier_rd );

  $setuphold (negedge RDCLK &&& rtmpRDSACB, _SACEEN, _TSACEENSsac, _TSACEENHsac, notifier_rd);

  $setuphold (negedge RDCLK &&& rtmpRDSACB, _TRMCP10, _TTRMCPSsac, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDSACB, _TRMCP11, _TTRMCPSsac, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDSACB, _TRMCP12, _TTRMCPSsac, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDSACB, _TRMCP13, _TTRMCPSsac, _TTRMCPHsac, notifier_rd);
  $setuphold (negedge RDCLK &&& rtmpRDSACB, _TRMCP14, _TTRMCPSsac, _TTRMCPHsac, notifier_rd);

//  $setuphold (negedge RDCLK &&& rtmpRDSACB, _R0FLAGZ, _TRDNS, _TRDNH, notifier_ad);
//  $setuphold (negedge RDCLK &&& rtmpRDSACB, _R0A0, _TRDNS, _TRDNH, notifier_ad);
//  $setuphold (negedge RDCLK &&& rtmpRDSACB, _R0A1, _TRDNS, _TRDNH, notifier_ad);
//  $setuphold (negedge RDCLK &&& rtmpRDSACB, _R0A2, _TRDNS, _TRDNH, notifier_ad);
//  $setuphold (negedge RDCLK &&& rtmpRDSACB, _R0A3, _TRDNS, _TRDNH, notifier_ad);
//  $setuphold (negedge RDCLK &&& rtmpRDSACB, _R0A4, _TRDNS, _TRDNH, notifier_ad);

//CWEE Control
  $setuphold (negedge DISmode, _CWEE, _TCWEES, _DMY);
  $setuphold (posedge DISmode, _CWEE, _DMY, _TCWEEH);

//WR/ER/OTHER COMMON
  $setuphold (negedge DISmode, _LOWSPY, _TLOWSPYS, _DMY);
  $setuphold (posedge DISmode, _LOWSPY, _DMY, _TLOWSPYH);

  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _BEU0, _TBEUS, _TBEUH);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _BEU1, _TBEUS, _TBEUH);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _BEU2, _TBEUS, _TBEUH);

//WORD WRITE
  $setuphold (negedge _RDCLKP1 &&& tmpCLKSELB, posedge DISmode, _TMSww, _DMY );

  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW0, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW1, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW2, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW3, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW4, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW5, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW6, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW7, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW8, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW9, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW10, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW11, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW12, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW13, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW14, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW15, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW16, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW17, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW18, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW19, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW20, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW21, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW22, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW23, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW24, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW25, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW26, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW27, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW28, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW29, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW30, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW31, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW32, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW33, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW34, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW35, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW36, _TDWSww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWRITE_EN, _DW37, _TDWSww, _DMY );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW0, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW1, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW2, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW3, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW4, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW5, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW6, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW7, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW8, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW9, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW10, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW11, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW12, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW13, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW14, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW15, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW16, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW17, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW18, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW19, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW20, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW21, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW22, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW23, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW24, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW25, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW26, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW27, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW28, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW29, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW30, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW31, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW32, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW33, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW34, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW35, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW36, _DMY, _TDWHww );
  $setuphold (negedge _FCLK1 &&& wtmpWRITE_EN, _DW37, _DMY, _TDWHww );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW0, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW1, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW2, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW3, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW4, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW5, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW6, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW7, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW8, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW9, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW10, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW11, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW12, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW13, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW14, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW15, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW16, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW17, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW18, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW19, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW20, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW21, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW22, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW23, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW24, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW25, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW26, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW27, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW28, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW29, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW30, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW31, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW32, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW33, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW34, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW35, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW36, _TDWSww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWRITE_EN, _DW37, _TDWSww, _DMY );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW0, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW1, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW2, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW3, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW4, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW5, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW6, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW7, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW8, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW9, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW10, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW11, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW12, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW13, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW14, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW15, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW16, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW17, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW18, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW19, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW20, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW21, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW22, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW23, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW24, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW25, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW26, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW27, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW28, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW29, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW30, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW31, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW32, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW33, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW34, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW35, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW36, _DMY, _TDWHww );
  $setuphold (negedge _FCLK2 &&& wtmpWRITE_EN, _DW37, _DMY, _TDWHww );

  $setuphold (negedge _FCLK1 &&& TRMRD12B, negedge _WWR, _DMY, _TMHww );
  $setuphold (negedge _FCLK2 &&& TRMRD12B, negedge _WWR, _DMY, _TMHww );

  $width (negedge _RDCLKP1 &&& tmpCLKSELBDIS, _TCLKLww );

  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELB, posedge _WWR, _DMY, _TRDWww );

  $setuphold (posedge RDCLK &&& tmpDIS, _CE, _TCESww, _TCEHww);  //For IONCHK1 RDMRGC STCHK

  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A2, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A3, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A4, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A5, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A6, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A7, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A8, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A9, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A10, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A11, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A12, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A13, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _A14, _TASww, _TAHww);
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELBDIS, _BFA, _TASww, _TAHww);
  $setuphold (posedge RDCLK &&& tmpDIS, _EXA, _TASww, _TAHww);  //For IONCHK1 RDMRGC STCHK

  $width (posedge _FCLK1 &&& wtmpCLKSELBWW, _TPWww);
  $width (posedge _FCLK2 &&& wtmpCLKSELBWW, _TPWww);
  $setup (negedge _FCLK1, posedge _FCLK2 &&& wtmpCLKSELBWW, _TPWLww);  //Unused $setuphold
  $setup (negedge _FCLK2, posedge _FCLK1 &&& wtmpCLKSELBWW, _TPWLww);  //Unused $setuphold

  $width (posedge _PROGI &&& wtmpCLKSELBWW, _TPROGIww );
  $setuphold (posedge _PROGI &&& TRMRD12B, posedge _WWR, _TPROGISww, _DMY ); //1ps
  $setuphold (posedge _PROGI &&& wtmpCLKSELBWW, negedge DISmode, _TPROGISww, _DMY ); //1ps
  $setuphold (posedge _FCLK1 &&& wtmpWWLSPB, negedge _PROGI, _TPROGIWPww, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpWWLSP, negedge _PROGI, _TPROGIWPww18v, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWWLSPB, negedge _PROGI, _TPROGIWPww, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpWWLSP, negedge _PROGI, _TPROGIWPww18v, _DMY );

  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP10, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP11, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP12, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP13, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSPB, _TRMCP14, _TTRMCPSww, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP10, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP11, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP12, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP13, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _WWR &&& tmpLSP, _TRMCP14, _TTRMCPSww18v, _DMY);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP10, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP11, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP12, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP13, _DMY, _TTRMCPHww);
  $setuphold (negedge _WWR &&& TRMRD12B, _TRMCP14, _DMY, _TTRMCPHww);

  $setuphold (posedge _WWR &&& TRMRD12B, _R0FLAGZ, _TRDNS, _DMY);
  $setuphold (negedge _WWR &&& TRMRD12B, _R0FLAGZ, _DMY, _TRDNH);

  $setuphold (posedge _WWR &&& TRMRD12B, _R0A0, _TRDNS, _DMY);
  $setuphold (posedge _WWR &&& TRMRD12B, _R0A1, _TRDNS, _DMY);
  $setuphold (posedge _WWR &&& TRMRD12B, _R0A2, _TRDNS, _DMY);
  $setuphold (posedge _WWR &&& TRMRD12B, _R0A3, _TRDNS, _DMY);
  $setuphold (posedge _WWR &&& TRMRD12B, _R0A4, _TRDNS, _DMY);
  $setuphold (negedge _WWR &&& TRMRD12B, _R0A0, _DMY, _TRDNH);
  $setuphold (negedge _WWR &&& TRMRD12B, _R0A1, _DMY, _TRDNH);
  $setuphold (negedge _WWR &&& TRMRD12B, _R0A2, _DMY, _TRDNH);
  $setuphold (negedge _WWR &&& TRMRD12B, _R0A3, _DMY, _TRDNH);
  $setuphold (negedge _WWR &&& TRMRD12B, _R0A4, _DMY, _TRDNH);

//## WORD WRITE(Add change amang this mode)
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _CE , _TCESww2, _DMY ); //Tces2=20ns
  $setuphold (posedge _RDCLKP1 &&& wtmpCLKSELBWW, _CE, _DMY, _TCEHww );

  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A2, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A3, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A4, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A5, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A6, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A7, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A8, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A9, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A10, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A11, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A12, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A13, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _A14, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _EXA, _TASww2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBWW, _BFA, _TASww2, _DMY);

  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A2, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A3, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A4, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A5, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A6, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A7, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A8, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A9, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A10, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A11, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A12, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A13, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _A14, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _EXA, _DMY, _TAHww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, _BFA, _DMY, _TAHww );

  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, posedge _FCLK1, _DMY, _TALWPww );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBWW, posedge _FCLK2, _DMY, _TALWPww );

  $setuphold ( negedge _RDCLKP1 &&& wtmpCLKSELBWW, negedge _FCLK1, _TWPRDww, _DMY );
  $setuphold ( negedge _RDCLKP1 &&& wtmpCLKSELBWW, negedge _FCLK2, _TWPRDww, _DMY );

  $width ( negedge _RDCLKP1 &&& wtmpCLKSELBWW, _TCLKLww );

//MULTI SELECT WRITE
  $setuphold (negedge _FCLK1 &&& TRMRD12B, negedge _MSWR, _DMY, _TMHm );
  $setuphold (negedge _FCLK2 &&& TRMRD12B, negedge _MSWR, _DMY, _TMHm );

  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELB, posedge _MSWR, _DMY, _TRDWm );

  $width (posedge _FCLK1 &&& wtmpCLKSELBMW, _TPWm);
  $width (posedge _FCLK2 &&& wtmpCLKSELBMW, _TPWm);
  $setup (negedge _FCLK1, posedge _FCLK2 &&& wtmpCLKSELBMW, _TPWLm);  //Unused $setuphold
  $setup (negedge _FCLK2, posedge _FCLK1 &&& wtmpCLKSELBMW, _TPWLm);  //Unused $setuphold

  $width (posedge _PROGI &&& wtmpCLKSELBMW, _TPROGIm );
  $setuphold (posedge _PROGI &&& TRMRD12B, posedge _MSWR, _TPROGISm, _DMY ); //1ps
  $setuphold (posedge _PROGI &&& wtmpCLKSELBMW, negedge DISmode, _TPROGISm, _DMY ); //1ps
  $setuphold (posedge _FCLK1 &&& wtmpMWLSPB, negedge _PROGI, _TPROGIWPm, _DMY );
  $setuphold (posedge _FCLK1 &&& wtmpMWLSP, negedge _PROGI, _TPROGIWPm18v, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpMWLSPB, negedge _PROGI, _TPROGIWPm, _DMY );
  $setuphold (posedge _FCLK2 &&& wtmpMWLSP, negedge _PROGI, _TPROGIWPm18v, _DMY );

  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP10, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP11, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP12, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP13, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSPB, _TRMCP14, _TTRMCPSww, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP10, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP11, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP12, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP13, _TTRMCPSww18v, _DMY);
  $setuphold (posedge _MSWR &&& tmpLSP, _TRMCP14, _TTRMCPSww18v, _DMY);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP10, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP11, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP12, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP13, _DMY, _TTRMCPHww);
  $setuphold (negedge _MSWR &&& TRMRD12B, _TRMCP14, _DMY, _TTRMCPHww);

  $setuphold (posedge _MSWR &&& TRMRD12B, _R0FLAGZ, _TRDNS, _DMY);
  $setuphold (negedge _MSWR &&& TRMRD12B, _R0FLAGZ, _DMY, _TRDNH);

  $setuphold (posedge _MSWR &&& TRMRD12B, _R0A0, _TRDNS, _DMY);
  $setuphold (posedge _MSWR &&& TRMRD12B, _R0A1, _TRDNS, _DMY);
  $setuphold (posedge _MSWR &&& TRMRD12B, _R0A2, _TRDNS, _DMY);
  $setuphold (posedge _MSWR &&& TRMRD12B, _R0A3, _TRDNS, _DMY);
  $setuphold (posedge _MSWR &&& TRMRD12B, _R0A4, _TRDNS, _DMY);
  $setuphold (negedge _MSWR &&& TRMRD12B, _R0A0, _DMY, _TRDNH);
  $setuphold (negedge _MSWR &&& TRMRD12B, _R0A1, _DMY, _TRDNH);
  $setuphold (negedge _MSWR &&& TRMRD12B, _R0A2, _DMY, _TRDNH);
  $setuphold (negedge _MSWR &&& TRMRD12B, _R0A3, _DMY, _TRDNH);
  $setuphold (negedge _MSWR &&& TRMRD12B, _R0A4, _DMY, _TRDNH);

//##MULTI SELECT WRITE(Add change amang this mode)
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _CE , _TCESm2, _DMY ); //Tces2=20ns
  $setuphold (posedge _RDCLKP1 &&& wtmpCLKSELBMW, _CE, _DMY, _TCEHm );

  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A2, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A3, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A4, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A5, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A6, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A7, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A8, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A9, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A10, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A11, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A12, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A13, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _A14, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _EXA, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _BFA, _TASm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _BEU0, _TBEUSm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _BEU1, _TBEUSm2, _DMY);
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW, _BEU2, _TBEUSm2, _DMY);

  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A2, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A3, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A4, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A5, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A6, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A7, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A8, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A9, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A10, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A11, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A12, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A13, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _A14, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _EXA, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _BFA, _DMY, _TAHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _BEU0, _DMY, _TBEUHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _BEU1, _DMY, _TBEUHm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, _BEU2, _DMY, _TBEUHm );

  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, posedge _FCLK1, _DMY, _TALWPm );
  $setuphold ( posedge _RDCLKP1 &&& wtmpCLKSELBMW, posedge _FCLK2, _DMY, _TALWPm );

  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW,  negedge _FCLK1, _TWPRDm, _DMY );
  $setuphold (negedge _RDCLKP1 &&& wtmpCLKSELBMW,  negedge _FCLK2, _TWPRDm, _DMY );

  $width ( negedge _RDCLKP1 &&& wtmpCLKSELBMW, _TCLKLm );

  $setuphold ( posedge _MSWR &&& TRMRD12B, _MEOC, _TMEOCS, _DMY );
  $setuphold ( negedge _MSWR &&& TRMRD12B, _MEOC, _DMY, _TMEOCH );

//CHIP ERASE/EXTRA ERASE
  $setuphold ( posedge _FCLK1 &&& TRMRD12B, posedge _CER, _TMSer, _DMY );
  $setuphold ( posedge _FCLK1 &&& TRMRD12B, posedge _EXER, _TMSer, _DMY );

  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _CER, _DMY, _TMHer );
  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _EXER, _DMY, _TMHer );

  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _CER, _DMY, _TRDEer );
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _EXER, _DMY, _TRDEer );

//  $width ( posedge _FCLK1 &&& _CER, _TPEer );
//  $width ( posedge _FCLK1 &&& _EXER, _TPEer );

  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP10, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP11, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP12, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP13, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSPB, _TRMCP14, _TTRMCPSer, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP10, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP11, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP12, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP13, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _CER &&& tmpLSP, _TRMCP14, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP10, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP11, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP12, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP13, _DMY, _TTRMCPHer);
  $setuphold (negedge _CER &&& TRMRD12B, _TRMCP14, _DMY, _TTRMCPHer);

  $setuphold (posedge _CER &&& TRMRD12B, _R0FLAGZ, _TRDNS, _DMY);
  $setuphold (negedge _CER &&& TRMRD12B, _R0FLAGZ, _DMY, _TRDNH);

  $setuphold (posedge _CER &&& TRMRD12B, _R0A0, _TRDNS, _DMY);
  $setuphold (posedge _CER &&& TRMRD12B, _R0A1, _TRDNS, _DMY);
  $setuphold (posedge _CER &&& TRMRD12B, _R0A2, _TRDNS, _DMY);
  $setuphold (posedge _CER &&& TRMRD12B, _R0A3, _TRDNS, _DMY);
  $setuphold (posedge _CER &&& TRMRD12B, _R0A4, _TRDNS, _DMY);
  $setuphold (negedge _CER &&& TRMRD12B, _R0A0, _DMY, _TRDNH);
  $setuphold (negedge _CER &&& TRMRD12B, _R0A1, _DMY, _TRDNH);
  $setuphold (negedge _CER &&& TRMRD12B, _R0A2, _DMY, _TRDNH);
  $setuphold (negedge _CER &&& TRMRD12B, _R0A3, _DMY, _TRDNH);
  $setuphold (negedge _CER &&& TRMRD12B, _R0A4, _DMY, _TRDNH);

  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP10, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP11, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP12, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP13, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSPB, _TRMCP14, _TTRMCPSer, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP10, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP11, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP12, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP13, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _EXER &&& tmpLSP, _TRMCP14, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP10, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP11, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP12, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP13, _DMY, _TTRMCPHer);
  $setuphold (negedge _EXER &&& TRMRD12B, _TRMCP14, _DMY, _TTRMCPHer);

  $setuphold (posedge _EXER &&& TRMRD12B, _R0FLAGZ, _TRDNS, _DMY);
  $setuphold (negedge _EXER &&& TRMRD12B, _R0FLAGZ, _DMY, _TRDNH);

  $setuphold (posedge _EXER &&& TRMRD12B, _R0A0, _TRDNS, _DMY);
  $setuphold (posedge _EXER &&& TRMRD12B, _R0A1, _TRDNS, _DMY);
  $setuphold (posedge _EXER &&& TRMRD12B, _R0A2, _TRDNS, _DMY);
  $setuphold (posedge _EXER &&& TRMRD12B, _R0A3, _TRDNS, _DMY);
  $setuphold (posedge _EXER &&& TRMRD12B, _R0A4, _TRDNS, _DMY);
  $setuphold (negedge _EXER &&& TRMRD12B, _R0A0, _DMY, _TRDNH);
  $setuphold (negedge _EXER &&& TRMRD12B, _R0A1, _DMY, _TRDNH);
  $setuphold (negedge _EXER &&& TRMRD12B, _R0A2, _DMY, _TRDNH);
  $setuphold (negedge _EXER &&& TRMRD12B, _R0A3, _DMY, _TRDNH);
  $setuphold (negedge _EXER &&& TRMRD12B, _R0A4, _DMY, _TRDNH);

//## CHIP ERASE/EXTRA ERASE (SACEEN signal control)
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELB, posedge EXERmode_sacb, _DMY, _TRDEersac );
  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELB, posedge CERmode_sacb, _DMY, _TRDEersac );

  $setuphold ( posedge _CER &&& TRMRD12B,  negedge _SACEEN , _TSACEENSer, _DMY );
  $setuphold ( posedge _EXER &&& TRMRD12B,  negedge _SACEEN , _TSACEENSer, _DMY );

  $setuphold ( negedge _CER &&& TRMRD12B, posedge _SACEEN, _DMY , _TSACEENHer );
  $setuphold ( negedge _EXER &&& TRMRD12B, posedge _SACEEN, _DMY , _TSACEENHer );

//## EXTRA ERASE (MEOR signal control)
  $setuphold ( posedge _EXER &&& TRMRD12B, _MEOR, _TMEORS, _DMY );
  $setuphold ( negedge _EXER &&& TRMRD12B, _MEOR, _DMY, _TMEORH );

//SECTOR ERASE
  $setuphold ( posedge _FCLK1 &&& TRMRD12B, posedge _SER, _TMSse, _DMY );

  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _SER, _DMY, _TMHse );

  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _SER, _DMY, _TRDEse );  

//  $width ( posedge _FCLK1 &&& _SER, _TPEse );

  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP10, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP11, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP12, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP13, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSPB, _TRMCP14, _TTRMCPSer, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP10, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP11, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP12, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP13, _TTRMCPSer18v, _DMY);
  $setuphold (posedge _SER &&& tmpLSP, _TRMCP14, _TTRMCPSer18v, _DMY);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP10, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP11, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP12, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP13, _DMY, _TTRMCPHer);
  $setuphold (negedge _SER &&& TRMRD12B, _TRMCP14, _DMY, _TTRMCPHer);
  
  $setuphold (posedge _SER &&& TRMRD12B, _R0FLAGZ, _TRDNS, _DMY);
  $setuphold (negedge _SER &&& TRMRD12B, _R0FLAGZ, _DMY, _TRDNH);

  $setuphold (posedge _SER &&& TRMRD12B, _R0A0, _TRDNS, _DMY);
  $setuphold (posedge _SER &&& TRMRD12B, _R0A1, _TRDNS, _DMY);
  $setuphold (posedge _SER &&& TRMRD12B, _R0A2, _TRDNS, _DMY);
  $setuphold (posedge _SER &&& TRMRD12B, _R0A3, _TRDNS, _DMY);
  $setuphold (posedge _SER &&& TRMRD12B, _R0A4, _TRDNS, _DMY);
  $setuphold (negedge _SER &&& TRMRD12B, _R0A0, _DMY, _TRDNH);
  $setuphold (negedge _SER &&& TRMRD12B, _R0A1, _DMY, _TRDNH);
  $setuphold (negedge _SER &&& TRMRD12B, _R0A2, _DMY, _TRDNH);
  $setuphold (negedge _SER &&& TRMRD12B, _R0A3, _DMY, _TRDNH);
  $setuphold (negedge _SER &&& TRMRD12B, _R0A4, _DMY, _TRDNH);

//MARGIN CHECK 00/01/10/11/12 & FCBRead
`ifdef QNSA_IV_10NS
  $setuphold (negedge RDCLK &&& mtmpMRGWVB, posedge _MRG01, _TMSmr, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRGWVB, posedge _MRG11, _TMSmr, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRGWVB, posedge _MRG12, _TMSmr, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRGWV, posedge _MRG01, _TMSmr18v, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRGWV, posedge _MRG11, _TMSmr18v, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRGWV, posedge _MRG12, _TMSmr18v, _DMY, notifier_rd);
`endif

  $setuphold ( posedge RDCLK &&& rtmpRD,  negedge _READ,  _DMY, _TMHmr );
  $setuphold ( posedge RDCLK &&& mtmpMRG, negedge _MRG00, _DMY, _TMHmr );
  $setuphold ( posedge RDCLK &&& mtmpMRG, negedge _MRG01, _DMY, _TMHmr );
  $setuphold ( posedge RDCLK &&& mtmpMRG, negedge _MRG10, _DMY, _TMHmr );
  $setuphold ( posedge RDCLK &&& mtmpMRG, negedge _MRG11, _DMY, _TMHmr );
  $setuphold ( posedge RDCLK &&& mtmpMRG, negedge _MRG12, _DMY, _TMHmr );

  $width ( negedge RDCLK &&& mtmpMRGWVB, _TCLKLmr, 0, notifier_rd);
  $width ( posedge RDCLK &&& mtmpMRGWVB, _TCLKHmr, 0, notifier_rd);
  $width ( negedge RDCLK &&& mtmpMRGWV, _TCLKLmr18v, 0, notifier_rd);
  $width ( posedge RDCLK &&& mtmpMRGWV, _TCLKHmr18v, 0, notifier_rd);

  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP10, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP11, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP12, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP13, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _TRMCP14, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP10, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP11, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP12, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP13, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& mtmpMRG, _TRMCP14, _DMY, _TTRMCPHmr, notifier_rd);

  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _R0FLAGZ, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& mtmpMRG, _R0FLAGZ, _DMY, _TRDNH, notifier_ad);

  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _R0A0, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _R0A1, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _R0A2, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _R0A3, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& mtmpMRGCEL, _R0A4, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& mtmpMRG, _R0A0, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& mtmpMRG, _R0A1, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& mtmpMRG, _R0A2, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& mtmpMRG, _R0A3, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& mtmpMRG, _R0A4, _DMY, _TRDNH, notifier_ad);

//READ MARGIN CHECK0/1
//##COMMON
  $setuphold ( negedge RDCLK &&& rmtmpRDM, negedge _RDMRG0, _DMY, _TMHrdm );
  $setuphold ( negedge RDCLK &&& rmtmpRDM, negedge _RDMRG1, _DMY, _TMHrdm );

//##CE=H&SACEEN=H
  $setuphold (negedge RDCLK &&& rmtmpRDMCESAC, _TRMCP10, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCESAC, _TRMCP11, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCESAC, _TRMCP12, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCESAC, _TRMCP13, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCESAC, _TRMCP14, _TTRMCPSrdm, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rmtmpRDMSAC, _TRMCP10, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMSAC, _TRMCP11, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMSAC, _TRMCP12, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMSAC, _TRMCP13, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMSAC, _TRMCP14, _DMY, _TTRMCPHrdm, notifier_rd);

//##CE=L&SACEEN=L
  $setuphold (negedge RDCLK &&& rmtmpRDMCEBSACB, _TRMCP10, _TTRMCPSrdm, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCEBSACB, _TRMCP11, _TTRMCPSrdm, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCEBSACB, _TRMCP12, _TTRMCPSrdm, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCEBSACB, _TRMCP13, _TTRMCPSrdm, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCEBSACB, _TRMCP14, _TTRMCPSrdm, _TTRMCPHrdm, notifier_rd);

  $setuphold (negedge RDCLK &&& rmtmpRDMCESAC, _R0FLAGZ, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMCEBSACB, _R0FLAGZ, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _R0FLAGZ, _DMY, _TRDNH, notifier_ad);

  $setuphold (negedge RDCLK &&& rmtmpRDMCESAC, _R0A0, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMCESAC, _R0A1, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMCESAC, _R0A2, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMCESAC, _R0A3, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMCESAC, _R0A4, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMCEBSACB, _R0A0, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMCEBSACB, _R0A1, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMCEBSACB, _R0A2, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMCEBSACB, _R0A3, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMCEBSACB, _R0A4, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _R0A0, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _R0A1, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _R0A2, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _R0A3, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDM, _R0A4, _DMY, _TRDNH, notifier_ad);

//COMMON READ
//##LowSpeed
//##HiSpeed
//##Sub
//##LowPower
//##LowVoltage
//##HS/LV/LS/LP => Sub
//##SACEEN Control

//ION CHECK1
  $setuphold ( posedge RDCLK &&& itmpION, negedge _IONCHK1, _DMY, _TMHion );
  $setuphold ( negedge _IONCHK1 &&& TRMRD12B, _EXA, _DMY , _TAH1ion );
  $setuphold ( negedge _IONCHK1 &&& TRMRD12B, _CE, _DMY , _TCEHion );

  $setuphold ( posedge RDCLK &&& TRMRD12B, posedge _IONCHK1, _DMY, _TRDIONion );

  $width ( negedge RDCLK &&& itmpION , _TCLKLion, 0, notifier_rd );
  $width ( posedge RDCLK &&& itmpION , _TCLKHion, 0, notifier_rd );

  $setuphold ( posedge _IONCHK1 &&& TRMRD12B, posedge _MUTEST, _TMUTESTSion, _DMY );

  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP10, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP11, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP12, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP13, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& itmpIONCE, _TRMCP14, _TTRMCPSmr, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& itmpION, _TRMCP10, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP11, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP12, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP13, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& itmpION, _TRMCP14, _DMY, _TTRMCPHmr, notifier_rd);

  $setuphold (posedge RDCLK &&& itmpIONCE, _R0FLAGZ, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& itmpION, _R0FLAGZ, _DMY, _TRDNH, notifier_ad);

  $setuphold (posedge RDCLK &&& itmpIONCE, _R0A0, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& itmpIONCE, _R0A1, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& itmpIONCE, _R0A2, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& itmpIONCE, _R0A3, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& itmpIONCE, _R0A4, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& itmpION, _R0A0, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& itmpION, _R0A1, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& itmpION, _R0A2, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& itmpION, _R0A3, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& itmpION, _R0A4, _DMY, _TRDNH, notifier_ad);

//READ MARGIN CHECK
//##COMMON
  $setuphold ( posedge RDCLK &&& rmtmpRDMC, negedge _RDMRGC, _DMY, _TMHrdmc );

  $setuphold ( negedge _RDMRGC &&& TRMRD12B, _EXA, _DMY , _TAH1rdmc );
  $setuphold ( negedge _RDMRGC &&& TRMRD12B, _CE, _DMY , _TCEHrdmc );

//  $setuphold (posedge RDCLK &&& TRMRD12B, posedge _RDMRGC, _DMY, _TRDRrdmc );

//##CE=H&SACEEN=H
  $setuphold (posedge RDCLK &&& rmtmpRDMCCESAC, _TRMCP10, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCESAC, _TRMCP11, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCESAC, _TRMCP12, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCESAC, _TRMCP13, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCESAC, _TRMCP14, _TTRMCPSrdm, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rmtmpRDMCSAC, _TRMCP10, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCSAC, _TRMCP11, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCSAC, _TRMCP12, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCSAC, _TRMCP13, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCSAC, _TRMCP14, _DMY, _TTRMCPHrdm, notifier_rd);

//##CE=L&SACEEN=L
  $setuphold (posedge RDCLK &&& rmtmpRDMCCEBSACB, _TRMCP10, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCEBSACB, _TRMCP11, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCEBSACB, _TRMCP12, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCEBSACB, _TRMCP13, _TTRMCPSrdm, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCEBSACB, _TRMCP14, _TTRMCPSrdm, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& rmtmpRDMCCEBSACB, _TRMCP10, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCCEBSACB, _TRMCP11, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCCEBSACB, _TRMCP12, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCCEBSACB, _TRMCP13, _DMY, _TTRMCPHrdm, notifier_rd);
  $setuphold (negedge RDCLK &&& rmtmpRDMCCEBSACB, _TRMCP14, _DMY, _TTRMCPHrdm, notifier_rd);

  $setuphold (posedge RDCLK &&& rmtmpRDMCCESAC, _R0FLAGZ, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCEBSACB, _R0FLAGZ, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _R0FLAGZ, _DMY, _TRDNH, notifier_ad);

  $setuphold (posedge RDCLK &&& rmtmpRDMCCESAC, _R0A0, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCESAC, _R0A1, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCESAC, _R0A2, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCESAC, _R0A3, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCESAC, _R0A4, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCEBSACB, _R0A0, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCEBSACB, _R0A1, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCEBSACB, _R0A2, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCEBSACB, _R0A3, _TRDNS, _DMY, notifier_ad);
  $setuphold (posedge RDCLK &&& rmtmpRDMCCEBSACB, _R0A4, _TRDNS, _DMY, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _R0A0, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _R0A1, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _R0A2, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _R0A3, _DMY, _TRDNH, notifier_ad);
  $setuphold (negedge RDCLK &&& rmtmpRDMC, _R0A4, _DMY, _TRDNH, notifier_ad);

//COMMON READ
//##LowSpeed
//##HiSpeed
//##Sub
//##LowPower
//##LowVoltage
//##HS/LV/LS/LP => Sub
//##SACEEN Control

//SELECT Tr CHECK
  $setuphold  (posedge RDCLK  &&&  sttmpSTC, negedge _STCHK, _DMY, _TMHstc);
  $setuphold  (negedge _STCHK  &&&  sttmpSTC, _CE, _DMY, _TCEHstc);

  $width ( negedge RDCLK &&& sttmpSTC , _TCLKLstc, 0, notifier_rd );
  $width ( posedge RDCLK &&& sttmpSTC , _TCLKHstc, 0, notifier_rd );

  $setuphold (posedge RDCLK &&& TRMRD12B, posedge _STCHK, _DMY, _TRDSTstc );

  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP10, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP11, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP12, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP13, _TTRMCPSmr, _DMY, notifier_rd);
  $setuphold (posedge RDCLK &&& sttmpSTCCE, _TRMCP14, _TTRMCPSmr, _DMY, notifier_rd);

  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP10, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP11, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP12, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP13, _DMY, _TTRMCPHmr, notifier_rd);
  $setuphold (negedge RDCLK &&& sttmpSTC, _TRMCP14, _DMY, _TTRMCPHmr, notifier_rd);

//  $setuphold (posedge RDCLK &&& sttmpSTCCE, _R0FLAGZ, _TRDNS, _DMY, notifier_ad);
//  $setuphold (negedge RDCLK &&& sttmpSTC, _R0FLAGZ, _DMY, _TRDNH, notifier_ad);

//  $setuphold (posedge RDCLK &&& sttmpSTCCE, _R0A0, _TRDNS, _DMY, notifier_ad);
//  $setuphold (posedge RDCLK &&& sttmpSTCCE, _R0A1, _TRDNS, _DMY, notifier_ad);
//  $setuphold (posedge RDCLK &&& sttmpSTCCE, _R0A2, _TRDNS, _DMY, notifier_ad);
//  $setuphold (posedge RDCLK &&& sttmpSTCCE, _R0A3, _TRDNS, _DMY, notifier_ad);
//  $setuphold (posedge RDCLK &&& sttmpSTCCE, _R0A4, _TRDNS, _DMY, notifier_ad);
//  $setuphold (negedge RDCLK &&& sttmpSTC, _R0A0, _DMY, _TRDNH, notifier_ad);
//  $setuphold (negedge RDCLK &&& sttmpSTC, _R0A1, _DMY, _TRDNH, notifier_ad);
//  $setuphold (negedge RDCLK &&& sttmpSTC, _R0A2, _DMY, _TRDNH, notifier_ad);
//  $setuphold (negedge RDCLK &&& sttmpSTC, _R0A3, _DMY, _TRDNH, notifier_ad);
//  $setuphold (negedge RDCLK &&& sttmpSTC, _R0A4, _DMY, _TRDNH, notifier_ad);

//CHARGE PUMP BT
  $width ( posedge _CPBT &&& TRMRD12B, _TCPBT );  // 1ms

  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP10, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP11, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP12, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP13, _TTRMCPScpb, _DMY);
  $setuphold (posedge _CPBT &&& TRMRD12B, _TRMCP14, _TTRMCPScpb, _DMY);

  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP10, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP11, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP12, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP13, _DMY, _TTRMCPHcpb);
  $setuphold (negedge _CPBT &&& TRMRD12B, _TRMCP14, _DMY, _TTRMCPHcpb);

  $setuphold (posedge _RDCLKP1 &&& tmpCLKSELB, posedge _CPBT, _DMY, _TRDMcpb );

//WRITE DISTRUB TEST1/2/3/4
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _WDT1, _DMY, _TRDWwd );
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _WDT2, _DMY, _TRDWwd );
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _WDT3, _DMY, _TRDWwd );
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _WDT4, _DMY, _TRDWwd );

  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _WDT1, _DMY, _TMHwd );
  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _WDT2, _DMY, _TMHwd );
  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _WDT3, _DMY, _TMHwd );
  $setuphold ( negedge _FCLK1 &&& TRMRD12B, negedge _WDT4, _DMY, _TMHwd );
  $setuphold ( negedge _FCLK2 &&& TRMRD12B, negedge _WDT1, _DMY, _TMHwd );
  $setuphold ( negedge _FCLK2 &&& TRMRD12B, negedge _WDT2, _DMY, _TMHwd );
  $setuphold ( negedge _FCLK2 &&& TRMRD12B, negedge _WDT3, _DMY, _TMHwd );
  $setuphold ( negedge _FCLK2 &&& TRMRD12B, negedge _WDT4, _DMY, _TMHwd );

  $setuphold ( posedge PROGI &&& TRMRD12B , posedge _WDT1, _TPROGISwd, _DMY );
  $setuphold ( posedge PROGI &&& TRMRD12B , posedge _WDT2, _TPROGISwd, _DMY );
  $setuphold ( posedge PROGI &&& TRMRD12B , posedge _WDT3, _TPROGISwd, _DMY );
  $setuphold ( posedge PROGI &&& TRMRD12B , posedge _WDT4, _TPROGISwd, _DMY );
  $width ( posedge _PROGI &&& dtmpWDT1, _TPROGIwd );
  $width ( posedge _PROGI &&& dtmpWDT2, _TPROGIwd );
  $width ( posedge _PROGI &&& dtmpWDT3, _TPROGIwd );
  $width ( posedge _PROGI &&& dtmpWDT4, _TPROGIwd );
  $setuphold ( negedge _PROGI &&& dtmpWDT1, posedge _FCLK1, _DMY, _TPROGIwdt1 );
  $setuphold ( negedge _PROGI &&& dtmpWDT1, posedge _FCLK2, _DMY, _TPROGIwdt2 );
  $setuphold ( negedge _PROGI &&& dtmpWDT2, posedge _FCLK1, _DMY, _TPROGIwdt1 );
  $setuphold ( negedge _PROGI &&& dtmpWDT2, posedge _FCLK2, _DMY, _TPROGIwdt2 );

  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP10, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP10, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP10, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP10, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP11, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP11, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP11, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP11, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP12, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP12, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP12, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP12, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP13, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP13, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP13, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP13, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _TRMCP14, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _TRMCP14, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _TRMCP14, _TTRMCPSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _TRMCP14, _TTRMCPSwd, _DMY);

  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP10, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP10, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP10, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP10, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP11, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP11, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP11, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP11, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP12, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP12, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP12, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP12, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP13, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP13, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP13, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP13, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _TRMCP14, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _TRMCP14, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _TRMCP14, _DMY, _TTRMCPHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _TRMCP14, _DMY, _TTRMCPHwd);

  $setuphold (posedge _WDT1 &&& TRMRD12B, _R0FLAGZ, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _R0FLAGZ, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _R0FLAGZ, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _R0FLAGZ, _TRDNSwd, _DMY);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _R0FLAGZ, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _R0FLAGZ, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _R0FLAGZ, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _R0FLAGZ, _DMY, _TRDNHwd);

  $setuphold (posedge _WDT1 &&& TRMRD12B, _R0A0, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _R0A0, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _R0A0, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _R0A0, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _R0A1, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _R0A1, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _R0A1, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _R0A1, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _R0A2, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _R0A2, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _R0A2, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _R0A2, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _R0A3, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _R0A3, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _R0A3, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _R0A3, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT1 &&& TRMRD12B, _R0A4, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT2 &&& TRMRD12B, _R0A4, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT3 &&& TRMRD12B, _R0A4, _TRDNSwd, _DMY);
  $setuphold (posedge _WDT4 &&& TRMRD12B, _R0A4, _TRDNSwd, _DMY);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _R0A0, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _R0A0, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _R0A0, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _R0A0, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _R0A1, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _R0A1, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _R0A1, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _R0A1, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _R0A2, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _R0A2, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _R0A2, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _R0A2, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _R0A3, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _R0A3, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _R0A3, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _R0A3, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT1 &&& TRMRD12B, _R0A4, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT2 &&& TRMRD12B, _R0A4, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT3 &&& TRMRD12B, _R0A4, _DMY, _TRDNHwd);
  $setuphold (negedge _WDT4 &&& TRMRD12B, _R0A4, _DMY, _TRDNHwd);

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

  $setuphold (posedge _RDT &&& TRMRD12B, _R0FLAGZ, _TRDNSrdt, _DMY);
  $setuphold (negedge _RDT &&& TRMRD12B, _R0FLAGZ, _DMY, _TRDNHrdt);

  $setuphold (posedge _RDT &&& TRMRD12B, _R0A0, _TRDNSrdt, _DMY);
  $setuphold (posedge _RDT &&& TRMRD12B, _R0A1, _TRDNSrdt, _DMY);
  $setuphold (posedge _RDT &&& TRMRD12B, _R0A2, _TRDNSrdt, _DMY);
  $setuphold (posedge _RDT &&& TRMRD12B, _R0A3, _TRDNSrdt, _DMY);
  $setuphold (posedge _RDT &&& TRMRD12B, _R0A4, _TRDNSrdt, _DMY);
  $setuphold (negedge _RDT &&& TRMRD12B, _R0A0, _DMY, _TRDNHrdt);
  $setuphold (negedge _RDT &&& TRMRD12B, _R0A1, _DMY, _TRDNHrdt);
  $setuphold (negedge _RDT &&& TRMRD12B, _R0A2, _DMY, _TRDNHrdt);
  $setuphold (negedge _RDT &&& TRMRD12B, _R0A3, _DMY, _TRDNHrdt);
  $setuphold (negedge _RDT &&& TRMRD12B, _R0A4, _DMY, _TRDNHrdt);

//READ DISTURB TEST (FCLK change)
  $width ( negedge _FCLK1 &&& dtmpRDT, _TRDTL );
  $width ( posedge _FCLK1 &&& dtmpRDT, _TRDTH );

//READ DISTURB TEST (MEOR Control)
  $setuphold ( posedge _RDCLKP1 &&& tmpCLKSELB, posedge _RDT, _DMY, _TRDRrdt );

  $setuphold ( posedge _RDT &&& TRMRD12B, _MEOR , _TMEORS, _DMY );
  $setuphold ( negedge _RDT &&& TRMRD12B, _MEOR , _DMY, _TMEORH );

//EXTERNAL VPP1/2
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

  $setuphold ( posedge _WWR &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _CER &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _SER &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _MRG00 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _MRG01 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _MRG10 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _MRG11 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _MRG12 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _READ &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _MSWR &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _EXER &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _IONCHK1 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _CPBT &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _WDT1 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _WDT2 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _WDT3 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _WDT4 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _RDT &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _STCHK &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _RDMRG0 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _RDMRG1 &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );
  $setuphold ( posedge _RDMRGC &&& TRMRD12B, _EXTVPP2, _TEXT1S, _DMY );

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

  $setuphold ( negedge _WWR &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _CER &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _SER &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _MRG00 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _MRG01 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _MRG10 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _MRG11 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _MRG12 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _READ &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _MSWR &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _EXER &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _IONCHK1 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _CPBT &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H ); 
  $setuphold ( negedge _WDT1 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _WDT2 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _WDT3 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _WDT4 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _RDT &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _STCHK &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _RDMRG0 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _RDMRG1 &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );
  $setuphold ( negedge _RDMRGC &&& TRMRD12B, _EXTVPP2, _DMY, _TEXT1H );

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

  $setuphold ( posedge _WWR &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _CER &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _SER &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MRG00 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MRG01 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MRG10 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MRG11 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MRG12 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _READ &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _MSWR &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _EXER &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _IONCHK1 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _CPBT &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _WDT1 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _WDT2 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _WDT3 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _WDT4 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _RDT &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _STCHK &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _RDMRG0 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _RDMRG1 &&& TRMRD12B, _CWEE, _TCWEES, _DMY );
  $setuphold ( posedge _RDMRGC &&& TRMRD12B, _CWEE, _TCWEES, _DMY );

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

//SENSE AMP REFERENSE TEST
  $setuphold ( posedge _WWR &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MRG00 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MRG01 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MRG10 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MRG11 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MRG12 &&& TRMRD12B, _IREFT, _TIREFTS, _DMY ); 
  $setuphold ( posedge _READ &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _MSWR &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _STCHK &&& TRMRD12B, _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _RDMRG0 &&& TRMRD12B,  _IREFT, _TIREFTS, _DMY );
  $setuphold ( posedge _RDMRG1 &&& TRMRD12B,  _IREFT, _TIREFTS, _DMY );
  
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

//BT-mode
  $width ( negedge _RDCLKC1 &&& btmpBT , _TCLKLhs32, 0, notifier_rd );
  $width ( posedge _RDCLKC1 &&& btmpBT , _TCLKHhs32, 0, notifier_rd );
  $period ( posedge _RDCLKC1 &&& btmpBT , _TCYChs32, notifier_rd );
  $period ( negedge _RDCLKC1 &&& btmpBT , _TCYChs32, notifier_rd );

//D  $width ( negedge _DRDCLKC1 &&& btmpBT , _TCLKLhs32, 0, notifier_rd );
//D  $width ( posedge _DRDCLKC1 &&& btmpBT , _TCLKHhs32, 0, notifier_rd );
////D  $period ( posedge _DRDCLKC1 &&& btmpBT , _TCYChs32, notifier_rd );
////D  $period ( negedge _DRDCLKC1 &&& btmpBT , _TCYChs32, notifier_rd );

//## SDF Annotate
  $width ( negedge RDCLKC1 &&& stmpSCAN , _TCLKLhs32);
  $width ( posedge RDCLKC1 &&& stmpSCAN , _TCLKHhs32);
  $period ( posedge RDCLKC1 &&& stmpSCAN , _TCYChs32);
  $period ( negedge RDCLKC1 &&& stmpSCAN , _TCYChs32);

//D  $width ( negedge DRDCLKC1 &&& stmpSCAN , _TCLKLhs32);
//D  $width ( posedge DRDCLKC1 &&& stmpSCAN , _TCLKHhs32);
//D  $period ( posedge DRDCLKC1 &&& stmpSCAN , _TCYChs32);
//D  $period ( negedge DRDCLKC1 &&& stmpSCAN , _TCYChs32);

// v1.01
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A2, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A2, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A3, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A3, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A4, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A4, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A5, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A5, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A6, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A6, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A7, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A7, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A8, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A8, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A9, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A9, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A10, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A10, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A11, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A11, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A12, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A12, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A13, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A13, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , negedge A14, _TAS, _DMY, notifier_ad );
  $setuphold ( negedge RDCLKC1 &&& btmpBT , posedge A14, _TAS, _DMY, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A2, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A2, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A3, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A3, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A4, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A4, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A5, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A5, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A6, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A6, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A7, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A7, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A8, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A8, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A9, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A9, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A10, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A10, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A11, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A11, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A12, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A12, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A13, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A13, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , negedge A14, _DMY, _TAH21v, notifier_ad );
  $setuphold ( posedge RDCLKC1 &&& btmpBT , posedge A14, _DMY, _TAH21v, notifier_ad );

//SCAN-mode
  $setuphold (negedge _RDCLKC1 &&& stmpSCAN, posedge _SCANMODE, _TSCNMDS, _DMY);
  $setuphold (negedge _RDCLKC1 &&& stmpSCAN, negedge _SCANMODE, _DMY, _TSCNMDH);

  $setuphold (negedge _VBRESZ &&& stmpSCAN, posedge _SCANMODE, _TVBZ, _DMY);  //v2 add

endspecify

`endif  // FAST_FUNC

`ifdef QNSXXXX_ASSERT_ON
`include "./ast/sv_file/QNSA3N032K1V2.sv"
`endif

endmodule

`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
