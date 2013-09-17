/************************************************************************************************************/
/*    RAM MODULE for FPGA   -  IRAM64K byte   version 1.00    by T.Ide    at 2005/09/15                     */
/*                                                    2.00    by T.Ide    at 2005/11/12                     */
/*                                                    3.00    by T.Ide    at 2005/12/19                     */
/*	SSr3d Ver1.00	Added brsam for saddr mirroring emulation	T.Tsunoda	2010/02/02	    */
/*	      Ver1.01	Added gdramwr for guard RAM function emulation	T.Tsunoda	2010/02/15	    */
/*            Ver1.02   Added ememramclk pin for ram/altram drive clock T.Tsunoda       2011/01/26          */
/*----------------------------------------------------------------------------------------------------------*/
// $Id: ememram-SS3rd.v,v 1.2 2010-02-15 06:54:29 tsuno3 Exp $
/************************************************************************************************************/
module EMEMRAM (slbmem, brsam, svmodf, svmod, alt1, slmem, gdramwr, wdop, cpuwr, ma, mdw, memmdr,
				flma, iceifa, icedo, icedi, icewr, sysrsoutb, baseck, ck60mhz, ememramclk);

	input			slbmem, brsam;
	input			svmodf, svmod, alt1;
	input			slmem, gdramwr, wdop, cpuwr;
	input	[15:0]	ma;
	input	[15:0]	mdw;
	output	[15:0]	memmdr;
	output	[15:0]	flma;
	input	[31:0]	iceifa, icedi;
	output	[31:0]	icedo;
	input			icewr;
	input			baseck, sysrsoutb, ck60mhz;
	input			ememramclk; // [Ver1.02]

	//***** internal signal *****
	wire	[14:0]	address_cpu;
	reg		[14:0]	icewritead;
	wire	[14:0]	address_ice, icealtuserad; 
	reg		[7:0]	icewritedata;
	reg				ice_write, icewritestart;

	wire			ice_user_area,ice_alt_area;
	wire			ice_userarea, ice_altarea;
	wire			sfr_area;
	wire			altram_area;
	wire			ocdram_area;
	wire			ice_sfr_area, ice_reg_area;
	wire			ena_cpu0, ena_cpu1, alt_ena_cpu0, alt_ena_cpu1,
            		ena_ice_iram0, ena_ice_iram1,
					ena_ice_alt0, ena_ice_alt1, re_cpu, ice_res1;
	wire	[31:0]	iceifa;
	wire	[7:0]	ram_out0, ram_out1;
	wire	[7:0]	ice_iram_out0, ice_iram_out1, iram_out0, iram_out1;
	wire	[7:0]	ice_alt_out0, ice_alt_out1, altram_out0, altram_out1;
	wire			svmod_ram, alt1;

	//**** Sadder Area Decode Signal *****
	wire			sadder_area;
	wire			sadder_area_flag;
	reg		[3:0]	ma_dec;

	//***** RAM空間アクセス切り替え信号 *****
	assign svmod_ram = svmodf & svmod;

