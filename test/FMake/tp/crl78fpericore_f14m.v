// *****************************************************************************
//  (C) COPYRIGHT 2012 RENESAS ELECTRONICS CORPORATION, ALL RIGHTS RESERVED
// *****************************************************************************
//   Module Name:         crl78fpericore_f14m
//   Revision:            $Id$
//   Gen Date:            2012/04/05 15:08:08
// *****************************************************************************

 module crl78fpericore_f14m  (
       clk_pclkrw
      ,clk_iic_0_pclk
      ,rst_iic_0_res_n
      ,iic_0_intiic0
      ,ocd_svperi1
      ,clk_scan
      ,mod_scanen
      ,mod_scanmode
      ,fpga_clk60mhz
      ,clk_tau_1_pclk
      ,rst_tau_1_res_n
      ,tau_1_int3
      ,tau_1_int2
      ,tau_1_int1
      ,tau_1_int0
      ,tau_1_inth3
      ,tau_1_inth1
      ,clk_tau_0_pclk
      ,rst_tau_0_res_n
      ,tau_0_int0
      ,tau_0_int1
      ,tau_0_int2
      ,tau_0_int3
      ,tau_0_int4
      ,tau_0_int5
      ,tau_0_int6
      ,tau_0_int7
      ,tau_0_inth1
      ,tau_0_inth3
      ,rst_timd_0_res_n
      ,ocd_svperi0
      ,clk_timd_0_pclk
      ,dtc_timd_0_endimfa0
      ,dtc_timd_0_endimfb0
      ,dtc_timd_0_endimfc0
      ,dtc_timd_0_endimfd0
      ,dtc_timd_0_endimfa1
      ,dtc_timd_0_endimfb1
      ,dtc_timd_0_endimfc1
      ,dtc_timd_0_endimfd1
      ,timd_0_reqimfa0
      ,timd_0_reqimfb0
      ,timd_0_reqimfc0
      ,timd_0_reqimfd0
      ,timd_0_reqimfa1
      ,timd_0_reqimfb1
      ,timd_0_reqimfc1
      ,timd_0_reqimfd1
      ,timd_0_irreq0
      ,timd_0_irreq1
      ,rst_timj_0_res_n
      ,clk_fsub
      ,clk_fil_intrclk
      ,clk_timj_0_pclk
      ,timj_0_prsclen
      ,timj_0_reqirq_k
      ,clk_adc_pclk
      ,rst_adc_res_n
      ,adc_reqpclk
      ,adc_intad
      ,adc_bg2aden
      ,adc_bg2adsel
      ,mod_tesdbt
      ,rst_reset_n
      ,rst_res_n
      ,csc_resstp
      ,clk_fmain
      ,rst_scanres_n
      ,csc_rt0lpm
      ,clk_rtc_pclk
      ,rst_rtc_res_n
      ,clk_rtc_mclk
      ,clk_rtc_tclk
      ,pgcsc_cksel
      ,mod_optbct
      ,rtc_intrtc
      ,rtc_intrtci
      ,rtc_rt0mon0
      ,rtc_rt0mon1
      ,krif_intkr
      ,bbr_bbrsub_apbmask
      ,bbr_bbrsub_psel1st
      ,bbr_bbrsub_psel2nd
      ,bbr_penable
      ,bbrsub_prdata
      ,bbrsub_timd_0_pselal
      ,cibc_frqsel4
      ,clk_dspclkrw
      ,cpu_cpuwr
      ,cpu_ma
      ,cpu_mdw
      ,cpu_wdop
      ,porga_gdint
      ,csc_cken
      ,csc_per0
      ,pgcsc_dscken1
      ,pgcsc_dscken2
      ,pgcsc_dscken3
      ,pgcsc_dscken5
      ,pgcsc_per14
      ,ifil_intp0
      ,ifil_intp1
      ,ifil_intp2
      ,ifil_intp3
      ,ifil_intp4
      ,ifil_intp5
      ,ifil_intp6
      ,ifil_intp7
      ,ifil_intp8
      ,ifil_intp9
      ,ifil_intp10
      ,ifil_intp11
      ,clk_fclkrt
      ,porga_iawen
      ,porga_gdram
      ,porga_gdcsc
      ,capmx_adtrig0
      ,capmx_adtrig1
      ,capmx_intrtcdis
      ,mod_oti00
      ,clk_fil
      ,clk_fmx
      ,clk_bbclkr
      ,dtc_intdtc5
      ,dtc_intdtc6
      ,dtc_intdtc7
      ,porga_intdtc5
      ,porga_intdtc6
      ,porga_intdtc7
      ,rst_comp_res_n
      ,clk_comp_pclk
      ,comp_cdfs
      ,mod_tesinst
      ,comp_cirq
      ,clk_baseckhs
      ,rst_dac_res_n
      ,clk_dac_pclk
      ,clk_rcn_pclk
      ,clk_rcn_clka_can
      ,rst_rcn_presetz
      ,rcn_cherr_int
      ,rcn_comfrx_int
      ,rcn_glerr_int
      ,rcn_rxf_int
      ,rcn_tx_int
      ,clk_lin3_0_pclk
      ,clk_clkc
      ,rst_lin3_0_res_n
      ,lin3_0_int_t
      ,lin3_0_int_r
      ,lin3_0_int_s
      ,lin3_0_int_m
      ,lin3_0_reqpclk
      ,clk_sau_0_pclk
      ,clk_c2c_pclk
      ,rst_c2c_res_n
      ,rst_sau_0_res_n
      ,sau_0_intsau0
      ,sau_0_seint0
      ,sau_0_intsau1
      ,sau_0_seint1
      ,c2c_waitmem
      ,clk_sau_1_pclk
      ,rst_sau_1_res_n
      ,sau_1_intsau0
      ,sau_1_seint0
      ,sau_1_intsau1
      ,sau_1_seint1
      ,P00
      ,P01
      ,P02
      ,P10
      ,P11
      ,P12
      ,P120
      ,P125
      ,P126
      ,P13
      ,P130
      ,P137
      ,P14
      ,P140
      ,P15
      ,P16
      ,P17
      ,P30
      ,P31
      ,P32
      ,P33
      ,P34
      ,P40
      ,P41
      ,P42
      ,P43
      ,P44
      ,P45
      ,P46
      ,P47
      ,P50
      ,P51
      ,P52
      ,P53
      ,P54
      ,P55
      ,P56
      ,P57
      ,P60
      ,P61
      ,P62
      ,P63
      ,P64
      ,P65
      ,P66
      ,P67
      ,P70
      ,P71
      ,P72
      ,P73
      ,P74
      ,P75
      ,P76
      ,P77
      ,P80
      ,P81
      ,P82
      ,P83
      ,P84
      ,P85
      ,P86
      ,P87
      ,P90
      ,P91
      ,P92
      ,P93
      ,P94
      ,P95
      ,P96
      ,P97
      ,pt_hflashcp_vpptsin_va
      ,cibc_selin1
      ,bbr_prdsel_pclm
      ,csc_tselires
      ,csc_tseloreg
      ,csc_ttemp
      ,stopst_p31
      ,stopst_p52
      ,fcb_modidis
      ,mod_gofirm
      ,mod_optoplrd
      ,mod_tdout0
      ,mod_tdout1
      ,mod_tdout2
      ,mod_tdout3
      ,mod_tdsel0r
      ,mod_tdsel0t
      ,mod_tdsel1r
      ,mod_tdsel1t
      ,mod_tdsel2r
      ,mod_tdsel2t
      ,mod_tdsel3
      ,mod_tesdbt2
      ,mod_teseni0r
      ,mod_teseni0t
      ,mod_teseni1r
      ,mod_teseni1t
      ,mod_teseni2r
      ,mod_teseni2t
      ,mod_teseni3
      ,mod_teseni4
      ,mod_teseno0r
      ,mod_teseno0t
      ,mod_teseno1r
      ,mod_teseno1t
      ,mod_teseno2r
      ,mod_teseno2t
      ,mod_teseno3
      ,cibc_opocden
      ,ocd_ocdmod
      ,ocd_sltrxtx
      ,ocd_sprgmod
      ,ocd_hpimod
      ,ocd_txocd
      ,hhoco_oregout_va
      ,oscm_x1din
      ,oscm_x2din
      ,oscs_xt1din
      ,oscs_xt2din
      ,regm_pocrel_v5
      ,rst_nsres_n
      ,pt_mod_hvin
      ,pt_mod_routsrc10
      ,pt_mod_routsrc12
      ,pt_mod_tdin0r
      ,pt_mod_tdin0t
      ,pt_mod_tdin1r
      ,pt_mod_tdin1t
      ,pt_mod_tdin2r
      ,pt_mod_tdin2t
      ,pt_mod_tdin3
      ,pt_mod_tdin4
      ,pt_mod_tdin5
      ,pt_mod_tin00
      ,pt_ocd_toolrx
      ,pt_oscm_x1eni
      ,pt_oscm_x2eni
      ,pt_oscs_xt1eni
      ,pt_oscs_xt2eni
      ,pt_crx_in_int
      ,pt_ocd_rxocd
      ,pporga_cap_sel08p
      ,fpga_dgen
      ,mod_seltar
      ,csc_tstn
      ,mod_moderd
      ,mod_modewr
      ,mod_incdecws1
      ,mod_incdecws0
      ,mod_ta
      ,mod_modenop
      ,fcb_dw
      ,ramif_rcn_cmt
      ,regm_vbg2ad
      ,rst_rtbfg_n_v5
  );

