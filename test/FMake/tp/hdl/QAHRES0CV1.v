/********************************/
/*     Ver1.00   QAHRES0CV1     */
/*     Sep.15.2010              */
/********************************/
`timescale 1ps/1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module  QAHRES0CV1 ( VPPTSIN, VPPTSOUT );

    inout  VPPTSIN ;
    inout  VPPTSOUT ;

    tran ( VPPTSOUT , VPPTSIN ) ;

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine

/**  HISTORY  *******************************/
/*                                          */
/*  V1.00   1st release                     */
/*                                          */
/********************************************/
