/********************************************************************************/
/* Date		: 2010/07/27							*/
/* Revision	: 1.00								*/
/* Designer	: T.Tsunoda							*/
/* Note		: Reset buffer use to make RTBFG.				*/
/********************************************************************************/
/* Date		: 2010/08/20							*/
/* Revision	: 1.01								*/
/* Designer	: T.Tsunoda							*/
/* Note		: TRESET��ICE�Ǥ�0������ѹ��������TRESET��N/F�μ������Ҥ���	*/
/*		: �٤�������ICE�Ǥ�ICE Macro��N/F���̤�����Τ���³���Ƥ��롣	*/
/*		: ����ˤ�ꡢ����N/F���̲�̵ͭ�ǵ���Delay����Ԥ�����ϩ��ICE	*/
/*		: �Ǥ�ư���ʤ��ʤ�Serial Programming Mode�˰�������ʤ����꤬	*/
/*		: ���ä����ᡢ��Macro���������ξ���(TRESET=0)���᤹���ȤȤ�����	*/
/********************************************************************************/

module QID04005_ICE ( RSTINBNF, RESFB5V, TRESET, DIN5V, POCREL5V, SPAD, HVIN5V );

	output	RSTINBNF;	// ü��Reset		| =TERRESB
	output	RESFB5V;	// Reset����(0:Reset)	| ~(TERRESB & POCRESB) (=RTBFG)
	output	TRESET;		// ü��Reset��ȿž	| =~TERRESB              ^^^^^
	input	DIN5V;		// 			| (<-pulldown)
	input	POCREL5V;	// POC����(5V��)	| (<-ice.resctl(POCRESB))
	input	SPAD;		// ü��Reset		| (<-ice.resctl(TERRESB))
	input	HVIN5V;		// 			| (<-pulldown)


	assign	RSTINBNF = SPAD;
	assign	RESFB5V = RSTINBNF & POCREL5V;
//	assign	TRESET = ~SPAD;	// [V1.01]
	assign	TRESET = 1'b0;	// [V1.01]

endmodule

