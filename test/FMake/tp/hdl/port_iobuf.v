/* ----------------------------------------------------------------------------	*/
/* For KX4		2010.12.02			Tomonori Tsunoda	*/
/* ----------------------------------------------------------------------------	*/

module port_iobuf (
	P00ENI, P00DIN, P00ENO, P00DOUT, P00, P00PUON, P00PUONOUT,
	P01ENI, P01DIN, P01ENO, P01DOUT, P01, P01SELIN, PTTL01, P01PUON, P01PUONOUT,
	P02ENI, P02DIN, P02ENO, P02DOUT, P02, P02PUON, P02PUONOUT,
	P03ENI, P03DIN, P03ENO, P03DOUT, P03, P03SELIN, PTTL03, P03PUON, P03PUONOUT,
	P04ENI, P04DIN, P04ENO, P04DOUT, P04, P04SELIN, PTTL04, P04PUON, P04PUONOUT,
	P05ENI, P05DIN, P05ENO, P05DOUT, P05, P05PUON, P05PUONOUT,
	P06ENI, P06DIN, P06ENO, P06DOUT, P06, P06PUON, P06PUONOUT,

	P10ENI, P10DIN, P10ENO, P10DOUT, P10, P10SELIN, PTTL10, P10PUON, P10PUONOUT,
	P11ENI, P11DIN, P11ENO, P11DOUT, P11, P11SELIN, PTTL11, P11PUON, P11PUONOUT,
	P12ENI, P12DIN, P12ENO, P12DOUT, P12, P12PUON, P12PUONOUT,
	P13ENI, P13DIN, P13ENO, P13DOUT, P13, P13SELIN, PTTL13, P13PUON, P13PUONOUT,
	P14ENI, P14DIN, P14ENO, P14DOUT, P14, P14SELIN, PTTL14, P14PUON, P14PUONOUT,
	P15ENI, P15DIN, P15ENO, P15DOUT, P15, P15SELIN, PTTL15, P15PUON, P15PUONOUT,
	P16ENI, P16DIN, P16ENO, P16DOUT, P16, P16SELIN, PTTL16, P16PUON, P16PUONOUT,
	P17ENI, P17DIN, P17ENO, P17DOUT, P17, P17SELIN, PTTL17, P17PUON, P17PUONOUT,

	P20ENI, P20DIN, P20ENO, P20DOUT, P20,
	P21ENI, P21DIN, P21ENO, P21DOUT, P21,
	P22ENI, P22DIN, P22ENO, P22DOUT, P22,
	P23ENI, P23DIN, P23ENO, P23DOUT, P23,
	P24ENI, P24DIN, P24ENO, P24DOUT, P24,
	P25ENI, P25DIN, P25ENO, P25DOUT, P25,
	P26ENI, P26DIN, P26ENO, P26DOUT, P26,
	P27ENI, P27DIN, P27ENO, P27DOUT, P27,

	P30ENI, P30DIN, P30ENO, P30DOUT, P30, P30PUON, P30PUONOUT,
	P31ENI, P31DIN, P31ENO, P31DOUT, P31, P31PUON, P31PUONOUT,
	
	P40ENI, P40DIN, P40ENO, P40DOUT, P40, P40PUON, P40PUONOUT,
	P41ENI, P41DIN, P41ENO, P41DOUT, P41, P41PUON, P41PUONOUT,
	P42ENI, P42DIN, P42ENO, P42DOUT, P42, P42PUON, P42PUONOUT,
	P43ENI, P43DIN, P43ENO, P43DOUT, P43, P43PUON, P43PUONOUT,
	
	P50ENI, P50DIN, P50ENO, P50DOUT, P50, P50PUON, P50PUONOUT,
	P51ENI, P51DIN, P51ENO, P51DOUT, P51, P51PUON, P51PUONOUT,
	P52ENI, P52DIN, P52ENO, P52DOUT, P52, P52PUON, P52PUONOUT,
	P53ENI, P53DIN, P53ENO, P53DOUT, P53, P53PUON, P53PUONOUT,
	P54ENI, P54DIN, P54ENO, P54DOUT, P54, P54PUON, P54PUONOUT,
	P55ENI, P55DIN, P55ENO, P55DOUT, P55SELIN, P55, PTTL55, P55PUON, P55PUONOUT,

	P60ENI, P60DIN, P60ENO, P60DOUT, P60,
	P61ENI, P61DIN, P61ENO, P61DOUT, P61,
	P62ENI, P62DIN, P62ENO, P62DOUT, P62,
	P63ENI, P63DIN, P63ENO, P63DOUT, P63,

	P70ENI, P70DIN, P70ENO, P70DOUT, P70, P70PUON, P70PUONOUT,
	P71ENI, P71DIN, P71ENO, P71DOUT, P71, P71PUON, P71PUONOUT,
	P72ENI, P72DIN, P72ENO, P72DOUT, P72, P72PUON, P72PUONOUT,
	P73ENI, P73DIN, P73ENO, P73DOUT, P73, P73PUON, P73PUONOUT,
	P74ENI, P74DIN, P74ENO, P74DOUT, P74, P74PUON, P74PUONOUT,
	P75ENI, P75DIN, P75ENO, P75DOUT, P75, P75PUON, P75PUONOUT,
	P76ENI, P76DIN, P76ENO, P76DOUT, P76, P76PUON, P76PUONOUT,
	P77ENI, P77DIN, P77ENO, P77DOUT, P77, P77PUON, P77PUONOUT,
	
	P120ENI, P120DIN, P120ENO, P120DOUT, P120, P120PUON, P120PUONOUT,

	P130ENO, P130DOUT, P130,
	P137ENI, P137DIN, P137,

	P140ENI, P140DIN, P140ENO, P140DOUT, P140, P140PUON, P140PUONOUT,
	P141ENI, P141DIN, P141ENO, P141DOUT, P141, P141PUON, P141PUONOUT,
	P146ENI, P146DIN, P146ENO, P146DOUT, P146, P146PUON, P146PUONOUT,
	P147ENI, P147DIN, P147ENO, P147DOUT, P147, P147PUON, P147PUONOUT,

	DGEN00, DGEN01, DGEN02, DGEN03, DGEN04, DGEN05, DGEN06, DGEN07,
	PORTEN_B0, PORTEN_B1, PORTEN_B2, PORTEN_B3, PORTEN_B4, PORTEN_B5, PORTEN_B6,
	PORTEN_B7, PORTEN_B16, PORTEN_B17, PORTEN_B18, PORTEN_B19,
	STOPZ, RESFB5V
);

	input	P00ENI, P00ENO, P00DOUT, P00PUON,
		P01ENI, P01ENO, P01DOUT, P01SELIN, PTTL01, P01PUON,
		P02ENI, P02ENO, P02DOUT, P02PUON,
		P03ENI, P03ENO, P03DOUT, P03SELIN, PTTL03, P03PUON,
		P04ENI, P04ENO, P04DOUT, P04SELIN, PTTL04, P04PUON,
		P05ENI, P05ENO, P05DOUT, P05PUON,
		P06ENI, P06ENO, P06DOUT,P06PUON;
	output	P00DIN, P01DIN, P02DIN, P03DIN, P04DIN, P05DIN, P06DIN,
		P00PUONOUT, P01PUONOUT, P02PUONOUT, P03PUONOUT, P04PUONOUT, P05PUONOUT, P06PUONOUT;
	inout	P00, P01, P02, P03, P04, P05, P06;
	
	input	P10ENI, P10ENO, P10DOUT, P10SELIN, PTTL10, P10PUON,
		P11ENI, P11ENO, P11DOUT, P11SELIN, PTTL11, P11PUON,
		P12ENI, P12ENO, P12DOUT, P12PUON,
		P13ENI, P13ENO, P13DOUT, P13SELIN, PTTL13, P13PUON,
		P14ENI, P14ENO, P14DOUT, P14SELIN, PTTL14, P14PUON,
		P15ENI, P15ENO, P15DOUT, P15SELIN, PTTL15, P15PUON,
		P16ENI, P16ENO, P16DOUT, P16SELIN, PTTL16, P16PUON,
		P17ENI, P17ENO, P17DOUT, P17SELIN, PTTL17,P17PUON;
	output	P10DIN, P11DIN, P12DIN, P13DIN, P14DIN, P15DIN, P16DIN, P17DIN,
		P10PUONOUT, P11PUONOUT, P12PUONOUT, P13PUONOUT, P14PUONOUT, P15PUONOUT, P16PUONOUT, P17PUONOUT;
	inout	P10, P11, P12, P13, P14, P15, P16, P17;

	input	P20ENI, P20ENO, P20DOUT,
		P21ENI, P21ENO, P21DOUT,
		P22ENI, P22ENO, P22DOUT,
		P23ENI, P23ENO, P23DOUT,
		P24ENI, P24ENO, P24DOUT,
		P25ENI, P25ENO, P25DOUT,
		P26ENI, P26ENO, P26DOUT,
		P27ENI, P27ENO, P27DOUT;
	output	P20DIN, P21DIN, P22DIN, P23DIN, P24DIN, P25DIN, P26DIN, P27DIN;
	inout	P20, P21, P22, P23, P24, P25, P26, P27;

	input	P30ENI, P30ENO, P30DOUT, P30PUON,
		P31ENI, P31ENO, P31DOUT, P31PUON;
	output	P30DIN, P31DIN,
		P30PUONOUT, P31PUONOUT;
	inout	P30, P31;

	input	P40ENI, P40ENO, P40DOUT, P40PUON,
		P41ENI, P41ENO, P41DOUT, P41PUON,
		P42ENI, P42ENO, P42DOUT, P42PUON,
		P43ENI, P43ENO, P43DOUT, P43PUON;
	output	P40DIN, P41DIN, P42DIN, P43DIN,
		P40PUONOUT, P41PUONOUT, P42PUONOUT, P43PUONOUT;
	inout	P40, P41, P42, P43;

	input	P50ENI, P50ENO, P50DOUT, P50PUON,
		P51ENI, P51ENO, P51DOUT, P51PUON,
		P52ENI, P52ENO, P52DOUT, P52PUON,
		P53ENI, P53ENO, P53DOUT, P53PUON,
		P54ENI, P54ENO, P54DOUT, P54PUON,
		P55ENI, P55ENO, P55DOUT, P55SELIN, PTTL55, P55PUON;
	output	P50DIN, P51DIN, P52DIN, P53DIN, P54DIN, P55DIN,
		P50PUONOUT, P51PUONOUT, P52PUONOUT, P53PUONOUT, P54PUONOUT, P55PUONOUT;
	inout	P50, P51, P52, P53, P54, P55;

	input	P60ENI, P60ENO, P60DOUT,
		P61ENI, P61ENO, P61DOUT,
		P62ENI, P62ENO, P62DOUT,
		P63ENI, P63ENO, P63DOUT;
	output	P60DIN, P61DIN, P62DIN, P63DIN;
	inout	P60, P61, P62, P63;

	input	P70ENI, P70ENO, P70DOUT, P70PUON,
		P71ENI, P71ENO, P71DOUT, P71PUON,
		P72ENI, P72ENO, P72DOUT, P72PUON,
		P73ENI, P73ENO, P73DOUT, P73PUON,
		P74ENI, P74ENO, P74DOUT, P74PUON,
		P75ENI, P75ENO, P75DOUT, P75PUON,
		P76ENI, P76ENO, P76DOUT, P76PUON,
		P77ENI, P77ENO, P77DOUT, P77PUON;
	output	P70DIN, P71DIN, P72DIN, P73DIN, P74DIN, P75DIN, P76DIN, P77DIN,
		P70PUONOUT, P71PUONOUT, P72PUONOUT, P73PUONOUT, P74PUONOUT, P75PUONOUT, P76PUONOUT, P77PUONOUT;
	inout	P70, P71, P72, P73, P74, P75, P76, P77;

	input	P120ENI, P120ENO, P120DOUT, P120PUON;
	output	P120DIN,
		P120PUONOUT;
	inout	P120;

	input	P130ENO, P130DOUT,
		P137ENI, P137;
	output	P137DIN, P130;

	input	P140ENI, P140ENO, P140DOUT, P140PUON,
		P141ENI, P141ENO, P141DOUT, P141PUON,
		P146ENI, P146ENO, P146DOUT, P146PUON,
		P147ENI, P147ENO, P147DOUT, P147PUON;
	output	P140DIN, P141DIN, P146DIN, P147DIN,
		P140PUONOUT, P141PUONOUT, P146PUONOUT, P147PUONOUT;
	inout	P140, P141, P146, P147;


	input	DGEN00, DGEN01, DGEN02, DGEN03, DGEN04, DGEN05, DGEN06, DGEN07;
	output	PORTEN_B0, PORTEN_B1, PORTEN_B2, PORTEN_B3, PORTEN_B4, PORTEN_B5;
	output	PORTEN_B6, PORTEN_B7, PORTEN_B16, PORTEN_B17, PORTEN_B18, PORTEN_B19;
	input	STOPZ, RESFB5V;


	// port0
	QB20HKASAG_ICE P00buf ( .ENI(P00ENI), .DIN(P00DIN), .ENO(P00ENO), .DOUT(P00DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P00) ,.PUON(P00PUON) ,.PUONOUT(P00PUONOUT) );
	QB20GKASAG_ICE P01buf ( .ENI(P01ENI), .DIN(P01DIN), .ENO(P01ENO), .DOUT(P01DOUT), .SELIN0(P01SELIN), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P01), .PTTL(PTTL01) ,.PUON(P01PUON) ,.PUONOUT(P01PUONOUT) );
	QB20HKASAG_ICE P02buf ( .ENI(P02ENI), .DIN(P02DIN), .ENO(P02ENO), .DOUT(P02DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P02) ,.PUON(P02PUON) ,.PUONOUT(P02PUONOUT) );
	QB20GKASAG_ICE P03buf ( .ENI(P03ENI), .DIN(P03DIN), .ENO(P03ENO), .DOUT(P03DOUT), .SELIN0(P03SELIN), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P03), .PTTL(PTTL03) ,.PUON(P03PUON) ,.PUONOUT(P03PUONOUT) );
	QB20GKASAG_ICE P04buf ( .ENI(P04ENI), .DIN(P04DIN), .ENO(P04ENO), .DOUT(P04DOUT), .SELIN0(P04SELIN), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P04), .PTTL(PTTL04) ,.PUON(P04PUON) ,.PUONOUT(P04PUONOUT) );
	QB20HKASAG_ICE P05buf ( .ENI(P05ENI), .DIN(P05DIN), .ENO(P05ENO), .DOUT(P05DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P05) ,.PUON(P05PUON) ,.PUONOUT(P05PUONOUT) );
	QB20HKASAG_ICE P06buf ( .ENI(P06ENI), .DIN(P06DIN), .ENO(P06ENO), .DOUT(P06DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P06) ,.PUON(P06PUON) ,.PUONOUT(P06PUONOUT) );
	
	// port1
	QB20GKASAG_ICE P10buf ( .ENI(P10ENI), .DIN(P10DIN), .ENO(P10ENO), .DOUT(P10DOUT), .SELIN0(P10SELIN), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P10), .PTTL(PTTL10) ,.PUON(P10PUON) ,.PUONOUT(P10PUONOUT) );
	QB20GKASAG_ICE P11buf ( .ENI(P11ENI), .DIN(P11DIN), .ENO(P11ENO), .DOUT(P11DOUT), .SELIN0(P11SELIN), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P11), .PTTL(PTTL11) ,.PUON(P11PUON) ,.PUONOUT(P11PUONOUT) );
	QB20HKASAG_ICE P12buf ( .ENI(P12ENI), .DIN(P12DIN), .ENO(P12ENO), .DOUT(P12DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P12) ,.PUON(P12PUON) ,.PUONOUT(P12PUONOUT) );
	QB20GKASAG_ICE P13buf ( .ENI(P13ENI), .DIN(P13DIN), .ENO(P13ENO), .DOUT(P13DOUT), .SELIN0(P13SELIN), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P13), .PTTL(PTTL13) ,.PUON(P13PUON) ,.PUONOUT(P13PUONOUT) );
	QB20GKASAG_ICE P14buf ( .ENI(P14ENI), .DIN(P14DIN), .ENO(P14ENO), .DOUT(P14DOUT), .SELIN0(P14SELIN), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P14), .PTTL(PTTL14) ,.PUON(P14PUON) ,.PUONOUT(P14PUONOUT) );
	QB20GKASAG_ICE P15buf ( .ENI(P15ENI), .DIN(P15DIN), .ENO(P15ENO), .DOUT(P15DOUT), .SELIN0(P15SELIN), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P15), .PTTL(PTTL15) ,.PUON(P15PUON) ,.PUONOUT(P15PUONOUT) );
	QB20GKASAG_ICE P16buf ( .ENI(P16ENI), .DIN(P16DIN), .ENO(P16ENO), .DOUT(P16DOUT), .SELIN0(P16SELIN), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P16), .PTTL(PTTL16) ,.PUON(P16PUON) ,.PUONOUT(P16PUONOUT) );
	QB20GKASAG_ICE P17buf ( .ENI(P17ENI), .DIN(P17DIN), .ENO(P17ENO), .DOUT(P17DOUT), .SELIN0(P17SELIN), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P17), .PTTL(PTTL17) ,.PUON(P17PUON) ,.PUONOUT(P17PUONOUT) );

	// port2
	QAHAB2000HNV1_ICE P20buf ( .ENI(P20ENI), .DIN(P20DIN), .ENO(P20ENO), .DOUT(P20DOUT), .RTBFG(RESFB5V), .SPAD(P20) );
	QAHAB2001HNV1_ICE P21buf ( .ENI(P21ENI), .DIN(P21DIN), .ENO(P21ENO), .DOUT(P21DOUT), .RTBFG(RESFB5V), .SPAD(P21) );
	QAHAB2002HNV1_ICE P22buf ( .ENI(P22ENI), .DIN(P22DIN), .ENO(P22ENO), .DOUT(P22DOUT), .RTBFG(RESFB5V), .SPAD(P22) );
	QAHAB2003HNV1_ICE P23buf ( .ENI(P23ENI), .DIN(P23DIN), .ENO(P23ENO), .DOUT(P23DOUT), .RTBFG(RESFB5V), .SPAD(P23) );
	QAHAB2004HNV1_ICE P24buf ( .ENI(P24ENI), .DIN(P24DIN), .ENO(P24ENO), .DOUT(P24DOUT), .RTBFG(RESFB5V), .SPAD(P24) );
	QAHAB2005HNV1_ICE P25buf ( .ENI(P25ENI), .DIN(P25DIN), .ENO(P25ENO), .DOUT(P25DOUT), .RTBFG(RESFB5V), .SPAD(P25) );
	QAHAB2006HNV1_ICE P26buf ( .ENI(P26ENI), .DIN(P26DIN), .ENO(P26ENO), .DOUT(P26DOUT), .RTBFG(RESFB5V), .SPAD(P26) );
	QAHAB2007HNV1_ICE P27buf ( .ENI(P27ENI), .DIN(P27DIN), .ENO(P27ENO), .DOUT(P27DOUT), .RTBFG(RESFB5V), .SPAD(P27) );

	// port3
	QB20HKASAG_ICE P30buf ( .ENI(P30ENI), .DIN(P30DIN), .ENO(P30ENO), .DOUT(P30DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P30) ,.PUON(P30PUON) ,.PUONOUT(P30PUONOUT) );
	QB20HKASAG_ICE P31buf ( .ENI(P31ENI), .DIN(P31DIN), .ENO(P31ENO), .DOUT(P31DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P31) ,.PUON(P31PUON) ,.PUONOUT(P31PUONOUT) );

	// port4
	QB20HKASAFG_ICE P40buf ( .ENI(P40ENI), .DIN(P40DIN), .ENO(P40ENO), .DOUT(P40DOUT), .STOPZ(STOPZ), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P40) ,.PUON(P40PUON) ,.PUONOUT(P40PUONOUT) );
	QB20HKASAG_ICE P41buf ( .ENI(P41ENI), .DIN(P41DIN), .ENO(P41ENO), .DOUT(P41DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P41) ,.PUON(P41PUON) ,.PUONOUT(P41PUONOUT) );
	QB20HKASAG_ICE P42buf ( .ENI(P42ENI), .DIN(P42DIN), .ENO(P42ENO), .DOUT(P42DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P42) ,.PUON(P42PUON) ,.PUONOUT(P42PUONOUT) );
	QB20HKASAG_ICE P43buf ( .ENI(P43ENI), .DIN(P43DIN), .ENO(P43ENO), .DOUT(P43DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P43) ,.PUON(P43PUON) ,.PUONOUT(P43PUONOUT) );

	// port5
	QB20HKASAG_ICE P50buf ( .ENI(P50ENI), .DIN(P50DIN), .ENO(P50ENO), .DOUT(P50DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P50) ,.PUON(P50PUON) ,.PUONOUT(P50PUONOUT) );
	QB20HKASAG_ICE P51buf ( .ENI(P51ENI), .DIN(P51DIN), .ENO(P51ENO), .DOUT(P51DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P51) ,.PUON(P51PUON) ,.PUONOUT(P51PUONOUT) );
	QB20HKASAG_ICE P52buf ( .ENI(P52ENI), .DIN(P52DIN), .ENO(P52ENO), .DOUT(P52DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P52) ,.PUON(P52PUON) ,.PUONOUT(P52PUONOUT) );
	QB20HKASAG_ICE P53buf ( .ENI(P53ENI), .DIN(P53DIN), .ENO(P53ENO), .DOUT(P53DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P53) ,.PUON(P53PUON) ,.PUONOUT(P53PUONOUT) );
	QB20HKASAG_ICE P54buf ( .ENI(P54ENI), .DIN(P54DIN), .ENO(P54ENO), .DOUT(P54DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P54) ,.PUON(P54PUON) ,.PUONOUT(P54PUONOUT) );
	QB20GKASAG_ICE P55buf ( .ENI(P55ENI), .DIN(P55DIN), .ENO(P55ENO), .DOUT(P55DOUT), .SELIN0(P55SELIN), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P55), .PTTL(PTTL55) ,.PUON(P55PUON) ,.PUONOUT(P55PUONOUT) );
	
	// port6
	QB003F0G_ICE P60buf ( .ENI(P60ENI), .DIN(P60DIN), .ENO(P60ENO), .DOUT(P60DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P60) );
	QB003F0G_ICE P61buf ( .ENI(P61ENI), .DIN(P61DIN), .ENO(P61ENO), .DOUT(P61DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P61) );
	QB003F0G_ICE P62buf ( .ENI(P62ENI), .DIN(P62DIN), .ENO(P62ENO), .DOUT(P62DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P62) );
	QB003F0G_ICE P63buf ( .ENI(P63ENI), .DIN(P63DIN), .ENO(P63ENO), .DOUT(P63DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P63) );
	
	// port7
	QB20HKASAG_ICE P70buf ( .ENI(P70ENI), .DIN(P70DIN), .ENO(P70ENO), .DOUT(P70DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P70) ,.PUON(P70PUON) ,.PUONOUT(P70PUONOUT) );
	QB20HKASAG_ICE P71buf ( .ENI(P71ENI), .DIN(P71DIN), .ENO(P71ENO), .DOUT(P71DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P71) ,.PUON(P71PUON) ,.PUONOUT(P71PUONOUT) );
	QB20HKASAG_ICE P72buf ( .ENI(P72ENI), .DIN(P72DIN), .ENO(P72ENO), .DOUT(P72DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P72) ,.PUON(P72PUON) ,.PUONOUT(P72PUONOUT) );
	QB20HKASAG_ICE P73buf ( .ENI(P73ENI), .DIN(P73DIN), .ENO(P73ENO), .DOUT(P73DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P73) ,.PUON(P73PUON) ,.PUONOUT(P73PUONOUT) );
	QB20HKASAG_ICE P74buf ( .ENI(P74ENI), .DIN(P74DIN), .ENO(P74ENO), .DOUT(P74DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P74) ,.PUON(P74PUON) ,.PUONOUT(P74PUONOUT) );
	QB20HKASAG_ICE P75buf ( .ENI(P75ENI), .DIN(P75DIN), .ENO(P75ENO), .DOUT(P75DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P75) ,.PUON(P75PUON) ,.PUONOUT(P75PUONOUT) );
	QB20HKASAG_ICE P76buf ( .ENI(P76ENI), .DIN(P76DIN), .ENO(P76ENO), .DOUT(P76DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P76) ,.PUON(P76PUON) ,.PUONOUT(P76PUONOUT) );
	QB20HKASAG_ICE P77buf ( .ENI(P77ENI), .DIN(P77DIN), .ENO(P77ENO), .DOUT(P77DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P77) ,.PUON(P77PUON) ,.PUONOUT(P77PUONOUT) );
	
	// port12
	QB20HKASAG_ICE P120buf ( .ENI(P120ENI), .DIN(P120DIN), .ENO(P120ENO), .DOUT(P120DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P120) ,.PUON(P120PUON) ,.PUONOUT(P120PUONOUT) );
	
	// port13
	QO200KALZ_ICE P130buf ( .ENO(P130ENO), .DOUT(P130DOUT), .RTBFG(RESFB5V), .SPAD(P130) );
	QIFLVPP15_ICE P137buf ( .DIN(P137DIN), .ENI(P137ENI), .SPAD(P137) );
	
	// port14
	QB20HKASAG_ICE P140buf ( .ENI(P140ENI), .DIN(P140DIN), .ENO(P140ENO), .DOUT(P140DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P140) ,.PUON(P140PUON) ,.PUONOUT(P140PUONOUT) );
	QB20HKASAG_ICE P141buf ( .ENI(P141ENI), .DIN(P141DIN), .ENO(P141ENO), .DOUT(P141DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P141) ,.PUON(P141PUON) ,.PUONOUT(P141PUONOUT) );
	QB20HKASAG_ICE P146buf ( .ENI(P146ENI), .DIN(P146DIN), .ENO(P146ENO), .DOUT(P146DOUT), .STOPZG(STOPZG), .RTBFG(RESFB5V), .SPAD(P146) ,.PUON(P146PUON) ,.PUONOUT(P146PUONOUT) );
	wire STOPZG_DMY;
	QB20HKASAFG_ICE P147buf ( .ENI(P147ENI), .DIN(P147DIN), .ENO(P147ENO), .DOUT(P147DOUT), .STOPZ(STOPZ), .STOPZG(STOPZG_DMY), .RTBFG(RESFB5V), .SPAD(P147) ,.PUON(P147PUON) ,.PUONOUT(P147PUONOUT) );

	// [A/D Port Disable Category VDD]
	assign	PORTEN_B0 = ~DGEN00;
	assign	PORTEN_B1 = ~DGEN01;
	assign	PORTEN_B2 = ~DGEN02;
	assign	PORTEN_B3 = ~DGEN03;
	assign	PORTEN_B4 = ~DGEN04;
	assign	PORTEN_B5 = ~DGEN05;
	assign	PORTEN_B6 = ~DGEN06;
	assign	PORTEN_B7 = ~DGEN07;

	// [A/D Port Disable Category EVDD]
	assign	PORTEN_B16 = ~P03ENI;
	assign	PORTEN_B17 = ~P02ENI;
	assign	PORTEN_B18 = ~P147ENI;
	assign	PORTEN_B19 = ~P120ENI;

