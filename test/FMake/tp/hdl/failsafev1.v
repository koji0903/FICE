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
/* Note		: (1)NPB$BBP1~$N=$@5(B						*/
/*		: WAITEXM$B3h@82=;~$K8mF0:n$9$kLdBj$r=$@5!#(BOCDWAIT$B$NO@M}$+$i(B		*/
/*		: WAITEXM$B$r=|30$9$k$h$&$KJQ99!#(B					*/
/*		: (2)Nonmap$BEy$,H/@8$9$Y$->r7o$G(BSOFTBRK$B$N$_H/@8$9$kLdBj$r=$@5(B		*/
/*		: SoftwareBreak$B$H(BNonmapFetch,FetchProtect,PeripheralProtect	*/
/*		: $B$,6%9g$7$?>l9g!"(BSoftwareBreak$B$N$_8!=P$5$l$kLdBj$r=$@5!#(B		*/
/*		: SoftwareBreak$B$O(BID$B%9%F!<%8$G(BSOFTBRK$B$r(BActive$B$K$9$k$N$HF1;~$K(B	*/
/*		: SVMOD$B$r(BActive$B$K$9$k!#(BFailsafe$B$O(BID$B%9%F!<%8$G(BSVMOD$B$r8+$F<!(Bclock	*/
/*		: $B$G(BBreak$B?.9f$r=PNO$9$k$N$,860x!#(B					*/
/********************************************************************************/
/* [Update Info]								*/
/* Data		: 2009/06/12							*/
/* Revision	: 1.46								*/
/* Designer	: T.Tsunoda							*/
/* Note		: 1.45(2)$B$K4X$9$kDI2C=$@5!#(B					*/
/*		: SOFTBRK$B$G(BSVMOD$B$r%^%9%/$7$?>l9g!$(BSVMOD$B$N%9%?%C%/%i%$%H$,(B		*/
/*		: FailSafe$B$NH=DjBP>]$H$J$C$F$7$^$&!#(BSOFTBRK$B$N%?%$%_%s%0$G$N(B		*/
/*		: $B%9%?%C%/%i%$%H$rL5;k$9$k$?$a$K!$(BNonmap$B$N%"%/%;%97O$N%V%l!<%/(B		*/
/*		: $BMW0x$K$O(BSOFTBRK$B$r;H$o$J$$9=@.$H$7$?!#(BFetch$B%V%l!<%/$O4X78$J$7!$(B	*/
/*		: Peripheral$B%V%l!<%/$OK\%^%/%m$G$OBP1~$G$-$J$$0YJQ99$J$7!#(B		*/
/********************************************************************************/
/* [Updata Info]								*/
/* Date		: 2009.7.14							*/
/* Revision	: 1.47								*/
/* Designer	: T.Tsunoda							*/
/* Note		: SP$BA`:n$H3d9~$_$,6%9g$7$?>l9g(B,PreFetch$B$7$?(BPC$B$,(BWait$B$5$l(B($B1d$S$k(B),	*/
/*		: PreFetch$B$,(Bfailsafe$B8!=PBP>]$H$J$kLdBj$r=$@5!#(B			*/
/*		: $BC"$7(B,FlashFetch,RAMFetch$B$K$OBP1~$7$?$,(B,EXMEMFetch$B$K$OL$BP1~(B	*/
/*		: $B$G(B,$B8eF|BP1~M=Dj!#(B						*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2009.9.18							*/
/* Revision	: 1.48								*/
/* Designer	: T.Tsunoda							*/
/* Note		: RAM->Flash,EXMEM->Flash$B$N(BBranch(BR$BL?Na8BDj(B)$B;~(B,$BIT@5$K(BRead$B%"%/(B	*/
/*		: $B%;%9$r8!=P$9$kIT6q9g$r=$@5!#(B					*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2010.3.25							*/
/* Revision	: 1.49								*/
/* Designer	: T.Tsunoda							*/
/* Note		: SS3rd$BBP1~(B.							*/
/*		: (1)Data Flash$B$K4X$9$k;EMM$rJQ99(B. SS2nd$B$G$O(BData Flash$B$,(BEXMEM	*/
/*		:   $B6u4V$K$"$C$?0Y(B,Data Flash$BHO0O$K(BEXMEM$BHO0O$r4XO"IU$1$F$$$?$,(B,	*/
/*		:   SS3rd$B$G$O(BMirror$B6u4V$KCV$+$l$k$?$a(B,EXMEM$B$H$N4XO"$r2r=|(B.		*/
/*		: (2)dfsize Resister$B$rDI2C(B.					*/
/*		: (3)Data Flash$B$+$i$N(BWord Read$B%W%m%F%/%H$rDI2C(B(SS3rd$BMQ(B).		*/
/*		: (4)failmk Register$B$K(Bbit14(Data Flash Word Read Mask)$B$rDI2C(B.	*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2010.3.29							*/
/* Revision	: 1.50								*/
/* Designer	: T.Tsunoda							*/
/* Note		: SS3rd$BBP1~(B.							*/
/*		: (1)mirror$B6u4V?.9f$+$i(Bdflash$B6u4V$r=|30$9$k$h$&JQ99(B.Function$BE*(B	*/
/*		: $B$K$OJQ99$J$7(B.							*/
/*		: (2)trace($B$J$I(B)$BMQ$K(BSELBRAMPC,SELBFAPC$B?.9f$r=PNO(B.			*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2010.3.30							*/
/* Revision	: 1.51								*/
/* Designer	: T.Tsunoda							*/
/* Note		: SS3rd$BBP1~(B.							*/
/*		: 1.48$B$HF1MM$N=$@5$r(B,Flash$B$G$O$J$/(BBFA$B$K$D$$$F=hCV(B.Firm$BI>2A$K$*(B	*/
/*		: $B$$$F(B,BRAM->BFA$B$N(Bbr,RAM->BFA$B$N(Bret$B$G9T$C$F$$$J$$(BRead$B%"%/%;%9$,(B	*/
/*		: $B8!=P$5$l$kLdBj$,Js9p$5$l$?$?$a(B.1.48$B$N(BCase$B$G$O(Bret$B;~$O(Bpcwaitf$B$K(B	*/
/*		: $B$h$j(Bmask$B$5$l$k$N$GLdBj$J$$$,(B,1.48$B$N=hCV$K$h$j(Bret$B;~$b(Bmask$B$5$l(B	*/
/*		: $B$k(B. BRAM,BFA$B$N>l9g$K$O(Bret$B$,(Bpcwaitf$B$K$h$j(Bmask$B$5$l$J$$$N$G$3$3(B	*/
/*		: $B$G$N=hCV$K$h$j(Bmask$B$5$l$k(B.$B$3$l$i$O(BSELF$BCf(B(selfmode$B?.9f$,(BActive)	*/
/*		: $B$K5/$k$3$N$G(B,$B%f!<%68+$($K$O1F6A$7$J$$(B.Firm,Library$B$J$I$NFbIt(B	*/
/*		: $BI>2AMQ$KITJX$J$?$aBP1~$9$k$,(B,$B=$@5FbMF$K4X$9$k(BTP$B$O:n@.$;$:(B,$BB>(B		*/
/*		: $B$N5!G=$K1F6A$7$J$$$3$H$r4{B8$N(BTP$B$G(Bdegrade$BI>2A$9$k$N$_$H$9$k(B.		*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2011.03.02							*/
/* Revision	: 1.52								*/
/* Designer	: T.Tsunoda							*/
/* Note		: sel_ram_ma, sel_dfad_ma$B$r(Bmacro$B$+$i=PNO(B($BB>$N(Bmacro$B$G;HMQ$9$k$?$a(B)$B!#(B	*/
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
wire [14:0]	failmk;	/* [V1.49] bit14$B$rDI2C(B */
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

	assign	nonmap_rom_fch	= fch & sel_nonmap_rom_pc;		/* nonmapROM$B7d4V(Bfetch */
	assign	nonmap_ram_fch	= fch & sel_nonmap_ram_pc;		/* nonmapRAM$B7d4V(Bfetch */
	assign	nonmap_exmem_fch= fch & sel_nonmap_exmem_pc;		/* nonmap$B30It@_DjHO0O30(Bfetch */
	assign	nonmap_rom_rw	= (rd | wr) & sel_nonmap_rom_ma;	/* nonmapROM$B7d4V(Baccess */
	assign	nonmap_mirror_rw = (rd | wr) & sel_nonmap_mirror_maa;	/* [V1.43] nonmapMirrorAccess */
	assign	nonmap_ram_rw	= (rd | wr) & sel_nonmap_ram_ma;	/* nonmapRAM$B7d4V(Baccess */
	assign	nonmap_exmem_rw	= (rd | wr) & sel_nonmap_exmem_ma;	/* nonmap$B30It@_DjHO0O30(Baccess */

	/* ------------------------------------------------------------------------------------	*/
	/* bramen=1$B$N$H$-$O(Bfailsafe$BL58z(B								*/
	/* bramen=0$B$N$H$-$G$b(Bbram$B$+$i(Bfetch$B$9$k$H(Bselfmode$B$H$J$k$,(B, selfmode$B$K$h$k(Bmask$B$h$j$b(B	*/
	/* bramen=0$B$K$h$k(Bnonmap$B$rM%@h$5$;$k0Y$K(B~selfmode$B$N>r7o$OF~$l$J$$(B.(self$BCf$N(Bfailsafe.)	*/
	/* ------------------------------------------------------------------------------------	*/
	assign	nonmap_bram_fch	= ~bramen & fch & sel_bram_pc;		/* nonmapBRAMfetch */

	/* ------------------------------------------------------------------------------------	*/
	/* bfaen=1$B$N$H$-$O(Bfailsafe$BL58z(B								*/
	/* bfaen=0$B$N$H$-$G$b(Bbfa$B$+$i(Bfetch$B$9$k$H(Bselfmode$B$H$J$k$,(B, selfmode$B$K$h$k(Bmask$B$h$j$b(B	*/
	/* bfaen=0$B$K$h$k(Bnonmap$B$rM%@h$5$;$k0Y$K(B~selfmode$B$N>r7o$OF~$l$J$$(B.(self$BCf$N(Bfailsafe.)	*/
	/* ------------------------------------------------------------------------------------	*/
	assign	nonmap_bfa_fch	= ~bfaen & fch & sel_bfa_pc;		/* nonmapBFAfetch */

	/* ----------------------------	*/
	/* bramen=1$B$N$H$-$O(Bfailsafe$BL58z(B */
	/* ----------------------------	*/
	assign	nonmap_bram_rw	= ~bramen & (rd | wr) & sel_bram_ma;	/* nonmapBRAMaccess */

	/* ------------------------------------	*/
	/* bfaen=1$B;~$N(Bwr$B$O(Bwrite protect$B$GBP1~(B	*/
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
	/* SFRAddress$B$,(Bpc$B$K>h$k$H(Bpcwaitf$B$,N)$A$C$Q$J$7$H$J$j(Bcpu$B$,K=Av$9$k0Y(B,fch$B$rO@M}$KF~$l$k$H(B	*/
	/* failsafe$B$b$+$+$i$J$/$J$k"*HFMQ%l%8%9%?$r%U%'%C%A6X;_$G$"$j(B,$BL?Na$N@hFI$_$G(Bsfr$B$,(B	*/
	/* pc$B$K>h$k$3$H$O$J$$$H9M$((B,fch$B$rO@M}$+$i30$9(B.						*/
	/* ------------------------------------------------------------------------------------	*/
	/* [V1.49]										*/
	/* DataFlash fetch protect$B$N>r7o$+$i(Bsel_exmem_pc_all$B$r:o=|$7$?(B.$B$3$l$K$h$j(Bdfadh,dladl$B$N(B	*/
	/* $B=i4|CM(B0$B$N>uBV$G(B0h$B$r(Bfetch$B$9$k$H(BData Flash$BNN0h$HG'<1$5$l$k$,(B,dfatt1$B$N=i4|CM$,85!9(B1$B$J$N(B	*/
	/* $B$G8mF0:n$9$k$3$H$OL5$$(B.								*/
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
	/* Data Flash write protect$B$N>r7o$rJQ99(B. SS3rd$BBP1~$N$?$a(B,Data Flash$B$N>r7o$+$i(Bsel_exmem_ma_all$B$r:o=|(B.	*/
	/* $B$3$l$K$h$j(Bdfadh,dladl$B$N=i4|CM(B0$B$N>uBV$G(B0h$B$r(Baccess$B$9$k$H(BData Flash$BNN0h$HG'<1$5$l$k$,(B,dfatt0$B$N=i4|CM$,(B	*/
	/* $B85!9(B1$B$J$N$G8mF0:n$9$k$3$H$OL5$$(B.									*/
	/* ----------------------------------------------------------------------------------------------------	*/
	always @(posedge baseck or negedge sysrsoutb) begin
		if( !sysrsoutb)	brkfail2 <= 1'b0;
		else if (~failmk2 & ~selfmode & ~svmod & wr & (
			(sel_rom_ma | sel_mirror_ma)				|	/* ROM write */
			( bfaen & sel_bfa_ma)					|	/* BFA write protect */
			(sel_exmem_ma_all & sel_exad0_ma_wprtct & ~exatt0)	|	/* $B30It(Bwrite$BB0@-(Bprotect-0 */
			(sel_exmem_ma_all & sel_exad1_ma_wprtct & ~exatt1)	|	/* $B30It(Bwrite$BB0@-(Bprotect-1 */
			(sel_exmem_ma_all & sel_exad2_ma_wprtct & ~exatt2)	|	/* $B30It(Bwrite$BB0@-(Bprotect-2 */
			(sel_exmem_ma_all & sel_exad3_ma_wprtct & ~exatt3)	|	/* $B30It(Bwrite$BB0@-(Bprotect-3 */
			(sel_dfad_ma_wprtct & ~dfatt0))					/* DataFlash write$BB0@-(Bprotect */
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

	/* $B!&(BGuradMemory$B$OF14|7?$J$N$G(Bcpuaddress$B$KBP$7$F=PNO$,(B1clock$BCY$l$k0Y(B, $BH=DjMQ$NB>$N?.9f$b(B1clock$BCY$i$;$k(B.	*/
	/* $B!&(Bsftattr,w$B$O(Bmemory$B=PNO$G4pK\E*$K2?$i$+$NCM$rJ];}$7$F$$$k$N$G(B, disable$B>r7o$O=P8}B&$K$D$1$k$7$+$J$$(B.	*/
	/*   -> 1clock$BCY$l$k(B.(memory$B=PNO$H9g$o$;$F(B2clock$BCY$l(B.)							*/
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

	/* 2ndsfr 2kx2bit+sfr256x2bit=4.5kbit -> 512adrx32bitRAM(ram16b_s32_s32:16kbitRAM)1$B8D;HMQ(B */
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
	/* $B!&F14|(Bmemory$B=PNO$J$N$G(Bcpu$BF0:n$KBP$7$F(B1clock$BCY$l$k(B.			*/
	/* $B!&(B32bitbus$B$N%G%3!<%I(B. ex) ma[3:0]=1111$B$J$i(Bsfrarea_attw = cpu_out[31]	*/
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
	/* $B!&(BRAMB16_Sx_Sx$B$N=PNO$N%j%;%C%H$O(BENx==1,CLKx$B",(B,SSRx==1$B$N>r7o$G(BSRVAL_x$B$N%l%Y%k$K=i4|2=(B	*/
	/*   $B$5$l$k(B.SRVAL_x$B$N(Bdefault$B$O(B0.$B$3$3$G(B,Reset$BCf$O(BClock$B$,F~$i$J$$$3$H$b$"$j(B,SSRx==0$B8GDj$G(B	*/
	/*   $B=i4|2=$O9T$o$J$$9=@.$K$9$k(B.$B$3$N>l9g(B,$B=PNO>r7o$,Mh$k$^$G=PNO$,ITDj$H$J$k$N$G(B,ENx$B$G(B	*/
	/*   $B=PNO$r(Bmask$B$7$F;H$&(B.							        */
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
	/* $B!&(BPOP$BL?Na(B($B%j!<%I%"%/%;%9(B)$B$G$O8!=P$5$;$J$$(B.						*/
	/* $B!&(BRAM$B7d4V$O=i4|2=ITMWNN0h$J$N$G=i4|2=K:$l8!=P$5$l$J$$$h$&$K$9$k(B.			*/
	/*   nonmap$B8!=P$O%,!<%I%a%b%j$r;HMQ$7$J$$$N$G!"8!=P%?%$%_%s%0$,(B1clock$B<jA0(B.		*/
	/* $B!&(Bcpu_en_acc$B$O!"(Balt1$B%"%/%;%9$r5v2D$9$k0Y$K(Bsvmod$BCf$G$b(Benable$B$H$J$k$,(B,			*/
	/*   $B$=$l$K$h$C$F(Bfailsafe$B$r9T$C$F$O$$$1$J$$$N$G(B,$B$3$3$GJLES(Bsvmod_l$B$rF~$l$k(B.		*/
	/*   (alt1$B$O%U%i%0$N=q$-9~$_$,L\E*(B.$B$3$N>l9g(BMemoryWrite$B$J$N$GLdBj$J$$$+$b$7$l$J$$$,0l1~(B)	*/
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
	/* RAM$B=i4|2=%U%i%0=q$-9~$_>r7o(B		*/
	/*  (1)$B%f!<%6%W%m%0%i%`$K$h$k=q$-9~$_(B	*/
	/*  (2)alt1$BL?Na$K$h$k=q$-9~$_(B		*/
	/*  (3)$B%[%9%H$+$i$N=q$-9~$_(B(ice-side)	*/
	/* ------------------------------------ */

	/* ----------------------------------------------------------------------------	*/
	/* FlashSelf$B;~$N(BUserArea$B=q$-9~$_;~(BEnable(BRAMAC$B$K$h$k(Boverlap$B6u4V$r=|$/(B)		*/
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
	/* $BDL>o;~(Benable											*/
	/* RAMfetch$BCf$N(BRAM$B6u4V0J30$N(Baccess$B$G8mF0:n$7$J$$$h$&(Baccess$B$N(Benable$B>r7o$K(Bsel_ram_ma$B$rF~$l$k(B.	*/
	/* selfmode_l1$B$+$i(Bselfmode_l3$B$KJQ99(B(Ver1.39)							*/
	/* [enable]     [change timing at self]	[enable accecc]						*/
	/* cpu_en_fch	selfmode		fch	sel_ram_pc$B$O(Bselfmode$B$HF14|$9$k$N$G$3$N$^$^$G(BOK.	*/
	/* cpu_en_acc	selfmode_l3		rd,wr	$B@Z$jBX$((BTiming$B$r(Bselfmode_l3$B$G9g$o$;$k(B.		*/
	/* firm_en	selfmode_l3		wr_l1	UserMode$B$X$N@Z$jBX$o$j$,CY$l$k$3$H$K$J$k$,(B,	*/
	/* brama_cnv_en	selfmode_l3		wr_l1	branch$B8e$G(BTiming$B$K(BMargin$B$,$"$k$N$GLdBj$J$$(B.	*/
	/* --------------------------------------------------------------------------------------------	*/
	assign	cpu_en_fch = ~selfmode & ~svmod & sel_ram_pc & fch;
	assign	cpu_en_acc = ~selfmode_l3 & (~svmod | alt1) & sel_ram_ma & (rd | wr);
	assign	firm_en = selfmode_l3 & sel_ram_ma_l1 & wr_l1;
	
	/* ------------------------------------------------------------	*/
	/* $BDL>o;~(Benable							*/
	/* break$B?.9f$N@8@.$K7sMQ$G$-$k$h$&(Bfetch$B$H(Baccess$B$G?.9f$rJ,$1$k(B	*/
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
	/* firm$B$K$h$k(BBRAM$B6u4V=q$-9~$_;~$K$b(BGuardMemory$B$r(Benable$B$K$9$k(B.	*/
	/* ------------------------------------------------------------	*/
	assign	cpu_en_evn_lo_bram = ~brama_cnv[15] & ~brama_cnv[0] & brama_cnv_en;
	assign	cpu_en_evn_hi_bram =  brama_cnv[15] & ~brama_cnv[0] & brama_cnv_en;
	assign	cpu_en_odd_lo_bram = ~brama_cnv[15] & (brama_cnv[0] | ~brama_cnv[0] & wdop_l1) & brama_cnv_en;
	assign	cpu_en_odd_hi_bram =  brama_cnv[15] & (brama_cnv[0] | ~brama_cnv[0] & wdop_l1) & brama_cnv_en;

	/* ------------------------------------------------------------	*/
	/* firm$B$K$h$k%f!<%6(BRAM$B=q$-9~$_;~$K$b(BGuardMemory$B$r(Benable$B$K$9$k(B.	*/
	/* bramac$B$K$h$k(Baccess$B$H(Btiming$B$,$V$D$+$i$J$$$h$&(B1clock$BCY$i$;$k(B.	*/
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
	/* selfmode_l1$B$+$i(Bselfmode_l3$B$KJQ99(B(Ver1.39)	*/
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
	/* $BGSB>$N(BOr     < $B"-(Buser write access ><firm BRAM Area Write access$B"-(B><firm User Area Access$B"-(B>	*/
	/* wr_l1$B$r(Bbrama_cnv_en, firm_en$B$NCf$KF~$l9~$s$@(B.(Ver1.39)					*/
	/* --------------------------------------------------------------------------------------------	*/
	assign	memwr = ~selfmode_l3 & sel_ram_ma & wr | brama_cnv_en & ovlapemu | firm_en ;
	
	/* ----------------------------------------------------	*/
	/* $B!&(Bfirm$B$K$h$k(BBRAM$B=q$-9~$_;~$N$_(B0($BL$=i4|2=(B)$B$r(Bwrite	*/
	/* $B!&(Bfirm$B$K$h$k(BUserRAM$B=q$-9~$_;~$O(B1($B=i4|2=(B)$B$r(Bwrite	*/
	/* Ver1.39$B$GJQ99(B					*/
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
	/* Convert Memory Enable.$B"-(Bbram$BHO0O30$J$i(Bdisable */
	wire cpu_en_0k_p, cpu_en_1k_p, cpu_en_2k_p, cpu_en_3k_p, cpu_en_4k_p, cpu_en_5k_p;
	assign	cpu_en_0k_p = sel_bram_ma & (flma[12:10] == 3'h2) ? 1'b1:1'b0;
	assign	cpu_en_1k_p = sel_bram_ma & (flma[12:10] == 3'h3) ? 1'b1:1'b0;
	assign	cpu_en_2k_p = sel_bram_ma & (flma[12:10] == 3'h4) ? 1'b1:1'b0;
	assign	cpu_en_3k_p = sel_bram_ma & (flma[12:10] == 3'h5) ? 1'b1:1'b0;
	assign	cpu_en_4k_p = sel_bram_ma & (flma[12:10] == 3'h6) ? 1'b1:1'b0;
	assign	cpu_en_5k_p = sel_bram_ma & (flma[12:10] == 3'h7) ? 1'b1:1'b0;
	
	/* selfmode = sel_bram_pc or sel_bfa_pc */
	/* address$B@Z$jBX$o$j$r(Bselfmode_l3$B$K$9$k$N$G(B,Memory Enable$B$O(Bselfmode_l2 */
	wire cpu_en_0k, cpu_en_1k, cpu_en_2k, cpu_en_3k, cpu_en_4k, cpu_en_5k;
	assign	cpu_en_0k = selfmode_l2 & cpu_en_0k_p;
	assign	cpu_en_1k = selfmode_l2 & cpu_en_1k_p;
	assign	cpu_en_2k = selfmode_l2 & cpu_en_2k_p;
	assign	cpu_en_3k = selfmode_l2 & cpu_en_3k_p;
	assign	cpu_en_4k = selfmode_l2 & cpu_en_4k_p;
	assign	cpu_en_5k = selfmode_l2 & cpu_en_5k_p;
	
	/* ----------------------------------------------------------------------------	*/
	/* brama$BM-8z>r7o(B(brama_cnv_en)$B$K;HMQ$N(Bselfmode_l1$B$r(Bselfmode_l3$B$KJQ99(B.		*/
	/* address,write,BRAMAC-Memory enable$B?.9f$N@Z$jBX$((BTiming$B$r(Bselfmode_l2$B$KE}0l(B.	*/
	/* Ver1.39$B$GJQ99(B.								*/
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
	/* FlashSelf$B;~$N(BBRAMAC$B$K$h$k(Boverlap$B6u4V(BRAM$BL$=i4|2=(BFlag$B=q$-9~$_(Benable.	*/
	/* self$BCf$N(Buser$B3d$j9~$_$G$O(B,Stack$BF0:n$,(BJustTiming$B$N(BUser$BF0:n$H(B1Clock$BCY$l(B	*/
	/* $B$N(BFirm$BF0:n$G$V$D$+$C$F$7$^$&(B.$B$3$N2sHr$N0Y(B,selfmode_l3$B?.9f$r;HMQ(B.	*/
	/* Ver1.39$B$GJQ99(B.							*/
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
	/* $B!&(Bpop$B$O(Bread$B8e$K(Bsp$B$r(Bincrement$B$7(B,push$B$O(Bsp$B$r(Bdecrement$B8e$K(Bwrite$B$9$k$N$G(B,			*/
	/*   pop$B8e$N(Bsp$B$,@_DjHO0O30$G$b8!=P$7$J$$(B. ->						*/
	/*   sp$B$N(Bincrement$B8e$K(BSPINC$B$,N)$D$N$G(Bma$B$r;HMQ$9$k(B(ma$B$O(Bincrement$BA0$NCM(B)			*/
	/* $B!&(Bpop$B$O(Bword$BC10L$G6v?t(Baccess$B$N$_$J$N$G(B,$B6v?t(Baddress$B$,>e8B$K@_Dj$5$l$F$$$?>l9g$K(Bpop$B$7$?(B	*/
	/*   $B4q?t(Baddress$B$,HO0O30$G$"$C$F$b8!=P$G$-$J$$(B(push$B$bF1MM(B) ->				*/
	/*           f008            f008  push          f002                  f002 push	*/
	/*           f007  <-($BHs8!=P(B)f007    <-($BHs8!=P(B)  f001                  f001		*/
	/*           --------        ----------          --------------        ----------	*/
	/*   ustadrh f006 pop,spinc  f006 spdec  ustadrl f000 pop,spinc($B8!=P(B)  f000 spdec($B8!=P(B)	*/
	/*											*/
	/* $B!!(Bustadrh$B$N:G2<0L(Bbit$B$O(B1$B8GDj(B, ustadrl$B$N:G2<0L(Bbit$B$O(B0$B8GDj$N;EMM$H$9$k(B.			*/
	/*   (ustadrl$B$O(B0$B8GDj$K$9$kI,MW$J$$$,!"J,$+$j$d$9$/$9$k0Y(B)				*/
	/* ------------------------------------------------------------------------------------	*/
	assign	sp_up = (flma > {ustadrh, 1'b1}) ? 1'b1:1'b0;
	assign	sp_lo = (flma < {ustadrl, 1'b0}) ? 1'b1:1'b0;

	//		
	// SP Under Flow
	//		
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) brkfail7 <= 1'b0;
		/* ------------------------------------------------------------------------------------	*/
		/* $B!&(Bsp$B=q$-9~$_D>8e$K(Bsp$BAjBPL?Na$r<B9T$9$k$H(Bsprel$B?.9f$,(B1clock$BAa$/N)$A>e$,$kLdBj$,$"$k0Y(B,	*/
		/*   cpurd,cpuwr$B$H(Band$B$9$k(B.spinc,spdec$B$K$D$$$F$O%(%P%3%"$GBP1~:Q$_(B.			*/
		/* $B!&(Bret$B$H(Bdma$B$N6%9g;~(B,dma$BE>AwCf$K$b(Bspnic$B$,(Bactive$B$H$J$k0Y(B,dma$B?.9f$G(Bmask($BIT6q9g=$@5(B)	*/
		/* ------------------------------------------------------------------------------------	*/
		else if (~failmk7 & ~selfmode & ~svmod & (spinc|spdec|sprel) & sp_up & (cpurd | cpuwr) & ~dma)
				brkfail7 <= 1'b1;
		else		brkfail7 <= 1'b0;
	end
	//		
	// SP Over Flow	
	//		

	/* ----------------------------------------------------------------------------	*/
	/* User Stack Overflow$B$O(Bself$BCf$K$b8!=P$r9T$$(B,self$B=*N;8e$K(Bbreak$B?.9f$r=PNO$9$k(B.	*/
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

	/* SP$B2<0L=q$-9~$_(B */
	always @(posedge baseck or negedge cpuresetb) begin
		if (!cpuresetb)	sp_notset1 <= 1'b1;
		else if (~selfmode & ~svmod & sel_sfr_ma & (flma[7:0] == 8'hf8) & cpuwr)
				sp_notset1 <= 1'b0;
	end
	/* SP$B>e0L=q$-9~$_(B,$B$^$?$O(BSPWord$B=q$-9~$_(B */
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
// $BFbIt(Bstatus	
//		
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	pcwaitf_l <= 1'b0;
		else		pcwaitf_l <= pcwaitf;
	end
	/* ------------------------------------------------------------------------------------------------------------	*/
	/* $B!&(Bint$B$N>l9g(B,prefetch$B$N(Bpc$B$,(Bstageadr, pcwaitf$B$G(Bmask$B$5$l$J$$$N$G(B,intack$B$G(Bmask$B$9$k(B(~intack).(fetch)		*/
	/* $B!&(Bint$B$N>l9g(B,VectorRead$B;~$K(Bstageadr$B$,N)$A(BFetchStatus$B$,N)$?$J$/$J$k$N$GJLES>r7o$KF~$l$k(B(intack_l2).(fetch)	*/
	/* $B!&(Bdma$BE>Aw;~$O(Bpcwaitf$B$,N)$?$J$$0Y(B,$BJLES>r7o$KF~$l$k(B(fetch)							*/
	/* $B!&(BRAMFetch$B$G$N(Bdma$BE>Aw;~$O(BdmaRead$B$,(Bmask$B$5$l$k$N$G(B,dma$BE>Aw$O(Bmask$B$5$l$J$$$h$&>r7o$KJLESF~$l$k(B.(rw)		*/
	/* $B!&30It(Baccess$B;~$OB>$N(Baccess$B$H(Btiming$B$,0[$J$k0Y(B,waitexm$B$r(Bpcwaitf$B$KF~$l9~$a$J$$(B.					*/
	/*   pcwaitf_l$B$H$7$?;~$K(Baccess$B$,(Bmask$B$5$l$F$7$^$&0Y(B.								*/
	/* $B!&(BEXMEM,RAMfetch$B;~(B,intack$B$N(Btiming$B$G(B~ramfch&cpurd($B??$N(Bread$B$G$O$J$$(B)$B$N>uBV$,5/$3$k(B. RAM$B;~$O(B			*/
	/*   pcwaitf_l$B$G(Bmask$B$5$l$k$,(B,EXMEM$B;~$O(Bwaitexm$B$G(Bmask$B$7$F$$$k$N$G$3$N56$N(Bcpurd$B$,(Breject$B$G$-$J$$0Y(B,			*/
	/*   ~intack$B$r(Brd$B$N>r7o$KF~$l$k(B.(read)										*/
	/* $B"*(B[V1.33] ~intack$B$K$h$j(B,$BB?$/$N(BCase$B$G3d$j9~$_D>A0$N(BAccess$B$,(BTrace$B$5$l$J$$LdBj$,5/$-$F$$$?(B.EXMEM Fetch$B$G$O(B	*/
	/*   Access$B$rH/@8$5$;$kL?Na$N(BStage$B$G(BAccess$B$b9T$o$l$k0Y(B,$B<!$N3d9~$_$K$h$k(BPrefetch$B;~$N(B(6)$B$N(Bmask$B$K(Bintack$B$r;HMQ(B	*/
	/*   $B$7$FLdBj$J$$$,(B,Flash Fetch$B;~$J$I$O(BPreFetch$B$N(BStage$B$G(Bintack$B",$N(BTiming$B$HF1;~$K(BAccess$B$,9T$o$l$k0Y(B,Access$B$,(B	*/
	/*   Mask$B$5$l$F$7$^$&(B. ~intack -> ~((selexmpc | selrampc) & intack)$B$HJQ99(B.					*/
	/* $B!&(Bstageadr,pcwaitf$B$J$I$OK\MhITMW$+$b$7$l$J$$$,(B,$B0BA4$N0YB>%V%m%C%/$K9g$o$;$k(B.					*/
	/* $B!&(Bcpumsk$B$O(Bcs,es,psw,sp($BHFMQ(Bregister)$B$N(Btrace$B$rM^@)$9$k?.9f$J$N$G$3$3$G$O;H$&I,MW$J$7(B.				*/
	/* $B!&(BCPU$B$,(BNPB-Retry$BBP1~$N0Y$K(BV2$B$G=$@5$5$l$F$$$k!#$3$l$K9g$;$F(Bocdwait$B$r;HMQ$9$k=$@5$r9T$C$?!#(BTiming$B$O(BSystem$B;EMM(B	*/
	/*   $B=q$K5-:\$7$?!#(BFlash$B%U%'%C%A$N>l9g$H(BRAM$B%U%'%C%A$N>l9g$G(Bocdwait$B$H(Bpcwaitf$B$NF0$-$,0c$&$N$GCm0U$,I,MW!#30It$K(B	*/
	/*   $B$D$$$F$O8=>u(BCPU$B$,HsBP1~$G!"(BNPB$B$"$j!\30It$"$j$N@=IJ$,=P$FMh$?>l9g$K$O8!F$$,I,MW!#(B				*/
	/* ------------------------------------------------------------------------------------------------------------	*/
	/* [V1.47]													*/
	/* pcwaitf$B$H(Bintack$B$,F1;~$KN)$C$?>l9g$O(Bpcwaitf$B4|4VJ,(Bintack_l1$B$rCY$i$;$k(B.						*/
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
	// RAM,EXMEM$B$+$i(BFlash$B$K(BPC$B$,A+0\8e$N(B1clock(WAITEXM Act$B;~$O(B+Wait)$B$r8!=P(B(mask_branch)
	// $B$7(B,cpurd$B$r(BMask$B$9$k$3$H$GIT@5$J(BRead$B$r8!=P$7$J$$9=@.$H$7$?!#(B
	// [V1.51]
	// BRAM(selbrampc),BFA(selbfapc)$B$r>r7o$KDI2C(B.
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
// $B6u4VH=JL?.9f(B	
//		
	/* ----------------------------------------------------------------------------------------------------	*/
	/* $B!&30It$KBP$9$k(BMirrorAccess$B$K$D$$$F(B									*/
	/* $B!!(B-> MirrorAccess$B$O(BpidBus$B9T$o$l(B,$B30It$O(BMemoryBus$B$r;HMQ$9$k$N$G(B,$B30It$,(Bmirror$B$H$7$F8+$($k$3$H$OL5$$(B.	*/
	/*   $B!!(B ROM64K$B0J2<(B,$B30It$"$j$N@=IJ$G(Bmaa=1$B$N@_Dj$O(Bcpu$B$H$7$F6X;_!J(B06.01.16EvaCore$B@_7W<T$K3NG'(B)		*/
	/*    $B!!(Bfailsafe$B$H$7$F$O(Bmirror$B$X$N(Bwrite$B$r0l0U$K(Bwprotect$B$NBP>]$K$9$k(B.					*/
	/* $B!&(Bexma$B$K$D$$$F(B											*/
	/*   -> exma$B$OK\Mh(B[$B30It(Bmemory$B6u4VMQ(Baddress$B>e0L(B4bit]$B$@$,(B,DMA$BE>Aw;~0J30$N(BAccessAddress$B>e0L(B4bit$B$H$7$F;HMQ(B	*/
	/*      $B$7$F(BOK(06.02.21 evacore$BC4Ev$K3NG'(B).DMA$B;~$O>e0L(B4bit$B$K30It$N(Baddress$B$,;D$k>l9g$,$"$k$N$G(Bfh$B8GDj(B.	*/
	/* ----------------------------------------------------------------------------------------------------	*/
	assign	maup		= dma ? 4'hf : exma;
	assign	sel_exxxxh_pc	= (pc[19:16] == 4'he) ? 1'b1:1'b0;
	assign	sel_exxxxh_ma	= (maup      == 4'he) ? 1'b1:1'b0;
	assign	sel_fxxxxh_pc	= (pc[19:16] == 4'hf) ? 1'b1:1'b0;
	assign	sel_ffxxxh_pc	= (sel_fxxxxh_pc && (pc[15:12] == 4'hf)) ? 1'b1:1'b0;
	assign	sel_fxxxxh_ma	= (maup      == 4'hf) ? 1'b1:1'b0; /* dma$B;~$O(Bexma$B$K$h$i$:(Bactive */
	assign	sel_ffxxxh_ma	= (sel_fxxxxh_ma && (flma[15:12] == 4'hf)) ? 1'b1:1'b0;
	assign	sel_sfr_pc	= (sel_ffxxxh_pc && (  pc[11:8] == 4'hf)) ? 1'b1:1'b0;
	assign	sel_sfr_ma	= (sel_ffxxxh_ma && (flma[11:8] == 4'hf)) ? 1'b1:1'b0;
	assign	sel_generalreg_pc = (sel_ffxxxh_pc && (  pc[11:8] == 4'he) && (  pc[7:4] >= 4'he)) ? 1'b1:1'b0;
	assign	sel_generalreg_ma = (sel_ffxxxh_ma && (flma[11:8] == 4'he) && (flma[7:4] >= 4'he)) ? 1'b1:1'b0;
	assign	sel_ram_pc_all	= (sel_fxxxxh_pc && ~sel_sfr_pc && ~sel_generalreg_pc && (  pc[15:8] >= ramsize) && ~sel_bram_pc) ? 1'b1:1'b0; /* nonmap$B$r4^$`(B */
	assign	sel_ram_ma_all	= (sel_fxxxxh_ma && ~sel_sfr_ma && ~sel_generalreg_ma && (flma[15:8] >= ramsize) && ~sel_bram_ma) ? 1'b1:1'b0; /* nonmap$B$r4^$`(B */
	assign	sel_ram_pc	= (sel_ram_pc_all && ~sel_nonmap_ram_pc) ? 1'b1:1'b0; /* nonmap$B$r=|$/(B */
	assign	sel_ram_ma	= (sel_ram_ma_all && ~sel_nonmap_ram_ma) ? 1'b1:1'b0; /* nonmap$B$r=|$/(B */
	// [V1.50]
	// mirror$B$+$i(Bdflash$BNN0h$r=|30(B
	assign	sel_mirror_pc_all = (sel_fxxxxh_pc && (ramsize >   pc[15:8]) && ~sel_bram_pc && ~sel_2ndsfr_pc && ~sel_dfad_pc) ? 1'b1:1'b0; /* nonmap$B$r4^$`(B */
	assign	sel_mirror_ma_all = (sel_fxxxxh_ma && (ramsize > flma[15:8]) && ~sel_bram_ma && ~sel_2ndsfr_ma && ~sel_dfad_ma) ? 1'b1:1'b0; /* nonmap$B$r4^$`(B */
//	assign	sel_mirror_pc	= (sel_mirror_pc_all && ~sel_nonmap_rom_pc) ? 1'b1:1'b0; /* nonmap$B$r=|$/(B */
	assign	sel_mirror_pc	= sel_mirror_pc_all; /* sel_nonmap_rom_pc$B$O(Bsel_mirror_pc_all$B$HGSB>(B. */
	assign	sel_mirror_ma	= (sel_mirror_ma_all && ~sel_nonmap_rom_ma) ? 1'b1:1'b0; /* nonmap$B$r=|$/(B */
	assign	sel_bram_pc	= (sel_fxxxxh_pc && ({3'h0, bmsize[3:0], 1'b0} >   pc[15:8]) && ~sel_2ndsfr_pc) ? 1'b1:1'b0;
	assign	sel_bram_ma	= (sel_fxxxxh_ma && ({3'h0, bmsize[3:0], 1'b0} > flma[15:8]) && ~sel_2ndsfr_ma) ? 1'b1:1'b0;
	assign	sel_2ndsfr_pc	= (sel_fxxxxh_pc && (  pc[15:11] == 5'h0)) ? 1'b1:1'b0;
	assign	sel_2ndsfr_ma	= (sel_fxxxxh_ma && (flma[15:11] == 5'h0)) ? 1'b1:1'b0;
	assign	sel_bfa_pc	= (sel_exxxxh_pc && (  pc[15:8] >= {2'b11, bfsize[3:0], 2'b00})) ? 1'b1:1'b0;
	assign	sel_bfa_ma	= (sel_exxxxh_ma && (flma[15:8] >= {2'b11, bfsize[3:0], 2'b00})) ? 1'b1:1'b0;
	assign	sel_exmem_pc_all = ((pc[19:16] > flsize) && ~sel_fxxxxh_pc && ~sel_bfa_pc) ? 1'b1:1'b0; /* nonmap$B$r4^$`(B */
	assign	sel_exmem_ma_all = ((maup      > flsize) && ~sel_fxxxxh_ma && ~sel_bfa_ma) ? 1'b1:1'b0; /* nonmap$B$r4^$`(B */
//	assign	sel_exmem_pc	= (sel_exmem_pc_all && (sel_exad0_pc || sel_exad1_pc || sel_exad2_pc || sel_exad3_pc || sel_dfad_pc)) ? 1'b1:1'b0; /* nonmap$B$r=|$/(B */
//	assign	sel_exmem_ma_wprtct = (sel_exmem_ma_all && (sel_exad0_ma_wprtct || sel_exad1_ma_wprtct || sel_exad2_ma_wprtct || sel_exad3_ma_wprtct || sel_dfad_ma_wprtct)) ? 1'b1:1'b0; /* nonmap$B$r=|$/(B */
	assign	sel_rom_pc_all	= ((flsize >= pc[19:16]) && ~sel_bfa_pc) ? 1'b1:1'b0; /* nonmap$B$r4^$`(B */
	assign	sel_rom_ma_all	= ((flsize >= maup     ) && ~sel_bfa_ma) ? 1'b1:1'b0; /* nonmap$B$r4^$`(B */
	assign	sel_rom_pc	= (sel_rom_pc_all && ~sel_nonmap_rom_pc) ? 1'b1:1'b0; /* nonmap$B$r=|$/(B */
	assign	sel_rom_ma	= (sel_rom_ma_all && ~sel_nonmap_rom_ma) ? 1'b1:1'b0; /* nonmap$B$r=|$/(B */

	/* rom nonmap area */
	assign	rom_nogap = (flsizeice[5:0] == 6'b0) ? 1'b1:1'b0; /* 64k($B7d4V$J$7(B) */
	assign	boundary_rom_pc = (pc[19:16] == flsize) ? 1'b1:1'b0;
	assign	rom_gap_pc = ((pc[15:10] >= flsizeice[5:0]) && ~rom_nogap) ? 1'b1:1'b0;
	assign	sel_nonmap_rom_pc = boundary_rom_pc & rom_gap_pc;

	assign	boundary_rom_ma = (maup == flsize) ? 1'b1:1'b0;	/* flsize=fh$B$O$J$$(B */
	assign	boundary_mirror_ma = (sel_mirror_ma_all && (maa == flsize[0]) && (flsize[3:1]==3'h0)) ? 1'b1:1'b0;
					/* mirror$B$K(B0xxxxh$B6u4V$,8+$((B,ROM$B6-3&$,(B0xxxxh$B6u4V(B.$B$^$?$O(B,	*/
					/* mirror$B$K(B1xxxxh$B6u4V$,8+$((B,ROM$B6-3&$,(B1xxxxh$B6u4V(B.	*/
	assign	rom_gap_ma = ((flma[15:10] >= flsizeice[5:0]) && ~rom_nogap) ? 1'b1:1'b0;
	assign	sel_nonmap_rom_ma = (boundary_rom_ma | boundary_mirror_ma) & rom_gap_ma;

	/* mirror nonmap area */
	/* [V1.43] flash<=64kB$B$G(Bmaa==1$B;~$K(Bmirror$B$K(Br/w$B%"%/%;%9$7$?>l9g$O(Bnonmap$B$H$7$F07$&(B. */
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
	/* fetch protect, sel_nonmap_exmem_pc$B$K;HMQ(B.	*/
	/* --------------------------------------------	*/
	assign	sel_dfad_pc = ((dfadh >= pc) && (pc >= dfadl)) ? 1'b1:1'b0;

	/* --------------------------------------------------------------------------------------------	*/
	/* [V1.50]											*/
	/* sel_dfad_ma$B$rDI2C(B. sel_mirror_ma_all$B$K;HMQ(B.SS3rd$B$G$O(Bdflash$B$O(Bmirror$B6u4V$KG[CV$5$l$k$?$a(B,	*/
	/* mirror$B$+$i(Bdflash$B$r:o=|(B. $BC"$7(B,$B$3$N=hCV$r$7$J$/$F$bLdBj$O$J$5$=$&(B. mirror$B=q9~$_$O(BOK,mirror	*/
	/* $B%U%'%C%A$O(BNG$B$@$,%G!<%?%U%i%C%7%e$b(BNG$B$G6&$K(Bfetch protect, mirror$B%j!<%I$O(BOK$B$J$N$G(B,dflash$B$,(B	*/
	/* sel_mirror_ma_all$B$+$i=|30$5$l$F$$$J$/$F$b0-$5$O$7$J$5$=$&(B.					*/
	/* --------------------------------------------------------------------------------------------	*/
	assign	sel_dfad_ma = ((dfadh >= {maup,flma}) && ({maup,flma} >= dfadl)) ? 1'b1:1'b0;

	/* --------------------------------------------------------------------------------------------	*/
	/* sel_nonmap_exmem_ma$B$K$N$_;HMQ(B. sel_nonmap_exmem_ma$B$O(Bexmem$B$N(Bnonmap$B6u4V$G$"$k$3$H$r<($9?.9f$G(B,	*/
	/* sel_dfad_ma_nonmap$B$,56$@$H(Bsel_nonmap_exmem_ma$B$,??$H$J$k!#(Bdfadh$B$N@_DjCM$HF1$8%"%I%l%9$KBP$7$F(B	*/
	/* wdop$B$r$7$?>l9g!"(Bdfadh$B$r1[$($k$N$G(B,$B$=$N>l9g$K(Bsel_nonmap_exmem_ma$B$r??$H$9$k0Y$K(B		*/
	/* sel_dfad_ma_nonmap$B$r56$K$9$kI,MW$,$"$j(B,$B>e8B$N>r7o$K(Bwdop$B$rF~$l$F$$$k!#(B			*/
	/* --------------------------------------------------------------------------------------------	*/
	assign	sel_dfad_ma_nonmap = ((dfadh >= {maup,flma[15:1],(flma[0] | wdop)} ) && ({maup,flma} >= dfadl)) ? 1'b1:1'b0;
	
	/* --------------------------------------------------------------------------------------------	*/
	/* High$B$@$C$?$i(Bnonmap.										*/
	/* ss3rd$BBP1~$K$D$-(BData Flash$B$NHO0O$,(Bexmem$B$^$?$O(Bmirror$B$H$J$C$?$,(B,$B$=$l$KH<$&JQ99$OITMW(B.SS3rd$B$G$O(B	*/
	/* Data Flash$B$O(Bmirror$BNN0h$KCV$+$l(B,Data Flash$BHO0O$r1[$($F$b(Bnonmap$B$H$O$J$i$J$$(B.			*/
	/* --------------------------------------------------------------------------------------------	*/
	assign	sel_nonmap_exmem_pc = sel_exmem_pc_all & ~sel_exad0_pc & ~sel_exad1_pc & ~sel_exad2_pc & ~sel_exad3_pc & ~sel_dfad_pc;
	assign	sel_nonmap_exmem_ma = sel_exmem_ma_all & ~sel_exad0_ma_nonmap & ~sel_exad1_ma_nonmap & ~sel_exad2_ma_nonmap & ~sel_exad3_ma_nonmap & ~sel_dfad_ma_nonmap;

	/* write protect area */
	assign	sel_exad0_ma_wprtct	= ((exadh0 >= {maup,flma}) && ({maup,flma[15:1],(flma[0] | wdop)} >= exadl0)) ? 1'b1:1'b0;
	assign	sel_exad1_ma_wprtct	= ((exadh1 >= {maup,flma}) && ({maup,flma[15:1],(flma[0] | wdop)} >= exadl1)) ? 1'b1:1'b0;
	assign	sel_exad2_ma_wprtct	= ((exadh2 >= {maup,flma}) && ({maup,flma[15:1],(flma[0] | wdop)} >= exadl2)) ? 1'b1:1'b0;
	assign	sel_exad3_ma_wprtct	= ((exadh3 >= {maup,flma}) && ({maup,flma[15:1],(flma[0] | wdop)} >= exadl3)) ? 1'b1:1'b0;

	/* --------------------------------------------------------------------------------------------	*/
	/* write protect$B$K;HMQ(B. $B$3$N?.9f$,(Bactive$B$G(Bdfatt0=0$B$N;~$K(Bwrite protect$B$H$9$k(B. dfadl$B$N0l$D2<$N%"(B	*/
	/* $B%I%l%9$K(Bwdop$B$G(Bwrite$B$7$?>l9g$O(BWord Data$B$N>e0L$,(BData Flash$B$NHO0O$KF~$k$N$G(Bwrite protect$B$H$9$k(B.	*/
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
output [14:0]	failmk;	/* [V1.49] bit14$B$rDI2C(B */
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
reg [14:0]	failmk;	/* [V1.49] bit14$B$rDI2C(B */
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
			16'b0000000000100000: register_ro = {17'b0, failmk};	/* [V1.49] bit14$B$rDI2C(B */
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
	/* bit14$B$rDI2C(B. bit14(=Data Flash Word Read Protect)$B$O(BSS3rd$BMQ$J$N$G(B,	*/
	/* SS2nd$B@=IJ$G8mF0:n$7$J$$$h$&$K=i4|CM$r(B1(=Mask)$B$K$9$k(B			*/
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


