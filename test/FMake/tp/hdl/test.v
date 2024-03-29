// Ver1.0:New	takahiro.kobayashi@nms	2005.11

module TESTCTL (
	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28,
	ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
	ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,
	ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
	ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,
	ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0,
	ICEDO31, ICEDO30, ICEDO29, ICEDO28,
	ICEDO27, ICEDO26, ICEDO25, ICEDO24,
	ICEDO23, ICEDO22, ICEDO21, ICEDO20,
	ICEDO19, ICEDO18, ICEDO17, ICEDO16,
	ICEDO15, ICEDO14, ICEDO13, ICEDO12,
	ICEDO11, ICEDO10, ICEDO9,  ICEDO8,
	ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,
	ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0,
	ADDRTD144, ADDRTD143, ADDRTD142, ADDRTD141,
	ADDRTD140, ADDRTD139, ADDRTD138, ADDRTD137,
	ADDRTD136, ADDRTD135, ADDRTD134, ADDRTD133,
	ADDRTD132, ADDRTD131, ADDRTD130, ADDRTD129,
	ADDRTD128, ADDRTD127, ADDRTD126, ADDRTD125,
	ADDRTD124, ADDRTD123, ADDRTD122, ADDRTD121,
	ADDRTD120, ADDRTD119, ADDRTD118, ADDRTD117,
	ADDRTD116, ADDRTD115, ADDRTD114, ADDRTD113,
	ADDRTD112, ADDRTD111, ADDRTD110, ADDRTD109,
	ADDRTD108, ADDRTD107, ADDRTD106, ADDRTD105,
	ADDRTD104, ADDRTD103, ADDRTD102, ADDRTD101,
	ADDRTD100, ADDRTD99, ADDRTD98, ADDRTD97,
	ADDRTD96, ADDRTD95, ADDRTD94, ADDRTD93,
	ADDRTD92, ADDRTD91, ADDRTD90, ADDRTD89,
	ADDRTD88, ADDRTD87, ADDRTD86, ADDRTD85,
	ADDRTD84, ADDRTD83, ADDRTD82, ADDRTD81,
	ADDRTD80, ADDRTD79, ADDRTD78, ADDRTD77,
	ADDRTD76, ADDRTD75, ADDRTD74, ADDRTD73,
	ADDRTD72, ADDRTD71, ADDRTD70, ADDRTD69,
	ADDRTD68, ADDRTD67, ADDRTD66, ADDRTD65,
	ADDRTD64, ADDRTD63, ADDRTD62, ADDRTD61,
	ADDRTD60, ADDRTD59, ADDRTD58, ADDRTD57,
	ADDRTD56, ADDRTD55, ADDRTD54, ADDRTD53,
	ADDRTD52, ADDRTD51, ADDRTD50, ADDRTD49,
	ADDRTD48, ADDRTD47, ADDRTD46, ADDRTD45,
	ADDRTD44, ADDRTD43, ADDRTD42, ADDRTD41,
	ADDRTD40, ADDRTD39, ADDRTD38, ADDRTD37,
	ADDRTD36, ADDRTD35, ADDRTD34, ADDRTD33,
	ADDRTD32, ADDRTD31, ADDRTD30, ADDRTD29,
	ADDRTD28, ADDRTD27, ADDRTD26, ADDRTD25,
	ADDRTD24, ADDRTD23, ADDRTD22, ADDRTD21,
	ADDRTD20, ADDRTD19, ADDRTD18, ADDRTD17,
	ADDRTD16, ADDRTD15, ADDRTD14, ADDRTD13,
	ADDRTD12, ADDRTD11, ADDRTD10, ADDRTD9,
	ADDRTD8, ADDRTD7, ADDRTD6, ADDRTD5,
	ADDRTD4, ADDRTD3, ADDRTD2, ADDRTD1,
	ADDRICE11, ADDRICE10, ADDRICE9, ADDRICE8,
	ADDRICE7, ADDRICE6, ADDRICE5, ADDRICE4,
	ADDRICE3, ADDRICE2, ADDRICE1, ADDRICE0,
	ADDRPINRD, ADDRPINMD, ADDRPINLV,
	TP144D3, TP144D2, TP144D1, TP144D0,
	TP143D3, TP143D2, TP143D1, TP143D0,
	TP142D3, TP142D2, TP142D1, TP142D0,
	TP141D3, TP141D2, TP141D1, TP141D0,
	TP140D3, TP140D2, TP140D1, TP140D0,
	TP139D3, TP139D2, TP139D1, TP139D0,
	TP138D3, TP138D2, TP138D1, TP138D0,
	TP137D3, TP137D2, TP137D1, TP137D0,
	TP136D3, TP136D2, TP136D1, TP136D0,
	TP135D3, TP135D2, TP135D1, TP135D0,
	TP134D3, TP134D2, TP134D1, TP134D0,
	TP133D3, TP133D2, TP133D1, TP133D0,
	TP132D3, TP132D2, TP132D1, TP132D0,
	TP131D3, TP131D2, TP131D1, TP131D0,
	TP130D3, TP130D2, TP130D1, TP130D0,
	TP129D3, TP129D2, TP129D1, TP129D0,
	TP128D3, TP128D2, TP128D1, TP128D0,
	TP127D3, TP127D2, TP127D1, TP127D0,
	TP126D3, TP126D2, TP126D1, TP126D0,
	TP125D3, TP125D2, TP125D1, TP125D0,
	TP124D3, TP124D2, TP124D1, TP124D0,
	TP123D3, TP123D2, TP123D1, TP123D0,
	TP122D3, TP122D2, TP122D1, TP122D0,
	TP121D3, TP121D2, TP121D1, TP121D0,
	TP120D3, TP120D2, TP120D1, TP120D0,
	TP119D3, TP119D2, TP119D1, TP119D0,
	TP118D3, TP118D2, TP118D1, TP118D0,
	TP117D3, TP117D2, TP117D1, TP117D0,
	TP116D3, TP116D2, TP116D1, TP116D0,
	TP115D3, TP115D2, TP115D1, TP115D0,
	TP114D3, TP114D2, TP114D1, TP114D0,
	TP113D3, TP113D2, TP113D1, TP113D0,
	TP112D3, TP112D2, TP112D1, TP112D0,
	TP111D3, TP111D2, TP111D1, TP111D0,
	TP110D3, TP110D2, TP110D1, TP110D0,
	TP109D3, TP109D2, TP109D1, TP109D0,
	TP108D3, TP108D2, TP108D1, TP108D0,
	TP107D3, TP107D2, TP107D1, TP107D0,
	TP106D3, TP106D2, TP106D1, TP106D0,
	TP105D3, TP105D2, TP105D1, TP105D0,
	TP104D3, TP104D2, TP104D1, TP104D0,
	TP103D3, TP103D2, TP103D1, TP103D0,
	TP102D3, TP102D2, TP102D1, TP102D0,
	TP101D3, TP101D2, TP101D1, TP101D0,
	TP100D3, TP100D2, TP100D1, TP100D0,
	TP99D3, TP99D2, TP99D1, TP99D0,
	TP98D3, TP98D2, TP98D1, TP98D0,
	TP97D3, TP97D2, TP97D1, TP97D0,
	TP96D3, TP96D2, TP96D1, TP96D0,
	TP95D3, TP95D2, TP95D1, TP95D0,
	TP94D3, TP94D2, TP94D1, TP94D0,
	TP93D3, TP93D2, TP93D1, TP93D0,
	TP92D3, TP92D2, TP92D1, TP92D0,
	TP91D3, TP91D2, TP91D1, TP91D0,
	TP90D3, TP90D2, TP90D1, TP90D0,
	TP89D3, TP89D2, TP89D1, TP89D0,
	TP88D3, TP88D2, TP88D1, TP88D0,
	TP87D3, TP87D2, TP87D1, TP87D0,
	TP86D3, TP86D2, TP86D1, TP86D0,
	TP85D3, TP85D2, TP85D1, TP85D0,
	TP84D3, TP84D2, TP84D1, TP84D0,
	TP83D3, TP83D2, TP83D1, TP83D0,
	TP82D3, TP82D2, TP82D1, TP82D0,
	TP81D3, TP81D2, TP81D1, TP81D0,
	TP80D3, TP80D2, TP80D1, TP80D0,
	TP79D3, TP79D2, TP79D1, TP79D0,
	TP78D3, TP78D2, TP78D1, TP78D0,
	TP77D3, TP77D2, TP77D1, TP77D0,
	TP76D3, TP76D2, TP76D1, TP76D0,
	TP75D3, TP75D2, TP75D1, TP75D0,
	TP74D3, TP74D2, TP74D1, TP74D0,
	TP73D3, TP73D2, TP73D1, TP73D0,
	TP72D3, TP72D2, TP72D1, TP72D0,
	TP71D3, TP71D2, TP71D1, TP71D0,
	TP70D3, TP70D2, TP70D1, TP70D0,
	TP69D3, TP69D2, TP69D1, TP69D0,
	TP68D3, TP68D2, TP68D1, TP68D0,
	TP67D3, TP67D2, TP67D1, TP67D0,
	TP66D3, TP66D2, TP66D1, TP66D0,
	TP65D3, TP65D2, TP65D1, TP65D0,
	TP64D3, TP64D2, TP64D1, TP64D0,
	TP63D3, TP63D2, TP63D1, TP63D0,
	TP62D3, TP62D2, TP62D1, TP62D0,
	TP61D3, TP61D2, TP61D1, TP61D0,
	TP60D3, TP60D2, TP60D1, TP60D0,
	TP59D3, TP59D2, TP59D1, TP59D0,
	TP58D3, TP58D2, TP58D1, TP58D0,
	TP57D3, TP57D2, TP57D1, TP57D0,
	TP56D3, TP56D2, TP56D1, TP56D0,
	TP55D3, TP55D2, TP55D1, TP55D0,
	TP54D3, TP54D2, TP54D1, TP54D0,
	TP53D3, TP53D2, TP53D1, TP53D0,
	TP52D3, TP52D2, TP52D1, TP52D0,
	TP51D3, TP51D2, TP51D1, TP51D0,
	TP50D3, TP50D2, TP50D1, TP50D0,
	TP49D3, TP49D2, TP49D1, TP49D0,
	TP48D3, TP48D2, TP48D1, TP48D0,
	TP47D3, TP47D2, TP47D1, TP47D0,
	TP46D3, TP46D2, TP46D1, TP46D0,
	TP45D3, TP45D2, TP45D1, TP45D0,
	TP44D3, TP44D2, TP44D1, TP44D0,
	TP43D3, TP43D2, TP43D1, TP43D0,
	TP42D3, TP42D2, TP42D1, TP42D0,
	TP41D3, TP41D2, TP41D1, TP41D0,
	TP40D3, TP40D2, TP40D1, TP40D0,
	TP39D3, TP39D2, TP39D1, TP39D0,
	TP38D3, TP38D2, TP38D1, TP38D0,
	TP37D3, TP37D2, TP37D1, TP37D0,
	TP36D3, TP36D2, TP36D1, TP36D0,
	TP35D3, TP35D2, TP35D1, TP35D0,
	TP34D3, TP34D2, TP34D1, TP34D0,
	TP33D3, TP33D2, TP33D1, TP33D0,
	TP32D3, TP32D2, TP32D1, TP32D0,
	TP31D3, TP31D2, TP31D1, TP31D0,
	TP30D3, TP30D2, TP30D1, TP30D0,
	TP29D3, TP29D2, TP29D1, TP29D0,
	TP28D3, TP28D2, TP28D1, TP28D0,
	TP27D3, TP27D2, TP27D1, TP27D0,
	TP26D3, TP26D2, TP26D1, TP26D0,
	TP25D3, TP25D2, TP25D1, TP25D0,
	TP24D3, TP24D2, TP24D1, TP24D0,
	TP23D3, TP23D2, TP23D1, TP23D0,
	TP22D3, TP22D2, TP22D1, TP22D0,
	TP21D3, TP21D2, TP21D1, TP21D0,
	TP20D3, TP20D2, TP20D1, TP20D0,
	TP19D3, TP19D2, TP19D1, TP19D0,
	TP18D3, TP18D2, TP18D1, TP18D0,
	TP17D3, TP17D2, TP17D1, TP17D0,
	TP16D3, TP16D2, TP16D1, TP16D0,
	TP15D3, TP15D2, TP15D1, TP15D0,
	TP14D3, TP14D2, TP14D1, TP14D0,
	TP13D3, TP13D2, TP13D1, TP13D0,
	TP12D3, TP12D2, TP12D1, TP12D0,
	TP11D3, TP11D2, TP11D1, TP11D0,
	TP10D3, TP10D2, TP10D1, TP10D0,
	TP9D3, TP9D2, TP9D1, TP9D0,
	TP8D3, TP8D2, TP8D1, TP8D0,
	TP7D3, TP7D2, TP7D1, TP7D0,
	TP6D3, TP6D2, TP6D1, TP6D0,
	TP5D3, TP5D2, TP5D1, TP5D0,
	TP4D3, TP4D2, TP4D1, TP4D0,
	TP3D3, TP3D2, TP3D1, TP3D0,
	TP2D3, TP2D2, TP2D1, TP2D0,
	TP1D3, TP1D2, TP1D1, TP1D0,
	TI11D3, TI11D2, TI11D1, TI11D0,
	TI10D3, TI10D2, TI10D1, TI10D0,
	TI9D3, TI9D2, TI9D1, TI9D0,
	TI8D3, TI8D2, TI8D1, TI8D0,
	TI7D3, TI7D2, TI7D1, TI7D0,
	TI6D3, TI6D2, TI6D1, TI6D0,
	TI5D3, TI5D2, TI5D1, TI5D0,
	TI4D3, TI4D2, TI4D1, TI4D0,
	TI3D3, TI3D2, TI3D1, TI3D0,
	TI2D3, TI2D2, TI2D1, TI2D0,
	TI1D3, TI1D2, TI1D1, TI1D0,
	TI0D3, TI0D2, TI0D1, TI0D0
);

	input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, // Host I/F address bus
			ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
			ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,
			ICEIFA11, ICEIFA10, ICEIFA9,  ICEIFA8,
			ICEIFA7,  ICEIFA6,  ICEIFA5,  ICEIFA4,
			ICEIFA3,  ICEIFA2,  ICEIFA1,  ICEIFA0;
	output	ICEDO31, ICEDO30, ICEDO29, ICEDO28, // Host I/F read data bus
			ICEDO27, ICEDO26, ICEDO25, ICEDO24,
			ICEDO23, ICEDO22, ICEDO21, ICEDO20,
			ICEDO19, ICEDO18, ICEDO17, ICEDO16,
			ICEDO15, ICEDO14, ICEDO13, ICEDO12,
			ICEDO11, ICEDO10, ICEDO9,  ICEDO8,
			ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,
			ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0;
	output	ADDRTD144, ADDRTD143, ADDRTD142, ADDRTD141,
		ADDRTD140, ADDRTD139, ADDRTD138, ADDRTD137,
		ADDRTD136, ADDRTD135, ADDRTD134, ADDRTD133,
		ADDRTD132, ADDRTD131, ADDRTD130, ADDRTD129,
		ADDRTD128, ADDRTD127, ADDRTD126, ADDRTD125,
		ADDRTD124, ADDRTD123, ADDRTD122, ADDRTD121,
		ADDRTD120, ADDRTD119, ADDRTD118, ADDRTD117,
		ADDRTD116, ADDRTD115, ADDRTD114, ADDRTD113,
		ADDRTD112, ADDRTD111, ADDRTD110, ADDRTD109,
		ADDRTD108, ADDRTD107, ADDRTD106, ADDRTD105,
		ADDRTD104, ADDRTD103, ADDRTD102, ADDRTD101,
		ADDRTD100, ADDRTD99, ADDRTD98, ADDRTD97,
		ADDRTD96, ADDRTD95, ADDRTD94, ADDRTD93,
		ADDRTD92, ADDRTD91, ADDRTD90, ADDRTD89,
		ADDRTD88, ADDRTD87, ADDRTD86, ADDRTD85,
		ADDRTD84, ADDRTD83, ADDRTD82, ADDRTD81,
		ADDRTD80, ADDRTD79, ADDRTD78, ADDRTD77,
		ADDRTD76, ADDRTD75, ADDRTD74, ADDRTD73,
		ADDRTD72, ADDRTD71, ADDRTD70, ADDRTD69,
		ADDRTD68, ADDRTD67, ADDRTD66, ADDRTD65,
		ADDRTD64, ADDRTD63, ADDRTD62, ADDRTD61,
		ADDRTD60, ADDRTD59, ADDRTD58, ADDRTD57,
		ADDRTD56, ADDRTD55, ADDRTD54, ADDRTD53,
		ADDRTD52, ADDRTD51, ADDRTD50, ADDRTD49,
		ADDRTD48, ADDRTD47, ADDRTD46, ADDRTD45,
		ADDRTD44, ADDRTD43, ADDRTD42, ADDRTD41,
		ADDRTD40, ADDRTD39, ADDRTD38, ADDRTD37,
		ADDRTD36, ADDRTD35, ADDRTD34, ADDRTD33,
		ADDRTD32, ADDRTD31, ADDRTD30, ADDRTD29,
		ADDRTD28, ADDRTD27, ADDRTD26, ADDRTD25,
		ADDRTD24, ADDRTD23, ADDRTD22, ADDRTD21,
		ADDRTD20, ADDRTD19, ADDRTD18, ADDRTD17,
		ADDRTD16, ADDRTD15, ADDRTD14, ADDRTD13,
		ADDRTD12, ADDRTD11, ADDRTD10, ADDRTD9,
		ADDRTD8, ADDRTD7, ADDRTD6, ADDRTD5,
		ADDRTD4, ADDRTD3, ADDRTD2, ADDRTD1,
		ADDRICE11, ADDRICE10, ADDRICE9, ADDRICE8,
		ADDRICE7, ADDRICE6, ADDRICE5, ADDRICE4,
		ADDRICE3, ADDRICE2, ADDRICE1, ADDRICE0,
		ADDRPINRD, ADDRPINMD, ADDRPINLV;
	input	TP144D3, TP144D2, TP144D1, TP144D0,
		TP143D3, TP143D2, TP143D1, TP143D0,
		TP142D3, TP142D2, TP142D1, TP142D0,
		TP141D3, TP141D2, TP141D1, TP141D0,
		TP140D3, TP140D2, TP140D1, TP140D0,
		TP139D3, TP139D2, TP139D1, TP139D0,
		TP138D3, TP138D2, TP138D1, TP138D0,
		TP137D3, TP137D2, TP137D1, TP137D0,
		TP136D3, TP136D2, TP136D1, TP136D0,
		TP135D3, TP135D2, TP135D1, TP135D0,
		TP134D3, TP134D2, TP134D1, TP134D0,
		TP133D3, TP133D2, TP133D1, TP133D0,
		TP132D3, TP132D2, TP132D1, TP132D0,
		TP131D3, TP131D2, TP131D1, TP131D0,
		TP130D3, TP130D2, TP130D1, TP130D0,
		TP129D3, TP129D2, TP129D1, TP129D0,
		TP128D3, TP128D2, TP128D1, TP128D0,
		TP127D3, TP127D2, TP127D1, TP127D0,
		TP126D3, TP126D2, TP126D1, TP126D0,
		TP125D3, TP125D2, TP125D1, TP125D0,
		TP124D3, TP124D2, TP124D1, TP124D0,
		TP123D3, TP123D2, TP123D1, TP123D0,
		TP122D3, TP122D2, TP122D1, TP122D0,
		TP121D3, TP121D2, TP121D1, TP121D0,
		TP120D3, TP120D2, TP120D1, TP120D0,
		TP119D3, TP119D2, TP119D1, TP119D0,
		TP118D3, TP118D2, TP118D1, TP118D0,
		TP117D3, TP117D2, TP117D1, TP117D0,
		TP116D3, TP116D2, TP116D1, TP116D0,
		TP115D3, TP115D2, TP115D1, TP115D0,
		TP114D3, TP114D2, TP114D1, TP114D0,
		TP113D3, TP113D2, TP113D1, TP113D0,
		TP112D3, TP112D2, TP112D1, TP112D0,
		TP111D3, TP111D2, TP111D1, TP111D0,
		TP110D3, TP110D2, TP110D1, TP110D0,
		TP109D3, TP109D2, TP109D1, TP109D0,
		TP108D3, TP108D2, TP108D1, TP108D0,
		TP107D3, TP107D2, TP107D1, TP107D0,
		TP106D3, TP106D2, TP106D1, TP106D0,
		TP105D3, TP105D2, TP105D1, TP105D0,
		TP104D3, TP104D2, TP104D1, TP104D0,
		TP103D3, TP103D2, TP103D1, TP103D0,
		TP102D3, TP102D2, TP102D1, TP102D0,
		TP101D3, TP101D2, TP101D1, TP101D0,
		TP100D3, TP100D2, TP100D1, TP100D0,
		TP99D3, TP99D2, TP99D1, TP99D0,
		TP98D3, TP98D2, TP98D1, TP98D0,
		TP97D3, TP97D2, TP97D1, TP97D0,
		TP96D3, TP96D2, TP96D1, TP96D0,
		TP95D3, TP95D2, TP95D1, TP95D0,
		TP94D3, TP94D2, TP94D1, TP94D0,
		TP93D3, TP93D2, TP93D1, TP93D0,
		TP92D3, TP92D2, TP92D1, TP92D0,
		TP91D3, TP91D2, TP91D1, TP91D0,
		TP90D3, TP90D2, TP90D1, TP90D0,
		TP89D3, TP89D2, TP89D1, TP89D0,
		TP88D3, TP88D2, TP88D1, TP88D0,
		TP87D3, TP87D2, TP87D1, TP87D0,
		TP86D3, TP86D2, TP86D1, TP86D0,
		TP85D3, TP85D2, TP85D1, TP85D0,
		TP84D3, TP84D2, TP84D1, TP84D0,
		TP83D3, TP83D2, TP83D1, TP83D0,
		TP82D3, TP82D2, TP82D1, TP82D0,
		TP81D3, TP81D2, TP81D1, TP81D0,
		TP80D3, TP80D2, TP80D1, TP80D0,
		TP79D3, TP79D2, TP79D1, TP79D0,
		TP78D3, TP78D2, TP78D1, TP78D0,
		TP77D3, TP77D2, TP77D1, TP77D0,
		TP76D3, TP76D2, TP76D1, TP76D0,
		TP75D3, TP75D2, TP75D1, TP75D0,
		TP74D3, TP74D2, TP74D1, TP74D0,
		TP73D3, TP73D2, TP73D1, TP73D0,
		TP72D3, TP72D2, TP72D1, TP72D0,
		TP71D3, TP71D2, TP71D1, TP71D0,
		TP70D3, TP70D2, TP70D1, TP70D0,
		TP69D3, TP69D2, TP69D1, TP69D0,
		TP68D3, TP68D2, TP68D1, TP68D0,
		TP67D3, TP67D2, TP67D1, TP67D0,
		TP66D3, TP66D2, TP66D1, TP66D0,
		TP65D3, TP65D2, TP65D1, TP65D0,
		TP64D3, TP64D2, TP64D1, TP64D0,
		TP63D3, TP63D2, TP63D1, TP63D0,
		TP62D3, TP62D2, TP62D1, TP62D0,
		TP61D3, TP61D2, TP61D1, TP61D0,
		TP60D3, TP60D2, TP60D1, TP60D0,
		TP59D3, TP59D2, TP59D1, TP59D0,
		TP58D3, TP58D2, TP58D1, TP58D0,
		TP57D3, TP57D2, TP57D1, TP57D0,
		TP56D3, TP56D2, TP56D1, TP56D0,
		TP55D3, TP55D2, TP55D1, TP55D0,
		TP54D3, TP54D2, TP54D1, TP54D0,
		TP53D3, TP53D2, TP53D1, TP53D0,
		TP52D3, TP52D2, TP52D1, TP52D0,
		TP51D3, TP51D2, TP51D1, TP51D0,
		TP50D3, TP50D2, TP50D1, TP50D0,
		TP49D3, TP49D2, TP49D1, TP49D0,
		TP48D3, TP48D2, TP48D1, TP48D0,
		TP47D3, TP47D2, TP47D1, TP47D0,
		TP46D3, TP46D2, TP46D1, TP46D0,
		TP45D3, TP45D2, TP45D1, TP45D0,
		TP44D3, TP44D2, TP44D1, TP44D0,
		TP43D3, TP43D2, TP43D1, TP43D0,
		TP42D3, TP42D2, TP42D1, TP42D0,
		TP41D3, TP41D2, TP41D1, TP41D0,
		TP40D3, TP40D2, TP40D1, TP40D0,
		TP39D3, TP39D2, TP39D1, TP39D0,
		TP38D3, TP38D2, TP38D1, TP38D0,
		TP37D3, TP37D2, TP37D1, TP37D0,
		TP36D3, TP36D2, TP36D1, TP36D0,
		TP35D3, TP35D2, TP35D1, TP35D0,
		TP34D3, TP34D2, TP34D1, TP34D0,
		TP33D3, TP33D2, TP33D1, TP33D0,
		TP32D3, TP32D2, TP32D1, TP32D0,
		TP31D3, TP31D2, TP31D1, TP31D0,
		TP30D3, TP30D2, TP30D1, TP30D0,
		TP29D3, TP29D2, TP29D1, TP29D0,
		TP28D3, TP28D2, TP28D1, TP28D0,
		TP27D3, TP27D2, TP27D1, TP27D0,
		TP26D3, TP26D2, TP26D1, TP26D0,
		TP25D3, TP25D2, TP25D1, TP25D0,
		TP24D3, TP24D2, TP24D1, TP24D0,
		TP23D3, TP23D2, TP23D1, TP23D0,
		TP22D3, TP22D2, TP22D1, TP22D0,
		TP21D3, TP21D2, TP21D1, TP21D0,
		TP20D3, TP20D2, TP20D1, TP20D0,
		TP19D3, TP19D2, TP19D1, TP19D0,
		TP18D3, TP18D2, TP18D1, TP18D0,
		TP17D3, TP17D2, TP17D1, TP17D0,
		TP16D3, TP16D2, TP16D1, TP16D0,
		TP15D3, TP15D2, TP15D1, TP15D0,
		TP14D3, TP14D2, TP14D1, TP14D0,
		TP13D3, TP13D2, TP13D1, TP13D0,
		TP12D3, TP12D2, TP12D1, TP12D0,
		TP11D3, TP11D2, TP11D1, TP11D0,
		TP10D3, TP10D2, TP10D1, TP10D0,
		TP9D3, TP9D2, TP9D1, TP9D0,
		TP8D3, TP8D2, TP8D1, TP8D0,
		TP7D3, TP7D2, TP7D1, TP7D0,
		TP6D3, TP6D2, TP6D1, TP6D0,
		TP5D3, TP5D2, TP5D1, TP5D0,
		TP4D3, TP4D2, TP4D1, TP4D0,
		TP3D3, TP3D2, TP3D1, TP3D0,
		TP2D3, TP2D2, TP2D1, TP2D0,
		TP1D3, TP1D2, TP1D1, TP1D0,
		TI11D3, TI11D2, TI11D1, TI11D0,
		TI10D3, TI10D2, TI10D1, TI10D0,
		TI9D3, TI9D2, TI9D1, TI9D0,
		TI8D3, TI8D2, TI8D1, TI8D0,
		TI7D3, TI7D2, TI7D1, TI7D0,
		TI6D3, TI6D2, TI6D1, TI6D0,
		TI5D3, TI5D2, TI5D1, TI5D0,
		TI4D3, TI4D2, TI4D1, TI4D0,
		TI3D3, TI3D2, TI3D1, TI3D0,
		TI2D3, TI2D2, TI2D1, TI2D0,
		TI1D3, TI1D2, TI1D1, TI1D0,
		TI0D3, TI0D2, TI0D1, TI0D0;

	wire	[31:0]	iceifa;
	
	assign iceifa = {
		ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
		ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
		ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
		ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0
	};
		
