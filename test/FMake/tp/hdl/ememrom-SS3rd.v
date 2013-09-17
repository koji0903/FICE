//------------------------------------------------------------------------------------------------//
// MEMORY I/F BLOCK (CIB/FCB, HOST, ALTROM I/F)                                                   //
//                                                                                                //
// 2006.10.6 ememrom.v  taketoshi.ide@necel                                                       //
//----------------------------------------------------------------------------------------------- //
// 2009.12.14 ememrom-SS3rd.v	Ver100		Tomonori Tsunoda                                  //
//	emulation rom for SS3rd modified from SS2nd based on ememrom-Sector1K.v                   //
//------------------------------------------------------------------------------------------------//
// 2010.01.28	SS3rd Ver101			Tomonori Tsunoda				  //
//	BFAのCPU側のアドレスデコードを変更。CIBの仕様がSS2ndから変更となっており、EMEMの物理      //
//	アドレスとのMatchingが取れなくなっていた。Host I/F見えのアドレスをSS2ndに合せるため、     //
//	CPU側のアドレスデコードを変更した。                                                       //
//------------------------------------------------------------------------------------------------//
// 2010.01.28	SS3rd Ver102			Tomonori Tsunoda				  //
//	Error EmulationのUnit数を5つとし、EEPROM/FLASH Emulationの選択機能を削除した。            //
//------------------------------------------------------------------------------------------------//
// 2010.01.29	SS3rd Ver103			Tomonori Tsunoda				  //
//	DataFlashとError Emulationモジュールを共通化するため、cpu_adrのビット数を2ビット追加し、  //
//	比較するRegisterを最下位ビットまで使用するようにした。                                    //
//------------------------------------------------------------------------------------------------//
// 2010.02.04	SS3rd Ver104			Tomonori Tsunoda                                  //
//	Flash Readモード時(MRG10など)のアドレスLatch方法を変更。SS2ndのときのままだと、Readモード //
//	後最初のアドレスをとりこぼしてしまうため。                                                //
//------------------------------------------------------------------------------------------------//
// 2010.03.02	SS3rd Ver105			Tomonori Tsunoda                                  //
//	CPU Reset中にHostからFlashへのAccessができなかったため、eromclkのSelectorの論理に         //
//	cpuresetbを追加した。                                                                     //
//------------------------------------------------------------------------------------------------//
// 2010.03.15	SS3rd Ver106			Tomonori Tsunoda				  //
//	Error Emulationにおいて、ExtraのError Emulationが正しく行えなかった問題を修正。DataFlash  //
//	のError Emulationとのmodule共有化を行った際、比較するcpuアドレスを20bitにしたが、比較設定 //
//	値の方が18bitのままだったのを修正。							  //
//------------------------------------------------------------------------------------------------//
// 2010.3.16	SS3rd Ver107			Tomonori Tsunoda				  //
//	IVerifyを1MHzで実施した場合にVerify Errorとなる問題を修正。**但し、cpu->ememのTimingが    //
//	厳しくなる修正(半Clockパス使用)のため、TargetSpeedを満せない場合には戻して制限とするなど  //
//	の考慮が必要なので注意。								  //
//------------------------------------------------------------------------------------------------//
// 2010.3.23	SS3rd Ver108			Tomonori Tsunoda				  //
//	Iverify時のメモリアドレスをcpu_adr_readからa_decに変更。合せて、SS3rd Ver107での修正内容  //
//	を元に戻した。										  //
//------------------------------------------------------------------------------------------------//
// 2010.3.24	SS3rd Ver109			Tomonori Tsunoda				  //
//	SS3rdの消去時間Typである10ms以内に全領域の消去を終らせられるよう修正。			  //
//------------------------------------------------------------------------------------------------//
// 2010.4.12	SS3rd Ver1010			Tomonori Tsunoda				  //
//	Firm実行中にBreakした場合,FCBのSequencerの処理を壊さないように,Alternateのバスを分けるよ  //
//	う修正。また,Firm実行中にBreakした場合は,AlternateからSRAMに対してアクセスできないように  //
//	修正。AlternateからのSRAMアクセスは行わないSoft仕様とし,すなわち一瞬BreakによるRRM,DMMを  //
//	行えないUser仕様とすることで対応する。							  //
//------------------------------------------------------------------------------------------------//
// 2010.08.06	SS3rd Ver1011			Tomonori Tsunoda				  //
//	CPU空間のEmulation Registerを初期化する信号(cpu_reg_res1)の初期化条件がsysrsoutbだった為, //
//	resbに変更した。sysrsoutbだと、ICEのResetが済んでいてもCPUがまだResetされていないときにも //
//	CPU系の信号を使用してしまう論理になっていたため。					  //
//------------------------------------------------------------------------------------------------//
// 2010.09.29	SS3rd Ver1012			shunji.nishimura.pv@rms				  //
//	■消去中にブレークした場合に消去処理が止まってしまう不具合の修正                          //
//	■ブレーク時にホストから消去中である事が分かるようにERASEFLAGレジスタ(0804_2010H)を追加   //
//------------------------------------------------------------------------------------------------//
// 2010.10.13 SS3rd Ver1013  shunji.nishimura.pv@rms                                              //
//      FCB動作中のブレークをサポート。FCBのステータス信号類をSVMODでマスクしていたが、           //
//      これらを外した。                                                                          //
//------------------------------------------------------------------------------------------------//
// 2010.10.20 SS3rd Ver1014  shunji.nishimura.pv@rms                                              //
//      BootSwapに対応(ERR_CMPにswap信号を追加)                                                   //
//      errmskhxレジスタ 3bit -> 4bit                                                             //
//------------------------------------------------------------------------------------------------//
// 2010.10.26 [SS3rd Ver1015] by shunji.nishimura.pv@rms                                          //
//      Extraスワップ時に反転するアドレスをbit11からbit10に変更                                   //
//      (Redmineチケット→ http://nqjpc147:1030/redmine/issues/159 )                              //
//------------------------------------------------------------------------------------------------//
// 2010.10.27 [SS3rd Ver1016] by shunji.nishimura.pv@rms                                          //
//      ExtraのSectro2にアクセスした際にはerradrのスワップは行なわないように修正                  //
//      (Redmineチケット→ http://nqjpc147:1030/redmine/issues/166 )                              //
//------------------------------------------------------------------------------------------------//

module EVA_EMEMROM(
	eromrd_b, eromwr_b, eromcs_b, eromclk, erompa, erompd,
	rdclkp1_out, exa_out,
	wwr_out, cer_out, ser_out, exer_out,
	mrg00_out, mrg01_out, mrg10_out, mrg11_out, mrg12_out, dis_out, read_out,
	fclk_out, progi_out, bfa_out,
	iceifa, icedi, icedo, icewr, eromwait,
	svmod, svmodf, alt1, prefix, slflash, flread, pa, waitfl2,
	slmem, exma, ma, mdw, memmdr, cpuwr, cpurd, wdop, waitmem,
	slbmem, flspmd, 
	btflg, tmspmd, tmbtsel, resb, swap, icetmspmd, icetmbtsel,
	clksel1, rdclkp1, ce0, ce1, exa, a19_2, ro1, ro0, selro1, cibpid, cpupid,
	exch, wwr, cer, ser, mrg00, mrg01, mrg10, mrg11, mrg12, dis, read,
	fclk, progi, wed, bfa, dw, beu, icenoecc, iceflerr,
	maaout, selfmode, selfmodedbg,
	flmd0, failmk12, brkfail12,
	bfbrkctl, bfbrkpid,
	cpuresetb, sysrsoutb, baseck, ck60mhz
	);

	//----- SRAM I/F -----//
	output eromrd_b, eromwr_b, eromcs_b, eromclk;
	output [17:0] erompa;
	inout  [31:0] erompd;

	//----- CIB Signal Output Pin -----//
	output rdclkp1_out, exa_out;

	//----- FCB Signal Output Pin -----//
	output wwr_out, cer_out, ser_out, exer_out,
	       mrg00_out, mrg01_out, mrg10_out, mrg11_out, mrg12_out, dis_out, read_out,
	       fclk_out, progi_out, bfa_out;

	//----- HOST I/F -----//
	input  [31:0] iceifa;
	input  [31:0] icedi;
	output [31:0] icedo;
	input  icewr;
	output eromwait;

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
	input  [15:0] ma;
	input  [15:0] mdw;
	output [15:0] memmdr;
	input  cpuwr;
	input  cpurd;
	input  wdop;
	output waitmem;

	//----- SLBMEM I/F -----//
	input	slbmem;

	//----- FLSPMD I/F -----//
	input  flspmd;
//	output iceflspmd; // [SS3rd Ver1010] Deleted.

	//----- BSWAP I/F -----//
	input	btflg;
	input	tmspmd;
	input	tmbtsel;
	input	resb;
	output	swap;
	output	icetmspmd;
	output	icetmbtsel;

	//----- CIB I/F -----//
	input  clksel1;
	input  rdclkp1;
	input  ce0;
	input  ce1;
	input  exa;
	input  [17:0] a19_2;
	output [37:0] ro1;
	output [37:0] ro0;
	input  selro1;
	input  [31:0] cibpid;	// [SS3rd Ver1010]
	output [31:0] cpupid;	// [SS3rd Ver1010]

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
	input  bfa;
	input  [37:0] dw;
	input  [2:0]  beu;
	output icenoecc;
	output iceflerr;

	//----- FAIL SAFE I/F -----//
	output maaout;

	//----- SELFMODE & SELFDEBUG OUTPUT -----//
	output selfmode;
	output selfmodedbg;

	//----- SELFMODE FAILSAFE SIGNAL -----//
	input  flmd0;
	input  failmk12;
	output brkfail12;

	//----- RUNBRK -----//
	input  bfbrkctl;
	input  [31:0] bfbrkpid;

	//----- OTHER I/F -----//
	input  cpuresetb;
	input  sysrsoutb;
	input  baseck;
	input  ck60mhz;

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

	//----- BFA select -----//
	wire slbfa;

	//----- SRAM I/F Signal -----//
	wire eromclk;
	wire [17:0] erompa;
	wire [31:0] erompd;
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

	//----- HOST I/F Signal -----//
	wire iceifa31,iceifa30,iceifa29,iceifa28,iceifa27,iceifa26,iceifa25,iceifa24,
		 iceifa23,iceifa22,iceifa21,iceifa20,iceifa19,iceifa18,iceifa17,iceifa16,
		 iceifa15,iceifa14,iceifa13,iceifa12,iceifa11,iceifa10,iceifa9,iceifa8,
		 iceifa7,iceifa6,iceifa5,iceifa4,iceifa3,iceifa2,iceifa1,iceifa0;
	wire iceeromcs_pre;
	reg  iceeromcs_l;
	reg  iceeromcs;

	//----- ALTROM I/F Signal -----//
	wire [31:0] alt_cpu_do, alt_ice_do, alt_ice_di;
	wire altromcs, alt_icewr;
	wire [17:0] alt_pa, alt_iceifa;
	wire [31:0] altro; // [SS3rd Ver1010]
	//----- HOST Emulation Registor -----//
	reg  [1:0] icedo_reg;
	reg  maacopy;
	wire slmaa;
	reg  debugmode;
	reg  fsexeflag;
        wire eraseflag;
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
	wire mcksel;
	wire [17:0] romwa;
	wire sl_swap;
	wire [17:0] romwa_dec;

	//----- ICEIFA Latch Address Bus -----//
	wire sl_ice_swap;
	wire [17:0] iceaddress;
	reg  [17:0] ice_adr_dec_pre;
	reg  [17:0] ice_adr_dec;

	//----- HOST Write Address & Data -----//
	reg  [31:0] icewritedata;

	wire ice_user_res1;
	reg  icewr_start;
	reg  icewr_start_latch;
	reg  ice_write;
	reg  ice_write_latch;
	wire icerd_mask;

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
	reg  rom_cs, romwr_en;

	//----- RO Hold Signal -----//
	reg  [37:0] ro;
	wire [31:0] ro_hold;
	reg  [31:0] ro_l;
	reg  ce_l_p;

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
	// [ SS3rd Ver102 ]
	reg  [15:0] erradrl1, erradrl2, erradrl3, erradrl4, erradrl5;
	reg  [3:0] erradrh1, erradrh2, erradrh3, erradrh4, erradrh5;
	reg  [6:0]  err_mode1, err_mode2, err_mode3, err_mode4, err_mode5;
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

	//----- FlashSelf FailSafe Break -----//
	reg flmd0_sync_pre;
	reg flmd0_sync;

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

	//----- CER/SER Mode Address Counter -----//
	reg  [16:0] count_adr;

	wire auto_change;
	wire reg_write;
	wire [1:0] reg_write_data;

	//----- boot swap -----//
	wire swap_p, swap, icetmspmd, icetmbtsel;
