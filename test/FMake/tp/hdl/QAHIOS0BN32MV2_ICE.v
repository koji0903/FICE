/************************************************************************/
/* Date		: 2009/11/16						*/
/* Version	: 100							*/
/* Designer	: T.Tsunoda						*/
/* Note		: SS3rd$BMQ(B32MHZ$B9bB.FbB"H/?64o$N(BICE$BMQ(BEmulationMacro.	*/
/************************************************************************/
/* Date		: 2010/02/12						*/
/* Version	: 101							*/
/* Designer	: T.Tsunoda						*/
/* Note		: REQFL$B$r8GDjCM(BH$B$+$i8GDjCM(BL$B$KJQ99!#(BREQFL=H$B$@$HB>$N(B	*/
/*		: $B%/%m%C%/Dd;_>r7o$K0-1F6A$,$"$k$?$a!#(B			*/
/************************************************************************/
/* Date		: 2010/02/16						*/
/* Version	: 102							*/
/* Designer	: T.Tsunoda						*/
/* Note		: REQFL$B$r(BDevice$B$HF1$8$/(BCP$B$+$i<u5k!#(BFIHFL$B$r=PNO!#(B	*/
/************************************************************************/
/* Date		: 2010/03/03						*/
/* Version	: 103							*/
/* Designer	: T.Tsunoda						*/
/* Note		: DCM$B$N(BCLKFX$B=PNO$r!"(BBUFG$BIU$-(B:Virtex5,$BL5$7(B:Virtex4$B$GJ,$1(B	*/
/*		: $B$?(B(ifdef$B$K$h$k(B)$B!#(BV5$B$G$O(BBUFG$BL5$7$@$H(BError$B$K$J$k$?$a!#(B	*/
/************************************************************************/
/* Date		: 2010/04/14						*/
/* Version	: 104							*/
/* Designer	: T.Tsunoda						*/
/* Note		: 32MHz$B$N(BDuty$B$rJQ99!#(Bifdef$B$K$h$j(BDuty$BHf$N@ZBX$r9T$&!#(B	*/
/*		: Target Device$B$G(B32MHz$B$rK~$9$N$,87$7$$>l9g$N=hCV$G$"$j(B,	*/
/*		: 32MHz Over$B$N<~GH?t$O;H$o$l$J$$$3$rA0Ds$H$9$k!#(B	*/
/*----------------------------------------------------------------------*/
/* ifdef$B$K$h$k@ZBX(B    |	define			      |	no-define	*/
/*--------------------+-------------------------------+-----------------*/
/* FPGA_ICE_HROSCSS3RD|	glitch$B$,H/@8$9$k(Bmux($B@ZBXB.$$(B) |	glitch$BH/@8$J$7(B	*/
/* FPGA_ICE_VIRTEX5   |	CLKFX$B$K(BBUFG$B$rA^F~(B	      |	$BA^F~$7$J$$(B	*/
/* FPGA_ICE_HRODCM160 | Duty$BD4@0(BClock$B$K(B160MHz$B;HMQ(B.    | Other		*/
/* FPGA_ICE_HRODCM224 | Duty$BD4@0(BClock$B$K(B224MHz$B;HMQ(B.    | Other		*/
/* FPGA_ICE_HRODCM256 | Duty$BD4@0(BClock$B$K(B256MHz$B;HMQ(B.    | Duty50:50	*/
/*----------------------------------------------------------------------*/
/************************************************************************/
/* Date		: 2010/04/15						*/
/* Version	: 105							*/
/* Designer	: T.Tsunoda						*/
/* Note		: $B!&(BMacro$BL>$rJQ99!#(B(HROSCSS3RD -> QAHIOS0BN32MV1_ICE)	*/
/*		: $B!&C<;RDI2C!#(B($BCV$-49$(85$N(BMacro$B$HC<;R>pJs$r9g$;$kL\E*(B	*/
/*		:   $B$G!"CV$-49$(85$K$"$C$F!"$3$N(BMacro$B$G$O;H$o$J$$C<;R$r(B	*/
/*		:   $BA4$F;}$?$;$?!#(B(Open or $BC<;R=hM}(B)			*/
/************************************************************************/
/* Date		: 2010/07/14						*/
/* Version	: 200							*/
/* Designer	: T.Tsunoda						*/
/* Note		: Macro Version$B$rJQ99(B.(**MV1_ICE->**MV2_ICE)		*/
/*		: $B85(BMacro$B$N2~HG$KH<$&(B.ICE$B$H$7$F$O0J2<$NC<;RDI2C$N$_(B.	*/
/*		: FRQSEL5, RTRIM5-2, WTRIM2-0, FTRIM5-0			*/
/************************************************************************/
/* Date		: 2010/07/30						*/
/* Version	: 201							*/
/* Designer	: Y.Ishiguro						*/
/* Note		: $B!&(B40MHz$B$N(BDCM$BDI2C(B $BDI2CC<;R(B :  LOCK40FAIL		*/
/* 		: $B!&(B`ifdef FPGA_ICE_HROSCSS3RD$B$N(Balways$B$N>r7o$K(BCLK48M,	*/
/* 		:   CLK64M,CLK40M,clk40$B$rDI2C!#(B				*/
/* 		: $B!&(B`ifdef FPGA_ICE_HRODCM40$B$rF~$l$F$$$kM}M3(B		*/
/* 		:   DCM$B$r;HMQ$9$k;~(BDCM$B$N=PNO$,A*Br$5$l$J$$$h$&$J(B	*/
/* 		:   $B2sO)9=@.$N>l9g(B,DRC$B$G%(%i!<$K$J$k!#(B			*/
/* 		:   FRQSEL5$B$O(BPull-down$B$5$l$F$$$F%I%i%$%V$9$k2sO)$,(B	*/
/* 		:   $B@Q$^$l$F$$$J$$$?$a(B40MHz$B$N(BDCM$B$,A*Br$5$l$J$$2sO)9=@.(B	*/
/* 		:   $B$K$J$j(B,DCM$B<+BN$O=LB`$5$l$:;D$j(B,DCM$B$N=PNO@h$N$_$,(B	*/
/* 		:   $B=LB`$7$F$7$^$$(BDRC$B$K0cH?$7(B,$B%(%i!<$H$J$k$?$a(B		*/
/* 		:   `ifdef FPGA_ICE_HRODCM40$B$rF~$l$F2sHr$7$F$$$k!#(B	*/
/************************************************************************/
/* Date		: 2010/09/09						*/
/* Version	: 202							*/
/* Designer	: T.Tsunoda						*/
/* Note		: Original$B$NC<;R$,JQ99$5$l$?$?$a9g$;$FJQ99$7$?!#(B	*/
/*		: RESFB5V -> POCREL5V					*/
/************************************************************************/
/* Date		: 2010/10/15						*/
/* Version	: 203							*/
/* Designer	: Y.Ishiguro						*/
/* Note		: $B2sO)5-=R$G(Bifdef FPGA_ICE_HRODCM40$B@k8@$7$?;~(B		*/
/*		: cnt40$B$,30$l$-$l$F$$$J$/F~NO?.9f$,@k8@$5$l$F$$$J$/(B	*/
/*		: $B$W$i$W$i$N>uBV$@$C$?$N$G(BLOW$B8GDj$K$7$?!#(B		*/
/************************************************************************/
/* Date		: 2011/01/12						*/
/* Version	: 204							*/
/* Designer	: T.Tsunoda						*/
/* Note		: CLK64M, CLK48M, CLK32M$B?.9f$r=PNOC<;R$K(BAssign.		*/
/************************************************************************/

