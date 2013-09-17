/********************************************************************************/
/* Date		: 2005/05/09							*/
/* Revision	: 1.00								*/
/* Designer	: T.Tsunoda							*/
/* Note		: 78K0R IECUBE Trace Unit					*/
/********************************************************************************/
/* [Upadte Info]								*/
/* Date		: 2007/11/16							*/
/* Revision	: 1.70								*/
/* Designer	: T.Tsunoda							*/
/* Note		: [V1.70]$B$N=$@5(B.$B3d9~$_D>A0$N(BAccess$B$,@5$7$/(Btrace$B$5$l$F$$$J$+$C$?(B	*/
/*		: $B$N$r=$@5(B.							*/
/********************************************************************************/
/* [Updata Info]								*/
/* Date		: 2009.1.15							*/
/* Revision	: 1.72								*/
/* Designer	: T.Tsunoda							*/
/* Note		: NPB-Macro$B$,@=IJ$KDI2C$5$l$?$3$H$KH<$&=$@5!#(BNPB-Macro Access$B$G(B	*/
/*		: Trace$B$N%@%V$j$d<h$jB;$M$,@8$8$J$$$h$&$K$7$?!#(BOCDWAIT$BC<;RDI2C(B.	*/
/********************************************************************************/
/* [Updata Info]								*/
/* Date		: 2009.7.14							*/
/* Revision	: 1.73								*/
/* Designer	: T.Tsunoda							*/
/* Note		: 1.SP$BA`:n$H3d9~$_$,6%9g$7$?>l9g$K(BID$B%9%F!<%8$,(BWait$B$5$l(B,$B3d$j9~$_(B	*/
/*		:   Flag(int_l3)$B$r(BTrace$B$9$k(BTiming$B$,$:$l$kLdBj$r=$@5!#(B		*/
/*		:   $BC"$7(B,FlashFetch,RAMFetch$B$K$OBP1~$7$?$,(B,EXMEMFetch$B$K$OL$BP1~(B	*/
/*		:   $B$G(B,$B8eF|BP1~M=Dj!#(B						*/
/*		: 2.SP$BA`:n$H3d9~$_$,6%9g$7$?>l9g(B,PreFetch$B$7$?(BPC$B$b(BWait$B$5$l(B	*/
/*		:   PreFetch$B$,%H%l!<%9$5$l$F$7$^$&LdBj$r=$@5!#(B			*/
/*		: 3.$B<~JU(BReset$B$,5)$K$?$@$7$/(BTrace$B$5$l$J$$LdBj$r=$@5!#(B		*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2009.9.15							*/
/* Revision	: 1.74								*/
/* Designer	: T.Tsunoda							*/
/* Note		: RAM->Flash,EXMEM->Flash$B$N(BBranch(BR$BL?Na8BDj(B)$B;~(B,$BIT@5$K(BRead$B%"%/(B	*/
/*		: $B%;%9$r8!=P$9$kIT6q9g$r=$@5!#=$@5FbMF$H$7$F$O(BBR$BL?Na$K8BDj$7$F(B	*/
/*		: $B$$$k$o$1$G$O$J$/(B,RAM,EXMEM->Flash$B$XA+0\;~$N%j!<%I%"%/%;%9$r(B	*/
/*		: $B0lN'(BMask$B$7$F$$$k(B.$BJ,4t8e:G=i$NL?Na<B9T;~$K%"%/%;%9$,H/@8$9$k(B	*/
/*		: $B$3$H$O5/$j$($J$$$?$a(B.						*/
/********************************************************************************/
/* [Update Info]								*/
/* Date		: 2010.3.30							*/
/* Revision	: 1.75								*/
/* Designer	: T.Tsunoda							*/
/* Note		: 1.74$B$HF1MM$N=$@5$r(B,Flash$B$G$O$J$/(BBFA$B$K$D$$$F=hCV(B.Firm$BI>2A$K$*(B	*/
/*		: $B$$$F(B,BRAM->BFA$B$N(Bbr,RAM->BFA$B$N(Bret$B$G9T$C$F$$$J$$(BRead$B%"%/%;%9$,(B	*/
/*		: $B8!=P$5$l$kLdBj$,Js9p$5$l$?$?$a(B.1.74$B$N(BCase$B$G$O(Bret$B;~$O(Bpcwaitf$B$K(B	*/
/*		: $B$h$j(Bmask$B$5$l$k$N$GLdBj$J$$$,(B,1.74$B$N=hCV$K$h$j(Bret$B;~$b(Bmask$B$5$l(B	*/
/*		: $B$k(B. BRAM,BFA$B$N>l9g$K$O(Bret$B$,(Bpcwaitf$B$K$h$j(Bmask$B$5$l$J$$$N$G$3$3(B	*/
/*		: $B$G$N=hCV$K$h$j(Bmask$B$5$l$k(B.$B$3$l$i$O(BSELF$BCf(B(selfmode$B?.9f$,(BActive)	*/
/*		: $B$K5/$k$3$N$G(B,$B%f!<%68+$($K$O1F6A$7$J$$(B.Firm,Library$B$J$I$NFbIt(B	*/
/*		: $BI>2AMQ$KITJX$J$?$aBP1~$9$k$,(B,$B=$@5FbMF$K4X$9$k(BTP$B$O:n@.$;$:(B,$BB>(B	*/
/*		: $B$N5!G=$K1F6A$7$J$$$3$H$r4{B8$N(BTP$B$G(Bdegrade$BI>2A$9$k$N$_$H$9$k(B.	*/
/********************************************************************************/
// $Id: tracev1.v,v 1.75 2010-03-30 02:39:50 tsuno3 Exp $

module	TRACE (
	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25,
	ICEIFA24, ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18,
	ICEIFA17, ICEIFA16, ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11,
	ICEIFA10, ICEIFA9, ICEIFA8, ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4,
	ICEIFA3, ICEIFA2,
	ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
	ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
	ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
	ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0,
	ICEWR,
	ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25,
	ICEDO24, ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18,
	ICEDO17, ICEDO16, ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11,
	ICEDO10, ICEDO9, ICEDO8, ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3,
	ICEDO2, ICEDO1, ICEDO0,
	PC19, PC18, PC17, PC16, PC15, PC14, PC13, PC12, PC11, PC10,
	PC9, PC8, PC7, PC6, PC5, PC4, PC3, PC2, PC1, PC0,
	IDADR31, IDADR30, IDADR29, IDADR28, IDADR27, IDADR26, IDADR25, IDADR24,
	IDADR23, IDADR22, IDADR21, IDADR20, IDADR19, IDADR18, IDADR17, IDADR16,
	IDADR15, IDADR14, IDADR13, IDADR12, IDADR11, IDADR10, IDADR9,  IDADR8,
	IDADR7,  IDADR6,  IDADR5,  IDADR4,  IDADR3,  IDADR2,  IDADR1,  IDADR0,
	STAGEADR1, STAGEADR0,
	PREFIX,
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
	EXMA3, EXMA2, EXMA1, EXMA0,
	MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8,
	MA7,MA6, MA5, MA4, MA3, MA2, MA1, MA0,
	IMDR15, IMDR14, IMDR13, IMDR12, IMDR11, IMDR10, IMDR9, IMDR8,
	IMDR7, IMDR6, IMDR5, IMDR4, IMDR3, IMDR2, IMDR1, IMDR0,
	TRACEMDR15, TRACEMDR14, TRACEMDR13, TRACEMDR12, TRACEMDR11, TRACEMDR10, TRACEMDR9, TRACEMDR8,
	TRACEMDR7,  TRACEMDR6,  TRACEMDR5,  TRACEMDR4,  TRACEMDR3,  TRACEMDR2,  TRACEMDR1, TRACEMDR0,
	MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8,
	MDW7, MDW6, MDW5, MDW4, MDW3, MDW2, MDW1, MDW0,
	CPURD, CPUWR, WDOP,
	BASECK,
	ALT1, SVMOD, SVMODUSER, SELFMODE, SELFMODEDBG, SELEXMPC, SELRAMPC, SELROMPC, SELBRAMPC, SELBFAPC,
	TAG31, TAG30, TAG29, TAG28, TAG27, TAG26, TAG25, TAG24, TAG23, TAG22, TAG21,
	TAG20, TAG19, TAG18, TAG17, TAG16, TAG15, TAG14, TAG13, TAG12, TAG11, TAG10,
	TAG9,  TAG8,  TAG7,  TAG6,  TAG5,  TAG4,  TAG3,  TAG2,  TAG1,  TAG0,
	TAGOVF,
	CLK30MHZ, CLK60MHZ, SYSRSOUTB, ICERESB, CPURSOUTB, TARRESB_NORM, ICEMSKICE, ICEMSKTRST,
	STEP,
	INTACK, DMAACK,
	BRKTRADY, BRKTRAFL,
	EVD01,
	EVD02, EVD03, EVD04, EVD05, EVD06, EVD07, EVD08, EVD09,
	EVD10,
	TRCON, MONITRC, TRCMD,
	TMEMWAIT,
	TMEMA16, TMEMA15, TMEMA14, TMEMA13, TMEMA12, TMEMA11, TMEMA10, TMEMA9,
	TMEMA8,  TMEMA7,  TMEMA6,  TMEMA5,  TMEMA4,  TMEMA3,  TMEMA2,  TMEMA1, TMEMA0,
	TMEMCS_B, TMEMRD_B, TMEMWR_B,
	TMEMCLK2, TMEMCLK1, TMEMCLK0,
	TMEMD107, TMEMD106, TMEMD105, TMEMD104,	TMEMD103, TMEMD102, TMEMD101, TMEMD100, TMEMD99, TMEMD98,
	TMEMD97,  TMEMD96,  TMEMD95,  TMEMD94,  TMEMD93,  TMEMD92,  TMEMD91,  TMEMD90,  TMEMD89, TMEMD88,
	TMEMD87,  TMEMD86,  TMEMD85,  TMEMD84,  TMEMD83,  TMEMD82,  TMEMD81,  TMEMD80,  TMEMD79, TMEMD78,
	TMEMD77,  TMEMD76,  TMEMD75,  TMEMD74,  TMEMD73,  TMEMD72,  TMEMD71,  TMEMD70,  TMEMD69, TMEMD68,
	TMEMD67,  TMEMD66,  TMEMD65,  TMEMD64,  TMEMD63,  TMEMD62,  TMEMD61,  TMEMD60,  TMEMD59, TMEMD58,
	TMEMD57,  TMEMD56,  TMEMD55,  TMEMD54,  TMEMD53,  TMEMD52,  TMEMD51,  TMEMD50,  TMEMD49, TMEMD48,
	TMEMD47,  TMEMD46,  TMEMD45,  TMEMD44,  TMEMD43,  TMEMD42,  TMEMD41,  TMEMD40,  TMEMD39, TMEMD38,
	TMEMD37,  TMEMD36,  TMEMD35,  TMEMD34,  TMEMD33,  TMEMD32,  TMEMD31,  TMEMD30,  TMEMD29, TMEMD28,
	TMEMD27,  TMEMD26,  TMEMD25,  TMEMD24,  TMEMD23,  TMEMD22,  TMEMD21,  TMEMD20,  TMEMD19, TMEMD18,
	TMEMD17,  TMEMD16,  TMEMD15,  TMEMD14,  TMEMD13,  TMEMD12,  TMEMD11,  TMEMD10,  TMEMD9,  TMEMD8,
	TMEMD7,   TMEMD6,   TMEMD5,   TMEMD4,   TMEMD3,   TMEMD2,   TMEMD1,   TMEMD0
	);
// -----------------------------------------------------------------------------------------------------
input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28,	// Host I/F Address Bus			( <- eva_pcifg )
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
output	ICEDO31, ICEDO30, ICEDO29, ICEDO28,	// Host I/F Read Data Bus		( -> eva_pcifg )
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
input	IDADR31, IDADR30, IDADR29, IDADR28,	// Flash Fetch Data at Address Stage	( <- eva core )	
	IDADR27, IDADR26, IDADR25, IDADR24,	//							
	IDADR23, IDADR22, IDADR21, IDADR20,	//							
	IDADR19, IDADR18, IDADR17, IDADR16,	//							
	IDADR15, IDADR14, IDADR13, IDADR12,	//							
	IDADR11, IDADR10, IDADR9,  IDADR8,	//							
	IDADR7,  IDADR6,  IDADR5,  IDADR4,	//							
	IDADR3,  IDADR2,  IDADR1,  IDADR0;	//							
input	STAGEADR1, STAGEADR0;			// Internal Counter for Instruction	( <- eva core )	
input	PREFIX;					// PREFIX instruction signal		( <- eva core )	
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
input	EXMA3, EXMA2, EXMA1, EXMA0;		// ES Register output signal		( <- eva core )	
input	MA15, MA14, MA13, MA12, MA11,		// Memory Access Address		( <- eva core )	
	MA10, MA9, MA8, MA7, MA6,		//							
	MA5, MA4, MA3, MA2, MA1, MA0;		//							
input	IMDR15, IMDR14, IMDR13, IMDR12,		// Memory Read Bus (for trace data)	( <- eva core )	
	IMDR11, IMDR10, IMDR9, IMDR8,		//							
	IMDR7,  IMDR6,  IMDR5, IMDR4,		//							
	IMDR3,  IMDR2,  IMDR1, IMDR0;		//							
output	TRACEMDR15, TRACEMDR14, TRACEMDR13,	// Memory Read Bus (for data out)	( -> eva core )	
	TRACEMDR12, TRACEMDR11, TRACEMDR10,	//							
	TRACEMDR9,  TRACEMDR8,	TRACEMDR7,	//							
	TRACEMDR6,  TRACEMDR5,  TRACEMDR4,	//							
	TRACEMDR3,  TRACEMDR2,  TRACEMDR1,	//							
	TRACEMDR0;				//							
input	MDW15, MDW14, MDW13, MDW12, MDW11,	// Memory Write Bus			( <- eva core )	
	MDW10, MDW9, MDW8, MDW7, MDW6,		//							
	MDW5, MDW4, MDW3, MDW2, MDW1, MDW0;	//							
input	CPURD;					// Memory Read Strobe			( <- eva core )	
input	CPUWR;					// Memory Write Strobe			( <- eva core )	
input	WDOP;					// Word Access Status			( <- eva core )	
input	BASECK ;				// CPU Base Clock			( <- device pin )
input	ALT1;					// ALT1 Instruction			( <- eva core )	
input	SVMOD;					// Super Visor Mode signal		( <- eva core )	
input	SVMODUSER;				// User SVMOD				( <- break )	
input	SELFMODE;				// Flash Self mode signal		( <- flctl )	
input	SELFMODEDBG;				// Flash Self mode signal for softdebug	( <- flctl )	
input	SELEXMPC;				// PC == External Area			( <- failsafe )
input	SELRAMPC;				// PC == RAM Area			( <- failsafe )
input	SELROMPC;				// PC == Flash Area			( <- failsafe )
input	SELBRAMPC;				// PC == BRAM Area			( <- failsafe )
input	SELBFAPC;				// PC == BFA Area			( <- failsafe )
input	TAG31, TAG30, TAG29, TAG28, TAG27,	// Time Tag Data			( <- time_tag )	
	TAG26, TAG25, TAG24, TAG23, TAG22,	//							
	TAG21, TAG20, TAG19, TAG18, TAG17,	//							
	TAG16, TAG15, TAG14, TAG13, TAG12,	//							
	TAG11, TAG10, TAG9,  TAG8,  TAG7,	//							
	TAG6,  TAG5,  TAG4,  TAG3,  TAG2,	//							
	TAG1,  TAG0 ;				//							
input	TAGOVF ;				// Time Tag Over Flow Status		( <- time_tag )	
input	CLK30MHZ;				// Fixed 30MHz clock(System Clock)	( <- device pin )
input	CLK60MHZ;				// Fixed 60MHz clock(System Clock)	( <- clock )	
input	SYSRSOUTB;				// System Reset Signal			( <- resetctl )	
input	ICERESB;				// ice reset				( <- resetctl )	
input	CPURSOUTB;				// reset from 1chip macro		( <- 1chip macro )
input	TARRESB_NORM;				// Target Reset				( <- resetctl )	
input	ICEMSKICE;				// iceresb mask				( <- mask )	
input	ICEMSKTRST;				// tarresb mask				( <- mask )	
input	STEP;					// Step status				( <- break )	
input	INTACK;					// INT acknowledge			( <- 1chip )	
input	DMAACK;					// DMA acknowledge			( <- 1chip )	
output	BRKTRADY;				// Trace Delay Break			( -> break )	
output	BRKTRAFL;				// Trace Full Break			( -> break )	
input	EVD01;					// Delay event				( <- event )	
input	EVD02, EVD03, EVD04, EVD05,		// Section event			( <- event )	
	EVD06, EVD07, EVD08, EVD09;		//							
input	EVD10;					// Qualify event			( <- event )	
output	TRCON;					// TRCON Register output		( -> event )	
output	MONITRC;				// MONITRC Register output		( -> timetag )	
output	TRCMD;					// Trace Condition Signal		( -> event )	
output	TMEMWAIT;				// USB I/F(SG2 EXMEM-IF) Wait Signal	( -> host i/f )	
output	TMEMA16, TMEMA15, TMEMA14, TMEMA13,	// Trace Memory Address Bus		( -> device pin )
	TMEMA12, TMEMA11, TMEMA10, TMEMA9,	//							
	TMEMA8,  TMEMA7,  TMEMA6,  TMEMA5,	//							
	TMEMA4,  TMEMA3,  TMEMA2,  TMEMA1,	//							
	TMEMA0;					//							
output	TMEMCS_B;				// Trace Memory Chip Select		( -> device pin )
output	TMEMRD_B ;				// Trace Memory Read signal		( -> device pin )
output	TMEMWR_B ;				// Trace Memory Write Strobe		( -> device pin )
output	TMEMCLK2, TMEMCLK1, TMEMCLK0 ;		// Trace Memory Clock			( -> device pin )
inout	TMEMD107, TMEMD106, TMEMD105, TMEMD104,	// Trace Memory Data Bus		(<-> device pin )
	TMEMD103, TMEMD102, TMEMD101, TMEMD100,	//							
	TMEMD99,  TMEMD98,  TMEMD97,  TMEMD96,	//							
	TMEMD95,  TMEMD94,  TMEMD93,  TMEMD92,	//							
	TMEMD91,  TMEMD90,  TMEMD89,  TMEMD88,	//							
	TMEMD87,  TMEMD86,  TMEMD85,  TMEMD84,	//							
	TMEMD83,  TMEMD82,  TMEMD81,  TMEMD80,	//							
	TMEMD79,  TMEMD78,  TMEMD77,  TMEMD76,	//							
	TMEMD75,  TMEMD74,  TMEMD73,  TMEMD72,	//							
	TMEMD71,  TMEMD70,  TMEMD69,  TMEMD68,	//							
	TMEMD67,  TMEMD66,  TMEMD65,  TMEMD64,	//							
	TMEMD63,  TMEMD62,  TMEMD61,  TMEMD60,	//							
	TMEMD59,  TMEMD58,  TMEMD57,  TMEMD56,	//							
	TMEMD55,  TMEMD54,  TMEMD53,  TMEMD52,	//							
	TMEMD51,  TMEMD50,  TMEMD49,  TMEMD48,	//							
	TMEMD47,  TMEMD46,  TMEMD45,  TMEMD44,	//							
	TMEMD43,  TMEMD42,  TMEMD41,  TMEMD40,	//							
	TMEMD39,  TMEMD38,  TMEMD37,  TMEMD36,	//							
	TMEMD35,  TMEMD34,  TMEMD33,  TMEMD32,	//							
	TMEMD31,  TMEMD30,  TMEMD29,  TMEMD28,	//							
	TMEMD27,  TMEMD26,  TMEMD25,  TMEMD24,	//							
	TMEMD23,  TMEMD22,  TMEMD21,  TMEMD20,	//							
	TMEMD19,  TMEMD18,  TMEMD17,  TMEMD16,	//							
	TMEMD15,  TMEMD14,  TMEMD13,  TMEMD12,	//							
	TMEMD11,  TMEMD10,  TMEMD9,   TMEMD8,	//							
	TMEMD7,   TMEMD6,   TMEMD5,   TMEMD4,	//							
	TMEMD3,   TMEMD2,   TMEMD1,   TMEMD0 ;	//							
