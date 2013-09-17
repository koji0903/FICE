module TOP(clk,rst,D,Q1,Q2,DOUT,peri_o,AD_O,P80,dummy1,dummy2,CapOut,X1,X2);
   input clk;
   input rst;
   input D,X2;
   output Q1;
   output Q2;
   wire   [3:0] D_Bus;
   wire [1:0] 	connect_bus_1718;
   output 		DOUT;
   wire [2:0] 	addr_a;
   output 		peri_o;
   output       AD_O;
   inout 		P80;
   output 			  dummy1,dummy2;
   input 			  X1;   
   
   wire 		rst_res_n;
   wire 		SVSTOP;
   wire [1:0] 	cap_out;
   wire 		pulldown_wire;
   output 		CapOut;
   wire 		a1,a0;
   
 		   
     
   ICE_TOP_test ice_top(
						.clk(clk),
						.rst(rst),
						.D(D),
						.Q(Q1),
						.clk_out(),
						.D_Bus(D_Bus),
						.test_clk(test_clk),
						.test_wire(test_wire),
						.connect_1718(connect_1718),
						.connect_bus_1718_0(connect_bus_1718[0]),
						.connect_bus_1718_1(connect_bus_1718[1]),
						.CE0(cibc_ce0),
						.A0(addr_a[0]),
						.A1(addr_a[1]),
						.A2(addr_a[2]),
						.clka_1777(1'b1),
						.SYSRSOUTB(),
						.ICECK60M(dummy),
						.wire001(wire001),
						.X1(X1),
						.a1(a1),
						.a0(a0)
						);
   
   CSPF_wrapper cspf_wrapper(
							 //   CSPF cspf(
											.D(D),
											.Q(Q2),
											.D_Bus_Out(D_Bus),
											.test_clk(test_clk),
											.test_wire(test_wire),
											.connect_1718(connect_1718),
											.connect_bus_1718(connect_bus_1718),
											.DOUT(DOUT),
											.cibc_ce0(cibc_ce0),
											.addr(addr_a),
											.rst_res_n(rst_res_n),
											.bg2adsel(bg2adsel),
											.P80(P80),
											.dummy1(dummy1),
											.dummy2(dummy2),
											.SVSTOP(SVSTOP),
											.iceck30m(pulldown_wire)
											);

   pulldown_cell_pf pulldown_cell0(.y(pulldown_wire),.x(wire001));
      
   pericore pericore(.rst_res_n(rst_res_n),.peri_o(peri_o),.bg2adsel(bg2adsel),.AD_O(AD_O),.SVSTOP(SVSTOP),.cap_out(cap_out),.a1(a1),.a0(a0));
   CAP_wrapper cap_wrapper(.cap_out(cap_out),.CapOut(CapOut));
   
   
endmodule // TOP

module pulldown_cell_pf(y,x);
   output y;
   output x;
   
   assign y = 1'b0;
   assign x = 1'b0;
   
endmodule // pulldown_cell_pf


module pericore(rst_res_n,peri_o,bg2adsel,AD_O,SVSTOP,cap_out,a1,a0);
   input rst_res_n;
   output peri_o;
   input  bg2adsel;
   output AD_O;
   input  SVSTOP;
   output [1:0] cap_out;
   output 		a1,a0;
            
   cap cap(.rst_res_n(rst_res_n),.peri_o(peri_o),.SVSTOP(SVSTOP),.Out1(cap_out[1]),.Out0(cap_out[0]),.A({a1,a0}));
   ad ad(.BG2ADSEL(bg2adsel),.O(AD_O));   
   
endmodule // pericore

module cap(rst_res_n,peri_o,SVSTOP,Out1,Out0,A);
   input rst_res_n;
   output peri_o;
   input  SVSTOP;
   output Out1;
   output Out0;
   output  A;
      
   assign peri_o = rst_res_n;   
endmodule // cap

module ad(BG2ADSEL,O);
   input BG2ADSEL;
   output O/*synthesis syn_keep*/;
   assign O = BG2ADSEL;   
endmodule // ad

module CAP_wrapper(cap_out,CapOut);
   input [1:0] cap_out;
   output 	   CapOut;
   
   
   cap_in cap_in(.In1(cap_out[1]),.In0(cap_out[0]),.CapOut(CapOut));
endmodule // CAP_wrapper


module ICE_TOP_test(clk,rst,D,Q,clk_out,D_Bus,test_clk,test_wire,connect_1718,connect_bus_1718_0,connect_bus_1718_1,CE0,A0,A1,A2,clka_1777,SYSRSOUTB,ICECK60M,wire001,X1,a1,a0);
   input clk;
   input rst;
   input D;
   input [3:0] D_Bus;
   input 	   X1;   
   output 	   Q;
   output 	   clk_out;
   input 	   test_clk;
   input 	   test_wire;
   input 	   connect_1718;
   input       connect_bus_1718_0;
   input       connect_bus_1718_1;
   input       CE0;
   input 	   A0,A1,A2;
   input       clka_1777;        
   output      SYSRSOUTB;
   input       ICECK60M;
   input 	   wire001;
   input 	   a1,a0;
   
   
   reg 	  Q;
   
   assign clk_out = clk;
   assign SYSRSOUTB = clk;
   
   always @(posedge clk or posedge rst) begin
	  if (rst) Q <= 1'b0;
	  else Q <= D & |D_Bus & test_clk & test_wire & connect_1718 & connect_bus_1718_0 & connect_bus_1718_1 & CE0 & A0 & A1 & A2 & clka_1777;
   end

   
endmodule // ICE_TOP

module cap_in(In1,In0,CapOut);
   input In1;
   input In0;
   output CapOut;
   
   assign CapOut = In1 & In0;
   
endmodule // cap_in


module CSPF_wrapper(D,Q,D_Bus_Out,test_clk,test_wire,connect_1718,connect_bus_1718,cibc_ce0,DOUT,addr,rst_res_n,bg2adsel,P80,dummy1,dummy2,SVSTOP,iceck30m);
   input D;
   output Q;
   output [3:0] D_Bus_Out;
   output 		test_clk;
   output 		test_wire;
   output       connect_1718;
   output       [1:0] connect_bus_1718;
   output 			  cibc_ce0;
   wire               cibc_ce0;
   output 			  DOUT;
   output [2:0] 	  addr;
   output 			  rst_res_n;
   output  			  bg2adsel;
   inout              P80;
   output 			  dummy1,dummy2;
   output             SVSTOP;
   input              iceck30m;
			  

   wire [1:0] 		  da_data;
   
   CSPF cspf(
			 .D(D),
			 .Q(Q),
			 .D_Bus_Out(D_Bus_Out),
			 .test_clk(test_clk),
			 .test_wire(test_wire),
			 .connect_1718(connect_1718),
			 .connect_bus_1718(connect_bus_1718),
			 .cibc_ce0(cibc_ce0),
			 .addr(addr),
			 .rst_res_n(rst_res_n),
			 .P80(P80),
			 .dummy1(dummy1),
			 .dummy2(dummy2),
			 .SVSTOP(SVSTOP),
			 .DADATA(da_data)
			 );
   
   flash_code flash_code(
						 .CE0(cibc_ce0),
						 .DOUT(DOUT),
						 .A0(addr[0]),
						 .A1(addr[1]),
						 .A2(addr[2]),
						 .rst_sysrsout_n(1'b0),
						 .rst_res_n(rst_res_n),
						 .bg2adsel(bg2adsel),
						 .SCANCLK(),
						 .mod_scanen(mod_scanen),
						 .iceck30m(iceck30m)
						 );

   da da(
		 .da_data1(da_data[1]),
		 .da_data0(da_data[0])
		 );
   


   
   
endmodule // CSPF

module da(da_data1,da_data0);
   input da_data1;
   input da_data0;   
endmodule // da


module flash_code(CE0,DOUT,A0,A1,A2,ICECK60M,rst_sysrsout_n,rst_res_n,bg2adsel,SCANCLK,mod_scanen,iceck30m);
   input CE0;
   output DOUT;
   input  A0,A1,A2;
   input  ICECK60M;
   input  rst_sysrsout_n;
   output rst_res_n;
   output bg2adsel;
   input  SCANCLK;
   output mod_scanen;
   input  iceck30m;
   
   
        
   assign DOUT = CE0 & A0 & A1 & A2 & ICECK60M & rst_sysrsout_n;
   assign RESB = A0;

   dummyOut dOut(.RESB(rst_res_n),.BG2ADSEL(bg2adsel));
endmodule // flash_code

module dummyOut(RESB,BG2ADSEL);
   output RESB;
   output BG2ADSEL;   
endmodule // dummyOut



module CSPF(D,Q,D_Bus_Out,test_clk,test_wire,connect_1718,connect_bus_1718,cibc_ce0,addr,rst_res_n,P80,dummy1,dummy2,SVSTOP,DADATA);
   input D;
   output Q;
   output [3:0] D_Bus_Out;
   output 		test_clk;
   output 		test_wire;
   output       connect_1718;
   output       [1:0] connect_bus_1718;
   output 			  cibc_ce0;
   output [2:0] 	  addr;
   input 			  rst_res_n;
   inout 			  P80;
   output 			  dummy1,dummy2;
   output 			  SVSTOP;
   output [1:0] 	  DADATA;

   wire [1:0] 		  vimds;
   
 			  
   
   MC200 mc200(
			   .D(D),
			   .Q(Q),
			   .test_clk(test_clk),
			   .test_wire(test_wire),
			   .wire_1718(connect_1718),
			   .CON_BUS1(connect_bus_1718[1]),
			   .CON_BUS0(connect_bus_1718[0]),
			   .reset_b(reset_b),
			   .P80(P80),
			   .DADATA(DADATA),
			   .VIMDS1(vimds[1]),
			   .VIMDS0(vimds[0])
			   );

   BUS bus(
		   .test_clk(test_clk),
		   .D3(D_Bus_Out[3]),
		   .D2(D_Bus_Out[2]),
		   .D1(D_Bus_Out[1]),
		   .D0(D_Bus_Out[0]),
		   .wire_1718(connect_1718),
		   .CON_BUS1(connect_bus_1718[1]),
		   .CON_BUS0(connect_bus_1718[0]),
		   .CE0(cibc_ce0),
		   .A0(addr[0]),
		   .A1(addr[1]),
		   .A2(addr[2]),
		   .clkb_1777(1'b1),
		   .clkb_bus_1777(3'b111),
		   .RESETB(reset_b),
		   .rst_res_n(rst_res_n),
		   .VIMDS1(vimds[1]),
		   .VIMDS0(vimds[0])
//		   .CON_BUS1(1'b0),
//		   .CON_BUS0(1'b0)
		   );

//   wire 			  SVSTOP;
   
   OCD ocd(.SVSTOP(SVSTOP),.dummy(D));
   CPU cpu(.SVSTOP(SVSTOP),.dummy(dummy1),.FCLK(1'b0),.EMEMRAMCLK(1'b0));
   DMA dma(.SVSTOP(SVSTOP),.dummy(dummy2));
   
         
endmodule // CSPF

module OCD(SVSTOP,dummy);
   input dummy;
   output SVSTOP;
   assign SVSTOP = dummy;
   
endmodule // OCD

module CPU(SVSTOP,dummy,FCLK,EMEMRAMCLK);
   input SVSTOP;
   output dummy;
   input  FCLK;
   input  EMEMRAMCLK;
   
   assign dummy = SVSTOP;   
endmodule // OCD

module DMA(SVSTOP,dummy);
   input SVSTOP;   
   output dummy;
   assign dummy = SVSTOP;   
endmodule // OCD

module BUS(test_clk,D3,D2,D1,D0,wire_1718,CON_BUS1,CON_BUS0,CE0,A0,A1,A2,clkb_1777,clkb_bus_1777,RESETB,rst_res_n,VIMDS1,VIMDS0);
   input  test_clk;   
   output D3,D2,D1,D0;
   input  wire_1718;
   input  CON_BUS1;
   input  CON_BUS0;
   output CE0;
   output A0,A1,A2;
   input  clkb_1777;
   input [2:0] clkb_bus_1777;
   input 	   RESETB;
   input 	   rst_res_n;
   output 	   VIMDS1,VIMDS0;
   
   
   
   assign D3 = test_clk;
   assign D2 = wire_1718;
   assign D1 = CON_BUS1;
   assign D0 = CON_BUS0;
   assign CE0 = wire_1718;
   assign A0 = wire_1718;
   assign A1 = wire_1718;
   assign A2 = clkb_1777 & ^clkb_bus_1777 & RESETB & rst_res_n;
   assign VIMDS1 = rst_res_n;
   assign VIMDS0 = rst_res_n;
   
endmodule // BUS


module MC200(D,Q,test_clk,test_wire,wire_1718,CON_BUS1,CON_BUS0,reset_b,P80,DADATA,VIMDS1,VIMDS0);
   input D;
   output Q;
   output test_clk;
   output test_wire;
   output wire_1718;
   output CON_BUS1;
   output CON_BUS0;
   output reset_b;
   inout  P80;
   output [1:0] DADATA;
   input 		VIMDS1,VIMDS0;
   
   
   

   wire   out;
   
   
   assign Q = D;
   assign test_clk = D;
   assign test_wire = D;
//   assign wire_1718 = D;
//   assign CON_BUS1 = D; 
//   assign CON_BUS0 = D;   
   
   Dummy dummy(.PUONOUT(),.I(out));

   port7 port7(.O(out),.PTTL(1'b1),.rstb(reset_b),.DADATA(DADATA),
			   .test_clk(test_clk),
			   .test_wire(test_wire),
			   .CON_BUS1(CON_BUS1),
			   .CON_BUS0(CON_BUS0),
			   .wire_1718(wire_1718),
			   .VIMDS1(VIMDS1),
			   .VIMDS0(VIMDS0)			   
			   );
   port8 port8(.SPAD(P80),.PTTL(1'b1),.rst_b(reset_b),.SCANCLK(out));
   
endmodule // MC200


module Dummy(PUONOUT,I);
   inout PUONOUT;
   input I;
   
endmodule // Dummy

module port7(O,PTTL,rstb,DADATA,test_clk,test_wire,CON_BUS1,CON_BU0,wire_1718,VIMDS1,VIMDS0);
   output CON_BUS1,CON_BUS0;   
   output test_clk;
   output test_wire;
   output wire_1718;   
   output O;
   input  VIMDS1,VIMDS0;   
   
   input PTTL;
   input rstb;

   output [1:0] DADATA;
   
   
   assign O = PTTL & rstb;
   
endmodule // port7

module port8(SPAD,PTTL,rst_b,SCANCLK);
   input SCANCLK;   
   inout SPAD;
   input PTTL;
   output rst_b;   
endmodule