//************************************************************************************************************
//* CPU側のアクセス制御                                                                                      *
//************************************************************************************************************

	//***** SFR 2ndSFR select flag *****
	assign sfr_area = (ma[15:8] == 8'hff || (ma[15:11] == 5'h0 && ocdram_area)); //すべてのSFR、2ndSFRマスク

	//***** OCDRAM select flag *****
	assign ocdram_area = !(ma[10:4] == 7'h7E || ma[10:4] == 7'h7F);              //OCDRAM空間フラグ

	//***** ALTRAM select flag *****
	assign altram_area = (ma[15:12] == 4'he || ma[15:12] == 4'hf) & slmem;       //FExxxh〜FFxxxh

	assign ena_cpu0 = slmem & (wdop | !ma[0]) & (!svmod_ram | alt1) & ~gdramwr;
	assign ena_cpu1 = slmem & (wdop | ma[0]) & (!svmod_ram | alt1) & ~gdramwr;
	assign alt_ena_cpu0 = altram_area & (wdop | !ma[0]) & (svmod_ram & !alt1);
	assign alt_ena_cpu1 = altram_area & (wdop | ma[0]) & (svmod_ram & !alt1);
	assign re_cpu = (ena_cpu0 | ena_cpu1 | alt_ena_cpu0 | alt_ena_cpu1) & !sfr_area;
	assign address_cpu = (sadder_area) ? {8'h08, ma_dec, ma[3:1]} : ma[15:1];

	//***** flma output *****
	assign flma = { address_cpu, ma[0] };

	//***** output select *****
	assign memmdr = (re_cpu) ? {ram_out1, ram_out0} : 16'h00;
	assign ram_out0 = (!svmod_ram | alt1) ? iram_out0 : altram_out0;
	assign ram_out1 = (!svmod_ram | alt1) ? iram_out1 : altram_out1;

	//2005.12.19デコードミス修正(saddr空間の上下 FFE00h〜FFE1Fh と FFEE0h〜FFEFFhまでBRAMにミラーしていたため)
	//***** saddr area flag *****
	assign sadder_area_flag = (ma[15:8] == 8'hFE) &
	                         !((ma[7:4] == 4'h0) || (ma[7:4] == 4'h1) || (ma[7:4] == 4'he) || (ma[7:4] == 4'hf));

	//***** saddr select flag *****
	/************************************************************************************************/
	/* [SS3rd Ver1.00]										*/
	/* saddrにBRAMをMirrorさせる条件にbrsamを追加。SS2ndでも本来BRAMEN=1の条件が必要だったはずだが,	*/
	/* 特に問題は起っていなかった。SS3rdではBRSAMのセットまで正しくemulationする(FirmでBRSAMをセッ	*/
	/* トする前の通常のsaddrを使う模様)。								*/
	/************************************************************************************************/
	assign sadder_area = slbmem & brsam & sadder_area_flag;

	//***** Address Decode *****
	always @(ma[7:4] or sadder_area)begin
		casex({sadder_area, ma[7:4]})
			{1'b0,4'hx} : ma_dec = 4'h0;
			{1'b1,4'h2} : ma_dec = 4'h0;
			{1'b1,4'h3} : ma_dec = 4'h1;
			{1'b1,4'h4} : ma_dec = 4'h2;
			{1'b1,4'h5} : ma_dec = 4'h3;
			{1'b1,4'h6} : ma_dec = 4'h4;
			{1'b1,4'h7} : ma_dec = 4'h5;
			{1'b1,4'h8} : ma_dec = 4'h6;
			{1'b1,4'h9} : ma_dec = 4'h7;
			{1'b1,4'hA} : ma_dec = 4'h8;
			{1'b1,4'hB} : ma_dec = 4'h9;
			{1'b1,4'hC} : ma_dec = 4'hA;
			{1'b1,4'hD} : ma_dec = 4'hB;
			default : ma_dec = 4'h0;
		endcase
	end

//***********************************************************************************************************
//* HOST側のアクセス制御                                                                                    *
//*                                                                                                         *
//* HOST Address                                                                                            *
//* modify at 2005.4.4 taketoshi.ide                                                                        *
//***********************************************************************************************************
//* Address                                                                                                 *
//*	010F_0800 - 010F_FEFF  IRAM                                                                             *
//*	0200_8000 - 0200_9FFF  ALTRAM                                                                           *
//***********************************************************************************************************

	assign icedo = (ice_user_area & !iceifa[2]) ? {24'h0000, ice_iram_out0} : 
					(ice_alt_area & !iceifa[2]) ? {24'h0000, ice_alt_out0} : 
                       (ice_user_area & iceifa[2]) ? {24'h0000, ice_iram_out1} :
						 (ice_alt_area & iceifa[2]) ? {24'h0000, ice_alt_out1} : 32'h0000_0000;

	//現状暫定的にSFR,2ndSFRはアクセスを開放している
	//HOSTからはSFR、GeneralRegister空間をアクセスできないようにしています。
	assign ice_sfr_area = (iceifa[17:10] == 8'hff || iceifa[17:13] == 5'h0) ? 1'b1 : 1'b0;
	assign ice_reg_area = (iceifa[17:6] == 12'hfee || iceifa[17:6] == 12'hfef) ? 1'b1 : 1'b0;

	assign ena_ice_iram0 = !iceifa[2] & ice_user_area ;
	assign ena_ice_iram1 = iceifa[2] & ice_user_area ;

	assign ena_ice_alt0 = !iceifa[2] & ice_alt_area;
	assign ena_ice_alt1 = iceifa[2] & ice_alt_area;

	assign ice_user_area = !ice_reg_area & ice_userarea;
	assign ice_alt_area = !ice_reg_area & ice_altarea;

//	assign ice_user_area = !(ice_sfr_area | ice_reg_area) & ice_userarea;
//	assign ice_alt_area = !(ice_sfr_area | ice_reg_area) & ice_altarea;

	//	modify at 2005.9.15 taketoshi.ide
	//***** IRAM Select (HOST) 011x_xxxxh〜 *****
	assign ice_userarea = !iceifa[31] & !iceifa[30] & !iceifa[29] & !iceifa[28] &
	                      !iceifa[27] & !iceifa[26] & !iceifa[25] &  iceifa[24] &
	                      !iceifa[23] & !iceifa[22] & !iceifa[21] &  iceifa[20] &
	                      !iceifa[19] & !iceifa[18] ;
	//***** ALTRAM Select (HOST) 0203_8xxxh 〜 0203_Fxxxh *****
	assign ice_altarea = !iceifa[31] & !iceifa[30] & !iceifa[29] & !iceifa[28] &
	                     !iceifa[27] & !iceifa[26] &  iceifa[25] & !iceifa[24] &
	                     !iceifa[23] & !iceifa[22] & !iceifa[21] & !iceifa[20] &
	                     !iceifa[19] & !iceifa[18] &  iceifa[17] &  iceifa[16] & iceifa[15];

//HOST adsress
	assign icealtuserad =  iceifa[17:3] ;

//SuperK0 -> icewritedata 8bit 
	always @(negedge icewr or negedge sysrsoutb) begin
		if (!sysrsoutb) begin
			icewritedata <= 8'h00;
			icewritead   <= 15'b0;
		end
		else begin
			icewritedata <= icedi[7:0];
			icewritead   <= icealtuserad;
		end
	end
	assign address_ice = (ice_write) ? icewritead : icealtuserad;

	assign ice_res1 = !sysrsoutb | ice_write;
	always @(negedge icewr or posedge ice_res1) begin
		if (ice_res1) icewritestart <= 1'b0;
		else if (ice_user_area | ice_alt_area) icewritestart <= 1'b1;
	end
	always @(posedge ck60mhz or negedge sysrsoutb) begin
		if (!sysrsoutb) ice_write <= 1'b0;
		else            ice_write <= icewritestart;
	end

//---------------------------------------------------------------------------------------
//FPGA IRAM 64Kbyte
//---------------------------------------------------------------------------------------
// [Ver1.02]
	EMEMIRAM_REG32K iram1 (.cpu_ad(address_cpu), .cpu_do(iram_out0), .cpu_di(mdw[7:0]), .cpu_en(ena_cpu0), 
                           .cpu_wr(cpuwr),.baseck(!ememramclk), .ice_ad(address_ice), .ice_do(ice_iram_out0), 
                           .ice_di(icewritedata), .ice_en(ena_ice_iram0), .ice_wr(ice_write), .ck60mhz(ck60mhz));

	EMEMIRAM_REG32K iram2 (.cpu_ad(address_cpu), .cpu_do(iram_out1), .cpu_di(mdw[15:8]), .cpu_en(ena_cpu1), 
                           .cpu_wr(cpuwr),.baseck(!ememramclk), .ice_ad(address_ice), .ice_do(ice_iram_out1), 
                           .ice_di(icewritedata), .ice_en(ena_ice_iram1), .ice_wr(ice_write), .ck60mhz(ck60mhz));
//---------------------------------------------------------------------------------------
//FPGA ALTRAM 8Kbyte
//---------------------------------------------------------------------------------------
// [Ver1.02]
	ALTRAM_REG4K altram1 (.cpu_ad(address_cpu[11:0]), .cpu_do(altram_out0), .cpu_di(mdw[7:0]), .cpu_en(alt_ena_cpu0), 
                         .cpu_wr(cpuwr),.baseck(!ememramclk), .ice_ad(address_ice[11:0]), .ice_do(ice_alt_out0), 
                         .ice_di(icewritedata), .ice_en(ena_ice_alt0), .ice_wr(ice_write), .ck60mhz(ck60mhz));

	ALTRAM_REG4K altram2 (.cpu_ad(address_cpu[11:0]), .cpu_do(altram_out1), .cpu_di(mdw[15:8]), .cpu_en(alt_ena_cpu1), 
                         .cpu_wr(cpuwr),.baseck(!ememramclk), .ice_ad(address_ice[11:0]), .ice_do(ice_alt_out1), 
                         .ice_di(icewritedata), .ice_en(ena_ice_alt1), .ice_wr(ice_write), .ck60mhz(ck60mhz));

endmodule

//---------------------------------------------------------------------------------------

module EMEMIRAM_REG32K (cpu_ad, cpu_do, cpu_di, cpu_en, cpu_wr, baseck, 
			ice_ad, ice_do, ice_di, ice_en, ice_wr, ck60mhz);
	input	[14:0]	cpu_ad, ice_ad;
	output	[7:0]	cpu_do, ice_do;
	input	[7:0]	cpu_di, ice_di;
	input		cpu_en, cpu_wr, baseck, ice_en, ice_wr, ck60mhz;

	wire	enc0 = cpu_en & !cpu_ad[14] & !cpu_ad[13] & !cpu_ad[12] & !cpu_ad[11];
	wire	enc1 = cpu_en & !cpu_ad[14] & !cpu_ad[13] & !cpu_ad[12] &  cpu_ad[11];
	wire	enc2 = cpu_en & !cpu_ad[14] & !cpu_ad[13] &  cpu_ad[12] & !cpu_ad[11];
	wire	enc3 = cpu_en & !cpu_ad[14] & !cpu_ad[13] &  cpu_ad[12] &  cpu_ad[11];
	wire	enc4 = cpu_en & !cpu_ad[14] &  cpu_ad[13] & !cpu_ad[12] & !cpu_ad[11];
	wire	enc5 = cpu_en & !cpu_ad[14] &  cpu_ad[13] & !cpu_ad[12] &  cpu_ad[11];
	wire	enc6 = cpu_en & !cpu_ad[14] &  cpu_ad[13] &  cpu_ad[12] & !cpu_ad[11];
	wire	enc7 = cpu_en & !cpu_ad[14] &  cpu_ad[13] &  cpu_ad[12] &  cpu_ad[11];
	wire	enc8 = cpu_en &  cpu_ad[14] & !cpu_ad[13] & !cpu_ad[12] & !cpu_ad[11];
	wire	enc9 = cpu_en &  cpu_ad[14] & !cpu_ad[13] & !cpu_ad[12] &  cpu_ad[11];
	wire	enc10 = cpu_en & cpu_ad[14] & !cpu_ad[13] &  cpu_ad[12] & !cpu_ad[11];
	wire	enc11 = cpu_en & cpu_ad[14] & !cpu_ad[13] &  cpu_ad[12] &  cpu_ad[11];
	wire	enc12 = cpu_en & cpu_ad[14] &  cpu_ad[13] & !cpu_ad[12] & !cpu_ad[11];
	wire	enc13 = cpu_en & cpu_ad[14] &  cpu_ad[13] & !cpu_ad[12] &  cpu_ad[11];
	wire	enc14 = cpu_en & cpu_ad[14] &  cpu_ad[13] &  cpu_ad[12] & !cpu_ad[11];
	wire	enc15 = cpu_en & cpu_ad[14] &  cpu_ad[13] &  cpu_ad[12] &  cpu_ad[11];

	wire	eni0 = ice_en & !ice_ad[14] & !ice_ad[13] & !ice_ad[12] & !ice_ad[11];
	wire	eni1 = ice_en & !ice_ad[14] & !ice_ad[13] & !ice_ad[12] &  ice_ad[11];
	wire	eni2 = ice_en & !ice_ad[14] & !ice_ad[13] &  ice_ad[12] & !ice_ad[11];
	wire	eni3 = ice_en & !ice_ad[14] & !ice_ad[13] &  ice_ad[12] &  ice_ad[11];
	wire	eni4 = ice_en & !ice_ad[14] &  ice_ad[13] & !ice_ad[12] & !ice_ad[11];
	wire	eni5 = ice_en & !ice_ad[14] &  ice_ad[13] & !ice_ad[12] &  ice_ad[11];
	wire	eni6 = ice_en & !ice_ad[14] &  ice_ad[13] &  ice_ad[12] & !ice_ad[11];
	wire	eni7 = ice_en & !ice_ad[14] &  ice_ad[13] &  ice_ad[12] &  ice_ad[11];
	wire	eni8 = ice_en &  ice_ad[14] & !ice_ad[13] & !ice_ad[12] & !ice_ad[11];
	wire	eni9 = ice_en &  ice_ad[14] & !ice_ad[13] & !ice_ad[12] &  ice_ad[11];
	wire	eni10 = ice_en & ice_ad[14] & !ice_ad[13] &  ice_ad[12] & !ice_ad[11];
	wire	eni11 = ice_en & ice_ad[14] & !ice_ad[13] &  ice_ad[12] &  ice_ad[11];
	wire	eni12 = ice_en & ice_ad[14] &  ice_ad[13] & !ice_ad[12] & !ice_ad[11];
	wire	eni13 = ice_en & ice_ad[14] &  ice_ad[13] & !ice_ad[12] &  ice_ad[11];
	wire	eni14 = ice_en & ice_ad[14] &  ice_ad[13] &  ice_ad[12] & !ice_ad[11];
	wire	eni15 = ice_en & ice_ad[14] &  ice_ad[13] &  ice_ad[12] &  ice_ad[11];

	wire	[7:0]	cpu_do0, cpu_do1, cpu_do2, cpu_do3, cpu_do4, cpu_do5, cpu_do6, cpu_do7,
					cpu_do8, cpu_do9, cpu_do10, cpu_do11, cpu_do12, cpu_do13, cpu_do14, cpu_do15;
	wire	[7:0]	ice_do0, ice_do1, ice_do2, ice_do3, ice_do4, ice_do5, ice_do6, ice_do7,
					ice_do8, ice_do9, ice_do10, ice_do11, ice_do12, ice_do13, ice_do14, ice_do15;

	assign cpu_do = (cpu_do0 & {enc0,enc0,enc0,enc0,enc0,enc0,enc0,enc0}) |
					(cpu_do1 & {enc1,enc1,enc1,enc1,enc1,enc1,enc1,enc1}) |
					(cpu_do2 & {enc2,enc2,enc2,enc2,enc2,enc2,enc2,enc2}) |
					(cpu_do3 & {enc3,enc3,enc3,enc3,enc3,enc3,enc3,enc3}) |
					(cpu_do4 & {enc4,enc4,enc4,enc4,enc4,enc4,enc4,enc4}) |
					(cpu_do5 & {enc5,enc5,enc5,enc5,enc5,enc5,enc5,enc5}) |
					(cpu_do6 & {enc6,enc6,enc6,enc6,enc6,enc6,enc6,enc6}) |
					(cpu_do7 & {enc7,enc7,enc7,enc7,enc7,enc7,enc7,enc7}) |
					(cpu_do8 & {enc8,enc8,enc8,enc8,enc8,enc8,enc8,enc8}) |
					(cpu_do9 & {enc9,enc9,enc9,enc9,enc9,enc9,enc9,enc9}) |
					(cpu_do10 & {enc10,enc10,enc10,enc10,enc10,enc10,enc10,enc10}) |
					(cpu_do11 & {enc11,enc11,enc11,enc11,enc11,enc11,enc11,enc11}) |
					(cpu_do12 & {enc12,enc12,enc12,enc12,enc12,enc12,enc12,enc12}) |
					(cpu_do13 & {enc13,enc13,enc13,enc13,enc13,enc13,enc13,enc13}) |
					(cpu_do14 & {enc14,enc14,enc14,enc14,enc14,enc14,enc14,enc14}) |
					(cpu_do15 & {enc15,enc15,enc15,enc15,enc15,enc15,enc15,enc15}) ;

	assign ice_do = (ice_do0 & {eni0,eni0,eni0,eni0,eni0,eni0,eni0,eni0}) |
					(ice_do1 & {eni1,eni1,eni1,eni1,eni1,eni1,eni1,eni1}) |
					(ice_do2 & {eni2,eni2,eni2,eni2,eni2,eni2,eni2,eni2}) |
					(ice_do3 & {eni3,eni3,eni3,eni3,eni3,eni3,eni3,eni3}) |
					(ice_do4 & {eni4,eni4,eni4,eni4,eni4,eni4,eni4,eni4}) |
					(ice_do5 & {eni5,eni5,eni5,eni5,eni5,eni5,eni5,eni5}) |
					(ice_do6 & {eni6,eni6,eni6,eni6,eni6,eni6,eni6,eni6}) |
					(ice_do7 & {eni7,eni7,eni7,eni7,eni7,eni7,eni7,eni7}) |
					(ice_do8 & {eni8,eni8,eni8,eni8,eni8,eni8,eni8,eni8}) |
					(ice_do9 & {eni9,eni9,eni9,eni9,eni9,eni9,eni9,eni9}) |
					(ice_do10 & {eni10,eni10,eni10,eni10,eni10,eni10,eni10,eni10}) |
					(ice_do11 & {eni11,eni11,eni11,eni11,eni11,eni11,eni11,eni11}) |
					(ice_do12 & {eni12,eni12,eni12,eni12,eni12,eni12,eni12,eni12}) |
					(ice_do13 & {eni13,eni13,eni13,eni13,eni13,eni13,eni13,eni13}) |
					(ice_do14 & {eni14,eni14,eni14,eni14,eni14,eni14,eni14,eni14}) |
					(ice_do15 & {eni15,eni15,eni15,eni15,eni15,eni15,eni15,eni15}) ;

	// FPGA RAM

	RAMB16_S9_S9 ram0 (.DOA(cpu_do0), .DOPA(), .DOB(ice_do0), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc0), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni0), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram1 (.DOA(cpu_do1), .DOPA(), .DOB(ice_do1), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc1), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni1), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram2 (.DOA(cpu_do2), .DOPA(), .DOB(ice_do2), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc2), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni2), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram3 (.DOA(cpu_do3), .DOPA(), .DOB(ice_do3), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc3), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni3), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram4 (.DOA(cpu_do4), .DOPA(), .DOB(ice_do4), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc4), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni4), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram5 (.DOA(cpu_do5), .DOPA(), .DOB(ice_do5), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc5), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni5), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram6 (.DOA(cpu_do6), .DOPA(), .DOB(ice_do6), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc6), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni6), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram7 (.DOA(cpu_do7), .DOPA(), .DOB(ice_do7), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc7), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni7), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram8 (.DOA(cpu_do8), .DOPA(), .DOB(ice_do8), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc8), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni8), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram9 (.DOA(cpu_do9), .DOPA(), .DOB(ice_do9), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc9), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni9), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram10 (.DOA(cpu_do10), .DOPA(), .DOB(ice_do10), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc10), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni10), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram11 (.DOA(cpu_do11), .DOPA(), .DOB(ice_do11), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc11), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni11), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram12 (.DOA(cpu_do12), .DOPA(), .DOB(ice_do12), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc12), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni12), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram13 (.DOA(cpu_do13), .DOPA(), .DOB(ice_do13), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc13), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni13), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram14 (.DOA(cpu_do14), .DOPA(), .DOB(ice_do14), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc14), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni14), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram15 (.DOA(cpu_do15), .DOPA(), .DOB(ice_do15), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc15), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni15), .SSRB(1'b0), .WEB(ice_wr)
		);

