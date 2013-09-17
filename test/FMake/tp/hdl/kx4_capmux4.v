
// [NEC Electronics Group CONFIDENTIAL]
// (C) Copyright NEC Electronics Corporation 2009
// All Rights Reserved. Do not duplicate without prior written
// consent of NEC Electronics Corporation.
//
// Macro Name      : KX4_CAPMUX4
// Version         : 1.00
// Date            : 2010.06.24
// Author          : Masaki.Ouchiyama
// History         : 0.00      2010/06/24 DF1
//		   : 0.01      2010/06/25 DF1
//		   : 0.02      2010/07/02 DF2
//		   : 0.03      2010/07/09 for DF2.1
//		   : 0.04      2010/08/26 for DF4.51 ram ext del
//		   :		del BBRPERR



module KX4_CAPMUX4 (
	 TTRG2
	,INTRTC
	,INTRTDISL ,INTRTDISR

	,BBCLKR
	,BBCLKM

//	,BBRPERR
	,BBREQPCLK
	,BBCKSELR
	,BBPRDATA15
	,BBPRDATA14
	,BBPRDATA13
	,BBPRDATA12
	,BBPRDATA11
	,BBPRDATA10
	,BBPRDATA9
	,BBPRDATA8
	,BBPRDATA7
	,BBPRDATA6
	,BBPRDATA5
	,BBPRDATA4
	,BBPRDATA3
	,BBPRDATA2
	,BBPRDATA1
	,BBPRDATA0
	,BBWAITMEM
	,BBWAIT56
	,BBINT0
	,BBINT1
	,BBINT2
	,BBINT3
	,BBINT4
	,BBINT5
	,BBINT6
	,BBINT7
	,BBINT8
	,BBINT9
	,BBINT10
	,BBINT11
	,BBINT12
	,BBINT13
	,BBMODE
	,BBSCANOUT
	,ADTRIG0
//	,ADTRIG1
	,FRQ4EN
	,BBCKSELM
	,BBHIOON
	,BBREGCTL

/*	,BBCLKRT*/	,BBCLKRL	,BBCLKRR	// ,BBCLKRD
/*	,BBCLKMT*/	,BBCLKML	,BBCLKMR	// ,BBCLKMD
//	,		BBRPERRL	,BBRPERRR		
/*	,BBREQPCLKT*/	,BBREQPCLKL	,BBREQPCLKR	// ,BBREQPCLKD
/*	,BBCKSELRT*/	,BBCKSELRL	,BBCKSELRR	// ,BBCKSELRD
/*	,BBPRDATA15T*/	,BBPRDATA15L	,BBPRDATA15R	// ,BBPRDATA15D
/*	,BBPRDATA14T*/	,BBPRDATA14L	,BBPRDATA14R	// ,BBPRDATA14D
/*	,BBPRDATA13T*/	,BBPRDATA13L	,BBPRDATA13R	// ,BBPRDATA13D
/*	,BBPRDATA12T*/	,BBPRDATA12L	,BBPRDATA12R	// ,BBPRDATA12D
/*	,BBPRDATA11T*/	,BBPRDATA11L	,BBPRDATA11R	// ,BBPRDATA11D
/*	,BBPRDATA10T*/	,BBPRDATA10L	,BBPRDATA10R	// ,BBPRDATA10D
/*	,BBPRDATA9T*/	,BBPRDATA9L	,BBPRDATA9R	// ,BBPRDATA9D
/*	,BBPRDATA8T*/	,BBPRDATA8L	,BBPRDATA8R	// ,BBPRDATA8D
/*	,BBPRDATA7T*/	,BBPRDATA7L	,BBPRDATA7R	// ,BBPRDATA7D
/*	,BBPRDATA6T*/	,BBPRDATA6L	,BBPRDATA6R	// ,BBPRDATA6D
/*	,BBPRDATA5T*/	,BBPRDATA5L	,BBPRDATA5R	// ,BBPRDATA5D
/*	,BBPRDATA4T*/	,BBPRDATA4L	,BBPRDATA4R	// ,BBPRDATA4D
/*	,BBPRDATA3T*/	,BBPRDATA3L	,BBPRDATA3R	// ,BBPRDATA3D
/*	,BBPRDATA2T*/	,BBPRDATA2L	,BBPRDATA2R	// ,BBPRDATA2D
/*	,BBPRDATA1T*/	,BBPRDATA1L	,BBPRDATA1R	// ,BBPRDATA1D
/*	,BBPRDATA0T*/	,BBPRDATA0L	,BBPRDATA0R	// ,BBPRDATA0D
/*	,BBWAITMEMT*/	,BBWAITMEML	,BBWAITMEMR	// ,BBWAITMEMD
/*	,BBWAIT56T*/	,BBWAIT56L	,BBWAIT56R	// ,BBWAIT56D
	,		 BBINT0L	,BBINT0R		
	,		 BBINT1L	,BBINT1R	
	,		 BBINT2L	,BBINT2R	
	,		 BBINT3L	,BBINT3R	
	,		 BBINT4L	,BBINT4R	
	,		 BBINT5L	,BBINT5R	
	,		 BBINT6L	,BBINT6R	
	,		 BBINT7L	,BBINT7R	
	,		 BBINT8L	,BBINT8R	
/*	,BBINT9T*/	,BBINT9L	,BBINT9R	// ,BBINT9D
/*	,BBINT10T*/	,BBINT10L	,BBINT10R	// ,BBINT10D
/*	,BBINT11T*/	,BBINT11L	,BBINT11R	// ,BBINT11D
/*	,BBINT12T*/	,BBINT12L	,BBINT12R	// ,BBINT12D
/*	,BBINT13T*/	,BBINT13L	,BBINT13R	// ,BBINT13D
/*	,BBMODET*/	,BBMODEL	,BBMODER	// ,BBMODED
/*	,BBSCANOUTT*/	,BBSCANOUTL	,BBSCANOUTR	// ,BBSCANOUTD
/*	,ADTRIG0T*/	,ADTRIG0L	,ADTRIG0R	// ,ADTRIG0D
	,		 ADTRIG1L	,ADTRIG1R	
/*	,FRQ4ENT*/	,FRQ4ENL	,FRQ4ENR	// ,FRQ4END
/*	,BBCKSELMT*/	,BBCKSELML	,BBCKSELMR	// ,BBCKSELMD
/*	,BBHIOONT*/	,BBHIOONL	,BBHIOONR	// ,BBHIOOND
/*	,BBREGCTLT*/	,BBREGCTLL	,BBREGCTLR	// ,BBREGCTLD
);

