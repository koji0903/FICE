//--------------------------------------------------------------------------//
//                                                                          //
//    Macro name: QLK0RSAU04R2V1                                            //
//    Version   : CF 1.00                                                   //
//    Date      : 2009/12/18                                                //
//    Creator   : T.Katsuki / NMS                                           //
//    History   : 2009/12/18 All verification is done                       //
//                2009/12/03 Basic verification done                        //
//                2009/11/24 Release DF2                                    //
//                2009/09/25 Release DF1                                    //
//--------------------------------------------------------------------------//
// (C) Copyright NEC Electronics Corporation 2009
// All Rights Reserved. Do not duplicate without prior written
// consent of NEC Electronics Corporation.


`timescale 10ps/10ps

module  QLK0RSAU04R2V1 (
                 PCLK,    PCLKRW,    PRESETZ,
                 PSEL2,    PSEL1,    PENABLE,  PWRITE,
                 PADDR5,   PADDR4,   PADDR3,   PADDR2,   PADDR1,
                 PWDATA31, PWDATA30, PWDATA29, PWDATA28, PWDATA27, PWDATA26, PWDATA25,
                 PWDATA24, PWDATA23, PWDATA22, PWDATA21, PWDATA20, PWDATA19, PWDATA18,
                 PWDATA17, PWDATA16, PWDATA15, PWDATA14, PWDATA13, PWDATA12, PWDATA11,
                 PWDATA10, PWDATA9,  PWDATA8,  PWDATA7,  PWDATA6,  PWDATA5,  PWDATA4,
                 PWDATA3,  PWDATA2,  PWDATA1,  PWDATA0,
                 PRDATA15, PRDATA14, PRDATA13, PRDATA12, PRDATA11,
                 PRDATA10, PRDATA9,  PRDATA8,  PRDATA7,  PRDATA6,  PRDATA5,  PRDATA4,
                 PRDATA3,  PRDATA2,  PRDATA1,  PRDATA0,
                 // Ch 0,1 interface
                 INT0,     INT1,
                 SEINT0,   SEINT1,
                 SIN0,     SIN1,
                 SOUT00,   SOUT01,
                 SOUT10,   SOUT11,
                 SCKO0,    SCKO1,
                 SCKI0,    SCKI1,
                 NFEN0,
                 // Ch 2,3 interface
                 INT2,     INT3,
                 SEINT2,   SEINT3,
                 SIN2,     SIN3,
                 SOUT02,   SOUT03,
                 SOUT12,   SOUT13,
                 SCKO2,    SCKO3,
                 SCKI2,    SCKI3,
                 NFEN2,
                 // General interface
                 PRS13,    PRS12,    PRS11,    PRS10,
                 PRS03,    PRS02,    PRS01,    PRS00,
                 CK0,      CK1,      REQPCLK,
                 SCANEN,   SCANMODE
                 );

//parameter LCLP=1'b0;
//parameter HCLP=1'b1;

// System signal
  input  PCLK;
  input  PCLKRW;
  input  PRESETZ;
// APB I/F
  input  PSEL1;
  input  PSEL2;
//   input  PSEL3;
  input  PADDR5;
  input  PADDR4;
  input  PADDR3;
  input  PADDR2;
  input  PADDR1;
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

  // Channel 0,1 interface
  output INT0;
  output INT1;
  output SEINT0;
  output SEINT1;
  input SIN0;
  input SIN1;
  output SOUT00;
  output SOUT01;
  output SOUT10;
  output SOUT11;
  output SCKO0;
  output SCKO1;
  input SCKI0;
  input SCKI1;
  input NFEN0;
  // Channel 2,3 interface
  output INT2;
  output INT3;
  output SEINT2;
  output SEINT3;
  input SIN2;
  input SIN3;
  output SOUT02;
  output SOUT03;
  output SOUT12;
  output SOUT13;
  output SCKO2;
  output SCKO3;
  input SCKI2;
  input SCKI3;
  input NFEN2;

// Prescalar Control
  output PRS13;
  output PRS12;
  output PRS11;
  output PRS10;
  output PRS03;
  output PRS02;
  output PRS01;
  output PRS00;

// Input from Prescalar
  input CK0;
  input CK1;

// CSC control
  output REQPCLK;
   
// For SCAN TEST
  input SCANEN;
  input SCANMODE;
   

// Wire Definition
wire [15:0] sdr0_data, sdr1_data, sdr2_data, sdr3_data;
wire [15:0] smr0_data, smr1_data, smr2_data, smr3_data;
wire [15:0] scr0_data, scr1_data, scr2_data, scr3_data;
wire [15:0] ssr0_data, ssr1_data, ssr2_data, ssr3_data;
wire        se03, se02, se01, se00;
wire        soe03, soe02, soe01, soe00;
wire        sol03, sol02, sol01, sol00;
wire [15:0] sps;

wire        re_sdr0, re_sdr1, re_sdr2, re_sdr3;

// APB Signal
wire [5:1] gate_paddr;
wire [31:0] gate_pwdata;
wire we_uhw, we_lhw;
wire sel_sdr0, sel_sdr1, sel_sdr2, sel_sdr3;
wire sel_smr0, sel_smr1, sel_smr2, sel_smr3;
wire sel_scr0, sel_scr1, sel_scr2, sel_scr3;
wire sel_sir0, sel_sir1, sel_sir2, sel_sir3;
wire sel_ss, sel_st, sel_sps;
wire sel_ssc;
wire wr_so, wr_sol, wr_st, wr_soe;

// Interconnect
wire SEINT0, SEINT1, SEINT2, SEINT3;
wire CK0, CK1;
wire count_clock0, count_clock1, count_clock2, count_clock3;
wire md_uart0, md_uart1, md_uart2, md_uart3;
wire stss_all;

wire sout0_src, sout1_src, sout2_src, sout3_src;
wire sin0_sel, sin1_sel, sin2_sel, sin3_sel;
wire md_iic0, md_iic1, md_iic2, md_iic3;

wire CKEN0, CKEN1, CKEN2, CKEN3;
wire fast_mode0, fast_mode1, fast_mode2, fast_mode3;
wire sin0_nf, sin1_nf, sin2_nf, sin3_nf;
wire ack_timing0, ack_timing1, ack_timing2, ack_timing3;

assign gate_pwdata = {PWDATA31, PWDATA30, PWDATA29, PWDATA28, PWDATA27, PWDATA26, PWDATA25, PWDATA24,
                      PWDATA23, PWDATA22, PWDATA21, PWDATA20, PWDATA19, PWDATA18, PWDATA17, PWDATA16,
                      PWDATA15, PWDATA14, PWDATA13, PWDATA12, PWDATA11, PWDATA10, PWDATA9, PWDATA8,
                      PWDATA7, PWDATA6, PWDATA5, PWDATA4, PWDATA3, PWDATA2, PWDATA1, PWDATA0};
assign gate_paddr = {PADDR5, PADDR4, PADDR3, PADDR2, PADDR1};

wire PRS13 = sps[7];
wire PRS12 = sps[6];
wire PRS11 = sps[5];
wire PRS10 = sps[4];
wire PRS03 = sps[3];
wire PRS02 = sps[2];
wire PRS01 = sps[1];
wire PRS00 = sps[0];

//wire [3:0] snc;
wire [1:0] ssc;

wire swc = ssc[0];
wire ssec = ssc[1];
wire rxe0 = scr0_data[14];
wire rxe1 = scr1_data[14];
wire rxe2 = scr2_data[14];
wire rxe3 = scr3_data[14];

wire ch1_error;
   
// APB Bus I/F Module (Address Decode, Data Output)
QLK0RSAU04R2V1_APBIF apbif (
                 .psel2(PSEL2), .psel1(PSEL1), .penable(PENABLE), .pwrite(PWRITE), 
                 .paddr5(gate_paddr[5]), .paddr4(gate_paddr[4]),
                 .paddr3(gate_paddr[3]), .paddr2(gate_paddr[2]), .paddr1(gate_paddr[1]),
                 .prdata15(PRDATA15), .prdata14(PRDATA14), .prdata13(PRDATA13), .prdata12(PRDATA12),
                 .prdata11(PRDATA11), .prdata10(PRDATA10), .prdata9(PRDATA9),   .prdata8(PRDATA8),
                 .prdata7(PRDATA7),   .prdata6(PRDATA6),   .prdata5(PRDATA5),   .prdata4(PRDATA4),
                 .prdata3(PRDATA3),   .prdata2(PRDATA2),   .prdata1(PRDATA1),   .prdata0(PRDATA0),
                 .we_uhw(we_uhw), .we_lhw(we_lhw),
                 .sel_sdr0(sel_sdr0), .sel_sdr1(sel_sdr1), .sel_sdr2(sel_sdr2), .sel_sdr3(sel_sdr3),
                 .sel_smr0(sel_smr0), .sel_smr1(sel_smr1), .sel_smr2(sel_smr2), .sel_smr3(sel_smr3),
                 .sel_scr0(sel_scr0), .sel_scr1(sel_scr1), .sel_scr2(sel_scr2), .sel_scr3(sel_scr3),
                 .sel_sir0(sel_sir0), .sel_sir1(sel_sir1), .sel_sir2(sel_sir2), .sel_sir3(sel_sir3),
                 .sel_ss(sel_ss),   .sel_st(sel_st),   .sel_sps(sel_sps),
                 .sel_ssc(sel_ssc),
                 .re_sdr0(re_sdr0), .re_sdr1(re_sdr1), .re_sdr2(re_sdr2), .re_sdr3(re_sdr3),
                 .wr_so(wr_so),.wr_sol(wr_sol), .wr_st(wr_st), .wr_soe(wr_soe),
                 .sdr0_data(sdr0_data), .smr0_data(smr0_data),
                 .scr0_data(scr0_data), .ssr0_data(ssr0_data),
                 .sdr1_data(sdr1_data), .smr1_data(smr1_data),
                 .scr1_data(scr1_data), .ssr1_data(ssr1_data),
                 .sdr2_data(sdr2_data), .smr2_data(smr2_data),
                 .scr2_data(scr2_data), .ssr2_data(ssr2_data),
                 .sdr3_data(sdr3_data), .smr3_data(smr3_data),
                 .scr3_data(scr3_data), .ssr3_data(ssr3_data),
                 .cko03(SCKO3), .cko02(SCKO2), .cko01(SCKO1), .cko00(SCKO0), 
                 .so03(sout3_src), .so02(sout2_src), .so01(sout1_src), .so00(sout0_src),
                 .soe03(soe03), .soe02(soe02), .soe01(soe01), .soe00(soe00),
                 .sol03(sol03), .sol02(sol02), .sol01(sol01), .sol00(sol00),
                 .se03(se03), .se02(se02), .se01(se01), .se00(se00),
                 .sps(sps), .ssc(ssc) );

// General RegisterPrescalor Module
QLK0RSAU04R2V1_GREG gregu (
                 .pclkrw(PCLKRW), .presetz(PRESETZ),
                 .peri_write(gate_pwdata[7:0]), .sel_sps(sel_sps),
                 .sel_ssc(sel_ssc), .pwrite(PWRITE), .penable(PENABLE),
                 .sps(sps), .ssc(ssc) );

// SAU ch0 module
QLK0RSAU04R2V1_MAIN_C0 ch0 (
                 .peclk(PCLK), .pclkrw(PCLKRW), .peresetz(PRESETZ),
                 .ck0(CK0), .ck1(CK1),
                 .peri_write(gate_pwdata[15:0]), .common_write({gate_pwdata[8],gate_pwdata[0]}), .re_sdr(re_sdr0),
                 .sel_sdr(sel_sdr0), .sel_smr(sel_smr0), .sel_scr(sel_scr0), .sel_sir(sel_sir0),
                 .wr_st(wr_st), .wr_so(wr_so),
                 .wr_soe(wr_soe), .wr_sol(wr_sol),
                 .we_ulhw(we_lhw), .we_lhw(we_lhw), .we_uhw(we_uhw),
                 .sdr_data(sdr0_data), .smr_data(smr0_data),
                 .scr_data(scr0_data), .ssr_data(ssr0_data),
                 .se(se00), .soe(soe00), .sol(sol00),
                 .count_clock(count_clock0),
                 .md_uart(md_uart0), .md_iic(md_iic0),
                 .stss_all(stss_all),
                 .sin(sin0_sel), .sin_direct(SIN0), .scki(SCKI0), .sout(sout0_src), 
                 .scko(SCKO0), .int_sig(INT0), .eint(SEINT0), .mck(CKEN0),
                 .fast_mode(fast_mode0), .scanmode(SCANMODE), .swc(swc), .ack_timing(ack_timing0)
                   );


// SAU ch1 module
QLK0RSAU04R2V1_MAIN_C1 ch1 (
                 .peclk(PCLK), .pclkrw(PCLKRW), .peresetz(PRESETZ),
                 .ck0(CK0), .ck1(CK1), 
                 .peri_write(gate_pwdata[31:16]), .common_write({gate_pwdata[9],gate_pwdata[1]}), .re_sdr(re_sdr1),
                 .sel_sdr(sel_sdr1), .sel_smr(sel_smr1), .sel_scr(sel_scr1), .sel_sir(sel_sir1),
                 .wr_st(wr_st), .wr_so(wr_so),
                 .wr_soe(wr_soe), .wr_sol(wr_sol),
                 .we_ulhw(we_uhw), .we_lhw(we_lhw), .we_uhw(we_uhw),
                 .sdr_data(sdr1_data), .smr_data(smr1_data),
                 .scr_data(scr1_data), .ssr_data(ssr1_data),
                 .se(se01), .soe(soe01), .sol(sol01),
                 .count_clock(count_clock1),
                 .md_uart(md_uart1), .md_iic(md_iic1),
                 .stss_all(stss_all),
                 .sin(sin1_sel), .sin_direct(SIN1), .scki(SCKI1), .sout(sout1_src),
                 .scko(SCKO1), .int_sig(INT1), .eint(SEINT1), .mck(CKEN1),
                 .fast_mode(fast_mode1), .scanmode(SCANMODE), .swc(swc), .ssec(ssec),
                 .ch_error(ch1_error), .ack_timing(ack_timing1)
                 );
   


// SAU ch2 module
QLK0RSAU04R2V1_MAIN_B0 ch2 (
                 .peclk(PCLK), .pclkrw(PCLKRW), .peresetz(PRESETZ),
                 .ck0(CK0), .ck1(CK1), 
                 .peri_write(gate_pwdata[15:0]), .common_write({gate_pwdata[10],gate_pwdata[2]}), .re_sdr(re_sdr2),
                 .sel_sdr(sel_sdr2), .sel_smr(sel_smr2), .sel_scr(sel_scr2), .sel_sir(sel_sir2),
                 .wr_st(wr_st), .wr_so(wr_so),
                 .wr_soe(wr_soe), .wr_sol(wr_sol),
                 .we_ulhw(we_lhw), .we_lhw(we_lhw), .we_uhw(we_uhw),
                 .sdr_data(sdr2_data), .smr_data(smr2_data),
                 .scr_data(scr2_data), .ssr_data(ssr2_data),
                 .se(se02), .soe(soe02), .sol(sol02),
                 .count_clock(count_clock2),
                 .md_uart(md_uart2), .md_iic(md_iic2),
                 .stss_all(stss_all),
                 .sin(sin2_sel), .sin_direct(SIN2), .scki(SCKI2), .sout(sout2_src),
                 .scko(SCKO2), .int_sig(INT2), .eint(SEINT2), .mck(CKEN2),
                 .fast_mode(fast_mode2), .ack_timing(ack_timing2)
                  );

// SAU ch3 module
QLK0RSAU04R2V1_MAIN_B1 ch3 (
                 .peclk(PCLK), .pclkrw(PCLKRW), .peresetz(PRESETZ),
                 .ck0(CK0), .ck1(CK1),
                 .peri_write(gate_pwdata[31:16]), .common_write({gate_pwdata[11],gate_pwdata[3]}), .re_sdr(re_sdr3),
                 .sel_sdr(sel_sdr3), .sel_smr(sel_smr3), .sel_scr(sel_scr3), .sel_sir(sel_sir3),
                 .wr_st(wr_st), .wr_so(wr_so),
                 .wr_soe(wr_soe), .wr_sol(wr_sol),
                 .we_ulhw(we_uhw), .we_lhw(we_lhw), .we_uhw(we_uhw),
                 .sdr_data(sdr3_data), .smr_data(smr3_data),
                 .scr_data(scr3_data), .ssr_data(ssr3_data),
                 .se(se03), .soe(soe03), .sol(sol03),
                 .count_clock(count_clock3),
                 .md_uart(md_uart3), .md_iic(md_iic3),
                 .stss_all(stss_all),
                 .sin(sin3_sel), .sin_direct(SIN3), .scki(SCKI3), .sout(sout3_src),
                 .scko(SCKO3), .int_sig(INT3), .eint(SEINT3), .mck(CKEN3),
                 .fast_mode(fast_mode3), .ack_timing(ack_timing3)
                  );
   

// Serial I/F selector modulr for ch0 and ch1
QLK0RSAU04R2V1_SIF sif01(
                        .sin_ev_i(sin0_nf), .sin_od_i(sin1_nf),
                        //.sin_od_thr(SIN1),  .csi_fast_od(fast_mode1),
                        .sin_ev_o(sin0_sel),  .sin_od_o(sin1_sel),
                        .sout_ev_i(sout0_src), .sout_od_i(sout1_src),
                        .sout0_ev_o(SOUT00), .sout1_ev_o(SOUT10), .sout0_od_o(SOUT01), .sout1_od_o(SOUT11),
                        .all_uart(md_uart0&md_uart1),
                        .md_iic_ev(md_iic0), .md_iic_od(md_iic1)
                      );

// Serial I/F selector modulr for ch2 and ch3
QLK0RSAU04R2V1_SIF sif23(
                        .sin_ev_i(sin2_nf),      .sin_od_i(sin3_nf),
                        //.sin_od_thr(SIN3),  .csi_fast_od(fast_mode3),
                        .sin_ev_o(sin2_sel),  .sin_od_o(sin3_sel),
                        .sout_ev_i(sout2_src), .sout_od_i(sout3_src),
                        .sout0_ev_o(SOUT02), .sout1_ev_o(SOUT12), .sout0_od_o(SOUT03), .sout1_od_o(SOUT13),
                        .all_uart(md_uart2&md_uart3),
                        .md_iic_ev(md_iic2), .md_iic_od(md_iic3)
                      );


QLK0RSAU04R2V1_SNF0  nf0(.pclk(PCLK), .presetz(PRESETZ), .cken(CKEN0), .rxe_ev(rxe0),
                        .rxe_od(rxe1&md_uart1), .iic_ack_timing(ack_timing0),
                        .din(SIN0), .dout(sin0_nf),
                        .nfen(NFEN0), .ch1_error(ch1_error&ssc[1]), .sis(smr1_data[6]) );
   
QLK0RSAU04R2V1_SYNC sync1(.pclk(PCLK), .presetz(PRESETZ), .cken(CKEN1), .rxe(rxe1),
                         .iic_ack_timing(ack_timing1),
                         .din(SIN1), .dout(sin1_nf) );

QLK0RSAU04R2V1_SNF2  nf2(.pclk(PCLK), .presetz(PRESETZ), .cken(CKEN2), .rxe_ev(rxe2),
                        .rxe_od(rxe3&md_uart3), .iic_ack_timing(ack_timing2),
                        .din(SIN2), .dout(sin2_nf),
                        .nfen(NFEN2) );

QLK0RSAU04R2V1_SYNC sync3(.pclk(PCLK), .presetz(PRESETZ), .cken(CKEN3), .rxe(rxe3),
                         .iic_ack_timing(ack_timing3),
                         .din(SIN3), .dout(sin3_nf) );
      
// Gating Contorol
QLK0RSAU04R2V1_GECTL gectl (
                      .sel_ss(sel_ss), .sel_st(sel_st), .stss_all(stss_all)
                        );

QLK0RSAU04R2V1_WUP wup (.pclk(PCLK), .presetz(PRESETZ), .scanmode(SCANMODE),
                        .ssc(ssc[0]), .ckp(scr0_data[12]), .sis(smr1_data[6]),
                        .scki(SCKI0), .sin(SIN0), .ch1_error(ch1_error),
                        .all_uart(md_uart0 & md_uart1),
                        .reqpclk(REQPCLK) );
 
   
endmodule


module  QLK0RSAU04R2V1_APBIF (
                 psel2,  psel1,  penable,  pwrite,
                 paddr5, paddr4, paddr3, paddr2, paddr1,
                 prdata15, prdata14, prdata13, prdata12, prdata11, prdata10, prdata9,  prdata8,
                 prdata7,  prdata6,  prdata5,  prdata4,  prdata3,  prdata2,  prdata1,  prdata0,
                 we_uhw, we_lhw,
                 sel_sdr0, sel_sdr1, sel_sdr2, sel_sdr3,
                 sel_smr0, sel_smr1, sel_smr2, sel_smr3,
                 sel_scr0, sel_scr1, sel_scr2, sel_scr3,
                 sel_sir0, sel_sir1, sel_sir2, sel_sir3,
                 sel_ss,
                 sel_st,
                 sel_sps, sel_ssc,
                 wr_soe, wr_so, wr_sol, wr_st,
                 re_sdr0, re_sdr1, re_sdr2, re_sdr3,
                 sdr0_data, smr0_data, scr0_data, ssr0_data,
                 sdr1_data, smr1_data, scr1_data, ssr1_data,
                 sdr2_data, smr2_data, scr2_data, ssr2_data,
                 sdr3_data, smr3_data, scr3_data, ssr3_data,
                 cko03, cko02, cko01, cko00,
                 so03, so02, so01, so00,
                 soe03, soe02, soe01, soe00,
                 sol03, sol02, sol01, sol00,
                 se03, se02, se01, se00,
                 sps, ssc
                 );


parameter SDR0_ADR=5'h00;
parameter SDR1_ADR=5'h01;
parameter SDR2_ADR=5'h02;
parameter SDR3_ADR=5'h03;
parameter SSR0_ADR=5'h00;
parameter SSR1_ADR=5'h01;
parameter SSR2_ADR=5'h02;
parameter SSR3_ADR=5'h03;
parameter SIR0_ADR=5'h04;
parameter SIR1_ADR=5'h05;
parameter SIR2_ADR=5'h06;
parameter SIR3_ADR=5'h07;
parameter SMR0_ADR=5'h08;
parameter SMR1_ADR=5'h09;
parameter SMR2_ADR=5'h0A;
parameter SMR3_ADR=5'h0B;
parameter SCR0_ADR=5'h0C;
parameter SCR1_ADR=5'h0D;
parameter SCR2_ADR=5'h0E;
parameter SCR3_ADR=5'h0F;
parameter SE_ADR  =5'h10;
parameter SS_ADR  =5'h11;
parameter ST_ADR  =5'h12;
parameter SPS_ADR =5'h13;
parameter SO_ADR  =5'h14;
parameter SOE_ADR =5'h15;
parameter SOL_ADR =5'h1A;
parameter EDR0_ADR=5'h16;
parameter EDR1_ADR=5'h17;
parameter EDR2_ADR=5'h18;
parameter EDR3_ADR=5'h19;
parameter SSC_ADR =5'h1C;   
//parameter SNC_ADR =5'h00;
   
//input psel3;
input psel2;
input psel1;
input penable;
input pwrite;
input paddr5;
input paddr4;
input paddr3;
input paddr2;
input paddr1;


output prdata15;
output prdata14;
output prdata13;
output prdata12;
output prdata11;
output prdata10;
output prdata9;
output prdata8;
output prdata7;
output prdata6;
output prdata5;
output prdata4;
output prdata3;
output prdata2;
output prdata1;
output prdata0;

output we_uhw;  // Upper Half-Word write signal
output we_lhw;  // Lower Half-Word write signal
output sel_sdr0;
output sel_sdr1;
output sel_sdr2;
output sel_sdr3;
output sel_smr0;
output sel_smr1;
output sel_smr2;
output sel_smr3;
output sel_scr0;
output sel_scr1;
output sel_scr2;
output sel_scr3;
output sel_sir0;
output sel_sir1;
output sel_sir2;
output sel_sir3;
output sel_ss;
output sel_st;
output sel_sps;
output wr_soe;
output wr_so;
output wr_sol;
output wr_st;
//output sel_snc;
output sel_ssc;

output re_sdr0;
output re_sdr1;
output re_sdr2;
output re_sdr3;

input [15:0] sdr0_data;
input [15:0] smr0_data;
input [15:0] scr0_data;
input [15:0] ssr0_data;
input [15:0] sdr1_data;
input [15:0] smr1_data;
input [15:0] scr1_data;
input [15:0] ssr1_data;
input [15:0] sdr2_data;
input [15:0] smr2_data;
input [15:0] scr2_data;
input [15:0] ssr2_data;
input [15:0] sdr3_data;
input [15:0] smr3_data;
input [15:0] scr3_data;
input [15:0] ssr3_data;

input cko03;
input cko02;
input cko01;
input cko00;
input so03;
input so02;
input so01;
input so00;
input soe03;
input soe02;
input soe01;
input soe00;
input sol03;
input sol02;
input sol01;
input sol00;
input se03;
input se02;
input se01;
input se00;
input [15:0] sps;
// input [3:0] snc;
input [1:0] ssc;
   
   
// Declaration of reg/wire
reg    sel_sdr0, sel_sdr1, sel_sdr2, sel_sdr3,
       sel_smr0, sel_smr1, sel_smr2, sel_smr3,
       sel_scr0, sel_scr1, sel_scr2, sel_scr3,
       sel_ssr0, sel_ssr1, sel_ssr2, sel_ssr3,
       sel_sir0, sel_sir1, sel_sir2, sel_sir3;
reg    sel_se, sel_ss, sel_st, sel_sps, sel_so, sel_soe, sel_sol;
reg    sel_edr0, sel_edr1, sel_edr2, sel_edr3;
reg    sel_ssc;
   
//==================================================//
//              Generate SEL signals                //
//==================================================//

always @( psel2 or psel1 or paddr5 or paddr4 or paddr3 or paddr2 or paddr1 ) begin
    {sel_sdr0, sel_sdr1, sel_sdr2, sel_sdr3} = 4'h0;
    {sel_smr0, sel_smr1, sel_smr2, sel_smr3} = 4'h0;
    {sel_scr0, sel_scr1, sel_scr2, sel_scr3} = 4'h0;
    {sel_ssr0, sel_ssr1, sel_ssr2, sel_ssr3} = 4'h0;
    {sel_sir0, sel_sir1, sel_sir2, sel_sir3} = 4'h0;
    sel_se = 1'b0;
    sel_ss = 1'b0;
    sel_st = 1'b0;
    sel_sps = 1'b0;
    sel_so = 1'b0;
    sel_soe = 1'b0;
    sel_sol = 1'b0;
    {sel_edr0, sel_edr1, sel_edr2, sel_edr3} = 4'h0;
//     sel_snc = 1'b0;
    sel_ssc = 1'b0;

    case({3'b000, paddr2, paddr1})   // synopsys parallel_case
      SDR0_ADR : sel_sdr0 = psel1;
      SDR1_ADR : sel_sdr1 = psel1;
      SDR2_ADR : sel_sdr2 = psel1;
      SDR3_ADR : sel_sdr3 = psel1;
      default  : begin
                  {sel_sdr0, sel_sdr1, sel_sdr2, sel_sdr3} = 4'h0;
                 end
    endcase

    case({paddr5, paddr4, paddr3, paddr2, paddr1})         // synopsys parallel_case
      SSR0_ADR : sel_ssr0 = psel2;
      SSR1_ADR : sel_ssr1 = psel2;
      SSR2_ADR : sel_ssr2 = psel2;
      SSR3_ADR : sel_ssr3 = psel2;
      SIR0_ADR : sel_sir0 = psel2;
      SIR1_ADR : sel_sir1 = psel2;
      SIR2_ADR : sel_sir2 = psel2;
      SIR3_ADR : sel_sir3 = psel2;
      SMR0_ADR : sel_smr0 = psel2;
      SMR1_ADR : sel_smr1 = psel2;
      SMR2_ADR : sel_smr2 = psel2;
      SMR3_ADR : sel_smr3 = psel2;
      SCR0_ADR : sel_scr0 = psel2;
      SCR1_ADR : sel_scr1 = psel2;
      SCR2_ADR : sel_scr2 = psel2;
      SCR3_ADR : sel_scr3 = psel2;
      SE_ADR   : sel_se  = psel2;
      SS_ADR   : sel_ss  = psel2;
      ST_ADR   : sel_st  = psel2;
      SPS_ADR  : sel_sps  = psel2;
      SO_ADR   : sel_so  = psel2;
      SOE_ADR  : sel_soe  = psel2;
      SOL_ADR  : sel_sol = psel2;
      EDR0_ADR : sel_edr0 = psel2;
      EDR1_ADR : sel_edr1 = psel2;
      EDR2_ADR : sel_edr2 = psel2;
      EDR3_ADR : sel_edr3 = psel2;
      SSC_ADR  : sel_ssc  = psel2;
      default  : begin
                  {sel_ssr0, sel_ssr1, sel_ssr2, sel_ssr3} = 4'h0;
                  {sel_sir0, sel_sir1, sel_sir2, sel_sir3} = 4'h0;
                  {sel_smr0, sel_smr1, sel_smr2, sel_smr3} = 4'h0;
                  {sel_scr0, sel_scr1, sel_scr2, sel_scr3} = 4'h0;
                  sel_se = 1'b0;
                  sel_ss = 1'b0;
                  sel_st = 1'b0;
                  sel_sps = 1'b0;
                  sel_so = 1'b0;
                  sel_soe = 1'b0;
                  sel_sol = 1'b0;
                  {sel_edr0, sel_edr1, sel_edr2, sel_edr3} = 4'h0;
                  sel_ssc = 1'b0;
                 end
    endcase

//     case({4'b000, paddr1})   // synopsys parallel_case
//       SNC_ADR : sel_snc = psel3;
//       default : sel_snc = 1'b0;
//     endcase
  
end

//==================================================//
//              Generate WE signals                 //
// This signal is used for register write.          //
//==================================================//
wire we_lhw;
wire we_uhw;
assign we_lhw = penable & pwrite & ~paddr1;
assign we_uhw = penable & pwrite &  paddr1;

//==================================================//
//             DATA Read Circuit                    //
//==================================================//
reg [31:0] dout;

always @( sel_sdr0 or sel_sdr1 or sel_sdr2 or sel_sdr3 or
          sel_smr0 or sel_smr1 or sel_smr2 or sel_smr3 or
          sel_scr0 or sel_scr1 or sel_scr2 or sel_scr3 or
          sel_ssr0 or sel_ssr1 or sel_ssr2 or sel_ssr3 or
          sel_se  or sel_sps  or sel_so  or
          sel_soe  or sel_sol or
          sdr1_data or sdr0_data or sdr3_data or sdr2_data or
          smr1_data or smr0_data or smr3_data or smr2_data or
          scr1_data or scr0_data or scr3_data or scr2_data or
          ssr1_data or ssr0_data or ssr3_data or ssr2_data or
          se03  or se02  or se01  or se00  or sps  or
          cko03 or cko02 or cko01 or cko00 or
          so03  or so02  or so01  or so00  or
          soe03 or soe02 or soe01 or soe00 or
          sol03 or sol02 or sol01 or sol00 or
          sel_edr0 or sel_edr1 or sel_edr2 or sel_edr3 or
          sel_ssc or ssc
          ) begin

      case(1'b1)         // synopsys parallel_case
        sel_sdr0|sel_sdr1|sel_edr0|sel_edr1 : dout = {sdr1_data, sdr0_data};
        sel_sdr2|sel_sdr3|sel_edr2|sel_edr3 : dout = {sdr3_data, sdr2_data};
        sel_smr0|sel_smr1 : dout = {smr1_data, smr0_data};
        sel_smr2|sel_smr3 : dout = {smr3_data, smr2_data};
        sel_scr0|sel_scr1 : dout = {scr1_data, scr0_data};
        sel_scr2|sel_scr3 : dout = {scr3_data, scr2_data};
        sel_ssr0|sel_ssr1 : dout = {ssr1_data, ssr0_data};
        sel_ssr2|sel_ssr3 : dout = {ssr3_data, ssr2_data};
        sel_se : dout = {28'h0000000, se03, se02, se01, se00};
        sel_sps : dout = {sps, 16'h0000};
        sel_so|sel_soe : dout = {12'h000, soe03, soe02, soe01, soe00, 4'h0, cko03, cko02, cko01, cko00, 4'h0, so03, so02, so01, so00};
        sel_sol : dout = {28'h0000000, sol03, sol02, sol01, sol00};
//         sel_snc : dout = {28'h0000000, snc};
        sel_ssc : dout = {30'h00000000, ssc};
        default : dout = 32'h00000000;
      endcase
end

// 32bit-16bit bus transform Logic
wire dis_word;
assign dis_word = paddr1;
wire [15:0] dout_l = dis_word ? dout[31:16] : dout[15:0] ;

wire [15:0] peri_read;
wire re_en;
assign re_en = penable & ~pwrite;

assign peri_read = re_en ? dout_l : 16'h0000;

// read sdr register signal for Over-run
wire re_sdr0 = sel_sdr0 & re_en ;
wire re_sdr1 = sel_sdr1 & re_en ;
wire re_sdr2 = sel_sdr2 & re_en ;
wire re_sdr3 = sel_sdr3 & re_en ;

wire prdata15 = peri_read[15];
wire prdata14 = peri_read[14];
wire prdata13 = peri_read[13];
wire prdata12 = peri_read[12];
wire prdata11 = peri_read[11];
wire prdata10 = peri_read[10];
wire prdata9 = peri_read[9];
wire prdata8 = peri_read[8];
wire prdata7 = peri_read[7];
wire prdata6 = peri_read[6];
wire prdata5 = peri_read[5];
wire prdata4 = peri_read[4];
wire prdata3 = peri_read[3];
wire prdata2 = peri_read[2];
wire prdata1 = peri_read[1];
wire prdata0 = peri_read[0];


// common signal for all channel
wire wr_so = we_lhw & sel_so;
wire wr_st = we_lhw & sel_st;
wire wr_sol = we_lhw & sel_sol;
wire wr_soe = we_uhw & sel_soe;
 
endmodule

// General RegisterPrescalor Module
module QLK0RSAU04R2V1_GREG (
                 pclkrw, presetz, peri_write,
                 sel_sps, sel_ssc, pwrite, penable,
                 sps, ssc );

   input pclkrw;
   input presetz;
   input [7:0] peri_write ;
   input       sel_sps;
//    input       sel_snc;
   input       sel_ssc;
   input       pwrite;
   input       penable;

   output [15:0] sps;
//    output [3:0] snc;
   output [1:0] ssc;

   
//================================//
//     SPS Register Block         //
//================================//
reg [3:0]         prs1, prs0;
   
  wire ge_sps = pwrite & penable & sel_sps;
always@(posedge pclkrw or negedge presetz) begin
  if (~presetz) begin
    prs1 <= 4'h0;
    prs0 <= 4'h0;
  end
  else if (ge_sps) begin
    prs1 <= peri_write[7:4];
    prs0 <= peri_write[3:0];
  end
end

   assign sps = {8'h00, prs1, prs0};
  

//================================//
//     SNC Register Block         //
//================================//
// reg  snc2, snc0;  
// wire ge_snc = pwrite & penable & sel_snc;
// always@(posedge pclkrw or negedge presetz) begin
//   if (~presetz) begin
//     snc2 <= 1'b0;
//     snc0 <= 1'b0;
//   end
//   else if (ge_snc) begin
//     snc2 <= peri_write[2];
//     snc0 <= peri_write[0];
//   end
// end

// wire [3:0] snc = {1'b0, snc2, 1'b0, snc0};   

//================================//
//     SSC Register Block         //
//================================//
reg [1:0] ssc;  
wire ge_ssc = pwrite & penable & sel_ssc;
always@(posedge pclkrw or negedge presetz) begin
  if (~presetz) begin
    ssc <= 2'h0;
  end
  else if (ge_ssc) begin
    ssc <= peri_write[1:0];
  end
end

endmodule

// For naiming rule  "async_resz2 -> async2_resz"
module QLK0RSAU04R2V1_WUP (
                           pclk, presetz, scanmode,
                           ssc, ckp, sis, all_uart,
                           sin, scki, ch1_error, reqpclk );

   input pclk;
   input presetz;
   input scanmode;
   input ssc;
   input ckp;
   input sis;
   input all_uart;
   input scki;
   input sin;
   input ch1_error;
   
   output reqpclk;
   wire   reqpclk;
   reg    reqpclk_async;
   reg    reqpclk_d1;

   wire   pos_clk = (all_uart ? (~sin ^ sis) : (~scki ^ ckp));
   reg    async_clk;
   reg    sync_ch_error ;

   always@(scanmode or pclk or pos_clk)
     case (scanmode)
       1'b0 : async_clk = pos_clk ;
       1'b1 : async_clk = pclk ;
     endcase
     
//   wire  neg_res = ssc & ~ch1_error;
   wire  neg_res = ssc & ~sync_ch_error;
   reg async_resz;

   always@(scanmode or presetz or neg_res)
     case(scanmode) 
       1'b0 : async_resz = neg_res;
       1'b1 : async_resz = presetz;
     endcase
   
   always@(posedge async_clk or negedge async_resz)
     if (~async_resz) reqpclk_async <= 1'b0;
//     else             reqpclk_async <= 1'b1;
     else             reqpclk_async <= ~scanmode | (pos_clk | neg_res) ; // For fault coverage

   wire async2_resz = presetz & (ssc|scanmode); 	// For naiming rule

   always@(posedge pclk or negedge async2_resz)
     if (~async2_resz) reqpclk_d1 <= 1'b0;
     else              reqpclk_d1 <= reqpclk_async;

   assign reqpclk = reqpclk_async | reqpclk_d1;  

   always@(posedge pclk or negedge async2_resz)
	if (~async2_resz)  	sync_ch_error <= 1'b0;
	else			sync_ch_error <= ch1_error;
   
endmodule

module QLK0RSAU04R2V1_SIF (
                        sin_ev_i, sin_od_i, 
                        sin_ev_o, sin_od_o,
                        sout_ev_i, sout_od_i,
                        sout0_ev_o, sout1_ev_o, sout0_od_o, sout1_od_o,
                        all_uart,
                        md_iic_ev, md_iic_od);

// Input From SAU SIN port
input sin_ev_i;
input sin_od_i;
//input sin_od_thr;
// Output To SAU CH sin port
output sin_ev_o;
output sin_od_o;
// Input From SAU CH sout port
input sout_ev_i;
input sout_od_i;
// Output To SAU SOUT port
output sout0_ev_o;
output sout1_ev_o;
output sout0_od_o;
output sout1_od_o;

// Input Mode signal
input all_uart;
input md_iic_ev;
input md_iic_od;
//input csi_fast_od;

// SIN Selector
wire sin_ev_o = sin_ev_i;

wire sin_od_o = all_uart ? sin_ev_i : sin_od_i;
//reg  sin_od_o;
//always@(csi_fast_od or sin_od_thr or sin_uart)
//  case (csi_fast_od) // synopsys infer_mux
//    1'b1 : sin_od_o = sin_od_thr;
//    1'b0 : sin_od_o = sin_uart;
//  endcase

// SOUT selector
wire sout_ev_tmp = sout_ev_i;
wire sout_od_tmp = sout_od_i; 

// SOUT Separator
wire p_mode_ev = md_iic_ev;
wire p_mode_od = md_iic_od;
wire sout0_ev_o =  p_mode_ev | sout_ev_tmp ;
wire sout1_ev_o = ~p_mode_ev | sout_ev_tmp ;
wire sout0_od_o =  p_mode_od | sout_od_tmp ;
wire sout1_od_o = ~p_mode_od | sout_od_tmp ;

endmodule

// Consider Active timing
// CSI send -> STOP
// CSI recv,send/recv  -> run at ~trans_state
// UART send -> STOP
// UART receive -> run at CKEN
// IIC send -> STOP
// IIC recv,send/recv -> run at ~trans_state
// For ch0, ch2

module  QLK0RSAU04R2V1_SNF0 (pclk, presetz, cken, rxe_ev, rxe_od, iic_ack_timing,
                             din, dout, nfen, ch1_error, sis);
   input pclk;
   input presetz;
   input cken;
   input rxe_ev;
   input rxe_od;
   input iic_ack_timing;
   input din;
   input nfen;      // Noisefilter Enable
   input ch1_error; 
   input sis;
   
//   input csi_fast;  // for Bypath
   output dout;
   
   reg   ff1, ff2, ff3;

   always@(posedge pclk or negedge presetz)
     if (~presetz)
       begin
         ff1 <= 1'b0;
         ff2 <= 1'b0;
         ff3 <= 1'b0;
       end
     else if (ch1_error|(cken&(rxe_od|rxe_ev|iic_ack_timing)))
       begin
         ff1 <= ch1_error ? ~sis : din;
         ff2 <= ch1_error ? ~sis : ff1;
         ff3 <= ch1_error ? ~sis : ff1==ff2 ? ff2 : ff3;
       end

   wire dout;
   assign dout =  nfen ? ff3 : ff1 ;
   
endmodule

module  QLK0RSAU04R2V1_SNF2 (pclk, presetz, cken, rxe_ev, rxe_od, iic_ack_timing, din, dout, nfen);
   input pclk;
   input presetz;
   input cken;
   input rxe_ev;
   input rxe_od;
   input iic_ack_timing;
   input din;
   input nfen;      // Noisefilter Enable
//   input csi_fast;  // for Bypath
   output dout;
   
   reg   ff1, ff2, ff3;

   always@(posedge pclk or negedge presetz)
     if (~presetz)
       begin
         ff1 <= 1'b0;
         ff2 <= 1'b0;
         ff3 <= 1'b0;
       end
     else if (cken&(rxe_od|rxe_ev|iic_ack_timing))
       begin
         ff1 <= din;
         ff2 <= ff1;
         ff3 <= ff1==ff2 ? ff2 : ff3;
       end

   wire dout;
   assign dout =  nfen ? ff3 : ff1 ;
   
endmodule


module  QLK0RSAU04R2V1_SYNC (pclk, presetz, cken, rxe, iic_ack_timing, din, dout);
   input pclk;
   input presetz;
   input cken;
   input din;
   input rxe;
   input iic_ack_timing;
//   input csi_fast;  // for Bypath
   output dout;
   
   reg   ff1;

   always@(posedge pclk or negedge presetz)
     if (~presetz)
         ff1 <= 1'b0;
     else if (cken&(rxe|iic_ack_timing))
         ff1 <= din;

   wire dout;
   assign dout = ff1;
   
endmodule
// This module generate common gating signal
//    int_all -> logical or of each INT
//    st_all  -> logical or of each count_start_trg
//    se_all  -> logical or of each ch SE
//    stss_all -> logical or of sel_ss and sel_st
//    ge_seri  -> logical or of md4 bit

module QLK0RSAU04R2V1_GECTL ( 
                       sel_ss, sel_st, stss_all );
   

input   sel_ss;
input   sel_st;

output  stss_all;

wire stss_all = sel_ss | sel_st;


endmodule
module QLK0RSAU04R2V1_EDGECK_B0 (
                     peclk, peresetz,
                     mck, scki,
                     ccs2,
                     scki_rise, scki_fall, scki_both
                     );

input peclk;
input peresetz;
input mck;
input scki;
input ccs2;
output scki_rise;
output scki_fall;
output scki_both;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
reg scki_cap;
reg scki_sync;
   
wire scki_rise, scki_fall;
wire scki_both;

//=======================//
//  SCKI Latch           //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        scki_sync <= 1'b0;
  else if (mck & ccs2) scki_sync <= scki;
end 
  
//=======================//
//  SCKI Latch           //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)          scki_cap <= 1'b0;
  else if (mck&ccs2)      scki_cap <= scki_sync;
end

// Rise
assign scki_rise = scki_sync & ~scki_cap & mck;
// Fall
assign scki_fall = ~scki_sync & scki_cap & mck;
// Rise and Fall
assign scki_both = (scki_sync ^ scki_cap) & mck;

endmodule

module QLK0RSAU04R2V1_EDGECK_B1 (
                     peclk, peresetz,
                     mck, scki,
                     ccs2,
                     scki_rise, scki_fall, scki_both
                     );

input peclk;
input peresetz;
input mck;
input scki;
input ccs2;
output scki_rise;
output scki_fall;
output scki_both;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
reg scki_cap;
reg scki_sync;
   
wire scki_rise, scki_fall;
wire scki_both;

//=======================//
//  SCKI Latch           //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        scki_sync <= 1'b0;
  else if (mck & ccs2) scki_sync <= scki;
end 
  
//=======================//
//  SCKI Latch           //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)          scki_cap <= 1'b0;
  else if (mck&ccs2)      scki_cap <= scki_sync;
end

// Rise
assign scki_rise = scki_sync & ~scki_cap & mck;
// Fall
assign scki_fall = ~scki_sync & scki_cap & mck;
// Rise and Fall
assign scki_both = (scki_sync ^ scki_cap) & mck;

endmodule

module QLK0RSAU04R2V1_EDGECK_C0 (
                     peclk, peresetz,
                     mck, scki,
                     ccs2, async_csi,
                     scki_rise, scki_fall, scki_both
                     );

input peclk;
input peresetz;
input mck;
input scki;
input ccs2;
input async_csi;
output scki_rise;
output scki_fall;
output scki_both;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
reg scki_cap;
reg scki_sync;
   
wire scki_rise, scki_fall;
wire scki_both;

//=======================//
//  SCKI Latch           //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        scki_sync <= 1'b0;
  else if (mck & ccs2) scki_sync <= scki;
end 
  
//=======================//
//  SCKI Latch           //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)          scki_cap <= 1'b0;
  else if (mck&ccs2)      scki_cap <= scki_sync;
end

// Rise
assign scki_rise = scki_sync & ~scki_cap & mck & ~async_csi;
// Fall
assign scki_fall = ~scki_sync & scki_cap & mck & ~async_csi;
// Rise and Fall
assign scki_both = (scki_sync ^ scki_cap) & mck & ~async_csi;

endmodule

module QLK0RSAU04R2V1_EDGECK_C1 (
                     peclk, peresetz,
                     mck, scki,
                     ccs2,
                     scki_rise, scki_fall, scki_both
                     );

input peclk;
input peresetz;
input mck;
input scki;
input ccs2;
output scki_rise;
output scki_fall;
output scki_both;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
reg scki_cap;
reg scki_sync;
   
wire scki_rise, scki_fall;
wire scki_both;

//=======================//
//  SCKI Latch           //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        scki_sync <= 1'b0;
  else if (mck & ccs2) scki_sync <= scki;
end 
  
//=======================//
//  SCKI Latch           //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)          scki_cap <= 1'b0;
  else if (mck&ccs2)      scki_cap <= scki_sync;
end

// Rise
assign scki_rise = scki_sync & ~scki_cap & mck;
// Fall
assign scki_fall = ~scki_sync & scki_cap & mck;
// Rise and Fall
assign scki_both = (scki_sync ^ scki_cap) & mck;

endmodule

module QLK0RSAU04R2V1_EDGEU_B0 (
                     peclk, peresetz,
                     mck,
                     sin,
//                     sin_rise, sin_fall,
                     sin_level, sin_latch
                     );

//=========================//
//  Interface Definition   //
//=========================//
input peclk;
input peresetz;
input mck;
input sin;
//input sis;
//output sin_rise;
//output sin_fall;
output sin_level;
output sin_latch;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
reg sin_cap;
wire sin_latch;

//=======================//
//  SIN Latch            //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     sin_cap <= 1'b0;
  else if (mck)      sin_cap <= sin;
end

// Rise
//assign sin_rise = sin & ~sin_cap & mck;

// Fall
//assign sin_fall = ~sin & sin_cap & mck;

// Level
//assign sin_level = sis ? ~sin : sin;
assign sin_level = sin;

// Latch
//assign sin_latch = sis ? ~sin_cap : sin_cap;
assign sin_latch = sin_cap;

endmodule
module QLK0RSAU04R2V1_EDGEU_B1 (
                     peclk, peresetz,
                     mck,
                     sin, sis,
                     sin_rise, sin_fall,
                     sin_level, sin_latch
                     );

//=========================//
//  Interface Definition   //
//=========================//
input peclk;
input peresetz;
input mck;
input sin;
input sis;
output sin_rise;
output sin_fall;
output sin_level;
output sin_latch;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
reg sin_cap;
wire sin_fall;
wire sin_latch;

//=======================//
//  SIN Latch            //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     sin_cap <= 1'b0;
  else if (mck)      sin_cap <= sin;
end

// Rise
assign sin_rise = sin & ~sin_cap & mck;
// Fall
assign sin_fall = ~sin & sin_cap & mck;

// Level
assign sin_level = sis ? ~sin : sin;

// Latch
assign sin_latch = sis ? ~sin_cap : sin_cap;

endmodule
module QLK0RSAU04R2V1_EDGEU_C0 (
                     peclk, peresetz,
                     mck,
                     sin, 
//                     sin_rise, sin_fall,
                     sin_level, sin_latch
                     );

//=========================//
//  Interface Definition   //
//=========================//
input peclk;
input peresetz;
input mck;
input sin;
//input sis;
//output sin_rise;
//output sin_fall;
output sin_level;
output sin_latch;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
reg sin_cap;
wire sin_latch;

//=======================//
//  SIN Latch            //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     sin_cap <= 1'b0;
  else if (mck)      sin_cap <= sin;
end

// Rise
//assign sin_rise = sin & ~sin_cap & mck;
// Fall
//assign sin_fall = ~sin & sin_cap & mck;

// Level
//assign sin_level = sis ? ~sin : sin;
assign sin_level = sin;

// Latch
//assign sin_latch = sis ? ~sin_cap : sin_cap;
assign sin_latch = sin_cap;

endmodule
module QLK0RSAU04R2V1_EDGEU_C1 (
                     peclk, peresetz,
                     mck,
                     sin, sis,
                     sin_rise, sin_fall,
                     sin_level, sin_latch,
                     brate_adj, bcnt_restart
                     );

//=========================//
//  Interface Definition   //
//=========================//
input peclk;
input peresetz;
input mck;
input sin;
input sis;
input brate_adj;
output sin_rise;
output sin_fall;
output sin_level;
output sin_latch;
output bcnt_restart;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
reg sin_cap;
wire sin_fall;
wire sin_latch;

//=======================//
//  SIN Latch            //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     sin_cap <= 1'b0;
  else if (mck)      sin_cap <= sin;
end

// Rise
assign sin_rise = sin & ~sin_cap & mck;
// Fall
assign sin_fall = ~sin & sin_cap & mck;

// Level
assign sin_level = sis ? ~sin : sin;

// Latch
assign sin_latch = sis ? ~sin_cap : sin_cap;

// UART baud rate counter adjustment signal
wire bcnt_restart = brate_adj & ( (~sis & sin_rise) | (sis & sin_fall) );

endmodule

module QLK0RSAU04R2V1_FUNC_B0 (
                    // INPUT
                    peclk, pclkrw, peresetz,
                    mck,
                    we_ulhw, sel_sdr, sel_sir, re_sdr, peri_write,
                    se, md0,
                    dap, ckp,
                    count_start_trg, 
                    count_clock, b_count_clock,
                    md_csi, md_uart, md_iic,
                    eoc,
                    dls, slc, dir, rxe, txe,
                    pstate_on, pcheck_on, odd_parity,
                    no_stopbit, ccs2,
                    data_7bit, data_8bit,
                    sin_level, st_trg, start_slave,
                    sin_latch, 
                    // OUTPUT
                    spr,sdr_read,
                    baud_borrow, csi_slave_stop,
                    int_sig, eint,
                    seri_fin_out,
                    pef,fef,bff,ovf,tsf,
                    seri_dout_timing, seri_dout,
                    sck_timing, sck_data,
                    fast_mode, sin_direct, ack_timing
                    
                   );

input peclk;
input pclkrw;
input peresetz;

input mck;

input we_ulhw;
input sel_sdr;
input sel_sir;
input re_sdr;
input [15:0] peri_write;

input se;
input md0;
input count_start_trg;
input count_clock;
input b_count_clock;

input md_csi;
input md_uart;
input md_iic;
input eoc;
input dap;
input ckp;
input [1:0] dls;
input [1:0] slc;
input dir;
input rxe;
input txe;
input pstate_on;
input pcheck_on;
input odd_parity;
input no_stopbit;
input ccs2;

input data_7bit;
input data_8bit;
input sin_level;
input sin_latch;
input sin_direct;
input st_trg;
input start_slave;

output [15:0] spr;
output [15:0] sdr_read;
output baud_borrow;
output csi_slave_stop;
output int_sig;
output eint;
output pef;
output fef;
output bff;
output ovf;
output tsf;
output seri_dout_timing;
output seri_dout;
output seri_fin_out;
output sck_timing;
output sck_data;
output fast_mode;
output ack_timing;

// Counter
wire [15:0] spr;
wire baud_borrow;
wire recv_data;
wire [15:0] sdr;
wire [15:0] sdr_read;
wire we_sdr;
wire ld_spr_to_sdr;
wire load_next_s_data;
wire csi_slave_ld_mask;
wire d_shift;

// Overflow
wire borrow_register;
wire bff;

// FSM
wire C_IDLE;
wire C_START;
wire C_SEND;
wire C_PARITY;
wire C_STOP;
wire N_START;
wire N_SEND;
wire N_PARITY;
wire N_STOP;

wire seq_start; // Seq_start is working on except of UART & rxe
wire trans_next_state; // This is state transfer timing on transmission
wire state_trans; // This is current_state gating signal
wire s_trans;
wire sck_toggle; // This is data shift/capture timing signal
wire last_state; // This is the status of Last state on 1 data
wire fin_timing;
wire sdr_load;
wire seri_fin;
wire seri_fin_out;
//wire uart_stop;

// Sout
wire seri_dout_timing; // serial SOUT change timing
wire seri_dout; // serial SOUT next data
wire send_data_out;

// Scko
wire sck_timing;   // sck toggle timing;
wire sck_data;     // sck data

// Int
wire int_sig;

// Flag
wire ovf;
wire pef;
wire ack_timing;
wire parity_out;
wire fef = 1'b0;
wire tsf;
wire sdr_load_timing;
wire set_ovf, set_pef, clr_ovf, clr_pef;

// I/O control
// wire data_out;	// not drive anything  by yama

// Common Signal
//assign uart_recv = md_uart & rxe;
//assign seri_fin_out = seri_fin | uart_stop;
assign seri_fin_out = seri_fin;

// SIN Signal Selector
wire csi_slave_mode = md_csi & ccs2;

reg sin_sel;
//always@(sin_latch or sin_level or md_uart or csi_slave_mode)
//  case ( md_uart|csi_slave_mode )
//    1'b1    : sin_sel = sin_latch;
//    default : sin_sel = sin_level;
//  endcase
always@(sin_latch or sin_level or csi_slave_mode)
  case ( csi_slave_mode )
    1'b1    : sin_sel = sin_latch;
    default : sin_sel = sin_level;
  endcase
  
assign load_next_s_data = sdr_load & txe; // <- SEQ transfer load next SDR data
assign sdr_load_timing = fin_timing & rxe;
assign ld_spr_to_sdr = sdr_load_timing & ~st_trg ;
assign recv_data = ~rxe | sin_sel;
assign we_sdr = we_ulhw & sel_sdr;

//++++====++++====++++====  COUNTER   ====++++====++++====++++====//
QLK0RSAU04R2V1_CNT_B0 cnt (.peclk(peclk), .peresetz(peresetz),
                     .data_8bit(data_8bit), .data_7bit(data_7bit),
                     .recv_data(recv_data), .dir(dir),
                     .csi_slave_ld_mask(csi_slave_ld_mask),
                     .count_start_trg(count_start_trg), .load_next_s_data(load_next_s_data),
                     .se(se), .d_shift(d_shift), .b_count_clock(b_count_clock),
                     .sdr(sdr), .spr(spr), .baud_borrow(baud_borrow),
                     .sin_direct(sin_direct), .fast_mode(fast_mode), .rxe(rxe) );

//++++====++++====++++====  DATA_REG   ====++++====++++====++++====//
QLK0RSAU04R2V1_DREG_B0 dreg ( .peclk(peclk), .pclkrw(pclkrw), .peresetz(peresetz),
                        .we_sdr(we_sdr), 
                        .se(se), .ccs2(ccs2),
                        .ld_spr_to_sdr(ld_spr_to_sdr), .peri_write(peri_write),
                        .spr(spr), .sdr(sdr), .sdr_read(sdr_read), .fast_mode(fast_mode)
                        );

//++++====++++====++++====   FSM    ++====++++====++++====++++====//
QLK0RSAU04R2V1_STATECTL_B0 statectl(
                              .peclk(peclk), .peresetz(peresetz), 
                              .count_start_trg(count_start_trg), .st_trg(st_trg), .count_clock(count_clock),
                              .md_csi(md_csi), .md_uart(md_uart), 
                              .txe(txe), .rxe(rxe),
                              .pstate_on(pstate_on), .no_stopbit(no_stopbit),
                              .dls(dls), .slc(slc), .ccs2(ccs2), .dap(dap), .fast_mode(fast_mode),
                              .we_sdr(we_sdr), .tsf(tsf), .start_slave(start_slave),
                              .csi_slave_mode(csi_slave_mode),
                              .C_IDLE(C_IDLE), .C_START(C_START), .C_SEND(C_SEND), .C_PARITY(C_PARITY), .C_STOP(C_STOP),
                              .N_START(N_START), .N_SEND(N_SEND), .N_PARITY(N_PARITY), .N_STOP(N_STOP),
                              .d_shift(d_shift), .state_trans(state_trans), .s_trans(s_trans),
                              .sck_toggle(sck_toggle),
                              .trans_next_state(trans_next_state), .last_state(last_state),
                              .fin_timing(fin_timing), .sdr_load(sdr_load),
                              .seri_fin(seri_fin), .seq_start(seq_start), .ack_timing(ack_timing),
                              .csi_slave_stop(csi_slave_stop),
                              .csi_slave_ld_mask(csi_slave_ld_mask) );

//++++====++++====++++==== SOUT_SRC ++====++++====++++====++++====++//
//++++====++++====++++==== SCKO_SRC ++====++++====++++====++++====+//
QLK0RSAU04R2V1_OUTCTL_B0 outctl(
                           .count_start_trg(count_start_trg), .st_trg(st_trg), .s_trans(s_trans), .fin_timing(fin_timing),
                           .last_state(last_state), .seq_start(seq_start),
                           .N_START(N_START), .N_SEND(N_SEND), .N_PARITY(N_PARITY), .N_STOP(N_STOP),
                           .C_IDLE(C_IDLE), .C_STOP(C_STOP),
                           .trans_next_state(trans_next_state),
                           .sdr(sdr), .count_register(spr),
                           .data_8bit(data_8bit),
                           .dir(dir), .txe(txe),
                           .md_iic(md_iic), .md_uart(md_uart),
                           .count_clock(count_clock), .sck_toggle(sck_toggle),
                           .parity_out(parity_out), .dap(dap), .ckp(ckp), .ccs2(ccs2), .csi_slave_mode(csi_slave_mode),
                           .seri_dout_timing(seri_dout_timing), .seri_dout(seri_dout),
                           .sck_timing(sck_timing), .sck_data(sck_data),
                           .send_data_out(send_data_out) );

//++++====++++====++++====   INT    ++====++++====++++====++++====//
QLK0RSAU04R2V1_INT_B0 intctl(
                         .peclk(peclk), .peresetz(peresetz),
                         .count_start_trg(count_start_trg),
                         .md0(md0), .dap(dap), .csi_slave_mode(csi_slave_mode),
                         .last_state(last_state), .seq_start(seq_start), .state_trans(state_trans),
                         .st_trg(st_trg),
                         .eoc(eoc), .ovf(ovf), .pef(pef),
                         .set_ovf(set_ovf), .set_pef(set_pef),
                         .clr_ovf(clr_ovf), .clr_pef(clr_pef),
                         .se(se), 
                         .int_sig(int_sig), .eint(eint) );


//++++====++++====++++====   EINT    ++====++++====++++====++++====//
//QLK0RSAU04R2V1_EINT_B0 seintctl(
//                         .peclk(peclk), .peresetz(peresetz),
//                         .set_ovf(set_ovf), .set_pef(set_pef),
//                         .eoc(eoc), .eint(eint) );

//++++====++++====++++====   FLAG   ++====++++====++++====++++====//
QLK0RSAU04R2V1_FLAG_B0 flag (
                       .peclk(peclk), .peresetz(peresetz), .mck(mck),
                       .peri_write(peri_write[2:0]), .sel_sir(sel_sir), .we_ulhw(we_ulhw), .we_sdr(we_sdr),
                       .se(se), .count_clock(count_clock), .st_trg(st_trg),
                       .count_start_trg(count_start_trg), .ccs2(ccs2), .dap(dap),
                       .sdr_load_timing(sdr_load_timing), .re_sdr(re_sdr),
                       .seq_start(seq_start),
                       .d_shift(d_shift), .ack_timing(ack_timing), .state_trans(state_trans),
                       .md_iic(md_iic),
                       .csi_slave_mode(csi_slave_mode), .seri_fin(seri_fin),
                       .pcheck_on(pcheck_on), .odd_parity(odd_parity),
                       .txe(txe), .rxe(rxe), .sin_sel(sin_sel), .send_data_out(send_data_out),
                       .fin_timing(fin_timing),
                       .ovf(ovf), .parity_out(parity_out), .pef(pef),
                       .tsf(tsf), .bff(bff),
                       .set_ovf(set_ovf), .set_pef(set_pef),
                       .clr_ovf(clr_ovf), .clr_pef(clr_pef),
                       .borrow_register(borrow_register)
                        );

//++++====++++====++++====+ I/O  CNT +====++++====++++====++++====+//
// assign data_out = txe ; 		// not drive anything : by yama

endmodule

// This is Counter(SPR) module
module QLK0RSAU04R2V1_CNT_B0 ( peclk, peresetz,
                        data_8bit, data_7bit,
                        recv_data,
                        dir,
                        csi_slave_ld_mask,
                        count_start_trg, load_next_s_data,
                        se, d_shift, b_count_clock,
                        sdr, spr, baud_borrow,
                        sin_direct, fast_mode, rxe );
input peclk;
input peresetz;

input data_8bit;
input data_7bit;
input recv_data;
input dir;
input csi_slave_ld_mask;
input count_start_trg;
input load_next_s_data;
input se;
input d_shift;
input b_count_clock;
input [15:0] sdr;
input sin_direct;
input fast_mode;
input rxe;

output [15:0] spr;
output baud_borrow;


//wire shift9_lsb;
wire shift8_lsb;
wire shift7_lsb;
wire shift6_lsb;
wire shift5_lsb;
//wire shift9_msb;
wire shift8_msb;
wire shift7_msb;
wire shift6_msb;

wire [15:0] shift_data;
wire [15:9] next_value;
reg [15:0] load_data;
wire borrow2;
wire baud_borrow;
reg [15:0] count_register;
wire load_trg_lb;
wire load_trg_ub;
wire ge_count_register_0;
wire ge_count_register_1;
wire ge_count_register_2;
wire ge_count_register_3;


// Shift/Capture function  all shift condition
wire recv_data_sel = fast_mode & rxe ? sin_direct : recv_data;

assign shift8_lsb = (data_8bit & recv_data_sel);
assign shift7_lsb = (~data_7bit & count_register[7]) | (data_7bit & recv_data_sel);
assign shift6_lsb = count_register[6];
assign shift5_lsb =  count_register[5];
assign shift8_msb = ~data_7bit & count_register[6];
assign shift7_msb =  count_register[5];
assign shift6_msb =  count_register[4];

// Generate bit8-0 shift data
//assign shift_data[8:0] = dir ? {shift9_lsb, shift8_lsb, shift7_lsb, shift6_lsb, shift5_lsb, count_register[4:1]}  // LSB first
//                             : {shift9_msb, shift8_msb, shift7_msb, shift6_msb, count_register[3:0], recv_data};  // MSB first
assign shift_data[7:0] = dir ? {shift8_lsb, shift7_lsb, shift6_lsb, shift5_lsb, count_register[4:1]}  // LSB first
                             : {shift8_msb, shift7_msb, shift6_msb, count_register[3:0], recv_data_sel};  // MSB first

   
// Generate bit15-9 shift data
//assign shift_data[15:9] = dir ? {recv_data, count_register[15:10]}  // LSB first
//                              : count_register[14:8];               // MSB first
assign shift_data[15:8] = 8'h00;
   
   
// Borrow signal (bit separated)
wire tmp_borrow2 ;

QLK0RSAU04R2V1_DEC3_B0 dec3_1 (.borrow(tmp_borrow2), .out1(next_value[11:9]),  .in1(count_register[11:9]) );
QLK0RSAU04R2V1_DEC4_B0 dec4_2 (.out1(next_value[15:12]), .in1(count_register[15:12]));

assign borrow2 = tmp_borrow2 ;                     // This is borrow signal count_register[11:9]-1

// Borrow Signal (Baud-Rate Counter), This is used for Timer and Serial
assign baud_borrow = (count_register[15:9]==7'h00);

// SPR Register value inverted on capture mode
assign spr        = {count_register[15:9],1'b0,count_register[7:0]} ;

// Load SDR/FFFFH trigger for SPR[8:0]
assign load_trg_lb  = ((count_start_trg & ~csi_slave_ld_mask)    // <- This is Serial/Timer Start Condition
                                                                 //    csi_slave_ld_mask is refered to STATECTL
                       | load_next_s_data) & se;                 // <- This is Serial Seq-Send Condition

// Load SDR/FFFFH trigger for SPR[15:9]
assign load_trg_ub  = ((count_start_trg & ~csi_slave_ld_mask)     // This is Serial/Timer Start Condition
                       | (baud_borrow & b_count_clock)            // This is Serial baud-rate Conter=00H Condition;
//                       | (~baud_count_en & load_next_s_data)) & se;   // <- This is Serial Se-Send Condition
                       ) & se;   // <- This is Serial Se-Send Condition


// Load data selector // Remove Bit9
always@(load_trg_lb or sdr or shift_data) begin
  case ({load_trg_lb}) // synopsys parallel_case
    1'b0:  load_data[7:0] = shift_data[7:0];  // load shift/recv for serial mode
    default: load_data[7:0] = sdr[7:0];         // load sdr[8:0] for non capture mode
  endcase
end

//wire shift16 = d_shift & data_16bit;

// Remove data_16bit
always@(load_trg_ub or sdr or shift_data or next_value) begin
  case ({load_trg_ub}) // synopsys parallel_case
    1'b1:  load_data[15:9] = sdr[15:9];         // load sdr[8:0] for non capture mode
    default: load_data[15:9] = next_value[15:9];  // load decrement value
  endcase
end

assign ge_count_register_0 = d_shift | load_trg_lb ;                     // Gating for bit[4:0]
assign ge_count_register_1 = d_shift | load_trg_lb ;                     // Gating for bit[8:5]
assign ge_count_register_2 = load_trg_ub | b_count_clock;                // Gating for bit[11:9]
assign ge_count_register_3 = load_trg_ub | (borrow2 & b_count_clock);    // Gating for bit[15:12]

// Counter/ShiftRegister
always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[3:0] <= 4'hf ;
    else if (ge_count_register_0)  count_register[3:0] <= load_data[3:0];
end

always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[7:4] <= 4'hf ;
    else if (ge_count_register_1)  count_register[7:4] <= load_data[7:4];
end

always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[11:9] <= 3'h7 ;
    else if (ge_count_register_2)  count_register[11:9] <= load_data[11:9];
end

always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[15:12] <= 4'hf ;
    else if (ge_count_register_3)  count_register[15:12] <= load_data[15:12];
end

endmodule

// 4bit Decrement Module
module QLK0RSAU04R2V1_DEC4_B0 (out1, in1);
  output [3:0] out1;
  input  [3:0] in1;

  wire [3:0] out1;
  wire [2:0] tmp_borrow;

  assign out1[0] = tmp_borrow[0] ;
  assign tmp_borrow[0] = ~in1[0] ;

  assign out1[1] = in1[1] ^ tmp_borrow[0];
  assign tmp_borrow[1] = ~in1[1] & tmp_borrow[0];

  assign out1[2] = in1[2] ^ tmp_borrow[1];
  assign tmp_borrow[2] = ~in1[2] & tmp_borrow[1];

  assign out1[3] = in1[3] ^ tmp_borrow[2];

endmodule

// 3bit Decrement Module
module QLK0RSAU04R2V1_DEC3_B0 (borrow, out1, in1);
  output borrow;
  output [2:0] out1;
  input  [2:0] in1;

  wire borrow;
  wire [2:0] out1;
  wire [1:0] tmp_borrow;

  assign out1[0] = tmp_borrow[0] ;
  assign tmp_borrow[0] = ~in1[0] ;

  assign out1[1] = in1[1] ^ tmp_borrow[0];
  assign tmp_borrow[1] = ~in1[1] & tmp_borrow[0];

  assign out1[2] = in1[2] ^ tmp_borrow[1];
  assign borrow = ~in1[2] & tmp_borrow[1];

endmodule

// Data Register (SDR)
module QLK0RSAU04R2V1_DREG_B0(
                         peclk, pclkrw, peresetz,
                         we_sdr, ccs2,
                         se,
                         ld_spr_to_sdr, peri_write,
                         spr, sdr, sdr_read, fast_mode
                         );

input peclk;
input pclkrw;
input peresetz;
input we_sdr;
input ccs2;
input se;
input ld_spr_to_sdr;
input [15:0] peri_write;
input [15:0] spr;

output [15:0] sdr;
output [15:0] sdr_read;
output     fast_mode;
   
wire apb_wr_en;
wire mask_sdr_h;
wire ge_sdr;
//reg [15:0] sdr_data;
//reg [15:0] sdr;
//reg [6:0] sdr_data_h;
reg [7:0] sdr_data_l;
reg [6:0] sdr_h;
reg [7:0] sdr_l;
   
wire [15:0] sdr_read;
wire [15:0] sdr = {sdr_h, 1'b0, sdr_l};
   
// SDR Write Signal (masked by capture mode)
assign apb_wr_en = we_sdr;
// APB Write Mask signal for baud-rate counter(SDR[15:9])
assign mask_sdr_h = se ;  // & baud_count_en;
// SDR gating signal (APB write, capture trigger, Serial Receive)
assign ge_sdr = apb_wr_en | ld_spr_to_sdr ;

// SDR Write data for SDR[8:0] // Remove SDR[8] R2
//always@(apb_wr_en or peri_write or spr) begin
//  if (apb_wr_en) sdr_data[8:0] = peri_write[8:0];  // APB write
//  else           sdr_data[8:0] = spr[8:0];         // Capture and Serial Receive
//end
always@(apb_wr_en or peri_write or spr) begin
  if (apb_wr_en) sdr_data_l[7:0] = peri_write[7:0];  // APB write
  else           sdr_data_l[7:0] = spr[7:0];         // Capture and Serial Receive
end
   

// SDR[15:9]
always @(posedge pclkrw or negedge peresetz) begin
    if (~peresetz)          sdr_h <= 7'h00;
    else if (~se&apb_wr_en) sdr_h <= peri_write[15:9];
end
   
// SDR[7:0]
always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)    sdr_l <= 8'h00;
    else if (ge_sdr)  sdr_l <= sdr_data_l;
end


// This is SDR read-out value
assign sdr_read[15:9] = mask_sdr_h ? 7'h00 : sdr_h; // Baud-rate doesn't read out while SE=1
assign sdr_read[8:0] = {1'b0,sdr_l};

wire fast_mode = (sdr_h == 7'h00)&~ccs2;
   
   
endmodule

// FSM Controller
module QLK0RSAU04R2V1_STATECTL_B0 (
                              peclk, peresetz,
                              count_start_trg, st_trg, count_clock,
                              md_csi, md_uart,
                              txe, rxe,
                              pstate_on, no_stopbit,
                              dls, slc, ccs2, dap, fast_mode,
                              we_sdr, tsf, start_slave, csi_slave_mode,
                              C_IDLE, C_START, C_SEND, C_PARITY, C_STOP,
                              N_START, N_SEND, N_PARITY, N_STOP,
                              d_shift, state_trans, s_trans,
                              sck_toggle,
                              trans_next_state, last_state,
                              fin_timing, sdr_load,
                              seri_fin, seq_start, ack_timing,
                              csi_slave_stop, csi_slave_ld_mask
                               );

input  peclk;
input  peresetz;
input  count_start_trg;
input  st_trg;
input  count_clock;
input  md_uart;
input  md_csi;
//input  uart_recv;
input  txe;
input  rxe;
input  pstate_on;
input  no_stopbit;
input [1:0] dls;
input [1:0] slc;
input  ccs2;
input  dap;
input  we_sdr;
input  tsf;
input  start_slave;
input  csi_slave_mode;
input fast_mode;
   
output C_IDLE;
output C_START;
output C_SEND;
output C_PARITY;
output C_STOP;
output N_START;
output N_SEND;
output N_PARITY;
output N_STOP;
output d_shift;
output sck_toggle;
output state_trans;
output s_trans;
output trans_next_state;
output last_state;
output fin_timing;
output sdr_load;
output seri_fin;
output seq_start;
output ack_timing;
output csi_slave_stop;
output csi_slave_ld_mask;
//output uart_stop;

// State definition
parameter IDLE   = 3'b000;
parameter START  = 3'b111;
parameter SEND   = 3'b101;
parameter PARITY = 3'b010;
parameter STOP   = 3'b110;

wire C_IDLE;
wire C_START;
wire C_SEND;
wire C_PARITY;
wire C_STOP;
wire N_START;
wire N_SEND;
wire N_PARITY;
wire N_STOP;
//wire uart_stop;
wire state_trans;
wire d_shift;
wire d_shift_normal;
reg  d_shift_delay;

wire last_state;
wire fin_timing;
wire sdr_load;
wire seri_fin;
reg trans_next_state;
reg [2:0] current_state;
reg [2:0] next_state;
wire st_counter_end;
wire [2:0] data_length;
reg  [2:0] stop_length;
wire dl_set;
wire [2:0] st_load_val;
wire load_stcnt;
wire run_stcnt;
wire [2:0] next_value;
reg [2:0] next_st_counter;
reg [2:0] st_counter;
wire ge_st_counter;
wire ge_seq_start;
reg seq_start;
wire ge_trans_next;
wire csi_slave_stop;
wire ge_dshift;
wire trans_next_data;
wire d_shift_data;
wire trans_next_set; 
wire d_shift_clr;
wire seq_start_clr;
wire seq_start_data;


// State Decode
assign C_IDLE   = (current_state != START) & (current_state != SEND) & (current_state != PARITY) & (current_state != STOP);
assign C_START  = (current_state == START);
assign C_SEND   = (current_state == SEND);
assign C_PARITY = (current_state == PARITY);
assign C_STOP   = (current_state == STOP);
assign N_START  = (next_state == START);
assign N_SEND   = (next_state == SEND);
assign N_PARITY = (next_state == PARITY);
assign N_STOP   = (next_state == STOP);

// Make common gating signal for seq_start, d_shift_delay, trans_next_state
wire ge_common = ge_trans_next | ge_dshift | ge_seq_start;
QLK0RSAU04R2V1_STATDSEL_B0 statdsel(
    .trans_next_data(trans_next_data), .ge_trans_next(ge_trans_next), .trans_next_set(trans_next_set),
    .trans_next_state(trans_next_state),
    .d_shift_data(d_shift_data), .ge_dshift(ge_dshift), .d_shift_clr(d_shift_clr), .d_shift_delay(d_shift_delay),
    .seq_start_data(seq_start_data), .ge_seq_start(ge_seq_start), .seq_start_clr(seq_start_clr),
    .seq_start(seq_start));

// CSI Slave mode(dap=1) signal
wire   csi_slave_dap1 = csi_slave_mode & dap;

// This is load_trg(SDR->SPR) mask signal (dap=1)
//  SCKI      ~~~~~~~~~~~~~~|________|~~~~~~~~~|______
//                   ________________ ________________
//  SIN       XXXXXXX________________X________________
//                          O
//          This is 1st clock edge of CSI Slave.
//          So load_trg(count_start_trg) is triggered, but in this transmission format,
//           SAU capture 1st receive bit.
wire   csi_slave_ld_mask = (csi_slave_dap1 & ~txe & rxe)   // mask start load_trig by csi slave dap=1
                           | (csi_slave_mode & txe & seq_start); // mask seq-start load_trg by csi slave
                           //| (uart_recv & tsf);            // mask load_trig by falling SIN (avoiding over-write SPR)

// This is CSI slave start signal at 1st SCKI edge in the case of no writing send data.
wire   csi_slave_dap1_start = csi_slave_dap1 & ~tsf & start_slave;

// This is CSI slave stop process at dap=0 
//      SCKI   ________|~~~~~~~~~~~~~~~~~~~~~
// state_trans ________|~~~~|________________
//                        ^^^ Generate this timing
//             __________ __ ________________
//      state  ____S_____XS_X___I____________
assign csi_slave_stop = csi_slave_mode & ~dap & last_state & trans_next_state;

// This is gating signal for trans_next_state register
//assign ge_trans_next = (count_start_trg | count_clock | csi_slave_stop | st_trg) & se;

// This is State transfer, Data Shift control register
//      brate        ______|~|_____|~|_____|~|_____|~|_____|~|_____|~|_____|~|_____
//  trans_next_state ________|~~~~~~~|_______|~~~~~~~|_______|~~~~~~~|_______|~~~~~
//                           O       X       O       X       O       X       O
//                      O:Data Shift/Capture Timing
//                      X:State Transfer Timing

//wire trans_next_data;
assign trans_next_set = (~state_trans | csi_slave_dap1_start) & ~st_trg ;
//assign ge_trans_next = (count_start_trg | count_clock | csi_slave_stop | st_trg) ;
assign ge_trans_next = (count_start_trg | count_clock | st_trg) ;
//assign  trans_next_data = ge_trans_next ? trans_next_set : trans_next_state;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)            trans_next_state <= 1'b0;
//   else if (ge_trans_next)   trans_next_state <= trans_next_set;
  else if (ge_common)       trans_next_state <= trans_next_data;
end

// 2 stop timing on UART receive function(Start by noise, Stop)
//    1.   SIN   ~~~~~~|______|~~~~~~~~~~~~~~~~~~~~
//      1/2Brate ______|_________|________|________
//               IDLE  X Start   X IDLE
//    2.1/2Brate ____|______|______|______|______
//                   X Parity      X Stop X Idle
//wire uart_stop_pre = uart_recv & ~trans_next_state & ((C_START & sin_sel) | (C_STOP & st_counter_end));
//assign uart_stop = uart_stop_pre & count_clock;

// source of state transition timing (Normal State transition)
//assign s_trans = (trans_next_state | uart_stop_pre) & count_clock;
assign s_trans = trans_next_state & count_clock;

// State transition signal
assign state_trans = count_start_trg | s_trans | st_trg ;

// Data Shift/Capture Timing
assign d_shift_normal = (~trans_next_state & C_SEND & count_clock) | csi_slave_dap1_start;

wire d_shift_set = d_shift_normal;
assign d_shift_clr = st_trg | d_shift_delay;
assign ge_dshift = d_shift_set | d_shift_clr;
//assign d_shift_data = ge_dshift ? ~d_shift_clr : d_shift_delay;
//wire d_shift_data;

always@(posedge peclk or negedge peresetz)
  if (~peresetz)      d_shift_delay <= 1'b0;
//   else if (ge_dshift) d_shift_delay <= ~d_shift_clr;
  else if (ge_common) d_shift_delay <= d_shift_data;


wire csi_master = ~ccs2 & md_csi & ~fast_mode;
assign d_shift = csi_master ? d_shift_delay : d_shift_normal;

// SCKO Toggle Timing
wire   sck_toggle = (~trans_next_state & count_clock) | csi_slave_dap1_start; // add for SCKO

// This is Serial Last State
assign last_state = (C_SEND & st_counter_end & ~pstate_on & no_stopbit) | // finish on SEND state
                    (C_PARITY & no_stopbit) |                             // finish on PARITY state
                    (C_STOP & st_counter_end) ;                           // finish on STOP state

// This is Serial Finish timing
assign fin_timing = last_state & state_trans;
// This is SDR->SPR load signal for Seq-send
assign sdr_load = fin_timing & seq_start;
// This is the end of serial
assign seri_fin = fin_timing & (~seq_start | (ccs2 & ~dap));

//===========================//
//   Next State combination  //
//===========================//
always@(count_start_trg or st_counter_end or st_trg or
        md_uart or pstate_on or no_stopbit or
        seq_start or ccs2 or dap or
        C_START or C_SEND or C_PARITY or C_STOP) begin
  next_state = IDLE;

  // Stop for write ST register
  if (st_trg)  begin
    next_state = IDLE;
  end
  else begin
    // Normal State Transition
    if (count_start_trg) begin
       if   (md_uart) next_state = START;   // IDLE -> START
       else           next_state = SEND;    // IDLE -> SEND
    end

    if (C_START) begin
      //if (uart_recv & sin_sel & ~trans_next_state)  next_state = IDLE;  // START -> IDLE
      //else                                          next_state = SEND;  // START -> SEND
      next_state = SEND;
    end

    if (C_SEND) begin
      if (st_counter_end) begin
        if (pstate_on)         next_state = PARITY; // SEND -> PARITY
        else if (~no_stopbit)  next_state = STOP;   // SEND -> STOP
        else if (seq_start & ~(ccs2 & ~dap)) begin
          //if (md_uart)         next_state = START;  // SEND -> START
          //else                 next_state = SEND;   // SEND -> SEND(next flame)
          next_state = SEND;
        end
        else                   next_state = IDLE;   // SEND -> IDLE
      end
      else                     next_state = SEND;   // SEND -> SEND(continue transfer)
    end

    if (C_PARITY) begin
      if (~no_stopbit)       next_state = STOP;    // PARITY -> STOP
      else if (seq_start & ~(ccs2 & ~dap)) begin
        //if (md_uart)         next_state = START;   // SEND -> START
        //else                 next_state = SEND;    // SEND -> SEND(next flame)
        next_state = SEND;
      end
      else                   next_state = IDLE;    // PARITY -> IDLE    
    end

    if (C_STOP) begin
      if (st_counter_end) begin
        if (seq_start & ~(ccs2 & ~dap)) begin
          if (md_uart)           next_state = START;  // STOP -> START
          else                   next_state = SEND;   // STOP -> SEND
        end
        else                     next_state = IDLE;   // STOP -> IDLE
      end
      else                       next_state = STOP;   // STOP -> STOP
    end
  end

end

// This is the FSM register
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        current_state <= IDLE;
  else if (state_trans) current_state <= next_state;
end

// Data length Counter/ Stop bit length Counter
assign st_counter_end = ~|st_counter;

// Data length Decoder
assign data_length = {1'b1,dls};

// Stop bit length Decoder
always@(slc) begin
  case (slc) //synopsys parallel_case
    2'b10 : stop_length = 3'b001;
    2'b11 : stop_length = 3'b010;
    default: stop_length = 3'b000;
  endcase
end


// Data Length Load Timing (IDLE->SEND, START->SEND, SEND->SEND, STOP->SEND, PARITY->SEND)
assign dl_set = N_SEND;

// This is the select signal of st_counter load value
assign st_load_val = dl_set ? data_length : stop_length;

                    // Data length load              Data/Stop length load
assign load_stcnt = (~C_SEND & N_SEND) | (C_SEND & st_counter_end);
assign run_stcnt = (C_SEND | C_STOP) & ~st_counter_end ;

// Decrementer(-1) of st_counter
//QLK0RSAU04R2V1_DEC4 dec4_1 (.out1(next_value),   .in1(st_counter) );
QLK0RSAU04R2V1_DEC3_2_B0 dec3_2 (.out1(next_value),   .in1(st_counter) );
   
// st_counter data selector
always@(load_stcnt or run_stcnt or st_load_val or next_value or st_counter) begin
  case(1'b1) //synopsys parallel_case
    load_stcnt: next_st_counter = st_load_val;     // load count data
    run_stcnt : next_st_counter = next_value[2:0]; // decrement(-1)
    default   : next_st_counter = st_counter;      // keep st_counter
  endcase
end

// Gating signal of st_counter
assign ge_st_counter = (load_stcnt | run_stcnt) & (s_trans | count_start_trg);

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)           st_counter <= 3'b000;
  else if (ge_st_counter)  st_counter <= next_st_counter;
end

// Sequencial start(except of CSI slave & UART receive)
wire seq_start_end = (ccs2 & ~dap) ? start_slave & ~tsf : fin_timing;

//wire seq_start_set = (~C_IDLE & we_sdr) & ~fin_timing & ~uart_recv ;
wire seq_start_set = (~C_IDLE & we_sdr) & ~fin_timing;
assign seq_start_clr = st_trg | seq_start_end;
assign ge_seq_start = seq_start_set | seq_start_clr;
//assign seq_start_data = ge_seq_start ? ~seq_start_clr : seq_start;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)          seq_start <= 1'b0;
//   else if (ge_seq_start)  seq_start <= ~seq_start_clr;
  else if (ge_common)     seq_start <= seq_start_data;
end

// This is ACK timing signal at IIC/SCIF
//assign ack_timing = (st_counter == stop_length) & C_STOP;
assign ack_timing = C_STOP;
endmodule


module QLK0RSAU04R2V1_DEC3_2_B0 (out1, in1);
  output [2:0] out1;
  input  [2:0] in1;

  wire [2:0] out1;
  wire [1:0] tmp_borrow;

  assign out1[0] = tmp_borrow[0] ;
  assign tmp_borrow[0] = ~in1[0] ;

  assign out1[1] = in1[1] ^ tmp_borrow[0];
  assign tmp_borrow[1] = ~in1[1] & tmp_borrow[0];

  assign out1[2] = in1[2] ^ tmp_borrow[1];


endmodule

module QLK0RSAU04R2V1_STATDSEL_B0(
    trans_next_data, ge_trans_next, trans_next_set, trans_next_state,
    d_shift_data, ge_dshift, d_shift_clr, d_shift_delay,
    seq_start_data, ge_seq_start, seq_start_clr, seq_start);

output trans_next_data;
input  ge_trans_next;
input  trans_next_set;
input  trans_next_state;
output d_shift_data;
input  ge_dshift;
input  d_shift_clr;
input  d_shift_delay;

output seq_start_data;
input  ge_seq_start;
input  seq_start_clr;
input  seq_start;


wire trans_next_data = ge_trans_next ? trans_next_set : trans_next_state;
wire d_shift_data = ge_dshift ? ~d_shift_clr : d_shift_delay;
wire seq_start_data = ge_seq_start ? ~seq_start_clr : seq_start;

endmodule

// Flag sub-module
module QLK0RSAU04R2V1_FLAG_B0 (
                         peclk, peresetz, mck,
                         peri_write, sel_sir, we_ulhw, we_sdr,
                         se, count_clock, ccs2, dap, st_trg,
                         count_start_trg, sdr_load_timing, re_sdr,
                         seq_start,
                         d_shift, ack_timing, state_trans, seri_fin,
                         md_iic,
                         csi_slave_mode,
                         pcheck_on, odd_parity,
                         rxe, txe, sin_sel,
                         send_data_out,
                         fin_timing,
                         ovf, parity_out, pef,
                         tsf, bff,
                         set_ovf, set_pef,
                         clr_ovf, clr_pef,
                         borrow_register
                          );

input peclk;
input peresetz;
input mck;
input [2:0] peri_write;
input sel_sir;
input we_ulhw;
input we_sdr;
input se;
input count_clock;
input ccs2;
input dap;
input count_start_trg;
input sdr_load_timing;
input re_sdr;
input seq_start;
//input uart_stop;
input d_shift;
input ack_timing;
input state_trans;
input md_iic;
//input uart_recv;
input csi_slave_mode;
//input C_STOP;
//input C_PARITY;
input pcheck_on;
input odd_parity;
input txe;
input rxe;
input sin_sel;
input send_data_out;
input fin_timing;
input st_trg;
input seri_fin;

output ovf;
output parity_out;
output pef;
//output fef;
output tsf;
output bff;
output set_ovf;
//output set_fef;
output set_pef;
output clr_ovf;
//output clr_fef;
output clr_pef;
output borrow_register;

wire orct_trg;
// wire fect_trg;	 // not drive anything  : by yama
wire pect_trg;
wire we_sir;
wire ge_recv_hold;
reg borrow_register;
wire recv_hold;
wire clr_ovf;
wire ovr_err;
wire slave_err;
wire ge_ovf;
reg ovf;
wire ge_pari_check;
wire iic_ack_timing;
wire pcheck_timing;
wire p_src_data;
wire parity_out;
reg pari_check;
wire ge_pef;
wire pef_data;
wire pc_data;
reg pef;
//wire ge_fef;
//wire fef_data;
//reg fef;
reg  tsf;
wire ge_tsf;
wire tsf_src;
wire set_sdff;  //wire set_bff;
wire clr_sdff;  //wire clr_bff;
wire ge_sdff;   //wire ge_bff;
reg  sdff;      //reg bff;
wire sdff_data; //wire bff_data;
wire bff;
wire recv_hold_data;
wire ovf_data;

// This is clear trigger assignment
assign orct_trg = peri_write[0];
assign pect_trg = peri_write[1];
// assign fect_trg = peri_write[2]; 		// not drive anything  : by yama
// SIR register write signal
assign we_sir = sel_sir & we_ulhw;


//-------------------------------------------------------------------------------//
// borrow_register has receive data holding  //
//-------------------------------------------------------------------------------//
// make common gating signal of recv_hold, ovf, sdff
wire ge_flag1 = ge_recv_hold | ge_ovf | ge_sdff;

QLK0RSAU04R2V1_FLGDSEL1_B0 flgsel1(.recv_hold_data(recv_hold_data), .ge_recv_hold(ge_recv_hold), 
                                     .sdr_load_timing(sdr_load_timing), .st_trg(st_trg), .recv_hold(recv_hold),
                                   .ovf_data(ovf_data), .ge_ovf(ge_ovf), .set_ovf(set_ovf), .ovf(ovf),
                                   .sdff_data(sdff_data), .ge_sdff(ge_sdff), .clr_sdff(clr_sdff), .sdff(sdff));

       // recv_hold gating signal
assign ge_recv_hold =  (sdr_load_timing) // set timing on data receive
                       | (recv_hold & re_sdr)         // clear timing at read-out received data
                       | st_trg ;                     // clear timing at ST Stop trigger
       // recv_hold data signal
//assign data_recv_hold = ge_recv_hold ? sdr_load_timing & ~st_trg : recv_hold; // set is high priority

// borrow register data and gating signal
//assign ge_brow = ge_recv_hold & se;

always @( posedge peclk or negedge peresetz ) begin
  if(~peresetz)           borrow_register <= 1'b0;
  //else if (ge_recv_hold)  borrow_register <= sdr_load_timing & ~st_trg;
  else if (ge_flag1)      borrow_register <= recv_hold_data;
end
assign recv_hold = borrow_register;

//----------------------------------------------------------------------------------------//
// OVF flag share the 2 function , serial over-run error, and serial slave data-not-ready //
//----------------------------------------------------------------------------------------//
       // over-run error clear condition
assign clr_ovf = we_sir &  orct_trg;
       // over-run error set condition. It's cause by next data receive or write SDR at recv_hold=1
       //       and receive end timing and write sdr timing
assign ovr_err = (recv_hold & ((sdr_load_timing & ~re_sdr) | we_sdr)) | (sdr_load_timing & we_sdr);
       // OVF set condition (for CSI Slave Send Data un-ready Status)
assign slave_err = csi_slave_mode & count_start_trg & txe & ~sdff;
wire set_ovf = (ovr_err | slave_err) & ~st_trg;

// ovf flag data and gating signal
assign ge_ovf = set_ovf | clr_ovf;

always @(posedge peclk or negedge peresetz) begin
  if (~peresetz)        ovf <= 1'b0;
//   else if (ge_ovf)      ovf <= set_ovf;
  else if (ge_flag1)    ovf <= ovf_data;
end

//-----------//
// BFF flag  //
//-----------//
assign bff = sdff | recv_hold; // New BFF flag

assign set_sdff = txe & we_sdr & se;
assign clr_sdff = (count_start_trg     // send data load(SDR->SPR) timing
                   | (txe & fin_timing & (~ccs2 | (ccs2&dap)))  // Seq-send start timing
                   | st_trg) & sdff ;

// sdff gating and data signal
assign ge_sdff = (set_sdff | clr_sdff) ;
// assign sdff_data = ge_sdff ? ~clr_sdff : sdff; // clear is high priority

always @( posedge peclk or negedge peresetz ) begin
  if(~peresetz)      sdff <= 1'b0;
//  else if (ge_sdff)   sdff <=  ~clr_sdff;
  else if (ge_flag1) sdff <= sdff_data;
end



//--------------------------------------------------------------------//
// pari_check is parity check status register until data receive end  //
//--------------------------------------------------------------------//
reg pari_check_data;

// make common gating signal of pari_check, pef, fef_tmp, fef
wire ge_pef_fef_common = mck|we_sir;
wire ge_flag2 = ge_pari_check | ge_pef_fef_common ;

QLK0RSAU04R2V1_FLGDSEL2_B0 flgsel2(
 .pc_data(pc_data), .ge_pari_check(ge_pari_check), .pari_check_data(pari_check_data), .pari_check(pari_check),
 .pef_data(pef_data), .ge_pef_fef_common(ge_pef_fef_common), .ge_pef(ge_pef), .set_pef(set_pef), .pef(pef));


// This is pari_check data signal (for Power Compiler extracting gating signal, avoiding logical complexity)
wire iic_ack_data = sin_sel & txe;
always@(iic_ack_timing or d_shift or pcheck_timing or
        iic_ack_data or parity_out or sin_sel or p_src_data or pari_check)
begin
  casex ({iic_ack_timing, pcheck_timing, d_shift}) //synopsys parallel_case
   3'b1xx: pari_check_data = iic_ack_data;
   3'b01x: pari_check_data = parity_out ^ sin_sel;
   3'b001: pari_check_data = p_src_data ^ pari_check;
   default: pari_check_data = 1'b0;
  endcase
end

    
// wire pari_check_en = 1'b0; //pcheck_on & rxe; 		// not drive anything : by yama

// this is ack timing for IIC mode
assign iic_ack_timing = md_iic & ack_timing & ~state_trans;
// this is parity check timing 
assign pcheck_timing = 1'b0; //pari_check_en & C_PARITY & ~state_trans ;

// source data for parity check, receive->SIN, send->SOUT
assign p_src_data = rxe ? sin_sel : send_data_out;

// Parity data output signal(-> OUTCTL sub-module)
assign parity_out = (odd_parity ? ~pari_check : pari_check) & pcheck_on ;

// gating signal for pari_check
wire pari_initialize = count_start_trg | (fin_timing & seq_start);
assign ge_pari_check = d_shift | ( iic_ack_timing & count_clock) | pari_initialize ;

// assign pc_data = ge_pari_check ? pari_check_data : pari_check;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     pari_check <= 1'b0;
//   else if (ge_pari_check)  pari_check <= pari_check_data;
  else if (ge_flag2)  pari_check <= pc_data;
end

//------------------------//
// PEF parity error flag  //
//------------------------//
//wire src_pef = (fin_timing & (pari_check_en | md_iic)) & pari_check & count_clock;
wire src_pef = (fin_timing & md_iic) & pari_check & count_clock;
wire clr_pef = (we_sir & pect_trg) ;  // pef clear timing
assign ge_pef = src_pef | clr_pef ;

// assign pef_data = ge_pef_fef_common ? (ge_pef ? set_pef : pef) : pef; // set is high priority

wire set_pef = src_pef & ~st_trg ;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)                  pef <= 1'b0;
//   else if (ge_pef_fef_common)     pef <= pef_data;
  else if (ge_flag2)     pef <= pef_data;
end

//----------//
// TSF flag //
//----------//
//assign ge_tsf = count_start_trg | uart_stop | seri_fin | st_trg;
assign ge_tsf = count_start_trg | seri_fin | st_trg;
//assign tsf_src = ~(uart_stop | seri_fin | st_trg) ; // clear is high priority, reduce redundant logic
assign tsf_src = ~(seri_fin | st_trg) ; // clear is high priority, reduce redundant logic

always @(posedge peclk or negedge peresetz) begin
  if (~peresetz)       tsf <= 1'b0;
  else if (ge_tsf)     tsf <= tsf_src;
end


endmodule

module QLK0RSAU04R2V1_FLGDSEL1_B0( recv_hold_data, ge_recv_hold, sdr_load_timing, st_trg, recv_hold,
                                   ovf_data, ge_ovf, set_ovf, ovf,
                                   sdff_data, ge_sdff, clr_sdff, sdff);

output recv_hold_data;
input ge_recv_hold;
input sdr_load_timing;
input st_trg;
input recv_hold;
output  ovf_data;
input ge_ovf;
input set_ovf;
input ovf;
output sdff_data;
input ge_sdff;
input clr_sdff;
input sdff;

wire recv_hold_data = ge_recv_hold ? sdr_load_timing & ~st_trg : recv_hold;
wire ovf_data = ge_ovf ? set_ovf : ovf;
wire sdff_data = ge_sdff ? ~clr_sdff : sdff; // clear is high priority

endmodule

module QLK0RSAU04R2V1_FLGDSEL2_B0(
 pc_data, ge_pari_check, pari_check_data, pari_check,
 pef_data, ge_pef_fef_common, ge_pef, set_pef, pef);

output pc_data;
input  ge_pari_check;
input  pari_check_data;
input  pari_check;

output pef_data;
input  ge_pef_fef_common;
input  ge_pef;
input  set_pef;
input  pef;

wire pc_data = ge_pari_check ? pari_check_data : pari_check;
wire pef_data = ge_pef_fef_common ? (ge_pef ? set_pef : pef) : pef; 

endmodule


// INT sub-module
module QLK0RSAU04R2V1_INT_B0 (
                         peclk, peresetz,
                         count_start_trg,
                         md0, dap, csi_slave_mode,
                         last_state, seq_start, state_trans,
                         st_trg,
                         eoc, ovf, pef, set_ovf, set_pef,
                         clr_ovf, clr_pef,
                         se,
                         int_sig, eint );

input peclk;
input peresetz;
input md0;
input dap;
input csi_slave_mode;
input last_state;
input seq_start;
input state_trans;
input st_trg;
input se;
input count_start_trg;
input eoc;
input ovf;
//input fef;
input pef;
input set_ovf;
//input set_fef;
input set_pef;
input clr_ovf;
//input clr_fef;
input clr_pef;

output int_sig;
output eint;

wire buf_emp;
wire t_end;
wire int_seri;
wire ge_int;
reg int_sig;
reg eint;
//
wire set_eint, clr_eint, ge_eint, data_eint;
wire int_sig_data;

wire ge_int_eint = ge_int | ge_eint;

// Serial function source of INT signal
assign buf_emp = count_start_trg | (last_state & seq_start & ~(csi_slave_mode & ~dap)); // buffer empty interrupt
assign t_end = last_state ;  // transfer end interrupt
wire eoc_mask = eoc & ((ovf&~clr_ovf) | (pef&~clr_pef)
                         | set_ovf | set_pef);
assign int_seri = (md0 ? buf_emp : t_end) & state_trans & ~eoc_mask & ~st_trg; // Serial mode


// int_sig gating and data signal
assign ge_int = int_seri | int_sig;
//assign int_sig_data = int_seri & se;
//assign int_sig_data = ge_int ? int_seri & se : int_sig;


assign set_eint = ( set_ovf | set_pef ) & eoc;
assign clr_eint = ~set_eint & eint;
assign ge_eint = set_eint | clr_eint;
//assign data_eint = ge_eint ? set_eint : eint;

QLK0RSAU04R2V1_INTDSEL_B0 intdsel( .data_eint(data_eint), .ge_eint(ge_eint), .set_eint(set_eint),
                                   .eint(eint), 
                                   .int_sig_data(int_sig_data), .ge_int(ge_int), .int_seri(int_seri),
                                   .se(se), .int_sig(int_sig));
   
   
always @( posedge peclk or negedge peresetz ) begin
    if(~peresetz) begin
            int_sig <= 1'b0;
            eint <= 1'b0;
      end
    else if (ge_int_eint) begin
            int_sig <= int_sig_data;
            eint <= data_eint;
      end
end

endmodule

module QLK0RSAU04R2V1_INTDSEL_B0( data_eint, ge_eint, set_eint, eint,
                                  int_sig_data, ge_int, int_seri, se, int_sig );
output data_eint;
output int_sig_data;

input ge_eint;
input set_eint;
input eint;
input ge_int;
input int_seri;
input se;
input int_sig;

wire data_eint = ge_eint ? set_eint : eint;
wire int_sig_data = ge_int ? int_seri & se : int_sig;

endmodule


// OUTCTL sub-module
module QLK0RSAU04R2V1_OUTCTL_B0 (
                           count_start_trg, st_trg, s_trans, fin_timing,
                           last_state, seq_start,
                           N_START, N_SEND, N_PARITY, N_STOP,
                           C_IDLE, C_STOP,
                           trans_next_state,
                           sdr, count_register,
                           data_8bit,
                           dir, txe, md_iic, md_uart,
                           count_clock, sck_toggle,
                           parity_out, dap, ckp, ccs2, csi_slave_mode,
                           seri_dout_timing, seri_dout,
                           sck_timing, sck_data,
                           send_data_out );

input count_start_trg;
input st_trg;
input s_trans;
input fin_timing;
input last_state;
input seq_start;
input N_START;
input N_SEND;
input N_PARITY;
input N_STOP;
input C_IDLE;
input C_STOP;
input trans_next_state;
input [15:0] sdr;
input [15:0] count_register;

input data_8bit;
input dir;
input txe;
input md_iic;
input md_uart;
input count_clock;
input sck_toggle;
input parity_out;
input dap;
input ckp;
input ccs2;
input csi_slave_mode;

output seri_dout_timing;
output seri_dout;
output sck_timing;
output sck_data;
output send_data_out;

wire seri_dout_timing;
wire start_bit;
wire parity_bit;
wire stop_bit;
wire load_from_sdr;
wire [15:0] src_of_dout;
reg  msb_out;
reg  pre_seri_dout;
wire seri_dout;
wire sck_timing;
wire sck_data;

// Serial Data output timing
wire iic_default = (md_iic & fin_timing & ~seq_start); // This is IIC default value (SOUT = "H")
wire csi_slv_out = ~(csi_slave_mode & ~dap) & seq_start ;
assign seri_dout_timing  = (count_start_trg | (s_trans & (~last_state|csi_slv_out)) | iic_default) & ~st_trg ;
// Start bit output timing
assign start_bit = N_START;
// Parity bit output timing
assign parity_bit = N_PARITY;
// Stop bit output timing
assign stop_bit = N_STOP;

// At start timing, SDR data doesnot load SPR register, 
// So SOUT is load from SDR register at this timing.
assign load_from_sdr = (C_IDLE & N_SEND & ~seq_start) | (last_state & seq_start & ~(ccs2 & ~dap));

// Serial output data selector
assign src_of_dout = load_from_sdr ? sdr : count_register;

// MSB first output data selector // Remove data_9bit, 16bit
//always@(data_5bit or data_8bit or src_of_dout) begin
always@(data_8bit or src_of_dout) begin
  case(1'b1) //synopsys parallel_case
//    data_5bit:  msb_out = src_of_dout[4];
    data_8bit:  msb_out = src_of_dout[7];
    default:  msb_out = src_of_dout[6];
  endcase
end

// MSB/LSB selector
wire send_data_out = dir ? src_of_dout[0] : msb_out;

// IIC/SCIF output data at stop state
wire stop_data = md_iic ? txe : 1'b1;

// data output
always@(start_bit or parity_bit or stop_bit or iic_default or
        parity_out or stop_data or send_data_out ) begin
  casex ({start_bit, parity_bit, stop_bit, iic_default})
    4'b1xxx: pre_seri_dout = 1'b0;
    4'bx1xx: pre_seri_dout = parity_out;
    4'bxx1x: pre_seri_dout = stop_data;
    4'b0001: pre_seri_dout = 1'b1;
    default: pre_seri_dout = send_data_out;
  endcase
end

assign seri_dout =  pre_seri_dout;

//++++====++++====++++==== SCKO_SRC ++====++++====++++====++++====+//
       // SCK toggle timing

wire   mask_stop = ((N_STOP & trans_next_state & ~dap) | C_STOP) & ~(seq_start & fin_timing);
wire   sck_tim_pre = count_start_trg |        // start timing
                     (count_clock & ~( ((~dap & fin_timing&(~seq_start|ccs2) ) | mask_stop) & ~md_iic));
assign sck_timing = sck_tim_pre & ~md_uart & ~st_trg ;
assign sck_data = (dap ^ ckp) ? ~sck_toggle : sck_toggle;

endmodule



module QLK0RSAU04R2V1_FUNC_B1 (
                    // INPUT
                    peclk, pclkrw, peresetz,
                    mck,
                    we_ulhw, sel_sdr, sel_sir, re_sdr, peri_write,
                    se, md0,
                    dap, ckp,
                    count_start_trg, 
                    count_clock, b_count_clock,
                    md_csi, md_uart, md_iic,
                    eoc,
                    dls, slc, dir, rxe, txe,
                    pstate_on, pcheck_on, odd_parity,
                    no_stopbit, ccs2,
                    data_7bit, data_8bit,
                    sin_level, st_trg, start_slave,
                    sin_latch, 
                    // OUTPUT
                    spr,sdr_read,
                    baud_borrow, csi_slave_stop,
                    int_sig, eint,
                    seri_fin_out,
                    pef,fef,bff,ovf,tsf,
                    seri_dout_timing, seri_dout,
                    sck_timing, sck_data,
                    fast_mode, sin_direct,
                    ack_timing
                    
                   );

input peclk;
input pclkrw;
input peresetz;

input mck;

input we_ulhw;
input sel_sdr;
input sel_sir;
input re_sdr;
input [15:0] peri_write;

input se;
input md0;
input count_start_trg;
input count_clock;
input b_count_clock;

input md_csi;
input md_uart;
input md_iic;
input eoc;
input dap;
input ckp;
input [1:0] dls;
input slc;
input dir;
input rxe;
input txe;
input pstate_on;
input pcheck_on;
input odd_parity;
input no_stopbit;
input ccs2;

input data_7bit;
input data_8bit;
input sin_level;
input sin_latch;
input sin_direct;
input st_trg;
input start_slave;

output [15:0] spr;
output [15:0] sdr_read;
output baud_borrow;
output csi_slave_stop;
output int_sig;
output eint;
output pef;
output fef;
output bff;
output ovf;
output tsf;
output seri_dout_timing;
output seri_dout;
output seri_fin_out;
output sck_timing;
output sck_data;
output fast_mode;
output ack_timing;

// Counter
wire [15:0] spr;
wire baud_borrow;
wire recv_data;
wire [15:0] sdr;
wire [15:0] sdr_read;
wire we_sdr;
wire ld_spr_to_sdr;
wire load_next_s_data;
wire csi_slave_ld_mask;
wire d_shift;

// Overflow
wire borrow_register;
wire bff;

// FSM
wire C_IDLE;
wire C_START;
wire C_SEND;
wire C_PARITY;
wire C_STOP;
wire N_START;
wire N_SEND;
wire N_PARITY;
wire N_STOP;

wire seq_start; // Seq_start is working on except of UART & rxe
wire trans_next_state; // This is state transfer timing on transmission
wire state_trans; // This is current_state gating signal
wire s_trans;
wire sck_toggle; // This is data shift/capture timing signal
wire last_state; // This is the status of Last state on 1 data
wire fin_timing;
wire sdr_load;
wire seri_fin;
wire seri_fin_out;
wire uart_stop;

// Sout
wire seri_dout_timing; // serial SOUT change timing
wire seri_dout; // serial SOUT next data
wire send_data_out;

// Scko
wire sck_timing;   // sck toggle timing;
wire sck_data;     // sck data

// Int
wire int_sig;

// Flag
wire ovf;
wire pef;
wire ack_timing;
wire parity_out;
wire fef;
wire tsf;
wire sdr_load_timing;
wire set_ovf, set_fef, set_pef, clr_ovf, clr_fef, clr_pef;
wire uart_recv;

// I/O control
// wire data_out;		// not drive anything  : by yaam

// Common Signal
//assign uart_recv = md_uart & rxe;
assign uart_recv = md_uart;
assign seri_fin_out = seri_fin | uart_stop;

// SIN Signal Selector
wire csi_slave_mode = md_csi & ccs2;

reg sin_sel;
always@(sin_latch or sin_level or md_uart or csi_slave_mode)
  case ( md_uart|csi_slave_mode )
    1'b1    : sin_sel = sin_latch;
    default : sin_sel = sin_level;
  endcase

assign load_next_s_data = sdr_load & txe; // <- SEQ transfer load next SDR data
assign sdr_load_timing = fin_timing & rxe;
assign ld_spr_to_sdr = sdr_load_timing & ~st_trg ;
assign recv_data = ~rxe | sin_sel;
assign we_sdr = we_ulhw & sel_sdr;

//++++====++++====++++====  COUNTER   ====++++====++++====++++====//
QLK0RSAU04R2V1_CNT_B1 cnt (.peclk(peclk), .peresetz(peresetz),
                     .data_8bit(data_8bit), .data_7bit(data_7bit),
                     .recv_data(recv_data), .dir(dir),
                     .csi_slave_ld_mask(csi_slave_ld_mask),
                     .count_start_trg(count_start_trg), .load_next_s_data(load_next_s_data),
                     .se(se), .d_shift(d_shift), .b_count_clock(b_count_clock),
                     .sdr(sdr), .spr(spr), .baud_borrow(baud_borrow),
                     .sin_direct(sin_direct), .fast_mode(fast_mode), .rxe(rxe) );

//++++====++++====++++====  DATA_REG   ====++++====++++====++++====//
QLK0RSAU04R2V1_DREG_B1 dreg ( .peclk(peclk), .pclkrw(pclkrw), .peresetz(peresetz),
                        .we_sdr(we_sdr), 
                        .se(se), .ccs2(ccs2),
                        .ld_spr_to_sdr(ld_spr_to_sdr), .peri_write(peri_write),
                        .spr(spr), .sdr(sdr), .sdr_read(sdr_read), .fast_mode(fast_mode)
                        );

//++++====++++====++++====   FSM    ++====++++====++++====++++====//
QLK0RSAU04R2V1_STATECTL_B1 statectl(
                              .peclk(peclk), .peresetz(peresetz), 
                              .count_start_trg(count_start_trg), .st_trg(st_trg), .count_clock(count_clock),
                              .md_csi(md_csi), .md_uart(md_uart), 
                              .uart_recv(uart_recv),
                              .txe(txe), .rxe(rxe), .sin_sel(sin_sel),
                              .pstate_on(pstate_on), .no_stopbit(no_stopbit),
                              .dls(dls), .ccs2(ccs2), .dap(dap), .fast_mode(fast_mode),
                              .we_sdr(we_sdr), .tsf(tsf), .start_slave(start_slave),
                              .csi_slave_mode(csi_slave_mode),
                              .C_IDLE(C_IDLE), .C_START(C_START), .C_SEND(C_SEND), .C_PARITY(C_PARITY), .C_STOP(C_STOP),
                              .N_START(N_START), .N_SEND(N_SEND), .N_PARITY(N_PARITY), .N_STOP(N_STOP),
                              .d_shift(d_shift), .state_trans(state_trans), .s_trans(s_trans),
                              .sck_toggle(sck_toggle),
                              .trans_next_state(trans_next_state), .last_state(last_state),
                              .fin_timing(fin_timing), .sdr_load(sdr_load),
                              .seri_fin(seri_fin), .seq_start(seq_start), .ack_timing(ack_timing),
                              .csi_slave_stop(csi_slave_stop),
                              .csi_slave_ld_mask(csi_slave_ld_mask),
                              .uart_stop(uart_stop) );

//++++====++++====++++==== SOUT_SRC ++====++++====++++====++++====++//
//++++====++++====++++==== SCKO_SRC ++====++++====++++====++++====+//
QLK0RSAU04R2V1_OUTCTL_B1 outctl(
                           .count_start_trg(count_start_trg), .st_trg(st_trg), .s_trans(s_trans), .fin_timing(fin_timing),
                           .last_state(last_state), .seq_start(seq_start),
                           .N_START(N_START), .N_SEND(N_SEND), .N_PARITY(N_PARITY), .N_STOP(N_STOP),
                           .C_IDLE(C_IDLE), .C_STOP(C_STOP),
                           .trans_next_state(trans_next_state),
                           .sdr(sdr), .count_register(spr),
                           .data_8bit(data_8bit),
                           .dir(dir), .txe(txe),
                           .md_iic(md_iic), .md_uart(md_uart),
                           .count_clock(count_clock), .sck_toggle(sck_toggle),
                           .parity_out(parity_out), .dap(dap), .ckp(ckp), .ccs2(ccs2), .csi_slave_mode(csi_slave_mode),
                           .seri_dout_timing(seri_dout_timing), .seri_dout(seri_dout),
                           .sck_timing(sck_timing), .sck_data(sck_data),
                           .send_data_out(send_data_out) );

//++++====++++====++++====   INT    ++====++++====++++====++++====//
QLK0RSAU04R2V1_INT_B1 intctl(
                         .peclk(peclk), .peresetz(peresetz),
                         .count_start_trg(count_start_trg),
                         .md0(md0), .dap(dap), .csi_slave_mode(csi_slave_mode),
                         .last_state(last_state), .seq_start(seq_start), .state_trans(state_trans),
                         .st_trg(st_trg),
                         .eoc(eoc), .ovf(ovf), .fef(fef), .pef(pef),
                         .set_ovf(set_ovf), .set_fef(set_fef), .set_pef(set_pef),
                         .clr_ovf(clr_ovf), .clr_fef(clr_fef), .clr_pef(clr_pef),
                         .se(se), 
                         .int_sig(int_sig), .eint(eint) );


//++++====++++====++++====   EINT    ++====++++====++++====++++====//
//QLK0RSAU04R2V1_EINT_B1 seintctl(
//                         .peclk(peclk), .peresetz(peresetz),
//                         .set_ovf(set_ovf), .set_fef(set_fef), .set_pef(set_pef),
//                         .eoc(eoc), .eint(eint) );

//++++====++++====++++====   FLAG   ++====++++====++++====++++====//
QLK0RSAU04R2V1_FLAG_B1 flag (
                       .peclk(peclk), .peresetz(peresetz), .mck(mck),
                       .peri_write(peri_write[2:0]), .sel_sir(sel_sir), .we_ulhw(we_ulhw), .we_sdr(we_sdr),
                       .se(se), .count_clock(count_clock), .st_trg(st_trg),
                       .count_start_trg(count_start_trg), .ccs2(ccs2), .dap(dap),
                       .sdr_load_timing(sdr_load_timing), .re_sdr(re_sdr),
                       .seq_start(seq_start), .uart_stop(uart_stop),
                       .d_shift(d_shift), .ack_timing(ack_timing), .state_trans(state_trans),
                       .md_iic(md_iic),
                       .uart_recv(uart_recv), .csi_slave_mode(csi_slave_mode), .seri_fin(seri_fin),
                       .C_STOP(C_STOP), .C_PARITY(C_PARITY),
                       .slc(slc),
                       .pcheck_on(pcheck_on), .odd_parity(odd_parity),
                       .txe(txe), .rxe(rxe), .sin_sel(sin_sel), .send_data_out(send_data_out),
                       .trans_next_state(trans_next_state),
                       .fin_timing(fin_timing),
                       .ovf(ovf), .parity_out(parity_out), .pef(pef),
                       .fef(fef), .tsf(tsf), .bff(bff),
                       .set_ovf(set_ovf), .set_fef(set_fef), .set_pef(set_pef),
                       .clr_ovf(clr_ovf), .clr_fef(clr_fef), .clr_pef(clr_pef),
                       .borrow_register(borrow_register)
                        );

//++++====++++====++++====+ I/O  CNT +====++++====++++====++++====+//
// assign data_out = txe ;		// not drive anything  : by yaam

endmodule

// This is Counter(SPR) module
module QLK0RSAU04R2V1_CNT_B1 ( peclk, peresetz,
                        data_8bit, data_7bit,
                        recv_data,
                        dir,
                        csi_slave_ld_mask,
                        count_start_trg, load_next_s_data,
                        se, d_shift, b_count_clock,
                        sdr, spr, baud_borrow,
                        sin_direct, fast_mode, rxe );
input peclk;
input peresetz;

input data_8bit;
input data_7bit;
input recv_data;
input dir;
input csi_slave_ld_mask;
input count_start_trg;
input load_next_s_data;
input se;
input d_shift;
input b_count_clock;
input [15:0] sdr;
input sin_direct;
input fast_mode;
input rxe;

output [15:0] spr;
output baud_borrow;


//wire shift9_lsb;
wire shift8_lsb;
wire shift7_lsb;
wire shift6_lsb;
wire shift5_lsb;
//wire shift9_msb;
wire shift8_msb;
wire shift7_msb;
wire shift6_msb;

wire [15:0] shift_data;
wire [15:9] next_value;
reg [15:0] load_data;
wire borrow2;
wire baud_borrow;
reg [15:0] count_register;
wire load_trg_lb;
wire load_trg_ub;
wire ge_count_register_0;
wire ge_count_register_1;
wire ge_count_register_2;
wire ge_count_register_3;


// Shift/Capture function  all shift condition
wire recv_data_sel = fast_mode & rxe ? sin_direct : recv_data;

assign shift8_lsb = (data_8bit & recv_data_sel);
assign shift7_lsb = (~data_7bit & count_register[7]) | (data_7bit & recv_data_sel);
assign shift6_lsb = count_register[6];
assign shift5_lsb =  count_register[5];
assign shift8_msb = ~data_7bit & count_register[6];
assign shift7_msb =  count_register[5];
assign shift6_msb =  count_register[4];

// Generate bit8-0 shift data
//assign shift_data[8:0] = dir ? {shift9_lsb, shift8_lsb, shift7_lsb, shift6_lsb, shift5_lsb, count_register[4:1]}  // LSB first
//                             : {shift9_msb, shift8_msb, shift7_msb, shift6_msb, count_register[3:0], recv_data};  // MSB first
assign shift_data[7:0] = dir ? {shift8_lsb, shift7_lsb, shift6_lsb, shift5_lsb, count_register[4:1]}  // LSB first
                             : {shift8_msb, shift7_msb, shift6_msb, count_register[3:0], recv_data_sel};  // MSB first

   
// Generate bit15-9 shift data
//assign shift_data[15:9] = dir ? {recv_data, count_register[15:10]}  // LSB first
//                              : count_register[14:8];               // MSB first
assign shift_data[15:8] = 8'h00;
   
   
// Borrow signal (bit separated)
wire tmp_borrow2 ;

QLK0RSAU04R2V1_DEC3_B1 dec3_1 (.borrow(tmp_borrow2), .out1(next_value[11:9]),  .in1(count_register[11:9]) );
QLK0RSAU04R2V1_DEC4_B1 dec4_2 (.out1(next_value[15:12]), .in1(count_register[15:12]));

assign borrow2 = tmp_borrow2 ;                     // This is borrow signal count_register[11:9]-1

// Borrow Signal (Baud-Rate Counter), This is used for Timer and Serial
assign baud_borrow = (count_register[15:9]==7'h00);

// SPR Register value inverted on capture mode
assign spr        = {count_register[15:9], 1'b0, count_register[7:0]} ;

// Load SDR/FFFFH trigger for SPR[8:0]
assign load_trg_lb  = ((count_start_trg & ~csi_slave_ld_mask)    // <- This is Serial/Timer Start Condition
                                                                 //    csi_slave_ld_mask is refered to STATECTL
                       | load_next_s_data) & se;                 // <- This is Serial Seq-Send Condition

// Load SDR/FFFFH trigger for SPR[15:9]
assign load_trg_ub  = ((count_start_trg & ~csi_slave_ld_mask)     // This is Serial/Timer Start Condition
                       | (baud_borrow & b_count_clock)            // This is Serial baud-rate Conter=00H Condition;
//                       | (~baud_count_en & load_next_s_data)) & se;   // <- This is Serial Se-Send Condition
                       ) & se;   // <- This is Serial Se-Send Condition


// Load data selector // Remove Bit9
always@(load_trg_lb or sdr or shift_data) begin
  case ({load_trg_lb}) // synopsys parallel_case
    1'b0:  load_data[7:0] = shift_data[7:0];  // load shift/recv for serial mode
    default: load_data[7:0] = sdr[7:0];         // load sdr[8:0] for non capture mode
  endcase
end

//wire shift16 = d_shift & data_16bit;

// Remove data_16bit
always@(load_trg_ub or sdr or shift_data or next_value) begin
  case ({load_trg_ub}) // synopsys parallel_case
    1'b1:  load_data[15:9] = sdr[15:9];         // load sdr[8:0] for non capture mode
    default: load_data[15:9] = next_value[15:9];  // load decrement value
  endcase
end

assign ge_count_register_0 = d_shift | load_trg_lb ;                     // Gating for bit[4:0]
assign ge_count_register_1 = d_shift | load_trg_lb ;                     // Gating for bit[8:5]
assign ge_count_register_2 = load_trg_ub | b_count_clock;                // Gating for bit[11:9]
assign ge_count_register_3 = load_trg_ub | (borrow2 & b_count_clock);    // Gating for bit[15:12]

// Counter/ShiftRegister
always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[3:0] <= 4'hf ;
    else if (ge_count_register_0)  count_register[3:0] <= load_data[3:0];
end

always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[7:4] <= 4'hf ;
    else if (ge_count_register_1)  count_register[7:4] <= load_data[7:4];
end

always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[11:9] <= 3'h7 ;
    else if (ge_count_register_2)  count_register[11:9] <= load_data[11:9];
end

always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[15:12] <= 4'hf ;
    else if (ge_count_register_3)  count_register[15:12] <= load_data[15:12];
end

endmodule

// 4bit Decrement Module
module QLK0RSAU04R2V1_DEC4_B1 (out1, in1);
  output [3:0] out1;
  input  [3:0] in1;

  wire [3:0] out1;
  wire [2:0] tmp_borrow;

  assign out1[0] = tmp_borrow[0] ;
  assign tmp_borrow[0] = ~in1[0] ;

  assign out1[1] = in1[1] ^ tmp_borrow[0];
  assign tmp_borrow[1] = ~in1[1] & tmp_borrow[0];

  assign out1[2] = in1[2] ^ tmp_borrow[1];
  assign tmp_borrow[2] = ~in1[2] & tmp_borrow[1];

  assign out1[3] = in1[3] ^ tmp_borrow[2];

endmodule

// 3bit Decrement Module
module QLK0RSAU04R2V1_DEC3_B1 (borrow, out1, in1);
  output borrow;
  output [2:0] out1;
  input  [2:0] in1;

  wire borrow;
  wire [2:0] out1;
  wire [1:0] tmp_borrow;

  assign out1[0] = tmp_borrow[0] ;
  assign tmp_borrow[0] = ~in1[0] ;

  assign out1[1] = in1[1] ^ tmp_borrow[0];
  assign tmp_borrow[1] = ~in1[1] & tmp_borrow[0];

  assign out1[2] = in1[2] ^ tmp_borrow[1];
  assign borrow = ~in1[2] & tmp_borrow[1];

endmodule

// Data Register (SDR)
module QLK0RSAU04R2V1_DREG_B1(
                         peclk, pclkrw, peresetz,
                         we_sdr, ccs2,
                         se,
                         ld_spr_to_sdr, peri_write,
                         spr, sdr, sdr_read, fast_mode
                         );

input peclk;
input pclkrw;
input peresetz;
input we_sdr;
input ccs2;
input se;
input ld_spr_to_sdr;
input [15:0] peri_write;
input [15:0] spr;

output [15:0] sdr;
output [15:0] sdr_read;
output     fast_mode;
   
wire apb_wr_en;
wire mask_sdr_h;
wire ge_sdr;
//reg [15:0] sdr_data;
//reg [15:0] sdr;
//reg [6:0] sdr_data_h;
reg [7:0] sdr_data_l;
reg [6:0] sdr_h;
reg [7:0] sdr_l;
   
wire [15:0] sdr_read;
wire [15:0] sdr = {sdr_h, 1'b0, sdr_l};
   
// SDR Write Signal (masked by capture mode)
assign apb_wr_en = we_sdr;
// APB Write Mask signal for baud-rate counter(SDR[15:9])
assign mask_sdr_h = se ;  // & baud_count_en;
// SDR gating signal (APB write, capture trigger, Serial Receive)
assign ge_sdr = apb_wr_en | ld_spr_to_sdr ;

// SDR Write data for SDR[8:0] // Remove SDR[8] R2
//always@(apb_wr_en or peri_write or spr) begin
//  if (apb_wr_en) sdr_data[8:0] = peri_write[8:0];  // APB write
//  else           sdr_data[8:0] = spr[8:0];         // Capture and Serial Receive
//end
always@(apb_wr_en or peri_write or spr) begin
  if (apb_wr_en) sdr_data_l[7:0] = peri_write[7:0];  // APB write
  else           sdr_data_l[7:0] = spr[7:0];         // Capture and Serial Receive
end
   

// SDR[15:9]
always @(posedge pclkrw or negedge peresetz) begin
    if (~peresetz)          sdr_h <= 7'h00;
    else if (~se&apb_wr_en) sdr_h <= peri_write[15:9];
end
   
// SDR[7:0]
always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)    sdr_l <= 8'h00;
    else if (ge_sdr)  sdr_l <= sdr_data_l;
end


// This is SDR read-out value
assign sdr_read[15:9] = mask_sdr_h ? 7'h00 : sdr_h; // Baud-rate doesn't read out while SE=1
assign sdr_read[8:0] = {1'b0,sdr_l};

wire fast_mode = (sdr_h == 7'h00)&~ccs2;
   
   
endmodule

// FSM Controller
module QLK0RSAU04R2V1_STATECTL_B1 (
                              peclk, peresetz,
                              count_start_trg, st_trg, count_clock,
                              md_csi, md_uart, uart_recv,
                              txe, rxe, sin_sel,
                              pstate_on, no_stopbit,
                              dls, ccs2, dap, fast_mode,
                              we_sdr, tsf, start_slave, csi_slave_mode,
                              C_IDLE, C_START, C_SEND, C_PARITY, C_STOP,
                              N_START, N_SEND, N_PARITY, N_STOP,
                              d_shift, state_trans, s_trans,
                              sck_toggle,
                              trans_next_state, last_state,
                              fin_timing, sdr_load,
                              seri_fin, seq_start, ack_timing,
                              csi_slave_stop, csi_slave_ld_mask,
                              uart_stop  );

input  peclk;
input  peresetz;
//input  se;
input  count_start_trg;
input  st_trg;
input  count_clock;
input  md_uart;
input  md_csi;
input  uart_recv;
input  txe;
input  rxe;
input  sin_sel;
input  pstate_on;
input  no_stopbit;
input [1:0] dls;
//input  slc;
input  ccs2;
input  dap;
input  we_sdr;
input  tsf;
input  start_slave;
input  csi_slave_mode;
input fast_mode;
   
output C_IDLE;
output C_START;
output C_SEND;
output C_PARITY;
output C_STOP;
output N_START;
output N_SEND;
output N_PARITY;
output N_STOP;
output d_shift;
output sck_toggle;
output state_trans;
output s_trans;
output trans_next_state;
output last_state;
output fin_timing;
output sdr_load;
output seri_fin;
output seq_start;
output ack_timing;
output csi_slave_stop;
output csi_slave_ld_mask;
output uart_stop;

// State definition
parameter IDLE   = 3'b000;
parameter START  = 3'b111;
parameter SEND   = 3'b101;
parameter PARITY = 3'b010;
parameter STOP   = 3'b110;

wire C_IDLE;
wire C_START;
wire C_SEND;
wire C_PARITY;
wire C_STOP;
wire N_START;
wire N_SEND;
wire N_PARITY;
wire N_STOP;
wire uart_stop;
wire state_trans;
wire d_shift;
wire d_shift_normal;
reg  d_shift_delay;

wire last_state;
wire fin_timing;
wire sdr_load;
wire seri_fin;
reg trans_next_state;
reg [2:0] current_state;
reg [2:0] next_state;
wire st_counter_end;
wire [2:0] data_length;
//reg  [2:0] stop_length;
wire dl_set;
wire [2:0] st_load_val;
wire load_stcnt;
wire run_stcnt;
wire [2:0] next_value;
reg [2:0] next_st_counter;
reg [2:0] st_counter;
wire ge_st_counter;
wire ge_seq_start;
wire seq_start_data;
reg seq_start;
wire ge_trans_next;
wire csi_slave_stop;
wire ge_dshift;
wire trans_next_data;
wire d_shift_data;
wire trans_next_set; 
wire d_shift_clr;
wire seq_start_clr;
 
// State Decode
assign C_IDLE   = (current_state != START) & (current_state != SEND) & (current_state != PARITY) & (current_state != STOP);
assign C_START  = (current_state == START);
assign C_SEND   = (current_state == SEND);
assign C_PARITY = (current_state == PARITY);
assign C_STOP   = (current_state == STOP);
assign N_START  = (next_state == START);
assign N_SEND   = (next_state == SEND);
assign N_PARITY = (next_state == PARITY);
assign N_STOP   = (next_state == STOP);


// Make common gating signal for seq_start, d_shift_delay, trans_next_state
wire ge_common = ge_trans_next | ge_dshift | ge_seq_start;
QLK0RSAU04R2V1_STATDSEL_B1 statdsel(
    .trans_next_data(trans_next_data), .ge_trans_next(ge_trans_next), .trans_next_set(trans_next_set),
    .trans_next_state(trans_next_state),
    .d_shift_data(d_shift_data), .ge_dshift(ge_dshift), .d_shift_clr(d_shift_clr), .d_shift_delay(d_shift_delay),
    .seq_start_data(seq_start_data), .ge_seq_start(ge_seq_start), .seq_start_clr(seq_start_clr),
    .seq_start(seq_start));



// CSI Slave mode(dap=1) signal
wire   csi_slave_dap1 = csi_slave_mode & dap;

// This is load_trg(SDR->SPR) mask signal (dap=1)
//  SCKI      ~~~~~~~~~~~~~~|________|~~~~~~~~~|______
//                   ________________ ________________
//  SIN       XXXXXXX________________X________________
//                          O
//          This is 1st clock edge of CSI Slave.
//          So load_trg(count_start_trg) is triggered, but in this transmission format,
//           SAU capture 1st receive bit.
wire   csi_slave_ld_mask = (csi_slave_dap1 & ~txe & rxe)   // mask start load_trig by csi slave dap=1
                           | (csi_slave_mode & txe & seq_start) // mask seq-start load_trg by csi slave
                           | (uart_recv & tsf);            // mask load_trig by falling SIN (avoiding over-write SPR)

// This is CSI slave start signal at 1st SCKI edge in the case of no writing send data.
wire   csi_slave_dap1_start = csi_slave_dap1 & ~tsf & start_slave;

// This is CSI slave stop process at dap=0 
//      SCKI   ________|~~~~~~~~~~~~~~~~~~~~~
// state_trans ________|~~~~|________________
//                        ^^^ Generate this timing
//             __________ __ ________________
//      state  ____S_____XS_X___I____________
assign csi_slave_stop = csi_slave_mode & ~dap & last_state & trans_next_state;

// This is gating signal for trans_next_state register
//assign ge_trans_next = (count_start_trg | count_clock | csi_slave_stop | st_trg) & se;

// This is State transfer, Data Shift control register
//      brate        ______|~|_____|~|_____|~|_____|~|_____|~|_____|~|_____|~|_____
//  trans_next_state ________|~~~~~~~|_______|~~~~~~~|_______|~~~~~~~|_______|~~~~~
//                           O       X       O       X       O       X       O
//                      O:Data Shift/Capture Timing
//                      X:State Transfer Timing

//wire trans_next_data;
assign trans_next_set = (~state_trans | csi_slave_dap1_start) & ~st_trg ;
//assign ge_trans_next = (count_start_trg | count_clock | csi_slave_stop | st_trg) ;
assign ge_trans_next = (count_start_trg | count_clock | st_trg) ;
//assign  trans_next_data = ge_trans_next ? trans_next_set : trans_next_state;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)            trans_next_state <= 1'b0;
//   else if (ge_trans_next)   trans_next_state <= trans_next_set;
  else if (ge_common)       trans_next_state <= trans_next_data;
end

// 2 stop timing on UART receive function(Start by noise, Stop)
//    1.   SIN   ~~~~~~|______|~~~~~~~~~~~~~~~~~~~~
//      1/2Brate ______|_________|________|________
//               IDLE  X Start   X IDLE
//    2.1/2Brate ____|______|______|______|______
//                   X Parity      X Stop X Idle
wire uart_stop_pre = uart_recv & ~trans_next_state & ((C_START & sin_sel) | (C_STOP & st_counter_end));
assign uart_stop = uart_stop_pre & count_clock;

// source of state transition timing (Normal State transition)
assign s_trans = (trans_next_state | uart_stop_pre) & count_clock;

// State transition signal
assign state_trans = count_start_trg | s_trans | st_trg ;

// Data Shift/Capture Timing
assign d_shift_normal = (~trans_next_state & C_SEND & count_clock) | csi_slave_dap1_start;

wire d_shift_set = d_shift_normal;
assign d_shift_clr = st_trg | d_shift_delay;
assign ge_dshift = d_shift_set | d_shift_clr;
//assign d_shift_data = ge_dshift ? ~d_shift_clr : d_shift_delay;

always@(posedge peclk or negedge peresetz)
  if (~peresetz)      d_shift_delay <= 1'b0;
//   else if (ge_dshift) d_shift_delay <= ~d_shift_clr;
  else if (ge_common) d_shift_delay <= d_shift_data;

wire csi_master = ~ccs2 & md_csi & ~fast_mode;
assign d_shift = csi_master ? d_shift_delay : d_shift_normal;

// SCKO Toggle Timing
wire   sck_toggle = (~trans_next_state & count_clock) | csi_slave_dap1_start; // add for SCKO

// This is Serial Last State
assign last_state = (C_SEND & st_counter_end & ~pstate_on & no_stopbit) | // finish on SEND state
                    (C_PARITY & no_stopbit) |                             // finish on PARITY state
                    (C_STOP & st_counter_end) ;                           // finish on STOP state

// This is Serial Finish timing
assign fin_timing = last_state & state_trans;
// This is SDR->SPR load signal for Seq-send
assign sdr_load = fin_timing & seq_start;
// This is the end of serial
assign seri_fin = fin_timing & (~seq_start | (ccs2 & ~dap));

//===========================//
//   Next State combination  //
//===========================//
always@(count_start_trg or sin_sel or st_counter_end or st_trg or
        md_uart or pstate_on or no_stopbit or uart_recv or
        seq_start or trans_next_state or ccs2 or dap or
        C_START or C_SEND or C_PARITY or C_STOP) begin
  next_state = IDLE;

  // Stop for write ST register
  if (st_trg)  begin
    next_state = IDLE;
  end
  else begin
    // Normal State Transition
    if (count_start_trg) begin
       if   (md_uart) next_state = START;   // IDLE -> START
       else           next_state = SEND;    // IDLE -> SEND
    end

    if (C_START) begin
      if (uart_recv & sin_sel & ~trans_next_state)
                                       next_state = IDLE;  // START -> IDLE
      else                             next_state = SEND;  // START -> SEND
    end

    if (C_SEND) begin
      if (st_counter_end) begin
        if (pstate_on)         next_state = PARITY; // SEND -> PARITY
        else if (~no_stopbit)  next_state = STOP;   // SEND -> STOP
        else if (seq_start & ~(ccs2 & ~dap)) begin
          //if (md_uart)         next_state = START;  // SEND -> START
          //else                 next_state = SEND;   // SEND -> SEND(next flame)
          next_state = SEND;
          end
        else                   next_state = IDLE;   // SEND -> IDLE
      end
      else                     next_state = SEND;   // SEND -> SEND(continue transfer)
    end

    if (C_PARITY) begin
      if (~no_stopbit)       next_state = STOP;    // PARITY -> STOP
      else if (seq_start & ~(ccs2 & ~dap)) begin
        //if (md_uart)         next_state = START;   // SEND -> START
        //else                 next_state = SEND;    // SEND -> SEND(next flame)
        next_state = SEND;
      end
      else                   next_state = IDLE;    // PARITY -> IDLE    
    end

    if (C_STOP) begin
      if (st_counter_end) begin
        if (seq_start & ~(ccs2 & ~dap)) begin
          //if (md_uart)           next_state = START;  // STOP -> START
          //else                   next_state = SEND;   // STOP -> SEND
          next_state = SEND;
        end
        else                     next_state = IDLE;   // STOP -> IDLE
      end
      else                       next_state = STOP;   // STOP -> STOP
    end
  end

end

// This is the FSM register
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        current_state <= IDLE;
  else if (state_trans) current_state <= next_state;
end

// Data length Counter/ Stop bit length Counter
assign st_counter_end = ~|st_counter;

// Data length Decoder
assign data_length = {1'b1,dls};

// Stop bit length Decoder
//always@(slc) begin
//  case (slc) //synopsys parallel_case
//    1'b1 : stop_length = 3'b001;
//    default: stop_length = 3'b000;
//  endcase
//end


// Data Length Load Timing (IDLE->SEND, START->SEND, SEND->SEND, STOP->SEND, PARITY->SEND)
assign dl_set = N_SEND;

// This is the select signal of st_counter load value
assign st_load_val = dl_set ? data_length : 3'b000;

                    // Data length load              Data/Stop length load
assign load_stcnt = (~C_SEND & N_SEND) | (C_SEND & st_counter_end);
assign run_stcnt = (C_SEND | C_STOP) & ~st_counter_end ;

// Decrementer(-1) of st_counter
//QLK0RSAU04R2V1_DEC4 dec4_1 (.out1(next_value),   .in1(st_counter) );
QLK0RSAU04R2V1_DEC3_2_B1 dec3_2 (.out1(next_value),   .in1(st_counter) );
   
// st_counter data selector
always@(load_stcnt or run_stcnt or st_load_val or next_value or st_counter) begin
  case(1'b1) //synopsys parallel_case
    load_stcnt: next_st_counter = st_load_val;     // load count data
    run_stcnt : next_st_counter = next_value[2:0]; // decrement(-1)
    default   : next_st_counter = st_counter;      // keep st_counter
  endcase
end

// Gating signal of st_counter
assign ge_st_counter = (load_stcnt | run_stcnt) & (s_trans | count_start_trg);

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)           st_counter <= 3'b000;
  else if (ge_st_counter)  st_counter <= next_st_counter;
end

// Sequencial start(except of CSI slave & UART receive)
wire seq_start_end = (ccs2 & ~dap) ? start_slave & ~tsf : fin_timing;

wire seq_start_set = (~C_IDLE & we_sdr) & ~fin_timing & ~uart_recv ;
assign seq_start_clr = st_trg | seq_start_end;
assign ge_seq_start = seq_start_set | seq_start_clr;
//assign seq_start_data = ge_seq_start ? ~seq_start_clr : seq_start;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)          seq_start <= 1'b0;
//   else if (ge_seq_start)  seq_start <= ~seq_start_clr;
  else if (ge_common)     seq_start <= seq_start_data;
end

// This is ACK timing signal at IIC/SCIF
//assign ack_timing = (st_counter == stop_length) & C_STOP;
assign ack_timing = C_STOP;

endmodule

module QLK0RSAU04R2V1_STATDSEL_B1(
    trans_next_data, ge_trans_next, trans_next_set, trans_next_state,
    d_shift_data, ge_dshift, d_shift_clr, d_shift_delay,
    seq_start_data, ge_seq_start, seq_start_clr, seq_start);

output trans_next_data;
input  ge_trans_next;
input  trans_next_set;
input  trans_next_state;
output d_shift_data;
input  ge_dshift;
input  d_shift_clr;
input  d_shift_delay;

output seq_start_data;
input  ge_seq_start;
input  seq_start_clr;
input  seq_start;


wire trans_next_data = ge_trans_next ? trans_next_set : trans_next_state;
wire d_shift_data = ge_dshift ? ~d_shift_clr : d_shift_delay;
wire seq_start_data = ge_seq_start ? ~seq_start_clr : seq_start;

endmodule


module QLK0RSAU04R2V1_DEC3_2_B1 (out1, in1);
  output [2:0] out1;
  input  [2:0] in1;

  wire [2:0] out1;
  wire [1:0] tmp_borrow;

  assign out1[0] = tmp_borrow[0] ;
  assign tmp_borrow[0] = ~in1[0] ;

  assign out1[1] = in1[1] ^ tmp_borrow[0];
  assign tmp_borrow[1] = ~in1[1] & tmp_borrow[0];

  assign out1[2] = in1[2] ^ tmp_borrow[1];


endmodule


// Flag sub-module
module QLK0RSAU04R2V1_FLAG_B1 (
                         peclk, peresetz, mck,
                         peri_write, sel_sir, we_ulhw, we_sdr,
                         se, count_clock, ccs2, dap, st_trg,
                         count_start_trg, sdr_load_timing, re_sdr,
                         seq_start, uart_stop,
                         d_shift, ack_timing, state_trans, seri_fin,
                         md_iic,
                         uart_recv, csi_slave_mode,
                         C_STOP, C_PARITY,
                         slc,
                         pcheck_on, odd_parity,
                         rxe, txe, sin_sel,
                         send_data_out,
                         trans_next_state,
                         fin_timing,
                         ovf, parity_out, pef,
                         fef, tsf, bff,
                         set_ovf, set_fef, set_pef,
                         clr_ovf, clr_fef, clr_pef,
                         borrow_register
                          );

input peclk;
input peresetz;
input mck;
input [2:0] peri_write;
input slc;
input sel_sir;
input we_ulhw;
input we_sdr;
input se;
input count_clock;
input ccs2;
input dap;
input count_start_trg;
input sdr_load_timing;
input re_sdr;
input seq_start;
input uart_stop;
input d_shift;
input ack_timing;
input state_trans;
input md_iic;
input uart_recv;
input csi_slave_mode;
input C_STOP;
input C_PARITY;
input pcheck_on;
input odd_parity;
input txe;
input rxe;
input sin_sel;
input send_data_out;
input trans_next_state;
input fin_timing;
input st_trg;
input seri_fin;

output ovf;
output parity_out;
output pef;
output fef;
output tsf;
output bff;
output set_ovf;
output set_fef;
output set_pef;
output clr_ovf;
output clr_fef;
output clr_pef;
output borrow_register;

wire orct_trg;
wire fect_trg;
wire pect_trg;
wire we_sir;
wire ge_recv_hold;
//wire data_recv_hold;
//wire ge_brow;
//wire dt_brow_reg;
reg borrow_register;
wire recv_hold;
wire clr_ovf;
wire ovr_err;
wire slave_err;
//wire data_ovf;
wire ge_ovf;
reg ovf;
wire ge_pari_check;
wire iic_ack_timing;
wire pcheck_timing;
wire p_src_data;
wire parity_out;
reg pari_check;
wire ge_pef;
wire pef_data;
reg pef;
wire ge_fef;
wire fef_data;
reg fef;
reg  tsf;
wire ge_tsf;
wire tsf_src;
//wire tsf_data;
wire set_sdff;  //wire set_bff;
wire clr_sdff;  //wire clr_bff;
wire ge_sdff;   //wire ge_bff;
reg  sdff;      //reg bff;
wire sdff_data; //wire bff_data;
wire bff;
wire recv_hold_data, ovf_data, pc_data;

// This is clear trigger assignment
assign orct_trg = peri_write[0];
assign pect_trg = peri_write[1];
assign fect_trg = peri_write[2];
// SIR register write signal
assign we_sir = sel_sir & we_ulhw;


//-------------------------------------------------------------------------------//
// borrow_register is receive data holding  //
//-------------------------------------------------------------------------------//

// make common gating signal of recv_hold, ovf, sdff
wire ge_flag1 = ge_recv_hold | ge_ovf | ge_sdff;

QLK0RSAU04R2V1_FLGDSEL1_B1 flgsel1(.recv_hold_data(recv_hold_data), .ge_recv_hold(ge_recv_hold), 
                                     .sdr_load_timing(sdr_load_timing), .st_trg(st_trg), .recv_hold(recv_hold),
                                   .ovf_data(ovf_data), .ge_ovf(ge_ovf), .set_ovf(set_ovf), .ovf(ovf),
                                   .sdff_data(sdff_data), .ge_sdff(ge_sdff), .clr_sdff(clr_sdff), .sdff(sdff));
       // recv_hold gating signal
assign ge_recv_hold =  (sdr_load_timing) // set timing on data receive
                       | (recv_hold & re_sdr)         // clear timing at read-out received data
                       | st_trg ;                     // clear timing at ST Stop trigger

// assign recv_hold_data = ge_recv_hold ? sdr_load_timing & ~st_trg : recv_hold;

always @( posedge peclk or negedge peresetz ) begin
  if(~peresetz)           borrow_register <= 1'b0;
//  else if (ge_recv_hold)  borrow_register <= recv_hold_data;
  else if (ge_flag1)      borrow_register <= recv_hold_data;
end
assign recv_hold = borrow_register;

//---------------------------------------------------------------------------------------//
// OVF flag share the 2 function, serial over-run error, and serial slave data-not-ready //
//---------------------------------------------------------------------------------------//
       // over-run error clear condition
assign clr_ovf = we_sir &  orct_trg;
       // over-run error set condition. It's cause by next data receive or write SDR at recv_hold=1
       //       and receive end timing and write sdr timing
assign ovr_err = (recv_hold & ((sdr_load_timing & ~re_sdr) | we_sdr)) | (sdr_load_timing & we_sdr);
       // OVF set condition (for CSI Slave Send Data un-ready Status)
assign slave_err = csi_slave_mode & count_start_trg & txe & ~sdff;
wire set_ovf = (ovr_err | slave_err) & ~st_trg;

// ovf flag data and gating signal
assign ge_ovf = set_ovf | clr_ovf;
// assign ovf_data = ge_ovf ? set_ovf : ovf;

always @(posedge peclk or negedge peresetz) begin
  if (~peresetz)        ovf <= 1'b0;
//  else if (ge_ovf)      ovf <= set_ovf;
  else if (ge_flag1)    ovf <= ovf_data;
end


//-----------//
// BFF flag  //
//-----------//
assign bff = sdff | recv_hold; // New BFF flag

assign set_sdff = txe & we_sdr & se;
assign clr_sdff = (count_start_trg     // send data load(SDR->SPR) timing
                   | (txe & fin_timing & (~ccs2 | (ccs2&dap)))  // Seq-send start timing
                   | st_trg) & sdff ;

// sdff gating and data signal
assign ge_sdff = (set_sdff | clr_sdff) ;
// assign sdff_data = ge_sdff ? ~clr_sdff : sdff; // clear is high priority

always @( posedge peclk or negedge peresetz ) begin
  if(~peresetz)      sdff <= 1'b0;
//  else if (ge_sdff)   sdff <=  ~clr_sdff;
  else if (ge_flag1) sdff <= sdff_data;
end



//--------------------------------------------------------------------//
// pari_check is parity check status register until data receive end  //
//--------------------------------------------------------------------//
wire fef_tmp_set,fef_tmp_clr,ge_fef_tmp, fef_tmp_data;
reg pari_check_data;
reg fef_tmp;

// make common gating signal of pari_check, pef, fef_tmp, fef
wire ge_pef_fef_common = mck|we_sir;
wire ge_flag2 = ge_pari_check | ge_pef_fef_common | ge_fef_tmp;

QLK0RSAU04R2V1_FLGDSEL2_B1 flgsel2(
 .pc_data(pc_data), .ge_pari_check(ge_pari_check), .pari_check_data(pari_check_data), .pari_check(pari_check),
 .pef_data(pef_data), .ge_pef_fef_common(ge_pef_fef_common), .ge_pef(ge_pef), .set_pef(set_pef), .pef(pef), 
 .fef_tmp_data(fef_tmp_data), .ge_fef_tmp(ge_fef_tmp), .fef_tmp_clr(fef_tmp_clr), .fef_tmp(fef_tmp),
 .fef_data(fef_data), .ge_fef(ge_fef), .set_fef(set_fef), .fef(fef));


// This is pari_check data signal (for Power Compiler extracting gating signal, avoiding logical complexity)
wire iic_ack_data = sin_sel & txe;
always@(iic_ack_timing or pcheck_timing or d_shift or
        iic_ack_data or parity_out or sin_sel or p_src_data or pari_check)
begin
  casex ({iic_ack_timing, pcheck_timing, d_shift}) //synopsys parallel_case
   3'b1xx: pari_check_data = iic_ack_data;
   3'b01x: pari_check_data = parity_out ^ sin_sel;
   3'b001: pari_check_data = p_src_data ^ pari_check;
   default: pari_check_data = 1'b0;
  endcase
end

wire pari_check_en = pcheck_on & rxe;

// this is ack timing for IIC mode
assign iic_ack_timing = md_iic & ack_timing & ~state_trans;
// this is parity check timing 
assign pcheck_timing = pari_check_en & C_PARITY & ~state_trans ;

// source data for parity check, receive->SIN, send->SOUT
assign p_src_data = rxe ? sin_sel : send_data_out;

// Parity data output signal(-> OUTCTL sub-module)
assign parity_out = (odd_parity ? ~pari_check : pari_check) & pcheck_on ;

// gating signal for pari_check
wire pari_initialize = count_start_trg | (fin_timing & seq_start);
assign ge_pari_check = d_shift | ((pcheck_timing | iic_ack_timing) & count_clock) | pari_initialize ;

// assign pc_data = ge_pari_check ? pari_check_data : pari_check;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     pari_check <= 1'b0;
//  else if (ge_pari_check)  pari_check <= pari_check_data;
  else if (ge_flag2)  pari_check <= pc_data;
end

//------------------------//
// PEF parity error flag  //
//------------------------//
wire src_pef = (fin_timing & (pari_check_en | md_iic)) & pari_check & count_clock;
wire set_pef = src_pef & ~st_trg ;
wire clr_pef = (we_sir & pect_trg) ;  // pef clear timing

assign ge_pef = src_pef | clr_pef ;
// assign pef_data = ge_pef_fef_common ? (ge_pef ? set_pef : pef) : pef; // set is high priority

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)                  pef <= 1'b0;
//   else if (ge_pef_fef_common)     pef <= pef_data;
  else if (ge_flag2)     pef <= pef_data;
end

//-----------------------------------------//
// Flaming Error Flag share for seq_start  //
//-----------------------------------------//
assign fef_tmp_set = ~sin_sel & ~trans_next_state & C_STOP & count_clock & uart_recv ;
assign fef_tmp_clr = count_start_trg ; // Clear only start timing
assign ge_fef_tmp = (fef_tmp_set | fef_tmp_clr);
// assign fef_tmp_data = ge_fef_tmp ? ~fef_tmp_clr : fef_tmp;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)             fef_tmp <= 1'b0;
//   else if (ge_fef_tmp)   fef_tmp <= ~fef_tmp_clr;
  else if (ge_flag2)   fef_tmp <= fef_tmp_data;
end

// fef check timing 1/2 Stop state
wire clr_fef;
wire set_fef_timing =  fin_timing & C_STOP & uart_recv & ~st_trg;
wire set_fef_src = ~sin_sel;
wire set_fef_suspend = fef_tmp ;
wire set_fef = ((slc == 1'b1) ? set_fef_src : set_fef_suspend) & set_fef_timing ;
assign clr_fef = (we_sir & fect_trg);

// gating signal for fef
assign ge_fef = set_fef | clr_fef;

// assign fef_data = ge_fef ? set_fef : fef ; 

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)    fef <= 1'b0;
//  else if (ge_pef_fef_common) fef <= fef_data;
  else if (ge_flag2) fef <= fef_data;
end

//----------//
// TSF flag //
//----------//
assign ge_tsf = count_start_trg | uart_stop | seri_fin | st_trg;
assign tsf_src = ~(uart_stop | seri_fin | st_trg) ; // clear is high priority, reduce redundant logic


always @(posedge peclk or negedge peresetz) begin
  if (~peresetz)       tsf <= 1'b0;
  else if (ge_tsf)     tsf <= tsf_src;
end


endmodule

module QLK0RSAU04R2V1_FLGDSEL1_B1( recv_hold_data, ge_recv_hold, sdr_load_timing, st_trg, recv_hold,
                                   ovf_data, ge_ovf, set_ovf, ovf,
                                   sdff_data, ge_sdff, clr_sdff, sdff);

output recv_hold_data;
input ge_recv_hold;
input sdr_load_timing;
input st_trg;
input recv_hold;
output  ovf_data;
input ge_ovf;
input set_ovf;
input ovf;
output sdff_data;
input ge_sdff;
input clr_sdff;
input sdff;

wire recv_hold_data = ge_recv_hold ? sdr_load_timing & ~st_trg : recv_hold;
wire ovf_data = ge_ovf ? set_ovf : ovf;
wire sdff_data = ge_sdff ? ~clr_sdff : sdff; // clear is high priority

endmodule

module QLK0RSAU04R2V1_FLGDSEL2_B1(
 pc_data, ge_pari_check, pari_check_data, pari_check,
 pef_data, ge_pef_fef_common, ge_pef, set_pef, pef, 
 fef_tmp_data, ge_fef_tmp, fef_tmp_clr, fef_tmp,
 fef_data, ge_fef, set_fef, fef);

output pc_data;
input  ge_pari_check;
input  pari_check_data;
input  pari_check;

output pef_data;
input  ge_pef_fef_common;
input  ge_pef;
input  set_pef;
input  pef;

output fef_tmp_data;
input  ge_fef_tmp;
input  fef_tmp_clr;
input  fef_tmp;

output fef_data;
input  ge_fef;
input  set_fef;
input  fef;

wire pc_data = ge_pari_check ? pari_check_data : pari_check;
wire pef_data = ge_pef_fef_common ? (ge_pef ? set_pef : pef) : pef; 
wire fef_tmp_data = ge_fef_tmp ? ~fef_tmp_clr : fef_tmp;
wire fef_data = ge_fef ? set_fef : fef ; 

endmodule


// INT sub-module
module QLK0RSAU04R2V1_INT_B1 (
                         peclk, peresetz,
                         count_start_trg,
                         md0, dap, csi_slave_mode,
                         last_state, seq_start, state_trans,
                         st_trg,
                         eoc, ovf, fef, pef, set_ovf, set_fef, set_pef,
                         clr_ovf, clr_fef, clr_pef,
                         se,
                         int_sig, eint );

input peclk;
input peresetz;
input md0;
input dap;
input csi_slave_mode;
input last_state;
input seq_start;
input state_trans;
input st_trg;
input se;
input count_start_trg;
input eoc;
input ovf;
input fef;
input pef;
input set_ovf;
input set_fef;
input set_pef;
input clr_ovf;
input clr_fef;
input clr_pef;

output int_sig;
output eint;

wire buf_emp;
wire t_end;
wire int_seri;
wire ge_int;
reg int_sig;
wire pre_eint ;
reg eint;
//
wire set_eint, clr_eint, ge_eint, data_eint;
wire int_sig_data;

wire ge_int_eint = ge_int | ge_eint;

// Serial function source of INT signal
assign buf_emp = count_start_trg | (last_state & seq_start & ~(csi_slave_mode & ~dap)); // buffer empty interrupt
assign t_end = last_state ;  // transfer end interrupt
wire eoc_mask = eoc & ((ovf&~clr_ovf) | (fef&~clr_fef) | (pef&~clr_pef)
                         | set_ovf | set_fef | set_pef);
assign int_seri = (md0 ? buf_emp : t_end) & state_trans & ~eoc_mask & ~st_trg; // Serial mode


// int_sig gating and data signal
assign ge_int = int_seri | int_sig;
//assign int_sig_data = int_seri & se;
//assign int_sig_data = ge_int ? int_seri & se : int_sig;


assign pre_eint = ( set_ovf | set_fef | set_pef ) & eoc;
assign set_eint = pre_eint;
assign clr_eint = ~set_eint & eint;
assign ge_eint = set_eint | clr_eint;
//assign data_eint = ge_eint ? set_eint : eint;

QLK0RSAU04R2V1_INTDSEL_B1 intdsel( .data_eint(data_eint), .ge_eint(ge_eint), .set_eint(set_eint),
                                   .eint(eint), 
                                   .int_sig_data(int_sig_data), .ge_int(ge_int), .int_seri(int_seri),
                                   .se(se), .int_sig(int_sig));
   
   
always @( posedge peclk or negedge peresetz ) begin
    if(~peresetz) begin
            int_sig <= 1'b0;
            eint <= 1'b0;
      end
    else if (ge_int_eint) begin
            int_sig <= int_sig_data;
            eint <= data_eint;
      end
end

endmodule

module QLK0RSAU04R2V1_INTDSEL_B1( data_eint, ge_eint, set_eint, eint,
                                  int_sig_data, ge_int, int_seri, se, int_sig );
output data_eint;
output int_sig_data;

input ge_eint;
input set_eint;
input eint;
input ge_int;
input int_seri;
input se;
input int_sig;

wire data_eint = ge_eint ? set_eint : eint;
wire int_sig_data = ge_int ? int_seri & se : int_sig;

endmodule


// OUTCTL sub-module
module QLK0RSAU04R2V1_OUTCTL_B1 (
                           count_start_trg, st_trg, s_trans, fin_timing,
                           last_state, seq_start,
                           N_START, N_SEND, N_PARITY, N_STOP,
                           C_IDLE, C_STOP,
                           trans_next_state,
                           sdr, count_register,
                           data_8bit,
                           dir, txe, md_iic, md_uart,
                           count_clock, sck_toggle,
                           parity_out, dap, ckp, ccs2, csi_slave_mode,
                           seri_dout_timing, seri_dout,
                           sck_timing, sck_data,
                           send_data_out );

input count_start_trg;
input st_trg;
input s_trans;
input fin_timing;
input last_state;
input seq_start;
input N_START;
input N_SEND;
input N_PARITY;
input N_STOP;
input C_IDLE;
input C_STOP;
input trans_next_state;
input [15:0] sdr;
input [15:0] count_register;

input data_8bit;
input dir;
input txe;
input md_iic;
input md_uart;
input count_clock;
input sck_toggle;
input parity_out;
input dap;
input ckp;
input ccs2;
input csi_slave_mode;

output seri_dout_timing;
output seri_dout;
output sck_timing;
output sck_data;
output send_data_out;

wire seri_dout_timing;
wire start_bit;
wire parity_bit;
wire stop_bit;
wire load_from_sdr;
wire [15:0] src_of_dout;
reg  msb_out;
reg  pre_seri_dout;
wire seri_dout;
wire sck_timing;
wire sck_data;

// Serial Data output timing
wire iic_default = (md_iic & fin_timing & ~seq_start); // This is IIC default value (SOUT = "H")
wire csi_slv_out = ~(csi_slave_mode & ~dap) & seq_start ;
assign seri_dout_timing  = (count_start_trg | (s_trans & (~last_state|csi_slv_out)) | iic_default) & ~st_trg ;
// Start bit output timing
assign start_bit = N_START;
// Parity bit output timing
assign parity_bit = N_PARITY;
// Stop bit output timing
assign stop_bit = N_STOP;

// At start timing, SDR data doesnot load SPR register, 
// So SOUT is load from SDR register at this timing.
assign load_from_sdr = (C_IDLE & N_SEND & ~seq_start) | (last_state & seq_start & ~(ccs2 & ~dap));

// Serial output data selector
assign src_of_dout = load_from_sdr ? sdr : count_register;

// MSB first output data selector // Remove data_9bit, 16bit
//always@(data_5bit or data_8bit or src_of_dout) begin
always@(data_8bit or src_of_dout) begin
  case(1'b1) //synopsys parallel_case
//    data_5bit:  msb_out = src_of_dout[4];
    data_8bit:  msb_out = src_of_dout[7];
    default:  msb_out = src_of_dout[6];
  endcase
end

// MSB/LSB selector
wire send_data_out = dir ? src_of_dout[0] : msb_out;

// IIC/SCIF output data at stop state
wire stop_data = md_iic ? txe : 1'b1;

// data output
always@(start_bit or parity_bit or stop_bit or iic_default or
        parity_out or stop_data or send_data_out ) begin
  casex ({start_bit, parity_bit, stop_bit, iic_default})
    4'b1xxx: pre_seri_dout = 1'b0;
    4'bx1xx: pre_seri_dout = parity_out;
    4'bxx1x: pre_seri_dout = stop_data;
    4'b0001: pre_seri_dout = 1'b1;
    default: pre_seri_dout = send_data_out;
  endcase
end

assign seri_dout =  pre_seri_dout;

//++++====++++====++++==== SCKO_SRC ++====++++====++++====++++====+//
       // SCK toggle timing

wire   mask_stop = ((N_STOP & trans_next_state & ~dap) | C_STOP) & ~(seq_start & fin_timing);
wire   sck_tim_pre = count_start_trg |        // start timing
                     (count_clock & ~( ((~dap & fin_timing&(~seq_start|ccs2) ) | mask_stop) & ~md_iic));
assign sck_timing = sck_tim_pre & ~md_uart & ~st_trg ;
assign sck_data = (dap ^ ckp) ? ~sck_toggle : sck_toggle;

endmodule



module QLK0RSAU04R2V1_FUNC_C0 (
                    // INPUT
                    peclk, pclkrw, peresetz,
                    mck,
                    we_ulhw, sel_sdr, sel_sir, re_sdr, peri_write,
                    se, md0,
                    dap, ckp,
                    count_start_trg, 
                    count_clock, b_count_clock,
                    md_csi, md_uart, md_iic,
                    eoc,
                    dls, slc, dir, rxe, txe,
                    pstate_on, pcheck_on, odd_parity,
                    no_stopbit, ccs2,
                    data_7bit, data_8bit, data_9bit,
                    sin_level, st_trg, start_slave,
                    sin_latch,
                    scki_thr,
                    // OUTPUT
                    spr,sdr_read,
                    baud_borrow, csi_slave_stop,
                    int_sig, eint,
                    seri_fin_out,
                    pef,fef,bff,ovf,tsf,
                    seri_dout_timing, seri_dout,
                    sck_timing, sck_data,
                    fast_mode, sin_direct,
                    scanmode, async_csi, ack_timing
                   );

input peclk;
input pclkrw;
   
input peresetz;

input mck;

input we_ulhw;
input sel_sdr;
input sel_sir;
input re_sdr;
input [15:0] peri_write;

//input brow_in_cas;
input se;
input md0;
input count_start_trg;
input count_clock;
input b_count_clock;

input md_csi;
input md_uart;
input md_iic;
input eoc;
input dap;
input ckp;
input [1:0] dls;
input [1:0] slc;
input dir;
input rxe;
input txe;
//input txrx_on;
input pstate_on;
input pcheck_on;
input odd_parity;
input no_stopbit;
input ccs2;
input data_7bit;
input data_8bit;
input data_9bit;
input sin_level;
input sin_latch;
input sin_direct;
input st_trg;
input start_slave;
input scki_thr;
input scanmode;
input async_csi;
   
   
output [15:0] spr;
output [15:0] sdr_read;
output baud_borrow;
output csi_slave_stop;
output int_sig;
output eint;
output pef;
output fef;
output bff;
output ovf;
output tsf;
output seri_dout_timing;
output seri_dout;
output seri_fin_out;
output sck_timing;
output sck_data;
output fast_mode;
output ack_timing;

// Counter
wire [15:0] spr;
wire baud_borrow;
wire recv_data;
wire [15:0] sdr;
wire [15:0] sdr_read;
wire we_sdr;
wire ld_spr_to_sdr;
wire load_next_s_data;
wire csi_slave_ld_mask;
wire d_shift;

// Overflow
wire borrow_register;
wire bff;

// FSM
wire C_IDLE;
wire C_START;
wire C_SEND;
wire C_PARITY;
wire C_STOP;
wire N_START;
wire N_SEND;
wire N_PARITY;
wire N_STOP;

wire seq_start; // Seq_start is working on except of UART & rxe
wire trans_next_state; // This is state transfer timing on transmission
wire state_trans; // This is current_state gating signal
wire s_trans;
wire sck_toggle; // This is data shift/capture timing signal
wire last_state; // This is the status of Last state on 1 data
wire fin_timing;
wire sdr_load;
wire seri_fin;
wire seri_fin_out;
//wire uart_stop;
wire st_counter_end;
wire async_clk;


// Sout
wire seri_dout_timing; // serial SOUT change timing
wire seri_dout; // serial SOUT next data
wire send_data_out;

// Scko
wire sck_timing;   // sck toggle timing;
wire sck_data;     // sck data

// Int
wire int_sig;

// Flag
wire ovf;
wire pef;
wire ack_timing;
wire parity_out;
wire fef = 1'b0;
wire tsf;
wire sdr_load_timing;
//wire uart_recv;
wire set_ovf, set_pef, clr_ovf, clr_pef;

// I/O control
// wire data_out;		// not drive anything : by yaam

// Common Signal
//assign uart_recv = md_uart & rxe;
//assign seri_fin_out = seri_fin | uart_stop;
assign seri_fin_out = seri_fin;

// SIN Signal Selector
wire csi_slave_mode = md_csi & ccs2;

reg sin_sel;
//always@(sin_latch or sin_level or md_uart or csi_slave_mode or ssc)
//  case ( (md_uart|csi_slave_mode) & ~ssc[0] )
//    1'b1    : sin_sel = sin_latch;
//    default : sin_sel = sin_level;
//  endcase
always@(sin_latch or sin_level or csi_slave_mode or async_csi)
  case ( (csi_slave_mode) & ~async_csi )
    1'b1    : sin_sel = sin_latch;
    default : sin_sel = sin_level;
  endcase

assign load_next_s_data = sdr_load & txe; // <- SEQ transfer load next SDR data
assign sdr_load_timing = fin_timing & rxe;
assign ld_spr_to_sdr = sdr_load_timing & ~st_trg ;
assign recv_data = ~rxe | sin_sel;
assign we_sdr = we_ulhw & sel_sdr;

assign async_clk =  (dap ^ ckp ^ scki_thr) ;

reg asclk;
always@(scanmode or peclk or async_clk or async_csi)
  case (scanmode|~async_csi) // synopsys infer_mux 
    1'b1 : asclk = peclk;
    default : asclk = async_clk;
  endcase

wire asresz = (scanmode | ~async_csi) ? peresetz : se ;

//++++====++++====++++====  COUNTER   ====++++====++++====++++====//
QLK0RSAU04R2V1_CNT_C0 cnt (.peclk(peclk), .peresetz(peresetz),
                     .data_8bit(data_8bit), .data_7bit(data_7bit), .data_9bit(data_9bit),
                     .recv_data(recv_data), .dir(dir),
                     .csi_slave_ld_mask(csi_slave_ld_mask),
                     .count_start_trg(count_start_trg), .load_next_s_data(load_next_s_data),
                     .se(se), .d_shift(d_shift), .b_count_clock(b_count_clock),
                     .sdr(sdr), .spr(spr), .baud_borrow(baud_borrow),
                     .sin_direct(sin_direct),
                     .asclk(asclk), .async_csi(async_csi),
                     .fast_mode(fast_mode), .rxe(rxe) );

//++++====++++====++++====  DATA_REG   ====++++====++++====++++====//
QLK0RSAU04R2V1_DREG_C0 dreg ( .peclk(peclk), .pclkrw(pclkrw), .peresetz(peresetz),
                        .we_sdr(we_sdr), 
                        .se(se), .ccs2(ccs2),
                        //.baud_count_en(baud_count_en),
                        .ld_spr_to_sdr(ld_spr_to_sdr), .peri_write(peri_write),
                        .spr(spr), .sdr(sdr), .sdr_read(sdr_read), .fast_mode(fast_mode),
                        .async_csi(async_csi)
                        );

//++++====++++====++++====   FSM    ++====++++====++++====++++====//
QLK0RSAU04R2V1_STATECTL_C0 statectl(
                              .peclk(peclk), .peresetz(peresetz), 
                              .count_start_trg(count_start_trg), .st_trg(st_trg), .count_clock(count_clock),
                              .md_csi(md_csi), .md_uart(md_uart), 
                              //.uart_recv(uart_recv),
                              .txe(txe), .rxe(rxe), 
                              .pstate_on(pstate_on), .no_stopbit(no_stopbit),
                              .dls(dls), .slc(slc), .ccs2(ccs2), .dap(dap), .fast_mode(fast_mode),
                              .we_sdr(we_sdr), .tsf(tsf), .start_slave(start_slave),
                              .csi_slave_mode(csi_slave_mode),
                              .C_IDLE(C_IDLE), .C_START(C_START), .C_SEND(C_SEND), .C_PARITY(C_PARITY), .C_STOP(C_STOP),
                              .N_START(N_START), .N_SEND(N_SEND), .N_PARITY(N_PARITY), .N_STOP(N_STOP),
                              .d_shift(d_shift), .state_trans(state_trans), .s_trans(s_trans),
                              .sck_toggle(sck_toggle),
                              .trans_next_state(trans_next_state), .last_state(last_state),
                              .fin_timing(fin_timing), .sdr_load(sdr_load),
                              .seri_fin(seri_fin), .seq_start(seq_start), .ack_timing(ack_timing),
                              .csi_slave_stop(csi_slave_stop),
                              .csi_slave_ld_mask(csi_slave_ld_mask),
                              
                              .asclk(asclk), .async_csi(async_csi), .st_counter_end(st_counter_end) );

//++++====++++====++++==== SOUT_SRC ++====++++====++++====++++====++//
//++++====++++====++++==== SCKO_SRC ++====++++====++++====++++====+//
QLK0RSAU04R2V1_OUTCTL_C0 outctl(
                           .count_start_trg(count_start_trg), .st_trg(st_trg), .s_trans(s_trans), .fin_timing(fin_timing),
                           .last_state(last_state), .seq_start(seq_start),
                           .N_START(N_START), .N_SEND(N_SEND), .N_PARITY(N_PARITY), .N_STOP(N_STOP),
                           .C_IDLE(C_IDLE), .C_STOP(C_STOP),
                           .trans_next_state(trans_next_state),
                           .sdr(sdr), .count_register(spr),
                           .data_8bit(data_8bit), .data_9bit(data_9bit),
                           .dir(dir), .txe(txe),
                           .md_iic(md_iic), .md_uart(md_uart),
                           .count_clock(count_clock), .sck_toggle(sck_toggle),
                           .parity_out(parity_out), .dap(dap), .ckp(ckp), .ccs2(ccs2), .csi_slave_mode(csi_slave_mode),
                           .seri_dout_timing(seri_dout_timing), .seri_dout(seri_dout),
                           .sck_timing(sck_timing), .sck_data(sck_data),
                           .send_data_out(send_data_out) );

//++++====++++====++++====   INT    ++====++++====++++====++++====//
QLK0RSAU04R2V1_INT_C0 intctl(
                         .peresetz(asresz),
                         .count_start_trg(count_start_trg),
                         .md0(md0), .dap(dap), .csi_slave_mode(csi_slave_mode),
                         .last_state(last_state), .seq_start(seq_start), .state_trans(state_trans),
                         .st_trg(st_trg),
                         .eoc(eoc), .ovf(ovf), .pef(pef),
                         .set_ovf(set_ovf), .set_pef(set_pef),
                         .clr_ovf(clr_ovf), .clr_pef(clr_pef),
                         .se(se), 
                         .int_sig(int_sig), .eint(eint),
                         .asclk(asclk), .st_counter_end(st_counter_end), .async_csi(async_csi),
                         .async_clk(async_clk), .scanmode(scanmode) ); // for fault coverage


//++++====++++====++++====   EINT    ++====++++====++++====++++====//
//QLK0RSAU04R2V1_EINT_C0 seintctl(
//                         .peclk(peclk), .peresetz(peresetz),
//                         .set_ovf(set_ovf), .set_pef(set_pef),
//                         .eoc(eoc), .eint(eint) );

//++++====++++====++++====   FLAG   ++====++++====++++====++++====//
QLK0RSAU04R2V1_FLAG_C0 flag (
                       .peclk(peclk), .peresetz(peresetz), .mck(mck),
                       .peri_write(peri_write[2:0]), .sel_sir(sel_sir), .we_ulhw(we_ulhw), .we_sdr(we_sdr),
                       .se(se), .count_clock(count_clock), .st_trg(st_trg),
                       .count_start_trg(count_start_trg), .ccs2(ccs2), .dap(dap),
                       .sdr_load_timing(sdr_load_timing), .re_sdr(re_sdr),
                       .seq_start(seq_start), 
                       .d_shift(d_shift), .ack_timing(ack_timing), .state_trans(state_trans),
                       .md_iic(md_iic),
                       .csi_slave_mode(csi_slave_mode), .seri_fin(seri_fin),
                       .pcheck_on(pcheck_on), .odd_parity(odd_parity),
                       .txe(txe), .rxe(rxe), .sin_sel(sin_sel), .send_data_out(send_data_out),
                       .fin_timing(fin_timing),
                       .ovf(ovf), .parity_out(parity_out), .pef(pef),
                       .tsf(tsf), .bff(bff),
                       .set_ovf(set_ovf), .set_pef(set_pef),
                       .clr_ovf(clr_ovf), .clr_pef(clr_pef),
                       .borrow_register(borrow_register),
                       .asclk(asclk), .async_csi(async_csi), .st_counter_end(st_counter_end)
                        );

//++++====++++====++++====+ I/O  CNT +====++++====++++====++++====+//
// assign data_out = txe ;  		// not drive anything : by yama

endmodule

// This is Counter(SPR) module
module QLK0RSAU04R2V1_CNT_C0( peclk, peresetz,
                        data_8bit, data_7bit, data_9bit,
                        recv_data,
                        dir,
                        csi_slave_ld_mask,
                        count_start_trg, load_next_s_data,
                        se, d_shift, b_count_clock,
                        sdr, spr, baud_borrow,
                        asclk, async_csi, sin_direct,
                        fast_mode, rxe );

input peclk;
input peresetz;

input data_8bit;
input data_7bit;
input data_9bit;
input recv_data;
input dir;
input csi_slave_ld_mask;
input count_start_trg;
input load_next_s_data;
input se;
input d_shift;
input b_count_clock;
input [15:0] sdr;
input     asclk;
input     async_csi;
input sin_direct;
input fast_mode;
input rxe;

output [15:0] spr;
output baud_borrow;


wire shift9_lsb;
wire shift8_lsb;
wire shift7_lsb;
wire shift6_lsb;
wire shift5_lsb;
wire shift9_msb;
wire shift8_msb;
wire shift7_msb;
wire shift6_msb;

wire [15:0] shift_data;
wire [15:9] next_value;
reg [15:0] load_data;
wire borrow2;
wire baud_borrow;
reg [15:0] count_register;
wire load_trg_lb;
wire load_trg_ub;
wire ge_count_register_0;
//wire ge_count_register_1;
wire ge_count_register_2;
wire ge_count_register_3;


// Shift/Capture function  all shift condition
wire recv_data_sel = fast_mode & rxe ? sin_direct : recv_data;

assign shift9_lsb = (data_9bit & recv_data_sel) ;
assign shift8_lsb = (data_9bit & count_register[8]) | (data_8bit & recv_data_sel);
assign shift7_lsb = (~data_7bit & count_register[7]) | (data_7bit & recv_data_sel);
assign shift6_lsb = count_register[6];
assign shift5_lsb = count_register[5];
assign shift9_msb = data_9bit & count_register[7];
assign shift8_msb = ~data_7bit & count_register[6];
assign shift7_msb = count_register[5];
assign shift6_msb = count_register[4];

// Generate bit8-0 shift data
assign shift_data[8:0] = dir ? {shift9_lsb, shift8_lsb, shift7_lsb, shift6_lsb, shift5_lsb, count_register[4:1]}  // LSB first
                             : {shift9_msb, shift8_msb, shift7_msb, shift6_msb, count_register[3:0], recv_data_sel};  // MSB first

// Generate bit15-9 shift data
assign shift_data[15:9] = 7'h00;
   
   
// Borrow signal (bit separated)
wire tmp_borrow2 ;

QLK0RSAU04R2V1_DEC3_C0 dec3_1 (.borrow(tmp_borrow2), .out1(next_value[11:9]),  .in1(count_register[11:9]) );
QLK0RSAU04R2V1_DEC4_C0 dec4_2 (.out1(next_value[15:12]), .in1(count_register[15:12]));

assign borrow2 = tmp_borrow2 ;                     // This is borrow signal count_register[11:9]-1

// Borrow Signal (Baud-Rate Counter), This is used for Timer and Serial
assign baud_borrow = (count_register[15:9]==7'h00);

// SPR Register value inverted on capture mode
assign spr        = count_register ;

// Load SDR/FFFFH trigger for SPR[8:0]
assign load_trg_lb  = ((count_start_trg & ~csi_slave_ld_mask)    // <- This is Serial        imer Start Condition
                                                                 //    csi_slave_ld_mask is refered to STATECTL
                       | load_next_s_data) & se;                 // <- This is Serial Seq-Send Condition

// Load SDR/FFFFH trigger for SPR[15:9]
assign load_trg_ub  = ((count_start_trg & ~csi_slave_ld_mask)     // This is Serial        imer Start Condition
                       | (baud_borrow & b_count_clock)            // This is Serial baud-rate Conter=00H Condition;
                       ) & se;   // <- This is Serial Se-Send Condition


// Load data selector // Remove Bit9
always@(load_trg_lb or sdr or shift_data) begin
  case ({load_trg_lb}) // synopsys parallel_case
    1'b0:  load_data[8:0] = shift_data[8:0];  // load shift/recv for serial mode
    default: load_data[8:0] = sdr[8:0];         // load sdr[8:0] for non capture mode
  endcase
end

// Remove data_16bit
always@(load_trg_ub or sdr or next_value) begin
  case ({load_trg_ub}) // synopsys parallel_case
    1'b1:  load_data[15:9] = sdr[15:9];         // load sdr[8:0] for non capture mode
    default: load_data[15:9] = next_value[15:9];  // load decrement value
  endcase
end

assign ge_count_register_0 = d_shift | load_trg_lb | async_csi ;               // Gating for bit[7:0]
assign ge_count_register_2 = load_trg_ub | b_count_clock;                // Gating for bit[11:9]
assign ge_count_register_3 = load_trg_ub | (borrow2 & b_count_clock);    // Gating for bit[15:12]

// Counter/ShiftRegister
always @(posedge asclk or negedge peresetz) begin
    if (~peresetz)                 count_register[8:0] <= 9'h1ff ;
    else if (ge_count_register_0)  count_register[8:0] <= load_data[8:0];
end

always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[11:9] <= 3'h7 ;
    else if (ge_count_register_2)  count_register[11:9] <= load_data[11:9];
end

always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[15:12] <= 4'hf ;
    else if (ge_count_register_3)  count_register[15:12] <= load_data[15:12];
end

endmodule

// 4bit Decrement Module
module QLK0RSAU04R2V1_DEC4_C0 (out1, in1);
  output [3:0] out1;
  input  [3:0] in1;

  wire [3:0] out1;
  wire [2:0] tmp_borrow;

  assign out1[0] = tmp_borrow[0] ;
  assign tmp_borrow[0] = ~in1[0] ;

  assign out1[1] = in1[1] ^ tmp_borrow[0];
  assign tmp_borrow[1] = ~in1[1] & tmp_borrow[0];

  assign out1[2] = in1[2] ^ tmp_borrow[1];
  assign tmp_borrow[2] = ~in1[2] & tmp_borrow[1];

  assign out1[3] = in1[3] ^ tmp_borrow[2];

endmodule

// 3bit Decrement Module
module QLK0RSAU04R2V1_DEC3_C0 (borrow, out1, in1);
  output borrow;
  output [2:0] out1;
  input  [2:0] in1;

  wire borrow;
  wire [2:0] out1;
  wire [1:0] tmp_borrow;

  assign out1[0] = tmp_borrow[0] ;
  assign tmp_borrow[0] = ~in1[0] ;

  assign out1[1] = in1[1] ^ tmp_borrow[0];
  assign tmp_borrow[1] = ~in1[1] & tmp_borrow[0];

  assign out1[2] = in1[2] ^ tmp_borrow[1];
  assign borrow = ~in1[2] & tmp_borrow[1];

endmodule


// Data Register (SDR)
module QLK0RSAU04R2V1_DREG_C0(
                         peclk, pclkrw, peresetz,
                         we_sdr, ccs2,
                         se,
                         ld_spr_to_sdr, peri_write,
                         spr, sdr, sdr_read, fast_mode, async_csi
                         );

input peclk;
input pclkrw;  
input peresetz;
input we_sdr;
input ccs2;
input se;
input ld_spr_to_sdr;
input [15:0] peri_write;
input [15:0] spr;
input     async_csi;
   
output [15:0] sdr;
output [15:0] sdr_read;
output     fast_mode;
   
wire apb_wr_en;
wire mask_sdr_h;
wire ge_sdr;
//reg [6:0] sdr_data_h;
reg [8:0] sdr_data_l;
reg [6:0] sdr_h;
reg [8:0] sdr_l;
   
wire [15:0] sdr_read;
wire [15:0] sdr = {sdr_h, sdr_l};
   
// SDR Write Signal (masked by capture mode)
assign apb_wr_en = we_sdr;
// APB Write Mask signal for baud-rate counter(SDR[15:9])
assign mask_sdr_h = se ;  // & baud_count_en;
// SDR gating signal (APB write, capture trigger, Serial Receive)
assign ge_sdr = apb_wr_en | ld_spr_to_sdr ;

// SDR Write data for SDR[8:0]
always@(apb_wr_en or peri_write or spr) begin
  if (apb_wr_en) sdr_data_l[8:0] = peri_write[8:0];  // APB write
  else           sdr_data_l[8:0] = spr[8:0];         // Capture and Serial Receive
end
   
// SDR[15:9]
always @(posedge pclkrw or negedge peresetz) begin
    if (~peresetz)          sdr_h <= 7'h00;
    else if (~se&apb_wr_en) sdr_h <= peri_write[15:9];
end
   
// SDR[7:0]
always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)    sdr_l <= 9'h000;
    else if (ge_sdr)  sdr_l <= sdr_data_l;
end

// This is SDR read-out value
assign sdr_read[15:9] = mask_sdr_h ? 7'h00 : sdr_h; // Baud-rate doesn't read out while SE=1
assign sdr_read[8:0] = async_csi ? spr[8:0] : sdr_l;
   
wire fast_mode = ((sdr_h == 7'h00)&~ccs2) | async_csi;
   
   
endmodule

// FSM Controller
module QLK0RSAU04R2V1_STATECTL_C0 (
                              peclk, peresetz,
                              count_start_trg, st_trg, count_clock,
                              md_csi, md_uart, 
                              txe, rxe, 
                              pstate_on, no_stopbit,
                              dls, slc, ccs2, dap, fast_mode,
                              we_sdr, tsf, start_slave, csi_slave_mode,
                              C_IDLE, C_START, C_SEND, C_PARITY, C_STOP,
                              N_START, N_SEND, N_PARITY, N_STOP,
                              d_shift, state_trans, s_trans,
                              sck_toggle,
                              trans_next_state, last_state,
                              fin_timing, sdr_load,
                              seri_fin, seq_start, ack_timing,
                              csi_slave_stop, csi_slave_ld_mask,
                              
                              asclk, async_csi, st_counter_end  );

input  peclk;
input  peresetz;
//input  se;
input  count_start_trg;
input  st_trg;
input  count_clock;
input  md_uart;
input  md_csi;
input  txe;
input  rxe;
//input  sin_sel;
input  pstate_on;
input  no_stopbit;
input [1:0] dls;
input [1:0] slc;
input  ccs2;
input  dap;
input  we_sdr;
input  tsf;
input  start_slave;
input  csi_slave_mode;
input fast_mode;
input asclk;
input async_csi;
   
output C_IDLE;
output C_START;
output C_SEND;
output C_PARITY;
output C_STOP;
output N_START;
output N_SEND;
output N_PARITY;
output N_STOP;
output d_shift;
output sck_toggle;
output state_trans;
output s_trans;
output trans_next_state;
output last_state;
output fin_timing;
output sdr_load;
output seri_fin;
output seq_start;
output ack_timing;
output csi_slave_stop;
output csi_slave_ld_mask;
//output uart_stop;
output st_counter_end;
   
// State definition
parameter IDLE   = 3'b000;
parameter START  = 3'b111;
parameter SEND   = 3'b101;
parameter PARITY = 3'b010;
parameter STOP   = 3'b110;

wire C_IDLE;
wire C_START;
wire C_SEND;
wire C_PARITY;
wire C_STOP;
wire N_START;
wire N_SEND;
wire N_PARITY;
wire N_STOP;
//wire uart_stop;
wire state_trans;
wire d_shift;
wire d_shift_normal;
reg  d_shift_delay;

wire last_state;
wire fin_timing;
wire sdr_load;
wire seri_fin;
reg trans_next_state;
reg [2:0] current_state;
reg [2:0] next_state;
wire st_counter_end;
wire [3:0] data_length;
reg  [1:0] stop_length;
wire dl_set;
wire [3:0] st_load_val;
wire load_stcnt;
wire run_stcnt;
wire [3:0] next_value;
reg [3:0] next_st_counter;
reg [3:0] st_counter;
wire ge_st_counter;
wire ge_seq_start;
reg seq_start;
wire ge_trans_next;
wire csi_slave_stop;
wire ge_dshift;
wire trans_next_data;
wire d_shift_data;
wire trans_next_set; 
wire d_shift_clr;
wire seq_start_clr;
wire seq_start_data;

// State Decode
assign C_IDLE   = (current_state != START) & (current_state != SEND) & (current_state != PARITY) & (current_state != STOP);
assign C_START  = (current_state == START);
assign C_SEND   = (current_state == SEND);
assign C_PARITY = (current_state == PARITY);
assign C_STOP   = (current_state == STOP);
assign N_START  = (next_state == START);
assign N_SEND   = (next_state == SEND);
assign N_PARITY = (next_state == PARITY);
assign N_STOP   = (next_state == STOP);

// Make common gating signal for seq_start, d_shift_delay, trans_next_state
wire ge_common = ge_trans_next | ge_dshift | ge_seq_start;
QLK0RSAU04R2V1_STATDSEL_C0 statdsel(
    .trans_next_data(trans_next_data), .ge_trans_next(ge_trans_next), .trans_next_set(trans_next_set),
    .trans_next_state(trans_next_state),
    .d_shift_data(d_shift_data), .ge_dshift(ge_dshift), .d_shift_clr(d_shift_clr), .d_shift_delay(d_shift_delay),
    .seq_start_data(seq_start_data), .ge_seq_start(ge_seq_start), .seq_start_clr(seq_start_clr),
    .seq_start(seq_start));

// CSI Slave mode(dap=1) signal
wire   csi_slave_dap1 = csi_slave_mode & dap;

// This is load_trg(SDR->SPR) mask signal (dap=1)
//  SCKI      ~~~~~~~~~~~~~~|________|~~~~~~~~~|______
//                   ________________ ________________
//  SIN       XXXXXXX________________X________________
//                          O
//          This is 1st clock edge of CSI Slave.
//          So load_trg(count_start_trg) is triggered, but in this transmission format,
//           SAU capture 1st receive bit.
wire   csi_slave_ld_mask = (csi_slave_dap1 & ~txe & rxe)   // mask start load_trig by csi slave dap=1
                           | (csi_slave_mode & txe & seq_start); // mask seq-start load_trg by csi slave
                           //| (uart_recv & tsf);            // mask load_trig by falling SIN (avoiding over-write SPR)

// This is CSI slave start signal at 1st SCKI edge in the case of no writing send data.
wire   csi_slave_dap1_start = csi_slave_dap1 & ~tsf & start_slave;

// This is CSI slave stop process at dap=0 
//      SCKI   ________|~~~~~~~~~~~~~~~~~~~~~
// state_trans ________|~~~~|________________
//                        ^^^ Generate this timing
//             __________ __ ________________
//      state  ____S_____XS_X___I____________
assign csi_slave_stop = csi_slave_mode & ~dap & last_state & trans_next_state;

// This is gating signal for trans_next_state register
//assign ge_trans_next = (count_start_trg | count_clock | csi_slave_stop | st_trg) & se;

// This is State transfer, Data Shift control register
//      brate        ______|~|_____|~|_____|~|_____|~|_____|~|_____|~|_____|~|_____
//  trans_next_state ________|~~~~~~~|_______|~~~~~~~|_______|~~~~~~~|_______|~~~~~
//                           O       X       O       X       O       X       O
//                      O:Data Shift/Capture Timing
//                      X:State Transfer Timing

//wire trans_next_data;
assign trans_next_set = (~state_trans | csi_slave_dap1_start) & ~st_trg ;
assign ge_trans_next = (count_start_trg | count_clock | st_trg) ;
//assign  trans_next_data = ge_trans_next ? trans_next_set : trans_next_state;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)           trans_next_state <= 1'b0;
//   else if (ge_trans_next)  trans_next_state <= trans_next_set;
  else if (ge_common)       trans_next_state <= trans_next_data;
end

// 2 stop timing on UART receive function(Start by noise, Stop)
//    1.   SIN   ~~~~~~|______|~~~~~~~~~~~~~~~~~~~~
//      1/2Brate ______|_________|________|________
//               IDLE  X Start   X IDLE
//    2.1/2Brate ____|______|______|______|______
//                   X Parity      X Stop X Idle
//wire uart_stop_pre = uart_recv & ~trans_next_state & ((C_START & sin_sel) | (C_STOP & st_counter_end));
//assign uart_stop = uart_stop_pre & count_clock;

// source of state transition timing (Normal State transition)
//assign s_trans = (trans_next_state | uart_stop_pre) & count_clock;
assign s_trans = trans_next_state & count_clock;

// State transition signal
assign state_trans = count_start_trg | s_trans | st_trg ;

// Data Shift/Capture Timing
assign d_shift_normal = (~trans_next_state & C_SEND & count_clock) | csi_slave_dap1_start;

wire d_shift_set = d_shift_normal;
assign d_shift_clr = st_trg | d_shift_delay;
assign ge_dshift = d_shift_set | d_shift_clr;
//assign d_shift_data = ge_dshift ? ~d_shift_clr : d_shift_delay;

always@(posedge peclk or negedge peresetz)
  if (~peresetz)       d_shift_delay <= 1'b0;
//   else if (ge_dshift)  d_shift_delay <= ~d_shift_clr;
  else if (ge_common) d_shift_delay <= d_shift_data;

wire csi_master = ~ccs2 & md_csi & ~fast_mode;
assign d_shift = csi_master ? d_shift_delay : d_shift_normal;

// SCKO Toggle Timing
wire   sck_toggle = (~trans_next_state & count_clock) | csi_slave_dap1_start; // add for SCKO

// This is Serial Last State
assign last_state = (C_SEND & st_counter_end & ~pstate_on & no_stopbit) | // finish on SEND state
                    (C_PARITY & no_stopbit) |                             // finish on PARITY state
                    (C_STOP & st_counter_end) ;                           // finish on STOP state

// This is Serial Finish timing
assign fin_timing = last_state & state_trans;
// This is SDR->SPR load signal for Seq-send
assign sdr_load = fin_timing & seq_start;
// This is the end of serial
assign seri_fin = fin_timing & (~seq_start | (ccs2 & ~dap));

//===========================//
//   Next State combination  //
//===========================//
always@(count_start_trg or st_counter_end or st_trg or
        md_uart or pstate_on or no_stopbit or
        seq_start or ccs2 or dap or
        C_START or C_SEND or C_PARITY or C_STOP) begin
  next_state = IDLE;

  // Stop for write ST register
  if (st_trg)  begin
    next_state = IDLE;
  end
  else begin
    // Normal State Transition
    if (count_start_trg) begin
       if   (md_uart) next_state = START;   // IDLE -> START
       else           next_state = SEND;    // IDLE -> SEND
    end

    if (C_START) begin
      //if (uart_recv & sin_sel & ~trans_next_state)  next_state = IDLE;  // START -> IDLE
      //else                                          next_state = SEND;  // START -> SEND
      next_state = SEND;  // START -> SEND
    end

    if (C_SEND) begin
      if (st_counter_end) begin
        if (pstate_on)         next_state = PARITY; // SEND -> PARITY
        else if (~no_stopbit)  next_state = STOP;   // SEND -> STOP
        else if (seq_start & ~(ccs2 & ~dap)) begin
          //if (md_uart)         next_state = START;  // SEND -> START
          //else                 next_state = SEND;   // SEND -> SEND(next flame)
          next_state = SEND;   // SEND -> SEND(next flame)
        end
        else                   next_state = IDLE;   // SEND -> IDLE
      end
      else                     next_state = SEND;   // SEND -> SEND(continue transfer)
    end

    if (C_PARITY) begin
      if (~no_stopbit)       next_state = STOP;    // PARITY -> STOP
      else if (seq_start & ~(ccs2 & ~dap)) begin
        //if (md_uart)         next_state = START;   // SEND -> START
        //else                 next_state = SEND;    // SEND -> SEND(next flame)
        next_state = SEND;    // SEND -> SEND(next flame)
      end
      else                   next_state = IDLE;    // PARITY -> IDLE    
    end

    if (C_STOP) begin
      if (st_counter_end) begin
        if (seq_start & ~(ccs2 & ~dap)) begin
          if (md_uart)           next_state = START;  // STOP -> START
          else                   next_state = SEND;   // STOP -> SEND
        end
        else                     next_state = IDLE;   // STOP -> IDLE
      end
      else                       next_state = STOP;   // STOP -> STOP
    end
  end

end

// This is the FSM register
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        current_state <= IDLE;
  else if (state_trans) current_state <= next_state;
end

// Data length Counter/ Stop bit length Counter
//assign st_counter_end = ~|st_counter;
assign st_counter_end = async_csi ? (st_counter == 3'b001) : ~|st_counter;

// Data length Decoder
assign data_length = (dls == 2'b01) ? 4'b1000 : {2'b01,dls};

// Stop bit length Decoder
always@(slc) begin
  case (slc) //synopsys parallel_case
    2'b10 : stop_length = 2'b01;
    2'b11 : stop_length = 2'b10;
    default: stop_length = 2'b00;
  endcase
end


// Data Length Load Timing (IDLE->SEND, START->SEND, SEND->SEND, STOP->SEND, PARITY->SEND)
assign dl_set = async_csi ? ~tsf : N_SEND;

// This is the select signal of st_counter load value
assign st_load_val = dl_set ? data_length : {2'b00,stop_length};

                    // Data length load              Data/Stop length load
assign load_stcnt = async_csi ? ~tsf : (~C_SEND & N_SEND) | (C_SEND & st_counter_end);
assign run_stcnt = async_csi ? tsf : (C_SEND | C_STOP) & ~st_counter_end ;

// Decrementer(-1) of st_counter
QLK0RSAU04R2V1_DEC4_C0 dec4 (.out1(next_value),   .in1(st_counter) );
   
// st_counter data selector
always@(load_stcnt or run_stcnt or st_load_val or next_value or st_counter) begin
  case(1'b1) //synopsys parallel_case
    load_stcnt: next_st_counter = st_load_val;     // load count data
    run_stcnt : next_st_counter = next_value[3:0]; // decrement(-1)
    default   : next_st_counter = st_counter;      // keep st_counter
  endcase
end

// Gating signal of st_counter
assign ge_st_counter = ((load_stcnt | run_stcnt) & (s_trans | count_start_trg)) | async_csi;

always@(posedge asclk or negedge peresetz) begin
  if (~peresetz)           st_counter <= 4'b0000;
  else if (ge_st_counter)  st_counter <= next_st_counter;
end

// Sequencial start(except of CSI slave & UART receive)
wire seq_start_end = (ccs2 & ~dap) ? start_slave & ~tsf : fin_timing;

//wire seq_start_set = (~C_IDLE & we_sdr) & ~fin_timing & ~uart_recv ;
wire seq_start_set = (~C_IDLE & we_sdr) & ~fin_timing;
assign seq_start_clr = st_trg | seq_start_end;
assign ge_seq_start = seq_start_set | seq_start_clr;
//assign seq_start_data = ge_seq_start ? ~seq_start_clr : seq_start;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)          seq_start <= 1'b0;
//   else if (ge_seq_start)  seq_start <= ~seq_start_clr;
  else if (ge_common)     seq_start <= seq_start_data;
end

// This is ACK timing signal at IIC/SCIF
//assign ack_timing = (st_counter == stop_length) & C_STOP;
assign ack_timing = C_STOP;

endmodule

module QLK0RSAU04R2V1_STATDSEL_C0(
    trans_next_data, ge_trans_next, trans_next_set, trans_next_state,
    d_shift_data, ge_dshift, d_shift_clr, d_shift_delay,
    seq_start_data, ge_seq_start, seq_start_clr, seq_start);

output trans_next_data;
input  ge_trans_next;
input  trans_next_set;
input  trans_next_state;
output d_shift_data;
input  ge_dshift;
input  d_shift_clr;
input  d_shift_delay;

output seq_start_data;
input  ge_seq_start;
input  seq_start_clr;
input  seq_start;


wire trans_next_data = ge_trans_next ? trans_next_set : trans_next_state;
wire d_shift_data = ge_dshift ? ~d_shift_clr : d_shift_delay;
wire seq_start_data = ge_seq_start ? ~seq_start_clr : seq_start;

endmodule


// Flag sub-module
module QLK0RSAU04R2V1_FLAG_C0 (
                         peclk, peresetz, mck,
                         peri_write, sel_sir, we_ulhw, we_sdr,
                         se, count_clock, ccs2, dap, st_trg,
                         count_start_trg, sdr_load_timing, re_sdr,
                         seq_start, 
                         d_shift, ack_timing, state_trans, seri_fin,
                         md_iic,
                         csi_slave_mode,
                         pcheck_on, odd_parity,
                         rxe, txe, sin_sel,
                         send_data_out,
                         fin_timing,
                         ovf, parity_out, pef,
                         tsf, bff,
                         set_ovf, set_pef,
                         clr_ovf, clr_pef,
                         borrow_register,
                         asclk, async_csi, st_counter_end
                          );

input peclk;
input peresetz;
input mck;
input [2:0] peri_write;
input sel_sir;
input we_ulhw;
input we_sdr;
input se;
input count_clock;
input ccs2;
input dap;
input count_start_trg;
input sdr_load_timing;
input re_sdr;
input seq_start;
//input uart_stop;
input d_shift;
input ack_timing;
input state_trans;
input md_iic;
//input uart_recv;
input csi_slave_mode;
input pcheck_on;
input odd_parity;
input txe;
input rxe;
input sin_sel;
input send_data_out;
input fin_timing;
input st_trg;
input seri_fin;
   input asclk;
   input async_csi;
   input st_counter_end;
   
output ovf;
output parity_out;
output pef;
//output fef;
output tsf;
output bff;
output set_ovf;
//output set_fef;
output set_pef;
output clr_ovf;
//output clr_fef;
output clr_pef;
output borrow_register;

wire orct_trg;
// wire fect_trg;  		// not drive anything : by yama
wire pect_trg;
wire we_sir;
wire ge_recv_hold;
//wire data_recv_hold;
//wire ge_brow;
//wire dt_brow_reg;
reg borrow_register;
wire recv_hold;
wire clr_ovf;
wire ovr_err;
wire slave_err;
//wire data_ovf;
wire ge_ovf;
reg ovf;
wire ge_pari_check;
wire iic_ack_timing;
wire pcheck_timing;
wire p_src_data;
wire parity_out;
reg pari_check;
wire ge_pef;
wire pef_data;
reg pef;
//wire ge_fef;
//wire fef_data;
//reg fef;
reg  tsf;
wire ge_tsf;
wire tsf_src;
//wire tsf_data;
wire set_sdff;  //wire set_bff;
wire clr_sdff;  //wire clr_bff;
wire ge_sdff;   //wire ge_bff;
reg  sdff;      //reg bff;
wire sdff_data; //wire bff_data;
wire bff;
wire recv_hold_data;
wire ovf_data;
wire pc_data;

// This is clear trigger assignment
assign orct_trg = peri_write[0];
assign pect_trg = peri_write[1];
// assign fect_trg = peri_write[2];  		// not drive anything : by yama
// SIR register write signal
assign we_sir = sel_sir & we_ulhw;


//-------------------------------------------------------------------------------//
// borrow_register has receive data holding  //
//-------------------------------------------------------------------------------//
// make common gating signal of recv_hold, ovf, sdff
wire ge_flag1 = ge_recv_hold | ge_ovf | ge_sdff;

QLK0RSAU04R2V1_FLGDSEL1_C0 flgsel1(.recv_hold_data(recv_hold_data), .ge_recv_hold(ge_recv_hold), 
                                     .sdr_load_timing(sdr_load_timing), .st_trg(st_trg), .recv_hold(recv_hold),
                                   .ovf_data(ovf_data), .ge_ovf(ge_ovf), .set_ovf(set_ovf), .ovf(ovf),
                                   .sdff_data(sdff_data), .ge_sdff(ge_sdff), .clr_sdff(clr_sdff), .sdff(sdff));

       // recv_hold gating signal
assign ge_recv_hold =  (sdr_load_timing) // set timing on data receive
                       | (recv_hold & re_sdr)         // clear timing at read-out received data
                       | st_trg ;                     // clear timing at ST Stop trigger
       // recv_hold data signal
//assign data_recv_hold = ge_recv_hold ? sdr_load_timing & ~st_trg : recv_hold; // set is high priority

// borrow register data and gating signal
//assign ge_brow = ge_recv_hold & se;

always @( posedge peclk or negedge peresetz ) begin
  if(~peresetz)           borrow_register <= 1'b0;
//   else if (ge_recv_hold)  borrow_register <= sdr_load_timing & ~st_trg ;
  else if (ge_flag1)      borrow_register <= recv_hold_data;
end
assign recv_hold = borrow_register;

//--------------------------------------------------------------------------------------------------------//
// OVF flag share the 3 function counter overflow, serial over-run error, and serial slave data-not-ready //
//--------------------------------------------------------------------------------------------------------//
       // over-run error clear condition
assign clr_ovf = we_sir &  orct_trg;
       // over-run error set condition. It's cause by next data receive or write SDR at recv_hold=1
       //       and receive end timing and write sdr timing
assign ovr_err = (recv_hold & ((sdr_load_timing & ~re_sdr) | we_sdr)) | (sdr_load_timing & we_sdr);
       // OVF set condition (for CSI Slave Send Data un-ready Status)
assign slave_err = csi_slave_mode & count_start_trg & txe & ~sdff;
wire set_ovf = (ovr_err | slave_err) & ~st_trg;

// ovf flag data and gating signal
assign ge_ovf = set_ovf | clr_ovf;

always @(posedge peclk or negedge peresetz) begin
  if (~peresetz)        ovf <= 1'b0;
//   else if (ge_ovf)      ovf <= set_ovf;
  else if (ge_flag1)    ovf <= ovf_data;
end

//-----------//
// BFF flag  //
//-----------//
assign bff = sdff | recv_hold; // New BFF flag

assign set_sdff = txe & we_sdr & se;
assign clr_sdff = (count_start_trg     // send data load(SDR->SPR) timing
                   | (txe & fin_timing & (~ccs2 | (ccs2&dap)))  // Seq-send start timing
                   | st_trg) & sdff ;

// sdff gating and data signal
assign ge_sdff = (set_sdff | clr_sdff) ;
// assign sdff_data = ge_sdff ? ~clr_sdff : sdff; // clear is high priority

always @( posedge peclk or negedge peresetz ) begin
  if(~peresetz)      sdff <= 1'b0;
//  else if (ge_sdff)   sdff <=  ~clr_sdff;
  else if (ge_flag1) sdff <= sdff_data;
end

//--------------------------------------------------------------------//
// pari_check is parity check status register until data receive end  //
//--------------------------------------------------------------------//
reg pari_check_data;

// make common gating signal of pari_check, pef, fef_tmp, fef
wire ge_pef_fef_common = mck|we_sir;
wire ge_flag2 = ge_pari_check | ge_pef_fef_common ;

QLK0RSAU04R2V1_FLGDSEL2_C0 flgsel2(
 .pc_data(pc_data), .ge_pari_check(ge_pari_check), .pari_check_data(pari_check_data), .pari_check(pari_check),
 .pef_data(pef_data), .ge_pef_fef_common(ge_pef_fef_common), .ge_pef(ge_pef), .set_pef(set_pef), .pef(pef));


// This is pari_check data signal (for Power Compiler extracting gating signal, avoiding logical complexity)
wire iic_ack_data = sin_sel & txe;
always@(iic_ack_timing or d_shift or pcheck_timing or
        iic_ack_data or parity_out or sin_sel or p_src_data or pari_check)
begin
  casex ({iic_ack_timing, pcheck_timing, d_shift}) //synopsys parallel_case
   3'b1xx: pari_check_data = iic_ack_data;
   3'b01x: pari_check_data = parity_out ^ sin_sel;
   3'b001: pari_check_data = p_src_data ^ pari_check;
   default: pari_check_data = 1'b0;
  endcase
end

//wire pari_check_en = pcheck_on & rxe;
// wire pari_check_en = 1'b0;			// not drive anything : by yama

// this is ack timing for IIC mode
assign iic_ack_timing = md_iic & ack_timing & ~state_trans;
// this is parity check timing 
assign pcheck_timing = 1'b0; 		//pari_check_en & C_PARITY & ~state_trans ;

// source data for parity check, receive->SIN, send->SOUT
assign p_src_data = rxe ? sin_sel : send_data_out;
//assign p_src_data = send_data_out;

// Parity data output signal(-> OUTCTL sub-module)
assign parity_out = (odd_parity ? ~pari_check : pari_check) & pcheck_on ;

// gating signal for pari_check
wire pari_initialize = count_start_trg | (fin_timing & seq_start);
assign ge_pari_check = d_shift | (iic_ack_timing & count_clock) | pari_initialize ;

// assign pc_data = ge_pari_check ? pari_check_data : pari_check;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     pari_check <= 1'b0;
//   else if (ge_pari_check)  pari_check <= pari_check_data;
  else if (ge_flag2)  pari_check <= pc_data;
end

//------------------------//
// PEF parity error flag  //
//------------------------//
//wire src_pef = (fin_timing & (pari_check_en | md_iic)) & pari_check & count_clock;
wire src_pef = (fin_timing & md_iic) & pari_check & count_clock;
wire clr_pef = (we_sir & pect_trg) ;  // pef clear timing
assign ge_pef = src_pef | clr_pef ;

// assign pef_data = ge_pef_fef_common ? (ge_pef ? set_pef : pef) : pef; // set is high priority

wire set_pef = src_pef & ~st_trg ;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)                  pef <= 1'b0;
//   else if (ge_pef_fef_common)     pef <= pef_data;
  else if (ge_flag2)     pef <= pef_data;
end

//----------//
// TSF flag //
//----------//
//assign ge_tsf = count_start_trg | uart_stop | seri_fin | st_trg | async_csi;
assign ge_tsf = count_start_trg | seri_fin | st_trg | async_csi;
//assign tsf_src = ~((async_csi&st_counter_end) | uart_stop | seri_fin | st_trg) ; // clear is high priority, reduce redundant logic
assign tsf_src = ~((async_csi&st_counter_end) | seri_fin | st_trg) ; // clear is high priority, reduce redundant logic


always @(posedge asclk or negedge peresetz) begin
  if (~peresetz)       tsf <= 1'b0;
  else if (ge_tsf)     tsf <= tsf_src;
end

endmodule

module QLK0RSAU04R2V1_FLGDSEL1_C0( recv_hold_data, ge_recv_hold, sdr_load_timing, st_trg, recv_hold,
                                   ovf_data, ge_ovf, set_ovf, ovf,
                                   sdff_data, ge_sdff, clr_sdff, sdff);

output recv_hold_data;
input ge_recv_hold;
input sdr_load_timing;
input st_trg;
input recv_hold;
output  ovf_data;
input ge_ovf;
input set_ovf;
input ovf;
output sdff_data;
input ge_sdff;
input clr_sdff;
input sdff;

wire recv_hold_data = ge_recv_hold ? sdr_load_timing & ~st_trg : recv_hold;
wire ovf_data = ge_ovf ? set_ovf : ovf;
wire sdff_data = ge_sdff ? ~clr_sdff : sdff; // clear is high priority

endmodule

module QLK0RSAU04R2V1_FLGDSEL2_C0(
 pc_data, ge_pari_check, pari_check_data, pari_check,
 pef_data, ge_pef_fef_common, ge_pef, set_pef, pef);

output pc_data;
input  ge_pari_check;
input  pari_check_data;
input  pari_check;

output pef_data;
input  ge_pef_fef_common;
input  ge_pef;
input  set_pef;
input  pef;

wire pc_data = ge_pari_check ? pari_check_data : pari_check;
wire pef_data = ge_pef_fef_common ? (ge_pef ? set_pef : pef) : pef; 

endmodule



// INT sub-module
module QLK0RSAU04R2V1_INT_C0 (
                         peresetz,
                         count_start_trg,
                         md0, dap, csi_slave_mode,
                         last_state, seq_start, state_trans,
                         st_trg,
                         eoc, ovf, pef, set_ovf, set_pef,
                         clr_ovf, clr_pef,
                         se, int_sig, eint, 
                         asclk, st_counter_end, async_csi,
                         async_clk, scanmode );

//input peclk;
input peresetz;
input md0;
input dap;
input csi_slave_mode;
input last_state;
input seq_start;
input state_trans;
input st_trg;
input se;
input count_start_trg;
input eoc;
input ovf;
//input fef;
input pef;
input set_ovf;
//input set_fef;
input set_pef;
input clr_ovf;
//input clr_fef;
input clr_pef;
input asclk;
input st_counter_end;
input async_csi;
input async_clk;
input scanmode;

output int_sig;
output eint;

wire buf_emp;
wire t_end;
wire int_seri;
wire ge_int;
reg int_sig;
wire pre_eint;
reg eint;
wire set_eint, clr_eint, ge_eint, data_eint;
wire int_sig_data;

wire ge_int_eint = ge_int | ge_eint;



// Serial function source of INT signal
assign buf_emp = count_start_trg | (last_state & seq_start & ~(csi_slave_mode & ~dap)); // buffer empty interrupt
assign t_end = last_state ;  // transfer end interrupt
//wire eoc_mask = eoc & ((ovf&~clr_ovf) | (fef&~clr_fef) | (pef&~clr_pef)
//                         | set_ovf | set_fef | set_pef);
wire eoc_mask = eoc & ((ovf&~clr_ovf) | (pef&~clr_pef)
                         | set_ovf | set_pef);
assign int_seri = async_csi ? st_counter_end : (md0 ? buf_emp : t_end) & state_trans & ~eoc_mask & ~st_trg; // Serial mode
// int_sig gating and data signal
assign ge_int = int_seri | int_sig | async_csi;


assign pre_eint = ( set_ovf | set_pef ) & eoc;
assign set_eint = pre_eint;
assign clr_eint = ~set_eint & eint;
assign ge_eint = set_eint | clr_eint;
//assign data_eint = ge_eint ? set_eint : eint;

QLK0RSAU04R2V1_INTDSEL_C0 intdsel( .data_eint(data_eint), .ge_eint(ge_eint), .set_eint(set_eint),
                                   .eint(eint), 
                                   .int_sig_data(int_sig_data), .ge_int(ge_int), .int_seri(int_seri),
                                   .se(se), .int_sig(int_sig),
                                   .async_clk(async_clk), .scanmode(scanmode));

always @( posedge asclk or negedge peresetz ) begin
    if(~peresetz) begin
            int_sig <= 1'b0;
            eint <= 1'b0;
      end
    else if (ge_int_eint) begin
            int_sig <= int_sig_data;
            eint <= data_eint;
      end
end


endmodule

module QLK0RSAU04R2V1_INTDSEL_C0( data_eint, ge_eint, set_eint, eint,
                                  int_sig_data, ge_int, int_seri, se, int_sig,
                                  async_clk, scanmode );
output data_eint;
output int_sig_data;

input ge_eint;
input set_eint;
input eint;
input ge_int;
input int_seri;
input se;
input int_sig;
input async_clk;
input scanmode;

wire data_eint = ge_eint ? set_eint | (scanmode&async_clk) : eint;
wire int_sig_data = ge_int ? int_seri & se : int_sig;

endmodule


// OUTCTL sub-module
module QLK0RSAU04R2V1_OUTCTL_C0 (
                           count_start_trg, st_trg, s_trans, fin_timing,
                           last_state, seq_start,
                           N_START, N_SEND, N_PARITY, N_STOP,
                           C_IDLE, C_STOP,
                           trans_next_state,
                           sdr, count_register,
                           data_8bit, data_9bit,
                           dir, txe, md_iic, md_uart,
                           count_clock, sck_toggle,
                           parity_out, dap, ckp, ccs2, csi_slave_mode,
                           seri_dout_timing, seri_dout,
                           sck_timing, sck_data,
                           send_data_out );

input count_start_trg;
input st_trg;
input s_trans;
input fin_timing;
input last_state;
input seq_start;
input N_START;
input N_SEND;
input N_PARITY;
input N_STOP;
input C_IDLE;
input C_STOP;
input trans_next_state;
input [15:0] sdr;
input [15:0] count_register;
input data_8bit;
input data_9bit;
input dir;
input txe;
input md_iic;
input md_uart;
input count_clock;
input sck_toggle;
input parity_out;
input dap;
input ckp;
input ccs2;
input csi_slave_mode;

output seri_dout_timing;
output seri_dout;
output sck_timing;
output sck_data;
output send_data_out;

wire seri_dout_timing;
wire start_bit;
wire parity_bit;
wire stop_bit;
wire load_from_sdr;
wire [15:0] src_of_dout;
reg  msb_out;
reg  pre_seri_dout;
wire seri_dout;
wire sck_timing;
wire sck_data;

// Serial Data output timing
wire iic_default = (md_iic & fin_timing & ~seq_start); // This is IIC default value (SOUT = "H")
wire csi_slv_out = ~(csi_slave_mode & ~dap) & seq_start ;
assign seri_dout_timing  = (count_start_trg | (s_trans & (~last_state|csi_slv_out)) | iic_default) & ~st_trg ;
// Start bit output timing
assign start_bit = N_START;
// Parity bit output timing
assign parity_bit = N_PARITY;
// Stop bit output timing
assign stop_bit = N_STOP;

// At start timing, SDR data doesnot load SPR register, 
// So SOUT is load from SDR register at this timing.
assign load_from_sdr = (C_IDLE & N_SEND & ~seq_start) | (last_state & seq_start & ~(ccs2 & ~dap));

// Serial output data selector
assign src_of_dout = load_from_sdr ? sdr : count_register;

// MSB first output data selector // Remove data_9bit, 16bit
always@(data_8bit or data_9bit or src_of_dout) begin
  case(1'b1) //synopsys parallel_case
    data_8bit:  msb_out = src_of_dout[7];
    data_9bit:  msb_out = src_of_dout[8];
    default:  msb_out = src_of_dout[6];
  endcase
end

// MSB/LSB selector
wire send_data_out = dir ? src_of_dout[0] : msb_out;

// IIC/SCIF output data at stop state
wire stop_data = md_iic ? txe : 1'b1;

// data output
always@(start_bit or parity_bit or stop_bit or iic_default or
        parity_out or stop_data or send_data_out ) begin
  casex ({start_bit, parity_bit, stop_bit, iic_default})
    4'b1xxx: pre_seri_dout = 1'b0;
    4'bx1xx: pre_seri_dout = parity_out;
    4'bxx1x: pre_seri_dout = stop_data;
    4'b0001: pre_seri_dout = 1'b1;
    default: pre_seri_dout = send_data_out;
  endcase
end

assign seri_dout =  pre_seri_dout;

//++++====++++====++++==== SCKO_SRC ++====++++====++++====++++====+//
       // SCK toggle timing

wire   mask_stop = ((N_STOP & trans_next_state & ~dap) | C_STOP) & ~(seq_start & fin_timing);
wire   sck_tim_pre = count_start_trg |        // start timing
                     (count_clock & ~( ((~dap & fin_timing&(~seq_start|ccs2) ) | mask_stop) & ~md_iic));
assign sck_timing = sck_tim_pre & ~md_uart & ~st_trg ;
assign sck_data = (dap ^ ckp) ? ~sck_toggle : sck_toggle;

endmodule

module QLK0RSAU04R2V1_FUNC_C1 (
                    // INPUT
                    peclk, pclkrw, peresetz,
                    mck,
                    we_ulhw, sel_sdr, sel_sir, re_sdr, peri_write,
                    se, md0,
                    dap, ckp,
                    count_start_trg, 
                    count_clock, b_count_clock,
                    md_csi, md_uart, md_iic,
                    eoc,
                    dls, slc, dir, rxe, txe,
                    pstate_on, pcheck_on, odd_parity,
                    no_stopbit, ccs2,
                    data_7bit, data_8bit, data_9bit,
                    sin_level, st_trg, start_slave,
                    sin_latch, 
                    // OUTPUT
                    spr,sdr_read,
                    baud_borrow, csi_slave_stop,
                    int_sig, eint,
                    seri_fin_out,
                    pef,fef,bff,ovf,tsf,
                    seri_dout_timing, seri_dout,
                    sck_timing, sck_data,
                    fast_mode, brate_adj, ssec, bcnt_restart, scanmode,
                    sin_direct, ch_error, ack_timing
                   );

input peclk;
input peresetz;
input pclkrw;
   
input mck;

input we_ulhw;
input sel_sdr;
input sel_sir;
input re_sdr;
input [15:0] peri_write;

//input brow_in_cas;
input se;
input md0;
input count_start_trg;
input count_clock;
input b_count_clock;

input md_csi;
input md_uart;
input md_iic;
input eoc;
input dap;
input ckp;
input [1:0] dls;
input slc;
input dir;
input rxe;
input txe;
//input txrx_on;
input pstate_on;
input pcheck_on;
input odd_parity;
input no_stopbit;
input ccs2;
input data_7bit;
input data_8bit;
input data_9bit;
input sin_level;
input sin_latch;
input sin_direct;
input st_trg;
input start_slave;
input ssec;
input brate_adj;
input    bcnt_restart;
input scanmode;
   
   
output [15:0] spr;
output [15:0] sdr_read;
output baud_borrow;
output csi_slave_stop;
output int_sig;
output eint;
output pef;
output fef;
output bff;
output ovf;
output tsf;
output seri_dout_timing;
output seri_dout;
output seri_fin_out;
output sck_timing;
output sck_data;
output fast_mode;
output ch_error;
output ack_timing;

// Counter
wire [15:0] spr;
wire baud_borrow;
wire recv_data;
wire [15:0] sdr;
wire [15:0] sdr_read;
wire we_sdr;
wire ld_spr_to_sdr;
wire load_next_s_data;
wire csi_slave_ld_mask;
wire d_shift;

// Overflow
wire borrow_register;
wire bff;

// FSM
wire C_IDLE;
wire C_START;
wire C_SEND;
wire C_PARITY;
wire C_STOP;
wire N_START;
wire N_SEND;
wire N_PARITY;
wire N_STOP;

wire seq_start; // Seq_start is working on except of UART & rxe
wire trans_next_state; // This is state transfer timing on transmission
wire state_trans; // This is current_state gating signal
wire s_trans;
wire sck_toggle; // This is data shift/capture timing signal
wire last_state; // This is the status of Last state on 1 data
wire fin_timing;
wire sdr_load;
wire seri_fin;
wire seri_fin_out;
wire uart_stop;
wire bcnt_clear;

// Sout
wire seri_dout_timing; // serial SOUT change timing
wire seri_dout; // serial SOUT next data
wire send_data_out;

// Scko
wire sck_timing;   // sck toggle timing;
wire sck_data;     // sck data

// Int
wire int_sig;
wire eint_sig;
wire eint = eint_sig & ~ssec;
wire ch_error = (eint_sig & ssec) | (C_START & uart_stop);

// Flag
wire ovf;
wire pef;
wire ack_timing;
wire parity_out;
wire fef;
wire tsf;
wire sdr_load_timing;
wire uart_recv;
wire set_ovf, set_fef, set_pef, clr_ovf, clr_fef, clr_pef;
wire baud_borrow_noclr;

// I/O control
// wire data_out;  		// not drive anything : by yama

// Common Signal
//assign uart_recv = md_uart & rxe;
assign uart_recv = md_uart;
assign seri_fin_out = seri_fin | uart_stop;

// SIN Signal Selector
wire csi_slave_mode = md_csi & ccs2;


reg sin_sel;
always@(sin_latch or sin_level or md_uart or csi_slave_mode)
  case ( md_uart|csi_slave_mode )
    1'b1    : sin_sel = sin_latch;
    default : sin_sel = sin_level;
  endcase

wire ssec;
wire error_gen;
  
assign load_next_s_data = sdr_load & txe; // <- SEQ transfer load next SDR data
//assign sdr_load_timing = fin_timing & rxe;
assign sdr_load_timing = fin_timing & rxe & ~(ssec&error_gen); // mask recv_hold
assign ld_spr_to_sdr = sdr_load_timing & ~st_trg ;
assign recv_data = ~rxe | sin_sel ;
//assign recv_data = ~rxe | (bcnt_clear ? ~sin_sel : sin_sel)  ;  // baud adjustment
assign we_sdr = we_ulhw & sel_sdr;

//++++====++++====++++====  COUNTER   ====++++====++++====++++====//
QLK0RSAU04R2V1_CNT_C1 cnt (.peclk(peclk), .peresetz(peresetz),
                     .data_8bit(data_8bit), .data_7bit(data_7bit), .data_9bit(data_9bit),
                     .recv_data(recv_data), .dir(dir),
                     .csi_slave_ld_mask(csi_slave_ld_mask),
                     .count_start_trg(count_start_trg), .load_next_s_data(load_next_s_data),
                     .se(se), .d_shift(d_shift), .b_count_clock(b_count_clock),
                     .sdr(sdr), .spr(spr), .baud_borrow(baud_borrow), .baud_borrow_noclr(baud_borrow_noclr),
                     .bcnt_clear(bcnt_clear),
                     .sin_direct(sin_direct), .fast_mode(fast_mode), .rxe(rxe) );

//++++====++++====++++====  DATA_REG   ====++++====++++====++++====//
QLK0RSAU04R2V1_DREG_C1 dreg ( .peclk(peclk), .pclkrw(pclkrw), .peresetz(peresetz),
                        .we_sdr(we_sdr), 
                        .se(se), .ccs2(ccs2),
                        .ld_spr_to_sdr(ld_spr_to_sdr), .peri_write(peri_write),
                        .spr(spr), .sdr(sdr), .sdr_read(sdr_read), .fast_mode(fast_mode)
                        );

//++++====++++====++++====   FSM    ++====++++====++++====++++====//
QLK0RSAU04R2V1_STATECTL_C1 statectl(
                              .peclk(peclk), .peresetz(peresetz), 
                              .count_start_trg(count_start_trg), .st_trg(st_trg),
                              .count_clock(count_clock), .baud_borrow_noclr(baud_borrow_noclr),
                              .md_csi(md_csi), .md_uart(md_uart), 
                              .uart_recv(uart_recv),
                              .txe(txe), .rxe(rxe), .sin_sel(sin_sel),
                              .pstate_on(pstate_on), .no_stopbit(no_stopbit),
                              .dls(dls), .ccs2(ccs2), .dap(dap), .fast_mode(fast_mode),
                              .we_sdr(we_sdr), .tsf(tsf), .start_slave(start_slave),
                              .csi_slave_mode(csi_slave_mode),
                              .eint(eint_sig),
                              .C_IDLE(C_IDLE), .C_START(C_START), .C_SEND(C_SEND), .C_PARITY(C_PARITY), .C_STOP(C_STOP),
                              .N_START(N_START), .N_SEND(N_SEND), .N_PARITY(N_PARITY), .N_STOP(N_STOP),
                              .d_shift(d_shift), .state_trans(state_trans), .s_trans(s_trans),
                              .sck_toggle(sck_toggle),
                              .trans_next_state(trans_next_state), .last_state(last_state),
                              .fin_timing(fin_timing), .sdr_load(sdr_load),
                              .seri_fin(seri_fin), .seq_start(seq_start), .ack_timing(ack_timing),
                              .csi_slave_stop(csi_slave_stop),
                              .csi_slave_ld_mask(csi_slave_ld_mask),
                              .uart_stop(uart_stop),
                              .brate_adj(brate_adj), .ssec(ssec),
                              .bcnt_restart(bcnt_restart), .bcnt_clear(bcnt_clear), .scanmode(scanmode)  );

//++++====++++====++++==== SOUT_SRC ++====++++====++++====++++====++//
//++++====++++====++++==== SCKO_SRC ++====++++====++++====++++====+//
QLK0RSAU04R2V1_OUTCTL_C1 outctl(
                           .count_start_trg(count_start_trg), .st_trg(st_trg), .s_trans(s_trans), .fin_timing(fin_timing),
                           .last_state(last_state), .seq_start(seq_start),
                           .N_START(N_START), .N_SEND(N_SEND), .N_PARITY(N_PARITY), .N_STOP(N_STOP),
                           .C_IDLE(C_IDLE), .C_STOP(C_STOP),
                           .trans_next_state(trans_next_state),
                           .sdr(sdr), .count_register(spr),
                           .data_8bit(data_8bit), .data_9bit(data_9bit),
                           .dir(dir), .txe(txe),
                           .md_iic(md_iic), .md_uart(md_uart),
                           .count_clock(count_clock), .sck_toggle(sck_toggle),
                           .parity_out(parity_out), .dap(dap), .ckp(ckp), .ccs2(ccs2), .csi_slave_mode(csi_slave_mode),
                           .seri_dout_timing(seri_dout_timing), .seri_dout(seri_dout),
                           .sck_timing(sck_timing), .sck_data(sck_data),
                           .send_data_out(send_data_out) );

//++++====++++====++++====   INT    ++====++++====++++====++++====//
QLK0RSAU04R2V1_INT_C1 intctl(
                         .peclk(peclk), .peresetz(peresetz),
                         .count_start_trg(count_start_trg),
                         .md0(md0), .dap(dap), .csi_slave_mode(csi_slave_mode),
                         .last_state(last_state), .seq_start(seq_start), .state_trans(state_trans),
                         .st_trg(st_trg),
                         .eoc(eoc), .ovf(ovf), .fef(fef), .pef(pef),
                         .set_ovf(set_ovf), .set_fef(set_fef), .set_pef(set_pef),
                         .clr_ovf(clr_ovf), .clr_fef(clr_fef), .clr_pef(clr_pef),
                         .se(se), 
                         .int_sig(int_sig), .eint(eint_sig) );


//++++====++++====++++====   EINT    ++====++++====++++====++++====//
//QLK0RSAU04R2V1_EINT_C1 seintctl(
//                         .peclk(peclk), .peresetz(peresetz),
//                         .set_ovf(set_ovf), .set_fef(set_fef), .set_pef(set_pef),
//                         .eoc(eoc), .eint(eint_sig) );

//++++====++++====++++====   FLAG   ++====++++====++++====++++====//
QLK0RSAU04R2V1_FLAG_C1 flag (
                       .peclk(peclk), .peresetz(peresetz), .mck(mck),
                       .peri_write(peri_write[2:0]), .sel_sir(sel_sir), .we_ulhw(we_ulhw), .we_sdr(we_sdr),
                       .se(se), .count_clock(count_clock), .st_trg(st_trg),
                       .count_start_trg(count_start_trg), .ccs2(ccs2), .dap(dap),
                       .sdr_load_timing(sdr_load_timing), .re_sdr(re_sdr),
                       .seq_start(seq_start), .uart_stop(uart_stop),
                       .d_shift(d_shift), .ack_timing(ack_timing), .state_trans(state_trans),
                       .md_iic(md_iic),
                       .uart_recv(uart_recv), .csi_slave_mode(csi_slave_mode), .seri_fin(seri_fin),
                       .C_STOP(C_STOP), .C_PARITY(C_PARITY),
                       .slc(slc),
                       .pcheck_on(pcheck_on), .odd_parity(odd_parity),
                       .txe(txe), .rxe(rxe), .sin_sel(sin_sel), .send_data_out(send_data_out),
                       .trans_next_state(trans_next_state),
                       .fin_timing(fin_timing),
                       .ovf(ovf), .parity_out(parity_out), .pef(pef),
                       .fef(fef), .tsf(tsf), .bff(bff),
                       .set_ovf(set_ovf), .set_fef(set_fef), .set_pef(set_pef),
                       .clr_ovf(clr_ovf), .clr_fef(clr_fef), .clr_pef(clr_pef),
                       .borrow_register(borrow_register),
                       .ssec(ssec), .error_gen(error_gen), .bcnt_clear(bcnt_clear)
                        );

//++++====++++====++++====+ I/O  CNT +====++++====++++====++++====+//
// assign data_out = txe ;  		// not drive anything : by yama

endmodule

// This is Counter(SPR) module
module QLK0RSAU04R2V1_CNT_C1( peclk, peresetz,
                        data_8bit, data_7bit, data_9bit,
                        recv_data,
                        dir,
                        csi_slave_ld_mask,
                        count_start_trg, load_next_s_data,
                        se, d_shift, b_count_clock,
                        sdr, spr, baud_borrow, baud_borrow_noclr,
                        bcnt_clear,
                        sin_direct, rxe, fast_mode );
input peclk;
input peresetz;

input data_8bit;
input data_7bit;
input data_9bit;
input recv_data;
input dir;
input csi_slave_ld_mask;
input count_start_trg;
input load_next_s_data;
input se;
input d_shift;
input b_count_clock;
input [15:0] sdr;
input     bcnt_clear;
input sin_direct;
input rxe;
input fast_mode;

output [15:0] spr;
output baud_borrow;
output baud_borrow_noclr;

wire shift9_lsb;
wire shift8_lsb;
wire shift7_lsb;
wire shift6_lsb;
wire shift5_lsb;
wire shift9_msb;
wire shift8_msb;
wire shift7_msb;
wire shift6_msb;

wire [15:0] shift_data;
wire [15:9] next_value;
reg [15:0] load_data;
wire borrow2;
wire baud_borrow;
wire baud_borrow_noclr;
reg [15:0] count_register;
wire load_trg_lb;
wire load_trg_ub;
wire ge_count_register_0;
//wire ge_count_register_1;
wire ge_count_register_2;
wire ge_count_register_3;

// Shift/Capture function  all shift condition
wire recv_data_sel = fast_mode & rxe ? sin_direct : recv_data;

assign shift9_lsb = (data_9bit & recv_data_sel) ;
assign shift8_lsb = (data_9bit & count_register[8]) | (data_8bit & recv_data_sel);
assign shift7_lsb = (~data_7bit & count_register[7]) | (data_7bit & recv_data_sel);
assign shift6_lsb = count_register[6];
assign shift5_lsb = count_register[5];
assign shift9_msb = data_9bit & count_register[7];
assign shift8_msb = ~data_7bit  & count_register[6];
assign shift7_msb = count_register[5];
assign shift6_msb = count_register[4];

// Generate bit8-0 shift data
assign shift_data[8:0] = dir ? {shift9_lsb, shift8_lsb, shift7_lsb, shift6_lsb, shift5_lsb, count_register[4:1]}  // LSB first
                             : {shift9_msb, shift8_msb, shift7_msb, shift6_msb, count_register[3:0], recv_data_sel};  // MSB first

// Generate bit15-9 shift data
assign shift_data[15:9] = 7'h00;
   
   
// Borrow signal (bit separated)
wire tmp_borrow2 ;

QLK0RSAU04R2V1_DEC3_C1 dec3_1 (.borrow(tmp_borrow2), .out1(next_value[11:9]),  .in1(count_register[11:9]) );
QLK0RSAU04R2V1_DEC4_C1 dec4_2 (.out1(next_value[15:12]), .in1(count_register[15:12]));

assign borrow2 = tmp_borrow2 ;                     // This is borrow signal count_register[11:9]-1

// Borrow Signal (Baud-Rate Counter), This is used for Timer and Serial
assign baud_borrow = ((count_register[15:9]==7'h00) | bcnt_clear);
assign baud_borrow_noclr = (count_register[15:9]==7'h00);

// SPR Register value inverted on capture mode
assign spr        = count_register ;

// Load SDR/FFFFH trigger for SPR[8:0]
assign load_trg_lb  = ((count_start_trg & ~csi_slave_ld_mask)    // <- This is Serial        imer Start Condition
                                                                 //    csi_slave_ld_mask is refered to STATECTL
                       | load_next_s_data) & se;                 // <- This is Serial Seq-Send Condition

// Load SDR/FFFFH trigger for SPR[15:9]
assign load_trg_ub  = ((count_start_trg & ~csi_slave_ld_mask)     // This is Serial        imer Start Condition
                       | (baud_borrow & b_count_clock)            // This is Serial baud-rate Conter=00H Condition;
                       ) & se;   // <- This is Serial Se-Send Condition


// Load data selector // Remove Bit9
always@(load_trg_lb or sdr or shift_data) begin
  case ({load_trg_lb}) // synopsys parallel_case
    1'b0:  load_data[8:0] = shift_data[8:0];  // load shift/recv for serial mode
    default: load_data[8:0] = sdr[8:0];         // load sdr[8:0] for non capture mode
  endcase
end

//wire shift16 = d_shift & data_16bit;

// Remove data_16bit
always@(load_trg_ub or sdr or shift_data or next_value) begin
  case ({load_trg_ub}) // synopsys parallel_case
    1'b1:  load_data[15:9] = sdr[15:9];         // load sdr[8:0] for non capture mode
    default: load_data[15:9] = next_value[15:9];  // load decrement value
  endcase
end

assign ge_count_register_0 = d_shift | load_trg_lb ;                     // Gating for bit[4:0]
assign ge_count_register_2 = load_trg_ub | b_count_clock;                // Gating for bit[11:9]
assign ge_count_register_3 = load_trg_ub | (borrow2 & b_count_clock);    // Gating for bit[15:12]

// Counter/ShiftRegister
always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[8:0] <= 9'h1ff ;
    else if (ge_count_register_0)  count_register[8:0] <= load_data[8:0];
end

always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[11:9] <= 3'h7 ;
    else if (ge_count_register_2)  count_register[11:9] <= load_data[11:9];
end

always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)                 count_register[15:12] <= 4'hf ;
    else if (ge_count_register_3)  count_register[15:12] <= load_data[15:12];
end

endmodule

// 4bit Decrement Module
module QLK0RSAU04R2V1_DEC4_C1 (out1, in1);
  output [3:0] out1;
  input  [3:0] in1;

  wire [3:0] out1;
  wire [2:0] tmp_borrow;

  assign out1[0] = tmp_borrow[0] ;
  assign tmp_borrow[0] = ~in1[0] ;

  assign out1[1] = in1[1] ^ tmp_borrow[0];
  assign tmp_borrow[1] = ~in1[1] & tmp_borrow[0];

  assign out1[2] = in1[2] ^ tmp_borrow[1];
  assign tmp_borrow[2] = ~in1[2] & tmp_borrow[1];

  assign out1[3] = in1[3] ^ tmp_borrow[2];

endmodule

// 3bit Decrement Module
module QLK0RSAU04R2V1_DEC3_C1 (borrow, out1, in1);
  output borrow;
  output [2:0] out1;
  input  [2:0] in1;

  wire borrow;
  wire [2:0] out1;
  wire [1:0] tmp_borrow;

  assign out1[0] = tmp_borrow[0] ;
  assign tmp_borrow[0] = ~in1[0] ;

  assign out1[1] = in1[1] ^ tmp_borrow[0];
  assign tmp_borrow[1] = ~in1[1] & tmp_borrow[0];

  assign out1[2] = in1[2] ^ tmp_borrow[1];
  assign borrow = ~in1[2] & tmp_borrow[1];

endmodule

// Data Register (SDR)
module QLK0RSAU04R2V1_DREG_C1(
                         peclk, pclkrw, peresetz,
                         we_sdr, ccs2,
                         se,
                         ld_spr_to_sdr, peri_write,
                         spr, sdr, sdr_read, fast_mode
                         );

input peclk;
input pclkrw;
   
input peresetz;
input we_sdr;
input ccs2;
input se;
input ld_spr_to_sdr;
input [15:0] peri_write;
input [15:0] spr;

output [15:0] sdr;
output [15:0] sdr_read;
output     fast_mode;
   
wire apb_wr_en;
wire mask_sdr_h;
wire ge_sdr;
//reg [15:0] sdr_data;
//reg [15:0] sdr;
//reg [6:0] sdr_data_h;
reg [8:0] sdr_data_l;
reg [6:0] sdr_h;
reg [8:0] sdr_l;
   
wire [15:0] sdr_read;
wire [15:0] sdr = {sdr_h, sdr_l};
   
// SDR Write Signal (masked by capture mode)
assign apb_wr_en = we_sdr;
// APB Write Mask signal for baud-rate counter(SDR[15:9])
assign mask_sdr_h = se ;  // & baud_count_en;
// SDR gating signal (APB write, capture trigger, Serial Receive)
assign ge_sdr = apb_wr_en | ld_spr_to_sdr ;

// SDR Write data for SDR[8:0] 
always@(apb_wr_en or peri_write or spr) begin
  if (apb_wr_en) sdr_data_l[8:0] = peri_write[8:0];  // APB write
  else           sdr_data_l[8:0] = spr[8:0];         // Capture and Serial Receive
end
   

// SDR Register
always @(posedge pclkrw or negedge peresetz) begin
    if (~peresetz)                   sdr_h <= 7'h00;
    else if (~mask_sdr_h&apb_wr_en)  sdr_h <= peri_write[15:9];
end

// SDR Register
always @(posedge peclk or negedge peresetz) begin
    if (~peresetz)    sdr_l <= 9'h000;
    else if (ge_sdr)  sdr_l <= sdr_data_l;
end

// This is SDR read-out value
assign sdr_read[15:9] = mask_sdr_h ? 7'h00 : sdr_h; // Baud-rate doesn't read out while SE=1
assign sdr_read[8:0] = sdr_l;

wire fast_mode = (sdr_h == 7'h00)&~ccs2;
   
   
endmodule

// FSM Controller
module QLK0RSAU04R2V1_STATECTL_C1 (
                              peclk, peresetz,
                              count_start_trg, st_trg, count_clock, baud_borrow_noclr,
                              md_csi, md_uart, uart_recv,
                              txe, rxe, sin_sel,
                              pstate_on, no_stopbit,
                              dls, ccs2, dap, fast_mode,
                              we_sdr, tsf, start_slave, csi_slave_mode,
                              eint,
                              C_IDLE, C_START, C_SEND, C_PARITY, C_STOP,
                              N_START, N_SEND, N_PARITY, N_STOP,
                              d_shift, state_trans, s_trans,
                              sck_toggle,
                              trans_next_state, last_state,
                              fin_timing, sdr_load,
                              seri_fin, seq_start, ack_timing,
                              csi_slave_stop, csi_slave_ld_mask,
                              uart_stop, brate_adj, ssec,
                              bcnt_restart, bcnt_clear, scanmode  );

input  peclk;
input  peresetz;
input  count_start_trg;
input  st_trg;
input  count_clock;
input  md_uart;
input  md_csi;
input  uart_recv;
input  txe;
input  rxe;
input  sin_sel;
input  pstate_on;
input  no_stopbit;
input [1:0] dls;
//input  slc;
input  ccs2;
input  dap;
input  we_sdr;
input  tsf;
input  start_slave;
input  csi_slave_mode;
input  fast_mode;
input  brate_adj;
input       bcnt_restart;
input    scanmode;
input  eint;
input ssec;
input baud_borrow_noclr;
  
output C_IDLE;
output C_START;
output C_SEND;
output C_PARITY;
output C_STOP;
output N_START;
output N_SEND;
output N_PARITY;
output N_STOP;
output d_shift;
output sck_toggle;
output state_trans;
output s_trans;
output trans_next_state;
output last_state;
output fin_timing;
output sdr_load;
output seri_fin;
output seq_start;
output ack_timing;
output csi_slave_stop;
output csi_slave_ld_mask;
output uart_stop;
output bcnt_clear;
   
   
// State definition
parameter IDLE   = 3'b000;
parameter START  = 3'b111;
parameter SEND   = 3'b101;
parameter PARITY = 3'b010;
parameter STOP   = 3'b110;

wire C_IDLE;
wire C_START;
wire C_SEND;
wire C_PARITY;
wire C_STOP;
wire N_START;
wire N_SEND;
wire N_PARITY;
wire N_STOP;
wire uart_stop;
wire state_trans;
wire d_shift;
wire d_shift_normal;
reg  d_shift_delay;

wire last_state;
wire fin_timing;
wire sdr_load;
wire seri_fin;
reg trans_next_state;
reg [2:0] current_state;
reg [2:0] next_state;
wire st_counter_end;
wire [3:0] data_length;
//reg  [2:0] stop_length;
wire dl_set;
wire [3:0] st_load_val;
wire load_stcnt;
wire run_stcnt;
wire [3:0] next_value;
reg [3:0] next_st_counter;
reg [3:0] st_counter;
wire ge_st_counter;
wire ge_seq_start;
//wire seq_start_data;
wire ge_trans_next;
wire csi_slave_stop;
wire ge_dshift;
reg seq_start;
wire d_shift_data;
wire trans_next_set; 
wire d_shift_clr;
wire seq_start_clr;
wire trans_next_data;
wire seq_start_data;

// State Decode
assign C_IDLE   = (current_state != START) & (current_state != SEND) & (current_state != PARITY) & (current_state != STOP);
assign C_START  = (current_state == START);
assign C_SEND   = (current_state == SEND);
assign C_PARITY = (current_state == PARITY);
assign C_STOP   = (current_state == STOP);
assign N_START  = (next_state == START);
assign N_SEND   = (next_state == SEND);
assign N_PARITY = (next_state == PARITY);
assign N_STOP   = (next_state == STOP);


// Make common gating signal for seq_start, d_shift_delay, trans_next_state
wire ge_common = ge_trans_next | ge_dshift | ge_seq_start;
QLK0RSAU04R2V1_STATDSEL_C1 statdsel(
    .trans_next_data(trans_next_data), .ge_trans_next(ge_trans_next), .trans_next_set(trans_next_set),
    .trans_next_state(trans_next_state),
    .d_shift_data(d_shift_data), .ge_dshift(ge_dshift), .d_shift_clr(d_shift_clr), .d_shift_delay(d_shift_delay),
    .seq_start_data(seq_start_data), .ge_seq_start(ge_seq_start), .seq_start_clr(seq_start_clr),
    .seq_start(seq_start));


// Brate counter adjust control
   wire asresetz = scanmode ? peresetz : brate_adj;
   wire bcnt_clear;
   reg         adjust_mask;
   always@(posedge peclk or negedge asresetz)
     if (~asresetz)      adjust_mask <= 1'b0;
     else if (eint&ssec) adjust_mask <= 1'b0;
     else if ((C_START | C_SEND | C_PARITY ) & bcnt_clear) adjust_mask <= 1'b1;
      
   assign bcnt_clear = bcnt_restart & ~(C_START&~trans_next_state&~baud_borrow_noclr) & ~adjust_mask & tsf;
    
// CSI Slave mode(dap=1) signal
wire   csi_slave_dap1 = csi_slave_mode & dap;

// This is load_trg(SDR->SPR) mask signal (dap=1)
//  SCKI      ~~~~~~~~~~~~~~|________|~~~~~~~~~|______
//                   ________________ ________________
//  SIN       XXXXXXX________________X________________
//                          O
//          This is 1st clock edge of CSI Slave.
//          So load_trg(count_start_trg) is triggered, but in this transmission format,
//           SAU capture 1st receive bit.
wire   csi_slave_ld_mask = (csi_slave_dap1 & ~txe & rxe)   // mask start load_trig by csi slave dap=1
                           | (csi_slave_mode & txe & seq_start) // mask seq-start load_trg by csi slave
                           | (uart_recv & tsf);            // mask load_trig by falling SIN (avoiding over-write SPR)

// This is CSI slave start signal at 1st SCKI edge in the case of no writing send data.
wire   csi_slave_dap1_start = csi_slave_dap1 & ~tsf & start_slave;

// This is CSI slave stop process at dap=0 
//      SCKI   ________|~~~~~~~~~~~~~~~~~~~~~
// state_trans ________|~~~~|________________
//                        ^^^ Generate this timing
//             __________ __ ________________
//      state  ____S_____XS_X___I____________
assign csi_slave_stop = csi_slave_mode & ~dap & last_state & trans_next_state;

// This is gating signal for trans_next_state register
//assign ge_trans_next = (count_start_trg | count_clock | csi_slave_stop | st_trg) & se;

// This is State transfer, Data Shift control register
//      brate        ______|~|_____|~|_____|~|_____|~|_____|~|_____|~|_____|~|_____
//  trans_next_state ________|~~~~~~~|_______|~~~~~~~|_______|~~~~~~~|_______|~~~~~
//                           O       X       O       X       O       X       O
//                      O:Data Shift/Capture Timing
//                      X:State Transfer Timing

//wire trans_next_data;
assign trans_next_set = (~state_trans | csi_slave_dap1_start) & ~st_trg 
                      & ~(~state_trans & bcnt_clear); // add baud-counter adjustment
//assign ge_trans_next = (count_start_trg | count_clock | csi_slave_stop | st_trg) ;
assign ge_trans_next = (count_start_trg | count_clock | st_trg | bcnt_clear) ;
//assign  trans_next_data = ge_trans_next ? trans_next_set : trans_next_state;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)           trans_next_state <= 1'b0;
//   else if (ge_trans_next)  trans_next_state <= trans_next_set;
  else if (ge_common)       trans_next_state <= trans_next_data;
end

// 2 stop timing on UART receive function(Start by noise, Stop)
//    1.   SIN   ~~~~~~|______|~~~~~~~~~~~~~~~~~~~~
//      1/2Brate ______|_________|________|________
//               IDLE  X Start   X IDLE
//    2.1/2Brate ____|______|______|______|______
//                   X Parity      X Stop X Idle
wire uart_stop_pre = uart_recv & ~trans_next_state & ((C_START & sin_sel) | (C_STOP & st_counter_end));
assign uart_stop = uart_stop_pre & count_clock;

// source of state transition timing (Normal State transition)
assign s_trans = (trans_next_state | uart_stop_pre | (~trans_next_state & bcnt_clear)) & count_clock;

// State transition signal
assign state_trans = count_start_trg | s_trans | st_trg ;

// Data Shift/Capture Timing
assign d_shift_normal = (~trans_next_state & (C_SEND | (C_SEND & bcnt_clear)) & count_clock) | csi_slave_dap1_start ;

wire d_shift_set = d_shift_normal;
assign d_shift_clr = st_trg | d_shift_delay;
assign ge_dshift = d_shift_set | d_shift_clr;
//assign d_shift_data = ge_dshift ? ~d_shift_clr : d_shift_delay;

always@(posedge peclk or negedge peresetz)
  if (~peresetz)      d_shift_delay <= 1'b0;
//   else if (ge_dshift) d_shift_delay <= ~d_shift_clr;
  else if (ge_common) d_shift_delay <= d_shift_data;

wire csi_master = ~ccs2 & md_csi & ~fast_mode;
assign d_shift = csi_master ? d_shift_delay : d_shift_normal;

// SCKO Toggle Timing
wire   sck_toggle = (~trans_next_state & count_clock) | csi_slave_dap1_start; // add for SCKO

// This is Serial Last State
assign last_state = (C_SEND & st_counter_end & ~pstate_on & no_stopbit) | // finish on SEND state
                    (C_PARITY & no_stopbit) |                             // finish on PARITY state
                    (C_STOP & st_counter_end) ;                           // finish on STOP state

// This is Serial Finish timing
assign fin_timing = last_state & state_trans;
// This is SDR->SPR load signal for Seq-send
assign sdr_load = fin_timing & seq_start;
// This is the end of serial
assign seri_fin = fin_timing & (~seq_start | (ccs2 & ~dap));

//===========================//
//   Next State combination  //
//===========================//
always@(count_start_trg or sin_sel or st_counter_end or st_trg or
        md_uart or pstate_on or no_stopbit or uart_recv or
        seq_start or trans_next_state or ccs2 or dap or
        C_START or C_SEND or C_PARITY or C_STOP) begin
  next_state = IDLE;

  // Stop for write ST register
  if (st_trg)  begin
    next_state = IDLE;
  end
  else begin
    // Normal State Transition
    if (count_start_trg) begin
       if   (md_uart) next_state = START;   // IDLE -> START
       else           next_state = SEND;    // IDLE -> SEND
    end

    if (C_START) begin
      if (uart_recv & sin_sel & ~trans_next_state)
                                       next_state = IDLE;  // START -> IDLE
      else                             next_state = SEND;  // START -> SEND
    end

    if (C_SEND) begin
      if (st_counter_end) begin
        if (pstate_on)         next_state = PARITY; // SEND -> PARITY
        else if (~no_stopbit)  next_state = STOP;   // SEND -> STOP
        else if (seq_start & ~(ccs2 & ~dap)) begin
          //if (md_uart)         next_state = START;  // SEND -> START
          //else                 next_state = SEND;   // SEND -> SEND(next flame)
          next_state = SEND;
        end
        else                   next_state = IDLE;   // SEND -> IDLE
      end
      else                     next_state = SEND;   // SEND -> SEND(continue transfer)
    end

    if (C_PARITY) begin
      if (~no_stopbit)       next_state = STOP;    // PARITY -> STOP
      else if (seq_start & ~(ccs2 & ~dap)) begin
        //if (md_uart)         next_state = START;   // SEND -> START
        //else                 next_state = SEND;    // SEND -> SEND(next flame)
        next_state = SEND;
      end
      else                   next_state = IDLE;    // PARITY -> IDLE    
    end

    if (C_STOP) begin
      if (st_counter_end) begin
        if (seq_start & ~(ccs2 & ~dap)) begin
          //if (md_uart)           next_state = START;  // STOP -> START
          //else                   next_state = SEND;   // STOP -> SEND
          next_state = SEND;
        end
        else                     next_state = IDLE;   // STOP -> IDLE
      end
      else                       next_state = STOP;   // STOP -> STOP
    end
  end

end

// This is the FSM register
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        current_state <= IDLE;
  else if (state_trans) current_state <= next_state;
end

// Data length Counter/ Stop bit length Counter
assign st_counter_end = ~|st_counter;

// Data length Decoder
assign data_length = (dls == 2'b01) ? 4'b1000 : {2'b01,dls};

// Stop bit length Decoder
//always@(slc) begin
//  case (slc) //synopsys parallel_case
//    1'b1 : stop_length = 3'b000;
//    default: stop_length = 3'b000;
//  endcase
//end


// Data Length Load Timing (IDLE->SEND, START->SEND, SEND->SEND, STOP->SEND, PARITY->SEND)
assign dl_set = N_SEND;

// This is the select signal of st_counter load value
assign st_load_val = dl_set ? data_length : {4'b0000};

                    // Data length load              Data/Stop length load
assign load_stcnt = (~C_SEND & N_SEND) | (C_SEND & st_counter_end);
assign run_stcnt = (C_SEND | C_STOP) & ~st_counter_end ;

// Decrementer(-1) of st_counter
QLK0RSAU04R2V1_DEC4_C1 dec4_1 (.out1(next_value),   .in1(st_counter) );
   
// st_counter data selector
always@(load_stcnt or run_stcnt or st_load_val or next_value or st_counter) begin
  case(1'b1) //synopsys parallel_case
    load_stcnt: next_st_counter = st_load_val;     // load count data
    run_stcnt : next_st_counter = next_value[3:0]; // decrement(-1)
    default   : next_st_counter = st_counter;      // keep st_counter
  endcase
end

// Gating signal of st_counter
assign ge_st_counter = (load_stcnt | run_stcnt) & (s_trans | count_start_trg);

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)           st_counter <= 4'b0000;
  else if (ge_st_counter)  st_counter <= next_st_counter;
end

// Sequencial start(except of CSI slave & UART receive)
wire seq_start_end = (ccs2 & ~dap) ? start_slave & ~tsf : fin_timing;

wire seq_start_set = (~C_IDLE & we_sdr) & ~fin_timing & ~uart_recv ;
assign seq_start_clr = st_trg | seq_start_end;
assign ge_seq_start = seq_start_set | seq_start_clr;
//assign seq_start_data = ge_seq_start ? ~seq_start_clr : seq_start;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)          seq_start <= 1'b0;
//   else if (ge_seq_start)  seq_start <= ~seq_start_clr;
  else if (ge_common)     seq_start <= seq_start_data;
end

// This is ACK timing signal at IIC/SCIF
//assign ack_timing = (st_counter == {1'b0,stop_length}) & C_STOP;
assign ack_timing = C_STOP;

endmodule

module QLK0RSAU04R2V1_STATDSEL_C1(
    trans_next_data, ge_trans_next, trans_next_set, trans_next_state,
    d_shift_data, ge_dshift, d_shift_clr, d_shift_delay,
    seq_start_data, ge_seq_start, seq_start_clr, seq_start);

output trans_next_data;
input  ge_trans_next;
input  trans_next_set;
input  trans_next_state;
output d_shift_data;
input  ge_dshift;
input  d_shift_clr;
input  d_shift_delay;

output seq_start_data;
input  ge_seq_start;
input  seq_start_clr;
input  seq_start;


wire trans_next_data = ge_trans_next ? trans_next_set : trans_next_state;
wire d_shift_data = ge_dshift ? ~d_shift_clr : d_shift_delay;
wire seq_start_data = ge_seq_start ? ~seq_start_clr : seq_start;

endmodule



// Flag sub-module
module QLK0RSAU04R2V1_FLAG_C1 (
                         peclk, peresetz, mck,
                         peri_write, sel_sir, we_ulhw, we_sdr,
                         se, count_clock, ccs2, dap, st_trg,
                         count_start_trg, sdr_load_timing, re_sdr,
                         seq_start, uart_stop,
                         d_shift, ack_timing, state_trans, seri_fin,
                         md_iic,
                         uart_recv, csi_slave_mode,
                         C_STOP, C_PARITY,
                         slc,
                         pcheck_on, odd_parity,
                         rxe, txe, sin_sel,
                         send_data_out,
                         trans_next_state,
                         fin_timing,
                         ovf, parity_out, pef,
                         fef, tsf, bff,
                         set_ovf, set_fef, set_pef,
                         clr_ovf, clr_fef, clr_pef,
                         borrow_register, ssec, error_gen, bcnt_clear
                          );

input peclk;
input peresetz;
input mck;
input [2:0] peri_write;
input slc;
input sel_sir;
input we_ulhw;
input we_sdr;
input se;
input count_clock;
input ccs2;
input dap;
input count_start_trg;
input sdr_load_timing;
input re_sdr;
input seq_start;
input uart_stop;
input d_shift;
input ack_timing;
input state_trans;
input md_iic;
input uart_recv;
input csi_slave_mode;
input C_STOP;
input C_PARITY;
input pcheck_on;
input odd_parity;
input txe;
input rxe;
input sin_sel;
input send_data_out;
input trans_next_state;
input fin_timing;
input st_trg;
input seri_fin;
input ssec;
input bcnt_clear;

output ovf;
output parity_out;
output pef;
output fef;
output tsf;
output bff;
output set_ovf;
output set_fef;
output set_pef;
output clr_ovf;
output clr_fef;
output clr_pef;
output borrow_register;
output error_gen;

wire orct_trg;
wire fect_trg;
wire pect_trg;
wire we_sir;
wire ge_recv_hold;
//wire data_recv_hold;
//wire ge_brow;
//wire dt_brow_reg;
reg borrow_register;
wire recv_hold;
wire clr_ovf;
wire ovr_err;
wire slave_err;
//wire data_ovf;
wire ge_ovf;
reg ovf;
wire ge_pari_check;
wire iic_ack_timing;
wire pcheck_timing;
wire p_src_data;
wire parity_out;
reg pari_check;
wire ge_pef;
wire pef_data;
reg pef;
wire ge_fef;
wire fef_data;
reg fef;
reg  tsf;
wire ge_tsf;
wire tsf_src;
//wire tsf_data;
wire set_sdff;  //wire set_bff;
wire clr_sdff;  //wire clr_bff;
wire ge_sdff;   //wire ge_bff;
reg  sdff;      //reg bff;
wire sdff_data; //wire bff_data;
wire bff;
wire recv_hold_data, ovf_data, pc_data;

// This is clear trigger assignment
assign orct_trg = peri_write[0];
assign pect_trg = peri_write[1];
assign fect_trg = peri_write[2];
// SIR register write signal
assign we_sir = sel_sir & we_ulhw;


//-------------------------------------------------------------------------------//
// borrow_register is receive data holding  //
//-------------------------------------------------------------------------------//

// make common gating signal of recv_hold, ovf, sdff
wire ge_flag1 = ge_recv_hold | ge_ovf | ge_sdff;

QLK0RSAU04R2V1_FLGDSEL1_C1 flgsel1(.recv_hold_data(recv_hold_data), .ge_recv_hold(ge_recv_hold), 
                                   .sdr_load_timing(sdr_load_timing), .st_trg(st_trg), .recv_hold(recv_hold),
                                   .ovf_data(ovf_data), .ge_ovf(ge_ovf), .set_ovf(set_ovf), .ovf(ovf),
                                   .sdff_data(sdff_data), .ge_sdff(ge_sdff), .clr_sdff(clr_sdff), .sdff(sdff));

       // recv_hold gating signal
assign ge_recv_hold =  (sdr_load_timing) // set timing on data receive
                       | (recv_hold & re_sdr)         // clear timing at read-out received data
                       | st_trg ;                     // clear timing at ST Stop trigger
       // recv_hold data signal
//assign data_recv_hold = ge_recv_hold ? sdr_load_timing & ~st_trg : recv_hold; // set is high priority

// borrow register data and gating signal
//assign ge_brow = ge_recv_hold & se;

always @( posedge peclk or negedge peresetz ) begin
  if(~peresetz)           borrow_register <= 1'b0;
//   else if (ge_recv_hold)  borrow_register <= sdr_load_timing & ~st_trg;
  else if (ge_flag1)      borrow_register <= recv_hold_data;
end
assign recv_hold = borrow_register;

//--------------------------------------------------------------------------------------------------------//
// OVF flag share the 3 function counter overflow, serial over-run error, and serial slave data-not-ready //
//--------------------------------------------------------------------------------------------------------//
       // over-run error clear condition
assign clr_ovf = we_sir &  orct_trg;
       // over-run error set condition. It's cause by next data receive or write SDR at recv_hold=1
       //       and receive end timing and write sdr timing
assign ovr_err = (recv_hold & ((sdr_load_timing & ~re_sdr) | we_sdr)) | (sdr_load_timing & we_sdr);
       // OVF set condition (for CSI Slave Send Data un-ready Status)
assign slave_err = csi_slave_mode & count_start_trg & txe & ~sdff;
wire set_ovf = (ovr_err | slave_err) & ~st_trg;

// ovf flag data and gating signal
assign ge_ovf = set_ovf | clr_ovf;
// assign ovf_data = ge_ovf ? set_ovf : ovf;

always @(posedge peclk or negedge peresetz) begin
  if (~peresetz)        ovf <= 1'b0;
//   else if (ge_ovf)      ovf <= set_ovf;
  else if (ge_flag1)    ovf <= ovf_data;
end

//-----------//
// BFF flag  //
//-----------//
assign bff = sdff | recv_hold; // New BFF flag

assign set_sdff = txe & we_sdr & se;
assign clr_sdff = (count_start_trg     // send data load(SDR->SPR) timing
                   | (txe & fin_timing & (~ccs2 | (ccs2&dap)))  // Seq-send start timing
                   | st_trg) & sdff ;

// sdff gating and data signal
assign ge_sdff = (set_sdff | clr_sdff) ;
// assign sdff_data = ge_sdff ? ~clr_sdff : sdff; // clear is high priority

always @( posedge peclk or negedge peresetz ) begin
  if(~peresetz)      sdff <= 1'b0;
//  else if (ge_sdff)   sdff <=  ~clr_sdff;
  else if (ge_flag1) sdff <= sdff_data;
end



//--------------------------------------------------------------------//
// pari_check is parity check status register until data receive end  //
//--------------------------------------------------------------------//
wire fef_tmp_set,fef_tmp_clr,ge_fef_tmp, fef_tmp_data;
reg pari_check_data;
reg fef_tmp;

// make common gating signal of pari_check, pef, fef_tmp, fef
wire ge_pef_fef_common = (mck|we_sir) ;
wire ge_flag2 = ge_pari_check | ge_pef_fef_common | ge_fef_tmp;

QLK0RSAU04R2V1_FLGDSEL2_C1 flgsel2(
 .pc_data(pc_data), .ge_pari_check(ge_pari_check), .pari_check_data(pari_check_data), .pari_check(pari_check),
 .pef_data(pef_data), .ge_pef_fef_common(ge_pef_fef_common), .ge_pef(ge_pef), .set_pef(set_pef), .pef(pef), 
 .fef_tmp_data(fef_tmp_data), .ge_fef_tmp(ge_fef_tmp), .fef_tmp_clr(fef_tmp_clr), .fef_tmp(fef_tmp),
 .fef_data(fef_data), .ge_fef(ge_fef), .set_fef(set_fef), .fef(fef));

// This is pari_check data signal (for Power Compiler extracting gating signal, avoiding logical complexity)
wire iic_ack_data = sin_sel & txe;
always@(iic_ack_timing or pcheck_timing or d_shift or
        iic_ack_data or parity_out or sin_sel or p_src_data or pari_check)
begin
  casex ({iic_ack_timing, pcheck_timing, d_shift}) //synopsys parallel_case
   3'b1xx: pari_check_data = iic_ack_data;
   3'b01x: pari_check_data = parity_out ^ sin_sel;
   3'b001: pari_check_data = p_src_data ^ pari_check;
   default: pari_check_data = 1'b0;
  endcase
end

wire pari_check_en = pcheck_on & rxe;

// this is ack timing for IIC mode
assign iic_ack_timing = md_iic & ack_timing & ~state_trans;
// this is parity check timing 
assign pcheck_timing = pari_check_en & C_PARITY & (~state_trans|(bcnt_clear&~trans_next_state)) ;

// source data for parity check, receive->SIN, send->SOUT
assign p_src_data = rxe ? sin_sel : send_data_out;

// Parity data output signal(-> OUTCTL sub-module)
assign parity_out = (odd_parity ? ~pari_check : pari_check) & pcheck_on ;

// gating signal for pari_check
wire pari_initialize = count_start_trg | (fin_timing & seq_start);
assign ge_pari_check = d_shift | ((pcheck_timing | iic_ack_timing) & count_clock) | pari_initialize ;

// assign pc_data = ge_pari_check ? pari_check_data : pari_check;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     pari_check <= 1'b0;
//   else if (ge_pari_check)  pari_check <= pari_check_data;
  else if (ge_flag2)  pari_check <= pc_data;
end

//------------------------//
// PEF parity error flag  //
//------------------------//
wire src_pef = (fin_timing & (pari_check_en | md_iic)) & pari_check & count_clock ;
wire set_pef = src_pef & ~st_trg ;
wire clr_pef = (we_sir & pect_trg) ;  // pef clear timing

assign ge_pef = src_pef | clr_pef ;
// assign pef_data = ge_pef_fef_common ? (ge_pef ? set_pef : pef) : pef; // set is high priority

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)                  pef <= 1'b0;
//   else if (ge_pef_fef_common)     pef <= pef_data;
  else if (ge_flag2)     pef <= pef_data & ~ssec;
end

//-----------------------------------------//
// Flaming Error Flag share for seq_start  //
//-----------------------------------------//
assign fef_tmp_set = ~sin_sel & ~trans_next_state & C_STOP & count_clock & uart_recv ;
assign fef_tmp_clr = count_start_trg ; // Clear only start timing
assign ge_fef_tmp = (fef_tmp_set | fef_tmp_clr);
// assign fef_tmp_data = ge_fef_tmp ? ~fef_tmp_clr : fef_tmp;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)             fef_tmp <= 1'b0;
//   else if (ge_fef_tmp_data)  fef_tmp <= ~fef_tmp_clr;
  else if (ge_flag2)   fef_tmp <= fef_tmp_data;
end

// fef check timing 1/2 Stop state
wire clr_fef;
wire set_fef_timing =  fin_timing & C_STOP & uart_recv & ~st_trg;
wire set_fef_src = ~sin_sel;
wire set_fef_suspend = fef_tmp ;
wire set_fef = ((slc == 1'b1) ? set_fef_src : set_fef_suspend) & set_fef_timing ;
assign clr_fef = (we_sir & fect_trg);

// gating signal for fef
assign ge_fef = set_fef | clr_fef;

// assign fef_data = ge_fef ? set_fef : fef ; 

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)    fef <= 1'b0;
//  else if (ge_pef_fef_common) fef <= fef_data;
  else if (ge_flag2) fef <= fef_data & ~ssec;
end

//----------//
// TSF flag //
//----------//
assign ge_tsf = count_start_trg | uart_stop | seri_fin | st_trg;
assign tsf_src = ~(uart_stop | seri_fin | st_trg) ; // clear is high priority, reduce redundant logic


always @(posedge peclk or negedge peresetz) begin
  if (~peresetz)       tsf <= 1'b0;
  else if (ge_tsf)     tsf <= tsf_src;
end


// To mask sdr_load_timing
wire error_gen = set_pef | set_fef;

endmodule

module QLK0RSAU04R2V1_FLGDSEL1_C1( recv_hold_data, ge_recv_hold, sdr_load_timing, st_trg, recv_hold,
                                   ovf_data, ge_ovf, set_ovf, ovf,
                                   sdff_data, ge_sdff, clr_sdff, sdff);

output recv_hold_data;
input ge_recv_hold;
input sdr_load_timing;
input st_trg;
input recv_hold;
output  ovf_data;
input ge_ovf;
input set_ovf;
input ovf;
output sdff_data;
input ge_sdff;
input clr_sdff;
input sdff;

wire recv_hold_data = ge_recv_hold ? sdr_load_timing & ~st_trg : recv_hold;
wire ovf_data = ge_ovf ? set_ovf : ovf;
wire sdff_data = ge_sdff ? ~clr_sdff : sdff; // clear is high priority

endmodule

module QLK0RSAU04R2V1_FLGDSEL2_C1(
 pc_data, ge_pari_check, pari_check_data, pari_check,
 pef_data, ge_pef_fef_common, ge_pef, set_pef, pef, 
 fef_tmp_data, ge_fef_tmp, fef_tmp_clr, fef_tmp,
 fef_data, ge_fef, set_fef, fef);

output pc_data;
input  ge_pari_check;
input  pari_check_data;
input  pari_check;

output pef_data;
input  ge_pef_fef_common;
input  ge_pef;
input  set_pef;
input  pef;

output fef_tmp_data;
input  ge_fef_tmp;
input  fef_tmp_clr;
input  fef_tmp;

output fef_data;
input  ge_fef;
input  set_fef;
input  fef;

wire pc_data = ge_pari_check ? pari_check_data : pari_check;
wire pef_data = ge_pef_fef_common ? (ge_pef ? set_pef : pef) : pef; 
wire fef_tmp_data = ge_fef_tmp ? ~fef_tmp_clr : fef_tmp;
wire fef_data = ge_fef ? set_fef : fef ; 

endmodule


// INT sub-module
module QLK0RSAU04R2V1_INT_C1 (
                         peclk, peresetz,
                         count_start_trg,
                         md0, dap, csi_slave_mode,
                         last_state, seq_start, state_trans,
                         st_trg,
                         eoc, ovf, fef, pef, set_ovf, set_fef, set_pef,
                         clr_ovf, clr_fef, clr_pef,
                         se,
                         int_sig, eint );

input peclk;
input peresetz;
input md0;
input dap;
input csi_slave_mode;
input last_state;
input seq_start;
input state_trans;
input st_trg;
input se;
input count_start_trg;
input eoc;
input ovf;
input fef;
input pef;
input set_ovf;
input set_fef;
input set_pef;
input clr_ovf;
input clr_fef;
input clr_pef;

output int_sig;
output eint;

wire buf_emp;
wire t_end;
wire int_seri;
wire ge_int;
reg int_sig;
wire pre_eint ;
reg eint;
//
wire set_eint, clr_eint, ge_eint, data_eint;
wire int_sig_data;

wire ge_int_eint = ge_int | ge_eint;

// Serial function source of INT signal
assign buf_emp = count_start_trg | (last_state & seq_start & ~(csi_slave_mode & ~dap)); // buffer empty interrupt
assign t_end = last_state ;  // transfer end interrupt
wire eoc_mask = eoc & ((ovf&~clr_ovf) | (fef&~clr_fef) | (pef&~clr_pef)
                         | set_ovf | set_fef | set_pef);
assign int_seri = (md0 ? buf_emp : t_end) & state_trans & ~eoc_mask & ~st_trg; // Serial mode


// int_sig gating and data signal
assign ge_int = int_seri | int_sig;
//assign int_sig_data = int_seri & se;
//assign int_sig_data = ge_int ? int_seri & se : int_sig;


assign pre_eint = ( set_ovf | set_fef | set_pef ) & eoc;
assign set_eint = pre_eint;
assign clr_eint = ~set_eint & eint;
assign ge_eint = set_eint | clr_eint;
//assign data_eint = ge_eint ? set_eint : eint;

QLK0RSAU04R2V1_INTDSEL_C1 intdsel( .data_eint(data_eint), .ge_eint(ge_eint), .set_eint(set_eint),
                                   .eint(eint), 
                                   .int_sig_data(int_sig_data), .ge_int(ge_int), .int_seri(int_seri),
                                   .se(se), .int_sig(int_sig));
   
   
always @( posedge peclk or negedge peresetz ) begin
    if(~peresetz) begin
            int_sig <= 1'b0;
            eint <= 1'b0;
      end
    else if (ge_int_eint) begin
            int_sig <= int_sig_data;
            eint <= data_eint;
      end
end

endmodule

module QLK0RSAU04R2V1_INTDSEL_C1( data_eint, ge_eint, set_eint, eint,
                                  int_sig_data, ge_int, int_seri, se, int_sig );
output data_eint;
output int_sig_data;

input ge_eint;
input set_eint;
input eint;
input ge_int;
input int_seri;
input se;
input int_sig;

wire data_eint = ge_eint ? set_eint : eint;
wire int_sig_data = ge_int ? int_seri & se : int_sig;

endmodule


// OUTCTL sub-module
module QLK0RSAU04R2V1_OUTCTL_C1 (
                           count_start_trg, st_trg, s_trans, fin_timing,
                           last_state, seq_start,
                           N_START, N_SEND, N_PARITY, N_STOP,
                           C_IDLE, C_STOP,
                           trans_next_state,
                           sdr, count_register,
                           data_8bit, data_9bit,
                           dir, txe, md_iic, md_uart,
                           count_clock, sck_toggle,
                           parity_out, dap, ckp, ccs2, csi_slave_mode,
                           seri_dout_timing, seri_dout,
                           sck_timing, sck_data,
                           send_data_out );

input count_start_trg;
input st_trg;
input s_trans;
input fin_timing;
input last_state;
input seq_start;
input N_START;
input N_SEND;
input N_PARITY;
input N_STOP;
input C_IDLE;
input C_STOP;
input trans_next_state;
input [15:0] sdr;
input [15:0] count_register;
input data_8bit;
input data_9bit;
input dir;
input txe;
input md_iic;
input md_uart;
input count_clock;
input sck_toggle;
input parity_out;
input dap;
input ckp;
input ccs2;
input csi_slave_mode;

output seri_dout_timing;
output seri_dout;
output sck_timing;
output sck_data;
output send_data_out;

wire seri_dout_timing;
wire start_bit;
wire parity_bit;
wire stop_bit;
wire load_from_sdr;
wire [15:0] src_of_dout;
reg  msb_out;
reg  pre_seri_dout;
wire seri_dout;
wire sck_timing;
wire sck_data;

// Serial Data output timing
wire iic_default = (md_iic & fin_timing & ~seq_start); // This is IIC default value (SOUT = "H")
wire csi_slv_out = ~(csi_slave_mode & ~dap) & seq_start ;
assign seri_dout_timing  = (count_start_trg | (s_trans & (~last_state|csi_slv_out)) | iic_default) & ~st_trg ;
// Start bit output timing
assign start_bit = N_START;
// Parity bit output timing
assign parity_bit = N_PARITY;
// Stop bit output timing
assign stop_bit = N_STOP;

// At start timing, SDR data doesnot load SPR register, 
// So SOUT is load from SDR register at this timing.
assign load_from_sdr = (C_IDLE & N_SEND & ~seq_start) | (last_state & seq_start & ~(ccs2 & ~dap));

// Serial output data selector
assign src_of_dout = load_from_sdr ? sdr : count_register;

// MSB first output data selector
always@(data_8bit or data_9bit or src_of_dout) begin
  case(1'b1) //synopsys parallel_case
    //data_5bit:  msb_out = src_of_dout[4];
    data_8bit:  msb_out = src_of_dout[7];
    data_9bit:  msb_out = src_of_dout[8];
    default:  msb_out = src_of_dout[6];
  endcase
end


// MSB/LSB selector
wire send_data_out = dir ? src_of_dout[0] : msb_out;

// IIC/SCIF output data at stop state
wire stop_data = md_iic ? txe : 1'b1;

// data output
always@(start_bit or parity_bit or stop_bit or iic_default or
        parity_out or stop_data or send_data_out ) begin
  casex ({start_bit, parity_bit, stop_bit, iic_default})
    4'b1xxx: pre_seri_dout = 1'b0;
    4'bx1xx: pre_seri_dout = parity_out;
    4'bxx1x: pre_seri_dout = stop_data;
    4'b0001: pre_seri_dout = 1'b1;
    default: pre_seri_dout = send_data_out;
  endcase
end

assign seri_dout =  pre_seri_dout;

//++++====++++====++++==== SCKO_SRC ++====++++====++++====++++====+//
       // SCK toggle timing

wire   mask_stop = ((N_STOP & trans_next_state & ~dap) | C_STOP) & ~(seq_start & fin_timing);
wire   sck_tim_pre = count_start_trg |        // start timing
                     (count_clock & ~( ((~dap & fin_timing&(~seq_start|ccs2) ) | mask_stop) & ~md_iic));
assign sck_timing = sck_tim_pre & ~md_uart & ~st_trg ;
assign sck_data = (dap ^ ckp) ? ~sck_toggle : sck_toggle;

endmodule



module QLK0RSAU04R2V1_MAIN_B0 (
                         peclk, pclkrw, peresetz,
                         ck0, ck1, 
                         peri_write, common_write, re_sdr,
                         sel_sdr, sel_smr, sel_scr, sel_sir,
                         wr_st, wr_so,
                         wr_soe, wr_sol,
                         we_ulhw, we_lhw, we_uhw,
                         sdr_data, smr_data, scr_data, ssr_data,
                         se, soe, sol,
                         count_clock,
                         md_uart, md_iic,
                         stss_all,
                         sin, sin_direct, scki,
                         sout, scko, int_sig, eint,
                         mck, fast_mode, ack_timing
                         
                         );

input peclk;
input pclkrw;
   
input peresetz;
input ck0;
input ck1;
input [15:0] peri_write;
input [1:0] common_write;
input re_sdr;
input sel_sdr;
input sel_smr;
input sel_scr;
input sel_sir;
input wr_st;
input wr_soe;
input wr_so;
input wr_sol;
input we_ulhw;
input we_lhw;
input we_uhw;
input stss_all;
input sin;
input sin_direct;
input scki;
   
output [15:0] sdr_data;
output [15:0] smr_data;
output [15:0] scr_data;
output [15:0] ssr_data;
output se;
output soe;
output sol;
output count_clock;
//output st_sel_trg;
output md_uart;
output md_iic;
output sout;
output scko;
output int_sig;
output eint;
output mck;
output fast_mode;
output ack_timing;
   
//===========================================//
//           wire definition                 //
//===========================================//
// SMR register
wire cks;
wire ccs;
wire sts;
wire sis;
wire [2:0] md;
wire md0 = md[0];
assign smr_data={cks, ccs, 5'b00000, sts, 1'b0, sis, 3'b100, md};

// SCR register
wire txe;
wire rxe;
wire dap;
wire ckp;
wire eoc;
wire [1:0] ptc;
wire dir;
wire [1:0] slc;
wire [1:0] dls;
assign scr_data = {txe, rxe, dap, ckp, 1'b0, eoc, ptc, dir, 1'b0, slc, 2'b01, dls};

//
wire [15:0] sdr_data;
wire [15:0] spr;
wire [15:0] sdr;
   
assign sdr_data = sdr;

wire start_slave;

// SSR Status Register;
wire tsf, bff, fef, pef, ovf;
wire eint;
assign ssr_data = {9'h000, tsf, bff, 2'h0, fef, pef, ovf};

// Other
wire seri_dout, seri_dout_timing;
wire scki_rise, scki_fall, scki_both;
wire sin_level, sin_latch;
wire md_csi, md_iic;
wire b_count_clock;
wire txrx_on;
wire pstate_on, pcheck_on, odd_parity /*, even_parity */ ;		// not drive anything : by yama
wire no_stopbit;
wire data_7bit, data_8bit; 
wire st_trg;
wire seri_fin;
wire csi_slave_stop;
wire baud_borrow;
wire sck_timing, sck_data;
wire count_start_trg;
wire ge_sout, ge_scko;

QLK0RSAU04R2V1_SOCTL_B0 soctl (
                     .peclk(peclk), .peresetz(peresetz),
                     .wr_so(wr_so),
                     .common_write(common_write[0]), .soe(soe), .sol(sol),
                     .seri_dout(seri_dout), .seri_dout_timing(seri_dout_timing),
                     .sout(sout), .ge_sout(ge_sout), .ge_sout_all(ge_sout|ge_scko));

QLK0RSAU04R2V1_EDGECK_B0 edgeck (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .scki(scki), .ccs2(ccs),
                     .scki_rise(scki_rise), .scki_fall(scki_fall), .scki_both(scki_both));

QLK0RSAU04R2V1_EDGEU_B0 edgeu (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .sin(sin), 
                     //.sin_rise(sin_rise), .sin_fall(sin_fall), 
                     .sin_level(sin_level), .sin_latch(sin_latch) );

QLK0RSAU04R2V1_FUNC_B0 func (
                     .peclk(peclk), .pclkrw(pclkrw), .peresetz(peresetz), .mck(mck),
                     .we_ulhw(we_ulhw), .sel_sdr(sel_sdr), .sel_sir(sel_sir),
                     .re_sdr(re_sdr), .peri_write(peri_write), .se(se), 
                     .md0(md0), .dap(dap), 
                     .ckp(ckp), 
                     .count_start_trg(count_start_trg), .count_clock(count_clock), .b_count_clock(b_count_clock),
                     .md_csi(md_csi), .md_uart(md_uart), .md_iic(md_iic),
                     .eoc(eoc),
                     .dls(dls), .slc(slc), .dir(dir), .rxe(rxe), .txe(txe), 
                     .pstate_on(pstate_on), .pcheck_on(pcheck_on),
                     .odd_parity(odd_parity),
                     .no_stopbit(no_stopbit), .ccs2(ccs),
                     .data_7bit(data_7bit), .data_8bit(data_8bit),
                     .sin_level(sin_level), .sin_latch(sin_latch),
                     .st_trg(st_trg), .start_slave(start_slave),
                     .seri_fin_out(seri_fin), .csi_slave_stop(csi_slave_stop),
                     .spr(spr), .sdr_read(sdr), .baud_borrow(baud_borrow),
                     .int_sig(int_sig), .eint(eint), .pef(pef), .fef(fef), 
                     .bff(bff), .ovf(ovf), .tsf(tsf),
                     .seri_dout_timing(seri_dout_timing), .seri_dout(seri_dout), 
                     .sck_timing(sck_timing), .sck_data(sck_data),
                     .fast_mode(fast_mode), .sin_direct(sin_direct), .ack_timing(ack_timing)
                      );


QLK0RSAU04R2V1_REGU_B0 regu (
                     .peclk(pclkrw), .peresetz(peresetz),
                     .we_ulhw(we_ulhw), .we_lhw(we_lhw), .we_uhw(we_uhw),
                     .smr_write({peri_write[15:14],peri_write[2:0]}),
                     .scr_write({peri_write[15:12],peri_write[10:7],peri_write[5:4],peri_write[0]}),
                     .common_write(common_write[0]),
                     .sel_smr(sel_smr), .sel_scr(sel_scr), .wr_soe(wr_soe), .wr_sol(wr_sol),
                     .wr_st(wr_st),
                     .cks(cks), .ccs(ccs), 
                     .sts(sts), .sis(sis), .md(md), .txe(txe), 
                     .rxe(rxe), .dap(dap), .ckp(ckp), .eoc(eoc), .ptc(ptc), 
                     .dir(dir), .slc(slc), .dls(dls), .soe(soe), .sol(sol),
                     .txrx_on(txrx_on),
                     .se(se), .st_trg(st_trg),
                     .stss_all(stss_all),
                     .md_csi(md_csi), .md_uart(md_uart), .md_iic(md_iic),
                     .pstate_on(pstate_on), /* .even_parity(even_parity), */		// not drive anything : by yama
                     .odd_parity(odd_parity), .pcheck_on(pcheck_on), .no_stopbit(no_stopbit), 
                     .data_7bit(data_7bit), .data_8bit(data_8bit)
                     );


QLK0RSAU04R2V1_SCKCTL_B0 sckctl (
                     .peclk(peclk), .peresetz(peresetz), .se(se), 
                     .wr_so(wr_so), .common_write(common_write[1]),
                     .sck_data(sck_data), .sck_timing(sck_timing), .scko(scko),
                     .ge_scko(ge_scko), .ge_sout_all(ge_sout|ge_scko));

QLK0RSAU04R2V1_TRGCTL_B0 trgctl (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .we_ulhw(we_ulhw), 
                     .sel_sdr(sel_sdr),
                     .ck0(ck0), .ck1(ck1), .cks(cks), .dap(dap),
                     .scki_rise(scki_rise), .scki_fall(scki_fall), .scki_both(scki_both), 
                     .ckp(ckp), 
                     .st_trg(st_trg), .baud_borrow(baud_borrow),
                     .se(se), .csi_slave_stop(csi_slave_stop),
                     .ccs(ccs),
                     .txrx_on(txrx_on),
                     .seri_fin(seri_fin),
                     .count_start_trg(count_start_trg),
                     .count_clock(count_clock), .b_count_clock(b_count_clock),
                     .start_slave(start_slave) );
   

endmodule


module QLK0RSAU04R2V1_MAIN_B1 (
                         peclk, pclkrw, peresetz,
                         ck0, ck1, 
                         peri_write, common_write, re_sdr,
                         sel_sdr, sel_smr, sel_scr, sel_sir,
                         wr_st, wr_so,
                         wr_soe, wr_sol,
                         we_ulhw, we_lhw, we_uhw,
                         sdr_data, smr_data, scr_data, ssr_data,
                         se, soe, sol,
                         count_clock,
                         md_uart, md_iic,
                         stss_all,
                         sin, scki,
                         sout, scko, int_sig, eint,
                         mck, fast_mode, sin_direct,
                         ack_timing
                         
                         );

input peclk;
input pclkrw;
   
input peresetz;
input ck0;
input ck1;
input [15:0] peri_write;
input [1:0] common_write;
input re_sdr;
input sel_sdr;
input sel_smr;
input sel_scr;
input sel_sir;
input wr_st;
input wr_soe;
input wr_so;
input wr_sol;
input we_ulhw;
input we_lhw;
input we_uhw;
input stss_all;
input sin;
input sin_direct;
input scki;

output [15:0] sdr_data;
output [15:0] smr_data;
output [15:0] scr_data;
output [15:0] ssr_data;
output se;
output soe;
output sol;
output count_clock;
//output st_sel_trg;
output md_uart;
output md_iic;
output sout;
output scko;
output int_sig;
output eint;
output mck;
output fast_mode;
output ack_timing;
   
//===========================================//
//           wire definition                 //
//===========================================//
// SMR register
wire cks;
wire ccs;
wire sts;
wire sis;
wire [2:0] md;
wire md0 = md[0];
assign smr_data={cks, ccs, 5'b00000, sts, 1'b0, sis, 3'b100, md};

// SCR register
wire txe;
wire rxe;
wire dap;
wire ckp;
wire eoc;
wire [1:0] ptc;
wire dir;
wire slc;
wire [1:0] dls;
assign scr_data = {txe, rxe, dap, ckp, 1'b0, eoc, ptc, dir, 2'b00, slc, 2'b01, dls};

//
wire [15:0] sdr_data;
wire [15:0] spr;
wire [15:0] sdr;
   
assign sdr_data = sdr;

wire start_slave;

// SSR Status Register;
wire tsf, bff, fef, pef, ovf;
wire eint;
assign ssr_data = {9'h000, tsf, bff, 2'h0, fef, pef, ovf};

// Other
wire seri_dout, seri_dout_timing;
wire scki_rise, scki_fall, scki_both;
wire sin_rise, sin_fall, sin_level, sin_latch;
wire md_csi, md_iic;
wire b_count_clock;
wire txrx_on;
wire pstate_on, pcheck_on, odd_parity /* , even_parity */ ;		// not drive anything : by yama
wire no_stopbit;
wire data_7bit, data_8bit; 
wire st_trg;
wire seri_fin;
wire csi_slave_stop;
wire baud_borrow;
wire sck_timing, sck_data;
wire count_start_trg;
wire ge_sout, ge_scko;

QLK0RSAU04R2V1_SOCTL_B1 soctl (
                     .peclk(peclk), .peresetz(peresetz),
                     .wr_so(wr_so),
                     .common_write(common_write[0]), .soe(soe), .sol(sol),
                     .seri_dout(seri_dout), .seri_dout_timing(seri_dout_timing),
                     .sout(sout), .ge_sout(ge_sout), .ge_sout_all(ge_sout|ge_scko));

QLK0RSAU04R2V1_EDGECK_B1 edgeck (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .scki(scki), .ccs2(ccs),
                     .scki_rise(scki_rise), .scki_fall(scki_fall), .scki_both(scki_both));

QLK0RSAU04R2V1_EDGEU_B1 edgeu (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .sin(sin), .sis(sis),
                     .sin_rise(sin_rise), .sin_fall(sin_fall), 
                     .sin_level(sin_level), .sin_latch(sin_latch) );

QLK0RSAU04R2V1_FUNC_B1 func (
                     .peclk(peclk), .pclkrw(pclkrw), .peresetz(peresetz), .mck(mck),
                     .we_ulhw(we_ulhw), .sel_sdr(sel_sdr), .sel_sir(sel_sir),
                     .re_sdr(re_sdr), .peri_write(peri_write), .se(se), 
                     .md0(md0), .dap(dap), 
                     .ckp(ckp), 
                     .count_start_trg(count_start_trg), .count_clock(count_clock), .b_count_clock(b_count_clock),
                     .md_csi(md_csi), .md_uart(md_uart), .md_iic(md_iic),
                     .eoc(eoc),
                     .dls(dls), .slc(slc), .dir(dir), .rxe(rxe), .txe(txe), 
                     .pstate_on(pstate_on), .pcheck_on(pcheck_on),
                     .odd_parity(odd_parity),
                     .no_stopbit(no_stopbit), .ccs2(ccs),
                     .data_7bit(data_7bit), .data_8bit(data_8bit),
                     .sin_level(sin_level), .sin_latch(sin_latch),
                     .st_trg(st_trg), .start_slave(start_slave),
                     .seri_fin_out(seri_fin), .csi_slave_stop(csi_slave_stop),
                     .spr(spr), .sdr_read(sdr), .baud_borrow(baud_borrow),
                     .int_sig(int_sig), .eint(eint), .pef(pef), .fef(fef), 
                     .bff(bff), .ovf(ovf), .tsf(tsf),
                     .seri_dout_timing(seri_dout_timing), .seri_dout(seri_dout), 
                     .sck_timing(sck_timing), .sck_data(sck_data),
                     .fast_mode(fast_mode), .sin_direct(sin_direct),
                     .ack_timing(ack_timing)
                     );


QLK0RSAU04R2V1_REGU_B1 regu (
                     .peclk(pclkrw), .peresetz(peresetz),
                     .we_ulhw(we_ulhw), .we_lhw(we_lhw), .we_uhw(we_uhw),
                     .smr_write({peri_write[15:14],peri_write[8],peri_write[6],peri_write[2:0]}),
                     .scr_write({peri_write[15:12],peri_write[10:7],peri_write[4],peri_write[0]}),
                     .common_write(common_write[0]),
                     .sel_smr(sel_smr), .sel_scr(sel_scr), .wr_soe(wr_soe), /* .wr_sol(wr_sol), */    // not drive anything : by yama
                     .wr_st(wr_st),
                     .cks(cks), .ccs(ccs), 
                     .sts(sts), .sis(sis), .md(md), .txe(txe), 
                     .rxe(rxe), .dap(dap), .ckp(ckp), .eoc(eoc), .ptc(ptc), 
                     .dir(dir), .slc(slc), .dls(dls), .soe(soe), .sol(sol),
                     .txrx_on(txrx_on),
                     .se(se), .st_trg(st_trg),
                     .stss_all(stss_all),
                     .md_csi(md_csi), .md_uart(md_uart), .md_iic(md_iic),
                     .pstate_on(pstate_on), /* .even_parity(even_parity), */		// not drive anything : by yama
                     .odd_parity(odd_parity), .pcheck_on(pcheck_on), .no_stopbit(no_stopbit), 
                     .data_7bit(data_7bit), .data_8bit(data_8bit) );


QLK0RSAU04R2V1_SCKCTL_B1 sckctl (
                     .peclk(peclk), .peresetz(peresetz), .se(se), 
                     .wr_so(wr_so), .common_write(common_write[1]),
                     .sck_data(sck_data), .sck_timing(sck_timing), .scko(scko),
                     .ge_scko(ge_scko), .ge_sout_all(ge_sout|ge_scko));

QLK0RSAU04R2V1_TRGCTL_B1 trgctl (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .we_ulhw(we_ulhw), 
                     .sel_sdr(sel_sdr),
                     .ck0(ck0), .ck1(ck1), .cks(cks), .dap(dap),
                     .scki_rise(scki_rise), .scki_fall(scki_fall), .scki_both(scki_both), 
                     .ckp(ckp), .sin_fall(sin_fall), .sin_rise(sin_rise),
                     .st_trg(st_trg), .baud_borrow(baud_borrow),
                     .se(se), .csi_slave_stop(csi_slave_stop),
                     .sts(sts), .ccs(ccs), .sis(sis),
                     .txrx_on(txrx_on),
                     .seri_fin(seri_fin),
                     .count_start_trg(count_start_trg),
                     .count_clock(count_clock), .b_count_clock(b_count_clock),
                     .start_slave(start_slave) );
   

endmodule


module QLK0RSAU04R2V1_MAIN_C0 (
                         peclk, pclkrw, peresetz,
                         ck0, ck1, 
                         peri_write, common_write, re_sdr,
                         sel_sdr, sel_smr, sel_scr, sel_sir,
                         wr_st, wr_so,
                         wr_soe, wr_sol,
                         we_ulhw, we_lhw, we_uhw,
                         sdr_data, smr_data, scr_data, ssr_data,
                         se, soe, sol,
                         count_clock,
                         md_uart, md_iic,
                         stss_all,
                         sin, sin_direct, scki,
                         sout, scko, int_sig, eint,
                         mck, fast_mode, scanmode, swc,
                         ack_timing
                         );

input peclk;
input pclkrw;  
input peresetz;
input ck0;
input ck1;
input [15:0] peri_write;
input [1:0] common_write;
input re_sdr;
input sel_sdr;
input sel_smr;
input sel_scr;
input sel_sir;
input wr_st;
input wr_soe;
input wr_so;
input wr_sol;
input we_ulhw;
input we_lhw;
input we_uhw;
input stss_all;
input sin;
input sin_direct;
input scki;
input scanmode;
input swc;
   
output [15:0] sdr_data;
output [15:0] smr_data;
output [15:0] scr_data;
output [15:0] ssr_data;
output se;
output soe;
output sol;
output count_clock;
//output st_sel_trg;
output md_uart;
output md_iic;
output sout;
output scko;
output int_sig;
output eint;
output mck;
output fast_mode;
output ack_timing;
   
//===========================================//
//           wire definition                 //
//===========================================//
// SMR register
wire cks;
wire ccs;
wire sts;
wire sis;
wire [2:0] md;
wire md0 = md[0];
assign smr_data={cks, ccs, 5'b00000, sts, 1'b0, sis, 3'b100, md};

// SCR register
wire txe;
wire rxe;
wire dap;
wire ckp;
wire eoc;
wire [1:0] ptc;
wire dir;
wire [1:0] slc;
wire [1:0] dls;
assign scr_data = {txe, rxe, dap, ckp, 1'b0, eoc, ptc, dir, 1'b0, slc, 2'b01, dls};

//
wire [15:0] sdr_data;
wire [15:0] spr;
wire [15:0] sdr;
   
assign sdr_data = sdr;

wire start_slave;

// SSR Status Register;
wire tsf, bff, fef, pef, ovf;
wire eint;
assign ssr_data = {9'h000, tsf, bff, 2'h0, fef, pef, ovf};

// Other
wire seri_dout, seri_dout_timing;
wire scki_rise, scki_fall, scki_both;
wire sin_level, sin_latch;
wire md_csi, md_iic;  
wire b_count_clock;
wire txrx_on;
wire pstate_on, pcheck_on, odd_parity /* , even_parity */ ;		// not drive anything : by yama
wire no_stopbit;
wire data_7bit, data_8bit, data_9bit;
wire st_trg;
wire seri_fin;
wire csi_slave_stop;
wire baud_borrow;
wire sck_timing, sck_data;
wire count_start_trg;
wire async_csi = swc & md_csi & se;
wire ge_sout, ge_scko;

QLK0RSAU04R2V1_SOCTL_C0 soctl (
                     .peclk(peclk), .peresetz(peresetz),
                     .wr_so(wr_so),
                     .common_write(common_write[0]), .soe(soe), .sol(sol),
                     .seri_dout(seri_dout), .seri_dout_timing(seri_dout_timing),
                     .sout(sout), .ge_sout(ge_sout), .ge_sout_all(ge_sout|ge_scko));

QLK0RSAU04R2V1_EDGECK_C0 edgeck (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .scki(scki), .ccs2(ccs), .async_csi(async_csi),
                     .scki_rise(scki_rise), .scki_fall(scki_fall), .scki_both(scki_both));

QLK0RSAU04R2V1_EDGEU_C0 edgeu (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .sin(sin), 
                     //.sin_rise(sin_rise), .sin_fall(sin_fall), 
                     .sin_level(sin_level), .sin_latch(sin_latch) );

QLK0RSAU04R2V1_FUNC_C0 func (
                     .peclk(peclk), .pclkrw(pclkrw), .peresetz(peresetz), .mck(mck),
                     .we_ulhw(we_ulhw), .sel_sdr(sel_sdr), .sel_sir(sel_sir),
                     .re_sdr(re_sdr), .peri_write(peri_write), .se(se), 
                     .md0(md0), .dap(dap), 
                     .ckp(ckp), 
                     .count_start_trg(count_start_trg), .count_clock(count_clock), .b_count_clock(b_count_clock),
                     .md_csi(md_csi), .md_uart(md_uart), .md_iic(md_iic),
                     //.md_seqcsi(md_seqcsi), // Delete R2
                     .eoc(eoc),
                     .dls(dls), .slc(slc), .dir(dir), .rxe(rxe), .txe(txe), 
                     .pstate_on(pstate_on), .pcheck_on(pcheck_on),
                     .odd_parity(odd_parity),
                     .no_stopbit(no_stopbit), .ccs2(ccs),
                     .data_7bit(data_7bit), .data_8bit(data_8bit),
                     .data_9bit(data_9bit),// .data_16bit(data_16bit), // Delere  R2
                     .sin_level(sin_level), .sin_latch(sin_latch),
                     .st_trg(st_trg), .start_slave(start_slave),
                     .scki_thr(scki),
                     //.baud_count_en(baud_count_en), // Delete R2
                     .seri_fin_out(seri_fin), .csi_slave_stop(csi_slave_stop),
                     .spr(spr), .sdr_read(sdr), .baud_borrow(baud_borrow),
                     .int_sig(int_sig), .eint(eint), .pef(pef), .fef(fef), 
                     .bff(bff), .ovf(ovf), .tsf(tsf),
                     .seri_dout_timing(seri_dout_timing), .seri_dout(seri_dout), 
                     .sck_timing(sck_timing), .sck_data(sck_data),
                     .fast_mode(fast_mode), .sin_direct(sin_direct),
                     .scanmode(scanmode), .async_csi(async_csi), .ack_timing(ack_timing)
                      );


QLK0RSAU04R2V1_REGU_C0 regu (
                     .peclk(pclkrw), .peresetz(peresetz),
                     .we_ulhw(we_ulhw), .we_lhw(we_lhw), .we_uhw(we_uhw),
                     .smr_write({peri_write[15:14],peri_write[2:0]}),
                     .scr_write({peri_write[15:12],peri_write[10:7],peri_write[5:4],peri_write[1:0]}),
                     .common_write(common_write[0]),
                     .sel_smr(sel_smr), .sel_scr(sel_scr), .wr_soe(wr_soe), .wr_sol(wr_sol),
                     .wr_st(wr_st),
                     .cks(cks), .ccs(ccs), 
                     .sts(sts), .sis(sis), .md(md), .txe(txe), 
                     .rxe(rxe), .dap(dap), .ckp(ckp), .eoc(eoc), .ptc(ptc), 
                     .dir(dir), .slc(slc), .dls(dls), .soe(soe), .sol(sol),
                     .txrx_on(txrx_on),
                     .se(se), .st_trg(st_trg),
                     .stss_all(stss_all),
                     .md_csi(md_csi), .md_uart(md_uart), .md_iic(md_iic),
                     .pstate_on(pstate_on), /* .even_parity(even_parity), */		// not drive anything : by yama
                     .odd_parity(odd_parity), .pcheck_on(pcheck_on), .no_stopbit(no_stopbit), 
                     .data_7bit(data_7bit), .data_8bit(data_8bit),
                     .data_9bit(data_9bit) );

QLK0RSAU04R2V1_SCKCTL_C0 sckctl (
                     .peclk(peclk), .peresetz(peresetz), .se(se), 
                     .wr_so(wr_so), .common_write(common_write[1]),
                     .sck_data(sck_data), .sck_timing(sck_timing), .scko(scko),
                     .ge_scko(ge_scko), .ge_sout_all(ge_sout|ge_scko) );

QLK0RSAU04R2V1_TRGCTL_C0 trgctl (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .we_ulhw(we_ulhw), 
                     .sel_sdr(sel_sdr),
                     .ck0(ck0), .ck1(ck1), .cks(cks), .dap(dap),
                     .scki_rise(scki_rise), .scki_fall(scki_fall), .scki_both(scki_both), 
                     .ckp(ckp), 
                     .st_trg(st_trg), .baud_borrow(baud_borrow),
                     .se(se), .csi_slave_stop(csi_slave_stop),
                     .ccs(ccs), 
                     .txrx_on(txrx_on),
                     .seri_fin(seri_fin),
                     .count_start_trg(count_start_trg),
                     .count_clock(count_clock), .b_count_clock(b_count_clock),
                     .start_slave(start_slave), .async_csi(async_csi) );
   

endmodule


module QLK0RSAU04R2V1_MAIN_C1 (
                         peclk, pclkrw, peresetz,
                         ck0, ck1, 
                         peri_write, common_write, re_sdr,
                         sel_sdr, sel_smr, sel_scr, sel_sir,
                         wr_st, wr_so,
                         wr_soe, wr_sol,
                         we_ulhw, we_lhw, we_uhw,
                         sdr_data, smr_data, scr_data, ssr_data,
                         se, soe, sol,
                         count_clock,
                         md_uart, md_iic,
                         stss_all,
                         sin, sin_direct, scki,
                         sout, scko, int_sig, eint,
                         mck, fast_mode, scanmode, swc, ssec,
                         ch_error, ack_timing
                         );

input peclk;
input pclkrw;
   
input peresetz;
input ck0;
input ck1;
input [15:0] peri_write;
input [1:0] common_write;
input re_sdr;
input sel_sdr;
input sel_smr;
input sel_scr;
input sel_sir;
input wr_st;
input wr_soe;
input wr_so;
input wr_sol;
input we_ulhw;
input we_lhw;
input we_uhw;
input stss_all;
input sin;
input sin_direct;
input scki;
input scanmode;
input swc;
input ssec;
   
output [15:0] sdr_data;
output [15:0] smr_data;
output [15:0] scr_data;
output [15:0] ssr_data;
output se;
output soe;
output sol;
output count_clock;
//output st_sel_trg;
output md_uart;
output md_iic;
output sout;
output scko;
output int_sig;
output eint;
output mck;
output fast_mode;
output ch_error;
output ack_timing;
   
//===========================================//
//           wire definition                 //
//===========================================//
// SMR register
wire cks;
wire ccs;
wire sts;
wire sis;
wire [2:0] md;
wire md0 = md[0];
assign smr_data={cks, ccs, 5'b00000, sts, 1'b0, sis, 3'b100, md};

// SCR register
wire txe;
wire rxe;
wire dap;
wire ckp;
wire eoc;
wire [1:0] ptc;
wire dir;
wire slc;
wire [1:0] dls;
//assign scr_data = {txe, rxe, dap, ckp, 1'b0, eoc, ptc, dir, 1'b0, slc, 2'b01, dls};
assign scr_data = {txe, rxe, dap, ckp, 1'b0, eoc, ptc, dir, 2'b00, slc, 2'b01, dls};

//
wire [15:0] sdr_data;
wire [15:0] spr;
wire [15:0] sdr;
   
assign sdr_data = sdr;

wire start_slave;

// SSR Status Register;
wire tsf, bff, fef, pef, ovf;
wire eint;
assign ssr_data = {9'h000, tsf, bff, 2'h0, fef, pef, ovf};

// Other
wire seri_dout, seri_dout_timing;
wire scki_rise, scki_fall, scki_both;
wire sin_rise, sin_fall, sin_level, sin_latch;
wire md_csi, md_iic;  // delete md_seqcsi R2;
wire b_count_clock;
wire txrx_on;
wire pstate_on, pcheck_on, odd_parity /* , even_parity */ ;		// not drive anything : by yama
wire no_stopbit;
wire data_7bit, data_8bit, data_9bit;
wire st_trg;
wire seri_fin;
wire csi_slave_stop;
wire baud_borrow;
wire sck_timing, sck_data;
wire count_start_trg;
wire brate_adj = md_uart & swc;
wire bcnt_restart;
wire ch_error;
wire ge_sout, ge_scko;

QLK0RSAU04R2V1_SOCTL_C1 soctl (
                     .peclk(peclk), .peresetz(peresetz),
                     .wr_so(wr_so),
                     .common_write(common_write[0]), .soe(soe), .sol(sol),
                     .seri_dout(seri_dout), .seri_dout_timing(seri_dout_timing),
                     .sout(sout), .ge_sout(ge_sout), .ge_sout_all(ge_sout|ge_scko));

QLK0RSAU04R2V1_EDGECK_C1 edgeck (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .scki(scki), .ccs2(ccs),
                     .scki_rise(scki_rise), .scki_fall(scki_fall), .scki_both(scki_both));

QLK0RSAU04R2V1_EDGEU_C1 edgeu (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .sin(sin), .sis(sis),
                     .sin_rise(sin_rise), .sin_fall(sin_fall), 
                     .sin_level(sin_level), .sin_latch(sin_latch),
                     .brate_adj(brate_adj), .bcnt_restart(bcnt_restart) );

QLK0RSAU04R2V1_FUNC_C1 func (
                     .peclk(peclk), .pclkrw(pclkrw), .peresetz(peresetz), .mck(mck),
                     .we_ulhw(we_ulhw), .sel_sdr(sel_sdr), .sel_sir(sel_sir),
                     .re_sdr(re_sdr), .peri_write(peri_write), .se(se), 
                     .md0(md0), .dap(dap), 
                     .ckp(ckp), 
                     .count_start_trg(count_start_trg), .count_clock(count_clock), .b_count_clock(b_count_clock),
                     .md_csi(md_csi), .md_uart(md_uart), .md_iic(md_iic),
                     .eoc(eoc),
                     .dls(dls), .slc(slc), .dir(dir), .rxe(rxe), .txe(txe), 
                     .pstate_on(pstate_on), .pcheck_on(pcheck_on),
                     .odd_parity(odd_parity),
                     .no_stopbit(no_stopbit), .ccs2(ccs),
                     .data_7bit(data_7bit), .data_8bit(data_8bit), .data_9bit(data_9bit),
                     .sin_level(sin_level), .sin_latch(sin_latch),
                     .st_trg(st_trg), .start_slave(start_slave),
                     .seri_fin_out(seri_fin), .csi_slave_stop(csi_slave_stop),
                     .spr(spr), .sdr_read(sdr), .baud_borrow(baud_borrow),
                     .int_sig(int_sig), .eint(eint), .pef(pef), .fef(fef), 
                     .bff(bff), .ovf(ovf), .tsf(tsf),
                     .seri_dout_timing(seri_dout_timing), .seri_dout(seri_dout), 
                     .sck_timing(sck_timing), .sck_data(sck_data),
                     .fast_mode(fast_mode), .sin_direct(sin_direct),
                     .brate_adj(brate_adj), .ssec(ssec), .bcnt_restart(bcnt_restart), .scanmode(scanmode),
                     .ch_error(ch_error), .ack_timing(ack_timing)
                     );


QLK0RSAU04R2V1_REGU_C1 regu (
                     .peclk(pclkrw), .peresetz(peresetz),
                     .we_ulhw(we_ulhw), .we_lhw(we_lhw), .we_uhw(we_uhw),
                     .smr_write({peri_write[15:14],peri_write[8],peri_write[6],peri_write[2:0]}),
                     .scr_write({peri_write[15:12],peri_write[10:7],peri_write[4],peri_write[1:0]}),
                     .common_write(common_write[0]),
                     .sel_smr(sel_smr), .sel_scr(sel_scr), .wr_soe(wr_soe), /* .wr_sol(wr_sol),*/    // not drive anything : by yama
                     .wr_st(wr_st),
                     .cks(cks), .ccs(ccs), 
                     .sts(sts), .sis(sis), .md(md), .txe(txe), 
                     .rxe(rxe), .dap(dap), .ckp(ckp), .eoc(eoc), .ptc(ptc), 
                     .dir(dir), .slc(slc), .dls(dls), .soe(soe), .sol(sol),
                     .txrx_on(txrx_on),
                     .se(se), .st_trg(st_trg),
                     .stss_all(stss_all),
                     .md_csi(md_csi), .md_uart(md_uart), .md_iic(md_iic),
                     .pstate_on(pstate_on), /* .even_parity(even_parity), */		// not drive anything : by yama
                     .odd_parity(odd_parity), .pcheck_on(pcheck_on), .no_stopbit(no_stopbit), 
                     .data_7bit(data_7bit), .data_8bit(data_8bit),
                     .data_9bit(data_9bit) );

QLK0RSAU04R2V1_SCKCTL_C1 sckctl (
                     .peclk(peclk), .peresetz(peresetz), .se(se), 
                     .wr_so(wr_so), .common_write(common_write[1]),
                     .sck_data(sck_data), .sck_timing(sck_timing), .scko(scko),
                     .ge_scko(ge_scko), .ge_sout_all(ge_sout|ge_scko) );

QLK0RSAU04R2V1_TRGCTL_C1 trgctl (
                     .peclk(peclk), .peresetz(peresetz), .mck(mck),
                     .we_ulhw(we_ulhw), 
                     .sel_sdr(sel_sdr),
                     .ck0(ck0), .ck1(ck1), .cks(cks), .dap(dap),
                     .scki_rise(scki_rise), .scki_fall(scki_fall), .scki_both(scki_both), 
                     .ckp(ckp), .sin_fall(sin_fall), .sin_rise(sin_rise),
                     .st_trg(st_trg), .baud_borrow(baud_borrow),
                     .se(se), .csi_slave_stop(csi_slave_stop),
                     .sts(sts), .ccs(ccs), .sis(sis),
                     .txrx_on(txrx_on),
                     .seri_fin(seri_fin),
                     .count_start_trg(count_start_trg),
                     .count_clock(count_clock), .b_count_clock(b_count_clock),
                     .start_slave(start_slave) );
   

endmodule
module QLK0RSAU04R2V1_REGU_B0 (
                     peclk, peresetz,
                     we_ulhw, we_lhw, we_uhw, smr_write, scr_write, common_write,
                     sel_smr, sel_scr, wr_soe, wr_sol, wr_st,
                     cks, ccs, sts, sis, md,
                     txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls,
                     txrx_on,
                     soe, sol,
                     se, st_trg,
                     stss_all,
                     md_csi, md_uart, md_iic,
                     pstate_on, /* even_parity, */ odd_parity, pcheck_on,		// not drive anything : by yama
                     no_stopbit,
                     data_7bit, data_8bit
                     );

//=========================//
//  Interface Definition   //
//=========================//
input peclk;
input peresetz;
input [4:0] smr_write;
input [10:0] scr_write;
input common_write;  // This is for SOE, SOL, SOM, SS, ST register 
input we_ulhw;  // CHn_even connect from we_lhw, CHn_odd connect from we_uhw
input we_lhw;
input we_uhw;
input sel_smr;
input sel_scr;
input wr_soe;
input wr_sol;
input wr_st;
input stss_all;  // This is for Clock Gating signal

output cks;
output ccs;
output sts;
output sis;
output [2:0] md;
output txe;
output rxe;
output dap;
output ckp;
output eoc;
output [1:0] ptc;
output dir;
output [1:0] slc;
output [1:0] dls;

output soe;
output sol;
output txrx_on;

output se;
output st_trg;

output md_csi;
output md_uart;
output md_iic;

output pstate_on;
// output even_parity;		// not drive anything : by yama
output odd_parity;
output pcheck_on;

output no_stopbit;

output data_7bit;
output data_8bit;
//output data_9bit;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
// CMR Register
reg cks;
reg ccs;
wire sts = 1'b0;
wire sis = 1'b0;
reg [2:0] md;
// CCR Register
reg txe;
reg rxe;
reg dap;
reg ckp;
reg eoc;
reg [1:0] ptc;
reg dir;
reg [1:0] slc;
wire [1:0] dls;
reg dls0;

assign dls = {1'b1,dls0};
// SOE Register
reg soe;
reg sol;

//=======================//
//  Generate WE Signal   //
//=======================//
wire we_smr = sel_smr & we_ulhw;
wire we_scr = sel_scr & we_ulhw;
wire we_soe = wr_soe;
wire we_sol = wr_sol;

//=======================//
//  CMR Register         //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)
     //{cks, ccs, sts, sis, md} <= 7'b0000000;
     {cks, ccs, md} <= 5'b00000;
  else if (we_smr)
     //{cks, ccs, sts, sis, md} <= smr_write;
     {cks, ccs, md} <= smr_write;
end

//=======================//
//  CCR Register         //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)
     {txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls0} <= 11'h009;
  else if (we_scr)
     {txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls0} <= scr_write;
end

//=============================//
//  SOE Register               //
//=============================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     soe <= 1'b0;
  else if (we_soe)   soe <= common_write;
end

//=============================//
//  SOL Register (GTOK all ch) //
//=============================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     sol <= 1'b0;
  else if (we_sol)   sol <= common_write;
end


//===================//
//  SE register      //
//===================//
//  stss_all <- sel_ss | sel_st

reg se;
wire ge_se_register = (we_uhw | we_lhw) & stss_all;
wire se_data = common_write ?  ~wr_st  : se;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)            se <= 1'b0;
  else if (ge_se_register)  se <= se_data;
end

// Stop signal
wire st_trg = ge_se_register & common_write;

wire md_csi = ~(^md[2:1]);
wire md_uart = (md[2:1]==2'b01);
wire md_iic = (md[2:1]==2'b10);

//=========================//
//  Transfer Decoder       //
//=========================//
wire txrx_on = txe | rxe;

//=========================//
//     Parity Decoder      //
//=========================//
wire pstate_on = (ptc != 2'b00);
// wire even_parity = (ptc == 2'b10);		// not drive anything : by yama
wire odd_parity = ptc[0];
wire pcheck_on = ptc[1] ;

//=========================//
//     Stop   Decoder      //
//=========================//
wire no_stopbit = (slc == 2'b00);

//=========================//
//  Data Length  Decoder   //
//=========================//
//wire data_9bit = (dls[1] == 1'b0);  // dls=00 work for data 9bit
//wire data_7bit = (dls == 2'b10);
//wire data_8bit = (dls == 2'b11);
wire data_7bit = (dls[0] == 1'b0);
wire data_8bit = (dls[0] == 1'b1);

endmodule
module QLK0RSAU04R2V1_REGU_B1 (
                     peclk, peresetz,
                     we_ulhw, we_lhw, we_uhw, smr_write, scr_write, common_write,
                     sel_smr, sel_scr, wr_soe, /* wr_sol,*/ wr_st,				// not drive anything : by yama
                     cks, ccs, sts, sis, md,
                     txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls,
                     txrx_on,
                     soe, sol,
                     se, st_trg,
                     stss_all,
                     md_csi, md_uart, md_iic,
                     pstate_on, /* even_parity, */ odd_parity, pcheck_on,		// not drive anything : by yama
                     no_stopbit,
                     data_7bit, data_8bit
                     );

//=========================//
//  Interface Definition   //
//=========================//
input peclk;
input peresetz;
input [6:0] smr_write;
input [9:0] scr_write;
input common_write;  // This is for SOE, SOL, SOM, SS, ST register 
input we_ulhw;  // CHn_even connect from we_lhw, CHn_odd connect from we_uhw
input we_lhw;
input we_uhw;
input sel_smr;
input sel_scr;
input wr_soe;
// input wr_sol; 			// not drive anything : by yama
input wr_st;
input stss_all;  // This is for Clock Gating signal

output cks;
output ccs;
output sts;
output sis;
output [2:0] md;
output txe;
output rxe;
output dap;
output ckp;
output eoc;
output [1:0] ptc;
output dir;
output slc;
output [1:0] dls;

output soe;
output sol;
output txrx_on;

output se;
output st_trg;

output md_csi;
output md_uart;
output md_iic;

output pstate_on;
// output even_parity;		// not drive anything : by yama
output odd_parity;
output pcheck_on;

output no_stopbit;

output data_7bit;
output data_8bit;
//output data_9bit;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
// CMR Register
reg cks;
reg ccs;
reg sts;
reg sis;
reg [2:0] md;
// CCR Register
reg txe;
reg rxe;
reg dap;
reg ckp;
reg eoc;
reg [1:0] ptc;
reg dir;
reg  slc;
wire [1:0] dls;
reg dls0;
assign dls = {1'b1,dls0};
// SOE Register
reg soe;
wire sol = 1'b0;

//=======================//
//  Generate WE Signal   //
//=======================//
wire we_smr = sel_smr & we_ulhw;
wire we_scr = sel_scr & we_ulhw;
wire we_soe = wr_soe;
// wire we_sol = wr_sol;  		// not drive anything : by yama

//=======================//
//  CMR Register         //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)
     {cks, ccs, sts, sis, md} <= 7'b0000000;
  else if (we_smr)
     {cks, ccs, sts, sis, md} <= smr_write;
end

//=======================//
//  CCR Register         //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)
     {txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls0} <= 10'h005;
  else if (we_scr)
     {txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls0} <= scr_write;
end

//=============================//
//  SOE Register               //
//=============================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     soe <= 1'b0;
  else if (we_soe)   soe <= common_write;
end

//=============================//
//  SOL Register (GTOK all ch) //
//=============================//
//always@(posedge peclk or negedge peresetz) begin
//  if (~peresetz)     sol <= 1'b0;
//  else if (we_sol)   sol <= common_write;
//end


//===================//
//  SE register      //
//===================//
//  stss_all <- sel_ss | sel_st

reg se;
wire ge_se_register = (we_uhw | we_lhw) & stss_all;
wire se_data = common_write ?  ~wr_st  : se;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)            se <= 1'b0;
  else if (ge_se_register)  se <= se_data;
end

// Stop signal
wire st_trg = ge_se_register & common_write;

wire md_csi = ~(^md[2:1]);
wire md_uart = (md[2:1]==2'b01);
wire md_iic = (md[2:1]==2'b10);

//=========================//
//  Transfer Decoder       //
//=========================//
wire txrx_on = txe | rxe;

//=========================//
//     Parity Decoder      //
//=========================//
wire pstate_on = (ptc != 2'b00);
// wire even_parity = (ptc == 2'b10);		// not drive anything : by yama
wire odd_parity = ptc[0];
wire pcheck_on = ptc[1] ;

//=========================//
//     Stop   Decoder      //
//=========================//
wire no_stopbit = (slc == 1'b0);

//=========================//
//  Data Length  Decoder   //
//=========================//
//wire data_9bit = (dls[1] == 1'b0);  // dls=00 work for data 9bit
wire data_7bit = (dls0 == 1'b0);
wire data_8bit = (dls0 == 1'b1);


endmodule
module QLK0RSAU04R2V1_REGU_C0 (
                     peclk, peresetz,
                     we_ulhw, we_lhw, we_uhw, smr_write, scr_write, common_write,
                     sel_smr, sel_scr, wr_soe, wr_sol, wr_st,
                     cks, ccs, sts, sis, md,
                     txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls,
                     txrx_on,
                     soe, sol,
                     se, st_trg,
                     stss_all,
                     md_csi, md_uart, md_iic,
                     pstate_on, /* even_parity, */ odd_parity, pcheck_on,		// not drive anything : by yama
                     no_stopbit,
                     data_7bit, data_8bit, data_9bit
                     );

//=========================//
//  Interface Definition   //
//=========================//
input peclk;
input peresetz;
input [4:0] smr_write;
input [11:0] scr_write;
input common_write;  // This is for SOE, SOL, SOM, SS, ST register 
input we_ulhw;  // CHn_even connect from we_lhw, CHn_odd connect from we_uhw
input we_lhw;
input we_uhw;
input sel_smr;
input sel_scr;
input wr_soe;
input wr_sol;
input wr_st;
input stss_all;  // This is for Clock Gating signal

output cks;
output ccs;
output sts;
output sis;
output [2:0] md;
output txe;
output rxe;
output dap;
output ckp;
output eoc;
output [1:0] ptc;
output dir;
output [1:0] slc;
output [1:0] dls;

output soe;
output sol;
output txrx_on;

output se;
output st_trg;

output md_csi;
output md_uart;
output md_iic;

output pstate_on;
// output even_parity;		// not drive anything : by yama
output odd_parity;
output pcheck_on;

output no_stopbit;

output data_7bit;
output data_8bit;
output data_9bit;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
// CMR Register
reg cks;
reg ccs;
wire sts = 1'b0;
wire sis = 1'b0;
reg [2:0] md;
// CCR Register
reg txe;
reg rxe;
reg dap;
reg ckp;
reg eoc;
reg [1:0] ptc;
reg dir;
reg [1:0] slc;
reg [1:0] dls;

// SOE Register
reg soe;
reg sol;

//=======================//
//  Generate WE Signal   //
//=======================//
wire we_smr = sel_smr & we_ulhw;
wire we_scr = sel_scr & we_ulhw;
wire we_soe = wr_soe;
wire we_sol = wr_sol;

//=======================//
//  CMR Register         //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)
     //{cks, ccs, sts, sis, md} <= 7'b0000000;
     {cks, ccs, md} <= 5'b00000;
  else if (we_smr)
     //{cks, ccs, sts, sis, md} <= smr_write;
     {cks, ccs, md} <= smr_write;
end

//=======================//
//  CCR Register         //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)
     {txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls} <= 12'h013;
  else if (we_scr)
     {txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls} <= scr_write;
end

//=============================//
//  SOE Register               //
//=============================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     soe <= 1'b0;
  else if (we_soe)   soe <= common_write;
end

//=============================//
//  SOL Register (GTOK all ch) //
//=============================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     sol <= 1'b0;
  else if (we_sol)   sol <= common_write;
end


//===================//
//  SE register      //
//===================//
//  stss_all <- sel_ss | sel_st

reg se;
wire ge_se_register = (we_uhw | we_lhw) & stss_all;
wire se_data = common_write ?  ~wr_st  : se;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)            se <= 1'b0;
  else if (ge_se_register)  se <= se_data;
end

// Stop signal
wire st_trg = ge_se_register & common_write;

wire md_csi = ~(^md[2:1]);
wire md_uart = (md[2:1]==2'b01);
wire md_iic = (md[2:1]==2'b10);

//=========================//
//  Transfer Decoder       //
//=========================//
wire txrx_on = txe | rxe;

//=========================//
//     Parity Decoder      //
//=========================//
wire pstate_on = (ptc != 2'b00);
// wire even_parity = (ptc == 2'b10);		// not drive anything : by yama
wire odd_parity = ptc[0];
wire pcheck_on = ptc[1] ;

//=========================//
//     Stop   Decoder      //
//=========================//
wire no_stopbit = (slc == 2'b00);

//=========================//
//  Data Length  Decoder   //
//=========================//
wire data_9bit = (dls[1] == 1'b0);  // dls=00 work for data 9bit
wire data_7bit = (dls == 2'b10);
wire data_8bit = (dls == 2'b11);


endmodule
module QLK0RSAU04R2V1_REGU_C1 (
                     peclk, peresetz,
                     we_ulhw, we_lhw, we_uhw, smr_write, scr_write, common_write,
                     sel_smr, sel_scr, wr_soe, /* wr_sol, */ wr_st,				// not drive anything : by yama
                     cks, ccs, sts, sis, md,
                     txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls,
                     txrx_on,
                     soe, sol,
                     se, st_trg,
                     stss_all,
                     md_csi, md_uart, md_iic,
                     pstate_on, /* even_parity, */ odd_parity, pcheck_on,		// not drive anything : by yama
                     no_stopbit,
                     data_7bit, data_8bit, data_9bit
                     );

//=========================//
//  Interface Definition   //
//=========================//
input peclk;
input peresetz;
input [6:0] smr_write;
input [10:0] scr_write;
input common_write;  // This is for SOE, SOL, SOM, SS, ST register 
input we_ulhw;  // CHn_even connect from we_lhw, CHn_odd connect from we_uhw
input we_lhw;
input we_uhw;
input sel_smr;
input sel_scr;
input wr_soe;
// input wr_sol;					// not drive anything : by yama
input wr_st;
input stss_all;  // This is for Clock Gating signal

output cks;
output ccs;
output sts;
output sis;
output [2:0] md;
output txe;
output rxe;
output dap;
output ckp;
output eoc;
output [1:0] ptc;
output dir;
output slc;
output [1:0] dls;

output soe;
output sol;
output txrx_on;

output se;
output st_trg;

output md_csi;
output md_uart;
output md_iic;

output pstate_on;
// output even_parity;		// not drive anything : by yama
output odd_parity;
output pcheck_on;

output no_stopbit;

output data_7bit;
output data_8bit;
output data_9bit;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
// CMR Register
reg cks;
reg ccs;
reg sts;
reg sis;
reg [2:0] md;
// CCR Register
reg txe;
reg rxe;
reg dap;
reg ckp;
reg eoc;
reg [1:0] ptc;
reg dir;
reg  slc;
reg [1:0] dls;

// SOE Register
reg soe;
wire sol=1'b0;

//=======================//
//  Generate WE Signal   //
//=======================//
wire we_smr = sel_smr & we_ulhw;
wire we_scr = sel_scr & we_ulhw;
wire we_soe = wr_soe;
// wire we_sol = wr_sol;  		// not drive anything : by yama

//=======================//
//  CMR Register         //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)
     {cks, ccs, sts, sis, md} <= 7'b0000000;
  else if (we_smr)
     {cks, ccs, sts, sis, md} <= smr_write;
end

//=======================//
//  CCR Register         //
//=======================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)
     {txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls} <= 11'h00B;
  else if (we_scr)
     {txe, rxe, dap, ckp, eoc, ptc, dir, slc, dls} <= scr_write;
end

//=============================//
//  SOE Register               //
//=============================//
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)     soe <= 1'b0;
  else if (we_soe)   soe <= common_write;
end

//=============================//
//  SOL Register (GTOK all ch) //
//=============================//
//always@(posedge peclk or negedge peresetz) begin
//  if (~peresetz)     sol <= 1'b0;
//  else if (we_sol)   sol <= common_write;
//end


//===================//
//  SE register      //
//===================//
//  stss_all <- sel_ss | sel_st

reg se;
wire ge_se_register = (we_uhw | we_lhw) & stss_all;
wire se_data = common_write ?  ~wr_st  : se;

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)            se <= 1'b0;
  else if (ge_se_register)  se <= se_data;
end

// Stop signal
wire st_trg = ge_se_register & common_write;

wire md_csi = ~(^md[2:1]);
wire md_uart = (md[2:1]==2'b01);
wire md_iic = (md[2:1]==2'b10);

//=========================//
//  Transfer Decoder       //
//=========================//
wire txrx_on = txe | rxe;

//=========================//
//     Parity Decoder      //
//=========================//
wire pstate_on = (ptc != 2'b00);
// wire even_parity = (ptc == 2'b10);		// not drive anything : by yama
wire odd_parity = ptc[0];
wire pcheck_on = ptc[1] ;

//=========================//
//     Stop   Decoder      //
//=========================//
wire no_stopbit = (slc == 1'b0);

//=========================//
//  Data Length  Decoder   //
//=========================//
wire data_9bit = (dls[1] == 1'b0);  // dls=00 work for data 9bit
wire data_7bit = (dls == 2'b10);
wire data_8bit = (dls == 2'b11);


endmodule
module QLK0RSAU04R2V1_SCKCTL_B0 (
                           peclk, peresetz,
                           se,
                           wr_so, common_write,
                           sck_data, sck_timing,
                           scko, ge_scko, ge_sout_all
                           );

input peclk, peresetz;
input se;
input wr_so;
input common_write;
input sck_data;
input sck_timing;
input ge_sout_all;
output scko;
output ge_scko;

reg scko;
wire scko_data;
wire scko_dsel;

// Write SO register is available on SE=0
wire we_sco = ~se & wr_so;

// This is Gating Signal fo SCKO register
wire ge_scko = (we_sco | sck_timing) ;

assign scko_data = (we_sco ? common_write : sck_data);
QLK0RSAU04R2V1_SCKDSEL_B0 sckdsel( .ge_scko(ge_scko), .scko_data(scko_data), .scko(scko), .scko_dsel(scko_dsel) );

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        scko <= 1'b1;
//  else if (ge_scko) scko <= (we_sco ? common_write : sck_data);
  else if (ge_sout_all) scko <= scko_dsel;
end

endmodule

module QLK0RSAU04R2V1_SCKDSEL_B0 ( ge_scko, scko_data, scko, scko_dsel );

input ge_scko;
input scko_data;
input scko;
output scko_dsel;

wire scko_dsel = ge_scko ? scko_data : scko;

endmodule
module QLK0RSAU04R2V1_SCKCTL_B1 (
                           peclk, peresetz,
                           se,
                           wr_so, common_write,
                           sck_data, sck_timing,
                           scko, ge_scko, ge_sout_all
                           );

input peclk, peresetz;
input se;
input wr_so;
input common_write;
input sck_data;
input sck_timing;
input ge_sout_all;
output scko;
output ge_scko;

reg scko;
wire scko_data;
wire scko_dsel;

// Write SO register is available on SE=0
wire we_sco = ~se & wr_so;

// This is Gating Signal fo SCKO register
wire ge_scko = (we_sco | sck_timing) ;

assign scko_data = (we_sco ? common_write : sck_data);
QLK0RSAU04R2V1_SCKDSEL_B1 sckdsel( .ge_scko(ge_scko), .scko_data(scko_data), .scko(scko), .scko_dsel(scko_dsel) );

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        scko <= 1'b1;
//  else if (ge_scko) scko <= (we_sco ? common_write : sck_data);
  else if (ge_sout_all) scko <= scko_dsel;
end

endmodule

module QLK0RSAU04R2V1_SCKDSEL_B1 ( ge_scko, scko_data, scko, scko_dsel );

input ge_scko;
input scko_data;
input scko;
output scko_dsel;

wire scko_dsel = ge_scko ? scko_data : scko;

endmodule
module QLK0RSAU04R2V1_SCKCTL_C0 (
                           peclk, peresetz,
                           se,
                           wr_so, common_write,
                           sck_data, sck_timing,
                           scko, ge_scko, ge_sout_all
                           );

input peclk, peresetz;
input se;
input wr_so;
input common_write;
input sck_data;
input sck_timing;
input ge_sout_all;
output scko;
output ge_scko;

reg scko;
wire scko_data;
wire scko_dsel;

// Write SO register is available on SE=0
wire we_sco = ~se & wr_so;

// This is Gating Signal fo SCKO register
wire ge_scko = (we_sco | sck_timing) ;

assign scko_data = (we_sco ? common_write : sck_data);
QLK0RSAU04R2V1_SCKDSEL_C0 sckdsel( .ge_scko(ge_scko), .scko_data(scko_data), .scko(scko), .scko_dsel(scko_dsel) );

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        scko <= 1'b1;
//  else if (ge_scko) scko <= (we_sco ? common_write : sck_data);
  else if (ge_sout_all) scko <= scko_dsel;
end

endmodule

module QLK0RSAU04R2V1_SCKDSEL_C0 ( ge_scko, scko_data, scko, scko_dsel );

input ge_scko;
input scko_data;
input scko;
output scko_dsel;

wire scko_dsel = ge_scko ? scko_data : scko;

endmodule
module QLK0RSAU04R2V1_SCKCTL_C1 (
                           peclk, peresetz,
                           se,
                           wr_so, common_write,
                           sck_data, sck_timing,
                           scko, ge_scko, ge_sout_all
                           );

input peclk, peresetz;
input se;
input wr_so;
input common_write;
input sck_data;
input sck_timing;
input ge_sout_all;
output scko;
output ge_scko;

reg scko;
wire scko_data;
wire scko_dsel;

// Write SO register is available on SE=0
wire we_sco = ~se & wr_so;

// This is Gating Signal fo SCKO register
wire ge_scko = (we_sco | sck_timing) ;

assign scko_data = (we_sco ? common_write : sck_data);
QLK0RSAU04R2V1_SCKDSEL_C1 sckdsel( .ge_scko(ge_scko), .scko_data(scko_data), .scko(scko), .scko_dsel(scko_dsel) );

always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)        scko <= 1'b1;
//  else if (ge_scko) scko <= (we_sco ? common_write : sck_data);
  else if (ge_sout_all) scko <= scko_dsel;
end

endmodule

module QLK0RSAU04R2V1_SCKDSEL_C1 ( ge_scko, scko_data, scko, scko_dsel );

input ge_scko;
input scko_data;
input scko;
output scko_dsel;

wire scko_dsel = ge_scko ? scko_data : scko;

endmodule
module QLK0RSAU04R2V1_SOCTL_B0 (
                     peclk, peresetz, 
                     wr_so, common_write,
                     soe, sol,
                     seri_dout, seri_dout_timing,
                     sout, ge_sout, ge_sout_all
                     );

input peclk;
input peresetz;
input wr_so;
input common_write;
input soe;
input sol;
input seri_dout;
input seri_dout_timing;
input ge_sout_all;
output sout;
output ge_sout;

reg  sout;
reg sout_data;
wire sout_datasel;

//=========================//
//  Priority of SAU or APB //
//=========================//
wire we_sco = wr_so;

//========================//
// Output Level Selecter  //
//========================//
wire seri_dout_sel = sol ? ~seri_dout : seri_dout;

// Data Selector
always@(soe or seri_dout_timing or we_sco or
        seri_dout_sel or common_write or sout) begin
  sout_data = sout;
  if (soe) begin
    if (seri_dout_timing)  sout_data = seri_dout_sel;
    else                   sout_data = sout;
  end
  else if (we_sco)         sout_data = common_write;
  else                     sout_data = sout;
end


wire ge_sout = we_sco | seri_dout_timing  ;
QLK0RSAU04R2V1_SODSEL_B0 sodsel(.ge_sout(ge_sout), .sout_data(sout_data), .sout(sout), .sout_datasel(sout_datasel) );

always @( posedge peclk or negedge peresetz) begin
    if(~peresetz)      sout <= 1'b1;
//    else if (ge_sout)  sout <= sout_data;
    else if (ge_sout_all) sout <= sout_datasel;
end

endmodule

module QLK0RSAU04R2V1_SODSEL_B0(ge_sout, sout_data, sout, sout_datasel);

input ge_sout;
input sout_data;
input sout;
output sout_datasel;

wire sout_datasel = ge_sout ? sout_data : sout;

endmodule
module QLK0RSAU04R2V1_SOCTL_B1 (
                     peclk, peresetz, 
                     wr_so, common_write,
                     soe, sol,
                     seri_dout, seri_dout_timing,
                     sout, ge_sout, ge_sout_all
                     );

input peclk;
input peresetz;
input wr_so;
input common_write;
input soe;
input sol;
input seri_dout;
input seri_dout_timing;
input ge_sout_all;
output sout;
output ge_sout;

reg  sout;
reg sout_data;
wire sout_datasel;

//=========================//
//  Priority of SAU or APB //
//=========================//
wire we_sco = wr_so;

//========================//
// Output Level Selecter  //
//========================//
wire seri_dout_sel = sol ? ~seri_dout : seri_dout;

// Data Selector
always@(soe or seri_dout_timing or we_sco or
        seri_dout_sel or common_write or sout) begin
  sout_data = sout;
  if (soe) begin
    if (seri_dout_timing)  sout_data = seri_dout_sel;
    else                   sout_data = sout;
  end
  else if (we_sco)         sout_data = common_write;
  else                     sout_data = sout;
end


wire ge_sout = we_sco | seri_dout_timing  ;
QLK0RSAU04R2V1_SODSEL_B1 sodsel(.ge_sout(ge_sout), .sout_data(sout_data), .sout(sout), .sout_datasel(sout_datasel) );

always @( posedge peclk or negedge peresetz) begin
    if(~peresetz)      sout <= 1'b1;
//    else if (ge_sout)  sout <= sout_data;
    else if (ge_sout_all) sout <= sout_datasel;
end

endmodule

module QLK0RSAU04R2V1_SODSEL_B1(ge_sout, sout_data, sout, sout_datasel);

input ge_sout;
input sout_data;
input sout;
output sout_datasel;

wire sout_datasel = ge_sout ? sout_data : sout;

endmodule
module QLK0RSAU04R2V1_SOCTL_C0 (
                     peclk, peresetz, 
                     wr_so, common_write,
                     soe, sol,
                     seri_dout, seri_dout_timing,
                     sout, ge_sout, ge_sout_all
                     );

input peclk;
input peresetz;
input wr_so;
input common_write;
input soe;
input sol;
input seri_dout;
input seri_dout_timing;
input ge_sout_all;
output sout;
output ge_sout;

reg  sout;
reg sout_data;
wire sout_datasel;

//=========================//
//  Priority of SAU or APB //
//=========================//
wire we_sco = wr_so;

//========================//
// Output Level Selecter  //
//========================//
wire seri_dout_sel = sol ? ~seri_dout : seri_dout;

// Data Selector
always@(soe or seri_dout_timing or we_sco or
        seri_dout_sel or common_write or sout) begin
  sout_data = sout;
  if (soe) begin
    if (seri_dout_timing)  sout_data = seri_dout_sel;
    else                   sout_data = sout;
  end
  else if (we_sco)         sout_data = common_write;
  else                     sout_data = sout;
end

wire ge_sout = we_sco | seri_dout_timing  ;
QLK0RSAU04R2V1_SODSEL_C0 sodsel(.ge_sout(ge_sout), .sout_data(sout_data), .sout(sout), .sout_datasel(sout_datasel) );

always @( posedge peclk or negedge peresetz) begin
    if(~peresetz)      sout <= 1'b1;
//    else if (ge_sout)  sout <= sout_data;
    else if (ge_sout_all) sout <= sout_datasel;
end

endmodule

module QLK0RSAU04R2V1_SODSEL_C0(ge_sout, sout_data, sout, sout_datasel);

input ge_sout;
input sout_data;
input sout;
output sout_datasel;

wire sout_datasel = ge_sout ? sout_data : sout;

endmodule

module QLK0RSAU04R2V1_SOCTL_C1 (
                     peclk, peresetz, 
                     wr_so, common_write,
                     soe, sol,
                     seri_dout, seri_dout_timing,
                     sout, ge_sout, ge_sout_all
                     );

input peclk;
input peresetz;
input wr_so;
input common_write;
input soe;
input sol;
input seri_dout;
input seri_dout_timing;
input ge_sout_all;
output sout;
output ge_sout;

reg  sout;
reg sout_data;
wire sout_datasel;

//=========================//
//  Priority of SAU or APB //
//=========================//
wire we_sco = wr_so;

//========================//
// Output Level Selecter  //
//========================//
wire seri_dout_sel = sol ? ~seri_dout : seri_dout;

// Data Selector
always@(soe or seri_dout_timing or we_sco or
        seri_dout_sel or common_write or sout) begin
  sout_data = sout;
  if (soe) begin
    if (seri_dout_timing)  sout_data = seri_dout_sel;
    else                   sout_data = sout;
  end
  else if (we_sco)         sout_data = common_write;
  else                     sout_data = sout;
end


wire ge_sout = we_sco | seri_dout_timing  ;
QLK0RSAU04R2V1_SODSEL_C1 sodsel(.ge_sout(ge_sout), .sout_data(sout_data), .sout(sout), .sout_datasel(sout_datasel) );

always @( posedge peclk or negedge peresetz) begin
    if(~peresetz)      sout <= 1'b1;
//    else if (ge_sout)  sout <= sout_data;
    else if (ge_sout_all) sout <= sout_datasel;
end

endmodule

module QLK0RSAU04R2V1_SODSEL_C1(ge_sout, sout_data, sout, sout_datasel);

input ge_sout;
input sout_data;
input sout;
output sout_datasel;

wire sout_datasel = ge_sout ? sout_data : sout;

endmodule
module QLK0RSAU04R2V1_TRGCTL_B0 (
                     peclk, peresetz, mck,
                     we_ulhw, sel_sdr, 
                     ck0, ck1, cks, dap,
                     scki_rise, scki_fall, scki_both, ckp,
                     st_trg,
                     baud_borrow,
                     se, csi_slave_stop,
                     ccs, txrx_on, 
                     seri_fin,
                     count_start_trg, count_clock, b_count_clock, start_slave
                     );

//=========================//
//  Interface Definition   //
//=========================//
input  peclk;
input  peresetz;
output mck;
input  we_ulhw;
input  sel_sdr;
input  ck0;
input  ck1;
input  cks;
input  dap;
input  scki_rise;
input  scki_fall;
input  scki_both;
input  ckp;
//input  sin_rise;
//input  sin_fall;
input  st_trg;
input  baud_borrow;
input  se;
input  csi_slave_stop;
//input  sts;
input  ccs;
input  txrx_on;
//input  sis;
input  seri_fin;

//output st_sel_trg;
output count_start_trg;
output count_clock;
output b_count_clock;
output start_slave;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
wire start_master;
wire start_slave;
wire seri_start_trg;
wire seri_slave_start;
wire ge_cen;
   
wire csi_start_out;

reg ss;
reg count_ck_source;
wire ge_ss;
wire ss_data;
wire ge_ss_cen;

wire mck;
//wire sin_sel_trg;
//reg st_sel_trg;

wire mck_sel;
wire stop_trg;

reg count_en_register;

//wire count_en_data;

wire count_clock;
wire b_count_clock;
wire count_start_trg;
wire seri_timer_start;
//=======================//
//  Serial Start Signal  //
//=======================//
       // SDR write signal
assign csi_start_out = sel_sdr & we_ulhw;

       // start CSI master, UART send, IIC, SCIF send,               CSI slave and dap=1 
       //                                                              This is for preparing SOUT/SPR
assign start_master = csi_start_out & (~ccs | (ccs&dap));

       // Start CSI slave, in cascade mode start signal(SCKIn_even) receive from even ch
assign start_slave = ((~ckp & scki_fall) | (ckp & scki_rise)) & ccs & se;

       // Serial start signal , CSI master, UART send, IIC, SCIF send, CSI slave and dap=1 
//assign seri_start_trg = ~sts & se & txrx_on & (~count_en_register|seri_fin) & start_master & ~ss;
assign seri_start_trg = se & txrx_on & (~count_en_register|seri_fin) & start_master & ~ss;

//=======================//
//  Timer Start Signal   //
//=======================//
// Common Gating signal
assign ge_ss_cen = ge_ss | ge_cen;
// Data Selector
wire cen_data;
QLK0RSAU04R2V1_SSDSEL_B0 ssdsel( .ge_cen(ge_cen), .stop_trg(stop_trg),
                                 .count_en_register(count_en_register), .cen_data(cen_data),
                                 .ge_ss(ge_ss), .seri_timer_start(seri_timer_start), .ss(ss), .ss_data(ss_data) );

//wire ss_trg = (st_sel_trg & se) | (ss & count_ck_source);
wire ss_trg = (ss & count_ck_source);

     // Start signal selector
assign seri_timer_start = seri_start_trg ;
wire clear_ss = count_ck_source | st_trg ;
assign ge_ss = (seri_timer_start | clear_ss) ;


//              ss ____________|~~~~~~~~~~|___________________
//           ge_ss __________|~~~~~~~~~~~~|___________________
// count_ck_source ______|~|____________|~|____________|~|____
//                                        clear until next count clock timing
//                                        I add special process for event mode(2005.8.3)
//                                        because count_ck_source is not active until first available CIN edge,
//                                        So SAU mis-count 1st edge.
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)    ss <= 1'b0;
//  else if (ge_ss)   ss <= seri_timer_start;
  else if (ge_ss_cen) ss <= ss_data;
end


//=====================//
//  MCK Clock Select   //
//=====================//
assign mck = cks ? ck1 : ck0;

//=====================//
//  SINn Edge Select   //
//=====================//
//assign sin_sel_trg = sis ? sin_rise : sin_fall;

//=======================================//
//  timer start signal (TAU in TRGCTL)   //
//=======================================//
//always @( sts or sin_sel_trg) begin
//    case(sts) // synopsys parallel_case
//      1'b1:  st_sel_trg = sin_sel_trg;   // -> Use for start of UART receive
//      default: st_sel_trg = 1'b0;
//    endcase
//end


//========================================//
//  Timer Count Source Clock Selector     //
//========================================//
       // MCK signal is triggered at Timer mode or no baud-rate mode(serial data 16bit),
       //                            start timing(ss), baud-rate counter on serial
//assign mck_sel = (ss | baud_borrow | ~baud_count_en) & mck;
assign mck_sel = (ss | baud_borrow) & mck;
always @( ccs or mck_sel or 
          scki_both or ss or mck or csi_slave_stop) begin
    case(ccs)   // synopsys parallel_case
      1'b0:    count_ck_source = mck_sel;
      default: count_ck_source = scki_both | (ss&mck) | csi_slave_stop; // -> Use for CSI Slave
    endcase
end

//======================================//
//  Timer stop signal (TAU in TRGCTL)   //
//======================================//
// Counter STOP both SIN Edge at STS=010
assign stop_trg = seri_fin | st_trg ;

//============================//
//      Count Enable signal   //
//============================//
// Timer md_waiting -> wait selected start trigger(sts)
//       Other mode -> start after writing SS register
wire seri_master_start = ss ;
assign seri_slave_start = (start_slave | ss_trg) & txrx_on;
// remove seri_slave_start & mck redundancy
wire seri_start = ((seri_master_start&mck) | seri_slave_start) & ~count_en_register & se ; 

assign count_start_trg = seri_start ;
                               
// count_en_register set/clr condition
assign ge_cen = count_start_trg | stop_trg;


// count_en_register is eneble signal of count clock;
always @( posedge peclk or negedge peresetz ) begin
    if(~peresetz)         count_en_register <= 1'b0;
//    else if (ge_cen)      count_en_register <= ~stop_trg;
  else if (ge_ss_cen)  count_en_register <= cen_data;
end

// Count clock
assign count_clock = count_en_register & count_ck_source ;

// This is for baud-rate counter(SPR[15:9])
assign b_count_clock = count_en_register & mck;

endmodule

module QLK0RSAU04R2V1_SSDSEL_B0 ( ge_cen, stop_trg, count_en_register, cen_data,
                                  ge_ss, seri_timer_start, ss, ss_data);

input ge_cen;
input stop_trg;
input count_en_register;
input ge_ss;
input seri_timer_start;
input ss;

output ss_data;
output cen_data;

wire cen_data = ge_cen ? ~stop_trg : count_en_register;
wire ss_data = ge_ss ? seri_timer_start : ss;

endmodule 
module QLK0RSAU04R2V1_TRGCTL_B1 (
                     peclk, peresetz, mck,
                     we_ulhw, sel_sdr, 
                     ck0, ck1, cks, dap,
                     scki_rise, scki_fall, scki_both, ckp,
                     sin_fall, sin_rise,
                     st_trg,
                     baud_borrow,
                     se, csi_slave_stop,
                     sts, ccs, txrx_on, sis,
                     seri_fin,
                     count_start_trg, count_clock, b_count_clock, start_slave
                     );

//=========================//
//  Interface Definition   //
//=========================//
input  peclk;
input  peresetz;
output mck;
input  we_ulhw;
input  sel_sdr;
input  ck0;
input  ck1;
input  cks;
input  dap;
input  scki_rise;
input  scki_fall;
input  scki_both;
input  ckp;
input  sin_rise;
input  sin_fall;
input  st_trg;
input  baud_borrow;
input  se;
input  csi_slave_stop;
input  sts;
input  ccs;
input  txrx_on;
input  sis;
input  seri_fin;

//output st_sel_trg;
output count_start_trg;
output count_clock;
output b_count_clock;
output start_slave;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
wire start_master;
wire start_slave;
wire seri_start_trg;
wire seri_slave_start;
wire ge_cen;
   
wire csi_start_out;

reg ss;
reg count_ck_source;
wire ge_ss;
wire ss_data;
wire ge_ss_cen;

wire mck;
wire sin_sel_trg;
reg st_sel_trg;

wire mck_sel;
wire stop_trg;

reg count_en_register;

//wire count_en_data;

wire count_clock;
wire b_count_clock;
wire count_start_trg;
wire seri_timer_start;

//=======================//
//  Serial Start Signal  //
//=======================//
       // SDR write signal
assign csi_start_out = sel_sdr & we_ulhw;

       // start CSI master, UART send, IIC, SCIF send,               CSI slave and dap=1 
       //                                                              This is for preparing SOUT/SPR
assign start_master = csi_start_out & (~ccs | (ccs&dap));

       // Start CSI slave, in cascade mode start signal(SCKIn_even) receive from even ch
assign start_slave = ((~ckp & scki_fall) | (ckp & scki_rise)) & ccs & se;

       // Serial start signal , CSI master, UART send, IIC, SCIF send, CSI slave and dap=1 
assign seri_start_trg = ~sts & se & txrx_on & (~count_en_register|seri_fin) & start_master & ~ss;

//=======================//
//  Timer Start Signal   //
//=======================//
// Common Gating signal
assign ge_ss_cen = ge_ss | ge_cen;
// Data Selector
wire cen_data;
QLK0RSAU04R2V1_SSDSEL_B1 ssdsel( .ge_cen(ge_cen), .stop_trg(stop_trg),
                                 .count_en_register(count_en_register), .cen_data(cen_data),
                                 .ge_ss(ge_ss), .seri_timer_start(seri_timer_start), .ss(ss), .ss_data(ss_data) );

wire ss_trg = (st_sel_trg & se) | (ss & count_ck_source);

     // Start signal selector
assign seri_timer_start = seri_start_trg ;
wire clear_ss = count_ck_source | st_trg ;
assign ge_ss = (seri_timer_start | clear_ss) ;


//              ss ____________|~~~~~~~~~~|___________________
//           ge_ss __________|~~~~~~~~~~~~|___________________
// count_ck_source ______|~|____________|~|____________|~|____
//                                        clear until next count clock timing
//                                        I add special process for event mode(2005.8.3)
//                                        because count_ck_source is not active until first available CIN edge,
//                                        So SAU mis-count 1st edge.
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)    ss <= 1'b0;
//  else if (ge_ss)   ss <= seri_timer_start;
  else if (ge_ss_cen) ss <= ss_data;
end


//=====================//
//  MCK Clock Select   //
//=====================//
assign mck = cks ? ck1 : ck0;

//=====================//
//  SINn Edge Select   //
//=====================//
assign sin_sel_trg = sis ? sin_rise : sin_fall;

//=======================================//
//  timer start signal (TAU in TRGCTL)   //
//=======================================//
always @( sts or sin_sel_trg) begin
    case(sts) // synopsys parallel_case
      1'b1:  st_sel_trg = sin_sel_trg;   // -> Use for start of UART receive
      default: st_sel_trg = 1'b0;
    endcase
end


//========================================//
//  Timer Count Source Clock Selector     //
//========================================//
       // MCK signal is triggered at Timer mode or no baud-rate mode(serial data 16bit),
       //                            start timing(ss), baud-rate counter on serial
//assign mck_sel = (ss | baud_borrow | ~baud_count_en) & mck;
assign mck_sel = (ss | baud_borrow) & mck;
always @( ccs or mck_sel or 
          scki_both or ss or mck or csi_slave_stop) begin
    case(ccs)   // synopsys parallel_case
      1'b0:    count_ck_source = mck_sel;
      default: count_ck_source = scki_both | (ss&mck) | csi_slave_stop; // -> Use for CSI Slave
    endcase
end

//======================================//
//  Timer stop signal (TAU in TRGCTL)   //
//======================================//
// Counter STOP both SIN Edge at STS=010
assign stop_trg = seri_fin | st_trg ;

//============================//
//      Count Enable signal   //
//============================//
// Timer md_waiting -> wait selected start trigger(sts)
//       Other mode -> start after writing SS register
wire seri_master_start = ss ;
assign seri_slave_start = (start_slave | ss_trg) & txrx_on;
// remove seri_slave_start & mck redundancy
wire seri_start = ((seri_master_start&mck) | seri_slave_start) & ~count_en_register & se ; 

assign count_start_trg = seri_start ;
                               
// count_en_register set/clr condition
assign ge_cen = count_start_trg | stop_trg;


// count_en_register is eneble signal of count clock;
always @( posedge peclk or negedge peresetz ) begin
    if(~peresetz)         count_en_register <= 1'b0;
//    else if (ge_cen)      count_en_register <= ~stop_trg;
    else if (ge_ss_cen)   count_en_register <= cen_data;
end

// Count clock
assign count_clock = count_en_register & count_ck_source ;

// This is for baud-rate counter(SPR[15:9])
assign b_count_clock = count_en_register & mck;

endmodule

module QLK0RSAU04R2V1_SSDSEL_B1 ( ge_cen, stop_trg, count_en_register, cen_data,
                                  ge_ss, seri_timer_start, ss, ss_data);

input ge_cen;
input stop_trg;
input count_en_register;
input ge_ss;
input seri_timer_start;
input ss;

output ss_data;
output cen_data;

wire cen_data = ge_cen ? ~stop_trg : count_en_register;
wire ss_data = ge_ss ? seri_timer_start : ss;

endmodule 
module QLK0RSAU04R2V1_TRGCTL_C0 (
                     peclk, peresetz, mck,
                     we_ulhw, sel_sdr, 
                     ck0, ck1, cks, dap,
                     scki_rise, scki_fall, scki_both, ckp,
                     st_trg,
                     baud_borrow,
                     se, csi_slave_stop,
                     ccs, txrx_on,
                     seri_fin,
                     count_start_trg, count_clock, b_count_clock, start_slave,
                     async_csi
                     );

//=========================//
//  Interface Definition   //
//=========================//
input  peclk;
input  peresetz;
output mck;
input  we_ulhw;
input  sel_sdr;
input  ck0;
input  ck1;
input  cks;
input  dap;
input  scki_rise;
input  scki_fall;
input  scki_both;
input  ckp;
//input  sin_rise;
//input  sin_fall;
input  st_trg;
input  baud_borrow;
input  se;
input  csi_slave_stop;
//input  sts;
input  ccs;
input  txrx_on;
//input  sis;
input  seri_fin;
input async_csi;

//output st_sel_trg;
output count_start_trg;
output count_clock;
output b_count_clock;
output start_slave;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
wire start_master;
wire start_slave;
wire seri_start_trg;
wire seri_slave_start;
wire ge_cen;
   
wire csi_start_out;

reg ss;
reg count_ck_source;
wire ge_ss;
wire ss_data;
wire ge_ss_cen;

wire mck;
//wire sin_sel_trg;
//reg st_sel_trg;

wire mck_sel;
wire stop_trg;

reg count_en_register;

//wire count_en_data;

wire count_clock;
wire b_count_clock;
wire count_start_trg;
wire seri_timer_start;
//=======================//
//  Serial Start Signal  //
//=======================//
       // SDR write signal
assign csi_start_out = sel_sdr & we_ulhw;

       // start CSI master, UART send, IIC, SCIF send,               CSI slave and dap=1 
       //                                                              This is for preparing SOUT/SPR
assign start_master = csi_start_out & (~ccs | (ccs&dap)) & ~async_csi;

       // Start CSI slave, in cascade mode start signal(SCKIn_even) receive from even ch
assign start_slave = ((~ckp & scki_fall) | (ckp & scki_rise)) & ccs & se;

       // Serial start signal , CSI master, UART send, IIC, SCIF send, CSI slave and dap=1 
//assign seri_start_trg = ~sts & se & txrx_on & (~count_en_register|seri_fin) & start_master & ~ss;
assign seri_start_trg = se & txrx_on & (~count_en_register|seri_fin) & start_master & ~ss;

//=======================//
//  Timer Start Signal   //
//=======================//
// Common Gating signal
assign ge_ss_cen = ge_ss | ge_cen;
// Data Selector
wire cen_data;
QLK0RSAU04R2V1_SSDSEL_C0 ssdsel( .ge_cen(ge_cen), .stop_trg(stop_trg),
                                 .count_en_register(count_en_register), .cen_data(cen_data),
                                 .ge_ss(ge_ss), .seri_timer_start(seri_timer_start), .ss(ss), .ss_data(ss_data) );


wire ss_trg = (ss & count_ck_source);
     // Start signal selector
assign seri_timer_start = seri_start_trg ;
wire clear_ss = count_ck_source | st_trg ;
assign ge_ss = (seri_timer_start | clear_ss) ;


//              ss ____________|~~~~~~~~~~|___________________
//           ge_ss __________|~~~~~~~~~~~~|___________________
// count_ck_source ______|~|____________|~|____________|~|____
//                                        clear until next count clock timing
//                                        I add special process for event mode(2005.8.3)
//                                        because count_ck_source is not active until first available CIN edge,
//                                        So SAU mis-count 1st edge.
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)    ss <= 1'b0;
//  else if (ge_ss)   ss <= seri_timer_start;
  else if (ge_ss_cen) ss <= ss_data;
end


//=====================//
//  MCK Clock Select   //
//=====================//
assign mck = cks ? ck1 : ck0;

//=====================//
//  SINn Edge Select   //
//=====================//
//assign sin_sel_trg = sis ? sin_rise : sin_fall;

//=======================================//
//  timer start signal (TAU in TRGCTL)   //
//=======================================//
//always @( sts or sin_sel_trg) begin
//   case(sts) // synopsys parallel_case
//      1'b1:  st_sel_trg = sin_sel_trg;   // -> Use for start of UART receive
//      default: st_sel_trg = 1'b0;
//    endcase
//end


//========================================//
//  Timer Count Source Clock Selector     //
//========================================//
       // MCK signal is triggered at Timer mode or no baud-rate mode(serial data 16bit),
       //                            start timing(ss), baud-rate counter on serial
//assign mck_sel = (ss | baud_borrow | ~baud_count_en) & mck;
assign mck_sel = (ss | baud_borrow) & mck;
always @( ccs or mck_sel or 
          scki_both or ss or mck or csi_slave_stop) begin
    case(ccs)   // synopsys parallel_case
      1'b0:    count_ck_source = mck_sel;
      default: count_ck_source = scki_both | (ss&mck) | csi_slave_stop; // -> Use for CSI Slave
    endcase
end

//======================================//
//  Timer stop signal (TAU in TRGCTL)   //
//======================================//
// Counter STOP both SIN Edge at STS=010
assign stop_trg = seri_fin | st_trg ;

//============================//
//      Count Enable signal   //
//============================//
// Timer md_waiting -> wait selected start trigger(sts)
//       Other mode -> start after writing SS register
wire seri_master_start = ss ;
assign seri_slave_start = (start_slave | ss_trg) & txrx_on;
// remove seri_slave_start & mck redundancy
wire seri_start = ((seri_master_start&mck) | seri_slave_start) & ~count_en_register & se ; 

assign count_start_trg = seri_start ;
                               
// count_en_register set/clr condition
assign ge_cen = count_start_trg | stop_trg;


// count_en_register is eneble signal of count clock;
always @( posedge peclk or negedge peresetz ) begin
    if(~peresetz)         count_en_register <= 1'b0;
//    else if (ge_cen)      count_en_register <= ~stop_trg;
    else if (ge_ss_cen)   count_en_register <= cen_data;
end

// Count clock
assign count_clock = count_en_register & count_ck_source ;

// This is for baud-rate counter(SPR[15:9])
//assign b_count_clock = baud_count_en & count_en_register & mck;
assign b_count_clock = count_en_register & mck;

endmodule

module QLK0RSAU04R2V1_SSDSEL_C0 ( ge_cen, stop_trg, count_en_register, cen_data,
                                  ge_ss, seri_timer_start, ss, ss_data);

input ge_cen;
input stop_trg;
input count_en_register;
input ge_ss;
input seri_timer_start;
input ss;

output ss_data;
output cen_data;

wire cen_data = ge_cen ? ~stop_trg : count_en_register;
wire ss_data = ge_ss ? seri_timer_start : ss;

endmodule 
module QLK0RSAU04R2V1_TRGCTL_C1 (
                     peclk, peresetz, mck,
                     we_ulhw, sel_sdr, 
                     ck0, ck1, cks, dap,
                     scki_rise, scki_fall, scki_both, ckp,
                     sin_fall, sin_rise,
                     st_trg,
                     baud_borrow,
                     se, csi_slave_stop,
                     sts, ccs, txrx_on, sis,
                     seri_fin,
                     count_start_trg, count_clock, b_count_clock, start_slave
                     );

//=========================//
//  Interface Definition   //
//=========================//
input  peclk;
input  peresetz;
output mck;
input  we_ulhw;
input  sel_sdr;
input  ck0;
input  ck1;
input  cks;
input  dap;
input  scki_rise;
input  scki_fall;
input  scki_both;
input  ckp;
input  sin_rise;
input  sin_fall;
input  st_trg;
input  baud_borrow;
input  se;
input  csi_slave_stop;
input  sts;
input  ccs;
input  txrx_on;
input  sis;
input  seri_fin;

//output st_sel_trg;
output count_start_trg;
output count_clock;
output b_count_clock;
output start_slave;

//=========================//
//  REG/WIRE  Definition   //
//=========================//
wire start_master;
wire start_slave;
wire seri_start_trg;
wire seri_slave_start;
wire ge_cen;
   
wire csi_start_out;

reg ss;
reg count_ck_source;
wire ge_ss;
wire ss_data;
wire ge_ss_cen;

wire mck;
wire sin_sel_trg;
reg st_sel_trg;

wire mck_sel;
wire stop_trg;

reg count_en_register;

//wire count_en_data;

wire count_clock;
wire b_count_clock;
wire count_start_trg;
wire seri_timer_start;
//=======================//
//  Serial Start Signal  //
//=======================//
       // SDR write signal
assign csi_start_out = sel_sdr & we_ulhw;

       // start CSI master, UART send, IIC, SCIF send,               CSI slave and dap=1 
       //                                                              This is for preparing SOUT/SPR
assign start_master = csi_start_out & (~ccs | (ccs&dap));

       // Start CSI slave, in cascade mode start signal(SCKIn_even) receive from even ch
assign start_slave = ((~ckp & scki_fall) | (ckp & scki_rise)) & ccs & se;

       // Serial start signal , CSI master, UART send, IIC, SCIF send, CSI slave and dap=1 
assign seri_start_trg = ~sts & se & txrx_on & (~count_en_register|seri_fin) & start_master & ~ss;

//=======================//
//  Timer Start Signal   //
//=======================//
// Common Gating signal
assign ge_ss_cen = ge_ss | ge_cen;
// Data Selector
wire cen_data;
QLK0RSAU04R2V1_SSDSEL_C1 ssdsel( .ge_cen(ge_cen), .stop_trg(stop_trg),
                                 .count_en_register(count_en_register), .cen_data(cen_data),
                                 .ge_ss(ge_ss), .seri_timer_start(seri_timer_start), .ss(ss), .ss_data(ss_data) );


wire ss_trg = (st_sel_trg & se) | (ss & count_ck_source);

     // Start signal selector
assign seri_timer_start = seri_start_trg ;
wire clear_ss = count_ck_source | st_trg ;
assign ge_ss = (seri_timer_start | clear_ss) ;


//              ss ____________|~~~~~~~~~~|___________________
//           ge_ss __________|~~~~~~~~~~~~|___________________
// count_ck_source ______|~|____________|~|____________|~|____
//                                        clear until next count clock timing
//                                        I add special process for event mode(2005.8.3)
//                                        because count_ck_source is not active until first available CIN edge,
//                                        So SAU mis-count 1st edge.
always@(posedge peclk or negedge peresetz) begin
  if (~peresetz)    ss <= 1'b0;
//  else if (ge_ss)   ss <= seri_timer_start;
  else if (ge_ss_cen) ss <= ss_data;
end


//=====================//
//  MCK Clock Select   //
//=====================//
assign mck = cks ? ck1 : ck0;

//=====================//
//  SINn Edge Select   //
//=====================//
assign sin_sel_trg = sis ? sin_rise : sin_fall;

//=======================================//
//  timer start signal (TAU in TRGCTL)   //
//=======================================//
always @( sts or sin_sel_trg) begin
    case(sts) // synopsys parallel_case
      1'b1:  st_sel_trg = sin_sel_trg;   // -> Use for start of UART receive
      default: st_sel_trg = 1'b0;
    endcase
end


//========================================//
//  Timer Count Source Clock Selector     //
//========================================//
       // MCK signal is triggered at Timer mode or no baud-rate mode(serial data 16bit),
       //                            start timing(ss), baud-rate counter on serial
//assign mck_sel = (ss | baud_borrow | ~baud_count_en) & mck;
assign mck_sel = (ss | baud_borrow) & mck;
always @( ccs or mck_sel or 
          scki_both or ss or mck or csi_slave_stop) begin
    case(ccs)   // synopsys parallel_case
      1'b0:    count_ck_source = mck_sel;
      default: count_ck_source = scki_both | (ss&mck) | csi_slave_stop; // -> Use for CSI Slave
    endcase
end

//======================================//
//  Timer stop signal (TAU in TRGCTL)   //
//======================================//
// Counter STOP both SIN Edge at STS=010
assign stop_trg = seri_fin | st_trg ;

//============================//
//      Count Enable signal   //
//============================//
// Timer md_waiting -> wait selected start trigger(sts)
//       Other mode -> start after writing SS register
wire seri_master_start = ss ;
assign seri_slave_start = (start_slave | ss_trg) & txrx_on;
// remove seri_slave_start & mck redundancy
wire seri_start = ((seri_master_start&mck) | seri_slave_start) & ~count_en_register & se ; 

assign count_start_trg = seri_start ;
                               
// count_en_register set/clr condition
assign ge_cen = count_start_trg | stop_trg;


// count_en_register is eneble signal of count clock;
always @( posedge peclk or negedge peresetz ) begin
    if(~peresetz)         count_en_register <= 1'b0;
//    else if (ge_cen)      count_en_register <= ~stop_trg;
    else if (ge_ss_cen)      count_en_register <= cen_data;
end

// Count clock
assign count_clock = count_en_register & count_ck_source ;

// This is for baud-rate counter(SPR[15:9])
//assign b_count_clock = baud_count_en & count_en_register & mck;
assign b_count_clock = count_en_register & mck;

endmodule

module QLK0RSAU04R2V1_SSDSEL_C1 ( ge_cen, stop_trg, count_en_register, cen_data,
                                  ge_ss, seri_timer_start, ss, ss_data);

input ge_cen;
input stop_trg;
input count_en_register;
input ge_ss;
input seri_timer_start;
input ss;

output ss_data;
output cen_data;

wire cen_data = ge_cen ? ~stop_trg : count_en_register;
wire ss_data = ge_ss ? seri_timer_start : ss;

endmodule 