// -----------------------------------------------------------------------------------------------------
	wire [31:2]	iceifa;
	wire [31:0]	icedi;
	wire [31:0]	trace_hostif_ro;
	wire [31:0]	trace_cont_ro;
	wire [31:0]	trace_delay_ro;
	wire [31:0]	tradr_ro;
	wire [31:0]	trdata_ro;
	wire [19:0]	pc;
	wire [3:0]	exma;
	wire [15:0]	ma;
	wire [15:0]	mdr;
	wire [15:0]	mdw;
	wire [3:0]	flreadb;
	wire [31:0]	pid;
	wire [31:0]	tag;
	wire [16:0]	tra;
	wire [13:0]	snapdt_cs;
	wire [107:0]	snapdt;
	wire [15:0]	snap_shot_ro;
	wire		trace_cont_altro;
	wire [16:0]	host_adr;
	wire [107:0]	hostwd;
	wire [31:0]	idadr;
	wire [31:0]	trcfact;
	wire		usbwait_trcmode, usbwait_hostif;
// -----------------------------------------------------------------------------------------------------
	assign	iceifa = {
			ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26,
			ICEIFA25, ICEIFA24, ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
			ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16, ICEIFA15, ICEIFA14,
			ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
			ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2
		} ;
	assign	icedi = {
			ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26,
			ICEDI25, ICEDI24, ICEDI23, ICEDI22, ICEDI21, ICEDI20,
			ICEDI19, ICEDI18, ICEDI17, ICEDI16, ICEDI15, ICEDI14,
			ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
			ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2,
			ICEDI1, ICEDI0
		} ;
	assign	{ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
		 ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
		 ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
		 ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0}
		= trace_hostif_ro |
		  trace_cont_ro |
		  trace_delay_ro |
		  tradr_ro |
		  trdata_ro |
		  trcfact;

	assign	pc = {	PC19, PC18, PC17, PC16, PC15, PC14, PC13, PC12,	PC11, PC10,
			PC9, PC8, PC7, PC6, PC5, PC4, PC3, PC2, PC1, PC0};

	assign	idadr = {IDADR31, IDADR30, IDADR29, IDADR28, IDADR27, IDADR26, IDADR25, IDADR24,
			 IDADR23, IDADR22, IDADR21, IDADR20, IDADR19, IDADR18, IDADR17, IDADR16,
			 IDADR15, IDADR14, IDADR13, IDADR12, IDADR11, IDADR10, IDADR9,  IDADR8,
			 IDADR7,  IDADR6,  IDADR5,  IDADR4,  IDADR3,  IDADR2,  IDADR1,  IDADR0};

	assign	exma = {EXMA3, EXMA2, EXMA1, EXMA0};

	assign	ma = {MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8, MA7, MA6, MA5, MA4, MA3, MA2,MA1, MA0};

	assign	mdr = {	IMDR15, IMDR14, IMDR13, IMDR12, IMDR11, IMDR10, IMDR9, IMDR8,
			IMDR7, IMDR6, IMDR5, IMDR4, IMDR3, IMDR2, IMDR1, IMDR0 };

	assign	{TRACEMDR15, TRACEMDR14, TRACEMDR13, TRACEMDR12, TRACEMDR11, TRACEMDR10,
		 TRACEMDR9,  TRACEMDR8,  TRACEMDR7,  TRACEMDR6,  TRACEMDR5,  TRACEMDR4,
		 TRACEMDR3,  TRACEMDR2,  TRACEMDR1, TRACEMDR0} = snap_shot_ro | {7'b0, trace_cont_altro, 8'b0};

	assign	mdw = {	MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8,
			MDW7, MDW6, MDW5, MDW4, MDW3, MDW2, MDW1, MDW0 };

	assign	flreadb = {FLREADB3, FLREADB2, FLREADB1, FLREADB0};

	assign	pid = {	EROMPD31, EROMPD30, EROMPD29, EROMPD28, EROMPD27, EROMPD26, EROMPD25, EROMPD24, 
			EROMPD23, EROMPD22, EROMPD21, EROMPD20, EROMPD19, EROMPD18, EROMPD17, EROMPD16, 
			EROMPD15, EROMPD14, EROMPD13, EROMPD12, EROMPD11, EROMPD10, EROMPD9 , EROMPD8 ,
			EROMPD7 , EROMPD6 , EROMPD5 , EROMPD4 , EROMPD3 , EROMPD2 , EROMPD1 , EROMPD0 }; 

	assign	tag = {	TAG31, TAG30, TAG29, TAG28, TAG27, TAG26, TAG25, TAG24,
			TAG23, TAG22, TAG21, TAG20, TAG19, TAG18, TAG17, TAG16,
			TAG15, TAG14, TAG13, TAG12, TAG11, TAG10, TAG9,  TAG8,
			TAG7,  TAG6,  TAG5,  TAG4,  TAG3,  TAG2,  TAG1,  TAG0 };

	assign	{TMEMA16, TMEMA15, TMEMA14, TMEMA13, TMEMA12, TMEMA11, TMEMA10, TMEMA9,
		 TMEMA8, TMEMA7, TMEMA6, TMEMA5, TMEMA4, TMEMA3, TMEMA2, TMEMA1, TMEMA0} = tra;

	assign	TMEMWAIT = usbwait_trcmode | usbwait_hostif;

// -----------------------------------------------------------------------------------------------------
	trace_hostif	hostif (
			.trmem_host_cs(trmem_host_cs), .icewr(ICEWR), .hostwd0_cs(hostwd0_cs),
			.hostwd1_cs(hostwd1_cs), .hostwd2_cs(hostwd2_cs), .hostwd3_cs(hostwd3_cs),
			.sysrsoutb(SYSRSOUTB), .clk30mhz(CLK30MHZ), .iceifa(iceifa[20:4]),
			.icedi(icedi), .usbwait_hostif(usbwait_hostif), .host_read(host_read),
			.host_write(host_write), .host_adr(host_adr), .hostwd(hostwd),
			.trace_hostif_ro(trace_hostif_ro)
	);
	
	trace_cont	trace_cont (
			.icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .trcmode_cs(trcmode_cs),
			.trctest_cs(trctest_cs), .trace_altcs(trace_altcs), .baseck(BASECK),
			.svmod(SVMOD), .pcwaitf_l(pcwaitf_l), .waitexm(WAITEXM), .svmoduser(SVMODUSER),
			.selfmodedbg(SELFMODEDBG), .fetch_l2(fetch_l2), .mrd_l1(mrd_l1),
			.mwr_l1(mwr_l1), .mrd_l2(mrd_l2), .mwr_l2(mwr_l2),
			.trmem_host_cs(trmem_host_cs), .host_read(host_read), .host_write(host_write),
			.host_clk(CLK30MHZ), .full_stop(full_stop), .delay_stop(delay_stop),
			.trcon_clr_trace_delay(trcon_clr_trace_delay), .snapdten(snapdten),
			.qualify_event(EVD10), .section_en(section_en), .mask_reset(mask_reset),
			.monitrc_cs(monitrc_cs), .cpuwr(CPUWR), .mdw8(mdw[8]), .icedi5(icedi[5]),
			.icedi3_0(icedi[3:0]), .monitrc(MONITRC), .monitrc1_f(monitrc1_f),
			.trctest(trctest), .trcon(TRCON), .trcon1_f(trcon1_f), .trcmd(TRCMD),
			.trcdlymode1(trcdlymode1), .trcdlymode0(trcdlymode0), .wpulse(wpulse),
			.svmod_fch(svmod_fch), .svmod_acc(svmod_acc),
			.trcon_clr_dlybrk(trcon_clr_dlybrk), .we_snap(we_snap),
			.svmod_delay(svmod_delay), .usbwait_trcmode(usbwait_trcmode),
			.tmemcsb_d(TMEMCS_B), .tmemrdb_d(TMEMRD_B), .tmemwrb_d(TMEMWR_B),
			.tmemclk({TMEMCLK2, TMEMCLK1, TMEMCLK0}),
			.trace_cont_ro(trace_cont_ro), .trace_cont_altro(trace_cont_altro)
	) ;
	
	trace_delay	trace_delay (
			.icewr(ICEWR), .sysrsoutb(SYSRSOUTB), .baseck(BASECK), .wpulse(wpulse),
			.svmod_delay(svmod_delay), .dly_event(EVD01), .trcdlymode1(trcdlymode1),
			.trcdlymode0(trcdlymode0), .we_snap(we_snap), .trctest(trctest),
			.snapdt(snapdt[65]), .trdlydt_cs(trdlydt_cs), .trdlyrd_cs(trdlyrd_cs),
			.trcdlyactclr_cs(trcdlyactclr_cs), .trcdlyendclr_cs(trcdlyendclr_cs),
			.trcon_clr_dlybrk(trcon_clr_dlybrk), .icedi(icedi[16:0]),
			.full_stop(full_stop), .delay_stop(delay_stop), .full_break(BRKTRAFL),
			.delay_break(BRKTRADY), .trcon_clr_trace_delay(trcon_clr_trace_delay),
			.trcdly(trcdly), .delay_bit(delay_bit), .trace_delay_ro(trace_delay_ro)
	);
	
	section_trace	section_trace (
			.baseck(BASECK), .sysrsoutb(SYSRSOUTB), .secclr_cs(secclr_cs), .icewr(ICEWR),
			.secon_event({EVD08, EVD06, EVD04, EVD02}),
			.secoff_event({EVD09, EVD07, EVD05, EVD03}), .section_en(section_en)
	);
	
	snap_shot	snap_shot (
			.baseck(BASECK), .sysrsoutb(SYSRSOUTB), .cpuwr(CPUWR), .snapdt_cs(snapdt_cs),
			.mdw(mdw), .snapdt(snapdt), .snap_shot_ro(snap_shot_ro)
	);
	
	tradr		tradr (
			.trcmem_cs(trcmem_cs), .trcadr_cs(trcadr_cs), .traovfcl_cs(traovfcl_cs),
			.trcard_cs(trcard_cs), .trmem_host_cs(trmem_host_cs), .monitrc1_f(monitrc1_f),
			.trcon1_f(trcon1_f), .baseck(BASECK), .icewr(ICEWR), .sysrsoutb(SYSRSOUTB),
			.wpulse(wpulse), .icedi(icedi[16:0]), .host_adr(host_adr), .tradr_ro(tradr_ro),
			.tra(tra), .traovf(traovf)
	) ;
	
	trdata		trdata (
			.baseck(BASECK), .clk60mhz(CLK60MHZ), .sysrsoutb(SYSRSOUTB), .wpulse(wpulse),
			.svmod_fch(svmod_fch), .svmod_acc(svmod_acc), .trcon(TRCON), .monitrc(MONITRC),
			.host_write(host_write), .trmem_host_cs(trmem_host_cs), .iceifa(iceifa[3:2]),
			.icedi(icedi[1:0]), .icewr(ICEWR), .trdsel_cs(trdsel_cs), .pc(pc),
			.idadr(idadr), .exma(exma), .ma(ma), .mdr(mdr), .mdw(mdw),
			.stageadr({STAGEADR1, STAGEADR0}), .pcwaitf(PCWAITF), .waitexm(WAITEXM), .ocdwait(OCDWAIT),
			.cpurd(CPURD), .cpuwr(CPUWR), .skipexe(SKIPEXE), .fchram(FCHRAM),
			.cpumask(CPUMASK), .wdop(WDOP), .prefix(PREFIX), .flread(FLREAD),
			.flreadb(flreadb), .pid(pid), .qualify_event(EVD10), .section_en(section_en),
			.step(STEP), .intack(INTACK), .dmaack(DMAACK), .iceresb(ICERESB),
			.cpursoutb(CPURSOUTB), .tarresb(TARRESB_NORM), .icemskice(ICEMSKICE),
			.icemsktrst(ICEMSKTRST), .we_snap(we_snap),
			.snapdt({snapdt[107:66], delay_bit, snapdt[64:0]}), .trctest(trctest),
			.hostwd(hostwd), .tag(tag), .tagovf(TAGOVF), .selfmode(SELFMODE),
			.selexmpc(SELEXMPC), .selrampc(SELRAMPC), .selrompc(SELROMPC), .selbrampc(SELBRAMPC),
			.selbfapc(SELBFAPC), .fetch_l2(fetch_l2), .mrd_l1(mrd_l1), .mwr_l1(mwr_l1),
			.mrd_l2(mrd_l2), .mwr_l2(mwr_l2), .pcwaitf_l(pcwaitf_l), .mask_reset(mask_reset),
			.trdata_ro(trdata_ro),
			.trd({
			TMEMD107, TMEMD106, TMEMD105,
			TMEMD104, TMEMD103, TMEMD102, TMEMD101, TMEMD100,
			TMEMD99,  TMEMD98,  TMEMD97,  TMEMD96,  TMEMD95,
			TMEMD94,  TMEMD93,  TMEMD92,  TMEMD91,  TMEMD90,
			TMEMD89,  TMEMD88,  TMEMD87,  TMEMD86,  TMEMD85,
			TMEMD84,  TMEMD83,  TMEMD82,  TMEMD81,  TMEMD80,
			TMEMD79,  TMEMD78,  TMEMD77,  TMEMD76,  TMEMD75,
			TMEMD74,  TMEMD73,  TMEMD72,  TMEMD71,  TMEMD70,
			TMEMD69,  TMEMD68,  TMEMD67,  TMEMD66,  TMEMD65,
			TMEMD64,  TMEMD63,  TMEMD62,  TMEMD61,  TMEMD60,
			TMEMD59,  TMEMD58,  TMEMD57,  TMEMD56,  TMEMD55,
			TMEMD54,  TMEMD53,  TMEMD52,  TMEMD51,  TMEMD50,
			TMEMD49,  TMEMD48,  TMEMD47,  TMEMD46,  TMEMD45,
			TMEMD44,  TMEMD43,  TMEMD42,  TMEMD41,  TMEMD40,
			TMEMD39,  TMEMD38,  TMEMD37,  TMEMD36,  TMEMD35,
			TMEMD34,  TMEMD33,  TMEMD32,  TMEMD31,  TMEMD30,
			TMEMD29,  TMEMD28,  TMEMD27,  TMEMD26,  TMEMD25,
			TMEMD24,  TMEMD23,  TMEMD22,  TMEMD21,  TMEMD20,
			TMEMD19,  TMEMD18,  TMEMD17,  TMEMD16,  TMEMD15,
			TMEMD14,  TMEMD13,  TMEMD12,  TMEMD11,  TMEMD10,
			TMEMD9,   TMEMD8,   TMEMD7,   TMEMD6,   TMEMD5,
			TMEMD4,   TMEMD3,   TMEMD2,   TMEMD1,   TMEMD0})
	) ;
	
	trace_cs	trace_cs (
			.iceifa(iceifa), .ma(ma), .alt1(ALT1), .svmod(SVMOD), .cpuwr(CPUWR),
			.wdop(WDOP), .trctest(trctest), .trcmode_cs(trcmode_cs),
			.trdlydt_cs(trdlydt_cs), .trdlyrd_cs(trdlyrd_cs), .trcadr_cs(trcadr_cs),
			.trcard_cs(trcard_cs), .trcmem_cs(trcmem_cs), .trcfact_cs(trcfact_cs),
			.trcdlyendclr_cs(trcdlyendclr_cs), .secclr_cs(secclr_cs),
			.traovfcl_cs(traovfcl_cs), .trcdlyactclr_cs(trcdlyactclr_cs),
			.hostwd0_cs(hostwd0_cs), .hostwd1_cs(hostwd1_cs), .hostwd2_cs(hostwd2_cs),
			.hostwd3_cs(hostwd3_cs), .trdsel_cs(trdsel_cs), .trctest_cs(trctest_cs),
			.monitrc_cs(monitrc_cs), .snapdt_cs(snapdt_cs), .snapdten(snapdten),
			.trace_altcs(trace_altcs), .trmem_host_cs(trmem_host_cs)
	);

// ------------------------------------------------------------------------------------------------------
// Flag Register											-
// ------------------------------------------------------------------------------------------------------
	assign	trcfact = trcfact_cs ? { 28'b0, traovf, TAGOVF, trcdly, 1'b0 } : 32'b0;

endmodule


// ======================================================================================================
// host i/f												=
// ======================================================================================================

	/* --------------------------------------------	*/
	/* iceifa         =============================	*/
	/* icewr          ~~~~~~~|_____________________	*/
	/* usbclk         ~|__|~~|__|~~|__|~~|___|~~|__	*/
	/* hostwd         =============================	*/
	/* hostwritestart    ____|~~~~~~~~~~|__________	*/
	/* hostwritestart_l1 _______|~~~~~~~|__________	*/
	/* hostwritestart_l2 ___________|~~~|__________	*/
	/* clk30mhz          _|~|_|~|_|~|_|~|_|~|_|~|_	*/
	/*						*/
	/* usbwait_hostif _______|~~~~~~~~~~~~~~~~~~|__	*/
	/*						*/
	/* host_read      ~~~~~~~~~~~~~~~~~~|_______|~~	*/
	/* host_write     ____________________|~~~|____	*/
	/* --------------------------------------------	*/

