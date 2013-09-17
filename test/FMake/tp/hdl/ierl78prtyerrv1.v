/************************************************************************/
/* Date		: 2011/02/09						*/
/* Version	: 100							*/
/* Designer	: Yuuji Ishiguro					*/
/* Note		: 擬似Parity error Emulation				*/
/************************************************************************/
/* Date		: 2011/03/07						*/
/* Version	: 101							*/
/* Designer	: Yuuji Ishiguro					*/
/* Note		: CPURD, SVMOD add.					*/
/************************************************************************/
/* Date		: 2011/03/08						*/
/* Version	: 102							*/
/* Designer	: Yuuji Ishiguro					*/
/* Note		: ICEDOPB bus revision.					*/
/************************************************************************/
/* Date		: 2011/03/22						*/
/* Version	: 103							*/
/* Designer	: Yuuji Ishiguro					*/
/* Note		: address revision.	0400_0000 -> 0401_0000		*/
/************************************************************************/
// $Id$

module IERL78PRTYERRV1 (

		RPERR,
		MA15,     MA14,     MA13,     MA12,     MA11,     MA10,
		MA9,      MA8 ,     MA7,      MA6,      MA5,      MA4,
		MA3,      MA2,      MA1,      MA0,
		ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25,
		ICEIFA24, ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18,
		ICEIFA17, ICEIFA16, ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11,
		ICEIFA10, ICEIFA9,  ICEIFA8,  ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,
		ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0,
		ICEDI15,  ICEDI14,  ICEDI13,  ICEDI12,  ICEDI11,  ICEDI10,  ICEDI9,   ICEDI8,
		ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4,   ICEDI3,   ICEDI2,   ICEDI1,   ICEDI0,
		ICEDOPB31, ICEDOPB30, ICEDOPB29, ICEDOPB28, ICEDOPB27, ICEDOPB26, ICEDOPB25,
		ICEDOPB24, ICEDOPB23, ICEDOPB22, ICEDOPB21, ICEDOPB20, ICEDOPB19, ICEDOPB18,
		ICEDOPB17, ICEDOPB16, ICEDOPB15, ICEDOPB14, ICEDOPB13, ICEDOPB12, ICEDOPB11,
		ICEDOPB10, ICEDOPB9,  ICEDOPB8,  ICEDOPB7,  ICEDOPB6,  ICEDOPB5,  ICEDOPB4,
		ICEDOPB3,  ICEDOPB2,  ICEDOPB1,  ICEDOPB0,
		ICEWR,	  SYSRSOUTB, FCHRAM ,CPUWR , WDOP, SELTAR, SLMEM, GDRAMWR ,CSPDTFLG,
		SELRAMMA, SELDFADMA, CPURD, SVMOD
		);

	output	RPERR;		// Parity error検出信号		(to csc)
	input	SYSRSOUTB ;	// System Reset Signal		( <- resetctl )

	input	MA15;		// memory空間アドレスバス	(from cpu)
	input	MA14;		// memory空間アドレスバス	(from cpu)
	input	MA13;		// memory空間アドレスバス	(from cpu)
	input	MA12;		// memory空間アドレスバス	(from cpu)
	input	MA11;		// memory空間アドレスバス	(from cpu)
	input	MA10;		// memory空間アドレスバス	(from cpu)
	input	MA9;		// memory空間アドレスバス	(from cpu)
	input	MA8;		// memory空間アドレスバス	(from cpu)
	input	MA7;		// memory空間アドレスバス	(from cpu)
	input	MA6;		// memory空間アドレスバス	(from cpu)
	input	MA5;		// memory空間アドレスバス	(from cpu)
	input	MA4;		// memory空間アドレスバス	(from cpu)
	input	MA3;		// memory空間アドレスバス	(from cpu)
	input	MA2;		// memory空間アドレスバス	(from cpu)
	input	MA1;		// memory空間アドレスバス	(from cpu)
	input	MA0;		// memory空間アドレスバス	(from cpu)

	input	FCHRAM;
	input	CPUWR;
	input	WDOP;
	input	SELTAR;
	input	SLMEM;
	input	GDRAMWR;
	input	CSPDTFLG;
	input	SELRAMMA;
	input	SELDFADMA;

	input	CPURD;
	input	SVMOD;

	wire [15:0]	ma ; 

	assign ma = { MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8,  
		      MA7,  MA6,  MA5,  MA4,  MA3,  MA2,  MA1, MA0 } ;

// ------------------------------
// host io
// ------------------------------
input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28,	// Host I/F Address Bus			( <- eva_pcifg )
	ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,	//
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,	//
	ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,	//
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,	//
	ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,	//
	ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,	//
	ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0 ;	//
input	ICEDI15,  ICEDI14,  ICEDI13,  ICEDI12,	// Host I/F Write Data Bus		( <- eva_pcifg )
	ICEDI11,  ICEDI10,  ICEDI9,   ICEDI8,	//
	ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4,	//
	ICEDI3,   ICEDI2,   ICEDI1,   ICEDI0 ;	//
