// =======================================================================================================
// Pseudo Emulation unit
//
// ver100	initial version		Y.Tsuchiya
// 
// $Id: pseudoemu.v,v 1.9 2006-02-08 07:30:26 Administrator Exp $
// =======================================================================================================
//

module PSEUDOEMU (
		ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25,
		ICEIFA24, ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18,
		ICEIFA17, ICEIFA16, ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11,
		ICEIFA10, ICEIFA9,  ICEIFA8,  ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,
		ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0,
		ICEDI15,  ICEDI14,  ICEDI13,  ICEDI12,  ICEDI11,  ICEDI10,  ICEDI9,
		ICEDI8,   ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4,   ICEDI3,   ICEDI2,
		ICEDI1,   ICEDI0,
		ICEWR,
		ICEDO31,  ICEDO30,  ICEDO29,  ICEDO28,  ICEDO27,  ICEDO26,  ICEDO25,
		ICEDO24,  ICEDO23,  ICEDO22,  ICEDO21,  ICEDO20,  ICEDO19,  ICEDO18,
		ICEDO17,  ICEDO16,  ICEDO15,  ICEDO14,  ICEDO13,  ICEDO12,  ICEDO11,
		ICEDO10,  ICEDO9,   ICEDO8,   ICEDO7,   ICEDO6,   ICEDO5,   ICEDO4,
		ICEDO3,   ICEDO2,   ICEDO1,   ICEDO0,
		PSEUDOON31, PSEUDOON30, PSEUDOON29, PSEUDOON28, PSEUDOON27, PSEUDOON26, PSEUDOON25,
		PSEUDOON24, PSEUDOON23, PSEUDOON22, PSEUDOON21, PSEUDOON20, PSEUDOON19, PSEUDOON18,
		PSEUDOON17, PSEUDOON16, PSEUDOON15, PSEUDOON14, PSEUDOON13, PSEUDOON12, PSEUDOON11,
		PSEUDOON10, PSEUDOON9,  PSEUDOON8,  PSEUDOON7,  PSEUDOON6,  PSEUDOON5,  PSEUDOON4,
		PSEUDOON3,  PSEUDOON2,  PSEUDOON1,  PSEUDOON0,
		PSEUDORES,
		SYSRSOUTB, SVMOD,
		PSEUDOANI09,  PSEUDOANI08,  PSEUDOANI07,  PSEUDOANI06,  PSEUDOANI05,  PSEUDOANI04,
		PSEUDOANI03,  PSEUDOANI02,  PSEUDOANI01,  PSEUDOANI00,
		PSEUDOANI19,  PSEUDOANI18,  PSEUDOANI17,  PSEUDOANI16,  PSEUDOANI15,  PSEUDOANI14,
		PSEUDOANI13,  PSEUDOANI12,  PSEUDOANI11,  PSEUDOANI10,
		);

// -------------------------------------------------------------------------------------------------------
//                      Port Difinition
// -------------------------------------------------------------------------------------------------------
input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28,	// Host I/F Address Bus			( <- eva_pcifg )
	ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,	//
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,	//
	ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,	//
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,	//
	ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,	//
	ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,	//
	ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0 ;	//
input	ICEDI15,  ICEDI14,  ICEDI13,  ICEDI12, 	// Host I/F Write Data 			( <- eva_pcifg )
	ICEDI11,  ICEDI10,  ICEDI9,   ICEDI8, 	//
	ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4, 	//
	ICEDI3,   ICEDI2,   ICEDI1,   ICEDI0;   //
