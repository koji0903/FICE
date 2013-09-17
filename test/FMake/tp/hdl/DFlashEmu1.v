//----------------------------------------------------------
//■v1.9
//  デバイスFCB QLK0RFCBM3SF1V1 Version1.11 のAFアドレス
//  変更に伴う修正。(F1000H→F0000H)
//----------------------------------------------------------
//■v1.10
//  FCB動作中のブレークをサポート。FCBのステータス信号類を
//  SVMODでマスクしていたが、これらを外した。
//  ememrom-SS3rd.v の SS3rd Ver1011→1013と同様の変更。
//----------------------------------------------------------
//■v1.11
//  - ERR_CMPのswap信号追加の対応
//  - errmskhxレジスタ 3bit -> 4bit
//----------------------------------------------------------
//  $Id: DFlashEmu1.v,v 1.11 2010-10-20 11:52:45 snisimu Exp $

module DFLASHEMU1 (
        CLK60MHZ, CLK30MHZ, 
	//----- Firm Debug Output -----
	DRDCLKP1_OUT, DWWR_OUT, DCER_OUT, DSER_OUT, DMRG00_OUT, DMRG01_OUT, DMRG10_OUT,
	DMRG11_OUT, DMRG12_OUT, DDIS_OUT, DREAD_OUT, DFCLK_OUT,
		   
	//----- HOST I/F -----
	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
	ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0,
	ICEDOU31, ICEDOU30, ICEDOU29, ICEDOU28, ICEDOU27, ICEDOU26, ICEDOU25, ICEDOU24,
	ICEDOU23, ICEDOU22, ICEDOU21, ICEDOU20, ICEDOU19, ICEDOU18, ICEDOU17, ICEDOU16,
	ICEDOU15, ICEDOU14, ICEDOU13, ICEDOU12, ICEDOU11, ICEDOU10, ICEDOU9, ICEDOU8,
	ICEDOU7, ICEDOU6, ICEDOU5, ICEDOU4, ICEDOU3, ICEDOU2, ICEDOU1, ICEDOU0,
	ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
	ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
	ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
	ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0,
	ICEWR,
		   
	//----- EVA CORE I/F -----
	SVMOD, SVMODF, ALT1, PREFIX,
	SLFLASH, FLREAD,
	PA19, PA18, PA17, PA16, PA15, PA14, PA13, PA12, PA11, PA10, PA9, PA8, PA7, PA6, PA5, PA4, PA3, PA2,
	SLMEM, EXMA3, EXMA2, EXMA1, EXMA0,
	MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8, MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0,
	MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8, MDW7, MDW6, MDW5, MDW4, MDW3, MDW2, MDW1, MDW0,
	DFMDR15, DFMDR14, DFMDR13, DFMDR12, DFMDR11, DFMDR10, DFMDR9, DFMDR8,
	DFMDR7, DFMDR6, DFMDR5, DFMDR4, DFMDR3, DFMDR2, DFMDR1, DFMDR0,
	CPUWR, CPURD, WDOP,
		   
	//----- SLBMEM I/F -----
	SLBMEM,

	//----- FLASH I/F -----
	DCLKSEL1, DRDCLK, DRDCLKC1, RDCLKP1, DCE0,
	AF19, AF18, AF17, AF16, AF15, AF14, AF13, AF12, AF11, AF10, AF9, AF8, AF7, AF6, AF5, AF4, AF3, AF2, AF1, AF0,
	DA13, DA12, DA11, DA10, DA9, DA8, DA7, DA6, DA5, DA4, DA3, DA2, DA1, DA0,
	//DFLRO11, DFLRO10, DFLRO9, DFLRO8, DFLRO7, DFLRO6, DFLRO5, DFLRO4, DFLRO3, DFLRO2, DFLRO1, DFLRO0, 
	DRO11, DRO10, DRO9, DRO8, DRO7, DRO6, DRO5, DRO4, DRO3, DRO2, DRO1, DRO0, 
	DWWR, DCER, DSER, DMRG00, DMRG01, DMRG10, DMRG11, DMRG12, DDIS, DREAD, FCLK, DWED, PROGI,
	DW11, DW10, DW9, DW8, DW7, DW6, DW5, DW4, DW3, DW2, DW1, DW0,
	BEU2, BEU1, BEU0, ICEFLERRD,

	//----- OHTER -----
	CPURSOUTB, SYSRSOUTB, BASECK

);

        input CLK60MHZ, CLK30MHZ ;
   
// Firm Debug Output I/F
	output	DRDCLKP1_OUT, DWWR_OUT, DCER_OUT, DSER_OUT, DMRG00_OUT, DMRG01_OUT, DMRG10_OUT,
		DMRG11_OUT, DMRG12_OUT, DDIS_OUT, DREAD_OUT, DFCLK_OUT;

// HOST I/F
	input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
		ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
		ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
		ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0;
	output	ICEDOU31, ICEDOU30, ICEDOU29, ICEDOU28, ICEDOU27, ICEDOU26, ICEDOU25, ICEDOU24,
		ICEDOU23, ICEDOU22, ICEDOU21, ICEDOU20, ICEDOU19, ICEDOU18, ICEDOU17, ICEDOU16,
		ICEDOU15, ICEDOU14, ICEDOU13, ICEDOU12, ICEDOU11, ICEDOU10, ICEDOU9, ICEDOU8,
		ICEDOU7, ICEDOU6, ICEDOU5, ICEDOU4, ICEDOU3, ICEDOU2, ICEDOU1, ICEDOU0;
	input	ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
		ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
		ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
		ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0,
		ICEWR;

// EVA CORE I/F
	input	SVMOD, SVMODF, ALT1, PREFIX;
	input	SLFLASH, FLREAD;
	input	PA19, PA18, PA17, PA16, PA15, PA14, PA13, PA12, PA11, PA10, PA9, PA8, PA7, PA6, PA5, PA4, PA3, PA2;
	input	SLMEM;
	input   EXMA3, EXMA2, EXMA1, EXMA0;
	input	MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8, MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0;
	input	MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8, MDW7, MDW6, MDW5, MDW4, MDW3, MDW2, MDW1, MDW0;
	output	DFMDR15, DFMDR14, DFMDR13, DFMDR12, DFMDR11, DFMDR10, DFMDR9, DFMDR8;
	output	DFMDR7, DFMDR6, DFMDR5, DFMDR4, DFMDR3, DFMDR2, DFMDR1, DFMDR0;
	input	CPUWR, CPURD, WDOP;

// SLBMEM I/F
	input   SLBMEM;

// FLASH I/F
	input	DCLKSEL1, DRDCLK, DRDCLKC1, RDCLKP1, DCE0 ;
        input  	AF19, AF18, AF17, AF16, AF15, AF14, AF13, AF12, AF11, AF10, AF9, AF8, AF7, AF6, AF5, AF4, AF3, AF2, AF1, AF0;
	input	DA13, DA12, DA11, DA10, DA9, DA8, DA7, DA6, DA5, DA4, DA3, DA2, DA1, DA0;
        //output 	DFLRO11, DFLRO10, DFLRO9, DFLRO8, DFLRO7, DFLRO6, DFLRO5, DFLRO4, DFLRO3, DFLRO2, DFLRO1, DFLRO0;
	output	DRO11, DRO10, DRO9, DRO8, DRO7, DRO6, DRO5, DRO4, DRO3, DRO2, DRO1, DRO0;
        input	DWWR, DCER, DSER, DMRG00, DMRG01, DMRG10, DMRG11, DMRG12, DDIS, DREAD, FCLK, DWED, PROGI;
	input	DW11, DW10, DW9, DW8, DW7, DW6, DW5, DW4, DW3, DW2, DW1, DW0;
	input	BEU2, BEU1, BEU0;
	output	ICEFLERRD;

// OHTER
	input	CPURSOUTB, SYSRSOUTB, BASECK;

