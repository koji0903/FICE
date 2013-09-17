/********************************************************************************/
/* Date		: 2010/07/27							*/
/* Revision	: 1.00								*/
/* Designer	: T.Tsunoda							*/
/* Note		: Reset buffer use to make RTBFG.				*/
/********************************************************************************/
/* Date		: 2010/08/20							*/
/* Revision	: 1.01								*/
/* Designer	: T.Tsunoda							*/
/* Note		: TRESETをICEでは0固定に変更。本来のTRESETはN/Fの手前が繋がる	*/
/*		: べきだが、ICEではICE MacroでN/Fを通したものを接続している。	*/
/*		: これにより、本来N/Fの通過有無で起るDelayを期待した回路がICE	*/
/*		: では動かなくなりSerial Programming Modeに引き込めない問題が	*/
/*		: 起ったため、本Macro実装以前の状態(TRESET=0)に戻すこととした。	*/
/********************************************************************************/

module QID04005_ICE ( RSTINBNF, RESFB5V, TRESET, DIN5V, POCREL5V, SPAD, HVIN5V );

	output	RSTINBNF;	// 端子Reset		| =TERRESB
	output	RESFB5V;	// Reset信号(0:Reset)	| ~(TERRESB & POCRESB) (=RTBFG)
	output	TRESET;		// 端子Resetの反転	| =~TERRESB              ^^^^^
	input	DIN5V;		// 			| (<-pulldown)
	input	POCREL5V;	// POC出力(5V系)	| (<-ice.resctl(POCRESB))
	input	SPAD;		// 端子Reset		| (<-ice.resctl(TERRESB))
	input	HVIN5V;		// 			| (<-pulldown)


	assign	RSTINBNF = SPAD;
	assign	RESFB5V = RSTINBNF & POCREL5V;
//	assign	TRESET = ~SPAD;	// [V1.01]
	assign	TRESET = 1'b0;	// [V1.01]

endmodule

