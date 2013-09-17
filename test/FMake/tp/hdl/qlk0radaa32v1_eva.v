// [NEC Electronics Group CONFIDENTIAL]
// (C) Copyright NEC Electronics Corporation 2009
// All Rights Reserved. Do not duplicate without prior written
// consent of NEC Electronics Corporation.
//
// Macro Name      : QLK0RADAA32V1
// Version         : 0.0n
// Date            : 2010.02.17
// Author          : Masaru.Takushima(masaru.takushima@nms.necel.com)
// History         : 0.00      2009/10/23 DF1
//                 : 0.01      2009/11/04 DF2
//                 : 0.02      2009/11/24 DF3
//                 : 0.03      2009/11/27
//                 : 0.04      2009/11/30
//                 : 0.05      2009/12/01 ( DF4 for product at 2009/12/11 )
//                 : 0.06      2009/12/14
//                 : 0.07      2009/12/16
//                 : 0.08      2009/12/21
//                 : 0.09      2010/01/05
//                 : 0.09a     2010/01/12
//                 : 0.09b     2010/01/12
//                 : 0.0a      2010/01/13
//                 : 0.0b      2010/01/14
//                 : 0.0c      2010/01/15
//                 : 0.0d      2010/01/18
//                 : 0.0e      2010/01/20
//                 : 0.0f      2010/01/22
//                 : 0.0g      2010/01/23
//                 : 0.0h      2010/01/30
//                 : 0.0i      2010/01/30
//                 : 0.0j      2010/02/01
//                 : 0.0ja     2010/02/02
//                 : 0.0k      2010/02/03
//                 : 0.0m      2010/02/16
//                 : 0.0n      2010/02/17
//
// modify for ICE tetsusi.uemura.fv@rms.renesas.com
//   20100603: add reg_adtyp

module QLK0RADAA32V1 ( 
                       PCLK, PCLKRW, PRESETZ, SCANCLK,
                       PADDR2, PADDR1, PADDR0, PSEL1, PSEL2, PWRITE, PENABLE,

                       PWDATA15, PWDATA14, PWDATA13, PWDATA12,
                       PWDATA11, PWDATA10, PWDATA9,  PWDATA8,
                       PWDATA7,  PWDATA6,  PWDATA5,  PWDATA4,
                       PWDATA3,  PWDATA2,  PWDATA1,  PWDATA0,

                       TTRG0, TTRG1, TTRG2, TTRG3,

                       ADEOCB, ADSAR9, ADSAR8, ADSAR7, ADSAR6, ADSAR5, ADSAR4, ADSAR3, ADSAR2, ADSAR1, ADSAR0,

                       SCANEN, SCANMODE, TESDBT,

                       REQPCLK,

                       PRDATA15, PRDATA14, PRDATA13, PRDATA12,
                       PRDATA11, PRDATA10, PRDATA9,  PRDATA8,
                       PRDATA7,  PRDATA6,  PRDATA5,  PRDATA4,
                       PRDATA3,  PRDATA2,  PRDATA1,  PRDATA0,

                       INTAD,

                       ADCLK, ADPDB,
                       ADCHSEL4, ADCHSEL3, ADCHSEL2, ADCHSEL1, ADCHSEL0,
                       ADBIONB, ADS1, ADOFC, ADCMP, ADCPON,
                       BG2ADEN, BG2ADSEL,
                       ADVSELMOD0, ADVSELMOD1, ADGSELMOD, ADTESMOD0, ADTESMOD1, ADTESMOD2,
                       reg_adtyp
                      );

// from CSC
input          PCLK ;
input          PCLKRW ;
input          PRESETZ ;
input          SCANCLK ;   // v0.0h added

// from APB
input          PADDR2 ;
input          PADDR1 ;
input          PADDR0 ;
input          PSEL1 ;
input          PSEL2 ;
input          PWRITE ;
input          PENABLE ;

input          PWDATA15 ;
input          PWDATA14 ;
input          PWDATA13 ;
input          PWDATA12 ;
input          PWDATA11 ;
input          PWDATA10 ;
input          PWDATA9  ;
input          PWDATA8  ;
input          PWDATA7  ;
input          PWDATA6  ;
input          PWDATA5  ;
input          PWDATA4  ;
input          PWDATA3  ;
input          PWDATA2  ;
input          PWDATA1  ;
input          PWDATA0  ;

// from Timer
input          TTRG0 ; // TAU
input          TTRG1 ; // TAU
input          TTRG2 ; // RTC
input          TTRG3 ; // RTC

// from Hard Macro(H/M)
input          ADEOCB ;
input          ADSAR9 ;
input          ADSAR8 ;
input          ADSAR7 ;
input          ADSAR6 ;
input          ADSAR5 ;
input          ADSAR4 ;
input          ADSAR3 ;
input          ADSAR2 ;
input          ADSAR1 ;
input          ADSAR0 ;

// from MODE CTL
//input          TESEN ;  // 0.02 delete
input          SCANEN ;
input          SCANMODE ;
input          TESDBT ;

// to   CSC
output         REQPCLK ;

// to   APB
output         PRDATA15 ;
output         PRDATA14 ;
output         PRDATA13 ;
output         PRDATA12 ;
output         PRDATA11 ;
output         PRDATA10 ;
output         PRDATA9  ;
output         PRDATA8  ;
output         PRDATA7  ;
output         PRDATA6  ;
output         PRDATA5  ;
output         PRDATA4  ;
output         PRDATA3  ;
output         PRDATA2  ;
output         PRDATA1  ;
output         PRDATA0  ;

// to   INT
output         INTAD ;

// to   Hard Macro(H/M)
output         ADCLK ;
output         ADPDB ;
output         ADCHSEL4 ;
output         ADCHSEL3 ;
output         ADCHSEL2 ;
output         ADCHSEL1 ;
output         ADCHSEL0 ;
output         ADBIONB ;
output         ADS1 ;
output         ADOFC ;
output         ADCMP ;
output         ADCPON ;
output         ADVSELMOD0 ; // 0.01 modified 
output         ADVSELMOD1 ; // 0.01 added 
output         ADGSELMOD ;
output         ADTESMOD0 ;
output         ADTESMOD1 ;
output         ADTESMOD2 ;

// to   BGR
output         BG2ADEN ;   // 0.01 added for TEMP. sensor
output         BG2ADSEL ;  // 0.01 added for TEMP. sensor

//for ICE
output	reg_adtyp;


wire    [9:0]  adsar ;
wire    [9:0]  ADCR ;
wire    [2:0]  reg_fr ;
wire    [1:0]  reg_lv ;
wire    [4:0]  reg_ads ;
wire    [1:0]  reg_adtrs ;
wire    [1:0]  reg_adrefp ;
wire    [7:0]  reg_adul ;
wire    [7:0]  reg_adll ;
wire    [2:0]  reg_adtes ; // 0.01 added
wire    [4:0]  ADCHSEL ;   // 0.01 modified
wire    [9:0]  SAR ;       // 0.01 modified

wire    [1:0]  ADVSELMOD ; // 0.03 added for ICE

wire           reg_adce ;
wire           reg_admd ;
wire           reg_adiss ;
//wire           reg_adtmd ; // 0.0a deleted
wire    [1:0]  reg_adtmd ;   // 0.0a modified
wire           reg_adscm ;
wire           reg_adrefm ;
wire           reg_adrck ;
wire           reg_awc ;
wire           reg_adtyp ;
wire           apb_we1 ;
wire           en_adm0 ;
wire           en_adm1 ;
wire           en_adm2 ;      // 0.0k added
wire           adcs ;         // 0.0k added
wire           en_ads ;

wire           pre_bg2aden ;  // 0.0k added
wire           pre_bg2adsel ; // 0.0k added

wire           EOCBW ;
wire           EOCBC ;        // 0.0k added

wire           ADPDBW ;
wire           ADBIONBW ;
wire           ADS1W ;
wire           ADOFCW ;
wire           ADCMPW ;
wire           ADCPONW ;

wire           ADVSELMOD0W ; // 0.03 added for ICE
wire           ADVSELMOD1W ; // 0.03 added for ICE
wire           ADGSELMODW ;  // 0.03 added for ICE
wire           ADTESMOD0W ;  // 0.03 added for ICE
wire           ADTESMOD1W ;  // 0.03 added for ICE
wire           ADTESMOD2W ;  // 0.03 added for ICE

//wire           BG2ADENW ;  // 0.0k deleted
//wire           BG2ADSELW ; // 0.0k deleted


//wire           reg_adtes_2b ;
//wire           dis ;

assign  adsar = { ADSAR9, ADSAR8, ADSAR7, ADSAR6, ADSAR5, ADSAR4, ADSAR3, ADSAR2, ADSAR1, ADSAR0 } ;
assign  EOCBW = ADEOCB ;

//assign  reg_adtes_2b = reg_adtes[2];
assign  ADVSELMOD0W = ADVSELMOD[0];  // 0.03 added for ICE
assign  ADVSELMOD1W = ADVSELMOD[1];  // 0.03 added for ICE

QLK0RADAA32V1_APBIF apbif   (
                             .PCLKRW(PCLKRW), .PRESETZ(PRESETZ),
                             .PADDR2(PADDR2), .PADDR1(PADDR1), .PADDR0(PADDR0), .PSEL1(PSEL1), .PSEL2(PSEL2), .PWRITE(PWRITE), .PENABLE(PENABLE),

                             .PWDATA15(PWDATA15), .PWDATA14(PWDATA14), .PWDATA13(PWDATA13), .PWDATA12(PWDATA12),
                             .PWDATA11(PWDATA11), .PWDATA10(PWDATA10), .PWDATA9(PWDATA9),  .PWDATA8(PWDATA8),
                             .PWDATA7(PWDATA7),  .PWDATA6(PWDATA6),  .PWDATA5(PWDATA5),  .PWDATA4(PWDATA4),
                             .PWDATA3(PWDATA3),  .PWDATA2(PWDATA2),  .PWDATA1(PWDATA1),  .PWDATA0(PWDATA0),

                             .adcs(adcs), .ADCR(ADCR), 

                             .PRDATA15(PRDATA15), .PRDATA14(PRDATA14), .PRDATA13(PRDATA13), .PRDATA12(PRDATA12),
                             .PRDATA11(PRDATA11), .PRDATA10(PRDATA10), .PRDATA9(PRDATA9),  .PRDATA8(PRDATA8),
                             .PRDATA7(PRDATA7),  .PRDATA6(PRDATA6),  .PRDATA5(PRDATA5),  .PRDATA4(PRDATA4),
                             .PRDATA3(PRDATA3),  .PRDATA2(PRDATA2),  .PRDATA1(PRDATA1),  .PRDATA0(PRDATA0),

                             .reg_admd(reg_admd), .reg_fr(reg_fr), .reg_lv(reg_lv), .reg_adce(reg_adce),
                             .reg_adiss(reg_adiss), .reg_ads(reg_ads),
                             .reg_adtmd(reg_adtmd), .reg_adscm(reg_adscm), .reg_adtrs(reg_adtrs),
                             .reg_adrefp(reg_adrefp), .reg_adrefm(reg_adrefm), .reg_adrck(reg_adrck), .reg_awc(reg_awc), .reg_adtyp(reg_adtyp),
                             .reg_adul(reg_adul), .reg_adll(reg_adll), .reg_adtes(reg_adtes),

                             .apb_we1(apb_we1), .en_adm0(en_adm0), .en_adm1(en_adm1), .en_adm2(en_adm2), .en_ads(en_ads),
                             .pre_bg2aden(pre_bg2aden), .pre_bg2adsel(pre_bg2adsel)
                             );

QLK0RADAA32V1_CORE   core   (
                             .SCANMODE(SCANMODE),
                             .PCLK(PCLK), .PRESETZ(PRESETZ), .SCANCLK(SCANCLK),
                             .PWDATA15(PWDATA15), .PWDATA7(PWDATA7), .PWDATA2(PWDATA2), .PWDATA0(PWDATA0),

                             .TTRG0(TTRG0), .TTRG1(TTRG1), .TTRG2(TTRG2), .TTRG3(TTRG3),
//                           .EOCB(EOCB), .SAR(SAR),
                             .EOCB(EOCBC), .SAR(SAR),

                             .apb_we1(apb_we1), .en_adm0(en_adm0), .en_ads(en_ads),
                             .en_adm2(en_adm2),

                             .reg_adce(reg_adce),
                             .reg_admd(reg_admd), .reg_fr(reg_fr), .reg_lv(reg_lv),
                             .reg_adiss(reg_adiss), .reg_ads(reg_ads),
                             .reg_adtmd(reg_adtmd), .reg_adscm(reg_adscm), .reg_adtrs(reg_adtrs),
                             .reg_adrck(reg_adrck), .reg_awc(reg_awc), .reg_adtyp(reg_adtyp),
                             .reg_adul(reg_adul), .reg_adll(reg_adll),
                             .reg_adrefp(reg_adrefp), .reg_adrefm(reg_adrefm), .reg_adtes(reg_adtes),

                             .ADCLK(ADCLK), .ADPDB(ADPDBW), .ADBIONB(ADBIONBW), .ADS1(ADS1W), .ADOFC(ADOFCW),
                             .ADCMP(ADCMPW), .ADCPON(ADCPONW), .ADCHSEL(ADCHSEL),
                             .ADVSELMOD(ADVSELMOD), .ADGSELMOD(ADGSELMODW),
                             .ADTESMOD0(ADTESMOD0W), .ADTESMOD1(ADTESMOD1W), .ADTESMOD2(ADTESMOD2W),

//                           .BG2ADEN(BG2ADENW), .BG2ADSEL(BG2ADSELW),

                             .adcs(adcs), .ADCR(ADCR), .reqpclk(REQPCLK), .intad(INTAD)
                             );

QLK0RADAA32V1_BYPASS bypass (
                              .SCANMODE(SCANMODE), .TESDBT(TESDBT),

//                            .reg_adrefp(reg_adrefp), .reg_adrefm(reg_adrefm), .reg_adtes(reg_adtes),
//                            .dis(dis),

                              .ADPDBS(ADPDBW), .ADBIONBS(ADBIONBW), .ADS1S(ADS1W), .ADOFCS(ADOFCW), .ADCMPS(ADCMPW),
                              .ADCPONS(ADCPONW), .ADCHSEL(ADCHSEL),  
                              .ADVSELMOD0S(ADVSELMOD0W), .ADVSELMOD1S(ADVSELMOD1W), .ADGSELMODS(ADGSELMODW),
                              .ADTESMOD0S(ADTESMOD0W), .ADTESMOD1S(ADTESMOD1W), .ADTESMOD2S(ADTESMOD2W),
                              
//                            .BG2ADENS(BG2ADENW), .BG2ADSELS(BG2ADSELW),
                              .BG2ADENS(pre_bg2aden), .BG2ADSELS(pre_bg2adsel),

                              .ADEOCB(EOCBW), .ADSAR(adsar),

                              .ADPDBH(ADPDB), .ADBIONBH(ADBIONB), .ADS1H(ADS1), .ADOFCH(ADOFC), .ADCMPH(ADCMP),
                              .ADCPONH(ADCPON),

                              .ADCHSEL4H(ADCHSEL4), .ADCHSEL3H(ADCHSEL3), .ADCHSEL2H(ADCHSEL2), .ADCHSEL1H(ADCHSEL1), .ADCHSEL0H(ADCHSEL0),
                              .ADVSELMOD0H(ADVSELMOD0), .ADVSELMOD1H(ADVSELMOD1), .ADGSELMODH(ADGSELMOD),
                              .ADTESMOD0H(ADTESMOD0), .ADTESMOD1H(ADTESMOD1), .ADTESMOD2H(ADTESMOD2),

                              .BG2ADENH(BG2ADEN), .BG2ADSELH(BG2ADSEL),

//                            .EOCB(EOCB), .SAR(SAR)
                              .EOCB(EOCBC), .SAR(SAR)
                             );