// ***************************************************************
// *** input,output
// ***************************************************************
    input            clk_pclkrw;
    input            clk_iic_0_pclk;
    input            rst_iic_0_res_n;
    output           iic_0_intiic0;
    input            ocd_svperi1;
    input            clk_scan;
    input            mod_scanen;
    input            mod_scanmode;
    input            fpga_clk60mhz;
    input            clk_tau_1_pclk;
    input            rst_tau_1_res_n;
    output           tau_1_int3;
    output           tau_1_int2;
    output           tau_1_int1;
    output           tau_1_int0;
    output           tau_1_inth3;
    output           tau_1_inth1;
    input            clk_tau_0_pclk;
    input            rst_tau_0_res_n;
    output           tau_0_int0;
    output           tau_0_int1;
    output           tau_0_int2;
    output           tau_0_int3;
    output           tau_0_int4;
    output           tau_0_int5;
    output           tau_0_int6;
    output           tau_0_int7;
    output           tau_0_inth1;
    output           tau_0_inth3;
    input            rst_timd_0_res_n;
    input            ocd_svperi0;
    input            clk_timd_0_pclk;
    input            dtc_timd_0_endimfa0;
    input            dtc_timd_0_endimfb0;
    input            dtc_timd_0_endimfc0;
    input            dtc_timd_0_endimfd0;
    input            dtc_timd_0_endimfa1;
    input            dtc_timd_0_endimfb1;
    input            dtc_timd_0_endimfc1;
    input            dtc_timd_0_endimfd1;
    output           timd_0_reqimfa0;
    output           timd_0_reqimfb0;
    output           timd_0_reqimfc0;
    output           timd_0_reqimfd0;
    output           timd_0_reqimfa1;
    output           timd_0_reqimfb1;
    output           timd_0_reqimfc1;
    output           timd_0_reqimfd1;
    output           timd_0_irreq0;
    output           timd_0_irreq1;
    input            rst_timj_0_res_n;
    input            clk_fsub;
    input            clk_fil_intrclk;
    input            clk_timj_0_pclk;
    output           timj_0_prsclen;
    output           timj_0_reqirq_k;
    input            clk_adc_pclk;
    input            rst_adc_res_n;
    output           adc_reqpclk;
    output           adc_intad;
    output           adc_bg2aden;
    output           adc_bg2adsel;
    input            mod_tesdbt;
    input            rst_reset_n;
    input            rst_res_n;
    input            csc_resstp;
    input            clk_fmain;
    input            rst_scanres_n;
    input            csc_rt0lpm;
    input            clk_rtc_pclk;
    input            rst_rtc_res_n;
    input            clk_rtc_mclk;
    input            clk_rtc_tclk;
    input            pgcsc_cksel;
    input            mod_optbct;
    output           rtc_intrtc;
    output           rtc_intrtci;
    output           rtc_rt0mon0;
    output           rtc_rt0mon1;
    output           krif_intkr;
    input            bbr_bbrsub_apbmask;
    input            bbr_bbrsub_psel1st;
    input            bbr_bbrsub_psel2nd;
    input            bbr_penable;
    output [15:0]    bbrsub_prdata;
    output           bbrsub_timd_0_pselal;
    input            cibc_frqsel4;
    input            clk_dspclkrw;
    input            cpu_cpuwr;
    input  [10:0]    cpu_ma;
    input  [15:0]    cpu_mdw;
    input            cpu_wdop;
    output           porga_gdint;
    input  [15:1]    csc_cken;
    input  [7:0]     csc_per0;
    input            pgcsc_dscken1;
    input            pgcsc_dscken2;
    input            pgcsc_dscken3;
    input            pgcsc_dscken5;
    input            pgcsc_per14;
    output           ifil_intp0;
    output           ifil_intp1;
    output           ifil_intp2;
    output           ifil_intp3;
    output           ifil_intp4;
    output           ifil_intp5;
    output           ifil_intp6;
    output           ifil_intp7;
    output           ifil_intp8;
    output           ifil_intp9;
    output           ifil_intp10;
    output           ifil_intp11;
    input            clk_fclkrt;
    output           porga_iawen;
    output [1:0]     porga_gdram;
    output           porga_gdcsc;
    input            capmx_adtrig0;
    input            capmx_adtrig1;
    input            capmx_intrtcdis;
    input            mod_oti00;
    input            clk_fil;
    input            clk_fmx;
    input            clk_bbclkr;
    input            dtc_intdtc5;
    input            dtc_intdtc6;
    input            dtc_intdtc7;
    output           porga_intdtc5;
    output           porga_intdtc6;
    output           porga_intdtc7;
    input            rst_comp_res_n;
    input            clk_comp_pclk;
    output [1:0]     comp_cdfs;
    input            mod_tesinst;
    output           comp_cirq;
    input            clk_baseckhs;
    input            rst_dac_res_n;
    input            clk_dac_pclk;
    input            clk_rcn_pclk;
    input            clk_rcn_clka_can;
    input            rst_rcn_presetz;
    output           rcn_cherr_int;
    output           rcn_comfrx_int;
    output           rcn_glerr_int;
    output           rcn_rxf_int;
    output           rcn_tx_int;
    input            clk_lin3_0_pclk;
    input            clk_clkc;
    input            rst_lin3_0_res_n;
    output           lin3_0_int_t;
    output           lin3_0_int_r;
    output           lin3_0_int_s;
    output           lin3_0_int_m;
    output           lin3_0_reqpclk;
    input            clk_sau_0_pclk;
    input            clk_c2c_pclk;
    input            rst_c2c_res_n;
    input            rst_sau_0_res_n;
    output           sau_0_intsau0;
    output           sau_0_seint0;
    output           sau_0_intsau1;
    output           sau_0_seint1;
    output           c2c_waitmem;
    input            clk_sau_1_pclk;
    input            rst_sau_1_res_n;
    output           sau_1_intsau0;
    output           sau_1_seint0;
    output           sau_1_intsau1;
    output           sau_1_seint1;
    inout            P00;
    inout            P01;
    inout            P02;
    inout            P10;
    inout            P11;
    inout            P12;
    inout            P120;
    inout            P125;
    inout            P126;
    inout            P13;
    output           P130;
    input            P137;
    inout            P14;
    inout            P140;
    inout            P15;
    inout            P16;
    inout            P17;
    inout            P30;
    inout            P31;
    inout            P32;
    inout            P33;
    inout            P34;
    inout            P40;
    inout            P41;
    inout            P42;
    inout            P43;
    inout            P44;
    inout            P45;
    inout            P46;
    inout            P47;
    inout            P50;
    inout            P51;
    inout            P52;
    inout            P53;
    inout            P54;
    inout            P55;
    inout            P56;
    inout            P57;
    inout            P60;
    inout            P61;
    inout            P62;
    inout            P63;
    inout            P64;
    inout            P65;
    inout            P66;
    inout            P67;
    inout            P70;
    inout            P71;
    inout            P72;
    inout            P73;
    inout            P74;
    inout            P75;
    inout            P76;
    inout            P77;
    inout            P80;
    inout            P81;
    inout            P82;
    inout            P83;
    inout            P84;
    inout            P85;
    inout            P86;
    inout            P87;
    inout            P90;
    inout            P91;
    inout            P92;
    inout            P93;
    inout            P94;
    inout            P95;
    inout            P96;
    inout            P97;
    inout            pt_hflashcp_vpptsin_va;
    input            cibc_selin1;
    input  [3:0]     bbr_prdsel_pclm;
    input            csc_tselires;
    input            csc_tseloreg;
    input            csc_ttemp;
    input            stopst_p31;
    input            stopst_p52;
    input            fcb_modidis;
    input            mod_gofirm;
    input            mod_optoplrd;
    input            mod_tdout0;
    input            mod_tdout1;
    input            mod_tdout2;
    input            mod_tdout3;
    input            mod_tdsel0r;
    input            mod_tdsel0t;
    input            mod_tdsel1r;
    input            mod_tdsel1t;
    input            mod_tdsel2r;
    input            mod_tdsel2t;
    input            mod_tdsel3;
    input            mod_tesdbt2;
    input            mod_teseni0r;
    input            mod_teseni0t;
    input            mod_teseni1r;
    input            mod_teseni1t;
    input            mod_teseni2r;
    input            mod_teseni2t;
    input            mod_teseni3;
    input            mod_teseni4;
    input            mod_teseno0r;
    input            mod_teseno0t;
    input            mod_teseno1r;
    input            mod_teseno1t;
    input            mod_teseno2r;
    input            mod_teseno2t;
    input            mod_teseno3;
    input            cibc_opocden;
    input            ocd_ocdmod;
    input            ocd_sltrxtx;
    input            ocd_sprgmod;
    input            ocd_hpimod;
    input            ocd_txocd;
    input            hhoco_oregout_va;
    input            oscm_x1din;
    input            oscm_x2din;
    input            oscs_xt1din;
    input            oscs_xt2din;
    input            regm_pocrel_v5;
    input            rst_nsres_n;
    output           pt_mod_hvin;
    output           pt_mod_routsrc10;
    output           pt_mod_routsrc12;
    output           pt_mod_tdin0r;
    output           pt_mod_tdin0t;
    output           pt_mod_tdin1r;
    output           pt_mod_tdin1t;
    output           pt_mod_tdin2r;
    output           pt_mod_tdin2t;
    output           pt_mod_tdin3;
    output           pt_mod_tdin4;
    output           pt_mod_tdin5;
    output           pt_mod_tin00;
    output           pt_ocd_toolrx;
    output           pt_oscm_x1eni;
    output           pt_oscm_x2eni;
    output           pt_oscs_xt1eni;
    output           pt_oscs_xt2eni;
    output           pt_crx_in_int;
    output           pt_ocd_rxocd;
    output           pporga_cap_sel08p;
    output [15:0]    fpga_dgen;
    input            mod_seltar;
    input            csc_tstn;
    input            mod_moderd;
    input            mod_modewr;
    input            mod_incdecws1;
    input            mod_incdecws0;
    input  [16:0]    mod_ta;
    input            mod_modenop;
    input  [31:0]    fcb_dw;
    input            ramif_rcn_cmt;
    input            regm_vbg2ad;
    input            rst_rtbfg_n_v5;

// ***************************************************************
// *** wire
// ***************************************************************

  // *** crl78gmp200_f14m : mp200 ***
    wire             iic_0_sclo0;
    wire             iic_0_sdao0;
    wire             iic_0_intiic0;
    wire             tau_1_int3;
    wire             tau_1_int2;
    wire             tau_1_int1;
    wire             tau_1_int0;
    wire             tau_1_inth3;
    wire             tau_1_inth1;
    wire             tau_1_tout3;
    wire             tau_1_tout2;
    wire             tau_1_tout1;
    wire             tau_1_tout0;
    wire             tau_0_int0;
    wire             tau_0_int1;
    wire             tau_0_int2;
    wire             tau_0_int3;
    wire             tau_0_int4;
    wire             tau_0_int5;
    wire             tau_0_int6;
    wire             tau_0_int7;
    wire             tau_0_inth1;
    wire             tau_0_inth3;
    wire             tau_0_tout0;
    wire             tau_0_tout1;
    wire             tau_0_tout2;
    wire             tau_0_tout3;
    wire             tau_0_tout4;
    wire             tau_0_tout5;
    wire             tau_0_tout6;
    wire             tau_0_tout7;
    wire             timd_0_ftoa0;
    wire             timd_0_ftoa1;
    wire             timd_0_ftob0;
    wire             timd_0_ftob1;
    wire             timd_0_ftoc0;
    wire             timd_0_ftoc1;
    wire             timd_0_ftod0;
    wire             timd_0_ftod1;
    wire             timd_0_ftoa0_hizsel;
    wire             timd_0_ftoa1_hizsel;
    wire             timd_0_ftob0_hizsel;
    wire             timd_0_ftob1_hizsel;
    wire             timd_0_ftoc0_hizsel;
    wire             timd_0_ftoc1_hizsel;
    wire             timd_0_ftod0_hizsel;
    wire             timd_0_ftod1_hizsel;
    wire             timd_0_reqimfa0;
    wire             timd_0_reqimfb0;
    wire             timd_0_reqimfc0;
    wire             timd_0_reqimfd0;
    wire             timd_0_reqimfa1;
    wire             timd_0_reqimfb1;
    wire             timd_0_reqimfc1;
    wire             timd_0_reqimfd1;
    wire             timd_0_irreq0;
    wire             timd_0_irreq1;
    wire             timj_0_prsclen;
    wire             timj_0_trjo_k;
    wire             timj_0_trjio_k;
    wire             timj_0_reqirq_k;
    wire             adc_reqpclk;
    wire             adc_hadm_adclk;
    wire             adc_hadm_adpdb;
    wire             adc_hadm_adbionb;
    wire             adc_hadm_ads1;
    wire             adc_hadm_adofc;
    wire             adc_hadm_adcmp;
    wire   [1:0]     adc_hadm_advselmod;
    wire             adc_hadm_adgselmod;
    wire   [2:0]     adc_hadm_adtesmod;
    wire             adc_adcpon;
    wire   [4:0]     adc_adchsel;
    wire             adc_intad;
    wire             adc_bg2aden;
    wire             adc_bg2adsel;
