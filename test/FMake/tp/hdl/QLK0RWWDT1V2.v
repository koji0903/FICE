//---------------------------------------------------------------------
//
//      [NEC Electronics Group CONFIDENTIAL]
//      (C) Copyright NEC Electronics Corporation 2008 2009
//      All Rights Reserved. Do not duplicate without prior written
//      consent of NEC Electronics Corporation.
//
//      Macro Name      : QLK0RWWDT1V2
//      Version         : 2.01Beta13
//      Date            : 2010.06.02
//      Author          : Masahiro.Minami(m.minami@nms.necel.com)
//                        Hisashi.Abe(hisashi.abe@nms.necel.com)
//      History         : 1.20      2008/05/08 CF (qlk0rwwdt1v1_1_mf2.hdl_080508)
//                        2.00Beta1 2009/08/19 Ver2.00 DF for V2.00
//                        mf3_2.00Beta1  2009/10/21 Ver2.00 for MF3
//                        mf3_2.00Beta7  2009/11/13 Ver2.00 for MF3
//                        mf3_2.00Beta8  2009/11/17 WDTCKI(wdtcki)->WDTCLK(wdtclk) chenged. //Y.koga 
//                        mf3_2.00Beta9  2009/11/19 asy_res logic chenged.(glich countermesure) //Y.koga 
//                        mf3_2.00Beta10 2009/11/20 inlvl CS101 count fixed. //Y.koga 
//                        mf3_2.00Beta11 2009/11/24 del. cksel1 in QLK0RWWDT1V2_ASYRES module //Y.koga 
//                        mf3_2.00Beta12 2009/11/24 modi. ASY_RES in SVMOD mode //Y.koga 
//                        mf3_2.00Beta13 2010/06/03 modi. for v2.1  //Y.koga 
//                        mf3_2.00Beta14 2010/08/07 modified by M.minami 
//
//---------------------------------------------------------------------

module QLK0RWWDT1V2 (
	PCLKRW,       // PCLK -> PCLKRW ('10.06.02)
	PRESETZ,
//	PADDR7,			//v1.10 del by M.Hashimoto
//	PADDR6,
//	PADDR5,
//	PADDR4,
//	PADDR3,
//	PADDR2,
//	PADDR1,
//	PADDR0,
	PWDATA15,
	PWDATA14,
	PWDATA13,
	PWDATA12,
	PWDATA11,
	PWDATA10,
	PWDATA9,
	PWDATA8,
	PRDATA15,
//	PRDATA14,///// Beta15 deleted by M.minami in 2010/08/07
//	PRDATA13,///// Beta15 deleted by M.minami in 2010/08/07
	PRDATA12,
	PRDATA11,
//	PRDATA10,///// Beta15 deleted by M.minami in 2010/08/07
	PRDATA9,
//	PRDATA8,///// Beta15 deleted by M.minami in 2010/08/07
	PWRITE,
	PENABLE,
	PSEL,
	WDEN,     //modi. OPWDEN -> WDEN ('10.06.03)
	OPWDCS0,
	OPWDCS1,
	OPWDCS2,
	OPWDWS1,
	OPWDWS0,
	OPWDINT,
	OPWDSTBY,
//	HLTST,          // del. ('10.06.03)
//	STPST,          // del. ('10.06.03)
	CPUSTART,       // add. ('10.06.03)
	SCANMODE,       // add. ('10.06.03)
	SVMOD,
	SPRGMOD,
	WDTRES,
	INTWWDT,
//	OCDMOD,          // add ver1.20 //del.('10.06.21) 

        WDTCLK,          // add ver2.00
        WDTTESCK,        // add ver2.00
        WDTTEN,	         // add ver2.00             
        WDTMON	         // add ver2.00             

	);


