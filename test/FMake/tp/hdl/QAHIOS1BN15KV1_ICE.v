/************************************************************************/
/* Date		: 2009/11/16						*/
/* Version	: 100							*/
/* Designer	: T.Tsunoda						*/
/* Note		: SS3rd$BMQ(BWDT$BFbB"H/?64o$N(BICE$BMQ(BEmulationMacro.		*/
/************************************************************************/
/* Date		: 2010/04/15						*/
/* Version	: 101							*/
/* Designer	: T.Tsunoda						*/
/* Note		: $B!&(BMacro$BL>$rJQ99!#(B(ROSC15KHZ -> QAHIOS1BN15KV1_ICE)	*/
/*		: $B!&C<;RDI2C!#(B($BCV$-49$(85$N(BMacro$B$HC<;R>pJs$r9g$;$kL\E*(B	*/
/*		:   $B$G!"CV$-49$(85$K$"$C$F!"$3$N(BMacro$B$G$O;H$o$J$$C<;R$r(B	*/
/*		:   $BA4$F;}$?$;$?!#(B(Open or $BC<;R=hM}(B)			*/
/************************************************************************/
// $Id$

module QAHIOS1BN15KV1_ICE (
	LOSCSTPZ, LOSCOUT,
	CLK30MHZ, PONRESB, CPUPRCLK3, CPURCLK3,
	FRSEL0, FRSEL1, FRSEL2, FRSEL3, FRSEL4, LOSCTEST
);
	input	LOSCSTPZ;	// $BH/?65v2D?.9f(B(WDT$BMQ(BClock$BDd;_?.9f(B)	(from CSC)
	output	LOSCOUT;	// $BH/?6=PNO(B(WDT$BMQ(BClock)			(to CSC)
	/*--------------*/
	/* ICE$BMQ(BI/F	*/
	/*--------------*/
	input	CLK30MHZ;	// ICE$BMQ(B30MHz$B8GDj(BClock.			(from Board)
	input	PONRESB;	// Power-ON Reset$B?.9f(B			(from reset block)
	output	CPUPRCLK3;	// Clock Block$B$KEO$9(BWDT$BMQ(BClock.		(to clock block)
	input	CPURCLK3;	// Clock Block$B$+$i$b$i$&(BWDT$BMQ(BClock.	(from clock block)
	/*----------------------*/
	/* $BF~NO$N$_(B($BL$;HMQC<;R(B)	*/
	/*----------------------*/
	input	FRSEL0;		// $BH/?6<~GH?t$N(BTrimming$B@)8f(B		(from cibc)
	input	FRSEL1;		// $BH/?6<~GH?t$N(BTrimming$B@)8f(B		(from cibc)
	input	FRSEL2;		// $BH/?6<~GH?t$N(BTrimming$B@)8f(B		(from cibc)
	input	FRSEL3;		// $BH/?6<~GH?t$N(BTrimming$B@)8f(B		(from cibc)
	input	FRSEL4;		// $BH/?6<~GH?t$N(BTrimming$B@)8f(B		(from cibc)
	input	LOSCTEST;	// $B<~GH?t%F%9%H?.9f(B($BJ,<~A0?.9f=PNO(B)	(from csc)


	// Clock$B%V%m%C%/$KEO$9(BWDT$BMQ(BClock$B$N85(BClock
	//
	CLK15KHZ clk15k (
		.CLK30MHZ(CLK30MHZ),
		.PONRESB(PONRESB),
		.CPUPRCLK3(CPUPRCLK3)
	);

	// CSC$B$KEO$9(BWDT$BMQ(BClock
	//
	reg [1:0] r15kstpz_l;
	always @(negedge CPURCLK3 or negedge PONRESB ) begin
		if (!PONRESB)
			r15kstpz_l <= 2'b00;
		else	r15kstpz_l <= {r15kstpz_l[0], LOSCSTPZ};
	end
	assign	LOSCOUT = LOSCSTPZ & r15kstpz_l[1] & CPURCLK3;

endmodule

module	CLK15KHZ ( CLK30MHZ, PONRESB, CPUPRCLK3 );
	input	CLK30MHZ, PONRESB;
	output	CPUPRCLK3;


	reg		CLK15K;
	reg [10:0]	count;
	always @(posedge CLK30MHZ or negedge PONRESB) begin
		if (!PONRESB) begin
			CLK15K <= 1'b0;
			count <= 11'h7cf;
		end
		else if (count == 11'h3e8) begin
			CLK15K <= 1'b1;
			count <= count -1;
		end
		else if (count == 11'h000) begin
			CLK15K <= 1'b0;
			count <= 11'h7cf;
		end
		else	count <= count - 1;
	end
	wire	CPUPRCLK3 = CLK15K;

endmodule

