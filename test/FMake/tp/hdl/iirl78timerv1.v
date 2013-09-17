/* ================================================================================================= */
/* [RL78 IECUBE ICE Macro]                                                                           */
/*                                                                                                   */
/* Function : timer block                                                                            */
/*                                                                                                   */
/* ------------------------------------------------------------------------------------------------- */
/* Date     : 2011.02.21                                                                             */
/* Version  : 1.0.0                                                                                  */
/* Designer : T.Tsunoda                                                                              */
/* Note     : modified from timerv1.v ver100                                                         */
/* ------------------------------------------------------------------------------------------------- */
/* Date     : 2011.03.02                                                                             */
/* Version  : 1.0.1                                                                                  */
/* Designer : T.Tsunoda                                                                              */
/* Note     : Change source clock (CLK240M -> CLK120M) bacause of taugh timing.                      */
/* ================================================================================================= */

module IIRL78TIMERV1 (
		ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25,
		ICEIFA24, ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18,
		ICEIFA17, ICEIFA16, ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11,
		ICEIFA10, ICEIFA9,  ICEIFA8,  ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,
		ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0,
		ICEDI31,  ICEDI30,  ICEDI29,  ICEDI28,  ICEDI27,  ICEDI26,  ICEDI25,
		ICEDI24,  ICEDI23,  ICEDI22,  ICEDI21,  ICEDI20,  ICEDI19,  ICEDI18,
		ICEDI17,  ICEDI16,  ICEDI15,  ICEDI14,  ICEDI13,  ICEDI12,  ICEDI11,
		ICEDI10,  ICEDI9,   ICEDI8,   ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4,
		ICEDI3,   ICEDI2,   ICEDI1,   ICEDI0,	ICEWR,
		ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25,
		ICEDO24, ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18,
		ICEDO17, ICEDO16, ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11,
		ICEDO10, ICEDO9,  ICEDO8,  ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,
		ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0,
		EVD14, EVD13, EVD12, EVD11,
		BRKTMOVR, BRKTMOVC0, BRKTMOVN0, BRKTMOVC1, BRKTMOVN1, BRKTMOT0, BRKTMOT1,
		BASECK, SYSRSOUTB, SVMODI,
		CLK120M
	) ;
// -------------------------------------------------------------------------------------------------------
//                      Port Definition
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
input	EVD14 ;					// Timer-1 Off Event			( <- event_top )
input	EVD13 ;					// Timer-1 On Event			( <- event_top )
input	EVD12 ;					// Timer-0 Off Event			( <- event_top )
input	EVD11 ;					// Timer-0 On Event			( <- event_top )
output	BRKTMOVR ;				// Run-Break Timer Over-Flow Break	( -> break )
output	BRKTMOVC0 ;				// Event Timer0 Over-Flow Break		( -> break )
output	BRKTMOVN0 ;				// Number Counter0 Over-flow Break	( -> break )
output	BRKTMOVC1 ;				// Event Timer1 Over-Flow Break		( -> break )
output	BRKTMOVN1 ;				// Number Counter1 Over-flow Break	( -> break )
output	BRKTMOT0 ;				// Time-Out Break0			( -> break )
output	BRKTMOT1 ;				// Time-Out Break1			( -> break )
input	BASECK ;				// CPU Base Clock			( <- clock )
input	SVMODI ;					// Super-Visor Mode Status(ICE)		( <- break )
input	SYSRSOUTB ;				// System Reset Signal			( <- resetctl )
input	CLK120M ;				// 120MHz clock				( <- emu macro )
// -------------------------------------------------------------------------------------------------------
//                      END of Port Definition
// -------------------------------------------------------------------------------------------------------
	wire [31:0]	iceifa, icedi, runbk_ro, e2e_ro ;
	wire [7:0]	ovfmk_ro ;
	wire [1:0]	evtomk_ro, evnumomk_ro ;
	wire		evtomk_cs, ovfmk_cs, evnumomk_cs ;
	reg [1:0]	evtomk, evovfmk, evnumomk ;
	reg		rbovfmk ;

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

	assign	ICEDO31 = runbk_ro[31] | e2e_ro[31] ;
	assign	ICEDO30 = runbk_ro[30] | e2e_ro[30] ;
	assign	ICEDO29 = runbk_ro[29] | e2e_ro[29] ;
	assign	ICEDO28 = runbk_ro[28] | e2e_ro[28] ;
	assign	ICEDO27 = runbk_ro[27] | e2e_ro[27] ;
	assign	ICEDO26 = runbk_ro[26] | e2e_ro[26] ;
	assign	ICEDO25 = runbk_ro[25] | e2e_ro[25] ;
	assign	ICEDO24 = runbk_ro[24] | e2e_ro[24] ;
	assign	ICEDO23 = runbk_ro[23] | e2e_ro[23] ;
	assign	ICEDO22 = runbk_ro[22] | e2e_ro[22] ;
	assign	ICEDO21 = runbk_ro[21] | e2e_ro[21] ;
	assign	ICEDO20 = runbk_ro[20] | e2e_ro[20] ;
	assign	ICEDO19 = runbk_ro[19] | e2e_ro[19] ;
	assign	ICEDO18 = runbk_ro[18] | e2e_ro[18] ;
	assign	ICEDO17 = runbk_ro[17] | e2e_ro[17] | evnumomk_ro[1] ;
	assign	ICEDO16 = runbk_ro[16] | e2e_ro[16] | evnumomk_ro[0] ;
	assign	ICEDO15 = runbk_ro[15] | e2e_ro[15] | ovfmk_ro[7] ;
	assign	ICEDO14 = runbk_ro[14] | e2e_ro[14] | ovfmk_ro[6] ;
	assign	ICEDO13 = runbk_ro[13] | e2e_ro[13] | ovfmk_ro[5] ;
	assign	ICEDO12 = runbk_ro[12] | e2e_ro[12] | ovfmk_ro[4] ;
	assign	ICEDO11 = runbk_ro[11] | e2e_ro[11] | ovfmk_ro[3] ;
	assign	ICEDO10 = runbk_ro[10] | e2e_ro[10] | ovfmk_ro[2] ;
	assign	ICEDO9  = runbk_ro[9]  | e2e_ro[9]  | ovfmk_ro[1] ;
	assign	ICEDO8  = runbk_ro[8]  | e2e_ro[8]  | ovfmk_ro[0] ;
	assign	ICEDO7  = runbk_ro[7]  | e2e_ro[7]  ;
	assign	ICEDO6  = runbk_ro[6]  | e2e_ro[6]  ;
	assign	ICEDO5  = runbk_ro[5]  | e2e_ro[5]  ;
	assign	ICEDO4  = runbk_ro[4]  | e2e_ro[4]  ;
	assign	ICEDO3  = runbk_ro[3]  | e2e_ro[3]  ;
	assign	ICEDO2  = runbk_ro[2]  | e2e_ro[2]  ;
	assign	ICEDO1  = runbk_ro[1]  | e2e_ro[1]  | evtomk_ro[1] ;
	assign	ICEDO0  = runbk_ro[0]  | e2e_ro[0]  | evtomk_ro[0] ;

// --------------------------------------------------------------
// EVNUMOVF ( event timer number counter over-flow mask register)
// --------------------------------------------------------------
	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB )
			evnumomk <= 2'b0 ;
		else if ( evnumomk_cs )
			evnumomk <= icedi[17:16] ;
	end
	assign	evnumomk_ro = evnumomk_cs ? evnumomk : 2'b0 ;

// ---------------------------------------------------------------------
// OVFMK ( (Run-Break and Event) timer counter over-flow mask register )
// ---------------------------------------------------------------------
	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) begin
			rbovfmk <= 1'b0 ;
			evovfmk <= 2'b0 ;
		end
		else if ( ovfmk_cs ) begin
			rbovfmk <= icedi[15] ;
			evovfmk <= icedi[9:8] ;
		end
	end
	assign	ovfmk_ro = ovfmk_cs ? { rbovfmk, 5'b0, evovfmk } : 8'b0 ;

// --------------------------------------
// EVTOMK ( TimeOut-Break mask register )
// --------------------------------------
	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB )
			// default mask
			evtomk <= 2'b11 ;
		else if ( evtomk_cs )
			evtomk <= icedi[1:0] ;
	end
	assign	evtomk_ro = evtomk_cs ? evtomk : 2'b0 ;

// --------------------
// run break timer
// --------------------
	IIRL78TIMERV1_RUN_BREAK run_break (
			.baseck(BASECK),.clk120m(CLK120M), .sysrsoutb(SYSRSOUTB), .svmod(SVMODI),
			.rbtcl_cs(rbtcl_cs), .rbtmc_cs(rbtmc_cs), .rbcntl_cs(rbcntl_cs), .rbcnth_cs(rbcnth_cs),
			.cntovf_cs(cntovf_cs), .rbovfmk(rbovfmk), .icewr(ICEWR),
			.rbcntadrl_cs(rbcntadrl_cs), .rbcntadrh_cs(rbcntadrh_cs), .rbcntld_cs(rbcntld_cs),
			.icedi(icedi), .runbk_ro(runbk_ro), .brktmovr(BRKTMOVR),
			.rbcntll_cs(rbcntll_cs), .rbcntadrll_cs(rbcntadrll_cs)
		);

// --------------------
// event timer
// --------------------
	IIRL78TIMERV1_EVENT2EVENT event2event (
			.baseck(BASECK), .clk120m(CLK120M), .sysrsoutb(SYSRSOUTB), .svmod(SVMODI),
			.timon0(EVD11), .timon1(EVD13), .timoff0(EVD12), .timoff1(EVD14),
			.evtcl0_cs(evtcl0_cs), .evtcl1_cs(evtcl1_cs), .evcnt0_cs(evcnt0_cs),
			.evcnt1_cs(evcnt1_cs), .evnum0_cs(evnum0_cs), .evnum1_cs(evnum1_cs),
			.evtmsp0_cs(evtmsp0_cs), .evtmsp1_cs(evtmsp1_cs), .tevclr_cs(tevclr_cs),
			.evtmc_cs(evtmc_cs), .evrmc_cs(evrmc_cs), .evtmout_cs(evtmout_cs),
			.cntovf_cs(cntovf_cs), .evnumovf_cs(evnumovf_cs), .evac00_cs(evac00_cs),
			.evac10_cs(evac10_cs), .evac01_cs(evac01_cs), .evac11_cs(evac11_cs),
			.evmxkp0_cs(evmxkp0_cs), .evmxkp1_cs(evmxkp1_cs), .evmnkp0_cs(evmnkp0_cs),
			.evmnkp1_cs(evmnkp1_cs), .evtomk(evtomk), .evnumomk(evnumomk),
			.evovfmk(evovfmk),
			.evcntadr0_cs(evcntadr0_cs), .evcntadr1_cs(evcntadr1_cs),
			.evcntld0_cs(evcntld0_cs), .evcntld1_cs(evcntld1_cs),
			.icewr(ICEWR), .icedi(icedi), .e2e_ro(e2e_ro),
			.brktmot0(BRKTMOT0), .brktmot1(BRKTMOT1),
			.brktmovc0(BRKTMOVC0), .brktmovn0(BRKTMOVN0), .brktmovc1(BRKTMOVC1),
			.brktmovn1(BRKTMOVN1)
		) ;

