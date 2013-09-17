/****************************************************************/
/* Date		: 2008/04/26					*/
/* Revision	: 1.00						*/
/* Designer	: T.Tsunoda					*/
/* Note		: OCDのEmulation用				*/
/****************************************************************/
/* Date		: 2009/11/18					*/
/* Revision	: 1.01						*/
/* Designer	: T.Tsunoda					*/
/* Note		: SS3rd用に変更					*/
/*		: (1)Deviceの端子名変更に合せて端子名を変更。	*/
/*		: (2)STBRELESVのEmulationをother_ifから移設。	*/
/****************************************************************/
/* Date		: 2010/10/20					*/
/* Revision	: 1.02						*/
/* Designer	: T.Tsunoda					*/
/* Note		: Open Breakを追加。				*/
/****************************************************************/
// $Id$

module SVMODIF (SVSTOPICE, SVPERI0ICE, SVPERI1ICE,
		SVMODI, SVMODIPERI1, SVMODIPERI2,
		SVSTOP, SVPERI0, SVPERI1,
		SVMODOPBRK, SVPERI0OPBRK,
		MONMD, SVMOD, MONSVMOD,
		STBRELE, STBRELESV, STBRELEICE,
);
		
	input	SVSTOPICE;	// OCD用のSVSTOP                (from chip.ocd)
	input	SVPERI0ICE;	// OCD用のSVPERI0(timer系)      (from chip.ocd)
	input	SVPERI1ICE;	// OCD用のSVPERI1(serial系)     (from chip.ocd)
	input	SVMODI;		// ICE用のSVMOD                 (from ice.break)
	input	SVMODIPERI1;	// ICE用のSVPERI1               (from ice.break)
	input	SVMODIPERI2;	// ICE用のSVPERI0               (from ice.break)
	output	SVSTOP;		// OR後のSVSTOP                 (to chip)
	output	SVPERI0;	// OR後のSVPERI0                (to chip)
	output	SVPERI1;	// OR後のSVPERI1                (to chip)
	input	MONMD;		// OCDモニタ中信号              (from chip.cpu)
	input	SVMOD;		// ICEのSVMOD                   (from chip.cpu)
	output	MONSVMOD;	// OCDのMONMODに接続            (to chip.ocd)
	
	input	STBRELE;	// Standby Release信号          (from chip.int)
	input	STBRELESV;	// ICE用Standby Release信号     (from ice.break)
	output	STBRELEICE;	// 統合後Standby Release信号    (to chip.csc)
	input	SVMODOPBRK;	// Open Break SVMOD             (from ice.break)
	output	SVPERI0OPBRK;	// OR後のSVMODOPBRK             (to chip)

	//
	// for OCD
	//
	assign	SVSTOP = SVSTOPICE | SVMODI;
	assign	SVPERI1 = SVPERI1ICE | SVMODIPERI1;
	assign	SVPERI0 = SVPERI0ICE | SVMODIPERI2;
	assign	MONSVMOD = MONMD | SVMOD;
	assign	SVPERI0OPBRK = SVPERI0ICE | SVMODOPBRK;
	
	//
	// for STBRELE
	//
	assign	STBRELEICE = STBRELE | STBRELESV;



endmodule

