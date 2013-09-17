// *****************************************************************************
//  (C) COPYRIGHT 2012 RENESAS ELECTRONICS CORPORATION, ALL RIGHTS RESERVED
// *****************************************************************************
//   Module Name:         crl78fcspf00_f14m
//   Revision:            $Id$
//   Gen Date:            2012/04/05 15:07:08
// *****************************************************************************

 module crl78fcspf00_f14m  (
       cpu_ma
      ,cpu_slmem
      ,cpu_mdw
      ,cpu_cpuwr
      ,cpu_wdop
      ,cpu_waitmem
      ,cpu_fchram
`ifdef FPGA_ICE
      ,SLIRAM
`endif
`ifdef FPGA_ICE
      ,WAITFL2
`endif
`ifdef FPGA_ICE
      ,ICEWAITMEM
`endif
`ifdef FPGA_ICE
      ,SVI
`endif
`ifdef FPGA_ICE
      ,SVVCOUT7
`endif
`ifdef FPGA_ICE
      ,SVVCOUT6
`endif
`ifdef FPGA_ICE
      ,SVVCOUT5
`endif
`ifdef FPGA_ICE
      ,SVVCOUT4
`endif
`ifdef FPGA_ICE
      ,SVVCOUT3
`endif
`ifdef FPGA_ICE
      ,SVVCOUT2
`endif
`ifdef FPGA_ICE
      ,SVVCOUT1
`endif
`ifdef FPGA_ICE
      ,SVVCOUT0
`endif
`ifdef FPGA_ICE
      ,SVINTACK
`endif
`ifdef FPGA_ICE
      ,SVMOD
`endif
`ifdef FPGA_ICE
      ,SVMODF
`endif
`ifdef FPGA_ICE
      ,ALT1
`endif
`ifdef FPGA_ICE
      ,ALT2
`endif
`ifdef FPGA_ICE
      ,SP15
`endif
`ifdef FPGA_ICE
      ,SP14
`endif
`ifdef FPGA_ICE
      ,SP13
`endif
`ifdef FPGA_ICE
      ,SP12
`endif
`ifdef FPGA_ICE
      ,SP11
`endif
`ifdef FPGA_ICE
      ,SP10
`endif
`ifdef FPGA_ICE
      ,SP9
`endif
`ifdef FPGA_ICE
      ,SP8
`endif
`ifdef FPGA_ICE
      ,SP7
`endif
`ifdef FPGA_ICE
      ,SP6
`endif
`ifdef FPGA_ICE
      ,SP5
`endif
`ifdef FPGA_ICE
      ,SP4
`endif
`ifdef FPGA_ICE
      ,SP3
`endif
`ifdef FPGA_ICE
      ,SP2
`endif
`ifdef FPGA_ICE
      ,SP1
`endif
`ifdef FPGA_ICE
      ,SP0
`endif
`ifdef FPGA_ICE
      ,SPINC
`endif
`ifdef FPGA_ICE
      ,SPDEC
`endif
`ifdef FPGA_ICE
      ,IDPOP
`endif
`ifdef FPGA_ICE
      ,ICECSGREGU
`endif
`ifdef FPGA_ICE
      ,ICECSGREGA
`endif
`ifdef FPGA_ICE
      ,ICEIFA4
`endif
`ifdef FPGA_ICE
      ,ICEIFA3
`endif
`ifdef FPGA_ICE
      ,ICEIFA2
`endif
`ifdef FPGA_ICE
      ,ICEDO31
`endif
`ifdef FPGA_ICE
      ,ICEDO30
`endif
`ifdef FPGA_ICE
      ,ICEDO29
`endif
`ifdef FPGA_ICE
      ,ICEDO28
`endif
`ifdef FPGA_ICE
      ,ICEDO27
`endif
`ifdef FPGA_ICE
      ,ICEDO26
`endif
`ifdef FPGA_ICE
      ,ICEDO25
`endif
`ifdef FPGA_ICE
      ,ICEDO24
`endif
`ifdef FPGA_ICE
      ,ICEDO23
`endif
`ifdef FPGA_ICE
      ,ICEDO22
`endif
`ifdef FPGA_ICE
      ,ICEDO21
`endif
`ifdef FPGA_ICE
      ,ICEDO20
`endif
`ifdef FPGA_ICE
      ,ICEDO19
`endif
`ifdef FPGA_ICE
      ,ICEDO18
`endif
`ifdef FPGA_ICE
      ,ICEDO17
`endif
`ifdef FPGA_ICE
      ,ICEDO16
`endif
`ifdef FPGA_ICE
      ,ICEDO15
`endif
`ifdef FPGA_ICE
      ,ICEDO14
`endif
`ifdef FPGA_ICE
      ,ICEDO13
`endif
`ifdef FPGA_ICE
      ,ICEDO12
`endif
`ifdef FPGA_ICE
      ,ICEDO11
`endif
`ifdef FPGA_ICE
      ,ICEDO10
`endif
`ifdef FPGA_ICE
      ,ICEDO9
`endif
`ifdef FPGA_ICE
      ,ICEDO8
`endif
`ifdef FPGA_ICE
      ,ICEDO7
`endif
`ifdef FPGA_ICE
      ,ICEDO6
`endif
`ifdef FPGA_ICE
      ,ICEDO5
`endif
`ifdef FPGA_ICE
      ,ICEDO4
`endif
`ifdef FPGA_ICE
      ,ICEDO3
`endif
`ifdef FPGA_ICE
      ,ICEDO2
`endif
`ifdef FPGA_ICE
      ,ICEDO1
`endif
`ifdef FPGA_ICE
      ,ICEDO0
`endif
`ifdef FPGA_ICE
      ,FLREADB3
`endif
`ifdef FPGA_ICE
      ,FLREADB2
`endif
`ifdef FPGA_ICE
      ,FLREADB1
`endif
`ifdef FPGA_ICE
      ,FLREADB0
`endif
`ifdef FPGA_ICE
      ,IMDR15
`endif
`ifdef FPGA_ICE
      ,IMDR14
`endif
`ifdef FPGA_ICE
      ,IMDR13
`endif
`ifdef FPGA_ICE
      ,IMDR12
`endif
`ifdef FPGA_ICE
      ,IMDR11
`endif
`ifdef FPGA_ICE
      ,IMDR10
`endif
`ifdef FPGA_ICE
      ,IMDR9
`endif
`ifdef FPGA_ICE
      ,IMDR8
`endif
`ifdef FPGA_ICE
      ,IMDR7
`endif
`ifdef FPGA_ICE
      ,IMDR6
`endif
`ifdef FPGA_ICE
      ,IMDR5
`endif
`ifdef FPGA_ICE
      ,IMDR4
`endif
`ifdef FPGA_ICE
      ,IMDR3
`endif
`ifdef FPGA_ICE
      ,IMDR2
`endif
`ifdef FPGA_ICE
      ,IMDR1
`endif
`ifdef FPGA_ICE
      ,IMDR0
`endif
`ifdef FPGA_ICE
      ,IDADR31
`endif
`ifdef FPGA_ICE
      ,IDADR30
`endif
`ifdef FPGA_ICE
      ,IDADR29
`endif
`ifdef FPGA_ICE
      ,IDADR28
`endif
`ifdef FPGA_ICE
      ,IDADR27
`endif
`ifdef FPGA_ICE
      ,IDADR26
`endif
`ifdef FPGA_ICE
      ,IDADR25
`endif
`ifdef FPGA_ICE
      ,IDADR24
`endif
`ifdef FPGA_ICE
      ,IDADR23
`endif
`ifdef FPGA_ICE
      ,IDADR22
`endif
`ifdef FPGA_ICE
      ,IDADR21
`endif
`ifdef FPGA_ICE
      ,IDADR20
`endif
`ifdef FPGA_ICE
      ,IDADR19
`endif
`ifdef FPGA_ICE
      ,IDADR18
`endif
`ifdef FPGA_ICE
      ,IDADR17
`endif
`ifdef FPGA_ICE
      ,IDADR16
`endif
`ifdef FPGA_ICE
      ,IDADR15
`endif
`ifdef FPGA_ICE
      ,IDADR14
`endif
`ifdef FPGA_ICE
      ,IDADR13
`endif
`ifdef FPGA_ICE
      ,IDADR12
`endif
`ifdef FPGA_ICE
      ,IDADR11
`endif
`ifdef FPGA_ICE
      ,IDADR10
`endif
`ifdef FPGA_ICE
      ,IDADR9
`endif
`ifdef FPGA_ICE
      ,IDADR8
`endif
`ifdef FPGA_ICE
      ,IDADR7
`endif
`ifdef FPGA_ICE
      ,IDADR6
`endif
`ifdef FPGA_ICE
      ,IDADR5
`endif
`ifdef FPGA_ICE
      ,IDADR4
`endif
`ifdef FPGA_ICE
      ,IDADR3
`endif
`ifdef FPGA_ICE
      ,IDADR2
`endif
`ifdef FPGA_ICE
      ,IDADR1
`endif
`ifdef FPGA_ICE
      ,IDADR0
`endif
`ifdef FPGA_ICE
      ,STAGEADR1
`endif
`ifdef FPGA_ICE
      ,STAGEADR0
`endif
`ifdef FPGA_ICE
      ,PREFIX
`endif
`ifdef FPGA_ICE
      ,PCWAITF
`endif
`ifdef FPGA_ICE
      ,ICEMSKNMI
`endif
`ifdef FPGA_ICE
      ,ICEMSKDBG
`endif
`ifdef FPGA_ICE
      ,CPUMASK
`endif
`ifdef FPGA_ICE
      ,CPUMISAL
`endif
`ifdef FPGA_ICE
      ,SPREL
`endif
`ifdef FPGA_ICE
      ,OCDMOD
`endif
      ,timd_0_irreq0
      ,timd_0_irreq1
      ,lin3_0_int_s
      ,iic_0_intiic0
      ,ifil_intp11
      ,tau_1_int3
      ,tau_1_int2
      ,tau_1_int1
      ,tau_1_int0
      ,comp_cirq
      ,timj_0_reqirq_k
      ,timd_0_reqimfd1
      ,timd_0_reqimfc1
      ,timd_0_reqimfb1
      ,timd_0_reqimfa1
      ,timd_0_reqimfd0
      ,timd_0_reqimfc0
      ,timd_0_reqimfb0
      ,timd_0_reqimfa0
      ,tau_0_int7
      ,tau_0_int6
      ,tau_0_int5
      ,tau_0_int4
      ,tau_0_int3
      ,tau_0_int2
      ,tau_0_int1
      ,tau_0_int0
      ,rcn_comfrx_int
      ,lin3_0_int_t
      ,lin3_0_int_r
      ,sau_1_intsau0
      ,sau_1_intsau1
      ,sau_0_intsau0
      ,sau_0_intsau1
      ,adc_intad
      ,krif_intkr
      ,ifil_intp6
      ,ifil_intp5
      ,ifil_intp4
      ,ifil_intp3
      ,ifil_intp2
      ,ifil_intp1
      ,ifil_intp0
      ,dtc_intdtc33
      ,dtc_intdtc32
      ,dtc_intdtc31
      ,dtc_intdtc30
      ,dtc_intdtc29
      ,dtc_intdtc28
      ,dtc_intdtc27
      ,dtc_intdtc26
      ,dtc_intdtc7
      ,dtc_intdtc6
      ,dtc_intdtc5
      ,ocd_ocdmod
      ,ocd_svstop
      ,ocd_svperi0
      ,ocd_svperi1
      ,pt_ocd_rxocd
      ,ocd_txocd
      ,ocd_sprgmod
      ,pt_ocd_toolrx
      ,ocd_sltrxtx
      ,ocd_hpimod
      ,cibc_opocden
      ,cibc_selin1
      ,cibc_frqsel
      ,cibc_bbnvm2
      ,capmx_frq4en
      ,fcb_modidis
      ,tfwepr
      ,fcb_dw
      ,icenoecc
      ,iceflerr
      ,clk_baseckhs
      ,clk_rtc_pclk
      ,clk_iic_1_pclk
      ,clk_adc_pclk
      ,clk_iic_0_pclk
      ,clk_sau_1_pclk
      ,clk_sau_0_pclk
      ,clk_tau_1_pclk
      ,clk_tau_0_pclk
      ,rst_res_n
      ,rst_nsres_n
      ,rst_rtc_res_n
      ,rst_iic_1_res_n
      ,rst_adc_res_n
      ,rst_iic_0_res_n
      ,rst_sau_1_res_n
      ,rst_sau_0_res_n
      ,rst_tau_1_res_n
      ,rst_tau_0_res_n
      ,csc_resstp
      ,rst_sysres_n
      ,rst_reset_n
      ,clk_fclkrt
      ,iceck60m
      ,icemkwdt
      ,icemklvi
      ,icemksrq
      ,csc_tseloreg
      ,csc_tselires
      ,csc_ttemp
      ,csc_tstn
      ,csc_per0
      ,csc_stpbckbt
      ,clk_pclkrw
      ,csc_cken
      ,csc_rt0lpm
      ,capmx_bbckselr
      ,capmx_bbckselm
      ,clk_fmp_div
      ,sau_0_reqpclk
      ,adc_reqpclk
      ,capmx_bbreqpclk
      ,clk_ex_fil
      ,clk_scan_ex
      ,clk_fsub
      ,csc_rsts
      ,capmx_bbrperr
      ,csc_bbckstr
      ,capmx_bbhioon
      ,csc_bbckstm
      ,csc_fmxst
      ,csc_subckst
      ,csc_bckhsen
      ,pgcsc_bbper
      ,capmx_bbmode
      ,pt_mod_tin00
      ,pt_mod_routsrc12
      ,pt_mod_routsrc10
      ,mod_gofirm
      ,mod_scanmode
      ,mod_tesscan1
      ,mod_tesinst
      ,mod_bbtesinst
      ,mod_tesdbt
      ,mod_optiddq
      ,mod_optexcck
      ,mod_optoplrd
      ,mod_optbct
      ,mod_rammulti
      ,mod_seltar
      ,mod_oti00
      ,mod_tesdbt2
      ,mod_moderd
      ,mod_modewr
      ,mod_modenop
      ,mod_incdecws1
      ,mod_incdecws0
      ,mod_ta
      ,rtc_rt0mon0
      ,rtc_rt0mon1
      ,pt_mod_tdin5
      ,pt_mod_tdin4
      ,pt_mod_tdin3
      ,pt_mod_tdin2t
      ,pt_mod_tdin2r
      ,pt_mod_tdin2b
      ,pt_mod_tdin2l
      ,pt_mod_tdin1t
      ,pt_mod_tdin1r
      ,pt_mod_tdin1b
      ,pt_mod_tdin1l
      ,pt_mod_tdin0t
      ,pt_mod_tdin0r
      ,pt_mod_tdin0b
      ,pt_mod_tdin0l
      ,mod_teseni4
      ,mod_teseni3
      ,mod_teseni2t
      ,mod_teseni2r
      ,mod_teseni2b
      ,mod_teseni2l
      ,mod_teseni1t
      ,mod_teseni1r
      ,mod_teseni1b
      ,mod_teseni1l
      ,mod_teseni0t
      ,mod_teseni0r
      ,mod_teseni0b
      ,mod_teseni0l
      ,mod_teseno3
      ,mod_teseno2t
      ,mod_teseno2r
      ,mod_teseno2b
      ,mod_teseno2l
      ,mod_teseno1t
      ,mod_teseno1r
      ,mod_teseno1b
      ,mod_teseno1l
      ,mod_teseno0t
      ,mod_teseno0r
      ,mod_teseno0b
      ,mod_teseno0l
      ,mod_tdsel3
      ,mod_tdsel2t
      ,mod_tdsel2r
      ,mod_tdsel2b
      ,mod_tdsel2l
      ,mod_tdsel1t
      ,mod_tdsel1r
      ,mod_tdsel1b
      ,mod_tdsel1l
      ,mod_tdsel0t
      ,mod_tdsel0r
      ,mod_tdsel0b
      ,mod_tdsel0l
      ,mod_tdout3
      ,mod_tdout2
      ,mod_tdout1
      ,mod_tdout0
      ,mod_scanin
      ,mod_scanen
      ,rst_scanres_n
      ,capmx_bbscanout
      ,porga_iawen
      ,porga_gdram
      ,iaw_gdramwr
      ,bbr_bbrsub_apbmask
      ,bbr_bbrsub_psel1st
      ,bbr_bbrsub_psel2nd
      ,bbr_penable
      ,bbr_prdsel_pclm
      ,bbrsub_prdata
      ,porga_gdcsc
      ,porga_gdint
`ifdef RL78_BBUSE
      ,bbr_bbadr
`endif
`ifdef RL78_BBUSE
      ,bbr_bbmdw
`endif
`ifdef RL78_BBUSE
      ,bbr_bbpenable
`endif
`ifdef RL78_BBUSE
      ,bbr_bbpwrite
`endif
`ifdef RL78_BBUSE
      ,bbr_bbselsfr1st
`endif
`ifdef RL78_BBUSE
      ,bbr_bbselsfr2nd
`endif
`ifdef RL78_BBUSE
      ,capmx_bbprdata
`endif
      ,capmx_bbint0
      ,capmx_bbint1
      ,capmx_bbint10
      ,capmx_bbint11
      ,capmx_bbint12
      ,capmx_bbint13
      ,capmx_bbint2
      ,capmx_bbint3
      ,capmx_bbint4
      ,capmx_bbint5
      ,capmx_bbint6
      ,capmx_bbint7
      ,capmx_bbint8
      ,capmx_bbint9
      ,ifil_intp10
      ,ifil_intp7
      ,ifil_intp8
      ,ifil_intp9
      ,porga_intdtc5
      ,porga_intdtc6
      ,porga_intdtc7
      ,pt_crx_in_int
      ,rcn_cherr_int
      ,rcn_glerr_int
      ,rcn_rxf_int
      ,rcn_tx_int
      ,rtc_intrtc
      ,tau_0_inth1
      ,tau_0_inth3
      ,tau_1_inth1
      ,tau_1_inth3
      ,pt_mod_hvin
      ,ramif_stn_n
      ,ramif_mode
      ,ramif_rcn_cmt
      ,pgcsc_dspclkrwen
      ,clk_dspclkrw
      ,clk_scan
      ,clk_fmain
      ,clk_fsl
      ,timj_0_prsclen
      ,clk_timj_0_pclk
      ,rst_timj_0_res_n
      ,bbrsub_timd_0_pselal
      ,clk_timd_0_pclk
      ,pgcsc_dscken1
      ,pgcsc_dscken2
      ,pgcsc_dscken3
      ,pgcsc_dscken5
      ,rst_timd_0_res_n
      ,clk_dac_pclk
      ,rst_dac_res_n
      ,comp_cdfs
      ,clk_comp_pclk
      ,rst_comp_res_n
      ,lin3_0_reqpclk
      ,clk_lin3_0_pclk
      ,clk_clkc
      ,rst_lin3_0_res_n
      ,clk_rcn_pclk
      ,clk_rcn_clka_can
      ,rst_rcn_presetz
      ,stopst_p31
      ,stopst_p52
      ,clk_rtc_mclk
      ,clk_rtc_tclk
      ,pgcsc_cksel
      ,pgcsc_per14
      ,clk_c2c_pclk
      ,rst_c2c_res_n
      ,hhoco_oregout_va
      ,clk_fhoco
      ,clk_fil
      ,adc_bg2aden
      ,adc_bg2adsel
      ,regm_vbg2ad
      ,regm_pocrel_v5
      ,X1
      ,pt_oscm_x1eni
      ,pt_oscm_x2eni
      ,X2
      ,clk_fmx
      ,oscm_x1din
      ,oscm_x2din
      ,XT1
      ,pt_oscs_xt1eni
      ,pt_oscs_xt2eni
      ,XT2
      ,clk_fsx_rtc
      ,oscs_xt1din
      ,oscs_xt2din
      ,RESINB
      ,rst_rtbfg_n_v5
      ,pt_hflashcp_vpptsin_va
      ,EVDD0PD
      ,EVDD0PDB
      ,VDDPD
      ,VDDPDB
      ,REGC
      ,EVSS0PD
      ,EVSS0PDB
      ,VSSPD
      ,VSSPDB
  );

// ***************************************************************
// *** input,output
// ***************************************************************
    output [15:0]    cpu_ma;
    output           cpu_slmem;
    output [15:0]    cpu_mdw;
    output           cpu_cpuwr;
    output           cpu_wdop;
    input            cpu_waitmem;
    output           cpu_fchram;
