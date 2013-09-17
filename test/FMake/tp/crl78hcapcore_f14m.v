// *****************************************************************************
//  (C) COPYRIGHT 2011 RENESAS ELECTRONICS CORPORATION, ALL RIGHTS RESERVED
// *****************************************************************************
//   Module Name:         crl78hcapcore
// *****************************************************************************


 module crl78hcapcore_f14m (
       pt_cap_selin1b_v5
      ,clk_bboscoutm
      ,clk_bbr32mout
      ,clk_bbfmain
      ,clk_bbfsub
      ,clk_bbfclkrt
      ,clk_bbr15kout
      ,rst_sysres_n
      ,rst_reset_n
      ,rst_res_n
      ,csc_stpbckbt
      ,csc_rsts
      ,csc_resstp
      ,csc_bckhsen
      ,csc_fmxst
      ,csc_subckst
      ,csc_bbckstr
      ,csc_bbckstm
      ,bbr_bbpwrite
      ,bbr_bbpenable
      ,bbr_bbadr
      ,bbr_bbmdw
      ,cibc_bbnvm1
      ,cibc_bbnvm2
      ,ocd_svstop
      ,ocd_svperi0
      ,ocd_svperi1
      ,clk_scan
      ,mod_scanmode
      ,mod_scanen
      ,mod_scanin
      ,mod_tesscan1
      ,mod_bbtesinst
      ,mod_optiddq
      ,mod_optexcck
      ,mod_tesdbt2
      ,mod_tesdbt
      ,pporga_cap_sel08p
      ,bbr_bbselsfr1st
      ,bbr_bbselsfr2nd
      ,cpu_slmem
      ,cpu_fchram
      ,cpu_wdop
      ,ramif_stn_n
      ,ramif_mode
      ,iaw_gdramwr

      ,clk_bbclkr
      ,clk_bbclkm
      ,cap_bbmode
      ,cap_bbreqpclk
      ,cap_bbckselr
      ,cap_bbckselm
      ,cap_bbhioon
      ,cap_bbregctl
      ,cap_bbprdata
      ,cap_waitmem
      ,cap_wait2nd56
      ,cap_bbint0
      ,cap_bbint1
      ,cap_bbint2
      ,cap_bbint3
      ,cap_bbint4
      ,cap_bbint5
      ,cap_bbint6
      ,cap_bbint7
      ,cap_bbint8
      ,cap_bbint9
      ,cap_bbint10
      ,cap_bbint11
      ,cap_bbint12
      ,cap_bbint13
      ,cap_bbint14
      ,cap_bbint15
      ,cap_bbint16
      ,cap_bbint17
      ,cap_bbint18
      ,cap_bbint19
      ,cap_bbint20
      ,cap_bbint21
      ,cap_bbscanout
      ,cap_adtrig0
      ,cap_adtrig1
      ,cap_intrtcdis
      ,cap_frq4en
      ,cap_bbrperr
  );


    input          pt_cap_selin1b_v5;
    input          clk_bboscoutm;
    input          clk_bbr32mout;
    input          clk_bbfmain;
    input          clk_bbfsub;
    input          clk_bbfclkrt;
    input          clk_bbr15kout;
    input          rst_sysres_n;
    input          rst_reset_n;
    input          rst_res_n;
    input          csc_stpbckbt;
    input          csc_rsts;
    input          csc_resstp;
    input          csc_bckhsen;
    input          csc_fmxst;
    input          csc_subckst;
    input          csc_bbckstr;
    input          csc_bbckstm;
    input          bbr_bbpwrite;
    input          bbr_bbpenable;
    input [15:0]   bbr_bbadr;
    input [15:0]   bbr_bbmdw;
    input          cibc_bbnvm1;
    input          cibc_bbnvm2;
    input          ocd_svstop;
    input          ocd_svperi0;
    input          ocd_svperi1;
    input          clk_scan;
    input          mod_scanmode;
    input          mod_scanen;
    input          mod_scanin;
    input          mod_tesscan1;
    input          mod_bbtesinst;
    input          mod_optiddq;
    input          mod_optexcck;
    input          mod_tesdbt2;
    input          mod_tesdbt;
    input          pporga_cap_sel08p;
    input          bbr_bbselsfr1st;
    input          bbr_bbselsfr2nd;
    input          cpu_slmem;
    input          cpu_fchram;
    input          cpu_wdop;
    input          ramif_stn_n;
    input [1:0]    ramif_mode;
    input          iaw_gdramwr;

    output         clk_bbclkr;
    output         clk_bbclkm;
    output         cap_bbmode;
    output         cap_bbreqpclk;
    output         cap_bbckselr;
    output         cap_bbckselm;
    output         cap_bbhioon;
    output         cap_bbregctl;
    output [15:0]  cap_bbprdata;
    output         cap_waitmem;
    output         cap_wait2nd56;
    output         cap_bbint0;
    output         cap_bbint1;
    output         cap_bbint2;
    output         cap_bbint3;
    output         cap_bbint4;
    output         cap_bbint5;
    output         cap_bbint6;
    output         cap_bbint7;
    output         cap_bbint8;
    output         cap_bbint9;
    output         cap_bbint10;
    output         cap_bbint11;
    output         cap_bbint12;
    output         cap_bbint13;
    output         cap_bbint14;
    output         cap_bbint15;
    output         cap_bbint16;
    output         cap_bbint17;
    output         cap_bbint18;
    output         cap_bbint19;
    output         cap_bbint20;
    output         cap_bbint21;
    output         cap_bbscanout;
    output         cap_adtrig0;
    output         cap_adtrig1;
    output         cap_intrtcdis;
    output         cap_frq4en;
    output         cap_bbrperr;

    wire           clk_bboscoutm_o;
    wire           clk_bbr32mout_o;
    wire           clk_bbfmain_o;
    wire           clk_bbfsub_o;
    wire           clk_bbfclkrt_o;
    wire           clk_bbr15kout_o;
    wire           rst_sysres_n_o;
    wire           rst_reset_n_o;
    wire           rst_res_n_o;
    wire           csc_stpbckbt_o;
    wire           csc_rsts_o;
    wire           csc_resstp_o;
    wire           csc_bckhsen_o;
    wire           csc_fmxst_o;
    wire           csc_subckst_o;
    wire           csc_bbckstr_o;
    wire           csc_bbckstm_o;
    wire           bbr_bbpwrite_o;
    wire           bbr_bbpenable_o;
    wire           bbr_bbadr10_o;
    wire           bbr_bbadr9_o;
    wire           bbr_bbadr8_o;
    wire           bbr_bbadr7_o;
    wire           bbr_bbadr6_o;
    wire           bbr_bbadr5_o;
    wire           bbr_bbadr4_o;
    wire           bbr_bbadr3_o;
    wire           bbr_bbadr2_o;
    wire           bbr_bbadr1_o;
    wire           bbr_bbadr0_o;
    wire           bbr_bbmdw15_o;
    wire           bbr_bbmdw14_o;
    wire           bbr_bbmdw13_o;
    wire           bbr_bbmdw12_o;
    wire           bbr_bbmdw11_o;
    wire           bbr_bbmdw10_o;
    wire           bbr_bbmdw9_o;
    wire           bbr_bbmdw8_o;
    wire           bbr_bbmdw7_o;
    wire           bbr_bbmdw6_o;
    wire           bbr_bbmdw5_o;
    wire           bbr_bbmdw4_o;
    wire           bbr_bbmdw3_o;
    wire           bbr_bbmdw2_o;
    wire           bbr_bbmdw1_o;
    wire           bbr_bbmdw0_o;
    wire           clk_scan_o;
    wire           cibc_bbnvm1_o;
    wire           cibc_bbnvm2_o;
    wire           ocd_svstop_o;
    wire           ocd_svperi0_o;
    wire           ocd_svperi1_o;
    wire           mod_scanmode_o;
    wire           mod_scanen_o;
    wire           mod_scanin_o;
    wire           mod_tesscan1_o;
    wire           mod_bbtesinst_o;
    wire           mod_optiddq_o;
    wire           mod_optexcck_o;
    wire           mod_tesdbt2_o;
    wire           mod_tesdbt_o;
    wire           pporga_cap_sel08p_o;
    wire           bbr_bbselsfr1st_o;
    wire           bbr_bbselsfr2nd_o;
    wire           bbr_bbadr15_o;
    wire           bbr_bbadr14_o;
    wire           bbr_bbadr13_o;
    wire           bbr_bbadr12_o;
    wire           bbr_bbadr11_o;
    wire           cpu_slmem_o;
    wire           cpu_fchram_o;
    wire           cpu_wdop_o;
    wire           ramif_stn_n_o;
    wire           ramif_mode0_o;
    wire           ramif_mode1_o;
    wire           iaw_gdramwr_o;


