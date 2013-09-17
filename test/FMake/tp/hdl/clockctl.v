//  $Id: clockctl.v,v 1.15 2010-03-02 08:46:31 koji-h Exp $
//  Modifyed by koji-h on Feb 17, 2010

module CLOCKCTL (
				 SYSRSOUTB, PONRESB,
				 ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28,
				 ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
				 ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
				 ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
				 ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,
				 ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
				 ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,
				 ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0,
				 ICEDI31, ICEDI30, ICEDI29, ICEDI28,
				 ICEDI27, ICEDI26, ICEDI25, ICEDI24,
				 ICEDI23, ICEDI22, ICEDI21, ICEDI20,
				 ICEDI19, ICEDI18, ICEDI17, ICEDI16,
				 ICEDI15, ICEDI14, ICEDI13, ICEDI12,
				 ICEDI11, ICEDI10, ICEDI9,  ICEDI8,
				 ICEDI7,  ICEDI6,  ICEDI5,  ICEDI4,
				 ICEDI3,  ICEDI2,  ICEDI1,  ICEDI0,
				 ICEDO31, ICEDO30, ICEDO29, ICEDO28,
				 ICEDO27, ICEDO26, ICEDO25, ICEDO24,
				 ICEDO23, ICEDO22, ICEDO21, ICEDO20,
				 ICEDO19, ICEDO18, ICEDO17, ICEDO16,
				 ICEDO15, ICEDO14, ICEDO13, ICEDO12,
				 ICEDO11, ICEDO10, ICEDO9,  ICEDO8,
				 ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,
				 ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0,
				 ICEWR,
				 CLK30MHZ, CLK60MHZ,
				 CPUTMCLK, EVAOSCMCLK, CPUTSCLK,
				 CPURCLK1SEL, CPUPRCLK2, CPUPRCLK3, EVAOSCRCLK1, EVAOSCRCLK2, EVAOSCRCLK3,
				 CPUMCLK, CPUSCLK, CPURCLK1, CPURCLK2, CPURCLK3,
				 CLK60MHZLOCK,
				 LOCKFAIL31 , LOCKFAIL30 , LOCKFAIL29 , LOCKFAIL28 , LOCKFAIL27 , LOCKFAIL26 , LOCKFAIL25 , LOCKFAIL24 , 
				 LOCKFAIL23 , LOCKFAIL22 , LOCKFAIL21 , LOCKFAIL20 , LOCKFAIL19 , LOCKFAIL18 , LOCKFAIL17 , LOCKFAIL16 , 
				 LOCKFAIL15 , LOCKFAIL14 , LOCKFAIL13 , LOCKFAIL12 , LOCKFAIL11 , LOCKFAIL10 , LOCKFAIL9 ,  LOCKFAIL8 , 
				 LOCKFAIL7  , LOCKFAIL6  , LOCKFAIL5 
				 );
   
   input	SYSRSOUTB, PONRESB; // Ice macro reset signal
   input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, // Host I/F address bus
			ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
			ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,
			ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
			ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,
			ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0;
   input	ICEDI31, ICEDI30, ICEDI29, ICEDI28, // Host I/F write data bus
			ICEDI27, ICEDI26, ICEDI25, ICEDI24,
			ICEDI23, ICEDI22, ICEDI21, ICEDI20,
			ICEDI19, ICEDI18, ICEDI17, ICEDI16,
			ICEDI15, ICEDI14, ICEDI13, ICEDI12,
			ICEDI11, ICEDI10, ICEDI9,  ICEDI8,
			ICEDI7,  ICEDI6,  ICEDI5,  ICEDI4,
			ICEDI3,  ICEDI2,  ICEDI1,  ICEDI0;
   output	ICEDO31, ICEDO30, ICEDO29, ICEDO28, // Host I/F read data bus
			ICEDO27, ICEDO26, ICEDO25, ICEDO24,
			ICEDO23, ICEDO22, ICEDO21, ICEDO20,
			ICEDO19, ICEDO18, ICEDO17, ICEDO16,
			ICEDO15, ICEDO14, ICEDO13, ICEDO12,
			ICEDO11, ICEDO10, ICEDO9,  ICEDO8,
			ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,
			ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0;
   input	ICEWR; // Host I/F write strobe
   input	CLK30MHZ;
   output	CLK60MHZ;
   input	CPUTMCLK, EVAOSCMCLK, CPUTSCLK,
			CPURCLK1SEL, CPUPRCLK2, CPUPRCLK3, EVAOSCRCLK1, EVAOSCRCLK2, EVAOSCRCLK3;
   output	CPUMCLK, CPUSCLK, CPURCLK1, CPURCLK2, CPURCLK3;
   output	CLK60MHZLOCK;
   
   input 	LOCKFAIL31 , LOCKFAIL30 , LOCKFAIL29 , LOCKFAIL28 , LOCKFAIL27 , LOCKFAIL26 , LOCKFAIL25 , LOCKFAIL24 , 
			LOCKFAIL23 , LOCKFAIL22 , LOCKFAIL21 , LOCKFAIL20 , LOCKFAIL19 , LOCKFAIL18 , LOCKFAIL17 , LOCKFAIL16 , 
			LOCKFAIL15 , LOCKFAIL14 , LOCKFAIL13 , LOCKFAIL12 , LOCKFAIL11 , LOCKFAIL10 , LOCKFAIL9 ,  LOCKFAIL8 , 
			LOCKFAIL7  , LOCKFAIL6  , LOCKFAIL5  ;
   
   wire [31:0] iceifa;
   wire [31:0] icedi;
   reg [31:0]  icedo;
   
   // バスインタフェース（各機能共通）
   
   assign iceifa = {
					ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
					ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
					ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
					ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0
					};
   
   assign icedi = {
				   ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
				   ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
				   ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
				   ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0
				   };
   
   assign	{ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
			 ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
			 ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
			 ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0
			 } = icedo;
   
   
   reg [5:0]   eoscmmd;
   reg [7:0]   eoscmck;
   reg [1:0]   eoscsmd;
   reg [11:0]  eoscsck;
   reg [3:1]   eoscrmd;
   wire 	   ice_area_eoscm, ice_area_eoscr, ice_area_eoscs, ice_area_lockfail;
   wire 	   clk112, clk142, clk147, clk150;
   wire 	   lock0, lock1, lock2, lock3, lock4;
   reg 		   lockfail0;
   
   //***************************************************************************************
   //DLLによるCLK112作成  112MHz出力
   //***************************************************************************************
   
   wire 	   rstdcm1;
   wire 	   rstlock1latch = !PONRESB | rstdcm1;
   reg 		   lock1pos;
   always @(posedge rstlock1latch or posedge lock1) begin
	  if (rstlock1latch) begin
	     lock1pos <= 1'b0;
	  end else begin
	     lock1pos <= 1'b1;
	  end
   end
   reg lock1posneg;
   always @(posedge rstlock1latch or negedge lock1) begin
	  if (rstlock1latch) begin
	     lock1posneg <= 1'b0;
	  end else begin
	     lock1posneg <= lock1pos;
	  end
   end
   reg lockfail1;
   always @(negedge PONRESB or posedge lock1posneg) begin
	  if (!PONRESB) begin
	     lockfail1 <= 1'b0;
	  end else begin
	     lockfail1 <= 1'b1;
	  end
   end
   
   wire rstdcm1src = !PONRESB | lock1posneg;
   reg 	rstdcm1srcd1, rstdcm1srcd2, rstdcm1srcd3, rstdcm1srcd4;
   always @(negedge PONRESB or posedge CLK60MHZ) begin
	  if (!PONRESB) begin
	     rstdcm1srcd1 <= 1'b1;
	     rstdcm1srcd2 <= 1'b1;
	     rstdcm1srcd3 <= 1'b1;
	     rstdcm1srcd4 <= 1'b1;
	  end else begin
	     if (lock0) begin
			rstdcm1srcd1 <= rstdcm1src;
			rstdcm1srcd2 <= rstdcm1srcd1;
			rstdcm1srcd3 <= rstdcm1srcd2;
			rstdcm1srcd4 <= rstdcm1srcd3;
	     end
	  end
   end
   assign rstdcm1 = rstdcm1srcd1 | rstdcm1srcd2 | rstdcm1srcd3 | rstdcm1srcd4;

   dcm1 dcm1(.CLKIN_IN(CLK60MHZ), 
             .RST_IN(rstdcm1), 
             .CLKFX_OUT(clk112), 
             .LOCKED_OUT(lock1));

