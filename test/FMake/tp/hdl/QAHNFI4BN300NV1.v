// VERSION:1.1 DATE:2010/02/24 OPENCAD Verilog Library
// 
// for cmos1_2.1V
// 
// Ver.0.1: 2010/02/05 : New Release (copy from MF2 tbdly50n_mf2.specify_040213_1)
// Ver.1.0: 2010/02/09 : modify submodule name (QAHNFI4BN300NV1_D50NS->QAHNFI4BN300NV1_D300NS)
// Ver.1.1: 2010/02/24 : correct internal delay
//

`celldefine
`timescale 1ps/1ps
`default_nettype wire

module QAHNFI4BN300NV1 ( NFOUT , NFIN );
 
    input   NFIN ;
 
    output  NFOUT ;

    not       INV_1  ( DELAY_IN , NFIN );

    QAHNFI4BN300NV1_D300NS     DELAY1 ( .O01(DELAY_OUT) , .I01(DELAY_IN) );

    and       AND_NOR1_01 ( and1_out , DELAY_OUT , DELAY_IN  );
    nor       AND_NOR1_02 ( FF1_OUTB , FF1_OUT   , and1_out  );

    nor       NOR1_01 ( A , DELAY_IN  , DELAY_OUT );

    nor       NOR_2 ( FF1_OUT , FF1_OUTB , A );

    not       INV_2 ( NFOUT , FF1_OUT );

`ifdef  FAST_FUNC
`else
    specify

	specparam DMY_SPC = 1:1:1;

	( NFIN => NFOUT ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule

module QAHNFI4BN300NV1_D300NS ( O01 , I01 );

   input  I01 ;

   output O01 ;

   buf ( O01 , I01 );

  specify
    ( I01 => O01 ) = ( 213000:334000:618000,
                       187000:306000:640000 );
  endspecify 

endmodule

`endcelldefine
