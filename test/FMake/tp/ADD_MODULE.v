module ADD_MODULE(
				  In_A1,
				  In_A2,
				  In_A3,
				  In_A4,
				  Out_B1,
				  Out_B2,
				  Out_B3,
				  Out_B4,
				  Inout_C1,
				  Inout_C2
				  );
   input In_A1;
   input In_A2;
   input  In_A3;
   input [10:0] In_A4;
   
   
   output 	   Out_B1,Out_B4;
   output [3:0] Out_B2;
   output 		Out_B3;
    
   inout 		Inout_C1;
   inout [3:0] 	Inout_C2;
   
   
endmodule
  