/*   
   //BUFG buf1 (.I(fb1i), .O(fb1o)); // ForSim
   DCM #(.CLKFX_DIVIDE(15), .CLKFX_MULTIPLY(28))
   dcm1 (.CLKIN(CLK60MHZP), .CLKFX(clk112), .RST(rstdcm1), .LOCKED(lock1),
		 .CLKFB(1'b0), .DSSEN(1'b0), .PSCLK(1'b0), .PSEN(1'b0), .PSINCDEC(1'b0), // ForImpl
		 .CLK0(), .CLK90(), .CLK180(), .CLK270(), .CLK2X(), .CLK2X180(), .CLKDV(), // ForImpl
		 //.CLKFB(fb1o), .DSSEN(1'b0), .PSCLK(1'b0), .PSEN(1'b0), .PSINCDEC(1'b0), // ForSim
		 //.CLK0(fb1i), .CLK90(), .CLK180(), .CLK270(), .CLK2X(), .CLK2X180(), .CLKDV(), // ForSim
		 .CLKFX180(), .PSDONE(), .STATUS() );
*/   
   //***************************************************************************************
   //DLLによるCLK142作成  142.5MHz出力
   //***************************************************************************************
   
   wire rstdcm2;
   wire rstlock2latch = !PONRESB | rstdcm2;
   reg 	lock2pos;
   always @(posedge rstlock2latch or posedge lock2) begin
	  if (rstlock2latch) begin
	     lock2pos <= 1'b0;
	  end else begin
	     lock2pos <= 1'b1;
	  end
   end
   reg lock2posneg;
   always @(posedge rstlock2latch or negedge lock2) begin
	  if (rstlock2latch) begin
	     lock2posneg <= 1'b0;
	  end else begin
	     lock2posneg <= lock2pos;
	  end
   end
   reg lockfail2;
   always @(negedge PONRESB or posedge lock2posneg) begin
	  if (!PONRESB) begin
	     lockfail2 <= 1'b0;
	  end else begin
	     lockfail2 <= 1'b1;
	  end
   end
   
   wire rstdcm2src = !PONRESB | lock2posneg;
   reg 	rstdcm2srcd1, rstdcm2srcd2, rstdcm2srcd3, rstdcm2srcd4;
   always @(negedge PONRESB or posedge CLK60MHZ) begin
	  if (!PONRESB) begin
	     rstdcm2srcd1 <= 1'b1;
	     rstdcm2srcd2 <= 1'b1;
	     rstdcm2srcd3 <= 1'b1;
	     rstdcm2srcd4 <= 1'b1;
	  end else begin
	     if (lock0) begin
			rstdcm2srcd1 <= rstdcm2src;
			rstdcm2srcd2 <= rstdcm2srcd1;
			rstdcm2srcd3 <= rstdcm2srcd2;
			rstdcm2srcd4 <= rstdcm2srcd3;
	     end
	  end
   end
   assign rstdcm2 = rstdcm2srcd1 | rstdcm2srcd2 | rstdcm2srcd3 | rstdcm2srcd4;

   dcm2 dcm2(.CLKIN_IN(CLK60MHZ), 
             .RST_IN(rstdcm2), 
             .CLKFX_OUT(clk142), 
             .LOCKED_OUT(lock2));