module trace_hostif (
		trmem_host_cs, icewr, hostwd0_cs, hostwd1_cs, hostwd2_cs, hostwd3_cs, sysrsoutb,
		clk30mhz, iceifa, icedi, usbwait_hostif, host_read, host_write, host_adr, hostwd,
		trace_hostif_ro
	);

	input		trmem_host_cs, icewr, hostwd0_cs, hostwd1_cs, hostwd2_cs, hostwd3_cs;
	input		sysrsoutb, clk30mhz;
	input [20:4]	iceifa;
	input [31:0]	icedi;
	output		usbwait_hostif;
	output		host_read, host_write;
	output [16:0]	host_adr;
	output [107:0]	hostwd;
	output [31:0]	trace_hostif_ro;

	reg [31:0]	hostwd0, hostwd1, hostwd2, trace_hostif_ro;
	reg [11:0]	hostwd3;

	wire [107:0]	hostwd;
	wire		host_res1;

	assign	host_adr = iceifa;

	assign	host_res1 = sysrsoutb & host_read;
	reg hostwritestart;
	always @( negedge icewr or negedge host_res1 ) begin
		if (!host_res1)
			hostwritestart <= 1'b0;
		else if (trmem_host_cs)
			hostwritestart <= 1'b1;
	end
	reg hostwritestart_l1;
	always @( negedge clk30mhz or negedge host_res1 ) begin
		if (!host_res1)	hostwritestart_l1 <= 1'b0;
		else		hostwritestart_l1 <= hostwritestart;
	end
	reg hostwritestart_l2;
	always @( negedge clk30mhz or negedge host_res1 ) begin
		if (!host_res1)	hostwritestart_l2 <= 1'b0;
		else		hostwritestart_l2 <= hostwritestart_l1;
	end
	
	reg host_read;
	always @( negedge clk30mhz or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			host_read <= 1'b1;
		else if (hostwritestart_l2)
			host_read <= 1'b0;
		else if (!host_write)
			host_read <= 1'b1;
	end
	reg host_read_l1;
	always @( negedge clk30mhz or negedge sysrsoutb ) begin
		if (!sysrsoutb)	host_read_l1 <= 1'b0;
		else		host_read_l1 <= host_read;
	end
	wire usbwait_hostif_reset;
	assign usbwait_hostif_reset = !sysrsoutb | host_read & ~host_read_l1;
	
	reg host_write;
	always @( posedge clk30mhz or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			host_write <= 1'b0;
		else if (!host_read & !host_write)
			host_write <= 1'b1;
		else	host_write <= 1'b0;
	end
	
	reg usbwait_hostif;
	always @(negedge icewr or posedge usbwait_hostif_reset) begin
		if (usbwait_hostif_reset)
			usbwait_hostif <= 1'b0;
		else if (trmem_host_cs)
			usbwait_hostif <= 1'b1;
	end

/* --------------- */
/* hostwd register */
/* --------------- */
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)		hostwd0 <= 32'b0;
		else if (hostwd0_cs)	hostwd0 <= icedi;
	end
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)		hostwd1 <= 32'b0;
		else if (hostwd1_cs)	hostwd1 <= icedi;
	end
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)		hostwd2 <= 32'b0;
		else if (hostwd2_cs)	hostwd2 <= icedi;
	end
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb)		hostwd3 <= 12'b0;
		else if (hostwd3_cs)	hostwd3 <= icedi[11:0];
	end

	assign	hostwd = {hostwd3[11:8], hostwd2, hostwd3[7:4], hostwd1, hostwd3[3:0], hostwd0};

	always @(hostwd0_cs or hostwd1_cs or hostwd2_cs or hostwd3_cs or hostwd0 or hostwd1 or hostwd2 or hostwd3) begin
		case ({hostwd0_cs, hostwd1_cs, hostwd2_cs, hostwd3_cs})
			4'b1000	: trace_hostif_ro = hostwd0;
			4'b0100	: trace_hostif_ro = hostwd1;
			4'b0010	: trace_hostif_ro = hostwd2;
			4'b0001	: trace_hostif_ro = {20'b0, hostwd3};
			default	: trace_hostif_ro = 32'b0;
		endcase
	end

endmodule


// ======================================================================================================
// trace control											=
// ======================================================================================================
module trace_cont (
		icewr, sysrsoutb, trcmode_cs, trctest_cs, trace_altcs, baseck, svmod, pcwaitf_l, waitexm,
		svmoduser, selfmodedbg, fetch_l2, mrd_l1, mwr_l1, mrd_l2, mwr_l2, trmem_host_cs,
		host_read, host_write, host_clk, full_stop, delay_stop, trcon_clr_trace_delay, snapdten,
		qualify_event, section_en, mask_reset, monitrc_cs, cpuwr, mdw8, icedi5, icedi3_0,
		monitrc, monitrc1_f, trctest, trcon, trcon1_f, trcmd, trcdlymode1, trcdlymode0,
		wpulse, svmod_fch, svmod_acc, trcon_clr_dlybrk, we_snap, svmod_delay, usbwait_trcmode,
		tmemcsb_d, tmemrdb_d, tmemwrb_d, tmemclk, trace_cont_ro, trace_cont_altro
	) ;

	input		icewr, sysrsoutb, trcmode_cs, trctest_cs, trace_altcs, baseck, svmod,
			pcwaitf_l, waitexm, svmoduser, selfmodedbg, fetch_l2, mrd_l1, mwr_l1, mrd_l2,
			mwr_l2, trmem_host_cs, host_read, host_write, host_clk, full_stop, delay_stop,
			trcon_clr_trace_delay, snapdten, qualify_event, section_en, mask_reset,
			monitrc_cs, cpuwr, mdw8, icedi5;
	input [3:0]	icedi3_0;
	output		monitrc, monitrc1_f, trctest, trcon, trcon1_f, trcmd, trcdlymode1,
			trcdlymode0, wpulse, svmod_fch, svmod_acc, trcon_clr_dlybrk, we_snap,
			svmod_delay, usbwait_trcmode, tmemcsb_d, tmemrdb_d, tmemwrb_d;
	output [2:0]	tmemclk;
	output [31:0]	trace_cont_ro;
	output		trace_cont_altro;

	reg		trctest_p, trctest, trcdlymode1, trcdlymode0, trcmd,
			moni_host_start, moni_host_data, moni_host_set, monitrc1, monitrc1_f,
			monitrc2, monitrc_f, trcon_p, trcon1, trcon1_f,
			trcon2, trcon_f, svmod_l1, svmod_delay, svmod_acc,
			svmoduser_l1_fch, svmod_strobe_l1_fch,
			wpulse, trcon_clr_dlystop, trcon_clr_dlybrk, trace_altcs_l1,
			selfmodedbg_l1, selfmodedbg_l2, waitexm_l;
	reg [31:0]	trace_cont_ro;
	wire		monitrc, moni_host_res, trcon, trcon_p_clr, we_com1, we_com2, we_com3,
			we_monitor, we_full, we_section, we_qualify, we_snap, we_trctest,
			host_access, tmemcsb, tmemwrb, tmemrdb, svmod_strobe, svmod_fch;
	wire		trcon_dmy, monitrc_dmy;
	wire		tmemclk_drv;

/* ------- */
/* trctest */
/* ------- */
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb) trctest_p <= 1'b0;
		else if (trctest_cs) trctest_p <= icedi3_0[0];
	end
	/* measures against meta-stable */
	reg trctest_p_l1;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) trctest_p_l1 <= 1'b0;
		else		trctest_p_l1 <= trctest_p;
	end
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) trctest <= 1'b0;
		else trctest <= trctest_p_l1;
	end

/* ------------------------------- */
/* trcdlymode1, trcdlymode0, trcmd */
/* ------------------------------- */
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb) begin trcdlymode1 <= 1'b0; trcdlymode0 <= 1'b0; trcmd <= 1'b0; end
		else if (trcmode_cs) begin
			trcdlymode1 <= icedi3_0[3];
			trcdlymode0 <= icedi3_0[2];
			trcmd <= icedi3_0[1];
		end
	end

/* ------- */
/* monitrc */
/* ------- */
	assign	moni_host_res = !sysrsoutb | moni_host_set;
	always @( negedge icewr or posedge moni_host_res ) begin
		if (moni_host_res)	moni_host_start <= 1'b0;
		else if (trcmode_cs)	moni_host_start <= 1'b1;
	end

	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)		moni_host_data <= 1'b0;
		else if (trcmode_cs)	moni_host_data <= icedi5;
	end

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	moni_host_set <= 1'b0;
		else		moni_host_set <= moni_host_start;
	end
	
	/* measures against meta-stable */
	reg moni_host_set_l1;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	moni_host_set_l1 <= 1'b0;
		else		moni_host_set_l1 <= moni_host_set;
	end
		
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			monitrc1 <= 1'b0;
		else if (moni_host_set_l1)
			monitrc1 <= moni_host_data;
		else if (monitrc_cs & cpuwr)
			monitrc1 <= mdw8;
	end
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) monitrc1_f <= 1'b0;
		else monitrc1_f <= monitrc1;
	end

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	monitrc2 <= 1'b0;
		else monitrc2 <= monitrc1_f;
	end

	assign	monitrc = monitrc1 | monitrc1_f | monitrc2;

	/* host_access$B$r(Bactive$B$K$9$k(Btiming$BMQ(B */
 	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) monitrc_f <= 1'b0;
		else monitrc_f <= monitrc;
	end
	
/* ------ */
/* trcon1 */
/* ------ */
	/* delay_stop,full_stop$B$K$h$k(Btrcon_p$B$N(Bclear */
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	trcon_clr_dlystop <= 1'b0;
		else if (full_stop | delay_stop)
			trcon_clr_dlystop <= 1'b1;
		else	trcon_clr_dlystop <= 1'b0;
	end

	/* delay_break,full_break$B$K$h$k(Btrcon_p$B$N(Bclear */
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	trcon_clr_dlybrk <= 1'b0;
		else if (trcon_clr_trace_delay & trcon1) /* $BD>$K(B0$B$KLa$7$?$$$N$G(Btrcon1$B$r;HMQ(B */
			trcon_clr_dlybrk <= 1'b1;	/* trcdly2$B$N(Bclear$B$K;HMQ(B */
		else	trcon_clr_dlybrk <= 1'b0;
	end


	assign	trcon_p_clr = trcon_clr_dlystop | trcon_clr_dlybrk | ~sysrsoutb;
	always @(negedge icewr or posedge trcon_p_clr) begin
		if (trcon_p_clr) trcon_p <= 1'b0;
		else if (trcmode_cs) trcon_p <= icedi3_0[0];
	end

	/* measures against meta-stable */
	reg trcon_p_l1;
	always @(posedge baseck or posedge trcon_p_clr) begin
		if (trcon_p_clr)trcon_p_l1 <= 1'b0;
		else		trcon_p_l1 <= trcon_p;
	end
	reg trcon_p_l2;
	always @(posedge baseck or posedge trcon_p_clr) begin
		if (trcon_p_clr)trcon_p_l2 <= 1'b0;
		else		trcon_p_l2 <= trcon_p_l1;
	end

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	trcon1 <= 1'b0;
		else if (trcon_clr_trace_delay | full_stop | delay_stop)
			trcon1 <= 1'b0;
		else	trcon1 <= trcon_p_l2;
	end

	always @( trcmode_cs or trctest_cs or monitrc or trcdlymode1 or trcdlymode0 or trcmd or trcon or trctest) begin
		case ({trcmode_cs, trctest_cs})
			2'b10	: trace_cont_ro = {26'b0, monitrc, 1'b0, trcdlymode1, trcdlymode0, trcmd, trcon}; /* not trcon1 */
			2'b01	: trace_cont_ro = {31'b0, trctest} ;
			default	: trace_cont_ro = 32'b0;
		endcase
	end

	assign	trace_cont_altro = monitrc_cs ? monitrc1 : 1'b0; /* imdr$B$X$N=PNO$OCY1d$G$-$J$$$N$G(Bminitrc1$B$r=PNO(B */

/* ----- */
/* trcon */
/* ----- */

	/* ----------------------------------------------------	*/ /* -----------------------------------------	*/
	/* baseck _|~|_|~|_|~|_|~|_|~|_				*/ /* baseck	_|~|_|~|_|~|_|~|_|~|_		*/
	/* trcon1 _____|~~~|___________				*/ /* delay_stop_________|~~~|_______		*/
	/* wpulse _________|~~~|_______				*/ /* trcon1	~~~~~~~~~~~~~|_______		*/
	/* trcon  _____|~~~~~~~~~~~|___				*/ /* trcon1_f	~~~~~~~~~~~~~|_______		*/
	/* tmemclk      <-baseck -> <- host_clk ->		*/ /* trcon2	~~~~~~~~~~~~~~~~~|___		*/
	/* wpulse-active$BCf$N(Bclock$B@ZBX$r$J$/$9(B			*/ /* trcon	~~~~~~~~~~~~~~~~~|___		*/
	/* $B!&(Brun$BCf$N(Btrcon-on/off$B$G(B,tmemwr_b active$BCf$K(Btmemclk$B$,(B	*/ /* tra	=x===x===x===x=======		*/
	/* $B%R%2$K$J$i$J$$$h$&(B,$BF1MM$K(Btrcon-off$B8e$K(BAddressCounter	*/ /* wpulse	~~~~~~~~~~~~~|_______		*/
	/* $B$,(BCountUp$B$5$l$J$$$h$&(B,trcon-off$B$N(Btiming$B$K:Y9)$9$k(B.	*/ /* $B!&(Bwpulse$B$O(Btrcon1$B$H(Bdelay_stop$B$G(Binactive	*/
	/* $B!&(Bwpule$B@8@.$K$O(Btrcon1$B$r;HMQ$9$k(B.			*/ /* $B!&(Btrcon$B$b(Bdelay_stop$B$N<!$N",$^$G$G@Z$k(B	*/
	/* ----------------------------------------------------	*/ /* -----------------------------------------	*/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	trcon1_f <= 1'b0;
		else if (trcon_clr_trace_delay | full_stop | delay_stop)
			trcon1_f <= 1'b0;
		else	trcon1_f <= trcon1;
	end
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) trcon2 <= 1'b0;
		else trcon2 <= trcon1_f;
	end
	assign	trcon = trcon1 | trcon1_f | trcon2;

	/* host_access$B$r(Bactive$B$K$9$k(Btiming$BMQ(B */
	always @( posedge baseck or negedge sysrsoutb ) begin
		if(!sysrsoutb) trcon_f <= 1'b0;
		else trcon_f <= trcon;
	end

/* ----------------- */
/* Wait for Host I/F */
/* ----------------- */

	/* ------------------------------------------------------------------------------------	*/
	/* trcon, monitrc$B$O(B,baseck$B$GF14|2=$7$F$$$k0Y(B,baseck$B$,CY$$>l9g$K(Bhost$B$+$i$N<!$N@_Dj$,(B	*/
	/* trcon, monitrc$B$N@_Dj$rDI$$H4$$$F$7$^$&2DG=@-$,$"$k0Y(B,USB I/F$B$KBP$7$F(BWait$B$rF~$l$k(B.	*/
	/* $B$^$?(B,Meta-Stable$BBP:v$r7s$M$k(B.							*/
	/* TraceMemoryI/F$B$N(BClock$B$H(BAddress$B$N@Z$jBX$o$j$r$=$l$>$l(BClock:(trcon | monitrc),Address:	*/
	/* (~monitrc1_f & ~trcon1_f & trmem_host_cs)$B$H$7(B,auto->host$B;~$O(BAddress$B@ZBX(B->Clock$B@ZBX(B,	*/
	/* $B$^$?(B,$B$=$N5U$H$$$&$h$&$K@Z$jBX$($F$$$k(B.						*/
	/* $B$3$N(BClock$B$N@Z$jBX$j;~$K(BAddress$B$,JQ2=$7$J$$$h$&(B,Wait$B?.9f$rF~$l$k(B.			*/
	/* ------------------------------------------------------------------------------------	*/
	
	/* host$B$+$i$N(Bmonitrc=off$B;~(B */
	reg usbwait_monitor_off;
	always @( negedge icewr or negedge monitrc ) begin
		if (!monitrc)
			usbwait_monitor_off <= 1'b0;
		else if (trcmode_cs & !icedi5 & monitrc)
			usbwait_monitor_off <= 1'b1;
	end
	/* alternate$B$+$i$N(Bmonitrc=off$B;~(B */
	reg usbwait_alt_monitor_off;
	always @( negedge monitrc1 or negedge monitrc ) begin
		if (!monitrc)
			usbwait_alt_monitor_off <= 1'b0;
		else if (!monitrc1)
			usbwait_alt_monitor_off <= 1'b1;
	end
	/* host$B$+$i$N(Bmonitor=on$B;~(B */
	wire usbwait_monitor_on_reset;
	assign	usbwait_monitor_on_reset = !sysrsoutb | monitrc1_f;
	reg usbwait_monitor_on;
	always @( negedge icewr or posedge usbwait_monitor_on_reset ) begin
		if (usbwait_monitor_on_reset)
			usbwait_monitor_on <= 1'b0;
		else if (trcmode_cs & icedi5 & !monitrc)
			usbwait_monitor_on <= 1'b1;
	end
	/* alternate$B$+$i$N(Bmonitrc=on$B;~(B */
	reg usbwait_alt_monitor_on;
	always @( posedge monitrc1 or posedge usbwait_monitor_on_reset ) begin
		if (usbwait_monitor_on_reset)
			usbwait_alt_monitor_on <= 1'b0;
		else if (monitrc1)
			usbwait_alt_monitor_on <= 1'b1;
	end
	/* trcon=1$B;~(B, trcon=0$B;~(B */
	wire usbwait_trcon;
	assign	usbwait_trcon = (~trcon_p & trcon) | (trcon_p & ~trcon1_f);

	assign	usbwait_trcmode = usbwait_trcon |
				  usbwait_monitor_off | usbwait_alt_monitor_off |
				  usbwait_monitor_on | usbwait_alt_monitor_on;

/* ----- */
/* svmod */
/* ----- */
	/* --------------------------------------------------------------------------------------------------------------- */
	/* $B!&0l=V(BBreak$B;~(B,pre-fetch(pc$B$N@hFI$_(B)$B$r(Btrace$B$7(B,break$B8e:G=i$N(Bfetch$B$O(Bmask$B$9$k(B.                                      */
	/* $B!&(BUserBreak$B;~(B,svmod$BA08e6&$K(Bmask$B$7$J$$(B.                                                                          */
	/* $B!&(BSoftwareBreak$B;~$O(Bpre-fetch$B$,L5$$$,(B,SoftwareBreakCode$B<+BN$r(Btrace$B$7$J$$$N$G(Bexec$B$N=hM}$OB>$N(Bbreak$B;~$HF1MM$K$J$k(B. */
	/* --------------------------------------------------------------------------------------------------------------- */

/* svmod_acc */
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	svmod_acc <= 1'b0;
		else svmod_acc <= svmod;
	end

