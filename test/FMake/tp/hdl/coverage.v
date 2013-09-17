// coverage
// Ver1.0 New taketoshi.ide 2005/9/20
// Ver1.1 t.uemura 2006/08/18
// Ver1.2 t.uemura 2009/01/23 EXMEM_WDOP_RD_COVERAGE modified
// Ver1.3 t.uemura 2010/05/19 RAM->FLASH,EXMEM->FLASH,BRAM-BAF,RAM->BFA
//                            のBR命令による分岐でリードしていない領域に
//　　　　　　　　　　　　　　リードカバッレジが乗るのを修正。
//$Id: coverage.v,v 1.23 2010/05/31 07:30:24 t-uemura Exp $

module COVERAGE (
	PA17, PA16,
	PA15, PA14, PA13, PA12, PA11, PA10, PA9, PA8,
	PA7, PA6, PA5, PA4, PA3, PA2, PA1, PA0,
	PC19, PC18, PC17, PC16,
	PC15, PC14, PC13, PC12, PC11, PC10, PC9, PC8,
	PC7, PC6, PC5, PC4, PC3, PC2, PC1, PC0,
	MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8,
	MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0,
	ES3, ES2, ES1, ES0,
	FLREAD, FLREADB3, FLREADB2, FLREADB1, FLREADB0,
	SVMOD, SELFMODEDBG, SKIPEXE, CPUMASK,
	PCWAITF, STAGEADR0, STAGEADR1, WAITEXM,
	SLEXM, FCHRAM,
	WDOP, CPUWR, CPURD,
	INTACK, DMAACK,
	CPURESETB, BASECK,
	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
	ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0,
	ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
	ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
	ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
	ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0,
	ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
	ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
	ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
	ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0,
	ICEWR, ICERD, CK60MHZ, SYSRSOUTB,
	SELEXMPC, SELRAMPC, SELROMPC, SELBRAMPC, SELBFAPC
);

	input	PA17, PA16,
			PA15, PA14, PA13, PA12, PA11, PA10, PA9, PA8,
			PA7, PA6, PA5, PA4, PA3, PA2, PA1, PA0,
			PC19, PC18, PC17, PC16,
			PC15, PC14, PC13, PC12, PC11, PC10, PC9, PC8,
			PC7, PC6, PC5, PC4, PC3, PC2, PC1, PC0,
			MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8,
			MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0,
			ES3, ES2, ES1, ES0,
			FLREAD, FLREADB3, FLREADB2, FLREADB1, FLREADB0,
			SVMOD, SELFMODEDBG, SKIPEXE, CPUMASK,
			PCWAITF, STAGEADR0, STAGEADR1, WAITEXM,
			SLEXM, FCHRAM,
			WDOP, CPUWR, CPURD,
			INTACK, DMAACK,
			CPURESETB, BASECK;
	input	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
			ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0,
			ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
			ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
			ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
			ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0;
	output	ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
			ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
			ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
			ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0;
	input	ICEWR, ICERD, CK60MHZ, SYSRSOUTB;

input	SELEXMPC;				// PC == External Area			( <- failsafe )
input	SELRAMPC;				// PC == RAM Area			( <- failsafe )
input	SELROMPC;				// PC == Flash Area			( <- failsafe )
input	SELBRAMPC;				// PC == BRAM Area			( <- failsafe )
input	SELBFAPC;				// PC == BFA Area			( <- failsafe )

//***************************************************************************************
//* wire and reg 宣言
//***************************************************************************************
	wire	[19:0]	pc;
	wire	[17:0]	pa;
	wire	[15:0]	ma;
	wire	[31:0]	iceifa, icedi, icedo;

	//HOST Read Data Bus
	wire	[31:0]	icedo_fch;	//HOST Read Data of Fetch Memory 
	wire	[3:0]	icedo_rd;	//HOST Read Data of Read Memory 
	wire	[3:0]	icedo_wr;	//HOST Read Data of Write Memory 
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	[31:0]	icedo_romrd;	//HOST Read Data of ROM Read Memory 
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//User RAM HOST READ Coverage Data
	reg		[1:0]	icedo_user_ram_rwcov;

	//HOST Coverage Memory Write Data
	reg		[31:0]	icedi_reg;
	wire	[31:0]	icedi_fch;	//HOST Write Data of Fetch Memory
	wire	[3:0]	icedi_rd;	//HOST Write Data of Read Memory
	wire	[3:0]	icedi_wr;	//HOST Write Data of Write Memory
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	[31:0]	icedi_romrd;	//HOST Write Data of ROM Read Memory
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//HOST Coverage Memory Clear Data :植村コメント追加	
	wire	[31:0]	icedi_fclr;
	wire	[3:0]	icedi_rclr;
	wire	[3:0]	icedi_wclr;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	[31:0]	icedi_romrdclr;	//HOST Clear Data of ROM Read Memory
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	//Emulation Registor Data set Registor
	reg		[31:0]	icedo_reg;

	//Coverage CPU Address
	wire	[19:0]	fcov_cpu_ad;
	wire	[15:0]	rcov_cpu_ad;
	wire	[15:0]	wcov_cpu_ad;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	[19:0]	romrdcov_cpu_ad;	//CPU Adress of ROM Read Coverage
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//Coverage HOST Address
	wire	[14:0]	fcov_ice_ad;
	wire	[13:0]	rcov_ice_ad;
	wire	[13:0]	wcov_ice_ad;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	[14:0]	romrdcov_ice_ad;	//HOST Adress of ROM Read Coverage
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


	//FLASH(ROM) Read byte Address
	reg		[1:0]	flread_ad;

	//ROM Read word Accsess
	reg		flread_word_pre;
	wire	flread_word;

	//Coverage Memory HOST Area Select Signal
	wire	fcov_mem_area;		//Fetch Coverage Area Select Signal
	wire	rcov_mem_area;		//Read Coverage Area Select Signal
	wire	wcov_mem_area;		//Write Coverage Area Select Signal
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	romrdcov_mem_area;		// ROM Read Coverage Area Select Signal
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//Coverage Byte Clear HOST Area Select Signal
	wire	fcov_bclr_area;		//Fetch Coverage Byte Clear Registor Area Select Signal
	wire	rcov_bclr_area;		//Read Coverage Byte Clear Registor Area Select Signal
	wire	wcov_bclr_area;		//Write Coverage Byte Clear Registor Area Select Signal
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	romrdcov_bclr_area;		//ROM Read Coverage Byte Clear Registor Area Select Signal
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//User RAM HOST Area Select Signal
	wire	user_ram_area;
	wire		gen_reg_area;

	//User RAM HOST Read Byte Select Signal
	reg		user_ram3, user_ram2, user_ram1, user_ram0;

	//FETCH, READ, WRITE,   FLASH_READ   Coverage Enable Signal
	wire	enc_fch_mem;		//IROM IRAM FETCH Enable
	wire	enc_rd_rom;			//(IROM)  FLASH READ Enable
	wire	enc_rd_mem;			//IRAM SFR 2ndSFR READ Enable
	wire	enc_wr_mem;			//IRAM SFR 2ndSFR WRITE Enable
	wire	enc_fch;			//Fetch Coverage Memory Enable
	wire	enc_rd_exm;         //EXMEM
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	enc_romrd;			// FLASH(EXMEM) READ coverage Enable
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	wire	pc_mask;
	reg 	pcwaitf_l;
	wire	exma_flag;

	//Coverage Data Write Enable Signal
	wire	we_fch;			//IROM IRAM FETCH Write Enable
	wire	we_rd;			//IRAM SFR 2ndSFR READ Write Enable
	wire	we_wr;			//IRAM SFR 2ndSFR WRITE Write Enable
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	we_romrd;			// FLASH(EXMEM) READ Write Enable
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//HOST Coverage Enable Signal
	wire	eni_fch;			//HOST Area Fetch Coverage Memory Enable
	wire	eni_rd;				//HOST Area Read Coverage Memory Enable
	wire	eni_wr;				//HOST Area Write Coverage Memory Enable
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	eni_romrd;			//HOST Area FLASH(EXMEを含む) Read Coverage Memory Enable
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//HOST Area Write Enable Signal
	wire	[31:0]	we_fch_ice;			//HOST Area Fetch Coverage Memory Write Enable
	wire	[3:0]	we_rd_ice;			//HOST Area Read Coverage Memory Write Enable
	wire	[3:0]	we_wr_ice;			//HOST Area Write Coverage Memory Write Enable
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	[31:0]	we_romrd_ice;			//HOST Area ROM Read Coverage Memory Write Enable
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//レジスタ空間選択信号
	wire	cov_reg_area;
	wire	ice_area_covcnt;
	wire	ice_area_fcovclr;
	wire	ice_area_rcovclr;
	wire	ice_area_wcovclr;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	ice_area_romrdcovclr;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//covon レジスタ
	reg 	wcovon, rcovon, fcovon;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	reg	    romrdcovon;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	reg	[31:0]	fclr;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	reg	[31:0]	romrdclr;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	reg	[3:0]	rclr, wclr;

	//Clear Timing Signal
	wire	[31:0]	ice_fclr;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	wire	[31:0]	ice_romrdclr;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	wire	[3:0]	ice_rclr;
	wire	[3:0]	ice_wclr;

	//HOST Write Timing Signal
	wire	res1;
	reg 	ice_wr_start;
	reg 	ice_write;
	wire	cov_host_area;

	//HOST Read Timing Signal
	wire	read_res1;
	reg 	ice_rd_start;
	reg 	ice_read;

	//INT Vector Access Flag
	reg 	int_flag0, int_flag1;

	//DMA Access Flag
	reg 	dma_flag0, dma_flag1;
	wire	dma_flag;

	//EXM Access Flag
	reg 	slexm_shift_pre;
	wire	slexm_shift;
	reg 	fchram_shift;


