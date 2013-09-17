module TOP(
		   );
   wire [3:0] adr;
   //--- Connect Inf ----//
   // suba.a3 <- wire:adr[3] <- sub_b3.data[3] <- (Lower Hier) <- Module:SubB data[3]
   SubA sub_a(
			  .a3(adr[3]),
			  .a2(adr[2]),
			  .a1(adr[1]),
			  .a0(adr[0])
			  );

   SubB sub_b3(
			  .data({adr[3],adr[2],adr[1],adr[0]})
			  );
   /*
   SubB sub_b2(
			  .adr(adr[2])
			  );
   SubB sub_b1(
			  .adr(adr[1])
			  );
   SubB sub_b0(
			  .adr(adr[0])
			  );
   */
   
endmodule // TOP

module SubA(a3,a2,a1,a0);
   input a3,a2,a1,a0;   
endmodule // SubA

module SubB(data);
   output [3:0] data;

   SubBSub sub_b_sub(
					 .A0(data[3]),
					 .A1(data[1]),
					 .A2(data[2]),
					 .A3(data[0])
					 );
/*
   SubBSub sub_b3(
					 .A0(data[3]),
					 .A1(data[1]),
					 .A2(data[2]),
					 .A3(data[0])
					 );
*/
   
endmodule // SubB


module SubBSub(A0,A1,A2,A3);
   output A0,A1,A2,A3;   
endmodule