// --------------------
// chip select
// --------------------
	IIRL78TIMERV1_TIMERCS timercs (
			.iceifa(iceifa), .rbcntl_cs(rbcntl_cs), .rbcnth_cs(rbcnth_cs), .rbtcl_cs(rbtcl_cs),
			.rbtmc_cs(rbtmc_cs), .tevclr_cs(tevclr_cs), .evtmc_cs(evtmc_cs),
			.evrmc_cs(evrmc_cs), .evcnt0_cs(evcnt0_cs), .evcnt1_cs(evcnt1_cs),
			.evnum0_cs(evnum0_cs), .evnum1_cs(evnum1_cs), .evac00_cs(evac00_cs),
			.evac10_cs(evac10_cs), .evac01_cs(evac01_cs), .evac11_cs(evac11_cs),
			.evmxkp0_cs(evmxkp0_cs), .evmxkp1_cs(evmxkp1_cs), .evmnkp0_cs(evmnkp0_cs),
			.evmnkp1_cs(evmnkp1_cs), .evtcl0_cs(evtcl0_cs), .evtcl1_cs(evtcl1_cs),
			.evtmsp0_cs(evtmsp0_cs), .evtmsp1_cs(evtmsp1_cs), .evtomk_cs(evtomk_cs),
			.evnumomk_cs(evnumomk_cs), .ovfmk_cs(ovfmk_cs), .evtmout_cs(evtmout_cs),
			.cntovf_cs(cntovf_cs), .evnumovf_cs(evnumovf_cs),
			.evcntadr0_cs(evcntadr0_cs), .evcntadr1_cs(evcntadr1_cs),
			.evcntld0_cs(evcntld0_cs), .evcntld1_cs(evcntld1_cs),
			.rbcntadrl_cs(rbcntadrl_cs), .rbcntadrh_cs(rbcntadrh_cs), .rbcntld_cs(rbcntld_cs),
			.rbcntll_cs(rbcntll_cs), .rbcntadrll_cs(rbcntadrll_cs)
		) ;
endmodule


// ===================================================================================================
//	run break timer
// ===================================================================================================
module IIRL78TIMERV1_RUN_BREAK	(
			baseck, clk120m, sysrsoutb, svmod, rbtcl_cs, rbtmc_cs, rbcntl_cs,  rbcnth_cs, 
			rbcntadrl_cs, rbcntadrh_cs, rbcntld_cs,
			cntovf_cs, rbovfmk, icewr, icedi, runbk_ro, brktmovr, rbcntll_cs, rbcntadrll_cs
		);

	input		baseck, clk120m, sysrsoutb, svmod, rbtcl_cs, rbtmc_cs, rbcntl_cs, rbcnth_cs,
			rbcntadrl_cs, rbcntadrh_cs, rbcntld_cs,
			cntovf_cs, rbovfmk, icewr ;
	input [31:0]	icedi ;
	output [31:0]	runbk_ro ;
	output		brktmovr ;
	input		rbcntll_cs, rbcntadrll_cs;

	wire [44:0]	rbcntadr ; // [ver1.0.0]
	wire [31:0]	rbcnth_ro, rbcntadrh_ro ;
	wire [10:0]	rbcntl_ro, rbcntadrl_ro ;
	wire [1:0]	rbcntll_ro, rbcntadrll_ro ; // [ver1.0.0]
	wire		rbcntovf_ro, rbtcl_ro;

	// [ver1.0.0] added bit12-11 of rbcntl_ro, rbcntadrl_ro.
	assign	runbk_ro[31] = rbcnth_ro[31] | rbcntadrh_ro[31];
	assign	runbk_ro[30] = rbcnth_ro[30] | rbcntadrh_ro[30];
	assign	runbk_ro[29] = rbcnth_ro[29] | rbcntadrh_ro[29];
	assign	runbk_ro[28] = rbcnth_ro[28] | rbcntadrh_ro[28];
	assign	runbk_ro[27] = rbcnth_ro[27] | rbcntadrh_ro[27];
	assign	runbk_ro[26] = rbcnth_ro[26] | rbcntadrh_ro[26];
	assign	runbk_ro[25] = rbcnth_ro[25] | rbcntadrh_ro[25];
	assign	runbk_ro[24] = rbcnth_ro[24] | rbcntadrh_ro[24];
	assign	runbk_ro[23] = rbcnth_ro[23] | rbcntadrh_ro[23];
	assign	runbk_ro[22] = rbcnth_ro[22] | rbcntadrh_ro[22];
	assign	runbk_ro[21] = rbcnth_ro[21] | rbcntadrh_ro[21];
	assign	runbk_ro[20] = rbcnth_ro[20] | rbcntadrh_ro[20];
	assign	runbk_ro[19] = rbcnth_ro[19] | rbcntadrh_ro[19];
	assign	runbk_ro[18] = rbcnth_ro[18] | rbcntadrh_ro[18];
	assign	runbk_ro[17] = rbcnth_ro[17] | rbcntadrh_ro[17];
	assign	runbk_ro[16] = rbcnth_ro[16] | rbcntadrh_ro[16];
	assign	runbk_ro[15] = rbcnth_ro[15] | rbcntadrh_ro[15];
	assign	runbk_ro[14] = rbcnth_ro[14] | rbcntadrh_ro[14];
	assign	runbk_ro[13] = rbcnth_ro[13] | rbcntadrh_ro[13];
	assign	runbk_ro[12] = rbcnth_ro[12] | rbcntadrh_ro[12];
	assign	runbk_ro[11] = rbcnth_ro[11] | rbcntadrh_ro[11];
	assign	runbk_ro[10] = rbcnth_ro[10] | rbcntadrh_ro[10] | rbcntl_ro[10] | rbcntadrl_ro[10];
	assign	runbk_ro[9]  = rbcnth_ro[9]  | rbcntadrh_ro[9]  | rbcntl_ro[9]  | rbcntadrl_ro[9];
	assign	runbk_ro[8]  = rbcnth_ro[8]  | rbcntadrh_ro[8]  | rbcntl_ro[8]  | rbcntadrl_ro[8];
	assign	runbk_ro[7]  = rbcnth_ro[7]  | rbcntadrh_ro[7]  | rbcntl_ro[7]  | rbcntadrl_ro[7]  | rbcntovf_ro ;
	assign	runbk_ro[6]  = rbcnth_ro[6]  | rbcntadrh_ro[6]  | rbcntl_ro[6]  | rbcntadrl_ro[6]  | rbtcl_ro;
	assign	runbk_ro[5]  = rbcnth_ro[5]  | rbcntadrh_ro[5]  | rbcntl_ro[5]  | rbcntadrl_ro[5];
	assign	runbk_ro[4]  = rbcnth_ro[4]  | rbcntadrh_ro[4]  | rbcntl_ro[4]  | rbcntadrl_ro[4];
	assign	runbk_ro[3]  = rbcnth_ro[3]  | rbcntadrh_ro[3]  | rbcntl_ro[3]  | rbcntadrl_ro[3];
	assign	runbk_ro[2]  = rbcnth_ro[2]  | rbcntadrh_ro[2]  | rbcntl_ro[2]  | rbcntadrl_ro[2];
	assign	runbk_ro[1]  = rbcnth_ro[1]  | rbcntadrh_ro[1]  | rbcntl_ro[1]  | rbcntadrl_ro[1];
	assign	runbk_ro[0]  = rbcnth_ro[0]  | rbcntadrh_ro[0]  | rbcntl_ro[0]  | rbcntadrl_ro[0]  | rbcntll_ro[0] | rbcntadrll_ro[0];