`ifdef FPGA_ICE
    wire             adc_reg_adtyp;
`endif
    wire             pcbz_pclbuz0;
    wire             pcbz_pclbuz1;
    wire             rtc_intrtc;
    wire             rtc_intrtci;
    wire             rtc_clk1hz;
    wire             rtc_rt0mon0;
    wire             rtc_rt0mon1;
    wire             krif_intkr;
    wire   [10:0]    bbrsub_peri_padr;
    wire             bbrsub_peri_penable;
    wire   [15:0]    bbrsub_peri_pwdata;
    wire             bbrsub_peri_pwrite;
    wire   [15:0]    bbrsub_prdata;
    wire             bbrsub_pt_pselporga;
    wire             bbrsub_pt_pselport;
    wire             bbrsub_pt_pselport2;
    wire             bbrsub_timd_0_pselal;
    wire             porga_gdint;
    wire             ifil_intp0;
    wire             ifil_intp1;
    wire             ifil_intp2;
    wire             ifil_intp3;
    wire             ifil_intp4;
    wire             ifil_intp5;
    wire             ifil_intp6;
    wire             ifil_intp7;
    wire             ifil_intp8;
    wire             ifil_intp9;
    wire             ifil_intp10;
    wire             ifil_intp11;
    wire             porga_iawen;
    wire   [1:0]     porga_gdram;
    wire             porga_gdcsc;
    wire             porga_intdtc5;
    wire             porga_intdtc6;
    wire             porga_intdtc7;
    wire   [1:0]     comp_cdfs;
    wire             comp_cirq;
    wire             comp_vcout;
    wire             comp_testsel;
    wire             comp_hcmpon;
    wire             comp_couten;
    wire             comp_cmpsel0;
    wire             comp_cmpsel1;
    wire             comp_cmpsel2;
    wire             comp_cmpsel3;
    wire             comp_cvrs0;
    wire             comp_cvrs1;
    wire   [7:0]     dac_dadata0;
    wire   [7:0]     dac_dadata1;
    wire             dac_dace0;
    wire             dac_dace1;
    wire             fpga_dac_clk0;
    wire             fpga_dac_clk1;
    wire   [7:0]     fpga_dac_dadata0;
    wire   [7:0]     fpga_dac_dadata1;
    wire             fpga_dac_dace0;
    wire             fpga_dac_dace1;
    wire             rcn_txclk;
    wire   [8:0]     rcn_ad_ram;
    wire   [3:0]     rcn_bwnb_n;
    wire             rcn_cen_n;
    wire             rcn_cherr_int;
    wire             rcn_comfrx_int;
    wire   [31:0]    rcn_d;
    wire             rcn_glerr_int;
    wire             rcn_rxf_int;
    wire             rcn_tx_int;
    wire             rcn_wen_n;
    wire             rcn_tx_out;
    wire             lin3_0_int_t;
    wire             lin3_0_int_r;
    wire             lin3_0_int_s;
    wire             lin3_0_int_m;
    wire             lin3_0_tx_out;
    wire             lin3_0_reqpclk;
    wire             sau_0_sso0;
    wire             sau_0_scko0;
    wire             sau_0_sout00;
    wire             sau_0_sout01;
    wire             sau_0_sso1;
    wire             sau_0_scko1;
    wire             sau_0_sout10dly;
    wire             sau_0_sout11dly;
    wire             sau_0_intsau0;
    wire             sau_0_seint0;
    wire             sau_0_intsau1;
    wire             sau_0_seint1;
    wire             c2c_exbck;
    wire             c2c_exben;
    wire             c2c_exbdir;
    wire   [3:0]     c2c_exbo;
    wire             c2c_waitmem;
    wire             sau_1_sso0;
    wire             sau_1_scko0;
    wire             sau_1_sout00;
    wire             sau_1_sout01;
    wire             sau_1_sso1;
    wire             sau_1_scko1;
    wire             sau_1_sout10dly;
    wire             sau_1_sout11dly;
    wire             sau_1_intsau0;
    wire             sau_1_seint0;
    wire             sau_1_intsau1;
    wire             sau_1_seint1;
  // *** crl78hportiotop_f14m : portiotop ***
    wire             pt_hadm_adinh_va;
    wire             P00;
    wire             P01;
    wire             P02;
    wire             P10;
    wire             P11;
    wire             P12;
    wire             P120;
    wire             P125;
    wire             P126;
    wire             P13;
    wire             P130;
    wire             P14;
    wire             P140;
    wire             P15;
    wire             P16;
    wire             P17;
    wire             P30;
    wire             P31;
    wire             P32;
    wire             P33;
    wire             P34;
    wire             P40;
    wire             P41;
    wire             P42;
    wire             P43;
    wire             P44;
    wire             P45;
    wire             P46;
    wire             P47;
    wire             P50;
    wire             P51;
    wire             P52;
    wire             P53;
    wire             P54;
    wire             P55;
    wire             P56;
    wire             P57;
    wire             P60;
    wire             P61;
    wire             P62;
    wire             P63;
    wire             P64;
    wire             P65;
    wire             P66;
    wire             P67;
    wire             P70;
    wire             P71;
    wire             P72;
    wire             P73;
    wire             P74;
    wire             P75;
    wire             P76;
    wire             P77;
    wire             P80;
    wire             P81;
    wire             P82;
    wire             P83;
    wire             P84;
    wire             P85;
    wire             P86;
    wire             P87;
    wire             P90;
    wire             P91;
    wire             P92;
    wire             P93;
    wire             P94;
    wire             P95;
    wire             P96;
    wire             P97;
    wire             pt_hads_p120adinlp_va;
    wire             pt_hads_p125adinlp_va;
    wire             pt_hads_p96adinlp_va;
    wire             pt_hads_p97adinlp_va;
    wire             pt_hcmp_ivcmp00_va;
    wire             pt_hcmp_ivcmp01_va;
    wire             pt_hcmp_ivcmp02_va;
    wire             pt_hcmp_ivcmp03_va;
    wire             pt_hcmp_ivref0_va;
    wire             pt_hflashcp_vpptsin_va;
    wire             pt_hadcorn_adchsel4sw;
    wire             pt_hadcorn_adchsel3sw;
    wire             pt_hadcorn_adchsel2sw;
    wire             pt_hadcorn_adchsel1sw;
    wire             pt_hadcorn_adchsel0sw;
    wire             pt_hads_adcponl_v5;
    wire             pt_hadm_ads1bmuxl_v5;
    wire             pt_hadm_ads1dbmuxl_v5;
    wire             pt_hadm_adchsel0bl_v5;
    wire             pt_hadm_adchsel0l_v5;
    wire             pt_hadm_adchsel1bl_v5;
    wire             pt_hadm_adchsel1l_v5;
    wire             pt_hadm_adchsel2bl_v5;
    wire             pt_hadm_adchsel2l_v5;
    wire             pt_hadm_adchsel3bl_v5;
    wire             pt_hadm_adchsel3l_v5;
    wire             pt_hadm_adchsel4bl_v5;
    wire             pt_hadm_adchsel4l_v5;
    wire             pt_hadm_avrefmc_v5;
    wire             pt_hadm_avrefmr_v5;
    wire             pt_hadm_avrefpc_v5;
    wire             pt_hadm_avrefpr_v5;
    wire             pt_ifil_intp0;
    wire             pt_ifil_intp1;
    wire             pt_ifil_intp10;
    wire             pt_ifil_intp11;
    wire             pt_ifil_intp2;
    wire             pt_ifil_intp3;
    wire             pt_ifil_intp4;
    wire             pt_ifil_intp5;
    wire             pt_ifil_intp6;
    wire             pt_ifil_intp7;
    wire             pt_ifil_intp8;
    wire             pt_ifil_intp9;
    wire             pt_iic_0_scli0;
    wire             pt_iic_0_sdai0;
    wire             pt_krif_kr0;
    wire             pt_krif_kr1;
    wire             pt_krif_kr2;
    wire             pt_krif_kr3;
    wire             pt_krif_kr4;
    wire             pt_krif_kr5;
    wire             pt_krif_kr6;
    wire             pt_krif_kr7;
    wire             pt_mod_hvin;
    wire             pt_mod_routsrc10;
    wire             pt_mod_routsrc12;
    wire             pt_mod_tdin0r;
    wire             pt_mod_tdin0t;
    wire             pt_mod_tdin1r;
    wire             pt_mod_tdin1t;
    wire             pt_mod_tdin2r;
    wire             pt_mod_tdin2t;
    wire             pt_mod_tdin3;
    wire             pt_mod_tdin4;
    wire             pt_mod_tdin5;
    wire             pt_mod_tin00;
    wire             pt_ocd_toolrx;
    wire             pt_oscm_x1eni;
    wire             pt_oscm_x2eni;
    wire             pt_oscs_xt1eni;
    wire             pt_oscs_xt2eni;
    wire   [15:0]    pt_prdata;
    wire             pt_sau_0_scki0;
    wire             pt_sau_0_scki1;
    wire             pt_sau_0_sin0;
    wire             pt_sau_0_sin1;
    wire             pt_sau_0_ssi0;
    wire             pt_sau_0_ssi1;
    wire             pt_sau_1_scki0;
    wire             pt_sau_1_scki1;
    wire             pt_sau_1_sin0;
    wire             pt_sau_1_sin1;
    wire             pt_sau_1_ssi0;
    wire             pt_sau_1_ssi1;
    wire             pt_crx_in;
    wire             pt_crx_in_int;
    wire             pt_lin3_0_rxd;
    wire             pt_ocd_rxocd;
    wire             pt_tau_0_tin1;
    wire             pt_tau_0_tin2;
    wire             pt_tau_0_tin3;
    wire             pt_tau_0_tin4;
    wire             pt_tau_0_tin5;
    wire             pt_tau_0_tin6;
    wire             pt_tau_0_tin7;
    wire             pt_tau_1_tin0;
    wire             pt_tau_1_tin1;
    wire             pt_tau_1_tin2;
    wire             pt_tau_1_tin3;
    wire             pt_timd_0_trdioa0_a;
    wire             pt_timd_0_trdioa1_a;
    wire             pt_timd_0_trdiob0_a;
    wire             pt_timd_0_trdiob1_a;
    wire             pt_timd_0_trdioc0_a;
    wire             pt_timd_0_trdioc1_a;
    wire             pt_timd_0_trdiod0_a;
    wire             pt_timd_0_trdiod1_a;
    wire             pt_timj_0_trjio_a;
    wire             pt_hadm_rtbf_v5;
    wire             pporga_cap_sel08p;
    wire             pporga_dgen02;
    wire   [3:0]     pt_c2c_exbi;
    wire   [15:0]    fpga_dgen;
  // *** crl78hcanram_wrap1 : canramwrap ***
    wire   [31:0]    cram_rcn_q;
    wire   [15:0]    cram_mtestout;
  // *** umf30QAHCMP2 : hcmp ***
    wire             hcmp_cmpo;
    wire             hcmp_pt_testo;
  // *** QAHAD21SW24V1 : adsw24 ***
  // *** QAHAD21SW25V1 : adsw25 ***
  // *** QAHAD21SW26V1 : adsw26 ***
  // *** QAHAD21SW27V1 : adsw27 ***
  // *** QAHAD21SWL1V1 : adswcap ***
    wire             hads_adinl_va;
  // *** QAHADA21HN0V1 : adhard ***
    wire   [9:0]     hadm_adc_adsar;
    wire             hadm_adc_adeocb;
    wire             hadm_ads1mux;
  // *** QICTRAHAH5 : adcorner ***
    wire             hadcorn_adchsel0g_v5;
    wire             hadcorn_adchsel1g_v5;
    wire             hadcorn_adchsel2g_v5;
    wire             hadcorn_adchsel3g_v5;
    wire             hadcorn_adchsel4g_v5;
    wire             hadcorn_adchsel0bg_v5;
    wire             hadcorn_adchsel1bg_v5;
    wire             hadcorn_adchsel2bg_v5;
    wire             hadcorn_adchsel3bg_v5;
    wire             hadcorn_adchsel4bg_v5;
    wire             hadcorn_ads1bmuxg_v5;
    wire             hadcorn_ads1dbmuxg_v5;
    wire             hadcorn_adcpong_v5;
  // *** umf30hdac023 : hmdac_0 ***
    wire             hdac_0_dacouthv_va;

//=================================================================
//===   pulldown,pullup
//=================================================================
    wire pull_up0;
    wire pull_down0;
    wire pull_down1;
    wire pull_down2;
    wire pull_down3;
    pullup_cell_pf pullup_cell0( .y(pull_up0) ) ;
    pulldown_cell_pf pulldown_cell0( .y(pull_down0) ) ;
    pulldown_cell_pf pulldown_cell1( .y(pull_down1) ) ;
    pulldown_cell_pf pulldown_cell2( .y(pull_down2) ) ;
    pulldown_cell_pf pulldown_cell3( .y(pull_down3) ) ;


