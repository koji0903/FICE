//-----------------------------------------------------------------------------
// Title         : IECUBE side FPGA
// Project       : RL78-IECUBE inspection environment
//-----------------------------------------------------------------------------
// File          : itrl78qbv1.v
// Author        : Tsunoda Tomonori
// Created       : 05.06.2012
// Last modified : 04.09.2012
//-----------------------------------------------------------------------------
// Description :
// inspection module for iecube side (TOP module).
//-----------------------------------------------------------------------------
// Copyright (c) 2012 by Renesas Electronics This model is the confidential and
// proprietary property of Renesas Electronics and the possession or use of this
// file requires a written license from Renesas Electronics.
//------------------------------------------------------------------------------
// Modification history :
// 31.08.2012 : Changed port (SIN,SOUT,SCLK,RDREADY->QBSI,QBSO,QBSCK,QBRDRDY).
// 12.06.2012 : created
//-----------------------------------------------------------------------------
module ITRL78QBV1 (
                   
`ifdef ITRL78QBV1_BUSSTYLE
		           
                   EXMA,
                   MA,
                   MDW,
                   MDRRAM,
                   MDR_RAM,
                   
`else
                   
                   EXMA3,
                   EXMA2,
                   EXMA1,
                   EXMA0,
                   MA15,
                   MA14,
                   MA13,
                   MA12,
                   MA11,
                   MA10,
                   MA9,
                   MA8,
                   MA7,
                   MA6,
                   MA5,
                   MA4,
                   MA3,
                   MA2,
                   MA1,
                   MA0,
                   MDW15,
                   MDW14,
                   MDW13,
                   MDW12,
                   MDW11,
                   MDW10,
                   MDW9,
                   MDW8,
                   MDW7,
                   MDW6,
                   MDW5,
                   MDW4,
                   MDW3,
                   MDW2,
                   MDW1,
                   MDW0,
                   MDRRAM15,
                   MDRRAM14,
                   MDRRAM13,
                   MDRRAM12,
                   MDRRAM11,
                   MDRRAM10,
                   MDRRAM9,
                   MDRRAM8,
                   MDRRAM7,
                   MDRRAM6,
                   MDRRAM5,
                   MDRRAM4,
                   MDRRAM3,
                   MDRRAM2,
                   MDRRAM1,
                   MDRRAM0,
                   MDR_RAM15,
                   MDR_RAM14,
                   MDR_RAM13,
                   MDR_RAM12,
                   MDR_RAM11,
                   MDR_RAM10,
                   MDR_RAM9,
                   MDR_RAM8,
                   MDR_RAM7,
                   MDR_RAM6,
                   MDR_RAM5,
                   MDR_RAM4,
                   MDR_RAM3,
                   MDR_RAM2,
                   MDR_RAM1,
                   MDR_RAM0,
                   
`endif // !`ifdef ITRL78QBV1_BUSSTYLE
                   
                   CLK30MHZ,
                   RESB,
                   SYSRSOUTB,
                   CPUCLK,
                   FLREAD,
                   WDOP,
                   CPUWR,
                   CPURD,
                   QBRDRDY,
                   QBSI,
                   QBSO,
                   QBSCK
                   );
   
`ifdef ITRL78QBV1_BUSSTYLE
   
   input [3:0]   EXMA;
   input [15:0]  MA;
   input [15:0]  MDW;
   output [15:0] MDRRAM;
   input [15:0]  MDR_RAM;
   
`else
   
   input         EXMA3, EXMA2, EXMA1, EXMA0;
   input         MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8,
                 MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0;
   input         MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8,
                 MDW7, MDW6, MDW5, MDW4, MDW3, MDW2, MDW1, MDW0;
   output        MDRRAM15, MDRRAM14, MDRRAM13, MDRRAM12,
                 MDRRAM11, MDRRAM10, MDRRAM9, MDRRAM8,
                 MDRRAM7, MDRRAM6, MDRRAM5, MDRRAM4,
                 MDRRAM3, MDRRAM2, MDRRAM1, MDRRAM0;
   input         MDR_RAM15, MDR_RAM14, MDR_RAM13, MDR_RAM12,
                 MDR_RAM11, MDR_RAM10, MDR_RAM9, MDR_RAM8,
                 MDR_RAM7, MDR_RAM6, MDR_RAM5, MDR_RAM4,
                 MDR_RAM3, MDR_RAM2, MDR_RAM1, MDR_RAM0;
   