input	ICEWR ;					// Host I/F Write Strobe		( <- eva_pcifg )
output	ICEDOPB31, ICEDOPB30, ICEDOPB29, ICEDOPB28,	// Host I/F Read Data Bus		( -> eva_pcifg )
	ICEDOPB27, ICEDOPB26, ICEDOPB25, ICEDOPB24,	//
	ICEDOPB23, ICEDOPB22, ICEDOPB21, ICEDOPB20,	//
	ICEDOPB19, ICEDOPB18, ICEDOPB17, ICEDOPB16,	//
	ICEDOPB15, ICEDOPB14, ICEDOPB13, ICEDOPB12,	//
	ICEDOPB11, ICEDOPB10, ICEDOPB9,  ICEDOPB8,	//
	ICEDOPB7,  ICEDOPB6,  ICEDOPB5,  ICEDOPB4,	//
	ICEDOPB3,  ICEDOPB2,  ICEDOPB1,  ICEDOPB0 ;	//	

	wire [31:0]	iceifa ; 
	wire [15:0]	icedi ;  

	assign iceifa = {ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26,
			 ICEIFA25, ICEIFA24, ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
			 ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16, ICEIFA15, ICEIFA14,
			 ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
			 ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,  ICEIFA3,  ICEIFA2,
			 ICEIFA1,  ICEIFA0} ;

	assign icedi = { ICEDI15,  ICEDI14,  ICEDI13,  ICEDI12,  ICEDI11,  ICEDI10,  ICEDI9,
			 ICEDI8,   ICEDI7,   ICEDI6,   ICEDI5,   ICEDI4,   ICEDI3,   ICEDI2,
			 ICEDI1,   ICEDI0} ;

//--------------------------------------------
// RAM area Choice
//--------------------------------------------

   	 wire	iramcs0_p ;
	 assign iramcs0_p = SLMEM & ( SELRAMMA & ~SELDFADMA );

//---------------------
// Address Comparison
//---------------------
	wire [31:0]	icedo ;  

	wire prtyeradr_cs = (iceifa[31:0] == 32'h0401_0000);
	reg [15:0] prtyeradr;
	always @(negedge ICEWR or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB) prtyeradr <= 16'h0000;
		else if (prtyeradr_cs) prtyeradr <= icedi[15:0];
	end

	assign	icedo = prtyeradr_cs ? {16'h0000, prtyeradr} : 32'h0000_0000;

	wire prtycmpout = (ma == prtyeradr) & CPURD;
	wire prtyerr_pre = prtycmpout & ~SVMOD;

	assign 	 {ICEDOPB31, ICEDOPB30, ICEDOPB29, ICEDOPB28, ICEDOPB27, ICEDOPB26, ICEDOPB25, ICEDOPB24,
		  ICEDOPB23, ICEDOPB22, ICEDOPB21, ICEDOPB20, ICEDOPB19, ICEDOPB18, ICEDOPB17, ICEDOPB16,
		  ICEDOPB15, ICEDOPB14, ICEDOPB13, ICEDOPB12, ICEDOPB11, ICEDOPB10, ICEDOPB9, ICEDOPB8,
		  ICEDOPB7, ICEDOPB6, ICEDOPB5, ICEDOPB4, ICEDOPB3, ICEDOPB2, ICEDOPB1, ICEDOPB0} = icedo ;

//---------------------
// mask
//---------------------

	reg	hi_mask_p	;	// 偶数番地リード時は RAMQ[17:9] をマスク
	reg	lo_mask_p	;	// 奇数番地リード時は RAMQ[8:0]  をマスク

	wire WEN;
	assign WEN = ~CPUWR ;

	wire BUN;
	assign BUN = iramcs0_p & ~(GDRAMWR | CSPDTFLG) ;

	always @( BUN or WEN or WDOP or MA0 ) begin
	  casex ( {BUN ,WEN ,WDOP ,MA0} ) // synopsys parallel_case
		4'b0_X_X_X : { hi_mask_p, lo_mask_p } = 2'b11 ;
		4'b1_0_X_X : { hi_mask_p, lo_mask_p } = 2'b11 ;
		4'b1_1_1_X : { hi_mask_p, lo_mask_p } = 2'b00 ;
		4'b1_1_0_0 : { hi_mask_p, lo_mask_p } = 2'b10 ;
		4'b1_1_0_1 : { hi_mask_p, lo_mask_p } = 2'b01 ;
	  endcase
	end

	wire	hi_mask		;
	wire	lo_mask		;

	assign	hi_mask = ( SELTAR == 1'b1 ) ? !( WEN ) : hi_mask_p ;
	assign	lo_mask = ( SELTAR == 1'b1 ) ? !( WEN ) : lo_mask_p ;

// ------------------------------
// Parity error Emulation
// ------------------------------

	wire	evnchk_hi	;
	wire	evnchk_lo	;

	assign	evnchk_hi = ( hi_mask == 1'b1 ) ? 1'b0 : prtyerr_pre ;
	assign	evnchk_lo = ( lo_mask == 1'b1 ) ? 1'b0 : prtyerr_pre ;

	assign	RPERR = ( FCHRAM == 1'b1 ) ? 1'b0 : (evnchk_hi | evnchk_lo)  ;

endmodule