input			PCLKRW;      // PCLK -> PCLKRW (V2.1,'10.06.02)
input			PRESETZ;
//input			PADDR7;			//v1.10 del by M.Hashimoto
//input			PADDR6;
//input			PADDR5;
//input			PADDR4;
//input			PADDR3;
//input			PADDR2;
//input			PADDR1;
//input			PADDR0;
input			PWDATA15;
input			PWDATA14;
input			PWDATA13;
input			PWDATA12;
input			PWDATA11;
input			PWDATA10;
input			PWDATA9;
input			PWDATA8;
output			PRDATA15;
//output		PRDATA14;///// Beta15 deleted by M.minami in 2010/08/07
//output		PRDATA13;///// Beta15 deleted by M.minami in 2010/08/07
output			PRDATA12;
output			PRDATA11;
//output		PRDATA10;///// Beta15 deleted by M.minami in 2010/08/07
output			PRDATA9;
//output		PRDATA8;///// Beta15 deleted by M.minami in 2010/08/07
input			PWRITE;
input			PENABLE;
input			PSEL;
input			WDEN;     // modi. OPWDEN -> WDEN ('10.06.03)
input			OPWDCS0;
input			OPWDCS1;
input			OPWDCS2;
input			OPWDWS1;
input			OPWDWS0;
input			OPWDINT;
input			OPWDSTBY;
// input		HLTST;     // del. ('10.06.03)
// input		STPST;     // del. ('10.06.03)
input			CPUSTART;  // add. ('10.06.03)
input			SCANMODE;  // add. ('10.06.03)
input			SVMOD;
input			SPRGMOD;
output			WDTRES;
output			INTWWDT;
// input		OCDMOD;			//v1.20 add  // del. ('10.06.21) 
input                   WDTCLK;                 //add ver2.00
input                   WDTTESCK;               //add ver2.00
input			WDTTEN;         	//add ver2.00
output			WDTMON;         	//add ver2.00

wire	[7:0]  din;
wire           we_wdte ;

wire    [2:0]  opwdcs; 
wire    [1:0]  opwdws; 



QLK0RWWDT1V2_MAIN	main	(
	.din(din[7:0]),
	.we_wdte(we_wdte),
	.res_b(PRESETZ),
//	.cksel1(CKSEL1),
	.scanmode(SCANMODE),   // add. ('10.06.03)
	.cpustart(CPUSTART),   // add. ('10.06.03)
	.svmod(SVMOD),
	.sprgmod(SPRGMOD),
	.pclkrw(PCLKRW),       // PCLK(pclk) -> PCLKRW(pclkrw) ('10.06.02)
//	.op_clksel({OPWDCS2, OPWDCS1, OPWDCS0}),      //for LEDA 
//	.op_window({OPWDWS1, OPWDWS0}),               //for LEDA
        .op_clksel(opwdcs[2:0]),
        .op_window(opwdws[1:0]),
	.op_en(WDEN),         // modi. OPWDEN -> WDEN ('10.06.02)
	.op_int(OPWDINT),
        .op_stby(OPWDSTBY),
//	.hltst(HLTST),        // del. ('10.06.03)
//	.stpst(STPST),        // del. ('10.06.03)
	.wdtres(WDTRES),
//	.int0(INTWWDT),
	.intwwdt(INTWWDT),
//	.ocdmod(OCDMOD),      // del. ('10.06.21)
        .wdtclk(WDTCLK),
        .wdttesck(WDTTESCK),
	.wdtten(WDTTEN),
	.wdtmon(WDTMON)
	) ;


QLK0RWWDT1V2_BI	bi	(
	.rdata15(PRDATA15),
	.rdata12(PRDATA12),
	.rdata11(PRDATA11),
	.rdata9 (PRDATA9),
	.wdata({PWDATA15, PWDATA14, PWDATA13, PWDATA12,
	        PWDATA11, PWDATA10, PWDATA9 , PWDATA8 }
	      ),
//	.addr({PADDR7, PADDR6, PADDR5, PADDR4,			//v1.10 del by M.Hashimoto
//	       PADDR3, PADDR2, PADDR1, PADDR0}
//	     ),
	.PSEL(PSEL),
	.PWRITE(PWRITE),
	.PENABLE(PENABLE),
	.din(din[7:0]),
	.we_wdte(we_wdte),
	.op_en(WDEN)     // modi. OPWDEN -> WDEN ('10.06.03)
	) ;

