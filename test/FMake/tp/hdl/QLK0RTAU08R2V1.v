// [NEC Electronics Group CONFIDENTIAL]
// (C) Copyright NEC Electronics Corporation 2009
// All Rights Reserved. Do not duplicate without prior written
// consent of NEC Electronics Corporation.
//
// Macro Name      : QLK0RTAU08R2V1
// Version         : 1.00
// Date            : 2010.01.15
// Author          : Yasuhiro Takata (y.takata@nms.necel.com)
// History         : ver.1.00 (2010.01.15) y.takata@nms.necel.com
//



module QLK0RTAU08R2V1 ( PCLK,   PCLKRW,   PRESETZ,  PSEL2,    PSEL1,
                      PADDR5,   PADDR4,   PADDR3,   PADDR2,   PADDR1,   PADDR0,
                      PENABLE,  PWRITE,
                      PWDATA31, PWDATA30, PWDATA29, PWDATA28, PWDATA27, PWDATA26, PWDATA25,
                      PWDATA24, PWDATA23, PWDATA22, PWDATA21, PWDATA20, PWDATA19, PWDATA18,
                      PWDATA17, PWDATA16, PWDATA15, PWDATA14, PWDATA13, PWDATA12, PWDATA11,
                      PWDATA10, PWDATA9,  PWDATA8,  PWDATA7,  PWDATA6,  PWDATA5,  PWDATA4,
                      PWDATA3,  PWDATA2,  PWDATA1,  PWDATA0,
                      PRDATA15, PRDATA14, PRDATA13, PRDATA12, PRDATA11, PRDATA10, PRDATA9,
                      PRDATA8,  PRDATA7,  PRDATA6,  PRDATA5,  PRDATA4,  PRDATA3,  PRDATA2,
                      PRDATA1,  PRDATA0,
                      CK3,      CK2,      CK1,      CK0,
                      TIN7,     TIN6,     TIN5,     TIN4,     TIN3,     TIN2,     TIN1,     TIN0,
                      NFEN7,    NFEN6,    NFEN5,    NFEN4,    NFEN3,    NFEN2,    NFEN1,    NFEN0,
                      TOUT7,    TOUT6,    TOUT5,    TOUT4,    TOUT3,    TOUT2,    TOUT1,    TOUT0,
                      INT7,     INT6,     INT5,     INT4,     INT3,     INT2,     INT1,     INT0,
                      INTH3,    INTH1,
                      PRS31,    PRS30,    PRS21,    PRS20,    PRS13,    PRS12,    PRS11,    PRS10,
                      PRS03,    PRS02,    PRS01,    PRS00,
                      CKEN7,    CKEN6,    CKEN5,    CKEN4,    CKEN3,    CKEN2,    CKEN1,    CKEN0,
                      CDEN7,    CDEN6,    CDEN5,    CDEN4,    CDEN3,    CDEN2,    CDEN1,    CDEN0,
                      TOE7,     TOE6,     TOE5,     TOE4,     TOE3,     TOE2,     TOE1,     TOE0,
                      TE7,      TE6,      TE5,      TE4,      TE3,      TE2,      TE1,      TE0 );


// APB Signals
  input  PCLK;
  input  PCLKRW;
  input  PRESETZ;
  
//  input  PSEL3;
  input  PSEL2;
  input  PSEL1;
  
  input  PADDR5;
  input  PADDR4;
  input  PADDR3;
  input  PADDR2;
  input  PADDR1;
  input  PADDR0;

  input  PENABLE;
  input  PWRITE;

  input  PWDATA31;
  input  PWDATA30;
  input  PWDATA29;
  input  PWDATA28;
  input  PWDATA27;
  input  PWDATA26;
  input  PWDATA25;
  input  PWDATA24;
  input  PWDATA23;
  input  PWDATA22;
  input  PWDATA21;
  input  PWDATA20;
  input  PWDATA19;
  input  PWDATA18;
  input  PWDATA17;
  input  PWDATA16;
  input  PWDATA15;
  input  PWDATA14;
  input  PWDATA13;
  input  PWDATA12;
  input  PWDATA11;
  input  PWDATA10;
  input  PWDATA9;
  input  PWDATA8;
  input  PWDATA7;
  input  PWDATA6;
  input  PWDATA5;
  input  PWDATA4;
  input  PWDATA3;
  input  PWDATA2;
  input  PWDATA1;
  input  PWDATA0;

  output PRDATA15;
  output PRDATA14;
  output PRDATA13;
  output PRDATA12;
  output PRDATA11;
  output PRDATA10;
  output PRDATA9;
  output PRDATA8;
  output PRDATA7;
  output PRDATA6;
  output PRDATA5;
  output PRDATA4;
  output PRDATA3;
  output PRDATA2;
  output PRDATA1;
  output PRDATA0;

// Clock enable Input
  input  CK3;
  input  CK2;
  input  CK1;
  input  CK0;

// Channel Input
  input  TIN7;
  input  TIN6;
  input  TIN5;
  input  TIN4;
  input  TIN3;
  input  TIN2;
  input  TIN1;
  input  TIN0;

// Channel NFEN Input
  input  NFEN7;
  input  NFEN6;
  input  NFEN5;
  input  NFEN4;
  input  NFEN3;
  input  NFEN2;
  input  NFEN1;
  input  NFEN0;

// Channel Output
  output TOUT7;
  output TOUT6;
  output TOUT5;
  output TOUT4;
  output TOUT3;
  output TOUT2;
  output TOUT1;
  output TOUT0;

// Int
  output INT7;
  output INT6;
  output INT5;
  output INT4;
  output INT3;
  output INT2;
  output INT1;
  output INT0;

  output INTH3;
  output INTH1;

// TPS:PRS bit Output
  output PRS31;
  output PRS30;
  output PRS21;
  output PRS20;
  output PRS13;
  output PRS12;
  output PRS11;
  output PRS10;
  output PRS03;
  output PRS02;
  output PRS01;
  output PRS00;

// For External Logic
  output CKEN7;
  output CKEN6;
  output CKEN5;
  output CKEN4;
  output CKEN3;
  output CKEN2;
  output CKEN1;
  output CKEN0;

  output CDEN7;
  output CDEN6;
  output CDEN5;
  output CDEN4;
  output CDEN3;
  output CDEN2;
  output CDEN1;
  output CDEN0;

  output TE7;
  output TE6;
  output TE5;
  output TE4;
  output TE3;
  output TE2;
  output TE1;
  output TE0;

  output TOE7;
  output TOE6;
  output TOE5;
  output TOE4;
  output TOE3;
  output TOE2;
  output TOE1;
  output TOE0;

// Signal wire
wire [7:0]  tom, tol, toe;
wire [7:0]  sel_tdr, sel_tmr;
wire        sel_to, sel_toe, sel_tol, sel_tom, sel_tps;
wire        sel_tdr3_l, sel_tdr3_h, sel_tdr1_l, sel_tdr1_h;
wire        we_ts, we_tt;

wire [15:0] tdr07, tdr06, tdr05, tdr04, tdr03, tdr02, tdr01, tdr00;
wire [15:0] tcr07, tcr06, tcr05, tcr04, tcr03, tcr02, tcr01, tcr00;
wire [15:0] tps;
wire [7:0]  te, ovf;
wire [1:0]  cks7,  cks6,  cks5,  cks4,  cks3,  cks2,  cks1, cks0;
wire [1:0]  ccs7, ccs6, ccs5, ccs4, ccs3, ccs2, ccs1, ccs0;
wire [1:0]  tis7, tis6, tis5, tis4, tis3, tis2, tis1, tis0;
wire [2:0]  sts7, sts6, sts5, sts4, sts3, sts2, sts1, sts0;
wire [3:0]  md7, md6, md5, md4, md3, md2, md1, md0;
wire        split7, master6, split5, master4, split3, master2, split1, master0;
wire        te_h3, te_h1;

wire        brow_out0, brow_out1, brow_out2, brow_out3,
            brow_out4, brow_out5, brow_out6, brow_out7;

wire        brow_sel23, brow_sel45, brow_sel67;

// Input connection CK
wire ck0 = CK0;
wire ck1 = CK1;
wire ck2 = CK2;
wire ck3 = CK3;

// Output connection PRS
wire PRS31 = tps[13];
wire PRS30 = tps[12];
wire PRS21 = tps[9];
wire PRS20 = tps[8];
wire PRS13 = tps[7];
wire PRS12 = tps[6];
wire PRS11 = tps[5];
wire PRS10 = tps[4];
wire PRS03 = tps[3];
wire PRS02 = tps[2];
wire PRS01 = tps[1];
wire PRS00 = tps[0];

// Output connection TOE
wire TOE7  = toe[7];
wire TOE6  = toe[6];
wire TOE5  = toe[5];
wire TOE4  = toe[4];
wire TOE3  = toe[3];
wire TOE2  = toe[2];
wire TOE1  = toe[1];
wire TOE0  = toe[0];

// Output connection TE
wire TE7  = te[7];
wire TE6  = te[6];
wire TE5  = te[5];
wire TE4  = te[4];
wire TE3  = te[3];
wire TE2  = te[2];
wire TE1  = te[1];
wire TE0  = te[0];

// input pwdata31-0
wire [31:0] pwdata = { PWDATA31, PWDATA30, PWDATA29, PWDATA28, PWDATA27, PWDATA26, PWDATA25, PWDATA24,
                       PWDATA23, PWDATA22, PWDATA21, PWDATA20, PWDATA19, PWDATA18, PWDATA17, PWDATA16,
                       PWDATA15, PWDATA14, PWDATA13, PWDATA12, PWDATA11, PWDATA10, PWDATA9,  PWDATA8,
                       PWDATA7,  PWDATA6,  PWDATA5,  PWDATA4,  PWDATA3,  PWDATA2,  PWDATA1,  PWDATA0 };

// Clock gating signal
wire   ge_enout7, ge_enout6, ge_enout5, ge_enout4, ge_enout3, ge_enout2, ge_enout1, ge_enout0;
wire   ck_all_l, ck_all_h;
wire   tstt_all;
wire   counten_all;

// ---------------------------------------------------------------------------------------------------------------

// APB Bus Interface
QLK0RTAU08R2V1_APBIF apbif ( .psel2(PSEL2),   .psel1(PSEL1),
                      .pwrite(PWRITE),        .penable(PENABLE),
                      .paddr5(PADDR5),        .paddr4(PADDR4),        .paddr3(PADDR3),
                      .paddr2(PADDR2),        .paddr1(PADDR1),        .paddr0(PADDR0),
                      .prdata15(PRDATA15),    .prdata14(PRDATA14),    .prdata13(PRDATA13),    .prdata12(PRDATA12),
                      .prdata11(PRDATA11),    .prdata10(PRDATA10),    .prdata9(PRDATA9),      .prdata8(PRDATA8),
                      .prdata7(PRDATA7),      .prdata6(PRDATA6),      .prdata5(PRDATA5),      .prdata4(PRDATA4),
                      .prdata3(PRDATA3),      .prdata2(PRDATA2),      .prdata1(PRDATA1),      .prdata0(PRDATA0),
                      .sel_tdr(sel_tdr),      .sel_tmr(sel_tmr),      .sel_to(sel_to),        .sel_toe(sel_toe),
                      .sel_tol(sel_tol),      .sel_tom(sel_tom),      .sel_tps(sel_tps),
                      .sel_tdr1_l(sel_tdr1_l), .sel_tdr1_h(sel_tdr1_h),
                      .sel_tdr3_l(sel_tdr3_l), .sel_tdr3_h(sel_tdr3_h),
                      .we_ts(we_ts),          .we_tt(we_tt),
                      .tdr07(tdr07),          .tdr06(tdr06),          .tdr05(tdr05),          .tdr04(tdr04),
                      .tdr03(tdr03),          .tdr02(tdr02),          .tdr01(tdr01),          .tdr00(tdr00),
                      .tcr07(tcr07),          .tcr06(tcr06),          .tcr05(tcr05),          .tcr04(tcr04),
                      .tcr03(tcr03),          .tcr02(tcr02),          .tcr01(tcr01),          .tcr00(tcr00),
                      .cks7(cks7),            .cks6(cks6),            .cks5(cks5),            .cks4(cks4),
                      .cks3(cks3),            .cks2(cks2),            .cks1(cks1),            .cks0(cks0),
                      .ccs7(ccs7),            .ccs6(ccs6),            .ccs5(ccs5),            .ccs4(ccs4),
                      .ccs3(ccs3),            .ccs2(ccs2),            .ccs1(ccs1),            .ccs0(ccs0),
                      .sts7(sts7),            .sts6(sts6),            .sts5(sts5),            .sts4(sts4),
                      .sts3(sts3),            .sts2(sts2),            .sts1(sts1),            .sts0(sts0),
                      .tis7(tis7),            .tis6(tis6),            .tis5(tis5),            .tis4(tis4),
                      .tis3(tis3),            .tis2(tis2),            .tis1(tis1),            .tis0(tis0),
                      .md7(md7),              .md6(md6),              .md5(md5),              .md4(md4), 
                      .md3(md3),              .md2(md2),              .md1(md1),              .md0(md0),
                      .split7(split7),        .master6(master6),      .split5(split5),        .master4(master4),
                      .split3(split3),        .master2(master2),      .split1(split1),        .master0(master0),
                      .ovf(ovf[7:0]),         .te(te[7:0]),           .toe(toe[7:0]),         .tol(tol[7:0]),
                      .tom(tom[7:0]),         .tps(tps),
                      .tout7(TOUT7),          .tout6(TOUT6),          .tout5(TOUT5),          .tout4(TOUT4),
                      .tout3(TOUT3),          .tout2(TOUT2),          .tout1(TOUT1),          .tout0(TOUT0),
                      .te_h3(te_h3),          .te_h1(te_h1) );


// Prescaler Block
QLK0RTAU08R2V1_PRSU  prsu  ( .pclk(PCLKRW),      .presetz(PRESETZ),       .sel_tps(sel_tps),
                      .pwdata(pwdata[15:0]),  .tps(tps) );