//-------------------------------------------------------------------------------------------------

   wire DCLKSEL1 ;
   
   wire        eromrd_b, eromwr_b, eromcs_b, eromclk;
   wire [17:0] erompa;
   wire [31:0] eromrd, eromwd;

   wire [11:0] dro_fcb, dro_cib ;
   wire [15:0] dfmdr;
   
	assign {DFMDR15, DFMDR14, DFMDR13, DFMDR12, DFMDR11, DFMDR10, DFMDR9, DFMDR8,
					DFMDR7, DFMDR6, DFMDR5, DFMDR4, DFMDR3, DFMDR2, DFMDR1, DFMDR0}
		  = dfmdr ;

	wire [31:0] icedo;
	assign {ICEDOU31, ICEDOU30, ICEDOU29, ICEDOU28, ICEDOU27, ICEDOU26, ICEDOU25, ICEDOU24,
		ICEDOU23, ICEDOU22, ICEDOU21, ICEDOU20, ICEDOU19, ICEDOU18, ICEDOU17, ICEDOU16,
		ICEDOU15, ICEDOU14, ICEDOU13, ICEDOU12, ICEDOU11, ICEDOU10, ICEDOU9, ICEDOU8,
		ICEDOU7, ICEDOU6, ICEDOU5, ICEDOU4, ICEDOU3, ICEDOU2, ICEDOU1, ICEDOU0}
		= icedo ;

        wire [19:0] a19_0 ;
        assign a19_0 = {AF19, AF18, AF17, AF16, {AF15, AF14, AF13, AF12} + 4'b0001, AF11, AF10, AF9, AF8, AF7, AF6, AF5, AF4, AF3, AF2, AF1, AF0} ;
   
	DFLASHEMU1MAIN main (
		.eromrd_b(eromrd_b), .eromwr_b(eromwr_b), .eromcs_b(eromcs_b), .eromclk(eromclk),
		.erompa(erompa), .eromrd(eromrd), .eromwd(eromwd),
		.rdclkp1_out(RDCLKP1_OUT),
		.wwr_out(DWWR_OUT), .cer_out(DCER_OUT), .ser_out(DSER_OUT),
		.mrg00_out(DMRG00_OUT), .mrg01_out(DMRG01_OUT), .mrg10_out(DMRG10_OUT), .mrg11_out(DMRG11_OUT),
		.mrg12_out(DMRG12_OUT), .dis_out(DDIS_OUT), .read_out(DREAD_OUT),
		.fclk_out(DFCLK_OUT),
		.svmod(SVMOD), .svmodf(SVMODF), .alt1(ALT1), .prefix(PREFIX),
		.slflash(SLFLASH), .flread(FLREAD),
		.pa({PA19, PA18, PA17, PA16, PA15, PA14, PA13, PA12, PA11, PA10, PA9, PA8, PA7, PA6, PA5, PA4, PA3, PA2}),
		.waitfl2(WAITFL2),
		.slmem(SLMEM), .exma({EXMA3, EXMA2, EXMA1, EXMA0}),
		.ma({MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8, MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0}),
		.mdw({MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8, MDW7, MDW6, MDW5, MDW4, MDW3, MDW2, MDW1, MDW0}),
		.memmdr(dfmdr),
		.flma({FLMA15, FLMA14, FLMA13, FLMA12, FLMA11, FLMA10, FLMA9, FLMA8,
		FLMA7, FLMA6, FLMA5, FLMA4, FLMA3, FLMA2, FLMA1, FLMA0}),
		.cpuwr(CPUWR), .cpurd(CPURD), .wdop(WDOP),
		.slbmem(SLBMEM),
		.clksel1(DCLKSEL1), .rdclkp1(RDCLKP1), .ce0(DCE0), .ce1(1'b0),
		.a19_0(a19_0), 
		.dro(dro_fcb),
		.wwr(DWWR), .cer(DCER), .ser(DSER), .mrg00(DMRG00), .mrg01(DMRG01), .mrg10(DMRG10),
		.mrg11(DMRG11), .mrg12(DMRG12), .dis(DDIS), .read(DREAD), .progi(PROGI),
		.fclk(FCLK), .wed(DWED),
		.dw({DW11, DW10, DW9, DW8, DW7, DW6, DW5, DW4, DW3, DW2, DW1, DW0}),
		.beu({BEU2, BEU1, BEU0}),
		.iceflerr(ICEFLERRD),
		.cpuresetb(CPURSOUTB), .sysrsoutb(SYSRSOUTB),
		.baseck(BASECK), .ck30mhz(CLK30MHZ)
	);
   
	DFLASHRAM dflashram (
		.CLK60MHZ(CLK60MHZ), .BASECK(BASECK),
		.eromrd_b(eromrd_b), .eromwr_b(eromwr_b), .eromcs_b(eromcs_b), .eromclk(eromclk),
		.erompa(erompa), .eromrd(eromrd), .eromwd(eromwd),
		.DCLKSEL1(DCLKSEL1), .da({DA13, DA12, DA11, DA10, DA9, DA8, DA7, DA6, DA5, DA4, DA3, DA2, DA1, DA0}),
		//.dro({DRO11, DRO10, DRO9, DRO8, DRO7, DRO6, DRO5, DRO4, DRO3, DRO2, DRO1, DRO0}),
		.dro(dro_cib),
		.iceifa({ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
		ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
		ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
		ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0}),
		.icedo(icedo),
		.icedi({ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
		ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
		ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
		ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0}),
		.icewr(ICEWR)
	);

   assign {DRO11, DRO10, DRO9, DRO8, DRO7, DRO6, DRO5, DRO4, DRO3, DRO2, DRO1, DRO0} = (DCLKSEL1) ? dro_cib : dro_fcb ;

endmodule

module DFLASHEMU1MAIN (
	eromrd_b, eromwr_b, eromcs_b, eromclk, erompa, eromrd, eromwd,
	rdclkp1_out,
	wwr_out, cer_out, ser_out, exer_out,
	mrg00_out, mrg01_out, mrg10_out, mrg11_out, mrg12_out, dis_out, read_out,
	fclk_out, progi_out,
	svmod, svmodf, alt1, prefix, slflash, flread, pa, waitfl2,
	slmem, exma, ma, mdw, memmdr, flma, cpuwr, cpurd, wdop,
	slbmem,
	clksel1, rdclkp1, ce0, ce1, a19_0, dro,
	exch, wwr, cer, ser, mrg00, mrg01, mrg10, mrg11, mrg12, dis, read,
	fclk, progi, wed, dw, beu, iceflerr,
	cpuresetb, sysrsoutb, baseck, ck30mhz
	);

	//----- SRAM I/F -----//
	output eromrd_b, eromwr_b, eromcs_b, eromclk;
	output [17:0] erompa;
	input  [31:0] eromrd;
	output  [31:0] eromwd;

	//----- CIB Signal Output Pin -----//
	output rdclkp1_out;

	//----- FCB Signal Output Pin -----//
	output wwr_out, cer_out, ser_out, exer_out,
	       mrg00_out, mrg01_out, mrg10_out, mrg11_out, mrg12_out, dis_out, read_out,
	       fclk_out, progi_out;

	//----- EVA CORE I/F -----//
	input  svmod;
	input  svmodf;
	input  alt1;
	input  prefix;
	input  slflash;
	input  flread;
	input  [17:0] pa;
	output waitfl2;
	input  slmem;
	input  [3:0] exma;
	input  [15:0] ma, flma;
	input  [15:0] mdw;
	output [15:0] memmdr;
	input  cpuwr;
	input  cpurd;
	input  wdop;

	//----- SLBMEM I/F -----//
	input  slbmem;

	//----- CIB I/F -----//
	input  clksel1;
	input  rdclkp1;
	input  ce0;
	input  ce1;
	input  [19:0] a19_0;
	output [11:0] dro;

	//----- FCB I/F -----//
	input  exch;
	input  wwr;
	input  cer;
	input  ser;
	input  mrg00;
	input  mrg01;
	input  mrg10;
	input  mrg11;
	input  mrg12;
	input  dis;
	input  read;
	input  fclk;
	input  progi;
	input  wed;
	input  [11:0] dw;
	input  [2:0]  beu;
	output iceflerr;

	//----- OTHER I/F -----//
	input  cpuresetb;
	input  sysrsoutb;
	input  baseck;
	input  ck30mhz ;

//-----------------------------------------------------------------------------------------------//
// ★Internal Signal                                                                             //
//-----------------------------------------------------------------------------------------------//
	//----- Read Mode Signal -----//
	wire read_mode;

	//----- Erase Mode Signal -----//
	wire erase_mode;

	//----- FCLK Control -----//
//	wire fclk_in;

	//----- CPU Address Signal -----//
	wire [17:0] cpu_adr_dec;
	reg  [17:0] cpu_adr;
	wire [17:0] a_dec;

	//----- CE -----//
	wire ce;

	//----- RDCLK -----//
	wire rdclk;

	//----- SRAM I/F Signal -----//
	wire eromclk;
	wire [17:0] erompa;
	reg	 [15:0] memmdr;
	
	wire [17:0] erompa_pre;
	wire [31:0] erom_wd;
	wire [31:0] erom_wd_pre;
	wire eromrd_b_pre;
	wire eromwr_b_pre;
	wire eromcs_b_pre;

	wire flash_cs;

	wire sl_cpurd;
	wire cpu_rd;
	wire selfread_flag;
	reg  sl_selfcpurd;
	wire selfread_resetb;
	reg  selfread_en;

	wire erase_en;
	reg  progi_l;
	wire progi_resetb;
	reg  flwrite_en_pre;
	wire flwrite_en;

	wire sl_cpubus;
	wire [31:0] cpu_wr_data;

	//----- ALTROM I/F Signal -----//
	wire [31:0] alt_cpu_do = 32'h0000_0000 ;
	wire [31:0] alt_ice_do, alt_ice_di;
	wire altromcs, alt_icewr;
	wire [17:0] alt_pa, alt_iceifa;

	//----- HOST Emulation Registor -----//
	reg  [1:0] icedo_reg;
	reg  maacopy;
	wire slmaa;
	reg  debugmode;
	reg  fsexeflag;
    wire flag_resetb;

	//----- IROM Write Emulation Registor -----//
	reg	 [15:0] romwd0;
	reg  [15:0] romwd1;
	reg  [15:0] romwa0;
	reg  [3:0]  romwa1;
	reg  [1:0]  romcksel, cpu_romcksel, ice_romcksel;
	reg  romcs;
	reg  romwren;
	wire romwritemode;
	wire altreg_rd;
	wire hostreg_sel;
	wire romwrite_en;
	wire mcksel = 1'b1; // Can not select 30MHz access for DFlash.
	wire [17:0] romwa;
	wire sl_swap;
	wire [17:0] romwa_dec;

	wire ice_user_res1;
	reg  icewr_start;
	reg  icewr_start_latch;
	reg  ice_write_latch;
	wire icerd_mask = 1'b0 ;

	wire ice_alt_res1;
	reg  alt_icewr_start;
	reg  alt_icewr_start_latch;
	reg  alt_ice_write;
	reg  alt_ice_write_latch;
	wire alt_icerd_mask;

	wire ice_reg_res1;
	wire cpu_reg_res1;

	reg  reg_icewr_start;
	reg  reg_cpuwr_start;

	reg  ice_reg_write;
	reg  cpu_reg_write;

	//----- Flash Read Timing Signal -----//
	wire alt1_flread_cs_b;
	reg  flread_rd;

	//----- ROM Write Registor Signal -----//
   wire      rom_cs = 1'b0;
   wire      romwr_en = 1'b0;

	//----- RO Hold Signal -----//
	reg  [37:0] ro;
	wire [31:0] ro_hold;
	reg  [31:0] ro_l;
	reg  ce_l;

	//----- 2ndSFR(Used ICE) -----//
	reg  [15:0] iceadr;
	reg  [15:0] icedat;
	wire sl_icesfr;
	wire sl_icesfr_read;
	wire sl_icesfr_write;
	reg  icesfr_wr;
	wire icesfr_rd;
	reg  [15:0] icedat_read;
	wire exma_flag;

	//----- Error Emulation -----//
	reg  [15:0] erradrl1, erradrl2, erradrl3, erradrl4, erradrl5;
	reg  [3:0] erradrh1, erradrh2, erradrh3, erradrh4, erradrh5;
	reg  [5:0]  err_mode1, err_mode2, err_mode3, err_mode4, err_mode5;
	reg  [15:0] errmskl1, errmskl2, errmskl3, errmskl4, errmskl5;
	reg  [3:0] errmskh1, errmskh2, errmskh3, errmskh4, errmskh5;
	reg  [7:0] err_count1, err_count2, err_count3, err_count4, err_count5;

	//----- ICEFLERR OutPut -----
	wire iceflerr_out;

	//----- Erase Address Registor-----//
	reg  [17:0] ser_adr;
//	reg  [16:0] cmp_reg;

	//----- ICE use Mode Signal -----//
	wire wwr_dbg;
	wire cer_dbg;
	wire ser_dbg;
	wire mrg00_dbg;
	wire mrg01_dbg;
	wire mrg10_dbg;
	wire mrg11_dbg;
	wire mrg12_dbg;
	wire dis_dbg;
	wire read_dbg;
	wire read_mode_dbg;

	//----- DIS,WWR,READ,MRGxx Mode Address Latch -----//
	reg  [17:0] cpu_adr_latch;
	reg  [17:0] adr_latch_dis;
	reg  [17:0] adr_latch_read;
	reg  [3:0] exa_beu_latch;

	wire [17:0] cpu_adr_read;
	wire sel_latch_wwr;
	wire sel_latch_dis;
	wire sel_latch_read;
	wire sel_read_resetb;
	reg  sel_read_flag;

	//----- CER/SER Mode Address Counter -----//
	wire [16:0] count_adr;
//	wire count_adr_max;
//	wire count_resetb;
//	wire overflow;
//	wire sel_count;

	wire auto_change;
	wire reg_write;
	wire [1:0] reg_write_data;

	wire exa = 1'b0 ;
        wire ice_write = 1'b0 ;

//------------------------------------------------------------------------------------------------//
// 常に1の信号生成、合成時に縮退させないため                                                      //
//------------------------------------------------------------------------------------------------//
	wire dmy1 = sysrsoutb | slflash;
	wire dmy2 = sysrsoutb | slflash;

//------------------------------------------------------------------------------------------------//
// OUTPUT PIN                                                                                     //
//------------------------------------------------------------------------------------------------//
        wire exa_out;
	//----- CIB/FCB Signal OUTPUT -----//
	assign rdclkp1_out = rdclkp1;
	assign exa_out = exa;
	assign wwr_out = wwr;
	assign cer_out = cer;
	assign ser_out = ser;
	assign exer_out = 1'b0;
	assign mrg00_out = mrg00;
	assign mrg01_out = mrg01;
	assign mrg10_out = mrg10;
	assign mrg11_out = mrg11;
	assign mrg12_out = mrg12;
	assign dis_out = dis;
	assign read_out = read;
	assign fclk_out = fclk;
	assign progi_out = progi;

	//----- ICEFLERR OUTPUT -----//
	assign iceflerr = iceflerr_out;

	//----- WAIT SIGNAL OUTPUT -----//
	assign eromwait = icerd_mask | alt_icerd_mask;
	assign waitfl2 = 1'b0;

//------------------------------------------------------------------------------------------------//
// FLASH SELF MODE Control                                                                        //
//------------------------------------------------------------------------------------------------//
// FLSPMDを強制的に解除する時、アクセスモード信号も同じく強制的に解除する。という思想が           //
// 初期にはあったが、SS3rdからはブレークありなのでステータスはSVMODでマスクしない。               //
// (このような背景から、無駄に_dbgの付いた信号が残っている。)                                     //
// リード系のアクセスモードはread_modeとして一つにまとめる                                        //
//------------------------------------------------------------------------------------------------//
	assign wwr_dbg = wwr; // as [SS3rd Ver1013]
	assign cer_dbg = cer; // as [SS3rd Ver1012]
	assign ser_dbg = ser; // as [SS3rd Ver1012]
	assign mrg00_dbg = mrg00; // as [SS3rd Ver1013]
	assign mrg01_dbg = mrg01; // as [SS3rd Ver1013]
	assign mrg10_dbg = mrg10; // as [SS3rd Ver1013]
	assign mrg11_dbg = mrg11; // as [SS3rd Ver1013]
	assign mrg12_dbg = mrg12; // as [SS3rd Ver1013]
	assign dis_dbg = dis; // as [SS3rd Ver1013]
	assign read_dbg = read; // as [SS3rd Ver1013]

	assign read_mode = mrg00 | mrg01 | mrg10 | mrg11 | mrg12 | read;
	assign read_mode_dbg = read_mode; // as [SS3rd Ver1013]

//------------------------------------------------------------------------------------------------//
// ★ce の生成 -> Chip Enable                                                                     //
//------------------------------------------------------------------------------------------------//
	assign ce = ce0 | ce1;

//------------------------------------------------------------------------------------------------//
// ★EROMCLK Select                                                                               //
//------------------------------------------------------------------------------------------------//
// ROMCKSELレジスタのmckselの値でBASECKかCK60MHZを選択する                                        //
// mcksel = 1 : BASECK                                                                            //
// mcksel = 0 : CK60MHZ                                                                           //
// FPGAのプリミティブBUFGMUXが使えないためクロック切り替え時専用のモジュールを作りこみ            //
// クロック切り替え時にヒゲが発生しないようにする                                                 //
//------------------------------------------------------------------------------------------------//
// 以下は以前の仕様 -> ROMの書き換わり対策で仕様を変更したため一応記述のみ残しておく              //
// ---------------------------------------------------------------------------------------------- //
// WWRモードでは書き込みクロックがFCLKとなる                                                      //
// ホストからのアクセスにはCK60MHzを使用することができる(mckselで選択)                            //
// RDCLKはCLKSEL1だけでなくCER,SER,EXERでも選択する(消去時のクロックとしてBASECK使用)             //
// CPUのFetch時はSRAMクロックはBASECK　ファーム実行時のMRGINCHECKやREADではRDCLKP1を使用する      //
// デバッグ用にSCKSELでSCLKを端子に出せるようにしておく                                           //
//------------------------------------------------------------------------------------------------//
	//----- BASECK or CK30MHz Select Signal ------//
        wire selclk = (cer_dbg | ser_dbg) ? 1'b0 : 1'b1 ; // Use 30MHz in CER and SER.
   
	//本当はこのプリミティブを使いたいが、プリミティブの数が足りないため作ったクロックセレクタを使用
	//BUFGMUX bufgmux (.O(eromclk), .I0(ck60mhz), .I1(baseck), .S(mcksel));
	CLKSEL clksel (.clkout(eromclk), .auto_change(auto_change), .clkin0(ck30mhz), .clkin1(baseck),
                   .selclk(selclk), .cpuresetb(cpuresetb), .resetb(sysrsoutb));

//------------------------------------------------------------------------------------------------//
// ★EROMCSB EROMRDB EROMWRB の生成 -> Read/Write/CS SIGNAL                                       //
//------------------------------------------------------------------------------------------------//
// [ EROMCSB 信号 ]------Active Low                                                               //
// flash_cs : フラッシュアクセスのモード信号がアクティブになったときCSがアクティブとなる          //
// eromcs_b_pre : mcksel==1'b1の場合BASECK同期のアクセス信号がONでアクティブ                      //
//                mcksel==1'b0の場合HOSTアクセスの時のみアクティブ                                //
//------------------------------------------------------------------------------------------------//
// 以下は以前の仕様 -> 念のためコメントのみ残す                                                   //
// ---------------------------------------------------------------------------------------------- //
// 制御の優先順位                                                                                 //
// 1. rom_cs==1                             オルタネートからの書換え時アクティブ                  //
// 2. alt1==1                               ALT1命令によるFLASHリード時アクティブ                 //
// 3. iceeromcs==1                          ホストアクセス時アクティブ                            //
// 4. wwr==1                                WordWriteモード時アクティブ                           //
// 5. cer,ser,read_mode==1 svmodf==1        SVMOD中以外と消去、リード中でアクティブ               //
//------------------------------------------------------------------------------------------------//
	//----- Flash Access Mode -----//
	assign flash_cs = wwr_dbg | cer_dbg | ser_dbg | read_mode; // MA:F1xxx !!

	//----- CS Signal -----//
	/* ------------------------------------------------------------------------------------	*/
	/* as [SS3rd Ver1010]									*/
	/* Firm実行(FLSPM=1)中にBreakしてもSRAMのCSをInactiveにならないように変更.		*/
	/* ------------------------------------------------------------------------------------	*/
   wire        iceeromcs = 1'b0;
	assign eromcs_b_pre = mcksel ? ~rom_cs & alt1_flread_cs_b & ~flash_cs : ~iceeromcs;

	//----- 5ns Delay -----//
	EMEM_NODLY5NS_H cs_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(eromcs_b_pre), .out(eromcs_b) );

//------------------------------------------------------------------------------------------------//
// [ EROMRDB 信号 ]------Active Low                                                               //
// 制御の優先順位                                                                                 //
// 
//------------------------------------------------------------------------------------------------//
// 以下は以前の仕様 -> 念のためコメントのみ残す                                                   //
// ---------------------------------------------------------------------------------------------- //
// 1. rom_cs==1                             オルタネートからの書換え時アクティブ                  //
// 2. alt1==1                               ALT1命令によるFLASHリード時アクティブ                 //
// 3. iceeromcs & (svmodf | !cpuresetb)==1  SVMODかCPURESET中のホストアクセス時にアクティブ       //
// 4. wwr==1                                WordWriteモード時アクティブ                           //
// 5. cer,ser,svmodf==1                     消去とSVMOD中アクティブ                               //
//------------------------------------------------------------------------------------------------//
	//----- Self Read Enable -----//
	assign selfread_flag = read_mode & ~clksel1 & ce & ~rdclkp1;

	assign selfread_resetb = cpuresetb & read_mode;

	always @(posedge baseck or negedge selfread_resetb)begin
		if(~selfread_resetb) selfread_en <= 1'b0;
		else if(selfread_flag) selfread_en <= 1'b1;
	end

	//----- Self Read Mode Enable -----//
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) sl_selfcpurd <= 1'b0;
		else if(rdclkp1) sl_selfcpurd <= selfread_en;
	end

	//----- Read Status -----//
	assign sl_cpurd = ~read_mode | cer_dbg | ser_dbg | wwr_dbg | svmodf | (~cpurd /* DRDCLK ?!! */) ;

	assign cpu_rd = clksel1 ? sl_cpurd : ~sl_selfcpurd;

	//----- Read Enable Signal -----//
	assign eromrd_b_pre = mcksel ? rom_cs | ~flread_rd & cpu_rd : icerd_mask | ~iceeromcs;

	//----- 5ns Delay -----//
	EMEM_NODLY5NS_H rd_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(eromrd_b_pre), .out(eromrd_b) );

