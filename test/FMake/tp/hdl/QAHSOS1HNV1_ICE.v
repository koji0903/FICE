/************************************************************************/
/* Date		: 2009/11/18						*/
/* Revision	: 100							*/
/* Designer	: T.Tsunoda						*/
/* Note		: SS3rd用sub発振器.					*/
/*		: (1) 発振器の停止制御					*/
/*		: (2) 発振器兼用端子のデータ入力			*/
/*		: (4) RTCCLKの出力(OSCOUTSと同一だが、Enable信号を持つ)	*/
/*		: (3) ICE機能ClockBlockとの間でI/F			*/
/*		:     (CPUTSCLK->ClockBlock->CPUSCLK->OSCOUTS)		*/
/*		: [ SS2ndからの変更点 ]					*/
/*		: other_ifにあったものから分離。			*/
/************************************************************************/
/* Date		: 2010/04/16						*/
/* Version	: 101							*/
/* Designer	: T.Tsunoda						*/
/* Note		: ・Macro名を変更。(OSCSUB -> QAHSOS1HNV1_ICE)		*/
/*		: ・端子追加。(置き換え元のMacroと端子情報を合せる目的	*/
/*		:   で、置き換え元にあって、このMacroでは使わない端子を	*/
/*		:   全て持たせた。(Open or 端子処理)			*/
/************************************************************************/
// $Id$

module QAHSOS1HNV1_ICE (
	OSCSELS, EXCLKS,
	XT1, XT1ENI, XT1DIN, XT2, XT2ENI, XT2DIN, XTSTOP, CPUCLKEN, RTCCLKEN, OSCOUTS, RTCCLK,
	CPUTSCLK, CPUSCLK,
	AMPHS0, AMPHS1, XTWKUP, BGISUB1, BGISUB2, BGISUB3
	);

	input	OSCSELS;	// OSCモード時，入力モード選択(H:OSC,L:I/O)	(from csc)
	input	EXCLKS;		// EXCLKモード信号(H)				(from csc)
	input	XT1;		// XT1端子入力					(from 端子)
	input	XT1ENI;		// 入力ポートモード時，XT1入力許可信号(H)	(from port12)
	output	XT1DIN;		// 入力ポートモード時，XT1入力データ		(to port12)
	input	XT2;		// XT2端子入力					(from 端子)
	input	XT2ENI;		// 入力ポートモード時，XT2入力許可信号(H)	(from port12)
	output	XT2DIN;		// 入力ポートモード時，XT2入力データ		(to port12)
	input	XTSTOP;		// OSCモード時，発振停止(H)			(from csc)
	input	CPUCLKEN;	// OSCモード時，CPU用subクロック許可信号(H)	(from csc)
	input	RTCCLKEN;	// OSCモード時，RTC用subクロック許可信号(H)	(from csc)
	output	OSCOUTS;	// OSCモード時，CPU用subクロック出力		(to csc)
	output	RTCCLK;		// OSCモード時，RTC用subクロック出力		(to rtc)
	/*--------------*/
	/* ICE用I/F	*/
	/*--------------*/
	output	CPUTSCLK;	// XT2兼用端子Clock入力				(to clock block)
	input	CPUSCLK;	// Sub Clock(ICE生成Clockと選択後)		(from clock block)
	/*----------------------*/
	/* 入力のみ(未使用端子)	*/
	/*----------------------*/
	input	AMPHS0;		// AMP電流切替信号				(from csc)
	input	AMPHS1;		// AMP電流切替信号				(from csc)
	input	XTWKUP;		// 電流を増やしサブOSCの高速起動を可能にする	(from csc)
	input	BGISUB1;	// BGRからtyp:60nAの定電流を貰う		(from regm)
	input	BGISUB2;	// BGRからtyp:60nAの定電流を貰う		(from regm)
	input	BGISUB3;	// BGRからtyp:60nAの定電流を貰う		(from regm)

	// ------------------------------------------------
	// port12データ入力とClockブロックに渡す端子Clock -
	// ------------------------------------------------
	// --- Sub OSC入力 ---
	wire	oscmode_s	= OSCSELS & ~EXCLKS;
	wire	exclkmode_s	= OSCSELS &  EXCLKS;
	assign	CPUTSCLK = (oscmode_s) ? XT2 : (exclkmode_s) ? ~XT2 : 1'b0;
	
	// --- p123(xt1),p124(xt2) ---
	assign	XT1DIN = XT1 & XT1ENI & ~oscmode_s;
	assign	XT2DIN = XT2 & XT2ENI & ~OSCSELS;
	
	// ------------------------------------------------
	// ClockブロックからのClockをCSC,RTCに渡す        -
	// ------------------------------------------------
	// --- sub clk ---
	wire	sub_en	 = OSCSELS & ~XTSTOP;
	wire	OSCOUT	 = CPUSCLK & sub_en;
	wire	OSCOUTSp = CPUCLKEN & OSCOUT;
	wire	RTCCLKp	 = RTCCLKEN & OSCOUT;
	BUFG sub_bufg ( .O(OSCOUTS), .I(OSCOUTSp) );	// kx3 device df2.0ではここをClock宣言している
	BUFG rtc_bufg ( .O(RTCCLK), .I(RTCCLKp) );	// kx3 device df2.0ではここをClock宣言している

endmodule

