// status
// V100 New by K.Ishihara at 2003/01/09.  
// V101 Add EMXIN11 and change meckstate to x11ckstate for K2. by shunji.nishimura@nms at 2004/05/14.(Please serch 'V101'.)
//-------------------------------------------------------------------------------------------------------------------------
// 78K0R V100 New by taketoshi.ide at 2005/05/20
//$Id: status.v,v 1.7 2007-10-03 04:00:55 tsuno3 Exp $
module STATUS (
	BASECK, SVMOD, SVMODUSER, ALT1, SELFMODE, HLTST, STPST, CPURESETB, TRESET_B, WAITEXM,
	EVAOSCMCLK, CPUSCLK, CPUTMCLK, TCCONNECT_B, EACONNECT_B, TVDDON, TVDDSEL, TBTSELOUT,
	LEDTVDD_B, LEDCLOCK_B, LEDRUN_B, LEDRESET_B, LEDSTANDBY_B, LEDWAIT_B,
	WDOP, CPURD, CPUWR,
	MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8, MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0,
	MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8, MDW7, MDW6, MDW5, MDW4, MDW3, MDW2, MDW1, MDW0,
	STATEMDR15, STATEMDR14, STATEMDR13, STATEMDR12, STATEMDR11, STATEMDR10, STATEMDR9,STATEMDR8,
	STATEMDR7, STATEMDR6, STATEMDR5, STATEMDR4, STATEMDR3, STATEMDR2, STATEMDR1, STATEMDR0,
	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
	ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0,
	ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
	ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
	ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
	ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0,
	ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
	ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
	ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
	ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0,
	ICEWR, CK60MHZ, SYSRSOUTB
);
	input	BASECK, SVMOD, SVMODUSER, ALT1, SELFMODE, HLTST, STPST, CPURESETB, TRESET_B, WAITEXM,
			EVAOSCMCLK, CPUSCLK, CPUTMCLK, TCCONNECT_B, EACONNECT_B, TVDDON;
	output	TVDDSEL;
	input   TBTSELOUT;
	output	LEDTVDD_B, LEDCLOCK_B, LEDRUN_B, LEDRESET_B, LEDSTANDBY_B, LEDWAIT_B;
	input	WDOP, CPURD, CPUWR;
	input	MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8, MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0;
	input	MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8,
			MDW7, MDW6, MDW5, MDW4, MDW3, MDW2, MDW1, MDW0;
	output	STATEMDR15, STATEMDR14, STATEMDR13, STATEMDR12, STATEMDR11, STATEMDR10, STATEMDR9,STATEMDR8,
			STATEMDR7, STATEMDR6, STATEMDR5, STATEMDR4, STATEMDR3, STATEMDR2, STATEMDR1, STATEMDR0;
	input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
			ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0;
	input   ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
			ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
			ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
			ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0;
	output	ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
			ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
			ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
			ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0;
	input	ICEWR, CK60MHZ, SYSRSOUTB;

	wire [31:0] iceifa, icedi;
	
//***************************************************************************************
//*Emulation Registor
//***************************************************************************************
	reg 		seliceck;		//ICEボード上の発振器のクロック検出選択：1選択
	reg 		seltmck;		//ターゲットからのメインクロック検出選択：1選択
	reg 		selbaseck;		//BASECK検出選択(デフォルトはこれ)：1選択	
	wire [15:0] clock_cycle;
	wire		clock_cycle_st;
	reg			tvddsel;
//	reg			powdw; //仕様変更により回路削除 2006.2.24
//***************************************************************************************
	wire 		clk_in;
	wire		sel_mcksel, sel_sys1;
	wire 		hostreg_sel, cpureg_sel;
//	wire		powdw_reset, set_powdw; //仕様変更により回路削除 2006.2.24
//***************************************************************************************
	reg  [31:0] icedo;
	wire [15:0] ma;
	reg  [15:0] statemdr;