module QAHIOS0BN32MV2_ICE (
	FRQSEL5,
	FRQSEL4, FRQSEL3, FRQSEL2, FRQSEL1, FRQSEL0, IOSCSTP, REQOCD, REQFL,
	R32MOUT, FIHOCD, FIHFL,
	CLK30MHZ, PONRESB, LOCK48FAIL, LOCK64FAIL, LOCKHROSCFAIL,LOCK40FAIL,
	CLK64M, CLK48M, CLK32M,
	VBGOREG, BGIOREG1, BGIOREG2, OREGSTP, POCREL5V, TSELOREG, TSELIRES,
	CTRIM6, CTRIM5, CTRIM4, CTRIM3, CTRIM2, CTRIM1, CTRIM0, 
	RTRIM5, RTRIM4, RTRIM3, RTRIM2, RTRIM1, RTRIM0, EXRTRIM,
	WTRIM2, WTRIM1, WTRIM0, FTRIM5, FTRIM4, FTRIM3, FTRIM2, FTRIM1, FTRIM0,
	TTEMP, OREGOUT, TEMP4, TEMP3, TEMP2, TEMP1, TEMP0
);
	input	FRQSEL5;	// 10.7.14$B;~E@$G;EMMITL@(B.Device$B$G$O(BPulldown.(V2$B$GDI2C(B)	(from pulldown)
				// $B$3$H$+$i(B,$BF~NOC<;R$H$7$FC<;RDI2C$N$_9T$&(B.
	input	FRQSEL4;	// R32MOUT,FIHOCD,FIHFL$B$NJ,<~Hf@_Dj?.9f(B.		(from CSC)
	input	FRQSEL3;	// R32MOUT,FIHOCD,FIHFL$B$NJ,<~Hf@_Dj?.9f(B.		(from CSC)
	input	FRQSEL2;	// R32MOUT$B$NJ,<~Hf@_Dj?.9f(B.				(from CSC)
	input	FRQSEL1;	// R32MOUT$B$NJ,<~Hf@_Dj?.9f(B.				(from CSC)
	input	FRQSEL0;	// R32MOUT$B$NJ,<~Hf@_Dj?.9f(B.				(from CSC)
	input	IOSCSTP;	// $BH/?64oA4BN$NH/?6Dd;_?.9f(B."1"$B$GDd;_!#(BREQOCD,REQFL=0$B$N(B	(from CSC)
				// $B;~$N$_(BIOSCSTP=1$B$N@_Dj$,2DG=$J$h$&(BCSC$B$G:n$j9~$s$G$$$k(B.
	input	REQOCD;		// FIHOCD$B$N=PNODd;_?.9f(B.    "0"$B$GDd;_(B			(from OCD)
	input	REQFL;		// FIHFL$B$N=PNODd;_?.9f(B.     "0"$B$GDd;_(B			(from flash_cp)
	output	R32MOUT;	// 32MHz$BFbB"9bB.H/?64o=PNO(B.				(to CSC)
	output	FIHOCD;		// OCD$BMQ(BClock$B=PNO(B					(to OCD)
	output	FIHFL;		// Flash-CP$BMQ(BClock$B=PNO(B					(to flash_cp)
	/*--------------*/
	/* ICE$BMQ(BI/F	*/
	/*--------------*/
	input	CLK30MHZ;	// ICE$BMQ(B30MHz System Clock				(from pin)
	input	PONRESB;	// Power-ON Reset$B?.9f(B					(from reset block)
	output	LOCK48FAIL;	// 48MHz$BMQ(BDCM$B$N(BLOCK$B?.9f(B					(to clock block)
	output	LOCK64FAIL;	// 64MHz$BMQ(BDCM$B$N(BLOCK$B?.9f(B					(to clock block)
	output	LOCKHROSCFAIL;	// 160MHz or 224MHz or 256MHz$BMQ(BDCM$B$N(BLOCK$B?.9f(B		(to clock block)
	output	LOCK40FAIL;	// 40MHz$BMQ(BDCM$B$N(BLOCK$B?.9f(B	ver.201 add			(to clock block)
	output	CLK64M;		// 64MHz Clock$B!#B>$N(BReplace Macro$B$G6&MQ$9$k!#(B
	output	CLK48M;		// 48MHz Clock$B!#B>$N(BReplace Macro$B$G6&MQ$9$k!#(B
	output	CLK32M;		// 32MHz Clock$B!#B>$N(BReplace Macro$B$G6&MQ$9$k!#(B
	/*----------------------*/
	/* $BF~NO$N$_(B($BL$;HMQC<;R(B)	*/
	/*----------------------*/
	input	VBGOREG;	// Chip Regulator$BFbB"(BBGR$B$+$i=PNO$5$l$k4p=`EE05(B(0.8V)	(from regm)
	input	BGIOREG1;	// Chip Regulator$BFbB"(BBGR$B$+$i=PNO$5$l$k4p=`EEN.(B(50nA)	(from regm)
	input	BGIOREG2;	// Chip Regulator$BFbB"(BBGR$B$+$i=PNO$5$l$k4p=`EEN.(B(50nA)	(from regm)
	input	OREGSTP;	// OREG$BDd;_@)8f?.9f(B					(from csc)
	input	POCREL5V;	// 5V$B7O(BReset$B?.9f(B					(from resetb)
	input	TSELOREG;	// OREG$B%F%9%H?.9f(B					(from csc)
	input	TSELIRES;	// IOSC$BFbDq93CM%F%9%H?.9f(B				(from csc)
	input	CTRIM6;		// C$B$K$h$kH/?6<~GH?t$N(BTrimming$B@)8f(B			(from cibc)
	input	CTRIM5;		// C$B$K$h$kH/?6<~GH?t$N(BTrimming$B@)8f(B			(from cibc)
	input	CTRIM4;		// C$B$K$h$kH/?6<~GH?t$N(BTrimming$B@)8f(B			(from cibc)
	input	CTRIM3;		// C$B$K$h$kH/?6<~GH?t$N(BTrimming$B@)8f(B			(from cibc)
	input	CTRIM2;		// C$B$K$h$kH/?6<~GH?t$N(BTrimming$B@)8f(B			(from cibc)
	input	CTRIM1;		// C$B$K$h$kH/?6<~GH?t$N(BTrimming$B@)8f(B			(from cibc)
	input	CTRIM0;		// C$B$K$h$kH/?6<~GH?t$N(BTrimming$B@)8f(B			(from cibc)
	input	RTRIM5;		// R$B$G;HMQ$5$l$F$$$k(BLSB$BDq93$N(BTc1 Trimming$BDq93(B(V2$B$GDI2C(B)	(from cibc)
	input	RTRIM4;		// R$B$G;HMQ$5$l$F$$$k(BLSB$BDq93$N(BTc1 Trimming$BDq93(B(V2$B$GDI2C(B)	(from cibc)
	input	RTRIM3;		// R$B$G;HMQ$5$l$F$$$k(BLSB$BDq93$N(BTc1 Trimming$BDq93(B(V2$B$GDI2C(B)	(from cibc)
	input	RTRIM2;		// R$B$G;HMQ$5$l$F$$$k(BLSB$BDq93$N(BTc1 Trimming$BDq93(B(V2$B$GDI2C(B)	(from cibc)
	input	RTRIM1;		// R$B$G;HMQ$5$l$F$$$k(BLSB$BDq93$N(BTc1 Trimming$BDq93(B		(from cibc)
	input	RTRIM0;		// R$B$G;HMQ$5$l$F$$$k(BLSB$BDq93$N(BTc1 Trimming$BDq93(B		(from cibc)
	input	EXRTRIM;	// $B<+8J@)8f29EY(BTrimming$B?.9f(B				(from cibc)
	input	WTRIM2;		// Metal$BDq93$K$h$k<~GH?t(BTrimming$B@)8f(B($BAF$/(B)(V2$B$GDI2C(B)	(from cibc)
	input	WTRIM1;		// Metal$BDq93$K$h$k<~GH?t(BTrimming$B@)8f(B($BAF$/(B)(V2$B$GDI2C(B)	(from cibc)
	input	WTRIM0;		// Metal$BDq93$K$h$k<~GH?t(BTrimming$B@)8f(B($BAF$/(B)(V2$B$GDI2C(B)	(from cibc)
	input	FTRIM5;		// Metal$BDq93$K$h$k<~GH?t(BTrimming$B@)8f(B($B:Y$+$/(B)(V2$B$GDI2C(B)	(from cibc)
	input	FTRIM4;		// Metal$BDq93$K$h$k<~GH?t(BTrimming$B@)8f(B($B:Y$+$/(B)(V2$B$GDI2C(B)	(from cibc)
	input	FTRIM3;		// Metal$BDq93$K$h$k<~GH?t(BTrimming$B@)8f(B($B:Y$+$/(B)(V2$B$GDI2C(B)	(from cibc)
	input	FTRIM2;		// Metal$BDq93$K$h$k<~GH?t(BTrimming$B@)8f(B($B:Y$+$/(B)(V2$B$GDI2C(B)	(from cibc)
	input	FTRIM1;		// Metal$BDq93$K$h$k<~GH?t(BTrimming$B@)8f(B($B:Y$+$/(B)(V2$B$GDI2C(B)	(from cibc)
	input	FTRIM0;		// Metal$BDq93$K$h$k<~GH?t(BTrimming$B@)8f(B($B:Y$+$/(B)(V2$B$GDI2C(B)	(from cibc)
	input	TTEMP;		// $B29EY(BTrimming$B%F%9%H?.9f(B				(from csc)
	/*----------------------*/
	/* $B8GDj=PNO(B($BL$;HMQC<;R(B)	*/
	/*----------------------*/
	output	OREGOUT;	// $B8!::!"I>2AMQF~=PNO(B($B"((BDevice$B$G$O(BI/O$BC<;R(B)		(to port4_iobuf)
	output	TEMP4;		// $B29EY(BTrimming Decoder$B=PNO(B				(to csc)
	output	TEMP3;		// $B29EY(BTrimming Decoder$B=PNO(B				(to csc)
	output	TEMP2;		// $B29EY(BTrimming Decoder$B=PNO(B				(to csc)
	output	TEMP1;		// $B29EY(BTrimming Decoder$B=PNO(B				(to csc)
	output	TEMP0;		// $B29EY(BTrimming Decoder$B=PNO(B				(to csc)

	wire rst64m;
	wire lock64;
	wire rst48m;
	wire lock48;
	wire rst40m;		//ver.201 add
	wire lock40;		//ver.201 add