/* svmod_fch */
	/* --------------------------------------------	*/ /* -$BF~$j8}$K(Bwait-----------------------  */ /* -$B=P8}$K(Bwait----------------------- */
	/* svmod_xxx$B$O(Bfch_l2,mrd_l2,mwr_l2$B$N(Bmask$B$K;HMQ(B.	*/ /*  baseck    |~|_|~|_|~|_|~|_|~|_|~|_   */ /* baseck    |~|_|~|_|~|_|~|_|~|_|~|_ */
	/* wpulse$B$N(Bmask$B?.9f$H$7$F;H$&$H<!$N(Bcase$B$GLdBj(B.	*/ /*  pc            x===========x          */ /* pc        x===========x            */
	/* baseck    |~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_	*/ /*  svmod     |_______|~~~~~~~~~~~       */ /* svmod     ~~~~~~~~|_______________ */
	/* pc            x===========x			*/ /*  stage_adr ======0=====x=1=x=2=x=3=   */ /* stage_adr                          */
	/* svmod     ________|~~~~~~~~~~~		*/ /*  fch_adr           x===========x      */ /* fch_adr       x===========x        */
	/* pcwaitf   ____|~~~|_________			*/ /*  pcwaitf   ____|~~~|_________         */ /* pcwaitf   |~~~~~~~|_______________ */
	/* stage_adr ======0=====x=1=x=2=x=3=x=		*/ /*  pcwaitf_l ~~~~|___|~~~|______        */ /* pcwaitf_l ____|~~~~~~~|___________ */
	/* fetch             ____________|~~~|___	*/ /*  svmod_fch ~~~~~~~~|_______|~~~~~~~~~ */ /* svmod_fch ~~~~~~~~~~~~~~~~|_______ */
	/* mwr                _______|~~~|___		*/ /*  fch_l2          __________|~~~|_____ */ /* fch       ________________|~~~|___ */
	/*                 access$B$3$3$^$G",!!",(Bfetch	*/ /*  wpulse             ___________|~~~|_ */ /* wpulse     _______________________ */
	/* acc_adr                   x===x===x===x	*/ /*                                       */ /*                                    */
	/*                           <acc><-stack>	*/ /*                                       */ /*                                    */
	/* --------------------------------------------	*/ /* ------------------------------------- */ /* ---------------------------------- */

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) waitexm_l <= 1'b0;
		else waitexm_l <= waitexm;
	end

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)
			svmoduser_l1_fch <= 1'b0;
		else if ((svmoduser & (pcwaitf_l | waitexm_l) & ~svmoduser_l1_fch)) /* $BF~$j8}$K(Bwait$B;~$O(Bmask$B$r(Bwait$B$5$;$k(B($BF~$j8}$b=P8}$b@8$+$9(B) */
			svmoduser_l1_fch <= svmoduser_l1_fch;
		else	svmoduser_l1_fch <= svmoduser;
	end

	assign	svmod_strobe = svmod & ~svmoduser;
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	svmod_strobe_l1_fch <= 1'b0;
				/* $BF~8}$K(Bwait$B;~$O(Bmask$B$r(Bwait$B$5$;$k(B($BF~$j8}$O@8$+$9(B) */		/* $B=P8}$K(Bwait$B;~$O(Bmask$B$r(Bwait$B$5$;$k(B($B=P8}$O(Bmask) */
		else if ((svmod_strobe & (pcwaitf_l | waitexm_l) & ~svmod_strobe_l1_fch) | (~svmod_strobe & (pcwaitf_l | waitexm_l) & svmod_strobe_l1_fch))
				svmod_strobe_l1_fch <= svmod_strobe_l1_fch;
		else		svmod_strobe_l1_fch <= svmod_strobe;
	end
	assign	svmod_fch = svmoduser_l1_fch | svmod_strobe_l1_fch;

/* svmod_delay */
	/* ------------------------------------------------------------------------------------------------------------	*/
	/* delay(full)$B$K$h$k(Bbreak$B;~$K(Btrcon$B$r(Bclear$B$9$kH=CG:`NA$H$7$F;HMQ(B.						*/
	/* delay(full)break$B$N$+$+$C$?L?Na$ND>8e$KJLMW0x$N(Bbreak($B0l=V$b4^$`(B)$B$,H/@8$7$?>l9g$K$O(B,$B$=$N(Bbreak$B$NCf$G(B		*/
	/* delay(full)break$B$N=hM}$b9T$&$h$&(Bsoft$B$G=hM}$7$F$$$k0Y(B,svmoduser$B$G$O$J$/(Bsvmod$B?.9f$r;HMQ$9$k(B.(051027exec$B3NG':Q(B)	*/
	/* ------------------------------------------------------------------------------------------------------------	*/
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			svmod_l1 <= 1'b0;
			svmod_delay <= 1'b0;
		end else begin
			svmod_l1 <= svmod;
			svmod_delay <= svmod_l1;
		end
	end

/* ------------------------- */
/* trace memory write enable */
/* ------------------------- */
	/* ------------------------------------	*/ /* -----------------------------------------	*/
	/* baseck _|~|_|~|_|~|_|~|_|~|_|~|_	*/ /* baseck _|~|_|~|_|~|_|~|_|~|_|~		*/
	/* adr     x===x=a=x===x===x===x===	*/ /* tra	=x===x=A=x=B=x===    		*/
	/* buf3                    x=a=x	*/ /* dealy_stop_________|~~~|_________		*/
	/* cpurd   ____|~~~|_______________	*/ /* trcon1	~~~~~~~~~~~~~|_________		*/
	/* a$B$N(BReadEvent	_______|~~~|_______	*/ /* trcon	~~~~~~~~~~~~~~~~~|_____		*/
	/* mrd_l2  ____________|~~~|_______	*/ /* we_xxx	~~~~~~~~~~~~~|_________		*/
	/* we_xxx  ____________|~~~|_______	*/ /* tra	=x===x===x===x=========		*/
	/* mrd     ________________|~~~|___	*/ /* wpulse	~~~~~~~~~~~~~|_________		*/
	/* wpulse  ________________|~~~|___	*/ /* A:full -1 ,B:full$B%"%I%l%9(B			*/
	/* tmemclk |~|_|~|_|~|_|~|_|~|_|~|_	*/ /* Delay,FullStop$B;~(B,wpulse$B$O(Btrcon1$B$G$J$/(B	*/
	/*                            $B",(B	*/ /* delay(full)_stop$B?.9f$G(Binactive$B$H$9$k(B	*/
	/* ------------------------------------	*/ /* -----------------------------------------	*/
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	selfmodedbg_l1 <= 1'b0;
		else		selfmodedbg_l1 <= selfmodedbg;
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	selfmodedbg_l2 <= 1'b0;
		else		selfmodedbg_l2 <= selfmodedbg_l1;
	end

	assign	we_com1 = ~monitrc & trcon1 & ~selfmodedbg_l2 & ~trctest;
	assign	we_com2 = we_com1 & (fetch_l2 | mrd_l2 | mwr_l2);
	assign	we_com3 = we_com2 & trcmd;

	assign	we_monitor = monitrc1;
	assign	we_full = we_com2 & ~trcmd;
	assign	we_section = we_com3 & section_en;
	assign	we_qualify = we_com3 & qualify_event;
	assign	we_snap = we_com1 & snapdten; /* svmod$B>r7o$O(Bsnapdten$B$K4^$`(B */

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) trace_altcs_l1 <= 1'b0;
		else		trace_altcs_l1 <= trace_altcs;
	end
	/* for test of trace memory i/f, trcon=1$B$G$J$$$H(Btmem$B$,(Bhostif$B$K3+J|$5$l$k$N$GF~$l$k(B */
	assign	we_trctest = ~svmod & trace_altcs_l1 & (mrd_l1 | mwr_l1) & trcon & trctest;

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)
			wpulse <= 1'b0;
		else if (mask_reset)
			wpulse <= 1'b0;
		else if (full_stop | delay_stop)	/* full$B%"%I%l%9$X$N=q$-9~$_$^$G$O5v2D(B */
			wpulse <= 1'b0;
		else if (we_monitor | we_full | we_section | we_qualify | we_snap | we_trctest)
			wpulse <= 1'b1;			/* break$B;~$O(Bsvmod$B>r7o$G(Bwe_xxx$B$,Mn$A$k(B */
		else	wpulse <= 1'b0;
	end

	/* --------------------------------------------------------------------	*/
	/* $B!&(BAddressCounter$B$N(BCountUp$B>r7o$K$J$k$N$G(B,host$B$+$i$N>r7o$OF~$l$J$$(B.	*/
	/* $B!&(Bdelay$B$d(Bfull$B$G(Btrace$BDd;_;~$K$?$^$?$^4{$K(Bhost$B$+$i$N(Baddress(iceifa)$B$,(B	*/
	/* $B!!(Btrace memory$BA*Br>uBV(B(trmem_host_cs==1)$B$@$H(B,traceON$B$K$h$k(BWriteData	*/
	/*   $B$H(Bhost$B$+$i$N(BReadData$B$,0l=V$V$D$+$k2DG=@-$,$"$k$N$G(B,trcon$B$r(B1$B2s(B	*/
	/*   baseck$B$G@Z$jD>$7$?(Btiming$B$G(Bhost_access$B$r(Bactive$B$K$9$k(B.		*/
	/* --------------------------------------------------------------------	*/
	assign	host_access = ~monitrc_f & ~trcon_f & trmem_host_cs;

/* --------------------- */
/* memory control signal */
/* --------------------- */
	/* $BA4$F%[%9%H$+$i$N%"%/%;%9$,Mm$`$N$GHsF14|(B */
	assign	tmemcsb = ~( monitrc | trcon | trmem_host_cs );
	assign	tmemrdb = ~( host_access & host_read ) ;
	assign	tmemwrb = ~( wpulse | (host_access & host_write) );

	wire	dmy1 = sysrsoutb | trcdlymode1; /* $B>o$K#1$N?.9f:n@.(B $B9g@.;~$K=LB`$5$;$J$$$?$a(B */
	wire	dmy2 = sysrsoutb | trcdlymode0; /* $B>o$K#1$N?.9f:n@.(B $B9g@.;~$K=LB`$5$;$J$$$?$a(B */

	tmemdlyh dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tmemcsb), .out(tmemcsb_d));
	tmemdlyl dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tmemrdb), .out(tmemrdb_d));
	tmemdlyh dly0 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tmemwrb), .out(tmemwrb_d));

	/* buffer$B$X$N(Bfanout3$B$D$@$HCY$l$k$N$G85$+$i(B3$B$D$KJ,$1$k(B */
	/* synplify$B$G(B1$B$D$K=LB`$5$l$F$7$^$&$N$G%;%l%/%H?.9f$rJ,$1$k(B */
	assign	trcon_dmy = trcon | !sysrsoutb;
	assign	monitrc_dmy = monitrc | !sysrsoutb;
	tmemclk_sel tmemclk0 ( 
		.trcon(trcon), .monitrc(monitrc),
		.baseck(baseck), .host_clk(host_clk),
		.tmemclk(tmemclk_drv)
	);
//	tmemclk_sel tmemclk0 ( .trcon(trcon_dmy), .monitrc(monitrc), .baseck(baseck), .host_clk(host_clk), .tmemclk(tmemclk[0]));
//	tmemclk_sel tmemclk1 ( .trcon(trcon), .monitrc(monitrc_dmy), .baseck(baseck), .host_clk(host_clk), .tmemclk(tmemclk[1]));
//	tmemclk_sel tmemclk2 ( .trcon(trcon), .monitrc(monitrc), .baseck(baseck), .host_clk(host_clk), .tmemclk(tmemclk[2]));
	// $B2?8N$+(Btmemclk1$B$,(Bedif$B$+$i>C$5$l$F$7$^$C$F$$$?$N$GLa$9(B.
	assign	tmemclk[0] = tmemclk_drv;
	assign	tmemclk[1] = tmemclk_drv;
	assign	tmemclk[2] = tmemclk_drv;

endmodule


// ======================================================================================================
// trace full												=
// ======================================================================================================
//module	trace_full (
//		icewr, baseck, sysrsoutb, wpulse,
//		trcfuldt_cs, trcfulclr_cs, trcfullmode0, trcfullmode1,
//		tra, icedi, full_stop, full_break, trcfull, trace_full_ro
//	);
//
//	input		icewr, baseck, sysrsoutb, wpulse,
//			trcfuldt_cs, trcfulclr_cs, trcfullmode0, trcfullmode1;
//	input [16:0]	tra;
//	input [16:0]	icedi;
//	output		full_stop, full_break, trcfull;
//	output [31:0]	trace_full_ro;
//
//	reg [16:0]	trcfuldt;
//	reg		full_stop;
//	reg		full_break;
//	reg		trcfull;
//	wire		trcfulclr;
//
//	assign	trace_full_ro = (trcfuldt_cs) ? {15'b0, trcfuldt} : 32'b0;
//
//// ----------------------------
//// trcfuldt (comparing address)
//// ----------------------------
//	always @ ( negedge icewr or negedge sysrsoutb ) begin
//		if (!sysrsoutb)		trcfuldt <=16'b0;
//		else if ( trcfuldt_cs )	trcfuldt <= icedi;
//	end
//// ---------
//// full-stop
//// ---------
//	/* full_stop$B$O%U%k%"%I%l%9$N0l$DA0$N%"%I%l%9$X$N=q$-9~$_$GH/@8$5$;!"(B	*/
//	/* trcon, wpulse$B$NDd;_$K4V$K9g$&$h$&$K$9$k!#(B				*/
//	always @ ( posedge baseck or negedge sysrsoutb ) begin
//		if (!sysrsoutb)	full_stop <= 1'b0;
//		else if ((tra == (trcfuldt-1)) & wpulse &
//			((trcfullmode1 & ~trcfullmode0)|(~trcfullmode1 & trcfullmode0)))
//				full_stop <= 1'b1;
//		else		full_stop <= 1'b0;
//	end
//// ----------
//// full-break
//// ----------
//	/* full_break$B$r=PNO$9$k$N$O%U%k%"%I%l%9$K%i%$%H$7$F$+$i(B */
//	always @ ( posedge baseck or negedge sysrsoutb ) begin
//		if (!sysrsoutb) full_break <= 1'b0;
//		else if ((tra == trcfuldt) & wpulse & ~trcfullmode1 & trcfullmode0)
//				full_break <= 1'b1;
//		else		full_break <= 1'b0;
//	end
//// --------------------------
//// trcfull (full-detect flag)
//// --------------------------
//	/* trcfull$B$rN)$F$k$N$O%U%k%"%I%l%9$K%i%$%H$7$F$+$i$J$N$G(Btra == trcfuldt$B$G(BOK */
//	assign	trcfulclr = trcfulclr_cs & icewr | ~sysrsoutb;
//	always @( posedge baseck or posedge trcfulclr ) begin
//		if (trcfulclr)	trcfull <= 1'b0;
//		else if ((tra == trcfuldt) & wpulse &
//			((trcfullmode1 & ~trcfullmode0)|(~trcfullmode1 & trcfullmode0)))
//				trcfull <= 1'b1;
//	end
//
//endmodule


// ======================================================================================================
// Trace Delay (includes trace-full)									=
// ======================================================================================================
	/* ---------------------------------------------*/
	/* delay$B$,$+$+$k$N$O(B2case			*/
	/* 1.count-down$B$K$h$j(Bdlycnt==0$B$H$J$C$?$H$-(B	*/
	/* 2.dlycnt==0$B$G(Bdly_event$B$,Mh$?;~(B		*/
	/*   full$B%b!<%I;~$O(Bdlycnt==0$B$N@_Dj$OL58z(B        */
	/* ---------------------------------------------*/