//***************************************************************************************
//$B%"%I%l%9!&%G%3!<%@(B
//***************************************************************************************
	wire		ADDRTD144, ADDRTD143, ADDRTD142, ADDRTD141,
			ADDRTD140, ADDRTD139, ADDRTD138, ADDRTD137,
			ADDRTD136, ADDRTD135, ADDRTD134, ADDRTD133,
			ADDRTD132, ADDRTD131, ADDRTD130, ADDRTD129,
			ADDRTD128, ADDRTD127, ADDRTD126, ADDRTD125,
			ADDRTD124, ADDRTD123, ADDRTD122, ADDRTD121,
			ADDRTD120, ADDRTD119, ADDRTD118, ADDRTD117,
			ADDRTD116, ADDRTD115, ADDRTD114, ADDRTD113,
			ADDRTD112, ADDRTD111, ADDRTD110, ADDRTD109,
			ADDRTD108, ADDRTD107, ADDRTD106, ADDRTD105,
			ADDRTD104, ADDRTD103, ADDRTD102, ADDRTD101,
			ADDRTD100, ADDRTD99, ADDRTD98, ADDRTD97,
			ADDRTD96, ADDRTD95, ADDRTD94, ADDRTD93,
			ADDRTD92, ADDRTD91, ADDRTD90, ADDRTD89,
			ADDRTD88, ADDRTD87, ADDRTD86, ADDRTD85,
			ADDRTD84, ADDRTD83, ADDRTD82, ADDRTD81,
			ADDRTD80, ADDRTD79, ADDRTD78, ADDRTD77,
			ADDRTD76, ADDRTD75, ADDRTD74, ADDRTD73,
			ADDRTD72, ADDRTD71, ADDRTD70, ADDRTD69,
			ADDRTD68, ADDRTD67, ADDRTD66, ADDRTD65,
			ADDRTD64, ADDRTD63, ADDRTD62, ADDRTD61,
			ADDRTD60, ADDRTD59, ADDRTD58, ADDRTD57,
			ADDRTD56, ADDRTD55, ADDRTD54, ADDRTD53,
			ADDRTD52, ADDRTD51, ADDRTD50, ADDRTD49,
			ADDRTD48, ADDRTD47, ADDRTD46, ADDRTD45,
			ADDRTD44, ADDRTD43, ADDRTD42, ADDRTD41,
			ADDRTD40, ADDRTD39, ADDRTD38, ADDRTD37,
			ADDRTD36, ADDRTD35, ADDRTD34, ADDRTD33,
			ADDRTD32, ADDRTD31, ADDRTD30, ADDRTD29,
			ADDRTD28, ADDRTD27, ADDRTD26, ADDRTD25,
			ADDRTD24, ADDRTD23, ADDRTD22, ADDRTD21,
			ADDRTD20, ADDRTD19, ADDRTD18, ADDRTD17,
			ADDRTD16, ADDRTD15, ADDRTD14, ADDRTD13,
			ADDRTD12, ADDRTD11, ADDRTD10, ADDRTD9,
			ADDRTD8, ADDRTD7, ADDRTD6, ADDRTD5,
			ADDRTD4, ADDRTD3, ADDRTD2, ADDRTD1,
			ADDRICE11, ADDRICE10, ADDRICE9, ADDRICE8,
			ADDRICE7, ADDRICE6, ADDRICE5, ADDRICE4,
			ADDRICE3, ADDRICE2, ADDRICE1, ADDRICE0,
			ADDRPINRD, ADDRPINMD, ADDRPINLV;
	wire		ADDRTDH, ADDRICEH;

	assign	ADDRTDH = (iceifa[31:12] == 20'h0880_1) ? 1'b1 : 1'b0;
	assign	ADDRICEH = (iceifa[31:8] == 24'h0880_20) ? 1'b1 : 1'b0;

	assign	ADDRPINRD = (iceifa[3:2] == 2'b00) ? 1'b1 : 1'b0;
	assign	ADDRPINMD = (iceifa[3:2] == 2'b01) ? 1'b1 : 1'b0;
	assign	ADDRPINLV = (iceifa[3:2] == 2'b10) ? 1'b1 : 1'b0;

	assign	ADDRTD144 = (ADDRTDH && iceifa[11:4] == 8'h90) ? 1'b1 : 1'b0;
	assign	ADDRTD143 = (ADDRTDH && iceifa[11:4] == 8'h8F) ? 1'b1 : 1'b0;
	assign	ADDRTD142 = (ADDRTDH && iceifa[11:4] == 8'h8E) ? 1'b1 : 1'b0;
	assign	ADDRTD141 = (ADDRTDH && iceifa[11:4] == 8'h8D) ? 1'b1 : 1'b0;
	assign	ADDRTD140 = (ADDRTDH && iceifa[11:4] == 8'h8C) ? 1'b1 : 1'b0;
	assign	ADDRTD139 = (ADDRTDH && iceifa[11:4] == 8'h8B) ? 1'b1 : 1'b0;
	assign	ADDRTD138 = (ADDRTDH && iceifa[11:4] == 8'h8A) ? 1'b1 : 1'b0;
	assign	ADDRTD137 = (ADDRTDH && iceifa[11:4] == 8'h89) ? 1'b1 : 1'b0;
	assign	ADDRTD136 = (ADDRTDH && iceifa[11:4] == 8'h88) ? 1'b1 : 1'b0;
	assign	ADDRTD135 = (ADDRTDH && iceifa[11:4] == 8'h87) ? 1'b1 : 1'b0;
	assign	ADDRTD134 = (ADDRTDH && iceifa[11:4] == 8'h86) ? 1'b1 : 1'b0;
	assign	ADDRTD133 = (ADDRTDH && iceifa[11:4] == 8'h85) ? 1'b1 : 1'b0;
	assign	ADDRTD132 = (ADDRTDH && iceifa[11:4] == 8'h84) ? 1'b1 : 1'b0;
	assign	ADDRTD131 = (ADDRTDH && iceifa[11:4] == 8'h83) ? 1'b1 : 1'b0;
	assign	ADDRTD130 = (ADDRTDH && iceifa[11:4] == 8'h82) ? 1'b1 : 1'b0;
	assign	ADDRTD129 = (ADDRTDH && iceifa[11:4] == 8'h81) ? 1'b1 : 1'b0;
	assign	ADDRTD128 = (ADDRTDH && iceifa[11:4] == 8'h80) ? 1'b1 : 1'b0;
	assign	ADDRTD127 = (ADDRTDH && iceifa[11:4] == 8'h7F) ? 1'b1 : 1'b0;
	assign	ADDRTD126 = (ADDRTDH && iceifa[11:4] == 8'h7E) ? 1'b1 : 1'b0;
	assign	ADDRTD125 = (ADDRTDH && iceifa[11:4] == 8'h7D) ? 1'b1 : 1'b0;
	assign	ADDRTD124 = (ADDRTDH && iceifa[11:4] == 8'h7C) ? 1'b1 : 1'b0;
	assign	ADDRTD123 = (ADDRTDH && iceifa[11:4] == 8'h7B) ? 1'b1 : 1'b0;
	assign	ADDRTD122 = (ADDRTDH && iceifa[11:4] == 8'h7A) ? 1'b1 : 1'b0;
	assign	ADDRTD121 = (ADDRTDH && iceifa[11:4] == 8'h79) ? 1'b1 : 1'b0;
	assign	ADDRTD120 = (ADDRTDH && iceifa[11:4] == 8'h78) ? 1'b1 : 1'b0;
	assign	ADDRTD119 = (ADDRTDH && iceifa[11:4] == 8'h77) ? 1'b1 : 1'b0;
	assign	ADDRTD118 = (ADDRTDH && iceifa[11:4] == 8'h76) ? 1'b1 : 1'b0;
	assign	ADDRTD117 = (ADDRTDH && iceifa[11:4] == 8'h75) ? 1'b1 : 1'b0;
	assign	ADDRTD116 = (ADDRTDH && iceifa[11:4] == 8'h74) ? 1'b1 : 1'b0;
	assign	ADDRTD115 = (ADDRTDH && iceifa[11:4] == 8'h73) ? 1'b1 : 1'b0;
	assign	ADDRTD114 = (ADDRTDH && iceifa[11:4] == 8'h72) ? 1'b1 : 1'b0;
	assign	ADDRTD113 = (ADDRTDH && iceifa[11:4] == 8'h71) ? 1'b1 : 1'b0;
	assign	ADDRTD112 = (ADDRTDH && iceifa[11:4] == 8'h70) ? 1'b1 : 1'b0;
	assign	ADDRTD111 = (ADDRTDH && iceifa[11:4] == 8'h6F) ? 1'b1 : 1'b0;
	assign	ADDRTD110 = (ADDRTDH && iceifa[11:4] == 8'h6E) ? 1'b1 : 1'b0;
	assign	ADDRTD109 = (ADDRTDH && iceifa[11:4] == 8'h6D) ? 1'b1 : 1'b0;
	assign	ADDRTD108 = (ADDRTDH && iceifa[11:4] == 8'h6C) ? 1'b1 : 1'b0;
	assign	ADDRTD107 = (ADDRTDH && iceifa[11:4] == 8'h6B) ? 1'b1 : 1'b0;
	assign	ADDRTD106 = (ADDRTDH && iceifa[11:4] == 8'h6A) ? 1'b1 : 1'b0;
	assign	ADDRTD105 = (ADDRTDH && iceifa[11:4] == 8'h69) ? 1'b1 : 1'b0;
	assign	ADDRTD104 = (ADDRTDH && iceifa[11:4] == 8'h68) ? 1'b1 : 1'b0;
	assign	ADDRTD103 = (ADDRTDH && iceifa[11:4] == 8'h67) ? 1'b1 : 1'b0;
	assign	ADDRTD102 = (ADDRTDH && iceifa[11:4] == 8'h66) ? 1'b1 : 1'b0;
	assign	ADDRTD101 = (ADDRTDH && iceifa[11:4] == 8'h65) ? 1'b1 : 1'b0;
	assign	ADDRTD100 = (ADDRTDH && iceifa[11:4] == 8'h64) ? 1'b1 : 1'b0;
	assign	ADDRTD99  = (ADDRTDH && iceifa[11:4] == 8'h63) ? 1'b1 : 1'b0;
	assign	ADDRTD98  = (ADDRTDH && iceifa[11:4] == 8'h62) ? 1'b1 : 1'b0;
	assign	ADDRTD97  = (ADDRTDH && iceifa[11:4] == 8'h61) ? 1'b1 : 1'b0;
	assign	ADDRTD96  = (ADDRTDH && iceifa[11:4] == 8'h60) ? 1'b1 : 1'b0;
	assign	ADDRTD95  = (ADDRTDH && iceifa[11:4] == 8'h5F) ? 1'b1 : 1'b0;
	assign	ADDRTD94  = (ADDRTDH && iceifa[11:4] == 8'h5E) ? 1'b1 : 1'b0;
	assign	ADDRTD93  = (ADDRTDH && iceifa[11:4] == 8'h5D) ? 1'b1 : 1'b0;
	assign	ADDRTD92  = (ADDRTDH && iceifa[11:4] == 8'h5C) ? 1'b1 : 1'b0;
	assign	ADDRTD91  = (ADDRTDH && iceifa[11:4] == 8'h5B) ? 1'b1 : 1'b0;
	assign	ADDRTD90  = (ADDRTDH && iceifa[11:4] == 8'h5A) ? 1'b1 : 1'b0;
	assign	ADDRTD89  = (ADDRTDH && iceifa[11:4] == 8'h59) ? 1'b1 : 1'b0;
	assign	ADDRTD88  = (ADDRTDH && iceifa[11:4] == 8'h58) ? 1'b1 : 1'b0;
	assign	ADDRTD87  = (ADDRTDH && iceifa[11:4] == 8'h57) ? 1'b1 : 1'b0;
	assign	ADDRTD86  = (ADDRTDH && iceifa[11:4] == 8'h56) ? 1'b1 : 1'b0;
	assign	ADDRTD85  = (ADDRTDH && iceifa[11:4] == 8'h55) ? 1'b1 : 1'b0;
	assign	ADDRTD84  = (ADDRTDH && iceifa[11:4] == 8'h54) ? 1'b1 : 1'b0;
	assign	ADDRTD83  = (ADDRTDH && iceifa[11:4] == 8'h53) ? 1'b1 : 1'b0;
	assign	ADDRTD82  = (ADDRTDH && iceifa[11:4] == 8'h52) ? 1'b1 : 1'b0;
	assign	ADDRTD81  = (ADDRTDH && iceifa[11:4] == 8'h51) ? 1'b1 : 1'b0;
	assign	ADDRTD80  = (ADDRTDH && iceifa[11:4] == 8'h50) ? 1'b1 : 1'b0;
	assign	ADDRTD79  = (ADDRTDH && iceifa[11:4] == 8'h4F) ? 1'b1 : 1'b0;
	assign	ADDRTD78  = (ADDRTDH && iceifa[11:4] == 8'h4E) ? 1'b1 : 1'b0;
	assign	ADDRTD77  = (ADDRTDH && iceifa[11:4] == 8'h4D) ? 1'b1 : 1'b0;
	assign	ADDRTD76  = (ADDRTDH && iceifa[11:4] == 8'h4C) ? 1'b1 : 1'b0;
	assign	ADDRTD75  = (ADDRTDH && iceifa[11:4] == 8'h4B) ? 1'b1 : 1'b0;
	assign	ADDRTD74  = (ADDRTDH && iceifa[11:4] == 8'h4A) ? 1'b1 : 1'b0;
	assign	ADDRTD73  = (ADDRTDH && iceifa[11:4] == 8'h49) ? 1'b1 : 1'b0;
	assign	ADDRTD72  = (ADDRTDH && iceifa[11:4] == 8'h48) ? 1'b1 : 1'b0;
	assign	ADDRTD71  = (ADDRTDH && iceifa[11:4] == 8'h47) ? 1'b1 : 1'b0;
	assign	ADDRTD70  = (ADDRTDH && iceifa[11:4] == 8'h46) ? 1'b1 : 1'b0;
	assign	ADDRTD69  = (ADDRTDH && iceifa[11:4] == 8'h45) ? 1'b1 : 1'b0;
	assign	ADDRTD68  = (ADDRTDH && iceifa[11:4] == 8'h44) ? 1'b1 : 1'b0;
	assign	ADDRTD67  = (ADDRTDH && iceifa[11:4] == 8'h43) ? 1'b1 : 1'b0;
	assign	ADDRTD66  = (ADDRTDH && iceifa[11:4] == 8'h42) ? 1'b1 : 1'b0;
	assign	ADDRTD65  = (ADDRTDH && iceifa[11:4] == 8'h41) ? 1'b1 : 1'b0;
	assign	ADDRTD64  = (ADDRTDH && iceifa[11:4] == 8'h40) ? 1'b1 : 1'b0;
	assign	ADDRTD63  = (ADDRTDH && iceifa[11:4] == 8'h3F) ? 1'b1 : 1'b0;
	assign	ADDRTD62  = (ADDRTDH && iceifa[11:4] == 8'h3E) ? 1'b1 : 1'b0;
	assign	ADDRTD61  = (ADDRTDH && iceifa[11:4] == 8'h3D) ? 1'b1 : 1'b0;
	assign	ADDRTD60  = (ADDRTDH && iceifa[11:4] == 8'h3C) ? 1'b1 : 1'b0;
	assign	ADDRTD59  = (ADDRTDH && iceifa[11:4] == 8'h3B) ? 1'b1 : 1'b0;
	assign	ADDRTD58  = (ADDRTDH && iceifa[11:4] == 8'h3A) ? 1'b1 : 1'b0;
	assign	ADDRTD57  = (ADDRTDH && iceifa[11:4] == 8'h39) ? 1'b1 : 1'b0;
	assign	ADDRTD56  = (ADDRTDH && iceifa[11:4] == 8'h38) ? 1'b1 : 1'b0;
	assign	ADDRTD55  = (ADDRTDH && iceifa[11:4] == 8'h37) ? 1'b1 : 1'b0;
	assign	ADDRTD54  = (ADDRTDH && iceifa[11:4] == 8'h36) ? 1'b1 : 1'b0;
	assign	ADDRTD53  = (ADDRTDH && iceifa[11:4] == 8'h35) ? 1'b1 : 1'b0;
	assign	ADDRTD52  = (ADDRTDH && iceifa[11:4] == 8'h34) ? 1'b1 : 1'b0;
	assign	ADDRTD51  = (ADDRTDH && iceifa[11:4] == 8'h33) ? 1'b1 : 1'b0;
	assign	ADDRTD50  = (ADDRTDH && iceifa[11:4] == 8'h32) ? 1'b1 : 1'b0;
	assign	ADDRTD49  = (ADDRTDH && iceifa[11:4] == 8'h31) ? 1'b1 : 1'b0;
	assign	ADDRTD48  = (ADDRTDH && iceifa[11:4] == 8'h30) ? 1'b1 : 1'b0;
	assign	ADDRTD47  = (ADDRTDH && iceifa[11:4] == 8'h2F) ? 1'b1 : 1'b0;
	assign	ADDRTD46  = (ADDRTDH && iceifa[11:4] == 8'h2E) ? 1'b1 : 1'b0;
	assign	ADDRTD45  = (ADDRTDH && iceifa[11:4] == 8'h2D) ? 1'b1 : 1'b0;
	assign	ADDRTD44  = (ADDRTDH && iceifa[11:4] == 8'h2C) ? 1'b1 : 1'b0;
	assign	ADDRTD43  = (ADDRTDH && iceifa[11:4] == 8'h2B) ? 1'b1 : 1'b0;
	assign	ADDRTD42  = (ADDRTDH && iceifa[11:4] == 8'h2A) ? 1'b1 : 1'b0;
	assign	ADDRTD41  = (ADDRTDH && iceifa[11:4] == 8'h29) ? 1'b1 : 1'b0;
	assign	ADDRTD40  = (ADDRTDH && iceifa[11:4] == 8'h28) ? 1'b1 : 1'b0;
	assign	ADDRTD39  = (ADDRTDH && iceifa[11:4] == 8'h27) ? 1'b1 : 1'b0;
	assign	ADDRTD38  = (ADDRTDH && iceifa[11:4] == 8'h26) ? 1'b1 : 1'b0;
	assign	ADDRTD37  = (ADDRTDH && iceifa[11:4] == 8'h25) ? 1'b1 : 1'b0;
	assign	ADDRTD36  = (ADDRTDH && iceifa[11:4] == 8'h24) ? 1'b1 : 1'b0;
	assign	ADDRTD35  = (ADDRTDH && iceifa[11:4] == 8'h23) ? 1'b1 : 1'b0;
	assign	ADDRTD34  = (ADDRTDH && iceifa[11:4] == 8'h22) ? 1'b1 : 1'b0;
	assign	ADDRTD33  = (ADDRTDH && iceifa[11:4] == 8'h21) ? 1'b1 : 1'b0;
	assign	ADDRTD32  = (ADDRTDH && iceifa[11:4] == 8'h20) ? 1'b1 : 1'b0;
	assign	ADDRTD31  = (ADDRTDH && iceifa[11:4] == 8'h1F) ? 1'b1 : 1'b0;
	assign	ADDRTD30  = (ADDRTDH && iceifa[11:4] == 8'h1E) ? 1'b1 : 1'b0;
	assign	ADDRTD29  = (ADDRTDH && iceifa[11:4] == 8'h1D) ? 1'b1 : 1'b0;
	assign	ADDRTD28  = (ADDRTDH && iceifa[11:4] == 8'h1C) ? 1'b1 : 1'b0;
	assign	ADDRTD27  = (ADDRTDH && iceifa[11:4] == 8'h1B) ? 1'b1 : 1'b0;
	assign	ADDRTD26  = (ADDRTDH && iceifa[11:4] == 8'h1A) ? 1'b1 : 1'b0;
	assign	ADDRTD25  = (ADDRTDH && iceifa[11:4] == 8'h19) ? 1'b1 : 1'b0;
	assign	ADDRTD24  = (ADDRTDH && iceifa[11:4] == 8'h18) ? 1'b1 : 1'b0;
	assign	ADDRTD23  = (ADDRTDH && iceifa[11:4] == 8'h17) ? 1'b1 : 1'b0;
	assign	ADDRTD22  = (ADDRTDH && iceifa[11:4] == 8'h16) ? 1'b1 : 1'b0;
	assign	ADDRTD21  = (ADDRTDH && iceifa[11:4] == 8'h15) ? 1'b1 : 1'b0;
	assign	ADDRTD20  = (ADDRTDH && iceifa[11:4] == 8'h14) ? 1'b1 : 1'b0;
	assign	ADDRTD19  = (ADDRTDH && iceifa[11:4] == 8'h13) ? 1'b1 : 1'b0;
	assign	ADDRTD18  = (ADDRTDH && iceifa[11:4] == 8'h12) ? 1'b1 : 1'b0;
	assign	ADDRTD17  = (ADDRTDH && iceifa[11:4] == 8'h11) ? 1'b1 : 1'b0;
	assign	ADDRTD16  = (ADDRTDH && iceifa[11:4] == 8'h10) ? 1'b1 : 1'b0;
	assign	ADDRTD15  = (ADDRTDH && iceifa[11:4] == 8'h0F) ? 1'b1 : 1'b0;
	assign	ADDRTD14  = (ADDRTDH && iceifa[11:4] == 8'h0E) ? 1'b1 : 1'b0;
	assign	ADDRTD13  = (ADDRTDH && iceifa[11:4] == 8'h0D) ? 1'b1 : 1'b0;
	assign	ADDRTD12  = (ADDRTDH && iceifa[11:4] == 8'h0C) ? 1'b1 : 1'b0;
	assign	ADDRTD11  = (ADDRTDH && iceifa[11:4] == 8'h0B) ? 1'b1 : 1'b0;
	assign	ADDRTD10  = (ADDRTDH && iceifa[11:4] == 8'h0A) ? 1'b1 : 1'b0;
	assign	ADDRTD9   = (ADDRTDH && iceifa[11:4] == 8'h09) ? 1'b1 : 1'b0;
	assign	ADDRTD8   = (ADDRTDH && iceifa[11:4] == 8'h08) ? 1'b1 : 1'b0;
	assign	ADDRTD7   = (ADDRTDH && iceifa[11:4] == 8'h07) ? 1'b1 : 1'b0;
	assign	ADDRTD6   = (ADDRTDH && iceifa[11:4] == 8'h06) ? 1'b1 : 1'b0;
	assign	ADDRTD5   = (ADDRTDH && iceifa[11:4] == 8'h05) ? 1'b1 : 1'b0;
	assign	ADDRTD4   = (ADDRTDH && iceifa[11:4] == 8'h04) ? 1'b1 : 1'b0;
	assign	ADDRTD3   = (ADDRTDH && iceifa[11:4] == 8'h03) ? 1'b1 : 1'b0;
	assign	ADDRTD2   = (ADDRTDH && iceifa[11:4] == 8'h02) ? 1'b1 : 1'b0;
	assign	ADDRTD1   = (ADDRTDH && iceifa[11:4] == 8'h01) ? 1'b1 : 1'b0;

	assign	ADDRICE11 = (ADDRICEH && iceifa[7:4] == 4'hB) ? 1'b1 : 1'b0;
	assign	ADDRICE10 = (ADDRICEH && iceifa[7:4] == 4'hA) ? 1'b1 : 1'b0;
	assign	ADDRICE9 = (ADDRICEH && iceifa[7:4] == 4'h9) ? 1'b1 : 1'b0;
	assign	ADDRICE8 = (ADDRICEH && iceifa[7:4] == 4'h8) ? 1'b1 : 1'b0;
	assign	ADDRICE7 = (ADDRICEH && iceifa[7:4] == 4'h7) ? 1'b1 : 1'b0;
	assign	ADDRICE6 = (ADDRICEH && iceifa[7:4] == 4'h6) ? 1'b1 : 1'b0;
	assign	ADDRICE5 = (ADDRICEH && iceifa[7:4] == 4'h5) ? 1'b1 : 1'b0;
	assign	ADDRICE4 = (ADDRICEH && iceifa[7:4] == 4'h4) ? 1'b1 : 1'b0;
	assign	ADDRICE3 = (ADDRICEH && iceifa[7:4] == 4'h3) ? 1'b1 : 1'b0;
	assign	ADDRICE2 = (ADDRICEH && iceifa[7:4] == 4'h2) ? 1'b1 : 1'b0;
	assign	ADDRICE1 = (ADDRICEH && iceifa[7:4] == 4'h1) ? 1'b1 : 1'b0;
	assign	ADDRICE0 = (ADDRICEH && iceifa[7:4] == 4'h0) ? 1'b1 : 1'b0;

//***************************************************************************************
//DATA OR
//***************************************************************************************
	wire		ICEDO31, ICEDO30, ICEDO29, ICEDO28,
			ICEDO27, ICEDO26, ICEDO25, ICEDO24,
			ICEDO23, ICEDO22, ICEDO21, ICEDO20,
			ICEDO19, ICEDO18, ICEDO17, ICEDO16,
			ICEDO15, ICEDO14, ICEDO13, ICEDO12,
			ICEDO11, ICEDO10, ICEDO9,  ICEDO8,
			ICEDO7,  ICEDO6,  ICEDO5,  ICEDO4,
			ICEDO3,  ICEDO2,  ICEDO1,  ICEDO0;

	assign {ICEDO31, ICEDO30, ICEDO29, ICEDO28,
			ICEDO27, ICEDO26, ICEDO25, ICEDO24,
			ICEDO23, ICEDO22, ICEDO21, ICEDO20,
			ICEDO19, ICEDO18, ICEDO17, ICEDO16,
			ICEDO15, ICEDO14, ICEDO13, ICEDO12,
			ICEDO11, ICEDO10, ICEDO9,  ICEDO8,
			ICEDO7,  ICEDO6,  ICEDO5,  ICEDO3} = 28'h0000_000;

	assign ICEDO4 =	TP144D3 | TP143D3 | TP142D3 | TP141D3 |
			TP140D3 | TP139D3 | TP138D3 | TP137D3 |
			TP136D3 | TP135D3 | TP134D3 | TP133D3 |
			TP132D3 | TP131D3 | TP130D3 | TP129D3 |
			TP128D3 | TP127D3 | TP126D3 | TP125D3 |
			TP124D3 | TP123D3 | TP122D3 | TP121D3 |
			TP120D3 | TP119D3 | TP118D3 | TP117D3 |
			TP116D3 | TP115D3 | TP114D3 | TP113D3 |
			TP112D3 | TP111D3 | TP110D3 | TP109D3 |
			TP108D3 | TP107D3 | TP106D3 | TP105D3 |
			TP104D3 | TP103D3 | TP102D3 | TP101D3 |
			TP100D3 | TP99D3 | TP98D3 | TP97D3 |
			TP96D3 | TP95D3 | TP94D3 | TP93D3 |
			TP92D3 | TP91D3 | TP90D3 | TP89D3 |
			TP88D3 | TP87D3 | TP86D3 | TP85D3 |
			TP84D3 | TP83D3 | TP82D3 | TP81D3 |
			TP80D3 | TP79D3 | TP78D3 | TP77D3 |
			TP76D3 | TP75D3 | TP74D3 | TP73D3 |
			TP72D3 | TP71D3 | TP70D3 | TP69D3 |
			TP68D3 | TP67D3 | TP66D3 | TP65D3 |
			TP64D3 | TP63D3 | TP62D3 | TP61D3 |
			TP60D3 | TP59D3 | TP58D3 | TP57D3 |
			TP56D3 | TP55D3 | TP54D3 | TP53D3 |
			TP52D3 | TP51D3 | TP50D3 | TP49D3 |
			TP48D3 | TP47D3 | TP46D3 | TP45D3 |
			TP44D3 | TP43D3 | TP42D3 | TP41D3 |
			TP40D3 | TP39D3 | TP38D3 | TP37D3 |
			TP36D3 | TP35D3 | TP34D3 | TP33D3 |
			TP32D3 | TP31D3 | TP30D3 | TP29D3 |
			TP28D3 | TP27D3 | TP26D3 | TP25D3 |
			TP24D3 | TP23D3 | TP22D3 | TP21D3 |
			TP20D3 | TP19D3 | TP18D3 | TP17D3 |
			TP16D3 | TP15D3 | TP14D3 | TP13D3 |
			TP12D3 | TP11D3 | TP10D3 | TP9D3 |
			TP8D3 | TP7D3 | TP6D3 | TP5D3 |
			TP4D3 | TP3D3 | TP2D3 | TP1D3 |
			TI11D3 | TI10D3 | TI9D3 | TI8D3 |
			TI7D3 | TI6D3 | TI5D3 | TI4D3 |
			TI3D3 | TI2D3 | TI1D3 | TI0D3;

	assign ICEDO2 =	TP144D2 | TP143D2 | TP142D2 | TP141D2 |
			TP140D2 | TP139D2 | TP138D2 | TP137D2 |
			TP136D2 | TP135D2 | TP134D2 | TP133D2 |
			TP132D2 | TP131D2 | TP130D2 | TP129D2 |
			TP128D2 | TP127D2 | TP126D2 | TP125D2 |
			TP124D2 | TP123D2 | TP122D2 | TP121D2 |
			TP120D2 | TP119D2 | TP118D2 | TP117D2 |
			TP116D2 | TP115D2 | TP114D2 | TP113D2 |
			TP112D2 | TP111D2 | TP110D2 | TP109D2 |
			TP108D2 | TP107D2 | TP106D2 | TP105D2 |
			TP104D2 | TP103D2 | TP102D2 | TP101D2 |
			TP100D2 | TP99D2 | TP98D2 | TP97D2 |
			TP96D2 | TP95D2 | TP94D2 | TP93D2 |
			TP92D2 | TP91D2 | TP90D2 | TP89D2 |
			TP88D2 | TP87D2 | TP86D2 | TP85D2 |
			TP84D2 | TP83D2 | TP82D2 | TP81D2 |
			TP80D2 | TP79D2 | TP78D2 | TP77D2 |
			TP76D2 | TP75D2 | TP74D2 | TP73D2 |
			TP72D2 | TP71D2 | TP70D2 | TP69D2 |
			TP68D2 | TP67D2 | TP66D2 | TP65D2 |
			TP64D2 | TP63D2 | TP62D2 | TP61D2 |
			TP60D2 | TP59D2 | TP58D2 | TP57D2 |
			TP56D2 | TP55D2 | TP54D2 | TP53D2 |
			TP52D2 | TP51D2 | TP50D2 | TP49D2 |
			TP48D2 | TP47D2 | TP46D2 | TP45D2 |
			TP44D2 | TP43D2 | TP42D2 | TP41D2 |
			TP40D2 | TP39D2 | TP38D2 | TP37D2 |
			TP36D2 | TP35D2 | TP34D2 | TP33D2 |
			TP32D2 | TP31D2 | TP30D2 | TP29D2 |
			TP28D2 | TP27D2 | TP26D2 | TP25D2 |
			TP24D2 | TP23D2 | TP22D2 | TP21D2 |
			TP20D2 | TP19D2 | TP18D2 | TP17D2 |
			TP16D2 | TP15D2 | TP14D2 | TP13D2 |
			TP12D2 | TP11D2 | TP10D2 | TP9D2 |
			TP8D2 | TP7D2 | TP6D2 | TP5D2 |
			TP4D2 | TP3D2 | TP2D2 | TP1D2 |
			TI11D2 | TI10D2 | TI9D2 | TI8D2 |
			TI7D2 | TI6D2 | TI5D2 | TI4D2 |
			TI3D2 | TI2D2 | TI1D2 | TI0D2;

	assign ICEDO1 =	TP144D1 | TP143D1 | TP142D1 | TP141D1 |
			TP140D1 | TP139D1 | TP138D1 | TP137D1 |
			TP136D1 | TP135D1 | TP134D1 | TP133D1 |
			TP132D1 | TP131D1 | TP130D1 | TP129D1 |
			TP128D1 | TP127D1 | TP126D1 | TP125D1 |
			TP124D1 | TP123D1 | TP122D1 | TP121D1 |
			TP120D1 | TP119D1 | TP118D1 | TP117D1 |
			TP116D1 | TP115D1 | TP114D1 | TP113D1 |
			TP112D1 | TP111D1 | TP110D1 | TP109D1 |
			TP108D1 | TP107D1 | TP106D1 | TP105D1 |
			TP104D1 | TP103D1 | TP102D1 | TP101D1 |
			TP100D1 | TP99D1 | TP98D1 | TP97D1 |
			TP96D1 | TP95D1 | TP94D1 | TP93D1 |
			TP92D1 | TP91D1 | TP90D1 | TP89D1 |
			TP88D1 | TP87D1 | TP86D1 | TP85D1 |
			TP84D1 | TP83D1 | TP82D1 | TP81D1 |
			TP80D1 | TP79D1 | TP78D1 | TP77D1 |
			TP76D1 | TP75D1 | TP74D1 | TP73D1 |
			TP72D1 | TP71D1 | TP70D1 | TP69D1 |
			TP68D1 | TP67D1 | TP66D1 | TP65D1 |
			TP64D1 | TP63D1 | TP62D1 | TP61D1 |
			TP60D1 | TP59D1 | TP58D1 | TP57D1 |
			TP56D1 | TP55D1 | TP54D1 | TP53D1 |
			TP52D1 | TP51D1 | TP50D1 | TP49D1 |
			TP48D1 | TP47D1 | TP46D1 | TP45D1 |
			TP44D1 | TP43D1 | TP42D1 | TP41D1 |
			TP40D1 | TP39D1 | TP38D1 | TP37D1 |
			TP36D1 | TP35D1 | TP34D1 | TP33D1 |
			TP32D1 | TP31D1 | TP30D1 | TP29D1 |
			TP28D1 | TP27D1 | TP26D1 | TP25D1 |
			TP24D1 | TP23D1 | TP22D1 | TP21D1 |
			TP20D1 | TP19D1 | TP18D1 | TP17D1 |
			TP16D1 | TP15D1 | TP14D1 | TP13D1 |
			TP12D1 | TP11D1 | TP10D1 | TP9D1 |
			TP8D1 | TP7D1 | TP6D1 | TP5D1 |
			TP4D1 | TP3D1 | TP2D1 | TP1D1 |
			TI11D1 | TI10D1 | TI9D1 | TI8D1 |
			TI7D1 | TI6D1 | TI5D1 | TI4D1 |
			TI3D1 | TI2D1 | TI1D1 | TI0D1;

	assign ICEDO0 =	TP144D0 | TP143D0 | TP142D0 | TP141D0 |
			TP140D0 | TP139D0 | TP138D0 | TP137D0 |
			TP136D0 | TP135D0 | TP134D0 | TP133D0 |
			TP132D0 | TP131D0 | TP130D0 | TP129D0 |
			TP128D0 | TP127D0 | TP126D0 | TP125D0 |
			TP124D0 | TP123D0 | TP122D0 | TP121D0 |
			TP120D0 | TP119D0 | TP118D0 | TP117D0 |
			TP116D0 | TP115D0 | TP114D0 | TP113D0 |
			TP112D0 | TP111D0 | TP110D0 | TP109D0 |
			TP108D0 | TP107D0 | TP106D0 | TP105D0 |
			TP104D0 | TP103D0 | TP102D0 | TP101D0 |
			TP100D0 | TP99D0 | TP98D0 | TP97D0 |
			TP96D0 | TP95D0 | TP94D0 | TP93D0 |
			TP92D0 | TP91D0 | TP90D0 | TP89D0 |
			TP88D0 | TP87D0 | TP86D0 | TP85D0 |
			TP84D0 | TP83D0 | TP82D0 | TP81D0 |
			TP80D0 | TP79D0 | TP78D0 | TP77D0 |
			TP76D0 | TP75D0 | TP74D0 | TP73D0 |
			TP72D0 | TP71D0 | TP70D0 | TP69D0 |
			TP68D0 | TP67D0 | TP66D0 | TP65D0 |
			TP64D0 | TP63D0 | TP62D0 | TP61D0 |
			TP60D0 | TP59D0 | TP58D0 | TP57D0 |
			TP56D0 | TP55D0 | TP54D0 | TP53D0 |
			TP52D0 | TP51D0 | TP50D0 | TP49D0 |
			TP48D0 | TP47D0 | TP46D0 | TP45D0 |
			TP44D0 | TP43D0 | TP42D0 | TP41D0 |
			TP40D0 | TP39D0 | TP38D0 | TP37D0 |
			TP36D0 | TP35D0 | TP34D0 | TP33D0 |
			TP32D0 | TP31D0 | TP30D0 | TP29D0 |
			TP28D0 | TP27D0 | TP26D0 | TP25D0 |
			TP24D0 | TP23D0 | TP22D0 | TP21D0 |
			TP20D0 | TP19D0 | TP18D0 | TP17D0 |
			TP16D0 | TP15D0 | TP14D0 | TP13D0 |
			TP12D0 | TP11D0 | TP10D0 | TP9D0 |
			TP8D0 | TP7D0 | TP6D0 | TP5D0 |
			TP4D0 | TP3D0 | TP2D0 | TP1D0 |
			TI11D0 | TI10D0 | TI9D0 | TI8D0 |
			TI7D0 | TI6D0 | TI5D0 | TI4D0 |
			TI3D0 | TI2D0 | TI1D0 | TI0D0;

endmodule

//***************************************************************************************
//                         PIO >-----+
//                     +--------+    |
//   EP <>-------------|selecter|----|>---+
// (1chip)   A         +--------+         |
//           |              A             |
//           |              |             |
//           |         PINMD,PINLV        |
//           |              |             |
//           |              V             |
//           |         +--------+         V
//           +---<|----|selecter|-------------<> P
//                |    +--------+                (FPGA)
//                +-----< !PIO
//PIO 0:input 1:output
//***************************************************************************************
module TESTPIN (
	SYSRSOUTB, ICEWR, ICEDI0,
	TPD3, TPD2, TPD1, TPD0,
	ADDRH, ADDRPINRD, ADDRPINMD, ADDRPINLV,
	EP, PIO, PUP, P
);

	input		SYSRSOUTB, ICEWR, ICEDI0;
	output		TPD3, TPD2, TPD1, TPD0;
	input		ADDRH, ADDRPINRD, ADDRPINMD, ADDRPINLV,
			PIO, PUP;
	inout		EP, P;

//***************************************************************************************
//$B%l%8%9%?!&%i%$%H(B
//***************************************************************************************
	reg		PINMD, PINLV;
	reg	[3:0]	icedo;
	wire		addr_rd, addr_md, addr_lv, PINRDLV;

	assign	addr_rd = ADDRH & ADDRPINRD;
	assign	addr_md = ADDRH & ADDRPINMD;
	assign	addr_lv = ADDRH & ADDRPINLV;

	always @(negedge ICEWR or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB)		PINMD <= 1'b0;
		else if (addr_md)	PINMD <= ICEDI0;
	end
	always @(negedge ICEWR or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB)		PINLV <= 1'b0;
		else if (addr_lv)	PINLV <= ICEDI0;
	end

//***************************************************************************************
//$B%l%8%9%?!&%j!<%I(B
//***************************************************************************************
	always @(addr_rd or addr_md or addr_lv or //PINMD or PINLV or
			PUP or PIO or PINRDLV) begin
		if      (addr_rd)	icedo = {1'b1, PUP, PIO, PINRDLV};
//		else if (addr_md)	icedo = {3'b0, PINMD};
//		else if (addr_lv)	icedo = {3'b0, PINLV};
		else			icedo = 4'b0;
	end

		assign	{TPD3, TPD2, TPD1, TPD0} = icedo;

//***************************************************************************************
//
//***************************************************************************************
	wire		platch_cnt, fplatch_cnt, porttmp, fporttmp;

	assign platch_cnt = PINMD & PIO;
	assign fplatch_cnt = PINMD & !PIO;
	assign porttmp = (platch_cnt) ? PINLV : EP;
	assign fporttmp = (fplatch_cnt) ? PINLV : P;
	assign P = (PIO) ? porttmp : 1'bz;
	assign EP = (!PIO)? fporttmp : 1'bz;

	assign PINRDLV = (PIO) ? EP : P;

endmodule
