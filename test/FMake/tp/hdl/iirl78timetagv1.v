/* ================================================================================================= */
/* [RL78 IECUBE ICE Macro]                                                                           */
/*                                                                                                   */
/* Function : timetag block                                                                          */
/*                                                                                                   */
/* ------------------------------------------------------------------------------------------------- */
/* Date     : 2010.06.18                                                                             */
/* Version  : 1.0.0                                                                                  */
/* Designer : T.Tsunoda                                                                              */
/* Note     : modified from timeragv1.v ver100                                                       */
/*          : Change system clock to 240MHz from 60MHz for the purpose of supporting 64MHz products. */
/* ------------------------------------------------------------------------------------------------- */
/* Date     : 2010.06.23                                                                             */
/* Version  : 1.0.1                                                                                  */
/* Designer : T.Tsunoda                                                                              */
/* Note     : Changed the timing of samp_flag, because meta-stable is occerrd.                       */
/* ------------------------------------------------------------------------------------------------- */
/* Date     : 2011.02.01                                                                             */
/* Version  : 1.0.2                                                                                  */
/* Designer : T.Tsunoda                                                                              */
/* Note     : Modified "Comment" only.                                                               */
/* ------------------------------------------------------------------------------------------------- */
/* Date     : 2011.02.21                                                                             */
/* Version  : 1.0.3                                                                                  */
/* Designer : T.Tsunoda                                                                              */
/* Note     : - Change the macro name and the file name.                                             */
/*          :   (TIMETAGV2(timetagv2.v) -> IIRL78TIMETAGV1(iirl78timetagv1.v)                        */
/*          : - Took out the 240MHz oscillator outside macro.                                        */
/*          :   - Delete pin : PONRESB(in), CLK60MHZ(in), CLK60MHZLOCK(in), LOCK240FAIL(out).        */
/*          :   - Add pin : CLK240M(in)                                                              */
/* ================================================================================================= */

module IIRL78TIMETAGV1 (
		ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25,
		ICEIFA24, ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18,
		ICEIFA17, ICEIFA16, ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11,
		ICEIFA10, ICEIFA9,  ICEIFA8,  ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,
		ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0,
		ICEDI31,  ICEDI30,  ICEDI29,  ICEDI28,  ICEDI27,  ICEDI26,  ICEDI25, ICEDI24,
		ICEDI23,  ICEDI22,  ICEDI21,  ICEDI20,  ICEDI19,  ICEDI18,  ICEDI17, ICEDI16,
		ICEDI15,  ICEDI14,  ICEDI13,  ICEDI12,  ICEDI11,  ICEDI10,  ICEDI9,   ICEDI8,
		ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4,   ICEDI3,   ICEDI2,   ICEDI1,   ICEDI0,
		ICEWR,
		ICEDOR31, ICEDOR30, ICEDOR29, ICEDOR28, ICEDOR27, ICEDOR26, ICEDOR25, ICEDOR24,
		ICEDOR23, ICEDOR22, ICEDOR21, ICEDOR20, ICEDOR19, ICEDOR18, ICEDOR17, ICEDOR16,
		ICEDOR15, ICEDOR14, ICEDOR13, ICEDOR12, ICEDOR11, ICEDOR10, ICEDOR9,  ICEDOR8,
		ICEDOR7,  ICEDOR6,  ICEDOR5,  ICEDOR4,  ICEDOR3,  ICEDOR2,  ICEDOR1,  ICEDOR0,
		BASECK, SYSRSOUTB, SVMODI, MONITRC, 
		TAG31, TAG30, TAG29, TAG28, TAG27, TAG26, TAG25, TAG24,
		TAG23, TAG22, TAG21, TAG20, TAG19, TAG18, TAG17, TAG16,
		TAG15, TAG14, TAG13, TAG12, TAG11, TAG10, TAG9,  TAG8,
		TAG7,  TAG6,  TAG5,  TAG4,  TAG3,  TAG2,  TAG1,  TAG0,
		TAGOVF,
		CLK240M
	) ;