// clamp PRDATA always low
//assign PRDATA14	= 1'b0;///// Beta15 deleted by M.minami in 2010/08/07
//assign PRDATA13	= 1'b0;///// Beta15 deleted by M.minami in 2010/08/07
//assign PRDATA10	= 1'b0;///// Beta15 deleted by M.minami in 2010/08/07
//assign PRDATA8	= 1'b0;///// Beta15 deleted by M.minami in 2010/08/07

//

assign opwdcs  = {OPWDCS2, OPWDCS1, OPWDCS0};
assign opwdws  = {OPWDWS1, OPWDWS0} ;

endmodule

//===================================================================================================================
//   WWDT0 MAIN BLOCK
//===================================================================================================================

module QLK0RWWDT1V2_MAIN	(
	din,
	we_wdte,
	res_b,
//	cksel1,
	scanmode,    // add. ('10.06.03)
	cpustart,    // add. ('10.06.03)
	svmod,
	sprgmod,
	pclkrw,      // pclk -> pclkrw ('10.06.02)
	op_clksel,
	op_window,
	op_en,
	op_int,
	op_stby,
//	hltst,       // del. ('10.06.03)
//	stpst,       // del. ('10.06.03)
	wdtres,
//	int0,
	intwwdt,
//	ocdmod,          //ver1.20  // del. ('10.06.21)
        wdtclk,          //ver2.00
        wdttesck,        //ver2.00
        wdtten,          //ver2.00
        wdtmon           //ver2.00
	) ;

input	[7:0]	din;
input		we_wdte;
input		res_b;
//input		cksel1;
input		scanmode;   // add. ('10.06.03)
input		cpustart;   // add. ('10.06.03)
input		svmod;
input		sprgmod;
input		pclkrw;     //  pclk -> pclkrw ('10.06.02)
input	[2:0]	op_clksel;
input	[1:0]	op_window;
input		op_en;
input		op_int;
input		op_stby;
//input		hltst;  // del.  ('10.06.03)
//input		stpst;  // del.  ('10.06.03)
//input		ocdmod; // del.  ('10.06.21)
input           wdtclk;
input           wdttesck;
input		wdtten;
output		wdtres;
//output		int0;
output		intwwdt;
output          wdtmon;

reg		counter_clear_m, counter_clear_s;
wire	[16:0]	counter;
reg		ctovf, win_open0, win_open1, win_open0_s, win_open1_s, wdte_next;
reg		err_wdte_access;
reg		intvl;
//wire		int0;
wire		intwwdt;
wire            wdtres;
//wire            scanmode;
wire            pclkrw;    // add. pclkrw ('10.06.02)
wire            pclk;
wire            wdtclk;
wire            wdttesck;
wire            wdtten;
wire            wdtmon;

wire            cksel1;

wire 		ASY_RES, pre_ASY_RES;


//=========  counter async clear by HLTST or STPST (Add by M.Hashimoto)  ============================================

wire			pre_cntclr;
wire			cntclr;
//assign pre_cntclr	= !op_stby & (hltst || stpst);  // del. ('10.06.03)
assign pre_cntclr	= !op_stby & !cpustart ;        // add. ('10.06.03)
assign cntclr		= res_b & (!pre_cntclr | wdtten);

// --- SCAN Moniter For faults coverage
reg	monitor_wwdt;
always @ (posedge wdttesck or negedge res_b) begin  // modi. pclk -> wdttesck ('10.06.03)
	if (!res_b) begin
		monitor_wwdt	<= 1'b0;
	end
	else begin
		monitor_wwdt	<= pre_cntclr ^ pre_ASY_RES ;
	end
end


//=========  module stop by SVMOD or SPRGMOD (Add by M.Hashimoto)  ==================================================

