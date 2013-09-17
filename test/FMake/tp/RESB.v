module TOP();
   wire rst_res_n2;
   wire SCAN_wire;

   CSPF cspf(.rst_res_n3(rst_res_n2),.rst(rst));
   PERICORE pericore(.rst_res_n(rst_res_n2),.rst(rst));
   wwdt wwdt(.SCANCLK(SCANCLK),.SCAN(SCAN_wire));
   
endmodule // TOP

module wwdt(SCAN,SCANCLK);
   input SCANCLK;   
   output SCAN;   
endmodule // wwdt

	

module CSPF(rst_res_n3,rst);
   output rst_res_n3;
   output rst;   
   wire   rst_res_n;
   wire   cpu_stpst;
   wire [1:0] adchsel;   
   
   PGCSC2 pgcsc2(.rst_res_n(rst_res_n3),.rst(rst),.cpu_stpst(1'b0),.SVSTOP(1'b0),.dw(3'b0));
   
   
      
   MP200 mp200(.rst_res_n(rst_res_n3),.rst(rst),.dummy_wire(dummy_wire),.adchsel(adchsel));

   ModA mod_a(.A(rst_res_n),.cpu_stpst(cpu_stpst),.ADCHSEL0(adchsel[0]),.ADCHSEL1(adchsel[1]));
   ModB mod_b(.B(rst_res_n),.cpu_stpst(cpu_stpst));
   
endmodule // CSPF


module MP200(rst_res_n,rst,dummy_wire,adchsel);
   output rst_res_n;
   output rst;
   wire   rst_res_n;
   wire   rst;
   wire [1:0] pid;
   wire [2:0] cpu_pa;
   wire [2:0] cpu_pb;
   wire [2:0] cpu_pc;
   output 	  dummy_wire;
   wire [2:0] dw;
   wire 	  cpu_cpuwr;
   output [1:0] adchsel;
   
   
   CSC csc(.RESB(rst_res_n),.ICE_RESB(rst),.stpst(cpu_stpst),.SVSTOP(svstop),
		   .PID1(pid[1]),.PID0(pid[0]),
		   .PA2(cpu_pa[2]),.PA1(cpu_pa[1]),.PA0(cpu_pa[0]),
		   .PB2(cpu_pb[2]),.PB1(cpu_pb[1]),.PB0(cpu_pb[0]),
		   .PC(cpu_pc),
		   .CPUWR(cpu_cpuwr),
		   .SCANCLK(SCANCLK),
		   .FCLK(FCLK)
		   );

   CPU cpu(.rst_res_n(rst_res_n),.rst(rst),.STPST(cpu_stpst),
		   .PID1(pid[1]),.PID0(pid[0]),
		   .PA2(cpu_pa[2]),.PA1(cpu_pa[1]),.PA0(cpu_pa[0]),
		   .PB2(cpu_pb[2]),.PB1(cpu_pb[1]),.PB0(cpu_pb[0]),
		   .PC(cpu_pc),
		   .dummy_wire(dummy_wire),
		   .dw2(dw[2]),
		   .dw1(dw[1]),
		   .dw0(dw[0]),
		   .pd(pull_down001),
		   .CPUWR(cpu_cpuwr),
		   .CPUBUS(),
		   .CPU_OUT(),
		   .CPU_IN(),
		   .FCLK(1'b0),
		   .EMEMRAMCLK(1'b0)
		   );

   plldown_cell_pf pulldown_cell(.y(pull_down001));
    
   OCD ocd(.SVSTOP(svstop),.PB2(cpu_pb[2]),.PB1(cpu_pb[1]),.PB0(cpu_pb[0]));   
   PGCSC pgcsc(.rst_res_n(rst_res_n),.rst(rst),.cpu_stpst(cpu_stpst),.SVSTOP(svstop),.dw(dw[2:0]),.adchsel(adchsel));
endmodule // MP200

module plldown_cell_pf(y);
   output y;
   wire   y = 1'b0;   
endmodule // plldown_cell_pf


module CSC(RESB,ICE_RESB,stpst,SVSTOP,PID1,PID0,PA2,PA1,PA0,PB2,PB1,PB0,PC,CPUWR,SCANCLK,FCLK);
   output RESB;
   output ICE_RESB;
   input  stpst;
   input  SVSTOP;
   input  PID1;
   input  PID0;
   input  PA2;   
   input  PA1;
   input  PA0;
   input  PB2;
   input  PB1;
   input  PB0;
   input [2:0] PC;
   input 	   CPUWR;
   input 	   SCANCLK;
   output 	   FCLK;
   
  
   
   
        
endmodule // CSC

module CPU(rst_res_n,rst,STPST,PID1,PID0,PA2,PA1,PA0,PB2,PB1,PB0,PC,dummy_wire,dw2,dw1,dw0,pd,CPUWR,CPUBUS,CPU_OUT,CPU_IN,FCLK,EMEMRAMCLK);
   input rst_res_n;
   input rst;
   output PID1;
   output PID0;   
   output STPST;
   output PA2;  
   output PA1;
   output PA0;
   output PB2;
   output PB1;
   output PB0;
   output [2:0] PC;
   output 		dummy_wire;
   output dw2,dw1,dw0;
   input  pd;
   output CPUWR;
   output [3:0] CPUBUS;
   output 		CPU_OUT;
   input 		CPU_IN;
   input 		FCLK;
   input 		EMEMRAMCLK;
   
     
endmodule // CPU

module OCD(SVSTOP,PB2,PB1,PB0);
   output SVSTOP;
   input  PB2;
   input  PB1;
   input  PB0;   
endmodule // OCD


module PGCSC(rst_res_n,rst,cpu_stpst,SVSTOP,dw,adchsel);
   input rst_res_n;
   input rst;
   input cpu_stpst;
   input SVSTOP;
   input [2:0] dw;
   output [1:0] adchsel;   
   
   pgcsc_kerneltop kerneltop(.rst_res_n(rst_res_n),.rst(rst),.cpu_stpst(cpu_stpst),.ADCHSEL0(adchsel[0]),.ADCHSEL1(adchsel[1]));
   pgcsc_kerneltop2 kerneltop2(.rst_res_n(rst_res_n),.rst(rst),.cpu_stpst(cpu_stpst));
endmodule // PGCSC

module pgcsc_kerneltop(rst_res_n,rst,cpu_stpst,ADCHSEL0,ADCHSEL1);
   input rst_res_n;
   input rst;
   input cpu_stpst;
   output ADCHSEL0;
   output ADCHSEL1;   
endmodule // PGCSC

module pgcsc_kerneltop2(rst_res_n,rst,cpu_stpst);
   input rst_res_n;
   input rst;
   input cpu_stpst;
   mdiv mdiv01(.rst_res_n(rst_res_n),.rst(rst),.cpu_stpst(cpu_stpst));
endmodule // PGCSC

module pgcsc_kerneltop3(rst_res_n,rst,cpu_stpst);
   input rst_res_n;
   input rst;
   input cpu_stpst;
endmodule // PGCSC

module mdiv(rst_res_n,rst,cpu_stpst);
   input rst_res_n;
   input rst;
   input cpu_stpst;
endmodule // PGCSC



module PERICORE(rst_res_n,rst);
   input rst_res_n;
   input rst;
   wire  dgen02,dgen01,dgen00;   
   PORTIOTOP portiotop(.rst_res_n(rst_res_n),.rst(rst),.dgen({dgen02,dgen01,dgen00}));
   MC200 mc200(.d2(dgen02),.d1(dgen01),.d0(dgen00));   
endmodule // PERICORE

module PORTIOTOP(rst_res_n,rst,dgen);
   input rst_res_n;
   input rst;
   output [2:0] dgen;
   wire [2:0] 	dgen;   
   PORTTOP porttop(.rst_res_n(rst_res_n),.rst(rst),.dgen(dgen[2:0]));
endmodule // PORTIOTOP

module MC200(d2,d1,d0);
   input d2,d1,d0;   
endmodule // MC200


module PORTTOP(rst_res_n,rst,dgen);
   input rst_res_n;
   input rst;
   output [2:0] dgen;   
endmodule // PORTTOP


module ModA(A,cpu_stpst,ADCHSEL1,ADCHSEL0);
   input A;
   input cpu_stpst;
   input ADCHSEL1;
   input ADCHSEL0;   
endmodule // ModA

module ModB(B,cpu_stpst);
   output B;
   output cpu_stpst;   
endmodule // ModA


module PGCSC2(rst_res_n,rst,cpu_stpst,SVSTOP,dw);
   input rst_res_n;
   input rst;
   input cpu_stpst;
   input SVSTOP;
   input [2:0] dw;
   
   pgcsc_kerneltop3 kerneltop3(.rst_res_n(rst_res_n),.rst(rst),.cpu_stpst(cpu_stpst));
   pgcsc_kerneltop2 kerneltop2(.rst_res_n(rst_res_n),.rst(rst),.cpu_stpst(cpu_stpst));
endmodule // PGCSC