//------------------------------------------------------------------------------------------------//
// 常に1の信号生成、合成時に縮退させないため                                                      //
//------------------------------------------------------------------------------------------------//
	wire dmy1 = sysrsoutb | slflash;
	wire dmy2 = sysrsoutb | slflash;

//------------------------------------------------------------------------------------------------//
// HOST Address Bus                                                                               //
//------------------------------------------------------------------------------------------------//
	assign	{iceifa31,iceifa30,iceifa29,iceifa28,iceifa27,iceifa26,iceifa25,iceifa24,
			iceifa23,iceifa22,iceifa21,iceifa20,iceifa19,iceifa18,iceifa17,iceifa16,
			iceifa15,iceifa14,iceifa13,iceifa12,iceifa11,iceifa10,iceifa9,iceifa8,
			iceifa7,iceifa6,iceifa5,iceifa4,iceifa3,iceifa2,iceifa1,iceifa0}
			= iceifa;

//------------------------------------------------------------------------------------------------//
// OUTPUT PIN                                                                                     //
//------------------------------------------------------------------------------------------------//
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
	assign bfa_out = bfa;

	//----- MAACOPY OUTPUT-----//
	assign maaout = maacopy;

	//----- ICENOECC OUTPUT -----//
	assign icenoecc = 1'b1;

	//----- ICEFLERR OUTPUT -----//
	assign iceflerr = iceflerr_out;

	//----- WAIT SIGNAL OUTPUT -----//
	assign eromwait = icerd_mask | alt_icerd_mask;
	assign waitfl2 = 1'b0;
	assign waitmem = 1'b0;

//------------------------------------------------------------------------------------------------//
// ★TBTSELIN の生成と出力 -> BSWAP Control                                                       //
//------------------------------------------------------------------------------------------------//
// [SS3rd Ver100 ]										  //
// ・DeviceのBootSwap信号について								  //
// SS2nd時はTBTSEL信号(tbtselout)を使ってBootSwap処理を行っていた。				  //
// SS3rdではTBTSEL信号がなく、代りにTBSPMD,TMBTSEL,BTFLG信号によってTBTSEL信号を実現している。	  //
// CIB内の制御論理:BTSWAP(TBTSEL相当) = TMBSPMD ? TMBTSEL : ~BTFLG				  //
// ・BootSwap信号のICE用制御について								  //
// UserProgramがBootSwapした状態でBreakすると,AlternateProgram(Break中にICEがフェッチするProgram) //
// もSwapするが,AlternateProgramはSwapに対応して配置していない為,swap信号をMaskしてCIBMacroへ渡す //
// ことで,Swap処理をMaskする。swap信号のDeviceMacroとのI/F信号はicetmspmd,icetmbtsel。		  //
// ・swap信号について										  //
// SS2ndではtbtselout(=TBTSEL)をEMEMのHostアドレスのSwapとALT Emulation RegisterのアドレスSwap,	  //
// Statusブロックで使用し,cibに対してはice用にSwapさせない制御を加えた信号(=tbtselin)を渡して	  //
// いた。SS3rdでは前者のICEMacroで使用する信号としてswap_p信号を作っている。(cib内で生成している  //
// Swap信号と同じ論理。)この信号は,btflgの初期値が0(swapする)であることからcpureset時にActive(=1) //
// となる。この動きはSS2ndのICEと異なる。SoftはReset中には何も行わないので問題ないが,既存のSimTP  //
// ではReset中にOptionByteの設定などを行っているので,TP流用性の観点からresbとAndしている(swap)。  //
// Reset中はSoft(HOST)で何もせず,ALTProgramは動かないので問題ない。				  //
//------------------------------------------------------------------------------------------------//
	assign	swap_p = tmspmd ? tmbtsel : ~btflg;
	assign	swap = resb & swap_p;
	assign	icetmspmd = (svmodf & ~(alt1 & flread)) ? 1'b1 : tmspmd;
	assign	icetmbtsel = (svmodf & ~(alt1 & flread)) ? 1'b0 : tmbtsel;

//------------------------------------------------------------------------------------------------//
// ★ICEFLSPMD の生成と出力 -> FLSPMD Control                                    		  //
//------------------------------------------------------------------------------------------------//
// フラッシュファームデバッグでBRAM実行中にFLSPMDをセットするとIROM、ALTROM領域への               //
// フェッチはできなくなるため、ブレークする場合にFLSPMDをsvmodfで強制的に解除する                 //
//------------------------------------------------------------------------------------------------//
// [SS3rd Ver100 ]										  //
// SS2ndではfcb<->cibにFLMOD,FLSPMDの2信号があった為,それぞれSVMODを考慮する制御を加えていた。	  //
// SS3rdではfcb<->cibにFLSPMDしかなく,cib内でFLSPMDからFLMODを生成している(FLMOD=FLSPM | テスト	  //
// 用の信号)。よって,FLMODは不要(FLSPMDで網羅)となったため,iceflmodは削除した。			  //
//------------------------------------------------------------------------------------------------//
// [SS3rd Ver1010]
// Firm実行(FLSPM=1)中にBreakした場合,flspmd=0とすると,SRAMへのバスがFCBのバスからCPUのバスに繋ぎ //
// 変ってしまい,Sequencerの処理をこわしてしまうため,SVMODによる制御はおこなわず,そのままFCBから   //
// CIBにthroughさせる。
//	assign iceflspmd = ~svmodf & flspmd;

//------------------------------------------------------------------------------------------------//
// FLASH SELF MODE Control                                                                        //
//------------------------------------------------------------------------------------------------//
// FLSPMDを強制的に解除する時、アクセスモード信号も同じく強制的に解除する。という思想が           //
// 初期にはあったが、SS3rdからはブレークありなのでステータスはSVMODでマスクしない。               //
// (このような背景から、無駄に_dbgの付いた信号が残っている。)                                     //
// リード系のアクセスモードはread_modeとして一つにまとめる                                        //
//------------------------------------------------------------------------------------------------//
	assign wwr_dbg = wwr; // [SS3rd Ver1013]
	assign cer_dbg = cer; // [SS3rd Ver1012]
	assign ser_dbg = ser; // [SS3rd Ver1012]
	assign mrg00_dbg = mrg00; // [SS3rd Ver1013]
	assign mrg01_dbg = mrg01; // [SS3rd Ver1013]
	assign mrg10_dbg = mrg10; // [SS3rd Ver1013]
	assign mrg11_dbg = mrg11; // [SS3rd Ver1013]
	assign mrg12_dbg = mrg12; // [SS3rd Ver1013]
	assign dis_dbg = dis; // [SS3rd Ver1013]
	assign read_dbg = read; // [SS3rd Ver1013]

	assign read_mode = mrg00 | mrg01 | mrg10 | mrg11 | mrg12 | read;
	assign read_mode_dbg = read_mode; // [SS3rd Ver1013]

//------------------------------------------------------------------------------------------------//
// ★SELFMODE / SELFMODEDBG の生成                                                                //
//------------------------------------------------------------------------------------------------//
// シリアルプログラミングモード中にユーザRAM空間をアクセスした場合SELFMODE信号が                  //
// 落ちないようにするためのラッチ(ユーザRAMにアクセスする可能性があるのはFLSPMD=1の時)            //
//------------------------------------------------------------------------------------------------//
// [ SS3rd Ver100 ]										  //
// ice機能を隱す条件を変更.ライブラリ実行の一部(BRAMフェッチ時)は隱す.また,iceflspmd_lは削除.	  //
// [SS2nd仕様]											  //
// Firm実行中ice機能を隱す/ライブラリ実行中は隱さない/Firm実行中のユーザ割込み時は隱さない/Firm	  //
// のBRCROSS使用中は隱す.									  //
// [SS2nd]											  //
// slbmemを使うとBFA/BRAMからのフェッチ中が隱される.ライブラリはBFA/BRAMを使わないのでslbmemで	  //
// 隠されない.Firm実行中のユーザ割込み時は一旦Frim処理を中断(このときflspmを0にする)してから割	  //
// 込みを受付,割込み中はselbmem=0でflspm=0なので隱されない.BRCROSSはデータアクセスにのみ使用す    //
// るので隱されない.(以上から,iceflspmd_lは不要と思われる.)					  //
// [SS3rd]											  //
// ライブラリがBRAMを使用するため,slbmemを使うとライブラリ実行中の一部が隠される.そこでbrsamをAND //
// する.brsamはss3rdにおいてSaddrにBRAMをSwapさせるためのcibのRegisterで,Firmでは使用しライブラリ //
// では使用しないので,ライブラリでは隱さなくするために使用.この場合,BFAでbrsamをセットするまでの  //
// 間のFirm実行が隱せないので,selbfapcをOrする.(selbfapc | brsam&slbmem)->FirmはBFAから始まるパタ //
// ーンと BRAMから始まるパターンがあり,BRAMから始まるパターンではBRSAMでは隱しきれないことが判明, //
// 条件が複雑化する一方BRAMを隱すことは問題ないとの他部門の見解より,BRAM実行を一律隱す方針とした. //
//------------------------------------------------------------------------------------------------//
//	//----- FLSPMD Latch -----//
//	always@(posedge baseck or negedge cpuresetb)begin
//		if(~cpuresetb) iceflspmd_l = 1'b0;
//		else if(slbmem) iceflspmd_l = iceflspmd;
//	end
//
//	//----- SELFMODE & SELFDEBUG Output -----//
//	assign selfmode = slbmem | iceflspmd_l;
//	assign selfmodedbg = ~debugmode & ( slbmem | iceflspmd_l);
	assign	selfmode = slbmem;
	assign	selfmodedbg = ~debugmode & selfmode;