//
// 64MHz Clock
//
	/* ------------------------------------------------------------------------------------	*/
	/* (1)$B<+?H$,(Block$B$7$?$"$H(Block$B$,30$l$?>l9g<+?H$r(BReset$B$9$k!#(BReset$BH/9T8e(B4Clock$B$^$C$F(BReset	*/
	/*    $B2r=|$9$k$?$a(Brst64m$B$r%U%#!<%I%P%C%/!#(B	clock$B%V%m%C%/$N:n$j$K9g$;$?!#(B		*/
	/* ------------------------------------------------------------------------------------	*/
	wire rst64mfb = !PONRESB | rst64m;
	reg lock64pos;
	always @(posedge lock64 or posedge rst64mfb) begin
		if (rst64mfb)
			lock64pos <= 1'b0;
		else	lock64pos <= 1'b1;
	end
	reg lock64posneg;
	always @(negedge lock64 or posedge rst64mfb) begin
		if (rst64mfb)
			lock64posneg <= 1'b0;
		else	lock64posneg <= lock64pos;
	end
	reg LOCK64FAIL;
	always @(posedge lock64posneg or negedge PONRESB) begin
		if (!PONRESB)
			LOCK64FAIL <= 1'b0;
		else	LOCK64FAIL <= 1'b1;
	end

	wire srcrst64 = PONRESB;
	reg [3:0] rst64msrc;
	always @(posedge CLK30MHZ or negedge srcrst64) begin
		if (!srcrst64)
			rst64msrc <= 4'hf;
		else	rst64msrc <= {rst64msrc[2:0], lock64posneg};
	end

	// Reset$B2r=|$O(B4Clock$BCY$i$;(BReset$B$KF~$l$k;~$OD>$KF~$l$k!#(B
	assign	rst64m = |rst64msrc;

	DCM64MHZ dcm64m (
		.CLKIN_IN(CLK30MHZ),
		.RST_IN(rst64m),
		.CLKFX_OUT(CLK64M),
		.LOCKED(lock64)
		);

