/********************************************************************************/
/* Date		: 2005/05/31							*/
/* Revision	: 1.00								*/
/* Designer	: T.Tsunoda							*/
/* Note		: 78K0R IECUBE Event Unit					*/
/********************************************************************************/
/* [Upadte Info]								*/
/* Date		: 2008/03/10							*/
/* Revision	: 1.33								*/
/* Designer	: T.Tsunoda							*/
/* Note		: [V1.33]の修正.割込み直前のAccessが正しく検出されていなかった	*/
/*		: のを修正.							*/
/********************************************************************************/
/* [Updata Info]								*/
/* Date		: 2009.1.15							*/
/* Revision	: 1.35								*/
/* Designer	: T.Tsunoda							*/
/* Note		: NPB-Macroが製品に追加されたことに伴う修正。NPB-Macro Accessで	*/
/*		: eventのダブりや取り損ねが生じないようにした。OCDWAIT端子追加。*/
/********************************************************************************/
/* [Updata Info]								*/
/* Date		: 2009.7.14							*/
/* Revision	: 1.36								*/
/* Designer	: T.Tsunoda							*/
/* Note		: SP操作と割込みが競合した場合,PreFetchしたPCがWaitされ(延びる),*/
/*		: PreFetchがEvent検出されてしまう問題を修正。			*/
/*		: 但し,FlashFetch,RAMFetchには対応したが,EXMEMFetchには未対応	*/
/*		: で,後日対応予定。						*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2009.9.18							*/
/* Revision	: 1.37								*/
/* Designer	: T.Tsunoda							*/
/* Note		: RAM->Flash,EXMEM->FlashのBranch(BR命令限定)時,不正にReadアク	*/
/*		: セスを検出する不具合を修正。					*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2010.3.30							*/
/* Revision	: 1.38								*/
/* Designer	: T.Tsunoda							*/
/* Note		: 1.37と同様の修正を,FlashではなくBFAについて処置.Firm評価にお	*/
/*		: いて,BRAM->BFAのbr,RAM->BFAのretで行っていないReadアクセスが	*/
/*		: 検出される問題が報告されたため.1.37のCaseではret時はpcwaitfに	*/
/*		: よりmaskされるので問題ないが,1.37の処置によりret時もmaskされ	*/
/*		: る. BRAM,BFAの場合にはretがpcwaitfによりmaskされないのでここ	*/
/*		: での処置によりmaskされる.これらはSELF中(selfmode信号がActive)	*/
/*		: に起るこので,ユーザ見えには影響しない.Firm,Libraryなどの内部	*/
/*		: 評価用に不便なため対応するが,修正内容に関するTPは作成せず,他	*/
/*		: の機能に影響しないことを既存のTPでdegrade評価するのみとする.	*/
/********************************************************************************/
// $Id: eventv1.v,v 1.38 2010-03-30 11:58:59 tsuno3 Exp $

/* ------------------------------------------------------------------------------------------------------------	*/
/* ・eventは最大で2clockずれて出力される.EventBreak時のslipはこの値にbreak,evacoreでの処理が加算される.		*/
/* ------------------------------------------------------------------------------------------------------------	*/
module	EVENTV1 (
	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
	ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,  ICEIFA3,  ICEIFA2,
	ICEDI19, ICEDI18, ICEDI17, ICEDI16, ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10,
	ICEDI9,  ICEDI8,  ICEDI7,  ICEDI6,  ICEDI5,  ICEDI4,  ICEDI3,  ICEDI2,  ICEDI1,  ICEDI0,
	ICEWR,
	ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
	ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
	ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9,  ICEDO8,
	ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,  ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0,
	PC19, PC18, PC17, PC16, PC15, PC14, PC13, PC12, PC11, PC10,
	PC9,  PC8,  PC7,  PC6,  PC5,  PC4,  PC3,  PC2,  PC1,  PC0,
	MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8,
	MA7,  MA6,  MA5,  MA4,  MA3,  MA2,  MA1, MA0,
	IMDR15, IMDR14, IMDR13, IMDR12, IMDR11, IMDR10, IMDR9, IMDR8,
	IMDR7,  IMDR6,  IMDR5,  IMDR4,  IMDR3,  IMDR2,  IMDR1, IMDR0,
	MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8,
	MDW7,  MDW6,  MDW5,  MDW4,  MDW3,  MDW2,  MDW1, MDW0,
	CPURD, CPUWR, WDOP,
	BASECK,
	SYSRSOUTB, CPURESETB,
	TRCON,
	TRCMD,
	SELFMODEDBG,
	SVMOD,
	SVMODUSER,
	STAGEADR1, STAGEADR0,
	FLREAD,
	FLREADB3, FLREADB2, FLREADB1, FLREADB0,
	EROMPD31, EROMPD30, EROMPD29, EROMPD28, EROMPD27, EROMPD26, EROMPD25, EROMPD24, 
	EROMPD23, EROMPD22, EROMPD21, EROMPD20, EROMPD19, EROMPD18, EROMPD17, EROMPD16, 
	EROMPD15, EROMPD14, EROMPD13, EROMPD12, EROMPD11, EROMPD10, EROMPD9 , EROMPD8 ,
	EROMPD7 , EROMPD6 , EROMPD5 , EROMPD4 , EROMPD3 , EROMPD2 , EROMPD1 , EROMPD0,
	PCWAITF,
	WAITEXM,
	OCDWAIT,
	SKIPEXE,
	FCHRAM,
	CPUMASK,
	INTACK, DMAACK,
	EXMA3, EXMA2, EXMA1, EXMA0,
	SELEXMPC, SELRAMPC, SELROMPC, SELBRAMPC, SELBFAPC,
	BRKEVTL1, BRKEVTL0,
	BRKEVTA7, BRKEVTA6, BRKEVTA5, BRKEVTA4, BRKEVTA3, BRKEVTA2, BRKEVTA1, BRKEVTA0,
	BRKEVTF7, BRKEVTF6, BRKEVTF5, BRKEVTF4, BRKEVTF3, BRKEVTF2, BRKEVTF1, BRKEVTF0,
	EVD21, EVD20, EVD19, EVD18, EVD17, EVD16, EVD15, EVD14, EVD13, EVD12, EVD11,
	EVD10, EVD09, EVD08, EVD07, EVD06, EVD05, EVD04, EVD03, EVD02, EVD01
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
input	ICEDI19, ICEDI18, ICEDI17, ICEDI16,	// Host I/F Write Data Bus		( <- eva_pcifg )
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
input	MA15, MA14, MA13, MA12, MA11,		// Memory Access Address		( <- eva core )	
	MA10, MA9,  MA8,  MA7,  MA6,		//							
	MA5,  MA4,  MA3,  MA2,  MA1, MA0;	//							
input	IMDR15, IMDR14, IMDR13, IMDR12,		// Memory Read Bus			( <- eva core )	
	IMDR11, IMDR10, IMDR9,  IMDR8,		//							
	IMDR7,  IMDR6,  IMDR5,  IMDR4,		//							
	IMDR3,  IMDR2,  IMDR1,  IMDR0;		//							
input	MDW15, MDW14, MDW13, MDW12, MDW11,	// Memory Write Bus			( <- eva core )	
	MDW10, MDW9,  MDW8,  MDW7,  MDW6,	//							
	MDW5,  MDW4,  MDW3,  MDW2,  MDW1, MDW0;	//							
input	CPURD;					// Memory Read Strobe			( <- eva core )	
input	CPUWR;					// Memory Write Strobe			( <- eva core )	
input	WDOP;					// Word Access Status			( <- eva core )	
input	BASECK;					// CPU Base Clock			( <- device pin )
input	SYSRSOUTB;				// System Reset Signal			( <- resetctl )	
input	CPURESETB;				// CPU Reset Signal			( <- resetctl )	
input	TRCON;					// Trace Enable Signal			( <- trace )	
input	TRCMD;					// Trace Condition Signal		( <- trace )	
input	SELFMODEDBG;				// SelfMode Debug Signal		( <- emem )	
input	SVMOD;					// Super Visor Mode signal		( <- eva core )	
input	SVMODUSER;				// User svmod				( <- break )	
input	STAGEADR1, STAGEADR0;			// Internal Counter for Instruction	( <- eva core )	
input	FLREAD;					// ROM Read Status			( <- eva core )	
input	FLREADB3, FLREADB2, FLREADB1, FLREADB0;	// Position status of ROM Read data	( <- eva core )	
input	EROMPD31, EROMPD30, EROMPD29, EROMPD28,	// flash data bus			( <- emem )	
	EROMPD27, EROMPD26, EROMPD25, EROMPD24,	//							
	EROMPD23, EROMPD22, EROMPD21, EROMPD20,	//							
	EROMPD19, EROMPD18, EROMPD17, EROMPD16,	//							
	EROMPD15, EROMPD14, EROMPD13, EROMPD12,	//							
	EROMPD11, EROMPD10, EROMPD9 , EROMPD8 ,	//							
	EROMPD7 , EROMPD6 , EROMPD5 , EROMPD4 ,	//							
	EROMPD3 , EROMPD2 , EROMPD1 , EROMPD0; 	//							
input	PCWAITF;				// PC Wait signal			( <- eva core )	
input	WAITEXM;				// cpuwait by external memory access	( <- eva core )	
input	OCDWAIT;				// Wait by NPB Access Or Retry for K0R	( <- eva core )
input	SKIPEXE;				// SKIP instruction execution flag	( <- eva core )	
input	FCHRAM;					// RAM fetch signal(**sync with PC**)	( <- eva core )	
input	CPUMASK;				// Memory Access Status to CS,ES,PSW,SP	( <- eva core )	
input	INTACK;					// INT acknowledge			( <- 1chip )	
input	DMAACK;					// DMA acknowledge			( <- 1chip )	
input	EXMA3, EXMA2, EXMA1, EXMA0;		// ES Register output signal		( <- eva core )	
input	SELEXMPC;				// PC == External Area			( <- failsafe ) 
input	SELRAMPC;				// PC == RAM Area			( <- failsafe ) 
input	SELROMPC;				// PC == Flash Area			( <- failsafe )
input	SELBRAMPC;				// PC == BRAM Area			( <- failsafe )
input	SELBFAPC;				// PC == BFA Area			( <- failsafe )
output	BRKEVTL1, BRKEVTL0 ;			// Event Link Break Signal		( -> break )	
output	BRKEVTA7, BRKEVTA6, BRKEVTA5,		// Access Break Signal			( -> break )	
	BRKEVTA4, BRKEVTA3, BRKEVTA2,		//							
	BRKEVTA1, BRKEVTA0 ;			//							
output	BRKEVTF7, BRKEVTF6, BRKEVTF5,		// Fetch Break Signal			( -> break )	
	BRKEVTF4, BRKEVTF3, BRKEVTF2,		//							
	BRKEVTF1, BRKEVTF0 ;			//							
output	EVD21 ;					// SNAP3 Event				( -> trace )	
output	EVD20 ;					// SNAP2 Event				( -> trace )	
output	EVD19 ;					// SNAP1 Event				( -> trace )	
output	EVD18 ;					// DMM-4 Event				( -> break )	
output	EVD17 ;					// DMM-3 Event				( -> break )	
output	EVD16 ;					// DMM-2 Event				( -> break )	
output	EVD15 ;					// DMM-1 Event				( -> break )	
output	EVD14 ;					// Timer-2 End Event			( -> timer )	
output	EVD13 ;					// Timer-2 Start Event			( -> timer )	
output	EVD12 ;					// Timer-1 End Event			( -> timer )	
output	EVD11 ;					// Timer-1 Start Event			( -> timer )	
output	EVD10 ;					// Qualify Event			( -> trace )	
output	EVD09 ;					// Section-4 End Event			( -> trace )	
output	EVD08 ;					// Section-4 Start Event		( -> trace )	
output	EVD07 ;					// Section-3 End Event			( -> trace )	
output	EVD06 ;					// Section-3 Start Event		( -> trace )	
output	EVD05 ;					// Section-2 End Event			( -> trace )	
output	EVD04 ;					// Section-2 Start Event		( -> trace )	
output	EVD03 ;					// Section-1 End Event			( -> trace )	
output	EVD02 ;					// Section-1 Start Event		( -> trace )	
output	EVD01 ;					// Delay Event				( -> trace )	

// top
wire [31:2]	iceifa;
wire [19:0]	icedi;
wire [19:0]	pc;
wire [3:0]	exma;
wire [3:0]	flreadb;
wire [31:0]	pid;
wire [15:0]	ma;
wire [15:0]	mdr;
wire [15:0]	mdw;
wire [31:0]	evtclr0_ro;
wire		svmod_strobe, svmod_fch;
wire		dma;
reg		evclr;
reg [1:0]	seqrst;
reg [19:0]	fch_adr;
reg [19:0]	acc_adr;
reg [15:0]	flread_data;
reg [15:0]	acc_bus;
reg		dmaack_l1, dmaack_l2;
reg		fch;
reg		rd;
reg		wr;
reg		word;
reg		svmod_acc, svmod_strobe_l1_fch;
reg		pcwaitf_l, waitexm_l;
reg		flrd_en;

// cs
wire [7:0]	fadr_cs;
wire [7:0]	fpasevt_cs;
wire [7:0]	fevtpasclr_cs;
wire [7:0]	fpascntrd_cs;
wire [7:0]	aadr_cs;
wire [7:0]	adtr_cs;
wire [7:0]	adtmkr_cs;
wire [7:0]	apasevt_cs;
wire [7:0]	aevtpasclr_cs;
wire [7:0]	apascntrd_cs;
wire [9:0]	seqin_cs;
wire [1:0]	seqctc_cs;
wire		evtclr0_cs;
wire [1:0]	seqpasclr_cs;
wire [1:0]	spascntrd_cs;
wire [21:0]	eventr_cs;

// fevent
wire [31:0]	fevent_ro;
wire [7:0]	fpasout;

// aevent
wire [31:0]	aevent_ro;
wire [7:0]	apasout;

// link
wire [31:0]	event_link_ro;
wire [1:0]	spasout;

// integra
wire [31:0]	integra_ro;

// -------------------------------------------------------------------------------------------------------
	assign	iceifa = {ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
			ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2};

	assign	icedi = {ICEDI19, ICEDI18, ICEDI17, ICEDI16, ICEDI15, ICEDI14, ICEDI13, ICEDI12,
			ICEDI11,  ICEDI10, ICEDI9,  ICEDI8,  ICEDI7,  ICEDI6,  ICEDI5,  ICEDI4,
			ICEDI3,   ICEDI2,  ICEDI1,  ICEDI0};

	assign	pc =	{PC19, PC18, PC17, PC16, PC15, PC14, PC13, PC12, PC11, PC10,
			PC9, PC8, PC7, PC6, PC5, PC4, PC3, PC2, PC1, PC0};

	assign	exma =	{EXMA3, EXMA2, EXMA1, EXMA0};

	assign	ma =	{MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8, MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0};

	assign	mdr =	{IMDR15, IMDR14, IMDR13, IMDR12, IMDR11, IMDR10, IMDR9, IMDR8,
			IMDR7,  IMDR6,  IMDR5,  IMDR4,  IMDR3,  IMDR2,  IMDR1, IMDR0};

	assign	mdw =	{MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8,
			MDW7,  MDW6,  MDW5,  MDW4,  MDW3,  MDW2,  MDW1, MDW0};

	assign	flreadb = {FLREADB3, FLREADB2, FLREADB1, FLREADB0};

	assign	pid = {	EROMPD31, EROMPD30, EROMPD29, EROMPD28, EROMPD27, EROMPD26, EROMPD25, EROMPD24, 
			EROMPD23, EROMPD22, EROMPD21, EROMPD20, EROMPD19, EROMPD18, EROMPD17, EROMPD16, 
			EROMPD15, EROMPD14, EROMPD13, EROMPD12, EROMPD11, EROMPD10, EROMPD9 , EROMPD8 ,
			EROMPD7 , EROMPD6 , EROMPD5 , EROMPD4 , EROMPD3 , EROMPD2 , EROMPD1 , EROMPD0 }; 

	assign {ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
		ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
		ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
		ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0}
		= evtclr0_ro | fevent_ro | aevent_ro | event_link_ro | integra_ro;

//			
// EVTCLR0 Register	
//			
	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)	begin evclr <= 1'b0; seqrst <= 2'b0; end
		else if (evtclr0_cs) begin
			evclr  <= icedi[6];
			seqrst <= icedi[1:0];
		end
	end
	assign	evtclr0_ro = evtclr0_cs ? {25'b0, evclr, 4'b0, seqrst} : 32'b0;

//			
// svmod for event	
//			

	/* ------------------------------------------------------------------------------------------------------------	*/
	/* ・一瞬break時,PreFetchに対するeventを検出し,break後最初のfetchに対するeventはmaskする.			*/
	/*   traceでは一瞬break時にPrefetchをtrace,fetchをmaskする為,eventも合わせないとQualifyEvent時に問題がある為.	*/
	/* ・通常break時,PreFetchに対するeventはmaskし,break後最初のfetchに対するeventを検出する.			*/
	/* 051027execに確認済												*/
	/* ------------------------------------------------------------------------------------------------------------	*/

