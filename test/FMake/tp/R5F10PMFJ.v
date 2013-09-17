//
// Make Top Net from mktop (V01.03.01.b00)
//

// ------------------------------------------------------------
//                                     R5F10PMFJ
//                                         +----+
//                                    P00->|    |->P130
//                                    P01->|    |
//                                    P02->|    |
//                                    P10->|    |
//                                    P11->|    |
//                                    P12->|    |
//                                   P120->|    |
//                                   P125->|    |
//                                   P126->|    |
//                                    P13->|    |
//                                   P137->|    |
//                                    P14->|    |
//                                   P140->|    |
//                                    P15->|    |
//                                    P16->|    |
//                                    P17->|    |
//                                    P30->|    |
//                                    P31->|    |
//                                    P32->|    |
//                                    P33->|    |
//                                    P34->|    |
//                                    P40->|    |
//                                    P41->|    |
//                                    P42->|    |
//                                    P43->|    |
//                                    P44->|    |
//                                    P45->|    |
//                                    P46->|    |
//                                    P47->|    |
//                                    P50->|    |
//                                    P51->|    |
//                                    P52->|    |
//                                    P53->|    |
//                                    P54->|    |
//                                    P55->|    |
//                                    P56->|    |
//                                    P57->|    |
//                                    P60->|    |
//                                    P61->|    |
//                                    P62->|    |
//                                    P63->|    |
//                                    P64->|    |
//                                    P65->|    |
//                                    P66->|    |
//                                    P67->|    |
//                                    P70->|    |
//                                    P71->|    |
//                                    P72->|    |
//                                    P73->|    |
//                                    P74->|    |
//                                    P75->|    |
//                                    P76->|    |
//                                    P77->|    |
//                                    P80->|    |
//                                    P81->|    |
//                                    P82->|    |
//                                    P83->|    |
//                                    P84->|    |
//                                    P85->|    |
//                                    P86->|    |
//                                    P87->|    |
//                                    P90->|    |
//                                    P91->|    |
//                                    P92->|    |
//                                    P93->|    |
//                                    P94->|    |
//                                    P95->|    |
//                                    P96->|    |
//                                    P97->|    |
//                                     X1->|    |
//                                     X2->|    |
//                                    XT1->|    |
//                                    XT2->|    |
//                                 RESINB->|    |
//                                   REGC->|    |
//                                  VDDPD->|    |
//                                EVDD0PD->|    |
//                                  VSSPD->|    |
//                                EVSS0PD->|    |
//                                 VDDPDB->|    |
//                               EVDD0PDB->|    |
//                                 VSSPDB->|    |
//                               EVSS0PDB->|    |
//                                         +----+
// ------------------------------------------------------------

module R5F10PMFJ (
    P00 ,
    P01 ,
    P02 ,
    P10 ,
    P11 ,
    P12 ,
    P120 ,
    P125 ,
    P126 ,
    P13 ,
    P130 ,
    P137 ,
    P14 ,
    P140 ,
    P15 ,
    P16 ,
    P17 ,
    P30 ,
    P31 ,
    P32 ,
    P33 ,
    P34 ,
    P40 ,
    P41 ,
    P42 ,
    P43 ,
    P44 ,
    P45 ,
    P46 ,
    P47 ,
    P50 ,
    P51 ,
    P52 ,
    P53 ,
    P54 ,
    P55 ,
    P56 ,
    P57 ,
    P60 ,
    P61 ,
    P62 ,
    P63 ,
    P64 ,
    P65 ,
    P66 ,
    P67 ,
    P70 ,
    P71 ,
    P72 ,
    P73 ,
    P74 ,
    P75 ,
    P76 ,
    P77 ,
    P80 ,
    P81 ,
    P82 ,
    P83 ,
    P84 ,
    P85 ,
    P86 ,
    P87 ,
    P90 ,
    P91 ,
    P92 ,
    P93 ,
    P94 ,
    P95 ,
    P96 ,
    P97 ,
    X1 ,
    X2 ,
    XT1 ,
    XT2 ,
    RESINB ,
    REGC ,
    VDDPD ,
    EVDD0PD ,
    VSSPD ,
    EVSS0PD ,
    VDDPDB ,
    EVDD0PDB ,
    VSSPDB ,
    EVSS0PDB );
inout	 P00;
inout	 P01;
inout	 P02;
inout	 P10;
inout	 P11;
inout	 P12;
inout	 P120;
inout	 P125;
inout	 P126;
inout	 P13;
output	 P130;
input	 P137;
inout	 P14;
inout	 P140;
inout	 P15;
inout	 P16;
inout	 P17;
inout	 P30;
inout	 P31;
inout	 P32;
inout	 P33;
inout	 P34;
inout	 P40;
inout	 P41;
inout	 P42;
inout	 P43;
inout	 P44;
inout	 P45;
inout	 P46;
inout	 P47;
inout	 P50;
inout	 P51;
inout	 P52;
inout	 P53;
inout	 P54;
inout	 P55;
inout	 P56;
inout	 P57;
inout	 P60;
inout	 P61;
inout	 P62;
inout	 P63;
inout	 P64;
inout	 P65;
inout	 P66;
inout	 P67;
inout	 P70;
inout	 P71;
inout	 P72;
inout	 P73;
inout	 P74;
inout	 P75;
inout	 P76;
inout	 P77;
inout	 P80;
inout	 P81;
inout	 P82;
inout	 P83;
inout	 P84;
inout	 P85;
inout	 P86;
inout	 P87;
inout	 P90;
inout	 P91;
inout	 P92;
inout	 P93;
inout	 P94;
inout	 P95;
inout	 P96;
inout	 P97;
input	 X1;
inout	 X2;
input	 XT1;
inout	 XT2;
input	 RESINB;
inout	 REGC;
inout	 VDDPD;
inout	 EVDD0PD;
inout	 VSSPD;
inout	 EVSS0PD;
inout	 VDDPDB;
inout	 EVDD0PDB;
inout	 VSSPDB;
inout	 EVSS0PDB;
    wire [15:0] cpu_ma;
    wire [15:0] cpu_mdw;
    wire [4:0] cibc_frqsel;
    wire [37:0] fcb_dw;
    wire [7:0] csc_per0;
    wire [15:1] csc_cken;
    wire [17:0] mod_ta;
    wire [1:0] porga_gdram;
    wire [3:0] bbr_prdsel_pclm;
    wire [15:0] bbrsub_prdata;
    wire [15:0] bbr_bbadr;
    wire [15:0] bbr_bbmdw;
    wire [15:0] capmx_bbprdata;
    wire [1:0] ramif_mode;
    wire [1:0] comp_cdfs;
    wire [15:0] fpga_dgen;

