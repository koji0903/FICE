/********************************************************************************/
/* Date		: 2005/09/12							*/
/* Revision	: 1.10								*/
/* Designer	: T.Tsunoda							*/
/* Note		: 78K0R IECUBE FailSafe Unit					*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2007/11/19							*/
/* Revision	: 1.42								*/
/* Designer	: T.Tsunoda							*/
/* Note		: output selexmpc for trace.					*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2007/12/03							*/
/* Revision	: 1.43								*/
/* Designer	: T.Tsunoda							*/
/* Note		: Added nonmap mirror access, failsafe as r/w access to mirror	*/
/*		: with MAA=1 for Flash under 64kB products.			*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2008/12/09							*/
/* Revision	: 1.44								*/
/* Designer	: T.Tsunoda							*/
/* Note		: Added dataflash failsafe.					*/
/*		: write-protect(option), fetch-protect(option), nonmap		*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2009/05/25							*/
/* Revision	: 1.45								*/
/* Designer	: T.Tsunoda							*/
/* Note		: (1)NPB対応の修正						*/
/*		: WAITEXM活生化時に誤動作する問題を修正。OCDWAITの論理から		*/
/*		: WAITEXMを除外するように変更。					*/
/*		: (2)Nonmap等が発生すべき条件でSOFTBRKのみ発生する問題を修正		*/
/*		: SoftwareBreakとNonmapFetch,FetchProtect,PeripheralProtect	*/
/*		: が競合した場合、SoftwareBreakのみ検出される問題を修正。		*/
/*		: SoftwareBreakはIDステージでSOFTBRKをActiveにするのと同時に	*/
/*		: SVMODをActiveにする。FailsafeはIDステージでSVMODを見て次clock	*/
/*		: でBreak信号を出力するのが原因。					*/
/********************************************************************************/
/* [Update Info]								*/
/* Data		: 2009/06/12							*/
/* Revision	: 1.46								*/
/* Designer	: T.Tsunoda							*/
/* Note		: 1.45(2)に関する追加修正。					*/
/*		: SOFTBRKでSVMODをマスクした場合，SVMODのスタックライトが		*/
/*		: FailSafeの判定対象となってしまう。SOFTBRKのタイミングでの		*/
/*		: スタックライトを無視するために，Nonmapのアクセス系のブレーク		*/
/*		: 要因にはSOFTBRKを使わない構成とした。Fetchブレークは関係なし，	*/
/*		: Peripheralブレークは本マクロでは対応できない為変更なし。		*/
/********************************************************************************/
/* [Updata Info]								*/
/* Date		: 2009.7.14							*/
/* Revision	: 1.47								*/
/* Designer	: T.Tsunoda							*/
/* Note		: SP操作と割込みが競合した場合,PreFetchしたPCがWaitされ(延びる),	*/
/*		: PreFetchがfailsafe検出対象となる問題を修正。			*/
/*		: 但し,FlashFetch,RAMFetchには対応したが,EXMEMFetchには未対応	*/
/*		: で,後日対応予定。						*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2009.9.18							*/
/* Revision	: 1.48								*/
/* Designer	: T.Tsunoda							*/
/* Note		: RAM->Flash,EXMEM->FlashのBranch(BR命令限定)時,不正にReadアク	*/
/*		: セスを検出する不具合を修正。					*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2010.3.25							*/
/* Revision	: 1.49								*/
/* Designer	: T.Tsunoda							*/
/* Note		: SS3rd対応.							*/
/*		: (1)Data Flashに関する仕様を変更. SS2ndではData FlashがEXMEM	*/
/*		:   空間にあった為,Data Flash範囲にEXMEM範囲を関連付けていたが,	*/
/*		:   SS3rdではMirror空間に置かれるため,EXMEMとの関連を解除.		*/
/*		: (2)dfsize Resisterを追加.					*/
/*		: (3)Data FlashからのWord Readプロテクトを追加(SS3rd用).		*/
/*		: (4)failmk Registerにbit14(Data Flash Word Read Mask)を追加.	*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2010.3.29							*/
/* Revision	: 1.50								*/
/* Designer	: T.Tsunoda							*/
/* Note		: SS3rd対応.							*/
/*		: (1)mirror空間信号からdflash空間を除外するよう変更.Function的	*/
/*		: には変更なし.							*/
/*		: (2)trace(など)用にSELBRAMPC,SELBFAPC信号を出力.			*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2010.3.30							*/
/* Revision	: 1.51								*/
/* Designer	: T.Tsunoda							*/
/* Note		: SS3rd対応.							*/
/*		: 1.48と同様の修正を,FlashではなくBFAについて処置.Firm評価にお	*/
/*		: いて,BRAM->BFAのbr,RAM->BFAのretで行っていないReadアクセスが	*/
/*		: 検出される問題が報告されたため.1.48のCaseではret時はpcwaitfに	*/
/*		: よりmaskされるので問題ないが,1.48の処置によりret時もmaskされ	*/
/*		: る. BRAM,BFAの場合にはretがpcwaitfによりmaskされないのでここ	*/
/*		: での処置によりmaskされる.これらはSELF中(selfmode信号がActive)	*/
/*		: に起るこので,ユーザ見えには影響しない.Firm,Libraryなどの内部	*/
/*		: 評価用に不便なため対応するが,修正内容に関するTPは作成せず,他		*/
/*		: の機能に影響しないことを既存のTPでdegrade評価するのみとする.		*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2011.03.02							*/
/* Revision	: 1.52								*/
/* Designer	: T.Tsunoda							*/
/* Note		: sel_ram_ma, sel_dfad_maをmacroから出力(他のmacroで使用するため)。	*/
/********************************************************************************/
// $Id: failsafev1.v,v 1.55 2010-03-30 11:59:02 tsuno3 Exp $

module	FAILSAFEV1 (
	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
	ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,  ICEIFA3,  ICEIFA2,
	ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
	ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
	ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9,  ICEDI8,
	ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0,
	ICEWR,
	ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
	ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
	ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9,  ICEDO8,
	ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,  ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0,
	PC19, PC18, PC17, PC16, PC15, PC14, PC13, PC12, PC11, PC10,
	PC9,  PC8,  PC7,  PC6,  PC5,  PC4,  PC3,  PC2,  PC1,  PC0,
	FLMA15, FLMA14, FLMA13, FLMA12, FLMA11, FLMA10, FLMA9, FLMA8,
	FLMA7,  FLMA6,  FLMA5,  FLMA4,  FLMA3,  FLMA2,  FLMA1, FLMA0,
	EXMA3, EXMA2, EXMA1, EXMA0,
	BASECK, CK60MHZ,
	CPURD, CPUWR, WDOP, SVMOD, MAAOUT, STAGEADR1, STAGEADR0, PCWAITF, SKIPEXE, FCHRAM,
	ALT1, IDPOP, SPINC, SPDEC, SPREL, CPUMISAL, CPURESETB, SYSRSOUTB,
	PERISVIB, SELFMODE, BRAMEN, BFAEN, INTACK, DMAACK, WAITEXM, OCDWAIT, SOFTBRK,
	FLSIZE3, FLSIZE2, FLSIZE1, FLSIZE0,
	RAMSIZE7, RAMSIZE6, RAMSIZE5, RAMSIZE4, RAMSIZE3, RAMSIZE2, RAMSIZE1, RAMSIZE0,
	BFSIZE3, BFSIZE2, BFSIZE1, BFSIZE0,
	BMSIZE3, BMSIZE2, BMSIZE1, BMSIZE0,
	DFSIZE1, DFSIZE0,
	BRKFAIL0, BRKFAIL1, BRKFAIL2, BRKFAIL3, BRKFAIL4, BRKFAIL5, BRKFAIL6, BRKFAIL7,
	BRKFAIL8, BRKFAIL9, BRKFAIL10, BRKFAIL11, BRKFAIL13, BRKFAIL15,
	FAILMK12,
	EXMAPOUT,
	SELEXMPC, SELRAMPC, SELROMPC, SELBRAMPC, SELBFAPC,
	SELRAMMA, SELDFADMA
	) ;


// -----------------------------------------------------------------------------------------------------
input   ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28,	// Host I/F Address Bus			( <- eva_pcifg )
	ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,	//							
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,	//							
	ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,	//							
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,	//							
	ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,	//							
	ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,	//							
	ICEIFA3,  ICEIFA2;			//							
input	ICEDI31, ICEDI30, ICEDI29, ICEDI28,	// Host I/F Write Data Bus		( <- eva_pcifg )
	ICEDI27, ICEDI26, ICEDI25, ICEDI24,	//							
	ICEDI23, ICEDI22, ICEDI21, ICEDI20,	//							
	ICEDI19, ICEDI18, ICEDI17, ICEDI16,	//							
	ICEDI15, ICEDI14, ICEDI13, ICEDI12,	//							
	ICEDI11, ICEDI10, ICEDI9,  ICEDI8,	//							
	ICEDI7,  ICEDI6,  ICEDI5,  ICEDI4,	//							
	ICEDI3,  ICEDI2,  ICEDI1,  ICEDI0 ;	//							
input	ICEWR ;					// Host I/F Write Strobe		( <- eva_pcifg )
output  ICEDO31, ICEDO30, ICEDO29, ICEDO28,	// Host I/F Read Data Bus		( -> eva_pcifg )
	ICEDO27, ICEDO26, ICEDO25, ICEDO24,	//							
	ICEDO23, ICEDO22, ICEDO21, ICEDO20,	//							
	ICEDO19, ICEDO18, ICEDO17, ICEDO16,	//							
	ICEDO15, ICEDO14, ICEDO13, ICEDO12,	//							
	ICEDO11, ICEDO10, ICEDO9,  ICEDO8,	//							
	ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,	//							
	ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0 ;	//							
input	PC19, PC18, PC17, PC16, PC15,		// Program Counter			( <- eva core )	
	PC14, PC13, PC12, PC11, PC10,		//							
	PC9, PC8, PC7, PC6, PC5,		//							
	PC4, PC3, PC2, PC1, PC0;		//							
input	FLMA15, FLMA14, FLMA13, FLMA12,		// Memory Access Address		( <- emem )	
	FLMA11, FLMA10, FLMA9, FLMA8,		// includes saddr convert address on			
	FLMA7, FLMA6, FLMA5, FLMA4,		// firm execution					
	FLMA3, FLMA2, FLMA1, FLMA0;		//							
input	EXMA3, EXMA2, EXMA1, EXMA0;		// access address upper bit		( <- eva core )	
input	BASECK;					// CPU Base Clock			( <- fpga pin )	
input	CK60MHZ;				// 60Mhz fixed Clock			( <- clock )	
input	CPURD;					// Memory Read Strobe			( <- eva core )	
input	CPUWR;					// Memory Write Strobe			( <- eva core )	
input	WDOP;					// Word Operation Signal		( <- eva core )	
input	SVMOD;					// Super Visor Mode signal		( <- eva core )	
input	MAAOUT;					// MAA Copy				( <- eva core )	
input	STAGEADR1, STAGEADR0;			// Internal Counter for Instruction	( <- eva core )	
input	PCWAITF;				// PC Wait signal			( <- eva core )	
input	SKIPEXE;				// SKIP instruction execution flag	( <- eva core )	
input	FCHRAM;					// RAM fetch signal(**sync with PC**)	( <- eva core )	
input	ALT1;					// ALT1 instruction			( <- eva core )	
input	IDPOP;					// POP instruction at ID stage		( <- eva core )	
input	SPINC;					// SP Incliment(POP stack) Operation	( <- eva core )	
input	SPDEC;					// SP Decliment(PUSH stack) operation	( <- eva core )	
input	SPREL;					// SP relative access operation		( <- eva core )	
input	CPUMISAL;				// Word Write to Odd Address		( <- eva core )	
input	CPURESETB;				// CPU reset signal			( <- resetctl )	
input	SYSRSOUTB;				// System Reset Signal			( <- resetctl )	
input	PERISVIB;				// FailSafe Signal from Peripheral	( <- 1chip )	
input	SELFMODE;				// Flash Self Mode Signal		( <- 1chip )	
input	BRAMEN;					// BRAM Enable				( <- 1chip )	
input	BFAEN;					// BFA Enable				( <- 1chip )	
input	INTACK;					// intack				( <- 1chip )	
input	DMAACK;					// dmaack				( <- 1chip )	
input	WAITEXM;				// external memory wait			( <- 1chip )	
input	OCDWAIT;				// Wait by NPB Access Or Retry for K0R	( <- eva core )
input	SOFTBRK;				// software break			( <- eva core )
output	FLSIZE3, FLSIZE2, FLSIZE1, FLSIZE0;	// Flash Size Signal			( -> 1chip )	
output	RAMSIZE7, RAMSIZE6, RAMSIZE5, RAMSIZE4,	// RAM Size Signal			( -> 1chip )	
	RAMSIZE3, RAMSIZE2, RAMSIZE1, RAMSIZE0;	// 							
output	BFSIZE3, BFSIZE2, BFSIZE1, BFSIZE0;	// BFA Size Signal			( -> 1chip )	
output	BMSIZE3, BMSIZE2, BMSIZE1, BMSIZE0;	// BRAM Size Signal			( -> 1chip )	
output	DFSIZE1, DFSIZE0;			// Dafa Flash Size Signal		( -> 1chip )
output	BRKFAIL0;				// NonMap Break				( -> break )	
output	BRKFAIL1;				// Fetch Protect Break			( -> break )	
output	BRKFAIL2;				// Write Protect Break			( -> break )	
output	BRKFAIL3;				// 2ndSFR Read Protect Break		( -> break )	
output	BRKFAIL4;				// 2ndSFR Write Protect Break		( -> break )	
output	BRKFAIL5;				// SFR Read Protect Break		( -> break )	
output	BRKFAIL6;				// SFR Write Protect Break		( -> break )	
output	BRKFAIL7;				// SP Under Flow			( -> break )	
output	BRKFAIL8;				// SP Over Flow				( -> break )	
output	BRKFAIL9;				// SP Not Initialize			( -> break )	
output	BRKFAIL10;				// RAM Initialize Protect Break		( -> break )	
output	BRKFAIL11;				// Peripheral Macro Break		( -> break )	
output	BRKFAIL13;				// Misaline Access Break		( -> break )	
output	BRKFAIL15;				// Data Flash Word Read Access Break	( -> break )
output	FAILMK12;				// FailSafe Mask Signal for FlashSelf	( -> memory )	
output	EXMAPOUT;				// select In or External for EXMEM	( -> memory )	
output	SELEXMPC;				// [V1.42] PC == External Area		( -> ice macro )
output	SELRAMPC;				// [V1.42] PC == RAM Area		( -> ice macro )
output	SELROMPC;				// PC == Flash Area			( -> ice macro )
output	SELBRAMPC;				// [V1.50] PC == BRAM Area		( -> ice macro )
output	SELBFAPC;				// [V1.50] PC == BFA Area		( -> ice macro )
output	SELRAMMA;				// [V1.52] MA == RAM Area		( -> other )
output	SELDFADMA;				// [V1.52] MA == DFlash Area		( -> other )

// -------------------------------------------------------------------------------------------------------
// top
wire [31:2]	iceifa;
wire [31:0]	icedi;
wire [19:0]	pc;
wire [15:0]	flma;
wire [3:0]	exma;
wire [1:0]	stageadr;
wire [3:0]	exadh_cs;
wire [3:0]	exadl_cs;
wire [14:0]	failmk;	/* [V1.49] bit14を追加 */
wire [8:0]	ramsizeice;
wire [9:0]	flsizeice;
wire [7:0]	ramsize;
wire [3:0]	flsize;
wire [3:0]	bmsize;
wire [3:0]	bfsize;
wire [1:0]	dfsize;
wire [19:0]	exadh0, exadh1, exadh2, exadh3;
wire [19:0]	exadl0, exadl1, exadl2, exadl3;
wire [19:0]	dfadh, dfadl;
wire [15:1]	ustadrh, ustadrl;
wire [31:0]	register_ro, sfr_protect_ro, ramini_ro;