//------------------------------------------------------------------------------------------------//
// [ EROMWRB 信号 ]------Active Low                                                               //
// 
//------------------------------------------------------------------------------------------------//
// 以下は以前の仕様 -> 念のためコメントのみ残す                                                   //
// ---------------------------------------------------------------------------------------------- //
// 1. rom_cs==1                             オルタネートからの書換え時アクティブ                  //
// 2. svmodf|!cpuresetb==1                  SVMOD中かCPURESET中のみホストライトアクティブ         //
// 3. wwr==1                                WordWriteモード時アクティブ                           //
// 4. cer,ser==1                            消去時はFCLKの反転信号でアクティブ                    //
// 5. 1'b1                                  上記以外はインアクティブの信号                        //
//------------------------------------------------------------------------------------------------//
	//----- Erase Mode Enable -----//
        reg fclk30M1, fclk30M2 ;
   	always @(posedge ck30mhz or negedge sysrsoutb) begin // Make fclk 30MHz sync.
		if (~sysrsoutb) begin
		   fclk30M1 <= 1'b0;
		   fclk30M2 <= 1'b0;
		end else begin
		   fclk30M1 <= fclk ;
		   fclk30M2 <= fclk30M1 ;
		end
	end
	assign erase_en = (cer_dbg | ser_dbg) & fclk30M2 & ~wed;

	//----- Flash Write Mode Enable -----//
	assign progi_resetb = cpuresetb & wwr;

	always @(posedge baseck or negedge progi_resetb)begin
		if(~progi_resetb) progi_l <= 1'b0;
		else if (progi) progi_l <= 1'b1;
	end

	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) flwrite_en_pre <= 1'b0;
		else if(progi_l) flwrite_en_pre <= fclk;
	end

	assign flwrite_en = flwrite_en_pre & ~wed;

	//----- Write Enable Signal -----//
	assign eromwr_b_pre = mcksel ? ~(romwr_en | erase_en | flwrite_en) : ~ice_write;

	//----- 5ns Delay -----//
	EMEM_NODLY5NS_H wr_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(eromwr_b_pre), .out(eromwr_b) );

//------------------------------------------------------------------------------------------------//
// ★EROMPA の生成 Address Bus Select                                                             //
//------------------------------------------------------------------------------------------------//
// 
//------------------------------------------------------------------------------------------------//
// 以下は以前の仕様 -> 念のためコメントのみ残す                                                   //
// ---------------------------------------------------------------------------------------------- //
// ・オルタネートからIROM空間の書換えを行う場合はrom_cs信号で書換えアドレスをセットする           //
// ・SVMOD中のALT1命令時とCPURESET中以外でホストからIROM空間を選択した場合(iceromcs=1)に          //
//   ホストアドレスICEIFAをセットする                                                             //
// ・それ以外ではcpu_adrをセットする                                                              //
//------------------------------------------------------------------------------------------------//
	//----- CPU Access Address Select -----//
	assign cpu_adr_dec = rom_cs ? romwa_dec : cpu_adr;

	//----- SRAM Address Bus -----//
   wire        ice_adr_dec;
	assign erompa_pre = mcksel ? cpu_adr_dec : ice_adr_dec;

	//----- 5ns Delay -----//
	EMEM_NODLY5NS_L pa_00_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[0]), .out(erompa[0]) );
	EMEM_NODLY5NS_L pa_01_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[1]), .out(erompa[1]) );
	EMEM_NODLY5NS_L pa_02_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[2]), .out(erompa[2]) );
	EMEM_NODLY5NS_L pa_03_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[3]), .out(erompa[3]) );
	EMEM_NODLY5NS_L pa_04_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[4]), .out(erompa[4]) );
	EMEM_NODLY5NS_L pa_05_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[5]), .out(erompa[5]) );
	EMEM_NODLY5NS_L pa_06_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[6]), .out(erompa[6]) );
	EMEM_NODLY5NS_L pa_07_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[7]), .out(erompa[7]) );
	EMEM_NODLY5NS_L pa_08_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[8]), .out(erompa[8]) );
	EMEM_NODLY5NS_L pa_09_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[9]), .out(erompa[9]) );
	EMEM_NODLY5NS_L pa_10_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[10]), .out(erompa[10]) );
	EMEM_NODLY5NS_L pa_11_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[11]), .out(erompa[11]) );
	EMEM_NODLY5NS_L pa_12_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[12]), .out(erompa[12]) );
	EMEM_NODLY5NS_L pa_13_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[13]), .out(erompa[13]) );
	EMEM_NODLY5NS_L pa_14_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[14]), .out(erompa[14]) );
	EMEM_NODLY5NS_L pa_15_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[15]), .out(erompa[15]) );
	EMEM_NODLY5NS_L pa_16_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[16]), .out(erompa[16]) );
	EMEM_NODLY5NS_L pa_17_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[17]), .out(erompa[17]) );