// Channel Array Block
QLK0RTAU08R2V1_CH_0     ch0 ( .pclk(PCLK), .pclkrw(PCLKRW), .presetz(PRESETZ), .pwdata(pwdata[15:0]), .chdata(pwdata[0]),
                      .we_ts(we_ts), .we_tt(we_tt), .sel_tdr(sel_tdr[0]), .sel_tmr(sel_tmr[0]),
                      .sel_toe(sel_toe), .sel_to(sel_to),
                      .tau_in(TIN0), .ck0(ck0), .ck1(ck1), .nfen(NFEN0), .brow_in(1'b0),
                      .ck_all(ck_all_l), .tstt_all(tstt_all), .counten_all(counten_all),
                      .tcr(tcr00), .ovf(ovf[0]), .te(te[0]), .tdr(tdr00), .cks(cks0), .ccs(ccs0), .master(master0),
                      .sts(sts0), .tis(tis0), .md(md0), .toe(toe[0]), .tol(tol[0]), .tom(tom[0]),
                      .tout(TOUT0), .intout(INT0), .mck(CKEN0), .to_reset(CDEN0), .brow_out(brow_out0),
                      .ge_enout(ge_enout0) );


QLK0RTAU08R2V1_CH_SPLIT ch1 ( .pclk(PCLK), .pclkrw(PCLKRW), .presetz(PRESETZ), .pwdata(pwdata[31:16]), .chdata(pwdata[17]),
                      .we_ts(we_ts), .we_tt(we_tt), .sel_tdr(sel_tdr[1]), .sel_tmr(sel_tmr[1]),
                      .sel_toe(sel_toe), .sel_tol(sel_tol), .sel_tom(sel_tom), .sel_to(sel_to),
                      .tau_in(TIN1), .ck0(ck0), .ck1(ck1), .nfen(NFEN1), .brow_in(brow_out0),
                      .ck_all(ck_all_h), .tstt_all(tstt_all), .counten_all(counten_all),
                      .tcr(tcr01), .ovf(ovf[1]), .te(te[1]), .tdr(tdr01), .cks(cks1), .ccs(ccs1), .master(split1),
                      .sts(sts1), .tis(tis1), .md(md1), .toe(toe[1]), .tol(tol[1]), .tom(tom[1]),
                      .tout(TOUT1), .intout(INT1), .mck(CKEN1), .to_reset(CDEN1), .brow_out(brow_out1),
                      .ge_enout(ge_enout1),
                      .ck2(ck2), .ck3(ck3), .chdata_h(pwdata[25]), .sel_tdr_l(sel_tdr1_l), .sel_tdr_h(sel_tdr1_h),
                      .intout_h(INTH1), .te_h(te_h1) );


QLK0RTAU08R2V1_CH_EVEN  ch2 ( .pclk(PCLK), .pclkrw(PCLKRW), .presetz(PRESETZ), .pwdata(pwdata[15:0]), .chdata(pwdata[2]),
                      .we_ts(we_ts), .we_tt(we_tt), .sel_tdr(sel_tdr[2]), .sel_tmr(sel_tmr[2]),
                      .sel_toe(sel_toe), .sel_tol(sel_tol), .sel_tom(sel_tom), .sel_to(sel_to),
                      .tau_in(TIN2), .ck0(ck0), .ck1(ck1), .nfen(NFEN2), .brow_in(brow_out0),
                      .ck_all(ck_all_l), .tstt_all(tstt_all), .counten_all(counten_all),
                      .tcr(tcr02), .ovf(ovf[2]), .te(te[2]), .tdr(tdr02), .cks(cks2), .ccs(ccs2), .master(master2),
                      .sts(sts2), .tis(tis2), .md(md2), .toe(toe[2]), .tol(tol[2]), .tom(tom[2]),
                      .tout(TOUT2), .intout(INT2), .mck(CKEN2), .to_reset(CDEN2), .brow_out(brow_out2),
                      .ge_enout(ge_enout2) );


QLK0RTAU08R2V1_CH_SPLIT ch3 ( .pclk(PCLK), .pclkrw(PCLKRW), .presetz(PRESETZ), .pwdata(pwdata[31:16]), .chdata(pwdata[19]),
                      .we_ts(we_ts), .we_tt(we_tt), .sel_tdr(sel_tdr[3]), .sel_tmr(sel_tmr[3]),
                      .sel_toe(sel_toe), .sel_tol(sel_tol), .sel_tom(sel_tom), .sel_to(sel_to),
                      .tau_in(TIN3), .ck0(ck0), .ck1(ck1), .nfen(NFEN3), .brow_in(brow_sel23),
                      .ck_all(ck_all_h), .tstt_all(tstt_all), .counten_all(counten_all),
                      .tcr(tcr03), .ovf(ovf[3]), .te(te[3]), .tdr(tdr03), .cks(cks3), .ccs(ccs3), .master(split3),
                      .sts(sts3), .tis(tis3), .md(md3), .toe(toe[3]), .tol(tol[3]), .tom(tom[3]),
                      .tout(TOUT3), .intout(INT3), .mck(CKEN3), .to_reset(CDEN3), .brow_out(brow_out3),
                      .ge_enout(ge_enout3),
                      .ck2(ck2), .ck3(ck3), .chdata_h(pwdata[27]), .sel_tdr_l(sel_tdr3_l), .sel_tdr_h(sel_tdr3_h),
                      .intout_h(INTH3), .te_h(te_h3) );


QLK0RTAU08R2V1_CH_EVEN  ch4 ( .pclk(PCLK), .pclkrw(PCLKRW), .presetz(PRESETZ), .pwdata(pwdata[15:0]), .chdata(pwdata[4]),
                      .we_ts(we_ts), .we_tt(we_tt), .sel_tdr(sel_tdr[4]), .sel_tmr(sel_tmr[4]),
                      .sel_toe(sel_toe), .sel_tol(sel_tol), .sel_tom(sel_tom), .sel_to(sel_to),
                      .tau_in(TIN4), .ck0(ck0), .ck1(ck1), .nfen(NFEN4), .brow_in(brow_sel23),
                      .ck_all(ck_all_l), .tstt_all(tstt_all), .counten_all(counten_all),
                      .tcr(tcr04), .ovf(ovf[4]), .te(te[4]), .tdr(tdr04), .cks(cks4), .ccs(ccs4), .master(master4),
                      .sts(sts4), .tis(tis4), .md(md4), .toe(toe[4]), .tol(tol[4]), .tom(tom[4]),
                      .tout(TOUT4), .intout(INT4), .mck(CKEN4), .to_reset(CDEN4), .brow_out(brow_out4),
                      .ge_enout(ge_enout4) );


QLK0RTAU08R2V1_CH_ODD   ch5 ( .pclk(PCLK), .pclkrw(PCLKRW), .presetz(PRESETZ), .pwdata(pwdata[31:16]), .chdata(pwdata[21]),
                      .we_ts(we_ts), .we_tt(we_tt), .sel_tdr(sel_tdr[5]), .sel_tmr(sel_tmr[5]),
                      .sel_toe(sel_toe), .sel_tol(sel_tol), .sel_tom(sel_tom), .sel_to(sel_to),
                      .tau_in(TIN5), .ck0(ck0), .ck1(ck1), .nfen(NFEN5), .brow_in(brow_sel45),
                      .ck_all(ck_all_l), .tstt_all(tstt_all), .counten_all(counten_all),
                      .tcr(tcr05), .ovf(ovf[5]), .te(te[5]), .tdr(tdr05), .cks(cks5), .ccs(ccs5), .master(split5),
                      .sts(sts5), .tis(tis5), .md(md5), .toe(toe[5]), .tol(tol[5]), .tom(tom[5]),
                      .tout(TOUT5), .intout(INT5), .mck(CKEN5), .to_reset(CDEN5), .brow_out(brow_out5),
                      .ge_enout(ge_enout5) );


QLK0RTAU08R2V1_CH_EVEN  ch6 ( .pclk(PCLK), .pclkrw(PCLKRW), .presetz(PRESETZ), .pwdata(pwdata[15:0]), .chdata(pwdata[6]),
                      .we_ts(we_ts), .we_tt(we_tt), .sel_tdr(sel_tdr[6]), .sel_tmr(sel_tmr[6]),
                      .sel_toe(sel_toe), .sel_tol(sel_tol), .sel_tom(sel_tom), .sel_to(sel_to),
                      .tau_in(TIN6), .ck0(ck0), .ck1(ck1), .nfen(NFEN6), .brow_in(brow_sel45),
                      .ck_all(ck_all_l), .tstt_all(tstt_all), .counten_all(counten_all),
                      .tcr(tcr06), .ovf(ovf[6]), .te(te[6]), .tdr(tdr06), .cks(cks6), .ccs(ccs6), .master(master6),
                      .sts(sts6), .tis(tis6), .md(md6), .toe(toe[6]), .tol(tol[6]), .tom(tom[6]),
                      .tout(TOUT6), .intout(INT6), .mck(CKEN6), .to_reset(CDEN6), .brow_out(brow_out6),
                      .ge_enout(ge_enout6) );


QLK0RTAU08R2V1_CH_ODD   ch7 ( .pclk(PCLK), .pclkrw(PCLKRW), .presetz(PRESETZ), .pwdata(pwdata[31:16]), .chdata(pwdata[23]),
                      .we_ts(we_ts), .we_tt(we_tt), .sel_tdr(sel_tdr[7]), .sel_tmr(sel_tmr[7]),
                      .sel_toe(sel_toe), .sel_tol(sel_tol), .sel_tom(sel_tom), .sel_to(sel_to),
                      .tau_in(TIN7), .ck0(ck0), .ck1(ck1), .nfen(NFEN7), .brow_in(brow_sel67),
                      .ck_all(ck_all_l), .tstt_all(tstt_all), .counten_all(counten_all),
                      .tcr(tcr07), .ovf(ovf[7]), .te(te[7]), .tdr(tdr07), .cks(cks7), .ccs(ccs7), .master(split7),
                      .sts(sts7), .tis(tis7), .md(md7), .toe(toe[7]), .tol(tol[7]), .tom(tom[7]),
                      .tout(TOUT7), .intout(INT7), .mck(CKEN7), .to_reset(CDEN7), .brow_out(brow_out7),
                      .ge_enout(ge_enout7) );


// Gating Contorol
QLK0RTAU08R2V1_GECTL gectl ( .ck3(ck3), .ck2(ck2), .ck1(ck1), .ck0(ck0), .we_ts(we_ts), .we_tt(we_tt),
                      .encount7(ge_enout7), .encount6(ge_enout6), .encount5(ge_enout5), .encount4(ge_enout4),
                      .encount3(ge_enout3), .encount2(ge_enout2), .encount1(ge_enout1), .encount0(ge_enout0),
                      .ck_all_l(ck_all_l), .ck_all_h(ck_all_h), .tstt_all(tstt_all), .counten_all(counten_all) );


// Channel connection of the trigger signal
QLK0RTAU08R2V1_TRGCNT tcnt23 ( .master(master2),     .brow_src1(brow_out0),       .brow_src2(brow_out2),
                      .brow_sel(brow_sel23) );


QLK0RTAU08R2V1_TRGCNT tcnt45 ( .master(master4),     .brow_src1(brow_sel23),      .brow_src2(brow_out4),
                      .brow_sel(brow_sel45) );


QLK0RTAU08R2V1_TRGCNT tcnt67 ( .master(master6),     .brow_src1(brow_sel45),      .brow_src2(brow_out6),
                      .brow_sel(brow_sel67) );


endmodule


module  QLK0RTAU08R2V1_APBIF ( psel2,    psel1,     pwrite,   penable,
                        paddr5,    paddr4,   paddr3,    paddr2,   paddr1,    paddr0,
                        prdata15,  prdata14, prdata13,  prdata12, prdata11,  prdata10, prdata9,   prdata8,
                        prdata7,   prdata6,  prdata5,   prdata4,  prdata3,   prdata2,  prdata1,   prdata0,
                        sel_tdr,   sel_tmr,  sel_to,    sel_toe,  sel_tol,   sel_tom,  sel_tps,
                        sel_tdr3_l,   sel_tdr3_h,   sel_tdr1_l,   sel_tdr1_h,
                        we_ts,     we_tt,
                        tdr07,     tdr06,    tdr05,     tdr04,    tdr03,     tdr02,    tdr01,     tdr00,    
                        tcr07,     tcr06,    tcr05,     tcr04,    tcr03,     tcr02,    tcr01,     tcr00,
                        cks7,      cks6,     cks5,      cks4,     cks3,      cks2,     cks1,      cks0,
                        ccs7,      ccs6,     ccs5,      ccs4,     ccs3,      ccs2,     ccs1,      ccs0,
                        sts7,      sts6,     sts5,      sts4,     sts3,      sts2,     sts1,      sts0,
                        tis7,      tis6,     tis5,      tis4,     tis3,      tis2,     tis1,      tis0,
                        md7,       md6,      md5,       md4,      md3,       md2,      md1,       md0,
                        split7,    master6,  split5,    master4,  split3,    master2,  split1,    master0,
                        ovf,       te,       toe,       tol,      tom,       tps,
                        tout7,     tout6,    tout5,     tout4,    tout3,     tout2,    tout1,     tout0,
                        te_h3,     te_h1 );

// PORT Define
input         psel2 ;
input         psel1 ;

input         pwrite ;
input         penable ;

input         paddr5 ;
input         paddr4 ;
input         paddr3 ;
input         paddr2 ;
input         paddr1 ;
input         paddr0 ;

input  [15:0] tdr07 ;
input  [15:0] tdr06 ;
input  [15:0] tdr05 ;
input  [15:0] tdr04 ;
input  [15:0] tdr03 ;
input  [15:0] tdr02 ;
input  [15:0] tdr01 ;
input  [15:0] tdr00 ;

input  [15:0] tcr07 ;
input  [15:0] tcr06 ;
input  [15:0] tcr05 ;
input  [15:0] tcr04 ;
input  [15:0] tcr03 ;
input  [15:0] tcr02 ;
input  [15:0] tcr01 ;
input  [15:0] tcr00 ;

input   [1:0] cks7 ;
input   [1:0] cks6 ;
input   [1:0] cks5 ;
input   [1:0] cks4 ;
input   [1:0] cks3 ;
input   [1:0] cks2 ;
input   [1:0] cks1 ;
input   [1:0] cks0 ;

input   [1:0] ccs7 ;
input   [1:0] ccs6 ;
input   [1:0] ccs5 ;
input   [1:0] ccs4 ;
input   [1:0] ccs3 ;
input   [1:0] ccs2 ;
input   [1:0] ccs1 ;
input   [1:0] ccs0 ;

input   [2:0] sts7 ;
input   [2:0] sts6 ;
input   [2:0] sts5 ;
input   [2:0] sts4 ;
input   [2:0] sts3 ;
input   [2:0] sts2 ;
input   [2:0] sts1 ;
input   [2:0] sts0 ;

input   [1:0] tis7 ;
input   [1:0] tis6 ;
input   [1:0] tis5 ;
input   [1:0] tis4 ;
input   [1:0] tis3 ;
input   [1:0] tis2 ;
input   [1:0] tis1 ;
input   [1:0] tis0 ;

input   [3:0] md7 ;
input   [3:0] md6 ;
input   [3:0] md5 ;
input   [3:0] md4 ;
input   [3:0] md3 ;
input   [3:0] md2 ;
input   [3:0] md1 ;
input   [3:0] md0 ;

input         split7 ;
input         master6 ;
input         split5 ;
input         master4 ;
input         split3 ;
input         master2 ;
input         split1 ;
input         master0 ;

input   [7:0] ovf ;
input   [7:0] te ;
input   [7:0] toe ;
input   [7:0] tol ;
input   [7:0] tom ;
input  [15:0] tps ;

input         tout7;
input         tout6;
input         tout5;
input         tout4;
input         tout3;
input         tout2;
input         tout1;
input         tout0;

input         te_h3;
input         te_h1;

output        prdata15 ;
output        prdata14 ;
output        prdata13 ;
output        prdata12 ;
output        prdata11 ;
output        prdata10 ;
output        prdata9 ;
output        prdata8 ;
output        prdata7 ;
output        prdata6 ;
output        prdata5 ;
output        prdata4 ;
output        prdata3 ;
output        prdata2 ;
output        prdata1 ;
output        prdata0 ;
output  [7:0] sel_tdr ;
output  [7:0] sel_tmr ;
output        sel_to ;
output        sel_toe ;
output        sel_tol ;
output        sel_tom ;
output        sel_tps ;

output        sel_tdr3_l;
output        sel_tdr3_h;
output        sel_tdr1_l;
output        sel_tdr1_h;

output        we_ts ;
output        we_tt ;

// Address Decode

wire  sel_e = ~paddr1 ;
wire  sel_o =  paddr1 ;


reg   [3:0]  ad_tdr;
reg   [3:0]  ad_tcr;
reg   [3:0]  ad_tmr;
reg   [3:0]  ad_tsr;
reg          ad_tste, ad_tpstt, ad_toeto, ad_tomtol;

wire  [7:0]  sel_tdr;
wire  [7:0]  sel_tmr;
wire         sel_to, sel_toe, sel_tol, sel_tom, sel_ts, sel_tt, sel_tps;
wire         sel_tdr1_l, sel_tdr1_h, sel_tdr3_l, sel_tdr3_h;
wire         douten;

always @( psel2 or psel1 or paddr5 or paddr4 or paddr3 or paddr2 ) begin
    ad_tdr    = 4'h0;
    ad_tcr    = 4'h0;
    ad_tmr    = 4'h0;
    ad_tsr    = 4'h0;
    ad_tste   = 1'b0;
    ad_tpstt  = 1'b0;
    ad_toeto  = 1'b0;
    ad_tomtol = 1'b0;

    if (psel1) begin
      case({4'b0000,paddr3,paddr2,2'b00}) 
        8'h00: ad_tdr = 4'h1;
        8'h04: ad_tdr = 4'h2;
        8'h08: ad_tdr = 4'h4;
        8'h0c: ad_tdr = 4'h8;
        default: begin
          ad_tdr    = 4'h0;
          ad_tcr    = 4'h0;
          ad_tmr    = 4'h0;
          ad_tsr    = 4'h0;
          ad_tste   = 1'b0;
          ad_tpstt  = 1'b0;
          ad_toeto  = 1'b0;
          ad_tomtol = 1'b0;
        end
      endcase
    end
    else if (psel2) begin
      case({2'b00,paddr5,paddr4,paddr3,paddr2,2'b00}) 
        8'h00: ad_tcr = 4'h1;
        8'h04: ad_tcr = 4'h2;
        8'h08: ad_tcr = 4'h4;
        8'h0c: ad_tcr = 4'h8;
        
        8'h10: ad_tmr = 4'h1;
        8'h14: ad_tmr = 4'h2;
        8'h18: ad_tmr = 4'h4;
        8'h1c: ad_tmr = 4'h8;

        8'h20: ad_tsr = 4'h1;
        8'h24: ad_tsr = 4'h2;
        8'h28: ad_tsr = 4'h4;
        8'h2c: ad_tsr = 4'h8;

        8'h30: ad_tste   = 1'b1;
        8'h34: ad_tpstt  = 1'b1;
        8'h38: ad_toeto  = 1'b1;
        8'h3c: ad_tomtol = 1'b1;
        default: begin
          ad_tdr    = 4'h0;
          ad_tcr    = 4'h0;
          ad_tmr    = 4'h0;
          ad_tsr    = 4'h0;
          ad_tste   = 1'b0;
          ad_tpstt  = 1'b0;
          ad_toeto  = 1'b0;
          ad_tomtol = 1'b0;
        end
      endcase
    end
    else begin
      ad_tdr    = 4'h0;
      ad_tcr    = 4'h0;
      ad_tmr    = 4'h0;
      ad_tsr    = 4'h0;
      ad_tste   = 1'b0;
      ad_tpstt  = 1'b0;
      ad_toeto  = 1'b0;
      ad_tomtol = 1'b0;
    end
end

// Write enable
wire   we = penable & pwrite ;

assign sel_tdr[7]  = ad_tdr[3] & sel_o & we;
assign sel_tdr[6]  = ad_tdr[3] & sel_e & we;
assign sel_tdr[5]  = ad_tdr[2] & sel_o & we;
assign sel_tdr[4]  = ad_tdr[2] & sel_e & we;
assign sel_tdr[3]  = ad_tdr[1] & sel_o & we;
assign sel_tdr[2]  = ad_tdr[1] & sel_e & we;
assign sel_tdr[1]  = ad_tdr[0] & sel_o & we;
assign sel_tdr[0]  = ad_tdr[0] & sel_e & we;

assign sel_tmr[7]  = ad_tmr[3] & sel_o & we;
assign sel_tmr[6]  = ad_tmr[3] & sel_e & we;
assign sel_tmr[5]  = ad_tmr[2] & sel_o & we;
assign sel_tmr[4]  = ad_tmr[2] & sel_e & we;
assign sel_tmr[3]  = ad_tmr[1] & sel_o & we;
assign sel_tmr[2]  = ad_tmr[1] & sel_e & we;
assign sel_tmr[1]  = ad_tmr[0] & sel_o & we;
assign sel_tmr[0]  = ad_tmr[0] & sel_e & we;

//assign sel_te      = ad_tste   & sel_e;
assign sel_ts      = ad_tste   & sel_o ;
assign sel_tt      = ad_tpstt  & sel_e ;
assign sel_tps     = ad_tpstt  & sel_o & we;
assign sel_to      = ad_toeto  & sel_e & we;
assign sel_toe     = ad_toeto  & sel_o & we;
assign sel_tol     = ad_tomtol & sel_e & we;
assign sel_tom     = ad_tomtol & sel_o & we;

assign sel_tdr1_l  = sel_tdr[1] & ~paddr0;
assign sel_tdr1_h  = sel_tdr[1] &  paddr0;
assign sel_tdr3_l  = sel_tdr[3] & ~paddr0;
assign sel_tdr3_h  = sel_tdr[3] &  paddr0;

// Write Trigger

assign we_ts = sel_ts & penable & pwrite;
assign we_tt = sel_tt & penable & pwrite;

// Read Data Select

wire    [15:0]  dout_l;
reg     [31:0]  dout;

wire    [19:0]  tau_rd;
assign tau_rd = {ad_tomtol, ad_toeto, ad_tpstt, ad_tste,
                 ad_tsr[3:0], ad_tmr[3:0], ad_tcr[3:0], ad_tdr[3:0]};

always @( tau_rd or
          tdr00 or tdr01 or tdr02 or tdr03 or tdr04 or tdr05 or tdr06 or tdr07 or
          tcr00 or tcr01 or tcr02 or tcr03 or tcr04 or tcr05 or tcr06 or tcr07 or
          cks7 or cks6 or cks5 or cks4 or cks3 or cks2 or cks1 or cks0 or
          ccs7 or ccs6 or ccs5 or ccs4 or ccs3 or ccs2 or ccs1 or ccs0 or 
          sts7 or sts6 or sts5 or sts4 or sts3 or sts2 or sts1 or sts0 or
          tis7 or tis6 or tis5 or tis4 or tis3 or tis2 or tis1 or tis0 or
          md7 or md6 or md5 or md4 or md3 or md2 or md1 or md0 or 
          split7 or master6 or split5 or master4 or split3 or master2 or split1 or master0 or
          ovf or te or te_h3 or te_h1 or toe or tol or tom or tps or
          tout7 or tout6 or tout5 or tout4 or tout3 or tout2 or tout1 or tout0 ) begin

    case(tau_rd) 
        20'b0000_0000_0000_0000_0001 : dout = {tdr01, tdr00};
        20'b0000_0000_0000_0000_0010 : dout = {tdr03, tdr02};
        20'b0000_0000_0000_0000_0100 : dout = {tdr05, tdr04};
        20'b0000_0000_0000_0000_1000 : dout = {tdr07, tdr06};

        20'b0000_0000_0000_0001_0000 : dout = {tcr01, tcr00};
        20'b0000_0000_0000_0010_0000 : dout = {tcr03, tcr02};
        20'b0000_0000_0000_0100_0000 : dout = {tcr05, tcr04};
        20'b0000_0000_0000_1000_0000 : dout = {tcr07, tcr06};

        20'b0000_0000_0001_0000_0000 : dout = {cks1, ccs1, split1,   sts1, tis1, 2'b00, md1,
                                               cks0, ccs0, master0,  sts0, tis0, 2'b00, md0};
        20'b0000_0000_0010_0000_0000 : dout = {cks3, ccs3, split3,   sts3, tis3, 2'b00, md3,
                                               cks2, ccs2, master2,  sts2, tis2, 2'b00, md2};
        20'b0000_0000_0100_0000_0000 : dout = {cks5, ccs5, split5,   sts5, tis5, 2'b00, md5,
                                               cks4, ccs4, master4,  sts4, tis4, 2'b00, md4};
        20'b0000_0000_1000_0000_0000 : dout = {cks7, ccs7, split7,   sts7, tis7, 2'b00, md7,
                                               cks6, ccs6, master6,  sts6, tis6, 2'b00, md6};

        20'b0000_0001_0000_0000_0000 : dout = {15'h0000,ovf[1], 15'h0000,ovf[0]};
        20'b0000_0010_0000_0000_0000 : dout = {15'h0000,ovf[3], 15'h0000,ovf[2]};
        20'b0000_0100_0000_0000_0000 : dout = {15'h0000,ovf[5], 15'h0000,ovf[4]};
        20'b0000_1000_0000_0000_0000 : dout = {15'h0000,ovf[7], 15'h0000,ovf[6]};

        20'b0001_0000_0000_0000_0000 : dout = {16'h0000, 4'b0000, te_h3, 1'b0, te_h1, 1'b0, te[7:0]};
        20'b0010_0000_0000_0000_0000 : dout = {tps, 16'h0000};
        20'b0100_0000_0000_0000_0000 : dout = {8'h00, toe, 8'h00, tout7,tout6,tout5,tout4,tout3,tout2,tout1,tout0};
        20'b1000_0000_0000_0000_0000 : dout = {8'h00, tom[7:0], 8'h00, tol[7:0]};
        20'b0000_0000_0000_0000_0000 : dout = 32'h0000_0000;
        default:   dout = 32'hxxxx_xxxx;
    endcase
end

// Read enable
assign douten = ~pwrite & penable;
assign dout_l = ( paddr1 ) ? dout[31:16] : dout[15:0];

assign {prdata15,prdata14,prdata13,prdata12,prdata11,prdata10,prdata9,prdata8,
        prdata7, prdata6, prdata5, prdata4, prdata3, prdata2, prdata1,prdata0}
        = ( douten ) ? dout_l : 16'h0000;

endmodule


module QLK0RTAU08R2V1_PRSU ( pclk, presetz, sel_tps, pwdata, tps );

input         pclk;
input         presetz;
input         sel_tps;
input  [15:0] pwdata;

output [15:0] tps;

reg [1:0]     tps3;
reg [1:0]     tps2;
reg [3:0]     tps1;
reg [3:0]     tps0;

// tps¥ì¥¸¥¹¥¿¤Î¥é¥¤¥È¥¤¥Í¡¼¥Ö¥ë¿®¹æ
//wire  ge_tps_wr = pwrite & penable & sel_tps;
wire  ge_tps_wr = sel_tps;

// tps¥ì¥¸¥¹¥¿
// ÆÃÊÌ¤Ê½èÃÖ¤ÎÌµ¤¤APB¥ì¥¸¥¹¥¿
always @(posedge pclk or negedge presetz) begin
  if (~presetz)        tps3 <= 2'b00;
  else if (ge_tps_wr) tps3 <= pwdata[13:12];
end

always @(posedge pclk or negedge presetz) begin
  if (~presetz)        tps2 <= 2'b00;
  else if (ge_tps_wr) tps2 <= pwdata[9:8];
end

always @(posedge pclk or negedge presetz) begin
  if (~presetz)        tps1 <= 4'b0000;
  else if (ge_tps_wr) tps1 <= pwdata[7:4];
end

always @(posedge pclk or negedge presetz) begin
  if (~presetz)        tps0 <= 4'b0000;
  else if (ge_tps_wr) tps0 <= pwdata[3:0];
end

wire [15:0] tps;
assign tps = { 2'b00, tps3, 2'b00, tps2, tps1, tps0 };


/*
// ¥×¥ê¥¹¥±¡¼¥é¥«¥¦¥ó¥¿¤Î¥²¡¼¥Æ¥£¥ó¥°¿®¹æ
// ²¼°Ì¥Ó¥Ã¥È¤Î¥­¥ã¥ê¡¼¤Ê¤·¤Ç¡¢¾å°Ì¥Ó¥Ã¥È¤Ë¥¯¥í¥Ã¥¯¤ò¶¡µë¤¹¤ë¡£
// ¥×¥ê¥¹¥±¡¼¥é¤Î3-1¤Ï¥²¡¼¥Æ¥£¥ó¥°¤·¤Ê¤¤¡£
assign up_count_en1 = (counter_reg[3:1]  ==  3'b111) & ~svstop ;
assign up_count_en2 = (counter_reg[7:1]  ==  7'b1111111) & ~svstop ;
assign up_count_en3 = (counter_reg[11:1] == 11'b11111111111) & ~svstop ;


// ck0¡Áck1¤ÎÀ¸À®¤È¡¢¥×¥ê¥¹¥±¡¼¥é3-1¡£
// tpsÀßÄêÃÍ¤Ë¤è¤ê¡¢¥Ç¥³¡¼¥É¤µ¤ì¤¿¥×¥ê¥¹¥±¡¼¥é¥¯¥í¥Ã¥¯¤òÀÚ¤êÄ¾¤·¤Æ
// ³Æ¥â¥¸¥å¡¼¥ë¤ËÀÜÂ³¤¹¤ë¡£VPSTOP»þ¤Ï¤³¤Î²óÏ©¤ò»ß¤á¤ë¡£
// Á´F/F¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤Ê¤¤¤Î¤Ï¡¢¤³¤ÎalwaysÊ¸Æâ¤Î¥ì¥¸¥¹¥¿¤À¤±¡£
//synopsys async_set_reset"presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
      counter_reg[3:1] <= 3'b111;
      ck0_pre <= 1'b0;
      ck1_pre <= 1'b0;
      ck2_pre <= 1'b0;
      ck3_pre <= 1'b0;
    end
    else if (svstop) begin
      counter_reg[3:1] <= counter_reg[3:1];
      ck0_pre <= 1'b0;
      ck1_pre <= 1'b0;
      ck2_pre <= 1'b0;
      ck3_pre <= 1'b0;
    end
    else begin
      counter_reg[3:1] <= counter_reg[3:1]+1'b1;
      ck0_pre <= ck0_sel;
      ck1_pre <= ck1_sel;
      ck2_pre <= ck2_sel;
      ck3_pre <= ck3_sel;
    end
end

wire ck0 = ck0_pre ;
wire ck1 = ck1_pre ;
wire ck2 = ck2_pre ;
wire ck3 = ck3_pre ;

// ¥×¥ê¥¹¥±¡¼¥é¤Î7-4¥Ó¥Ã¥È
//synopsys async_set_reset"presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
      counter_reg[7:4] <= 4'hf;
    end
    else if (up_count_en1) begin
      counter_reg[7:4] <= counter_reg[7:4]+1'b1;
    end
end

// ¥×¥ê¥¹¥±¡¼¥é¤Î11-8¥Ó¥Ã¥È
//synopsys async_set_reset"presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
      counter_reg[11:8] <= 4'hf;
    end
    else if (up_count_en2) begin
      counter_reg[11:8] <= counter_reg[11:8]+1'b1;
    end
end

// ¥×¥ê¥¹¥±¡¼¥é¤Î15-12¥Ó¥Ã¥È
//synopsys async_set_reset"presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
      counter_reg[15:12] <= 4'hf;
    end
    else if (up_count_en3) begin
      counter_reg[15:12] <= counter_reg[15:12]+1'b1;
    end
end

// CK0-3¤Î¥½¡¼¥¹¥¯¥í¥Ã¥¯¤Î¥Ç¥³¡¼¥É²óÏ©
// clk0¤Ï¾ï¤Ë1¤È¤Ê¤ë°Ù¡¢¤³¤³¤Ç¤ÏºîÀ®¤·¤Ê¤¤¡£
wire clk1  =         counter_reg[1];
wire clk2  = clk1  & counter_reg[2];
wire clk3  = clk2  & counter_reg[3];
wire clk4  = clk3  & counter_reg[4];
wire clk5  = clk4  & counter_reg[5];
wire clk6  = clk5  & counter_reg[6];
wire clk7  = clk6  & counter_reg[7];
wire clk8  = clk7  & counter_reg[8];
wire clk9  = clk8  & counter_reg[9];
wire clk10 = clk9  & counter_reg[10];
wire clk11 = clk10 & counter_reg[11];
wire clk12 = clk11 & counter_reg[12];
wire clk13 = clk12 & counter_reg[13];
wire clk14 = clk13 & counter_reg[14];
wire clk15 = clk14 & counter_reg[15];


// CK0¤ÎÁªÂò²óÏ©
// tps¥ì¥¸¥¹¥¿ÀßÄêÃÍ¤ÇCK0¤Î¥½¡¼¥¹¤ò·èÄê¤¹¤ë¡£
always @(tps or clk1 or clk2 or clk3 or clk4 or clk5 or clk6 or
         clk7 or clk8 or clk9 or clk10 or clk11 or clk12 or
         clk13 or clk14 or clk15 ) begin
  case (tps[3:0])
    4'h1    : ck0_sel = clk1;
    4'h2    : ck0_sel = clk2;
    4'h3    : ck0_sel = clk3;
    4'h4    : ck0_sel = clk4;
    4'h5    : ck0_sel = clk5;
    4'h6    : ck0_sel = clk6;
    4'h7    : ck0_sel = clk7;
    4'h8    : ck0_sel = clk8;
    4'h9    : ck0_sel = clk9;
    4'ha    : ck0_sel = clk10;
    4'hb    : ck0_sel = clk11;
    4'hc    : ck0_sel = clk12;
    4'hd    : ck0_sel = clk13;
    4'he    : ck0_sel = clk14;
    4'hf    : ck0_sel = clk15;
    default : ck0_sel = 1'b1;
  endcase
end

// CK1¤ÎÁªÂò²óÏ©
// tps¥ì¥¸¥¹¥¿ÀßÄêÃÍ¤ÇCK1¤Î¥½¡¼¥¹¤ò·èÄê¤¹¤ë¡£
always @(tps or clk1 or clk2 or clk3 or clk4 or clk5 or clk6 or
         clk7 or clk8 or clk9 or clk10 or clk11 or clk12 or
         clk13 or clk14 or clk15 ) begin
  case (tps[7:4])
    4'h1    : ck1_sel = clk1;
    4'h2    : ck1_sel = clk2;
    4'h3    : ck1_sel = clk3;
    4'h4    : ck1_sel = clk4;
    4'h5    : ck1_sel = clk5;
    4'h6    : ck1_sel = clk6;
    4'h7    : ck1_sel = clk7;
    4'h8    : ck1_sel = clk8;
    4'h9    : ck1_sel = clk9;
    4'ha    : ck1_sel = clk10;
    4'hb    : ck1_sel = clk11;
    4'hc    : ck1_sel = clk12;
    4'hd    : ck1_sel = clk13;
    4'he    : ck1_sel = clk14;
    4'hf    : ck1_sel = clk15;
    default : ck1_sel = 1'b1;
  endcase
end

// CK2¤ÎÁªÂò²óÏ©
// tps¥ì¥¸¥¹¥¿ÀßÄêÃÍ¤ÇCK2¤Î¥½¡¼¥¹¤ò·èÄê¤¹¤ë¡£
always @(tps or clk1 or clk2 or clk3 or clk4 or clk5 or clk6 or
         clk7 or clk8 or clk9 or clk10 or clk11 or clk12 or
         clk13 or clk14 or clk15 ) begin
  case (tps[11:8])
    4'h1    : ck2_sel = clk1;
    4'h2    : ck2_sel = clk2;
    4'h3    : ck2_sel = clk3;
    4'h4    : ck2_sel = clk4;
    4'h5    : ck2_sel = clk5;
    4'h6    : ck2_sel = clk6;
    4'h7    : ck2_sel = clk7;
    4'h8    : ck2_sel = clk8;
    4'h9    : ck2_sel = clk9;
    4'ha    : ck2_sel = clk10;
    4'hb    : ck2_sel = clk11;
    4'hc    : ck2_sel = clk12;
    4'hd    : ck2_sel = clk13;
    4'he    : ck2_sel = clk14;
    4'hf    : ck2_sel = clk15;
    default : ck2_sel = 1'b1;
  endcase
end

// CK3¤ÎÁªÂò²óÏ©
// tps¥ì¥¸¥¹¥¿ÀßÄêÃÍ¤ÇCK3¤Î¥½¡¼¥¹¤ò·èÄê¤¹¤ë¡£
always @(tps or clk1 or clk2 or clk3 or clk4 or clk5 or clk6 or
         clk7 or clk8 or clk9 or clk10 or clk11 or clk12 or
         clk13 or clk14 or clk15 ) begin
  case (tps[15:12])
    4'h1    : ck3_sel = clk1;
    4'h2    : ck3_sel = clk2;
    4'h3    : ck3_sel = clk3;
    4'h4    : ck3_sel = clk4;
    4'h5    : ck3_sel = clk5;
    4'h6    : ck3_sel = clk6;
    4'h7    : ck3_sel = clk7;
    4'h8    : ck3_sel = clk8;
    4'h9    : ck3_sel = clk9;
    4'ha    : ck3_sel = clk10;
    4'hb    : ck3_sel = clk11;
    4'hc    : ck3_sel = clk12;
    4'hd    : ck3_sel = clk13;
    4'he    : ck3_sel = clk14;
    4'hf    : ck3_sel = clk15;
    default : ck3_sel = 1'b1;
  endcase
end



// ¥¯¥í¥Ã¥¯¥²¡¼¥Æ¥£¥ó¥°ÍÑ¿®¹æ¤ÎºîÀ®
// CK3-0¤Ë¹ç¤ï¤»¤ÆÆ°ºî¤¹¤ëF/F¤Ç¡¢¸ÄÊÌ¤Ë¥²¡¼¥Æ¥£¥ó¥°¤Ç¤­¤Ê¤¤F/F¤ò¤Þ¤È¤á¤Æ
// ¥²¡¼¥Æ¥£¥ó¥°¤¹¤ë°Ù¤Ë¡¢¤³¤³¤Ç¥²¡¼¥Æ¥£¥ó¥°¿®¹æ¤òºîÀ®¡£
// ²¼°Ì8CH¤ÏCK0¤ÈCK1¤ò¡¢¾å°Ì8CH¤ÏCK2¤ÈCK3¤ò»È¤¦¡£
assign ck_all_l = ck0 | ck1;
assign ck_all_h = ck2 | ck3;

*/
endmodule