//=================================================================
//===   crl78gmp200_f14m : mp200
//=================================================================
  crl78gmp200_f14m  mp200  (
      .clk_pclkrw                 (   clk_pclkrw                                                                                                              )
     ,.clk_iic_0_pclk             (   clk_iic_0_pclk                                                                                                          )
     ,.rst_iic_0_res_n            (   rst_iic_0_res_n                                                                                                         )
     ,.pt_iic_0_scli0             (   pt_iic_0_scli0                                                                                                          )
     ,.iic_0_sclo0                (   iic_0_sclo0                                                                                                             )
     ,.pt_iic_0_sdai0             (   pt_iic_0_sdai0                                                                                                          )
     ,.iic_0_sdao0                (   iic_0_sdao0                                                                                                             )
     ,.iic_0_intiic0              (   iic_0_intiic0                                                                                                           )
     ,.ocd_svperi1                (   ocd_svperi1                                                                                                             )
     ,.clk_scan                   (   clk_scan                                                                                                                )
     ,.mod_scanen                 (   mod_scanen                                                                                                              )
     ,.mod_scanmode               (   mod_scanmode                                                                                                            )
     ,.fpga_clk60mhz              (   fpga_clk60mhz                                                                                                           )
     ,.clk_tau_1_pclk             (   clk_tau_1_pclk                                                                                                          )
     ,.rst_tau_1_res_n            (   rst_tau_1_res_n                                                                                                         )
     ,.tau_1_int3                 (   tau_1_int3                                                                                                              )
     ,.tau_1_int2                 (   tau_1_int2                                                                                                              )
     ,.tau_1_int1                 (   tau_1_int1                                                                                                              )
     ,.tau_1_int0                 (   tau_1_int0                                                                                                              )
     ,.tau_1_inth3                (   tau_1_inth3                                                                                                             )
     ,.tau_1_inth1                (   tau_1_inth1                                                                                                             )
     ,.pt_tau_1_tin3              (   pt_tau_1_tin3                                                                                                           )
     ,.pt_tau_1_tin2              (   pt_tau_1_tin2                                                                                                           )
     ,.pt_tau_1_tin1              (   pt_tau_1_tin1                                                                                                           )
     ,.pt_tau_1_tin0              (   pt_tau_1_tin0                                                                                                           )
     ,.tau_1_tout3                (   tau_1_tout3                                                                                                             )
     ,.tau_1_tout2                (   tau_1_tout2                                                                                                             )
     ,.tau_1_tout1                (   tau_1_tout1                                                                                                             )
     ,.tau_1_tout0                (   tau_1_tout0                                                                                                             )
     ,.clk_tau_0_pclk             (   clk_tau_0_pclk                                                                                                          )
     ,.rst_tau_0_res_n            (   rst_tau_0_res_n                                                                                                         )
     ,.pt_tau_0_tin2              (   pt_tau_0_tin2                                                                                                           )
     ,.pt_tau_0_tin3              (   pt_tau_0_tin3                                                                                                           )
     ,.tau_0_int0                 (   tau_0_int0                                                                                                              )
     ,.tau_0_int1                 (   tau_0_int1                                                                                                              )
     ,.tau_0_int2                 (   tau_0_int2                                                                                                              )
     ,.tau_0_int3                 (   tau_0_int3                                                                                                              )
     ,.tau_0_int4                 (   tau_0_int4                                                                                                              )
     ,.tau_0_int5                 (   tau_0_int5                                                                                                              )
     ,.tau_0_int6                 (   tau_0_int6                                                                                                              )
     ,.tau_0_int7                 (   tau_0_int7                                                                                                              )
     ,.tau_0_inth1                (   tau_0_inth1                                                                                                             )
     ,.tau_0_inth3                (   tau_0_inth3                                                                                                             )
     ,.tau_0_tout0                (   tau_0_tout0                                                                                                             )
     ,.tau_0_tout1                (   tau_0_tout1                                                                                                             )
     ,.tau_0_tout2                (   tau_0_tout2                                                                                                             )
     ,.tau_0_tout3                (   tau_0_tout3                                                                                                             )
     ,.tau_0_tout4                (   tau_0_tout4                                                                                                             )
     ,.tau_0_tout5                (   tau_0_tout5                                                                                                             )
     ,.tau_0_tout6                (   tau_0_tout6                                                                                                             )
     ,.tau_0_tout7                (   tau_0_tout7                                                                                                             )
     ,.rst_timd_0_res_n           (   rst_timd_0_res_n                                                                                                        )
     ,.ocd_svperi0                (   ocd_svperi0                                                                                                             )
     ,.clk_timd_0_pclk            (   clk_timd_0_pclk                                                                                                         )
     ,.pt_timd_0_trdioa0_a        (   pt_timd_0_trdioa0_a                                                                                                     )
     ,.pt_timd_0_trdioa1_a        (   pt_timd_0_trdioa1_a                                                                                                     )
     ,.pt_timd_0_trdiob0_a        (   pt_timd_0_trdiob0_a                                                                                                     )
     ,.pt_timd_0_trdiob1_a        (   pt_timd_0_trdiob1_a                                                                                                     )
     ,.pt_timd_0_trdioc0_a        (   pt_timd_0_trdioc0_a                                                                                                     )
     ,.pt_timd_0_trdioc1_a        (   pt_timd_0_trdioc1_a                                                                                                     )
     ,.pt_timd_0_trdiod0_a        (   pt_timd_0_trdiod0_a                                                                                                     )
     ,.pt_timd_0_trdiod1_a        (   pt_timd_0_trdiod1_a                                                                                                     )
     ,.timd_0_ftoa0               (   timd_0_ftoa0                                                                                                            )
     ,.timd_0_ftoa1               (   timd_0_ftoa1                                                                                                            )
     ,.timd_0_ftob0               (   timd_0_ftob0                                                                                                            )
     ,.timd_0_ftob1               (   timd_0_ftob1                                                                                                            )
     ,.timd_0_ftoc0               (   timd_0_ftoc0                                                                                                            )
     ,.timd_0_ftoc1               (   timd_0_ftoc1                                                                                                            )
     ,.timd_0_ftod0               (   timd_0_ftod0                                                                                                            )
     ,.timd_0_ftod1               (   timd_0_ftod1                                                                                                            )
     ,.timd_0_ftoa0_hizsel        (   timd_0_ftoa0_hizsel                                                                                                     )
     ,.timd_0_ftoa1_hizsel        (   timd_0_ftoa1_hizsel                                                                                                     )
     ,.timd_0_ftob0_hizsel        (   timd_0_ftob0_hizsel                                                                                                     )
     ,.timd_0_ftob1_hizsel        (   timd_0_ftob1_hizsel                                                                                                     )
     ,.timd_0_ftoc0_hizsel        (   timd_0_ftoc0_hizsel                                                                                                     )
     ,.timd_0_ftoc1_hizsel        (   timd_0_ftoc1_hizsel                                                                                                     )
     ,.timd_0_ftod0_hizsel        (   timd_0_ftod0_hizsel                                                                                                     )
     ,.timd_0_ftod1_hizsel        (   timd_0_ftod1_hizsel                                                                                                     )
     ,.dtc_timd_0_endimfa0        (   dtc_timd_0_endimfa0                                                                                                     )
     ,.dtc_timd_0_endimfb0        (   dtc_timd_0_endimfb0                                                                                                     )
     ,.dtc_timd_0_endimfc0        (   dtc_timd_0_endimfc0                                                                                                     )
     ,.dtc_timd_0_endimfd0        (   dtc_timd_0_endimfd0                                                                                                     )
     ,.dtc_timd_0_endimfa1        (   dtc_timd_0_endimfa1                                                                                                     )
     ,.dtc_timd_0_endimfb1        (   dtc_timd_0_endimfb1                                                                                                     )
     ,.dtc_timd_0_endimfc1        (   dtc_timd_0_endimfc1                                                                                                     )
     ,.dtc_timd_0_endimfd1        (   dtc_timd_0_endimfd1                                                                                                     )
     ,.timd_0_reqimfa0            (   timd_0_reqimfa0                                                                                                         )
     ,.timd_0_reqimfb0            (   timd_0_reqimfb0                                                                                                         )
     ,.timd_0_reqimfc0            (   timd_0_reqimfc0                                                                                                         )
     ,.timd_0_reqimfd0            (   timd_0_reqimfd0                                                                                                         )
     ,.timd_0_reqimfa1            (   timd_0_reqimfa1                                                                                                         )
     ,.timd_0_reqimfb1            (   timd_0_reqimfb1                                                                                                         )
     ,.timd_0_reqimfc1            (   timd_0_reqimfc1                                                                                                         )
     ,.timd_0_reqimfd1            (   timd_0_reqimfd1                                                                                                         )
     ,.timd_0_irreq0              (   timd_0_irreq0                                                                                                           )
     ,.timd_0_irreq1              (   timd_0_irreq1                                                                                                           )
     ,.rst_timj_0_res_n           (   rst_timj_0_res_n                                                                                                        )
     ,.clk_fsub                   (   clk_fsub                                                                                                                )
     ,.clk_fil_intrclk            (   clk_fil_intrclk                                                                                                         )
     ,.clk_timj_0_pclk            (   clk_timj_0_pclk                                                                                                         )
     ,.timj_0_prsclen             (   timj_0_prsclen                                                                                                          )
     ,.pt_timj_0_trjio_a          (   pt_timj_0_trjio_a                                                                                                       )
     ,.timj_0_trjo_k              (   timj_0_trjo_k                                                                                                           )
     ,.timj_0_trjio_k             (   timj_0_trjio_k                                                                                                          )
     ,.timj_0_reqirq_k            (   timj_0_reqirq_k                                                                                                         )
     ,.fpga_clk_oneshot_thr       (   pull_down0                                                                                                              )
     ,.fpga_clk_dlymeta           (   pull_down1                                                                                                              )
     ,.clk_adc_pclk               (   clk_adc_pclk                                                                                                            )
     ,.rst_adc_res_n              (   rst_adc_res_n                                                                                                           )
     ,.adc_reqpclk                (   adc_reqpclk                                                                                                             )
     ,.hadm_adc_adeocb            (   hadm_adc_adeocb                                                                                                         )
     ,.hadm_adc_adsar             (   hadm_adc_adsar[9:0]                                                                                                     )
     ,.adc_hadm_adclk             (   adc_hadm_adclk                                                                                                          )
     ,.adc_hadm_adpdb             (   adc_hadm_adpdb                                                                                                          )
     ,.adc_hadm_adbionb           (   adc_hadm_adbionb                                                                                                        )
     ,.adc_hadm_ads1              (   adc_hadm_ads1                                                                                                           )
     ,.adc_hadm_adofc             (   adc_hadm_adofc                                                                                                          )
     ,.adc_hadm_adcmp             (   adc_hadm_adcmp                                                                                                          )
     ,.adc_hadm_advselmod         (   adc_hadm_advselmod[1:0]                                                                                                 )
     ,.adc_hadm_adgselmod         (   adc_hadm_adgselmod                                                                                                      )
     ,.adc_hadm_adtesmod          (   adc_hadm_adtesmod[2:0]                                                                                                  )
     ,.adc_adcpon                 (   adc_adcpon                                                                                                              )
     ,.adc_adchsel                (   adc_adchsel[4:0]                                                                                                        )
     ,.adc_intad                  (   adc_intad                                                                                                               )
     ,.adc_bg2aden                (   adc_bg2aden                                                                                                             )
     ,.adc_bg2adsel               (   adc_bg2adsel                                                                                                            )
     ,.mod_tesdbt                 (   mod_tesdbt                                                                                                              )
`ifdef FPGA_ICE
     ,.adc_reg_adtyp              (   adc_reg_adtyp                                                                                                           )
`endif
     ,.rst_reset_n                (   rst_reset_n                                                                                                             )
     ,.rst_res_n                  (   rst_res_n                                                                                                               )
     ,.csc_resstp                 (   csc_resstp                                                                                                              )
     ,.clk_fmain                  (   clk_fmain                                                                                                               )
     ,.rst_scanres_n              (   rst_scanres_n                                                                                                           )
     ,.pcbz_pclbuz0               (   pcbz_pclbuz0                                                                                                            )
     ,.pcbz_pclbuz1               (   pcbz_pclbuz1                                                                                                            )
     ,.csc_rt0lpm                 (   csc_rt0lpm                                                                                                              )
     ,.clk_rtc_pclk               (   clk_rtc_pclk                                                                                                            )
     ,.rst_rtc_res_n              (   rst_rtc_res_n                                                                                                           )
     ,.clk_rtc_mclk               (   clk_rtc_mclk                                                                                                            )
     ,.clk_rtc_tclk               (   clk_rtc_tclk                                                                                                            )
     ,.pgcsc_cksel                (   pgcsc_cksel                                                                                                             )
     ,.mod_optbct                 (   mod_optbct                                                                                                              )
     ,.rtc_intrtc                 (   rtc_intrtc                                                                                                              )
     ,.rtc_intrtci                (   rtc_intrtci                                                                                                             )
     ,.rtc_clk1hz                 (   rtc_clk1hz                                                                                                              )
     ,.rtc_rt0mon0                (   rtc_rt0mon0                                                                                                             )
     ,.rtc_rt0mon1                (   rtc_rt0mon1                                                                                                             )
     ,.pt_krif_kr0                (   pt_krif_kr0                                                                                                             )
     ,.pt_krif_kr1                (   pt_krif_kr1                                                                                                             )
     ,.pt_krif_kr2                (   pt_krif_kr2                                                                                                             )
     ,.pt_krif_kr3                (   pt_krif_kr3                                                                                                             )
     ,.pt_krif_kr4                (   pt_krif_kr4                                                                                                             )
     ,.pt_krif_kr5                (   pt_krif_kr5                                                                                                             )
     ,.pt_krif_kr6                (   pt_krif_kr6                                                                                                             )
     ,.pt_krif_kr7                (   pt_krif_kr7                                                                                                             )
     ,.krif_intkr                 (   krif_intkr                                                                                                              )
     ,.bbr_bbrsub_apbmask         (   bbr_bbrsub_apbmask                                                                                                      )
     ,.bbr_bbrsub_psel1st         (   bbr_bbrsub_psel1st                                                                                                      )
     ,.bbr_bbrsub_psel2nd         (   bbr_bbrsub_psel2nd                                                                                                      )
     ,.bbr_penable                (   bbr_penable                                                                                                             )
     ,.bbrsub_peri_padr           (   bbrsub_peri_padr[10:0]                                                                                                  )
     ,.bbrsub_peri_penable        (   bbrsub_peri_penable                                                                                                     )
     ,.bbrsub_peri_pwdata         (   bbrsub_peri_pwdata[15:0]                                                                                                )
     ,.bbrsub_peri_pwrite         (   bbrsub_peri_pwrite                                                                                                      )
     ,.bbrsub_prdata              (   bbrsub_prdata[15:0]                                                                                                     )
     ,.bbrsub_pt_pselporga        (   bbrsub_pt_pselporga                                                                                                     )
     ,.bbrsub_pt_pselport         (   bbrsub_pt_pselport                                                                                                      )
     ,.bbrsub_pt_pselport2        (   bbrsub_pt_pselport2                                                                                                     )
     ,.bbrsub_timd_0_pselal       (   bbrsub_timd_0_pselal                                                                                                    )
     ,.cibc_frqsel4               (   cibc_frqsel4                                                                                                            )
     ,.clk_dspclkrw               (   clk_dspclkrw                                                                                                            )
     ,.cpu_cpuwr                  (   cpu_cpuwr                                                                                                               )
     ,.cpu_ma                     (   cpu_ma[10:0]                                                                                                            )
     ,.cpu_mdw                    (   cpu_mdw[15:0]                                                                                                           )
     ,.cpu_wdop                   (   cpu_wdop                                                                                                                )
     ,.porga_gdint                (   porga_gdint                                                                                                             )
     ,.pt_prdata                  (   pt_prdata[15:0]                                                                                                         )
     ,.csc_cken                   (   csc_cken[15:1]                                                                                                          )
     ,.csc_per0                   (   csc_per0[7:0]                                                                                                           )
     ,.pgcsc_dscken1              (   pgcsc_dscken1                                                                                                           )
     ,.pgcsc_dscken2              (   pgcsc_dscken2                                                                                                           )
     ,.pgcsc_dscken3              (   pgcsc_dscken3                                                                                                           )
     ,.pgcsc_dscken5              (   pgcsc_dscken5                                                                                                           )
     ,.pgcsc_per14                (   pgcsc_per14                                                                                                             )
     ,.pt_ifil_intp1              (   pt_ifil_intp1                                                                                                           )
     ,.pt_ifil_intp2              (   pt_ifil_intp2                                                                                                           )
     ,.pt_ifil_intp3              (   pt_ifil_intp3                                                                                                           )
     ,.pt_ifil_intp4              (   pt_ifil_intp4                                                                                                           )
     ,.pt_ifil_intp5              (   pt_ifil_intp5                                                                                                           )
     ,.pt_ifil_intp6              (   pt_ifil_intp6                                                                                                           )
     ,.pt_ifil_intp7              (   pt_ifil_intp7                                                                                                           )
     ,.pt_ifil_intp8              (   pt_ifil_intp8                                                                                                           )
     ,.pt_ifil_intp9              (   pt_ifil_intp9                                                                                                           )
     ,.pt_ifil_intp10             (   pt_ifil_intp10                                                                                                          )
     ,.ifil_intp0                 (   ifil_intp0                                                                                                              )
     ,.ifil_intp1                 (   ifil_intp1                                                                                                              )
     ,.ifil_intp2                 (   ifil_intp2                                                                                                              )
     ,.ifil_intp3                 (   ifil_intp3                                                                                                              )
     ,.ifil_intp4                 (   ifil_intp4                                                                                                              )
     ,.ifil_intp5                 (   ifil_intp5                                                                                                              )
     ,.ifil_intp6                 (   ifil_intp6                                                                                                              )
     ,.ifil_intp7                 (   ifil_intp7                                                                                                              )
     ,.ifil_intp8                 (   ifil_intp8                                                                                                              )
     ,.ifil_intp9                 (   ifil_intp9                                                                                                              )
     ,.ifil_intp10                (   ifil_intp10                                                                                                             )
     ,.ifil_intp11                (   ifil_intp11                                                                                                             )
     ,.clk_fclkrt                 (   clk_fclkrt                                                                                                              )
     ,.porga_iawen                (   porga_iawen                                                                                                             )
     ,.porga_gdram                (   porga_gdram[1:0]                                                                                                        )
     ,.porga_gdcsc                (   porga_gdcsc                                                                                                             )
     ,.capmx_adtrig0              (   capmx_adtrig0                                                                                                           )
     ,.capmx_adtrig1              (   capmx_adtrig1                                                                                                           )
     ,.capmx_intrtcdis            (   capmx_intrtcdis                                                                                                         )
     ,.pt_sau_0_sin0              (   pt_sau_0_sin0                                                                                                           )
     ,.pt_ifil_intp0              (   pt_ifil_intp0                                                                                                           )
     ,.pt_ifil_intp11             (   pt_ifil_intp11                                                                                                          )
     ,.pt_lin3_0_rxd              (   pt_lin3_0_rxd                                                                                                           )
     ,.mod_oti00                  (   mod_oti00                                                                                                               )
     ,.clk_fil                    (   clk_fil                                                                                                                 )
     ,.clk_fmx                    (   clk_fmx                                                                                                                 )
     ,.pt_tau_0_tin1              (   pt_tau_0_tin1                                                                                                           )
     ,.clk_bbclkr                 (   clk_bbclkr                                                                                                              )
     ,.pt_tau_0_tin4              (   pt_tau_0_tin4                                                                                                           )
     ,.pt_tau_0_tin5              (   pt_tau_0_tin5                                                                                                           )
     ,.pt_tau_0_tin6              (   pt_tau_0_tin6                                                                                                           )
     ,.pt_tau_0_tin7              (   pt_tau_0_tin7                                                                                                           )
     ,.dtc_intdtc5                (   dtc_intdtc5                                                                                                             )
     ,.dtc_intdtc6                (   dtc_intdtc6                                                                                                             )
     ,.dtc_intdtc7                (   dtc_intdtc7                                                                                                             )
     ,.porga_intdtc5              (   porga_intdtc5                                                                                                           )
     ,.porga_intdtc6              (   porga_intdtc6                                                                                                           )
     ,.porga_intdtc7              (   porga_intdtc7                                                                                                           )
     ,.rst_comp_res_n             (   rst_comp_res_n                                                                                                          )
     ,.clk_comp_pclk              (   clk_comp_pclk                                                                                                           )
     ,.comp_cdfs                  (   comp_cdfs[1:0]                                                                                                          )
     ,.mod_tesinst                (   mod_tesinst                                                                                                             )
     ,.comp_cirq                  (   comp_cirq                                                                                                               )
     ,.comp_vcout                 (   comp_vcout                                                                                                              )
     ,.hcmp_cmpo                  (   hcmp_cmpo                                                                                                               )
     ,.comp_testsel               (   comp_testsel                                                                                                            )
     ,.comp_hcmpon                (   comp_hcmpon                                                                                                             )
     ,.comp_couten                (   comp_couten                                                                                                             )
     ,.comp_cmpsel0               (   comp_cmpsel0                                                                                                            )
     ,.comp_cmpsel1               (   comp_cmpsel1                                                                                                            )
     ,.comp_cmpsel2               (   comp_cmpsel2                                                                                                            )
     ,.comp_cmpsel3               (   comp_cmpsel3                                                                                                            )
     ,.comp_cvrs0                 (   comp_cvrs0                                                                                                              )
     ,.comp_cvrs1                 (   comp_cvrs1                                                                                                              )
     ,.clk_baseckhs               (   clk_baseckhs                                                                                                            )
     ,.rst_dac_res_n              (   rst_dac_res_n                                                                                                           )
     ,.clk_dac_pclk               (   clk_dac_pclk                                                                                                            )
     ,.pporga_dgen02              (   pporga_dgen02                                                                                                           )
     ,.pporga_dgen03              (   pull_down2                                                                                                              )
     ,.dac_dadata0                (   dac_dadata0[7:0]                                                                                                        )
     ,.dac_dadata1                (   dac_dadata1[7:0]                                                                                                        )
     ,.dac_dace0                  (   dac_dace0                                                                                                               )
     ,.dac_dace1                  (   dac_dace1                                                                                                               )
     ,.fpga_dac_clk0              (   fpga_dac_clk0                                                                                                           )
     ,.fpga_dac_clk1              (   fpga_dac_clk1                                                                                                           )
     ,.fpga_dac_dadata0           (   fpga_dac_dadata0[7:0]                                                                                                   )
     ,.fpga_dac_dadata1           (   fpga_dac_dadata1[7:0]                                                                                                   )
     ,.fpga_dac_dace0             (   fpga_dac_dace0                                                                                                          )
     ,.fpga_dac_dace1             (   fpga_dac_dace1                                                                                                          )
     ,.clk_rcn_pclk               (   clk_rcn_pclk                                                                                                            )
     ,.clk_rcn_clka_can           (   clk_rcn_clka_can                                                                                                        )
     ,.rst_rcn_presetz            (   rst_rcn_presetz                                                                                                         )
     ,.pt_crx_in                  (   pt_crx_in                                                                                                               )
     ,.cram_rcn_q                 (   cram_rcn_q[31:0]                                                                                                        )
     ,.cram_mtestout              (   cram_mtestout[15:0]                                                                                                     )
     ,.rcn_txclk                  (   rcn_txclk                                                                                                               )
     ,.rcn_ad_ram                 (   rcn_ad_ram[8:0]                                                                                                         )
     ,.rcn_bwnb_n                 (   rcn_bwnb_n[3:0]                                                                                                         )
     ,.rcn_cen_n                  (   rcn_cen_n                                                                                                               )
     ,.rcn_cherr_int              (   rcn_cherr_int                                                                                                           )
     ,.rcn_comfrx_int             (   rcn_comfrx_int                                                                                                          )
     ,.rcn_d                      (   rcn_d[31:0]                                                                                                             )
     ,.rcn_glerr_int              (   rcn_glerr_int                                                                                                           )
     ,.rcn_rxf_int                (   rcn_rxf_int                                                                                                             )
     ,.rcn_tx_int                 (   rcn_tx_int                                                                                                              )
     ,.rcn_wen_n                  (   rcn_wen_n                                                                                                               )
     ,.rcn_tx_out                 (   rcn_tx_out                                                                                                              )
     ,.clk_lin3_0_pclk            (   clk_lin3_0_pclk                                                                                                         )
     ,.clk_clkc                   (   clk_clkc                                                                                                                )
     ,.rst_lin3_0_res_n           (   rst_lin3_0_res_n                                                                                                        )
     ,.lin3_0_int_t               (   lin3_0_int_t                                                                                                            )
     ,.lin3_0_int_r               (   lin3_0_int_r                                                                                                            )
     ,.lin3_0_int_s               (   lin3_0_int_s                                                                                                            )
     ,.lin3_0_int_m               (   lin3_0_int_m                                                                                                            )
     ,.lin3_0_tx_out              (   lin3_0_tx_out                                                                                                           )
     ,.lin3_0_reqpclk             (   lin3_0_reqpclk                                                                                                          )
     ,.clk_sau_0_pclk             (   clk_sau_0_pclk                                                                                                          )
     ,.clk_c2c_pclk               (   clk_c2c_pclk                                                                                                            )
     ,.rst_c2c_res_n              (   rst_c2c_res_n                                                                                                           )
     ,.rst_sau_0_res_n            (   rst_sau_0_res_n                                                                                                         )
     ,.pt_sau_0_ssi0              (   pt_sau_0_ssi0                                                                                                           )
     ,.pt_sau_0_scki0             (   pt_sau_0_scki0                                                                                                          )
     ,.sau_0_sso0                 (   sau_0_sso0                                                                                                              )
     ,.sau_0_scko0                (   sau_0_scko0                                                                                                             )
     ,.sau_0_sout00               (   sau_0_sout00                                                                                                            )
     ,.sau_0_sout01               (   sau_0_sout01                                                                                                            )
     ,.pt_sau_0_sin1              (   pt_sau_0_sin1                                                                                                           )
     ,.pt_sau_0_ssi1              (   pt_sau_0_ssi1                                                                                                           )
     ,.pt_sau_0_scki1             (   pt_sau_0_scki1                                                                                                          )
     ,.sau_0_sso1                 (   sau_0_sso1                                                                                                              )
     ,.sau_0_scko1                (   sau_0_scko1                                                                                                             )
     ,.sau_0_sout10dly            (   sau_0_sout10dly                                                                                                         )
     ,.sau_0_sout11dly            (   sau_0_sout11dly                                                                                                         )
     ,.sau_0_intsau0              (   sau_0_intsau0                                                                                                           )
     ,.sau_0_seint0               (   sau_0_seint0                                                                                                            )
     ,.sau_0_intsau1              (   sau_0_intsau1                                                                                                           )
     ,.sau_0_seint1               (   sau_0_seint1                                                                                                            )
     ,.c2c_exbck                  (   c2c_exbck                                                                                                               )
     ,.c2c_exben                  (   c2c_exben                                                                                                               )
     ,.c2c_exbdir                 (   c2c_exbdir                                                                                                              )
     ,.pt_c2c_exbi                (   pt_c2c_exbi[3:0]                                                                                                        )
     ,.c2c_exbo                   (   c2c_exbo[3:0]                                                                                                           )
     ,.c2c_waitmem                (   c2c_waitmem                                                                                                             )
     ,.clk_sau_1_pclk             (   clk_sau_1_pclk                                                                                                          )
     ,.rst_sau_1_res_n            (   rst_sau_1_res_n                                                                                                         )
     ,.pt_sau_1_sin0              (   pt_sau_1_sin0                                                                                                           )
     ,.pt_sau_1_ssi0              (   pt_sau_1_ssi0                                                                                                           )
     ,.pt_sau_1_scki0             (   pt_sau_1_scki0                                                                                                          )
     ,.sau_1_sso0                 (   sau_1_sso0                                                                                                              )
     ,.sau_1_scko0                (   sau_1_scko0                                                                                                             )
     ,.sau_1_sout00               (   sau_1_sout00                                                                                                            )
     ,.sau_1_sout01               (   sau_1_sout01                                                                                                            )
     ,.pt_sau_1_sin1              (   pt_sau_1_sin1                                                                                                           )
     ,.pt_sau_1_ssi1              (   pt_sau_1_ssi1                                                                                                           )
     ,.pt_sau_1_scki1             (   pt_sau_1_scki1                                                                                                          )
     ,.sau_1_sso1                 (   sau_1_sso1                                                                                                              )
     ,.sau_1_scko1                (   sau_1_scko1                                                                                                             )
     ,.sau_1_sout10dly            (   sau_1_sout10dly                                                                                                         )
     ,.sau_1_sout11dly            (   sau_1_sout11dly                                                                                                         )
     ,.sau_1_intsau0              (   sau_1_intsau0                                                                                                           )
     ,.sau_1_seint0               (   sau_1_seint0                                                                                                            )
     ,.sau_1_intsau1              (   sau_1_intsau1                                                                                                           )
     ,.sau_1_seint1               (   sau_1_seint1                                                                                                            )
     );