endmodule

/* ----------------------------------------------------------------------------	*/
/* ・STOPZGはGlobal信号なので,DeviceのHDL上は見えないが,物理的には存在する。	*/
/* ・DeviceではCMOS3とのBuffer Type切り替え信号のSELIN1B5Vが存在するが,		*/
/*   ICEでは制限とするのでHDLから省く。						*/
/* ----------------------------------------------------------------------------	*/
module QB20HKASAG_ICE ( ENI, DIN, ENO, DOUT, STOPZG, RTBFG, SPAD, PUON, PUONOUT );
	input	ENI, ENO, DOUT, STOPZG, RTBFG, PUON;
	output	DIN, PUONOUT;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	assign	DIN = SPAD & ENI & STOPZG;
	assign	PUONOUT = PUON & RTBFG;

endmodule

/* ----------------------------------------------------------------------------	*/
/* ・STOPZGはGlobal信号なので,DeviceのHDL上は見えないが,物理的には存在する。	*/
/* ・DeviceではCMOS3とのBuffer Type切り替え信号のSELIN1B5Vが存在するが,		*/
/*   ICEでは制限とするのでHDLから省く。						*/
/* ・SELIN0は1でTTL選択。							*/
/* ----------------------------------------------------------------------------	*/
module QB20GKASAG_ICE ( ENI, DIN, ENO, DOUT, SELIN0, STOPZG, RTBFG, SPAD, PTTL, PUON, PUONOUT );
	input	ENI, ENO, DOUT, SELIN0, STOPZG, RTBFG, PTTL, PUON;
	output	DIN, PUONOUT;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	wire	DIN_pre = SELIN0 ? PTTL & ENI : SPAD & ENI;
	assign	DIN = DIN_pre & STOPZG;
	assign	PUONOUT = PUON & RTBFG;