/*   
   //BUFG buf2 (.I(fb2i), .O(fb2o)); // ForSim
   DCM #(.CLKFX_DIVIDE(8), .CLKFX_MULTIPLY(19))
   dcm2 (.CLKIN(CLK60MHZP), .CLKFX(clk142), .RST(rstdcm2), .LOCKED(lock2),
		 .CLKFB(1'b0), .DSSEN(1'b0), .PSCLK(1'b0), .PSEN(1'b0), .PSINCDEC(1'b0), // ForImpl
		 .CLK0(), .CLK90(), .CLK180(), .CLK270(), .CLK2X(), .CLK2X180(), .CLKDV(), // ForImpl
		 //.CLKFB(fb2o), .DSSEN(1'b0), .PSCLK(1'b0), .PSEN(1'b0), .PSINCDEC(1'b0), // ForSim
		 //.CLK0(fb2i), .CLK90(), .CLK180(), .CLK270(), .CLK2X(), .CLK2X180(), .CLKDV(), // ForSim
		 .CLKFX180(), .PSDONE(), .STATUS() );
*/
   
   //***************************************************************************************
   //DLLによるCLK147作成  147.273MHz出力
   //***************************************************************************************
   
   wire rstdcm3;
   wire rstlock3latch = !PONRESB | rstdcm3;
   reg 	lock3pos;
   always @(posedge rstlock3latch or posedge lock3) begin
	  if (rstlock3latch) begin
	     lock3pos <= 1'b0;
	  end else begin
	     lock3pos <= 1'b1;
	  end
   end
   reg lock3posneg;
   always @(posedge rstlock3latch or negedge lock3) begin
	  if (rstlock3latch) begin
	     lock3posneg <= 1'b0;
	  end else begin
	     lock3posneg <= lock3pos;
	  end
   end
   reg lockfail3;
   always @(negedge PONRESB or posedge lock3posneg) begin
	  if (!PONRESB) begin
	     lockfail3 <= 1'b0;
	  end else begin
	     lockfail3 <= 1'b1;
	  end
   end
   
   wire rstdcm3src = !PONRESB | lock3posneg;
   reg 	rstdcm3srcd1, rstdcm3srcd2, rstdcm3srcd3, rstdcm3srcd4;
   always @(negedge PONRESB or posedge CLK60MHZ) begin
	  if (!PONRESB) begin
	     rstdcm3srcd1 <= 1'b1;
	     rstdcm3srcd2 <= 1'b1;
	     rstdcm3srcd3 <= 1'b1;
	     rstdcm3srcd4 <= 1'b1;
	  end else begin
	     if (lock0) begin
			rstdcm3srcd1 <= rstdcm3src;
			rstdcm3srcd2 <= rstdcm3srcd1;
			rstdcm3srcd3 <= rstdcm3srcd2;
			rstdcm3srcd4 <= rstdcm3srcd3;
	     end
	  end
   end
   assign rstdcm3 = rstdcm3srcd1 | rstdcm3srcd2 | rstdcm3srcd3 | rstdcm3srcd4;

   dcm3 dcm3(.CLKIN_IN(CLK60MHZ), 
             .RST_IN(rstdcm3), 
             .CLKFX_OUT(clk147), 
             .LOCKED_OUT(lock3));


/*   
   //BUFG buf3 (.I(fb3i), .O(fb3o)); // ForSim
   DCM #(.CLKFX_DIVIDE(11), .CLKFX_MULTIPLY(27))
   dcm3 (.CLKIN(CLK60MHZP), .CLKFX(clk147), .RST(rstdcm3), .LOCKED(lock3),
		 .CLKFB(1'b0), .DSSEN(1'b0), .PSCLK(1'b0), .PSEN(1'b0), .PSINCDEC(1'b0), // ForImpl
		 .CLK0(), .CLK90(), .CLK180(), .CLK270(), .CLK2X(), .CLK2X180(), .CLKDV(), // ForImpl
		 //.CLKFB(fb3o), .DSSEN(1'b0), .PSCLK(1'b0), .PSEN(1'b0), .PSINCDEC(1'b0), // ForSim
		 //.CLK0(fb3i), .CLK90(), .CLK180(), .CLK270(), .CLK2X(), .CLK2X180(), .CLKDV(), // ForSim
		 .CLKFX180(), .PSDONE(), .STATUS() );
*/
   
   //***************************************************************************************
   //DLLによるCLK150作成  150MHz出力
   //***************************************************************************************
   
   wire rstdcm4;
   wire rstlock4latch = !PONRESB | rstdcm4;
   reg 	lock4pos;
   always @(posedge rstlock4latch or posedge lock4) begin
	  if (rstlock4latch) begin
	     lock4pos <= 1'b0;
	  end else begin
	     lock4pos <= 1'b1;
	  end
   end
   reg lock4posneg;
   always @(posedge rstlock4latch or negedge lock4) begin
	  if (rstlock4latch) begin
	     lock4posneg <= 1'b0;
	  end else begin
	     lock4posneg <= lock4pos;
	  end
   end
   reg lockfail4;
   always @(negedge PONRESB or posedge lock4posneg) begin
	  if (!PONRESB) begin
	     lockfail4 <= 1'b0;
	  end else begin
	     lockfail4 <= 1'b1;
	  end
   end
   
   wire rstdcm4src = !PONRESB | lock4posneg;
   reg 	rstdcm4srcd1, rstdcm4srcd2, rstdcm4srcd3, rstdcm4srcd4;
   always @(negedge PONRESB or posedge CLK60MHZ) begin
	  if (!PONRESB) begin
	     rstdcm4srcd1 <= 1'b1;
	     rstdcm4srcd2 <= 1'b1;
	     rstdcm4srcd3 <= 1'b1;
	     rstdcm4srcd4 <= 1'b1;
	  end else begin
	     if (lock0) begin
			rstdcm4srcd1 <= rstdcm4src;
			rstdcm4srcd2 <= rstdcm4srcd1;
			rstdcm4srcd3 <= rstdcm4srcd2;
			rstdcm4srcd4 <= rstdcm4srcd3;
	     end
	  end
   end
   assign rstdcm4 = rstdcm4srcd1 | rstdcm4srcd2 | rstdcm4srcd3 | rstdcm4srcd4;

   dcm4 dcm4(.CLKIN_IN(CLK60MHZ), 
             .RST_IN(rstdcm4), 
             .CLKFX_OUT(clk150), 
             .LOCKED_OUT(lock4));

/*   
   //BUFG buf4 (.I(fb4i), .O(fb4o)); // ForSim
   DCM #(.CLKFX_DIVIDE(2), .CLKFX_MULTIPLY(5))
   dcm4 (.CLKIN(CLK60MHZP), .CLKFX(clk150), .RST(rstdcm4), .LOCKED(lock4),
		 .CLKFB(1'b0), .DSSEN(1'b0), .PSCLK(1'b0), .PSEN(1'b0), .PSINCDEC(1'b0), // ForImpl
		 .CLK0(), .CLK90(), .CLK180(), .CLK270(), .CLK2X(), .CLK2X180(), .CLKDV(), // ForImpl
		 //.CLKFB(fb4o), .DSSEN(1'b0), .PSCLK(1'b0), .PSEN(1'b0), .PSINCDEC(1'b0), // ForSim
		 //.CLK0(fb4i), .CLK90(), .CLK180(), .CLK270(), .CLK2X(), .CLK2X180(), .CLKDV(), // ForSim
		 .CLKFX180(), .PSDONE(), .STATUS() );
*/
   
   //***************************************************************************************
   //メイン発振器出力
   //***************************************************************************************
   wire		mclksel1, mclksel2, mclksel3, main_clk;