output	TTRG2 ;
input	INTRTC ;
input	INTRTDISL ,INTRTDISR ;

output	BBCLKR ;
output	BBCLKM ;

//output	BBRPERR ;
output	BBREQPCLK ;
output	BBCKSELR ;
output	BBPRDATA15 ;
output	BBPRDATA14 ;
output	BBPRDATA13 ;
output	BBPRDATA12 ;
output	BBPRDATA11 ;
output	BBPRDATA10 ;
output	BBPRDATA9 ;
output	BBPRDATA8 ;
output	BBPRDATA7 ;
output	BBPRDATA6 ;
output	BBPRDATA5 ;
output	BBPRDATA4 ;
output	BBPRDATA3 ;
output	BBPRDATA2 ;
output	BBPRDATA1 ;
output	BBPRDATA0 ;
output	BBWAITMEM ;
output	BBWAIT56 ;
output	BBINT0 ;
output	BBINT1 ;
output	BBINT2 ;
output	BBINT3 ;
output	BBINT4 ;
output	BBINT5 ;
output	BBINT6 ;
output	BBINT7 ;
output	BBINT8 ;
output	BBINT9 ;
output	BBINT10 ;
output	BBINT11 ;
output	BBINT12 ;
output	BBINT13 ;
output	BBMODE ;
output	BBSCANOUT ;
output	ADTRIG0 ;
// output	ADTRIG1 ;
output	FRQ4EN ;
output	BBCKSELM ;
output	BBHIOON ;
output	BBREGCTL ;