//------------------------------------------------------------------------------------------------//
// ★BRKFAIL12 の生成 -> Flash Self Mode Error FailSafe Break Control                             //
//------------------------------------------------------------------------------------------------//
	//----- FLMD0 baseck Synchronous -----//
	always @(negedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) flmd0_sync_pre <= 1'b0;
		else flmd0_sync_pre <= flmd0;
	end

	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) flmd0_sync <= 1'b0;
		else flmd0_sync <= flmd0_sync_pre;
	end

	//----- BRKFAIL12 Output -----//
	assign brkfail12 = (slbmem & ~flmd0_sync) & ~svmodf & ~failmk12;

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
//------------------------------------------------------------------------------------------------//
// [SS3rd Ver109]										  //
// チップ消去を10msで行うため、CER,SER時はクロックをCLK60MHZ選択状態にする。			  //
//------------------------------------------------------------------------------------------------//
	//----- BASECK or CK60MHz Select Signal ------//
	assign mcksel = romcksel;
	wire selclk = (cer_dbg | ser_dbg) ? 1'b0 : mcksel;  // [SS3rd Ver109] Added. Use 60MHz in CER and SER.

	CLKSEL clksel (.clkout(eromclk), .auto_change(auto_change), .clkin0(ck60mhz), .clkin1(baseck),
                   .selclk(selclk), .cpuresetb(cpuresetb), .resetb(sysrsoutb));

//------------------------------------------------------------------------------------------------//
// ★iceeromcs の生成 -> HOST Address IROM and ALTROM chip select                                 //
//------------------------------------------------------------------------------------------------//
// ALTRAM   0203_7C00H - 0203_FB7FH                                                               //
// ALTROM   0200_0000H - 0200_5FFFH   <--- altromcs                                               //
// IRAM     0110_2000H - 0113_FBFFH                                                               //
// IROM     0100_0000H - 010E_FFFFH   <--- iceeromcs                                              //
//                                                                                                //
// ICEIFA24 == 1 -> User Memory select(01xx_xxxxH)                                                //
// ICEIFA20 == 0 -> IROM area select(010x_xxxxH)                                                  //
//                                                                                                //
// ICEIFA25 == 1 -> ALT Memory select(020x_xxxxH)                                                 //
// ICEIFA17-16 == 0 -> ALTROM area select(0200_xxxx)                                              //
// ---------------------------------------------------------------------------------------------  //
// ホスト空間のメモリセレクト信号はEROMCLKで同期させてから使用する                                //
//------------------------------------------------------------------------------------------------//
	assign iceeromcs_pre = ~iceifa31 & ~iceifa30 & ~iceifa29 & ~iceifa28 &
                           ~iceifa27 & ~iceifa26 & ~iceifa25 & iceifa24 & ~iceifa20;
	assign altromcs = ~iceifa31 & ~iceifa30 & ~iceifa29 & ~iceifa28 &
	                  ~iceifa27 & ~iceifa26 &  iceifa25 & ~iceifa24 & ~iceifa17 & ~iceifa16 ;

	always @(negedge eromclk or negedge sysrsoutb)begin
		if(~sysrsoutb) iceeromcs_l <= 1'b0;
		else iceeromcs_l <= iceeromcs_pre;
	end

	always @(posedge eromclk or negedge sysrsoutb)begin
		if(~sysrsoutb) iceeromcs <= 1'b0;
		else iceeromcs <= iceeromcs_l;
	end

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
	assign flash_cs = wwr_dbg | cer_dbg | ser_dbg | read_mode;

	//----- CS Signal -----//
	/* ------------------------------------------------------------------------------------	*/
	/* [SS3rd Ver1010]									*/
	/* Firm実行(FLSPM=1)中にBreakしてもSRAMのCSをInactiveにならないように変更.		*/
	/* ------------------------------------------------------------------------------------	*/
//	assign eromcs_b_pre = mcksel ? ~rom_cs & alt1_flread_cs_b & (~flash_cs | svmodf) : ~iceeromcs;
	assign eromcs_b_pre = mcksel ? ~rom_cs & alt1_flread_cs_b & ~flash_cs : ~iceeromcs;

	//----- 5ns Delay -----//
	EMEM_DLY5NS_H cs_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(eromcs_b_pre), .out(eromcs_b) );

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
	assign sl_cpurd = ~read_mode | cer_dbg | ser_dbg | wwr_dbg | svmodf;

	assign cpu_rd = clksel1 ? sl_cpurd : ~sl_selfcpurd;

	//----- Read Enable Signal -----//
	/* ------------------------------------------------------------------------------------	*/
	/* [SS3rd Ver1010]									*/
	/* alternateによるSRAM書込み(rom_cs=1)要求があっても,Firm実行(FLSPM=1)中であればFirmの	*/
	/* 実行を優先するように変更(rom_cs -> romcs & ~flspmd).					*/
	/* ------------------------------------------------------------------------------------	*/
	assign eromrd_b_pre = mcksel ? (rom_cs & ~flspmd) | ~flread_rd & cpu_rd : icerd_mask | ~iceeromcs;

	//----- 5ns Delay -----//
	EMEM_DLY5NS_H rd_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(eromrd_b_pre), .out(eromrd_b) );

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
	// -----------------------------------------------------------------------------//
	// [SS3rd Ver109]								//
	// CER,SER時のクロックをCLK60MHZとするため、erase_enを60MHz同期信号にする。	//
	// -----------------------------------------------------------------------------//
	reg [1:0] fclk60m;
	always @(posedge ck60mhz or negedge sysrsoutb) begin
		if (~sysrsoutb)	fclk60m <= 2'b00;
		else		fclk60m <= {fclk60m[0], fclk};
	end
	assign erase_en = (cer_dbg | ser_dbg) & fclk60m[1] & ~wed;

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
	/* ------------------------------------------------------------------------------------	*/
	/* [SS3rd Ver1010]									*/
	/* alternateによるSRAM書込み(romwr_en=1)要求があっても,Firm実行(FLSPM=1)中であればFirm	*/
	/* の実行を優先するように変更(romwr_en -> romwr_en & ~flspmd).				*/
	/* ------------------------------------------------------------------------------------	*/
	assign eromwr_b_pre = mcksel ? ~(romwr_en & ~flspmd | erase_en | flwrite_en) : ~ice_write;

	//----- 5ns Delay -----//
	EMEM_DLY5NS_H wr_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(eromwr_b_pre), .out(eromwr_b) );

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
	/* ------------------------------------------------------------------------------------	*/
	/* [SS3rd Ver1010]									*/
	/* alternateによるSRAM書込み(rom_cs=1)要求があっても,Firm実行(FLSPM=1)中であればFirm	*/
	/* の実行を優先するように変更(rom_cs -> rom_cs & ~flspmd).				*/
	/* ------------------------------------------------------------------------------------	*/
	assign cpu_adr_dec = (rom_cs & ~flspmd) ? romwa_dec : cpu_adr;

	//----- SRAM Address Bus -----//
	assign erompa_pre = mcksel ? cpu_adr_dec : ice_adr_dec;

	//----- 5ns Delay -----//
	EMEM_DLY5NS_L pa_00_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[0]), .out(erompa[0]) );
	EMEM_DLY5NS_L pa_01_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[1]), .out(erompa[1]) );
	EMEM_DLY5NS_L pa_02_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[2]), .out(erompa[2]) );
	EMEM_DLY5NS_L pa_03_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[3]), .out(erompa[3]) );
	EMEM_DLY5NS_L pa_04_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[4]), .out(erompa[4]) );
	EMEM_DLY5NS_L pa_05_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[5]), .out(erompa[5]) );
	EMEM_DLY5NS_L pa_06_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[6]), .out(erompa[6]) );
	EMEM_DLY5NS_L pa_07_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[7]), .out(erompa[7]) );
	EMEM_DLY5NS_L pa_08_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[8]), .out(erompa[8]) );
	EMEM_DLY5NS_L pa_09_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[9]), .out(erompa[9]) );
	EMEM_DLY5NS_L pa_10_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[10]), .out(erompa[10]) );
	EMEM_DLY5NS_L pa_11_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[11]), .out(erompa[11]) );
	EMEM_DLY5NS_L pa_12_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[12]), .out(erompa[12]) );
	EMEM_DLY5NS_L pa_13_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[13]), .out(erompa[13]) );
	EMEM_DLY5NS_L pa_14_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[14]), .out(erompa[14]) );
	EMEM_DLY5NS_L pa_15_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[15]), .out(erompa[15]) );
	EMEM_DLY5NS_L pa_16_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[16]), .out(erompa[16]) );
	EMEM_DLY5NS_L pa_17_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erompa_pre[17]), .out(erompa[17]) );

//------------------------------------------------------------------------------------------------//
// ★EROMPD の生成 -> Data Bus Select                                                             //
//------------------------------------------------------------------------------------------------//
	//----- SRAM DATA BUS -----//
	assign erompd = ((iceeromcs & ice_write) | sl_cpubus) ? erom_wd : 32'hzzzz_zzzz;

	//----- FCB DATA BUS -----//
	/* ------------------------------------------------------------------------------------	*/
	/* [SS3rd Ver1010]									*/
	/* SRAMのData BusとalternateのData Busを分離.ro_holdはSRAM専用とした.			*/
	/* ------------------------------------------------------------------------------------	*/
//	assign ro_hold = bfbrkctl ? bfbrkpid : (!svmodf | flread_rd ) ? erompd : alt_cpu_do;
	assign ro_hold = bfbrkctl ? bfbrkpid : erompd;
	assign	cpupid = (!svmodf | flread_rd ) ? cibpid : altro;

	//----- HOST READ DATA BUS Select -----//
	assign icedo = (iceeromcs & !icerd_mask) ? erompd : (altromcs) ? alt_ice_do : 
					(hostreg_sel) ? {30'h0000_0000, icedo_reg} : 32'h0000_0000;

	//----- WRITE DATA Select -----//
	assign sl_cpubus = rom_cs | wwr_dbg | cer_dbg | ser_dbg;
	assign cpu_wr_data = wwr_dbg ? dw[31:0] : (cer_dbg | ser_dbg) ? 32'hFFFF_FFFF : {romwd1, romwd0};

	assign erom_wd_pre = sl_cpubus ? cpu_wr_data : icewritedata;

	//----- 5ns Delay -----//
	EMEM_DLY5NS_L pd_00_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[0]), .out(erom_wd[0]));
	EMEM_DLY5NS_L pd_01_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[1]), .out(erom_wd[1]));
	EMEM_DLY5NS_L pd_02_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[2]), .out(erom_wd[2]));
	EMEM_DLY5NS_L pd_03_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[3]), .out(erom_wd[3]));
	EMEM_DLY5NS_L pd_04_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[4]), .out(erom_wd[4]));
	EMEM_DLY5NS_L pd_05_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[5]), .out(erom_wd[5]));
	EMEM_DLY5NS_L pd_06_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[6]), .out(erom_wd[6]));
	EMEM_DLY5NS_L pd_07_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[7]), .out(erom_wd[7]));
	EMEM_DLY5NS_L pd_08_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[8]), .out(erom_wd[8]));
	EMEM_DLY5NS_L pd_09_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[9]), .out(erom_wd[9]));
	EMEM_DLY5NS_L pd_10_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[10]), .out(erom_wd[10]));
	EMEM_DLY5NS_L pd_11_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[11]), .out(erom_wd[11]));
	EMEM_DLY5NS_L pd_12_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[12]), .out(erom_wd[12]));
	EMEM_DLY5NS_L pd_13_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[13]), .out(erom_wd[13]));
	EMEM_DLY5NS_L pd_14_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[14]), .out(erom_wd[14]));
	EMEM_DLY5NS_L pd_15_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[15]), .out(erom_wd[15]));
	EMEM_DLY5NS_L pd_16_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[16]), .out(erom_wd[16]));
	EMEM_DLY5NS_L pd_17_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[17]), .out(erom_wd[17]));
	EMEM_DLY5NS_L pd_18_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[18]), .out(erom_wd[18]));
	EMEM_DLY5NS_L pd_19_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[19]), .out(erom_wd[19]));
	EMEM_DLY5NS_L pd_20_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[20]), .out(erom_wd[20]));
	EMEM_DLY5NS_L pd_21_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[21]), .out(erom_wd[21]));
	EMEM_DLY5NS_L pd_22_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[22]), .out(erom_wd[22]));
	EMEM_DLY5NS_L pd_23_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[23]), .out(erom_wd[23]));
	EMEM_DLY5NS_L pd_24_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[24]), .out(erom_wd[24]));
	EMEM_DLY5NS_L pd_25_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[25]), .out(erom_wd[25]));
	EMEM_DLY5NS_L pd_26_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[26]), .out(erom_wd[26]));
	EMEM_DLY5NS_L pd_27_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[27]), .out(erom_wd[27]));
	EMEM_DLY5NS_L pd_28_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[28]), .out(erom_wd[28]));
	EMEM_DLY5NS_L pd_29_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[29]), .out(erom_wd[29]));
	EMEM_DLY5NS_L pd_30_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[30]), .out(erom_wd[30]));
	EMEM_DLY5NS_L pd_31_dly (.dmy1(dmy1), .dmy2(dmy2), .sysrsoutb(sysrsoutb), .in(erom_wd_pre[31]), .out(erom_wd[31]));