// -------------------------------------------------------------------------------------------------------
	assign	iceifa = {
			ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
			ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,  ICEIFA3,  ICEIFA2};

	assign	icedi = {
			ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
			ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
			ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9,  ICEDI8,
			ICEDI7,  ICEDI6,  ICEDI5,  ICEDI4,  ICEDI3,  ICEDI2,  ICEDI1,  ICEDI0};

	assign	pc =	{
			PC19, PC18, PC17, PC16, PC15, PC14, PC13, PC12, PC11, PC10,
			PC9,  PC8,  PC7,  PC6,  PC5,  PC4,  PC3,  PC2,  PC1,  PC0};

	assign	flma = {
			FLMA15, FLMA14, FLMA13, FLMA12, FLMA11, FLMA10, FLMA9, FLMA8,
			FLMA7,  FLMA6,  FLMA5,  FLMA4,  FLMA3,  FLMA2,  FLMA1, FLMA0};

	assign	exma =	{ EXMA3, EXMA2, EXMA1, EXMA0 };

	assign	stageadr = {STAGEADR1, STAGEADR0};

	assign {ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
		ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
		ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
		ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0}
		= register_ro | sfr_protect_ro | ramini_ro;

	assign	{RAMSIZE7, RAMSIZE6, RAMSIZE5, RAMSIZE4, RAMSIZE3, RAMSIZE2, RAMSIZE1, RAMSIZE0} = ramsize;
	assign	{FLSIZE3, FLSIZE2, FLSIZE1, FLSIZE0} = flsize;
	assign	{BMSIZE3, BMSIZE2, BMSIZE1, BMSIZE0} = bmsize;
	assign	{BFSIZE3, BFSIZE2, BFSIZE1, BFSIZE0} = bfsize;
	assign	{DFSIZE1, DFSIZE0} = dfsize;

// -------------------------------------------------------------------------------------------------------
	nonmap	nonmap (
		.baseck(BASECK), .sysrsoutb(SYSRSOUTB), .fch(fch), .rd(rd), .wr(wr), .svmod(SVMOD),
		.selfmode(SELFMODE), .bramen(BRAMEN), .bfaen(BFAEN), .failmk0(failmk[0]),
		.sel_nonmap_rom_pc(sel_nonmap_rom_pc), .sel_nonmap_ram_pc(sel_nonmap_ram_pc),
		.sel_nonmap_exmem_pc(sel_nonmap_exmem_pc), .sel_nonmap_rom_ma(sel_nonmap_rom_ma),
		.sel_nonmap_mirror_maa(sel_nonmap_mirror_maa),
		.sel_nonmap_ram_ma(sel_nonmap_ram_ma), .sel_nonmap_exmem_ma(sel_nonmap_exmem_ma),
		.sel_bram_pc(SELBRAMPC), .sel_bfa_pc(SELBFAPC), .sel_bram_ma(sel_bram_ma),
		.sel_bfa_ma(sel_bfa_ma), .softbrk(SOFTBRK), .brkfail0(BRKFAIL0)
	);

	fetch_protect	fetch_protect (
		.baseck(BASECK), .sysrsoutb(SYSRSOUTB), .failmk1(failmk[1]), .selfmode(SELFMODE),
		.svmod(SVMOD), .fch(fch), .sel_sfr_pc(sel_sfr_pc), .sel_generalreg_pc(sel_generalreg_pc),
		.sel_mirror_pc(sel_mirror_pc), .sel_2ndsfr_pc(sel_2ndsfr_pc),
		.sel_dfad_pc(sel_dfad_pc), .dfatt1(dfatt1), .softbrk(SOFTBRK),
		.brkfail1(BRKFAIL1)
	);

	write_protect	write_protect (
		.baseck(BASECK), .sysrsoutb(SYSRSOUTB), .failmk2(failmk[2]), .selfmode(SELFMODE),
		.bfaen(BFAEN), .svmod(SVMOD), .wr(wr), .sel_rom_ma(sel_rom_ma), .sel_bfa_ma(sel_bfa_ma),
		.sel_mirror_ma(sel_mirror_ma), .sel_exmem_ma_all(sel_exmem_ma_all),
		.sel_exad0_ma_wprtct(sel_exad0_ma_wprtct), .sel_exad1_ma_wprtct(sel_exad1_ma_wprtct),
		.sel_exad2_ma_wprtct(sel_exad2_ma_wprtct), .sel_exad3_ma_wprtct(sel_exad3_ma_wprtct),
		.exatt0(exatt0), .exatt1(exatt1), .exatt2(exatt2), .exatt3(exatt3),
		.sel_dfad_ma_wprtct(sel_dfad_ma_wprtct), .dfatt0(dfatt0),
		.brkfail2(BRKFAIL2)
	);

	sfr_protect	sfr_protect (
		.baseck(BASECK), .ck60mhz(CK60MHZ), .sysrsoutb(SYSRSOUTB), .selfmode(SELFMODE),
		.svmod(SVMOD), .sel_2ndsfr_ma(sel_2ndsfr_ma), .sel_sfr_ma(sel_sfr_ma), .rd(rd), .wr(wr),
		.sfratt_cs(sfratt_cs), .failmk3(failmk[3]), .failmk4(failmk[4]), .failmk5(failmk[5]),
		.failmk6(failmk[6]), .icewr(ICEWR), .icedi(icedi), .iceifa(iceifa[9:2]), .flma(flma[10:0]),
		.brkfail3(BRKFAIL3), .brkfail4(BRKFAIL4), .brkfail5(BRKFAIL5), .brkfail6(BRKFAIL6),
		.sfr_protect_ro(sfr_protect_ro)
	);

	sp_rangeout	sp_rangeout (
		.baseck(BASECK), .sysrsoutb(SYSRSOUTB), .failmk7(failmk[7]), .failmk8(failmk[8]),
		.selfmode(SELFMODE), .svmod(SVMOD), .spinc(SPINC), .spdec(SPDEC), .sprel(SPREL),
		.cpurd(CPURD), .cpuwr(CPUWR), .dma(dma), .flma(flma), .ustadrh(ustadrh), .ustadrl(ustadrl),
		.brkfail7(BRKFAIL7), .brkfail8(BRKFAIL8)
	);

	sp_ini	sp_ini (
		.baseck(BASECK), .cpuresetb(CPURESETB), .sysrsoutb(SYSRSOUTB), .failmk9(failmk[9]),
		.selfmode(SELFMODE), .svmod(SVMOD), .sel_sfr_ma(sel_sfr_ma), .wdop(WDOP), .cpurd(CPURD),
		.cpuwr(CPUWR), .spinc(SPINC), .spdec(SPDEC), .sprel(SPREL), .flma(flma[7:0]),
		.brkfail9(BRKFAIL9)
	);

	ramini	ramini (
		.baseck(BASECK), .ck60mhz(CK60MHZ), .sysrsoutb(SYSRSOUTB), .failmk10(failmk[10]),
		.selfmode(SELFMODE), .svmod(SVMOD), .alt1(ALT1), .idpop(IDPOP), .fch(fch), .rd(rd),
		.wr(wr), .wdop(WDOP), .ramini_cs(ramini_cs), .conv_cs(conv_cs), .sel_ram_pc(sel_ram_pc),
		.sel_ram_ma(SELRAMMA), .sel_bram_ma(sel_bram_ma), .ovlapemu(ovlapemu), .icewr(ICEWR),
		.iceifa(iceifa[13:2]), .icedi(icedi), .pc(pc[15:0]), .flma(flma), .brkfail10(BRKFAIL10),
		.ramini_ro(ramini_ro)
	);

	peri_protect	peri_protect (
		.baseck(BASECK), .sysrsoutb(SYSRSOUTB), .failmk11(failmk[11]),
		.selfmode(SELFMODE), .svmod(SVMOD), .perisvib(PERISVIB), .softbrk(SOFTBRK), .brkfail11(BRKFAIL11));

	misalign	misalign (
		.baseck(BASECK), .sysrsoutb(SYSRSOUTB), .failmk13(failmk[13]), .selfmode(SELFMODE),
		.svmod(SVMOD), .cpumisal(CPUMISAL), .dma(dma), .brkfail13(BRKFAIL13)
	);

	// [V1.49]
	dflash_wread	dflash_wread (
		.baseck(BASECK), .sysrsoutb(SYSRSOUTB), .failmk14(failmk[14]), .selfmode(SELFMODE),
		.svmod(SVMOD), .rd(rd), .wdop(WDOP), .sel_dfad_ma_wdrdprtct(sel_dfad_ma_wdrdprtct),
		.brkfail15(BRKFAIL15)
	);

	sel_area	sel_area (
		.baseck(BASECK), .sysrsoutb(SYSRSOUTB), .pcwaitf(PCWAITF), .intack(INTACK),
		.dmaack(DMAACK), .waitexm(WAITEXM), .ocdwait(OCDWAIT), .skipexe(SKIPEXE), .cpurd(CPURD), .cpuwr(CPUWR),
		.fchram(FCHRAM), .wdop(WDOP), .maa(MAAOUT), .stageadr(stageadr), .exma(exma), .flma(flma), .pc(pc),
		.flsize(flsize), .ramsize(ramsize), .flsizeice(flsizeice[5:0]), .ramsizeice(ramsizeice[0]),
		.bfsize(bfsize), .bmsize(bmsize), .exadh0(exadh0), .exadh1(exadh1), .exadh2(exadh2),
		.exadh3(exadh3), .exadl0(exadl0), .exadl1(exadl1), .exadl2(exadl2), .exadl3(exadl3),
		.dfadh(dfadh), .dfadl(dfadl),
		.fch(fch), .rd(rd), .wr(wr), .dma(dma),
		.sel_sfr_pc(sel_sfr_pc), .sel_sfr_ma(sel_sfr_ma),
		.sel_generalreg_pc(sel_generalreg_pc),
		.sel_ram_pc(sel_ram_pc), .sel_ram_ma(SELRAMMA),
		.sel_mirror_pc(sel_mirror_pc), .sel_mirror_ma(sel_mirror_ma),
		.sel_bram_pc(SELBRAMPC), .sel_bram_ma(sel_bram_ma),
		.sel_2ndsfr_pc(sel_2ndsfr_pc), .sel_2ndsfr_ma(sel_2ndsfr_ma),
		.sel_bfa_pc(SELBFAPC), .sel_bfa_ma(sel_bfa_ma),
		.sel_exmem_ma_all(sel_exmem_ma_all),
		.sel_rom_ma(sel_rom_ma),
		.sel_nonmap_rom_pc(sel_nonmap_rom_pc), .sel_nonmap_rom_ma(sel_nonmap_rom_ma),
		.sel_nonmap_mirror_maa(sel_nonmap_mirror_maa),
		.sel_nonmap_ram_pc(sel_nonmap_ram_pc), .sel_nonmap_ram_ma(sel_nonmap_ram_ma),
		.sel_nonmap_exmem_pc(sel_nonmap_exmem_pc), .sel_nonmap_exmem_ma(sel_nonmap_exmem_ma),
		.sel_exad0_ma_wprtct(sel_exad0_ma_wprtct), .sel_exad1_ma_wprtct(sel_exad1_ma_wprtct),
		.sel_exad2_ma_wprtct(sel_exad2_ma_wprtct), .sel_exad3_ma_wprtct(sel_exad3_ma_wprtct),
		.sel_exmem_pc_all(SELEXMPC), .sel_ram_pc_all(SELRAMPC), .sel_rom_pc_all(SELROMPC),
		.sel_dfad_pc(sel_dfad_pc),
		.sel_dfad_ma_wprtct(sel_dfad_ma_wprtct),
		.sel_dfad_ma_wdrdprtct(sel_dfad_ma_wdrdprtct),
		.sel_dfad_ma(SELDFADMA)
	);

	exmap		exmap	(
		.exma(exma), .flma(flma), .exadh0(exadh0), .exadh1(exadh1), .exadh2(exadh2), .exadh3(exadh3),
		.exadl0(exadl0), .exadl1(exadl1), .exadl2(exadl2), .exadl3(exadl3), .exmap0(exmap0),
		.exmap1(exmap1), .exmap2(exmap2), .exmap3(exmap3), .exmapout(EXMAPOUT)
	);

	failsafe_register	failsafe_register (
		.icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .size_cs(size_cs), .exadh_cs(exadh_cs),
		.exadl_cs(exadl_cs), .ustadr_cs(ustadr_cs), .failmk_cs(failmk_cs), .bsize_cs(bsize_cs),
		.ovlapemu_cs(ovlapemu_cs), .dfsize_cs(dfsize_cs), .icedi(icedi), .ramsize(ramsize),
		.flsize(flsize), .ramsizeice(ramsizeice), .flsizeice(flsizeice), .exmap0(exmap0),
		.exmap1(exmap1), .exmap2(exmap2), .exmap3(exmap3), .exatt0(exatt0), .exatt1(exatt1),
		.exatt2(exatt2), .exatt3(exatt3), .exadh0(exadh0), .exadh1(exadh1), .exadh2(exadh2),
		.exadh3(exadh3), .exadl0(exadl0), .exadl1(exadl1), .exadl2(exadl2), .exadl3(exadl3),
		.ustadrh(ustadrh), .ustadrl(ustadrl), .failmk(failmk), .bfsize(bfsize), .bmsize(bmsize),
		.ovlapemu(ovlapemu), .dfsize(dfsize), .register_ro(register_ro), .dfadh_cs(dfadh_cs),
		.dfadl_cs(dfadl_cs), .dfatt0(dfatt0), .dfatt1(dfatt1), .dfadh(dfadh), .dfadl(dfadl)
	);

	assign	FAILMK12 = failmk[12];

	failsafe_cs	failsafe_cs (
		.iceifa(iceifa), .size_cs(size_cs), .exadh_cs(exadh_cs), .exadl_cs(exadl_cs),
		.ustadr_cs(ustadr_cs), .failmk_cs(failmk_cs), .bsize_cs(bsize_cs),
		.ovlapemu_cs(ovlapemu_cs), .dfsize_cs(dfsize_cs), .sfratt_cs(sfratt_cs), .ramini_cs(ramini_cs),
		.conv_cs(conv_cs), .dfadh_cs(dfadh_cs), .dfadl_cs(dfadl_cs)
	);

endmodule



// =====================================================================================================
// nonmap												
// =====================================================================================================
module	nonmap	(
		baseck, sysrsoutb, fch, rd, wr, svmod, selfmode, bramen, bfaen, failmk0,
		sel_nonmap_rom_pc, sel_nonmap_ram_pc, sel_nonmap_exmem_pc,
		sel_nonmap_rom_ma, sel_nonmap_ram_ma, sel_nonmap_exmem_ma,
		sel_nonmap_mirror_maa,
		sel_bram_pc, sel_bfa_pc, sel_bram_ma, sel_bfa_ma,
		softbrk,
		brkfail0
	);

input		baseck, sysrsoutb, fch, rd, wr, svmod, selfmode, bramen, bfaen, failmk0,
		sel_nonmap_rom_pc, sel_nonmap_ram_pc, sel_nonmap_exmem_pc,
		sel_nonmap_rom_ma, sel_nonmap_ram_ma, sel_nonmap_exmem_ma,
		sel_nonmap_mirror_maa,
		sel_bram_pc, sel_bfa_pc, sel_bram_ma, sel_bfa_ma;
input		softbrk;
output		brkfail0;

// -------------------------------------------------------------------------------------------------------
reg	brkfail0;

wire	nonmap_rom_fch;
wire	nonmap_ram_fch;
wire	nonmap_exmem_fch;
wire	nonmap_rom_rw;
wire	nonmap_mirror_rw;
wire	nonmap_ram_rw;
wire	nonmap_exmem_rw;
wire	nonmap_bram_fch;
wire	nonmap_bfa_fch;
wire	nonmap_bram_rw;
wire	nonmap_bfa_rw;
wire	brkfail0_pre1, brkfail0_pre2, brkfail0_pre3;

