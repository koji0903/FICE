//  (C) Copyright NEC Electronics Corporation 2010
//  All Rights Reserved. Do not duplicate without prior written
//  consent of NEC Electronics Corporation.
//
//  Macro Name   : QLK0RRTC0V3
//  Version      : 3.10
//  Date         : 2010/06/03
//  Creator      : M.Minami RENESAS Micro systems
//  History      : 2010/01/26 ver3.00
//               : 2010/06/04 ver3.10 
//                            Add clock selecter in PCLK line for the Scan Test
//

module QLK0RRTC0V3	(
        SCANMODE,
        RT0LPM,
	PCLK,
	RTCRESB,
	PRESETZ,
	RTCCLK,
        INTRCLK,
	CKSEL,
	RT0TEN,
	SVMOD,

	PADDR3,
	PADDR2,
	PADDR1,
	PADDR0,
	PWDATA15,
	PWDATA14,
	PWDATA13,
	PWDATA12,
	PWDATA11,
	PWDATA10,
	PWDATA9,
	PWDATA8,
	PWDATA7,
	PWDATA6,
	PWDATA5,
	PWDATA4,
	PWDATA3,
	PWDATA2,
	PWDATA1,
	PWDATA0,
	PRDATA15,
	PRDATA14,
	PRDATA13,
	PRDATA12,
	PRDATA11,
	PRDATA10,
	PRDATA9,
	PRDATA8,
	PRDATA7,
	PRDATA6,
	PRDATA5,
	PRDATA4,
	PRDATA3,
	PRDATA2,
	PRDATA1,
	PRDATA0,
	PWRITE,
	PENABLE,
	PSEL,
	INTRTC,
	INTRTCI,
//	CLK32KHZ,
	CLK1HZ,
	RT0MON0,
	RT0MON1
	);


//--- port direction
input			SCANMODE;
input			RT0LPM;

input			PCLK;
input			PADDR3;
input			PADDR2;
input			PADDR1;
input			PADDR0;
input			PWDATA15;
input			PWDATA14;
input			PWDATA13;
input			PWDATA12;
input			PWDATA11;
input			PWDATA10;
input			PWDATA9;
input			PWDATA8;
input			PWDATA7;
input			PWDATA6;
input			PWDATA5;
input			PWDATA4;
input			PWDATA3;
input			PWDATA2;
input			PWDATA1;
input			PWDATA0;
output			PRDATA15;
output			PRDATA14;
output			PRDATA13;
output			PRDATA12;
output			PRDATA11;
output			PRDATA10;
output			PRDATA9;
output			PRDATA8;
output			PRDATA7;
output			PRDATA6;
output			PRDATA5;
output			PRDATA4;
output			PRDATA3;
output			PRDATA2;
output			PRDATA1;
output			PRDATA0;
input			PWRITE;
input			PENABLE;
input			PSEL;


input			RTCRESB;
input			PRESETZ;
input			RTCCLK;
input			INTRCLK;
input			CKSEL;
input			RT0TEN;
input			SVMOD;

output			INTRTC;
output			INTRTCI;
//output			CLK32KHZ;
output			CLK1HZ;
output			RT0MON0;
output			RT0MON1;



//--- reg, wire
wire	[15:0]	din;
wire	[15:0]	dout;

wire re_rtcc0, re_rtcc1, re_sec, re_min, re_hour,
     re_week, re_day, re_month, re_year, re_subcud, re_alarmwm, re_alarmwh, re_alarmww, re_itmc,
     we_rtcc0, we_rtcc1, we_sec, we_min, we_hour, we_week, we_day, we_month,
     we_year, we_subcud, we_alarmwm, we_alarmwh, we_alarmww, we_itmc;

//--- Module Connect
QLK0RRTC0V3_APBBI apbbi	(
	.addr({PADDR3, PADDR2, PADDR1, PADDR0}),
	.wdata({PWDATA15, PWDATA14, PWDATA13, PWDATA12,
	        PWDATA11, PWDATA10, PWDATA9 , PWDATA8 ,
	        PWDATA7 , PWDATA6 , PWDATA5 , PWDATA4 ,
	        PWDATA3 , PWDATA2 , PWDATA1 , PWDATA0}
	      ),
	.rdata({PRDATA15, PRDATA14, PRDATA13, PRDATA12,
	        PRDATA11, PRDATA10, PRDATA9 , PRDATA8 ,
	        PRDATA7 , PRDATA6 , PRDATA5 , PRDATA4 ,
	        PRDATA3 , PRDATA2 , PRDATA1 , PRDATA0 }
	      ),
	.PWRITE(PWRITE),
	.PENABLE(PENABLE),
	.PSEL(PSEL),

	.re_rtcc0(re_rtcc0),
	.re_rtcc1(re_rtcc1),
//	.re_subc(re_subc),
	.re_sec(re_sec),
	.re_min(re_min),
	.re_hour(re_hour),
	.re_week(re_week),
	.re_day(re_day),
	.re_month(re_month),
	.re_year(re_year),
	.re_subcud(re_subcud),
	.re_alarmwm(re_alarmwm),
	.re_alarmwh(re_alarmwh),
	.re_alarmww(re_alarmww),
	.re_itmc(re_itmc),
	.we_rtcc0(we_rtcc0),
	.we_rtcc1(we_rtcc1),
	.we_sec(we_sec),
	.we_min(we_min),
	.we_hour(we_hour),
	.we_week(we_week),
	.we_day(we_day),
	.we_month(we_month),
	.we_year(we_year),
	.we_subcud(we_subcud),
	.we_alarmwm(we_alarmwm),
	.we_alarmwh(we_alarmwh),
	.we_alarmww(we_alarmww),
	.we_itmc(we_itmc),

	.din(din),
	.dout(dout)
	);



QLK0RRTC0V3_MAIN main	(
	.SCANMODE(SCANMODE),
        .RT0LPM(RT0LPM),
	.PCLK(PCLK),
	.RTCRESB(RTCRESB),
	.PRESETZ(PRESETZ),
	.RTCCLK(RTCCLK),
	.INTRCLK(INTRCLK),
	.CKSEL(CKSEL),
	.RT0TEN(RT0TEN),
	.SVMOD(SVMOD),
//	.CLK32KHZ(CLK32KHZ),
	.CLK1HZ(CLK1HZ),

	.re_rtcc0(re_rtcc0),
	.re_rtcc1(re_rtcc1),
//	.re_rtcc2(re_rtcc2),
//	.re_subc(re_subc),
	.re_sec(re_sec),
	.re_min(re_min),
	.re_hour(re_hour),
	.re_week(re_week),
	.re_day(re_day),
	.re_month(re_month),
	.re_year(re_year),
	.re_subcud(re_subcud),
	.re_alarmwm(re_alarmwm),
	.re_alarmwh(re_alarmwh),
	.re_alarmww(re_alarmww),
	.re_itmc(re_itmc),
	.we_rtcc0(we_rtcc0),
	.we_rtcc1(we_rtcc1),
	.we_sec(we_sec),
	.we_min(we_min),
	.we_hour(we_hour),
	.we_week(we_week),
	.we_day(we_day),
	.we_month(we_month),
	.we_year(we_year),
	.we_subcud(we_subcud),
	.we_alarmwm(we_alarmwm),
	.we_alarmwh(we_alarmwh),
	.we_alarmww(we_alarmww),
	.we_itmc(we_itmc),

	.intr(INTRTC),
	.INTRTCI(INTRTCI),
	.din(din),
	.dout(dout),
	.RT0MON0(RT0MON0),
	.RT0MON1(RT0MON1)
	);




endmodule





module QLK0RRTC0V3_APBBI	(
	addr,
	wdata,
	rdata,
	PWRITE,
	PENABLE,
	PSEL,

	re_rtcc0,
	re_rtcc1,
//	re_subc,
	re_sec,
	re_min,
	re_hour,
	re_week,
	re_day,
	re_month,
	re_year,
	re_subcud,
	re_alarmwm,
	re_alarmwh,
	re_alarmww,
	re_itmc,
	we_rtcc0,
	we_rtcc1,
	we_sec,
	we_min,
	we_hour,
	we_week,
	we_day,
	we_month,
	we_year,
	we_subcud,
	we_alarmwm,
	we_alarmwh,
	we_alarmww,
	we_itmc,

	din,
	dout
	);


//--- port direction
input	[3:0]	addr;
input	[15:0]	wdata;
output	[15:0]	rdata;
input			PWRITE;
input			PENABLE;
input			PSEL;

output			re_rtcc0;
output			re_rtcc1;
////// output			re_subc;
output			re_sec;
output			re_min;
output			re_hour;
output			re_week;
output			re_day;
output			re_month;
output			re_year;
output			re_subcud;
output			re_alarmwm;
output			re_alarmwh;
output			re_alarmww;
output			re_itmc;
output			we_rtcc0;
output			we_rtcc1;
output			we_sec;
output			we_min;
output			we_hour;
output			we_week;
output			we_day;
output			we_month;
output			we_year;
output			we_subcud;
output			we_alarmwm;
output			we_alarmwh;
output			we_alarmww;
output			we_itmc;

output	[15:0]	din;
input	[15:0]	dout;


//--- wire
wire			sel_rtcc0;
wire			sel_rtcc1;
wire			sel_subc;
wire			sel_sec;
wire			sel_min;
wire			sel_hour;
wire			sel_week;
wire			sel_day;
wire			sel_month;
wire			sel_year;
wire			sel_subcud;
wire			sel_alarmwm;
wire			sel_alarmwh;
wire			sel_alarmww;
wire			sel_itmc;


//--- logic