endmodule

module ALTRAM_REG4K (cpu_ad, cpu_do, cpu_di, cpu_en, cpu_wr, baseck, 
			ice_ad, ice_do, ice_di, ice_en, ice_wr, ck60mhz);
	input	[11:0]	cpu_ad, ice_ad;
	output	[7:0]	cpu_do, ice_do;
	input	[7:0]	cpu_di, ice_di;
	input		cpu_en, cpu_wr, baseck, ice_en, ice_wr, ck60mhz;

	wire	enc0 = cpu_en & !cpu_ad[11];
	wire	enc1 = cpu_en &  cpu_ad[11];

	wire	eni0 = ice_en & !ice_ad[11];
	wire	eni1 = ice_en &  ice_ad[11];

	wire	[7:0]	cpu_do0, cpu_do1;
	wire	[7:0]	ice_do0, ice_do1;

	assign cpu_do =
		(cpu_do0 & {enc0,enc0,enc0,enc0,enc0,enc0,enc0,enc0}) |
		(cpu_do1 & {enc1,enc1,enc1,enc1,enc1,enc1,enc1,enc1}) ;

	assign ice_do =
		(ice_do0 & {eni0,eni0,eni0,eni0,eni0,eni0,eni0,eni0}) |
		(ice_do1 & {eni1,eni1,eni1,eni1,eni1,eni1,eni1,eni1}) ;

// FPGA RAM

	RAMB16_S9_S9 ram0 (.DOA(cpu_do0), .DOPA(), .DOB(ice_do0), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc0), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni0), .SSRB(1'b0), .WEB(ice_wr)
		);

	RAMB16_S9_S9 ram1 (.DOA(cpu_do1), .DOPA(), .DOB(ice_do1), .DOPB(),
		.ADDRA(cpu_ad[10:0]), .CLKA(baseck), .DIA(cpu_di), .DIPA(1'b0),
		.ENA(enc1), .SSRA(1'b0), .WEA(cpu_wr),
		.ADDRB(ice_ad[10:0]), .CLKB(ck60mhz), .DIB(ice_di), .DIPB(1'b0),
		.ENB(eni1), .SSRB(1'b0), .WEB(ice_wr)
		);

endmodule