/* svmod_acc */
	always @(posedge BASECK or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB)	svmod_acc <= 1'b0;
		else svmod_acc <= SVMOD;
	end

/* svmod_fch */
	/* -入り口にwait----------------------- */ /* -出口にwait---------------------- */
	/*  baseck    |~|_|~|_|~|_|~|_|~|_|~|_  */ /* baseck    |~|_|~|_|~|_|~|_|~|_|~| */
	/*  pc            x===========x         */ /* pc        x===========x           */
	/*  svmod     |_______|~~~~~~~~~~~      */ /* svmod     ~~~~~~~~|______________ */
	/*  stage_adr ======0=====x=1=x=2=x=3=  */ /* stage_adr                         */
	/*  fch_adr           x===========x     */ /* fch_adr       x===========x       */
	/*  pcwaitf   ____|~~~|_________        */ /* pcwaitf   |~~~~~~~|______________ */
	/*  pcwaitf_l ~~~~|___|~~~|______       */ /* pcwaitf_l ____|~~~~~~~|__________ */
	/*  svmod_fch ~~~~~~~~|_______|~~~~~~~~	*/ /* svmod_fch ~~~~~~~~~~~~~~~~|______ */
	/*  fch             ______|~~~|_____    */ /* fch       ____________|~~~|______ */
	/*  event              _______|~~~|_    */ /* event     _______________________ */
	/* ------------------------------------ */ /* --------------------------------- */
	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)	pcwaitf_l <= 1'b0;
		else		pcwaitf_l <= PCWAITF;
	end

	always @(posedge BASECK or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB) waitexm_l <= 1'b0;
		else waitexm_l <= WAITEXM;
	end

	assign	svmod_strobe = SVMOD & ~SVMODUSER;
	always @(posedge BASECK or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB)	svmod_strobe_l1_fch <= 1'b0;
				/* 入口にwait時はmaskをwaitさせる(入り口は生かす) */		/* 出口にwait時はmaskをwaitさせる(出口はmask) */
		else if ((svmod_strobe & (pcwaitf_l | waitexm_l) & ~svmod_strobe_l1_fch) | (~svmod_strobe & (pcwaitf_l | waitexm_l) & svmod_strobe_l1_fch))
				svmod_strobe_l1_fch <= svmod_strobe_l1_fch;
		else		svmod_strobe_l1_fch <= svmod_strobe;
	end
	assign	svmod_fch = SVMODUSER | svmod_strobe_l1_fch; /* SVMODUSER -> UserBreakでは入り口も出口もmask */

//			
// fetch, access bus	
//			

	always @( posedge BASECK or negedge CPURESETB ) begin
		if (!CPURESETB) fch_adr <= 20'b0;
		else		fch_adr <= pc;
	end

	always @( posedge BASECK or negedge CPURESETB ) begin
		if (!CPURESETB) acc_adr <= 20'b0;
		else		acc_adr <= dma ? {4'hf,ma} : {exma,ma};
	end

	/* ------------------------------------------------------------------------------------ */
	/* flash Read時はその命令のID-Stageにwaitが入りpa,pidを横取りしてReadする.また,		*/
	/* MEM-Stageでmaにaddress,"mdw"にReadData(aluの出力垂れ流し)が乗る(from evacore担当)	*/
	/* ------------------------------------------------------------------------------------ */
	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)	flrd_en <= 1'b0;
		else if (~PCWAITF & FLREAD)
				flrd_en <= 1'b1;
		else		flrd_en <= 1'b0;
	end
	/* --------------------------------------------------------------------------------------------	*/
	/* flash Read時はその命令のID-Stageにwaitが入りpa,pidを横取りしてReadする.また, MEM-Stageで	*/
	/* maにaddress,"mdw"にReadData(aluの出力垂れ流し)が乗る.->alu出力はaddw,subwなどの命令の場合	*/
	/* Read値でなく演算結果が出力されるので注意.							*/
	/* --------------------------------------------------------------------------------------------	*/
	always @( posedge BASECK or negedge CPURESETB ) begin
		if (!CPURESETB) flread_data <= 16'b0;
		else begin
			case ({FLREAD, flreadb}) // synopsys parallel_case
				5'b1_0001 : flread_data <= {8'b0,       pid[7:0]  };	// for flash read
				5'b1_0010 : flread_data <= {pid[15:8],  8'b0      };	// for flash read
				5'b1_0100 : flread_data <= {8'b0,       pid[23:16]};	// for flash read
				5'b1_1000 : flread_data <= {pid[31:24], 8'b0      };	// for flash read
				5'b1_0011 : flread_data <=  pid[15:0];			// for flash read
				5'b1_1100 : flread_data <=  pid[31:16];			// for flash read
				default : flread_data <= flread_data;	// Dont permit misalignment
			endcase
		end
	end

	always @( posedge BASECK or negedge CPURESETB ) begin
		if (!CPURESETB)	acc_bus <= 16'b0;
		else if (CPURD)	acc_bus <= flrd_en ? flread_data : mdr;
		else if (CPUWR)	acc_bus <= mdw;
	end

//		
// fch,rd,wr	
//		

	/* ----------------------------------------------------	*/ /* -------------------------------------------------	*/
	/* CPUがwaitしたIDStageの次のMEMStageにaccessがある場合	*/ /* stageadrは1clockで処理できない命令の内部counterで	*/
	/* cpurd,cpuwr信号はIDStageから伸びてactiveとなる.	*/ /* fetch信号生成に使用.accessのmaskには使用できない.	*/
	/* pcwaitfActiveの次のclockでcpurd,cpuwrがActiveの場合,	*/ /* baseck	_|~|_|~|_|~|_|~|_|~|_|~|_|~|_		*/
	/* そのcpurd,cpuwrはwaitで伸びた分でtraceとしてはreject	*/ /* pc	=x===x=(*1)==x===x===x===x===		*/
	/* (from eva-core担当)					*/ /* stageadr	====0====x=1=x====0==========		*/
	/*               [   id     ][mem]			*/ /* cpurd	_________|~~~|_______________		*/
	/* baseck	_|~|_|~|_|~|_|~|_|~|_|~|_|~|_		*/ /* cpuwr	_____________|~~~|___________		*/
	/* pcwaitf	_|~~~~~~~|___|~~~|____________		*/ /* *1 ex) xch(read-modify-write)命令 ..		*/
	/* cpurd	_____|~~~~~~~~~~~|____________		*/ /* IDStageを1clock伸ばしread処理を行っている		*/
	/* rd(internal)	_____xxxxxxxx_________________		*/ /*							*/
	/* -------------------------------------------------	*/ /* -------------------------------------------------	*/

	/* ------------------------------------------------------------------------------------------------------------	*/
	/* (1)intの場合,先行fetchのpcがstageadr, pcwaitfでmaskされないので,intackでmaskする(~intack).(fetch)		*/
	/* (2)intの場合,VectorRead時にstageadrが立ちFetchStatusが立たなくなるので別途条件に入れる(intack_l2).(fetch)	*/
	/* (3)dma転送時はpcwaitfが立たない為,別途条件に入れる(fetch)							*/
	/* (4)RAMFetchでのdma転送時はdmaReadがmaskされるので,dma転送はmaskされないよう条件に別途入れる.(rw)		*/
	/* (5)外部access時は他のaccessとtimingが異なる為,waitexmをpcwaitfに入れ込めない.				*/
	/*    pcwaitf_lとした時にaccessがmaskされてしまう為.								*/
	/* (6)EXMEM,RAMfetch時,intackのtimingで~ramfch&cpurd(真のreadではない)の状態が起こる. RAM時は			*/
	/*    pcwaitf_lでmaskされるが,EXMEM時はwaitexmでmaskしているのでこの偽のcpurdがrejectできない為,		*/
	/*    ~intackをmrdの条件に入れる.(read)										*/
	/* →[V1.33] ~intackにより,多くのCaseで割り込み直前のAccessがTraceされない問題が起きていた.EXMEM Fetchでは	*/
	/*   Accessを発生させる命令のStageでAccessも行われる為,次の割込みによるPrefetch時の(6)のmaskにintackを使用	*/
	/*   して問題ないが,Flash Fetch時などはPreFetchのStageでintack↑のTimingと同時にAccessが行われる為,Accessが	*/
	/*   Maskされてしまう. ~intack -> ~((selexmpc | selrampc) & intack)と変更.					*/
	/* (7)CPUがNPB-Retry対応の為にV2で修正されている。これに合せてocdwaitを使用する修正を行った。TimingはSystem仕様	*/
	/*    書に記載した。Flashフェッチの場合とRAMフェッチの場合でocdwaitとpcwaitfの動きが違うので注意が必要。外部に	*/
	/*    ついては現状CPUが非対応で、NPBあり＋外部ありの製品が出て来た場合には検討が必要。				*/
	/* ------------------------------------------------------------------------------------------------------------	*/
	/* [V1.36]													*/
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
	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)
			intack_wait <= 1'b0;
		else if (PCWAITF) begin
			if (INTACK)
				intack_wait <= 1'b1;
			else	intack_wait <= intack_wait;
		end
		else	intack_wait <= 1'b0;
	end
	wire	intack_l1pre1 = INTACK | intack_wait;
	
	reg intack_l1pre2;
	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)
			intack_l1pre2 <= 1'b0;
		else	intack_l1pre2 <= intack_l1pre1;
	end
	wire	intack_l1 = ~intack_l1pre1 & intack_l1pre2;
	
	reg intack_l2;
	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)
			intack_l2 <= 1'b0;
		else	intack_l2 <= intack_l1;
	end

	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB) begin
			dmaack_l1 <= 1'b0;
			dmaack_l2 <= 1'b0;
		end
		else begin
			dmaack_l1 <= DMAACK;
			dmaack_l2 <= dmaack_l1;
		end
	end
	assign	dma = ~DMAACK & (dmaack_l1 | dmaack_l2);
	
	reg pcwaitf_lf;
	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)
			pcwaitf_lf <= 1'b0;
		else if (!OCDWAIT)
			pcwaitf_lf <= 1'b0;
		else if (!pcwaitf_l && OCDWAIT && ~WAITEXM)
			pcwaitf_lf <= 1'b1;
	end
	wire	pcwaitf_lw = pcwaitf_lf & ~OCDWAIT;
	
	// [V1.37]
	// RAM,EXMEMからFlashにPCが遷移後の1clock(WAITEXM Act時は+Wait)を検出(mask_branch)
	// し,cpurdをMaskすることで不正なReadを検出しない構成とした。
	// [V1.38]
	// BRAM(selbrampc),BFA(selbfapc)を条件に追加.
	reg selxxxpc_wait;
	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)   selxxxpc_wait <= 1'b0;
		else if (WAITEXM) selxxxpc_wait <= selxxxpc_wait;
		else              selxxxpc_wait <= (SELEXMPC | SELRAMPC | SELBRAMPC);
	end
	wire mask_branch = selxxxpc_wait & (SELROMPC | SELBFAPC);
	
	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)	begin fch <= 1'b0; rd <= 1'b0; wr <= 1'b0; word <= 1'b0; end
		else begin
			fch <= ~STAGEADR1 & ~STAGEADR0 & ~PCWAITF & ~WAITEXM & ~OCDWAIT & ~SKIPEXE & ~dma & ~INTACK & ~intack_wait | intack_l2;
			rd <= CPURD & (~pcwaitf_l & ~WAITEXM & ~OCDWAIT & ~FCHRAM & ~CPUMASK &
				      ~((SELEXMPC | SELRAMPC) & INTACK) & ~mask_branch | dma | pcwaitf_lw);
			wr <= CPUWR & (~pcwaitf_l & ~WAITEXM & ~OCDWAIT & ~FCHRAM & ~CPUMASK | dma | pcwaitf_lw);
			word <= WDOP;
		end
	end

// -------------------------------------------------------------------------------------------------------
	fevent		fevent (
		.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .cpuresetb(CPURESETB),
		.selfmodedbg(SELFMODEDBG), .fch(fch), .svmod_fch(svmod_fch), .evclr(evclr),
		.icedi(icedi[19:0]), .fadr_cs(fadr_cs), .fpasevt_cs(fpasevt_cs),
		.fevtpasclr_cs(fevtpasclr_cs), .fpascntrd_cs(fpascntrd_cs), .fch_adr(fch_adr),
		.fevent_ro(fevent_ro), .fpasout(fpasout)
		);

	aevent		aevent (
		.baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .cpuresetb(CPURESETB),
		.selfmodedbg(SELFMODEDBG), .word(word), .rd(rd), .wr(wr), .evclr(evclr),
		.svmod_acc(svmod_acc), .aadr_cs(aadr_cs), .adtr_cs(adtr_cs), .adtmkr_cs(adtmkr_cs),
		.apasevt_cs(apasevt_cs), .aevtpasclr_cs(aevtpasclr_cs), .apascntrd_cs(apascntrd_cs),
		.acc_adr(acc_adr), .acc_bus(acc_bus), .icedi(icedi[19:0]), .apasout(apasout),
		.aevent_ro(aevent_ro)
		);

	event_link	event_link (
		.baseck(BASECK), .sysrsoutb(SYSRSOUTB), .cpuresetb(CPURESETB), .icewr(ICEWR),
		.evclr(evclr), .seqrst(seqrst), .seqin_cs(seqin_cs), .seqctc_cs(seqctc_cs),
		.seqpasclr_cs(seqpasclr_cs), .spascntrd_cs(spascntrd_cs), .detect_out({apasout, fpasout}),
		.icedi(icedi[15:0]), .spasout(spasout), .event_link_ro(event_link_ro)
		);

	integra		integra (
		.icewr(ICEWR), .baseck(BASECK), .sysrsoutb(SYSRSOUTB), .cpuresetb(CPURESETB),
		.trcon(TRCON), .trcmd(TRCMD), .svmod(SVMOD), .eventr_cs(eventr_cs), .icedi(icedi[17:0]),
		.fpasout(fpasout), .apasout(apasout), .spasout(spasout), .brkevtl1(BRKEVTL1),
		.brkevtl0(BRKEVTL0), .brkevta7(BRKEVTA7), .brkevta6(BRKEVTA6), .brkevta5(BRKEVTA5),
		.brkevta4(BRKEVTA4), .brkevta3(BRKEVTA3), .brkevta2(BRKEVTA2), .brkevta1(BRKEVTA1),
		.brkevta0(BRKEVTA0), .brkevtf7(BRKEVTF7), .brkevtf6(BRKEVTF6), .brkevtf5(BRKEVTF5),
		.brkevtf4(BRKEVTF4), .brkevtf3(BRKEVTF3), .brkevtf2(BRKEVTF2), .brkevtf1(BRKEVTF1),
		.brkevtf0(BRKEVTF0),
		.evd({EVD21, EVD20, EVD19, EVD18, EVD17, EVD16, EVD15, EVD14, EVD13, EVD12, EVD11,
		      EVD10, EVD09, EVD08, EVD07, EVD06, EVD05, EVD04, EVD03, EVD02, EVD01}),
		.integra_ro(integra_ro)
		);

	event_cs	event_cs (
		.iceifa(iceifa), .fadr_cs(fadr_cs), .fpasevt_cs(fpasevt_cs),
		.fevtpasclr_cs(fevtpasclr_cs), .fpascntrd_cs(fpascntrd_cs), .aadr_cs(aadr_cs),
		.adtr_cs(adtr_cs), .adtmkr_cs(adtmkr_cs), .apasevt_cs(apasevt_cs),
		.aevtpasclr_cs(aevtpasclr_cs), .apascntrd_cs(apascntrd_cs),
		.seqin_cs(seqin_cs), .seqctc_cs(seqctc_cs), .evtclr0_cs(evtclr0_cs),
		.seqpasclr_cs(seqpasclr_cs), .spascntrd_cs(spascntrd_cs), .eventr_cs(eventr_cs)
		);

endmodule

