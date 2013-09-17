/* =================================================================== */
/* [RL78 IECUBE Emulation Macro]                                       */
/*                                                                     */
/* Function     : PullUp Control Unit for FPGA                         */
/* Target System: IO board which has 7 level-shifter devices.          */
/*                                                                     */
/* ------------------------------------------------------------------- */
/* Date     : 2011.02.18                                               */
/* Version  : 1.0.0                                                    */
/* Designer : T.Tsunoda                                                */
/* Note     : modified from puctl6.v                                   */
/* =================================================================== */

module IERL78PUCTL7V1 (
  CLK60MHZ, CPURSOUTB,
  DIN000, DIN001, DIN002, DIN003, DIN004, DIN005, DIN006, DIN007,
  DIN008, DIN009, DIN010, DIN011, DIN012, DIN013, DIN014, DIN015,
  DIN016, DIN017, DIN018, DIN019, DIN020, DIN021,
  DIN024, DIN025, DIN026, DIN027, DIN028, DIN029, DIN030, DIN031,
  DIN100, DIN101, DIN102, DIN103, DIN104, DIN105, DIN106, DIN107,
  DIN108, DIN109, DIN110, DIN111, DIN112, DIN113, DIN114, DIN115,
  DIN116, DIN117, DIN118, DIN119, DIN120, DIN121,
  DIN124, DIN125, DIN126, DIN127, DIN128, DIN129, DIN130, DIN131,
  DIN200, DIN201, DIN202, DIN203, DIN204, DIN205, DIN206, DIN207,
  DIN208, DIN209, DIN210, DIN211, DIN212, DIN213, DIN214, DIN215,
  DIN216, DIN217, DIN218, DIN219, DIN220, DIN221,
  DIN224, DIN225, DIN226, DIN227, DIN228, DIN229, DIN230, DIN231,
  DIN300, DIN301, DIN302, DIN303, DIN304, DIN305, DIN306, DIN307,
  DIN308, DIN309, DIN310, DIN311, DIN312, DIN313, DIN314, DIN315,
  DIN316, DIN317, DIN318, DIN319, DIN320, DIN321,
  DIN324, DIN325, DIN326, DIN327, DIN328, DIN329, DIN330, DIN331,
  DIN400, DIN401, DIN402, DIN403, DIN404, DIN405, DIN406, DIN407,
  DIN408, DIN409, DIN410, DIN411, DIN412, DIN413, DIN414, DIN415,
  DIN416, DIN417, DIN418, DIN419, DIN420, DIN421,
  DIN424, DIN425, DIN426, DIN427, DIN428, DIN429, DIN430, DIN431,
  DIN500, DIN501, DIN502, DIN503, DIN504, DIN505, DIN506, DIN507,
  DIN508, DIN509, DIN510, DIN511, DIN512, DIN513, DIN514, DIN515,
  DIN516, DIN517, DIN518, DIN519, DIN520, DIN521,
  DIN524, DIN525, DIN526, DIN527, DIN528, DIN529, DIN530, DIN531,
  DIN600, DIN601, DIN602, DIN603, DIN604, DIN605, DIN606, DIN607,
  DIN608, DIN609, DIN610, DIN611, DIN612, DIN613, DIN614, DIN615,
  DIN616, DIN617, DIN618, DIN619, DIN620, DIN621,
  DIN624, DIN625, DIN626, DIN627, DIN628, DIN629, DIN630, DIN631,
  PPUP0,  PPUP1,  PPUP2,  PPUP3,  PPUP4,  PPUP5,  PPUP6,  PPUP7,
  PPUP8,  PPUP9,  PPUP10, PPUP11, PPUP12, PPUP13, PPUP14, PPUP15,
  PPUP16, PPUP17, PPUP18, PPUP19, PPUP20, PPUP21,
  PPUP24, PPUP25, PPUP26, PPUP27, PPUP28, PPUP29, PPUP30, PPUP31,
  PUPLE0, PUPLE1, PUPLE2, PUPLE3, PUPLE4, PUPLE5, PUPLE6
);

  input	CLK60MHZ, CPURSOUTB;
  input DIN000, DIN001, DIN002, DIN003, DIN004, DIN005, DIN006, DIN007,
	DIN008, DIN009, DIN010, DIN011, DIN012, DIN013, DIN014, DIN015,
	DIN016, DIN017, DIN018, DIN019, DIN020, DIN021,
	DIN024, DIN025, DIN026, DIN027, DIN028, DIN029, DIN030, DIN031;
  input DIN100, DIN101, DIN102, DIN103, DIN104, DIN105, DIN106, DIN107,
	DIN108, DIN109, DIN110, DIN111, DIN112, DIN113, DIN114, DIN115,
	DIN116, DIN117, DIN118, DIN119, DIN120, DIN121,
	DIN124, DIN125, DIN126, DIN127, DIN128, DIN129, DIN130, DIN131;
  input DIN200, DIN201, DIN202, DIN203, DIN204, DIN205, DIN206, DIN207,
	DIN208, DIN209, DIN210, DIN211, DIN212, DIN213, DIN214, DIN215,
	DIN216, DIN217, DIN218, DIN219, DIN220, DIN221,
	DIN224, DIN225, DIN226, DIN227, DIN228, DIN229, DIN230, DIN231;
  input DIN300, DIN301, DIN302, DIN303, DIN304, DIN305, DIN306, DIN307,
	DIN308, DIN309, DIN310, DIN311, DIN312, DIN313, DIN314, DIN315,
	DIN316, DIN317, DIN318, DIN319, DIN320, DIN321,
	DIN324, DIN325, DIN326, DIN327, DIN328, DIN329, DIN330, DIN331;
  input DIN400, DIN401, DIN402, DIN403, DIN404, DIN405, DIN406, DIN407,
	DIN408, DIN409, DIN410, DIN411, DIN412, DIN413, DIN414, DIN415,
	DIN416, DIN417, DIN418, DIN419, DIN420, DIN421,
	DIN424, DIN425, DIN426, DIN427, DIN428, DIN429, DIN430, DIN431;
  input DIN500, DIN501, DIN502, DIN503, DIN504, DIN505, DIN506, DIN507,
	DIN508, DIN509, DIN510, DIN511, DIN512, DIN513, DIN514, DIN515,
	DIN516, DIN517, DIN518, DIN519, DIN520, DIN521,
	DIN524, DIN525, DIN526, DIN527, DIN528, DIN529, DIN530, DIN531;
  input DIN600, DIN601, DIN602, DIN603, DIN604, DIN605, DIN606, DIN607,
	DIN608, DIN609, DIN610, DIN611, DIN612, DIN613, DIN614, DIN615,
	DIN616, DIN617, DIN618, DIN619, DIN620, DIN621,
	DIN624, DIN625, DIN626, DIN627, DIN628, DIN629, DIN630, DIN631;
  output PPUP0,  PPUP1,  PPUP2,  PPUP3,  PPUP4,  PPUP5,  PPUP6,  PPUP7,
	 PPUP8,  PPUP9,  PPUP10, PPUP11, PPUP12, PPUP13, PPUP14, PPUP15,
	 PPUP16, PPUP17, PPUP18, PPUP19, PPUP20, PPUP21,
	 PPUP24, PPUP25, PPUP26, PPUP27, PPUP28, PPUP29, PPUP30, PPUP31;
  output PUPLE0, PUPLE1, PUPLE2, PUPLE3, PUPLE4, PUPLE5, PUPLE6;


  wire start2;
  wire [29:0] din0, din1, din2, din3, din4, din5, din6;

  assign din0 = {DIN000, DIN001, DIN002, DIN003, DIN004, DIN005, DIN006, DIN007,
		 DIN008, DIN009, DIN010, DIN011, DIN012, DIN013, DIN014, DIN015,
		 DIN016, DIN017, DIN018, DIN019, DIN020, DIN021,
		 DIN024, DIN025, DIN026, DIN027, DIN028, DIN029, DIN030, DIN031};
  assign din1 = {DIN100, DIN101, DIN102, DIN103, DIN104, DIN105, DIN106, DIN107,
		 DIN108, DIN109, DIN110, DIN111, DIN112, DIN113, DIN114, DIN115,
		 DIN116, DIN117, DIN118, DIN119, DIN120, DIN121,
		 DIN124, DIN125, DIN126, DIN127, DIN128, DIN129, DIN130, DIN131};
  assign din2 = {DIN200, DIN201, DIN202, DIN203, DIN204, DIN205, DIN206, DIN207,
		 DIN208, DIN209, DIN210, DIN211, DIN212, DIN213, DIN214, DIN215,
		 DIN216, DIN217, DIN218, DIN219, DIN220, DIN221,
		 DIN224, DIN225, DIN226, DIN227, DIN228, DIN229, DIN230, DIN231};
  assign din3 = {DIN300, DIN301, DIN302, DIN303, DIN304, DIN305, DIN306, DIN307,
		 DIN308, DIN309, DIN310, DIN311, DIN312, DIN313, DIN314, DIN315,
		 DIN316, DIN317, DIN318, DIN319, DIN320, DIN321,
		 DIN324, DIN325, DIN326, DIN327, DIN328, DIN329, DIN330, DIN331};
  assign din4 = {DIN400, DIN401, DIN402, DIN403, DIN404, DIN405, DIN406, DIN407,
		 DIN408, DIN409, DIN410, DIN411, DIN412, DIN413, DIN414, DIN415,
		 DIN416, DIN417, DIN418, DIN419, DIN420, DIN421,
		 DIN424, DIN425, DIN426, DIN427, DIN428, DIN429, DIN430, DIN431};
  assign din5 = {DIN500, DIN501, DIN502, DIN503, DIN504, DIN505, DIN506, DIN507,
		 DIN508, DIN509, DIN510, DIN511, DIN512, DIN513, DIN514, DIN515,
		 DIN516, DIN517, DIN518, DIN519, DIN520, DIN521,
		 DIN524, DIN525, DIN526, DIN527, DIN528, DIN529, DIN530, DIN531};
  assign din6 = {DIN600, DIN601, DIN602, DIN603, DIN604, DIN605, DIN606, DIN607,
		 DIN608, DIN609, DIN610, DIN611, DIN612, DIN613, DIN614, DIN615,
		 DIN616, DIN617, DIN618, DIN619, DIN620, DIN621,
		 DIN624, DIN625, DIN626, DIN627, DIN628, DIN629, DIN630, DIN631};

  // --------------------------------------------------------------
  // clk60mhz   _|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_
  // cpursoutb  ______|~~~~~~~~~~
  // start1     ~~~~~~~|____________
  // sel_p_1    _______|~~~|___________|~~~|___
  // sel_p_2    ___________|~~~|___________|~~~|___
  // sel_din0   ___________|~~~~~~~|_______|~~~~~~~|___
  // sel_din0_f         _______|~~~~~~~|_______|~~~~~~~|________
  // sel_din1   ___________________|~~~~~~~|_______|~~~~~~~|___
  // sel_din1_f         _______________|~~~~~~~|_______|~~~~~~~|_
  // start2     ___________________|~~~|_______________
  // dout	               x===0===x===1===x===0===x===1===x
  // puple0	_________________|~~~|___________|~~~|__
  // puple1	_________________________|~~~|___________|~~~|__
  // --------------------------------------------------------------

  reg start1;
  always @( negedge CLK60MHZ or negedge CPURSOUTB ) begin
    if (!CPURSOUTB)	start1 <= 1'b1;
      else start1 <= 1'b0;
  end


  reg sel_p_1;
  always @( negedge CLK60MHZ or negedge CPURSOUTB ) begin
    if (!CPURSOUTB) begin
      sel_p_1 <= 1'b0;
    end else if (start1 | start2) begin
      sel_p_1 <= 1'b1;
    end else begin
      sel_p_1 <= 1'b0;
    end
  end

  reg sel_p_2;
  always @( negedge CLK60MHZ or negedge CPURSOUTB ) begin
    if (!CPURSOUTB) begin
      sel_p_2 <= 1'b0;
    end else begin
      sel_p_2 <= sel_p_1;
    end
  end

  wire sel_p = sel_p_1 | sel_p_2;

  IERL78PUCTL7V1_SELDIN sunit0 (.clk(CLK60MHZ), .resb(CPURSOUTB), .selp(sel_p),      .sel(sel_din0), .self(sel_din0_f));
  IERL78PUCTL7V1_SELDIN sunit1 (.clk(CLK60MHZ), .resb(CPURSOUTB), .selp(sel_din0_f), .sel(sel_din1), .self(sel_din1_f));
  IERL78PUCTL7V1_SELDIN sunit2 (.clk(CLK60MHZ), .resb(CPURSOUTB), .selp(sel_din1_f), .sel(sel_din2), .self(sel_din2_f));
  IERL78PUCTL7V1_SELDIN sunit3 (.clk(CLK60MHZ), .resb(CPURSOUTB), .selp(sel_din2_f), .sel(sel_din3), .self(sel_din3_f));
  IERL78PUCTL7V1_SELDIN sunit4 (.clk(CLK60MHZ), .resb(CPURSOUTB), .selp(sel_din3_f), .sel(sel_din4), .self(sel_din4_f));
  IERL78PUCTL7V1_SELDIN sunit5 (.clk(CLK60MHZ), .resb(CPURSOUTB), .selp(sel_din4_f), .sel(sel_din5), .self(sel_din5_f));
  IERL78PUCTL7V1_SELDIN sunit6 (.clk(CLK60MHZ), .resb(CPURSOUTB), .selp(sel_din5_f), .sel(sel_din6), .self(sel_din6_f));

  assign start2 = sel_din6 & ~sel_din6_f;

  reg [29:0] dout;
  always @( negedge CLK60MHZ or negedge CPURSOUTB ) begin
    if (!CPURSOUTB) begin
      dout <= 30'b0;
    end else if (sel_din0) begin
      dout <= din0;
    end else if (sel_din1) begin
      dout <= din1;
    end else if (sel_din2) begin
      dout <= din2;
    end else if (sel_din3) begin
      dout <= din3;
    end else if (sel_din4) begin
      dout <= din4;
    end else if (sel_din5) begin
      dout <= din5;
    end else if (sel_din6) begin
      dout <= din6;
    end
  end

  IERL78PUCTL7V1_PUPLE punit0 ( .clk(CLK60MHZ), .resb(CPURSOUTB), .sel(sel_din1), .self(sel_din0_f), .puple(PUPLE0));
  IERL78PUCTL7V1_PUPLE punit1 ( .clk(CLK60MHZ), .resb(CPURSOUTB), .sel(sel_din2), .self(sel_din1_f), .puple(PUPLE1));
  IERL78PUCTL7V1_PUPLE punit2 ( .clk(CLK60MHZ), .resb(CPURSOUTB), .sel(sel_din3), .self(sel_din2_f), .puple(PUPLE2));
  IERL78PUCTL7V1_PUPLE punit3 ( .clk(CLK60MHZ), .resb(CPURSOUTB), .sel(sel_din4), .self(sel_din3_f), .puple(PUPLE3));
  IERL78PUCTL7V1_PUPLE punit4 ( .clk(CLK60MHZ), .resb(CPURSOUTB), .sel(sel_din5), .self(sel_din4_f), .puple(PUPLE4));
  IERL78PUCTL7V1_PUPLE punit5 ( .clk(CLK60MHZ), .resb(CPURSOUTB), .sel(sel_din6), .self(sel_din5_f), .puple(PUPLE5));
  IERL78PUCTL7V1_PUPLE punit6 ( .clk(CLK60MHZ), .resb(CPURSOUTB), .sel(sel_din0), .self(sel_din6_f), .puple(PUPLE6));

  assign {PPUP0,  PPUP1,  PPUP2,  PPUP3,  PPUP4,  PPUP5,  PPUP6,  PPUP7,
          PPUP8,  PPUP9,  PPUP10, PPUP11, PPUP12, PPUP13, PPUP14, PPUP15,
          PPUP16, PPUP17, PPUP18, PPUP19, PPUP20, PPUP21,
          PPUP24, PPUP25, PPUP26, PPUP27, PPUP28, PPUP29, PPUP30, PPUP31} = dout;

endmodule

module IERL78PUCTL7V1_SELDIN ( clk, resb, selp, sel, self );
  input clk, resb, selp;
  output sel, self;

  reg [1:0] selreg;
  always @( negedge clk or negedge resb ) begin
    if (!resb) begin
      selreg <= 2'b00;
    end else begin
      selreg <= {selreg[0], selp};
    end
  end
  wire sel = selreg[0];
  wire self = selreg[1];

endmodule

module IERL78PUCTL7V1_PUPLE ( clk, resb, sel, self, puple );
  input clk, resb, sel, self;
  output puple;

  reg puple;
  always @( posedge clk or negedge resb ) begin
    if (!resb) begin
      puple <= 1'b1;
    end else if (sel) begin
      puple <= 1'b0;
    end else if (self) begin
      puple <= 1'b1;
    end else begin
      puple <= 1'b0; // from release-reset to din
    end
  end

endmodule