//***************************************************************************************
//*Address and Data Bus作成
//***************************************************************************************
	assign pc = { PC19, PC18, PC17, PC16, PC15, PC14, PC13, PC12, PC11, PC10,
					PC9, PC8, PC7, PC6, PC5, PC4, PC3, PC2, PC1, PC0};

	assign pa = { PA17, PA16, PA15, PA14, PA13, PA12, PA11, PA10,
					PA9, PA8, PA7, PA6, PA5, PA4, PA3, PA2, PA1, PA0};

	assign ma = {MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8, MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0};

	assign iceifa = {ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
			ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0};

	assign icedi =	{ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
			ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
			ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
			ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0};

	assign {ICEDO31, ICEDO30, ICEDO29, ICEDO28, ICEDO27, ICEDO26, ICEDO25, ICEDO24,
			ICEDO23, ICEDO22, ICEDO21, ICEDO20, ICEDO19, ICEDO18, ICEDO17, ICEDO16,
			ICEDO15, ICEDO14, ICEDO13, ICEDO12, ICEDO11, ICEDO10, ICEDO9, ICEDO8,
			ICEDO7, ICEDO6, ICEDO5, ICEDO4, ICEDO3, ICEDO2, ICEDO1, ICEDO0}
			= (cov_reg_area) ? icedo_reg : icedo;

	assign	icedo = (fcov_mem_area) ? icedo_fch :
					(rcov_mem_area) ? {7'b0, icedo_rd[3], 7'b0, icedo_rd[2], 7'b0, icedo_rd[1], 7'b0, icedo_rd[0]} :
					(wcov_mem_area) ? {7'b0, icedo_wr[3], 7'b0, icedo_wr[2], 7'b0, icedo_wr[1], 7'b0, icedo_wr[0]} :
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	//下記で汎用レジスタのリードの時はカバレッジデータのicedo_user_ram_rwcovを乗せないようにする2006.10.18
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
					(user_ram_area && !gen_reg_area) ? {icedo_user_ram_rwcov, 2'b00, 28'h000_0000} : //汎用レジスタ以外のRAMエリア
	//				(user_ram_area &&  gen_reg_area) ? {4'b0000, 28'h000_0000} : //汎用レジスタのエリア
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
					(romrdcov_mem_area) ? {icedo_romrd} : 32'h0000_0000;
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//*************************************************************************************************
//*エミュレーションレジスタ 　　(アレンジ)
//*************************************************************************************************
	assign	cov_reg_area = !ICEIFA31 & !ICEIFA30 & !ICEIFA29 & !ICEIFA28 &     //082x_
							ICEIFA27 & !ICEIFA26 & !ICEIFA25 & !ICEIFA24 &
							!ICEIFA23 & !ICEIFA22 & ICEIFA21 & !ICEIFA20;

	always @(cov_reg_area or iceifa[4:2] or wcovon or rcovon or fcovon or romrdcovon or fclr or rclr or wclr or romrdclr)begin
		casex({cov_reg_area, iceifa[4:2]})
			4'b1000 : icedo_reg = {28'b0, romrdcovon, wcovon, rcovon, fcovon};                    //0820_0000 
			4'b1001 : icedo_reg = fclr;                                                         //0820_0004
			4'b1010 : icedo_reg = {7'b0, rclr[3], 7'b0, rclr[2], 7'b0, rclr[1], 7'b0, rclr[0]}; //0820_0008
			4'b1011 : icedo_reg = {7'b0, wclr[3], 7'b0, wclr[2], 7'b0, wclr[1], 7'b0, wclr[0]}; //0820_000C
			4'b1100 : icedo_reg = romrdclr;                                                       //0820_0010
			default : icedo_reg = 32'h0000_0000;
		endcase
	end

	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//*************************************************************************************************
//*カバレッジのON/OFFレジスタ
//*************************************************************************************************
//*REGISTOR NAME : COVCNT
//*HOST ADDRESS : 0820_0000H
//*************************************************************************************************

	assign	ice_area_covcnt = cov_reg_area & !ICEIFA4 & !ICEIFA3 & !ICEIFA2;

	always @(negedge ICEWR or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB) begin
			wcovon <= 1'b0;
			rcovon <= 1'b0;
			fcovon <= 1'b0;
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
			romrdcovon <= 1'b0;
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
		end
		else if (ice_area_covcnt) begin
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
			romrdcovon <= icedi[3];
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
			wcovon <= icedi[2];
			rcovon <= icedi[1];
			fcovon <= icedi[0];
		end
	end

//*************************************************************************************************
//*カバレッジのクリア選択レジスタ
//*************************************************************************************************
//*REGISTOR NAME : FCOVCLR  HOST ADDRESS : 0820_0004H
//*REGISTOR NAME : RCOVCLR  HOST ADDRESS : 0820_0008H
//*REGISTOR NAME : WCOVCLR  HOST ADDRESS : 0820_000CH
//*************************************************************************************************
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//*REGISTOR NAME : romrdCOVCLR  HOST ADDRESS : 0820_0010H
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	assign	ice_area_fcovclr = cov_reg_area & !ICEIFA4 & !ICEIFA3 & ICEIFA2;
	assign	ice_area_rcovclr = cov_reg_area & !ICEIFA4 & ICEIFA3 & !ICEIFA2;
	assign	ice_area_wcovclr = cov_reg_area & !ICEIFA4 & ICEIFA3 & ICEIFA2;
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	assign	ice_area_romrdcovclr = cov_reg_area & ICEIFA4 & !ICEIFA3 & !ICEIFA2;
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	always @(negedge ICEWR or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB) fclr <= 32'h0000_0000;
		else if (ice_area_fcovclr) fclr <= icedi;
	end

	always @(negedge ICEWR or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB) rclr <= 4'h0;
		else if (ice_area_rcovclr) begin
			rclr[3] <= icedi[24];
			rclr[2] <= icedi[16];
			rclr[1] <= icedi[8];
			rclr[0] <= icedi[0];
		end
	end

	always @(negedge ICEWR or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB) wclr <= 4'h0;
		else if (ice_area_wcovclr) begin
			wclr[3] <= icedi[24];
			wclr[2] <= icedi[16];
			wclr[1] <= icedi[8];
			wclr[0] <= icedi[0];
		end
	end

	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	always @(negedge ICEWR or negedge SYSRSOUTB) begin
		if (!SYSRSOUTB) romrdclr <= 32'h0000_0000;	//システムリセットで初期値0
		else if (ice_area_romrdcovclr) romrdclr <= icedi;  //icediw
	end
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


//*************************************************************************************************
//*RAMへの真のアクセスステータス信号(PCWAITFのラッチ)
//*************************************************************************************************
	always @(posedge BASECK or negedge CPURESETB)begin
		if(!CPURESETB) pcwaitf_l <= 1'b0;
		else pcwaitf_l <= PCWAITF;
	end
//*************************************************************************************************
//*EXMA信号のメモリ空間選択フラグ
//*************************************************************************************************
	assign exma_flag = ES3 & ES2 & ES1 & ES0;

//*************************************************************************************************
//*DMAアクセスステータス信号
//*************************************************************************************************
	always @(posedge BASECK or negedge CPURESETB)begin
		if(!CPURESETB) begin
			dma_flag0 <= 1'b0;
			dma_flag1 <= 1'b0;
		end
		else begin
			dma_flag0 <= DMAACK;
			dma_flag1 <= dma_flag0;
		end
	end

	assign dma_flag = !DMAACK & (dma_flag0 | dma_flag1);//DMAACKを1クロック遅らせて、High幅を1クロック伸ばす。

//*************************************************************************************************
//*INTベクタテーブルアクセスステータス信号
//*************************************************************************************************
	always @(posedge BASECK or negedge CPURESETB)begin
		if(!CPURESETB) begin
			int_flag0 <= 1'b0;
			int_flag1 <= 1'b0;
		end
		else begin
			int_flag0 <= INTACK;
			int_flag1 <= int_flag0;
		end
	end

//*************************************************************************************************
//*EXMアクセスステータス信号
//*************************************************************************************************

	//外部メモリリード用のSLEXMラッチ
	always @(posedge BASECK or negedge CPURESETB)begin
		if(!CPURESETB) slexm_shift_pre <= 1'b0;
		else slexm_shift_pre <= SLEXM;
	end

	//外部フェッチからROMフェッチに戻るときの外部リードイネーブルのマスク用
	always @(posedge BASECK or negedge CPURESETB)begin
		if(!CPURESETB) fchram_shift <= 1'b0;
		else fchram_shift <= FCHRAM;
	end

	//外部メモリリードイネーブル信号
	assign slexm_shift = slexm_shift_pre & !fchram_shift;

//*************************************************************************************************
//*CPUアクセス制御　フェッチ系
//*************************************************************************************************

	//PC MASK Signal
	assign pc_mask = PCWAITF | STAGEADR0 | STAGEADR1 | INTACK | WAITEXM | SKIPEXE | dma_flag;

	//Fetch Memory Enable
	assign	enc_fch_mem = (!pc_mask | int_flag1) & CPURESETB & !SVMOD & !SELFMODEDBG & fcovon;

	//Flash Read Enable
	assign	enc_rd_rom = CPURESETB & !SVMOD & FLREAD & PCWAITF & !SELFMODEDBG & romrdcovon;
	//EXMEM Read Enable
	assign	enc_rd_exm = CPURESETB & !SVMOD & !FLREAD & !FCHRAM & CPURD & slexm_shift & !SELFMODEDBG & romrdcovon;


//\\\\\\\\\\\\\\\\\\\\\\\\ フラッシュフェッチ、フラッシュリード分解 植村変更　↓ \\\\\\\\\\\\\\\\\\\\\

	//Fetch Coverage Memory Enable
	assign	enc_fch = enc_fch_mem;

	//Fetch Coverage Memory Write Enable
	assign	we_fch = enc_fch;

	//Fetch Coverage Memory Address Select
	assign	fcov_cpu_ad = (enc_fch_mem) ? pc : (enc_rd_exm) ? {{ES3, ES2, ES1, ES0}, ma} :
							 (enc_rd_rom) ? {pa, flread_ad} : 20'h0_0000;
//\\\\\\\\\\\\\\\\\\\\\\\\ フラッシュフェッチ、フラッシュリード分解 植村挿入　↑ここまで \\\\\\\\\\\\\\\\\\\\\


	// [Ver1.3]
	// RAM,EXMEMからFlashにPCが遷移後の1clock(WAITEXM Act時は+Wait)を検出(mask_branch)
	// し,cpurdをMaskすることで不正なReadを検出しない構成とした.
	// BRAM(selbrampc),BFA(selbfapc)を条件に追加.
	reg selxxxpc_wait;
	always @( posedge BASECK or negedge SYSRSOUTB ) begin
		if (!SYSRSOUTB)   selxxxpc_wait <= 1'b0;
		else if (WAITEXM) selxxxpc_wait <= selxxxpc_wait;
		else              selxxxpc_wait <= (SELEXMPC | SELRAMPC | SELBRAMPC);
	end
	wire mask_branch = selxxxpc_wait & (SELROMPC | SELBFAPC);



//*************************************************************************************************
//*CPUアクセス制御　リード系
//*************************************************************************************************

	//RAM Read Coverage Memory Enable
	assign	enc_rd_mem = CPURD & (!CPUMASK & !FCHRAM & !INTACK & !WAITEXM & !pcwaitf_l & exma_flag | dma_flag) & !SVMOD & !FLREAD & !SELFMODEDBG & rcovon & !mask_branch;

	//RAM Read Coverage Memory Write Enable
	assign	we_rd = enc_rd_mem;

	//RAM Read Coverage Memory Address
	assign	rcov_cpu_ad = ma;