// -------------------------------------------------------------------------------------------------------

	assign	nonmap_rom_fch	= fch & sel_nonmap_rom_pc;		/* nonmapROM隙間fetch */
	assign	nonmap_ram_fch	= fch & sel_nonmap_ram_pc;		/* nonmapRAM隙間fetch */
	assign	nonmap_exmem_fch= fch & sel_nonmap_exmem_pc;		/* nonmap外部設定範囲外fetch */
	assign	nonmap_rom_rw	= (rd | wr) & sel_nonmap_rom_ma;	/* nonmapROM隙間access */
	assign	nonmap_mirror_rw = (rd | wr) & sel_nonmap_mirror_maa;	/* [V1.43] nonmapMirrorAccess */
	assign	nonmap_ram_rw	= (rd | wr) & sel_nonmap_ram_ma;	/* nonmapRAM隙間access */
	assign	nonmap_exmem_rw	= (rd | wr) & sel_nonmap_exmem_ma;	/* nonmap外部設定範囲外access */

	/* ------------------------------------------------------------------------------------	*/
	/* bramen=1のときはfailsafe無効								*/
	/* bramen=0のときでもbramからfetchするとselfmodeとなるが, selfmodeによるmaskよりも	*/
	/* bramen=0によるnonmapを優先させる為に~selfmodeの条件は入れない.(self中のfailsafe.)	*/
	/* ------------------------------------------------------------------------------------	*/
	assign	nonmap_bram_fch	= ~bramen & fch & sel_bram_pc;		/* nonmapBRAMfetch */

	/* ------------------------------------------------------------------------------------	*/
	/* bfaen=1のときはfailsafe無効								*/
	/* bfaen=0のときでもbfaからfetchするとselfmodeとなるが, selfmodeによるmaskよりも	*/
	/* bfaen=0によるnonmapを優先させる為に~selfmodeの条件は入れない.(self中のfailsafe.)	*/
	/* ------------------------------------------------------------------------------------	*/
	assign	nonmap_bfa_fch	= ~bfaen & fch & sel_bfa_pc;		/* nonmapBFAfetch */

	/* ----------------------------	*/
	/* bramen=1のときはfailsafe無効 */
	/* ----------------------------	*/
	assign	nonmap_bram_rw	= ~bramen & (rd | wr) & sel_bram_ma;	/* nonmapBRAMaccess */

	/* ------------------------------------	*/
	/* bfaen=1時のwrはwrite protectで対応	*/
	/* ------------------------------------	*/
	assign	nonmap_bfa_rw	= ~bfaen & (rd | wr) & sel_bfa_ma;	/* nonmapBFAaccess */

	//			
	// break integrate	
	//			
	assign	brkfail0_pre1	= ~selfmode & ~(svmod & ~softbrk) & (nonmap_rom_fch | nonmap_ram_fch | nonmap_exmem_fch);
	assign	brkfail0_pre2	= ~selfmode & ~svmod & (nonmap_rom_rw  | nonmap_mirror_rw | nonmap_ram_rw  |
					      nonmap_exmem_rw | nonmap_bram_rw | nonmap_bfa_rw);
	assign	brkfail0_pre3	= ~svmod & (nonmap_bram_fch | nonmap_bfa_fch);

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) brkfail0 <= 1'b0;
		else if (~failmk0 & (brkfail0_pre1 | brkfail0_pre2 | brkfail0_pre3))	/* [V1.45(2)], [V1.46] */
				brkfail0 <= 1'b1;
		else		brkfail0 <= 1'b0;
	end
endmodule


// =====================================================================================================
// Fetch Protect											
// =====================================================================================================
module	fetch_protect	(
		baseck, sysrsoutb, failmk1, selfmode, svmod, fch, sel_sfr_pc, sel_generalreg_pc,
		sel_mirror_pc, sel_2ndsfr_pc,
		sel_dfad_pc, dfatt1, softbrk,
		brkfail1
	);

input	baseck, sysrsoutb, failmk1, selfmode, svmod, fch, sel_sfr_pc, sel_generalreg_pc;
input	sel_mirror_pc, sel_2ndsfr_pc;
input	sel_dfad_pc, dfatt1;
input	softbrk;
output	brkfail1;

reg	brkfail1;

	/* ------------------------------------------------------------------------------------	*/
	/* SFRAddressがpcに乗るとpcwaitfが立ちっぱなしとなりcpuが暴走する為,fchを論理に入れると	*/
	/* failsafeもかからなくなる→汎用レジスタをフェッチ禁止であり,命令の先読みでsfrが	*/
	/* pcに乗ることはないと考え,fchを論理から外す.						*/
	/* ------------------------------------------------------------------------------------	*/
	/* [V1.49]										*/
	/* DataFlash fetch protectの条件からsel_exmem_pc_allを削除した.これによりdfadh,dladlの	*/
	/* 初期値0の状態で0hをfetchするとData Flash領域と認識されるが,dfatt1の初期値が元々1なの	*/
	/* で誤動作することは無い.								*/
	/* ------------------------------------------------------------------------------------	*/
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	brkfail1 <= 1'b0;
		else if (~failmk1 & ~selfmode & ~(svmod & ~softbrk) & (			/* [V1.45(2)] */
			sel_sfr_pc						|	/* sfr fetch */
			(fch & sel_generalreg_pc)				|	/* generalreg fetch */
			(fch & sel_mirror_pc)					|	/* mirror fetch */
			(fch & sel_2ndsfr_pc)					|	/* 2ndsfr fetch */
			(fch & sel_dfad_pc & ~dfatt1))					/* DataFlash fetch */
			)
				brkfail1 <= 1'b1;
		else		brkfail1 <= 1'b0;
	end
endmodule


// =====================================================================================================
// Write Protect											
// =====================================================================================================
module	write_protect	(
		baseck, sysrsoutb, failmk2, selfmode, bfaen, svmod, wr, sel_rom_ma, sel_bfa_ma,
		sel_mirror_ma, sel_exmem_ma_all, sel_exad0_ma_wprtct, sel_exad1_ma_wprtct, sel_exad2_ma_wprtct, sel_exad3_ma_wprtct,
		exatt0, exatt1, exatt2, exatt3,
		sel_dfad_ma_wprtct, dfatt0,
		brkfail2
	);

input	baseck, sysrsoutb, failmk2, selfmode, bfaen, svmod, wr, sel_rom_ma, sel_bfa_ma,
	sel_mirror_ma, sel_exmem_ma_all, sel_exad0_ma_wprtct, sel_exad1_ma_wprtct, sel_exad2_ma_wprtct, sel_exad3_ma_wprtct,
	exatt0, exatt1, exatt2, exatt3,
	sel_dfad_ma_wprtct, dfatt0;
output	brkfail2;

reg	brkfail2;

	/* ----------------------------------------------------------------------------------------------------	*/
	/* [V1.49]												*/
	/* Data Flash write protectの条件を変更. SS3rd対応のため,Data Flashの条件からsel_exmem_ma_allを削除.	*/
	/* これによりdfadh,dladlの初期値0の状態で0hをaccessするとData Flash領域と認識されるが,dfatt0の初期値が	*/
	/* 元々1なので誤動作することは無い.									*/
	/* ----------------------------------------------------------------------------------------------------	*/
	always @(posedge baseck or negedge sysrsoutb) begin
		if( !sysrsoutb)	brkfail2 <= 1'b0;
		else if (~failmk2 & ~selfmode & ~svmod & wr & (
			(sel_rom_ma | sel_mirror_ma)				|	/* ROM write */
			( bfaen & sel_bfa_ma)					|	/* BFA write protect */
			(sel_exmem_ma_all & sel_exad0_ma_wprtct & ~exatt0)	|	/* 外部write属性protect-0 */
			(sel_exmem_ma_all & sel_exad1_ma_wprtct & ~exatt1)	|	/* 外部write属性protect-1 */
			(sel_exmem_ma_all & sel_exad2_ma_wprtct & ~exatt2)	|	/* 外部write属性protect-2 */
			(sel_exmem_ma_all & sel_exad3_ma_wprtct & ~exatt3)	|	/* 外部write属性protect-3 */
			(sel_dfad_ma_wprtct & ~dfatt0))					/* DataFlash write属性protect */
			)
				brkfail2 <= 1'b1;
		else		brkfail2 <= 1'b0;
	end
endmodule


// =====================================================================================================
// SFR,2ndSFR Read Protect & Write Protect								
// =====================================================================================================
module	sfr_protect	(
		baseck, ck60mhz, sysrsoutb, selfmode, svmod, sel_2ndsfr_ma, sel_sfr_ma, rd, wr, sfratt_cs,
		failmk3, failmk4, failmk5, failmk6, icewr, icedi, iceifa, flma,
		brkfail3, brkfail4, brkfail5, brkfail6, sfr_protect_ro
	);

input		baseck, ck60mhz, sysrsoutb, selfmode, svmod, sel_2ndsfr_ma, sel_sfr_ma, rd, wr, sfratt_cs,
		failmk3, failmk4, failmk5, failmk6, icewr;
input [31:0]	icedi;
input [9:2]	iceifa;
input [10:0]	flma;
output		brkfail3, brkfail4, brkfail5, brkfail6;
output [31:0]	sfr_protect_ro;

reg		selfmode_l1, svmod_l1, sel_2ndsfr_ma_l1, sel_sfr_ma_l1, rd_l1, wr_l1;
reg [3:0]	flma_l1;
reg		brkfail3, brkfail4, brkfail5, brkfail6;
reg [8:0]	cpuaddress;
reg [7:0]	icewritead;
reg [31:0]	icewritedata;
reg		icewritestart, icewrite;
wire [8:0]	iceaddress;
wire [31:0]	icedo_out,cpu_out;
wire		sfrarea_attw, sfrarea_attr;
wire		ice_res1;

	/* ・GuradMemoryは同期型なのでcpuaddressに対して出力が1clock遅れる為, 判定用の他の信号も1clock遅らせる.	*/
	/* ・sftattr,wはmemory出力で基本的に何らかの値を保持しているので, disable条件は出口側につけるしかない.	*/
	/*   -> 1clock遅れる.(memory出力と合わせて2clock遅れ.)							*/
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			selfmode_l1		<= 1'b0;
			svmod_l1		<= 1'b0;
			rd_l1			<= 1'b0;
			wr_l1			<= 1'b0;
			sel_2ndsfr_ma_l1	<= 1'b0;
			sel_sfr_ma_l1		<= 1'b0;
			flma_l1			<= 4'h0;
		end
		else begin
			selfmode_l1		<= selfmode;
			svmod_l1		<= svmod;
			rd_l1			<= rd;
			wr_l1			<= wr;
			sel_2ndsfr_ma_l1	<= sel_2ndsfr_ma;
			sel_sfr_ma_l1		<= sel_sfr_ma;
			flma_l1			<= flma[3:0];
		end
	end

	//			
	// 2ndsfr read protect	
	//			
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	brkfail3 <= 1'b0;
		else if (~failmk3 & ~selfmode_l1 & ~svmod_l1 & sel_2ndsfr_ma_l1 & rd_l1 & !sfrarea_attr)
				brkfail3 <= 1'b1;
		else		brkfail3 <= 1'b0;
	end
	//			
	// 2ndsfr write protect	
	//			
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	brkfail4 <= 1'b0;
		else if (~failmk4 & ~selfmode_l1 & ~svmod_l1 & sel_2ndsfr_ma_l1 & wr_l1 & !sfrarea_attw)
				brkfail4 <= 1'b1;
		else		brkfail4 <= 1'b0;
	end

	//			
	// sfr read protect	
	//			
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	brkfail5 <= 1'b0;
		else if (~failmk5 & ~selfmode_l1 & ~svmod_l1 & sel_sfr_ma_l1 & rd_l1 & !sfrarea_attr)
				brkfail5 <= 1'b1;
		else		brkfail5 <= 1'b0;
	end
	//			
	// sfr write protect	
	//			
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) brkfail6 <= 1'b0;
		else if (~failmk6 & ~selfmode_l1 & ~svmod_l1 & sel_sfr_ma_l1 & wr_l1 & !sfrarea_attw)
				brkfail6 <= 1'b1;
		else		brkfail6 <= 1'b0;
	end

	//			
	// Guard Memory IF	
	//			

	/* 2ndsfr 2kx2bit+sfr256x2bit=4.5kbit -> 512adrx32bitRAM(ram16b_s32_s32:16kbitRAM)1個使用 */
	/* iceifa[9:0]	iceaddress	cpuaddress					*/
 	/* 000-03c	{1'b0,00-0f}	{2'b00,00-0f} (sel2ndsfr)			*/
	/* 040-07c	{1'b0,10-1f}	{2'b00,10-1f} (sel2ndsfr)			*/
	/* 080-0bc	{1'b0,20-2f}	{2'b00,20-2f} (sel2ndsfr)			*/
	/* 0c0-0fc	{1'b0,30-3f}	{2'b00,30-3f} (sel2ndsfr)			*/
	/* 100-13c	{1'b0,40-4f}	{2'b00,40-4f} (sel2ndsfr)			*/
	/* 140-17c	{1'b0,50-5f}	{2'b00,50-5f} (sel2ndsfr)			*/
	/* 180-1bc	{1'b0,60-6f}	{2'b00,60-6f} (sel2ndsfr)			*/
	/* 1c0-1fc	{1'b0,70-7f}	{2'b00,70-7f} (sel2ndsfr)			*/
	/* 200-23c	{1'b0,80-8f}	{5'b01000,0-f} (selsfr) ;<- next to sndsfr	*/

	always @(sel_2ndsfr_ma or flma) begin
		case (sel_2ndsfr_ma)
			1'b1	:cpuaddress = {2'b00,   flma[10:4]};	/* 2ndsfr att */
			default	:cpuaddress = {5'b01000, flma[7:4]};	/* sfr att */
		endcase
	end

	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			icewritedata <= 32'b0;
			icewritead   <= 8'b0;
		end
		else begin
			icewritedata <= icedi;
			icewritead <= iceifa;
		end
	end

	assign ice_res1 = !sysrsoutb | icewrite;
	always @(negedge icewr or posedge ice_res1) begin
		if (ice_res1)		icewritestart <= 1'b0;
		else if (sfratt_cs)	icewritestart <= 1'b1;
	end

	always @(posedge ck60mhz or negedge sysrsoutb) begin
		if (!sysrsoutb) icewrite <= 1'b0;
		else            icewrite <= icewritestart;
	end
	assign iceaddress = (icewrite) ? {1'b0, icewritead} : {1'b0, iceifa};


	/* FPGA RAM (DO* is latch output by en==0*) */
	RAMB16_S36_S36 ram1 ( 
		.ADDRA(cpuaddress), .DIA(32'b0)       , .DOA(cpu_out)  , .CLKA(baseck) , .ENA(1'b1)     , .WEA(1'b0)    , // cpu
		.ADDRB(iceaddress), .DIB(icewritedata), .DOB(icedo_out), .CLKB(ck60mhz), .ENB(sfratt_cs), .WEB(icewrite), // host
		.SSRA(1'b0), .DIPA(4'b0), .DOPA(),
		.SSRB(1'b0), .DIPB(4'b0), .DOPB()
		);

	assign	sfr_protect_ro = (sfratt_cs) ? icedo_out : 32'b0;
	/* ・同期memory出力なのでcpu動作に対して1clock遅れる.			*/
	/* ・32bitbusのデコード. ex) ma[3:0]=1111ならsfrarea_attw = cpu_out[31]	*/
	assign	sfrarea_attw = cpu_out[{flma_l1,1'b1}];
	assign	sfrarea_attr = cpu_out[{flma_l1,1'b0}];

endmodule



// =====================================================================================================
// RAM Initialize Error Protect										
// =====================================================================================================
module	ramini	(
		baseck, ck60mhz, sysrsoutb, failmk10, selfmode, svmod, alt1, idpop, fch, rd, wr, wdop,
		ramini_cs, conv_cs, sel_ram_pc, sel_ram_ma, sel_bram_ma, ovlapemu, icewr, iceifa, icedi,
		pc, flma, brkfail10, ramini_ro
	);

input		baseck, ck60mhz, sysrsoutb, failmk10, selfmode, svmod, alt1, idpop, fch, rd, wr, wdop,
		ramini_cs, conv_cs, sel_ram_pc, sel_ram_ma, sel_bram_ma, ovlapemu, icewr;
input [13:2]	iceifa;
input [31:0]	icedi;
input [15:0]	pc;
input [15:0]	flma;
output		brkfail10;
output [31:0]	ramini_ro;
// -----------------------------------------------------------------------------------------------------
//
// guard memory and break signal
//
reg		brkfail10;
reg [15:0]	flma_l;

reg [31:0]	icewritedata;
reg [9:0]	icewritead;
reg		icewritestart, icewrite;
reg [31:0]	ramini1_ro;

wire [31:0]	ramini_ro;

wire		cpu_en_fch, cpu_en_acc;
wire		firm_en;

wire		cpu_en_evn_lo_fch, cpu_en_evn_hi_fch, cpu_en_odd_lo_fch, cpu_en_odd_hi_fch;
wire		cpu_en_evn_lo_acc, cpu_en_evn_hi_acc, cpu_en_odd_lo_acc, cpu_en_odd_hi_acc;
wire		cpu_en_evn_lo_user, cpu_en_evn_hi_user, cpu_en_odd_lo_user, cpu_en_odd_hi_user;
wire		cpu_en_evn_lo_bram, cpu_en_evn_hi_bram, cpu_en_odd_lo_bram, cpu_en_odd_hi_bram;
wire		cpu_en_evn_lo_firm, cpu_en_evn_hi_firm, cpu_en_odd_lo_firm, cpu_en_odd_hi_firm;
wire		cpu_en_evn_lo, cpu_en_evn_hi, cpu_en_odd_lo, cpu_en_odd_hi;
wire		cpu_do_evn_hi, cpu_do_evn_lo, cpu_do_odd_hi, cpu_do_odd_lo;

wire		ice_en_lo, ice_en_hi, ice_res1;
wire [9:0]	iceaddress;
wire [15:0]	icewritedata_evn, icewritedata_odd;
wire [15:0]	ice_do_odd_hi, ice_do_evn_hi, ice_do_odd_lo, ice_do_evn_lo;
wire [31:0]	icedo_hi, icedo_lo;
wire		memwr;
wire		cpuwritedata;
//
// bram addres convert
//
/* cpu side */
wire		brama_cnv_en;
wire [15:0]	brama_cnv_0k, brama_cnv_1k, brama_cnv_2k, brama_cnv_3k, brama_cnv_4k, brama_cnv_5k;
reg [15:0]	brama_cnv;
/* ice side */
reg [8:0]	icewritead2;
reg [31:0]	icewritedata2;
reg		icewritestart2, icewrite2;
reg [31:0]	ramini2_ro;

wire		ice_res2;
wire		ice_en_0k, ice_en_1k, ice_en_2k, ice_en_3k, ice_en_4k, ice_en_5k;
wire [31:0]	ice_do_0k, ice_do_1k, ice_do_2k, ice_do_3k, ice_do_4k, ice_do_5k;
wire [8:0]	iceaddress2;

// -----------------------------------------------------------------------------------------------------
	assign	ramini_ro = ramini_cs ? ramini1_ro : ramini2_ro;

/* ---------------------------------------------------------------------------------------------------- */
/* break signal												*/
/* ---------------------------------------------------------------------------------------------------- */
	/* ------------------------------------------------------------------------------------	*/
	/* ・RAMB16_Sx_Sxの出力のリセットはENx==1,CLKx↑,SSRx==1の条件でSRVAL_xのレベルに初期化	*/
	/*   される.SRVAL_xのdefaultは0.ここで,Reset中はClockが入らないこともあり,SSRx==0固定で	*/
	/*   初期化は行わない構成にする.この場合,出力条件が来るまで出力が不定となるので,ENxで	*/
	/*   出力をmaskして使う.							        */
	/* ------------------------------------------------------------------------------------	*/
	reg idpop_mem;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	idpop_mem <= 1'b0;
		else		idpop_mem <= idpop;
	end
	reg idpop_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) idpop_l1 <= 1'b0;
		else		idpop_l1 <= idpop_mem;
	end
	reg wr_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	wr_l1 <= 1'b0;
		else		wr_l1 <= wr;
	end
	reg rd_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) rd_l1 <= 1'b0;
		else		rd_l1 <= rd;
	end
	reg wdop_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) wdop_l1 <= 1'b0;
		else		wdop_l1 <= wdop;
	end
	reg svmod_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) svmod_l1 <= 1'b0;
		else		svmod_l1 <= svmod;
	end
	reg cpu_en_odd_hi_fch_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) cpu_en_odd_hi_fch_l1 <= 1'b0;
		else		cpu_en_odd_hi_fch_l1 <= cpu_en_odd_hi_fch;
	end
	reg cpu_en_evn_hi_fch_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) cpu_en_evn_hi_fch_l1 <= 1'b0;
		else		cpu_en_evn_hi_fch_l1 <= cpu_en_evn_hi_fch;
	end
	reg cpu_en_odd_lo_fch_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) cpu_en_odd_lo_fch_l1 <= 1'b0;
		else		cpu_en_odd_lo_fch_l1 <= cpu_en_odd_lo_fch;
	end
	reg cpu_en_evn_lo_fch_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	cpu_en_evn_lo_fch_l1 <= 1'b0;
		else		cpu_en_evn_lo_fch_l1 <= cpu_en_evn_lo_fch;
	end
	reg cpu_en_odd_hi_acc_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	cpu_en_odd_hi_acc_l1 <= 1'b0;
		else		cpu_en_odd_hi_acc_l1 <= cpu_en_odd_hi_acc;
	end
	reg cpu_en_evn_hi_acc_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) cpu_en_evn_hi_acc_l1 <= 1'b0;
		else		cpu_en_evn_hi_acc_l1 <= cpu_en_evn_hi_acc;
	end
	reg cpu_en_odd_lo_acc_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) cpu_en_odd_lo_acc_l1 <= 1'b0;
		else		cpu_en_odd_lo_acc_l1 <= cpu_en_odd_lo_acc;
	end
	reg cpu_en_evn_lo_acc_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) cpu_en_evn_lo_acc_l1 <= 1'b0;
		else		cpu_en_evn_lo_acc_l1 <= cpu_en_evn_lo_acc;
	end

	/* ------------------------------------------------------------------------------------	*/
	/* ・POP命令(リードアクセス)では検出させない.						*/
	/* ・RAM隙間は初期化不要領域なので初期化忘れ検出されないようにする.			*/
	/*   nonmap検出はガードメモリを使用しないので、検出タイミングが1clock手前.		*/
	/* ・cpu_en_accは、alt1アクセスを許可する為にsvmod中でもenableとなるが,			*/
	/*   それによってfailsafeを行ってはいけないので,ここで別途svmod_lを入れる.		*/
	/*   (alt1はフラグの書き込みが目的.この場合MemoryWriteなので問題ないかもしれないが一応)	*/
	/* ------------------------------------------------------------------------------------	*/
	wire brk_odd_hi_fch, brk_evn_hi_fch, brk_odd_lo_fch, brk_evn_lo_fch;
	wire brk_odd_hi_rd, brk_evn_hi_rd, brk_odd_lo_rd, brk_evn_lo_rd;
	assign	brk_odd_hi_fch = ~cpu_do_odd_hi & cpu_en_odd_hi_fch_l1;
	assign	brk_evn_hi_fch = ~cpu_do_evn_hi & cpu_en_evn_hi_fch_l1;
	assign	brk_odd_lo_fch = ~cpu_do_odd_lo & cpu_en_odd_lo_fch_l1;
	assign	brk_evn_lo_fch = ~cpu_do_evn_lo & cpu_en_evn_lo_fch_l1;
	assign	brk_odd_hi_rd  = ~cpu_do_odd_hi & cpu_en_odd_hi_acc_l1 & rd_l1 & ~idpop_l1 & ~svmod_l1;
	assign	brk_evn_hi_rd  = ~cpu_do_evn_hi & cpu_en_evn_hi_acc_l1 & rd_l1 & ~idpop_l1 & ~svmod_l1;
	assign	brk_odd_lo_rd  = ~cpu_do_odd_lo & cpu_en_odd_lo_acc_l1 & rd_l1 & ~idpop_l1 & ~svmod_l1;
	assign	brk_evn_lo_rd  = ~cpu_do_evn_lo & cpu_en_evn_lo_acc_l1 & rd_l1 & ~idpop_l1 & ~svmod_l1;

	wire brk;
	assign	brk =	brk_evn_lo_fch | brk_evn_lo_rd | brk_evn_hi_fch | brk_evn_hi_rd |
			brk_odd_lo_fch | brk_odd_lo_rd | brk_odd_hi_fch | brk_odd_hi_rd;

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) brkfail10 <= 1'b0;
		else if (!failmk10) brkfail10 <= brk;
	end