// ======================================================================================================
// fetch event												=
// ======================================================================================================
module	fevent (
		baseck, icewr, sysrsoutb, cpuresetb, selfmodedbg, fch, svmod_fch, evclr, icedi,
		fadr_cs, fpasevt_cs, fevtpasclr_cs, fpascntrd_cs, fch_adr, fevent_ro, fpasout
	);

	input		icewr, baseck, sysrsoutb, cpuresetb, selfmodedbg, fch, svmod_fch, evclr;
	input [19:0]	icedi;
	input [7:0]	fadr_cs, fpasevt_cs, fevtpasclr_cs, fpascntrd_cs;
	input [19:0]	fch_adr;
	output [31:0]	fevent_ro;
	output [7:0]	fpasout;

	wire [7:0]	fa_meet, fa_over, fa_under;
	wire[31:0]	fdetect_ro0, fdetect_ro1, fdetect_ro2, fdetect_ro3,
			fdetect_ro4, fdetect_ro5, fdetect_ro6, fdetect_ro7;
	wire[31:0]	fpas_ro0, fpas_ro1, fpas_ro2, fpas_ro3,
			fpas_ro4, fpas_ro5, fpas_ro6, fpas_ro7;


	assign	fevent_ro = fdetect_ro0 | fdetect_ro1 | fdetect_ro2 | fdetect_ro3 |
			    fdetect_ro4 | fdetect_ro5 | fdetect_ro6 | fdetect_ro7 |
			    fpas_ro0 | fpas_ro1 | fpas_ro2 | fpas_ro3 |
			    fpas_ro4 | fpas_ro5 | fpas_ro6 | fpas_ro7;

	// --------
	// detector
	// --------
	fdetect		fdetect0 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .fadr_cs(fadr_cs[0]),
				.icedi(icedi), .fch_adr(fch_adr), .fa_meet(fa_meet[0]), .fa_over(fa_over[0]),
				.fa_under(fa_under[0]), .fdetect_ro(fdetect_ro0)
			) ;
	fdetect		fdetect1 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .fadr_cs(fadr_cs[1]),
				.icedi(icedi), .fch_adr(fch_adr), .fa_meet(fa_meet[1]), .fa_over(fa_over[1]),
				.fa_under(fa_under[1]), .fdetect_ro(fdetect_ro1)
			) ;
	fdetect		fdetect2 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .fadr_cs(fadr_cs[2]),
				.icedi(icedi), .fch_adr(fch_adr), .fa_meet(fa_meet[2]), .fa_over(fa_over[2]),
				.fa_under(fa_under[2]), .fdetect_ro(fdetect_ro2)
			) ;
	fdetect		fdetect3 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .fadr_cs(fadr_cs[3]),
				.icedi(icedi), .fch_adr(fch_adr), .fa_meet(fa_meet[3]), .fa_over(fa_over[3]),
				.fa_under(fa_under[3]), .fdetect_ro(fdetect_ro3)
			) ;
	fdetect		fdetect4 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .fadr_cs(fadr_cs[4]),
				.icedi(icedi), .fch_adr(fch_adr), .fa_meet(fa_meet[4]), .fa_over(fa_over[4]),
				.fa_under(fa_under[4]), .fdetect_ro(fdetect_ro4)
			) ;
	fdetect		fdetect5 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .fadr_cs(fadr_cs[5]),
				.icedi(icedi), .fch_adr(fch_adr), .fa_meet(fa_meet[5]), .fa_over(fa_over[5]),
				.fa_under(fa_under[5]), .fdetect_ro(fdetect_ro5)
			) ;
	fdetect		fdetect6 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .fadr_cs(fadr_cs[6]),
				.icedi(icedi), .fch_adr(fch_adr), .fa_meet(fa_meet[6]), .fa_over(fa_over[6]),
				.fa_under(fa_under[6]), .fdetect_ro(fdetect_ro6)
			) ;
	fdetect		fdetect7 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .fadr_cs(fadr_cs[7]),
				.icedi(icedi), .fch_adr(fch_adr), .fa_meet(fa_meet[7]), .fa_over(fa_over[7]),
				.fa_under(fa_under[7]), .fdetect_ro(fdetect_ro7)
			) ;

	// -------------
	// selector, PAS
	// -------------
	fpas		fpas0 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.selfmodedbg(selfmodedbg), .fch(fch), .svmod_fch(svmod_fch),
				.fpasevt_cs(fpasevt_cs[0]), .fevtpasclr_cs(fevtpasclr_cs[0]),
				.fpascntrd_cs(fpascntrd_cs[0]), .evclr(evclr), .icewr(icewr),
				.icedi15_8(icedi[15:8]), .icedi2_0(icedi[2:0]), .fa_meet(fa_meet[0]),
				.fa_over(fa_over[0]), .fa_under(fa_under[0]), .fa_over2(fa_over[1]),
				.fpasout(fpasout[0]), .fpas_ro(fpas_ro0)
			);
	fpas		fpas1 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.selfmodedbg(selfmodedbg), .fch(fch), .svmod_fch(svmod_fch),
				.fpasevt_cs(fpasevt_cs[1]), .fevtpasclr_cs(fevtpasclr_cs[1]),
				.fpascntrd_cs(fpascntrd_cs[1]), .evclr(evclr), .icewr(icewr),
				.icedi15_8(icedi[15:8]), .icedi2_0(icedi[2:0]), .fa_meet(fa_meet[1]),
				.fa_over(fa_over[1]), .fa_under(fa_under[1]), .fa_over2(fa_over[2]),
				.fpasout(fpasout[1]), .fpas_ro(fpas_ro1)
			);
	fpas		fpas2 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.selfmodedbg(selfmodedbg), .fch(fch), .svmod_fch(svmod_fch),
				.fpasevt_cs(fpasevt_cs[2]), .fevtpasclr_cs(fevtpasclr_cs[2]),
				.fpascntrd_cs(fpascntrd_cs[2]), .evclr(evclr), .icewr(icewr),
				.icedi15_8(icedi[15:8]), .icedi2_0(icedi[2:0]), .fa_meet(fa_meet[2]),
				.fa_over(fa_over[2]), .fa_under(fa_under[2]), .fa_over2(fa_over[3]),
				.fpasout(fpasout[2]), .fpas_ro(fpas_ro2)
			);
	fpas		fpas3 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.selfmodedbg(selfmodedbg), .fch(fch), .svmod_fch(svmod_fch),
				.fpasevt_cs(fpasevt_cs[3]), .fevtpasclr_cs(fevtpasclr_cs[3]),
				.fpascntrd_cs(fpascntrd_cs[3]), .evclr(evclr), .icewr(icewr),
				.icedi15_8(icedi[15:8]), .icedi2_0(icedi[2:0]), .fa_meet(fa_meet[3]),
				.fa_over(fa_over[3]), .fa_under(fa_under[3]), .fa_over2(fa_over[4]),
				.fpasout(fpasout[3]), .fpas_ro(fpas_ro3)
			);
	fpas		fpas4 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.selfmodedbg(selfmodedbg), .fch(fch), .svmod_fch(svmod_fch),
				.fpasevt_cs(fpasevt_cs[4]), .fevtpasclr_cs(fevtpasclr_cs[4]),
				.fpascntrd_cs(fpascntrd_cs[4]), .evclr(evclr), .icewr(icewr),
				.icedi15_8(icedi[15:8]), .icedi2_0(icedi[2:0]), .fa_meet(fa_meet[4]),
				.fa_over(fa_over[4]), .fa_under(fa_under[4]), .fa_over2(fa_over[5]),
				.fpasout(fpasout[4]), .fpas_ro(fpas_ro4)
			);
	fpas		fpas5 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.selfmodedbg(selfmodedbg), .fch(fch), .svmod_fch(svmod_fch),
				.fpasevt_cs(fpasevt_cs[5]), .fevtpasclr_cs(fevtpasclr_cs[5]),
				.fpascntrd_cs(fpascntrd_cs[5]), .evclr(evclr), .icewr(icewr),
				.icedi15_8(icedi[15:8]), .icedi2_0(icedi[2:0]), .fa_meet(fa_meet[5]),
				.fa_over(fa_over[5]), .fa_under(fa_under[5]), .fa_over2(fa_over[6]),
				.fpasout(fpasout[5]), .fpas_ro(fpas_ro5)
			);
	fpas		fpas6 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.selfmodedbg(selfmodedbg), .fch(fch), .svmod_fch(svmod_fch),
				.fpasevt_cs(fpasevt_cs[6]), .fevtpasclr_cs(fevtpasclr_cs[6]),
				.fpascntrd_cs(fpascntrd_cs[6]), .evclr(evclr), .icewr(icewr),
				.icedi15_8(icedi[15:8]), .icedi2_0(icedi[2:0]), .fa_meet(fa_meet[6]),
				.fa_over(fa_over[6]), .fa_under(fa_under[6]), .fa_over2(fa_over[7]),
				.fpasout(fpasout[6]), .fpas_ro(fpas_ro6)
			);
	fpas		fpas7 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.selfmodedbg(selfmodedbg), .fch(fch), .svmod_fch(svmod_fch),
				.fpasevt_cs(fpasevt_cs[7]), .fevtpasclr_cs(fevtpasclr_cs[7]),
				.fpascntrd_cs(fpascntrd_cs[7]), .evclr(evclr), .icewr(icewr),
				.icedi15_8(icedi[15:8]), .icedi2_0(icedi[2:0]), .fa_meet(fa_meet[7]),
				.fa_over(fa_over[7]), .fa_under(fa_under[7]), .fa_over2(fa_over[0]),
				.fpasout(fpasout[7]), .fpas_ro(fpas_ro7)
			);

endmodule

// ======================================================================================================
// fevent detector											=
// ======================================================================================================
module	fdetect (
		icewr, sysrsoutb, fadr_cs, icedi, fch_adr,
		fa_meet, fa_over, fa_under, fdetect_ro
	) ;

	input		icewr, sysrsoutb, fadr_cs;
	input [19:0]	icedi;
	input [19:0]	fch_adr;
	output		fa_meet, fa_over, fa_under;
	output [31:0]	fdetect_ro;

	reg [19:0]	fadr;


	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb) fadr <= 20'b0;
		else if (fadr_cs) fadr <= icedi[19:0];
	end
	assign	fdetect_ro = fadr_cs ? {12'b0, fadr} : 32'b0;


	assign	fa_meet = ( fch_adr == fadr ) ? 1'b1:1'b0;
	assign	fa_over = ( fch_adr >= fadr ) ? 1'b1:1'b0;
	assign	fa_under= ~fa_over | fa_meet;

endmodule

// ======================================================================================================
// fageq output-selector/PAScounter									=
// ======================================================================================================
module	fpas (
		baseck, sysrsoutb, cpuresetb, selfmodedbg, fch, svmod_fch,
		fpasevt_cs, fevtpasclr_cs, fpascntrd_cs, evclr, icewr, icedi15_8, icedi2_0,
		fa_meet, fa_over, fa_under, fa_over2,
		fpasout, fpas_ro
	) ;

	input		baseck, sysrsoutb, cpuresetb, selfmodedbg, fch, svmod_fch,
			fpasevt_cs, fevtpasclr_cs, fpascntrd_cs, evclr, icewr;
	input [15:8]	icedi15_8;
	input [2:0]	icedi2_0;
	input		fa_meet, fa_over, fa_under, fa_over2;
	output		fpasout;
	output [31:0]	fpas_ro;

	reg [7:0]	fevtpasdt;
	reg [2:0]	fpasevt_p, fpasevt;
	reg [7:0]	fpascnt;
	reg		fageq;
	reg [31:0]	fpas_ro;
	wire		fpasclr;
	wire		condition, range;


	/* ------- */
	/* read io */
	/* ------- */
	always @( fpasevt_cs or fpascntrd_cs or fevtpasdt or fpasevt or fpascnt ) begin
		case ({fpasevt_cs, fpascntrd_cs})
			2'b10:	fpas_ro = {16'b0, fevtpasdt, 5'b0, fpasevt};
			2'b01:	fpas_ro = {24'b0, fpascnt};
			default:fpas_ro = 32'b0;
		endcase
	end

	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb) begin
			fevtpasdt <= 8'h01;
			fpasevt_p <= 3'h0;
		end
		else if (fpasevt_cs) begin
			fevtpasdt <= icedi15_8;
			fpasevt_p <= icedi2_0;
		end
	end
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	fpasevt <= 3'h0;
		else		fpasevt <= fpasevt_p;
	end

	/* ----------------------- */
	/* f_event output selector */
	/* ----------------------- */
	assign	condition = fch & ~svmod_fch & ~selfmodedbg;
	assign	range = fa_under & fa_over2;
	always @( fpasevt or fa_meet or fa_over or fa_under or range or condition ) begin
		case (fpasevt)
			3'b000 : fageq <= 1'b0;
			3'b001 : fageq <= fa_meet & condition;
			3'b010 : fageq <= 1'b0;
			3'b011 : fageq <= fa_over & condition;
			3'b100 : fageq <= fa_under & condition;
			3'b101 : fageq <= range & condition;
			3'b110 : fageq <= ~range & condition;
			3'b111 : fageq <= 1'b0;
		endcase
	end

	/* ----------- */
	/* pas counter */
	/* ----------- */
	/* --------------------------------------------------------------------	*/
	/* CPU Reset時にはPASCounterはCountUpさせない.				*/
	/* fpascnt==(fevtpasdt-1)時はevent成立信号がthroughされるので,		*/
	/* event信号はeventr(統合器)で抑える.					*/
	/* breakなど,受側でひげのある信号を出してもでも問題ない作りになって	*/
	/* いれば,eventrでも切らずにひげのある信号を出力させ,受側でcpuresetb	*/
	/* を条件に入れて切り直してもらうことでeventのtimingを早められる.	*/
	/* --------------------------------------------------------------------	*/

	assign	fpasclr = evclr | fevtpasclr_cs & icewr | ~sysrsoutb;
	always @( posedge baseck or posedge fpasclr ) begin
		if (fpasclr)	fpascnt <= 8'b0;
		else if (cpuresetb) begin
			if ((fpascnt == (fevtpasdt-1)) & fageq)
				fpascnt <= 8'b0;
			else if (fageq)
				fpascnt <= fpascnt+1;
		end
	end

	/* ---------- */
	/* detect out */
	/* ---------- */
	assign	fpasout = (fpascnt == (fevtpasdt-1)) ? fageq : 1'b0;


endmodule

