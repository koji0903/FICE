/********************************/
/*     Ver1.10  QICA01P5H5H       */
/*     Sep.3.2010               */
/********************************/
`timescale 1ps/1ps
`celldefine
`ifdef verifault
    `suppress_faults
    `enable_portfaults
`endif

module QICAP015H5H ( ANAI01, CLKI01, CLKI02, CLKI03, CLKI04, CLKI05, CLKI06, CLKO01, CLKO02, CLKO03,
 SIGI01, SIGI02, SIGI03, SIGI04, SIGI05, SIGI06, SIGI07, SIGI08, SIGI09, SIGI10,
 SIGI11, SIGI12, SIGI13, SIGI14, SIGI15, SIGI16, SIGI17, SIGI18, SIGI19, SIGI20,
 SIGI21, SIGI22, SIGI23, SIGI24, SIGI25, SIGI26, SIGI27, SIGI28, SIGI29, SIGI30,
 SIGI31, SIGI32, SIGI33, SIGI34, SIGI35, SIGI36, SIGI37, SIGI38, SIGI39, SIGI40,
 SIGI41, SIGI42, SIGI43, SIGI44, SIGI45, SIGI46, SIGI47, SIGI48, SIGI49, SIGI50,
 SIGI51, SIGI52, SIGI53, SIGI54, SIGI55, SIGI56, SIGI57, SIGI58, SIGI59, SIGI60,
 SIGI61, SIGI62, SIGI63, SIGI64, SIGI65, SIGI66, SIGI67, 
 SIGO01, SIGO02, SIGO03, SIGO04, SIGO05, SIGO06, SIGO07, SIGO08, SIGO09, SIGO10,
 SIGO11, SIGO12, SIGO13, SIGO14, SIGO15, SIGO16, SIGO17, SIGO18, SIGO19, SIGO20,
 SIGO21, SIGO22, SIGO23, SIGO24, SIGO25, SIGO26, SIGO27, SIGO28, SIGO29, SIGO30,
 SIGO31, SIGO32, SIGO33, SIGO34, SIGO35, SIGO36, SIGO37, SIGO38, SIGO39, SIGO40,
 SIGO41, SIGO42, SIGO43, SIGO44, SIGO45, SIGO46, SIGO47, SIGO48, SIGO49, SIGO50, 
 SIGO51, SIGO52, SIGO53, SIGO54, SIGO55, SIGO56, SIGO57 ) ; 

output CLKO01, CLKO02, CLKO03, 
 SIGO01, SIGO02, SIGO03, SIGO04, SIGO05, SIGO06, SIGO07, SIGO08, SIGO09, SIGO10,
 SIGO11, SIGO12, SIGO13, SIGO14, SIGO15, SIGO16, SIGO17, SIGO18, SIGO19, SIGO20,
 SIGO21, SIGO22, SIGO23, SIGO24, SIGO25, SIGO26, SIGO27, SIGO28, SIGO29, SIGO30,
 SIGO31, SIGO32, SIGO33, SIGO34, SIGO35, SIGO36, SIGO37, SIGO38, SIGO39, SIGO40,
 SIGO41, SIGO42, SIGO43, SIGO44, SIGO45, SIGO46, SIGO47, SIGO48, SIGO49, SIGO50,
 SIGO51, SIGO52, SIGO53, SIGO54, SIGO55, SIGO56, SIGO57 ; 

inout ANAI01, CLKI01, CLKI02, CLKI03, CLKI04, CLKI05, CLKI06, 
 SIGI01, SIGI02, SIGI03, SIGI04, SIGI05, SIGI06, SIGI07, SIGI08, SIGI09, SIGI10,
 SIGI11, SIGI12, SIGI13, SIGI14, SIGI15, SIGI16, SIGI17, SIGI18, SIGI19, SIGI20,
 SIGI21, SIGI22, SIGI23, SIGI24, SIGI25, SIGI26, SIGI27, SIGI28, SIGI29, SIGI30,
 SIGI31, SIGI32, SIGI33, SIGI34, SIGI35, SIGI36, SIGI37, SIGI38, SIGI39, SIGI40,
 SIGI41, SIGI42, SIGI43, SIGI44, SIGI45, SIGI46, SIGI47, SIGI48, SIGI49, SIGI50,
 SIGI51, SIGI52, SIGI53, SIGI54, SIGI55, SIGI56, SIGI57, SIGI58, SIGI59, SIGI60,
 SIGI61, SIGI62, SIGI63, SIGI64, SIGI65, SIGI66, SIGI67 ; 

   supply0 GND ;