module	trace_delay (
		icewr, sysrsoutb, baseck, wpulse, svmod_delay, dly_event, trcdlymode1, trcdlymode0,
		we_snap, trctest, snapdt,
		trdlydt_cs, trdlyrd_cs, trcdlyactclr_cs, trcdlyendclr_cs, trcon_clr_dlybrk, icedi,
		full_stop, delay_stop, full_break, delay_break, trcon_clr_trace_delay,
		trcdly, delay_bit, trace_delay_ro
	);

	input		icewr, sysrsoutb, baseck, wpulse, svmod_delay, dly_event, trcdlymode1, trcdlymode0;
	input		we_snap, trctest, snapdt;
	input		trdlydt_cs, trdlyrd_cs, trcdlyactclr_cs, trcdlyendclr_cs;
	input		trcon_clr_dlybrk;
	input [16:0]	icedi;
	output		full_stop, delay_stop, full_break, delay_break, trcon_clr_trace_delay;
	output		trcdly, delay_bit;
	output [31:0]	trace_delay_ro;

	reg [16:0]	trdlydt;
	reg [16:0]	dlycnt;
	reg [31:0]	trace_delay_ro;
	reg		dlyact_p, dlyact, load_start, dlyload;
	reg		delay_break, full_break, trcdly, trcdly2;
	reg		dly_event_l;
	reg		delay_bit;
	wire		load_res;
	wire		trdlyactclr, trcdlyendclr;
	wire		delay_zero, delay_1cnt;
	wire		full_stop_p, delay_stop_p;


	always @( trdlydt_cs or trdlyrd_cs or trdlydt or dlycnt ) begin
		case ({trdlydt_cs, trdlyrd_cs})
			2'b10	: trace_delay_ro = {15'b0, trdlydt};
			2'b01	: trace_delay_ro = {15'b0, dlycnt};
			default : trace_delay_ro = 32'b0;
		endcase
	end

	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb) trdlydt <= 17'b0;
		else if (trdlydt_cs) trdlydt <= icedi;
	end

	/* --------------------------------------------------------------------	*/
	/* baseck	_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|	*/
	/* pc		 x=a=x===x===x   					*/
	/* acc_adr	             x=a=x					*/
	/* event(at a)	        _|~~~|_______________________|~~~|______	*/
	/* dlyact_p	        _____|~~~~~~~~~~~~~~~|__________________	*/
	/* dlyact	             ____|~~~~~~~~~~~|__________________	*/
	/* wpulse	~~~~~~~~~~~~~~~~~|___|~~~~~~~|_______xxxxxxxxxxx	*/
	/* trcon1	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|_______|~~~~~~~~~~	*/
	/* dlycnt	  =2=====================x=1=x=0================	*/
	/* delay_stop	_________________________|~~~|___________|~~~|__	*/
	/* delay_break	_____________________________|~~~|___________|~~~|__	*/
	/*				             dlycnt          dlyzero	*/
	/*                                        $B$K$h$k(Bbreak       $B$K$h$k(Bbreak	*/
	/*						      (wpulse$B$K$h$i$J$$(B)*/
	/*									*/
	/* $B!&(Btrcon$B$K$h$k(Bevent$B$N(Bmask$B$O(Bevent$B=PNO>r7o$KF~$l$k(B			*/
	/* $B!&(Bdelay$B%+%&%s%H$O(Bdelay$B%$%Y%s%H$N$+$+$C$?(Bflame$B$N<!$N(Bflame$B$+$i3+;O$9$k(B */
        /*   (delay-mode$B;~(B)							*/
	/* $B!&(Btrace$B%G!<%?$N(Bdelay$BCf%U%i%0$O(Bdelay$B%$%Y%s%H$N$+$+$C$?(Bflame$B$H%+%&%s%H(B */
	/*   $BCf$N%U%l!<%`$G6&$K(B1$B$rN)$F$k!J(Bdlyact_p$B$r;HMQ!K(B			*/
	/* $B!&(Bfull$B%b!<%I$H$7$F;HMQ$9$k>l9g$O!"4pK\E*$K(Bbreak$BCf$K@_Dj$7$F$b$i$&!#(B	*/
	/*   $B@_Dj=g=x$K$h$j@_Dj?t$h$j(B1$B2sB?$/%+%&%s%H$7$F%9%H%C%W(B,$B%V%l!<%/$9$k(B	*/
	/*   $B>l9g$,$"$k!#!J(Bdelay$B$HF1$8F0$-$K$J$k!K(B				*/
	/*   ex)run$BCf$K(Btrcdlymode1$B$H(Btrcon$B$r%;%C%H$9$k$H!"(Bdlyact_p$B$HF1$8(Btiming	*/
	/*   $B$G(Bwpulse$B$,N)$A!"<!$N(Bclock$B$G(Bdlyact$B$,(Bactive$B$K$J$k(B.(1cnt$BB?$/$J$k!K(B	*/
	/*   dlyact_p$B$N(Btiming$B$G$?$^$?$^(Bfetch,rd,wr$B$,$J$1$l$P$:$l$J$$(B.		*/
	/* --------------------------------------------------------------------	*/

	assign	delay_zero = dlycnt==0;
	assign	delay_1cnt = dlycnt==1;

	/* -------------------- */
	/* delay counter enable */
	/* -------------------- */
	assign	trdlyactclr = trcdlyactclr_cs & icewr | ~sysrsoutb;
	always @( posedge baseck or posedge trdlyactclr ) begin
		if (trdlyactclr)
			dlyact_p <= 1'b0;
		else if	(dlyact_p & delay_1cnt & wpulse)	 /* dlyact_p$B$,(B1$B$N>r7o$rF~$l$J$$$H(Bdelay1$B$,8z$+$J$/$J$k(B */
			dlyact_p <= 1'b0;			 /* count-end */
		else if (!delay_zero & dly_event & ~trcdlymode1) /* dly-mode */
			dlyact_p <= 1'b1;
		else if (!delay_zero & trcdlymode1)		 /* full-mode */
			dlyact_p <= 1'b1;
	end

	/* delay-count$B$O(Bdelay-event$B$,$+$+$C$?<!$N(Bcycle$B$+$i9T$&(B */
	always @( posedge baseck or posedge trdlyactclr ) begin
		if (trdlyactclr)
			dlyact <= 1'b0;
		else if (dlyact & delay_1cnt & wpulse)		/* dlyact$B$,(B1$B$N>r7o$rF~$l$J$$$H(Bdelay1$B$,8z$+$J$/$J$k(B */
			dlyact <= 1'b0;
		else	dlyact <= dlyact_p;
	end

	/* ------------ */
	/* counter load */
	/* ------------ */
	assign	load_res = !sysrsoutb | dlyload;
	always @( negedge icewr or posedge load_res ) begin
		if (load_res) load_start <= 1'b0;
		else if (trdlyrd_cs) load_start <= 1'b1;
	end

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	dlyload <= 1'b0;
		else dlyload <= load_start; /* 1clock */
	end

	/* ------------- */
	/* delay counter */
	/* ------------- */
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			dlycnt <= 17'b0;
		else if (dlyload)
			dlycnt <= trdlydt;
		else if (!delay_zero & wpulse & dlyact)
			dlycnt <= dlycnt-1;
	end

	/* ---------- */
	/* stop/break */
	/* ---------- */
	/* ------------------------------------------------------------------------------------	*/
	/* $B!&(Bdelay_break$B$H(Bfull_break$B$G%Y%/%?$r0l1~J,$1$k!#(B(EXEC$B$HAjCL:Q$_(B050622)		*/
	/* $B!&(Btrcon$B$,%"%/%F%#%V$G$"$kA0Ds>r7o$O(Bevent$B%V%m%C%/$KF~$l$F$"$k!#(B			*/
	/* $B!&(Bdelay_zero$B$N>r7o$O(Bdelay-mode$B;~$N$_!#(Bfull-mode$B$G$O(Bdlycnt==0$B$N@_Dj$OL58z(B		*/
	/* ------------------------------------------------------------------------------------ */

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) dly_event_l <= 1'b0;
		else dly_event_l <= dly_event;
	end

	assign	full_stop_p = delay_1cnt & wpulse & dlyact; /* count-down */
	assign	delay_stop_p = full_stop_p | delay_zero & ~dlyact & dly_event_l;

	assign	full_stop = trcdlymode0 & trcdlymode1 & full_stop_p;
	assign	delay_stop = trcdlymode0 & ~trcdlymode1 & delay_stop_p;

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	delay_break <= 1'b0;
		else if (delay_stop_p & ~trcdlymode0 & ~trcdlymode1)
			delay_break <= 1'b1;
		else	delay_break <= 1'b0;
	end

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	full_break <= 1'b0;
		else if (full_stop_p & ~trcdlymode0 & trcdlymode1)
			full_break <= 1'b1;
		else	full_break <= 1'b0;
	end

	/* ------ */
	/* trcdly */
	/* ------ */
	assign	trcdlyendclr = trcdlyendclr_cs & icewr | ~sysrsoutb;
	always @( posedge baseck or posedge trcdlyendclr ) begin
		if(trcdlyendclr) trcdly <= 1'b0;
		else if (delay_stop_p) trcdly <= 1'b1; /* full_stop,break or delay_stop,break */
	end

	/* break$B;~$N(Btrcon$B%/%j%"MQ%U%i%0(B */
	/* --------------------------------------------	*/
	/* svmod_delay	_________________|~~~~~~~~~	*/
	/* trcon	~~~~~~~~~~~~~~~~~~~~~~~~~|___	*/
	/* trcon1(_p)	~~~~~~~~~~~~~~~~~~~~~|___	*/
	/* baseck	_|~|_|~|_|~|_|~|_|~|_|~|_|~|_	*/
	/* dly_stop	_|~~~|_____			*/
	/* dly_break	_____|~~~|____			*/
	/* trcdly2	_____|~~~~~~~~~~~~~~~~~~~|_____	*/
	/* trcon_clr_trace_delay  _______|~~~~~~~|_____ */
	/* trcon_clr_dlybrk _________________|~~~|_____	*/
	/* -------------------------------------------- */

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	trcdly2 <= 1'b0;
		else if(trcon_clr_dlybrk)
			trcdly2 <= 1'b0;
		else if (~trcdlymode0 & trcdlymode1 & full_stop_p | ~trcdlymode0 & ~trcdlymode1 & delay_stop_p)
			trcdly2 <= 1'b1;
	end
	assign	trcon_clr_trace_delay = svmod_delay & trcdly2;

	/* ------- */
	/* trcfull */
	/* ------- */
	/* for the time being, do not make trace-full flag(trcfull). (EXEC$B$K3NG':Q(B050622) */

	/* ---------------------- */
	/* trace-flame delay-flag */
	/* ---------------------- */
	/* ----------------------------------------------------------------------------	*/
	/* full-mode$B;~$O(B0$B8GDj$K$9$k(B.delay-zero$B$G$bN)$F$k(B(trigger$B$H(Bcount$BCf$N(Bor$B$H$9$k(B).	*/
	/* $B;EMM=q8+$;$O$7$J$$M=Dj$@$,(B,DelayBreak$B;~(B,delay_bit$B$O(BDelayCount$B=*N;$^$G$O(B	*/
	/* $BN)$D$,(B,$B$=$3$+$i(Bbreak$B$KF~$k$^$G$N(Btrace$B$G$ON)$?$J$$(B.				*/
	/* break$B$^$GN)$F$kI,MW$,$"$l$P(Btrcdly2$B$r(Bor$B$9$l$P(BOK.				*/
	/* ----------------------------------------------------------------------------	*/

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			delay_bit <= 1'b0;  /* trdlyactclr$B$rF~$l$k$H(Bsnap,trctest$BCf$K(Bclear$B$5$l$k2DG=@-$,$"$k$N$GF~$l$J$$(B           */
		else if (we_snap | trctest) /* trdlyactclr$B$K$h$k(Bclear$B;~$N(Bdelay_bit$B$N(BClearTiming$B$,F14|2=$5$l>/$7CY$l$k$@$1$J$N$G(BOK */
			delay_bit <= snapdt;
		else if (dlyact & delay_1cnt & wpulse)
			delay_bit <= 1'b0;
		else if (!trcdlymode1)
			delay_bit <= (dlyact_p | dly_event);
		else	delay_bit <= 1'b0;
	end

endmodule


// ======================================================================================================
// Section trace											=
// ======================================================================================================
	/* --------------------------------------------	*/
	/* baseck	_|~|_|~|_|~|_|~|_|~|_|~|_|~|_	*/
	/* adr		 x===x=a=x===x=b=x===x		*/
	/* buf3		                 x=a=x===x=b=x	*/
	/* secon event	_____________|~~~|_________	*/
	/* secoff event	_____________________|~~~|___	*/
	/* section_en	_____________|~~~~~~~~~~~|___	*/
	/* --------------------------------------------	*/
module	section_trace (
		baseck, sysrsoutb, secclr_cs, icewr, secon_event, secoff_event, section_en
	);

	input		baseck, sysrsoutb, secclr_cs, icewr;
	input [3:0]	secon_event;	/* trcon$B$K$h$k(Bmask$B$O(Bevent$B$G9T$&(B */
	input [3:0]	secoff_event;	/* trcon$B$K$h$k(Bmask$B$O(Bevent$B$G9T$&(B */
	output		section_en;


	wire		secclr;
	reg [3:0]	section_l;


	assign	secclr = secclr_cs & icewr | ~sysrsoutb;

	integer s;
	always @( posedge baseck or posedge secclr ) begin
	  for(s=0; s<4; s=s+1)
		if (secclr)
			section_l[s] <= 1'b0;
		else if (secoff_event[s])
			section_l[s] <= 1'b0;
		else if (secon_event[s])
			section_l[s] <= 1'b1;
	end

	assign	section_en = (secon_event[0] & ~secoff_event[0]) | section_l[0] |
			     (secon_event[1] & ~secoff_event[1]) | section_l[1] |
			     (secon_event[2] & ~secoff_event[2]) | section_l[2] |
			     (secon_event[3] & ~secoff_event[3]) | section_l[3];

endmodule


// ======================================================================================================
// Snap Shot												=
// ======================================================================================================
module	snap_shot (
		baseck, sysrsoutb, cpuwr, snapdt_cs, mdw, snapdt, snap_shot_ro
	);

	input		baseck, sysrsoutb, cpuwr;
	input [13:0]	snapdt_cs;
	input [15:0]	mdw;
	output [107:0]	snapdt;
	output [15:0]	snap_shot_ro;

	reg [7:0]	snapdt0, snapdt1, snapdt2, snapdt3, snapdt4, snapdt5, snapdt6,
			snapdt7, snapdt8, snapdt9, snapdt10, snapdt11, snapdt12;
	reg [3:0]	snapdt13;
	reg [7:0]	snap_shot_rol, snap_shot_roh;


// ---------------
// snapdt register
// ---------------
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt0 <= 8'b0;
		else if (snapdt_cs[0] & cpuwr)
				snapdt0 <= mdw[7:0];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	snapdt1 <= 8'b0;
		else if (snapdt_cs[1] & cpuwr)
				snapdt1 <= mdw[15:8];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt2 <= 8'b0;
		else if (snapdt_cs[2] & cpuwr)
				snapdt2 <= mdw[7:0];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt3 <= 8'b0;
		else if (snapdt_cs[3] & cpuwr)
				snapdt3 <= mdw[15:8];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt4 <= 8'b0;
		else if (snapdt_cs[4] & cpuwr)
				snapdt4 <= mdw[7:0];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt5 <= 8'b0;
		else if (snapdt_cs[5] & cpuwr)
				snapdt5 <= mdw[15:8];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt6 <= 8'b0;
		else if (snapdt_cs[6] & cpuwr)
				snapdt6 <= mdw[7:0];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb)	snapdt7 <= 8'b0;
		else if (snapdt_cs[7] & cpuwr)
				snapdt7 <= mdw[15:8];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt8 <= 8'b0;
		else if (snapdt_cs[8] & cpuwr)
				snapdt8 <= mdw[7:0];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt9 <= 8'b0;
		else if (snapdt_cs[9] & cpuwr)
				snapdt9 <= mdw[15:8];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt10 <= 8'b0;
		else if (snapdt_cs[10] & cpuwr)
				snapdt10 <= mdw[7:0];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt11 <= 8'b0;
		else if (snapdt_cs[11] & cpuwr)
				snapdt11 <= mdw[15:8];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt12 <= 8'b0;
		else if (snapdt_cs[12] & cpuwr)
				snapdt12 <= mdw[7:0];
	end
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) snapdt13 <= 8'b0;
		else if (snapdt_cs[13] & cpuwr)
				snapdt13 <= mdw[11:8];
	end

/* $B=q$-9~$s$@CM$r(BHOST I/F$B$GFI$_=P$70W$$$h$&$K$D$J$.49$($k(B */
//	assign	snapdt = {snapdt13, snapdt12, snapdt11, snapdt10, snapdt9, snapdt8, snapdt7,
//			  snapdt6, snapdt5, snapdt4, snapdt3, snapdt2, snapdt1, snapdt0};
	assign	snapdt =  {snapdt13, snapdt11, snapdt10, snapdt9, snapdt8, snapdt12[7:4], snapdt7, snapdt6,
			  snapdt5, snapdt4, snapdt12[3:0] ,snapdt3, snapdt2, snapdt1, snapdt0};
			  
	always @(snapdt_cs[0] or snapdt_cs[2] or snapdt_cs[4] or snapdt_cs[6] or snapdt_cs[8] or snapdt_cs[10] or snapdt_cs[12] or
		 snapdt0 or snapdt2 or snapdt4 or snapdt6 or snapdt8 or snapdt10 or snapdt12) begin

		case({snapdt_cs[0], snapdt_cs[2], snapdt_cs[4], snapdt_cs[6], snapdt_cs[8], snapdt_cs[10], snapdt_cs[12]})
			7'b100_0000:	snap_shot_rol = snapdt0;
			7'b010_0000:	snap_shot_rol = snapdt2;
			7'b001_0000:	snap_shot_rol = snapdt4;
			7'b000_1000:	snap_shot_rol = snapdt6;
			7'b000_0100:	snap_shot_rol = snapdt8;
			7'b000_0010:	snap_shot_rol = snapdt10;
			7'b000_0001:	snap_shot_rol = snapdt12;
			default:	snap_shot_rol = 8'b0;
		endcase
	end

	always @(snapdt_cs[1] or snapdt_cs[3] or snapdt_cs[5] or snapdt_cs[7] or snapdt_cs[9] or snapdt_cs[11] or snapdt_cs[13] or
		 snapdt1 or snapdt3 or snapdt5 or snapdt7 or snapdt9 or snapdt11 or snapdt13) begin

		case({snapdt_cs[1], snapdt_cs[3], snapdt_cs[5], snapdt_cs[7], snapdt_cs[9], snapdt_cs[11], snapdt_cs[13]})
			7'b100_0000:	snap_shot_roh = snapdt1;
			7'b010_0000:	snap_shot_roh = snapdt3;
			7'b001_0000:	snap_shot_roh = snapdt5;
			7'b000_1000:	snap_shot_roh = snapdt7;
			7'b000_0100:	snap_shot_roh = snapdt9;
			7'b000_0010:	snap_shot_roh = snapdt11;
			7'b000_0001:	snap_shot_roh = snapdt13;
			default:	snap_shot_roh = 8'b0;
		endcase
	end

	assign	snap_shot_ro = {snap_shot_roh, snap_shot_rol};

endmodule


// ======================================================================================================
// trace memory address											=
// ======================================================================================================
module	tradr (
		trcmem_cs, trcadr_cs, traovfcl_cs, trcard_cs, trmem_host_cs, monitrc1_f, trcon1_f,
		baseck, icewr, sysrsoutb, wpulse, host_adr, icedi, tradr_ro, tra, traovf
	) ;

	input		trcmem_cs, trcadr_cs, traovfcl_cs, trcard_cs, trmem_host_cs, monitrc1_f,
			trcon1_f, baseck, icewr, sysrsoutb, wpulse ;
	input [16:0]	host_adr, icedi;
	output [31:0]	tradr_ro ;
	output [16:0]	tra ;
	output		traovf ;

	wire		traovfcl, load_res ;
	wire [16:0]	tra_pre;
	reg [2:0]	trcarea ;
	reg		tramax, traovf, ptraload, traload ;
	reg [16:0]	autotra, trcadr ;
	reg [31:0]	tradr_ro;


	always @( trcmem_cs or trcard_cs or trcadr_cs or trcarea or autotra or trcadr ) begin
		case ({trcmem_cs, trcard_cs, trcadr_cs})
			3'b100 : tradr_ro = {29'b0, trcarea};
			3'b010 : tradr_ro = {15'b0, autotra};
			3'b001 : tradr_ro = {15'b0, trcadr};
			default: tradr_ro = 32'b0;
		endcase
	end

// -----------------------
// trcmem ( address-area )
// -----------------------
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)	trcarea <= 3'b0;
		else if (trcmem_cs) trcarea <= icedi[2:0];
	end

// -------------------
// load address buffer
// -------------------
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)	trcadr <= 17'b0 ;
		else if (trcadr_cs) trcadr <= icedi ;
	end