`ifdef FPGA_ICE
    output           SLIRAM;
`endif
`ifdef FPGA_ICE
    input            WAITFL2;
`endif
`ifdef FPGA_ICE
    input            ICEWAITMEM;
`endif
`ifdef FPGA_ICE
    input            SVI;
`endif
`ifdef FPGA_ICE
    input            SVVCOUT7;
`endif
`ifdef FPGA_ICE
    input            SVVCOUT6;
`endif
`ifdef FPGA_ICE
    input            SVVCOUT5;
`endif
`ifdef FPGA_ICE
    input            SVVCOUT4;
`endif
`ifdef FPGA_ICE
    input            SVVCOUT3;
`endif
`ifdef FPGA_ICE
    input            SVVCOUT2;
`endif
`ifdef FPGA_ICE
    input            SVVCOUT1;
`endif
`ifdef FPGA_ICE
    input            SVVCOUT0;
`endif
`ifdef FPGA_ICE
    output           SVINTACK;
`endif
`ifdef FPGA_ICE
    output           SVMOD;
`endif
`ifdef FPGA_ICE
    output           SVMODF;
`endif
`ifdef FPGA_ICE
    output           ALT1;
`endif
`ifdef FPGA_ICE
    output           ALT2;
`endif
`ifdef FPGA_ICE
    output           SP15;
`endif
`ifdef FPGA_ICE
    output           SP14;
`endif
`ifdef FPGA_ICE
    output           SP13;
`endif
`ifdef FPGA_ICE
    output           SP12;
`endif
`ifdef FPGA_ICE
    output           SP11;
`endif
`ifdef FPGA_ICE
    output           SP10;
`endif
`ifdef FPGA_ICE
    output           SP9;
`endif
`ifdef FPGA_ICE
    output           SP8;
`endif
`ifdef FPGA_ICE
    output           SP7;
`endif
`ifdef FPGA_ICE
    output           SP6;
`endif
`ifdef FPGA_ICE
    output           SP5;
`endif
`ifdef FPGA_ICE
    output           SP4;
`endif
`ifdef FPGA_ICE
    output           SP3;
`endif
`ifdef FPGA_ICE
    output           SP2;
`endif
`ifdef FPGA_ICE
    output           SP1;
`endif
`ifdef FPGA_ICE
    output           SP0;
`endif
`ifdef FPGA_ICE
    output           SPINC;
`endif
`ifdef FPGA_ICE
    output           SPDEC;
`endif
`ifdef FPGA_ICE
    output           IDPOP;
`endif
`ifdef FPGA_ICE
    input            ICECSGREGU;
`endif
`ifdef FPGA_ICE
    input            ICECSGREGA;
`endif
`ifdef FPGA_ICE
    input            ICEIFA4;
`endif
`ifdef FPGA_ICE
    input            ICEIFA3;
`endif
`ifdef FPGA_ICE
    input            ICEIFA2;
`endif
`ifdef FPGA_ICE
    output           ICEDO31;
`endif
`ifdef FPGA_ICE
    output           ICEDO30;
`endif
`ifdef FPGA_ICE
    output           ICEDO29;
`endif
`ifdef FPGA_ICE
    output           ICEDO28;
`endif
`ifdef FPGA_ICE
    output           ICEDO27;
`endif
`ifdef FPGA_ICE
    output           ICEDO26;
`endif
`ifdef FPGA_ICE
    output           ICEDO25;
`endif
`ifdef FPGA_ICE
    output           ICEDO24;
`endif
`ifdef FPGA_ICE
    output           ICEDO23;
`endif
`ifdef FPGA_ICE
    output           ICEDO22;
`endif
`ifdef FPGA_ICE
    output           ICEDO21;
`endif
`ifdef FPGA_ICE
    output           ICEDO20;
`endif
`ifdef FPGA_ICE
    output           ICEDO19;
`endif
`ifdef FPGA_ICE
    output           ICEDO18;
`endif
`ifdef FPGA_ICE
    output           ICEDO17;
`endif
`ifdef FPGA_ICE
    output           ICEDO16;
`endif
`ifdef FPGA_ICE
    output           ICEDO15;
`endif
`ifdef FPGA_ICE
    output           ICEDO14;
`endif
`ifdef FPGA_ICE
    output           ICEDO13;
`endif
`ifdef FPGA_ICE
    output           ICEDO12;
`endif
`ifdef FPGA_ICE
    output           ICEDO11;
`endif
`ifdef FPGA_ICE
    output           ICEDO10;
`endif
`ifdef FPGA_ICE
    output           ICEDO9;
`endif
`ifdef FPGA_ICE
    output           ICEDO8;
`endif
`ifdef FPGA_ICE
    output           ICEDO7;
`endif
`ifdef FPGA_ICE
    output           ICEDO6;
`endif
`ifdef FPGA_ICE
    output           ICEDO5;
`endif
`ifdef FPGA_ICE
    output           ICEDO4;
`endif
`ifdef FPGA_ICE
    output           ICEDO3;
`endif
`ifdef FPGA_ICE
    output           ICEDO2;
`endif
`ifdef FPGA_ICE
    output           ICEDO1;
`endif
`ifdef FPGA_ICE
    output           ICEDO0;
`endif
`ifdef FPGA_ICE
    output           FLREADB3;
`endif
`ifdef FPGA_ICE
    output           FLREADB2;
`endif
`ifdef FPGA_ICE
    output           FLREADB1;
`endif
`ifdef FPGA_ICE
    output           FLREADB0;
`endif
`ifdef FPGA_ICE
    output           IMDR15;
`endif
`ifdef FPGA_ICE
    output           IMDR14;
`endif
`ifdef FPGA_ICE
    output           IMDR13;
`endif
`ifdef FPGA_ICE
    output           IMDR12;
`endif
`ifdef FPGA_ICE
    output           IMDR11;
`endif
`ifdef FPGA_ICE
    output           IMDR10;
`endif
`ifdef FPGA_ICE
    output           IMDR9;
`endif
`ifdef FPGA_ICE
    output           IMDR8;
`endif
`ifdef FPGA_ICE
    output           IMDR7;
`endif
`ifdef FPGA_ICE
    output           IMDR6;
`endif
`ifdef FPGA_ICE
    output           IMDR5;
`endif
`ifdef FPGA_ICE
    output           IMDR4;
`endif
`ifdef FPGA_ICE
    output           IMDR3;
`endif
`ifdef FPGA_ICE
    output           IMDR2;
`endif
`ifdef FPGA_ICE
    output           IMDR1;
`endif
`ifdef FPGA_ICE
    output           IMDR0;
`endif
`ifdef FPGA_ICE
    output           IDADR31;
`endif
`ifdef FPGA_ICE
    output           IDADR30;
`endif
`ifdef FPGA_ICE
    output           IDADR29;
`endif
`ifdef FPGA_ICE
    output           IDADR28;
`endif
`ifdef FPGA_ICE
    output           IDADR27;
`endif
`ifdef FPGA_ICE
    output           IDADR26;
`endif
`ifdef FPGA_ICE
    output           IDADR25;
`endif
`ifdef FPGA_ICE
    output           IDADR24;
`endif
`ifdef FPGA_ICE
    output           IDADR23;
`endif
`ifdef FPGA_ICE
    output           IDADR22;
`endif
`ifdef FPGA_ICE
    output           IDADR21;
`endif
`ifdef FPGA_ICE
    output           IDADR20;
`endif
`ifdef FPGA_ICE
    output           IDADR19;
`endif
`ifdef FPGA_ICE
    output           IDADR18;
`endif
`ifdef FPGA_ICE
    output           IDADR17;
`endif
`ifdef FPGA_ICE
    output           IDADR16;
`endif
`ifdef FPGA_ICE
    output           IDADR15;
`endif
`ifdef FPGA_ICE
    output           IDADR14;
`endif
`ifdef FPGA_ICE
    output           IDADR13;
`endif
`ifdef FPGA_ICE
    output           IDADR12;
`endif
`ifdef FPGA_ICE
    output           IDADR11;
`endif
`ifdef FPGA_ICE
    output           IDADR10;
`endif
`ifdef FPGA_ICE
    output           IDADR9;
`endif
`ifdef FPGA_ICE
    output           IDADR8;
`endif
`ifdef FPGA_ICE
    output           IDADR7;
`endif
`ifdef FPGA_ICE
    output           IDADR6;
`endif
`ifdef FPGA_ICE
    output           IDADR5;
`endif
`ifdef FPGA_ICE
    output           IDADR4;
`endif
`ifdef FPGA_ICE
    output           IDADR3;
`endif
`ifdef FPGA_ICE
    output           IDADR2;
`endif
`ifdef FPGA_ICE
    output           IDADR1;
`endif
`ifdef FPGA_ICE
    output           IDADR0;
`endif
`ifdef FPGA_ICE
    output           STAGEADR1;
`endif
`ifdef FPGA_ICE
    output           STAGEADR0;
`endif
`ifdef FPGA_ICE
    output           PREFIX;
`endif
`ifdef FPGA_ICE
    output           PCWAITF;
`endif
`ifdef FPGA_ICE
    input            ICEMSKNMI;
`endif
`ifdef FPGA_ICE
    input            ICEMSKDBG;
`endif
`ifdef FPGA_ICE
    output           CPUMASK;
`endif
`ifdef FPGA_ICE
    output           CPUMISAL;
`endif
`ifdef FPGA_ICE
    output           SPREL;
`endif
`ifdef FPGA_ICE
    input            OCDMOD;
`endif
    input            timd_0_irreq0;
    input            timd_0_irreq1;
    input            lin3_0_int_s;
    input            iic_0_intiic0;
    input            ifil_intp11;
    input            tau_1_int3;
    input            tau_1_int2;
    input            tau_1_int1;
    input            tau_1_int0;
    input            comp_cirq;
    input            timj_0_reqirq_k;
    input            timd_0_reqimfd1;
    input            timd_0_reqimfc1;
    input            timd_0_reqimfb1;
    input            timd_0_reqimfa1;
    input            timd_0_reqimfd0;
    input            timd_0_reqimfc0;
    input            timd_0_reqimfb0;
    input            timd_0_reqimfa0;
    input            tau_0_int7;
    input            tau_0_int6;
    input            tau_0_int5;
    input            tau_0_int4;
    input            tau_0_int3;
    input            tau_0_int2;
    input            tau_0_int1;
    input            tau_0_int0;
    input            rcn_comfrx_int;
    input            lin3_0_int_t;
    input            lin3_0_int_r;
    input            sau_1_intsau0;
    input            sau_1_intsau1;
    input            sau_0_intsau0;
    input            sau_0_intsau1;
    input            adc_intad;
    input            krif_intkr;
    input            ifil_intp6;
    input            ifil_intp5;
    input            ifil_intp4;
    input            ifil_intp3;
    input            ifil_intp2;
    input            ifil_intp1;
    input            ifil_intp0;
    output           dtc_intdtc33;
    output           dtc_intdtc32;
    output           dtc_intdtc31;
    output           dtc_intdtc30;
    output           dtc_intdtc29;
    output           dtc_intdtc28;
    output           dtc_intdtc27;
    output           dtc_intdtc26;
    output           dtc_intdtc7;
    output           dtc_intdtc6;
    output           dtc_intdtc5;
    output           ocd_ocdmod;
    output           ocd_svstop;
    output           ocd_svperi0;
    output           ocd_svperi1;
    input            pt_ocd_rxocd;
    output           ocd_txocd;
    output           ocd_sprgmod;
    input            pt_ocd_toolrx;
    output           ocd_sltrxtx;
    output           ocd_hpimod;
    output           cibc_opocden;
    output           cibc_selin1;
    output [4:0]     cibc_frqsel;
    output           cibc_bbnvm2;
    input            capmx_frq4en;
    output           fcb_modidis;
    input            tfwepr;
    output [37:0]    fcb_dw;
    input            icenoecc;
    input            iceflerr;
    output           clk_baseckhs;
    output           clk_rtc_pclk;
    output           clk_iic_1_pclk;
    output           clk_adc_pclk;
    output           clk_iic_0_pclk;
    output           clk_sau_1_pclk;
    output           clk_sau_0_pclk;
    output           clk_tau_1_pclk;
    output           clk_tau_0_pclk;
    output           rst_res_n;
    output           rst_nsres_n;
    output           rst_rtc_res_n;
    output           rst_iic_1_res_n;
    output           rst_adc_res_n;
    output           rst_iic_0_res_n;
    output           rst_sau_1_res_n;
    output           rst_sau_0_res_n;
    output           rst_tau_1_res_n;
    output           rst_tau_0_res_n;
    output           csc_resstp;
    output           rst_sysres_n;
    output           rst_reset_n;
    output           clk_fclkrt;
    input            iceck60m;
    input            icemkwdt;
    input            icemklvi;
    input            icemksrq;
    output           csc_tseloreg;
    output           csc_tselires;
    output           csc_ttemp;
    output           csc_tstn;
    output [7:0]     csc_per0;
    output           csc_stpbckbt;
    output           clk_pclkrw;
    output [15:1]    csc_cken;
    output           csc_rt0lpm;
    input            capmx_bbckselr;
    input            capmx_bbckselm;
    output           clk_fmp_div;
    input            sau_0_reqpclk;
    input            adc_reqpclk;
    input            capmx_bbreqpclk;
    output           clk_ex_fil;
    output           clk_scan_ex;
    output           clk_fsub;
    output           csc_rsts;
    input            capmx_bbrperr;
    output           csc_bbckstr;
    input            capmx_bbhioon;
    output           csc_bbckstm;
    output           csc_fmxst;
    output           csc_subckst;
    output           csc_bckhsen;
    output           pgcsc_bbper;
    input            capmx_bbmode;
    input            pt_mod_tin00;
    input            pt_mod_routsrc12;
    input            pt_mod_routsrc10;
    output           mod_gofirm;
    output           mod_scanmode;
    output           mod_tesscan1;
    output           mod_tesinst;
    output           mod_bbtesinst;
    output           mod_tesdbt;
    output           mod_optiddq;
    output           mod_optexcck;
    output           mod_optoplrd;
    output           mod_optbct;
    output           mod_rammulti;
    output           mod_seltar;
    output           mod_oti00;
    output           mod_tesdbt2;
    output           mod_moderd;
    output           mod_modewr;
    output           mod_modenop;
    output           mod_incdecws1;
    output           mod_incdecws0;
    output [17:0]    mod_ta;
    input            rtc_rt0mon0;
    input            rtc_rt0mon1;
    input            pt_mod_tdin5;
    input            pt_mod_tdin4;
    input            pt_mod_tdin3;
    input            pt_mod_tdin2t;
    input            pt_mod_tdin2r;
    input            pt_mod_tdin2b;
    input            pt_mod_tdin2l;
    input            pt_mod_tdin1t;
    input            pt_mod_tdin1r;
    input            pt_mod_tdin1b;
    input            pt_mod_tdin1l;
    input            pt_mod_tdin0t;
    input            pt_mod_tdin0r;
    input            pt_mod_tdin0b;
    input            pt_mod_tdin0l;
    output           mod_teseni4;
    output           mod_teseni3;
    output           mod_teseni2t;
    output           mod_teseni2r;
    output           mod_teseni2b;
    output           mod_teseni2l;
    output           mod_teseni1t;
    output           mod_teseni1r;
    output           mod_teseni1b;
    output           mod_teseni1l;
    output           mod_teseni0t;
    output           mod_teseni0r;
    output           mod_teseni0b;
    output           mod_teseni0l;
    output           mod_teseno3;
    output           mod_teseno2t;
    output           mod_teseno2r;
    output           mod_teseno2b;
    output           mod_teseno2l;
    output           mod_teseno1t;
    output           mod_teseno1r;
    output           mod_teseno1b;
    output           mod_teseno1l;
    output           mod_teseno0t;
    output           mod_teseno0r;
    output           mod_teseno0b;
    output           mod_teseno0l;
    output           mod_tdsel3;
    output           mod_tdsel2t;
    output           mod_tdsel2r;
    output           mod_tdsel2b;
    output           mod_tdsel2l;
    output           mod_tdsel1t;
    output           mod_tdsel1r;
    output           mod_tdsel1b;
    output           mod_tdsel1l;
    output           mod_tdsel0t;
    output           mod_tdsel0r;
    output           mod_tdsel0b;
    output           mod_tdsel0l;
    output           mod_tdout3;
    output           mod_tdout2;
    output           mod_tdout1;
    output           mod_tdout0;
    output           mod_scanin;
    output           mod_scanen;
    output           rst_scanres_n;
    input            capmx_bbscanout;
    input            porga_iawen;
    input  [1:0]     porga_gdram;
    output           iaw_gdramwr;
    output           bbr_bbrsub_apbmask;
    output           bbr_bbrsub_psel1st;
    output           bbr_bbrsub_psel2nd;
    output           bbr_penable;
    output [3:0]     bbr_prdsel_pclm;
    input  [15:0]    bbrsub_prdata;
    input            porga_gdcsc;
    input            porga_gdint;
`ifdef RL78_BBUSE
    output [15:0]    bbr_bbadr;
`endif
`ifdef RL78_BBUSE
    output [15:0]    bbr_bbmdw;
`endif
`ifdef RL78_BBUSE
    output           bbr_bbpenable;
`endif
`ifdef RL78_BBUSE
    output           bbr_bbpwrite;
`endif
`ifdef RL78_BBUSE
    output           bbr_bbselsfr1st;
`endif
`ifdef RL78_BBUSE
    output           bbr_bbselsfr2nd;
`endif
`ifdef RL78_BBUSE
    input  [15:0]    capmx_bbprdata;
`endif
    input            capmx_bbint0;
    input            capmx_bbint1;
    input            capmx_bbint10;
    input            capmx_bbint11;
    input            capmx_bbint12;
    input            capmx_bbint13;
    input            capmx_bbint2;
    input            capmx_bbint3;
    input            capmx_bbint4;
    input            capmx_bbint5;
    input            capmx_bbint6;
    input            capmx_bbint7;
    input            capmx_bbint8;
    input            capmx_bbint9;
    input            ifil_intp10;
    input            ifil_intp7;
    input            ifil_intp8;
    input            ifil_intp9;
    input            porga_intdtc5;
    input            porga_intdtc6;
    input            porga_intdtc7;
    input            pt_crx_in_int;
    input            rcn_cherr_int;
    input            rcn_glerr_int;
    input            rcn_rxf_int;
    input            rcn_tx_int;
    input            rtc_intrtc;
    input            tau_0_inth1;
    input            tau_0_inth3;
    input            tau_1_inth1;
    input            tau_1_inth3;
    input            pt_mod_hvin;
    output           ramif_stn_n;
    output [1:0]     ramif_mode;
    output           ramif_rcn_cmt;
    output           pgcsc_dspclkrwen;
    output           clk_dspclkrw;
    output           clk_scan;
    output           clk_fmain;
    output           clk_fsl;
    input            timj_0_prsclen;
    output           clk_timj_0_pclk;
    output           rst_timj_0_res_n;
    input            bbrsub_timd_0_pselal;
    output           clk_timd_0_pclk;
    output           pgcsc_dscken1;
    output           pgcsc_dscken2;
    output           pgcsc_dscken3;
    output           pgcsc_dscken5;
    output           rst_timd_0_res_n;
    output           clk_dac_pclk;
    output           rst_dac_res_n;
    input  [1:0]     comp_cdfs;
    output           clk_comp_pclk;
    output           rst_comp_res_n;
    input            lin3_0_reqpclk;
    output           clk_lin3_0_pclk;
    output           clk_clkc;
    output           rst_lin3_0_res_n;
    output           clk_rcn_pclk;
    output           clk_rcn_clka_can;
    output           rst_rcn_presetz;
    output           stopst_p31;
    output           stopst_p52;
    output           clk_rtc_mclk;
    output           clk_rtc_tclk;
    output           pgcsc_cksel;
    output           pgcsc_per14;
    output           clk_c2c_pclk;
    output           rst_c2c_res_n;
    inout            hhoco_oregout_va;
    output           clk_fhoco;
    output           clk_fil;
    input            adc_bg2aden;
    input            adc_bg2adsel;
    output           regm_vbg2ad;
    output           regm_pocrel_v5;
    input            X1;
    input            pt_oscm_x1eni;
    input            pt_oscm_x2eni;
    inout            X2;
    output           clk_fmx;
    output           oscm_x1din;
    output           oscm_x2din;
    input            XT1;
    input            pt_oscs_xt1eni;
    input            pt_oscs_xt2eni;
    inout            XT2;
    output           clk_fsx_rtc;
    output           oscs_xt1din;
    output           oscs_xt2din;
    input            RESINB;
    output           rst_rtbfg_n_v5;
    inout            pt_hflashcp_vpptsin_va;
    inout            EVDD0PD;
    inout            EVDD0PDB;
    inout            VDDPD;
    inout            VDDPDB;
    inout            REGC;
    inout            EVSS0PD;
    inout            EVSS0PDB;
    inout            VSSPD;
    inout            VSSPDB;

// ***************************************************************
// *** wire
// ***************************************************************

  // *** crl78gmc200_f14m : mc200 ***
    wire   [15:0]    cpu_ma;
    wire             cpu_slmem;
    wire             cpu_slbmem;
    wire             cpu_hltst;
    wire             cpu_stpst;
    wire   [15:0]    cpu_mdw;
    wire             cpu_cpuwr;
    wire             cpu_wdop;
    wire             cpu_wdwr;
    wire             cpu_fchram;
    wire             clk_drdclk;