`endif // !`ifdef ITRL78QBV1_BUSSTYLE
   
   input         CLK30MHZ;
   input         RESB;
   input         SYSRSOUTB;
   input         CPUCLK;
   input         FLREAD;
   input         WDOP;
   input         CPUWR;
   input         CPURD;
   input         QBRDRDY;
   input         QBSI;
   output        QBSO;
   output        QBSCK;
   
   wire [15:0]   ma;
   wire [3:0]    exma;
   wire [15:0]   mdw;
   wire [15:0]   mdr;
   wire [15:0]   mdr_ram;
   wire [7:0]    txdat;
   wire [7:0]    rdbuf;
   wire          clk5m;
   wire          clk1m;
   wire          done;
   wire          done_syncmclk;
   wire          rdrdy_cpu;
   wire          sttrg;
   wire          rdrdy_cpu_clear;
   wire          rdrdy_nf;
   wire          trg;
   wire          store;
   wire          si_nf;
   
   
`ifdef ITRL78QBV1_BUSSTYLE

   assign exma = EXMA;
   assign ma = MA;
   assign mdw = MDW;
   assign mdr_ram = MDR_RAM;
   assign MDRRAM = mdr | mdr_ram;

`else

   assign exma = {EXMA3, EXMA2, EXMA1, EXMA0};
   assign ma = {MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8,
                MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0};
   assign mdw = {MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8,
                 MDW7, MDW6, MDW5, MDW4, MDW3, MDW2, MDW1, MDW0};

   assign mdr_ram = {MDR_RAM15, MDR_RAM14, MDR_RAM13, MDR_RAM12,
                     MDR_RAM11, MDR_RAM10, MDR_RAM9, MDR_RAM8,
                     MDR_RAM7, MDR_RAM6, MDR_RAM5, MDR_RAM4,
                     MDR_RAM3, MDR_RAM2, MDR_RAM1, MDR_RAM0};
   
   assign {MDRRAM15, MDRRAM14, MDRRAM13, MDRRAM12,
           MDRRAM11, MDRRAM10, MDRRAM9, MDRRAM8,
           MDRRAM7, MDRRAM6, MDRRAM5, MDRRAM4,
           MDRRAM3, MDRRAM2, MDRRAM1, MDRRAM0} = mdr | mdr_ram;