module QLK0RTAU08R2V1_CH_0 ( pclk, pclkrw, presetz, pwdata, chdata,
                    we_ts, we_tt, sel_tdr, sel_tmr, sel_toe, sel_to,
                    tau_in, ck0, ck1, nfen, brow_in, ck_all, tstt_all, counten_all,
                    tcr, ovf, te, tdr, cks, ccs, master, sts, tis, md, toe, tol, tom,
                    tout, intout, mck, to_reset, brow_out, ge_enout );

input         pclk;
input         pclkrw;
input         presetz;
input  [15:0] pwdata;
input         chdata;

input         we_ts;
input         we_tt;
input         sel_tdr;
input         sel_tmr;
input         sel_toe;
//input         sel_tol;
//input         sel_tom;
input         sel_to;

input         tau_in;
input         ck0;
input         ck1;
input         nfen;

input         brow_in;

input         ck_all;
input         tstt_all;
input         counten_all;

output [15:0] tcr;
output        ovf;
output        te;
output [15:0] tdr;
output [1:0]  cks;
output [1:0]  ccs;
output        master;
output [2:0]  sts;
output [1:0]  tis;
output [3:0]  md;
output        toe;
output        tol;
output        tom;

output        tout;
output        intout;
output        mck;       // output to CKENn
output        to_reset;  // output to CDENn
output        brow_out;

output        ge_enout;
//output        ge_toint;
//output        ge_count;

wire          init_ts;
wire          capture_mode, waiting_mode, onecnt_mode, event_mode;
wire          count_clock, count_start_trg, capture_trg;
wire          count_start_trg_out, capture_trg_out;
wire          borrow, tin_out, ti_fall_trg, ti_rise_trg;
wire          ge_intout;

wire    [1:0] ccs;
wire    [2:0] sts;

wire    ge_toint;
assign  ge_toint = to_reset | sel_to | tstt_all | intout | count_start_trg | ge_intout;

wire    ge_edge;
assign  ge_edge = (ccs[0] | sts[1] | sts[0]) & mck;


QLK0RTAU08R2V1_REGU_0  regu_0  ( .pclkrw(pclkrw), .presetz(presetz), .chdata(chdata), .pwdata(pwdata),
                          .sel_toe(sel_toe),
                          .we_ts(we_ts),          .we_tt(we_tt),         .sel_tmr(sel_tmr),
                          .tstt_all(tstt_all),    .init_ts(init_ts),
                          .toe(toe),  .tol(tol),  .tom(tom),  .te(te),  .tis(tis),  .ccs(ccs),  .sts(sts),
                          .cks(cks),  .md(md),    .master(master),
                          .capture_mode(capture_mode),  .waiting_mode(waiting_mode),  .onecnt_mode(onecnt_mode),
                          .event_mode(event_mode) );

QLK0RTAU08R2V1_COUNTER counter ( .pclk(pclk),  .presetz(presetz),  .pwdata(pwdata),  .sel_tdr(sel_tdr),
                          .capture_mode(capture_mode),  .onecnt_mode(onecnt_mode),  .md0(md[0]),
                          .count_start_trg(count_start_trg),  .count_clock(count_clock),
                          .capture_trg(capture_trg),  .count_start_trg_out(count_start_trg_out),
                          .capture_trg_out(capture_trg_out),  .init_ts(init_ts),  .ge_toint(ge_toint),
                          .tcr(tcr),  .tdr(tdr),  .to_reset(to_reset),  .brow_out(brow_out),
                          .intout(intout),  .ovf(ovf),  .borrow(borrow),  .ge_intout(ge_intout) );

QLK0RTAU08R2V1_TOCTL_0 toctl_0 ( .pclk(pclk),  .presetz(presetz),  .to_data(chdata),
                          .sel_to(sel_to),  .toe(toe),  .to_reset(to_reset), .ge_toint(ge_toint),
                          .tout(tout) );

QLK0RTAU08R2V1_FILTER  filter  ( .pclk(pclk),  .presetz(presetz),  .tau_in(tau_in),
                          .nfen(nfen),  .ge_edge(ge_edge),  .tin_out(tin_out));

QLK0RTAU08R2V1_EDGEU   edgeu   ( .pclk(pclk),  .presetz(presetz),  .tin(tin_out),
                          .ge_edge(ge_edge),  .ti_fall_trg(ti_fall_trg),  .ti_rise_trg(ti_rise_trg) );

QLK0RTAU08R2V1_TRGCTL  trgctl  ( .pclk(pclk),  .presetz(presetz),  .ti_rise_trg(ti_rise_trg),
                          .ti_fall_trg(ti_fall_trg),  .brow_in(brow_in),  .tis(tis),
                          .sts(sts),  .we_ts(we_ts),  .chdata(chdata),
                          .ccs(ccs[0]),  .cks(cks[1]),  .ck0(ck0),  .ck1(ck1),
                          .count_start_trg(count_start_trg),  .mck(mck),
                          .count_clock(count_clock),  .onecnt_mode(onecnt_mode),
                          .event_mode(event_mode),  .te(te),  .waiting_mode(waiting_mode),
                          .capture_trg(capture_trg),  .md0(md[0]),  .capture_mode(capture_mode),
                          .count_start_trg_out(count_start_trg_out),
                          .capture_trg_out(capture_trg_out),
                          .ck_all(ck_all),  .tstt_all(tstt_all),  .we_tt(we_tt),  .borrow(borrow),
                          .ge_enout(ge_enout),  .counten_all(counten_all) );

endmodule


module QLK0RTAU08R2V1_CH_EVEN ( pclk, pclkrw, presetz, pwdata, chdata,
                    we_ts, we_tt, sel_tdr, sel_tmr, sel_toe, sel_tol, sel_tom, sel_to,
                    tau_in, ck0, ck1, nfen, brow_in, ck_all, tstt_all, counten_all,
                    tcr, ovf, te, tdr, cks, ccs, master, sts, tis, md, toe, tol, tom,
                    tout, intout, mck, to_reset, brow_out, ge_enout );

input         pclk;
input         pclkrw;
input         presetz;
input  [15:0] pwdata;
input         chdata;

input         we_ts;
input         we_tt;
input         sel_tdr;
input         sel_tmr;
input         sel_toe;
input         sel_tol;
input         sel_tom;
input         sel_to;

input         tau_in;
input         ck0;
input         ck1;
input         nfen;

input         brow_in;

input         ck_all;
input         tstt_all;
input         counten_all;

output [15:0] tcr;
output        ovf;
output        te;
output [15:0] tdr;
output [1:0]  cks;
output [1:0]  ccs;
output        master;
output [2:0]  sts;
output [1:0]  tis;
output [3:0]  md;
output        toe;
output        tol;
output        tom;

output        tout;
output        intout;
output        mck;       // output to CKENn
output        to_reset;  // output to CDENn
output        brow_out;

output        ge_enout;
//output        ge_toint;
//output        ge_count;

wire          init_ts;
wire          capture_mode, waiting_mode, onecnt_mode, event_mode;
wire          count_clock, count_start_trg, capture_trg;
wire          count_start_trg_out, capture_trg_out;
wire          borrow, tin_out, ti_fall_trg, ti_rise_trg;
wire          ge_intout;

wire          to_set_d;

wire    [1:0] ccs;
wire    [2:0] sts;

wire    ge_toint;
assign  ge_toint = to_reset | sel_to | tstt_all | intout | count_start_trg | to_set_d | ge_intout;

wire    ge_edge;
assign  ge_edge = (ccs[0] | sts[1] | sts[0]) & mck;


QLK0RTAU08R2V1_REGU_EVEN  regu_e ( .pclkrw(pclkrw), .presetz(presetz), .chdata(chdata), .pwdata(pwdata),
                          .sel_toe(sel_toe),      .sel_tol(sel_tol),     .sel_tom(sel_tom),
                          .we_ts(we_ts),          .we_tt(we_tt),         .sel_tmr(sel_tmr),
                          .tstt_all(tstt_all),    .init_ts(init_ts),
                          .toe(toe),  .tol(tol),  .tom(tom),  .te(te),  .tis(tis),  .ccs(ccs),  .sts(sts),
                          .cks(cks),  .md(md),    .master(master),
                          .capture_mode(capture_mode),  .waiting_mode(waiting_mode),  .onecnt_mode(onecnt_mode),
                          .event_mode(event_mode) );

QLK0RTAU08R2V1_COUNTER counter ( .pclk(pclk),  .presetz(presetz),  .pwdata(pwdata),  .sel_tdr(sel_tdr),
                          .capture_mode(capture_mode),  .onecnt_mode(onecnt_mode),  .md0(md[0]),
                          .count_start_trg(count_start_trg),  .count_clock(count_clock),
                          .capture_trg(capture_trg),  .count_start_trg_out(count_start_trg_out),
                          .capture_trg_out(capture_trg_out),  .init_ts(init_ts),  .ge_toint(ge_toint),
                          .tcr(tcr),  .tdr(tdr),  .to_reset(to_reset),  .brow_out(brow_out),
                          .intout(intout),  .ovf(ovf),  .borrow(borrow),  .ge_intout(ge_intout) );

QLK0RTAU08R2V1_TOCTL   toctl   ( .pclk(pclk),  .presetz(presetz),  .to_data(chdata),
                          .sel_to(sel_to),  .toe(toe),  .tom(tom),  .tol(tol),
                          .to_reset(to_reset),  .to_set(brow_in),  .count_clock(count_clock),
                          .ge_toint(ge_toint),  .ck_all(ck_all),  .tstt_all(tstt_all),
                          .tout(tout), .to_set_d(to_set_d) );

QLK0RTAU08R2V1_FILTER  filter  ( .pclk(pclk),  .presetz(presetz),  .tau_in(tau_in),
                          .nfen(nfen),  .ge_edge(ge_edge),  .tin_out(tin_out));

QLK0RTAU08R2V1_EDGEU   edgeu   ( .pclk(pclk),  .presetz(presetz),  .tin(tin_out),
                          .ge_edge(ge_edge),  .ti_fall_trg(ti_fall_trg),  .ti_rise_trg(ti_rise_trg) );

QLK0RTAU08R2V1_TRGCTL  trgctl  ( .pclk(pclk),  .presetz(presetz),  .ti_rise_trg(ti_rise_trg),
                          .ti_fall_trg(ti_fall_trg),  .brow_in(brow_in),  .tis(tis),
                          .sts(sts),  .we_ts(we_ts),  .chdata(chdata),
                          .ccs(ccs[0]),  .cks(cks[1]),  .ck0(ck0),  .ck1(ck1),
                          .count_start_trg(count_start_trg),  .mck(mck),
                          .count_clock(count_clock),  .onecnt_mode(onecnt_mode),
                          .event_mode(event_mode),  .te(te),  .waiting_mode(waiting_mode),
                          .capture_trg(capture_trg),  .md0(md[0]),  .capture_mode(capture_mode),
                          .count_start_trg_out(count_start_trg_out),
                          .capture_trg_out(capture_trg_out),
                          .ck_all(ck_all),  .tstt_all(tstt_all),  .we_tt(we_tt),  .borrow(borrow),
                          .ge_enout(ge_enout),  .counten_all(counten_all) );

endmodule


module QLK0RTAU08R2V1_CH_SPLIT ( pclk, pclkrw, presetz, pwdata, chdata,
                    we_ts, we_tt, sel_tdr, sel_tmr, sel_toe, sel_tol, sel_tom, sel_to,
                    tau_in, ck0, ck1, nfen, brow_in, ck_all, tstt_all, counten_all,
                    tcr, ovf, te, tdr, cks, ccs, master, sts, tis, md, toe, tol, tom,
                    tout, intout, mck, to_reset, brow_out, ge_enout,
                    ck2, ck3, chdata_h, sel_tdr_l, sel_tdr_h, intout_h, te_h );

input         pclk;
input         pclkrw;
input         presetz;
input  [15:0] pwdata;
input         chdata;

input         we_ts;
input         we_tt;
input         sel_tdr;
input         sel_tmr;
input         sel_toe;
input         sel_tol;
input         sel_tom;
input         sel_to;

input         tau_in;
input         ck0;
input         ck1;
input         nfen;

input         brow_in;

input         ck_all;
input         tstt_all;
input         counten_all;

output [15:0] tcr;
output        ovf;
output        te;
output [15:0] tdr;
output [1:0]  cks;
output [1:0]  ccs;
output        master;
output [2:0]  sts;
output [1:0]  tis;
output [3:0]  md;
output        toe;
output        tol;
output        tom;

output        tout;
output        intout;
output        mck;       // output to CKENn
output        to_reset;  // output to CDENn
output        brow_out;

output        ge_enout;
//output        ge_toint;
//output        ge_count;


// for split mode (16bit -> 8bit)
input         ck2;
input         ck3;
input         chdata_h;
input         sel_tdr_l;
input         sel_tdr_h;

output        intout_h;
output        te_h;

wire          init_ts;
wire          capture_mode, waiting_mode, onecnt_mode, event_mode;
wire          count_clock, count_start_trg, capture_trg;
wire          count_start_trg_out, capture_trg_out;
wire          borrow, tin_out, ti_fall_trg, ti_rise_trg;
wire          ge_intout;

wire          to_set_d;
wire          count_start_trg_h, count_clock_h, to_reset_h, ge_intout_h;

wire    [1:0] ccs;
wire    [2:0] sts;

wire    ge_toint;
assign  ge_toint = to_reset | sel_to | tstt_all | intout | count_start_trg | to_set_d | ge_intout
                 | to_reset_h | intout_h | count_start_trg_h | ge_intout_h;
                 
wire    ge_edge;
assign  ge_edge = (ccs[0] | sts[1] | sts[0]) & mck;


QLK0RTAU08R2V1_REGU_13   regu_13 ( .pclkrw(pclkrw), .presetz(presetz), .chdata(chdata), .pwdata(pwdata),
                          .sel_toe(sel_toe),      .sel_tol(sel_tol),     .sel_tom(sel_tom),
                          .we_ts(we_ts),          .we_tt(we_tt),         .sel_tmr(sel_tmr),
                          .tstt_all(tstt_all),    .init_ts(init_ts),
                          .toe(toe),  .tol(tol),  .tom(tom),  .te(te),  .tis(tis),  .ccs(ccs),  .sts(sts),
                          .cks(cks),  .md(md),    .master(master),
                          .capture_mode(capture_mode),  .waiting_mode(waiting_mode),  .onecnt_mode(onecnt_mode),
                          .event_mode(event_mode),
                     // for split mode (16bit -> 8bit)
                          .chdata_h(chdata_h),    .te_h(te_h) );

QLK0RTAU08R2V1_COUNTER_H counter_h ( .pclk(pclk),  .presetz(presetz),  .pwdata(pwdata),  .sel_tdr(sel_tdr),
                          .capture_mode(capture_mode),  .onecnt_mode(onecnt_mode),  .md0(md[0]),
                          .count_start_trg(count_start_trg),  .count_clock(count_clock),
                          .capture_trg(capture_trg),  .count_start_trg_out(count_start_trg_out),
                          .capture_trg_out(capture_trg_out),  .init_ts(init_ts),  .ge_toint(ge_toint),
                          .tcr(tcr),  .tdr(tdr),  .to_reset(to_reset),  .brow_out(brow_out),
                          .intout(intout),  .ovf(ovf),  .borrow(borrow),  .ge_intout(ge_intout),
                     // for split mode (16bit -> 8bit)
                          .count_start_trg_h(count_start_trg_h),  .count_clock_h(count_clock_h),
                          .sel_tdr_l(sel_tdr_l),  .sel_tdr_h(sel_tdr_h),  .split(master),
                          .intout_h(intout_h), .to_reset_h(to_reset_h), .ge_intout_h(ge_intout_h) );

QLK0RTAU08R2V1_TOCTL   toctl   ( .pclk(pclk),  .presetz(presetz),  .to_data(chdata),
                          .sel_to(sel_to),  .toe(toe),  .tom(tom),  .tol(tol),
                          .to_reset(to_reset),  .to_set(brow_in),  .count_clock(count_clock),
                          .ge_toint(ge_toint),  .ck_all(ck_all),  .tstt_all(tstt_all),
                          .tout(tout), .to_set_d(to_set_d) );

QLK0RTAU08R2V1_FILTER  filter  ( .pclk(pclk),  .presetz(presetz),  .tau_in(tau_in),
                          .nfen(nfen),  .ge_edge(ge_edge),  .tin_out(tin_out));

QLK0RTAU08R2V1_EDGEU   edgeu   ( .pclk(pclk),  .presetz(presetz),  .tin(tin_out),
                          .ge_edge(ge_edge),  .ti_fall_trg(ti_fall_trg),  .ti_rise_trg(ti_rise_trg) );

QLK0RTAU08R2V1_TRGCTL_H  trgctl_h  ( .pclk(pclk),  .presetz(presetz),  .ti_rise_trg(ti_rise_trg),
                          .ti_fall_trg(ti_fall_trg),  .brow_in(brow_in),  .tis(tis),
                          .sts(sts),  .we_ts(we_ts),  .chdata(chdata),
                          .ccs(ccs[0]),  .cks(cks),  .ck0(ck0),  .ck1(ck1),
                          .count_start_trg(count_start_trg),  .mck(mck),
                          .count_clock(count_clock),  .onecnt_mode(onecnt_mode),
                          .event_mode(event_mode),  .te(te),  .waiting_mode(waiting_mode),
                          .capture_trg(capture_trg),  .md0(md[0]),  .capture_mode(capture_mode),
                          .count_start_trg_out(count_start_trg_out),
                          .capture_trg_out(capture_trg_out),
                          .ck_all(ck_all),  .tstt_all(tstt_all),  .we_tt(we_tt),  .borrow(borrow),
                          .ge_enout(ge_enout),  .counten_all(counten_all),
                     // for split mode (16bit -> 8bit)
                          .ck2(ck2), .ck3(ck3), .split(master), .chdata_h(chdata_h),
                          .count_start_trg_h(count_start_trg_h),  .count_clock_h(count_clock_h) );

endmodule


module QLK0RTAU08R2V1_CH_ODD ( pclk, pclkrw, presetz, pwdata, chdata,
                    we_ts, we_tt, sel_tdr, sel_tmr, sel_toe, sel_tol, sel_tom, sel_to,
                    tau_in, ck0, ck1, nfen, brow_in, ck_all, tstt_all, counten_all,
                    tcr, ovf, te, tdr, cks, ccs, master, sts, tis, md, toe, tol, tom,
                    tout, intout, mck, to_reset, brow_out, ge_enout );

input         pclk;
input         pclkrw;
input         presetz;
input  [15:0] pwdata;
input         chdata;

input         we_ts;
input         we_tt;
input         sel_tdr;
input         sel_tmr;
input         sel_toe;
input         sel_tol;
input         sel_tom;
input         sel_to;

input         tau_in;
input         ck0;
input         ck1;
input         nfen;

input         brow_in;

input         ck_all;
input         tstt_all;
input         counten_all;

output [15:0] tcr;
output        ovf;
output        te;
output [15:0] tdr;
output [1:0]  cks;
output [1:0]  ccs;
output        master;
output [2:0]  sts;
output [1:0]  tis;
output [3:0]  md;
output        toe;
output        tol;
output        tom;

output        tout;
output        intout;
output        mck;       // output to CKENn
output        to_reset;  // output to CDENn
output        brow_out;

output        ge_enout;
//output        ge_toint;
//output        ge_count;

wire          init_ts;
wire          capture_mode, waiting_mode, onecnt_mode, event_mode;
wire          count_clock, count_start_trg, capture_trg;
wire          count_start_trg_out, capture_trg_out;
wire          borrow, tin_out, ti_fall_trg, ti_rise_trg;
wire          ge_intout;

wire          to_set_d;

wire    [1:0] ccs;
wire    [2:0] sts;

wire    ge_toint;
assign  ge_toint = to_reset | sel_to | tstt_all | intout | count_start_trg | to_set_d | ge_intout;

wire    ge_edge;
assign  ge_edge = (ccs[0] | sts[1] | sts[0]) & mck;


QLK0RTAU08R2V1_REGU_57 regu_57 ( .pclkrw(pclkrw), .presetz(presetz), .chdata(chdata), .pwdata(pwdata),
                          .sel_toe(sel_toe),      .sel_tol(sel_tol),     .sel_tom(sel_tom),
                          .we_ts(we_ts),          .we_tt(we_tt),         .sel_tmr(sel_tmr),
                          .tstt_all(tstt_all),    .init_ts(init_ts),
                          .toe(toe),  .tol(tol),  .tom(tom),  .te(te),  .tis(tis),  .ccs(ccs),  .sts(sts),
                          .cks(cks),  .md(md),    .master(master),
                          .capture_mode(capture_mode),  .waiting_mode(waiting_mode),  .onecnt_mode(onecnt_mode),
                          .event_mode(event_mode) );

QLK0RTAU08R2V1_COUNTER counter ( .pclk(pclk),  .presetz(presetz),  .pwdata(pwdata),  .sel_tdr(sel_tdr),
                          .capture_mode(capture_mode),  .onecnt_mode(onecnt_mode),  .md0(md[0]),
                          .count_start_trg(count_start_trg),  .count_clock(count_clock),
                          .capture_trg(capture_trg),  .count_start_trg_out(count_start_trg_out),
                          .capture_trg_out(capture_trg_out),  .init_ts(init_ts),  .ge_toint(ge_toint),
                          .tcr(tcr),  .tdr(tdr),  .to_reset(to_reset),  .brow_out(brow_out),
                          .intout(intout),  .ovf(ovf),  .borrow(borrow),  .ge_intout(ge_intout) );

QLK0RTAU08R2V1_TOCTL   toctl   ( .pclk(pclk),  .presetz(presetz),  .to_data(chdata),
                          .sel_to(sel_to),  .toe(toe),  .tom(tom),  .tol(tol),
                          .to_reset(to_reset),  .to_set(brow_in),  .count_clock(count_clock),
                          .ge_toint(ge_toint),  .ck_all(ck_all),  .tstt_all(tstt_all),
                          .tout(tout), .to_set_d(to_set_d) );

QLK0RTAU08R2V1_FILTER  filter  ( .pclk(pclk),  .presetz(presetz),  .tau_in(tau_in),
                          .nfen(nfen),  .ge_edge(ge_edge),  .tin_out(tin_out));

QLK0RTAU08R2V1_EDGEU   edgeu   ( .pclk(pclk),  .presetz(presetz),  .tin(tin_out),
                          .ge_edge(ge_edge),  .ti_fall_trg(ti_fall_trg),  .ti_rise_trg(ti_rise_trg) );

QLK0RTAU08R2V1_TRGCTL  trgctl  ( .pclk(pclk),  .presetz(presetz),  .ti_rise_trg(ti_rise_trg),
                          .ti_fall_trg(ti_fall_trg),  .brow_in(brow_in),  .tis(tis),
                          .sts(sts),  .we_ts(we_ts),  .chdata(chdata),
                          .ccs(ccs[0]),  .cks(cks[1]),  .ck0(ck0),  .ck1(ck1),
                          .count_start_trg(count_start_trg),  .mck(mck),
                          .count_clock(count_clock),  .onecnt_mode(onecnt_mode),
                          .event_mode(event_mode),  .te(te),  .waiting_mode(waiting_mode),
                          .capture_trg(capture_trg),  .md0(md[0]),  .capture_mode(capture_mode),
                          .count_start_trg_out(count_start_trg_out),
                          .capture_trg_out(capture_trg_out),
                          .ck_all(ck_all),  .tstt_all(tstt_all),  .we_tt(we_tt),  .borrow(borrow),
                          .ge_enout(ge_enout),  .counten_all(counten_all) );

endmodule


module  QLK0RTAU08R2V1_REGU_0 ( pclkrw,  presetz,  chdata,  pwdata,
                       sel_toe,  we_ts,  we_tt,  sel_tmr,
                       tstt_all, init_ts,
                       toe,      tol,    tom,      te,
                       tis,      ccs,    sts,      cks,     master,  md,
                       capture_mode, waiting_mode, onecnt_mode, event_mode );

input         pclkrw; 
input         presetz;
input         chdata;
input  [15:0] pwdata;
input         sel_toe;
//input         sel_tol;
//input         sel_tom;
input         we_ts;
input         we_tt;
input         sel_tmr;