input	ICEWR ;					// Host I/F Write Strobe		( <- eva_pcifg )
output	ICEDO31,  ICEDO30,  ICEDO29,  ICEDO28,  // Host I/F Read Data Bus		( -> eva_pcifg )
	ICEDO27,  ICEDO26,  ICEDO25,  ICEDO24,	//
	ICEDO23,  ICEDO22,  ICEDO21,  ICEDO20,	//
	ICEDO19,  ICEDO18,  ICEDO17,  ICEDO16,	//
	ICEDO15,  ICEDO14,  ICEDO13,  ICEDO12,	//
	ICEDO11,  ICEDO10,  ICEDO9,   ICEDO8,	//
	ICEDO7,   ICEDO6,   ICEDO5,   ICEDO4,	//
	ICEDO3,   ICEDO2,   ICEDO1,   ICEDO0 ;	//
output	PSEUDOON31, PSEUDOON30, PSEUDOON29, PSEUDOON28,	// PseudoEmulation Status	( -> EVA Core_ )
	PSEUDOON27, PSEUDOON26, PSEUDOON25, PSEUDOON24,	//
	PSEUDOON23, PSEUDOON22, PSEUDOON21, PSEUDOON20,	//
	PSEUDOON19, PSEUDOON18, PSEUDOON17, PSEUDOON16,	//
	PSEUDOON15, PSEUDOON14, PSEUDOON13, PSEUDOON12,	//
	PSEUDOON11, PSEUDOON10, PSEUDOON9,  PSEUDOON8,	//
	PSEUDOON7,  PSEUDOON6,  PSEUDOON5,  PSEUDOON4,	//
	PSEUDOON3,  PSEUDOON2,  PSEUDOON1,  PSEUDOON0 ;	//
input	SYSRSOUTB ;				// System Reset Signal			( <- resetctl )
output	PSEUDORES ;				// PseudoPOC Reset Status Signal	( -> resetctl  )
input	SVMOD ;					// Super-Visor Mode Status		( <- EVA Core_ )
output	PSEUDOANI09,  PSEUDOANI08,  PSEUDOANI07,			// Pseudo Voltage Signal0	( -> EVA Core_ )
	PSEUDOANI06,  PSEUDOANI05,  PSEUDOANI04,			//
	PSEUDOANI03,  PSEUDOANI02,  PSEUDOANI01,  PSEUDOANI00 ;		//
output	PSEUDOANI19,  PSEUDOANI18,  PSEUDOANI17,  			// Pseudo Voltage Signal1	( -> EVA Core_ )
	PSEUDOANI16,  PSEUDOANI15,  PSEUDOANI14,			//
	PSEUDOANI13,  PSEUDOANI12,  PSEUDOANI11,  PSEUDOANI10 ;		//

