// =======================================================================================================
// Bfore Break unit
//
// ver100	initial version		Y.Tsuchiya
// ver101	Modified (V101)		T.Tsunoda
// 
// $Id: bforebreak.v,v 1.6 2007-10-03 04:09:37 tsuno3 Exp $
// =======================================================================================================
//設定された実行前ブレークアドレスデータとPA19-2の一致にて，
//格納している実行前ブレークデータをメモリーブロックに出力する。

module BFOREBREAK (
		ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25,
		ICEIFA24, ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18,
		ICEIFA17, ICEIFA16, ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11,
		ICEIFA10, ICEIFA9,  ICEIFA8,  ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,
		ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0,
		ICEDI31,  ICEDI30,  ICEDI29,  ICEDI28,  ICEDI27,  ICEDI26,  ICEDI25,
		ICEDI24,  ICEDI23,  ICEDI22,  ICEDI21,  ICEDI20,  ICEDI19,  ICEDI18,
		ICEDI17,  ICEDI16,  ICEDI15,  ICEDI14,  ICEDI13,  ICEDI12,  ICEDI11,
		ICEDI10,  ICEDI9,   ICEDI8,   ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4,
		ICEDI3,   ICEDI2,   ICEDI1,   ICEDI0,
		ICEWR,
		ICEDO31,  ICEDO30,  ICEDO29,  ICEDO28,  ICEDO27,  ICEDO26,  ICEDO25,
		ICEDO24,  ICEDO23,  ICEDO22,  ICEDO21,  ICEDO20,  ICEDO19,  ICEDO18,
		ICEDO17,  ICEDO16,  ICEDO15,  ICEDO14,  ICEDO13,  ICEDO12,  ICEDO11,
		ICEDO10,  ICEDO9,   ICEDO8,   ICEDO7,   ICEDO6,   ICEDO5,   ICEDO4,
		ICEDO3,   ICEDO2,   ICEDO1,   ICEDO0,
		PA19, PA18, PA17, PA16, PA15, PA14, PA13,
		PA12, PA11, PA10, PA9,  PA8,  PA7,  PA6,
		PA5,  PA4,  PA3,  PA2,
		BFBRKPID31, BFBRKPID30, BFBRKPID29, BFBRKPID28, BFBRKPID27, BFBRKPID26, BFBRKPID25,
		BFBRKPID24, BFBRKPID23, BFBRKPID22, BFBRKPID21, BFBRKPID20, BFBRKPID19, BFBRKPID18,
		BFBRKPID17, BFBRKPID16, BFBRKPID15, BFBRKPID14, BFBRKPID13, BFBRKPID12, BFBRKPID11,
		BFBRKPID10, BFBRKPID9,  BFBRKPID8,  BFBRKPID7,  BFBRKPID6,  BFBRKPID5,  BFBRKPID4,
		BFBRKPID3,  BFBRKPID2,  BFBRKPID1,  BFBRKPID0,
		BFBRKSEL,
		SYSRSOUTB,
		BASECK,
		FLREAD,
		SVMODF,
		PCWAITF	// (V101)
		);
// -------------------------------------------------------------------------------------------------------
//                      Port Difinition
// -------------------------------------------------------------------------------------------------------
input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28,	// Host I/F Address Bus			( <- eva_pcifg )
	ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,	//
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,	//
	ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,	//
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,	//
	ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,	//
	ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,	//
	ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0 ;	//
input	ICEDI31,  ICEDI30,  ICEDI29,  ICEDI28,	// Host I/F Write Data Bus		( <- eva_pcifg )
	ICEDI27,  ICEDI26,  ICEDI25,  ICEDI24,	//
	ICEDI23,  ICEDI22,  ICEDI21,  ICEDI20,	//
	ICEDI19,  ICEDI18,  ICEDI17,  ICEDI16,	//
	ICEDI15,  ICEDI14,  ICEDI13,  ICEDI12,	//
	ICEDI11,  ICEDI10,  ICEDI9,   ICEDI8,	//
	ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4,	//
	ICEDI3,   ICEDI2,   ICEDI1,   ICEDI0 ;	//
input	ICEWR ;					// Host I/F Write Strobe		( <- eva_pcifg )
output	ICEDO31, ICEDO30, ICEDO29, ICEDO28,	// Host I/F Read Data Bus		( -> eva_pcifg )
	ICEDO27, ICEDO26, ICEDO25, ICEDO24,	//
	ICEDO23, ICEDO22, ICEDO21, ICEDO20,	//
	ICEDO19, ICEDO18, ICEDO17, ICEDO16,	//
	ICEDO15, ICEDO14, ICEDO13, ICEDO12,	//
	ICEDO11, ICEDO10, ICEDO9,  ICEDO8,	//
	ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,	//
	ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0 ;	//