//=================================================================
//===   crl78hportiotop_f14m : portiotop
//=================================================================
  crl78hportiotop_f14m  portiotop  (
      .pt_hadm_adinh_va           (   pt_hadm_adinh_va                                                                                                        )
     ,.P00                        (   P00                                                                                                                     )
     ,.P01                        (   P01                                                                                                                     )
     ,.P02                        (   P02                                                                                                                     )
     ,.P10                        (   P10                                                                                                                     )
     ,.P11                        (   P11                                                                                                                     )
     ,.P12                        (   P12                                                                                                                     )
     ,.P120                       (   P120                                                                                                                    )
     ,.P125                       (   P125                                                                                                                    )
     ,.P126                       (   P126                                                                                                                    )
     ,.P13                        (   P13                                                                                                                     )
     ,.P130                       (   P130                                                                                                                    )
     ,.P137                       (   P137                                                                                                                    )
     ,.P14                        (   P14                                                                                                                     )
     ,.P140                       (   P140                                                                                                                    )
     ,.P15                        (   P15                                                                                                                     )
     ,.P16                        (   P16                                                                                                                     )
     ,.P17                        (   P17                                                                                                                     )
     ,.P30                        (   P30                                                                                                                     )
     ,.P31                        (   P31                                                                                                                     )
     ,.P32                        (   P32                                                                                                                     )
     ,.P33                        (   P33                                                                                                                     )
     ,.P34                        (   P34                                                                                                                     )
     ,.P40                        (   P40                                                                                                                     )
     ,.P41                        (   P41                                                                                                                     )
     ,.P42                        (   P42                                                                                                                     )
     ,.P43                        (   P43                                                                                                                     )
     ,.P44                        (   P44                                                                                                                     )
     ,.P45                        (   P45                                                                                                                     )
     ,.P46                        (   P46                                                                                                                     )
     ,.P47                        (   P47                                                                                                                     )
     ,.P50                        (   P50                                                                                                                     )
     ,.P51                        (   P51                                                                                                                     )
     ,.P52                        (   P52                                                                                                                     )
     ,.P53                        (   P53                                                                                                                     )
     ,.P54                        (   P54                                                                                                                     )
     ,.P55                        (   P55                                                                                                                     )
     ,.P56                        (   P56                                                                                                                     )
     ,.P57                        (   P57                                                                                                                     )
     ,.P60                        (   P60                                                                                                                     )
     ,.P61                        (   P61                                                                                                                     )
     ,.P62                        (   P62                                                                                                                     )
     ,.P63                        (   P63                                                                                                                     )
     ,.P64                        (   P64                                                                                                                     )
     ,.P65                        (   P65                                                                                                                     )
     ,.P66                        (   P66                                                                                                                     )
     ,.P67                        (   P67                                                                                                                     )
     ,.P70                        (   P70                                                                                                                     )
     ,.P71                        (   P71                                                                                                                     )
     ,.P72                        (   P72                                                                                                                     )
     ,.P73                        (   P73                                                                                                                     )
     ,.P74                        (   P74                                                                                                                     )
     ,.P75                        (   P75                                                                                                                     )
     ,.P76                        (   P76                                                                                                                     )
     ,.P77                        (   P77                                                                                                                     )
     ,.P80                        (   P80                                                                                                                     )
     ,.P81                        (   P81                                                                                                                     )
     ,.P82                        (   P82                                                                                                                     )
     ,.P83                        (   P83                                                                                                                     )
     ,.P84                        (   P84                                                                                                                     )
     ,.P85                        (   P85                                                                                                                     )
     ,.P86                        (   P86                                                                                                                     )
     ,.P87                        (   P87                                                                                                                     )
     ,.P90                        (   P90                                                                                                                     )
     ,.P91                        (   P91                                                                                                                     )
     ,.P92                        (   P92                                                                                                                     )
     ,.P93                        (   P93                                                                                                                     )
     ,.P94                        (   P94                                                                                                                     )
     ,.P95                        (   P95                                                                                                                     )
     ,.P96                        (   P96                                                                                                                     )
     ,.P97                        (   P97                                                                                                                     )
     ,.pt_hads_p12adinlp_0_va     (   pt_hads_p120adinlp_va                                                                                                   )
     ,.pt_hads_p12adinlp_5_va     (   pt_hads_p125adinlp_va                                                                                                   )
     ,.pt_hads_p9adinlp_6_va      (   pt_hads_p96adinlp_va                                                                                                    )
     ,.pt_hads_p9adinlp_7_va      (   pt_hads_p97adinlp_va                                                                                                    )
     ,.pt_hcmp_ivcmp00_va         (   pt_hcmp_ivcmp00_va                                                                                                      )
     ,.pt_hcmp_ivcmp01_va         (   pt_hcmp_ivcmp01_va                                                                                                      )
     ,.pt_hcmp_ivcmp02_va         (   pt_hcmp_ivcmp02_va                                                                                                      )
     ,.pt_hcmp_ivcmp03_va         (   pt_hcmp_ivcmp03_va                                                                                                      )
     ,.pt_hcmp_ivref0_va          (   pt_hcmp_ivref0_va                                                                                                       )
     ,.pt_hflashcp_vpptsin_va     (   pt_hflashcp_vpptsin_va                                                                                                  )
     ,.cibc_opresout              (   cibc_selin1                                                                                                             )
     ,.adc_adchsel                (   adc_adchsel[4:0]                                                                                                        )
     ,.bbr_prdsel_pclm            (   bbr_prdsel_pclm[3:0]                                                                                                    )
     ,.bbrsub_peri_padr           (   bbrsub_peri_padr[6:0]                                                                                                   )
     ,.bbrsub_peri_penable        (   bbrsub_peri_penable                                                                                                     )
     ,.bbrsub_peri_pwdata         (   bbrsub_peri_pwdata[15:0]                                                                                                )
     ,.bbrsub_peri_pwrite         (   bbrsub_peri_pwrite                                                                                                      )
     ,.bbrsub_pt_pselporga        (   bbrsub_pt_pselporga                                                                                                     )
     ,.bbrsub_pt_pselport1        (   bbrsub_pt_pselport                                                                                                      )
     ,.bbrsub_pt_pselport2        (   bbrsub_pt_pselport2                                                                                                     )
     ,.clk_pclkrw                 (   clk_pclkrw                                                                                                              )
     ,.clk_scan                   (   clk_scan                                                                                                                )
     ,.clk_tau08_0_pclk           (   clk_tau_0_pclk                                                                                                          )
     ,.rst_tau08_0_res_n          (   rst_tau_0_res_n                                                                                                         )
     ,.clk_tau04_1_pclk           (   clk_tau_1_pclk                                                                                                          )
     ,.rst_tau04_1_res_n          (   rst_tau_1_res_n                                                                                                         )
     ,.comp_ivc0out               (   comp_vcout                                                                                                              )
     ,.csc_tselires               (   csc_tselires                                                                                                            )
     ,.csc_tseloreg               (   csc_tseloreg                                                                                                            )
     ,.csc_ttemp                  (   csc_ttemp                                                                                                               )
     ,.pgcsc_stopst_p31           (   stopst_p31                                                                                                              )
     ,.pgcsc_stopst_p52           (   stopst_p52                                                                                                              )
     ,.clk_timd_0_pclk            (   clk_timd_0_pclk                                                                                                         )
     ,.rst_timd_0_res_n           (   rst_timd_0_res_n                                                                                                        )
     ,.fcb_modidis                (   fcb_modidis                                                                                                             )
     ,.hdac_0_dacouthv            (   hdac_0_dacouthv_va                                                                                                      )
     ,.iic_0_sclo0                (   iic_0_sclo0                                                                                                             )
     ,.iic_0_sdao0                (   iic_0_sdao0                                                                                                             )
     ,.mod_gofirm                 (   mod_gofirm                                                                                                              )
     ,.mod_optoplrd               (   mod_optoplrd                                                                                                            )
     ,.mod_scanmode               (   mod_scanmode                                                                                                            )
     ,.mod_tdout0                 (   mod_tdout0                                                                                                              )
     ,.mod_tdout1                 (   mod_tdout1                                                                                                              )
     ,.mod_tdout2                 (   mod_tdout2                                                                                                              )
     ,.mod_tdout3                 (   mod_tdout3                                                                                                              )
     ,.mod_tdsel0r                (   mod_tdsel0r                                                                                                             )
     ,.mod_tdsel0t                (   mod_tdsel0t                                                                                                             )
     ,.mod_tdsel1r                (   mod_tdsel1r                                                                                                             )
     ,.mod_tdsel1t                (   mod_tdsel1t                                                                                                             )
     ,.mod_tdsel2r                (   mod_tdsel2r                                                                                                             )
     ,.mod_tdsel2t                (   mod_tdsel2t                                                                                                             )
     ,.mod_tdsel3                 (   mod_tdsel3                                                                                                              )
     ,.mod_tesdbt2                (   mod_tesdbt2                                                                                                             )
     ,.mod_teseni0r               (   mod_teseni0r                                                                                                            )
     ,.mod_teseni0t               (   mod_teseni0t                                                                                                            )
     ,.mod_teseni1r               (   mod_teseni1r                                                                                                            )
     ,.mod_teseni1t               (   mod_teseni1t                                                                                                            )
     ,.mod_teseni2r               (   mod_teseni2r                                                                                                            )
     ,.mod_teseni2t               (   mod_teseni2t                                                                                                            )
     ,.mod_teseni3                (   mod_teseni3                                                                                                             )
     ,.mod_teseni4                (   mod_teseni4                                                                                                             )
     ,.mod_teseno0r               (   mod_teseno0r                                                                                                            )
     ,.mod_teseno0t               (   mod_teseno0t                                                                                                            )
     ,.mod_teseno1r               (   mod_teseno1r                                                                                                            )
     ,.mod_teseno1t               (   mod_teseno1t                                                                                                            )
     ,.mod_teseno2r               (   mod_teseno2r                                                                                                            )
     ,.mod_teseno2t               (   mod_teseno2t                                                                                                            )
     ,.mod_teseno3                (   mod_teseno3                                                                                                             )
     ,.cibc_opocden               (   cibc_opocden                                                                                                            )
     ,.ocd_ocdmod                 (   ocd_ocdmod                                                                                                              )
     ,.ocd_sltrxtx                (   ocd_sltrxtx                                                                                                             )
     ,.ocd_sprgmod                (   ocd_sprgmod                                                                                                             )
     ,.ocd_hpimod                 (   ocd_hpimod                                                                                                              )
     ,.ocd_txocd                  (   ocd_txocd                                                                                                               )
     ,.hhoco_oregout_va           (   hhoco_oregout_va                                                                                                        )
     ,.oscm_x1din                 (   oscm_x1din                                                                                                              )
     ,.oscm_x2din                 (   oscm_x2din                                                                                                              )
     ,.oscs_xt1din                (   oscs_xt1din                                                                                                             )
     ,.oscs_xt2din                (   oscs_xt2din                                                                                                             )
     ,.pcbz_pclbuz0               (   pcbz_pclbuz0                                                                                                            )
     ,.regm_pocrel_v5             (   regm_pocrel_v5                                                                                                          )
     ,.rst_nsres_n                (   rst_nsres_n                                                                                                             )
     ,.rst_res_n                  (   rst_res_n                                                                                                               )
     ,.rst_sysrsout_n             (   pull_down3                                                                                                              )
     ,.rtc_clk1hz                 (   rtc_clk1hz                                                                                                              )
     ,.sau_0_scko0                (   sau_0_scko0                                                                                                             )
     ,.sau_0_scko1                (   sau_0_scko1                                                                                                             )
     ,.sau_0_sout00               (   sau_0_sout00                                                                                                            )
     ,.sau_0_sout01               (   sau_0_sout01                                                                                                            )
     ,.sau_0_sout10dly            (   sau_0_sout10dly                                                                                                         )
     ,.sau_0_sout11dly            (   sau_0_sout11dly                                                                                                         )
     ,.sau_0_sso0                 (   sau_0_sso0                                                                                                              )
     ,.sau_0_sso1                 (   sau_0_sso1                                                                                                              )
     ,.sau_1_scko0                (   sau_1_scko0                                                                                                             )
     ,.sau_1_scko1                (   sau_1_scko1                                                                                                             )
     ,.sau_1_sout00               (   sau_1_sout00                                                                                                            )
     ,.sau_1_sout01               (   sau_1_sout01                                                                                                            )
     ,.sau_1_sso0                 (   sau_1_sso0                                                                                                              )
     ,.sau_1_sso1                 (   sau_1_sso1                                                                                                              )
     ,.sau_1_sout10dly            (   sau_1_sout10dly                                                                                                         )
     ,.sau_1_sout11dly            (   sau_1_sout11dly                                                                                                         )
     ,.can_0_tx_out               (   rcn_tx_out                                                                                                              )
     ,.can_0_cn_i_dbg_txclk       (   rcn_txclk                                                                                                               )
     ,.lin_0_tx_out               (   lin3_0_tx_out                                                                                                           )
     ,.tau_0_tout0                (   tau_0_tout0                                                                                                             )
     ,.tau_0_tout1                (   tau_0_tout1                                                                                                             )
     ,.tau_0_tout2                (   tau_0_tout2                                                                                                             )
     ,.tau_0_tout3                (   tau_0_tout3                                                                                                             )
     ,.tau_0_tout4                (   tau_0_tout4                                                                                                             )
     ,.tau_0_tout5                (   tau_0_tout5                                                                                                             )
     ,.tau_0_tout6                (   tau_0_tout6                                                                                                             )
     ,.tau_0_tout7                (   tau_0_tout7                                                                                                             )
     ,.tau_1_tout0                (   tau_1_tout0                                                                                                             )
     ,.tau_1_tout1                (   tau_1_tout1                                                                                                             )
     ,.tau_1_tout2                (   tau_1_tout2                                                                                                             )
     ,.tau_1_tout3                (   tau_1_tout3                                                                                                             )
     ,.timd_0_ftoa0               (   timd_0_ftoa0                                                                                                            )
     ,.timd_0_ftoa0_hizsel        (   timd_0_ftoa0_hizsel                                                                                                     )
     ,.timd_0_ftoa1               (   timd_0_ftoa1                                                                                                            )
     ,.timd_0_ftoa1_hizsel        (   timd_0_ftoa1_hizsel                                                                                                     )
     ,.timd_0_ftob0               (   timd_0_ftob0                                                                                                            )
     ,.timd_0_ftob0_hizsel        (   timd_0_ftob0_hizsel                                                                                                     )
     ,.timd_0_ftob1               (   timd_0_ftob1                                                                                                            )
     ,.timd_0_ftob1_hizsel        (   timd_0_ftob1_hizsel                                                                                                     )
     ,.timd_0_ftoc0               (   timd_0_ftoc0                                                                                                            )
     ,.timd_0_ftoc0_hizsel        (   timd_0_ftoc0_hizsel                                                                                                     )
     ,.timd_0_ftoc1               (   timd_0_ftoc1                                                                                                            )
     ,.timd_0_ftoc1_hizsel        (   timd_0_ftoc1_hizsel                                                                                                     )
     ,.timd_0_ftod0               (   timd_0_ftod0                                                                                                            )
     ,.timd_0_ftod0_hizsel        (   timd_0_ftod0_hizsel                                                                                                     )
     ,.timd_0_ftod1               (   timd_0_ftod1                                                                                                            )
     ,.timd_0_ftod1_hizsel        (   timd_0_ftod1_hizsel                                                                                                     )
     ,.timj_0_trjio_k             (   timj_0_trjio_k                                                                                                          )
     ,.timj_0_trjo_k              (   timj_0_trjo_k                                                                                                           )
     ,.c2cexben                   (   c2c_exben                                                                                                               )
     ,.c2cexbdir                  (   c2c_exbdir                                                                                                              )
     ,.c2cexbck                   (   c2c_exbck                                                                                                               )
     ,.c2cexbo3                   (   c2c_exbo[3]                                                                                                             )
     ,.c2cexbo2                   (   c2c_exbo[2]                                                                                                             )
     ,.c2cexbo1                   (   c2c_exbo[1]                                                                                                             )
     ,.c2cexbo0                   (   c2c_exbo[0]                                                                                                             )
     ,.pt_hadcorn_sw_adchsel      (   {pt_hadcorn_adchsel4sw, pt_hadcorn_adchsel3sw, pt_hadcorn_adchsel2sw, pt_hadcorn_adchsel1sw, pt_hadcorn_adchsel0sw}     )
     ,.pt_hads_adcponl_v5         (   pt_hads_adcponl_v5                                                                                                      )
     ,.pt_hadm_ads1bmuxl_v5       (   pt_hadm_ads1bmuxl_v5                                                                                                    )
     ,.pt_hadm_ads1dbmuxl_v5      (   pt_hadm_ads1dbmuxl_v5                                                                                                   )
     ,.fpga_pio0                  (   /*fpga_pio0*/                                                                                                           )
     ,.fpga_pio1                  (   /*fpga_pio1*/                                                                                                           )
     ,.fpga_pio3                  (   /*fpga_pio3*/                                                                                                           )
     ,.fpga_pio4                  (   /*fpga_pio4*/                                                                                                           )
     ,.fpga_pio5                  (   /*fpga_pio5*/                                                                                                           )
     ,.fpga_pio6                  (   /*fpga_pio6*/                                                                                                           )
     ,.fpga_pio7                  (   /*fpga_pio7*/                                                                                                           )
     ,.fpga_pio8                  (   /*fpga_pio8*/                                                                                                           )
     ,.fpga_pio9                  (   /*fpga_pio9*/                                                                                                           )
     ,.fpga_pio12                 (   /*fpga_pio12*/                                                                                                          )
     ,.fpga_pio13_0               (   /*fpga_pio13*/                                                                                                          )
     ,.fpga_pio13_7               (   /*fpga_pio13*/                                                                                                          )
     ,.fpga_pio14_0               (   /*fpga_pio14*/                                                                                                          )
     ,.pt_hadm_adchsel0bl_v5      (   pt_hadm_adchsel0bl_v5                                                                                                   )
     ,.pt_hadm_adchsel0l_v5       (   pt_hadm_adchsel0l_v5                                                                                                    )
     ,.pt_hadm_adchsel1bl_v5      (   pt_hadm_adchsel1bl_v5                                                                                                   )
     ,.pt_hadm_adchsel1l_v5       (   pt_hadm_adchsel1l_v5                                                                                                    )
     ,.pt_hadm_adchsel2bl_v5      (   pt_hadm_adchsel2bl_v5                                                                                                   )
     ,.pt_hadm_adchsel2l_v5       (   pt_hadm_adchsel2l_v5                                                                                                    )
     ,.pt_hadm_adchsel3bl_v5      (   pt_hadm_adchsel3bl_v5                                                                                                   )
     ,.pt_hadm_adchsel3l_v5       (   pt_hadm_adchsel3l_v5                                                                                                    )
     ,.pt_hadm_adchsel4bl_v5      (   pt_hadm_adchsel4bl_v5                                                                                                   )
     ,.pt_hadm_adchsel4l_v5       (   pt_hadm_adchsel4l_v5                                                                                                    )
     ,.pt_hadm_avrefmc_v5         (   pt_hadm_avrefmc_v5                                                                                                      )
     ,.pt_hadm_avrefmr_v5         (   pt_hadm_avrefmr_v5                                                                                                      )
     ,.pt_hadm_avrefpc_v5         (   pt_hadm_avrefpc_v5                                                                                                      )
     ,.pt_hadm_avrefpr_v5         (   pt_hadm_avrefpr_v5                                                                                                      )
     ,.pt_ifil_intp0              (   pt_ifil_intp0                                                                                                           )
     ,.pt_ifil_intp1              (   pt_ifil_intp1                                                                                                           )
     ,.pt_ifil_intp10             (   pt_ifil_intp10                                                                                                          )
     ,.pt_ifil_intp11             (   pt_ifil_intp11                                                                                                          )
     ,.pt_ifil_intp2              (   pt_ifil_intp2                                                                                                           )
     ,.pt_ifil_intp3              (   pt_ifil_intp3                                                                                                           )
     ,.pt_ifil_intp4              (   pt_ifil_intp4                                                                                                           )
     ,.pt_ifil_intp5              (   pt_ifil_intp5                                                                                                           )
     ,.pt_ifil_intp6              (   pt_ifil_intp6                                                                                                           )
     ,.pt_ifil_intp7              (   pt_ifil_intp7                                                                                                           )
     ,.pt_ifil_intp8              (   pt_ifil_intp8                                                                                                           )
     ,.pt_ifil_intp9              (   pt_ifil_intp9                                                                                                           )
     ,.pt_iic_0_scli0             (   pt_iic_0_scli0                                                                                                          )
     ,.pt_iic_0_sdai0             (   pt_iic_0_sdai0                                                                                                          )
     ,.pt_krif_kr0                (   pt_krif_kr0                                                                                                             )
     ,.pt_krif_kr1                (   pt_krif_kr1                                                                                                             )
     ,.pt_krif_kr2                (   pt_krif_kr2                                                                                                             )
     ,.pt_krif_kr3                (   pt_krif_kr3                                                                                                             )
     ,.pt_krif_kr4                (   pt_krif_kr4                                                                                                             )
     ,.pt_krif_kr5                (   pt_krif_kr5                                                                                                             )
     ,.pt_krif_kr6                (   pt_krif_kr6                                                                                                             )
     ,.pt_krif_kr7                (   pt_krif_kr7                                                                                                             )
     ,.pt_mod_hvin                (   pt_mod_hvin                                                                                                             )
     ,.pt_mod_routsrc10           (   pt_mod_routsrc10                                                                                                        )
     ,.pt_mod_routsrc12           (   pt_mod_routsrc12                                                                                                        )
     ,.pt_mod_tdin0r              (   pt_mod_tdin0r                                                                                                           )
     ,.pt_mod_tdin0t              (   pt_mod_tdin0t                                                                                                           )
     ,.pt_mod_tdin1r              (   pt_mod_tdin1r                                                                                                           )
     ,.pt_mod_tdin1t              (   pt_mod_tdin1t                                                                                                           )
     ,.pt_mod_tdin2r              (   pt_mod_tdin2r                                                                                                           )
     ,.pt_mod_tdin2t              (   pt_mod_tdin2t                                                                                                           )
     ,.pt_mod_tdin3               (   pt_mod_tdin3                                                                                                            )
     ,.pt_mod_tdin4               (   pt_mod_tdin4                                                                                                            )
     ,.pt_mod_tdin5               (   pt_mod_tdin5                                                                                                            )
     ,.pt_mod_tin00               (   pt_mod_tin00                                                                                                            )
     ,.pt_ocd_toolrx              (   pt_ocd_toolrx                                                                                                           )
     ,.pt_oscm_x1eni              (   pt_oscm_x1eni                                                                                                           )
     ,.pt_oscm_x2eni              (   pt_oscm_x2eni                                                                                                           )
     ,.pt_oscs_xt1eni             (   pt_oscs_xt1eni                                                                                                          )
     ,.pt_oscs_xt2eni             (   pt_oscs_xt2eni                                                                                                          )
     ,.pt_prdata                  (   pt_prdata[15:0]                                                                                                         )
     ,.pt_sau_0_scki0             (   pt_sau_0_scki0                                                                                                          )
     ,.pt_sau_0_scki1             (   pt_sau_0_scki1                                                                                                          )
     ,.pt_sau_0_sin0              (   pt_sau_0_sin0                                                                                                           )
     ,.pt_sau_0_sin1              (   pt_sau_0_sin1                                                                                                           )
     ,.pt_sau_0_ssi0              (   pt_sau_0_ssi0                                                                                                           )
     ,.pt_sau_0_ssi1              (   pt_sau_0_ssi1                                                                                                           )
     ,.pt_sau_1_scki0             (   pt_sau_1_scki0                                                                                                          )
     ,.pt_sau_1_scki1             (   pt_sau_1_scki1                                                                                                          )
     ,.pt_sau_1_sin0              (   pt_sau_1_sin0                                                                                                           )
     ,.pt_sau_1_sin1              (   pt_sau_1_sin1                                                                                                           )
     ,.pt_sau_1_ssi0              (   pt_sau_1_ssi0                                                                                                           )
     ,.pt_sau_1_ssi1              (   pt_sau_1_ssi1                                                                                                           )
     ,.pt_can_0_crx_in            (   pt_crx_in                                                                                                               )
     ,.pt_can_0_crx_in_int        (   pt_crx_in_int                                                                                                           )
     ,.rst_rcn_presetz            (   rst_rcn_presetz                                                                                                         )
     ,.pt_lin_0_rxd               (   pt_lin3_0_rxd                                                                                                           )
     ,.pt_ocd_rxocd               (   pt_ocd_rxocd                                                                                                            )
     ,.pt_tau_0_tin1              (   pt_tau_0_tin1                                                                                                           )
     ,.pt_tau_0_tin2              (   pt_tau_0_tin2                                                                                                           )
     ,.pt_tau_0_tin3              (   pt_tau_0_tin3                                                                                                           )
     ,.pt_tau_0_tin4              (   pt_tau_0_tin4                                                                                                           )
     ,.pt_tau_0_tin5              (   pt_tau_0_tin5                                                                                                           )
     ,.pt_tau_0_tin6              (   pt_tau_0_tin6                                                                                                           )
     ,.pt_tau_0_tin7              (   pt_tau_0_tin7                                                                                                           )
     ,.pt_tau_1_tin0              (   pt_tau_1_tin0                                                                                                           )
     ,.pt_tau_1_tin1              (   pt_tau_1_tin1                                                                                                           )
     ,.pt_tau_1_tin2              (   pt_tau_1_tin2                                                                                                           )
     ,.pt_tau_1_tin3              (   pt_tau_1_tin3                                                                                                           )
     ,.pt_timd_0_trdioa0_a        (   pt_timd_0_trdioa0_a                                                                                                     )
     ,.pt_timd_0_trdioa1_a        (   pt_timd_0_trdioa1_a                                                                                                     )
     ,.pt_timd_0_trdiob0_a        (   pt_timd_0_trdiob0_a                                                                                                     )
     ,.pt_timd_0_trdiob1_a        (   pt_timd_0_trdiob1_a                                                                                                     )
     ,.pt_timd_0_trdioc0_a        (   pt_timd_0_trdioc0_a                                                                                                     )
     ,.pt_timd_0_trdioc1_a        (   pt_timd_0_trdioc1_a                                                                                                     )
     ,.pt_timd_0_trdiod0_a        (   pt_timd_0_trdiod0_a                                                                                                     )
     ,.pt_timd_0_trdiod1_a        (   pt_timd_0_trdiod1_a                                                                                                     )
     ,.pt_timj_0_trjio_a          (   pt_timj_0_trjio_a                                                                                                       )
     ,.pt_hadm_rtbf_v5            (   pt_hadm_rtbf_v5                                                                                                         )
     ,.sel08p                     (   pporga_cap_sel08p                                                                                                       )
     ,.pt_dgen02                  (   pporga_dgen02                                                                                                           )
     ,.pt_c2cexbi3                (   pt_c2c_exbi[3]                                                                                                          )
     ,.pt_c2cexbi2                (   pt_c2c_exbi[2]                                                                                                          )
     ,.pt_c2cexbi1                (   pt_c2c_exbi[1]                                                                                                          )
     ,.pt_c2cexbi0                (   pt_c2c_exbi[0]                                                                                                          )
     ,.rst_rtbfg_n_v5             (   rst_rtbfg_n_v5                                                                                                          )
     ,.hadcorn_adchsel0g_v5       (   hadcorn_adchsel0g_v5                                                                                                    )
     ,.hadcorn_adchsel1g_v5       (   hadcorn_adchsel1g_v5                                                                                                    )
     ,.hadcorn_adchsel2g_v5       (   hadcorn_adchsel2g_v5                                                                                                    )
     ,.hadcorn_adchsel3g_v5       (   hadcorn_adchsel3g_v5                                                                                                    )
     ,.hadcorn_adchsel4g_v5       (   hadcorn_adchsel4g_v5                                                                                                    )
     ,.hadcorn_adchsel0bg_v5      (   hadcorn_adchsel0bg_v5                                                                                                   )
     ,.hadcorn_adchsel1bg_v5      (   hadcorn_adchsel1bg_v5                                                                                                   )
     ,.hadcorn_adchsel2bg_v5      (   hadcorn_adchsel2bg_v5                                                                                                   )
     ,.hadcorn_adchsel3bg_v5      (   hadcorn_adchsel3bg_v5                                                                                                   )
     ,.hadcorn_adchsel4bg_v5      (   hadcorn_adchsel4bg_v5                                                                                                   )
     ,.hadcorn_ads1bmuxg_v5       (   hadcorn_ads1bmuxg_v5                                                                                                    )
     ,.hadcorn_ads1dbmuxg_v5      (   hadcorn_ads1dbmuxg_v5                                                                                                   )
     ,.hadcorn_adcpong_v5         (   hadcorn_adcpong_v5                                                                                                      )
     ,.cmp_testo_va               (   hcmp_pt_testo                                                                                                           )
     ,.comp_testsel               (   comp_testsel                                                                                                            )
     ,.fpga_swapon                (   pull_up0                                                                                                                )
     ,.fpga_clk60mhz              (   fpga_clk60mhz                                                                                                           )
     ,.fpga_dgen                  (   fpga_dgen[15:0]                                                                                                         )
`ifdef RL78_GATEUSE
     ,.mod_scanen                 (   mod_scanen                                                                                                              )
`endif
     );