//
// 48MHz Clock
//
	/* ------------------------------------------------------------------------------------	*/
	/* (1)clkin$B6!5k85$N(Block$B$,$+$+$C$F$+$i(B2clock$B0J>e(B(4clock)$B$^$C$F$+$i(Breset$B$r(Bdeassert$B$9$k!#(B	*/
	/* (2)$B<+?H$,(Block$B$7$?$"$H(Block$B$,30$l$?>l9g<+?H$r(BReset$B$9$k!#(BReset$BH/9T8e(B4Clock$B$^$C$F(BReset	*/
	/*    $B2r=|$9$k$?$a(Brst64m$B$r%U%#!<%I%P%C%/!#(B	clock$B%V%m%C%/$N:n$j$K9g$;$?!#(B		*/
	/* (3)clkin$B6!5k85$,(Block$B$7$?>l9g$b(B(2)$B$K9g$;$F(BDCM$B$r(BReset$B$5$;$k!#(B				*/
	/* ------------------------------------------------------------------------------------	*/
	wire rst48mfb = !PONRESB | rst48m;
	reg lock48pos;
	always @(posedge lock48 or posedge rst48mfb) begin
		if (rst48mfb)
			lock48pos <= 1'b0;
		else	lock48pos <= 1'b1;
	end
	reg lock48posneg;
	always @(negedge lock48 or posedge rst48mfb) begin
		if (rst48mfb)
			lock48posneg <= 1'b0;
		else	lock48posneg <= lock48pos;
	end
	reg LOCK48FAIL;
	always @(posedge lock48posneg or negedge PONRESB) begin
		if (!PONRESB)
			LOCK48FAIL <= 1'b0;
		else	LOCK48FAIL <= 1'b1;
	end

	wire srcrst48 = PONRESB & lock64;
	reg [3:0] rst48msrc;
	always @(posedge CLK64M or negedge srcrst48) begin
		if (!srcrst48)
			rst48msrc <= 4'hf;
		else if (lock64)
			rst48msrc <= {rst48msrc[2:0], lock48posneg};
	end

	// Reset$B2r=|$O(B4Clock$BCY$i$;(BReset$B$KF~$l$k;~$OD>$KF~$l$k!#(B
	assign	rst48m = |rst48msrc;

	DCM48MHZ dcm48m (
		.CLKIN_IN(CLK64M),
		.RST_IN(rst48m),
		.CLKFX_OUT(CLK48M),
		.LOCKED(lock48)
		);

//
// 32MHz Clock
//

`ifdef FPGA_ICE_HRODCM160

/*----------------------------------------------------------------------*/
/* 32MHz$B$G(BDuty4:6$B$N>l9g(B,Low$BI}(B(6)$B$G8+$?<~GH?t$O(B=~26MHz$B$J$N$G(B,32MHz$B$N(B	*/
/* $B<!$KB.$$A*Br;h$N(B24MHz$B$h$j$bB.$$$?$a(B,32MHz$B$N$_(BDuty$B$rJQ99$9$l$P(BOK.	*/
/*----------------------------------------------------------------------*/
	wire rst160m;
	wire lock160;

	wire rst160mfb = !PONRESB | rst160m;
	reg lock160pos;
	always @(posedge lock160 or posedge rst160mfb) begin
		if (rst160mfb)
			lock160pos <= 1'b0;
		else	lock160pos <= 1'b1;
	end
	reg lock160posneg;
	always @(negedge lock160 or posedge rst160mfb) begin
		if (rst160mfb)
			lock160posneg <= 1'b0;
		else	lock160posneg <= lock160pos;
	end
	reg LOCKHROSCFAIL;
	always @(posedge lock160posneg or negedge PONRESB) begin
		if (!PONRESB)
			LOCKHROSCFAIL <= 1'b0;
		else	LOCKHROSCFAIL <= 1'b1;
	end

	wire srcrst160 = PONRESB & lock64;
	reg [3:0] rst160msrc;
	always @(posedge CLK64M or negedge srcrst160) begin
		if (!srcrst160)
			rst160msrc <= 4'hf;
		else if (lock64)
			rst160msrc <= {rst160msrc[2:0], lock160posneg};
	end

	// Reset$B2r=|$O(B4Clock$BCY$i$;(BReset$B$KF~$l$k;~$OD>$KF~$l$k!#(B
	assign	rst160m = |rst160msrc;

	DCM160MHZ dcm160m (
		.CLKIN_IN(CLK64M),
		.RST_IN(rst160m),
		.CLKFX_OUT(CLK160M),
		.LOCKED_OUT(lock160)
		);

	reg [2:0] cnt32_duty4_6;
	reg CLK32M;
	always @(posedge CLK160M or negedge PONRESB) begin
		if (!PONRESB) begin
			cnt32_duty4_6 <= 3'h0;
			CLK32M <= 1'b1;
		end
		else if (cnt32_duty4_6 == 3'h1) begin
			cnt32_duty4_6 <= cnt32_duty4_6 + 1;
			CLK32M <= 1'b0;
		end
		else if (cnt32_duty4_6 == 3'h4) begin
			cnt32_duty4_6 <= 3'h0;
			CLK32M <= 1'b1;
		end
		else begin
			cnt32_duty4_6 <= cnt32_duty4_6 + 1;
			CLK32M <= CLK32M;
		end
	end

`else
`ifdef FPGA_ICE_HRODCM224

/*----------------------------------------------------------------------*/
/* 32MHz$B$G(BDuty42:58$B$N>l9g(B,Low$BI}(B(58)$B$G8+$?<~GH?t$O(B=~27MHz$B$J$N$G(B,32MHz$B$N(B	*/
/* $B<!$KB.$$A*Br;h$N(B24MHz$B$h$j$bB.$$$?$a(B,32MHz$B$N$_(BDuty$B$rJQ99$9$l$P(BOK.	*/
/*----------------------------------------------------------------------*/
	wire rst224m;
	wire lock224;

	wire rst224mfb = !PONRESB | rst224m;
	reg lock224pos;
	always @(posedge lock224 or posedge rst224mfb) begin
		if (rst224mfb)
			lock224pos <= 1'b0;
		else	lock224pos <= 1'b1;
	end
	reg lock224posneg;
	always @(negedge lock224 or posedge rst224mfb) begin
		if (rst224mfb)
			lock224posneg <= 1'b0;
		else	lock224posneg <= lock224pos;
	end
	reg LOCKHROSCFAIL;
	always @(posedge lock224posneg or negedge PONRESB) begin
		if (!PONRESB)
			LOCKHROSCFAIL <= 1'b0;
		else	LOCKHROSCFAIL <= 1'b1;
	end

	wire srcrst224 = PONRESB & lock64;
	reg [3:0] rst224msrc;
	always @(posedge CLK64M or negedge srcrst224) begin
		if (!srcrst224)
			rst224msrc <= 4'hf;
		else if (lock64)
			rst224msrc <= {rst224msrc[2:0], lock224posneg};
	end

	// Reset$B2r=|$O(B4Clock$BCY$i$;(BReset$B$KF~$l$k;~$OD>$KF~$l$k!#(B
	assign	rst224m = |rst224msrc;

	DCM224MHZ dcm224m (
		.CLKIN_IN(CLK64M),
		.RST_IN(rst224m),
		.CLKFX_OUT(CLK224M),
		.LOCKED_OUT(lock224)
		);

	reg [2:0] cnt32_duty42_58;
	reg CLK32M;
	always @(posedge CLK224M or negedge PONRESB) begin
		if (!PONRESB) begin
			cnt32_duty42_58 <= 3'h0;
			CLK32M <= 1'b1;
		end
		else if (cnt32_duty42_58 == 3'h2) begin
			cnt32_duty42_58 <= cnt32_duty42_58 + 1;
			CLK32M <= 1'b0;
		end
		else if (cnt32_duty42_58 == 3'h6) begin
			cnt32_duty42_58 <= 3'h0;
			CLK32M <= 1'b1;
		end
		else begin
			cnt32_duty42_58 <= cnt32_duty42_58 + 1;
			CLK32M <= CLK32M;
		end
	end

`else
`ifdef FPGA_ICE_HRODCM256

/*----------------------------------------------------------------------*/
/* 32MHz$B$G(BDuty38:62$B$N>l9g(B,Low$BI}(B(62)$B$G8+$?<~GH?t$O(B=~25MHz$B$J$N$G(B,32MHz$B$N(B	*/
/* $B<!$KB.$$A*Br;h$N(B24MHz$B$h$j$bB.$$$?$a(B,32MHz$B$N$_(BDuty$B$rJQ99$9$l$P(BOK.	*/
/*----------------------------------------------------------------------*/
	wire rst256m;
	wire lock256;

	wire rst256mfb = !PONRESB | rst256m;
	reg lock256pos;
	always @(posedge lock256 or posedge rst256mfb) begin
		if (rst256mfb)
			lock256pos <= 1'b0;
		else	lock256pos <= 1'b1;
	end
	reg lock256posneg;
	always @(negedge lock256 or posedge rst256mfb) begin
		if (rst256mfb)
			lock256posneg <= 1'b0;
		else	lock256posneg <= lock256pos;
	end
	reg LOCKHROSCFAIL;
	always @(posedge lock256posneg or negedge PONRESB) begin
		if (!PONRESB)
			LOCKHROSCFAIL <= 1'b0;
		else	LOCKHROSCFAIL <= 1'b1;
	end

	wire srcrst256 = PONRESB & lock64;
	reg [3:0] rst256msrc;
	always @(posedge CLK64M or negedge srcrst256) begin
		if (!srcrst256)
			rst256msrc <= 4'hf;
		else if (lock64)
			rst256msrc <= {rst256msrc[2:0], lock256posneg};
	end

	// Reset$B2r=|$O(B4Clock$BCY$i$;(BReset$B$KF~$l$k;~$OD>$KF~$l$k!#(B
	assign	rst256m = |rst256msrc;

	DCM256MHZ dcm256m (
		.CLKIN_IN(CLK64M),
		.RST_IN(rst256m),
		.CLKFX_OUT(CLK256M),
		.LOCKED_OUT(lock256)
		);

	reg [2:0] cnt32_duty38_62;
	reg CLK32M;
	always @(posedge CLK256M or negedge PONRESB) begin
		if (!PONRESB) begin
			cnt32_duty38_62 <= 3'h0;
			CLK32M <= 1'b1;
			end
		else if (cnt32_duty38_62 == 3'h2) begin
			cnt32_duty38_62 <= cnt32_duty38_62 + 1;
			CLK32M <= 1'b0;
		end
		else if (cnt32_duty38_62 == 3'h7) begin
			cnt32_duty38_62 <= 3'h0;
			CLK32M <= 1'b1;
		end
		else begin
			cnt32_duty38_62 <= cnt32_duty38_62 + 1;
			CLK32M <= CLK32M;
		end
	end

`else

	reg CLK32M;
	always @(posedge CLK64M or negedge PONRESB) begin
		if (!PONRESB)	CLK32M <= 1'b0;
		else		CLK32M <= ~CLK32M;
	end
	wire	LOCKHROSCFAIL = 1'b0;