input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28,	// Host I/F Address Bus			( <- eva_pcifg )
	ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,	//
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,	//
	ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,	//
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,	//
	ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,	//
	ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,	//
	ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0,	//
	ICEDI31,  ICEDI30,  ICEDI29,  ICEDI28,	// Host I/F Write Data Bus		( <- eva_pcifg )
	ICEDI27,  ICEDI26,  ICEDI25,  ICEDI24,	//
	ICEDI23,  ICEDI22,  ICEDI21,  ICEDI20,	//
	ICEDI19,  ICEDI18,  ICEDI17,  ICEDI16,	//
	ICEDI15,  ICEDI14,  ICEDI13,  ICEDI12,	//
	ICEDI11,  ICEDI10,  ICEDI9,   ICEDI8,	//
	ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4,	//
	ICEDI3,   ICEDI2,   ICEDI1,   ICEDI0 ;	//
input	ICEWR ;					// Host I/F Write Strobe		( <- eva_pcifg )
output	ICEDOR31, ICEDOR30, ICEDOR29, ICEDOR28,	// Host I/F Read Data Bus		( -> eva_pcifg )
	ICEDOR27, ICEDOR26, ICEDOR25, ICEDOR24,	//
	ICEDOR23, ICEDOR22, ICEDOR21, ICEDOR20,	//
	ICEDOR19, ICEDOR18, ICEDOR17, ICEDOR16,	//
	ICEDOR15, ICEDOR14, ICEDOR13, ICEDOR12,	//
	ICEDOR11, ICEDOR10, ICEDOR9,  ICEDOR8,	//
	ICEDOR7,  ICEDOR6,  ICEDOR5,  ICEDOR4,	//
	ICEDOR3,  ICEDOR2,  ICEDOR1,  ICEDOR0 ;	//
input	BASECK ;				// CPU Base Clock			( <- device pin )
input	SYSRSOUTB ;				// System Reset Signal			( <- resetctl )
input	SVMODI ;				// Super-Visor Mode Status(ICE)		( <- break )
input	MONITRC ;				// Monitor Trace Status			( <- trace )
output	TAG31, TAG30, TAG29, TAG28, TAG27,	// Time Tag Data			( -> trace )
	TAG26, TAG25, TAG24, TAG23, TAG22,	//
	TAG21, TAG20, TAG19, TAG18, TAG17,	//
	TAG16, TAG15, TAG14, TAG13, TAG12,	//
	TAG11, TAG10, TAG9,  TAG8,  TAG7,	//
	TAG6,  TAG5,  TAG4,  TAG3,  TAG2,	//
	TAG1,  TAG0 ;				//
output	TAGOVF ;				// Time Tag Over Flow Status		( -> trace )
input	CLK240M;                                // 240MHz Clock                         ( <- emu macro )

	wire [44:0]	tagadr ;
	wire [31:0]	iceifa, icedi, tagadrl_ro, tagcntl_ro ;
	wire [12:0]	tagadrh_ro, tagcnth_ro ;
	wire [11:0]	tagdtsel_ro ;
	wire		CLK240M;

	assign	iceifa = {ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26,
			  ICEIFA25, ICEIFA24, ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
			  ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16, ICEIFA15, ICEIFA14,
			  ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
			  ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,  ICEIFA3,  ICEIFA2,
			  ICEIFA1,  ICEIFA0} ;

	assign	icedi = {ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
			 ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
			 ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9,  ICEDI8,
			 ICEDI7,  ICEDI6,  ICEDI5,  ICEDI4,  ICEDI3,  ICEDI2,  ICEDI1,  ICEDI0} ;

	assign	{ICEDOR31,ICEDOR30,ICEDOR29,ICEDOR28,ICEDOR27,ICEDOR26,ICEDOR25,ICEDOR24,
		 ICEDOR23,ICEDOR22,ICEDOR21,ICEDOR20,ICEDOR19,ICEDOR18,ICEDOR17,ICEDOR16,
		 ICEDOR15,ICEDOR14,ICEDOR13,ICEDOR12,ICEDOR11,ICEDOR10,ICEDOR9 ,ICEDOR8 ,
		 ICEDOR7 ,ICEDOR6 ,ICEDOR5 ,ICEDOR4 ,ICEDOR3 ,ICEDOR2 ,ICEDOR1 ,ICEDOR0 }
		= tagadrl_ro | {21'b0,tagadrh_ro} | tagcntl_ro | {21'b0,tagcnth_ro} | {20'b0,tagdtsel_ro[11:8],8'b0};