//------------------------------------------------------------------------------------------------//
// ★EROMPD の生成 -> Data Bus Select                                                             //
//------------------------------------------------------------------------------------------------//
	//----- SRAM DATA BUS -----//
	assign eromwd = ((iceeromcs & ice_write) | sl_cpubus) ? erom_wd : 32'h0000_0000;

	//----- FCB DATA BUS -----//
	//assign ro_hold = (!svmodf | flread_rd ) ? eromrd : alt_cpu_do;
	assign ro_hold = eromrd; // alt_cpu_do は使わないため、切り換えの必要無し。(v1.10)

	//----- HOST READ DATA BUS Select -----//
	assign icedo = (iceeromcs & !icerd_mask) ? eromrd : (altromcs) ? alt_ice_do : 
					(hostreg_sel) ? {30'h0000_0000, icedo_reg} : 32'h0000_0000;

	//----- WRITE DATA Select -----//
	assign sl_cpubus = rom_cs | wwr_dbg | cer_dbg | ser_dbg;
	assign cpu_wr_data = wwr_dbg ? {24'h00_0000, dw[7:0]} : (cer_dbg | ser_dbg) ? 32'hFFFF_FFFF : {romwd1, romwd0};

   wire  [31:0]      icewritedata = 32'h0000_0000;
	assign erom_wd_pre = sl_cpubus ? cpu_wr_data : icewritedata;

	//----- 5ns Delay -----//
	EMEM_NODLY5NS_L pd_00_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[0]), .out(erom_wd[0]));
	EMEM_NODLY5NS_L pd_01_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[1]), .out(erom_wd[1]));
	EMEM_NODLY5NS_L pd_02_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[2]), .out(erom_wd[2]));
	EMEM_NODLY5NS_L pd_03_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[3]), .out(erom_wd[3]));
	EMEM_NODLY5NS_L pd_04_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[4]), .out(erom_wd[4]));
	EMEM_NODLY5NS_L pd_05_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[5]), .out(erom_wd[5]));
	EMEM_NODLY5NS_L pd_06_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[6]), .out(erom_wd[6]));
	EMEM_NODLY5NS_L pd_07_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[7]), .out(erom_wd[7]));
	EMEM_NODLY5NS_L pd_08_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[8]), .out(erom_wd[8]));
	EMEM_NODLY5NS_L pd_09_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[9]), .out(erom_wd[9]));
	EMEM_NODLY5NS_L pd_10_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[10]), .out(erom_wd[10]));
	EMEM_NODLY5NS_L pd_11_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[11]), .out(erom_wd[11]));
	EMEM_NODLY5NS_L pd_12_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[12]), .out(erom_wd[12]));
	EMEM_NODLY5NS_L pd_13_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[13]), .out(erom_wd[13]));
	EMEM_NODLY5NS_L pd_14_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[14]), .out(erom_wd[14]));
	EMEM_NODLY5NS_L pd_15_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[15]), .out(erom_wd[15]));
	EMEM_NODLY5NS_L pd_16_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[16]), .out(erom_wd[16]));
	EMEM_NODLY5NS_L pd_17_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[17]), .out(erom_wd[17]));
	EMEM_NODLY5NS_L pd_18_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[18]), .out(erom_wd[18]));
	EMEM_NODLY5NS_L pd_19_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[19]), .out(erom_wd[19]));
	EMEM_NODLY5NS_L pd_20_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[20]), .out(erom_wd[20]));
	EMEM_NODLY5NS_L pd_21_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[21]), .out(erom_wd[21]));
	EMEM_NODLY5NS_L pd_22_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[22]), .out(erom_wd[22]));
	EMEM_NODLY5NS_L pd_23_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[23]), .out(erom_wd[23]));
	EMEM_NODLY5NS_L pd_24_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[24]), .out(erom_wd[24]));
	EMEM_NODLY5NS_L pd_25_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[25]), .out(erom_wd[25]));
	EMEM_NODLY5NS_L pd_26_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[26]), .out(erom_wd[26]));
	EMEM_NODLY5NS_L pd_27_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[27]), .out(erom_wd[27]));
	EMEM_NODLY5NS_L pd_28_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[28]), .out(erom_wd[28]));
	EMEM_NODLY5NS_L pd_29_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[29]), .out(erom_wd[29]));
	EMEM_NODLY5NS_L pd_30_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[30]), .out(erom_wd[30]));
	EMEM_NODLY5NS_L pd_31_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[31]), .out(erom_wd[31]));

//------------------------------------------------------------------------------------------------//
// ★cpu_adrの生成 -> CPU Address Decode                                                          //
//------------------------------------------------------------------------------------------------//
	always @( a_dec or cpu_adr_latch or count_adr or ser_adr or cpu_adr_read or
	          dis_dbg or wwr_dbg or cer_dbg or ser_dbg or read_mode_dbg )begin
		casex({dis_dbg, wwr_dbg, cer_dbg, ser_dbg, read_mode_dbg})
			5'b1xxxx : cpu_adr = 18'h0;
			5'b01000 : cpu_adr = cpu_adr_latch;
			5'b00100 : cpu_adr = {1'b0, count_adr};
			5'b00010 : cpu_adr = ser_adr;
			5'b00001 : cpu_adr = cpu_adr_read;
			default : cpu_adr = a_dec;
		endcase
	end

//------------------------------------------------------------------------------------------------//
// ★a_decの生成 -> A19-2 Address Decode                                                          //
//------------------------------------------------------------------------------------------------//
// a19_2 = 18bit Address Bus                                                                      //
//------------------------------------------------------------------------------------------------//
// EXA == 1                 -> F_E000H - F_F7FF Extra Area 6Kbyte(2Kbyte*3)                       //
// ・EXTRA領域はEXA信号が立ったらアクセス                                                         //
//------------------------------------------------------------------------------------------------//
// CLKSEL1 == 1  -> F_0000H - F_1FFF BFA領域 8Kbyte(実アドレス E_E000H - E_FFFFH)      //
// ・CPU見えアドレスはE_E000H - E_FFFFHだが、後々のBFAサイズ変更などを考えて                      //
//   ICEとしてはSRAMのF_0000H - F_1FFFHに実体を置く                                               //
//   (8K越えのサイズになるとFLASHのアドレス用にCIBがデコードしたアドレスになるため)               //
// ・CIBからのアドレスはCPUのアドレス(E_E000H - E_FFFFH)が乗ってくるので下位13bitのみ有効         //
//------------------------------------------------------------------------------------------------//

	//----- a_dec Decode -----//
	//assign a_dec = (exa & ~svmodf) ? {7'b1111111, a19_2[10:0]} :
	//               (clksel1) ? {6'b111100, a19_2[11:0]} : a19_2;
	assign a_dec = a19_0[17:0];

//------------------------------------------------------------------------------------------------//
// ★cpu_adr_latch / cpu_adr_readの生成 -> DIS/WWR/READ/MRGxx Mode Address Latch                  //
//------------------------------------------------------------------------------------------------//
// 通常のフェッチ(clksel1==1)の時は特にアドレスをラッチしない。                                   //
// WWRとCERとSERはDISモードでアドレスをラッチする。ただし、WWRモードはDISモード期間だけでなく     //
// WWRモード期間でも CE=1 & RDCLKP1↑ で下位アドレスだけラッチする必要がある。                    //
//------------------------------------------------------------------------------------------------//

	//----- Address Latch Select -----//
	// ---------------------------------------------------------
	// [SS3rd Ver100]
	// sel_latch_readのTimingを変更。
	// ---------------------------------------------------------
	wire sel_read_mode = read_mode_dbg & ce & ~clksel1 & rdclkp1;
	reg sel_read_mode_l;
	always @(posedge baseck or negedge cpuresetb) begin
		if (!cpuresetb)	sel_read_mode_l <= 1'b0;
		else		sel_read_mode_l <= sel_read_mode;
	end
	assign sel_latch_read = sel_read_mode & ~sel_read_mode_l;

	//assign sel_latch_wwr = ce & wwr_dbg & ~rdclkp1;
	assign sel_latch_wwr = ce & wwr_dbg & progi ;

	assign sel_latch_dis = ce & dis_dbg & ~rdclkp1;

	//----- WWR Address Latch -----//
	always @( posedge baseck or negedge cpuresetb )begin
		if(~cpuresetb) cpu_adr_latch <= 18'h0;
		else if(sel_latch_dis) cpu_adr_latch <= a_dec;
		else if(sel_latch_wwr) cpu_adr_latch <= {adr_latch_dis[17:8], a_dec[7:0]};
	end
	always @( posedge baseck or negedge cpuresetb )begin
		if(~cpuresetb) adr_latch_dis <= 18'h0;
		else if(sel_latch_dis) adr_latch_dis <= a_dec;
	end

	//----- Read Mode Address Latch -----//
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) adr_latch_read <= 18'h0;
		else if(sel_latch_read) adr_latch_read <= a_dec;
	end

	//----- Read Mode Address Select -----//
	// ---------------------------------------------------------------------------------------
	// [Rev1.8]
        // From EVA_EMEMROM(SS3rd)
	// iverify_state信号を追加し、iverify時はアドレスとしてa_decを使用するよう変更。
	// iverify時は他のmrg**モードとmrg**とアドレス(a_dec)のタイミングが相対的に異り、1MHz動作時
	// にfcbでのデータ取り込みタイミングに間に合わない問題があった。同じmrg11,mrg12でもブランク
	// チェック時はタイミングが異りmrg10やmrg00と同じ動きをするので、iverify(mrg01->mrg11ormrg12)
	// に特化した修正とする。なお、iverify_stateはERR_CMPのmrg01_11_12_stateを参考にしている。
	// mrg01_11_12_stateの説明にあるひげはSS3rdのSequencerにはない(mrg01,11,12の変化点は1clock分
	// 重なる)のでmrg01のlatchはしていない。
	//
	// <1MHz動作時(修正後)>
	// eromclk        |~|_|~|_|~|_|~|_|~|_|~|_|~|_
	// rdclkp1        ~~~~|___|~~~|_______|~~~~~~~
	// a_dec          x===========================
	// erompd         ====x=====Need==============
	// fcb/vcmpb                      x==Need=====
	// ---------------------------------------------------------------------------------------
	wire iverify_resb = (mrg01_dbg | mrg11_dbg | mrg12_dbg) & cpuresetb;
	reg iverify_state;
	always @(posedge baseck or negedge iverify_resb)begin
		if(~iverify_resb) iverify_state <= 1'b0;
		else if(mrg01_dbg) iverify_state <= 1'b1;
	end
	assign cpu_adr_read = (clksel1 & (a19_0[19] & a19_0[18])) ? a_dec : (iverify_state) ? a_dec : adr_latch_read;

	//----- EXA and BEU Latch -----//
	always @( posedge baseck or negedge cpuresetb )begin
		if(!cpuresetb) exa_beu_latch <= 4'b000;
		else if(sel_latch_dis) exa_beu_latch <= {exa, beu};
	end