// ======================================================================================================
// access event												=
// ======================================================================================================
module	aevent (
		baseck, icewr, sysrsoutb, cpuresetb, selfmodedbg, word, rd, wr, evclr, svmod_acc,
		aadr_cs, adtr_cs, adtmkr_cs, apasevt_cs, aevtpasclr_cs, apascntrd_cs,
		acc_adr, acc_bus, icedi, apasout, aevent_ro
	);

	input		baseck, icewr, sysrsoutb, cpuresetb, selfmodedbg, word, rd, wr, evclr, svmod_acc;
	input [7:0]	aadr_cs, adtr_cs, adtmkr_cs, apasevt_cs, aevtpasclr_cs, apascntrd_cs;
	input [19:0]	acc_adr;
	input [15:0]	acc_bus;
	input [19:0]	icedi;
	output [7:0]	apasout;
	output [31:0]	aevent_ro;

	wire [7:0]	address_meet, address_over, address_under,
			data_meet, data_not, data_over, data_under;
	wire [31:0]	adetect_ro0, adetect_ro1, adetect_ro2, adetect_ro3,
			adetect_ro4, adetect_ro5, adetect_ro6, adetect_ro7;
	wire [31:0]	apas_ro0, apas_ro1, apas_ro2, apas_ro3,
			apas_ro4, apas_ro5, apas_ro6, apas_ro7;


	assign	aevent_ro = adetect_ro0 | adetect_ro1 | adetect_ro2 | adetect_ro3 |
			    adetect_ro4 | adetect_ro5 | adetect_ro6 | adetect_ro7 |
			    apas_ro0 | apas_ro1 | apas_ro2 | apas_ro3 |
			    apas_ro4 | apas_ro5 | apas_ro6 | apas_ro7;


	// --------
	// detector
	// --------
	adetect		adetect0 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .aadr_cs(aadr_cs[0]),
				.adtr_cs(adtr_cs[0]), .adtmkr_cs(adtmkr_cs[0]), .word(word),
				.rd(rd), .wr(wr), .icedi(icedi), .acc_adr(acc_adr),
				.acc_bus(acc_bus), .address_meet(address_meet[0]),
				.address_over(address_over[0]), .address_under(address_under[0]),
				.data_meet(data_meet[0]), .data_not(data_not[0]),
				.data_over(data_over[0]), .data_under(data_under[0]),
				.adetect_ro(adetect_ro0)
			);
	adetect		adetect1 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .aadr_cs(aadr_cs[1]),
				.adtr_cs(adtr_cs[1]), .adtmkr_cs(adtmkr_cs[1]), .word(word),
				.rd(rd), .wr(wr), .icedi(icedi), .acc_adr(acc_adr),
				.acc_bus(acc_bus), .address_meet(address_meet[1]),
				.address_over(address_over[1]), .address_under(address_under[1]),
				.data_meet(data_meet[1]), .data_not(data_not[1]),
				.data_over(data_over[1]), .data_under(data_under[1]),
				.adetect_ro(adetect_ro1)
			);
	adetect		adetect2 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .aadr_cs(aadr_cs[2]),
				.adtr_cs(adtr_cs[2]), .adtmkr_cs(adtmkr_cs[2]), .word(word),
				.rd(rd), .wr(wr), .icedi(icedi), .acc_adr(acc_adr),
				.acc_bus(acc_bus), .address_meet(address_meet[2]),
				.address_over(address_over[2]), .address_under(address_under[2]),
				.data_meet(data_meet[2]), .data_not(data_not[2]),
				.data_over(data_over[2]), .data_under(data_under[2]),
				.adetect_ro(adetect_ro2)
			);
	adetect		adetect3 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .aadr_cs(aadr_cs[3]),
				.adtr_cs(adtr_cs[3]), .adtmkr_cs(adtmkr_cs[3]), .word(word),
				.rd(rd), .wr(wr), .icedi(icedi), .acc_adr(acc_adr),
				.acc_bus(acc_bus), .address_meet(address_meet[3]),
				.address_over(address_over[3]), .address_under(address_under[3]),
				.data_meet(data_meet[3]), .data_not(data_not[3]),
				.data_over(data_over[3]), .data_under(data_under[3]),
				.adetect_ro(adetect_ro3)
			);
	adetect		adetect4 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .aadr_cs(aadr_cs[4]),
				.adtr_cs(adtr_cs[4]), .adtmkr_cs(adtmkr_cs[4]), .word(word),
				.rd(rd), .wr(wr), .icedi(icedi), .acc_adr(acc_adr),
				.acc_bus(acc_bus), .address_meet(address_meet[4]),
				.address_over(address_over[4]), .address_under(address_under[4]),
				.data_meet(data_meet[4]), .data_not(data_not[4]),
				.data_over(data_over[4]), .data_under(data_under[4]),
				.adetect_ro(adetect_ro4)
			);
	adetect		adetect5 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .aadr_cs(aadr_cs[5]),
				.adtr_cs(adtr_cs[5]), .adtmkr_cs(adtmkr_cs[5]), .word(word),
				.rd(rd), .wr(wr), .icedi(icedi), .acc_adr(acc_adr),
				.acc_bus(acc_bus), .address_meet(address_meet[5]),
				.address_over(address_over[5]), .address_under(address_under[5]),
				.data_meet(data_meet[5]), .data_not(data_not[5]),
				.data_over(data_over[5]), .data_under(data_under[5]),
				.adetect_ro(adetect_ro5)
			);
	adetect		adetect6 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .aadr_cs(aadr_cs[6]),
				.adtr_cs(adtr_cs[6]), .adtmkr_cs(adtmkr_cs[6]), .word(word),
				.rd(rd), .wr(wr), .icedi(icedi), .acc_adr(acc_adr),
				.acc_bus(acc_bus), .address_meet(address_meet[6]),
				.address_over(address_over[6]), .address_under(address_under[6]),
				.data_meet(data_meet[6]), .data_not(data_not[6]),
				.data_over(data_over[6]), .data_under(data_under[6]),
				.adetect_ro(adetect_ro6)
			);
	adetect		adetect7 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .aadr_cs(aadr_cs[7]),
				.adtr_cs(adtr_cs[7]), .adtmkr_cs(adtmkr_cs[7]), .word(word),
				.rd(rd), .wr(wr), .icedi(icedi), .acc_adr(acc_adr),
				.acc_bus(acc_bus), .address_meet(address_meet[7]),
				.address_over(address_over[7]), .address_under(address_under[7]),
				.data_meet(data_meet[7]), .data_not(data_not[7]),
				.data_over(data_over[7]), .data_under(data_under[7]),
				.adetect_ro(adetect_ro7)
			);

	// -------------
	// selector, PAS
	// -------------
	apas		apas0 (
				.baseck(baseck), .icewr(icewr), .sysrsoutb(sysrsoutb),
				.cpuresetb(cpuresetb), .selfmodedbg(selfmodedbg), .apasevt_cs(apasevt_cs[0]),
				.aevtpasclr_cs(aevtpasclr_cs[0]), .apascntrd_cs(apascntrd_cs[0]),
				.evclr(evclr), .svmod_acc(svmod_acc), .address_meet(address_meet[0]),
				.address_over(address_over[0]), .address_under(address_under[0]),
				.address_meet2(address_meet[1]), .address_over2(address_over[1]),
				.address_under2(address_under[1]), .data_meet(data_meet[0]),
				.data_over(data_over[0]), .data_under(data_under[0]),
				.data_meet2(data_meet[1]), .data_over2(data_over[1]),
				.data_under2(data_under[1]), .data_not(data_not[0]),
				.icedi15_8(icedi[15:8]), .icedi6_4(icedi[6:4]), .icedi2_0(icedi[2:0]),
				.apasout(apasout[0]), .apas_ro(apas_ro0)
			);
	apas		apas1 (
				.baseck(baseck), .icewr(icewr), .sysrsoutb(sysrsoutb),
				.cpuresetb(cpuresetb), .selfmodedbg(selfmodedbg), .apasevt_cs(apasevt_cs[1]),
				.aevtpasclr_cs(aevtpasclr_cs[1]), .apascntrd_cs(apascntrd_cs[1]),
				.evclr(evclr), .svmod_acc(svmod_acc), .address_meet(address_meet[1]),
				.address_over(address_over[1]), .address_under(address_under[1]),
				.address_meet2(address_meet[2]), .address_over2(address_over[2]),
				.address_under2(address_under[2]), .data_meet(data_meet[1]),
				.data_over(data_over[1]), .data_under(data_under[1]),
				.data_meet2(data_meet[2]), .data_over2(data_over[2]),
				.data_under2(data_under[2]), .data_not(data_not[1]),
				.icedi15_8(icedi[15:8]), .icedi6_4(icedi[6:4]), .icedi2_0(icedi[2:0]),
				.apasout(apasout[1]), .apas_ro(apas_ro1)
			);
	apas		apas2 (
				.baseck(baseck), .icewr(icewr), .sysrsoutb(sysrsoutb),
				.cpuresetb(cpuresetb), .selfmodedbg(selfmodedbg), .apasevt_cs(apasevt_cs[2]),
				.aevtpasclr_cs(aevtpasclr_cs[2]), .apascntrd_cs(apascntrd_cs[2]),
				.evclr(evclr), .svmod_acc(svmod_acc), .address_meet(address_meet[2]),
				.address_over(address_over[2]), .address_under(address_under[2]),
				.address_meet2(address_meet[3]), .address_over2(address_over[3]),
				.address_under2(address_under[3]), .data_meet(data_meet[2]),
				.data_over(data_over[2]), .data_under(data_under[2]),
				.data_meet2(data_meet[3]), .data_over2(data_over[3]),
				.data_under2(data_under[3]), .data_not(data_not[2]),
				.icedi15_8(icedi[15:8]), .icedi6_4(icedi[6:4]), .icedi2_0(icedi[2:0]),
				.apasout(apasout[2]), .apas_ro(apas_ro2)
			);
	apas		apas3 (
				.baseck(baseck), .icewr(icewr), .sysrsoutb(sysrsoutb),
				.cpuresetb(cpuresetb), .selfmodedbg(selfmodedbg), .apasevt_cs(apasevt_cs[3]),
				.aevtpasclr_cs(aevtpasclr_cs[3]), .apascntrd_cs(apascntrd_cs[3]),
				.evclr(evclr), .svmod_acc(svmod_acc), .address_meet(address_meet[3]),
				.address_over(address_over[3]), .address_under(address_under[3]),
				.address_meet2(address_meet[4]), .address_over2(address_over[4]),
				.address_under2(address_under[4]), .data_meet(data_meet[3]),
				.data_over(data_over[3]), .data_under(data_under[3]),
				.data_meet2(data_meet[4]), .data_over2(data_over[4]),
				.data_under2(data_under[4]), .data_not(data_not[3]),
				.icedi15_8(icedi[15:8]), .icedi6_4(icedi[6:4]), .icedi2_0(icedi[2:0]),
				.apasout(apasout[3]), .apas_ro(apas_ro3)
			);
	apas		apas4 (
				.baseck(baseck), .icewr(icewr), .sysrsoutb(sysrsoutb),
				.cpuresetb(cpuresetb), .selfmodedbg(selfmodedbg), .apasevt_cs(apasevt_cs[4]),
				.aevtpasclr_cs(aevtpasclr_cs[4]), .apascntrd_cs(apascntrd_cs[4]),
				.evclr(evclr), .svmod_acc(svmod_acc), .address_meet(address_meet[4]),
				.address_over(address_over[4]), .address_under(address_under[4]),
				.address_meet2(address_meet[5]), .address_over2(address_over[5]),
				.address_under2(address_under[5]), .data_meet(data_meet[4]),
				.data_over(data_over[4]), .data_under(data_under[4]),
				.data_meet2(data_meet[5]), .data_over2(data_over[5]),
				.data_under2(data_under[5]), .data_not(data_not[4]),
				.icedi15_8(icedi[15:8]), .icedi6_4(icedi[6:4]), .icedi2_0(icedi[2:0]),
				.apasout(apasout[4]), .apas_ro(apas_ro4)
			);
	apas		apas5 (
				.baseck(baseck), .icewr(icewr), .sysrsoutb(sysrsoutb),
				.cpuresetb(cpuresetb), .selfmodedbg(selfmodedbg), .apasevt_cs(apasevt_cs[5]),
				.aevtpasclr_cs(aevtpasclr_cs[5]), .apascntrd_cs(apascntrd_cs[5]),
				.evclr(evclr), .svmod_acc(svmod_acc), .address_meet(address_meet[5]),
				.address_over(address_over[5]), .address_under(address_under[5]),
				.address_meet2(address_meet[6]), .address_over2(address_over[6]),
				.address_under2(address_under[6]), .data_meet(data_meet[5]),
				.data_over(data_over[5]), .data_under(data_under[5]),
				.data_meet2(data_meet[6]), .data_over2(data_over[6]),
				.data_under2(data_under[6]), .data_not(data_not[5]),
				.icedi15_8(icedi[15:8]), .icedi6_4(icedi[6:4]), .icedi2_0(icedi[2:0]),
				.apasout(apasout[5]), .apas_ro(apas_ro5)
			);
	apas		apas6 (
				.baseck(baseck), .icewr(icewr), .sysrsoutb(sysrsoutb),
				.cpuresetb(cpuresetb), .selfmodedbg(selfmodedbg), .apasevt_cs(apasevt_cs[6]),
				.aevtpasclr_cs(aevtpasclr_cs[6]), .apascntrd_cs(apascntrd_cs[6]),
				.evclr(evclr), .svmod_acc(svmod_acc), .address_meet(address_meet[6]),
				.address_over(address_over[6]), .address_under(address_under[6]),
				.address_meet2(address_meet[7]), .address_over2(address_over[7]),
				.address_under2(address_under[7]), .data_meet(data_meet[6]),
				.data_over(data_over[6]), .data_under(data_under[6]),
				.data_meet2(data_meet[7]), .data_over2(data_over[7]),
				.data_under2(data_under[7]), .data_not(data_not[6]),
				.icedi15_8(icedi[15:8]), .icedi6_4(icedi[6:4]), .icedi2_0(icedi[2:0]),
				.apasout(apasout[6]), .apas_ro(apas_ro6)
			);
	apas		apas7 (
				.baseck(baseck), .icewr(icewr), .sysrsoutb(sysrsoutb),
				.cpuresetb(cpuresetb), .selfmodedbg(selfmodedbg), .apasevt_cs(apasevt_cs[7]),
				.aevtpasclr_cs(aevtpasclr_cs[7]), .apascntrd_cs(apascntrd_cs[7]),
				.evclr(evclr), .svmod_acc(svmod_acc), .address_meet(address_meet[7]),
				.address_over(address_over[7]), .address_under(address_under[7]),
				.address_meet2(address_meet[0]), .address_over2(address_over[0]),
				.address_under2(address_under[0]), .data_meet(data_meet[7]),
				.data_over(data_over[7]), .data_under(data_under[7]),
				.data_meet2(data_meet[0]), .data_over2(data_over[0]),
				.data_under2(data_under[0]), .data_not(data_not[7]),
				.icedi15_8(icedi[15:8]), .icedi6_4(icedi[6:4]), .icedi2_0(icedi[2:0]),
				.apasout(apasout[7]), .apas_ro(apas_ro7)
			);

endmodule

// ======================================================================================================
// aevent detector											=
// ======================================================================================================
module	adetect (
		icewr, sysrsoutb, aadr_cs, adtr_cs, adtmkr_cs, word, rd, wr,
		icedi, acc_adr, acc_bus,
		address_meet, address_over, address_under,
		data_meet, data_not, data_over, data_under,
		adetect_ro
		
	) ;

	input	icewr, sysrsoutb, aadr_cs, adtr_cs, adtmkr_cs, word, rd, wr;
	input [19:0]	icedi;
	input [19:0]	acc_adr;
	input [15:0]	acc_bus;

	output		address_meet, address_over, address_under;
	output		data_meet, data_not, data_over, data_under;
	output [31:0]	adetect_ro;

	reg [19:0]	aadr;
	reg [19:0]	adtr;
	reg [15:0]	adtmkr;
	reg [31:0]	adetect_ro;
	wire		access_ok, comp_address_meet, comp_address_over;
	wire [15:0]	acc_bus;
	wire		rw_access, ncnd_access, byte_access, word_access;
	wire		comp_byte_meet_upp, comp_byte_meet_low, comp_byte_meet;
	wire		comp_byte_over_upp, comp_byte_over_low, comp_byte_over;
	wire		comp_word_meet, comp_word_over;
	wire		comp_ncnd_meet_word, comp_ncnd_meet, comp_ncnd_over_word, comp_ncnd_over;


	// ------------------
	// emulation register
	// ------------------
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)		aadr <= 20'b0;
		else if (aadr_cs)	aadr <= icedi;
	end
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)		adtr <= 20'b0;
		else if (adtr_cs)	adtr <= icedi[19:0];
	end
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)		adtmkr <= 16'b0;
		else if (adtmkr_cs)	adtmkr <= icedi[15:0];
	end


	/* ------- */
	/* read io */
	/* ------- */
	always @( aadr_cs or adtr_cs or adtmkr_cs or aadr or adtr or adtmkr ) begin
		case ({aadr_cs, adtr_cs, adtmkr_cs})
			3'b100:	adetect_ro = {12'b0, aadr};
			3'b010:	adetect_ro = {12'b0, adtr};
			3'b001:	adetect_ro = {16'b0, adtmkr};
			default:adetect_ro = 32'b0;
		endcase
	end

// ------------------------------------------------------------------------------------------------------
// access address detector										-
// ------------------------------------------------------------------------------------------------------
	/* --------------------------------------------------------------------	*/
	/* ・WordでもByteでも設定したAccess Sizeと一致していればok		*/
	/* ・一応no-conditionもaddress検出器の条件に入れる			*/
	/*  （no-conditionで使用の時はaddressは無効(1固定)にして使用される）	*/
	/* --------------------------------------------------------------------	*/

	assign	access_ok =	adtr[19] ? rw_access : (word == adtr[18]) & rw_access;

	// -------------------------
	// access address comparator
	// -------------------------
	assign	comp_address_meet = ( acc_adr == aadr ) ? 1'b1 : 1'b0;
	assign	comp_address_over = ( acc_adr >= aadr ) ? 1'b1 : 1'b0;


	// -----------------------
	// access address detector
	// -----------------------
	assign	address_meet =	comp_address_meet & access_ok;
	assign	address_over =	comp_address_over & access_ok;
	assign	address_under =	(~comp_address_over | comp_address_meet) & access_ok;


// ------------------------------------------------------------------------------------------------------
// access data detector											-
// ------------------------------------------------------------------------------------------------------

/* --------------------------------------------------------------------------------------------	*/
/* ・Byte検出,Word検出はdata_xx信号に統合する.							*/
/* ・不一致,範囲外などはdataに対してのみで,read,write,word条件は外す				*/
/* ・NoConditionの不一致,以上,以下,範囲内,範囲外は要求仕様が明確にならないので使用禁止		*/
/*   作り込みは不一致は一致の排他,範囲外は範囲内の排他として動く(aabbhでaa比較のときaaで一致	*/
/*   なのでbbで不一致検出しない.55-aa範囲なら,aaがあるので範囲内検出とし,bbで範囲外検出しない.)	*/
/* --------------------------------------------------------------------------------------------	*/
	assign	rw_access =	(wr & adtr[17]) | (rd & adtr[16]);
	assign	ncnd_access =	adtr[19] & rw_access;	/* accessサイズはバイトでもワードでもok */
	assign	byte_access =	~adtr[19] & (~word & ~adtr[18]) & rw_access;
	assign	word_access =	~adtr[19] & ( word &  adtr[18]) & rw_access;

	// ----------------------
	// access data comparator
	// ----------------------
	/* byte-meet */
	assign	comp_byte_meet_upp = (acc_bus[15:8] | adtmkr[15:8]) == (adtr[15:8] | adtmkr[15:8]) ? 1'b1 : 1'b0;
	assign	comp_byte_meet_low = (acc_bus[7:0]  | adtmkr[7:0]) == (adtr[7:0] | adtmkr[7:0]) ? 1'b1 : 1'b0;
	assign	comp_byte_meet = acc_adr[0] ? comp_byte_meet_upp : comp_byte_meet_low;

	/* byte-over */
	assign	comp_byte_over_upp = (acc_bus[15:8] | adtmkr[15:8]) >= (adtr[15:8] | adtmkr[15:8]) ? 1'b1 : 1'b0;
	assign	comp_byte_over_low = (acc_bus[7:0]  | adtmkr[7:0]) >= (adtr[7:0] | adtmkr[7:0]) ? 1'b1 : 1'b0;
	assign	comp_byte_over = acc_adr[0] ? comp_byte_over_upp : comp_byte_over_low;

	/* word */
	assign	comp_word_meet = comp_byte_meet_upp & comp_byte_meet_low;
	assign	comp_word_over = (( acc_bus | adtmkr ) >= ( adtr[15:0] | adtmkr )) ? 1'b1:1'b0;

	/* no-condition */
	assign	comp_ncnd_meet_word = comp_byte_meet_upp | comp_byte_meet_low; /* どちらか一方でも一致していたら一致 */
	assign	comp_ncnd_meet = word ? comp_ncnd_meet_word : comp_byte_meet; /* byteアクセス時は通常と同じ */
	assign	comp_ncnd_over_word = comp_byte_over_upp | comp_byte_over_low; /* どちらか一方でも以上だったら以上 */
	assign	comp_ncnd_over = word ? comp_ncnd_over_word : comp_byte_over; /* byteアクセス時は通常と同じ */

	// --------------------
	// access data detector
	// --------------------
	assign	data_meet  =	comp_byte_meet & byte_access |				/* byte用 */
				comp_word_meet & word_access |				/* word用,16bitバスなのでダブり検出の考慮不要 */
				comp_ncnd_meet & ncnd_access;				/* no-condition用 */

	assign	data_not   =	~comp_byte_meet & byte_access |				/* byte用 */
				~comp_word_meet & word_access |				/* word用 */
				~comp_ncnd_meet & ncnd_access;				/* no-condition用 */

	assign	data_over  =	comp_byte_over & byte_access |				/* byte用 */
				comp_word_over & word_access |				/* word用 */
				comp_ncnd_over & ncnd_access;				/* no-condition用 */

	assign	data_under =	(~comp_byte_over | comp_byte_meet) & byte_access |	/* byte用 */
				(~comp_word_over | comp_word_meet) & word_access |	/* word用 */
				(~comp_ncnd_over | comp_ncnd_meet) & ncnd_access;	/* no-condition用 */