/* ---------------------------------------------------------------------------------------------------- */
/* Guard Memory Unit											*/
/* ---------------------------------------------------------------------------------------------------- */

//		
// CPU Side	
//		

	/* ------------------------------------ */
	/* RAM初期化フラグ書き込み条件		*/
	/*  (1)ユーザプログラムによる書き込み	*/
	/*  (2)alt1命令による書き込み		*/
	/*  (3)ホストからの書き込み(ice-side)	*/
	/* ------------------------------------ */

	/* ----------------------------------------------------------------------------	*/
	/* FlashSelf時のUserArea書き込み時Enable(BRAMACによるoverlap空間を除く)		*/
	/* ----------------------------------------------------------------------------	*/
	reg sel_ram_ma_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)
			sel_ram_ma_l1 <= 1'b0;
		else	sel_ram_ma_l1 <= sel_ram_ma;
	end
	reg selfmode_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)
			selfmode_l1 <= 1'b0;
		else	selfmode_l1 <= selfmode;
	end
	reg selfmode_l2;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)
			selfmode_l2 <= 1'b0;
		else	selfmode_l2 <= selfmode_l1;
	end
	reg selfmode_l3;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)
			selfmode_l3 <= 1'b0;
		else	selfmode_l3 <= selfmode_l2;
	end
	
	/* --------------------------------------------------------------------------------------------	*/
	/* 通常時enable											*/
	/* RAMfetch中のRAM空間以外のaccessで誤動作しないようaccessのenable条件にsel_ram_maを入れる.	*/
	/* selfmode_l1からselfmode_l3に変更(Ver1.39)							*/
	/* [enable]     [change timing at self]	[enable accecc]						*/
	/* cpu_en_fch	selfmode		fch	sel_ram_pcはselfmodeと同期するのでこのままでOK.	*/
	/* cpu_en_acc	selfmode_l3		rd,wr	切り替えTimingをselfmode_l3で合わせる.		*/
	/* firm_en	selfmode_l3		wr_l1	UserModeへの切り替わりが遅れることになるが,	*/
	/* brama_cnv_en	selfmode_l3		wr_l1	branch後でTimingにMarginがあるので問題ない.	*/
	/* --------------------------------------------------------------------------------------------	*/
	assign	cpu_en_fch = ~selfmode & ~svmod & sel_ram_pc & fch;
	assign	cpu_en_acc = ~selfmode_l3 & (~svmod | alt1) & sel_ram_ma & (rd | wr);
	assign	firm_en = selfmode_l3 & sel_ram_ma_l1 & wr_l1;
	
	/* ------------------------------------------------------------	*/
	/* 通常時enable							*/
	/* break信号の生成に兼用できるようfetchとaccessで信号を分ける	*/
	/* ------------------------------------------------------------	*/
	assign	cpu_en_evn_lo_fch =   ~pc[15] &   ~pc[0] & cpu_en_fch;
	assign	cpu_en_evn_hi_fch =    pc[15] &   ~pc[0] & cpu_en_fch;
	assign	cpu_en_odd_lo_fch =   ~pc[15] &    pc[0] & cpu_en_fch;
	assign	cpu_en_odd_hi_fch =    pc[15] &    pc[0] & cpu_en_fch;
	assign	cpu_en_evn_lo_acc = ~flma[15] & ~flma[0] & cpu_en_acc;
	assign	cpu_en_evn_hi_acc =  flma[15] & ~flma[0] & cpu_en_acc;
	assign	cpu_en_odd_lo_acc = ~flma[15] & (flma[0] | ~flma[0] & wdop) & cpu_en_acc;
	assign	cpu_en_odd_hi_acc =  flma[15] & (flma[0] | ~flma[0] & wdop) & cpu_en_acc;

	assign	cpu_en_evn_lo_user = cpu_en_evn_lo_fch | cpu_en_evn_lo_acc;
	assign	cpu_en_evn_hi_user = cpu_en_evn_hi_fch | cpu_en_evn_hi_acc;
	assign	cpu_en_odd_lo_user = cpu_en_odd_lo_fch | cpu_en_odd_lo_acc;
	assign	cpu_en_odd_hi_user = cpu_en_odd_hi_fch | cpu_en_odd_hi_acc;

	/* ------------------------------------------------------------	*/
	/* firmによるBRAM空間書き込み時にもGuardMemoryをenableにする.	*/
	/* ------------------------------------------------------------	*/
	assign	cpu_en_evn_lo_bram = ~brama_cnv[15] & ~brama_cnv[0] & brama_cnv_en;
	assign	cpu_en_evn_hi_bram =  brama_cnv[15] & ~brama_cnv[0] & brama_cnv_en;
	assign	cpu_en_odd_lo_bram = ~brama_cnv[15] & (brama_cnv[0] | ~brama_cnv[0] & wdop_l1) & brama_cnv_en;
	assign	cpu_en_odd_hi_bram =  brama_cnv[15] & (brama_cnv[0] | ~brama_cnv[0] & wdop_l1) & brama_cnv_en;

	/* ------------------------------------------------------------	*/
	/* firmによるユーザRAM書き込み時にもGuardMemoryをenableにする.	*/
	/* bramacによるaccessとtimingがぶつからないよう1clock遅らせる.	*/
	/* ------------------------------------------------------------	*/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	flma_l <= 16'h0;
		else		flma_l <= flma;
	end
	assign	cpu_en_evn_lo_firm = ~flma_l[15] & ~flma_l[0] & firm_en;
	assign	cpu_en_evn_hi_firm =  flma_l[15] & ~flma_l[0] & firm_en;
	assign	cpu_en_odd_lo_firm = ~flma_l[15] & (flma_l[0] | ~flma_l[0] & wdop_l1) & firm_en;
	assign	cpu_en_odd_hi_firm =  flma_l[15] & (flma_l[0] | ~flma_l[0] & wdop_l1) & firm_en;
	
	/* ------------------- */
	/* Guard Memory Enable */
	/* ------------------- */
	assign	cpu_en_evn_lo = cpu_en_evn_lo_user | cpu_en_evn_lo_bram | cpu_en_evn_lo_firm;
	assign	cpu_en_evn_hi = cpu_en_evn_hi_user | cpu_en_evn_hi_bram | cpu_en_evn_hi_firm;
	assign	cpu_en_odd_lo = cpu_en_odd_lo_user | cpu_en_odd_lo_bram | cpu_en_odd_lo_firm;
	assign	cpu_en_odd_hi = cpu_en_odd_hi_user | cpu_en_odd_hi_bram | cpu_en_odd_hi_firm;
	
	wire userfch_en;
	assign	userfch_en = sel_ram_pc & fch;
	reg [13:0] cpuaddress;
	/* --------------------------------------------	*/
	/* selfmode_l1からselfmode_l3に変更(Ver1.39)	*/
	/* --------------------------------------------	*/
	always @(selfmode_l3 or brama_cnv_en or userfch_en or brama_cnv[14:1] or flma_l[14:1] or pc[14:1] or flma[14:1]) begin
		if (selfmode_l3) begin
			case (brama_cnv_en)
				1'b1 : cpuaddress = brama_cnv[14:1];
				1'b0 : cpuaddress = flma_l[14:1];
			endcase
		end else begin
			case(userfch_en)
				1'b1 : cpuaddress = pc[14:1];
				1'b0 : cpuaddress = flma[14:1];
			endcase
		end
	end
	
	/* --------------------------------------------------------------------------------------------	*/
	/* 排他のOr     < ↓user write access ><firm BRAM Area Write access↓><firm User Area Access↓>	*/
	/* wr_l1をbrama_cnv_en, firm_enの中に入れ込んだ.(Ver1.39)					*/
	/* --------------------------------------------------------------------------------------------	*/
	assign	memwr = ~selfmode_l3 & sel_ram_ma & wr | brama_cnv_en & ovlapemu | firm_en ;
	
	/* ----------------------------------------------------	*/
	/* ・firmによるBRAM書き込み時のみ0(未初期化)をwrite	*/
	/* ・firmによるUserRAM書き込み時は1(初期化)をwrite	*/
	/* Ver1.39で変更					*/
	/* ----------------------------------------------------	*/
	assign	cpuwritedata = (brama_cnv_en) ? 1'b0 : 1'b1;