endmodule


module QLK0RADAA32V1_APBIF ( 
                              PCLKRW, PRESETZ,
                              PADDR2, PADDR1, PADDR0, PSEL1, PSEL2, PWRITE, PENABLE,

                              PWDATA15, PWDATA14, PWDATA13, PWDATA12,
                              PWDATA11, PWDATA10, PWDATA9,  PWDATA8,
                              PWDATA7,  PWDATA6,  PWDATA5,  PWDATA4,
                              PWDATA3,  PWDATA2,  PWDATA1,  PWDATA0,

                              adcs, ADCR,

                              PRDATA15, PRDATA14, PRDATA13, PRDATA12,
                              PRDATA11, PRDATA10, PRDATA9,  PRDATA8,
                              PRDATA7,  PRDATA6,  PRDATA5,  PRDATA4,
                              PRDATA3,  PRDATA2,  PRDATA1,  PRDATA0,

                              reg_admd, reg_fr, reg_lv, reg_adce,
                              reg_adiss, reg_ads,
                              reg_adtmd, reg_adscm, reg_adtrs,
                              reg_adrefp, reg_adrefm, reg_adrck, reg_awc, reg_adtyp,
                              reg_adul, reg_adll, reg_adtes,

                              apb_we1, en_adm0, en_adm1, en_adm2, en_ads, 
                              pre_bg2aden, pre_bg2adsel

                              );

// to  APB
input          PCLKRW, PRESETZ ;

input          PADDR2 ;
input          PADDR1 ;
input          PADDR0 ;
input          PSEL1, PSEL2 ;
input          PWRITE ;
input          PENABLE ;

input          PWDATA15 ;
input          PWDATA14 ;
input          PWDATA13 ;
input          PWDATA12 ;
input          PWDATA11 ;
input          PWDATA10 ;
input          PWDATA9  ;
input          PWDATA8  ;
input          PWDATA7  ;
input          PWDATA6  ;
input          PWDATA5  ;
input          PWDATA4  ;
input          PWDATA3  ;
input          PWDATA2  ;
input          PWDATA1  ;
input          PWDATA0  ;

// from CORE
input          adcs ;
input   [9:0]  ADCR ;

// to  APB
output         PRDATA15 ;
output         PRDATA14 ;
output         PRDATA13 ;
output         PRDATA12 ;
output         PRDATA11 ;
output         PRDATA10 ;
output         PRDATA9  ;
output         PRDATA8  ;
output         PRDATA7  ;
output         PRDATA6  ;
output         PRDATA5  ;
output         PRDATA4  ;
output         PRDATA3  ;
output         PRDATA2  ;
output         PRDATA1  ;
output         PRDATA0  ;

// to  CORE
output         reg_admd ;
output  [2:0]  reg_fr ;
output  [1:0]  reg_lv ;
output         reg_adce ;
output         reg_adiss ;
output  [4:0]  reg_ads ;
//output         reg_adtmd ; // 0.0a deleted
output  [1:0]  reg_adtmd ;   // 0.0a modified
output         reg_adscm ;
output  [1:0]  reg_adtrs ;
output  [1:0]  reg_adrefp ;
output         reg_adrefm ;
output         reg_adrck ;
output         reg_awc ;
output         reg_adtyp ;
output  [7:0]  reg_adul ;
output  [7:0]  reg_adll ;
output  [2:0]  reg_adtes ;  // 0.01 added test mode

output         apb_we1 ;
output         en_adm0 ;
output         en_adm1 ;
output         en_ads ;
output         en_adm2 ;       // 0.0b added
output         pre_bg2aden ;   // 0.0k added
output         pre_bg2adsel ;  // 0.0k added

wire           reg_admd ;
wire    [2:0]  reg_fr ;
wire    [1:0]  reg_lv ;
wire           reg_adce ;
wire           reg_adiss ;
wire    [4:0]  reg_ads ;
//wire           reg_adtmd ;// 0.0a deleted
wire    [1:0]  reg_adtmd ;  // 0.0a modified
wire           reg_adscm ;
wire    [1:0]  reg_adtrs ;
wire    [1:0]  reg_adrefp ;
wire           reg_adrefm ;
wire           reg_adrck ;
wire           reg_awc ;
wire           reg_adtyp ;
wire    [7:0]  reg_adul ;
wire    [7:0]  reg_adll ;
wire    [2:0]  reg_adtes ;

wire           sel_adm0 ;
wire           sel_ads ;
wire           sel_adm1 ;
wire           sel_adcr ;
wire           sel_adcrh ;
wire           sel_adm2 ;
wire           sel_adul ;
wire           sel_adll ;
wire           sel_adtes ;

wire           apb_we1 ;
wire           apb_we2 ;
wire           apb_re ;
wire           en_adm0 ;
wire           en_adm1 ;
wire           en_ads ;

QLK0RADAA32V1_BUSCTL busctl (
                             .PSEL1(PSEL1), .PSEL2(PSEL2), .PADDR2(PADDR2), .PADDR1(PADDR1), .PADDR0(PADDR0), .PWRITE(PWRITE), .PENABLE(PENABLE),

                             .sel_adm0(sel_adm0), .sel_ads(sel_ads), .sel_adm1(sel_adm1),
                             .sel_adcr(sel_adcr), .sel_adcrh(sel_adcrh),
                             .sel_adm2(sel_adm2), .sel_adul(sel_adul), .sel_adll(sel_adll), .sel_adtes(sel_adtes),

                             .apb_we1(apb_we1), .apb_we2(apb_we2), .apb_re(apb_re) 
                            );

QLK0RADAA32V1_REGTOP regtop (
                             .PCLKRW(PCLKRW), .PRESETZ(PRESETZ),
  
                             .PWDATA15(PWDATA15), .PWDATA14(PWDATA14), .PWDATA13(PWDATA13), .PWDATA12(PWDATA12),
                             .PWDATA11(PWDATA11), .PWDATA10(PWDATA10), .PWDATA9(PWDATA9),  .PWDATA8(PWDATA8),
                             .PWDATA7(PWDATA7),  .PWDATA6(PWDATA6),  .PWDATA5(PWDATA5),  .PWDATA4(PWDATA4),
                             .PWDATA3(PWDATA3),  .PWDATA2(PWDATA2),  .PWDATA1(PWDATA1),  .PWDATA0(PWDATA0),

                             .sel_adm0(sel_adm0), .sel_ads(sel_ads), .sel_adm1(sel_adm1),
                             .sel_adcr(sel_adcr), .sel_adcrh(sel_adcrh),
                             .sel_adm2(sel_adm2), .sel_adul(sel_adul), .sel_adll(sel_adll), .sel_adtes(sel_adtes),

                             .apb_we1(apb_we1), .apb_we2(apb_we2), .apb_re(apb_re), .adcs(adcs), .ADCR(ADCR),

                             .reg_admd(reg_admd), .reg_fr(reg_fr), .reg_lv(reg_lv), .reg_adce(reg_adce),
                             .reg_adiss(reg_adiss), .reg_ads(reg_ads),
                             .reg_adtmd(reg_adtmd), .reg_adscm(reg_adscm), .reg_adtrs(reg_adtrs),
                             .reg_adrefp(reg_adrefp), .reg_adrefm(reg_adrefm), .reg_adrck(reg_adrck), .reg_awc(reg_awc), .reg_adtyp(reg_adtyp),
                             .reg_adul(reg_adul), .reg_adll(reg_adll), .reg_adtes(reg_adtes),

                             .en_adm0(en_adm0), .en_adm1(en_adm1), .en_adm2(en_adm2), .en_ads(en_ads),
                             .pre_bg2aden(pre_bg2aden), .pre_bg2adsel(pre_bg2adsel),

                             .PRDATA15(PRDATA15), .PRDATA14(PRDATA14), .PRDATA13(PRDATA13), .PRDATA12(PRDATA12),
                             .PRDATA11(PRDATA11), .PRDATA10(PRDATA10), .PRDATA9(PRDATA9),  .PRDATA8(PRDATA8),
                             .PRDATA7(PRDATA7),  .PRDATA6(PRDATA6),  .PRDATA5(PRDATA5),  .PRDATA4(PRDATA4),
                             .PRDATA3(PRDATA3),  .PRDATA2(PRDATA2),  .PRDATA1(PRDATA1),  .PRDATA0(PRDATA0)
                            );

endmodule


module QLK0RADAA32V1_BUSCTL ( 
                              PADDR2, PADDR1, PADDR0, PSEL1, PSEL2, PWRITE, PENABLE,

                              sel_adm0, sel_ads, sel_adm1, sel_adcr, sel_adcrh,
                              sel_adm2, sel_adul, sel_adll, sel_adtes,
                              apb_we1, apb_we2, apb_re 
                              );

input          PADDR2 ;
input          PADDR1 ;
input          PADDR0 ;
input          PSEL1, PSEL2 ;
input          PWRITE ;
input          PENABLE ;

output         sel_adm0 ;
output         sel_ads ;
output         sel_adm1 ;
output         sel_adcr ;
output         sel_adcrh ;
output         sel_adm2 ;
output         sel_adul ;
output         sel_adll ;
output         sel_adtes ;  // 0.01 added test mode

output         apb_we1, apb_we2 ;
output         apb_re ;

QLK0RADAA32V1_ADDEC addec (
                           .PSEL1(PSEL1), .PSEL2(PSEL2), .PADDR2(PADDR2), .PADDR1(PADDR1), .PADDR0(PADDR0),

                           .sel_adm0(sel_adm0), .sel_ads(sel_ads), .sel_adm1(sel_adm1),
                           .sel_adcr(sel_adcr), .sel_adcrh(sel_adcrh),
                           .sel_adm2(sel_adm2), .sel_adul(sel_adul), .sel_adll(sel_adll),
                           .sel_adtes(sel_adtes)
                           );

QLK0RADAA32V1_ENCTL enctl (
                           .PSEL1(PSEL1), .PSEL2(PSEL2), .PWRITE(PWRITE), .PENABLE(PENABLE),

                           .apb_we1(apb_we1), .apb_we2(apb_we2), .apb_re(apb_re)
                           );

endmodule


module QLK0RADAA32V1_ADDEC ( 
                             PADDR2, PADDR1, PADDR0, PSEL1, PSEL2,
                             sel_adm0, sel_ads, sel_adm1, sel_adcr, sel_adcrh,
                             sel_adm2, sel_adul, sel_adll, sel_adtes
                             );

input          PADDR2 ;
input          PADDR1 ;
input          PADDR0 ;
input          PSEL1, PSEL2 ;

output         sel_adm0 ;
output         sel_ads ;
output         sel_adm1 ;
output         sel_adcr ;
output         sel_adcrh ;
output         sel_adm2 ;
output         sel_adul ;
output         sel_adll ;
output         sel_adtes ;  // 0.01 added test mode

reg     [4:0]  sel_reg1 ;
reg     [3:0]  sel_reg2 ;   // 0.01 modified test mode register

wire    [2:0]  paddr ;

assign  paddr = { PADDR2, PADDR1, PADDR0 } ;

always  @( PSEL1 or paddr[2:0] ) 
        if ( !PSEL1 ) sel_reg1 = 5'b00000 ;
        else
          casex ( paddr[2:0] )
            3'b000  : sel_reg1 = 5'b00001 ;    // 00H
            3'b001  : sel_reg1 = 5'b00010 ;    // 01H
            3'b010  : sel_reg1 = 5'b00100 ;    // 02H
            3'b110  : sel_reg1 = 5'b01000 ;    // 06H
            3'b111  : sel_reg1 = 5'b10000 ;    // 07H
            default : sel_reg1 = 5'b00000 ;    // xxH
          endcase

assign  sel_adm0  = sel_reg1[0] ;
assign  sel_ads   = sel_reg1[1] ;
assign  sel_adm1  = sel_reg1[2] ;
assign  sel_adcr  = sel_reg1[3] ;
assign  sel_adcrh = sel_reg1[4] ;

always  @( PSEL2 or paddr[1:0] )
        if ( !PSEL2 ) sel_reg2 = 4'b0000 ;
        else
          casex ( paddr[1:0] )
            2'b00   : sel_reg2 = 4'b0001 ;   // 00H
            2'b01   : sel_reg2 = 4'b0010 ;   // 01H
            2'b10   : sel_reg2 = 4'b0100 ;   // 02H
            2'b11   : sel_reg2 = 4'b1000 ;   // 03H  0.01 added test mode
            default : sel_reg2 = 4'b0000 ;   // xxH
          endcase

assign sel_adm2  = sel_reg2[0] ;
assign sel_adul  = sel_reg2[1] ;
assign sel_adll  = sel_reg2[2] ;
assign sel_adtes = sel_reg2[3] ;  // 0.01 added test mode

endmodule


module QLK0RADAA32V1_ENCTL ( 
                             PSEL1, PSEL2, PWRITE, PENABLE,
                             apb_we1, apb_we2, apb_re 
                             );

input          PSEL1, PSEL2 ;
input          PWRITE ;
input          PENABLE ;

output         apb_we1, apb_we2 ;
output         apb_re ;

assign  apb_we1 = PSEL1 & PWRITE ;
assign  apb_we2 = PSEL2 & PWRITE ;

assign  apb_re  = ( PSEL1 | PSEL2 ) & ~PWRITE & PENABLE ;


endmodule


module QLK0RADAA32V1_REGTOP ( 
                              PCLKRW, PRESETZ,

                              PWDATA15, PWDATA14, PWDATA13, PWDATA12,
                              PWDATA11, PWDATA10, PWDATA9,  PWDATA8,
                              PWDATA7,  PWDATA6,  PWDATA5,  PWDATA4,
                              PWDATA3,  PWDATA2,  PWDATA1,  PWDATA0,

                              sel_adm0, sel_ads, sel_adm1, sel_adcr, sel_adcrh,
                              sel_adm2, sel_adul, sel_adll, sel_adtes,
                              apb_we1, apb_we2, apb_re,
                              adcs, ADCR,

                              PRDATA15, PRDATA14, PRDATA13, PRDATA12,
                              PRDATA11, PRDATA10, PRDATA9,  PRDATA8,
                              PRDATA7,  PRDATA6,  PRDATA5,  PRDATA4,
                              PRDATA3,  PRDATA2,  PRDATA1,  PRDATA0,

                              reg_admd, reg_fr, reg_lv, reg_adce,
                              reg_adiss, reg_ads,
                              reg_adtmd, reg_adscm, reg_adtrs,
                              reg_adrefp, reg_adrefm, reg_adrck, reg_awc, reg_adtyp,
                              reg_adul, reg_adll, reg_adtes,

                              en_adm0, en_adm1, en_adm2, en_ads,
                              pre_bg2aden, pre_bg2adsel

                              );