//------------------------------------------------------------------------------------------------//
// ★cpu_adrの生成 -> CPU Address Decode                                                          //
//------------------------------------------------------------------------------------------------//
/* [SS3rd Ver1010]										*/
/* svmod中にSRAMのアドレスバスがFCBからCPUに切り替わらないよう,svmod信号を除外した.		*/
/* (dis_dbg,wwr_dbg,cer_dbg,ser_dbg,read_mode_dbg -> dis,wwr,cer,ser,read_mode)			*/
/* --------------------------------------------------------------------------------------------	*/
	always @( a_dec or cpu_adr_latch or count_adr or ser_adr or cpu_adr_read or
	          dis or wwr or cer or ser or read_mode )begin
		casex({dis, wwr, cer, ser, read_mode})
			5'b1xxxx : cpu_adr = 18'h0;
			5'b01000 : cpu_adr = cpu_adr_latch;
			5'b00100 : cpu_adr = {1'b0, count_adr};
			5'b00010 : cpu_adr = ser_adr;
			5'b00001 : cpu_adr = cpu_adr_read;
			default : cpu_adr = a_dec;
		endcase
	end

//------------------------------------------------------------------------------------------------//
// [SS3rd Ver101 ]										  //
// ★a_decの生成 -> A19-2 Address Decode                                                          //
//------------------------------------------------------------------------------------------------//
// a19_2 = 18bit Address Bus                                                                      //
//------------------------------------------------------------------------------------------------//
// EXA == 1                 -> F_E000H - F_FFFF Extra Area 8Kbyte(max)                            //
// EXTRA領域はEXA信号が立ったらアクセス                                                           //
//------------------------------------------------------------------------------------------------//
// BFA == 1 & CLKSEL1 == 1  -> F_0000H - F_27FF BFA領域 10Kbyte(実アドレス E_D800H - E_FFFFH)     //
// CPU AddressはE_D800H-E_FFFFHだが,SS2nd用EMEMのBFA空間割に合せSRAMのF_0000H-F_27FFHに実体を置く.//
// CIBはBFA用に特別にAdr変換は行わないので,ED800h->F0000hの変換(+10K=2800h)を行う(A=+2800/4=a00h).//
//------------------------------------------------------------------------------------------------//
	//----- BFA select -----//
        assign slbfa = bfa; // & pa[17] & pa[16] & pa[15] & ~pa[14] & pa[13] & pa[12] & pa[11];

	//----- a_dec Decode -----//
	wire [11:0]  a_dec_bfa = a19_2[11:0] + 12'ha00;
	assign a_dec = exa               ? {7'b1111111, a19_2[10:0]} :          // [SS3rd Ver1013]
//	               (slbfa & clksel1) ? {6'b111100, a19_2[11:0]}  : a19_2;	// for ss2nd
		       (slbfa & clksel1) ? {6'b111100, a_dec_bfa}    : a19_2;	// for ss3rd

//------------------------------------------------------------------------------------------------//
// ★cpu_adr_latch / cpu_adr_readの生成 -> DIS/WWR/READ/MRGxx Mode Address Latch                  //
//------------------------------------------------------------------------------------------------//
// 通常のフェッチ(clksel1==1)の時は特にアドレスをラッチしない。                                   //
// WWRとCERとSERはDISモードでアドレスをラッチする。ただし、WWRモードはDISモード期間だけでなく     //
// WWRモード期間でも CE=1 & RDCLKP1↑ で下位アドレスだけラッチする必要がある。                    //
//------------------------------------------------------------------------------------------------//

	//----- Address Latch Select -----//
	// ---------------------------------------------------------
	// [SS3rd Ver104]
	// sel_latch_readのTimingを変更。
	// ---------------------------------------------------------
	wire sel_read_mode = read_mode_dbg & ce & ~clksel1 & rdclkp1;
	reg sel_read_mode_l;
	always @(posedge baseck or negedge cpuresetb) begin
		if (!cpuresetb)	sel_read_mode_l <= 1'b0;
		else		sel_read_mode_l <= sel_read_mode;
	end
	assign sel_latch_read = sel_read_mode & ~sel_read_mode_l;
	assign sel_latch_wwr = ce & wwr_dbg & ~rdclkp1;
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
	// ---------------------------------------------------------------------------------------
	// [SS3rd Ver107]
	// posedge baseck -> negedge baseckへ変更。SS3rdでFlash制御がSequencer化されたことで
	// rdclkp1のPulse幅が短くなり、↑では間に合わなくなったため。
	// <1MHz動作時(修正前)>
	// eromclk        |~|_|~|_|~|_|~|_|~|_|~|_|~|_
	// rdclkp1        ~~~~|___|***|_______|~~~~~~~	// 1MHz動作時は***が1MHz幅になる。
	// sel_latch_read ________|~~~|_______|~~~|___
	// adr_latch_read             x===============
	// erompd         ==PreData=======x==Need=====
	// fcb/vcmpb                      x==PreData==
	//
	// fcb/vcmpbはMRG01のデータを取り込むBufferで、このあとMRG11のデータをvcmpaに取り込み
	// 比較を行う。vcmpbの取り込みタイミングはrdclkp1↓のbaseck1Clock後なので、1MHz動作時
	// だとerompdの出力タイミングが間に合わなくなってしまう。
	// <1MHz動作時(修正後)>
	// eromclk        |~|_|~|_|~|_|~|_|~|_|~|_|~|_
	// rdclkp1        ~~~~|___|~~~|_______|~~~~~~~
	// sel_latch_read ________|~~~|_______|~~~|___
	// adr_latch_read           x===============
	// erompd         ==PreData===x==Need=====
	// fcb/vcmpb                      x==Need==
	// *adr_latch_readに取り込むアドレスはa_dec(CIBのA19-2)なので、タイミングが厳しいので注意。
	// [SS3rd Ver108]
	// 前述の通りタイミング的にNGだったため元通りposedgeとした。
	// ---------------------------------------------------------------------------------------
	always @(posedge baseck or negedge cpuresetb)begin
		if(~cpuresetb) adr_latch_read <= 18'h0;
		else if(sel_latch_read) adr_latch_read <= a_dec;
	end

	//----- Read Mode Address Select -----//
	// ---------------------------------------------------------------------------------------
	// [SS3rd Ver108]
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
	/* [SS3rd Ver1010]									*/
	/* Firm実行(FLSPM=1)中にBreakした際,SRAMのアドレスがFCBからCPUに切替らないように変更.	*/
	/* (mrg01_dbg,mrg11_dbg,mrg12dbg -> mrg01,mrg11,mrg12)					*/
	/* ------------------------------------------------------------------------------------	*/
	wire iverify_resb = (mrg01 | mrg11 | mrg12) & cpuresetb;
	reg iverify_state;
	always @(posedge baseck or negedge iverify_resb)begin
		if(~iverify_resb) iverify_state <= 1'b0;
		else if(mrg01) iverify_state <= 1'b1;
	end
	assign cpu_adr_read = (clksel1) ? a_dec : (iverify_state) ? a_dec : adr_latch_read;

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
			4'b0000 : ser_adr = {cpu_adr_latch[17:8], count_adr[7:0]};  //USER FLASH AREA 1Kbyte/1ERASE
			4'b0001 : ser_adr = {cpu_adr_latch[17:9], count_adr[8:0]}; //USER FLASH AREA 2Kbyte/1ERASE
			4'b0010 : ser_adr = {cpu_adr_latch[17:10], count_adr[9:0]};//USER FLASH AREA 4Kbyte/1ERASE
			4'b0011 : ser_adr = {cpu_adr_latch[17:11], count_adr[10:0]};//USER FLASH AREA 8Kbyte/1ERASE
			4'b0100 : ser_adr = {cpu_adr_latch[17:12], count_adr[11:0]};//USER FLASH AREA 16Kbyte/1ERASE
			4'b0101 : ser_adr = {cpu_adr_latch[17:13], count_adr[12:0]};//USER FLASH AREA 32Kbyte/1ERASE
			4'b0110 : ser_adr = {cpu_adr_latch[17:14], count_adr[13:0]};//USER FLASH AREA 64Kbyte/1ERASE
			4'b0111 : ser_adr = {cpu_adr_latch[17:15], count_adr[14:0]};//USER FLASH AREA 128Kbyte/1ERASE
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
// [SS3rd Ver109]										  //
// count_adrを baseck⇒60MHz同期に変更。Address CounterはSER,CER中に対象範囲を一周以上すればよい  //
// ので、Count Enableは不要と判断し削除。							  //
//------------------------------------------------------------------------------------------------//
//	assign sel_count = ( cer_dbg | ser_dbg ) & fclk;

//CPURESETBのみに修正
	always @(posedge ck60mhz or negedge cpuresetb)begin
		if(~cpuresetb)	count_adr <= 17'h0;
		else		count_adr <= count_adr + 1'b1;
	end

//------------------------------------------------------------------------------------------------//
// RO HOLD (SLFLASH -> LOW >>>>> LATCH DATA OUTPUT)                                               //
//------------------------------------------------------------------------------------------------//
// SLFLASH信号が落ちてもデバイスはメモリ出力を保持するが、ICEはFLASHの代わりに                    //
// SRAMを使用しているため出力を保持できない。                                                     //
// そこでBASECKで毎クロック出力データをラッチしておいてSLFLASHが落ちたら                          //
// ラッチしたデータをバスに乗せてFLASHと同じようにデータが見えるようにする。                      //
// [SS3rd Ver100]										  //
// Kx4-DF3.0にてDeviceの動きが変わり,ce_l=1となる直前のタイミングのroをReset-Vectorの飛先アドレス //
// として使うようになった。この場合,ce_l=1でro=ro_holdと変わり,このときのbaseckの立ち上がりで	  //
// Vectorアドレスを取得するが,ICEMacroはfclk同期,Vectorアドレスを作るcpuはbaseck同期の為,sim上	  //
// 非同期の関係となり,ce_l=1となる直前のro値をVectorアドレスとしてしまい,暴走してしまう問題がSim  //
// で起った。実際はICEMacroもcpuもfclk同期にgated Clock変換されるため問題ないが,Simで問題なので	  //
// #1を付ける事で回避している。									  //
//------------------------------------------------------------------------------------------------//
	always @(posedge baseck or negedge cpuresetb) begin
		if (~cpuresetb) ce_l_p <= 1'b0;
		else ce_l_p <= ce;
	end
	wire	#1 ce_l = ce_l_p;

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

	/* ------------------------------------------------------------------------------------	*/
	/* [SS3rd Ver1010]									*/
	/* Firm実行(FLSPM=1)中にBreakした際,SRAMのアドレスがFCBからCPUに切替らないように変更.	*/
	/* alternateのバス(altro)は別途CPUとのみ接続し,制御もcib.ceでなくcpu.slflashで行う.	*/
	/* ------------------------------------------------------------------------------------	*/
	reg altce_l_p;
	always @(posedge baseck or negedge cpuresetb) begin
		if (~cpuresetb) altce_l_p <= 1'b0;
		else altce_l_p <= slflash;
	end
	wire	#1 altce_l = altce_l_p;

	reg [31:0] alt_cpu_do_l;
	always @(posedge baseck or negedge cpuresetb) begin
		if (!cpuresetb) alt_cpu_do_l <= 1'b0;
		else if (altce_l) alt_cpu_do_l <= alt_cpu_do;
	end
	assign	altro = altce_l ? alt_cpu_do : alt_cpu_do_l;

//------------------------------------------------------------------------------------------------//
// RO SELECT CONTROL                                                                              //
//------------------------------------------------------------------------------------------------//
// RO0とRO1のデータを選択する回路。                                                               //
// SELRO1=1でRO1を選択する。                                                                      //
// このときRO0にはFFFF_FFFFhがのり、逆にSELRO1=0の時はRO1にFFFF_FFFFhがのる                       //
//------------------------------------------------------------------------------------------------//
	assign ro0 = ro | {selro1, selro1, selro1, selro1, selro1, selro1, selro1, selro1,
	                   selro1, selro1, selro1, selro1, selro1, selro1, selro1, selro1,
	                   selro1, selro1, selro1, selro1, selro1, selro1, selro1, selro1,
	                   selro1, selro1, selro1, selro1, selro1, selro1, selro1, selro1,
	                   selro1, selro1, selro1, selro1, selro1, selro1};
	assign ro1 = ro | {~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1,
	                   ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1,
	                   ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1,
	                   ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1,
	                   ~selro1, ~selro1, ~selro1, ~selro1, ~selro1, ~selro1};

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
//                              ★ ALTROM Access Control ★                                       //
//                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////
//------------------------------------------------------------------------------------------------//
// ・ALTROM空間へのアドレスバスは常にcpu_adrを接続しておく                                        //
// ・ALTROM空間はDualPortMemoryなのでもう一方へホストのアドレスバスを接続する                     //
// ・ALTROM空間へのホストからの書込み時はラッチしたデータバッファに切替える                       //
// ・それ以外はICEIFAを接続する                                                                   //
//------------------------------------------------------------------------------------------------//
	//----- ALTROM Address Bus -----
	/* ------------------------------------------------------------------------------------	*/
	/* [SS3rd Ver1010]									*/
	/* Firm実行(FLSPM=1)中にBreakした際,SRAMのアドレスがFCBからCPUに切替らないように変更.	*/
	/* alternateのバス(alt_pa)はCPUとのみ接続する.						*/
	/* ------------------------------------------------------------------------------------	*/
	assign alt_pa = pa;

	//----- ALTROM Host Address Bus Select -----
	assign alt_iceifa = altromcs ? iceifa[19:2] : 18'b0;

	//----- ALTROM Host Write Data Bus Select -----//
	assign alt_ice_di = (altromcs & alt_icerd_mask) ? icewritedata : 32'h0000_0000;

	//----- ALTROM Host Write Enable -----//
	assign alt_icewr = alt_ice_write;

	//----- ALTROM 24Kbyte -----//
	ALTROM_REG24K altrom (.cpu_ad(alt_pa), .cpu_do(alt_cpu_do), .cpu_di(32'h0), .cpu_en(svmodf), 
                         .cpu_wr(1'b0),.baseck(baseck), .ice_ad(alt_iceifa), .ice_do(alt_ice_do), 
                         .ice_di(alt_ice_di), .ice_en(altromcs), .ice_wr(alt_icewr), .ck60mhz(ck60mhz),
	                     .cpuresetb(cpuresetb), .sysrsoutb(sysrsoutb));

////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                //
//                               ★ Host Access Control ★                                        //
//                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////
//------------------------------------------------------------------------------------------------//
// ★ice_adr_dec の生成 -> Host Address Latch                                                     //
//------------------------------------------------------------------------------------------------//
	//----- BootSwap Host Address -----//
	assign sl_ice_swap = (iceifa[19:13] == 7'b0) & swap;
	assign iceaddress = (sl_ice_swap) ? {iceifa[19:13], ~iceifa[12], iceifa[11:2]} : iceifa[19:2];

	always @(negedge eromclk or negedge sysrsoutb)begin
		if(~sysrsoutb) ice_adr_dec_pre <= 18'h0;
		else ice_adr_dec_pre <= iceaddress;
	end
	always @(posedge eromclk or negedge sysrsoutb)begin
		if(~sysrsoutb) ice_adr_dec <= 18'h0;
		else ice_adr_dec <= ice_adr_dec_pre;
	end
//------------------------------------------------------------------------------------------------//
// ★icewritedata の生成 -> Write Data Latch                                                      //
//------------------------------------------------------------------------------------------------//
	//----- Host Write Data Latch -----//
	always @(negedge icewr or negedge sysrsoutb) begin
		if(!sysrsoutb) icewritedata <= 32'h0;
		else if( iceeromcs | altromcs ) icewritedata <= icedi;
	end

	//----- EROMCLK Sync -----//
	//同期したほうがよければ追加する

//------------------------------------------------------------------------------------------------//
// ★ice_write / ice_rd_mask / alt_ice_write / alt_icerd_mask の生成 -> Write Timing Signal       //
//------------------------------------------------------------------------------------------------//
// ice_write      ----- IROM write timing signal                                                  //
// icerd_mask     ----- IROM read strobe control signal                                           //
// alt_ice_write  ----- ALTROM write tiiming sigal                                                //
// alt_icerd_mask ----- ALTROM read strobe control signal                                         //
//------------------------------------------------------------------------------------------------//
	//----- IROM Write Timing Signal -----//
	assign ice_user_res1 = !sysrsoutb | ice_write;
	always @(negedge icewr or posedge ice_user_res1) begin
		if(ice_user_res1) icewr_start <= 1'b0;
		else if(iceeromcs) icewr_start <= 1'b1;
	end
	always @(negedge eromclk or negedge sysrsoutb) begin
		if(~sysrsoutb) icewr_start_latch <= 1'b0;
		else if(iceeromcs) icewr_start_latch <= icewr_start;
	end

	always @(posedge eromclk or negedge sysrsoutb) begin
		if(~sysrsoutb) ice_write <= 1'b0;
		else if(iceeromcs) ice_write <= icewr_start_latch;
	end

	always @(negedge eromclk or negedge sysrsoutb) begin
		if(~sysrsoutb) ice_write_latch <= 1'b0;
		else if(iceeromcs) ice_write_latch <= ice_write;
	end

	assign icerd_mask = icewr_start_latch | ice_write | ice_write_latch;

	//----- ALTROM Write Timing Signal -----//
	assign ice_alt_res1 = !sysrsoutb | alt_ice_write;
	always @(negedge icewr or posedge ice_alt_res1) begin
		if(ice_alt_res1) alt_icewr_start <= 1'b0;
		else if(altromcs) alt_icewr_start <= 1'b1;
	end

	always @(negedge ck60mhz or negedge sysrsoutb) begin
		if(~sysrsoutb) alt_icewr_start_latch <= 1'b0;
		else if(altromcs) alt_icewr_start_latch <= alt_icewr_start;
	end

	always @(posedge ck60mhz or negedge sysrsoutb) begin
		if(~sysrsoutb) alt_ice_write <= 1'b0;
		else if(altromcs) alt_ice_write <= alt_icewr_start_latch;
	end

	always @(negedge ck60mhz or negedge sysrsoutb) begin
		if(~sysrsoutb) alt_ice_write_latch <= 1'b0;
		else if(altromcs) alt_ice_write_latch <= alt_ice_write;
	end

	assign alt_icerd_mask = alt_icewr_start_latch | alt_ice_write | alt_ice_write_latch;

//------------------------------------------------------------------------------------------------//
// HOST Emulation Registor                                                                        //
//------------------------------------------------------------------------------------------------//
// Registor name--------HOST address-------- bit7  bit6  bit5  bit4  bit3  bit2  bit1  bit0       //
//   PMCCOPY             0804_2000H           0     0     0     0     0     0     0    maacopy    //
//   ROMCKSEL            0804_2004H           0     0     0     0     0     0     0    romcksel   //
//   SELFDEBIG           0804_2008H           0     0     0     0     0     0     0    debugmode  //
//   SELFFLAG            0804_200CH           0     0     0     0     0     0     0    fsexeflag  //
//   ERASEFLAG           0804_2010H           0     0     0     0     0     0     0    eraseflag  //
//------------------------------------------------------------------------------------------------//
	assign hostreg_sel = ~iceifa31 & ~iceifa30 & ~iceifa29 & ~iceifa28 &
	                     iceifa27 & ~iceifa26 & ~iceifa25 & ~iceifa24 &
	                    ~iceifa23 & ~iceifa22 & ~iceifa21 & ~iceifa20 &
	                    ~iceifa19 &  iceifa18 & ~iceifa17 & ~iceifa16 &
						~iceifa15 & ~iceifa14 &  iceifa13;

	always @( iceifa4 or iceifa3 or iceifa2 or hostreg_sel or maacopy or romcksel or debugmode or fsexeflag or eraseflag) begin
		casex({hostreg_sel, iceifa4, iceifa3, iceifa2})
			4'b0xxx : icedo_reg <= 2'b00;
			4'b1000 : icedo_reg <= {1'b0, maacopy};
			4'b1001 : icedo_reg <= romcksel;
			4'b1010 : icedo_reg <= {1'b0, debugmode};
			4'b1011 : icedo_reg <= {1'b0, fsexeflag};
			4'b1100 : icedo_reg <= {1'b0, eraseflag}; // [SS3rd Ver1012]
			default : icedo_reg <= 2'b00;
		endcase
	end

//------------------------------------------------------------------------------------------------//
// [ ROMCKSEL ] セット -> SRAMへのクロック選択フラグ                                              //
//------------------------------------------------------------------------------------------------//
	wire sel_ice_romcksel;
	assign sel_ice_romcksel = hostreg_sel & ~iceifa3 & iceifa2;
	always @(negedge icewr or negedge sysrsoutb)begin
		if(~sysrsoutb)begin
			ice_romcksel <= 2'b00;
		end
		else if(sel_ice_romcksel)begin
			ice_romcksel <= icedi[1:0];
		end
	end

//------------------------------------------------------------------------------------------------//
// [ DEBUGMODE ] セット -> セルフデバッグモードの選択フラグ                                       //
//------------------------------------------------------------------------------------------------//
	wire sel_debugmode;
	assign sel_debugmode = hostreg_sel & iceifa3 & ~iceifa2;
	always @(negedge icewr or negedge sysrsoutb)begin
		if(~sysrsoutb)begin
			debugmode <= 1'b0;
		end
		else if(sel_debugmode)begin
			debugmode <= icedi[0];
		end
	end

//------------------------------------------------------------------------------------------------//
// [ FSEXEFLAG ] セット -> セルフ書換え、消去実行フラグ                                           //
//------------------------------------------------------------------------------------------------//
// ユーザ領域に対して書き込み、消去を行った時のみフラグを立てる                                   //
// このレジスタへの書き込みでフラグをクリアする                                                   //
//------------------------------------------------------------------------------------------------//
	wire sel_flashself_exe;
	//書き込み、消去時のみフラグを立てる
	assign sel_flashself_exe = ~exa & selfmode & (wwr_dbg | cer_dbg | ser_dbg);
	assign flag_resetb = ~(hostreg_sel & iceifa3 & iceifa2 & icewr) & sysrsoutb;
	always @(posedge baseck or negedge flag_resetb)begin
		if(~flag_resetb) fsexeflag <= 1'b0;
		else if(sel_flashself_exe) fsexeflag <= 1'b1;
	end
//------------------------------------------------------------------------------------------------//
// [ ERASEFLAG ] 消去中かどうかを示す [SS3rd Ver1012][SS3rd Ver1013]
//------------------------------------------------------------------------------------------------//
	 assign erasing = dis | mrg10 | cer | ser ; // 消去中に出るステータス全て
   reg 		erasing_d ;
	 always @(posedge baseck or negedge cpuresetb) begin
			if (!cpuresetb) begin
				 erasing_d <= 1'b0 ;
			end else begin           // ステータスが切り換わる瞬間の谷間を防ぐために
				 erasing_d <= erasing ; // 切り直しの信号を作成してOR(↓)する。
			end
	 end
   assign eraseflag = erasing | erasing_d ;

//------------------------------------------------------------------------------------------------//
// [ MAACOPY ] のセット -> PMCレジスタ（MAA）の値をコピー                                         //
//------------------------------------------------------------------------------------------------//
	//PMC Registor Copy
	assign slmaa = slmem & (ma == 16'hFFFE) & cpuwr;
	
	always @(posedge baseck or negedge cpuresetb) begin
		if(~cpuresetb)begin
			maacopy <= 1'b0;
		end
		else if(slmaa) begin
			maacopy <= mdw[0];
		end
	end

//------------------------------------------------------------------------------------------------//
// ALT Emulation Registor                                                                         //
//------------------------------------------------------------------------------------------------//
// Registor name------CPU address------ Registor bit(Used bit)                                    //
//    ROMWD0           F_C030H          16bit(all bit) -> write data set registor0                //
//    ROMWD1           F_C032H          16bit(all bit) -> write data set registor1                //
//    ROMWA0           F_C034H          16bit(all bit) ->write address set registor0              //
//    ROMWA1           F_C036H          8bit(bit3,bit2,bit1,bit0) -> write address set registor1  //
//    ROMCKSEL         F_C037H          8bit(bit1,bit0) -> ROM clock select registor              //
//    ROMCS            F_C038H          8bit(bit0) -> ROM write mode chip select registor         //
//    ROMWREN          F_C039H          Dummy Registor -> ROM write mode write enable registor    //
//------------------------------------------------------------------------------------------------//

	assign romwritemode = svmodf & !alt1 & slmem & cpuwr & (ma[15:4] == 12'hC03);
	assign altreg_rd = svmodf & !alt1 & slmem & cpurd & (ma[15:4] == 12'hC03);

	//----- ROMWD0 -----//
	wire sel_romwd0;
	assign sel_romwd0 = romwritemode & (ma[3:0] == 4'h0) & wdop;
	always @(posedge baseck or negedge cpuresetb) begin
		if(~cpuresetb) romwd0  <= 16'h0000;
		else if(sel_romwd0) romwd0 <= mdw;
	end

	//----- ROMWD1 -----//
	wire sel_romwd1;
	assign sel_romwd1 = romwritemode & (ma[3:0] == 4'h2) & wdop;
	always @(posedge baseck or negedge cpuresetb) begin
		if(~cpuresetb) romwd1  <= 16'h0000;
		else if(sel_romwd1) romwd1 <= mdw;
	end

	//----- ROMWA0 -----//
	wire sel_romwa0;
	assign sel_romwa0 = romwritemode & (ma[3:0] == 4'h4) & wdop;
	always @(posedge baseck or negedge cpuresetb) begin
		if(~cpuresetb) romwa0  <= 16'h0000;
		else if(sel_romwa0) romwa0 <= mdw;
	end

	//----- ROMWA1 -----//
	wire sel_romwa1;
	assign sel_romwa1 = romwritemode & (ma[3:0] == 4'h6) & ~wdop;
	always @(posedge baseck or negedge cpuresetb) begin
		if(~cpuresetb) romwa1  <= 4'h0;
		else if(sel_romwa1) romwa1 <= mdw[3:0];
	end

	//----- ROMCKSEL -----//
	wire sel_cpu_romcksel;
	assign sel_cpu_romcksel = romwritemode & (ma[3:0] == 4'h7) & ~wdop;
	always @(posedge baseck or negedge cpuresetb) begin
		if(~cpuresetb) cpu_romcksel <= 2'b00;
		else if(sel_cpu_romcksel) cpu_romcksel <= mdw[9:8];
	end

	//----- ROMCS -----//
	wire sel_romcs;
	assign sel_romcs = romwritemode & (ma[3:0] == 4'h8) & ~wdop;
	always @(posedge baseck or negedge cpuresetb) begin
		if(~cpuresetb) romcs   <= 1'b0;
		else if(sel_romcs) romcs <= mdw[0];
	end

	//----- ROMWREN -----//
	wire sel_romwren;
	assign sel_romwren = romwritemode & (ma[3:0] == 4'h9) & ~wdop;
	always @(posedge baseck or negedge cpuresetb) begin
		if(~cpuresetb) romwren <= 1'b0;
		else if(sel_romwren) romwren <= 1'b1;
		else romwren <= 1'b0;
	end

	//----- Boot Swap Address Decode -----//
	assign sl_swap = (romwa[17:11] == 7'b0) & swap;

	assign romwa = {romwa1, romwa0[15:2]};

	assign romwa_dec = (sl_swap) ? {romwa[17:11], ~romwa[10], romwa[9:0]} : romwa;

	//----- CPU Registor Read Output -----//
	always @(sl_icesfr_read or altreg_rd or ma[3:0] or romwd0 or romwd1 or romwa0 or romwa1 or romcksel or romcs or
	         iceadr or icedat_read) begin
			casex ({sl_icesfr_read, altreg_rd, ma[3:0]})
				{1'b0, 1'b0, 4'hx} : memmdr = 16'h0000;
				{1'b0, 1'b1, 4'h0} : memmdr = romwd0;
				{1'b0, 1'b1, 4'h2} : memmdr = romwd1;
				{1'b0, 1'b1, 4'h4} : memmdr = romwa0;
				{1'b0, 1'b1, 4'h6} : memmdr = {8'h00, 4'b0000, romwa1};
				{1'b0, 1'b1, 4'h7} : memmdr = {6'b000000, romcksel, 8'h00};
				{1'b0, 1'b1, 4'h8} : memmdr = {8'h00, 7'b0000000, romcs};
				{1'b1, 1'b0, 4'h0} : memmdr = iceadr;
				{1'b1, 1'b0, 4'h2} : memmdr = icedat_read;
				default		 : memmdr = 16'h0000;
			endcase
	end

//------------------------------------------------------------------------------------------------//
// ROMCLKSEL Registor write                                                                       //
//------------------------------------------------------------------------------------------------//
	assign reg_write = ice_reg_write | auto_change;
	assign reg_write_data = ice_romcksel | {1'b0, auto_change};
	always @(posedge ck60mhz or negedge sysrsoutb)begin
		if(~sysrsoutb) romcksel <= 2'b00;
		else if(cpu_reg_write) romcksel <= cpu_romcksel;
		else if(reg_write) romcksel <= reg_write_data;
	end

	assign romwrite_en = romwritemode & (ma[3:0] == 4'h7) & ~wdop;

	assign cpu_reg_res1 = ~resb | cpu_reg_write;	// [V1011]

	always @(negedge romwrite_en or posedge cpu_reg_res1) begin
		if(cpu_reg_res1) reg_cpuwr_start <= 1'b0;
		else reg_cpuwr_start <= 1'b1;
	end

	//----- IROM write timing signal -----//
	always @(posedge baseck or negedge sysrsoutb) begin
		if(~sysrsoutb) cpu_reg_write <= 1'b0;
		else cpu_reg_write <= reg_cpuwr_start;
	end

	assign ice_reg_res1 = ~sysrsoutb | ice_reg_write;

	always @(negedge icewr or posedge ice_reg_res1) begin
		if(ice_reg_res1) reg_icewr_start <= 1'b0;
		else if(hostreg_sel) reg_icewr_start <= 1'b1;
	end

	//----- IROM write timing signal -----
	always @(posedge ck60mhz or negedge sysrsoutb) begin
		if(~sysrsoutb) ice_reg_write <= 1'b0;
		else if(hostreg_sel) ice_reg_write <= reg_icewr_start;
	end

//------------------------------------------------------------------------------------------------//
// EROM WRITE REGISTOR Write Timing Signal                                                        //
//------------------------------------------------------------------------------------------------//

	always @(negedge baseck or negedge sysrsoutb ) begin
		if(~sysrsoutb)begin
			rom_cs <= 1'b0;
			romwr_en <= 1'b0;
		end
		else begin
			rom_cs <= romcs;
			romwr_en <= romwren;
		end
	end

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
			17'h10000 : icedat_read = erradrl1;
			17'h10001 : icedat_read = {12'h000, erradrh1};
			17'h10002 : icedat_read = erradrl2;
			17'h10003 : icedat_read = {12'h000, erradrh2};
			17'h10004 : icedat_read = erradrl3;
			17'h10005 : icedat_read = {12'h000, erradrh3};
			17'h10006 : icedat_read = erradrl4;
			17'h10007 : icedat_read = {12'h000, erradrh4};
			17'h10008 : icedat_read = erradrl5;
			17'h10009 : icedat_read = {12'h000, erradrh5};
			17'h10010 : icedat_read = {9'h0, err_mode1};
			17'h10011 : icedat_read = {9'h0, err_mode2};
			17'h10012 : icedat_read = {9'h0, err_mode3};
			17'h10013 : icedat_read = {9'h0, err_mode4};
			17'h10014 : icedat_read = {9'h0, err_mode5};
			17'h10020 : icedat_read = errmskl1;
			17'h10021 : icedat_read = {12'h000, errmskh1};
			17'h10022 : icedat_read = errmskl2;
			17'h10023 : icedat_read = {12'h000, errmskh2};
			17'h10024 : icedat_read = errmskl3;
			17'h10025 : icedat_read = {12'h000, errmskh3};
			17'h10026 : icedat_read = errmskl4;
			17'h10027 : icedat_read = {12'h000, errmskh4};
			17'h10028 : icedat_read = errmskl5;
			17'h10029 : icedat_read = {12'h000, errmskh5};
			17'h10030 : icedat_read = err_count1;
			17'h10031 : icedat_read = err_count2;
			17'h10032 : icedat_read = err_count3;
			17'h10033 : icedat_read = err_count4;
			17'h10034 : icedat_read = err_count5;
			default : icedat_read = 16'h0000;
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
	// [ SS3rd Ver102 ] Unit3-5の追加と記述スタイルを変更。

	wire	sl_erradrl1 = (iceadr == 16'h0000);
	wire	sl_erradrh1 = (iceadr == 16'h0001);
	wire	sl_erradrl2 = (iceadr == 16'h0002);
	wire	sl_erradrh2 = (iceadr == 16'h0003);
	wire	sl_erradrl3 = (iceadr == 16'h0004);
	wire	sl_erradrh3 = (iceadr == 16'h0005);
	wire	sl_erradrl4 = (iceadr == 16'h0006);
	wire	sl_erradrh4 = (iceadr == 16'h0007);
	wire	sl_erradrl5 = (iceadr == 16'h0008);
	wire	sl_erradrh5 = (iceadr == 16'h0009);
	wire	sl_err_mode1 = (iceadr == 16'h0010);
	wire	sl_err_mode2 = (iceadr == 16'h0011);
	wire	sl_err_mode3 = (iceadr == 16'h0012);
	wire	sl_err_mode4 = (iceadr == 16'h0013);
	wire	sl_err_mode5 = (iceadr == 16'h0014);
	wire	sl_errmskl1 = (iceadr == 16'h0020);
	wire	sl_errmskh1 = (iceadr == 16'h0021);
	wire	sl_errmskl2 = (iceadr == 16'h0022);
	wire	sl_errmskh2 = (iceadr == 16'h0023);
	wire	sl_errmskl3 = (iceadr == 16'h0024);
	wire	sl_errmskh3 = (iceadr == 16'h0025);
	wire	sl_errmskl4 = (iceadr == 16'h0026);
	wire	sl_errmskh4 = (iceadr == 16'h0027);
	wire	sl_errmskl5 = (iceadr == 16'h0028);
	wire	sl_errmskh5 = (iceadr == 16'h0029);
	wire	sl_err_count1 = (iceadr == 16'h0030);
	wire	sl_err_count2 = (iceadr == 16'h0031);
	wire	sl_err_count3 = (iceadr == 16'h0032);
	wire	sl_err_count4 = (iceadr == 16'h0033);
	wire	sl_err_count5 = (iceadr == 16'h0034);

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
			if(~sysrsoutb) err_mode1 <= 9'h000;
			else if(icesfr_wr & sl_err_mode1) err_mode1 <= icedat[6:0];
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
			if(~sysrsoutb) err_mode2 <= 9'h000;
			else if(icesfr_wr & sl_err_mode2) err_mode2 <= icedat[6:0];
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

	// #3 [ SS3rd Ver102 ] Added
	
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrl3 <= 16'h0000;
			else if(icesfr_wr & sl_erradrl3) erradrl3 <= icedat;
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrh3 <= 4'h0;
			else if(icesfr_wr & sl_erradrh3) erradrh3 <= icedat[3:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_mode3 <= 9'h000;
			else if(icesfr_wr & sl_err_mode3) err_mode3 <= icedat[6:0];
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

	// #4 [ SS3rd Ver102 ] Added
	
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrl4 <= 16'h0000;
			else if(icesfr_wr & sl_erradrl4) erradrl4 <= icedat;
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrh4 <= 4'h0;
			else if(icesfr_wr & sl_erradrh4) erradrh4 <= icedat[3:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_mode4 <= 9'h000;
			else if(icesfr_wr & sl_err_mode4) err_mode4 <= icedat[6:0];
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

	// #5 [ SS3rd Ver102 ] Added
	
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrl5 <= 16'h0000;
			else if(icesfr_wr & sl_erradrl5) erradrl5 <= icedat;
		end
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) erradrh5 <= 4'h0;
			else if(icesfr_wr & sl_erradrh5) erradrh5 <= icedat[3:0];
		end
		
		always @(posedge baseck or negedge sysrsoutb)begin
			if(~sysrsoutb) err_mode5 <= 9'h000;
			else if(icesfr_wr & sl_err_mode5) err_mode5 <= icedat[6:0];
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
	

	wire iceflerr_out1;
	ERR_CMP err_cmp1 (
		.erradrl(erradrl1), .erradrh(erradrh1),
		.errmskl({errmskl1[15:2],2'b11}), .errmskh(errmskh1),
		.err_mode(err_mode1), .err_count(err_count1),
		.mrg00_dbg(mrg00_dbg), .mrg01_dbg(mrg01_dbg), .mrg10_dbg(mrg10_dbg),
		.mrg11_dbg(mrg11_dbg), .mrg12_dbg(mrg12_dbg), .read_dbg(read_dbg),
		.slbmem(slbmem), .exch(exch), .swap(swap), .clksel1(clksel1), .rdclkp1(rdclkp1),
		.cpu_adr({cpu_adr,2'b00}),
		.baseck(baseck), .cpuresetb(cpuresetb), .iceflerr_out(iceflerr_out1)
	);
	
	wire iceflerr_out2;
	ERR_CMP err_cmp2 (
		.erradrl(erradrl2), .erradrh(erradrh2),
		.errmskl({errmskl2[15:2],2'b11}), .errmskh(errmskh2),
		.err_mode(err_mode2), .err_count(err_count2),
		.mrg00_dbg(mrg00_dbg), .mrg01_dbg(mrg01_dbg), .mrg10_dbg(mrg10_dbg),
		.mrg11_dbg(mrg11_dbg), .mrg12_dbg(mrg12_dbg), .read_dbg(read_dbg),
		.slbmem(slbmem), .exch(exch), .swap(swap), .clksel1(clksel1), .rdclkp1(rdclkp1),
		.cpu_adr({cpu_adr,2'b00}),
		.baseck(baseck), .cpuresetb(cpuresetb), .iceflerr_out(iceflerr_out2)
	);

	// [ SS3rd Ver102 ] Added
	wire iceflerr_out3;
	ERR_CMP err_cmp3 (
		.erradrl(erradrl3), .erradrh(erradrh3),
		.errmskl({errmskl3[15:2],2'b11}), .errmskh(errmskh3),
		.err_mode(err_mode3), .err_count(err_count3),
		.mrg00_dbg(mrg00_dbg), .mrg01_dbg(mrg01_dbg), .mrg10_dbg(mrg10_dbg),
		.mrg11_dbg(mrg11_dbg), .mrg12_dbg(mrg12_dbg), .read_dbg(read_dbg),
		.slbmem(slbmem), .exch(exch), .swap(swap), .clksel1(clksel1), .rdclkp1(rdclkp1),
		.cpu_adr({cpu_adr,2'b00}),
		.baseck(baseck), .cpuresetb(cpuresetb), .iceflerr_out(iceflerr_out3)
	);

	// [ SS3rd Ver102 ] Added
	wire iceflerr_out4;
	ERR_CMP err_cmp4 (
		.erradrl(erradrl4), .erradrh(erradrh4),
		.errmskl({errmskl4[15:2],2'b11}), .errmskh(errmskh4),
		.err_mode(err_mode4), .err_count(err_count4),
		.mrg00_dbg(mrg00_dbg), .mrg01_dbg(mrg01_dbg), .mrg10_dbg(mrg10_dbg),
		.mrg11_dbg(mrg11_dbg), .mrg12_dbg(mrg12_dbg), .read_dbg(read_dbg),
		.slbmem(slbmem), .exch(exch), .swap(swap), .clksel1(clksel1), .rdclkp1(rdclkp1),
		.cpu_adr({cpu_adr,2'b00}),
		.baseck(baseck), .cpuresetb(cpuresetb), .iceflerr_out(iceflerr_out4)
	);

	// [ SS3rd Ver102 ] Added
	wire iceflerr_out5;
	ERR_CMP err_cmp5 (
		.erradrl(erradrl5), .erradrh(erradrh5),
		.errmskl({errmskl5[15:2],2'b11}), .errmskh(errmskh5),
		.err_mode(err_mode5), .err_count(err_count5),
		.mrg00_dbg(mrg00_dbg), .mrg01_dbg(mrg01_dbg), .mrg10_dbg(mrg10_dbg),
		.mrg11_dbg(mrg11_dbg), .mrg12_dbg(mrg12_dbg), .read_dbg(read_dbg),
		.slbmem(slbmem), .exch(exch), .swap(swap), .clksel1(clksel1), .rdclkp1(rdclkp1),
		.cpu_adr({cpu_adr,2'b00}),
		.baseck(baseck), .cpuresetb(cpuresetb), .iceflerr_out(iceflerr_out5)
	);

	assign iceflerr_out = iceflerr_out1 | iceflerr_out2 | iceflerr_out3 | iceflerr_out4 | iceflerr_out5;

endmodule

//後のセルフのエラーエミュレーション用にエラー発生回路をモジュール化
//2006.10.5 taketoshi.ide@necel
//------------------------------------------------------------------------------------------------//
// ICEFLERR Address Compare Module                                                                //
//------------------------------------------------------------------------------------------------//
// OutPut Signal = iceflerr_out                                                                   //
//------------------------------------------------------------------------------------------------//
// Internal Make Signal
// erradr_cmp   :エラーアドレスのコンペア結果フラグ
// iceflerr_res :エラー発生回路のリセット(比較結果が不一致とシステムリセット時にリセット)
// iceflerr_out :エラー出力
// mrg01_11_12_state :
// erradr_mrg01_11_12_check :
// extra_cmp_buff :
// mrg01_resb :
// mrg01_l :
// exa_swap_bit :
// read_mode_err :
//------------------------------------------------------------------------------------------------//
// [ SS3rd Ver102 ]										  //
// DataFlashの実装によりEEPROM Emulationが無くなったため,flwwr,eepromのError Mask機能を削除した。 //
// [ SS3rd Ver103 ]                                                                               //
// Data Flashとmoduleを共用するため、(Data Flashはデータ8bitでアドレス下位2bitをCareするので)	  //
// cpu_adrを17-0->19:0とした。EMEM(Code Flash)ではmodule呼び出し側で下位2bitを追加する。また下位  //
// 2bitを無視するように、errmsklの下位2bitを1に差し替えて渡す。					  //
// [SS3rd Ver1014]                                                                                //
//  - BootSwapに対応(swap信号入力を追加)                                                          //
//  - errmskhレジスタ 3bit -> 4bit                                                                //
//------------------------------------------------------------------------------------------------//
module ERR_CMP ( erradrl, erradrh, errmskl, errmskh, err_mode, err_count,
				mrg00_dbg, mrg01_dbg, mrg10_dbg, mrg11_dbg, mrg12_dbg, read_dbg,
				slbmem, exch, swap, clksel1, rdclkp1, cpu_adr,
				baseck, cpuresetb, iceflerr_out);
	input [15:0] erradrl, errmskl;
	input [3:0] erradrh;
	input [3:0] errmskh;
	input [6:0] err_mode;
	input [7:0] err_count;
	input mrg00_dbg, mrg01_dbg, mrg10_dbg, mrg11_dbg, mrg12_dbg, read_dbg;
	input slbmem, exch, swap, clksel1, rdclkp1;
	input [19:0] cpu_adr;
	input baseck, cpuresetb;
	output iceflerr_out;

	//----- ICEFLERR Address CMP Signal -----//
	wire mrg01_11_12_err;
	wire erradr_cmp;

	wire iceflerr_res;
	wire mrg00_err;
	wire mrg01_err;
	wire mrg10_err;
	wire mrg11_err;
	wire mrg12_err;
	wire read_err;
	wire exa_err;

	reg  mrg01_11_12_state;
	wire mrg01_resb;
	reg mrg01_l;

	assign {exa_err, read_err, mrg12_err, mrg11_err, mrg10_err, mrg01_err, mrg00_err} = err_mode;

	//内部ベリファイ発生条件の場合を示すステータス信号生成
	assign mrg01_11_12_err = mrg01_err & (mrg11_err | mrg12_err);

	//エラーを発生させるモードの検出回路(エラー発生ONフラグ)
	wire read_mode_err = (mrg01_11_12_state) ? (
		mrg01_11_12_err
	) : (
		(read_err & read_dbg) |
		(mrg00_err & mrg00_dbg) |
		(mrg10_err & mrg10_dbg) |
		(~mrg01_err & mrg11_err & mrg11_dbg) |
		(~mrg01_err & mrg12_err & mrg12_dbg)
	);

	//リセットのヒゲ対策
	//内部ベリファイアクセス検出回路(下記の回路)のリセット条件でMRG01をそのまま使うと
	//MRG01からMRG11/MRG12に切り替わるところでヒゲが乗る(リセットされてしまう)ためMRG01をシフトさせて使用
	always @(posedge baseck or negedge cpuresetb )begin
		if(~cpuresetb) mrg01_l <= 1'b0;
		else if(slbmem) mrg01_l <= mrg01_dbg;
	end

	//内部ベリファイでエラーを発生させる場合のアクセスシーケンス検出回路(MRG01アクセスを検出する)
	//MRG01アクセス後MRG11かMRG12でなければアクセス検出結果をリセット
	//MRG01アクセス後MRG11かMRG12であればアクセス検出結果を保持
	assign mrg01_resb = (mrg01_l | mrg11_dbg | mrg12_dbg) & cpuresetb;
	always @(posedge baseck or negedge mrg01_resb)begin
		if(~mrg01_resb) mrg01_11_12_state <= 1'b0;
		else if(mrg01_dbg) mrg01_11_12_state <= 1'b1;
	end

	//Extraスワップ時にエラー発生をExtraアクセスで起こす場合アドレス比較用レジスタのスワップビットをスワップさせる
        //デバイス仕様
        //    800H-     : セクタ2
        //    400H-7FFH : セクタ1
        //    000H-3FFH : セクタ0
        //  exch=1でセクタ0とセクタ1がスワップする。
        //  cpu_adr は FExxxHで来る。
	//比較アドレス生成 [SS3rd Ver106][SS3rd Ver1015][SS3rd Ver1016]
        wire sector0or1 = ~erradrl[11];
	wire [19:0] extra_cmp_buff_adr = (exch & sector0or1) ? {8'hFE, erradrl[11], ~erradrl[10], erradrl[9:0]} : {8'hFE, erradrl[11:0]};
	wire [19:0] extra_cmp_buff_msk = {8'h00, errmskl[11:0]};

	//ブートスワップ中にエラーを発生させる場合の比較アドレス生成 [SS3rd Ver1014]
	wire [15:0] erradrl_btswp = swap ? {erradrl[15:13], ~erradrl[12], erradrl[11:0]} : erradrl[15:0];

	//エラー発生アドレスとの比較回路
	assign erradr_cmp = (exa_err & ~clksel1) ? (
		read_mode_err & ((extra_cmp_buff_adr | extra_cmp_buff_msk) == (cpu_adr | extra_cmp_buff_msk))
	) : (
		~clksel1 & read_mode_err & (({erradrh, erradrl_btswp[15:0]} | {errmskh, errmskl[15:0]}) == (cpu_adr | {errmskh, errmskl[15:0]}))
	);                                                 // ^^^^^^[SS3rd Ver1014]
	
	// Counter
	
		wire noretry = (err_count == 8'h00);
		
		reg rdclkp1_l;
		always @(posedge baseck or negedge cpuresetb)begin
			if (~cpuresetb) begin
				rdclkp1_l <= 1'b0;
			end else begin
				rdclkp1_l <= rdclkp1;
			end
		end
		wire rdclkp1_neg = ~rdclkp1 & rdclkp1_l;
		wire rdclkp1_pos = rdclkp1 & ~rdclkp1_l;
		reg rdclkp1_pos_flag;
		always @(posedge baseck or negedge cpuresetb)begin
			if(~cpuresetb)begin
				rdclkp1_pos_flag <= 1'b0;
			end
			else if(~(mrg00_dbg | mrg10_dbg) | rdclkp1_neg)begin
				rdclkp1_pos_flag <= 1'b0;
			end
			else if(rdclkp1_pos)begin
				rdclkp1_pos_flag <= 1'b1;
			end
		end
		
		wire count_stb = ~noretry & (mrg00_dbg | mrg10_dbg) & rdclkp1_neg & rdclkp1_pos_flag;
		
		reg initial_state;
		reg [7:0] counter;
		reg [17:0] count_target_adr;
		wire count_full = (counter == err_count);
		wire new_count_target = (initial_state | count_full) & erradr_cmp;
		wire count_target = ~initial_state & (cpu_adr == count_target_adr);
		
		always @(posedge baseck or negedge cpuresetb)begin
			if (~cpuresetb) begin
				initial_state <= 1'b1; // リセット直後の状態
				count_target_adr <= 18'h00000;
			end else begin
				if (count_stb & new_count_target) begin // カウント1回目のアクセス
					initial_state <= 1'b0;
					count_target_adr <= cpu_adr;
				end
			end
		end
		
		always @(posedge baseck or negedge cpuresetb)begin
			if (~cpuresetb) begin
				counter <= 8'h00;
			end else begin
				if (count_stb) begin
					if (new_count_target) begin // カウント1回目のアクセス
						counter <= 8'h00;
					end else begin
						if (count_target) begin
							counter <= counter + 1; // カウント2回目以降
						end
					end
				end
			end
		end
	
	//エラー出力
	//エラー発生タイミング同期回路(比較結果が一致時のみアクティブ、それ以外はLow出力)
	//FlashMemoryはRDCLKP1の立下りでデータを出力してくるのでエラーも立下り同期で発生
	//↑としたかったが、BASECK同期の回路に修正したためアドレス一致でエラー出力
	//タイミングネックになることを避けるためBASECKで一度切断
	reg iceflerr_out;
	always @(posedge baseck or negedge cpuresetb)begin
		if (~cpuresetb) begin
			iceflerr_out <= 1'b0;
		end else begin
			iceflerr_out <= erradr_cmp & (noretry | (count_target & ~count_full));
		end
	end

endmodule

//------------------------------------------------------------------------------------------------//
// DELAY Circuit                                                                                  //
//------------------------------------------------------------------------------------------------//
//----- SYSTEMRESET Level Low module -----//
module EMEM_DLY5NS_L (dmy1, dmy2, sysrsoutb, in, out);
	input	dmy1, dmy2, sysrsoutb, in;
	output	out;

	reg	[3:0]	dly;
	reg		out;

	always @(sysrsoutb or dmy1 or in ) begin
		if (~sysrsoutb) dly[0] = 1'b0;
		else if (dmy1) dly[0] = in;
	end
	always @(sysrsoutb or dmy2 or dly[0]) begin
		if (~sysrsoutb) dly[1] = 1'b0;
		else if (dmy2) dly[1] = dly[0];
	end
	always @(sysrsoutb or dmy1 or dly[1]) begin
		if (~sysrsoutb) dly[2] = 1'b0;
		else if (dmy1) dly[2] = dly[1];
	end
	always @(sysrsoutb or dmy2 or dly[2]) begin
		if (~sysrsoutb) dly[3] = 1'b0;
		else if (dmy2) dly[3] = dly[2];
	end
	always @(sysrsoutb or dmy1 or dly[3]) begin
		if (~sysrsoutb) out = 1'b0;
		else if (dmy1) out = dly[3];
	end

endmodule

//----- SYSTEMRESET Level Hi module -----//
module EMEM_DLY5NS_H (dmy1, dmy2, sysrsoutb, in, out);
	input	dmy1, dmy2, sysrsoutb, in;
	output	out;

	reg	[3:0]	dly;
	reg		out;

	always @(sysrsoutb or dmy1 or in ) begin
		if (~sysrsoutb) dly[0] = 1'b1;
		else if (dmy1) dly[0] = in;
	end
	always @(sysrsoutb or dmy2 or dly) begin
		if (~sysrsoutb) dly[1] = 1'b1;
		else if (dmy2) dly[1] = dly[0];
	end
	always @(sysrsoutb or dmy1 or dly) begin
		if (~sysrsoutb) dly[2] = 1'b1;
		else if (dmy1) dly[2] = dly[1];
	end
	always @(sysrsoutb or dmy2 or dly) begin
		if (~sysrsoutb) dly[3] = 1'b1;
		else if (dmy2) dly[3] = dly[2];
	end
	always @(sysrsoutb or dmy1 or dly) begin
		if (~sysrsoutb) out = 1'b1;
		else if (dmy1) out = dly[3];
	end

endmodule

//------------------------------------------------------------------------------------------------//
// Clock Selector                                                                                 //
//------------------------------------------------------------------------------------------------//
module CLKSEL (clkout, auto_change, clkin0, clkin1, selclk, cpuresetb, resetb);
	input  clkin0, clkin1, selclk, cpuresetb, resetb;
	output clkout, auto_change;

//	assign clkout = selclk ? clkin1 : clkin0;

	//----- Internal Signal -----//

	wire clkin0_gate;
	wire clkin1_gate;
	reg  cpureset_flag;
	reg  cpureset_st_pp;
	reg  cpureset_st_p;
	reg  cpureset_st;
	reg  cpureset_st_l;
	reg  low1_p, low1, clksel_resetb_p, clksel_resetb_st;
	wire clksel_resetb;
	reg  low0, clksel_p, clksel;

	wire auto_change;
	reg  clkin1_st, change;
	wire change_resetb;

	//----- clk select -----//
	always @(negedge clkin1 or negedge resetb )begin
		if(~resetb)begin
			low1_p <= 1'b0;
			low1 <= 1'b0;
		end
		else begin
			low1_p <= ~selclk;
			low1 <= low1_p;
		end
	end

	always @(negedge clkin0 or negedge resetb )begin
		if(~resetb)begin
			clksel_resetb_p <= 1'b0;
			clksel_resetb_st <= 1'b0;
		end
		else begin
			clksel_resetb_p <= ~low1;
			clksel_resetb_st <= clksel_resetb_p;
		end
	end

	always @(negedge clkin0 or negedge resetb )begin
		if(~resetb)begin
			low0 <= 1'b0;
		end
		else begin
			low0 <= selclk;
		end
	end

	assign clksel_resetb = (clksel_resetb_st | selclk) & resetb;

	always @(negedge clkin1 or negedge resetb )begin
		if(~resetb) clksel_p <= 1'b0;
		else clksel_p <= low0;
	end

	always @(negedge clkin1 or negedge clksel_resetb )begin
		if(~clksel_resetb) clksel <= 1'b0;
		else if(clksel_p) clksel <= 1'b1;
	end

	assign clkin0_gate = clkin0 & ~low0;
	assign clkin1_gate = clkin1 & ~low1;
	// [ SS3rd Ver105 ]
	assign clkout = (clksel | change) & cpuresetb ? clkin1_gate : clkin0_gate;

	//----- CPURESET AUTO CHANGE -----//
	always @(posedge clkin0 or negedge resetb)begin
		if(~resetb) cpureset_st_pp <= 1'b0;
		else cpureset_st_pp <= cpuresetb;
	end

	always @(posedge clkin0 or negedge resetb)begin
		if(~resetb) cpureset_st_p <= 1'b0;
		else cpureset_st_p <= cpureset_st_pp;
	end

	always @(posedge clkin0 or negedge resetb)begin
		if(~resetb) cpureset_st <= 1'b0;
		else cpureset_st <= cpureset_st_p;
	end

	always @(posedge clkin0 or negedge resetb)begin
		if(~resetb) cpureset_st_l <= 1'b0;
		else cpureset_st_l <= cpureset_st;
	end

	assign auto_change = cpureset_st & ~cpureset_st_l;

	assign change_resetb = resetb & ~clksel;
	always @(negedge clkin0 or negedge change_resetb)begin
		if(~change_resetb) change <= 1'b0;
		else if(auto_change) change <= 1'b1;
	end

endmodule

