/****************************************************************/
/* Date		: 2008/04/26					*/
/* Revision	: 1.00						*/
/* Designer	: T.Tsunoda					*/
/* Note		: OCD��Emulation�p				*/
/****************************************************************/
/* Date		: 2009/11/18					*/
/* Revision	: 1.01						*/
/* Designer	: T.Tsunoda					*/
/* Note		: SS3rd�p�ɕύX					*/
/*		: (1)Device�̒[�q���ύX�ɍ����Ē[�q����ύX�B	*/
/*		: (2)STBRELESV��Emulation��other_if����ڐ݁B	*/
/****************************************************************/
/* Date		: 2010/10/20					*/
/* Revision	: 1.02						*/
/* Designer	: T.Tsunoda					*/
/* Note		: Open Break��ǉ��B				*/
/****************************************************************/
// $Id$

module SVMODIF (SVSTOPICE, SVPERI0ICE, SVPERI1ICE,
		SVMODI, SVMODIPERI1, SVMODIPERI2,
		SVSTOP, SVPERI0, SVPERI1,
		SVMODOPBRK, SVPERI0OPBRK,
		MONMD, SVMOD, MONSVMOD,
		STBRELE, STBRELESV, STBRELEICE,
);
		
	input	SVSTOPICE;	// OCD�p��SVSTOP                (from chip.ocd)
	input	SVPERI0ICE;	// OCD�p��SVPERI0(timer�n)      (from chip.ocd)
	input	SVPERI1ICE;	// OCD�p��SVPERI1(serial�n)     (from chip.ocd)
	input	SVMODI;		// ICE�p��SVMOD                 (from ice.break)
	input	SVMODIPERI1;	// ICE�p��SVPERI1               (from ice.break)
	input	SVMODIPERI2;	// ICE�p��SVPERI0               (from ice.break)
	output	SVSTOP;		// OR���SVSTOP                 (to chip)
	output	SVPERI0;	// OR���SVPERI0                (to chip)
	output	SVPERI1;	// OR���SVPERI1                (to chip)
	input	MONMD;		// OCD���j�^���M��              (from chip.cpu)
	input	SVMOD;		// ICE��SVMOD                   (from chip.cpu)
	output	MONSVMOD;	// OCD��MONMOD�ɐڑ�            (to chip.ocd)
	
	input	STBRELE;	// Standby Release�M��          (from chip.int)
	input	STBRELESV;	// ICE�pStandby Release�M��     (from ice.break)
	output	STBRELEICE;	// ������Standby Release�M��    (to chip.csc)
	input	SVMODOPBRK;	// Open Break SVMOD             (from ice.break)
	output	SVPERI0OPBRK;	// OR���SVMODOPBRK             (to chip)

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