//  QICAP015H5H cap0 (
  QACAP04 cap0 (
      .ANAI01( pt_cap_selin1b_v5    )

     ,.CLKI01( clk_bboscoutm_o      )
     ,.CLKI02( clk_bbr32mout_o      )
     ,.CLKI03( clk_bbfmain_o        )
     ,.CLKI04( clk_bbfsub_o         )
     ,.CLKI05( clk_bbfclkrt_o       )
     ,.CLKI06( clk_bbr15kout_o      )

     ,.CLKO01( clk_bbclkr           )
     ,.CLKO02( clk_bbclkm           )
     ,.CLKO03(                      )

     ,.SIGI01( rst_sysres_n_o       )
     ,.SIGI02( rst_reset_n_o        )
     ,.SIGI03( rst_res_n_o          )
     ,.SIGI04( csc_stpbckbt_o       )
     ,.SIGI05( csc_rsts_o           )
     ,.SIGI06( csc_resstp_o         )
     ,.SIGI07( csc_bckhsen_o        )
     ,.SIGI08( csc_fmxst_o          )
     ,.SIGI09( csc_subckst_o        )
     ,.SIGI10( csc_bbckstr_o        )
     ,.SIGI11( csc_bbckstm_o        )
     ,.SIGI12( bbr_bbpwrite_o       )
     ,.SIGI13( bbr_bbpenable_o      )
     ,.SIGI14( bbr_bbadr10_o        )
     ,.SIGI15( bbr_bbadr9_o         )
     ,.SIGI16( bbr_bbadr8_o         )
     ,.SIGI17( bbr_bbadr7_o         )
     ,.SIGI18( bbr_bbadr6_o         )
     ,.SIGI19( bbr_bbadr5_o         )
     ,.SIGI20( bbr_bbadr4_o         )
     ,.SIGI21( bbr_bbadr3_o         )
     ,.SIGI22( bbr_bbadr2_o         )
     ,.SIGI23( bbr_bbadr1_o         )
     ,.SIGI24( bbr_bbadr0_o         )
     ,.SIGI25( bbr_bbmdw15_o        )
     ,.SIGI26( bbr_bbmdw14_o        )
     ,.SIGI27( bbr_bbmdw13_o        )
     ,.SIGI28( bbr_bbmdw12_o        )
     ,.SIGI29( bbr_bbmdw11_o        )
     ,.SIGI30( bbr_bbmdw10_o        )
     ,.SIGI31( bbr_bbmdw9_o         )
     ,.SIGI32( bbr_bbmdw8_o         )
     ,.SIGI33( bbr_bbmdw7_o         )
     ,.SIGI34( bbr_bbmdw6_o         )
     ,.SIGI35( bbr_bbmdw5_o         )
     ,.SIGI36( bbr_bbmdw4_o         )
     ,.SIGI37( bbr_bbmdw3_o         )
     ,.SIGI38( bbr_bbmdw2_o         )
     ,.SIGI39( bbr_bbmdw1_o         )
     ,.SIGI40( bbr_bbmdw0_o         )
     ,.SIGI41(                      )
     ,.SIGI42(                      )
     ,.SIGI43(                      )
     ,.SIGI44(                      )
     ,.SIGI45(                      )
     ,.SIGI46(                      )
     ,.SIGI47(                      )
     ,.SIGI48(                      )
     ,.SIGI49(                      )
     ,.SIGI50(                      )
     ,.SIGI51(                      )
//     ,.SIGI52(                      )
//     ,.SIGI53(                      )
//     ,.SIGI54(                      )
//     ,.SIGI55(                      )
//     ,.SIGI56(                      )
//     ,.SIGI57(                      )
//     ,.SIGI58(                      )
//     ,.SIGI59(                      )
//     ,.SIGI60(                      )
//     ,.SIGI61(                      )
//     ,.SIGI62(                      )
//     ,.SIGI63(                      )
//     ,.SIGI64(                      )
//     ,.SIGI65(                      )
//     ,.SIGI66(                      )
//     ,.SIGI67(                      )

     ,.SIGO01( cap_bbmode           )
     ,.SIGO02( cap_bbreqpclk        )
     ,.SIGO03( cap_bbckselr         )
     ,.SIGO04( cap_bbckselm         )
     ,.SIGO05( cap_bbhioon          )
     ,.SIGO06( cap_bbregctl         )
     ,.SIGO07( cap_bbprdata[15]     )
     ,.SIGO08( cap_bbprdata[14]     )
     ,.SIGO09( cap_bbprdata[13]     )
     ,.SIGO10( cap_bbprdata[12]     )
     ,.SIGO11( cap_bbprdata[11]     )
     ,.SIGO12( cap_bbprdata[10]     )
     ,.SIGO13( cap_bbprdata[9]      )
     ,.SIGO14( cap_bbprdata[8]      )
     ,.SIGO15( cap_bbprdata[7]      )
     ,.SIGO16( cap_bbprdata[6]      )
     ,.SIGO17( cap_bbprdata[5]      )
     ,.SIGO18( cap_bbprdata[4]      )
     ,.SIGO19( cap_bbprdata[3]      )
     ,.SIGO20( cap_bbprdata[2]      )
     ,.SIGO21( cap_bbprdata[1]      )
     ,.SIGO22( cap_bbprdata[0]      )
     ,.SIGO23( cap_waitmem          )
     ,.SIGO24( cap_wait2nd56        )
     ,.SIGO25(                      )
     ,.SIGO26(                      )
     ,.SIGO27(                      )
     ,.SIGO28(                      )
     ,.SIGO29(                      )
     ,.SIGO30(                      )
     ,.SIGO31(                      )
     ,.SIGO32(                      )
     ,.SIGO33(                      )
     ,.SIGO34(                      )
     ,.SIGO35(                      )
     ,.SIGO36(                      )
     ,.SIGO37(                      )
     ,.SIGO38(                      )
     ,.SIGO39(                      )
     ,.SIGO40(                      )
     ,.SIGO41(                      )
     ,.SIGO42(                      )
     ,.SIGO43(                      )
     ,.SIGO44(                      )
//     ,.SIGO45(                      )
//     ,.SIGO46(                      )
//     ,.SIGO47(                      )
//     ,.SIGO48(                      )
//     ,.SIGO49(                      )
//     ,.SIGO50(                      )
//     ,.SIGO51(                      )
//     ,.SIGO52(                      )
//     ,.SIGO53(                      )
//     ,.SIGO54(                      )
//     ,.SIGO55(                      )
//     ,.SIGO56(                      )
//     ,.SIGO57(                      )

  );