input	PA19, PA18, PA17, PA16,			// Flash Address Bus			( <- eva_core )
	PA15, PA14, PA13, PA12, 		//
	PA11, PA10, PA9,  PA8,  		//
	PA7,  PA6,  PA5,  PA4, 			//
	PA3,  PA2 ;				//
output	BFBRKPID31, BFBRKPID30, BFBRKPID29, BFBRKPID28,	// Bfore Break Data Bus		( -> MEMORY )
	BFBRKPID27, BFBRKPID26, BFBRKPID25, BFBRKPID24,	//
	BFBRKPID23, BFBRKPID22, BFBRKPID21, BFBRKPID20,	//
	BFBRKPID19, BFBRKPID18, BFBRKPID17, BFBRKPID16,	//
	BFBRKPID15, BFBRKPID14, BFBRKPID13, BFBRKPID12,	//
	BFBRKPID11, BFBRKPID10, BFBRKPID9,  BFBRKPID8,	//
	BFBRKPID7,  BFBRKPID6,  BFBRKPID5,  BFBRKPID4,	//
	BFBRKPID3,  BFBRKPID2,  BFBRKPID1,  BFBRKPID0 ;	//
output	BFBRKSEL ;				// Bfore Break Select singnal		( -> MEMORY  )
input	BASECK ;				// CPU Base Clock			( <- clock )
input	SYSRSOUTB ;				// System Reset Signal			( <- resetctl )
input	FLREAD ;				// Flash reading timing signal		( <- eva_core )
input	SVMODF ;				// Super Viser mode (fetch access)	( <- eva_core )
input	PCWAITF ;				// program counter wait signal		( <- eva_core ) (V101)
// -------------------------------------------------------------------------------------------------------
//                      END of Port Difinition
// -------------------------------------------------------------------------------------------------------
	reg [31:0]	bfbreakpid;
	reg [7:0]	bfbrkctl ;
	reg 		BFBRKSEL ;
	wire [31:0]	iceifa, icedi, bfbrkdt_ro,
			bfbrkdt0_ro, bfbrkdt1_ro, bfbrkdt2_ro, bfbrkdt3_ro,
			bfbrkdt4_ro, bfbrkdt5_ro, bfbrkdt6_ro, bfbrkdt7_ro,
			bfbrkdt0, bfbrkdt1, bfbrkdt2, bfbrkdt3, 
			bfbrkdt4, bfbrkdt5, bfbrkdt6, bfbrkdt7;
	wire [19:0]	bfbrkadr_ro, bfbrkadr0_ro, bfbrkadr1_ro, bfbrkadr2_ro, bfbrkadr3_ro, 
			bfbrkadr4_ro, bfbrkadr5_ro, bfbrkadr6_ro, bfbrkadr7_ro ;
	wire [17:0]	pa ;
	wire [7:0]	bfbrkctl_ro ;
	wire		bforebreak_cs,
			bfbrkctl_cs, 
			bfbrksel_on,
			bfbrkadr0_cs, bfbrkadr1_cs, bfbrkadr2_cs, bfbrkadr3_cs,
			bfbrkadr4_cs, bfbrkadr5_cs, bfbrkadr6_cs, bfbrkadr7_cs,
			bfbrkdt0_cs, bfbrkdt1_cs, bfbrkdt2_cs, bfbrkdt3_cs,
			bfbrkdt4_cs, bfbrkdt5_cs, bfbrkdt6_cs, bfbrkdt7_cs,
			fa_meet0, fa_meet1, fa_meet2, fa_meet3,
			fa_meet4, fa_meet5, fa_meet6, fa_meet7,
			bfbrksel_on0, bfbrksel_on1, bfbrksel_on2, bfbrksel_on3,
			bfbrksel_on4, bfbrksel_on5, bfbrksel_on6, bfbrksel_on7,
			FLREAD, SVMODF;

	assign iceifa = {ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26,
			 ICEIFA25, ICEIFA24, ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
			 ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16, ICEIFA15, ICEIFA14,
			 ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
			 ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,  ICEIFA3,  ICEIFA2,
			 ICEIFA1,  ICEIFA0} ;

	assign icedi = { ICEDI31,  ICEDI30,  ICEDI29,  ICEDI28,  ICEDI27,  ICEDI26,
			 ICEDI25,  ICEDI24,  ICEDI23,  ICEDI22,  ICEDI21,  ICEDI20,
			 ICEDI19,  ICEDI18,  ICEDI17,  ICEDI16,  ICEDI15,  ICEDI14,
			 ICEDI13,  ICEDI12,  ICEDI11,  ICEDI10,  ICEDI9,   ICEDI8,
			 ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4,   ICEDI3,   ICEDI2,
			 ICEDI1,   ICEDI0 } ;

	assign	ICEDO31 = bfbrkdt_ro[31] ;
	assign	ICEDO30 = bfbrkdt_ro[30] ;
	assign	ICEDO29 = bfbrkdt_ro[29] ;
	assign	ICEDO28 = bfbrkdt_ro[28] ;
	assign	ICEDO27 = bfbrkdt_ro[27] ;
	assign	ICEDO26 = bfbrkdt_ro[26] ;
	assign	ICEDO25 = bfbrkdt_ro[25] ;
	assign	ICEDO24 = bfbrkdt_ro[24] ;
	assign	ICEDO23 = bfbrkdt_ro[23] ;
	assign	ICEDO22 = bfbrkdt_ro[22] ;
	assign	ICEDO21 = bfbrkdt_ro[21] ;
	assign	ICEDO20 = bfbrkdt_ro[20] ;
	assign	ICEDO19 = bfbrkdt_ro[19] | bfbrkadr_ro[19] ;
	assign	ICEDO18 = bfbrkdt_ro[18] | bfbrkadr_ro[18] ;
	assign	ICEDO17 = bfbrkdt_ro[17] | bfbrkadr_ro[17] ;
	assign	ICEDO16 = bfbrkdt_ro[16] | bfbrkadr_ro[16] ;
	assign	ICEDO15 = bfbrkdt_ro[15] | bfbrkadr_ro[15] ;
	assign	ICEDO14 = bfbrkdt_ro[14] | bfbrkadr_ro[14] ;
	assign	ICEDO13 = bfbrkdt_ro[13] | bfbrkadr_ro[13] ;
	assign	ICEDO12 = bfbrkdt_ro[12] | bfbrkadr_ro[12] ;
	assign	ICEDO11 = bfbrkdt_ro[11] | bfbrkadr_ro[11] ;
	assign	ICEDO10 = bfbrkdt_ro[10] | bfbrkadr_ro[10] ;
	assign	ICEDO9  = bfbrkdt_ro[9]  | bfbrkadr_ro[9]  ;
	assign	ICEDO8  = bfbrkdt_ro[8]  | bfbrkadr_ro[8]  ;
	assign	ICEDO7  = bfbrkdt_ro[7]  | bfbrkadr_ro[7]  | bfbrkctl_ro[7]  ;
	assign	ICEDO6  = bfbrkdt_ro[6]  | bfbrkadr_ro[6]  | bfbrkctl_ro[6]  ;
	assign	ICEDO5  = bfbrkdt_ro[5]  | bfbrkadr_ro[5]  | bfbrkctl_ro[5]  ;
	assign	ICEDO4  = bfbrkdt_ro[4]  | bfbrkadr_ro[4]  | bfbrkctl_ro[4]  ;
	assign	ICEDO3  = bfbrkdt_ro[3]  | bfbrkadr_ro[3]  | bfbrkctl_ro[3]  ;
	assign	ICEDO2  = bfbrkdt_ro[2]  | bfbrkadr_ro[2]  | bfbrkctl_ro[2]  ;
	assign	ICEDO1  = bfbrkdt_ro[1]  | bfbrkadr_ro[1]  | bfbrkctl_ro[1]  ;
	assign	ICEDO0  = bfbrkdt_ro[0]  | bfbrkadr_ro[0]  | bfbrkctl_ro[0]  ;

	assign	bfbrkadr_ro = bfbrkadr0_ro | bfbrkadr1_ro | bfbrkadr2_ro | bfbrkadr3_ro | 
			      bfbrkadr4_ro | bfbrkadr5_ro | bfbrkadr6_ro | bfbrkadr7_ro;

	assign	bfbrkdt_ro  = bfbrkdt0_ro | bfbrkdt1_ro | bfbrkdt2_ro | bfbrkdt3_ro | 
			      bfbrkdt4_ro | bfbrkdt5_ro | bfbrkdt6_ro | bfbrkdt7_ro;

	assign pa = {	PA19, PA18, PA17, PA16, PA15, PA14, 
		 	PA13, PA12, PA11, PA10, PA9,  PA8,  
		 	PA7,  PA6,  PA5,  PA4,  PA3,  PA2	} ;

	assign	{BFBRKPID31,  BFBRKPID30,  BFBRKPID29,  BFBRKPID28,  BFBRKPID27,  BFBRKPID26,
		 BFBRKPID25,  BFBRKPID24,  BFBRKPID23,  BFBRKPID22,  BFBRKPID21,  BFBRKPID20,
		 BFBRKPID19,  BFBRKPID18,  BFBRKPID17,  BFBRKPID16,  BFBRKPID15,  BFBRKPID14,
		 BFBRKPID13,  BFBRKPID12,  BFBRKPID11,  BFBRKPID10,  BFBRKPID9,   BFBRKPID8,
		 BFBRKPID7,   BFBRKPID6,   BFBRKPID5,   BFBRKPID4,   BFBRKPID3,   BFBRKPID2,
		 BFBRKPID1,   BFBRKPID0 }  = bfbreakpid ;