input	/*BBCLKRT*/	BBCLKRL		,BBCLKRR	; // ,BBCLKRD	;
input	/*BBCLKMT*/	BBCLKML		,BBCLKMR	; // ,BBCLKMD	;
//input			BBRPERRL	,BBRPERRR			;
input	/*BBREQPCLKT*/	BBREQPCLKL	,BBREQPCLKR	; // ,BBREQPCLKD	;
input	/*BBCKSELRT*/	BBCKSELRL	,BBCKSELRR	; // ,BBCKSELRD	;
input	/*BBPRDATA15T*/	BBPRDATA15L	,BBPRDATA15R	; // ,BBPRDATA15D	;
input	/*BBPRDATA14T*/	BBPRDATA14L	,BBPRDATA14R	; // ,BBPRDATA14D	;
input	/*BBPRDATA13T*/	BBPRDATA13L	,BBPRDATA13R	; // ,BBPRDATA13D	;
input	/*BBPRDATA12T*/	BBPRDATA12L	,BBPRDATA12R	; // ,BBPRDATA12D	;
input	/*BBPRDATA11T*/	BBPRDATA11L	,BBPRDATA11R	; // ,BBPRDATA11D	;
input	/*BBPRDATA10T*/	BBPRDATA10L	,BBPRDATA10R	; // ,BBPRDATA10D	;
input	/*BBPRDATA9T*/	BBPRDATA9L	,BBPRDATA9R	; // ,BBPRDATA9D	;
input	/*BBPRDATA8T*/	BBPRDATA8L	,BBPRDATA8R	; // ,BBPRDATA8D	;
input	/*BBPRDATA7T*/	BBPRDATA7L	,BBPRDATA7R	; // ,BBPRDATA7D	;
input	/*BBPRDATA6T*/	BBPRDATA6L	,BBPRDATA6R	; // ,BBPRDATA6D	;
input	/*BBPRDATA5T*/	BBPRDATA5L	,BBPRDATA5R	; // ,BBPRDATA5D	;
input	/*BBPRDATA4T*/	BBPRDATA4L	,BBPRDATA4R	; // ,BBPRDATA4D	;
input	/*BBPRDATA3T*/	BBPRDATA3L	,BBPRDATA3R	; // ,BBPRDATA3D	;
input	/*BBPRDATA2T*/	BBPRDATA2L	,BBPRDATA2R	; // ,BBPRDATA2D	;
input	/*BBPRDATA1T*/	BBPRDATA1L	,BBPRDATA1R	; // ,BBPRDATA1D	;
input	/*BBPRDATA0T*/	BBPRDATA0L	,BBPRDATA0R	; // ,BBPRDATA0D	;
input	/*BBWAITMEMT*/	BBWAITMEML	,BBWAITMEMR	; // ,BBWAITMEMD	;
input	/*BBWAIT56T*/	BBWAIT56L	,BBWAIT56R	; // ,BBWAIT56D	;
input			 BBINT0L	,BBINT0R			;
input			 BBINT1L	,BBINT1R		;
input			 BBINT2L	,BBINT2R		;
input			 BBINT3L	,BBINT3R		;
input			 BBINT4L	,BBINT4R		;
input			 BBINT5L	,BBINT5R		;
input			 BBINT6L	,BBINT6R		;
input			 BBINT7L	,BBINT7R		;
input			 BBINT8L	,BBINT8R		;
input	/*BBINT9T*/	BBINT9L		,BBINT9R	; // ,BBINT9D	;
input	/*BBINT10T*/	BBINT10L	,BBINT10R	; // ,BBINT10D	;
input	/*BBINT11T*/	BBINT11L	,BBINT11R	; // ,BBINT11D	;
input	/*BBINT12T*/	BBINT12L	,BBINT12R	; // ,BBINT12D	;
input	/*BBINT13T*/	BBINT13L	,BBINT13R	; // ,BBINT13D	;
input	/*BBMODET*/	BBMODEL		,BBMODER	; // ,BBMODED	;
input	/*BBSCANOUTT*/	BBSCANOUTL	,BBSCANOUTR	; // ,BBSCANOUTD	;
input	/*ADTRIG0T*/	ADTRIG0L	,ADTRIG0R	; // ,ADTRIG0D	;
input			ADTRIG1L	,ADTRIG1R		;
input	/*FRQ4ENT*/	FRQ4ENL		,FRQ4ENR	; // ,FRQ4END	;
input	/*BBCKSELMT*/	BBCKSELML	,BBCKSELMR	; // ,BBCKSELMD	;
input	/*BBHIOONT*/	BBHIOONL	,BBHIOONR	; // ,BBHIOOND	;
input	/*BBREGCTLT*/	BBREGCTLL	,BBREGCTLR	; // ,BBREGCTLD	;






	// for CLKs
	KX4_CAPMUX_OR2	or_clko01 ( .out1( BBCLKR	) /*,.in_t( BBCLKRT	) */,.in_l( BBCLKRL	) ,.in_r( BBCLKRR	) /*,.in_d( BBCLKRD	)*/ );
	KX4_CAPMUX_OR2	or_clko02 ( .out1( BBCLKM	) /*,.in_t( BBCLKMT	) */,.in_l( BBCLKML	) ,.in_r( BBCLKMR	) /*,.in_d( BBCLKMD	)*/ );


	// for SIGNALs