//		
// ICE Side	
//		

	/* ------------------------------------	*/
	/*   HOST/4   CPU/8      CPU/2		*/
	/* iceaddress HOST  CPU  cpuaddress	*/
	/*	 07F6 1FD8  FEC0 3F60(evn_hi)	*/
	/*	 .... ....  .... ....	   	*/
	/*	 0041 0104  0820 0410(evn_lo)	*/
	/*	 .... ....  .... ....	   	*/
	/*	 0002 0008  0040 0020(evn_lo)	*/
	/*	 0001 0004  0020 0010(evn_lo)	*/
	/*	 0000 0000  0000 0000(evn_lo)	*/
	/* ------------------------------------	*/
	assign	ice_en_lo = ~iceifa[12];
	assign	ice_en_hi =  iceifa[12];

	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			icewritead <= 10'b0;
			icewritedata <= 32'b0;
		end
		else begin
			icewritead <= iceifa[11:2];
			icewritedata <= icedi;
		end
	end
	assign	icewritedata_evn = {
				icewritedata[30], icewritedata[28],
				icewritedata[26], icewritedata[24],
				icewritedata[22], icewritedata[20],
				icewritedata[18], icewritedata[16],
				icewritedata[14], icewritedata[12],
				icewritedata[10], icewritedata[8],
				icewritedata[6],  icewritedata[4],
				icewritedata[2],  icewritedata[0]};
	assign	icewritedata_odd = {
				icewritedata[31], icewritedata[29],
				icewritedata[27], icewritedata[25],
				icewritedata[23], icewritedata[21],
				icewritedata[19], icewritedata[17],
				icewritedata[15], icewritedata[13],
				icewritedata[11], icewritedata[9],
				icewritedata[7],  icewritedata[5],
				icewritedata[3],  icewritedata[1]};

	assign ice_res1 = !sysrsoutb | icewrite;
	always @(negedge icewr or posedge ice_res1) begin
		if (ice_res1)		icewritestart <= 1'b0;
		else if (ramini_cs)	icewritestart <= 1'b1;
	end

	always @(posedge ck60mhz or negedge sysrsoutb) begin
		if (!sysrsoutb)	icewrite <= 1'b0;
		else		icewrite <= icewritestart;
	end
	assign	iceaddress = (icewrite) ? icewritead : iceifa[11:2];

	assign	icedo_hi = {
			ice_do_odd_hi[15], ice_do_evn_hi[15],
			ice_do_odd_hi[14], ice_do_evn_hi[14],
			ice_do_odd_hi[13], ice_do_evn_hi[13],
			ice_do_odd_hi[12], ice_do_evn_hi[12],
			ice_do_odd_hi[11], ice_do_evn_hi[11],
			ice_do_odd_hi[10], ice_do_evn_hi[10],
			ice_do_odd_hi[9], ice_do_evn_hi[9],
			ice_do_odd_hi[8], ice_do_evn_hi[8],
			ice_do_odd_hi[7], ice_do_evn_hi[7],
			ice_do_odd_hi[6], ice_do_evn_hi[6],
			ice_do_odd_hi[5], ice_do_evn_hi[5],
			ice_do_odd_hi[4], ice_do_evn_hi[4],
			ice_do_odd_hi[3], ice_do_evn_hi[3],
			ice_do_odd_hi[2], ice_do_evn_hi[2],
			ice_do_odd_hi[1], ice_do_evn_hi[1],
			ice_do_odd_hi[0], ice_do_evn_hi[0]};

	assign	icedo_lo = {
			ice_do_odd_lo[15], ice_do_evn_lo[15],
			ice_do_odd_lo[14], ice_do_evn_lo[14],
			ice_do_odd_lo[13], ice_do_evn_lo[13],
			ice_do_odd_lo[12], ice_do_evn_lo[12],
			ice_do_odd_lo[11], ice_do_evn_lo[11],
			ice_do_odd_lo[10], ice_do_evn_lo[10],
			ice_do_odd_lo[9], ice_do_evn_lo[9],
			ice_do_odd_lo[8], ice_do_evn_lo[8],
			ice_do_odd_lo[7], ice_do_evn_lo[7],
			ice_do_odd_lo[6], ice_do_evn_lo[6],
			ice_do_odd_lo[5], ice_do_evn_lo[5],
			ice_do_odd_lo[4], ice_do_evn_lo[4],
			ice_do_odd_lo[3], ice_do_evn_lo[3],
			ice_do_odd_lo[2], ice_do_evn_lo[2],
			ice_do_odd_lo[1], ice_do_evn_lo[1],
			ice_do_odd_lo[0], ice_do_evn_lo[0]};

	always @( ramini_cs or iceifa[12] or icedo_lo or icedo_hi ) begin
		casex({ramini_cs, iceifa[12]})	// synthesis parallel_case
			2'b0x :	ramini1_ro = 32'h0;
			2'b10 :	ramini1_ro = icedo_lo;
			2'b11 :	ramini1_ro = icedo_hi;
		endcase
	end