// ------------------------------
// host io
// ------------------------------

	assign	bforebreak_cs	= (iceifa[31:8] == 24'h0840_30) ? 1'b1:1'b0;
	assign	bfbrkadr0_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0000_0000)) ? 1'b1 : 1'b0 ;
	assign	bfbrkadr1_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0000_0100)) ? 1'b1 : 1'b0 ;
	assign	bfbrkadr2_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0000_1000)) ? 1'b1 : 1'b0 ;
	assign	bfbrkadr3_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0000_1100)) ? 1'b1 : 1'b0 ;
	assign	bfbrkadr4_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0001_0000)) ? 1'b1 : 1'b0 ;
	assign	bfbrkadr5_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0001_0100)) ? 1'b1 : 1'b0 ;
	assign	bfbrkadr6_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0001_1000)) ? 1'b1 : 1'b0 ;
	assign	bfbrkadr7_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0001_1100)) ? 1'b1 : 1'b0 ;
	assign	bfbrkdt0_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0010_0000)) ? 1'b1 : 1'b0 ;
	assign	bfbrkdt1_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0010_0100)) ? 1'b1 : 1'b0 ;
	assign	bfbrkdt2_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0010_1000)) ? 1'b1 : 1'b0 ;
	assign	bfbrkdt3_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0010_1100)) ? 1'b1 : 1'b0 ;
	assign	bfbrkdt4_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0011_0000)) ? 1'b1 : 1'b0 ;
	assign	bfbrkdt5_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0011_0100)) ? 1'b1 : 1'b0 ;
	assign	bfbrkdt6_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0011_1000)) ? 1'b1 : 1'b0 ;
	assign	bfbrkdt7_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0011_1100)) ? 1'b1 : 1'b0 ;
	assign	bfbrkctl_cs	= (bforebreak_cs & (iceifa[7:0] == 8'b0100_0000)) ? 1'b1 : 1'b0 ;

// ---------------------------------------------------------------------------------------------------
//	Bfore Break Address Detection Control register  (BFBRKCTL)
// ---------------------------------------------------------------------------------------------------

	reg [7:0] bfbrkctl_p;
	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB )       bfbrkctl_p <= 8'b0 ;
		else if ( bfbrkctl_cs )	bfbrkctl_p <= icedi[7:0] ;
	end
	
	// (V101) 制御レジスタの設定とアドレス／データ設定レジスタの設定タイミングがズレないよう
	//        BASECKで切り直す。設定には順番があり、必ずbfbrkctl-OFF→各設定→bfbrkctl-ONとす
	//        る。これらにより、設定アドレス等が変化点で切り直されてもbfbrkctlでmaskされる。
	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB) bfbrkctl <= 8'h0;
		else bfbrkctl <= bfbrkctl_p;
	end
	assign	bfbrkctl_ro = bfbrkctl_cs ? bfbrkctl : 8'b0;