`ifdef FPGA_ICE
    wire             SLIRAM;
`endif
`ifdef FPGA_ICE
    wire             SVINTACK;
`endif
`ifdef FPGA_ICE
    wire             SVMOD;
`endif
`ifdef FPGA_ICE
    wire             SVMODF;
`endif
`ifdef FPGA_ICE
    wire             ALT1;
`endif
`ifdef FPGA_ICE
    wire             ALT2;
`endif
`ifdef FPGA_ICE
    wire             SP15;
`endif
`ifdef FPGA_ICE
    wire             SP14;
`endif
`ifdef FPGA_ICE
    wire             SP13;
`endif
`ifdef FPGA_ICE
    wire             SP12;
`endif
`ifdef FPGA_ICE
    wire             SP11;
`endif
`ifdef FPGA_ICE
    wire             SP10;
`endif
`ifdef FPGA_ICE
    wire             SP9;
`endif
`ifdef FPGA_ICE
    wire             SP8;
`endif
`ifdef FPGA_ICE
    wire             SP7;
`endif
`ifdef FPGA_ICE
    wire             SP6;
`endif
`ifdef FPGA_ICE
    wire             SP5;
`endif
`ifdef FPGA_ICE
    wire             SP4;
`endif
`ifdef FPGA_ICE
    wire             SP3;
`endif
`ifdef FPGA_ICE
    wire             SP2;
`endif
`ifdef FPGA_ICE
    wire             SP1;
`endif
`ifdef FPGA_ICE
    wire             SP0;
`endif
`ifdef FPGA_ICE
    wire             SPINC;
`endif
`ifdef FPGA_ICE
    wire             SPDEC;
`endif
`ifdef FPGA_ICE
    wire             IDPOP;
`endif
`ifdef FPGA_ICE
    wire             ICEDO31;
`endif
`ifdef FPGA_ICE
    wire             ICEDO30;
`endif
`ifdef FPGA_ICE
    wire             ICEDO29;
`endif
`ifdef FPGA_ICE
    wire             ICEDO28;
`endif
`ifdef FPGA_ICE
    wire             ICEDO27;
`endif
`ifdef FPGA_ICE
    wire             ICEDO26;
`endif
`ifdef FPGA_ICE
    wire             ICEDO25;
`endif
`ifdef FPGA_ICE
    wire             ICEDO24;
`endif
`ifdef FPGA_ICE
    wire             ICEDO23;
`endif
`ifdef FPGA_ICE
    wire             ICEDO22;
`endif
`ifdef FPGA_ICE
    wire             ICEDO21;
`endif
`ifdef FPGA_ICE
    wire             ICEDO20;
`endif
`ifdef FPGA_ICE
    wire             ICEDO19;
`endif
`ifdef FPGA_ICE
    wire             ICEDO18;
`endif
`ifdef FPGA_ICE
    wire             ICEDO17;
`endif
`ifdef FPGA_ICE
    wire             ICEDO16;
`endif
`ifdef FPGA_ICE
    wire             ICEDO15;
`endif
`ifdef FPGA_ICE
    wire             ICEDO14;
`endif
`ifdef FPGA_ICE
    wire             ICEDO13;
`endif
`ifdef FPGA_ICE
    wire             ICEDO12;
`endif
`ifdef FPGA_ICE
    wire             ICEDO11;
`endif
`ifdef FPGA_ICE
    wire             ICEDO10;
`endif
`ifdef FPGA_ICE
    wire             ICEDO9;
`endif
`ifdef FPGA_ICE
    wire             ICEDO8;
`endif
`ifdef FPGA_ICE
    wire             ICEDO7;
`endif
`ifdef FPGA_ICE
    wire             ICEDO6;
`endif
`ifdef FPGA_ICE
    wire             ICEDO5;
`endif
`ifdef FPGA_ICE
    wire             ICEDO4;
`endif
`ifdef FPGA_ICE
    wire             ICEDO3;
`endif
`ifdef FPGA_ICE
    wire             ICEDO2;
`endif
`ifdef FPGA_ICE
    wire             ICEDO1;
`endif
`ifdef FPGA_ICE
    wire             ICEDO0;
`endif
`ifdef FPGA_ICE
    wire             FLREADB3;
`endif
`ifdef FPGA_ICE
    wire             FLREADB2;
`endif
`ifdef FPGA_ICE
    wire             FLREADB1;
`endif
`ifdef FPGA_ICE
    wire             FLREADB0;
`endif
`ifdef FPGA_ICE
    wire             IMDR15;
`endif
`ifdef FPGA_ICE
    wire             IMDR14;
`endif
`ifdef FPGA_ICE
    wire             IMDR13;
`endif
`ifdef FPGA_ICE
    wire             IMDR12;
`endif
`ifdef FPGA_ICE
    wire             IMDR11;
`endif
`ifdef FPGA_ICE
    wire             IMDR10;
`endif
`ifdef FPGA_ICE
    wire             IMDR9;
`endif
`ifdef FPGA_ICE
    wire             IMDR8;
`endif
`ifdef FPGA_ICE
    wire             IMDR7;
`endif
`ifdef FPGA_ICE
    wire             IMDR6;
`endif
`ifdef FPGA_ICE
    wire             IMDR5;
`endif
`ifdef FPGA_ICE
    wire             IMDR4;
`endif
`ifdef FPGA_ICE
    wire             IMDR3;
`endif
`ifdef FPGA_ICE
    wire             IMDR2;
`endif
`ifdef FPGA_ICE
    wire             IMDR1;
`endif
`ifdef FPGA_ICE
    wire             IMDR0;
`endif
`ifdef FPGA_ICE
    wire             IDADR31;
`endif
`ifdef FPGA_ICE
    wire             IDADR30;
`endif
`ifdef FPGA_ICE
    wire             IDADR29;
`endif
`ifdef FPGA_ICE
    wire             IDADR28;
`endif
`ifdef FPGA_ICE
    wire             IDADR27;
`endif
`ifdef FPGA_ICE
    wire             IDADR26;
`endif
`ifdef FPGA_ICE
    wire             IDADR25;
`endif
`ifdef FPGA_ICE
    wire             IDADR24;
`endif
`ifdef FPGA_ICE
    wire             IDADR23;
`endif
`ifdef FPGA_ICE
    wire             IDADR22;
`endif
`ifdef FPGA_ICE
    wire             IDADR21;
`endif
`ifdef FPGA_ICE
    wire             IDADR20;
`endif
`ifdef FPGA_ICE
    wire             IDADR19;
`endif
`ifdef FPGA_ICE
    wire             IDADR18;
`endif
`ifdef FPGA_ICE
    wire             IDADR17;
`endif
`ifdef FPGA_ICE
    wire             IDADR16;
`endif
`ifdef FPGA_ICE
    wire             IDADR15;
`endif
`ifdef FPGA_ICE
    wire             IDADR14;
`endif
`ifdef FPGA_ICE
    wire             IDADR13;
`endif
`ifdef FPGA_ICE
    wire             IDADR12;
`endif
`ifdef FPGA_ICE
    wire             IDADR11;
`endif
`ifdef FPGA_ICE
    wire             IDADR10;
`endif
`ifdef FPGA_ICE
    wire             IDADR9;
`endif
`ifdef FPGA_ICE
    wire             IDADR8;
`endif
`ifdef FPGA_ICE
    wire             IDADR7;
`endif
`ifdef FPGA_ICE
    wire             IDADR6;
`endif
`ifdef FPGA_ICE
    wire             IDADR5;
`endif
`ifdef FPGA_ICE
    wire             IDADR4;
`endif
`ifdef FPGA_ICE
    wire             IDADR3;
`endif
`ifdef FPGA_ICE
    wire             IDADR2;
`endif
`ifdef FPGA_ICE
    wire             IDADR1;
`endif
`ifdef FPGA_ICE
    wire             IDADR0;
`endif
`ifdef FPGA_ICE
    wire             STAGEADR1;
`endif
`ifdef FPGA_ICE
    wire             STAGEADR0;
`endif
`ifdef FPGA_ICE
    wire             PREFIX;
`endif
`ifdef FPGA_ICE
    wire             PCWAITF;
`endif
`ifdef FPGA_ICE
    wire             CPUMASK;
`endif
`ifdef FPGA_ICE
    wire             CPUMISAL;
`endif
`ifdef FPGA_ICE
    wire             SPREL;
`endif
    wire             int_stbrele;
    wire             dtc_intdtc33;
    wire             dtc_intdtc32;
    wire             dtc_intdtc31;
    wire             dtc_intdtc30;
    wire             dtc_intdtc29;
    wire             dtc_intdtc28;
    wire             dtc_intdtc27;
    wire             dtc_intdtc26;
    wire             dtc_intdtc7;
    wire             dtc_intdtc6;
    wire             dtc_intdtc5;
    wire             dtc_reqpclkdt;
    wire             ocd_ocdmod;
    wire             ocd_svstop;
    wire             ocd_svperi0;
    wire             ocd_svperi1;
    wire             ocd_txocd;
    wire             ocd_sprgmod;
    wire             ocd_sltrxtx;
    wire             ocd_reqocd;
    wire   [6:0]     ocd_trcma;
    wire   [19:0]    ocd_trcmdw;
    wire             ocd_trcwr;
    wire             ocd_hpimod;
    wire             cibd_dce0;
    wire   [13:0]    cibd_da;
    wire             cibd_dclksel1;
    wire             cibd_dsrcut;
    wire             cibd_dflstop;
    wire             clk_drdclkc1;
    wire   [4:0]     cibc_frsel;
    wire             cibc_opclkmb;
    wire             cibc_opwden;
    wire             cibc_opwdstby;
    wire             cibc_opocden;
    wire             cibc_selin1;
    wire   [17:0]    cibc_trmcp0;
    wire   [14:10]   cibc_trmcp1;
    wire   [14:10]   cibc_dtrmcp0;
    wire   [20:15]   cibc_rtrmcp0;
    wire             cibc_ce0;
    wire   [19:2]    cibc_a;
    wire             cibc_exa;
    wire             cibc_bfa;
    wire             cibc_clksel1;
    wire             cibc_srcut;
    wire             cibc_flstop;
    wire             cibc_sub;
    wire             cibc_hispeed;
    wire   [4:0]     cibc_frqsel;
    wire             cibc_rlowspy;
    wire             cibc_lowpower;
    wire   [6:0]     cibc_ctrim;
    wire   [2:0]     cibc_wtrim;
    wire   [5:0]     cibc_ftrim;
    wire   [5:0]     cibc_rtrim;
    wire   [10:0]    cibc_bgrt;
    wire             cibc_bbnvm2;
    wire             cibc_brsam;
    wire             cibc_r0flagz_n;
    wire             cibc_r1flagz_n;
    wire   [7:0]     cibc_r0a;
    wire   [7:0]     cibc_r1a;
    wire             cibc_oscnostp;
    wire             cibc_oscouten;
    wire             fcb_lowspy;
    wire             fcb_cwee;
    wire             fcb_ddis;
    wire             fcb_dread;
    wire             fcb_dmrg00;
    wire             fcb_dmrg01;
    wire             fcb_dmrg10;
    wire             fcb_dmrg11;
    wire             fcb_dmrg12;
    wire             fcb_dser;
    wire             fcb_dwwr;
    wire             fcb_dcer;
    wire             fcb_dis;
    wire             fcb_read;
    wire             fcb_mrg00;
    wire             fcb_mrg01;
    wire             fcb_mrg10;
    wire             fcb_mrg11;
    wire             fcb_mrg12;
    wire             fcb_wwr;
    wire             fcb_mswr;
    wire             fcb_cer;
    wire             fcb_ser;
    wire             fcb_exer;
    wire             fcb_stchk;
    wire             fcb_ionchk1;
    wire             fcb_rdt;
    wire             fcb_rdmrg1;
    wire             fcb_rdmrg0;
    wire             fcb_rdmrgc;
    wire             fcb_wdt1;
    wire             fcb_wdt2;
    wire             fcb_wdt3;
    wire             fcb_wdt4;
    wire             fcb_cpbt;
    wire             fcb_saceen_n;
    wire             fcb_ireft;
    wire             fcb_cpt;
    wire             fcb_extvpp2;
    wire             fcb_extvpp1;
    wire             fcb_meoc;
    wire             fcb_meor;
    wire   [2:0]     fcb_beu;
    wire             fcb_modidis;
    wire             fcb_wed;
    wire             fcb_dwed;
    wire   [37:0]    fcb_dw;
    wire             fcb_fclk1;
    wire             fcb_fclk2;
    wire             clk_rdclkp1;
    wire             fcb_progi;
    wire             fcb_mutest;
    wire             bbr_csc_penable;
    wire             clk_baseck;
    wire             clk_baseckhs;
    wire             clk_pclkocd;
    wire             clk_rtc_pclk;
    wire             clk_iic_1_pclk;
    wire             clk_adc_pclk;
    wire             clk_iic_0_pclk;
    wire             clk_sau_1_pclk;
    wire             clk_sau_0_pclk;
    wire             clk_tau_1_pclk;
    wire             clk_tau_0_pclk;
    wire             rst_res_n;
    wire             rst_nsres_n;
    wire             rst_rtc_res_n;
    wire             rst_iic_1_res_n;
    wire             rst_adc_res_n;
    wire             rst_iic_0_res_n;
    wire             rst_sau_1_res_n;
    wire             rst_sau_0_res_n;
    wire             rst_tau_1_res_n;
    wire             rst_tau_0_res_n;
    wire             csc_resstp;
    wire             csc_cpustart;
    wire             csc_oscsel;
    wire             csc_mstop;
    wire             csc_exclk;
    wire             csc_amph;
    wire             csc_oscsels;
    wire             csc_xtstop;
    wire             csc_exclks;
    wire             csc_amphs0;
    wire             csc_r32mstp;
    wire             csc_r15kstpz_n;
    wire             csc_reglc;
    wire             csc_reglv;
    wire             csc_oregstp;
    wire             rst_sysres_n;
    wire             rst_reset_n;
    wire             csc_lvien;
    wire   [3:0]     csc_lvis;
    wire             csc_pstn_n;
    wire             csc_amphs1;
    wire             csc_xtwkup;
    wire             clk_fclkrt;
    wire             csc_tseloreg;
    wire             csc_tselires;
    wire             csc_ttemp;
    wire             csc_losctest;
    wire             csc_tstn;
    wire   [7:0]     csc_per0;
    wire             csc_stpbckbt;
    wire             clk_pclkrw;
    wire   [15:1]    csc_cken;
    wire             csc_rt0lpm;
    wire             clk_ex_fil;
    wire             clk_scan_ex;
    wire             csc_cpuclken;
    wire             csc_rtcclken;
    wire             clk_pclktst;
    wire             clk_fsub;
    wire             csc_paenb_n;
    wire             csc_lvitest;
    wire             csc_lvitsel;
    wire             clk_pclkfcb;
    wire             csc_mcm0;
    wire             csc_rsts;
    wire             csc_bbckstr;
    wire             csc_bbckstm;
    wire             csc_ampsel;
    wire             csc_fmxst;
    wire             csc_subckst;
    wire             csc_bckhsen;
    wire             mod_gofirm;
    wire             mod_testmod;
    wire             mod_scanmode;
    wire             mod_tesscan1;
    wire             mod_tesinst;
    wire             mod_bbtesinst;
    wire             mod_tesdbt;
    wire             mod_optram;
    wire             mod_optiddq;
    wire             mod_optexcck;
    wire             mod_optoplrd;
    wire             mod_optbct;
    wire             mod_rammulti;
    wire             mod_mdlycut;
    wire             mod_raedis;
    wire             mod_seltar;
    wire             mod_oti00;
    wire             mod_tesdbt2;
    wire             mod_moderd;
    wire             mod_modewr;
    wire             mod_modenop;
    wire             mod_incdecws1;
    wire             mod_incdecws0;
    wire   [17:0]    mod_ta;
    wire             clk_exclk1;
    wire             mod_teseni4;
    wire             mod_teseni3;
    wire             mod_teseni2t;
    wire             mod_teseni2r;
    wire             mod_teseni2b;
    wire             mod_teseni2l;
    wire             mod_teseni1t;
    wire             mod_teseni1r;
    wire             mod_teseni1b;
    wire             mod_teseni1l;
    wire             mod_teseni0t;
    wire             mod_teseni0r;
    wire             mod_teseni0b;
    wire             mod_teseni0l;
    wire             mod_teseno3;
    wire             mod_teseno2t;
    wire             mod_teseno2r;
    wire             mod_teseno2b;
    wire             mod_teseno2l;
    wire             mod_teseno1t;
    wire             mod_teseno1r;
    wire             mod_teseno1b;
    wire             mod_teseno1l;
    wire             mod_teseno0t;
    wire             mod_teseno0r;
    wire             mod_teseno0b;
    wire             mod_teseno0l;
    wire             mod_tdsel3;
    wire             mod_tdsel2t;
    wire             mod_tdsel2r;
    wire             mod_tdsel2b;
    wire             mod_tdsel2l;
    wire             mod_tdsel1t;
    wire             mod_tdsel1r;
    wire             mod_tdsel1b;
    wire             mod_tdsel1l;
    wire             mod_tdsel0t;
    wire             mod_tdsel0r;
    wire             mod_tdsel0b;
    wire             mod_tdsel0l;
    wire             mod_tdout3;
    wire             mod_tdout2;
    wire             mod_tdout1;
    wire             mod_tdout0;
    wire             mod_scanin;
    wire             clk_scan_pre;
    wire             mod_scanen;
    wire             rst_scanres_n;
    wire             iaw_gdramwr;
    wire             clk_tfhoco;
    wire             clk_tfil;
    wire             clk_tfihfl;
    wire             clk_tfihocd;
    wire             bbr_bbrsub_apbmask;
    wire             bbr_bbrsub_psel1st;
    wire             bbr_bbrsub_psel2nd;
    wire   [4:0]     bbr_cpusys_padr;
    wire             bbr_cpusys_penable;
    wire   [15:0]    bbr_cpusys_pwdata;
    wire             bbr_cpusys_pwrite;
    wire             bbr_penable;
    wire             bbr_pgcsc_psel;
    wire   [7:0]     bbr_prdctl;
    wire   [3:0]     bbr_prdsel_pclm;
    wire   [7:0]     bbr_wdtliotrm;
    wire   [15:0]    ramif_prdata;
`ifdef RL78_BBUSE
    wire   [15:0]    bbr_bbadr;
`endif
`ifdef RL78_BBUSE
    wire   [15:0]    bbr_bbmdw;
`endif
`ifdef RL78_BBUSE
    wire             bbr_bbpenable;
`endif
`ifdef RL78_BBUSE
    wire             bbr_bbpwrite;
`endif
`ifdef RL78_BBUSE
    wire             bbr_bbselsfr1st;
`endif
`ifdef RL78_BBUSE
    wire             bbr_bbselsfr2nd;
`endif
    wire             clk_ramclk;
    wire             ramif_cen0_n;
    wire             ramif_cen1_n;
    wire             ramif_cen2_n;
    wire             ramif_cen3_n;
    wire   [12:0]    ramif_ramd0;
    wire   [12:0]    ramif_ramd1;
    wire   [12:0]    ramif_ramd2;
    wire   [12:0]    ramif_ramd3;
    wire   [10:0]    ramif_rama;
    wire             ramif_wen_n;
    wire             ramif_stn_n;
    wire   [1:0]     ramif_mode;
    wire             ramif_cmt;
    wire             ramif_rcn_cmt;
  // *** crl78hpgcsc_f14mid : pgcsc ***
    wire   [15:0]    pgcsc_prdata;
    wire             pgcsc_dspclkrwen;
    wire             clk_dspclkrw;
    wire             pgcsc_sout;
    wire             clk_scan;
    wire             clk_fmain;
    wire             clk_fpll64m;
    wire             clk_fmp_div;
    wire             clk_fsl;
    wire             pgcsc_r15kstpz;
    wire             clk_wdt_loscout;
    wire             clk_timj_0_pclk;
    wire             rst_timj_0_res_n;
    wire             clk_timd_0_pclk;
    wire             pgcsc_dscken1;
    wire             pgcsc_dscken2;
    wire             pgcsc_dscken3;
    wire             pgcsc_dscken5;
    wire             rst_timd_0_res_n;
    wire             clk_dac_pclk;
    wire             rst_dac_res_n;
    wire             clk_comp_pclk;
    wire             rst_comp_res_n;
    wire             clk_pclkdt;
    wire             clk_lin3_0_pclk;
    wire             clk_clkc;
    wire             rst_lin3_0_res_n;
    wire             clk_rcn_pclk;
    wire             clk_rcn_clka_can;
    wire             rst_rcn_presetz;
    wire             clk_ocd_loco;
    wire             ramif_rperr;
    wire             pgcsc_intclm;
    wire             pgcsc_wden;
    wire             stopst_p31;
    wire             stopst_p52;
    wire             clk_rtc_mclk;
    wire             clk_rtc_tclk;
    wire             pgcsc_cksel;
    wire             pgcsc_pllrgctl;
    wire             pgcsc_bbper;
    wire             pgcsc_oscsels;
    wire             pgcsc_per14;
    wire             clk_c2c_pclk;
    wire             rst_c2c_res_n;
    wire             rst_preset_wdt_n;
