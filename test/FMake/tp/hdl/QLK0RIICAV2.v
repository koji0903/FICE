// [NEC Electronics Group CONFIDENTIAL]
// (C) Copyright NEC Electronics Corporation 2009
// All Rights Reserved. Do not duplicate without prior written
// consent of NEC Electronics Corporation.
//
// Macro Name      : QLK0RIICAV2
// Version         : 2.10
// Date            : 2010.02.07
// Author          : Motoo.Akasaka(m.akasaka@nms.necel.com)
// History         : 0.00      2009/09/25 DF1
//                 : 0.01      2009/11/02 DF2
//                 : 0.02      2009/12/11 DF3
//		   : 2.00	2010/01/29
//		   : 2.10      2010/02/07
//
  
module QLK0RIICAV2 (
        PCLK,                           // Mod 20091111  PECLK -> PCLK
        PCLKRW,                         // Add 20091111
        PRESETZ,                        // Mod 20091111  PERESETZ -> PRESETZ
        CK0,                            // Add 20091111
	SCANCLK,			// Add 20091205
	PADDR2,
	PADDR1,
	PADDR0,
	PWDATA15,
	PWDATA14,
	PWDATA13,
	PWDATA12,
	PWDATA11,
	PWDATA10,
	PWDATA9,
	PWDATA8,
	PWDATA7,
	PWDATA6,
	PWDATA5,
	PWDATA4,
	PWDATA3,
	PWDATA2,
	PWDATA1,
	PWDATA0,
	PRDATA15,
	PRDATA14,
	PRDATA13,
	PRDATA12,
	PRDATA11,
	PRDATA10,
	PRDATA9,
	PRDATA8,
	PRDATA7,
	PRDATA6,
	PRDATA5,
	PRDATA4,
	PRDATA3,
	PRDATA2,
	PRDATA1,
	PRDATA0,
	PWRITE,
	PENABLE,
	PSEL1,        // ONW Modified
	PSEL0,        // ONW Modified
	SCANMODE,
	SVMOD,
       PRS0,                           // Add 20091111
	SCLI0,
	SCLI1,
	SDAI0,
	SDAI1,
	SCLO0,
	SDAO0,
	SCLO1,
	SDAO1,
	INTIIC0,
	SCANEN				// Add 20091210
	); 

input                   PCLK;                   // Mod 20091111 PECLK -> PCLK
input                   PCLKRW;                 // Add 20091111
input                   PRESETZ;                // Mod 20091111 PERESETZ -> PRESETZ
input                   CK0;                    // Add 20091111
input			SCANCLK;		// Add 20091205
input			PADDR2;
input			PADDR1;
input			PADDR0;
input			PWDATA15;
input			PWDATA14;
input			PWDATA13;
input			PWDATA12;
input			PWDATA11;
input			PWDATA10;
input			PWDATA9;
input			PWDATA8;
input			PWDATA7;
input			PWDATA6;
input			PWDATA5;
input			PWDATA4;
input			PWDATA3;
input			PWDATA2;
input			PWDATA1;
input			PWDATA0;
output			PRDATA15;
output			PRDATA14;
output			PRDATA13;
output			PRDATA12;
output			PRDATA11;
output			PRDATA10;
output			PRDATA9;
output			PRDATA8;
output			PRDATA7;
output			PRDATA6;
output			PRDATA5;
output			PRDATA4;
output			PRDATA3;
output			PRDATA2;
output			PRDATA1;
output			PRDATA0;
input			PWRITE;
input			PENABLE;
input			PSEL1;        // ONW Modified
input			PSEL0;        // ONW Modified
input			SCANMODE;
input			SVMOD;
output                  PRS0;                   // 20091111 Add
input			SCLI0;
input			SCLI1;
input			SDAI0;
input			SDAI1;
output			SCLO0;
output			SDAO0;
output			SCLO1;
output			SDAO1;
output			INTIIC0;

input			SCANEN;

//--- wire
wire            iice;
wire	[15:0]	din;
wire	[15:0]	dout;
wire    [7:0]   iica_s;
wire    [7:1]   sva;

wire            PECLK, exc_s, coi_s, trc_s, wait_s, sdao_s,re_iicc0, re_iicf0;
wire            re_iic0, re_sva0, re_iiccl0, re_iicwl0, re_iicwh0, re_iics0, re_iicse0;
wire            we_iic0, we_iicf0, we_iicc0, we_sva0, we_iiccl0, we_iicwl0, we_iicwh0;



////////// ONW Modified //////////////

/*		Delete 20091205
wire top_clkgate_en;
assign top_clkgate_en = PSEL0 | PSEL1 | iice;
TBGTSMLALADPCLX2 tbgtsmlaladpclx2 (
     .N01      (clg_peclk),
     .N02      (),
     .H01      (top_clkgate_en),
     .H02      (PECLK),
     .H03      (SCANMODE)
);

*/

// Manual ICG           Add 20091118
QLK0RIICAV2_MICG_GATE   micg_gate_0 (
        .CLK(PCLK),
        .CEN(CK0),
        .SMC(SCANEN),
        .GCLK(PECLK)
        );


//--- module connect

QLK0RIICAV2_SUB sub (
     .PECLK    (SCANCLK ),
     .PERESETZ (PRESETZ ),
     .SCANMODE (SCANMODE ),
     .SVMOD    (SVMOD    ),
     .SCL      (SCLI1 ),
     .SDA      (SDAI1 ),
     .iice     (iice  ),
     .sva      (sva   ),
     .exc_s    (exc_s ),
     .coi_s    (coi_s ),
     .trc_s    (trc_s ),
     .wait_s   (wait_s),
     .iica_s   (iica_s),
     .sdao_s   (sdao_s)
     );
////////// ONW Modified //////////////



QLK0RIICAV2_APBBI apbbi	(
	.addr({PADDR2, PADDR1, PADDR0}),
	.wdata({PWDATA15, PWDATA14, PWDATA13, PWDATA12,
	        PWDATA11, PWDATA10, PWDATA9 , PWDATA8 ,
	        PWDATA7 , PWDATA6 , PWDATA5 , PWDATA4 ,
	        PWDATA3 , PWDATA2 , PWDATA1 , PWDATA0}
	      ),
	.rdata({PRDATA15, PRDATA14, PRDATA13, PRDATA12,
	        PRDATA11, PRDATA10, PRDATA9 , PRDATA8 ,
	        PRDATA7 , PRDATA6 , PRDATA5 , PRDATA4 ,
	        PRDATA3 , PRDATA2 , PRDATA1 , PRDATA0 }
	      ),
	.PWRITE(PWRITE),
	.PENABLE(PENABLE),
	.PSEL({PSEL1,PSEL0}),        // ONW Modified

	.re_iic0(re_iic0),
	.re_iicf0(re_iicf0),
	.re_iicc0(re_iicc0),
	.re_sva0(re_sva0),
	.re_iiccl0(re_iiccl0),
//	.re_iicx0(re_iicx0),
	.re_iicwl0(re_iicwl0),        // ONW Modified
	.re_iicwh0(re_iicwh0),        // ONW Modified
	.re_iics0(re_iics0),
	.re_iicse0(re_iicse0),
	.we_iic0(we_iic0),
	.we_iicf0(we_iicf0),
	.we_iicc0(we_iicc0),
	.we_sva0(we_sva0),
	.we_iiccl0(we_iiccl0),
//	.we_iicx0(we_iicx0),
	.we_iicwl0(we_iicwl0),        // ONW Modified
	.we_iicwh0(we_iicwh0),        // ONW Modified

	.din(din),
	.dout(dout)
	);



QLK0RIICAV2_MAIN main	(
	.PCLK(PCLK),
	.PECLK(PECLK),
	.PCLKRW(PCLKRW),
	.PERESETZ(PRESETZ),
//	.SCANMODE(SCANMODE),		// Mod 20091209 -5
	.SVMOD(SVMOD),			// Mod 20091207 -2

	.re_iic0(re_iic0),
	.re_iicf0(re_iicf0),
	.re_iicc0(re_iicc0),
	.re_sva0(re_sva0),
	.re_iiccl0(re_iiccl0),
//	.re_iicx0(re_iicx0),
	.re_iics0(re_iics0),
	.re_iicse0(re_iicse0),
	.re_iicwl0(re_iicwl0),        // ONW Modified
	.re_iicwh0(re_iicwh0),        // ONW Modified
	.we_iic0(we_iic0),
	.we_iicf0(we_iicf0),
	.we_iicc0(we_iicc0),
	.we_sva0(we_sva0),
	.we_iiccl0(we_iiccl0),
//	.we_iicx0(we_iicx0),
	.we_iicwl0(we_iicwl0),        // ONW Modified
	.we_iicwh0(we_iicwh0),        // ONW Modified

	.CK0(CK0),

	.din(din),
	.dout(dout),

	.scli0(SCLI0),
	.sdai0(SDAI0),
	.sclo0(SCLO0),
	.sdao0(SDAO0),
	.sclo1(SCLO1),
	.sdao1(SDAO1),
	.intiic0(INTIIC0),

        .exc_s  (exc_s ),        // ONW Modified
        .coi_s  (coi_s ),        // ONW Modified
        .trc_s  (trc_s ),        // ONW Modified
        .wait_s (wait_s),        // ONW Modified
        .iica_s (iica_s),        // ONW Modified
        .sdao_s (sdao_s),        // ONW Modified
        .iice0  (iice  ),
        .sva0   (sva   ),

	.prs0(PRS0)			// Add 20091118

	);

endmodule

// Manual ICG module            Add 20091118

module  QLK0RIICAV2_MICG_GATE  (
        CLK,
        CEN,
        SMC,
        GCLK
        );

input   CLK, CEN, SMC ;
output  GCLK ;


TBGTSMLALADCLX1 U1 (
        .H02(CLK),
        .H01(CEN),
        .H03(SMC),
        .N01(GCLK)
        ) ;

endmodule

//  for Verification

/*
module  QLK0RIICAV2_MICG_GATE  (
        CLK,
        CEN,
        SMC,
        GCLK
        );

input   CLK, CEN, SMC ;
output  GCLK ;

reg     clocken ;

always@( CLK or CEN or SMC ) begin
        if ( ~CLK )             clocken = CEN | SMC ;
end

wire    GCLK = clocken & CLK ;

endmodule
*/


module QLK0RIICAV2_SUB (
      PECLK
     ,PERESETZ
     ,SCANMODE
     ,SVMOD
     ,SCL
     ,SDA

     // fromto main I/O
     ,iice
     ,sva
     ,exc_s
     ,coi_s
     ,trc_s
     ,wait_s
     ,iica_s
     ,sdao_s
);

input PECLK;                //
input PERESETZ;             //
input SCANMODE;             //
input SVMOD;                //
input SCL;                  //
input SDA;                  //

//#### MAIN CIRCUIT I/O ####
input           iice;       //
input  [7:1]    sva;        //
output          exc_s;      //
output          coi_s;      //
output          trc_s;      //
output          wait_s;     //
output [7:0]    iica_s;     //
output          sdao_s;     //

// Reg , Wire
wire            sel_scl;
wire            sel_sda;
reg             even;
wire            st1clr;
reg             std_s1;
wire            st2clr;
reg             std_s2;
wire            stdpls_s1;
wire            stdpls_s2;
wire            sp1_clr;
reg             spd_s1;
wire            sp2_clr;
reg             spd_s2;
wire            stddclr;
reg             stdd_s1;
reg             stdd_s2;
wire            cc_clr;
reg [3:0]       cc;
reg [7:0]       iica_s;

wire            pre_coi;
wire            pre_exc;
reg             wait_s;
reg             coi_s;
reg             exc_s;
reg             trc_s;
reg             sdao_s;

wire            iice_scan;
wire            st1clr_scan;
wire            st2clr_scan;
wire            sp1_clr_scan;
wire            sp2_clr_scan;
wire            stddclr_scan;
wire            cc_clr_scan;

// for monitor

//wire            sub_mon;
//reg             monitor_iic;

///////////////////////////////////
//  Detect Start / Stop codition //
///////////////////////////////////
// Start Condition
wire	sel_sda_f, sel_scl_f ;			// Add 20070706

assign sel_sda      = (SCANMODE)? PECLK : SDA;
assign sel_sda_f      = (SCANMODE)? PECLK : ~SDA;
assign sel_scl      = (SCANMODE)? PECLK : SCL;
assign sel_scl_f      = (SCANMODE)? PECLK : ~SCL;
assign iice_scan    = (SCANMODE)? PERESETZ : iice;


//always@(negedge sel_sda or negedge iice_scan)begin
always@(posedge sel_sda_f or negedge iice_scan)begin
     if(~iice_scan)
        even <= 1'b1;
     else if (~SVMOD) begin
        if (SCL)  begin
          even <= ~even;
        end
     end
end

assign st1clr = iice & ~(stdd_s1 & ~even & SCL) & ~spd_s1 ;
assign st1clr_scan  = (SCANMODE)? PERESETZ : st1clr;

//always@(negedge sel_sda or negedge st1clr_scan)begin
always@(posedge sel_sda_f or negedge st1clr_scan)begin
     if(~st1clr_scan)   
        std_s1 <= 1'b0;
     else if (~SVMOD) begin
        if (even) begin
           if (SCL) begin
             std_s1 <= 1'b1;
           end
        end
     end
end

assign st2clr = iice & ~(stdd_s2 & even & SCL) & ~spd_s2 ;
assign st2clr_scan  = (SCANMODE)? PERESETZ : st2clr;

//always@(negedge sel_sda or negedge st2clr_scan)begin
always@(posedge sel_sda_f or negedge st2clr_scan)begin
     if(~st2clr_scan)   
        std_s2 <= 1'b0;
     else if (~SVMOD) begin
        if (~even) begin
           if (SCL) begin
             std_s2 <= 1'b1;
           end
        end
     end
end

assign stdpls_s1 = std_s1 & ~stdd_s1;
assign stdpls_s2 = std_s2 & ~stdd_s2;

// Stop Condition
assign sp1_clr = iice & ~std_s2;
assign sp1_clr_scan = (SCANMODE)? PERESETZ : sp1_clr;

always@(posedge sel_sda or negedge sp1_clr_scan)begin
     if(~sp1_clr_scan)   
        spd_s1 <= 1'b0;
     else if (~SVMOD) begin
        if (~even) begin
           if (SCL) begin
             spd_s1 <= 1'b1;
           end
        end
     end
end

assign sp2_clr = iice & ~std_s1;
assign sp2_clr_scan = (SCANMODE)? PERESETZ : sp2_clr;

always@(posedge sel_sda or negedge sp2_clr_scan)begin
     if(~sp2_clr_scan)   
        spd_s2 <= 1'b0;
     else if (~SVMOD) begin
        if (even) begin
           if (SCL) begin
              spd_s2 <= 1'b1;
           end
        end
     end
end

///////////////////////////////////
//  SCL Counter                //
///////////////////////////////////
// Counter Enable
assign	stddclr = iice & ~spd_s1 & ~spd_s2;
assign stddclr_scan = (SCANMODE)? PERESETZ : stddclr;