`endif
   
   
   ITRL78QBV1_DIVIDER mclkgen (.clkin(CLK30MHZ),
                               .resb(SYSRSOUTB),
                               .clkdiv6(clk5m),
                               .clkdiv30(clk1m));
   
   ITRL78QBV1_CPUIF cpuif (.exma(exma),
                           .ma(ma),
                           .mdw(mdw),
                           .cpuclk(CPUCLK),
                           .resb(RESB),
                           .flread(FLREAD),
                           .wdop(WDOP),
                           .cpuwr(CPUWR),
                           .cpurd(CPURD),
                           .done(done),
                           .rdbuf(rdbuf),
                           .rdrdy_cpu(rdrdy_cpu),
                           .mdr(mdr),
                           .txdat(txdat),
                           .sttrg(sttrg),
                           .rdrdy_cpu_clear(rdrdy_cpu_clear));
   
   ITRL78QBV1_SEQUENCER sequencer (.cpuclk(CPUCLK),
                                   .mclk(clk1m),
                                   .nfclk(clk5m),
                                   .resb(SYSRSOUTB),
                                   .sttrg(sttrg),
                                   .rdready(rdrdy_nf),
                                   .rdrdy_cpu_clear(rdrdy_cpu_clear),
                                   .trg(trg),
                                   .rdrdy_cpu(rdrdy_cpu),
                                   .done_syncmclk(done_syncmclk));
   
   ITRL78QBV1_SCLKGEN sclkgen (.trg(trg),
                               .mclk(clk1m),
                               .resb(SYSRSOUTB),
                               .cpuclk(CPUCLK),
                               .sclk(QBSCK),
                               .store(store),
                               .done(done),
                               .done_syncmclk(done_syncmclk));
   
   ITRL78QBV1_FILTER_MIN200 rdyfilter (.nfclk(clk5m),
                                       .i(QBRDRDY),
                                       .o(rdrdy_nf),
                                       .resb(SYSRSOUTB));
   
   ITRL78QBV1_FILTER_MIN600 sifilter (.nfclk(clk5m),
                                      .i(QBSI),
                                      .o(si_nf),
                                      .resb(SYSRSOUTB));
   
   ITRL78QBV1_PARASERI sender (.sclk(QBSCK),
                               .store(store),
                               .pi(txdat),
                               .so(QBSO));
   
   ITRL78QBV1_SERIPARA receiver (.sclk(QBSCK),
                                 .si(si_nf),
                                 .po(rdbuf));
   
endmodule // ITRL78QBV1

//////////////////////////////////////////////////////////////////
// (C) 2012 Renesas Electronics Corporation.
// For FPGA of RL78-IECUBE inspection environment.
// Function : Virtual Cell for clock driver.
//////////////////////////////////////////////////////////////////
// History (Insert a new history to the upper side of the below.)
// ---------------------------------------------------------------
// Date     : 2012.06.05
// Author   : Tsunoda
// Outline  : New.
//////////////////////////////////////////////////////////////////
module ITRL78QBV1_DIVIDER (clkin, resb, clkdiv6, clkdiv30);
   input clkin;
   input resb;
   output clkdiv6;
   output clkdiv30;
   
   reg [4:0] counter;
   always @(posedge clkin or negedge resb) begin
      if (!resb) begin
         counter <= 5'h00;
      end else if (counter==30'h1d) begin
         counter <= 5'h00;
      end else begin
         counter <= counter + 1;
      end
   end

   reg clkdiv6p;
   always @(posedge clkin or negedge resb) begin
      if (!resb) begin
         clkdiv6p <= 1'b0;
      end else if ((counter==5'h02)||(counter==5'h08)||
                   (counter==5'h0e)||(counter==5'h14)||
                   (counter==5'h1a)) begin
         clkdiv6p <= 1'b0;
      end else if ((counter==5'h05)||(counter==5'h0b)||
                   (counter==5'h11)||(counter==5'h17)||
                   (counter==5'h1d)) begin
         clkdiv6p <= 1'b1;
      end
   end // always @ (posedge clkin or negedge resb)
   
   ITRL78QBV1_CLKBUF bufdiv6 (.clkin(clkdiv6p), .clkout(clkdiv6));
   
   reg clkdiv30p;
   always @(posedge clkin or negedge resb) begin
      if (!resb) begin
         clkdiv30p <= 1'b0;
      end else if (counter==5'h0e) begin
         clkdiv30p <= 1'b0;
      end else if (counter==5'h1d) begin
         clkdiv30p <= 1'b1;
      end
   end
   
   ITRL78QBV1_CLKBUF bufdiv30 (.clkin(clkdiv30p), .clkout(clkdiv30));
   
endmodule // ITRL78QBV1_DIVIDER

//////////////////////////////////////////////////////////////////
// (C) 2012 Renesas Electronics Corporation.
// For FPGA of RL78-IECUBE inspection environment.
// Function : ICE controller in CPU(2ndsfr) area. It is driven
//            by CPU clock as a module of CPU synchronous domain.
//////////////////////////////////////////////////////////////////
// History (Insert a new history to the upper side of the below.)
// ---------------------------------------------------------------
// Date     : 2012.06.05
// Author   : Tsunoda
// Outline  : New.
//////////////////////////////////////////////////////////////////
module ITRL78QBV1_CPUIF (exma, ma, mdw, cpuclk, resb, flread,
                         wdop, cpuwr, cpurd, done, rdbuf, rdrdy_cpu,
                         mdr, txdat, sttrg, rdrdy_cpu_clear);
   
   parameter TXDAT = 16'h0040;
   parameter RXDAT = 16'h0041;
   parameter STTRG = 16'h0042;
   parameter RDRDY = 16'h0043;
   
   output [15:0] mdr;
   output [7:0]  txdat;
   output        sttrg;
   output        rdrdy_cpu_clear;
   input [15:0]  ma;
   input [3:0] 	 exma;
   input [15:0]  mdw;
   input         cpuclk;
   input         resb;
   input         flread;
   input         wdop;
   input         cpuwr;
   input         cpurd;
   input         done;
   input [7:0]   rdbuf;
   input         rdrdy_cpu;
   
   wire exma_flag = & exma;
   wire sl_icesfr = exma_flag & (ma[15:4] == 12'h00D) & ~flread & wdop;
   wire sl_iceadr = sl_icesfr & (ma[3:0] == 4'h0);
   wire sl_icedat = sl_icesfr & (ma[3:0] == 4'h2);
   
   reg [15:0] iceadr;
   always @(posedge cpuclk or negedge resb) begin
      if (!resb) begin
         iceadr <= 16'h0000;
      end else if (sl_iceadr & cpuwr) begin
         iceadr <= mdw;
      end
   end
   
   reg [7:0] txdat;
   always @(posedge cpuclk or negedge resb) begin
      if (!resb) begin
         txdat <= 8'h00;
      end else if (sl_icedat & (iceadr==TXDAT) & cpuwr) begin
         txdat <= mdw[7:0];
      end
   end
   
   reg sttrg;
   always @(posedge cpuclk or negedge resb) begin
      if (!resb) begin
         sttrg <= 1'b0;
      end else if (done) begin
         sttrg <= 1'b0;
      end else if (sl_icedat & (iceadr==STTRG) & cpuwr) begin
         sttrg <= mdw[0];
      end
   end
   
   reg [7:0] rxdat;
   always @(posedge cpuclk or negedge resb) begin
      if (!resb) begin
         rxdat <= 8'h00;
      end else if (done) begin
         rxdat <= rdbuf;
      end
   end
   
   reg [15:0] mdr;
   always @(sl_iceadr or sl_icedat or iceadr or txdat or rxdat or sttrg or rdrdy_cpu) begin
      casex({sl_iceadr, sl_icedat, iceadr})
        {1'b1, 1'bx, 16'hxxxx} : mdr = iceadr;
        {1'b0, 1'b1, TXDAT} : mdr = {8'h00, txdat};
        {1'b0, 1'b1, RXDAT} : mdr = {8'h00, rxdat};
        {1'b0, 1'b1, STTRG} : mdr = {15'h0000, sttrg};
        {1'b0, 1'b1, RDRDY} : mdr = {15'h0000, rdrdy_cpu};
        default : mdr = 16'h0000;
      endcase // casex ({sl_iceadr, sl_icedat, iceadr})
   end

   reg rdrdy_cpu_clear;
   always @(posedge cpuclk or negedge resb) begin
      if (!resb) begin
         rdrdy_cpu_clear <= 1'b0;
      end else if (sl_icedat & (iceadr == RXDAT) & cpurd) begin
         rdrdy_cpu_clear <= 1'b1;
      end else begin
         rdrdy_cpu_clear <= 1'b0;
      end
   end
   
endmodule // ITRL78QBV1_CPUIF

//////////////////////////////////////////////////////////////////
// (C) 2012 Renesas Electronics Corporation.
// For FPGA of RL78-IECUBE inspection environment.
// Function : sequencer for parallel to serial interface.
//////////////////////////////////////////////////////////////////
// History (Insert a new history to the upper side of the below.)
// ---------------------------------------------------------------
// Date     : 2012.09.18
// Author   : Tsunoda
// Outline  : adjust the timing of clear rdrdy_cpu. It considered the
//            case which cpu clock is extremely slow. then, rdrdy
//            synchronized with cpu and transfer-done timing is reversed.
// ---------------------------------------------------------------
// Date     : 2012.09.04
// Author   : Tsunoda
// Outline  : Added rdrdy_synccpu* and reset condition to trg_rdrdy_status
//             to fix the illegal initial value of rdrdy_cpu.
// ---------------------------------------------------------------
// Date     : 2012.09.03
// Author   : Tsunoda
// Outline  : modified rdrdy_cpu to be reset by synchronous.
// ---------------------------------------------------------------
// Date     : 2012.06.05
// Author   : Tsunoda
// Outline  : New.
//////////////////////////////////////////////////////////////////
module ITRL78QBV1_SEQUENCER (cpuclk, mclk, nfclk, resb, sttrg, rdready,
                             rdrdy_cpu_clear, trg, rdrdy_cpu, done_syncmclk);
   output trg;
   output rdrdy_cpu;
   input  cpuclk;
   input  mclk;
   input  nfclk;
   input  resb;
   input  sttrg;
   input  rdready;
   input  rdrdy_cpu_clear;
   input  done_syncmclk;
   
   // trigger for sclkgen by sttrg (cpuclk -> mclk)
   reg [1:0] sttrg_syncmclk;
   always @(posedge mclk or negedge resb) begin
      if (!resb) begin
         sttrg_syncmclk <= 1'b0;
      end else begin
         sttrg_syncmclk <= {sttrg_syncmclk[0], sttrg};
      end
   end
   
   reg sttrg_l;
   always @(posedge mclk or negedge resb) begin
      if (!resb) begin
         sttrg_l <= 1'b0;
      end else begin
         sttrg_l <= sttrg_syncmclk[1];
      end
   end
   wire trg_sttrg = sttrg_syncmclk[1] & ~sttrg_l;

   reg rdrdy_syncnfclk;
   always @(posedge nfclk or negedge resb) begin
      if (!resb) begin
         rdrdy_syncnfclk <= 1'b0;
      end else begin
         rdrdy_syncnfclk <= rdready;
      end
   end
   wire rdrdy_pulse = ~rdready & rdrdy_syncnfclk;
   
   
   // syncronous to mclk
   
   reg [1:0] rdrdy_syncmclk;
   wire      rdrdy_async_clear = !resb | rdrdy_syncmclk[1];
   reg       rdrdy_async;
   
   always @(posedge rdrdy_pulse or posedge rdrdy_async_clear) begin
      if (rdrdy_async_clear) begin
         rdrdy_async <= 1'b0;
      end else begin
         rdrdy_async <= 1'b1;
      end
   end
   
   always @(posedge mclk or negedge resb) begin
      if (!resb) begin
         rdrdy_syncmclk <= 2'h0;
      end else begin
         rdrdy_syncmclk <= {rdrdy_syncmclk[0], rdrdy_async};
      end
   end
   
   reg rdrdy_syncmclk_l;
   always @(posedge mclk or negedge resb) begin
      if (!resb) begin
         rdrdy_syncmclk_l <= 1'b0;
      end else begin
         rdrdy_syncmclk_l <= rdrdy_syncmclk[1];
      end
   end
   
   wire trg_rdrdy = ~rdrdy_syncmclk[1] & rdrdy_syncmclk_l;
   
   assign trg = trg_sttrg | trg_rdrdy;
   
   // synchronous to cpuclk

// [2012.09.18]   reg [1:0] rdrdy_synccpuclk;
// [2012.09.18]   wire      rdrdy_async2_clear = !resb | rdrdy_synccpuclk[1];
// [2012.09.18]   reg       rdrdy_async2;
// [2012.09.18]   
// [2012.09.18]   always @(posedge rdrdy_pulse or posedge rdrdy_async2_clear) begin
// [2012.09.18]      if (rdrdy_async2_clear) begin
// [2012.09.18]         rdrdy_async2 <= 1'b0;
// [2012.09.18]      end else begin
// [2012.09.18]         rdrdy_async2 <= 1'b1;
// [2012.09.18]      end
// [2012.09.18]   end
// [2012.09.18]   
// [2012.09.18]   always @(posedge cpuclk or negedge resb) begin
// [2012.09.18]      if (!resb) begin
// [2012.09.18]         rdrdy_synccpuclk <= 2'h0;
// [2012.09.18]      end else begin
// [2012.09.18]         rdrdy_synccpuclk <= {rdrdy_synccpuclk[0], rdrdy_async2};
// [2012.09.18]      end
// [2012.09.18]   end
   
// [2012.09.18]   reg rdrdy_synccpuclk_l;
// [2012.09.18]   always @(posedge cpuclk or negedge resb) begin
// [2012.09.18]      if (!resb) begin
// [2012.09.18]         rdrdy_synccpuclk_l <= 1'b0;
// [2012.09.18]      end else begin
// [2012.09.18]         rdrdy_synccpuclk_l <= rdrdy_synccpuclk[1];
// [2012.09.18]      end
// [2012.09.18]   end
// [2012.09.18]   
// [2012.09.18]   assign trg_rdrdy_synccpuclk = ~rdrdy_synccpuclk[1] & rdrdy_synccpuclk_l;
   
// [2012.09.18]   // [2012.09.04]
// [2012.09.18]   reg 	trg_rdrdy_status;
// [2012.09.18]   always @(posedge cpuclk or negedge resb) begin
// [2012.09.18]      if (!resb) begin
// [2012.09.18]         trg_rdrdy_status <= 1'b0;
// [2012.09.18]      end else if (trg_rdrdy_synccpuclk) begin
// [2012.09.18]         trg_rdrdy_status <= 1'b1;
// [2012.09.18]      end else if (done) begin
// [2012.09.18]         trg_rdrdy_status <= 1'b0;
// [2012.09.18]      end
// [2012.09.18]   end
// [2012.09.18]   wire rdrdy_cpu_set = trg_rdrdy_status & done;

   // [2012.09.18]
   // sequence flag of rdrdy to done. considering the changing point of 2012.09.04.
   reg trg_rdrdy_status;
   always @(posedge mclk or negedge resb) begin
      if (!resb) begin
         trg_rdrdy_status <= 1'b0;
      end else if (trg_rdrdy) begin
         trg_rdrdy_status <= 1'b1;
      end else if (done_syncmclk) begin
         trg_rdrdy_status <= 1'b0;
      end
   end
   
   // [2012.09.18]
   // completion flag that read date have been got.
   reg done_rdrdy;
   reg [1:0] done_rdrdy_synccpuclk;
   assign done_rdrdy_clear = ~resb | done_rdrdy_synccpuclk[1];
   always @(posedge mclk or posedge done_rdrdy_clear) begin
      if (done_rdrdy_clear) begin
         done_rdrdy <= 1'b0;
      end else if (trg_rdrdy_status && done_syncmclk) begin
         done_rdrdy <= 1'b1;
      end
   end
   
   // [2012.09.18]
   // synchronizer to cpuclk.
   reg rdrdy_cpu_set;
   always @(posedge cpuclk or negedge resb) begin
      if (!resb) begin
         done_rdrdy_synccpuclk <= 2'h0;
      end else if (rdrdy_cpu_set) begin
         done_rdrdy_synccpuclk <= 2'h0;
      end else begin
         done_rdrdy_synccpuclk <= {done_rdrdy_synccpuclk[0], done_rdrdy};
      end
   end
   
   // [2012.09.18]
   // 1clock pulse of done_rdrdy_synccpuclk.
   always @(posedge cpuclk or negedge resb) begin
      if (!resb) begin
         rdrdy_cpu_set <= 1'b0;
      end else if (rdrdy_cpu_set) begin
         rdrdy_cpu_set <= 1'b0;
      end else if (done_rdrdy_synccpuclk[1]) begin
         rdrdy_cpu_set <= 1'b1;
      end
   end
   
   // [2012.09.03]
   // use synchronous clear.
   // because read rxdat -> read rdready can't do within 2 clocks.
   reg rdrdy_cpu;
   always @(posedge cpuclk or negedge resb) begin
      if (!resb) begin
         rdrdy_cpu <= 1'b1;
      end else if (rdrdy_cpu_set) begin
         rdrdy_cpu <= 1'b0;
      end else if (rdrdy_cpu_clear) begin
         rdrdy_cpu <= 1'b1;
      end
   end
   
endmodule // ITRL78QBV1_SEQUENCER

//////////////////////////////////////////////////////////////////
// (C) 2012 Renesas Electronics Corporation.
// For FPGA of RL78-IECUBE inspection environment.
// Function : serial master clock generator.
//////////////////////////////////////////////////////////////////
// History (Insert a new history to the upper side of the below.)
// ---------------------------------------------------------------
// Date     : 2012.06.05
// Author   : Tsunoda
// Outline  : New.
//////////////////////////////////////////////////////////////////
module ITRL78QBV1_SCLKGEN (trg, mclk, resb, cpuclk, sclk, store, done,
                           done_syncmclk);
   output sclk;
   output store;
   output done;
   output done_syncmclk;
   input  trg;
   input  mclk;
   input  resb;
   input  cpuclk;
   
   reg trg_l;
   reg cnten;
   reg [2:0] cnt3b;
   
   always @(posedge mclk or negedge resb) begin
      if (!resb) begin
         trg_l <= 1'b0;
      end else if (cnten) begin
         trg_l <= 1'b0;
      end else if (trg) begin
         trg_l <= 1'b1;
      end
   end
   
   always @(posedge mclk or negedge resb) begin
      if (!resb) begin
         cnten <= 1'b0;
      end else if (cnt3b == 3'h7) begin
         cnten <= 1'b0;
      end else if (trg_l) begin
         cnten <= 1'b1;
      end
   end
   
   assign store = trg_l & ~cnten;

   reg done_syncmclk;
   always @(posedge mclk or negedge resb) begin
      if (!resb) begin
         done_syncmclk <= 1'b0;
      end else if (cnt3b == 3'h7) begin
         done_syncmclk <= 1'b1;
      end else begin
         done_syncmclk <= 1'b0;
      end
   end
   
   reg [1:0] done_synccpuclk;
   wire      done_async_clear = done_synccpuclk[1] | !resb;
   reg       done_async;
   always @(posedge done_syncmclk or posedge done_async_clear) begin
      if (done_async_clear) begin
         done_async <= 1'b0;
      end else begin
         done_async <= 1'b1;
      end
   end
   
   always @(posedge cpuclk or negedge resb) begin
      if (!resb) begin
         done_synccpuclk <= 2'h0;
      end else begin
         done_synccpuclk <= {done_synccpuclk[0], done_async};
      end
   end
   assign done = done_synccpuclk[1];
   
   always @(posedge mclk or negedge resb) begin
      if (!resb) begin
         cnt3b <= 3'h0;
      end else if (!cnten) begin
         cnt3b <= 3'h0;
      end else begin
         cnt3b <= cnt3b + 1;
      end
   end
   
   reg clkmsk;
   always @(cnten or mclk or resb) begin
      if (!resb) begin
         clkmsk <= 1'b0;
      end else if (!mclk) begin
         clkmsk <= cnten;
      end else begin
         clkmsk <= clkmsk;
      end
   end
   assign sclk = clkmsk & mclk;
   
endmodule // ITRL78QBV1_SCLKGEN

//////////////////////////////////////////////////////////////////
// (C) 2012 Renesas Electronics Corporation.
// For FPGA of RL78-IECUBE inspection environment.
// Function : Degital noise filter with reset which passes
//          : minimum 600ns. It assumes that 5MHz is used for
//          : a clock (nfclk).
//////////////////////////////////////////////////////////////////
// History (Insert a new history to the upper side of the below.)
// ---------------------------------------------------------------
// Date     : 2012.06.05
// Author   : Tsunoda
// Outline  : New.
//////////////////////////////////////////////////////////////////
module ITRL78QBV1_FILTER_MIN600 (nfclk, i, o, resb);
   input nfclk, i, resb;
   output o;

   reg [1:0] dly /* synthesis syn_keep=1 */;
   always @(posedge nfclk or negedge resb) begin
      if (!resb) begin
         dly <= 2'h0;
      end else begin
         dly <= {dly[0], i};
      end
   end
   
   reg o /* synthesis syn_keep=1 */;
   always @(posedge nfclk or negedge resb) begin
      if (!resb) begin
         o <= 1'b0;
      end else if ((dly[0]==i)&&(dly[1]==i)) begin
         o <= dly[1];
      end else begin
         o <= o;
      end
   end
   
endmodule // ITRL78QBV1_FILTER_MIN600

//////////////////////////////////////////////////////////////////
// (C) 2012 Renesas Electronics Corporation.
// For FPGA of RL78-IECUBE inspection environment.
// Function : Degital noise filter with reset which passes
//          : minimum 200ns. It assumes that 5MHz is used for
//          : a clock (nfclk).
//////////////////////////////////////////////////////////////////
// History (Insert a new history to the upper side of the below.)
// ---------------------------------------------------------------
// Date     : 2012.06.05
// Author   : Tsunoda
// Outline  : New.
//////////////////////////////////////////////////////////////////
module ITRL78QBV1_FILTER_MIN200 (nfclk, i, o, resb);
   input nfclk, i, resb;
   output o;

   reg dly /* synthesis syn_keep=1 */;
   always @(posedge nfclk or negedge resb) begin
      if (!resb) begin
         dly <= 1'b0;
      end else begin
         dly <= i;
      end
   end
   
   reg o /* synthesis syn_keep=1 */;
   always @(posedge nfclk or negedge resb) begin
      if (!resb) begin
         o <= 1'b0;
      end else if (dly==i) begin
         o <= dly;
      end else begin
         o <= o;
      end
   end
   
endmodule // ITRL78QBV1_FILTER_MIN200

//////////////////////////////////////////////////////////////////
// (C) 2012 Renesas Electronics Corporation.
// For FPGA of RL78-IECUBE inspection environment.
// Function : Serial to parallel converter. (8bit,MSB first)
//////////////////////////////////////////////////////////////////
// History (Insert a new history to the upper side of the below.)
// ---------------------------------------------------------------
// Date     : 2012.06.05
// Author   : Tsunoda
// Outline  : New.
//////////////////////////////////////////////////////////////////
module ITRL78QBV1_SERIPARA (sclk, si, po);
   output [7:0] po;
   input 	sclk;
   input 	si;

   reg [7:0] rxbuf;
   always @(posedge sclk) begin
      rxbuf <= {rxbuf[6:0], si};
   end
   assign po = rxbuf;
   
endmodule // ITRL78QBV1_SERIPARA

//////////////////////////////////////////////////////////////////
// (C) 2012 Renesas Electronics Corporation.
// For FPGA of RL78-IECUBE inspection environment.
// Function : Parallel to serial converter. (8bit,MSB first)
//////////////////////////////////////////////////////////////////
// History (Insert a new history to the upper side of the below.)
// ---------------------------------------------------------------
// Date     : 2012.06.05
// Author   : Tsunoda
// Outline  : New.
//////////////////////////////////////////////////////////////////
module ITRL78QBV1_PARASERI (sclk, store, pi, so);
   input [7:0] pi;
   input       sclk;
   input       store;
   output      so;
   
   reg [7:0] txbuf;
   always @(posedge sclk or posedge store) begin
      if (store) begin
         txbuf <= pi;
      end else begin
         txbuf <= txbuf << 1;
      end
   end
   wire so = txbuf[7];
   
endmodule // ITRL78QBV1_PARASERI

//////////////////////////////////////////////////////////////////
// (C) 2012 Renesas Electronics Corporation.
// For FPGA of RL78-IECUBE inspection environment.
// Function : Virtual Cell for clock driver.
//////////////////////////////////////////////////////////////////
// History (Insert a new history to the upper side of the below.)
// ---------------------------------------------------------------
// Date     : 2012.06.05
// Author   : Tsunoda
// Outline  : New.
//////////////////////////////////////////////////////////////////
module ITRL78QBV1_CLKBUF (clkin, clkout);
   input clkin;
   output clkout;
   
`ifdef PRIMITIVE_VIRTEX // Virtual Cell for Xilinx Virtex series.
   BUFG gbuf (.I(clkin), .O(clkout));
`else
   assign clkout = clkin;
`endif

endmodule // ITRL78QBV1_CLKBUF

