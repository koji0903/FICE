`define FAST_FUNC

// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD2X1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    and ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else   
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD2X2 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    and ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else   
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD2X3 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    and ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else   
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD2X4 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    and ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else   
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD2X6 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    and ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else   
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD2X8 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    and ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else   
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD2Y0 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    and ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else   
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD2Y1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    and ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else   
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD3X1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    and ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD3X2 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    and ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD3X3 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    and ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD3X4 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    and ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD4X1 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( N01, _H01, _H02, _H03, _H04 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAD4X2 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( N01, _H01, _H02, _H03, _H04 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBADFAX1 ( N01 , N02 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;
 output N02 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  xor  	 ( C2 , _H01 , _H02 ) ;
  xor  	 ( N01 , C2 , _H03 ) ;
  and  	 ( C4 , _H01 , _H02 ) ;
  and  	 ( C5 , _H01 , _H03 ) ;
  and  	 ( C6 , _H02 , _H03 ) ;
  or  	 ( N02 , C4 , C5 , C6 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

  ( H01 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H02 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H03 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBADFAX2 ( N01 , N02 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;
 output N02 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  xor  	 ( C2 , _H01 , _H02 ) ;
  xor  	 ( N01 , C2 , _H03 ) ;
  and  	 ( C4 , _H01 , _H02 ) ;
  and  	 ( C5 , _H01 , _H03 ) ;
  and  	 ( C6 , _H02 , _H03 ) ;
  or  	 ( N02 , C4 , C5 , C6 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

  ( H01 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H02 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H03 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBADFAY0 ( N01 , N02 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;
 output N02 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  xor  	 ( C2 , _H01 , _H02 ) ;
  xor  	 ( N01 , C2 , _H03 ) ;
  and  	 ( C4 , _H01 , _H02 ) ;
  and  	 ( C5 , _H01 , _H03 ) ;
  and  	 ( C6 , _H02 , _H03 ) ;
  or  	 ( N02 , C4 , C5 , C6 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

  ( H01 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H02 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H03 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBADFAY1 ( N01 , N02 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;
 output N02 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  xor  	 ( C2 , _H01 , _H02 ) ;
  xor  	 ( N01 , C2 , _H03 ) ;
  and  	 ( C4 , _H01 , _H02 ) ;
  and  	 ( C5 , _H01 , _H03 ) ;
  and  	 ( C6 , _H02 , _H03 ) ;
  or  	 ( N02 , C4 , C5 , C6 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

  ( H01 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H02 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H03 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBADHAX1 ( N01 , N02 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;
 output N02 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  xor  	 ( N01 , _H01 , _H02 ) ;
  and  	 ( N02 , _H01 , _H02 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

  ( H01 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H02 =>  N02 ) = ( DMY_SPC,
                      DMY_SPC );
      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN112X1 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( _G001, _H03, _H04 );
    nor ( N01, _H01, _H02, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Tue Nov  7 20:29:49 1995

module TBAN122X0 ( N01 , H01 , H02 , H03 , H04 , H05 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 input H05 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  buf  	 ( _H05 , H05 ) ;
  and  	 ( C3 , _H02 , _H03 ) ;
  and  	 ( C4 , _H04 , _H05 ) ;
  or  	 ( C2 , _H01 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H05 to N01
  ( H05 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Tue Nov  7 20:29:49 1995

module TBAN122X1 ( N01 , H01 , H02 , H03 , H04 , H05 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 input H05 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  buf  	 ( _H05 , H05 ) ;
  and  	 ( C3 , _H02 , _H03 ) ;
  and  	 ( C4 , _H04 , _H05 ) ;
  or  	 ( C2 , _H01 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H05 to N01
  ( H05 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Tue Nov  7 20:29:49 1995

module TBAN122Y0 ( N01 , H01 , H02 , H03 , H04 , H05 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 input H05 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  buf  	 ( _H05 , H05 ) ;
  and  	 ( C3 , _H02 , _H03 ) ;
  and  	 ( C4 , _H04 , _H05 ) ;
  or  	 ( C2 , _H01 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H05 to N01
  ( H05 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:12:24 1995

module TBAN12BBX1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C4 , _H02 ) ;
  not  	 ( C5 , _H03 ) ;
  and  	 ( C3 , C4 , C5 ) ;
  or  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:12:24 1995

module TBAN12BBX2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C4 , _H02 ) ;
  not  	 ( C5 , _H03 ) ;
  and  	 ( C3 , C4 , C5 ) ;
  or  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:12:15 1995

module TBAN12BX1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C4 , _H02 ) ;
  and  	 ( C3 , C4 , _H03 ) ;
  or  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:12:15 1995

module TBAN12BX2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C4 , _H02 ) ;
  and  	 ( C3 , C4 , _H03 ) ;
  or  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN12X0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    and ( _G001, _H02, _H03 );
    nor ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN12X1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    and ( _G001, _H02, _H03 );
    nor ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN12X2 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    and ( _G001, _H02, _H03 );
    nor ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN12X3 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    and ( _G001, _H02, _H03 );
    nor ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN12X4 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    and ( _G001, _H02, _H03 );
    nor ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN12Y0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    and ( _G001, _H02, _H03 );
    nor ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN13X0 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( _G001, _H02, _H03, _H04 );
    nor ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN13X1 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( _G001, _H02, _H03, _H04 );
    nor ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN13X2 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( _G001, _H02, _H03, _H04 );
    nor ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN13Y0 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( _G001, _H02, _H03, _H04 );
    nor ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:11:52 1995

module TBAN1B2BX1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  and  	 ( C4 , C5 , _H03 ) ;
  or  	 ( C2 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:11:44 1995

module TBAN1B2X1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H01 ) ;
  and  	 ( C4 , _H02 , _H03 ) ;
  or  	 ( C2 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif 
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:11:44 1995

module TBAN1B2X2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H01 ) ;
  and  	 ( C4 , _H02 , _H03 ) ;
  or  	 ( C2 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif 
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN222X0 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );
    buf ( _H06, H06 );
    and ( _G001, _H01, _H02 );
    and ( _G002, _H03, _H04 );
    and ( _G003, _H05, _H06 );
    nor ( N01, _G001, _G002, _G003 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H05 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H06 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN222X1 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );
    buf ( _H06, H06 );
    and ( _G001, _H01, _H02 );
    and ( _G002, _H03, _H04 );
    and ( _G003, _H05, _H06 );
    nor ( N01, _G001, _G002, _G003 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H05 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H06 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN222X2 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );
    buf ( _H06, H06 );
    and ( _G001, _H01, _H02 );
    and ( _G002, _H03, _H04 );
    and ( _G003, _H05, _H06 );
    nor ( N01, _G001, _G002, _G003 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H05 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H06 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN222Y0 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );
    buf ( _H06, H06 );
    and ( _G001, _H01, _H02 );
    and ( _G002, _H03, _H04 );
    and ( _G003, _H05, _H06 );
    nor ( N01, _G001, _G002, _G003 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H05 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H06 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN222Y1 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );
    buf ( _H06, H06 );
    and ( _G001, _H01, _H02 );
    and ( _G002, _H03, _H04 );
    and ( _G003, _H05, _H06 );
    nor ( N01, _G001, _G002, _G003 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H05 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H06 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN22X0 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( _G001, _H01, _H02 );
    and ( _G002, _H03, _H04 );
    nor ( N01, _G001, _G002 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN22X1 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( _G001, _H01, _H02 );
    and ( _G002, _H03, _H04 );
    nor ( N01, _G001, _G002 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN22X2 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( _G001, _H01, _H02 );
    and ( _G002, _H03, _H04 );
    nor ( N01, _G001, _G002 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN22X4 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( _G001, _H01, _H02 );
    and ( _G002, _H03, _H04 );
    nor ( N01, _G001, _G002 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN22Y0 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( _G001, _H01, _H02 );
    and ( _G002, _H03, _H04 );
    nor ( N01, _G001, _G002 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBAN22Y1 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    and ( _G001, _H01, _H02 );
    and ( _G002, _H03, _H04 );
    nor ( N01, _G001, _G002 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:14:40 1995

module TBAN2B2BX1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  and  	 ( C3 , C4 , _H02 ) ;
  not  	 ( C6 , _H03 ) ;
  and  	 ( C5 , C6 , _H04 ) ;
  or  	 ( C2 , C3 , C5 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:14:40 1995

module TBAN2B2BX2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  and  	 ( C3 , C4 , _H02 ) ;
  not  	 ( C6 , _H03 ) ;
  and  	 ( C5 , C6 , _H04 ) ;
  or  	 ( C2 , C3 , C5 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:14:17 1995

module TBAN2B2X1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  and  	 ( C3 , C4 , _H02 ) ;
  and  	 ( C5 , _H03 , _H04 ) ;
  or  	 ( C2 , C3 , C5 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:14:17 1995

module TBAN2B2X2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  and  	 ( C3 , C4 , _H02 ) ;
  and  	 ( C5 , _H03 , _H04 ) ;
  or  	 ( C2 , C3 , C5 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:14:17 1995

module TBAN2B2X4 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  and  	 ( C3 , C4 , _H02 ) ;
  and  	 ( C5 , _H03 , _H04 ) ;
  or  	 ( C2 , C3 , C5 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:14:24 1995

module TBAN2BB2X1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  and  	 ( C3 , C4 , C5 ) ;
  and  	 ( C6 , _H03 , _H04 ) ;
  or  	 ( C2 , C3 , C6 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif 
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:14:24 1995

module TBAN2BB2X2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  and  	 ( C3 , C4 , C5 ) ;
  and  	 ( C6 , _H03 , _H04 ) ;
  or  	 ( C2 , C3 , C6 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif 
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:15:35 1995

module TBAO12X1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  not  	 ( C6 , _H03 ) ;
  or  	 ( C4 , C5 , C6 ) ;
  and  	 ( C2 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:15:35 1995

module TBAO12X2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  not  	 ( C6 , _H03 ) ;
  or  	 ( C4 , C5 , C6 ) ;
  and  	 ( C2 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:18:09 1995

module TBAO22X1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  or  	 ( C3 , C4 , C5 ) ;
  not  	 ( C7 , _H03 ) ;
  not  	 ( C8 , _H04 ) ;
  or  	 ( C6 , C7 , C8 ) ;
  and  	 ( C2 , C3 , C6 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:18:09 1995

module TBAO22X2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  or  	 ( C3 , C4 , C5 ) ;
  not  	 ( C7 , _H03 ) ;
  not  	 ( C8 , _H04 ) ;
  or  	 ( C6 , C7 , C8 ) ;
  and  	 ( C2 , C3 , C6 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:18:09 1995

module TBAO22Y0 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  or  	 ( C3 , C4 , C5 ) ;
  not  	 ( C7 , _H03 ) ;
  not  	 ( C8 , _H04 ) ;
  or  	 ( C6 , C7 , C8 ) ;
  and  	 ( C2 , C3 , C6 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:18:09 1995

module TBAO22Y1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  or  	 ( C3 , C4 , C5 ) ;
  not  	 ( C7 , _H03 ) ;
  not  	 ( C8 , _H04 ) ;
  or  	 ( C6 , C7 , C8 ) ;
  and  	 ( C2 , C3 , C6 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBAX12X1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  and  	 ( C2 , _H02 , _H03 ) ;
  xor  	 ( N01 , _H01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFCLX4 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFCLX6 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFCLX8 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFX1 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFX10 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFX12 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFX16 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFX2 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFX3 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFX4 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFX6 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFX8 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFY0 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBBUFY1 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBCLH ( N01 ) ;
 output N01 ;

  buf    ( N01 , 1'b1 ) ;
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBCLL ( N01 ) ;
 output N01 ;

  buf    ( N01 , 1'b0 ) ;
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBCTS ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBCTSRS ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    buf ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBDFHQRBX1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, _H03, 1'b1, notifier );
    wire chk_cond1 =  ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$width (posedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBDFHQRBX2 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, _H03, 1'b1, notifier );
    wire chk_cond1 =  ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$width (posedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBDFHQRBX4 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, _H03, 1'b1, notifier );
    wire chk_cond1 =  ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$width (posedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBDFHQRBY0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, _H03, 1'b1, notifier );
    wire chk_cond1 =  ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$width (posedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBDFHQSBX1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, 1'b1, _H03, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, 1'b1, _H03, notifier );
    wire chk_cond1 =  ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$width (posedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( DMY_SPC, 0:0:0 );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBDFHQSBX4 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, 1'b1, _H03, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    DESFQ2 DESFQ2_inst ( N01, _H01, _H02, 1'b1, _H03, notifier );
    wire chk_cond1 =  ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$width (posedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( DMY_SPC, 0:0:0 );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBDFLQRBX1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    not ( _CLK, _H02 );
    DESFQ2 DESFQ2_inst ( N01, _H01, _CLK, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    not ( _CLK, _H02 );
    DESFQ2 DESFQ2_inst ( N01, _H01, _CLK, _H03, 1'b1, notifier );
    wire chk_cond1 =  ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$recrem (posedge H03, negedge H02 , DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$width (negedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (posedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBDFLQRBX4 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    not ( _CLK, _H02 );
    DESFQ2 DESFQ2_inst ( N01, _H01, _CLK, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    not ( _CLK, _H02 );
    DESFQ2 DESFQ2_inst ( N01, _H01, _CLK, _H03, 1'b1, notifier );
    wire chk_cond1 =  ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$recrem (posedge H03, negedge H02 , DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$width (negedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (posedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBDFLQSBX1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    not ( delayed_CLK, _H02 );
    DESFQ2 DESFQ2_inst ( N01, _H01, delayed_CLK, 1'b1, _H03, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    not ( delayed_CLK, _H02 );
    DESFQ2 DESFQ2_inst ( N01, _H01, delayed_CLK, 1'b1, _H03, notifier );
`endif