// ----------------------------------------------------------------
// RBTCL[RBCNTE] (Run-Break Timer Clock Select Register) [ver1.0.0]
// ----------------------------------------------------------------
	// rbtclは1bitなので単純なmetas対策のみでOK(同期化信号のfeedbackは不要).

	reg rbcnte_p;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if ( !sysrsoutb ) 
			rbcnte_p <= 1'b0 ;
		else if ( rbtcl_cs )
			rbcnte_p <= icedi[6] ;
	end

	// [ver1.0.0] Metas対策。ver1とのTP共用の可能性を考慮し4回切り直す。
	reg [2:0] rbcnte_meta;
	always @( posedge clk120m or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			rbcnte_meta <= 3'b000;
		else	rbcnte_meta <= {rbcnte_meta[1:0], rbcnte_p};
	end

	reg rbcnte;
	always @( posedge clk120m or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			rbcnte <= 1'b0;
		else	rbcnte <= rbcnte_meta[2];
	end

	assign	rbtcl_ro = rbtcl_cs ? rbcnte : 1'b0 ;

// ----------------------------------------------------------
// RBTMC (Run-Break Timer Counter Clear Register) [ ver1.0.0]
// ----------------------------------------------------------
	wire rbtmc_host_set;
	IIRL78TIMERV1_HOST_SET_SYNC rbtmc_set (
		.sysrsoutb(sysrsoutb), .host_clk(icewr), .host_cs(rbtmc_cs), .sync_clk(clk120m), .host_cs_sync(rbtmc_host_set)
	);

	reg rbtmc_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			rbtmc_host_data <= 1'b0;
		else if (rbtmc_cs)
			rbtmc_host_data <= icedi[0];
		else	rbtmc_host_data <= 1'b0;
	end

// -----------------------------------------------------------------------------------
// RBCNTADRH/RBCNTADRL/RBCNTADRLL ( load run-brake counter address buffer ) [ver1.0.0]
// -----------------------------------------------------------------------------------
	reg [31:0] rbcntadrh ;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if ( !sysrsoutb )
			rbcntadrh <= 32'h0000_0000 ;
		else if ( rbcntadrh_cs )
			rbcntadrh <= icedi ;
	end
	assign	rbcntadrh_ro = rbcntadrh_cs ? rbcntadrh : 32'h0000 ;

	reg [10:0] rbcntadrl ;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if ( !sysrsoutb )
			rbcntadrl <= 11'h000 ;
		else if ( rbcntadrl_cs )
			rbcntadrl <= icedi[10:0] ;
	end
	assign	rbcntadrl_ro = rbcntadrl_cs ? rbcntadrl : 11'h000 ;

	// [ver1.0.0] added 1bit.
	reg rbcntadrll ;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if ( !sysrsoutb )
			rbcntadrll <= 1'b0 ;
		else if ( rbcntadrll_cs )
			rbcntadrll <= icedi[0] ;
	end
	assign	rbcntadrll_ro = rbcntadrll_cs ? rbcntadrll : 1'b0 ;


	assign	rbcntadr = { rbcntadrh, rbcntadrl, rbcntadrll } ;

// --------------------------------------------------
// RBCNTLD ( run_brake timer load status ) [ver1.0.0]
// --------------------------------------------------
	wire rbcntload;
	IIRL78TIMERV1_HOST_SET_SYNC rbcntload_set (
		.sysrsoutb(sysrsoutb), .host_clk(icewr), .host_cs(rbcntld_cs), .sync_clk(clk120m), .host_cs_sync(rbcntload)
	);

// ----------------------------------------------------------------------
// RBCNTH/RBCNTL/RBCNTLL ( Run-Break timer counter ( 44bit ) ) [ver1.0.0]
// ----------------------------------------------------------------------
	wire rbcnt_fl;
	wire rbcnt_clr = (rbtmc_host_data & rbtmc_host_set) | ~sysrsoutb ;

	// [ver1.0.0] 120MHz化, 44bit化。(Metas回避のため、出来ればsvmodも同期化したい。)
	reg [43:0] allcnt ;
	always @( posedge clk120m or posedge rbcnt_clr ) begin
		if ( rbcnt_clr )
			allcnt <= 44'h000_0000_0000 ;
		else if ( rbcntload )
			allcnt <= rbcntadr ;
		else if ( rbcnte & ~svmod & ~rbcnt_fl )	// rbcnt=all-Fの時は保持
			allcnt <= allcnt + 1 ;
	end

	reg [31:0] rbcnth;
	always @( posedge clk120m or posedge rbcnt_clr ) begin
		if (rbcnt_clr)
			rbcnth <= 32'h0000_0000 ;
		else	rbcnth <= allcnt[43:12] ;
	end

	reg [10:0] rbcntl;
	always @( posedge clk120m or posedge rbcnt_clr ) begin
		if (rbcnt_clr)
			rbcntl <= 11'h000 ;
		else	rbcntl <= allcnt[11:1] ;
	end

	// --------------------------------------------------------
	// [ver1.0.0]
	// ver1とUser I/Fに互換性を持たせるため, rbcnth,rbcntlへの割付を
	// 1bit上にshiftさせ、追加した下位1bitはhost-i/oを別にする。
	// --------------------------------------------------------
	reg rbcntll;
	always @( posedge clk120m or posedge rbcnt_clr ) begin
		if (rbcnt_clr)
			rbcntll <= 1'b0 ;
		else	rbcntll <= allcnt[0] ;
	end

	// run中のhostからのreadはrbcnteを"0"にしてから行うこと
	assign	rbcnth_ro = rbcnth_cs ? rbcnth : 32'h0000_0000 ;
	assign	rbcntl_ro = rbcntl_cs ? rbcntl : 11'h000 ;
	assign	rbcntll_ro = rbcntll_cs ? rbcntll : 1'b0;
	assign	rbcnt_fl = ( allcnt == 44'hfff_ffff_ffff ) ? 1'b1 : 1'b0 ; // [ver1.0.0]

	// [ver1.0.0] clk60m->clk120m Only.
	// over-flowマスク設定であっても検出は行う

	wire rbcntovf_wr = cntovf_cs & icewr & icedi[7] | ~sysrsoutb ;

	reg rbcntovf;
	always @( posedge clk120m or posedge rbcntovf_wr ) begin
		if ( rbcntovf_wr )
			rbcntovf <= 1'b0 ;
		else if ( rbcnte & ~svmod & rbcnt_fl ) 
			rbcntovf <= 1'b1 ;
	end

	assign	rbcntovf_ro = cntovf_cs ? rbcntovf : 1'b0 ;

	wire brktmovr;
	reg brktmovr120m;
	wire brktmovr_res = ~sysrsoutb | brktmovr;

	always @( posedge clk120m or posedge brktmovr_res ) begin
		if ( brktmovr_res )
			brktmovr120m <= 1'b0 ;
		else if ( rbcnte & ~svmod & rbcnt_fl & ~rbcntovf & ~rbovfmk ) 
			brktmovr120m <= 1'b1 ;
	end

	IIRL78TIMERV1_BREAK_BASECK_SYNC brktmovr_sync (
		.baseck(baseck), .sysrsoutb(sysrsoutb), .break_async(brktmovr120m), .break(brktmovr)
	);

endmodule


// ===================================================================================================
//	event-to-event timer(TOP)
// ===================================================================================================
module	IIRL78TIMERV1_EVENT2EVENT (
		baseck, clk120m, sysrsoutb, svmod, timon0, timon1, timoff0, timoff1,
		evtcl0_cs, evtcl1_cs, evcnt0_cs, evcnt1_cs, evnum0_cs, evnum1_cs,
		evtmsp0_cs, evtmsp1_cs, tevclr_cs, evtmc_cs, evrmc_cs, evtmout_cs,
		cntovf_cs, evnumovf_cs, evac00_cs, evac10_cs, evac01_cs, evac11_cs,
		evcntadr0_cs, evcntadr1_cs, evcntld0_cs, evcntld1_cs,
		evmxkp0_cs, evmxkp1_cs, evmnkp0_cs, evmnkp1_cs,  evnumomk, evovfmk, evtomk,
		icewr, icedi, e2e_ro, brktmot0, brktmot1,
		brktmovc0, brktmovn0, brktmovc1, brktmovn1
		) ;

	input	baseck, clk120m, sysrsoutb, svmod, timon0, timon1, timoff0, timoff1,
		evtcl0_cs, evtcl1_cs, evcnt0_cs, evcnt1_cs, evnum0_cs, evnum1_cs,
		evtmsp0_cs, evtmsp1_cs, tevclr_cs, evtmc_cs, evrmc_cs, evtmout_cs,
		cntovf_cs, evnumovf_cs, evac00_cs, evac10_cs, evac01_cs, evac11_cs,
		evcntadr0_cs, evcntadr1_cs, evcntld0_cs, evcntld1_cs,
		evmxkp0_cs, evmxkp1_cs, evmnkp0_cs, evmnkp1_cs, icewr ;
	input [1:0]	evnumomk, evovfmk, evtomk ;
	input [31:0]	icedi ;
	output [31:0]	e2e_ro ;
	output		brktmot0, brktmot1,
			brktmovc0, brktmovn0, brktmovc1, brktmovn1 ;

	wire [31:0]	evtimer0_ro, evtimer1_ro, evtimer_ro ;
	wire [1:0]	evtmout_ro, evcntovf_ro, evnumovf_ro ;
	wire		evtmout0, evtmout1, evcntovf0, evcntovf1, evnumovf0, evnumovf1;


	assign	e2e_ro[31] = evtimer_ro[31] ;
	assign	e2e_ro[30] = evtimer_ro[30] ;
	assign	e2e_ro[29] = evtimer_ro[29] ;
	assign	e2e_ro[28] = evtimer_ro[28] ;
	assign	e2e_ro[27] = evtimer_ro[27] ;
	assign	e2e_ro[26] = evtimer_ro[26] ;
	assign	e2e_ro[25] = evtimer_ro[25] ;
	assign	e2e_ro[24] = evtimer_ro[24] ;
	assign	e2e_ro[23] = evtimer_ro[23] ;
	assign	e2e_ro[22] = evtimer_ro[22] ;
	assign	e2e_ro[21] = evtimer_ro[21] ;
	assign	e2e_ro[20] = evtimer_ro[20] ;
	assign	e2e_ro[19] = evtimer_ro[19] ;
	assign	e2e_ro[18] = evtimer_ro[18] ;
	assign	e2e_ro[17] = evtimer_ro[17] ;
	assign	e2e_ro[16] = evtimer_ro[16] ;
	assign	e2e_ro[15] = evtimer_ro[15] ;
	assign	e2e_ro[14] = evtimer_ro[14] ;
	assign	e2e_ro[13] = evtimer_ro[13] ;
	assign	e2e_ro[12] = evtimer_ro[12] ;
	assign	e2e_ro[11] = evtimer_ro[11] ;
	assign	e2e_ro[10] = evtimer_ro[10] ;
	assign	e2e_ro[9] = evtimer_ro[9] ;
	assign	e2e_ro[8] = evtimer_ro[8] ;
	assign	e2e_ro[7] = evtimer_ro[7] ;
	assign	e2e_ro[6] = evtimer_ro[6] ;
	assign	e2e_ro[5] = evtimer_ro[5] ;
	assign	e2e_ro[4] = evtimer_ro[4] ;
	assign	e2e_ro[3] = evtimer_ro[3] ;
	assign	e2e_ro[2] = evtimer_ro[2] ;
	assign	e2e_ro[1] = evtimer_ro[1] | evtmout_ro[1] | evnumovf_ro[1] | evcntovf_ro[1] ;
	assign	e2e_ro[0] = evtimer_ro[0] | evtmout_ro[0] | evnumovf_ro[0] | evcntovf_ro[0] ;

// ---------------------------------------------------------------------
// TEVCLR ( Timer Event Clear Register (for all unit) ) [ver1.0.0]
// (2nd quarter of word data at same address as EVTMC, RBTMC and so on.)
// ---------------------------------------------------------------------
	wire tevclr_host_set;
	IIRL78TIMERV1_HOST_SET_SYNC tevclr_set (
		.sysrsoutb(sysrsoutb), .host_clk(icewr), .host_cs(tevclr_cs), .sync_clk(clk120m), .host_cs_sync(tevclr_host_set)
	);

	reg tevclr0_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)	
			tevclr0_host_data <= 1'b0;
		else if (tevclr_cs)
			tevclr0_host_data <= icedi[8];
		else	tevclr0_host_data <= 1'b0;
	end

	reg tevclr1_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			tevclr1_host_data <= 1'b0;
		else if (tevclr_cs)
			tevclr1_host_data <= icedi[9];
		else	tevclr1_host_data <= 1'b0;
	end

// ----------------------------------------------------------------------
// EVTMC ( Event Timer Counter Clear Register (for all unit) ) [ver1.0.0]
// (3rd quarter of word data at same address as EVRMC)
// ----------------------------------------------------------------------
	wire evtmc_host_set = tevclr_host_set;

	reg evcntclr0_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evcntclr0_host_data <= 1'b0;
		else if (evtmc_cs)
			evcntclr0_host_data <= icedi[16];
		else	evcntclr0_host_data <= 1'b0;
	end

	reg evcntclr1_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evcntclr1_host_data <= 1'b0;
		else if (evtmc_cs)
			evcntclr1_host_data <= icedi[17];
		else	evcntclr1_host_data <= 1'b0;
	end

// --------------------------------------------------------------------------------------
// EVRMC ( Event Timer Register (EVNUM/EVAC/EVXKP/EVMNKP) Clear Register (for all unit) )
// (4th quarter of word data at same address as EVTMC)
// --------------------------------------------------------------------------------------
	wire evrmc_host_set = tevclr_host_set;

	reg evregclr0_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evregclr0_host_data <= 1'b0;
		else if (evtmc_cs)
			evregclr0_host_data <= icedi[24];
		else	evregclr0_host_data <= 1'b0;
	end

	reg evregclr1_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evregclr1_host_data <= 1'b0;
		else if (evtmc_cs)
			evregclr1_host_data <= icedi[25];
		else	evregclr1_host_data <= 1'b0;
	end

// -------------------------------------------------------------
// EVTMOUT ( Event Timer Timeout Detect Register ) [ver1.0.0]
// (ここではRegisterのClear機能のみを実現。検出値は検出信号自体を使う。)
// -------------------------------------------------------------
	wire evtmout_host_set;
	IIRL78TIMERV1_HOST_SET_SYNC evtmout_set (
		.sysrsoutb(sysrsoutb), .host_clk(icewr), .host_cs(evtmout_cs), .sync_clk(clk120m), .host_cs_sync(evtmout_host_set)
	);

	reg evtmout0_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evtmout0_host_data <= 1'b0;
		else if (evtmout_cs)
			evtmout0_host_data <= icedi[0];
		else	evtmout0_host_data <= 1'b0;
	end

	reg evtmout1_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evtmout1_host_data <= 1'b0;
		else if (evtmout_cs)
			evtmout1_host_data <= icedi[1];
		else	evtmout1_host_data <= 1'b0;
	end

// ----------------------------------------------------------------------------------
// CNTOVF [EVCNTOVF bit] ( Event Timer Counter Over-Flow Detect Register ) [ver1.0.0]
// (ここではRegisterのClear機能のみを実現。検出値は検出信号自体を使う。)
// ----------------------------------------------------------------------------------
	wire evcntovf_host_set;
	IIRL78TIMERV1_HOST_SET_SYNC evcntovf_set (
		.sysrsoutb(sysrsoutb), .host_clk(icewr), .host_cs(cntovf_cs), .sync_clk(clk120m), .host_cs_sync(evcntovf_host_set)
	);

	reg evcntovf0_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evcntovf0_host_data <= 1'b0;
		else if (cntovf_cs)
			evcntovf0_host_data <= icedi[0];
		else	evcntovf0_host_data <= 1'b0;
	end

	reg evcntovf1_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evcntovf1_host_data <= 1'b0;
		else if (cntovf_cs)
			evcntovf1_host_data <= icedi[1];
		else	evcntovf1_host_data <= 1'b0;
	end

// -----------------------------------------------------------------------------------------
// EVNUMOVF ( Event Timer Measurements Number Counter Over-Flow Detect Register ) [ver1.0.0]
// (ここではRegisterのClear機能のみを実現。検出値は検出信号自体を使う。)
// -----------------------------------------------------------------------------------------
	wire evnumovf_host_set;
	IIRL78TIMERV1_HOST_SET_SYNC evnumovt_set (
		.sysrsoutb(sysrsoutb), .host_clk(icewr), .host_cs(evnumovf_cs), .sync_clk(clk120m), .host_cs_sync(evnumovf_host_set)
	);

	reg evnumovf0_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evnumovf0_host_data <= 1'b0;
		else if (evnumovf_cs)
			evnumovf0_host_data <= icedi[0];
		else	evnumovf0_host_data <= 1'b0;
	end

	reg evnumovf1_host_data;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evnumovf1_host_data <= 1'b0;
		else if (evnumovf_cs)
			evnumovf1_host_data <= icedi[1];
		else	evnumovf1_host_data <= 1'b0;
	end

	wire tevclr0 = (tevclr0_host_data & tevclr_host_set) | ~sysrsoutb ;	// e2e０ON状態clear
	wire tevclr1 = (tevclr1_host_data & tevclr_host_set) | ~sysrsoutb ;	// e2e１ON状態clear
	wire evcntclr0 = (evcntclr0_host_data & evtmc_host_set) | ~sysrsoutb ; // e2eカウンタ０clear
	wire evcntclr1 = (evcntclr1_host_data & evtmc_host_set) | ~sysrsoutb ; // e2eカウンタ１clear
	wire evregclr0 = (evregclr0_host_data & evrmc_host_set) | ~sysrsoutb ; // 回数カウンタclear
	wire evregclr1 = (evregclr1_host_data & evrmc_host_set) | ~sysrsoutb ; // 回数カウンタclear
	wire evtmout_wr0 = (evtmout0_host_data & evtmout_host_set) | ~sysrsoutb ; // time-out(0) clear
	wire evtmout_wr1 = (evtmout1_host_data & evtmout_host_set) | ~sysrsoutb ; // time-out(1) clear
	wire evcntovf_wr0 = (evcntovf0_host_data & evcntovf_host_set) | ~sysrsoutb ; // カウンタovf-flg0 clear
	wire evcntovf_wr1 = (evcntovf1_host_data & evcntovf_host_set) | ~sysrsoutb ; // カウンタovf-flg1 clear
	wire evnumovf_wr0 = (evnumovf0_host_data & evnumovf_host_set) | ~sysrsoutb ; // 回数カウンタ0 clear
	wire evnumovf_wr1 = (evnumovf1_host_data & evnumovf_host_set) | ~sysrsoutb ; // 回数カウンタ1 clear


	IIRL78TIMERV1_EVENT_TIMER event_timer0 (
			.baseck(baseck), .clk120m(clk120m), .sysrsoutb(sysrsoutb), .svmod(svmod),
			.timon(timon0), .timoff(timoff0), .evtcl_cs(evtcl0_cs),
			.evcnt_cs(evcnt0_cs), .evnum_cs(evnum0_cs), .evtmsp_cs(evtmsp0_cs),
			.evcntadr_cs(evcntadr0_cs), .evcntld_cs(evcntld0_cs),
			.tevclr(tevclr0), .evcntclr(evcntclr0), .evregclr(evregclr0),
			.evtmout_wr(evtmout_wr0),  .evcntovf_wr(evcntovf_wr0),
			.evnumovf_wr(evnumovf_wr0), .evac0_cs(evac00_cs), .evac1_cs(evac10_cs),
			.evmxkp_cs(evmxkp0_cs), .evmnkp_cs(evmnkp0_cs),
			.evnumomk(evnumomk[0]), .evovfmk(evovfmk[0]), .evtomk(evtomk[0]),
			.icewr(icewr), .icedi(icedi), .evtimer_ro(evtimer0_ro),
			.evtmout(evtmout0), .evcntovf(evcntovf0), .evnumovf(evnumovf0),
			.brktmot(brktmot0), .brktmovc(brktmovc0), .brktmovn(brktmovn0)
		) ;

	IIRL78TIMERV1_EVENT_TIMER event_timer1 (
			.baseck(baseck), .clk120m(clk120m), .sysrsoutb(sysrsoutb), .svmod(svmod),
			.timon(timon1), .timoff(timoff1), .evtcl_cs(evtcl1_cs),
			.evcnt_cs(evcnt1_cs), .evnum_cs(evnum1_cs), .evtmsp_cs(evtmsp1_cs),
			.evcntadr_cs(evcntadr1_cs), .evcntld_cs(evcntld1_cs),
			.tevclr(tevclr1), .evcntclr(evcntclr1), .evregclr(evregclr1), 
			.evtmout_wr(evtmout_wr1), .evcntovf_wr(evcntovf_wr1),
			.evnumovf_wr(evnumovf_wr1), .evac0_cs(evac01_cs), .evac1_cs(evac11_cs),
			.evmxkp_cs(evmxkp1_cs), .evmnkp_cs(evmnkp1_cs),
			.evnumomk(evnumomk[1]), .evovfmk(evovfmk[1]), .evtomk(evtomk[1]),
			.icewr(icewr), .icedi(icedi), .evtimer_ro(evtimer1_ro),
			.evtmout(evtmout1), .evcntovf(evcntovf1), .evnumovf(evnumovf1),
			.brktmot(brktmot1), .brktmovc(brktmovc1), .brktmovn(brktmovn1)
		) ;

	assign	evtimer_ro = evtimer0_ro | evtimer1_ro ;
	assign	evtmout_ro = evtmout_cs ? { evtmout1, evtmout0 } : 2'b00 ;
	assign	evcntovf_ro = cntovf_cs ? { evcntovf1, evcntovf0 } : 2'b00 ;
	assign	evnumovf_ro = evnumovf_cs ? { evnumovf1, evnumovf0 } : 2'b00 ;

endmodule

// ===================================================================================================
//	event-to-event timer (単体)
// ===================================================================================================
module	IIRL78TIMERV1_EVENT_TIMER (
			baseck, clk120m, sysrsoutb, svmod, timon, timoff,
			evtcl_cs, evcnt_cs, evnum_cs, evtmsp_cs, evcntadr_cs, evcntld_cs,
 			tevclr, evcntclr, evregclr, 
			evtmout_wr, evcntovf_wr, evnumovf_wr,
			evac0_cs, evac1_cs, evmxkp_cs, evmnkp_cs, evnumomk, evovfmk,
			evtomk,	icewr, icedi, evtimer_ro, evtmout, evcntovf, evnumovf, brktmot,
			brktmovc, brktmovn
		) ;

	input		baseck, clk120m, sysrsoutb, svmod, timon, timoff,
			evtcl_cs, evcnt_cs, evnum_cs, evtmsp_cs, evcntadr_cs, evcntld_cs,
			tevclr, evcntclr, evregclr,
			evtmout_wr, evcntovf_wr, evnumovf_wr,
			evac0_cs, evac1_cs, evmxkp_cs, evmnkp_cs, evnumomk, evovfmk,
			evtomk, icewr ;
	input [31:0]	icedi ;
	output [31:0]	evtimer_ro ;
	output		evtmout, evcntovf, evnumovf, brktmot, brktmovc, brktmovn ;

	wire [31:0]	sum_ro, evcnt_ro, evtmsp_ro, evnum_ro, evac1_ro, evac0_ro,
			evmxkp_ro, evmnkp_ro, evcntadr_ro ;
	wire [7:0]	evtcl_ro ;
	wire		evtmout1, evnum_fl,
			timon_i, timoff_i ;
	assign	sum_ro = evcnt_ro | evtmsp_ro | evnum_ro | evac1_ro | evac0_ro |
			 evmxkp_ro | evmnkp_ro | evcntadr_ro ;

	assign	evtimer_ro[31] = sum_ro[31];
	assign	evtimer_ro[30] = sum_ro[30];
	assign	evtimer_ro[29] = sum_ro[29];
	assign	evtimer_ro[28] = sum_ro[28];
	assign	evtimer_ro[27] = sum_ro[27];
	assign	evtimer_ro[26] = sum_ro[26];
	assign	evtimer_ro[25] = sum_ro[25];
	assign	evtimer_ro[24] = sum_ro[24];
	assign	evtimer_ro[23] = sum_ro[23];
	assign	evtimer_ro[22] = sum_ro[22];
	assign	evtimer_ro[21] = sum_ro[21];
	assign	evtimer_ro[20] = sum_ro[20];
	assign	evtimer_ro[19] = sum_ro[19];
	assign	evtimer_ro[18] = sum_ro[18];
	assign	evtimer_ro[17] = sum_ro[17];
	assign	evtimer_ro[16] = sum_ro[16];
	assign	evtimer_ro[15] = sum_ro[15];
	assign	evtimer_ro[14] = sum_ro[14];
	assign	evtimer_ro[13] = sum_ro[13];
	assign	evtimer_ro[12] = sum_ro[12];
	assign	evtimer_ro[11] = sum_ro[11];
	assign	evtimer_ro[10] = sum_ro[10];
	assign	evtimer_ro[9] = sum_ro[9];
	assign	evtimer_ro[8] = sum_ro[8];
	assign	evtimer_ro[7] = sum_ro[7] | evtcl_ro[7];
	assign	evtimer_ro[6] = sum_ro[6] | evtcl_ro[6];
	assign	evtimer_ro[5] = sum_ro[5] | evtcl_ro[5];
	assign	evtimer_ro[4] = sum_ro[4] | evtcl_ro[4];
	assign	evtimer_ro[3] = sum_ro[3] | evtcl_ro[3];
	assign	evtimer_ro[2] = sum_ro[2] | evtcl_ro[2];
	assign	evtimer_ro[1] = sum_ro[1] | evtcl_ro[1];
	assign	evtimer_ro[0] = sum_ro[0] | evtcl_ro[0];

// ----------------------------------------------------------------------------------------
// EVTCLn (Event-to-Event timer clock select register) [ver1.0.0] for countermeasure metas.
// ----------------------------------------------------------------------------------------
	wire evcntovf_host_set;
	IIRL78TIMERV1_HOST_SET_SYNC evcntovf_set (
		.sysrsoutb(sysrsoutb), .host_clk(icewr), .host_cs(evtcl_cs), .sync_clk(clk120m), .host_cs_sync(evtcl_host_set)
	);

	reg evcnte_p;
	reg [3:0] evtcl_p;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if ( !sysrsoutb ) begin
			evcnte_p <= 1'b0 ;
			evtcl_p  <= 4'b0 ;
		end
		else if ( evtcl_cs ) begin
			evcnte_p <= icedi[6] ;
			evtcl_p  <= icedi[3:0] ;
		end
	end

	reg evcnte;
	reg [3:0] evtcl;
	always @(posedge clk120m or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			evcnte <= 1'b0;
			evtcl <= 3'b000;
		end else if (evtcl_host_set) begin
			evcnte <= evcnte_p;
			evtcl <= evtcl_p;
		end
	end

	assign	evtcl_ro = evtcl_cs ? {1'b0, evcnte, 2'b0, evtcl} : 8'b0 ;

	/* --------------------------------------------------------------------	*/
	/* [ver1.0.0]								*/
	/* ・svmod_iはcounterのdisable用。eventのsvmod制御はevent blockで行う	*/
	/* ・timon_i,timoff_iに合わせてで5回latchする				*/
	/* --------------------------------------------------------------------	*/
	reg [3:0] svmod_meta;
	always @( posedge clk120m or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			svmod_meta <= 4'h0 ;
		else	svmod_meta <= {svmod_meta[2:0], svmod} ;
	end

	reg svmod_i;
	always @( posedge clk120m or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			svmod_i <= 1'b0;
		else	svmod_i <= svmod_meta[3];
	end

// -----------------------------------------------------------------------------------
// Event Interface [ver1.0.0] 60m->120mに伴い、metas対策も安定時間を考慮し1clk->4clkにする。
// -----------------------------------------------------------------------------------
	/* ------------------------------------------------------------------------------------	*/
	/* (clk60mhz*1)               _|~~~~~~~|_______|~~~~~~~|_______				*/
	/* clk120m	_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~	*/
	/* baseck	__|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~	*/
	/* svmod	__________________________________________________|~~~~~~~~~~~~~~~~	*/
	/* timon        ~~|_______________________|~~~~~~~~~~~|____________________________	*/
	/* timoff       ______________|~~~~~~~~~~~|___________|~~~~~~~~~~~|________________	*/
	/* even_bck     __|~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~~~~~|________________	*/
	/* peven[0]     _____|~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~~~~~|_____________	*/
	/* peven[1]     _________|~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~~~~~|_________	*/
	/* peven[2]     _____________|~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~~~~~|_________	*/
	/* peven[3]     _________________|~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~~~~~|_____	*/
	/* even         _____________________|~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~~~~~|_	*/
	/* timon_i      _________________|~~~|_______________________________|~~~|_____________	*/
	/* timoff_i     _________________________________________|~~~|___________________|~~~|_	*/
	/* evcnt	=====================x=1=x=2=x=3=x=4=x=5=x=6=============x=1=x=2=x=3===	*/
	/* evnum	=============================================x=======================x=	*/
	/* svmod_meta[0] ____________________________________________________|~~~~~~~~~~~~~	*/
	/* svmod_meta[1] ________________________________________________________|~~~~~~~~~~~~	*/
	/* svmod_meta[2] ____________________________________________________________|~~~~~~~~~	*/
	/* svmod_meta[3] ________________________________________________________________|~~~~~	*/
	/* svmod_i	_____________________________________________________________________|~	*/
	/* ------------------------------------------------------------------------------------	*/
	/* *1) clk60mhzのとき(ver1)とのTP共用を考慮し、metas対策は4clock行う。			*/
	/*                                                                                      */
	/*(clk120m↑とeven_bckが競合した場合)							*/
	/* ------------------------------------------------------------------------------------	*/
	/* ck120m	_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~	*/
	/* baseck	_|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~	*/
	/* svmod	_________________________________________________|~~~~~~~~~~~~~~~~~	*/
	/* timon        ~|_______________________|~~~~~~~~~~~|_____________________________	*/
	/* timoff       _____________|~~~~~~~~~~~|___________|~~~~~~~~~~~|_________________	*/
	/* even_bck     _|~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~~~~~|_________________	*/
	/* peven[0]     _|xxx|~~~~~~~~~~~~~~~~~~~|xxx|_______|xxx|~~~~~~~|xxx|_____________	*/
	/* peven[1]     _____|xx1|~~~~~~~~~~~~~~~~~~~|xx1|_______|xx0|~~~~~~~|xx0|_____________	*/
	/* peven[2]     _________|~~~~~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~|_____________	*/
	/* peven[3]     _____________|~~~~~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~|_________	*/
	/* even         _________________|~~~~~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~|_____	*/
	/* timon_i      _____________|~~~|___________________________________|~~~|_____________	*/
	/* timoff_i     _________________________________________|~~~|_______________|~~~|_____	*/
	/* evcnt*1*	=================x=1=x=2=x=3=x=4=x=5=x=6=x=7=============x=1=x=2=======	*/
	/* evnum	=============================================x===================x=====	*/
	/* svmod_meta[0] ________________________________________________|xxxxxxx|~~~~~~~~~~~~~	*/
	/* svmod_meta[1] ____________________________________________________|xx1|~~~~~~~~~~~~~	*/
	/* svmod_meta[2] ________________________________________________________|~~~~~~~~~~~~~	*/
	/* svmod_meta[3] ____________________________________________________________|~~~~~~~~~	*/
	/* svmod_i	_________________________________________________________________|~~~~~	*/
	/*                                                                                      */
	/* (svmodとの競合case2)                                                                 	*/
	/* peven[1]     _____|xx1|~~~~~~~~~~~~~~~~~~~|xx1|_______|xx0|~~~~~~~|xx1|_____________	*/
	/* peven[2]     _________|~~~~~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~~~~~|_________	*/
	/* peven[3]     _____________|~~~~~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~~~~~|_____	*/
	/* even         _________________|~~~~~~~~~~~~~~~~~~~~~~~~~~~|___________|~~~~~~~~~~~|_	*/
	/* timon_i      _____________|~~~|___________________________________|~~~|_____________	*/
	/* timoff_i     _________________________________________|~~~|___________________|~~~|_	*/
	/* svmod_i	_________________________________________________________________|~~~~~	*/
	/*                                                                                   ↑	*/
	/* eventとsvmodは別々にsamplingしているため,SamplingClock 1clock分のずれが生じる可能性がある。	*/
	/* eventのsvmodによるmaskは本macroでは行っておらずeventで行っている。svmod_iはcounterの	*/
	/* disable用なので、eventとsvmodのsamplingのずれによりeventが認識されなくなることはなく、Count	*/
	/* 値が1clockずれるだけで、これはsampling誤差なので問題なし。					*/
	/* ------------------------------------------------------------------------------------	*/

	// EVCNTEn==0の時はtimerイベントを受け付けない,svmodはイベントブロックで押える

	reg even_bck;
	always @( posedge baseck or posedge tevclr ) begin
		if ( tevclr )
			even_bck <= 1'b0 ;
		else if ( evcnte ) begin
			if ( timoff )			// offイベントを優先する
				even_bck <= 1'b0 ;
			else if ( timon )
				even_bck <= 1'b1 ;
		end
	end

	// [ver1.0.0]
	reg [3:0] peven;
	always @( posedge clk120m or posedge tevclr ) begin
		if (tevclr)
			peven <= 4'h0 ;
		else	peven <= {peven[2:0], even_bck} ;
	end

	// [ver1.0.0]
	reg even;
	always @( posedge clk120m or posedge tevclr ) begin
		if (tevclr)
			even <= 1'b0 ;
		else	even <= peven[3] ;
	end

	assign	timon_i = peven[3] & ~even ;	// [ver1.0.0]
	assign	timoff_i = ~peven[3] & even ;	// [ver1.0.0]

// -------------------------------------------------------------------------------
// EVCNTADRn (Event-to-Event timer counter write data setting register) [ver1.0.0]
// -------------------------------------------------------------------------------
	reg [31:0] evcntadr;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if ( !sysrsoutb )
			evcntadr <= 32'b0 ;
		else if ( evcntadr_cs )
			evcntadr <= icedi ;
	end
	assign	evcntadr_ro = evcntadr_cs ? evcntadr : 32'b0 ;

	// ---------------------------------------------------
	// [ver1.0.0]
	// evcntadr43[42:0] -> evnctadr_loaddata[43:0]
	// ver1と互換性を保つためにfx,fx/2の選択値を後ろにもってくる。
	// ---------------------------------------------------
	reg [43:0] evcntadr_loaddata ;
	always @( evtcl or evcntadr ) begin
		case ( evtcl )
			4'hc	: evcntadr_loaddata = {12'b0, evcntadr       };	// fx
			4'h0	: evcntadr_loaddata = {11'b0, evcntadr,  1'b0};	// fx/2 (ver1のfx)
			4'h1	: evcntadr_loaddata = {10'b0, evcntadr,  2'b0};	// fx/4
			4'h2	: evcntadr_loaddata = { 9'b0, evcntadr,  3'b0};	// fx/8
			4'h3	: evcntadr_loaddata = { 8'b0, evcntadr,  4'b0};	// fx/16
			4'h4	: evcntadr_loaddata = { 7'b0, evcntadr,  5'b0};	// fx/32
			4'h5	: evcntadr_loaddata = { 6'b0, evcntadr,  6'b0};	// fx/64
			4'h6	: evcntadr_loaddata = { 5'b0, evcntadr,  7'b0};	// fx/128
			4'h7	: evcntadr_loaddata = { 4'b0, evcntadr,  8'b0};	// fx/256
			4'h8	: evcntadr_loaddata = { 3'b0, evcntadr,  9'b0};	// fx/512
			4'h9	: evcntadr_loaddata = { 2'b0, evcntadr, 10'b0};	// fx/1024
			4'ha	: evcntadr_loaddata = { 1'b0, evcntadr, 11'b0};	// fx/2048
			4'hb	: evcntadr_loaddata = {       evcntadr, 12'b0};	// fx/4096
			default	: evcntadr_loaddata = {11'b0, evcntadr,  1'b0};	// fx/2
		endcase
	end

// -----------------------------------------------------
// EVCNTLDn (Event-to-Event timer load status [ver1.0.0]
// -----------------------------------------------------
	wire evcntload;
	IIRL78TIMERV1_HOST_SET_SYNC evcntload_set (
		.sysrsoutb(sysrsoutb), .host_clk(icewr), .host_cs(evcntld_cs), .sync_clk(clk120m), .host_cs_sync(evcntload)
	);

// -------------------------------------------------
// EVCNTn (Event timer counter ( 44bit )) [ver1.0.0]
// -------------------------------------------------
	// ・over-flow信号/timoff_iにてcount終了時は前のcount値を保持する
	// _|~|_|~|_|~|_|~|_|~|_  clk120m
	// ___|~~~|_____________  timon_i
	// _______________|~~~|_  timoff_i
	// _______|~~~~~~~~~~~|_  even
	// =======x=1=x=2=x=3===  allcnt
	// ・even中に発生したtimon_iは無視(timon_iにてclear1される為)
	// ・timon_iはsvmod_iより遅れる可能性があり(60m選択で競合した場合)svmod_iでmaskされると
	//   timon_iによるclear1が無効になる。timoff_iも同様に、evnum加算などの演算が無効になる
	//   ->timon_i,timoff_iは~svmod中に発生するのでsvmod_iで抑えない

	// [ver1.0.0] add 1bit.
	// [ver1.0.0] delete evcnt_fl use to count enable.
	reg [43:0] allcnt ;
	always @(posedge clk120m or posedge evcntclr) begin
		if (evcntclr)
			allcnt <= 0 ;			 // 初期値0h
		else if (evcntload)  			 // /*~even & ~evcnte &*/ delete
			allcnt <= evcntadr_loaddata ;
		else if (~even & timon_i)
			allcnt <= 1 ;			 // count開始で初期値1h
		else if (evcnte & ~svmod_i & even & ~timoff_i) 
			allcnt <= allcnt + 1 ;		 // even中はevcnte=1とは限らないので
	end

	// -----------------------------------------------------------------------------------
	// [ver1.0.0] Add 2bit to allcnt, and add two choices for evtcl.
	// [ver1.0.0] Cut the timing path by edge latch, because of tough timing on CLK120M.
	// [ver1.0.0] If counter was full, keep count value. ignore allcnt behavior.
	// [ver1.0.0] Clear the counter by evcntclr same as allcnt.
	//
	// evtcl/allcnt -> evcnt -> evcnt_fl -> allcntのパスがCriticalに見えた。
	// evtcl/allcnt -> evcnt -> evmxkp         などのパスがCriticalに見えた。
	//  対策*1として、evcntは上で切り直すようにした。これによりevcnt_flのタイミングが1clock
	//  ずれてしまう。従来とおりのevcnt_flでallcntを止めてもover-flowしたあとになるので、
	//  allcntのカウント条件からは除外する。代りにevcnt自体をevcnt_flで保持するようにした。
	//  切り直したことにより、load後にCounter停止状態でCounterを読み出してもloadする前の値が読める。
	// -----------------------------------------------------------------------------------
	reg [31:0] evcnt;
	wire evcnt_fl = (evcnt == 32'hffff_ffff);
	always @(posedge clk120m or posedge evcntclr) begin
		if (evcntclr) begin
			evcnt <= 32'h0000_0000;
		end else if (evcnt_fl) begin
			evcnt <= evcnt;
		end else begin
			case (evtcl)
				4'hc	: evcnt <= allcnt[31:0];	// fx
				4'h0	: evcnt <= allcnt[32:1];	// fx/2 (ver1のfx)
				4'h1	: evcnt <= allcnt[33:2];	// fx/4
				4'h2	: evcnt <= allcnt[34:3];	// fx/8
				4'h3	: evcnt <= allcnt[35:4];	// fx/16
				4'h4	: evcnt <= allcnt[36:5];	// fx/32
				4'h5	: evcnt <= allcnt[37:6];	// fx/64
				4'h6	: evcnt <= allcnt[38:7];	// fx/128
				4'h7	: evcnt <= allcnt[39:8];	// fx/256
				4'h8	: evcnt <= allcnt[40:9];	// fx/512
				4'h9	: evcnt <= allcnt[41:10];	// fx/1024
				4'ha	: evcnt <= allcnt[42:11];	// fx/2048
				4'hb	: evcnt <= allcnt[43:12];	// fx/4096
				default	: evcnt <= allcnt[32:1];	// fx/2
			endcase
		end
	end

	// hostからのreadはevcnteを"0"にしてから行うこと
	assign	evcnt_ro = evcnt_cs ? evcnt : 32'b0 ;

	// _________|~~~|_____________	timoff_i
	// ~|_|~|_|~|_|~|_|~|_|~|_|~|_	clk120m
	// =x===x=====all-f=====x=1=x=	evcnt
	// _____|~~~~~~~~~~~~~~~|_____	evcnt_fl
	// _________|~~~~~~~~~~~~~~|__	evcntovf
	//                         ↑evcntovf_wrによりclear
	// _________|~~~|_____________	brktmovc

	// [ver1.0.0] clk60m -> clk120m only
	// ・over-flowマスク設定であっても検出は行う
	reg evcntovf;
	always @( posedge clk120m or posedge evcntovf_wr ) begin
		if ( evcntovf_wr )
			evcntovf <= 1'b0 ;
		// counterはsvmod_iで制御
		else if ( evcnte & ~svmod_i & even & ~timoff_i & evcnt_fl ) 
			evcntovf <= 1'b1 ;
	end

	wire brktmovc;
	reg brktmovc120m;
	wire brktmovc_res = ~sysrsoutb | brktmovc;

	always @( posedge clk120m or posedge brktmovc_res ) begin
		if ( brktmovc_res )
			brktmovc120m <= 1'b0 ;
		else if ( evcnte & ~svmod_i & even & ~timoff_i & evcnt_fl & ~evcntovf & ~evovfmk )
			brktmovc120m <= 1'b1 ;
	end

	IIRL78TIMERV1_BREAK_BASECK_SYNC brktmovc_sync (
		.baseck(baseck), .sysrsoutb(sysrsoutb), .break_async(brktmovc120m), .break(brktmovc)
	);

// ---------------------------------------
// EVTMSP ( Time-Out register ) [ver1.0.0]
// ---------------------------------------
	// 変更時はtimer停止にしておくこと
	reg [31:0]  evtmsp;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if ( !sysrsoutb )
			evtmsp <= 32'b0 ;
		else if ( evtmsp_cs )
			evtmsp <= icedi[31:0] ;
	end
	assign	evtmsp_ro = evtmsp_cs ? evtmsp : 32'b0 ;
	assign	evtmout1 = ( evcnt == evtmsp ) ? 1'b1 : 1'b0 ;

	// ・time-out mask設定であっても検出は行う
	// ・time-out設定時間として0を許す為にtimon_iを条件に追加
	//   (timer-start eventでbreakのような条件を許す為)
	// ・evtmspの初期値は0だが、測定counterの動作中以外はevtmoutはsetされない
	// ~|_|~|_|~|_|~|_|~	ck120m
	// _____|~~~|_______	timon_i
	// _________|~~~~~~~	even
	// ====0====x=1=x=2=	evcnt
	// ====0============	evtmsp
	// ~~~~~~~~~|_______	evtmout1
	// _________|~~~~~~~	evtmout
	// _________|~~~|___	brktmot
	//
	// ・timon_iはsvmod_iより遅れる可能性があり(120m選択で競合した場合)
	//   ->timon_iは~svmod中に発生するのでsvmod_iで抑えない

	reg evtmout;
	always @( posedge clk120m or posedge evtmout_wr ) begin
		if ( evtmout_wr )
			evtmout <= 1'b0 ;
		else if (~even & timon_i & ~timoff_i & evtmout1)
			evtmout <= 1'b1 ;
		// counterもsvmod_iで制御
		else if (evcnte & ~svmod_i & even & ~timoff_i & evtmout1) 
			evtmout <= 1'b1 ;
	end

	wire brktmot;
	reg brktmot120m;
	wire brktmot_res = ~sysrsoutb | brktmot;

	always @( posedge clk120m or posedge brktmot_res ) begin
		if ( brktmot_res )
			brktmot120m <= 1'b0 ;
		else if (~even & timon_i & ~timoff_i & evtmout1 & ~evtmout & ~evtomk)
			brktmot120m <= 1'b1 ;
		else if (evcnte & ~svmod_i & even & ~timoff_i & evtmout1 & ~evtmout & ~evtomk) 
			brktmot120m <= 1'b1 ;
	end

	IIRL78TIMERV1_BREAK_BASECK_SYNC brktmot_sync (
		.baseck(baseck), .sysrsoutb(sysrsoutb), .break_async(brktmot120m), .break(brktmot)
	);

// -----------------------------------------------------------
// EVNUM (measurement number counter ( 32bit+ovf )) [ver1.0.0]
// -----------------------------------------------------------
	wire evnumwr_host_set;
	IIRL78TIMERV1_HOST_SET_SYNC evnumwr_set (
		.sysrsoutb(sysrsoutb), .host_clk(icewr), .host_cs(evnum_cs), .sync_clk(clk120m), .host_cs_sync(evnumwr_host_set)
	);

	reg [31:0] evnumwr_host_data ;
	always @( negedge icewr or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			evnumwr_host_data <= 32'h0;
		else if (evnum_cs)
			evnumwr_host_data <= icedi;
		else	evnumwr_host_data <= 32'h0;
	end

	//all-fまでcountしたらcounterを止める
	reg [31:0] evnum;
	always @( posedge clk120m or posedge evregclr ) begin
		if ( evregclr )
			evnum <= 32'b0 ;
		else if ( evnumwr_host_set )
			evnum <= evnumwr_host_data ;
		else if ( even & timoff_i & ~evnum_fl )	// timoff_iはevcnte&!svmodで受付(svmod_iは関係なし)
			evnum <= evnum + 1 ;
	end

	assign	evnum_ro = evnum_cs ? evnum : 32'b0 ;
	assign	evnum_fl = ( evnum == 32'hffff_ffff ) ? 1'b1 : 1'b0 ;

	// over-flow mask設定であっても検出は行う
	// ~|_|~|_|~|_|~|_|~	clk120m
	// _____|~~~|_______	timoff_i
	// _________|~~~~~~~	even
	// ==ffff_ffff======	evnum
	// ~~~~~~~~~~~~~~~~~	evnum_fl
	// _________|~~~~~~~	evnumovf
	// _________|~~~|___	brktmovn

	reg evnumovf;
	always @( posedge clk120m or posedge evnumovf_wr ) begin
		if ( evnumovf_wr )
			evnumovf <= 1'b0 ;
		else if ( even & timoff_i & evnum_fl )
			evnumovf <= 1'b1 ;
	end

	wire brktmovn;
	reg brktmovn120m;
	wire brktmovn_res = ~sysrsoutb | brktmovn;

	always @( posedge clk120m or posedge brktmovn_res ) begin
		if ( brktmovn_res )
			brktmovn120m <= 1'b0 ;
		else if ( even & timoff_i & evnum_fl & ~evnumovf & ~evnumomk )
			brktmovn120m <= 1'b1 ;
	end

	IIRL78TIMERV1_BREAK_BASECK_SYNC brktmovn_sync (
		.baseck(baseck), .sysrsoutb(sysrsoutb), .break_async(brktmovn120m), .break(brktmovn)
	);

// --------------------------------------------------------------------------------------------
// EVAC1n/EVAC0n ( Event Timer Counter Accumulative Register ) [ver1.0.0] clk60m->clk120m Only.
// --------------------------------------------------------------------------------------------
	// evnumがover-flow時には加算しない

	reg [63:0] evac ;
	always @( posedge clk120m or posedge evregclr ) begin
		if ( evregclr ) begin
			evac <= 64'b0 ;
		end
		else if ( even & timoff_i & ~evnum_fl )	// timoff_iはevcnte&!svmodで受付
			evac <= evac + evcnt ;
	end

	assign	evac0_ro = evac0_cs ? evac[31:0] : 32'b0 ;
	assign	evac1_ro = evac1_cs ? evac[63:32] : 32'b0 ;

// -------------------------------------------------------------------
// EVMXKPn ( Muximum value register ) [ver1.0.0] clk60m->clk120m Only.
// -------------------------------------------------------------------
	// evnumがover-flow時は前の値を保持する

	reg [31:0] evmxkp;
	always @( posedge clk120m or posedge evregclr ) begin
		if ( evregclr )
			evmxkp <= 32'b0 ;
		else if ( even & timoff_i & (evcnt > evmxkp) & ~evnum_fl )
			evmxkp <= evcnt ;	// timoff_iはevcnte&!svmodで受付
	end
	assign	evmxkp_ro = evmxkp_cs ? evmxkp : 32'b0 ;

// -------------------------------------------------------------------
// EVMNKPn ( Minimum value register ) [ver1.0.0] clk60m->clk120m Only.
// -------------------------------------------------------------------
	// evnumがover-flow時は前の値を保持する

	reg [31:0] evmnkp;
	always @( posedge clk120m or posedge evregclr ) begin
		if ( evregclr )
			evmnkp <= 32'b0 ;
		else if ( even & timoff_i & (evnum==32'b0) )
			evmnkp <= evcnt ;
		else if ( even & timoff_i & (evcnt < evmnkp) & ~evnum_fl )
			evmnkp <= evcnt ;	// timoff_iはevcnte&!svmodで受付
	end
	assign	evmnkp_ro = evmnkp_cs ? evmnkp : 32'b0 ;

endmodule

// ===================================================================================================
//	create chip select
// ===================================================================================================
module IIRL78TIMERV1_TIMERCS (
		iceifa, rbcntl_cs, rbcnth_cs, rbtcl_cs, rbtmc_cs, tevclr_cs, evtmc_cs, evrmc_cs,
		evcnt0_cs, evcnt1_cs, evnum0_cs, evnum1_cs, evac00_cs, evac10_cs,
		evac01_cs, evac11_cs, evmxkp0_cs,evmxkp1_cs, evmnkp0_cs, evmnkp1_cs,
		evtcl0_cs, evtcl1_cs, evtmsp0_cs, evtmsp1_cs, evtomk_cs, evnumomk_cs,
		ovfmk_cs, evtmout_cs, cntovf_cs, evnumovf_cs,
		evcntadr0_cs, evcntadr1_cs, evcntld0_cs, evcntld1_cs,
		rbcntadrl_cs, rbcntadrh_cs, rbcntld_cs, rbcntll_cs, rbcntadrll_cs
		) ;

	input [31:0]	iceifa ;
	output		rbcntl_cs, rbcnth_cs, rbtcl_cs, rbtmc_cs, tevclr_cs, evtmc_cs, evrmc_cs,
			evcnt0_cs, evcnt1_cs, evnum0_cs, evnum1_cs,
			evac00_cs, evac10_cs, evac01_cs, evac11_cs, evmxkp0_cs,evmxkp1_cs,
			evmnkp0_cs, evmnkp1_cs, evtcl0_cs, evtcl1_cs,
			evtmsp0_cs, evtmsp1_cs, evtomk_cs, evnumomk_cs, ovfmk_cs, evtmout_cs,
			evcntadr0_cs, evcntadr1_cs, evcntld0_cs, evcntld1_cs,
			rbcntadrl_cs, rbcntadrh_cs, rbcntld_cs,
			cntovf_cs ,evnumovf_cs, rbcntll_cs, rbcntadrll_cs ;

	wire		timer_cs ;

	assign	timer_cs = (iceifa[31:8] == 24'h0840_20) ? 1'b1 : 1'b0 ;
	assign	rbcntl_cs = (timer_cs & (iceifa[7:1] == 7'b0000_000)) ? 1'b1 : 1'b0 ;	// run_break-counter(12-2bit)
	assign	rbcnth_cs = (timer_cs & (iceifa[7:2] == 6'b0000_01)) ? 1'b1 : 1'b0 ;	// run_break-counter(44-13bit)
	assign	rbtcl_cs = (timer_cs & (iceifa[7:0] == 8'b0000_1000)) ? 1'b1 : 1'b0 ;	// rb-count-enable
	assign	rbtmc_cs = (timer_cs & (iceifa[7:2] == 6'b0000_11)) ? 1'b1 : 1'b0 ;	// rb-counter clear
	assign	tevclr_cs = rbtmc_cs ;							// e2e-event clear
	assign	evtmc_cs = rbtmc_cs ;							// e2e-counter clear
	assign	evrmc_cs = rbtmc_cs ;							// e2e-registerclear
	assign	evcnt0_cs = (timer_cs & (iceifa[7:2] == 6'b0001_00)) ? 1'b1 : 1'b0 ;	// e2e-counter0
	assign	evcnt1_cs = (timer_cs & (iceifa[7:2] == 6'b0001_01)) ? 1'b1 : 1'b0 ;	// e2e-counter1
	assign	evnum0_cs = (timer_cs & (iceifa[7:2] == 6'b0001_10)) ? 1'b1 : 1'b0 ;	// 測定回数0
	assign	evnum1_cs = (timer_cs & (iceifa[7:2] == 6'b0001_11)) ? 1'b1 : 1'b0 ;	// 測定回数1
	assign	evac00_cs = (timer_cs & (iceifa[7:2] == 6'b0010_00)) ? 1'b1 : 1'b0 ;	// 累積keep0(下位)
	assign	evac10_cs = (timer_cs & (iceifa[7:2] == 6'b0010_01)) ? 1'b1 : 1'b0 ;	// 累積keep0(上位)
	assign	evac01_cs = (timer_cs & (iceifa[7:2] == 6'b0010_10)) ? 1'b1 : 1'b0 ;	// 累積keep1(下位)
	assign	evac11_cs = (timer_cs & (iceifa[7:2] == 6'b0010_11)) ? 1'b1 : 1'b0 ;	// 累積keep1(上位)
	assign	evmxkp0_cs = (timer_cs & (iceifa[7:2] == 6'b0011_00)) ? 1'b1 : 1'b0 ;	// 最大値keep0
	assign	evmxkp1_cs = (timer_cs & (iceifa[7:2] == 6'b0011_01)) ? 1'b1 : 1'b0 ;	// 最大値keep1
	assign	evmnkp0_cs = (timer_cs & (iceifa[7:2] == 6'b0011_10)) ? 1'b1 : 1'b0 ;	// 最小値keep0
	assign	evmnkp1_cs = (timer_cs & (iceifa[7:2] == 6'b0011_11)) ? 1'b1 : 1'b0 ;	// 最小値keep1
	assign	evtcl0_cs = (timer_cs & (iceifa[7:0] == 8'b0100_0000)) ? 1'b1 : 1'b0 ;	// e2e-clock0選択
	assign	evtcl1_cs = (timer_cs & (iceifa[7:0] == 8'b0100_0100)) ? 1'b1 : 1'b0 ;	// e2e-clock1選択
	assign	evtmsp0_cs = (timer_cs & (iceifa[7:2] == 6'b0100_10)) ? 1'b1 : 1'b0 ;	// time-out0 setting
	assign	evtmsp1_cs = (timer_cs & (iceifa[7:2] == 6'b0100_11)) ? 1'b1 : 1'b0 ;	// time-out1 setteig
	assign	evnumomk_cs = (timer_cs & (iceifa[7:2] == 6'b0101_00)) ? 1'b1 : 1'b0 ;	// 測定回数over-flow mask
	assign	ovfmk_cs = evnumomk_cs ;						// over-flow mask
	assign	evtomk_cs = evnumomk_cs ;						// time-out mask
	assign	evtmout_cs = (timer_cs & (iceifa[7:0] == 8'b0101_0100)) ? 1'b1 : 1'b0 ;	// time-out detect
	assign	cntovf_cs = (timer_cs & (iceifa[7:0] == 8'b0101_1000)) ? 1'b1 : 1'b0 ;	// over-flow detect
	assign	evnumovf_cs = (timer_cs & (iceifa[7:0] == 8'b0101_1100)) ? 1'b1 : 1'b0 ;// 測定回数over-flow
	assign	evcntadr0_cs = (timer_cs & (iceifa[7:2] == 6'b0110_00)) ? 1'b1 : 1'b0 ;	// e2e-counter0 data setting
	assign	evcntadr1_cs = (timer_cs & (iceifa[7:2] == 6'b0110_01)) ? 1'b1 : 1'b0 ;	// e2e-counter1 data setting
	assign	evcntld0_cs = (timer_cs & (iceifa[7:2] == 6'b0110_10)) ? 1'b1 : 1'b0 ;	// e2e-counter0 data load
	assign	evcntld1_cs = (timer_cs & (iceifa[7:2] == 6'b0110_11)) ? 1'b1 : 1'b0 ;	// e2e-counter1 data load
	assign	rbcntadrl_cs = (timer_cs & (iceifa[7:1] == 7'b0111_000)) ? 1'b1 : 1'b0 ;// run_break-counter data setting(12-2bit)
	assign	rbcntadrh_cs = (timer_cs & (iceifa[7:2] == 6'b0111_01)) ? 1'b1 : 1'b0 ;	// run_break-counter data setting(44-13bit)
	assign	rbcntld_cs = (timer_cs & (iceifa[7:2] == 6'b0111_10)) ? 1'b1 : 1'b0 ;	// run_break-counter data load
	assign	rbcntll_cs = (timer_cs & (iceifa[7:0] == 8'b1000_0000)) ? 1'b1 : 1'b0 ;	// run_break-counter(1-0bit)
	assign	rbcntadrll_cs = (timer_cs & (iceifa[7:0] == 8'b1000_0100)) ? 1'b1 : 1'b0;// run_break-counter data setting(1-0bit)

endmodule

module IIRL78TIMERV1_HOST_SET_SYNC (
	sysrsoutb, host_clk, host_cs, sync_clk, host_cs_sync
);
	input sysrsoutb, host_clk, host_cs, sync_clk;
	output host_cs_sync;

	// ---------------------------------------------------------------------
	// icewr             _|~~~|__________________
	// _host_start        ____|~~~~~~~~~~~|_____
	// [set data(host)]    ===x=DATADATADATA=========
	// sync_clk          _|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_
	// host_meta[0]        ___|xxx|xx1|~~~|xxx|xx0|___________
	// host_meta[1]         ______|xx0|~~~~~~~|xx1|___________
	//                                ↑      ↑ assume the signal be stable
	// host_meta[2]           ____________|~~~~~~~~~~~|_______
	// host_cs_sync_pre         ______________|~~~~~~~~~~~|___
	// host_cs_sync            _______________|~~~|_________
	// [set data(sync)]              =============x=DATADATADATA======
	// ---------------------------------------------------------------------

	reg [2:0] host_meta;
	wire host_res = ~sysrsoutb | host_meta[2];

	reg host_start;
	always @( negedge host_clk or posedge host_res ) begin
		if (host_res)
			host_start <= 1'b0;
		else if (host_cs)
			host_start <= 1'b1;
	end

	always @( posedge sync_clk or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			host_meta <= 3'b000;
		else	host_meta <= {host_meta[1:0], host_start};
	end

	reg host_cs_sync_pre;
	always @( posedge sync_clk or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			host_cs_sync_pre <= 1'b0 ;
		else	host_cs_sync_pre <= host_meta[2] ;
	end

	reg host_cs_sync;
	always @( posedge sync_clk or negedge sysrsoutb ) begin
		if (!sysrsoutb)
			host_cs_sync <= 1'b0;
		else if (host_meta[2] & ~host_cs_sync_pre)
			host_cs_sync <= 1'b1;
		else	host_cs_sync <= 1'b0;
	end

endmodule

module IIRL78TIMERV1_BREAK_BASECK_SYNC (
	baseck, sysrsoutb, break_async, break
);
	input baseck, sysrsoutb, break_async;
	output break;

	// [ break_asyncをbaseck 1clockに同期化 ]

	// [Macro Ver1のTiming]
	/* ----------------------------------------------------------------------- */
	/* ck60mhz           |~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_	           */
	/* baseck           |~~~~~|_____|~~~~~|_____|~~~~~|_____		   */
	/* break_async       ____|~~~~~~~|______________________		   */
	/* break             ___________|~~~~~~~~~~~|____________		   */
	/* 			  	 ↑break↑でbreak_asyncをClear.		   */
	/* -------------------------------------------------------------------     */
	// [ver1.0.0]								   */
	// さほどBreak Timingは気にしないので,安全に2段切り直す.1Clock Pulseで渡す.      */
	// break_metaを論理に使用するが,baseck↑のTimingではmetasは収まっている見積もり.  */
	/* ----------------------------------------------------------------------- */
	/* async_clk         |~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_  */
	/* [ case:metas=>high ]                                                    */
	/* break_async       ____|~~~~~~~~~~~|_______________________________      */
	/* baseck           _____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____  */
	/* break_bck         ____|xxxxxxxxxx1|~~~~~~~~~~~|_______________________  */
        /* break_meta          ________|xxxx1|~~~~~~~~~~~~~~~~~|_____________      */
        /* break_pre              ___________|~~~~~~~~~~~~~~~~~~~~~~~|___________  */
        /* break                   __________|~~~~~~~~~~~|____________________     */
        /*                                                                         */
	/* [ case:metas=>low ]                                                     */
	/* break_async       ____|~~~~~~~~~~~~~~~~~~~~~~~|_______________________  */
	/* baseck           _____|~~~~~|_____|~~~~~|_____|~~~~~|_____|~~~~~|_____  */
	/* break_bck         ____|xxxxxxxxxx0|~~~~~~~~~~~~~~~~~~~~~~~|___________  */
        /* break_meta          ________|xxxx0|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|_____  */
        /* break_pre              _______________________|~~~~~~~~~~~~~~~~~~~~~~~| */
        /* break                   ______________________|~~~~~~~~~~~|___________  */
	/* ----------------------------------------------------------------------- */

	reg break_bck;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if ( !sysrsoutb )
			break_bck <= 1'b0;
		else if ( break_async )
			break_bck <= 1'b1;
		else	break_bck <= 1'b0;
	end

	reg break_meta;
	always @( negedge baseck or negedge sysrsoutb ) begin
		if ( !sysrsoutb )
			break_meta <= 1'b0;
		else	break_meta <= break_bck;
	end

	reg break_pre;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if ( !sysrsoutb )
			break_pre <= 1'b0 ;
		else	break_pre <= break_meta;
	end

	reg break;
	always @( posedge baseck or negedge sysrsoutb ) begin
		if ( !sysrsoutb )
			break <= 1'b0 ;
		else if ( break_meta & ~break_pre ) 
			break <= 1'b1 ;
		else	break <= 1'b0 ;	// 1clock(baseck) pulse
	end

endmodule