//\\\\\\\\\\\\\\\\\\\\\\\\ フラッシュフェッチ、フラッシュリード分解 植村変更　↓ \\\\\\\\\\\\\\\\\\\\\
	//FLASH(EXMEM) Read Coverage Memory Enable
	assign enc_romrd = enc_rd_rom | enc_rd_exm;

	//FLASH(EXMEM) Read Coverage Memory Write Enable
	assign we_romrd = enc_romrd;

	//FLASH(EXMEM) Read Coverage Memory Address Select
	assign	romrdcov_cpu_ad = (enc_rd_exm) ? {{ES3, ES2, ES1, ES0}, ma} :
				 (enc_rd_rom) ? {pa, flread_ad} : 20'h0_0000;

//\\\\\\\\\\\\\\\\\\\\\\\\ フラッシュフェッチ、フラッシュリード分解 植村挿入　↑ここまで \\\\\\\\\\\\\\\\\\\\\

//*************************************************************************************************
//*CPUアクセス制御　ライト系
//*************************************************************************************************

	//RAM Write Coverage Memory Enable
	assign	enc_wr_mem = CPUWR & (!CPUMASK & !FCHRAM & !WAITEXM & !pcwaitf_l & exma_flag | dma_flag) &
	                     !SVMOD & !FLREAD & !SELFMODEDBG & wcovon;

	//RAM Write Coverage Memory Write Enable
	assign	we_wr = enc_wr_mem;

	//RAM Write Coverage Memory Address
	assign	wcov_cpu_ad = ma;

//*************************************************************************************************
//*FLASH READ Byte Decord
//*************************************************************************************************
	always @(FLREAD or FLREADB3 or FLREADB2 or FLREADB1 or FLREADB0)begin
		casex({FLREAD, FLREADB3, FLREADB2, FLREADB1, FLREADB0})
			5'b0xxxx : flread_ad = 2'b00;
			5'b10001 : flread_ad = 2'b00;
			5'b10010 : flread_ad = 2'b01;
			5'b10100 : flread_ad = 2'b10;
			5'b11000 : flread_ad = 2'b11;
			5'b10011 : flread_ad = 2'b00;
			5'b11100 : flread_ad = 2'b10;
			default : flread_ad = 2'b00;
		endcase
	end

//*************************************************************************************************
//*FLASH READ Byte Decord
//*************************************************************************************************
	always @(FLREAD or FLREADB3 or FLREADB2 or FLREADB1 or FLREADB0)begin
		casex({FLREAD, FLREADB3, FLREADB2, FLREADB1, FLREADB0})
			5'b0xxxx : flread_word_pre = 1'b0;
			5'b10011 : flread_word_pre = 1'b1;
			5'b11100 : flread_word_pre = 1'b1;
			default : flread_word_pre = 1'b0;
		endcase
	end

	//assign flread_word = enc_rd_rom & flread_word_pre;  //t-uemura 090123  modify
	assign flread_word = (enc_rd_rom & flread_word_pre) | (enc_rd_exm & WDOP);  //t-uemura 090123  modify

//*************************************************************************************************
//*Coverage Memory HOST空間　制御信号
//*************************************************************************************************
//*フェッチカバレッジ空間                 フェッチカバレッジクリア空間
//*2011_FFFFH-----------------------------2091_FFFFH
//*    |         SFR空間(未使用)
//*2011_FFE0H-----------------------------2091_FFE0H
//*2011_FFDFH-----------------------------2091_FFDFH
//*    |         IRAM(汎用レジスタ含む)
//*2011_E100H-----------------------------2091_E100H
//*2011_E0FFH-----------------------------2091_E0FFH
//*    |         2ndSFR空間(未使用)
//*2011_E000H-----------------------------2091_E000H
//*2011_DFFFH-----------------------------2091_DFFFH
//*    |         IROM空間
//*2010_0000H-----------------------------2090_0000H
//*************************************************************************************************
	assign	fcov_mem_area = !ICEIFA31 & !ICEIFA30 & ICEIFA29 & !ICEIFA28 &     //201
							!ICEIFA27 & !ICEIFA26 & !ICEIFA25 & !ICEIFA24 &
							!ICEIFA23 & !ICEIFA22 & !ICEIFA21 & ICEIFA20;
	assign	fcov_bclr_area = !ICEIFA31 & !ICEIFA30 & ICEIFA29 & !ICEIFA28 &    //209
							!ICEIFA27 & !ICEIFA26 & !ICEIFA25 & !ICEIFA24 &
							ICEIFA23 & !ICEIFA22 & !ICEIFA21 & ICEIFA20;
	assign	fcov_ice_ad = (fcov_mem_area | fcov_bclr_area) ? iceifa[16:2] : 15'h0;

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//*************************************************************************************************
//*ROMリードカバレッジ空間           ROMリードカバレッジクリア空間     CPUAddress  960Kbyte
//*2101_DFFFH-----------------------------2201_DFFFH                    EDFFFH
//   |                                       |
//   |          EXMEM空間                    |                         20000H-80000Hまで、品種によって変動
//   |                                       | 
//   |          FLASH                        |
//*2100_0000H-----------------------------2200_0000H                    00000H
//*************************************************************************************************
	assign	romrdcov_mem_area = !ICEIFA31 & !ICEIFA30 & ICEIFA29 & !ICEIFA28 &     //210
							!ICEIFA27 & !ICEIFA26 & !ICEIFA25 & ICEIFA24 &
							!ICEIFA23 & !ICEIFA22 & !ICEIFA21 & !ICEIFA20;
	assign	romrdcov_bclr_area = !ICEIFA31 & !ICEIFA30 & ICEIFA29 & !ICEIFA28 &    //220
							!ICEIFA27 & !ICEIFA26 & ICEIFA25 & !ICEIFA24 &
							!ICEIFA23 & !ICEIFA22 & !ICEIFA21 & !ICEIFA20;
	assign	romrdcov_ice_ad = (romrdcov_mem_area | romrdcov_bclr_area) ? iceifa[16:2] : 15'h0;

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//*************************************************************************************************
//*リードカバレッジ空間                   リードカバレッジクリア空間
//*2020_FFFFH-----------------------------20A0_FFFFH
//*    |         SFR空間
//*2020_FF00H-----------------------------20A0_FF00H
//*2020_FEFFH-----------------------------20A0_FEFFH
//*    |         IRAM(汎用レジスタ含む)
//*2020_0800H-----------------------------20A0_0800H
//*2020_07FFH-----------------------------20A0_07FFH
//*    |         2ndSFR空間
//*2020_0000H-----------------------------20A0_0000H
//*************************************************************************************************
	assign	rcov_mem_area = !ICEIFA31 & !ICEIFA30 & ICEIFA29 & !ICEIFA28 &
							!ICEIFA27 & !ICEIFA26 & !ICEIFA25 & !ICEIFA24 &
							!ICEIFA23 & !ICEIFA22 & ICEIFA21 & !ICEIFA20;
	assign	rcov_bclr_area = !ICEIFA31 & !ICEIFA30 & ICEIFA29 & !ICEIFA28 &
							!ICEIFA27 & !ICEIFA26 & !ICEIFA25 & !ICEIFA24 &
							ICEIFA23 & !ICEIFA22 & ICEIFA21 & !ICEIFA20;
	assign	rcov_ice_ad = (rcov_mem_area | rcov_bclr_area) ? iceifa[15:2] :
							(user_ram_area) ? iceifa[17:4] : 14'h0;

//*************************************************************************************************
//*ライトカバレッジ空間                   ライトカバレッジクリア空間
//*2040_FFFFH-----------------------------20C0_FFFFH
//*    |         SFR空間
//*2040_FF00H-----------------------------20C0_FF00H
//*2040_FEFFH-----------------------------20C0_FEFFH
//*    |         IRAM(汎用レジスタ含む)
//*2040_0800H-----------------------------20C0_0800H
//*2040_07FFH-----------------------------20C0_07FFH
//*    |         2ndSFR空間
//*2040_0000H-----------------------------20C0_0000H
//*************************************************************************************************
	assign	wcov_mem_area = !ICEIFA31 & !ICEIFA30 & ICEIFA29 & !ICEIFA28 &
							!ICEIFA27 & !ICEIFA26 & !ICEIFA25 & !ICEIFA24 &
							!ICEIFA23 & ICEIFA22 & !ICEIFA21 & !ICEIFA20;
	assign	wcov_bclr_area = !ICEIFA31 & !ICEIFA30 & ICEIFA29 & !ICEIFA28 &
							!ICEIFA27 & !ICEIFA26 & !ICEIFA25 & !ICEIFA24 &
							ICEIFA23 & ICEIFA22 & !ICEIFA21 & !ICEIFA20;
	assign	wcov_ice_ad = (wcov_mem_area | wcov_bclr_area) ? iceifa[15:2] :
							(user_ram_area) ? iceifa[17:4] : 14'h0;

//*************************************************************************************************
//*User RAM 空間
//*0113_FBFFH-----------------------------
//*    |         IRAM(汎用レジスタ含む)  *汎用レジスタの領域のときのflagを立てる
//*0110_0C00H-----------------------------
//*************************************************************************************************
	assign	user_ram_area = !ICEIFA31 & !ICEIFA30 & !ICEIFA29 & !ICEIFA28 &			//011*
							!ICEIFA27 & !ICEIFA26 & !ICEIFA25 & ICEIFA24 &
							!ICEIFA23 & !ICEIFA22 & !ICEIFA21 & ICEIFA20;

	always @(user_ram_area or iceifa[3:2])begin
		casex({user_ram_area, iceifa[3:2]})
			3'b0xx : {user_ram3, user_ram2, user_ram1, user_ram0} = 4'b0000;
			3'b100 : {user_ram3, user_ram2, user_ram1, user_ram0} = 4'b0001;
			3'b101 : {user_ram3, user_ram2, user_ram1, user_ram0} = 4'b0010;
			3'b110 : {user_ram3, user_ram2, user_ram1, user_ram0} = 4'b0100;
			3'b111 : {user_ram3, user_ram2, user_ram1, user_ram0} = 4'b1000;
			default : {user_ram3, user_ram2, user_ram1, user_ram0} = 4'b0000;
		endcase
	end

	always @(user_ram_area or user_ram3 or user_ram2 or user_ram1 or user_ram0 or icedo_rd or icedo_wr)begin
		casex({user_ram_area, user_ram3, user_ram2, user_ram1, user_ram0})
			5'b0xxxx : icedo_user_ram_rwcov = 2'b00;
			5'b10001 : icedo_user_ram_rwcov = {icedo_rd[0], icedo_wr[0]};
			5'b10010 : icedo_user_ram_rwcov = {icedo_rd[1], icedo_wr[1]};
			5'b10100 : icedo_user_ram_rwcov = {icedo_rd[2], icedo_wr[2]};
			5'b11000 : icedo_user_ram_rwcov = {icedo_rd[3], icedo_wr[3]};
			default : icedo_user_ram_rwcov = 2'b00;
		endcase
	end

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//*************************************************************************************************
//*汎用レジスタ 空間 認識フラグ
//*0113_FBFFH-----------------------------
//*    |         汎用レジスタの領域のときのflagを立てる。gen_reg_area
//*0113_FB80H-----------------------------
//*************************************************************************************************
	assign gen_reg_area = !ICEIFA31 & !ICEIFA30 & !ICEIFA29 & !ICEIFA28 &	//0000		//0113_FB8*以上
						  !ICEIFA27 & !ICEIFA26 & !ICEIFA25 & ICEIFA24 &	//0001
						  !ICEIFA23 & !ICEIFA22 & !ICEIFA21 & ICEIFA20 &	//0001
						  !ICEIFA19 & !ICEIFA18 &  ICEIFA17 & ICEIFA16 &	//0011
						   ICEIFA15 &  ICEIFA14 &  ICEIFA13 & ICEIFA12 &	//1111
						   ICEIFA11 & !ICEIFA10 &  ICEIFA9  & ICEIFA8 &		//1011
						   ICEIFA7;
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
						   
						  
						  