// to  APB
input          PCLKRW, PRESETZ ;

input          PWDATA15 ;
input          PWDATA14 ;
input          PWDATA13 ;
input          PWDATA12 ;
input          PWDATA11 ;
input          PWDATA10 ;
input          PWDATA9  ;
input          PWDATA8  ;
input          PWDATA7  ;
input          PWDATA6  ;
input          PWDATA5  ;
input          PWDATA4  ;
input          PWDATA3  ;
input          PWDATA2  ;
input          PWDATA1  ;
input          PWDATA0  ;

// from CORE
input          adcs ;
input   [9:0]  ADCR ;

// from BUSCTL
input          sel_adm0 ;
input          sel_ads ;
input          sel_adm1 ;
input          sel_adcr ;
input          sel_adcrh ;
input          sel_adm2 ;
input          sel_adul ;
input          sel_adll ;
input          sel_adtes ; // 0.01 added test mode
input          apb_we1 ;
input          apb_we2 ;
input          apb_re ;

// to  APB
output         PRDATA15 ;
output         PRDATA14 ;
output         PRDATA13 ;
output         PRDATA12 ;
output         PRDATA11 ;
output         PRDATA10 ;
output         PRDATA9  ;
output         PRDATA8  ;
output         PRDATA7  ;
output         PRDATA6  ;
output         PRDATA5  ;
output         PRDATA4  ;
output         PRDATA3  ;
output         PRDATA2  ;
output         PRDATA1  ;
output         PRDATA0  ;

// to  CORE
output         reg_admd ;
output  [2:0]  reg_fr ;
output  [1:0]  reg_lv ;
output         reg_adce ;
output         reg_adiss ;
output  [4:0]  reg_ads ;
//output         reg_adtmd ;  // 0.0a deleted
output  [1:0]  reg_adtmd ;    // 0.0a modified
output         reg_adscm ;
output  [1:0]  reg_adtrs ;
output  [1:0]  reg_adrefp ;
output         reg_adrefm ;
output         reg_adrck ;
output         reg_awc ;
output         reg_adtyp ;
output  [7:0]  reg_adul ;
output  [7:0]  reg_adll ;
output  [2:0]  reg_adtes ;     // 0.01 added test mode

output         en_adm0 ;
output         en_adm1 ;
output         en_ads ;
output         en_adm2 ;       // 0.0b added
output         pre_bg2aden ;   // 0.0k added
output         pre_bg2adsel ;  // 0.0k added

wire    [7:0]  adm0 ;
wire    [7:0]  ads ;
wire    [7:0]  adm1 ;
wire    [7:0]  adm2 ;
wire    [7:0]  adul ;
wire    [7:0]  adll ;
wire    [7:0]  adtes ;  // 0.01 added test mode
wire    [15:0] dout ;


QLK0RADAA32V1_REGWR regwr (
                           .PCLKRW(PCLKRW), .PRESETZ(PRESETZ),

                           .PWDATA15(PWDATA15), .PWDATA14(PWDATA14), .PWDATA13(PWDATA13), .PWDATA12(PWDATA12),
                           .PWDATA11(PWDATA11), .PWDATA10(PWDATA10), .PWDATA9(PWDATA9),  .PWDATA8(PWDATA8),
                           .PWDATA7(PWDATA7),  .PWDATA6(PWDATA6),  .PWDATA5(PWDATA5),  .PWDATA4(PWDATA4),
                           .PWDATA3(PWDATA3),  .PWDATA2(PWDATA2),  .PWDATA1(PWDATA1),  .PWDATA0(PWDATA0),

                           .sel_adm0(sel_adm0), .sel_ads(sel_ads), .sel_adm1(sel_adm1),
                           .sel_adm2(sel_adm2), .sel_adul(sel_adul), .sel_adll(sel_adll),
                           .sel_adtes(sel_adtes),

                           .apb_we1(apb_we1), .apb_we2(apb_we2), .adcs(adcs),

                           .en_adm0(en_adm0), .en_adm1(en_adm1), .en_adm2(en_adm2), .en_ads(en_ads),

                           .reg_admd(reg_admd), .reg_fr(reg_fr), .reg_lv(reg_lv), .reg_adce(reg_adce),
                           .reg_adiss(reg_adiss), .reg_ads(reg_ads),
                           .reg_adtmd(reg_adtmd), .reg_adscm(reg_adscm), .reg_adtrs(reg_adtrs),
                           .reg_adrefp(reg_adrefp), .reg_adrefm(reg_adrefm), .reg_adrck(reg_adrck), .reg_awc(reg_awc), .reg_adtyp(reg_adtyp),
                           .reg_adul(reg_adul), .reg_adll(reg_adll),
                           .reg_adtes(reg_adtes),
                           .pre_bg2aden(pre_bg2aden), .pre_bg2adsel(pre_bg2adsel),

                           .adm0(adm0), .ads(ads), .adm1(adm1), .adm2(adm2), .adul(adul), .adll(adll), .adtes(adtes)
                           );

QLK0RADAA32V1_RDATA rdata (
                           .sel_adm0(sel_adm0), .sel_ads(sel_ads), .sel_adm1(sel_adm1), .sel_adcr(sel_adcr), .sel_adcrh(sel_adcrh),
                           .sel_adm2(sel_adm2), .sel_adul(sel_adul), .sel_adll(sel_adll),
                           .sel_adtes(sel_adtes),

                           .adm0(adm0), .ads(ads), .adm1(adm1), .adm2(adm2), .adul(adul), .adll(adll), .adtes(adtes), .ADCR(ADCR),

                           .dout(dout)
                           );

QLK0RADAA32V1_REGRD regrd (
                           .apb_re(apb_re),
                           .dout(dout),

                           .PRDATA15(PRDATA15), .PRDATA14(PRDATA14), .PRDATA13(PRDATA13), .PRDATA12(PRDATA12),
                           .PRDATA11(PRDATA11), .PRDATA10(PRDATA10), .PRDATA9(PRDATA9),  .PRDATA8(PRDATA8),
                           .PRDATA7(PRDATA7),  .PRDATA6(PRDATA6),  .PRDATA5(PRDATA5),  .PRDATA4(PRDATA4),
                           .PRDATA3(PRDATA3),  .PRDATA2(PRDATA2),  .PRDATA1(PRDATA1),  .PRDATA0(PRDATA0)
                           );

endmodule

module QLK0RADAA32V1_REGWR ( 
                             PCLKRW, PRESETZ,

                             PWDATA15, PWDATA14, PWDATA13, PWDATA12,
                             PWDATA11, PWDATA10, PWDATA9,  PWDATA8,
                             PWDATA7,  PWDATA6,  PWDATA5,  PWDATA4,
                             PWDATA3,  PWDATA2,  PWDATA1,  PWDATA0,

                             sel_adm0, sel_ads, sel_adm1,
                             sel_adm2, sel_adul, sel_adll,
                             sel_adtes,

                             apb_we1, apb_we2,
                             adcs,

                             reg_admd, reg_fr, reg_lv, reg_adce,
                             reg_adiss, reg_ads,
                             reg_adtmd, reg_adscm, reg_adtrs,
                             reg_adrefp, reg_adrefm, reg_adrck, reg_awc, reg_adtyp,
                             reg_adul, reg_adll,
                             reg_adtes,

                             adm0, ads, adm1, adm2, adul, adll, adtes,
                             en_adm0, en_adm1, en_adm2, en_ads,
                             pre_bg2aden, pre_bg2adsel

                             );

// from APB
input          PCLKRW, PRESETZ ;

input          PWDATA15 ;
input          PWDATA14 ;
input          PWDATA13 ;
input          PWDATA12 ;
input          PWDATA11 ;
input          PWDATA10 ;
input          PWDATA9  ;
input          PWDATA8  ;
input          PWDATA7  ;
input          PWDATA6  ;
input          PWDATA5  ;
input          PWDATA4  ;
input          PWDATA3  ;
input          PWDATA2  ;
input          PWDATA1  ;
input          PWDATA0  ;

// from BUSCTL
input          sel_adm0 ;
input          sel_ads ;
input          sel_adm1 ;
input          sel_adm2 ;
input          sel_adul ;
input          sel_adll ;
input          sel_adtes ;  // 0.01 added test mode
input          apb_we1 ;
input          apb_we2 ;

// from CORE
input          adcs ;

// to  CORE
output         reg_admd ;
output  [2:0]  reg_fr ;
output  [1:0]  reg_lv ;
output         reg_adce ;
output         reg_adiss ;
output  [4:0]  reg_ads ;
//output         reg_adtmd ;  // 0.0a deleted
output  [1:0]  reg_adtmd ;    // 0.0a added
output         reg_adscm ;
output  [1:0]  reg_adtrs ;
output  [1:0]  reg_adrefp ;
output         reg_adrefm ;
output         reg_adrck ;
output         reg_awc ;
output         reg_adtyp ;
output  [7:0]  reg_adul ;
output  [7:0]  reg_adll ;
output  [2:0]  reg_adtes ;  // 0.01 added test mode

output  [7:0]  adm0 ;  // PSEL1 & 00H
output  [7:0]  ads ;   // PSEL1 & 01H
output  [7:0]  adm1 ;  // PSEL1 & 10H
output  [7:0]  adm2 ;  // PSEL2 & 00H
output  [7:0]  adul ;  // PSEL2 & 01H
output  [7:0]  adll ;  // PSEL2 & 10H
output  [7:0]  adtes ; // PSEL2 & 10H  0.01 added test mode

output         en_adm0 ;
output         en_adm1 ;
output         en_ads ;
output         en_adm2 ;      // 0.0b added
output         pre_bg2aden ;  // 0.0k added
output         pre_bg2adsel ; // 0.0k added

reg            reg_admd ;
reg     [2:0]  reg_fr ;
reg     [1:0]  reg_lv ;
reg            reg_adce ;
reg            reg_adiss ;
reg     [4:0]  reg_ads ;
//reg            reg_adtmd ; // 0.0a deleted
reg     [1:0]  reg_adtmd ;   // 0.0a added
reg            reg_adscm ;
reg     [1:0]  reg_adtrs ;
reg     [1:0]  reg_adrefp ;
reg            reg_adrefm ;
reg            reg_adrck ;
reg            reg_awc ;
reg            reg_adtyp ;
reg     [7:0]  reg_adul ;
reg     [7:0]  reg_adll ;
reg     [2:0]  reg_adtes ;     // 0.01 added test mode
reg            pre_bg2adsel_r ;  // 0.0k added

wire    [15:0] WRDATA ;
wire           en_adm0, en_ads, en_adm1, en_adm2, en_adul, en_adll ;
wire           en_adtes ;  // 0.01 added test mode
wire           sel_data ;  // 0.0k added

wire    [7:0]  adm0 ;  // PSEL1 & 00H
wire    [7:0]  ads ;   // PSEL1 & 01H
wire    [7:0]  adm1 ;  // PSEL1 & 10H
wire    [7:0]  adm2 ;  // PSEL2 & 00H
wire    [7:0]  adul ;  // PSEL2 & 01H
wire    [7:0]  adll ;  // PSEL2 & 10H
wire    [7:0]  adtes ; // PSEL2 & 11H  0.01 added test mode

wire		pre_bg2adsel ;

assign   WRDATA = { PWDATA15, PWDATA14, PWDATA13, PWDATA12,
                    PWDATA11, PWDATA10, PWDATA9,  PWDATA8,
                    PWDATA7,  PWDATA6,  PWDATA5,  PWDATA4,
                    PWDATA3,  PWDATA2,  PWDATA1,  PWDATA0 } ;

// generate FF enable signal "en_xxx"
assign  en_adm0  = apb_we1 & sel_adm0 ;
assign  en_ads   = apb_we1 & sel_ads ;
assign  en_adm1  = apb_we1 & sel_adm1 ;
assign  en_adm2  = apb_we2 & sel_adm2 ;
assign  en_adul  = apb_we2 & sel_adul ;
assign  en_adll  = apb_we2 & sel_adll ;
assign  en_adtes = apb_we2 & sel_adtes ;  // 0.01 added test mode

// ADM0 register write
always  @(negedge PRESETZ or posedge PCLKRW) begin
        if(!PRESETZ) 
            {reg_admd, reg_fr[2:0], reg_lv[1:0], reg_adce} <= 7'b0000000;
        else if ( en_adm0 )
            {reg_admd, reg_fr[2:0], reg_lv[1:0], reg_adce} <= WRDATA[6:0];
end

// ADM1 register write
always  @(negedge PRESETZ or posedge PCLKRW) begin
        if(!PRESETZ) 
//          {reg_adtmd, reg_adscm, reg_adtrs[1:0]} <= 4'b0000;                          // 0.0a deleted
            {reg_adtmd[1:0], reg_adscm, reg_adtrs[1:0]} <= 5'b00000;                    // 0.0a modified
        else if ( en_adm1 )
//          {reg_adtmd, reg_adscm, reg_adtrs[1:0]} <= {WRDATA[7:6], WRDATA[1:0]};       // 0.0a deleted
            {reg_adtmd[1:0], reg_adscm, reg_adtrs[1:0]} <= {WRDATA[7:5], WRDATA[1:0]};  // 0.0a modified
end

// ADM2 register write
always  @(negedge PRESETZ or posedge PCLKRW) begin
        if(!PRESETZ) 
            {reg_adrefp[1:0], reg_adrefm, reg_adrck, reg_awc, reg_adtyp} <= 6'b000000;
        else if ( en_adm2 )
            {reg_adrefp[1:0], reg_adrefm, reg_adrck, reg_awc, reg_adtyp} <= {WRDATA[7:5], WRDATA[3:2], WRDATA[0]};
end

// ADUL register write
always  @(negedge PRESETZ or posedge PCLKRW) begin
        if(!PRESETZ) 
            reg_adul <= 8'hFF;
        else if ( en_adul )
            reg_adul <= WRDATA[15:8];
end

// ADLL register write
always  @(negedge PRESETZ or posedge PCLKRW) begin
        if(!PRESETZ) 
            reg_adll <= 8'h00;
        else if ( en_adll )
            reg_adll <= WRDATA[7:0];
end

// ADS register write
always  @(negedge PRESETZ or posedge PCLKRW) begin
        if(!PRESETZ) 
            {reg_adiss, reg_ads[4:0]} <= 6'b000000;
        else if ( en_ads )
            {reg_adiss, reg_ads[4:0]} <= {WRDATA[15], WRDATA[12:8]};
end

// pre_bg2aden  0.0k added
assign  pre_bg2aden = reg_adiss  | ( reg_adrefp[1] & ~reg_adrefp[0]) ;                // 0.0k added  0.0m modify

// pre_bg2adsel  0.0k added
assign  sel_data    = WRDATA[15] &  WRDATA[8] ;  // 0.0k added
always  @(negedge PRESETZ or posedge PCLKRW) begin
        if(!PRESETZ)
            pre_bg2adsel_r <= 1'b0 ;
        else if ( en_ads )
            pre_bg2adsel_r <= sel_data ;
end