// ------------------------------------------------------------
//                       crl78fcspf00_f14m(cspf)
//                                         +----+
//           cpu_waitmem(c2c_waitmem    )->|    |->cpu_ma[15:0] (cpu_ma[15:0])
//         timd_0_irreq0(timd_0_irreq0  )->|    |->cpu_slmem    (cpu_slmem)
//         timd_0_irreq1(timd_0_irreq1  )->|    |->cpu_mdw[15:0](cpu_mdw[15:0])
//          lin3_0_int_s(lin3_0_int_s   )->|    |->cpu_cpuwr    (cpu_cpuwr)
//         iic_0_intiic0(iic_0_intiic0  )->|    |->cpu_wdop     (cpu_wdop)
//           ifil_intp11(ifil_intp11    )->|    |->cpu_fchram   (cpu_fchram)
//            tau_1_int3(tau_1_int3     )->|    |->dtc_intdtc33 (dtc_intdtc33)
//            tau_1_int2(tau_1_int2     )->|    |->dtc_intdtc32 (dtc_intdtc32)
//            tau_1_int1(tau_1_int1     )->|    |->dtc_intdtc31 (dtc_intdtc31)
//            tau_1_int0(tau_1_int0     )->|    |->dtc_intdtc30 (dtc_intdtc30)
//             comp_cirq(comp_cirq      )->|    |->dtc_intdtc29 (dtc_intdtc29)
//       timj_0_reqirq_k(timj_0_reqirq_k)->|    |->dtc_intdtc28 (dtc_intdtc28)
//       timd_0_reqimfd1(timd_0_reqimfd1)->|    |->dtc_intdtc27 (dtc_intdtc27)
//       timd_0_reqimfc1(timd_0_reqimfc1)->|    |->dtc_intdtc26 (dtc_intdtc26)
//       timd_0_reqimfb1(timd_0_reqimfb1)->|    |->dtc_intdtc7  (dtc_intdtc7)
//       timd_0_reqimfa1(timd_0_reqimfa1)->|    |->dtc_intdtc6  (dtc_intdtc6)
//       timd_0_reqimfd0(timd_0_reqimfd0)->|    |->dtc_intdtc5  (dtc_intdtc5)
//       timd_0_reqimfc0(timd_0_reqimfc0)->|    |->ocd_ocdmod   (ocd_ocdmod)
//       timd_0_reqimfb0(timd_0_reqimfb0)->|    |->ocd_svstop   (ocd_svstop)
//       timd_0_reqimfa0(timd_0_reqimfa0)->|    |->ocd_svperi0  (ocd_svperi0)
//            tau_0_int7(tau_0_int7     )->|    |->ocd_svperi1  (ocd_svperi1)
//            tau_0_int6(tau_0_int6     )->|    |->ocd_txocd    (ocd_txocd)
//            tau_0_int5(tau_0_int5     )->|    |->ocd_sprgmod  (ocd_sprgmod)
//            tau_0_int4(tau_0_int4     )->|    |->ocd_sltrxtx  (ocd_sltrxtx)
//            tau_0_int3(tau_0_int3     )->|    |->ocd_hpimod   (ocd_hpimod)
//            tau_0_int2(tau_0_int2     )->|    |->cibc_opocden (cibc_opocden)
//            tau_0_int1(tau_0_int1     )->|    |->cibc_selin1  (cibc_selin1)
//            tau_0_int0(tau_0_int0     )->|    |->cibc_frqsel[4:0](cibc_frqsel[4:0])
//        rcn_comfrx_int(rcn_comfrx_int )->|    |->cibc_bbnvm2  (cibc_bbnvm2)
//          lin3_0_int_t(lin3_0_int_t   )->|    |->fcb_modidis  (fcb_modidis)
//          lin3_0_int_r(lin3_0_int_r   )->|    |->fcb_dw[37:0] (fcb_dw[37:0])
//         sau_1_intsau0(sau_1_intsau0  )->|    |->clk_baseckhs (clk_baseckhs)
//         sau_1_intsau1(sau_1_intsau1  )->|    |->clk_rtc_pclk (clk_rtc_pclk)
//         sau_0_intsau0(sau_0_intsau0  )->|    |->clk_iic_1_pclk(clk_iic_1_pclk)
//         sau_0_intsau1(sau_0_intsau1  )->|    |->clk_adc_pclk (clk_adc_pclk)
//             adc_intad(adc_intad      )->|    |->clk_iic_0_pclk(clk_iic_0_pclk)
//            krif_intkr(krif_intkr     )->|    |->clk_sau_1_pclk(clk_sau_1_pclk)
//            ifil_intp6(ifil_intp6     )->|    |->clk_sau_0_pclk(clk_sau_0_pclk)
//            ifil_intp5(ifil_intp5     )->|    |->clk_tau_1_pclk(clk_tau_1_pclk)
//            ifil_intp4(ifil_intp4     )->|    |->clk_tau_0_pclk(clk_tau_0_pclk)
//            ifil_intp3(ifil_intp3     )->|    |->rst_res_n    (rst_res_n)
//            ifil_intp2(ifil_intp2     )->|    |->rst_nsres_n  (rst_nsres_n)
//            ifil_intp1(ifil_intp1     )->|    |->rst_rtc_res_n(rst_rtc_res_n)
//            ifil_intp0(ifil_intp0     )->|    |->rst_iic_1_res_n(rst_iic_1_res_n)
//          pt_ocd_rxocd(pt_ocd_rxocd   )->|    |->rst_adc_res_n(rst_adc_res_n)
//         pt_ocd_toolrx(pt_ocd_toolrx  )->|    |->rst_iic_0_res_n(rst_iic_0_res_n)
//          capmx_frq4en(capmx_frq4en   )->|    |->rst_sau_1_res_n(rst_sau_1_res_n)
//                tfwepr(1'b1           )->|    |->rst_sau_0_res_n(rst_sau_0_res_n)
//              icenoecc(1'b0           )->|    |->rst_tau_1_res_n(rst_tau_1_res_n)
//              iceflerr(1'b0           )->|    |->rst_tau_0_res_n(rst_tau_0_res_n)
//              iceck60m(1'b0           )->|    |->csc_resstp   (csc_resstp)
//              icemkwdt(1'b0           )->|    |->rst_sysres_n (rst_sysres_n)
//              icemklvi(1'b0           )->|    |->rst_reset_n  (rst_reset_n)
//              icemksrq(1'b0           )->|    |->clk_fclkrt   (clk_fclkrt)
//        capmx_bbckselr(1'b1           )->|    |->csc_tseloreg (csc_tseloreg)
//        capmx_bbckselm(1'b1           )->|    |->csc_tselires (csc_tselires)
//         sau_0_reqpclk(lin3_0_reqpclk )->|    |->csc_ttemp    (csc_ttemp)
//           adc_reqpclk(adc_reqpclk    )->|    |->csc_tstn     (csc_tstn)
//       capmx_bbreqpclk(capmx_bbreqpclk)->|    |->csc_per0[7:0](csc_per0[7:0])
//         capmx_bbrperr(capmx_bbrperr  )->|    |->csc_stpbckbt (csc_stpbckbt)
//         capmx_bbhioon(capmx_bbhioon  )->|    |->clk_pclkrw   (clk_pclkrw)
//          capmx_bbmode(capmx_bbmode   )->|    |->csc_cken[15:1](csc_cken[15:1])
//          pt_mod_tin00(pt_mod_tin00   )->|    |->csc_rt0lpm   (csc_rt0lpm)
//     pt_mod_routsrc12(pt_mod_routsrc12)->|    |->clk_fmp_div  (clk_fmp_div)
//     pt_mod_routsrc10(pt_mod_routsrc10)->|    |->clk_ex_fil   (clk_fil_intrclk)
//           rtc_rt0mon0(rtc_rt0mon0    )->|    |->clk_scan_ex  (clk_scan_ex)
//           rtc_rt0mon1(rtc_rt0mon1    )->|    |->clk_fsub     (clk_fsub)
//          pt_mod_tdin5(pt_mod_tdin5   )->|    |->csc_rsts     (csc_rsts)
//          pt_mod_tdin4(pt_mod_tdin4   )->|    |->csc_bbckstr  (csc_bbckstr)
//          pt_mod_tdin3(pt_mod_tdin3   )->|    |->csc_bbckstm  (csc_bbckstm)
//         pt_mod_tdin2t(pt_mod_tdin2t  )->|    |->csc_fmxst    (csc_fmxst)
//         pt_mod_tdin2r(pt_mod_tdin2r  )->|    |->csc_subckst  (csc_subckst)
//         pt_mod_tdin2b(1'b0           )->|    |->csc_bckhsen  (csc_bckhsen)
//         pt_mod_tdin2l(1'b0           )->|    |->pgcsc_bbper  (pgcsc_bbper)
//         pt_mod_tdin1t(pt_mod_tdin1t  )->|    |->mod_gofirm   (mod_gofirm)
//         pt_mod_tdin1r(pt_mod_tdin1r  )->|    |->mod_scanmode (mod_scanmode)
//         pt_mod_tdin1b(1'b0           )->|    |->mod_tesscan1 (mod_tesscan1)
//         pt_mod_tdin1l(1'b0           )->|    |->mod_tesinst  (mod_tesinst)
//         pt_mod_tdin0t(pt_mod_tdin0t  )->|    |->mod_bbtesinst(mod_bbtesinst)
//         pt_mod_tdin0r(pt_mod_tdin0r  )->|    |->mod_tesdbt   (mod_tesdbt)
//         pt_mod_tdin0b(1'b0           )->|    |->mod_optiddq  (mod_optiddq)
//         pt_mod_tdin0l(1'b0           )->|    |->mod_optexcck (mod_optexcck)
//       capmx_bbscanout(capmx_bbscanout)->|    |->mod_optoplrd (mod_optoplrd)
//           porga_iawen(porga_iawen    )->|    |->mod_optbct   (mod_optbct)
//     porga_gdram[1:0](porga_gdram[1:0])->|    |->mod_rammulti (mod_rammulti)
// bbrsub_prdata[15:0](bbrsub_prdata[15:0])->|    |->mod_seltar   (mod_seltar)
//           porga_gdcsc(porga_gdcsc    )->|    |->mod_oti00    (mod_oti00)
//           porga_gdint(porga_gdint    )->|    |->mod_tesdbt2  (mod_tesdbt2)
// capmx_bbprdata[15:0](capmx_bbprdata[15:0])->|    |->mod_moderd   (mod_moderd)
//          capmx_bbint0(capmx_bbint0   )->|    |->mod_modewr   (mod_modewr)
//          capmx_bbint1(capmx_bbint1   )->|    |->mod_modenop  (mod_modenop)
//         capmx_bbint10(capmx_bbint10  )->|    |->mod_incdecws1(mod_incdecws1)
//         capmx_bbint11(capmx_bbint11  )->|    |->mod_incdecws0(mod_incdecws0)
//         capmx_bbint12(capmx_bbint12  )->|    |->mod_ta[17:0] (mod_ta[17:0])
//         capmx_bbint13(capmx_bbint13  )->|    |->mod_teseni4  (mod_teseni4)
//          capmx_bbint2(capmx_bbint2   )->|    |->mod_teseni3  (mod_teseni3)
//          capmx_bbint3(capmx_bbint3   )->|    |->mod_teseni2t (mod_teseni2t)
//          capmx_bbint4(capmx_bbint4   )->|    |->mod_teseni2r (mod_teseni2r)
//          capmx_bbint5(capmx_bbint5   )->|    |->mod_teseni2b (mod_teseni2b)
//          capmx_bbint6(capmx_bbint6   )->|    |->mod_teseni2l (mod_teseni2l)
//          capmx_bbint7(capmx_bbint7   )->|    |->mod_teseni1t (mod_teseni1t)
//          capmx_bbint8(capmx_bbint8   )->|    |->mod_teseni1r (mod_teseni1r)
//          capmx_bbint9(capmx_bbint9   )->|    |->mod_teseni1b (mod_teseni1b)
//           ifil_intp10(ifil_intp10    )->|    |->mod_teseni1l (mod_teseni1l)
//            ifil_intp7(ifil_intp7     )->|    |->mod_teseni0t (mod_teseni0t)
//            ifil_intp8(ifil_intp8     )->|    |->mod_teseni0r (mod_teseni0r)
//            ifil_intp9(ifil_intp9     )->|    |->mod_teseni0b (mod_teseni0b)
//         porga_intdtc5(porga_intdtc5  )->|    |->mod_teseni0l (mod_teseni0l)
//         porga_intdtc6(porga_intdtc6  )->|    |->mod_teseno3  (mod_teseno3)
//         porga_intdtc7(porga_intdtc7  )->|    |->mod_teseno2t (mod_teseno2t)
//         pt_crx_in_int(pt_crx_in_int  )->|    |->mod_teseno2r (mod_teseno2r)
//         rcn_cherr_int(rcn_cherr_int  )->|    |->mod_teseno2b (mod_teseno2b)
//         rcn_glerr_int(rcn_glerr_int  )->|    |->mod_teseno2l (mod_teseno2l)
//           rcn_rxf_int(rcn_rxf_int    )->|    |->mod_teseno1t (mod_teseno1t)
//            rcn_tx_int(rcn_tx_int     )->|    |->mod_teseno1r (mod_teseno1r)
//            rtc_intrtc(rtc_intrtc     )->|    |->mod_teseno1b (mod_teseno1b)
//           tau_0_inth1(tau_0_inth1    )->|    |->mod_teseno1l (mod_teseno1l)
//           tau_0_inth3(tau_0_inth3    )->|    |->mod_teseno0t (mod_teseno0t)
//           tau_1_inth1(tau_1_inth1    )->|    |->mod_teseno0r (mod_teseno0r)
//           tau_1_inth3(tau_1_inth3    )->|    |->mod_teseno0b (mod_teseno0b)
//           pt_mod_hvin(pt_mod_hvin    )->|    |->mod_teseno0l (mod_teseno0l)
//        timj_0_prsclen(timj_0_prsclen )->|    |->mod_tdsel3   (mod_tdsel3)
// bbrsub_timd_0_pselal(bbrsub_timd_0_pselal)->|    |->mod_tdsel2t  (mod_tdsel2t)
//        comp_cdfs[1:0](comp_cdfs[1:0] )->|    |->mod_tdsel2r  (mod_tdsel2r)
//        lin3_0_reqpclk(lin3_0_reqpclk )->|    |->mod_tdsel2b  (mod_tdsel2b)
//     hhoco_oregout_va(hhoco_oregout_va)->|    |->mod_tdsel2l  (mod_tdsel2l)
//           adc_bg2aden(adc_bg2aden    )->|    |->mod_tdsel1t  (mod_tdsel1t)
//          adc_bg2adsel(adc_bg2adsel   )->|    |->mod_tdsel1r  (mod_tdsel1r)
//                    X1(X1             )->|    |->mod_tdsel1b  (mod_tdsel1b)
//         pt_oscm_x1eni(pt_oscm_x1eni  )->|    |->mod_tdsel1l  (mod_tdsel1l)
//         pt_oscm_x2eni(pt_oscm_x2eni  )->|    |->mod_tdsel0t  (mod_tdsel0t)
//                    X2(X2             )->|    |->mod_tdsel0r  (mod_tdsel0r)
//                   XT1(XT1            )->|    |->mod_tdsel0b  (mod_tdsel0b)
//        pt_oscs_xt1eni(pt_oscs_xt1eni )->|    |->mod_tdsel0l  (mod_tdsel0l)
//        pt_oscs_xt2eni(pt_oscs_xt2eni )->|    |->mod_tdout3   (mod_tdout3)
//                   XT2(XT2            )->|    |->mod_tdout2   (mod_tdout2)
//                RESINB(RESINB         )->|    |->mod_tdout1   (mod_tdout1)
// pt_hflashcp_vpptsin_va(pt_hflashcp_vpptsin_va)->|    |->mod_tdout0   (mod_tdout0)
//               EVDD0PD(EVDD0PD        )->|    |->mod_scanin   (mod_scanin)
//              EVDD0PDB(EVDD0PDB       )->|    |->mod_scanen   (mod_scanen)
//                 VDDPD(VDDPD          )->|    |->rst_scanres_n(rst_scanres_n)
//                VDDPDB(VDDPDB         )->|    |->iaw_gdramwr  (iaw_gdramwr)
//                  REGC(REGC           )->|    |->bbr_bbrsub_apbmask(bbr_bbrsub_apbmask)
//               EVSS0PD(EVSS0PD        )->|    |->bbr_bbrsub_psel1st(bbr_bbrsub_psel1st)
//              EVSS0PDB(EVSS0PDB       )->|    |->bbr_bbrsub_psel2nd(bbr_bbrsub_psel2nd)
//                 VSSPD(VSSPD          )->|    |->bbr_penable  (bbr_penable)
//                VSSPDB(VSSPDB         )->|    |->bbr_prdsel_pclm[3:0](bbr_prdsel_pclm[3:0])
//                                         |    |->bbr_bbadr[15:0](bbr_bbadr[15:0])
//                                         |    |->bbr_bbmdw[15:0](bbr_bbmdw[15:0])
//                                         |    |->bbr_bbpenable(bbr_bbpenable)
//                                         |    |->bbr_bbpwrite (bbr_bbpwrite)
//                                         |    |->bbr_bbselsfr1st(bbr_bbselsfr1st)
//                                         |    |->bbr_bbselsfr2nd(bbr_bbselsfr2nd)
//                                         |    |->ramif_stn_n  (ramif_stn_n)
//                                         |    |->ramif_mode[1:0](ramif_mode[1:0])
//                                         |    |->ramif_rcn_cmt(ramif_rcn_cmt)
//                                         |    |->pgcsc_dspclkrwen(cibc_frqsel4)
//                                         |    |->clk_dspclkrw (clk_dspclkrw)
//                                         |    |->clk_scan     (clk_scan)
//                                         |    |->clk_fmain    (clk_fmain)
//                                         |    |->clk_fsl      (clk_fsl)
//                                         |    |->clk_timj_0_pclk(clk_timj_0_pclk)
//                                         |    |->rst_timj_0_res_n(rst_timj_0_res_n)
//                                         |    |->clk_timd_0_pclk(clk_timd_0_pclk)
//                                         |    |->pgcsc_dscken1(pgcsc_dscken1)
//                                         |    |->pgcsc_dscken2(pgcsc_dscken2)
//                                         |    |->pgcsc_dscken3(pgcsc_dscken3)
//                                         |    |->pgcsc_dscken5(pgcsc_dscken5)
//                                         |    |->rst_timd_0_res_n(rst_timd_0_res_n)
//                                         |    |->clk_dac_pclk (clk_dac_pclk)
//                                         |    |->rst_dac_res_n(rst_dac_res_n)
//                                         |    |->clk_comp_pclk(clk_comp_pclk)
//                                         |    |->rst_comp_res_n(rst_comp_res_n)
//                                         |    |->clk_lin3_0_pclk(clk_lin3_0_pclk)
//                                         |    |->clk_clkc     (clk_clkc)
//                                         |    |->rst_lin3_0_res_n(rst_lin3_0_res_n)
//                                         |    |->clk_rcn_pclk (clk_rcn_pclk)
//                                         |    |->clk_rcn_clka_can(clk_rcn_clka_can)
//                                         |    |->rst_rcn_presetz(rst_rcn_presetz)
//                                         |    |->stopst_p31   (stopst_p31)
//                                         |    |->stopst_p52   (stopst_p52)
//                                         |    |->clk_rtc_mclk (clk_rtc_mclk)
//                                         |    |->clk_rtc_tclk (clk_rtc_tclk)
//                                         |    |->pgcsc_cksel  (pgcsc_cksel)
//                                         |    |->pgcsc_per14  (pgcsc_per14)
//                                         |    |->clk_c2c_pclk (clk_c2c_pclk)
//                                         |    |->rst_c2c_res_n(rst_c2c_res_n)
//                                         |    |->clk_fhoco    (clk_fhoco)
//                                         |    |->clk_fil      (clk_fil)
//                                         |    |->regm_vbg2ad  (regm_vbg2ad)
//                                         |    |->regm_pocrel_v5(regm_pocrel_v5)
//                                         |    |->clk_fmx      (clk_fmx)
//                                         |    |->oscm_x1din   (oscm_x1din)
//                                         |    |->oscm_x2din   (oscm_x2din)
//                                         |    |->clk_fsx_rtc  (clk_fsx_rtc)
//                                         |    |->oscs_xt1din  (oscs_xt1din)
//                                         |    |->oscs_xt2din  (oscs_xt2din)
//                                         |    |->rst_rtbfg_n_v5(rst_rtbfg_n_v5)
//                                         +----+
// ------------------------------------------------------------