//=================================================================
//===   crl78hcanram_wrap1 : canramwrap
//=================================================================
  crl78hcanram_wrap1  canramwrap  (
      .clk_rcn_pclk               (   clk_rcn_pclk                                                                                                            )
     ,.rst_rcn_presetz            (   rst_rcn_presetz                                                                                                         )
     ,.rcn_cen_n                  (   rcn_cen_n                                                                                                               )
     ,.rcn_wen_n                  (   rcn_wen_n                                                                                                               )
     ,.rcn_bwnb_n                 (   rcn_bwnb_n[3:0]                                                                                                         )
     ,.rcn_ad_ram                 (   rcn_ad_ram[7:0]                                                                                                         )
     ,.rcn_d                      (   rcn_d[31:0]                                                                                                             )
     ,.cram_rcn_q                 (   cram_rcn_q[31:0]                                                                                                        )
     ,.clk_scan                   (   clk_scan                                                                                                                )
     ,.mod_scanmode               (   mod_scanmode                                                                                                            )
     ,.mod_tesdbt                 (   mod_tesdbt                                                                                                              )
     ,.mod_seltar                 (   mod_seltar                                                                                                              )
     ,.csc_tstn                   (   csc_tstn                                                                                                                )
     ,.mod_moderd                 (   mod_moderd                                                                                                              )
     ,.mod_modewr                 (   mod_modewr                                                                                                              )
     ,.mod_incdecws               (   {mod_incdecws1,mod_incdecws0}                                                                                           )
     ,.mod_ta                     (   mod_ta[16:0]                                                                                                            )
     ,.mod_modenop                (   mod_modenop                                                                                                             )
     ,.fcb_dw                     (   fcb_dw[31:0]                                                                                                            )
     ,.ramif_rcn_cmt              (   ramif_rcn_cmt                                                                                                           )
     ,.cram_mtestout              (   cram_mtestout[15:0]                                                                                                     )
     );