assign	pre_bg2adsel = pre_bg2adsel_r | ( reg_adrefp[1] & ~reg_adrefp[0]) ;		//  0.0m added



// ADTES register write  0.01 added test mode
always  @(negedge PRESETZ or posedge PCLKRW) begin
        if(!PRESETZ) 
            reg_adtes <= 3'b000;
        else if ( en_adtes )
            reg_adtes <= WRDATA[10:8];
end

// register 
assign  adm0  = { adcs, reg_admd, reg_fr, reg_lv, reg_adce } ;
assign  ads   = { reg_adiss, 2'b00, reg_ads } ;
//assign  adm1  = { reg_adtmd, reg_adscm, 4'b0000, reg_adtrs } ;                          // 0.0a deleted
assign  adm1  = { reg_adtmd[1:0], reg_adscm, 3'b000, reg_adtrs } ;                        // 0.0a modified
assign  adm2  = { reg_adrefp, reg_adrefm, 1'b0, reg_adrck, reg_awc, 1'b0, reg_adtyp } ;
assign  adul  = { reg_adul } ;
assign  adll  = { reg_adll } ;
assign  adtes = { 5'b00000, reg_adtes } ;                                                // 0.01 added test mode

endmodule


module QLK0RADAA32V1_RDATA ( 
                             sel_adm0, sel_ads, sel_adm1, sel_adcr, sel_adcrh,
                             sel_adm2, sel_adul, sel_adll, sel_adtes,

                             adm0, ads, adm1, adm2, adul, adll, adtes, ADCR,

                             dout
                             );

// from BUSCTL
input          sel_adm0 ;
input          sel_ads ;
input          sel_adm1 ;
input          sel_adcr ;
input          sel_adcrh ;
input          sel_adm2 ;
input          sel_adul ;
input          sel_adll ;
input          sel_adtes ;  // 0.01 added test mode

// from REGWR
input   [7:0]  adm0 ;
input   [7:0]  ads ;
input   [7:0]  adm1 ;
input   [7:0]  adm2 ;
input   [7:0]  adul ;
input   [7:0]  adll ;
input   [7:0]  adtes ;  // 0.01 added test mode

// from CORE
input   [9:0]  ADCR ;

// to  REGRD
output  [15:0] dout ;  // PRDATA15-0

reg     [15:0] dout ;
wire    [8:0]  sel_reg ;  // 0.01 modified added test mode register

assign  sel_reg = { sel_adtes, sel_adll, sel_adul, sel_adm2, sel_adcrh, sel_adcr, sel_adm1, sel_ads, sel_adm0 } ;

always  @( sel_reg  or adm0 or ads or adm1 or ADCR or adm2 or adul or adll or adtes ) begin
          case ( sel_reg )
            9'b0_0000_0001 : dout = { 8'b00000000, adm0  }     ; // psel1 & 00H
            9'b0_0000_0010 : dout = { ads, 8'b00000000   }     ; // psel1 & 01H
            9'b0_0000_0100 : dout = { 8'b00000000, adm1  }     ; // psel1 & 02H
            9'b0_0000_1000 : dout = { ADCR[9:0], 6'b000000 } ;   // psel1 & 06H
            9'b0_0001_0000 : dout = { ADCR[9:2], 8'b00000000 } ; // psel1 & 07H
            9'b0_0010_0000 : dout = { 8'b00000000, adm2 }      ; // psel2 & 00H
            9'b0_0100_0000 : dout = { adul, 8'b00000000 }      ; // psel2 & 01H
            9'b0_1000_0000 : dout = { 8'b00000000, adll }      ; // psel2 & 02H
            9'b1_0000_0000 : dout = { adtes, 8'b00000000 }     ; // psel2 & 03H   // 0.01 added test mode
            9'b0_0000_0000 : dout = 16'b0000000000000000 ;       // 0.06 added
            default        : dout = 16'bxxxxxxxxxxxxxxxx ;       // 0.06 added
          endcase
end

endmodule


module QLK0RADAA32V1_REGRD ( 
                             apb_re,
                             dout,

                             PRDATA15, PRDATA14, PRDATA13, PRDATA12,
                             PRDATA11, PRDATA10, PRDATA9,  PRDATA8,
                             PRDATA7,  PRDATA6,  PRDATA5,  PRDATA4,
                             PRDATA3,  PRDATA2,  PRDATA1,  PRDATA0

                             );

// from BUSCTL
input          apb_re ;

// from RDATA
input   [15:0] dout ;

// to  APB
output         PRDATA15 ;
output         PRDATA14 ;
output         PRDATA13 ;
output         PRDATA12 ;
output         PRDATA11 ;
output         PRDATA10 ;
output         PRDATA9  ;
output         PRDATA8  ;
output         PRDATA7  ;
output         PRDATA6  ;
output         PRDATA5  ;
output         PRDATA4  ;
output         PRDATA3  ;
output         PRDATA2  ;
output         PRDATA1  ;
output         PRDATA0  ;

wire    [15:0] RDATA ;   // 0.02 modified

assign  RDATA = ( apb_re ) ? dout : 16'b0 ;

assign  PRDATA15 = RDATA[15] ;
assign  PRDATA14 = RDATA[14] ;
assign  PRDATA13 = RDATA[13] ;
assign  PRDATA12 = RDATA[12] ;
assign  PRDATA11 = RDATA[11] ;
assign  PRDATA10 = RDATA[10] ;
assign  PRDATA9  = RDATA[9]  ;
assign  PRDATA8  = RDATA[8]  ;
assign  PRDATA7  = RDATA[7]  ;
assign  PRDATA6  = RDATA[6]  ;
assign  PRDATA5  = RDATA[5]  ;
assign  PRDATA4  = RDATA[4]  ;
assign  PRDATA3  = RDATA[3]  ;
assign  PRDATA2  = RDATA[2]  ;
assign  PRDATA1  = RDATA[1]  ;
assign  PRDATA0  = RDATA[0]  ;


endmodule


module QLK0RADAA32V1_CORE   ( 
                              SCANMODE, SCANCLK,
                              PCLK, PRESETZ, PWDATA15, PWDATA7, PWDATA2, PWDATA0,

                              TTRG0, TTRG1, TTRG2, TTRG3,
                              EOCB, SAR,

                              apb_we1, en_adm0, en_ads,
                              en_adm2,

                              reg_adce,
                              reg_admd, reg_fr, reg_lv,
                              reg_adiss, reg_ads, reg_adtmd, reg_adscm, reg_adtrs,
                              reg_adrck, reg_awc, reg_adtyp,
                              reg_adul, reg_adll,
                              reg_adrefp, reg_adrefm, reg_adtes,

                              ADCLK, ADPDB, ADBIONB, ADS1, ADOFC, ADCMP, ADCPON,
//                            ADCHSEL, BG2ADEN, BG2ADSEL,
                              ADCHSEL,
                              ADVSELMOD, ADGSELMOD, ADTESMOD0, ADTESMOD1, ADTESMOD2,

                              adcs, ADCR, reqpclk, intad
                              );

// from MODE CTL
input          SCANMODE ;

// from CSC
input          PCLK, PRESETZ, SCANCLK ;   // v0.0h added

// from APBIF
input          PWDATA15 ;
input          PWDATA7 ;
input          PWDATA2 ;    // 0.0b added
input          PWDATA0 ;

// from Timer
input          TTRG0 ;
input          TTRG1 ;
input          TTRG2 ;
input          TTRG3 ;

// from Hard Macro(H/M)
input          EOCB ;
input   [9:0]  SAR ;

// from APBIF
input          apb_we1, en_adm0 ;
input          en_ads ;   // 0.02 added for dis charge
input          en_adm2 ;  // 0.0b added

input          reg_admd ;
input   [2:0]  reg_fr ;
input   [1:0]  reg_lv ;
input          reg_adiss ;
input   [4:0]  reg_ads ;
//input          reg_adtmd ; // 0.0a deleted
input   [1:0]  reg_adtmd ;   // 0.0a modified
input          reg_adscm ;
input   [1:0]  reg_adtrs ;
input          reg_adrck ;
input          reg_awc ;
input          reg_adtyp ;
input   [7:0]  reg_adul ;
input   [7:0]  reg_adll ;
input   [1:0]  reg_adrefp ;  // 0.03 added for ICE
input          reg_adrefm ;  // 0.03 added for ICE
input   [2:0]  reg_adtes ;
input          reg_adce ;    // 0.04 added

// to   BYPASS
output         ADCLK ;
output         ADPDB ;
output         ADBIONB ;
output         ADS1 ;
output         ADOFC ;
output         ADCMP ;
output         ADCPON ;
output  [4:0]  ADCHSEL ;    // 0.01 modified
//output         BG2ADEN ;    // 0.01 added for TEMP. sensor  // 0.0k deleted
//output         BG2ADSEL ;   // 0.01 added for TEMP. sensor  // 0.0k deleted
//output         dis ;        // 0.02 added for dis charge
                              
output  [1:0]  ADVSELMOD ;  // 0.03 added for ICE
output         ADGSELMOD ;  // 0.03 added for ICE
output         ADTESMOD0 ;  // 0.03 added for ICE
output         ADTESMOD1 ;  // 0.03 added for ICE
output         ADTESMOD2 ;  // 0.03 added for ICE

// to   APBIF
output        adcs ;
output  [9:0] ADCR ;

// to   CSC 
output         reqpclk ;

// to   INT
output         intad ;

//wire    [4:0]  adchsel ;
wire    [4:0]  adchsel_o ;
wire    [7:0]  cmp_sar ;

wire           adclk_rise ;
wire           adclk_fall ;
wire           comp_mask ;
wire           hard_trg ;
wire           scan_end ;
wire           clr_wup ;
wire           CH_init ;
wire           CH_up ;
wire           adcs ;
wire           wup_trg ;
wire           clr_adcs ;   // 0.09a added

wire    [1:0]  reg_adrefp ;  // 0.03 added for ICE
wire           reg_adrefm ;  // 0.03 added for ICE
wire    [2:0]  reg_adtes ;   // 0.03 added for ICE

wire           reg_adtes_2b ;
wire           dis ;         // 0.03 added for ICE
//wire           chsel_0b ;    // 0.07 deleted <- 0.06 added 
//wire           pre_adchsel_0b ;    // 0.07 added 
//wire           adchsel_0b ;    // 0.0i added  // 0.0k deleted

//assign  ADCHSEL = { reg_adiss, adchsel[4:0] };
assign  ADCHSEL = adchsel_o[4:0] ;     // 0.01 modified 
assign  cmp_sar = SAR[9:2] ;
assign  reg_adtes_2b = reg_adtes[2] ;  // 0.03 added for ICE 
//assign  adchsel_0b = reg_ads[0] ;  // 0.0i added  // 0.0k deleted

wire    [1:0]  ADVSELMOD ;  // 0.03 added for ICE
wire           ADGSELMOD ;  // 0.03 added for ICE
wire           ADTESMOD0 ;  // 0.03 added for ICE
wire           ADTESMOD1 ;  // 0.03 added for ICE
wire           ADTESMOD2 ;  // 0.03 added for ICE
wire           ads_wr_f ;   // 0.06 added

wire           req_rst_sig ;    // 0.0k added
wire           reqpclk_async ;  // 0.0k added
wire           trgsync_1 ;      // 0.0k added

assign  ADVSELMOD = ( reg_adrefp[1] & reg_adrefp[0] ) ? 2'b00 : reg_adrefp ; // 0.03 added for ICE
assign  ADGSELMOD  = reg_adrefm ;                                           // 0.03 added for ICE
assign  ADTESMOD0  = reg_adtes[0] ;                                         // 0.03 added for ICE
assign  ADTESMOD1  = reg_adtes[1] | dis ;                                   // 0.03 added for ICE
assign  ADTESMOD2  = reg_adtes[2] ;                                         // 0.03 added for ICE

QLK0RADAA32V1_FSM     fsm     (
                                .PCLK(PCLK), .PRESETZ(PRESETZ), .PWDATA15(PWDATA15), .PWDATA7(PWDATA7), .PWDATA0(PWDATA0),
                                .PWDATA2(PWDATA2),
                                .reg_adtmd(reg_adtmd),
                                .reg_admd(reg_admd),
                                .reg_adscm(reg_adscm), .reg_lv(reg_lv), .reg_adtyp(reg_adtyp),
                                .reg_adiss(reg_adiss), .reg_adtes_2b(reg_adtes_2b),
                                .apb_we1(apb_we1), .en_adm0(en_adm0), .en_ads(en_ads),
                                .en_adm2(en_adm2),

                                .EOCB(EOCB), .SAR(SAR), .adclk_rise(adclk_rise), .adclk_fall(adclk_fall), .comp_mask(comp_mask),
//                              .hard_trg(hard_trg), .scan_end(scan_end), .adchsel_0b(adchsel_0b),
                                .hard_trg(hard_trg), .scan_end(scan_end),
//                              .reqpclk(reqpclk),
                                .req_rst_sig(req_rst_sig),

                                .ADCLK(ADCLK), .ADPDB(ADPDB), .ADBIONB(ADBIONB), .ADS1(ADS1), .ADOFC(ADOFC),
                                .ADCMP(ADCMP), .ADCPON(ADCPON),
//                              .BG2ADEN(BG2ADEN), .BG2ADSEL(BG2ADSEL),
                                .intad(intad), .clr_wup(clr_wup), .CH_init(CH_init), .CH_up(CH_up), .adcs(adcs),
                                .clr_adcs(clr_adcs),
                                .dis(dis), .ads_wr_f(ads_wr_f), .ADCR(ADCR)
                              );

QLK0RADAA32V1_CH_SCAN ch_scan (
                                .PCLK(PCLK), .PRESETZ(PRESETZ), .reg_admd(reg_admd), .reg_ads(reg_ads), .CH_init(CH_init), .CH_up(CH_up), 
                                .reg_adiss(reg_adiss), .ads_wr_f(ads_wr_f),
                                .adchsel(adchsel_o), .scan_end(scan_end)
                              );

QLK0RADAA32V1_CMP     cmp     (
                                .cmp_sar(cmp_sar), .reg_adul(reg_adul), .reg_adll(reg_adll), .reg_adrck(reg_adrck), 
                                .comp_mask(comp_mask)
                              );

QLK0RADAA32V1_CLK_GEN clk_gen (
                                .PCLK(PCLK), .PRESETZ(PRESETZ), .reg_fr(reg_fr),
                                .ADPDB(ADPDB),
                                .adclk_fall(adclk_fall), .adclk_rise(adclk_rise)
                              );

QLK0RADAA32V1_WUP     wup     (
                                .SCANMODE(SCANMODE), .SCANCLK(SCANCLK),
                                .PCLK(PCLK), .PRESETZ(PRESETZ), 
                                .reg_awc(reg_awc), .wup_trg(wup_trg), .clr_wup(clr_wup),
                                .reg_adce(reg_adce), .adcs(adcs), .clr_adcs(clr_adcs),
                                .trgsync_1(trgsync_1),
                                .reqpclk(reqpclk), .reqpclk_async(reqpclk_async), .req_rst_sig(req_rst_sig)
                              );

