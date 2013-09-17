// IECUBE 78K0R Break Unit		//
// V100				snisimu	//
// V101	Refer to V101		tsuno3	//
// V102 Refer to V102		tsuno3	//
//----------------------------------------------------------
//$B"#(Bv1.37
//  $B8m5-=$@5(B brkfail14 -> brkfail15
//----------------------------------------------------------
//$B"#(Bv1.36
//  $B%G!<%?!&%U%i%C%7%e$N%o!<%I%j!<%I;~$N%U%'%$%k%;!<%U!&(B
//  $B%V%l!<%/$rDI2C$9$k$?$a!"(BBRKFAIL15$BDI2C(B
//----------------------------------------------------------
//  $Id: break.v,v 1.37 2010-07-08 04:08:13 snisimu Exp $

module BREAK (
	SYSRSOUTB, CLK60MHZ,
	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28,
	ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
	ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,
	ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
	ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,
	ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0,
	ICEDI31, ICEDI30, ICEDI29, ICEDI28,
	ICEDI27, ICEDI26, ICEDI25, ICEDI24,
	ICEDI23, ICEDI22, ICEDI21, ICEDI20,
	ICEDI19, ICEDI18, ICEDI17, ICEDI16,
	ICEDI15, ICEDI14, ICEDI13, ICEDI12,
	ICEDI11, ICEDI10, ICEDI9,  ICEDI8,
	ICEDI7,  ICEDI6,  ICEDI5,  ICEDI4,
	ICEDI3,  ICEDI2,  ICEDI1,  ICEDI0,
	ICEDO31, ICEDO30, ICEDO29, ICEDO28,
	ICEDO27, ICEDO26, ICEDO25, ICEDO24,
	ICEDO23, ICEDO22, ICEDO21, ICEDO20,
	ICEDO19, ICEDO18, ICEDO17, ICEDO16,
	ICEDO15, ICEDO14, ICEDO13, ICEDO12,
	ICEDO11, ICEDO10, ICEDO9,  ICEDO8,
	ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,
	ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0,
	ICEWR,
	CPURESETB, BASECK,
	SLMEM,
	ES3, ES2, ES1, ES0,
	MA15, MA14, MA13, MA12,
	MA11, MA10, MA9, MA8,
	MA7, MA6, MA5, MA4,
	MA3, MA2, MA1, MA0,
	MDW15, MDW14, MDW13, MDW12,
	MDW11, MDW10, MDW9, MDW8,
	MDW7, MDW6, MDW5, MDW4,
	MDW3, MDW2, MDW1, MDW0,
	MDR15, MDR14, MDR13, MDR12,
	MDR11, MDR10, MDR9, MDR8,
	MDR7, MDR6, MDR5, MDR4,
	MDR3, MDR2, MDR1, MDR0,
	CPUWR, CPURD,
	SVMOD, SVMODF, HLTST, STPST, ALT1, SELFMODEDBG,
	BRKFAIL0, BRKFAIL1, BRKFAIL2, BRKFAIL3,
	BRKFAIL4, BRKFAIL5, BRKFAIL6, BRKFAIL7,
	BRKFAIL8, BRKFAIL9, BRKFAIL10, BRKFAIL11,
	BRKFAIL12, BRKFAIL13, BRKFAIL14SOURCE, BRKFAIL15,
	SOFTBRK,
	BRKEDMM0, BRKEDMM1, BRKEDMM2, BRKEDMM3,
	BRKSNAP0, BRKSNAP1, BRKSNAP2,
	BRKEVTF0, BRKEVTF1, BRKEVTF2, BRKEVTF3,
	BRKEVTF4, BRKEVTF5, BRKEVTF6, BRKEVTF7,
	BRKEVTA0, BRKEVTA1, BRKEVTA2, BRKEVTA3,
	BRKEVTA4, BRKEVTA5, BRKEVTA6, BRKEVTA7,
	BRKEVTL0, BRKEVTL1,
	BRKTMOT0, BRKTMOT1, BRKTMOT2, BRKTMOT3,
	BRKTMOT4, BRKTMOT5, BRKTMOT6, BRKTMOV0,
	BRKTMOV1, BRKTMOV2, BRKTMOV3, BRKTMOV4,
	BRKTMOV5, BRKTMOV6,
	BRKTRAFL, BRKTRADY,
	STBRELESV, SVI,
	SVVCOUT7, SVVCOUT6, SVVCOUT5, SVVCOUT4,
	SVVCOUT3, SVVCOUT2, SVVCOUT1, SVVCOUT0,
	SVINTACK,
	PCWAITF,
	SVMODI, SVMODUSER,
	SVMODOPBRK, SVMODIPERI1, SVMODIPERI2,
	STEP,
	IDADR15, IDADR14, IDADR13, IDADR12, IDADR11, IDADR10, IDADR9,  IDADR8,	// Added [V101]-(1)
	IDADR7,  IDADR6,  IDADR5,  IDADR4,  IDADR3,  IDADR2,  IDADR1,  IDADR0,	// Added [V101]-(1)
);

	input	SYSRSOUTB, CLK60MHZ;
	input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, // Host I/F address bus
			ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
			ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,
			ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
			ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,
			ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0;
	input	ICEDI31, ICEDI30, ICEDI29, ICEDI28, // Host I/F write data bus
			ICEDI27, ICEDI26, ICEDI25, ICEDI24,
			ICEDI23, ICEDI22, ICEDI21, ICEDI20,
			ICEDI19, ICEDI18, ICEDI17, ICEDI16,
			ICEDI15, ICEDI14, ICEDI13, ICEDI12,
			ICEDI11, ICEDI10, ICEDI9,  ICEDI8,
			ICEDI7,  ICEDI6,  ICEDI5,  ICEDI4,
			ICEDI3,  ICEDI2,  ICEDI1,  ICEDI0;
	output	ICEDO31, ICEDO30, ICEDO29, ICEDO28, // Host I/F read data bus
			ICEDO27, ICEDO26, ICEDO25, ICEDO24,
			ICEDO23, ICEDO22, ICEDO21, ICEDO20,
			ICEDO19, ICEDO18, ICEDO17, ICEDO16,
			ICEDO15, ICEDO14, ICEDO13, ICEDO12,
			ICEDO11, ICEDO10, ICEDO9,  ICEDO8,
			ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,
			ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0;
	input	ICEWR; // Host I/F write strobe
	input	CPURESETB; // CPU and peripheral reset (except RESF)
	input	BASECK; // CPU base clock
	input	SLMEM;
	input	ES3, ES2, ES1, ES0;
	input	MA15, MA14, MA13, MA12;
	input	MA11, MA10, MA9, MA8;
	input	MA7, MA6, MA5, MA4;
	input	MA3, MA2, MA1, MA0;
	input	MDW15, MDW14, MDW13, MDW12;
	input	MDW11, MDW10, MDW9, MDW8;
	input	MDW7, MDW6, MDW5, MDW4;
	input	MDW3, MDW2, MDW1, MDW0;
	output	MDR15, MDR14, MDR13, MDR12;
	output	MDR11, MDR10, MDR9, MDR8;
	output	MDR7, MDR6, MDR5, MDR4;
	output	MDR3, MDR2, MDR1, MDR0;
	input	CPUWR, CPURD;
	input	BRKFAIL0, BRKFAIL1, BRKFAIL2, BRKFAIL3;
	input	BRKFAIL4, BRKFAIL5, BRKFAIL6, BRKFAIL7;
	input	BRKFAIL8, BRKFAIL9, BRKFAIL10, BRKFAIL11;
	input	BRKFAIL12, BRKFAIL13, BRKFAIL14SOURCE, BRKFAIL15;
	input	SOFTBRK;
	input	BRKEDMM0, BRKEDMM1, BRKEDMM2, BRKEDMM3;
	input	BRKSNAP0, BRKSNAP1, BRKSNAP2;
	input	BRKEVTF0, BRKEVTF1, BRKEVTF2, BRKEVTF3;
	input	BRKEVTF4, BRKEVTF5, BRKEVTF6, BRKEVTF7;
	input	BRKEVTA0, BRKEVTA1, BRKEVTA2, BRKEVTA3;
	input	BRKEVTA4, BRKEVTA5, BRKEVTA6, BRKEVTA7;
	input	BRKEVTL0, BRKEVTL1;
	input	BRKTMOT0, BRKTMOT1, BRKTMOT2, BRKTMOT3;
	input	BRKTMOT4, BRKTMOT5, BRKTMOT6, BRKTMOV0;
	input	BRKTMOV1, BRKTMOV2, BRKTMOV3, BRKTMOV4;
	input	BRKTMOV5, BRKTMOV6;
	input	BRKTRAFL, BRKTRADY;
	input	SVMOD, SVMODF, HLTST, STPST, ALT1, SELFMODEDBG;
	output	STBRELESV, SVI;
	output	SVVCOUT7, SVVCOUT6, SVVCOUT5, SVVCOUT4,
			SVVCOUT3, SVVCOUT2, SVVCOUT1, SVVCOUT0;
	input	SVINTACK;
	input	PCWAITF;
	output	SVMODI, SVMODUSER;
	output	SVMODOPBRK, SVMODIPERI1, SVMODIPERI2;
	output	STEP;
	input	IDADR15, IDADR14, IDADR13, IDADR12, IDADR11, IDADR10, IDADR9,  IDADR8,	// Added [V101]-(2)
		IDADR7,  IDADR6,  IDADR5,  IDADR4,  IDADR3,  IDADR2,  IDADR1,  IDADR0;	// Added [V101]-(2)
	
	wire [31:0] ICEIFA, ICEDI, ICEDO;
	wire sel_host_brk;
	wire sel_host_00h, sel_host_04h, sel_host_08h, sel_host_0Ch;
	wire sel_host_10h, sel_host_14h, sel_host_18h;
	
	reg  svmod_d;
	
	reg  ignorefrrm, ignorefdmm;
	reg  brkfrrm, brkfdmm, brkforce, brkstep, brkfail14;
	wire brkvc00h, brkvc02h, brkvc04h, brkvc06h;
	wire brkvc08h, brkvc0Ah, brkvc0Ch, brkvc0Eh;
	wire brkvc10h, brkvc12h, brkvc14h, brkvc16h;
	wire brkvc18h;
	wire brkall, brkforstop;
	
	reg  STBRELESV;
	reg  [7:0] SVVCOUT;
	
	reg srrmbk, sdmmbk, sfbk, stepbk;
	
	wire factfrrm, factfdmm, factforce, factstep;
	wire factedmm0, factedmm1, factedmm2, factedmm3;
	wire factsnap0, factsnap1, factsnap2;
	wire [7:0] fact0, fact1, fact2, fact3;
	wire [7:0] fact4, fact5, fact6, fact7;
	wire [7:0] fact8, fact9, factA, factB;
	wire [7:0] factC, factD, factE, factF;
	wire factuser;
	
	reg stopperi2, stopperi1, opbrk;
	
	// Host bus interface
	
		assign ICEIFA = {
			ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
			ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0
		};
		assign ICEDI = {
			ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
			ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
			ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
			ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0
		};
		assign {
			ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
			ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
			ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
			ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0
		} = ICEDO;
		
		assign sel_host_brk = ICEIFA[27] & ICEIFA[17] & ICEIFA[13];
		assign sel_host_00h = sel_host_brk & (({ICEIFA[7:2], 2'b00} == 8'h00) ? 1'b1 : 1'b0);
		assign sel_host_04h = sel_host_brk & (({ICEIFA[7:2], 2'b00} == 8'h04) ? 1'b1 : 1'b0);
		assign sel_host_08h = sel_host_brk & (({ICEIFA[7:2], 2'b00} == 8'h08) ? 1'b1 : 1'b0);
		assign sel_host_0Ch = sel_host_brk & (({ICEIFA[7:2], 2'b00} == 8'h0C) ? 1'b1 : 1'b0);
		assign sel_host_10h = sel_host_brk & (({ICEIFA[7:2], 2'b00} == 8'h10) ? 1'b1 : 1'b0);
		assign sel_host_14h = sel_host_brk & (({ICEIFA[7:2], 2'b00} == 8'h14) ? 1'b1 : 1'b0);
		assign sel_host_18h = sel_host_brk & (({ICEIFA[7:2], 2'b00} == 8'h18) ? 1'b1 : 1'b0);
		
		assign ICEDO = (
			(sel_host_00h) ? {fact3, fact2, fact1, fact0} :
			(sel_host_04h) ? {fact7, fact6, fact5, fact4} :
			(sel_host_08h) ? {factB, factA, fact9, fact8} :
			(sel_host_0Ch) ? {factF, factE, factD, factC} :
			(sel_host_10h) ? {28'b0, srrmbk, sdmmbk, sfbk, stepbk} : // BRKCNT
			(sel_host_14h) ? {29'b0, stopperi2, stopperi1, opbrk} :  // SVMODMSK
			(sel_host_18h) ? {30'b0, ignorefrrm, ignorefdmm} :       // IGNORE
			32'h0000_0000
		);
	
	// Common
	
		// Added [V101]-(3) start
		wire [15:0] idadrl;
		assign	idadrl = {IDADR15, IDADR14, IDADR13, IDADR12, IDADR11, IDADR10, IDADR9,  IDADR8,
				  IDADR7,  IDADR6,  IDADR5,  IDADR4,  IDADR3,  IDADR2,  IDADR1,  IDADR0};
		wire	standby_st = ((idadrl == 16'hed61) || (idadrl == 16'hfd61)) ? 1'b1 : 1'b0;
		// Added [V101]-(3) end

		always @(posedge BASECK or negedge SYSRSOUTB) begin
			if (!SYSRSOUTB) begin
				svmod_d <= 1'b0;
			end else begin
				svmod_d <= SVMOD; // SVMOD$B$N(B1$B%/%m%C%/CY$l(B
			end
		end
		
		wire standby = HLTST | STPST;
		reg standby_d;
		always @(posedge BASECK or negedge SYSRSOUTB) begin
			if (!SYSRSOUTB) begin
				standby_d <= 1'b0;
			end else begin
				standby_d <= standby; // standby$B$N(B1$B%/%m%C%/CY$l(B
			end
		end
	
	// [$B%V%l!<%/MW5a<u$1IU$1(B]
	
		reg  brkfrrm_async, brkfdmm_async, brkforce_async, brkstep_async, brkfail14_async;
		
		// $BHsF14|$N%V%l!<%/MW5a(B(brkfrrm, brkfdmm, brkforce, brkstep, brkfail14)
		//  $B!&(Bbrkxxx_async : 60MHz$BF14|!"%U%i%0$,(B0$B$KLa$5$l$F$b(BBASECK$B$G%i%C%A$9$k$^$GJ];}$7$J$1$l$P$J$i$J$$(B
		//  $B!&(Bbrkxxx       : BASECK$BF14|(B
		
			always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
				if(!SYSRSOUTB) begin
					brkfrrm_async <= 1'b0;
				end else begin
					if (srrmbk) begin
						if (!standby) begin
							brkfrrm_async <= 1'b1;
						end
					end else begin
						if (brkfrrm) begin
							brkfrrm_async <= 1'b0;
						end
					end
				end
			end
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if(!SYSRSOUTB) begin
					brkfrrm <= 1'b0;
				end else begin
					brkfrrm <= brkfrrm_async;
				end
			end
			
			always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
				if(!SYSRSOUTB) begin
					brkfdmm_async <= 1'b0;
				end else begin
					if (sdmmbk) begin
						if (!standby) begin
							brkfdmm_async <= 1'b1;
						end
					end else begin
						if (brkfdmm) begin
							brkfdmm_async <= 1'b0;
						end
					end
				end
			end
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if(!SYSRSOUTB) begin
					brkfdmm <= 1'b0;
				end else begin
					brkfdmm <= brkfdmm_async;
				end
			end
			
			always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
				if(!SYSRSOUTB) begin
					brkforce_async <= 1'b0;
				end else begin
					if (sfbk) begin
						brkforce_async <= 1'b1;
					end else begin
						if (brkforce) begin
							brkforce_async <= 1'b0;
						end
					end
				end
			end
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if(!SYSRSOUTB) begin
					brkforce <= 1'b0;
				end else begin
					brkforce <= brkforce_async;
				end
			end
			
			always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
				if(!SYSRSOUTB) begin
					brkstep_async <= 1'b0;
				end else begin
					if (stepbk) begin
						brkstep_async <= 1'b1;
					end else begin
						if (brkstep) begin
							brkstep_async <= 1'b0;
						end
					end
				end
			end
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if(!SYSRSOUTB) begin
					brkstep <= 1'b0;
				end else begin
					brkstep <= brkstep_async;
				end
			end
			
			always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
				if(!SYSRSOUTB) begin
					brkfail14_async <= 1'b0;
				end else begin
					if (BRKFAIL14SOURCE) begin   // $B"+(BBRKFAIL14SOURCE : $B%V%l!<%/Cf$N%?!<%2%C%HEE8;(BOFF$B$K$h$k%V%l!<%/(B
						brkfail14_async <= 1'b1; //                   $B!!(B($BEE8;(BOFF$B$G%j%;%C%H$,$+$+$k$?$aHsF14|(B)
					end else begin
						if (brkfail14) begin
							brkfail14_async <= 1'b0;
						end
					end
				end
			end
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if(!SYSRSOUTB) begin
					brkfail14 <= 1'b0;
				end else begin
					brkfail14 <= brkfail14_async;
				end
			end
		
		// brkvcxxh : $B4pK\E*$K(BBASECK$BF14|$G$"$j!"(BSVVCOUT$B$NMW0x$H$J$k(B
		
			assign brkvc00h = (
				BRKFAIL0 | BRKFAIL1 | BRKFAIL2 | BRKFAIL3 |
				BRKFAIL4 | BRKFAIL5 | BRKFAIL6 | BRKFAIL7 |
				BRKFAIL8 | BRKFAIL9 | BRKFAIL10 | BRKFAIL11 |
				BRKFAIL12 | BRKFAIL13 | brkfail14 | BRKFAIL15
			);
			assign brkvc02h = SOFTBRK;
			assign brkvc04h = ~SELFMODEDBG & (brkforce | factforce); // $B%;%k%U!&%W%m%0%i%_%s%0Cf$OJ]N1(B

		// modified [V101]-(4) start
			brksource_modify mod_brkedmm0 ( .baseck(BASECK), .cpuresetb(CPURESETB), .standby_st(standby_st), .standby_d(standby_d), .brksource(BRKEDMM0), .brksource_mod(brkedmm0_mod) );
			brksource_modify mod_brkedmm1 ( .baseck(BASECK), .cpuresetb(CPURESETB), .standby_st(standby_st), .standby_d(standby_d), .brksource(BRKEDMM1), .brksource_mod(brkedmm1_mod) );
			brksource_modify mod_brkedmm2 ( .baseck(BASECK), .cpuresetb(CPURESETB), .standby_st(standby_st), .standby_d(standby_d), .brksource(BRKEDMM2), .brksource_mod(brkedmm2_mod) );
			brksource_modify mod_brkedmm3 ( .baseck(BASECK), .cpuresetb(CPURESETB), .standby_st(standby_st), .standby_d(standby_d), .brksource(BRKEDMM3), .brksource_mod(brkedmm3_mod) );
			assign brkvc06h = ~standby_d & ( // $B%9%?%s%P%$Cf$OJ]N1(B($B%?%$%_%s%0!&%k!<%W2sHr$N$?$a$K(B_d$B$r;H$&(B)
				brkedmm0_mod | factedmm0 |
				brkedmm1_mod | factedmm1 |
				brkedmm2_mod | factedmm2 |
				brkedmm3_mod | factedmm3
			);
			brksource_modify mod_brksnap0 ( .baseck(BASECK), .cpuresetb(CPURESETB), .standby_st(standby_st), .standby_d(standby_d), .brksource(BRKSNAP0), .brksource_mod(brksnap0_mod) );
			brksource_modify mod_brksnap1 ( .baseck(BASECK), .cpuresetb(CPURESETB), .standby_st(standby_st), .standby_d(standby_d), .brksource(BRKSNAP1), .brksource_mod(brksnap1_mod) );
			brksource_modify mod_brksnap2 ( .baseck(BASECK), .cpuresetb(CPURESETB), .standby_st(standby_st), .standby_d(standby_d), .brksource(BRKSNAP2), .brksource_mod(brksnap2_mod) );
			assign brkvc08h = ~standby_d & ( // $B%9%?%s%P%$Cf$OJ]N1(B($B%?%$%_%s%0!&%k!<%W2sHr$N$?$a$K(B_d$B$r;H$&(B)
				brksnap0_mod | factsnap0 |
				brksnap1_mod | factsnap1 |
				brksnap2_mod | factsnap2
			);
			brksource_modify mod_brkfdmm ( .baseck(BASECK), .cpuresetb(CPURESETB), .standby_st(standby_st), .standby_d(standby_d), .brksource(brkfdmm), .brksource_mod(brkfdmm_mod) );
			brksource_modify mod_brkfrrm ( .baseck(BASECK), .cpuresetb(CPURESETB), .standby_st(standby_st), .standby_d(standby_d), .brksource(brkfrrm), .brksource_mod(brkfrrm_mod) );
			wire	brkfdmm_standby = ~standby_d & brkfdmm_mod;
			wire	brkfrrm_standby = ~standby_d & brkfrrm_mod;
			assign brkvc0Ah = ~SELFMODEDBG & // $B%;%k%U!&%W%m%0%i%_%s%0Cf$OJ]N1(B
					  ~standby_d &   // $B%9%?%s%P%$$KF~$k(B2Clock$B4V$OJ]N1(B($B%?%$%_%s%0!&%k!<%W2sHr$N$?$a$K(B_d$B$r;H$&(B)
					  (brkfdmm_mod | factfdmm);
			assign brkvc0Ch = ~SELFMODEDBG & // $B%;%k%U!&%W%m%0%i%_%s%0Cf$OJ]N1(B
					  ~standby_d &   // $B%9%?%s%P%$$KF~$k(B2Clock$B4V$OJ]N1(B($B%?%$%_%s%0!&%k!<%W2sHr$N$?$a$K(B_d$B$r;H$&(B)
					  (brkfrrm_mod | factfrrm);
		// modified [V101]-(4) end
			assign brkvc0Eh = (
				BRKEVTF0 | BRKEVTF1 | BRKEVTF2 | BRKEVTF3 |
				BRKEVTF4 | BRKEVTF5 | BRKEVTF6 | BRKEVTF7 |
				BRKEVTA0 | BRKEVTA1 | BRKEVTA2 | BRKEVTA3 |
				BRKEVTA4 | BRKEVTA5 | BRKEVTA6 | BRKEVTA7 |
				BRKEVTL0 | BRKEVTL1
			);
			assign brkvc10h = 1'b0; // $B<B9TA0%V%l!<%/$N%Y%/%?!<$@$C$?$,!";HMQ$7$J$$$3$H$K$J$C$?(B
			assign brkvc12h = ~SELFMODEDBG & (brkstep | factstep); // $B%;%k%U!&%W%m%0%i%_%s%0Cf$OJ]N1(B
			assign brkvc14h = BRKTMOT0 | BRKTMOT1 | BRKTMOT2 | BRKTMOT3 | BRKTMOT4 | BRKTMOT5 | BRKTMOT6;
			assign brkvc16h = BRKTMOV0 | BRKTMOV1 | BRKTMOV2 | BRKTMOV3 | BRKTMOV4 | BRKTMOV5 | BRKTMOV6;
			assign brkvc18h = BRKTRAFL | BRKTRADY;
		
		assign brkforstop = ( // 60MHz$BF14|$G$"$j!"(BSTBRELESV$B$NMW0x$H$J$k(B
			brkforce_async | brkstep_async | brkfail14_async
		);
		assign brkall = ( // BASECK$BF14|$G$"$j!"(BSVI$B$NMW0x$H$J$k(B
			brkvc00h | brkvc02h | brkvc04h | brkvc06h |
			brkvc08h | brkvc0Ah | brkvc0Ch | brkvc0Eh |
			brkvc10h | brkvc12h | brkvc14h | brkvc16h |
			brkvc18h
		);
		
		// IGNORE$B%l%8%9%?(B
		
			reg ignorefrrm_clear;
			reg ignorefrrm_clear_d0;
			reg ignorefrrm_clear_d1;
			wire res_ignorefrrm_clear = ~SYSRSOUTB | ignorefrrm_clear_d1;
			always @(negedge ICEWR or posedge res_ignorefrrm_clear) begin
				if (res_ignorefrrm_clear) begin
					ignorefrrm_clear <= 1'b0;
				end else begin
					if (sel_host_18h) begin
						ignorefrrm_clear <= ~ICEDI[1]; // $B%[%9%H$+$i(BIGNORERRM$B%S%C%H$r%/%j%"2DG=(B
					end
				end
			end
			always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					ignorefrrm_clear_d0 <= 1'b0;
				end else begin
					ignorefrrm_clear_d0 <= ignorefrrm_clear;
				end
			end
			always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					ignorefrrm_clear_d1 <= 1'b0;
				end else begin
					ignorefrrm_clear_d1 <= ignorefrrm_clear_d0;
				end
			end
			wire ignorefrrm_clear_posedge = ignorefrrm_clear_d0 & ~ignorefrrm_clear_d1;
			wire res_ignorefrrm = ~SYSRSOUTB | ignorefrrm_clear_posedge;
			always @(posedge CLK60MHZ or posedge res_ignorefrrm) begin
				if (res_ignorefrrm) begin
					ignorefrrm <= 1'b0;
				end else begin
					if (standby & srrmbk) begin
						ignorefrrm <= 1'b1;
					end
				end
			end
			
			reg ignorefdmm_clear;
			reg ignorefdmm_clear_d0;
			reg ignorefdmm_clear_d1;
			wire res_ignorefdmm_clear = ~SYSRSOUTB | ignorefdmm_clear_d1;
			always @(negedge ICEWR or posedge res_ignorefdmm_clear) begin
				if (res_ignorefdmm_clear) begin
					ignorefdmm_clear <= 1'b0;
				end else begin
					if (sel_host_18h) begin
						ignorefdmm_clear <= ~ICEDI[0]; // $B%[%9%H$+$i(BIGNOREDMM$B%S%C%H$r%/%j%"2DG=(B
					end
				end
			end
			always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					ignorefdmm_clear_d0 <= 1'b0;
				end else begin
					ignorefdmm_clear_d0 <= ignorefdmm_clear;
				end
			end
			always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					ignorefdmm_clear_d1 <= 1'b0;
				end else begin
					ignorefdmm_clear_d1 <= ignorefdmm_clear_d0;
				end
			end
			wire ignorefdmm_clear_posedge = ignorefdmm_clear_d0 & ~ignorefdmm_clear_d1;
			wire res_ignorefdmm = ~SYSRSOUTB | ignorefdmm_clear_posedge;
			always @(posedge CLK60MHZ or posedge res_ignorefdmm) begin
				if (res_ignorefdmm) begin
					ignorefdmm <= 1'b0;
				end else begin
					if (standby & sdmmbk) begin
						ignorefdmm <= 1'b1;
					end
				end
			end
		
	
	// [SVI$B$H%Y%/%?!<%3!<%I@8@.(B]
	
		always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
			if (!SYSRSOUTB) begin
				STBRELESV <= 1'b0;
			end else begin
				if (SVINTACK) begin // ACK$B$,JV$C$F$-$?$i(B
					STBRELESV <= 1'b0;
				end else begin
					if (standby & (SVI | brkforstop)) begin // $B"+(B(1)SVI       :BASECK$BF14|$G$"$j!"(BSTOP$BCf$K$O(B1$B$H$J$i$J$$(B($B$?$@$7(BSTOP$B0\9TCf$O(B1$B$H$J$k2DG=@-$,$"$k(B)
						STBRELESV <= 1'b1;                  //   (2)brkforstop:60MHz$BF14|$G$"$j!"(BSTOP$BCf$K$b(B1$B$H$J$k2DG=@-$,$"$k(B
					end
				end
			end
		end
		
		reg svintack_d;
		always @(posedge BASECK or negedge SYSRSOUTB) begin
			if(!SYSRSOUTB) begin
				svintack_d <= 1'b0;
			end else begin
				svintack_d <= SVINTACK; // SVINTACK$B$N(B1$B%/%m%C%/CY$l(B
			end
		end
		wire svintacknegedge = ~SVINTACK & svintack_d; // SVINTACK$B$N(Bnegedge$B8!=P(B
		
		reg svmod_transition;
		always @(posedge BASECK or negedge SYSRSOUTB) begin
			if(!SYSRSOUTB) begin
				svmod_transition <= 1'b0;
			end else begin
				if (svintacknegedge | SOFTBRK) begin
					svmod_transition <= 1'b1; // SVMOD$B$X0\9TCf(B
				end else begin
					if (SVMODF) begin
						svmod_transition <= 1'b0; // SVMOD$B$X0\9T40N;(B
					end
				end
			end
		end
		
		reg svmodf_d1;
		always @(posedge BASECK or negedge SYSRSOUTB) begin
			if(!SYSRSOUTB) begin
				svmodf_d1 <= 1'b0;
			end else begin
				svmodf_d1 <= SVMODF; // SVMODF$B$N(B1$B%/%m%C%/CY$l(B
			end
		end
		reg svmodf_d2;
		always @(posedge BASECK or negedge SYSRSOUTB) begin
			if(!SYSRSOUTB) begin
				svmodf_d2 <= 1'b0;
			end else begin
				svmodf_d2 <= svmodf_d1; // SVMODF$B$N(B2$B%/%m%C%/CY$l(B
			end
		end
		wire SVI_head_d0 = brkall & ~svmod_transition & ~svmodf_d2 & ~SVMODF;
		                                                      // $B",(BSVI$B$NA0H>(B
		// modified [V101]-(5) start
//		reg SVI_head_d1;                                      // $B!!(B(1)SVMOD$B$X0\9TCf(B(svmod_transition=1)$B$O=P$5$J$$(B
//		always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin // $B!!(B(2)Go$B$9$k;~E@$GMW5a$,$"$k>l9g$O(BSVMODF=0$B$N(B2$B%/%m%C%/8e$+$i(BSVI$B$r=P$9(B
//			if(!SYSRSOUTB) begin                              //      $B!&(BSVMODF=0$BD>8e$G$O(BSELFMODE$B$,4V$K9g$o$J$$(B
//				SVI_head_d1 <= 1'b0;                          //      $B!&(BSVMOD=0$B$G$OCY$9$.$F(B2$BL?NaL\$^$G<B9T$7$F$7$^$&(B
//			end else begin
//				SVI_head_d1 <= SVI_head_d0; // CLK60MHZ$B$G%i%C%A(B
//			end
//		end
//		reg SVI_head_d2;
//		always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
//			if(!SYSRSOUTB) begin
//				SVI_head_d2 <= 1'b0;
//			end else begin
//				SVI_head_d2 <= SVI_head_d1; // $B$5$i$K(B1$B%/%m%C%/CY$i$;$k(B
//			end
//		end
//		wire SVI_head = SVI_head_d0 | SVI_head_d1 | SVI_head_d2; // SVI$B$K%R%2(B($BC+4V(B)$B$,$G$-$J$$$h$&$K(B
		wire SVI_head = SVI_head_d0; // SVI$B$K%R%2(B($BC+4V(B)$B$,$G$-$k(B.$BC"$7(B,SVI$B$NF~NO$K%R%2$,$"$C$F$bLdBj$,$J$/$J$k(B.
		// modified [V101]-(5) end
		reg SVI_tail;
		always @(posedge BASECK or negedge SYSRSOUTB) begin
			if(!SYSRSOUTB) begin
				SVI_tail <= 1'b0;
			end else begin
				if (svintacknegedge | SOFTBRK) begin // ACK or $B%=%U%H%&%'%"!&%V%l!<%/(B $B$G%/%j%"(B
					SVI_tail <= 1'b0;
				end else begin
					if (SVI_head) begin
						SVI_tail <= 1'b1;  // SVI$B$N8eH>(B
					end
				end
			end
		end
		assign SVI = SVI_head | SVI_tail; // SVI_head$B$,L5$$$H%V%l!<%/!&%?%$%_%s%0$,(B1$B%/%m%C%/CY$/$J$k(B
		
		wire [12:0] brkvc;
		assign brkvc = {
			brkvc00h , brkvc02h , brkvc04h , brkvc06h ,
			brkvc08h , brkvc0Ah , brkvc0Ch , brkvc0Eh ,
			brkvc10h , brkvc12h , brkvc14h , brkvc16h ,
			brkvc18h
		};
		always @(posedge BASECK or negedge SYSRSOUTB) begin
			if(!SYSRSOUTB) begin
				SVVCOUT <= 8'h00;
			end else begin
				if(!SVI_tail) begin // SVI$B$,N)$C$?8e$N:G=i$N%/%m%C%/$^$G%i%C%A(B
					casex(brkvc)
						13'b1xxxxxxxxxxxx : SVVCOUT <= 8'h00;
						// 02h=$B%=%U%H%&%'%"!&%V%l!<%/$O=PNO$7$J$$(B
						13'b0x1xxxxxxxxxx : SVVCOUT <= 8'h04;
						13'b0x01xxxxxxxxx : SVVCOUT <= 8'h06;
						13'b0x001xxxxxxxx : SVVCOUT <= 8'h08;
						13'b0x0001xxxxxxx : SVVCOUT <= 8'h0A;
						13'b0x00001xxxxxx : SVVCOUT <= 8'h0C;
						13'b0x000001xxxxx : SVVCOUT <= 8'h0E;
						13'b0x0000001xxxx : SVVCOUT <= 8'h10;
						13'b0x00000001xxx : SVVCOUT <= 8'h12;
						13'b0x000000001xx : SVVCOUT <= 8'h14;
						13'b0x0000000001x : SVVCOUT <= 8'h16;
						13'b0x00000000001 : SVVCOUT <= 8'h18;
						default SVVCOUT <= 8'h00;
					endcase
				end
			end
	    end
		assign {
			SVVCOUT7, SVVCOUT6, SVVCOUT5, SVVCOUT4,
			SVVCOUT3, SVVCOUT2, SVVCOUT1, SVVCOUT0
		} = SVVCOUT;
	
	// [$B%9%F%C%W<B9T@_Dj(B], [$B6/@)%V%l!<%/H/@8(B]
	
		wire svmodposedge = SVMOD & ~svmod_d; // SVMOD$B$N(Bposedge$B8!=P(B
		
		// SRRMBK
		
			reg res_srrmbk;
			always @(negedge ICEWR or posedge res_srrmbk) begin
				if (res_srrmbk) begin
					srrmbk <= 1'b0;
				end else begin
					if (sel_host_10h) begin
						srrmbk <= ICEDI[3];
					end
				end
			end
			reg srrmbk_d;
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					srrmbk_d <= 1'b0;
				end else begin
					srrmbk_d <= srrmbk; // 1$B%/%m%C%/CY$i$;$?(Bsrrmbk
				end
			end
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					res_srrmbk <= 1'b1;
				end else begin
					res_srrmbk <= srrmbk_d & svmodposedge; // $B"+%V%l!<%/$7$?$i<+F0E*$K%/%j%"(B
				end                                        // $B!!(B($B$?$@$7I,$:MW0x%U%i%0$K;D$k$h$&$K$7$F$$$k(B)
			end
		
		// SDMMBK
		
			reg res_sdmmbk;
			always @(negedge ICEWR or posedge res_sdmmbk) begin
				if (res_sdmmbk) begin
					sdmmbk <= 1'b0;
				end else begin
					if (sel_host_10h) begin
						sdmmbk <= ICEDI[2];
					end
				end
			end
			reg sdmmbk_d;
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					sdmmbk_d <= 1'b0;
				end else begin
					sdmmbk_d <= sdmmbk; // 1$B%/%m%C%/CY$i$;$?(Bsdmmbk
				end
			end
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					res_sdmmbk <= 1'b1;
				end else begin
					res_sdmmbk <= sdmmbk_d & svmodposedge; // $B"+%V%l!<%/$7$?$i<+F0E*$K%/%j%"(B
				end                                        // $B!!(B($B$?$@$7I,$:MW0x%U%i%0$K;D$k$h$&$K$7$F$$$k(B)
			end
		
		// SFBK, STEPBK
		
			always @(negedge ICEWR or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					sfbk   <= 1'b0;
					stepbk <= 1'b0;
				end else begin
					if (sel_host_10h) begin
						sfbk   <= ICEDI[1];
						stepbk <= ICEDI[0];
					end
				end
			end
		
		assign STEP = stepbk;
	
	// [$B%V%l!<%/MW5aDLCN(B]
	
		wire factfail0, factfail1, factfail2, factfail3;
		wire factfail4, factfail5, factfail6, factfail7;
		wire factfail8, factfail9, factfail10, factfail11;
		wire factfail12, factfail13, factfail14, factfail15;
		wire factsoft;
		wire factevtf0, factevtf1, factevtf2, factevtf3;
		wire factevtf4, factevtf5, factevtf6, factevtf7;
		wire factevta0, factevta1, factevta2, factevta3;
		wire factevta4, factevta5, factevta6, factevta7;
		wire factevtl0, factevtl1;
		wire facttmot0, facttmot1, facttmot2, facttmot3, facttmot4, facttmot5, facttmot6;
		wire facttmov0, facttmov1, facttmov2, facttmov3, facttmov4, facttmov5, facttmov6;
		wire facttrafl, facttrady;
		wire sel_cpu_brk;
		wire sel_cpu_0h, sel_cpu_1h, sel_cpu_2h, sel_cpu_3h;
		wire sel_cpu_4h, sel_cpu_5h, sel_cpu_6h, sel_cpu_7h;
		wire sel_cpu_8h, sel_cpu_9h, sel_cpu_Ah, sel_cpu_Bh;
		wire sel_cpu_Ch, sel_cpu_Dh, sel_cpu_Eh, sel_cpu_Fh;
		wire res_factall;
		wire res_factinstant;
		wire [3:0] ES;
		wire [15:0] MA;
		
		// Fact registers
		
			BRKFACTREG factregfail0  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL0),  .fact(factfail0) );
			BRKFACTREG factregfail1  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL1),  .fact(factfail1) );
			BRKFACTREG factregfail2  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL2),  .fact(factfail2) );
			BRKFACTREG factregfail3  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL3),  .fact(factfail3) );
			BRKFACTREG factregfail4  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL4),  .fact(factfail4) );
			BRKFACTREG factregfail5  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL5),  .fact(factfail5) );
			BRKFACTREG factregfail6  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL6),  .fact(factfail6) );
			BRKFACTREG factregfail7  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL7),  .fact(factfail7) );
			BRKFACTREG factregfail8  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL8),  .fact(factfail8) );
			BRKFACTREG factregfail9  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL9),  .fact(factfail9) );
			BRKFACTREG factregfail10 (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL10), .fact(factfail10));
			BRKFACTREG factregfail11 (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL11), .fact(factfail11));
			BRKFACTREG factregfail12 (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL12), .fact(factfail12));
			BRKFACTREG factregfail13 (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL13), .fact(factfail13));
			BRKFACTREG factregfail14 (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(brkfail14), .fact(factfail14));
			BRKFACTREG factregfail15 (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKFAIL15), .fact(factfail15));
			BRKFACTREG factregsoft   (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(SOFTBRK),   .fact(factsoft)  );
			BRKFACTREG factregforce  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(brkforce),  .fact(factforce) );
			BRKFACTREG factregedmm0  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall | res_factinstant), .brk(brkedmm0_mod),  .fact(factedmm0) ); // Modified [V101]-(6)
			BRKFACTREG factregedmm1  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall | res_factinstant), .brk(brkedmm1_mod),  .fact(factedmm1) ); // Modified [V101]-(6)
			BRKFACTREG factregedmm2  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall | res_factinstant), .brk(brkedmm2_mod),  .fact(factedmm2) ); // Modified [V101]-(6)
			BRKFACTREG factregedmm3  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall | res_factinstant), .brk(brkedmm3_mod),  .fact(factedmm3) ); // Modified [V101]-(6)
			BRKFACTREG factregsnap0  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall | res_factinstant), .brk(brksnap0_mod),  .fact(factsnap0) ); // Modified [V101]-(6)
			BRKFACTREG factregsnap1  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall | res_factinstant), .brk(brksnap1_mod),  .fact(factsnap1) ); // Modified [V101]-(6)
			BRKFACTREG factregsnap2  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall | res_factinstant), .brk(brksnap2_mod),  .fact(factsnap2) ); // Modified [V101]-(6)
			BRKFACTREG factregfdmm   (.clock(BASECK), .reset(~SYSRSOUTB | res_factall | res_factinstant), .brk(brkfdmm_standby),   .fact(factfdmm)  ); // Modified [V101]-(6)
			BRKFACTREG factregfrrm   (.clock(BASECK), .reset(~SYSRSOUTB | res_factall | res_factinstant), .brk(brkfrrm_standby),   .fact(factfrrm)  ); // Modified [V101]-(6)
			BRKFACTREG factregevtf0  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTF0),  .fact(factevtf0) );
			BRKFACTREG factregevtf1  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTF1),  .fact(factevtf1) );
			BRKFACTREG factregevtf2  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTF2),  .fact(factevtf2) );
			BRKFACTREG factregevtf3  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTF3),  .fact(factevtf3) );
			BRKFACTREG factregevtf4  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTF4),  .fact(factevtf4) );
			BRKFACTREG factregevtf5  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTF5),  .fact(factevtf5) );
			BRKFACTREG factregevtf6  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTF6),  .fact(factevtf6) );
			BRKFACTREG factregevtf7  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTF7),  .fact(factevtf7) );
			BRKFACTREG factregevta0  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTA0),  .fact(factevta0) );
			BRKFACTREG factregevta1  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTA1),  .fact(factevta1) );
			BRKFACTREG factregevta2  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTA2),  .fact(factevta2) );
			BRKFACTREG factregevta3  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTA3),  .fact(factevta3) );
			BRKFACTREG factregevta4  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTA4),  .fact(factevta4) );
			BRKFACTREG factregevta5  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTA5),  .fact(factevta5) );
			BRKFACTREG factregevta6  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTA6),  .fact(factevta6) );
			BRKFACTREG factregevta7  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTA7),  .fact(factevta7) );
			BRKFACTREG factregevtl0  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTL0),  .fact(factevtl0) );
			BRKFACTREG factregevtl1  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKEVTL1),  .fact(factevtl1) );
			BRKFACTREG factregstep   (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(brkstep),   .fact(factstep)  );
			BRKFACTREG factregtmot0  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOT0),  .fact(facttmot0) );
			BRKFACTREG factregtmot1  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOT1),  .fact(facttmot1) );
			BRKFACTREG factregtmot2  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOT2),  .fact(facttmot2) );
			BRKFACTREG factregtmot3  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOT3),  .fact(facttmot3) );
			BRKFACTREG factregtmot4  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOT4),  .fact(facttmot4) );
			BRKFACTREG factregtmot5  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOT5),  .fact(facttmot5) );
			BRKFACTREG factregtmot6  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOT6),  .fact(facttmot6) );
			BRKFACTREG factregtmov0  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOV0),  .fact(facttmov0) );
			BRKFACTREG factregtmov1  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOV1),  .fact(facttmov1) );
			BRKFACTREG factregtmov2  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOV2),  .fact(facttmov2) );
			BRKFACTREG factregtmov3  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOV3),  .fact(facttmov3) );
			BRKFACTREG factregtmov4  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOV4),  .fact(facttmov4) );
			BRKFACTREG factregtmov5  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOV5),  .fact(facttmov5) );
			BRKFACTREG factregtmov6  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTMOV6),  .fact(facttmov6) );
			BRKFACTREG factregtrafl  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTRAFL),  .fact(facttrafl) );
			BRKFACTREG factregtrady  (.clock(BASECK), .reset(~SYSRSOUTB | res_factall),                   .brk(BRKTRADY),  .fact(facttrady) );
			
			assign factuser = (
				factfail0 | factfail1 | factfail2 | factfail3 |
				factfail4 | factfail5 | factfail6 | factfail7 |
				factfail8 | factfail9 | factfail10 | factfail11 |
				factfail12 | factfail13 | factfail14 | factfail15 |
				factsoft |
				factforce |
				factevtf0 | factevtf1 | factevtf2 | factevtf3 |
				factevtf4 | factevtf5 | factevtf6 | factevtf7 |
				factevta0 | factevta1 | factevta2 | factevta3 |
				factevta4 | factevta5 | factevta6 | factevta7 |
				factevtl0 | factevtl1 |
				factstep |
				facttmot0 | facttmot1 | facttmot2 | facttmot3 | facttmot4 | facttmot5 | facttmot6 |
				facttmov0 | facttmov1 | facttmov2 | facttmov3 | facttmov4 | facttmov5 | facttmov6 |
				facttrafl | facttrady
			);
		
		// Selector
		
			assign sel_cpu_brk = CPURESETB & SVMOD & ~ALT1 & SLMEM & (({ES, MA[15:4], 4'h0} == 20'hFC000) ? 1'b1 : 1'b0);
			assign sel_cpu_0h = sel_cpu_brk & ((MA[3:0] == 4'h0) ? 1'b1 : 1'b0);
			assign sel_cpu_1h = sel_cpu_brk & ((MA[3:0] == 4'h1) ? 1'b1 : 1'b0);
			assign sel_cpu_2h = sel_cpu_brk & ((MA[3:0] == 4'h2) ? 1'b1 : 1'b0);
			assign sel_cpu_3h = sel_cpu_brk & ((MA[3:0] == 4'h3) ? 1'b1 : 1'b0);
			assign sel_cpu_4h = sel_cpu_brk & ((MA[3:0] == 4'h4) ? 1'b1 : 1'b0);
			assign sel_cpu_5h = sel_cpu_brk & ((MA[3:0] == 4'h5) ? 1'b1 : 1'b0);
			assign sel_cpu_6h = sel_cpu_brk & ((MA[3:0] == 4'h6) ? 1'b1 : 1'b0);
			assign sel_cpu_7h = sel_cpu_brk & ((MA[3:0] == 4'h7) ? 1'b1 : 1'b0);
			assign sel_cpu_8h = sel_cpu_brk & ((MA[3:0] == 4'h8) ? 1'b1 : 1'b0);
			assign sel_cpu_9h = sel_cpu_brk & ((MA[3:0] == 4'h9) ? 1'b1 : 1'b0);
			assign sel_cpu_Ah = sel_cpu_brk & ((MA[3:0] == 4'hA) ? 1'b1 : 1'b0);
			assign sel_cpu_Bh = sel_cpu_brk & ((MA[3:0] == 4'hB) ? 1'b1 : 1'b0);
			assign sel_cpu_Ch = sel_cpu_brk & ((MA[3:0] == 4'hC) ? 1'b1 : 1'b0);
			assign sel_cpu_Dh = sel_cpu_brk & ((MA[3:0] == 4'hD) ? 1'b1 : 1'b0);
			assign sel_cpu_Eh = sel_cpu_brk & ((MA[3:0] == 4'hE) ? 1'b1 : 1'b0);
			assign sel_cpu_Fh = sel_cpu_brk & ((MA[3:0] == 4'hF) ? 1'b1 : 1'b0);
		
		// Read common
		
			assign fact0 = {factfail7, factfail6, factfail5, factfail4, factfail3, factfail2, factfail1, factfail0};
			assign fact1 = {factfail15, factfail14, factfail13, factfail12, factfail11, factfail10, factfail9, factfail8};
			assign fact2 = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, factforce, factsoft};
			assign fact3 = {1'b0, factsnap2, factsnap1, factsnap0, factedmm3, factedmm2, factedmm1, factedmm0};
			assign fact4 = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, factfrrm, factfdmm};
			assign fact5 = {factevtf7, factevtf6, factevtf5, factevtf4, factevtf3, factevtf2, factevtf1, factevtf0};
			assign fact6 = {factevta7, factevta6, factevta5, factevta4, factevta3, factevta2, factevta1, factevta0};
			assign fact7 = {1'b0, 1'b0, 1'b0, 1'b0, factstep, 1'b0, factevtl1, factevtl0};
			assign fact8 = {1'b0, facttmot6, facttmot5, facttmot4, facttmot3, facttmot2, facttmot1, facttmot0};
			assign fact9 = {1'b0, facttmov6, facttmov5, facttmov4, facttmov3, facttmov2, facttmov1, facttmov0};
			assign factA = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, facttrady, facttrafl};
			assign factB = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
			assign factC = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
			assign factD = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
			assign factE = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
			assign factF = {factuser, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
		
		// Read from CPU
		
			wire [15:0] MDR, MDW;
			
			assign ES = {ES3, ES2, ES1, ES0};
			assign MA = {
				MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8,
				MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0
			};
			assign MDW = {
				MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8,
				MDW7, MDW6, MDW5, MDW4, MDW3, MDW2, MDW1, MDW0
			};
			assign {
				MDR15, MDR14, MDR13, MDR12, MDR11, MDR10, MDR9, MDR8,
				MDR7, MDR6, MDR5, MDR4, MDR3, MDR2, MDR1, MDR0
			} = MDR;
			
			assign MDR = (
				(CPURD & sel_cpu_0h) ? {8'h00, fact0} :
				(CPURD & sel_cpu_1h) ? {fact1, 8'h00} :
				(CPURD & sel_cpu_2h) ? {8'h00, fact2} :
				(CPURD & sel_cpu_3h) ? {fact3, 8'h00} :
				(CPURD & sel_cpu_4h) ? {8'h00, fact4} :
				(CPURD & sel_cpu_5h) ? {fact5, 8'h00} :
				(CPURD & sel_cpu_6h) ? {8'h00, fact6} :
				(CPURD & sel_cpu_7h) ? {fact7, 8'h00} :
				(CPURD & sel_cpu_8h) ? {8'h00, fact8} :
				(CPURD & sel_cpu_9h) ? {fact9, 8'h00} :
				(CPURD & sel_cpu_Ah) ? {8'h00, factA} :
				(CPURD & sel_cpu_Bh) ? {factB, 8'h00} :
				(CPURD & sel_cpu_Ch) ? {8'h00, factC} :
				(CPURD & sel_cpu_Dh) ? {factD, 8'h00} :
				(CPURD & sel_cpu_Eh) ? {8'h00, factE} :
				(CPURD & sel_cpu_Fh) ? {factF, 8'h00} :
				16'h0000
			);
		
		// Clear facts
		
			reg factall_clear_host;
			reg factall_clear_host_d0;
			reg factall_clear_host_d1;
			wire res_factall_clear_host = ~SYSRSOUTB | factall_clear_host_d1;
			always @(negedge ICEWR or posedge res_factall_clear_host) begin
				if (res_factall_clear_host) begin
					factall_clear_host <= 1'b0;
				end else begin
					if (sel_host_0Ch) begin
						factall_clear_host <= ~ICEDI[31];
					end
				end
			end
			always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					factall_clear_host_d0 <= 1'b0;
				end else begin
					factall_clear_host_d0 <= factall_clear_host;
				end
			end
			always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					factall_clear_host_d1 <= 1'b0;
				end else begin
					factall_clear_host_d1 <= factall_clear_host_d0;
				end
			end
			wire res_factall_host = factall_clear_host_d0 & ~factall_clear_host_d1; // $B"+%[%9%H$+$iA4MW0x%l%8%9%?$r%/%j%"$9$k?.9f(B
			reg res_factall_cpu;                                                    // $B!!(B($B!a(B factall_crear $B$N(B posedge)
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					res_factall_cpu <= 1'b0;
				end else begin
					res_factall_cpu <= CPUWR & sel_cpu_Fh & ~MDW[7]; // CPU$B$+$iA4MW0x%l%8%9%?$r%/%j%"$9$k?.9f(B
				end
			end
			assign res_factall = res_factall_host | res_factall_cpu;
			
			reg res_factinstant_cpu;
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					res_factinstant_cpu <= 1'b0;
				end else begin
					res_factinstant_cpu <= CPUWR & sel_cpu_Fh & ~MDW[6];  // CPU$B$+$i0l=V%V%l!<%/$N$_$r%/%j%"$9$k?.9f(B
				end
			end
			assign res_factinstant = ~CPURESETB | res_factinstant_cpu; // $B"+0l=V%V%l!<%/$O(BCPU$B%j%;%C%H$G$b%/%j%"$9$k(B
		                                                               // $B!!(B($B>u67$,JQ$o$C$?8e$K%V%l!<%/$9$k$N$O%f!<%6$NK\0U$G$J$$$?$a(B)
	
	// [$B%V%l!<%/>uBVDLCN(B]
	
		
		// SVMODI$B@8@.(B
		
			reg pcwaitf_insvmod;
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					pcwaitf_insvmod <= 1'b0;
				end else begin
					if (PCWAITF) begin
						if (SVMOD) begin
							pcwaitf_insvmod <= 1'b1;
						end
					end else begin
						pcwaitf_insvmod <= 1'b0;
					end
				end
			end
			assign SVMODI = SVMOD | svmod_d | (PCWAITF & pcwaitf_insvmod); // SVMOD$B$r(B1$B%/%m%C%/1d$P$9(B
		
		// SVMODUSER$B@8@.(B
		
			reg softbrk_d, factuser_long;
			
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					softbrk_d <= 1'b0;
				end else begin
					softbrk_d <= SOFTBRK; // SOFTBRK$B$N(B1$B%/%m%C%/CY$l(B
				end
			end
			wire softbrkposedge = SOFTBRK & ~softbrk_d; // SOFTBRK$B$N(Bposedge$B8!=P(B
			reg softbrk_transition_tail;
			always @(posedge BASECK or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					softbrk_transition_tail <= 1'b0;
				end else begin
					if (factuser_long) begin
						softbrk_transition_tail <= 1'b0; // $B%=%U%H%&%'%"!&%V%l!<%/MW0x$,G'<1$5$l$?$i%/%j%"(B
					end else begin
						if (softbrkposedge) begin
							softbrk_transition_tail <= 1'b1; // $B"+%=%U%H%&%'%"!&%V%l!<%/$G(BSVMOD$B$K0\9TCf(B
						end                                  // $B!!$?$@$7!"=P;O$a$,(B1$B%/%m%C%/CY$$(B
					end
				end
			end
			wire softbrk_transition = SOFTBRK | softbrk_transition_tail; // $B%=%U%H%&%'%"!&%V%l!<%/$G(BSVMOD$B$K0\9TCf(B
			
			wire svmodnegedge = ~SVMOD & svmod_d; // SVMOD$B$N(Bnegedge$B8!=P(B
			wire res_factuser_long = ~SYSRSOUTB | svmodnegedge;
			always @(posedge BASECK or posedge res_factuser_long) begin
				if (res_factuser_long) begin
					factuser_long <= 1'b0; // SVMOD$B$,=*$C$?$i%/%j%"(B
				end else begin
					if (factuser) begin
						factuser_long <= 1'b1; // $B%f!<%6!&%V%l!<%/MW5a%U%i%0$,N)$C$F$$$k(B
					end
				end
			end
			
			assign SVMODUSER = SVMOD & (softbrk_transition | factuser_long);
			//     $B",%=%U%H%&%'%"!&%V%l!<%/$O(BSOFTBRK$B$H(BSVMOD$B$,F1;~$J$N$G(Bfactuser$B$,4V$K9g$o$J$$(B
		
		// SVMODOPBRK, SVMODIPERI1, SVMODIPERI2$B@8@.(B
		
			always @(negedge ICEWR or negedge SYSRSOUTB) begin
				if (!SYSRSOUTB) begin
					stopperi2 <= 1'b0;
					stopperi1 <= 1'b0;
					opbrk     <= 1'b0;
				end else begin
					if (sel_host_14h) begin
						stopperi2 <= ICEDI[2];
						stopperi1 <= ICEDI[1];
						opbrk     <= ICEDI[0];
					end
				end
			end
			assign SVMODOPBRK = SVMODUSER & opbrk;
			assign SVMODIPERI1 = SVMODI & stopperi1;
			assign SVMODIPERI2 = SVMODI & stopperi2;
		
	
endmodule

module BRKFACTREG(clock, reset, brk, fact);
	
	input clock, reset, brk;
	output fact;
	reg fact;
	
	always @(posedge clock or posedge reset) begin
		if(reset) begin
			fact <= 1'b0;
		end else begin
			if (brk) begin
				fact <= 1'b1;
			end
		end
	end
	
endmodule

// added [V101]-(7) start
module brksource_modify ( baseck, cpuresetb, standby_st, standby_d, brksource, brksource_mod );

	input baseck, cpuresetb, standby_st, standby_d, brksource;
	output brksource_mod;
	
	reg brksource_l;
	always @(posedge baseck or negedge cpuresetb) begin
		if (!cpuresetb) brksource_l <= 1'b0;
		else if (!standby_st || standby_d) brksource_l <= 1'b0;
		else if (standby_st & brksource ) brksource_l <= 1'b1;
	end
		// Modified [V102]
		/* --------------------------------------------------------------------------------------------	*/
		/* standby_d$B$,(BLow$B$N(B2Clock$B4V0J30$N(Bbrksource$B$O(Bthrough(standby_d==1$B;~$N(Bevent$B$OMW0x(BLatch$B$,<u$1$k(B)	*/
		/* stadnby_d$B$,(BLow$B$N(B2Clock$B4V$N(Bbrksource$B$O(BLatch$B$7$F(Bstandby$B2r=|%?%$%_%s%0$^$GJ]N1$9$k(B		*/
		/* --------------------------------------------------------------------------------------------	*/
	wire	brksource_mod = (~(standby_st & ~standby_d) & brksource) | (brksource_l & (standby_d | ~standby_st));
endmodule
// added [V101]-(7) end