//------------------------------------------------------------------------------------------------//
// ★ser_adr の生成 -> SER Mode Address & BEU Signal Decode                                       //
//------------------------------------------------------------------------------------------------//
// USER FLASH AREA MAX 512Kbyte(ICE)   EXTRA AREA MAX 6Kbyte(Device & ICE)                        //
//------------------------------------------------------------------------------------------------//
// EXA BEU2-0                    EXA BEU2-0(Extra Area)                                           //
//  0  000 -> 1Kbyte              1  000 -> 1Kbyte                                                //
//  0  001 -> 2Kbyte              1  001 -> 2Kbyte                                                //
//  0  010 -> 4Kbyte              1  010 -> 4Kbyte                                                //
//  0  011 -> 8Kbyte              1  011 -> 8Kbyte   <----ICE Erase Only 6Kbyte                   //
//  0  100 -> 16Kbyte             1  100 -> 16Kbyte  <----ICE Erase Only 6Kbyte                   //
//  0  101 -> 32Kbyte             1  101 -> 32Kbyte  <----ICE Erase Only 6Kbyte                   //
//  0  110 -> 64Kbyte             1  110 -> 64Kbyte  <----ICE Erase Only 6Kbyte                   //
//  0  111 -> 128Kbyte            1  111 -> 128Kbyte <----ICE Erase Only 6Kbyte                   //
//------------------------------------------------------------------------------------------------//
	always @( exa_beu_latch or cpu_adr_latch or count_adr )begin
		case( exa_beu_latch )
			4'b0000 : ser_adr = {cpu_adr_latch[17:10], count_adr[9:0]};  //USER FLASH AREA 1Kbyte/1ERASE
			4'b0001 : ser_adr = {cpu_adr_latch[17:11], count_adr[10:0]}; //USER FLASH AREA 2Kbyte/1ERASE
			4'b0010 : ser_adr = {cpu_adr_latch[17:12], count_adr[11:0]};//USER FLASH AREA 4Kbyte/1ERASE
			4'b0011 : ser_adr = {cpu_adr_latch[17:13], count_adr[12:0]};//USER FLASH AREA 8Kbyte/1ERASE
			4'b0100 : ser_adr = {cpu_adr_latch[17:14], count_adr[13:0]};//USER FLASH AREA 16Kbyte/1ERASE
			4'b0101 : ser_adr = {cpu_adr_latch[17:15], count_adr[14:0]};//USER FLASH AREA 32Kbyte/1ERASE
			4'b0110 : ser_adr = {cpu_adr_latch[17:16], count_adr[15:0]};//USER FLASH AREA 64Kbyte/1ERASE
			4'b0111 : ser_adr = {cpu_adr_latch[17],    count_adr[16:0]};//USER FLASH AREA 128Kbyte/1ERASE
			4'b1000 : ser_adr = {cpu_adr_latch[17:8], count_adr[7:0]};  //EXTRA AREA 1Kbyte/1ERASE
			4'b1001 : ser_adr = {cpu_adr_latch[17:9], count_adr[8:0]}; //EXTRA AREA 2Kbyte/1ERASE
			4'b1010 : ser_adr = {cpu_adr_latch[17:10], count_adr[9:0]};//EXTRA AREA 4Kbyte/1ERASE
			4'b1011 : ser_adr = {cpu_adr_latch[17:11], count_adr[10:0]};//EXTRA AREA 8Kbyte/1ERASE(ICE Only 007FF->005FF(Max6Kbyte))
			4'b1100 : ser_adr = {cpu_adr_latch[17:11], count_adr[10:0]};//EXTRA AREA 8Kbyte/1ERASE(ICE Only 007FF->005FF(Max6Kbyte))
			4'b1101 : ser_adr = {cpu_adr_latch[17:11], count_adr[10:0]};//EXTRA AREA 8Kbyte/1ERASE(ICE Only 007FF->005FF(Max6Kbyte))
			4'b1110 : ser_adr = {cpu_adr_latch[17:11], count_adr[10:0]};//EXTRA AREA 8Kbyte/1ERASE(ICE Only 007FF->005FF(Max6Kbyte))
			4'b1111 : ser_adr = {cpu_adr_latch[17:11], count_adr[10:0]};//EXTRA AREA 8Kbyte/1ERASE(ICE Only 007FF->005FF(Max6Kbyte))
			default : ser_adr = 18'h0;
		endcase
	end

//セルフ割り込み対応修正 2006.11.6 taketoshi.ide@necel
//不要なため削除

//	always @( exa_beu_latch )begin
//		case( exa_beu_latch )
//			4'b0000 : cmp_reg = 17'h001FF;//USER FLASH AREA 2Kbyte/OneERASE
//			4'b0001 : cmp_reg = 17'h003FF;//USER FLASH AREA 4Kbyte/OneERASE
//			4'b0010 : cmp_reg = 17'h007FF;//USER FLASH AREA 8Kbyte/OneERASE
//			4'b0011 : cmp_reg = 17'h00FFF;//USER FLASH AREA 16Kbyte/OneERASE
//			4'b0100 : cmp_reg = 17'h01FFF;//USER FLASH AREA 32Kbyte/OneERASE
//			4'b0101 : cmp_reg = 17'h03FFF;//USER FLASH AREA 64Kbyte/OneERASE
//			4'b0110 : cmp_reg = 17'h07FFF;//USER FLASH AREA 128Kbyte/OneERASE
//			4'b0111 : cmp_reg = 17'h0FFFF;//USER FLASH AREA 256Kbyte/OneERASE
//			4'b1000 : cmp_reg = 17'h001FF;//EXTRA AREA 2Kbyte/OneERASE
//			4'b1001 : cmp_reg = 17'h003FF;//EXTRA AREA 4Kbyte/OneERASE
//			4'b1010 : cmp_reg = 17'h005FF;//EXTRA AREA 8Kbyte/OneERASE    ICE Only Changed 007FF->005FF(Extra=Max6Kbyte)
//			4'b1011 : cmp_reg = 17'h005FF;//NO EXTRA AREA 2Kbyte/OneERASE ICE Only Changed 00FFF->005FF(Extra=Max6Kbyte)
//			4'b1100 : cmp_reg = 17'h005FF;//NO EXTRA AREA 2Kbyte/OneERASE ICE Only Changed 01FFF->005FF(Extra=Max6Kbyte)
//			4'b1101 : cmp_reg = 17'h005FF;//NO EXTRA AREA 2Kbyte/OneERASE ICE Only Changed 03FFF->005FF(Extra=Max6Kbyte)
//			4'b1110 : cmp_reg = 17'h005FF;//NO EXTRA AREA 2Kbyte/OneERASE ICE Only Changed 07FFF->005FF(Extra=Max6Kbyte)
//			4'b1111 : cmp_reg = 17'h005FF;//NO EXTRA AREA 2Kbyte/OneERASE ICE Only Changed 0FFFF->005FF(Extra=Max6Kbyte)
//			default : cmp_reg = 17'h00000;
//		endcase
//	end

//------------------------------------------------------------------------------------------------//
// ★count_adr の生成 -> CER/SER Mode Address Counter                                             //
//------------------------------------------------------------------------------------------------//
// CER Mode -> Address 0_0000_H(0_0000_H) - 1FFFFH(7_FFFF_H) 512Kbyte                             //
// SER Mode -> Address 0_0000_H(F_0000_H) - 003FFH(F_0FFF_H) 4Kbyte                               //
//------------------------------------------------------------------------------------------------//

//セルフ割り込み対応修正 2006.11.6 taketoshi.ide@necel
//ResetはCPURESETBのみにするため削除
	//----- COUNTER RESET -----//
//	assign count_resetb = cpuresetb & fclk & !( dis | wwr | read_mode );

//OverFlowフラグは必要がなくなったため削除
	//----- COUNT OVERFLOW FLAG -----//
//	assign count_adr_max = count_adr[16] & count_adr[15] & count_adr[14] & count_adr[13] & count_adr[12] & 
//	                                       count_adr[11] & count_adr[10] & count_adr[9] & count_adr[8] & 
//	                                       count_adr[7] & count_adr[6] & count_adr[5] & count_adr[4] & 
//	                                       count_adr[3] & count_adr[2] & count_adr[1] & count_adr[0];
//
//	assign overflow = (cer & count_adr_max) ? 1'b1 : (ser & (count_adr == cmp_reg)) ? 1'b1 : 1'b0;

//OverFlowフラグの論理が不要なため削除
	//----- COUNTER SELECT -----//
//	assign sel_count = ( cer_dbg | ser_dbg ) & fclk ~overflow;
//	assign sel_count = ( cer_dbg | ser_dbg ) & fclk;

//CPURESETBのみに修正
	reg  [16:0] count_adr_pre2;
	always @(posedge ck30mhz or negedge cpuresetb)begin
		if(~cpuresetb) count_adr_pre2 <= 17'h0;
		else count_adr_pre2 <= count_adr_pre2 + 1'b1; // Delete enable control by sel_count.
	end
	wire  [16:0] count_adr_pre1;
	EMEM_DLY5NS_L count_adr00_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[0]), .out(count_adr_pre1[0]));
	EMEM_DLY5NS_L count_adr01_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[1]), .out(count_adr_pre1[1]));
	EMEM_DLY5NS_L count_adr02_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[2]), .out(count_adr_pre1[2]));
	EMEM_DLY5NS_L count_adr03_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[3]), .out(count_adr_pre1[3]));
	EMEM_DLY5NS_L count_adr04_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[4]), .out(count_adr_pre1[4]));
	EMEM_DLY5NS_L count_adr05_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[5]), .out(count_adr_pre1[5]));
	EMEM_DLY5NS_L count_adr06_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[6]), .out(count_adr_pre1[6]));
	EMEM_DLY5NS_L count_adr07_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[7]), .out(count_adr_pre1[7]));
	EMEM_DLY5NS_L count_adr08_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[8]), .out(count_adr_pre1[8]));
	EMEM_DLY5NS_L count_adr09_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[9]), .out(count_adr_pre1[9]));
   	EMEM_DLY5NS_L count_adr10_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[10]), .out(count_adr_pre1[10]));
   	EMEM_DLY5NS_L count_adr11_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[11]), .out(count_adr_pre1[11]));
   	EMEM_DLY5NS_L count_adr12_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[12]), .out(count_adr_pre1[12]));
   	EMEM_DLY5NS_L count_adr13_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[13]), .out(count_adr_pre1[13]));
   	EMEM_DLY5NS_L count_adr14_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[14]), .out(count_adr_pre1[14]));
   	EMEM_DLY5NS_L count_adr15_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[15]), .out(count_adr_pre1[15]));
   	EMEM_DLY5NS_L count_adr16_dly1 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre2[16]), .out(count_adr_pre1[16]));
   	EMEM_DLY5NS_L count_adr00_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[0]), .out(count_adr[0]));
   	EMEM_DLY5NS_L count_adr01_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[1]), .out(count_adr[1]));
   	EMEM_DLY5NS_L count_adr02_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[2]), .out(count_adr[2]));
   	EMEM_DLY5NS_L count_adr03_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[3]), .out(count_adr[3]));
   	EMEM_DLY5NS_L count_adr04_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[4]), .out(count_adr[4]));
   	EMEM_DLY5NS_L count_adr05_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[5]), .out(count_adr[5]));
   	EMEM_DLY5NS_L count_adr06_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[6]), .out(count_adr[6]));
   	EMEM_DLY5NS_L count_adr07_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[7]), .out(count_adr[7]));
   	EMEM_DLY5NS_L count_adr08_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[8]), .out(count_adr[8]));
   	EMEM_DLY5NS_L count_adr09_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[9]), .out(count_adr[9]));
   	EMEM_DLY5NS_L count_adr10_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[10]), .out(count_adr[10]));
   	EMEM_DLY5NS_L count_adr11_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[11]), .out(count_adr[11]));
   	EMEM_DLY5NS_L count_adr12_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[12]), .out(count_adr[12]));
   	EMEM_DLY5NS_L count_adr13_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[13]), .out(count_adr[13]));
   	EMEM_DLY5NS_L count_adr14_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[14]), .out(count_adr[14]));
   	EMEM_DLY5NS_L count_adr15_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[15]), .out(count_adr[15]));
   	EMEM_DLY5NS_L count_adr16_dly2 (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(count_adr_pre1[16]), .out(count_adr[16]));