QLK0RADAA32V1_SYNC    sync    (
                                .PCLK(PCLK), .PRESETZ(PRESETZ), 
                                .TTRG0(TTRG0), .TTRG1(TTRG1), .TTRG2(TTRG2), .TTRG3(TTRG3), 
//                              .ADPDB(ADPDB), 
                                .reg_adce(reg_adce),
//                              .reg_adtrs(reg_adtrs), .reqpclk(reqpclk), .reg_awc(reg_awc),
                                .reg_adtrs(reg_adtrs), .reqpclk_async(reqpclk_async), .reg_awc(reg_awc),
                                .wup_trg(wup_trg), .hard_trg(hard_trg), .trgsync_1(trgsync_1)
                              );


endmodule


module QLK0RADAA32V1_FSM ( 
                           PCLK, PRESETZ, PWDATA15, PWDATA7, PWDATA2, PWDATA0,

                           reg_adtmd, reg_adscm, reg_lv, reg_adtyp,
                           reg_admd,
                           reg_adiss, reg_adtes_2b,
                           apb_we1, en_adm0, en_ads,
                           en_adm2,

                           EOCB, SAR, adclk_rise, adclk_fall, comp_mask,
//                         hard_trg, scan_end, adchsel_0b,
                           hard_trg, scan_end,
//                         reqpclk,
//                         reqpclk_d1,
                           req_rst_sig,

                           ADCLK, ADPDB, ADBIONB, ADS1, ADOFC, ADCMP, ADCPON,
//                         BG2ADEN, BG2ADSEL,

                           intad, clr_wup, CH_init, CH_up, adcs,
                           clr_adcs,
                           dis, ads_wr_f,

                           ADCR
                           );

input          PCLK, PRESETZ ;
//input          reg_adtmd, reg_adscm, reg_adtyp ;
input          reg_adscm, reg_adtyp ;  // 0.0a modified
input          reg_admd ;              // 0.0b added
input   [1:0]  reg_adtmd ;             // 0.0a added
input   [1:0]  reg_lv ;
input          reg_adiss ;     // 0.01 added for TEMP. sensor
input          reg_adtes_2b ;  // 0.02 added for 7bit TEST MODE
input          apb_we1, en_adm0 ;
input          en_ads ;        // 0.02 added for dis charge
input          adclk_rise, adclk_fall, comp_mask, hard_trg, scan_end ;
//input          chsel_0b ;      // 0.07 deleted <- 0.06 added
//input          pre_adchsel_0b; // 0.07 added
//input          adchsel_0b ;      // 0.0i added  // 0.0k deleted
//input          reqpclk ;       // 0.0b added
//input          reqpclk_d1 ;     // 0.0k added
input          req_rst_sig ;    // 0.0k added
input          en_adm2 ;       // 0.0b added

input          EOCB ;
input   [9:0]  SAR ;
input          PWDATA15 ;
input          PWDATA7 ;
input          PWDATA2 ;  // 0.0b added
input          PWDATA0 ;

output         ADCLK, ADPDB, ADBIONB, ADS1, ADOFC, ADCMP, ADCPON ;
//output         BG2ADEN ;       // 0.01 added for TEMP. sensor
//output         BG2ADSEL ;      // 0.01 added for TEMP. sensor

output         intad, clr_wup, CH_init, CH_up, adcs ;
output         clr_adcs ; // 0.09a added
output         dis ;           // 0.02 added for dis charge
output         ads_wr_f ;      // 0.06 added
output  [9:0]  ADCR ;

reg            intad ;
reg            clr_wup ;
wire           CH_init ;       // 0.06 modified
wire           CH_up ;         // 0.06 modified
reg            adcs ;

reg            ADCLK ;
reg            hard_adpdb ;
wire           ADPDB ;
reg            ADBIONB ;
reg            ADS1 ;
reg            pre_ADOFC ;
wire           ADOFC ;
reg            ADCMP ;

reg            pre_dis ;       // 0.02 added for dis chage
reg            dis ;           // 0.02 added for dis chage

//wire         pre_bg2aden ;   // 0.02 modified for TEMP. sensor // 0.0i deleted
//wire           pre_bg2adsel ;// 0.02 modified for TEMP. sensor // 0.0k deleted
//reg            BG2ADEN ;     // 0.02 modified for TEMP. sensor // 0.0i deleted
//reg            BG2ADSEL ;    // 0.02 modified for TEMP. sensor // 0.0k deleted
//wire           BG2ADEN ;     // 0.0i modified for TEMP. sensor // 0.0k deleted

reg            ads_wr_f ;      // 0.06 added
reg            t_int_mask ;    // 0.06 added
reg            int_dt_f ;      // 0.0b added

reg            trig_detect ;

reg     [2:0]  state ;
reg     [9:0]  ADCR ;

wire           we_adce ; 
wire           we_adcs ; 
wire           clr_adce ; 
wire           clr_adcs ; 
wire           clr_adiss ;     // 0.02 added for dis charge 
wire           clr_awc ;       // 0.0b added

wire           soft ; 
wire           oneshot ; 
wire           nowait ;        // 0.0a added
wire           scan ;          // 0.0b added

wire           conv_trg ; 
wire           conv_end ; 

wire           eq_width ; 
//reg     [3:0]  eq_count ;      //counter for Stabilization or sampling
reg     [2:0]  eq_count ;      //counter for Stabilization or sampling modified 0.02

wire           idle_state ;                                              // 0.03 added
wire           bion_state ;                                              // 0.03 added
wire           stab_state ;
wire           smp_state ;
wire           smp_end_state ;                                           // 0.06 added
wire           cmp_state ;                                               // 0.06 added

//--------------------------------------
//  parameter for state-machine
//--------------------------------------
parameter      STOP    = 3'b000 ;
parameter      IDLE    = 3'b001 ;
parameter      STAB    = 3'b010 ;
parameter      BION    = 3'b011 ;
parameter      SMP     = 3'b100 ;
parameter      SMP_END = 3'b101 ;
parameter      CMP     = 3'b110 ;

//--------------------------------------
//  internal signal             
//--------------------------------------
assign  we_adce   = en_adm0 & PWDATA0 ;              // adce=1
assign  we_adcs   = en_adm0 & PWDATA0 & PWDATA7 ;    // adce=1 & adcs=1

assign  clr_adce  = en_adm0 & ~PWDATA0 ;             // adce=0
assign  clr_adcs  = en_adm0 & PWDATA0 & ~PWDATA7 ;   // adce=1 & adcs=0
assign  clr_adiss = en_ads & ~PWDATA15 ;             // adiss=0
assign  clr_awc   = en_adm2 & ~PWDATA2 ;             // awc=0  0.0b added

//assign  soft      = ~reg_adtmd ;   // 0.0a deleted
assign  soft      = ~reg_adtmd[1] ;  // 0.0a modified
assign  oneshot   = reg_adscm ;
assign  nowait    = ~reg_adtmd[0] ;  // 0.0a added
assign  scan      = reg_admd ;       // 0.0b added

//assign  conv_trg  = ( clr_adce | clr_adcs ) ? 1'b0 : ( ( soft & we_adcs ) | ( ~soft & hard_trg ) | ( state[2] & apb_we1 ) ) ;  // conversion trigger select  0.03 modified
//assign  conv_trg  = ( clr_adce | clr_adcs ) ? 1'b0 : ( ( soft & we_adcs ) | ( ~soft & hard_trg ) | ( ( bion_state | state[2] ) & apb_we1 ) ) ;  // conversion trigger select  0.04 modified
assign  conv_trg  = ( clr_adce | clr_adcs ) ? 1'b0 : ( ( soft & we_adcs ) | ( ~soft & nowait & adcs & hard_trg ) | ( ~soft & ~nowait & hard_trg ) | ( ( bion_state | state[2] ) & apb_we1 ) ) ;  // conversion trigger select  0.0e modified

assign  conv_end  = ~EOCB | ( reg_adtyp & SAR[1] ) | ( reg_adtes_2b & SAR[2] ) ; // conversion end  10bit:~EOCB, 8bit:SAR[1], 7bit:SAR[2]

//--------------------------------------
//  state machine ( generated hard_adpdb and adcs signal )
//--------------------------------------
always  @( posedge PCLK or negedge PRESETZ ) begin
        if ( !PRESETZ ) begin
          state     <= STOP ;
          hard_adpdb <= 1'b0 ;
          adcs       <= 1'b0 ;
        end
        else if ( apb_we1 | adclk_fall | hard_trg ) begin            // 0.03 added hard_trg
            if ( clr_adce ) begin
                        state      <= STOP ;
                        hard_adpdb <= 1'b0 ;
                        adcs       <= 1'b0 ;
            end
            else begin
                case ( state )
                    STOP        : if ( soft & we_adce ) begin
                                                state      <= STAB ; // soft
                                                hard_adpdb <= 1'b1 ;
                                  end
                                  else if ( ~soft & nowait & we_adce ) begin
                                                state      <= STAB ; // hard/nowait 0.0a added
                                                hard_adpdb <= 1'b1 ;
                                  end
//                                else if ( ~soft & we_adce )                                   state <= IDLE    ; // hard
                                  else if ( ~soft & ~nowait & we_adce )                         state <= IDLE    ; // hard/wait   0.0a modified
//                                  else if ( soft & we_adcs ) begin   // 0.0j deleted for redundancy 
//                                                state      <= BION ; // soft adce=adcs=1 write 
//                                                hard_adpdb <= 1'b1 ;
//                                                adcs       <= 1'b1 ;
//                                  end
                                  else                         					state <= STOP    ;

                    IDLE        : if ( conv_trg ) begin
	               				state      <= STAB ; // hard only
	  					hard_adpdb <= 1'b1 ;
	  					adcs       <= 1'b1 ;
                                  end
                                  else                          				state <= IDLE    ;

//                  STAB        : if ( ~soft & clr_adcs ) begin
                    STAB        : if ( ~soft & ~nowait & clr_adcs ) begin          // 0.0a modified
                                                state      <= IDLE ; // hard/wait   
                                                hard_adpdb <= 1'b0 ;
                                                adcs       <= 1'b0 ;
                                  end
                                  else if ( ~soft & nowait & clr_adcs ) begin
                                                state      <= STAB ; // hard/nowait   0.0a added
                                                adcs       <= 1'b0 ;
				  end
                                  else if ( ~soft & nowait & we_adcs ) begin
                                                state      <= STAB ; // hard/nowait   0.0a added
                                                adcs       <= 1'b1 ;
				  end
//                                else if ( ~soft & eq_width & adclk_fall ) begin
                                  else if ( ~soft & ~nowait & eq_width & adclk_fall ) begin  // hard/wait   0.0a modified
                        			state      <= BION ; // hard
	                                        adcs       <= 1'b1 ;
                                  end
//                                else if ( ~soft & nowait & adcs & ( conv_trg | trig_detect ) & adclk_fall ) begin   // hard/nowait   0.0a added
                                  else if ( ~soft & nowait & ( conv_trg | trig_detect ) & adclk_fall ) begin          // hard/nowait   0.0e modified
                        			state      <= BION ; // hard
                                  end
		    		  else if ( soft & ( conv_trg | trig_detect ) & adclk_fall ) begin
                                                state      <= BION ; // soft only
	                                        adcs       <= 1'b1 ;
                                  end
//		    		  else if ( soft & ( we_adcs | trig_detect ) & adclk_fall ) begin       // 0.0j deleted for redundancy
//                                                state      <= BION ;    // soft only prohibit setting
//	                                        adcs       <= 1'b1 ;
//                                  end
                                  else                                                  	state <= STAB    ;

		    BION	: if ( soft & clr_adcs ) begin
 						state      <= STAB ;    // soft
	  					adcs       <= 1'b0 ;
				  end
//                                else if ( ~soft & clr_adcs ) begin
                                  else if ( ~soft & nowait & clr_adcs ) begin
                                                state      <= STAB ;    // hard/nowait  0.0a added
                                                adcs       <= 1'b0 ;
                                  end
		                  else if ( ~soft & ~nowait & clr_adcs ) begin
						state      <= IDLE ;    // hard/  wait  0.0a modified
	  					hard_adpdb <= 1'b0 ;
	  					adcs       <= 1'b0 ;
                                  end
                                  else if ( ( conv_trg | trig_detect ) & adclk_fall )           state <= BION    ;
                                  else if ( adclk_fall )                                        state <= SMP     ;
                                  else                                                          state <= BION    ;

		    SMP 	: if ( soft & clr_adcs ) begin
                                                state      <= STAB ;    // soft
                                                adcs       <= 1'b0 ;    // 0.03 added
				  end
//                                else if ( ~soft & clr_adcs ) begin
                                  else if ( ~soft & nowait & clr_adcs ) begin
                                                state      <= STAB ;    // hard/nowait  0.0a added
                                                adcs       <= 1'b0 ;
                                  end
                                  else if ( ~soft & ~nowait & clr_adcs ) begin
                                                state      <= IDLE ;    // hard/  wait  0.0a modified
                                                hard_adpdb <= 1'b0 ;
                                                adcs       <= 1'b0 ;
                                  end
                                  else if ( ( conv_trg | trig_detect ) & adclk_fall )           state <= BION    ;
                                  else if ( eq_width & adclk_fall )                             state <= SMP_END ;
                                  else                                                 	        state <= SMP     ;

		    SMP_END 	: if ( soft & clr_adcs ) begin
                                                state      <= STAB ;    // soft
                                                adcs       <= 1'b0 ;    // 0.03 added
                                  end
//                                else if ( ~soft & clr_adcs ) begin
                                  else if ( ~soft & nowait & clr_adcs ) begin
                                                state      <= STAB ;    // hard/nowait  0.0a added
                                                adcs       <= 1'b0 ;
                                  end
		                  else if ( ~soft & ~nowait & clr_adcs ) begin
						state      <= IDLE ;    // hard/  wait  0.0a modified
	  					hard_adpdb <= 1'b0 ;
	  					adcs       <= 1'b0 ;
				  end
		                  else if ( ( conv_trg | trig_detect ) & adclk_fall ) 		state <= BION    ;
		                  else if ( adclk_fall )					state <= CMP     ;
                                  else                                                 	 	state <= SMP_END ;

		    CMP     	: if ( soft & clr_adcs ) begin
                                                state <= STAB    ;      // soft adcs=0
	  					adcs  <= 1'b0 ;         // 0.03 added
				  end
//                                else if ( ~soft & clr_adcs ) begin
                                  else if ( ~soft & nowait & clr_adcs ) begin
						state      <= STAB ;    // hard/nowait adcs=0  0.0a added
	  					adcs       <= 1'b0 ;
				  end
		                  else if ( ~soft & ~nowait & clr_adcs ) begin
						state      <= IDLE ;    // hard/ wait  adcs=0  0.0a modified
	  					hard_adpdb <= 1'b0 ;
	  					adcs       <= 1'b0 ;
				  end
//                                else if ( ( conv_trg | trig_detect ) & adclk_fall )                           state <= BION    ;
                                  else if ( ( conv_trg | trig_detect ) & adclk_fall & t_int_mask )              state <= BION    ;  // 0.07 added competition only
		                  else if ( soft & oneshot & conv_end & adclk_fall & scan_end )	begin                // # 1 #
                                                state      <= STAB ;    // soft oneshot end
	  					adcs       <= 1'b0 ;
                                  end