endmodule

/* ----------------------------------------------------------------------------	*/
/* ・STOPZGはGlobal信号なので,DeviceのHDL上は見えないが,物理的には存在する。	*/
/*   このBufferからDriveする仕様なので,ICEでも実仕様に合せる(STOPZG=STOPZ)。	*/
/* ・DeviceではCMOS3とのBuffer Type切り替え信号のSELIN1B5Vが存在するが,		*/
/*   ICEでは制限とするのでHDLから省く。						*/
/* ----------------------------------------------------------------------------	*/
module QB20HKASAFG_ICE ( ENI, DIN, ENO, DOUT, STOPZ, STOPZG, RTBFG, SPAD, PUON, PUONOUT );
	input	ENI, ENO, DOUT, STOPZ, RTBFG, PUON;
	output	DIN, STOPZG, PUONOUT;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	assign	DIN = SPAD & ENI & STOPZG;
	assign	STOPZG = STOPZ;
	assign	PUONOUT = PUON & RTBFG;

endmodule

module QAHAB2000HNV1_ICE ( ENI, DIN, ENO, DOUT, RTBFG, SPAD );
	input	ENI, ENO, DOUT, RTBFG;
	output	DIN;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	assign	DIN = SPAD & ENI;
endmodule

module QAHAB2001HNV1_ICE ( ENI, DIN, ENO, DOUT, RTBFG, SPAD );
	input	ENI, ENO, DOUT, RTBFG;
	output	DIN;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	assign	DIN = SPAD & ENI;
