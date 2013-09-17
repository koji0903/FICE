/************************************************************************/
/* Date		: 2009/11/18						*/
/* Revision	: 100							*/
/* Designer	: T.Tsunoda						*/
/* Note		: SS3rd�psub���U��.					*/
/*		: (1) ���U��̒�~����					*/
/*		: (2) ���U�팓�p�[�q�̃f�[�^����			*/
/*		: (4) RTCCLK�̏o��(OSCOUTS�Ɠ��ꂾ���AEnable�M��������)	*/
/*		: (3) ICE�@�\ClockBlock�Ƃ̊Ԃ�I/F			*/
/*		:     (CPUTSCLK->ClockBlock->CPUSCLK->OSCOUTS)		*/
/*		: [ SS2nd����̕ύX�_ ]					*/
/*		: other_if�ɂ��������̂��番���B			*/
/************************************************************************/
/* Date		: 2010/04/16						*/
/* Version	: 101							*/
/* Designer	: T.Tsunoda						*/
/* Note		: �EMacro����ύX�B(OSCSUB -> QAHSOS1HNV1_ICE)		*/
/*		: �E�[�q�ǉ��B(�u����������Macro�ƒ[�q����������ړI	*/
/*		:   �ŁA�u���������ɂ����āA����Macro�ł͎g��Ȃ��[�q��	*/
/*		:   �S�Ď��������B(Open or �[�q����)			*/
/************************************************************************/
// $Id$

module QAHSOS1HNV1_ICE (
	OSCSELS, EXCLKS,
	XT1, XT1ENI, XT1DIN, XT2, XT2ENI, XT2DIN, XTSTOP, CPUCLKEN, RTCCLKEN, OSCOUTS, RTCCLK,
	CPUTSCLK, CPUSCLK,
	AMPHS0, AMPHS1, XTWKUP, BGISUB1, BGISUB2, BGISUB3
	);

	input	OSCSELS;	// OSC���[�h���C���̓��[�h�I��(H:OSC,L:I/O)	(from csc)
	input	EXCLKS;		// EXCLK���[�h�M��(H)				(from csc)
	input	XT1;		// XT1�[�q����					(from �[�q)
	input	XT1ENI;		// ���̓|�[�g���[�h���CXT1���͋��M��(H)	(from port12)
	output	XT1DIN;		// ���̓|�[�g���[�h���CXT1���̓f�[�^		(to port12)
	input	XT2;		// XT2�[�q����					(from �[�q)
	input	XT2ENI;		// ���̓|�[�g���[�h���CXT2���͋��M��(H)	(from port12)
	output	XT2DIN;		// ���̓|�[�g���[�h���CXT2���̓f�[�^		(to port12)
	input	XTSTOP;		// OSC���[�h���C���U��~(H)			(from csc)
	input	CPUCLKEN;	// OSC���[�h���CCPU�psub�N���b�N���M��(H)	(from csc)
	input	RTCCLKEN;	// OSC���[�h���CRTC�psub�N���b�N���M��(H)	(from csc)
	output	OSCOUTS;	// OSC���[�h���CCPU�psub�N���b�N�o��		(to csc)
	output	RTCCLK;		// OSC���[�h���CRTC�psub�N���b�N�o��		(to rtc)
	/*--------------*/
	/* ICE�pI/F	*/
	/*--------------*/
	output	CPUTSCLK;	// XT2���p�[�qClock����				(to clock block)
	input	CPUSCLK;	// Sub Clock(ICE����Clock�ƑI����)		(from clock block)
	/*----------------------*/
	/* ���͂̂�(���g�p�[�q)	*/
	/*----------------------*/
	input	AMPHS0;		// AMP�d���ؑ֐M��				(from csc)
	input	AMPHS1;		// AMP�d���ؑ֐M��				(from csc)
	input	XTWKUP;		// �d���𑝂₵�T�uOSC�̍����N�����\�ɂ���	(from csc)
	input	BGISUB1;	// BGR����typ:60nA�̒�d����Ⴄ		(from regm)
	input	BGISUB2;	// BGR����typ:60nA�̒�d����Ⴄ		(from regm)
	input	BGISUB3;	// BGR����typ:60nA�̒�d����Ⴄ		(from regm)

	// ------------------------------------------------
	// port12�f�[�^���͂�Clock�u���b�N�ɓn���[�qClock -
	// ------------------------------------------------
	// --- Sub OSC���� ---
	wire	oscmode_s	= OSCSELS & ~EXCLKS;
	wire	exclkmode_s	= OSCSELS &  EXCLKS;
	assign	CPUTSCLK = (oscmode_s) ? XT2 : (exclkmode_s) ? ~XT2 : 1'b0;
	
	// --- p123(xt1),p124(xt2) ---
	assign	XT1DIN = XT1 & XT1ENI & ~oscmode_s;
	assign	XT2DIN = XT2 & XT2ENI & ~OSCSELS;
	
	// ------------------------------------------------
	// Clock�u���b�N�����Clock��CSC,RTC�ɓn��        -
	// ------------------------------------------------
	// --- sub clk ---
	wire	sub_en	 = OSCSELS & ~XTSTOP;
	wire	OSCOUT	 = CPUSCLK & sub_en;
	wire	OSCOUTSp = CPUCLKEN & OSCOUT;
	wire	RTCCLKp	 = RTCCLKEN & OSCOUT;
	BUFG sub_bufg ( .O(OSCOUTS), .I(OSCOUTSp) );	// kx3 device df2.0�ł͂�����Clock�錾���Ă���
	BUFG rtc_bufg ( .O(RTCCLK), .I(RTCCLKp) );	// kx3 device df2.0�ł͂�����Clock�錾���Ă���

endmodule