//  QICAP015H5H cap1 (
  QACAP04 cap1 (
      .ANAI01(                      )

     ,.CLKI01( clk_scan_o           )
     ,.CLKI02(                      )
     ,.CLKI03(                      )
     ,.CLKI04(                      )
     ,.CLKI05(                      )
     ,.CLKI06(                      )

     ,.CLKO01(                      )
     ,.CLKO02(                      )
     ,.CLKO03(                      )

     ,.SIGI01( cibc_bbnvm1_o        )
     ,.SIGI02( cibc_bbnvm2_o        )
     ,.SIGI03( ocd_svstop_o         )
     ,.SIGI04( ocd_svperi0_o        )
     ,.SIGI05( ocd_svperi1_o        )
     ,.SIGI06( mod_scanmode_o       )
     ,.SIGI07( mod_scanen_o         )
     ,.SIGI08( mod_scanin_o         )
     ,.SIGI09( mod_tesscan1_o       )
     ,.SIGI10( mod_bbtesinst_o      )
     ,.SIGI11( mod_optiddq_o        )
     ,.SIGI12( mod_optexcck_o       )
     ,.SIGI13( mod_tesdbt2_o        )
     ,.SIGI14( mod_tesdbt_o         )
     ,.SIGI15( pporga_cap_sel08p_o  )
     ,.SIGI16( bbr_bbselsfr1st_o    )
     ,.SIGI17( bbr_bbselsfr2nd_o    )
     ,.SIGI18(                      )
     ,.SIGI19(                      )
     ,.SIGI20(                      )
     ,.SIGI21( bbr_bbadr15_o        )
     ,.SIGI22( bbr_bbadr14_o        )
     ,.SIGI23( bbr_bbadr13_o        )
     ,.SIGI24( bbr_bbadr12_o        )
     ,.SIGI25( bbr_bbadr11_o        )
     ,.SIGI26( cpu_slmem_o          )
     ,.SIGI27( cpu_fchram_o         )
     ,.SIGI28( cpu_wdop_o           )
     ,.SIGI29( ramif_stn_n_o        )
     ,.SIGI30( ramif_mode0_o        )
     ,.SIGI31( ramif_mode1_o        )
     ,.SIGI32( iaw_gdramwr_o        )
     ,.SIGI33(                      )
     ,.SIGI34(                      )
     ,.SIGI35(                      )
     ,.SIGI36(                      )
     ,.SIGI37(                      )
     ,.SIGI38(                      )
     ,.SIGI39(                      )
     ,.SIGI40(                      )
     ,.SIGI41(                      )
     ,.SIGI42(                      )
     ,.SIGI43(                      )
     ,.SIGI44(                      )
     ,.SIGI45(                      )
     ,.SIGI46(                      )
     ,.SIGI47(                      )
     ,.SIGI48(                      )
     ,.SIGI49(                      )
     ,.SIGI50(                      )
     ,.SIGI51(                      )
//     ,.SIGI52(                      )
//     ,.SIGI53(                      )
//     ,.SIGI54(                      )
//     ,.SIGI55(                      )
//     ,.SIGI56(                      )
//     ,.SIGI57(                      )
//     ,.SIGI58(                      )
//     ,.SIGI59(                      )
//     ,.SIGI60(                      )
//     ,.SIGI61(                      )
//     ,.SIGI62(                      )
//     ,.SIGI63(                      )
//     ,.SIGI64(                      )
//     ,.SIGI65(                      )
//     ,.SIGI66(                      )
//     ,.SIGI67(                      )

     ,.SIGO01( cap_bbint0           )
     ,.SIGO02( cap_bbint1           )
     ,.SIGO03( cap_bbint2           )
     ,.SIGO04( cap_bbint3           )
     ,.SIGO05( cap_bbint4           )
     ,.SIGO06( cap_bbint5           )
     ,.SIGO07( cap_bbint6           )
     ,.SIGO08( cap_bbint7           )
     ,.SIGO09( cap_bbint8           )
     ,.SIGO10( cap_bbint9           )
     ,.SIGO11( cap_bbint10          )
     ,.SIGO12( cap_bbint11          )
     ,.SIGO13( cap_bbint12          )
     ,.SIGO14( cap_bbint13          )
     ,.SIGO15( cap_bbint14          )
     ,.SIGO16( cap_bbint15          )
     ,.SIGO17( cap_bbint16          )
     ,.SIGO18( cap_bbint17          )
     ,.SIGO19( cap_bbint18          )
     ,.SIGO20( cap_bbint19          )
     ,.SIGO21( cap_bbint20          )
     ,.SIGO22( cap_bbint21          )
     ,.SIGO23( cap_bbscanout        )
     ,.SIGO24( cap_adtrig0          )
     ,.SIGO25( cap_adtrig1          )
     ,.SIGO26( cap_intrtcdis        )
     ,.SIGO27( cap_frq4en           )
     ,.SIGO28( cap_bbrperr          )
     ,.SIGO29(                      )
     ,.SIGO30(                      )
     ,.SIGO31(                      )
     ,.SIGO32(                      )
     ,.SIGO33(                      )
     ,.SIGO34(                      )
     ,.SIGO35(                      )
     ,.SIGO36(                      )
     ,.SIGO37(                      )
     ,.SIGO38(                      )
     ,.SIGO39(                      )
     ,.SIGO40(                      )
     ,.SIGO41(                      )
     ,.SIGO42(                      )
     ,.SIGO43(                      )
     ,.SIGO44(                      )
//     ,.SIGO45(                      )
//     ,.SIGO46(                      )
//     ,.SIGO47(                      )
//     ,.SIGO48(                      )
//     ,.SIGO49(                      )
//     ,.SIGO50(                      )
//     ,.SIGO51(                      )
//     ,.SIGO52(                      )
//     ,.SIGO53(                      )
//     ,.SIGO54(                      )
//     ,.SIGO55(                      )
//     ,.SIGO56(                      )
//     ,.SIGO57(                      )

  );