`endif	// FPGA_ICE_HRODCM256
`endif	// FPGA_ICE_HRODCM224
`endif	// FPGA_ICE_HRODCM160

//
// 24MHz Clock
//
	reg CLK24M;
	always @(posedge CLK48M or negedge PONRESB) begin
		if (!PONRESB)	CLK24M <= 1'b0;
		else		CLK24M <= ~CLK24M;
	end

`ifdef FPGA_ICE_HRODCM40

	assign	LOCK40FAIL = 1'b0;

	wire CLK40M;
	assign CLK40M = 1'b0;

	wire [5:0] cnt40;
	assign cnt40 = 5'h00;
 
`else
//
// 40MHz Clock
//
	/* ------------------------------------------------------------------------------------	*/
	/* (1)clkin$B6!5k85$N(Block$B$,$+$+$C$F$+$i(B2clock$B0J>e(B(4clock)$B$^$C$F$+$i(Breset$B$r(Bdeassert$B$9$k!#(B	*/
	/* (2)$B<+?H$,(Block$B$7$?$"$H(Block$B$,30$l$?>l9g<+?H$r(BReset$B$9$k!#(BReset$BH/9T8e(B4Clock$B$^$C$F(BReset	*/
	/*    $B2r=|$9$k$?$a(Brst64m$B$r%U%#!<%I%P%C%/!#(B	clock$B%V%m%C%/$N:n$j$K9g$;$?!#(B		*/
	/* (3)clkin$B6!5k85$,(Block$B$7$?>l9g$b(B(2)$B$K9g$;$F(BDCM$B$r(BReset$B$5$;$k!#(B				*/
	/* ------------------------------------------------------------------------------------	*/
	wire rst40mfb = !PONRESB | rst40m;
	reg lock40pos;
	always @(posedge lock40 or posedge rst40mfb) begin
		if (rst40mfb)
			lock40pos <= 1'b0;
		else	lock40pos <= 1'b1;
	end
	reg lock40posneg;
	always @(negedge lock40 or posedge rst40mfb) begin
		if (rst40mfb)
			lock40posneg <= 1'b0;
		else	lock40posneg <= lock40pos;
	end
	reg LOCK40FAIL;
	always @(posedge lock40posneg or negedge PONRESB) begin
		if (!PONRESB)
			LOCK40FAIL <= 1'b0;
		else	LOCK40FAIL <= 1'b1;
	end

	wire srcrst40 = PONRESB & lock64;
	reg [3:0] rst40msrc;
	always @(posedge CLK64M or negedge srcrst40) begin
		if (!srcrst40)
			rst40msrc <= 4'hf;
		else if (lock64)
			rst40msrc <= {rst40msrc[2:0], lock40posneg};
	end

	// Reset$B2r=|$O(B4Clock$BCY$i$;(BReset$B$KF~$l$k;~$OD>$KF~$l$k!#(B
	assign	rst40m = |rst40msrc;

	DCM40MHZ dcm40m (
		.CLKIN_IN(CLK64M),
		.RST_IN(rst40m),
		.CLKFX_OUT(CLK40M),
		.LOCKED(lock40)
		);

//
// $BJ,<~(BClock
//
	reg [4:0] cnt40;
	always @(posedge CLK40M or negedge PONRESB) begin
		if (!PONRESB)		 cnt40 <= 5'h0;
		else if (cnt40 == 5'h1f) cnt40 <= 5'h0;
		else			 cnt40 <= cnt40 + 1;
	end

`endif	// FPGA_ICE_HRODCM40


