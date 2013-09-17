/************************************************************************/
/* Date		: 2010/02/03						*/
/* Version	: 1.0							*/
/* Designer	: Yuuji Ishiguro					*/
/* Note		: SS3rd�pLVI��։�H�Ƌ[��LVI				*/
/************************************************************************/
/* updata								*/
/* Date		: 2010/02/10						*/
/* Version	: 1.1							*/
/* Note		: LVI���o�̌덷�␳					*/
/* Designer	: Yuuji Ishiguro					*/
/************************************************************************/
/* Date		: 2010/04/16						*/
/* Version	: 1.2							*/
/* Designer	: T.Tsunoda						*/
/* Note		: �EMacro����ύX�B(LVIDSS3RD -> QAHREGOHNMAINV1_ICE)	*/
/*		: �E�[�q�ǉ��B(�u����������Macro�ƒ[�q����������ړI	*/
/*		:   �ŁA�u���������ɂ����āA����Macro�ł͎g��Ȃ��[�q��	*/
/*		:   �S�Ď��������B(Open or �[�q����)			*/
/*		: �ELVI�o�͂�Noise�΍��F/F��i�}��			*/
/*		: �EPOC��ǉ�(ice.resetctl����{Macro��through���邾��)	*/
/************************************************************************/
/* Date		: 2010/06/23						*/
/* Version	: 2.3							*/
/* Designer	: Y.Ishiguro						*/
/* Note		: �E�[��LVI�̎d�l�ύX�B(INT & RESET MODE�Ή�)		*/
/*		: �E�����݃��[�h�Ή�					*/
/* 		: �EMacro����ύX�B(QAHREGOHNMAINV1_ICE ->		*/
/*		:				QAHREGOHNMAINV1_ICE)	*/
/************************************************************************/
/* Date		: 2010/07/14						*/
/* Version	: 2.4							*/
/* Designer	: Y.Ishiguro						*/
/* Note		: �E�[�q�ǉ��B(TEMPADJ3-0,AMPSEL,BGRTEST,TESTVOUT)	*/
/*		:   �ǉ��[�q�͑S��Trimming�ƃe�X�g�p			*/
/************************************************************************/
/* Date		: 2010/07/27						*/
/* Version	: 2.5							*/
/* Designer	: Y.Ishiguro						*/
/* Note		: POCREL5V��0�Œ肩��POCRESB��through�ɕύX�Bport-iobuf	*/
/*		: ��RTBFG�[�q�ǉ��ɔ���resetb Macro��ǉ���,resetb�p��	*/
/*		: POC Reset�M���Ƃ���POCREL5V���K�v�ƂȂ����ׁB		*/
/************************************************************************/
/* Date		: 2010/12/08						*/
/* Version	: 2.6							*/
/* Designer	: K.Hamada						*/
/* Note		: LVI���o�d����CT4�{�[�h(������)�ɍ��킹�Ĕ����������B  */
/*              : 2.5�ł܂ł�CT3�{�[�h��Tuning���Ă����B                */
/************************************************************************/
// $Id$