// -------------------------------------------------------------------------------------------------------
//                      END of Port Difinition
// -------------------------------------------------------------------------------------------------------

	reg [31:0]	pseudoctl ;
	reg		empocctl ;
	reg [9:0]	pseudoani0, pseudoani1 ;
	wire [31:0]	iceifa ; 
	wire 		pseudoctl31_ro, pseudoctl30_ro, pseudoctl29_ro, pseudoctl28_ro, pseudoctl27_ro, pseudoctl26_ro,
			pseudoctl25_ro, pseudoctl24_ro, pseudoctl23_ro, pseudoctl22_ro, pseudoctl21_ro, pseudoctl20_ro,
			pseudoctl19_ro, pseudoctl18_ro, pseudoctl17_ro, pseudoctl16_ro, pseudoctl15_ro, pseudoctl14_ro,
			pseudoctl13_ro, pseudoctl12_ro, pseudoctl11_ro, pseudoctl10_ro, pseudoctl9_ro,  pseudoctl8_ro,
			pseudoctl7_ro,  pseudoctl6_ro,  pseudoctl5_ro,  pseudoctl4_ro,  pseudoctl3_ro,  pseudoctl2_ro,
			pseudoctl1_ro,  pseudoctl0_ro,
			empocctl_ro ;
	wire [9:0]	pseudoani0_ro, pseudoani1_ro ; 
	wire [15:0]	icedi ; 
	wire		pseudoctl31_cs, pseudoctl30_cs, pseudoctl29_cs, pseudoctl28_cs, pseudoctl27_cs, pseudoctl26_cs,
			pseudoctl25_cs, pseudoctl24_cs, pseudoctl23_cs, pseudoctl22_cs, pseudoctl21_cs, pseudoctl20_cs,
			pseudoctl19_cs, pseudoctl18_cs, pseudoctl17_cs, pseudoctl16_cs, pseudoctl15_cs, pseudoctl14_cs,
			pseudoctl13_cs, pseudoctl12_cs, pseudoctl11_cs, pseudoctl10_cs, pseudoctl9_cs,  pseudoctl8_cs,
			pseudoctl7_cs,  pseudoctl6_cs,  pseudoctl5_cs,  pseudoctl4_cs,  pseudoctl3_cs,  pseudoctl2_cs,
			pseudoctl1_cs,  pseudoctl0_cs,
			pseudoctl_cs,
			empocctl_cs, SVMOD,
			pseudoani0_cs, pseudoani1_cs ;

	assign iceifa = {ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26,
			 ICEIFA25, ICEIFA24, ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
			 ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16, ICEIFA15, ICEIFA14,
			 ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
			 ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,  ICEIFA3,  ICEIFA2,
			 ICEIFA1,  ICEIFA0} ;

	assign  { PSEUDOON31,  PSEUDOON30,  PSEUDOON29,  PSEUDOON28,  PSEUDOON27,  PSEUDOON26,
		PSEUDOON25,  PSEUDOON24,  PSEUDOON23,  PSEUDOON22,  PSEUDOON21,  PSEUDOON20,
		PSEUDOON19,  PSEUDOON18,  PSEUDOON17,  PSEUDOON16,  PSEUDOON15,  PSEUDOON14,
		PSEUDOON13,  PSEUDOON12,  PSEUDOON11,  PSEUDOON10,  PSEUDOON9,   PSEUDOON8,
		PSEUDOON7,   PSEUDOON6,   PSEUDOON5,   PSEUDOON4,   PSEUDOON3,   PSEUDOON2,
		PSEUDOON1,   PSEUDOON0 } = pseudoctl;


	assign	{ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
		ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16 } = 16'h0;

	assign	ICEDO15  = pseudoani0_ro[9]  |  pseudoani1_ro[9] ;
	assign	ICEDO14  = pseudoani0_ro[8]  |  pseudoani1_ro[8] ;
	assign	ICEDO13  = pseudoani0_ro[7]  |  pseudoani1_ro[7] ;
	assign	ICEDO12  = pseudoani0_ro[6]  |  pseudoani1_ro[6] ;
	assign	ICEDO11  = pseudoani0_ro[5]  |  pseudoani1_ro[5] ;
	assign	ICEDO10  = pseudoani0_ro[4]  |  pseudoani1_ro[4] ;
	assign	ICEDO9  = pseudoani0_ro[3]  |  pseudoani1_ro[3] ;
	assign	ICEDO8  = pseudoani0_ro[2]  |  pseudoani1_ro[2] ;
	assign	ICEDO7  = pseudoani0_ro[1]  |  pseudoani1_ro[1] ;
	assign	ICEDO6  = pseudoani0_ro[0]  |  pseudoani1_ro[0] ;
	assign	ICEDO5  = 1'b0 ;
	assign	ICEDO4  = 1'b0 ;
	assign	ICEDO3  = 1'b0 ;
	assign	ICEDO2  = 1'b0 ;
	assign	ICEDO1  = 1'b0 ;

	assign	ICEDO0  = pseudoctl31_ro | pseudoctl30_ro | pseudoctl29_ro | pseudoctl28_ro | pseudoctl27_ro | pseudoctl26_ro
			| pseudoctl25_ro | pseudoctl24_ro | pseudoctl23_ro | pseudoctl22_ro | pseudoctl21_ro | pseudoctl20_ro
			| pseudoctl19_ro | pseudoctl18_ro | pseudoctl17_ro | pseudoctl16_ro | pseudoctl15_ro | pseudoctl14_ro
			| pseudoctl13_ro | pseudoctl12_ro | pseudoctl11_ro | pseudoctl10_ro | pseudoctl9_ro  | pseudoctl8_ro
			| pseudoctl7_ro  | pseudoctl6_ro  | pseudoctl5_ro  | pseudoctl4_ro  | pseudoctl3_ro  | pseudoctl2_ro
			| pseudoctl1_ro |  pseudoctl0_ro
			| empocctl_ro ;

	assign  {PSEUDOANI09,   PSEUDOANI08,
		PSEUDOANI07,   PSEUDOANI06,   PSEUDOANI05,   PSEUDOANI04,   PSEUDOANI03,   PSEUDOANI02,
		PSEUDOANI01,   PSEUDOANI00 } = pseudoani0;

	assign  {PSEUDOANI19,   PSEUDOANI18,
		PSEUDOANI17,   PSEUDOANI16,   PSEUDOANI15,   PSEUDOANI14,   PSEUDOANI13,   PSEUDOANI12,
		PSEUDOANI11,   PSEUDOANI10 } = pseudoani1;

	assign icedi = { ICEDI15,  ICEDI14,  ICEDI13,  ICEDI12,  ICEDI11,  ICEDI10,
			 ICEDI9,   ICEDI8,   ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4,
			 ICEDI3,   ICEDI2,   ICEDI1,   ICEDI0 } ;