//------------------------------------------------------------------------------------------------//
// RO HOLD (SLFLASH -> LOW >>>>> LATCH DATA OUTPUT)                                               //
//------------------------------------------------------------------------------------------------//
// SLFLASH信号が落ちてもデバイスはメモリ出力を保持するが、ICEはFLASHの代わりに                    //
// SRAMを使用しているため出力を保持できない。                                                     //
// そこでBASECKで毎クロック出力データをラッチしておいてSLFLASHが落ちたら                          //
// ラッチしたデータをバスに乗せてFLASHと同じようにデータが見えるようにする。                      //
//------------------------------------------------------------------------------------------------//
	always @(posedge baseck or negedge cpuresetb) begin
		if (~cpuresetb) ce_l <= 1'b0;
		else ce_l <= ce;
	end

	always @(posedge baseck or negedge cpuresetb) begin
		if (~cpuresetb) ro_l <= 1'b0;
		else if(ce_l) ro_l <= ro_hold;
	end

	always @(ro_l or ro_hold or ce_l)begin
		case(ce_l)
			1'b0 : ro = {6'b0, ro_l};
			1'b1 : ro = {6'b0, ro_hold};
		endcase
	end

	assign dro = ro;

//------------------------------------------------------------------------------------------------//
// ALT1 FLREAD timing signal                                                                      //
//------------------------------------------------------------------------------------------------//
// ALT1命令実行時はFETCH空間がALTROMのためALT1信号の立上がりでアドレスをSRAM側に乗せ              //
// 次のクロックでデータバスをSRAMに切替える必要がある                                             //
// ---------------------------------------------------------------------------------------------- //
// SVMODF     _______|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___  //
//                                                                                                //
// ALT1       ____________________|~~~~~|_________________                                        //
//                                                                                                //
// FLREAD     ____________________|~~~~~|_________________                                        //
//                                                                                                //
// flread_rd  __________________________|~~~~~|___________                                        //
//                                                                                                //
// BASECK     __|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__|~~|__                                        //
//                                                                                                //
// PA         =========x=A0==x=A1==x=RDA=x=A2==xxxxxxxxxxx                                        //
//                                                                                                //
// PID        ===============x=D0==x=D1==x=RDD=x=D2==xxxxx                                        //
//                                                                                                //
//------------------------------------------------------------------------------------------------//
	always @(posedge baseck or negedge cpuresetb)begin
		if(!cpuresetb) flread_rd <= 1'b0;
		else if(alt1) flread_rd <= flread;
		else flread_rd <= 1'b0;
	end

	assign alt1_flread_cs_b = !flread_rd & !(alt1 & prefix) ;

////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                //
//                              ★ Firm Debug Function ★                                         //
//                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////
//------------------------------------------------------------------------------------------------//
// 2ndSFR(USED ICE) Access Control                                                                //
//------------------------------------------------------------------------------------------------//
// ICEADR(WORD SFR) F_00D0H -> Address Set Registor                                               //
// ICEDAT(WORD SFR) F_00D2H -> Data Set Registor                                                  //
//------------------------------------------------------------------------------------------------//

	//----- ICE 2ndSFR Registor Select -----//
	assign exma_flag = exma[3] & exma[2] & exma[1] & exma[0];
	assign sl_icesfr = exma_flag & (ma[15:4] == 12'h00D) & ~flread & wdop;
	assign sl_icesfr_read = cpurd & sl_icesfr;
	assign sl_icesfr_write = cpuwr & sl_icesfr;

	always @(posedge baseck or negedge sysrsoutb) begin
		if(~sysrsoutb) iceadr <= 16'h0;
		else if(sl_icesfr_write & (ma[3:0] == 4'h0)) iceadr <= mdw;
	end

	always @(posedge baseck or negedge sysrsoutb) begin
		if(~sysrsoutb) icedat <= 16'h0;
		else if(sl_icesfr_write & (ma[3:0] == 4'h2)) icedat <= mdw;
	end

	always @(posedge baseck or negedge sysrsoutb)begin
		if(~sysrsoutb) icesfr_wr <= 1'b0;
		else if(sl_icesfr_write & (ma[3:0] == 4'h2)) icesfr_wr <= 1'b1;
		else icesfr_wr <= 1'b0;
	end

	assign icesfr_rd = sl_icesfr_read & (ma[3:0] == 4'h2);

	always @(icesfr_rd or iceadr or
			erradrl1 or erradrh1 or errmskl1 or errmskh1 or err_mode1 or err_count1 or
			erradrl2 or erradrh2 or errmskl2 or errmskh2 or err_mode2 or err_count2 or
			erradrl3 or erradrh3 or errmskl3 or errmskh3 or err_mode3 or err_count3 or
			erradrl4 or erradrh4 or errmskl4 or errmskh4 or err_mode4 or err_count4 or
			erradrl5 or erradrh5 or errmskl5 or errmskh5 or err_mode5 or err_count5 )begin
		casex({icesfr_rd, iceadr})
			17'h0xxxx : icedat_read = 16'h0000;
			17'h100xx : icedat_read = 16'h0000;
			17'h10100 : icedat_read = erradrl1;
			17'h10101 : icedat_read = {12'h000, erradrh1};
			17'h10102 : icedat_read = erradrl2;
			17'h10103 : icedat_read = {12'h000, erradrh2};
			17'h10104 : icedat_read = erradrl3;
			17'h10105 : icedat_read = {12'h000, erradrh3};
			17'h10106 : icedat_read = erradrl4;
			17'h10107 : icedat_read = {12'h000, erradrh4};
			17'h10108 : icedat_read = erradrl5;
			17'h10109 : icedat_read = {12'h000, erradrh5};
			17'h10110 : icedat_read = {10'h0, err_mode1};
			17'h10111 : icedat_read = {10'h0, err_mode2};
			17'h10112 : icedat_read = {10'h0, err_mode3};
			17'h10113 : icedat_read = {10'h0, err_mode4};
			17'h10114 : icedat_read = {10'h0, err_mode5};
			17'h10120 : icedat_read = errmskl1;
			17'h10121 : icedat_read = {12'h000, errmskh1};
			17'h10122 : icedat_read = errmskl2;
			17'h10123 : icedat_read = {12'h000, errmskh2};
			17'h10124 : icedat_read = errmskl3;
			17'h10125 : icedat_read = {12'h000, errmskh3};
			17'h10126 : icedat_read = errmskl4;
			17'h10127 : icedat_read = {12'h000, errmskh4};
			17'h10128 : icedat_read = errmskl5;
			17'h10129 : icedat_read = {12'h000, errmskh5};
			17'h10130 : icedat_read = err_count1;
			17'h10131 : icedat_read = err_count2;
			17'h10132 : icedat_read = err_count3;
			17'h10133 : icedat_read = err_count4;
			17'h10134 : icedat_read = err_count5;
			default : icedat_read = 16'h0000;
		endcase
	end

	//----- CPU Registor Read Output -----//
	always @(sl_icesfr_read or ma[3:0] or iceadr or icedat_read) begin
			casex ({sl_icesfr_read, ma[3:0]})
				{1'b0, 4'hx} : memmdr = 16'h0000;
				{1'b1, 4'h0} : memmdr = iceadr;
				{1'b1, 4'h2} : memmdr = icedat_read;
				default	     : memmdr = 16'h0000;
			endcase
	end

