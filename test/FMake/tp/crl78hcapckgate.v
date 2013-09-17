// *****************************************************************************
//  (C) COPYRIGHT 2011 RENESAS ELECTRONICS CORPORATION, ALL RIGHTS RESERVED
// *****************************************************************************
//   Module Name:         crl78hcapckgate
// *****************************************************************************


 module crl78hcapckgate (
       capmx_bbmode
      ,mod_scanmode
      ,clk_oscoutm
      ,clk_r32mout
      ,clk_fmain
      ,clk_fsub
      ,clk_fclkrt
      ,clk_r15kout

      ,clk_bboscoutm
      ,clk_bbr32mout
      ,clk_bbfmain
      ,clk_bbfsub
      ,clk_bbfclkrt
      ,clk_bbr15kout
  );


    input          capmx_bbmode;
    input          mod_scanmode;
    input          clk_oscoutm;
    input          clk_r32mout;
    input          clk_fmain;
    input          clk_fsub;
    input          clk_fclkrt;
    input          clk_r15kout;

    output         clk_bboscoutm;
    output         clk_bbr32mout;
    output         clk_bbfmain;
    output         clk_bbfsub;
    output         clk_bbfclkrt;
    output         clk_bbr15kout;

    wire           bb_scan;


  orx2_cell_pf  gate_bb_scan ( .a( mod_scanmode ) ,.b ( capmx_bbmode ) ,.y( bb_scan       ) );

  andx2_cell_pf gate_fclk    ( .a( clk_fclkrt   ) ,.b ( bb_scan      ) ,.y( clk_bbfclkrt  ) );

  andx2_cell_pf gate_fmain   ( .a( clk_fmain    ) ,.b ( capmx_bbmode ) ,.y( clk_bbfmain   ) );
  andx2_cell_pf gate_fsub    ( .a( clk_fsub     ) ,.b ( capmx_bbmode ) ,.y( clk_bbfsub    ) );

  andx2_cell_pf gate_mosc    ( .a( clk_oscoutm  ) ,.b ( capmx_bbmode ) ,.y( clk_bboscoutm ) );
  andx2_cell_pf gate_hiosc   ( .a( clk_r32mout  ) ,.b ( capmx_bbmode ) ,.y( clk_bbr32mout ) );
  andx2_cell_pf gate_liosc   ( .a( clk_r15kout  ) ,.b ( capmx_bbmode ) ,.y( clk_bbr15kout ) );


endmodule