endmodule


// ======================================================================================================
// apas output-selector/PAScounter									=
// ======================================================================================================
module	apas	(
		baseck, icewr, sysrsoutb, cpuresetb, selfmodedbg, apasevt_cs, aevtpasclr_cs, apascntrd_cs,
		evclr, svmod_acc, address_meet, address_over, address_under, address_meet2, address_over2,
		address_under2, data_meet, data_over, data_under, data_not, data_meet2, data_over2,
		data_under2, icedi15_8, icedi6_4, icedi2_0, apasout, apas_ro
	);

	input		baseck, icewr, sysrsoutb, cpuresetb, selfmodedbg, apasevt_cs, aevtpasclr_cs,
			apascntrd_cs;
	input		evclr, svmod_acc;
	input		address_meet, address_over, address_under;
	input		address_meet2, address_over2, address_under2;
	input		data_meet, data_over, data_under, data_not;
	input		data_meet2, data_over2, data_under2;
	input [15:8]	icedi15_8;
	input [6:4]	icedi6_4;
	input [2:0]	icedi2_0;
	output		apasout;
	output [31:0]	apas_ro;

	reg [7:0]	aevtpasdt;
	reg [5:0]	apasevt_p, apasevt;
	reg		aageq, adgeq;
	reg [7:0]	apascnt;
	reg [31:0]	apas_ro;
	wire		apasclr;
	wire		apas;
	wire		apasout;
	wire		condition;

	/* ------- */
	/* read io */
	/* ------- */
	always @( apasevt_cs or apascntrd_cs or aevtpasdt or apasevt or apascnt ) begin
		case ({apasevt_cs, apascntrd_cs})
			2'b10:	apas_ro = {16'b0, aevtpasdt, 1'b0, apasevt[5:3], 1'b0, apasevt[2:0]};
			2'b01:	apas_ro = {24'b0, apascnt};
			default:apas_ro = 32'b0;
		endcase
	end

	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb) begin
			aevtpasdt <= 8'h01;
			apasevt_p <= 6'h0;
		end
		else if (apasevt_cs) begin
			aevtpasdt <= icedi15_8;
			apasevt_p <= {icedi6_4, icedi2_0};
		end
	end
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) apasevt	<= 6'h0;
		else 		apasevt	<= apasevt_p;
	end

	/* -------------------- */
	/* access address event */
	/* -------------------- */
	/* -------------------------------- */
	/* 範囲外は範囲内との境界を含まない */
	/* -------------------------------- */
	assign	condition = ~svmod_acc & ~selfmodedbg;
	always @( apasevt[2:0] or address_meet or address_over or address_under or
				address_meet2 or address_over2 or address_under2 or condition) begin

		case (apasevt[2:0])
			3'b000 : aageq = 1'b0;
			3'b001 : aageq = address_meet & condition;
			3'b010 : aageq = 1'b0;
			3'b011 : aageq = address_over & condition;
			3'b100 : aageq = address_under & condition;
			3'b101 : aageq = address_under & address_over2 & condition;
			3'b110 : aageq = (address_over & ~address_meet | address_under2 & ~address_meet2) & condition;
			3'b111 : aageq = 1'b1;
		endcase
	end

	/* ----------------- */
	/* access data event */
	/* ----------------- */
	/* -------------------------------------------------------------------- */
	/* 範囲外は範囲内との境界を含まない					*/
	/* ここのdata_xxにnotを付けるとアクセス条件も否定してしまうので注意	*/
	/* -------------------------------------------------------------------- */

	always @( apasevt[5:3] or data_meet or data_not or data_over or data_under or
				data_meet2 or data_over2 or data_under2 or condition ) begin
		case (apasevt[5:3])
			3'b000 : adgeq = 1'b0; 
			3'b001 : adgeq = data_meet & condition;
			3'b010 : adgeq = data_not & condition;
			3'b011 : adgeq = data_over & condition;
			3'b100 : adgeq = data_under & condition;
			3'b101 : adgeq = data_under & data_over2 & condition;
			3'b110 : adgeq = (data_over & ~data_meet | data_under2 & ~data_meet2) & condition;
			3'b111 : adgeq = 1'b1;
		endcase
	end
	assign	apas = aageq & adgeq;

	/* ----------- */
	/* pas counter */
	/* --------------------------------------------------------------------	*/
	/* CPU Reset時にはPASCounterはCountUpさせない.				*/
	/* apascnt==(aevtpasdt-1)時はevent成立信号がthroughされるので,		*/
	/* event信号はeventr(統合器)で抑える.					*/
	/* breakなど,受側でひげのある信号を出してもでも問題ない作りになって	*/
	/* いれば,eventrでも切らずにひげのある信号を出力させ,受側でcpuresetb	*/
	/* を条件に入れて切り直してもらうことでeventのtimingを早められる.	*/
	/* --------------------------------------------------------------------	*/

	assign	apasclr = evclr | aevtpasclr_cs & icewr | ~sysrsoutb;
	always @( posedge baseck or posedge apasclr ) begin
		if (apasclr)	apascnt <= 8'b0;
		else if (cpuresetb) begin
			if ((apascnt == (aevtpasdt-1)) & apas)
				apascnt <= 8'b0;
			else if (apas)
				apascnt <= apascnt+1;
		end
	end

	// ----------
	// detect out
	// ----------
	assign	apasout = (apascnt == (aevtpasdt-1)) ? apas : 1'b0;

endmodule

// ======================================================================================================
// Event Link												=
// ======================================================================================================
module	event_link (
		baseck, sysrsoutb, cpuresetb, icewr, evclr, seqrst, seqin_cs, seqctc_cs,
		seqpasclr_cs, spascntrd_cs, detect_out, icedi, spasout, event_link_ro
	);
	input		baseck, sysrsoutb, cpuresetb, icewr, evclr;
	input [1:0]	seqrst;
	input [9:0]	seqin_cs;
	input [1:0]	seqctc_cs;
	input [1:0]	seqpasclr_cs;
	input [1:0]	spascntrd_cs;
	input [15:0]	detect_out;
	input [15:0]	icedi;
	output [1:0]	spasout;
	output [31:0]	event_link_ro;

	wire [31:0]	sequential_unit0_ro, sequential_unit1_ro;


	assign	event_link_ro =	sequential_unit0_ro | sequential_unit1_ro;

	sequential_unit	sequential_unit0 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.icewr(icewr), .evclr(evclr), .seqrst(seqrst[0]),
				.seqin_cs(seqin_cs[4:0]), .seqctc_cs(seqctc_cs[0]),
				.seqpasclr_cs(seqpasclr_cs[0]), .spascntrd_cs(spascntrd_cs[0]),
				.detect_out(detect_out), .icedi(icedi),
				.spasout(spasout[0]), .sequential_unit_ro(sequential_unit0_ro)
			);
	sequential_unit	sequential_unit1 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.icewr(icewr), .evclr(evclr), .seqrst(seqrst[1]),
				.seqin_cs(seqin_cs[9:5]), .seqctc_cs(seqctc_cs[1]),
				.seqpasclr_cs(seqpasclr_cs[1]), .spascntrd_cs(spascntrd_cs[1]),
				.detect_out(detect_out), .icedi(icedi),
				.spasout(spasout[1]), .sequential_unit_ro(sequential_unit1_ro)
			);

endmodule

// ======================================================================================================
// Sequencial Unit											=
// ======================================================================================================

/* ------------------------------------------------------------------------------------------------------- */
/*           | seqin      |               -------------o|_       |                       seqpasdt	   */
/*           | |   ---    |              |      ------->|_)-|_   |     ||                   |		   */
/* detect_out|  ->||_ |   | use_event    |     |   _____    |))->|----->|                   |		   */
/*    ------>|--->||_)|-->|--------------|-----+->|in   |-+-|~   |     ||--->|_            ---		   */
/*           |  ->||  |-->| disable_event|   |_   |     | |      |   ->||  ->|_)-- x4..-+-|PAS|--> spasout */
/*           | |   ---    |--------------+-->|_)->|clr  | |      |  |  || |             |  ---		   */
/*           | |          | spas -----+----->|    |     | |      |  |  ^  |             |   |		   */
/*           | |          | step_en --|--+------->|en   | |      |  |  |  |             |   |		   */
/*           | |          | baseck ---|--|------->|clk  | |      |  |  | seqmode        |   |		   */
/*           | |          |           |  |         -----  |      |  |  |                |   |		   */
/*           | |          |           |   -----------|----|----->|--  seqen             |   |		   */
/*           | |          |            --------------|----|------|<---------------------    |		   */
/*           | |　  (n+1) | (n)      evclr, seqrst---+----|----->|--------------------->|_  |		   */
/*           |  ----------|<------------------------------       |       seqpasclr----->|_)-		   */
/*  f/aevent | seqin_unit |**************** step ****************|*********** sequential_unit ***********  */
/* ------------------------------------------------------------------------------------------------------- */

module	sequential_unit (
		baseck, sysrsoutb, cpuresetb, icewr, evclr, seqrst, seqin_cs, seqctc_cs,
		seqpasclr_cs, spascntrd_cs, detect_out, icedi, spasout, sequential_unit_ro
	);

	input		baseck, sysrsoutb, cpuresetb, icewr, evclr, seqrst;
	input [4:0]	seqin_cs;
	input		seqctc_cs;
	input		seqpasclr_cs;
	input		spascntrd_cs;
	input [15:0]	detect_out;
	input [15:0]	icedi;
	output		spasout;
	output [31:0]	sequential_unit_ro;

	reg [7:0]	seqpasdt;
	reg		seqmode_p, seqmode;
	reg [3:0]	seqen;
	reg [7:0]	spascnt;
	reg [31:0]	sequential_unit_ro;

	wire [3:0]	step_en;
	wire [3:0]	seqin_en;
	wire		spas;
	wire		spasclr;
	wire [3:0]	step_l;
	wire [3:0]	step_out;
	wire [3:0]	use_event;
	wire [31:0]	disable_unit_ro, seqin_unit0_ro, seqin_unit1_ro, seqin_unit2_ro, seqin_unit3_ro;


	always @( seqin_cs or seqctc_cs or spascntrd_cs or disable_unit_ro or
		  seqin_unit0_ro or seqin_unit1_ro or seqin_unit2_ro or seqin_unit3_ro or
		  seqpasdt or seqmode or seqen or spascnt ) begin

		case ({seqin_cs[0], seqin_cs[1], seqin_cs[2], seqin_cs[3], seqin_cs[4], seqctc_cs, spascntrd_cs})
			7'b100_0000:	sequential_unit_ro = disable_unit_ro;
			7'b010_0000:	sequential_unit_ro = seqin_unit0_ro;
			7'b001_0000:	sequential_unit_ro = seqin_unit1_ro;
			7'b000_1000:	sequential_unit_ro = seqin_unit2_ro;
			7'b000_0100:	sequential_unit_ro = seqin_unit3_ro;
			7'b000_0010:	sequential_unit_ro = {16'b0, seqpasdt, 3'b0, seqmode, seqen};
			7'b000_0001:	sequential_unit_ro = {24'b0, spascnt};
			default:	sequential_unit_ro = 32'b0;
		endcase
	end
// ------------------------------------------------------------------------------------------------------
// seqin_unit												-
// ------------------------------------------------------------------------------------------------------
	/* ----------------------------------------------------------------------------------------- */
	/* seqmode=0中のdisable_eventでstepがclearされないよう,disable_eventのenableをseqmodeにする. */
	/* ----------------------------------------------------------------------------------------- */
	seqin_unit	disable_unit (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .seqin_cs(seqin_cs[0]),
				.seqin_en(seqmode), .detect_out(detect_out), .icedi(icedi),
				.use_event(disable_event), .seqin_unit_ro(disable_unit_ro)
			);
	seqin_unit	seqin_unit0 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .seqin_cs(seqin_cs[1]),
				.seqin_en(seqin_en[0]), .detect_out(detect_out), .icedi(icedi),
				.use_event(use_event[0]), .seqin_unit_ro(seqin_unit0_ro)
			);
	seqin_unit	seqin_unit1 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .seqin_cs(seqin_cs[2]),
				.seqin_en(seqin_en[1]), .detect_out(detect_out), .icedi(icedi),
				.use_event(use_event[1]), .seqin_unit_ro(seqin_unit1_ro)
			);
	seqin_unit	seqin_unit2 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .seqin_cs(seqin_cs[3]),
				.seqin_en(seqin_en[2]), .detect_out(detect_out), .icedi(icedi),
				.use_event(use_event[2]), .seqin_unit_ro(seqin_unit2_ro)
			);
	seqin_unit	seqin_unit3 (
				.icewr(icewr), .sysrsoutb(sysrsoutb), .seqin_cs(seqin_cs[4]),
				.seqin_en(seqin_en[3]), .detect_out(detect_out), .icedi(icedi),
				.use_event(use_event[3]), .seqin_unit_ro(seqin_unit3_ro)
			);

// ------------------------------------------------------------------------------------------------------
// SEQCTC Register											-
// ------------------------------------------------------------------------------------------------------
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)	begin
			seqpasdt <= 8'h01;
			seqmode_p <=1'b0;
			seqen <= 4'h0;
		end
		else if (seqctc_cs) begin
			seqpasdt <= icedi[15:8];
			seqmode_p <= icedi[4];
			seqen <= icedi[3:0];
		end
	end
	always @( posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	seqmode <= 1'b0;
		else		seqmode <= seqmode_p;
	end

// ------------------------------------------------------------------------------------------------------
// Step													-
// ------------------------------------------------------------------------------------------------------
	step_unit	step0 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.disable_event(disable_event), .spas(spas), .evclr(evclr),
				.seqrst(seqrst), .step_en(step_en[0]), .use_event(use_event[0]),
				.step_l(step_l[0]), .step_out(step_out[0])
			);
	step_unit	step1 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.disable_event(disable_event), .spas(spas), .evclr(evclr),
				.seqrst(seqrst), .step_en(step_en[1]), .use_event(use_event[1]),
				.step_l(step_l[1]), .step_out(step_out[1])
			);
	step_unit	step2 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.disable_event(disable_event), .spas(spas), .evclr(evclr),
				.seqrst(seqrst), .step_en(step_en[2]), .use_event(use_event[2]),
				.step_l(step_l[2]), .step_out(step_out[2])
			);
	step_unit	step3 (
				.baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
				.disable_event(disable_event), .spas(spas), .evclr(evclr),
				.seqrst(seqrst), .step_en(step_en[3]), .use_event(use_event[3]),
				.step_l(), .step_out(step_out[3])
			);

// ------------------------------------------------------------------------------------------------------
// step/seqin enable											-
// ------------------------------------------------------------------------------------------------------
	assign	step_en[0] = seqmode;						//           en(1)
	assign	step_en[1] = seqmode & (seqen[0] ? step_en[0] : step_out[0]);	// osel(1) & en(2)
	assign	step_en[2] = seqmode & (seqen[1] ? step_en[1] : step_out[1]);	// osel(2) & en(3)
	assign	step_en[3] = seqmode & (seqen[2] ? step_en[2] : step_out[2]);	// osel(3) & en(4)
	assign	spas       = seqmode & (seqen[3] ? step_en[3] : step_out[3]);	// osel(4)

	assign	seqin_en[0] = seqmode;
	assign	seqin_en[1] = seqen[0] ? seqin_en[0] : step_l[0];	// (seqmode=0だとstep_lは0固定)
	assign	seqin_en[2] = seqen[1] ? seqin_en[1] : step_l[1];
	assign	seqin_en[3] = seqen[2] ? seqin_en[2] : step_l[2];

