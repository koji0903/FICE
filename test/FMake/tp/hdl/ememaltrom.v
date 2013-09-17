//------------------------------------------------------------------------------------------------//
// ALTROM Module (24Kbyte)                                                                        //
//                                                                                                //
// 2006.9.5 ememaltrom.v taketoshi.ide@necel                                                      //
//------------------------------------------------------------------------------------------------//
//$Id: ememaltrom.v,v 1.7 2009-03-03 04:21:14 tsuno3 Exp $
module ALTROM_REG24K (cpu_ad, cpu_do, cpu_di, cpu_en, cpu_wr, baseck, 
			ice_ad, ice_do, ice_di, ice_en, ice_wr, ck60mhz, cpuresetb, sysrsoutb);
	input	[17:0]	cpu_ad, ice_ad;
	output	[31:0]	cpu_do, ice_do;
	input	[31:0]	cpu_di, ice_di;
	input		cpu_en, cpu_wr, baseck, ice_en, ice_wr, ck60mhz, cpuresetb, sysrsoutb;

	// Area Select Flag
	wire	cpu_flag = !cpu_ad[17] & !cpu_ad[16] & !cpu_ad[15] & !cpu_ad[14] & !cpu_ad[13];
	wire	ice_flag = !ice_ad[17] & !ice_ad[16] & !ice_ad[15] & !ice_ad[14] & !ice_ad[13];

	// CPU Access Enable
	wire	enc0  = cpu_en & cpu_flag & !cpu_ad[12] & !cpu_ad[11] & !cpu_ad[10] & !cpu_ad[9];
	wire	enc1  = cpu_en & cpu_flag & !cpu_ad[12] & !cpu_ad[11] & !cpu_ad[10] &  cpu_ad[9];
	wire	enc2  = cpu_en & cpu_flag & !cpu_ad[12] & !cpu_ad[11] &  cpu_ad[10] & !cpu_ad[9];
	wire	enc3  = cpu_en & cpu_flag & !cpu_ad[12] & !cpu_ad[11] &  cpu_ad[10] &  cpu_ad[9];
	wire	enc4  = cpu_en & cpu_flag & !cpu_ad[12] &  cpu_ad[11] & !cpu_ad[10] & !cpu_ad[9];
	wire	enc5  = cpu_en & cpu_flag & !cpu_ad[12] &  cpu_ad[11] & !cpu_ad[10] &  cpu_ad[9];
	wire	enc6  = cpu_en & cpu_flag & !cpu_ad[12] &  cpu_ad[11] &  cpu_ad[10] & !cpu_ad[9];
	wire	enc7  = cpu_en & cpu_flag & !cpu_ad[12] &  cpu_ad[11] &  cpu_ad[10] &  cpu_ad[9];
	wire	enc8  = cpu_en & cpu_flag &  cpu_ad[12] & !cpu_ad[11] & !cpu_ad[10] & !cpu_ad[9];
	wire	enc9  = cpu_en & cpu_flag &  cpu_ad[12] & !cpu_ad[11] & !cpu_ad[10] &  cpu_ad[9];
	wire	enc10 = cpu_en & cpu_flag &  cpu_ad[12] & !cpu_ad[11] &  cpu_ad[10] & !cpu_ad[9];
	wire	enc11 = cpu_en & cpu_flag &  cpu_ad[12] & !cpu_ad[11] &  cpu_ad[10] &  cpu_ad[9];

	// ICE(HOST) Access Enable
	wire	eni0  = ice_en & ice_flag & !ice_ad[12] & !ice_ad[11] & !ice_ad[10] & !ice_ad[9];
	wire	eni1  = ice_en & ice_flag & !ice_ad[12] & !ice_ad[11] & !ice_ad[10] &  ice_ad[9];
	wire	eni2  = ice_en & ice_flag & !ice_ad[12] & !ice_ad[11] &  ice_ad[10] & !ice_ad[9];
	wire	eni3  = ice_en & ice_flag & !ice_ad[12] & !ice_ad[11] &  ice_ad[10] &  ice_ad[9];
	wire	eni4  = ice_en & ice_flag & !ice_ad[12] &  ice_ad[11] & !ice_ad[10] & !ice_ad[9];
	wire	eni5  = ice_en & ice_flag & !ice_ad[12] &  ice_ad[11] & !ice_ad[10] &  ice_ad[9];
	wire	eni6  = ice_en & ice_flag & !ice_ad[12] &  ice_ad[11] &  ice_ad[10] & !ice_ad[9];
	wire	eni7  = ice_en & ice_flag & !ice_ad[12] &  ice_ad[11] &  ice_ad[10] &  ice_ad[9];
	wire	eni8  = ice_en & ice_flag &  ice_ad[12] & !ice_ad[11] & !ice_ad[10] & !ice_ad[9];
	wire	eni9  = ice_en & ice_flag &  ice_ad[12] & !ice_ad[11] & !ice_ad[10] &  ice_ad[9];
	wire	eni10 = ice_en & ice_flag &  ice_ad[12] & !ice_ad[11] &  ice_ad[10] & !ice_ad[9];
	wire	eni11 = ice_en & ice_flag &  ice_ad[12] & !ice_ad[11] &  ice_ad[10] &  ice_ad[9];

	wire	[31:0]	cpu_do0, cpu_do1, cpu_do2, cpu_do3, cpu_do4, cpu_do5,
	                cpu_do6, cpu_do7, cpu_do8, cpu_do9, cpu_do10, cpu_do11;

	wire	[31:0]	ice_do0, ice_do1, ice_do2, ice_do3, ice_do4, ice_do5,
	                ice_do6, ice_do7, ice_do8, ice_do9, ice_do10, ice_do11;

	reg 	denc0, denc1, denc2, denc3, denc4, denc5, denc6, denc7, denc8, denc9, denc10, denc11;
	reg 	deni0, deni1, deni2, deni3, deni4, deni5, deni6, deni7, deni8, deni9, deni10, deni11;

	// CPU Access Data Enable
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc0 <= 1'b0;
		else denc0 <= enc0;
	end
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc1 <= 1'b0;
		else denc1 <= enc1;
	end
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc2 <= 1'b0;
		else denc2 <= enc2;
	end
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc3 <= 1'b0;
		else denc3 <= enc3;
	end
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc4 <= 1'b0;
		else denc4 <= enc4;
	end
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc5 <= 1'b0;
		else denc5 <= enc5;
	end
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc6 <= 1'b0;
		else denc6 <= enc6;
	end
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc7 <= 1'b0;
		else denc7 <= enc7;
	end
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc8 <= 1'b0;
		else denc8 <= enc8;
	end
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc9 <= 1'b0;
		else denc9 <= enc9;
	end
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc10 <= 1'b0;
		else denc10 <= enc10;
	end
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) denc11 <= 1'b0;
		else denc11 <= enc11;
	end

	// ICE(HOST) Access Data Enable
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni0 <= 1'b0;
		else deni0 <= eni0;
	end
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni1 <= 1'b0;
		else deni1 <= eni1;
	end
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni2 <= 1'b0;
		else deni2 <= eni2;
	end
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni3 <= 1'b0;
		else deni3 <= eni3;
	end
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni4 <= 1'b0;
		else deni4 <= eni4;
	end
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni5 <= 1'b0;
		else deni5 <= eni5;
	end
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni6 <= 1'b0;
		else deni6 <= eni6;
	end
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni7 <= 1'b0;
		else deni7 <= eni7;
	end
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni8 <= 1'b0;
		else deni8 <= eni8;
	end
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni9 <= 1'b0;
		else deni9 <= eni9;
	end
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni10 <= 1'b0;
		else deni10 <= eni10;
	end
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) deni11 <= 1'b0;
		else deni11 <= eni11;
	end

	// CPU Data Bus OutPut Select
	assign 	cpu_do = (cpu_do0 & {32{denc0}}) | (cpu_do1 & {32{denc1}}) | (cpu_do2 & {32{denc2}}) |
	                 (cpu_do3 & {32{denc3}}) | (cpu_do4 & {32{denc4}}) | (cpu_do5 & {32{denc5}}) |
	                 (cpu_do6 & {32{denc6}}) | (cpu_do7 & {32{denc7}}) | (cpu_do8 & {32{denc8}}) |
	                 (cpu_do9 & {32{denc9}}) | (cpu_do10 & {32{denc10}}) | (cpu_do11 & {32{denc11}});

	// ICE(HOST) Data Bus OutPut Select
	assign 	ice_do = (ice_do0 & {32{deni0}}) | (ice_do1 & {32{deni1}}) | (ice_do2 & {32{deni2}}) |
	                 (ice_do3 & {32{deni3}}) | (ice_do4 & {32{deni4}}) | (ice_do5 & {32{deni5}}) |
	                 (ice_do6 & {32{deni6}}) | (ice_do7 & {32{deni7}}) | (ice_do8 & {32{deni8}}) |
	                 (ice_do9 & {32{deni9}}) | (ice_do10 & {32{deni10}}) | (ice_do11 & {32{deni11}});

	RAMB16_S36_S36 ram0 (.DOA(cpu_do0), .DOPA(), .DOB(ice_do0), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc0), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni0), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S36_S36 ram1 (.DOA(cpu_do1), .DOPA(), .DOB(ice_do1), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc1), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni1), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S36_S36 ram2 (.DOA(cpu_do2), .DOPA(), .DOB(ice_do2), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc2), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni2), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S36_S36_DUMMY ram3 (.DOA(cpu_do3), .DOPA(), .DOB(ice_do3), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc3), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni3), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S36_S36_DUMMY ram4 (.DOA(cpu_do4), .DOPA(), .DOB(ice_do4), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc4), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni4), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S36_S36_DUMMY ram5 (.DOA(cpu_do5), .DOPA(), .DOB(ice_do5), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc5), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni5), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S36_S36_DUMMY ram6 (.DOA(cpu_do6), .DOPA(), .DOB(ice_do6), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc6), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni6), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S36_S36_DUMMY ram7 (.DOA(cpu_do7), .DOPA(), .DOB(ice_do7), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc7), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni7), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S36_S36 ram8 (.DOA(cpu_do8), .DOPA(), .DOB(ice_do8), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc8), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni8), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S36_S36_DUMMY ram9 (.DOA(cpu_do9), .DOPA(), .DOB(ice_do9), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc9), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni9), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S36_S36_DUMMY ram10 (.DOA(cpu_do10), .DOPA(), .DOB(ice_do10), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc10), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni10), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S36_S36 ram11 (.DOA(cpu_do11), .DOPA(), .DOB(ice_do11), .DOPB(),
		.ADDRA(cpu_ad[8:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(4'b0),
		.ENA(enc11), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[8:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(4'b0),
		.ENB(eni11), .SSRB(1'b0), .WEB(ice_wr)
		);
endmodule

module RAMB16_S36_S36_DUMMY (DOA, DOB, DOPA, DOPB, ADDRA, ADDRB, CLKA, CLKB, DIA, DIB, DIPA, DIPB, ENA, ENB, SSRA, SSRB, WEA, WEB);

    output [31:0] DOA;
    output [3:0] DOPA;

    input [8:0] ADDRA;
    input [31:0] DIA;
    input [3:0] DIPA;
    input ENA, CLKA, WEA, SSRA;

    output [31:0] DOB;
    output [3:0] DOPB;

    input [8:0] ADDRB;
    input [31:0] DIB;
    input [3:0] DIPB;
    input ENB, CLKB, WEB, SSRB;

    assign DOA = 32'b0;
    assign DOPA = 4'b0;
    assign DOB = 32'b0;
    assign DOPB = 4'b0;
   
endmodule // RAMB16_S36_S36_DUMMY