// ----------------
// address max flag
// ----------------
	always @( trcarea or autotra ) begin
		case ( trcarea[2:0] ) // synopsys parallel_case
			3'h0	: tramax = (autotra == 17'h0_1fff) ? 1'b1:1'b0 ; //   8k-over
			3'h1	: tramax = (autotra == 17'h0_3fff) ? 1'b1:1'b0 ; //  16k-over
			3'h2	: tramax = (autotra == 17'h0_7fff) ? 1'b1:1'b0 ; //  32k-over
			3'h3	: tramax = (autotra == 17'h0_ffff) ? 1'b1:1'b0 ; //  64k-over
			default	: tramax = (autotra == 17'h1_ffff) ? 1'b1:1'b0 ; // 128k-over
		endcase
	end

// ----------------------------
// address over flow flag latch
// ----------------------------
	assign	traovfcl = traovfcl_cs & icewr | ~sysrsoutb ;
	always @( posedge baseck or posedge traovfcl ) begin
		if (traovfcl) traovf <= 1'b0 ;
		else if	(tramax & wpulse) traovf <= 1'b1 ;
	end

// -------------------------
// trace-address load status
// -------------------------
	/* ---------------------------------------------------- */
	/* baseck	_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_	*/
	/* icewr	________|~~~~~~~|____			*/
	/* ptraload	________________||__________		*/
	/* traload	_________________|~~~|_____		*/
	/* autotra	===x=================x=trcadr=		*/
	/* ---------------------------------------------------- */

	/* load status$B$O<~GH?t$N5UE>$G<h$j$3$\$5$J$$$h$&(Bdubble buffer$B$K$9$k(B */
	assign	load_res = !sysrsoutb | traload;
	always @( negedge icewr or posedge load_res ) begin	/* load enable */
		if (load_res) ptraload <= 1'b0 ;
		else if (trcard_cs) ptraload <= 1'b1 ;
	end

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	traload <= 1'b0 ;
		else		traload <= ptraload ;
	end

// ---------------
// address counter
// ---------------
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)		autotra <= 0 ;
		else if (traload)	autotra <= trcadr ;
		else if (wpulse) begin
			if (tramax)	autotra <= 0 ;
			else		autotra <= autotra +1 ;
		end
	end
	
	/* ---------------------------------------------------------------------------- */
	/* $B!&(Bhost$B$+$i(Btrace-memory access$B$9$k:]$O(BTRCON=0,$B5Z$S(BMONITRC=0$B$K$9$kI,MW$,$"$k(B.	*/
	/* $B!&(BTRCON=0,MONITRC=0$B$K$7$J$$$H(Bhost$B$+$i(Bwrite$B=PMh$J$$(B.				*/
	/* ---------------------------------------------------------------------------- */
	
	assign	tra_pre = ( ~monitrc1_f & ~trcon1_f & trmem_host_cs ) ? host_adr : autotra;
	
	wire	dmy1 = sysrsoutb | monitrc1_f; /* $B>o$K#1$N?.9f:n@.(B $B9g@.;~$K=LB`$5$;$J$$$?$a(B */
	wire	dmy2 = sysrsoutb | trcon1_f; /* $B>o$K#1$N?.9f:n@.(B $B9g@.;~$K=LB`$5$;$J$$$?$a(B */
	
	tmemdlyl dly16 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[16]), .out(tra[16]));
	tmemdlyl dly15 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[15]), .out(tra[15]));
	tmemdlyl dly14 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[14]), .out(tra[14]));
	tmemdlyl dly13 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[13]), .out(tra[13]));
	tmemdlyl dly12 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[12]), .out(tra[12]));
	tmemdlyl dly11 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[11]), .out(tra[11]));
	tmemdlyl dly10 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[10]), .out(tra[10]));
	tmemdlyl dly9 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[9]), .out(tra[9]));
	tmemdlyl dly8 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[8]), .out(tra[8]));
	tmemdlyl dly7 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[7]), .out(tra[7]));
	tmemdlyl dly6 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[6]), .out(tra[6]));
	tmemdlyl dly5 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[5]), .out(tra[5]));
	tmemdlyl dly4 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[4]), .out(tra[4]));
	tmemdlyl dly3 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[3]), .out(tra[3]));
	tmemdlyl dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[2]), .out(tra[2]));
	tmemdlyl dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[1]), .out(tra[1]));
	tmemdlyl dly0 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(tra_pre[0]), .out(tra[0]));

endmodule


// ======================================================================================================
// trace data												=
// ======================================================================================================
module	trdata (
		baseck, clk60mhz, sysrsoutb, wpulse, svmod_fch, svmod_acc, trcon, monitrc, host_write,
		trmem_host_cs, iceifa, icedi, icewr, trdsel_cs, pc, idadr, exma, ma, mdr, mdw, stageadr,
		pcwaitf, waitexm, ocdwait, flread, flreadb, pid, cpurd, cpuwr, skipexe, fchram, cpumask, wdop,
		prefix, qualify_event, section_en, step, intack, dmaack, iceresb, cpursoutb, tarresb,
		icemskice, icemsktrst, we_snap, snapdt, trctest, hostwd, tag, tagovf, selfmode, selexmpc,
		selrampc, selrompc, selbrampc, selbfapc, fetch_l2, mrd_l1, mwr_l1, mrd_l2, mwr_l2, pcwaitf_l,
		mask_reset, trdata_ro, trd
	) ;

	input		baseck, clk60mhz, sysrsoutb, wpulse, svmod_fch, svmod_acc, trcon, monitrc,
			host_write, trmem_host_cs;
	input [3:2]	iceifa, icedi;
	input		icewr, trdsel_cs;
	input [19:0]	pc;
	input [31:0]	idadr;
	input [3:0]	exma;
	input [15:0]	ma, mdr, mdw;
	input [1:0]	stageadr;
	input		pcwaitf, waitexm, ocdwait, flread;
	input [3:0]	flreadb;
	input [31:0]	pid;
	input		cpurd, cpuwr, skipexe, fchram, cpumask, wdop, prefix;
	input		qualify_event, section_en, step, intack, dmaack;
	input		iceresb, cpursoutb, tarresb, icemskice, icemsktrst;
	input		we_snap, trctest;
	input [107:0]	snapdt;
	input [107:0]	hostwd;
	input [31:0]	tag;
	input		tagovf, selfmode;
	input		selexmpc;
	input		selrampc;
	input		selrompc;
	input		selbrampc;
	input		selbfapc;
	
	output		fetch_l2, mrd_l1, mwr_l1, mrd_l2, mwr_l2;	// for we_xxxx
	output		pcwaitf_l;
	output		mask_reset;
	output [31:0]	trdata_ro;
	inout [107:0]	trd;


	// register
	reg[1:0]	trdsel_p, trdsel;

	// internal
	reg [31:0]	trdrd;

	// buffer
	reg		step_l1;
	reg		qualifyf, secen_bit;
	reg[1:0]	trdself, trdself_l1, trdself_l2;
	reg		prefix_id1, prefix_id2, prefix_id3;
	reg		fetch, fetch_l1, fetch_l2;
	reg		mrd, mrd_l1, mrd_l2;
	reg		mwr, mwr_l1, mwr_l2;
	reg		word, word_l1, word_l2;
	reg [19:0]	fch_adr, fch_adr_l1, fch_adr_l2;
	reg [31:0]	fch_data, fch_data_l1, fch_data_l2;
	reg [19:0]	acc_adr, acc_adr_l1, acc_adr_l2;
	reg [15:0]	acc_data, acc_data_l1, acc_data_l2;
	reg [15:0]	flread_data;
	reg		flrd_en, pcwaitf_l;
	reg		selfmode_l1, selfmode_l2, selfmode_l3;
	reg		reserve1;
	reg		tagovf_l1, tagovf_l2;
	reg		soft_bit;
	reg		dmaack_l1, dmaack_l2;
	reg		int_l1, int_l2, int_l3;
	reg		dma_l1, dma_l2, dma_l3;

	wire		delay_bit;
	wire		int, dma;
	wire		iceresb_st, periresb_st, tarresb_st;
	wire		mask_iceresb, mask_periresb, mask_tarresb;
	wire [31:0]	trdsel_ro;
	wire [107:0]	autotrd, autotrd_d;

// ------------
// host read if
// ------------
	assign	trdata_ro = trdsel_ro | trdrd;

// ---------
// delay_bit
// ---------
	assign	delay_bit = snapdt[65];
// ------
// trdsel
// ------
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)	trdsel_p <= 2'h0;
		else if (trdsel_cs) trdsel_p <= icedi;
	end
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	trdsel <= 2'h0;
		else trdsel <= trdsel_p;
	end
	assign	trdsel_ro = (trdsel_cs) ? {30'b0,trdsel}:32'b0;

// -----------------------
// enable for cpurd, cpuwr
// -----------------------
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	pcwaitf_l <= 1'b0;
		else pcwaitf_l <= pcwaitf;
	end

// ------------------------------------------------------------------------------------------------------
// 1st Buffer												-
// ------------------------------------------------------------------------------------------------------

	/* ------------------------------------------------------------------------------------	*/
	/*   $B!&(Bfetch$B$b(Brd$B$b(Bwr$B$b$J$$(Bflame$B$N$_(Breject(wpulse$B$rMn$H(B)$B$7(B,$BB>$OKh(Bclock$B%G!<%?:N<h$9$k(B.	*/
	/* ------------------------------------------------------------------------------------	*/

/***** trdsel (trd107-106) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	trdself_l1 <= 2'b0;
		else trdself_l1 <= trdsel;
	end

/***** selfmode (trd105) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) selfmode_l1 <= 1'b0;
		else selfmode_l1 <= selfmode;
	end

/***** reserce (trd104) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	reserve1 <= 1'b0;
		else if (we_snap | trctest)
				reserve1 <= snapdt[104];
		else		reserve1 <= 1'b0;
	end

/***** fetch data (trd103-72) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	fch_data_l1 <= 32'b0;
		else fch_data_l1 <= idadr;
	end

/***** tagovf (trd71) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) tagovf_l1 <= 1'b0;
		else tagovf_l1 <= tagovf;
	end

/***** reset status (trd70-68) *****/
	reset_detect	reset1 (
				.baseck(baseck), .reset_in(iceresb), .reset_mask(icemskice),
				.snapdt(snapdt[70]), .we_snap(we_snap), .trctest(trctest),
				.pcwaitf_l(pcwaitf_l), .wpulse(wpulse), .trcon(trcon),
				.monitrc(monitrc), .sysrsoutb(sysrsoutb),
				.mask_reset(mask_iceresb),
				.reset_st(iceresb_st)
			);
	reset_detect2	reset2 (
				.baseck(baseck), .clk60mhz(clk60mhz), .reset_in(cpursoutb),
				.snapdt(snapdt[69]), .we_snap(we_snap), .trctest(trctest),
				.iceresb(iceresb), .icemskice(icemskice),
				.tarresb(tarresb), .icemsktrst(icemsktrst),
				.pcwaitf_l(pcwaitf_l), .wpulse(wpulse), .trcon(trcon),
				.monitrc(monitrc), .sysrsoutb(sysrsoutb),
				.mask_reset(mask_periresb),
				.reset_st(periresb_st)
			);
	reset_detect	reset3 (
				.baseck(baseck), .reset_in(tarresb), .reset_mask(icemsktrst),
				.snapdt(snapdt[68]), .we_snap(we_snap), .trctest(trctest),
				.pcwaitf_l(pcwaitf_l), .wpulse(wpulse), .trcon(trcon),
				.monitrc(monitrc), .sysrsoutb(sysrsoutb),
				.mask_reset(mask_tarresb),
				.reset_st(tarresb_st)
			);
	assign	mask_reset = mask_iceresb | mask_periresb | mask_tarresb;

/***** event (trd67-66) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			secen_bit <= 1'b0;
		else if (we_snap | trctest)
			secen_bit <= snapdt[67];
		else	secen_bit <= section_en;
	end

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) qualifyf <= 1'b0;
		else if (we_snap | trctest)
				qualifyf <= snapdt[66];
		else		qualifyf <= qualify_event;
	end

/***** step (trd64) *****/
	/* ------------------------------------------------------------------------------------	*/
	/* $B%Y%?$G;H$&?.9f$J$N$G(Btiming$B$O5$$K$7$J$$$,(B,step$B?.9f$OHsF14|$J$N$G=PNOA0$K(B1$B2s$-$jD>$9(B.	*/
	/* ------------------------------------------------------------------------------------	*/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			step_l1 <= 1'b0;
		else if (we_snap | trctest)
			step_l1 <= snapdt[64];
		else	step_l1 <= step;
	end

/***** soft bit (trd63) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			soft_bit <= 1'b0;
		else if (we_snap | trctest)
			soft_bit <= snapdt[63];
		else	soft_bit <= 1'b0;
	end

/***** interrupt (trd62) *****/
	/* --------------------------------------------------------------------	*/
	/* [V1.73]								*/
	/* pcwaitf$B$H(Bintack$B$,F1;~$KN)$C$?>l9g$O(Bpcwaitf$B4|4VJ,(Bintack_l1$B$rCY$i$;$k(B.	*/
	/* 		 _|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_		*/
	/* pcwaitf	 _____________|~~~|___________|~~~~~~~|___		*/
	/* intack	 _|~~~|_______|~~~|___________|~~~|///|___		*/
	/* intack_wait   _________________|~~~|___________|~~~~~~~|___		*/
	/* intack_l1pre1 _|~~~|_______|~~~~~~~|_______|~~~~~~~~~~~|___		*/
	/* intack_l1pre2 _____|~~~|_______|~~~~~~~|_______|~~~~~~~~~~~|___	*/
	/* intack_l1	 _____|~~~|___________|~~~|_______________|~~~|___	*/
	/* --------------------------------------------------------------------	*/
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
	assign	int = intack_l2;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	int_l1 <= 1'b0;
		else		int_l1 <= int;
	end

/***** fetch (trd61) *****/
	/* ------------------------------------------------------------------------------------------------------------	*/
	/* 1.int$B$N>l9g(B,pre-fetch$B$N(Bpc$B$,(Bstageadr, pcwaitf$B$G(Bmask$B$5$l$J$$$N$G(B,intack$B$G(Bmask$B$9$k(B(~intack).(fetch)		*/
	/* 1-2 [V1.73] intack$B$N(BTiming$B$G(BPCWAITF$B$,N)$D$H$-$O(Bpre-fetch$B$N(Bpc$B$,(Bwait$B$5$l$FD9$/$J$k0Y(B,1$B$N=hCV$@$1$G$O(Bpre-fetch	*/
	/*     $B$r(BMask$B$G$-$J$$$3$H$,J,$C$?0Y(B,intack$B$NBe$o$j$K(Bintack_wait$B$G(BMask$B$9$k$h$&$K$7$?!#(B				*/
	/* 2.int$B$N>l9g(B,VectorRead$B;~$K(Bstageadr$B$,N)$A(BFetchStatus$B$,N)$?$J$/$J$k$N$GJLES>r7o$KF~$l$k(B(intack_l2).(fetch)	*/
	/* 3.dma$BE>Aw;~$O(Bpcwaitf$B$,N)$?$J$$0Y(B,$BJLES>r7o$KF~$l$k(B(fetch)							*/
	/* ------------------------------------------------------------------------------------------------------------	*/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	fetch_l1 <= 1'b0;
		else fetch_l1 <= ~stageadr[1] & ~stageadr[0] & ~pcwaitf & ~waitexm & ~ocdwait & ~skipexe & ~dma & ~intack & ~intack_wait | intack_l2;
	end

/***** dmaak (trd60) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) begin
			dmaack_l1 <= 1'b0;
			dmaack_l2 <= 1'b0;
		end
		else begin
			dmaack_l1 <= dmaack;
			dmaack_l2 <= dmaack_l1;
		end
	end
	assign	dma = ~dmaack & (dmaack_l1 | dmaack_l2);
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) dma_l1 <= 1'b0;
		else		dma_l1 <= dma;
	end

/***** prefix (trd59) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	prefix_id1 <= 1'b0;
		else prefix_id1 <= prefix; /* prefix$B$OBP>]L?Na$N(Bid$B4|4VCfN)$D(B */
	end

/***** word, mrd, mwr (trd58-56) *****/
	/* ----------------------------------------------------	*/ /* -------------------------------------------------	*/
	/* CPU$B$,(Bwait$B$7$?(BIDStage$B$N<!$N(BMEMStage$B$K(Baccess$B$,$"$k>l9g(B	*/ /* stageadr$B$O(B1clock$B$G=hM}$G$-$J$$L?Na$NFbIt(Bcounter$B$G(B	*/
	/* cpurd,cpuwr$B?.9f$O(BIDStage$B$+$i?-$S$F(Bactive$B$H$J$k(B.	*/ /* fetch$B?.9f@8@.$K;HMQ(B.access$B$N(Bmask$B$K$O;HMQ$G$-$J$$(B.	*/
	/* pcwaitfActive$B$N<!$N(Bclock$B$G(Bcpurd,cpuwr$B$,(BActive$B$N>l9g(B,	*/ /* baseck	_|~|_|~|_|~|_|~|_|~|_|~|_|~|_		*/
	/* $B$=$N(Bcpurd,cpuwr$B$O(Bwait$B$G?-$S$?J,$G(Btrace$B$H$7$F$O(Breject	*/ /* pc	=x===x=(*1)==x===x===x===x===		*/
	/* (from eva-core$BC4Ev(B)					*/ /* stageadr	====0====x=1=x====0==========		*/
	/*               [   id     ][mem]			*/ /* cpurd	_________|~~~|_______________		*/
	/* baseck	_|~|_|~|_|~|_|~|_|~|_|~|_|~|_		*/ /* cpuwr	_____________|~~~|___________		*/
	/* pcwaitf	_|~~~~~~~|___|~~~|____________		*/ /* *1 ex) xch(read-modify-write)$BL?Na(B ..		*/
	/* cpurd	_____|~~~~~~~~~~~|____________		*/ /* IDStage$B$r(B1clock$B?-$P$7(Bread$B=hM}$r9T$C$F$$$k(B		*/
	/* rd(internal)	_____xxxxxxxx_________________		*/ /*							*/
	/* -------------------------------------------------	*/ /* -------------------------------------------------	*/

	/* ------------------------------------------------------------------------------------------------------------	*/
	/* (1)RAMFetch$B$G$N(Bdma$BE>Aw;~$O(BdmaRead$B$,(Bmask$B$5$l$k$N$G(B,dma$BE>Aw$O(Bmask$B$5$l$J$$$h$&>r7o$KJLESF~$l$k(B.(rw)		*/
	/* (2)$B30It(Baccess$B;~$OB>$N(Baccess$B$H(Btiming$B$,0[$J$k0Y(B,waitexm$B$r(Bpcwaitf$B$KF~$l9~$a$J$$(B.				*/
	/*    pcwaitf_l$B$H$7$?;~$K(Baccess$B$,(Bmask$B$5$l$F$7$^$&0Y(B.								*/
	/* (3)EXMEM,RAMfetch$B;~(B,intack$B$N(Btiming$B$G(B~ramfch&cpurd($B??$N(Bread$B$G$O$J$$(B)$B$N>uBV$,5/$3$k(B. RAM$B;~$O(B			*/
	/*    pcwaitf_l$B$G(Bmask$B$5$l$k$,(B,EXMEM$B;~$O(Bwaitexm$B$G(Bmask$B$7$F$$$k$N$G$3$N56$N(Bcpurd$B$,(Breject$B$G$-$J$$0Y(B,		*/
	/*    ~intack$B$r(Bmrd$B$N>r7o$KF~$l$k(B.(read)										*/
	/* (4)-> [V1.70] ~intack$B$K$h$j(B,$BB?$/$N(BCase$B$G3d$j9~$_D>A0$N(BAccess$B$,(BTrace$B$5$l$J$$LdBj$,5/$-$F$$$?(B.EXMEM Fetch$B$G$O(B	*/
	/*    Access$B$rH/@8$5$;$kL?Na$N(BStage$B$G(BAccess$B$b9T$o$l$k0Y(B,$B<!$N3d9~$_$K$h$k(BPrefetch$B;~$N(B(3)$B$N(Bmask$B$K(Bintack$B$r;HMQ(B	*/
	/*    $B$7$FLdBj$J$$$,(B,Flash Fetch$B;~$J$I$O(BPreFetch$B$N(BStage$B$G(Bintack$B",$N(BTiming$B$HF1;~$K(BAccess$B$,9T$o$l$k0Y(B,Access$B$,(B	*/
	/*    Mask$B$5$l$F$7$^$&(B. ~intack -> ~((selexmpc | selrampc) & intack)$B$HJQ99(B.					*/
	/* (5)CPU$B$,(BNPB-Retry$BBP1~$N0Y$K(BV2$B$G=$@5$5$l$F$$$k!#$3$l$K9g$;$F(Bocdwait$B$r;HMQ$9$k=$@5$r9T$C$?!#(BTiming$B$O(BSystem$B;EMM(B	*/
	/*    $B=q$K5-:\$7$?!#(BFlash$B%U%'%C%A$N>l9g$H(BRAM$B%U%'%C%A$N>l9g$G(Bocdwait$B$H(Bpcwaitf$B$NF0$-$,0c$&$N$GCm0U$,I,MW!#30It$K(B	*/
	/*    $B$D$$$F$O8=>u(BCPU$B$,HsBP1~$G!"(BNPB$B$"$j!\30It$"$j$N@=IJ$,=P$FMh$?>l9g$K$O8!F$$,I,MW!#(B				*/
	/* ------------------------------------------------------------------------------------------------------------	*/
	// [V1.72] (5)
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
	
	// [V1.74]
	// RAM,EXMEM$B$+$i(BFlash$B$K(BPC$B$,A+0\8e$N(B1clock(WAITEXM Act$B;~$O(B+Wait)$B$r8!=P(B(mask_branch)
	// $B$7(B,cpurd$B$r(BMask$B$9$k$3$H$GIT@5$J(BRead$B$r8!=P$7$J$$9=@.$H$7$?(B.
	// [V1.75]
	// BRAM(selbrampc),BFA(selbfapc)$B$r>r7o$KDI2C(B.
	reg selxxxpc_wait;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)   selxxxpc_wait <= 1'b0;
		else if (waitexm) selxxxpc_wait <= selxxxpc_wait;
		else              selxxxpc_wait <= (selexmpc | selrampc | selbrampc);
	end
	wire mask_branch = selxxxpc_wait & (selrompc | selbfapc);
	
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	begin  word_l1 <= 1'b0; mrd_l1 <= 1'b0; mwr_l1 <= 1'b0; end
		else begin
			word_l1 <= wdop;
			mrd_l1  <= cpurd & (~pcwaitf_l & ~waitexm & ~ocdwait & ~fchram & ~cpumask &
					    ~((selexmpc | selrampc) & intack) & ~mask_branch | dma | pcwaitf_lw);
			mwr_l1  <= cpuwr & (~pcwaitf_l & ~waitexm & ~ocdwait & ~fchram & ~cpumask | dma | pcwaitf_lw);
		end
	end