// ------------------------------------------------------------------------------------------------------
// PASCounter for sequential unit									-
// ------------------------------------------------------------------------------------------------------

	/* --------------------------------------------------------------------	*/
	/* CPU Reset時にはPASCounterはCountUpさせない.				*/
	/* spascnt==(seqpasdt-1)時はevent成立信号がthroughされるので,		*/
	/* event信号はeventr(統合器)で抑える.					*/
	/* breakなど,受側でひげのある信号を出してもでも問題ない作りになって	*/
	/* いれば,eventrでも切らずにひげのある信号を出力させ,受側でcpuresetb	*/
	/* を条件に入れて切り直してもらうことでeventのtimingを早められる.	*/
	/* --------------------------------------------------------------------	*/

	assign	spasclr = evclr | seqrst | seqpasclr_cs & icewr | ~sysrsoutb;
	always @( posedge baseck or posedge spasclr ) begin
		if (spasclr)	spascnt <= 8'b0;
		else if (cpuresetb) begin
			if ((spascnt == (seqpasdt-1)) & spas)
				spascnt <= 8'b0;
			else if (spas)
				spascnt <= spascnt+1;
		end
	end

	// ----------
	// detect out
	// ----------
	assign	spasout = (spascnt == (seqpasdt-1)) ? spas : 1'b0;

endmodule

// ======================================================================================================
// Select Input Event											=
// ======================================================================================================
module	seqin_unit (
		icewr, sysrsoutb, seqin_cs, seqin_en, detect_out, icedi,
		use_event, seqin_unit_ro
	);

	input		icewr, sysrsoutb, seqin_cs, seqin_en;
	input [15:0]	detect_out;
	input [15:0]	icedi;
	output		use_event;
	output [31:0]	seqin_unit_ro;

	reg [15:0]	seqin;
	reg [15:0]	seqin_out;


	assign	seqin_unit_ro = {16'b0, seqin};

	// --------------
	// SEQIN Register
	// --------------
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)	   seqin <= 16'b0;
		else if (seqin_cs) seqin <= icedi;
	end

	integer s;
	always @( seqin or detect_out ) begin
		for(s=0; s<16; s=s+1)
			seqin_out[s] = seqin[s] ? detect_out[s] : 1'b0;
	end

	assign	use_event = (seqin_out[0]  | seqin_out[1]  | seqin_out[2]  | seqin_out[3]  |
			     seqin_out[4]  | seqin_out[5]  | seqin_out[6]  | seqin_out[7]  |
			     seqin_out[8]  | seqin_out[9]  | seqin_out[10] | seqin_out[11] |
			     seqin_out[12] | seqin_out[13] | seqin_out[14] | seqin_out[15]) & seqin_en;

endmodule

// ======================================================================================================
// Step													=
// ======================================================================================================

/* ------------------------------------------------------------	*/
/* baseck	_|~|_|~|_|~|_|~|_|~|_				*/
/* use_event[2]	_|~~~|______					*/
/* use_event[3]	_|///|~~~|___					*/
/*		  ↑seqin_unitでstep_l(2)を使ってスルーを抑える	*/
/* step_l[2]	_____|~~~|_____					*/
/* step_out[2]	_|~~~~~~~|_____					*/
/*			 ↑spasでclear				*/
/* step_l[3]	_________↓____					*/
/* step_out[3]	_____|~~~|_____(=spas)				*/
/* ------------------------------------------------------------	*/

module	step_unit (
		baseck, sysrsoutb, cpuresetb, disable_event, spas,
		evclr, seqrst, step_en, use_event, step_l, step_out
	);

	input	baseck, sysrsoutb, cpuresetb, disable_event, spas, evclr, seqrst, step_en, use_event;
	output	step_l, step_out;

	reg	step_l;
	wire	step_clear;

	/* ------------------------------------------------------------------------------------ */
	/* ※ CPUリセット時にはstep_lはdisable条件もspasもuse_eventも受け付けない(無視する).	*/
	/*    但し,段が全段成立,且つPAS成立時はイベント成立信号がスルーされるので,		*/
	/*    event信号はeventr(統合器)で抑える.(すなわち,pasもstep_lもevent出力も無効にする.)	*/
	/*    breakなど,受け側でひげのある信号を出してもでも問題ない作りになっていれば,		*/
	/*    eventrでも切らずにひげのある信号を出力させ,受け側でcpuresetbを条件にいれて	*/
	/*    切りなおしてもらえればeventのtimingを早められる.					*/
	/* ------------------------------------------------------------------------------------ */

	assign	step_clear = evclr | seqrst | ~sysrsoutb;
	always @( posedge baseck or posedge step_clear ) begin
		if (step_clear)	step_l <= 1'b0;
		else if (cpuresetb) begin
			if (disable_event | spas)
				step_l <= 1'b0;
			else if (step_en & use_event)
				step_l <= 1'b1;
		end
	end

	assign	step_out = use_event & ~disable_event | step_l;

endmodule

// ======================================================================================================
// Event Integration											=
// ======================================================================================================

	/* --------------------------------------------------------------------------------------------	*/
	/* Eventが貼られた命令のPreFetchで(別要因による)Breakが発生した場合,				*/
	/* ・Break=UserBreak => UserBreak時はPreFetch側がmaskされるので問題ない.			*/
	/* ・Break=一瞬Break => Event受付時点では一瞬BreakなのでEventが発生.		 		*/
	/* 　>EventがUserBreakEventの場合,								*/
	/*    一瞬BreakによるBreak中に要因が立ち,その後SVMODUSER=1に移行するのでRet後も要因が立つ.	*/
	/*   >Eventが一瞬BreakEventの場合,								*/
	/*    2番目の一瞬BreakがEventを貼った命令の実行前に処理されてしまう.				*/
	/* (AccessEventの場合,PreAccessは無いので問題なし.)						*/
	/* ->Break中に発生したFetchBreakEventは,Retするまで保留する. Accessは保留してもしなくてもOK.	*/
	/* --------------------------------------------------------------------------------------------	*/

module	integra	(
		icewr, baseck, sysrsoutb, cpuresetb, trcon, trcmd, svmod, eventr_cs, icedi, fpasout,
		apasout, spasout, brkevtl1, brkevtl0, brkevta7, brkevta6, brkevta5,
		brkevta4, brkevta3, brkevta2, brkevta1, brkevta0, brkevtf7, brkevtf6,
		brkevtf5, brkevtf4, brkevtf3, brkevtf2, brkevtf1, brkevtf0, evd,
		integra_ro
	);

	input		icewr, baseck , sysrsoutb, cpuresetb, trcon, trcmd, svmod;
	input [21:0]	eventr_cs;
	input [17:0]	icedi;
	input [7:0]	fpasout;
	input [7:0]	apasout;
	input [1:0]	spasout;
	output		brkevtl1, brkevtl0,
			brkevta7, brkevta6, brkevta5, brkevta4, brkevta3, brkevta2, brkevta1, brkevta0,
			brkevtf7, brkevtf6, brkevtf5, brkevtf4, brkevtf3, brkevtf2, brkevtf1, brkevtf0;
	output [21:1]	evd;
	output [31:0]	integra_ro;

	wire [31:0]	break_unit_ro,
			evd_unit_ro01, evd_unit_ro02, evd_unit_ro03, evd_unit_ro04,
			evd_unit_ro05, evd_unit_ro06, evd_unit_ro07, evd_unit_ro08,
			evd_unit_ro09, evd_unit_ro10, evd_unit_ro11, evd_unit_ro12,
			evd_unit_ro13, evd_unit_ro14, evd_unit_ro15, evd_unit_ro16,
			evd_unit_ro17, evd_unit_ro18, evd_unit_ro19, evd_unit_ro20,
			evd_unit_ro21;
	wire		sec_qualify;

	assign	sec_qualify = trcon & trcmd;

	assign	integra_ro = break_unit_ro |
			     evd_unit_ro01 | evd_unit_ro02 | evd_unit_ro03 | evd_unit_ro04 | 
			     evd_unit_ro05 | evd_unit_ro06 | evd_unit_ro07 | evd_unit_ro08 | 
			     evd_unit_ro09 | evd_unit_ro10 | evd_unit_ro11 | evd_unit_ro12 | 
			     evd_unit_ro13 | evd_unit_ro14 | evd_unit_ro15 | evd_unit_ro16 | 
			     evd_unit_ro17 | evd_unit_ro18 | evd_unit_ro19 | evd_unit_ro20 | 
			     evd_unit_ro21;

	reg svmod_l;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) svmod_l <= 1'b0;
		else		svmod_l <= svmod;
	end

	break_unit	break_unit (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[0]), .svmod(svmod), .svmod_l(svmod_l), .icedi(icedi),
		.fpasout(fpasout), .apasout(apasout), .spasout(spasout), .brkevtl1(brkevtl1),
		.brkevtl0(brkevtl0), .brkevta7(brkevta7), .brkevta6(brkevta6), .brkevta5(brkevta5),
		.brkevta4(brkevta4), .brkevta3(brkevta3), .brkevta2(brkevta2), .brkevta1(brkevta1),
		.brkevta0(brkevta0), .brkevtf7(brkevtf7), .brkevtf6(brkevtf6), .brkevtf5(brkevtf5),
		.brkevtf4(brkevtf4), .brkevtf3(brkevtf3), .brkevtf2(brkevtf2), .brkevtf1(brkevtf1),
		.brkevtf0(brkevtf0), .break_unit_ro(break_unit_ro)
	);

	/* delay event */
	evd_unit_trace	evd_unit01 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[1]), .trcon(trcon), .icedi(icedi), .fpasout(fpasout),
		.apasout(apasout), .spasout(spasout), .evd(evd[1]), .evd_unit_ro(evd_unit_ro01)
	);

	/* section1 start event */
	evd_unit_trace	evd_unit02 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[2]), .trcon(sec_qualify), .icedi(icedi), .fpasout(fpasout),
		.apasout(apasout), .spasout(spasout), .evd(evd[2]), .evd_unit_ro(evd_unit_ro02)
	);

	/* section1 end event */
	evd_unit_trace	evd_unit03 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[3]), .trcon(sec_qualify), .icedi(icedi), .fpasout(fpasout),
		.apasout(apasout), .spasout(spasout), .evd(evd[3]), .evd_unit_ro(evd_unit_ro03)
	);

	/* section2 start event */
	evd_unit_trace	evd_unit04 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[4]), .trcon(sec_qualify), .icedi(icedi), .fpasout(fpasout),
		.apasout(apasout), .spasout(spasout), .evd(evd[4]), .evd_unit_ro(evd_unit_ro04)
	);

	/* section2 end event */
	evd_unit_trace	evd_unit05 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[5]), .trcon(sec_qualify), .icedi(icedi), .fpasout(fpasout),
		.apasout(apasout), .spasout(spasout), .evd(evd[5]), .evd_unit_ro(evd_unit_ro05)
	);

	/* section3 start event */
	evd_unit_trace	evd_unit06 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[6]), .trcon(sec_qualify), .icedi(icedi), .fpasout(fpasout),
		.apasout(apasout), .spasout(spasout), .evd(evd[6]), .evd_unit_ro(evd_unit_ro06)
	);

	/* section3 end event */
	evd_unit_trace	evd_unit07 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[7]), .trcon(sec_qualify), .icedi(icedi), .fpasout(fpasout),
		.apasout(apasout), .spasout(spasout), .evd(evd[7]), .evd_unit_ro(evd_unit_ro07)
	);

	/* section4 start event */
	evd_unit_trace	evd_unit08 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[8]), .trcon(sec_qualify), .icedi(icedi), .fpasout(fpasout),
		.apasout(apasout), .spasout(spasout), .evd(evd[8]), .evd_unit_ro(evd_unit_ro08)
	);

	/* section4 end event */
	evd_unit_trace	evd_unit09 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[9]), .trcon(sec_qualify), .icedi(icedi), .fpasout(fpasout),
		.apasout(apasout), .spasout(spasout), .evd(evd[9]), .evd_unit_ro(evd_unit_ro09)
	);

	/* qualify event */
	evd_unit_trace	evd_unit10 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[10]), .trcon(sec_qualify), .icedi(icedi), .fpasout(fpasout),
		.apasout(apasout), .spasout(spasout), .evd(evd[10]), .evd_unit_ro(evd_unit_ro10)
	);

	/* timer1 start event */
	evd_unit	evd_unit11 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[11]), .icedi(icedi), .fpasout(fpasout), .apasout(apasout),
		.spasout(spasout), .evd(evd[11]), .evd_unit_ro(evd_unit_ro11)
	);

	/* timer1 end event */
	evd_unit	evd_unit12 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[12]), .icedi(icedi), .fpasout(fpasout), .apasout(apasout),
		.spasout(spasout), .evd(evd[12]), .evd_unit_ro(evd_unit_ro12)
	);

	/* timer2 start event */
	evd_unit	evd_unit13 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[13]), .icedi(icedi), .fpasout(fpasout), .apasout(apasout),
		.spasout(spasout), .evd(evd[13]), .evd_unit_ro(evd_unit_ro13)
	);

	/* timer2 end event */
	evd_unit	evd_unit14 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[14]), .icedi(icedi), .fpasout(fpasout), .apasout(apasout),
		.spasout(spasout), .evd(evd[14]), .evd_unit_ro(evd_unit_ro14)
	);

	/* dmm event1 */
	evd_unit_dmm	evd_unit15 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[15]), .svmod(svmod), .svmod_l(svmod_l), .icedi(icedi),
		.fpasout(fpasout), .apasout(apasout), .spasout(spasout), .evd(evd[15]),
		.evd_unit_ro(evd_unit_ro15)
	);

	/* dmm event2 */
	evd_unit_dmm	evd_unit16 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[16]), .svmod(svmod), .svmod_l(svmod_l), .icedi(icedi),
		.fpasout(fpasout), .apasout(apasout), .spasout(spasout), .evd(evd[16]),
		.evd_unit_ro(evd_unit_ro16)
	);

	/* dmm event3 */
	evd_unit_dmm	evd_unit17 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[17]), .svmod(svmod), .svmod_l(svmod_l), .icedi(icedi),
		.fpasout(fpasout), .apasout(apasout), .spasout(spasout), .evd(evd[17]),
		.evd_unit_ro(evd_unit_ro17)
	);

	/* dmm event4 */
	evd_unit_dmm	evd_unit18 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[18]), .svmod(svmod), .svmod_l(svmod_l), .icedi(icedi),
		.fpasout(fpasout), .apasout(apasout), .spasout(spasout), .evd(evd[18]),
		.evd_unit_ro(evd_unit_ro18)
	);

	/* snap event1 */
	evd_unit_snap	evd_unit19 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[19]), .trcon(trcon), .svmod(svmod), .svmod_l(svmod_l),
		.icedi(icedi), .fpasout(fpasout), .apasout(apasout), .spasout(spasout),
		.evd(evd[19]), .evd_unit_ro(evd_unit_ro19)
	);

	/* snap event2 */
	evd_unit_snap	evd_unit20 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[20]), .trcon(trcon), .svmod(svmod), .svmod_l(svmod_l),
		.icedi(icedi), .fpasout(fpasout), .apasout(apasout), .spasout(spasout),
		.evd(evd[20]), .evd_unit_ro(evd_unit_ro20)
	);

	/* snap event3 */
	evd_unit_snap	evd_unit21 (
		.icewr(icewr), .baseck(baseck), .sysrsoutb(sysrsoutb), .cpuresetb(cpuresetb),
		.eventr_cs(eventr_cs[21]), .trcon(trcon), .svmod(svmod), .svmod_l(svmod_l),
		.icedi(icedi), .fpasout(fpasout), .apasout(apasout), .spasout(spasout),
		.evd(evd[21]), .evd_unit_ro(evd_unit_ro21)
	);

endmodule