crl78fcspf00_f14m cspf (
	.cpu_ma(cpu_ma[15:0]) ,
	.cpu_slmem(cpu_slmem) ,
	.cpu_mdw(cpu_mdw[15:0]) ,
	.cpu_cpuwr(cpu_cpuwr) ,
	.cpu_wdop(cpu_wdop) ,
	.cpu_waitmem(c2c_waitmem) ,
	.cpu_fchram(cpu_fchram) ,
	.timd_0_irreq0(timd_0_irreq0) ,
	.timd_0_irreq1(timd_0_irreq1) ,
	.lin3_0_int_s(lin3_0_int_s) ,
	.iic_0_intiic0(iic_0_intiic0) ,
	.ifil_intp11(ifil_intp11) ,
	.tau_1_int3(tau_1_int3) ,
	.tau_1_int2(tau_1_int2) ,
	.tau_1_int1(tau_1_int1) ,
	.tau_1_int0(tau_1_int0) ,
	.comp_cirq(comp_cirq) ,
	.timj_0_reqirq_k(timj_0_reqirq_k) ,
	.timd_0_reqimfd1(timd_0_reqimfd1) ,
	.timd_0_reqimfc1(timd_0_reqimfc1) ,
	.timd_0_reqimfb1(timd_0_reqimfb1) ,
	.timd_0_reqimfa1(timd_0_reqimfa1) ,
	.timd_0_reqimfd0(timd_0_reqimfd0) ,
	.timd_0_reqimfc0(timd_0_reqimfc0) ,
	.timd_0_reqimfb0(timd_0_reqimfb0) ,
	.timd_0_reqimfa0(timd_0_reqimfa0) ,
	.tau_0_int7(tau_0_int7) ,
	.tau_0_int6(tau_0_int6) ,
	.tau_0_int5(tau_0_int5) ,
	.tau_0_int4(tau_0_int4) ,
	.tau_0_int3(tau_0_int3) ,
	.tau_0_int2(tau_0_int2) ,
	.tau_0_int1(tau_0_int1) ,
	.tau_0_int0(tau_0_int0) ,
	.rcn_comfrx_int(rcn_comfrx_int) ,
	.lin3_0_int_t(lin3_0_int_t) ,
	.lin3_0_int_r(lin3_0_int_r) ,
	.sau_1_intsau0(sau_1_intsau0) ,
	.sau_1_intsau1(sau_1_intsau1) ,
	.sau_0_intsau0(sau_0_intsau0) ,
	.sau_0_intsau1(sau_0_intsau1) ,
	.adc_intad(adc_intad) ,
	.krif_intkr(krif_intkr) ,
	.ifil_intp6(ifil_intp6) ,
	.ifil_intp5(ifil_intp5) ,
	.ifil_intp4(ifil_intp4) ,
	.ifil_intp3(ifil_intp3) ,
	.ifil_intp2(ifil_intp2) ,
	.ifil_intp1(ifil_intp1) ,
	.ifil_intp0(ifil_intp0) ,
	.dtc_intdtc33(dtc_intdtc33) ,
	.dtc_intdtc32(dtc_intdtc32) ,
	.dtc_intdtc31(dtc_intdtc31) ,
	.dtc_intdtc30(dtc_intdtc30) ,
	.dtc_intdtc29(dtc_intdtc29) ,
	.dtc_intdtc28(dtc_intdtc28) ,
	.dtc_intdtc27(dtc_intdtc27) ,
	.dtc_intdtc26(dtc_intdtc26) ,
	.dtc_intdtc7(dtc_intdtc7) ,
	.dtc_intdtc6(dtc_intdtc6) ,
	.dtc_intdtc5(dtc_intdtc5) ,
	.ocd_ocdmod(ocd_ocdmod) ,
	.ocd_svstop(ocd_svstop) ,
	.ocd_svperi0(ocd_svperi0) ,
	.ocd_svperi1(ocd_svperi1) ,
	.pt_ocd_rxocd(pt_ocd_rxocd) ,
	.ocd_txocd(ocd_txocd) ,
	.ocd_sprgmod(ocd_sprgmod) ,
	.pt_ocd_toolrx(pt_ocd_toolrx) ,
	.ocd_sltrxtx(ocd_sltrxtx) ,
	.ocd_hpimod(ocd_hpimod) ,
	.cibc_opocden(cibc_opocden) ,
	.cibc_selin1(cibc_selin1) ,
	.cibc_frqsel(cibc_frqsel[4:0]) ,
	.cibc_bbnvm2(cibc_bbnvm2) ,
	.capmx_frq4en(capmx_frq4en) ,
	.fcb_modidis(fcb_modidis) ,
	.tfwepr(1'b1) ,
	.fcb_dw(fcb_dw[37:0]) ,
	.icenoecc(1'b0) ,
	.iceflerr(1'b0) ,
	.clk_baseckhs(clk_baseckhs) ,
	.clk_rtc_pclk(clk_rtc_pclk) ,
	.clk_iic_1_pclk(clk_iic_1_pclk) ,
	.clk_adc_pclk(clk_adc_pclk) ,
	.clk_iic_0_pclk(clk_iic_0_pclk) ,
	.clk_sau_1_pclk(clk_sau_1_pclk) ,
	.clk_sau_0_pclk(clk_sau_0_pclk) ,
	.clk_tau_1_pclk(clk_tau_1_pclk) ,
	.clk_tau_0_pclk(clk_tau_0_pclk) ,
	.rst_res_n(rst_res_n) ,
	.rst_nsres_n(rst_nsres_n) ,
	.rst_rtc_res_n(rst_rtc_res_n) ,
	.rst_iic_1_res_n(rst_iic_1_res_n) ,
	.rst_adc_res_n(rst_adc_res_n) ,
	.rst_iic_0_res_n(rst_iic_0_res_n) ,
	.rst_sau_1_res_n(rst_sau_1_res_n) ,
	.rst_sau_0_res_n(rst_sau_0_res_n) ,
	.rst_tau_1_res_n(rst_tau_1_res_n) ,
	.rst_tau_0_res_n(rst_tau_0_res_n) ,
	.csc_resstp(csc_resstp) ,
	.rst_sysres_n(rst_sysres_n) ,
	.rst_reset_n(rst_reset_n) ,
	.clk_fclkrt(clk_fclkrt) ,
	.iceck60m(1'b0) ,
	.icemkwdt(1'b0) ,
	.icemklvi(1'b0) ,
	.icemksrq(1'b0) ,
	.csc_tseloreg(csc_tseloreg) ,
	.csc_tselires(csc_tselires) ,
	.csc_ttemp(csc_ttemp) ,
	.csc_tstn(csc_tstn) ,
	.csc_per0(csc_per0[7:0]) ,
	.csc_stpbckbt(csc_stpbckbt) ,
	.clk_pclkrw(clk_pclkrw) ,
	.csc_cken(csc_cken[15:1]) ,
	.csc_rt0lpm(csc_rt0lpm) ,
	.capmx_bbckselr(1'b1) ,
	.capmx_bbckselm(1'b1) ,
	.clk_fmp_div(clk_fmp_div) ,
	.sau_0_reqpclk(lin3_0_reqpclk) ,
	.adc_reqpclk(adc_reqpclk) ,
	.capmx_bbreqpclk(capmx_bbreqpclk) ,
	.clk_ex_fil(clk_fil_intrclk) ,
	.clk_scan_ex(clk_scan_ex) ,
	.clk_fsub(clk_fsub) ,
	.csc_rsts(csc_rsts) ,
	.capmx_bbrperr(capmx_bbrperr) ,
	.csc_bbckstr(csc_bbckstr) ,
	.capmx_bbhioon(capmx_bbhioon) ,
	.csc_bbckstm(csc_bbckstm) ,
	.csc_fmxst(csc_fmxst) ,
	.csc_subckst(csc_subckst) ,
	.csc_bckhsen(csc_bckhsen) ,
	.pgcsc_bbper(pgcsc_bbper) ,
	.capmx_bbmode(capmx_bbmode) ,
	.pt_mod_tin00(pt_mod_tin00) ,
	.pt_mod_routsrc12(pt_mod_routsrc12) ,
	.pt_mod_routsrc10(pt_mod_routsrc10) ,
	.mod_gofirm(mod_gofirm) ,
	.mod_scanmode(mod_scanmode) ,
	.mod_tesscan1(mod_tesscan1) ,
	.mod_tesinst(mod_tesinst) ,
	.mod_bbtesinst(mod_bbtesinst) ,
	.mod_tesdbt(mod_tesdbt) ,
	.mod_optiddq(mod_optiddq) ,
	.mod_optexcck(mod_optexcck) ,
	.mod_optoplrd(mod_optoplrd) ,
	.mod_optbct(mod_optbct) ,
	.mod_rammulti(mod_rammulti) ,
	.mod_seltar(mod_seltar) ,
	.mod_oti00(mod_oti00) ,
	.mod_tesdbt2(mod_tesdbt2) ,
	.mod_moderd(mod_moderd) ,
	.mod_modewr(mod_modewr) ,
	.mod_modenop(mod_modenop) ,
	.mod_incdecws1(mod_incdecws1) ,
	.mod_incdecws0(mod_incdecws0) ,
	.mod_ta(mod_ta[17:0]) ,
	.rtc_rt0mon0(rtc_rt0mon0) ,
	.rtc_rt0mon1(rtc_rt0mon1) ,
	.pt_mod_tdin5(pt_mod_tdin5) ,
	.pt_mod_tdin4(pt_mod_tdin4) ,
	.pt_mod_tdin3(pt_mod_tdin3) ,
	.pt_mod_tdin2t(pt_mod_tdin2t) ,
	.pt_mod_tdin2r(pt_mod_tdin2r) ,
	.pt_mod_tdin2b(1'b0) ,
	.pt_mod_tdin2l(1'b0) ,
	.pt_mod_tdin1t(pt_mod_tdin1t) ,
	.pt_mod_tdin1r(pt_mod_tdin1r) ,
	.pt_mod_tdin1b(1'b0) ,
	.pt_mod_tdin1l(1'b0) ,
	.pt_mod_tdin0t(pt_mod_tdin0t) ,
	.pt_mod_tdin0r(pt_mod_tdin0r) ,
	.pt_mod_tdin0b(1'b0) ,
	.pt_mod_tdin0l(1'b0) ,
	.mod_teseni4(mod_teseni4) ,
	.mod_teseni3(mod_teseni3) ,
	.mod_teseni2t(mod_teseni2t) ,
	.mod_teseni2r(mod_teseni2r) ,
	.mod_teseni2b(mod_teseni2b) ,
	.mod_teseni2l(mod_teseni2l) ,
	.mod_teseni1t(mod_teseni1t) ,
	.mod_teseni1r(mod_teseni1r) ,
	.mod_teseni1b(mod_teseni1b) ,
	.mod_teseni1l(mod_teseni1l) ,
	.mod_teseni0t(mod_teseni0t) ,
	.mod_teseni0r(mod_teseni0r) ,
	.mod_teseni0b(mod_teseni0b) ,
	.mod_teseni0l(mod_teseni0l) ,
	.mod_teseno3(mod_teseno3) ,
	.mod_teseno2t(mod_teseno2t) ,
	.mod_teseno2r(mod_teseno2r) ,
	.mod_teseno2b(mod_teseno2b) ,
	.mod_teseno2l(mod_teseno2l) ,
	.mod_teseno1t(mod_teseno1t) ,
	.mod_teseno1r(mod_teseno1r) ,
	.mod_teseno1b(mod_teseno1b) ,
	.mod_teseno1l(mod_teseno1l) ,
	.mod_teseno0t(mod_teseno0t) ,
	.mod_teseno0r(mod_teseno0r) ,
	.mod_teseno0b(mod_teseno0b) ,
	.mod_teseno0l(mod_teseno0l) ,
	.mod_tdsel3(mod_tdsel3) ,
	.mod_tdsel2t(mod_tdsel2t) ,
	.mod_tdsel2r(mod_tdsel2r) ,
	.mod_tdsel2b(mod_tdsel2b) ,
	.mod_tdsel2l(mod_tdsel2l) ,
	.mod_tdsel1t(mod_tdsel1t) ,
	.mod_tdsel1r(mod_tdsel1r) ,
	.mod_tdsel1b(mod_tdsel1b) ,
	.mod_tdsel1l(mod_tdsel1l) ,
	.mod_tdsel0t(mod_tdsel0t) ,
	.mod_tdsel0r(mod_tdsel0r) ,
	.mod_tdsel0b(mod_tdsel0b) ,
	.mod_tdsel0l(mod_tdsel0l) ,
	.mod_tdout3(mod_tdout3) ,
	.mod_tdout2(mod_tdout2) ,
	.mod_tdout1(mod_tdout1) ,
	.mod_tdout0(mod_tdout0) ,
	.mod_scanin(mod_scanin) ,
	.mod_scanen(mod_scanen) ,
	.rst_scanres_n(rst_scanres_n) ,
	.capmx_bbscanout(capmx_bbscanout) ,
	.porga_iawen(porga_iawen) ,
	.porga_gdram(porga_gdram[1:0]) ,
	.iaw_gdramwr(iaw_gdramwr) ,
	.bbr_bbrsub_apbmask(bbr_bbrsub_apbmask) ,
	.bbr_bbrsub_psel1st(bbr_bbrsub_psel1st) ,
	.bbr_bbrsub_psel2nd(bbr_bbrsub_psel2nd) ,
	.bbr_penable(bbr_penable) ,
	.bbr_prdsel_pclm(bbr_prdsel_pclm[3:0]) ,
	.bbrsub_prdata(bbrsub_prdata[15:0]) ,
	.porga_gdcsc(porga_gdcsc) ,
	.porga_gdint(porga_gdint) ,
	.bbr_bbadr(bbr_bbadr[15:0]) ,
	.bbr_bbmdw(bbr_bbmdw[15:0]) ,
	.bbr_bbpenable(bbr_bbpenable) ,
	.bbr_bbpwrite(bbr_bbpwrite) ,
	.bbr_bbselsfr1st(bbr_bbselsfr1st) ,
	.bbr_bbselsfr2nd(bbr_bbselsfr2nd) ,
	.capmx_bbprdata(capmx_bbprdata[15:0]) ,
	.capmx_bbint0(capmx_bbint0) ,
	.capmx_bbint1(capmx_bbint1) ,
	.capmx_bbint10(capmx_bbint10) ,
	.capmx_bbint11(capmx_bbint11) ,
	.capmx_bbint12(capmx_bbint12) ,
	.capmx_bbint13(capmx_bbint13) ,
	.capmx_bbint2(capmx_bbint2) ,
	.capmx_bbint3(capmx_bbint3) ,
	.capmx_bbint4(capmx_bbint4) ,
	.capmx_bbint5(capmx_bbint5) ,
	.capmx_bbint6(capmx_bbint6) ,
	.capmx_bbint7(capmx_bbint7) ,
	.capmx_bbint8(capmx_bbint8) ,
	.capmx_bbint9(capmx_bbint9) ,
	.ifil_intp10(ifil_intp10) ,
	.ifil_intp7(ifil_intp7) ,
	.ifil_intp8(ifil_intp8) ,
	.ifil_intp9(ifil_intp9) ,
	.porga_intdtc5(porga_intdtc5) ,
	.porga_intdtc6(porga_intdtc6) ,
	.porga_intdtc7(porga_intdtc7) ,
	.pt_crx_in_int(pt_crx_in_int) ,
	.rcn_cherr_int(rcn_cherr_int) ,
	.rcn_glerr_int(rcn_glerr_int) ,
	.rcn_rxf_int(rcn_rxf_int) ,
	.rcn_tx_int(rcn_tx_int) ,
	.rtc_intrtc(rtc_intrtc) ,
	.tau_0_inth1(tau_0_inth1) ,
	.tau_0_inth3(tau_0_inth3) ,
	.tau_1_inth1(tau_1_inth1) ,
	.tau_1_inth3(tau_1_inth3) ,
	.pt_mod_hvin(pt_mod_hvin) ,
	.ramif_stn_n(ramif_stn_n) ,
	.ramif_mode(ramif_mode[1:0]) ,
	.ramif_rcn_cmt(ramif_rcn_cmt) ,
	.pgcsc_dspclkrwen(cibc_frqsel4) ,
	.clk_dspclkrw(clk_dspclkrw) ,
	.clk_scan(clk_scan) ,
	.clk_fmain(clk_fmain) ,
	.clk_fsl(clk_fsl) ,
	.timj_0_prsclen(timj_0_prsclen) ,
	.clk_timj_0_pclk(clk_timj_0_pclk) ,
	.rst_timj_0_res_n(rst_timj_0_res_n) ,
	.bbrsub_timd_0_pselal(bbrsub_timd_0_pselal) ,
	.clk_timd_0_pclk(clk_timd_0_pclk) ,
	.pgcsc_dscken1(pgcsc_dscken1) ,
	.pgcsc_dscken2(pgcsc_dscken2) ,
	.pgcsc_dscken3(pgcsc_dscken3) ,
	.pgcsc_dscken5(pgcsc_dscken5) ,
	.rst_timd_0_res_n(rst_timd_0_res_n) ,
	.clk_dac_pclk(clk_dac_pclk) ,
	.rst_dac_res_n(rst_dac_res_n) ,
	.comp_cdfs(comp_cdfs[1:0]) ,
	.clk_comp_pclk(clk_comp_pclk) ,
	.rst_comp_res_n(rst_comp_res_n) ,
	.lin3_0_reqpclk(lin3_0_reqpclk) ,
	.clk_lin3_0_pclk(clk_lin3_0_pclk) ,
	.clk_clkc(clk_clkc) ,
	.rst_lin3_0_res_n(rst_lin3_0_res_n) ,
	.clk_rcn_pclk(clk_rcn_pclk) ,
	.clk_rcn_clka_can(clk_rcn_clka_can) ,
	.rst_rcn_presetz(rst_rcn_presetz) ,
	.stopst_p31(stopst_p31) ,
	.stopst_p52(stopst_p52) ,
	.clk_rtc_mclk(clk_rtc_mclk) ,
	.clk_rtc_tclk(clk_rtc_tclk) ,
	.pgcsc_cksel(pgcsc_cksel) ,
	.pgcsc_per14(pgcsc_per14) ,
	.clk_c2c_pclk(clk_c2c_pclk) ,
	.rst_c2c_res_n(rst_c2c_res_n) ,
	.hhoco_oregout_va(hhoco_oregout_va) ,
	.clk_fhoco(clk_fhoco) ,
	.clk_fil(clk_fil) ,
	.adc_bg2aden(adc_bg2aden) ,
	.adc_bg2adsel(adc_bg2adsel) ,
	.regm_vbg2ad(regm_vbg2ad) ,
	.regm_pocrel_v5(regm_pocrel_v5) ,
	.X1(X1) ,
	.pt_oscm_x1eni(pt_oscm_x1eni) ,
	.pt_oscm_x2eni(pt_oscm_x2eni) ,
	.X2(X2) ,
	.clk_fmx(clk_fmx) ,
	.oscm_x1din(oscm_x1din) ,
	.oscm_x2din(oscm_x2din) ,
	.XT1(XT1) ,
	.pt_oscs_xt1eni(pt_oscs_xt1eni) ,
	.pt_oscs_xt2eni(pt_oscs_xt2eni) ,
	.XT2(XT2) ,
	.clk_fsx_rtc(clk_fsx_rtc) ,
	.oscs_xt1din(oscs_xt1din) ,
	.oscs_xt2din(oscs_xt2din) ,
	.RESINB(RESINB) ,
	.rst_rtbfg_n_v5(rst_rtbfg_n_v5) ,
	.pt_hflashcp_vpptsin_va(pt_hflashcp_vpptsin_va) ,
	.EVDD0PD(EVDD0PD) ,
	.EVDD0PDB(EVDD0PDB) ,
	.VDDPD(VDDPD) ,
	.VDDPDB(VDDPDB) ,
	.REGC(REGC) ,
	.EVSS0PD(EVSS0PD) ,
	.EVSS0PDB(EVSS0PDB) ,
	.VSSPD(VSSPD) ,
	.VSSPDB(VSSPDB)
);

// ------------------------------------------------------------
//                 crl78fpericore_f14m(pericore)
//                                         +----+
//            clk_pclkrw(clk_pclkrw     )->|    |->iic_0_intiic0(iic_0_intiic0)
//        clk_iic_0_pclk(clk_iic_0_pclk )->|    |->tau_1_int3   (tau_1_int3)
//       rst_iic_0_res_n(rst_iic_0_res_n)->|    |->tau_1_int2   (tau_1_int2)
//           ocd_svperi1(ocd_svperi1    )->|    |->tau_1_int1   (tau_1_int1)
//              clk_scan(clk_scan       )->|    |->tau_1_int0   (tau_1_int0)
//            mod_scanen(mod_scanen     )->|    |->tau_1_inth3  (tau_1_inth3)
//          mod_scanmode(mod_scanmode   )->|    |->tau_1_inth1  (tau_1_inth1)
//         fpga_clk60mhz(1'b0           )->|    |->tau_0_int0   (tau_0_int0)
//        clk_tau_1_pclk(clk_tau_1_pclk )->|    |->tau_0_int1   (tau_0_int1)
//       rst_tau_1_res_n(rst_tau_1_res_n)->|    |->tau_0_int2   (tau_0_int2)
//        clk_tau_0_pclk(clk_tau_0_pclk )->|    |->tau_0_int3   (tau_0_int3)
//       rst_tau_0_res_n(rst_tau_0_res_n)->|    |->tau_0_int4   (tau_0_int4)
//     rst_timd_0_res_n(rst_timd_0_res_n)->|    |->tau_0_int5   (tau_0_int5)
//           ocd_svperi0(ocd_svperi0    )->|    |->tau_0_int6   (tau_0_int6)
//       clk_timd_0_pclk(clk_timd_0_pclk)->|    |->tau_0_int7   (tau_0_int7)
//   dtc_timd_0_endimfa0(dtc_intdtc26   )->|    |->tau_0_inth1  (tau_0_inth1)
//   dtc_timd_0_endimfb0(dtc_intdtc27   )->|    |->tau_0_inth3  (tau_0_inth3)
//   dtc_timd_0_endimfc0(dtc_intdtc28   )->|    |->timd_0_reqimfa0(timd_0_reqimfa0)
//   dtc_timd_0_endimfd0(dtc_intdtc29   )->|    |->timd_0_reqimfb0(timd_0_reqimfb0)
//   dtc_timd_0_endimfa1(dtc_intdtc30   )->|    |->timd_0_reqimfc0(timd_0_reqimfc0)
//   dtc_timd_0_endimfb1(dtc_intdtc31   )->|    |->timd_0_reqimfd0(timd_0_reqimfd0)
//   dtc_timd_0_endimfc1(dtc_intdtc32   )->|    |->timd_0_reqimfa1(timd_0_reqimfa1)
//   dtc_timd_0_endimfd1(dtc_intdtc33   )->|    |->timd_0_reqimfb1(timd_0_reqimfb1)
//     rst_timj_0_res_n(rst_timj_0_res_n)->|    |->timd_0_reqimfc1(timd_0_reqimfc1)
//              clk_fsub(clk_fsub       )->|    |->timd_0_reqimfd1(timd_0_reqimfd1)
//       clk_fil_intrclk(clk_fil_intrclk)->|    |->timd_0_irreq0(timd_0_irreq0)
//       clk_timj_0_pclk(clk_timj_0_pclk)->|    |->timd_0_irreq1(timd_0_irreq1)
//          clk_adc_pclk(clk_adc_pclk   )->|    |->timj_0_prsclen(timj_0_prsclen)
//         rst_adc_res_n(rst_adc_res_n  )->|    |->timj_0_reqirq_k(timj_0_reqirq_k)
//            mod_tesdbt(mod_tesdbt     )->|    |->adc_reqpclk  (adc_reqpclk)
//           rst_reset_n(rst_reset_n    )->|    |->adc_intad    (adc_intad)
//             rst_res_n(rst_res_n      )->|    |->adc_bg2aden  (adc_bg2aden)
//            csc_resstp(csc_resstp     )->|    |->adc_bg2adsel (adc_bg2adsel)
//             clk_fmain(clk_fmain      )->|    |->rtc_intrtc   (rtc_intrtc)
//         rst_scanres_n(rst_scanres_n  )->|    |->rtc_intrtci  (rtc_intrtci)
//            csc_rt0lpm(csc_rt0lpm     )->|    |->rtc_rt0mon0  (rtc_rt0mon0)
//          clk_rtc_pclk(clk_rtc_pclk   )->|    |->rtc_rt0mon1  (rtc_rt0mon1)
//         rst_rtc_res_n(rst_rtc_res_n  )->|    |->krif_intkr   (krif_intkr)
//          clk_rtc_mclk(clk_rtc_mclk   )->|    |->bbrsub_prdata[15:0](bbrsub_prdata[15:0])
//          clk_rtc_tclk(clk_rtc_tclk   )->|    |->bbrsub_timd_0_pselal(bbrsub_timd_0_pselal)
//           pgcsc_cksel(pgcsc_cksel    )->|    |->porga_gdint  (porga_gdint)
//            mod_optbct(mod_optbct     )->|    |->ifil_intp0   (ifil_intp0)
// bbr_bbrsub_apbmask(bbr_bbrsub_apbmask)->|    |->ifil_intp1   (ifil_intp1)
// bbr_bbrsub_psel1st(bbr_bbrsub_psel1st)->|    |->ifil_intp2   (ifil_intp2)
// bbr_bbrsub_psel2nd(bbr_bbrsub_psel2nd)->|    |->ifil_intp3   (ifil_intp3)
//           bbr_penable(bbr_penable    )->|    |->ifil_intp4   (ifil_intp4)
//          cibc_frqsel4(cibc_frqsel4   )->|    |->ifil_intp5   (ifil_intp5)
//          clk_dspclkrw(clk_dspclkrw   )->|    |->ifil_intp6   (ifil_intp6)
//             cpu_cpuwr(cpu_cpuwr      )->|    |->ifil_intp7   (ifil_intp7)
//          cpu_ma[10:0](cpu_ma[10:0]   )->|    |->ifil_intp8   (ifil_intp8)
//         cpu_mdw[15:0](cpu_mdw[15:0]  )->|    |->ifil_intp9   (ifil_intp9)
//              cpu_wdop(cpu_wdop       )->|    |->ifil_intp10  (ifil_intp10)
//        csc_cken[15:1](csc_cken[15:1] )->|    |->ifil_intp11  (ifil_intp11)
//         csc_per0[7:0](csc_per0[7:0]  )->|    |->porga_iawen  (porga_iawen)
//         pgcsc_dscken1(pgcsc_dscken1  )->|    |->porga_gdram[1:0](porga_gdram[1:0])
//         pgcsc_dscken2(pgcsc_dscken2  )->|    |->porga_gdcsc  (porga_gdcsc)
//         pgcsc_dscken3(pgcsc_dscken3  )->|    |->porga_intdtc5(porga_intdtc5)
//         pgcsc_dscken5(pgcsc_dscken5  )->|    |->porga_intdtc6(porga_intdtc6)
//           pgcsc_per14(pgcsc_per14    )->|    |->porga_intdtc7(porga_intdtc7)
//            clk_fclkrt(clk_fclkrt     )->|    |->comp_cdfs[1:0](comp_cdfs[1:0])
//         capmx_adtrig0(capmx_adtrig0  )->|    |->comp_cirq    (comp_cirq)
//         capmx_adtrig1(capmx_adtrig1  )->|    |->rcn_cherr_int(rcn_cherr_int)
//       capmx_intrtcdis(capmx_intrtcdis)->|    |->rcn_comfrx_int(rcn_comfrx_int)
//             mod_oti00(mod_oti00      )->|    |->rcn_glerr_int(rcn_glerr_int)
//               clk_fil(clk_fil        )->|    |->rcn_rxf_int  (rcn_rxf_int)
//               clk_fmx(clk_fmx        )->|    |->rcn_tx_int   (rcn_tx_int)
//            clk_bbclkr(clk_bbclkr     )->|    |->lin3_0_int_t (lin3_0_int_t)
//           dtc_intdtc5(dtc_intdtc5    )->|    |->lin3_0_int_r (lin3_0_int_r)
//           dtc_intdtc6(dtc_intdtc6    )->|    |->lin3_0_int_s (lin3_0_int_s)
//           dtc_intdtc7(dtc_intdtc7    )->|    |->lin3_0_int_m (lin3_0_int_m)
//        rst_comp_res_n(rst_comp_res_n )->|    |->lin3_0_reqpclk(lin3_0_reqpclk)
//         clk_comp_pclk(clk_comp_pclk  )->|    |->sau_0_intsau0(sau_0_intsau0)
//           mod_tesinst(mod_tesinst    )->|    |->sau_0_seint0 (sau_0_seint0)
//          clk_baseckhs(clk_baseckhs   )->|    |->sau_0_intsau1(sau_0_intsau1)
//         rst_dac_res_n(rst_dac_res_n  )->|    |->sau_0_seint1 (sau_0_seint1)
//          clk_dac_pclk(clk_dac_pclk   )->|    |->c2c_waitmem  (c2c_waitmem)
//          clk_rcn_pclk(clk_rcn_pclk   )->|    |->sau_1_intsau0(sau_1_intsau0)
//     clk_rcn_clka_can(clk_rcn_clka_can)->|    |->sau_1_seint0 (sau_1_seint0)
//       rst_rcn_presetz(rst_rcn_presetz)->|    |->sau_1_intsau1(sau_1_intsau1)
//       clk_lin3_0_pclk(clk_lin3_0_pclk)->|    |->sau_1_seint1 (sau_1_seint1)
//              clk_clkc(clk_clkc       )->|    |->P130         (P130)
//     rst_lin3_0_res_n(rst_lin3_0_res_n)->|    |->pt_mod_hvin  (pt_mod_hvin)
//        clk_sau_0_pclk(clk_sau_0_pclk )->|    |->pt_mod_routsrc10(pt_mod_routsrc10)
//          clk_c2c_pclk(clk_c2c_pclk   )->|    |->pt_mod_routsrc12(pt_mod_routsrc12)
//         rst_c2c_res_n(rst_c2c_res_n  )->|    |->pt_mod_tdin0r(pt_mod_tdin0r)
//       rst_sau_0_res_n(rst_sau_0_res_n)->|    |->pt_mod_tdin0t(pt_mod_tdin0t)
//        clk_sau_1_pclk(clk_sau_1_pclk )->|    |->pt_mod_tdin1r(pt_mod_tdin1r)
//       rst_sau_1_res_n(rst_sau_1_res_n)->|    |->pt_mod_tdin1t(pt_mod_tdin1t)
//                   P00(P00            )->|    |->pt_mod_tdin2r(pt_mod_tdin2r)
//                   P01(P01            )->|    |->pt_mod_tdin2t(pt_mod_tdin2t)
//                   P02(P02            )->|    |->pt_mod_tdin3 (pt_mod_tdin3)
//                   P10(P10            )->|    |->pt_mod_tdin4 (pt_mod_tdin4)
//                   P11(P11            )->|    |->pt_mod_tdin5 (pt_mod_tdin5)
//                   P12(P12            )->|    |->pt_mod_tin00 (pt_mod_tin00)
//                  P120(P120           )->|    |->pt_ocd_toolrx(pt_ocd_toolrx)
//                  P125(P125           )->|    |->pt_oscm_x1eni(pt_oscm_x1eni)
//                  P126(P126           )->|    |->pt_oscm_x2eni(pt_oscm_x2eni)
//                   P13(P13            )->|    |->pt_oscs_xt1eni(pt_oscs_xt1eni)
//                  P137(P137           )->|    |->pt_oscs_xt2eni(pt_oscs_xt2eni)
//                   P14(P14            )->|    |->pt_crx_in_int(pt_crx_in_int)
//                  P140(P140           )->|    |->pt_ocd_rxocd (pt_ocd_rxocd)
//                   P15(P15            )->|    |->pporga_cap_sel08p(pporga_cap_sel08p)
//                   P16(P16            )->|    |->fpga_dgen[15:0](fpga_dgen[15:0])
//                   P17(P17            )->|    |
//                   P30(P30            )->|    |
//                   P31(P31            )->|    |
//                   P32(P32            )->|    |
//                   P33(P33            )->|    |
//                   P34(P34            )->|    |
//                   P40(P40            )->|    |
//                   P41(P41            )->|    |
//                   P42(P42            )->|    |
//                   P43(P43            )->|    |
//                   P44(P44            )->|    |
//                   P45(P45            )->|    |
//                   P46(P46            )->|    |
//                   P47(P47            )->|    |
//                   P50(P50            )->|    |
//                   P51(P51            )->|    |
//                   P52(P52            )->|    |
//                   P53(P53            )->|    |
//                   P54(P54            )->|    |
//                   P55(P55            )->|    |
//                   P56(P56            )->|    |
//                   P57(P57            )->|    |
//                   P60(P60            )->|    |
//                   P61(P61            )->|    |
//                   P62(P62            )->|    |
//                   P63(P63            )->|    |
//                   P64(P64            )->|    |
//                   P65(P65            )->|    |
//                   P66(P66            )->|    |
//                   P67(P67            )->|    |
//                   P70(P70            )->|    |
//                   P71(P71            )->|    |
//                   P72(P72            )->|    |
//                   P73(P73            )->|    |
//                   P74(P74            )->|    |
//                   P75(P75            )->|    |
//                   P76(P76            )->|    |
//                   P77(P77            )->|    |
//                   P80(P80            )->|    |
//                   P81(P81            )->|    |
//                   P82(P82            )->|    |
//                   P83(P83            )->|    |
//                   P84(P84            )->|    |
//                   P85(P85            )->|    |
//                   P86(P86            )->|    |
//                   P87(P87            )->|    |
//                   P90(P90            )->|    |
//                   P91(P91            )->|    |
//                   P92(P92            )->|    |
//                   P93(P93            )->|    |
//                   P94(P94            )->|    |
//                   P95(P95            )->|    |
//                   P96(P96            )->|    |
//                   P97(P97            )->|    |
// pt_hflashcp_vpptsin_va(pt_hflashcp_vpptsin_va)->|    |
//           cibc_selin1(cibc_selin1    )->|    |
// bbr_prdsel_pclm[3:0](bbr_prdsel_pclm[3:0])->|    |
//          csc_tselires(csc_tselires   )->|    |
//          csc_tseloreg(csc_tseloreg   )->|    |
//             csc_ttemp(csc_ttemp      )->|    |
//            stopst_p31(stopst_p31     )->|    |
//            stopst_p52(stopst_p52     )->|    |
//           fcb_modidis(fcb_modidis    )->|    |
//            mod_gofirm(mod_gofirm     )->|    |
//          mod_optoplrd(mod_optoplrd   )->|    |
//            mod_tdout0(mod_tdout0     )->|    |
//            mod_tdout1(mod_tdout1     )->|    |
//            mod_tdout2(mod_tdout2     )->|    |
//            mod_tdout3(mod_tdout3     )->|    |
//           mod_tdsel0r(mod_tdsel0r    )->|    |
//           mod_tdsel0t(mod_tdsel0t    )->|    |
//           mod_tdsel1r(mod_tdsel1r    )->|    |
//           mod_tdsel1t(mod_tdsel1t    )->|    |
//           mod_tdsel2r(mod_tdsel2r    )->|    |
//           mod_tdsel2t(mod_tdsel2t    )->|    |
//            mod_tdsel3(mod_tdsel3     )->|    |
//           mod_tesdbt2(mod_tesdbt2    )->|    |
//          mod_teseni0r(mod_teseni0r   )->|    |
//          mod_teseni0t(mod_teseni0t   )->|    |
//          mod_teseni1r(mod_teseni1r   )->|    |
//          mod_teseni1t(mod_teseni1t   )->|    |
//          mod_teseni2r(mod_teseni2r   )->|    |
//          mod_teseni2t(mod_teseni2t   )->|    |
//           mod_teseni3(mod_teseni3    )->|    |
//           mod_teseni4(mod_teseni4    )->|    |
//          mod_teseno0r(mod_teseno0r   )->|    |
//          mod_teseno0t(mod_teseno0t   )->|    |
//          mod_teseno1r(mod_teseno1r   )->|    |
//          mod_teseno1t(mod_teseno1t   )->|    |
//          mod_teseno2r(mod_teseno2r   )->|    |
//          mod_teseno2t(mod_teseno2t   )->|    |
//           mod_teseno3(mod_teseno3    )->|    |
//          cibc_opocden(cibc_opocden   )->|    |
//            ocd_ocdmod(ocd_ocdmod     )->|    |
//           ocd_sltrxtx(ocd_sltrxtx    )->|    |
//           ocd_sprgmod(ocd_sprgmod    )->|    |
//            ocd_hpimod(ocd_hpimod     )->|    |
//             ocd_txocd(ocd_txocd      )->|    |
//     hhoco_oregout_va(hhoco_oregout_va)->|    |
//            oscm_x1din(oscm_x1din     )->|    |
//            oscm_x2din(oscm_x2din     )->|    |
//           oscs_xt1din(oscs_xt1din    )->|    |
//           oscs_xt2din(oscs_xt2din    )->|    |
//        regm_pocrel_v5(regm_pocrel_v5 )->|    |
//           rst_nsres_n(rst_nsres_n    )->|    |
//            mod_seltar(mod_seltar     )->|    |
//              csc_tstn(csc_tstn       )->|    |
//            mod_moderd(mod_moderd     )->|    |
//            mod_modewr(mod_modewr     )->|    |
//         mod_incdecws1(mod_incdecws1  )->|    |
//         mod_incdecws0(mod_incdecws0  )->|    |
//          mod_ta[16:0](mod_ta[16:0]   )->|    |
//           mod_modenop(mod_modenop    )->|    |
//          fcb_dw[31:0](fcb_dw[31:0]   )->|    |
//         ramif_rcn_cmt(ramif_rcn_cmt  )->|    |
//           regm_vbg2ad(regm_vbg2ad    )->|    |
//        rst_rtbfg_n_v5(rst_rtbfg_n_v5 )->|    |
//                                         +----+
// ------------------------------------------------------------

crl78fpericore_f14m pericore (
	.clk_pclkrw(clk_pclkrw) ,
	.clk_iic_0_pclk(clk_iic_0_pclk) ,
	.rst_iic_0_res_n(rst_iic_0_res_n) ,
	.iic_0_intiic0(iic_0_intiic0) ,
	.ocd_svperi1(ocd_svperi1) ,
	.clk_scan(clk_scan) ,
	.mod_scanen(mod_scanen) ,
	.mod_scanmode(mod_scanmode) ,
	.fpga_clk60mhz(1'b0) ,
	.clk_tau_1_pclk(clk_tau_1_pclk) ,
	.rst_tau_1_res_n(rst_tau_1_res_n) ,
	.tau_1_int3(tau_1_int3) ,
	.tau_1_int2(tau_1_int2) ,
	.tau_1_int1(tau_1_int1) ,
	.tau_1_int0(tau_1_int0) ,
	.tau_1_inth3(tau_1_inth3) ,
	.tau_1_inth1(tau_1_inth1) ,
	.clk_tau_0_pclk(clk_tau_0_pclk) ,
	.rst_tau_0_res_n(rst_tau_0_res_n) ,
	.tau_0_int0(tau_0_int0) ,
	.tau_0_int1(tau_0_int1) ,
	.tau_0_int2(tau_0_int2) ,
	.tau_0_int3(tau_0_int3) ,
	.tau_0_int4(tau_0_int4) ,
	.tau_0_int5(tau_0_int5) ,
	.tau_0_int6(tau_0_int6) ,
	.tau_0_int7(tau_0_int7) ,
	.tau_0_inth1(tau_0_inth1) ,
	.tau_0_inth3(tau_0_inth3) ,
	.rst_timd_0_res_n(rst_timd_0_res_n) ,
	.ocd_svperi0(ocd_svperi0) ,
	.clk_timd_0_pclk(clk_timd_0_pclk) ,
	.dtc_timd_0_endimfa0(dtc_intdtc26) ,
	.dtc_timd_0_endimfb0(dtc_intdtc27) ,
	.dtc_timd_0_endimfc0(dtc_intdtc28) ,
	.dtc_timd_0_endimfd0(dtc_intdtc29) ,
	.dtc_timd_0_endimfa1(dtc_intdtc30) ,
	.dtc_timd_0_endimfb1(dtc_intdtc31) ,
	.dtc_timd_0_endimfc1(dtc_intdtc32) ,
	.dtc_timd_0_endimfd1(dtc_intdtc33) ,
	.timd_0_reqimfa0(timd_0_reqimfa0) ,
	.timd_0_reqimfb0(timd_0_reqimfb0) ,
	.timd_0_reqimfc0(timd_0_reqimfc0) ,
	.timd_0_reqimfd0(timd_0_reqimfd0) ,
	.timd_0_reqimfa1(timd_0_reqimfa1) ,
	.timd_0_reqimfb1(timd_0_reqimfb1) ,
	.timd_0_reqimfc1(timd_0_reqimfc1) ,
	.timd_0_reqimfd1(timd_0_reqimfd1) ,
	.timd_0_irreq0(timd_0_irreq0) ,
	.timd_0_irreq1(timd_0_irreq1) ,
	.rst_timj_0_res_n(rst_timj_0_res_n) ,
	.clk_fsub(clk_fsub) ,
	.clk_fil_intrclk(clk_fil_intrclk) ,
	.clk_timj_0_pclk(clk_timj_0_pclk) ,
	.timj_0_prsclen(timj_0_prsclen) ,
	.timj_0_reqirq_k(timj_0_reqirq_k) ,
	.clk_adc_pclk(clk_adc_pclk) ,
	.rst_adc_res_n(rst_adc_res_n) ,
	.adc_reqpclk(adc_reqpclk) ,
	.adc_intad(adc_intad) ,
	.adc_bg2aden(adc_bg2aden) ,
	.adc_bg2adsel(adc_bg2adsel) ,
	.mod_tesdbt(mod_tesdbt) ,
	.rst_reset_n(rst_reset_n) ,
	.rst_res_n(rst_res_n) ,
	.csc_resstp(csc_resstp) ,
	.clk_fmain(clk_fmain) ,
	.rst_scanres_n(rst_scanres_n) ,
	.csc_rt0lpm(csc_rt0lpm) ,
	.clk_rtc_pclk(clk_rtc_pclk) ,
	.rst_rtc_res_n(rst_rtc_res_n) ,
	.clk_rtc_mclk(clk_rtc_mclk) ,
	.clk_rtc_tclk(clk_rtc_tclk) ,
	.pgcsc_cksel(pgcsc_cksel) ,
	.mod_optbct(mod_optbct) ,
	.rtc_intrtc(rtc_intrtc) ,
	.rtc_intrtci(rtc_intrtci) ,
	.rtc_rt0mon0(rtc_rt0mon0) ,
	.rtc_rt0mon1(rtc_rt0mon1) ,
	.krif_intkr(krif_intkr) ,
	.bbr_bbrsub_apbmask(bbr_bbrsub_apbmask) ,
	.bbr_bbrsub_psel1st(bbr_bbrsub_psel1st) ,
	.bbr_bbrsub_psel2nd(bbr_bbrsub_psel2nd) ,
	.bbr_penable(bbr_penable) ,
	.bbrsub_prdata(bbrsub_prdata[15:0]) ,
	.bbrsub_timd_0_pselal(bbrsub_timd_0_pselal) ,
	.cibc_frqsel4(cibc_frqsel4) ,
	.clk_dspclkrw(clk_dspclkrw) ,
	.cpu_cpuwr(cpu_cpuwr) ,
	.cpu_ma(cpu_ma[10:0]) ,
	.cpu_mdw(cpu_mdw[15:0]) ,
	.cpu_wdop(cpu_wdop) ,
	.porga_gdint(porga_gdint) ,
	.csc_cken(csc_cken[15:1]) ,
	.csc_per0(csc_per0[7:0]) ,
	.pgcsc_dscken1(pgcsc_dscken1) ,
	.pgcsc_dscken2(pgcsc_dscken2) ,
	.pgcsc_dscken3(pgcsc_dscken3) ,
	.pgcsc_dscken5(pgcsc_dscken5) ,
	.pgcsc_per14(pgcsc_per14) ,
	.ifil_intp0(ifil_intp0) ,
	.ifil_intp1(ifil_intp1) ,
	.ifil_intp2(ifil_intp2) ,
	.ifil_intp3(ifil_intp3) ,
	.ifil_intp4(ifil_intp4) ,
	.ifil_intp5(ifil_intp5) ,
	.ifil_intp6(ifil_intp6) ,
	.ifil_intp7(ifil_intp7) ,
	.ifil_intp8(ifil_intp8) ,
	.ifil_intp9(ifil_intp9) ,
	.ifil_intp10(ifil_intp10) ,
	.ifil_intp11(ifil_intp11) ,
	.clk_fclkrt(clk_fclkrt) ,
	.porga_iawen(porga_iawen) ,
	.porga_gdram(porga_gdram[1:0]) ,
	.porga_gdcsc(porga_gdcsc) ,
	.capmx_adtrig0(capmx_adtrig0) ,
	.capmx_adtrig1(capmx_adtrig1) ,
	.capmx_intrtcdis(capmx_intrtcdis) ,
	.mod_oti00(mod_oti00) ,
	.clk_fil(clk_fil) ,
	.clk_fmx(clk_fmx) ,
	.clk_bbclkr(clk_bbclkr) ,
	.dtc_intdtc5(dtc_intdtc5) ,
	.dtc_intdtc6(dtc_intdtc6) ,
	.dtc_intdtc7(dtc_intdtc7) ,
	.porga_intdtc5(porga_intdtc5) ,
	.porga_intdtc6(porga_intdtc6) ,
	.porga_intdtc7(porga_intdtc7) ,
	.rst_comp_res_n(rst_comp_res_n) ,
	.clk_comp_pclk(clk_comp_pclk) ,
	.comp_cdfs(comp_cdfs[1:0]) ,
	.mod_tesinst(mod_tesinst) ,
	.comp_cirq(comp_cirq) ,
	.clk_baseckhs(clk_baseckhs) ,
	.rst_dac_res_n(rst_dac_res_n) ,
	.clk_dac_pclk(clk_dac_pclk) ,
	.clk_rcn_pclk(clk_rcn_pclk) ,
	.clk_rcn_clka_can(clk_rcn_clka_can) ,
	.rst_rcn_presetz(rst_rcn_presetz) ,
	.rcn_cherr_int(rcn_cherr_int) ,
	.rcn_comfrx_int(rcn_comfrx_int) ,
	.rcn_glerr_int(rcn_glerr_int) ,
	.rcn_rxf_int(rcn_rxf_int) ,
	.rcn_tx_int(rcn_tx_int) ,
	.clk_lin3_0_pclk(clk_lin3_0_pclk) ,
	.clk_clkc(clk_clkc) ,
	.rst_lin3_0_res_n(rst_lin3_0_res_n) ,
	.lin3_0_int_t(lin3_0_int_t) ,
	.lin3_0_int_r(lin3_0_int_r) ,
	.lin3_0_int_s(lin3_0_int_s) ,
	.lin3_0_int_m(lin3_0_int_m) ,
	.lin3_0_reqpclk(lin3_0_reqpclk) ,
	.clk_sau_0_pclk(clk_sau_0_pclk) ,
	.clk_c2c_pclk(clk_c2c_pclk) ,
	.rst_c2c_res_n(rst_c2c_res_n) ,
	.rst_sau_0_res_n(rst_sau_0_res_n) ,
	.sau_0_intsau0(sau_0_intsau0) ,
	.sau_0_seint0(sau_0_seint0) ,
	.sau_0_intsau1(sau_0_intsau1) ,
	.sau_0_seint1(sau_0_seint1) ,
	.c2c_waitmem(c2c_waitmem) ,
	.clk_sau_1_pclk(clk_sau_1_pclk) ,
	.rst_sau_1_res_n(rst_sau_1_res_n) ,
	.sau_1_intsau0(sau_1_intsau0) ,
	.sau_1_seint0(sau_1_seint0) ,
	.sau_1_intsau1(sau_1_intsau1) ,
	.sau_1_seint1(sau_1_seint1) ,
	.P00(P00) ,
	.P01(P01) ,
	.P02(P02) ,
	.P10(P10) ,
	.P11(P11) ,
	.P12(P12) ,
	.P120(P120) ,
	.P125(P125) ,
	.P126(P126) ,
	.P13(P13) ,
	.P130(P130) ,
	.P137(P137) ,
	.P14(P14) ,
	.P140(P140) ,
	.P15(P15) ,
	.P16(P16) ,
	.P17(P17) ,
	.P30(P30) ,
	.P31(P31) ,
	.P32(P32) ,
	.P33(P33) ,
	.P34(P34) ,
	.P40(P40) ,
	.P41(P41) ,
	.P42(P42) ,
	.P43(P43) ,
	.P44(P44) ,
	.P45(P45) ,
	.P46(P46) ,
	.P47(P47) ,
	.P50(P50) ,
	.P51(P51) ,
	.P52(P52) ,
	.P53(P53) ,
	.P54(P54) ,
	.P55(P55) ,
	.P56(P56) ,
	.P57(P57) ,
	.P60(P60) ,
	.P61(P61) ,
	.P62(P62) ,
	.P63(P63) ,
	.P64(P64) ,
	.P65(P65) ,
	.P66(P66) ,
	.P67(P67) ,
	.P70(P70) ,
	.P71(P71) ,
	.P72(P72) ,
	.P73(P73) ,
	.P74(P74) ,
	.P75(P75) ,
	.P76(P76) ,
	.P77(P77) ,
	.P80(P80) ,
	.P81(P81) ,
	.P82(P82) ,
	.P83(P83) ,
	.P84(P84) ,
	.P85(P85) ,
	.P86(P86) ,
	.P87(P87) ,
	.P90(P90) ,
	.P91(P91) ,
	.P92(P92) ,
	.P93(P93) ,
	.P94(P94) ,
	.P95(P95) ,
	.P96(P96) ,
	.P97(P97) ,
	.pt_hflashcp_vpptsin_va(pt_hflashcp_vpptsin_va) ,
	.cibc_selin1(cibc_selin1) ,
	.bbr_prdsel_pclm(bbr_prdsel_pclm[3:0]) ,
	.csc_tselires(csc_tselires) ,
	.csc_tseloreg(csc_tseloreg) ,
	.csc_ttemp(csc_ttemp) ,
	.stopst_p31(stopst_p31) ,
	.stopst_p52(stopst_p52) ,
	.fcb_modidis(fcb_modidis) ,
	.mod_gofirm(mod_gofirm) ,
	.mod_optoplrd(mod_optoplrd) ,
	.mod_tdout0(mod_tdout0) ,
	.mod_tdout1(mod_tdout1) ,
	.mod_tdout2(mod_tdout2) ,
	.mod_tdout3(mod_tdout3) ,
	.mod_tdsel0r(mod_tdsel0r) ,
	.mod_tdsel0t(mod_tdsel0t) ,
	.mod_tdsel1r(mod_tdsel1r) ,
	.mod_tdsel1t(mod_tdsel1t) ,
	.mod_tdsel2r(mod_tdsel2r) ,
	.mod_tdsel2t(mod_tdsel2t) ,
	.mod_tdsel3(mod_tdsel3) ,
	.mod_tesdbt2(mod_tesdbt2) ,
	.mod_teseni0r(mod_teseni0r) ,
	.mod_teseni0t(mod_teseni0t) ,
	.mod_teseni1r(mod_teseni1r) ,
	.mod_teseni1t(mod_teseni1t) ,
	.mod_teseni2r(mod_teseni2r) ,
	.mod_teseni2t(mod_teseni2t) ,
	.mod_teseni3(mod_teseni3) ,
	.mod_teseni4(mod_teseni4) ,
	.mod_teseno0r(mod_teseno0r) ,
	.mod_teseno0t(mod_teseno0t) ,
	.mod_teseno1r(mod_teseno1r) ,
	.mod_teseno1t(mod_teseno1t) ,
	.mod_teseno2r(mod_teseno2r) ,
	.mod_teseno2t(mod_teseno2t) ,
	.mod_teseno3(mod_teseno3) ,
	.cibc_opocden(cibc_opocden) ,
	.ocd_ocdmod(ocd_ocdmod) ,
	.ocd_sltrxtx(ocd_sltrxtx) ,
	.ocd_sprgmod(ocd_sprgmod) ,
	.ocd_hpimod(ocd_hpimod) ,
	.ocd_txocd(ocd_txocd) ,
	.hhoco_oregout_va(hhoco_oregout_va) ,
	.oscm_x1din(oscm_x1din) ,
	.oscm_x2din(oscm_x2din) ,
	.oscs_xt1din(oscs_xt1din) ,
	.oscs_xt2din(oscs_xt2din) ,
	.regm_pocrel_v5(regm_pocrel_v5) ,
	.rst_nsres_n(rst_nsres_n) ,
	.pt_mod_hvin(pt_mod_hvin) ,
	.pt_mod_routsrc10(pt_mod_routsrc10) ,
	.pt_mod_routsrc12(pt_mod_routsrc12) ,
	.pt_mod_tdin0r(pt_mod_tdin0r) ,
	.pt_mod_tdin0t(pt_mod_tdin0t) ,
	.pt_mod_tdin1r(pt_mod_tdin1r) ,
	.pt_mod_tdin1t(pt_mod_tdin1t) ,
	.pt_mod_tdin2r(pt_mod_tdin2r) ,
	.pt_mod_tdin2t(pt_mod_tdin2t) ,
	.pt_mod_tdin3(pt_mod_tdin3) ,
	.pt_mod_tdin4(pt_mod_tdin4) ,
	.pt_mod_tdin5(pt_mod_tdin5) ,
	.pt_mod_tin00(pt_mod_tin00) ,
	.pt_ocd_toolrx(pt_ocd_toolrx) ,
	.pt_oscm_x1eni(pt_oscm_x1eni) ,
	.pt_oscm_x2eni(pt_oscm_x2eni) ,
	.pt_oscs_xt1eni(pt_oscs_xt1eni) ,
	.pt_oscs_xt2eni(pt_oscs_xt2eni) ,
	.pt_crx_in_int(pt_crx_in_int) ,
	.pt_ocd_rxocd(pt_ocd_rxocd) ,
	.pporga_cap_sel08p(pporga_cap_sel08p) ,
	.fpga_dgen(fpga_dgen[15:0]) ,
	.mod_seltar(mod_seltar) ,
	.csc_tstn(csc_tstn) ,
	.mod_moderd(mod_moderd) ,
	.mod_modewr(mod_modewr) ,
	.mod_incdecws1(mod_incdecws1) ,
	.mod_incdecws0(mod_incdecws0) ,
	.mod_ta(mod_ta[16:0]) ,
	.mod_modenop(mod_modenop) ,
	.fcb_dw(fcb_dw[31:0]) ,
	.ramif_rcn_cmt(ramif_rcn_cmt) ,
	.regm_vbg2ad(regm_vbg2ad) ,
	.rst_rtbfg_n_v5(rst_rtbfg_n_v5)
);

// ------------------------------------------------------------
//                    crl78hcapckgate(capckgate)
//                                         +----+
//          capmx_bbmode(capmx_bbmode   )->|    |->clk_bboscoutm(clk_bboscoutm)
//          mod_scanmode(mod_scanmode   )->|    |->clk_bbr32mout(clk_bbr32mout)
//           clk_oscoutm(clk_fmx        )->|    |->clk_bbfmain  (clk_bbfmain)
//           clk_r32mout(clk_fhoco      )->|    |->clk_bbfsub   (clk_bbfsub)
//             clk_fmain(clk_fmain      )->|    |->clk_bbfclkrt (clk_bbfclkrt)
//              clk_fsub(clk_fsub       )->|    |->clk_bbr15kout(clk_bbr15kout)
//            clk_fclkrt(clk_fclkrt     )->|    |
//           clk_r15kout(clk_fil        )->|    |
//                                         +----+
// ------------------------------------------------------------

crl78hcapckgate capckgate (
	.capmx_bbmode(capmx_bbmode) ,
	.mod_scanmode(mod_scanmode) ,
	.clk_oscoutm(clk_fmx) ,
	.clk_r32mout(clk_fhoco) ,
	.clk_fmain(clk_fmain) ,
	.clk_fsub(clk_fsub) ,
	.clk_fclkrt(clk_fclkrt) ,
	.clk_r15kout(clk_fil) ,
	.clk_bboscoutm(clk_bboscoutm) ,
	.clk_bbr32mout(clk_bbr32mout) ,
	.clk_bbfmain(clk_bbfmain) ,
	.clk_bbfsub(clk_bbfsub) ,
	.clk_bbfclkrt(clk_bbfclkrt) ,
	.clk_bbr15kout(clk_bbr15kout)
);

// ------------------------------------------------------------
//                    crl78hcapcore_f14m(capbuf)
//                                         +----+
//     pt_cap_selin1b_v5(1'b0           )->|    |->clk_bbclkr   (clk_bbclkr)
//         clk_bboscoutm(clk_bboscoutm  )->|    |->clk_bbclkm   (clk_bbclkm)
//         clk_bbr32mout(clk_bbr32mout  )->|    |->cap_bbmode   (capmx_bbmode)
//           clk_bbfmain(clk_bbfmain    )->|    |->cap_bbreqpclk(capmx_bbreqpclk)
//            clk_bbfsub(clk_bbfsub     )->|    |->cap_bbckselr (capmx_bbckselr)
//          clk_bbfclkrt(clk_bbfclkrt   )->|    |->cap_bbckselm (capmx_bbckselm)
//         clk_bbr15kout(clk_bbr15kout  )->|    |->cap_bbhioon  (capmx_bbhioon)
//          rst_sysres_n(rst_sysres_n   )->|    |->cap_bbregctl (capmx_bbregctl)
//           rst_reset_n(rst_reset_n    )->|    |->cap_bbprdata[15:0](capmx_bbprdata[15:0])
//             rst_res_n(rst_res_n      )->|    |->cap_waitmem  (capmx_waitmem)
//          csc_stpbckbt(csc_stpbckbt   )->|    |->cap_wait2nd56(capmx_wait2nd56)
//              csc_rsts(csc_rsts       )->|    |->cap_bbint0   (capmx_bbint0)
//            csc_resstp(csc_resstp     )->|    |->cap_bbint1   (capmx_bbint1)
//           csc_bckhsen(csc_bckhsen    )->|    |->cap_bbint2   (capmx_bbint2)
//             csc_fmxst(csc_fmxst      )->|    |->cap_bbint3   (capmx_bbint3)
//           csc_subckst(csc_subckst    )->|    |->cap_bbint4   (capmx_bbint4)
//           csc_bbckstr(csc_bbckstr    )->|    |->cap_bbint5   (capmx_bbint5)
//           csc_bbckstm(csc_bbckstm    )->|    |->cap_bbint6   (capmx_bbint6)
//          bbr_bbpwrite(bbr_bbpwrite   )->|    |->cap_bbint7   (capmx_bbint7)
//         bbr_bbpenable(bbr_bbpenable  )->|    |->cap_bbint8   (capmx_bbint8)
//       bbr_bbadr[15:0](bbr_bbadr[15:0])->|    |->cap_bbint9   (capmx_bbint9)
//       bbr_bbmdw[15:0](bbr_bbmdw[15:0])->|    |->cap_bbint10  (capmx_bbint10)
//           cibc_bbnvm1(1'b0           )->|    |->cap_bbint11  (capmx_bbint11)
//           cibc_bbnvm2(cibc_bbnvm2    )->|    |->cap_bbint12  (capmx_bbint12)
//            ocd_svstop(ocd_svstop     )->|    |->cap_bbint13  (capmx_bbint13)
//           ocd_svperi0(ocd_svperi0    )->|    |->cap_bbint14  (capmx_bbint14)
//           ocd_svperi1(ocd_svperi1    )->|    |->cap_bbint15  (capmx_bbint15)
//              clk_scan(clk_scan       )->|    |->cap_bbint16  (capmx_bbint16)
//          mod_scanmode(mod_scanmode   )->|    |->cap_bbint17  (capmx_bbint17)
//            mod_scanen(mod_scanen     )->|    |->cap_bbint18  (capmx_bbint18)
//            mod_scanin(mod_scanin     )->|    |->cap_bbint19  (capmx_bbint19)
//          mod_tesscan1(mod_tesscan1   )->|    |->cap_bbint20  (capmx_bbint20)
//         mod_bbtesinst(mod_bbtesinst  )->|    |->cap_bbint21  (capmx_bbint21)
//           mod_optiddq(mod_optiddq    )->|    |->cap_bbscanout(capmx_bbscanout)
//          mod_optexcck(mod_optexcck   )->|    |->cap_adtrig0  (capmx_adtrig0)
//           mod_tesdbt2(mod_tesdbt2    )->|    |->cap_adtrig1  (capmx_adtrig1)
//            mod_tesdbt(mod_tesdbt     )->|    |->cap_intrtcdis(capmx_intrtcdis)
//   pporga_cap_sel08p(pporga_cap_sel08p)->|    |->cap_frq4en   (capmx_frq4en)
//       bbr_bbselsfr1st(bbr_bbselsfr1st)->|    |->cap_bbrperr  (capmx_bbrperr)
//       bbr_bbselsfr2nd(bbr_bbselsfr2nd)->|    |
//             cpu_slmem(cpu_slmem      )->|    |
//            cpu_fchram(cpu_fchram     )->|    |
//              cpu_wdop(cpu_wdop       )->|    |
//           ramif_stn_n(ramif_stn_n    )->|    |
//       ramif_mode[1:0](ramif_mode[1:0])->|    |
//           iaw_gdramwr(iaw_gdramwr    )->|    |
//                                         +----+
// ------------------------------------------------------------

crl78hcapcore_f14m capbuf (
	.pt_cap_selin1b_v5(1'b0) ,
	.clk_bboscoutm(clk_bboscoutm) ,
	.clk_bbr32mout(clk_bbr32mout) ,
	.clk_bbfmain(clk_bbfmain) ,
	.clk_bbfsub(clk_bbfsub) ,
	.clk_bbfclkrt(clk_bbfclkrt) ,
	.clk_bbr15kout(clk_bbr15kout) ,
	.clk_bbclkr(clk_bbclkr) ,
	.clk_bbclkm(clk_bbclkm) ,
	.rst_sysres_n(rst_sysres_n) ,
	.rst_reset_n(rst_reset_n) ,
	.rst_res_n(rst_res_n) ,
	.csc_stpbckbt(csc_stpbckbt) ,
	.csc_rsts(csc_rsts) ,
	.csc_resstp(csc_resstp) ,
	.csc_bckhsen(csc_bckhsen) ,
	.csc_fmxst(csc_fmxst) ,
	.csc_subckst(csc_subckst) ,
	.csc_bbckstr(csc_bbckstr) ,
	.csc_bbckstm(csc_bbckstm) ,
	.bbr_bbpwrite(bbr_bbpwrite) ,
	.bbr_bbpenable(bbr_bbpenable) ,
	.bbr_bbadr(bbr_bbadr[15:0]) ,
	.bbr_bbmdw(bbr_bbmdw[15:0]) ,
	.cibc_bbnvm1(1'b0) ,
	.cibc_bbnvm2(cibc_bbnvm2) ,
	.ocd_svstop(ocd_svstop) ,
	.ocd_svperi0(ocd_svperi0) ,
	.ocd_svperi1(ocd_svperi1) ,
	.clk_scan(clk_scan) ,
	.mod_scanmode(mod_scanmode) ,
	.mod_scanen(mod_scanen) ,
	.mod_scanin(mod_scanin) ,
	.mod_tesscan1(mod_tesscan1) ,
	.mod_bbtesinst(mod_bbtesinst) ,
	.mod_optiddq(mod_optiddq) ,
	.mod_optexcck(mod_optexcck) ,
	.mod_tesdbt2(mod_tesdbt2) ,
	.mod_tesdbt(mod_tesdbt) ,
	.pporga_cap_sel08p(pporga_cap_sel08p) ,
	.bbr_bbselsfr1st(bbr_bbselsfr1st) ,
	.bbr_bbselsfr2nd(bbr_bbselsfr2nd) ,
	.cpu_slmem(cpu_slmem) ,
	.cpu_fchram(cpu_fchram) ,
	.cpu_wdop(cpu_wdop) ,
	.ramif_stn_n(ramif_stn_n) ,
	.ramif_mode(ramif_mode[1:0]) ,
	.iaw_gdramwr(iaw_gdramwr) ,
	.cap_bbmode(capmx_bbmode) ,
	.cap_bbreqpclk(capmx_bbreqpclk) ,
	.cap_bbckselr(capmx_bbckselr) ,
	.cap_bbckselm(capmx_bbckselm) ,
	.cap_bbhioon(capmx_bbhioon) ,
	.cap_bbregctl(capmx_bbregctl) ,
	.cap_bbprdata(capmx_bbprdata[15:0]) ,
	.cap_waitmem(capmx_waitmem) ,
	.cap_wait2nd56(capmx_wait2nd56) ,
	.cap_bbint0(capmx_bbint0) ,
	.cap_bbint1(capmx_bbint1) ,
	.cap_bbint2(capmx_bbint2) ,
	.cap_bbint3(capmx_bbint3) ,
	.cap_bbint4(capmx_bbint4) ,
	.cap_bbint5(capmx_bbint5) ,
	.cap_bbint6(capmx_bbint6) ,
	.cap_bbint7(capmx_bbint7) ,
	.cap_bbint8(capmx_bbint8) ,
	.cap_bbint9(capmx_bbint9) ,
	.cap_bbint10(capmx_bbint10) ,
	.cap_bbint11(capmx_bbint11) ,
	.cap_bbint12(capmx_bbint12) ,
	.cap_bbint13(capmx_bbint13) ,
	.cap_bbint14(capmx_bbint14) ,
	.cap_bbint15(capmx_bbint15) ,
	.cap_bbint16(capmx_bbint16) ,
	.cap_bbint17(capmx_bbint17) ,
	.cap_bbint18(capmx_bbint18) ,
	.cap_bbint19(capmx_bbint19) ,
	.cap_bbint20(capmx_bbint20) ,
	.cap_bbint21(capmx_bbint21) ,
	.cap_bbscanout(capmx_bbscanout) ,
	.cap_adtrig0(capmx_adtrig0) ,
	.cap_adtrig1(capmx_adtrig1) ,
	.cap_intrtcdis(capmx_intrtcdis) ,
	.cap_frq4en(capmx_frq4en) ,
	.cap_bbrperr(capmx_bbrperr)
);

endmodule
