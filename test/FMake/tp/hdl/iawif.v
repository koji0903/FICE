/************************************************************************/
/* Date		: 2008/10/03						*/
/* Revision	: 1.00  (***** FX3$BMQ$rN.MQ(B *****)			*/
/* Designer	: T.Tsunoda						*/
/* Note		: for IAW Emulation.					*/
/*		: $B!&(BIAW Reset$B$r(BPeripheral Break$B$H$7$F5!G=$5$;$k!#(B	*/
/*		: $B!&(BSVSTOP(=SVMODI)$B$r@\B3$9$k$H!"(BSoftWareBreak$B$H(B $BF1;~$K(B	*/
/*		:   $B8!=P>r7o$,H/@8$7$?>l9g$K8!=P$G$-$J$$>l9g$,$"$k$?$a!"(B*/
/*		:   ICEmacro$B$HF1$8(BSVMOD$B?.9f$r;HMQ!#$?$@$7!"$3$N(BMask$B$r(B	*/
/*		:   $B9T$&$H(BSVMOD$B$N(BStack$B%i%$%H$,8!=P$5$l$F$7$^$&0Y!"(BIAW$B$K(B	*/
/*		:   $B$D$$$F$O99$K(BCPUWR$B?.9f$K(BSOFTBRK$B$NH?E>$r(BAND$B$5$;$k!#(B	*/
/************************************************************************/
/* Date		: 2010/02/18						*/
/* Revision	: 1.01							*/
/* Designer	: T.Tsunoda						*/
/* Note		: SoftWare Break$B$H6%9g;~$b(BIAWRES$B$,M-8z$H$J$k$h$&JQ99!#(B	*/
/************************************************************************/

module IAWIF ( IAWRES, PERISVIB, SVMOD, SOFTBRK, SVSTOPIAW, CPUWR, CPUWRIAW, FCLKRT, RESB );
	// iaw reset emu
	input	IAWRES;
	output	PERISVIB;
	
	// SoftWareBreak$BBP:v(B
	input	SVMOD, CPUWR, SOFTBRK, FCLKRT, RESB;
	output	SVSTOPIAW, CPUWRIAW;
	
	// --------------------------------------------------------------------------------
	// <SoftWare Break$B$H6%9g;~$b(BIAWRES$B$rM-8z$K$9$k0Y$N=hCV(B>
	// SOFTBRK$B$r@Z$jD>$7$F(BSVMOD2clock$BJ,$N(BMask$B$r$D$/$k>l9g!"(BOr$B>r7o$K$h$k$R$2$,$G$k!#(B
	// IAW$B$G$O(BSVMOD$B$r(BEdge$B$G;HMQ$7$F$$$k$?$a$R$2$O5v$5$l$J$$$N$G$3$N:n$j$H$7$?!#(B
	// $B$3$N(B2clock$B$O(Bsvmod$B$N(Bstack write$B$N(Btiming$B$J$N$G!"(Biaw$B$G;H$&(Bcpuwr(CPUWRIAW)$B$O(BMask$B$9$k!#(B
	// $B$3$N(BTiming$B$G%j!<%I(B/$B%U%'%C%A$N(Billigal Access$B$OH/@8$7$J$$!#(B
	// -> failsafe$B$NJ}$G(Bsvmod$B$G(Bmask$B$7$F$$$k>l9g$O8z2L$J$7!#(B
	// --------------------------------------------------------------------------------
	// $BB>$N(BHardWare Break$B$H6%9g;~$O(BCare$B$7$J$$!#(B(Mask$B$5$l$k>l9g$,$"$k!#(B)$B$=$N>l9g$OJL$N(B
	// Failsafe$B$G(BIlligal Access$B$rH=CG$G$-$k0Y!#(B
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