/*   
   BUFGMUX	mclk1sel (.O(mclksel1), .I0(CLK60MHZP), .I1(clk112), .S(eoscmmd[0]));
   BUFGMUX	mclk2sel (.O(mclksel2), .I0(clk142), .I1(clk147), .S(eoscmmd[0]));
   BUFGMUX	mclk3sel (.O(mclksel3), .I0(mclksel1), .I1(mclksel2), .S(eoscmmd[1]));
 */
   clockctl_cksel mclk1sel(.clk1(CLK60MHZ), .clk2(clk112), .sel2(eoscmmd[0]), .resb(PONRESB), .clkout(mclksel1));
   clockctl_cksel mclk2sel(.clk1(clk142), .clk2(clk147), .sel2(eoscmmd[0]), .resb(PONRESB), .clkout(mclksel2));
   clockctl_cksel mclk3sel(.clk1(mclksel1), .clk2(mclksel2), .sel2(eoscmmd[1]), .resb(PONRESB), .clkout(mclksel3));
   BUFGMUX	mclk4sel (.O(main_clk), .I0(mclksel3), .I1(clk150), .S(eoscmmd[2]));
   
   reg		main_wait, main_out_pos, main_out_neg;
   reg [7:0] main_count;
   wire 	 EVAMCLK, eoscmck0, main_out;
   
   always @(posedge main_clk) begin
	  main_wait <= ice_area_eoscm & ICEWR;
   end
   
   always @(posedge main_clk) begin
	  if (!eoscmmd[5]) begin
		 main_out_pos <= 1'b0;
		 main_count <= eoscmck;
		end
	  else if (main_wait) main_count <= main_count;
	  else if (main_count == ({1'b0, eoscmck[7:1]}+1) ) begin
		 main_out_pos <= 1'b1;
		 main_count <= main_count - 1;
	  end
	  else if (main_count == 8'b0) begin
		 main_out_pos <= 1'b0;
		 main_count <= eoscmck;
	  end
	  else main_count <= main_count - 1;
   end
   
   always @(negedge main_clk) begin
	  if (eoscmck[0]) main_out_neg <= 1'b1;
	  else            main_out_neg <= main_out_pos;
   end
   
   assign	main_out = main_out_pos & main_out_neg;
   assign	eoscmck0 = eoscmck[7] | eoscmck[6] | eoscmck[5] | eoscmck[4] |
					   eoscmck[3] | eoscmck[2] | eoscmck[1] | eoscmck[0];
   
//   BUFGMUX	evamclksel (.O(EVAMCLK), .I0(main_clk), .I1(main_out), .S(eoscmck0));
   clockctl_cksel evamclksel(.clk1(main_clk), .clk2(main_out), .sel2(eoscmck0), .resb(PONRESB), .clkout(EVAMCLK));
   
   //***************************************************************************************
   //RING発振器出力
   //***************************************************************************************
   reg		ring8MHz, ring16MHz;
   reg [3:0] ring8_count, ring16_count;
   wire 	 CPURCLK1SEL, EVARCLK;
   
   always @(negedge SYSRSOUTB or posedge clk112) begin
	  if (!SYSRSOUTB) begin
		 ring8MHz <= 1'b0;
		 ring8_count <= 4'hD;
	  end
	  else if (ring8_count == 4'h7) begin
		 ring8MHz <= 1'b1;
		 ring8_count <= ring8_count -1;
	  end
	  else if (ring8_count == 4'h0) begin
		 ring8MHz <= 1'b0;
		 ring8_count <= 4'hD;
	  end
	  else ring8_count <= ring8_count - 1;
   end
   
   always @(negedge SYSRSOUTB or posedge clk112) begin
	  if (!SYSRSOUTB) begin
		 ring16MHz <= 1'b0;
		 ring16_count <= 4'h6;
	  end
	  else if (ring16_count == 4'h3) begin
		 ring16MHz <= 1'b1;
		 ring16_count <= ring16_count -1;
	  end
	  else if (ring16_count == 4'h0) begin
		 ring16MHz <= 1'b0;
		 ring16_count <= 4'h6;
	  end
	  else ring16_count <= ring16_count - 1;
   end
   
   BUFGMUX	evarclksel (.O(EVARCLK), .I0(ring8MHz), .I1(ring16MHz), .S(CPURCLK1SEL));
   
   //***************************************************************************************
   //サブ発振器出力
   //***************************************************************************************
   reg		sub_wait, sub_out_pos, sub_out_neg;
   reg [11:0] sub_count;
   wire 	  EVASCLK, eoscsck0, sub_out;
   
   always @(posedge clk112) begin
	  sub_wait <= ice_area_eoscs & ICEWR;
   end
   
   always @(negedge eoscsmd[1] or posedge clk112) begin
	  if (!eoscsmd[1]) begin
		 sub_out_pos <= 1'b0;
		 sub_count <= eoscsck;
	  end
	  else if (sub_wait) sub_count <= sub_count;
	  else if (sub_count == ({1'b0, eoscsck[11:1]}+1) ) begin
		 sub_out_pos <= 1'b1;
		 sub_count <= sub_count - 1;
	  end
	  else if (sub_count == 12'b0) begin
		 sub_out_pos <= 1'b0;
		 sub_count <= eoscsck;
	  end
	  else sub_count <= sub_count - 1;
   end
   
   always @(posedge eoscsck[0] or negedge clk112) begin
	  if (eoscsck[0]) sub_out_neg <= 1'b1;
	  else            sub_out_neg <= sub_out_pos;
   end
   
   assign	sub_out = sub_out_pos & sub_out_neg;
	assign	eoscsck0 = eoscsck[11] | eoscsck[10] | eoscsck[9] | eoscsck[8] |
					   eoscsck[7] | eoscsck[6] | eoscsck[5] | eoscsck[4] |
					   eoscsck[3] | eoscsck[2] | eoscsck[1] | eoscsck[0];
   
//   BUFGMUX	evasclksel (.O(EVASCLK), .I0(clk112), .I1(sub_out), .S(eoscsck0));
   clockctl_cksel evasclksel(.clk1(clk112), .clk2(sub_out), .sel2(eoscsck0), .resb(PONRESB), .clkout(EVASCLK));

   //***************************************************************************************
   //CPU用発振器出力選択
   //クロック切り替え用同期回路を入れる。切り替え回路は２つのクロックの周波数によらないタイプで
   //片側のクロックが停止している場合はクロック出力が止まってしまうので注意が必要
   //***************************************************************************************
   wire		mclktmp1, mclktmp2, sclktmp;
   
//   BUFGMUX	mclk1mux (.O(mclktmp1), .I0(EVAMCLK), .I1(CPUTMCLK), .S(eoscmmd[3]));
   clockctl_cksel mclk1mux(.clk1(EVAMCLK), .clk2(CPUTMCLK), .sel2(eoscmmd[3]), .resb(PONRESB), .clkout(mclktmp1));
   
//   BUFGMUX	mclk2mux (.O(mclktmp2), .I0(mclktmp1), .I1(EVAOSCMCLK), .S(eoscmmd[4]));
   clockctl_cksel mclk2mux(.clk1(mclktmp1), .clk2(EVAOSCMCLK), .sel2(eoscmmd[4]), .resb(PONRESB), .clkout(mclktmp2));

   BUFGCE	mclkout (.O(CPUMCLK), .CE(eoscmmd[5]), .I(mclktmp2));
   
   BUFGMUX	ring1mux (.O(CPURCLK1), .I0(EVARCLK), .I1(EVAOSCRCLK1), .S(eoscrmd[1]));
   BUFGMUX	ring2mux (.O(CPURCLK2), .I0(CPUPRCLK2), .I1(EVAOSCRCLK2), .S(eoscrmd[2]));
   BUFGMUX	ring3mux (.O(CPURCLK3), .I0(CPUPRCLK3), .I1(EVAOSCRCLK3), .S(eoscrmd[3]));
   
//   BUFGMUX	sclkmux (.O(sclktmp), .I0(EVASCLK), .I1(CPUTSCLK), .S(eoscsmd[0]));
   clockctl_cksel sclkmux(.clk1(EVASCLK), .clk2(CPUTSCLK), .sel2(eoscsmd[0]), .resb(PONRESB), .clkout(sclktmp));

   BUFGCE	sclkout (.O(CPUSCLK), .CE(eoscsmd[1]), .I(sclktmp));
   
   //***************************************************************************************
   //レジスタ作成
   //***************************************************************************************
   assign ice_area_eoscm = (iceifa[31:4] == 28'h0802_800 && iceifa[3:2] == 2'b00) ? 1'b1 : 1'b0;
   assign ice_area_eoscs = (iceifa[31:4] == 28'h0802_800 && iceifa[3:2] == 2'b01) ? 1'b1 : 1'b0;
   assign ice_area_eoscr = (iceifa[31:4] == 28'h0802_800 && iceifa[3:2] == 2'b10) ? 1'b1 : 1'b0;
   assign ice_area_lockfail = (iceifa[31:4] == 28'h0802_800 && iceifa[3:2] == 2'b11) ? 1'b1 : 1'b0;
   always @(negedge ICEWR or negedge SYSRSOUTB) begin
	  if (!SYSRSOUTB) begin
		 eoscmmd[5:0] <= 6'b0;
		 eoscmck[7:0] <= 8'b0;
	  end
	  else if (ice_area_eoscm) begin
		 eoscmmd[5:0] <= icedi[21:16];
		 eoscmck[7:0] <= icedi[7:0];
	  end
   end
   always @(negedge ICEWR or negedge SYSRSOUTB) begin
	  if (!SYSRSOUTB) begin
		 eoscsmd[1:0] <= 2'b0;
		 eoscsck[11:0] <= 12'h0;
	  end
	  else if (ice_area_eoscs) begin
		 eoscsmd[1:0] <= icedi[17:16];
		 eoscsck[11:0] <= icedi[11:0];
	  end
   end
   always @(negedge ICEWR or negedge SYSRSOUTB) begin
	  if (!SYSRSOUTB) begin
		 eoscrmd[3:1] <= 3'b0;
	  end
	  else if (ice_area_eoscr) begin
		 eoscrmd[3:1] <= icedi[3:1];
	  end
   end
   
   always @(ice_area_eoscm or ice_area_eoscs or ice_area_eoscr or ice_area_lockfail or
			eoscmmd or eoscmck or eoscsmd or eoscsck or eoscrmd or
            LOCKFAIL31 or LOCKFAIL30 or LOCKFAIL29 or LOCKFAIL28 or LOCKFAIL27 or LOCKFAIL26 or LOCKFAIL25 or LOCKFAIL24 or 
            LOCKFAIL23 or LOCKFAIL22 or LOCKFAIL21 or LOCKFAIL20 or LOCKFAIL19 or LOCKFAIL18 or LOCKFAIL17 or LOCKFAIL16 or 
			LOCKFAIL15 or LOCKFAIL14 or LOCKFAIL13 or LOCKFAIL12 or LOCKFAIL11 or LOCKFAIL10 or LOCKFAIL9  or LOCKFAIL8  or 
			LOCKFAIL7  or LOCKFAIL6  or LOCKFAIL5  or lockfail4  or lockfail3  or lockfail2  or lockfail1  or lockfail0  ) begin
	  if      (ice_area_eoscm)   icedo = {10'b0, eoscmmd, 8'b0, eoscmck};
	  else if (ice_area_eoscs)   icedo = {14'b0, eoscsmd, 4'b0, eoscsck};
	  else if (ice_area_eoscr)   icedo = {28'b0, eoscrmd[3:1], 1'b0};
	  else if (ice_area_lockfail) icedo = { LOCKFAIL31 , LOCKFAIL30 , LOCKFAIL29 , LOCKFAIL28 , LOCKFAIL27 , LOCKFAIL26 , LOCKFAIL25 , LOCKFAIL24 , 
											LOCKFAIL23 , LOCKFAIL22 , LOCKFAIL21 , LOCKFAIL20 , LOCKFAIL19 , LOCKFAIL18 , LOCKFAIL17 , LOCKFAIL16 , 
											LOCKFAIL15 , LOCKFAIL14 , LOCKFAIL13 , LOCKFAIL12 , LOCKFAIL11 , LOCKFAIL10 , LOCKFAIL9  , LOCKFAIL8  , 
											LOCKFAIL7  , LOCKFAIL6  , LOCKFAIL5  , lockfail4  , lockfail3  , lockfail2  , lockfail1  , lockfail0  };
	  else                        icedo = 32'b0;
   end
   
   // [60MHz生成]
   dcm5 dcm5(.CLKIN_IN(CLK30MHZ), 
             .RST_IN(!PONRESB), 
             .CLKFX_OUT(CLK60MHZ), 
             .LOCKED_OUT(lock0));
/*   
   //BUFG buf5 (.I(fb5i), .O(fb5o)); // ForSim
   DCM #(.CLKFX_DIVIDE(1), .CLKFX_MULTIPLY(2))
   dcm5 (.CLKIN(CLK30MHZ), .CLKFX(CLK60MHZP), .RST(!PONRESB), .LOCKED(lock0),
		 .CLKFB(1'b0), .DSSEN(1'b0), .PSCLK(1'b0), .PSEN(1'b0), .PSINCDEC(1'b0), // ForImpl
		 .CLK0(), .CLK90(), .CLK180(), .CLK270(), .CLK2X(), .CLK2X180(), .CLKDV(), // ForImpl
		 //.CLKFB(fb5o), .DSSEN(1'b0), .PSCLK(1'b0), .PSEN(1'b0), .PSINCDEC(1'b0), // ForSim
		 //.CLK0(fb5i), .CLK90(), .CLK180(), .CLK270(), .CLK2X(), .CLK2X180(), .CLKDV(), // ForSim
		 .CLKFX180(), .PSDONE(), .STATUS()
		 );
   BUFG buf6 (.I(CLK60MHZP), .O(CLK60MHZ));
*/
   
   reg lock0pos;
   always @(negedge PONRESB or posedge lock0) begin
	  if (!PONRESB) begin
		 lock0pos <= 1'b0;
	  end else begin
		 lock0pos <= 1'b1;
	  end
   end
   always @(negedge PONRESB or negedge lock0) begin
	  if (!PONRESB) begin
		 lockfail0 <= 1'b0;
	  end else begin
		 if (lock0pos) begin
			lockfail0 <= 1'b1;
		 end
	  end
   end
   
   assign CLK60MHZLOCK = lock0;
   
endmodule


//////////////////////////////////////////////////////////////////////////
//
// Clock Selector with NO Glitch.					                    
//
// [Function]
//   Reset : Active Low
//   clockout = clk1 when sel2 = 0
//   clockout = clk2 when sel2 = 1
//
//////////////////////////////////////////////////////////////////////////
module clockctl_cksel (clk1, clk2, sel2, resb, clkout);
   input	clk1, clk2, sel2, resb;
   output	clkout;
   
   reg 		clk1mk;
   reg 		clk2mk;
   
   always @(negedge clk1 or negedge resb) begin
	  if (!resb)	clk1mk <= 1'b0;
	  else		clk1mk <= ~sel2 & ~clk2mk;
   end
   
   always @(negedge clk2 or negedge resb) begin
	  if (!resb)	clk2mk <= 1'b0;
	  else		clk2mk <= sel2 & ~clk1mk;
   end
   
   wire	clk1mkout = ~(clk1 & clk1mk);
   wire	clk2mkout = ~(clk2 & clk2mk);
   assign	clkout = ~(clk1mkout & clk2mkout);   
endmodule

`ifndef FPGA_V5

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 11.3
//  \   \         Application : xaw2verilog
//  /   /         Filename : dcm1.v
// /___/   /\     Timestamp : 02/12/2010 19:00:07
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: xaw2verilog -st /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v4/./dcm1.xaw /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v4/./dcm1
//Design Name: dcm1
//Device: xc4vlx80-10ff1148
//
// Module dcm1
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: Synplify
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.038 UI
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.339 ns
`timescale 1ns / 1ps

module dcm1(CLKIN_IN, 
            RST_IN, 
            CLKFX_OUT, 
            LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;
   DCM_ADV DCM_ADV_INST (.CLKFB(GND_BIT), 
                         .CLKIN(CLKIN_IN), 
                         .DADDR(GND_BUS_7[6:0]), 
                         .DCLK(GND_BIT), 
                         .DEN(GND_BIT), 
                         .DI(GND_BUS_16[15:0]), 
                         .DWE(GND_BIT), 
                         .PSCLK(GND_BIT), 
                         .PSEN(GND_BIT), 
                         .PSINCDEC(GND_BIT), 
                         .RST(RST_IN), 
                         .CLKDV(), 
                         .CLKFX(CLKFX_OUT), 
                         .CLKFX180(), 
                         .CLK0(), 
                         .CLK2X(), 
                         .CLK2X180(), 
                         .CLK90(), 
                         .CLK180(), 
                         .CLK270(), 
                         .DO(), 
                         .DRDY(), 
                         .LOCKED(LOCKED_OUT), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 15;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 28;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 16.667;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
endmodule

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 11.3
//  \   \         Application : xaw2verilog
//  /   /         Filename : dcm2.v
// /___/   /\     Timestamp : 02/12/2010 19:00:24
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: xaw2verilog -st /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v4/dcm2.xaw /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v4/dcm2
//Design Name: dcm2
//Device: xc4vlx80-10ff1148
//
// Module dcm2
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: Synplify
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.038 UI
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.269 ns
`timescale 1ns / 1ps

module dcm2(CLKIN_IN, 
            RST_IN, 
            CLKFX_OUT, 
            LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;
   DCM_ADV DCM_ADV_INST (.CLKFB(GND_BIT), 
                         .CLKIN(CLKIN_IN), 
                         .DADDR(GND_BUS_7[6:0]), 
                         .DCLK(GND_BIT), 
                         .DEN(GND_BIT), 
                         .DI(GND_BUS_16[15:0]), 
                         .DWE(GND_BIT), 
                         .PSCLK(GND_BIT), 
                         .PSEN(GND_BIT), 
                         .PSINCDEC(GND_BIT), 
                         .RST(RST_IN), 
                         .CLKDV(), 
                         .CLKFX(CLKFX_OUT), 
                         .CLKFX180(), 
                         .CLK0(), 
                         .CLK2X(), 
                         .CLK2X180(), 
                         .CLK90(), 
                         .CLK180(), 
                         .CLK270(), 
                         .DO(), 
                         .DRDY(), 
                         .LOCKED(LOCKED_OUT), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 8;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 19;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 16.667;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
endmodule

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 11.3
//  \   \         Application : xaw2verilog
//  /   /         Filename : dcm3.v
// /___/   /\     Timestamp : 02/12/2010 18:57:53
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: xaw2verilog -st /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v4/./dcm3.xaw /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v4/./dcm3
//Design Name: dcm3
//Device: xc4vlx80-10ff1148
//
// Module dcm3
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: Synplify
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.044 UI
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.299 ns
`timescale 1ns / 1ps

module dcm3(CLKIN_IN, 
            RST_IN, 
            CLKFX_OUT, 
            LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;
   DCM_ADV DCM_ADV_INST (.CLKFB(GND_BIT), 
                         .CLKIN(CLKIN_IN), 
                         .DADDR(GND_BUS_7[6:0]), 
                         .DCLK(GND_BIT), 
                         .DEN(GND_BIT), 
                         .DI(GND_BUS_16[15:0]), 
                         .DWE(GND_BIT), 
                         .PSCLK(GND_BIT), 
                         .PSEN(GND_BIT), 
                         .PSINCDEC(GND_BIT), 
                         .RST(RST_IN), 
                         .CLKDV(), 
                         .CLKFX(CLKFX_OUT), 
                         .CLKFX180(), 
                         .CLK0(), 
                         .CLK2X(), 
                         .CLK2X180(), 
                         .CLK90(), 
                         .CLK180(), 
                         .CLK270(), 
                         .DO(), 
                         .DRDY(), 
                         .LOCKED(LOCKED_OUT), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 11;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 27;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 16.667;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
endmodule

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 11.3
//  \   \         Application : xaw2verilog
//  /   /         Filename : dcm4.v
// /___/   /\     Timestamp : 02/12/2010 18:56:26
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: xaw2verilog -st /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v4/dcm4.xaw /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v4/dcm4
//Design Name: dcm4
//Device: xc4vlx80-10ff1148
//
// Module dcm4
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: Synplify
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.031 UI
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.210 ns
`timescale 1ns / 1ps

module dcm4(CLKIN_IN, 
            RST_IN, 
            CLKFX_OUT, 
            LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;
   DCM_ADV DCM_ADV_INST (.CLKFB(GND_BIT), 
                         .CLKIN(CLKIN_IN), 
                         .DADDR(GND_BUS_7[6:0]), 
                         .DCLK(GND_BIT), 
                         .DEN(GND_BIT), 
                         .DI(GND_BUS_16[15:0]), 
                         .DWE(GND_BIT), 
                         .PSCLK(GND_BIT), 
                         .PSEN(GND_BIT), 
                         .PSINCDEC(GND_BIT), 
                         .RST(RST_IN), 
                         .CLKDV(), 
                         .CLKFX(CLKFX_OUT), 
                         .CLKFX180(), 
                         .CLK0(), 
                         .CLK2X(), 
                         .CLK2X180(), 
                         .CLK90(), 
                         .CLK180(), 
                         .CLK270(), 
                         .DO(), 
                         .DRDY(), 
                         .LOCKED(LOCKED_OUT), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 2;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 5;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 16.667;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
endmodule // dcm4

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 11.3
//  \   \         Application : xaw2verilog
//  /   /         Filename : dcm5.v
// /___/   /\     Timestamp : 02/15/2010 09:24:00
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: xaw2verilog -st /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v4/dcm5.xaw /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v4/dcm5
//Design Name: dcm5
//Device: xc4vlx80-10ff1148
//
// Module dcm5
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: Synplify
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.027 UI
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.454 ns
`timescale 1ns / 1ps

module dcm5(CLKIN_IN, 
            RST_IN, 
            CLKFX_OUT, 
            LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), 
                         .O(CLKFX_OUT));
   DCM_ADV DCM_ADV_INST (.CLKFB(GND_BIT), 
                         .CLKIN(CLKIN_IN), 
                         .DADDR(GND_BUS_7[6:0]), 
                         .DCLK(GND_BIT), 
                         .DEN(GND_BIT), 
                         .DI(GND_BUS_16[15:0]), 
                         .DWE(GND_BIT), 
                         .PSCLK(GND_BIT), 
                         .PSEN(GND_BIT), 
                         .PSINCDEC(GND_BIT), 
                         .RST(RST_IN), 
                         .CLKDV(), 
                         .CLKFX(CLKFX_BUF), 
                         .CLKFX180(), 
                         .CLK0(), 
                         .CLK2X(), 
                         .CLK2X180(), 
                         .CLK90(), 
                         .CLK180(), 
                         .CLK270(), 
                         .DO(), 
                         .DRDY(), 
                         .LOCKED(LOCKED_OUT), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 1;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 2;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 33.333;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
endmodule


`else

 ////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 11.3
//  \   \         Application : xaw2verilog
//  /   /         Filename : dcm1.v
// /___/   /\     Timestamp : 02/12/2010 19:04:01
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: xaw2verilog -st /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v5/./dcm1.xaw /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v5/./dcm1
//Design Name: dcm1
//Device: xc5vlx110-2ff1153
//
// Module dcm1
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: Synplify
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.057 UI
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.507 ns
`timescale 1ns / 1ps

module dcm1(CLKIN_IN, 
            RST_IN, 
            CLKFX_OUT, 
            LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), 
                         .O(CLKFX_OUT));
   DCM_ADV DCM_ADV_INST (.CLKFB(GND_BIT), 
                         .CLKIN(CLKIN_IN), 
                         .DADDR(GND_BUS_7[6:0]), 
                         .DCLK(GND_BIT), 
                         .DEN(GND_BIT), 
                         .DI(GND_BUS_16[15:0]), 
                         .DWE(GND_BIT), 
                         .PSCLK(GND_BIT), 
                         .PSEN(GND_BIT), 
                         .PSINCDEC(GND_BIT), 
                         .RST(RST_IN), 
                         .CLKDV(), 
                         .CLKFX(CLKFX_BUF), 
                         .CLKFX180(), 
                         .CLK0(), 
                         .CLK2X(), 
                         .CLK2X180(), 
                         .CLK90(), 
                         .CLK180(), 
                         .CLK270(), 
                         .DO(), 
                         .DRDY(), 
                         .LOCKED(LOCKED_OUT), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 15;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 28;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 16.667;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
   defparam DCM_ADV_INST.SIM_DEVICE = "VIRTEX5";
endmodule // dcm1

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 11.3
//  \   \         Application : xaw2verilog
//  /   /         Filename : dcm2.v
// /___/   /\     Timestamp : 02/12/2010 19:05:02
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: xaw2verilog -st /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v5/./dcm2.xaw /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v5/./dcm2
//Design Name: dcm2
//Device: xc5vlx110-2ff1153
//
// Module dcm2
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: Synplify
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.046 UI
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.324 ns
`timescale 1ns / 1ps

module dcm2(CLKIN_IN, 
            RST_IN, 
            CLKFX_OUT, 
            LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), 
                         .O(CLKFX_OUT));
   DCM_ADV DCM_ADV_INST (.CLKFB(GND_BIT), 
                         .CLKIN(CLKIN_IN), 
                         .DADDR(GND_BUS_7[6:0]), 
                         .DCLK(GND_BIT), 
                         .DEN(GND_BIT), 
                         .DI(GND_BUS_16[15:0]), 
                         .DWE(GND_BIT), 
                         .PSCLK(GND_BIT), 
                         .PSEN(GND_BIT), 
                         .PSINCDEC(GND_BIT), 
                         .RST(RST_IN), 
                         .CLKDV(), 
                         .CLKFX(CLKFX_BUF), 
                         .CLKFX180(), 
                         .CLK0(), 
                         .CLK2X(), 
                         .CLK2X180(), 
                         .CLK90(), 
                         .CLK180(), 
                         .CLK270(), 
                         .DO(), 
                         .DRDY(), 
                         .LOCKED(LOCKED_OUT), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 8;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 19;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 16.667;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
   defparam DCM_ADV_INST.SIM_DEVICE = "VIRTEX5";
endmodule // dcm2

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 11.3
//  \   \         Application : xaw2verilog
//  /   /         Filename : dcm3.v
// /___/   /\     Timestamp : 02/12/2010 19:05:41
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: xaw2verilog -st /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v5/./dcm3.xaw /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v5/./dcm3
//Design Name: dcm3
//Device: xc5vlx110-2ff1153
//
// Module dcm3
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: Synplify
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.059 UI
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.403 ns
`timescale 1ns / 1ps

module dcm3(CLKIN_IN, 
            RST_IN, 
            CLKFX_OUT, 
            LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), 
                         .O(CLKFX_OUT));
   DCM_ADV DCM_ADV_INST (.CLKFB(GND_BIT), 
                         .CLKIN(CLKIN_IN), 
                         .DADDR(GND_BUS_7[6:0]), 
                         .DCLK(GND_BIT), 
                         .DEN(GND_BIT), 
                         .DI(GND_BUS_16[15:0]), 
                         .DWE(GND_BIT), 
                         .PSCLK(GND_BIT), 
                         .PSEN(GND_BIT), 
                         .PSINCDEC(GND_BIT), 
                         .RST(RST_IN), 
                         .CLKDV(), 
                         .CLKFX(CLKFX_BUF), 
                         .CLKFX180(), 
                         .CLK0(), 
                         .CLK2X(), 
                         .CLK2X180(), 
                         .CLK90(), 
                         .CLK180(), 
                         .CLK270(), 
                         .DO(), 
                         .DRDY(), 
                         .LOCKED(LOCKED_OUT), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 11;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 27;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 16.667;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
   defparam DCM_ADV_INST.SIM_DEVICE = "VIRTEX5";
endmodule // dcm3

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 11.3
//  \   \         Application : xaw2verilog
//  /   /         Filename : dcm4.v
// /___/   /\     Timestamp : 02/12/2010 19:06:14
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: xaw2verilog -st /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v5/./dcm4.xaw /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v5/./dcm4
//Design Name: dcm4
//Device: xc5vlx110-2ff1153
//
// Module dcm4
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: Synplify
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.025 UI
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.167 ns
`timescale 1ns / 1ps

module dcm4(CLKIN_IN, 
            RST_IN, 
            CLKFX_OUT, 
            LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), 
                         .O(CLKFX_OUT));
   DCM_ADV DCM_ADV_INST (.CLKFB(GND_BIT), 
                         .CLKIN(CLKIN_IN), 
                         .DADDR(GND_BUS_7[6:0]), 
                         .DCLK(GND_BIT), 
                         .DEN(GND_BIT), 
                         .DI(GND_BUS_16[15:0]), 
                         .DWE(GND_BIT), 
                         .PSCLK(GND_BIT), 
                         .PSEN(GND_BIT), 
                         .PSINCDEC(GND_BIT), 
                         .RST(RST_IN), 
                         .CLKDV(), 
                         .CLKFX(CLKFX_BUF), 
                         .CLKFX180(), 
                         .CLK0(), 
                         .CLK2X(), 
                         .CLK2X180(), 
                         .CLK90(), 
                         .CLK180(), 
                         .CLK270(), 
                         .DO(), 
                         .DRDY(), 
                         .LOCKED(LOCKED_OUT), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 2;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 5;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 16.667;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
   defparam DCM_ADV_INST.SIM_DEVICE = "VIRTEX5";
endmodule // dcm4

////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 11.3
//  \   \         Application : xaw2verilog
//  /   /         Filename : dcm5.v
// /___/   /\     Timestamp : 02/12/2010 19:08:37
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: xaw2verilog -st /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v5/dcm5.xaw /home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/K0R-Kx4/SpeedCheck/coregen_v5/dcm5
//Design Name: dcm5
//Device: xc5vlx110-2ff1153
//
// Module dcm5
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: Synplify
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.012 UI
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.199 ns
`timescale 1ns / 1ps

module dcm5(CLKIN_IN, 
            RST_IN, 
            CLKFX_OUT, 
            LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), 
                         .O(CLKFX_OUT));
   DCM_ADV DCM_ADV_INST (.CLKFB(GND_BIT), 
                         .CLKIN(CLKIN_IN), 
                         .DADDR(GND_BUS_7[6:0]), 
                         .DCLK(GND_BIT), 
                         .DEN(GND_BIT), 
                         .DI(GND_BUS_16[15:0]), 
                         .DWE(GND_BIT), 
                         .PSCLK(GND_BIT), 
                         .PSEN(GND_BIT), 
                         .PSINCDEC(GND_BIT), 
                         .RST(RST_IN), 
                         .CLKDV(), 
                         .CLKFX(CLKFX_BUF), 
                         .CLKFX180(), 
                         .CLK0(), 
                         .CLK2X(), 
                         .CLK2X180(), 
                         .CLK90(), 
                         .CLK180(), 
                         .CLK270(), 
                         .DO(), 
                         .DRDY(), 
                         .LOCKED(LOCKED_OUT), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 1;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 2;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 33.333;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
   defparam DCM_ADV_INST.SIM_DEVICE = "VIRTEX5";
endmodule // dcm5 

`endif