//                                else if ( ~soft & oneshot & conv_end & adclk_fall & scan_end ) begin               // # 2 #
		                  else if ( ~soft & nowait & oneshot & conv_end & adclk_fall & scan_end ) begin               // # 2-1 #
						state      <= STAB ;    // hard/nowait oneshot end  0.0a added
				  end
		                  else if ( ~soft & ~nowait & oneshot & conv_end & adclk_fall & scan_end ) begin               // # 2-2 #
						state      <= IDLE ;    // hard/  wait oneshot end  0.0a modified
	  					hard_adpdb <= 1'b0 ;
	  					adcs       <= 1'b0 ;
				  end
                                  else if ( ( conv_trg | trig_detect ) & adclk_fall )                           state <= BION    ;  // 0.07 added normal restart
		                  else if ( oneshot & conv_end & adclk_fall & ~scan_end ) begin                      // 0.06 added # 3 #
                                                state      <= BION ;    // soft/hard oneshot scan no end
                                  end
		                  else if ( ~oneshot & conv_end & adclk_fall )	 		state <= BION    ;   // soft/hard continuous  // # 4 #
                                  else                                                 	 	state <= CMP     ;
		    default 	: state <= STOP ;

                endcase // case    end
            end         // else    end
        end             // else if end

end                     // always  end

//--------------------------------------
// ADBIONB/ADS1/pre_ADOFC/ADCMP signal
//--------------------------------------
always  @( posedge PCLK or negedge PRESETZ ) begin
        if ( !PRESETZ ) begin
            ADBIONB   <= 1'b1 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
        else if ( clr_adce | clr_adcs ) begin
            ADBIONB   <= 1'b1 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
        else if ( soft & stab_state & (( conv_trg | trig_detect ) & adclk_fall )) begin  // 0.06 modified soft ## ##   STAB start
            ADBIONB   <= 1'b0 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
//      else if ( ~soft & stab_state & eq_width & adclk_fall ) begin                    // 0.03 added hard first conv. ## STAB => BION hard start
        else if ( ~soft & nowait & adcs & stab_state & (( conv_trg | trig_detect ) & adclk_fall ) ) begin   // 0.0a added hard/nowait  ## STAB => BION hard start
            ADBIONB   <= 1'b0 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
        else if ( ~soft & ~nowait & stab_state & eq_width & adclk_fall ) begin          // 0.0a modified hard/wait first conv. ## STAB => BION hard start
            ADBIONB   <= 1'b0 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
        else if ( bion_state & (( conv_trg | trig_detect ) & adclk_fall )) begin        // 0.06 modified hard/soft ## ## BION start/restart
            ADBIONB   <= 1'b0 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
//      else if ( soft & state[2] & (( conv_trg | trig_detect ) & adclk_fall )) begin   // 0.06 modifeid soft 
//      else if ( state[2] & (( conv_trg | trig_detect ) & adclk_fall )) begin          // 0.06 modifeid soft/hard  SMP/SMP_END/CMP restart
//      else if ( state[2] & (( conv_trg | trig_detect ) & adclk_fall & t_int_mask )) begin  // 0.06 modifeid soft/hard  SMP/SMP_END/CMP restart
//      else if ( ( smp_state | smp_end_state ) & (( conv_trg | trig_detect ) & adclk_fall )) begin  // 0.07 modifeid soft/hard  SMP/SMP_END restart
//      else if ( ( ( state == SMP ) | ( state == SMP_END ) ) & (( conv_trg | trig_detect ) & adclk_fall )) begin  // 0.07 modifeid soft/hard  SMP/SMP_END restart
//      else if ( ( smp_state | smp_end_state ) & (( conv_trg | trig_detect ) & adclk_fall & ~t_int_mask )) begin  // 0.07 modifeid soft/hard  SMP/SMP_END restart
//      else if ( ( smp_state | smp_end_state ) & (( conv_trg | trig_detect ) & adclk_fall )) begin  // 0.09b modifeid soft/hard  SMP/SMP_END restart
        else if ( ( smp_state | smp_end_state ) & (( conv_trg | trig_detect ) & adclk_fall & ~t_int_mask )) begin  // 0.0c modifeid soft/hard  SMP/SMP_END restart
            ADBIONB   <= 1'b0 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
//  0.0f position change
//      else if ( cmp_state & ( conv_trg | trig_detect ) & adclk_fall ) begin      // 0.07 added soft scan/oneshot CMP => BION restart ##
//      else if ( cmp_state & ( conv_trg | trig_detect ) & adclk_fall & t_int_mask ) begin      // 0.09b added soft/hard  CMP => BION restart ##
//      else if ( cmp_state & ( conv_trg | trig_detect ) & adclk_fall ) begin      // 0.0c modified soft scan/oneshot CMP => BION restart ##
        else if ( cmp_state & ( conv_trg | trig_detect ) & adclk_fall & t_int_mask ) begin      // 0.0f modified soft scan/oneshot CMP => BION restart ##
            ADBIONB   <= 1'b0 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
//  0.0f position change
//      else if ( cmp_state & soft & oneshot & conv_end & adclk_fall & scan_end ) begin  // 0.0c added soft oneshot CMP => STAB 
        else if ( cmp_state & oneshot & conv_end & adclk_fall & scan_end ) begin         // 0.0f modified soft/hard oneshot CMP => STAB 
            ADBIONB   <= 1'b1 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
        else if ( cmp_state & ( conv_trg | trig_detect ) & adclk_fall ) begin            // 0.0f added soft/hard restart CMP => BION restart ##
            ADBIONB   <= 1'b0 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
//      else if ( soft & oneshot & conv_end & adclk_fall & ~scan_end ) begin            // 0.06 added soft scan/oneshot/noend CMP => BION ##
//      else if ( ( state == CMP ) & oneshot & conv_end & adclk_fall & ~scan_end ) begin  // 0.06 added soft scan/oneshot/noend CMP => BION ##
        else if ( cmp_state & oneshot & conv_end & adclk_fall & ~scan_end ) begin       // 0.07 modified soft scan/oneshot/noend CMP => BION ##
            ADBIONB   <= 1'b0 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
//      else if ( ~soft & oneshot & conv_end & adclk_fall & ~scan_end ) begin           // 0.06 added hard scan/oneshot/noend CMP => BION ##
//          ADBIONB   <= 1'b0 ;
//          ADS1      <= 1'b0 ;
//          pre_ADOFC <= 1'b0 ;
//          ADCMP     <= 1'b0 ;
//      end
//      else if ( ( state == CMP ) && ~oneshot & conv_end & adclk_fall ) begin          // 0.06 added soft/hard continuous
        else if ( cmp_state && ~oneshot & conv_end & adclk_fall ) begin                 // 0.07 modified soft/hard continuous
            ADBIONB   <= 1'b0 ;
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ;
        end
        else if ( bion_state & adclk_rise ) begin                                       // 0.07 modified
            ADBIONB   <= 1'b0 ;
            ADS1      <= 1'b1 ;
            pre_ADOFC <= 1'b1 ;
            ADCMP     <= 1'b0 ; // 0.0g added
        end
//      else if ( cmp_state & adclk_rise ) begin                                        // 0.07 modified ( before change  )
//          ADCMP     <= 1'b1 ;
//          ADBIONB   <= 1'b1 ;
//      end
        else if ( smp_end_state &  adclk_rise ) begin                                   // 0.07 modified
            ADBIONB   <= 1'b0 ; // 0.0g added
            ADS1      <= 1'b1 ; // 0.0g added
            pre_ADOFC <= 1'b0 ;
            ADCMP     <= 1'b0 ; // 0.0g added
        end
        else if ( smp_end_state & adclk_fall ) begin                                    // 0.07 modified
//          ADBIONB   <= 1'b1 ;
            ADBIONB   <= 1'b0 ;                                                         // 0.0d modified
            ADS1      <= 1'b0 ;
            pre_ADOFC <= 1'b0 ; // 0.0g added
            ADCMP     <= 1'b0 ; // 0.0g added
        end
        else if ( cmp_state & adclk_rise ) begin                                        // 0.0d modified ( position change )
            ADCMP     <= 1'b1 ;
            ADBIONB   <= 1'b1 ;
            ADS1      <= 1'b0 ; // 0.0g added
            pre_ADOFC <= 1'b0 ; // 0.0g added
        end
//        else if ( cmp_state & (conv_end & adclk_fall) ) begin                           // 0.07 modified
//            ADCMP     <= 1'b0 ;                                                         // 0.0j deleted for redundancy
//            ADBIONB   <= oneshot ;
//            ADS1      <= 1'b0 ; // 0.0g added
//            pre_ADOFC <= 1'b0 ; // 0.0g added
//        end
end

assign  ADOFC = pre_ADOFC ;

//--------------------------------------
// pre_dis/dis signal 0.02 added for dis charge
//--------------------------------------
always  @( posedge PCLK or negedge PRESETZ ) begin
        if ( !PRESETZ )                                                      pre_dis   <= 1'b0 ;
	else if ( clr_adiss )                                                pre_dis   <= 1'b0 ;                   // soft & hard clr
	else if ( en_ads )                                                   pre_dis   <= ~reg_adiss & PWDATA15 ;  // soft & hard set
	else if ( soft & ( conv_trg | trig_detect ) & adclk_fall )           pre_dis   <= 1'b0 ;                   // soft only   clr
	else if ( ~soft & eq_width & adclk_fall )                            pre_dis   <= 1'b0 ;                   // hard only   clr
        else                                                                 pre_dis   <= pre_dis ;
end

always  @( posedge PCLK or negedge PRESETZ ) begin
        if ( !PRESETZ )                                                      dis       <= 1'b0 ;
	else if ( clr_adce | clr_adcs | clr_adiss )                          dis       <= 1'b0 ;                   // soft & hard clr
	else if ( soft & ( conv_trg | trig_detect ) & adclk_fall & pre_dis ) dis       <= 1'b1 ;                   // soft set
//	else if ( ~soft & eq_width & adclk_fall & pre_dis )                  dis       <= 1'b1 ;                   // hard set
	else if ( ~soft & adclk_fall & pre_dis )                             dis       <= 1'b1 ;                   // hard set
	else if ( ( state == CMP ) & adclk_rise )                            dis       <= 1'b0 ;                   // soft & hard clr
        else                                                                 dis       <= dis ;
end

////--------------------------------------
// 0.0k deleted BG2ADEN & BG2ADSEL signal from
////--------------------------------------
//// pre_bg2aden/pre_bg2adsel 0.02 modified for TEMP. sensor
//// BG2ADEN/BG2ADSEL signal   0.0i modified
////--------------------------------------
////assign  pre_bg2aden  = reg_adiss ;
//assign  BG2ADEN  = reg_adiss ;
//
////assign  pre_bg2adsel = reg_adiss & reg_ads_0b ;
////assign  pre_bg2adsel = reg_adiss & chsel_0b ;     // 0.06 modified 
////assign  pre_bg2adsel = reg_adiss & pre_adchsel_0b ; // 0.07 modified // 0.0i deleted
//assign  pre_bg2adsel = reg_adiss & adchsel_0b ; // 0.0i added
//
////--------------------------------------
//// BG2ADSEL signal   0.02 modified for TEMP. sensor  // 0.0i modified
////--------------------------------------
//always  @( posedge PCLK or negedge PRESETZ ) begin
//        if ( !PRESETZ ) begin
////            BG2ADEN   <= 1'b0 ;
//	    BG2ADSEL  <= 1'b0 ;
//	end
//	else begin
//            BG2ADEN   <= pre_bg2aden  ;
//            BG2ADSEL  <= pre_bg2adsel ;
//        end
//end
////--------------------------------------
// 0.0k deleted BG2ADEN & BG2ADSEL signal to
////--------------------------------------

//--------------------------------------
// CH_init/CH_up
//--------------------------------------
//always  @( posedge PCLK or negedge PRESETZ ) begin
//        if ( !PRESETZ ) begin
//            CH_init   <= 1'b0 ;
//            CH_up     <= 1'b0 ;
//        end
//        else if ( soft & stab_state & (( conv_trg | trig_detect ) & adclk_fall )) begin  // 0.06 added ## soft start 
//            CH_init   <= 1'b1 ;
//        end
//        else if ( ~soft & stab_state & eq_width & adclk_fall ) begin                     // 0.06 added ## hard start 
//            CH_init   <= 1'b1 ;
//        end
//        else if ( bion_state & (( conv_trg | trig_detect ) & adclk_fall )) begin         // 0.06 added ## BION restart 
//            CH_init   <= 1'b1 ;
//        end
//        else if ( state[2] & (( conv_trg | trig_detect ) & adclk_fall )) begin           // 0.06 added ## SMP/SMP_END/CMP restart 
//            CH_init   <= 1'b1 ;
//        end
//        else if ( ( state == CMP ) & (conv_end & adclk_fall) ) begin                     // conv. end
//            CH_init   <= scan_end ;
//            CH_up     <= ~scan_end ;
//        end
//        else if ( CH_init | CH_up ) begin                                                // generated negedge by next pclk posedge
//            CH_init   <= 1'b0 ;
//            CH_up     <= 1'b0 ;
//        end
//end

wire           soft_start_cnd ;
//wire           hard_start_cnd ;      // 0.0a deleted
wire           hard_nowait_start_cnd ; // 0,0a added
wire           hard_wait_start_cnd ;   // 0.0a added
wire           bion_restart_cnd ;
//wire           state2_restart_cnd ;  // 0.07 deleted
wire           smp_restart_cnd ;       // 0.07 added
wire           cmp_restart_cnd ;       // 0.07 added
wire           cmp_restart_cnd2 ;      // 0.07 added
wire           conv_end_cnd ;

assign  soft_start_cnd     = soft & stab_state & ( conv_trg | trig_detect ) & adclk_fall ;               // 0.06 added ## soft start

//assign  hard_start_cnd     = ~soft & stab_state & eq_width & adclk_fall ;                                // 0.06 added ## hard start
assign  hard_nowait_start_cnd   = ~soft & nowait & stab_state & adcs & ( conv_trg | trig_detect ) & adclk_fall ;  // 0.0a added    ## hard/nowait start
assign  hard_wait_start_cnd     = ~soft & ~nowait & stab_state & eq_width & adclk_fall ;                          // 0.0a modified ## hard/  wait start

assign  bion_restart_cnd   = bion_state & ( ( conv_trg | trig_detect ) & adclk_fall ) ;                  // 0.06 added ## BION restart

//assign  state2_restart_cnd = state[2] & ( ( conv_trg | trig_detect ) & adclk_fall ) ;                  // 0.06 added ## SMP/SMP_END/CMP restart
//assign  state2_restart_cnd = state[2] & ( ( conv_trg | trig_detect ) & adclk_fall & t_int_mask ) ;     // 0.06 modified ## SMP/SMP_END/CMP restart
assign  smp_restart_cnd = ( smp_state | smp_end_state ) & ( ( conv_trg | trig_detect ) & adclk_fall ) ;  // 0.07 modified ## SMP/SMP_END restart

assign  cmp_restart_cnd  = cmp_state & ( ( conv_trg | trig_detect ) & adclk_fall ) ;                     // 0.07 added ## CMP restart
assign  cmp_restart_cnd2 = cmp_state & ( ( conv_trg | trig_detect ) & adclk_fall & t_int_mask ) ;        // 0.07 added ## CMP restart

