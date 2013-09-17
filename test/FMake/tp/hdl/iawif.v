/************************************************************************/
/* Date		: 2008/10/03						*/
/* Revision	: 1.00  (***** FX3用を流用 *****)			*/
/* Designer	: T.Tsunoda						*/
/* Note		: for IAW Emulation.					*/
/*		: ・IAW ResetをPeripheral Breakとして機能させる。	*/
/*		: ・SVSTOP(=SVMODI)を接続すると、SoftWareBreakと 同時に	*/
/*		:   検出条件が発生した場合に検出できない場合があるため、*/
/*		:   ICEmacroと同じSVMOD信号を使用。ただし、このMaskを	*/
/*		:   行うとSVMODのStackライトが検出されてしまう為、IAWに	*/
/*		:   ついては更にCPUWR信号にSOFTBRKの反転をANDさせる。	*/
/************************************************************************/
/* Date		: 2010/02/18						*/
/* Revision	: 1.01							*/
/* Designer	: T.Tsunoda						*/
/* Note		: SoftWare Breakと競合時もIAWRESが有効となるよう変更。	*/
/************************************************************************/

module IAWIF ( IAWRES, PERISVIB, SVMOD, SOFTBRK, SVSTOPIAW, CPUWR, CPUWRIAW, FCLKRT, RESB );
	// iaw reset emu
	input	IAWRES;
	output	PERISVIB;
	
	// SoftWareBreak対策
	input	SVMOD, CPUWR, SOFTBRK, FCLKRT, RESB;
	output	SVSTOPIAW, CPUWRIAW;
	
	// --------------------------------------------------------------------------------
	// <SoftWare Breakと競合時もIAWRESを有効にする為の処置>
	// SOFTBRKを切り直してSVMOD2clock分のMaskをつくる場合、Or条件によるひげがでる。
	// IAWではSVMODをEdgeで使用しているためひげは許されないのでこの作りとした。
	// この2clockはsvmodのstack writeのtimingなので、iawで使うcpuwr(CPUWRIAW)はMaskする。
	// このTimingでリード/フェッチのilligal Accessは発生しない。
	// -> failsafeの方でsvmodでmaskしている場合は効果なし。
	// --------------------------------------------------------------------------------
	// 他のHardWare Breakと競合時はCareしない。(Maskされる場合がある。)その場合は別の
	// FailsafeでIlligal Accessを判断できる為。
	// --------------------------------------------------------------------------------
	reg svmod_wait;
	always @(posedge FCLKRT or negedge RESB) begin
		if (!RESB)
			svmod_wait <= 1'b0;
		else if (SOFTBRK)
			svmod_wait <= svmod_wait;
		else	svmod_wait <= SVMOD;
	end
	assign	SVSTOPIAW = SVMOD & svmod_wait;

	assign	svmod_writemask = SVMOD & ~svmod_wait;
	assign	CPUWRIAW = CPUWR & ~svmod_writemask;

	assign	PERISVIB = ~IAWRES;

endmodule