/***** fetch address (trd55-36) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	fch_adr_l1 <= 20'b0;
		else fch_adr_l1 <= pc;
	end

/***** access address (trd35-16) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	acc_adr_l1 <= 20'b0;
		else acc_adr_l1 <= dma ? {4'hf,ma} : {exma,ma};
	end

/***** access data (trd15-0) *****/
	/* ---------------------------------------------------------------------------- */
	/* MirrorAccess$B;~$O(BPrefixAccess$B$HF1MM$NF0$-$r$9$k$,(B,Prefix$B?.9f$ON)$?$J$$(B.	*/
	/* MirrorAccess$B;~$b(BReadData$B$r<h$j9~$a$k$h$&(Bflread$B?.9f$r;HMQ(B.			*/
	/* ---------------------------------------------------------------------------- */
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	flrd_en <= 1'b0;
		else if (~pcwaitf & flread)
				flrd_en <= 1'b1;
		else		flrd_en <= 1'b0;
	end

	/* --------------------------------------------------------------------------------------------	*/
	/* flash Read$B;~$O$=$NL?Na$N(BID-Stage$B$K(Bwait$B$,F~$j(Bpa,pid$B$r2#<h$j$7$F(BRead$B$9$k(B.$B$^$?(B, MEM-Stage$B$G(B	*/
	/* ma$B$K(Baddress,"mdw"$B$K(BReadData(alu$B$N=PNO?b$lN.$7(B)$B$,>h$k(B.->alu$B=PNO$O(Baddw,subw$B$J$I$NL?Na$N>l9g(B	*/
	/* Read$BCM$G$J$/1i;;7k2L$,=PNO$5$l$k$N$GCm0U(B.							*/
	/* --------------------------------------------------------------------------------------------	*/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) flread_data <= 16'b0;
		else begin
			case ({flread, flreadb}) // synopsys parallel_case
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

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	acc_data_l1 <= 16'b0;
		else if (cpurd)	acc_data_l1 <= flrd_en ? flread_data : mdr;
		else if (cpuwr)	acc_data_l1 <= mdw;
	end

// ------------------------------------------------------------------------------------------------------
// 2nd Buffer (trd107-105, 103-71, 62-0)								-
// ------------------------------------------------------------------------------------------------------

/***** fetch data (trd103-72) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)	fch_data_l2 <= 32'b0;
		else begin
			case (trdself_l1[0])	// trdsel$B$O(Bhost-reg$B$J$N$GFC$K(BTiming$B5$$K$7$J$$(B
				1'b0 : fch_data_l2 <= fch_data_l1;
				1'b1 : fch_data_l2 <= tag;
			endcase
		end
	end

/***** tagovf (trd71) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) begin
			tagovf_l2	<= 1'b0;
		end else if (we_snap | trctest) begin
			tagovf_l2	<= snapdt[71];
		end else begin
			tagovf_l2	<= tagovf_l1;
		end
	end

/***** fetch (trd61) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			fetch_l2 <= 1'b0;
		else if (monitrc | !svmod_fch)
			fetch_l2 <= fetch_l1;
		else	fetch_l2 <= 1'b0;
	end

/***** mrd, mwr (trd57-56) *****/
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) begin
			mrd_l2 <= 1'b0;
			mwr_l2 <= 1'b0;
		end else if (monitrc | !svmod_acc) begin
			mrd_l2 <= mrd_l1;
			mwr_l2 <= mwr_l1;
		end else begin
			mrd_l2 <= 1'b0;
			mwr_l2 <= 1'b0;
		end
	end

	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) begin
			trdself_l2	<= 2'h0;
			selfmode_l2	<= 1'b0;
			int_l2		<= 1'b0;
			dma_l2		<= 1'b0;
			prefix_id2	<= 1'b0;
			word_l2		<= 1'b0;
			fch_adr_l2	<= 20'h0;
			acc_adr_l2	<= 20'h0;
			acc_data_l2	<= 16'h0;

		end else begin
			trdself_l2	<= trdself_l1;	// 107-106
			selfmode_l2	<= selfmode_l1;	// 105
			int_l2		<= int_l1;	// 62
			dma_l2		<= dma_l1;	// 60
			prefix_id2	<= prefix_id1;	// 59
			word_l2		<= word_l1;	// 58
			fch_adr_l2	<= fch_adr_l1;	// 55-36
			acc_adr_l2	<= acc_adr_l1;	// 35-16
			acc_data_l2	<= acc_data_l1;	// 15-0
		end
	end

// ------------------------------------------------------------------------------------------------------
// 3rd Buffer (trd107-105, 103-72, 62-0)								-
// ------------------------------------------------------------------------------------------------------
	always @( posedge baseck or negedge sysrsoutb ) begin
		if (!sysrsoutb) begin
			trdself		<= 2'h0;
			selfmode_l3	<= 1'b0;
			fch_data	<= 32'h0;
			int_l3		<= 1'b0;
			fetch		<= 1'b0;
			dma_l3		<= 1'b0;
			prefix_id3	<= 1'b0;
			word		<= 1'b0;
			mrd		<= 1'b0;
			mwr		<= 1'b0;
			fch_adr		<= 20'h0;
			acc_adr		<= 20'h0;
			acc_data	<= 16'h0;

		end else if (we_snap | trctest) begin
			trdself		<= snapdt[107:106];
			selfmode_l3	<= snapdt[105];
			fch_data	<= snapdt[103:72];
			int_l3		<= snapdt[62];
			fetch		<= snapdt[61];
			dma_l3		<= snapdt[60];
			prefix_id3	<= snapdt[59];
			word		<= snapdt[58];
			mrd		<= snapdt[57];
			mwr		<= snapdt[56];
			fch_adr		<= snapdt[55:36];
			acc_adr		<= snapdt[35:16];
			acc_data	<= snapdt[15:0];

		end else begin
			trdself		<= trdself_l2;	// trdsel
			selfmode_l3	<= selfmode_l2;	// selfmode
			fch_data	<= fch_data_l2;	// idadr
			int_l3		<= int_l2; // int
			fetch		<= fetch_l2;	// fetch
			dma_l3		<= dma_l2;	// dmaak
			prefix_id3	<= prefix_id2;	// prefix_id
			word		<= word_l2;	// wdop
			mrd		<= mrd_l2;	// read status
			mwr		<= mwr_l2;	// write status
			fch_adr		<= fch_adr_l2;	// pc
			acc_adr		<= acc_adr_l2;	// exma, ma
			acc_data	<= acc_data_l2;	// mdr, mdw
		end
	end

// ------------------------------------------------------------------------------------------------------
// trace data												-
// ------------------------------------------------------------------------------------------------------

// --------------------
// $BDL>o$N%H%l!<%9%G!<%?(B
// --------------------
	assign	autotrd = {
	// ------------------------------------------------------
	// 107-104						-
	// ------------------------------------------------------
		trdself[1],	// sp trace flag		
		trdself[0],	// time-tag trace flag		
		selfmode_l3,	// flash self			
		reserve1,	// Reserve			
	// ------------------------------------------------------
	// 103-72						-
	// ------------------------------------------------------
		fch_data,	// fetch data or time-tag data	
	// ------------------------------------------------------
	// 71-68						-
	// ------------------------------------------------------
		tagovf_l2,	// time-tag over flow		
		iceresb_st,	// ice reset			
		periresb_st,	// peripheral reset		
		tarresb_st,	// target reset			
	// ------------------------------------------------------
	// 67-36						-
	// ------------------------------------------------------
		secen_bit,	// section trace	67	
		qualifyf,	// qualify trace	66	
		delay_bit,	// delay trace		65	
		step_l1,	// step run		64	
		soft_bit,	// soft-output flame	63	
		int_l3,		// interrupt		62	
		fetch,		// fetch status		61	
		dma_l3,		// dma status		60	
		prefix_id3,	// prefix status	59	
		word,		// byte or write status	58	
		mrd,		// memory read		57	
		mwr,		// memory write		56	
		fch_adr,	// fetch address	55-36	
	// ------------------------------------------------------
	// 35-0							-
	// ------------------------------------------------------
		acc_adr,	// access address		
		acc_data	// access data			
		};

	wire	dmy1 = sysrsoutb | monitrc; /* $B>o$K#1$N?.9f:n@.(B $B9g@.;~$K=LB`$5$;$J$$$?$a(B */
	wire	dmy2 = sysrsoutb | trcon; /* $B>o$K#1$N?.9f:n@.(B $B9g@.;~$K=LB`$5$;$J$$$?$a(B */

	tmemdlyl dly107 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[107]), .out(autotrd_d[107]));
	tmemdlyl dly106 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[106]), .out(autotrd_d[106]));
	tmemdlyl dly105 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[105]), .out(autotrd_d[105]));
	tmemdlyl dly104 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[104]), .out(autotrd_d[104]));
	tmemdlyl dly103 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[103]), .out(autotrd_d[103]));
	tmemdlyl dly102 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[102]), .out(autotrd_d[102]));
	tmemdlyl dly101 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[101]), .out(autotrd_d[101]));
	tmemdlyl dly100 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[100]), .out(autotrd_d[100]));
	tmemdlyl dly99 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[99]), .out(autotrd_d[99]));
	tmemdlyl dly98 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[98]), .out(autotrd_d[98]));
	tmemdlyl dly97 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[97]), .out(autotrd_d[97]));
	tmemdlyl dly96 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[96]), .out(autotrd_d[96]));
	tmemdlyl dly95 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[95]), .out(autotrd_d[95]));
	tmemdlyl dly94 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[94]), .out(autotrd_d[94]));
	tmemdlyl dly93 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[93]), .out(autotrd_d[93]));
	tmemdlyl dly92 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[92]), .out(autotrd_d[92]));
	tmemdlyl dly91 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[91]), .out(autotrd_d[91]));
	tmemdlyl dly90 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[90]), .out(autotrd_d[90]));
	tmemdlyl dly89 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[89]), .out(autotrd_d[89]));
	tmemdlyl dly88 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[88]), .out(autotrd_d[88]));
	tmemdlyl dly87 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[87]), .out(autotrd_d[87]));
	tmemdlyl dly86 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[86]), .out(autotrd_d[86]));
	tmemdlyl dly85 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[85]), .out(autotrd_d[85]));
	tmemdlyl dly84 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[84]), .out(autotrd_d[84]));
	tmemdlyl dly83 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[83]), .out(autotrd_d[83]));
	tmemdlyl dly82 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[82]), .out(autotrd_d[82]));
	tmemdlyl dly81 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[81]), .out(autotrd_d[81]));
	tmemdlyl dly80 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[80]), .out(autotrd_d[80]));
	tmemdlyl dly79 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[79]), .out(autotrd_d[79]));
	tmemdlyl dly78 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[78]), .out(autotrd_d[78]));
	tmemdlyl dly77 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[77]), .out(autotrd_d[77]));
	tmemdlyl dly76 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[76]), .out(autotrd_d[76]));
	tmemdlyl dly75 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[75]), .out(autotrd_d[75]));
	tmemdlyl dly74 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[74]), .out(autotrd_d[74]));
	tmemdlyl dly73 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[73]), .out(autotrd_d[73]));
	tmemdlyl dly72 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[72]), .out(autotrd_d[72]));
	tmemdlyl dly71 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[71]), .out(autotrd_d[71]));
	tmemdlyl dly70 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[70]), .out(autotrd_d[70]));
	tmemdlyl dly69 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[69]), .out(autotrd_d[69]));
	tmemdlyl dly68 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[68]), .out(autotrd_d[68]));
	tmemdlyl dly67 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[67]), .out(autotrd_d[67]));
	tmemdlyl dly66 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[66]), .out(autotrd_d[66]));
	tmemdlyl dly65 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[65]), .out(autotrd_d[65]));
	tmemdlyl dly64 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[64]), .out(autotrd_d[64]));
	tmemdlyl dly63 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[63]), .out(autotrd_d[63]));
	tmemdlyl dly62 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[62]), .out(autotrd_d[62]));
	tmemdlyl dly61 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[61]), .out(autotrd_d[61]));
	tmemdlyl dly60 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[60]), .out(autotrd_d[60]));
	tmemdlyl dly59 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[59]), .out(autotrd_d[59]));
	tmemdlyl dly58 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[58]), .out(autotrd_d[58]));
	tmemdlyl dly57 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[57]), .out(autotrd_d[57]));
	tmemdlyl dly56 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[56]), .out(autotrd_d[56]));
	tmemdlyl dly55 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[55]), .out(autotrd_d[55]));
	tmemdlyl dly54 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[54]), .out(autotrd_d[54]));
	tmemdlyl dly53 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[53]), .out(autotrd_d[53]));
	tmemdlyl dly52 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[52]), .out(autotrd_d[52]));
	tmemdlyl dly51 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[51]), .out(autotrd_d[51]));
	tmemdlyl dly50 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[50]), .out(autotrd_d[50]));
	tmemdlyl dly49 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[49]), .out(autotrd_d[49]));
	tmemdlyl dly48 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[48]), .out(autotrd_d[48]));
	tmemdlyl dly47 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[47]), .out(autotrd_d[47]));
	tmemdlyl dly46 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[46]), .out(autotrd_d[46]));
	tmemdlyl dly45 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[45]), .out(autotrd_d[45]));
	tmemdlyl dly44 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[44]), .out(autotrd_d[44]));
	tmemdlyl dly43 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[43]), .out(autotrd_d[43]));
	tmemdlyl dly42 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[42]), .out(autotrd_d[42]));
	tmemdlyl dly41 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[41]), .out(autotrd_d[41]));
	tmemdlyl dly40 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[40]), .out(autotrd_d[40]));
	tmemdlyl dly39 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[39]), .out(autotrd_d[39]));
	tmemdlyl dly38 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[38]), .out(autotrd_d[38]));
	tmemdlyl dly37 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[37]), .out(autotrd_d[37]));
	tmemdlyl dly36 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[36]), .out(autotrd_d[36]));
	tmemdlyl dly35 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[35]), .out(autotrd_d[35]));
	tmemdlyl dly34 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[34]), .out(autotrd_d[34]));
	tmemdlyl dly33 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[33]), .out(autotrd_d[33]));
	tmemdlyl dly32 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[32]), .out(autotrd_d[32]));
	tmemdlyl dly31 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[31]), .out(autotrd_d[31]));
	tmemdlyl dly30 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[30]), .out(autotrd_d[30]));
	tmemdlyl dly29 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[29]), .out(autotrd_d[29]));
	tmemdlyl dly28 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[28]), .out(autotrd_d[28]));
	tmemdlyl dly27 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[27]), .out(autotrd_d[27]));
	tmemdlyl dly26 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[26]), .out(autotrd_d[26]));
	tmemdlyl dly25 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[25]), .out(autotrd_d[25]));
	tmemdlyl dly24 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[24]), .out(autotrd_d[24]));
	tmemdlyl dly23 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[23]), .out(autotrd_d[23]));
	tmemdlyl dly22 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[22]), .out(autotrd_d[22]));
	tmemdlyl dly21 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[21]), .out(autotrd_d[21]));
	tmemdlyl dly20 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[20]), .out(autotrd_d[20]));
	tmemdlyl dly19 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[19]), .out(autotrd_d[19]));
	tmemdlyl dly18 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[18]), .out(autotrd_d[18]));
	tmemdlyl dly17 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[17]), .out(autotrd_d[17]));
	tmemdlyl dly16 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[16]), .out(autotrd_d[16]));
	tmemdlyl dly15 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[15]), .out(autotrd_d[15]));
	tmemdlyl dly14 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[14]), .out(autotrd_d[14]));
	tmemdlyl dly13 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[13]), .out(autotrd_d[13]));
	tmemdlyl dly12 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[12]), .out(autotrd_d[12]));
	tmemdlyl dly11 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[11]), .out(autotrd_d[11]));
	tmemdlyl dly10 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[10]), .out(autotrd_d[10]));
	tmemdlyl dly9 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[9]), .out(autotrd_d[9]));
	tmemdlyl dly8 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[8]), .out(autotrd_d[8]));
	tmemdlyl dly7 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[7]), .out(autotrd_d[7]));
	tmemdlyl dly6 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[6]), .out(autotrd_d[6]));
	tmemdlyl dly5 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[5]), .out(autotrd_d[5]));
	tmemdlyl dly4 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[4]), .out(autotrd_d[4]));
	tmemdlyl dly3 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[3]), .out(autotrd_d[3]));
	tmemdlyl dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[2]), .out(autotrd_d[2]));
	tmemdlyl dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[1]), .out(autotrd_d[1]));
	tmemdlyl dly0 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(autotrd[0]), .out(autotrd_d[0]));

/* ------- */
/* trd bus */
/* ------- */
	/* ----------------------------------------------------------------------------	*/
	/* tmemclk$B$G=P8}$@$1@Z$k$H(B,tmemclk$B$K4V$K9g$&$b$N$H4V$K9g$o$J$$$b$N$G(B1clock	*/
	/* $B$:$l$F$^$&2DG=@-$,$"$k$N$G(Btmemclk$BF14|$OD|$a$k(B.$BF~$j8}$G@Z$C$F$bF1$8$O$J$7(B.	*/
	/* ----------------------------------------------------------------------------	*/
	assign	trd = ( trcon | monitrc ) ? autotrd_d :
			( host_write )    ? hostwd :
			108'bz;