//=================================================================
//===   umf30QAHCMP2 : hcmp
//=================================================================
  umf30QAHCMP2  hcmp  (
      .AIN5V0                     (   pt_hcmp_ivcmp00_va                                                                                                      )
     ,.AIN5V1                     (   pt_hcmp_ivcmp01_va                                                                                                      )
     ,.AIN5V2                     (   pt_hcmp_ivcmp02_va                                                                                                      )
     ,.AIN5V3                     (   pt_hcmp_ivcmp03_va                                                                                                      )
     ,.IVREF0                     (   pt_hcmp_ivref0_va                                                                                                       )
     ,.IVREF1                     (   hdac_0_dacouthv_va                                                                                                      )
     ,.RSTB5V                     (   regm_pocrel_v5                                                                                                          )
     ,.CVRS0                      (   comp_cvrs0                                                                                                              )
     ,.CVRS1                      (   comp_cvrs1                                                                                                              )
     ,.CMPEN                      (   comp_hcmpon                                                                                                             )
     ,.COUTEN                     (   comp_couten                                                                                                             )
     ,.CMPSEL0                    (   comp_cmpsel0                                                                                                            )
     ,.CMPSEL1                    (   comp_cmpsel1                                                                                                            )
     ,.CMPSEL2                    (   comp_cmpsel2                                                                                                            )
     ,.CMPSEL3                    (   comp_cmpsel3                                                                                                            )
     ,.CMPO                       (   hcmp_cmpo                                                                                                               )
     ,.TESTSEL                    (   comp_testsel                                                                                                            )
     ,.TESTO                      (   hcmp_pt_testo                                                                                                           )
     );