//***************************************************************************************

	assign iceifa = {ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
			ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0};
	assign icedi = {
		ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
		ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
		ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
		ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0};
	assign {ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
		ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
		ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
		ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0}
		= icedo;

	assign ma = {MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8, MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0};

	assign {STATEMDR15, STATEMDR14, STATEMDR13, STATEMDR12, STATEMDR11, STATEMDR10, STATEMDR9, STATEMDR8, 
			STATEMDR7, STATEMDR6, STATEMDR5, STATEMDR4, STATEMDR3, STATEMDR2, STATEMDR1, STATEMDR0} = statemdr;

//***************************************************************************************
	wire tbtselstate = TBTSELOUT;   //ブートスワップ状態 1:SWAP (2006.1.18 追加)
	wire selfstate = SELFMODE;      //Selfmode State Signal 1:Self Mode
	wire sclkstate;                 //サブクロック状態 0:停止
	wire mclkstate;                 //メインクロック状態 0:停止
	wire cpurststate = !CPURESETB;  //CPUリセット状態  0:解除
	wire uctcstate = TCCONNECT_B;   //TC(ターゲット)接続状態
	wire uceastate = EACONNECT_B;   //EA(変換アダプタ)接続状態
	wire uresetstate = !TRESET_B;   //ターゲットリセット状態  0:解除
	wire uvddlostate = TVDDON;      //ターゲット電源下位レベル  0:設定値内
	wire waitstate;                 //ウエイト状態  0:継続検出なし
	wire stopstate;                 //ストップ状態  0:継続検出なし
	wire haltstate;                 //ホルト状態  0:継続検出なし
	wire irunstate = !SVMOD;        //ユーザーRUN中  0:SVMOD中
	wire urunstate = !SVMODUSER;    //ユーザーRUN中  0:SVMOD中(ただし一瞬ブレイク除く)
//***************************************************************************************
//*LED output
//***************************************************************************************
	assign LEDTVDD_B = !uvddlostate; 
	assign LEDCLOCK_B = mclkstate;
	assign LEDRUN_B = !urunstate;
	assign LEDRESET_B = !cpurststate;
	assign LEDSTANDBY_B = !(stopstate | haltstate);
	assign LEDWAIT_B = !waitstate;
//***************************************************************************************
//* CLOCK STATUS SELECT
//***************************************************************************************
	
	assign clk_in = (selbaseck) ? BASECK : (seltmck) ? CPUTMCLK : (seliceck) ? EVAOSCMCLK : 1'b0;

//***************************************************************************************
//Counter detect STOP, HALT, WAIT status value  over 2.63s
//***************************************************************************************

	STATUS3S waitst (.in(CK60MHZ), .out(waitstate), .reset(!WAITEXM) );
	STATUS3S hltst (.in(CK60MHZ), .out(haltstate), .reset(!HLTST) );
	STATUS3S stpst (.in(CK60MHZ), .out(stopstate), .reset(!STPST) );

//***************************************************************************************
//1.3ms(約1KHz)以下のクロックを停止とみなす
//***************************************************************************************

	CLKSTATUS1K cpumclkst (.clkin(clk_in), .out(mclkstate), .ck60mhz(CK60MHZ));
	CLKSTATUS1K cpusclkst (.clkin(CPUSCLK), .out(sclkstate), .ck60mhz(CK60MHZ));

//***************************************************************************************
//クロック周波数検出回路
//***************************************************************************************

	STATUS_CLOCKSENCE clock_sence (.baseck(BASECK), .ck60mhz(CK60MHZ), .sysrsoutb(SYSRSOUTB),
			.hltst(HLTST), .stpst(STPST), .countbuf(clock_cycle), .data_set_end(clock_cycle_st) );

