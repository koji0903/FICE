/************************************************************************/
/* Date		: 2009/11/16						*/
/* Version	: 100							*/
/* Designer	: T.Tsunoda						*/
/* Note		: SS3rd用WDT内蔵発振器のICE用EmulationMacro.		*/
/************************************************************************/
/* Date		: 2010/04/15						*/
/* Version	: 101							*/
/* Designer	: T.Tsunoda						*/
/* Note		: ・Macro名を変更。(ROSC15KHZ -> QAHIOS1BN15KV1_ICE)	*/
/*		: ・端子追加。(置き換え元のMacroと端子情報を合せる目的	*/
/*		:   で、置き換え元にあって、このMacroでは使わない端子を	*/
/*		:   全て持たせた。(Open or 端子処理)			*/
/************************************************************************/
// $Id$

module QAHIOS1BN15KV1_ICE (
	LOSCSTPZ, LOSCOUT,
	CLK30MHZ, PONRESB, CPUPRCLK3, CPURCLK3,
	FRSEL0, FRSEL1, FRSEL2, FRSEL3, FRSEL4, LOSCTEST
);
	input	LOSCSTPZ;	// 発振許可信号(WDT用Clock停止信号)	(from CSC)
	output	LOSCOUT;	// 発振出力(WDT用Clock)			(to CSC)
	/*--------------*/
	/* ICE用I/F	*/
	/*--------------*/
	input	CLK30MHZ;	// ICE用30MHz固定Clock.			(from Board)
	input	PONRESB;	// Power-ON Reset信号			(from reset block)
	output	CPUPRCLK3;	// Clock Blockに渡すWDT用Clock.		(to clock block)
	input	CPURCLK3;	// Clock BlockからもらうWDT用Clock.	(from clock block)
	/*----------------------*/
	/* 入力のみ(未使用端子)	*/
	/*----------------------*/
	input	FRSEL0;		// 発振周波数のTrimming制御		(from cibc)
	input	FRSEL1;		// 発振周波数のTrimming制御		(from cibc)
	input	FRSEL2;		// 発振周波数のTrimming制御		(from cibc)
	input	FRSEL3;		// 発振周波数のTrimming制御		(from cibc)
	input	FRSEL4;		// 発振周波数のTrimming制御		(from cibc)
	input	LOSCTEST;	// 周波数テスト信号(分周前信号出力)	(from csc)


	// Clockブロックに渡すWDT用Clockの元Clock
	//
	CLK15KHZ clk15k (
		.CLK30MHZ(CLK30MHZ),
		.PONRESB(PONRESB),
		.CPUPRCLK3(CPUPRCLK3)
	);

	// CSCに渡すWDT用Clock
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