`ifdef FPGA_ICE
    wire             CPUPRCLK3_ICE;
`endif
  // *** QAHIOS0BN32MV2 : h_rosc ***
    wire             hhoco_oregout_va;
    wire             clk_fihfl;
    wire             clk_fihocd;
    wire             clk_fhoco;
    wire   [4:0]     hoco_temp;
  // *** QAHIOS1BN15KV1 : l_rosc ***
    wire             clk_fil;
  // *** umf30QAHMIX3MAIN : regm ***
    wire             regm_vbg08;
    wire             regm_vreg;
    wire             regm_bgioreg1;
    wire             regm_bgioreg2;
    wire             regm_vbg2ad;
    wire             regm_bgisub1;
    wire             regm_bgisub2;
    wire             regm_bgisub3;
    wire             regm_regdrv;
    wire             regm_pdrv;
    wire             regm_pocrel;
    wire             regm_pocrel_v5;
    wire             regm_lvioutz;
    wire             open_testvout;
  // *** umf30QAHMIX3DRV : regd ***
    wire             regd_sensevdd;
  // *** QAHMOS0HNV1 : oscmain ***
    wire             X2;
    wire             clk_fmx;
    wire             oscm_x1din;
    wire             oscm_x2din;
  // *** QAHSOS1HNV1 : oscsub ***
    wire             XT2;
    wire             clk_fsx;
    wire             clk_fsx_rtc;
    wire             oscs_xt1din;
    wire             oscs_xt2din;
  // *** D78F2048QID03005 : pwresetb ***
    wire             rst_resfb_v5;
    wire             rst_rstinbnf_n;
    wire             rst_treset;
    wire             rst_rtbfg_n_v5;
  // *** KX4_NF : nf ***
    wire             nf_pocrelnf;
    wire             rst_resetinbnf_n;
    wire             nf_lvioutznf;
  // *** QAHRES0CV1 : vppts1_res ***
    wire             pt_hflashcp_vpptsin_va;
    wire             vppts1_cp;
  // *** QIVG0005ZBL : power ***
    wire             EVDD0PD;
    wire             EVDD0PDB;
    wire             VDDPD;
    wire             VDDPDB;
    wire             REGC;
    wire             EVSS0PD;
    wire             EVSS0PDB;
    wire             VSSPD;
    wire             VSSPDB;
    wire             gpad1bb;
    wire             vpad0bb;
    wire             vpad1bb;
    wire             vpad2bb;
    wire             gpad0bb;
  // *** QAHNFI4BN300NV1 : dmydly300n ***
    wire             dly300_dly300no;
  // *** QNSC3NCP1V2 : flash_cp ***
    wire             flcp_trmrd1;
    wire             flcp_trmrd1ck;
    wire             flcp_trmrd2;
    wire             flcp_trmrd2ck;
    wire             flcp_vbreszcp_n;
    wire             flcp_vcphv;
    wire             flcp_vregmv;
    wire             flcp_vregrmv;
    wire             flcp_hvppts1;
    wire             flcp_vpbias;
    wire             flcp_srcutcp;
    wire             clk_oscoutcp;
    wire             flcp_reqfl;
    wire             flcp_rdsetup;
    wire             flcp_reg125st;
    wire             flcp_bg1st;
    wire             flcp_flregenb;
  // *** QNSB3N004K0V2 : flash_data ***
    wire   [11:0]    fdata_dro0;
  // *** QNSC3NREG1V2 : flash_reg ***
    wire             freg_vcprgwe;
  // *** QNSC3NCPDC0V1 : flash_capa_0 ***
  // *** QNSC3NCPDC0V1 : flash_capa_1 ***
  // *** QNSC3NCPDC0V1 : flash_capa_2 ***
  // *** QNSC3NCPDC0V1 : flash_capa_3 ***
  // *** QNSC3NCPDC0V1 : flash_capa_4 ***
  // *** QNSC3NCPDC0V1 : flash_capa_5 ***
  // *** QNSC3NCPDC0V1 : flash_capa_6 ***
  // *** QNSC3NCPDC0V1 : flash_capa_7 ***
  // *** QNSC3NCPDC0V1 : flash_capa_8 ***
  // *** QNSC3NCPDC0V1 : flash_capa_9 ***
  // *** QNSC3NCPDC0V1 : flash_capa_10 ***
  // *** QNSC3NCPDC0V1 : flash_capa_11 ***
  // *** QNSC3NCPDC0V1 : flash_capa_12 ***
  // *** QNSC3NCPDC0V1 : flash_capa_13 ***
  // *** QNSC3NCPDC0V1 : flash_capa_14 ***
  // *** QNSA3N128K0V2 : flash_code_0 ***
    wire   [37:0]    fcode0_ro0;
  // *** OWSRAM152W2048B13C4 : sram_0 ***
    wire   [12:0]    hram_0_ramq;
  // *** OWSRAM152W2048B13C4 : sram_1 ***
    wire   [12:0]    hram_1_ramq;
  // *** OWSRAM152W2048B13C4 : sram_2 ***
    wire   [12:0]    hram_2_ramq;
  // *** OWSRAM152W2048B13C4 : sram_3 ***
    wire   [12:0]    hram_3_ramq;
  // *** bufclk_cell_pf : flashclk_dly ***
    wire             clk_rdclkc1;
  // *** bufclk_cell_pf : ramclk_dly_0 ***
    wire             clk_ramclko_dly0;
  // *** bufclk_cell_pf : ramclk_dly_1 ***
    wire             clk_ramclko_dly1;
  // *** bufclk_cell_pf : ramclk_dly_2 ***
    wire             clk_ramclko_dly2;
  // *** bufclk_cell_pf : ramclk_dly_3 ***
    wire             clk_ramclko_dly3;
  // *** andclk_cell_pf : monitor_sig_gating_1 ***
    wire             clk_fmp_div_gating;
  // *** andclk_cell_pf : monitor_sig_gating_2 ***
    wire             clk_fpll64m_gating;
  // *** andclk_cell_pf : monitor_sig_gating_3 ***
    wire             clk_wdt_loscout_gating;
  // *** dly50_cell_pf : dmydly50n ***
    wire             dly50_dly50no;

//=================================================================
//===   pulldown,pullup
//=================================================================
    wire pull_down0;
    wire pull_down1;
    wire pull_down2;
    wire pull_down3;
    wire pull_down4;
    wire pull_down5;
    wire pull_down6;
    wire pull_down7;
    wire pull_down8;
    pulldown_cell_pf pulldown_cell0( .y(pull_down0) ) ;
    pulldown_cell_pf pulldown_cell1( .y(pull_down1) ) ;
    pulldown_cell_pf pulldown_cell2( .y(pull_down2) ) ;
    pulldown_cell_pf pulldown_cell3( .y(pull_down3) ) ;
    pulldown_cell_pf pulldown_cell4( .y(pull_down4) ) ;
    pulldown_cell_pf pulldown_cell5( .y(pull_down5) ) ;
    pulldown_cell_pf pulldown_cell6( .y(pull_down6) ) ;
    pulldown_cell_pf pulldown_cell7( .y(pull_down7) ) ;
    pulldown_cell_pf pulldown_cell8( .y(pull_down8) ) ;