endmodule

module QAHAB2002HNV1_ICE ( ENI, DIN, ENO, DOUT, RTBFG, SPAD );
	input	ENI, ENO, DOUT, RTBFG;
	output	DIN;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	assign	DIN = SPAD & ENI;
endmodule

module QAHAB2003HNV1_ICE ( ENI, DIN, ENO, DOUT, RTBFG, SPAD );
	input	ENI, ENO, DOUT, RTBFG;
	output	DIN;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	assign	DIN = SPAD & ENI;
endmodule

module QAHAB2004HNV1_ICE ( ENI, DIN, ENO, DOUT, RTBFG, SPAD );
	input	ENI, ENO, DOUT, RTBFG;
	output	DIN;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	assign	DIN = SPAD & ENI;
endmodule

module QAHAB2005HNV1_ICE ( ENI, DIN, ENO, DOUT, RTBFG, SPAD );
	input	ENI, ENO, DOUT, RTBFG;
	output	DIN;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	assign	DIN = SPAD & ENI;
endmodule

module QAHAB2006HNV1_ICE ( ENI, DIN, ENO, DOUT, RTBFG, SPAD );
	input	ENI, ENO, DOUT, RTBFG;
	output	DIN;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	assign	DIN = SPAD & ENI;
endmodule

module QAHAB2007HNV1_ICE ( ENI, DIN, ENO, DOUT, RTBFG, SPAD );
	input	ENI, ENO, DOUT, RTBFG;
	output	DIN;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	assign	DIN = SPAD & ENI;