//*************
// for cap0
//*************

  // for CLKs
  bufclk_cell_pf rep_clki_0_01 ( .a( clk_bboscoutm ) ,.y( clk_bboscoutm_o ) );
  bufclk_cell_pf rep_clki_0_02 ( .a( clk_bbr32mout ) ,.y( clk_bbr32mout_o ) );
  bufclk_cell_pf rep_clki_0_03 ( .a( clk_bbfmain   ) ,.y( clk_bbfmain_o   ) );
  bufclk_cell_pf rep_clki_0_04 ( .a( clk_bbfsub    ) ,.y( clk_bbfsub_o    ) );
  bufclk_cell_pf rep_clki_0_05 ( .a( clk_bbfclkrt  ) ,.y( clk_bbfclkrt_o  ) );
  bufclk_cell_pf rep_clki_0_06 ( .a( clk_bbr15kout ) ,.y( clk_bbr15kout_o ) );


  // for SIGNALs
  bufx2_cell_pf  rep_sigi_0_01 ( .a( rst_sysres_n  ) ,.y( rst_sysres_n_o  ) );
  bufx2_cell_pf  rep_sigi_0_02 ( .a( rst_reset_n   ) ,.y( rst_reset_n_o   ) );
  bufx2_cell_pf  rep_sigi_0_03 ( .a( rst_res_n     ) ,.y( rst_res_n_o     ) );
  bufx2_cell_pf  rep_sigi_0_04 ( .a( csc_stpbckbt  ) ,.y( csc_stpbckbt_o  ) );
  bufx2_cell_pf  rep_sigi_0_05 ( .a( csc_rsts      ) ,.y( csc_rsts_o      ) );
  bufx2_cell_pf  rep_sigi_0_06 ( .a( csc_resstp    ) ,.y( csc_resstp_o    ) );
  bufx2_cell_pf  rep_sigi_0_07 ( .a( csc_bckhsen   ) ,.y( csc_bckhsen_o   ) );
  bufx2_cell_pf  rep_sigi_0_08 ( .a( csc_fmxst     ) ,.y( csc_fmxst_o     ) );
  bufx2_cell_pf  rep_sigi_0_09 ( .a( csc_subckst   ) ,.y( csc_subckst_o   ) );
  bufx2_cell_pf  rep_sigi_0_10 ( .a( csc_bbckstr   ) ,.y( csc_bbckstr_o   ) );
  bufx2_cell_pf  rep_sigi_0_11 ( .a( csc_bbckstm   ) ,.y( csc_bbckstm_o   ) );
  bufx2_cell_pf  rep_sigi_0_12 ( .a( bbr_bbpwrite  ) ,.y( bbr_bbpwrite_o  ) );
  bufx2_cell_pf  rep_sigi_0_13 ( .a( bbr_bbpenable ) ,.y( bbr_bbpenable_o ) );
  bufx2_cell_pf  rep_sigi_0_14 ( .a( bbr_bbadr[10] ) ,.y( bbr_bbadr10_o   ) );
  bufx2_cell_pf  rep_sigi_0_15 ( .a( bbr_bbadr[9]  ) ,.y( bbr_bbadr9_o    ) );
  bufx2_cell_pf  rep_sigi_0_16 ( .a( bbr_bbadr[8]  ) ,.y( bbr_bbadr8_o    ) );
  bufx2_cell_pf  rep_sigi_0_17 ( .a( bbr_bbadr[7]  ) ,.y( bbr_bbadr7_o    ) );
  bufx2_cell_pf  rep_sigi_0_18 ( .a( bbr_bbadr[6]  ) ,.y( bbr_bbadr6_o    ) );
  bufx2_cell_pf  rep_sigi_0_19 ( .a( bbr_bbadr[5]  ) ,.y( bbr_bbadr5_o    ) );
  bufx2_cell_pf  rep_sigi_0_20 ( .a( bbr_bbadr[4]  ) ,.y( bbr_bbadr4_o    ) );
  bufx2_cell_pf  rep_sigi_0_21 ( .a( bbr_bbadr[3]  ) ,.y( bbr_bbadr3_o    ) );
  bufx2_cell_pf  rep_sigi_0_22 ( .a( bbr_bbadr[2]  ) ,.y( bbr_bbadr2_o    ) );
  bufx2_cell_pf  rep_sigi_0_23 ( .a( bbr_bbadr[1]  ) ,.y( bbr_bbadr1_o    ) );
  bufx2_cell_pf  rep_sigi_0_24 ( .a( bbr_bbadr[0]  ) ,.y( bbr_bbadr0_o    ) );
  bufx2_cell_pf  rep_sigi_0_25 ( .a( bbr_bbmdw[15] ) ,.y( bbr_bbmdw15_o   ) );
  bufx2_cell_pf  rep_sigi_0_26 ( .a( bbr_bbmdw[14] ) ,.y( bbr_bbmdw14_o   ) );
  bufx2_cell_pf  rep_sigi_0_27 ( .a( bbr_bbmdw[13] ) ,.y( bbr_bbmdw13_o   ) );
  bufx2_cell_pf  rep_sigi_0_28 ( .a( bbr_bbmdw[12] ) ,.y( bbr_bbmdw12_o   ) );
  bufx2_cell_pf  rep_sigi_0_29 ( .a( bbr_bbmdw[11] ) ,.y( bbr_bbmdw11_o   ) );
  bufx2_cell_pf  rep_sigi_0_30 ( .a( bbr_bbmdw[10] ) ,.y( bbr_bbmdw10_o   ) );
  bufx2_cell_pf  rep_sigi_0_31 ( .a( bbr_bbmdw[9]  ) ,.y( bbr_bbmdw9_o    ) );
  bufx2_cell_pf  rep_sigi_0_32 ( .a( bbr_bbmdw[8]  ) ,.y( bbr_bbmdw8_o    ) );
  bufx2_cell_pf  rep_sigi_0_33 ( .a( bbr_bbmdw[7]  ) ,.y( bbr_bbmdw7_o    ) );
  bufx2_cell_pf  rep_sigi_0_34 ( .a( bbr_bbmdw[6]  ) ,.y( bbr_bbmdw6_o    ) );
  bufx2_cell_pf  rep_sigi_0_35 ( .a( bbr_bbmdw[5]  ) ,.y( bbr_bbmdw5_o    ) );
  bufx2_cell_pf  rep_sigi_0_36 ( .a( bbr_bbmdw[4]  ) ,.y( bbr_bbmdw4_o    ) );
  bufx2_cell_pf  rep_sigi_0_37 ( .a( bbr_bbmdw[3]  ) ,.y( bbr_bbmdw3_o    ) );
  bufx2_cell_pf  rep_sigi_0_38 ( .a( bbr_bbmdw[2]  ) ,.y( bbr_bbmdw2_o    ) );
  bufx2_cell_pf  rep_sigi_0_39 ( .a( bbr_bbmdw[1]  ) ,.y( bbr_bbmdw1_o    ) );
  bufx2_cell_pf  rep_sigi_0_40 ( .a( bbr_bbmdw[0]  ) ,.y( bbr_bbmdw0_o    ) );