//------------------------------------------------------------------------------------------------//
// Farm Debug Internal Register                                                                   //
//------------------------------------------------------------------------------------------------//
//  ADR    REG_Name                                                                               //
// 0000H   ERRADRL   Err Address 16bit(15-0)                                                      //
// 0001H   ERRADRH   Err Address 4bit(3-0)                                                        //
// 0010H   ICEFLERR  bit0 = ICEFLERR OUTPUT                                                       //
//                                                                                                //
// ICEDAT(WORD SFR) F_00D2H -> Data Set Register                                                  //
//------------------------------------------------------------------------------------------------//

	//----- Internal Register Select Flag Decode -----

	wire sl_erradrl1, sl_erradrl2, sl_erradrl3, sl_erradrl4, sl_erradrl5 ;
	wire sl_erradrh1, sl_erradrh2, sl_erradrh3, sl_erradrh4, sl_erradrh5 ;
	wire sl_err_mode1, sl_err_mode2, sl_err_mode3, sl_err_mode4, sl_err_mode5 ;
	wire sl_errmskl1, sl_errmskl2, sl_errmskl3, sl_errmskl4, sl_errmskl5 ;
	wire sl_errmskh1, sl_errmskh2, sl_errmskh3, sl_errmskh4, sl_errmskh5 ;
	wire sl_err_count1, sl_err_count2, sl_err_count3, sl_err_count4, sl_err_count5 ;
	reg  [30:1] sl_errreg_set;
	
	always @( iceadr )begin
		case( iceadr )
			16'h0100 : sl_errreg_set = 30'b000000000000000000000000000001;
			16'h0101 : sl_errreg_set = 30'b000000000000000000000000000010;
			16'h0102 : sl_errreg_set = 30'b000000000000000000000000000100;
			16'h0103 : sl_errreg_set = 30'b000000000000000000000000001000;
			16'h0104 : sl_errreg_set = 30'b000000000000000000000000010000;
			16'h0105 : sl_errreg_set = 30'b000000000000000000000000100000;
			16'h0106 : sl_errreg_set = 30'b000000000000000000000001000000;
			16'h0107 : sl_errreg_set = 30'b000000000000000000000010000000;
			16'h0108 : sl_errreg_set = 30'b000000000000000000000100000000;
			16'h0109 : sl_errreg_set = 30'b000000000000000000001000000000;
			16'h0110 : sl_errreg_set = 30'b000000000000000000010000000000;
			16'h0111 : sl_errreg_set = 30'b000000000000000000100000000000;
			16'h0112 : sl_errreg_set = 30'b000000000000000001000000000000;
			16'h0113 : sl_errreg_set = 30'b000000000000000010000000000000;
			16'h0114 : sl_errreg_set = 30'b000000000000000100000000000000;
			16'h0120 : sl_errreg_set = 30'b000000000000001000000000000000;
			16'h0121 : sl_errreg_set = 30'b000000000000010000000000000000;
			16'h0122 : sl_errreg_set = 30'b000000000000100000000000000000;
			16'h0123 : sl_errreg_set = 30'b000000000001000000000000000000;
			16'h0124 : sl_errreg_set = 30'b000000000010000000000000000000;
			16'h0125 : sl_errreg_set = 30'b000000000100000000000000000000;
			16'h0126 : sl_errreg_set = 30'b000000001000000000000000000000;
			16'h0127 : sl_errreg_set = 30'b000000010000000000000000000000;
			16'h0128 : sl_errreg_set = 30'b000000100000000000000000000000;
			16'h0129 : sl_errreg_set = 30'b000001000000000000000000000000;
			16'h0130 : sl_errreg_set = 30'b000010000000000000000000000000;
			16'h0131 : sl_errreg_set = 30'b000100000000000000000000000000;
			16'h0132 : sl_errreg_set = 30'b001000000000000000000000000000;
			16'h0133 : sl_errreg_set = 30'b010000000000000000000000000000;
			16'h0134 : sl_errreg_set = 30'b100000000000000000000000000000;
			default  : sl_errreg_set = 30'b000000000000000000000000000000;
		endcase
	end
	assign {
		sl_err_count5, sl_err_count4, sl_err_count3, sl_err_count2, sl_err_count1,
		sl_errmskh5, sl_errmskl5, sl_errmskh4, sl_errmskl4, sl_errmskh3, sl_errmskl3, sl_errmskh2, sl_errmskl2, sl_errmskh1, sl_errmskl1,
		sl_err_mode5, sl_err_mode4, sl_err_mode3, sl_err_mode2, sl_err_mode1,
		sl_erradrh5, sl_erradrl5, sl_erradrh4, sl_erradrl4, sl_erradrh3, sl_erradrl3, sl_erradrh2, sl_erradrl2, sl_erradrh1, sl_erradrl1
	} = sl_errreg_set;

	//----- Data Set to Internal Register -----
	
	// #1
	
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrl1 <= 16'h0000;
			else if(icesfr_wr & sl_erradrl1) erradrl1 <= icedat;
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrh1 <= 4'h0;
			else if(icesfr_wr & sl_erradrh1) erradrh1 <= icedat[3:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_mode1 <= 6'h00;
			else if(icesfr_wr & sl_err_mode1) err_mode1 <= icedat[5:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) errmskl1 <= 16'h0000;
			else if(icesfr_wr & sl_errmskl1) errmskl1 <= icedat;
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) errmskh1 <= 4'h0;
			else if(icesfr_wr & sl_errmskh1) errmskh1 <= icedat[3:0];
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_count1 <= 8'h00;
			else if(icesfr_wr & sl_err_count1) err_count1 <= icedat[7:0];
		end
	
	// #2
	
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrl2 <= 16'h0000;
			else if(icesfr_wr & sl_erradrl2) erradrl2 <= icedat;
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrh2 <= 4'h0;
			else if(icesfr_wr & sl_erradrh2) erradrh2 <= icedat[3:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_mode2 <= 6'h00;
			else if(icesfr_wr & sl_err_mode2) err_mode2 <= icedat[5:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) errmskl2 <= 16'h0000;
			else if(icesfr_wr & sl_errmskl2) errmskl2 <= icedat;
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) errmskh2 <= 4'h0;
			else if(icesfr_wr & sl_errmskh2) errmskh2 <= icedat[3:0];
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_count2 <= 8'h00;
			else if(icesfr_wr & sl_err_count2) err_count2 <= icedat[7:0];
		end
	
	// #3
	
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrl3 <= 16'h0000;
			else if(icesfr_wr & sl_erradrl3) erradrl3 <= icedat;
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrh3 <= 4'h0;
			else if(icesfr_wr & sl_erradrh3) erradrh3 <= icedat[3:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_mode3 <= 6'h00;
			else if(icesfr_wr & sl_err_mode3) err_mode3 <= icedat[5:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) errmskl3 <= 16'h0000;
			else if(icesfr_wr & sl_errmskl3) errmskl3 <= icedat;
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) errmskh3 <= 4'h0;
			else if(icesfr_wr & sl_errmskh3) errmskh3 <= icedat[3:0];
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_count3 <= 8'h00;
			else if(icesfr_wr & sl_err_count3) err_count3 <= icedat[7:0];
		end
	
	// #4
	
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrl4 <= 16'h0000;
			else if(icesfr_wr & sl_erradrl4) erradrl4 <= icedat;
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrh4 <= 4'h0;
			else if(icesfr_wr & sl_erradrh4) erradrh4 <= icedat[3:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_mode4 <= 6'h00;
			else if(icesfr_wr & sl_err_mode4) err_mode4 <= icedat[5:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) errmskl4 <= 16'h0000;
			else if(icesfr_wr & sl_errmskl4) errmskl4 <= icedat;
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) errmskh4 <= 4'h0;
			else if(icesfr_wr & sl_errmskh4) errmskh4 <= icedat[3:0];
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_count4 <= 8'h00;
			else if(icesfr_wr & sl_err_count4) err_count4 <= icedat[7:0];
		end
	
	// #5
	
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrl5 <= 16'h0000;
			else if(icesfr_wr & sl_erradrl5) erradrl5 <= icedat;
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrh5 <= 4'h0;
			else if(icesfr_wr & sl_erradrh5) erradrh5 <= icedat[3:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_mode5 <= 6'h00;
			else if(icesfr_wr & sl_err_mode5) err_mode5 <= icedat[5:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) errmskl5 <= 16'h0000;
			else if(icesfr_wr & sl_errmskl5) errmskl5 <= icedat;
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) errmskh5 <= 4'h0;
			else if(icesfr_wr & sl_errmskh5) errmskh5 <= icedat[3:0];
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_count5 <= 8'h00;
			else if(icesfr_wr & sl_err_count5) err_count5 <= icedat[7:0];
		end

