/************************************************************************/
/* Date		: 2010/02/03						*/
/* Version	: 1.0							*/
/* Designer	: Yuuji Ishiguro					*/
/* Note		: SS3rd用LVI代替回路と擬似LVI				*/
/************************************************************************/
/* updata								*/
/* Date		: 2010/02/10						*/
/* Version	: 1.1							*/
/* Note		: LVI検出の誤差補正					*/
/* Designer	: Yuuji Ishiguro					*/
/************************************************************************/
/* Date		: 2010/04/16						*/
/* Version	: 1.2							*/
/* Designer	: T.Tsunoda						*/
/* Note		: ・Macro名を変更。(LVIDSS3RD -> QAHREGOHNMAINV1_ICE)	*/
/*		: ・端子追加。(置き換え元のMacroと端子情報を合せる目的	*/
/*		:   で、置き換え元にあって、このMacroでは使わない端子を	*/
/*		:   全て持たせた。(Open or 端子処理)			*/
/*		: ・LVI出力にNoise対策でF/F一段挿入			*/
/*		: ・POCを追加(ice.resetctlから本Macroをthroughするだけ)	*/
/************************************************************************/
/* Date		: 2010/06/23						*/
/* Version	: 2.3							*/
/* Designer	: Y.Ishiguro						*/
/* Note		: ・擬似LVIの仕様変更。(INT & RESET MODE対応)		*/
/*		: ・割込みモード対応					*/
/* 		: ・Macro名を変更。(QAHREGOHNMAINV1_ICE ->		*/
/*		:				QAHREGOHNMAINV1_ICE)	*/
/************************************************************************/
/* Date		: 2010/07/14						*/
/* Version	: 2.4							*/
/* Designer	: Y.Ishiguro						*/
/* Note		: ・端子追加。(TEMPADJ3-0,AMPSEL,BGRTEST,TESTVOUT)	*/
/*		:   追加端子は全部Trimmingとテスト用			*/
/************************************************************************/
/* Date		: 2010/07/27						*/
/* Version	: 2.5							*/
/* Designer	: Y.Ishiguro						*/
/* Note		: POCREL5Vを0固定からPOCRESBのthroughに変更。port-iobuf	*/
/*		: のRTBFG端子追加に伴いresetb Macroを追加し,resetb用の	*/
/*		: POC Reset信号としてPOCREL5Vが必要となった為。		*/
/************************************************************************/
/* Date		: 2010/12/08						*/
/* Version	: 2.6							*/
/* Designer	: K.Hamada						*/
/* Note		: LVI検出電圧をCT4ボード(正式版)に合わせて微調整した。  */
/*              : 2.5版まではCT3ボードでTuningしていた。                */
/************************************************************************/
// $Id$

