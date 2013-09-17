module add_ff(clk,rst,D,Q3,RESB,wire_connect_1718,
			  CON_BUS1,
			  CON_BUS0,
			  CE0,
			  clk_1777,
			  clk_bus_1777,
			  CLK60MHZ,
			  ff2_Q,
			  PUONOUT,
			  CPURSOUTB,
			  CLK30MHz,
			  wire002
);
   input clk;
   input rst;
   input D;
   output Q3;
   input  RESB;
   input  wire_connect_1718;
//   input  [1:0] BUS;
   input  CON_BUS1;
   input  CON_BUS0;
//   input  BUS1;
//   input  BUS0;
   input  CE0;
   output clk_1777;
   output [2:0] clk_bus_1777;
   output 		CLK60MHZ;
   input 		ff2_Q;
   input        PUONOUT;
   input 		CPURSOUTB;
   output 		CLK30MHz;
   input 		wire002;
   
		   
   reg 	  Q3;

   assign clk_1777 = ^Q3;
   assign clk_bus_1777 = {Q3,Q3,Q3};
   assign CLK60MHZ = Q3;
   
   always @(posedge clk or posedge rst) begin
	  if (rst) Q3 <= 1'b0;
	  else Q3 <= D & RESB & wire_connect_1718 & CON_BUS1 & CON_BUS0 & CE0 && ff2_Q & PUONOUT & CPURSOUTB;	  
//	  else Q3 <= D & RESB & wire_connect_1718 & BUS1 & BUS0;	  
   end
   
endmodule // add_ff