// ---------------------------------------------------------------------------------------------------
//	MASK
// ---------------------------------------------------------------------------------------------------

	assign	bfbrksel_on0 = bfbrkctl[0] ?  fa_meet0 : 1'b0;
	assign	bfbrksel_on1 = bfbrkctl[1] ?  fa_meet1 : 1'b0;
	assign	bfbrksel_on2 = bfbrkctl[2] ?  fa_meet2 : 1'b0;
	assign	bfbrksel_on3 = bfbrkctl[3] ?  fa_meet3 : 1'b0;
	assign	bfbrksel_on4 = bfbrkctl[4] ?  fa_meet4 : 1'b0;
	assign	bfbrksel_on5 = bfbrkctl[5] ?  fa_meet5 : 1'b0;
	assign	bfbrksel_on6 = bfbrkctl[6] ?  fa_meet6 : 1'b0;
	assign	bfbrksel_on7 = bfbrkctl[7] ?  fa_meet7 : 1'b0;

// ---------------------------------------------------------------------------------------------------
//	Bfore Break Address Detection Control signal (BFBRKSEL)
// ---------------------------------------------------------------------------------------------------

	assign	bfbrksel_on = bfbrksel_on0 | bfbrksel_on1 | bfbrksel_on2 | bfbrksel_on3 | 
			      bfbrksel_on4 | bfbrksel_on5 | bfbrksel_on6 | bfbrksel_on7;

	// (V101) FLREADのRead Address Timingのみを使用.Data出力Timingを使用すると
	//        Flash Readの次のPA一致によるBFBRKSEL信号出力がMaskされてしまう為.
	wire flreadadr_en;
	assign	flreadadr_en = FLREAD & PCWAITF;

	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB )       BFBRKSEL <= 1'b0 ;
		else if ( bfbrksel_on & !SVMODF & !flreadadr_en )
					BFBRKSEL <= 1'b1 ;
		else			BFBRKSEL <= 1'b0 ;
	end