//
// $BJ,<~(BClock
//
	reg [4:0] cnt24;
	always @(posedge CLK24M or negedge PONRESB) begin
		if (!PONRESB)		 cnt24 <= 5'h0;
		else if (cnt24 == 5'h1f) cnt24 <= 5'h0;
		else			 cnt24 <= cnt24 + 1;
	end

	reg [4:0] cnt32;
	always @(posedge CLK32M or negedge PONRESB) begin
		if (!PONRESB)		 cnt32 <= 5'h0;
		else if (cnt32 == 5'h1f) cnt32 <= 5'h0;
		else			 cnt32 <= cnt32 + 1;
	end



//
// $B=PNO(BSelector
//
	/* --------------------------------------------------------------------	*/
	/* 2010.1.6$B8=:_!"(BDevice$B$N(B32MRing$B$H$7$F@Z$jBX$(;~$K(Bglitch$B$,H/@8$9$k$+$I(B	*/
	/* $B$&$+$N;EMM$,3NDj$7$F$*$i$:!";CDj$G(Bglitch$B$,H/@8$9$k9=@.$H$J$C$F$$$F!"(B	*/
	/* CSC$B$H$7$F$O(Bglitch$B$,H/@8$7$F$b$7$J$/$F$bBP1~$G$-$k$h$&$K$J$C$F$$$k$H(B	*/
	/* $B$N$3$H$r(Bmacro$B@_7W<T$K3NG'$7$?!#(B					*/
	/* --------------------------------------------------------------------	*/
// glitch$B$,H/@8$9$k9=@.(B
`ifdef FPGA_ICE_HROSCSS3RD
	reg clkmux;
	always @(FRQSEL5 or FRQSEL4 or FRQSEL3 or FRQSEL2 or FRQSEL1 or FRQSEL0 or CLK32M or cnt32 or CLK24M or cnt24 or CLK48M or CLK64M or CLK40M or cnt40) begin
		case({FRQSEL5,FRQSEL4,FRQSEL3,FRQSEL2,FRQSEL1,FRQSEL0})
			6'b000000 : clkmux = CLK24M;	// 24MHz
			6'b000001 : clkmux = cnt24[0];	// 12MHz
			6'b000010 : clkmux = cnt24[1];	//  6MHz
			6'b000011 : clkmux = cnt24[2];	//  3MHz
			6'b000100 : clkmux = cnt24[3];	//  1.5MHz
			6'b000101 : clkmux = cnt24[4];	//  0.75MHz
			6'b001000 : clkmux = CLK32M;	// 32MHz
			6'b001001 : clkmux = cnt32[0];	// 16MHz
			6'b001010 : clkmux = cnt32[1];	//  8MHz
			6'b001011 : clkmux = cnt32[2];	//  4MHz
			6'b001100 : clkmux = cnt32[3];	//  2MHz
			6'b001101 : clkmux = cnt32[4];	//  1MHz
			6'b010000 : clkmux = CLK48M;	// 48MHz
			6'b010001 : clkmux = CLK24M;	// 24MHz
			6'b010010 : clkmux = cnt24[0];	// 12MHz
			6'b010011 : clkmux = cnt24[1];	//  6MHz
			6'b010100 : clkmux = cnt24[2];	//  3MHz
			6'b010101 : clkmux = cnt24[3];	//  1.5MHz
			6'b011000 : clkmux = CLK64M;	// 64MHz
			6'b011001 : clkmux = CLK32M;	// 32MHz
			6'b011010 : clkmux = cnt32[0];	// 16MHz
			6'b011011 : clkmux = cnt32[1];	//  8MHz
			6'b011100 : clkmux = cnt32[2];	//  4MHz
			6'b011101 : clkmux = cnt32[3];	//  2MHz
			6'b100000 : clkmux = CLK40M;	// 40MHz
			6'b100001 : clkmux = cnt40[0];	// 20MHz
			6'b100010 : clkmux = cnt40[1];	// 10MHz
			6'b100011 : clkmux = cnt40[2];	//  5MHz
			6'b100100 : clkmux = cnt40[3];	//  2.5MHz
			6'b100101 : clkmux = cnt40[4];	//  1.25MHz
			6'b101000 : clkmux = CLK40M;	// 40MHz
			6'b101001 : clkmux = cnt40[0];	// 20MHz
			6'b101010 : clkmux = cnt40[1];	// 10MHz
			6'b101011 : clkmux = cnt40[2];	//  5MHz
			6'b101100 : clkmux = cnt40[3];	//  2.5MHz
			6'b101101 : clkmux = cnt40[4];	//  1.25MHz
			6'b110000 : clkmux = CLK40M;	// 40MHz
			6'b110001 : clkmux = cnt40[0];	// 20MHz
			6'b110010 : clkmux = cnt40[1];	// 10MHz
			6'b110011 : clkmux = cnt40[2];	//  5MHz
			6'b110100 : clkmux = cnt40[3];	//  2.5MHz
			6'b110101 : clkmux = cnt40[4];	//  1.25MHz
			6'b111000 : clkmux = CLK40M;	// 40MHz
			6'b111001 : clkmux = cnt40[0];	// 20MHz
			6'b111010 : clkmux = cnt40[1];	// 10MHz
			6'b111011 : clkmux = cnt40[2];	//  5MHz
			6'b111100 : clkmux = cnt40[3];	//  2.5MHz
			6'b111101 : clkmux = cnt40[4];	//  1.25MHz
			default  : clkmux = cnt32[4];	//  1MHz ($B4pK\E*$K$3$3$OA*Br$5$l$J$$(B)
		endcase
	end
`else
// glitch$B$,H/@8$7$J$$9=@.(B
	cksel cksel24_a ( .clk1(CLK24M),   .clk2(cnt24[0]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk24_a) );
	cksel cksel24_b ( .clk1(cnt24[1]), .clk2(cnt24[2]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk24_b) );
	cksel cksel24_c ( .clk1(cnt24[3]), .clk2(cnt24[4]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk24_c) );
	cksel cksel24_x ( .clk1(clk24_a),  .clk2(clk24_b),  .sel2(FRQSEL1), .resb(PONRESB), .clkout(clk24_x) );
	cksel cksel24_y ( .clk1(clk24_x),  .clk2(clk24_c),  .sel2(FRQSEL2), .resb(PONRESB), .clkout(clk24_y) );

	cksel cksel32_a ( .clk1(CLK32M),   .clk2(cnt32[0]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk32_a) );
	cksel cksel32_b ( .clk1(cnt32[1]), .clk2(cnt32[2]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk32_b) );
	cksel cksel32_c ( .clk1(cnt32[3]), .clk2(cnt32[4]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk32_c) );
	cksel cksel32_x ( .clk1(clk32_a),  .clk2(clk32_b),  .sel2(FRQSEL1), .resb(PONRESB), .clkout(clk32_x) );
	cksel cksel32_y ( .clk1(clk32_x),  .clk2(clk32_c),  .sel2(FRQSEL2), .resb(PONRESB), .clkout(clk32_y) );

	cksel cksel48_a ( .clk1(CLK48M),   .clk2(CLK24M), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk48_a) );
	cksel cksel48_b ( .clk1(cnt24[0]), .clk2(cnt24[1]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk48_b) );
	cksel cksel48_c ( .clk1(cnt24[2]), .clk2(cnt24[3]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk48_c) );
	cksel cksel48_x ( .clk1(clk48_a),  .clk2(clk48_b),  .sel2(FRQSEL1), .resb(PONRESB), .clkout(clk48_x) );
	cksel cksel48_y ( .clk1(clk48_x),  .clk2(clk48_c),  .sel2(FRQSEL2), .resb(PONRESB), .clkout(clk48_y) );

	cksel cksel64_a ( .clk1(CLK64M),   .clk2(CLK32M), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk64_a) );
	cksel cksel64_b ( .clk1(cnt32[0]), .clk2(cnt32[1]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk64_b) );
	cksel cksel64_c ( .clk1(cnt32[2]), .clk2(cnt32[3]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk64_c) );
	cksel cksel64_x ( .clk1(clk64_a),  .clk2(clk64_b),  .sel2(FRQSEL1), .resb(PONRESB), .clkout(clk64_x) );
	cksel cksel64_y ( .clk1(clk64_x),  .clk2(clk64_c),  .sel2(FRQSEL2), .resb(PONRESB), .clkout(clk64_y) );

	cksel cksel40_a ( .clk1(CLK40M),   .clk2(cnt40[0]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk40_a) );
	cksel cksel40_b ( .clk1(cnt40[1]), .clk2(cnt40[2]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk40_b) );
	cksel cksel40_c ( .clk1(cnt40[3]), .clk2(cnt40[4]), .sel2(FRQSEL0), .resb(PONRESB), .clkout(clk40_c) );
	cksel cksel40_x ( .clk1(clk40_a),  .clk2(clk40_b),  .sel2(FRQSEL1), .resb(PONRESB), .clkout(clk40_x) );
	cksel cksel40_y ( .clk1(clk40_x),  .clk2(clk40_c),  .sel2(FRQSEL2), .resb(PONRESB), .clkout(clk40_y) );

	cksel cksel2432 ( .clk1(clk24_y),  .clk2(clk32_y),  .sel2(FRQSEL3), .resb(PONRESB), .clkout(clk2432) );
	cksel cksel4864 ( .clk1(clk48_y),  .clk2(clk64_y),  .sel2(FRQSEL3), .resb(PONRESB), .clkout(clk4864) );
	cksel cksel2464 ( .clk1(clk2432),  .clk2(clk4864),  .sel2(FRQSEL4), .resb(PONRESB), .clkout(clk2464) );
	cksel ckselmux  ( .clk1(clk2464),  .clk2(clk40_y),  .sel2(FRQSEL5), .resb(PONRESB), .clkout(clkmux)  );