//***************************************************************************************
//*レジスタ読みだし HOST
//***************************************************************************************
//*Emulation Registor HOST Address
//*STATEDET					0804_1000H
//*MCLKSEL					0804_1004H
//*BCKCYCLE and BCKCYCST	0804_1008H
//*SYS1						0804_100CH
//*PWSTATE					0804_1010H
//***************************************************************************************
	assign hostreg_sel = !ICEIFA31 & !ICEIFA30 & !ICEIFA29 & !ICEIFA28 &
	                      ICEIFA27 & !ICEIFA26 & !ICEIFA25 & !ICEIFA24 &
	                     !ICEIFA23 & !ICEIFA22 & !ICEIFA21 & !ICEIFA20 &
	                     !ICEIFA19 &  ICEIFA18 & !ICEIFA17 & !ICEIFA16 &
	                     !ICEIFA15 & !ICEIFA14 & !ICEIFA13 &  ICEIFA12;

	//仕様変更によりパワーダウン検出回路削除 (powdwの削除)
	always @(iceifa or hostreg_sel or tbtselstate or selfstate or sclkstate or mclkstate or cpurststate or
             uctcstate or uceastate or uresetstate or uvddlostate or waitstate or stopstate or
             haltstate or irunstate or urunstate or clock_cycle_st or clock_cycle or seliceck or
             seltmck or selbaseck or tvddsel)begin
			casex({hostreg_sel, iceifa[4:2]})
				4'b1000 : icedo = {8'h00, 2'b00, tbtselstate, selfstate, !sclkstate, 2'b00, !mclkstate,
								  cpurststate, 4'b0000, uctcstate, uceastate, uresetstate,
								  1'b0, uvddlostate, waitstate, stopstate, haltstate, 1'b0,
								  irunstate, urunstate};
				4'b1001 : icedo = {28'h0000_000, 1'b0, seliceck, seltmck, selbaseck};
				4'b1010 : icedo = {12'h000, 3'b000, clock_cycle_st, clock_cycle};
				4'b1011 : icedo = {28'h0000_000, 3'b00, tvddsel};
				/*4'b1100 : icedo = {28'h0000_000, 3'b000, powdw};*/
				default icedo = 32'h0000_0000;
			endcase
	end