//Address Decode
assign sel_rtcc0	=  PSEL & (addr == 4'hd);
assign sel_rtcc1	=  PSEL & (addr == 4'he);
////// assign sel_rtcc2	=  PSEL & (addr == 4'hf);
////// assign sel_subc		=  PSEL & (addr == 4'h0);
assign sel_sec		=  PSEL & (addr == 4'h2);
assign sel_min		=  PSEL & (addr == 4'h3);
assign sel_hour		=  PSEL & (addr == 4'h4);
assign sel_week		=  PSEL & (addr == 4'h5);
assign sel_day		=  PSEL & (addr == 4'h6);
assign sel_month	=  PSEL & (addr == 4'h7);
assign sel_year		=  PSEL & (addr == 4'h8);
assign sel_subcud	=  PSEL & (addr == 4'h9);
assign sel_alarmwm	=  PSEL & (addr == 4'ha);
assign sel_alarmwh	=  PSEL & (addr == 4'hb);
assign sel_alarmww	=  PSEL & (addr == 4'hc);
assign sel_itmc		=  PSEL & (addr == 4'h0);

//Write Enable
assign we_rtcc0		= (sel_rtcc0 && PENABLE && PWRITE);
assign we_rtcc1		= (sel_rtcc1 && PENABLE && PWRITE);
//////assign we_rtcc2		= (sel_rtcc2 && PENABLE && PWRITE);
assign we_sec		= (sel_sec	 && PENABLE && PWRITE);
assign we_min		= (sel_min	 && PENABLE && PWRITE);
assign we_hour		= (sel_hour	 && PENABLE && PWRITE);
assign we_week		= (sel_week	 && PENABLE && PWRITE);
assign we_day		= (sel_day	 && PENABLE && PWRITE);
assign we_month		= (sel_month && PENABLE && PWRITE);
assign we_year		= (sel_year	 && PENABLE && PWRITE);
assign we_subcud	= (sel_subcud && PENABLE && PWRITE);
assign we_alarmwm	= (sel_alarmwm && PENABLE && PWRITE);
assign we_alarmwh	= (sel_alarmwh && PENABLE && PWRITE);
assign we_alarmww	= (sel_alarmww && PENABLE && PWRITE);
assign we_itmc		= (sel_itmc && PENABLE && PWRITE);


//Write Enable
assign re_rtcc0		= (sel_rtcc0 && PENABLE && (!PWRITE));
assign re_rtcc1		= (sel_rtcc1 && PENABLE && (!PWRITE));
//////assign re_rtcc2		= (sel_rtcc2 && PENABLE && (!PWRITE));
//////assign re_subc		= (sel_subc	 && PENABLE && (!PWRITE));
assign re_sec		= (sel_sec	 && PENABLE && (!PWRITE));
assign re_min		= (sel_min	 && PENABLE && (!PWRITE));
assign re_hour		= (sel_hour	 && PENABLE && (!PWRITE));
assign re_week		= (sel_week	 && PENABLE && (!PWRITE));
assign re_day		= (sel_day	 && PENABLE && (!PWRITE));
assign re_month		= (sel_month && PENABLE && (!PWRITE));
assign re_year		= (sel_year	 && PENABLE && (!PWRITE));
assign re_subcud	= (sel_subcud && PENABLE && (!PWRITE));
assign re_alarmwm	= (sel_alarmwm && PENABLE && (!PWRITE));
assign re_alarmwh	= (sel_alarmwh && PENABLE && (!PWRITE));
assign re_alarmww	= (sel_alarmww && PENABLE && (!PWRITE));
assign re_itmc		= (sel_itmc && PENABLE && (!PWRITE));


//Output
assign din		= wdata;
assign rdata	= dout;

endmodule





module QLK0RRTC0V3_MAIN	(
	SCANMODE,
	RT0LPM,
	PCLK,
	RTCRESB,
	PRESETZ,
	RTCCLK,
	INTRCLK,
	CKSEL,
	RT0TEN,
	SVMOD,
//	CLK32KHZ,
	CLK1HZ,

	re_rtcc0,
	re_rtcc1,
//	re_subc,
	re_sec,
	re_min,
	re_hour,
	re_week,
	re_day,
	re_month,
	re_year,
	re_subcud,
	re_alarmwm,
	re_alarmwh,
	re_alarmww,
	re_itmc,
	we_rtcc0,
	we_rtcc1,
	we_sec,
	we_min,
	we_hour,
	we_week,
	we_day,
	we_month,
	we_year,
	we_subcud,
	we_alarmwm,
	we_alarmwh,
	we_alarmww,
	we_itmc,

	intr,
	INTRTCI,
	din,
	dout,
	RT0MON0,
	RT0MON1
	);

input			SCANMODE;
input			RT0LPM;
input			PCLK;
input			RTCRESB;
input			PRESETZ;
input			RTCCLK;
input			INTRCLK;
input			CKSEL;
input			RT0TEN;
input			SVMOD;
//output			CLK32KHZ;
output			CLK1HZ;

input			re_rtcc0;
input			re_rtcc1;
//////input			re_subc;
input			re_sec;
input			re_min;
input			re_hour;
input			re_week;
input			re_day;
input			re_month;
input			re_year;
input			re_subcud;
input			re_alarmwm;
input			re_alarmwh;
input			re_alarmww;
input			re_itmc;
input			we_rtcc0;
input			we_rtcc1;
input			we_sec;
input			we_min;
input			we_hour;
input			we_week;
input			we_day;
input			we_month;
input			we_year;
input			we_subcud;
input			we_alarmwm;
input			we_alarmwh;
input			we_alarmww;
input			we_itmc;

output			intr;
output			INTRTCI;
input	[15:0]		din;
output	[15:0]		dout;
output			RT0MON0;
output			RT0MON1;

//--- reg, wire
wire	[15:0]	subbuf;
wire	[6:0]	secbuf;
wire	[6:0]	minbuf;
wire	[5:0]	hourbuf;
wire	[2:0]	weekbuf;
wire	[5:0]	daybuf;
wire	[4:0]	monbuf;
wire	[7:0]	yearbuf;

////// wire	[15:0]	subcount;
wire	[6:0]	seccount;
wire	[6:0]	mincount;
wire	[5:0]	hourcount;
wire	[2:0]	weekcount;
wire	[5:0]	daycount;
wire	[4:0]	moncount;
wire	[7:0]	yearcount;
wire	[11:0]	ITMCMP;

wire wafg_rtc, rifg_rtc, cntwait, cnt_writing, wafg_rst, rifg_rst, rtce, 
     cloe1, ampm, ct2, ct1, ct0, wale, walie, 
     cwait, rwait, RINTE, RINTE_RTC,
//cloe2, ckdiv, ict2, ict1, ict0, 
     dev, f6, f5, f4, f3, f2, f1, f0, 
     wm40, wm20, wm10, wm8, wm4, wm2, wm1,
     wh20, wh10, wh8, wh4, wh2, wh1,
     ww6, ww5, ww4, ww3, ww2, ww1, ww0, 
     load_sec_trg, load_min_trg, load_hour_trg, load_week_trg,
     load_day_trg, load_mon_trg, load_year_trg, load_seccount,
     load_mincount, load_hourcount, load_weekcount, load_daycount,
     load_moncount, load_yearcount;
wire PCLK_SELCK;

QLK0RRTC0V3_PCLK_CLKSEL pclk_clksel
(.SCANMODE(SCANMODE), .PCLK(PCLK), .INTRCLK(INTRCLK), .PCLK_SELCK(PCLK_SELCK));

//--- Module Connect
QLK0RRTC0V3_IOREG ioreg	(
	.PCLK(PCLK_SELCK),
	.RTCRESB(RTCRESB),
	.PRESETZ(PRESETZ),

	.we_rtcc0(we_rtcc0),
	.we_rtcc1(we_rtcc1),
//	.we_rtcc2(we_rtcc2),
	.we_subcud(we_subcud),
	.we_alarmwm(we_alarmwm),
	.we_alarmwh(we_alarmwh),
	.we_alarmww(we_alarmww),
	.we_itmc(we_itmc),

	.din(din),
//////	.wafg_rtc(wafg_rtc),
//	.int_ct(int_ct),				// Ver1.20 del
//////	.rifg_rtc(rifg_rtc),			// Ver1.20 add
	.cntwait(cntwait),
	.cnt_writing(cnt_writing),		// Ver1.10 add
	.wafg_rst(wafg_rst),			// Ver1.20 add
	.rifg_rst(rifg_rst),			// Ver1.20 add

	.rtce(rtce),
	.cloe1(cloe1),
	.ampm(ampm),
	.ct2(ct2),
	.ct1(ct1),
	.ct0(ct0),
	.wale(wale),
	.walie(walie),
//////	.wafg(wafg),
//////	.rifg(rifg),
	.cwait(cwait),
	.rwait(rwait),
	.RINTE(RINTE),
	.ITMCMP(ITMCMP),
//	.cloe2(cloe2),
//	.ckdiv(ckdiv),
//	.ict2(ict2),
//	.ict1(ict1),
//	.ict0(ict0),
	.dev(dev),
	.f6(f6),
	.f5(f5),
	.f4(f4),
	.f3(f3),
	.f2(f2),
	.f1(f1),
	.f0(f0),
	.wm40(wm40),
	.wm20(wm20),
	.wm10(wm10),
	.wm8(wm8),
	.wm4(wm4),
	.wm2(wm2),
	.wm1(wm1),
	.wh20(wh20),
	.wh10(wh10),
	.wh8(wh8),
	.wh4(wh4),
	.wh2(wh2),
	.wh1(wh1),
	.ww6(ww6),
	.ww5(ww5),
	.ww4(ww4),
	.ww3(ww3),
	.ww2(ww2),
	.ww1(ww1),
	.ww0(ww0)
	);


QLK0RRTC0V3_WERDBUF werdbuf	(
	.PCLK(PCLK_SELCK),
	.RTCRESB(RTCRESB),

	.we_sec(we_sec),
	.we_min(we_min),
	.we_hour(we_hour),
	.we_week(we_week),
	.we_day(we_day),
	.we_month(we_month),
	.we_year(we_year),

	.din(din),

	.ampm(ampm),

///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//	.subcount(subcount),

	.seccount(seccount),
	.mincount(mincount),
	.hourcount(hourcount),
	.weekcount(weekcount),
	.daycount(daycount),
	.moncount(moncount),
	.yearcount(yearcount),
	.load_sec_trg(load_sec_trg),
	.load_min_trg(load_min_trg),
	.load_hour_trg(load_hour_trg),
	.load_week_trg(load_week_trg),
	.load_day_trg(load_day_trg),
	.load_mon_trg(load_mon_trg),
	.load_year_trg(load_year_trg),

///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//	.subbuf(subbuf),

	.secbuf(secbuf),
	.minbuf(minbuf),
	.hourbuf(hourbuf),
	.weekbuf(weekbuf),
	.daybuf(daybuf),
	.monbuf(monbuf),
	.yearbuf(yearbuf),
	.load_seccount(load_seccount),
	.load_mincount(load_mincount),
	.load_hourcount(load_hourcount),
	.load_weekcount(load_weekcount),
	.load_daycount(load_daycount),
	.load_moncount(load_moncount),
	.load_yearcount(load_yearcount),
	.cnt_writing(cnt_writing)		// Ver1.10 add
	);


QLK0RRTC0V3_CNT cnt	(
        .RT0LPM(RT0LPM),
	.RTCCLK(RTCCLK),
	.INTRCLK(INTRCLK),
	.RTCRESB(RTCRESB),
	.PRESETZ(PRESETZ),
	.CKSEL(CKSEL),
	.RT0TEN(RT0TEN),
	.SVMOD(SVMOD),
//	.CLK32KHZ(CLK32KHZ),
	.CLK1HZ(CLK1HZ),

	.rtce(rtce),
	.cloe1(cloe1),
	.ct2(ct2),
	.ct1(ct1),
	.ct0(ct0),
	.wale(wale),
	.walie(walie),
//	.wafg(wafg),			// Ver1.20 del
	.rwait(rwait),
	.RINTE(RINTE),
	.ITMCMP(ITMCMP),
//	.cloe2(cloe2),
//	.ckdiv(ckdiv),
//	.ict2(ict2),
//	.ict1(ict1),
//	.ict0(ict0),
	.dev(dev),
	.f6(f6),
	.f5(f5),
	.f4(f4),
	.f3(f3),
	.f2(f2),
	.f1(f1),
	.f0(f0),
	.wm40(wm40),
	.wm20(wm20),
	.wm10(wm10),
	.wm8(wm8),
	.wm4(wm4),
	.wm2(wm2),
	.wm1(wm1),
	.wh20(wh20),
	.wh10(wh10),
	.wh8(wh8),
	.wh4(wh4),
	.wh2(wh2),
	.wh1(wh1),
	.ww6(ww6),
	.ww5(ww5),
	.ww4(ww4),
	.ww3(ww3),
	.ww2(ww2),
	.ww1(ww1),
	.ww0(ww0),

//////	.subcount(subcount),
	.secbuf(secbuf),
	.seccount(seccount),
	.minbuf(minbuf),
	.mincount(mincount),
	.hourbuf(hourbuf),
	.hourcount(hourcount),
	.weekbuf(weekbuf),
	.weekcount(weekcount),
	.daybuf(daybuf),
	.daycount(daycount),
	.monbuf(monbuf),
	.moncount(moncount),
	.yearbuf(yearbuf),
	.yearcount(yearcount),
	.load_seccount(load_seccount),
	.load_sec_trg(load_sec_trg),
	.load_mincount(load_mincount),
	.load_min_trg(load_min_trg),
	.load_hourcount(load_hourcount),
	.load_hour_trg(load_hour_trg),
	.load_weekcount(load_weekcount),
	.load_week_trg(load_week_trg),
	.load_daycount(load_daycount),
	.load_day_trg(load_day_trg),
	.load_moncount(load_moncount),
	.load_mon_trg(load_mon_trg),
	.load_yearcount(load_yearcount),
	.load_year_trg(load_year_trg),
	.wafg_rtc(wafg_rtc),
//	.int_ct(int_ct),				// Ver1.20 del
	.rifg_rtc(rifg_rtc),			// Ver1.20 add
	.wafg_rst(wafg_rst),			// Ver1.20 add
	.rifg_rst(rifg_rst),			// Ver1.20 add

	.cntwait(cntwait),
	.intr(intr),
	.INTRTCI(INTRTCI),
	.RINTE_RTC(RINTE_RTC),
	.RT0MON0(RT0MON0),
	.RT0MON1(RT0MON1)
	);


QLK0RRTC0V3_DOUTSEL doutsel	(
	.re_rtcc0(re_rtcc0),
	.re_rtcc1(re_rtcc1),
//////	.re_rtcc2(re_rtcc2),
//////	.re_subc(re_subc),
	.re_sec(re_sec),
	.re_min(re_min),
	.re_hour(re_hour),
	.re_week(re_week),
	.re_day(re_day),
	.re_month(re_month),
	.re_year(re_year),
	.re_subcud(re_subcud),
	.re_alarmwm(re_alarmwm),
	.re_alarmwh(re_alarmwh),
	.re_alarmww(re_alarmww),
	.re_itmc(re_itmc),
	.rtce(rtce),
	.cloe1(cloe1),
	.ampm(ampm),
	.ct2(ct2),
	.ct1(ct1),
	.ct0(ct0),
	.wale(wale),
	.walie(walie),
	.wafg_rtc(wafg_rtc),
	.rifg_rtc(rifg_rtc),
	.cwait(cwait),
	.rwait(rwait),
	.RINTE_RTC(RINTE_RTC),
	.ITMCMP(ITMCMP),
//	.cloe2(cloe2),
//	.ckdiv(ckdiv),
//	.ict2(ict2),
//	.ict1(ict1),
//	.ict0(ict0),
	.dev(dev),
	.f6(f6),
	.f5(f5),
	.f4(f4),
	.f3(f3),
	.f2(f2),
	.f1(f1),
	.f0(f0),
	.wm40(wm40),
	.wm20(wm20),
	.wm10(wm10),
	.wm8(wm8),
	.wm4(wm4),
	.wm2(wm2),
	.wm1(wm1),
	.wh20(wh20),
	.wh10(wh10),
	.wh8(wh8),
	.wh4(wh4),
	.wh2(wh2),
	.wh1(wh1),
	.ww6(ww6),
	.ww5(ww5),
	.ww4(ww4),
	.ww3(ww3),
	.ww2(ww2),
	.ww1(ww1),
	.ww0(ww0),
///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//	.subbuf(subbuf),
//////	.subcount(subcount),

	.secbuf(secbuf),
	.minbuf(minbuf),
	.hourbuf(hourbuf),
	.weekbuf(weekbuf),
	.daybuf(daybuf),
	.monbuf(monbuf),
	.yearbuf(yearbuf),

	.dout(dout)
	);


endmodule





module QLK0RRTC0V3_IOREG	(
	PCLK,
	RTCRESB,
	PRESETZ,

	we_rtcc0,
	we_rtcc1,
//	we_rtcc2,
	we_subcud,
	we_alarmwm,
	we_alarmwh,
	we_alarmww,
	we_itmc,
	din,

//////	wafg_rtc,
//	int_ct,				// Ver1.20 del
//////	rifg_rtc,			// Ver1.20 add
	cntwait,
	cnt_writing,		// Ver1.10 add

	wafg_rst,			// Ver1.20 add
	rifg_rst,			// Ver1.20 add

	rtce,
	cloe1,
	ampm,
	ct2,
	ct1,
	ct0,

	wale,
	walie,
//////	wafg,
//////	rifg,
	cwait,
	rwait,

	RINTE,
	ITMCMP,
//	cloe2,
//	ckdiv,
//	ict2,
//	ict1,
//	ict0,

	dev,
	f6,
	f5,
	f4,
	f3,
	f2,
	f1,
	f0,

	wm40,
	wm20,
	wm10,
	wm8,
	wm4,
	wm2,
	wm1,

	wh20,
	wh10,
	wh8,
	wh4,
	wh2,
	wh1,

	ww6,
	ww5,
	ww4,
	ww3,
	ww2,
	ww1,
	ww0

	);

//--- port direction
input			PCLK;
input			RTCRESB;
input			PRESETZ;

input			we_rtcc0;
input			we_rtcc1;
input			we_subcud;
input			we_alarmwm;
input			we_alarmwh;
input			we_alarmww;
input			we_itmc;
input	[15:0]	din;

//////input			wafg_rtc;
//input			int_ct;			// Ver1.20 del
//////input			rifg_rtc;		// Ver1.20 add
input			cntwait;
input			cnt_writing;	// Ver1.10 Add

output			wafg_rst;		// Ver1.20 add
output			rifg_rst;		// Ver1.20 add

output			rtce;
output			cloe1;
output			ampm;
output			ct2;
output			ct1;
output			ct0;

output			wale;
output			walie;
//////output			wafg;
//////output			rifg;
output			cwait;
output			rwait;

output			RINTE;
output[11:0]		ITMCMP;
//output			cloe2;
//output			ckdiv;
//output			ict2;
//output			ict1;
//output			ict0;

output			dev;
output			f6;
output			f5;
output			f4;
output			f3;
output			f2;
output			f1;
output			f0;

output			wm40;
output			wm20;
output			wm10;
output			wm8;
output			wm4;
output			wm2;
output			wm1;

output			wh20;
output			wh10;
output			wh8;
output			wh4;
output			wh2;
output			wh1;

output			ww6;
output			ww5;
output			ww4;
output			ww3;
output			ww2;
output			ww1;
output			ww0;


//--- reg, wire
reg				rtce;
reg				cloe1;
reg				ampm;
reg				ct2;
reg				ct1;
reg				ct0;

reg				wale;
reg				walie;
//reg				wafg;
//reg				rifg;
wire				wafg;
wire				rifg;
reg				cwait;
reg				rwait;

reg				RINTE;
//reg				cloe2;
//reg				ckdiv;
//reg				ict2;
//reg				ict1;
//reg				ict0;

reg				dev;
reg				f6;
reg				f5;
reg				f4;
reg				f3;
reg				f2;
reg				f1;
reg				f0;

reg				wm40;
reg				wm20;
reg				wm10;
reg				wm8;
reg				wm4;
reg				wm2;
reg				wm1;

reg				wh20;
reg				wh10;
reg				wh8;
reg				wh4;
reg				wh2;
reg				wh1;

reg				ww6;
reg				ww5;
reg				ww4;
reg				ww3;
reg				ww2;
reg				ww1;
reg				ww0;

wire	[5:0]	houral_din;
wire	[6:0]	houral_bus;

// Ver1.20 del
//reg				pre_wafg_pclk;
//reg				wafg_pclk;
//reg				wafg_pclk_1t;
//wire			wafg_pclk_pedge;
//reg				pre_int_ct_pclk;
//reg				int_ct_pclk;
//reg				int_ct_pclk_1t;
//wire			int_ct_pclk_pedge;


reg				wafg_rst;		// Ver1.20 add
reg				rifg_rst;		// Ver1.20 add
wire			w_wafg_rst;		// Ver1.20 add
wire			w_rifg_rst;		// Ver1.20 add


//--- logic

//RTCC0
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		rtce	<= 1'b0;
		cloe1	<= 1'b0;
		ampm	<= 1'b0;
		ct2		<= 1'b0;
		ct1		<= 1'b0;
		ct0		<= 1'b0;
	end
	else if (we_rtcc0) begin
		rtce	<= din[15];
		cloe1	<= din[13];
		ampm	<= din[11];
		ct2		<= din[10];
		ct1		<= din[9];
		ct0		<= din[8];
	end
	else begin
		rtce	<= rtce;
		cloe1	<= cloe1;
		ampm	<= ampm;
		ct2		<= ct2;
		ct1		<= ct1;
		ct0		<= ct0;
	end
end


//RTCC1
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		wale	<= 1'b0;
		walie	<= 1'b0;
		rwait	<= 1'b0;
	end
	else if (we_rtcc1) begin
		wale	<= din[7];
		walie	<= din[6];
		rwait	<= din[0];
	end
	else begin
		wale	<= wale;
		walie	<= walie;
		rwait	<= rwait;
	end
end

//wafg
// Ver1.20 del
//always @(posedge PCLK or negedge RTCRESB) begin
//	if (!RTCRESB) begin
//		pre_wafg_pclk	<= 1'b0;
//		wafg_pclk		<= 1'b0;
//		wafg_pclk_1t	<= 1'b0;
//	end
//	else begin
//		pre_wafg_pclk	<= wafg_rtc;
//		wafg_pclk		<= pre_wafg_pclk;
//		wafg_pclk_1t	<= wafg_pclk;
//	end
//end
//
//assign wafg_pclk_pedge	= (wafg_pclk && (!wafg_pclk_1t));


//////assign wafg = wafg_rtc;

/* modified by M.minami 

always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		wafg	<= 1'b0;
	end
//	else if (wafg_pclk_pedge) begin			//wafg_rtc is active	// Ver1.20 del
//		wafg	<= 1'b1;
//	end
	else if (we_rtcc1 && (!din[4])) begin	//write 1 mask
		wafg	<= 1'b0;
	end
	else if (wafg_rtc) begin				//wafg_rtc is active	// Ver1.20 add
		wafg	<= 1'b1;
	end
	else begin
		wafg	<= wafg;
	end
end
*/

//rifg
// Ver1.20 del
//always @(posedge PCLK or negedge RTCRESB) begin
//	if (!RTCRESB) begin
//		pre_int_ct_pclk	<= 1'b0;
//		int_ct_pclk		<= 1'b0;
//		int_ct_pclk_1t	<= 1'b0;
//	end
//	else begin
//		pre_int_ct_pclk	<= int_ct;
//		int_ct_pclk		<= pre_int_ct_pclk;
//		int_ct_pclk_1t	<= int_ct_pclk;
//	end
//end
//
//assign int_ct_pclk_pedge	= (int_ct_pclk && (!int_ct_pclk_1t));

//////assign rifg = rifg_rtc;

/* modified M.minami

always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		rifg	<= 1'b0;
	end
//	else if (int_ct_pclk_pedge) begin		//int_ct is active	// Ver1.20 del
//		rifg	<= 1'b1;
//	end
	else if (we_rtcc1 && (!din[3])) begin	//write 1 mask
		rifg	<= 1'b0;
	end
	else if (rifg_rtc) begin		//rifg_rtc is active	// Ver1.20 add
		rifg	<= 1'b1;
	end
	else begin
		rifg	<= rifg;
	end
end
*/

//cwait (cntwait sync PCLK)
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		cwait	<= 1'b0;
	end
	else if (cnt_writing) begin		// Ver1.10 add
		cwait	<= cwait;
	end
	else begin
		cwait	<= cntwait;
	end
end

/*
//RTCC2
always @(posedge PCLK or negedge PRESETZ) begin
	if (!PRESETZ) begin
		rinte	<= 1'b0;
		cloe2	<= 1'b0;
		ckdiv	<= 1'b0;
		ict2	<= 1'b0;
		ict1	<= 1'b0;
		ict0	<= 1'b0;
	end
	else if (we_rtcc2) begin
		rinte	<= din[15];
		cloe2	<= din[14];
		ckdiv	<= din[13];
		ict2	<= din[10];
		ict1	<= din[9];
		ict0	<= din[8];
	end
	else begin
		rinte	<= rinte;
		cloe2	<= cloe2;
		ckdiv	<= ckdiv;
		ict2	<= ict2;
		ict1	<= ict1;
		ict0	<= ict0;
	end
end
*/


//SUBCUD
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		dev		<= 1'b0;
		f6		<= 1'b0;
		f5		<= 1'b0;
		f4		<= 1'b0;
		f3		<= 1'b0;
		f2		<= 1'b0;
		f1		<= 1'b0;
		f0		<= 1'b0;
	end
	else if (we_subcud) begin
		dev		<= din[15];
		f6		<= din[14];
		f5		<= din[13];
		f4		<= din[12];
		f3		<= din[11];
		f2		<= din[10];
		f1		<= din[9];
		f0		<= din[8];
	end
	else begin
		dev		<= dev;
		f6		<= f6;
		f5		<= f5;
		f4		<= f4;
		f3		<= f3;
		f2		<= f2;
		f1		<= f1;
		f0		<= f0;
	end
end


//ALARMWM
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		wm40	<= 1'b0;
		wm20	<= 1'b0;
		wm10	<= 1'b0;
		wm8		<= 1'b0;
		wm4		<= 1'b0;
		wm2		<= 1'b0;
		wm1		<= 1'b0;
	end
	else if (we_alarmwm) begin
		wm40	<= din[6];
		wm20	<= din[5];
		wm10	<= din[4];
		wm8		<= din[3];
		wm4		<= din[2];
		wm2		<= din[1];
		wm1		<= din[0];
	end
	else begin
		wm40	<= wm40;
		wm20	<= wm20;
		wm10	<= wm10;
		wm8		<= wm8;
		wm4		<= wm4;
		wm2		<= wm2;
		wm1		<= wm1;
	end
end


//hour_din
assign houral_bus	= {ampm, din[13:8]};
assign houral_din	= (houral_bus == 7'b0010010) ? 6'b000000	//12am
					: (houral_bus == 7'b0110010) ? 6'b010010	//32pm
					: (houral_bus == 7'b0100001) ? 6'b010011	//21pm
					: (houral_bus == 7'b0100010) ? 6'b010100	//22pm
					: (houral_bus == 7'b0100011) ? 6'b010101	//23pm
					: (houral_bus == 7'b0100100) ? 6'b010110	//24pm
					: (houral_bus == 7'b0100101) ? 6'b010111	//25pm
					: (houral_bus == 7'b0100110) ? 6'b011000	//26pm
					: (houral_bus == 7'b0100111) ? 6'b011001	//27pm
					: (houral_bus == 7'b0101000) ? 6'b100000	//28pm
					: (houral_bus == 7'b0101001) ? 6'b100001	//29pm
					: (houral_bus == 7'b0110000) ? 6'b100010	//30pm
					: (houral_bus == 7'b0110001) ? 6'b100011	//31pm
					: din[13:8];

//ALARMWH
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		wh20	<= 1'b0;
		wh10	<= 1'b0;
		wh8		<= 1'b0;
		wh4		<= 1'b0;
		wh2		<= 1'b0;
		wh1		<= 1'b0;
	end
	else if (we_alarmwh) begin
		wh20	<= houral_din[5];
		wh10	<= houral_din[4];
		wh8		<= houral_din[3];
		wh4		<= houral_din[2];
		wh2		<= houral_din[1];
		wh1		<= houral_din[0];
	end
	else begin
		wh20	<= wh20;
		wh10	<= wh10;
		wh8		<= wh8;
		wh4		<= wh4;
		wh2		<= wh2;
		wh1		<= wh1;
	end
end


//ALARMWW
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		ww6		<= 1'b0;
		ww5		<= 1'b0;
		ww4		<= 1'b0;
		ww3		<= 1'b0;
		ww2		<= 1'b0;
		ww1		<= 1'b0;
		ww0		<= 1'b0;
	end
	else if (we_alarmww) begin
		ww6		<= din[6];
		ww5		<= din[5];
		ww4		<= din[4];
		ww3		<= din[3];
		ww2		<= din[2];
		ww1		<= din[1];
		ww0		<= din[0];
	end
	else begin
		ww6		<= ww6;
		ww5		<= ww5;
		ww4		<= ww4;
		ww3		<= ww3;
		ww2		<= ww2;
		ww1		<= ww1;
		ww0		<= ww0;
	end
end

reg[11:0] ITMCMP;

always @(posedge PCLK or negedge PRESETZ) begin
  if(!PRESETZ)begin
    RINTE <= 1'b0;
    ITMCMP <= 12'hFFF;
  end
  else if(we_itmc)begin
    RINTE <= din[15];
    ITMCMP <= din[11:0];
  end
end

// Ver1.20 add --------------
assign w_wafg_rst	= we_rtcc1 & (!din[4]);
assign w_rifg_rst	= we_rtcc1 & (!din[3]);

always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		wafg_rst	<= 1'b0;
	end
	else begin
		wafg_rst	<= w_wafg_rst;
	end
end

always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		rifg_rst	<= 1'b0;
	end
	else begin
		rifg_rst	<= w_rifg_rst;
	end
end
// --------------------------

endmodule





module QLK0RRTC0V3_DOUTSEL	(
	re_rtcc0,
	re_rtcc1,
//////	re_rtcc2,
//////	re_subc,
	re_sec,
	re_min,
	re_hour,
	re_week,
	re_day,
	re_month,
	re_year,
	re_subcud,
	re_alarmwm,
	re_alarmwh,
	re_alarmww,
	re_itmc,

	rtce,
	cloe1,
	ampm,
	ct2,
	ct1,
	ct0,

	wale,
	walie,
	wafg_rtc,
	rifg_rtc,
	cwait,
	rwait,

	RINTE_RTC,
	ITMCMP,
//	cloe2,
//	ckdiv,
//	ict2,
//	ict1,
//	ict0,

	dev,
	f6,
	f5,
	f4,
	f3,
	f2,
	f1,
	f0,

	wm40,
	wm20,
	wm10,
	wm8,
	wm4,
	wm2,
	wm1,

	wh20,
	wh10,
	wh8,
	wh4,
	wh2,
	wh1,

	ww6,
	ww5,
	ww4,
	ww3,
	ww2,
	ww1,
	ww0,

///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//	subbuf,
//////	subcount,

	secbuf,
	minbuf,
	hourbuf,
	weekbuf,
	daybuf,
	monbuf,
	yearbuf,

	dout
	);


//--- port direction
input			re_rtcc0;
input			re_rtcc1;
//////input			re_rtcc2;
//////input			re_subc;
input			re_sec;
input			re_min;
input			re_hour;
input			re_week;
input			re_day;
input			re_month;
input			re_year;
input			re_subcud;
input			re_alarmwm;
input			re_alarmwh;
input			re_alarmww;
input			re_itmc;

input			rtce;
input			cloe1;
input			ampm;
input			ct2;
input			ct1;
input			ct0;

input			wale;
input			walie;
input			wafg_rtc;
input			rifg_rtc;
input			cwait;
input			rwait;

input			RINTE_RTC;
input[11:0]		ITMCMP;
//input			cloe2;
//input			ckdiv;
//input			ict2;
//input			ict1;
//input			ict0;

input			dev;
input			f6;
input			f5;
input			f4;
input			f3;
input			f2;
input			f1;
input			f0;

input			wm40;
input			wm20;
input			wm10;
input			wm8;
input			wm4;
input			wm2;
input			wm1;

input			wh20;
input			wh10;
input			wh8;
input			wh4;
input			wh2;
input			wh1;

input			ww6;
input			ww5;
input			ww4;
input			ww3;
input			ww2;
input			ww1;
input			ww0;

///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//input	[15:0]	subbuf;
//////input	[15:0]	subcount;

input	[6:0]	secbuf;
input	[6:0]	minbuf;
input	[5:0]	hourbuf;
input	[2:0]	weekbuf;
input	[5:0]	daybuf;
input	[4:0]	monbuf;
input	[7:0]	yearbuf;

output	[15:0]	dout;


// reg & wire
wire	[6:0]	hour_bus_o;
wire	[5:0]	output_hour;
wire	[6:0]	houral_bus_o;
wire	[5:0]	output_houral;


//--- logic

//hour output data
assign hour_bus_o	= {ampm, hourbuf};
assign output_hour	= (hour_bus_o == 7'b0000000) ? 6'b010010	//12am
					: (hour_bus_o == 7'b0010010) ? 6'b110010	//32pm
					: (hour_bus_o == 7'b0010011) ? 6'b100001	//21pm
					: (hour_bus_o == 7'b0010100) ? 6'b100010	//22pm
					: (hour_bus_o == 7'b0010101) ? 6'b100011	//23pm
					: (hour_bus_o == 7'b0010110) ? 6'b100100	//24pm
					: (hour_bus_o == 7'b0010111) ? 6'b100101	//25pm
					: (hour_bus_o == 7'b0011000) ? 6'b100110	//26pm
					: (hour_bus_o == 7'b0011001) ? 6'b100111	//27pm
					: (hour_bus_o == 7'b0100000) ? 6'b101000	//28pm
					: (hour_bus_o == 7'b0100001) ? 6'b101001	//29pm
					: (hour_bus_o == 7'b0100010) ? 6'b110000	//30pm
					: (hour_bus_o == 7'b0100011) ? 6'b110001	//31pm
					: hourbuf;

assign houral_bus_o	= {ampm, wh20, wh10, wh8, wh4, wh2, wh1};
assign output_houral	= (houral_bus_o == 7'b0000000) ? 6'b010010	//12am
					: (houral_bus_o == 7'b0010010) ? 6'b110010	//32pm
					: (houral_bus_o == 7'b0010011) ? 6'b100001	//21pm
					: (houral_bus_o == 7'b0010100) ? 6'b100010	//22pm
					: (houral_bus_o == 7'b0010101) ? 6'b100011	//23pm
					: (houral_bus_o == 7'b0010110) ? 6'b100100	//24pm
					: (houral_bus_o == 7'b0010111) ? 6'b100101	//25pm
					: (houral_bus_o == 7'b0011000) ? 6'b100110	//26pm
					: (houral_bus_o == 7'b0011001) ? 6'b100111	//27pm
					: (houral_bus_o == 7'b0100000) ? 6'b101000	//28pm
					: (houral_bus_o == 7'b0100001) ? 6'b101001	//29pm
					: (houral_bus_o == 7'b0100010) ? 6'b110000	//30pm
					: (houral_bus_o == 7'b0100011) ? 6'b110001	//31pm
					: {wh20, wh10, wh8, wh4, wh2, wh1};

//read data
////
////
wire[13:0] sel_reg = {
re_itmc,
re_alarmww,
re_alarmwh,
re_alarmwm,
re_subcud,
re_year,
re_month,
re_day,
re_week,
re_hour,
re_min,
re_sec,
re_rtcc1,
re_rtcc0
};

reg[15:0] dout;
always@(sel_reg or rtce or cloe1 or ampm or ct2 or ct1 or ct0 or wale or walie or wafg_rtc or rifg_rtc or cwait or rwait
        or secbuf or minbuf or output_hour or weekbuf or daybuf or monbuf or yearbuf
        or dev or f6 or f5 or f4 or f3 or f2 or f1 or f0
        or wm40 or wm20 or wm10 or wm8 or wm4 or wm2 or wm1
        or output_houral or  ww6 or ww5 or ww4 or ww3 or ww2 or ww1 or ww0
        or RINTE_RTC or  ITMCMP)
case ( sel_reg )
  14'b00000000000001: dout[15:0] = {rtce, 1'h0, cloe1, 1'b0, ampm, ct2, ct1, ct0, 8'h00};
  14'b00000000000010: dout[15:0] = {8'h00, wale, walie, 1'b0, wafg_rtc, rifg_rtc, 1'h0, cwait, rwait};
  14'b00000000000100: dout[15:0] = {9'h000, secbuf};
  14'b00000000001000: dout[15:0] = {1'h0, minbuf, 8'h00};
  14'b00000000010000: dout[15:0] = {10'h000, output_hour};
  14'b00000000100000: dout[15:0] = {5'h00, weekbuf, 8'h00};
  14'b00000001000000: dout[15:0] = {10'h000, daybuf};
  14'b00000010000000: dout[15:0] = {3'h0, monbuf, 8'h00};
  14'b00000100000000: dout[15:0] = {8'h00, yearbuf};
  14'b00001000000000: dout[15:0] = {dev, f6, f5, f4, f3, f2, f1, f0, 8'h00};
  14'b00010000000000: dout[15:0] = {9'h000, wm40, wm20, wm10, wm8, wm4, wm2, wm1};
  14'b00100000000000: dout[15:0] = {2'h0, output_houral, 8'h00};
  14'b01000000000000: dout[15:0] = {9'h000, ww6, ww5, ww4, ww3, ww2, ww1, ww0};
  14'b10000000000000: dout[15:0] = {RINTE_RTC, 3'b0, ITMCMP[11:0]};
  default: dout[15:0] = 16'h0000 ;
endcase

/*
assign dout	= (re_rtcc0)	? {rtce, 1'h0, cloe1, 1'b0, ampm, ct2, ct1, ct0, 8'h00}
			: (re_rtcc1)	? {8'h00, wale, walie, 1'b0, wafg, rifg, 1'h0, cwait, rwait}
//			: (re_rtcc2)	? {rinte, cloe2, ckdiv, 2'h0, ict2, ict1, ict0, 8'h00}
///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//			: (re_subc)		? {subbuf}
//			: (re_subc)		? {subcount}

			: (re_sec)		? {9'h000, secbuf}
			: (re_min)		? {1'h0, minbuf, 8'h00}
			: (re_hour)		? {10'h000, output_hour}
			: (re_week)		? {5'h00, weekbuf, 8'h00}
			: (re_day)		? {10'h000, daybuf}
			: (re_month)	? {3'h0, monbuf, 8'h00}
			: (re_year)		? {8'h00, yearbuf}
			: (re_subcud)	? {dev, f6, f5, f4, f3, f2, f1, f0, 8'h00}
			: (re_alarmwm)	? {9'h000, wm40, wm20, wm10, wm8, wm4, wm2, wm1}
			: (re_alarmwh)	? {2'h0, output_houral, 8'h00}

			: (re_alarmww)	? {9'h000, ww6, ww5, ww4, ww3, ww2, ww1, ww0}
			: (re_itmc)	? {RINTE_RTC, 3'b0, ITMCMP[11:0]}
			: 16'h0000;
*/


endmodule





module QLK0RRTC0V3_WERDBUF	(
	PCLK,
	RTCRESB,

	we_sec,
	we_min,
	we_hour,
	we_week,
	we_day,
	we_month,
	we_year,

	din,

	ampm,

///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//	subcount,

	seccount,
	mincount,
	hourcount,
	weekcount,
	daycount,
	moncount,
	yearcount,
	load_sec_trg,
	load_min_trg,
	load_hour_trg,
	load_week_trg,
	load_day_trg,
	load_mon_trg,
	load_year_trg,
///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//	subbuf,

	secbuf,
	minbuf,
	hourbuf,
	weekbuf,
	daybuf,
	monbuf,
	yearbuf,
	load_seccount,
	load_mincount,
	load_hourcount,
	load_weekcount,
	load_daycount,
	load_moncount,
	load_yearcount,
	cnt_writing		// Ver1.10 add
	);

//--- port direction
input			PCLK;
input			RTCRESB;

input			we_sec;
input			we_min;
input			we_hour;
input			we_week;
input			we_day;
input			we_month;
input			we_year;

input	[15:0]	din;

input			ampm;

///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//input	[15:0]	subcount;

input	[6:0]	seccount;
input	[6:0]	mincount;
input	[5:0]	hourcount;
input	[2:0]	weekcount;
input	[5:0]	daycount;
input	[4:0]	moncount;
input	[7:0]	yearcount;
input			load_sec_trg;
input			load_min_trg;
input			load_hour_trg;
input			load_week_trg;
input			load_day_trg;
input			load_mon_trg;
input			load_year_trg;

///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//output	[15:0]	subbuf;

output	[6:0]	secbuf;
output	[6:0]	minbuf;
output	[5:0]	hourbuf;
output	[2:0]	weekbuf;
output	[5:0]	daybuf;
output	[4:0]	monbuf;
output	[7:0]	yearbuf;
output			load_seccount;
output			load_mincount;
output			load_hourcount;
output			load_weekcount;
output			load_daycount;
output			load_moncount;
output			load_yearcount;
output			cnt_writing;		// Ver1.10 add


//--- reg, wire
///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//reg		[15:0]	subbuf;

reg		[6:0]	secbuf;
reg		[6:0]	minbuf;
reg		[5:0]	hourbuf;
reg		[2:0]	weekbuf;
reg		[5:0]	daybuf;
reg		[4:0]	monbuf;
reg		[7:0]	yearbuf;

wire	[5:0]	hour_din;
wire	[6:0]	hour_bus;

//reg			load_subend_pclk;
//reg			load_subcount;
reg			load_secend_pclk;
reg			load_seccount;
reg			load_minend_pclk;
reg			load_mincount;
reg			load_hourend_pclk;
reg			load_hourcount;
reg			load_weekend_pclk;
reg			load_weekcount;
reg			load_dayend_pclk;
reg			load_daycount;
reg			load_monend_pclk;
reg			load_moncount;
reg			load_yearend_pclk;
reg			load_yearcount;



//--- logic

//load_xxxend async(RTCCLK->PCLK) latch -> load_xxxend_pclk
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_secend_pclk	<= 1'b0;
		load_minend_pclk	<= 1'b0;
		load_hourend_pclk	<= 1'b0;
		load_weekend_pclk	<= 1'b0;
		load_dayend_pclk	<= 1'b0;
		load_monend_pclk	<= 1'b0;
		load_yearend_pclk	<= 1'b0;
	end
	else begin
		load_secend_pclk	<= load_sec_trg;
		load_minend_pclk	<= load_min_trg;
		load_hourend_pclk	<= load_hour_trg;
		load_weekend_pclk	<= load_week_trg;
		load_dayend_pclk	<= load_day_trg;
		load_monend_pclk	<= load_mon_trg;
		load_yearend_pclk	<= load_year_trg;
	end
end

//load_xxxcount

//sec
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_seccount	<= 1'b0;
	end
	else if (we_sec) begin
		load_seccount	<= 1'b1;
	end
	else if (load_secend_pclk) begin
		load_seccount	<= 1'b0;
	end
	else begin
		load_seccount	<= load_seccount;
	end
end

//min
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_mincount	<= 1'b0;
	end
	else if (we_min) begin
		load_mincount	<= 1'b1;
	end
	else if (load_minend_pclk) begin
		load_mincount	<= 1'b0;
	end
	else begin
		load_mincount	<= load_mincount;
	end
end

//hour
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_hourcount	<= 1'b0;
	end
	else if (we_hour) begin
		load_hourcount	<= 1'b1;
	end
	else if (load_hourend_pclk) begin
		load_hourcount	<= 1'b0;
	end
	else begin
		load_hourcount	<= load_hourcount;
	end
end

//week
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_weekcount	<= 1'b0;
	end
	else if (we_week) begin
		load_weekcount	<= 1'b1;
	end
	else if (load_weekend_pclk) begin
		load_weekcount	<= 1'b0;
	end
	else begin
		load_weekcount	<= load_weekcount;
	end
end

//day
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_daycount	<= 1'b0;
	end
	else if (we_day) begin
		load_daycount	<= 1'b1;
	end
	else if (load_dayend_pclk) begin
		load_daycount	<= 1'b0;
	end
	else begin
		load_daycount	<= load_daycount;
	end
end

//mon
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_moncount	<= 1'b0;
	end
	else if (we_month) begin
		load_moncount	<= 1'b1;
	end
	else if (load_monend_pclk) begin
		load_moncount	<= 1'b0;
	end
	else begin
		load_moncount	<= load_moncount;
	end
end

//year
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_yearcount	<= 1'b0;
	end
	else if (we_year) begin
		load_yearcount	<= 1'b1;
	end
	else if (load_yearend_pclk) begin
		load_yearcount	<= 1'b0;
	end
	else begin
		load_yearcount	<= load_yearcount;
	end
end


//buffer write
///////////////////////////////////////////////////
// V2から変更
// サブカウント値のリードをsubbuf経由でPCLKでリクロック：
// tcount.subc.subcount[15:0] → werdbuf.subbuf[15:0] → doutsel
// から、リクロックなし：
// tcount.subc.subcount[15:0] → doutsel
// に変更。
//
// ※ 仕様上「動作中に読み出しを行った場合保証されない」
// 　 となっており、PCLKでリクロックする必要はない。
///////////////////////////////////////////////////
//subbuf
//always @(posedge PCLK or negedge RTCRESB) begin
//	if (!RTCRESB) begin
//		subbuf	<= 16'h0000;
//	end
//	else if (we_sec || load_seccount || load_secend_pclk) begin	//sec write clear
//		subbuf	<= 16'h0000;
//	end
//	else begin
//		subbuf	<= subcount;
//	end
//end


//secbuf
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		secbuf	<= 7'h00;
	end
	else if (we_sec) begin								//buf write
		secbuf	<= din[6:0];
	end
	else if (load_seccount || load_secend_pclk) begin	//buf keep until counter write
		secbuf	<= secbuf;
	end
	else begin
		secbuf	<= seccount;
	end
end


//minbuf
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		minbuf	<= 7'h00;
	end
	else if (we_min) begin								//buf write
		minbuf	<= din[14:8];
	end
	else if (load_mincount || load_minend_pclk) begin	//buf keep until counter write
		minbuf	<= minbuf;
	end
	else begin
		minbuf	<= mincount;
	end
end


//hour_din
assign hour_bus	= {ampm, din[5:0]};
assign hour_din	= (hour_bus == 7'b0010010) ? 6'b000000	//12am
				: (hour_bus == 7'b0110010) ? 6'b010010	//32pm
				: (hour_bus == 7'b0100001) ? 6'b010011	//21pm
				: (hour_bus == 7'b0100010) ? 6'b010100	//22pm
				: (hour_bus == 7'b0100011) ? 6'b010101	//23pm
				: (hour_bus == 7'b0100100) ? 6'b010110	//24pm
				: (hour_bus == 7'b0100101) ? 6'b010111	//25pm
				: (hour_bus == 7'b0100110) ? 6'b011000	//26pm
				: (hour_bus == 7'b0100111) ? 6'b011001	//27pm
				: (hour_bus == 7'b0101000) ? 6'b100000	//28pm
				: (hour_bus == 7'b0101001) ? 6'b100001	//29pm
				: (hour_bus == 7'b0110000) ? 6'b100010	//30pm
				: (hour_bus == 7'b0110001) ? 6'b100011	//31pm
				: din[5:0];

//hourbuf
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		hourbuf	<= 6'h00;
	end
	else if (we_hour) begin								//buf write
		hourbuf	<= hour_din[5:0];
	end
	else if (load_hourcount || load_hourend_pclk) begin	//buf keep until counter write
		hourbuf	<= hourbuf;
	end
	else begin
		hourbuf	<= hourcount;
	end
end


//weekbuf
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		weekbuf	<= 3'h0;
	end
	else if (we_week) begin								//buf write
		weekbuf	<= din[10:8];
	end
	else if (load_weekcount || load_weekend_pclk) begin	//buf keep until counter write
		weekbuf	<= weekbuf;
	end
	else begin
		weekbuf	<= weekcount;
	end
end


//daybuf
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		daybuf	<= 6'h01;
	end
	else if (we_day) begin								//buf write
		daybuf	<= din[5:0];
	end
	else if (load_daycount || load_dayend_pclk) begin	//buf keep until counter write
		daybuf	<= daybuf;
	end
	else begin
		daybuf	<= daycount;
	end
end


//monbuf
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		monbuf	<= 5'h01;
	end
	else if (we_month) begin							//buf write
		monbuf	<= din[12:8];
	end
	else if (load_moncount || load_monend_pclk) begin	//buf keep until counter write
		monbuf	<= monbuf;
	end
	else begin
		monbuf	<= moncount;
	end
end


//yearbuf
always @(posedge PCLK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		yearbuf	<= 8'h00;
	end
	else if (we_year) begin								//buf write
		yearbuf	<= din[7:0];
	end
	else if (load_yearcount || load_yearend_pclk) begin	//buf keep until counter write
		yearbuf	<= yearbuf;
	end
	else begin
		yearbuf	<= yearcount;
	end
end


//-------------------------------------------------------
// Ver1.10 Addition
//-------------------------------------------------------
wire	sec_writing;
wire	min_writing;
wire	hour_writing;
wire	week_writing;
wire	day_writing;
wire	mon_writing;
wire	year_writing;
wire	cnt_writing;

assign sec_writing	= load_seccount  || load_secend_pclk ;
assign min_writing	= load_mincount  || load_minend_pclk ;
assign hour_writing	= load_hourcount || load_hourend_pclk ;
assign week_writing	= load_weekcount || load_weekend_pclk ;
assign day_writing	= load_daycount  || load_dayend_pclk ;
assign mon_writing	= load_moncount  || load_monend_pclk ;
assign year_writing	= load_yearcount || load_yearend_pclk ;

assign cnt_writing	=  sec_writing || min_writing || hour_writing || week_writing ||
			   day_writing || mon_writing || year_writing ;


endmodule





module QLK0RRTC0V3_CNT	(
	RT0LPM,
	RTCCLK,
	INTRCLK,
	RTCRESB,
	PRESETZ,
        CKSEL,
	RT0TEN,
	SVMOD,
//	CLK32KHZ,
	CLK1HZ,

	rtce,
	cloe1,
	ct2,
	ct1,
	ct0,
	wale,
	walie,
//	wafg,			// Ver1.20 del
	rwait,
	RINTE,
	ITMCMP,
//	cloe2,
//	ckdiv,
//	ict2,
//	ict1,
//	ict0,
	dev,
	f6,
	f5,
	f4,
	f3,
	f2,
	f1,
	f0,
	wm40,
	wm20,
	wm10,
	wm8,
	wm4,
	wm2,
	wm1,
	wh20,
	wh10,
	wh8,
	wh4,
	wh2,
	wh1,
	ww6,
	ww5,
	ww4,
	ww3,
	ww2,
	ww1,
	ww0,

//////	subcount,
	secbuf,
	seccount,
	minbuf,
	mincount,
	hourbuf,
	hourcount,
	weekbuf,
	weekcount,
	daybuf,
	daycount,
	monbuf,
	moncount,
	yearbuf,
	yearcount,
	load_seccount,
	load_sec_trg,
	load_mincount,
	load_min_trg,
	load_hourcount,
	load_hour_trg,
	load_weekcount,
	load_week_trg,
	load_daycount,
	load_day_trg,
	load_moncount,
	load_mon_trg,
	load_yearcount,
	load_year_trg,
	wafg_rtc,
//	int_ct,					// Ver1.20 del
	rifg_rtc,				// Ver1.20 add
	wafg_rst,				// Ver1.20 add
	rifg_rst,				// Ver1.20 add
	cntwait,
	intr,
	INTRTCI,
	RINTE_RTC,
	RT0MON0,
	RT0MON1
	);


//--- port direction
input			RT0LPM;
input			RTCCLK;
input			INTRCLK;
input			RTCRESB;
input			PRESETZ;
input			CKSEL;
input			RT0TEN;
input			SVMOD;
//output			CLK32KHZ;
output			CLK1HZ;

input			rtce;
input			cloe1;
input			ct2;
input			ct1;
input			ct0;
input			wale;
input			walie;
//input			wafg;			// Ver1.20 del
input			rwait;
input			RINTE;
input[11:0]		ITMCMP;
//input			cloe2;
//input			ckdiv;
//input			ict2;
//input			ict1;
//input			ict0;
input			dev;
input			f6;
input			f5;
input			f4;
input			f3;
input			f2;
input			f1;
input			f0;
input			wm40;
input			wm20;
input			wm10;
input			wm8;
input			wm4;
input			wm2;
input			wm1;
input			wh20;
input			wh10;
input			wh8;
input			wh4;
input			wh2;
input			wh1;
input			ww6;
input			ww5;
input			ww4;
input			ww3;
input			ww2;
input			ww1;
input			ww0;

//////output	[15:0]	subcount;
input	[6:0]	secbuf;
output	[6:0]	seccount;
input	[6:0]	minbuf;
output	[6:0]	mincount;
input	[5:0]	hourbuf;
output	[5:0]	hourcount;
input	[2:0]	weekbuf;
output	[2:0]	weekcount;
input	[5:0]	daybuf;
output	[5:0]	daycount;
input	[4:0]	monbuf;
output	[4:0]	moncount;
input	[7:0]	yearbuf;
output	[7:0]	yearcount;
input			load_seccount;
output			load_sec_trg;
input			load_mincount;
output			load_min_trg;
input			load_hourcount;
output			load_hour_trg;
input			load_weekcount;
output			load_week_trg;
input			load_daycount;
output			load_day_trg;
input			load_moncount;
output			load_mon_trg;
input			load_yearcount;
output			load_year_trg;
output			wafg_rtc;
//output			int_ct;				// Ver1.20 del
output			rifg_rtc;				// Ver1.20 add
input			wafg_rst;				// Ver1.20 add
input			rifg_rst;				// Ver1.20 add
output			cntwait;
output			intr;
output			INTRTCI;
output			RINTE_RTC;
output			RT0MON0;
output			RT0MON1;

wire svmod_rtc, rtce_rtc,
     seceq00, secdev0en, subtop, sub500ms,
     clken_sec, clken_min, clken_hour, clken_week,
     clken_day, clken_mon, clken_year, clken_all_cnt,
     seceq59, hour_cu, day_cu, leapyear, mon_cu, year_cu, pulse1hz;

wire RTC_SELCK;
wire RT0LPM_RTCCLK_B;

QLK0RRTC0V3_CLKSEL clksel (.CKSEL(CKSEL), .RTCCLK(RTCCLK), .INTRCLK(INTRCLK), .RTC_SELCK(RTC_SELCK));

QLK0RRTC0V3_SYNC_RT0LPM sync_rt0tlpm(.RTC_SELCK(RTC_SELCK), .RTCRESB(RTCRESB), .RT0LPM(RT0LPM),
                                      .RT0LPM_RTCCLK_B(RT0LPM_RTCCLK_B));

QLK0RRTC0V3_SUBC subc	(
	.RT0TEN(RT0TEN),
        .RT0LPM_RTCCLK_B(RT0LPM_RTCCLK_B),
	.yearcount(yearcount),
	.mincount(mincount),
	.RTC_SELCK(RTC_SELCK),
	.RTCRESB(RTCRESB),

	.svmod_rtc(svmod_rtc),
	.load_sec_trg(load_sec_trg),
	.rtce_rtc(rtce_rtc),
	.cloe1(cloe1),
	.dev(dev),
	.f6(f6),
	.f5(f5),
	.f4(f4),
	.f3(f3),
	.f2(f2),
	.f1(f1),
	.f0(f0),
	.seceq00(seceq00),
	.secdev0en(secdev0en),
//////	.subcount(subcount),
	.subtop(subtop),
	.sub500ms(sub500ms),
	.CLK1HZ(CLK1HZ),
	.RT0MON0(RT0MON0),
	.pulse1hz(pulse1hz)
	);



QLK0RRTC0V3_CNTCLKGE cntclkge	(
	.RT0LPM_RTCCLK_B(RT0LPM_RTCCLK_B),
	.RTC_SELCK(RTC_SELCK),
	.RTCRESB(RTCRESB),
	.SVMOD(SVMOD),
	.load_seccount(load_seccount),
	.load_mincount(load_mincount),
	.load_hourcount(load_hourcount),
	.load_weekcount(load_weekcount),
	.load_daycount(load_daycount),
	.load_moncount(load_moncount),
	.load_yearcount(load_yearcount),
	.rtce(rtce),
	.rwait(rwait),
	.subtop(subtop),

	.svmod_rtc(svmod_rtc),
	.cntwait(cntwait),
	.rtce_rtc(rtce_rtc),
	.load_sec_trg(load_sec_trg),
	.load_min_trg(load_min_trg),
	.load_hour_trg(load_hour_trg),
	.load_week_trg(load_week_trg),
	.load_day_trg(load_day_trg),
	.load_mon_trg(load_mon_trg),
	.load_year_trg(load_year_trg),
	.clken_sec(clken_sec),
	.clken_min(clken_min),
	.clken_hour(clken_hour),
	.clken_week(clken_week),
	.clken_day(clken_day),
	.clken_mon(clken_mon),
	.clken_year(clken_year),
	.clken_all_cnt(clken_all_cnt)
	);



QLK0RRTC0V3_SECC secc	(
	.RTC_SELCK(RTC_SELCK),
	.RTCRESB(RTCRESB),
	.clken_sec(clken_sec),

	.load_sec_trg(load_sec_trg),
	.secbuf(secbuf),
	.clken_all_cnt(clken_all_cnt),

	.seceq59(seceq59),
	.seceq00(seceq00),
	.secdev0en(secdev0en),
	.seccount(seccount)
	);



QLK0RRTC0V3_MINC minc	(
	.RTC_SELCK(RTC_SELCK),
	.RTCRESB(RTCRESB),
	.clken_min(clken_min),

	.load_min_trg(load_min_trg),
	.minbuf(minbuf),
	.clken_all_cnt(clken_all_cnt),
	.seceq59(seceq59),
	.hour_cu(hour_cu),
	.mincount(mincount)
	);



QLK0RRTC0V3_HOURC hourc	(
	.RTC_SELCK(RTC_SELCK),
	.RTCRESB(RTCRESB),
	.clken_hour(clken_hour),

	.load_hour_trg(load_hour_trg),
	.hourbuf(hourbuf),
	.clken_all_cnt(clken_all_cnt),

	.hour_cu(hour_cu),
	.day_cu(day_cu),
	.hourcount(hourcount)
	);



QLK0RRTC0V3_WEEKC weekc	(
	.RTC_SELCK(RTC_SELCK),
	.RTCRESB(RTCRESB),
	.clken_week(clken_week),

	.load_week_trg(load_week_trg),
	.weekbuf(weekbuf),
        .clken_all_cnt(clken_all_cnt),
	.day_cu(day_cu),
	.weekcount(weekcount)
	);



QLK0RRTC0V3_DAYC dayc	(
	.RTC_SELCK(RTC_SELCK),
	.RTCRESB(RTCRESB),
	.clken_day(clken_day),

	.load_day_trg(load_day_trg),
	.daybuf(daybuf),
	.day_cu(day_cu),
	.moncount(moncount),
	.leapyear(leapyear),
        .clken_all_cnt(clken_all_cnt),
	.mon_cu(mon_cu),
	.daycount(daycount)
	);



QLK0RRTC0V3_MONC monc	(
	.RTC_SELCK(RTC_SELCK),
	.RTCRESB(RTCRESB),
	.clken_mon(clken_mon),

	.load_mon_trg(load_mon_trg),
	.monbuf(monbuf),
        .clken_all_cnt(clken_all_cnt),
	.mon_cu(mon_cu),
	.year_cu(year_cu),
	.moncount(moncount)
	);



QLK0RRTC0V3_YEARC yearc	(
	.RTC_SELCK(RTC_SELCK),
	.RTCRESB(RTCRESB),
	.clken_year(clken_year),

	.load_year_trg(load_year_trg),
	.yearbuf(yearbuf),
	.year_cu(year_cu),
        .clken_all_cnt(clken_all_cnt),
	.leapyear(leapyear),
	.yearcount(yearcount)
	);


QLK0RRTC0V3_INTVLCOUNNT intvlc(
.RT0TEN(RT0TEN), .RTC_SELCK(RTC_SELCK), .PRESETZ(PRESETZ), .svmod_rtc(svmod_rtc),
.RT0LPM_RTCCLK_B(RT0LPM_RTCCLK_B), .ITMCMP(ITMCMP),
.hourcount(hourcount), .daycount(daycount), .RINTE(RINTE), .RINTE_RTC(RINTE_RTC), .INTRTCI(INTRTCI), .RT0TMON1(RT0MON1));


/*
QLK0RRTC0V3_INTVLCOUNNT intvlc(
	.RTCRESB(RTCRESB),
	.PRESETZ(PRESETZ),
	.RT0TEN(RT0TEN),

	.svmod_rtc(svmod_rtc),
	.rinte(rinte),
	.cloe2(cloe2),
	.cloe0(cloe0),
	.ckdiv(ckdiv),
	.CLK32KHZ(CLK32KHZ),
	.CKDIVO(CKDIVO),
	.intvl_en(intvl_en),

	.int_1_95ms(int_1_95ms),
	.int_3_91ms(int_3_91ms),
	.int_7_81ms(int_7_81ms),
	.int_15_6ms(int_15_6ms),
	.int_31ms(int_31ms),
	.int_62ms(int_62ms),
	.int_125ms(int_125ms)
	);

*/

//QLK0RRTC0V3_INT int	(
QLK0RRTC0V3_INT intctrtc	(	// V2で変更(VCSエラー対策)
	.RTC_SELCK(RTC_SELCK),
	.RTCRESB(RTCRESB),
	.RT0TEN(RT0TEN),	// Ver1.20 add
	.INTRCLK(INTRCLK),		// Ver1.20 add

	.svmod_rtc(svmod_rtc),
	.rtce_rtc(rtce_rtc),
//	.intvl_en(intvl_en),
	.ct2(ct2),
	.ct1(ct1),
	.ct0(ct0),
	.wale(wale),
	.walie(walie),
//	.wafg(wafg),			// Ver1.20 del
//	.rinte(rinte),
//	.ict2(ict2),
//	.ict1(ict1),
//	.ict0(ict0),
	.wm40(wm40),
	.wm20(wm20),
	.wm10(wm10),
	.wm8(wm8),
	.wm4(wm4),
	.wm2(wm2),
	.wm1(wm1),
	.wh20(wh20),
	.wh10(wh10),
	.wh8(wh8),
	.wh4(wh4),
	.wh2(wh2),
	.wh1(wh1),
	.ww6(ww6),
	.ww5(ww5),
	.ww4(ww4),
	.ww3(ww3),
	.ww2(ww2),
	.ww1(ww1),
	.ww0(ww0),

	.seceq00(seceq00),
	.mincount(mincount),
	.hourcount(hourcount),
	.weekcount(weekcount),
	.sub500ms(sub500ms),
	.subtop(subtop),
	.seceq59(seceq59),
	.hour_cu(hour_cu),
	.day_cu(day_cu),
	.mon_cu(mon_cu),

//	.int_1_95ms(int_1_95ms),
//	.int_3_91ms(int_3_91ms),
//	.int_7_81ms(int_7_81ms),
//	.int_15_6ms(int_15_6ms),
//	.int_31ms(int_31ms),
//	.int_62ms(int_62ms),
//	.int_125ms(int_125ms),

//	.CLK32KHZ(CLK32KHZ),
	.wafg_rtc(wafg_rtc),
	.rifg_rtc(rifg_rtc),		// Ver1.20 add
	.wafg_rst(wafg_rst),		// Ver1.20 add
	.rifg_rst(rifg_rst),		// Ver1.20 add
//	.int_ct(int_ct),			// Ver1.20 del
	.intr(intr),
//	.intr2(intr2),
	.pulse1hz(pulse1hz)
	);

endmodule





module QLK0RRTC0V3_CNTCLKGE	(
	RT0LPM_RTCCLK_B,
	RTC_SELCK,
	RTCRESB,
	SVMOD,

	load_seccount,
	load_mincount,
	load_hourcount,
	load_weekcount,
	load_daycount,
	load_moncount,
	load_yearcount,
	rtce,
	rwait,
	subtop,

	svmod_rtc,
	cntwait,
	rtce_rtc,
	load_sec_trg,
	load_min_trg,
	load_hour_trg,
	load_week_trg,
	load_day_trg,
	load_mon_trg,
	load_year_trg,
	clken_sec,
	clken_min,
	clken_hour,
	clken_week,
	clken_day,
	clken_mon,
	clken_year,
	clken_all_cnt
	);

//--- port direction
input			RT0LPM_RTCCLK_B;
input			RTC_SELCK;
input			RTCRESB;
input			SVMOD;

input			load_seccount;
input			load_mincount;
input			load_hourcount;
input			load_weekcount;
input			load_daycount;
input			load_moncount;
input			load_yearcount;
input			rtce;
input			rwait;
input			subtop;

output			svmod_rtc;
output			cntwait;
output			rtce_rtc;
output			load_sec_trg;
output			load_min_trg;
output			load_hour_trg;
output			load_week_trg;
output			load_day_trg;
output			load_mon_trg;
output			load_year_trg;
output			clken_sec;
output			clken_min;
output			clken_hour;
output			clken_week;
output			clken_day;
output			clken_mon;
output			clken_year;
output			clken_all_cnt;


//--- reg, wire
wire			clken_sec;
wire			clken_min;
wire			clken_hour;
wire			clken_week;
wire			clken_day;
wire			clken_mon;
wire			clken_year;
wire			subtop_trg;
reg				load_sec_trg;
reg				load_min_trg;
reg				load_hour_trg;
reg				load_week_trg;
reg				load_day_trg;
reg				load_mon_trg;
reg				load_year_trg;
wire			carry_trg_pre;		// add Ver1.30
wire			carry_trg;
reg				subtop_wait;
wire			subtop_wait_trg;
reg				cntwait;
reg				rtce_rtc;
reg				svmod_rtc;


//--- logic

//rwait sync RTCCLK -> cntwait

wire wd_cntwait;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
  if(!RTCRESB)begin
    cntwait <= 1'b0;
  end
  else if (RT0LPM_RTCCLK_B) begin
    cntwait <= wd_cntwait;
  end
end

/*
always @(posedge RTC_SELCK or negedge RTCRESB) begin
  if(!RTCRESB)begin
    cntwait <= 1'b0;
  end
  else if (rtce_rtc && (!svmod_rtc)) begin
    cntwait <= rwait;
  end
end
*/

//rtce sync RTCCLK -> rtce_rtc
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		rtce_rtc	<= 1'b0;
	end
	else if(RT0LPM_RTCCLK_B)begin
		rtce_rtc	<= rtce;
	end
end



wire wd_load_sec_trg, wd_load_min_trg, wd_load_hour_trg, wd_load_week_trg, 
     wd_load_day_trg, wd_load_mon_trg, wd_load_year_trg, wd_subtop_wait;

QLK0RRTC0V3_CNTCLKGE_SUB cntclkge_sub(
	.svmod_rtc(svmod_rtc),
	.rtce_rtc(rtce_rtc),
	.rwait(rwait),
	.wd_cntwait(wd_cntwait),
	.cntwait(cntwait),
	.subtop(subtop),
	.subtop_wait(subtop_wait),
	.load_seccount(load_seccount),
	.load_mincount(load_mincount),
	.load_hourcount(load_hourcount),
	.load_weekcount(load_weekcount),
	.load_daycount(load_daycount),
	.load_moncount(load_moncount),
	.load_yearcount(load_yearcount),
	.load_sec_trg(load_sec_trg),
	.load_min_trg(load_min_trg),
	.load_hour_trg(load_hour_trg),
	.load_week_trg(load_week_trg),
	.load_day_trg(load_day_trg),
	.load_mon_trg(load_mon_trg),
	.load_year_trg(load_year_trg),
	.wd_load_sec_trg(wd_load_sec_trg),
	.wd_load_min_trg(wd_load_min_trg),
	.wd_load_hour_trg(wd_load_hour_trg),
	.wd_load_week_trg(wd_load_week_trg),
	.wd_load_day_trg(wd_load_day_trg),
	.wd_load_mon_trg(wd_load_mon_trg),
	.wd_load_year_trg(wd_load_year_trg),
	.wd_subtop_wait(wd_subtop_wait)
);

//for xxxbuf write clock enable

/////////////////////// wire wd_load_sec_trg = (rtce_rtc && (!svmod_rtc)) ? load_seccount : load_sec_trg;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
  if (!RTCRESB) begin
    load_sec_trg  <= 1'b0;
  end
  else if(RT0LPM_RTCCLK_B)begin
    load_sec_trg <= wd_load_sec_trg;
  end
end


/////////////////////// wire wd_load_min_trg = (rtce_rtc && (!svmod_rtc)) ? load_mincount : load_min_trg;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_min_trg	<= 1'b0;
	end
	else if(RT0LPM_RTCCLK_B)begin
		load_min_trg	<= wd_load_min_trg;
	end
end

/////////////////////// wire wd_load_hour_trg = (rtce_rtc && (!svmod_rtc)) ? load_hourcount : load_hour_trg;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_hour_trg	<= 1'b0;
	end
	else if(RT0LPM_RTCCLK_B)begin
		load_hour_trg	<= wd_load_hour_trg;
	end
end


/////////////////////// wire wd_load_week_trg = (rtce_rtc && (!svmod_rtc)) ? load_weekcount : load_week_trg;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_week_trg	<= 1'b0;
	end
	else if(RT0LPM_RTCCLK_B)begin
		load_week_trg	<= wd_load_week_trg;
	end
end


/////////////////////// wire wd_load_day_trg = (rtce_rtc && (!svmod_rtc)) ? load_daycount : load_day_trg;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_day_trg	<= 1'b0;
	end
	else if(RT0LPM_RTCCLK_B)begin
		load_day_trg	<= wd_load_day_trg;
	end
end

/////////////////////// wire wd_load_mon_trg = (rtce_rtc && (!svmod_rtc)) ? load_moncount : load_mon_trg;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_mon_trg	<= 1'b0;
	end
	else if(RT0LPM_RTCCLK_B)begin
		load_mon_trg	<= wd_load_mon_trg;
	end
end


/////////////////////// wire wd_load_year_trg = (rtce_rtc && (!svmod_rtc)) ? load_yearcount : load_year_trg;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		load_year_trg	<= 1'b0;
	end
	else if(RT0LPM_RTCCLK_B)begin
	if (rtce_rtc && (!svmod_rtc)) begin
		load_year_trg	<= wd_load_year_trg;
	end
	end
end


//wait subtop
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		subtop_wait	<= 1'b0;
	end
	else if(RT0LPM_RTCCLK_B)begin
		subtop_wait	<= wd_subtop_wait;
	end

/*
	else if(RT0LPM_RTCCLK_B)begin
	if (rtce_rtc && (!svmod_rtc)) begin
		if (!cntwait) begin					//not wait
			subtop_wait	<= 1'b0;
		end
		//else if (load_seccount) begin		//secc write
		else if (load_sec_trg) begin		//mod Ver1.30
			subtop_wait	<= 1'b0;
		end
		else if (subtop) begin				//subtop in wait
			subtop_wait	<= 1'b1;
		end
		else begin
			subtop_wait	<= subtop_wait;
		end
	end
	end
*/
end

//for subtop clock enable
assign subtop_trg		= ((!cntwait) && (subtop));
assign subtop_wait_trg	= ((!cntwait) && (subtop_wait));

//for carry clock enable
//assign carry_trg	= (subtop_trg || subtop_wait_trg);
assign carry_trg_pre	= (subtop_trg || subtop_wait_trg);	// mod Ver1.30
assign carry_trg	= carry_trg_pre & rtce_rtc;		// add Ver1.30

//clock enable (write or subcarry or rtce reset)
assign clken_sec	= ((load_sec_trg  || carry_trg) && (!svmod_rtc));
assign clken_min	= ((load_min_trg  || carry_trg) && (!svmod_rtc));
assign clken_hour	= ((load_hour_trg || carry_trg) && (!svmod_rtc));
assign clken_week	= ((load_week_trg || carry_trg) && (!svmod_rtc));
assign clken_day	= ((load_day_trg  || carry_trg) && (!svmod_rtc));
assign clken_mon	= ((load_mon_trg  || carry_trg) && (!svmod_rtc));
assign clken_year	= ((load_year_trg || carry_trg) && (!svmod_rtc));
assign clken_all_cnt	= clken_sec | clken_min | clken_hour | clken_week | 
                          clken_day | clken_mon | clken_year;

//SVMOD sync RTCCLK -> svmod_rtc
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		svmod_rtc	<= 1'b0;
	end
	else if(RT0LPM_RTCCLK_B)begin
		svmod_rtc	<= SVMOD;
	end
end


endmodule

module QLK0RRTC0V3_CNTCLKGE_SUB(
rtce_rtc, svmod_rtc,
wd_cntwait, rwait, cntwait, subtop, subtop_wait,
load_seccount, load_mincount, load_hourcount, load_weekcount,
load_daycount, load_moncount, load_yearcount,
load_sec_trg, load_min_trg, load_hour_trg, load_week_trg,
load_day_trg, load_mon_trg, load_year_trg,
wd_load_sec_trg, wd_load_min_trg, wd_load_hour_trg, wd_load_week_trg, 
wd_load_day_trg, wd_load_mon_trg, wd_load_year_trg,
wd_subtop_wait);

input rtce_rtc, svmod_rtc;
input rwait, cntwait, subtop, subtop_wait;
input load_seccount, load_mincount, load_hourcount, load_weekcount,
      load_daycount, load_moncount, load_yearcount;

input load_sec_trg, load_min_trg, load_hour_trg, load_week_trg,
      load_day_trg, load_mon_trg, load_year_trg;

output wd_cntwait;
output wd_load_sec_trg, wd_load_min_trg, wd_load_hour_trg, wd_load_week_trg, 
       wd_load_day_trg, wd_load_mon_trg, wd_load_year_trg;
output wd_subtop_wait;

wire wd_cntwait = (rtce_rtc && (!svmod_rtc)) ? rwait : cntwait;
wire wd_load_sec_trg = (rtce_rtc && (!svmod_rtc)) ? load_seccount : load_sec_trg;
wire wd_load_min_trg = (rtce_rtc && (!svmod_rtc)) ? load_mincount : load_min_trg;
wire wd_load_hour_trg = (rtce_rtc && (!svmod_rtc)) ? load_hourcount : load_hour_trg;
wire wd_load_week_trg = (rtce_rtc && (!svmod_rtc)) ? load_weekcount : load_week_trg;
wire wd_load_day_trg = (rtce_rtc && (!svmod_rtc)) ? load_daycount : load_day_trg;
wire wd_load_mon_trg = (rtce_rtc && (!svmod_rtc)) ? load_moncount : load_mon_trg;
wire wd_load_year_trg = (rtce_rtc && (!svmod_rtc)) ? load_yearcount : load_year_trg;

reg wd_subtop_wait;

always@(rtce_rtc or svmod_rtc or cntwait or load_sec_trg or subtop or subtop_wait)begin
	if (rtce_rtc && (!svmod_rtc)) begin
		if (!cntwait) begin					//not wait
			wd_subtop_wait	= 1'b0;
		end
		//else if (load_seccount) begin		//secc write
		else if (load_sec_trg) begin		//mod Ver1.30
			wd_subtop_wait	= 1'b0;
		end
		else if (subtop) begin				//subtop in wait
			wd_subtop_wait	= 1'b1;
		end
		else begin
			wd_subtop_wait	= subtop_wait;
		end
	end
	else begin
			wd_subtop_wait	= subtop_wait;
        end
end

endmodule


module QLK0RRTC0V3_SUBC	(
	RT0TEN, RT0LPM_RTCCLK_B, yearcount, mincount,
	RTC_SELCK,
	RTCRESB,

	svmod_rtc,
	load_sec_trg,

	rtce_rtc,
	cloe1,
	dev,
	f6,
	f5,
	f4,
	f3,
	f2,
	f1,
	f0,

	seceq00,
	secdev0en,

//////	subcount,
	subtop,

	sub500ms,
	CLK1HZ,
	RT0MON0,
	pulse1hz
	);

//--- port direction
input			RT0TEN;
input			RT0LPM_RTCCLK_B;
input[7:0] 		yearcount;
input[6:0] 		mincount;
input			RTC_SELCK;
input			RTCRESB;

input			svmod_rtc;
input			load_sec_trg;

input			rtce_rtc;
input			cloe1;
input			dev;
input			f6;
input			f5;
input			f4;
input			f3;
input			f2;
input			f1;
input			f0;

input			seceq00;
input			secdev0en;

//////output	[15:0]	subcount;
output			subtop;

output			sub500ms;
output			CLK1HZ;
output			RT0MON0;
output			pulse1hz;

//--- reg, wire
//////wire	[15:0]	subcount;
wire			subtop;
wire				pulse1hz;

wire			subeq;
wire			subcnt_rst ;
//////wire			adjusten;
wire			adjust00;
wire	[14:0]	sub_add_sel;
wire	[14:0]	sub_add_sel0;
wire	[14:0]	sub_add_sel1;
//////wire	[14:0]	sub_sel;
wire	[6:0]	subcount_lo;
wire	[7:0]	subcount_hi;
wire			rtcdev, rtcf6, rtcf5, rtcf4, rtcf3, rtcf2, rtcf1, rtcf0;
wire		[14:0]	pre_subcount;
wire			sub500ms;
wire			CLK1HZ;
wire	[15:0]	adjust_1st_count;
wire	[15:0]	adjust_2nd_count;
wire	[15:0]	adjust_count;
////// reg				cloe1_rtc_n;



//--- logic

//////////////2-1hz pulse////////////////////////////////////////
/*
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		pulse1hz <= 1'b0 ;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		if (load_sec_trg) begin			//when write sec count
			pulse1hz <= 1'b0 ;
		end
		else if (subeq) begin
			pulse1hz <= !pulse1hz ;
		end
	end
end
*/

assign rtcdev	= dev;
assign rtcf6	= f6;
assign rtcf5	= f5;
assign rtcf4	= f4;
assign rtcf3	= f3;
assign rtcf2	= f2;
assign rtcf1	= f1;
assign rtcf0	= f0;

//////////////adjustment //////////////////////////
///////////// modified by M.minami
/*
assign  sub_add_sel0= {14'b01111111111111,rtcf6};   	//  (32678/2 -1(counter)) + @(adjust)  - rtcf6 (1:0) 
assign  sub_add_sel1= {rtcf6,rtcf6,rtcf6,rtcf6,rtcf6,rtcf6,rtcf6,rtcf6,rtcf6,rtcf5,rtcf4,rtcf3,rtcf2,rtcf1,rtcf0}; 
assign  sub_add_sel = sub_add_sel0 + sub_add_sel1;	// Adjusted compare value	

assign  subcount_hi = {pre_subcount[14:7]};
assign  subcount_lo = {pre_subcount[6:0]};

assign  adjust00    = rtcf5 |rtcf4 |rtcf3 |rtcf2 |rtcf1;	// when rtcf[6:0]=*00000*, not adjust
assign  adjusten    = (rtcdev ? (seceq00): (secdev0en))&adjust00;

assign  sub_sel     = adjusten? sub_add_sel : {15'b011111111111111};
assign  subeq       = ({subcount_hi,subcount_lo}  == sub_sel);  //(32678/2 -1(counter))

*/

assign  subtop      = subeq & pulse1hz;		// 1Hz trggier


//////////////sub counter  reset //////////////////////////
// assign  subcnt_rst     =  subeq;


//////////////sub counter//////////////////////////
//sub counter
//always @(posedge RTCCLK or negedge RTCRESB) begin
//	if (!RTCRESB) begin
//		pre_subcount	<= 15'h0000;
//	end
//	else if (rtce_rtc && (!svmod_rtc)) begin
//		if (subcnt_rst) begin			//carry
//			pre_subcount	<= 15'h0000;
//		end
//		else if (load_sec_trg) begin	//secc write 
//			pre_subcount	<= 15'h0000;
//		end
//		else begin
//	 		pre_subcount	<= pre_subcount + 15'h0001;
//		end
//	end
//end

///////////////////////////////////////////////////
// V2から変更
// 消費電流削減の為、V85x用RTC: qlnpsrtc1v1 の
// 桁上がりゲーティング3段構成カウンタに変更
///////////////////////////////////////////////////


QLK0RRTC0V3_SUBC_SUB0 subc_sub0(
.RT0TEN(RT0TEN), .yearcount(yearcount), .mincount(mincount), .RTC_SELCK(RTC_SELCK), .RTCRESB(RTCRESB), 
.rtce_rtc(rtce_rtc), .svmod_rtc(svmod_rtc), .subcnt_rst(subcnt_rst), .load_sec_trg(load_sec_trg), .subeq(subeq),
.pre_subcount(pre_subcount), .pulse1hz(pulse1hz), .RT0MON0(RT0MON0), .RT0LPM_RTCCLK_B(RT0LPM_RTCCLK_B)
);

QLK0RRTC0V3_SUBC_SUB1 subc_sub1(
.RTC_SELCK(RTC_SELCK), .RTCRESB(RTCRESB),
.rtcf6(rtcf6), .rtcf5(rtcf5), .rtcf4(rtcf4), .rtcf3(rtcf3), .rtcf2(rtcf2), .rtcf1(rtcf1), .rtcf0(rtcf0),
.rtcdev(rtcdev), .seceq00(seceq00), .secdev0en(secdev0en),
.pre_subcount(pre_subcount), .subeq(subeq), .subcnt_rst(subcnt_rst)
);

/*
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		pre_subcount[3:0]	<= 4'h0;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		if (subcnt_rst) begin			//carry
			pre_subcount[3:0]	<= 4'h0;
		end
		else if (load_sec_trg) begin	//secc write 
			pre_subcount[3:0]	<= 4'h0;
		end
		else begin
	 		pre_subcount[3:0]	<= pre_subcount[3:0] + 4'h1;
		end
	end
end

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		pre_subcount[7:4]	<= 4'h0;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		if (subcnt_rst) begin			//carry
			pre_subcount[7:4]	<= 4'h0;
		end
		else if (load_sec_trg) begin	//secc write 
			pre_subcount[7:4]	<= 4'h0;
		end
		else begin
                  if(pre_subcount[3:0]==4'hF)begin
	 		pre_subcount[7:4]	<= pre_subcount[7:4] + 4'h1;
                  end
		end
	end
end

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		pre_subcount[14:8]	<= 7'h00;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		if (subcnt_rst) begin			//carry
			pre_subcount[14:8]	<= 7'h00;
		end
		else if (load_sec_trg) begin	//secc write 
			pre_subcount[14:8]	<= 7'h00;
		end
		else begin
                  if(pre_subcount[7:0]==8'hFF)begin
	 		pre_subcount[14:8]	<= pre_subcount[14:8] + 7'h01;
                  end
		end
	end
end

*/

//subcount
//////assign adjust_1st_count	= {1'b0, pre_subcount[14:0]};
//////assign adjust_2nd_count	= {1'b0, pre_subcount[14:0]} + {1'b0, sub_sel} + 16'h0001;
//////assign adjust_count	= (!pulse1hz) ? adjust_1st_count : adjust_2nd_count; //adjust 1stcount or 2ndcount
//////assign subcount	= (adjusten) ? adjust_count					//adjust
//////				: {1'b0, pulse1hz, pre_subcount[13:0]};		//not adjust

//interval width:32KHz
assign sub500ms	= subeq;


//CLK1HZ out

////// always @(negedge RTCCLK or negedge RTCRESB) begin    //neg clk for noise
//////always @(posedge RTCCLK or negedge RTCRESB) begin  //////////////////////// modified M.minami
//////  if (!RTCRESB) begin
//////    cloe1_rtc_n <= 1'h0;
//////  end
//////  else if(RT0LPM_RTCCLK_B)begin
//////    cloe1_rtc_n <= wd_cloe1_rtc_n;
//////  end
//////end

assign CLK1HZ		= (cloe1) ? pulse1hz : 1'b0;

endmodule


//////////////////////////////////////////////////////////// added by M.minami (end)


module QLK0RRTC0V3_SUBC_SUB0 (
RT0TEN, yearcount, mincount,
RTC_SELCK, RTCRESB, 
rtce_rtc, svmod_rtc, subcnt_rst, load_sec_trg, subeq,
pre_subcount, pulse1hz, RT0MON0, RT0LPM_RTCCLK_B
);

input RT0TEN, RT0LPM_RTCCLK_B;
input[7:0] yearcount;
input[6:0] mincount;
input RTC_SELCK, RTCRESB;
input rtce_rtc, svmod_rtc, subcnt_rst, load_sec_trg, subeq;
output[14:0] pre_subcount;
// reg[14:0] pre_subcount;

output pulse1hz;
output RT0MON0;


reg pulse1hz;
wire[14:0] SUBC;
wire[14:0] pre_subcount = RT0TEN ? {yearcount[7:0], mincount[6:0]}: SUBC[14:0];
wire RT0MON0 = SUBC[14] & RT0TEN;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		pulse1hz <= 1'b0 ;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		if (load_sec_trg) begin			//when write sec count
			pulse1hz <= 1'b0 ;
		end
		else if (subeq) begin
			pulse1hz <= !pulse1hz ;
		end
	end
end

wire[14:0] wd_SUBC = {(~(SUBC[14:1])), SUBC[0] ^ (rtce_rtc & (~svmod_rtc))};
wire[14:0] ck_SUBC = {(~(SUBC[13:0])), RTC_SELCK};

reg rtce_svmod_d2;
always@(posedge RTC_SELCK or negedge RTCRESB)begin
  if(!RTCRESB)begin
    rtce_svmod_d2 <= 1'b0;
  end
  else if(RT0LPM_RTCCLK_B)begin
    rtce_svmod_d2 <= (rtce_rtc & (~svmod_rtc));
  end
end
////////////////////////wire       SUBC_RESB = RTCRESB & (((~load_sec_trg) & (~subcnt_rst)) & (rtce_rtc & (~svmod_rtc)));
//////////////////////////////////// wire SUBC_RESB = RTCRESB & (~((load_sec_trg | subcnt_rst) & (rtce_rtc & (~svmod_rtc))));
//////////////////////////////////// wire SUBC_RESB = RTCRESB & (~((load_sec_trg | subcnt_rst) & (rtce_svmod_d2 & (rtce_rtc & (~svmod_rtc)))));
wire SUBC_RESB = RTCRESB & (~(subcnt_rst & (rtce_svmod_d2 & (rtce_rtc & (~svmod_rtc)))))
                         & (~(load_sec_trg & (rtce_rtc & (~svmod_rtc))));

////////////wire       pre_SUBC_RESB = RTCRESB & (((~load_sec_trg) & (~subcnt_rst)) & (rtce_rtc & (~svmod_rtc)));
////////////wire       SUBC_RESB ;
////////////assign #500 SUBC_RESB = pre_SUBC_RESB;

QLK0RRTC0V3_BCNT bcnt0(.BCNT_CK(ck_SUBC[0]), .wd_BCNT(wd_SUBC[0]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[0]));
QLK0RRTC0V3_BCNT bcnt1(.BCNT_CK(ck_SUBC[1]), .wd_BCNT(wd_SUBC[1]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[1]));
QLK0RRTC0V3_BCNT bcnt2(.BCNT_CK(ck_SUBC[2]), .wd_BCNT(wd_SUBC[2]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[2]));
QLK0RRTC0V3_BCNT bcnt3(.BCNT_CK(ck_SUBC[3]), .wd_BCNT(wd_SUBC[3]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[3]));
QLK0RRTC0V3_BCNT bcnt4(.BCNT_CK(ck_SUBC[4]), .wd_BCNT(wd_SUBC[4]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[4]));
QLK0RRTC0V3_BCNT bcnt5(.BCNT_CK(ck_SUBC[5]), .wd_BCNT(wd_SUBC[5]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[5]));
QLK0RRTC0V3_BCNT bcnt6(.BCNT_CK(ck_SUBC[6]), .wd_BCNT(wd_SUBC[6]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[6]));
QLK0RRTC0V3_BCNT bcnt7(.BCNT_CK(ck_SUBC[7]), .wd_BCNT(wd_SUBC[7]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[7]));
QLK0RRTC0V3_BCNT bcnt8(.BCNT_CK(ck_SUBC[8]), .wd_BCNT(wd_SUBC[8]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[8]));
QLK0RRTC0V3_BCNT bcnt9(.BCNT_CK(ck_SUBC[9]), .wd_BCNT(wd_SUBC[9]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[9]));
QLK0RRTC0V3_BCNT bcnt10(.BCNT_CK(ck_SUBC[10]), .wd_BCNT(wd_SUBC[10]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[10]));
QLK0RRTC0V3_BCNT bcnt11(.BCNT_CK(ck_SUBC[11]), .wd_BCNT(wd_SUBC[11]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[11]));
QLK0RRTC0V3_BCNT bcnt12(.BCNT_CK(ck_SUBC[12]), .wd_BCNT(wd_SUBC[12]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[12]));
QLK0RRTC0V3_BCNT bcnt13(.BCNT_CK(ck_SUBC[13]), .wd_BCNT(wd_SUBC[13]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[13]));
QLK0RRTC0V3_BCNT bcnt14(.BCNT_CK(ck_SUBC[14]), .wd_BCNT(wd_SUBC[14]), .BCNT_RESB(SUBC_RESB), .BCNT(SUBC[14]));


endmodule

module QLK0RRTC0V3_BCNT(BCNT_CK, BCNT_RESB, wd_BCNT, BCNT);
input BCNT_CK;
input BCNT_RESB;
input wd_BCNT;
output BCNT;
reg BCNT;

always@(posedge BCNT_CK or negedge BCNT_RESB)begin
  if(!BCNT_RESB)begin
    BCNT <= 1'b0; 
  end
  else begin
    BCNT <= wd_BCNT;
  end
end

endmodule

/*
module QLK0RRTC0V3_BCNT_N(BCNT_CK, BCNT_RESB, wd_BCNT, BCNT);
input BCNT_CK;
input BCNT_RESB;
input wd_BCNT;
output BCNT;
reg BCNT;

always@(negedge BCNT_CK or negedge BCNT_RESB)begin
  if(!BCNT_RESB)begin
    BCNT <= 0; 
  end
  else begin
    BCNT <= wd_BCNT;
  end
end

endmodule
*/

module QLK0RRTC0V3_SUBC_SUB1 (
RTC_SELCK, RTCRESB,
rtcf6, rtcf5, rtcf4, rtcf3, rtcf2, rtcf1, rtcf0,
rtcdev, seceq00, secdev0en,
pre_subcount, subeq, subcnt_rst
);

input RTC_SELCK, RTCRESB;
input rtcf6, rtcf5, rtcf4, rtcf3, rtcf2, rtcf1, rtcf0;
input rtcdev, seceq00, secdev0en;
input[14:0] pre_subcount;
output  subeq, subcnt_rst;


wire	[14:0]	sub_add_sel;
wire	[14:0]	sub_add_sel0;
wire	[14:0]	sub_add_sel1;
wire	[14:0]	sub_sel;
wire	[6:0]	subcount_lo;
wire	[7:0]	subcount_hi;

wire  adjust00;
wire  adjusten;
wire  adjusten_plus1;
wire	[14:0]	sub_sel_plus1;

wire  pre_subeq;
reg  subeq;
wire  subcnt_rst = subeq;

assign  sub_add_sel0= {14'b01111111111111,rtcf6};   	//  (32678/2 -1(counter)) + @(adjust)  - rtcf6 (1:0) 
assign  sub_add_sel1= {rtcf6,rtcf6,rtcf6,rtcf6,rtcf6,rtcf6,rtcf6,rtcf6,rtcf6,rtcf5,rtcf4,rtcf3,rtcf2,rtcf1,rtcf0}; 
assign  sub_add_sel = sub_add_sel0 + sub_add_sel1;	// Adjusted compare value	

assign  subcount_hi = {pre_subcount[14:7]};
assign  subcount_lo = {pre_subcount[6:0]};

assign  adjust00    = rtcf5 |rtcf4 |rtcf3 |rtcf2 |rtcf1;	// when rtcf[6:0]=*00000*, not adjust
assign  adjusten    = (rtcdev ? (seceq00): (secdev0en))&adjust00;

assign  sub_sel     = adjusten? sub_add_sel : {15'b011111111111111};

// assign  subeq       = ({subcount_hi,subcount_lo}  == sub_sel);  //(32678/2 -1(counter))
assign  pre_subeq       = ({subcount_hi,subcount_lo}  == sub_sel);  //(32678/2 -1(counter))


always@(negedge RTC_SELCK or negedge RTCRESB)begin
  if(!RTCRESB)begin
    subeq <= 1'b0;
  end
  else begin
    subeq <= pre_subeq;
  end
end

endmodule

//////////////////////////////////////////////////////////// added by M.minami (end)

module QLK0RRTC0V3_SECC	(
	RTC_SELCK,
	RTCRESB,
	clken_sec,

	load_sec_trg,
	secbuf,
	clken_all_cnt,
	seceq59,
	seceq00,
	secdev0en,
	seccount
	);

//--- port direction
input			RTC_SELCK;
input			RTCRESB;
input			clken_sec;

input			load_sec_trg;
input	[6:0]	secbuf;
input clken_all_cnt;

output			seceq59;
output			seceq00;
output			secdev0en;
output	[6:0]	seccount;


//--- reg, wire
wire			seceq59;
wire			seceq00;
wire			secdev0en;
wire	[6:0]	seccount;

reg		[3:0] 	seccount0;
reg		[2:0] 	seccount1;

wire  	 		seceq50;
wire     		seccarry;
wire     		seceq00_pre0  ;
wire     		seceq00_pre1  ;


//--- logic

//////////////sec BCD counter//////////////////////////
//sec counter

//////////////////////////////////////////////////////////// modified by M.minami (begin)

wire[3:0] wd_seccount0;
wire[2:0] wd_seccount1;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
  if(!RTCRESB)begin
    seccount0[3:0] <= 4'b0000;
  end
  else if(clken_all_cnt)begin
    seccount0[3:0] <= wd_seccount0[3:0];
  end
end

always @(posedge RTC_SELCK or negedge RTCRESB) begin
  if(!RTCRESB)begin
    seccount1[2:0] <= 3'b000;
  end
  else if(clken_all_cnt)begin
    seccount1[2:0] <= wd_seccount1[2:0];
  end
end

QLK0RRTC0V3_SECC_SUB secc_sub
(.clken_sec(clken_sec), .load_sec_trg(load_sec_trg), .secbuf(secbuf),
 .seccount0(seccount0), .seccount1(seccount1),
 .wd_seccount0(wd_seccount0), .wd_seccount1(wd_seccount1), .seceq59(seceq59));

/*

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		seccount0	<= 4'b0000;
	end

	else if (clken_sec) begin		//clock gating
		if (load_sec_trg) begin						//buf->counter
			seccount0	<= secbuf[3:0];
		end
		else if (seccarry) begin					//carry
			seccount0	<= 4'b0000;
		end
		else begin									//count up
			seccount0	<= seccount0 + 4'b0001;
		end
	end
end

assign  seccarry = (seccount0 == 4'b1001);


always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		seccount1	<= 3'b000;
	end

	else if (clken_sec) begin		//clock gating
		if (load_sec_trg) begin						//buf->counter
			seccount1	<= secbuf[6:4];
		end
		else if (seceq59) begin						//carry
			seccount1	<= 3'b000;
		end
		else if (seccarry) begin					//count up
			seccount1	<= seccount1 + 3'b001;
		end
	end
end

assign  seceq50      =  (seccount1 == 3'b101);
assign  seceq59      =   seccarry & seceq50;	// min count up 

*/

//////////////////////////////////////////////////////////// modified by M.minami (end)

assign  seccount     =  {seccount1 , seccount0 };
assign  seceq00_pre0 =  (seccount0 == 4'b0000);
assign  seceq00_pre1 =  (seccount1 == 3'b000);
assign  seceq00      =   seceq00_pre1 & seceq00_pre0;

assign  secdev0en    =  !seccount1[0] & seceq00_pre0;	// 00,20,40 for adjust



endmodule


//////////////////////////////////////////////////////////// added by M.minami (start)

module QLK0RRTC0V3_SECC_SUB(clken_sec, load_sec_trg, seccount0, seccount1, secbuf, wd_seccount0, wd_seccount1, seceq59);

input clken_sec, load_sec_trg;
input[3:0]seccount0;
input[2:0] seccount1;
input[6:0] secbuf;
output[3:0] wd_seccount0;
output[2:0] wd_seccount1;
output seceq59;

wire seccarry = (seccount0 == 4'b1001);
wire seceq50 = (seccount1 == 3'b101);
wire seceq59 = seccarry & seceq50;

wire[3:0] wd_seccount0 = clken_sec    ? (
                         load_sec_trg ? secbuf[3:0] :
                         seccarry     ? 4'b0000 : (seccount0[3:0] + 4'b0001)) :seccount0[3:0];


wire[2:0] wd_seccount1 = clken_sec    ? (
                         load_sec_trg ? secbuf[6:4] :
                         seceq59      ? 3'b000 :
                         seccarry     ? (seccount1[2:0] + 3'b001) : seccount1[2:0]): seccount1[2:0];

endmodule

//////////////////////////////////////////////////////////// added by M.minami (end)


module QLK0RRTC0V3_MINC	(
	RTC_SELCK,
	RTCRESB,
	clken_min,

	load_min_trg,
	minbuf,
	clken_all_cnt,

	seceq59,
	hour_cu,
	mincount
	);

//--- port direction
input			RTC_SELCK;
input			RTCRESB;
input			clken_min;

input			load_min_trg;
input	[6:0]		minbuf;
input			clken_all_cnt;
input			seceq59;

output			hour_cu;
output	[6:0]	mincount;


//--- reg, wire
reg		[3:0] 	mincount0;
reg		[2:0] 	mincount1;
wire			mineq09;
wire			mineq50;
wire			mincarry;
wire			min_add;


//--- logic

assign min_add	= seceq59;

//////////////minute counter//////////////////////////
//min counter

//////////////////////////////////////////////////////////// modified by M.minami (begin)

wire[3:0] wd_mincount0;
wire[2:0] wd_mincount1;

always@(posedge RTC_SELCK or negedge RTCRESB)begin
  if(!RTCRESB)begin
    mincount0[3:0] <= 4'b0;
  end
  else if(clken_all_cnt)begin
    mincount0[3:0] <= wd_mincount0[3:0];
  end
end

always@(posedge RTC_SELCK or negedge RTCRESB)begin
  if(!RTCRESB)begin
    mincount1[2:0] <= 3'b0;
  end
  else if(clken_all_cnt)begin
    mincount1[2:0] <= wd_mincount1[2:0];
  end
end

QLK0RRTC0V3_MINC_SUB minc_sub
(.clken_min(clken_min), .load_min_trg(load_min_trg), .min_add(min_add), .minbuf(minbuf),
 .mincount0(mincount0), .mincount1(mincount1),
 .wd_mincount0(wd_mincount0), .wd_mincount1(wd_mincount1), .hour_cu(hour_cu));

/*
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		mincount0	<= 4'b0000;
	end

	else if (clken_min) begin		//clock gating
		if (load_min_trg) begin						//buf->counter
			mincount0	<= minbuf[3:0];
		end
		else if (mincarry) begin					//carry
			mincount0	<= 4'b0000;
		end
		else if (min_add) begin						//count up
			mincount0	<= mincount0 + 4'b0001;
		end
	end
end

assign  mineq09  = (mincount0 == 4'b1001);
assign  mincarry = mineq09 & min_add;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		mincount1	<= 3'b000;
	end

	else if (clken_min) begin		//clock gating
		if (load_min_trg) begin						//buf->counter
			mincount1	<= minbuf[6:4];
		end
		else if (hour_cu) begin						//carry
			mincount1	<= 3'b000;
		end
		else if (mincarry) begin					//count up
			mincount1	<= mincount1 + 3'b001;
		end
	end
end

assign  mincount     =  { mincount1, mincount0};
assign  mineq50      =  ( mincount1 == 3'b101);
assign  hour_cu      =   mincarry & mineq50;	// hour count up

*/
//////////////////////////////////////////////////////////// modified by M.minami (end)

assign  mincount     =  { mincount1, mincount0};

endmodule

//////////////////////////////////////////////////////////// added by M.minami (start)

module QLK0RRTC0V3_MINC_SUB(clken_min, load_min_trg, min_add, mincount0, mincount1, minbuf,
                            wd_mincount0, wd_mincount1, hour_cu);

input clken_min, load_min_trg, min_add;
input[3:0]mincount0;
input[2:0] mincount1;
input[6:0] minbuf;
output[3:0] wd_mincount0;
output[2:0] wd_mincount1;
output hour_cu;

wire mineq09 = (mincount0 == 4'b1001);
wire mincarry = mineq09 & min_add;
wire mineq50 = (mincount1 == 3'b101);
wire hour_cu = mincarry & mineq50;    // hour count up

wire[3:0] wd_mincount0 = clken_min    ? (
                         load_min_trg ? minbuf[3:0] :
                         mincarry     ? 4'b0000 :
                         min_add      ? (mincount0[3:0] + 4'b0001): mincount0[3:0]): mincount0[3:0];


wire[2:0] wd_mincount1 = clken_min    ? (
                         load_min_trg ? minbuf[6:4] :
                         hour_cu      ? 3'b000 :
                         mincarry     ? (mincount1[2:0] + 3'b001): mincount1[2:0]): mincount1[2:0];

endmodule


//////////////////////////////////////////////////////////// added by M.minami (end)

module QLK0RRTC0V3_HOURC	(
	RTC_SELCK,
	RTCRESB,
	clken_hour,

	load_hour_trg,
	hourbuf,
	clken_all_cnt,
	hour_cu,
	day_cu,
	hourcount
	);

//--- port direction
input			RTC_SELCK;
input			RTCRESB;
input			clken_hour;

input			load_hour_trg;
input	[5:0]	hourbuf;
input			clken_all_cnt;
input			hour_cu;

output			day_cu;
output	[5:0]	hourcount;


//--- reg, wire
reg		[3:0] 	hourcount0;
reg		[1:0] 	hourcount1;
wire			hourcarry;
wire			houreq;
wire			hour_add;


//--- logic

assign hour_add	= hour_cu;

//////////////hour counter//////////////////////////
//hour counter
//////////////////////////////////////////////////////////// modified by M.minami (begin)

wire[3:0] wd_hourcount0;
wire[1:0] wd_hourcount1;

always@(posedge RTC_SELCK or negedge RTCRESB)begin
  if(!RTCRESB)begin
    hourcount0[3:0] <= 4'b0;
  end
  else if(clken_all_cnt)begin
    hourcount0[3:0] <= wd_hourcount0[3:0];
  end
end

always@(posedge RTC_SELCK or negedge RTCRESB)begin
  if(!RTCRESB)begin
    hourcount1[1:0] <= 2'b0;
  end
  else if(clken_all_cnt)begin
    hourcount1[1:0] <= wd_hourcount1[1:0];
  end
end

QLK0RRTC0V3_HOURC_SUB hourc_sub
(.clken_hour(clken_hour), .load_hour_trg(load_hour_trg), .hour_add(hour_add), .hourbuf(hourbuf),
 .hourcount0(hourcount0), .hourcount1(hourcount1),
 .wd_hourcount0(wd_hourcount0), .wd_hourcount1(wd_hourcount1), .day_cu(day_cu));

/*
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		hourcount0	<= 4'b0000;
	end

	else if (clken_hour) begin		//clock gating
		if (load_hour_trg) begin					//buf->counter
			hourcount0	<= hourbuf[3:0];
		end
		else if (day_cu || hourcarry) begin			//carry
			hourcount0	<= 4'b0000;
		end
		else if (hour_add) begin					//count up
			hourcount0	<= hourcount0 + 4'b0001;
		end
	end
end

assign  hourcarry = hourcount0[0]& hourcount0[3]&hour_add;	// hour[3:0]=1xx1

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		hourcount1	<= 2'b00;
	end

	else if (clken_hour) begin		//clock gating
		if (load_hour_trg) begin					//buf->counter
			hourcount1	<= hourbuf[5:4];
		end
		else if (day_cu) begin						//carry
			hourcount1	<= 2'b00;
		end
		else if (hourcarry) begin					//count up
			hourcount1	<= hourcount1 + 2'b01;
		end
	end
end

assign  hourcount  = {hourcount1,hourcount0}; 
assign  houreq     = (hourcount == 6'b100011);  //23

assign 	day_cu = hour_add & houreq;

*/

//////////////////////////////////////////////////////////// modified by M.minami (end)

assign  hourcount  = {hourcount1,hourcount0}; 

endmodule

//////////////////////////////////////////////////////////// added by M.minami (start)

module QLK0RRTC0V3_HOURC_SUB(clken_hour, load_hour_trg, hour_add, hourcount0, hourcount1, hourbuf,
                            wd_hourcount0, wd_hourcount1, day_cu);

input clken_hour, load_hour_trg, hour_add;
input[3:0]hourcount0;
input[1:0] hourcount1;
input[5:0] hourbuf;
output[3:0] wd_hourcount0;
output[1:0] wd_hourcount1;
output day_cu;

wire hourcarry = hourcount0[0]& hourcount0[3]&hour_add; // hour[3:0]=1xx1
wire houreq = ({hourcount1[1:0],hourcount0[3:0]} == 6'b100011); //23
wire day_cu = hour_add & houreq;

wire[3:0] wd_hourcount0 = clken_hour           ? (
                          load_hour_trg        ? hourbuf[3:0] :
                          (day_cu | hourcarry) ? 4'b0000 :
                          hour_add             ? (hourcount0[3:0] + 4'b0001): hourcount0[3:0]): hourcount0[3:0];


wire[1:0] wd_hourcount1 = clken_hour    ? (
                          load_hour_trg ? hourbuf[5:4] :
                          day_cu      ? 2'b00 :
                          hourcarry     ? (hourcount1[1:0] + 2'b01): hourcount1[1:0]): hourcount1[1:0];

endmodule

//////////////////////////////////////////////////////////// added by M.minami (end)



module QLK0RRTC0V3_WEEKC	(
	RTC_SELCK,
	RTCRESB,
	clken_week,

	load_week_trg,
	weekbuf,
	clken_all_cnt,
	day_cu,
	weekcount
	);

//--- port direction
input			RTC_SELCK;
input			RTCRESB;
input			clken_week;

input			load_week_trg;
input	[2:0]	weekbuf;
input 			clken_all_cnt;
input			day_cu;

output	[2:0]	weekcount;


//--- reg, wire
reg		[2:0]	weekcount;
wire			weekeq;
wire			week_add;


//--- logic

assign week_add	= day_cu;

//////////////hour counter//////////////////////////
//hour counter
//////////////////////////////////////////////////////////// modified by M.minami (begin)

wire[2:0] wd_weekcount;

always@(posedge RTC_SELCK or negedge RTCRESB)begin
  if(!RTCRESB)begin
    weekcount[2:0] <= 3'b0;
  end
  else if(clken_all_cnt)begin
    weekcount[2:0] <= wd_weekcount[2:0];
  end 
end

QLK0RRTC0V3_WEEKC_SUB weekc_sub
(.clken_week(clken_week), .load_week_trg(load_week_trg), .week_add(week_add),
 .weekbuf(weekbuf), .weekcount(weekcount),
 .wd_weekcount(wd_weekcount));

/*
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		weekcount	<= 3'b000;
	end

	else if (clken_week) begin		//clock gating
		if (load_week_trg) begin					//buf->counter
			weekcount	<= weekbuf[2:0];
		end
		else if (weekeq) begin						//carry
			weekcount	<= 3'b000;
		end
		else if (week_add) begin					//count up
			weekcount	<= weekcount + 3'b001;
		end
	end
end

assign  weekeq =  (weekcount == 3'b110) & week_add;

*/


endmodule

//////////////////////////////////////////////////////////// added by M.minami (begin)

module QLK0RRTC0V3_WEEKC_SUB(clken_week, load_week_trg, week_add, weekcount, weekbuf,
                            wd_weekcount);

input clken_week, load_week_trg, week_add;
input[2:0] weekcount;
input[2:0] weekbuf;
output[2:0] wd_weekcount;

wire weekeq =  (weekcount == 3'b110) & week_add;

wire[2:0] wd_weekcount = clken_week    ? (
                         load_week_trg ? weekbuf[2:0] :
                         weekeq        ? 3'b000 :
                         week_add      ? (weekcount[2:0] + 3'b001): weekcount[2:0]): weekcount[2:0];


endmodule

//////////////////////////////////////////////////////////// added by M.minami (end)



module QLK0RRTC0V3_DAYC	(
	RTC_SELCK,
	RTCRESB,
	clken_day,

	load_day_trg,
	daybuf,
	day_cu,
	moncount,
	leapyear,
        clken_all_cnt,
	mon_cu,
	daycount
	);

//--- port direction
input			RTC_SELCK;
input			RTCRESB;
input			clken_day;

input			load_day_trg;
input	[5:0]	daybuf;
input			day_cu;
input	[4:0]	moncount;
input			leapyear;
input			clken_all_cnt;

output			mon_cu;
output	[5:0]	daycount;


//--- reg, wire
reg		[3:0] 	daycount0;
reg		[1:0] 	daycount1;
wire			daycarry;
wire			dayeq;
wire			day_add;
wire	[5:0]	daycom;


//--- logic

assign day_add	= day_cu;

//daycom
assign daycom	= (moncount[4:0] ==  5'b00001) ?  6'b110001				//1-31
				: (moncount[4:0] ==  5'b00010) ?  {5'b10100,leapyear}	//2-28/29
				: (moncount[4:0] ==  5'b00011) ?  6'b110001				//3-31
				: (moncount[4:0] ==  5'b00100) ?  6'b110000				//4-30
				: (moncount[4:0] ==  5'b00101) ?  6'b110001				//5-31
				: (moncount[4:0] ==  5'b00110) ?  6'b110000				//6-30
				: (moncount[4:0] ==  5'b00111) ?  6'b110001				//7-31
				: (moncount[4:0] ==  5'b01000) ?  6'b110001				//8-31
				: (moncount[4:0] ==  5'b01001) ?  6'b110000				//9-30
				: (moncount[4:0] ==  5'b10000) ?  6'b110001				//10-31
				: (moncount[4:0] ==  5'b10001) ?  6'b110000				//11-30
				: 								  6'b110001;			//12-31

//////////////day BCD counter//////////////////////////
//day counter
//////////////////////////////////////////////////////////// modified by M.minami (begin)

wire[3:0] wd_daycount0;
wire[1:0] wd_daycount1;

always@(posedge RTC_SELCK or negedge RTCRESB) begin
  if(!RTCRESB)begin
    daycount0[3:0] <= 4'b0001;
  end
  else if(clken_all_cnt)begin
    daycount0[3:0] <= wd_daycount0[3:0];
  end 
end

always@(posedge RTC_SELCK or negedge RTCRESB) begin
  if(!RTCRESB)begin
    daycount1[1:0] <= 2'b00;
  end
  else if(clken_all_cnt)begin
    daycount1[1:0] <= wd_daycount1[1:0];
  end 
end

QLK0RRTC0V3_DAYC_SUB dayc_sub(.clken_day(clken_day), .load_day_trg(load_day_trg), .day_add(day_add),
                              .mon_cu(mon_cu), .daycount0(daycount0), .daycount1(daycount1), .daybuf(daybuf),
                              .wd_daycount0(wd_daycount0), .wd_daycount1(wd_daycount1));

/*

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		daycount0	<= 4'b0001;
	end

	else if (clken_day) begin		//clock gating
		if (load_day_trg) begin						//buf->counter
			daycount0	<= daybuf[3:0];
		end
		else if (mon_cu) begin						//carry
			daycount0	<= 4'b0001;
		end
		else if (daycarry) begin					//carry ->10,20,30
			daycount0	<= 4'b0000;
		end
		else if (day_add) begin						//count up
			daycount0	<= daycount0 + 4'b0001;
		end
	end
end

assign  daycarry = daycount0[0] & daycount0[3] & day_add;	// daycount0[3:0]=1xx1

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		daycount1	<= 2'b00;
	end

	else if (clken_day) begin		//clock gating
		if (load_day_trg) begin						//buf->counter
			daycount1	<= daybuf[5:4];
		end
		else if (mon_cu) begin						//carry
			daycount1	<= 2'b00;
		end
		else if (daycarry) begin					//count up
			daycount1	<= daycount1 + 2'b01;
		end
	end
end

*/

assign  daycount = {daycount1[1:0],daycount0[3:0]};
assign  dayeq    = (daycount == daycom);
assign	mon_cu = day_add & dayeq;


//////////////////////////////////////////////////////////// modified by M.minami (begin)

endmodule

//////////////////////////////////////////////////////////// added by M.minami (begin)

module QLK0RRTC0V3_DAYC_SUB(clken_day, load_day_trg, day_add, mon_cu, daycount0, daycount1, daybuf,
                            wd_daycount0, wd_daycount1);

input clken_day, load_day_trg, day_add, mon_cu;
input[3:0] daycount0;
input[1:0] daycount1;
input[5:0] daybuf;
output[3:0] wd_daycount0;
output[1:0] wd_daycount1;

wire daycarry = daycount0[0] & daycount0[3] & day_add;       // daycount0[3:0]=1xx1

wire[3:0] wd_daycount0 = clken_day    ? (
                         load_day_trg ? daybuf[3:0] :
                         mon_cu       ? 4'b0001 :
                         daycarry     ? 4'b0000 :
                         day_add      ? (daycount0[3:0] + 4'b0001): daycount0[3:0]): daycount0[3:0];

wire[1:0] wd_daycount1 = clken_day    ? (
                         load_day_trg ? daybuf[5:4] :
                         mon_cu       ? 2'b00 :
                         daycarry     ? (daycount1 + 2'b01) : daycount1[1:0]): daycount1[1:0];


endmodule

//////////////////////////////////////////////////////////// added by M.minami (end)


module QLK0RRTC0V3_MONC	(
	RTC_SELCK,
	RTCRESB,
	clken_mon,

	load_mon_trg,
	monbuf,
	clken_all_cnt,
	mon_cu,
	year_cu,
	moncount
	);

//--- port direction
input			RTC_SELCK;
input			RTCRESB;
input			clken_mon;

input			load_mon_trg;
input	[4:0]	monbuf;
input			clken_all_cnt;
input			mon_cu;

output			year_cu;
output	[4:0]	moncount;


//--- reg, wire
reg		[3:0] 	moncount0;
reg		 		mon10;
//wire			moncarry;
wire			moneql;
wire			moneq;
wire			mon_add;


//--- logic

assign mon_add	= mon_cu;

//////////////mon BCD counter//////////////////////////
//mon counter

//////////////////////////////////////////////////////////// modified by M.minami (begin)

wire[3:0] wd_moncount0;
wire wd_mon10;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
  if(!RTCRESB)begin
    moncount0[3:0] <= 4'b0001;
  end
  else if(clken_all_cnt)begin
    moncount0[3:0] <= wd_moncount0[3:0];
  end
end

always @(posedge RTC_SELCK or negedge RTCRESB) begin
  if(!RTCRESB)begin
    mon10 <= 1'b0;
  end
  else if(clken_all_cnt)begin
    mon10 <= wd_mon10;
  end
end

QLK0RRTC0V3_MONC_SUB monc_sub(.clken_mon(clken_mon), .load_mon_trg(load_mon_trg), .year_cu(year_cu),
                              .mon_add(mon_add), .moncount0(moncount0), .mon10(mon10), .monbuf(monbuf),
                              .wd_moncount0(wd_moncount0), .wd_mon10(wd_mon10));

/*
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		moncount0	<= 4'b0001;
	end

	else if (clken_mon) begin		//clock gating
		if (load_mon_trg) begin						//buf->counter
			moncount0	<= monbuf[3:0];
		end
		else if (year_cu) begin						//carry
			moncount0	<= 4'b0001;
		end
		else if (moncarry) begin					//carry ->10
			moncount0	<= 4'b0000;
		end
		else if (mon_add) begin						//count up
			moncount0	<= moncount0 + 4'b0001;
		end
	end
end

assign  moncarry = moncount0[0] & moncount0[3]& mon_add ;	// moncount0[3:0]=1xx1

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		mon10	<= 1'b0;
	end

	else if (clken_mon) begin		//clock gating
		if (load_mon_trg) begin						//buf->counter
			mon10	<= monbuf[4];
		end
		else if (year_cu) begin						//carry
			mon10	<= 1'b0;
		end
		else if (moncarry) begin					//count up
			mon10	<= 1'b1;
		end
	end
end


*/
//////////////////////////////////////////////////////////// modified by M.minami (end)

assign moncount = { mon10 ,moncount0[3:0]}; 
assign moneql   = (moncount0[3:0]== 4'b0010);

assign moneq    =  moneql & mon10;	// month=12	

assign	year_cu = mon_add & moneq;


endmodule

//////////////////////////////////////////////////////////// added by M.minami (begin)


module QLK0RRTC0V3_MONC_SUB(clken_mon, load_mon_trg, year_cu, mon_add,  moncount0, mon10, monbuf,
                            wd_moncount0, wd_mon10);

input clken_mon, load_mon_trg, year_cu, mon_add;
input[3:0] moncount0;
input mon10;
input[4:0] monbuf;
output[3:0] wd_moncount0;
output wd_mon10;

wire  moncarry = moncount0[0] & moncount0[3]& mon_add ;       // moncount0[3:0]=1xx1

wire[3:0] wd_moncount0 = clken_mon    ? (
                         load_mon_trg ? monbuf[3:0] :
                         year_cu      ? 4'b0001 :
                         moncarry     ? 4'b0000 :
                         mon_add      ? (moncount0[3:0] + 4'b0001): moncount0[3:0]): moncount0[3:0];

wire wd_mon10 = clken_mon    ? (
                load_mon_trg ? monbuf[4] :
                year_cu      ? 1'b0 :
                moncarry     ? 1'b1 : mon10): mon10;


endmodule

//////////////////////////////////////////////////////////// added by M.minami (end)

module QLK0RRTC0V3_YEARC	(
	RTC_SELCK,
	RTCRESB,
	clken_year,

	load_year_trg,
	yearbuf,
	year_cu,
        clken_all_cnt,
	leapyear,
	yearcount
	);

//--- port direction
input			RTC_SELCK;
input			RTCRESB;
input			clken_year;

input			load_year_trg;
input	[7:0]	yearbuf;
input			year_cu;
input			clken_all_cnt;

output			leapyear;
output	[7:0]	yearcount;


//--- reg, wire
reg		[3:0] 	yearcount0;
reg		[3:0] 	yearcount1;
wire			yeareq1;
wire			yeareq0;
wire			yeareq;
wire			leapyear_pre;
wire			yearcarry;
wire			year_add;


//--- logic

assign year_add	= year_cu;

//////////////year counter//////////////////////////
//year counter

//////////////////////////////////////////////////////////// moddified by M.minami (begin)

wire[3:0] wd_yearcount0, wd_yearcount1;

always@(posedge RTC_SELCK or negedge RTCRESB) begin
  if(!RTCRESB)begin
    yearcount0[3:0] <= 4'b0000;
  end
  else if(clken_all_cnt)begin
    yearcount0[3:0] <= wd_yearcount0[3:0];
  end
end

always@(posedge RTC_SELCK or negedge RTCRESB) begin
  if(!RTCRESB)begin
    yearcount1[3:0] <= 4'b0000;
  end
  else if(clken_all_cnt)begin
    yearcount1[3:0] <= wd_yearcount1[3:0];
  end
end

QLK0RRTC0V3_YEARC_SUB yearc_sub
(.clken_year(clken_year), .load_year_trg(load_year_trg), .year_add(year_add), .yearcount0(yearcount0), .yearcount1(yearcount1),
 .yearbuf(yearbuf), .wd_yearcount0(wd_yearcount0), .wd_yearcount1(wd_yearcount1), .leapyear(leapyear));

/*
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		yearcount0	<= 4'b0000;
	end

	else if (clken_year) begin		//clock gating
		if (load_year_trg) begin					//buf->counter
			yearcount0	<= yearbuf[3:0];
		end
		else if (yearcarry) begin					//carry
			yearcount0	<= 4'b0000;
		end
		else if (year_add) begin					//count up
			yearcount0	<= yearcount0 + 4'b0001;
		end
	end
end

assign yeareq0   = yearcount0[3] & yearcount0[0];		// yearcount0[3:0]=1xx1
assign yearcarry = yeareq0 & year_add;

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		yearcount1	<= 4'b0000;
	end

	else if (clken_year) begin		//clock gating
		if (load_year_trg) begin					//buf->counter
			yearcount1	<= yearbuf[7:4];
		end
		else if (yeareq) begin						//carry
			yearcount1	<= 4'b0000;
		end
		else if (yearcarry) begin					//count up
			yearcount1	<= yearcount1 + 4'b0001;
		end
	end
end

assign leapyear_pre = yearcount1[0] ? yearcount0[1] : !yearcount0[1];
assign leapyear  = !yearcount0[0]& leapyear_pre;   

assign yeareq1   = yearcount1[3] & yearcount1[0]; 	// yearcount1[3:0]=1xx1

assign yeareq    = yeareq1 & yearcarry;
*/

assign yearcount = {yearcount1[3:0], yearcount0[3:0]};

//////////////////////////////////////////////////////////// moddified by M.minami (end)


endmodule

//////////////////////////////////////////////////////////// added by M.minami (begin)

module QLK0RRTC0V3_YEARC_SUB(clken_year, load_year_trg, year_add, yearcount0, yearcount1, yearbuf, wd_yearcount0, wd_yearcount1,
                             leapyear);

input clken_year, load_year_trg, year_add;
input[3:0]yearcount0;
input[3:0] yearcount1;
input[7:0] yearbuf;
output[3:0] wd_yearcount0;
output[3:0] wd_yearcount1;
output leapyear;

wire yeareq0 = yearcount0[3] & yearcount0[0];               // yearcount0[3:0]=1xx1
wire yearcarry = yeareq0 & year_add;
wire leapyear_pre = yearcount1[0] ? yearcount0[1] : !yearcount0[1];
wire leapyear = !yearcount0[0]& leapyear_pre;   
wire yeareq1 = yearcount1[3] & yearcount1[0];       // yearcount1[3:0]=1xx1
wire yeareq = yeareq1 & yearcarry;

wire[3:0] wd_yearcount0 = clken_year ? (
                          load_year_trg ? yearbuf[3:0] :
                          yearcarry ? 4'b0000 :
                          year_add ? (yearcount0[3:0] + 4'b0001) :yearcount0[3:0]) :yearcount0[3:0];


wire[3:0] wd_yearcount1 = clken_year ? (
                         load_year_trg ? yearbuf[7:4] :
                         yeareq ? 4'b0000 :
                         yearcarry ? (yearcount1[3:0] + 4'b0001) : yearcount1[3:0]): yearcount1[3:0];

endmodule

//////////////////////////////////////////////////////////// added by M.minami (end)

module QLK0RRTC0V3_INTVLCOUNNT(RT0TEN, RTC_SELCK, PRESETZ, svmod_rtc, RT0LPM_RTCCLK_B, ITMCMP,
                               hourcount, daycount, RINTE, RINTE_RTC, INTRTCI, RT0TMON1);

input RT0TEN, RTC_SELCK, PRESETZ, svmod_rtc, RT0LPM_RTCCLK_B;
input[11:0] ITMCMP;
input RINTE;
input[5:0] hourcount, daycount;
output RINTE_RTC;
output INTRTCI, RT0TMON1;
reg RINTE_RTC, INTRTCI;

wire[11:0] ITMCNT, ITMCNT_data;

always@(posedge RTC_SELCK or negedge PRESETZ)begin
  if(!PRESETZ)begin
    RINTE_RTC <= 1'b0;
  end
  else if(RT0LPM_RTCCLK_B)begin
    RINTE_RTC <= RINTE;
  end
end

wire RT0TMON1 = RT0TEN & ITMCNT[11];
// wire[11:0] ITMCNT_data  = RT0TEN ? {hourcount[5:0], daycount[5:0]} : ITMCNT[11:0];
QLK0RRTC0V3_INTVLCOUNNT_SUB intvlc_sub
(.RT0TEN(RT0TEN), .ITMCNT(ITMCNT), .hourcount(hourcount), .daycount(daycount), .ITMCNT_data(ITMCNT_data));

wire[11:0] wd_ITMCNT    = {~(ITMCNT[11:1]), (ITMCNT[0] ^ (RINTE_RTC & (~svmod_rtc)))};
wire[11:1] ck_ITMCNT    = ~(ITMCNT[10:0]);
wire eq_ITMCNT_ITMCMP   = (ITMCNT_data[11:0] == ITMCMP[11:0]);
wire ITMCNT_RESB	= ~INTRTCI & RINTE;

wire res_INTRTCI = RT0TEN ? PRESETZ : RINTE;

always@(negedge RTC_SELCK or negedge res_INTRTCI)begin
  if(!res_INTRTCI)begin
    INTRTCI <= 1'b0;
  end
  else begin
    INTRTCI <= (~svmod_rtc) & RINTE_RTC & eq_ITMCNT_ITMCMP;
  end
end


QLK0RRTC0V3_BCNT bcnt0(.BCNT_CK(RTC_SELCK), .wd_BCNT(wd_ITMCNT[0]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[0]));
QLK0RRTC0V3_BCNT bcnt1(.BCNT_CK(ck_ITMCNT[1]), .wd_BCNT(wd_ITMCNT[1]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[1]));
QLK0RRTC0V3_BCNT bcnt2(.BCNT_CK(ck_ITMCNT[2]), .wd_BCNT(wd_ITMCNT[2]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[2]));
QLK0RRTC0V3_BCNT bcnt3(.BCNT_CK(ck_ITMCNT[3]), .wd_BCNT(wd_ITMCNT[3]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[3]));
QLK0RRTC0V3_BCNT bcnt4(.BCNT_CK(ck_ITMCNT[4]), .wd_BCNT(wd_ITMCNT[4]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[4]));
QLK0RRTC0V3_BCNT bcnt5(.BCNT_CK(ck_ITMCNT[5]), .wd_BCNT(wd_ITMCNT[5]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[5]));
QLK0RRTC0V3_BCNT bcnt6(.BCNT_CK(ck_ITMCNT[6]), .wd_BCNT(wd_ITMCNT[6]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[6]));
QLK0RRTC0V3_BCNT bcnt7(.BCNT_CK(ck_ITMCNT[7]), .wd_BCNT(wd_ITMCNT[7]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[7]));
QLK0RRTC0V3_BCNT bcnt8(.BCNT_CK(ck_ITMCNT[8]), .wd_BCNT(wd_ITMCNT[8]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[8]));
QLK0RRTC0V3_BCNT bcnt9(.BCNT_CK(ck_ITMCNT[9]), .wd_BCNT(wd_ITMCNT[9]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[9]));
QLK0RRTC0V3_BCNT bcnt10(.BCNT_CK(ck_ITMCNT[10]), .wd_BCNT(wd_ITMCNT[10]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[10]));
QLK0RRTC0V3_BCNT bcnt11(.BCNT_CK(ck_ITMCNT[11]), .wd_BCNT(wd_ITMCNT[11]), .BCNT_RESB(ITMCNT_RESB), .BCNT(ITMCNT[11]));

endmodule

module QLK0RRTC0V3_INTVLCOUNNT_SUB(
RT0TEN, ITMCNT, hourcount, daycount, ITMCNT_data);

input RT0TEN;
input[11:0] ITMCNT;
input[5:0] hourcount, daycount;
output[11:0] ITMCNT_data;

wire[11:0] ITMCNT_data  = RT0TEN ? {hourcount[5:0], daycount[5:0]} : ITMCNT[11:0];

endmodule

module QLK0RRTC0V3_INT	(
	RTC_SELCK,
	RTCRESB,
	RT0TEN,		// Ver1.20 add
	INTRCLK,		// Ver1.20 add

	svmod_rtc,
	rtce_rtc,
//	intvl_en,
	ct2,
	ct1,
	ct0,
	wale,
	walie,
//	wafg,			// Ver1.20 del
//	rinte,
//	ict2,
//	ict1,
//	ict0,
	wm40,
	wm20,
	wm10,
	wm8,
	wm4,
	wm2,
	wm1,
	wh20,
	wh10,
	wh8,
	wh4,
	wh2,
	wh1,
	ww6,
	ww5,
	ww4,
	ww3,
	ww2,
	ww1,
	ww0,

	seceq00,
	mincount,
	hourcount,
	weekcount,

	sub500ms,
	subtop,
	seceq59,
	hour_cu,
	day_cu,
	mon_cu,

//	int_1_95ms,
//	int_3_91ms,
//	int_7_81ms,
//	int_15_6ms,
//	int_31ms,
//	int_62ms,
//	int_125ms,
//	CLK32KHZ,

	wafg_rtc,
	rifg_rtc,		// Ver1.20 add
	wafg_rst,		// Ver1.20 add
	rifg_rst,		// Ver1.20 add
//	int_ct,			// Ver1.20 del
	intr,
//	intr2
	pulse1hz
	);

//--- port direction
input			RTC_SELCK;
input			RTCRESB;
input			RT0TEN;	// Ver1.20 add
input			INTRCLK;	// Ver1.20 add

input			svmod_rtc;
input			rtce_rtc;
//input			intvl_en;
input			ct2;
input			ct1;
input			ct0;
input			wale;
input			walie;
//input			wafg;		// Ver1.20 del
//input			rinte;
//input			ict2;
//input			ict1;
//input			ict0;
input			wm40;
input			wm20;
input			wm10;
input			wm8;
input			wm4;
input			wm2;
input			wm1;
input			wh20;
input			wh10;
input			wh8;
input			wh4;
input			wh2;
input			wh1;
input			ww6;
input			ww5;
input			ww4;
input			ww3;
input			ww2;
input			ww1;
input			ww0;

input			seceq00;
input	[6:0]	mincount;
input	[5:0]	hourcount;
input	[2:0]	weekcount;

input			sub500ms;
input			subtop;
input			seceq59;
input			hour_cu;
input			day_cu;
input			mon_cu;

//input			int_1_95ms;
//input			int_3_91ms;
//input			int_7_81ms;
//input			int_15_6ms;
//input			int_31ms;
//input			int_62ms;
//input			int_125ms;
//output			CLK32KHZ;

output			wafg_rtc;
output			rifg_rtc;		// Ver1.20 add
input			wafg_rst;		// Ver1.20 add
input			rifg_rst;		// Ver1.20 add
//output			int_ct;		// Ver1.20 del
output			intr;
//output			intr2;
input			pulse1hz;

//--- reg, wire
wire	[6:0]	wm;
wire	[5:0]	wh;
wire			minal_w;
wire			houral_w;
wire			weekal_w;
wire			alarm_wp;
wire			alarm_w;
reg				alarm_w_1t;
wire			alarm_w_trg;
reg				wafg_rtc;
reg				int_alarm;
wire			ct_trg;
wire			ict_trg;
reg				int_ct_pre; // Ver1.30 add
reg				int_ct;
reg				int_ict;
reg				alarm_w_trg_1t;	// Ver1.20 add
reg				rifg_rtc;		// Ver1.20 add


wire			wafg_scanclk;	// Ver1.20 add
wire			wafg_scanrst;	// Ver1.20 add
wire			rifg_scanclk;	// Ver1.20 add
wire			rifg_scanrst;	// Ver1.20 add

//--- logic

//ALARM
assign wm =	{wm40, wm20, wm10, wm8, wm4, wm2, wm1};
assign wh =	{wh20, wh10, wh8, wh4, wh2, wh1};

assign minal_w	= (mincount == wm);
assign houral_w	= (hourcount == wh);
assign weekal_w	= (weekcount == 3'b000) ? ww0
				: (weekcount == 3'b001) ? ww1
				: (weekcount == 3'b010) ? ww2
				: (weekcount == 3'b011) ? ww3
				: (weekcount == 3'b100) ? ww4
				: (weekcount == 3'b101) ? ww5
				: ww6;							//3'b110

assign alarm_wp	= (minal_w && houral_w && weekal_w);
//////////assign alarm_w	= (alarm_wp && seceq00);		//sync sec up
assign alarm_w	= (alarm_wp && seceq00 && sub500ms && (~pulse1hz));	//sync sec up

reg INTRTC_ALARM;

always@(negedge RTC_SELCK or negedge RTCRESB)begin
  if(!RTCRESB)begin
    INTRTC_ALARM <= 1'b0;
  end
  else if(rtce_rtc && (!svmod_rtc))begin
    INTRTC_ALARM <= alarm_w & wale;
  end
end

assign wafg_scanclk	= RT0TEN ? INTRCLK : INTRTC_ALARM;
assign wafg_scanrst	= RTCRESB & (!wafg_rst | RT0TEN);

always @(posedge wafg_scanclk or negedge wafg_scanrst) begin
	if (!wafg_scanrst) begin
		wafg_rtc	<= 1'b0;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		wafg_rtc	<= 1'b1;
	end
end


/* modified M.minami

always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		alarm_w_1t	<= 1'b0;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		alarm_w_1t	<= alarm_w;
	end
end

assign alarm_w_trg	= (alarm_w && (!alarm_w_1t));	//alarm_w rise edge

// Ver1.20 add --------------

//---------------------------

//wafg RTCCLK
// Ver1.20 mod --------------
//always @(posedge RTC_SELCK or negedge RTCRESB) begin
//	if (!RTCRESB) begin
//		wafg_rtc	<= 1'b0;
//	end
//	else if (rtce_rtc && (!svmod_rtc)) begin
//		if (!wale) begin		//alarm enable
//			wafg_rtc	<= 1'b0;
//		end
//		else if (alarm_w_trg) begin	//alarm detect
//			wafg_rtc	<= 1'b1;
//		end
//		else if (!wafg) begin		//alarm clr
//			wafg_rtc	<= 1'b0;
//		end
//		else begin
//			wafg_rtc	<= wafg_rtc;
//		end
//	end
//end


always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		alarm_w_trg_1t	<= 1'b0;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		if (!wale) begin		//alarm enable off
			alarm_w_trg_1t	<= 1'b0;
		end
		else begin
			alarm_w_trg_1t	<= alarm_w_trg;
		end
	end
end

assign wafg_scanclk	= (alarm_w_trg_1t & (!RT0TEN)) | (INTRCLK & RT0TEN);
assign wafg_scanrst	= RTCRESB & (!wafg_rst | RT0TEN);

always @(posedge wafg_scanclk or negedge wafg_scanrst) begin
	if (!wafg_scanrst) begin
		wafg_rtc	<= 1'b0;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		wafg_rtc	<= 1'b1;
	end
end
//---------------------------


//alarm int
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		int_alarm	<= 1'b0;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		if (!wale) begin		//alarm enable
			int_alarm	<= 1'b0;
		end
		else if (!walie) begin		//alarm int enable
			int_alarm	<= 1'b0;
		end
		else begin					//alarm 1shot 32.768MHz
			int_alarm	<= alarm_w_trg;
		end
	end
end

*/

//adjust interval signal
assign ct_trg	= ({ct2, ct1, ct0} == 3'b001) ? sub500ms			//500ms
				: ({ct2, ct1, ct0} == 3'b010) ? subtop				//1sec
				: ({ct2, ct1, ct0} == 3'b011) ? (subtop && seceq59)	//1min
				: ({ct2, ct1, ct0} == 3'b100) ? (subtop && hour_cu)	//1hour
				: ({ct2, ct1, ct0} == 3'b101) ? (subtop && day_cu)	//1day
				: ({ct2, ct1}      == 2'b11)  ? (subtop && mon_cu)	//1month
				: 1'b0;		//no interval int

// mod Ver1.30
//adjust interval int sync sec up
//////////always @(posedge RTCCLK or negedge RTCRESB) begin
//////////	if (!RTCRESB) begin
//////////		int_ct_pre	<= 1'b0;
//////////	end
//////////	else if (rtce_rtc && (!svmod_rtc)) begin
//////////		int_ct_pre	<= ct_trg;
//////////	end
//////////end

// mod Ver1.30
//adjust interval int sync sec up
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		int_ct_pre	<= 1'b0;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		int_ct_pre	<= ct_trg;
	end
end

always @(negedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		int_ct	<= 1'b0;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		int_ct	<= int_ct_pre;
	end
end

// Ver1.20 add --------------
assign rifg_scanclk	= (int_ct & (!RT0TEN)) | (INTRCLK & RT0TEN);
assign rifg_scanrst	= RTCRESB & (!rifg_rst | RT0TEN);

always @(posedge rifg_scanclk or negedge rifg_scanrst) begin
	if (!rifg_scanrst) begin
		rifg_rtc	<= 1'b0;
	end
	else if (rtce_rtc && (!svmod_rtc)) begin
		rifg_rtc	<= 1'b1;
	end
end
//---------------------------


//12bit counter interval signal
/*
assign ict_trg	= ({rinte, ict2, ict1, ict0} == 4'b1000) ? int_1_95ms	//1.95ms
				: ({rinte, ict2, ict1, ict0} == 4'b1001) ? int_3_91ms	//3.91ms
				: ({rinte, ict2, ict1, ict0} == 4'b1010) ? int_7_81ms	//7.81ms
				: ({rinte, ict2, ict1, ict0} == 4'b1011) ? int_15_6ms	//15.6ms
				: ({rinte, ict2, ict1, ict0} == 4'b1100) ? int_31ms		//31.25ms
				: ({rinte, ict2, ict1, ict0} == 4'b1101) ? int_62ms		//62.5ms
				: ({rinte, ict2, ict1      } == 3'b111 ) ? int_125ms	//125ms
				: 1'b0;		//no interval int

//12bit counter int sync xx10xx00
always @(posedge RTC_SELCK or negedge RTCRESB) begin
	if (!RTCRESB) begin
		int_ict	<= 1'b0;
	end
	else if (intvl_en && (!svmod_rtc)) begin
		int_ict	<= ict_trg;
	end
end

*/


//int
assign intr	= ((INTRTC_ALARM & walie) || int_ct);
//assign intr2	= int_ict;





endmodule

module QLK0RRTC0V3_SYNC_RT0LPM(RTC_SELCK, RTCRESB, RT0LPM, RT0LPM_RTCCLK_B);

input RTC_SELCK, RTCRESB, RT0LPM;
output RT0LPM_RTCCLK_B;

reg RT0LPM_RTCCLK;
wire RT0LPM_RTCCLK_B = ~(RT0LPM_RTCCLK);

always@(posedge RTC_SELCK or negedge RTCRESB)begin
  if(!RTCRESB)begin
    RT0LPM_RTCCLK <= 1'b0;
  end
  else begin
    RT0LPM_RTCCLK <= RT0LPM;
  end
end

endmodule

module QLK0RRTC0V3_CLKSEL(CKSEL, RTCCLK, INTRCLK, RTC_SELCK);

input CKSEL, RTCCLK, INTRCLK;
output RTC_SELCK;

wire RTC_SELCK = CKSEL ? INTRCLK : RTCCLK;


endmodule


module QLK0RRTC0V3_PCLK_CLKSEL(SCANMODE, PCLK, INTRCLK, PCLK_SELCK);

input SCANMODE, PCLK, INTRCLK;
output PCLK_SELCK;

wire PCLK_SELCK = SCANMODE ? INTRCLK : PCLK;


endmodule