`endif

	assign	R32MOUT = clkmux & ~IOSCSTP;
//	BUFG r32mbufg ( .O(R32MOUT), .I(R32MOUTp) );	// df2.0$B$G;CDjE*$K@)Ls$,E=$i$l$F$$$k(B

	cksel ckselfih2432 ( .clk1(CLK24M),   .clk2(CLK32M),   .sel2(FRQSEL3), .resb(PONRESB), .clkout(fih2432)  );
	cksel ckselfihxx ( .clk1(fih2432),   .clk2(cnt40[0]),   .sel2(FRQSEL5), .resb(PONRESB), .clkout(fihxx)  );
//	cksel ckselfihyy ( .clk1(CLK48M),   .clk2(CLK64M),   .sel2(FRQSEL3), .resb(PONRESB), .clkout(fihyy)  );
//	cksel ckselfihzz ( .clk1(fihxx),    .clk2(fihyy),    .sel2(FRQSEL4), .resb(PONRESB), .clkout(fihzz)  );
	assign	FIHOCD = fihxx & ~IOSCSTP & REQOCD;
	assign	FIHFL = fihxx & ~IOSCSTP & REQFL;	// [1.02]


//
// $BL$;HMQC<;R(B
//
	/*--------------*/
	/* $BF~NO$N$_(B	*/
	/*--------------*/
	// FRQSEL5;		// from pulldown
	// VBGOREG;		// from regm
	// BGIOREG1;		// from regm
	// BGIOREG2;		// from regm
	// OREGSTP;		// from csc
	// POCREL5V;		// from resetb		ICE$B$G$OF~NO85$,B8:_$7$J$$$N$G(BMacro$B$N30$G(BLow Clamp.
	// TSELOREG;		// from csc
	// TSELIRES;		// from csc
	// CTRIM6;		// from cibc
	// CTRIM5;		// from cibc
	// CTRIM4;		// from cibc
	// CTRIM3;		// from cibc
	// CTRIM2;		// from cibc
	// CTRIM1;		// from cibc
	// CTRIM0;		// from cibc
	// RTRIM5;		// from cibc
	// RTRIM4;		// from cibc
	// RTRIM3;		// from cibc
	// RTRIM2;		// from cibc
	// RTRIM1;		// from cibc
	// RTRIM0;		// from cibc
	// EXRTRIM;		// from cibc
	// WTRIM2;		// from cibc
	// WTRIM1;		// from cibc
	// WTRIM0;		// from cibc
	// FTRIM5;		// from cibc
	// FTRIM4;		// from cibc
	// FTRIM3;		// from cibc
	// FTRIM2;		// from cibc
	// FTRIM1;		// from cibc
	// FTRIM0;		// from cibc
	// TTEMP;		// from csc
	/*--------------*/
	/* $B8GDj=PNO(B	*/
	/*--------------*/
	assign	OREGOUT = 1'b0;	// to port4_iobuf	ICE$B$G$O=PNO@h$,B8:_$7$J$$$N$G(BMacro$B$N30$G(BOpen.
	assign	TEMP4 = 1'b0;	// to csc
	assign	TEMP3 = 1'b0;	// to csc
	assign	TEMP2 = 1'b0;	// to csc
	assign	TEMP1 = 1'b0;	// to csc
	assign	TEMP0 = 1'b0;	// to csc

endmodule

/* --------------------------------------------------------------------	*/
/* Clock Selector with NO Glitch.					*/
/*									*/
/* --------------------------------------------------------------------	*/
module cksel (clk1, clk2, sel2, resb, clkout);
	input	clk1, clk2, sel2, resb;
	output	clkout;

	reg clk1mk;
	reg clk2mk;

	always @(negedge clk1 or negedge resb) begin
		if (!resb)	clk1mk <= 1'b0;
		else		clk1mk <= ~sel2 & ~clk2mk;
	end

	always @(negedge clk2 or negedge resb) begin
		if (!resb)	clk2mk <= 1'b0;
		else		clk2mk <= sel2 & ~clk1mk;
	end

	wire	clk1mkout = ~(clk1 & clk1mk);
	wire	clk2mkout = ~(clk2 & clk2mk);
	assign	clkout = ~(clk1mkout & clk2mkout);

endmodule

/* --------------------------------------------------------------------	*/
/* 64MHz DCM								*/
/* Modified from DFLASHDCM8M as Fx3's DataFlash DCM.			*/
/* --------------------------------------------------------------------	*/
module DCM64MHZ (CLKIN_IN, 
                   RST_IN, 
                   CLKFX_OUT,
		   LOCKED);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED;
   
   wire CLKFX_OUT;
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;

// [1.03]
`ifdef FPGA_ICE_VIRTEX5
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), .O(CLKFX_OUT));
`else
   assign CLKFX_OUT = CLKFX_BUF;
`endif

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
                         .LOCKED(LOCKED), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 15;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 32;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 33.333;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
