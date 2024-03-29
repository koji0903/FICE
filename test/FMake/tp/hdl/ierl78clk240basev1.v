/* ================================================================================================= */
/* [RL78 IECUBE Emulation Macro]                                                                     */
/*                                                                                                   */
/* Function : 240MHZ clock oscillator                                                                */
/*                                                                                                   */
/* ------------------------------------------------------------------------------------------------- */
/* Date     : 2011.02.21                                                                             */
/* Version  : 1.0.0                                                                                  */
/* Designer : T.Tsunoda                                                                              */
/* Note     : New                                                                                    */
/* ------------------------------------------------------------------------------------------------- */
/* Date     : 2011.03.02                                                                             */
/* Version  : 1.0.1                                                                                  */
/* Designer : T.Tsunoda                                                                              */
/* Note     : Added CLK120M and change macro name (IERL78CLK240MV1 -> IERL78CLK240BASEV1             */
// ------------------------------------------------------------------------------------------------- */

module IERL78CLK240BASEV1 (
  PONRESB, CLK60MHZ, CLK60MHZLOCK, CLK240M, LOCK240FAIL, CLK120M
);

  input PONRESB, CLK60MHZ, CLK60MHZLOCK;
  output CLK240M, LOCK240FAIL, CLK120M;


  /*----------------------------------------------------------------------*/
  /* DCMのReset解除をCLKIN供給から数Clock遅らせる処理を行う(DCMの仕様を守る)。   */
  /* また,CLKINに供給するClock自体が安定していることも考慮するため,              */
  /* CLK60MHZLOCK信号を使用して,CLKINの安定供給後4ClockまってResetを解除する。  */
  /*----------------------------------------------------------------------*/
  wire rst240m;
  wire lock240;

  wire rst240mfb = !PONRESB | rst240m;
  reg lock240pos;
  always @(posedge lock240 or posedge rst240mfb) begin
    if (rst240mfb) begin
      lock240pos <= 1'b0;
    end else begin
      lock240pos <= 1'b1;
    end
  end

  reg lock240posneg;
  always @(negedge lock240 or posedge rst240mfb) begin
    if (rst240mfb) begin
      lock240posneg <= 1'b0;
    end else begin
      lock240posneg <= lock240pos;
    end
  end

  reg LOCK240FAIL;
  always @(posedge lock240posneg or negedge PONRESB) begin
    if (!PONRESB) begin
      LOCK240FAIL <= 1'b0;
    end else begin
      LOCK240FAIL <= 1'b1;
    end
  end

  wire srcrst240 = PONRESB & CLK60MHZLOCK;
  reg [3:0] rst240msrc;
  always @(posedge CLK60MHZ or negedge srcrst240) begin
    if (!srcrst240) begin
      rst240msrc <= 4'hf;
    end else if (CLK60MHZLOCK) begin
      rst240msrc <= {rst240msrc[2:0], lock240posneg};
    end
  end

  // Reset解除は4Clock遅らせResetに入れる時は直に入れる。
  assign rst240m = |rst240msrc;

  IERL78CLK240BASEV1_DCM240MHZ dcm240m (
    .CLKIN_IN(CLK60MHZ), 
    .RST_IN(rst240m),
    .CLKFX_OUT(CLK240M), 
    .LOCKED_OUT(lock240)
  );

  reg CLK120MP;
  always @(posedge CLK240M or negedge PONRESB) begin
    if (!PONRESB) begin
      CLK120MP <= 1'b0;
    end else begin
      CLK120MP <= ~CLK120MP;
    end
  end

  BUFG IERL78CLK240BASEV1_BUFG120 (
    .I(CLK120MP), .O(CLK120M)
  );

endmodule


////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 11.3
//  \   \         Application : xaw2verilog
//  /   /         Filename : DCM240MHZ.v
// /___/   /\     Timestamp : 06/17/2010 19:42:38
// \   \  /  \ 
//  \___\/\___\ 
//
//Design Name: DCM240MHZ
//Device: xc4vlx80-11ff1148
//
// Module DCM240MHZ
// Generated by Xilinx Architecture Wizard
// Written for synthesis tool: Synplify
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.048 UI
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.200 ns

module IERL78CLK240BASEV1_DCM240MHZ(CLKIN_IN, 
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
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 4;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 16.667;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "HIGH";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
endmodule