//*************
// for cap1
//*************

  // for CLKs
  bufclk_cell_pf rep_clki_1_01 ( .a( clk_scan ) ,.y( clk_scan_o ) );

  // for SIGNALs
  bufx2_cell_pf  rep_sigi_1_01 ( .a( cibc_bbnvm1       ) ,.y( cibc_bbnvm1_o       ) );
  bufx2_cell_pf  rep_sigi_1_02 ( .a( cibc_bbnvm2       ) ,.y( cibc_bbnvm2_o       ) );
  bufx2_cell_pf  rep_sigi_1_03 ( .a( ocd_svstop        ) ,.y( ocd_svstop_o        ) );
  bufx2_cell_pf  rep_sigi_1_04 ( .a( ocd_svperi0       ) ,.y( ocd_svperi0_o       ) );
  bufx2_cell_pf  rep_sigi_1_05 ( .a( ocd_svperi1       ) ,.y( ocd_svperi1_o       ) );
  bufx2_cell_pf  rep_sigi_1_06 ( .a( mod_scanmode      ) ,.y( mod_scanmode_o      ) );
  bufx2_cell_pf  rep_sigi_1_07 ( .a( mod_scanen        ) ,.y( mod_scanen_o        ) );
  bufx2_cell_pf  rep_sigi_1_08 ( .a( mod_scanin        ) ,.y( mod_scanin_o        ) );
  bufx2_cell_pf  rep_sigi_1_09 ( .a( mod_tesscan1      ) ,.y( mod_tesscan1_o      ) );
  bufx2_cell_pf  rep_sigi_1_10 ( .a( mod_bbtesinst     ) ,.y( mod_bbtesinst_o     ) );
  bufx2_cell_pf  rep_sigi_1_11 ( .a( mod_optiddq       ) ,.y( mod_optiddq_o       ) );
  bufx2_cell_pf  rep_sigi_1_12 ( .a( mod_optexcck      ) ,.y( mod_optexcck_o      ) );
  bufx2_cell_pf  rep_sigi_1_13 ( .a( mod_tesdbt2       ) ,.y( mod_tesdbt2_o       ) );
  bufx2_cell_pf  rep_sigi_1_14 ( .a( mod_tesdbt        ) ,.y( mod_tesdbt_o        ) );
  bufx2_cell_pf  rep_sigi_1_15 ( .a( pporga_cap_sel08p ) ,.y( pporga_cap_sel08p_o ) );
  bufx2_cell_pf  rep_sigi_1_16 ( .a( bbr_bbselsfr1st   ) ,.y( bbr_bbselsfr1st_o   ) );
  bufx2_cell_pf  rep_sigi_1_17 ( .a( bbr_bbselsfr2nd   ) ,.y( bbr_bbselsfr2nd_o   ) );
  bufx2_cell_pf  rep_sigi_1_21 ( .a( bbr_bbadr[15]     ) ,.y( bbr_bbadr15_o       ) );
  bufx2_cell_pf  rep_sigi_1_22 ( .a( bbr_bbadr[14]     ) ,.y( bbr_bbadr14_o       ) );
  bufx2_cell_pf  rep_sigi_1_23 ( .a( bbr_bbadr[13]     ) ,.y( bbr_bbadr13_o       ) );
  bufx2_cell_pf  rep_sigi_1_24 ( .a( bbr_bbadr[12]     ) ,.y( bbr_bbadr12_o       ) );
  bufx2_cell_pf  rep_sigi_1_25 ( .a( bbr_bbadr[11]     ) ,.y( bbr_bbadr11_o       ) );
  bufx2_cell_pf  rep_sigi_1_26 ( .a( cpu_slmem         ) ,.y( cpu_slmem_o         ) );
  bufx2_cell_pf  rep_sigi_1_27 ( .a( cpu_fchram        ) ,.y( cpu_fchram_o        ) );
  bufx2_cell_pf  rep_sigi_1_28 ( .a( cpu_wdop          ) ,.y( cpu_wdop_o          ) );
  bufx2_cell_pf  rep_sigi_1_29 ( .a( ramif_stn_n       ) ,.y( ramif_stn_n_o       ) );
  bufx2_cell_pf  rep_sigi_1_30 ( .a( ramif_mode[0]     ) ,.y( ramif_mode0_o       ) );
  bufx2_cell_pf  rep_sigi_1_31 ( .a( ramif_mode[1]     ) ,.y( ramif_mode1_o       ) );
  bufx2_cell_pf  rep_sigi_1_32 ( .a( iaw_gdramwr       ) ,.y( iaw_gdramwr_o       ) );


endmodule