//*************************************************************************************************
//*HOST Write 制御
//*************************************************************************************************
	//All Coverage Area (HOST)
	assign	cov_host_area = fcov_mem_area | fcov_bclr_area | rcov_mem_area |
							rcov_bclr_area | wcov_mem_area | wcov_bclr_area |
							romrdcov_mem_area | romrdcov_bclr_area | romrdcov_ice_ad;

	//Write Data Hold
	always @(negedge ICEWR or negedge SYSRSOUTB)begin
		if(!SYSRSOUTB) icedi_reg <= 32'h0;
		else if(cov_host_area) icedi_reg <= icedi;
	end
	//Write Timing Signal
	assign	res1 = ice_write | !SYSRSOUTB;

	always @(negedge ICEWR or posedge res1)begin
		if(res1) ice_wr_start <= 1'b0;
		else if(cov_host_area) ice_wr_start <= 1'b1;
	end
	always @(posedge CK60MHZ or negedge SYSRSOUTB)begin
		if(!SYSRSOUTB) ice_write <= 1'b0;
		else if(cov_host_area) ice_write <= ice_wr_start;
	end

	//Clear On/Off Signal
	assign	ice_fclr[0] = fclr[0] & ice_read ;		//Fetch Clear On/Off Signal
	assign	ice_fclr[1] = fclr[1] & ice_read ;
	assign	ice_fclr[2] = fclr[2] & ice_read ;
	assign	ice_fclr[3] = fclr[3] & ice_read ;
	assign	ice_fclr[4] = fclr[4] & ice_read ;
	assign	ice_fclr[5] = fclr[5] & ice_read ;
	assign	ice_fclr[6] = fclr[6] & ice_read ;
	assign	ice_fclr[7] = fclr[7] & ice_read ;
	assign	ice_fclr[8] = fclr[8] & ice_read ;
	assign	ice_fclr[9] = fclr[9] & ice_read ;
	assign	ice_fclr[10] = fclr[10] & ice_read ;
	assign	ice_fclr[11] = fclr[11] & ice_read ;
	assign	ice_fclr[12] = fclr[12] & ice_read ;
	assign	ice_fclr[13] = fclr[13] & ice_read ;
	assign	ice_fclr[14] = fclr[14] & ice_read ;
	assign	ice_fclr[15] = fclr[15] & ice_read ;
	assign	ice_fclr[16] = fclr[16] & ice_read ;
	assign	ice_fclr[17] = fclr[17] & ice_read ;
	assign	ice_fclr[18] = fclr[18] & ice_read ;
	assign	ice_fclr[19] = fclr[19] & ice_read ;
	assign	ice_fclr[20] = fclr[20] & ice_read ;
	assign	ice_fclr[21] = fclr[21] & ice_read ;
	assign	ice_fclr[22] = fclr[22] & ice_read ;
	assign	ice_fclr[23] = fclr[23] & ice_read ;
	assign	ice_fclr[24] = fclr[24] & ice_read ;
	assign	ice_fclr[25] = fclr[25] & ice_read ;
	assign	ice_fclr[26] = fclr[26] & ice_read ;
	assign	ice_fclr[27] = fclr[27] & ice_read ;
	assign	ice_fclr[28] = fclr[28] & ice_read ;
	assign	ice_fclr[29] = fclr[29] & ice_read ;
	assign	ice_fclr[30] = fclr[30] & ice_read ;
	assign	ice_fclr[31] = fclr[31] & ice_read ;

	assign	ice_rclr[0] = rclr[0] & ice_read ;		//Read Clear On/Off Signal
	assign	ice_rclr[1] = rclr[1] & ice_read ;
	assign	ice_rclr[2] = rclr[2] & ice_read ;
	assign	ice_rclr[3] = rclr[3] & ice_read ;

	assign	ice_wclr[0] = wclr[0] & ice_read ;		//Write Clear On/Off Signal
	assign	ice_wclr[1] = wclr[1] & ice_read ;
	assign	ice_wclr[2] = wclr[2] & ice_read ;
	assign	ice_wclr[3] = wclr[3] & ice_read ;

	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	assign	ice_romrdclr[0] = romrdclr[0] & ice_read ;
	assign	ice_romrdclr[1] = romrdclr[1] & ice_read ;
	assign	ice_romrdclr[2] = romrdclr[2] & ice_read ;
	assign	ice_romrdclr[3] = romrdclr[3] & ice_read ;
	assign	ice_romrdclr[4] = romrdclr[4] & ice_read ;
	assign	ice_romrdclr[5] = romrdclr[5] & ice_read ;
	assign	ice_romrdclr[6] = romrdclr[6] & ice_read ;
	assign	ice_romrdclr[7] = romrdclr[7] & ice_read ;
	assign	ice_romrdclr[8] = romrdclr[8] & ice_read ;
	assign	ice_romrdclr[9] = romrdclr[9] & ice_read ;
	assign	ice_romrdclr[10] = romrdclr[10] & ice_read ;
	assign	ice_romrdclr[11] = romrdclr[11] & ice_read ;
	assign	ice_romrdclr[12] = romrdclr[12] & ice_read ;
	assign	ice_romrdclr[13] = romrdclr[13] & ice_read ;
	assign	ice_romrdclr[14] = romrdclr[14] & ice_read ;
	assign	ice_romrdclr[15] = romrdclr[15] & ice_read ;
	assign	ice_romrdclr[16] = romrdclr[16] & ice_read ;
	assign	ice_romrdclr[17] = romrdclr[17] & ice_read ;
	assign	ice_romrdclr[18] = romrdclr[18] & ice_read ;
	assign	ice_romrdclr[19] = romrdclr[19] & ice_read ;
	assign	ice_romrdclr[20] = romrdclr[20] & ice_read ;
	assign	ice_romrdclr[21] = romrdclr[21] & ice_read ;
	assign	ice_romrdclr[22] = romrdclr[22] & ice_read ;
	assign	ice_romrdclr[23] = romrdclr[23] & ice_read ;
	assign	ice_romrdclr[24] = romrdclr[24] & ice_read ;
	assign	ice_romrdclr[25] = romrdclr[25] & ice_read ;
	assign	ice_romrdclr[26] = romrdclr[26] & ice_read ;
	assign	ice_romrdclr[27] = romrdclr[27] & ice_read ;
	assign	ice_romrdclr[28] = romrdclr[28] & ice_read ;
	assign	ice_romrdclr[29] = romrdclr[29] & ice_read ;
	assign	ice_romrdclr[30] = romrdclr[30] & ice_read ;
	assign	ice_romrdclr[31] = romrdclr[31] & ice_read ;
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	//Coverage Memory Write Enable Signal
	assign	we_fch_ice[0] = (ice_fclr[0] | ice_write) & (fcov_mem_area | fcov_bclr_area);	//Fetch Coverage Mem WE Signal
	assign	we_fch_ice[1] = (ice_fclr[1] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[2] = (ice_fclr[2] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[3] = (ice_fclr[3] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[4] = (ice_fclr[4] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[5] = (ice_fclr[5] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[6] = (ice_fclr[6] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[7] = (ice_fclr[7] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[8] = (ice_fclr[8] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[9] = (ice_fclr[9] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[10] = (ice_fclr[10] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[11] = (ice_fclr[11] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[12] = (ice_fclr[12] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[13] = (ice_fclr[13] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[14] = (ice_fclr[14] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[15] = (ice_fclr[15] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[16] = (ice_fclr[16] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[17] = (ice_fclr[17] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[18] = (ice_fclr[18] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[19] = (ice_fclr[19] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[20] = (ice_fclr[20] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[21] = (ice_fclr[21] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[22] = (ice_fclr[22] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[23] = (ice_fclr[23] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[24] = (ice_fclr[24] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[25] = (ice_fclr[25] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[26] = (ice_fclr[26] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[27] = (ice_fclr[27] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[28] = (ice_fclr[28] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[29] = (ice_fclr[29] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[30] = (ice_fclr[30] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_fch_ice[31] = (ice_fclr[31] | ice_write) & (fcov_mem_area | fcov_bclr_area);
	assign	we_rd_ice[0] = (ice_rclr[0] | ice_write) & (rcov_mem_area | rcov_bclr_area | user_ram0);	//Read Coverage Mem WE Signal
	assign	we_rd_ice[1] = (ice_rclr[1] | ice_write) & (rcov_mem_area | rcov_bclr_area | user_ram1);
	assign	we_rd_ice[2] = (ice_rclr[2] | ice_write) & (rcov_mem_area | rcov_bclr_area | user_ram2);
	assign	we_rd_ice[3] = (ice_rclr[3] | ice_write) & (rcov_mem_area | rcov_bclr_area | user_ram3);
	assign	we_wr_ice[0] = (ice_wclr[0] | ice_write) & (wcov_mem_area | wcov_bclr_area | user_ram0);	//Write Coverage Mem WE Signal
	assign	we_wr_ice[1] = (ice_wclr[1] | ice_write) & (wcov_mem_area | wcov_bclr_area | user_ram1);
	assign	we_wr_ice[2] = (ice_wclr[2] | ice_write) & (wcov_mem_area | wcov_bclr_area | user_ram2);
	assign	we_wr_ice[3] = (ice_wclr[3] | ice_write) & (wcov_mem_area | wcov_bclr_area | user_ram3);

	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	assign	we_romrd_ice[0] = (ice_romrdclr[0] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[1] = (ice_romrdclr[1] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[2] = (ice_romrdclr[2] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[3] = (ice_romrdclr[3] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[4] = (ice_romrdclr[4] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[5] = (ice_romrdclr[5] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[6] = (ice_romrdclr[6] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[7] = (ice_romrdclr[7] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[8] = (ice_romrdclr[8] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[9] = (ice_romrdclr[9] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[10] = (ice_romrdclr[10] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[11] = (ice_romrdclr[11] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[12] = (ice_romrdclr[12] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[13] = (ice_romrdclr[13] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[14] = (ice_romrdclr[14] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[15] = (ice_romrdclr[15] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[16] = (ice_romrdclr[16] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[17] = (ice_romrdclr[17] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[18] = (ice_romrdclr[18] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[19] = (ice_romrdclr[19] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[20] = (ice_romrdclr[20] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[21] = (ice_romrdclr[21] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[22] = (ice_romrdclr[22] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[23] = (ice_romrdclr[23] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[24] = (ice_romrdclr[24] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[25] = (ice_romrdclr[25] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[26] = (ice_romrdclr[26] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[27] = (ice_romrdclr[27] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[28] = (ice_romrdclr[28] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[29] = (ice_romrdclr[29] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[30] = (ice_romrdclr[30] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);
	assign	we_romrd_ice[31] = (ice_romrdclr[31] | ice_write) & (romrdcov_mem_area | romrdcov_bclr_area);

	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//Coverage Memory Enable
	assign	eni_fch = fcov_mem_area | fcov_bclr_area;	//Fetch Coverage Memory Enable
	assign	eni_rd = rcov_mem_area | rcov_bclr_area | user_ram_area;	//Read Coverage Memory Enable
	assign	eni_wr = wcov_mem_area | wcov_bclr_area | user_ram_area;	//Write Coverage Memory Enable

	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	assign	eni_romrd = romrdcov_mem_area | romrdcov_bclr_area;	//ROM Read Coverage Memory Enable
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	//Clear Memory Select Signal ([ 0: Not Clear ] [ 1: Clear ] )
	assign	icedi_fclr = (fcov_mem_area) ? 32'hFFFF_FFFF : (fcov_bclr_area) ? icedi_reg : 32'h0000_0000;
	assign	icedi_rclr = (rcov_mem_area) ? 4'hF : (rcov_bclr_area) ? {icedi_reg[24], icedi_reg[16], icedi_reg[8], icedi_reg[0]} :
						 (user_ram_area) ? {user_ram3, user_ram2, user_ram1, user_ram0} : 4'h0;
	assign	icedi_wclr = (wcov_mem_area) ? 4'hF : (wcov_bclr_area) ? {icedi_reg[24], icedi_reg[16], icedi_reg[8], icedi_reg[0]} :
						 (user_ram_area) ? {user_ram3, user_ram2, user_ram1, user_ram0} : 4'h0;

	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	assign	icedi_romrdclr = (romrdcov_mem_area) ? 32'hFFFF_FFFF : (romrdcov_bclr_area) ? icedi_reg : 32'h0000_0000;
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	//Coverage Memory Write Data ( HOST Write Only / Other -> 0 Write = 0 Clear )
	assign	icedi_fch = (fcov_mem_area & ice_write) ? icedi_reg : 32'h0000_0000;
	assign	icedi_rd = (rcov_mem_area & ice_write) ? {icedi_reg[24], icedi[16], icedi_reg[8], icedi_reg[0]} : 4'h0;
	assign	icedi_wr = (wcov_mem_area & ice_write) ? {icedi_reg[24], icedi[16], icedi[8], icedi_reg[0]} : 4'h0;
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	assign	icedi_romrd = (romrdcov_mem_area & ice_write) ? icedi_reg : 32'h0000_0000;
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//*************************************************************************************************
//*HOST Read Clear 回路
//*************************************************************************************************

	//Read Timing Signal
	assign	read_res1 = ice_read | !SYSRSOUTB;

	always @(negedge ICERD or posedge read_res1)begin
		if(read_res1) ice_rd_start <= 1'b0;
		else if(fcov_mem_area | rcov_mem_area | wcov_mem_area | user_ram_area | romrdcov_mem_area) ice_rd_start <= 1'b1;
	end
	always @(posedge CK60MHZ or negedge SYSRSOUTB)begin
		if(!SYSRSOUTB) ice_read <= 1'b0;
		else if(fcov_mem_area | rcov_mem_area | wcov_mem_area | user_ram_area | romrdcov_mem_area) ice_read <= ice_rd_start;
	end

//*************************************************************************************************
//*フェッチカバレッジメモリ
//*************************************************************************************************
	COVERAGE_RAM1MB fcov_mem(.cpu_ad(fcov_cpu_ad), .cpu_en(enc_fch), .cpu_wr(we_fch), .wdop(flread_word),
						.baseck(BASECK), .ice_ad(fcov_ice_ad), .ice_en(eni_fch), .ice_wr(we_fch_ice),
						.icedi_clr(icedi_fclr), .icedi(icedi_fch), .icedo(icedo_fch), .ck60mhz(CK60MHZ));

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↓ \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//*************************************************************************************************
//*ROMリードカバレッジメモリ
//*************************************************************************************************
	COVERAGE_RAM1MB romrdcov_mem(.cpu_ad(romrdcov_cpu_ad), .cpu_en(enc_romrd), .cpu_wr(we_romrd), .wdop(flread_word),
						.baseck(BASECK), .ice_ad(romrdcov_ice_ad), .ice_en(eni_romrd), .ice_wr(we_romrd_ice),
						.icedi_clr(icedi_romrdclr), .icedi(icedi_romrd), .icedo(icedo_romrd), .ck60mhz(CK60MHZ));

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 植村挿入  ↑ここまで \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//*************************************************************************************************
//*リードカバレッジメモリ
//*************************************************************************************************
	COVERAGE_RAM64KB rcov_mem(.cpu_ad(rcov_cpu_ad), .cpu_en(enc_rd_mem), .cpu_wr(we_rd), .wdop(WDOP),
						.baseck(BASECK), .ice_ad(rcov_ice_ad), .ice_en(eni_rd), .ice_wr(we_rd_ice),
						.icedi_clr(icedi_rclr), .icedi(icedi_rd), .icedo(icedo_rd), .ck60mhz(CK60MHZ));

//*************************************************************************************************
//*ライトカバレッジメモリ
//*************************************************************************************************
	COVERAGE_RAM64KB wcov_mem(.cpu_ad(wcov_cpu_ad), .cpu_en(enc_wr_mem), .cpu_wr(we_wr), .wdop(WDOP),
						.baseck(BASECK), .ice_ad(wcov_ice_ad), .ice_en(eni_wr), .ice_wr(we_wr_ice),
						.icedi_clr(icedi_wclr), .icedi(icedi_wr), .icedo(icedo_wr), .ck60mhz(CK60MHZ));

endmodule

//  ↓ライトクリア回路の不具合修正 2006.9.12 taketoshi.ide@necel
//*************************************************************************************************
//*フェッチカバレッジメモリ　兼　フラッシュリードカバレッジ
//*************************************************************************************************
module COVERAGE_RAM1MB (cpu_ad, cpu_en, cpu_wr, wdop, baseck, 
						ice_ad, ice_en, ice_wr, icedi_clr, icedi, icedo, ck60mhz);
	input	[19:0]	cpu_ad;
	input	cpu_en;
	input	cpu_wr;
	input	wdop;
	input	baseck;
	input	[14:0]	ice_ad;
	input	ice_en;
	input	[31:0]	ice_wr;
	input	[31:0]	icedi_clr;
	input	[31:0]	icedi;
	output	[31:0]	icedo;
	input	ck60mhz;

	wire	ice_do63, ice_do62, ice_do61, ice_do60, ice_do59, ice_do58, ice_do57, ice_do56,
			ice_do55, ice_do54, ice_do53, ice_do52, ice_do51, ice_do50, ice_do49, ice_do48,
			ice_do47, ice_do46, ice_do45, ice_do44, ice_do43, ice_do42, ice_do41, ice_do40,
			ice_do39, ice_do38, ice_do37, ice_do36, ice_do35, ice_do34, ice_do33, ice_do32,
			ice_do31, ice_do30, ice_do29, ice_do28, ice_do27, ice_do26, ice_do25, ice_do24,
			ice_do23, ice_do22, ice_do21, ice_do20, ice_do19, ice_do18, ice_do17, ice_do16,
			ice_do15, ice_do14, ice_do13, ice_do12, ice_do11, ice_do10, ice_do9, ice_do8,
			ice_do7, ice_do6, ice_do5, ice_do4, ice_do3, ice_do2, ice_do1, ice_do0;

	assign	icedo = ({ice_do63, ice_do62, ice_do61, ice_do60, ice_do59, ice_do58, ice_do57, ice_do56,
					  ice_do55, ice_do54, ice_do53, ice_do52, ice_do51, ice_do50, ice_do49, ice_do48,
					  ice_do47, ice_do46, ice_do45, ice_do44, ice_do43, ice_do42, ice_do41, ice_do40,
					  ice_do39, ice_do38, ice_do37, ice_do36, ice_do35, ice_do34, ice_do33, ice_do32} &
					{ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14],
					 ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14],
					 ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14],
					 ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14], ice_ad[14]}) |
					({ice_do31, ice_do30, ice_do29, ice_do28, ice_do27, ice_do26, ice_do25, ice_do24,
					  ice_do23, ice_do22, ice_do21, ice_do20, ice_do19, ice_do18, ice_do17, ice_do16,
					  ice_do15, ice_do14, ice_do13, ice_do12, ice_do11, ice_do10, ice_do9, ice_do8,
					  ice_do7, ice_do6, ice_do5, ice_do4, ice_do3, ice_do2, ice_do1, ice_do0} &
					{!ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14],
					 !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14],
					 !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14],
					 !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14], !ice_ad[14]});

	wire	ice_di31, ice_di30, ice_di29, ice_di28, ice_di27, ice_di26, ice_di25, ice_di24,
			ice_di23, ice_di22, ice_di21, ice_di20, ice_di19, ice_di18, ice_di17, ice_di16,
			ice_di15, ice_di14, ice_di13, ice_di12, ice_di11, ice_di10, ice_di9, ice_di8,
			ice_di7, ice_di6, ice_di5, ice_di4, ice_di3, ice_di2, ice_di1, ice_di0;

	wire	icedi_clr31, icedi_clr30, icedi_clr29, icedi_clr28, icedi_clr27, icedi_clr26, icedi_clr25, icedi_clr24,
			icedi_clr23, icedi_clr22, icedi_clr21, icedi_clr20, icedi_clr19, icedi_clr18, icedi_clr17, icedi_clr16,
			icedi_clr15, icedi_clr14, icedi_clr13, icedi_clr12, icedi_clr11, icedi_clr10, icedi_clr9, icedi_clr8,
			icedi_clr7, icedi_clr6, icedi_clr5, icedi_clr4, icedi_clr3, icedi_clr2, icedi_clr1, icedi_clr0;

	assign	{icedi_clr31, icedi_clr30, icedi_clr29, icedi_clr28, icedi_clr27, icedi_clr26, icedi_clr25, icedi_clr24,
			icedi_clr23, icedi_clr22, icedi_clr21, icedi_clr20, icedi_clr19, icedi_clr18, icedi_clr17, icedi_clr16,
			icedi_clr15, icedi_clr14, icedi_clr13, icedi_clr12, icedi_clr11, icedi_clr10, icedi_clr9, icedi_clr8,
			icedi_clr7, icedi_clr6, icedi_clr5, icedi_clr4, icedi_clr3, icedi_clr2, icedi_clr1, icedi_clr0}
			= icedi_clr;

	assign	{ice_di31, ice_di30, ice_di29, ice_di28, ice_di27, ice_di26, ice_di25, ice_di24,
			 ice_di23, ice_di22, ice_di21, ice_di20, ice_di19, ice_di18, ice_di17, ice_di16,
			 ice_di15, ice_di14, ice_di13, ice_di12, ice_di11, ice_di10, ice_di9, ice_di8,
			 ice_di7, ice_di6, ice_di5, ice_di4, ice_di3, ice_di2, ice_di1, ice_di0}
			= icedi;

	wire	enc0  = cpu_en & !cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc1  = cpu_en & !cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc2  = cpu_en & !cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc3  = cpu_en & !cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc4  = cpu_en & !cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc5  = cpu_en & !cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc6  = cpu_en & !cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc7  = cpu_en & !cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc8  = cpu_en & !cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc9  = cpu_en & !cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc10 = cpu_en & !cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc11 = cpu_en & !cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc12 = cpu_en & !cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc13 = cpu_en & !cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc14 = cpu_en & !cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc15 = cpu_en & !cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc16 = cpu_en & !cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc17 = cpu_en & !cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc18 = cpu_en & !cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc19 = cpu_en & !cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc20 = cpu_en & !cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc21 = cpu_en & !cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc22 = cpu_en & !cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc23 = cpu_en & !cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc24 = cpu_en & !cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc25 = cpu_en & !cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc26 = cpu_en & !cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc27 = cpu_en & !cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc28 = cpu_en & !cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc29 = cpu_en & !cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc30 = cpu_en & !cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc31 = cpu_en & !cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc32 = cpu_en & cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc33 = cpu_en & cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc34 = cpu_en & cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc35 = cpu_en & cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc36 = cpu_en & cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc37 = cpu_en & cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc38 = cpu_en & cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc39 = cpu_en & cpu_ad[19] & !cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc40 = cpu_en & cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc41 = cpu_en & cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc42 = cpu_en & cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc43 = cpu_en & cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc44 = cpu_en & cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc45 = cpu_en & cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc46 = cpu_en & cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc47 = cpu_en & cpu_ad[19] & !cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc48 = cpu_en & cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc49 = cpu_en & cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc50 = cpu_en & cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc51 = cpu_en & cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc52 = cpu_en & cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc53 = cpu_en & cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc54 = cpu_en & cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc55 = cpu_en & cpu_ad[19] & cpu_ad[4] & !cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc56 = cpu_en & cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc57 = cpu_en & cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc58 = cpu_en & cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc59 = cpu_en & cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & !cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc60 = cpu_en & cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & !cpu_ad[0];
	wire	enc61 = cpu_en & cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc62 = cpu_en & cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & !cpu_ad[0];
	wire	enc63 = cpu_en & cpu_ad[19] & cpu_ad[4] & cpu_ad[3] & cpu_ad[2] & cpu_ad[1] & (cpu_ad[0] | wdop);

	wire	eni0 = ice_en & !ice_ad[14];
	wire	eni1 = ice_en & !ice_ad[14];
	wire	eni2 = ice_en & !ice_ad[14];
	wire	eni3 = ice_en & !ice_ad[14];
	wire	eni4 = ice_en & !ice_ad[14];
	wire	eni5 = ice_en & !ice_ad[14];
	wire	eni6 = ice_en & !ice_ad[14];
	wire	eni7 = ice_en & !ice_ad[14];
	wire	eni8 = ice_en & !ice_ad[14];
	wire	eni9 = ice_en & !ice_ad[14];
	wire	eni10 = ice_en & !ice_ad[14];
	wire	eni11 = ice_en & !ice_ad[14];
	wire	eni12 = ice_en & !ice_ad[14];
	wire	eni13 = ice_en & !ice_ad[14];
	wire	eni14 = ice_en & !ice_ad[14];
	wire	eni15 = ice_en & !ice_ad[14];
	wire	eni16 = ice_en & !ice_ad[14];
	wire	eni17 = ice_en & !ice_ad[14];
	wire	eni18 = ice_en & !ice_ad[14];
	wire	eni19 = ice_en & !ice_ad[14];
	wire	eni20 = ice_en & !ice_ad[14];
	wire	eni21 = ice_en & !ice_ad[14];
	wire	eni22 = ice_en & !ice_ad[14];
	wire	eni23 = ice_en & !ice_ad[14];
	wire	eni24 = ice_en & !ice_ad[14];
	wire	eni25 = ice_en & !ice_ad[14];
	wire	eni26 = ice_en & !ice_ad[14];
	wire	eni27 = ice_en & !ice_ad[14];
	wire	eni28 = ice_en & !ice_ad[14];
	wire	eni29 = ice_en & !ice_ad[14];
	wire	eni30 = ice_en & !ice_ad[14];
	wire	eni31 = ice_en & !ice_ad[14];
	wire	eni32 = ice_en & ice_ad[14];
	wire	eni33 = ice_en & ice_ad[14];
	wire	eni34 = ice_en & ice_ad[14];
	wire	eni35 = ice_en & ice_ad[14];
	wire	eni36 = ice_en & ice_ad[14];
	wire	eni37 = ice_en & ice_ad[14];
	wire	eni38 = ice_en & ice_ad[14];
	wire	eni39 = ice_en & ice_ad[14];
	wire	eni40 = ice_en & ice_ad[14];
	wire	eni41 = ice_en & ice_ad[14];
	wire	eni42 = ice_en & ice_ad[14];
	wire	eni43 = ice_en & ice_ad[14];
	wire	eni44 = ice_en & ice_ad[14];
	wire	eni45 = ice_en & ice_ad[14];
	wire	eni46 = ice_en & ice_ad[14];
	wire	eni47 = ice_en & ice_ad[14];
	wire	eni48 = ice_en & ice_ad[14];
	wire	eni49 = ice_en & ice_ad[14];
	wire	eni50 = ice_en & ice_ad[14];
	wire	eni51 = ice_en & ice_ad[14];
	wire	eni52 = ice_en & ice_ad[14];
	wire	eni53 = ice_en & ice_ad[14];
	wire	eni54 = ice_en & ice_ad[14];
	wire	eni55 = ice_en & ice_ad[14];
	wire	eni56 = ice_en & ice_ad[14];
	wire	eni57 = ice_en & ice_ad[14];
	wire	eni58 = ice_en & ice_ad[14];
	wire	eni59 = ice_en & ice_ad[14];
	wire	eni60 = ice_en & ice_ad[14];
	wire	eni61 = ice_en & ice_ad[14];
	wire	eni62 = ice_en & ice_ad[14];
	wire	eni63 = ice_en & ice_ad[14];

	wire	ice_wr0 = ice_wr[0] & !ice_ad[14] & (ice_di0 ^ ice_do0) & icedi_clr0;
	wire	ice_wr1 = ice_wr[1] & !ice_ad[14] & (ice_di1 ^ ice_do1) & icedi_clr1;
	wire	ice_wr2 = ice_wr[2] & !ice_ad[14] & (ice_di2 ^ ice_do2) & icedi_clr2;
	wire	ice_wr3 = ice_wr[3] & !ice_ad[14] & (ice_di3 ^ ice_do3) & icedi_clr3;
	wire	ice_wr4 = ice_wr[4] & !ice_ad[14] & (ice_di4 ^ ice_do4) & icedi_clr4;
	wire	ice_wr5 = ice_wr[5] & !ice_ad[14] & (ice_di5 ^ ice_do5) & icedi_clr5;
	wire	ice_wr6 = ice_wr[6] & !ice_ad[14] & (ice_di6 ^ ice_do6) & icedi_clr6;
	wire	ice_wr7 = ice_wr[7] & !ice_ad[14] & (ice_di7 ^ ice_do7) & icedi_clr7;
	wire	ice_wr8 = ice_wr[8] & !ice_ad[14] & (ice_di8 ^ ice_do8) & icedi_clr8;
	wire	ice_wr9 = ice_wr[9] & !ice_ad[14] & (ice_di9 ^ ice_do9) & icedi_clr9;
	wire	ice_wr10 = ice_wr[10] & !ice_ad[14] & (ice_di10 ^ ice_do10) & icedi_clr10;
	wire	ice_wr11 = ice_wr[11] & !ice_ad[14] & (ice_di11 ^ ice_do11) & icedi_clr11;
	wire	ice_wr12 = ice_wr[12] & !ice_ad[14] & (ice_di12 ^ ice_do12) & icedi_clr12;
	wire	ice_wr13 = ice_wr[13] & !ice_ad[14] & (ice_di13 ^ ice_do13) & icedi_clr13;
	wire	ice_wr14 = ice_wr[14] & !ice_ad[14] & (ice_di14 ^ ice_do14) & icedi_clr14;
	wire	ice_wr15 = ice_wr[15] & !ice_ad[14] & (ice_di15 ^ ice_do15) & icedi_clr15;
	wire	ice_wr16 = ice_wr[16] & !ice_ad[14] & (ice_di16 ^ ice_do16) & icedi_clr16;
	wire	ice_wr17 = ice_wr[17] & !ice_ad[14] & (ice_di17 ^ ice_do17) & icedi_clr17;
	wire	ice_wr18 = ice_wr[18] & !ice_ad[14] & (ice_di18 ^ ice_do18) & icedi_clr18;
	wire	ice_wr19 = ice_wr[19] & !ice_ad[14] & (ice_di19 ^ ice_do19) & icedi_clr19;
	wire	ice_wr20 = ice_wr[20] & !ice_ad[14] & (ice_di20 ^ ice_do20) & icedi_clr20;
	wire	ice_wr21 = ice_wr[21] & !ice_ad[14] & (ice_di21 ^ ice_do21) & icedi_clr21;
	wire	ice_wr22 = ice_wr[22] & !ice_ad[14] & (ice_di22 ^ ice_do22) & icedi_clr22;
	wire	ice_wr23 = ice_wr[23] & !ice_ad[14] & (ice_di23 ^ ice_do23) & icedi_clr23;
	wire	ice_wr24 = ice_wr[24] & !ice_ad[14] & (ice_di24 ^ ice_do24) & icedi_clr24;
	wire	ice_wr25 = ice_wr[25] & !ice_ad[14] & (ice_di25 ^ ice_do25) & icedi_clr25;
	wire	ice_wr26 = ice_wr[26] & !ice_ad[14] & (ice_di26 ^ ice_do26) & icedi_clr26;
	wire	ice_wr27 = ice_wr[27] & !ice_ad[14] & (ice_di27 ^ ice_do27) & icedi_clr27;
	wire	ice_wr28 = ice_wr[28] & !ice_ad[14] & (ice_di28 ^ ice_do28) & icedi_clr28;
	wire	ice_wr29 = ice_wr[29] & !ice_ad[14] & (ice_di29 ^ ice_do29) & icedi_clr29;
	wire	ice_wr30 = ice_wr[30] & !ice_ad[14] & (ice_di30 ^ ice_do30) & icedi_clr30;
	wire	ice_wr31 = ice_wr[31] & !ice_ad[14] & (ice_di31 ^ ice_do31) & icedi_clr31;
	wire	ice_wr32 = ice_wr[0] & ice_ad[14] & (ice_di0 ^ ice_do32) & icedi_clr0;
	wire	ice_wr33 = ice_wr[1] & ice_ad[14] & (ice_di1 ^ ice_do33) & icedi_clr1;
	wire	ice_wr34 = ice_wr[2] & ice_ad[14] & (ice_di2 ^ ice_do34) & icedi_clr2;
	wire	ice_wr35 = ice_wr[3] & ice_ad[14] & (ice_di3 ^ ice_do35) & icedi_clr3;
	wire	ice_wr36 = ice_wr[4] & ice_ad[14] & (ice_di4 ^ ice_do36) & icedi_clr4;
	wire	ice_wr37 = ice_wr[5] & ice_ad[14] & (ice_di5 ^ ice_do37) & icedi_clr5;
	wire	ice_wr38 = ice_wr[6] & ice_ad[14] & (ice_di6 ^ ice_do38) & icedi_clr6;
	wire	ice_wr39 = ice_wr[7] & ice_ad[14] & (ice_di7 ^ ice_do39) & icedi_clr7;
	wire	ice_wr40 = ice_wr[8] & ice_ad[14] & (ice_di8 ^ ice_do40) & icedi_clr8;
	wire	ice_wr41 = ice_wr[9] & ice_ad[14] & (ice_di9 ^ ice_do41) & icedi_clr9;
	wire	ice_wr42 = ice_wr[10] & ice_ad[14] & (ice_di10 ^ ice_do42) & icedi_clr10;
	wire	ice_wr43 = ice_wr[11] & ice_ad[14] & (ice_di11 ^ ice_do43) & icedi_clr11;
	wire	ice_wr44 = ice_wr[12] & ice_ad[14] & (ice_di12 ^ ice_do44) & icedi_clr12;
	wire	ice_wr45 = ice_wr[13] & ice_ad[14] & (ice_di13 ^ ice_do45) & icedi_clr13;
	wire	ice_wr46 = ice_wr[14] & ice_ad[14] & (ice_di14 ^ ice_do46) & icedi_clr14;
	wire	ice_wr47 = ice_wr[15] & ice_ad[14] & (ice_di15 ^ ice_do47) & icedi_clr15;
	wire	ice_wr48 = ice_wr[16] & ice_ad[14] & (ice_di16 ^ ice_do48) & icedi_clr16;
	wire	ice_wr49 = ice_wr[17] & ice_ad[14] & (ice_di17 ^ ice_do49) & icedi_clr17;
	wire	ice_wr50 = ice_wr[18] & ice_ad[14] & (ice_di18 ^ ice_do50) & icedi_clr18;
	wire	ice_wr51 = ice_wr[19] & ice_ad[14] & (ice_di19 ^ ice_do51) & icedi_clr19;
	wire	ice_wr52 = ice_wr[20] & ice_ad[14] & (ice_di20 ^ ice_do52) & icedi_clr20;
	wire	ice_wr53 = ice_wr[21] & ice_ad[14] & (ice_di21 ^ ice_do53) & icedi_clr21;
	wire	ice_wr54 = ice_wr[22] & ice_ad[14] & (ice_di22 ^ ice_do54) & icedi_clr22;
	wire	ice_wr55 = ice_wr[23] & ice_ad[14] & (ice_di23 ^ ice_do55) & icedi_clr23;
	wire	ice_wr56 = ice_wr[24] & ice_ad[14] & (ice_di24 ^ ice_do56) & icedi_clr24;
	wire	ice_wr57 = ice_wr[25] & ice_ad[14] & (ice_di25 ^ ice_do57) & icedi_clr25;
	wire	ice_wr58 = ice_wr[26] & ice_ad[14] & (ice_di26 ^ ice_do58) & icedi_clr26;
	wire	ice_wr59 = ice_wr[27] & ice_ad[14] & (ice_di27 ^ ice_do59) & icedi_clr27;
	wire	ice_wr60 = ice_wr[28] & ice_ad[14] & (ice_di28 ^ ice_do60) & icedi_clr28;
	wire	ice_wr61 = ice_wr[29] & ice_ad[14] & (ice_di29 ^ ice_do61) & icedi_clr29;
	wire	ice_wr62 = ice_wr[30] & ice_ad[14] & (ice_di30 ^ ice_do62) & icedi_clr30;
	wire	ice_wr63 = ice_wr[31] & ice_ad[14] & (ice_di31 ^ ice_do63) & icedi_clr31;

	RAMB16_S1_S1 ram0 (.DOA(), .DOB(ice_do0),//A側への出力なし
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc0), .SSRA(1'b0), .WEA(cpu_wr), //A側から書くだけなので、DIAは常に'1'
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di0), .ENB(eni0), .SSRB(1'b0), .WEB(ice_wr0) ); //B側から

	RAMB16_S1_S1 ram1 (.DOA(), .DOB(ice_do1),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc1), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di1), .ENB(eni1), .SSRB(1'b0), .WEB(ice_wr1) );

	RAMB16_S1_S1 ram2 (.DOA(), .DOB(ice_do2),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc2), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di2), .ENB(eni2), .SSRB(1'b0), .WEB(ice_wr2) );

	RAMB16_S1_S1 ram3 (.DOA(), .DOB(ice_do3),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc3), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di3), .ENB(eni3), .SSRB(1'b0), .WEB(ice_wr3) );

	RAMB16_S1_S1 ram4 (.DOA(), .DOB(ice_do4),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc4), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di4), .ENB(eni4), .SSRB(1'b0), .WEB(ice_wr4) );

	RAMB16_S1_S1 ram5 (.DOA(), .DOB(ice_do5),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc5), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di5), .ENB(eni5), .SSRB(1'b0), .WEB(ice_wr5) );

	RAMB16_S1_S1 ram6 (.DOA(), .DOB(ice_do6),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc6), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di6), .ENB(eni6), .SSRB(1'b0), .WEB(ice_wr6) );

	RAMB16_S1_S1 ram7 (.DOA(), .DOB(ice_do7),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc7), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di7), .ENB(eni7), .SSRB(1'b0), .WEB(ice_wr7) );

	RAMB16_S1_S1 ram8 (.DOA(), .DOB(ice_do8),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc8), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di8), .ENB(eni8), .SSRB(1'b0), .WEB(ice_wr8) );

	RAMB16_S1_S1 ram9 (.DOA(), .DOB(ice_do9),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc9), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di9), .ENB(eni9), .SSRB(1'b0), .WEB(ice_wr9) );

	RAMB16_S1_S1 ram10 (.DOA(), .DOB(ice_do10),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc10), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di10), .ENB(eni10), .SSRB(1'b0), .WEB(ice_wr10) );

	RAMB16_S1_S1 ram11 (.DOA(), .DOB(ice_do11),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc11), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di11), .ENB(eni11), .SSRB(1'b0), .WEB(ice_wr11) );

	RAMB16_S1_S1 ram12 (.DOA(), .DOB(ice_do12),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc12), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di12), .ENB(eni12), .SSRB(1'b0), .WEB(ice_wr12) );

	RAMB16_S1_S1 ram13 (.DOA(), .DOB(ice_do13),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc13), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di13), .ENB(eni13), .SSRB(1'b0), .WEB(ice_wr13) );

	RAMB16_S1_S1 ram14 (.DOA(), .DOB(ice_do14),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc14), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di14), .ENB(eni14), .SSRB(1'b0), .WEB(ice_wr14) );

	RAMB16_S1_S1 ram15 (.DOA(), .DOB(ice_do15),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc15), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di15), .ENB(eni15), .SSRB(1'b0), .WEB(ice_wr15) );

	RAMB16_S1_S1 ram16 (.DOA(), .DOB(ice_do16),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc16), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di16), .ENB(eni16), .SSRB(1'b0), .WEB(ice_wr16) );

	RAMB16_S1_S1 ram17 (.DOA(), .DOB(ice_do17),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc17), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di17), .ENB(eni17), .SSRB(1'b0), .WEB(ice_wr17) );

	RAMB16_S1_S1 ram18 (.DOA(), .DOB(ice_do18),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc18), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di18), .ENB(eni18), .SSRB(1'b0), .WEB(ice_wr18) );

	RAMB16_S1_S1 ram19 (.DOA(), .DOB(ice_do19),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc19), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di19), .ENB(eni19), .SSRB(1'b0), .WEB(ice_wr19) );

	RAMB16_S1_S1 ram20 (.DOA(), .DOB(ice_do20),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc20), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di20), .ENB(eni20), .SSRB(1'b0), .WEB(ice_wr20) );

	RAMB16_S1_S1 ram21 (.DOA(), .DOB(ice_do21),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc21), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di21), .ENB(eni21), .SSRB(1'b0), .WEB(ice_wr21) );

	RAMB16_S1_S1 ram22 (.DOA(), .DOB(ice_do22),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc22), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di22), .ENB(eni22), .SSRB(1'b0), .WEB(ice_wr22) );

	RAMB16_S1_S1 ram23 (.DOA(), .DOB(ice_do23),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc23), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di23), .ENB(eni23), .SSRB(1'b0), .WEB(ice_wr23) );

	RAMB16_S1_S1 ram24 (.DOA(), .DOB(ice_do24),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc24), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di24), .ENB(eni24), .SSRB(1'b0), .WEB(ice_wr24) );

	RAMB16_S1_S1 ram25 (.DOA(), .DOB(ice_do25),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc25), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di25), .ENB(eni25), .SSRB(1'b0), .WEB(ice_wr25) );

	RAMB16_S1_S1 ram26 (.DOA(), .DOB(ice_do26),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc26), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di26), .ENB(eni26), .SSRB(1'b0), .WEB(ice_wr26) );

	RAMB16_S1_S1 ram27 (.DOA(), .DOB(ice_do27),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc27), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di27), .ENB(eni27), .SSRB(1'b0), .WEB(ice_wr27) );

	RAMB16_S1_S1 ram28 (.DOA(), .DOB(ice_do28),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc28), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di28), .ENB(eni28), .SSRB(1'b0), .WEB(ice_wr28) );

	RAMB16_S1_S1 ram29 (.DOA(), .DOB(ice_do29),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc29), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di29), .ENB(eni29), .SSRB(1'b0), .WEB(ice_wr29) );

	RAMB16_S1_S1 ram30 (.DOA(), .DOB(ice_do30),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc30), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di30), .ENB(eni30), .SSRB(1'b0), .WEB(ice_wr30) );

	RAMB16_S1_S1 ram31 (.DOA(), .DOB(ice_do31),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc31), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di31), .ENB(eni31), .SSRB(1'b0), .WEB(ice_wr31) );

	RAMB16_S1_S1 ram32 (.DOA(), .DOB(ice_do32),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc32), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di0), .ENB(eni32), .SSRB(1'b0), .WEB(ice_wr32) );

	RAMB16_S1_S1 ram33 (.DOA(), .DOB(ice_do33),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc33), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di1), .ENB(eni33), .SSRB(1'b0), .WEB(ice_wr33) );

	RAMB16_S1_S1 ram34 (.DOA(), .DOB(ice_do34),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc34), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di2), .ENB(eni34), .SSRB(1'b0), .WEB(ice_wr34) );

	RAMB16_S1_S1 ram35 (.DOA(), .DOB(ice_do35),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc35), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di3), .ENB(eni35), .SSRB(1'b0), .WEB(ice_wr35) );

	RAMB16_S1_S1 ram36 (.DOA(), .DOB(ice_do36),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc36), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di4), .ENB(eni36), .SSRB(1'b0), .WEB(ice_wr36) );

	RAMB16_S1_S1 ram37 (.DOA(), .DOB(ice_do37),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc37), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di5), .ENB(eni37), .SSRB(1'b0), .WEB(ice_wr37) );

	RAMB16_S1_S1 ram38 (.DOA(), .DOB(ice_do38),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc38), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di6), .ENB(eni38), .SSRB(1'b0), .WEB(ice_wr38) );

	RAMB16_S1_S1 ram39 (.DOA(), .DOB(ice_do39),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc39), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di7), .ENB(eni39), .SSRB(1'b0), .WEB(ice_wr39) );

	RAMB16_S1_S1 ram40 (.DOA(), .DOB(ice_do40),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc40), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di8), .ENB(eni40), .SSRB(1'b0), .WEB(ice_wr40) );

	RAMB16_S1_S1 ram41 (.DOA(), .DOB(ice_do41),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc41), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di9), .ENB(eni41), .SSRB(1'b0), .WEB(ice_wr41) );

	RAMB16_S1_S1 ram42 (.DOA(), .DOB(ice_do42),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc42), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di10), .ENB(eni42), .SSRB(1'b0), .WEB(ice_wr42) );

	RAMB16_S1_S1 ram43 (.DOA(), .DOB(ice_do43),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc43), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di11), .ENB(eni43), .SSRB(1'b0), .WEB(ice_wr43) );

	RAMB16_S1_S1 ram44 (.DOA(), .DOB(ice_do44),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc44), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di12), .ENB(eni44), .SSRB(1'b0), .WEB(ice_wr44) );

	RAMB16_S1_S1 ram45 (.DOA(), .DOB(ice_do45),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc45), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di13), .ENB(eni45), .SSRB(1'b0), .WEB(ice_wr45) );

	RAMB16_S1_S1 ram46 (.DOA(), .DOB(ice_do46),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc46), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di14), .ENB(eni46), .SSRB(1'b0), .WEB(ice_wr46) );

	RAMB16_S1_S1 ram47 (.DOA(), .DOB(ice_do47),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc47), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di15), .ENB(eni47), .SSRB(1'b0), .WEB(ice_wr47) );

	RAMB16_S1_S1 ram48 (.DOA(), .DOB(ice_do48),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc48), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di16), .ENB(eni48), .SSRB(1'b0), .WEB(ice_wr48) );

	RAMB16_S1_S1 ram49 (.DOA(), .DOB(ice_do49),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc49), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di17), .ENB(eni49), .SSRB(1'b0), .WEB(ice_wr49) );

	RAMB16_S1_S1 ram50 (.DOA(), .DOB(ice_do50),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc50), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di18), .ENB(eni50), .SSRB(1'b0), .WEB(ice_wr50) );

	RAMB16_S1_S1 ram51 (.DOA(), .DOB(ice_do51),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc51), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di19), .ENB(eni51), .SSRB(1'b0), .WEB(ice_wr51) );

	RAMB16_S1_S1 ram52 (.DOA(), .DOB(ice_do52),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc52), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di20), .ENB(eni52), .SSRB(1'b0), .WEB(ice_wr52) );

	RAMB16_S1_S1 ram53 (.DOA(), .DOB(ice_do53),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc53), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di21), .ENB(eni53), .SSRB(1'b0), .WEB(ice_wr53) );

	RAMB16_S1_S1 ram54 (.DOA(), .DOB(ice_do54),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc54), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di22), .ENB(eni54), .SSRB(1'b0), .WEB(ice_wr54) );

	RAMB16_S1_S1 ram55 (.DOA(), .DOB(ice_do55),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc55), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di23), .ENB(eni55), .SSRB(1'b0), .WEB(ice_wr55) );

	RAMB16_S1_S1 ram56 (.DOA(), .DOB(ice_do56),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc56), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di24), .ENB(eni56), .SSRB(1'b0), .WEB(ice_wr56) );

	RAMB16_S1_S1 ram57 (.DOA(), .DOB(ice_do57),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc57), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di25), .ENB(eni57), .SSRB(1'b0), .WEB(ice_wr57) );

	RAMB16_S1_S1 ram58 (.DOA(), .DOB(ice_do58),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc58), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di26), .ENB(eni58), .SSRB(1'b0), .WEB(ice_wr58) );

	RAMB16_S1_S1 ram59 (.DOA(), .DOB(ice_do59),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc59), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di27), .ENB(eni59), .SSRB(1'b0), .WEB(ice_wr59) );

	RAMB16_S1_S1 ram60 (.DOA(), .DOB(ice_do60),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc60), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di28), .ENB(eni60), .SSRB(1'b0), .WEB(ice_wr60) );

	RAMB16_S1_S1 ram61 (.DOA(), .DOB(ice_do61),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc61), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di29), .ENB(eni61), .SSRB(1'b0), .WEB(ice_wr61) );

	RAMB16_S1_S1 ram62 (.DOA(), .DOB(ice_do62),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc62), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di30), .ENB(eni62), .SSRB(1'b0), .WEB(ice_wr62) );

	RAMB16_S1_S1 ram63 (.DOA(), .DOB(ice_do63),
		.ADDRA(cpu_ad[18:5]), .CLKA(baseck), .DIA(1'b1), .ENA(enc63), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[13:0]), .CLKB(ck60mhz), .DIB(ice_di31), .ENB(eni63), .SSRB(1'b0), .WEB(ice_wr63) );

endmodule

module COVERAGE_RAM64KB (cpu_ad, cpu_en, cpu_wr, wdop, baseck, 
						ice_ad, ice_en, ice_wr, icedi_clr, icedi, icedo, ck60mhz);
	input	[15:0]	cpu_ad;
	input	cpu_en;
	input	cpu_wr;
	input	wdop;
	input	baseck;
	input	[13:0]	ice_ad;
	input	ice_en;
	input	[3:0]	ice_wr;
	input	[3:0]	icedi_clr;
	input	[3:0]	icedi;
	output	[3:0]	icedo;
	input	ck60mhz;

	wire	ice_do3, ice_do2, ice_do1, ice_do0;

	assign	icedo = {ice_do3, ice_do2, ice_do1, ice_do0};

	wire	ice_di3, ice_di2, ice_di1, ice_di0;

	wire	icedi_clr3, icedi_clr2, icedi_clr1, icedi_clr0;

	assign	{ice_di3, ice_di2, ice_di1, ice_di0} = icedi;

	assign	{icedi_clr3, icedi_clr2, icedi_clr1, icedi_clr0} = icedi_clr;

	wire	enc0  = cpu_en & !cpu_ad[1] & !cpu_ad[0];
	wire	enc1  = cpu_en & !cpu_ad[1] & (cpu_ad[0] | wdop);
	wire	enc2  = cpu_en & cpu_ad[1] & !cpu_ad[0];
	wire	enc3  = cpu_en & cpu_ad[1] & (cpu_ad[0] | wdop);

	wire	eni0 = ice_en;
	wire	eni1 = ice_en;
	wire	eni2 = ice_en;
	wire	eni3 = ice_en;

	wire	ice_wr0 = ice_wr[0] & (ice_di0 ^ ice_do0) & icedi_clr0;
	wire	ice_wr1 = ice_wr[1] & (ice_di1 ^ ice_do1) & icedi_clr1;
	wire	ice_wr2 = ice_wr[2] & (ice_di2 ^ ice_do2) & icedi_clr2;
	wire	ice_wr3 = ice_wr[3] & (ice_di3 ^ ice_do3) & icedi_clr3;

	RAMB16_S1_S1 ram0 (.DOA(), .DOB(ice_do0),
		.ADDRA(cpu_ad[15:2]), .CLKA(baseck), .DIA(1'b1), .ENA(enc0), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad), .CLKB(ck60mhz), .DIB(ice_di0), .ENB(eni0), .SSRB(1'b0), .WEB(ice_wr0) );

	RAMB16_S1_S1 ram1 (.DOA(), .DOB(ice_do1),
		.ADDRA(cpu_ad[15:2]), .CLKA(baseck), .DIA(1'b1), .ENA(enc1), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad), .CLKB(ck60mhz), .DIB(ice_di1), .ENB(eni1), .SSRB(1'b0), .WEB(ice_wr1) );

	RAMB16_S1_S1 ram2 (.DOA(), .DOB(ice_do2),
		.ADDRA(cpu_ad[15:2]), .CLKA(baseck), .DIA(1'b1), .ENA(enc2), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad), .CLKB(ck60mhz), .DIB(ice_di2), .ENB(eni2), .SSRB(1'b0), .WEB(ice_wr2) );

	RAMB16_S1_S1 ram3 (.DOA(), .DOB(ice_do3),
		.ADDRA(cpu_ad[15:2]), .CLKA(baseck), .DIA(1'b1), .ENA(enc3), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad), .CLKB(ck60mhz), .DIB(ice_di3), .ENB(eni3), .SSRB(1'b0), .WEB(ice_wr3) );

endmodule