// ======================================================================================================
// evd output												=
// ======================================================================================================
module	evd_unit (
		icewr, baseck, sysrsoutb, cpuresetb, eventr_cs,
		icedi, fpasout, apasout, spasout, evd, evd_unit_ro
	);

	input	icewr, baseck, sysrsoutb, cpuresetb, eventr_cs;
	input [17:0]	icedi;
	input [7:0]	fpasout;
	input [7:0]	apasout;
	input [1:0]	spasout;
	output		evd;
	output [31:0]	evd_unit_ro;

	wire [17:0]	evdin;
	reg [17:0]	even_p, even;
	reg		evd;

	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)		even_p <=18'b0;
		else if (eventr_cs)	even_p <= icedi;
	end
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	even <= 18'b0;
		else		even <= even_p;
	end
	assign	evd_unit_ro = eventr_cs ? {14'b0, even} : 32'b0;

	assign	evdin[0]  = even[0] & fpasout[0];
	assign	evdin[1]  = even[1] & fpasout[1];
	assign	evdin[2]  = even[2] & fpasout[2];
	assign	evdin[3]  = even[3] & fpasout[3];
	assign	evdin[4]  = even[4] & fpasout[4];
	assign	evdin[5]  = even[5] & fpasout[5];
	assign	evdin[6]  = even[6] & fpasout[6];
	assign	evdin[7]  = even[7] & fpasout[7];
	assign	evdin[8]  = even[8] & apasout[0];
	assign	evdin[9]  = even[9] & apasout[1];
	assign	evdin[10] = even[10] & apasout[2];
	assign	evdin[11] = even[11] & apasout[3];
	assign	evdin[12] = even[12] & apasout[4];
	assign	evdin[13] = even[13] & apasout[5];
	assign	evdin[14] = even[14] & apasout[6];
	assign	evdin[15] = even[15] & apasout[7];
	assign	evdin[16] = even[16] & spasout[0];
	assign	evdin[17] = even[17] & spasout[1];

	/* ------------------------------------------------------------	*/
	/* ※ CPUReset時にはfpascnt,apascnt,spascntはCountUpさせない.	*/
	/*    但し,event成立信号はthroughされるので統合器で抑える.	*/
	/* ------------------------------------------------------------	*/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evd <= 1'b0;
		else if (!cpuresetb)
			evd <= 1'b0;	// とりあえずk0iecubeにならう
		else
			evd <= {evdin[0] | evdin[1] | evdin[2] | evdin[3] | evdin[4] | evdin[5] |
				evdin[6] | evdin[7] | evdin[8] | evdin[9] | evdin[10]| evdin[11]|
				evdin[12]| evdin[13]| evdin[14]| evdin[15]| evdin[16]| evdin[17]};
	end

endmodule

// ======================================================================================================
// evd output for dmm(EVD15-18)										=
// ======================================================================================================
module	evd_unit_dmm (
		icewr, baseck, sysrsoutb, cpuresetb, eventr_cs, svmod, svmod_l,
		icedi, fpasout, apasout, spasout, evd, evd_unit_ro
	);

	input	icewr, baseck, sysrsoutb, cpuresetb, eventr_cs, svmod, svmod_l;
	input [17:0]	icedi;
	input [7:0]	fpasout;
	input [7:0]	apasout;
	input [1:0]	spasout;
	output		evd;
	output [31:0]	evd_unit_ro;

	wire [17:0]	evdin;
	reg [17:0]	even_p, even;
	reg		evd;

	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)		even_p <=18'b0;
		else if (eventr_cs)	even_p <= icedi;
	end
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	even <= 18'b0;
		else		even <= even_p;
	end
	assign	evd_unit_ro = eventr_cs ? {14'b0, even} : 32'b0;

	assign	evdin[0]  = even[0]  & fpasout[0];
	assign	evdin[1]  = even[1]  & fpasout[1];
	assign	evdin[2]  = even[2]  & fpasout[2];
	assign	evdin[3]  = even[3]  & fpasout[3];
	assign	evdin[4]  = even[4]  & fpasout[4];
	assign	evdin[5]  = even[5]  & fpasout[5];
	assign	evdin[6]  = even[6]  & fpasout[6];
	assign	evdin[7]  = even[7]  & fpasout[7];
	assign	evdin[8]  = even[8]  & apasout[0];
	assign	evdin[9]  = even[9]  & apasout[1];
	assign	evdin[10] = even[10] & apasout[2];
	assign	evdin[11] = even[11] & apasout[3];
	assign	evdin[12] = even[12] & apasout[4];
	assign	evdin[13] = even[13] & apasout[5];
	assign	evdin[14] = even[14] & apasout[6];
	assign	evdin[15] = even[15] & apasout[7];
	assign	evdin[16] = even[16] & spasout[0];
	assign	evdin[17] = even[17] & spasout[1];

	event_shift_evd event_shift0 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[0]), .even(even[0]), .evdout(evdin0_f)
	);
	event_shift_evd event_shift1 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[1]), .even(even[1]), .evdout(evdin1_f)
	);
	event_shift_evd event_shift2 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[2]), .even(even[2]), .evdout(evdin2_f)
	);
	event_shift_evd event_shift3 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[3]), .even(even[3]), .evdout(evdin3_f)
	);
	event_shift_evd event_shift4 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[4]), .even(even[4]), .evdout(evdin4_f)
	);
	event_shift_evd event_shift5 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[5]), .even(even[5]), .evdout(evdin5_f)
	);
	event_shift_evd event_shift6 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[6]), .even(even[6]), .evdout(evdin6_f)
	);
	event_shift_evd event_shift7 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[7]), .even(even[7]), .evdout(evdin7_f)
	);
	event_shift_evd event_shift8 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[16]), .even(even[16]), .evdout(evdin16_f)
	);
	event_shift_evd event_shift9 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[17]), .even(even[17]), .evdout(evdin17_f)
	);

	/* ------------------------------------------------------------	*/
	/* ※ CPUReset時にはfpascnt,apascnt,spascntはCountUpさせない.	*/
	/*    但し,event成立信号はthroughされるので統合器で抑える.	*/
	/* ------------------------------------------------------------	*/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evd <= 1'b0;
		else if (!cpuresetb)
			evd <= 1'b0;	// とりあえずk0iecubeにならう
		else
			evd <= {evdin0_f | evdin1_f | evdin2_f | evdin3_f | evdin4_f | evdin5_f |
				evdin6_f | evdin7_f | evdin[8] | evdin[9] | evdin[10]| evdin[11]|
				evdin[12]| evdin[13]| evdin[14]| evdin[15]| evdin16_f| evdin17_f};
	end

endmodule

// ======================================================================================================
// evd output for delay(EVD01), section(EVD02-EVD09), qualify(EVD10)					=
// ======================================================================================================
module	evd_unit_trace (
		icewr, baseck, sysrsoutb, cpuresetb, eventr_cs, trcon,
		icedi, fpasout, apasout, spasout, evd, evd_unit_ro
	);

	input	icewr, baseck, sysrsoutb, cpuresetb, eventr_cs, trcon;
	input [17:0]	icedi;
	input [7:0]	fpasout;
	input [7:0]	apasout;
	input [1:0]	spasout;
	output		evd;
	output [31:0]	evd_unit_ro;

	wire [17:0]	evdin;
	reg [17:0]	even_p, even;
	reg		evd;

	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)		even_p <=18'b0;
		else if (eventr_cs)	even_p <= icedi;
	end
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	even <= 18'b0;
		else		even <= even_p;
	end
	assign	evd_unit_ro = eventr_cs ? {14'b0, even} : 32'b0;

	assign	evdin[0]  = even[0] & fpasout[0];
	assign	evdin[1]  = even[1] & fpasout[1];
	assign	evdin[2]  = even[2] & fpasout[2];
	assign	evdin[3]  = even[3] & fpasout[3];
	assign	evdin[4]  = even[4] & fpasout[4];
	assign	evdin[5]  = even[5] & fpasout[5];
	assign	evdin[6]  = even[6] & fpasout[6];
	assign	evdin[7]  = even[7] & fpasout[7];
	assign	evdin[8]  = even[8] & apasout[0];
	assign	evdin[9]  = even[9] & apasout[1];
	assign	evdin[10] = even[10] & apasout[2];
	assign	evdin[11] = even[11] & apasout[3];
	assign	evdin[12] = even[12] & apasout[4];
	assign	evdin[13] = even[13] & apasout[5];
	assign	evdin[14] = even[14] & apasout[6];
	assign	evdin[15] = even[15] & apasout[7];
	assign	evdin[16] = even[16] & spasout[0];
	assign	evdin[17] = even[17] & spasout[1];

	/* ------------------------------------------------------------	*/
	/* ※ CPUReset時にはfpascnt,apascnt,spascntはCountUpさせない.	*/
	/*    但し,event成立信号はthroughされるので統合器で抑える.	*/
	/* ------------------------------------------------------------	*/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evd <= 1'b0;
		else if (!cpuresetb)
			evd <= 1'b0;	// とりあえずk0iecubeにならう
		else if (trcon)
			evd <= (evdin[0] | evdin[1] | evdin[2] | evdin[3] | evdin[4] | evdin[5] |
				evdin[6] | evdin[7] | evdin[8] | evdin[9] | evdin[10]| evdin[11]|
				evdin[12]| evdin[13]| evdin[14]| evdin[15]| evdin[16]| evdin[17]);
		else	evd <= 1'b0;
	end

endmodule

// ======================================================================================================
// evd output for snap(EVD19-21)									=
// ======================================================================================================
module	evd_unit_snap (
		icewr, baseck, sysrsoutb, cpuresetb, eventr_cs, trcon, svmod, svmod_l,
		icedi, fpasout, apasout, spasout, evd, evd_unit_ro
	);

	input	icewr, baseck, sysrsoutb, cpuresetb, eventr_cs, trcon, svmod, svmod_l;
	input [17:0]	icedi;
	input [7:0]	fpasout;
	input [7:0]	apasout;
	input [1:0]	spasout;
	output		evd;
	output [31:0]	evd_unit_ro;

	wire [17:0]	evdin;
	reg [17:0]	even_p, even;
	reg		evd;

	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)		even_p <=18'b0;
		else if (eventr_cs)	even_p <= icedi;
	end
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	even <= 18'b0;
		else		even <= even_p;
	end
	assign	evd_unit_ro = eventr_cs ? {14'b0, even} : 32'b0;

	assign	evdin[0]  = even[0]  & fpasout[0];
	assign	evdin[1]  = even[1]  & fpasout[1];
	assign	evdin[2]  = even[2]  & fpasout[2];
	assign	evdin[3]  = even[3]  & fpasout[3];
	assign	evdin[4]  = even[4]  & fpasout[4];
	assign	evdin[5]  = even[5]  & fpasout[5];
	assign	evdin[6]  = even[6]  & fpasout[6];
	assign	evdin[7]  = even[7]  & fpasout[7];
	assign	evdin[8]  = even[8]  & apasout[0];
	assign	evdin[9]  = even[9]  & apasout[1];
	assign	evdin[10] = even[10] & apasout[2];
	assign	evdin[11] = even[11] & apasout[3];
	assign	evdin[12] = even[12] & apasout[4];
	assign	evdin[13] = even[13] & apasout[5];
	assign	evdin[14] = even[14] & apasout[6];
	assign	evdin[15] = even[15] & apasout[7];
	assign	evdin[16] = even[16] & spasout[0];
	assign	evdin[17] = even[17] & spasout[1];

	event_shift_evd event_shift0 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[0]), .even(even[0]), .evdout(evdin0_f)
	);
	event_shift_evd event_shift1 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[1]), .even(even[1]), .evdout(evdin1_f)
	);
	event_shift_evd event_shift2 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[2]), .even(even[2]), .evdout(evdin2_f)
	);
	event_shift_evd event_shift3 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[3]), .even(even[3]), .evdout(evdin3_f)
	);
	event_shift_evd event_shift4 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[4]), .even(even[4]), .evdout(evdin4_f)
	);
	event_shift_evd event_shift5 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[5]), .even(even[5]), .evdout(evdin5_f)
	);
	event_shift_evd event_shift6 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[6]), .even(even[6]), .evdout(evdin6_f)
	);
	event_shift_evd event_shift7 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[7]), .even(even[7]), .evdout(evdin7_f)
	);
	event_shift_evd event_shift8 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[16]), .even(even[16]), .evdout(evdin16_f)
	);
	event_shift_evd event_shift9 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[17]), .even(even[17]), .evdout(evdin17_f)
	);

	/* ------------------------------------------------------------	*/
	/* ※ CPUReset時にはfpascnt,apascnt,spascntはCountUpさせない.	*/
	/*    但し,event成立信号はthroughされるので統合器で抑える.	*/
	/* ------------------------------------------------------------	*/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evd <= 1'b0;
		else if (!cpuresetb)
			evd <= 1'b0;	// とりあえずk0iecubeにならう
		else if (trcon)
			evd <= {evdin0_f | evdin1_f | evdin2_f | evdin3_f | evdin4_f | evdin5_f |
				evdin6_f | evdin7_f | evdin[8] | evdin[9] | evdin[10]| evdin[11]|
				evdin[12]| evdin[13]| evdin[14]| evdin[15]| evdin16_f| evdin17_f};
		else	evd <= 1'b0;
	end

endmodule

// ======================================================================================================
// break event output											=
// ======================================================================================================
module	break_unit (
		icewr, baseck, sysrsoutb, cpuresetb, eventr_cs, svmod, svmod_l,
		icedi, fpasout, apasout, spasout,
		brkevtl1, brkevtl0,
		brkevta7, brkevta6, brkevta5, brkevta4, brkevta3, brkevta2, brkevta1, brkevta0,
		brkevtf7, brkevtf6, brkevtf5, brkevtf4, brkevtf3, brkevtf2, brkevtf1, brkevtf0,
		break_unit_ro
	);

	input	icewr, baseck, sysrsoutb, cpuresetb, eventr_cs, svmod, svmod_l;
	input [17:0]	icedi;
	input [7:0]	fpasout;
	input [7:0]	apasout;
	input [1:0]	spasout;
	output		brkevtl1, brkevtl0;
	output		brkevta7, brkevta6, brkevta5, brkevta4, brkevta3, brkevta2, brkevta1, brkevta0;
	output		brkevtf7, brkevtf6, brkevtf5, brkevtf4, brkevtf3, brkevtf2, brkevtf1, brkevtf0;
	output [31:0]	break_unit_ro;
	
	wire [17:0]	evdin;
	reg [17:0]	even_p, even;
	reg [7:0]	evd;
	
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)		even_p <=18'b0;
		else if (eventr_cs)	even_p <= icedi;
	end
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	even <= 18'b0;
		else		even <= even_p;
	end
	assign	break_unit_ro = eventr_cs ? {14'b0, even} : 32'b0;
	
	assign	evdin[0]  = even[0]  & fpasout[0];
	assign	evdin[1]  = even[1]  & fpasout[1];
	assign	evdin[2]  = even[2]  & fpasout[2];
	assign	evdin[3]  = even[3]  & fpasout[3];
	assign	evdin[4]  = even[4]  & fpasout[4];
	assign	evdin[5]  = even[5]  & fpasout[5];
	assign	evdin[6]  = even[6]  & fpasout[6];
	assign	evdin[7]  = even[7]  & fpasout[7];
	assign	evdin[8]  = even[8]  & apasout[0];
	assign	evdin[9]  = even[9]  & apasout[1];
	assign	evdin[10] = even[10] & apasout[2];
	assign	evdin[11] = even[11] & apasout[3];
	assign	evdin[12] = even[12] & apasout[4];
	assign	evdin[13] = even[13] & apasout[5];
	assign	evdin[14] = even[14] & apasout[6];
	assign	evdin[15] = even[15] & apasout[7];
	assign	evdin[16] = even[16] & spasout[0];
	assign	evdin[17] = even[17] & spasout[1];
	
	event_shift_break event_shift0 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[0]), .even(even[0]), .evdout(brkevtf0)
	);
	event_shift_break event_shift1 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[1]), .even(even[1]), .evdout(brkevtf1)
	);
	event_shift_break event_shift2 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[2]), .even(even[2]), .evdout(brkevtf2)
	);
	event_shift_break event_shift3 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[3]), .even(even[3]), .evdout(brkevtf3)
	);
	event_shift_break event_shift4 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[4]), .even(even[4]), .evdout(brkevtf4)
	);
	event_shift_break event_shift5 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[5]), .even(even[5]), .evdout(brkevtf5)
	);
	event_shift_break event_shift6 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[6]), .even(even[6]), .evdout(brkevtf6)
	);
	event_shift_break event_shift7 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[7]), .even(even[7]), .evdout(brkevtf7)
	);
	event_shift_break event_shift8 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[16]), .even(even[16]), .evdout(brkevtl0)
	);
	event_shift_break event_shift9 (
		.baseck(baseck), .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb), .svmod(svmod),
		.svmod_l(svmod_l), .evdin(evdin[17]), .even(even[17]), .evdout(brkevtl1)
	);

	/* ------------------------------------------------------------	*/
	/* ※ CPUReset時にはfpascnt,apascnt,spascntはCountUpさせない.	*/
	/*    但し,event成立信号はthroughされるので統合器で抑える.	*/
	/* ------------------------------------------------------------	*/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)		evd <= 8'b0;
		else if (!cpuresetb)	evd <= 8'b0;	// とりあえずk0iecubeにならう.cpuresetでヒゲにしない.
		else			evd <= evdin[15:8];
	end
	
	assign	{brkevta7, brkevta6, brkevta5, brkevta4, brkevta3, brkevta2, brkevta1, brkevta0}
		= evd;
	
endmodule