module QAHREGOHNMAINV2_ICE (
	LVIS3, LVIS2, LVIS1, LVIS0, LVIEN, LVIOUTZ, POCREL,
	SYSRESB, POCRESB, VDDLEV7, VDDLEV6, VDDLEV5, VDDLEV4, VDDLEV3, VDDLEV2, VDDLEV1,
	VDDLEV0, USBIFWR, PSEUDOON0, PSEUDOON8, PONRESB, OPLVIMDS1, OPLVIMDS0,
	BG1EN, RESFB5V, REGLV, REGLC, BGRT6, BGRT5, BGRT4, BGRT3, BGRT2, BGRT1, BGRT0,
	BG1ST, BG2ADEN, BG2ADSEL, LVITEST, LVITSEL, PAENB, SENSEVDD,
	VBG1, VBG08, BGIOREG2, BGIOREG1, VBG2AD, BGISUB3, BGISUB2, BGISUB1,
	REGDRV, PDRV, POCREL5V, 
	TEMPADJ3, TEMPADJ2, TEMPADJ1, TEMPADJ0, AMPSEL, BGRTEST, TESTVOUT
	);

	input	LVIS3;		// LVI���o�d���ݒ�				(from csc)
	input	LVIS2;		// LVI���o�d���ݒ�				(from csc)
	input	LVIS1;		// LVI���o�d���ݒ�				(from csc)
	input	LVIS0;		// LVI���o�d���ݒ�				(from csc)
	input	LVIEN;		// LVI���싖�M��				(from csc)
	output	LVIOUTZ;	// LVI�o��					(to nf)
	output	POCREL;		// POC�o��					(to nf)
	output	POCREL5V;	// POC�o��(5V�n)				(to resetb)
	/*--------------*/
	/* ICE�pI/F	*/
	/*--------------*/
	input	SYSRESB;	// �{macro��F/F��Reset�p�B(POCor�[�qReset�M��)	(from csc)
	input	POCRESB;	// POC����					(from ice(resctl))
	input	VDDLEV7;	// �`�b�v�d����8bit A/D�ϊ�����(bit7)		(from ice(host I/F))
	input	VDDLEV6;	// �`�b�v�d����8bit A/D�ϊ�����(bit6)		(from ice(host I/F))
	input	VDDLEV5;	// �`�b�v�d����8bit A/D�ϊ�����(bit5)		(from ice(host I/F))
	input	VDDLEV4;	// �`�b�v�d����8bit A/D�ϊ�����(bit4)		(from ice(host I/F))
	input	VDDLEV3;	// �`�b�v�d����8bit A/D�ϊ�����(bit3)		(from ice(host I/F))
	input	VDDLEV2;	// �`�b�v�d����8bit A/D�ϊ�����(bit2)		(from ice(host I/F))
	input	VDDLEV1;	// �`�b�v�d����8bit A/D�ϊ�����(bit1)		(from ice(host I/F))
	input	VDDLEV0;	// �`�b�v�d����8bit A/D�ϊ�����(bit0)		(from ice(host I/F))
	input	USBIFWR;	// SG2�O���o�XI/F�p�N���b�N			(from ice(host I/F))
	input	PSEUDOON0;	// �[��LVI�M��(RESET MODE)			(from ice(pseudoemu))
	input	PSEUDOON8;	// �[��LVI�M��(INT & RESET MODE)		(from ice(pseudoemu))
	input	PONRESB;	// Power-ON Reset�M��				(from reset block)
	input	OPLVIMDS1;	// LVI���[�h�M��				(from ice())
	input	OPLVIMDS0;	// LVI���[�h�M��				(from ice())

	/*----------------------*/
	/* ���͂̂�(���g�p�[�q)	*/
	/*----------------------*/
	input	BG1EN;		// CP����BIASAMP Enable�M��			(from flash_cp)
	input	RESFB5V;	// Reset�M��					(from reset-buf)
	input	REGLV;		// REG�o�͓d���؂�ւ�				(from csc)
	input	REGLC;		// �d���\�͐؂�ւ�				(from csc)
	input	BGRT6;		// BGR Trimming�M��				(from cibc)
	input	BGRT5;		// BGR Trimming�M��				(from cibc)
	input	BGRT4;		// BGR Trimming�M��				(from cibc)
	input	BGRT3;		// BGR Trimming�M��				(from cibc)
	input	BGRT2;		// BGR Trimming�M��				(from cibc)
	input	BGRT1;		// BGR Trimming�M��				(from cibc)
	input	BGRT0;		// BGR Trimming�M��				(from cibc)
	input	BG1ST;		// CP����BIASAMP���������グ�M��		(from flash_cp)
	input	BG2ADEN;	// A/D����BIASAMP Enable�M��			(from adctl)
	input	BG2ADSEL;	// A/D����BIASAMP�o�͐ؑ֐M��			(from adctl)
	input	LVITEST;	// LVI�e�X�g���[�h				(from csc)
	input	LVITSEL;	// LVI�e�X�g���[�h�̌��o�Ώ�Select		(from csc)
	input	PAENB;		// Pch�A�V�X�g�@�\�̎g�p�����M��		(from csc)
	input	SENSEVDD;	// REG FeedBack���C��				(to regd)
	input	TEMPADJ3;	// BGR�o�͂̉��xTrimming�p���͐M��		(from cibc)
	input	TEMPADJ2;	// BGR�o�͂̉��xTrimming�p���͐M��		(from cibc)
	input	TEMPADJ1;	// BGR�o�͂̉��xTrimming�p���͐M��		(from cibc)
	input	TEMPADJ0;	// BGR�o�͂̉��xTrimming�p���͐M��		(from cibc)
	input	AMPSEL;		// VBG2AD�o�͐؂�ւ��p�M��			(from pulldown)
	input	BGRTEST;	// TESTVOUT�؂�ւ��M��				(from pulldown)
	/*----------------------*/
	/* �Œ�o��(���g�p�[�q)	*/
	/*----------------------*/
	output	VBG1;		// CP������d��(0.8V)				(to flash_cp)
	output	VBG08;		// 0.8V BGR��d���o��				(to h_rosc)
	output	BGIOREG2;	// 32MOSC�p�d����(TYP=50nA)			(to h_rosc)
	output	BGIOREG1;	// 32MOSC�p�d����(TYP=50nA)			(to h_rosc)
	output	VBG2AD;		// A/D������d��(1.4V)/���x�Z���T�[�o��	(to adhard)
	output	BGISUB3;	// SubOSC�p�d����(TYP=60nA)			(to oscsub)
	output	BGISUB2;	// SubOSC�p�d����(TYP=30nA)			(to oscsub)
	output	BGISUB1;	// SubOSC�p�d����(TYP=10nA)			(to oscsub)
	output	REGDRV;		// REG�o��					(to regd)
	output	PDRV;		// Pch�A�V�X�g�p����M��			(to regd)
	output	TESTVOUT;	// �e�X�g�p���o�͐M��				(to open)

	// [V1.01]
	// 1. lvivol���ŐV��Macro�d�l���ɍ��킹�ďC��
	// 1. LVI���o�덷�␳�-0.02V(���olevel��0.02V�������ω��ł��Ȃ�����)
	reg [7:0]	lvivol;
	always @( LVIS3 or LVIS2 or LVIS1 or LVIS0 ) begin
		casex ( {LVIS3, LVIS2, LVIS1, LVIS0} ) //synopsys parallel_case

			//SG2�����8bit��A/D�ϊ��l(VDDLEV7-0)�ɑ΂����rData (VDD/(5.5V/256))
			4'b0000    : lvivol = 8'b1000_0101 ; //2.87V(�␳�Ȃ�)
			4'b0001    : lvivol = 8'b0101_0110 ; //1.85V(�␳�Ȃ�)
			4'b0010    : lvivol = 8'b0101_0000 ; //1.74V(�␳�Ȃ�)
			4'b0011    : lvivol = 8'b0100_1100 ; //1.64V(�␳�Ȃ�)

			4'b0100    : lvivol = 8'b1000_1110 ; //3.07V(�␳�Ȃ�)
			4'b0101    : lvivol = 8'b0101_1111 ; //2.05V(�␳�Ȃ�)
			4'b0110    : lvivol = 8'b0101_1010 ; //1.95V(�␳�Ȃ�)
			4'b0111    : lvivol = 8'b0101_0110 ; //1.85V(�␳�Ȃ�)

			4'b1000    : lvivol = 8'b1010_1011 ; //3.68V(�␳�Ȃ�)
			4'b1001    : lvivol = 8'b0111_1011 ; //2.66V(�␳�Ȃ�)
			4'b1010    : lvivol = 8'b0111_0111 ; //2.56V(�␳�Ȃ�)
			4'b1011    : lvivol = 8'b0111_0010 ; //2.46V(�␳�Ȃ�)

			4'b1100    : lvivol = 8'b1011_1001 ; //3.99V(�␳�Ȃ�)
			4'b1101    : lvivol = 8'b1000_1010 ; //2.97V(�␳�Ȃ�)
			4'b1110    : lvivol = 8'b1000_0101 ; //2.87V(�␳�Ȃ�)
			4'b1111    : lvivol = 8'b1000_0000 ; //2.76V(�␳�Ȃ�)
		endcase
	end

	reg [7:0]	vddvol;
	always @( negedge SYSRESB or negedge USBIFWR ) begin
		if (!SYSRESB)
			vddvol <= 8'b1111_1111;
		else	vddvol <= { VDDLEV7, VDDLEV6, VDDLEV5, VDDLEV4,
				VDDLEV3, VDDLEV2, VDDLEV1, VDDLEV0 };
	end

	reg LVIOZ_pp;
	always @( LVIEN or vddvol or lvivol ) begin
		if (LVIEN) begin
			if (vddvol > lvivol)
				LVIOZ_pp <= 1'b1;
			else	LVIOZ_pp <= 1'b0;
		end
		else		LVIOZ_pp <= 1'b1;
	end

	// [V101] �ǉ�. N/F���폜�����̂ŕK�v.
	//LVI�������P(lvivol�̕ω����Ɋe�r�b�g�̕ω��Ńq�Q���łȂ��悤�ɂ���)
	reg LVIOZ_p;
	always @( negedge SYSRESB or negedge USBIFWR ) begin
		if ( !SYSRESB )	LVIOZ_p <= 1'b1;
		else		LVIOZ_p <= LVIOZ_pp;
	end

	// [V101]
	// (1)LVIOZ_pp -> LVIOZ_p��
	// (2)LVIOZNFP->LVIOUTZ�֐M�����ύX
	// �[��LVI
	// assign	LVIOUTZ = LVIOZ_p & ~PSEUDOON0;

	// [V103]
	// �[��LVI
	// �[��LVI(INT)�𔭍s����LVI���o�d���l���ς����猳�ɖ߂��B
	reg regst;
	always @(LVIEN or LVIS3 or LVIS2 or LVIS1 or LVIS0 ) begin
		casex ( {LVIEN,LVIS3, LVIS2, LVIS1, LVIS0} ) //synopsys parallel_case
		
			5'b10011 : regst =1'b1 ;
			5'b10111 : regst =1'b1 ;
			5'b11011 : regst =1'b1 ;
			5'b11111 : regst =1'b1 ;
 			default  : regst =1'b0 ;
		endcase
	end

	reg PSEUDOON8_m;
	always @( PSEUDOON8 or OPLVIMDS1 or OPLVIMDS0 ) begin
		casex ( {PSEUDOON8,OPLVIMDS1,OPLVIMDS0})

			3'b101 : PSEUDOON8_m = 1'b1 ;
			3'b110 : PSEUDOON8_m = 1'b1 ;
			default : PSEUDOON8_m = 1'b0 ;
		endcase
	end

	wire lvi_int;
	assign lvi_int = PSEUDOON8_m & ~regst;

	wire lvi_giji;
	assign	lvi_giji = lvi_int | PSEUDOON0;

	assign	LVIOUTZ = LVIOZ_p & ~lvi_giji;