input         tstt_all;

output        init_ts;

output        toe;
output        tol;
output        tom;
output        te;

output [1:0]  tis;
output [1:0]  ccs;
output [2:0]  sts;
output [1:0]  cks;
output        master;
output [3:0]  md;


output        capture_mode;
output        waiting_mode;
output        onecnt_mode;
output        event_mode;

// ¥¿¥¤¥Þ½ÐÎÏ¥¤¥Í¡¼¥Ö¥ë¥ì¥¸¥¹¥¿
// we_toe¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg  toe;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)      toe <= 1'b0;
    else if (sel_toe) toe <= chdata;
end

/*
// ¥¿¥¤¥Þ½ÐÎÏ¥ì¥Ù¥ëÀßÄê¥ì¥¸¥¹¥¿
// we_tol¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg tol;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)      tol <= 1'b0;
    else if (sel_tol) tol <= chdata;
end

// ¥¿¥¤¥Þ½ÐÎÏ¥â¡¼¥ÉÀßÄê¥ì¥¸¥¹¥¿
// we_tom¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg tom;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)      tom <= 1'b0;
    else if (sel_tom) tom <= chdata;
end
*/
wire tom, tol;
assign tom = 1'b0;
assign tol = 1'b0;

// ¥Á¥ã¥Í¥ë¥¤¥Í¡¼¥Ö¥ë¥ì¥¸¥¹¥¿
// ts¥ì¥¸¥¹¥¿1½ñ¤­¹þ¤ß¤Ç¥»¥Ã¥È¤µ¤ì¡¢tt¥ì¥¸¥¹¥¿1½ñ¤­¹þ¤ß¤Ç¥¯¥ê¥¢¤µ¤ì¤ë
// tstt_all¿®¹æ¤Ï¡¢ts¥ì¥¸¥¹¥¿¥é¥¤¥È¿®¹æ¤Ètt¥ì¥¸¥¹¥¿¥é¥¤¥È¿®¹æ¤ÎOR¡£
reg  te;
wire te_data;
//wire ge_te_reg = penable & pwrite & tstt_all;
wire ge_te_reg = tstt_all;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if(~presetz)          te <= 1'b0;
    else if(ge_te_reg)   te <= te_data;
end

// tt¥ì¥¸¥¹¥¿
// APB·ÐÍ³¤Î1½ñ¤­¹þ¤ß¤Ç¥»¥Ã¥È¤µ¤ì¡¢¥«¥¦¥ó¥È¥¤¥Í¡¼¥Ö¥ë¤¬¥»¥Ã¥È¤µ¤ì¤ë¤È¥¯¥ê¥¢¤¹¤ë¡£
// ½ñ¤­¹þ¤ßÍÑ¤Îchdata¤òÊÌ³¬ÁØ¤ÇºîÀ®¤·¤Æ¤¤¤ë¤Î¤Ï¡¢¥²¡¼¥Æ¥£¥ó¥°ÏÀÍý¤È¥Ç¡¼¥¿ÏÀÍý¤¬
// ½ÌÂà¤µ¤ì¤ë¤Î¤òËÉ¤°°Ù¡£
// Data Sub Module for PowerCompiler
//wire  we_ts = penable & pwrite & sel_ts ;
//wire  we_tt = penable & pwrite & sel_tt ;
wire  init_ts = we_ts & chdata & ~te ;     // Start initialize signal for ovf

QLK0RTAU08R2V1_REGU_GL regu_gl ( .chdata(chdata) , .we_ts(we_ts), .we_tt(we_tt), .te(te), .te_data(te_data) );


// TMR Register
reg [1:0] tis;
//reg [1:0] ccs;
reg       ccs0bit;
reg [2:0] sts;
//reg       cks;
reg       cks1bit;
//reg       master;
reg [3:0] md;

// ¥â¡¼¥É¥ì¥¸¥¹¥¿
// ÉáÄÌ¤ÎAPB¥ì¥¸¥¹¥¿¤ÇÆÃÊÌ¤Ê½èÃÖ¤Ï¤Ê¤¤¡£
// synopsys async_set_reset "presetz"
always @(posedge pclkrw or negedge presetz) begin
    if(~presetz) begin
      cks1bit <= 1'b0;
      ccs0bit <= 1'b0;
//      master <= 1'b0;
      sts <= 3'b000;
      tis <= 2'b00;
      md <=4 'b0000;
    end
    else if(sel_tmr) begin
      cks1bit <= pwdata[15];
      ccs0bit <= pwdata[12];
//      master <= pwdata[11];
      sts <= pwdata[10:8];
      tis <= pwdata[7:6];
      md <= pwdata[3:0];
    end
end

