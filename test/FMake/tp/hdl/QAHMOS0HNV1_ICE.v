/************************************************************************/
/* Date		: 2009/11/18						*/
/* Version	: 100							*/
/* Designer	: T.Tsunoda						*/
/* Note		: SS3rd�pmain���U��.					*/
/*		: (1) ���U��̒�~����					*/
/*		: (2) ���U�팓�p�[�q�̃f�[�^����			*/
/*		: (3) ICE�@�\ClockBlock�Ƃ̊Ԃ�I/F			*/
/*		:     (CPUTMCLK->ClockBlock->CPUMCLK->OSCOUTM)		*/
/*		: [ SS2nd����̕ύX�_ ]					*/
/*		: other_if�ɂ��������̂��番���B			*/
/************************************************************************/
/* Date		: 2010/04/16						*/
/* Version	: 101							*/
/* Designer	: T.Tsunoda						*/
/* Note		: �EMacro����ύX�B(OSCMAIN -> QAHMOS0HNV1_ICE)		*/
/*		: �E�[�q�ǉ��B(�u����������Macro�ƒ[�q����������ړI	*/
/*		:   �ŁA�u���������ɂ����āA����Macro�ł͎g��Ȃ��[�q��	*/
/*		:   �S�Ď��������B(Open or �[�q����)			*/
/************************************************************************/
// $Id$

module QAHMOS0HNV1_ICE (
	OSCSEL, EXCLK, X1, X1ENI, X1DIN, X2, X2ENI, X2DIN, MSTOP, OSCOUTM,
	CPUTMCLK,CPUMCLK,
	RESETB, MDLYCUT, AMPH
		);

	input	OSCSEL;		// OSC���[�h(H),����Port���[�h(L)�I��M��	(from csc)
	input	EXCLK;		// EXCLK���[�h�M��(H)				(from csc)
	input	X1;		// ���U�q�ڑ� or ���o��(ICE�͓���)		(from �[�q)
	input	X1ENI;		// ����Port���[�h��,X1 Input Enable		(from port12)
	output	X1DIN;		// ����Port���[�h��,X1���p�[�q�f�[�^����	(to port12)
	input	X2;		// ���U�q�ڑ� or ���o��(ICE�͓���)		(from �[�q)
	input	X2ENI;		// ����Port���[�h��,X2 Input Enable		(from port12)
	output	X2DIN;		// ����Port���[�h��,X2���p�[�q�f�[�^����	(to port12)
	input	MSTOP;		// OSC���[�h��,���U��~(H)			(from csc)
	output	OSCOUTM;	// OSC���[�h��,���U�o��(CPUMCLK�̒�~�����)	(to csc)
	/*--------------*/
	/* ICE�pI/F	*/
	/*--------------*/
	output	CPUTMCLK;	// X2���p�[�qClock����				(to clock block)
	input	CPUMCLK;	// Main Clock(ICE����Clock�ƑI����)		(from clock block)
	/*----------------------*/
	/* ���͂̂�(���g�p�[�q)	*/
	/*----------------------*/
	input	RESETB;		// OSC�p�m�C�YFilter��Reset�M��			(from csc)
	input	MDLYCUT;	// Filter����(H:N/F�ʉߑO,L:N/F�ʉߌ�)		(from modectl)
	input	AMPH;		// OSC��AMP Dimension�ؑ�(1:20MHz,0:10MHz)	(from csc)

	// ------------------------------------------------
	// port12�f�[�^���͂�Clock�u���b�N�ɓn���[�qClock -
	// ------------------------------------------------
	// --- Main OSC���� ---
	wire	oscmode_m	= OSCSEL & ~EXCLK;
	wire	exclkmode_m	= OSCSEL &  EXCLK;
	assign	CPUTMCLK = (oscmode_m) ? X2 : (exclkmode_m) ? ~X2 : 1'b0;
	
	// --- p121(x1),p122(x2) ---
	assign	X1DIN = X1 & X1ENI & ~oscmode_m;
	assign	X2DIN = X2 & X2ENI & ~OSCSEL;
	
	// ------------------------------------------------
	// Clock�u���b�N�����Clock��CSC�ɓn��            -
	// ------------------------------------------------
	// --- baseck ---
	wire	main_en	= OSCSEL & ~MSTOP;
	assign	OSCOUTM	= CPUMCLK & main_en;

	
endmodule