endmodule

/* ----------------------------------------------------------------------------	*/
/* for Nch OD. HI出力時はENOが0になるようport macroで制御されているという前提。	*/
/* ----------------------------------------------------------------------------	*/
module QB003F0G_ICE ( ENI, DIN, ENO, DOUT, STOPZG, RTBFG, SPAD );
	input	ENI, ENO, DOUT, STOPZG, RTBFG;
	output	DIN;
	inout	SPAD;

	assign	SPAD = (RTBFG & ENO) ? DOUT : 1'bz;
	assign	DIN = SPAD & ENI & STOPZG;
endmodule

/* ----------------------------------------------------------------------------	*/
/* ・ENO=0ではHi-z								*/
/* ・DeviceではSPADがIO PinだがFunction的にOutのみなので ICEではOutとしておく。	*/
/* ・このBufferはRTBFG Active時にSPAD=0となる。					*/
/* ----------------------------------------------------------------------------	*/
module QO200KALZ_ICE ( ENO, DOUT, SPAD, RTBFG );
	input	ENO, DOUT, RTBFG;
	output	SPAD;
	
	wire	SPAD_pre = (ENO) ? DOUT : 1'bz;
	assign	SPAD = SPAD_pre & RTBFG;
endmodule

/* ----------------------------------------------------------------------------	*/
/* ・DeviceにはDISEN, POCREL5Vという入力端子があるが,これらの値によってDINは	*/
/*   影響を受けないのでICEでは使わない。					*/
/* ・DeviceにはVPPTS1が接続されているが,接続先のFlashCPはVPPTS1をICE用に0固定	*/
/*   出力に置き換えており,ICEでは使わない。					*/
/* ----------------------------------------------------------------------------	*/
module QIFLVPP15_ICE ( DIN, ENI, SPAD );
	input	ENI;
	output	DIN;
	input	SPAD;

	assign	DIN = SPAD & ENI;
endmodule