//=================================================================
//===   QAHAD21SW24V1 : adsw24
//=================================================================
  QAHAD21SW24V1  adsw24  (
      .ADINLP5V                   (   pt_hads_p125adinlp_va                                                                                                   )
     );
//=================================================================
//===   QAHAD21SW25V1 : adsw25
//=================================================================
  QAHAD21SW25V1  adsw25  (
      .ADINLP5V                   (   pt_hads_p120adinlp_va                                                                                                   )
     );
//=================================================================
//===   QAHAD21SW26V1 : adsw26
//=================================================================
  QAHAD21SW26V1  adsw26  (
      .ADINLP5V                   (   pt_hads_p96adinlp_va                                                                                                    )
     );
//=================================================================
//===   QAHAD21SW27V1 : adsw27
//=================================================================
  QAHAD21SW27V1  adsw27  (
      .ADINLP5V                   (   pt_hads_p97adinlp_va                                                                                                    )
     );
//=================================================================
//===   QAHAD21SWL1V1 : adswcap
//=================================================================
  QAHAD21SWL1V1  adswcap  (
      .ADINL5V                    (   hads_adinl_va                                                                                                           )
     ,.ADCHSEL4L5V                (   pt_hadm_adchsel4l_v5                                                                                                    )
     ,.ADCHSEL3L5V                (   pt_hadm_adchsel3l_v5                                                                                                    )
     ,.ADCHSEL2L5V                (   pt_hadm_adchsel2l_v5                                                                                                    )
     ,.ADCHSEL1L5V                (   pt_hadm_adchsel1l_v5                                                                                                    )
     ,.ADCHSEL0L5V                (   pt_hadm_adchsel0l_v5                                                                                                    )
     ,.ADCHSELB4L5V               (   pt_hadm_adchsel4bl_v5                                                                                                   )
     ,.ADCHSELB3L5V               (   pt_hadm_adchsel3bl_v5                                                                                                   )
     ,.ADCHSELB2L5V               (   pt_hadm_adchsel2bl_v5                                                                                                   )
     ,.ADCHSELB1L5V               (   pt_hadm_adchsel1bl_v5                                                                                                   )
     ,.ADCHSELB0L5V               (   pt_hadm_adchsel0bl_v5                                                                                                   )
     ,.ADS1BMUXL5V                (   pt_hadm_ads1bmuxl_v5                                                                                                    )
     ,.ADS1DBMUXL5V               (   pt_hadm_ads1dbmuxl_v5                                                                                                   )
     ,.ADCPONL5V                  (   pt_hads_adcponl_v5                                                                                                      )
     );
//=================================================================
//===   QAHADA21HN0V1 : adhard
//=================================================================
  QAHADA21HN0V1  adhard  (
      .ADCLK                      (   adc_hadm_adclk                                                                                                          )
     ,.ADPDB                      (   adc_hadm_adpdb                                                                                                          )
     ,.PRESETZ                    (   rst_adc_res_n                                                                                                           )
     ,.ADBIONB                    (   adc_hadm_adbionb                                                                                                        )
     ,.ADCPON                     (   adc_adcpon                                                                                                              )
     ,.ADS1                       (   adc_hadm_ads1                                                                                                           )
     ,.ADINL5V                    (   hads_adinl_va                                                                                                           )
     ,.ADINH5V                    (   pt_hadm_adinh_va                                                                                                        )
     ,.RTBF5V                     (   pt_hadm_rtbf_v5                                                                                                         )
     ,.ADOFC                      (   adc_hadm_adofc                                                                                                          )
     ,.ADCMP                      (   adc_hadm_adcmp                                                                                                          )
     ,.ADVSELMOD1                 (   adc_hadm_advselmod[1]                                                                                                   )
     ,.ADVSELMOD0                 (   adc_hadm_advselmod[0]                                                                                                   )
     ,.ADGSELMOD                  (   adc_hadm_adgselmod                                                                                                      )
     ,.ADTESMOD2                  (   adc_hadm_adtesmod[2]                                                                                                    )
     ,.ADTESMOD1                  (   adc_hadm_adtesmod[1]                                                                                                    )
     ,.ADTESMOD0                  (   adc_hadm_adtesmod[0]                                                                                                    )
     ,.ADSAR9                     (   hadm_adc_adsar[9]                                                                                                       )
     ,.ADSAR8                     (   hadm_adc_adsar[8]                                                                                                       )
     ,.ADSAR7                     (   hadm_adc_adsar[7]                                                                                                       )
     ,.ADSAR6                     (   hadm_adc_adsar[6]                                                                                                       )
     ,.ADSAR5                     (   hadm_adc_adsar[5]                                                                                                       )
     ,.ADSAR4                     (   hadm_adc_adsar[4]                                                                                                       )
     ,.ADSAR3                     (   hadm_adc_adsar[3]                                                                                                       )
     ,.ADSAR2                     (   hadm_adc_adsar[2]                                                                                                       )
     ,.ADSAR1                     (   hadm_adc_adsar[1]                                                                                                       )
     ,.ADSAR0                     (   hadm_adc_adsar[0]                                                                                                       )
     ,.ADEOCB                     (   hadm_adc_adeocb                                                                                                         )
     ,.ADS1MUX                    (   hadm_ads1mux                                                                                                            )
     ,.AVREFPC                    (   pt_hadm_avrefpc_v5                                                                                                      )
     ,.AVREFPR                    (   pt_hadm_avrefpr_v5                                                                                                      )
     ,.AVREFMC                    (   pt_hadm_avrefmc_v5                                                                                                      )
     ,.AVREFMR                    (   pt_hadm_avrefmr_v5                                                                                                      )
     ,.VBG2AD                     (   regm_vbg2ad                                                                                                             )
     ,.ADS1BMUXL5V                (   pt_hadm_ads1bmuxl_v5                                                                                                    )
     ,.ADS1DBMUXL5V               (   pt_hadm_ads1dbmuxl_v5                                                                                                   )
     ,.ADCHSEL0L5V                (   pt_hadm_adchsel0l_v5                                                                                                    )
     ,.ADCHSEL1L5V                (   pt_hadm_adchsel1l_v5                                                                                                    )
     ,.ADCHSEL2L5V                (   pt_hadm_adchsel2l_v5                                                                                                    )
     ,.ADCHSEL3L5V                (   pt_hadm_adchsel3l_v5                                                                                                    )
     ,.ADCHSEL4L5V                (   pt_hadm_adchsel4l_v5                                                                                                    )
     );
//=================================================================
//===   QICTRAHAH5 : adcorner
//=================================================================
  QICTRAHAH5  adcorner  (
      .ADCHSEL0                   (   pt_hadcorn_adchsel0sw                                                                                                   )
     ,.ADCHSEL1                   (   pt_hadcorn_adchsel1sw                                                                                                   )
     ,.ADCHSEL2                   (   pt_hadcorn_adchsel2sw                                                                                                   )
     ,.ADCHSEL3                   (   pt_hadcorn_adchsel3sw                                                                                                   )
     ,.ADCHSEL4                   (   pt_hadcorn_adchsel4sw                                                                                                   )
     ,.ADCPON                     (   adc_adcpon                                                                                                              )
     ,.ADS1MUX                    (   hadm_ads1mux                                                                                                            )
     ,.RTBFG                      (   rst_rtbfg_n_v5                                                                                                          )
     ,.ADCHSEL0G                  (   hadcorn_adchsel0g_v5                                                                                                    )
     ,.ADCHSEL1G                  (   hadcorn_adchsel1g_v5                                                                                                    )
     ,.ADCHSEL2G                  (   hadcorn_adchsel2g_v5                                                                                                    )
     ,.ADCHSEL3G                  (   hadcorn_adchsel3g_v5                                                                                                    )
     ,.ADCHSEL4G                  (   hadcorn_adchsel4g_v5                                                                                                    )
     ,.ADCHSEL0BG                 (   hadcorn_adchsel0bg_v5                                                                                                   )
     ,.ADCHSEL1BG                 (   hadcorn_adchsel1bg_v5                                                                                                   )
     ,.ADCHSEL2BG                 (   hadcorn_adchsel2bg_v5                                                                                                   )
     ,.ADCHSEL3BG                 (   hadcorn_adchsel3bg_v5                                                                                                   )
     ,.ADCHSEL4BG                 (   hadcorn_adchsel4bg_v5                                                                                                   )
     ,.ADS1BMUXG                  (   hadcorn_ads1bmuxg_v5                                                                                                    )
     ,.ADS1DBMUXG                 (   hadcorn_ads1dbmuxg_v5                                                                                                   )
     ,.ADCPONG                    (   hadcorn_adcpong_v5                                                                                                      )
     );
//=================================================================
//===   umf30hdac023 : hmdac_0
//=================================================================
  umf30hdac023  hmdac_0  (
      .DACE                       (   dac_dace0                                                                                                               )
     ,.R5V                        (   regm_pocrel_v5                                                                                                          )
     ,.DADATA7                    (   dac_dadata0[7]                                                                                                          )
     ,.DADATA6                    (   dac_dadata0[6]                                                                                                          )
     ,.DADATA5                    (   dac_dadata0[5]                                                                                                          )
     ,.DADATA4                    (   dac_dadata0[4]                                                                                                          )
     ,.DADATA3                    (   dac_dadata0[3]                                                                                                          )
     ,.DADATA2                    (   dac_dadata0[2]                                                                                                          )
     ,.DADATA1                    (   dac_dadata0[1]                                                                                                          )
     ,.DADATA0                    (   dac_dadata0[0]                                                                                                          )
     ,.DACOUTHV                   (   hdac_0_dacouthv_va                                                                                                      )
     );

endmodule
// *****************************************************************************
//  (C) COPYRIGHT 2012 RENESAS ELECTRONICS CORPORATION, ALL RIGHTS RESERVED
// *****************************************************************************