wire [1:0] cks = { cks1bit, 1'b0 };
wire [1:0] ccs = { 1'b0, ccs0bit };
wire       master = 1'b0;

// mode decoder
reg  capture_mode;
reg  waiting_mode;
reg  onecnt_mode;
reg  event_mode;


// Æ°ºî¥â¡¼¥É¤Î¥Ç¥³¡¼¥À
// CH¤ÎÆ°ºî¥â¡¼¥É¤ò¤³¤³¤Ç·èÄê¤·¤Æ¡¢³Æ¥â¥¸¥å¡¼¥ë¤Ç»ÈÍÑ¤¹¤ë¡£
// waiting_mode¿®¹æ¤Ï¡¢¥½¥Õ¥È¥¦¥§¥¢¥È¥ê¥¬¤Ç¥«¥¦¥ó¥È¥¹¥¿¡¼¥È¤»¤º¡¢te=1¾õÂÖ¤Ç¥¹¥¿¡¼¥È¥È¥ê¥¬¤¬
// ÆþÎÏ¤µ¤ì¤Æ½é¤á¤Æ¥«¥¦¥ó¥ÈÆ°ºî¤ò¹Ô¤¦¥â¡¼¥ÉÍÑ¤Î¿®¹æ¡£
always @(md) begin
  case(md[3:1]) 
   3'b000 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0000; // interval mode
   3'b001 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0000; // judge mode
   3'b010 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b1000; // capture mode
   3'b011 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0001; // event count mode
   3'b100 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0110; // onecount mode
   3'b101 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0100; // trigger start
   3'b110 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b1110; // capture & onecount mode
   default:{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0110; // judge & onecount mode
  endcase
end


endmodule



module  QLK0RTAU08R2V1_REGU_13 ( pclkrw,  presetz,  chdata,  pwdata,
                       sel_toe,  sel_tol,  sel_tom,  we_ts,  we_tt,  sel_tmr,
                       tstt_all, init_ts,
                       toe,      tol,    tom,      te,
                       tis,      ccs,    sts,      cks,     master,  md,
                       capture_mode, waiting_mode, onecnt_mode, event_mode,
                       chdata_h, te_h );

input         pclkrw; 
input         presetz;
input         chdata;
input  [15:0] pwdata;
input         sel_toe;
input         sel_tol;
input         sel_tom;
input         we_ts;
input         we_tt;
input         sel_tmr;

input         tstt_all;

output        init_ts;

output        toe;
output        tol;
output        tom;
output        te;

output [1:0]  tis;
output [1:0]  ccs;
output [2:0]  sts;
output [1:0]  cks;
output        master;
output [3:0]  md;

output        capture_mode;
output        waiting_mode;
output        onecnt_mode;
output        event_mode;

// for split mode (16bit -> 8bit)
input         chdata_h;
output        te_h;

// ¥¿¥¤¥Þ½ÐÎÏ¥¤¥Í¡¼¥Ö¥ë¥ì¥¸¥¹¥¿
// we_toe¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg  toe;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)     toe <= 1'b0;
    else if (sel_toe) toe <= chdata;
end

// ¥¿¥¤¥Þ½ÐÎÏ¥ì¥Ù¥ëÀßÄê¥ì¥¸¥¹¥¿
// we_tol¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg tol;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)     tol <= 1'b0;
    else if (sel_tol) tol <= chdata;
end

// ¥¿¥¤¥Þ½ÐÎÏ¥â¡¼¥ÉÀßÄê¥ì¥¸¥¹¥¿
// we_tom¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg tom;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)     tom <= 1'b0;
    else if (sel_tom) tom <= chdata;
end

// ¥Á¥ã¥Í¥ë¥¤¥Í¡¼¥Ö¥ë¥ì¥¸¥¹¥¿
// ts¥ì¥¸¥¹¥¿1½ñ¤­¹þ¤ß¤Ç¥»¥Ã¥È¤µ¤ì¡¢tt¥ì¥¸¥¹¥¿1½ñ¤­¹þ¤ß¤Ç¥¯¥ê¥¢¤µ¤ì¤ë
// tstt_all¿®¹æ¤Ï¡¢ts¥ì¥¸¥¹¥¿¥é¥¤¥È¿®¹æ¤Ètt¥ì¥¸¥¹¥¿¥é¥¤¥È¿®¹æ¤ÎOR¡£
reg  te;
wire te_data;
wire ge_te_reg = tstt_all;
always @( posedge pclkrw or negedge presetz ) begin
    if(~presetz)          te <= 1'b0;
    else if(ge_te_reg)   te <= te_data;
end

// te_h
reg  te_h;
wire te_data_h;
always @( posedge pclkrw or negedge presetz ) begin
    if(~presetz)          te_h <= 1'b0;
    else if(ge_te_reg)   te_h <= te_data_h;
end


// tt¥ì¥¸¥¹¥¿
// APB·ÐÍ³¤Î1½ñ¤­¹þ¤ß¤Ç¥»¥Ã¥È¤µ¤ì¡¢¥«¥¦¥ó¥È¥¤¥Í¡¼¥Ö¥ë¤¬¥»¥Ã¥È¤µ¤ì¤ë¤È¥¯¥ê¥¢¤¹¤ë¡£
// ½ñ¤­¹þ¤ßÍÑ¤Îchdata¤òÊÌ³¬ÁØ¤ÇºîÀ®¤·¤Æ¤¤¤ë¤Î¤Ï¡¢¥²¡¼¥Æ¥£¥ó¥°ÏÀÍý¤È¥Ç¡¼¥¿ÏÀÍý¤¬
// ½ÌÂà¤µ¤ì¤ë¤Î¤òËÉ¤°°Ù¡£
// Data Sub Module for PowerCompiler
//wire  we_ts = penable & pwrite & sel_ts ;
//wire  we_tt = penable & pwrite & sel_tt ;
wire  init_ts = we_ts & chdata & ~te ;     // Start initialize signal for ovf

wire  sp_chdata_h = chdata_h & master;

QLK0RTAU08R2V1_REGU_GL rgl_odd1l ( .chdata(chdata) , .we_ts(we_ts), .we_tt(we_tt), .te(te), .te_data(te_data) );
QLK0RTAU08R2V1_REGU_GL rgl_odd1h ( .chdata(sp_chdata_h) , .we_ts(we_ts), .we_tt(we_tt), .te(te_h), .te_data(te_data_h) );


// TMR Register
reg [1:0] tis;
//reg [1:0] ccs;
reg       ccs0bit;
reg [2:0] sts;
reg [1:0] cks;
reg       master;
reg [3:0] md;

// ¥â¡¼¥É¥ì¥¸¥¹¥¿
// ÉáÄÌ¤ÎAPB¥ì¥¸¥¹¥¿¤ÇÆÃÊÌ¤Ê½èÃÖ¤Ï¤Ê¤¤¡£
// synopsys async_set_reset "presetz"
always @(posedge pclkrw or negedge presetz) begin
    if(~presetz) begin
      cks <= 2'b00;
      ccs0bit <= 1'b0;
      master <= 1'b0;
      sts <= 3'b000;
      tis <= 2'b00;
      md <=4 'b0000;
    end
    else if(sel_tmr) begin
      cks <= pwdata[15:14];
      ccs0bit <= pwdata[12];
      master <= pwdata[11];
      sts <= pwdata[10:8];
      tis <= pwdata[7:6];
      md <= pwdata[3:0];
    end
end

wire [1:0] ccs = { 1'b0, ccs0bit };

// mode decoder
reg  capture_mode;
reg  waiting_mode;
reg  onecnt_mode;
reg  event_mode;


// Æ°ºî¥â¡¼¥É¤Î¥Ç¥³¡¼¥À
// CH¤ÎÆ°ºî¥â¡¼¥É¤ò¤³¤³¤Ç·èÄê¤·¤Æ¡¢³Æ¥â¥¸¥å¡¼¥ë¤Ç»ÈÍÑ¤¹¤ë¡£
// waiting_mode¿®¹æ¤Ï¡¢¥½¥Õ¥È¥¦¥§¥¢¥È¥ê¥¬¤Ç¥«¥¦¥ó¥È¥¹¥¿¡¼¥È¤»¤º¡¢te=1¾õÂÖ¤Ç¥¹¥¿¡¼¥È¥È¥ê¥¬¤¬
// ÆþÎÏ¤µ¤ì¤Æ½é¤á¤Æ¥«¥¦¥ó¥ÈÆ°ºî¤ò¹Ô¤¦¥â¡¼¥ÉÍÑ¤Î¿®¹æ¡£
always @(md) begin
  case(md[3:1])
   3'b000 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0000; // interval mode
   3'b001 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0000; // judge mode
   3'b010 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b1000; // capture mode
   3'b011 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0001; // event count mode
   3'b100 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0110; // onecount mode
   3'b101 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0100; // trigger start
   3'b110 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b1110; // capture & onecount mode
   default:{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0110; // judge & onecount mode
  endcase
end


endmodule



module  QLK0RTAU08R2V1_REGU_EVEN ( pclkrw,  presetz,  chdata,  pwdata,
                       sel_toe,  sel_tol,  sel_tom,  we_ts,  we_tt,  sel_tmr,
                       tstt_all, init_ts,
                       toe,      tol,    tom,      te,
                       tis,      ccs,    sts,      cks,     master,  md,
                       capture_mode, waiting_mode, onecnt_mode, event_mode );

input         pclkrw; 
input         presetz;
input         chdata;
input  [15:0] pwdata;
input         sel_toe;
input         sel_tol;
input         sel_tom;
input         we_ts;
input         we_tt;
input         sel_tmr;

input         tstt_all;

output        init_ts;

output        toe;
output        tol;
output        tom;
output        te;

output [1:0]  tis;
output [1:0]  ccs;
output [2:0]  sts;
output [1:0]  cks;
output        master;
output [3:0]  md;

output        capture_mode;
output        waiting_mode;
output        onecnt_mode;
output        event_mode;

// ¥¿¥¤¥Þ½ÐÎÏ¥¤¥Í¡¼¥Ö¥ë¥ì¥¸¥¹¥¿
// we_toe¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg  toe;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)      toe <= 1'b0;
    else if (sel_toe) toe <= chdata;
end

// ¥¿¥¤¥Þ½ÐÎÏ¥ì¥Ù¥ëÀßÄê¥ì¥¸¥¹¥¿
// we_tol¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg tol;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)      tol <= 1'b0;
    else if (sel_tol) tol <= chdata;
end

// ¥¿¥¤¥Þ½ÐÎÏ¥â¡¼¥ÉÀßÄê¥ì¥¸¥¹¥¿
// we_tom¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg tom;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)      tom <= 1'b0;
    else if (sel_tom) tom <= chdata;
end

// ¥Á¥ã¥Í¥ë¥¤¥Í¡¼¥Ö¥ë¥ì¥¸¥¹¥¿
// ts¥ì¥¸¥¹¥¿1½ñ¤­¹þ¤ß¤Ç¥»¥Ã¥È¤µ¤ì¡¢tt¥ì¥¸¥¹¥¿1½ñ¤­¹þ¤ß¤Ç¥¯¥ê¥¢¤µ¤ì¤ë
// tstt_all¿®¹æ¤Ï¡¢ts¥ì¥¸¥¹¥¿¥é¥¤¥È¿®¹æ¤Ètt¥ì¥¸¥¹¥¿¥é¥¤¥È¿®¹æ¤ÎOR¡£
reg  te;
wire te_data;
wire ge_te_reg = tstt_all;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if(~presetz)          te <= 1'b0;
    else if(ge_te_reg)   te <= te_data;
end

// tt¥ì¥¸¥¹¥¿
// APB·ÐÍ³¤Î1½ñ¤­¹þ¤ß¤Ç¥»¥Ã¥È¤µ¤ì¡¢¥«¥¦¥ó¥È¥¤¥Í¡¼¥Ö¥ë¤¬¥»¥Ã¥È¤µ¤ì¤ë¤È¥¯¥ê¥¢¤¹¤ë¡£
// ½ñ¤­¹þ¤ßÍÑ¤Îchdata¤òÊÌ³¬ÁØ¤ÇºîÀ®¤·¤Æ¤¤¤ë¤Î¤Ï¡¢¥²¡¼¥Æ¥£¥ó¥°ÏÀÍý¤È¥Ç¡¼¥¿ÏÀÍý¤¬
// ½ÌÂà¤µ¤ì¤ë¤Î¤òËÉ¤°°Ù¡£
// Data Sub Module for PowerCompiler
//wire  we_ts = penable & pwrite & sel_ts ;
//wire  we_tt = penable & pwrite & sel_tt ;
wire  init_ts = we_ts & chdata & ~te ;     // Start initialize signal for ovf

QLK0RTAU08R2V1_REGU_GL regu_gl ( .chdata(chdata) , .we_ts(we_ts), .we_tt(we_tt), .te(te), .te_data(te_data) );


// TMR Register
reg [1:0] tis;
//reg [1:0] ccs;
reg       ccs0bit;
reg [2:0] sts;
//reg       cks;
reg       cks1bit;
reg       master;
reg [3:0] md;

// ¥â¡¼¥É¥ì¥¸¥¹¥¿
// ÉáÄÌ¤ÎAPB¥ì¥¸¥¹¥¿¤ÇÆÃÊÌ¤Ê½èÃÖ¤Ï¤Ê¤¤¡£
// synopsys async_set_reset "presetz"
always @(posedge pclkrw or negedge presetz) begin
    if(~presetz) begin
      cks1bit <= 1'b0;
      ccs0bit <= 1'b0;
      master <= 1'b0;
      sts <= 3'b000;
      tis <= 2'b00;
      md <=4 'b0000;
    end
    else if(sel_tmr) begin
      cks1bit <= pwdata[15];
      ccs0bit <= pwdata[12];
      master <= pwdata[11];
      sts <= pwdata[10:8];
      tis <= pwdata[7:6];
      md <= pwdata[3:0];
    end
end

wire [1:0] cks = { cks1bit, 1'b0 };
wire [1:0] ccs = { 1'b0, ccs0bit };


// mode decoder
reg  capture_mode;
reg  waiting_mode;
reg  onecnt_mode;
reg  event_mode;


// Æ°ºî¥â¡¼¥É¤Î¥Ç¥³¡¼¥À
// CH¤ÎÆ°ºî¥â¡¼¥É¤ò¤³¤³¤Ç·èÄê¤·¤Æ¡¢³Æ¥â¥¸¥å¡¼¥ë¤Ç»ÈÍÑ¤¹¤ë¡£
// waiting_mode¿®¹æ¤Ï¡¢¥½¥Õ¥È¥¦¥§¥¢¥È¥ê¥¬¤Ç¥«¥¦¥ó¥È¥¹¥¿¡¼¥È¤»¤º¡¢te=1¾õÂÖ¤Ç¥¹¥¿¡¼¥È¥È¥ê¥¬¤¬
// ÆþÎÏ¤µ¤ì¤Æ½é¤á¤Æ¥«¥¦¥ó¥ÈÆ°ºî¤ò¹Ô¤¦¥â¡¼¥ÉÍÑ¤Î¿®¹æ¡£
always @(md) begin
  case(md[3:1])
   3'b000 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0000; // interval mode
   3'b001 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0000; // judge mode
   3'b010 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b1000; // capture mode
   3'b011 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0001; // event count mode
   3'b100 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0110; // onecount mode
   3'b101 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0100; // trigger start
   3'b110 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b1110; // capture & onecount mode
   default:{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0110; // judge & onecount mode
  endcase
end


endmodule


module  QLK0RTAU08R2V1_REGU_57 ( pclkrw,  presetz,  chdata,  pwdata,
                       sel_toe,  sel_tol,  sel_tom,  we_ts,  we_tt,  sel_tmr,
                       tstt_all, init_ts,
                       toe,      tol,    tom,      te,
                       tis,      ccs,    sts,      cks,     master,  md,
                       capture_mode, waiting_mode, onecnt_mode, event_mode );

input         pclkrw; 
input         presetz;
input         chdata;
input  [15:0] pwdata;
input         sel_toe;
input         sel_tol;
input         sel_tom;
input         we_ts;
input         we_tt;
input         sel_tmr;

input         tstt_all;

output        init_ts;

output        toe;
output        tol;
output        tom;
output        te;

output [1:0]  tis;
output [1:0]  ccs;
output [2:0]  sts;
output [1:0]  cks;
output        master;
output [3:0]  md;

output        capture_mode;
output        waiting_mode;
output        onecnt_mode;
output        event_mode;

// ¥¿¥¤¥Þ½ÐÎÏ¥¤¥Í¡¼¥Ö¥ë¥ì¥¸¥¹¥¿
// we_toe¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg  toe;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)     toe <= 1'b0;
    else if (sel_toe) toe <= chdata;
end

// ¥¿¥¤¥Þ½ÐÎÏ¥ì¥Ù¥ëÀßÄê¥ì¥¸¥¹¥¿
// we_tol¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg tol;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)     tol <= 1'b0;
    else if (sel_tol) tol <= chdata;
end

// ¥¿¥¤¥Þ½ÐÎÏ¥â¡¼¥ÉÀßÄê¥ì¥¸¥¹¥¿
// we_tom¤Ç¥²¡¼¥Æ¥£¥ó¥°¤µ¤ì¤ë¡£
reg tom;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if (~presetz)     tom <= 1'b0;
    else if (sel_tom) tom <= chdata;
end

// ¥Á¥ã¥Í¥ë¥¤¥Í¡¼¥Ö¥ë¥ì¥¸¥¹¥¿
// ts¥ì¥¸¥¹¥¿1½ñ¤­¹þ¤ß¤Ç¥»¥Ã¥È¤µ¤ì¡¢tt¥ì¥¸¥¹¥¿1½ñ¤­¹þ¤ß¤Ç¥¯¥ê¥¢¤µ¤ì¤ë
// tstt_all¿®¹æ¤Ï¡¢ts¥ì¥¸¥¹¥¿¥é¥¤¥È¿®¹æ¤Ètt¥ì¥¸¥¹¥¿¥é¥¤¥È¿®¹æ¤ÎOR¡£
reg  te;
wire te_data;
wire ge_te_reg = tstt_all;
// synopsys async_set_reset "presetz"
always @( posedge pclkrw or negedge presetz ) begin
    if(~presetz)          te <= 1'b0;
    else if(ge_te_reg)   te <= te_data;
end

// tt¥ì¥¸¥¹¥¿
// APB·ÐÍ³¤Î1½ñ¤­¹þ¤ß¤Ç¥»¥Ã¥È¤µ¤ì¡¢¥«¥¦¥ó¥È¥¤¥Í¡¼¥Ö¥ë¤¬¥»¥Ã¥È¤µ¤ì¤ë¤È¥¯¥ê¥¢¤¹¤ë¡£
// ½ñ¤­¹þ¤ßÍÑ¤Îchdata¤òÊÌ³¬ÁØ¤ÇºîÀ®¤·¤Æ¤¤¤ë¤Î¤Ï¡¢¥²¡¼¥Æ¥£¥ó¥°ÏÀÍý¤È¥Ç¡¼¥¿ÏÀÍý¤¬
// ½ÌÂà¤µ¤ì¤ë¤Î¤òËÉ¤°°Ù¡£
// Data Sub Module for PowerCompiler
//wire  we_ts = penable & pwrite & sel_ts ;
//wire  we_tt = penable & pwrite & sel_tt ;
wire  init_ts = we_ts & chdata & ~te ;     // Start initialize signal for ovf

QLK0RTAU08R2V1_REGU_GL regu_gl ( .chdata(chdata) , .we_ts(we_ts), .we_tt(we_tt), .te(te), .te_data(te_data) );


// TMR Register
reg [1:0] tis;
//reg [1:0] ccs;
reg       ccs0bit;
reg [2:0] sts;
//reg       cks;
reg       cks1bit;
//reg       master;
reg [3:0] md;

// ¥â¡¼¥É¥ì¥¸¥¹¥¿
// ÉáÄÌ¤ÎAPB¥ì¥¸¥¹¥¿¤ÇÆÃÊÌ¤Ê½èÃÖ¤Ï¤Ê¤¤¡£
// synopsys async_set_reset "presetz"
always @(posedge pclkrw or negedge presetz) begin
    if(~presetz) begin
      cks1bit <= 1'b0;
      ccs0bit <= 1'b0;
//      master <= 1'b0;
      sts <= 3'b000;
      tis <= 2'b00;
      md <=4 'b0000;
    end
    else if(sel_tmr) begin
      cks1bit <= pwdata[15];
      ccs0bit <= pwdata[12];
//      master <= pwdata[11];
      sts <= pwdata[10:8];
      tis <= pwdata[7:6];
      md <= pwdata[3:0];
    end
end

wire [1:0] cks = { cks1bit, 1'b0 };
wire [1:0] ccs = { 1'b0, ccs0bit };
wire       master = 1'b0;

// mode decoder
reg  capture_mode;
reg  waiting_mode;
reg  onecnt_mode;
reg  event_mode;


// Æ°ºî¥â¡¼¥É¤Î¥Ç¥³¡¼¥À
// CH¤ÎÆ°ºî¥â¡¼¥É¤ò¤³¤³¤Ç·èÄê¤·¤Æ¡¢³Æ¥â¥¸¥å¡¼¥ë¤Ç»ÈÍÑ¤¹¤ë¡£
// waiting_mode¿®¹æ¤Ï¡¢¥½¥Õ¥È¥¦¥§¥¢¥È¥ê¥¬¤Ç¥«¥¦¥ó¥È¥¹¥¿¡¼¥È¤»¤º¡¢te=1¾õÂÖ¤Ç¥¹¥¿¡¼¥È¥È¥ê¥¬¤¬
// ÆþÎÏ¤µ¤ì¤Æ½é¤á¤Æ¥«¥¦¥ó¥ÈÆ°ºî¤ò¹Ô¤¦¥â¡¼¥ÉÍÑ¤Î¿®¹æ¡£
always @(md) begin
  case(md[3:1])
   3'b000 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0000; // interval mode
   3'b001 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0000; // judge mode
   3'b010 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b1000; // capture mode
   3'b011 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0001; // event count mode
   3'b100 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0110; // onecount mode
   3'b101 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0100; // trigger start
   3'b110 :{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b1110; // capture & onecount mode
   default:{capture_mode,waiting_mode,onecnt_mode,event_mode}= 4'b0110; // judge & onecount mode
  endcase
end


endmodule



module QLK0RTAU08R2V1_REGU_GL ( chdata, we_ts, we_tt, te, te_data );

input   chdata ;
input   we_ts;
input   we_tt;
input   te;
output  te_data;

reg te_data;
always @(we_ts or we_tt or chdata or te) begin
  if (we_ts & chdata)      te_data = 1'b1;
  else if (we_tt & chdata) te_data = 1'b0;
  else                     te_data = te;
end

endmodule



module QLK0RTAU08R2V1_COUNTER ( pclk, presetz, pwdata, sel_tdr,
                         capture_mode, onecnt_mode, md0, count_start_trg, count_clock,
                         capture_trg, count_start_trg_out, capture_trg_out,
                         init_ts, ge_toint,
                         tcr, tdr, to_reset, brow_out, intout, ovf, borrow,
                         ge_intout );

input         pclk;
input         presetz;
input  [15:0] pwdata;

input         sel_tdr;
//input         judge_mode;
input         capture_mode;
input         onecnt_mode;
input         md0;
input         count_start_trg;
input         count_clock;
input         capture_trg;
input         count_start_trg_out;
input         capture_trg_out;
input         init_ts;
input         ge_toint;
//input         count_clock_out;
//input         brow_in_cas;
//input         re_clr;
//input         re_set;
//input         re_clr_all;
//input         re_set_all;
//input         ck_all;
//input         tstt_all;

output [15:0] tcr;
output [15:0] tdr;
output        to_reset;
output        brow_out;
output        intout;
output        ovf;
output        borrow;
//output        brow_up;
output        ge_intout;
//output        ge_count;

// timer counter
wire            borrow;
wire    [15:0]  next_value;
wire            load_trg;
wire    [15:0]  load_data;
wire            ge_count_register;
wire            ge_count_register_1;
wire            ge_count_register_2;
//wire            ge_count_register_3;
wire            borrow0;
wire            borrow1;
//wire            borrow2;
reg     [15:0]  count_register;
wire            borrow_out ;

wire            tmp_borrow0 ;
wire            tmp_borrow1 ;
//wire            tmp_borrow2 ;

// 16Bit¥«¥¦¥ó¥¿¤Î¥Ç¥¯¥ê¥á¥ó¥È²óÏ©
// Ê¬³ä¥²¡¼¥Æ¥£¥ó¥°¤Î°Ù¡¢4¤Ä¤ËÊ¬³ä¤·¤Æ¤¤¤ë¡£
// brow_in_cas¤Ï¥«¥¹¥±¡¼¥É»þ¤Î²¼°ÌCH¤Î¥Ü¥í¡¼¤Ç¡¢Ã±CH¤È32bit¤Î²¼°ÌCH»þ¤Ï¾ï¤Ë1¤Ë¤Ê¤Ã¤Æ¤¤¤ë¡£
assign {tmp_borrow0, next_value[3:0]}  = {1'b0,count_register[3:0] } - 1'b1 ;
assign {tmp_borrow1, next_value[7:4]}  = {1'b0,count_register[7:4] } - 1'b1 ;
//assign {tmp_borrow2, next_value[11:8]} = {1'b0,count_register[11:8]} - 1'b1 ;
assign {next_value[15:8]} = count_register[15:8] - 1'b1  ;

assign borrow0 = tmp_borrow0 ;              // count_register[3:0]-1  for ge_count_register_1
assign borrow1 = tmp_borrow1 & borrow0 ;    // count_register[7:4]-1  for ge_count_register_2
//assign borrow2 = tmp_borrow2 & borrow1;     // count_register[11:8]-1 for ge_count_register_3


// ¥«¥¦¥ó¥¿¤Î¥Ü¥í¡¼¤òÉ½¤¹¿®¹æ
assign borrow = (count_register == 16'h0000) & ~((count_start_trg & ~onecnt_mode) | capture_trg) ;

assign borrow_out = (count_register == 16'h0000) & ~((count_start_trg_out & ~onecnt_mode) | capture_trg_out) ;

// ¥«¥¦¥ó¥¿¤Î¥ê¡¼¥ÉÃÍ¤òÀ¸À®¡£¥­¥ã¥×¥Á¥ã¥â¡¼¥É¤Ç¤ÏÈ¿Å¾ÃÍ¤¬ÆÉ¤á¤ë¡£
assign tcr        = (capture_mode) ? ~count_register : count_register ;

// ¥«¥¦¥ó¥¿¤Î¥í¡¼¥É¥È¥ê¥¬¿®¹æ
// ¥«¥¦¥ó¥È¥¹¥¿¡¼¥È»þ¤ÏÁ´¥â¡¼¥É¤Ç¥í¡¼¥É¡£
// ¥ï¥ó¥«¥¦¥ó¥È¥â¡¼¥É¡¢¥­¥ã¥×¥Á¥ã¥â¡¼¥É¡¢¥¸¥ã¥Ã¥¸¥â¡¼¥É°Ê³°¤Ï¥«¥¦¥ó¥ÈÃÍ=0000H¤Ç¤â¥í¡¼¥É¡£
//assign load_trg   = count_start_trg | (borrow & count_clock & ~(onecnt_mode | capture_mode | judge_mode)) ; // mod v1.04
assign load_trg   = count_start_trg | (borrow & count_clock & ~(onecnt_mode | capture_mode)) ; 

// ¥«¥¦¥ó¥¿¤Î¥í¡¼¥É¥Ç¡¼¥¿À¸À®¡£
// ¥­¥ã¥×¥Á¥ã¥â¡¼¥É¤Ç¤ÏFFFFH¡£¤½¤ì°Ê³°¤â¥â¡¼¥É¤Ç¥í¡¼¥É¥È¥ê¥¬¤¬1¤À¤È¥Ç¡¼¥¿¥ì¥¸¥¹¥¿¤ò¥í¡¼¥É¡£
// ¤½¤ì°Ê³°¤Î¤È¤­¤Ï¡¢¥«¥¦¥ó¥È¥Ç¥¯¥ê¥á¥ó¥ÈÃÍ¤ò¥í¡¼¥É¡£
assign load_data  = (load_trg) ? (capture_mode) ? 16'hffff : tdr : next_value;

// ¥«¥¦¥ó¥¿¤Î¥²¡¼¥Æ¥£¥ó¥°¥¤¥Í¡¼¥Ö¥ë¿®¹æÀ¸À®¡£
// ¥í¡¼¥É»þ¤È²¼°Ì¥Ó¥Ã¥È¤Î¥Ü¥í¡¼È¯À¸»þ¤Ë¥¤¥Í¡¼¥Ö¥ë¤òON¤¹¤ë¡£
assign ge_count_register   = load_trg |  count_clock;
assign ge_count_register_1 = load_trg | (count_clock & borrow0);
assign ge_count_register_2 = load_trg | (count_clock & borrow1);
//assign ge_count_register_3 = load_trg | (count_clock & borrow2);

// Test Monitor
//wire ge_count = ge_count_register_1 ^ ge_count_register_2 ;
//wire ge_count = ge_count_register_1 ^ ge_count_register_2 ^ ge_count_register_3;


// ¥«¥¦¥ó¥¿¡¼¤Î¥Ó¥Ã¥È3-0
// synopsys async_set_reset "presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        count_register[3:0] <=4'hf ;
    end
    else if (ge_count_register) 
        count_register[3:0] <= load_data[3:0];
end

// ¥«¥¦¥ó¥¿¡¼¤Î¥Ó¥Ã¥È7-4
// synopsys async_set_reset "presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        count_register[7:4] <=4'hf ;
    end
    else if (ge_count_register_1)
        count_register[7:4] <= load_data[7:4];
end

// ¥«¥¦¥ó¥¿¡¼¤Î¥Ó¥Ã¥È15-8
// synopsys async_set_reset "presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        count_register[15:8] <=8'hff ;
    end
    else if (ge_count_register_2)
        count_register[15:8] <= load_data[15:8];
end

// data register
wire         ge_tdr_register;
reg  [15:0]  tdr;

// ¥Ç¡¼¥¿¥ì¥¸¥¹¥¿¤Î¥²¡¼¥Æ¥£¥ó¥°¿®¹æ¤òÀ¸À®¡£
// ¥­¥ã¥×¥Á¥ã¥â¡¼¥É°Ê³°¤ÎAPB·ÐÍ³¥é¥¤¥È¿®¹æ¡¢¥­¥ã¥×¥Á¥ã¥â¡¼¥É»þ¤Î¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¤Ç
// ¥¤¥Í¡¼¥Ö¥ëON
assign ge_tdr_register = (sel_tdr & ~capture_mode) | (capture_trg & capture_mode) ;

// ¥Ç¡¼¥¿¥ì¥¸¥¹¥¿
// synopsys async_set_reset "presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        tdr <= 16'h0000;
    end
    else if (ge_tdr_register) begin
        if (sel_tdr)   tdr <= pwdata;
        else          tdr <= tcr;
    end
end


// borrow register
wire    ge_borrow_register;
//wire    re_clr;
wire    borrow_data;
wire    borrow_reg_data;
wire    ovf_data;
reg     borrow_register;


// For Gating
QLK0RTAU08R2V1_COUNT_GL counter_gl (
   .ge_borrow_register(ge_borrow_register), .borrow_data(borrow_data),
   .borrow_register(borrow_register), .borrow_reg_data(borrow_reg_data), .capture_trg(capture_trg),
   .ovf(ovf), .ovf_data(ovf_data), .init_ts(init_ts), .capture_mode(capture_mode)  );

// int register
reg     int_register;
wire    int_interval;
//wire    int_judge;
wire    int_capture;
wire    int_onecount;
wire    brow_interval;
//wire    brow_judge;
wire    brow_capture;
wire    brow_onecount;
wire    ge_int_register;
wire    pre_int_reg;


// INT¤Î¥½¡¼¥¹¿®¹æ¤òºîÀ®
// ¥ï¥ó¥«¥¦¥ó¥È»þ¤Ï¥Ü¥í¡¼È¯À¸»þ
// ¥¤¥ó¥¿¡¼¥Ð¥ë»þ¤Ï¥Ü¥í¡¼È¯À¸»þ¤È¡¢¥«¥¦¥ó¥È¥¹¥¿¡¼¥È»þ¤ÇMD0=1¤ÇTO¤¬¥È¥°¥ë¥â¡¼¥É
// ¥¸¥ã¥Ã¥¸¥â¡¼¥É»þ¤ÏÈ½Äê¥È¥ê¥¬ÆþÎÏ»þ¤ÎMD0ÀßÄêÃÍ¤Ë¤è¤Ã¤ÆÀÚ¤êÂØ¤¨
// ¥­¥ã¥×¥Á¥ã»þ¤Ï¥­¥ã¥×¥Á¥ã¥È¥ê¥¬ÆþÎÏ»þ¤È¡¢¥«¥¦¥ó¥È¥¹¥¿¡¼¥È»þ(MD0=0)
//assign int_onecount = borrow & brow_in_cas & count_clock;               // One Count
assign int_onecount = borrow & count_clock;                             // One Count
assign int_interval = (count_start_trg & md0) | int_onecount;           // Interval
//assign int_judge    = capture_trg & ~(md0 ^ borrow_register);           // Judge
assign int_capture  = (md0 & count_start_trg) | capture_trg;            // Capture


// ¥¹¥ì¡¼¥ÖCHÍÑ¤ÎINT(¥Ü¥í¡¼)¤òÀ¸À®¡£
// ¾å°ÌCH¤«¤é¤Î¿®¹æ¤¬¥¹¥¿¡¼¥È¥È¥ê¥¬¤È¤Ê¤ê¡¢²¼°ÌCH¤ËÅÁ¤ï¤ë¤³¤È¤Ï»ÅÍÍ¾åÌµ¤¤¤¬¡¢¤³¤Î¥Ñ¥¹
// ¤¬STA¤Ç¸«¤¨¤Æ¡¢¥¹¥Ô¡¼¥ÉÄã²¼¤Ë¤Ä¤Ê¤¬¤ë¤Î¤Ç¡¢²¼°ÌCHÀìÍÑ¤Î¿®¹æ¤òÀ¸À®
//assign brow_onecount = borrow_out & count_clock_out;                    // One Count
assign brow_onecount = borrow_out & count_clock;                        // One Count
assign brow_interval = (count_start_trg_out & md0) | brow_onecount;     // Interval
//assign brow_judge    = capture_trg_out& ~(md0 ^ borrow_register);       // Judge
assign brow_capture  = (md0 & count_start_trg_out) | capture_trg_out ;  // Capture


// ¼«CH¤ÎINT-F/FÍÑ¿®¹æ¤È¡¢²¼°ÌCH¤ËÅÁ¤¨¤ë¥Ü¥í¡¼¤ò¥â¡¼¥ÉËè¤Ë¥Ç¥³¡¼¥É
// cÎcaseÊ¸¤À¤ÈDesignCompiler¤¬¾éÄ¹²óÏ©¤òºîÀ®¤¹¤ë¤Î¤Ç¡¢AND¤ÈOR¤Ç¥Ç¥³¡¼¥À¤òÌÀ¼¨Åª¤Ë¹½À®¡£

//wire brow_up  = brow_onecount ;  // add v1.04 for 32bit cascade

//wire brow_out = (capture_mode & brow_capture) |
//                (judge_mode   & brow_judge)   |
//                (onecnt_mode  & ~capture_mode & ~judge_mode & brow_onecount) |
//                (~onecnt_mode & ~capture_mode & ~judge_mode & brow_interval) ;
wire brow_out = (capture_mode & brow_capture) |
                (onecnt_mode  & ~capture_mode & brow_onecount) |
                (~onecnt_mode & ~capture_mode & brow_interval) ;

//wire to_reset = (capture_mode & int_capture) |
//                (judge_mode   & int_judge)   |
//                (onecnt_mode  & ~capture_mode & ~judge_mode & int_onecount) |
//                (~onecnt_mode & ~capture_mode & ~judge_mode & int_interval) ;
wire to_reset = (capture_mode & int_capture) |
                (onecnt_mode  & ~capture_mode & int_onecount) |
                (~onecnt_mode & ~capture_mode & int_interval) ;


// INT¥ì¥¸¥¹¥¿¤Î¥Ç¡¼¥¿¤òÀ¸À®
// INT¤ÏPCLK¤Î1¥¯¥í¥Ã¥¯¤Ê¤Î¤Ç¡¢INT¤¬1¤Ê¤é0¤ËÌá¤¹¡£
// ¥°¥í¡¼¥Ð¥ë¥²¡¼¥Æ¥£¥ó¥°¤µ¤»¤ë°Ù¡¢INT¤Î¥²¡¼¥Æ¥£¥ó¥°¤ËÁ´CH¤ÎINT¤ÎOR¤ò»ÈÍÑ¤¹¤ë¤Î¤Ç¡¢
// ¥Ç¡¼¥¿ÁªÂò¤Ç¡¢¼«¿È¤ÎINT¥»¥Ã¥È¤â¤·¤¯¤Ï¡¢¼«¿È¤ÎINT=1°Ê³°¤ÏÃÍÊÝ»ý¤Î¾ò·ï¤ò¤¤¤ì¤Æ¤¤¤ë¡£
assign ge_int_register = to_reset | int_register;
assign pre_int_reg = ge_int_register ? (to_reset |~int_register) : int_register;
//wire   pre_int = pre_int_reg & te;
// borrow_register
assign borrow_data = borrow & count_clock & ~count_start_trg;   // mod init-start-timing
assign ge_borrow_register = (borrow & count_clock ) | count_start_trg ;

wire   ge_intout;
assign ge_intout = ge_borrow_register;

// INT¥ì¥¸¥¹¥¿
// ¥²¡¼¥Æ¥£¥ó¥°¤ÏÁ´ÂÎ¤Ç¥²¡¼¥Æ¥£¥ó¥°¤¹¤ë°Ù¤Ë¡¢ck_all¤ÈÁ´CHINT¤ÎOR¤ò»ÈÍÑ¡£
// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz ) begin
    if(~presetz)       int_register <= 1'b0;
    else if(ge_toint)  int_register <= pre_int_reg;
end
assign intout = int_register;

// OVF¥Õ¥é¥°¤ÎÆâÉô¿®¹æÀ¸À®¡£
// ¥Ü¥í¡¼È¯À¸¤Ç¥»¥Ã¥È¡¢¥«¥¦¥ó¥È¥¹¥¿¡¼¥È¥È¥ê¥¬(¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¡Ë¤Ç¥¯¥ê¥¢¡£
// ¥«¥¹¥±¡¼¥É»þ¤Î¥«¥¦¥ó¥¿¥ê¡¼¥ÉÍÑ¤Ëre_clr(²¼°ÌCH¤Î¥«¥¦¥ó¥¿¥ê¡¼¥É¿®¹æ)¤Ç¤â¥¯¥ê¥¢
// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz ) begin
  if(~presetz)      borrow_register <= 1'b0;
  else if(ge_toint) borrow_register <= borrow_reg_data;
end

// OVF¥Õ¥é¥°¥ì¥¸¥¹¥¿¡Ê¤³¤Î¥ì¥¸¥¹¥¿ÃÍ¤¬OVF¤È¤·¤ÆÆÉ¤á¤ë¡Ë
// ¥­¥ã¥×¥Á¥ã¥â¡¼¥É»þ¤Ï¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¤ÇÆâÉôÃÍ¤ò¼è¤ê¹þ¤à
// ¥«¥¹¥±¡¼¥É»þ¤Ï¾å°ÌCH¤Î¥ê¡¼¥É¿®¹æ¤ÇÆâÉôÃÍ¤ò¼è¤ê¹þ¤à¡£
reg ovf;
always @(posedge pclk or negedge presetz) begin
  if (~presetz)     ovf <= 1'b0;
  else if(ge_toint) ovf <= ovf_data;
end

endmodule



module QLK0RTAU08R2V1_COUNTER_H ( pclk, presetz,  pwdata, sel_tdr,
                         capture_mode, onecnt_mode, md0, count_start_trg, count_clock,
                         capture_trg, count_start_trg_out, capture_trg_out,
                         init_ts, ge_toint,
                         tcr, tdr, to_reset, brow_out, intout, ovf, borrow, ge_intout,
                         count_start_trg_h, count_clock_h, sel_tdr_l, sel_tdr_h, split,
                         intout_h, to_reset_h, ge_intout_h );

input         pclk;
input         presetz;
input  [15:0] pwdata;

input         sel_tdr;
//input         judge_mode;
input         capture_mode;
input         onecnt_mode;
input         md0;
input         count_start_trg;
input         count_clock;
input         capture_trg;
input         count_start_trg_out;
input         capture_trg_out;
input         init_ts;
input         ge_toint;
//input         count_clock_out;
//input         brow_in_cas;
//input         re_clr;
//input         re_set;
//input         re_clr_all;
//input         re_set_all;
//input         ck_all;
//input         tstt_all;

output [15:0] tcr;
output [15:0] tdr;
output        brow_out;
output        intout;
output        ovf;
output        to_reset;
output        borrow;
//output        brow_up;
output        ge_intout;
//output        ge_count;

// for split mode (16bit -> 8bit)
input         count_start_trg_h;
input         count_clock_h;
input         sel_tdr_l;
input         sel_tdr_h;
input         split;

output        intout_h;
output        ge_intout_h;
output        to_reset_h;

// timer counter
wire            borrow;
wire            borrow_16;
wire            borrow_l;
wire            load_trg_l;
wire            borrow_h;
wire            load_trg_h;
wire    [15:0]  next_value;
wire    [15:0]  load_data;

wire            ge_count_register;
wire            ge_count_register_1;
wire            ge_count_register_2;
wire            ge_count_register_3;
wire            borrow0;
wire            borrow1;
wire            borrow2;

reg     [15:0]  count_register;
wire            borrow_out ;

wire            tmp_borrow0 ;
wire            tmp_borrow1 ;
wire            tmp_borrow2 ;

// ¥«¥¦¥ó¥¿¤Î¥Ü¥í¡¼¤òÉ½¤¹¿®¹æ
assign borrow_16 = (count_register == 16'h0000)   & ~((count_start_trg & ~onecnt_mode) | capture_trg) ;
assign borrow_l  = (count_register[7:0] == 8'h00) & ~((count_start_trg & ~onecnt_mode) | capture_trg) ;
assign borrow_h  = (count_register[15:8] == 8'h00) ;

assign borrow_out = (count_register == 16'h0000) & ~((count_start_trg_out & ~onecnt_mode) | capture_trg_out) ;

//wire   dec8h_value = split ? 1'b1 : borrow_l;

// 16Bit¥«¥¦¥ó¥¿¤Î¥Ç¥¯¥ê¥á¥ó¥È²óÏ©
// Ê¬³ä¥²¡¼¥Æ¥£¥ó¥°¤Î°Ù¡¢4¤Ä¤ËÊ¬³ä¤·¤Æ¤¤¤ë¡£
assign {tmp_borrow0, next_value[3:0]}  = {1'b0,count_register[3:0] } - 1'b1 ;
assign {tmp_borrow1, next_value[7:4]}  = {1'b0,count_register[7:4] } - 1'b1 ;
assign {tmp_borrow2, next_value[11:8]} = {1'b0,count_register[11:8]} - 1'b1 ;
assign {next_value[15:12]} = count_register[15:12] - 1'b1  ;

assign borrow0 = tmp_borrow0 ;                        // count_register[3:0]-1  for ge_count_register_1
assign borrow1 = tmp_borrow1 & borrow0 ;              // count_register[7:4]-1  for ge_count_register_2
assign borrow2 = tmp_borrow2 & (borrow1 | split);     // count_register[11:8]-1 for ge_count_register_3

//assign next_value[7:0]  = count_register[7:0]  - 1'b1;
//assign next_value[15:8] = count_register[15:8] - dec8h_value;

// ¥«¥¦¥ó¥¿¤Î¥ê¡¼¥ÉÃÍ¤òÀ¸À®¡£¥­¥ã¥×¥Á¥ã¥â¡¼¥É¤Ç¤ÏÈ¿Å¾ÃÍ¤¬ÆÉ¤á¤ë¡£
//assign tcr        = (capture_mode) ? ~count_register : count_register ;
assign tcr[7:0]  = (capture_mode) ? ~count_register[7:0] : count_register[7:0] ;
assign tcr[15:8] = (capture_mode & ~split) ? ~count_register[15:8] : count_register[15:8] ;

assign borrow = split ? borrow_l : borrow_16 ;
// ¥«¥¦¥ó¥¿¤Î¥í¡¼¥É¥È¥ê¥¬¿®¹æ
// ¥«¥¦¥ó¥È¥¹¥¿¡¼¥È»þ¤ÏÁ´¥â¡¼¥É¤Ç¥í¡¼¥É¡£
// ¥ï¥ó¥«¥¦¥ó¥È¥â¡¼¥É¡¢¥­¥ã¥×¥Á¥ã¥â¡¼¥É¡¢¥¸¥ã¥Ã¥¸¥â¡¼¥É°Ê³°¤Ï¥«¥¦¥ó¥ÈÃÍ=0000H¤Ç¤â¥í¡¼¥É¡£
//assign load_trg_l   = count_start_trg | (borrow & count_clock & ~(onecnt_mode | capture_mode | judge_mode)) ;
assign load_trg_l   = count_start_trg | (borrow & count_clock & ~(onecnt_mode | capture_mode)) ;

wire pre_load_trg_h = count_start_trg_h | borrow_h & count_clock_h;

assign load_trg_h   = split ? pre_load_trg_h : load_trg_l;
// ¥«¥¦¥ó¥¿¤Î¥í¡¼¥É¥Ç¡¼¥¿À¸À®¡£
// ¥­¥ã¥×¥Á¥ã¥â¡¼¥É¤Ç¤ÏFFFFH¡£¤½¤ì°Ê³°¤â¥â¡¼¥É¤Ç¥í¡¼¥É¥È¥ê¥¬¤¬1¤À¤È¥Ç¡¼¥¿¥ì¥¸¥¹¥¿¤ò¥í¡¼¥É¡£
// ¤½¤ì°Ê³°¤Î¤È¤­¤Ï¡¢¥«¥¦¥ó¥È¥Ç¥¯¥ê¥á¥ó¥ÈÃÍ¤ò¥í¡¼¥É¡£
assign load_data[7:0]   = (load_trg_l) ? (capture_mode) ? 8'hff : tdr[7:0]  : next_value[7:0];
//assign load_data[15:8]  = (load_trg_h) ? (capture_mode) ? 8'hff : tdr[15:8] : next_value[15:8];
assign load_data[15:8]  = (load_trg_h) ? (capture_mode & ~split) ? 8'hff : tdr[15:8] : next_value[15:8];

wire  upper_clock = split ? count_clock_h : count_clock; 

/*
wire ge_count_register_l = load_trg_l |  count_clock;
wire ge_count_register_h = load_trg_h |  upper_clock;

// ¥«¥¦¥ó¥¿¡¼¤Î¥Ó¥Ã¥È7-0
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        count_register[7:0] <=8'hff ;
    end
    else if (ge_count_register_l) begin
        count_register[7:0] <= load_data[7:0];
    end
end

// ¥«¥¦¥ó¥¿¡¼¤Î¥Ó¥Ã¥È15-8
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        count_register[15:8] <=8'hff ;
    end
    else if (ge_count_register_h) begin
        count_register[15:8] <= load_data[15:8];
    end
end
*/

// ¥«¥¦¥ó¥¿¤Î¥²¡¼¥Æ¥£¥ó¥°¥¤¥Í¡¼¥Ö¥ë¿®¹æÀ¸À®¡£
// ¥í¡¼¥É»þ¤È²¼°Ì¥Ó¥Ã¥È¤Î¥Ü¥í¡¼È¯À¸»þ¤Ë¥¤¥Í¡¼¥Ö¥ë¤òON¤¹¤ë¡£
assign ge_count_register   = load_trg_l |  count_clock;
assign ge_count_register_1 = load_trg_l | (count_clock & borrow0);
assign ge_count_register_2 = load_trg_h | (upper_clock & (borrow1 | split));
assign ge_count_register_3 = load_trg_h | (upper_clock & borrow2);

// Test Monitor
//wire ge_count = ge_count_register_1 ^ ge_count_register_2 ^ ge_count_register_3;


// ¥«¥¦¥ó¥¿¡¼¤Î¥Ó¥Ã¥È3-0
// synopsys async_set_reset "presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        count_register[3:0] <=4'hf ;
    end
    else if (ge_count_register) 
        count_register[3:0] <= load_data[3:0];
end

// ¥«¥¦¥ó¥¿¡¼¤Î¥Ó¥Ã¥È7-4
// synopsys async_set_reset "presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        count_register[7:4] <=4'hf ;
    end
    else if (ge_count_register_1)
        count_register[7:4] <= load_data[7:4];
end

// ¥«¥¦¥ó¥¿¡¼¤Î¥Ó¥Ã¥È11-8
// synopsys async_set_reset "presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        count_register[11:8] <=4'hf ;
    end
    else if (ge_count_register_2)
        count_register[11:8] <= load_data[11:8];
end

// ¥«¥¦¥ó¥¿¡¼¤Î¥Ó¥Ã¥È15-12
// synopsys async_set_reset "presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        count_register[15:12] <=4'hf ;
    end
    else if (ge_count_register_3)
        count_register[15:12] <= load_data[15:12];
end


wire sel_upper_tdr = split ? sel_tdr_h : sel_tdr ;
wire sel_lower_tdr = split ? sel_tdr_l : sel_tdr ;

wire ge_tdr_register_h = (sel_upper_tdr & ~capture_mode) | (capture_trg & capture_mode) ;
wire ge_tdr_register_l = (sel_lower_tdr & ~capture_mode) | (capture_trg & capture_mode) ;


// data register
reg  [15:0]  tdr;

always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        tdr[7:0] <= 8'h00;
    end
    else if (ge_tdr_register_l) begin
        if (sel_lower_tdr)  tdr[7:0] <= pwdata[7:0];
        else                tdr[7:0] <= tcr[7:0];
    end
end

always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        tdr[15:8] <= 8'h00;
    end
    else if (ge_tdr_register_h) begin
        if (sel_upper_tdr)  tdr[15:8] <= pwdata[15:8];
        else                tdr[15:8] <= tcr[15:8];
    end
end


/*
// data register
wire         ge_tdr_register;
reg  [15:0]  tdr;

// ¥Ç¡¼¥¿¥ì¥¸¥¹¥¿¤Î¥é¥¤¥È¥¤¥Í¡¼¥Ö¥ëÀ¸À®¡£
// ¥°¥í¡¼¥Ð¥ë¥²¡¼¥Æ¥£¥ó¥°²½¤ò¹Í¤¨¤Æ¡¢ÏÀÍý¤ò¤³¤Î³¬ÁØ¤ÇºîÀ®¡£
wire we_tdr = penable & pwrite & sel_tdr;

// ¥Ç¡¼¥¿¥ì¥¸¥¹¥¿¤Î¥²¡¼¥Æ¥£¥ó¥°¿®¹æ¤òÀ¸À®¡£
// ¥­¥ã¥×¥Á¥ã¥â¡¼¥É°Ê³°¤ÎAPB·ÐÍ³¥é¥¤¥È¿®¹æ¡¢¥­¥ã¥×¥Á¥ã¥â¡¼¥É»þ¤Î¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¤Ç
// ¥¤¥Í¡¼¥Ö¥ëON
assign ge_tdr_register = (we_tdr & ~capture_mode) | (capture_trg & capture_mode) ; // mod v1.04

// ¥Ç¡¼¥¿¥ì¥¸¥¹¥¿
// synopsys async_set_reset "presetz"
always @(posedge pclk or negedge presetz) begin
    if (~presetz) begin
        tdr <= 16'h0000;
    end
    else if (ge_tdr_register) begin
        if (we_tdr)   tdr <= pwdata;
        else          tdr <= tcr;
    end
end
*/

// borrow register
wire    ge_borrow_register;
//wire    re_clr;
wire    borrow_data;
wire    borrow_reg_data;
wire    ovf_data;
reg     borrow_register;

// For Gating
QLK0RTAU08R2V1_COUNT_GL counter_gl (
   .ge_borrow_register(ge_borrow_register), .borrow_data(borrow_data),
   .borrow_register(borrow_register), .borrow_reg_data(borrow_reg_data), .capture_trg(capture_trg),
   .ovf(ovf), .ovf_data(ovf_data), .init_ts(init_ts), .capture_mode(capture_mode)  );

// int register
reg     int_register;
wire    int_interval;
//wire    int_judge;
wire    int_capture;
wire    int_onecount;
wire    brow_interval;
//wire    brow_judge;
wire    brow_capture;
wire    brow_onecount;
wire    ge_int_register;
wire    pre_int_reg;
reg     int_register_h;
wire    ge_int_register_h;
wire    pre_int_reg_h;


// INT¤Î¥½¡¼¥¹¿®¹æ¤òºîÀ®
// ¥ï¥ó¥«¥¦¥ó¥È»þ¤Ï¥Ü¥í¡¼È¯À¸»þ
// ¥¤¥ó¥¿¡¼¥Ð¥ë»þ¤Ï¥Ü¥í¡¼È¯À¸»þ¤È¡¢¥«¥¦¥ó¥È¥¹¥¿¡¼¥È»þ¤ÇMD0=1¤ÇTO¤¬¥È¥°¥ë¥â¡¼¥É
// ¥¸¥ã¥Ã¥¸¥â¡¼¥É»þ¤ÏÈ½Äê¥È¥ê¥¬ÆþÎÏ»þ¤ÎMD0ÀßÄêÃÍ¤Ë¤è¤Ã¤ÆÀÚ¤êÂØ¤¨
// ¥­¥ã¥×¥Á¥ã»þ¤Ï¥­¥ã¥×¥Á¥ã¥È¥ê¥¬ÆþÎÏ»þ¤È¡¢¥«¥¦¥ó¥È¥¹¥¿¡¼¥È»þ(MD0=0)
//assign int_onecount = borrow & brow_in_cas & count_clock;               // One Count
assign int_onecount = borrow & count_clock;                             // One Count
assign int_interval = (count_start_trg & md0) | int_onecount;           // Interval
//assign int_judge    = capture_trg & ~(md0 ^ borrow_register);           // Judge
assign int_capture  = (md0 & count_start_trg) | capture_trg;            // Capture


// ¥¹¥ì¡¼¥ÖCHÍÑ¤ÎINT(¥Ü¥í¡¼)¤òÀ¸À®¡£
// ¾å°ÌCH¤«¤é¤Î¿®¹æ¤¬¥¹¥¿¡¼¥È¥È¥ê¥¬¤È¤Ê¤ê¡¢²¼°ÌCH¤ËÅÁ¤ï¤ë¤³¤È¤Ï»ÅÍÍ¾åÌµ¤¤¤¬¡¢¤³¤Î¥Ñ¥¹
// ¤¬STA¤Ç¸«¤¨¤Æ¡¢¥¹¥Ô¡¼¥ÉÄã²¼¤Ë¤Ä¤Ê¤¬¤ë¤Î¤Ç¡¢²¼°ÌCHÀìÍÑ¤Î¿®¹æ¤òÀ¸À®
//assign brow_onecount = borrow_out & count_clock_out;                    // One Count
assign brow_onecount = borrow_out & count_clock;                        // One Count
assign brow_interval = (count_start_trg_out & md0) | brow_onecount;     // Interval
//assign brow_judge    = capture_trg_out& ~(md0 ^ borrow_register);       // Judge 
assign brow_capture  = (md0 & count_start_trg_out) | capture_trg_out ;  // Capture


// ¼«CH¤ÎINT-F/FÍÑ¿®¹æ¤È¡¢²¼°ÌCH¤ËÅÁ¤¨¤ë¥Ü¥í¡¼¤ò¥â¡¼¥ÉËè¤Ë¥Ç¥³¡¼¥É
// caseÊ¸¤À¤ÈDesignCompiler¤¬¾éÄ¹²óÏ©¤òºîÀ®¤¹¤ë¤Î¤Ç¡¢AND¤ÈOR¤Ç¥Ç¥³¡¼¥À¤òÌÀ¼¨Åª¤Ë¹½À®¡£

//wire brow_up  = brow_onecount ;  // add v1.04 for 32bit cascade

//wire brow_out = (capture_mode & brow_capture) |
//                (judge_mode   & brow_judge)   |
//                (onecnt_mode  & ~capture_mode & ~judge_mode & brow_onecount) |
//                (~onecnt_mode & ~capture_mode & ~judge_mode & brow_interval) ;
wire brow_out = (capture_mode & brow_capture) |
                (onecnt_mode  & ~capture_mode & brow_onecount) |
                (~onecnt_mode & ~capture_mode & brow_interval) ;

//wire to_reset = (capture_mode & int_capture) |
//                (judge_mode   & int_judge)   |
//                (onecnt_mode  & ~capture_mode & ~judge_mode & int_onecount) |
//                (~onecnt_mode & ~capture_mode & ~judge_mode & int_interval) ;
wire to_reset = (capture_mode & int_capture) |
                (onecnt_mode  & ~capture_mode & int_onecount) |
                (~onecnt_mode & ~capture_mode & int_interval) ;


// INT¥ì¥¸¥¹¥¿¤Î¥Ç¡¼¥¿¤òÀ¸À®
// INT¤ÏPCLK¤Î1¥¯¥í¥Ã¥¯¤Ê¤Î¤Ç¡¢INT¤¬1¤Ê¤é0¤ËÌá¤¹¡£
// ¥°¥í¡¼¥Ð¥ë¥²¡¼¥Æ¥£¥ó¥°¤µ¤»¤ë°Ù¡¢INT¤Î¥²¡¼¥Æ¥£¥ó¥°¤ËÁ´CH¤ÎINT¤ÎOR¤ò»ÈÍÑ¤¹¤ë¤Î¤Ç¡¢
// ¥Ç¡¼¥¿ÁªÂò¤Ç¡¢¼«¿È¤ÎINT¥»¥Ã¥È¤â¤·¤¯¤Ï¡¢¼«¿È¤ÎINT=1°Ê³°¤ÏÃÍÊÝ»ý¤Î¾ò·ï¤ò¤¤¤ì¤Æ¤¤¤ë¡£
assign ge_int_register = to_reset | int_register;
assign pre_int_reg = ge_int_register ? (to_reset |~int_register) : int_register;
//wire   pre_int = pre_int_reg & te;

wire to_reset_h = borrow_h & count_clock_h | count_start_trg_h ;

assign ge_int_register_h = to_reset_h | int_register_h;
assign pre_int_reg_h = ge_int_register_h ? (to_reset_h |~int_register_h) : int_register_h;

// borrow_register
assign borrow_data = borrow & count_clock & ~count_start_trg;   // mod init-start-timing
assign ge_borrow_register = (borrow & count_clock ) | count_start_trg ;

// INT¥ì¥¸¥¹¥¿
// ¥²¡¼¥Æ¥£¥ó¥°¤ÏÁ´ÂÎ¤Ç¥²¡¼¥Æ¥£¥ó¥°¤¹¤ë°Ù¤Ë¡¢ck_all¤ÈÁ´CHINT¤ÎOR¤ò»ÈÍÑ¡£
// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz ) begin
    if(~presetz)       int_register <= 1'b0;
    else if(ge_toint)  int_register <= pre_int_reg;
end
assign intout = int_register;


always @( posedge pclk or negedge presetz ) begin
    if(~presetz)       int_register_h <= 1'b0;
    else if(ge_toint)  int_register_h <= pre_int_reg_h;
end
assign intout_h = int_register_h;

wire ge_intout = ge_borrow_register;
wire ge_intout_h = ge_int_register_h;


// OVF¥Õ¥é¥°¤ÎÆâÉô¿®¹æÀ¸À®¡£
// ¥Ü¥í¡¼È¯À¸¤Ç¥»¥Ã¥È¡¢¥«¥¦¥ó¥È¥¹¥¿¡¼¥È¥È¥ê¥¬(¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¡Ë¤Ç¥¯¥ê¥¢¡£
// ¥«¥¹¥±¡¼¥É»þ¤Î¥«¥¦¥ó¥¿¥ê¡¼¥ÉÍÑ¤Ëre_clr(²¼°ÌCH¤Î¥«¥¦¥ó¥¿¥ê¡¼¥É¿®¹æ)¤Ç¤â¥¯¥ê¥¢
// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz ) begin
  if(~presetz)      borrow_register <= 1'b0;
  else if(ge_toint) borrow_register <= borrow_reg_data;
end

// OVF¥Õ¥é¥°¥ì¥¸¥¹¥¿¡Ê¤³¤Î¥ì¥¸¥¹¥¿ÃÍ¤¬OVF¤È¤·¤ÆÆÉ¤á¤ë¡Ë
// ¥­¥ã¥×¥Á¥ã¥â¡¼¥É»þ¤Ï¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¤ÇÆâÉôÃÍ¤ò¼è¤ê¹þ¤à
// ¥«¥¹¥±¡¼¥É»þ¤Ï¾å°ÌCH¤Î¥ê¡¼¥É¿®¹æ¤ÇÆâÉôÃÍ¤ò¼è¤ê¹þ¤à¡£
reg ovf;
always @(posedge pclk or negedge presetz) begin
  if (~presetz)     ovf <= 1'b0;
  else if(ge_toint) ovf <= ovf_data;
end


endmodule



module QLK0RTAU08R2V1_COUNT_GL (ge_borrow_register, borrow_data,
                         borrow_register, borrow_reg_data, capture_trg,
                         ovf, ovf_data, init_ts, capture_mode );

input   ge_borrow_register;
//input   re_clr;
input   borrow_data;
input   borrow_register;
input   capture_trg;
//input   re_set;
input   ovf;
//input   count_start_trg;
input   init_ts;
input   capture_mode;

output  borrow_reg_data;
output  ovf_data;

reg borrow_reg_data;
reg ovf_data;

// For borrow_register
// ge_borrow_register=1borrow_data
// reclr(CH)capture_trgcount_start_trg
always @(ge_borrow_register or borrow_data or init_ts
         or borrow_register or capture_trg) begin
   if (ge_borrow_register)        borrow_reg_data = borrow_data;
   else if (capture_trg|init_ts)  borrow_reg_data = 1'b0;
   else                           borrow_reg_data = borrow_register;
end

// For ovf register
always @(capture_trg or capture_mode or borrow_register or ovf) begin
  if (capture_trg&capture_mode)   ovf_data = borrow_register;
  else                            ovf_data = ovf;
end

endmodule



module QLK0RTAU08R2V1_TOCTL_0 ( pclk, presetz, to_data, sel_to, toe,
                                to_reset, ge_toint, tout );

input    pclk;
input    presetz;
input    to_data;      // TO register write deta(pwdata[ch])
input    sel_to;       // TO register write enable
input    toe;          // timer pulse output enable signal
//input    tom;          // TO output mode  0:toggle mode
                         //                 1:combination mode
//input    tol;          // 0: buf output
                         // 1: inv output
input    to_reset;     // TO reset or TO toggle signal
//input    to_set;       // TO set signal
//input    count_clock;  //
input    ge_toint;     //
//input    ck_all;       // Macro Clock(Enable)
//input    tstt_all;     //

output   tout;         // Timer pulse signal

// to register
reg     to_register;

wire    to_data_sel;

// PowerCompiler¤ÇÏÀÍý½ÌÂà¤µ¤ì¤Æ¥²¡¼¥Æ¥£¥ó¥°¤¬³Ý¤«¤é¤Ê¤¯¤Ê¤ë¤Î¤òËÉ¤°°Ù¤Ë
// F/F¤Î¥Ç¡¼¥¿Â¦¤ò1³¬ÁØ²¼¤²¤Æ¤¤¤ë¡£
QLK0RTAU08R2V1_TO_GL_0 to_gl_0 ( .toe(toe), .to_reset(to_reset), .to_data(to_data),
                                 .to_register(to_register), .we_to(sel_to), .to_data_sel(to_data_sel) );

// TO¥ì¥¸¥¹¥¿
// APB½ñ¤­¹þ¤ß¤È¡¢Æ°ºî»þ¤ÎTOÁàºî¿®¹æ¤ÇÆ°ºî¤¹¤ë¡£
// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz) begin
    if(~presetz) begin
      to_register <= 1'b0;
    end
    else if (ge_toint) begin
      to_register <= to_data_sel;
    end
end

assign tout = to_register;

endmodule


module QLK0RTAU08R2V1_TO_GL_0 ( toe, to_reset, to_data, to_register, we_to, to_data_sel );
//input   tom;
//input   tol; 
input   toe;
input   to_reset;
//input   to_set;
input   to_data;
input   to_register;
input   we_to;
output  to_data_sel;

// Æ°ºî»þ(toe=1)¤ÎTOÃÍ¤ò·èÄê¤¹¤ë¡£
// tom=0¤Î»þ¤Ï¥È¥°¥ë¡¢tom=1¤Î»þ¤Ïtol¤Ë¤è¤Ã¤Æ¥»¥Ã¥È¤«¥ê¥»¥Ã¥È¤«¤ò·èÄê¤¹¤ë¡£
//wire to_data_sel_toe = (tom) ? (tol) ? to_reset : ~to_reset : ~to_register;
wire to_data_sel_toe = ~to_register;

// toe=1»þ¤Îtom¤ÎÃÍ¤Ë¤è¤Ã¤ÆÆ°ºî¥â¡¼¥É¤ò·èÄê¤¹¤ë¡£
// tom=1¤Ê¤éto_set(¥Þ¥¹¥¿¡¼¤ÎINT)¤¬Í­¸ú¡£to_reset(¼«CH¤ÎINT)¤Ï¾ï¤ËÍ­¸ú¡£
wire to_sel          = toe & to_reset;

reg to_data_sel;

// TO¥ì¥¸¥¹¥¿¤Î¥Ç¡¼¥¿ÃÍ¤ò·èÄê¤¹¤ë¡£
// to_sel=1(Æ°ºî¥â¡¼¥É»þ)¤Ë¤Ï¡¢to_reset/to_set¤Ë¤è¤ëÏÀÍý¤òÁªÂò¡£
// toe=0»þ¤ÏAPB·ÐÍ³¤Î¥Ç¡¼¥¿¤òÍ­¸ú¤Ë¤¹¤ë¡£
// ¤½¤ì°Ê³°¤Î»þ¤Ï¡¢ÃÍ¤òÊÝ»ý¤¹¤ë(¥²¡¼¥Æ¥£¥ó¥°ÏÀÍý¤Ëck_all¤ò»ÈÍÑ¤·¤Æ¤¤¤ë¤Î¤Ç¡¢¤³¤ì¤¬É¬Í×
always @(to_sel or we_to or to_data_sel_toe or to_data or toe or to_register)begin
  if (to_sel)            to_data_sel = to_data_sel_toe;
  else if (~toe & we_to) to_data_sel = to_data;
  else                   to_data_sel = to_register;
end

endmodule


module QLK0RTAU08R2V1_TOCTL ( pclk, presetz, to_data, sel_to,
                       toe, tom, tol, to_reset, to_set, count_clock,
                       ge_toint, ck_all, tstt_all, tout, to_set_d );

input    pclk;
input    presetz;
input    to_data;      // TO register write deta(pwdata)
input    sel_to;       // TO register write enable
input    toe;          // timer pulse output enable signal
input    tom;          // TO output mode  0:toggle mode
                       //                 1:combination mode
input    tol;          // 0: buf output
                       // 1: inv output
input    to_reset;     // TO reset or TO toggle signal
input    to_set;       // TO set signal
input    count_clock;  //
input    ge_toint;     //
input    ck_all;       // Macro Clock(Enable)
input    tstt_all;     //

output   tout;         // Timer pulse signal
output   to_set_d;

// to register
reg     to_register;
reg     to_set_d;

wire    to_data_sel, to_set_d_sel;

wire   ge_set_d;
assign ge_set_d = ck_all | tstt_all;

QLK0RTAU08R2V1_TOSET_GL toset_gl ( .to_set_d_sel(to_set_d_sel), .to_set(to_set),
                                   .count_clock(count_clock), .to_set_d(to_set_d) );

//wire to_set_d_sel = (to_set|count_clock) ? to_set : to_set_d ;

always @(posedge pclk or negedge presetz) begin
  if (~presetz )     to_set_d <= 1'b0;
  else if (ge_set_d) to_set_d <= to_set_d_sel;
end

wire to_set_dly = to_set_d & count_clock;


// TO¥ì¥¸¥¹¥¿¤ÎAPB·ÐÍ³¥é¥¤¥È¥¤¥Í¡¼¥Ö¥ë¿®¹æ
//assign we_to = penable & pwrite & sel_to ;

// PowerCompiler¤ÇÏÀÍý½ÌÂà¤µ¤ì¤Æ¥²¡¼¥Æ¥£¥ó¥°¤¬³Ý¤«¤é¤Ê¤¯¤Ê¤ë¤Î¤òËÉ¤°°Ù¤Ë
// F/F¤Î¥Ç¡¼¥¿Â¦¤ò1³¬ÁØ²¼¤²¤Æ¤¤¤ë¡£
QLK0RTAU08R2V1_TO_GL to_gl ( .tom(tom), .tol(tol), .toe(toe), .to_reset(to_reset), .to_set(to_set_dly),
                      .to_data(to_data), .to_register(to_register), .we_to(sel_to),
                      .to_data_sel(to_data_sel) );

// TO¥ì¥¸¥¹¥¿
// APB½ñ¤­¹þ¤ß¤È¡¢Æ°ºî»þ¤ÎTOÁàºî¿®¹æ¤ÇÆ°ºî¤¹¤ë¡£
// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz) begin
    if(~presetz) begin
      to_register <= 1'b0;
    end
    else if (ge_toint) begin
      to_register <= to_data_sel;
    end
end

assign tout = to_register;

endmodule


module QLK0RTAU08R2V1_TOSET_GL ( to_set_d_sel, to_set, count_clock, to_set_d );

input   to_set ;
input   count_clock;
input   to_set_d;
output  to_set_d_sel;

wire to_set_d_sel = (to_set|count_clock) ? to_set : to_set_d ;

endmodule


module QLK0RTAU08R2V1_TO_GL ( tom, tol, toe, to_reset, to_set, to_data, to_register,
                       we_to, to_data_sel );
input   tom;
input   tol; 
input   toe;
input   to_reset;
input   to_set;
input   to_data;
input   to_register;
input   we_to;
output  to_data_sel;

// Æ°ºî»þ(toe=1)¤ÎTOÃÍ¤ò·èÄê¤¹¤ë¡£
// tom=0¤Î»þ¤Ï¥È¥°¥ë¡¢tom=1¤Î»þ¤Ïtol¤Ë¤è¤Ã¤Æ¥»¥Ã¥È¤«¥ê¥»¥Ã¥È¤«¤ò·èÄê¤¹¤ë¡£
wire to_data_sel_toe = (tom) ? (tol) ? to_reset : ~to_reset : ~to_register;

// toe=1»þ¤Îtom¤ÎÃÍ¤Ë¤è¤Ã¤ÆÆ°ºî¥â¡¼¥É¤ò·èÄê¤¹¤ë¡£
// tom=1¤Ê¤éto_set(¥Þ¥¹¥¿¡¼¤ÎINT)¤¬Í­¸ú¡£to_reset(¼«CH¤ÎINT)¤Ï¾ï¤ËÍ­¸ú¡£
wire to_sel          = toe & ((tom & to_set) | to_reset);

reg to_data_sel;

// TO¥ì¥¸¥¹¥¿¤Î¥Ç¡¼¥¿ÃÍ¤ò·èÄê¤¹¤ë¡£
// to_sel=1(Æ°ºî¥â¡¼¥É»þ)¤Ë¤Ï¡¢to_reset/to_set¤Ë¤è¤ëÏÀÍý¤òÁªÂò¡£
// toe=0»þ¤ÏAPB·ÐÍ³¤Î¥Ç¡¼¥¿¤òÍ­¸ú¤Ë¤¹¤ë¡£
// ¤½¤ì°Ê³°¤Î»þ¤Ï¡¢ÃÍ¤òÊÝ»ý¤¹¤ë(¥²¡¼¥Æ¥£¥ó¥°ÏÀÍý¤Ëck_all¤ò»ÈÍÑ¤·¤Æ¤¤¤ë¤Î¤Ç¡¢¤³¤ì¤¬É¬Í×
always @(to_sel or we_to or to_data_sel_toe or to_data or toe or to_register)begin
  if (to_sel)            to_data_sel = to_data_sel_toe;
  else if (~toe & we_to) to_data_sel = to_data;
  else                   to_data_sel = to_register;
end

endmodule


module  QLK0RTAU08R2V1_FILTER ( pclk, presetz, tau_in, nfen, ge_edge, tin_out);

input   pclk;
input   presetz;
input   tau_in;     // External input signal
//input   mck;        // tin sampling clock 
input   nfen;       // NFEN register input
input   ge_edge;

output  tin_out;

reg     ti_ff1, ti_ff2, ti_ff3;
wire    ff3_data;

//wire    ff1_data = mck ? tau_in : ti_ff1 ;
wire    ff1_data = ge_edge ? tau_in : ti_ff1 ;

// ff1
always @( posedge pclk or negedge presetz ) begin
    if(~presetz) begin
      ti_ff1 <= 1'b0;
    end
    else if(ge_edge) begin
      ti_ff1 <= ff1_data;
    end
end

//wire    ff2_data = mck ? ti_ff1 : ti_ff2 ;
wire    ff2_data = ge_edge ? ti_ff1 : ti_ff2 ;

// ff2
always @( posedge pclk or negedge presetz ) begin
    if(~presetz) begin
      ti_ff2 <= 1'b0;
    end
    else if(ge_edge) begin
      ti_ff2 <= ff2_data;
    end
end

wire    pre_ff3_data = ~(ti_ff1 ^ ti_ff2) ;
//wire    ff3_data = mck & pre_ff3_data ? ti_ff2 : ti_ff3 ;

QLK0RTAU08R2V1_FFSEL fil_ff3 ( .data1(ti_ff2), .data2(ti_ff3), .sel(pre_ff3_data),
                               .dataout(ff3_data) );

//wire    ff3_data = pre_ff3_data ? ti_ff2 : ti_ff3 ;

// ff3
always @( posedge pclk or negedge presetz ) begin
    if(~presetz) begin
      ti_ff3 <= 1'b0;
    end
    else if(ge_edge) begin
      ti_ff3 <= ff3_data;
    end
end

wire tin_out = nfen ? ti_ff3 : ti_ff1;

endmodule


module  QLK0RTAU08R2V1_FFSEL ( data1, data2, sel, dataout );

input  data1;
input  data2;
input  sel;

output dataout;

wire   dataout;
assign dataout = sel ? data1 : data2;

endmodule



module  QLK0RTAU08R2V1_EDGEU ( pclk, presetz, tin, ge_edge, ti_rise_trg, ti_fall_trg );

input   pclk;
input   presetz;
input   tin;        // External input signal
//input   mck;        // tin sampling clock
//input   ck_all;     // ck0 or ck1
input   ge_edge;

output  ti_rise_trg;
output  ti_fall_trg;

wire    ti_rise_trg;
wire    ti_fall_trg;

reg     ti_register;

wire    ti_register_data;


//assign  ti_register_data = mck ? tin : ti_register ;
assign  ti_register_data = ge_edge ? tin : ti_register ;

// tinÃ¼»Ò¤Î¥¨¥Ã¥¸¸¡½Ð¥ì¥¸¥¹¥¿
// tinÃ¼»Ò¤ÏÆ±´üÆþÎÏ¤Î¤¿¤á¡¢1ÃÊ¤Î¥¨¥Ã¥¸¸¡½Ð¤È¤·¤Æ¤¤¤ë¡£
// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz ) begin
    if(~presetz) begin
      ti_register <= 1'b0;
    end
    else if(ge_edge) begin
      ti_register <= ti_register_data;
    end
end


// Î©¤Á¾å¤¬¤ê¥¨¥Ã¥¸¸¡½Ð¿®¹æ
// mck¤ò»È¤¦¤Î¤Ï¡¢¥¨¥Ã¥¸¸¡½Ð¤¬¥¹¥¿¡¼¥È¥È¥ê¥¬¤Ë¤Ê¤ë¾ì¹ç¤¬¤¢¤ë°Ù
//assign ti_rise_trg =  tin & ~ti_register & mck;
assign ti_rise_trg =  tin & ~ti_register & ge_edge;

// Î©¤Á²¼¤ê¥¨¥Ã¥¸¸¡½Ð¿®¹æ
// mck¤ò»È¤¦¤Î¤Ï¡¢¥¨¥Ã¥¸¸¡½Ð¤¬¥¹¥¿¡¼¥È¥È¥ê¥¬¤Ë¤Ê¤ë¾ì¹ç¤¬¤¢¤ë°Ù
//assign ti_fall_trg = ~tin &  ti_register & mck;
assign ti_fall_trg = ~tin &  ti_register & ge_edge;

endmodule


module QLK0RTAU08R2V1_TRGCTL ( pclk, presetz, ti_rise_trg, ti_fall_trg,
                        brow_in, tis, sts, ccs, cks,
                        ck0, ck1, count_start_trg, mck, borrow,
                        count_clock, onecnt_mode, event_mode, te, waiting_mode,
                        capture_trg, md0, capture_mode,
                        count_start_trg_out, capture_trg_out,
                        ck_all, tstt_all, we_ts, chdata, we_tt, ge_enout, counten_all );

input        pclk;
input        presetz;
input        ti_rise_trg;
input        ti_fall_trg;
//input        start_in;
input        brow_in;
//input        cck_in;
input [1:0]  tis;
input [2:0]  sts;
//input [1:0]  ccs;
input        ccs;
input        cks;
input        ck0;
input        ck1;
input        onecnt_mode;
input        event_mode;
input        capture_mode;
input        te;
input        waiting_mode;
//input        brow_in_up;
input        md0;
input        ck_all;
input        tstt_all;
input        we_ts;
input        chdata;
input        we_tt;
//input        svhold;
//input        judge_mode;
input        borrow;
//input        brow_in_cas;
input        counten_all;

output       count_start_trg;
output       count_start_trg_out;
output       mck;
output       count_clock;
//output       count_clock_out;
output       capture_trg;
output       capture_trg_out;
//output       st_sel_out;
//output       ts;
output       ge_enout;

wire count_ck_source;
reg  count_en_register;
wire count_ck_source_out;
reg  st_sel_out ;

wire pre_count_en;

//wire te_sv = te & ~svhold ;
wire te_sv = te ;

//TE=High¡¢SVHOLD=Low¤Î»þ¡¢¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¤ò¶¡µë¡¢¥­¥ã¥×¥Á¥ã¥¨¥Ã¥¸Í­¸ú
wire count_enable = count_en_register & te_sv ;


// TIS¥ì¥¸¥¹¥¿¤ÎÀßÄê¤Ë¤è¤ê¡¢tinÆþÎÏ¤ÎÎ©²¼¤ê¥¨¥Ã¥¸/Î©¤Á¾å¤¬¤ê¥¨¥Ã¥¸/Î¾¥¨¥Ã¥¸¤ò
// ÁªÂò¤¹¤ë¡£
reg     ti_sel_trg;
always @( tis or ti_rise_trg or ti_fall_trg ) begin
    case(tis)
      2'b00: ti_sel_trg = ti_fall_trg;
      2'b01: ti_sel_trg = ti_rise_trg;
    default: ti_sel_trg = (ti_rise_trg | ti_fall_trg);
    endcase
end

// tinÉýÂ¬ÄêÍÑ¤Ë¥¹¥¿¡¼¥È¥È¥ê¥¬¤È¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¤òÊÌ¡¹¤ËÀ¸À®¤¹¤ë¡£
wire width_st_trg, width_cp_trg;
assign width_st_trg = (tis[0]) ? ti_rise_trg : ti_fall_trg;
assign width_cp_trg = (tis[0]) ? ti_fall_trg : ti_rise_trg;

// STS¥ì¥¸¥¹¥¿¤ÎÀßÄêÃÍ¤Ë¤è¤ê¡¢¼«CH¤Ç»È¤¦¥¹¥¿¡¼¥È¥È¥ê¥¬¤òÁªÂò¤¹¤ë¡£
// RFU¤ÎÀßÄêÃÍ¤Ï¾å°ÌCH¤Î¥Ü¥í¡¼¤ËÀßÄê¡£
reg     pre_st_sel;
//always @( sts or ti_sel_trg or width_st_trg or start_in or brow_in or brow_in_up ) begin
//    case(sts)
//      3'b000: pre_st_sel = 1'b0;
//      3'b001: pre_st_sel = ti_sel_trg;
//      3'b010: pre_st_sel = width_st_trg;
//      3'b011: pre_st_sel = start_in;
//      3'b101: pre_st_sel = brow_in_up;
//     default: pre_st_sel = brow_in;
//    endcase
//end

always @( sts or ti_sel_trg or width_st_trg or brow_in ) begin
    case(sts)
      3'b000: pre_st_sel = 1'b0;
      3'b001: pre_st_sel = ti_sel_trg;
      3'b010: pre_st_sel = width_st_trg;
      3'b011: pre_st_sel = 1'b0;
      3'b101: pre_st_sel = 1'b0;
     default: pre_st_sel = brow_in;
    endcase
end

/*
reg     keep_sel_trg; // add v1.04
wire sel_data = count_ck_source ? 1'b0 : pre_st_sel ? 1'b1 : keep_sel_trg ; // add v1.04

// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz ) begin
    if(~presetz)      keep_sel_trg <= 1'b0;
    else if (ck_all)  keep_sel_trg <= sel_data ;
end

wire st_sel_trg = count_ck_source ? pre_st_sel ? 1'b1 : keep_sel_trg : 1'b0 ; // add v1.04
*/
wire st_sel_trg = pre_st_sel & count_ck_source ;

reg ts ;

//wire ts_trg = (st_sel_trg & te_sv) | (ts & count_ck_source & ~svhold) ;
//wire ts_trg_out = (st_sel_out & te_sv) | (ts & count_ck_source_out & ~svhold) ;
//wire ts_data = (we_ts & chdata & (te|~waiting_mode) &~event_mode) ? 1'b1 : (count_ck_source & ~svhold | (we_tt & chdata)) ? 1'b0 : ts ;

wire ts_trg = (st_sel_trg & te_sv) | (ts & count_ck_source) ;
wire ts_trg_out = (st_sel_out & te_sv) | (ts & count_ck_source_out) ;

wire ts_data = (we_ts & chdata & (te|~waiting_mode) &~event_mode) ? 1'b1 : (count_ck_source | (we_tt & chdata)) ? 1'b0 : ts ;

wire ge_ts_register = tstt_all | ck_all ;

// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz ) begin
    if(~presetz)             ts <= 1'b0;
    else if(ge_ts_register)  ts <= ts_data ;
end


// ¥¹¥ì¡¼¥ÖCH¤ËÅÏ¤¹¥¹¥¿¡¼¥È¥È¥ê¥¬¤ò¥Ç¥³¡¼¥É¤¹¤ë¡£
// ¼«CHÍÑ¤È¤ï¤¶¤ï¤¶ÊÌ¤±¤Æ¤¤¤ë¤Î¤Ï¡¢STA¤Çµ¼»÷¥¨¥é¡¼¤ò½Ð¤µ¤Ê¤¤°Ù¡£
// ¾å°ÌCH¤«¤éÍè¤¿¥¹¥¿¡¼¥È¥È¥ê¥¬¤òCHÆâ·ÐÍ³¤Ç¼¡¤ÎCH¤ËÅÏ¤¹¤³¤È¤ÏÌµ¤¤¤Î¤Ç¡¢
// ¾å°ÌCH¤«¤é¤Î¥È¥ê¥¬¤òÈ´¤¤¤Æ¤¤¤ë¡£
always @( sts or ti_sel_trg or width_st_trg ) begin
    case(sts[2:0])
      3'b001 : st_sel_out = ti_sel_trg;
      3'b010 : st_sel_out = width_st_trg;
      default: st_sel_out = 1'b0;
    endcase
end


// ¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¥½¡¼¥¹¤ÎÁªÂò  // mod v1.04
// STS¥ì¥¸¥¹¥¿¤ÎÀßÄêÃÍ¤Ë¤è¤ê¡¢¼«CH¤Ç»È¤¦¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¤òÁªÂò¤¹¤ë¡£
// RFU¤ÎÀßÄêÃÍ¤Ï¾å°ÌCH¤Î¥Ü¥í¡¼¤ËÀßÄê¡£
reg     pre_cp_trg, pre_cp_trg_out;
always @( sts or width_cp_trg or ti_sel_trg or st_sel_trg ) begin
    case(sts)
      3'b010: pre_cp_trg = width_cp_trg;
      3'b110: pre_cp_trg = ti_sel_trg;
     default: pre_cp_trg = st_sel_trg;
    endcase
end

always @( sts or width_cp_trg or ti_sel_trg or st_sel_out ) begin
    case(sts)
      3'b010: pre_cp_trg_out = width_cp_trg;
      3'b110: pre_cp_trg_out = ti_sel_trg;
     default: pre_cp_trg_out = st_sel_out;
    endcase
end

//onecnt_mode¤Çjudge_mode¤ÇÌµ¤¤¾ì¹ç¡¢MD0=0¤ÇÆ°ºîÃæ¤ÏTS¤Î½ñ¤­¹þ¤ß¤òÌµ¸ú¤È¤¹¤ë¡£
//Judge&OneCountMode¤Ç¤Ï¡¢MD0¥Ó¥Ã¥È¤Ç¤ÎÀ©¸æ¤ò½ü³°¤¹¤ë¡£
//wire sel_capture_trg = (ts & count_ck_source & ~(~judge_mode&onecnt_mode&~md0 & count_en_register)) | pre_cp_trg ;
//wire sel_capture_trg_out = (ts & count_ck_source & ~(~judge_mode&onecnt_mode&~md0 & count_en_register)) | pre_cp_trg_out ;
wire sel_capture_trg = (ts & count_ck_source & ~(onecnt_mode&~md0 & count_en_register)) | pre_cp_trg ;
wire sel_capture_trg_out = (ts & count_ck_source & ~(onecnt_mode&~md0 & count_en_register)) | pre_cp_trg_out ;

//¥­¥ã¥×¥Á¥ã¥È¥ê¥¬(¥¸¥ã¥Ã¥¸¥È¥ê¥¬)¤¬Í­¸ú¤È¤Ê¤ë¤Î¤Ï¡¢Æ°ºîÃæ¤Ç³î¤Ä¡¢capture_mode¤Èjudge_mode¤Î¤È¤­¡£
//wire capture_trg = sel_capture_trg & count_enable & (capture_mode | judge_mode) ;
//wire capture_trg_out = sel_capture_trg_out  & count_enable & (capture_mode | judge_mode) ;
wire capture_trg = sel_capture_trg & count_enable & capture_mode ;
wire capture_trg_out = sel_capture_trg_out  & count_enable & capture_mode ;


// CKS¥ì¥¸¥¹¥¿¤Ë¤è¤ëÆ°ºî¥¯¥í¥Ã¥¯(MCK)¤ÎÁªÂò
reg     mck;
always @( cks or ck0 or ck1 )  begin
    case(cks)
      1'b0: mck = ck0;
   default: mck = ck1;
    endcase
end

/*
// ¼«CH¤Ç»ÈÍÑ¤¹¤ë¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¥½¡¼¥¹¤ÎÁªÂò
// CCS¥ì¥¸¥¹¥¿¤ÎÀßÄêÃÍ¤Ç¥Ç¥³¡¼¥É¤¹¤ë¡£
always @( ccs or mck or ti_sel_trg or cck_in or brow_in_cas ) begin
    case(ccs)
      2'b00: count_ck_source = mck;
      2'b01: count_ck_source = ti_sel_trg;
      2'b10: count_ck_source = cck_in;
    default: count_ck_source = 1'b1;
    endcase
end
*/

assign count_ck_source = ccs ? ti_sel_trg : mck ;
assign count_ck_source_out = count_ck_source ;


// ¥¹¥È¥Ã¥×¥È¥ê¥¬¤ÎÁªÂò  // mod v1.04
// STS=010¤Î»þ¡¢tinÆþÎÏ¤Î¤É¤Á¤é¤«¤Î¥¨¥Ã¥¸¤Ç¥¹¥È¥Ã¥×¡£
// STS=110¤Î»þ¡¢tinÆþÎÏ¤Î¥¨¥Ã¥¸¤Ç¥¹¥È¥Ã¥×¡£

wire stop_trg_sel = (sts[1:0] != 2'b10) ? 1'b0 : pre_cp_trg ;

// Capture & OneCount mode/Judge & OneCount mode¤Ê¤é¡¢stop_trg_sel¤Ç¥¹¥È¥Ã¥×
// OneCount mode¤Ê¤é¡¢borrow¸¡½Ð¿®¹æ¤Ç¥¹¥È¥Ã¥×¡£; borrow & count_clock

//wire pre_stop_trg = ~onecnt_mode ? 1'b0 : (capture_mode | judge_mode) ? stop_trg_sel : borrow & count_clock ; 
wire pre_stop_trg = ~onecnt_mode ? 1'b0 : capture_mode ? stop_trg_sel : borrow & count_clock ; 
wire stop_trg = pre_stop_trg & count_enable ;

// Operation start trigger & Count clock enable

// Count start trigger
wire count_start_trg,count_start_trg_out;

// ¥«¥¦¥ó¥È¥¹¥¿¡¼¥È¥È¥ê¥¬¤ÎÀ¸À®¡£
// ¥¤¥Ù¥ó¥È¥«¥¦¥ó¥È¥â¡¼¥É¤Ç¤Ïwe_ts¤ò¤½¤Î¤Þ¤Þ»È¤¦¡£
// ¥ï¥ó¥«¥¦¥ó¥È¥â¡¼¥É¤Ç¤ÏMD0¥Ó¥Ã¥È¤ÇÆ°ºîÃæ¤Î¥¹¥¿¡¼¥È¥È¥ê¥¬Í­¸ú/Ìµ¸ú¤òÀÚ¤êÂØ¤¨¤ë
// Ã¢¤·¡¢¥¸¥ã¥Ã¥¸¥â¡¼¥É¤Ç¤Ï¡¢MD0¥Ó¥Ã¥È¤Ç¥È¥ê¥¬¤ÎÀ©¸æ¤ò¹Ô¤ï¤Ê¤¤¤Î¤Ç½ü³°¤¹¤ë¡£
// ¤½¤ÎÂ¾¤Î¥â¡¼¥É¤Ç¤Ï¾ï¤Ë¥¹¥¿¡¼¥È¥È¥ê¥¬¤¬Í­¸ú
// ¥È¥ê¥¬¥¹¥¿¡¼¥È¥â¡¼¥É(¥¦¥¨¥¤¥È¥â¡¼¥É)°Ê³°¤Ê¤éts¥ì¥¸¥¹¥¿½ñ¤­¹þ¤ß¤ÇMCK¤Ë¹ç¤ï¤»¤Æ¥¢¥¯¥Æ¥£¥Ö¤Ë¤¹¤ë¡£
// ¥È¥ê¥¬¥¹¥¿¡¼¥È¥â¡¼¥É(¥¦¥¨¥¤¥È¥â¡¼¥É)¤Ê¤éTE=1¾õÂÖ¤Ç¥¹¥¿¡¼¥È¥È¥ê¥¬È¯À¸¤Ç¥¢¥¯¥Æ¥£¥Ö¤È¤Ê¤ë¡£

//assign count_start_trg = (we_tt&chdata) ? 1'b0 : (event_mode) ? (we_ts&chdata) : ~(~judge_mode&onecnt_mode&~md0&count_en_register)&ts_trg ;
assign count_start_trg = (we_tt&chdata) ? 1'b0 : (event_mode) ? (we_ts&chdata) : ~(onecnt_mode&~md0&count_en_register)&ts_trg ;

// ¥¹¥ì¡¼¥Ö¤ËÅÁ¤¨¤ë¥¹¥¿¡¼¥È¥È¥ê¥¬¤ÎÀ¸À®¡£
// STA¤Çµ¼»÷¥¨¥é¡¼¤¬¸«¤¨¤ë¤¿¤á¡¢¾å°Ì¤«¤é¤Î¥È¥ê¥¬¤òÈ´¤¯

//assign count_start_trg_out = (we_tt&chdata) ? 1'b0 : (event_mode) ? (we_ts&chdata) : ~(~judge_mode&onecnt_mode&~md0&count_en_register)&ts_trg_out ;
assign count_start_trg_out = (we_tt&chdata) ? 1'b0 : (event_mode) ? (we_ts&chdata) : ~(onecnt_mode&~md0&count_en_register)&ts_trg_out ;


QLK0RTAU08R2V1_TRGCTL_GL trgctl_gl ( .we_tt(we_tt), .chdata(chdata),
                              .stop_trg(stop_trg), .count_start_trg(count_start_trg),
                              .count_en_register(count_en_register), .pre_count_en(pre_count_en) );

// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz ) begin
    if(~presetz) begin
        count_en_register <= 1'b0;
    end
    else if (counten_all) begin
        count_en_register <= pre_count_en;
    end
end


// Count clock
wire count_clock;
//wire count_clock_out;

// ¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¤ÎÀ¸À®
// ¥«¥¦¥ó¥È¥¤¥Í¡¼¥Ö¥ë¥ì¥¸¥¹¥¿¤¬1¤Ë¤Ê¤Ã¤¿¤é¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¤òÆ°ºî³«»Ï¤µ¤»¤ë¡£
//assign count_clock = count_en_register & count_ck_source ;
assign count_clock = count_enable & count_ck_source ;

// ¥¹¥ì¡¼¥Ö¤ËÅÁ¤¨¤ë¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¤ÎÀ¸À®¡£
// STA¤Îµ¼»÷¥¨¥é¡¼ËÉ»ß¤Î¤¿¤á¡¢ÉÔÉ¬Í×¤Ê¾å°Ì¤«¤é¤Î¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¤òÈ´¤¤¤Æ¤¤¤ë¡£
//assign count_clock_out = count_enable & count_ck_source_out;

wire ge_enout = stop_trg | count_start_trg ;

endmodule


module QLK0RTAU08R2V1_TRGCTL_H ( pclk, presetz, ti_rise_trg, ti_fall_trg,
                        brow_in, tis, sts, ccs, cks,
                        ck0, ck1, count_start_trg, mck, borrow,
                        count_clock, onecnt_mode, event_mode, te, waiting_mode,
                        capture_trg, md0, capture_mode,
                        count_start_trg_out, capture_trg_out,
                        ck_all, tstt_all, we_ts, chdata, we_tt, ge_enout, counten_all,
                        ck2, ck3, split, chdata_h, count_start_trg_h, count_clock_h );

input        pclk;
input        presetz;
input        ti_rise_trg;
input        ti_fall_trg;
//input        start_in;
input        brow_in;
//input        cck_in;
input [1:0]  tis;
input [2:0]  sts;
//input [1:0]  ccs;
input        ccs;
input [1:0]  cks;
input        ck0;
input        ck1;
input        onecnt_mode;
input        event_mode;
input        capture_mode;
input        te;
input        waiting_mode;
//input        brow_in_up;
input        md0;
input        ck_all;
input        tstt_all;
input        we_ts;
input        chdata;
input        chdata_h;
input        we_tt;
//input        svhold;
//input        judge_mode;
input        borrow;
//input        brow_in_cas;
input        counten_all;

output       count_start_trg;
output       count_start_trg_out;
output       mck;
output       count_clock;
//output       count_clock_out;
output       capture_trg;
output       capture_trg_out;
//output       st_sel_out;
//output       ts;
output       ge_enout;

// for split mode (16bit -> 8bit)
input        ck2;
input        ck3;
input        split;
output       count_start_trg_h;
output       count_clock_h;

wire count_ck_source;
reg  count_en_register;
reg  count_en_register_h;
wire count_ck_source_out;
reg  st_sel_out ;

wire pre_count_en, pre_count_en_h;

//wire te_sv = te & ~svhold ;
wire te_sv = te ;

//TE=High¡¢SVHOLD=Low¤Î»þ¡¢¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¤ò¶¡µë¡¢¥­¥ã¥×¥Á¥ã¥¨¥Ã¥¸Í­¸ú
wire count_enable = count_en_register & te_sv ;


// TIS¥ì¥¸¥¹¥¿¤ÎÀßÄê¤Ë¤è¤ê¡¢tinÆþÎÏ¤ÎÎ©²¼¤ê¥¨¥Ã¥¸/Î©¤Á¾å¤¬¤ê¥¨¥Ã¥¸/Î¾¥¨¥Ã¥¸¤ò
// ÁªÂò¤¹¤ë¡£
reg     ti_sel_trg;
always @( tis or ti_rise_trg or ti_fall_trg ) begin
    case(tis)
      2'b00: ti_sel_trg = ti_fall_trg;
      2'b01: ti_sel_trg = ti_rise_trg;
    default: ti_sel_trg = (ti_rise_trg | ti_fall_trg);
    endcase
end

// tinÉýÂ¬ÄêÍÑ¤Ë¥¹¥¿¡¼¥È¥È¥ê¥¬¤È¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¤òÊÌ¡¹¤ËÀ¸À®¤¹¤ë¡£
wire width_st_trg, width_cp_trg;
assign width_st_trg = (tis[0]) ? ti_rise_trg : ti_fall_trg;
assign width_cp_trg = (tis[0]) ? ti_fall_trg : ti_rise_trg; // mod V1.04

// STS¥ì¥¸¥¹¥¿¤ÎÀßÄêÃÍ¤Ë¤è¤ê¡¢¼«CH¤Ç»È¤¦¥¹¥¿¡¼¥È¥È¥ê¥¬¤òÁªÂò¤¹¤ë¡£
// RFU¤ÎÀßÄêÃÍ¤Ï¾å°ÌCH¤Î¥Ü¥í¡¼¤ËÀßÄê¡£
reg     pre_st_sel;
/*
always @( sts or ti_sel_trg or width_st_trg or start_in or brow_in or brow_in_up ) begin
    case(sts)
      3'b000: pre_st_sel = 1'b0;
      3'b001: pre_st_sel = ti_sel_trg;
      3'b010: pre_st_sel = width_st_trg;
      3'b011: pre_st_sel = start_in;
      3'b101: pre_st_sel = brow_in_up;
     default: pre_st_sel = brow_in;
    endcase
end
*/
always @( sts or ti_sel_trg or width_st_trg or brow_in ) begin
    case(sts)
      3'b000: pre_st_sel = 1'b0;
      3'b001: pre_st_sel = ti_sel_trg;
      3'b010: pre_st_sel = width_st_trg;
      3'b011: pre_st_sel = 1'b0;
      3'b101: pre_st_sel = 1'b0;
     default: pre_st_sel = brow_in;
    endcase
end

/*
reg     keep_sel_trg; // add v1.04
wire sel_data = count_ck_source ? 1'b0 : pre_st_sel ? 1'b1 : keep_sel_trg ; // add v1.04

// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz ) begin
    if(~presetz)      keep_sel_trg <= 1'b0;
    else if (ck_all)  keep_sel_trg <= sel_data ;
end

wire st_sel_trg = count_ck_source ? pre_st_sel ? 1'b1 : keep_sel_trg : 1'b0 ; // add v1.04
*/

wire st_sel_trg = pre_st_sel & count_ck_source ;


reg ts ;

//wire ts_trg = (st_sel_trg & te_sv) | (ts & count_ck_source & ~svhold) ;
//wire ts_trg_out = (st_sel_out & te_sv) | (ts & count_ck_source_out & ~svhold) ;
//wire ts_data = (we_ts & chdata & (te|~waiting_mode) &~event_mode) ? 1'b1 : (count_ck_source & ~svhold | (we_tt & chdata)) ? 1'b0 : ts ;

wire ts_trg = (st_sel_trg & te_sv) | (ts & count_ck_source) ;
wire ts_trg_out = (st_sel_out & te_sv) | (ts & count_ck_source_out) ;

wire ts_data = (we_ts & chdata & (te|~waiting_mode) &~event_mode) ? 1'b1 : (count_ck_source | (we_tt & chdata)) ? 1'b0 : ts ;

wire ge_ts_register = tstt_all | ck_all ;

// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz ) begin
    if(~presetz)             ts <= 1'b0;
    else if(ge_ts_register)  ts <= ts_data ;
end

// tau08r2
reg  ts_h ;
wire ts_trg_h = ts_h & mck;

//wire ts_data_h = (we_ts & chdata_h & te & split) ? 1'b1 : (mck | (we_tt & chdata_h)) ? 1'b0 : ts_h ;
wire ts_data_h = (we_ts & chdata_h & split) ? 1'b1 : (mck | (we_tt & chdata_h)) ? 1'b0 : ts_h ;

always @( posedge pclk or negedge presetz ) begin
    if(~presetz)             ts_h <= 1'b0;
    else if(ge_ts_register)  ts_h <= ts_data_h;
end

// ¥¹¥ì¡¼¥ÖCH¤ËÅÏ¤¹¥¹¥¿¡¼¥È¥È¥ê¥¬¤ò¥Ç¥³¡¼¥É¤¹¤ë¡£
// ¼«CHÍÑ¤È¤ï¤¶¤ï¤¶ÊÌ¤±¤Æ¤¤¤ë¤Î¤Ï¡¢STA¤Çµ¼»÷¥¨¥é¡¼¤ò½Ð¤µ¤Ê¤¤°Ù¡£
// ¾å°ÌCH¤«¤éÍè¤¿¥¹¥¿¡¼¥È¥È¥ê¥¬¤òCHÆâ·ÐÍ³¤Ç¼¡¤ÎCH¤ËÅÏ¤¹¤³¤È¤ÏÌµ¤¤¤Î¤Ç¡¢
// ¾å°ÌCH¤«¤é¤Î¥È¥ê¥¬¤òÈ´¤¤¤Æ¤¤¤ë¡£
always @( sts or ti_sel_trg or width_st_trg ) begin
    case(sts[2:0])
      3'b001 : st_sel_out = ti_sel_trg;
      3'b010 : st_sel_out = width_st_trg;
      default: st_sel_out = 1'b0;
    endcase
end


// ¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¥½¡¼¥¹¤ÎÁªÂò  // mod v1.04
// STS¥ì¥¸¥¹¥¿¤ÎÀßÄêÃÍ¤Ë¤è¤ê¡¢¼«CH¤Ç»È¤¦¥­¥ã¥×¥Á¥ã¥È¥ê¥¬¤òÁªÂò¤¹¤ë¡£
// RFU¤ÎÀßÄêÃÍ¤Ï¾å°ÌCH¤Î¥Ü¥í¡¼¤ËÀßÄê¡£
reg     pre_cp_trg, pre_cp_trg_out;
always @( sts or width_cp_trg or ti_sel_trg or st_sel_trg ) begin
    case(sts)
      3'b010: pre_cp_trg = width_cp_trg;
      3'b110: pre_cp_trg = ti_sel_trg;
     default: pre_cp_trg = st_sel_trg;
    endcase
end

always @( sts or width_cp_trg or ti_sel_trg or st_sel_out ) begin
    case(sts)
      3'b010: pre_cp_trg_out = width_cp_trg;
      3'b110: pre_cp_trg_out = ti_sel_trg;
     default: pre_cp_trg_out = st_sel_out;
    endcase
end

//onecnt_mode¤Çjudge_mode¤ÇÌµ¤¤¾ì¹ç¡¢MD0=0¤ÇÆ°ºîÃæ¤ÏTS¤Î½ñ¤­¹þ¤ß¤òÌµ¸ú¤È¤¹¤ë¡£
//Judge&OneCountMode¤Ç¤Ï¡¢MD0¥Ó¥Ã¥È¤Ç¤ÎÀ©¸æ¤ò½ü³°¤¹¤ë¡£
//wire sel_capture_trg = (ts & count_ck_source & ~(~judge_mode&onecnt_mode&~md0 & count_en_register)) | pre_cp_trg ;
//wire sel_capture_trg_out = (ts & count_ck_source & ~(~judge_mode&onecnt_mode&~md0 & count_en_register)) | pre_cp_trg_out ;
wire sel_capture_trg = (ts & count_ck_source & ~(onecnt_mode&~md0 & count_en_register)) | pre_cp_trg ;
wire sel_capture_trg_out = (ts & count_ck_source & ~(onecnt_mode&~md0 & count_en_register)) | pre_cp_trg_out ;

//¥­¥ã¥×¥Á¥ã¥È¥ê¥¬(¥¸¥ã¥Ã¥¸¥È¥ê¥¬)¤¬Í­¸ú¤È¤Ê¤ë¤Î¤Ï¡¢Æ°ºîÃæ¤Ç³î¤Ä¡¢capture_mode¤Èjudge_mode¤Î¤È¤­¡£
//wire capture_trg = sel_capture_trg & count_enable & (capture_mode | judge_mode) ;
//wire capture_trg_out = sel_capture_trg_out  & count_enable & (capture_mode | judge_mode) ;
wire capture_trg = sel_capture_trg & count_enable & capture_mode ;
wire capture_trg_out = sel_capture_trg_out  & count_enable & capture_mode ;


// CKS¥ì¥¸¥¹¥¿¤Ë¤è¤ëÆ°ºî¥¯¥í¥Ã¥¯(MCK)¤ÎÁªÂò
reg     mck;
always @( cks or ck0 or ck1 or ck2 or ck3 )  begin
    case(cks)
      2'b00: mck = ck0;
      2'b01: mck = ck2;
      2'b11: mck = ck3;
    default: mck = ck1;
    endcase
end

/*
// ¼«CH¤Ç»ÈÍÑ¤¹¤ë¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¥½¡¼¥¹¤ÎÁªÂò
// CCS¥ì¥¸¥¹¥¿¤ÎÀßÄêÃÍ¤Ç¥Ç¥³¡¼¥É¤¹¤ë¡£
always @( ccs or mck or ti_sel_trg or cck_in or brow_in_cas ) begin
    case(ccs)
      2'b00: count_ck_source = mck;
      2'b01: count_ck_source = ti_sel_trg;
      2'b10: count_ck_source = cck_in;
    default: count_ck_source = brow_in_cas;
    endcase
end
*/

assign count_ck_source = ccs ? ti_sel_trg : mck ;
assign count_ck_source_out = count_ck_source ;

// ¥¹¥È¥Ã¥×¥È¥ê¥¬¤ÎÁªÂò  // mod v1.04
// STS=010¤Î»þ¡¢tinÆþÎÏ¤Î¤É¤Á¤é¤«¤Î¥¨¥Ã¥¸¤Ç¥¹¥È¥Ã¥×¡£
// STS=110¤Î»þ¡¢tinÆþÎÏ¤Î¥¨¥Ã¥¸¤Ç¥¹¥È¥Ã¥×¡£

wire stop_trg_sel = (sts[1:0] != 2'b10) ? 1'b0 : pre_cp_trg ;

// Capture & OneCount mode/Judge & OneCount mode¤Ê¤é¡¢stop_trg_sel¤Ç¥¹¥È¥Ã¥×
// OneCount mode¤Ê¤é¡¢borrow¸¡½Ð¿®¹æ¤Ç¥¹¥È¥Ã¥×¡£; borrow & count_clock

//wire pre_stop_trg = ~onecnt_mode ? 1'b0 : (capture_mode | judge_mode) ? stop_trg_sel : borrow & count_clock ; 
wire pre_stop_trg = ~onecnt_mode ? 1'b0 : capture_mode ? stop_trg_sel : borrow & count_clock ; 
wire stop_trg = pre_stop_trg & count_enable ;

// Operation start trigger & Count clock enable

// Count start trigger
wire count_start_trg,count_start_trg_out;

// ¥«¥¦¥ó¥È¥¹¥¿¡¼¥È¥È¥ê¥¬¤ÎÀ¸À®¡£
// ¥¤¥Ù¥ó¥È¥«¥¦¥ó¥È¥â¡¼¥É¤Ç¤Ïwe_ts¤ò¤½¤Î¤Þ¤Þ»È¤¦¡£
// ¥ï¥ó¥«¥¦¥ó¥È¥â¡¼¥É¤Ç¤ÏMD0¥Ó¥Ã¥È¤ÇÆ°ºîÃæ¤Î¥¹¥¿¡¼¥È¥È¥ê¥¬Í­¸ú/Ìµ¸ú¤òÀÚ¤êÂØ¤¨¤ë
// Ã¢¤·¡¢¥¸¥ã¥Ã¥¸¥â¡¼¥É¤Ç¤Ï¡¢MD0¥Ó¥Ã¥È¤Ç¥È¥ê¥¬¤ÎÀ©¸æ¤ò¹Ô¤ï¤Ê¤¤¤Î¤Ç½ü³°¤¹¤ë¡£
// ¤½¤ÎÂ¾¤Î¥â¡¼¥É¤Ç¤Ï¾ï¤Ë¥¹¥¿¡¼¥È¥È¥ê¥¬¤¬Í­¸ú
// ¥È¥ê¥¬¥¹¥¿¡¼¥È¥â¡¼¥É(¥¦¥¨¥¤¥È¥â¡¼¥É)°Ê³°¤Ê¤éts¥ì¥¸¥¹¥¿½ñ¤­¹þ¤ß¤ÇMCK¤Ë¹ç¤ï¤»¤Æ¥¢¥¯¥Æ¥£¥Ö¤Ë¤¹¤ë¡£
// ¥È¥ê¥¬¥¹¥¿¡¼¥È¥â¡¼¥É(¥¦¥¨¥¤¥È¥â¡¼¥É)¤Ê¤éTE=1¾õÂÖ¤Ç¥¹¥¿¡¼¥È¥È¥ê¥¬È¯À¸¤Ç¥¢¥¯¥Æ¥£¥Ö¤È¤Ê¤ë¡£

//assign count_start_trg = (we_tt&chdata) ? 1'b0 : (event_mode) ? (we_ts&chdata) : ~(~judge_mode&onecnt_mode&~md0&count_en_register)&ts_trg ;
assign count_start_trg = (we_tt&chdata) ? 1'b0 : (event_mode) ? (we_ts&chdata) : ~(onecnt_mode&~md0&count_en_register)&ts_trg ;

// ¥¹¥ì¡¼¥Ö¤ËÅÁ¤¨¤ë¥¹¥¿¡¼¥È¥È¥ê¥¬¤ÎÀ¸À®¡£
// STA¤Çµ¼»÷¥¨¥é¡¼¤¬¸«¤¨¤ë¤¿¤á¡¢¾å°Ì¤«¤é¤Î¥È¥ê¥¬¤òÈ´¤¯

//assign count_start_trg_out = (we_tt&chdata) ? 1'b0 : (event_mode) ? (we_ts&chdata) : ~(~judge_mode&onecnt_mode&~md0&count_en_register)&ts_trg_out ;
assign count_start_trg_out = (we_tt&chdata) ? 1'b0 : (event_mode) ? (we_ts&chdata) : ~(onecnt_mode&~md0&count_en_register)&ts_trg_out ;

// tau08r2
//wire   count_start_trg_h = ts_trg_h & ~(we_tt & chdata_h); 
wire   count_start_trg_h = (we_tt & chdata_h) ? 1'b0 : ts_trg_h ;

QLK0RTAU08R2V1_TRGCTL_GL trgctl_gl ( .we_tt(we_tt), .chdata(chdata),
                              .stop_trg(stop_trg), .count_start_trg(count_start_trg),
                              .count_en_register(count_en_register), .pre_count_en(pre_count_en) );

// synopsys async_set_reset "presetz"
always @( posedge pclk or negedge presetz ) begin
    if(~presetz) begin
        count_en_register <= 1'b0;
    end
    else if (counten_all) begin
        count_en_register <= pre_count_en;
    end
end

QLK0RTAU08R2V1_TRGCTL_GL trgctl_glh ( .we_tt(we_tt), .chdata(chdata_h),
                              .stop_trg(1'b0), .count_start_trg(count_start_trg_h),
                              .count_en_register(count_en_register_h), .pre_count_en(pre_count_en_h) );

always @( posedge pclk or negedge presetz ) begin
    if(~presetz) begin
        count_en_register_h <= 1'b0;
    end
    else if (counten_all) begin
        count_en_register_h <= pre_count_en_h;
    end
end


// Count clock
wire count_clock;
//wire count_clock_out;

// ¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¤ÎÀ¸À®
// ¥«¥¦¥ó¥È¥¤¥Í¡¼¥Ö¥ë¥ì¥¸¥¹¥¿¤¬1¤Ë¤Ê¤Ã¤¿¤é¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¤òÆ°ºî³«»Ï¤µ¤»¤ë¡£
//assign count_clock = count_en_register & count_ck_source ;
assign count_clock = count_enable & count_ck_source ;

wire count_clock_h;
assign count_clock_h = count_en_register_h & mck;

// ¥¹¥ì¡¼¥Ö¤ËÅÁ¤¨¤ë¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¤ÎÀ¸À®¡£
// STA¤Îµ¼»÷¥¨¥é¡¼ËÉ»ß¤Î¤¿¤á¡¢ÉÔÉ¬Í×¤Ê¾å°Ì¤«¤é¤Î¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¤òÈ´¤¤¤Æ¤¤¤ë¡£
//assign count_clock_out = count_enable & count_ck_source_out;

wire ge_enout = stop_trg | count_start_trg | count_start_trg_h;

endmodule



module QLK0RTAU08R2V1_TRGCTL_GL (we_tt, chdata, stop_trg, count_start_trg, count_en_register, pre_count_en);

input  we_tt ;
input  chdata ;
input  stop_trg ;
input  count_start_trg ;
input  count_en_register;
output pre_count_en;

reg pre_count_en;
always @(we_tt or chdata or stop_trg or count_start_trg or count_en_register) begin
  if (we_tt&chdata)         pre_count_en = 1'b0;
  else if (count_start_trg) pre_count_en = 1'b1;
  else if (stop_trg)        pre_count_en = 1'b0;
  else                      pre_count_en = count_en_register;
end


endmodule



module QLK0RTAU08R2V1_TRGCNT ( master, brow_src1, brow_src2, brow_sel );

input  master;
input  brow_src1;
input  brow_src2;
//input  start_src1;
//input  start_src2;
//input  cck_src1;
//input  cck_src2;

output  brow_sel;
//output  start_sel;
//output  cck_sel;

wire    brow_sel;
//wire    start_sel;
//wire    cck_sel;

// ¥Þ¥¹¥¿¡¼¤«¤é¥¹¥ì¡¼¥Ö¤ËÅÁ¤¨¤ë¥Ü¥í¡¼¿®¹æ¤ÎÁªÂò
// Ï¢·ë¤¹¤ëCH¤Î¾å°ÌCH¤¬¥Þ¥¹¥¿¡¼¤Ê¤é¤½¤ÎCH¤Î¥Ü¥í¡¼¤ò²¼¤ËÅÁ¤¨¤ë¡£¥¹¥ì¡¼¥Ö¤Ê¤é
// ¤½¤Î¾å°ÌCH¤«¤é¤Î¥Ü¥í¡¼¤òÅÁ¤¨¤ë¡£
assign brow_sel   = master ? brow_src2   : brow_src1;

// ¥Þ¥¹¥¿¡¼¤«¤é¥¹¥ì¡¼¥Ö¤ËÅÁ¤¨¤ë¥¹¥¿¡¼¥È¿®¹æ¤ÎÁªÂò
// Ï¢·ë¤¹¤ëCH¤Î¾å°ÌCH¤¬¥Þ¥¹¥¿¡¼¤Ê¤é¤½¤ÎCH¤Î¥¹¥¿¡¼¥È¿®¹æ¤ò²¼¤ËÅÁ¤¨¤ë¡£
// ¥¹¥ì¡¼¥Ö¤Ê¤é¤½¤Î¾å°ÌCH¤«¤é¤Î¥¹¥¿¡¼¥È¿®¹æ¤òÅÁ¤¨¤ë¡£
//assign start_sel  = master ? start_src2  : start_src1;

// ¥Þ¥¹¥¿¡¼¤«¤é¥¹¥ì¡¼¥Ö¤ËÅÁ¤¨¤ë¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¿®¹æ¤ÎÁªÂò
// Ï¢·ë¤¹¤ëCH¤Î¾å°ÌCH¤¬¥Þ¥¹¥¿¡¼¤Ê¤é¤½¤ÎCH¤Î¥«¥¦¥ó¥È¥¯¥í¥Ã¥¯¿®¹æ¤ò²¼¤ËÅÁ¤¨¤ë¡£
// ¥¹¥ì¡¼¥Ö¤Ê¤é¤½¤Î¾å°ÌCH¤«¤é¤Î¥¹¥¿¡¼¥È¿®¹æ¤òÅÁ¤¨¤ë¡£
//assign cck_sel    = master ? cck_src2    : cck_src1;


endmodule


module QLK0RTAU08R2V1_GECTL ( ck3, ck2, ck1, ck0, we_ts, we_tt, encount7, encount6,
                              encount5 ,encount4 ,encount3, encount2, encount1, encount0,
                              ck_all_l, ck_all_h, tstt_all, counten_all );

input   ck3;
input   ck2;
input   ck1;
input   ck0;

input   we_ts;
input   we_tt;

input   encount7;
input   encount6;
input   encount5;
input   encount4;
input   encount3;
input   encount2;
input   encount1;
input   encount0;

output  ck_all_l;
output  ck_all_h;
output  tstt_all;
output  counten_all;

// CH¶¦ÄÌ¤Î¥²¡¼¥Æ¥£¥ó¥°¿®¹æ¤òºîÀ®

wire   ck_all_l, ck_all_h;
assign ck_all_l = ck0 | ck1 ;
assign ck_all_h = ck0 | ck1 | ck2 | ck3;

// ¥«¥¦¥ó¥È¥¤¥Í¡¼¥Ö¥ë¥ì¥¸¥¹¥¿¤Î¥²¡¼¥Æ¥¤¥ó¥°¿®¹æ
// ts¥ì¥¸¥¹¥¿½ñ¤­¹þ¤ß¤Ç¥»¥Ã¥È¡¢tt¥ì¥¸¥¹¥¿½ñ¤­¹þ¤ß¤Ç¥¯¥ê¥¢¤¹¤ëÉ¬Í×¤¬¤¢¤ë¤Î¤Ç
// ¤³¤³¤Ç¤Þ¤È¤á¤Æ¤ª¤¯¡£
wire  tstt_all = we_ts | we_tt ;

wire  counten_all = encount7 | encount6 | encount5 | encount4
                  | encount3 | encount2 | encount1 | encount0
                  | we_ts | we_tt ;

endmodule


/////////////////////////////////////////////////////////////////////////////////////////////////
// Revision History
/////////////////////////////////////////////////////////////////////////////////////////////////
//
// ver.0.01 (2009.10.23) y.takata : Local
//     1) first edition
// ver.0.02 (2009.11.05) y.takata : Local
//     2) Change in RTL description > TRGCTL:count_start_trg_h (MANTIS ID:1461)
//     3) Change of counter circuit > COUNTER_H:ge_count_register_l/h (MANTIS ID:1462)
//     4) Change of ts_data_h circuit > TRGCTL:ts_data_h, ts_h (MANTIS ID:1466)
// ver.0.03 (2009.11.09) y.takata : Local
//     5) Change of counter circuit > COUNTER_H:pre_load_trg_h (MANTIS ID:1468)
//     6) Change of counter circuit > COUNTER_H:borrow_sel_l -> borrow (MANTIS ID:1469)
// ver.0.04 (2009.11.09) y.takata : Local
//     7) Change of prsu circuit    > PRSU:tps register (MANTIS ID:1470)
//         TPS register bit 15,14,11,10 are RFU and fixed to 0.
//         pclk signal connection change PCLK -> PCLKRW
//     8) Change of Specifications  > Input port signal change (delete:PSEL3, add:NFEN7-0)
//        add module CH_0, TOCTL_0, REGU_0     change module REGU_057 -> REGU_57
// ver.0.05 (2009.11.10) y.takata : Local
//     9) Change of prdata circuit  > TOM0/TOL0 bit are RFU and fixed to 0. (MANTIS ID:1473)
// ver.0.06 (2009.11.13) y.takata : Local
//    10) Change of te_h circuit    > SPLIT is added to TEH control. (MANTIS ID:1477)
//    11) Change of counter circuit > SPLIT is added to load_data_h. (MANTIS ID:1478)
//    12) Change of counter circuit > SPLIT is added to tcr[15:8].   (MANTIS ID:1478)
// ver.0.07 (2009.11.17) y.takata : Local
//    13) Change of counter circuit > load_data_h is described in 2 places. (MANTIS ID:1478)
// ver.0.08 (2009.11.24) y.takata : DF
//    14) Change of regu circuit    > we_ts/we_tt is corrected.   (function:same as v0.07)
//    15) Change of apbif circuit   > case(1'b1) is corrected.    (function:same as v0.07)
//    16) Change of trgctl circuit  > svhold(=Low) is deleted.    (function:same as v0.07)
//    17) cascnt/ch_dummy is deleted. > The function is the same as v0.07.
// ver.0.09 (2009.11.25) y.takata : Local
//    18) Change of TOP circuit     > regu3/regu7 is corrected.PCLK->PCLKRW (MANTIS ID:1521)
// ver.0.10 (2009.12.04) y.takata : Local
//    19) Change of TOP circuit     > divide EDGEU -> FILTER + EDGEU (for Conformal test)
//    20) Change of TOP circuit     > include REGU -> CH/REGU (for Conformal test & ungruop)
//    21) Change of regu circuit    > we_xxx is corrected.        (function:same as v0.09)
//    22) Change of prsu circuit    > we_tps is corrected.        (function:same as v0.09)
//    23) Change of counter circuit > we_tdr is corrected.        (function:same as v0.09)
//    24) brow_in_cas is deleted.   > The function is the same as v0.09.
//    25) start_in is deleted.      > The function is the same as v0.09.
//    26) brow_up is deleted.       > The function is the same as v0.09.
//    27) count_clock_out is deleted. > The function is the same as v0.09.
//    28) re_clr/re_set is deleted. > The function is the same as v0.09.
//    29) judge_mode is deleted.    > The function is the same as v0.09.
//    30) keep_sel_trg is deleted.  > The function is the same as v0.09.
//    31) Change of counter circuit > clock gating of TCRn        (function:same as v0.09)
//    32) Change of counter circuit > TCR1/TCR3 is corrected. (for 16bit timer mode)
//    33) Change of filter  circuit > ff3 circuit is corrected.
// ver.0.11 (2009.12.10) y.takata : DF
//    34) Change of clock gating circuit > ck_all is corrected.   (MANTIS ID:1554)
// ver.0.12 (2009.12.18) y.takata : Local
//    35) RTL without the clock gating. (function:same as v0.10/v0.11)  (MANTIS ID:1559)
// ver.0.13 (2010.01.07) y.takata : Local
//    36) RTL with the clock gating. (function:same as v0.12)
// ver.0.14 (2010.01.14) y.takata : Local
//    37) RTL with the clock gating of TINn. (change of TINn spec)
//        
/////////////////////////////////////////////////////////////////////////////////////////////////