//assign  conv_end_cnd       = ( state == CMP ) & (conv_end & adclk_fall) ;                              // 0.06 added ## conv. end
assign  conv_end_cnd       = cmp_state & (conv_end & adclk_fall) ;                                // 0.07 modified ## conv. end

//assign  CH_init            = soft_start_cnd | hard_start_cnd | bion_restart_cnd | state2_restart_cnd | (conv_end_cnd & scan_end) ; // 0.06 added
//assign  CH_init            = soft_start_cnd | hard_start_cnd | bion_restart_cnd | smp_restart_cnd | cmp_restart_cnd | (conv_end_cnd & scan_end) ; // 0.07 added
//assign  CH_init            = soft_start_cnd | hard_start_cnd | bion_restart_cnd | smp_restart_cnd | cmp_restart_cnd | cmp_restart_cnd2 | (conv_end_cnd & scan_end) ; // 0.07 added
assign  CH_init            = soft_start_cnd | hard_nowait_start_cnd | hard_wait_start_cnd | bion_restart_cnd | smp_restart_cnd | cmp_restart_cnd | cmp_restart_cnd2 | (conv_end_cnd & scan_end) ; // 0.07 added
assign  CH_up              = conv_end_cnd & ~scan_end ;  // 0.06 added

//--------------------------------------
// ads_wr_f  0.06 added for chsel
//--------------------------------------
always  @( posedge PCLK or negedge PRESETZ ) begin
          if ( !PRESETZ )                 ads_wr_f <= 1'b0 ;
          else if ( en_ads & adclk_fall ) ads_wr_f <= 1'b1 ;
          else if ( CH_init | CH_up )     ads_wr_f <= 1'b0 ;
          else                            ads_wr_f <= ads_wr_f ;
end

//--------------------------------------
// ADCLK
//--------------------------------------
always  @( posedge PCLK or negedge PRESETZ ) begin
        if ( !PRESETZ )		ADCLK  <= 1'b0 ;
        else if ( ~ADPDB )	ADCLK  <= 1'b0 ;
        else if ( adclk_rise )	ADCLK  <= 1'b1 ;
        else if ( adclk_fall )	ADCLK  <= 1'b0 ;
        else			ADCLK  <= ADCLK ;
end

//--------------------------------------
// ADPDB
//--------------------------------------

assign	ADPDB = hard_adpdb ;

//--------------------------------------
// ADCPON 0.02 modified
//--------------------------------------

assign	ADCPON = reg_lv[1] ? ADPDB : 1'b0 ;  // 0.02 modified 

//--------------------------------------
// trigger detect signal
//--------------------------------------
always  @( posedge PCLK or negedge PRESETZ ) begin
          if ( !PRESETZ )               trig_detect <= 1'b0 ;
          else if ( adclk_fall )        trig_detect <= 1'b0 ;
          else if ( conv_trg )          trig_detect <= 1'b1 ;
          else                          trig_detect <= trig_detect ;
end

//--------------------------------------
// set_count for sampling time
//--------------------------------------
assign  idle_state     = ( state == IDLE    ) ? 1'b1 : 1'b0 ;                   // 0.03 added
assign  bion_state     = ( state == BION    ) ? 1'b1 : 1'b0 ;                   // 0.03 added
assign  stab_state     = ( state == STAB    ) ? 1'b1 : 1'b0 ;
assign  smp_state      = ( state == SMP     ) ? 1'b1 : 1'b0 ;
assign  smp_end_state  = ( state == SMP_END ) ? 1'b1 : 1'b0 ;                   // 0.06 added
assign  cmp_state      = ( state == CMP     ) ? 1'b1 : 1'b0 ;                   // 0.06 added

wire    [3:0]  set_cond ;

assign  set_cond   = { reg_lv[1], reg_lv[0], idle_state, bion_state } ;  // 0.03 modified

reg     [2:0]  set_count ; //set_count for Stabilization or sampling     // 0.02 modified
always  @( set_cond ) begin
          case ( set_cond )
            4'b0001 : set_count = 3'b101 ; // 7ADCLK Nomarl SMP     ( setting value : 7-2=5ADCLK )  // 0.03 modified
            4'b0010 : set_count = 3'b111 ; // 8ADCLK Normal STAB
            4'b0101 : set_count = 3'b011 ; // 5ADCLK Normal SMP     ( setting value : 5-2=3ADCLK )  // 0.03 modified
            4'b0110 : set_count = 3'b111 ; // 8ADCLK Normal STAB
            4'b1001 : set_count = 3'b101 ; // 7ADCLK Shouatsu SMP   ( setting value : 7-2=5ADCLK )  // 0.03 modified
            4'b1010 : set_count = 3'b001 ; // 2ADCLK Shouatsu STAB
            4'b1101 : set_count = 3'b011 ; // 5ADCLK Shouatsu SMP   ( setting value : 5-2=3ADCLK )  // 0.03 modified
            4'b1110 : set_count = 3'b001 ; // 2ADCLK Shouatsu STAB
            default : set_count = 3'b111 ; // 8ADCLK
          endcase
end

//--------------------------------------
// eq_count  for stabilization or sampling time
//--------------------------------------
always  @( posedge PCLK or negedge PRESETZ ) begin
          if ( !PRESETZ )            
                          eq_count[2:0] <= 3'b111 ;
          else if ( idle_state & hard_trg )                         // stabilization count load for hard only  0.03 modified
                          eq_count[2:0] <= set_count[2:0] ;
          else if ( bion_state & adclk_fall )                       // sampling count load for soft & hard     0.03 added
                          eq_count[2:0] <= set_count[2:0] ;
//        else if ( adclk_fall & ( stab_state | smp_state ) )       // count down                              0.03 added
          else if ( adclk_fall & ( ( ~nowait & stab_state ) | smp_state ) )       // count down                0.0a modified
                          eq_count[2:0] <= eq_count[2:0] - 1'b1 ;
          else                                                      //                                         0.03 added
                          eq_count[2:0] <= eq_count[2:0] ;
end

//--------------------------------------
// eq_width
//--------------------------------------
assign  eq_width = ~( eq_count[2] | eq_count[1] | eq_count[0] ) ;   // 0.02 modified

//--------------------------------------
// t_int_mask 0.06 added
//--------------------------------------
always  @( posedge PCLK or negedge PRESETZ ) begin
        if ( !PRESETZ )                               t_int_mask <= 1'b0 ;
//      else if ( cmp_state & conv_trg & conv_end )   t_int_mask <= 1'b1 ;
        else if ( cmp_state & conv_trg )              t_int_mask <= 1'b1 ;
        else if ( bion_state )                        t_int_mask <= 1'b0 ;
        else                                          t_int_mask <= t_int_mask ;
end

//--------------------------------------
// Wake up/hard/scan/oneshot int detect flag 0.0b added
//--------------------------------------
always  @( posedge PCLK or negedge PRESETZ ) begin
        if ( !PRESETZ )                      int_dt_f <= 1'b0 ;
        else if ( ~soft & scan & oneshot ) begin                 // hard/scan/oneshot
           if      ( clr_adce )              int_dt_f <= 1'b0 ;
           else if ( clr_adcs )              int_dt_f <= 1'b0 ;
           else if ( clr_wup | clr_awc )     int_dt_f <= 1'b0 ;
           else if ( conv_trg )              int_dt_f <= 1'b0 ;
           else if ( ~adcs )                 int_dt_f <= 1'b0 ;
//         else if ( reqpclk & intad )       int_dt_f <= 1'b1 ;
//         else if ( reqpclk_d1 & intad )    int_dt_f <= 1'b1 ;  // 0.0k modified
           else if ( req_rst_sig & intad )   int_dt_f <= 1'b1 ;  // 0.0k modified
           else                              int_dt_f <= int_dt_f ;
        end
        else                                 int_dt_f <= int_dt_f ;
end

//--------------------------------------
// INTAD & ADCR & REQPCLK clear signal
//--------------------------------------
always  @( posedge PCLK or negedge PRESETZ ) begin
          if ( !PRESETZ )  begin
              intad     <= 1'b0 ;
              clr_wup   <= 1'b0 ;
              ADCR[9:0] <= 10'b0000000000 ;                         // 0.03 modified
          end
//        else if ( ( ( state == CMP ) & conv_end & adclk_fall ) | intad | clr_wup ) begin
          else if ( ( ( state == CMP ) & conv_end & adclk_fall & ~t_int_mask ) | intad | clr_wup ) begin     // 0.06 added
            if ( ( state == CMP ) & conv_end  & adclk_fall) begin
                    intad   <= ~comp_mask ;