// ======================================================================================================
// Shift the Break Event On SVMOD									=
// ======================================================================================================
module event_shift_break ( baseck, cpuresetb, sysrsoutb, svmod, svmod_l, evdin, even, evdout );
	input	baseck, cpuresetb, sysrsoutb, svmod, svmod_l, evdin, even;
	output	evdout;
	
	reg evdin_l1, evdin_l2, evdout;
	always @( posedge baseck or negedge cpuresetb ) begin
		if (!cpuresetb)			evdin_l1 <= 1'b0;
		else if (svmod && !svmod_l)	evdin_l1 <= evdin;
		else if (!svmod && svmod_l)	evdin_l1 <= 1'b0;
	end
	always @( posedge baseck or negedge cpuresetb ) begin
		if (!cpuresetb)			evdin_l2 <= 1'b0;
		else if (!svmod && svmod_l)	evdin_l2 <= evdin_l1;
		else				evdin_l2 <= 1'b0;
	end
	
	/* ----------------------------------------------------	*/
	/* 保留中のEventが解除された場合に,			*/
	/* 保留されたEventをCancelする為に,evenを使用する.	*/
	/* ----------------------------------------------------	*/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)		evdout <= 1'b0;
		else if (!cpuresetb)	evdout <= 1'b0;
		else			evdout <= ((~svmod & evdin) | (even & evdin_l2));
	end

endmodule

// ======================================================================================================
// Shift the Break Event On SVMOD									=
// ======================================================================================================
module event_shift_evd ( baseck, cpuresetb, sysrsoutb, svmod, svmod_l, evdin, even, evdout );
	input	baseck, cpuresetb, sysrsoutb, svmod, svmod_l, evdin, even;
	output	evdout;
	
	reg evdin_l1, evdin_l2;
	always @( posedge baseck or negedge cpuresetb ) begin
		if (!cpuresetb)			evdin_l1 <= 1'b0;
		else if (svmod && !svmod_l)	evdin_l1 <= evdin;
		else if (!svmod && svmod_l)	evdin_l1 <= 1'b0;
	end
	always @( posedge baseck or negedge cpuresetb ) begin
		if (!cpuresetb)			evdin_l2 <= 1'b0;
		else if (!svmod && svmod_l)	evdin_l2 <= evdin_l1;
		else				evdin_l2 <= 1'b0;
	end
	
	/* ----------------------------------------------------	*/
	/* 保留中のEventが解除された場合に,			*/
	/* 保留されたEventをCancelする為に,evenを使用する.	*/
	/* ----------------------------------------------------	*/
	assign	evdout =  ((~svmod & evdin) | (even & evdin_l2));

endmodule

// ======================================================================================================
// cs													=
// ======================================================================================================
module	event_cs (
		iceifa, fadr_cs, fpasevt_cs, fevtpasclr_cs, fpascntrd_cs, aadr_cs, adtr_cs, adtmkr_cs,
		apasevt_cs, aevtpasclr_cs, apascntrd_cs, seqin_cs, seqctc_cs, evtclr0_cs, seqpasclr_cs,
		spascntrd_cs, eventr_cs
		);

	input [31:2]	iceifa;
	output [7:0]	fadr_cs;
	output [7:0]	fpasevt_cs;
	output [7:0]	fevtpasclr_cs;
	output [7:0]	fpascntrd_cs;
	output [7:0]	aadr_cs;
	output [7:0]	adtr_cs;
	output [7:0]	adtmkr_cs;
	output [7:0]	apasevt_cs;
	output [7:0]	aevtpasclr_cs;
	output [7:0]	apascntrd_cs;
	output [9:0]	seqin_cs;
	output [1:0]	seqctc_cs;
	output		evtclr0_cs;
	output [1:0]	seqpasclr_cs;
	output [1:0]	spascntrd_cs;
	output [21:0]	eventr_cs;

	wire		event_cs, fevent_cs, aevent_cs, link_cs, integra_cs;

	assign	event_cs	= (iceifa[31:16] == 16'h0810) ? 1'b1:1'b0;
	assign	fevent_cs	= (iceifa[15:12] == 4'h0) ? 1'b1:1'b0;
	assign	aevent_cs	= (iceifa[15:12] == 4'h1) ? 1'b1:1'b0;
	assign	link_cs		= (iceifa[15:12] == 4'h2) ? 1'b1:1'b0;
	assign	integra_cs	= (iceifa[15:12] == 4'h3) ? 1'b1:1'b0;

	assign	fadr_cs[0]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h000)) ? 1'b1:1'b0;
	assign	fadr_cs[1]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h001)) ? 1'b1:1'b0;
	assign	fadr_cs[2]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h002)) ? 1'b1:1'b0;
	assign	fadr_cs[3]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h003)) ? 1'b1:1'b0;
	assign	fadr_cs[4]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h004)) ? 1'b1:1'b0;
	assign	fadr_cs[5]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h005)) ? 1'b1:1'b0;
	assign	fadr_cs[6]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h006)) ? 1'b1:1'b0;
	assign	fadr_cs[7]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h007)) ? 1'b1:1'b0;

	assign	fpasevt_cs[0]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h040)) ? 1'b1:1'b0;
	assign	fpasevt_cs[1]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h041)) ? 1'b1:1'b0;
	assign	fpasevt_cs[2]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h042)) ? 1'b1:1'b0;
	assign	fpasevt_cs[3]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h043)) ? 1'b1:1'b0;
	assign	fpasevt_cs[4]	= (event_cs & fevent_cs & (iceifa[11:2]	== 10'h044)) ? 1'b1:1'b0;
	assign	fpasevt_cs[5]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h045)) ? 1'b1:1'b0;
	assign	fpasevt_cs[6]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h046)) ? 1'b1:1'b0;
	assign	fpasevt_cs[7]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h047)) ? 1'b1:1'b0;

	assign	fevtpasclr_cs[0]= (event_cs & fevent_cs & (iceifa[11:2] == 10'h080)) ? 1'b1:1'b0;
	assign	fevtpasclr_cs[1]= (event_cs & fevent_cs & (iceifa[11:2] == 10'h081)) ? 1'b1:1'b0;
	assign	fevtpasclr_cs[2]= (event_cs & fevent_cs & (iceifa[11:2] == 10'h082)) ? 1'b1:1'b0;
	assign	fevtpasclr_cs[3]= (event_cs & fevent_cs & (iceifa[11:2] == 10'h083)) ? 1'b1:1'b0;
	assign	fevtpasclr_cs[4]= (event_cs & fevent_cs & (iceifa[11:2]	== 10'h084)) ? 1'b1:1'b0;
	assign	fevtpasclr_cs[5]= (event_cs & fevent_cs & (iceifa[11:2] == 10'h085)) ? 1'b1:1'b0;
	assign	fevtpasclr_cs[6]= (event_cs & fevent_cs & (iceifa[11:2] == 10'h086)) ? 1'b1:1'b0;
	assign	fevtpasclr_cs[7]= (event_cs & fevent_cs & (iceifa[11:2] == 10'h087)) ? 1'b1:1'b0;

	assign	fpascntrd_cs[0]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h0c0)) ? 1'b1:1'b0;
	assign	fpascntrd_cs[1]	= (event_cs & fevent_cs & (iceifa[11:2]	== 10'h0c1)) ? 1'b1:1'b0;
	assign	fpascntrd_cs[2]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h0c2)) ? 1'b1:1'b0;
	assign	fpascntrd_cs[3]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h0c3)) ? 1'b1:1'b0;
	assign	fpascntrd_cs[4] = (event_cs & fevent_cs & (iceifa[11:2] == 10'h0c4)) ? 1'b1:1'b0;
	assign	fpascntrd_cs[5]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h0c5)) ? 1'b1:1'b0;
	assign	fpascntrd_cs[6]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h0c6)) ? 1'b1:1'b0;
	assign	fpascntrd_cs[7]	= (event_cs & fevent_cs & (iceifa[11:2] == 10'h0c7)) ? 1'b1:1'b0;

	assign	aadr_cs[0]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h000)) ? 1'b1:1'b0;
	assign	aadr_cs[1]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h001)) ? 1'b1:1'b0;
	assign	aadr_cs[2]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h002)) ? 1'b1:1'b0;
	assign	aadr_cs[3]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h003)) ? 1'b1:1'b0;
	assign	aadr_cs[4]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h004)) ? 1'b1:1'b0;
	assign	aadr_cs[5]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h005)) ? 1'b1:1'b0;
	assign	aadr_cs[6]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h006)) ? 1'b1:1'b0;
	assign	aadr_cs[7]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h007)) ? 1'b1:1'b0;

	assign	adtr_cs[0]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h040)) ? 1'b1:1'b0;
	assign	adtr_cs[1]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h041)) ? 1'b1:1'b0;
	assign	adtr_cs[2]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h042)) ? 1'b1:1'b0;
	assign	adtr_cs[3]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h043)) ? 1'b1:1'b0;
	assign	adtr_cs[4]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h044)) ? 1'b1:1'b0;
	assign	adtr_cs[5]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h045)) ? 1'b1:1'b0;
	assign	adtr_cs[6]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h046)) ? 1'b1:1'b0;
	assign	adtr_cs[7]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h047)) ? 1'b1:1'b0;

	assign	adtmkr_cs[0]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h080)) ? 1'b1:1'b0;
	assign	adtmkr_cs[1]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h081)) ? 1'b1:1'b0;
	assign	adtmkr_cs[2]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h082)) ? 1'b1:1'b0;
	assign	adtmkr_cs[3]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h083)) ? 1'b1:1'b0;
	assign	adtmkr_cs[4]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h084)) ? 1'b1:1'b0;
	assign	adtmkr_cs[5]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h085)) ? 1'b1:1'b0;
	assign	adtmkr_cs[6]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h086)) ? 1'b1:1'b0;
	assign	adtmkr_cs[7]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h087)) ? 1'b1:1'b0;

	assign	apasevt_cs[0]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h0c0)) ? 1'b1:1'b0;
	assign	apasevt_cs[1]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h0c1)) ? 1'b1:1'b0;
	assign	apasevt_cs[2]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h0c2)) ? 1'b1:1'b0;
	assign	apasevt_cs[3]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h0c3)) ? 1'b1:1'b0;
	assign	apasevt_cs[4]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h0c4)) ? 1'b1:1'b0;
	assign	apasevt_cs[5]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h0c5)) ? 1'b1:1'b0;
	assign	apasevt_cs[6]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h0c6)) ? 1'b1:1'b0;
	assign	apasevt_cs[7]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h0c7)) ? 1'b1:1'b0;

	assign	aevtpasclr_cs[0]= (event_cs & aevent_cs & (iceifa[11:2] == 10'h100)) ? 1'b1:1'b0;
	assign	aevtpasclr_cs[1]= (event_cs & aevent_cs & (iceifa[11:2] == 10'h101)) ? 1'b1:1'b0;
	assign	aevtpasclr_cs[2]= (event_cs & aevent_cs & (iceifa[11:2] == 10'h102)) ? 1'b1:1'b0;
	assign	aevtpasclr_cs[3]= (event_cs & aevent_cs & (iceifa[11:2] == 10'h103)) ? 1'b1:1'b0;
	assign	aevtpasclr_cs[4]= (event_cs & aevent_cs & (iceifa[11:2] == 10'h104)) ? 1'b1:1'b0;
	assign	aevtpasclr_cs[5]= (event_cs & aevent_cs & (iceifa[11:2] == 10'h105)) ? 1'b1:1'b0;
	assign	aevtpasclr_cs[6]= (event_cs & aevent_cs & (iceifa[11:2] == 10'h106)) ? 1'b1:1'b0;
	assign	aevtpasclr_cs[7]= (event_cs & aevent_cs & (iceifa[11:2] == 10'h107)) ? 1'b1:1'b0;

	assign	apascntrd_cs[0]	= (event_cs & aevent_cs & (iceifa[11:2] == 10'h140)) ? 1'b1:1'b0;
	assign	apascntrd_cs[1] = (event_cs & aevent_cs & (iceifa[11:2] == 10'h141)) ? 1'b1:1'b0;
	assign	apascntrd_cs[2] = (event_cs & aevent_cs & (iceifa[11:2] == 10'h142)) ? 1'b1:1'b0;
	assign	apascntrd_cs[3] = (event_cs & aevent_cs & (iceifa[11:2] == 10'h143)) ? 1'b1:1'b0;
	assign	apascntrd_cs[4] = (event_cs & aevent_cs & (iceifa[11:2] == 10'h144)) ? 1'b1:1'b0;
	assign	apascntrd_cs[5] = (event_cs & aevent_cs & (iceifa[11:2] == 10'h145)) ? 1'b1:1'b0;
	assign	apascntrd_cs[6] = (event_cs & aevent_cs & (iceifa[11:2] == 10'h146)) ? 1'b1:1'b0;
	assign	apascntrd_cs[7] = (event_cs & aevent_cs & (iceifa[11:2] == 10'h147)) ? 1'b1:1'b0;

	assign	seqin_cs[0]	= (event_cs & link_cs & (iceifa[11:2] == 10'h000)) ? 1'b1:1'b0;
	assign	seqin_cs[1]	= (event_cs & link_cs & (iceifa[11:2] == 10'h001)) ? 1'b1:1'b0;
	assign	seqin_cs[2]	= (event_cs & link_cs & (iceifa[11:2] == 10'h002)) ? 1'b1:1'b0;
	assign	seqin_cs[3]	= (event_cs & link_cs & (iceifa[11:2] == 10'h003)) ? 1'b1:1'b0;
	assign	seqin_cs[4]	= (event_cs & link_cs & (iceifa[11:2] == 10'h004)) ? 1'b1:1'b0;
	assign	seqin_cs[5]	= (event_cs & link_cs & (iceifa[11:2] == 10'h005)) ? 1'b1:1'b0;
	assign	seqin_cs[6]	= (event_cs & link_cs & (iceifa[11:2] == 10'h006)) ? 1'b1:1'b0;
	assign	seqin_cs[7]	= (event_cs & link_cs & (iceifa[11:2] == 10'h007)) ? 1'b1:1'b0;
	assign	seqin_cs[8]	= (event_cs & link_cs & (iceifa[11:2] == 10'h008)) ? 1'b1:1'b0;
	assign	seqin_cs[9]	= (event_cs & link_cs & (iceifa[11:2] == 10'h009)) ? 1'b1:1'b0;

	assign	seqctc_cs[0]	= (event_cs & link_cs & (iceifa[11:2] == 10'h040)) ? 1'b1:1'b0;
	assign	seqctc_cs[1]	= (event_cs & link_cs & (iceifa[11:2] == 10'h041)) ? 1'b1:1'b0;

	assign	evtclr0_cs	= (event_cs & link_cs & (iceifa[11:2] == 10'h080)) ? 1'b1:1'b0;

	assign	seqpasclr_cs[0]	= (event_cs & link_cs & (iceifa[11:2] == 10'h0c0)) ? 1'b1:1'b0;
	assign	seqpasclr_cs[1]	= (event_cs & link_cs & (iceifa[11:2] == 10'h0c1)) ? 1'b1:1'b0;

	assign	spascntrd_cs[0]	= (event_cs & link_cs & (iceifa[11:2] == 10'h100)) ? 1'b1:1'b0;
	assign	spascntrd_cs[1]	= (event_cs & link_cs & (iceifa[11:2] == 10'h101)) ? 1'b1:1'b0;

	assign	eventr_cs[0]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h000)) ? 1'b1:1'b0;
	assign	eventr_cs[1]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h001)) ? 1'b1:1'b0;
	assign	eventr_cs[2]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h002)) ? 1'b1:1'b0;
	assign	eventr_cs[3]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h003)) ? 1'b1:1'b0;
	assign	eventr_cs[4]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h004)) ? 1'b1:1'b0;
	assign	eventr_cs[5]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h005)) ? 1'b1:1'b0;
	assign	eventr_cs[6]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h006)) ? 1'b1:1'b0;
	assign	eventr_cs[7]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h007)) ? 1'b1:1'b0;
	assign	eventr_cs[8]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h008)) ? 1'b1:1'b0;
	assign	eventr_cs[9]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h009)) ? 1'b1:1'b0;
	assign	eventr_cs[10]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h00a)) ? 1'b1:1'b0;
	assign	eventr_cs[11]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h00b)) ? 1'b1:1'b0;
	assign	eventr_cs[12]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h00c)) ? 1'b1:1'b0;
	assign	eventr_cs[13]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h00d)) ? 1'b1:1'b0;
	assign	eventr_cs[14]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h00e)) ? 1'b1:1'b0;
	assign	eventr_cs[15]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h00f)) ? 1'b1:1'b0;
	assign	eventr_cs[16]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h010)) ? 1'b1:1'b0;
	assign	eventr_cs[17]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h011)) ? 1'b1:1'b0;
	assign	eventr_cs[18]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h012)) ? 1'b1:1'b0;
	assign	eventr_cs[19]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h013)) ? 1'b1:1'b0;
	assign	eventr_cs[20]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h014)) ? 1'b1:1'b0;
	assign	eventr_cs[21]	= (event_cs & integra_cs & (iceifa[11:2] == 10'h015)) ? 1'b1:1'b0;

endmodule
