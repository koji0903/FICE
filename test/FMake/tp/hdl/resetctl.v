// =======================================================================================================
// 78K0R IECUBE Reset-Control Unit
//
//
// V100	initial version										T.Tsunoda
// V101 I did a revision to clear the target reset flag of SVMOD at the end of SVMODUSER.	T.Tsunoda
// $Id: resetctl.v,v 1.20 2007-11-13 08:24:14 tsuno3 Exp $
// =======================================================================================================
module RESETCTL (
		ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
		ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
		ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
		ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2,
		ICEDI0,
		ICEWR,
		ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
		ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
		ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
		ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0,
		CLK30MHZ,
		CLK60MHZ,
		SVMODUSER,
		ICESYSRES_B,
		ICECPURES_B,
		PSEUDORES,
		RESET_B,
//		CPURSOUTB,
		ICEMSKPOC,
		ICEMSKTRST,
		ICEMSKICE,
		ICEMSKTRSTFLG,
		PONRESB,
		ICERESB,
		POCRESB,
		TARRESB,
		TARRESB_NORM,
		SYSRSOUTB,
		BRKFAIL14
);


input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28,	// Host I/F Address Bus			( <- eva_pcifg )
	ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,	//
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,	//
	ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,	//
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,	//
	ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,	//
	ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,	//
	ICEIFA3,  ICEIFA2;			//
input	ICEDI0;					// Host I/F Write Data Bus		( <- eva_pcifg )
input	ICEWR;					// Host I/F Write Strobe		( <- eva_pcifg )
output	ICEDO31, ICEDO30, ICEDO29, ICEDO28,	// Host I/F Read Data Bus		( -> eva_pcifg )
	ICEDO27, ICEDO26, ICEDO25, ICEDO24,	//
	ICEDO23, ICEDO22, ICEDO21, ICEDO20,	//
	ICEDO19, ICEDO18, ICEDO17, ICEDO16,	//
	ICEDO15, ICEDO14, ICEDO13, ICEDO12,	//
	ICEDO11, ICEDO10, ICEDO9,  ICEDO8,	//
	ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,	//
	ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0;	//
input	CLK30MHZ;				// 30mhz source clock			( <- terminal )
input	CLK60MHZ;				// system clock				( <- clock )
input	SVMODUSER;				// user svmod				( <- break )
input	ICESYSRES_B;				// power on reset			( <- terminal )
input	ICECPURES_B;				// poc reset				( <- terminal )
input	PSEUDORES;				// pseudo poc reset			( <- pseudoemu )
input	RESET_B;				// target reset				( <- terminal )
// input	CPURSOUTB;			// cpu reset				( <- 1chip )
input	ICEMSKPOC;				// poc reset mask			( <- mask )
input	ICEMSKTRST;				// target reset mask			( <- mask )
input	ICEMSKICE;				// ice(debugger) reset mask		( <- mask )
input	ICEMSKTRSTFLG;				// target reset mask exept svmoduser	( <- mask )
output	PONRESB;				// noise reduced ponreset		( -> clock )
output	ICERESB;				// ice reset				( -> 1chip )
output	POCRESB;				// poc reset to 1chip			( -> 1chip )
output	TARRESB;				// target reset to 1chip		( -> 1chip )
output	TARRESB_NORM;				// noise reduced target reset		( -> ice macro )
output	SYSRSOUTB;				// ice system reset			( -> ice macro )
output	BRKFAIL14;				// power off break			( -> break )


wire [31:2]	iceifa;
wire		reset_cs, ssysrst_cs, scpurst_cs, brkresfl_cs, tarrflclr_cs, pocrflclr_cs;
wire		ponresb, pocresb, tarresb, iceresb_1chip;
wire		pocrflset, pocrflclr;
wire		tarrflset, tarrflclr;