//=================================================================
//===   crl78gmc200_f14m : mc200
//=================================================================
  crl78gmc200_f14m  mc200  (
      .cpu_ma                   (   cpu_ma[15:0]                )
     ,.cpu_slmem                (   cpu_slmem                   )
     ,.cpu_slbmem               (   cpu_slbmem                  )
     ,.cpu_hltst                (   cpu_hltst                   )
     ,.cpu_stpst                (   cpu_stpst                   )
     ,.cpu_mdw                  (   cpu_mdw[15:0]               )
     ,.cpu_cpuwr                (   cpu_cpuwr                   )
     ,.cpu_wdop                 (   cpu_wdop                    )
     ,.cpu_wdwr                 (   cpu_wdwr                    )
     ,.cpu_waitmem              (   cpu_waitmem                 )
     ,.cpu_fchram               (   cpu_fchram                  )
     ,.clk_drdclk               (   clk_drdclk                  )
`ifdef FPGA_ICE
     ,.SLIRAM                   (   SLIRAM                      )
`endif
`ifdef FPGA_ICE
     ,.WAITFL2                  (   WAITFL2                     )
`endif
`ifdef FPGA_ICE
     ,.ICEWAITMEM               (   ICEWAITMEM                  )
`endif
`ifdef FPGA_ICE
     ,.SVI                      (   SVI                         )
`endif
`ifdef FPGA_ICE
     ,.SVVCOUT7                 (   SVVCOUT7                    )
`endif
`ifdef FPGA_ICE
     ,.SVVCOUT6                 (   SVVCOUT6                    )
`endif
`ifdef FPGA_ICE
     ,.SVVCOUT5                 (   SVVCOUT5                    )
`endif
`ifdef FPGA_ICE
     ,.SVVCOUT4                 (   SVVCOUT4                    )
`endif
`ifdef FPGA_ICE
     ,.SVVCOUT3                 (   SVVCOUT3                    )
`endif
`ifdef FPGA_ICE
     ,.SVVCOUT2                 (   SVVCOUT2                    )
`endif
`ifdef FPGA_ICE
     ,.SVVCOUT1                 (   SVVCOUT1                    )
`endif
`ifdef FPGA_ICE
     ,.SVVCOUT0                 (   SVVCOUT0                    )
`endif
`ifdef FPGA_ICE
     ,.SVINTACK                 (   SVINTACK                    )
`endif
`ifdef FPGA_ICE
     ,.SVMOD                    (   SVMOD                       )
`endif
`ifdef FPGA_ICE
     ,.SVMODF                   (   SVMODF                      )
`endif
`ifdef FPGA_ICE
     ,.ALT1                     (   ALT1                        )
`endif
`ifdef FPGA_ICE
     ,.ALT2                     (   ALT2                        )
`endif
`ifdef FPGA_ICE
     ,.SP15                     (   SP15                        )
`endif
`ifdef FPGA_ICE
     ,.SP14                     (   SP14                        )
`endif
`ifdef FPGA_ICE
     ,.SP13                     (   SP13                        )
`endif
`ifdef FPGA_ICE
     ,.SP12                     (   SP12                        )
`endif
`ifdef FPGA_ICE
     ,.SP11                     (   SP11                        )
`endif
`ifdef FPGA_ICE
     ,.SP10                     (   SP10                        )
`endif
`ifdef FPGA_ICE
     ,.SP9                      (   SP9                         )
`endif
`ifdef FPGA_ICE
     ,.SP8                      (   SP8                         )
`endif
`ifdef FPGA_ICE
     ,.SP7                      (   SP7                         )
`endif
`ifdef FPGA_ICE
     ,.SP6                      (   SP6                         )
`endif
`ifdef FPGA_ICE
     ,.SP5                      (   SP5                         )
`endif
`ifdef FPGA_ICE
     ,.SP4                      (   SP4                         )
`endif
`ifdef FPGA_ICE
     ,.SP3                      (   SP3                         )
`endif
`ifdef FPGA_ICE
     ,.SP2                      (   SP2                         )
`endif
`ifdef FPGA_ICE
     ,.SP1                      (   SP1                         )
`endif
`ifdef FPGA_ICE
     ,.SP0                      (   SP0                         )
`endif
`ifdef FPGA_ICE
     ,.SPINC                    (   SPINC                       )
`endif
`ifdef FPGA_ICE
     ,.SPDEC                    (   SPDEC                       )
`endif
`ifdef FPGA_ICE
     ,.IDPOP                    (   IDPOP                       )
`endif
`ifdef FPGA_ICE
     ,.ICECSGREGU               (   ICECSGREGU                  )
`endif
`ifdef FPGA_ICE
     ,.ICECSGREGA               (   ICECSGREGA                  )
`endif
`ifdef FPGA_ICE
     ,.ICEIFA4                  (   ICEIFA4                     )
`endif
`ifdef FPGA_ICE
     ,.ICEIFA3                  (   ICEIFA3                     )
`endif
`ifdef FPGA_ICE
     ,.ICEIFA2                  (   ICEIFA2                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO31                  (   ICEDO31                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO30                  (   ICEDO30                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO29                  (   ICEDO29                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO28                  (   ICEDO28                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO27                  (   ICEDO27                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO26                  (   ICEDO26                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO25                  (   ICEDO25                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO24                  (   ICEDO24                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO23                  (   ICEDO23                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO22                  (   ICEDO22                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO21                  (   ICEDO21                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO20                  (   ICEDO20                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO19                  (   ICEDO19                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO18                  (   ICEDO18                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO17                  (   ICEDO17                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO16                  (   ICEDO16                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO15                  (   ICEDO15                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO14                  (   ICEDO14                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO13                  (   ICEDO13                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO12                  (   ICEDO12                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO11                  (   ICEDO11                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO10                  (   ICEDO10                     )
`endif
`ifdef FPGA_ICE
     ,.ICEDO9                   (   ICEDO9                      )
`endif
`ifdef FPGA_ICE
     ,.ICEDO8                   (   ICEDO8                      )
`endif
`ifdef FPGA_ICE
     ,.ICEDO7                   (   ICEDO7                      )
`endif
`ifdef FPGA_ICE
     ,.ICEDO6                   (   ICEDO6                      )
`endif
`ifdef FPGA_ICE
     ,.ICEDO5                   (   ICEDO5                      )
`endif
`ifdef FPGA_ICE
     ,.ICEDO4                   (   ICEDO4                      )
`endif
`ifdef FPGA_ICE
     ,.ICEDO3                   (   ICEDO3                      )
`endif
`ifdef FPGA_ICE
     ,.ICEDO2                   (   ICEDO2                      )
`endif
`ifdef FPGA_ICE
     ,.ICEDO1                   (   ICEDO1                      )
`endif
`ifdef FPGA_ICE
     ,.ICEDO0                   (   ICEDO0                      )
`endif
`ifdef FPGA_ICE
     ,.FLREADB3                 (   FLREADB3                    )
`endif
`ifdef FPGA_ICE
     ,.FLREADB2                 (   FLREADB2                    )
`endif
`ifdef FPGA_ICE
     ,.FLREADB1                 (   FLREADB1                    )
`endif
`ifdef FPGA_ICE
     ,.FLREADB0                 (   FLREADB0                    )
`endif
`ifdef FPGA_ICE
     ,.IMDR15                   (   IMDR15                      )
`endif
`ifdef FPGA_ICE
     ,.IMDR14                   (   IMDR14                      )
`endif
`ifdef FPGA_ICE
     ,.IMDR13                   (   IMDR13                      )
`endif
`ifdef FPGA_ICE
     ,.IMDR12                   (   IMDR12                      )
`endif
`ifdef FPGA_ICE
     ,.IMDR11                   (   IMDR11                      )
`endif
`ifdef FPGA_ICE
     ,.IMDR10                   (   IMDR10                      )
`endif
`ifdef FPGA_ICE
     ,.IMDR9                    (   IMDR9                       )
`endif
`ifdef FPGA_ICE
     ,.IMDR8                    (   IMDR8                       )
`endif
`ifdef FPGA_ICE
     ,.IMDR7                    (   IMDR7                       )
`endif
`ifdef FPGA_ICE
     ,.IMDR6                    (   IMDR6                       )
`endif
`ifdef FPGA_ICE
     ,.IMDR5                    (   IMDR5                       )
`endif
`ifdef FPGA_ICE
     ,.IMDR4                    (   IMDR4                       )
`endif
`ifdef FPGA_ICE
     ,.IMDR3                    (   IMDR3                       )
`endif
`ifdef FPGA_ICE
     ,.IMDR2                    (   IMDR2                       )
`endif
`ifdef FPGA_ICE
     ,.IMDR1                    (   IMDR1                       )
`endif
`ifdef FPGA_ICE
     ,.IMDR0                    (   IMDR0                       )
`endif
`ifdef FPGA_ICE
     ,.IDADR31                  (   IDADR31                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR30                  (   IDADR30                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR29                  (   IDADR29                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR28                  (   IDADR28                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR27                  (   IDADR27                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR26                  (   IDADR26                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR25                  (   IDADR25                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR24                  (   IDADR24                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR23                  (   IDADR23                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR22                  (   IDADR22                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR21                  (   IDADR21                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR20                  (   IDADR20                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR19                  (   IDADR19                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR18                  (   IDADR18                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR17                  (   IDADR17                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR16                  (   IDADR16                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR15                  (   IDADR15                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR14                  (   IDADR14                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR13                  (   IDADR13                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR12                  (   IDADR12                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR11                  (   IDADR11                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR10                  (   IDADR10                     )
`endif
`ifdef FPGA_ICE
     ,.IDADR9                   (   IDADR9                      )
`endif
`ifdef FPGA_ICE
     ,.IDADR8                   (   IDADR8                      )
`endif
`ifdef FPGA_ICE
     ,.IDADR7                   (   IDADR7                      )
`endif
`ifdef FPGA_ICE
     ,.IDADR6                   (   IDADR6                      )
`endif
`ifdef FPGA_ICE
     ,.IDADR5                   (   IDADR5                      )
`endif
`ifdef FPGA_ICE
     ,.IDADR4                   (   IDADR4                      )
`endif
`ifdef FPGA_ICE
     ,.IDADR3                   (   IDADR3                      )
`endif
`ifdef FPGA_ICE
     ,.IDADR2                   (   IDADR2                      )
`endif
`ifdef FPGA_ICE
     ,.IDADR1                   (   IDADR1                      )
`endif
`ifdef FPGA_ICE
     ,.IDADR0                   (   IDADR0                      )
`endif
`ifdef FPGA_ICE
     ,.STAGEADR1                (   STAGEADR1                   )
`endif
`ifdef FPGA_ICE
     ,.STAGEADR0                (   STAGEADR0                   )
`endif
`ifdef FPGA_ICE
     ,.PREFIX                   (   PREFIX                      )
`endif
`ifdef FPGA_ICE
     ,.PCWAITF                  (   PCWAITF                     )
`endif
`ifdef FPGA_ICE
     ,.ICEMSKNMI                (   ICEMSKNMI                   )
`endif
`ifdef FPGA_ICE
     ,.ICEMSKDBG                (   ICEMSKDBG                   )
`endif
`ifdef FPGA_ICE
     ,.CPUMASK                  (   CPUMASK                     )
`endif
`ifdef FPGA_ICE
     ,.CPUMISAL                 (   CPUMISAL                    )
`endif
`ifdef FPGA_ICE
     ,.SPREL                    (   SPREL                       )
`endif
`ifdef FPGA_ICE
     ,.OCDMOD                   (   OCDMOD                      )
`endif
     ,.pgcsc_intclm             (   pgcsc_intclm                )
     ,.timd_0_irreq0            (   timd_0_irreq0               )
     ,.timd_0_irreq1            (   timd_0_irreq1               )
     ,.lin3_0_int_s             (   lin3_0_int_s                )
     ,.iic_0_intiic0            (   iic_0_intiic0               )
     ,.ifil_intp11              (   ifil_intp11                 )
     ,.int_stbrele              (   int_stbrele                 )
     ,.clk_scan                 (   clk_scan                    )
     ,.tau_1_int3               (   tau_1_int3                  )
     ,.tau_1_int2               (   tau_1_int2                  )
     ,.tau_1_int1               (   tau_1_int1                  )
     ,.tau_1_int0               (   tau_1_int0                  )
     ,.comp_cirq                (   comp_cirq                   )
     ,.timj_0_reqirq_k          (   timj_0_reqirq_k             )
     ,.timd_0_reqimfd1          (   timd_0_reqimfd1             )
     ,.timd_0_reqimfc1          (   timd_0_reqimfc1             )
     ,.timd_0_reqimfb1          (   timd_0_reqimfb1             )
     ,.timd_0_reqimfa1          (   timd_0_reqimfa1             )
     ,.timd_0_reqimfd0          (   timd_0_reqimfd0             )
     ,.timd_0_reqimfc0          (   timd_0_reqimfc0             )
     ,.timd_0_reqimfb0          (   timd_0_reqimfb0             )
     ,.timd_0_reqimfa0          (   timd_0_reqimfa0             )
     ,.tau_0_int7               (   tau_0_int7                  )
     ,.tau_0_int6               (   tau_0_int6                  )
     ,.tau_0_int5               (   tau_0_int5                  )
     ,.tau_0_int4               (   tau_0_int4                  )
     ,.tau_0_int3               (   tau_0_int3                  )
     ,.tau_0_int2               (   tau_0_int2                  )
     ,.tau_0_int1               (   tau_0_int1                  )
     ,.tau_0_int0               (   tau_0_int0                  )
     ,.rcn_comfrx_int           (   rcn_comfrx_int              )
     ,.lin3_0_int_t             (   lin3_0_int_t                )
     ,.lin3_0_int_r             (   lin3_0_int_r                )
     ,.sau_1_intsau0            (   sau_1_intsau0               )
     ,.sau_1_intsau1            (   sau_1_intsau1               )
     ,.sau_0_intsau0            (   sau_0_intsau0               )
     ,.sau_0_intsau1            (   sau_0_intsau1               )
     ,.adc_intad                (   adc_intad                   )
     ,.krif_intkr               (   krif_intkr                  )
     ,.ifil_intp6               (   ifil_intp6                  )
     ,.ifil_intp5               (   ifil_intp5                  )
     ,.ifil_intp4               (   ifil_intp4                  )
     ,.ifil_intp3               (   ifil_intp3                  )
     ,.ifil_intp2               (   ifil_intp2                  )
     ,.ifil_intp1               (   ifil_intp1                  )
     ,.ifil_intp0               (   ifil_intp0                  )
     ,.dtc_intdtc33             (   dtc_intdtc33                )
     ,.dtc_intdtc32             (   dtc_intdtc32                )
     ,.dtc_intdtc31             (   dtc_intdtc31                )
     ,.dtc_intdtc30             (   dtc_intdtc30                )
     ,.dtc_intdtc29             (   dtc_intdtc29                )
     ,.dtc_intdtc28             (   dtc_intdtc28                )
     ,.dtc_intdtc27             (   dtc_intdtc27                )
     ,.dtc_intdtc26             (   dtc_intdtc26                )
     ,.dtc_intdtc7              (   dtc_intdtc7                 )
     ,.dtc_intdtc6              (   dtc_intdtc6                 )
     ,.dtc_intdtc5              (   dtc_intdtc5                 )
     ,.dtc_reqpclkdt            (   dtc_reqpclkdt               )
     ,.clk_pclkdt               (   clk_pclkdt                  )
     ,.ocd_ocdmod               (   ocd_ocdmod                  )
     ,.ocd_svstop               (   ocd_svstop                  )
     ,.ocd_svperi0              (   ocd_svperi0                 )
     ,.ocd_svperi1              (   ocd_svperi1                 )
     ,.pt_ocd_rxocd             (   pt_ocd_rxocd                )
     ,.ocd_txocd                (   ocd_txocd                   )
     ,.ocd_sprgmod              (   ocd_sprgmod                 )
     ,.clk_fihocd               (   clk_fihocd                  )
     ,.pt_ocd_toolrx            (   pt_ocd_toolrx               )
     ,.ocd_sltrxtx              (   ocd_sltrxtx                 )
     ,.ocd_reqocd               (   ocd_reqocd                  )
     ,.ocd_trcma                (   ocd_trcma[6:0]              )
     ,.ocd_trcmdw               (   ocd_trcmdw[19:0]            )
     ,.ocd_trcwr                (   ocd_trcwr                   )
     ,.clk_ocd_loco             (   clk_ocd_loco                )
     ,.ocd_hpimod               (   ocd_hpimod                  )
     ,.cibd_dce0                (   cibd_dce0                   )
     ,.cibd_da                  (   cibd_da[13:0]               )
     ,.fdata_dro0               (   fdata_dro0[11:0]            )
     ,.cibd_dclksel1            (   cibd_dclksel1               )
     ,.cibd_dsrcut              (   cibd_dsrcut                 )
     ,.cibd_dflstop             (   cibd_dflstop                )
     ,.clk_drdclkc1             (   clk_drdclkc1                )
     ,.flcp_rdsetup             (   flcp_rdsetup                )
     ,.cibc_frsel               (   cibc_frsel[4:0]             )
     ,.cibc_opclkmb             (   cibc_opclkmb                )
     ,.cibc_opwden              (   cibc_opwden                 )
     ,.cibc_opwdstby            (   cibc_opwdstby               )
     ,.cibc_opocden             (   cibc_opocden                )
     ,.cibc_selin1              (   cibc_selin1                 )
     ,.cibc_trmcp0              (   cibc_trmcp0[17:0]           )
     ,.cibc_trmcp1              (   cibc_trmcp1[14:10]          )
     ,.cibc_dtrmcp0             (   cibc_dtrmcp0[14:10]         )
     ,.cibc_rtrmcp0             (   cibc_rtrmcp0[20:15]         )
     ,.cibc_ce0                 (   cibc_ce0                    )
     ,.cibc_a                   (   cibc_a[19:2]                )
     ,.fcode0_ro0               (   fcode0_ro0[37:0]            )
     ,.cibc_exa                 (   cibc_exa                    )
     ,.cibc_bfa                 (   cibc_bfa                    )
     ,.cibc_clksel1             (   cibc_clksel1                )
     ,.cibc_srcut               (   cibc_srcut                  )
     ,.cibc_flstop              (   cibc_flstop                 )
     ,.cibc_sub                 (   cibc_sub                    )
     ,.cibc_hispeed             (   cibc_hispeed                )
     ,.cibc_frqsel              (   cibc_frqsel[4:0]            )
     ,.cibc_rlowspy             (   cibc_rlowspy                )
     ,.cibc_lowpower            (   cibc_lowpower               )
     ,.cibc_ctrim               (   cibc_ctrim[6:0]             )
     ,.cibc_wtrim               (   cibc_wtrim[2:0]             )
     ,.cibc_ftrim               (   cibc_ftrim[5:0]             )
     ,.cibc_rtrim               (   cibc_rtrim[5:0]             )
     ,.cibc_bgrt                (   cibc_bgrt[10:0]             )
     ,.cibc_bbnvm2              (   cibc_bbnvm2                 )
     ,.flcp_trmrd1ck            (   flcp_trmrd1ck               )
     ,.flcp_trmrd2ck            (   flcp_trmrd2ck               )
     ,.cibc_brsam               (   cibc_brsam                  )
     ,.cibc_r0flagz_n           (   cibc_r0flagz_n              )
     ,.cibc_r1flagz_n           (   cibc_r1flagz_n              )
     ,.cibc_r0a                 (   cibc_r0a[7:0]               )
     ,.cibc_r1a                 (   cibc_r1a[7:0]               )
     ,.cibc_oscnostp            (   cibc_oscnostp               )
     ,.cibc_oscouten            (   cibc_oscouten               )
     ,.capmx_frq4en             (   capmx_frq4en                )
     ,.fcb_lowspy               (   fcb_lowspy                  )
     ,.fcb_cwee                 (   fcb_cwee                    )
     ,.fcb_ddis                 (   fcb_ddis                    )
     ,.fcb_dread                (   fcb_dread                   )
     ,.fcb_dmrg00               (   fcb_dmrg00                  )
     ,.fcb_dmrg01               (   fcb_dmrg01                  )
     ,.fcb_dmrg10               (   fcb_dmrg10                  )
     ,.fcb_dmrg11               (   fcb_dmrg11                  )
     ,.fcb_dmrg12               (   fcb_dmrg12                  )
     ,.fcb_dser                 (   fcb_dser                    )
     ,.fcb_dwwr                 (   fcb_dwwr                    )
     ,.fcb_dcer                 (   fcb_dcer                    )
     ,.fcb_dis                  (   fcb_dis                     )
     ,.fcb_read                 (   fcb_read                    )
     ,.fcb_mrg00                (   fcb_mrg00                   )
     ,.fcb_mrg01                (   fcb_mrg01                   )
     ,.fcb_mrg10                (   fcb_mrg10                   )
     ,.fcb_mrg11                (   fcb_mrg11                   )
     ,.fcb_mrg12                (   fcb_mrg12                   )
     ,.fcb_wwr                  (   fcb_wwr                     )
     ,.fcb_mswr                 (   fcb_mswr                    )
     ,.fcb_cer                  (   fcb_cer                     )
     ,.fcb_ser                  (   fcb_ser                     )
     ,.fcb_exer                 (   fcb_exer                    )
     ,.fcb_stchk                (   fcb_stchk                   )
     ,.fcb_ionchk1              (   fcb_ionchk1                 )
     ,.fcb_rdt                  (   fcb_rdt                     )
     ,.fcb_rdmrg1               (   fcb_rdmrg1                  )
     ,.fcb_rdmrg0               (   fcb_rdmrg0                  )
     ,.fcb_rdmrgc               (   fcb_rdmrgc                  )
     ,.fcb_wdt1                 (   fcb_wdt1                    )
     ,.fcb_wdt2                 (   fcb_wdt2                    )
     ,.fcb_wdt3                 (   fcb_wdt3                    )
     ,.fcb_wdt4                 (   fcb_wdt4                    )
     ,.fcb_cpbt                 (   fcb_cpbt                    )
     ,.fcb_saceen_n             (   fcb_saceen_n                )
     ,.fcb_ireft                (   fcb_ireft                   )
     ,.fcb_cpt                  (   fcb_cpt                     )
     ,.fcb_extvpp2              (   fcb_extvpp2                 )
     ,.fcb_extvpp1              (   fcb_extvpp1                 )
     ,.fcb_meoc                 (   fcb_meoc                    )
     ,.fcb_meor                 (   fcb_meor                    )
     ,.fcb_beu                  (   fcb_beu[2:0]                )
     ,.fcb_modidis              (   fcb_modidis                 )
     ,.tfwepr                   (   tfwepr                      )
     ,.fcb_wed                  (   fcb_wed                     )
     ,.fcb_dwed                 (   fcb_dwed                    )
     ,.fcb_dw                   (   fcb_dw[37:0]                )
     ,.fcb_fclk1                (   fcb_fclk1                   )
     ,.fcb_fclk2                (   fcb_fclk2                   )
     ,.clk_rdclkp1              (   clk_rdclkp1                 )
     ,.fcb_progi                (   fcb_progi                   )
     ,.icenoecc                 (   icenoecc                    )
     ,.iceflerr                 (   iceflerr                    )
     ,.fcb_mutest               (   fcb_mutest                  )
     ,.bbr_csc_penable          (   bbr_csc_penable             )
     ,.clk_fmx                  (   clk_fmx                     )
     ,.clk_fsl                  (   clk_fsl                     )
     ,.clk_fhoco                (   clk_fhoco                   )
     ,.clk_fil                  (   clk_fil                     )
     ,.regm_pocrel              (   regm_pocrel                 )
     ,.nf_pocrelnf              (   nf_pocrelnf                 )
     ,.rst_resetinbnf_n         (   rst_resetinbnf_n            )
     ,.nf_lvioutznf             (   nf_lvioutznf                )
     ,.clk_baseck               (   clk_baseck                  )
     ,.clk_baseckhs             (   clk_baseckhs                )
     ,.clk_pclkocd              (   clk_pclkocd                 )
     ,.clk_rtc_pclk             (   clk_rtc_pclk                )
     ,.clk_iic_1_pclk           (   clk_iic_1_pclk              )
     ,.clk_adc_pclk             (   clk_adc_pclk                )
     ,.clk_iic_0_pclk           (   clk_iic_0_pclk              )
     ,.clk_sau_1_pclk           (   clk_sau_1_pclk              )
     ,.clk_sau_0_pclk           (   clk_sau_0_pclk              )
     ,.clk_tau_1_pclk           (   clk_tau_1_pclk              )
     ,.clk_tau_0_pclk           (   clk_tau_0_pclk              )
     ,.rst_res_n                (   rst_res_n                   )
     ,.rst_nsres_n              (   rst_nsres_n                 )
     ,.rst_rtc_res_n            (   rst_rtc_res_n               )
     ,.rst_iic_1_res_n          (   rst_iic_1_res_n             )
     ,.rst_adc_res_n            (   rst_adc_res_n               )
     ,.rst_iic_0_res_n          (   rst_iic_0_res_n             )
     ,.rst_sau_1_res_n          (   rst_sau_1_res_n             )
     ,.rst_sau_0_res_n          (   rst_sau_0_res_n             )
     ,.rst_tau_1_res_n          (   rst_tau_1_res_n             )
     ,.rst_tau_0_res_n          (   rst_tau_0_res_n             )
     ,.csc_resstp               (   csc_resstp                  )
     ,.csc_cpustart             (   csc_cpustart                )
     ,.csc_oscsel               (   csc_oscsel                  )
     ,.csc_mstop                (   csc_mstop                   )
     ,.csc_exclk                (   csc_exclk                   )
     ,.csc_amph                 (   csc_amph                    )
     ,.csc_oscsels              (   csc_oscsels                 )
     ,.csc_xtstop               (   csc_xtstop                  )
     ,.csc_exclks               (   csc_exclks                  )
     ,.csc_amphs0               (   csc_amphs0                  )
     ,.csc_r32mstp              (   csc_r32mstp                 )
     ,.csc_r15kstpz_n           (   csc_r15kstpz_n              )
     ,.csc_reglc                (   csc_reglc                   )
     ,.csc_reglv                (   csc_reglv                   )
     ,.csc_oregstp              (   csc_oregstp                 )
     ,.rst_sysres_n             (   rst_sysres_n                )
     ,.rst_reset_n              (   rst_reset_n                 )
     ,.csc_lvien                (   csc_lvien                   )
     ,.csc_lvis                 (   csc_lvis[3:0]               )
     ,.csc_pstn_n               (   csc_pstn_n                  )
     ,.csc_amphs1               (   csc_amphs1                  )
     ,.csc_xtwkup               (   csc_xtwkup                  )
     ,.clk_fclkrt               (   clk_fclkrt                  )
     ,.iceck60m                 (   iceck60m                    )
     ,.icemkwdt                 (   icemkwdt                    )
     ,.icemklvi                 (   icemklvi                    )
     ,.icemksrq                 (   icemksrq                    )
     ,.csc_tseloreg             (   csc_tseloreg                )
     ,.csc_tselires             (   csc_tselires                )
     ,.csc_ttemp                (   csc_ttemp                   )
     ,.csc_losctest             (   csc_losctest                )
     ,.csc_tstn                 (   csc_tstn                    )
     ,.csc_per0                 (   csc_per0[7:0]               )
     ,.csc_stpbckbt             (   csc_stpbckbt                )
     ,.clk_pclkrw               (   clk_pclkrw                  )
     ,.csc_cken                 (   csc_cken[15:1]              )
     ,.csc_rt0lpm               (   csc_rt0lpm                  )
     ,.capmx_bbckselr           (   capmx_bbckselr              )
     ,.capmx_bbckselm           (   capmx_bbckselm              )
     ,.clk_fmp_div              (   clk_fmp_div                 )
     ,.sau_0_reqpclk            (   sau_0_reqpclk               )
     ,.adc_reqpclk              (   adc_reqpclk                 )
     ,.capmx_bbreqpclk          (   capmx_bbreqpclk             )
     ,.flcp_reqfl               (   flcp_reqfl                  )
     ,.clk_ex_fil               (   clk_ex_fil                  )
     ,.clk_scan_ex              (   clk_scan_ex                 )
     ,.csc_cpuclken             (   csc_cpuclken                )
     ,.csc_rtcclken             (   csc_rtcclken                )
     ,.ramif_rperr              (   ramif_rperr                 )
     ,.clk_pclktst              (   clk_pclktst                 )
     ,.clk_fsub                 (   clk_fsub                    )
     ,.csc_paenb_n              (   csc_paenb_n                 )
     ,.csc_lvitest              (   csc_lvitest                 )
     ,.csc_lvitsel              (   csc_lvitsel                 )
     ,.clk_pclkfcb              (   clk_pclkfcb                 )
     ,.csc_mcm0                 (   csc_mcm0                    )
     ,.csc_rsts                 (   csc_rsts                    )
     ,.capmx_bbrperr            (   capmx_bbrperr               )
     ,.csc_bbckstr              (   csc_bbckstr                 )
     ,.pgcsc_pllrgctl           (   pgcsc_pllrgctl              )
     ,.capmx_bbhioon            (   capmx_bbhioon               )
     ,.csc_bbckstm              (   csc_bbckstm                 )
     ,.csc_ampsel               (   csc_ampsel                  )
     ,.csc_fmxst                (   csc_fmxst                   )
     ,.csc_subckst              (   csc_subckst                 )
     ,.csc_bckhsen              (   csc_bckhsen                 )
     ,.flcp_trmrd1              (   flcp_trmrd1                 )
     ,.pgcsc_bbper              (   pgcsc_bbper                 )
     ,.capmx_bbmode             (   capmx_bbmode                )
     ,.pt_mod_tin00             (   pt_mod_tin00                )
     ,.mod_rngin6               (   clk_fpll64m_gating          )
     ,.mod_rngin5               (   clk_wdt_loscout_gating      )
     ,.clk_oscoutcp             (   clk_oscoutcp                )
     ,.mod_routsrc15            (   clk_fmp_div_gating          )
     ,.mod_routsrc14            (   clk_wdt_loscout_gating      )
     ,.dly300_dly300no          (   dly300_dly300no             )
     ,.pt_mod_routsrc12         (   pt_mod_routsrc12            )
     ,.dly50_dly50no            (   dly50_dly50no               )
     ,.pt_mod_routsrc10         (   pt_mod_routsrc10            )
     ,.mod_routsrc8             (   pull_down0                  )
     ,.mod_gofirm               (   mod_gofirm                  )
     ,.mod_testmod              (   mod_testmod                 )
     ,.mod_scanmode             (   mod_scanmode                )
     ,.mod_tesscan1             (   mod_tesscan1                )
     ,.mod_tesinst              (   mod_tesinst                 )
     ,.mod_bbtesinst            (   mod_bbtesinst               )
     ,.mod_tesdbt               (   mod_tesdbt                  )
     ,.mod_optram               (   mod_optram                  )
     ,.mod_optiddq              (   mod_optiddq                 )
     ,.mod_optexcck             (   mod_optexcck                )
     ,.mod_optoplrd             (   mod_optoplrd                )
     ,.mod_optbct               (   mod_optbct                  )
     ,.mod_rammulti             (   mod_rammulti                )
     ,.mod_mdlycut              (   mod_mdlycut                 )
     ,.mod_raedis               (   mod_raedis                  )
     ,.mod_seltar               (   mod_seltar                  )
     ,.mod_oti00                (   mod_oti00                   )
     ,.mod_tesdbt2              (   mod_tesdbt2                 )
     ,.mod_moderd               (   mod_moderd                  )
     ,.mod_modewr               (   mod_modewr                  )
     ,.mod_modenop              (   mod_modenop                 )
     ,.mod_incdecws1            (   mod_incdecws1               )
     ,.mod_incdecws0            (   mod_incdecws0               )
     ,.mod_ta                   (   mod_ta[17:0]                )
     ,.rtc_rt0mon0              (   rtc_rt0mon0                 )
     ,.rtc_rt0mon1              (   rtc_rt0mon1                 )
     ,.pt_mod_tdin5             (   pt_mod_tdin5                )
     ,.pt_mod_tdin4             (   pt_mod_tdin4                )
     ,.pt_mod_tdin3             (   pt_mod_tdin3                )
     ,.pt_mod_tdin2t            (   pt_mod_tdin2t               )
     ,.pt_mod_tdin2r            (   pt_mod_tdin2r               )
     ,.pt_mod_tdin2b            (   pt_mod_tdin2b               )
     ,.pt_mod_tdin2l            (   pt_mod_tdin2l               )
     ,.pt_mod_tdin1t            (   pt_mod_tdin1t               )
     ,.pt_mod_tdin1r            (   pt_mod_tdin1r               )
     ,.pt_mod_tdin1b            (   pt_mod_tdin1b               )
     ,.pt_mod_tdin1l            (   pt_mod_tdin1l               )
     ,.pt_mod_tdin0t            (   pt_mod_tdin0t               )
     ,.pt_mod_tdin0r            (   pt_mod_tdin0r               )
     ,.pt_mod_tdin0b            (   pt_mod_tdin0b               )
     ,.pt_mod_tdin0l            (   pt_mod_tdin0l               )
     ,.clk_exclk1               (   clk_exclk1                  )
     ,.mod_teseni4              (   mod_teseni4                 )
     ,.mod_teseni3              (   mod_teseni3                 )
     ,.mod_teseni2t             (   mod_teseni2t                )
     ,.mod_teseni2r             (   mod_teseni2r                )
     ,.mod_teseni2b             (   mod_teseni2b                )
     ,.mod_teseni2l             (   mod_teseni2l                )
     ,.mod_teseni1t             (   mod_teseni1t                )
     ,.mod_teseni1r             (   mod_teseni1r                )
     ,.mod_teseni1b             (   mod_teseni1b                )
     ,.mod_teseni1l             (   mod_teseni1l                )
     ,.mod_teseni0t             (   mod_teseni0t                )
     ,.mod_teseni0r             (   mod_teseni0r                )
     ,.mod_teseni0b             (   mod_teseni0b                )
     ,.mod_teseni0l             (   mod_teseni0l                )
     ,.mod_teseno3              (   mod_teseno3                 )
     ,.mod_teseno2t             (   mod_teseno2t                )
     ,.mod_teseno2r             (   mod_teseno2r                )
     ,.mod_teseno2b             (   mod_teseno2b                )
     ,.mod_teseno2l             (   mod_teseno2l                )
     ,.mod_teseno1t             (   mod_teseno1t                )
     ,.mod_teseno1r             (   mod_teseno1r                )
     ,.mod_teseno1b             (   mod_teseno1b                )
     ,.mod_teseno1l             (   mod_teseno1l                )
     ,.mod_teseno0t             (   mod_teseno0t                )
     ,.mod_teseno0r             (   mod_teseno0r                )
     ,.mod_teseno0b             (   mod_teseno0b                )
     ,.mod_teseno0l             (   mod_teseno0l                )
     ,.mod_tdsel3               (   mod_tdsel3                  )
     ,.mod_tdsel2t              (   mod_tdsel2t                 )
     ,.mod_tdsel2r              (   mod_tdsel2r                 )
     ,.mod_tdsel2b              (   mod_tdsel2b                 )
     ,.mod_tdsel2l              (   mod_tdsel2l                 )
     ,.mod_tdsel1t              (   mod_tdsel1t                 )
     ,.mod_tdsel1r              (   mod_tdsel1r                 )
     ,.mod_tdsel1b              (   mod_tdsel1b                 )
     ,.mod_tdsel1l              (   mod_tdsel1l                 )
     ,.mod_tdsel0t              (   mod_tdsel0t                 )
     ,.mod_tdsel0r              (   mod_tdsel0r                 )
     ,.mod_tdsel0b              (   mod_tdsel0b                 )
     ,.mod_tdsel0l              (   mod_tdsel0l                 )
     ,.mod_tdout3               (   mod_tdout3                  )
     ,.mod_tdout2               (   mod_tdout2                  )
     ,.mod_tdout1               (   mod_tdout1                  )
     ,.mod_tdout0               (   mod_tdout0                  )
     ,.mod_scanin               (   mod_scanin                  )
     ,.clk_scan_pre             (   clk_scan_pre                )
     ,.mod_scanen               (   mod_scanen                  )
     ,.rst_scanres_n            (   rst_scanres_n               )
     ,.capmx_bbscanout          (   capmx_bbscanout             )
     ,.porga_iawen              (   porga_iawen                 )
     ,.porga_gdram              (   porga_gdram[1:0]            )
     ,.iaw_gdramwr              (   iaw_gdramwr                 )
     ,.clk_fihfl                (   clk_fihfl                   )
     ,.clk_tfhoco               (   clk_tfhoco                  )
     ,.clk_tfil                 (   clk_tfil                    )
     ,.clk_tfihfl               (   clk_tfihfl                  )
     ,.clk_tfihocd              (   clk_tfihocd                 )
     ,.rst_preset_wdt_n         (   rst_preset_wdt_n            )
     ,.pgcsc_wden               (   pgcsc_wden                  )
     ,.clk_wdt_loscout          (   clk_wdt_loscout             )
     ,.bbr_bbrsub_apbmask       (   bbr_bbrsub_apbmask          )
     ,.bbr_bbrsub_psel1st       (   bbr_bbrsub_psel1st          )
     ,.bbr_bbrsub_psel2nd       (   bbr_bbrsub_psel2nd          )
     ,.bbr_cpusys_padr          (   bbr_cpusys_padr[4:0]        )
     ,.bbr_cpusys_penable       (   bbr_cpusys_penable          )
     ,.bbr_cpusys_pwdata        (   bbr_cpusys_pwdata[15:0]     )
     ,.bbr_cpusys_pwrite        (   bbr_cpusys_pwrite           )
     ,.bbr_penable              (   bbr_penable                 )
     ,.bbr_pgcsc_psel           (   bbr_pgcsc_psel              )
     ,.bbr_prdctl               (   bbr_prdctl[7:0]             )
     ,.bbr_prdsel_pclm          (   bbr_prdsel_pclm[3:0]        )
     ,.bbr_wdtliotrm            (   bbr_wdtliotrm[7:0]          )
     ,.bbrsub_prdata            (   bbrsub_prdata[15:0]         )
     ,.pgcsc_prdata             (   pgcsc_prdata[15:0]          )
     ,.porga_gdcsc              (   porga_gdcsc                 )
     ,.porga_gdint              (   porga_gdint                 )
     ,.ramif_prdata             (   ramif_prdata[15:0]          )
`ifdef RL78_BBUSE
     ,.bbr_bbadr                (   bbr_bbadr[15:0]             )
`endif
`ifdef RL78_BBUSE
     ,.bbr_bbmdw                (   bbr_bbmdw[15:0]             )
`endif
`ifdef RL78_BBUSE
     ,.bbr_bbpenable            (   bbr_bbpenable               )
`endif
`ifdef RL78_BBUSE
     ,.bbr_bbpwrite             (   bbr_bbpwrite                )
`endif
`ifdef RL78_BBUSE
     ,.bbr_bbselsfr1st          (   bbr_bbselsfr1st             )
`endif
`ifdef RL78_BBUSE
     ,.bbr_bbselsfr2nd          (   bbr_bbselsfr2nd             )
`endif
`ifdef RL78_BBUSE
     ,.capmx_bbprdata           (   capmx_bbprdata[15:0]        )
`endif
     ,.capmx_bbint0             (   capmx_bbint0                )
     ,.capmx_bbint1             (   capmx_bbint1                )
     ,.capmx_bbint10            (   capmx_bbint10               )
     ,.capmx_bbint11            (   capmx_bbint11               )
     ,.capmx_bbint12            (   capmx_bbint12               )
     ,.capmx_bbint13            (   capmx_bbint13               )
     ,.capmx_bbint2             (   capmx_bbint2                )
     ,.capmx_bbint3             (   capmx_bbint3                )
     ,.capmx_bbint4             (   capmx_bbint4                )
     ,.capmx_bbint5             (   capmx_bbint5                )
     ,.capmx_bbint6             (   capmx_bbint6                )
     ,.capmx_bbint7             (   capmx_bbint7                )
     ,.capmx_bbint8             (   capmx_bbint8                )
     ,.capmx_bbint9             (   capmx_bbint9                )
     ,.ifil_intp10              (   ifil_intp10                 )
     ,.ifil_intp7               (   ifil_intp7                  )
     ,.ifil_intp8               (   ifil_intp8                  )
     ,.ifil_intp9               (   ifil_intp9                  )
     ,.porga_intdtc5            (   porga_intdtc5               )
     ,.porga_intdtc6            (   porga_intdtc6               )
     ,.porga_intdtc7            (   porga_intdtc7               )
     ,.pt_crx_in_int            (   pt_crx_in_int               )
     ,.rcn_cherr_int            (   rcn_cherr_int               )
     ,.rcn_glerr_int            (   rcn_glerr_int               )
     ,.rcn_rxf_int              (   rcn_rxf_int                 )
     ,.rcn_tx_int               (   rcn_tx_int                  )
     ,.rtc_intrtc               (   rtc_intrtc                  )
     ,.tau_0_inth1              (   tau_0_inth1                 )
     ,.tau_0_inth3              (   tau_0_inth3                 )
     ,.tau_1_inth1              (   tau_1_inth1                 )
     ,.tau_1_inth3              (   tau_1_inth3                 )
     ,.rst_treset               (   rst_treset                  )
     ,.oscm_x2din               (   oscm_x2din                  )
     ,.pt_mod_hvin              (   pt_mod_hvin                 )
     ,.hram_0_ramq              (   hram_0_ramq[12:0]           )
     ,.hram_1_ramq              (   hram_1_ramq[12:0]           )
     ,.hram_2_ramq              (   hram_2_ramq[12:0]           )
     ,.hram_3_ramq              (   hram_3_ramq[12:0]           )
     ,.clk_ramclk               (   clk_ramclk                  )
     ,.ramif_cen0_n             (   ramif_cen0_n                )
     ,.ramif_cen1_n             (   ramif_cen1_n                )
     ,.ramif_cen2_n             (   ramif_cen2_n                )
     ,.ramif_cen3_n             (   ramif_cen3_n                )
     ,.ramif_ramd0              (   ramif_ramd0[12:0]           )
     ,.ramif_ramd1              (   ramif_ramd1[12:0]           )
     ,.ramif_ramd2              (   ramif_ramd2[12:0]           )
     ,.ramif_ramd3              (   ramif_ramd3[12:0]           )
     ,.ramif_rama               (   ramif_rama[10:0]            )
     ,.ramif_wen_n              (   ramif_wen_n                 )
     ,.ramif_stn_n              (   ramif_stn_n                 )
     ,.ramif_mode               (   ramif_mode[1:0]             )
     ,.ramif_cmt                (   ramif_cmt                   )
     ,.ramif_rcn_cmt            (   ramif_rcn_cmt               )
     );
