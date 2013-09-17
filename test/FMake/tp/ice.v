module ICE(RESB,ICE_RESB,STPST,PID1,PID0,CPUPID1,CPUPID0,PA,PB2,PB1,PB0,PC1,dgen02,dgen01,dgen00,CPUWR);
   input RESB;
   input ICE_RESB;   
   input STPST;
   input CPUPID1;
   input CPUPID0;
   output PID1;
   output PID0;
   input [2:0] PA;
   input 	   PB2;
   input 	   PB1;
   input 	   PB0;
   input 	   PC1;
   input 	   CPUWR;
 	   
//   input [2:0] dgen;
   input 	   dgen02,dgen01,dgen00;   
endmodule