/* ------------------- */
/* host read interface */
/* ------------------- */
	/* ------------------------------------------------------------------------------------	*/
	/* monitor$BCf$d(Btrace$BCf$G$b(Bread$B$O2DG=(B(trd bus$B$NCM$,8+$($k(B)				*/
	/* reset$BCf$O(Bpcifa$B$,!J$J$<$+!K=i4|CM(Bffff_0000h$B$K$J$k$N$G(B3'b100$B>r7o@.N)$7$F$7$^$&$,!"(B	*/
	/* trd$B$O(BHi-z(Pull-Down)$B$J$N$GLdBj$J$7(B							*/
	/* ------------------------------------------------------------------------------------	*/
	always @( trmem_host_cs or iceifa or trd ) begin
		casex ( {trmem_host_cs, iceifa} ) // synopsys parallel_case
			3'b100	: trdrd = trd[31:0];					// memory0
			3'b101	: trdrd = trd[67:36];					// memory1
			3'b110	: trdrd = trd[103:72];					// memory2
			3'b111	: trdrd = {20'b0,trd[107:104],trd[71:68],trd[35:32]};	//bit35-32
			default	: trdrd = 32'b0;
		endcase
	end

endmodule


// ======================================================================================================
// cs													=
// ======================================================================================================
module	trace_cs (
		iceifa,	ma, alt1, svmod, cpuwr, wdop, trctest,
		trcmode_cs, trdlydt_cs, trdlyrd_cs, trcadr_cs,
		trcard_cs, trcmem_cs, trcfact_cs, trcdlyendclr_cs,
		secclr_cs, traovfcl_cs, trcdlyactclr_cs, hostwd0_cs, hostwd1_cs,
		hostwd2_cs, hostwd3_cs, trdsel_cs, trctest_cs, monitrc_cs, snapdt_cs,
		snapdten, trace_altcs, trmem_host_cs
	);

	input [31:2]	iceifa ;
	input [15:0]	ma ;
	input		alt1, svmod, cpuwr, wdop, trctest;
	output		trcmode_cs, trdlydt_cs, trdlyrd_cs, trcadr_cs,
			trcard_cs, trcmem_cs, trcfact_cs, trcdlyendclr_cs,
			secclr_cs, traovfcl_cs, trcdlyactclr_cs, hostwd0_cs, hostwd1_cs,
			hostwd2_cs, hostwd3_cs, trdsel_cs, trctest_cs;
	output		monitrc_cs;
	output [13:0]	snapdt_cs;
	output		snapdten;
	output		trace_altcs;
	output		trmem_host_cs;

	wire		trace_cs;
	wire		snap_ucs;

/* -------- */
/* host i/o */
/* -------- */
	assign	trmem_host_cs	= (iceifa[31:24] == 8'h40) ? 1'b1 : 1'b0;
	assign	trace_cs	= (iceifa[31:8] == 24'h0808_00) ? 1'b1:1'b0;
	assign	trcmode_cs	= (trace_cs & (iceifa[7:2] == 6'b0000_00)) ? 1'b1 : 1'b0;
//	assign	trcfuldt_cs	= (trace_cs & (iceifa[7:2] == 6'b0000_01)) ? 1'b1 : 1'b0;
	assign	trdlydt_cs	= (trace_cs & (iceifa[7:2] == 6'b0000_10)) ? 1'b1 : 1'b0;
	assign	trdlyrd_cs	= (trace_cs & (iceifa[7:2] == 6'b0000_11)) ? 1'b1 : 1'b0;
	assign	trcadr_cs	= (trace_cs & (iceifa[7:2] == 6'b0001_00)) ? 1'b1 : 1'b0;
	assign	trcard_cs	= (trace_cs & (iceifa[7:2] == 6'b0001_01)) ? 1'b1 : 1'b0;
	assign	trcmem_cs	= (trace_cs & (iceifa[7:2] == 6'b0001_10)) ? 1'b1 : 1'b0;
	assign	trcfact_cs	= (trace_cs & (iceifa[7:2] == 6'b0001_11)) ? 1'b1 : 1'b0;
//	assign	trcfulclr_cs	= (trace_cs & (iceifa[7:2] == 6'b0010_00)) ? 1'b1 : 1'b0;
	assign	trcdlyendclr_cs	= (trace_cs & (iceifa[7:2] == 6'b0010_01)) ? 1'b1 : 1'b0;
	assign	secclr_cs	= (trace_cs & (iceifa[7:2] == 6'b0010_10)) ? 1'b1 : 1'b0;
	assign	traovfcl_cs	= (trace_cs & (iceifa[7:2] == 6'b0010_11)) ? 1'b1 : 1'b0;
	assign	trcdlyactclr_cs	= (trace_cs & (iceifa[7:2] == 6'b0011_00)) ? 1'b1 : 1'b0;
	assign	hostwd0_cs	= (trace_cs & (iceifa[7:2] == 6'b0011_01)) ? 1'b1 : 1'b0;
	assign	hostwd1_cs	= (trace_cs & (iceifa[7:2] == 6'b0011_10)) ? 1'b1 : 1'b0;
	assign	hostwd2_cs	= (trace_cs & (iceifa[7:2] == 6'b0011_11)) ? 1'b1 : 1'b0;
	assign	hostwd3_cs	= (trace_cs & (iceifa[7:2] == 6'b0100_00)) ? 1'b1 : 1'b0;
	assign	trdsel_cs	= (trace_cs & (iceifa[7:2] == 6'b0100_01)) ? 1'b1 : 1'b0;
	assign	trctest_cs	= (trace_cs & (iceifa[7:2] == 6'b0100_10)) ? 1'b1 : 1'b0;

/* ------------- */
/* alternate i/o */
/* ------------- */
	assign	trace_altcs	= ma[15:6] == 10'b1100_0000_00;
	assign	monitrc_cs	= (trace_altcs & (ma[5:0] == 6'b01_1111) & svmod & !alt1) ? 1'b1 : 1'b0;
	assign	snap_ucs	= (trace_altcs & (ma[5:4] == 2'b10)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[0]	= (snap_ucs & (ma[3:0] == 4'b0000) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[1]	= (snap_ucs & (ma[3:1] == 3'b000) & ((ma[0] == 1'b1) | ((ma[0] == 1'b0) & wdop)) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[2]	= (snap_ucs & (ma[3:0] == 4'b0010) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[3]	= (snap_ucs & (ma[3:1] == 3'b001) & ((ma[0] == 1'b1) | ((ma[0] == 1'b0) & wdop)) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[4]	= (snap_ucs & (ma[3:0] == 4'b0100) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[5]	= (snap_ucs & (ma[3:1] == 3'b010) & ((ma[0] == 1'b1) | ((ma[0] == 1'b0) & wdop)) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[6]	= (snap_ucs & (ma[3:0] == 4'b0110) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[7]	= (snap_ucs & (ma[3:1] == 3'b011) & ((ma[0] == 1'b1) | ((ma[0] == 1'b0) & wdop)) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[8]	= (snap_ucs & (ma[3:0] == 4'b1000) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[9]	= (snap_ucs & (ma[3:1] == 3'b100) & ((ma[0] == 1'b1) | ((ma[0] == 1'b0) & wdop)) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[10]	= (snap_ucs & (ma[3:0] == 4'b1010) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[11]	= (snap_ucs & (ma[3:1] == 3'b101) & ((ma[0] == 1'b1) | ((ma[0] == 1'b0) & wdop)) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[12]	= (snap_ucs & (ma[3:0] == 4'b1100) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdt_cs[13]	= (snap_ucs & (ma[3:1] == 3'b110) & ((ma[0] == 1'b1) | ((ma[0] == 1'b0) & wdop)) & ((svmod & !alt1) | trctest)) ? 1'b1 : 1'b0;
	assign	snapdten = (snap_ucs & (ma[3:0] == 4'b1110) & svmod & !alt1) & cpuwr ? 1'b1 : 1'b0;

endmodule

// ======================================================================================================
// tmemclk output selector										=
// ======================================================================================================
module tmemclk_sel ( trcon, monitrc, baseck, host_clk, tmemclk );
	input	trcon, monitrc, baseck, host_clk;
	output	tmemclk;

	assign	tmemclk = ( trcon | monitrc ) ? baseck : host_clk;
endmodule


// ======================================================================================================
// reset status ($BHsF14|$r4^$`!K(B										=
// ======================================================================================================

	/* ------------------------------------------------------------ */
	/* |~|_|_|~|_|~|_|~|_|~|_|~|_					*/
	/* x==x==0===x===	     pc					*/
	/*               x===0===x== fch_adr				*/
	/* ~~~|~~~~~~~~~~~~~~~	     reset_in				*/
	/* ___|_______________	     reset				*/
	/*    |~~|___|~~~~~~~~	     pcwaitf				*/
	/*     |~~~~~|___|~~~~	     pcwaitf_l				*/
	/* ___|~~~~~~|______________ mask_reset(wpulse mask signal)	*/
	/* ____|~~~~~~~~~|___	     mask_reset_l			*/
	/*     ______________|~~~|__ wpulse				*/
	/* ______|~~~~~~~~~~~~~~~|__ reset_st				*/
	/* ------------------------------------------------------------ */
	/* Reset$B;~(B,1clock$B$@$1(Bbaseck$B$,$R$2$K$J$k2DG=@-$,$"$k(B(cg$B$N;HMQ>e(B)	*/

	/* ----------------------------	*/
	/* baseck  |~|_|~|_|~|_|~|_	*/
	/* we_snap ____|~~~|_______	*/
	/* trd     x=======x===x===	*/
	/* wpulse  ________|~~~|___	*/
	/* ----------------------------	*/

module reset_detect ( baseck, reset_in, reset_mask, snapdt, we_snap, trctest, pcwaitf_l,
			wpulse, trcon, monitrc, sysrsoutb, mask_reset, reset_st );

	input	baseck, reset_in, reset_mask, snapdt, we_snap, trctest, pcwaitf_l, wpulse, trcon, monitrc, sysrsoutb;
	output	mask_reset;
	output	reset_st;

	wire	reset;
	reg	mask_reset, mask_reset_l, reset_st;

	/* ------------------------------- */
	/* mask signal for wpulse by reset */
	/* ------------------------------- */
	assign	reset = ~reset_in & ~reset_mask & (trcon | monitrc);
	always @(negedge pcwaitf_l or posedge reset) begin
		if (reset) mask_reset <= 1'b1;
		else mask_reset <= 1'b0;
	end

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) mask_reset_l <= 1'b0;
		else mask_reset_l <= mask_reset;
	end

	/* --------------------------- */
	/* reset status for trace data */
	/* --------------------------- */
	always @(posedge baseck or negedge sysrsoutb) begin
		if(!sysrsoutb)
			reset_st <= 1'b0;
		else if (we_snap | trctest)
			reset_st <= snapdt;
		else if (mask_reset_l)
			reset_st <= 1'b1;
		else if (wpulse)
			reset_st <= 1'b0;
	end

endmodule

// ======================================================================================================
// reset status ($B<~JU$+$i$N%j%;%C%HMQ!K(B									=
// ======================================================================================================

	/* ------------------------------------	*/
	/* iceresb	~~|__|~~~~~~~~~~~~~~~~~	*/
	/* tarresb	~~~~~~~~~|__|~~~~~~~~~~	*/
	/* cpursout	___|~~|___|~~|___|~~|__	*/
	/* reset_l1	____|~~|___|~~|___|~~|_	*/
	/* reset_l2	_____|~~|___|~~|___|~~|	*/
	/* reset_l3	___________________|~~~	*/
	/* ------------------------------------	*/
	/* ----------------------------------------------------------------------------	*/
	/* $B<~JU$+$i$N(BReset(wdt,trap)$B$O@=IJ$G$O(BAnalogueNoise$B=|5n$r;H$C$F(Bdelay$B8e$N?.9f$G(B	*/
	/* $B<+?H$r2r=|$7$F$$$k$,(B,ICE$BHG$G$O(Bclk30mhz$B$+(Bclk60mhz$B$G(BDegitalNoise$B=|5n$7$F(B	*/
	/* $B$$$k$N$G(Bclk30mhz$B$+(Bclk60mhz$BF14|$H$J$k(B	-> $B$3$3$G$O(B60mhz$BF14|$G(Bsampling$B$9$k(B.	*/
	/* ----------------------------------------------------------------------------	*/

module reset_detect2 ( baseck, clk60mhz, reset_in, snapdt, we_snap, trctest, iceresb, icemskice, tarresb,
			icemsktrst, pcwaitf_l, wpulse, trcon, monitrc, sysrsoutb, mask_reset, reset_st );

	input	baseck, clk60mhz, reset_in, snapdt, we_snap, trctest, iceresb, icemskice, tarresb, icemsktrst,
		pcwaitf_l, wpulse, trcon, monitrc, sysrsoutb;
	output	mask_reset;
	output	reset_st;

	wire		reset;
	reg		mask_reset, reset_l1, reset_l2, reset_l3, reset_l4;
	reg [1:0]	pcwaitf_l2;
	reg		reset_st;

	/* ------------------------------- */
	/* mask signal for wpulse by reset */
	/* ------------------------------- */
	assign	reset = ~reset_in & (trcon | monitrc);
	always @(negedge pcwaitf_l or posedge reset) begin
		if (reset) mask_reset <= 1'b1;
		else mask_reset <= 1'b0;
	end

	always @(posedge clk60mhz or negedge sysrsoutb) begin
		if (!sysrsoutb) reset_l1 <= 1'b0;
		else reset_l1 <= reset;
	end
	always @(posedge clk60mhz or negedge sysrsoutb) begin
		if (!sysrsoutb) reset_l2 <= 1'b0;
		else reset_l2 <= reset_l1;
	end
	always @(posedge clk60mhz or negedge sysrsoutb) begin
		if (!sysrsoutb) pcwaitf_l2 <= 1'b0;
		else pcwaitf_l2 <= {pcwaitf_l2[0], pcwaitf_l};
	end

	/* ------------------------------------------------------------------------------------	*/
	/* [V1.73] pcwaitf_l2->pcwaitf_l2[1:0]$B$NHsF14|BP:v$r9T$C$?!#(B				*/
	/* pcwaitf_l$B$r(B1$B2s(B60M$B$G@Z$jD>$7$??.9f$H(Bbaseck$BF14|$N86H/$GO@M}$rAH$s$G$$$?$N$G!"JQ2=E@$,(B	*/
	/* $B$V$D$+$k:]$K(Breset_l3$B$,(B0Clear$B$5$l$J$$4m81$,$"$C$?0Y!"(Bpcwaitf$B$r(B2$B2s@Z$jD>$7$F(B60M$BF14|$N(B	*/
	/* $B$_$GO@M}$rAH$`9=@.$H$7$?!#(Bpcwaitf$B$O(B60M$B$G(B2$B2s@Z$jD>$7$F$b(Bbaseck(max25M)$B$h$j$b<jA0$G@Z(B	*/
	/* $B$j=*$k!#$^$?!"<B:]$O(BReset$B2r=|8e:G8e$N(BFetch$B$O(BWait$B$,F~$k0Y!"D>$K$O(Bwpulse$B$,Mh$J$$$N$G!"(B	*/
	/* $B$b$&>/$71d$S$?$H$7$F$bLdBj$J$$!#(B							*/
	/* ------------------------------------------------------------------------------------	*/
	always @( posedge clk60mhz or negedge sysrsoutb ) begin
		if (!sysrsoutb) reset_l3 <= 1'b0;
		else if (reset_l1 & ~reset_l2)
				reset_l3 <= ((iceresb | icemskice) & (tarresb | icemsktrst));
		else if (~pcwaitf_l2[0] & pcwaitf_l2[1])
				reset_l3 <= 1'b0;
	end

	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) reset_l4 <= 1'b0;
		else reset_l4 <= reset_l3;
	end

	/* --------------------------- */
	/* reset status for trace data */
	/* --------------------------- */
	always @(posedge baseck or negedge sysrsoutb) begin
		if(!sysrsoutb)
			reset_st <= 1'b0;
		else if (we_snap | trctest)
			reset_st <= snapdt;
		else if (reset_l4)
			reset_st <= 1'b1;
		else if (wpulse)
			reset_st <= 1'b0;
	end

endmodule


// ======================================================================================================
// Insert output delay1											=
// ======================================================================================================
// $B%j%;%C%H=i4|CM(B0$B$H$J$k?.9fMQ(B
// $BCY1d@8@.MQ$K%l%Y%k%i%C%A$r;HMQ(B

module tmemdlyl (dmy1, dmy2, sysrsoutb, in, out);
	input	dmy1, dmy2, sysrsoutb, in;
	output	out;

	reg	[3:0]	dly;
	reg		out;

	always @(sysrsoutb or dmy1 or in ) begin
		if (!sysrsoutb) dly[0] <= 1'b0;
		else if (dmy1) dly[0] <= in;
	end
	always @(sysrsoutb or dmy2 or dly[0]) begin
		if (!sysrsoutb) dly[1] <= 1'b0;
		else if (dmy2) dly[1] <= dly[0];
	end
	always @(sysrsoutb or dmy1 or dly[1]) begin
		if (!sysrsoutb) dly[2] <= 1'b0;
		else if (dmy1) dly[2] <= dly[1];
	end
	always @(sysrsoutb or dmy2 or dly[2]) begin
		if (!sysrsoutb) dly[3] <= 1'b0;
		else if (dmy2) dly[3] <= dly[2];
	end
	always @(sysrsoutb or dmy1 or dly[3]) begin
		if (!sysrsoutb) out <= 1'b0;
		else if (dmy1) out <= dly[3];
	end

endmodule


// ======================================================================================================
// Insert output delay2											=
// ======================================================================================================
// $B%j%;%C%H=i4|CM(B1$B$H$J$k?.9fMQ(B
// $BCY1d@8@.MQ$K%l%Y%k%i%C%A$r;HMQ(B

module tmemdlyh (dmy1, dmy2, sysrsoutb, in, out);
	input	dmy1, dmy2, sysrsoutb, in;
	output	out;

	reg	[3:0]	dly;
	reg		out;

	always @(sysrsoutb or dmy1 or in ) begin
		if (!sysrsoutb) dly[0] <= 1'b1;
		else if (dmy1) dly[0] <= in;
	end
	always @(sysrsoutb or dmy2 or dly) begin
		if (!sysrsoutb) dly[1] <= 1'b1;
		else if (dmy2) dly[1] <= dly[0];
	end
	always @(sysrsoutb or dmy1 or dly) begin
		if (!sysrsoutb) dly[2] <= 1'b1;
		else if (dmy1) dly[2] <= dly[1];
	end
	always @(sysrsoutb or dmy2 or dly) begin
		if (!sysrsoutb) dly[3] <= 1'b1;
		else if (dmy2) dly[3] <= dly[2];
	end
	always @(sysrsoutb or dmy1 or dly) begin
		if (!sysrsoutb) out <= 1'b1;
		else if (dmy1) out <= dly[3];
	end

endmodule