//=================================================================
//===   crl78hpgcsc_f14mid : pgcsc
//=================================================================
  crl78hpgcsc_f14mid  pgcsc  (
      .rst_res_n                (   rst_res_n                   )
     ,.rst_reset_n              (   rst_reset_n                 )
     ,.rst_nsreset_n            (   rst_nsres_n                 )
     ,.clk_pclkrw               (   clk_pclkrw                  )
     ,.bbr_pgcsc_psel           (   bbr_pgcsc_psel              )
     ,.bbr_cpusys_penable       (   bbr_cpusys_penable          )
     ,.bbr_cpusys_pwrite        (   bbr_cpusys_pwrite           )
     ,.bbr_cpusys_padr          (   bbr_cpusys_padr[3:0]        )
     ,.bbr_cpusys_pwdata        (   bbr_cpusys_pwdata[15:0]     )
     ,.clk_fclk                 (   clk_fclkrt                  )
     ,.clk_pclktst              (   clk_pclktst                 )
     ,.pgcsc_prdata             (   pgcsc_prdata[15:0]          )
     ,.pgcsc_dspclkrwen         (   pgcsc_dspclkrwen            )
     ,.clk_dspclkrw             (   clk_dspclkrw                )
     ,.mod_scanmode             (   mod_scanmode                )
     ,.clk_pre_sck              (   clk_scan_pre                )
     ,.mod_scanen               (   mod_scanen                  )
     ,.sin                      (   pull_down1                  )
     ,.rst_scanreset_n          (   rst_scanres_n               )
     ,.sout                     (   pgcsc_sout                  )
     ,.clk_scan                 (   clk_scan                    )
     ,.clk_oscoutm              (   clk_fmx                     )
     ,.clk_r32mout              (   clk_fhoco                   )
     ,.clk_oscouts              (   clk_fsx                     )
     ,.clk_loscout              (   clk_fil                     )
     ,.clk_fmain                (   clk_fmain                   )
     ,.clk_fpll64m              (   clk_fpll64m                 )
     ,.mcm0                     (   csc_mcm0                    )
     ,.clk_fmp_div              (   clk_fmp_div                 )
     ,.clk_fsl                  (   clk_fsl                     )
     ,.clk_fsl_nf               (   clk_fsub                    )
     ,.cibc_frqsel4             (   cibc_frqsel[4]              )
     ,.csc_rsts                 (   csc_rsts                    )
     ,.csc_r15kstpz             (   csc_r15kstpz_n              )
     ,.cibc_opocden             (   cibc_opocden                )
     ,.cibc_opclkmb             (   cibc_opclkmb                )
     ,.mod_optiddq              (   mod_optiddq                 )
     ,.pgcsc_r15kstpz           (   pgcsc_r15kstpz              )
     ,.cibc_opwdstby            (   cibc_opwdstby               )
     ,.cibc_opwden              (   cibc_opwden                 )
     ,.cpu_hltst                (   cpu_hltst                   )
     ,.cpu_stpst                (   cpu_stpst                   )
     ,.bbr_frsel4               (   bbr_wdtliotrm[4]            )
     ,.bbr_frsel3               (   bbr_wdtliotrm[3]            )
     ,.bbr_frsel2               (   bbr_wdtliotrm[2]            )
     ,.bbr_frsel1               (   bbr_wdtliotrm[1]            )
     ,.bbr_frsel0               (   bbr_wdtliotrm[0]            )
     ,.clk_wdt_loscout          (   clk_wdt_loscout             )
     ,.timj_0_prsclen           (   timj_0_prsclen              )
     ,.clk_trj_pclk             (   clk_timj_0_pclk             )
     ,.preset_trj_n             (   rst_timj_0_res_n            )
     ,.bbrsub_timd_0_pselal     (   bbrsub_timd_0_pselal        )
     ,.ocd_svperi0              (   ocd_svperi0                 )
     ,.clk_trd_pclk             (   clk_timd_0_pclk             )
     ,.clk_trd_pclk2            (   pgcsc_dscken1               )
     ,.clk_trd_pclk4            (   pgcsc_dscken2               )
     ,.clk_trd_pclk8            (   pgcsc_dscken3               )
     ,.clk_trd_pclk32           (   pgcsc_dscken5               )
     ,.preset_trd_n             (   rst_timd_0_res_n            )
     ,.clk_dac_pclk             (   clk_dac_pclk                )
     ,.preset_dac_n             (   rst_dac_res_n               )
     ,.comp_cdfs                (   comp_cdfs[1:0]              )
     ,.clk_cmp_pclk             (   clk_comp_pclk               )
     ,.preset_cmp_n             (   rst_comp_res_n              )
     ,.dtc_reqpclk              (   dtc_reqpclkdt               )
     ,.clk_dtc_pclk             (   clk_pclkdt                  )
     ,.lin_reqpclk              (   lin3_0_reqpclk              )
     ,.clk_lin_pclk             (   clk_lin3_0_pclk             )
     ,.clk_lin_mclk             (   clk_clkc                    )
     ,.preset_lin_n             (   rst_lin3_0_res_n            )
     ,.bbr_pcanen               (   bbr_prdctl[0]               )
     ,.clk_can_pclk             (   clk_rcn_pclk                )
     ,.clk_can_x1               (   clk_rcn_clka_can            )
     ,.preset_can_n             (   rst_rcn_presetz             )
     ,.clk_ocd_loco             (   clk_ocd_loco                )
     ,.csc_cls                  (   csc_subckst                 )
     ,.csc_cpustart             (   csc_cpustart                )
     ,.rst_clmreset_n           (   ramif_rperr                 )
     ,.pgcsc_intclm             (   pgcsc_intclm                )
     ,.pgcsc_wden               (   pgcsc_wden                  )
     ,.int_stbrele              (   int_stbrele                 )
     ,.stopst_p31               (   stopst_p31                  )
     ,.stopst_p52               (   stopst_p52                  )
     ,.clk_rtcclk               (   clk_fsx_rtc                 )
     ,.mod_optbct               (   mod_optbct                  )
     ,.clk_rtc_mclk             (   clk_rtc_mclk                )
     ,.clk_rtc_tclk             (   clk_rtc_tclk                )
     ,.pgcsc_cksel              (   pgcsc_cksel                 )
     ,.pocrelnf                 (   nf_pocrelnf                 )
     ,.mod_optexcck             (   mod_optexcck                )
     ,.mod_tesdbt               (   mod_tesdbt                  )
     ,.mod_testmod              (   mod_testmod                 )
     ,.clk_exclk1               (   clk_exclk1                  )
     ,.csc_stpbckbt             (   csc_stpbckbt                )
     ,.pgcsc_pllrgctl           (   pgcsc_pllrgctl              )
     ,.pgcsc_bbper              (   pgcsc_bbper                 )
     ,.csc_oscsels              (   csc_oscsels                 )
     ,.pgcsc_oscsels            (   pgcsc_oscsels               )
     ,.pgcsc_per14              (   pgcsc_per14                 )
     ,.clk_c2ccnt_pclk          (   clk_c2c_pclk                )
     ,.preset_c2ccnt_n          (   rst_c2c_res_n               )
     ,.ocd_ocdmod               (   ocd_ocdmod                  )
     ,.ocd_sprgmod              (   ocd_sprgmod                 )
     ,.mod_gofirm               (   mod_gofirm                  )
     ,.preset_wdt_n             (   rst_preset_wdt_n            )
`ifdef FPGA_ICE
     ,.CLK30MHZ_ICE             (   CLK30MHZ_ICE                )
`endif
`ifdef FPGA_ICE
     ,.CLK60MHZ_ICE             (   CLK60MHZ_ICE                )
`endif
`ifdef FPGA_ICE
     ,.CLK64M_ICE               (   CLK64M_ICE                  )
`endif
`ifdef FPGA_ICE
     ,.CLK48M_ICE               (   CLK48M_ICE                  )
`endif
`ifdef FPGA_ICE
     ,.CLK32M_ICE               (   CLK32M_ICE                  )
`endif
`ifdef FPGA_ICE
     ,.RESB_ICE                 (   RESB_ICE                    )
`endif
`ifdef FPGA_ICE
     ,.SYSRSOUTB_ICE            (   SYSRSOUTB_ICE               )
`endif
`ifdef FPGA_ICE
     ,.PONRESB_ICE              (   PONRESB_ICE                 )
`endif
`ifdef FPGA_ICE
     ,.CPURCLK3_ICE             (   CPURCLK3_ICE                )
`endif
`ifdef FPGA_ICE
     ,.ICEMKCLM                 (   ICEMKCLM                    )
`endif
`ifdef FPGA_ICE
     ,.CPUPRCLK3_ICE            (   CPUPRCLK3_ICE               )
`endif
     );
//=================================================================
//===   QAHIOS0BN32MV2 : h_rosc
//=================================================================
  QAHIOS0BN32MV2  h_rosc  (
      .BGIOREG1                 (   regm_bgioreg1               )
     ,.BGIOREG2                 (   regm_bgioreg2               )
     ,.CTRIM6                   (   cibc_ctrim[6]               )
     ,.CTRIM5                   (   cibc_ctrim[5]               )
     ,.CTRIM4                   (   cibc_ctrim[4]               )
     ,.CTRIM3                   (   cibc_ctrim[3]               )
     ,.CTRIM2                   (   cibc_ctrim[2]               )
     ,.CTRIM1                   (   cibc_ctrim[1]               )
     ,.CTRIM0                   (   cibc_ctrim[0]               )
     ,.EXRTRIM                  (   pull_down2                  )
     ,.FRQSEL5                  (   pull_down3                  )
     ,.FRQSEL4                  (   cibc_frqsel[4]              )
     ,.FRQSEL3                  (   cibc_frqsel[3]              )
     ,.FRQSEL2                  (   cibc_frqsel[2]              )
     ,.FRQSEL1                  (   cibc_frqsel[1]              )
     ,.FRQSEL0                  (   cibc_frqsel[0]              )
     ,.FTRIM5                   (   cibc_ftrim[5]               )
     ,.FTRIM4                   (   cibc_ftrim[4]               )
     ,.FTRIM3                   (   cibc_ftrim[3]               )
     ,.FTRIM2                   (   cibc_ftrim[2]               )
     ,.FTRIM1                   (   cibc_ftrim[1]               )
     ,.FTRIM0                   (   cibc_ftrim[0]               )
     ,.IOSCSTP                  (   csc_r32mstp                 )
     ,.OREGSTP                  (   csc_oregstp                 )
     ,.REQFL                    (   flcp_reqfl                  )
     ,.REQOCD                   (   ocd_reqocd                  )
     ,.POCREL5V                 (   regm_pocrel_v5              )
     ,.RTRIM5                   (   cibc_rtrim[5]               )
     ,.RTRIM4                   (   cibc_rtrim[4]               )
     ,.RTRIM3                   (   cibc_rtrim[3]               )
     ,.RTRIM2                   (   cibc_rtrim[2]               )
     ,.RTRIM1                   (   cibc_rtrim[1]               )
     ,.RTRIM0                   (   cibc_rtrim[0]               )
     ,.TSELIRES                 (   csc_tselires                )
     ,.TSELOREG                 (   csc_tseloreg                )
     ,.TTEMP                    (   csc_ttemp                   )
     ,.VBGOREG                  (   regm_vbg08                  )
     ,.WTRIM2                   (   cibc_wtrim[2]               )
     ,.WTRIM1                   (   cibc_wtrim[1]               )
     ,.WTRIM0                   (   cibc_wtrim[0]               )
     ,.OREGOUT                  (   hhoco_oregout_va            )
     ,.FIHFL                    (   clk_fihfl                   )
     ,.FIHOCD                   (   clk_fihocd                  )
     ,.R32MOUT                  (   clk_fhoco                   )
     ,.TEMP4                    (   hoco_temp[4]                )
     ,.TEMP3                    (   hoco_temp[3]                )
     ,.TEMP2                    (   hoco_temp[2]                )
     ,.TEMP1                    (   hoco_temp[1]                )
     ,.TEMP0                    (   hoco_temp[0]                )
     );
//=================================================================
//===   QAHIOS1BN15KV1 : l_rosc
//=================================================================
  QAHIOS1BN15KV1  l_rosc  (
      .FRSEL4                   (   cibc_frsel[4]               )
     ,.FRSEL3                   (   cibc_frsel[3]               )
     ,.FRSEL2                   (   cibc_frsel[2]               )
     ,.FRSEL1                   (   cibc_frsel[1]               )
     ,.FRSEL0                   (   cibc_frsel[0]               )
     ,.LOSCSTPZ                 (   pgcsc_r15kstpz              )
     ,.LOSCTEST                 (   csc_losctest                )
     ,.LOSCOUT                  (   clk_fil                     )
     );
//=================================================================
//===   umf30QAHMIX3MAIN : regm
//=================================================================
  umf30QAHMIX3MAIN  regm  (
      .RESFB5V                  (   rst_resfb_v5                )
     ,.REGLV                    (   csc_reglv                   )
     ,.REGLC                    (   csc_reglc                   )
     ,.BGRT6                    (   cibc_bgrt[6]                )
     ,.BGRT5                    (   cibc_bgrt[5]                )
     ,.BGRT4                    (   cibc_bgrt[4]                )
     ,.BGRT3                    (   cibc_bgrt[3]                )
     ,.BGRT2                    (   cibc_bgrt[2]                )
     ,.BGRT1                    (   cibc_bgrt[1]                )
     ,.BGRT0                    (   cibc_bgrt[0]                )
     ,.LVIEN                    (   csc_lvien                   )
     ,.LVIS3                    (   csc_lvis[3]                 )
     ,.LVIS2                    (   csc_lvis[2]                 )
     ,.LVIS1                    (   csc_lvis[1]                 )
     ,.LVIS0                    (   csc_lvis[0]                 )
     ,.BG1EN                    (   flcp_reg125st               )
     ,.BG1ST                    (   flcp_bg1st                  )
     ,.BG2ADEN                  (   adc_bg2aden                 )
     ,.BG2ADSEL                 (   adc_bg2adsel                )
     ,.LVITEST                  (   csc_lvitest                 )
     ,.LVITSEL                  (   csc_lvitsel                 )
     ,.PAENB                    (   csc_paenb_n                 )
     ,.SENSEVDD                 (   regd_sensevdd               )
     ,.VBG08                    (   regm_vbg08                  )
     ,.VBG1                     (   regm_vreg                   )
     ,.BGIOREG1                 (   regm_bgioreg1               )
     ,.BGIOREG2                 (   regm_bgioreg2               )
     ,.VBG2AD                   (   regm_vbg2ad                 )
     ,.BGISUB1                  (   regm_bgisub1                )
     ,.BGISUB2                  (   regm_bgisub2                )
     ,.BGISUB3                  (   regm_bgisub3                )
     ,.REGDRV                   (   regm_regdrv                 )
     ,.PDRV                     (   regm_pdrv                   )
     ,.POCREL                   (   regm_pocrel                 )
     ,.POCREL5V                 (   regm_pocrel_v5              )
     ,.LVIOUTZ                  (   regm_lvioutz                )
     ,.TEMPADJ3                 (   cibc_bgrt[10]               )
     ,.TEMPADJ2                 (   cibc_bgrt[9]                )
     ,.TEMPADJ1                 (   cibc_bgrt[8]                )
     ,.TEMPADJ0                 (   cibc_bgrt[7]                )
     ,.AMPSEL                   (   csc_ampsel                  )
     ,.BGRTEST                  (   pull_down4                  )
     ,.TESTVOUT                 (   open_testvout               )
     );
//=================================================================
//===   umf30QAHMIX3DRV : regd
//=================================================================
  umf30QAHMIX3DRV  regd  (
      .SENSEVDD                 (   regd_sensevdd               )
     ,.REGDRV                   (   regm_regdrv                 )
     ,.PDRV                     (   regm_pdrv                   )
     );
//=================================================================
//===   QAHMOS0HNV1 : oscmain
//=================================================================
  QAHMOS0HNV1  oscmain  (
      .AMPH                     (   csc_amph                    )
     ,.EXCLK                    (   csc_exclk                   )
     ,.MDLYCUT                  (   mod_mdlycut                 )
     ,.MSTOP                    (   csc_mstop                   )
     ,.OSCSEL                   (   csc_oscsel                  )
     ,.RESETB                   (   rst_reset_n                 )
     ,.RTBFG                    (   rst_rtbfg_n_v5              )
     ,.X1                       (   X1                          )
     ,.X1ENI                    (   pt_oscm_x1eni               )
     ,.X2ENI                    (   pt_oscm_x2eni               )
     ,.X2                       (   X2                          )
     ,.OSCOUTM                  (   clk_fmx                     )
     ,.X1DIN                    (   oscm_x1din                  )
     ,.X2DIN                    (   oscm_x2din                  )
     );