// ---------------------------------------------------------------------------------------------------
//	Bfore Break Data Bus output
//	(実行前フ゛レークアト゛レスの設定が重複した場合，書換えデータの優先順位はBFBRKDT0→7となる)
//	(↑アト゛レスが同じであれば書き換えるデータは同じなので特に問題なし)
// ---------------------------------------------------------------------------------------------------
// (V101) アドレスが同じでも書き換えるデータが同じとは限らないのでデータ出力条件にUnitのEnableを追加.

	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)		bfbreakpid <= 32'b0 ;
		else if (bfbrksel_on0)	bfbreakpid <= bfbrkdt0;
		else if (bfbrksel_on1)	bfbreakpid <= bfbrkdt1;
		else if (bfbrksel_on2)	bfbreakpid <= bfbrkdt2;
		else if (bfbrksel_on3)	bfbreakpid <= bfbrkdt3;
		else if (bfbrksel_on4)	bfbreakpid <= bfbrkdt4;
		else if (bfbrksel_on5)	bfbreakpid <= bfbrkdt5;
		else if (bfbrksel_on6)	bfbreakpid <= bfbrkdt6;
		else if (bfbrksel_on7)	bfbreakpid <= bfbrkdt7;
		else			bfbreakpid <= 32'b0 ;
	end

// ---------------------------------------------------------------------------------------------------
//	bfore break address register (BFBRKADR7-0)
// ---------------------------------------------------------------------------------------------------

	bfbrkadr	bfbrkadr0 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkadr_cs(bfbrkadr0_cs),
				.icedi(icedi), .pa(pa), .fa_meet(fa_meet0), .bfbrkadr_ro(bfbrkadr0_ro)
			) ;
	bfbrkadr	bfbrkadr1 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkadr_cs(bfbrkadr1_cs),
				.icedi(icedi), .pa(pa), .fa_meet(fa_meet1), .bfbrkadr_ro(bfbrkadr1_ro)
			) ;
	bfbrkadr	bfbrkadr2 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkadr_cs(bfbrkadr2_cs),
				.icedi(icedi), .pa(pa), .fa_meet(fa_meet2), .bfbrkadr_ro(bfbrkadr2_ro)
			) ;
	bfbrkadr	bfbrkadr3 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkadr_cs(bfbrkadr3_cs),
				.icedi(icedi), .pa(pa), .fa_meet(fa_meet3), .bfbrkadr_ro(bfbrkadr3_ro)
			) ;
	bfbrkadr	bfbrkadr4 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkadr_cs(bfbrkadr4_cs),
				.icedi(icedi), .pa(pa), .fa_meet(fa_meet4), .bfbrkadr_ro(bfbrkadr4_ro)
			) ;
	bfbrkadr	bfbrkadr5 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkadr_cs(bfbrkadr5_cs),
				.icedi(icedi), .pa(pa), .fa_meet(fa_meet5), .bfbrkadr_ro(bfbrkadr5_ro)
			) ;
	bfbrkadr	bfbrkadr6 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkadr_cs(bfbrkadr6_cs),
				.icedi(icedi), .pa(pa), .fa_meet(fa_meet6), .bfbrkadr_ro(bfbrkadr6_ro)
			) ;
	bfbrkadr	bfbrkadr7 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkadr_cs(bfbrkadr7_cs),
				.icedi(icedi), .pa(pa), .fa_meet(fa_meet7), .bfbrkadr_ro(bfbrkadr7_ro)
			) ;