//	KX4_CAPMUX_OR2	or_sigo03 ( .out1( BBRPERR	) 			  ,.in_l( BBRPERRL	) ,.in_r( BBRPERRR	) 			  );
	KX4_CAPMUX_OR2	or_sigo04 ( .out1( BBREQPCLK	) /*,.in_t( BBREQPCLKT	) */,.in_l( BBREQPCLKL	) ,.in_r( BBREQPCLKR	) /*,.in_d( BBREQPCLKD	)*/ );
	KX4_CAPMUX_OR2	or_sigo05 ( .out1( BBCKSELR	) /*,.in_t( BBCKSELRT	) */,.in_l( BBCKSELRL	) ,.in_r( BBCKSELRR	) /*,.in_d( BBCKSELRD	)*/ );
	KX4_CAPMUX_OR2	or_sigo06 ( .out1( BBPRDATA15	) /*,.in_t( BBPRDATA15T	) */,.in_l( BBPRDATA15L	) ,.in_r( BBPRDATA15R	) /*,.in_d( BBPRDATA15D	)*/ );
	KX4_CAPMUX_OR2	or_sigo07 ( .out1( BBPRDATA14	) /*,.in_t( BBPRDATA14T	) */,.in_l( BBPRDATA14L	) ,.in_r( BBPRDATA14R	) /*,.in_d( BBPRDATA14D	)*/ );
	KX4_CAPMUX_OR2	or_sigo08 ( .out1( BBPRDATA13	) /*,.in_t( BBPRDATA13T	) */,.in_l( BBPRDATA13L	) ,.in_r( BBPRDATA13R	) /*,.in_d( BBPRDATA13D	)*/ );
	KX4_CAPMUX_OR2	or_sigo09 ( .out1( BBPRDATA12	) /*,.in_t( BBPRDATA12T	) */,.in_l( BBPRDATA12L	) ,.in_r( BBPRDATA12R	) /*,.in_d( BBPRDATA12D	)*/ );
	KX4_CAPMUX_OR2	or_sigo10 ( .out1( BBPRDATA11	) /*,.in_t( BBPRDATA11T	) */,.in_l( BBPRDATA11L	) ,.in_r( BBPRDATA11R	) /*,.in_d( BBPRDATA11D	)*/ );
	KX4_CAPMUX_OR2	or_sigo11 ( .out1( BBPRDATA10	) /*,.in_t( BBPRDATA10T	) */,.in_l( BBPRDATA10L	) ,.in_r( BBPRDATA10R	) /*,.in_d( BBPRDATA10D	)*/ );
	KX4_CAPMUX_OR2	or_sigo12 ( .out1( BBPRDATA9	) /*,.in_t( BBPRDATA9T	) */,.in_l( BBPRDATA9L	) ,.in_r( BBPRDATA9R	) /*,.in_d( BBPRDATA9D	)*/ );
	KX4_CAPMUX_OR2	or_sigo13 ( .out1( BBPRDATA8	) /*,.in_t( BBPRDATA8T	) */,.in_l( BBPRDATA8L	) ,.in_r( BBPRDATA8R	) /*,.in_d( BBPRDATA8D	)*/ );
	KX4_CAPMUX_OR2	or_sigo14 ( .out1( BBPRDATA7	) /*,.in_t( BBPRDATA7T	) */,.in_l( BBPRDATA7L	) ,.in_r( BBPRDATA7R	) /*,.in_d( BBPRDATA7D	)*/ );
	KX4_CAPMUX_OR2	or_sigo15 ( .out1( BBPRDATA6	) /*,.in_t( BBPRDATA6T	) */,.in_l( BBPRDATA6L	) ,.in_r( BBPRDATA6R	) /*,.in_d( BBPRDATA6D	)*/ );
	KX4_CAPMUX_OR2	or_sigo16 ( .out1( BBPRDATA5	) /*,.in_t( BBPRDATA5T	) */,.in_l( BBPRDATA5L	) ,.in_r( BBPRDATA5R	) /*,.in_d( BBPRDATA5D	)*/ );
	KX4_CAPMUX_OR2	or_sigo17 ( .out1( BBPRDATA4	) /*,.in_t( BBPRDATA4T	) */,.in_l( BBPRDATA4L	) ,.in_r( BBPRDATA4R	) /*,.in_d( BBPRDATA4D	)*/ );
	KX4_CAPMUX_OR2	or_sigo18 ( .out1( BBPRDATA3	) /*,.in_t( BBPRDATA3T	) */,.in_l( BBPRDATA3L	) ,.in_r( BBPRDATA3R	) /*,.in_d( BBPRDATA3D	)*/ );
	KX4_CAPMUX_OR2	or_sigo19 ( .out1( BBPRDATA2	) /*,.in_t( BBPRDATA2T	) */,.in_l( BBPRDATA2L	) ,.in_r( BBPRDATA2R	) /*,.in_d( BBPRDATA2D	)*/ );
	KX4_CAPMUX_OR2	or_sigo20 ( .out1( BBPRDATA1	) /*,.in_t( BBPRDATA1T	) */,.in_l( BBPRDATA1L	) ,.in_r( BBPRDATA1R	) /*,.in_d( BBPRDATA1D	)*/ );
	KX4_CAPMUX_OR2	or_sigo21 ( .out1( BBPRDATA0	) /*,.in_t( BBPRDATA0T	) */,.in_l( BBPRDATA0L	) ,.in_r( BBPRDATA0R	) /*,.in_d( BBPRDATA0D	)*/ );
	KX4_CAPMUX_OR2	or_sigo22 ( .out1( BBWAITMEM	) /*,.in_t( BBWAITMEMT	) */,.in_l( BBWAITMEML	) ,.in_r( BBWAITMEMR	) /*,.in_d( BBWAITMEMD	)*/ );
	KX4_CAPMUX_OR2	or_sigo23 ( .out1( BBWAIT56	) /*,.in_t( BBWAIT56T	) */,.in_l( BBWAIT56L	) ,.in_r( BBWAIT56R	) /*,.in_d( BBWAIT56D	)*/ );
	KX4_CAPMUX_OR2	or_sigo24 ( .out1( BBINT0	) 			  ,.in_l( BBINT0L	) ,.in_r( BBINT0R	) 			  );
	KX4_CAPMUX_OR2	or_sigo25 ( .out1( BBINT1	) 			  ,.in_l( BBINT1L	) ,.in_r( BBINT1R	) 			  );
	KX4_CAPMUX_OR2	or_sigo26 ( .out1( BBINT2	) 			  ,.in_l( BBINT2L	) ,.in_r( BBINT2R	) 			  );
	KX4_CAPMUX_OR2	or_sigo27 ( .out1( BBINT3	) 			  ,.in_l( BBINT3L	) ,.in_r( BBINT3R	) 			  );
	KX4_CAPMUX_OR2	or_sigo28 ( .out1( BBINT4	) 			  ,.in_l( BBINT4L	) ,.in_r( BBINT4R	) 			  );
	KX4_CAPMUX_OR2	or_sigo29 ( .out1( BBINT5	) 			  ,.in_l( BBINT5L	) ,.in_r( BBINT5R	) 			  );
	KX4_CAPMUX_OR2	or_sigo30 ( .out1( BBINT6	) 			  ,.in_l( BBINT6L	) ,.in_r( BBINT6R	) 			  );
	KX4_CAPMUX_OR2	or_sigo31 ( .out1( BBINT7	) 			  ,.in_l( BBINT7L	) ,.in_r( BBINT7R	) 			  );
	KX4_CAPMUX_OR2	or_sigo32 ( .out1( BBINT8	) 			  ,.in_l( BBINT8L	) ,.in_r( BBINT8R	) 			  );
	KX4_CAPMUX_OR2	or_sigo33 ( .out1( BBINT9	) /*,.in_t( BBINT9T	) */,.in_l( BBINT9L	) ,.in_r( BBINT9R	) /*,.in_d( BBINT9D	)*/ );
	KX4_CAPMUX_OR2	or_sigo34 ( .out1( BBINT10	) /*,.in_t( BBINT10T	) */,.in_l( BBINT10L	) ,.in_r( BBINT10R	) /*,.in_d( BBINT10D	)*/ );
	KX4_CAPMUX_OR2	or_sigo35 ( .out1( BBINT11	) /*,.in_t( BBINT11T	) */,.in_l( BBINT11L	) ,.in_r( BBINT11R	) /*,.in_d( BBINT11D	)*/ );
	KX4_CAPMUX_OR2	or_sigo36 ( .out1( BBINT12	) /*,.in_t( BBINT12T	) */,.in_l( BBINT12L	) ,.in_r( BBINT12R	) /*,.in_d( BBINT12D	)*/ );
	KX4_CAPMUX_OR2	or_sigo37 ( .out1( BBINT13	) /*,.in_t( BBINT13T	) */,.in_l( BBINT13L	) ,.in_r( BBINT13R	) /*,.in_d( BBINT13D	)*/ );
	KX4_CAPMUX_OR2	or_sigo38 ( .out1( BBMODE	) /*,.in_t( BBMODET	) */,.in_l( BBMODEL	) ,.in_r( BBMODER	) /*,.in_d( BBMODED	)*/ );
	KX4_CAPMUX_OR2	or_sigo39 ( .out1( BBSCANOUT	) /*,.in_t( BBSCANOUTT	) */,.in_l( BBSCANOUTL	) ,.in_r( BBSCANOUTR	) /*,.in_d( BBSCANOUTD	)*/ );
	KX4_CAPMUX_OR2	or_sigo40 ( .out1( ADTRIG0	) /*,.in_t( ADTRIG0T	) */,.in_l( ADTRIG0L	) ,.in_r( ADTRIG0R	) /*,.in_d( ADTRIG0D	)*/ );
	KX4_CAPMUX_OR2	or_sigo41 ( .out1( ADTRIG1	) 			  ,.in_l( ADTRIG1L	) ,.in_r( ADTRIG1R	) 			  );
	KX4_CAPMUX_OR2	or_sigo42 ( .out1( FRQ4EN	) /*,.in_t( FRQ4ENT	) */,.in_l( FRQ4ENL	) ,.in_r( FRQ4ENR	) /*,.in_d( FRQ4END	)*/ );
	KX4_CAPMUX_OR2	or_sigo43 ( .out1( INTRTDIS	) 			  ,.in_l( INTRTDISL	) ,.in_r( INTRTDISR	) 			  );
	KX4_CAPMUX_OR2	or_sigo44 ( .out1( BBCKSELM	) /*,.in_t( BBCKSELMT	) */,.in_l( BBCKSELML	) ,.in_r( BBCKSELMR	) /*,.in_d( BBCKSELMD	)*/ );
	KX4_CAPMUX_OR2	or_sigo45 ( .out1( BBHIOON	) /*,.in_t( BBHIOONT	) */,.in_l( BBHIOONL	) ,.in_r( BBHIOONR	) /*,.in_d( BBHIOOND	)*/ );
	KX4_CAPMUX_OR2	or_sigo46 ( .out1( BBREGCTL	) /*,.in_t( BBREGCTLT	) */,.in_l( BBREGCTLL	) ,.in_r( BBREGCTLR	) /*,.in_d( BBREGCTLD	)*/ );
	


	KX4_CAPMUX4_INTRTSEL intrtc_sel ( .TTRG2( TTRG2 ) ,.ADTRIG1( ADTRIG1 ) ,.INTRTC( INTRTC ) ,.INTRTDIS( INTRTDIS ) );