// ---------------------------------------------------------------------------------------------------
// host io
// ---------------------------------------------------------------------------------------------------
	wire	tag_cs	= (iceifa[31:8] == 24'h0840_10) ? 1'b1:1'b0;
	wire	tagdtsel_cs	= (tag_cs & (iceifa[7:1] == 7'b0000_000)) ? 1'b1 : 1'b0 ;
	wire	ttagovfclr_cs	= (tag_cs & (iceifa[7:0] == 8'b0000_0100)) ? 1'b1 : 1'b0 ;
	wire	ttagcntclr_cs	= (tag_cs & (iceifa[7:0] == 8'b0000_1000)) ? 1'b1 : 1'b0 ;
	wire	tagadrl_cs	= (tag_cs & (iceifa[7:2] == 6'b0000_11)) ? 1'b1 : 1'b0 ;
	wire	tagadrh_cs	= (tag_cs & (iceifa[7:1] == 7'b0001_000)) ? 1'b1 : 1'b0 ;
	wire	tagld_cs	= (tag_cs & (iceifa[7:0] == 8'b0001_0100)) ? 1'b1 : 1'b0 ;
	wire	tagcntl_cs	= (tag_cs & (iceifa[7:2] == 6'b0001_10)) ? 1'b1 : 1'b0 ;
	wire	tagcnth_cs	= (tag_cs & (iceifa[7:1] == 7'b0001_110)) ? 1'b1 : 1'b0 ;
// ---------------------------------------------------------------------------------------------------
//	tag data output select register
// ---------------------------------------------------------------------------------------------------
	reg [3:0] tagcntsel;
	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)		tagcntsel <= 4'b0 ;
		else if (tagdtsel_cs)	tagcntsel <= icedi[11:8] ;
	end
	assign	tagdtsel_ro = tagdtsel_cs ? {tagcntsel, 8'b0} : 12'b0 ;
// ---------------------------------------------------------------------------------------------------
// 240MHz counter count timing (sampling for meta-stable)
// ---------------------------------------------------------------------------------------------------
	/*--------------------------------------------------------------------------------------*/
	/* [V200]										*/
	/* Counterの出力を発振させないためにCounterの手前にmetas対策を入れる。			*/
	/* (targetのV4は90n processで240Mは約4nsなのでFF1段ではやや不足するかもしれないが)	*/
	/*--------------------------------------------------------------------------------------*/
	reg [1:0] tagsvmod;
	always @(posedge CLK240M or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB)	tagsvmod <= 2'h0;
		else		tagsvmod <= {tagsvmod[0], SVMODI};
	end
	reg [1:0] tagmonitrc;
	always @(posedge CLK240M or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB)	tagmonitrc <= 2'h0;
		else		tagmonitrc <= {tagmonitrc[0], MONITRC};
	end
// ---------------------------------------------------------------------------------------------------
// counter sampling timing
// ---------------------------------------------------------------------------------------------------
	/*--------------------------------------------------------------------------------------*/
	/* [V200]										*/
	/* trace(baseck同期)にデータを載せるため,データ化けしないように,baseckに対して一定の		*/
	/* SetUpを持たせる必要がある。traceではTAGをbaseck↑で取り込むので,baseckのHiレベルを		*/
	/* サンプリングしてTAGに載せるタイミングを決めている(samp_flag)。このサンプリング信号		*/
	/* のmetasを考慮する必要があり,sampbck_metaを作成,また,baseck↑からのSetUpマージンを		*/
	/* 稼ぐためにsampbck_l->samp_flagを作成している。metas対策としては不十分にも思えるが,		*/
	/* これがぎりぎり。									*/
	/*--------------------------------------------------------------------------------------*/
	/* 240M		|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_	*/
	/*    		x=1=x=2=x=3=x=4=x=5=x=6=x=7=x=8=x=9=x=10x=11x=12x=13x=14x=15x=16	*/
	/* 40M(baseck)	  |~~~~~~~~~~~|___________|~~~~~~~~~~~|___________|~~~~~~~~~~~|_____	*/
	/* 65M(baseck)    |~~~~~~|_______|~~~~~~|_______|~~~~~~|_______|~~~~~~|_______		*/
	/* 80M(baseck)	__|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~	*/
	/* sampbck	____|~~~|mmm____|~~~~mmm|___|~~~|mmm____|~~~~mmm|___|~~~|mmm____	*/
	/* sampbck_meta	________|~~~|_______|~~~~~~~|___|~~~|_______|~~~~~~~|___|~~~|_____	*/
	/* sampbck_l	____________|~~~|_______|~~~~~~~|___|~~~|_______|~~~~~~~|___|~~~|___	*/
	/* samp_flag	________|~~~|_______|~~~|_______|~~~|_______|~~~|_______|~~~|_______	*/
	/* tag		            x===3=======x===6=======x===9=======x===12======x===15==	*/
	/* fch_data_l2	              x===2=======x===6=======x===9=======x===12========	*/
	/*		          ->| |<- 0.5clock(2ns)						*/
	/* [V202] baseckのmaxは64MHzなので,((1/64M)/2-(1/240M))*10^9=3.64ns程とれる。		*/
	/*											*/
	/* 240M		|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_	*/
	/*    		x=1=x=2=x=3=x=4=x=5=x=6=x=7=x=8=x=9=x=10x=11x=12x=13x=14x=15x=16	*/
	/* 40M(baseck)	|~~~~~~~~~~~|___________|~~~~~~~~~~~|___________|~~~~~~~~~~~|_______	*/
	/* 65M(baseck)  |~~~~~~|_______|~~~~~~|_______|~~~~~~|_______|~~~~~~|_______		*/
	/* 80M(baseck)	|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~	*/
	/* sampbck	mmmm|~~~|___|mmm~~~~|___mmmm|~~~|___|mmm~~~~|___mmmm|~~~|___mmmm	*/
	/* sampbck_meta	________|~~~|___|~~~~~~~|_______|~~~|___|~~~~~~~|_______|~~~|_____	*/
	/* sampbck_l	____________|~~~|___|~~~~~~~|_______|~~~|___|~~~~~~~|_______|~~~|___	*/
	/* samp_flag	________|~~~|___|~~~|___________|~~~|___|~~~|___________|~~~|_______	*/
	/* tag		            x===3===x===5===========x===9===x===11==========x===15==	*/
	/* fch_data_l2	            x===3=======x===5=======x===9=======x===11======x=15	*/
	/*		          ->||<- 0clock(0ns)						*/
	/* [V202] baseckのmaxは64MHzなので,((1/64M)-(1/240M)*3)*10^9=3.125ns程。34MHzだと余裕。	*/
	/*											*/
	/* 240M		|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_	*/
	/*    		x=1=x=2=x=3=x=4=x=5=x=6=x=7=x=8=x=9=x=10x=11x=12x=13x=14x=15x=16x=17	*/
	/* 40M(baseck)	|~~~~~~~~~~~|___________|~~~~~~~~~~~|___________|~~~~~~~~~~~|_______	*/
	/* sampbck	mmmm|~~~~~~~|mmm________mmmm|~~~~~~~mmmm|_______|mmm~~~~~~~~mmmm|___	*/
	/* sampbck_meta	________|~~~~~~~|_______________|~~~~~~~~~~~|_______|~~~~~~~~~~~~~~~|_	*/
	/* sampbck_l	____________|~~~~~~~|_______________|~~~~~~~~~~~|_______|~~~~~~~~~~~~~	*/
	/* samp_flag	________|~~~|___________________|~~~|_______________|~~~|_____________	*/
	/* tag		            x===2===================x===8===============x===13========	*/
	/* fch_data_l2	                        x===2===================x===8===============	*/
	/*		            |<--------->| 3clock(12.5ns)				*/
	/*--------------------------------------------------------------------------------------*/
	reg sampbck;
	always @( posedge CLK240M or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)	sampbck <= 1'b0 ;
		else		sampbck <= BASECK ;
	end
	reg sampbck_meta;
	always @( posedge CLK240M or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)	sampbck_meta <= 1'b0;
		else		sampbck_meta <= sampbck;
	end
	reg sampbck_l;
	always @( posedge CLK240M or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB) sampbck_l <= 1'b0;
		else		sampbck_l <= sampbck_meta;
	end
	wire samp_flag = sampbck_meta & ~sampbck_l;
// ---------------------------------------------------------------------------------------------------
//	load tag-address buffer (TAGADRH,L)
// ---------------------------------------------------------------------------------------------------
	reg [31:0] tagadrl;
	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)		tagadrl <= 32'b0;
		else if (tagadrl_cs)	tagadrl <= icedi;
	end
	assign	tagadrl_ro = tagadrl_cs ? tagadrl : 32'b0;

	reg [12:0] tagadrh;
	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)		tagadrh <= 13'b0;
		else if (tagadrh_cs)	tagadrh <= icedi[12:0];
	end
	assign	tagadrh_ro = tagadrh_cs ? tagadrh : 13'b0;
	assign	tagadr = {tagadrh, tagadrl};
// ---------------------------------------------------------------------------------------------------
//	tag-address load status (TAGLD)
// ---------------------------------------------------------------------------------------------------
	/* ----------------------------------------------------	*/
	/* CLK240M	|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_	*/
	/* icewr	______|~~~~~~~~~~|__________________	*/
	/* tagld_cs	__|~~~~~~~~~~~~~~~~~~~|_____________	*/
	/* ptagload	_________________|~~|_______________	*/
	/* tagload	____________________|~~~|___________	*/
	/* count240m	===x====================x=trcadr====	*/
	/* ----------------------------------------------------	*/
	reg tagload;
	reg ptagload;

	wire	load_res = !SYSRSOUTB | tagload;
	always @( negedge ICEWR or posedge load_res ) begin
		if (load_res)		ptagload <= 1'b0 ;
		else if (tagld_cs)	ptagload <= 1'b1 ;
	end

	always @( posedge CLK240M or negedge SYSRSOUTB ) begin /* load enable */
		if (!SYSRSOUTB)	tagload <= 1'b0 ;
		else		tagload <= ptagload ;
	end
// ---------------------------------------------------------------------------------------------------
//	counter ( count240m )
// ---------------------------------------------------------------------------------------------------
	wire	ttagcntclr  = ttagcntclr_cs & ICEWR | ~SYSRSOUTB;
	reg [44:0] count240m;
	always @( posedge CLK240M or posedge ttagcntclr ) begin
		if (ttagcntclr)
			count240m <= 0;
		else if (tagload)
			count240m <= tagadr;		// load
		else if ( ~tagsvmod[1] | tagmonitrc[1] )
			count240m <= count240m + 1'b1;	// count up
	end

	assign	tagcntl_ro = tagcntl_cs ? count240m[31:0] : 32'b0;
	assign	tagcnth_ro = tagcnth_cs ? count240m[44:32] : 13'b0;
// ---------------------------------------------------------------------------------------------------
//	rate selector (counterのbit選択によりrateを選択する)
// ---------------------------------------------------------------------------------------------------
	/*--------------------------------------------------------------------------------------*/
	/* [V200]										*/
	/* timetagv1の仕様に合せこめるように,60MHz->240MHz(2^2倍)としている。そこで,tagcntselの	*/
	/* 仕様もUpper compatibleになるように0:fx/4...,b:fx,c:fx/2という形で2bit追加する。	*/
	/*--------------------------------------------------------------------------------------*/
	reg [31:0] tagcount;
	always @( tagcntsel or count240m ) begin
		case ( tagcntsel )
			4'hb	: tagcount = count240m[31:0];	// fx		counter
			4'hc	: tagcount = count240m[32:1];	// fx/2		counter
			4'h0	: tagcount = count240m[33:2];	// fx/4		counter
			4'h1	: tagcount = count240m[34:3];	// fx/8		counter
			4'h2	: tagcount = count240m[35:4];	// fx/16	counter
			4'h3	: tagcount = count240m[36:5];	// fx/32	counter
			4'h4	: tagcount = count240m[37:6];	// fx/64	counter
			4'h5	: tagcount = count240m[38:7];	// fx/128	counter
			4'h6	: tagcount = count240m[39:8];	// fx/256	counter
			4'h7	: tagcount = count240m[40:9];	// fx/512	counter
			4'h8	: tagcount = count240m[41:10];	// fx/1024	counter
			4'h9	: tagcount = count240m[42:11];	// fx/2048	counter
			4'ha	: tagcount = count240m[43:12];	// fx/4096	counter
			default	: tagcount = count240m[33:2] ;	// fx/4		counter
		endcase
	end
// ---------------------------------------------------------------------------------------------------
//	time tag data
// ---------------------------------------------------------------------------------------------------
	reg [31:0] tag;
	always @( posedge CLK240M or posedge ttagcntclr ) begin
		if (ttagcntclr)
			tag <= 32'h0;
		else if (samp_flag)
			tag <= tagcount; // tag -> trace.fch_data_l2にmax_delay 3nsを設定する。
	end
	
	assign	{TAG31, TAG30, TAG29, TAG28, TAG27, TAG26, TAG25, TAG24,
		 TAG23, TAG22, TAG21, TAG20, TAG19, TAG18, TAG17, TAG16,
		 TAG15, TAG14, TAG13, TAG12, TAG11, TAG10, TAG9,  TAG8,
		 TAG7,  TAG6,  TAG5,  TAG4,  TAG3,  TAG2,  TAG1,  TAG0} = tag ;
// ---------------------------------------------------------------------------------------------------
//	time tag over-flow flag
// ---------------------------------------------------------------------------------------------------
	/*--------------------------------------------------------------------------------------*/
	/* [V200] tagcntselと同様,timetagv1とUpper compatibleになる形で2bit追加する。		*/
	/*--------------------------------------------------------------------------------------*/
	reg tagovin;
	always @( tagcntsel or count240m[42:32] ) begin
		case ( tagcntsel )
			4'hb	: tagovin = count240m[32];	// over-flow flag @ fx
			4'hc	: tagovin = count240m[33];	// over-flow flag @ fx/2
			4'h0	: tagovin = count240m[34] ;	// over-flow flag @ fx/4
			4'h1	: tagovin = count240m[35] ;	// over-flow flag @ fx/8
			4'h2	: tagovin = count240m[36] ;	// over-flow flag @ fx/16
			4'h3	: tagovin = count240m[37] ;	// over-flow flag @ fx/32
			4'h4	: tagovin = count240m[38] ;	// over-flow flag @ fx/64
			4'h5	: tagovin = count240m[39] ;	// over-flow flag @ fx/128
			4'h6	: tagovin = count240m[40] ;	// over-flow flag @ fx/256
			4'h7	: tagovin = count240m[41] ;	// over-flow flag @ fx/512
			4'h8	: tagovin = count240m[42] ;	// over-flow flag @ fx/1024
			4'h9	: tagovin = count240m[43] ;	// over-flow flag @ fx/2048
			4'ha	: tagovin = count240m[44] ;	// over-flow flag @ fx/4096
			default	: tagovin = count240m[34] ;	// over-flow flag @ fx/4
		endcase
	end
// ---------------------------------------------------------------------------------------------------
//	over-flow flag capture 240m	
// ---------------------------------------------------------------------------------------------------
	wire	ttagovfclr =  ttagovfclr_cs & ICEWR | ~SYSRSOUTB ;
	
	reg TAGOVF;
	always @ ( posedge CLK240M or posedge ttagovfclr ) begin
		if ( ttagovfclr )
			TAGOVF <= 1'b0 ;
		else if ( tagovin & samp_flag )
			TAGOVF <= 1'b1 ; // synthesis attribute maxdelay TAGOVF 5;
	end

endmodule