//                  clr_wup <= comp_mask ;
                    clr_wup <= comp_mask & ~int_dt_f & scan_end ;  // 0.0b added
                if ( ~comp_mask ) begin
                   if ( reg_adtyp ) ADCR[9:0] <= { SAR[9:2], 2'b00 } ;  // 0.04 modified
                   else             ADCR[9:0] <= SAR[9:0] ;             // 0.04 modified
                end
            end
            else begin
                intad     <= 1'b0 ;
                clr_wup   <= 1'b0 ;
                ADCR[9:0] <= ADCR[9:0] ;
            end
          end
end

endmodule


module QLK0RADAA32V1_CH_SCAN ( 
                               PCLK, PRESETZ, reg_admd, reg_ads, CH_init, CH_up, 
                               reg_adiss, ads_wr_f,
                               adchsel, scan_end
                               );

input          PCLK, PRESETZ, CH_init, CH_up ; 
input          reg_admd ; 
input   [4:0]  reg_ads ; 
input          reg_adiss ;     // 0.01 added for TEMP. sensor
input          ads_wr_f ;      // 0.06 added

output         scan_end ;
output  [4:0]  adchsel ;
//output         chsel_0b ;      // 0.07 deleted <- 0.06 added
//output         pre_adchsel_0b ;  // 0.07 added  //0.0i deleted

wire    [3:0]  next_chsel ;
//wire           chsel_0b ;    // 0.07 deleted <- 0.06 added

wire    [4:0]  load_chsel ;    // 0.06 added
wire    [4:0]  pre_adchsel ;   // 0.06 added
//wire           pre_adchsel_0b ;// 0.07 added // 0.0i deleted

reg     [3:0]  chsel ;

always  @( posedge PCLK or negedge PRESETZ ) begin
            if (~PRESETZ)                    chsel <= 4'b0000 ;
            else if (CH_init)                chsel <= reg_ads[3:0] ;
//          else if (ads_wr_f) begin                                        // 0.06 added
////             if (CH_up)                  chsel <= reg_ads + 1'b1 ;      // 0.06 added
//               if ( CH_up & ~t_int_mask )  chsel <= reg_ads + 1'b1 ;      // 0.07 modified
//               if ( CH_up & t_int_mask )   chsel <= next_chsel ;          // 0.07 added
//          end                                                             // 0.06 added
            else if (CH_up)                  chsel <= next_chsel ;
end

//assign  next_chsel = chsel + 1'b1 ;
assign  next_chsel = ads_wr_f ? reg_ads + 1'b1 : chsel + 1'b1 ;  // 0.07 modified

//assign  scan_end   = reg_admd ? ( reg_ads[2] ^ next_chsel[2]) & ( reg_ads[1:0] == next_chsel[1:0] ) : 1'b1 ;
assign  scan_end   = reg_admd ? ads_wr_f ? 1'b0 : ( reg_ads[2] ^ next_chsel[2]) & ( reg_ads[1:0] == next_chsel[1:0] ) : 1'b1 ;  // 0.06 added

//assign  chsel_0b   = chsel[0] ;   // 0.07 deleted <- 0.06 added

assign  load_chsel = { reg_ads[4], chsel[3:0] } ;                           // 0.06 added
assign  pre_adchsel= ads_wr_f ? reg_ads[4:0] : load_chsel ;                 // 0.06 added
//assign  pre_adchsel_0b = pre_adchsel[0] ;                                 // 0.07 added //0.0i deleted

//assign  adchsel    = reg_adiss ? 5'b11111 : { reg_ads[4], chsel[3:0] } ;  // 0.01 modified for TEMP. sensor
assign  adchsel    = reg_adiss ? 5'b11111 : pre_adchsel ;                   // 0.06 modified

endmodule


module QLK0RADAA32V1_CMP ( 
                           cmp_sar, reg_adul, reg_adll, reg_adrck, 
                           comp_mask
                           );

input   [7:0]  cmp_sar ;
input   [7:0]  reg_adul ;
input   [7:0]  reg_adll ;
input          reg_adrck ;

output         comp_mask ;

reg            dll_cmp ;
reg            dul_cmp ;

// compare dll 
always  @( cmp_sar or reg_adll ) begin
          if ( reg_adll[7:0] > cmp_sar[7:0] ) dll_cmp = 1'b1 ;
          else                            dll_cmp = 1'b0 ;
end 

// compare dul 
always  @( cmp_sar or reg_adul ) begin
          if ( reg_adul[7:0] < cmp_sar[7:0] ) dul_cmp = 1'b1 ;
          else                                dul_cmp = 1'b0 ;
end 

// comp_mask
assign  comp_mask = reg_adrck ? ~( dul_cmp | dll_cmp ) : ( dul_cmp | dll_cmp ) ;


endmodule


module QLK0RADAA32V1_CLK_GEN ( 
                               PCLK, PRESETZ, reg_fr,
                               ADPDB,
                               adclk_fall, adclk_rise
                               );

input          PCLK, PRESETZ ;
input   [2:0]  reg_fr ;
input          ADPDB ;

output         adclk_fall ;
output         adclk_rise ;

reg     [5:0]  counter ;    // 0.02 modified
reg     [5:0]  comp_data ;  // 0.02 modified
wire	[2:0]  counter_data_pre ;  // 0.0i added
wire	[2:0]  counter_data_pre2 ;  // 0.0i added
//wire	[5:0]  counter_data ;  // 0.0i added

wire 		adclk_fall, adclk_rise ;
//wire		counter_en ;  // 0.0i added
//wire    [1:0]   reg_fr_tmp ;

//assign  reg_fr_tmp = reg_fr[1:0] ;

//always  @( reg_fr_tmp )begin
//          case( reg_fr_tmp )
//              2'b00 : comp_data = 3'b101 ;
//              2'b01 : comp_data = 3'b011 ;
//              2'b10 : comp_data = 3'b010 ;
//              2'b11 : comp_data = 3'b001 ;
//          endcase
//end

always  @( reg_fr )begin
          case( reg_fr )
              3'b000  : comp_data = 6'b111111 ;  // fclk/64
              3'b001  : comp_data = 6'b011111 ;  // fclk/32
              3'b010  : comp_data = 6'b001111 ;  // fclk/16
              3'b011  : comp_data = 6'b000111 ;  // fclk/8
              3'b100  : comp_data = 6'b000101 ;  // fclk/6
              3'b101  : comp_data = 6'b000100 ;  // fclk/5
              3'b110  : comp_data = 6'b000011 ;  // fclk/4
              default : comp_data = 6'b000001 ;  // fclk/2
          endcase
end

//always  @( posedge PCLK or negedge PRESETZ ) begin               // 0.0j deleted for improve gating
//          if ( ~PRESETZ )		counter <= 6'b000000 ;
//          else if ( ~ADPDB ) 		counter <= 6'b000000 ;
//          else if ( adclk_rise )	counter <= comp_data ;
//          else        		counter <= counter - 1'b1 ;
//end

assign  counter_data_pre =  adclk_rise ? comp_data[2:0] : counter[2:0] - 1'b1 ;
//assign  counter_data = ~ADPDB ? 6'b000000 : counter_data_pre ;
assign  counter_data_pre2 =  adclk_rise ? comp_data[5:3] : counter[5:3] - 1'b1 ;


always  @( posedge PCLK or negedge PRESETZ ) begin
          if ( ~PRESETZ )		counter[2:0] <= 3'b000 ;
          else if ( ~ADPDB )	  	counter[2:0] <= 3'b000 ;
          else				counter[2:0] <= counter_data_pre ;
end

always  @( posedge PCLK or negedge PRESETZ ) begin 
          if ( ~PRESETZ )               counter[5:3] <= 3'b000 ;
          else if ( ~ADPDB )		counter[5:3] <= 3'b000 ;
          else if ( ~|counter[2:0] )    counter[5:3] <= counter_data_pre2 ;
          else                          counter[5:3] <= counter[5:3] ;
end 


assign  adclk_fall = (counter == 6'b000001)? 1'b1 : 1'b0 ;
assign  adclk_rise = (counter == 6'b000000)? 1'b1 : 1'b0 ;

endmodule


module QLK0RADAA32V1_WUP ( 
                           SCANMODE, PCLK, PRESETZ, reg_awc, wup_trg, clr_wup, 
                           reg_adce, adcs, clr_adcs, SCANCLK,
                           trgsync_1,
//                         reqpclk, reqpclk_d1
                           reqpclk, reqpclk_async, req_rst_sig
                           );

input          SCANMODE, PCLK, PRESETZ, SCANCLK ;
input          reg_awc, wup_trg, clr_wup ;
input          reg_adce, adcs, clr_adcs ;  // 0.09a added
input          trgsync_1 ;                 // 0.0k  added

output         reqpclk ;
output         reqpclk_async ;  // 0.0k added
output         req_rst_sig ;    // 0.0k added

reg            async_resz ;
//wire           async2_resz ;  // 0.0k deleted

reg            reqpclk_async ;
//reg            reqpclk_d1 ;     // 0.0k deleted
wire           reqpclk ;
wire           scan_din ;

wire           clr_cs_msk ;  // 0.09a added
wire           req_rst_sig ; // 0.0k  added

assign  clr_cs_msk = ~adcs & reg_awc ; // 0.09a added

//always  @( SCANMODE or PRESETZ or reg_awc or clr_wup ) begin
//always  @( SCANMODE or PRESETZ or reg_awc or clr_wup or clr_cs_msk or clr_adcs ) begin
always  @( SCANMODE or PRESETZ or reg_awc or clr_wup or clr_cs_msk or clr_adcs or reg_adce ) begin
          if ( !PRESETZ )        async_resz = 1'b0 ;
//        else if ( !SCANMODE )  async_resz = ~( clr_wup | ~reg_awc ) ;
          else if ( !SCANMODE )  async_resz = ~( clr_wup | ~reg_awc | ( ~clr_cs_msk & clr_adcs ) | ~reg_adce ) ;
          else                   async_resz = 1'b1 ;
end

reg            clk_reqpclk ;
//always  @( SCANMODE or PCLK or wup_trg )             // v0.0h deleted
//          case ( SCANMODE ) // synopsys infer_mux    // v0.0h deleted
//            1'b0 : clk_reqpclk = wup_trg ;           // v0.0h deleted
//            1'b1 : clk_reqpclk = PCLK ;              // v0.0h deleted
//          endcase                                    // v0.0h deleted       

always  @( SCANMODE or SCANCLK or wup_trg )            // v0.0h added
//        case ( SCANMODE ) // synopsys infer_mux      // v0.0h added
          case ( SCANMODE )                            // v0.0j modified by m-taku
            1'b0 : clk_reqpclk = wup_trg ;             // v0.0h added
            1'b1 : clk_reqpclk = SCANCLK ;             // v0.0h added
          endcase                                      // v0.0h added

assign  scan_din = wup_trg | ( clr_wup | ~reg_awc ) ;

reg            reqpclk_din ;
always  @( SCANMODE or scan_din )
          case ( SCANMODE ) // synopsys infer_mux
            1'b0 : reqpclk_din = 1'b1 ;
            1'b1 : reqpclk_din = scan_din ;
          endcase

//always  @( posedge clk_reqpclk or negedge async_resz ) begin
//          if( !async_resz )     reqpclk_async <= 1'b0 ;
//          else                  reqpclk_async <= 1'b1 ;
//end
always  @( posedge clk_reqpclk or negedge async_resz ) begin
          if( !async_resz )     reqpclk_async <= 1'b0 ;
          else                  reqpclk_async <= reqpclk_din ;
end


//assign  async2_resz = PRESETZ & ( SCANMODE | reg_awc ) ;  // 0.0k deleted

// v0.0k reqpclk_d1 deleted
//always  @( posedge PCLK or negedge async2_resz ) begin
//          if( !async2_resz )      reqpclk_d1 <= 1'b0 ;
//          else                    reqpclk_d1 <= reqpclk_async ;
//end

// v0.0k added
assign  req_rst_sig = reg_awc & trgsync_1 ;           // 0.0k added

//assign  reqpclk = reqpclk_d1 | reqpclk_async ;
assign  reqpclk     = req_rst_sig | reqpclk_async ;   // 0.0k modified

endmodule


module QLK0RADAA32V1_SYNC ( 
                            PCLK, PRESETZ, 
                            TTRG0, TTRG1, TTRG2, TTRG3, 
//                          ADPDB,
                            reg_adce,
//                          reg_adtrs, reqpclk, reg_awc,
                            reg_adtrs, reg_awc,
                            reqpclk_async,
//                          wup_trg, hard_trg
                            wup_trg, hard_trg, trgsync_1
                            );

input          PCLK, PRESETZ ; 
input          TTRG0, TTRG1, TTRG2, TTRG3 ;
//input          ADPDB ;         // 0.09 added
//input          reqpclk, reg_awc ;
input          reg_awc ;         // 0.0k modified
input          reg_adce ;        // 0.04 added
input   [1:0]  reg_adtrs ;
input          reqpclk_async ;   // 0.0k added

output         wup_trg ;
output         hard_trg ;
output         trgsync_1 ;       // 0.0k added

reg            trgsync_1 ;
reg            trgsync_2 ;
reg            trg_sig ;

//wire           req_st ;     // 0.09  added // 0.0h deleted
//reg            req_st ;       // 0.09a added

wire           sel_trg ;
wire           hard_trg ;

always  @( reg_adtrs or TTRG0 or TTRG1 or TTRG2 or TTRG3 ) begin
        case( reg_adtrs )
          2'b01   : trg_sig = TTRG1 ;
          2'b10   : trg_sig = TTRG2 ;
          2'b11   : trg_sig = TTRG3 ;
          default : trg_sig = TTRG0 ;
        endcase
end

//assign  sel_trg = reg_awc ? reqpclk : trg_sig ;     // 0.0h added
assign  sel_trg = reg_awc ? reqpclk_async : trg_sig ; // 0.0k modified

//assign  req_st  = reg_awc & ~ADPDB ;              // 0.09 added
//assign  req_st  = reg_awc & ~reqpclk ;              // 0.09a added  0.0h deleted

//assign  sel_trg = req_st ? reqpclk : trg_sig ;  // 0.09 modified

always  @( posedge PCLK or negedge PRESETZ ) begin
        if( !PRESETZ )       trgsync_1 <= 1'b0;
        else if( !reg_adce ) trgsync_1 <= 1'b0;        // 0.04 added
        else                 trgsync_1 <= sel_trg ;
end

always  @( posedge PCLK or negedge PRESETZ ) begin
        if( !PRESETZ ) trgsync_2 <= 1'b0;
        else           trgsync_2 <= trgsync_1 ;
end

assign  hard_trg = trgsync_1 & ~trgsync_2 ;

assign  wup_trg  = trg_sig ;

endmodule

module QLK0RADAA32V1_BYPASS (
                              SCANMODE, TESDBT,

//                            reg_adrefp, reg_adrefm, reg_adtes,
//                            dis,

                              ADPDBS, ADBIONBS, ADS1S, ADOFCS, ADCMPS, ADCPONS,
                              ADCHSEL,
                              ADVSELMOD0S, ADVSELMOD1S, ADGSELMODS, ADTESMOD0S, ADTESMOD1S, ADTESMOD2S,
                              BG2ADENS, BG2ADSELS,
                              
                              ADEOCB, ADSAR,

                              ADPDBH, ADBIONBH, ADS1H, ADOFCH, ADCMPH, ADCPONH,
                              ADCHSEL4H, ADCHSEL3H, ADCHSEL2H, ADCHSEL1H, ADCHSEL0H, 
                              ADVSELMOD0H, ADVSELMOD1H, ADGSELMODH, ADTESMOD0H, ADTESMOD1H, ADTESMOD2H,
                              BG2ADENH, BG2ADSELH,

                              EOCB, SAR
                              );

input          SCANMODE, TESDBT ;
//input  [1:0]   reg_adrefp ;
//input          reg_adrefm ;
//input  [2:0]   reg_adtes ;

input          ADPDBS ;
input          ADBIONBS ;
input          ADS1S ;
input          ADOFCS ;
input          ADCMPS ;
input          ADCPONS ;
input  [4:0]   ADCHSEL ;

input          ADVSELMOD0S ;  // 0.03 added for ICE
input          ADVSELMOD1S ;  // 0.03 added for ICE
input          ADGSELMODS ;   // 0.03 added for ICE
input          ADTESMOD0S ;   // 0.03 added for ICE
input          ADTESMOD1S ;   // 0.03 added for ICE
input          ADTESMOD2S ;   // 0.03 added for ICE
 
input          BG2ADENS ;   // 0.02 added
input          BG2ADSELS ;  // 0.02 added

input          ADEOCB ;
input  [9:0]   ADSAR ;

//input          dis ;        // 0.02 added for dis charge

output         ADPDBH ;
output         ADBIONBH ;
output         ADS1H ;
output         ADOFCH ;
output         ADCMPH ;
output         ADCPONH ;
output         ADCHSEL4H ;
output         ADCHSEL3H ;
output         ADCHSEL2H ;
output         ADCHSEL1H ;
output         ADCHSEL0H ;
output         ADVSELMOD0H ;
output         ADVSELMOD1H ;
output         ADGSELMODH ;
output         ADTESMOD0H ;
output         ADTESMOD1H ;
output         ADTESMOD2H ;

output         BG2ADENH ;   // 0.02 added
output         BG2ADSELH ;  // 0.02 added

output         EOCB ;
output [9:0]   SAR ;

wire           o_scan_bt ;
wire   [1:0]   c_scan_bt ;

assign  o_scan_bt = SCANMODE | TESDBT ;
assign  c_scan_bt = { TESDBT, SCANMODE } ;

// ADS1H/ADOFCH/BG2ADSELH
assign  ADS1H      = ADS1S & ~o_scan_bt ;
assign  ADOFCH     = ADOFCS & ~o_scan_bt ;
assign  BG2ADSELH  = BG2ADSELS & ~o_scan_bt ;

// ADCPONH
assign  ADCPONH    = ADCPONS | o_scan_bt ;   //  0.08 modified

// ADTESMOD0H,ADTESMOD2H
//wire           ADTESMOD0 ;
//wire           ADTESMOD2 ;

//assign  ADTESMOD0  = reg_adtes[0] ;
//assign  ADTESMOD2  = reg_adtes[2] ;

assign  ADTESMOD0H = ADTESMOD0S & ~o_scan_bt ;
assign  ADTESMOD2H = ADTESMOD2S & ~o_scan_bt ;

// ADTESMOD1H
//wire           ADTESMOD1 ;
//assign  ADTESMOD1  = reg_adtes[1] | dis ;  // 0.02 added for dis charge
assign  ADTESMOD1H = ADTESMOD1S & ~o_scan_bt ;

reg            ADPDBH ;
reg            ADBIONBH ;

// ADPDBH
always  @( c_scan_bt or ADPDBS ) begin
          case ( c_scan_bt )
            2'b00   : ADPDBH = ADPDBS ;
            2'b01   : ADPDBH = 1'b0 ;
            default : ADPDBH = 1'b1 ;
          endcase
end

// ADBIONBH
always  @( c_scan_bt or ADBIONBS ) begin
          case ( c_scan_bt )
            2'b00   : ADBIONBH = ADBIONBS ;
            2'b01   : ADBIONBH = 1'b1 ;
            default : ADBIONBH = 1'b0 ;
          endcase
end

// ADCMPH
assign  ADCMPH = ADCMPS & ~( SCANMODE & ~TESDBT ) ;

// ADVSELMOD0/ADVSELMOD1
//wire   [1:0]   ADVSELMOD ;
//assign  ADVSELMOD = ( reg_adrefp[1] & reg_adrefp[0] ) ? 2'b0 : reg_adrefp ;

// ADVSELMOD0H
assign  ADVSELMOD0H = ADVSELMOD0S & ~TESDBT ;

// ADVSELMOD1H
assign  ADVSELMOD1H = ADVSELMOD1S & ~TESDBT ;

// pre_adgselmod
//wire           ADGSELMOD ;
//assign         ADGSELMOD = reg_adrefm ;

// ADGSELMODH
assign  ADGSELMODH = ADGSELMODS & ~TESDBT ;

// BG2ADENH  0.02 added
//assign  BG2ADENH  = BG2ADENS ;
assign  BG2ADENH   = BG2ADENS & ~( SCANMODE & ~TESDBT ) ;  // 0.06 modified

// ADCHSEL4H-0H
assign  ADCHSEL4H = ADCHSEL[4] ;
assign  ADCHSEL3H = ADCHSEL[3] ;
assign  ADCHSEL2H = ADCHSEL[2] ;
assign  ADCHSEL1H = ADCHSEL[1] ;
assign  ADCHSEL0H = ADCHSEL[0] ;

// EOCB
assign  EOCB = SCANMODE ? ADBIONBS : ADEOCB ;

// SAR9-0
assign  SAR[9] = SCANMODE ? ADPDBS      : ADSAR[9] ;
assign  SAR[8] = SCANMODE ? ADCPONS     : ADSAR[8] ;
assign  SAR[7] = SCANMODE ? ADS1S       : ADSAR[7] ;
assign  SAR[6] = SCANMODE ? ADOFCS      : ADSAR[6] ;
assign  SAR[5] = SCANMODE ? ADCMPS      : ADSAR[5] ;
assign  SAR[4] = SCANMODE ? ADCHSEL[4]  : ADSAR[4] ;
assign  SAR[3] = SCANMODE ? ADCHSEL[3]  : ADSAR[3] ;
assign  SAR[2] = SCANMODE ? ADCHSEL[2]  : ADSAR[2] ;
assign  SAR[1] = SCANMODE ? ADCHSEL[1]  : ADSAR[1] ;
assign  SAR[0] = SCANMODE ? ADCHSEL[0]  : ADSAR[0] ;

endmodule