// ---------------------------------------------------------------------------------------------------
//	bfore break data register (BFBRKDT7-0)
// ---------------------------------------------------------------------------------------------------

	bfbrkdtreg		bfbrkdtreg0 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkdt_cs(bfbrkdt0_cs),
				.icedi(icedi), .bfbrkdt_ro(bfbrkdt0_ro), .bfbrkdt(bfbrkdt0)
			) ;
	bfbrkdtreg		bfbrkdtreg1 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkdt_cs(bfbrkdt1_cs),
				.icedi(icedi), .bfbrkdt_ro(bfbrkdt1_ro), .bfbrkdt(bfbrkdt1)
			) ;
	bfbrkdtreg		bfbrkdtreg2 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkdt_cs(bfbrkdt2_cs),
				.icedi(icedi), .bfbrkdt_ro(bfbrkdt2_ro), .bfbrkdt(bfbrkdt2)
			) ;
	bfbrkdtreg		bfbrkdtreg3 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkdt_cs(bfbrkdt3_cs),
				.icedi(icedi), .bfbrkdt_ro(bfbrkdt3_ro), .bfbrkdt(bfbrkdt3)
			) ;
	bfbrkdtreg		bfbrkdtreg4 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkdt_cs(bfbrkdt4_cs),
				.icedi(icedi), .bfbrkdt_ro(bfbrkdt4_ro), .bfbrkdt(bfbrkdt4)
			) ;
	bfbrkdtreg		bfbrkdtreg5 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkdt_cs(bfbrkdt5_cs),
				.icedi(icedi), .bfbrkdt_ro(bfbrkdt5_ro), .bfbrkdt(bfbrkdt5)
			) ;
	bfbrkdtreg		bfbrkdtreg6 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkdt_cs(bfbrkdt6_cs),
				.icedi(icedi), .bfbrkdt_ro(bfbrkdt6_ro), .bfbrkdt(bfbrkdt6)
			) ;
	bfbrkdtreg		bfbrkdtreg7 (
				.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .bfbrkdt_cs(bfbrkdt7_cs),
				.icedi(icedi), .bfbrkdt_ro(bfbrkdt7_ro), .bfbrkdt(bfbrkdt7)
			) ;

endmodule

module	bfbrkadr (
		baseck, icewr, sysrsoutb, bfbrkadr_cs,
		icedi, pa, fa_meet, bfbrkadr_ro
	) ;

	input		baseck, icewr, sysrsoutb, bfbrkadr_cs;
	input [31:0]	icedi;
	input [17:0]	pa;
	output		fa_meet;
	output [19:0]	bfbrkadr_ro;

	reg [19:0]	bfbrkadr_p, bfbrkadr;

	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)		bfbrkadr_p <= 20'hffffc;
		else if (bfbrkadr_cs)	bfbrkadr_p <= {icedi[19:2], 2'b0 };
	end

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)		bfbrkadr <= 20'hffffc;
		else 			bfbrkadr <= bfbrkadr_p;
	end

	assign	bfbrkadr_ro = bfbrkadr_cs ? bfbrkadr : 20'b0;

	assign	fa_meet = ( bfbrkadr[19:2] == pa ) ? 1'b1:1'b0;

endmodule

module	bfbrkdtreg ( baseck, icewr, sysrsoutb, bfbrkdt_cs, icedi, bfbrkdt_ro, bfbrkdt ) ;

	input		baseck, icewr, sysrsoutb, bfbrkdt_cs;
	input [31:0]	icedi;
	output [31:0]	bfbrkdt_ro, bfbrkdt;

	reg [31:0]	bfbrkdt_p, bfbrkdt;

	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)		bfbrkdt_p <= 32'b0;
		else if (bfbrkdt_cs)	bfbrkdt_p <= icedi;
	end

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)		bfbrkdt <= 32'b0;
		else 			bfbrkdt <= bfbrkdt_p;
	end

	assign	bfbrkdt_ro = bfbrkdt_cs ? bfbrkdt : 32'b0;

endmodule

