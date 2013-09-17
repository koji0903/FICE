/* ============================================================================================================	*/
/* K0R IECUBE ICE Macro												*/
/*														*/
/* Other Macro( for ice_top)	T.Tsunoda									*/
/*														*/
// トップで繋ぎ替えが必要な信号、端子処理、make_chip対策など							*/
/* ============================================================================================================	*/
// $Id: ice_other.v,v 1.7 2010-01-29 07:47:03 tsuno3 Exp $

module ice_other (
	UP, DOWN,
	TVDDSELB, TVDDSEL,
	EROMWAIT, TMEMWAIT, WAITOR,
	CLK30MHZ, CLK30MHZ_GB,
	ICEDI_PRE31, ICEDI_PRE30, ICEDI_PRE29, ICEDI_PRE28,
	ICEDI_PRE27, ICEDI_PRE26, ICEDI_PRE25, ICEDI_PRE24,
	ICEDI_PRE23, ICEDI_PRE22, ICEDI_PRE21, ICEDI_PRE20,
	ICEDI_PRE19, ICEDI_PRE18, ICEDI_PRE17, ICEDI_PRE16,
	ICEDI_PRE15, ICEDI_PRE14, ICEDI_PRE13, ICEDI_PRE12,
	ICEDI_PRE11, ICEDI_PRE10, ICEDI_PRE9,  ICEDI_PRE8,
	ICEDI_PRE7,  ICEDI_PRE6,  ICEDI_PRE5,  ICEDI_PRE4,
	ICEDI_PRE3,  ICEDI_PRE2,  ICEDI_PRE1,
	ETVDDSEL,
	ELEDTVDD_B,
	ELEDCLOCK_B,
	ELEDRUN_B,
	ELEDRESET_B,
	ELEDSTANDBY_B,
	ELEDWAIT_B,

	ICECPURES_B,
	TCCONNECT_B,
	EACONNECT_B,
	TVDDON,
	ICERD_PRE,
	EXMAPOUT,
	ICEIFA_PRE1, ICEIFA_PRE0,
	ICEFLERRC, ICEFLERRD, ICEFLERR
);

	output	UP, DOWN;
	input	TVDDSELB;
	output	TVDDSEL;
	input	EROMWAIT, TMEMWAIT;
	output	WAITOR;
	input	CLK30MHZ;
	output	CLK30MHZ_GB;
	input	ICEDI_PRE31, ICEDI_PRE30, ICEDI_PRE29, ICEDI_PRE28,
		ICEDI_PRE27, ICEDI_PRE26, ICEDI_PRE25, ICEDI_PRE24,
		ICEDI_PRE23, ICEDI_PRE22, ICEDI_PRE21, ICEDI_PRE20,
		ICEDI_PRE19, ICEDI_PRE18, ICEDI_PRE17, ICEDI_PRE16,
		ICEDI_PRE15, ICEDI_PRE14, ICEDI_PRE13, ICEDI_PRE12,
		ICEDI_PRE11, ICEDI_PRE10, ICEDI_PRE9,  ICEDI_PRE8,
		ICEDI_PRE7,  ICEDI_PRE6,  ICEDI_PRE5,  ICEDI_PRE4,
		ICEDI_PRE3,  ICEDI_PRE2,  ICEDI_PRE1;
	
	// 入力するのみ。make_chipのエラー対策。SHORTパラメータと併用。
	input	ETVDDSEL;	// status(O) -> testpin.EP(I/O)
	input	ELEDTVDD_B;	// status(O) -> testpin.EP(I/O)
	input	ELEDCLOCK_B;	// status(O) -> testpin.EP(I/O)
	input	ELEDRUN_B;	// status(O) -> testpin.EP(I/O)
	input	ELEDRESET_B;	// status(O) -> testpin.EP(I/O)
	input	ELEDSTANDBY_B;	// status(O) -> testpin.EP(I/O)
	input	ELEDWAIT_B;	// status(O) -> testpin.EP(I/O)

	// 入力するのみ。make_chipのワーニング対策。
	input	ICECPURES_B;	// terminal(I) -> testpin.P(I/O)
	input	TCCONNECT_B;	// terminal(I) -> testpin.P(I/O)
	input	EACONNECT_B;	// terminal(I) -> testpin.P(I/O)
	input	TVDDON;		// terminal(I) -> testpin.P(I/O)
	input	ICERD_PRE;	// host_interface(O) -> non-connect
	input	EXMAPOUT;	// failsafe(O) -> non-connect
	input	ICEIFA_PRE1;	// host_interface(O) -> non-connect
	input	ICEIFA_PRE0;	// host_interface(O) -> non-connect

	// Flash Error Emulation
	input	ICEFLERRC;
	input	ICEFLERRD;
	output	ICEFLERR;

	// 端子処理(1'b0, 1'b1を直接繋ぐと、make_chipはそれを信号名と捕らえる為、
	// ドライブ元がなくエラーとなる。
	assign	UP = 1'b1;
	assign	DOWN = 1'b0;
	
	// 繋ぎ替え
	assign	TVDDSEL = ~TVDDSELB;
	assign	WAITOR = EROMWAIT | TMEMWAIT;

	// グローバルバッファによるバッファリング(トップに直接置く場合、
	// BUFGをモジュール宣言する必要がある。
	BUFG buf30m (.O(CLK30MHZ_GB), .I(CLK30MHZ));

	assign	ICEFLERR = ICEFLERRC | ICEFLERRD;

endmodule