//	N/F�폜
//	reg [2:0] lvi;
//	always @(negedge USBIFWR or negedge SYSRESB) begin
//		if (!SYSRESB)	lvi <= 3'h7;
//		else		lvi <= { lvi[1], lvi[0] ,LVIOZ_pp };
//	end
	
//	reg LVIOZ;
//	always @(negedge USBIFWR) begin
//		if ((lvi[2]==LVIOZ_pp)&&(lvi[1]==LVIOZ_pp)&&(lvi[0]==LVIOZ_pp)) begin
//			LVIOZ <= lvi[2];
//		end
//	end

// �[��LVI
//	assign	LVIOZNFP = LVIOZ & ~PSEUDOON0;

//
// POC
//
	assign	POCREL = POCRESB;
	assign	POCREL5V = POCRESB;	// [V205]

//
// ���͂̂�(���g�p�[�q)
//
	//BG1EN;		// from flash_cp
	//RESFB5V;		// reset-buf��ICE�ł͎������Ȃ��̂�,���͂��Œ肷��
	//REGLV;		// from csc
	//REGLC;		// from csc
	//BGRT0;		// from cibc
	//BGRT1;		// from cibc
	//BGRT2;		// from cibc
	//BGRT3;		// from cibc
	//BGRT4;		// from cibc
	//BGRT5;		// from cibc
	//BGRT6;		// from cibc
	//BG1ST;		// from flash_cp
	//BG2ADEN;		// from adctl
	//BG2ADSEL;		// from adctl
	//LVITEST;		// from csc
	//LVITSEL;		// from csc
	//PAENB;		// from csc
	//SENSEVDD;		// from regd
	//TEMPADJ3;		// from cibc
	//TEMPADJ2;		// from cibc
	//TEMPADJ1;		// from cibc
	//TEMPADJ0;		// from cibc
	//AMPSEL;		// from flash_cp
	//BGRTEST;		//

//
// �Œ�o��(���g�p�[�q)
//
	assign	VBG1 = 1'b0;		// to flash_cp
	assign	VBG08 = 1'b0;		// to h_rosc
	assign	BGIOREG1 = 1'b0;	// to h_rosc
	assign	BGIOREG2 = 1'b0;	// to h_rosc
	assign	VBG2AD = 1'b0;		// adhard��ICE�ł͎������Ȃ��̂�,�o��Open�ƂȂ�
	assign	BGISUB1 = 1'b0;		// to oscsub
	assign	BGISUB2 = 1'b0;		// to oscsub
	assign	BGISUB3 = 1'b0;		// to oscsub
	assign	REGDRV = 1'b0;		// regd��ICE�ł͎������Ȃ��̂�,�o��Open�ƂȂ�
	assign	PDRV = 1'b0;		// regd��ICE�ł͎������Ȃ��̂�,�o��Open�ƂȂ�
	assign	TESTVOUT = 1'b0;	// ���o�͐M������ICE�ł͎g�p���Ȃ��̂ŏo��Open�Ƃ���B

endmodule
	