// ------------------------------
// host io
// ------------------------------
	assign	pseudoctl_cs	= (iceifa[31:8] == 24'h0840_01) ? 1'b1:1'b0;
	assign	pseudoctl0_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0000_0000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl1_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0000_0100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl2_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0000_1000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl3_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0000_1100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl4_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0001_0000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl5_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0001_0100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl6_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0001_1000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl7_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0001_1100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl8_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0010_0000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl9_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0010_0100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl10_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0010_1000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl11_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0010_1100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl12_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0011_0000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl13_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0011_0100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl14_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0011_1000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl15_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0011_1100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl16_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0100_0000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl17_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0100_0100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl18_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0100_1000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl19_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0100_1100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl20_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0101_0000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl21_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0101_0100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl22_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0101_1000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl23_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0101_1100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl24_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0110_0000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl25_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0110_0100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl26_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0110_1000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl27_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0110_1100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl28_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0111_0000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl29_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0111_0100)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl30_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0111_1000)) ? 1'b1 : 1'b0 ;
	assign	pseudoctl31_cs	= (pseudoctl_cs & (iceifa[7:0] == 8'b0111_1100)) ? 1'b1 : 1'b0 ;
	assign	empocctl_cs	= (iceifa[31:0] == 32'h0840_0200) ? 1'b1 : 1'b0 ;
	assign	pseudoani0_cs	= (iceifa[31:0] == 32'h0840_0204) ? 1'b1 : 1'b0 ;			//add 2006.1.30 
	assign	pseudoani1_cs	= (iceifa[31:0] == 32'h0840_0208) ? 1'b1 : 1'b0 ;			//擬似内部ソース電圧


// ---------------------------------------------------------------------------------------------------
//	Pseudo Emulation control register (pseudoctl31-0)
// ---------------------------------------------------------------------------------------------------

	assign	pseudoctl0_ro = pseudoctl0_cs ? pseudoctl[0] : 1'b0 ;
	assign	pseudoctl1_ro = pseudoctl1_cs ? pseudoctl[1] : 1'b0 ;
	assign	pseudoctl2_ro = pseudoctl2_cs ? pseudoctl[2] : 1'b0 ;
	assign	pseudoctl3_ro = pseudoctl3_cs ? pseudoctl[3] : 1'b0 ;
	assign	pseudoctl4_ro = pseudoctl4_cs ? pseudoctl[4] : 1'b0 ;
	assign	pseudoctl5_ro = pseudoctl5_cs ? pseudoctl[5] : 1'b0 ;
	assign	pseudoctl6_ro = pseudoctl6_cs ? pseudoctl[6] : 1'b0 ;
	assign	pseudoctl7_ro = pseudoctl7_cs ? pseudoctl[7] : 1'b0 ;
	assign	pseudoctl8_ro = pseudoctl8_cs ? pseudoctl[8] : 1'b0 ;
	assign	pseudoctl9_ro = pseudoctl9_cs ? pseudoctl[9] : 1'b0 ;
	assign	pseudoctl10_ro = pseudoctl10_cs ? pseudoctl[10] : 1'b0 ;
	assign	pseudoctl11_ro = pseudoctl11_cs ? pseudoctl[11] : 1'b0 ;
	assign	pseudoctl12_ro = pseudoctl12_cs ? pseudoctl[12] : 1'b0 ;
	assign	pseudoctl13_ro = pseudoctl13_cs ? pseudoctl[13] : 1'b0 ;
	assign	pseudoctl14_ro = pseudoctl14_cs ? pseudoctl[14] : 1'b0 ;
	assign	pseudoctl15_ro = pseudoctl15_cs ? pseudoctl[15] : 1'b0 ;
	assign	pseudoctl16_ro = pseudoctl16_cs ? pseudoctl[16] : 1'b0 ;
	assign	pseudoctl17_ro = pseudoctl17_cs ? pseudoctl[17] : 1'b0 ;
	assign	pseudoctl18_ro = pseudoctl18_cs ? pseudoctl[18] : 1'b0 ;
	assign	pseudoctl19_ro = pseudoctl19_cs ? pseudoctl[19] : 1'b0 ;
	assign	pseudoctl20_ro = pseudoctl20_cs ? pseudoctl[20] : 1'b0 ;
	assign	pseudoctl21_ro = pseudoctl21_cs ? pseudoctl[21] : 1'b0 ;
	assign	pseudoctl22_ro = pseudoctl22_cs ? pseudoctl[22] : 1'b0 ;
	assign	pseudoctl23_ro = pseudoctl23_cs ? pseudoctl[23] : 1'b0 ;
	assign	pseudoctl24_ro = pseudoctl24_cs ? pseudoctl[24] : 1'b0 ;
	assign	pseudoctl25_ro = pseudoctl25_cs ? pseudoctl[25] : 1'b0 ;
	assign	pseudoctl26_ro = pseudoctl26_cs ? pseudoctl[26] : 1'b0 ;
	assign	pseudoctl27_ro = pseudoctl27_cs ? pseudoctl[27] : 1'b0 ;
	assign	pseudoctl28_ro = pseudoctl28_cs ? pseudoctl[28] : 1'b0 ;
	assign	pseudoctl29_ro = pseudoctl29_cs ? pseudoctl[29] : 1'b0 ;
	assign	pseudoctl30_ro = pseudoctl30_cs ? pseudoctl[30] : 1'b0 ;
	assign	pseudoctl31_ro = pseudoctl31_cs ? pseudoctl[31] : 1'b0 ;

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[0] <= 1'b0 ;
		else if (pseudoctl0_cs) pseudoctl[0] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[1] <= 1'b0 ;
		else if (pseudoctl1_cs) pseudoctl[1] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[2] <= 1'b0 ;
		else if (pseudoctl2_cs) pseudoctl[2] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[3] <= 1'b0 ;
		else if (pseudoctl3_cs) pseudoctl[3] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[4] <= 1'b0 ;
		else if (pseudoctl4_cs) pseudoctl[4] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[5] <= 1'b0 ;
		else if (pseudoctl5_cs) pseudoctl[5] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[6] <= 1'b0 ;
		else if (pseudoctl6_cs) pseudoctl[6] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[7] <= 1'b0 ;
		else if (pseudoctl7_cs) pseudoctl[7] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[8] <= 1'b0 ;
		else if (pseudoctl8_cs) pseudoctl[8] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[9] <= 1'b0 ;
		else if (pseudoctl9_cs) pseudoctl[9] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[10] <= 1'b0 ;
		else if (pseudoctl10_cs) pseudoctl[10] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[11] <= 1'b0 ;
		else if (pseudoctl11_cs) pseudoctl[11] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[12] <= 1'b0 ;
		else if (pseudoctl12_cs) pseudoctl[12] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[13] <= 1'b0 ;
		else if (pseudoctl13_cs) pseudoctl[13] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[14] <= 1'b0 ;
		else if (pseudoctl14_cs) pseudoctl[14] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[15] <= 1'b0 ;
		else if (pseudoctl15_cs) pseudoctl[15] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[16] <= 1'b0 ;
		else if (pseudoctl16_cs) pseudoctl[16] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[17] <= 1'b0 ;
		else if (pseudoctl17_cs) pseudoctl[17] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[18] <= 1'b0 ;
		else if (pseudoctl18_cs) pseudoctl[18] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[19] <= 1'b0 ;
		else if (pseudoctl19_cs) pseudoctl[19] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[20] <= 1'b0 ;
		else if (pseudoctl20_cs) pseudoctl[20] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[21] <= 1'b0 ;
		else if (pseudoctl21_cs) pseudoctl[21] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[22] <= 1'b0 ;
		else if (pseudoctl22_cs) pseudoctl[22] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[23] <= 1'b0 ;
		else if (pseudoctl23_cs) pseudoctl[23] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[24] <= 1'b0 ;
		else if (pseudoctl24_cs) pseudoctl[24] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[25] <= 1'b0 ;
		else if (pseudoctl25_cs) pseudoctl[25] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[26] <= 1'b0 ;
		else if (pseudoctl26_cs) pseudoctl[26] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[27] <= 1'b0 ;
		else if (pseudoctl27_cs) pseudoctl[27] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[28] <= 1'b0 ;
		else if (pseudoctl28_cs) pseudoctl[28] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[29] <= 1'b0 ;
		else if (pseudoctl29_cs) pseudoctl[29] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[30] <= 1'b0 ;
		else if (pseudoctl30_cs) pseudoctl[30] <= icedi[0] ;
	end

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoctl[31] <= 1'b0 ;
		else if (pseudoctl31_cs) pseudoctl[31] <= icedi[0] ;
	end

// ---------------------------------------------------------------------------------------------------
//	PseudoPOC Reset Signal register (EMPOCCTL)
// ---------------------------------------------------------------------------------------------------

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) empocctl <= 1'b0 ;
//		else if ( empocctl_cs & ~SVMOD ) empocctl <= icedi[0] ;
		else if ( empocctl_cs ) empocctl <= icedi[0] ;
	end

	assign	empocctl_ro = empocctl_cs ? empocctl : 1'b0 ;

// ---------------------------------------------------------------------------------------------------
//	PseudoPOC Reset Status Signal output (PSEUDORES)
// ---------------------------------------------------------------------------------------------------

	assign	PSEUDORES = empocctl & ~SVMOD ;

// ---------------------------------------------------------------------------------------------------
//	Pseudo Voltage Signal register (PSEUDOANI0,1)
// ---------------------------------------------------------------------------------------------------

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoani0 <= 10'h66 ;
		else if ( pseudoani0_cs ) pseudoani0 <= icedi[15:6] ;
	end

	assign	pseudoani0_ro = pseudoani0_cs ? pseudoani0 : 1'b0 ;

	always @( negedge ICEWR or negedge SYSRSOUTB ) begin
		if ( !SYSRSOUTB ) pseudoani1 <= 10'hF5 ;
		else if ( pseudoani1_cs ) pseudoani1 <= icedi[15:6] ;
	end

	assign	pseudoani1_ro = pseudoani1_cs ? pseudoani1 : 1'b0 ;


endmodule