// --- Ver1.10 Addition ---
reg	svmod_wdt;
wire	m_stop_clr;

always @ (negedge cksel1 or negedge res_b) begin
	if (!res_b) begin
		svmod_wdt		<= 1'b0;
	end
	else begin
		svmod_wdt		<= svmod;
	end
end

wire   m_stop;
//assign m_stop	= svmod | sprgmod;

///////////////////////assign m_stop	= svmod_wdt | sprgmod;///// Beta14 modified by M.minami in 2010/08/07
assign m_stop     = svmod | sprgmod;                          ///// Beta14 modified by M.minami in 2010/08/07

// --- Ver1.20 EMS Measures ---
// wire   svmod_ems; // del. ('10.06.21) 
// assign svmod_ems	=  svmod_wdt & ocdmod;  // del. ('10.06.21)
// assign m_stop_clr	=  m_stop | svmod_ems;  // del. ('10.06.21)  
assign m_stop_clr       =  svmod_wdt | sprgmod; ///// Beta14 modified by M.minami in 2010/08/07


// ----------------------------
// del for ver2.00 by abe 
//=========  wdt counter clock signal  ==============================================================================
//
//del by M.Hashimoto
//	assign cksel1 = (tesen | scanmode) ? tclk : (cksel1 & op_en);
//
//Add by M.Hashimoto
//	assign wdclk = cksel1;
//
//===================================================================================================================
//========= ver2.00 counter clock signal ============================================================================

QLK0RWWDT1V2_CLKSEL wdtclksel(.wdtclk(wdtclk), .wdttesck(wdttesck), .wdtten(wdtten), .cksel1(cksel1)); 
QLK0RWWDT1V2_CLKSEL pclksel(.wdtclk(pclkrw), .wdttesck(wdttesck), .wdtten(scanmode), .cksel1(pclk));     // add. for SCAN ('10.06.02)

//=========  wdt counter clear signal  ==============================================================================

        wire counter_clear_x ;
        assign counter_clear_x  = counter_clear_s & cksel1 ;
//
	wire wdte_clr = !res_b | (counter_clear_x & !scanmode);