//=================================================================
//===   QAHSOS1HNV1 : oscsub
//=================================================================
  QAHSOS1HNV1  oscsub  (
      .AMPHS0                   (   csc_amphs0                  )
     ,.AMPHS1                   (   csc_amphs1                  )
     ,.BGISUB1                  (   regm_bgisub1                )
     ,.BGISUB2                  (   regm_bgisub2                )
     ,.BGISUB3                  (   regm_bgisub3                )
     ,.RTBFG                    (   rst_rtbfg_n_v5              )
     ,.CPUCLKEN                 (   csc_cpuclken                )
     ,.EXCLKS                   (   csc_exclks                  )
     ,.OSCSELS                  (   pgcsc_oscsels               )
     ,.RTCCLKEN                 (   csc_rtcclken                )
     ,.XT1                      (   XT1                         )
     ,.XT1ENI                   (   pt_oscs_xt1eni              )
     ,.XT2ENI                   (   pt_oscs_xt2eni              )
     ,.XTSTOP                   (   csc_xtstop                  )
     ,.XTWKUP                   (   csc_xtwkup                  )
     ,.XT2                      (   XT2                         )
     ,.OSCOUTS                  (   clk_fsx                     )
     ,.RTCCLK                   (   clk_fsx_rtc                 )
     ,.XT1DIN                   (   oscs_xt1din                 )
     ,.XT2DIN                   (   oscs_xt2din                 )
     );
//=================================================================
//===   D78F2048QID03005 : pwresetb
//=================================================================
  D78F2048QID03005  pwresetb  (
      .DIN5V                    (   pull_down5                  )
     ,.HVIN5V                   (   pull_down6                  )
     ,.POCREL5V                 (   regm_pocrel_v5              )
     ,.SPAD                     (   RESINB                      )
     ,.RESFB5V                  (   rst_resfb_v5                )
     ,.RESF5V                   (                               )
     ,.RSTINBNF                 (   rst_rstinbnf_n              )
     ,.TRESET                   (   rst_treset                  )
     ,.RTBFG                    (   rst_rtbfg_n_v5              )
     );
//=================================================================
//===   KX4_NF : nf
//=================================================================
  KX4_NF  nf  (
      .POCREL                   (   regm_pocrel                 )
     ,.POCRELNF                 (   nf_pocrelnf                 )
     ,.RSTINBNF                 (   rst_rstinbnf_n              )
     ,.RESETINBNF               (   rst_resetinbnf_n            )
     ,.LVIOUTZ                  (   regm_lvioutz                )
     ,.LVIOUTZNF                (   nf_lvioutznf                )
     );
//=================================================================
//===   QAHRES0CV1 : vppts1_res
//=================================================================
  QAHRES0CV1  vppts1_res  (
      .VPPTSIN                  (   pt_hflashcp_vpptsin_va      )
     ,.VPPTSOUT                 (   vppts1_cp                   )
     );
//=================================================================
//===   QIVG0005ZBL : power
//=================================================================
  QIVG0005ZBL  power  (
      .PDRV                     (   regm_pdrv                   )
     ,.VPAD01                   (   EVDD0PD                     )
     ,.VPAD02                   (   EVDD0PDB                    )
     ,.VPAD11                   (   VDDPD                       )
     ,.VPAD12                   (   VDDPDB                      )
     ,.VPAD2                    (   REGC                        )
     ,.GPAD01                   (   EVSS0PD                     )
     ,.GPAD02                   (   EVSS0PDB                    )
     ,.GPAD11                   (   VSSPD                       )
     ,.GPAD12                   (   VSSPDB                      )
     ,.GPAD11BB                 (   gpad1bb                     )
     ,.GPAD12BB                 (   gpad1bb                     )
     ,.VPAD01BB                 (   vpad0bb                     )
     ,.VPAD02BB                 (   vpad0bb                     )
     ,.VPAD11BB                 (   vpad1bb                     )
     ,.VPAD12BB                 (   vpad1bb                     )
     ,.VPAD2BB                  (   vpad2bb                     )
     ,.GPAD01BB                 (   gpad0bb                     )
     ,.GPAD02BB                 (   gpad0bb                     )
     ,.RTBFG                    (   rst_rtbfg_n_v5              )
     );
//=================================================================
//===   QAHNFI4BN300NV1 : dmydly300n
//=================================================================
  QAHNFI4BN300NV1  dmydly300n  (
      .NFIN                     (   pt_mod_routsrc12            )
     ,.NFOUT                    (   dly300_dly300no             )
     );
//=================================================================
//===   QNSC3NCP1V2 : flash_cp
//=================================================================
  QNSC3NCP1V2  flash_cp  (
      .WWR                      (   fcb_wwr                     )
     ,.DWWR                     (   fcb_dwwr                    )
     ,.MSWR                     (   fcb_mswr                    )
     ,.CER                      (   fcb_cer                     )
     ,.DCER                     (   fcb_dcer                    )
     ,.SER                      (   fcb_ser                     )
     ,.DSER                     (   fcb_dser                    )
     ,.EXER                     (   fcb_exer                    )
     ,.MRG00                    (   fcb_mrg00                   )
     ,.MRG01                    (   fcb_mrg01                   )
     ,.MRG10                    (   fcb_mrg10                   )
     ,.MRG11                    (   fcb_mrg11                   )
     ,.MRG12                    (   fcb_mrg12                   )
     ,.DMRG00                   (   fcb_dmrg00                  )
     ,.DMRG01                   (   fcb_dmrg01                  )
     ,.DMRG10                   (   fcb_dmrg10                  )
     ,.DMRG11                   (   fcb_dmrg11                  )
     ,.DMRG12                   (   fcb_dmrg12                  )
     ,.DIS                      (   fcb_dis                     )
     ,.DDIS                     (   fcb_ddis                    )
     ,.READ                     (   fcb_read                    )
     ,.DREAD                    (   fcb_dread                   )
     ,.IONCHK1                  (   fcb_ionchk1                 )
     ,.STCHK                    (   fcb_stchk                   )
     ,.CPBT                     (   fcb_cpbt                    )
     ,.WDT1                     (   fcb_wdt1                    )
     ,.WDT2                     (   fcb_wdt2                    )
     ,.WDT3                     (   fcb_wdt3                    )
     ,.WDT4                     (   fcb_wdt4                    )
     ,.RDT                      (   fcb_rdt                     )
     ,.RDMRG0                   (   fcb_rdmrg0                  )
     ,.RDMRG1                   (   fcb_rdmrg1                  )
     ,.RDMRGC                   (   fcb_rdmrgc                  )
     ,.EXTVPP1                  (   fcb_extvpp1                 )
     ,.EXTVPP2                  (   fcb_extvpp2                 )
     ,.CPT                      (   fcb_cpt                     )
     ,.IREFT                    (   fcb_ireft                   )
     ,.MEOR                     (   fcb_meor                    )
     ,.MEOC                     (   fcb_meoc                    )
     ,.FLSTOP                   (   cibc_flstop                 )
     ,.DFLSTOP                  (   cibd_dflstop                )
     ,.VBRESZ                   (   rst_reset_n                 )
     ,.RDCLKC1                  (   clk_rdclkc1                 )
     ,.DRDCLKC1                 (   clk_drdclkc1                )
     ,.RDCLKP1                  (   clk_rdclkp1                 )
     ,.CLKSEL1                  (   cibc_clksel1                )
     ,.DCLKSEL1                 (   cibd_dclksel1               )
     ,.CE                       (   cibc_ce0                    )
     ,.DCE                      (   cibd_dce0                   )
     ,.CWEE                     (   fcb_cwee                    )
     ,.SUB                      (   cibc_sub                    )
     ,.LOWPOWER                 (   cibc_lowpower               )
     ,.HISPEED                  (   cibc_hispeed                )
     ,.RLOWSPY                  (   cibc_rlowspy                )
     ,.LOWSPY                   (   fcb_lowspy                  )
     ,.FCLK1                    (   fcb_fclk1                   )
     ,.PROGI                    (   fcb_progi                   )
     ,.WED                      (   fcb_wed                     )
     ,.DWED                     (   fcb_dwed                    )
     ,.TRMCP9                   (   cibc_trmcp0[9]              )
     ,.TRMCP8                   (   cibc_trmcp0[8]              )
     ,.TRMCP7                   (   cibc_trmcp0[7]              )
     ,.TRMCP6                   (   cibc_trmcp0[6]              )
     ,.TRMCP5                   (   cibc_trmcp0[5]              )
     ,.TRMCP4                   (   cibc_trmcp0[4]              )
     ,.TRMCP3                   (   cibc_trmcp0[3]              )
     ,.TRMCP2                   (   cibc_trmcp0[2]              )
     ,.TRMCP1                   (   cibc_trmcp0[1]              )
     ,.TRMCP0                   (   cibc_trmcp0[0]              )
     ,.TRMCP17                  (   cibc_trmcp0[17]             )
     ,.TRMCP16                  (   cibc_trmcp0[16]             )
     ,.TRMCP15                  (   cibc_trmcp0[15]             )
     ,.RTRMCP20                 (   cibc_rtrmcp0[20]            )
     ,.RTRMCP19                 (   cibc_rtrmcp0[19]            )
     ,.RTRMCP18                 (   cibc_rtrmcp0[18]            )
     ,.RTRMCP17                 (   cibc_rtrmcp0[17]            )
     ,.RTRMCP16                 (   cibc_rtrmcp0[16]            )
     ,.RTRMCP15                 (   cibc_rtrmcp0[15]            )
     ,.POCREL                   (   nf_pocrelnf                 )
     ,.TRMRD1                   (   flcp_trmrd1                 )
     ,.TRMRD1CK                 (   flcp_trmrd1ck               )
     ,.TRMRD2                   (   flcp_trmrd2                 )
     ,.TRMRD2CK                 (   flcp_trmrd2ck               )
     ,.VBRESZCP                 (   flcp_vbreszcp_n             )
     ,.SCANMODE                 (   mod_scanmode                )
     ,.TESDBT                   (   mod_tesdbt                  )
     ,.POCREL5V                 (   regm_pocrel_v5              )
     ,.VCPHV                    (   flcp_vcphv                  )
     ,.VREGMV                   (   flcp_vregmv                 )
     ,.VREGRMV                  (   flcp_vregrmv                )
     ,.HVPPTS1                  (   flcp_hvppts1                )
     ,.VPBIAS                   (   flcp_vpbias                 )
     ,.SRCUT                    (   cibc_srcut                  )
     ,.SRCUTCP                  (   flcp_srcutcp                )
     ,.FIHFL                    (   clk_fihfl                   )
     ,.OSCOUT                   (   clk_oscoutcp                )
     ,.OSCOUTEN                 (   cibc_oscouten               )
     ,.OSCNOSTP                 (   cibc_oscnostp               )
     ,.VPPTS1                   (   vppts1_cp                   )
     ,.VREG                     (   regm_vreg                   )
     ,.REQFL                    (   flcp_reqfl                  )
     ,.RDSETUP                  (   flcp_rdsetup                )
     ,.REG125ST                 (   flcp_reg125st               )
     ,.BG1ST                    (   flcp_bg1st                  )
     ,.VCPRGWE                  (   freg_vcprgwe                )
     ,.FLREGENB                 (   flcp_flregenb               )
     ,.RESB                     (   rst_res_n                   )
     );
//=================================================================
//===   QNSB3N004K0V2 : flash_data
//=================================================================
  QNSB3N004K0V2  flash_data  (
      .BEU2                     (   fcb_beu[2]                  )
     ,.BEU1                     (   fcb_beu[1]                  )
     ,.BEU0                     (   fcb_beu[0]                  )
     ,.CPBT                     (   fcb_cpbt                    )
     ,.CPT                      (   fcb_cpt                     )
     ,.CWEE                     (   fcb_cwee                    )
     ,.DA11                     (   cibd_da[11]                 )
     ,.DA10                     (   cibd_da[10]                 )
     ,.DA9                      (   cibd_da[9]                  )
     ,.DA8                      (   cibd_da[8]                  )
     ,.DA7                      (   cibd_da[7]                  )
     ,.DA6                      (   cibd_da[6]                  )
     ,.DA5                      (   cibd_da[5]                  )
     ,.DA4                      (   cibd_da[4]                  )
     ,.DA3                      (   cibd_da[3]                  )
     ,.DA2                      (   cibd_da[2]                  )
     ,.DA1                      (   cibd_da[1]                  )
     ,.DA0                      (   cibd_da[0]                  )
     ,.DCE                      (   cibd_dce0                   )
     ,.DCER                     (   fcb_dcer                    )
     ,.DCLKSEL1                 (   cibd_dclksel1               )
     ,.DDIS                     (   fcb_ddis                    )
     ,.DFLSTOP                  (   cibd_dflstop                )
     ,.DMRG00                   (   fcb_dmrg00                  )
     ,.DMRG01                   (   fcb_dmrg01                  )
     ,.DMRG10                   (   fcb_dmrg10                  )
     ,.DMRG11                   (   fcb_dmrg11                  )
     ,.DMRG12                   (   fcb_dmrg12                  )
     ,.DRDCLKC1                 (   clk_drdclkc1                )
     ,.DREAD                    (   fcb_dread                   )
     ,.DSER                     (   fcb_dser                    )
     ,.DSRCUT                   (   cibd_dsrcut                 )
     ,.DTRMCP14                 (   cibc_dtrmcp0[14]            )
     ,.DTRMCP13                 (   cibc_dtrmcp0[13]            )
     ,.DTRMCP12                 (   cibc_dtrmcp0[12]            )
     ,.DTRMCP11                 (   cibc_dtrmcp0[11]            )
     ,.DTRMCP10                 (   cibc_dtrmcp0[10]            )
     ,.DW11                     (   fcb_dw[35]                  )
     ,.DW10                     (   fcb_dw[34]                  )
     ,.DW9                      (   fcb_dw[33]                  )
     ,.DW8                      (   fcb_dw[32]                  )
     ,.DW7                      (   fcb_dw[7]                   )
     ,.DW6                      (   fcb_dw[6]                   )
     ,.DW5                      (   fcb_dw[5]                   )
     ,.DW4                      (   fcb_dw[4]                   )
     ,.DW3                      (   fcb_dw[3]                   )
     ,.DW2                      (   fcb_dw[2]                   )
     ,.DW1                      (   fcb_dw[1]                   )
     ,.DW0                      (   fcb_dw[0]                   )
     ,.DWED                     (   fcb_dwed                    )
     ,.DWWR                     (   fcb_dwwr                    )
     ,.EXER                     (   fcb_exer                    )
     ,.EXTVPP1                  (   fcb_extvpp1                 )
     ,.EXTVPP2                  (   fcb_extvpp2                 )
     ,.FCLK1                    (   fcb_fclk1                   )
     ,.HISPEED                  (   cibc_hispeed                )
     ,.HVPPTS1                  (   flcp_hvppts1                )
     ,.IONCHK1                  (   fcb_ionchk1                 )
     ,.IREFT                    (   fcb_ireft                   )
     ,.LOWPOWER                 (   cibc_lowpower               )
     ,.LOWSPY                   (   fcb_lowspy                  )
     ,.MEOC                     (   fcb_meoc                    )
     ,.MEOR                     (   fcb_meor                    )
     ,.MSWR                     (   fcb_mswr                    )
     ,.MUTEST                   (   fcb_mutest                  )
     ,.PROGI                    (   fcb_progi                   )
     ,.RDCLKP1                  (   clk_rdclkp1                 )
     ,.RDMRG0                   (   fcb_rdmrg0                  )
     ,.RDMRG1                   (   fcb_rdmrg1                  )
     ,.RDMRGC                   (   fcb_rdmrgc                  )
     ,.RDT                      (   fcb_rdt                     )
     ,.RLOWSPY                  (   cibc_rlowspy                )
     ,.SACEEN                   (   fcb_saceen_n                )
     ,.SCANIN                   (   pull_down7                  )
     ,.SCANMODE                 (   mod_scanmode                )
     ,.STCHK                    (   fcb_stchk                   )
     ,.SUB                      (   cibc_sub                    )
     ,.TESDBT                   (   mod_tesdbt                  )
     ,.VBRESZ                   (   rst_reset_n                 )
     ,.VBRESZCP                 (   flcp_vbreszcp_n             )
     ,.VCPHV                    (   flcp_vcphv                  )
     ,.VPBIAS                   (   flcp_vpbias                 )
     ,.VREGMV                   (   flcp_vregmv                 )
     ,.VREGRMV                  (   flcp_vregrmv                )
     ,.WDT1                     (   fcb_wdt1                    )
     ,.WDT2                     (   fcb_wdt2                    )
     ,.WDT3                     (   fcb_wdt3                    )
     ,.WDT4                     (   fcb_wdt4                    )
     ,.TRMRD1                   (   flcp_trmrd1                 )
     ,.TRMRD2                   (   flcp_trmrd2                 )
     ,.DRO11                    (   fdata_dro0[11]              )
     ,.DRO10                    (   fdata_dro0[10]              )
     ,.DRO9                     (   fdata_dro0[9]               )
     ,.DRO8                     (   fdata_dro0[8]               )
     ,.DRO7                     (   fdata_dro0[7]               )
     ,.DRO6                     (   fdata_dro0[6]               )
     ,.DRO5                     (   fdata_dro0[5]               )
     ,.DRO4                     (   fdata_dro0[4]               )
     ,.DRO3                     (   fdata_dro0[3]               )
     ,.DRO2                     (   fdata_dro0[2]               )
     ,.DRO1                     (   fdata_dro0[1]               )
     ,.DRO0                     (   fdata_dro0[0]               )
     );