//***************************************************************************************
//MCKSEL and SYS1 registor wite
//***************************************************************************************
	assign sel_mcksel = hostreg_sel & (iceifa[4:2] == 3'b001);
	assign sel_sys1 = hostreg_sel & (iceifa[4:2] == 3'b011);
	always @(negedge ICEWR or negedge SYSRSOUTB) begin 
		if(!SYSRSOUTB) begin
			{seliceck, seltmck, selbaseck} <= 3'b001;
		end
		else if(sel_mcksel) begin
			{seliceck, seltmck, selbaseck} <= icedi[2:0];
		end
	end
	always @(negedge ICEWR or negedge SYSRSOUTB) begin 
		if(!SYSRSOUTB) begin
			tvddsel <= 1'b1;
		end
		else if(sel_sys1) begin
			tvddsel <= icedi[0];
		end
	end
	assign TVDDSEL = tvddsel;
//***************************************************************************************
//*POWER DOWN 検出                              modyfy at 2006.1.18 taketoshi.ide@nms   *
//*                                             delete at 2006.2.24 taketoshi.ide@nms   *
//***************************************************************************************
//	assign powdw_reset = (hostreg_sel & ICEIFA4 & !ICEIFA3 & !ICEIFA2) ? ICEWR : !SYSRSOUTB;
//	assign set_powdw = !TVDDON & !SVMODUSER;
//	always @(posedge CK60MHZ or posedge powdw_reset) begin
//		if(powdw_reset) powdw <= 1'b0;
//		else if(set_powdw)powdw <= 1'b0;
//	end
//***************************************************************************************
//レジスタ読みだし(CPU)
//***************************************************************************************
	assign cpureg_sel = SVMOD & !ALT1 & CPURD & (ma[15:4] == 12'hC04);
	always @(cpureg_sel or ma or clock_cycle_st or clock_cycle or WDOP) begin
			casex ({cpureg_sel, WDOP, ma[3:0]})
				6'b110000 : statemdr = clock_cycle[15:0];
				6'b100010 : statemdr = {15'b0, clock_cycle_st};
				default  : statemdr = 16'h0000;
			endcase
	end
endmodule


//***************************************************************************************//
//*クロックステータス検出回路                                                           *//
//*78K0R modify at taketoshi.ide 2005/05/25                                             *//
//***************************************************************************************//
module CLKSTATUS1K(clkin, ck60mhz, out);
	input clkin, ck60mhz;
	output out;

	wire	clks, prs16;
	reg	clkm_p1, clkm_p2, out;

	always @(posedge ck60mhz) begin
		clkm_p1 <= clkin;
	end
	always @(posedge ck60mhz) begin
		clkm_p2 <= clkm_p1;
	end
	assign clks = clkm_p1 ^ clkm_p2;

	STATUSBFF bff1 (.in(ck60mhz), .out(prs1), .reset(clks) );	//20ns 16.6ns 60MHz
	STATUSBFF bff2 (.in(prs1), .out(prs2), .reset(clks) );		//40ns 33.3ns 30MHz
	STATUSBFF bff3 (.in(prs2), .out(prs3), .reset(clks) );		//80ns 66.6ns 15MHz
	STATUSBFF bff4 (.in(prs3), .out(prs4), .reset(clks) );		//160ns 133.3ns 7.5MHz
	STATUSBFF bff5 (.in(prs4), .out(prs5), .reset(clks) );		//320ns 266.6ns 3.75MHz
	STATUSBFF bff6 (.in(prs5), .out(prs6), .reset(clks) );		//640ns 1.875MHz
	STATUSBFF bff7 (.in(prs6), .out(prs7), .reset(clks) );		//1.28us 937.5KHz
	STATUSBFF bff8 (.in(prs7), .out(prs8), .reset(clks) );		//2.56us 468.75KHz
	STATUSBFF bff9 (.in(prs8), .out(prs9), .reset(clks) );		//5.12us 234.375KHz
	STATUSBFF bff10 (.in(prs9), .out(prs10), .reset(clks) );	//10.24us 117.1875KHz
	STATUSBFF bff11 (.in(prs10), .out(prs11), .reset(clks) );	//20.48us 58.59375KHz
	STATUSBFF bff12 (.in(prs11), .out(prs12), .reset(clks) );	//40.96us 29.296875KHz
	STATUSBFF bff13 (.in(prs12), .out(prs13), .reset(clks) );	//81.92us 14.6484375KHz
	STATUSBFF bff14 (.in(prs13), .out(prs14), .reset(clks) );	//163us 7.32421875KHz
	STATUSBFF bff15 (.in(prs14), .out(prs15), .reset(clks) );	//326us 3.662109375KHz
	STATUSBFF bff16 (.in(prs15), .out(prs16), .reset(clks) );	//652us 1.8310546875KHz
	always @(negedge prs16 or posedge clks) begin			//1.3ms 1.1ms(1.09ms) 916Hz(0.91552734375KHz)
		if (clks) out <= 1'b0;
		else      out <= 1'b1;
	end

endmodule

//***************************************************************************************//
//*信号状態検出回路                                                                     *//
//*78K0R modify at taketoshi.ide 2005/05/24                                             *//
//***************************************************************************************//
module STATUS3S(in, out, reset);
	input in, reset;
	output out;
	reg out;
	wire prs27;
	STATUSBFF bff1 (.in(in), .out(prs1), .reset(reset) );		//20ns
	STATUSBFF bff2 (.in(prs1), .out(prs2), .reset(reset) );		//40ns
	STATUSBFF bff3 (.in(prs2), .out(prs3), .reset(reset) );		//80ns
	STATUSBFF bff4 (.in(prs3), .out(prs4), .reset(reset) );		//160ns
	STATUSBFF bff5 (.in(prs4), .out(prs5), .reset(reset) );		//320ns
	STATUSBFF bff6 (.in(prs5), .out(prs6), .reset(reset) );		//640ns
	STATUSBFF bff7 (.in(prs6), .out(prs7), .reset(reset) );		//1.28us
	STATUSBFF bff8 (.in(prs7), .out(prs8), .reset(reset) );		//2.56us
	STATUSBFF bff9 (.in(prs8), .out(prs9), .reset(reset) );		//5.12us
	STATUSBFF bff10 (.in(prs9), .out(prs10), .reset(reset) );	//10.24us
	STATUSBFF bff11 (.in(prs10), .out(prs11), .reset(reset) );	//20.48us
	STATUSBFF bff12 (.in(prs11), .out(prs12), .reset(reset) );	//40.96us
	STATUSBFF bff13 (.in(prs12), .out(prs13), .reset(reset) );	//81.92us
	STATUSBFF bff14 (.in(prs13), .out(prs14), .reset(reset) );	//163us
	STATUSBFF bff15 (.in(prs14), .out(prs15), .reset(reset) );	//326us
	STATUSBFF bff16 (.in(prs15), .out(prs16), .reset(reset) );	//652us
	STATUSBFF bff17 (.in(prs16), .out(prs17), .reset(reset) );	//1.304ms
	STATUSBFF bff18 (.in(prs17), .out(prs18), .reset(reset) );	//2.6ms
	STATUSBFF bff19 (.in(prs18), .out(prs19), .reset(reset) );	//5.2ms
	STATUSBFF bff20 (.in(prs19), .out(prs20), .reset(reset) );	//10.4ms
	STATUSBFF bff21 (.in(prs20), .out(prs21), .reset(reset) );	//20.8ms
	STATUSBFF bff22 (.in(prs21), .out(prs22), .reset(reset) );	//41.6ms
	STATUSBFF bff23 (.in(prs22), .out(prs23), .reset(reset) );	//83.2ms
	STATUSBFF bff24 (.in(prs23), .out(prs24), .reset(reset) );	//166.4ms
	STATUSBFF bff25 (.in(prs24), .out(prs25), .reset(reset) );	//333ms
	STATUSBFF bff26 (.in(prs25), .out(prs26), .reset(reset) );	//666ms
	STATUSBFF bff27 (.in(prs26), .out(prs27), .reset(reset) );	//1.33s
	always @(negedge prs27 or posedge reset) begin			//2.66s
		if (reset) out <= 1'b0;
		else       out <= 1'b1;
	end

endmodule

//***************************************************************************************//
//*クロックセンス回路                                                                   *//
//*60MHzのクロック2^16個の幅(1092266ns)中にBASECKが何クロック入っているかをカウントする *//
//*周波数(MHz)＝カウント値×60(MHz)/2^16                                                *//
//***************************************************************************************//
module STATUS_CLOCKSENCE (baseck, ck60mhz, sysrsoutb, hltst, stpst, countbuf, data_set_end);

	input		baseck, ck60mhz, sysrsoutb, hltst, stpst;
	output	[15:0]	countbuf;
	output		data_set_end;

	reg		start_eg1, start_eg2, bufen, data_set_end;
	reg		cpuhalf, fst1, fst2, clock_change;
	reg	[15:0]	count, countbuf;
	reg	[7:0]	cntf, cntfa;
	wire		start, prs16;

//***************************************************************************************
//*クロック検出制御部
//***************************************************************************************
	//2^16個の幅である立ち上がりエッジ検出回路
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			start_eg1 <= 1'b0;
			start_eg2 <= 1'b0;
		end
		else begin
			start_eg1 <= prs16;
			start_eg2 <= start_eg1;
		end
	end
	assign start = start_eg1 & !start_eg2;

	//カウンタバッファに移す為のタイミング作成
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			bufen <= 1'b0;
			data_set_end <= 1'b0;
		end
		else if (hltst | stpst | clock_change) begin
			bufen <= 1'b0;
			data_set_end <= 1'b0;
		end
		else if (start) begin
			if (!bufen) bufen <= 1'b1;
			else        data_set_end <= 1'b1;
		end
	end

	//BASECKのカウンタ作成
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) count <= 16'h0000;
		else if (start) count <= 16'h0001;
		else            count <= count + 1;
	end

	//BASECKのカウンタバッファ作成
	always @(posedge baseck or negedge sysrsoutb) begin
		if      (!sysrsoutb)    countbuf <= 16'h0000;
		else if (start & bufen) countbuf <= count;
	end

//***************************************************************************************
//　60MHzクロックの2^16幅信号の作成
//***************************************************************************************
	STATUSBFF bff1 (.in(ck60mhz), .out(prs1), .reset(!sysrsoutb) );	// 2^1
	STATUSBFF bff2  (.in(prs1),  .out(prs2),  .reset(!sysrsoutb) );	// 2^2
	STATUSBFF bff3  (.in(prs2),  .out(prs3),  .reset(!sysrsoutb) );	// 2^3
	STATUSBFF bff4  (.in(prs3),  .out(prs4),  .reset(!sysrsoutb) );	// 2^4
	STATUSBFF bff5  (.in(prs4),  .out(prs5),  .reset(!sysrsoutb) );	// 2^5
	STATUSBFF bff6  (.in(prs5),  .out(prs6),  .reset(!sysrsoutb) );	// 2^6
	STATUSBFF bff7  (.in(prs6),  .out(prs7),  .reset(!sysrsoutb) );	// 2^7
	STATUSBFF bff8  (.in(prs7),  .out(prs8),  .reset(!sysrsoutb) );	// 2^8
	STATUSBFF bff9  (.in(prs8),  .out(prs9),  .reset(!sysrsoutb) );	// 2^9
	STATUSBFF bff10 (.in(prs9),  .out(prs10), .reset(!sysrsoutb) );	// 2^10
	STATUSBFF bff11 (.in(prs10), .out(prs11), .reset(!sysrsoutb) );	// 2^11
	STATUSBFF bff12 (.in(prs11), .out(prs12), .reset(!sysrsoutb) );	// 2^12
	STATUSBFF bff13 (.in(prs12), .out(prs13), .reset(!sysrsoutb) );	// 2^13
	STATUSBFF bff14 (.in(prs13), .out(prs14), .reset(!sysrsoutb) );	// 2^14
	STATUSBFF bff15 (.in(prs14), .out(prs15), .reset(!sysrsoutb) );	// 2^15
	STATUSBFF bff16 (.in(prs15), .out(prs16), .reset(!sysrsoutb) );	// 2^16

//***************************************************************************************
//*クロックが変更された事を検出する回路
//***************************************************************************************
	//BASECKの２クロック分の幅を計る為の分周期
	always @(posedge baseck or negedge sysrsoutb) begin
		if (!sysrsoutb) cpuhalf <= 1'b0;
		else            cpuhalf <= !cpuhalf;
	end

	//cpuhalfをCK60MHzで同期させる。
	always @(posedge ck60mhz or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			fst1 <= 1'b0;
			fst2 <= 1'b0;
		end
		else begin
			fst1 <= cpuhalf;
			fst2 <= fst1;
		end
	end

	//カウンタ作成
	always @(posedge ck60mhz or negedge sysrsoutb) begin
		if      (!sysrsoutb)    cntf <= 8'h00;
		else if (fst1 & !fst2)  cntf <= 8'h00;
		else if (cntf != 8'hff) cntf <= cntf + 1;
	end

	//カウンタのバッファ作成
	always @(posedge ck60mhz or negedge sysrsoutb) begin
		if      (!sysrsoutb)   cntfa <= 8'h00;
		else if (fst1 & !fst2) cntfa <= cntf;
	end

	//クロックが途中で切り替わった事を示す信号作成
	always @(posedge ck60mhz or negedge sysrsoutb) begin
		if      (!sysrsoutb)   clock_change <= 1'b0;
		else if (fst1 & !fst2) begin
			if (cntf > cntfa + 1 || cntf < cntfa -1) clock_change <= 1'b1;
			else                                     clock_change <= 1'b0;
		end
	end

endmodule

module STATUSBFF(in, out, reset);
	input in, reset;
	output out;
	reg out;
	always @(negedge in or posedge reset) begin
		if (reset) out <= 1'b0;
		else       out <= !out;
	end
endmodule