//	wire wdte_clr = !res_b | (counter_clear_x & !wdtten);

	//synopsys async_set_reset "wdte_clr"
	always @ (posedge pclk or posedge wdte_clr) begin
		if      (wdte_clr)                counter_clear_m <= 1'b0;
		else if (din == 8'hac && we_wdte && (!m_stop)) counter_clear_m <= 1'b1;
	end
	//synopsys async_set_reset "res_b"
	always @ (negedge cksel1 or negedge res_b) begin
		if (!res_b) counter_clear_s <= 1'b0;
		else if (op_en && (!m_stop_clr))	counter_clear_s <= counter_clear_m;		//for power compiler gating -- add by M.hashimoto
	end
//
// del for ver2.00 by abe 
//=========  wdt counter binary counter ===========================================================================================
//
// for modify counter  
//
//        always @ (posedge cksel1 or negedge cntclr) begin
//                if (!cntclr) begin
//                      counter[17:14] <= 4'h0;
//                end
//                else if (op_en && (!m_stop)) begin                      //
//                        if (counter_clear_s) begin
//				counter[17:14] <= 4'h0;
//                        end
//                        else if (counter[13:0]==14'h3FFF)	begin
//				counter[17:14] <= counter[17:14] + 4'h1;
//                        end
//                end
//        end
//
//========  ver2.00 wdt binary counter module ===========================================================

assign wdtmon  = counter[16] & wdtten;

//wire [16:0] wd_cnt = {(~(counter[16:1])),counter[0]^(op_en & (~m_stop))}; 
wire [16:0] wd_cnt = {(~(counter[16:1])),counter[0]^(op_en & (~m_stop_clr))};  // modi. for prevent counter unknown ( m_stop -> m_stop_clr )
wire [16:0] ck_cnt = {(~(counter[15:0])),cksel1};

//wire ASY_RES = cntclr & ~(((op_en & (~m_stop)) & counter_clear_s) & (~cksel1));

//wire ASY_RES, pre_ASY_RES;
//QLK0RWWDT1V2_ASYRES asyres(.cksel1(cksel1),.cntclr(cntclr),.op_en(op_en), .m_stop(m_stop), .counter_clear_s(counter_clear_s),.asy_res(ASY_RES));
//QLK0RWWDT1V2_ASYRES asyres(.cntclr(cntclr),.op_en(op_en), .m_stop(m_stop), .counter_clear_s(counter_clear_s),.asy_res(ASY_RES));
QLK0RWWDT1V2_ASYRES asyres(.cntclr(!pre_cntclr),.op_en(op_en),.counter_clear_s(counter_clear_s),.asy_res(pre_ASY_RES));

//assign	ASY_RES	= (scanmode)? res_b : pre_ASY_RES ;
assign	ASY_RES	= res_b & (pre_ASY_RES | scanmode) ;

QLK0RWWDT1V2_BCNT bcnt0(.bclk(ck_cnt[0]), .bres(ASY_RES), .wd_bcnt(wd_cnt[0]),.bcnt(counter[0]));
QLK0RWWDT1V2_BCNT1 bcnt1(.bclk(ck_cnt[1]), .bres(ASY_RES), .wd_bcnt(wd_cnt[1]),.bcnt(counter[1]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt2(.bclk(ck_cnt[2]), .bres(ASY_RES), .wd_bcnt(wd_cnt[2]),.bcnt(counter[2]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt3(.bclk(ck_cnt[3]), .bres(ASY_RES), .wd_bcnt(wd_cnt[3]),.bcnt(counter[3]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt4(.bclk(ck_cnt[4]), .bres(ASY_RES), .wd_bcnt(wd_cnt[4]),.bcnt(counter[4]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt5(.bclk(ck_cnt[5]), .bres(ASY_RES), .wd_bcnt(wd_cnt[5]),.bcnt(counter[5]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt6(.bclk(ck_cnt[6]), .bres(ASY_RES), .wd_bcnt(wd_cnt[6]),.bcnt(counter[6]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt7(.bclk(ck_cnt[7]), .bres(ASY_RES), .wd_bcnt(wd_cnt[7]),.bcnt(counter[7]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt8(.bclk(ck_cnt[8]), .bres(ASY_RES), .wd_bcnt(wd_cnt[8]),.bcnt(counter[8]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt9(.bclk(ck_cnt[9]), .bres(ASY_RES), .wd_bcnt(wd_cnt[9]),.bcnt(counter[9]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt10(.bclk(ck_cnt[10]), .bres(ASY_RES), .wd_bcnt(wd_cnt[10]),.bcnt(counter[10]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt11(.bclk(ck_cnt[11]), .bres(ASY_RES), .wd_bcnt(wd_cnt[11]),.bcnt(counter[11]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt12(.bclk(ck_cnt[12]), .bres(ASY_RES), .wd_bcnt(wd_cnt[12]),.bcnt(counter[12]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt13(.bclk(ck_cnt[13]), .bres(ASY_RES), .wd_bcnt(wd_cnt[13]),.bcnt(counter[13]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt14(.bclk(ck_cnt[14]), .bres(ASY_RES), .wd_bcnt(wd_cnt[14]),.bcnt(counter[14]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt15(.bclk(ck_cnt[15]), .bres(ASY_RES), .wd_bcnt(wd_cnt[15]),.bcnt(counter[15]), .smode(scanmode), .sclk(wdttesck));
QLK0RWWDT1V2_BCNT1 bcnt16(.bclk(ck_cnt[16]), .bres(ASY_RES), .wd_bcnt(wd_cnt[16]),.bcnt(counter[16]), .smode(scanmode), .sclk(wdttesck));

//== QLK0RWWDT0V1 v1.10 modify by K.Baba ==
//== QLK0RWWDT1V2 v2.00 modify by abe    ==
//== ctovf = counter[x] ver2.00 // ver1.20 // ver1.1

	always @(op_clksel or counter) begin
		casex ({op_clksel})
			3'b000  : ctovf = counter[6];//[7]; //[10];
			3'b001  : ctovf = counter[7];//[8]; //[11];
			3'b010  : ctovf = counter[8];//[9]; //[12];
			3'b011  : ctovf = counter[9];//[10]; //[13];
			3'b100  : ctovf = counter[11];//[12]; //[15];
			3'b101  : ctovf = counter[13];//[14]; //[17];
			3'b110  : ctovf = counter[14];//[15]; //[18];
			default : ctovf = counter[16];//[17]; //[20];
		endcase
		casex ({op_clksel})
			3'b000  : win_open1 = counter[5];//[6]; //[9];
			3'b001  : win_open1 = counter[6];//[7]; //[10];
			3'b010  : win_open1 = counter[7];//[8]; //[11];
			3'b011  : win_open1 = counter[8];//[9]; //[12];
			3'b100  : win_open1 = counter[10];//[11]; //[14];
			3'b101  : win_open1 = counter[12];//[13]; //[16];
			3'b110  : win_open1 = counter[13];//[14]; //[17];
			default : win_open1 = counter[15];//[16]; //[19];
		endcase
		casex ({op_clksel})
			3'b000  : win_open0 = counter[4];//[5]; //[8];
			3'b001  : win_open0 = counter[5];//[6]; //[9];
			3'b010  : win_open0 = counter[6];//[7]; //[10];
			3'b011  : win_open0 = counter[7];//[8]; //[11];
			3'b100  : win_open0 = counter[9];//[10]; //[13];
			3'b101  : win_open0 = counter[11];//[12]; //[15];
			3'b110  : win_open0 = counter[12];//[13]; //[16];
			default : win_open0 = counter[14];//[15]; //[18];
		endcase
	end

//Add by M.hashimoto
//=========  interval signal  =======================================================================================
//xx10111xx1 = 75%
//        always @(op_clksel or counter) begin
//		casex (op_clksel)
//			3'b000 : intvl = (counter[ 7:0]	==  8'b01011111);
//			3'b001 : intvl = (counter[ 8:0]	==  9'b010111111);
//			3'b010 : intvl = (counter[ 9:0]	== 10'b0101111111);
//			3'b011 : intvl = (counter[10:0]	== 11'b01011111111);
//			3'b100 : intvl = (counter[12:0]	== 13'b0101111111111);
//			3'b101 : intvl = (counter[14:0]	== 15'b010111111111111);
//			3'b110 : intvl = (counter[15:0]	== 16'b0101111111111111);
//			default : intvl = (counter[17:0]	== 18'b010111111111111111);
//		endcase
//	end
//=========  ver2.00 interval signal  =======================================================================================

        always @(op_clksel or counter) begin
              casex (op_clksel)
                       3'b000 : intvl = (counter[ 6:0] ==  7'b0110000);
                       3'b001 : intvl = (counter[ 7:0] ==  8'b01100000);
                       3'b010 : intvl = (counter[ 8:0] ==  9'b011000000);
                       3'b011 : intvl = (counter[ 9:0] == 10'b0110000000);
                       3'b100 : intvl = (counter[11:0] == 12'b011000000000);
                       3'b101 : intvl = (counter[13:0] == 14'b01100000000000);
                       3'b110 : intvl = (counter[14:0] == 15'b011000000000000);
                      default : intvl = (counter[16:0] == 17'b01100000000000000);
              endcase
      end

//assign int0 = intvl & !cksel1 & op_int & (!m_stop);
//wire  int0_pre = intvl & op_en & op_int & (!m_stop);  // 2009/11/13  add op_en signal
wire  int0_pre = intvl & op_en & op_int & (!sprgmod) ;  // 2010/06/04 modi. for glitch prevention at svmod.

// QLK0RWWDT1V2_INT0 int0(.cksel1(cksel1), .int0_pre(int0_pre),.int0(intwwdt));
//QLK0RWWDT1V2_INT0 int0(.cksel1(cksel1), .int0_pre(int0_pre),.int0(intwwdt),.scanmode(scanmode));  // modi. '10.07.16
QLK0RWWDT1V2_INT0 int0(.cksel1(cksel1), .int0_pre(int0_pre),
                       .int0(intwwdt), .scanmode(scanmode), .svmod_wdt(svmod_wdt));  ///// Beta14 modified by M.minami in 2010/08/07

//del for ver 2.00 by abe
/*
	//synopsys async_set_reset "res_b"
	always @ (posedge cksel1 or negedge res_b) begin
		if (!res_b) begin
			int0	<= 1'b0;
		end
		else if (op_en && op_int && (!m_stop)) begin
			int0	<= intvl;
		end
	end
*/

//=========  wdt reset signal  ======================================================================================
/*
//del for ver2.00 by abe
//win_open0,1はwdtclkに同期しているので、BASECK同期に変更しwin_open0_s,win_open1_sを作る。
//最初の１回目はWINDOW=100%とする為に１回目のWDTEの書き込みをラッチwdte_next

	//synopsys async_set_reset "res_b"
	always @ (posedge pclk or negedge res_b) begin
		if (!res_b) begin
			win_open1_s <= 1'b0;
			win_open0_s <= 1'b0;
		end
		else begin
			win_open1_s <= win_open1;
			win_open0_s <= win_open0;
		end
	end
*/
//----------------------------------------------------------------------------------------------

	//synopsys async_set_reset "res_b"
	always @ (posedge pclk or negedge res_b) begin
		if      (!res_b)  wdte_next <= 1'b0;
		else if (we_wdte && (!m_stop)) wdte_next <= 1'b1;
	end

	//synopsys async_set_reset "res_b"
	always @ (posedge pclk or negedge res_b) begin
		if      ( !res_b ) err_wdte_access <= 1'b0;
		else if (we_wdte && (!m_stop)) begin
			if (din != 8'hac) err_wdte_access <= 1'b1;
			else begin
//				casex ({op_stby, wdte_next, op_window, win_open1_s, win_open0_s}) //OPDWSTBY:1 Window:100%
				casex ({op_stby, wdte_next, op_window, win_open1, win_open0}) //OPDWSTBY:1 Window:100%
					6'b11000x : err_wdte_access <= 1'b1;		//Window = 25%
					6'b110010 : err_wdte_access <= 1'b1;		//Window = 25%
					6'b11010x : err_wdte_access <= 1'b1;		//Window = 50%
					6'b111000 : err_wdte_access <= 1'b1;		//Window = 75%
					default  : err_wdte_access <= err_wdte_access;
				endcase
			end
		end
	end

//del for ver 2.00 by abe
//=========  all reset or  =========================================================================================
//	//synopsys async_set_reset "res_b"
//	always @ (posedge cksel1 or negedge res_b) begin
//		if     (!res_b) wdtres <= 1'b0;
////		else if (op_en) wdtres <= ctovf | err_wdte_access | err_cpu_access;
//		else if (op_en && (!m_stop))	wdtres <= ctovf | err_wdte_access;	//err_cpu_access del by M.hashimoto
//	end
//
//=========  ver 2.00 all reset or  =========================================================================================

//assign int0 = int0_pre & !(cksel1 & !scanmode);  // modi. '10.07.16
assign wdtres = ( ctovf | err_wdte_access) & (op_en & (~m_stop_clr));///// Beta14 modified by M.minami in 2010/08/07

endmodule

//====================================================================
// INT0 OUTPUT
//====================================================================


//module QLK0RWWDT1V2_INT0(cksel1,int0_pre,int0,scanmode); // add. scanmode '10.07.16
module QLK0RWWDT1V2_INT0(cksel1,int0_pre,int0,scanmode, svmod_wdt); ///// Beta14 modified by M.minami in 2010/08/07
input   cksel1;
input   int0_pre;
input   scanmode;
input   svmod_wdt;

output  int0;

wire int0;

//////////assign int0 = int0_pre & !(cksel1 & !scanmode);  // modi. '10.07.16
assign int0 = int0_pre & ((!cksel1) | scanmode | svmod_wdt);  ///// Beta14 modified by M.minami in 2010/08/07

endmodule

//====================================================================
// ASY_RES
//====================================================================

//module QLK0RWWDT1V2_ASYRES(cntclr,op_en,m_stop,counter_clear_s,asy_res);
module QLK0RWWDT1V2_ASYRES(cntclr,op_en,counter_clear_s,asy_res);
input   cntclr;
input   op_en;
// input   m_stop;
input   counter_clear_s;
output  asy_res;

wire asy_res;

// assign asy_res = cntclr & ~(((op_en & (~m_stop)) & counter_clear_s) & (~cksel1));
// assign asy_res = cntclr & (((op_en & (~m_stop)) & ~(counter_clear_s)));
assign asy_res = cntclr & (op_en  & (~counter_clear_s));   // '09.11.24 Beta12


endmodule


//====================================================================
// BINARY COUNTER
//====================================================================

module QLK0RWWDT1V2_BCNT1(bclk,bres,wd_bcnt,bcnt,smode,sclk);	// add 20100604
input  bclk;
input  bres;
input  wd_bcnt;
input	smode, sclk ;
output bcnt;

reg    bcnt;

wire	bclk_scan;

assign	bclk_scan = (smode)? sclk : bclk ;

always@(posedge bclk_scan or negedge bres)begin
  if(!bres)begin
    bcnt <= 1'b0;
  end
  else begin 
    bcnt <= wd_bcnt;

  end
end

endmodule

module QLK0RWWDT1V2_BCNT(bclk,bres,wd_bcnt,bcnt);
input  bclk;
input  bres;
input  wd_bcnt;
output bcnt;

reg    bcnt;

always@(posedge bclk or negedge bres)begin
  if(!bres)begin
    bcnt <= 1'b0;
  end
  else begin 
    bcnt <= wd_bcnt;

  end
end

endmodule

//===================================================================
//  WWDT CKSEL module
//===================================================================

module QLK0RWWDT1V2_CLKSEL(wdtclk,wdttesck,wdtten,cksel1);
input  wdtclk;
input  wdttesck;
input  wdtten;
output cksel1;

wire cksel1;

assign cksel1 = wdtten ? wdttesck:wdtclk;

endmodule 

//===================================================================================================================
//  WWDT0 BI BLOCK
//===================================================================================================================

//-- add by M.Hashimoto
module	QLK0RWWDT1V2_BI	(
		rdata15,
		rdata12,
		rdata11,
		rdata9,
		wdata,
//		addr,			//v1.10 del by M.Hashimoto
		PSEL,
		PWRITE,
		PENABLE,
		din,
		we_wdte,
		op_en
				) ;

output			rdata15;
output			rdata12;
output			rdata11;
output			rdata9;
input	[7:0]	wdata;
//input	[7:0]	addr;			//v1.10 del by M.Hashimoto
input			PSEL;
input			PWRITE;
input			PENABLE;
output	[7:0]	din;
output			we_wdte;
input			op_en;


//wire			ad_wdte ;			//v1.10 del by M.Hashimoto
wire			rd_en ;
wire			sel_wdte ;

assign sel_wdte	= PSEL;

//========== assign write strobe ====================================================================================

assign we_wdte	= (sel_wdte && PWRITE && PENABLE);

//========== assign bus output driver ===============================================================================

//  sfrbus Read/Write control


//add by M.Hashimoto
assign rd_en	= ((!PWRITE) && PENABLE && sel_wdte);

//WDTE read = 9AH or 1AH
//divide data bus for inner clamp deleted & top clamped when design compiler
assign rdata15	= rd_en & op_en;
assign rdata12	= rd_en;
assign rdata11	= rd_en;
assign rdata9	= rd_en;

assign din	= wdata;		//odd address

endmodule