//		
// Guard Memory	
//		

	RAMB16_S1_S18 ramini_odd_hi (
	.ADDRA(cpuaddress), .DIA(cpuwritedata)    , .DOA(cpu_do_odd_hi), .CLKA(baseck) , .ENA(cpu_en_odd_hi), .WEA(memwr),
	.ADDRB(iceaddress), .DIB(icewritedata_odd), .DOB(ice_do_odd_hi), .CLKB(ck60mhz), .ENB(ice_en_hi)    , .WEB(icewrite),
	.SSRA(1'b0),
	.SSRB(1'b0), .DIPB(2'b0), .DOPB()
	);

	RAMB16_S1_S18 ramini_evn_hi (
	.ADDRA(cpuaddress), .DIA(cpuwritedata)    , .DOA(cpu_do_evn_hi), .CLKA(baseck) , .ENA(cpu_en_evn_hi), .WEA(memwr),
	.ADDRB(iceaddress), .DIB(icewritedata_evn), .DOB(ice_do_evn_hi), .CLKB(ck60mhz), .ENB(ice_en_hi)    , .WEB(icewrite),
	.SSRA(1'b0),
	.SSRB(1'b0), .DIPB(2'b0), .DOPB()
	);

	RAMB16_S1_S18 ramini_odd_lo (
	.ADDRA(cpuaddress), .DIA(cpuwritedata)    , .DOA(cpu_do_odd_lo), .CLKA(baseck),  .ENA(cpu_en_odd_lo), .WEA(memwr),
	.ADDRB(iceaddress), .DIB(icewritedata_odd), .DOB(ice_do_odd_lo), .CLKB(ck60mhz), .ENB(ice_en_lo)    , .WEB(icewrite),
	.SSRA(1'b0),
	.SSRB(1'b0), .DIPB(2'b0), .DOPB()
	);

	RAMB16_S1_S18 ramini_evn_lo (
	.ADDRA(cpuaddress), .DIA(cpuwritedata)    , .DOA(cpu_do_evn_lo), .CLKA(baseck) , .ENA(cpu_en_evn_lo), .WEA(memwr),
	.ADDRB(iceaddress), .DIB(icewritedata_evn), .DOB(ice_do_evn_lo), .CLKB(ck60mhz), .ENB(ice_en_lo)    , .WEB(icewrite),
	.SSRA(1'b0),
	.SSRB(1'b0), .DIPB(2'b0), .DOPB()
	);

/* ---------------------------------------------------------------------------------------------------- */
/* BRAM Address Convert Unit										*/
/* ---------------------------------------------------------------------------------------------------- */

//		
// CPU Side	
//		
	/* Convert Memory Enable.↓bram範囲外ならdisable */
	wire cpu_en_0k_p, cpu_en_1k_p, cpu_en_2k_p, cpu_en_3k_p, cpu_en_4k_p, cpu_en_5k_p;
	assign	cpu_en_0k_p = sel_bram_ma & (flma[12:10] == 3'h2) ? 1'b1:1'b0;
	assign	cpu_en_1k_p = sel_bram_ma & (flma[12:10] == 3'h3) ? 1'b1:1'b0;
	assign	cpu_en_2k_p = sel_bram_ma & (flma[12:10] == 3'h4) ? 1'b1:1'b0;
	assign	cpu_en_3k_p = sel_bram_ma & (flma[12:10] == 3'h5) ? 1'b1:1'b0;
	assign	cpu_en_4k_p = sel_bram_ma & (flma[12:10] == 3'h6) ? 1'b1:1'b0;
	assign	cpu_en_5k_p = sel_bram_ma & (flma[12:10] == 3'h7) ? 1'b1:1'b0;
	
	/* selfmode = sel_bram_pc or sel_bfa_pc */
	/* address切り替わりをselfmode_l3にするので,Memory Enableはselfmode_l2 */
	wire cpu_en_0k, cpu_en_1k, cpu_en_2k, cpu_en_3k, cpu_en_4k, cpu_en_5k;
	assign	cpu_en_0k = selfmode_l2 & cpu_en_0k_p;
	assign	cpu_en_1k = selfmode_l2 & cpu_en_1k_p;
	assign	cpu_en_2k = selfmode_l2 & cpu_en_2k_p;
	assign	cpu_en_3k = selfmode_l2 & cpu_en_3k_p;
	assign	cpu_en_4k = selfmode_l2 & cpu_en_4k_p;
	assign	cpu_en_5k = selfmode_l2 & cpu_en_5k_p;
	
	/* ----------------------------------------------------------------------------	*/
	/* brama有効条件(brama_cnv_en)に使用のselfmode_l1をselfmode_l3に変更.		*/
	/* address,write,BRAMAC-Memory enable信号の切り替えTimingをselfmode_l2に統一.	*/
	/* Ver1.39で変更.								*/
	/* ----------------------------------------------------------------------------	*/
	reg cpu_en_0k_l1, cpu_en_1k_l1, cpu_en_2k_l1, cpu_en_3k_l1, cpu_en_4k_l1, cpu_en_5k_l1;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	begin
			cpu_en_0k_l1 <= 1'b0;
			cpu_en_1k_l1 <= 1'b0;
			cpu_en_2k_l1 <= 1'b0;
			cpu_en_3k_l1 <= 1'b0;
			cpu_en_4k_l1 <= 1'b0;
			cpu_en_5k_l1 <= 1'b0;
		end else begin
			cpu_en_0k_l1 <= cpu_en_0k_p;
			cpu_en_1k_l1 <= cpu_en_1k_p;
			cpu_en_2k_l1 <= cpu_en_2k_p;
			cpu_en_3k_l1 <= cpu_en_3k_p;
			cpu_en_4k_l1 <= cpu_en_4k_p;
			cpu_en_5k_l1 <= cpu_en_5k_p;
		end
	end
	
	/* --------------------------------------------------------------------	*/
	/* FlashSelf時のBRAMACによるoverlap空間RAM未初期化Flag書き込みenable.	*/
	/* self中のuser割り込みでは,Stack動作がJustTimingのUser動作と1Clock遅れ	*/
	/* のFirm動作でぶつかってしまう.この回避の為,selfmode_l3信号を使用.	*/
	/* Ver1.39で変更.							*/
	/* --------------------------------------------------------------------	*/
	assign	brama_cnv_en = selfmode_l3 & wr_l1 & (cpu_en_0k_l1 | cpu_en_1k_l1 | cpu_en_2k_l1 | cpu_en_3k_l1 | cpu_en_4k_l1 | cpu_en_5k_l1);
	
	always @(cpu_en_0k_l1 or cpu_en_1k_l1 or cpu_en_2k_l1 or cpu_en_3k_l1 or cpu_en_4k_l1 or cpu_en_5k_l1 or
		brama_cnv_0k or brama_cnv_1k or brama_cnv_2k or brama_cnv_3k or brama_cnv_4k or brama_cnv_5k) begin
		case ({cpu_en_0k_l1, cpu_en_1k_l1, cpu_en_2k_l1, cpu_en_3k_l1, cpu_en_4k_l1, cpu_en_5k_l1})
			6'b100000 : brama_cnv = brama_cnv_0k;
			6'b010000 : brama_cnv = brama_cnv_1k;
			6'b001000 : brama_cnv = brama_cnv_2k;
			6'b000100 : brama_cnv = brama_cnv_3k;
			6'b000010 : brama_cnv = brama_cnv_4k;
			6'b000001 : brama_cnv = brama_cnv_5k;
			default : brama_cnv = 16'h0;
		endcase
	end
	
//		
// ICE Side	
//		

	/* --------------------------------------------	*/
	/*   host/4    cpu*2				*/
	/* iceaddress2 HOST    CPU    cpuaddress2	*/
	/* (en_5k)0ff  3bfc 1dfe,1dff (en_5k)1fe,1ff	*/
	/* (en_5k)000  3800 1c00,1c01 (en_5k)000,001	*/
	/* (en_4k)000  3000 1800,1801 (en_4k)000,001	*/
	/* (en_3k)000  2800 1400,1401 (en_3k)000,001	*/
	/* (en_2k)000  2000 1000,1001 (en_2k)000,001	*/
	/* (en_1k)000  1800 0c00,0c01 (en_1k)000,001	*/
	/*  ..... ...  .... .... ....  ..... ... ...	*/
	/* (en_0k)002  1008 0804,0804 (en_0k)004,003	*/
	/* (en_0k)001  1004 0802,0803 (en_0k)003,002	*/
	/* (en_0k)000  1000 0800,0801 (en_0k)001,000	*/
	/* --------------------------------------------	*/
	assign	ice_en_0k = conv_cs & (iceifa[13:11] == 3'h2) ? 1'b1:1'b0;
	assign	ice_en_1k = conv_cs & (iceifa[13:11] == 3'h3) ? 1'b1:1'b0;
	assign	ice_en_2k = conv_cs & (iceifa[13:11] == 3'h4) ? 1'b1:1'b0;
	assign	ice_en_3k = conv_cs & (iceifa[13:11] == 3'h5) ? 1'b1:1'b0;
	assign	ice_en_4k = conv_cs & (iceifa[13:11] == 3'h6) ? 1'b1:1'b0;
	assign	ice_en_5k = conv_cs & (iceifa[13:11] == 3'h7) ? 1'b1:1'b0;

	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			icewritead2 <= 9'b0;
			icewritedata2 <= 32'b0;
		end
		else begin
			icewritead2 <= iceifa[10:2];
			icewritedata2 <= icedi;
		end
	end

	assign	ice_res2 = !sysrsoutb | icewrite2;
	always @(negedge icewr or posedge ice_res2) begin
		if (ice_res2)		icewritestart2 <= 1'b0;
		else if (conv_cs)	icewritestart2 <= 1'b1;
	end
	always @(posedge ck60mhz or negedge sysrsoutb) begin
		if (!sysrsoutb) icewrite2 <= 1'b0;
		else		icewrite2 <= icewritestart2;
	end

	assign	iceaddress2 = (icewrite2) ? icewritead2 : iceifa[10:2];

	always @( ice_en_0k or ice_en_1k or ice_en_2k or ice_en_3k or ice_en_4k or ice_en_5k or
		ice_do_0k or ice_do_1k or ice_do_2k or ice_do_3k or ice_do_4k or ice_do_5k) begin
		case ({ice_en_0k, ice_en_1k, ice_en_2k, ice_en_3k, ice_en_4k, ice_en_5k})
			6'b100000: ramini2_ro = ice_do_0k;
			6'b010000: ramini2_ro = ice_do_1k;
			6'b001000: ramini2_ro = ice_do_2k;
			6'b000100: ramini2_ro = ice_do_3k;
			6'b000010: ramini2_ro = ice_do_4k;
			6'b000001: ramini2_ro = ice_do_5k;
			default  : ramini2_ro = 32'h0;
		endcase
	end

//			
// Convert Memory	
//			

	RAMB16_S18_S36	conv1 (
	.ADDRA(flma[9:0])  , .DIA(16'h0)        , .DOA(brama_cnv_0k), .CLKA(baseck) , .ENA(cpu_en_0k), .WEA(1'b0),
	.ADDRB(iceaddress2), .DIB(icewritedata2), .DOB(ice_do_0k)   , .CLKB(ck60mhz), .ENB(ice_en_0k), .WEB(icewrite2),
	.SSRA(1'b0), .DIPA(2'h0), .DOPA(),
	.SSRB(1'b0), .DIPB(4'h0), .DOPB()
	);

	RAMB16_S18_S36	conv2 (
	.ADDRA(flma[9:0])  , .DIA(16'h0),         .DOA(brama_cnv_1k), .CLKA(baseck) , .ENA(cpu_en_1k), .WEA(1'b0),
	.ADDRB(iceaddress2), .DIB(icewritedata2), .DOB(ice_do_1k)   , .CLKB(ck60mhz), .ENB(ice_en_1k), .WEB(icewrite2),
	.SSRA(1'b0), .DIPA(2'h0), .DOPA(),
	.SSRB(1'b0), .DIPB(4'h0), .DOPB()
	);

	RAMB16_S18_S36	conv3 (
	.ADDRA(flma[9:0])  , .DIA(16'h0),         .DOA(brama_cnv_2k), .CLKA(baseck) , .ENA(cpu_en_2k), .WEA(1'b0),
	.ADDRB(iceaddress2), .DIB(icewritedata2), .DOB(ice_do_2k)   , .CLKB(ck60mhz), .ENB(ice_en_2k), .WEB(icewrite2),
	.SSRA(1'b0), .DIPA(2'h0), .DOPA(),
	.SSRB(1'b0), .DIPB(4'h0), .DOPB()
	);

	RAMB16_S18_S36	conv4 (
	.ADDRA(flma[9:0]),   .DIA(16'h0),         .DOA(brama_cnv_3k), .CLKA(baseck) , .ENA(cpu_en_3k), .WEA(1'b0),
	.ADDRB(iceaddress2), .DIB(icewritedata2), .DOB(ice_do_3k)   , .CLKB(ck60mhz), .ENB(ice_en_3k), .WEB(icewrite2),
	.SSRA(1'b0), .DIPA(2'h0), .DOPA(),
	.SSRB(1'b0), .DIPB(4'h0), .DOPB()
	);

	RAMB16_S18_S36	conv5 (
	.ADDRA(flma[9:0]),   .DIA(16'h0),         .DOA(brama_cnv_4k), .CLKA(baseck) , .ENA(cpu_en_4k), .WEA(1'b0),
	.ADDRB(iceaddress2), .DIB(icewritedata2), .DOB(ice_do_4k)   , .CLKB(ck60mhz), .ENB(ice_en_4k), .WEB(icewrite2),
	.SSRA(1'b0), .DIPA(2'h0), .DOPA(),
	.SSRB(1'b0), .DIPB(4'h0), .DOPB()
	);

	RAMB16_S18_S36	conv6 (
	.ADDRA(flma[9:0]),   .DIA(16'h0),         .DOA(brama_cnv_5k), .CLKA(baseck) , .ENA(cpu_en_5k), .WEA(1'b0),
	.ADDRB(iceaddress2), .DIB(icewritedata2), .DOB(ice_do_5k)   , .CLKB(ck60mhz), .ENB(ice_en_5k), .WEB(icewrite2),
	.SSRA(1'b0), .DIPA(2'h0), .DOPA(),
	.SSRB(1'b0), .DIPB(4'h0), .DOPB()
	);

endmodule



// =====================================================================================================
// SP OverFlow/ UnderFlow										
// =====================================================================================================
module	sp_rangeout	(
		baseck, sysrsoutb, failmk7, failmk8, selfmode, svmod, spinc, spdec, sprel, cpurd, cpuwr,
		dma, flma, ustadrh, ustadrl, brkfail7, brkfail8
	);

input		baseck, sysrsoutb, failmk7, failmk8, selfmode, svmod, spinc, spdec, sprel,cpurd, cpuwr, dma;
input [15:0]	flma;
input [15:1]	ustadrh, ustadrl;
output		brkfail7, brkfail8;

reg		brkfail7, brkfail8a, brkfail8b_p;
wire		sp_up, sp_lo, brkfail8b;

	/* ------------------------------------------------------------------------------------	*/
	/* ・popはread後にspをincrementし,pushはspをdecrement後にwriteするので,			*/
	/*   pop後のspが設定範囲外でも検出しない. ->						*/
	/*   spのincrement後にSPINCが立つのでmaを使用する(maはincrement前の値)			*/
	/* ・popはword単位で偶数accessのみなので,偶数addressが上限に設定されていた場合にpopした	*/
	/*   奇数addressが範囲外であっても検出できない(pushも同様) ->				*/
	/*           f008            f008  push          f002                  f002 push	*/
	/*           f007  <-(非検出)f007    <-(非検出)  f001                  f001		*/
	/*           --------        ----------          --------------        ----------	*/
	/*   ustadrh f006 pop,spinc  f006 spdec  ustadrl f000 pop,spinc(検出)  f000 spdec(検出)	*/
	/*											*/
	/* 　ustadrhの最下位bitは1固定, ustadrlの最下位bitは0固定の仕様とする.			*/
	/*   (ustadrlは0固定にする必要ないが、分かりやすくする為)				*/
	/* ------------------------------------------------------------------------------------	*/
	assign	sp_up = (flma > {ustadrh, 1'b1}) ? 1'b1:1'b0;
	assign	sp_lo = (flma < {ustadrl, 1'b0}) ? 1'b1:1'b0;

	//		
	// SP Under Flow
	//		
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) brkfail7 <= 1'b0;
		/* ------------------------------------------------------------------------------------	*/
		/* ・sp書き込み直後にsp相対命令を実行するとsprel信号が1clock早く立ち上がる問題がある為,	*/
		/*   cpurd,cpuwrとandする.spinc,spdecについてはエバコアで対応済み.			*/
		/* ・retとdmaの競合時,dma転送中にもspnicがactiveとなる為,dma信号でmask(不具合修正)	*/
		/* ------------------------------------------------------------------------------------	*/
		else if (~failmk7 & ~selfmode & ~svmod & (spinc|spdec|sprel) & sp_up & (cpurd | cpuwr) & ~dma)
				brkfail7 <= 1'b1;
		else		brkfail7 <= 1'b0;
	end
	//		
	// SP Over Flow	
	//		

	/* ----------------------------------------------------------------------------	*/
	/* User Stack Overflowはself中にも検出を行い,self終了後にbreak信号を出力する.	*/
	/* ----------------------------------------------------------------------------	*/
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) brkfail8a <= 1'b0;
		else if (~failmk8 & ~selfmode & ~svmod & (spdec|spinc|sprel) & sp_lo & (cpurd | cpuwr) & ~dma)
				brkfail8a <= 1'b1;
		else		brkfail8a <= 1'b0;
	end

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	brkfail8b_p <= 1'b0;
		else if (~selfmode)
				brkfail8b_p <= 1'b0;
		else if (~failmk8 & selfmode & ~svmod & (spdec|spinc|sprel) & sp_lo & (cpurd | cpuwr) & ~dma)
				brkfail8b_p <= 1'b1;
	end
	assign	brkfail8b = ~selfmode & brkfail8b_p;
	assign	brkfail8 = brkfail8a | brkfail8b;

endmodule



// =====================================================================================================
// SP NotInitialize											
// =====================================================================================================
module	sp_ini	(
		baseck, cpuresetb, sysrsoutb, failmk9, selfmode, svmod, sel_sfr_ma, wdop, cpurd, cpuwr,
		spinc, spdec, sprel, flma, brkfail9
	);

input		baseck, cpuresetb, sysrsoutb, failmk9, selfmode, svmod, sel_sfr_ma, wdop, cpurd, cpuwr,
		spinc, spdec, sprel;
input [7:0]	flma;
output		brkfail9;

reg	sp_notset1, sp_notset2;
reg	brkfail9;
wire	sp_notset;

	/* SP下位書き込み */
	always @(posedge baseck or negedge cpuresetb) begin
		if (!cpuresetb)	sp_notset1 <= 1'b1;
		else if (~selfmode & ~svmod & sel_sfr_ma & (flma[7:0] == 8'hf8) & cpuwr)
				sp_notset1 <= 1'b0;
	end
	/* SP上位書き込み,またはSPWord書き込み */
	always @(posedge baseck or negedge cpuresetb) begin
		if (!cpuresetb) sp_notset2 <= 1'b1;
		else if (~selfmode & ~svmod & sel_sfr_ma & (flma[7:1] == 7'h7c) & (flma[0] | (~flma[0] & wdop)) & cpuwr)
				sp_notset2 <= 1'b0;
	end
	assign	sp_notset = sp_notset1 | sp_notset2;

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	brkfail9 <= 1'b0;
		else if (~failmk9 & ~selfmode & ~svmod & sp_notset & (spdec | spinc | sprel) & (cpurd | cpuwr))
				brkfail9 <= 1'b1;
		else		brkfail9 <= 1'b0;
	end

endmodule



// =====================================================================================================
// Peripheral Macro break										
// =====================================================================================================
module	peri_protect (baseck, sysrsoutb, failmk11, selfmode, svmod, perisvib, softbrk, brkfail11);

input	baseck, sysrsoutb, failmk11, selfmode, svmod, perisvib;
input	softbrk;
output	brkfail11;

reg	brkfail11;

	always @( posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	brkfail11 <= 1'b0;
		else if (~failmk11 & ~selfmode & ~(svmod & ~softbrk) & ~perisvib)	/* [V1.45(2)] */
				brkfail11 <= 1'b1;
		else		brkfail11 <= 1'b0;
	end

endmodule



// =====================================================================================================
// misalign access break										
// =====================================================================================================
module	misalign (baseck, sysrsoutb, failmk13, selfmode, svmod, cpumisal, dma, brkfail13);

input	baseck, sysrsoutb, failmk13, selfmode, svmod, cpumisal, dma;
output	brkfail13;

reg	brkfail13;

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	brkfail13 <= 1'b0;
		else if (~failmk13 & ~selfmode & ~svmod & ~dma & cpumisal)
				brkfail13 <= 1'b1;
		else		brkfail13 <= 1'b0;
	end

endmodule


// [V1.49]
// =====================================================================================================
// Data Flash Word Read access break									
// =====================================================================================================
module	dflash_wread (
		baseck, sysrsoutb, failmk14, selfmode, svmod, rd, wdop, sel_dfad_ma_wdrdprtct, brkfail15
	);

input	baseck, sysrsoutb, failmk14, selfmode, svmod, rd, wdop, sel_dfad_ma_wdrdprtct;
output	brkfail15;

	reg brkfail15;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) brkfail15 <= 1'b0;
		else if (~failmk14 & ~selfmode & ~svmod & rd & wdop & sel_dfad_ma_wdrdprtct)
				brkfail15 <= 1'b1;
		else		brkfail15 <= 1'b0;
	end
endmodule



// =====================================================================================================
// area signals												
// =====================================================================================================
module	sel_area (
		baseck, sysrsoutb, pcwaitf, intack, dmaack, waitexm, ocdwait, skipexe, cpurd, cpuwr, fchram, wdop, maa,
		stageadr, exma, flma, pc, flsize, ramsize, flsizeice, ramsizeice, bfsize, bmsize,
		exadh0, exadh1, exadh2, exadh3, exadl0, exadl1, exadl2, exadl3, dfadh, dfadl,
		fch, rd, wr, dma,
		sel_sfr_pc, sel_sfr_ma,
		sel_generalreg_pc,
		sel_ram_pc, sel_ram_ma,
		sel_mirror_pc, sel_mirror_ma,
		sel_bram_pc, sel_bram_ma,
		sel_2ndsfr_pc, sel_2ndsfr_ma,
		sel_bfa_pc, sel_bfa_ma,
		sel_exmem_ma_all,
		sel_rom_ma,
		sel_nonmap_rom_pc, sel_nonmap_rom_ma,
		sel_nonmap_mirror_maa,
		sel_nonmap_ram_pc, sel_nonmap_ram_ma,
		sel_nonmap_exmem_pc, sel_nonmap_exmem_ma,
		sel_exad0_ma_wprtct, sel_exad1_ma_wprtct,
		sel_exad2_ma_wprtct, sel_exad3_ma_wprtct,
		sel_exmem_pc_all,
		sel_ram_pc_all,
		sel_rom_pc_all,
		sel_dfad_pc,
		sel_dfad_ma_wprtct,
		sel_dfad_ma_wdrdprtct,
		sel_dfad_ma
	);

input		baseck, sysrsoutb, pcwaitf, intack, dmaack, waitexm, ocdwait, skipexe, cpurd, cpuwr, fchram, wdop, maa;
input [1:0]	stageadr;
input [3:0]	exma;
input [15:0]	flma;
input [19:0]	pc;
input [3:0]	flsize;
input [7:0]	ramsize;
input [5:0]	flsizeice;
input [0:0]	ramsizeice;
input [3:0]	bfsize;
input [3:0]	bmsize;
input [19:0]	exadh0, exadh1, exadh2, exadh3;
input [19:0]	exadl0, exadl1, exadl2, exadl3;
input [19:0]	dfadh, dfadl;
output		fch, rd, wr, dma;
output		sel_sfr_pc, sel_sfr_ma;
output		sel_generalreg_pc;
output		sel_ram_pc, sel_ram_ma;
output		sel_mirror_pc, sel_mirror_ma;
output		sel_bram_pc, sel_bram_ma;
output		sel_2ndsfr_pc, sel_2ndsfr_ma;
output		sel_bfa_pc, sel_bfa_ma;
output		sel_exmem_ma_all;
output		sel_rom_ma;
output		sel_nonmap_rom_pc, sel_nonmap_rom_ma;
output		sel_nonmap_mirror_maa; // [V1.43]
output		sel_nonmap_ram_pc, sel_nonmap_ram_ma;
output		sel_nonmap_exmem_pc, sel_nonmap_exmem_ma;
output		sel_exad0_ma_wprtct, sel_exad1_ma_wprtct, sel_exad2_ma_wprtct, sel_exad3_ma_wprtct;
output		sel_exmem_pc_all; // [V1.42] Output for ice macro
output		sel_ram_pc_all; // [V1.42] Output for ice macro
output		sel_rom_pc_all;	// [V1.48] Output for ice macro
output		sel_dfad_pc;
output		sel_dfad_ma_wprtct;
output		sel_dfad_ma_wdrdprtct;
output		sel_dfad_ma; // [V1.53]

// -------------------------------------------------------------------------------------------------------
reg		pcwaitf_l;
reg		dmaack_l1, dmaack_l2;
wire [3:0]	maup;
wire		sel_ffxxxh_pc;
wire		sel_ffxxxh_ma;
wire		rom_nogap;
wire		boundary_rom_pc, rom_gap_pc;
wire		boundary_rom_ma, boundary_mirror_ma, rom_gap_ma;
wire		sel_fxxxxh_pc, sel_fxxxxh_ma;
wire		sel_exxxxh_pc, sel_exxxxh_ma;
wire		sel_generalreg_ma;
//wire		sel_exmem_pc;
wire		sel_rom_pc;
wire		sel_exad0_pc, sel_exad1_pc, sel_exad2_pc, sel_exad3_pc;
wire		sel_dfad_ma_nonmap;
wire		sel_ram_pc_all, sel_ram_ma_all;
wire		sel_mirror_pc_all, sel_mirror_ma_all;
wire		sel_exmem_pc_all, sel_exmem_ma_all;
wire		sel_rom_pc_all, sel_rom_ma_all;
wire		sel_exad0_ma_nonmap, sel_exad1_ma_nonmap, sel_exad2_ma_nonmap, sel_exad3_ma_nonmap;

// -------------------------------------------------------------------------------------------------------
//		
// 内部status	
//		
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	pcwaitf_l <= 1'b0;
		else		pcwaitf_l <= pcwaitf;
	end
	/* ------------------------------------------------------------------------------------------------------------	*/
	/* ・intの場合,prefetchのpcがstageadr, pcwaitfでmaskされないので,intackでmaskする(~intack).(fetch)		*/
	/* ・intの場合,VectorRead時にstageadrが立ちFetchStatusが立たなくなるので別途条件に入れる(intack_l2).(fetch)	*/
	/* ・dma転送時はpcwaitfが立たない為,別途条件に入れる(fetch)							*/
	/* ・RAMFetchでのdma転送時はdmaReadがmaskされるので,dma転送はmaskされないよう条件に別途入れる.(rw)		*/
	/* ・外部access時は他のaccessとtimingが異なる為,waitexmをpcwaitfに入れ込めない.					*/
	/*   pcwaitf_lとした時にaccessがmaskされてしまう為.								*/
	/* ・EXMEM,RAMfetch時,intackのtimingで~ramfch&cpurd(真のreadではない)の状態が起こる. RAM時は			*/
	/*   pcwaitf_lでmaskされるが,EXMEM時はwaitexmでmaskしているのでこの偽のcpurdがrejectできない為,			*/
	/*   ~intackをrdの条件に入れる.(read)										*/
	/* →[V1.33] ~intackにより,多くのCaseで割り込み直前のAccessがTraceされない問題が起きていた.EXMEM Fetchでは	*/
	/*   Accessを発生させる命令のStageでAccessも行われる為,次の割込みによるPrefetch時の(6)のmaskにintackを使用	*/
	/*   して問題ないが,Flash Fetch時などはPreFetchのStageでintack↑のTimingと同時にAccessが行われる為,Accessが	*/
	/*   Maskされてしまう. ~intack -> ~((selexmpc | selrampc) & intack)と変更.					*/
	/* ・stageadr,pcwaitfなどは本来不要かもしれないが,安全の為他ブロックに合わせる.					*/
	/* ・cpumskはcs,es,psw,sp(汎用register)のtraceを抑制する信号なのでここでは使う必要なし.				*/
	/* ・CPUがNPB-Retry対応の為にV2で修正されている。これに合せてocdwaitを使用する修正を行った。TimingはSystem仕様	*/
	/*   書に記載した。Flashフェッチの場合とRAMフェッチの場合でocdwaitとpcwaitfの動きが違うので注意が必要。外部に	*/
	/*   ついては現状CPUが非対応で、NPBあり＋外部ありの製品が出て来た場合には検討が必要。				*/
	/* ------------------------------------------------------------------------------------------------------------	*/
	/* [V1.47]													*/
	/* pcwaitfとintackが同時に立った場合はpcwaitf期間分intack_l1を遅らせる.						*/
	/* 		 _|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_							*/
	/* pcwaitf	 _____________|~~~|___________|~~~~~~~|___							*/
	/* intack	 _|~~~|_______|~~~|___________|~~~|///|___							*/
	/* intack_wait   _________________|~~~|___________|~~~~~~~|___							*/
	/* intack_l1pre1 _|~~~|_______|~~~~~~~|_______|~~~~~~~~~~~|___							*/
	/* intack_l1pre2 _____|~~~|_______|~~~~~~~|_______|~~~~~~~~~~~|___						*/
	/* intack_l1	 _____|~~~|___________|~~~|_______________|~~~|___						*/
	/* ------------------------------------------------------------------------------------------------------------	*/
	reg intack_wait;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			intack_wait <= 1'b0;
		else if (pcwaitf) begin
			if (intack)
				intack_wait <= 1'b1;
			else	intack_wait <= intack_wait;
		end
		else	intack_wait <= 1'b0;
	end
	wire	intack_l1pre1 = intack | intack_wait;
	
	reg intack_l1pre2;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			intack_l1pre2 <= 1'b0;
		else	intack_l1pre2 <= intack_l1pre1;
	end
	wire	intack_l1 = ~intack_l1pre1 & intack_l1pre2;
	
	reg intack_l2;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			intack_l2 <= 1'b0;
		else	intack_l2 <= intack_l1;
	end


	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) begin dmaack_l1 <= 1'b0; dmaack_l2 <= 1'b0; end
		else begin
			dmaack_l1 <= dmaack;
			dmaack_l2 <= dmaack_l1;
		end
	end
	assign	dma = ~dmaack & (dmaack_l1 | dmaack_l2);
	
// [V1.45(1)]
	reg pcwaitf_lf;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			pcwaitf_lf <= 1'b0;
		else if (!ocdwait)
			pcwaitf_lf <= 1'b0;
		else if (!pcwaitf_l && ocdwait && ~waitexm)
			pcwaitf_lf <= 1'b1;
	end
	wire	pcwaitf_lw = pcwaitf_lf & ~ocdwait;
	
	// [V1.48]
	// RAM,EXMEMからFlashにPCが遷移後の1clock(WAITEXM Act時は+Wait)を検出(mask_branch)
	// し,cpurdをMaskすることで不正なReadを検出しない構成とした。
	// [V1.51]
	// BRAM(selbrampc),BFA(selbfapc)を条件に追加.
	reg selxxxpc_wait;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)   selxxxpc_wait <= 1'b0;
		else if (waitexm) selxxxpc_wait <= selxxxpc_wait;
		else              selxxxpc_wait <= (sel_exmem_pc_all | sel_ram_pc_all | sel_bram_pc);
	end
	wire mask_branch = selxxxpc_wait & (sel_rom_pc_all | sel_bfa_pc);
	
	assign	fch	= ~stageadr[1] & ~stageadr[0] & ~pcwaitf & ~waitexm & ~ocdwait & ~skipexe & ~dma & ~intack & ~intack_wait | intack_l2;
	assign	rd	= cpurd & (~pcwaitf_l & ~waitexm & ~ocdwait & ~fchram & 
				   ~((sel_exmem_pc_all | sel_ram_pc_all) & intack) & ~mask_branch | dma | pcwaitf_lw);
	assign	wr	= cpuwr & (~pcwaitf_l & ~waitexm & ~ocdwait & ~fchram | dma | pcwaitf_lw);

//		
// 空間判別信号	
//		
	/* ----------------------------------------------------------------------------------------------------	*/
	/* ・外部に対するMirrorAccessについて									*/
	/* 　-> MirrorAccessはpidBus行われ,外部はMemoryBusを使用するので,外部がmirrorとして見えることは無い.	*/
	/*   　 ROM64K以下,外部ありの製品でmaa=1の設定はcpuとして禁止（06.01.16EvaCore設計者に確認)		*/
	/*    　failsafeとしてはmirrorへのwriteを一意にwprotectの対象にする.					*/
	/* ・exmaについて											*/
	/*   -> exmaは本来[外部memory空間用address上位4bit]だが,DMA転送時以外のAccessAddress上位4bitとして使用	*/
	/*      してOK(06.02.21 evacore担当に確認).DMA時は上位4bitに外部のaddressが残る場合があるのでfh固定.	*/
	/* ----------------------------------------------------------------------------------------------------	*/
	assign	maup		= dma ? 4'hf : exma;
	assign	sel_exxxxh_pc	= (pc[19:16] == 4'he) ? 1'b1:1'b0;
	assign	sel_exxxxh_ma	= (maup      == 4'he) ? 1'b1:1'b0;
	assign	sel_fxxxxh_pc	= (pc[19:16] == 4'hf) ? 1'b1:1'b0;
	assign	sel_ffxxxh_pc	= (sel_fxxxxh_pc && (pc[15:12] == 4'hf)) ? 1'b1:1'b0;
	assign	sel_fxxxxh_ma	= (maup      == 4'hf) ? 1'b1:1'b0; /* dma時はexmaによらずactive */
	assign	sel_ffxxxh_ma	= (sel_fxxxxh_ma && (flma[15:12] == 4'hf)) ? 1'b1:1'b0;
	assign	sel_sfr_pc	= (sel_ffxxxh_pc && (  pc[11:8] == 4'hf)) ? 1'b1:1'b0;
	assign	sel_sfr_ma	= (sel_ffxxxh_ma && (flma[11:8] == 4'hf)) ? 1'b1:1'b0;
	assign	sel_generalreg_pc = (sel_ffxxxh_pc && (  pc[11:8] == 4'he) && (  pc[7:4] >= 4'he)) ? 1'b1:1'b0;
	assign	sel_generalreg_ma = (sel_ffxxxh_ma && (flma[11:8] == 4'he) && (flma[7:4] >= 4'he)) ? 1'b1:1'b0;
	assign	sel_ram_pc_all	= (sel_fxxxxh_pc && ~sel_sfr_pc && ~sel_generalreg_pc && (  pc[15:8] >= ramsize) && ~sel_bram_pc) ? 1'b1:1'b0; /* nonmapを含む */
	assign	sel_ram_ma_all	= (sel_fxxxxh_ma && ~sel_sfr_ma && ~sel_generalreg_ma && (flma[15:8] >= ramsize) && ~sel_bram_ma) ? 1'b1:1'b0; /* nonmapを含む */
	assign	sel_ram_pc	= (sel_ram_pc_all && ~sel_nonmap_ram_pc) ? 1'b1:1'b0; /* nonmapを除く */
	assign	sel_ram_ma	= (sel_ram_ma_all && ~sel_nonmap_ram_ma) ? 1'b1:1'b0; /* nonmapを除く */
	// [V1.50]
	// mirrorからdflash領域を除外
	assign	sel_mirror_pc_all = (sel_fxxxxh_pc && (ramsize >   pc[15:8]) && ~sel_bram_pc && ~sel_2ndsfr_pc && ~sel_dfad_pc) ? 1'b1:1'b0; /* nonmapを含む */
	assign	sel_mirror_ma_all = (sel_fxxxxh_ma && (ramsize > flma[15:8]) && ~sel_bram_ma && ~sel_2ndsfr_ma && ~sel_dfad_ma) ? 1'b1:1'b0; /* nonmapを含む */
//	assign	sel_mirror_pc	= (sel_mirror_pc_all && ~sel_nonmap_rom_pc) ? 1'b1:1'b0; /* nonmapを除く */
	assign	sel_mirror_pc	= sel_mirror_pc_all; /* sel_nonmap_rom_pcはsel_mirror_pc_allと排他. */
	assign	sel_mirror_ma	= (sel_mirror_ma_all && ~sel_nonmap_rom_ma) ? 1'b1:1'b0; /* nonmapを除く */
	assign	sel_bram_pc	= (sel_fxxxxh_pc && ({3'h0, bmsize[3:0], 1'b0} >   pc[15:8]) && ~sel_2ndsfr_pc) ? 1'b1:1'b0;
	assign	sel_bram_ma	= (sel_fxxxxh_ma && ({3'h0, bmsize[3:0], 1'b0} > flma[15:8]) && ~sel_2ndsfr_ma) ? 1'b1:1'b0;
	assign	sel_2ndsfr_pc	= (sel_fxxxxh_pc && (  pc[15:11] == 5'h0)) ? 1'b1:1'b0;
	assign	sel_2ndsfr_ma	= (sel_fxxxxh_ma && (flma[15:11] == 5'h0)) ? 1'b1:1'b0;
	assign	sel_bfa_pc	= (sel_exxxxh_pc && (  pc[15:8] >= {2'b11, bfsize[3:0], 2'b00})) ? 1'b1:1'b0;
	assign	sel_bfa_ma	= (sel_exxxxh_ma && (flma[15:8] >= {2'b11, bfsize[3:0], 2'b00})) ? 1'b1:1'b0;
	assign	sel_exmem_pc_all = ((pc[19:16] > flsize) && ~sel_fxxxxh_pc && ~sel_bfa_pc) ? 1'b1:1'b0; /* nonmapを含む */
	assign	sel_exmem_ma_all = ((maup      > flsize) && ~sel_fxxxxh_ma && ~sel_bfa_ma) ? 1'b1:1'b0; /* nonmapを含む */
//	assign	sel_exmem_pc	= (sel_exmem_pc_all && (sel_exad0_pc || sel_exad1_pc || sel_exad2_pc || sel_exad3_pc || sel_dfad_pc)) ? 1'b1:1'b0; /* nonmapを除く */
//	assign	sel_exmem_ma_wprtct = (sel_exmem_ma_all && (sel_exad0_ma_wprtct || sel_exad1_ma_wprtct || sel_exad2_ma_wprtct || sel_exad3_ma_wprtct || sel_dfad_ma_wprtct)) ? 1'b1:1'b0; /* nonmapを除く */
	assign	sel_rom_pc_all	= ((flsize >= pc[19:16]) && ~sel_bfa_pc) ? 1'b1:1'b0; /* nonmapを含む */
	assign	sel_rom_ma_all	= ((flsize >= maup     ) && ~sel_bfa_ma) ? 1'b1:1'b0; /* nonmapを含む */
	assign	sel_rom_pc	= (sel_rom_pc_all && ~sel_nonmap_rom_pc) ? 1'b1:1'b0; /* nonmapを除く */
	assign	sel_rom_ma	= (sel_rom_ma_all && ~sel_nonmap_rom_ma) ? 1'b1:1'b0; /* nonmapを除く */

	/* rom nonmap area */
	assign	rom_nogap = (flsizeice[5:0] == 6'b0) ? 1'b1:1'b0; /* 64k(隙間なし) */
	assign	boundary_rom_pc = (pc[19:16] == flsize) ? 1'b1:1'b0;
	assign	rom_gap_pc = ((pc[15:10] >= flsizeice[5:0]) && ~rom_nogap) ? 1'b1:1'b0;
	assign	sel_nonmap_rom_pc = boundary_rom_pc & rom_gap_pc;

	assign	boundary_rom_ma = (maup == flsize) ? 1'b1:1'b0;	/* flsize=fhはない */
	assign	boundary_mirror_ma = (sel_mirror_ma_all && (maa == flsize[0]) && (flsize[3:1]==3'h0)) ? 1'b1:1'b0;
					/* mirrorに0xxxxh空間が見え,ROM境界が0xxxxh空間.または,	*/
					/* mirrorに1xxxxh空間が見え,ROM境界が1xxxxh空間.	*/
	assign	rom_gap_ma = ((flma[15:10] >= flsizeice[5:0]) && ~rom_nogap) ? 1'b1:1'b0;
	assign	sel_nonmap_rom_ma = (boundary_rom_ma | boundary_mirror_ma) & rom_gap_ma;

	/* mirror nonmap area */
	/* [V1.43] flash<=64kBでmaa==1時にmirrorにr/wアクセスした場合はnonmapとして扱う. */
	assign	sel_nonmap_mirror_maa = ((sel_mirror_ma_all == 1'b1) && (maa == 1'b1) && (flsize == 4'h0)) ? 1'b1:1'b0;

	/* ram nonmap area */
	assign	sel_nonmap_ram_pc = (sel_fxxxxh_pc && (  pc[15:8] == ramsize) && ramsizeice[0] && ~pc[7]) ? 1'b1:1'b0;
	assign	sel_nonmap_ram_ma = (sel_fxxxxh_ma && (flma[15:8] == ramsize) && ramsizeice[0] && ~flma[7]) ? 1'b1:1'b0;

	/* exmem and data-flash nonmap area */
	assign	sel_exad0_pc	= ((exadh0 >= pc) && (pc >= exadl0)) ? 1'b1:1'b0;
	assign	sel_exad1_pc	= ((exadh1 >= pc) && (pc >= exadl1)) ? 1'b1:1'b0;
	assign	sel_exad2_pc	= ((exadh2 >= pc) && (pc >= exadl2)) ? 1'b1:1'b0;
	assign	sel_exad3_pc	= ((exadh3 >= pc) && (pc >= exadl3)) ? 1'b1:1'b0;
	
	assign	sel_exad0_ma_nonmap	= ((exadh0 >= {maup,flma[15:1],(flma[0] | wdop)}) && ({maup,flma} >= exadl0)) ? 1'b1:1'b0;
	assign	sel_exad1_ma_nonmap	= ((exadh1 >= {maup,flma[15:1],(flma[0] | wdop)}) && ({maup,flma} >= exadl1)) ? 1'b1:1'b0;
	assign	sel_exad2_ma_nonmap	= ((exadh2 >= {maup,flma[15:1],(flma[0] | wdop)}) && ({maup,flma} >= exadl2)) ? 1'b1:1'b0;
	assign	sel_exad3_ma_nonmap	= ((exadh3 >= {maup,flma[15:1],(flma[0] | wdop)}) && ({maup,flma} >= exadl3)) ? 1'b1:1'b0;
	
	/* --------------------------------------------	*/
	/* fetch protect, sel_nonmap_exmem_pcに使用.	*/
	/* --------------------------------------------	*/
	assign	sel_dfad_pc = ((dfadh >= pc) && (pc >= dfadl)) ? 1'b1:1'b0;

	/* --------------------------------------------------------------------------------------------	*/
	/* [V1.50]											*/
	/* sel_dfad_maを追加. sel_mirror_ma_allに使用.SS3rdではdflashはmirror空間に配置されるため,	*/
	/* mirrorからdflashを削除. 但し,この処置をしなくても問題はなさそう. mirror書込みはOK,mirror	*/
	/* フェッチはNGだがデータフラッシュもNGで共にfetch protect, mirrorリードはOKなので,dflashが	*/
	/* sel_mirror_ma_allから除外されていなくても悪さはしなさそう.					*/
	/* --------------------------------------------------------------------------------------------	*/
	assign	sel_dfad_ma = ((dfadh >= {maup,flma}) && ({maup,flma} >= dfadl)) ? 1'b1:1'b0;

	/* --------------------------------------------------------------------------------------------	*/
	/* sel_nonmap_exmem_maにのみ使用. sel_nonmap_exmem_maはexmemのnonmap空間であることを示す信号で,	*/
	/* sel_dfad_ma_nonmapが偽だとsel_nonmap_exmem_maが真となる。dfadhの設定値と同じアドレスに対して	*/
	/* wdopをした場合、dfadhを越えるので,その場合にsel_nonmap_exmem_maを真とする為に		*/
	/* sel_dfad_ma_nonmapを偽にする必要があり,上限の条件にwdopを入れている。			*/
	/* --------------------------------------------------------------------------------------------	*/
	assign	sel_dfad_ma_nonmap = ((dfadh >= {maup,flma[15:1],(flma[0] | wdop)} ) && ({maup,flma} >= dfadl)) ? 1'b1:1'b0;
	
	/* --------------------------------------------------------------------------------------------	*/
	/* Highだったらnonmap.										*/
	/* ss3rd対応につきData Flashの範囲がexmemまたはmirrorとなったが,それに伴う変更は不要.SS3rdでは	*/
	/* Data Flashはmirror領域に置かれ,Data Flash範囲を越えてもnonmapとはならない.			*/
	/* --------------------------------------------------------------------------------------------	*/
	assign	sel_nonmap_exmem_pc = sel_exmem_pc_all & ~sel_exad0_pc & ~sel_exad1_pc & ~sel_exad2_pc & ~sel_exad3_pc & ~sel_dfad_pc;
	assign	sel_nonmap_exmem_ma = sel_exmem_ma_all & ~sel_exad0_ma_nonmap & ~sel_exad1_ma_nonmap & ~sel_exad2_ma_nonmap & ~sel_exad3_ma_nonmap & ~sel_dfad_ma_nonmap;

	/* write protect area */
	assign	sel_exad0_ma_wprtct	= ((exadh0 >= {maup,flma}) && ({maup,flma[15:1],(flma[0] | wdop)} >= exadl0)) ? 1'b1:1'b0;
	assign	sel_exad1_ma_wprtct	= ((exadh1 >= {maup,flma}) && ({maup,flma[15:1],(flma[0] | wdop)} >= exadl1)) ? 1'b1:1'b0;
	assign	sel_exad2_ma_wprtct	= ((exadh2 >= {maup,flma}) && ({maup,flma[15:1],(flma[0] | wdop)} >= exadl2)) ? 1'b1:1'b0;
	assign	sel_exad3_ma_wprtct	= ((exadh3 >= {maup,flma}) && ({maup,flma[15:1],(flma[0] | wdop)} >= exadl3)) ? 1'b1:1'b0;

	/* --------------------------------------------------------------------------------------------	*/
	/* write protectに使用. この信号がactiveでdfatt0=0の時にwrite protectとする. dfadlの一つ下のア	*/
	/* ドレスにwdopでwriteした場合はWord Dataの上位がData Flashの範囲に入るのでwrite protectとする.	*/
	/* --------------------------------------------------------------------------------------------	*/
	assign	sel_dfad_ma_wprtct	= ((dfadh >= {maup,flma} ) && ({maup,flma[15:1],(flma[0] | wdop)} >= dfadl)) ? 1'b1:1'b0;
	assign	sel_dfad_ma_wdrdprtct	= sel_dfad_ma_wprtct;
	
endmodule



// ======================================================================================================
// Select internal or external for EXMEM (Pending)							=
// ======================================================================================================
module	exmap	(
		exma, flma, exadh0, exadh1, exadh2, exadh3, exadl0, exadl1, exadl2,
		exadl3, exmap0, exmap1, exmap2, exmap3, exmapout
	);

input [3:0]	exma;
input [15:0]	flma;
input [19:0]	exadh0, exadh1, exadh2, exadh3, exadl0, exadl1, exadl2, exadl3;
input		exmap0, exmap1, exmap2, exmap3;
output		exmapout;

wire	sel_exad0_mapout, sel_exad1_mapout, sel_exad2_mapout, sel_exad3_mapout;


	assign	sel_exad0_mapout = ((exadh0 >= {exma,flma}) && ({exma,flma} >= exadl0)) ? 1'b1:1'b0;
	assign	sel_exad1_mapout = ((exadh1 >= {exma,flma}) && ({exma,flma} >= exadl1)) ? 1'b1:1'b0;
	assign	sel_exad2_mapout = ((exadh2 >= {exma,flma}) && ({exma,flma} >= exadl2)) ? 1'b1:1'b0;
	assign	sel_exad3_mapout = ((exadh3 >= {exma,flma}) && ({exma,flma} >= exadl3)) ? 1'b1:1'b0;

	assign	exmapout = (exmap0 & sel_exad0_mapout) | (exmap1 & sel_exad1_mapout) |
			   (exmap2 & sel_exad2_mapout) | (exmap3 & sel_exad3_mapout);

endmodule



// ======================================================================================================
// Register												=
// ======================================================================================================
module	failsafe_register (
		icewr, sysrsoutb, size_cs, exadh_cs, exadl_cs, ustadr_cs, failmk_cs, bsize_cs,
		ovlapemu_cs, dfsize_cs, icedi, ramsize, flsize, ramsizeice, flsizeice, exmap0, exmap1,
		exmap2, exmap3, exatt0, exatt1, exatt2, exatt3, exadh0, exadh1, exadh2, exadh3, exadl0,
		exadl1, exadl2, exadl3, ustadrh, ustadrl, failmk, bfsize, bmsize, ovlapemu, dfsize,
		register_ro, dfadh_cs, dfadl_cs, dfatt0, dfatt1, dfadh, dfadl
	);

input		icewr, sysrsoutb, size_cs;
input [3:0]	exadh_cs, exadl_cs;
input		dfadh_cs, dfadl_cs;
input		ustadr_cs, failmk_cs, bsize_cs, ovlapemu_cs, dfsize_cs;
input [31:0]	icedi;
output [7:0]	ramsize;
output [3:0]	flsize;
output [8:0]	ramsizeice;
output [9:0]	flsizeice;
output [3:0]	bfsize;
output [3:0]	bmsize;
output		ovlapemu;
output [1:0]	dfsize;
output		exmap0, exmap1, exmap2, exmap3;
output		exatt0, exatt1, exatt2, exatt3;
output [19:0]	exadh0, exadh1, exadh2, exadh3;
output [19:0]	exadl0, exadl1, exadl2, exadl3;
output		dfatt0, dfatt1;
output [19:0]	dfadh;
output [19:0]	dfadl;
output [15:1]	ustadrh, ustadrl;
output [14:0]	failmk;	/* [V1.49] bit14を追加 */
output [31:0]	register_ro;


// -------------------------------------------------------------------------------------------------------
reg [8:0]	ramsizeice;
reg [9:0]	flsizeice;
reg [3:0]	bfsize, bmsize;
reg		ovlapemu;
reg		exmap0, exmap1, exmap2, exmap3;
reg		exatt0, exatt1, exatt2, exatt3;
reg [19:0]	exadh0, exadh1, exadh2, exadh3;
reg [19:0]	exadl0, exadl1, exadl2, exadl3;
reg		dfatt1, dfatt0;
reg [19:0]	dfadh;
reg [19:0]	dfadl;
reg [15:1]	ustadrh, ustadrl;
reg [14:0]	failmk;	/* [V1.49] bit14を追加 */
reg [31:0]	register_ro;


// -------------------------------------------------------------------------------------------------------
	always @(size_cs or exadh_cs or exadl_cs or ustadr_cs or failmk_cs or bsize_cs or ovlapemu_cs or
		dfsize_cs or ramsizeice or flsizeice or exmap0 or exmap1 or exmap2 or exmap3 or exatt0 or
		exatt1 or exatt2 or exatt3 or exadh0 or exadh1 or exadh2 or exadh3 or exadl0 or exadl1 or
		exadl2 or exadl3 or ustadrh or ustadrl or failmk or bmsize or bfsize or ovlapemu or dfsize or
		dfadh_cs or dfadl_cs or dfatt0 or dfatt1 or dfadh or dfadl ) begin

		case ({size_cs, exadh_cs[0], exadh_cs[1], exadh_cs[2], exadh_cs[3], exadl_cs[0],
			exadl_cs[1], exadl_cs[2], exadl_cs[3], ustadr_cs, failmk_cs, bsize_cs, ovlapemu_cs,
			dfsize_cs, dfadh_cs, dfadl_cs})

			16'b1000000000000000: register_ro = {7'b0, ramsizeice, 6'b0, flsizeice};
			16'b0100000000000000: register_ro = {8'b0, exmap0, 2'b0, exatt0, exadh0};
			16'b0010000000000000: register_ro = {8'b0, exmap1, 2'b0, exatt1, exadh1};
			16'b0001000000000000: register_ro = {8'b0, exmap2, 2'b0, exatt2, exadh2};
			16'b0000100000000000: register_ro = {8'b0, exmap3, 2'b0, exatt3, exadh3};
			16'b0000010000000000: register_ro = {12'b0, exadl0};
			16'b0000001000000000: register_ro = {12'b0, exadl1};
			16'b0000000100000000: register_ro = {12'b0, exadl2};
			16'b0000000010000000: register_ro = {12'b0, exadl3};
			16'b0000000001000000: register_ro = {ustadrh, 1'b1, ustadrl, 1'b0};
			16'b0000000000100000: register_ro = {17'b0, failmk};	/* [V1.49] bit14を追加 */
			16'b0000000000010000: register_ro = {12'b0, bmsize, 12'b0, bfsize};
			16'b0000000000001000: register_ro = {31'b0, ovlapemu};
			16'b0000000000000100: register_ro = {30'b0, dfsize};
			16'b0000000000000010: register_ro = {10'b0, dfatt1, dfatt0, dfadh};
			16'b0000000000000001: register_ro = {12'b0, dfadl};
			default            : register_ro = 32'b0;
		endcase
	end

	/* ramsizeice, flsizeice */
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			ramsizeice <= 9'h010;
			flsizeice <= 10'h380;
		end
		else if (size_cs) begin
			ramsizeice <= icedi[24:16];
			flsizeice <= icedi[9:0];
		end
	end
	assign	ramsize	= ramsizeice[8:1];
	assign	flsize	= flsizeice[9:6];

	/* exadh0-3 */
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) begin exmap0 <= 1'b0; exatt0 <= 1'b0; exadh0 <= 20'h0; end
		else if (exadh_cs[0]) begin
			exmap0 <= icedi[23];
			exatt0 <= icedi[20];
			exadh0 <= icedi[19:0];
		end
	end
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) begin exmap1 <= 1'b0; exatt1 <= 1'b0; exadh1 <= 20'h0; end
		else if (exadh_cs[1]) begin
			exmap1 <= icedi[23];
			exatt1 <= icedi[20];
			exadh1 <= icedi[19:0];
		end
	end
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) begin exmap2 <= 1'b0; exatt2 <= 1'b0; exadh2 <= 20'h0; end
		else if (exadh_cs[2]) begin
			exmap2 <= icedi[23];
			exatt2 <= icedi[20];
			exadh2 <= icedi[19:0];
		end
	end
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) begin exmap3 <= 1'b0; exatt3 <= 1'b0; exadh3 <= 20'h0; end
		else if (exadh_cs[3]) begin
			exmap3 <= icedi[23];
			exatt3 <= icedi[20];
			exadh3 <= icedi[19:0];
		end
	end

	/* exadl0-3 */
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)		exadl0 <= 20'h0;
		else if	(exadl_cs[0])	exadl0 <= icedi[19:0];
	end
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)		exadl1 <= 20'h0;
		else if	(exadl_cs[1])	exadl1 <= icedi[19:0];
	end
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)		exadl2 <= 20'h0;
		else if	(exadl_cs[2])	exadl2 <= icedi[19:0];
	end
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)		exadl3 <= 20'h0;
		else if	(exadl_cs[3])	exadl3 <= icedi[19:0];
	end
	
	/* dfadh, dfadl */
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)	begin
			dfatt1 <= 1'b1;		// default ignore (permit)
			dfatt0 <= 1'b1;		// default ignore (permit)
			dfadh <= 20'h0;
		end
		else if (dfadh_cs) begin
			dfatt1 <= icedi[21];	// fetch attribute
			dfatt0 <= icedi[20];	// write attribute
			dfadh <= icedi[19:0];	// dflash upper range
		end
	end
	
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)	
			dfadl <= 20'h0;
		else if (dfadl_cs)
			dfadl <= icedi[19:0];	// dflash lower range
	end
	
	/* ustadrh, ustadrl */
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			ustadrh <= 15'h7f6f;	// fedf -> 7f6f,1'b1
			ustadrl <= 15'h0400;	// 0800 -> 0400,1'b0
		end
		else if (ustadr_cs) begin
			ustadrh <= icedi[31:17];
			ustadrl <= icedi[15:1];
		end
	end

	/* failmk */
	/* --------------------------------------------------------------------	*/
	/* [V1.49]								*/
	/* bit14を追加. bit14(=Data Flash Word Read Protect)はSS3rd用なので,	*/
	/* SS2nd製品で誤動作しないように初期値を1(=Mask)にする			*/
	/* --------------------------------------------------------------------	*/
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)		failmk <= 15'h4000;
		else if (failmk_cs)	failmk <= icedi[14:0];
	end

	/* bfsize, bmsize */
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)	begin
			bmsize <= 4'h8;	/* initial f0800h-f0fffh (2KByte) */
			bfsize <= 4'h8;	/* initial ee000h-effffh (8KByte) */
		end
		else if (bsize_cs) begin
			bmsize <= icedi[19:16];
			bfsize <= icedi[3:0];
		end
	end

	/* ovlapemu */
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) ovlapemu <= 1'b0;
		else if (ovlapemu_cs) ovlapemu <= icedi[0];
	end

	/* [V1.49] */
	/* dfsize */
	reg [1:0] dfsize;
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) dfsize <= 2'b01;
		else if (dfsize_cs) dfsize <= icedi[1:0];
	end

endmodule



// =====================================================================================================
// cs													
// =====================================================================================================
module	failsafe_cs (
		iceifa, size_cs, exadh_cs, exadl_cs, ustadr_cs, failmk_cs, bsize_cs, ovlapemu_cs,
		dfsize_cs, sfratt_cs, ramini_cs, conv_cs, dfadh_cs, dfadl_cs
	);

	input [31:2]	iceifa;
	output		size_cs;
	output [3:0]	exadh_cs;
	output [3:0]	exadl_cs;
	output		ustadr_cs;
	output		failmk_cs;
	output		bsize_cs;
	output		ovlapemu_cs;
	output		dfsize_cs;
	output		sfratt_cs;
	output		ramini_cs, conv_cs;
	output		dfadh_cs;
	output		dfadl_cs;

	wire	failsafe_cs, sfratt_cs_p;
	wire failsafe_cs2;


	assign	failsafe_cs = (iceifa[31:12] == 20'h0801_2) ? 1'b1:1'b0;
	assign	sfratt_cs_p   = (iceifa[31:12] == 20'h0801_3) ? 1'b1:1'b0;
	assign	failsafe_cs2 = (iceifa[31:12] == 20'h0801_4) ? 1'b1:1'b0;

	assign	size_cs		= (failsafe_cs & (iceifa[11:2] == 10'h000)) ? 1'b1:1'b0;
	assign	exadh_cs[0]	= (failsafe_cs & (iceifa[11:2] == 10'h001)) ? 1'b1:1'b0;
	assign	exadl_cs[0]	= (failsafe_cs & (iceifa[11:2] == 10'h002)) ? 1'b1:1'b0;
	assign	exadh_cs[1]	= (failsafe_cs & (iceifa[11:2] == 10'h003)) ? 1'b1:1'b0;
	assign	exadl_cs[1]	= (failsafe_cs & (iceifa[11:2] == 10'h004)) ? 1'b1:1'b0;
	assign	exadh_cs[2]	= (failsafe_cs & (iceifa[11:2] == 10'h005)) ? 1'b1:1'b0;
	assign	exadl_cs[2]	= (failsafe_cs & (iceifa[11:2] == 10'h006)) ? 1'b1:1'b0;
	assign	exadh_cs[3]	= (failsafe_cs & (iceifa[11:2] == 10'h007)) ? 1'b1:1'b0;
	assign	exadl_cs[3]	= (failsafe_cs & (iceifa[11:2] == 10'h008)) ? 1'b1:1'b0;
	assign	ustadr_cs	= (failsafe_cs & (iceifa[11:2] == 10'h009)) ? 1'b1:1'b0;
	assign	failmk_cs	= (failsafe_cs & (iceifa[11:2] == 10'h00a)) ? 1'b1:1'b0;
	assign	bsize_cs	= (failsafe_cs & (iceifa[11:2] == 10'h00b)) ? 1'b1:1'b0;
	assign	ovlapemu_cs	= (failsafe_cs & (iceifa[11:2] == 10'h00c)) ? 1'b1:1'b0;
	assign	dfsize_cs	= (failsafe_cs & (iceifa[11:2] == 10'h00d)) ? 1'b1:1'b0; // [V1.49]
	assign	sfratt_cs	= (sfratt_cs_p & (iceifa[11:10] == 2'b00)) ? 1'b1:1'b0;
	assign	ramini_cs	= iceifa[28] & ~iceifa[16];
	assign	conv_cs		= iceifa[28] & iceifa[16];
	assign	dfadh_cs	= (failsafe_cs2 & (iceifa[11:2] == 10'h000)) ? 1'b1:1'b0;
	assign	dfadl_cs	= (failsafe_cs2 & (iceifa[11:2] == 10'h001)) ? 1'b1:1'b0;

endmodule


