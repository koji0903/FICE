// ============================================================================================================	*/
/* K0R IECUBE ORBUS-ICEDOP											*/
/* V100												Y.ishguro	*/
/* $Id: orbus-SS3rd.v,v 1.2 2010-02-01 02:59:25 snisimu Exp $							*/
/* ============================================================================================================	*/
module IERL78ORBUSICEDOPV1 (
	ICEDOP31, ICEDOP30, ICEDOP29, ICEDOP28, ICEDOP27, ICEDOP26, ICEDOP25, ICEDOP24,
	ICEDOP23, ICEDOP22, ICEDOP21, ICEDOP20, ICEDOP19, ICEDOP18, ICEDOP17, ICEDOP16,
	ICEDOP15, ICEDOP14, ICEDOP13, ICEDOP12, ICEDOP11, ICEDOP10, ICEDOP9, ICEDOP8,
	ICEDOP7, ICEDOP6, ICEDOP5, ICEDOP4, ICEDOP3, ICEDOP2, ICEDOP1, ICEDOP0,

	// from icescon
	ICEDOPA31, ICEDOPA30, ICEDOPA29, ICEDOPA28, ICEDOPA27, ICEDOPA26, ICEDOPA25, ICEDOPA24,
	ICEDOPA23, ICEDOPA22, ICEDOPA21, ICEDOPA20, ICEDOPA19, ICEDOPA18, ICEDOPA17, ICEDOPA16,
	ICEDOPA15, ICEDOPA14, ICEDOPA13, ICEDOPA12, ICEDOPA11, ICEDOPA10, ICEDOPA9, ICEDOPA8,
	ICEDOPA7, ICEDOPA6, ICEDOPA5, ICEDOPA4, ICEDOPA3, ICEDOPA2, ICEDOPA1, ICEDOPA0,

	// from ierk78prtyerrv1
	ICEDOPB31, ICEDOPB30, ICEDOPB29, ICEDOPB28, ICEDOPB27, ICEDOPB26, ICEDOPB25, ICEDOPB24,
	ICEDOPB23, ICEDOPB22, ICEDOPB21, ICEDOPB20, ICEDOPB19, ICEDOPB18, ICEDOPB17, ICEDOPB16,
	ICEDOPB15, ICEDOPB14, ICEDOPB13, ICEDOPB12, ICEDOPB11, ICEDOPB10, ICEDOPB9, ICEDOPB8,
	ICEDOPB7, ICEDOPB6, ICEDOPB5, ICEDOPB4, ICEDOPB3, ICEDOPB2, ICEDOPB1, ICEDOPB0,
	);

	output	ICEDOP31, ICEDOP30, ICEDOP29, ICEDOP28, ICEDOP27, ICEDOP26, ICEDOP25, ICEDOP24,
		ICEDOP23, ICEDOP22, ICEDOP21, ICEDOP20, ICEDOP19, ICEDOP18, ICEDOP17, ICEDOP16,
		ICEDOP15, ICEDOP14, ICEDOP13, ICEDOP12, ICEDOP11, ICEDOP10, ICEDOP9, ICEDOP8,
		ICEDOP7, ICEDOP6, ICEDOP5, ICEDOP4, ICEDOP3, ICEDOP2, ICEDOP1, ICEDOP0;

	input	ICEDOPA31, ICEDOPA30, ICEDOPA29, ICEDOPA28, ICEDOPA27, ICEDOPA26, ICEDOPA25, ICEDOPA24,
		ICEDOPA23, ICEDOPA22, ICEDOPA21, ICEDOPA20, ICEDOPA19, ICEDOPA18, ICEDOPA17, ICEDOPA16,
		ICEDOPA15, ICEDOPA14, ICEDOPA13, ICEDOPA12, ICEDOPA11, ICEDOPA10, ICEDOPA9, ICEDOPA8,
		ICEDOPA7, ICEDOPA6, ICEDOPA5, ICEDOPA4, ICEDOPA3, ICEDOPA2, ICEDOPA1, ICEDOPA0;

	input	ICEDOPB31, ICEDOPB30, ICEDOPB29, ICEDOPB28, ICEDOPB27, ICEDOPB26, ICEDOPB25, ICEDOPB24,
		ICEDOPB23, ICEDOPB22, ICEDOPB21, ICEDOPB20, ICEDOPB19, ICEDOPB18, ICEDOPB17, ICEDOPB16,
		ICEDOPB15, ICEDOPB14, ICEDOPB13, ICEDOPB12, ICEDOPB11, ICEDOPB10, ICEDOPB9, ICEDOPB8,
		ICEDOPB7, ICEDOPB6, ICEDOPB5, ICEDOPB4, ICEDOPB3, ICEDOPB2, ICEDOPB1, ICEDOPB0;

	wire [31:0]	icedop, icedopa, icedopb;

	assign	{ICEDOP31, ICEDOP30, ICEDOP29, ICEDOP28, ICEDOP27, ICEDOP26, ICEDOP25, ICEDOP24,
		 ICEDOP23, ICEDOP22, ICEDOP21, ICEDOP20, ICEDOP19, ICEDOP18, ICEDOP17, ICEDOP16,
		 ICEDOP15, ICEDOP14, ICEDOP13, ICEDOP12, ICEDOP11, ICEDOP10, ICEDOP9, ICEDOP8,
		 ICEDOP7, ICEDOP6, ICEDOP5, ICEDOP4, ICEDOP3, ICEDOP2, ICEDOP1, ICEDOP0 } = icedop;

	assign  icedopa = {ICEDOPA31, ICEDOPA30, ICEDOPA29, ICEDOPA28, ICEDOPA27, ICEDOPA26, ICEDOPA25, ICEDOPA24,
			   ICEDOPA23, ICEDOPA22, ICEDOPA21, ICEDOPA20, ICEDOPA19, ICEDOPA18, ICEDOPA17, ICEDOPA16,
			   ICEDOPA15, ICEDOPA14, ICEDOPA13, ICEDOPA12, ICEDOPA11, ICEDOPA10, ICEDOPA9, ICEDOPA8,
			   ICEDOPA7, ICEDOPA6, ICEDOPA5, ICEDOPA4, ICEDOPA3, ICEDOPA2, ICEDOPA1, ICEDOPA0};

	assign  icedopb = {ICEDOPB31, ICEDOPB30, ICEDOPB29, ICEDOPB28, ICEDOPB27, ICEDOPB26, ICEDOPB25, ICEDOPB24,
			   ICEDOPB23, ICEDOPB22, ICEDOPB21, ICEDOPB20, ICEDOPB19, ICEDOPB18, ICEDOPB17, ICEDOPB16,
			   ICEDOPB15, ICEDOPB14, ICEDOPB13, ICEDOPB12, ICEDOPB11, ICEDOPB10, ICEDOPB9, ICEDOPB8,
			   ICEDOPB7, ICEDOPB6, ICEDOPB5, ICEDOPB4, ICEDOPB3, ICEDOPB2, ICEDOPB1, ICEDOPB0};

	assign icedop = icedopa | icedopb;

endmodule