module QAHREGOHNMAINV2_ICE (
	LVIS3, LVIS2, LVIS1, LVIS0, LVIEN, LVIOUTZ, POCREL,
	SYSRESB, POCRESB, VDDLEV7, VDDLEV6, VDDLEV5, VDDLEV4, VDDLEV3, VDDLEV2, VDDLEV1,
	VDDLEV0, USBIFWR, PSEUDOON0, PSEUDOON8, PONRESB, OPLVIMDS1, OPLVIMDS0,
	BG1EN, RESFB5V, REGLV, REGLC, BGRT6, BGRT5, BGRT4, BGRT3, BGRT2, BGRT1, BGRT0,
	BG1ST, BG2ADEN, BG2ADSEL, LVITEST, LVITSEL, PAENB, SENSEVDD,
	VBG1, VBG08, BGIOREG2, BGIOREG1, VBG2AD, BGISUB3, BGISUB2, BGISUB1,
	REGDRV, PDRV, POCREL5V, 
	TEMPADJ3, TEMPADJ2, TEMPADJ1, TEMPADJ0, AMPSEL, BGRTEST, TESTVOUT
	);

	input	LVIS3;		// LVI検出電圧設定				(from csc)
	input	LVIS2;		// LVI検出電圧設定				(from csc)
	input	LVIS1;		// LVI検出電圧設定				(from csc)
	input	LVIS0;		// LVI検出電圧設定				(from csc)
	input	LVIEN;		// LVI動作許可信号				(from csc)
	output	LVIOUTZ;	// LVI出力					(to nf)
	output	POCREL;		// POC出力					(to nf)
	output	POCREL5V;	// POC出力(5V系)				(to resetb)
	/*--------------*/
	/* ICE用I/F	*/
	/*--------------*/
	input	SYSRESB;	// 本macro内F/FのReset用。(POCor端子Reset信号)	(from csc)
	input	POCRESB;	// POC入力					(from ice(resctl))
	input	VDDLEV7;	// チップ電圧の8bit A/D変換結果(bit7)		(from ice(host I/F))
	input	VDDLEV6;	// チップ電圧の8bit A/D変換結果(bit6)		(from ice(host I/F))
	input	VDDLEV5;	// チップ電圧の8bit A/D変換結果(bit5)		(from ice(host I/F))
	input	VDDLEV4;	// チップ電圧の8bit A/D変換結果(bit4)		(from ice(host I/F))
	input	VDDLEV3;	// チップ電圧の8bit A/D変換結果(bit3)		(from ice(host I/F))
	input	VDDLEV2;	// チップ電圧の8bit A/D変換結果(bit2)		(from ice(host I/F))
	input	VDDLEV1;	// チップ電圧の8bit A/D変換結果(bit1)		(from ice(host I/F))
	input	VDDLEV0;	// チップ電圧の8bit A/D変換結果(bit0)		(from ice(host I/F))
	input	USBIFWR;	// SG2外部バスI/F用クロック			(from ice(host I/F))
	input	PSEUDOON0;	// 擬似LVI信号(RESET MODE)			(from ice(pseudoemu))
	input	PSEUDOON8;	// 擬似LVI信号(INT & RESET MODE)		(from ice(pseudoemu))
	input	PONRESB;	// Power-ON Reset信号				(from reset block)
	input	OPLVIMDS1;	// LVIモード信号				(from ice())
	input	OPLVIMDS0;	// LVIモード信号				(from ice())

	/*----------------------*/
	/* 入力のみ(未使用端子)	*/
	/*----------------------*/
	input	BG1EN;		// CP向けBIASAMP Enable信号			(from flash_cp)
	input	RESFB5V;	// Reset信号					(from reset-buf)
	input	REGLV;		// REG出力電圧切り替え				(from csc)
	input	REGLC;		// 電流能力切り替え				(from csc)
	input	BGRT6;		// BGR Trimming信号				(from cibc)
	input	BGRT5;		// BGR Trimming信号				(from cibc)
	input	BGRT4;		// BGR Trimming信号				(from cibc)
	input	BGRT3;		// BGR Trimming信号				(from cibc)
	input	BGRT2;		// BGR Trimming信号				(from cibc)
	input	BGRT1;		// BGR Trimming信号				(from cibc)
	input	BGRT0;		// BGR Trimming信号				(from cibc)
	input	BG1ST;		// CP向けBIASAMP高速立ち上げ信号		(from flash_cp)
	input	BG2ADEN;	// A/D向けBIASAMP Enable信号			(from adctl)
	input	BG2ADSEL;	// A/D向けBIASAMP出力切替信号			(from adctl)
	input	LVITEST;	// LVIテストモード				(from csc)
	input	LVITSEL;	// LVIテストモードの検出対象Select		(from csc)
	input	PAENB;		// Pchアシスト機能の使用制限信号		(from csc)
	input	SENSEVDD;	// REG FeedBackライン				(to regd)
	input	TEMPADJ3;	// BGR出力の温度Trimming用入力信号		(from cibc)
	input	TEMPADJ2;	// BGR出力の温度Trimming用入力信号		(from cibc)
	input	TEMPADJ1;	// BGR出力の温度Trimming用入力信号		(from cibc)
	input	TEMPADJ0;	// BGR出力の温度Trimming用入力信号		(from cibc)
	input	AMPSEL;		// VBG2AD出力切り替え用信号			(from pulldown)
	input	BGRTEST;	// TESTVOUT切り替え信号				(from pulldown)
	/*----------------------*/
	/* 固定出力(未使用端子)	*/
	/*----------------------*/
	output	VBG1;		// CP向け基準電圧(0.8V)				(to flash_cp)
	output	VBG08;		// 0.8V BGR基準電圧出力				(to h_rosc)
	output	BGIOREG2;	// 32MOSC用電流源(TYP=50nA)			(to h_rosc)
	output	BGIOREG1;	// 32MOSC用電流源(TYP=50nA)			(to h_rosc)
	output	VBG2AD;		// A/D向け基準電圧(1.4V)/温度センサー出力	(to adhard)
	output	BGISUB3;	// SubOSC用電流源(TYP=60nA)			(to oscsub)
	output	BGISUB2;	// SubOSC用電流源(TYP=30nA)			(to oscsub)
	output	BGISUB1;	// SubOSC用電流源(TYP=10nA)			(to oscsub)
	output	REGDRV;		// REG出力					(to regd)
	output	PDRV;		// Pchアシスト用制御信号			(to regd)
	output	TESTVOUT;	// テスト用入出力信号				(to open)

	// [V1.01]
	// 1. lvivolを最新のMacro仕様書に合わせて修正
	// 1. LVI検出誤差補正｡-0.02V(検出levelは0.02Vずつしか変化できないため)
	reg [7:0]	lvivol;
	always @( LVIS3 or LVIS2 or LVIS1 or LVIS0 ) begin
		casex ( {LVIS3, LVIS2, LVIS1, LVIS0} ) //synopsys parallel_case

			//SG2からの8bitのA/D変換値(VDDLEV7-0)に対する比較Data (VDD/(5.5V/256))
			4'b0000    : lvivol = 8'b1000_0101 ; //2.87V(補正なし)
			4'b0001    : lvivol = 8'b0101_0110 ; //1.85V(補正なし)
			4'b0010    : lvivol = 8'b0101_0000 ; //1.74V(補正なし)
			4'b0011    : lvivol = 8'b0100_1100 ; //1.64V(補正なし)

			4'b0100    : lvivol = 8'b1000_1110 ; //3.07V(補正なし)
			4'b0101    : lvivol = 8'b0101_1111 ; //2.05V(補正なし)
			4'b0110    : lvivol = 8'b0101_1010 ; //1.95V(補正なし)
			4'b0111    : lvivol = 8'b0101_0110 ; //1.85V(補正なし)

			4'b1000    : lvivol = 8'b1010_1011 ; //3.68V(補正なし)
			4'b1001    : lvivol = 8'b0111_1011 ; //2.66V(補正なし)
			4'b1010    : lvivol = 8'b0111_0111 ; //2.56V(補正なし)
			4'b1011    : lvivol = 8'b0111_0010 ; //2.46V(補正なし)

			4'b1100    : lvivol = 8'b1011_1001 ; //3.99V(補正なし)
			4'b1101    : lvivol = 8'b1000_1010 ; //2.97V(補正なし)
			4'b1110    : lvivol = 8'b1000_0101 ; //2.87V(補正なし)
			4'b1111    : lvivol = 8'b1000_0000 ; //2.76V(補正なし)
		endcase
	end

	reg [7:0]	vddvol;
	always @( negedge SYSRESB or negedge USBIFWR ) begin
		if (!SYSRESB)
			vddvol <= 8'b1111_1111;
		else	vddvol <= { VDDLEV7, VDDLEV6, VDDLEV5, VDDLEV4,
				VDDLEV3, VDDLEV2, VDDLEV1, VDDLEV0 };
	end

	reg LVIOZ_pp;
	always @( LVIEN or vddvol or lvivol ) begin
		if (LVIEN) begin
			if (vddvol > lvivol)
				LVIOZ_pp <= 1'b1;
			else	LVIOZ_pp <= 1'b0;
		end
		else		LVIOZ_pp <= 1'b1;
	end

	// [V101] 追加. N/Fを削除したので必要.
	//LVI特性改善(lvivolの変化時に各ビットの変化でヒゲがでないようにする)
	reg LVIOZ_p;
	always @( negedge SYSRESB or negedge USBIFWR ) begin
		if ( !SYSRESB )	LVIOZ_p <= 1'b1;
		else		LVIOZ_p <= LVIOZ_pp;
	end

	// [V101]
	// (1)LVIOZ_pp -> LVIOZ_pへ
	// (2)LVIOZNFP->LVIOUTZへ信号名変更
	// 擬似LVI
	// assign	LVIOUTZ = LVIOZ_p & ~PSEUDOON0;

	// [V103]
	// 擬似LVI
	// 擬似LVI(INT)を発行してLVI検出電圧値が変ったら元に戻す。
	reg regst;
	always @(LVIEN or LVIS3 or LVIS2 or LVIS1 or LVIS0 ) begin
		casex ( {LVIEN,LVIS3, LVIS2, LVIS1, LVIS0} ) //synopsys parallel_case
		
			5'b10011 : regst =1'b1 ;
			5'b10111 : regst =1'b1 ;
			5'b11011 : regst =1'b1 ;
			5'b11111 : regst =1'b1 ;
 			default  : regst =1'b0 ;
		endcase
	end

	reg PSEUDOON8_m;
	always @( PSEUDOON8 or OPLVIMDS1 or OPLVIMDS0 ) begin
		casex ( {PSEUDOON8,OPLVIMDS1,OPLVIMDS0})

			3'b101 : PSEUDOON8_m = 1'b1 ;
			3'b110 : PSEUDOON8_m = 1'b1 ;
			default : PSEUDOON8_m = 1'b0 ;
		endcase
	end

	wire lvi_int;
	assign lvi_int = PSEUDOON8_m & ~regst;

	wire lvi_giji;
	assign	lvi_giji = lvi_int | PSEUDOON0;

	assign	LVIOUTZ = LVIOZ_p & ~lvi_giji;