buf  ( _CLKI01, CLKI01 ) ;
buf  ( _CLKI02, CLKI02 ) ;
buf  ( _CLKI03, CLKI03 ) ;
buf  ( _CLKI04, CLKI04 ) ;
buf  ( _CLKI05, CLKI05 ) ;
buf  ( _CLKI06, CLKI06 ) ;

buf  ( _SIGI01, SIGI01 ) ;
buf  ( _SIGI02, SIGI02 ) ;
buf  ( _SIGI03, SIGI03 ) ;
buf  ( _SIGI04, SIGI04 ) ;
buf  ( _SIGI05, SIGI05 ) ;
buf  ( _SIGI06, SIGI06 ) ;
buf  ( _SIGI07, SIGI07 ) ;
buf  ( _SIGI08, SIGI08 ) ;
buf  ( _SIGI09, SIGI09 ) ;
buf  ( _SIGI10, SIGI10 ) ;
buf  ( _SIGI11, SIGI11 ) ;
buf  ( _SIGI12, SIGI12 ) ;
buf  ( _SIGI13, SIGI13 ) ;
buf  ( _SIGI14, SIGI14 ) ;
buf  ( _SIGI15, SIGI15 ) ;
buf  ( _SIGI16, SIGI16 ) ;
buf  ( _SIGI17, SIGI17 ) ;
buf  ( _SIGI18, SIGI18 ) ;
buf  ( _SIGI19, SIGI19 ) ;
buf  ( _SIGI20, SIGI20 ) ;
buf  ( _SIGI21, SIGI21 ) ;
buf  ( _SIGI22, SIGI22 ) ;
buf  ( _SIGI23, SIGI23 ) ;
buf  ( _SIGI24, SIGI24 ) ;
buf  ( _SIGI25, SIGI25 ) ;
buf  ( _SIGI26, SIGI26 ) ;
buf  ( _SIGI27, SIGI27 ) ;
buf  ( _SIGI28, SIGI28 ) ;
buf  ( _SIGI29, SIGI29 ) ;
buf  ( _SIGI30, SIGI30 ) ;
buf  ( _SIGI31, SIGI31 ) ;
buf  ( _SIGI32, SIGI32 ) ;
buf  ( _SIGI33, SIGI33 ) ;
buf  ( _SIGI34, SIGI34 ) ;
buf  ( _SIGI35, SIGI35 ) ;
buf  ( _SIGI36, SIGI36 ) ;
buf  ( _SIGI37, SIGI37 ) ;
buf  ( _SIGI38, SIGI38 ) ;
buf  ( _SIGI39, SIGI39 ) ;
buf  ( _SIGI40, SIGI40 ) ;
buf  ( _SIGI41, SIGI41 ) ;
buf  ( _SIGI42, SIGI42 ) ;
buf  ( _SIGI43, SIGI43 ) ;
buf  ( _SIGI44, SIGI44 ) ;
buf  ( _SIGI45, SIGI45 ) ;
buf  ( _SIGI46, SIGI46 ) ;
buf  ( _SIGI47, SIGI47 ) ;
buf  ( _SIGI48, SIGI48 ) ;
buf  ( _SIGI49, SIGI49 ) ;
buf  ( _SIGI50, SIGI50 ) ;
buf  ( _SIGI51, SIGI51 ) ;
buf  ( _SIGI52, SIGI52 ) ;
buf  ( _SIGI53, SIGI53 ) ;
buf  ( _SIGI54, SIGI54 ) ;
buf  ( _SIGI55, SIGI55 ) ;
buf  ( _SIGI56, SIGI56 ) ;
buf  ( _SIGI57, SIGI57 ) ;
buf  ( _SIGI58, SIGI58 ) ;
buf  ( _SIGI59, SIGI59 ) ;
buf  ( _SIGI60, SIGI60 ) ;
buf  ( _SIGI61, SIGI61 ) ;
buf  ( _SIGI62, SIGI62 ) ;
buf  ( _SIGI63, SIGI63 ) ;
buf  ( _SIGI64, SIGI64 ) ;
buf  ( _SIGI65, SIGI65 ) ;
buf  ( _SIGI66, SIGI66 ) ;
buf  ( _SIGI67, SIGI67 ) ;




