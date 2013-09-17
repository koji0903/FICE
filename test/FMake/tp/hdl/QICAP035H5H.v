/********************************/
/*     Ver1.00  QICAP035H5H       */
/*     Sep.7.2010               */
/********************************/
`timescale 1ps/1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module QICAP035H5H ( ADINLBB5V ) ;
inout ADINLBB5V ;

   supply0 GNDADR ;
   supply0 GNDAD ;

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