endmodule


module KX4_CAPMUX_OR4 ( out1 ,in_t ,in_l ,in_r ,in_d );
input in_t;
input in_l;
input in_r;
input in_d;

output out1;

wire   out_top_left ;
wire   out_dwn_rigt ;

//	TBOR4X2 U1 ( .N01(out1) ,.H01(in_t) ,.H02(in_l) ,.H03(in_r) ,.H04(in_d) );

	TBOR2X1 or1_top_left ( .N01( out_top_left ) ,.H01(in_t) ,.H02(in_l) );
	TBOR2X1 or2_dwn_rigt ( .N01( out_dwn_rigt ) ,.H01(in_d) ,.H02(in_r) );

	TBOR2X1 or3 ( .N01( out1 ) ,.H01(out_top_left) ,.H02(out_dwn_rigt) );
endmodule

module KX4_CAPMUX_OR2 ( out1 ,in_l ,in_r );
input in_l;
input in_r;

output out1;

	TBOR2X1 or3 ( .N01( out1 ) ,.H01(in_l) ,.H02(in_r) );
endmodule

module KX4_CAPMUX4_INTRTSEL ( TTRG2 ,ADTRIG1 ,INTRTC ,INTRTDIS );
output	TTRG2 ;
input	ADTRIG1 ;
input	INTRTC	;
input	INTRTDIS ;

	TBINVX2	U_intrt_inv ( .N01( INTRTDIS_b ) ,.H01( INTRTDIS ) ) ;
	TBAD2X1 U_intrt_and ( .N01( sel_INTRTC ) ,.H01( INTRTC ) ,.H02( INTRTDIS_b ) );
	TBOR2X1 U_intrt_or  ( .N01( TTRG2 ) ,.H01( sel_INTRTC ) ,.H02( ADTRIG1 ) );

endmodule