reg [2:0]	icedo;
reg		ssysrst, scpurst;
reg		pocrfl;
reg		tarrfl;


	assign iceifa = {
		ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
		ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
		ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
		ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2
		};

	assign	{ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
		ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
		ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
		ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0} = {29'b0, icedo};

//
// host if
//

	assign	reset_cs      = (iceifa[31:8] == 24'h0801_10) ? 1'b1 : 1'b0;
	assign	ssysrst_cs    = (reset_cs & (iceifa[7:2] == 6'b0000_00)) ? 1'b1 : 1'b0;
	assign	scpurst_cs    = (reset_cs & (iceifa[7:2] == 6'b0000_01)) ? 1'b1 : 1'b0;
	assign	brkresfl_cs   = (reset_cs & (iceifa[7:2] == 6'b0000_10)) ? 1'b1 : 1'b0;
	assign	tarrflclr_cs  = (reset_cs & (iceifa[7:2] == 6'b0000_11)) ? 1'b1 : 1'b0;
	assign	pocrflclr_cs  = (reset_cs & (iceifa[7:2] == 6'b0001_01)) ? 1'b1 : 1'b0;

	always @(ssysrst_cs or scpurst_cs or brkresfl_cs or ssysrst or scpurst or pocrfl or tarrfl) begin
		case ({ssysrst_cs, scpurst_cs, brkresfl_cs})
			3'b100:	icedo = {2'b0, ssysrst};
			3'b010:	icedo = {2'b0, scpurst};
			3'b001:	icedo = {pocrfl, 1'b0, tarrfl};
			default:icedo = 3'b0;
		endcase
	end

//
// [ noise reduce ]
//
	res_noise100ns	noise_pon    (.in(ICESYSRES_B), .out(ponresb), .ck30mhz(CLK30MHZ));
	res_noise100ns	noise_poc    (.in(ICECPURES_B), .out(pocresb), .ck30mhz(CLK30MHZ));
	res_noise100ns	noise_target (.in(RESET_B), .out(tarresb), .ck30mhz(CLK30MHZ));
//
// [ make ice reset ]
//
	always @(negedge ICEWR or negedge ponresb) begin
		if (!ponresb)		ssysrst <= 1'b0; /* initial 0 */
		else if (ssysrst_cs)	ssysrst <= ICEDI0;
	end
	always @(negedge ICEWR or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB)		scpurst <= 1'b1;
		else if (scpurst_cs)	scpurst <= ICEDI0;
	end
	assign	SYSRSOUTB = !ssysrst & ponresb;
	assign	PONRESB = ponresb;
	assign	ICERESB = ~scpurst;
	assign	TARRESB_NORM = tarresb;
//
// [ output to 1chip ]
//
	assign	iceresb_1chip = ICEMSKICE | ICERESB;
	assign	TARRESB = (ICEMSKTRST | tarresb) & iceresb_1chip;
	assign	POCRESB = (ICEMSKPOC | (pocresb & ~PSEUDORES)) & iceresb_1chip;
//
// [ reset control during break ]
//
		reg [2:0] svmoduser_l; // bit0 for metas
		always @(posedge CLK60MHZ or negedge SYSRSOUTB) begin
			if (!SYSRSOUTB)	svmoduser_l <= 1'b0;
			else		svmoduser_l <= {svmoduser_l[1:0], SVMODUSER};
		end

	/* POC Detect */
		/* svmoduser‚Íreset‚Å”ñ“¯Šú‚É‰ðœ‚³‚ê‚é‚Ì‚Å */
		assign	pocrflset = ~pocresb & svmoduser_l[1] & ~ICEMSKPOC;
		assign	pocrflclr = pocrflclr_cs ? ICEWR : !SYSRSOUTB;
		always @(posedge CLK60MHZ or posedge pocrflclr) begin
			if (pocrflclr) pocrfl <= 1'b0;
			else if (pocrflset) pocrfl <= 1'b1;
		end
		assign BRKFAIL14 = pocrfl;

	/* Target-reset Detect */
		assign	tarrflset = ~tarresb & SVMODUSER & ~ICEMSKTRSTFLG;
		wire	clr_svmd = ~svmoduser_l[1] & svmoduser_l[2];
		assign	tarrflclr = (tarrflclr_cs & ICEWR) | !SYSRSOUTB | clr_svmd;
		always @(posedge CLK60MHZ or posedge tarrflclr) begin
			if (tarrflclr) tarrfl <= 1'b0;
			else if (tarrflset) tarrfl <= 1'b1;
		end

	/* peripheral-reset Detect */
//wire		perirflclr_cs;
//wire		perires, perirflset, perirflclr;
//reg		cpursoutb_l1, cpursoutb_l2, perirfl;
//
//		assign	perirflclr_cs = (reset_cs & (iceifa[7:2] == 6'b0001_00)) ? 1'b1 : 1'b0;
//		assign	perires = ~CPURSOUTB & tarresb & pocresb & ~scpurst;
//		assign	perirflset = perires & SVMODUSER;
//		assign	perirflclr = perirflclr_cs ? ICEWR : !SYSRSOUTB;
//		always @( posedge CLK60MHZ or negedge SYSRSOUTB ) begin
//			if (!SYSRSOUTB)	cpursoutb_l1 <= 1'b0;
//			else		cpursoutb_l1 <= CPURSOUTB;
//		end
//		always @( posedge CLK60MHZ or negedge SYSRSOUTB ) begin
//			if (!SYSRSOUTB)	cpursoutb_l2 <= 1'b0;
//			else		cpursoutb_l2 <= cpursoutb_l1;
//		end
//		always @( posedge CLK60MHZ or posedge perirflclr ) begin
//			if (perirflclr)	perirfl <= 1'b0;
//			else if (~cpursoutb_l1 & cpursoutb_l2)
//					perirfl <= perirflset;
//		end
endmodule



module res_noise100ns (in, out, ck30mhz);
	input	in, ck30mhz;
	output	out;
	reg	buf1, buf2, out;

	always @(posedge ck30mhz) begin
		buf1 <= in;
		buf2 <= buf1;
		if (buf1 == in && buf2 == in) begin
			out <= buf2;
		end
	end
endmodule