buf  ( CLKO01, GND ) ;
buf  ( CLKO02, GND ) ;
buf  ( CLKO03, GND ) ;
buf  ( SIGO01, GND ) ;
buf  ( SIGO02, GND ) ;
buf  ( SIGO03, GND ) ;
buf  ( SIGO04, GND ) ;
buf  ( SIGO05, GND ) ;
buf  ( SIGO06, GND ) ;
buf  ( SIGO07, GND ) ;
buf  ( SIGO08, GND ) ;
buf  ( SIGO09, GND ) ;
buf  ( SIGO10, GND ) ;
buf  ( SIGO11, GND ) ;
buf  ( SIGO12, GND ) ;
buf  ( SIGO13, GND ) ;
buf  ( SIGO14, GND ) ;
buf  ( SIGO15, GND ) ;
buf  ( SIGO16, GND ) ;
buf  ( SIGO17, GND ) ;
buf  ( SIGO18, GND ) ;
buf  ( SIGO19, GND ) ;
buf  ( SIGO20, GND ) ;
buf  ( SIGO21, GND ) ;
buf  ( SIGO22, GND ) ;
buf  ( SIGO23, GND ) ;
buf  ( SIGO24, GND ) ;
buf  ( SIGO25, GND ) ;
buf  ( SIGO26, GND ) ;
buf  ( SIGO27, GND ) ;
buf  ( SIGO28, GND ) ;
buf  ( SIGO29, GND ) ;
buf  ( SIGO30, GND ) ;
buf  ( SIGO31, GND ) ;
buf  ( SIGO32, GND ) ;
buf  ( SIGO33, GND ) ;
buf  ( SIGO34, GND ) ;
buf  ( SIGO35, GND ) ;
buf  ( SIGO36, GND ) ;
buf  ( SIGO37, GND ) ;
buf  ( SIGO38, GND ) ;
buf  ( SIGO39, GND ) ;
buf  ( SIGO40, GND ) ;
buf  ( SIGO41, GND ) ;
buf  ( SIGO42, GND ) ;
buf  ( SIGO43, GND ) ;
buf  ( SIGO44, GND ) ;
buf  ( SIGO45, GND ) ;
buf  ( SIGO46, GND ) ;
buf  ( SIGO47, GND ) ;
buf  ( SIGO48, GND ) ;
buf  ( SIGO49, GND ) ;
buf  ( SIGO50, GND ) ;
buf  ( SIGO51, GND ) ;
buf  ( SIGO52, GND ) ;
buf  ( SIGO53, GND ) ;
buf  ( SIGO54, GND ) ;
buf  ( SIGO55, GND ) ;
buf  ( SIGO56, GND ) ;
buf  ( SIGO57, GND ) ;




endmodule
`ifdef verifault
    `nosuppress_faults
    `disable_portfaults
`endif
`endcelldefine

/**  HISTORY  *******************************/
/*                                          */
/*  V0.10   1st release                     */
/*  V1.00   2nd release                     */
/*          input pin -> inout pin          */
/*  V1.10   3rd release                     */
/*          remove  pins.                   */
/*                                          */
/********************************************/