//	N/F削除
//	reg [2:0] lvi;
//	always @(negedge USBIFWR or negedge SYSRESB) begin
//		if (!SYSRESB)	lvi <= 3'h7;
//		else		lvi <= { lvi[1], lvi[0] ,LVIOZ_pp };
//	end
	
//	reg LVIOZ;
//	always @(negedge USBIFWR) begin
//		if ((lvi[2]==LVIOZ_pp)&&(lvi[1]==LVIOZ_pp)&&(lvi[0]==LVIOZ_pp)) begin
//			LVIOZ <= lvi[2];
//		end
//	end

// 擬似LVI
//	assign	LVIOZNFP = LVIOZ & ~PSEUDOON0;

//
// POC
//
	assign	POCREL = POCRESB;
	assign	POCREL5V = POCRESB;	// [V205]

//
// 入力のみ(未使用端子)
//
	//BG1EN;		// from flash_cp
	//RESFB5V;		// reset-bufはICEでは実装しないので,入力を固定する
	//REGLV;		// from csc
	//REGLC;		// from csc
	//BGRT0;		// from cibc
	//BGRT1;		// from cibc
	//BGRT2;		// from cibc
	//BGRT3;		// from cibc
	//BGRT4;		// from cibc
	//BGRT5;		// from cibc
	//BGRT6;		// from cibc
	//BG1ST;		// from flash_cp
	//BG2ADEN;		// from adctl
	//BG2ADSEL;		// from adctl
	//LVITEST;		// from csc
	//LVITSEL;		// from csc
	//PAENB;		// from csc
	//SENSEVDD;		// from regd
	//TEMPADJ3;		// from cibc
	//TEMPADJ2;		// from cibc
	//TEMPADJ1;		// from cibc
	//TEMPADJ0;		// from cibc
	//AMPSEL;		// from flash_cp
	//BGRTEST;		//

//
// 固定出力(未使用端子)
//
	assign	VBG1 = 1'b0;		// to flash_cp
	assign	VBG08 = 1'b0;		// to h_rosc
	assign	BGIOREG1 = 1'b0;	// to h_rosc
	assign	BGIOREG2 = 1'b0;	// to h_rosc
	assign	VBG2AD = 1'b0;		// adhardはICEでは実装しないので,出力Openとなる
	assign	BGISUB1 = 1'b0;		// to oscsub
	assign	BGISUB2 = 1'b0;		// to oscsub
	assign	BGISUB3 = 1'b0;		// to oscsub
	assign	REGDRV = 1'b0;		// regdはICEでは実装しないので,出力Openとなる
	assign	PDRV = 1'b0;		// regdはICEでは実装しないので,出力Openとなる
	assign	TESTVOUT = 1'b0;	// 入出力信号だがICEでは使用しないので出力Openとする。

endmodule
	