//always@(negedge sel_scl or negedge stddclr_scan )begin
always@(posedge sel_scl_f or negedge stddclr_scan )begin
	if (~stddclr_scan)	stdd_s1 <= 1'b0 ;
        else if (~SVMOD) begin
	if (std_s1)	stdd_s1 <= 1'b1 ;
        else if (stdpls_s2)     stdd_s1 <= 1'b0 ;
	else if ((cc[2:0] == 3'b111) & pre_exc) stdd_s1 <= 1'b0 ; // (cc == 4'b0111)
	else if ((cc[2:0] == 3'b111) & ~pre_exc & ~pre_coi) stdd_s1 <= 1'b0 ; // (cc == 4'b0111)
	else if (cc[3]) stdd_s1 <= 1'b0 ;
        end
end

//always@(negedge sel_scl or negedge stddclr_scan )begin
always@(posedge sel_scl_f or negedge stddclr_scan )begin
	if (~stddclr_scan)	stdd_s2 <= 1'b0 ;
        else if (~SVMOD) begin
	if (std_s2)	stdd_s2 <= 1'b1 ;
	else if (stdpls_s1)	stdd_s2 <= 1'b0 ;
	else if ((cc[2:0] == 3'b111) & pre_exc) stdd_s2 <= 1'b0 ; // (cc == 4'b0111)
	else if ((cc[2:0] == 3'b111) & ~pre_exc & ~pre_coi) stdd_s2 <= 1'b0 ; // (cc == 4'b0111)
	else if (cc[3])         stdd_s2 <= 1'b0 ;
        end
end	

// Clock Counter
assign cc_clr = iice & ~std_s1 & ~std_s2 & ~spd_s1 & ~spd_s2;
assign cc_clr_scan  = (SCANMODE)? PERESETZ : cc_clr;

//always@(negedge sel_scl or negedge cc_clr_scan)begin
always@(posedge sel_scl_f or negedge cc_clr_scan)begin
     if(~cc_clr_scan)   
        cc <= 4'h0;
     else if (~SVMOD) begin
        if ((stdd_s1 | stdd_s2) & ~cc[3] & ~((cc[2:0] == 3'b111) & pre_exc))
           cc <= cc + 4'h1;
        else
           cc <= 4'h0;
     end
end

///////////////////////////////////
//  Shift Register               //
///////////////////////////////////
always@(posedge sel_scl or negedge iice_scan)begin
     if(~iice_scan)   
        iica_s <= 8'h00;
     else if (~SVMOD) begin
        if((stdd_s1 | stdd_s2) &  ~cc[3])
           iica_s <= {iica_s[6:0],SDA};
     end
end

///////////////////////////////////
//  INT & WAIT                   //
///////////////////////////////////
assign pre_coi = (iica_s[7:1] == sva[7:1])? 1'b1 : 1'b0;
assign pre_exc = (~|iica_s[7:4] | &iica_s[7:4])? 1'b1 : 1'b0;

//always@(negedge sel_scl or negedge cc_clr_scan)begin
always@(posedge sel_scl_f or negedge cc_clr_scan)begin
     if(~cc_clr_scan)
        wait_s <= 1'b0;
     else if (~SVMOD) begin
     if((cc[2:0] == 3'b111) & pre_exc)
        wait_s <= 1'b1;
     else if(cc[3] & pre_coi & ~pre_exc)
        wait_s <= 1'b1;
     else
        wait_s <= 1'b0;
     end
end

///////////////////////////////////
//  State flags                  //
///////////////////////////////////
//always@(negedge sel_scl or negedge cc_clr_scan)begin
always@(posedge sel_scl_f or negedge cc_clr_scan)begin
     if(~cc_clr_scan)
        coi_s <= 1'b0;
     else if (~SVMOD) begin
        if((cc[2:0] == 3'b111) | cc[3])
           coi_s <= pre_coi;
        else
           coi_s <= 1'b0;
     end
end

//always@(negedge sel_scl or negedge cc_clr_scan)begin
always@(posedge sel_scl_f or negedge cc_clr_scan)begin
     if(~cc_clr_scan)
        exc_s <= 1'b0;
     else if (~SVMOD) begin
        if((cc[2:0] == 3'b111) | cc[3])
           exc_s <= pre_exc;
        else
           exc_s <= 1'b0;
     end
end

//always@(negedge sel_scl or negedge cc_clr_scan)begin
always@(posedge sel_scl_f or negedge cc_clr_scan)begin
     if(~cc_clr_scan)
        trc_s <= 1'b0;
     else if (~SVMOD) begin
        if((cc[2:0] == 3'b111) | cc[3])
           trc_s <= (pre_exc | pre_coi) & iica_s[0];
        else
           trc_s <= 1'b0;
     end
end

///////////////////////////////////
//  SDA line                     //
///////////////////////////////////
//always@(negedge sel_scl or negedge cc_clr_scan)begin
always@(posedge sel_scl_f or negedge cc_clr_scan)begin
     if(~cc_clr_scan)
        sdao_s <= 1'b1;
     else if (~SVMOD) begin
        if((cc[2:0] == 3'b111) & pre_coi & ~pre_exc)
           sdao_s <= 1'b0;
        else
           sdao_s <= 1'b1;
     end
end

///////////////////////////////////
//  SCAN Monitor                 //
///////////////////////////////////
// --- SCAN Moniter
/*
assign sub_mon = iice ^ st1clr ^ st2clr ^ sp1_clr ^ sp2_clr ^ stddclr ^ cc_clr;
always @ (posedge PECLK or negedge PERESETZ) begin
        if (!PERESETZ) begin
                monitor_iic     <= 1'b0;
        end
        else if(SCANMODE) begin				// Modify 20070706 NMS
                monitor_iic     <= sub_mon ;
        end
end
*/
endmodule

module QLK0RIICAV2_APBBI	(
	addr,
	wdata,
	rdata,
	PWRITE,
	PENABLE,
	PSEL,

	re_iic0,
	re_iicf0,
	re_iicc0,
	re_sva0,
	re_iiccl0,
//	re_iicx0,
	re_iics0,
	re_iicse0,
	re_iicwl0,        // ONW Modified
	re_iicwh0,        // ONW Modified
	we_iic0,
	we_iicf0,
	we_iicc0,
	we_sva0,
	we_iiccl0,
//	we_iicx0,
	we_iicwl0,        // ONW Modified
	we_iicwh0,        // ONW Modified

	din,
	dout
	);


//--- port direction
input	[2:0]	addr;
input	[15:0]	wdata;
output	[15:0]	rdata;
input			PWRITE;
input			PENABLE;
input   [1:0]		PSEL;             // ONW Modified

output			re_iic0;
output			re_iicf0;
output			re_iicc0;
output			re_sva0;
output			re_iiccl0;
//output			re_iicx0;
output			re_iics0;
output			re_iicse0;
output                  re_iicwl0;        // ONW Modified
output                  re_iicwh0;        // ONW Modified

output			we_iic0;
output			we_iicf0;
output			we_iicc0;
output			we_sva0;
output			we_iiccl0;
//output			we_iicx0;
output                  we_iicwl0;        // ONW Modified
output                  we_iicwh0;        // ONW Modified

output	[15:0]	din;
input	[15:0]	dout;


//--- wire
wire			sel_iic0;
wire			sel_iicf0;
wire			sel_iicc0;
wire			sel_sva0;
wire			sel_iiccl0;
//wire			sel_iicx0;
wire			sel_iics0;
wire			sel_iicse0;
wire			sel_iicwl0;        // ONW Modified
wire			sel_iicwh0;        // ONW Modified


//--- logic

//Address Decode
//assign sel_iic0		=  PSEL & (addr == 3'h0);
//assign sel_iicf0	=  PSEL & (addr == 3'h1);
//assign sel_iicc0	=  PSEL & (addr == 3'h2);
//assign sel_sva0		=  PSEL & (addr == 3'h3);
//assign sel_iiccl0	=  PSEL & (addr == 3'h4);
//assign sel_iicx0	=  PSEL & (addr == 3'h5);
//assign sel_iics0	=  PSEL & (addr == 3'h6);
//assign sel_iicse0	=  PSEL & (addr == 3'h7);

assign sel_iic0		=  PSEL[0] & (addr[1:0] == 2'h0);                   // ONW Modified -> NMS Modify 20070804
assign sel_iics0	=  PSEL[0] & (addr[1:0] == 2'h1);                   // ONW Modified -> NMS Modify 20070804
assign sel_iicf0	=  PSEL[0] & (addr[1:0] == 2'h2);                   // ONW Modified -> NMS Modify 20070804

assign sel_iicc0	=  PSEL[1] & (addr == 3'h0);                   // ONW Modified
assign sel_iiccl0	=  PSEL[1] & (addr == 3'h1);                   // ONW Modified
assign sel_iicwl0	=  PSEL[1] & (addr == 3'h2);                   // ONW Modified
assign sel_iicwh0	=  PSEL[1] & (addr == 3'h3);                   // ONW Modified
assign sel_sva0		=  PSEL[1] & (addr == 3'h4);                   // ONW Modified
assign sel_iicse0	=  PSEL[1] & (addr == 3'h5);                   // ONW Modified


//Write Enable
assign we_iic0		= (sel_iic0  && PENABLE && PWRITE);
assign we_iicf0		= (sel_iicf0 && PENABLE && PWRITE);
assign we_iicc0		= (sel_iicc0 && PENABLE && PWRITE);
assign we_sva0		= (sel_sva0  && PENABLE && PWRITE);
assign we_iiccl0	= (sel_iiccl0 && PENABLE && PWRITE);
//assign we_iicx0		= (sel_iicx0 && PENABLE && PWRITE);    // ONW Modified
assign we_iicwl0        = (sel_iicwl0 && PENABLE && PWRITE);           // ONW Modified
assign we_iicwh0        = (sel_iicwh0 && PENABLE && PWRITE);           // ONW Modified


//Write Enable
assign re_iic0		= (sel_iic0  && PENABLE && (!PWRITE));
assign re_iicf0		= (sel_iicf0 && PENABLE && (!PWRITE));
assign re_iicc0		= (sel_iicc0 && PENABLE && (!PWRITE));
assign re_sva0		= (sel_sva0  && PENABLE && (!PWRITE));
assign re_iiccl0	= (sel_iiccl0 && PENABLE && (!PWRITE));
//assign re_iicx0		= (sel_iicx0 && PENABLE && (!PWRITE)); // ONW Modified
assign re_iics0		= (sel_iics0 && PENABLE && (!PWRITE));
assign re_iicse0	= (sel_iicse0 && PENABLE && (!PWRITE));
assign re_iicwl0        = (sel_iicwl0 && PENABLE && (!PWRITE));        // ONW Modified
assign re_iicwh0        = (sel_iicwh0 && PENABLE && (!PWRITE));        // ONW Modified


//Output
assign din		= wdata;
assign rdata		= dout;


endmodule
module QLK0RIICAV2_MAIN	(
	PCLK,			// Add 20091118
	PECLK,
	PCLKRW,			// Add 20091118
	PERESETZ,
//	SCANMODE,				// Del 20091209 -5
	SVMOD,			// Del 20091207 -2

	re_iic0,
	re_iicf0,
	re_iicc0,
	re_sva0,
	re_iiccl0,
//	re_iicx0,         // ONW Modified
	re_iics0,
	re_iicse0,
        re_iicwl0,        // ONW Modified
        re_iicwh0,        // ONW Modified
	we_iic0,
	we_iicf0,
	we_iicc0,
	we_sva0,
	we_iiccl0,
//	we_iicx0,         // ONW Modified
        we_iicwl0,        // ONW Modified
        we_iicwh0,        // ONW Modified

	CK0,

	din,
	dout,

	scli0,
	sdai0,
	sclo0,
	sdao0,
	sclo1,
	sdao1,
	intiic0,

        exc_s,           // ONW Modified
        coi_s,           // ONW Modified
        trc_s,           // ONW Modified
        wait_s,          // ONW Modified
        iica_s,          // ONW Modified
        sdao_s,          // ONW Modified
        iice0,           // ONW Modified
        sva0,             // ONW Modified

        prs0                   // Add 20091118

	);


//--- port direction
input                   PCLK;                   // Add 20091118
input                   PECLK;
input                   PCLKRW;                 // Add 20091118
input			PERESETZ;
//input			SCANMODE;			// Del 20091209 -5
input			SVMOD;			// Del 20091207 -2

input			re_iic0;
input			re_iicf0;
input			re_iicc0;
input			re_sva0;
input			re_iiccl0;
//input			re_iicx0;         // ONW Modified
input			re_iics0;
input			re_iicse0;
input			re_iicwl0;        // ONW Modified
input			re_iicwh0;        // ONW Modified

input			we_iic0;
input			we_iicf0;
input			we_iicc0;
input			we_sva0;
input			we_iiccl0;
//input			we_iicx0;         // ONW Modified
input			we_iicwl0;        // ONW Modified
input			we_iicwh0;        // ONW Modified

input			CK0;

input	[15:0]	din;
output	[15:0]	dout;

input			scli0;
input			sdai0;
output			sclo0;
output			sdao0;
output			sclo1;
output			sdao1;
output			intiic0;


input                   exc_s;        // ONW Modified
input                   coi_s;        // ONW Modified
input                   trc_s;        // ONW Modified
input                   wait_s;       // ONW Modified
input   [7:0]           iica_s;       // ONW Modified
input                   sdao_s;       // ONW Modified
output                  iice0;        // ONW Modified
output  [7:1]           sva0;         // ONW Modified

output                  prs0;                   // Add 20091118


//--- wire
wire	[7:0]	iic0;
wire	[7:1]	sva0;
wire		stt0t;
wire    [7:0]   iicwl;        // ONW Modified
wire    [7:0]   iicwh;        // ONW Modified

wire            prs0;                   // Add 20091118

wire            wup, stdpls, spdpls, wup_s, wait_ch0, lrelp, stf, msts0, scl, selscli;
wire            sclu1, scld1, selsdai, sdau1, sdad1, waitiic, iicwrq, setsptp, spten;
wire            aldp, cld0, dad0, spc0, dfc0, sclstp, t03, t06, t13, t40, t47, t13p, t50p;
wire            sclout, sclo, std0, exc0, c7en, c8en, c8en_sdao, c9en, c9en_sdao, acker;
wire            stten, setsttp, coi0, trc0, sda, waitiic_sdao, spd0, exccode, coicode;
wire            bufsetp, sdaout, sdao, tsuup, intiic, wrelp, spicr, wtimr, serv, aldr, stcen;
wire		iice0_rst;

//--- module connect

QLK0RIICAV2_SUBIF  sub_if       (
        .PECLK    (PECLK   ),
        .PERESETZ (PERESETZ),
//        .SVMOD    (SVMOD   ),			// Del 20091207 -2
        .iice0    (iice0   ),
        .wait_s   (wait_s  ),
        .wup      (wup     ),
        .stdpls   (stdpls  ),
        .spdpls   (spdpls  ),
        .wup_s    (wup_s   ),
        .wait_ch0 (wait_ch0),
        .iice0_rst(iice0_rst)	
//        .wup_rst1(wup_rst1)			// Del 20091207 -3
        );


QLK0RIICAV2_CLKSEL clksel	(
	.PECLK(PECLK),
	.PCLKRW(PCLKRW),		// Add 20091118
	.PERESETZ(PERESETZ),
//	.SVMOD(SVMOD),				// Del 20091207 -2

	.we_iiccl0(we_iiccl0),
//	.we_iicx0(we_iicx0),          // ONW Modified
	.we_iicwl0(we_iicwl0),        // ONW Modified
	.we_iicwh0(we_iicwh0),        // ONW Modified
	.din(din),
	.iice0(iice0),
	.lrelp(lrelp),
	.stt0(stt0t),
	.stf(stf),
	.msts0(msts0),
	.stdpls(stdpls),
	.spdpls(spdpls),
	.scl(scl),
	.selscli(selscli),
	.sclu1(sclu1),
	.scld1(scld1),
	.selsdai(selsdai),
	.sdau1(sdau1),
	.sdad1(sdad1),
	.waitiic(waitiic),
	.iicwrq(iicwrq),
	.setsptp(setsptp),
	.spten(spten),
	.aldp(aldp),
        .wup_s(wup_s),                // ONW Modified
        .wait_s(wait_s),              // ONW Modified
        //.wait_ch0(wait_ch0),          // ONW Modified
        .iice0_rst(iice0_rst),        // ONW RPU

	.cld0(cld0),
	.dad0(dad0),
	.spc0(spc0),
	.dfc0(dfc0),
//	.cl01(cl01),
//	.cl00(cl00),
	.sclstp(sclstp),
	.t03(t03),
	.t06(t06),
	.t13(t13),
	.t40(t40),
	.t47(t47),
	.t13p(t13p),
	.t50p(t50p),
	.sclout(sclout),
	.sclo(sclo),
//	.clx0(clx0)
        .iicwl(iicwl),                 // ONW Modified
        .iicwh(iicwh),                 // ONW Modified
        .wup(wup),                     // ONW Modified
//        .wup_rst1(wup_rst1),            // ONW RPU	Del 20091219

	.prs0(prs0)                             // Add 20091118

	);



QLK0RIICAV2_CLKCOUNT clkcount	(
	.PECLK(PECLK),
	.PERESETZ(PERESETZ),
//	.SVMOD(SVMOD),				// Del 20091207 -2

	.iice0(iice0),
	.scld1(scld1),
	.std0(std0),
	.stdpls(stdpls),
	.spdpls(spdpls),
	.scl(scl),
        .wup(wup),                    // ONW Modified
        .wup_s(wup_s),                // ONW Modified
        .wait_ch0(wait_ch0),          // ONW Modified
	.exc0(exc0),                  // ONW Modified
        .iice0_rst(iice0_rst),      // ONW RPU

	.c7en(c7en),
	.c8en(c8en),
	.c8en_sdao(c8en_sdao),        // ONW Modified
	.c9en(c9en), 
	.c9en_sdao(c9en_sdao)         // ONW Modified
	);



QLK0RIICAV2_DATAOUT dataout	(
        .PCLK(PCLK),                            // Add 20091118
	.PECLK(PECLK),
        .PCLKRW(PCLKRW),                        // Add 20091118
	.PERESETZ(PERESETZ),
//	.SCANMODE(SCANMODE),			// Del 20091209 -5
	.SVMOD(SVMOD),				// Del 20091207 -2

	.we_iic0(we_iic0),
	.we_sva0(we_sva0),
	.din(din[7:0]),

        .iica_s(iica_s),              // ONW Modified
        .wup(wup),                    // ONW Modified
        .wup_s(wup_s),                // ONW Modified
        .wait_ch0(wait_ch0),          // ONW Modified
//        .stdpls(stdpls),              // ONW Modified
//        .spdpls(spdpls),              // ONW Modified
        .sdao_s(sdao_s),              // ONW Modified

	.iice0(iice0),
	.lrelp(lrelp),
	.acker(acker),
	.stt0(stt0t),
	.stten(stten),
	.spten(spten),
	.setsttp(setsttp),
	.msts0(msts0),
	.exc0(exc0),
	.coi0(coi0),
	.trc0(trc0),
	.std0(std0),
	.sclstp(sclstp),
	.scl(scl),
	.sclu1(sclu1),
//        .scld1(scld1),                     // ONW Modified
	.sda(sda), 
	.waitiic_sdao(waitiic_sdao),         // ONW Modified
	.aldp(aldp),
	.sdad1(sdad1),
	.c8en(c8en),
	.c8en_sdao(c8en_sdao),               // ONW Modified
	.c9en_sdao(c9en_sdao),               // ONW Modified
	.t03(t03),
	.t06(t06),
	.t40(t40),
	.spd0(spd0),
        .iice0_rst(iice0_rst),             // ONW RPU

	.exccode(exccode),
	.coicode(coicode),
//	.exccode_pre(exccode_pre),           // ONW Modified
//	.coicode_pre(coicode_pre),           // ONW Modified
	.bufsetp(bufsetp),
	.sdaout(sdaout),
	.sdao(sdao),
	.tsuup(tsuup),
	.iic0(iic0),
	.sva0(sva0),

	.prs0(prs0) 
	);



QLK0RIICAV2_EXTCNT extcnt	(
	.PECLK(PECLK),
	.PERESETZ(PERESETZ),
//	.SVMOD(SVMOD),			// Del 20091207 -2

	.scli(scli0),
	.sdai(sdai0),
	.iice0(iice0),
        .iice0_rst(iice0_rst),
	.dfc0(dfc0),
	.intiic(intiic),
	.sclo(sclo),
	.sdao(sdao), 
	.sclout(sclout),
	.sdaout(sdaout),

	.selscli(selscli),
	.selsdai(selsdai),
	.scl(scl),
	.sda(sda),
	.sclu1(sclu1),
	.scld1(scld1),
	.sdau1(sdau1),
	.sdad1(sdad1),
	.intiic0(intiic0),
	.sclo0(sclo0),
	.sdao0(sdao0),
	.sclo1(sclo1),
	.sdao1(sdao1)
	);



QLK0RIICAV2_IOREG ioreg	(
        .PCLK(PCLK),                            // Add 20091118
	.PECLK(PECLK),
        .PCLKRW(PCLKRW),                        // Add 20091118
	.PERESETZ(PERESETZ),
//	.SCANMODE(SCANMODE),			// Del 20091209 -5
//	.SVMOD(SVMOD),				// Del 20091207 -2

	.we_iicf0(we_iicf0),
	.we_iicc0(we_iicc0),
	.re_iic0(re_iic0),
	.re_iicf0(re_iicf0),
	.re_iicc0(re_iicc0),
	.re_sva0(re_sva0),
	.re_iiccl0(re_iiccl0),
//	.re_iicx0(re_iicx0),          // ONW Modified
	.re_iics0(re_iics0),
	.re_iicse0(re_iicse0),
	.re_iicwl0(re_iicwl0),        // ONW Modified
	.re_iicwh0(re_iicwh0),        // ONW Modified
	.din(din[7:0]),
        .wup(wup),                    // ONW Modified

	.scl(scl),
	.sda(sda),
	.sdaout(sdaout),
	.sclu1(sclu1),
	.scld1(scld1),
	.sdau1(sdau1),
	.sdad1(sdad1),
	.sclstp(sclstp),
	.cld0(cld0),
	.dad0(dad0),
	.spc0(spc0),
	.dfc0(dfc0),
//	.cl01(cl01),                  // ONW Modified
//	.cl00(cl00),                  // ONW Modified
	.sclout(sclout),
	.exccode(exccode),
	.coicode(coicode),
//	.exccode_pre(exccode_pre),    // ONW Modified
//	.coicode_pre(coicode_pre),    // ONW Modified
	.t06(t06),
	.t13(t13),
	.t40(t40),
	.t47(t47),
	.t13p(t13p),
	.t50p(t50p),
	.c7en(c7en),
	.c8en(c8en),
	.c9en(c9en),
	.iic0(iic0),
	.sva0(sva0),
	.tsuup(tsuup),
//	.clx0(clx0),                  // ONW Modified
	.iicwl(iicwl),                // ONW Modified
	.iicwh(iicwh),                // ONW Modified
	
        .exc_s(exc_s),                // ONW Modified
        .coi_s(coi_s),                // ONW Modified
        .trc_s(trc_s),                // ONW Modified
        .wup_s(wup_s),                // ONW Modified
        .wait_ch0(wait_ch0),          // ONW Modified
	.CK0(CK0),

        .iice0_rst(iice0_rst),      // ONW RPU

	.iice0(iice0),
//	.lrelp(lrelp),
	.lrelrp(lrelp),
//	.wrelp(wrelp),
	.wrelrp(wrelp),			// Mod 20091212
	.spicr(spicr),
	.wtimr(wtimr),
	.acker(acker),
	.stt0t(stt0t),
	.serv(serv),

	.msts0(msts0),
	.aldr(aldr),
	.exc0(exc0),
	.coi0(coi0),
	.trc0(trc0),
	.std0(std0),
	.spd0(spd0),
	.aldp(aldp),

	.stten(stten),
	.spten(spten),
	.stdpls(stdpls),
	.spdpls(spdpls),
	.stf(stf),
	.setsttp(setsttp),
	.setsptp(setsptp),
	.stcen(stcen),

	.dout(dout),

        .prs0(prs0)                                    // Add 20091118
	);



QLK0RIICAV2_WAITCONT waitcont	(
	.PECLK(PECLK),
	.PERESETZ(PERESETZ),
//	.SVMOD(SVMOD),				// Del 20091207 -2

	.iice0(iice0),
        .iice0_rst(iice0_rst),
	.lrelp(lrelp),
	.wrelp(wrelp),
	.spicr(spicr),
	.wtimr(wtimr),
	.stt0(stt0t),
	.setsttp(setsttp),
	.setsptp(setsptp),
	.msts0(msts0),
	.exc0(exc0),
	.coi0(coi0),
	.aldr(aldr),
	.std0(std0),
	.spd0(spd0),
	.spdpls(spdpls),
	.scl(scl),
	.sclu1(sclu1),
	.scld1(scld1),
	.c7en(c7en),
	.c8en(c8en),
	.bufsetp(bufsetp),
	.serv(serv),
	.aldp(aldp),
	.stcen(stcen),

        .wup(wup),                    // ONW Modified
        .wup_s(wup_s),                // ONW Modified
        .wait_ch0(wait_ch0),          // ONW Modified
        .wait_s(wait_s),              // ONW Modified
        .stdpls(stdpls),              // ONW Modified

	.waitiic(waitiic),
	.waitiic_sdao(waitiic_sdao),  // ONW Modified
	.iicwrq(iicwrq),
	.intiic(intiic) 
	);




endmodule
module QLK0RIICAV2_SUBIF (
     PECLK
     ,PERESETZ
//     ,SVMOD				// Del 20091207 -2
     ,iice0
     ,wait_s
     ,wup
     ,stdpls
     ,spdpls
     ,wup_s
     ,wait_ch0
     ,iice0_rst	
//     ,wup_rst1			// Del 20091207 -3
);

input        PECLK;          //
input        PERESETZ;       //
//input        SVMOD;          //		// Del 20091207 -2
input        iice0;          //
input        wait_s;         //
input        wup;

input        stdpls;         //
input        spdpls;         //

input        iice0_rst;    // ONW RPU		
//input        wup_rst1;      // ONW RPU	// Del 20091207 -3

output       wup_s;          //
output       wait_ch0;       //

reg          wup_s;
reg   [2:0]  wait_m;
wire         wait_ch0;
wire         wait_ch1;

// ----- Standby Signal  -----
always @ (posedge PECLK or negedge PERESETZ) begin
        if (!PERESETZ)
                wup_s    <= 1'b0;
//        else if (!SVMOD & (iice0_rst | wup_rst1 | (iice0 & ~wup))) begin // ONW RPU
        else if (iice0_rst | wup | (iice0 & ~wup)) begin 		// Mod 20091207 -2 -3
           if (iice0_rst)
                wup_s    <= 1'b0;
//           else if (wup_rst1)
           else if (wup)
                wup_s    <= 1'b1;
           else if ( stdpls | spdpls | wait_ch1 )
                wup_s    <= 1'b0;
        end
end

// ----- Detect standby cancel  -----
// ONW RPU
always @ (posedge PECLK or negedge PERESETZ) begin
        if (!PERESETZ)
                wait_m    <= 3'b000;
//        else if (!SVMOD & (iice0_rst | wup_rst1 | (iice0 & ~wup))) begin
        else if (iice0_rst | wup | (iice0 & ~wup)) begin		// Mod 20091207 -2  -3
//           if(iice0_rst | wup_rst1)
           if(iice0_rst | wup)				// Mod 20091207 -3
              wait_m    <= 3'b000;
           else
                wait_m    <= {wait_m[1:0],wait_s};
        end
end

assign wait_ch0 = wait_m[0] & ~wait_m[2];
assign wait_ch1 = wait_m[1] & ~wait_m[2];

endmodule
module QLK0RIICAV2_CLKCOUNT	(
	PECLK,
	PERESETZ,
//	SVMOD,				// Del 20091207 -2

	iice0,
	scld1,
	std0,
	stdpls,
	spdpls,
	scl,

        wup,                       // ONW Modified
        wup_s,                     // ONW Modified
        wait_ch0,                  // ONW Modified
        exc0,                      // ONW Modified
        iice0_rst,                // ONW RPU

	c7en,
	c8en,
	c8en_sdao,
	c9en,
	c9en_sdao 
	);


//--- port direction
input			PECLK;
input			PERESETZ;
//input			SVMOD;			// Del 20091207 -2

input			iice0;
input			scld1;
input			std0;
input			stdpls;
input			spdpls;
input			scl;

input                   wup;         // ONW Modified
input                   wup_s;       // ONW Modified
input                   wait_ch0;    // ONW Modified
input                   exc0;        // ONW Modified
input                   iice0_rst;  // ONW RPU

output			c7en;
output			c8en;
output			c8en_sdao;
output			c9en;
output			c9en_sdao;



//--- logic

// ----- COUNTEN -----

reg	counten;

always @(posedge PECLK or negedge PERESETZ) begin
	if(!PERESETZ) begin
		counten	<= 1'b0;
	end
//      else if (!SVMOD & ((iice0 & (wup_s | stdpls | spdpls | (std0 && !scl))) | iice0_rst)) begin
//        else if (!SVMOD & (iice0 | iice0_rst)) begin
        else if (iice0 | iice0_rst) begin		// Mod 20091207 -2
	if (iice0_rst) begin
		counten	<= 1'b0;
	end
        else if (wup_s)
        begin : COUNTEN_MAIN_STOP
            counten <= wait_ch0;
        end  // COUNTEN_MAIN_STOP
	else if (stdpls || spdpls) begin
		counten	<= 1'b0;
	end
	else if (std0 && !scl) begin
		counten	<= 1'b1;
	end
	end
end


// ----- C1,C2,C3 -----
// ----- C9EN -----

reg [3:0] c_cnt; // ONW RPU

//ONW RPU
always @(posedge PECLK or negedge PERESETZ) begin
        if(!PERESETZ) begin
           c_cnt[3:0] <= 4'd0;
        end
        else begin
//           if(!SVMOD & !wup & ((iice0 & (wup_s | !counten | scld1)) | iice0_rst)) begin
           if(!wup & ((iice0 & (wup_s | !counten | scld1)) | iice0_rst)) begin		// Mod 20091207 -2
              if(iice0_rst) begin
                 c_cnt[3:0] <= 4'd0;
              end
              else if(wup_s) begin
                 c_cnt[3:0] <= {wait_ch0,2'd0,(wait_ch0 & ~exc0)};
              end
              else if(!counten) begin
                 c_cnt[3:0] <= 4'd0;
              end
              else if(scld1) begin
                 if(c_cnt[3:0] == 4'd9) begin
                    c_cnt[3:0] <= 4'd1;
                 end
                 else begin
                    c_cnt[3:0] <= c_cnt[3:0] + 1'b1;
                 end
              end
           end
        end
end
                 
// ----- C7EN -----

wire    c1   = c_cnt[0];
wire    c2   = c_cnt[1];
wire    c3   = c_cnt[2];
wire	c7en = c1 & c2 & c3;
wire    c8en = (c_cnt[3:0] == 4'd8); //ONW RPU
wire    c9en = (c_cnt[3:0] == 4'd9); //ONW RPU

wire c8en_pre;                                         // ONW Modified
wire c8en_mask;                                        // ONW Modified
wire c8en_sdao;                                        // ONW Modified
assign c8en_pre  = (scld1 & c7en) | c8en;              // ONW Modified
assign c8en_mask = (scld1 & ~c7en) | ~counten;         // ONW Modified
assign c8en_sdao = c8en_pre & ~c8en_mask;              // ONW Modified

wire c9en_pre;                                     // ONW Modified
wire c9en_mask;                                    // ONW Modified
wire c9en_sdao;                                    // ONW Modified
assign c9en_pre  = (scld1 & c8en) | c9en ;         // ONW Modified
assign c9en_mask = (scld1 & ~c8en) | ~counten ;    // ONW Modified
assign c9en_sdao = c9en_pre & ~c9en_mask ;         // ONW Modified


endmodule
module QLK0RIICAV2_CLKSEL	(
	PECLK,
	PCLKRW,
	PERESETZ,
//	SVMOD,				// Del 20091207 -2

	we_iiccl0,
//	we_iicx0,    // ONW Modified
        we_iicwl0,
        we_iicwh0,
	din,
	iice0,
	lrelp,
	stt0,
	stf,
	msts0,
	stdpls,
	spdpls,
	scl,
	selscli,
	sclu1,
	scld1,
	selsdai,
	sdau1,
	sdad1,
	waitiic,
	iicwrq,
	setsptp,
	spten,
	aldp,

        wait_s,       // ONW Modified
        wup_s,        // ONW Modified
        //wait_ch0,     // ONW Modified
	cld0,
	dad0,
	spc0,
	dfc0,
//	cl01,         // ONW Modified
//	cl00,         // ONW Modified
	sclstp,
	t03,
	t06,
	t13,
	t40,
	t47,
	t13p,
	t50p,
	sclout,
	sclo, 
//	clx0          // ONW Modified
        iicwl,        // ONW Modified
        iicwh,        // ONW Modified
        wup,          // ONW Modified
        iice0_rst,    // ONW RPU
//        wup_rst1,      // ONW RPU		// Del 20091219

	prs0					// Add 20091118
	);


//--- port direction
input			PECLK;
input			PCLKRW;			// Add 20091118
input			PERESETZ;
//input			SVMOD;			// Del 20091207 -2

input			we_iiccl0;
//input			we_iicx0;          // ONW Modified
input                   we_iicwl0;        // ONW Modified
input                   we_iicwh0;        // ONW Modified
input	[15:0]	din;

input			iice0;
input			lrelp;
input			stt0;
input			stf;
input			msts0;
input			stdpls;
input			spdpls;
input			scl;
input			selscli;
input			sclu1;
input			scld1;
input			selsdai;
input			sdau1;
input			sdad1;
input			waitiic;
input			iicwrq;
input			setsptp;
input			spten;
input			aldp;
input                   wait_s;           // ONW Modified
input                   wup_s;            // ONW Modified
//input                   wait_ch0;         // ONW Modified
input                   iice0_rst;

output			cld0;
output			dad0;
output			spc0;
output			dfc0;
//output			cl01;     // ONW Modified
//output			cl00;     // ONW Modified
output			sclstp;
output			t03;
output			t06;
output			t13;
output			t40;
output			t47;
output			t13p;
output			t50p;
output			sclout;
output			sclo;
//output			clx0;     // ONW Modified
output [7:0]		iicwl;      // ONW Modified
output [7:0] 		iicwh;      // ONW Modified
output			wup;        // ONW Modified
//output                  wup_rst1;   // ONW RPU

output			prs0;			// Add 20091118

reg			prs0;			// Add 20091118


reg  wup;
//--- logic

// ----- IICX reg ----- 
//reg	clx0 ;
//
//always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!PERESETZ) begin
//		clx0	<= 1'b0;
//	end
//	else if (we_iicx0) begin
//		clx0	<= din[8];
//	end
//	else begin
//		clx0	<= clx0;
//	end
//end

//////////////// ONW Modified START/////////////////////////
// ----- IICWL reg ----- 
reg [7:0] iicwl ;

always @ (posedge PCLKRW or negedge PERESETZ) begin		// Modify 20091118
	if (!PERESETZ) begin
		iicwl	<= 8'hff;
	end
	else if (we_iicwl0) begin
		iicwl	<= din[7:0];
	end
	else begin
		iicwl	<= iicwl;
	end
end

// ----- IICWH reg ----- 
reg [7:0] iicwh ;

always @ (posedge PCLKRW or negedge PERESETZ) begin		// Modify 20091118
	if (!PERESETZ) begin
		iicwh	<= 8'hff;
	end
	else if (we_iicwh0) begin
		iicwh	<= din[15:8];
	end
	else begin
		iicwh	<= iicwh;
	end
end
// ----- IICCL0 -----
//reg	spc0, dfc0, cl01, cl00;
reg	spc0, dfc0;                     // ONW Modified

always @ (posedge PCLKRW or negedge PERESETZ) begin		// Modify 20091118
        if (!PERESETZ) begin
                wup     <= 1'b0;        // ONW Modified
        end
        else if (we_iiccl0) begin
                wup     <= din[15];     // ONW Modified
        end
        else begin
                wup     <= wup;         // ONW Modified
        end
end

//assign wup_rst1 = we_iiccl0 & din[15];

//////////////// ONW Modified END /////////////////////////

always @ (posedge PCLKRW or negedge PERESETZ) begin
	if (!PERESETZ) begin
		spc0	<= 1'b0;
		dfc0	<= 1'b0;
//		cl01	<= 1'b0;               // ONW Modified
//		cl00	<= 1'b0;               // ONW Modified
		prs0	<= 1'b0 ;			// Add 20091118
	end
	else if (we_iiccl0) begin
		spc0	<= din[11];
		dfc0	<= din[10];
//		cl01	<= din[1];             // ONW Modified
//		cl00	<= din[0];             // ONW Modified
		prs0	<= din[8];			// Add 20091118
	end
	else begin
		spc0	<= spc0;
		dfc0	<= dfc0;
//		cl01	<= cl01;               // ONW Modified
//		cl00	<= cl00;               // ONW Modified
		prs0	<= prs0;			// Add 20091118
        end
end

wire	cld0    = iice0 & selscli;
wire	dad0    = iice0 & selsdai;

// ----- TIME MEASURE UNIT -----

wire	t03, t06, t13, t40, t47, t50;
reg	t13d, t50d;
reg     sclout_pre;                            // ONW Modified

wire	stdspd = scl & sclout_pre & ( sdau1 | sdad1 );


///////////////////////////////

//////////////// ONW Modified START /////////////////////////
// Timing Counter
reg [7:0] tcnt;
// ONW RPU
always @ (posedge PECLK or negedge PERESETZ) begin
   if (!PERESETZ)
      tcnt[3:0] <= 4'h0;
   else begin
//      if (!SVMOD & !wup & ((iice0 & (wup_s | scld1 | sclu1 | stdspd | (~waitiic & (tcnt < 8'hff)))) | iice0_rst)) begin
      if (!wup & ((iice0 & (wup_s | scld1 | sclu1 | stdspd | (~waitiic & (tcnt < 8'hff)))) | iice0_rst)) begin		// Mod 20091207 -2
         if (iice0_rst | lrelp)
                tcnt[3:0] <= 4'h0;
         else if (wup_s)
           begin : TCNT_MAIN_STOP
               tcnt[3:0] <= 4'h2 + {3'd0, dfc0};
           end  // TCNT_MAIN_STOP
         else if (scld1 | sclu1 | stdspd)
               tcnt[3:0] <= 4'h2 + {3'd0,dfc0};
         else if (~waitiic & (tcnt[7:0] < 8'hff))
               tcnt[3:0] <= tcnt[3:0] + 4'h1;
     end
   end
end

always @ (posedge PECLK or negedge PERESETZ) begin
   if (!PERESETZ)
      tcnt[7:4] <= 4'h0;
   else begin
//      if (!SVMOD & !wup & ((iice0 & (wup_s | scld1 | sclu1 | stdspd | ((&tcnt[3:0]) & ~waitiic & (tcnt < 8'hff)))) | iice0_rst)) begin
      if (!wup & ((iice0 & (wup_s | scld1 | sclu1 | stdspd | ((&tcnt[3:0]) & ~waitiic & (tcnt < 8'hff)))) | iice0_rst)) begin		// Mod 20091207 -2
         if (iice0_rst | lrelp)
                tcnt[7:4] <= 4'h0;
         else if (wup_s)
                tcnt[7:4] <= 4'h0;
         else if (scld1 | sclu1 | stdspd)
                tcnt[7:4] <= 4'h0;
         else if (~waitiic & (tcnt < 8'hff))
               tcnt[7:4] <= tcnt[7:4] + 4'h1;
     end
   end
end

////////////////////////
// t03 timing generate
////////////////////////
wire t03_min;
wire t03_pre;
wire t03_mask;

assign t03_min = (dfc0)? (iicwl[7:2] <= 6'b00_0010) :
                         (iicwl[7:2] <= 6'b00_0001) ;
assign t03_pre = ((scld1 | sclu1 | stdspd) & t03_min)                      ? 1'b1 :
                 (~scld1 & ~sclu1 & ~stdspd & (tcnt >= {2'h0,iicwl[7:2]})) ? 1'b1 :
                                                                             1'b0 ;
assign t03_mask = setsptp | iicwrq | waitiic | scl;
assign t03 = t03_pre & ~t03_mask;

////////////////////////
// t06 timing generate
////////////////////////
wire t06_pre;
wire t06_mask;

assign t06_pre = ( tcnt >= iicwh );
assign t06_mask = ~spc0 | setsptp | waitiic | scld1 | sclu1 | stdspd;
assign t06 = t06_pre & ~t06_mask;

////////////////////////
// t13 timing generate
////////////////////////
wire t13_pre;
wire [7:0] t13_lohisel;

// start or stop condition
reg  start_cond;
reg  stop_cond;
always @ (posedge PECLK or negedge PERESETZ) begin
        if (!PERESETZ) begin
                start_cond <= 1'b0;
        end
//        else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin
        else if (!wup & (iice0 | iice0_rst)) begin			// Mod 20091207 -2
           if (iice0_rst | lrelp ) begin
                start_cond <= 1'b0;
           end
           else if (wup_s)
           begin : START_COND_MAIN_STOP
               start_cond <= stdpls;
           end  // START_COND_MAIN_STOP
           else if (scl & sclout_pre & sdad1) begin    // start condition detect
                start_cond <= 1'b1;
           end
           else if (sdau1 | sdad1 | sclu1 | scld1) begin
                start_cond <= 1'b0;
           end
        end
end
always @ (posedge PECLK or negedge PERESETZ) begin
        if (!PERESETZ) begin
                stop_cond <= 1'b0;
        end
//        else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin
        else if (!wup & (iice0 | iice0_rst)) begin		// Mod 20091207 -2
           if (iice0_rst) begin
                stop_cond <= 1'b1;
           end
           else if (wup_s)
           begin : STOP_COND_MAIN_STOP
               stop_cond <= spdpls;
           end  // STOP_COND_MAIN_STOP
           else if (scl & sclout_pre & sdau1) begin    // stop condition detect
                stop_cond <= 1'b1;
           end
           else if (sdau1 | sdad1 | sclu1 | scld1) begin
                stop_cond <= 1'b0;
           end
        end
end
assign t13_lohisel = (start_cond)?    iicwh :
                     (stop_cond)?     iicwl :
                       (scl)?         iicwh :
                                      iicwl ;

assign t13_pre = (tcnt >= t13_lohisel);
assign t13 = t13_pre & ~t06_mask;

////////////////////////
// t40 timing generate
////////////////////////
wire t40_mask;

assign t40_mask = spc0 | setsptp | waitiic | scld1 | sclu1 | stdspd;
assign t40 = t06_pre & ~t40_mask;

////////////////////////
// t47 timing generate
////////////////////////
wire t47_pre;

assign t47_pre = ( tcnt >= iicwl );
assign t47 = t47_pre & ~t40_mask;

////////////////////////
// t50 timing generate
////////////////////////
assign t50 = t13_pre & ~t40_mask;

//////////////// ONW Modified END /////////////////////////


always @ (posedge PECLK or negedge PERESETZ) begin
	if (!PERESETZ) begin
		t13d	<= 1'b0;
		t50d	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin                          // ONW Modified
	else if (!wup & (iice0 | iice0_rst)) begin                          // Mod 20091207 -2
	if (iice0_rst) begin
		t13d	<= 1'b0;
		t50d	<= 1'b0;
	end
//      else if (wup_s)
//      begin : TxxD_MAIN_STOP
//          t13d <= 1'b0;
//          t50d <= 1'b0;
//      end  // TxxD_MAIN_STOP
//      else if (lrelp || stdspd) begin
//          t13d	<= 1'b0;
//          t50d	<= 1'b0;
//      end
	else begin
		t13d	<= t13;
		t50d	<= t50;
	end
	end
end


wire	t13p = t13 & !t13d;
wire	t50p = t50 & !t50d;


// ----- SCLOUT -----

reg	sclstp;                                     // ONW Modified

always @ (posedge PECLK or negedge PERESETZ) begin
	if (!PERESETZ) begin
		sclstp	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin               // ONW Modified
	else if (!wup & (iice0 | iice0_rst)) begin               // Mod 20091207 -2
	if (iice0_rst) begin
		sclstp	<= 1'b0;
	end
        else if (wup_s)
        begin : SCLSTP_MAIN_STOP
            sclstp <= 1'b0;
        end  // SCLSTP_MAIN_STOP
	else if (spten && scl) begin	// SCL=H keep at stop making
		sclstp	<= 1'b1;
	end
	else if (scld1 || spdpls) begin
		sclstp	<= 1'b0;
	end
	end
end

always @ (posedge PECLK or negedge PERESETZ) begin
	if (!PERESETZ) begin
		sclout_pre	<= 1'b1;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin                           // ONW Modified
	else if ( !wup & (iice0 | iice0_rst)) begin                           // Mod 20091207 -2
	if (iice0_rst) begin
		sclout_pre	<= 1'b1;
	end
	else if (lrelp) begin
		sclout_pre	<= 1'b1;
	end
        else if (wup_s)
        begin : SCLOUT_PRE_MAIN_STOP
            sclout_pre <= stdpls | spdpls;
        end  // SCLOUT_PRE_MAIN_STOP
	else if (sclstp) begin	// SCL=H keep at stop making
		sclout_pre	<= 1'b1;
	end
	else if (waitiic) begin	// wait
		sclout_pre	<= 1'b0;
	end
	else if (stt0 && sclout_pre) begin	// scl=H keep at start
		sclout_pre	<= 1'b1;
	end
	else if (aldp) begin	// ALD fail
		sclout_pre	<= 1'b1;
	end
	else if ((sdad1 || sdau1) && sclout_pre && scl) begin	// START/STOP
		sclout_pre	<= 1'b1;
	end 
  	else if (stdpls) begin	// at Start making(detect)
  		sclout_pre	<= 1'b1;
  	end
	else begin
	  casex({msts0, sclu1, scld1, spc0, stf, t13p, t50p, t06, t40}) 
       //remove parallel_case for conformal by k0r
	    9'b11xxxxxxx : sclout_pre <= 1'b1 	;
	    9'b1x1xxxxxx : sclout_pre <= 1'b0  ;
	    9'b1xx11xx1x : sclout_pre <= 1'b0  ; // fast - start  Thd:sta
	    9'b1xx101xxx : sclout_pre <= !sclout_pre; // fast - clock
	    9'b1xx01xxx1 : sclout_pre <= 1'b0  ; // standard - start Thd:sta
	    9'b1xx00x1xx : sclout_pre <= !sclout_pre; // standars - clock
	    9'b0xx1x1xxx : sclout_pre <= 1'b1  ; // rise after wait
	    9'b0xx0xx1xx : sclout_pre <= 1'b1  ; // rise after wait
	    default		 : sclout_pre <= sclout_pre;
	  endcase
	end
	end
end


wire	sclout = (wup_s)? ~wait_s : sclout_pre;                // ONW Modified
wire	sclo   = (wup_s)? iice0 & ~wait_s : iice0 & sclout_pre;        // ONW Modified


endmodule
module QLK0RIICAV2_DATAOUT	(
	PCLK,				// Add 20091118
	PECLK,
	PCLKRW,				// Add 20091118
	PERESETZ,
//	SCANMODE,			// Del 20091209 -5
	SVMOD,				// Del 20091207 -2

	we_iic0,
	we_sva0,
	din,
  
        iica_s,                // ONW Modified
        wup,                   // ONW Modified
        wup_s,                 // ONW Modified
        wait_ch0,              // ONW Modified
//        stdpls,                // ONW Modified
//        spdpls,                // ONW Modified
        sdao_s,                // ONW Modified

	iice0,
	lrelp,
	acker,
	stt0,
	stten,
	spten,
	setsttp,
	msts0,
	exc0,
	coi0,
	trc0,
	std0,
	sclstp,
	scl,
	sclu1,
	sda, 
	waitiic_sdao,           // ONW Modified
	aldp,
	sdad1,
	c8en,
	c8en_sdao,
	c9en_sdao,              // ONW Modified
	t03,
	t06,
	t40,
	spd0,
        iice0_rst,             // ONW RPU

	exccode,
	coicode,
	bufsetp,
	sdaout,
	sdao,
	tsuup,
	iic0,
	sva0,

	prs0 
	);


//--- port direction
input			PCLK;		// Add 20091118
input			PECLK;
input			PCLKRW;		// Add 20091118
input			PERESETZ;
//input			SCANMODE;		// Del 20091209 -5
input			SVMOD;			// Del 20091207 -2

input			we_iic0;
input			we_sva0;
input	[7:0]	din;

input   [7:0]           iica_s;          // ONW Modified
input                   wup;             // ONW Modified
input                   wup_s;           // ONW Modified
input                   wait_ch0;        // ONW Modified
//input                   stdpls;          // ONW Modified
//input                   spdpls;          // ONW Modified
input                   sdao_s;          // ONW Modified

input			iice0;
input			lrelp;
input			acker;
input			stt0;
input			stten;
input			spten;
input			setsttp;
input			msts0;
input			exc0;
input			coi0;
input			trc0;
input			std0;
input			sclstp;
input			scl;
input			sclu1;
input			sda; 
input			waitiic_sdao;           // ONW Modified
input			aldp;
input			sdad1;
input			c8en;
input			c8en_sdao;
input			c9en_sdao;           // ONW Modified
input			t03;
input			t06;
input			t40;
input			spd0;
input                   iice0_rst;

output			exccode;
output			coicode;
output			bufsetp;
output			sdaout;
output			sdao;
output			tsuup;
output	[7:0]	iic0;
output	[7:1]	sva0;

input		prs0 ;			// Add 20091212



//--- logic

// ----- IICBUF -----
reg     [7:0] iicbuf;
//wire    const_iice0, const_we_iic0 ;

//assign  const_iice0   = SCANMODE ? 1'b1 : iice0 ;
//assign  const_we_iic0 = SCANMODE ? 1'b1 : we_iic0 ;
// const del For faults coverage 05/09/29

always @(posedge PCLK or negedge PERESETZ) begin
	if(!PERESETZ) begin
		iicbuf	<= 8'h00;
	end
        else if (!wup & ((iice0 & we_iic0) | iice0_rst)) begin               // ONW Modified
	   if (iice0_rst) begin
	   	iicbuf	<= 8'h00;
	   end
	   else if (we_iic0) begin
	   	iicbuf	<= din[7:0];
	   end
        end
end


// ----- BUFSET -----

reg     bufset, bsdly;
//wire	sebufset;
//assign sebufset	= PERESETZ & (!we_iic0 || SCANMODE);
//assign sebufset	= PERESETZ & ((!we_iic0 || SVMOD) || SCANMODE);

//always @(posedge PECLK or negedge sebufset) begin             // Modify 200609
always @(posedge PCLK or negedge PERESETZ) begin
//      if(!sebufset) begin                                     // Modify 200609
        if(!PERESETZ) begin
                bufset  <= 1'b1;
        end
	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin                          // ONW Modified
        if (!iice0 | we_iic0) begin                             // Modify 200609
                bufset  <= 1'b1;
        end
        else if (wup_s)
        begin : BUFSET_MAIN_STOP
            bufset <= 1'b0;
        end  // BUFSET_MAIN_STOP
        else begin
                bufset  <= 1'b0;
        end
        end
end

always @(posedge PECLK or negedge PERESETZ) begin
	if(!PERESETZ) begin
		bsdly	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin                          // ONW Modified
	else if (!wup & (iice0 | iice0_rst)) begin                          // Mod 20091207 -2
	if (iice0_rst) begin
		bsdly	<= 1'b0;
	end
        else if (wup_s)
        begin : BSDLY_MAIN_STOP
            bsdly <= 1'b0;
        end  // BSDLY_MAIN_STOP
	else begin
//		bsdly	<= bufset;
		bsdly	<= bufset | (prs0 & we_iic0);			// Mod 20091212 
	end
	end
end

wire	bufsetp = bsdly & !bufset;				// Modify 20060903
//wire	bufsetp = bsdly ;					// Modify 20060903

// ----- IICSR -----

reg	[7:0] iic0;

// ONW RPU
always @(posedge PECLK or negedge PERESETZ) begin
        if(!PERESETZ)
                iic0    <= 8'h00;
        else begin
//           if(!SVMOD & !wup & ((iice0 & ((wup_s & wait_ch0) | bufsetp |  (!c8en && sclu1))) | iice0_rst)) begin
           if(!wup & ((iice0 & ((wup_s & wait_ch0) | bufsetp |  (!c8en && sclu1))) | iice0_rst)) begin		// Mod 20091207 -2
              if (iice0_rst)
                iic0    <= 8'h00;
              else if (wup_s)
                 begin : IIC0_MAIN_STOP
                    if (wait_ch0)
                        iic0 <= iica_s;
                    else
                        iic0 <= iic0;
                 end  // IIC0_MAIN_STOP
              else if (bufset)
                   iic0    <= iic0;
              else if (bufsetp)
                   iic0    <= iicbuf;
              else if (msts0 && stt0)
                   iic0    <= iic0;
              else if (!c8en && sclu1)
                   iic0    <= { iic0[6:0], sda };
              else
                   iic0    <= iic0;
           end
        end
end


// ----- SVA -----

reg	[7:1] sva0;

always @(posedge PCLKRW or negedge PERESETZ) begin
	if(!PERESETZ) begin
		sva0	<= 7'h00;
	end
	else if (we_sva0) begin
		sva0	<= din[7:1];
	end
	else begin
		sva0	<= sva0;
	end
end


// ----- EXCCODE & COICODE -----

assign	exccode = ( ( iic0[7:4]==4'b0000 ) | ( iic0[7:4]==4'b1111 ) );
assign	coicode = ( sva0[7:1]==iic0[7:1] );
/*
// ----- SO -----

reg	so;

always @(posedge PECLK or negedge PERESETZ) begin
	if(!PERESETZ) begin
		so	<= 1'b1;
	end
//        else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin               // ONW Modified
        else if (!wup & (iice0 | iice0_rst)) begin               // Mod 20091207 -2
	if (iice0_rst) begin
		so	<= 1'b1;
	end
        else if (wup_s)
        begin : SO_MAIN_STOP
            so <= 1'b1;
        end  // SO_MAIN_STOP
	else if (trc0 && !bufset && !scl) begin
		so	<= iic0[7];
	end
        end
end

wire so_sda;                                           // ONW Modified
wire so_pre;                                           // ONW Modified
wire so_mask;                                          // ONW Modified
assign so_pre = (trc0 && !bufset && !scl && iic0[7]) | so; // ONW Modified
assign so_mask = (trc0 && !bufset && !scl && !iic0[7]);    // ONW Modified
assign so_sda = so_pre & ~so_mask;
*/
wire so_sda;                                           // ONW Modified
assign so_sda = iic0[7];

// ----- SDAO -----
reg	sdaout_pre, tsuup;                             // ONW Modified

always @(posedge PECLK or negedge PERESETZ) begin
	if(!PERESETZ) begin
		tsuup	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin               // ONW Modified
	else if (!wup & (iice0 | iice0_rst)) begin               // Mod 20091207 -2
	if (iice0_rst) begin
		tsuup	<= 1'b0;
	end
        else if (wup_s)
        begin : TSUUP_MAIN_STOP
            tsuup <= 1'b0;
        end  // TSUUP_MAIN_STOP
	else if (lrelp) begin
		tsuup	<= 1'b0;
	end
	else if (!sclstp) begin
		tsuup	<= 1'b0;
	end
	else if (t06 || t40) begin
		tsuup	<= 1'b1;
	end
	end
end

always @(posedge PECLK or negedge PERESETZ) begin
	if(!PERESETZ) begin
		sdaout_pre	<= 1'b1;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin
	else if (!wup & (iice0 | iice0_rst)) begin		// Mod 20091207 -2
	if (iice0_rst) begin
		sdaout_pre	<= 1'b1;
	end
        else if (wup_s)
        begin : SDAOUT_PRE_MAIN_STOP
            sdaout_pre <= 1'b1;
        end  // SDAOUT_PRE_MAIN_STOP
	else if (lrelp) begin
		sdaout_pre	<= 1'b1;
	end
	else if (aldp) begin	// arbitration fail
		sdaout_pre	<= 1'b1;
	end
	else if (spten) begin	// init pulse & stop making
		sdaout_pre	<= 1'b0;
	end
	else if (tsuup) begin	// Tsu:sto making
		sdaout_pre	<= 1'b1;
	end
	else if (stt0) begin
		if (stten) begin
			sdaout_pre	<= 1'b0;
		end
		else if ((msts0 | spd0) && scl && sdad1) begin	// restart kyougou
			sdaout_pre	<= 1'b0;
		end
		else if (!scl && t03) begin						// restart
			sdaout_pre	<= 1'b1;
		end
		else if (setsttp) begin							// restart after start
			sdaout_pre	<= 1'b1;
		end
	end
	else if (waitiic_sdao) begin           // ONW Modified
		if (c8en_sdao || c9en_sdao) begin	// WAIT timing              // ONW Modified
			sdaout_pre	<= 1'b1;
		end
		else begin				// initial wait
			sdaout_pre	<= 1'b0;
		end
	end
	else if (trc0) begin
            casex({ c8en_sdao, t03, (stten && scl)})                                // ONW Modified
		3'bxx1  :		sdaout_pre <= 1'b0 ;
		3'b11x  :		sdaout_pre <= 1'b1 ; // ACK timing
		3'b01x  :		sdaout_pre <= so_sda   ; // normal          // ONW Modified
		default :		sdaout_pre <= sdaout_pre;
	    endcase
	end
	else begin
	    casex({ msts0, coi0, exc0, c8en_sdao, std0, acker, t03 })               // ONW Modified
		7'b01011x1  :	sdaout_pre <= 1'b0  ; // ACK at address
		7'b0101011  :	sdaout_pre <= 1'b0  ; // ACK at data
		7'b0x11x11  :   sdaout_pre <= 1'b0  ; // ACK at ext. code RX
		7'b1xx1x11  :	sdaout_pre <= 1'b0  ; // ACK at master RX
		7'bxxx0xx1  :   sdaout_pre <= 1'b1  ; // ACK end
		default 	:	sdaout_pre <= sdaout_pre;
	    endcase
	end
	end
end

wire	sdaout = (wup_s)? sdao_s : sdaout_pre;     // ONW Modified
//wire	sdao = iice0 & sdaout;
wire	sdao = (wup_s)? iice0 & sdao_s : iice0 & sdaout_pre;     // ONW Modified



endmodule
module QLK0RIICAV2_EXTCNT	(
	PECLK,
	PERESETZ,
//	SVMOD,				// Del 20091207 -2

	scli,
	sdai,
	iice0,
        iice0_rst,
	dfc0,
	intiic,
	sclo,
	sdao, 
	sclout,
	sdaout,
	selscli,
	selsdai,
	scl,
	sda,
	sclu1,
	scld1,
	sdau1,
	sdad1,
	intiic0,
	sclo0,
	sdao0,
	sclo1,
	sdao1
	);


//--- port direction
input			PECLK;
input			PERESETZ;
//input			SVMOD;			// Del 20091207 -2

input			scli;
input			sdai;
input			iice0;
input                   iice0_rst;
input			dfc0;
input			intiic;
input			sclo;
input			sdao; 
input			sclout;
input			sdaout;

output			selscli;
output			selsdai;
output			scl;
output			sda;
output			sclu1;
output			scld1;
output			sdau1;
output			sdad1;
output			intiic0;
output			sclo0;
output			sdao0;
output			sclo1;
output			sdao1;



//--- logic

// ----- Clock Select -----
	// PECLK Only //


// ----- Serial Input Select -----

wire	selscli, selsdai;

  assign selscli = scli ;
  assign selsdai = sdai ;


// ----- Serial Input Digital Filter -----

reg	scl1, scln, scldly, sda1, sdan, sdadly;

always @(posedge PECLK or negedge PERESETZ) begin
        if(!PERESETZ) begin
                scl1    <= 1'b1;
                sda1    <= 1'b1;
        end
//        else if (!SVMOD & (iice0 | iice0_rst)) begin
        else if (iice0 | iice0_rst) begin		// Mod 20091207 -2
        if (iice0_rst) begin
                scl1    <= 1'b1;
                sda1    <= 1'b1;
        end
        else begin
                scl1    <= selscli;
                sda1    <= selsdai;
        end
        end
end

always @(posedge PECLK or negedge PERESETZ) begin   // ONW Modified
	if(!PERESETZ) begin
		scln	<= 1'b1;
	end
//	else if (!SVMOD & (iice0 | iice0_rst)) begin
	else if (iice0 | iice0_rst) begin		// Mod 20091207 -2
	if (iice0_rst) begin
		scln	<= 1'b1;
	end
	else begin
	    casex({ selscli, scl1 }) //synopsys parallel_case
		2'b11  : scln <= 1'b1; 
		2'b00  : scln <= 1'b0;
		default  : scln <= scln;
	    endcase
	end
	end
end

always @(posedge PECLK or negedge PERESETZ) begin   // ONW Modified
	if(!PERESETZ) begin
		sdan	<= 1'b1;
	end
//	else if (!SVMOD & (iice0 | iice0_rst)) begin
	else if (iice0 | iice0_rst) begin		// Mod 20091207 -2
	if (iice0_rst) begin
		sdan	<= 1'b1;
	end
	else begin
	    casex({ selsdai, sda1 }) //synopsys parallel_case
		2'b11	: sdan <= 1'b1;
		2'b00   : sdan <= 1'b0;
		default  : sdan <= sdan;
	    endcase
	end
	end
end

assign	scl = ( dfc0 )? scln : scl1;
assign	sda = ( dfc0 )? sdan : sda1;


// ----- SCL & SDA Edge Detection -----
always @(posedge PECLK or negedge PERESETZ) begin
        if(!PERESETZ) begin
                scldly  <= 1'b1;
                sdadly  <= 1'b1;
        end
//        else if (!SVMOD & (iice0 | iice0_rst)) begin
        else if (iice0 | iice0_rst) begin		// Mod 20091207 -2
        if (iice0_rst) begin
                scldly  <= 1'b1;
                sdadly  <= 1'b1;
        end
        else begin
                scldly  <= scl;
                sdadly  <= sda;
        end
        end
end

wire	sclu1 = scl  & !scldly;
wire	scld1 = !scl &  scldly;
wire	sdau1 = sda  & !sdadly;
//wire	sdad1 = !sda &  sdadly;

//----added by qlnpsiic0v3----
reg     f_mask_pre2, f_mask_pre , f_mask ;

always @(posedge PECLK or negedge PERESETZ) begin
        if(!PERESETZ) begin
                f_mask_pre2     <= 1'b1;
        end
//        else if (!SVMOD & ((iice0 & f_mask) | iice0_rst)) begin
        else if ((iice0 & f_mask) | iice0_rst) begin		// Mod 20091207 -2
        if (iice0_rst) begin
                f_mask_pre2     <= 1'b1;
        end
        else begin
                f_mask_pre2     <= 1'b0;
        end
        end
end

always @(posedge PECLK or negedge PERESETZ) begin
        if(!PERESETZ) begin
                f_mask_pre      <= 1'b1;
        end
//        else if (!SVMOD & ((iice0 & f_mask) | iice0_rst)) begin
        else if ((iice0 & f_mask) | iice0_rst) begin		// Mod 20091207 -2
        if (iice0_rst) begin
                f_mask_pre      <= 1'b1;
        end
        else begin
                f_mask_pre      <= f_mask_pre2;
        end
        end
end

always @(posedge PECLK or negedge PERESETZ) begin
        if(!PERESETZ) begin
                f_mask  <= 1'b1;
        end
//        else if (!SVMOD & ((iice0 & f_mask) | iice0_rst)) begin
        else if ((iice0 & f_mask) | iice0_rst) begin		// Mod 20091207 -2
        if (iice0_rst) begin
                f_mask  <= 1'b1;
        end
        else begin
                f_mask  <= f_mask_pre;
        end
        end
end

wire    sda_mask = (dfc0) ? f_mask : f_mask_pre;
wire    sdad1 = !sda_mask & !sda & sdadly ;


// ----- Output Control -----

 assign sclo0   = sclo ;
 assign sdao0   = sdao ;
 assign intiic0 = intiic ;
 assign sclo1   = sclout ;
 assign sdao1   = sdaout ;






endmodule
module QLK0RIICAV2_IOREG	(
	PCLK,			// Add 20091118
	PECLK,
	PCLKRW,			// Add 20091118
	PERESETZ,
//	SCANMODE,			// Del 20091209 -5
//	SVMOD,			// Del 20091207 -2

	we_iicf0,
	we_iicc0,
	re_iic0,
	re_iicf0,
	re_iicc0,
	re_sva0,
	re_iiccl0,
//	re_iicx0,
	re_iics0,
	re_iicse0,
	re_iicwl0,        // ONW Modified
	re_iicwh0,        // ONW Modified
	din,
        wup,

	scl,
	sda,
	sdaout,
	sclu1,
	scld1,
	sdau1,
	sdad1,
	sclstp,
	cld0,
	dad0,
	spc0,
	dfc0,
//	cl01,             // ONW Modified
//	cl00,             // ONW Modified
	sclout,
	exccode,
	coicode,
//	exccode_pre,           // ONW Modified
//	coicode_pre,           // ONW Modified
	t06,
	t13,
	t40,
	t47,
	t13p,
	t50p,
	c7en,
	c8en,
	c9en,
	iic0,
	sva0,
	tsuup,
//	clx0,             // ONW Modified
        iicwl,           // ONW Modified
        iicwh,           // ONW Modified
	
        exc_s,           // ONW Modified
        coi_s,           // ONW Modified
        trc_s,           // ONW Modified
        wup_s,           // ONW Modified
        wait_ch0,        // ONW Modified
	CK0,

        iice0_rst,      // ONW RPU

	iice0,
//	lrelp,
	lrelrp,
//	wrelp,
	wrelrp,
	spicr,
	wtimr,
	acker,
	stt0t,
	serv,

	msts0,
	aldr,
	exc0,
	coi0,
	trc0,
	std0,
	spd0,
	aldp,

	stten,
	spten,
	stdpls,
	spdpls,
	stf,
	setsttp,
	setsptp,
	stcen,

	dout,

	prs0		// Add 20091118
	);


//--- port direction
input			PCLK;		// Add 20091118
input			PECLK;
input			PCLKRW;		// Add 20091118
input			PERESETZ;
//input			SCANMODE;		// Del 20091209 -5
//input			SVMOD;		// Mod 20091207 -2

input			we_iicf0;
input			we_iicc0;
input			re_iic0;
input			re_iicf0;
input			re_iicc0;
input			re_sva0;
input			re_iiccl0;
//input			re_iicx0;
input			re_iics0;
input			re_iicse0;
input			re_iicwl0;        // ONW Modified
input			re_iicwh0;        // ONW Modified
input	[7:0]	din;
input			wup;

input			scl;
input			sda;
input			sdaout;
input			sclu1;
input			scld1;
input			sdau1;
input			sdad1;
input			sclstp;
input			cld0;
input			dad0;
input			spc0;
input			dfc0;
//input			cl01;         // ONW Modified
//input			cl00;         // ONW Modified
input			sclout;
input			exccode;
input			coicode;
//input			exccode_pre;           // ONW Modified
//input			coicode_pre;           // ONW Modified
input			t06;
input			t13;
input			t40;
input			t47;
input			t13p;
input			t50p;
input			c7en;
input			c8en;
input			c9en;
input	[7:0]		iic0;
input	[7:1]		sva0;
input			tsuup;
//input			clx0;         // ONW Modified
input	[7:0]		iicwl;        // ONW Modified
input	[7:0]		iicwh;        // ONW Modified

input                   exc_s;        // ONW Modified
input                   coi_s;        // ONW Modified
input                   trc_s;        // ONW Modified
input                   wup_s;        // ONW Modified
input                   wait_ch0;     // ONW Modified

input			CK0;
output                  iice0_rst;   // ONW RPU

output			iice0;
//output			lrelp;
output			lrelrp;
//output			wrelp;
//output			wrelr;
output			wrelrp;			// Mod 20091212
output			spicr;
output			wtimr;
output			acker;
output			stt0t;
output			serv;

output			msts0;
output			aldr;
output			exc0;
output			coi0;
output			trc0;
output			std0;
output			spd0;
output			aldp;

output			stten;
output			spten;
output			stdpls;
output			spdpls;
output			stf;
output			setsttp;
output			setsptp;
output			stcen;

output	[15:0]	dout;

input			prs0;			// Add 20091118



//--- reg, wire
reg				iice0;
reg				spicr;
reg				wtimr;
reg				acker;
reg				stt0;
reg				spt0;
reg				stt0r;
reg				spt0r;
reg				sttdly;
reg				sptdly;
wire			lrelr;
wire			wrelr;
wire			spdda;
wire			pre_sttclr;
reg				sttclr;
wire			sttclr_w;
wire			pre_resstt;
//wire			resstt;                  // ONW Modified
//wire			selrel;                  // ONW Modified
wire			stt0t;
wire			pre_resspt;
//wire			resspt;                  // ONW Modified
reg				lrelp;
reg				wrelp;
//wire			sewrel;                  // ONW Modified
wire			setsttp;
wire			setsptp;
reg				stten;
reg				spten;

reg				stcen;
reg				iicrsv;
//wire			res_stdpls;              // ONW Modified
wire			iicbsy;
reg				stm;
reg				stcf;

reg				msts0;
reg				exc0;
reg				coi0;
reg				trc0;
reg				ackd0;
reg				std0;
reg				spd0;
reg				aldm;
reg				trcm;
reg				stddly;
reg				stf;
reg				serv;
//wire			retrc;

//wire			stop_stddly;
wire			stdpls;
reg				spdpls;

//wire			lrelr_scan;
//wire			wrelr_scan;
//wire	[15:0]	dout;
reg	[15:0]	dout;						// Mod 20100124

wire			iice0_rst, pre_iice0_rst;		// Add 20091207 -4
reg			iice0_rst_r;				// Add 20091207 -4
reg			re_iics0_r;				// Add 20091209 -5

//--- logic

// ----- IICC register -----
always @ (posedge PCLKRW or negedge PERESETZ) begin		// Mod 20091118
	if (!PERESETZ) begin
                iice0   <= 1'b0;
		spicr	<= 1'b0;
		wtimr	<= 1'b0;
		acker	<= 1'b0;
	end
	else if (we_iicc0) begin
                iice0   <= din[7];
		spicr	<= din[4];
		wtimr	<= din[3];
		acker	<= din[2];
	end
	else begin
                iice0   <= iice0;
		spicr	<= spicr;
		wtimr	<= wtimr;
		acker	<= acker;
	end
end

assign	iice0_rst = pre_iice0_rst | iice0_rst_r ;		// Mod 20091207 -4

//assign iice0_rst = we_iicc0 & (din[7] != iice0);		Mod 20091207 -4
assign pre_iice0_rst = we_iicc0 & (din[7] != iice0);

always@(posedge PCLK or negedge PERESETZ) begin			// Add 20091207 -4 -5
	if ( ~PERESETZ) begin
	 	iice0_rst_r	<= 1'b0 ;
		re_iics0_r	<= 1'b0 ;
	end
	else if ( prs0 ) begin
		iice0_rst_r	<= pre_iice0_rst ;
		re_iics0_r	<= re_iics0 ;
	end
end

//LREL0, WREL0
assign lrelr	= we_iicc0 & din[6];	//finish write cycle -> 0
assign wrelr	= we_iicc0 & din[5];	//finish write cycle -> 0

assign	lrelrp	= lrelr |  lrelp ;
assign	wrelrp  = wrelr |  wrelp ;

//STT0
assign spdda	= (spd0 | stcen) & (sda | sdad1) & (!sdau1);
assign pre_sttclr	= iicrsv & (!msts0) & (std0 || (!spdda));

always @ (posedge PECLK or negedge PERESETZ) begin
	if (!PERESETZ) begin
		sttclr	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin               // ONW Modified
	else if (!wup & (iice0 | iice0_rst)) begin               // Mod 20091207 -2
	if (iice0_rst) begin
		sttclr	<= 1'b0;
	end
	else begin
		sttclr	<= pre_sttclr & stt0;
	end
	end
end

assign sttclr_w		= sttclr ;



//assign pre_resstt	= (!sttclr_w) & (PERESETZ && (!aldp) && (!(stdpls && msts0))) ;
//assign pre_resstt	= ( (!sttclr_w) & ( (!aldp) && (!(stdpls && msts0))) ) | SVMOD ;
assign pre_resstt	= ( (!sttclr_w) & ( (!aldp) && (!(stdpls && msts0))) ) ;	// Mod 20091207 -2
//assign resstt	= (SCANMODE) ? PERESETZ : pre_resstt;


//--------------------------------------------------------------
//	20060901
//	make syncronus reset signal [ pre_resstt]
//--------------------------------------------------------------
wire	s_sttclr_w = pre_sttclr & stt0 ;

wire	s_aldp1	= msts0 && sclu1 && trc0 && !c8en && !sda && sdaout ;
wire	s_aldp2 = msts0 && sclu1 && !trc0 && c8en && !sda && sdaout ;
wire	s_aldp3 = msts0 && sclu1 && !sda && sdaout && stt0t ;
wire	s_aldp4 = msts0 && sclstp && scld1 ;
wire	s_aldp5 = msts0 && stt0t && scld1 ;
wire	s_aldp6 = msts0 && scl && sdad1 && !stt0t && sclout ;
wire	s_aldp7 = msts0 && scl && !sclu1 && sdau1 && !spt0 && sclout ;
wire	s_aldp  = s_aldp1 | s_aldp2 | s_aldp3 | s_aldp4 | s_aldp5 | s_aldp6 | s_aldp7 ;

//wire	s_start = msts0 & scl & sdad1 & sclout & ~stddly ;
wire	pre_s_start = scl & sdad1 & sclout & ~stddly ;
wire	s_start = msts0 & pre_s_start ;

//wire	s_pre_resstt = ( s_sttclr_w | s_aldp | s_start ) & ~SVMOD  ;
wire	s_pre_resstt = ( s_sttclr_w | s_aldp | s_start )  ;		// Mod 20091207 -2
//wire	sync_resstt = s_pre_resstt | pre_resstt ;				// Modify 20060905
wire	sync_resstt = s_pre_resstt | ~pre_resstt ;				// Modify 20060905

//SPT0
//assign pre_resspt     = PERESETZ & (!aldp) & (!spdpls);
//assign pre_resspt       = ((!aldp) && (!spdpls)) | SVMOD;
assign pre_resspt       = ((!aldp) && (!spdpls)) ;		// Mod 20091207 -2
//assign resspt         = (SCANMODE) ? PERESETZ : pre_resspt;

wire    s_spdpls = scl & sclout & !sclu1 & sdau1 ;
//wire    s_pre_resspt =  (s_aldp | s_spdpls) & ~SVMOD  ;
wire    s_pre_resspt =  (s_aldp | s_spdpls) ;		// Mod 20091207 -2
wire    sync_resspt = s_pre_resspt | ~pre_resspt ;                      // Modify       20060905

//wire    pre_res_stcen = (pre_s_start | stdpls) & ~SVMOD ;
wire    pre_res_stcen = (pre_s_start | stdpls) ;		// Mod 20091207 -2

//----------------------------------------------------------------

// For DFT								// Modify 200609
//QLK0RIICAV2_SCAN_MASK scan_mask_stt (
//	.A_IN(PERESETZ),
//	.B_IN(pre_resstt),
//	.EN(SCANMODE),
//	.C_OUT(resstt)
//	);

//always @ (posedge PECLK or negedge resstt) begin			// Modify 20060901
always @ (posedge PCLK or negedge PERESETZ) begin			// Mod 20091118
//	if (!resstt) begin
	if (!PERESETZ) begin
		stt0r	<= 1'b0;
	end
        else begin
           if(sync_resstt | we_iicc0 | sync_resspt | we_iicf0 | pre_res_stcen) begin
	      if ( sync_resstt )		
                 stt0r <= 1'b0 ;		// Modify 20060901 
	      else if (we_iicc0) begin
		if ((!din[7]) || din[6]) begin
			stt0r	<= 1'b0;
		end
		else if (stten) begin
			stt0r	<= stt0r;
		end
		else if (din[1]) begin		//"0"write nothing
			stt0r	<= 1'b1;
		end
	     end
          end
       end
end


//assign selrel	= PERESETZ & ((!lrelr) || SCANMODE);
//assign selrel	= PERESETZ & ( ((!lrelr) || SVMOD) || SCANMODE );		// Modify 200609

//always @ (posedge PECLK or negedge selrel) begin			// Modify 20060901
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!selrel) begin						// Modify 20060901
	if (!PERESETZ) begin
		stt0	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin                                   // ONW Modified
	else if (!wup & (iice0 | iice0_rst)) begin                                   // Mod 20091207 -2
	if (iice0_rst ) begin					// Modify 20060901		// MD_0905
		stt0	<= 1'b0;
	end

	else if (aldp || lrelrp || sttclr_w) begin			// ALD : Clear
		stt0	<= 1'b0;                                    	// LREL : Clear
	end                                                     	// STTCLR_W : STCF set & STT0  Clear

	else if ((msts0 || spd0 || stcen) && scl && sdad1) begin	// Master & Clear
		stt0	<= 1'b0;                                    	// STOP  & Start detect & Clear
	end                                                     	// STCEN & Start detect & Clear

	else if ((!msts0) && (exc0 || coi0) && (!iicrsv)) begin		// Slave Select -> Start Reserve
		stt0	<= 1'b0;
	end
	else if (stten) begin						// Start & Hold
		stt0	<= stt0;
	end
	else if (stt0r) begin						// Sampling
		stt0	<= 1'b1;
	end
	end
end

assign stt0t	= stt0 & (!pre_sttclr);


//SPT0
//----------------------------------------------------------------
// For DFT								// Modify 200609
//QLK0RIICAV2_SCAN_MASK scan_mask_spt (	
//	.A_IN(PERESETZ),
//	.B_IN(pre_resspt),
//	.EN(SCANMODE),
//	.C_OUT(resspt)
//	);

//always @ (posedge PECLK or negedge resspt) begin			// Modify 20060901
always @ (posedge PCLK or negedge PERESETZ) begin			// Mod 20091118
//	if (!resspt) begin						// Modify 20060901
	if (!PERESETZ) begin
		spt0r	<= 1'b0;
	end
        else begin
           if(sync_resstt | we_iicc0 | sync_resspt | we_iicf0 | pre_res_stcen) begin
	      if ( sync_resspt )
           	spt0r <= 1'b0 ;		// Modify 20060901
	      else if (we_iicc0) begin
		if (spd0 && (!std0)) begin
			spt0r	<= 1'b0;
		end
		else if ((!din[7]) || din[6]) begin
			spt0r	<= 1'b0;
		end
		else if (din[0]) begin		//"0"write nothing
			spt0r	<= 1'b1;
		end
              end
           end
       end
end



//always @ (posedge PECLK or negedge selrel) begin		// Modify 20060901
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!selrel) begin					// Modify 20060901
	if (!PERESETZ) begin
		spt0	<= 1'b0;
	end
//	else if (!SVMOD & !wup_s & (iice0 | iice0_rst)) begin                           // ONW Modified
	else if (!wup_s & (iice0 | iice0_rst)) begin                           // Mod 20091207 -2
           if (iice0_rst) 			// Modify 20060901		// MD_0905
		spt0	<= 1'b0;
	   else if (aldp || lrelrp) 				// ALD : Clear
		spt0	<= 1'b0;                        	// LREL : Clear
	   else if (spd0 && (!std0))
		spt0	<= 1'b0;
	   else if (spt0r)
		spt0	<= 1'b1;
	end
end



//lrelp, wrelp

/*
//always @ (posedge PECLK or negedge selrel) begin		// Modify 20060901
always @ (posedge PCLK or negedge PERESETZ) begin		// Mod 20091118
//	if (!selrel) begin					// Modify 20060901
	if (!PERESETZ) begin
		lrelp	<= 1'b1;
	end
//        else if (!SVMOD & !wup_s & (iice0 | iice0_rst)) begin                           // ONW Modified
        else if (!wup_s & (iice0 | iice0_rst)) begin                           // Mod 20091207 -2
	if (iice0_rst | lrelr) begin				// Modify 20060901
		lrelp	<= 1'b1;
	end
	else begin
		lrelp	<= 1'b0;
	end
	end
end

//assign sewrel	= PERESETZ & ((!wrelr) || SCANMODE);
//assign sewrel	= PERESETZ & ( ((!wrelr) || SVMOD) || SCANMODE );		// Modify 200609


//always @ (posedge PECLK or negedge sewrel) begin		// Modify 20060901
always @ (posedge PCLK or negedge PERESETZ) begin		// Mod 20091118
//	if (!sewrel) begin					// Modify 20060901
	if (!PERESETZ) begin
		wrelp	<= 1'b1;
	end
//        else if (!SVMOD & !wup_s & (iice0 | iice0_rst)) begin                           // ONW Modified
        else if (!wup_s & (iice0 | iice0_rst)) begin                           // Mod 20091207 -2
	if (iice0_rst | wrelr) begin				// Modify 20060901
		wrelp	<= 1'b1;
	end
	else begin
		wrelp	<= 1'b0;
	end
	end
end
*/

// Modify IICAV2  	20091209

always@(posedge PCLK or negedge PERESETZ) begin
	if (~PERESETZ) begin
		lrelp		<= 1'b1 ;
		wrelp		<= 1'b1 ;
	end
	else if ( !wup_s & (iice0 | iice0_rst) ) begin
	    if ( iice0_rst ) begin
		lrelp		<= 1'b1 ;
		wrelp		<= 1'b1 ;
	    end
	    else begin
		lrelp		<= lrelr ;
		wrelp		<= wrelr ;
	    end
	end
end


//setsttp, setsptp
reg		aldr;
wire ioreg_lt_pls = (sttdly != stt0) | (sptdly != spt0) | (aldr != aldm);

always @ (posedge PECLK or negedge PERESETZ) begin
	if (!PERESETZ) begin
		sttdly	<= 1'b0;
		sptdly	<= 1'b0;
                aldr    <= 1'b0;
	end
//	else if (!SVMOD & !wup_s & ((iice0 & ioreg_lt_pls) | iice0_rst)) begin               // ONW Modified
	else if (!wup_s & ((iice0 & ioreg_lt_pls) | iice0_rst)) begin               // Mod 20091207 -2
	if (iice0_rst) begin
		sttdly	<= 1'b0;
		sptdly	<= 1'b0;
                aldr    <= 1'b0;
	end
	else begin
		sttdly	<= stt0;
		sptdly	<= spt0;
                aldr    <= aldm;
	end
	end
end

assign setsttp	= stt0t & (!sttdly);

assign setsptp	= spt0 & (!sptdly);




// ----- IICF register -----
//IICRSV
always @ (posedge PCLKRW or negedge PERESETZ) begin		// Mod 20091118
	if (!PERESETZ) begin
		iicrsv	<= 1'b0;
	end
        else if(sync_resstt | we_iicc0 | sync_resspt | we_iicf0 | pre_res_stcen) begin				// CHECK!!
           if (we_iicf0) begin
   		iicrsv	<= din[0];
        	end
	   else begin
		iicrsv	<= iicrsv;
           end
        end
end

//STCEN
//assign res_stdpls	= (PERESETZ && ((!stdpls) || SCANMODE));
//assign res_stdpls	= PERESETZ & ( ((!stdpls) || SVMOD) || SCANMODE );
//wire	pre_res_stdpls;
//assign pre_res_stdpls	= (!stdpls) | SVMOD;				// Modify 200609

// For DFT								// Modify 200609
//QLK0RIICAV2_SCAN_MASK scan_mask_stcen (
//	.A_IN(PERESETZ),
//	.B_IN(pre_res_stdpls),
//	.EN(SCANMODE),
//	.C_OUT(res_stdpls)
//	);

//always @ (posedge PECLK or negedge res_stdpls) begin			// Modify 200609
always @ (posedge PCLK or negedge PERESETZ) begin			// Mod 20091118
//	if (!res_stdpls) begin						// Modify 200609
	if (!PERESETZ) begin
		stcen	<= 1'b0;
	end
        else if(sync_resstt | we_iicc0 | sync_resspt | we_iicf0 | pre_res_stcen) begin
	   if ( pre_res_stcen & CK0 )
              stcen <= 1'b0 ;		// Modify 200609	
	   else if (we_iicf0)
              stcen	<= din[1];
	   else
		stcen	<= stcen;
       end
end

//IICBSY
assign iicbsy	= iice0 & (!(((!std0 || !stm) && spd0) || stcen));

//STCF
always @ (posedge PECLK or negedge PERESETZ) begin
	if (!PERESETZ) begin
		stcf	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin               // ONW Modified
	else if ( !wup & (iice0 | iice0_rst)) begin               // Mod 20091207 -2
	if (iice0_rst) begin
		stcf	<= 1'b0;
	end
	else if (!stt0) begin
		stcf	<= stcf;
	end
	else begin
		stcf	<= sttclr;
	end
	end
end




//stten
//always @ (posedge PECLK or negedge selrel) begin		// Modify 20060901
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!selrel) begin					// Modify 20060901
	if (!PERESETZ) begin
		stten	<= 1'b0;
	end
//	else if (!SVMOD & !wup_s & (iice0 | iice0_rst)) begin                           // ONW Modified
	else if (!wup_s & (iice0 | iice0_rst)) begin                           // Mod 20091207 -2
	if (iice0_rst | lrelr ) begin				// Modify 20060901
		stten	<= 1'b0;
	end
	else if (aldp) begin
		stten	<= 1'b0;
	end
	else if ((!scl) || tsuup) begin
		stten	<= 1'b0;
	end
	else if (sclu1) begin
		stten	<= 1'b0;
	end
	else if (stt0t && (!spdpls)) begin
		casex({ spdda, msts0, spc0, t06, t13, t47, sdad1  })
		//remove parallel_case for conformal by k0r
		7'b1x1x1xx :     stten <= 1'b1; // fast normal Start < Tbuf >
		7'b1x0xx1x :     stten <= 1'b1; // std. normal Start < Tbuf >
		7'b0111xxx :     stten <= 1'b1; // fast Re_Start < Tsu:sta >
		7'b010xx1x :     stten <= 1'b1; // std. Re_Start < Tsu:sta >
		7'b1xxxxx1 :	 stten <= 1'b1;
		7'b01xxxx1 :	 stten <= 1'b1;
		default    :	 stten <= stten;
		endcase
	end
	end
end


//spten
//always @ (posedge PECLK or negedge selrel) begin		// Modify 20060901
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!selrel) begin					// Modify 20060901
	if (!PERESETZ) begin
		spten	<= 1'b0;
	end
//	else if (!SVMOD & !wup_s & (iice0 | iice0_rst)) begin                           // ONW Modified
	else if (!wup_s & (iice0 | iice0_rst)) begin                           // Mod 20091207 -2
	if (iice0_rst | lrelr ) begin				// Modify 20060901
		spten	<= 1'b0;
	end
	else if (spd0) begin
		spten	<= 1'b0;
	end
	else if (!spt0) begin
		if (!scl) begin
			spten	<= 1'b0;
		end
	end
	else if (!sdau1) begin
		casex({ msts0, scl, scld1, spc0, sda, t06, t40, t13p, t50p })
		//synopsys parallel_case
		9'b100xxxxxx : spten <= 1'b1; // master end SDA L
		9'b11x1x1xxx : spten <= 1'b0; // master end SDA H<Tsu:sto>
		9'b11x0xx1xx : spten <= 1'b0; // master end SDA L<Tsu:sto>
		9'b001xxxxxx : spten <= 1'b1; // slave
		9'b01x11xx1x : spten <= 1'b1; // fast init SDA L
		9'b01x01xxx1 : spten <= 1'b1; // std. init SDA L
		9'b01x10xx1x : spten <= 1'b0; // fast init SDA H
		9'b01x00xxx1 : spten <= 1'b0; // std. intitSDA H
		// 通信初期状態では、pulseを使用しないと発振してしまう為。
		default      : spten <= spten;
		endcase
	end
	end
end




// ----- IICS register -----
//MSTS
//always @ (posedge PECLK or negedge selrel) begin		// Modify 20060901
always @ (posedge PECLK or negedge PERESETZ) begin		
//	if (!selrel) begin					// Modify 20060901
	if (!PERESETZ) begin
		msts0	<= 1'b0;
	end
//	else if (!SVMOD & !wup_s & (iice0 | iice0_rst)) begin                           // ONW Modified
	else if (!wup_s & (iice0 | iice0_rst)) begin                           // Mod 20091207 -2
//	if (iice0_rst | lrelr ) begin				// Modify 20060901
	if (iice0_rst | lrelrp ) begin				// Modify 20091219
		msts0	<= 1'b0;
	end
	else if (aldp) begin	// ALD fail
		msts0	<= 1'b0;
	end
	else if (scl && sclout && (!sclu1) && sdau1) begin	// stop
		msts0	<= 1'b0;
	end
	else if ((spd0 || stcen) && stt0t && scl && sdad1) begin	// MSTS set
		msts0	<= 1'b1;
	end
	end
end


//ALD0

always @ (posedge PECLK or negedge PERESETZ) begin
	if (!PERESETZ) begin
		aldm	<= 1'b0;
	end
//	else if (!SVMOD & !wup_s & (iice0 | iice0_rst)) begin               // ONW Modified
	else if ( !wup_s & (iice0 | iice0_rst)) begin               // Mod 20091207 -2
	if (iice0_rst) begin
		aldm	<= 1'b0;
	end
//	else if (re_iics0 ) begin
	else if (re_iics0 | re_iics0_r) begin				// Mod 20091209 -5
		aldm	<= 1'b0;
	end
	else if ( msts0 && sclu1 && trc0 && !c8en && !sda && sdaout ) begin
		aldm <= 1'b1;	// master TX
	end
	else if ( msts0 && sclu1 && !trc0 && c8en && !sda && sdaout ) begin
		aldm <= 1'b1;	// master TX  ACK fail
	end
	else if ( msts0 && sclu1 && !sda && sdaout && stt0t ) begin
		aldm <= 1'b1;	// restart making fail
	end
	else if ( msts0 && sclstp && scld1 ) begin
		aldm <= 1'b1;	// can't make stop condition
	end
	else if ( msts0 && stt0t && scld1 ) begin
		aldm <= 1'b1;	// can't make start
	end
	else if ( msts0 && scl && sdad1 && !stt0t && sclout ) begin
		aldm <= 1'b1;	// be restart by others
	end
	else if ( msts0 && scl && !sclu1 && sdau1 && !spt0 && sclout ) begin
		aldm <= 1'b1;	// stop detect
	end
	end
end

wire	aldp = iice0 & aldm & !aldr;


//EXC
//always @ (posedge PECLK or negedge selrel) begin			// Modify 20060901
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!selrel) begin						// Modify 20060901
	if (!PERESETZ) begin
		exc0	<= 1'b0;
	end
//      else if (!SVMOD & ((iice0 & (lrelr | wup_s | stdpls | spdpls | (std0 && c7en && scl && (!sclu1)))) | iice0_rst)) begin
//        else if (!SVMOD & (iice0 | iice0_rst)) begin
        else if (iice0 | iice0_rst) begin			// Mod 20091207 -2
//	if (iice0_rst | lrelr) begin					// Modify 20060901
	if (iice0_rst | lrelrp) begin					// Modify 20091219
		exc0	<= 1'b0;
	end
        else if ( wup_s ) begin                                         // ONW Modified
                exc0    <= exc_s;                                       // ONW Modified
        end                                                             // ONW Modified
  	else if (stdpls || spdpls) begin	 // Start or Stop
  		exc0	<= 1'b0;
	end
	else if (std0 && c7en && scl && (!sclu1)) begin
		exc0	<= exccode;
//	else if (std0 && c7en && scl && sclu1) begin                    // ONW Modified
//		exc0	<= exccode_pre;                                 // ONW Modified
	end
	end
end

//COI
//always @ (posedge PECLK or negedge selrel) begin			// Modify 20060901
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!selrel) begin						// Modify 20060901
	if (!PERESETZ) begin
		coi0	<= 1'b0;
	end
//      else if (!SVMOD & ((iice0 & (lrelr | wup_s | stdpls | spdpls | (std0 && c7en && scl && (!sclu1)))) | iice0_rst)) begin
//        else if (!SVMOD & (iice0 | iice0_rst)) begin
        else if (iice0 | iice0_rst) begin				// Mod 20091207 -2
//	if (iice0_rst | lrelr) begin					// Modify 20060901	
	if (iice0_rst | lrelrp) begin					// Modify 20091219	
		coi0	<= 1'b0;
	end
        else if ( wup_s ) begin                                         // ONW Modified
                coi0    <= coi_s;                                       // ONW Modified
        end                                                             // ONW Modified
	else if (stdpls || spdpls) begin	 // Start or Stop
		coi0	<= 1'b0;
	end
	else if (std0 && c7en && scl && (!sclu1)) begin
		coi0	<= coicode;
//	else if (std0 && c7en && scl && sclu1) begin                    // ONW Modified
//		coi0	<= coicode_pre;                                 // ONW Modified
	end
	end
end


//serv
//always @ (posedge PECLK or negedge selrel) begin			// Modify 20060901
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!selrel) begin						// Modify 20060901
	if (!PERESETZ) begin
		serv	<= 1'b0;
	end
//	else if (!SVMOD & !wup_s & (iice0 | iice0_rst)) begin                                   // ONW Modified
	else if (!wup_s & (iice0 | iice0_rst)) begin                                   // Mod 20091207 -2
//	if (iice0_rst | lrelr ) begin					// Modify 20060901
	if (iice0_rst | lrelrp ) begin					// Modify 20091219
		serv	<= 1'b0;
	end
	else if (spd0) begin
		serv	<= 1'b0;
	end
	else if (c9en && sclu1) begin
		serv	<= 1'b0;
	end
	else if (stdpls && (exc0 || coi0)) begin	//リスタート時にセット
		serv	<= 1'b1;
	end
	end
end


//TRC
//wire	retrc = iice0 & !lrelr & ~( c9en & wrelr );
//assign retrc	= (SCANMODE) ? PERESETZ : ((!lrelr) && (!(c9en && wrelr)));
//assign retrc	= (SCANMODE) ? PERESETZ : ((!lrelr) && (!(c9en && wrelr))) | SVMOD ;
//assign retrc	= PERESETZ & ( (((!lrelr) && (!(c9en && wrelr))) || SVMOD) || SCANMODE ) ;

//always @ (posedge PECLK or negedge retrc) begin			// Modify 20060903
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!retrc) begin						// Modify 20060903
	if (!PERESETZ) begin
		trcm	<= 1'b0;
	end
//  	else if (!SVMOD & (iice0 | iice0_rst)) begin
  	else if (iice0 | iice0_rst) begin			// Mod 20091207 -2
//	if (iice0_rst | lrelr | (c9en & wrelr) ) begin			// Modify 20060903
	if (iice0_rst | lrelrp | (c9en & wrelrp) ) begin			// Modify 20091219
		trcm	<= 1'b0;
	end
        else if ( wup_s  ) begin                                         // ONW Modified
		trcm	<= trc_s;                                       // ONW Modified
        end                                                             // ONW Modified
	else if (scl && sdau1) begin	// OFF by stet
		trcm	<= 1'b0;
	end
	else if (spdpls) begin			// till c7en(std0) is down by stop
		trcm	<= 1'b0;
	end
	else if (aldp) begin			// ALD fail
		trcm	<= 1'b0;
	end
	else if (stdpls) begin			// init
		if (stten) begin
			trcm	<= 1'b1;
		end
		else begin
			trcm	<= 1'b0;
		end
	end
	else if (scl && std0 && c7en && sda) begin
		if (msts0) begin					// master TX
			trcm	<= 1'b0;
		end
		else if (coicode || exccode) begin	// slave TX
			trcm	<= 1'b1;
		end
		else begin
			trcm	<= 1'b0;
		end
	end
	end
end

//always @ (posedge PECLK or negedge retrc) begin			// Modify 20060903
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!retrc) begin						// Modify 20060903
	if (!PERESETZ) begin
		trc0	<= 1'b0;
	end
//	else if (!SVMOD & !wup_s & (iice0 | iice0_rst)) begin                                   // ONW Modified
	else if (!wup_s & (iice0 | iice0_rst)) begin                                   // Mod 20091207 -2
//	if (iice0_rst | lrelr | (c9en & wrelr) ) begin			// Modify 20060903
	if (iice0_rst | lrelrp | (c9en & wrelrp) ) begin			// Modify 20091219
		trc0	<= 1'b0;
	end
	else if (aldp) begin
		trc0	<= 1'b0;
	end
	else if ((!c7en) && (!c8en)) begin
		trc0	<= trcm;
	end
	end
end


//ACKD
//always @ (posedge PECLK or negedge selrel) begin			// Modify 200609
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!selrel) begin						// Modify 200609
	if (!PERESETZ) begin
		ackd0	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin                                   // ONW Modified
	else if (!wup & (iice0 | iice0_rst)) begin                                   // Mod 20091207 -2
//	if (iice0_rst | lrelr) begin					// Modify 200609
	if (iice0_rst | lrelrp) begin					// Modify 20091219
		ackd0	<= 1'b0;
	end
        else if (wup_s)
        begin : ACKD0_MAIN_STOP
            ackd0 <= wait_ch0 & ~exc0;
        end  // ACKD0_MAIN_STOP
	else if (spdpls) begin
		ackd0	<= 1'b0;
	end
	else if (sclu1) begin
		if (c8en && (!sda)) begin
			ackd0	<= 1'b1;
		end
		else begin
			ackd0	<= 1'b0;
		end
	end
	end
end


//STD
//always @ (posedge PECLK or negedge selrel) begin			// Modify 200609
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!selrel) begin						// Modify 200609
	if (!PERESETZ) begin
		stm	<= 1'b0;
	end
//	else if (!SVMOD & (iice0 | iice0_rst)) begin                                   // ONW Modified
	else if (iice0 | iice0_rst) begin                                   // Mod 20091207 -2
//	if (iice0_rst | lrelr ) begin					// Modify 200609
	if (iice0_rst | lrelrp ) begin					// Modify 20091219
		stm	<= 1'b0;
	end
        else if (wup) begin            // ONW Modified
                stm     <= 1'b0;                                        // ONW Modified
        end                                                             // ONW Modified
	else if (sclu1) begin
		stm	<= 1'b0;
	end
	else if (spdpls) begin
		stm	<= 1'b0;
	end
	else if (scl && sdad1 && sclout) begin
		stm	<= 1'b1;
	end
	end
end

//always @ (posedge PECLK or negedge selrel) begin			// Modify 200609
always @ (posedge PECLK or negedge PERESETZ) begin
//	if (!selrel) begin						// Modify 200609
	if (!PERESETZ) begin
		std0	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin                                   // ONW Modified
	else if (!wup & (iice0 | iice0_rst)) begin                                   // Mod 20091207 -2
//	if (iice0_rst | lrelr ) begin					// Modify 200609
	if (iice0_rst | lrelrp ) begin					// Modify 20091219
		std0	<= 1'b0;
	end
        else if (wup_s)
        begin : STD0_MAIN_STOP
            std0 <= wait_ch0;
        end  // STD0_MAIN_STOP
	else if (stdpls || spdpls) begin
		std0	<= 1'b0;
	end
	else if (c9en && sclu1) begin
		std0	<= 1'b0;
	end
	else if (stm) begin
		std0	<= 1'b1;
	end
	end
end


//SPD
always @ (posedge PECLK or negedge PERESETZ) begin
	if (!PERESETZ) begin
		spd0	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin               // ONW Modified
	else if (!wup & (iice0 | iice0_rst)) begin               // Mod 20091207 -2
	if (iice0_rst) begin
		spd0	<= 1'b0;
	end
        else if (wup_s)
        begin : SPD0_MAIN_STOP
            spd0 <= spdpls;
        end  // SPD0_MAIN_STOP
	else if (setsptp) begin
		spd0	<= 1'b0;
	end
	else if (std0 && sclu1) begin
		spd0	<= 1'b0;
	end
	else if (scl && sclout && (!sclu1) && sdau1) begin
		spd0	<= 1'b1;
	end
	end
end




//stdpls
always @ (posedge PECLK or negedge PERESETZ) begin
	if (!PERESETZ) begin
		stddly	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin               // ONW Modified
	else if (!wup & (iice0 | iice0_rst)) begin               // Mod 20091207 -2
	if (iice0_rst) begin
		stddly	<= 1'b0;
	end
	else begin
		stddly	<= stm;
	end
	end
end

//assign stop_stddly	= (SCANMODE) ? 1'b1 : stddly ;
//assign stdpls		= iice0 & stm & (!stop_stddly);
assign stdpls		= iice0 & stm & (!stddly);			//For faults coverage


//spdpls
always @ (posedge PECLK or negedge PERESETZ) begin
	if (!PERESETZ) begin
		spdpls	<= 1'b0;
	end
//	else if (!SVMOD & (iice0 | iice0_rst)) begin
	else if (iice0 | iice0_rst) begin			// Mod 20091207 -2
	if (iice0_rst) begin
		spdpls	<= 1'b0;
	end
        else if (wup) begin                  // ONW Modified
		spdpls	<= 1'b0;
        end
	else begin
		spdpls	<= (scl && sclout && (!sclu1) && sdau1);
	end
	end
end


//stf
always @ (posedge PECLK or negedge PERESETZ) begin
	if (!PERESETZ) begin
		stf	<= 1'b0;
	end
//	else if (!SVMOD & !wup_s & (iice0 | iice0_rst)) begin               // ONW Modified
	else if (!wup_s & (iice0 | iice0_rst)) begin               // Mod 20091207 -2
	if (iice0_rst) begin
		stf	<= 1'b0;
	end
	else if (spdpls || scld1) begin
		stf	<= 1'b0;
	end
	else if ((!msts0) && (!spd0) && (!stcen)) begin
		stf	<= 1'b0;
	end
	else if (sdad1 && scl && stt0t) begin
		stf	<= 1'b1;
	end
	end
end




// ----- DATA READ -----
//assign	lrelr_scan	= lrelr | SCANMODE;
//assign	wrelr_scan	= wrelr | SCANMODE;
// wire del For faults coverage

//assign dout	= (re_iic0)		? {8'h00, iic0}
//			: (re_iicf0)	? {stcf, iicbsy, 4'b0000, stcen, iicrsv, 8'h00}
////			: (re_iicc0)	? {8'h00, iice0, lrelr_scan, wrelr_scan, spicr, wtimr, acker, 2'b00}
////			: (re_iicc0)	? {8'h00, iice0, lrelr, wrelr, spicr, wtimr, acker, 2'b00}
//			: (re_iicc0)	? {8'h00, iice0, 2'b00, spicr, wtimr, acker, 2'b00}				// for timing loop 051104
//			: (re_sva0)		? {sva0[7:1], 1'b0, 8'h00}
//			: (re_iiccl0)	? {8'h00,  2'b00 , cld0 , dad0 , spc0 , dfc0 , cl01 , cl00}
//			: (re_iicx0)	? {7'b0000000, clx0, 8'h00}
//			: (re_iics0)	? {8'h00, msts0, aldm, exc0, coi0, trcm, ackd0, std0, spd0}
//			: (re_iicse0)	? {msts0, aldm, exc0, coi0, trcm, ackd0, std0, spd0, 8'h00}
//			: 16'h0000;
/*
assign dout	=         (re_iic0)	? {8'h00, iic0}
			: (re_iics0)	? {msts0, aldm, exc0, coi0, trcm, ackd0, std0, spd0, 8'h00}
			: (re_iicf0)	? {8'h00, stcf, iicbsy, 4'b0000, stcen, iicrsv}
			: (re_iicc0)	? {8'h00, iice0, 2'b00, spicr, wtimr, acker, 2'b00}	// for timing loop 051104
			: (re_iiccl0)	? {wup , 1'b0 , cld0 , dad0 , spc0 , dfc0 , 1'b0 , prs0 , 8'h00}		// Mod 20091118
			: (re_iicwl0)	? {8'h00,iicwl}
			: (re_iicwh0)	? {iicwh, 8'h00}
			: (re_sva0)	? {8'h00, sva0[7:1], 1'b0}
			: (re_iicse0)	? {msts0, aldm, exc0, coi0, trcm, ackd0, std0, spd0, 8'h00}
			: 16'h0000;
*/
wire	[8:0] sel_reg ;
assign	sel_reg = { re_iic0 , re_iics0 , re_iicf0 , re_iicc0 , re_iiccl0 , re_iicwl0 , re_iicwh0 , re_sva0 , re_iicse0 } ;

always@( sel_reg or iic0 or msts0 or aldm or exc0 or coi0 or trcm or ackd0 or std0 or spd0 or
         stcf or iicbsy or stcen or iicrsv or iice0 or spicr or wtimr or acker or
         wup or cld0 or dad0 or spc0 or dfc0 or prs0 or iicwl or iicwh or sva0 ) begin
	case( sel_reg )
	  9'b1_0000_0000 : dout = {8'h00, iic0} ;
	  9'b0_1000_0000 : dout = {msts0, aldm, exc0, coi0, trcm, ackd0, std0, spd0, 8'h00} ;
	  9'b0_0100_0000 : dout = {8'h00, stcf, iicbsy, 4'b0000, stcen, iicrsv} ;
	  9'b0_0010_0000 : dout = {8'h00, iice0, 2'b00, spicr, wtimr, acker, 2'b00} ;
	  9'b0_0001_0000 : dout = {wup , 1'b0 , cld0 , dad0 , spc0 , dfc0 , 1'b0 , prs0 , 8'h00} ;
	  9'b0_0000_1000 : dout = {8'h00,iicwl} ;
	  9'b0_0000_0100 : dout = {iicwh, 8'h00} ;
	  9'b0_0000_0010 : dout = {8'h00, sva0[7:1], 1'b0} ;
	  9'b0_0000_0001 : dout = {msts0, aldm, exc0, coi0, trcm, ackd0, std0, spd0, 8'h00} ;
	  9'b0_0000_0000 : dout = 16'h0000 ;
	  default	 : dout = 16'bxxxx_xxxx_xxxx_xxxx ;
	endcase
end  



endmodule
module QLK0RIICAV2_WAITCONT	(
	PECLK,
	PERESETZ,
//	SVMOD,			// Del 20091207 -2

	iice0,
        iice0_rst,
	lrelp,
	wrelp,
	spicr,
	wtimr,
	stt0,
	setsttp,
	setsptp,
	msts0,
	exc0,
	coi0,
	aldr,
	std0,
	spd0,
	spdpls,
	scl,
	sclu1,
	scld1,
	c7en,
	c8en,
	bufsetp,
	serv,
	aldp,
	stcen,

        wup,             // ONW Modified
        wup_s,           // ONW Modified
        wait_ch0,        // ONW Modified
        wait_s,          // ONW Modified
        stdpls,          // ONW Modified

	waitiic,
	waitiic_sdao,    // ONW Modified
	iicwrq,
	intiic 
	);


//--- port direction
input			PECLK;
input			PERESETZ;
//input			SVMOD;			// Del 20091207 -2

input			iice0;
input                   iice0_rst;
input			lrelp;
input			wrelp;
input			spicr;
input			wtimr;
input			stt0;
input			setsttp;
input			setsptp;
input			msts0;
input			exc0;
input			coi0;
input			aldr;
input			std0;
input			spd0;
input			spdpls;
input			scl;
input			sclu1;
input			scld1;
input			c7en;
input			c8en;
input			bufsetp;
input			serv;
input			aldp;
input			stcen;

input                   wup;             // ONW ModifieD
input                   wup_s;           // ONW ModifieD
input                   wait_ch0;        // ONW Modified
//input                   exc_s;           // ONW Modified
input                   wait_s;          // ONW Modified
input                   stdpls;          // ONW Modified

output			waitiic;
output			waitiic_sdao;    // ONW Modified
output			iicwrq;
output			intiic;



//--- logic

// ----- WAITRQ -----

reg	iicwrq;

always @(posedge PECLK or negedge PERESETZ) begin
	if(!PERESETZ) begin
		iicwrq	<= 1'b0;
	end
//        else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin    // ONW Modified
        else if (!wup & (iice0 | iice0_rst)) begin    // Mod 20091207 -2
	if (iice0_rst) begin
		iicwrq	<= 1'b0;
	end
	else if (lrelp || wrelp) begin
		iicwrq	<= 1'b0;
	end
        else if (wup_s)
        begin : IICWRQ_MAIN_STOP
            iicwrq <= 1'b0;
        end  // IICWRQ_MAIN_STOP
	else if (bufsetp || scld1 ) begin
		iicwrq	<= 1'b0;
	end
	else if (aldp) begin
		iicwrq	<= 1'b0;
	end
	else if (setsttp && msts0) begin	// for STT set during wait
		iicwrq	<= 1'b1;
	end
	else if (scl) begin
		if (setsttp && ( spd0 || stcen || msts0)) begin
			iicwrq	<= 1'b1;
		end
		else if (stt0 && spdpls) begin	// for data wirte by STT set
			iicwrq	<= 1'b1;
		end
		else begin						// reserve
	      casex({ msts0, exc0, coi0, std0, wtimr, c8en, c7en })
	    //remove parallel_case for conformal by k0r
		7'b1xx1x1x : iicwrq <= 1'b1; // master - STD
		7'b1xx00x1 : iicwrq <= 1'b1; // master
		7'b1xx011x : iicwrq <= 1'b1; // master
		7'b01x1xx1 : iicwrq <= 1'b1; // ext. code receive - STD
		7'b01xx11x : iicwrq <= 1'b1; // ext. code recieve
		7'b01x00x1 : iicwrq <= 1'b1; // ext. code recieve
		7'b0011x1x : iicwrq <= 1'b1; // slave select - STD
		7'b001011x : iicwrq <= 1'b1; // slave select
		7'b00100x1 : iicwrq <= 1'b1; // slave select
		default    : iicwrq <= iicwrq;
	      endcase
	    end
	end
        end
end


// ----- WAIT  -----

reg	waitiic;

always @(posedge PECLK or negedge PERESETZ) begin
	if(!PERESETZ) begin
		waitiic	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin             // ONW Modified
	else if ( !wup & (iice0 | iice0_rst)) begin             // Mod 20091207 -2
	if (iice0_rst) begin
		waitiic	<= 1'b0;
	end
	else if (lrelp || wrelp) begin
		waitiic	<= 1'b0;
	end
        else if (wup_s)
        begin : WAITIIC_MAIN_STOP
            if (wait_ch0)
                waitiic <= 1'b1;
            else
                if (stdpls | spdpls)
                    waitiic <= 1'b0;
                else
                    waitiic <= waitiic;
        end  // WAITIIC_MAIN_STOP
	else if (bufsetp || setsptp) begin
		waitiic	<= 1'b0;
	end
	else if (msts0 && setsttp) begin
		waitiic	<= 1'b0;
	end
	else if (aldp) begin
		waitiic	<= 1'b0;
	end
	else if (iicwrq && scld1 && ((!stt0 && msts0) || exc0 || coi0)) begin
		waitiic	<= 1'b1;
	end 
	end 
end

wire  waitiic_pre;                                                                        // ONW Modified
wire  waitiic_mask;                                                                       // ONW Modified
wire  waitiic_sdao;                                                                       // ONW Modified
//assign waitiic_pre = (wup_s & wait_ch0 & exc_s) |                                         // ONW Modified
assign waitiic_pre = (wup_s & wait_ch0 ) |                                         // ONW Modified
                     (iicwrq && scld1 && ((!stt0 && msts0) || exc0 || coi0)) | waitiic ;  // ONW Modified
assign waitiic_mask =  wrelp | bufsetp | setsptp | (msts0 && setsttp) ;                   // ONW Modified
assign waitiic_sdao = waitiic_pre & ~waitiic_mask;            // ONW Modified

// ----- INTIIC -----

reg	intii;

always @(posedge PECLK or negedge PERESETZ) begin
	if(!PERESETZ) begin
		intii	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin    // ONW Modified
	else if (!wup & (iice0 | iice0_rst)) begin    // Mod 20091207 -2
	if (iice0_rst) begin
		intii	<= 1'b0;
	end
        else if (wup_s)
        begin : INTII_MAIN_STOP
            intii <= spdpls & spicr;
        end  // INTII_MAIN_STOP
	else if (spicr && spdpls) begin	// STOP int
		intii	<= 1'b1;
	end
	else if (sclu1) begin
		intii	<= 1'b0;
	end
	else if (scld1) begin
		casex({ iicwrq, c7en, c8en, aldr, exc0, coi0, wtimr, serv })
		//remove parallel_case for conformal by k0r
		    8'b11xxxxxx : intii <= 1'b1; // WAIT & int
		    8'b1x1xxxxx	: intii <= 1'b1; // WAIT & int
		    8'bx1x1000x : intii <= 1'b1; // ALD fail
		    8'bxx11001x	: intii <= 1'b1; // ALD fail
		    8'bxx1000x1	: intii <= 1'b1; // Not join after Restart
		    default	: intii <= 1'b0;
		endcase
	end
	end
end

reg	intii_1t;

always @(posedge PECLK or negedge PERESETZ) begin
	if(!PERESETZ) begin
		intii_1t	<= 1'b0;
	end
//	else if (!SVMOD & !wup & (iice0 | iice0_rst)) begin                       // ONW Modified
	else if ( !wup & (iice0 | iice0_rst)) begin                       // Mod 20091207 -2
	if (iice0_rst) begin
		intii_1t	<= 1'b0;
	end
        else if (wup_s)
        begin : INTIIC_1T_MAIN_STOP
            intii_1t <= 1'b0;
        end  // INTIIC_1T_MAIN_STOP
	else begin
		intii_1t	<= intii;
	end
	end
end


wire	intiic = (wup_s)? wait_s : intii && (!intii_1t);       // ONW Modified




endmodule
//[EOF]