endmodule

/* --------------------------------------------------------------------	*/
/* 48MHz DCM								*/
/* Modified from DFLASHDCM8M as Fx3's DataFlash DCM.			*/
/* --------------------------------------------------------------------	*/
module DCM48MHZ (CLKIN_IN, 
                   RST_IN, 
                   CLKFX_OUT,
		   LOCKED);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED;
   
   wire CLKFX_OUT;
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;

// [1.03]
`ifdef FPGA_ICE_VIRTEX5
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), .O(CLKFX_OUT));
`else
   assign CLKFX_OUT = CLKFX_BUF;
`endif

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
                         .LOCKED(LOCKED), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 2;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 3;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "TRUE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 15.625;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
endmodule

//////////////////////////////////////////////////////////////////////////
//   ____  ____ 							//
//  /   /\/   / 							//
// /___/  \  /    Vendor: Xilinx 					//
// \   \   \/     Version : 11.3					//
//  \   \         Application : xaw2verilog				//
//  /   /         Filename : DCM160MHZ.v				//
// /___/   /\     Timestamp : 04/14/2010 09:33:57			//
// \   \  /  \ 								//
//  \___\/\___\ 							//
//									//
//Device: xc4vlx80-10ff1148						//
//									//
// Module DCM160MHZ							//
// Generated by Xilinx Architecture Wizard				//
// Written for synthesis tool: Synplify					//
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.033 UI	//
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.209 ns	//
//////////////////////////////////////////////////////////////////////////
module DCM160MHZ(CLKIN_IN, 
                 RST_IN, 
                 CLKFX_OUT, 
                 LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire CLKFX_OUT;
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;

`ifdef FPGA_ICE_VIRTEX5
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), .O(CLKFX_OUT));
`else
   assign CLKFX_OUT = CLKFX_BUF;
`endif

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
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 2;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 5;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 15.625;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
endmodule

//////////////////////////////////////////////////////////////////////////
//   ____  ____ 							//
//  /   /\/   / 							//
// /___/  \  /    Vendor: Xilinx 					//
// \   \   \/     Version : 11.3					//
//  \   \         Application : xaw2verilog				//
//  /   /         Filename : DCM224MHZ.v				//
// /___/   /\     Timestamp : 04/14/2010 09:46:30			//
// \   \  /  \ 								//
//  \___\/\___\ 							//
//									//
//Device: xc4vlx80-10ff1148						//
//									//
// Module DCM224MHZ							//
// Generated by Xilinx Architecture Wizard				//
// Written for synthesis tool: Synplify					//
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.047 UI	//
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.209 ns	//
//////////////////////////////////////////////////////////////////////////
module DCM224MHZ(CLKIN_IN, 
                 RST_IN, 
                 CLKFX_OUT, 
                 LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire CLKFX_OUT;
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;

`ifdef FPGA_ICE_VIRTEX5
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), .O(CLKFX_OUT));
`else
   assign CLKFX_OUT = CLKFX_BUF;
`endif

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
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 2;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 7;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 15.625;
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

//////////////////////////////////////////////////////////////////////////
//   ____  ____ 							//
//  /   /\/   / 							//
// /___/  \  /    Vendor: Xilinx 					//
// \   \   \/     Version : 11.3					//
//  \   \         Application : xaw2verilog				//
//  /   /         Filename : DCM256MHZ.v				//
// /___/   /\     Timestamp : 04/14/2010 09:49:01			//
// \   \  /  \ 								//
//  \___\/\___\ 							//
//									//
//Device: xc4vlx80-10ff1148						//
//									//
// Module DCM256MHZ							//
// Generated by Xilinx Architecture Wizard				//
// Written for synthesis tool: Synplify					//
// Period Jitter (unit interval) for block DCM_ADV_INST = 0.051 UI	//
// Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.200 ns	//
//////////////////////////////////////////////////////////////////////////

module DCM256MHZ(CLKIN_IN, 
                 RST_IN, 
                 CLKFX_OUT, 
                 LOCKED_OUT);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED_OUT;
   
   wire CLKFX_OUT;
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;

`ifdef FPGA_ICE_VIRTEX5
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), .O(CLKFX_OUT));
`else
   assign CLKFX_OUT = CLKFX_BUF;
`endif

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
   defparam DCM_ADV_INST.CLKIN_PERIOD = 15.625;
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

/* --------------------------------------------------------------------	*/
/* 40MHz DCM								*/
/* Modified from DFLASHDCM8M as Fx3's DataFlash DCM.			*/
/* --------------------------------------------------------------------	*/
module DCM40MHZ (CLKIN_IN, 
                   RST_IN, 
                   CLKFX_OUT,
		   LOCKED);

    input CLKIN_IN;
    input RST_IN;
   output CLKFX_OUT;
   output LOCKED;
   
   wire CLKFX_OUT;
   wire CLKFX_BUF;
   wire GND_BIT;
   wire [6:0] GND_BUS_7;
   wire [15:0] GND_BUS_16;
   
   assign GND_BIT = 0;
   assign GND_BUS_7 = 7'b0000000;
   assign GND_BUS_16 = 16'b0000000000000000;

// [1.03]
`ifdef FPGA_ICE_VIRTEX5
   BUFG CLKFX_BUFG_INST (.I(CLKFX_BUF), .O(CLKFX_OUT));
`else
   assign CLKFX_OUT = CLKFX_BUF;
`endif

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
                         .LOCKED(LOCKED), 
                         .PSDONE());
   defparam DCM_ADV_INST.CLK_FEEDBACK = "NONE";
   defparam DCM_ADV_INST.CLKDV_DIVIDE = 2.0;
   defparam DCM_ADV_INST.CLKFX_DIVIDE = 8;
   defparam DCM_ADV_INST.CLKFX_MULTIPLY = 5;
   defparam DCM_ADV_INST.CLKIN_DIVIDE_BY_2 = "FALSE";
   defparam DCM_ADV_INST.CLKIN_PERIOD = 15.625;
   defparam DCM_ADV_INST.CLKOUT_PHASE_SHIFT = "NONE";
   defparam DCM_ADV_INST.DCM_AUTOCALIBRATION = "TRUE";
   defparam DCM_ADV_INST.DCM_PERFORMANCE_MODE = "MAX_SPEED";
   defparam DCM_ADV_INST.DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
   defparam DCM_ADV_INST.DFS_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DLL_FREQUENCY_MODE = "LOW";
   defparam DCM_ADV_INST.DUTY_CYCLE_CORRECTION = "TRUE";
   defparam DCM_ADV_INST.FACTORY_JF = 16'hF0F0;
   defparam DCM_ADV_INST.PHASE_SHIFT = 0;
   defparam DCM_ADV_INST.STARTUP_WAIT = "FALSE";
endmodule
