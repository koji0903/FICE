/************************************************************************/
/* Date		: 2009/11/18						*/
/* Version	: 100							*/
/* Designer	: T.Tsunoda						*/
/* Note		: SS3rd用main発振器.					*/
/*		: (1) 発振器の停止制御					*/
/*		: (2) 発振器兼用端子のデータ入力			*/
/*		: (3) ICE機能ClockBlockとの間でI/F			*/
/*		:     (CPUTMCLK->ClockBlock->CPUMCLK->OSCOUTM)		*/
/*		: [ SS2ndからの変更点 ]					*/
/*		: other_ifにあったものから分離。			*/
/************************************************************************/
/* Date		: 2010/04/16						*/
/* Version	: 101							*/
/* Designer	: T.Tsunoda						*/
/* Note		: ・Macro名を変更。(OSCMAIN -> QAHMOS0HNV1_ICE)		*/
/*		: ・端子追加。(置き換え元のMacroと端子情報を合せる目的	*/
/*		:   で、置き換え元にあって、このMacroでは使わない端子を	*/
/*		:   全て持たせた。(Open or 端子処理)			*/
/************************************************************************/
// $Id$

module QAHMOS0HNV1_ICE (
	OSCSEL, EXCLK, X1, X1ENI, X1DIN, X2, X2ENI, X2DIN, MSTOP, OSCOUTM,
	CPUTMCLK,CPUMCLK,
	RESETB, MDLYCUT, AMPH
		);

	input	OSCSEL;		// OSCモード(H),入力Portモード(L)選択信号	(from csc)
	input	EXCLK;		// EXCLKモード信号(H)				(from csc)
	input	X1;		// 発振子接続 or 入出力(ICEは入力)		(from 端子)
	input	X1ENI;		// 入力Portモード時,X1 Input Enable		(from port12)
	output	X1DIN;		// 入力Portモード時,X1兼用端子データ入力	(to port12)
	input	X2;		// 発振子接続 or 入出力(ICEは入力)		(from 端子)
	input	X2ENI;		// 入力Portモード時,X2 Input Enable		(from port12)
	output	X2DIN;		// 入力Portモード時,X2兼用端子データ入力	(to port12)
	input	MSTOP;		// OSCモード時,発振停止(H)			(from csc)
	output	OSCOUTM;	// OSCモード時,発振出力(CPUMCLKの停止制御後)	(to csc)
	/*--------------*/
	/* ICE用I/F	*/
	/*--------------*/
	output	CPUTMCLK;	// X2兼用端子Clock入力				(to clock block)
	input	CPUMCLK;	// Main Clock(ICE生成Clockと選択後)		(from clock block)
	/*----------------------*/
	/* 入力のみ(未使用端子)	*/
	/*----------------------*/
	input	RESETB;		// OSC用ノイズFilterのReset信号			(from csc)
	input	MDLYCUT;	// Filter制御(H:N/F通過前,L:N/F通過後)		(from modectl)
	input	AMPH;		// OSCのAMP Dimension切替(1:20MHz,0:10MHz)	(from csc)

	// ------------------------------------------------
	// port12データ入力とClockブロックに渡す端子Clock -
	// ------------------------------------------------
	// --- Main OSC入力 ---
	wire	oscmode_m	= OSCSEL & ~EXCLK;
	wire	exclkmode_m	= OSCSEL &  EXCLK;
	assign	CPUTMCLK = (oscmode_m) ? X2 : (exclkmode_m) ? ~X2 : 1'b0;
	
	// --- p121(x1),p122(x2) ---
	assign	X1DIN = X1 & X1ENI & ~oscmode_m;
	assign	X2DIN = X2 & X2ENI & ~OSCSEL;
	
	// ------------------------------------------------
	// ClockブロックからのClockをCSCに渡す            -
	// ------------------------------------------------
	// --- baseck ---
	wire	main_en	= OSCSEL & ~MSTOP;
	assign	OSCOUTM	= CPUMCLK & main_en;

	
endmodule