//=================================================================
//===   QNSC3NREG1V2 : flash_reg
//=================================================================
  QNSC3NREG1V2  flash_reg  (
      .POCREL5V                 (   regm_pocrel_v5              )
     ,.FLREGENB                 (   flcp_flregenb               )
     ,.VCPRGWE                  (   freg_vcprgwe                )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_0
//=================================================================
  QNSC3NCPDC0V1  flash_capa_0  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_1
//=================================================================
  QNSC3NCPDC0V1  flash_capa_1  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_2
//=================================================================
  QNSC3NCPDC0V1  flash_capa_2  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_3
//=================================================================
  QNSC3NCPDC0V1  flash_capa_3  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_4
//=================================================================
  QNSC3NCPDC0V1  flash_capa_4  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_5
//=================================================================
  QNSC3NCPDC0V1  flash_capa_5  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_6
//=================================================================
  QNSC3NCPDC0V1  flash_capa_6  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_7
//=================================================================
  QNSC3NCPDC0V1  flash_capa_7  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_8
//=================================================================
  QNSC3NCPDC0V1  flash_capa_8  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_9
//=================================================================
  QNSC3NCPDC0V1  flash_capa_9  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_10
//=================================================================
  QNSC3NCPDC0V1  flash_capa_10  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_11
//=================================================================
  QNSC3NCPDC0V1  flash_capa_11  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_12
//=================================================================
  QNSC3NCPDC0V1  flash_capa_12  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_13
//=================================================================
  QNSC3NCPDC0V1  flash_capa_13  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSC3NCPDC0V1 : flash_capa_14
//=================================================================
  QNSC3NCPDC0V1  flash_capa_14  (
      .VCPHV                    (   flcp_vcphv                  )
     );
//=================================================================
//===   QNSA3N128K0V2 : flash_code_0
//=================================================================
  QNSA3N128K0V2_test  flash_code_0  (
      .WWR                      (   fcb_wwr                     )
     ,.MSWR                     (   fcb_mswr                    )
     ,.CER                      (   fcb_cer                     )
     ,.SER                      (   fcb_ser                     )
     ,.EXER                     (   fcb_exer                    )
     ,.MRG00                    (   fcb_mrg00                   )
     ,.MRG01                    (   fcb_mrg01                   )
     ,.MRG10                    (   fcb_mrg10                   )
     ,.MRG11                    (   fcb_mrg11                   )
     ,.MRG12                    (   fcb_mrg12                   )
     ,.DIS                      (   fcb_dis                     )
     ,.READ                     (   fcb_read                    )
     ,.IONCHK1                  (   fcb_ionchk1                 )
     ,.STCHK                    (   fcb_stchk                   )
     ,.CPBT                     (   fcb_cpbt                    )
     ,.WDT1                     (   fcb_wdt1                    )
     ,.WDT2                     (   fcb_wdt2                    )
     ,.WDT3                     (   fcb_wdt3                    )
     ,.WDT4                     (   fcb_wdt4                    )
     ,.RDT                      (   fcb_rdt                     )
     ,.RDMRG0                   (   fcb_rdmrg0                  )
     ,.RDMRG1                   (   fcb_rdmrg1                  )
     ,.RDMRGC                   (   fcb_rdmrgc                  )
     ,.EXTVPP1                  (   fcb_extvpp1                 )
     ,.EXTVPP2                  (   fcb_extvpp2                 )
     ,.CPT                      (   fcb_cpt                     )
     ,.IREFT                    (   fcb_ireft                   )
     ,.MEOR                     (   fcb_meor                    )
     ,.MEOC                     (   fcb_meoc                    )
     ,.SACEEN                   (   fcb_saceen_n                )
     ,.FLSTOP                   (   cibc_flstop                 )
     ,.VBRESZ                   (   rst_reset_n                 )
     ,.RDCLKC1                  (   clk_rdclkc1                 )
     ,.RDCLKP1                  (   clk_rdclkp1                 )
     ,.CLKSEL1                  (   cibc_clksel1                )
     ,.CE                       (   cibc_ce0                    )
     ,.CWEE                     (   fcb_cwee                    )
     ,.SUB                      (   cibc_sub                    )
     ,.LOWPOWER                 (   cibc_lowpower               )
     ,.HISPEED                  (   cibc_hispeed                )
     ,.RLOWSPY                  (   cibc_rlowspy                )
     ,.LOWSPY                   (   fcb_lowspy                  )
     ,.SRCUT                    (   cibc_srcut                  )
     ,.EXA                      (   cibc_exa                    )
     ,.BFA                      (   cibc_bfa                    )
     ,.A16                      (   cibc_a[16]                  )
     ,.A15                      (   cibc_a[15]                  )
     ,.A14                      (   cibc_a[14]                  )
     ,.A13                      (   cibc_a[13]                  )
     ,.A12                      (   cibc_a[12]                  )
     ,.A11                      (   cibc_a[11]                  )
     ,.A10                      (   cibc_a[10]                  )
     ,.A9                       (   cibc_a[9]                   )
     ,.A8                       (   cibc_a[8]                   )
     ,.A7                       (   cibc_a[7]                   )
     ,.A6                       (   cibc_a[6]                   )
     ,.A5                       (   cibc_a[5]                   )
     ,.A4                       (   cibc_a[4]                   )
     ,.A3                       (   cibc_a[3]                   )
     ,.A2                       (   cibc_a[2]                   )
     ,.R0A6                     (   cibc_r0a[6]                 )
     ,.R0A5                     (   cibc_r0a[5]                 )
     ,.R0A4                     (   cibc_r0a[4]                 )
     ,.R0A3                     (   cibc_r0a[3]                 )
     ,.R0A2                     (   cibc_r0a[2]                 )
     ,.R0A1                     (   cibc_r0a[1]                 )
     ,.R0A0                     (   cibc_r0a[0]                 )
     ,.R0FLAGZ                  (   cibc_r0flagz_n              )
     ,.DW37                     (   fcb_dw[37]                  )
     ,.DW36                     (   fcb_dw[36]                  )
     ,.DW35                     (   fcb_dw[35]                  )
     ,.DW34                     (   fcb_dw[34]                  )
     ,.DW33                     (   fcb_dw[33]                  )
     ,.DW32                     (   fcb_dw[32]                  )
     ,.DW31                     (   fcb_dw[31]                  )
     ,.DW30                     (   fcb_dw[30]                  )
     ,.DW29                     (   fcb_dw[29]                  )
     ,.DW28                     (   fcb_dw[28]                  )
     ,.DW27                     (   fcb_dw[27]                  )
     ,.DW26                     (   fcb_dw[26]                  )
     ,.DW25                     (   fcb_dw[25]                  )
     ,.DW24                     (   fcb_dw[24]                  )
     ,.DW23                     (   fcb_dw[23]                  )
     ,.DW22                     (   fcb_dw[22]                  )
     ,.DW21                     (   fcb_dw[21]                  )
     ,.DW20                     (   fcb_dw[20]                  )
     ,.DW19                     (   fcb_dw[19]                  )
     ,.DW18                     (   fcb_dw[18]                  )
     ,.DW17                     (   fcb_dw[17]                  )
     ,.DW16                     (   fcb_dw[16]                  )
     ,.DW15                     (   fcb_dw[15]                  )
     ,.DW14                     (   fcb_dw[14]                  )
     ,.DW13                     (   fcb_dw[13]                  )
     ,.DW12                     (   fcb_dw[12]                  )
     ,.DW11                     (   fcb_dw[11]                  )
     ,.DW10                     (   fcb_dw[10]                  )
     ,.DW9                      (   fcb_dw[9]                   )
     ,.DW8                      (   fcb_dw[8]                   )
     ,.DW7                      (   fcb_dw[7]                   )
     ,.DW6                      (   fcb_dw[6]                   )
     ,.DW5                      (   fcb_dw[5]                   )
     ,.DW4                      (   fcb_dw[4]                   )
     ,.DW3                      (   fcb_dw[3]                   )
     ,.DW2                      (   fcb_dw[2]                   )
     ,.DW1                      (   fcb_dw[1]                   )
     ,.DW0                      (   fcb_dw[0]                   )
     ,.RO37                     (   fcode0_ro0[37]              )
     ,.RO36                     (   fcode0_ro0[36]              )
     ,.RO35                     (   fcode0_ro0[35]              )
     ,.RO34                     (   fcode0_ro0[34]              )
     ,.RO33                     (   fcode0_ro0[33]              )
     ,.RO32                     (   fcode0_ro0[32]              )
     ,.RO31                     (   fcode0_ro0[31]              )
     ,.RO30                     (   fcode0_ro0[30]              )
     ,.RO29                     (   fcode0_ro0[29]              )
     ,.RO28                     (   fcode0_ro0[28]              )
     ,.RO27                     (   fcode0_ro0[27]              )
     ,.RO26                     (   fcode0_ro0[26]              )
     ,.RO25                     (   fcode0_ro0[25]              )
     ,.RO24                     (   fcode0_ro0[24]              )
     ,.RO23                     (   fcode0_ro0[23]              )
     ,.RO22                     (   fcode0_ro0[22]              )
     ,.RO21                     (   fcode0_ro0[21]              )
     ,.RO20                     (   fcode0_ro0[20]              )
     ,.RO19                     (   fcode0_ro0[19]              )
     ,.RO18                     (   fcode0_ro0[18]              )
     ,.RO17                     (   fcode0_ro0[17]              )
     ,.RO16                     (   fcode0_ro0[16]              )
     ,.RO15                     (   fcode0_ro0[15]              )
     ,.RO14                     (   fcode0_ro0[14]              )
     ,.RO13                     (   fcode0_ro0[13]              )
     ,.RO12                     (   fcode0_ro0[12]              )
     ,.RO11                     (   fcode0_ro0[11]              )
     ,.RO10                     (   fcode0_ro0[10]              )
     ,.RO9                      (   fcode0_ro0[9]               )
     ,.RO8                      (   fcode0_ro0[8]               )
     ,.RO7                      (   fcode0_ro0[7]               )
     ,.RO6                      (   fcode0_ro0[6]               )
     ,.RO5                      (   fcode0_ro0[5]               )
     ,.RO4                      (   fcode0_ro0[4]               )
     ,.RO3                      (   fcode0_ro0[3]               )
     ,.RO2                      (   fcode0_ro0[2]               )
     ,.RO1                      (   fcode0_ro0[1]               )
     ,.RO0                      (   fcode0_ro0[0]               )
     ,.BEU2                     (   fcb_beu[2]                  )
     ,.BEU1                     (   fcb_beu[1]                  )
     ,.BEU0                     (   fcb_beu[0]                  )
     ,.FCLK1                    (   fcb_fclk1                   )
     ,.FCLK2                    (   fcb_fclk2                   )
     ,.PROGI                    (   fcb_progi                   )
     ,.WED                      (   fcb_wed                     )
     ,.TRMCP14                  (   cibc_trmcp0[14]             )
     ,.TRMCP13                  (   cibc_trmcp0[13]             )
     ,.TRMCP12                  (   cibc_trmcp0[12]             )
     ,.TRMCP11                  (   cibc_trmcp0[11]             )
     ,.TRMCP10                  (   cibc_trmcp0[10]             )
     ,.POCREL                   (   nf_pocrelnf                 )
     ,.TRMRD1                   (   flcp_trmrd1                 )
     ,.TRMRD2                   (   flcp_trmrd2                 )
     ,.VBRESZCP                 (   flcp_vbreszcp_n             )
     ,.SCANIN                   (   pull_down8                  )
     ,.SCANMODE                 (   mod_scanmode                )
     ,.TESDBT                   (   mod_tesdbt                  )
     ,.MUTEST                   (   fcb_mutest                  )
     ,.VCPHV                    (   flcp_vcphv                  )
     ,.VREGMV                   (   flcp_vregmv                 )
     ,.VREGRMV                  (   flcp_vregrmv                )
     ,.HVPPTS1                  (   flcp_hvppts1                )
     ,.VPBIAS                   (   flcp_vpbias                 )
     ,.SRCUTCP                  (   flcp_srcutcp                )
     );
//=================================================================
//===   OWSRAM152W2048B13C4 : sram_0
//=================================================================
  OWSRAM152W2048B13C4  sram_0  (
      .CLK                      (   clk_ramclko_dly0            )
     ,.CEN                      (   ramif_cen0_n                )
     ,.D12                      (   ramif_ramd0[12]             )
     ,.D11                      (   ramif_ramd0[11]             )
     ,.D10                      (   ramif_ramd0[10]             )
     ,.D9                       (   ramif_ramd0[9]              )
     ,.D8                       (   ramif_ramd0[8]              )
     ,.D7                       (   ramif_ramd0[7]              )
     ,.D6                       (   ramif_ramd0[6]              )
     ,.D5                       (   ramif_ramd0[5]              )
     ,.D4                       (   ramif_ramd0[4]              )
     ,.D3                       (   ramif_ramd0[3]              )
     ,.D2                       (   ramif_ramd0[2]              )
     ,.D1                       (   ramif_ramd0[1]              )
     ,.D0                       (   ramif_ramd0[0]              )
     ,.A10                      (   ramif_rama[10]              )
     ,.A9                       (   ramif_rama[9]               )
     ,.A8                       (   ramif_rama[8]               )
     ,.A7                       (   ramif_rama[7]               )
     ,.A6                       (   ramif_rama[6]               )
     ,.A5                       (   ramif_rama[5]               )
     ,.A4                       (   ramif_rama[4]               )
     ,.A3                       (   ramif_rama[3]               )
     ,.A2                       (   ramif_rama[2]               )
     ,.A1                       (   ramif_rama[1]               )
     ,.A0                       (   ramif_rama[0]               )
     ,.WEN                      (   ramif_wen_n                 )
     ,.STN                      (   ramif_stn_n                 )
     ,.MODE1                    (   ramif_mode[1]               )
     ,.MODE0                    (   ramif_mode[0]               )
     ,.CMT                      (   ramif_cmt                   )
     ,.Q12                      (   hram_0_ramq[12]             )
     ,.Q11                      (   hram_0_ramq[11]             )
     ,.Q10                      (   hram_0_ramq[10]             )
     ,.Q9                       (   hram_0_ramq[9]              )
     ,.Q8                       (   hram_0_ramq[8]              )
     ,.Q7                       (   hram_0_ramq[7]              )
     ,.Q6                       (   hram_0_ramq[6]              )
     ,.Q5                       (   hram_0_ramq[5]              )
     ,.Q4                       (   hram_0_ramq[4]              )
     ,.Q3                       (   hram_0_ramq[3]              )
     ,.Q2                       (   hram_0_ramq[2]              )
     ,.Q1                       (   hram_0_ramq[1]              )
     ,.Q0                       (   hram_0_ramq[0]              )
     );
//=================================================================
//===   OWSRAM152W2048B13C4 : sram_1
//=================================================================
  OWSRAM152W2048B13C4  sram_1  (
      .CLK                      (   clk_ramclko_dly1            )
     ,.CEN                      (   ramif_cen1_n                )
     ,.D12                      (   ramif_ramd1[12]             )
     ,.D11                      (   ramif_ramd1[11]             )
     ,.D10                      (   ramif_ramd1[10]             )
     ,.D9                       (   ramif_ramd1[9]              )
     ,.D8                       (   ramif_ramd1[8]              )
     ,.D7                       (   ramif_ramd1[7]              )
     ,.D6                       (   ramif_ramd1[6]              )
     ,.D5                       (   ramif_ramd1[5]              )
     ,.D4                       (   ramif_ramd1[4]              )
     ,.D3                       (   ramif_ramd1[3]              )
     ,.D2                       (   ramif_ramd1[2]              )
     ,.D1                       (   ramif_ramd1[1]              )
     ,.D0                       (   ramif_ramd1[0]              )
     ,.A10                      (   ramif_rama[10]              )
     ,.A9                       (   ramif_rama[9]               )
     ,.A8                       (   ramif_rama[8]               )
     ,.A7                       (   ramif_rama[7]               )
     ,.A6                       (   ramif_rama[6]               )
     ,.A5                       (   ramif_rama[5]               )
     ,.A4                       (   ramif_rama[4]               )
     ,.A3                       (   ramif_rama[3]               )
     ,.A2                       (   ramif_rama[2]               )
     ,.A1                       (   ramif_rama[1]               )
     ,.A0                       (   ramif_rama[0]               )
     ,.WEN                      (   ramif_wen_n                 )
     ,.STN                      (   ramif_stn_n                 )
     ,.MODE1                    (   ramif_mode[1]               )
     ,.MODE0                    (   ramif_mode[0]               )
     ,.CMT                      (   ramif_cmt                   )
     ,.Q12                      (   hram_1_ramq[12]             )
     ,.Q11                      (   hram_1_ramq[11]             )
     ,.Q10                      (   hram_1_ramq[10]             )
     ,.Q9                       (   hram_1_ramq[9]              )
     ,.Q8                       (   hram_1_ramq[8]              )
     ,.Q7                       (   hram_1_ramq[7]              )
     ,.Q6                       (   hram_1_ramq[6]              )
     ,.Q5                       (   hram_1_ramq[5]              )
     ,.Q4                       (   hram_1_ramq[4]              )
     ,.Q3                       (   hram_1_ramq[3]              )
     ,.Q2                       (   hram_1_ramq[2]              )
     ,.Q1                       (   hram_1_ramq[1]              )
     ,.Q0                       (   hram_1_ramq[0]              )
     );
//=================================================================
//===   OWSRAM152W2048B13C4 : sram_2
//=================================================================
  OWSRAM152W2048B13C4  sram_2  (
      .CLK                      (   clk_ramclko_dly2            )
     ,.CEN                      (   ramif_cen2_n                )
     ,.D12                      (   ramif_ramd2[12]             )
     ,.D11                      (   ramif_ramd2[11]             )
     ,.D10                      (   ramif_ramd2[10]             )
     ,.D9                       (   ramif_ramd2[9]              )
     ,.D8                       (   ramif_ramd2[8]              )
     ,.D7                       (   ramif_ramd2[7]              )
     ,.D6                       (   ramif_ramd2[6]              )
     ,.D5                       (   ramif_ramd2[5]              )
     ,.D4                       (   ramif_ramd2[4]              )
     ,.D3                       (   ramif_ramd2[3]              )
     ,.D2                       (   ramif_ramd2[2]              )
     ,.D1                       (   ramif_ramd2[1]              )
     ,.D0                       (   ramif_ramd2[0]              )
     ,.A10                      (   ramif_rama[10]              )
     ,.A9                       (   ramif_rama[9]               )
     ,.A8                       (   ramif_rama[8]               )
     ,.A7                       (   ramif_rama[7]               )
     ,.A6                       (   ramif_rama[6]               )
     ,.A5                       (   ramif_rama[5]               )
     ,.A4                       (   ramif_rama[4]               )
     ,.A3                       (   ramif_rama[3]               )
     ,.A2                       (   ramif_rama[2]               )
     ,.A1                       (   ramif_rama[1]               )
     ,.A0                       (   ramif_rama[0]               )
     ,.WEN                      (   ramif_wen_n                 )
     ,.STN                      (   ramif_stn_n                 )
     ,.MODE1                    (   ramif_mode[1]               )
     ,.MODE0                    (   ramif_mode[0]               )
     ,.CMT                      (   ramif_cmt                   )
     ,.Q12                      (   hram_2_ramq[12]             )
     ,.Q11                      (   hram_2_ramq[11]             )
     ,.Q10                      (   hram_2_ramq[10]             )
     ,.Q9                       (   hram_2_ramq[9]              )
     ,.Q8                       (   hram_2_ramq[8]              )
     ,.Q7                       (   hram_2_ramq[7]              )
     ,.Q6                       (   hram_2_ramq[6]              )
     ,.Q5                       (   hram_2_ramq[5]              )
     ,.Q4                       (   hram_2_ramq[4]              )
     ,.Q3                       (   hram_2_ramq[3]              )
     ,.Q2                       (   hram_2_ramq[2]              )
     ,.Q1                       (   hram_2_ramq[1]              )
     ,.Q0                       (   hram_2_ramq[0]              )
     );
//=================================================================
//===   OWSRAM152W2048B13C4 : sram_3
//=================================================================
  OWSRAM152W2048B13C4  sram_3  (
      .CLK                      (   clk_ramclko_dly3            )
     ,.CEN                      (   ramif_cen3_n                )
     ,.D12                      (   ramif_ramd3[12]             )
     ,.D11                      (   ramif_ramd3[11]             )
     ,.D10                      (   ramif_ramd3[10]             )
     ,.D9                       (   ramif_ramd3[9]              )
     ,.D8                       (   ramif_ramd3[8]              )
     ,.D7                       (   ramif_ramd3[7]              )
     ,.D6                       (   ramif_ramd3[6]              )
     ,.D5                       (   ramif_ramd3[5]              )
     ,.D4                       (   ramif_ramd3[4]              )
     ,.D3                       (   ramif_ramd3[3]              )
     ,.D2                       (   ramif_ramd3[2]              )
     ,.D1                       (   ramif_ramd3[1]              )
     ,.D0                       (   ramif_ramd3[0]              )
     ,.A10                      (   ramif_rama[10]              )
     ,.A9                       (   ramif_rama[9]               )
     ,.A8                       (   ramif_rama[8]               )
     ,.A7                       (   ramif_rama[7]               )
     ,.A6                       (   ramif_rama[6]               )
     ,.A5                       (   ramif_rama[5]               )
     ,.A4                       (   ramif_rama[4]               )
     ,.A3                       (   ramif_rama[3]               )
     ,.A2                       (   ramif_rama[2]               )
     ,.A1                       (   ramif_rama[1]               )
     ,.A0                       (   ramif_rama[0]               )
     ,.WEN                      (   ramif_wen_n                 )
     ,.STN                      (   ramif_stn_n                 )
     ,.MODE1                    (   ramif_mode[1]               )
     ,.MODE0                    (   ramif_mode[0]               )
     ,.CMT                      (   ramif_cmt                   )
     ,.Q12                      (   hram_3_ramq[12]             )
     ,.Q11                      (   hram_3_ramq[11]             )
     ,.Q10                      (   hram_3_ramq[10]             )
     ,.Q9                       (   hram_3_ramq[9]              )
     ,.Q8                       (   hram_3_ramq[8]              )
     ,.Q7                       (   hram_3_ramq[7]              )
     ,.Q6                       (   hram_3_ramq[6]              )
     ,.Q5                       (   hram_3_ramq[5]              )
     ,.Q4                       (   hram_3_ramq[4]              )
     ,.Q3                       (   hram_3_ramq[3]              )
     ,.Q2                       (   hram_3_ramq[2]              )
     ,.Q1                       (   hram_3_ramq[1]              )
     ,.Q0                       (   hram_3_ramq[0]              )
     );
//=================================================================
//===   bufclk_cell_pf : flashclk_dly
//=================================================================
  bufclk_cell_pf flashclk_dly (
      .a                      (   clk_baseckhs   )
     ,.y                      (   clk_rdclkc1   )
     );
//=================================================================
//===   bufclk_cell_pf : ramclk_dly_0
//=================================================================
  bufclk_cell_pf ramclk_dly_0 (
      .a                      (   clk_ramclk   )
     ,.y                      (   clk_ramclko_dly0   )
     );
//=================================================================
//===   bufclk_cell_pf : ramclk_dly_1
//=================================================================
  bufclk_cell_pf ramclk_dly_1 (
      .a                      (   clk_ramclk   )
     ,.y                      (   clk_ramclko_dly1   )
     );
//=================================================================
//===   bufclk_cell_pf : ramclk_dly_2
//=================================================================
  bufclk_cell_pf ramclk_dly_2 (
      .a                      (   clk_ramclk   )
     ,.y                      (   clk_ramclko_dly2   )
     );
//=================================================================
//===   bufclk_cell_pf : ramclk_dly_3
//=================================================================
  bufclk_cell_pf ramclk_dly_3 (
      .a                      (   clk_ramclk   )
     ,.y                      (   clk_ramclko_dly3   )
     );
//=================================================================
//===   andclk_cell_pf : monitor_sig_gating_1
//=================================================================
  andclk_cell_pf monitor_sig_gating_1 (
      .a                      (   clk_fmp_div   )
     ,.b                      (   mod_testmod   )
     ,.y                      (   clk_fmp_div_gating   )
     );
//=================================================================
//===   andclk_cell_pf : monitor_sig_gating_2
//=================================================================
  andclk_cell_pf monitor_sig_gating_2 (
      .a                      (   clk_fpll64m   )
     ,.b                      (   mod_testmod   )
     ,.y                      (   clk_fpll64m_gating   )
     );
//=================================================================
//===   andclk_cell_pf : monitor_sig_gating_3
//=================================================================
  andclk_cell_pf monitor_sig_gating_3 (
      .a                      (   clk_wdt_loscout   )
     ,.b                      (   mod_testmod   )
     ,.y                      (   clk_wdt_loscout_gating   )
     );
//=================================================================
//===   dly50_cell_pf : dmydly50n
//=================================================================
  dly50_cell_pf dmydly50n (
      .in                     (   pt_mod_routsrc10   )
     ,.out                    (   dly50_dly50no   )
     );

endmodule
// *****************************************************************************
//  (C) COPYRIGHT 2012 RENESAS ELECTRONICS CORPORATION, ALL RIGHTS RESERVED
// *****************************************************************************