//

	wire iceflerr_out1;
	ERR_CMP err_cmp1 (
		.erradrl(erradrl1), .erradrh(erradrh1),
		.errmskl(errmskl1), .errmskh(errmskh1),
		.err_mode({1'b0, err_mode1}), .err_count(err_count1),
		.mrg00_dbg(mrg00_dbg), .mrg01_dbg(mrg01_dbg), .mrg10_dbg(mrg10_dbg),
		.mrg11_dbg(mrg11_dbg), .mrg12_dbg(mrg12_dbg), .read_dbg(read_dbg),
		.slbmem(slbmem), .exch(exch), .swap(1'b0), .clksel1(clksel1), .rdclkp1(rdclkp1),
		.cpu_adr({a19_0[19:18], cpu_adr}),
		.baseck(baseck), .cpuresetb(cpuresetb), .iceflerr_out(iceflerr_out1)
	);
	wire iceflerr_out2;
	ERR_CMP err_cmp2 (
		.erradrl(erradrl2), .erradrh(erradrh2),
		.errmskl(errmskl2), .errmskh(errmskh2),
		.err_mode({1'b0, err_mode2}), .err_count(err_count2),
		.mrg00_dbg(mrg00_dbg), .mrg01_dbg(mrg01_dbg), .mrg10_dbg(mrg10_dbg),
		.mrg11_dbg(mrg11_dbg), .mrg12_dbg(mrg12_dbg), .read_dbg(read_dbg),
		.slbmem(slbmem), .exch(exch), .swap(1'b0), .clksel1(clksel1), .rdclkp1(rdclkp1),
		.cpu_adr({a19_0[19:18], cpu_adr}),
		.baseck(baseck), .cpuresetb(cpuresetb), .iceflerr_out(iceflerr_out2)
	);
	wire iceflerr_out3;
	ERR_CMP err_cmp3 (
		.erradrl(erradrl3), .erradrh(erradrh3),
		.errmskl(errmskl3), .errmskh(errmskh3),
		.err_mode({1'b0, err_mode3}), .err_count(err_count3),
		.mrg00_dbg(mrg00_dbg), .mrg01_dbg(mrg01_dbg), .mrg10_dbg(mrg10_dbg),
		.mrg11_dbg(mrg11_dbg), .mrg12_dbg(mrg12_dbg), .read_dbg(read_dbg),
		.slbmem(slbmem), .exch(exch), .swap(1'b0), .clksel1(clksel1), .rdclkp1(rdclkp1),
		.cpu_adr({a19_0[19:18], cpu_adr}),
		.baseck(baseck), .cpuresetb(cpuresetb), .iceflerr_out(iceflerr_out3)
	);
	wire iceflerr_out4;
	ERR_CMP err_cmp4 (
		.erradrl(erradrl4), .erradrh(erradrh4),
		.errmskl(errmskl4), .errmskh(errmskh4),
		.err_mode({1'b0, err_mode4}), .err_count(err_count4),
		.mrg00_dbg(mrg00_dbg), .mrg01_dbg(mrg01_dbg), .mrg10_dbg(mrg10_dbg),
		.mrg11_dbg(mrg11_dbg), .mrg12_dbg(mrg12_dbg), .read_dbg(read_dbg),
		.slbmem(slbmem), .exch(exch), .swap(1'b0), .clksel1(clksel1), .rdclkp1(rdclkp1),
		.cpu_adr({a19_0[19:18], cpu_adr}),
		.baseck(baseck), .cpuresetb(cpuresetb), .iceflerr_out(iceflerr_out4)
	);
	wire iceflerr_out5;
	ERR_CMP err_cmp5 (
		.erradrl(erradrl5), .erradrh(erradrh5),
		.errmskl(errmskl5), .errmskh(errmskh5),
		.err_mode({1'b0, err_mode5}), .err_count(err_count5),
		.mrg00_dbg(mrg00_dbg), .mrg01_dbg(mrg01_dbg), .mrg10_dbg(mrg10_dbg),
		.mrg11_dbg(mrg11_dbg), .mrg12_dbg(mrg12_dbg), .read_dbg(read_dbg),
		.slbmem(slbmem), .exch(exch), .swap(1'b0), .clksel1(clksel1), .rdclkp1(rdclkp1),
		.cpu_adr({a19_0[19:18], cpu_adr}),
		.baseck(baseck), .cpuresetb(cpuresetb), .iceflerr_out(iceflerr_out5)
	);
	assign iceflerr_out = iceflerr_out1 | iceflerr_out2 | iceflerr_out3 | iceflerr_out4 | iceflerr_out5 ;

endmodule

//------------------------------------------------------------------------------------------------//
// DELAY Circuit                                                                                  //
//------------------------------------------------------------------------------------------------//
//----- SYSTEMRESET Level Low module -----//
module EMEM_NODLY5NS_L (dmy1, dmy2, sysrsoutb, in, out); // DLY -> NODLY
	input	dmy1, dmy2, sysrsoutb, in;
	output	out;

   assign 		out = in ;

//	reg	[3:0]	dly;
//	reg		out;
//   
//	always @(sysrsoutb or dmy1 or in ) begin
//		if (~sysrsoutb) dly[0] = 1'b0;
//		else if (dmy1) dly[0] = in;
//	end
//	always @(sysrsoutb or dmy2 or dly[0]) begin
//		if (~sysrsoutb) dly[1] = 1'b0;
//		else if (dmy2) dly[1] = dly[0];
//	end
//	always @(sysrsoutb or dmy1 or dly[1]) begin
//		if (~sysrsoutb) dly[2] = 1'b0;
//		else if (dmy1) dly[2] = dly[1];
//	end
//	always @(sysrsoutb or dmy2 or dly[2]) begin
//		if (~sysrsoutb) dly[3] = 1'b0;
//		else if (dmy2) dly[3] = dly[2];
//	end
//	always @(sysrsoutb or dmy1 or dly[3]) begin
//		if (~sysrsoutb) out = 1'b0;
//		else if (dmy1) out = dly[3];
//	end

endmodule

//----- SYSTEMRESET Level Hi module -----// // DLY -> NODLY
module EMEM_NODLY5NS_H (dmy1, dmy2, sysrsoutb, in, out);
	input	dmy1, dmy2, sysrsoutb, in;
	output	out;

   assign 		out = in ;

//	reg	[3:0]	dly;
//	reg		out;
//
//	always @(sysrsoutb or dmy1 or in ) begin
//		if (~sysrsoutb) dly[0] = 1'b1;
//		else if (dmy1) dly[0] = in;
//	end
//	always @(sysrsoutb or dmy2 or dly) begin
//		if (~sysrsoutb) dly[1] = 1'b1;
//		else if (dmy2) dly[1] = dly[0];
//	end
//	always @(sysrsoutb or dmy1 or dly) begin
//		if (~sysrsoutb) dly[2] = 1'b1;
//		else if (dmy1) dly[2] = dly[1];
//	end
//	always @(sysrsoutb or dmy2 or dly) begin
//		if (~sysrsoutb) dly[3] = 1'b1;
//		else if (dmy2) dly[3] = dly[2];
//	end
//	always @(sysrsoutb or dmy1 or dly) begin
//		if (~sysrsoutb) out = 1'b1;
//		else if (dmy1) out = dly[3];
//	end

endmodule

module DFLASHRAM (
	CLK60MHZ, BASECK,
	eromrd_b, eromwr_b, eromcs_b, eromclk, erompa, eromrd, eromwd,
	DCLKSEL1, da, dro,
	iceifa, icedi, icedo, icewr,
		  );
   
        input CLK60MHZ, BASECK;
   
	input eromrd_b, eromwr_b, eromcs_b, eromclk;
	input [17:0] erompa;
	output  [31:0] eromrd;
	input  [31:0] eromwd;

        input DCLKSEL1;
        input [13:0] da;
        output [11:0] dro;
   
	input  [31:0] iceifa;
	input  [31:0] icedi;
	output [31:0] icedo;
	input  icewr;

   wire [7:0] rd7, rd6, rd5, rd4, rd3, rd2, rd1, rd0 ;
   wire [7:0] icedo7, icedo6, icedo5, icedo4, icedo3, icedo2, icedo1, icedo0 ;
   
   wire [13:0] cpuad = (DCLKSEL1) ? da     : erompa[13:0] ;
   wire        clka  = (DCLKSEL1) ? BASECK : eromclk      ;
   wire [7:0]  dia   = (DCLKSEL1) ? 8'h00  : eromwd[7:0]  ;
   wire        wea   = (DCLKSEL1) ? 1'b0   : ~eromwr_b    ;
   
   wire ena0         = (DCLKSEL1) ? (cpuad[13:11] == 3'b000) : ~eromcs_b & (cpuad[13:11] == 3'b010) ;
   wire ena1         = (DCLKSEL1) ? (cpuad[13:11] == 3'b001) : ~eromcs_b & (cpuad[13:11] == 3'b011) ;
   wire ena2         = (DCLKSEL1) ? (cpuad[13:11] == 3'b010) : ~eromcs_b & (cpuad[13:11] == 3'b100) ;
   wire ena3         = (DCLKSEL1) ? (cpuad[13:11] == 3'b011) : ~eromcs_b & (cpuad[13:11] == 3'b101) ;
   wire ena4         = (DCLKSEL1) ? (cpuad[13:11] == 3'b100) : ~eromcs_b & (cpuad[13:11] == 3'b110) ;
   wire ena5         = (DCLKSEL1) ? (cpuad[13:11] == 3'b101) : ~eromcs_b & (cpuad[13:11] == 3'b111) ;
   wire ena6         = (DCLKSEL1) ? (cpuad[13:11] == 3'b110) : ~eromcs_b & (cpuad[13:11] == 3'b000) ;
   wire ena7         = (DCLKSEL1) ? (cpuad[13:11] == 3'b111) : ~eromcs_b & (cpuad[13:11] == 3'b001) ;

   wire seldflash = (iceifa[31:16] == 16'h0114) ;
   
   wire enb0 = seldflash & (iceifa[15:13] == 3'b000);
   wire enb1 = seldflash & (iceifa[15:13] == 3'b001);
   wire enb2 = seldflash & (iceifa[15:13] == 3'b010);
   wire enb3 = seldflash & (iceifa[15:13] == 3'b011);
   wire enb4 = seldflash & (iceifa[15:13] == 3'b100);
   wire enb5 = seldflash & (iceifa[15:13] == 3'b101);
   wire enb6 = seldflash & (iceifa[15:13] == 3'b110);
   wire enb7 = seldflash & (iceifa[15:13] == 3'b111);
   
        RAMB16_S9_S9 ram0 (
			.DOA(rd0), .DOPA(),
			.ADDRA(cpuad[10:0]), .CLKA(clka), .DIA(dia), .DIPA(1'b0),
			.ENA(ena0), .SSRA(1'b0), .WEA(wea),
			.DOB(icedo0), .DOPB(),
			.ADDRB(iceifa[12:2]), .CLKB(CLK60MHZ), .DIB(icedi[7:0]), .DIPB(1'b0),
			.ENB(enb0), .SSRB(1'b0), .WEB(icewr)
	);
        RAMB16_S9_S9 ram1 (
			.DOA(rd1), .DOPA(),
			.ADDRA(cpuad[10:0]), .CLKA(clka), .DIA(dia), .DIPA(1'b0),
			.ENA(ena1), .SSRA(1'b0), .WEA(wea),
			.DOB(icedo1), .DOPB(),
			.ADDRB(iceifa[12:2]), .CLKB(CLK60MHZ), .DIB(icedi[7:0]), .DIPB(1'b0),
			.ENB(enb1), .SSRB(1'b0), .WEB(icewr)
	);
        RAMB16_S9_S9 ram2 (
			.DOA(rd2), .DOPA(),
			.ADDRA(cpuad[10:0]), .CLKA(clka), .DIA(dia), .DIPA(1'b0),
			.ENA(ena2), .SSRA(1'b0), .WEA(wea),
			.DOB(icedo2), .DOPB(),
			.ADDRB(iceifa[12:2]), .CLKB(CLK60MHZ), .DIB(icedi[7:0]), .DIPB(1'b0),
			.ENB(enb2), .SSRB(1'b0), .WEB(icewr)
	);
        RAMB16_S9_S9 ram3 (
			.DOA(rd3), .DOPA(),
			.ADDRA(cpuad[10:0]), .CLKA(clka), .DIA(dia), .DIPA(1'b0),
			.ENA(ena3), .SSRA(1'b0), .WEA(wea),
			.DOB(icedo3), .DOPB(),
			.ADDRB(iceifa[12:2]), .CLKB(CLK60MHZ), .DIB(icedi[7:0]), .DIPB(1'b0),
			.ENB(enb3), .SSRB(1'b0), .WEB(icewr)
	);
        RAMB16_S9_S9 ram4 (
			.DOA(rd4), .DOPA(),
			.ADDRA(cpuad[10:0]), .CLKA(clka), .DIA(dia), .DIPA(1'b0),
			.ENA(ena4), .SSRA(1'b0), .WEA(wea),
			.DOB(icedo4), .DOPB(),
			.ADDRB(iceifa[12:2]), .CLKB(CLK60MHZ), .DIB(icedi[7:0]), .DIPB(1'b0),
			.ENB(enb4), .SSRB(1'b0), .WEB(icewr)
	);
        RAMB16_S9_S9 ram5 (
			.DOA(rd5), .DOPA(),
			.ADDRA(cpuad[10:0]), .CLKA(clka), .DIA(dia), .DIPA(1'b0),
			.ENA(ena5), .SSRA(1'b0), .WEA(wea),
			.DOB(icedo5), .DOPB(),
			.ADDRB(iceifa[12:2]), .CLKB(CLK60MHZ), .DIB(icedi[7:0]), .DIPB(1'b0),
			.ENB(enb5), .SSRB(1'b0), .WEB(icewr)
	);
        RAMB16_S9_S9 ram6 (
			.DOA(rd6), .DOPA(),
			.ADDRA(cpuad[10:0]), .CLKA(clka), .DIA(dia), .DIPA(1'b0),
			.ENA(ena6), .SSRA(1'b0), .WEA(wea),
			.DOB(icedo6), .DOPB(),
			.ADDRB(iceifa[12:2]), .CLKB(CLK60MHZ), .DIB(icedi[7:0]), .DIPB(1'b0),
			.ENB(enb6), .SSRB(1'b0), .WEB(icewr)
	);
        RAMB16_S9_S9 ram7 (
			.DOA(rd7), .DOPA(),
			.ADDRA(cpuad[10:0]), .CLKA(clka), .DIA(dia), .DIPA(1'b0),
			.ENA(ena7), .SSRA(1'b0), .WEA(wea),
			.DOB(icedo7), .DOPB(),
			.ADDRB(iceifa[12:2]), .CLKB(CLK60MHZ), .DIB(icedi[7:0]), .DIPB(1'b0),
			.ENB(enb7), .SSRB(1'b0), .WEB(icewr)
	);
   
   assign eromrd[7:0] = (DCLKSEL1) ? 8'h00 :
                        (ena0) ? rd0 :
                        (ena1) ? rd1 :
                        (ena2) ? rd2 :
                        (ena3) ? rd3 :
                        (ena4) ? rd4 :
                        (ena5) ? rd5 :
                        (ena6) ? rd6 :
                        (ena7) ? rd7 :
			8'h00 ;
   assign eromrd[31:8] = 24'h000000;

   assign dro[7:0] = (!DCLKSEL1) ? 8'h00 :
		     (ena0) ? rd0 :
		     (ena1) ? rd1 :
		     (ena2) ? rd2 :
		     (ena3) ? rd3 :
		     (ena4) ? rd4 :
		     (ena5) ? rd5 :
		     (ena6) ? rd6 :
		     (ena7) ? rd7 :
		     8'h00 ;
   assign dro[11:8] = 4'h0;
   
   assign icedo[7:0] = (enb0) ? icedo0 :
		       (enb1) ? icedo1 :
		       (enb2) ? icedo2 :
		       (enb3) ? icedo3 :
		       (enb4) ? icedo4 :
		       (enb5) ? icedo5 :
		       (enb6) ? icedo6 :
		       (enb7) ? icedo7 :
		       8'b0;
   assign icedo[31:8] = 24'h000000;
   
endmodule

module RAMB16_S9_S9_dummy (DOA, DOB, DOPA, DOPB, ADDRA, ADDRB, CLKA, CLKB, DIA, DIB, DIPA, DIPB, ENA, ENB, SSRA, SSRB, WEA, WEB);

    output [7:0] DOA;
    assign DOA = 8'h00;
    output [0:0] DOPA;
    assign DOAPA = 1'b0;

    input [10:0] ADDRA;
    input [7:0] DIA;
    input [0:0] DIPA;
    input ENA, CLKA, WEA, SSRA;

    output [7:0] DOB;
    assign DOB = 8'h00;
    output [0:0] DOPB;
    assign DOAPB = 1'b0;

    input [10:0] ADDRB;
    input [7:0] DIB;
    input [0:0] DIPB;
    input ENB, CLKB, WEB, SSRB;

endmodule // RAMB16_S9_S9

// -----------------------------------------------------------------------------
// $Log: not supported by cvs2svn $
// Revision 1.10  2010/10/13 14:21:43  snisimu
// Support break during FCB working. as ememrom-SS3rd.v [SS3rd Ver1013]
//
// -----------------------------------------------------------------------------
// Revision 1.9  2010/07/23 06:43:56  snisimu
// Corresponding to FCB v1.11 (AF address changed F1000H->F0000H)
// -----------------------------------------------------------------------------
// Revision 1.8  2010/04/05 08:06:36  snisimu
// (1)Change clock 60MHz -> 30MHz for block erase.
// (2)Add delay 10ns for count_adr to ensure hold time.
// (3)Modify the way to latch address for IVerify.(as EVA_EMEMROM SS3rd Ver108)
// -----------------------------------------------------------------------------
// Revision 1.7  2010/02/26 02:11:54  snisimu
// Available multi block erase. (Change the clock of address counter BASECK -> 60MHz)
// -----------------------------------------------------------------------------
// Revision 1.6  2010/02/26 02:05:01  snisimu
// (Missing revision cause of Japanese comment)
// -----------------------------------------------------------------------------
// Revision 1.5  2010/02/18 04:21:28  snisimu
// Modify memory size 4KB -> 16KB.
// -----------------------------------------------------------------------------