`ifdef FAST_FUNC
`else
    wire chk_cond1 =  ( _H03 !== 1'b0 );

    specify
        specparam DMY_SPC=1:1:1;

$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$recrem (posedge H03, negedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$width (negedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (posedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( DMY_SPC, 0:0:0 );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBDLY1X2 ( N01, H01 );
    input H01;
    output N01;

`ifdef FAST_FUNC
    `ifdef DLY_D_1
        parameter DelaySpec = 1;
    `else
        parameter DelaySpec = 0;
    `endif

    buf ( _H01, H01 );
    buf #DelaySpec ( N01, _H01 );

`else
    buf ( _H01, H01 );
    buf ( N01, _H01 );

    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBDLY2X2 ( N01, H01 );
    input H01;
    output N01;

`ifdef FAST_FUNC
    `ifdef DLY_D_1
        parameter DelaySpec = 1;
    `else
        parameter DelaySpec = 0;
    `endif

    buf ( _H01, H01 );
    buf #DelaySpec ( N01, _H01 );

`else
    buf ( _H01, H01 );
    buf ( N01, _H01 );

    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBDLY3X2 ( N01, H01 );
    input H01;
    output N01;

`ifdef FAST_FUNC
    `ifdef DLY_D_1
        parameter DelaySpec = 1;
    `else
        parameter DelaySpec = 0;
    `endif

    buf ( _H01, H01 );
    buf #DelaySpec ( N01, _H01 );

`else
    buf ( _H01, H01 );
    buf ( N01, _H01 );

    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/11/10
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBGTSMLALADCLX1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
    wire chk_cond1 = ( _H03!==1'b1 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02, posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$width ( negedge H02, DMY_SPC, 0, notifier );

        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/11/10
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBGTSMLALADCLX2 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
    wire chk_cond1 = ( _H03!==1'b1 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02, posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$width ( negedge H02, DMY_SPC, 0, notifier );

        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/11/10
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBGTSMLALADCLX4 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
    wire chk_cond1 = ( _H03!==1'b1 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02, posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$width ( negedge H02, DMY_SPC, 0, notifier );

        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/11/10
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBGTSMLALADCLX8 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
    wire chk_cond1 = ( _H03!==1'b1 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02, posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$width ( negedge H02, DMY_SPC, 0, notifier );

        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/11/10
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBGTSMLALADCLY0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
    wire chk_cond1 = ( _H03!==1'b1 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02, posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$width ( negedge H02, DMY_SPC, 0, notifier );

        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBGTSMLALADPCLX1 ( N01, N02, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    output N02;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    buf ( N02, _H01 );
    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    buf ( N02, _H01 );
    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
    wire chk_cond1 = ( _H03!==1'b1 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02, posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$width (negedge H02, DMY_SPC, 0, notifier);

        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H01 => N02 ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBGTSMLALADPCLX2 ( N01, N02, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    output N02;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    buf ( N02, _H01 );
    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    buf ( N02, _H01 );
    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
    wire chk_cond1 = ( _H03!==1'b1 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02, posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$width (negedge H02, DMY_SPC, 0, notifier);

        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H01 => N02 ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBGTSMLALADPCLX4 ( N01, N02, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    output N02;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    buf ( N02, _H01 );
    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    buf ( N02, _H01 );
    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
    wire chk_cond1 = ( _H03!==1'b1 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02, posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$width (negedge H02, DMY_SPC, 0, notifier);

        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H01 => N02 ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBGTSMLALADPCLX8 ( N01, N02, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    output N02;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    buf ( N02, _H01 );
    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    buf ( N02, _H01 );
    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
    wire chk_cond1 = ( _H03!==1'b1 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02, posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$width (negedge H02, DMY_SPC, 0, notifier);

        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H01 => N02 ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBGTSMLALADPCLY0 ( N01, N02, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    output N02;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    buf ( N02, _H01 );
    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    buf ( N02, _H01 );
    or ( G001, _H03, _H01 );
    not ( _H02B, _H02 );
    DLSFQ2 DLSFQ2_inst ( G002, G001, _H02B, 1'b1, 1'b1, notifier );
    and ( N01, G002, _H02 );
    wire chk_cond1 = ( _H03!==1'b1 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02, posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$width (negedge H02, DMY_SPC, 0, notifier);

        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H01 => N02 ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBINVX1 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    not ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBINVX10 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    not ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBINVX12 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    not ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBINVX16 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    not ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBINVX2 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    not ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBINVX3 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    not ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBINVX4 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    not ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBINVX6 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    not ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBINVX8 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    not ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBINVY0 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    not ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBINVY1 ( N01, H01 );
    input H01;
    output N01;

    buf ( _H01, H01 );
    not ( N01, _H01 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBLAHQRBX1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );

    DLSFQ2 DLSFQ2_inst ( N01, _H01, _H02, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );

    DLSFQ2 DLSFQ2_inst ( N01, _H01, _H02, _H03, 1'b1, notifier );
    wire chk_cond1 =  ( _H03 !== 1'b0 );
`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$recrem (posedge H03, negedge H02 , DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$width ( posedge H02 &&& (chk_cond1 == 1'b1), DMY_SPC, 0, notifier );
$width ( negedge H03 , DMY_SPC, 0, notifier );

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBLAHQX1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );

    DLSFQ2 DLSFQ2_inst ( N01, _H01, _H02, 1'b1, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );

    DLSFQ2 DLSFQ2_inst ( N01, _H01, _H02, 1'b1, 1'b1, notifier );
`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (negedge H02, posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02, negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$width ( posedge H02, DMY_SPC, 0, notifier );

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMAJ3X1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  and  	 ( C2 , _H01 , _H02 ) ;
  and  	 ( C3 , _H02 , _H03 ) ;
  and  	 ( C4 , _H03 , _H01 ) ;
  or  	 ( N01 , C2 , C3 , C4 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMAJ3X2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  and  	 ( C2 , _H01 , _H02 ) ;
  and  	 ( C3 , _H02 , _H03 ) ;
  and  	 ( C4 , _H03 , _H01 ) ;
  or  	 ( N01 , C2 , C3 , C4 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMUX2X1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G003 );
    and ( _G012, _G002, _H03 );
    nor ( N01, _G010, _G011, _G012 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMUX2X2 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G003 );
    and ( _G012, _G002, _H03 );
    nor ( N01, _G010, _G011, _G012 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMUX2X3 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G003 );
    and ( _G012, _G002, _H03 );
    nor ( N01, _G010, _G011, _G012 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMUX2X4 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G003 );
    and ( _G012, _G002, _H03 );
    nor ( N01, _G010, _G011, _G012 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMUX2Y0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G003 );
    and ( _G012, _G002, _H03 );
    nor ( N01, _G010, _G011, _G012 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMUX2Y1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G003 );
    and ( _G012, _G002, _H03 );
    nor ( N01, _G010, _G011, _G012 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMUX4X1 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    buf ( _H04, H04 );
    not ( _G004, _H04 );
    buf ( _H05, H05 );
    not ( _G005, _H05 );
    buf ( _H06, H06 );
    not ( _G006, _H06 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G005 );
    and ( _G012, _G002, _H05 );
    or  ( _G013, _G010, _G011, _G012 );
    and ( _G014, _G003, _G004 );
    and ( _G015, _G003, _G005 );
    and ( _G016, _G004, _H05 );
    or  ( _G017, _G014, _G015, _G016 );
    and ( _G018, _G013, _G017 );
    and ( _G019, _G013, _G006 );
    and ( _G020, _G017, _H06 );
    nor ( N01, _G018, _G019, _G020 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMUX4X2 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    buf ( _H04, H04 );
    not ( _G004, _H04 );
    buf ( _H05, H05 );
    not ( _G005, _H05 );
    buf ( _H06, H06 );
    not ( _G006, _H06 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G005 );
    and ( _G012, _G002, _H05 );
    or  ( _G013, _G010, _G011, _G012 );
    and ( _G014, _G003, _G004 );
    and ( _G015, _G003, _G005 );
    and ( _G016, _G004, _H05 );
    or  ( _G017, _G014, _G015, _G016 );
    and ( _G018, _G013, _G017 );
    and ( _G019, _G013, _G006 );
    and ( _G020, _G017, _H06 );
    nor ( N01, _G018, _G019, _G020 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMUX4X4 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    buf ( _H04, H04 );
    not ( _G004, _H04 );
    buf ( _H05, H05 );
    not ( _G005, _H05 );
    buf ( _H06, H06 );
    not ( _G006, _H06 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G005 );
    and ( _G012, _G002, _H05 );
    or  ( _G013, _G010, _G011, _G012 );
    and ( _G014, _G003, _G004 );
    and ( _G015, _G003, _G005 );
    and ( _G016, _G004, _H05 );
    or  ( _G017, _G014, _G015, _G016 );
    and ( _G018, _G013, _G017 );
    and ( _G019, _G013, _G006 );
    and ( _G020, _G017, _H06 );
    nor ( N01, _G018, _G019, _G020 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMUX4Y0 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    buf ( _H04, H04 );
    not ( _G004, _H04 );
    buf ( _H05, H05 );
    not ( _G005, _H05 );
    buf ( _H06, H06 );
    not ( _G006, _H06 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G005 );
    and ( _G012, _G002, _H05 );
    or  ( _G013, _G010, _G011, _G012 );
    and ( _G014, _G003, _G004 );
    and ( _G015, _G003, _G005 );
    and ( _G016, _G004, _H05 );
    or  ( _G017, _G014, _G015, _G016 );
    and ( _G018, _G013, _G017 );
    and ( _G019, _G013, _G006 );
    and ( _G020, _G017, _H06 );
    nor ( N01, _G018, _G019, _G020 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBMXI2X1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( _G001 , _H01 ) ;
  not  	 ( _G002 , _H02 ) ;
  not  	 ( _G003 , _H03 ) ;
  and  	 ( _G010 , _G001 , _G002 ) ;
  and  	 ( _G011 , _G001 , _G003 ) ;
  and  	 ( _G012 , _H03 , _G002 ) ;
  or  	 ( N01 , _G010 , _G011 , _G012 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBMXI2X2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( _G001 , _H01 ) ;
  not  	 ( _G002 , _H02 ) ;
  not  	 ( _G003 , _H03 ) ;
  and  	 ( _G010 , _G001 , _G002 ) ;
  and  	 ( _G011 , _G001 , _G003 ) ;
  and  	 ( _G012 , _H03 , _G002 ) ;
  or  	 ( N01 , _G010 , _G011 , _G012 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBMXI2X3 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( _G001 , _H01 ) ;
  not  	 ( _G002 , _H02 ) ;
  not  	 ( _G003 , _H03 ) ;
  and  	 ( _G010 , _G001 , _G002 ) ;
  and  	 ( _G011 , _G001 , _G003 ) ;
  and  	 ( _G012 , _H03 , _G002 ) ;
  or  	 ( N01 , _G010 , _G011 , _G012 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBMXI2X4 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( _G001 , _H01 ) ;
  not  	 ( _G002 , _H02 ) ;
  not  	 ( _G003 , _H03 ) ;
  and  	 ( _G010 , _G001 , _G002 ) ;
  and  	 ( _G011 , _G001 , _G003 ) ;
  and  	 ( _G012 , _H03 , _G002 ) ;
  or  	 ( N01 , _G010 , _G011 , _G012 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBMXI2Y0 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( _G001 , _H01 ) ;
  not  	 ( _G002 , _H02 ) ;
  not  	 ( _G003 , _H03 ) ;
  and  	 ( _G010 , _G001 , _G002 ) ;
  and  	 ( _G011 , _G001 , _G003 ) ;
  and  	 ( _G012 , _H03 , _G002 ) ;
  or  	 ( N01 , _G010 , _G011 , _G012 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBMXI2Y1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( _G001 , _H01 ) ;
  not  	 ( _G002 , _H02 ) ;
  not  	 ( _G003 , _H03 ) ;
  and  	 ( _G010 , _G001 , _G002 ) ;
  and  	 ( _G011 , _G001 , _G003 ) ;
  and  	 ( _G012 , _H03 , _G002 ) ;
  or  	 ( N01 , _G010 , _G011 , _G012 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMXI4X1 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    buf ( _H04, H04 );
    not ( _G004, _H04 );
    buf ( _H05, H05 );
    not ( _G005, _H05 );
    buf ( _H06, H06 );
    not ( _G006, _H06 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G005 );
    and ( _G012, _G002, _H05 );
    or  ( _G013, _G010, _G011, _G012 );
    and ( _G014, _G003, _G004 );
    and ( _G015, _G003, _G005 );
    and ( _G016, _G004, _H05 );
    or  ( _G017, _G014, _G015, _G016 );
    and ( _G018, _G013, _G017 );
    and ( _G019, _G013, _G006 );
    and ( _G020, _G017, _H06 );
    or  ( N01, _G018, _G019, _G020 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMXI4X2 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    buf ( _H04, H04 );
    not ( _G004, _H04 );
    buf ( _H05, H05 );
    not ( _G005, _H05 );
    buf ( _H06, H06 );
    not ( _G006, _H06 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G005 );
    and ( _G012, _G002, _H05 );
    or  ( _G013, _G010, _G011, _G012 );
    and ( _G014, _G003, _G004 );
    and ( _G015, _G003, _G005 );
    and ( _G016, _G004, _H05 );
    or  ( _G017, _G014, _G015, _G016 );
    and ( _G018, _G013, _G017 );
    and ( _G019, _G013, _G006 );
    and ( _G020, _G017, _H06 );
    or  ( N01, _G018, _G019, _G020 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMXI4X4 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    buf ( _H04, H04 );
    not ( _G004, _H04 );
    buf ( _H05, H05 );
    not ( _G005, _H05 );
    buf ( _H06, H06 );
    not ( _G006, _H06 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G005 );
    and ( _G012, _G002, _H05 );
    or  ( _G013, _G010, _G011, _G012 );
    and ( _G014, _G003, _G004 );
    and ( _G015, _G003, _G005 );
    and ( _G016, _G004, _H05 );
    or  ( _G017, _G014, _G015, _G016 );
    and ( _G018, _G013, _G017 );
    and ( _G019, _G013, _G006 );
    and ( _G020, _G017, _H06 );
    or  ( N01, _G018, _G019, _G020 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBMXI4Y0 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;

    buf ( _H01, H01 );
    not ( _G001, _H01 );
    buf ( _H02, H02 );
    not ( _G002, _H02 );
    buf ( _H03, H03 );
    not ( _G003, _H03 );
    buf ( _H04, H04 );
    not ( _G004, _H04 );
    buf ( _H05, H05 );
    not ( _G005, _H05 );
    buf ( _H06, H06 );
    not ( _G006, _H06 );
    and ( _G010, _G001, _G002 );
    and ( _G011, _G001, _G005 );
    and ( _G012, _G002, _H05 );
    or  ( _G013, _G010, _G011, _G012 );
    and ( _G014, _G003, _G004 );
    and ( _G015, _G003, _G005 );
    and ( _G016, _G004, _H05 );
    or  ( _G017, _G014, _G015, _G016 );
    and ( _G018, _G013, _G017 );
    and ( _G019, _G013, _G006 );
    and ( _G020, _G017, _H06 );
    or  ( N01, _G018, _G019, _G020 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );

      ( posedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H05 => (N01:H05) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H06 => (N01:H06) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:24 1995

module TBND2BX1 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  and  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:24 1995

module TBND2BX2 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  and  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:24 1995

module TBND2BX3 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  and  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:24 1995

module TBND2BX4 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  and  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:24 1995

module TBND2BY0 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  and  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:24 1995

module TBND2BY1 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  and  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND2X1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nand ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif   
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND2X2 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nand ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif   
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND2X3 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nand ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif   
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND2X4 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nand ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif   
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND2X6 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nand ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif   
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND2X8 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nand ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif   
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND2Y0 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nand ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif   
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND2Y1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nand ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif   
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:38 1995

module TBND3BBX1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H02 ) ;
  not  	 ( C4 , _H03 ) ;
  and  	 ( C2 , _H01 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:38 1995

module TBND3BBX2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H02 ) ;
  not  	 ( C4 , _H03 ) ;
  and  	 ( C2 , _H01 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:31 1995

module TBND3BX1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H03 ) ;
  and  	 ( C2 , _H01 , _H02 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:31 1995

module TBND3BX2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H03 ) ;
  and  	 ( C2 , _H01 , _H02 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND3X0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nand ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND3X1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nand ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND3X2 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nand ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND3X3 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nand ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND3X4 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nand ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND3Y0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nand ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:55 1995

module TBND4BBX1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C3 , _H03 ) ;
  not  	 ( C4 , _H04 ) ;
  and  	 ( C2 , _H01 , _H02 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif 
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:55 1995

module TBND4BBX2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C3 , _H03 ) ;
  not  	 ( C4 , _H04 ) ;
  and  	 ( C2 , _H01 , _H02 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif 
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:45 1995

module TBND4BX1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C3 , _H04 ) ;
  and  	 ( C2 , _H01 , _H02 , _H03 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:45 1995

module TBND4BX2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C3 , _H04 ) ;
  and  	 ( C2 , _H01 , _H02 , _H03 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND4X0 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    nand ( N01, _H01, _H02, _H03, _H04 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND4X1 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    nand ( N01, _H01, _H02, _H03, _H04 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND4X2 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    nand ( N01, _H01, _H02, _H03, _H04 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBND4Y0 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    nand ( N01, _H01, _H02, _H03, _H04 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:09 1995

module TBNR2BX0 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  or  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:09 1995

module TBNR2BX1 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  or  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:09 1995

module TBNR2BX2 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  or  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:09 1995

module TBNR2BX3 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  or  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:09 1995

module TBNR2BX4 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  or  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:09 1995

module TBNR2BY0 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  or  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:09 1995

module TBNR2BY1 ( N01 , H01 , H02 ) ;
 input H01 ;
 input H02 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  not  	 ( C3 , _H02 ) ;
  or  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR2X0 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nor ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR2X1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nor ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR2X2 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nor ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR2X3 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nor ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR2X4 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nor ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR2X6 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nor ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR2X8 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nor ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR2Y0 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nor ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR2Y1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    nor ( N01, _H01, _H02 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:16 1995

module TBNR3BBX1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H02 ) ;
  not  	 ( C4 , _H03 ) ;
  or  	 ( C2 , _H01 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:10:16 1995

module TBNR3BBX2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H02 ) ;
  not  	 ( C4 , _H03 ) ;
  or  	 ( C2 , _H01 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Sat Nov 25 22:14:02 1995

module TBNR3BX1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H03 ) ;
  or  	 ( C2 , _H01 , _H02 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Sat Nov 25 22:14:02 1995

module TBNR3BX2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H03 ) ;
  or  	 ( C2 , _H01 , _H02 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR3X0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nor ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR3X1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nor ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR3X2 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nor ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR3X3 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nor ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR3X4 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nor ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR3Y0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    nor ( N01, _H01, _H02, _H03 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Tue Nov  7 20:26:06 1995

module TBNR4BX1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C3 , _H04 ) ;
  or  	 ( C2 , _H01 , _H02 , _H03 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Tue Nov  7 20:26:06 1995

module TBNR4BX2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C3 , _H04 ) ;
  or  	 ( C2 , _H01 , _H02 , _H03 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR4X0 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    nor ( N01, _H01, _H02, _H03, _H04 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR4X1 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    nor ( N01, _H01, _H02, _H03, _H04 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR4X2 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    nor ( N01, _H01, _H02, _H03, _H04 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBNR4Y0 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    nor ( N01, _H01, _H02, _H03, _H04 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:12:03 1995

module TBOA12X1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  not  	 ( C6 , _H03 ) ;
  and  	 ( C4 , C5 , C6 ) ;
  or  	 ( C2 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:12:03 1995

module TBOA12X2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  not  	 ( C6 , _H03 ) ;
  and  	 ( C4 , C5 , C6 ) ;
  or  	 ( C2 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:14:32 1995

module TBOA22X1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  and  	 ( C3 , C4 , C5 ) ;
  not  	 ( C7 , _H03 ) ;
  not  	 ( C8 , _H04 ) ;
  and  	 ( C6 , C7 , C8 ) ;
  or  	 ( C2 , C3 , C6 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:14:32 1995

module TBOA22X2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  and  	 ( C3 , C4 , C5 ) ;
  not  	 ( C7 , _H03 ) ;
  not  	 ( C8 , _H04 ) ;
  and  	 ( C6 , C7 , C8 ) ;
  or  	 ( C2 , C3 , C6 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:16:47 1995

module TBON112BX1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H03 ) ;
  or  	 ( C3 , C4 , _H04 ) ;
  and  	 ( C2 , _H01 , _H02 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:16:47 1995

module TBON112BX2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H03 ) ;
  or  	 ( C3 , C4 , _H04 ) ;
  and  	 ( C2 , _H01 , _H02 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBON112X1 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    or ( _G001, _H03, _H04 );
    nand ( N01, _H01, _H02, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBON112X2 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    or ( _G001, _H03, _H04 );
    nand ( N01, _H01, _H02, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Tue Nov  7 20:29:58 1995

module TBON122X1 ( N01 , H01 , H02 , H03 , H04 , H05 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 input H05 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  buf  	 ( _H05 , H05 ) ;
  or  	 ( C3 , _H02 , _H03 ) ;
  or  	 ( C4 , _H04 , _H05 ) ;
  and  	 ( C2 , _H01 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H05 to N01
  ( H05 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Tue Nov  7 20:29:58 1995

module TBON122X2 ( N01 , H01 , H02 , H03 , H04 , H05 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 input H05 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  buf  	 ( _H05 , H05 ) ;
  or  	 ( C3 , _H02 , _H03 ) ;
  or  	 ( C4 , _H04 , _H05 ) ;
  and  	 ( C2 , _H01 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H05 to N01
  ( H05 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:15:52 1995

module TBON12BBX1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C4 , _H02 ) ;
  not  	 ( C5 , _H03 ) ;
  or  	 ( C3 , C4 , C5 ) ;
  and  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:15:52 1995

module TBON12BBX2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C4 , _H02 ) ;
  not  	 ( C5 , _H03 ) ;
  or  	 ( C3 , C4 , C5 ) ;
  and  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:15:52 1995

module TBON12BBY0 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C4 , _H02 ) ;
  not  	 ( C5 , _H03 ) ;
  or  	 ( C3 , C4 , C5 ) ;
  and  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:15:45 1995

module TBON12BX1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C4 , _H02 ) ;
  or  	 ( C3 , C4 , _H03 ) ;
  and  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:15:45 1995

module TBON12BX2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C4 , _H02 ) ;
  or  	 ( C3 , C4 , _H03 ) ;
  and  	 ( C2 , _H01 , C3 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBON12X0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    or ( _G001, _H02, _H03 );
    nand ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBON12X1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    or ( _G001, _H02, _H03 );
    nand ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBON12X2 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    or ( _G001, _H02, _H03 );
    nand ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBON12X4 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    or ( _G001, _H02, _H03 );
    nand ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBON12Y0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    or ( _G001, _H02, _H03 );
    nand ( N01, _H01, _G001 );

`ifdef  FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:15:25 1995

module TBON1B2BX1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  or  	 ( C4 , C5 , _H03 ) ;
  and  	 ( C2 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:15:25 1995

module TBON1B2BX2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  or  	 ( C4 , C5 , _H03 ) ;
  and  	 ( C2 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef  FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:15:18 1995

module TBON1B2X1 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H01 ) ;
  or  	 ( C4 , _H02 , _H03 ) ;
  and  	 ( C2 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;
  
`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:15:18 1995

module TBON1B2X2 ( N01 , H01 , H02 , H03 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  not  	 ( C3 , _H01 ) ;
  or  	 ( C4 , _H02 , _H03 ) ;
  and  	 ( C2 , C3 , C4 ) ;
  not  	 ( N01 , C2 ) ;
  
`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Tue Nov  7 20:30:06 1995

module TBON222X0 ( N01 , H01 , H02 , H03 , H04 , H05 , H06 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 input H05 ;
 input H06 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  buf  	 ( _H05 , H05 ) ;
  buf  	 ( _H06 , H06 ) ;
  or  	 ( C3 , _H01 , _H02 ) ;
  or  	 ( C4 , _H03 , _H04 ) ;
  or  	 ( C5 , _H05 , _H06 ) ;
  and  	 ( C2 , C3 , C4 , C5 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H05 to N01
  ( H05 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H06 to N01
  ( H06 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
 
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Tue Nov  7 20:30:06 1995

module TBON222X1 ( N01 , H01 , H02 , H03 , H04 , H05 , H06 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 input H05 ;
 input H06 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  buf  	 ( _H05 , H05 ) ;
  buf  	 ( _H06 , H06 ) ;
  or  	 ( C3 , _H01 , _H02 ) ;
  or  	 ( C4 , _H03 , _H04 ) ;
  or  	 ( C5 , _H05 , _H06 ) ;
  and  	 ( C2 , C3 , C4 , C5 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H05 to N01
  ( H05 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H06 to N01
  ( H06 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
 
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Tue Nov  7 20:30:06 1995

module TBON222X2 ( N01 , H01 , H02 , H03 , H04 , H05 , H06 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 input H05 ;
 input H06 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  buf  	 ( _H05 , H05 ) ;
  buf  	 ( _H06 , H06 ) ;
  or  	 ( C3 , _H01 , _H02 ) ;
  or  	 ( C4 , _H03 , _H04 ) ;
  or  	 ( C5 , _H05 , _H06 ) ;
  and  	 ( C2 , C3 , C4 , C5 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H05 to N01
  ( H05 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H06 to N01
  ( H06 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
 
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Tue Nov  7 20:30:06 1995

module TBON222Y0 ( N01 , H01 , H02 , H03 , H04 , H05 , H06 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 input H05 ;
 input H06 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  buf  	 ( _H05 , H05 ) ;
  buf  	 ( _H06 , H06 ) ;
  or  	 ( C3 , _H01 , _H02 ) ;
  or  	 ( C4 , _H03 , _H04 ) ;
  or  	 ( C5 , _H05 , _H06 ) ;
  and  	 ( C2 , C3 , C4 , C5 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H05 to N01
  ( H05 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H06 to N01
  ( H06 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
 
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBON22X0 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    or ( _G001, _H01, _H02 );
    or ( _G002, _H03, _H04 );
    nand ( N01, _G001, _G002 );
    
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBON22X1 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    or ( _G001, _H01, _H02 );
    or ( _G002, _H03, _H04 );
    nand ( N01, _G001, _G002 );
    
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBON22X2 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    or ( _G001, _H01, _H02 );
    or ( _G002, _H03, _H04 );
    nand ( N01, _G001, _G002 );
    
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBON22Y0 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    or ( _G001, _H01, _H02 );
    or ( _G002, _H03, _H04 );
    nand ( N01, _G001, _G002 );
    
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
    
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:18:18 1995

module TBON2B2BBX1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  or  	 ( C3 , C4 , _H02 ) ;
  not  	 ( C6 , _H03 ) ;
  not  	 ( C7 , _H04 ) ;
  or  	 ( C5 , C6 , C7 ) ;
  and  	 ( C2 , C3 , C5 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Jun 19 20:18:18 1995

module TBON2B2BBX2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  or  	 ( C3 , C4 , _H02 ) ;
  not  	 ( C6 , _H03 ) ;
  not  	 ( C7 , _H04 ) ;
  or  	 ( C5 , C6 , C7 ) ;
  and  	 ( C2 , C3 , C5 ) ;
  not  	 ( N01 , C2 ) ;

`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Nov 27 13:23:04 1995

module TBON2B2BX1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  or  	 ( C3 , C4 , _H02 ) ;
  not  	 ( C6 , _H03 ) ;
  or  	 ( C5 , C6 , _H04 ) ;
  and  	 ( C2 , C3 , C5 ) ;
  not  	 ( N01 , C2 ) ;
`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Nov 27 13:23:04 1995

module TBON2B2BX2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  or  	 ( C3 , C4 , _H02 ) ;
  not  	 ( C6 , _H03 ) ;
  or  	 ( C5 , C6 , _H04 ) ;
  and  	 ( C2 , C3 , C5 ) ;
  not  	 ( N01 , C2 ) ;
`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Nov 27 13:17:48 1995

module TBON2B2X1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  or  	 ( C3 , C4 , _H02 ) ;
  or  	 ( C5 , _H03 , _H04 ) ;
  and  	 ( C2 , C3 , C5 ) ;
  not  	 ( N01 , C2 ) ;
`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Nov 27 13:17:48 1995

module TBON2B2X2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  or  	 ( C3 , C4 , _H02 ) ;
  or  	 ( C5 , _H03 , _H04 ) ;
  and  	 ( C2 , C3 , C5 ) ;
  not  	 ( N01 , C2 ) ;
`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Nov 27 13:18:11 1995

module TBON2BB2X1 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  or  	 ( C3 , C4 , C5 ) ;
  or  	 ( C6 , _H03 , _H04 ) ;
  and  	 ( C2 , C3 , C6 ) ;
  not  	 ( N01 , C2 ) ;
`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
// generated by sldtoveri Version 1.3.4
// Mon Nov 27 13:18:11 1995

module TBON2BB2X2 ( N01 , H01 , H02 , H03 , H04 ) ;
 input H01 ;
 input H02 ;
 input H03 ;
 input H04 ;
 output N01 ;

  buf  	 ( _H01 , H01 ) ;
  buf  	 ( _H02 , H02 ) ;
  buf  	 ( _H03 , H03 ) ;
  buf  	 ( _H04 , H04 ) ;
  not  	 ( C4 , _H01 ) ;
  not  	 ( C5 , _H02 ) ;
  or  	 ( C3 , C4 , C5 ) ;
  or  	 ( C6 , _H03 , _H04 ) ;
  and  	 ( C2 , C3 , C6 ) ;
  not  	 ( N01 , C2 ) ;
`ifdef FAST_FUNC
`else
 specify
        specparam DMY_SPC=1;

// path from H01 to N01
  ( H01 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H02 to N01
  ( H02 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H03 to N01
  ( H03 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
// path from H04 to N01
  ( H04 =>  N01 ) = ( DMY_SPC,
                      DMY_SPC );
 endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR2X1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    or  ( N01, _H01, _H02 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR2X2 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    or  ( N01, _H01, _H02 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR2X4 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    or  ( N01, _H01, _H02 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR2X6 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    or  ( N01, _H01, _H02 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR2X8 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    or  ( N01, _H01, _H02 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR2Y0 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    or  ( N01, _H01, _H02 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR2Y1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    or  ( N01, _H01, _H02 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;


        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR3X1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    or ( N01, _H01, _H02, _H03 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR3X2 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    or ( N01, _H01, _H02, _H03 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR3X4 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    or ( N01, _H01, _H02, _H03 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR4X1 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    or ( N01, _H01, _H02, _H03, _H04 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBOR4X2 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    or ( N01, _H01, _H02, _H03, _H04 );
`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

        ( H01 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H02 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H03 => N01 ) = ( DMY_SPC, DMY_SPC );
        ( H04 => N01 ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFHQRBX1 ( N01, H01, H02, H03, H04, H05 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, _H03, 1'b1, notifier );
    wire chk_cond1 = ( _H03 !== 1'b0 && _H05 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H05 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);

$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFHQRBX2 ( N01, H01, H02, H03, H04, H05 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, _H03, 1'b1, notifier );
    wire chk_cond1 = ( _H03 !== 1'b0 && _H05 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H05 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);

$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFHQRBX4 ( N01, H01, H02, H03, H04, H05 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, _H03, 1'b1, notifier );
    wire chk_cond1 = ( _H03 !== 1'b0 && _H05 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H05 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);

$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFHQRBY0 ( N01, H01, H02, H03, H04, H05 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, _H03, 1'b1, notifier );
    wire chk_cond1 = ( _H03 !== 1'b0 && _H05 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H05 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);

$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFHQRSBX1 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );
    buf ( _H06, H06 );

    udp_MUX udp_MUX_inst ( G001, _H06, _H01, _H05 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, _H03, _H04, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );
    buf ( _H06, delayed_H06 );

    udp_MUX udp_MUX_inst ( G001, _H06, _H01, _H05 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, _H03, _H04, notifier );
    wire chk_cond1 = ( _H03 !== 1'b0 && _H04 !== 1'b0 && _H06 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H04 !== 1'b0 && _H06 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 && _H04 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), posedge H06, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H06);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), negedge H06, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H06);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$recrem (posedge H04, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H04, delayed_H02);

$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);
$width (negedge H04, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );
        ( negedge H04 => (N01:H04) ) = ( DMY_SPC, 0:0:0 );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFHQSBX1 ( N01, H01, H02, H03, H04, H05 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, 1'b1, _H03, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, 1'b1, _H03, notifier );
    wire chk_cond1 = ( _H03 !== 1'b0 && _H05 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H05 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);

$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( DMY_SPC, 0:0:0 );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFHQSBX2 ( N01, H01, H02, H03, H04, H05 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, 1'b1, _H03, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, 1'b1, _H03, notifier );
    wire chk_cond1 = ( _H03 !== 1'b0 && _H05 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H05 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);

$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( DMY_SPC, 0:0:0 );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFHQSBY0 ( N01, H01, H02, H03, H04, H05 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, 1'b1, _H03, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );

    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, 1'b1, _H03, notifier );
    wire chk_cond1 = ( _H03 !== 1'b0 && _H05 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H05 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (posedge H02 &&& (chk_cond3 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$recrem (posedge H03, posedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);

$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( DMY_SPC, 0:0:0 );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFHQX1 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );

    udp_MUX udp_MUX_inst ( G001, _H04, _H01, _H03 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, 1'b1, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );

    udp_MUX udp_MUX_inst ( G001, _H04, _H01, _H03 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, 1'b1, 1'b1, notifier );
    wire chk_cond1 = ( _H04 !== 1'b1 );
    wire chk_cond2 = ( _H04 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02, negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);

$width (posedge H02, DMY_SPC, 0, notifier);
$width (negedge H02, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFHQX2 ( N01, H01, H02, H03, H04 );
    input H01;
    input H02;
    input H03;
    input H04;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );

    udp_MUX udp_MUX_inst ( G001, _H04, _H01, _H03 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, 1'b1, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );

    udp_MUX udp_MUX_inst ( G001, _H04, _H01, _H03 );
    DESFQ2 DESFQ2_inst ( N01, G001, _H02, 1'b1, 1'b1, notifier );
    wire chk_cond1 = ( _H04 !== 1'b1 );
    wire chk_cond2 = ( _H04 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), posedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02 &&& (chk_cond2 == 1'b1), negedge H03, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H03);
$setuphold (posedge H02, posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (posedge H02, negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);

$width (posedge H02, DMY_SPC, 0, notifier);
$width (negedge H02, DMY_SPC, 0, notifier);

        ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFLQRBX1 ( N01, H01, H02, H03, H04, H05 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );

    not ( _CLK, _H02 );
    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _CLK, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );

    not ( _CLK, _H02 );
    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _CLK, _H03, 1'b1, notifier );
    wire chk_cond1 = ( _H03 !== 1'b0 && _H05 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H05 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond2 == 1'b1), posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (negedge H02 &&& (chk_cond2 == 1'b1), negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (negedge H02 &&& (chk_cond3 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (negedge H02 &&& (chk_cond3 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$recrem (posedge H03, negedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);

$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFLQRBY0 ( N01, H01, H02, H03, H04, H05 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );

    not ( _CLK, _H02 );
    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _CLK, _H03, 1'b1, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );

    not ( _CLK, _H02 );
    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, _CLK, _H03, 1'b1, notifier );
    wire chk_cond1 = ( _H03 !== 1'b0 && _H05 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H05 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond2 == 1'b1), posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (negedge H02 &&& (chk_cond2 == 1'b1), negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (negedge H02 &&& (chk_cond3 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (negedge H02 &&& (chk_cond3 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$recrem (posedge H03, negedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);

$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/13
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFLQRSBX1 ( N01, H01, H02, H03, H04, H05, H06 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    input H06;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );
    buf ( _H06, H06 );

    not ( _CLK, _H02 );
    udp_MUX udp_MUX_inst ( G001, _H06, _H01, _H05 );
    DESFQ2 DESFQ2_inst ( N01, G001, _CLK, _H03, _H04, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );
    buf ( _H06, delayed_H06 );

    not ( _CLK, _H02 );
    udp_MUX udp_MUX_inst ( G001, _H06, _H01, _H05 );
    DESFQ2 DESFQ2_inst ( N01, G001, _CLK, _H03, _H04, notifier );
    wire chk_cond1 = ( _H03 !== 1'b0 && _H04 !== 1'b0 && _H06 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H04 !== 1'b0 && _H06 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 && _H04 !== 1'b0 );

`endif

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1:1:1;

$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond2 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (negedge H02 &&& (chk_cond2 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (negedge H02 &&& (chk_cond3 == 1'b1), posedge H06, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H06);
$setuphold (negedge H02 &&& (chk_cond3 == 1'b1), negedge H06, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H06);
$recrem (posedge H03, negedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);
$recrem (posedge H04, negedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H04, delayed_H02);

$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);
$width (negedge H04, DMY_SPC, 0, notifier);

        ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( 0:0:0, DMY_SPC );
        ( negedge H04 => (N01:H04) ) = ( DMY_SPC, 0:0:0 );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module TBSMDFLQSBX1 ( N01, H01, H02, H03, H04, H05 );
    input H01;
    input H02;
    input H03;
    input H04;
    input H05;
    output N01;
    reg notifier;

`ifdef FAST_FUNC
    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    buf ( _H04, H04 );
    buf ( _H05, H05 );

    not ( delayed_CLK, _H02 );
    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, delayed_CLK, 1'b1, _H03, notifier );
`else
    buf ( _H01, delayed_H01 );
    buf ( _H02, delayed_H02 );
    buf ( _H03, delayed_H03 );
    buf ( _H04, delayed_H04 );
    buf ( _H05, delayed_H05 );

    not ( delayed_CLK, _H02 );
    udp_MUX udp_MUX_inst ( G001, _H05, _H01, _H04 );
    DESFQ2 DESFQ2_inst ( N01, G001, delayed_CLK, 1'b1, _H03, notifier );
`endif

`ifdef FAST_FUNC
`else
    wire chk_cond1 = ( _H03 !== 1'b0 && _H05 !== 1'b1 );
    wire chk_cond2 = ( _H03 !== 1'b0 && _H05 !== 1'b0 );
    wire chk_cond3 = ( _H03 !== 1'b0 );

    specify
        specparam DMY_SPC=1:1:1;

$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), posedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond1 == 1'b1), negedge H01, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H01);
$setuphold (negedge H02 &&& (chk_cond2 == 1'b1), posedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (negedge H02 &&& (chk_cond2 == 1'b1), negedge H04, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H04);
$setuphold (negedge H02 &&& (chk_cond3 == 1'b1), posedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$setuphold (negedge H02 &&& (chk_cond3 == 1'b1), negedge H05, DMY_SPC, DMY_SPC, notifier, , , delayed_H02, delayed_H05);
$recrem (posedge H03, negedge H02, DMY_SPC, DMY_SPC, notifier, , , delayed_H03, delayed_H02);

$width (negedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (posedge H02 &&& (chk_cond3 == 1'b1), DMY_SPC, 0, notifier);
$width (negedge H03, DMY_SPC, 0, notifier);

        ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
        ( negedge H03 => (N01:H03) ) = ( DMY_SPC, 0:0:0 );

    endspecify
`endif
endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXN2X0 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    xnor ( N01, _H01, _H02 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

    if ( H01 )
      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
    if ( !H01 )
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
    if ( H02 )
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
    if ( !H02 )
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXN2X1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    xnor ( N01, _H01, _H02 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXN2X2 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    xnor ( N01, _H01, _H02 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXN2Y0 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    xnor ( N01, _H01, _H02 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXN2Y1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    xnor ( N01, _H01, _H02 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXN3X1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    xnor ( N01, _H01, _H02, _H03 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXN3X2 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    xnor ( N01, _H01, _H02, _H03 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXR2X0 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    xor ( N01, _H01, _H02 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

    if ( H01 )
      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
    if ( !H01 )
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
    if ( H02 )
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
    if ( !H02 )
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );

    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXR2X1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    xor ( N01, _H01, _H02 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXR2X2 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    xor ( N01, _H01, _H02 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXR2Y0 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    xor ( N01, _H01, _H02 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/08/31
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXR2Y1 ( N01, H01, H02 );
    input H01;
    input H02;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    xor ( N01, _H01, _H02 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXR3X1 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    xor ( N01, _H01, _H02, _H03 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXR3X2 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    xor ( N01, _H01, _H02, _H03 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine
// VERSION:5.00 DATE:2009/07/16
`timescale 1ps / 1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif
module TBXR3Y0 ( N01, H01, H02, H03 );
    input H01;
    input H02;
    input H03;
    output N01;

    buf ( _H01, H01 );
    buf ( _H02, H02 );
    buf ( _H03, H03 );
    xor ( N01, _H01, _H02, _H03 );

`ifdef FAST_FUNC
`else
    specify
        specparam DMY_SPC=1;

      ( posedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H01 => (N01:H01) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H02 => (N01:H02) ) = ( DMY_SPC, DMY_SPC );
      ( posedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
      ( negedge H03 => (N01:H03) ) = ( DMY_SPC, DMY_SPC );
    endspecify
`endif

endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine

// ------------------------------------------------------
// Positive edge triggered D flip-flop with active low	-
// asynchronous set and clear.Equivalent to ACOS DESF.	-
// ------------------------------------------------------
module DESFQ2 ( Q, D, CP, RB, SB, notifier );
	output Q;
	input D,CP,RB,SB,notifier;

	FDCPE FDCPE_inst (
		.Q(Q),		// Data output		Active -
		.D(D),		// Data input		Active -
		.C(CP),		// Clock input		Active ↑
		.CE(1'b1),	// Clock enable input	Active 1(through by 1)
		.CLR(~RB),	// Asynchronous clear	Active 1
		.PRE(~SB)	// Asynchronous set	Active 1(@CLR=0)
	);
	defparam FDCPE_inst.INIT = 1'b0; // Initial value of regiser = 1'b0
endmodule

// VERSION:1.00 DATE:2003/07/04 UDP
//`timescale 1ps / 1ps
//`celldefine
//`ifdef verifault
//    `suppress_faults
//`endif
//
//primitive DESFQ2 ( Q, D, CP, RB, SB, notifier );
//    output Q;
//    input  D,CP,RB,SB,notifier;
//    reg    Q;    
//    // Positive edge triggered D flip-flop with active low
//    // asynchronous set and clear.Equivalent to ACOS DESF.
//
//    table
//
//    //  D    CP      RB    SB   notifier:   Qt  :   Qt+1
//
//        1   (01)     1     ?        ?   :   ?   :   1; // clocked data
//        0   (01)     ?     1        ?   :   ?   :   0;
//        *    b       1     1        ?   :   ?   :   -; // edges on data
//        *    b       x     1        ?   :   ?   :   -;
//        *    b       1     x        ?   :   ?   :   -;  
//        ?   (10)     1     1        ?   :   ?   :   -; // negative edge on clock
//        ?   (10)     x     1        ?   :   ?   :   -;
//        ?   (10)     1     x        ?   :   ?   :   -;
//
//        ?    ?      (?1)   0        ?   :   ?   :   1; // set
//        ?    ?       1    (?0)      ?   :   ?   :   1;
//        ?    *       1     0        ?   :   ?   :   1;
//        *    ?       1     0        ?   :   ?   :   1;
//        ?    ?      (?0)   1        ?   :   ?   :   0; // reset
//        ?    ?       0    (?1)      ?   :   ?   :   0;
//        ?    *       0     1        ?   :   ?   :   0;
//        *    ?       0     1        ?   :   ?   :   0;
//
//        ?    ?       0     0        ?   :   ?   :   x; // set and reset
//        ?    ?       x     0        ?   :   ?   :   x; // set and reset
//        ?    ?       0     x        ?   :   ?   :   x; // set and reset
//
//        0   (?x)     ?     1        ?   :   0   :   -; // x-edges on clock
//        1   (?x)     1     ?        ?   :   1   :   -;
//        0   (x1)     ?     1        ?   :   0   :   -;
//        1   (x1)     1     ?        ?   :   1   :   -;
//        1   (x0)     1     ?        ?   :   1   :   -;
//        0   (x0)     ?     1        ?   :   0   :   -; 
//       (?1)  ?       1     x        ?   :   1   :   1;
//        1    ?      (?1)   x        ?   :   1   :   1;
//        1    ?       1    (?x)      ?   :   1   :   1;
//       (?0)  ?       x     1        ?   :   0   :   0;  
//        0    ?      (?x)   1        ?   :   0   :   0;  
//        0    ?       x    (?1)      ?   :   0   :   0;  
//        ?    b      (?1)   1        ?   :   ?   :   -;  // ignore the edges on
//        ?    b       1    (?1)      ?   :   ?   :   -;  //       set and clear
//        ?    b       1    (1x)      ?   :   1   :   -; 
//        ?    b      (1x)   1        ?   :   0   :   -;
//        ?    b      (0x)   1        ?   :   0   :   -;
//        ?    b       1    (0x)      ?   :   1   :   -;
//        0    x      (x1)   1        ?   :   0   :   -;
//        1    x       1    (01)      ?   :   1   :   -;
//        1    x       1    (x1)      ?   :   1   :   -;
//        0    x      (01)   1        ?   :   0   :   -;     
//        ?    ?       ?     ?        *   :   ?   :   x; // At any notifier event
//                                                       //output an x
//        
//    endtable
//endprimitive
//
//`ifdef verifault
//        `nosuppress_faults
//`endif
//`endcelldefine

// ------------------------------------------------------
// C=Gateは↓でLatch。Set/ResetはActive0。		-
// ------------------------------------------------------
module DLSFQ2 ( Q, D, C, R, S, notifier );
	output Q;
	input	D,C,R,S,notifier;

	LDCPE LDCPE_inst (
		.Q(Q),		// Data output		Active -
		.D(D),		// Data input		Active -
		.G(C),		// Gate Input		Active 1(through by 1 ,Latch by↓)
		.GE(1'b1),	// Gate enable input	Active 1(through by 1)
		.CLR(~R),	// Asynchronous clear	Active 1
		.PRE(~S)	// Asynchronous preset	Active 1(@CLR=0)
	);
	defparam LDCPE_inst.INIT = 1'b0; // Initial value of latch = 1'b0

endmodule

// ------------------------------------------------------
// C=Gateは↓でLatch。Set/ResetはActive0。		-
// ------------------------------------------------------
// VERSION:1.00 DATE:2003/07/02 UDP
//`timescale 1ps / 1ps
//`celldefine
//`ifdef verifault
//    `suppress_faults
//`endif
//
//primitive DLSFQ2 ( Q, D, C, R, S, notifier );
//    output Q;
//    reg  Q;
//    input  D,C,R,S,notifier;
//
//    table
//    // D    C    R    S notifier  : Qtn    :  Qtn+1
//
//     (?1)   1    1    1    ?     :  ?        :   1;
//       1  (?1)   1    1    ?     :  ?        :   1;
//       1    1  (?1)   1    ?     :  ?        :   1;
//       1    1    1  (?1)   ?     :  ?        :   1;
//     (?0)   1    1    1    ?     :  ?        :   0;
//       0  (?1)   1    1    ?     :  ?        :   0;
//       0    1  (?1)   1    ?     :  ?        :   0;
//       0    1    1  (?1)   ?     :  ?        :   0;
//       ?    0   (?1)  1    ?     :  ?        :   -;
//       ?    0    1   (?1)  ?     :  ?        :   -;
//       1  (?x)   1    1    ?     :  1        :   -;
//       0  (?x)   1    1    ?     :  0        :   -;
//      (?1)  x    1    1    ?     :  1        :   -;
//      (?0)  x    1    1    ?     :  0        :   -;
//       0    x   (?1)  1    ?     :  0        :   -;
//       1    x    1   (?1)  ?     :  1        :   -;
//       *    0    1    1    ?     :  ?        :   -;
//
//     (?0)   0    x    1    ?     :  0        :   -;
//       0  (?0)   x    1    ?     :  0        :   -;
//       0    0  (?x)   1    ?     :  0        :   -;
//       0    0    x  (?1)   ?     :  0        :   -;
//     (?1)   0    x    1    ?     :  0        :   -;
//       1  (?0)   x    1    ?     :  0        :   -;
//       1    0  (?x)   1    ?     :  0        :   -;
//       1    0    x  (?1)   ?     :  0        :   -;
//     (?0)   1    x    1    ?     :  ?        :   0;
//       0  (?1)   x    1    ?     :  ?        :   0;
//       0    1  (?x)   1    ?     :  ?        :   0;
//       0    1    x  (?1)   ?     :  ?        :   0;
//     (?0)   x    x    1    ?     :  0        :   -;
//       0  (?x)   x    1    ?     :  0        :   -;
//       0    x  (?x)   1    ?     :  0        :   -;
//       0    x    x  (?1)   ?     :  0        :   -;
//     (?x)   0    x    1    ?     :  0        :   -;  
//       x  (?0)   x    1    ?     :  0        :   -;  
//       x    0  (?x)   1    ?     :  0        :   -;  
//       x    0    x  (?1)   ?     :  0        :   -;  
//
//     (?1)   0    1    x    ?     :  1        :   -;
//       1  (?0)   1    x    ?     :  1        :   -;
//       1    0  (?1)   x    ?     :  1        :   -;
//       1    0    1  (?x)   ?     :  1        :   -;
//     (?0)   0    1    x    ?     :  1        :   -;
//       0  (?0)   1    x    ?     :  1        :   -;
//       0    0  (?1)   x    ?     :  1        :   -;
//       0    0    1  (?x)   ?     :  1        :   -;
//     (?1)   1    1    x    ?     :  ?        :   1;
//       1  (?1)   1    x    ?     :  ?        :   1;
//       1    1  (?1)   x    ?     :  ?        :   1;
//       1    1    1  (?x)   ?     :  ?        :   1;
//     (?1)   x    1    x    ?     :  1        :   -;
//       1  (?x)   1    x    ?     :  1        :   -;
//       1    x  (?1)   x    ?     :  1        :   -;
//       1    x    1  (?x)   ?     :  1        :   -;
//     (?x)   0    1    x    ?     :  1        :   -;
//       x  (?0)   1    x    ?     :  1        :   -;
//       x    0  (?1)   x    ?     :  1        :   -;
//       x    0    1  (?x)   ?     :  1        :   -;
//     
//       ?    ?  (?1)   0    ?     :  ?        :   1;
//       ?    ?    1  (?0)   ?     :  ?        :   1;
//       *    ?    1    0    ?     :  ?        :   1;
//       ?    *    1    0    ?     :  ?        :   1;
//       ?    ?  (?0)   1    ?     :  ?        :   0;
//       ?    ?    0  (?1)   ?     :  ?        :   0;
//       *    ?    0    1    ?     :  ?        :   0;
//       ?    *    0    1    ?     :  ?        :   0;
//
//       ?    ?    0    0    ?     :  ?        :   x; // set & reset
//       ?    ?    0    x    ?     :  ?        :   x; // set & reset
//       ?    ?    x    0    ?     :  ?        :   x; // set & reset
//      
//       b  (?0)   1    1    ?     :  ?        :   -;
//       ?    ?    ?    ?    *     :  ?        :   x; // Output an x if the
//                                                    //notifier changes
//
//    endtable
//endprimitive
//
//`ifdef verifault
//	`nosuppress_faults
//`endif
//`endcelldefine
//

module udp_MUX ( mux, control, dataA, dataB );
	output	mux;
	input	control, dataA, dataB;
	
	assign	mux = control ? dataB : dataA;
endmodule

// VERSION:3.00 DATE:1999/09/24 UDP
//`timescale 1ps / 1ps
//`celldefine
//`ifdef verifault
//    `suppress_faults
//`endif
//
//primitive udp_MUX (mux, control, dataA, dataB ) ;
//    output mux ;
//    input control, dataA, dataB ;
//
//    table
//    // control dataA dataB  mux
//           0     1     ?  : 1  ;   // ? = 0,1,x
//           0     0     ?  : 0  ;
//           1     ?     1  : 1  ;
//           1     ?     0  : 0  ;
//           x     0     0  : 0  ;
//           x     1     1  : 1  ;
//    //  Unspecified cases is a default output state of x.
//    endtable
//endprimitive
//
//`ifdef verifault
//        `nosuppress_faults
//`endif
//`endcelldefine
