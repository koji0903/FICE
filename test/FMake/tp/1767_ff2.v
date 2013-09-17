module add_ff2(clk,rst,D,Q3,OUT_OPEN,FixedPin_Single,FixedPin_Bus,NoConnectInPin,CLK60M,PUONOUT,ADINLP5V,fpga_pio,PTTL);
   input clk;
   input rst;
   input D;
   output Q3;
   output OUT_OPEN;
   input  FixedPin_Single;
   input [2:0] FixedPin_Bus;
   input 	   NoConnectInPin;
   input 	   CLK60M;
   output      PUONOUT;
   output      ADINLP5V;
   output [7:0] fpga_pio;
   input 		PTTL;
		
 	   
   assign fpga_pio = {Q3,Q3,Q3};
   
   reg 	  Q3;
   
   always @(posedge clk or posedge rst) begin
	  if (rst) Q3 <= 1'b0;
	  else Q3 <= D & CLK60M & PTTL;	  
   end
   
endmodule // add_ff