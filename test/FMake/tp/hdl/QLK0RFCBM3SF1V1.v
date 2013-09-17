// [RENESAS Group CONFIDENTIAL]
// Copyright (C) 2010 Renesas Electronics Corporation 
// All Rights Reserved. Do not duplicate without prior written
// consent of Renesas Electronics Corporation.
//
// Macro Name      : QLK0RFCBM3SF1V1
// Version         : 1.20
// Date            : 2010.08.17
// Author          : Hiroki Masaoka (hiroki.masaoka@necel.com)
// History         : 1.10 Fix bugs as FCLK2,MRG12,STDWAIT from 1.00
//                 :      Modify for SpyGlass Error from 1.10
//                 :      BEU control, CWEE, FSCTL control 
//                 : 1.20 enhanced safty feature 
//
//  file name   ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/top.hdl
//  module name ... QLK0RFCBM3SF1V1
//  version     ... 1.2
//  designer    ... H.Masaoka
//  refer to    ... ./top_top


module	QLK0RFCBM3SF1V1      ( TESTMOD          , BTBLS1           , BTBLS0           , FSWE9            , 
      	                       FSWE8            , FSWE7            , FSWE6            , FSWE5            , 
      	                       FSWE4            , FSWE3            , FSWE2            , FSWE1            , 
      	                       FSWE0            , FSWS9            , FSWS8            , FSWS7            , 
      	                       FSWS6            , FSWS5            , FSWS4            , FSWS3            , 
      	                       FSWS2            , FSWS1            , FSWS0            , FLSPM            , 
      	                       EEEMD            , LOWSPY           , CWEE             , SCANMODE         , 
      	                       EXCHEN           , SECEN            , FSWEN            , FPSER2           , 
      	                       FPSER1           , FPSER0           , FPWWR2           , FPWWR1           , 
      	                       FPWWR0           , FPWRTY7          , FPWRTY6          , FPWRTY5          , 
      	                       FPWRTY4          , FPWRTY3          , FPWRTY2          , FPWRTY1          , 
      	                       FPWRTY0          , FPERTY7          , FPERTY6          , FPERTY5          , 
      	                       FPERTY4          , FPERTY3          , FPERTY2          , FPERTY1          , 
      	                       FPERTY0          , FPECC3           , FPECC2           , FPECC1           , 
      	                       FPECC0           , CECCE            , DECCE            , INTFL            , 
      	                       STDWAIT          , TMBTSEL          , TMSPMD           , EXCH             , 
      	                       FSPR             , RDPR             , WRPR             , CEPR             , 
      	                       SEPR             , BTPR             , BTFLG            , DDIS             , 
      	                       DREAD            , DMRG00           , DMRG01           , DMRG10           , 
      	                       DMRG11           , DMRG12           , DSER             , DWWR             , 
      	                       DCER             , PSEL2            , PSEL1            , PADDR4           , 
      	                       PADDR3           , PADDR2           , PADDR1           , PADDR0           , 
      	                       PWDATA15         , PWDATA14         , PWDATA13         , PWDATA12         , 
      	                       PWDATA11         , PWDATA10         , PWDATA9          , PWDATA8          , 
      	                       PWDATA7          , PWDATA6          , PWDATA5          , PWDATA4          , 
      	                       PWDATA3          , PWDATA2          , PWDATA1          , PWDATA0          , 
      	                       PRDATA15         , PRDATA14         , PRDATA13         , PRDATA12         , 
      	                       PRDATA11         , PRDATA10         , PRDATA9          , PRDATA8          , 
      	                       PRDATA7          , PRDATA6          , PRDATA5          , PRDATA4          , 
      	                       PRDATA3          , PRDATA2          , PRDATA1          , PRDATA0          , 
      	                       PWRITE           , PRESETZ          , PENABLE          , FLMEMTES         , 
      	                       DIS              , READ             , MRG00            , MRG01            , 
      	                       MRG10            , MRG11            , MRG12            , WWR              , 
      	                       MSWR             , CER              , SER              , EXER             , 
      	                       STCHK            , IONCHK1          , RDT              , RDMRG1           , 
      	                       RDMRG0           , RDMRGC           , WDT1             , WDT2             , 
      	                       WDT3             , WDT4             , CPBT             , SACEEN           , 
      	                       IREFT            , CPT              , EXTVPP2          , EXTVPP1          , 
      	                       MEOC             , MEOR             , BEU2             , BEU1             , 
      	                       BEU0             , MODIDIS          , TFWEPR           , EXA              , 
      	                       WED              , DWED             , ONBD             , DFLRO11          , 
      	                       DFLRO10          , DFLRO9           , DFLRO8           , DFLRO7           , 
      	                       DFLRO6           , DFLRO5           , DFLRO4           , DFLRO3           , 
      	                       DFLRO2           , DFLRO1           , DFLRO0           , FLRO37           , 
      	                       FLRO36           , FLRO35           , FLRO34           , FLRO33           , 
      	                       FLRO32           , FLRO31           , FLRO30           , FLRO29           , 
      	                       FLRO28           , FLRO27           , FLRO26           , FLRO25           , 
      	                       FLRO24           , FLRO23           , FLRO22           , FLRO21           , 
      	                       FLRO20           , FLRO19           , FLRO18           , FLRO17           , 
      	                       FLRO16           , FLRO15           , FLRO14           , FLRO13           , 
      	                       FLRO12           , FLRO11           , FLRO10           , FLRO9            , 
      	                       FLRO8            , FLRO7            , FLRO6            , FLRO5            , 
      	                       FLRO4            , FLRO3            , FLRO2            , FLRO1            , 
      	                       FLRO0            , DW37             , DW36             , DW35             , 
      	                       DW34             , DW33             , DW32             , DW31             , 
      	                       DW30             , DW29             , DW28             , DW27             , 
      	                       DW26             , DW25             , DW24             , DW23             , 
      	                       DW22             , DW21             , DW20             , DW19             , 
      	                       DW18             , DW17             , DW16             , DW15             , 
      	                       DW14             , DW13             , DW12             , DW11             , 
      	                       DW10             , DW9              , DW8              , DW7              , 
      	                       DW6              , DW5              , DW4              , DW3              , 
      	                       DW2              , DW1              , DW0              , FCLK1            , 
      	                       FCLK2            , RDCLKP1          , PROGI            , AF19             , 
      	                       AF18             , AF17             , AF16             , AF15             , 
      	                       AF14             , AF13             , AF12             , AF11             , 
      	                       AF10             , AF9              , AF8              , AF7              , 
      	                       AF6              , AF5              , AF4              , AF3              , 
      	                       AF2              , AF1              , AF0              , SSEQBRK          , 
      	                       ICENOECC         , ICEFLERR         , MUTEST           , PCLK             , 
      	                       VCEQ             ) ;

    input	        	  TESTMOD ;
    input	        	  BTBLS1 ;
    input	        	  BTBLS0 ;
    output	        	  FSWE9 ;
    output	        	  FSWE8 ;
    output	        	  FSWE7 ;
    output	        	  FSWE6 ;
    output	        	  FSWE5 ;
    output	        	  FSWE4 ;
    output	        	  FSWE3 ;
    output	        	  FSWE2 ;
    output	        	  FSWE1 ;
    output	        	  FSWE0 ;
    output	        	  FSWS9 ;
    output	        	  FSWS8 ;
    output	        	  FSWS7 ;
    output	        	  FSWS6 ;
    output	        	  FSWS5 ;
    output	        	  FSWS4 ;
    output	        	  FSWS3 ;
    output	        	  FSWS2 ;
    output	        	  FSWS1 ;
    output	        	  FSWS0 ;
    output	        	  FLSPM ;
    output	        	  EEEMD ;
    output	        	  LOWSPY ;
    output	        	  CWEE ;
    input	        	  SCANMODE ;
    input	        	  EXCHEN ;
    input	        	  SECEN ;
    input	        	  FSWEN ;
    input	        	  FPSER2 ;
    input	        	  FPSER1 ;
    input	        	  FPSER0 ;
    input	        	  FPWWR2 ;
    input	        	  FPWWR1 ;
    input	        	  FPWWR0 ;
    input	        	  FPWRTY7 ;
    input	        	  FPWRTY6 ;
    input	        	  FPWRTY5 ;
    input	        	  FPWRTY4 ;
    input	        	  FPWRTY3 ;
    input	        	  FPWRTY2 ;
    input	        	  FPWRTY1 ;
    input	        	  FPWRTY0 ;
    input	        	  FPERTY7 ;
    input	        	  FPERTY6 ;
    input	        	  FPERTY5 ;
    input	        	  FPERTY4 ;
    input	        	  FPERTY3 ;
    input	        	  FPERTY2 ;
    input	        	  FPERTY1 ;
    input	        	  FPERTY0 ;
    input	        	  FPECC3 ;
    input	        	  FPECC2 ;
    input	        	  FPECC1 ;
    input	        	  FPECC0 ;
    output	        	  CECCE ;
    output	        	  DECCE ;
    output	        	  INTFL ;
    output	        	  STDWAIT ;
    output	        	  TMBTSEL ;
    output	        	  TMSPMD ;
    output	        	  EXCH ;
    output	        	  FSPR ;
    output	        	  RDPR ;
    output	        	  WRPR ;
    output	        	  CEPR ;
    output	        	  SEPR ;
    output	        	  BTPR ;
    output	        	  BTFLG ;
    output	        	  DDIS ;
    output	        	  DREAD ;
    output	        	  DMRG00 ;
    output	        	  DMRG01 ;
    output	        	  DMRG10 ;
    output	        	  DMRG11 ;
    output	        	  DMRG12 ;
    output	        	  DSER ;
    output	        	  DWWR ;
    output	        	  DCER ;
    input	        	  PSEL2 ;
    input	        	  PSEL1 ;
    input	        	  PADDR4 ;
    input	        	  PADDR3 ;
    input	        	  PADDR2 ;
    input	        	  PADDR1 ;
    input	        	  PADDR0 ;
    input	        	  PWDATA15 ;
    input	        	  PWDATA14 ;
    input	        	  PWDATA13 ;
    input	        	  PWDATA12 ;
    input	        	  PWDATA11 ;
    input	        	  PWDATA10 ;
    input	        	  PWDATA9 ;
    input	        	  PWDATA8 ;
    input	        	  PWDATA7 ;
    input	        	  PWDATA6 ;
    input	        	  PWDATA5 ;
    input	        	  PWDATA4 ;
    input	        	  PWDATA3 ;
    input	        	  PWDATA2 ;
    input	        	  PWDATA1 ;
    input	        	  PWDATA0 ;
    output	        	  PRDATA15 ;
    output	        	  PRDATA14 ;
    output	        	  PRDATA13 ;
    output	        	  PRDATA12 ;
    output	        	  PRDATA11 ;
    output	        	  PRDATA10 ;
    output	        	  PRDATA9 ;
    output	        	  PRDATA8 ;
    output	        	  PRDATA7 ;
    output	        	  PRDATA6 ;
    output	        	  PRDATA5 ;
    output	        	  PRDATA4 ;
    output	        	  PRDATA3 ;
    output	        	  PRDATA2 ;
    output	        	  PRDATA1 ;
    output	        	  PRDATA0 ;
    input	        	  PWRITE ;
    input	        	  PRESETZ ;
    input	        	  PENABLE ;
    input	        	  FLMEMTES ;
    output	        	  DIS ;
    output	        	  READ ;
    output	        	  MRG00 ;
    output	        	  MRG01 ;
    output	        	  MRG10 ;
    output	        	  MRG11 ;
    output	        	  MRG12 ;
    output	        	  WWR ;
    output	        	  MSWR ;
    output	        	  CER ;
    output	        	  SER ;
    output	        	  EXER ;
    output	        	  STCHK ;
    output	        	  IONCHK1 ;
    output	        	  RDT ;
    output	        	  RDMRG1 ;
    output	        	  RDMRG0 ;
    output	        	  RDMRGC ;
    output	        	  WDT1 ;
    output	        	  WDT2 ;
    output	        	  WDT3 ;
    output	        	  WDT4 ;
    output	        	  CPBT ;
    output	        	  SACEEN ;
    output	        	  IREFT ;
    output	        	  CPT ;
    output	        	  EXTVPP2 ;
    output	        	  EXTVPP1 ;
    output	        	  MEOC ;
    output	        	  MEOR ;
    output	        	  BEU2 ;
    output	        	  BEU1 ;
    output	        	  BEU0 ;
    output	        	  MODIDIS ;
    input	        	  TFWEPR ;
    output	        	  EXA ;
    output	        	  WED ;
    output	        	  DWED ;
    input	        	  ONBD ;
    input	        	  DFLRO11 ;
    input	        	  DFLRO10 ;
    input	        	  DFLRO9 ;
    input	        	  DFLRO8 ;
    input	        	  DFLRO7 ;
    input	        	  DFLRO6 ;
    input	        	  DFLRO5 ;
    input	        	  DFLRO4 ;
    input	        	  DFLRO3 ;
    input	        	  DFLRO2 ;
    input	        	  DFLRO1 ;
    input	        	  DFLRO0 ;
    input	        	  FLRO37 ;
    input	        	  FLRO36 ;
    input	        	  FLRO35 ;
    input	        	  FLRO34 ;
    input	        	  FLRO33 ;
    input	        	  FLRO32 ;
    input	        	  FLRO31 ;
    input	        	  FLRO30 ;
    input	        	  FLRO29 ;
    input	        	  FLRO28 ;
    input	        	  FLRO27 ;
    input	        	  FLRO26 ;
    input	        	  FLRO25 ;
    input	        	  FLRO24 ;
    input	        	  FLRO23 ;
    input	        	  FLRO22 ;
    input	        	  FLRO21 ;
    input	        	  FLRO20 ;
    input	        	  FLRO19 ;
    input	        	  FLRO18 ;
    input	        	  FLRO17 ;
    input	        	  FLRO16 ;
    input	        	  FLRO15 ;
    input	        	  FLRO14 ;
    input	        	  FLRO13 ;
    input	        	  FLRO12 ;
    input	        	  FLRO11 ;
    input	        	  FLRO10 ;
    input	        	  FLRO9 ;
    input	        	  FLRO8 ;
    input	        	  FLRO7 ;
    input	        	  FLRO6 ;
    input	        	  FLRO5 ;
    input	        	  FLRO4 ;
    input	        	  FLRO3 ;
    input	        	  FLRO2 ;
    input	        	  FLRO1 ;
    input	        	  FLRO0 ;
    output	        	  DW37 ;
    output	        	  DW36 ;
    output	        	  DW35 ;
    output	        	  DW34 ;
    output	        	  DW33 ;
    output	        	  DW32 ;
    output	        	  DW31 ;
    output	        	  DW30 ;
    output	        	  DW29 ;
    output	        	  DW28 ;
    output	        	  DW27 ;
    output	        	  DW26 ;
    output	        	  DW25 ;
    output	        	  DW24 ;
    output	        	  DW23 ;
    output	        	  DW22 ;
    output	        	  DW21 ;
    output	        	  DW20 ;
    output	        	  DW19 ;
    output	        	  DW18 ;
    output	        	  DW17 ;
    output	        	  DW16 ;
    output	        	  DW15 ;
    output	        	  DW14 ;
    output	        	  DW13 ;
    output	        	  DW12 ;
    output	        	  DW11 ;
    output	        	  DW10 ;
    output	        	  DW9 ;
    output	        	  DW8 ;
    output	        	  DW7 ;
    output	        	  DW6 ;
    output	        	  DW5 ;
    output	        	  DW4 ;
    output	        	  DW3 ;
    output	        	  DW2 ;
    output	        	  DW1 ;
    output	        	  DW0 ;
    output	        	  FCLK1 ;
    output	        	  FCLK2 ;
    output	        	  RDCLKP1 ;
    output	        	  PROGI ;
    output	        	  AF19 ;
    output	        	  AF18 ;
    output	        	  AF17 ;
    output	        	  AF16 ;
    output	        	  AF15 ;
    output	        	  AF14 ;
    output	        	  AF13 ;
    output	        	  AF12 ;
    output	        	  AF11 ;
    output	        	  AF10 ;
    output	        	  AF9 ;
    output	        	  AF8 ;
    output	        	  AF7 ;
    output	        	  AF6 ;
    output	        	  AF5 ;
    output	        	  AF4 ;
    output	        	  AF3 ;
    output	        	  AF2 ;
    output	        	  AF1 ;
    output	        	  AF0 ;
    input	        	  SSEQBRK ;
    input	        	  ICENOECC ;
    input	        	  ICEFLERR ;
    output	        	  MUTEST ;
    input	        	  PCLK ;
    output	        	  VCEQ ;

    wire		          AF0 ;
    wire		          AF1 ;
    wire		          AF10 ;
    wire		          AF11 ;
    wire		          AF12 ;
    wire		          AF13 ;
    wire		          AF14 ;
    wire		          AF15 ;
    wire		          AF16 ;
    wire		          AF17 ;
    wire		          AF18 ;
    wire		          AF19 ;
    wire		          AF2 ;
    wire		          AF3 ;
    wire		          AF4 ;
    wire		          AF5 ;
    wire		          AF6 ;
    wire		          AF7 ;
    wire		          AF8 ;
    wire		          AF9 ;
    wire		          BEU0 ;
    wire		          BEU1 ;
    wire		          BEU2 ;
    wire		          BTBLS0 ;
    wire		          BTBLS1 ;
    wire		          BTFLG ;
    wire		          BTPR ;
    wire		          CECCE ;
    wire		          CEPR ;
    wire		          CER ;
    wire		          CPBT ;
    wire		          CPT ;
    wire		          CWEE ;
    wire		          DCER ;
    wire		          DDIS ;
    wire		          DECCE ;
    wire		          DFLRO0 ;
    wire		          DFLRO1 ;
    wire		          DFLRO10 ;
    wire		          DFLRO11 ;
    wire		          DFLRO2 ;
    wire		          DFLRO3 ;
    wire		          DFLRO4 ;
    wire		          DFLRO5 ;
    wire		          DFLRO6 ;
    wire		          DFLRO7 ;
    wire		          DFLRO8 ;
    wire		          DFLRO9 ;
    wire		          DIS ;
    wire		          DMRG00 ;
    wire		          DMRG01 ;
    wire		          DMRG10 ;
    wire		          DMRG11 ;
    wire		          DMRG12 ;
    wire		          DREAD ;
    wire		          DSER ;
    wire		          DW0 ;
    wire		          DW1 ;
    wire		          DW10 ;
    wire		          DW11 ;
    wire		          DW12 ;
    wire		          DW13 ;
    wire		          DW14 ;
    wire		          DW15 ;
    wire		          DW16 ;
    wire		          DW17 ;
    wire		          DW18 ;
    wire		          DW19 ;
    wire		          DW2 ;
    wire		          DW20 ;
    wire		          DW21 ;
    wire		          DW22 ;
    wire		          DW23 ;
    wire		          DW24 ;
    wire		          DW25 ;
    wire		          DW26 ;
    wire		          DW27 ;
    wire		          DW28 ;
    wire		          DW29 ;
    wire		          DW3 ;
    wire		          DW30 ;
    wire		          DW31 ;
    wire		          DW32 ;
    wire		          DW33 ;
    wire		          DW34 ;
    wire		          DW35 ;
    wire		          DW36 ;
    wire		          DW37 ;
    wire		          DW4 ;
    wire		          DW5 ;
    wire		          DW6 ;
    wire		          DW7 ;
    wire		          DW8 ;
    wire		          DW9 ;
    wire		          DWED ;
    wire		          DWWR ;
    wire		          EEEMD ;
    wire		          EXA ;
    wire		          EXCH ;
    wire		          EXCHEN ;
    wire		          EXER ;
    wire		          EXTVPP1 ;
    wire		          EXTVPP2 ;
    wire		          FCLK1 ;
    wire		          FCLK2 ;
    wire		          FLMEMTES ;
    wire		          FLRO0 ;
    wire		          FLRO1 ;
    wire		          FLRO10 ;
    wire		          FLRO11 ;
    wire		          FLRO12 ;
    wire		          FLRO13 ;
    wire		          FLRO14 ;
    wire		          FLRO15 ;
    wire		          FLRO16 ;
    wire		          FLRO17 ;
    wire		          FLRO18 ;
    wire		          FLRO19 ;
    wire		          FLRO2 ;
    wire		          FLRO20 ;
    wire		          FLRO21 ;
    wire		          FLRO22 ;
    wire		          FLRO23 ;
    wire		          FLRO24 ;
    wire		          FLRO25 ;
    wire		          FLRO26 ;
    wire		          FLRO27 ;
    wire		          FLRO28 ;
    wire		          FLRO29 ;
    wire		          FLRO3 ;
    wire		          FLRO30 ;
    wire		          FLRO31 ;
    wire		          FLRO32 ;
    wire		          FLRO33 ;
    wire		          FLRO34 ;
    wire		          FLRO35 ;
    wire		          FLRO36 ;
    wire		          FLRO37 ;
    wire		          FLRO4 ;
    wire		          FLRO5 ;
    wire		          FLRO6 ;
    wire		          FLRO7 ;
    wire		          FLRO8 ;
    wire		          FLRO9 ;
    wire		          FLSPM ;
    wire		          FPECC0 ;
    wire		          FPECC1 ;
    wire		          FPECC2 ;
    wire		          FPECC3 ;
    wire		          FPERTY0 ;
    wire		          FPERTY1 ;
    wire		          FPERTY2 ;
    wire		          FPERTY3 ;
    wire		          FPERTY4 ;
    wire		          FPERTY5 ;
    wire		          FPERTY6 ;
    wire		          FPERTY7 ;
    wire		          FPSER0 ;
    wire		          FPSER1 ;
    wire		          FPSER2 ;
    wire		          FPWRTY0 ;
    wire		          FPWRTY1 ;
    wire		          FPWRTY2 ;
    wire		          FPWRTY3 ;
    wire		          FPWRTY4 ;
    wire		          FPWRTY5 ;
    wire		          FPWRTY6 ;
    wire		          FPWRTY7 ;
    wire		          FPWWR0 ;
    wire		          FPWWR1 ;
    wire		          FPWWR2 ;
    wire		          FSPR ;
    wire		          FSWE0 ;
    wire		          FSWE1 ;
    wire		          FSWE2 ;
    wire		          FSWE3 ;
    wire		          FSWE4 ;
    wire		          FSWE5 ;
    wire		          FSWE6 ;
    wire		          FSWE7 ;
    wire		          FSWE8 ;
    wire		          FSWE9 ;
    wire		          FSWEN ;
    wire		          FSWS0 ;
    wire		          FSWS1 ;
    wire		          FSWS2 ;
    wire		          FSWS3 ;
    wire		          FSWS4 ;
    wire		          FSWS5 ;
    wire		          FSWS6 ;
    wire		          FSWS7 ;
    wire		          FSWS8 ;
    wire		          FSWS9 ;
    wire		          ICEFLERR ;
    wire		          ICENOECC ;
    wire		          INTFL ;
    wire		          IONCHK1 ;
    wire		          IREFT ;
    wire		          LOWSPY ;
    wire		          MEOC ;
    wire		          MEOR ;
    wire		          MODIDIS ;
    wire		          MRG00 ;
    wire		          MRG01 ;
    wire		          MRG10 ;
    wire		          MRG11 ;
    wire		          MRG12 ;
    wire		          MSWR ;
    wire		          MUTEST ;
    wire		          ONBD ;
    wire		          PADDR0 ;
    wire		          PADDR1 ;
    wire		          PADDR2 ;
    wire		          PADDR3 ;
    wire		          PADDR4 ;
    wire		          PCLK ;
    wire		          PENABLE ;
    wire		          PRDATA0 ;
    wire		          PRDATA1 ;
    wire		          PRDATA10 ;
    wire		          PRDATA11 ;
    wire		          PRDATA12 ;
    wire		          PRDATA13 ;
    wire		          PRDATA14 ;
    wire		          PRDATA15 ;
    wire		          PRDATA2 ;
    wire		          PRDATA3 ;
    wire		          PRDATA4 ;
    wire		          PRDATA5 ;
    wire		          PRDATA6 ;
    wire		          PRDATA7 ;
    wire		          PRDATA8 ;
    wire		          PRDATA9 ;
    wire		          PRESETZ ;
    wire		          PROGI ;
    wire		          PSEL1 ;
    wire		          PSEL2 ;
    wire		          PWDATA0 ;
    wire		          PWDATA1 ;
    wire		          PWDATA10 ;
    wire		          PWDATA11 ;
    wire		          PWDATA12 ;
    wire		          PWDATA13 ;
    wire		          PWDATA14 ;
    wire		          PWDATA15 ;
    wire		          PWDATA2 ;
    wire		          PWDATA3 ;
    wire		          PWDATA4 ;
    wire		          PWDATA5 ;
    wire		          PWDATA6 ;
    wire		          PWDATA7 ;
    wire		          PWDATA8 ;
    wire		          PWDATA9 ;
    wire		          PWRITE ;
    wire		          RDCLKP1 ;
    wire		          RDMRG0 ;
    wire		          RDMRG1 ;
    wire		          RDMRGC ;
    wire		          RDPR ;
    wire		          RDT ;
    wire		          READ ;
    wire		          SACEEN ;
    wire		          SCANMODE ;
    wire		          SECEN ;
    wire		          SEPR ;
    wire		          SER ;
    wire		          SSEQBRK ;
    wire		          STCHK ;
    wire		          STDWAIT ;
    wire		          TESTMOD ;
    wire		          TFWEPR ;
    wire		          TMBTSEL ;
    wire		          TMSPMD ;
    wire		          VCEQ ;
    wire		          WDT1 ;
    wire		          WDT2 ;
    wire		          WDT3 ;
    wire		          WDT4 ;
    wire		          WED ;
    wire		          WRPR ;
    wire		          WWR ;
    wire		          act1 ;
    wire		          afsel ;
    wire	[19:0]	          aluout ;
    wire		          bler ;
    wire		          ceren ;
    wire		          cerin ;
    wire	[8:0]	          count10us ;
    wire	[4:0]	          count1us ;
    wire	[9:0]	          count20us ;
    wire	[5:0]	          count2us ;
    wire	[6:0]	          count3us ;
    wire	[10:0]	          count40us ;
    wire	[21:0]	          countend ;
    wire	[21:0]	          counterase ;
    wire	[10:0]	          countwrite ;
    wire		          dceren ;
    wire		          dcerin ;
    wire		          dclr ;
    wire		          ddisen ;
    wire		          ddisin ;
    wire	[31:0]	          din_escb ;
    wire		          disen ;
    wire		          disin ;
    wire		          dmrg00en ;
    wire		          dmrg00in ;
    wire		          dmrg01en ;
    wire		          dmrg01in ;
    wire		          dmrg10en ;
    wire		          dmrg10in ;
    wire		          dmrg11en ;
    wire		          dmrg11in ;
    wire		          dmrg12en ;
    wire		          dmrg12in ;
    wire		          dreaden ;
    wire		          dreadin ;
    wire		          drreq ;
    wire		          dseren ;
    wire		          dserin ;
    wire		          dseten ;
    wire		          dwwren ;
    wire		          dwwrin ;
    wire		          eq ;
    wire		          eqact ;
    wire		          erer ;
    wire		          eseqer ;
    wire		          esqend ;
    wire		          esqmd0 ;
    wire		          esqmd1 ;
    wire		          esqmd2 ;
    wire		          esqst ;
    wire		          exchen_escb ;
    wire		          fclk2in ;
    wire		          fclkin ;
    wire	[3:0]	          flaph ;
    wire	[7:0]	          flaplh ;
    wire	[7:0]	          flapll ;
    wire		          flapsel ;
    wire	[5:0]	          flre ;
    wire	[7:0]	          flrhh ;
    wire	[7:0]	          flrhl ;
    wire	[7:0]	          flrlh ;
    wire	[7:0]	          flrll ;
    wire		          flrst ;
    wire	[3:0]	          flsedh ;
    wire	[7:0]	          flsedlh ;
    wire	[7:0]	          flsedll ;
    wire	[5:0]	          flwe ;
    wire	[7:0]	          flwhh ;
    wire	[7:0]	          flwhl ;
    wire	[7:0]	          flwlh ;
    wire	[7:0]	          flwll ;
    wire		          fprerr ;
    wire		          fset0 ;
    wire		          fset1 ;
    wire		          fset2 ;
    wire		          fset3 ;
    wire		          fset4 ;
    wire		          fsstp ;
    wire		          fswen_escb ;
    wire		          fwedis ;
    wire		          iv ;
    wire		          iv_ecc ;
    wire		          iver ;
    wire		          lowspy_mscb ;
    wire		          mdch ;
    wire		          mopen ;
    wire		          mrg00en ;
    wire		          mrg00in ;
    wire		          mrg01en ;
    wire		          mrg01in ;
    wire		          mrg10en ;
    wire		          mrg10in ;
    wire		          mrg11en ;
    wire		          mrg11in ;
    wire		          mrg12en ;
    wire		          mrg12in ;
    wire	[1:0]	          ope ;
    wire		          p_seqer ;
    wire		          progin ;
    wire		          rdclkp1in ;
    wire		          readen ;
    wire		          readin ;
    wire		          safen ;
    wire		          sdrdclken ;
    wire		          secen_escb ;
    wire		          sel_dflmch ;
    wire		          sel_dflmcl ;
    wire		          sel_flaph ;
    wire		          sel_flaplh ;
    wire		          sel_flapll ;
    wire		          sel_flars ;
    wire		          sel_flfadh ;
    wire		          sel_flfadlh ;
    wire		          sel_flfadll ;
    wire		          sel_flfsweh ;
    wire		          sel_flfswel ;
    wire		          sel_flfswsh ;
    wire		          sel_flfswsl ;
    wire		          sel_flmch ;
    wire		          sel_flmclh ;
    wire		          sel_flmcll ;
    wire		          sel_flpmc ;
    wire		          sel_flre ;
    wire		          sel_flrhh ;
    wire		          sel_flrhl ;
    wire		          sel_flrlh ;
    wire		          sel_flrll ;
    wire		          sel_flrst ;
    wire		          sel_flsech ;
    wire		          sel_flsedh ;
    wire		          sel_flsedlh ;
    wire		          sel_flsedll ;
    wire		          sel_fltmsh ;
    wire		          sel_fltmsl ;
    wire		          sel_flwe ;
    wire		          sel_flwhh ;
    wire		          sel_flwhl ;
    wire		          sel_flwlh ;
    wire		          sel_flwll ;
    wire		          sel_fsasth ;
    wire		          sel_fsastl ;
    wire		          sel_fsctl ;
    wire		          sel_fsse ;
    wire		          sel_fsset ;
    wire		          sel_fssql ;
    wire		          sel_pfcmd ;
    wire		          sel_pfs ;
    wire		          seldfl ;
    wire		          seqer ;
    wire		          seren ;
    wire		          serin ;
    wire		          sfclk2en ;
    wire		          sfclken ;
    wire		          sflren ;
    wire		          sflw1en ;
    wire		          sflwen ;
    wire		          sinafen ;
    wire		          sprogien ;
    wire		          sqend ;
    wire		          sqmd0 ;
    wire		          sqmd1 ;
    wire		          sqmd2 ;
    wire		          sqst ;
    wire		          tcwee ;
    wire		          tesman ;
    wire		          tlowspy ;
    wire		          we_dflmch ;
    wire		          we_dflmcl ;
    wire		          we_flap_escb ;
    wire		          we_flaph ;
    wire		          we_flaplh ;
    wire		          we_flapll ;
    wire		          we_flars ;
    wire		          we_flars_escb ;
    wire		          we_flmch ;
    wire		          we_flmcl ;
    wire		          we_flpmc ;
    wire		          we_flrst ;
    wire		          we_flsed_escb ;
    wire		          we_flsedh ;
    wire		          we_flsedlh ;
    wire		          we_flsedll ;
    wire		          we_fltmsh ;
    wire		          we_fltmsl ;
    wire		          we_flw_escb ;
    wire		          we_flwe ;
    wire		          we_flwe_escb ;
    wire		          we_flwhh ;
    wire		          we_flwhl ;
    wire		          we_flwlh ;
    wire		          we_flwll ;
    wire		          we_fsctl ;
    wire		          we_fsse ;
    wire		          we_fsset ;
    wire		          we_fssq_escb ;
    wire		          we_fssql ;
    wire		          wrer ;
    wire		          wwren ;
    wire		          wwrin ;
    wire		          xregclr ;
    wire		          xregen ;
    wire		          xregld ;
    wire	[1:0]	          yregdin ;
    wire		          yregen ;
    wire		          zregen ;
    wire		          zregoe ;



    //  refer to ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/_parts/qlk0rfcbm3sf1v1_apbif.hdl

    QLK0RFCBM3SF1V1_APBIF  	apbif ( 
		.eeemd ( EEEMD )         , .flmemtes ( FLMEMTES )   , .flspm ( FLSPM )         , .fwedis ( fwedis )       ,
		.paddr0 ( PADDR0 )       , .paddr1 ( PADDR1 )       , .paddr2 ( PADDR2 )       , .paddr3 ( PADDR3 )       ,
		.paddr4 ( PADDR4 )       , .penable ( PENABLE )     , .psel1 ( PSEL1 )         , .psel2 ( PSEL2 )         ,
		.pwrite ( PWRITE )       , .sel_dflmch ( sel_dflmch )                          , 
		.sel_dflmcl ( sel_dflmcl )                          , .sel_flaph ( sel_flaph ) , 
		.sel_flaplh ( sel_flaplh )                          , .sel_flapll ( sel_flapll )                          ,
		.sel_flars ( sel_flars ) , .sel_flfadh ( sel_flfadh )                          , 
		.sel_flfadlh ( sel_flfadlh )                        , .sel_flfadll ( sel_flfadll )                        ,
		.sel_flfsweh ( sel_flfsweh )                        , .sel_flfswel ( sel_flfswel )                        ,
		.sel_flfswsh ( sel_flfswsh )                        , .sel_flfswsl ( sel_flfswsl )                        ,
		.sel_flmch ( sel_flmch ) , .sel_flmclh ( sel_flmclh )                          , 
		.sel_flmcll ( sel_flmcll )                          , .sel_flpmc ( sel_flpmc ) , .sel_flre ( sel_flre )   ,
		.sel_flrhh ( sel_flrhh ) , .sel_flrhl ( sel_flrhl ) , .sel_flrlh ( sel_flrlh ) , .sel_flrll ( sel_flrll ) ,
		.sel_flrst ( sel_flrst ) , .sel_flsech ( sel_flsech )                          , 
		.sel_flsedh ( sel_flsedh )                          , .sel_flsedlh ( sel_flsedlh )                        ,
		.sel_flsedll ( sel_flsedll )                        , .sel_fltmsh ( sel_fltmsh )                          ,
		.sel_fltmsl ( sel_fltmsl )                          , .sel_flwe ( sel_flwe )   , .sel_flwhh ( sel_flwhh ) ,
		.sel_flwhl ( sel_flwhl ) , .sel_flwlh ( sel_flwlh ) , .sel_flwll ( sel_flwll ) , 
		.sel_fsasth ( sel_fsasth )                          , .sel_fsastl ( sel_fsastl )                          ,
		.sel_fsctl ( sel_fsctl ) , .sel_fsse ( sel_fsse )   , .sel_fsset ( sel_fsset ) , .sel_fssql ( sel_fssql ) ,
		.sel_pfcmd ( sel_pfcmd ) , .sel_pfs ( sel_pfs )     , .tesman ( tesman )       , .we_dflmch ( we_dflmch ) ,
		.we_dflmcl ( we_dflmcl ) , .we_flaph ( we_flaph )   , .we_flaplh ( we_flaplh ) , .we_flapll ( we_flapll ) ,
		.we_flars ( we_flars )   , .we_flmch ( we_flmch )   , .we_flmcl ( we_flmcl )   , .we_flrst ( we_flrst )   ,
		.we_flsedh ( we_flsedh ) , .we_flsedlh ( we_flsedlh )                          , 
		.we_flsedll ( we_flsedll )                          , .we_fltmsh ( we_fltmsh ) , .we_fltmsl ( we_fltmsl ) ,
		.we_flwe ( we_flwe )     , .we_flwhh ( we_flwhh )   , .we_flwhl ( we_flwhl )   , .we_flwlh ( we_flwlh )   ,
		.we_flwll ( we_flwll )   , .we_fsctl ( we_fsctl )   , .we_fsse ( we_fsse )     , .we_fsset ( we_fsset )   ,
		.we_fssql ( we_fssql )   ) ;

    //  refer to ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/_parts/qlk0rfcbm3sf1v1_fcb_escb.hdl

    QLK0RFCBM3SF1V1_FCB_ESCB	escb ( 
		.bler ( bler )           , .din_escb ( din_escb[31:0] )                        , .drreq ( drreq )         ,
		.erer ( erer )           , .eseqer ( eseqer )       , .esqend ( esqend )       , .esqmd0 ( esqmd0 )       ,
		.esqmd1 ( esqmd1 )       , .esqmd2 ( esqmd2 )       , .esqst ( esqst )         , .exa ( EXA )             ,
		.exch ( EXCH )           , .exchen_escb ( exchen_escb )                        , .flrhh0 ( flrhh[0] )     ,
		.flrhh1 ( flrhh[1] )     , .flrhh2 ( flrhh[2] )     , .flrhh3 ( flrhh[3] )     , .flrhh4 ( flrhh[4] )     ,
		.flrhh5 ( flrhh[5] )     , .flrhh6 ( flrhh[6] )     , .flrhh7 ( flrhh[7] )     , .flrhl0 ( flrhl[0] )     ,
		.flrhl1 ( flrhl[1] )     , .flrhl2 ( flrhl[2] )     , .flrhl3 ( flrhl[3] )     , .flrhl4 ( flrhl[4] )     ,
		.flrhl5 ( flrhl[5] )     , .flrhl6 ( flrhl[6] )     , .flrhl7 ( flrhl[7] )     , .flrlh0 ( flrlh[0] )     ,
		.flrlh1 ( flrlh[1] )     , .flrlh2 ( flrlh[2] )     , .flrlh3 ( flrlh[3] )     , .flrlh4 ( flrlh[4] )     ,
		.flrlh5 ( flrlh[5] )     , .flrlh6 ( flrlh[6] )     , .flrlh7 ( flrlh[7] )     , .flrll0 ( flrll[0] )     ,
		.flrll1 ( flrll[1] )     , .flrll2 ( flrll[2] )     , .flrll3 ( flrll[3] )     , .flrll4 ( flrll[4] )     ,
		.flrll5 ( flrll[5] )     , .flrll6 ( flrll[6] )     , .flrll7 ( flrll[7] )     , .flwhh0 ( flwhh[0] )     ,
		.flwhh1 ( flwhh[1] )     , .flwhh2 ( flwhh[2] )     , .flwhh3 ( flwhh[3] )     , .flwhh4 ( flwhh[4] )     ,
		.flwhh5 ( flwhh[5] )     , .flwhh6 ( flwhh[6] )     , .flwhh7 ( flwhh[7] )     , .flwhl0 ( flwhl[0] )     ,
		.flwhl1 ( flwhl[1] )     , .flwhl2 ( flwhl[2] )     , .flwhl3 ( flwhl[3] )     , .flwhl4 ( flwhl[4] )     ,
		.flwhl5 ( flwhl[5] )     , .flwhl6 ( flwhl[6] )     , .flwhl7 ( flwhl[7] )     , .flwlh0 ( flwlh[0] )     ,
		.flwlh1 ( flwlh[1] )     , .flwlh2 ( flwlh[2] )     , .flwlh3 ( flwlh[3] )     , .flwlh4 ( flwlh[4] )     ,
		.flwlh5 ( flwlh[5] )     , .flwlh6 ( flwlh[6] )     , .flwlh7 ( flwlh[7] )     , .flwll0 ( flwll[0] )     ,
		.flwll1 ( flwll[1] )     , .flwll2 ( flwll[2] )     , .flwll3 ( flwll[3] )     , .flwll4 ( flwll[4] )     ,
		.flwll5 ( flwll[5] )     , .flwll6 ( flwll[6] )     , .flwll7 ( flwll[7] )     , 
		.fswen_escb ( fswen_escb )                          , .intfl ( INTFL )         , .iver ( iver )           ,
		.onbd ( ONBD )           , .pclk ( PCLK )           , .presetz ( PRESETZ )     , .sec2 ( BTFLG )          ,
		.sec3 ( BTPR )           , .sec4 ( SEPR )           , .sec5 ( CEPR )           , .sec6 ( WRPR )           ,
		.sec7 ( RDPR )           , .sec8 ( FSPR )           , .secen_escb ( secen_escb )                          ,
		.sqend ( sqend )         , .sqst ( sqst )           , .stdwait ( STDWAIT )     , 
		.we_flap_escb ( we_flap_escb )                      , .we_flars_escb ( we_flars_escb )                    ,
		.we_flsed_escb ( we_flsed_escb )                    , .we_flw_escb ( we_flw_escb )                        ,
		.we_flwe_escb ( we_flwe_escb )                      , .we_fssq_escb ( we_fssq_escb )                      ,
		.wrer ( wrer )           ) ;

    //  refer to ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/_parts/qlk0rfcbm3sf1v1_fcb_expreg.hdl

    QLK0RFCBM3SF1V1_FCB_EXPREG	expreg ( 
		.exch ( EXCH )           , .exchen ( EXCHEN )       , .exchen_escb ( exchen_escb )                        ,
		.fswe ( { FSWE9 , FSWE8 , FSWE7 , FSWE6 , FSWE5 , FSWE4 , FSWE3 , FSWE2 , FSWE1 , FSWE0 } )               ,
		.fswen ( FSWEN )         , .fswen_escb ( fswen_escb )                          , 
		.fsws ( { FSWS9 , FSWS8 , FSWS7 , FSWS6 , FSWS5 , FSWS4 , FSWS3 , FSWS2 , FSWS1 , FSWS0 } )               ,
		.pclk ( PCLK )           , .rdata0 ( FLRO0 )        , .rdata1 ( FLRO1 )        , .rdata10 ( FLRO10 )      ,
		.rdata11 ( FLRO11 )      , .rdata12 ( FLRO12 )      , .rdata13 ( FLRO13 )      , .rdata14 ( FLRO14 )      ,
		.rdata15 ( FLRO15 )      , .rdata16 ( FLRO16 )      , .rdata17 ( FLRO17 )      , .rdata18 ( FLRO18 )      ,
		.rdata19 ( FLRO19 )      , .rdata2 ( FLRO2 )        , .rdata20 ( FLRO20 )      , .rdata21 ( FLRO21 )      ,
		.rdata22 ( FLRO22 )      , .rdata23 ( FLRO23 )      , .rdata24 ( FLRO24 )      , .rdata25 ( FLRO25 )      ,
		.rdata26 ( FLRO26 )      , .rdata27 ( FLRO27 )      , .rdata28 ( FLRO28 )      , .rdata29 ( FLRO29 )      ,
		.rdata3 ( FLRO3 )        , .rdata30 ( FLRO30 )      , .rdata31 ( FLRO31 )      , .rdata4 ( FLRO4 )        ,
		.rdata5 ( FLRO5 )        , .rdata6 ( FLRO6 )        , .rdata7 ( FLRO7 )        , .rdata8 ( FLRO8 )        ,
		.rdata9 ( FLRO9 )        , .resz ( PRESETZ )        , 
		.sec ( { FSPR , RDPR , WRPR , CEPR , SEPR , BTPR , BTFLG } )                   , .secen ( SECEN )         ,
		.secen_escb ( secen_escb )                          ) ;

    //  refer to ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/_parts/qlk0rfcbm3sf1v1_fcb_fcpu.hdl

    QLK0RFCBM3SF1V1_FCB_FCPU	fcpu ( 
		.af0 ( AF0 )             , .af1 ( AF1 )             , .af10 ( AF10 )           , .af11 ( AF11 )           ,
		.af12 ( AF12 )           , .af13 ( AF13 )           , .af14 ( AF14 )           , .af15 ( AF15 )           ,
		.af16 ( AF16 )           , .af17 ( AF17 )           , .af18 ( AF18 )           , .af19 ( AF19 )           ,
		.af2 ( AF2 )             , .af3 ( AF3 )             , .af4 ( AF4 )             , .af5 ( AF5 )             ,
		.af6 ( AF6 )             , .af7 ( AF7 )             , .af8 ( AF8 )             , .af9 ( AF9 )             ,
		.aluout ( aluout[19:0] ) , .countend0 ( countend[0] )                          , 
		.countend1 ( countend[1] )                          , .countend10 ( countend[10] )                        ,
		.countend11 ( countend[11] )                        , .countend12 ( countend[12] )                        ,
		.countend13 ( countend[13] )                        , .countend14 ( countend[14] )                        ,
		.countend15 ( countend[15] )                        , .countend16 ( countend[16] )                        ,
		.countend17 ( countend[17] )                        , .countend18 ( countend[18] )                        ,
		.countend19 ( countend[19] )                        , .countend2 ( countend[2] )                          ,
		.countend20 ( countend[20] )                        , .countend21 ( countend[21] )                        ,
		.countend3 ( countend[3] )                          , .countend4 ( countend[4] )                          ,
		.countend5 ( countend[5] )                          , .countend6 ( countend[6] )                          ,
		.countend7 ( countend[7] )                          , .countend8 ( countend[8] )                          ,
		.countend9 ( countend[9] )                          , .eq ( eq )               , .eqact ( eqact )         ,
		.flapsel ( flapsel )     , .ope ( ope[1:0] )        , .resz ( PRESETZ )        , .sqclk ( PCLK )          ,
		.xregclr ( xregclr )     , .xregen ( xregen )       , .xregld ( xregld )       , .yregdin0 ( yregdin[0] ) ,
		.yregdin1 ( yregdin[1] ) , .yregen ( yregen )       , .zregen ( zregen )       , .zregoe ( zregoe )       ) ;

    //  refer to ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/_parts/qlk0rfcbm3sf1v1_fcb_mode.hdl

    QLK0RFCBM3SF1V1_FCB_MODE	mode ( 
		.cer ( CER )             , .ceren ( ceren )         , .cerin ( cerin )         , .cpbt ( CPBT )           ,
		.cpt ( CPT )             , .cwee ( CWEE )           , .dcer ( DCER )           , .dceren ( dceren )       ,
		.dcerin ( dcerin )       , .ddis ( DDIS )           , .ddisen ( ddisen )       , .ddisin ( ddisin )       ,
		.dhin0 ( PWDATA8 )       , .dhin1 ( PWDATA9 )       , .dhin2 ( PWDATA10 )      , .dhin3 ( PWDATA11 )      ,
		.dhin4 ( PWDATA12 )      , .dhin5 ( PWDATA13 )      , .dhin6 ( PWDATA14 )      , .dhin7 ( PWDATA15 )      ,
		.din0 ( PWDATA0 )        , .din1 ( PWDATA1 )        , .din2 ( PWDATA2 )        , .din3 ( PWDATA3 )        ,
		.din4 ( PWDATA4 )        , .din5 ( PWDATA5 )        , .din6 ( PWDATA6 )        , .din7 ( PWDATA7 )        ,
		.dis ( DIS )             , .disen ( disen )         , .disin ( disin )         , .dmrg00 ( DMRG00 )       ,
		.dmrg00en ( dmrg00en )   , .dmrg00in ( dmrg00in )   , .dmrg01 ( DMRG01 )       , .dmrg01en ( dmrg01en )   ,
		.dmrg01in ( dmrg01in )   , .dmrg10 ( DMRG10 )       , .dmrg10en ( dmrg10en )   , .dmrg10in ( dmrg10in )   ,
		.dmrg11 ( DMRG11 )       , .dmrg11en ( dmrg11en )   , .dmrg11in ( dmrg11in )   , .dmrg12 ( DMRG12 )       ,
		.dmrg12en ( dmrg12en )   , .dmrg12in ( dmrg12in )   , .dread ( DREAD )         , .dreaden ( dreaden )     ,
		.dreadin ( dreadin )     , .dser ( DSER )           , .dseren ( dseren )       , .dserin ( dserin )       ,
		.dwwr ( DWWR )           , .dwwren ( dwwren )       , .dwwrin ( dwwrin )       , .eeemd ( EEEMD )         ,
		.exer ( EXER )           , .extvpp1 ( EXTVPP1 )     , .extvpp2 ( EXTVPP2 )     , .flmemtes ( FLMEMTES )   ,
		.flspm ( FLSPM )         , .ionchk1 ( IONCHK1 )     , .ireft ( IREFT )         , .meoc ( MEOC )           ,
		.meor ( MEOR )           , .modidis ( MODIDIS )     , .mrg00 ( MRG00 )         , .mrg00en ( mrg00en )     ,
		.mrg00in ( mrg00in )     , .mrg01 ( MRG01 )         , .mrg01en ( mrg01en )     , .mrg01in ( mrg01in )     ,
		.mrg10 ( MRG10 )         , .mrg10en ( mrg10en )     , .mrg10in ( mrg10in )     , .mrg11 ( MRG11 )         ,
		.mrg11en ( mrg11en )     , .mrg11in ( mrg11in )     , .mrg12 ( MRG12 )         , .mrg12en ( mrg12en )     ,
		.mrg12in ( mrg12in )     , .mswr ( MSWR )           , .mutest ( MUTEST )       , .pclk ( PCLK )           ,
		.rdmrg0 ( RDMRG0 )       , .rdmrg1 ( RDMRG1 )       , .rdmrgc ( RDMRGC )       , .rdt ( RDT )             ,
		.read ( READ )           , .readen ( readen )       , .readin ( readin )       , .resz ( PRESETZ )        ,
		.saceenz ( SACEEN )      , .scanmode ( SCANMODE )   , .ser ( SER )             , .seren ( seren )         ,
		.serin ( serin )         , .stchk ( STCHK )         , .testmod ( TESTMOD )     , .wdt1 ( WDT1 )           ,
		.wdt2 ( WDT2 )           , .wdt3 ( WDT3 )           , .wdt4 ( WDT4 )           , .we_dflmch ( we_dflmch ) ,
		.we_dflmcl ( we_dflmcl ) , .we_flmch ( we_flmch )   , .we_flmcl ( we_flmcl )   , .we_flpmc ( we_flpmc )   ,
		.we_fltmsh ( we_fltmsh ) , .we_fltmsl ( we_fltmsl ) , .wwr ( WWR )             , .wwren ( wwren )         ,
		.wwrin ( wwrin )         ) ;

    //  refer to ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/_parts/qlk0rfcbm3sf1v1_fcb_mscb.hdl

    QLK0RFCBM3SF1V1_FCB_MSCB	mscb ( 
		.act1 ( act1 )           , .af0 ( AF0 )             , .af1 ( AF1 )             , .af10 ( AF10 )           ,
		.af11 ( AF11 )           , .af12 ( AF12 )           , .af13 ( AF13 )           , .af14 ( AF14 )           ,
		.af15 ( AF15 )           , .af16 ( AF16 )           , .af17 ( AF17 )           , .af18 ( AF18 )           ,
		.af19 ( AF19 )           , .af2 ( AF2 )             , .af3 ( AF3 )             , .af4 ( AF4 )             ,
		.af5 ( AF5 )             , .af6 ( AF6 )             , .af7 ( AF7 )             , .af8 ( AF8 )             ,
		.af9 ( AF9 )             , .afsel ( afsel )         , .beu ( { BEU2 , BEU1 , BEU0 } )                     ,
		.bler ( bler )           , .cecce ( CECCE )         , .ceren ( ceren )         , .cerin ( cerin )         ,
		.count10us0 ( count10us[0] )                        , .count10us1 ( count10us[1] )                        ,
		.count10us2 ( count10us[2] )                        , .count10us3 ( count10us[3] )                        ,
		.count10us4 ( count10us[4] )                        , .count10us5 ( count10us[5] )                        ,
		.count10us6 ( count10us[6] )                        , .count10us7 ( count10us[7] )                        ,
		.count10us8 ( count10us[8] )                        , .count1us ( count1us[4:0] )                         ,
		.count20us0 ( count20us[0] )                        , .count20us1 ( count20us[1] )                        ,
		.count20us2 ( count20us[2] )                        , .count20us3 ( count20us[3] )                        ,
		.count20us4 ( count20us[4] )                        , .count20us5 ( count20us[5] )                        ,
		.count20us6 ( count20us[6] )                        , .count20us7 ( count20us[7] )                        ,
		.count20us8 ( count20us[8] )                        , .count20us9 ( count20us[9] )                        ,
		.count2us ( count2us[5:0] )                         , .count3us0 ( count3us[0] )                          ,
		.count3us1 ( count3us[1] )                          , .count3us2 ( count3us[2] )                          ,
		.count3us3 ( count3us[3] )                          , .count3us4 ( count3us[4] )                          ,
		.count3us5 ( count3us[5] )                          , .count3us6 ( count3us[6] )                          ,
		.count40us0 ( count40us[0] )                        , .count40us1 ( count40us[1] )                        ,
		.count40us10 ( count40us[10] )                      , .count40us2 ( count40us[2] )                        ,
		.count40us3 ( count40us[3] )                        , .count40us4 ( count40us[4] )                        ,
		.count40us5 ( count40us[5] )                        , .count40us6 ( count40us[6] )                        ,
		.count40us7 ( count40us[7] )                        , .count40us8 ( count40us[8] )                        ,
		.count40us9 ( count40us[9] )                        , .countend ( countend[21:0] )                        ,
		.counterase0 ( counterase[0] )                      , .counterase1 ( counterase[1] )                      ,
		.counterase10 ( counterase[10] )                    , .counterase11 ( counterase[11] )                    ,
		.counterase12 ( counterase[12] )                    , .counterase13 ( counterase[13] )                    ,
		.counterase14 ( counterase[14] )                    , .counterase15 ( counterase[15] )                    ,
		.counterase16 ( counterase[16] )                    , .counterase17 ( counterase[17] )                    ,
		.counterase18 ( counterase[18] )                    , .counterase19 ( counterase[19] )                    ,
		.counterase2 ( counterase[2] )                      , .counterase20 ( counterase[20] )                    ,
		.counterase21 ( counterase[21] )                    , .counterase3 ( counterase[3] )                      ,
		.counterase4 ( counterase[4] )                      , .counterase5 ( counterase[5] )                      ,
		.counterase6 ( counterase[6] )                      , .counterase7 ( counterase[7] )                      ,
		.counterase8 ( counterase[8] )                      , .counterase9 ( counterase[9] )                      ,
		.countwrite ( countwrite[10:0] )                    , .dceren ( dceren )       , .dcerin ( dcerin )       ,
		.dclr ( dclr )           , .ddisen ( ddisen )       , .ddisin ( ddisin )       , .decce ( DECCE )         ,
		.dhin0 ( PWDATA8 )       , .dhin1 ( PWDATA9 )       , .dhin2 ( PWDATA10 )      , .dhin3 ( PWDATA11 )      ,
		.dhin4 ( PWDATA12 )      , .dhin5 ( PWDATA13 )      , .dhin6 ( PWDATA14 )      , .dhin7 ( PWDATA15 )      ,
		.din_escb0 ( din_escb[0] )                          , .din_escb1 ( din_escb[1] )                          ,
		.din_escb2 ( din_escb[2] )                          , .din_escb3 ( din_escb[3] )                          ,
		.din_escb4 ( din_escb[4] )                          , .din_escb5 ( din_escb[5] )                          ,
		.din_escb6 ( din_escb[6] )                          , .din_escb7 ( din_escb[7] )                          ,
		.disen ( disen )         , .disin ( disin )         , .dmrg00en ( dmrg00en )   , .dmrg00in ( dmrg00in )   ,
		.dmrg01 ( DMRG01 )       , .dmrg01en ( dmrg01en )   , .dmrg01in ( dmrg01in )   , .dmrg10en ( dmrg10en )   ,
		.dmrg10in ( dmrg10in )   , .dmrg11 ( DMRG11 )       , .dmrg11en ( dmrg11en )   , .dmrg11in ( dmrg11in )   ,
		.dmrg12 ( DMRG12 )       , .dmrg12en ( dmrg12en )   , .dmrg12in ( dmrg12in )   , .dreaden ( dreaden )     ,
		.dreadin ( dreadin )     , .drreq ( drreq )         , .dseren ( dseren )       , .dserin ( dserin )       ,
		.dseten ( dseten )       , .dwwren ( dwwren )       , .dwwrin ( dwwrin )       , .eq ( eq )               ,
		.eqact ( eqact )         , .erer ( erer )           , .exa ( EXA )             , .fclk2in ( fclk2in )     ,
		.fclkin ( fclkin )       , .flapsel ( flapsel )     , .flrst ( flrst )         , .flsed0 ( flsedll[0] )   ,
		.flsed1 ( flsedll[1] )   , .flsed10 ( flsedlh[2] )  , .flsed11 ( flsedlh[3] )  , .flsed12 ( flsedlh[4] )  ,
		.flsed13 ( flsedlh[5] )  , .flsed14 ( flsedlh[6] )  , .flsed15 ( flsedlh[7] )  , .flsed16 ( flsedh[0] )   ,
		.flsed17 ( flsedh[1] )   , .flsed18 ( flsedh[2] )   , .flsed19 ( flsedh[3] )   , .flsed2 ( flsedll[2] )   ,
		.flsed3 ( flsedll[3] )   , .flsed4 ( flsedll[4] )   , .flsed5 ( flsedll[5] )   , .flsed6 ( flsedll[6] )   ,
		.flsed7 ( flsedll[7] )   , .flsed8 ( flsedlh[0] )   , .flsed9 ( flsedlh[1] )   , .fpecc0 ( FPECC0 )       ,
		.fpecc1 ( FPECC1 )       , .fpecc2 ( FPECC2 )       , .fpecc3 ( FPECC3 )       , .fperty0 ( FPERTY0 )     ,
		.fperty1 ( FPERTY1 )     , .fperty2 ( FPERTY2 )     , .fperty3 ( FPERTY3 )     , .fperty4 ( FPERTY4 )     ,
		.fperty5 ( FPERTY5 )     , .fperty6 ( FPERTY6 )     , .fperty7 ( FPERTY7 )     , .fpwrty0 ( FPWRTY0 )     ,
		.fpwrty1 ( FPWRTY1 )     , .fpwrty2 ( FPWRTY2 )     , .fpwrty3 ( FPWRTY3 )     , .fpwrty4 ( FPWRTY4 )     ,
		.fpwrty5 ( FPWRTY5 )     , .fpwrty6 ( FPWRTY6 )     , .fpwrty7 ( FPWRTY7 )     , .fset0 ( fset0 )         ,
		.fset1 ( fset1 )         , .fset2 ( fset2 )         , .fset3 ( fset3 )         , .fset4 ( fset4 )         ,
		.fsstp ( fsstp )         , .iv ( iv )               , .iv_ecc ( iv_ecc )       , .iver ( iver )           ,
		.lowspy ( lowspy_mscb )  , .mdch ( mdch )           , .mopen ( mopen )         , .mrg00en ( mrg00en )     ,
		.mrg00in ( mrg00in )     , .mrg01 ( MRG01 )         , .mrg01en ( mrg01en )     , .mrg01in ( mrg01in )     ,
		.mrg10en ( mrg10en )     , .mrg10in ( mrg10in )     , .mrg11 ( MRG11 )         , .mrg11en ( mrg11en )     ,
		.mrg11in ( mrg11in )     , .mrg12 ( MRG12 )         , .mrg12en ( mrg12en )     , .mrg12in ( mrg12in )     ,
		.ope ( ope[1:0] )        , .p_seqer ( p_seqer )     , .pclk ( PCLK )           , .progin ( progin )       ,
		.rdclkp1in ( rdclkp1in ) , .readen ( readen )       , .readin ( readin )       , .resz ( PRESETZ )        ,
		.safen ( safen )         , .sdrdclken ( sdrdclken ) , .seldfl ( seldfl )       , .seqer ( seqer )         ,
		.seren ( seren )         , .serin ( serin )         , .sfclk2en ( sfclk2en )   , .sfclken ( sfclken )     ,
		.sflren ( sflren )       , .sflw1en ( sflw1en )     , .sflwen ( sflwen )       , .sinafen ( sinafen )     ,
		.sprogien ( sprogien )   , .sqend ( sqend )         , .sqmd0 ( sqmd0 )         , .sqmd1 ( sqmd1 )         ,
		.sqmd2 ( sqmd2 )         , .sqst ( sqst )           , .vceq ( VCEQ )           , .we_fltmsh ( we_fltmsh ) ,
		.we_fssq_escb ( we_fssq_escb )                      , .we_fssql ( we_fssql )   , .wrer ( wrer )           ,
		.wwren ( wwren )         , .wwrin ( wwrin )         , .xregclr ( xregclr )     , .xregen ( xregen )       ,
		.xregld ( xregld )       , .yregdin ( yregdin[1:0] )                           , .yregen ( yregen )       ,
		.zregen ( zregen )       , .zregoe ( zregoe )       ) ;

    //  refer to ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/_parts/qlk0rfcbm3sf1v1_fcb_regrw.hdl

    QLK0RFCBM3SF1V1_FCB_REGRW	regrw ( 
		.af0 ( AF0 )             , .af1 ( AF1 )             , .af10 ( AF10 )           , .af11 ( AF11 )           ,
		.af12 ( AF12 )           , .af13 ( AF13 )           , .af14 ( AF14 )           , .af15 ( AF15 )           ,
		.af16 ( AF16 )           , .af17 ( AF17 )           , .af18 ( AF18 )           , .af19 ( AF19 )           ,
		.af2 ( AF2 )             , .af3 ( AF3 )             , .af4 ( AF4 )             , .af5 ( AF5 )             ,
		.af6 ( AF6 )             , .af7 ( AF7 )             , .af8 ( AF8 )             , .af9 ( AF9 )             ,
		.beu0 ( BEU0 )           , .beu1 ( BEU1 )           , .beu2 ( BEU2 )           , .bler ( bler )           ,
		.cer ( CER )             , .cpbt ( CPBT )           , .cpt ( CPT )             , .cwed ( WED )            ,
		.cwee ( CWEE )           , .dcer ( DCER )           , .dclr ( dclr )           , .ddis ( DDIS )           ,
		.dfclk1 ( FCLK1 )        , .dfclk2 ( FCLK2 )        , .dhin0 ( PWDATA8 )       , .dhin1 ( PWDATA9 )       ,
		.dhin2 ( PWDATA10 )      , .dhin7 ( PWDATA15 )      , .din0 ( PWDATA0 )        , .din1 ( PWDATA1 )        ,
		.din2 ( PWDATA2 )        , .din3 ( PWDATA3 )        , .din4 ( PWDATA4 )        , .din6 ( PWDATA6 )        ,
		.din7 ( PWDATA7 )        , .dis ( DIS )             , .dmrg00 ( DMRG00 )       , .dmrg01 ( DMRG01 )       ,
		.dmrg10 ( DMRG10 )       , .dmrg11 ( DMRG11 )       , .dmrg12 ( DMRG12 )       , .dprogi ( PROGI )        ,
		.drdclkz ( RDCLKP1 )     , .dread ( DREAD )         , .drreq ( drreq )         , .dser ( DSER )           ,
		.dseten ( dseten )       , .dwed ( DWED )           , .dwwr ( DWWR )           , .eeemd ( EEEMD )         ,
		.erer ( erer )           , .eseqer ( eseqer )       , .esqend ( esqend )       , .esqmd0 ( esqmd0 )       ,
		.esqmd1 ( esqmd1 )       , .esqmd2 ( esqmd2 )       , .esqst ( esqst )         , .exa ( EXA )             ,
		.exer ( EXER )           , .extvpp1 ( EXTVPP1 )     , .extvpp2 ( EXTVPP2 )     , .flaph0 ( flaph[0] )     ,
		.flaph1 ( flaph[1] )     , .flaph2 ( flaph[2] )     , .flaph3 ( flaph[3] )     , .flaplh0 ( flaplh[0] )   ,
		.flaplh1 ( flaplh[1] )   , .flaplh2 ( flaplh[2] )   , .flaplh3 ( flaplh[3] )   , .flaplh4 ( flaplh[4] )   ,
		.flaplh5 ( flaplh[5] )   , .flaplh6 ( flaplh[6] )   , .flaplh7 ( flaplh[7] )   , .flapll0 ( flapll[0] )   ,
		.flapll1 ( flapll[1] )   , .flapll2 ( flapll[2] )   , .flapll3 ( flapll[3] )   , .flapll4 ( flapll[4] )   ,
		.flapll5 ( flapll[5] )   , .flapll6 ( flapll[6] )   , .flapll7 ( flapll[7] )   , .flmemtes ( FLMEMTES )   ,
		.flre0 ( flre[0] )       , .flre1 ( flre[1] )       , .flre2 ( flre[2] )       , .flre3 ( flre[3] )       ,
		.flre4 ( flre[4] )       , .flre5 ( flre[5] )       , .flrhh0 ( flrhh[0] )     , .flrhh1 ( flrhh[1] )     ,
		.flrhh2 ( flrhh[2] )     , .flrhh3 ( flrhh[3] )     , .flrhh4 ( flrhh[4] )     , .flrhh5 ( flrhh[5] )     ,
		.flrhh6 ( flrhh[6] )     , .flrhh7 ( flrhh[7] )     , .flrhl0 ( flrhl[0] )     , .flrhl1 ( flrhl[1] )     ,
		.flrhl2 ( flrhl[2] )     , .flrhl3 ( flrhl[3] )     , .flrhl4 ( flrhl[4] )     , .flrhl5 ( flrhl[5] )     ,
		.flrhl6 ( flrhl[6] )     , .flrhl7 ( flrhl[7] )     , .flrlh0 ( flrlh[0] )     , .flrlh1 ( flrlh[1] )     ,
		.flrlh2 ( flrlh[2] )     , .flrlh3 ( flrlh[3] )     , .flrlh4 ( flrlh[4] )     , .flrlh5 ( flrlh[5] )     ,
		.flrlh6 ( flrlh[6] )     , .flrlh7 ( flrlh[7] )     , .flrll0 ( flrll[0] )     , .flrll1 ( flrll[1] )     ,
		.flrll2 ( flrll[2] )     , .flrll3 ( flrll[3] )     , .flrll4 ( flrll[4] )     , .flrll5 ( flrll[5] )     ,
		.flrll6 ( flrll[6] )     , .flrll7 ( flrll[7] )     , .flrst ( flrst )         , .flsedh0 ( flsedh[0] )   ,
		.flsedh1 ( flsedh[1] )   , .flsedh2 ( flsedh[2] )   , .flsedh3 ( flsedh[3] )   , .flsedlh0 ( flsedlh[0] ) ,
		.flsedlh1 ( flsedlh[1] ) , .flsedlh2 ( flsedlh[2] ) , .flsedlh3 ( flsedlh[3] ) , .flsedlh4 ( flsedlh[4] ) ,
		.flsedlh5 ( flsedlh[5] ) , .flsedlh6 ( flsedlh[6] ) , .flsedlh7 ( flsedlh[7] ) , .flsedll0 ( flsedll[0] ) ,
		.flsedll1 ( flsedll[1] ) , .flsedll2 ( flsedll[2] ) , .flsedll3 ( flsedll[3] ) , .flsedll4 ( flsedll[4] ) ,
		.flsedll5 ( flsedll[5] ) , .flsedll6 ( flsedll[6] ) , .flsedll7 ( flsedll[7] ) , .flspm ( FLSPM )         ,
		.flwe0 ( flwe[0] )       , .flwe1 ( flwe[1] )       , .flwe2 ( flwe[2] )       , .flwe3 ( flwe[3] )       ,
		.flwe4 ( flwe[4] )       , .flwe5 ( flwe[5] )       , .flwhh0 ( flwhh[0] )     , .flwhh1 ( flwhh[1] )     ,
		.flwhh2 ( flwhh[2] )     , .flwhh3 ( flwhh[3] )     , .flwhh4 ( flwhh[4] )     , .flwhh5 ( flwhh[5] )     ,
		.flwhh6 ( flwhh[6] )     , .flwhh7 ( flwhh[7] )     , .flwhl0 ( flwhl[0] )     , .flwhl1 ( flwhl[1] )     ,
		.flwhl2 ( flwhl[2] )     , .flwhl3 ( flwhl[3] )     , .flwhl4 ( flwhl[4] )     , .flwhl5 ( flwhl[5] )     ,
		.flwhl6 ( flwhl[6] )     , .flwhl7 ( flwhl[7] )     , .flwlh0 ( flwlh[0] )     , .flwlh1 ( flwlh[1] )     ,
		.flwlh2 ( flwlh[2] )     , .flwlh3 ( flwlh[3] )     , .flwlh4 ( flwlh[4] )     , .flwlh5 ( flwlh[5] )     ,
		.flwlh6 ( flwlh[6] )     , .flwlh7 ( flwlh[7] )     , .flwll0 ( flwll[0] )     , .flwll1 ( flwll[1] )     ,
		.flwll2 ( flwll[2] )     , .flwll3 ( flwll[3] )     , .flwll4 ( flwll[4] )     , .flwll5 ( flwll[5] )     ,
		.flwll6 ( flwll[6] )     , .flwll7 ( flwll[7] )     , .fprerr ( fprerr )       , .fset0 ( fset0 )         ,
		.fset1 ( fset1 )         , .fset2 ( fset2 )         , .fset3 ( fset3 )         , .fset4 ( fset4 )         ,
		.fsstp ( fsstp )         , .fswe0 ( FSWE0 )         , .fswe1 ( FSWE1 )         , .fswe2 ( FSWE2 )         ,
		.fswe3 ( FSWE3 )         , .fswe4 ( FSWE4 )         , .fswe5 ( FSWE5 )         , .fswe6 ( FSWE6 )         ,
		.fswe7 ( FSWE7 )         , .fswe8 ( FSWE8 )         , .fswe9 ( FSWE9 )         , .fsws0 ( FSWS0 )         ,
		.fsws1 ( FSWS1 )         , .fsws2 ( FSWS2 )         , .fsws3 ( FSWS3 )         , .fsws4 ( FSWS4 )         ,
		.fsws5 ( FSWS5 )         , .fsws6 ( FSWS6 )         , .fsws7 ( FSWS7 )         , .fsws8 ( FSWS8 )         ,
		.fsws9 ( FSWS9 )         , .fwedis ( fwedis )       , .fwepr ( TFWEPR )        , .ionchk1 ( IONCHK1 )     ,
		.ireft ( IREFT )         , .iver ( iver )           , .lowspy ( LOWSPY )       , 
		.lowspy_mscb ( lowspy_mscb )                        , .mdch ( mdch )           , .meoc ( MEOC )           ,
		.meor ( MEOR )           , .modidis ( MODIDIS )     , .mopen ( mopen )         , .mrg00 ( MRG00 )         ,
		.mrg01 ( MRG01 )         , .mrg10 ( MRG10 )         , .mrg11 ( MRG11 )         , .mrg12 ( MRG12 )         ,
		.mswr ( MSWR )           , .mutest ( MUTEST )       , .pclk ( PCLK )           , .penable ( PENABLE )     ,
		.prdata ( { PRDATA15 , PRDATA14 , PRDATA13 , PRDATA12 , PRDATA11 , PRDATA10 , PRDATA9 , PRDATA8 , PRDATA7 , PRDATA6 , PRDATA5 , PRDATA4 , PRDATA3 , PRDATA2 , PRDATA1 , PRDATA0 } ) ,
		.psel1 ( PSEL1 )         , .psel2 ( PSEL2 )         , .pwrite ( PWRITE )       , .rdmrg0 ( RDMRG0 )       ,
		.rdmrg1 ( RDMRG1 )       , .rdmrgc ( RDMRGC )       , .rdt ( RDT )             , .read ( READ )           ,
		.resz ( PRESETZ )        , .saceenz ( SACEEN )      , .sec2 ( BTFLG )          , .sec3 ( BTPR )           ,
		.sec4 ( SEPR )           , .sec5 ( CEPR )           , .sec6 ( WRPR )           , .sec7 ( RDPR )           ,
		.sec8 ( FSPR )           , .sel_dflmch ( sel_dflmch )                          , 
		.sel_dflmcl ( sel_dflmcl )                          , .sel_flaph ( sel_flaph ) , 
		.sel_flaplh ( sel_flaplh )                          , .sel_flapll ( sel_flapll )                          ,
		.sel_flars ( sel_flars ) , .sel_flfadh ( sel_flfadh )                          , 
		.sel_flfadlh ( sel_flfadlh )                        , .sel_flfadll ( sel_flfadll )                        ,
		.sel_flfsweh ( sel_flfsweh )                        , .sel_flfswel ( sel_flfswel )                        ,
		.sel_flfswsh ( sel_flfswsh )                        , .sel_flfswsl ( sel_flfswsl )                        ,
		.sel_flmch ( sel_flmch ) , .sel_flmclh ( sel_flmclh )                          , 
		.sel_flmcll ( sel_flmcll )                          , .sel_flpmc ( sel_flpmc ) , .sel_flre ( sel_flre )   ,
		.sel_flrhh ( sel_flrhh ) , .sel_flrhl ( sel_flrhl ) , .sel_flrlh ( sel_flrlh ) , .sel_flrll ( sel_flrll ) ,
		.sel_flrst ( sel_flrst ) , .sel_flsech ( sel_flsech )                          , 
		.sel_flsedh ( sel_flsedh )                          , .sel_flsedlh ( sel_flsedlh )                        ,
		.sel_flsedll ( sel_flsedll )                        , .sel_fltmsh ( sel_fltmsh )                          ,
		.sel_fltmsl ( sel_fltmsl )                          , .sel_flwe ( sel_flwe )   , .sel_flwhh ( sel_flwhh ) ,
		.sel_flwhl ( sel_flwhl ) , .sel_flwlh ( sel_flwlh ) , .sel_flwll ( sel_flwll ) , 
		.sel_fsasth ( sel_fsasth )                          , .sel_fsastl ( sel_fsastl )                          ,
		.sel_fsctl ( sel_fsctl ) , .sel_fsse ( sel_fsse )   , .sel_fsset ( sel_fsset ) , .sel_fssql ( sel_fssql ) ,
		.sel_pfs ( sel_pfs )     , .seldfl ( seldfl )       , .seqer ( seqer )         , .ser ( SER )             ,
		.sqend ( sqend )         , .sqmd0 ( sqmd0 )         , .sqmd1 ( sqmd1 )         , .sqmd2 ( sqmd2 )         ,
		.sqst ( sqst )           , .stchk ( STCHK )         , .tcwee ( tcwee )         , .tlowspy ( tlowspy )     ,
		.tmbtsel ( TMBTSEL )     , .tmspmd ( TMSPMD )       , .vceq ( VCEQ )           , .wdt1 ( WDT1 )           ,
		.wdt2 ( WDT2 )           , .wdt3 ( WDT3 )           , .wdt4 ( WDT4 )           , .we_flpmc ( we_flpmc )   ,
		.we_flrst ( we_flrst )   , .we_fsse ( we_fsse )     , .we_fsset ( we_fsset )   , .wrer ( wrer )           ,
		.wwr ( WWR )             ) ;

    //  refer to ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/_parts/qlk0rfcbm3sf1v1_fcb_secure.hdl

    QLK0RFCBM3SF1V1_FCB_SECURE	secure ( 
		.act1 ( act1 )           , .btbls0 ( BTBLS0 )       , .btbls1 ( BTBLS1 )       , .btpr ( BTPR )           ,
		.cepr ( CEPR )           , .eeemd ( EEEMD )         , .esqst ( esqst )         , .exa ( EXA )             ,
		.flap0 ( flapll[0] )     , .flap1 ( flapll[1] )     , .flap10 ( flaplh[2] )    , .flap11 ( flaplh[3] )    ,
		.flap12 ( flaplh[4] )    , .flap13 ( flaplh[5] )    , .flap14 ( flaplh[6] )    , .flap15 ( flaplh[7] )    ,
		.flap16 ( flaph[0] )     , .flap17 ( flaph[1] )     , .flap18 ( flaph[2] )     , .flap19 ( flaph[3] )     ,
		.flap2 ( flapll[2] )     , .flap3 ( flapll[3] )     , .flap4 ( flapll[4] )     , .flap5 ( flapll[5] )     ,
		.flap6 ( flapll[6] )     , .flap7 ( flapll[7] )     , .flap8 ( flaplh[0] )     , .flap9 ( flaplh[1] )     ,
		.flmemtes ( FLMEMTES )   , .flsed0 ( flsedll[0] )   , .flsed1 ( flsedll[1] )   , .flsed10 ( flsedlh[2] )  ,
		.flsed11 ( flsedlh[3] )  , .flsed12 ( flsedlh[4] )  , .flsed13 ( flsedlh[5] )  , .flsed14 ( flsedlh[6] )  ,
		.flsed15 ( flsedlh[7] )  , .flsed16 ( flsedh[0] )   , .flsed17 ( flsedh[1] )   , .flsed18 ( flsedh[2] )   ,
		.flsed19 ( flsedh[3] )   , .flsed2 ( flsedll[2] )   , .flsed3 ( flsedll[3] )   , .flsed4 ( flsedll[4] )   ,
		.flsed5 ( flsedll[5] )   , .flsed6 ( flsedll[6] )   , .flsed7 ( flsedll[7] )   , .flsed8 ( flsedlh[0] )   ,
		.flsed9 ( flsedlh[1] )   , .flspm ( FLSPM )         , .fswe0 ( FSWE0 )         , .fswe1 ( FSWE1 )         ,
		.fswe2 ( FSWE2 )         , .fswe3 ( FSWE3 )         , .fswe4 ( FSWE4 )         , .fswe5 ( FSWE5 )         ,
		.fswe6 ( FSWE6 )         , .fswe7 ( FSWE7 )         , .fswe8 ( FSWE8 )         , .fswe9 ( FSWE9 )         ,
		.fsws0 ( FSWS0 )         , .fsws1 ( FSWS1 )         , .fsws2 ( FSWS2 )         , .fsws3 ( FSWS3 )         ,
		.fsws4 ( FSWS4 )         , .fsws5 ( FSWS5 )         , .fsws6 ( FSWS6 )         , .fsws7 ( FSWS7 )         ,
		.fsws8 ( FSWS8 )         , .fsws9 ( FSWS9 )         , .onbd ( ONBD )           , .p_seqer ( p_seqer )     ,
		.seldfl ( seldfl )       , .sepr ( SEPR )           , .sqmd0 ( sqmd0 )         , .sqmd1 ( sqmd1 )         ,
		.sqmd2 ( sqmd2 )         , .wrpr ( WRPR )           ) ;

    //  refer to ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/_parts/qlk0rfcbm3sf1v1_fcb_sqctl.hdl

    QLK0RFCBM3SF1V1_FCB_SQCTL	sqctl ( 
		.din ( { PWDATA7 , PWDATA6 , PWDATA5 , PWDATA4 , PWDATA3 , PWDATA2 , PWDATA1 , PWDATA0 } )                ,
		.fprerr ( fprerr )       , .pclk ( PCLK )           , .penable ( PENABLE )     , .presetz ( PRESETZ )     ,
		.psel1 ( PSEL1 )         , .psel2 ( PSEL2 )         , .pwrite ( PWRITE )       , .s_sseqbrk ( SSEQBRK )   ,
		.sel_flpmc_p ( sel_flpmc )                          , .sel_pfcmd ( sel_pfcmd ) , .we_flpmc ( we_flpmc )   ) ;

    //  refer to ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/_parts/qlk0rfcbm3sf1v1_fcb_timetable.hdl

    QLK0RFCBM3SF1V1_FCB_TIMETABLE	timetable ( 
		.count10us ( count10us[8:0] )                       , .count1us ( count1us[4:0] )                         ,
		.count20us ( count20us[9:0] )                       , .count2us ( count2us[5:0] )                         ,
		.count3us ( count3us[6:0] )                         , .count40us ( count40us[10:0] )                      ,
		.counterase ( counterase[21:0] )                    , .countwrite ( countwrite[10:0] )                    ,
		.fpser0 ( FPSER0 )       , .fpser1 ( FPSER1 )       , .fpser2 ( FPSER2 )       , .fpwwr0 ( FPWWR0 )       ,
		.fpwwr1 ( FPWWR1 )       , .fpwwr2 ( FPWWR2 )       , .fset0 ( fset0 )         , .fset1 ( fset1 )         ,
		.fset2 ( fset2 )         , .fset3 ( fset3 )         , .fset4 ( fset4 )         ) ;

    //  refer to ... /home/product/flctl/qlk0rfcbm3sf1v1_mf3_v1.20/_hdl/_parts/qlk0rfcbm3sf1v1_fcb_wcbctl.hdl

    QLK0RFCBM3SF1V1_FCB_WCBCTL	wcbctl ( 
		.af ( { AF19 , AF18 , AF17 , AF16 , AF15 , AF14 , AF13 , AF12 , AF11 , AF10 , AF9 , AF8 , AF7 , AF6 , AF5 , AF4 , AF3 , AF2 , AF1 , AF0 } ) ,
		.afsel ( afsel )         , .aluout0 ( aluout[0] )   , .aluout1 ( aluout[1] )   , .aluout10 ( aluout[10] ) ,
		.aluout11 ( aluout[11] ) , .aluout12 ( aluout[12] ) , .aluout13 ( aluout[13] ) , .aluout14 ( aluout[14] ) ,
		.aluout15 ( aluout[15] ) , .aluout16 ( aluout[16] ) , .aluout17 ( aluout[17] ) , .aluout18 ( aluout[18] ) ,
		.aluout19 ( aluout[19] ) , .aluout2 ( aluout[2] )   , .aluout3 ( aluout[3] )   , .aluout4 ( aluout[4] )   ,
		.aluout5 ( aluout[5] )   , .aluout6 ( aluout[6] )   , .aluout7 ( aluout[7] )   , .aluout8 ( aluout[8] )   ,
		.aluout9 ( aluout[9] )   , .cecce ( CECCE )         , .dclr ( dclr )           , .decce ( DECCE )         ,
		.dhin0 ( PWDATA8 )       , .dhin1 ( PWDATA9 )       , .dhin2 ( PWDATA10 )      , .dhin3 ( PWDATA11 )      ,
		.dhin4 ( PWDATA12 )      , .dhin5 ( PWDATA13 )      , .dhin6 ( PWDATA14 )      , .dhin7 ( PWDATA15 )      ,
		.din0 ( PWDATA0 )        , .din1 ( PWDATA1 )        , .din2 ( PWDATA2 )        , .din3 ( PWDATA3 )        ,
		.din4 ( PWDATA4 )        , .din5 ( PWDATA5 )        , .din6 ( PWDATA6 )        , .din7 ( PWDATA7 )        ,
		.din_escb ( din_escb[31:0] )                        , .dro0 ( DFLRO0 )         , .dro1 ( DFLRO1 )         ,
		.dro10 ( DFLRO10 )       , .dro11 ( DFLRO11 )       , .dro2 ( DFLRO2 )         , .dro3 ( DFLRO3 )         ,
		.dro4 ( DFLRO4 )         , .dro5 ( DFLRO5 )         , .dro6 ( DFLRO6 )         , .dro7 ( DFLRO7 )         ,
		.dro8 ( DFLRO8 )         , .dro9 ( DFLRO9 )         , 
		.dw ( { DW31 , DW30 , DW29 , DW28 , DW27 , DW26 , DW25 , DW24 , DW23 , DW22 , DW21 , DW20 , DW19 , DW18 , DW17 , DW16 , DW15 , DW14 , DW13 , DW12 , DW11 , DW10 , DW9 , DW8 , DW7 , DW6 , DW5 , DW4 , DW3 , DW2 , DW1 , DW0 } ) ,
		.edw ( { DW37 , DW36 , DW35 , DW34 , DW33 , DW32 } )                           , .exa ( EXA )             ,
		.fclk ( FCLK1 )          , .fclk2 ( FCLK2 )         , .fclk2in ( fclk2in )     , .fclkin ( fclkin )       ,
		.flaph ( flaph[3:0] )    , .flaplh ( flaplh[7:0] )  , .flapll ( flapll[7:0] )  , .flmemtes ( FLMEMTES )   ,
		.flre ( flre[5:0] )      , .flrhh ( flrhh[7:0] )    , .flrhl ( flrhl[7:0] )    , .flrlh ( flrlh[7:0] )    ,
		.flrll ( flrll[7:0] )    , .flrst ( flrst )         , .flsedh ( flsedh[3:0] )  , 
		.flsedlh ( flsedlh[7:0] )                           , .flsedll ( flsedll[7:0] )                           ,
		.flwe ( flwe[5:0] )      , .flwhh ( flwhh[7:0] )    , .flwhl ( flwhl[7:0] )    , .flwlh ( flwlh[7:0] )    ,
		.flwll ( flwll[7:0] )    , .iceflerr ( ICEFLERR )   , .icenoecc ( ICENOECC )   , .iv ( iv )               ,
		.iv_ecc ( iv_ecc )       , .pclk ( PCLK )           , .progi ( PROGI )         , .progin ( progin )       ,
		.rdclkp1 ( RDCLKP1 )     , .rdclkp1in ( rdclkp1in ) , .resz ( PRESETZ )        , .ro0 ( FLRO0 )           ,
		.ro1 ( FLRO1 )           , .ro10 ( FLRO10 )         , .ro11 ( FLRO11 )         , .ro12 ( FLRO12 )         ,
		.ro13 ( FLRO13 )         , .ro14 ( FLRO14 )         , .ro15 ( FLRO15 )         , .ro16 ( FLRO16 )         ,
		.ro17 ( FLRO17 )         , .ro18 ( FLRO18 )         , .ro19 ( FLRO19 )         , .ro2 ( FLRO2 )           ,
		.ro20 ( FLRO20 )         , .ro21 ( FLRO21 )         , .ro22 ( FLRO22 )         , .ro23 ( FLRO23 )         ,
		.ro24 ( FLRO24 )         , .ro25 ( FLRO25 )         , .ro26 ( FLRO26 )         , .ro27 ( FLRO27 )         ,
		.ro28 ( FLRO28 )         , .ro29 ( FLRO29 )         , .ro3 ( FLRO3 )           , .ro30 ( FLRO30 )         ,
		.ro31 ( FLRO31 )         , .ro32 ( FLRO32 )         , .ro33 ( FLRO33 )         , .ro34 ( FLRO34 )         ,
		.ro35 ( FLRO35 )         , .ro36 ( FLRO36 )         , .ro37 ( FLRO37 )         , .ro4 ( FLRO4 )           ,
		.ro5 ( FLRO5 )           , .ro6 ( FLRO6 )           , .ro7 ( FLRO7 )           , .ro8 ( FLRO8 )           ,
		.ro9 ( FLRO9 )           , .safen ( safen )         , .sdrdclken ( sdrdclken ) , .seldfl ( seldfl )       ,
		.sfclk2en ( sfclk2en )   , .sfclken ( sfclken )     , .sflren ( sflren )       , .sflw1en ( sflw1en )     ,
		.sflwen ( sflwen )       , .sinafen ( sinafen )     , .sprogien ( sprogien )   , .tcwee ( tcwee )         ,
		.tesman ( tesman )       , .tlowspy ( tlowspy )     , .vceq ( VCEQ )           , 
		.we_flap_escb ( we_flap_escb )                      , .we_flaph ( we_flaph )   , .we_flaplh ( we_flaplh ) ,
		.we_flapll ( we_flapll ) , .we_flars ( we_flars )   , .we_flars_escb ( we_flars_escb )                    ,
		.we_flsed_escb ( we_flsed_escb )                    , .we_flsedh ( we_flsedh ) , 
		.we_flsedlh ( we_flsedlh )                          , .we_flsedll ( we_flsedll )                          ,
		.we_flw_escb ( we_flw_escb )                        , .we_flwe ( we_flwe )     , 
		.we_flwe_escb ( we_flwe_escb )                      , .we_flwhh ( we_flwhh )   , .we_flwhl ( we_flwhl )   ,
		.we_flwlh ( we_flwlh )   , .we_flwll ( we_flwll )   , .we_fsctl ( we_fsctl )   ) ;

endmodule

//	module name	QLK0RFCBM3SF1V1_FCB_WCBCTL
//	verision
//	designer	Y.Terauchi


module QLK0RFCBM3SF1V1_FCB_WCBCTL (
	pclk,		resz,		seldfl,		cecce,		flmemtes,	decce,
	din7, 		din6, 		din5, 		din4,		din3, 		din2, 		
	din1, 		din0,		dhin7, 		dhin6, 		dhin5, 		dhin4,
        dhin3, 		dhin2, 		dhin1, 		dhin0,		flre,
	we_fsctl,	we_flwll,	we_flwlh,	we_flwhl,	we_flwhh,	we_flwe,	
	we_flaph,	we_flapll,	we_flaplh,	we_flsedh,	we_flsedll,	we_flsedlh,	
	we_flars,	flrst,		iceflerr,	tesman,		iv,		iv_ecc,
	sflw1en,	sinafen,	exa,
	rdclkp1in,	sdrdclken,	progin,		sprogien,	sfclken,	fclkin,
	dclr,		sflren,		safen,		fclk2in,	sfclk2en,	fclk2,
	rdclkp1,	progi,		fclk,		afsel,		sflwen,
	aluout19,	aluout18,	aluout17,	aluout16,	aluout15,	aluout14,
	aluout13,	aluout12,	aluout11,	aluout10,	aluout9,	aluout8,
	aluout7,	aluout6,	aluout5,	aluout4,	aluout3,	aluout2,
	aluout1,	aluout0,
	dro11,		dro10,		dro9,		dro8,		
	dro7,		dro6,		dro5,		dro4,		dro3,
	dro2,		dro1,		dro0,
	ro37,		ro36,		ro35,		ro34,		ro33,		ro32,
	ro31,		ro30,		ro29,		ro28,		ro27,		ro26,
	ro25,		ro24,		ro23,		ro22,		ro21,		ro20,
	ro19,		ro18,		ro17,		ro16,		ro15,		ro14,
	ro13,		ro12,		ro11,		ro10,		ro9,		ro8,
	ro7,		ro6,		ro5,		ro4,		ro3,		ro2,
	ro1,		ro0,		vceq,		af,		
	flapll,		flaplh,		flaph,		flsedll,	flsedlh,	flsedh,
	flwhh,		flwhl,		flwlh,		flwll,		flwe,		
	dw,		edw,		flrhh,		flrhl,		flrlh,		flrll,
	icenoecc,
	din_escb,	we_flap_escb,	we_flsed_escb,	we_flars_escb, 	we_flw_escb,	we_flwe_escb,
	tcwee,		tlowspy
);

input [31:0]	din_escb	;
input	we_flap_escb,	we_flsed_escb,	we_flars_escb, 	we_flw_escb,	we_flwe_escb			;
input	pclk,		resz,		flrst,		sflren,		sdrdclken,	tesman		;
input	din7, 		din6, 		din5, 		din4,		din3, 		din2		;
input   din1, 		din0,		dhin7, 		dhin6, 		dhin5, 		dhin4         	;
input	dhin3, 		dhin2, 		dhin1, 		dhin0         					;
input	we_fsctl,	we_flaph,	we_flaplh,	we_flapll,	we_flsedh,	we_flsedll	;
input	we_flsedlh,	we_flwhh,	we_flwhl,	we_flwll,	we_flwlh,	we_flars	;
input	we_flwe,	iceflerr,	icenoecc,	cecce,		flmemtes,	decce		;
input	rdclkp1in,	progin,		sprogien,	sfclken,	fclkin,		iv		;
input	dclr,		safen,		sfclk2en,	fclk2in,	iv_ecc				;
input	afsel,		sflwen,		sflw1en,	sinafen						;
input	aluout19,	aluout18,	aluout17,	aluout16,	aluout15,	aluout14	;
input	aluout13,	aluout12,	aluout11,	aluout10,	aluout9,	aluout8		;
input	aluout7,	aluout6,	aluout5,	aluout4,	aluout3,	aluout2		;
input	aluout1,	aluout0										;
input	ro37,		ro36,		ro35,		ro34,		ro33,		ro32		;
input	ro31,		ro30,		ro29,		ro28,		ro27,		ro26		;
input	ro25,		ro24,		ro23,		ro22,		ro21,		ro20		;
input	ro19,		ro18,		ro17,		ro16,		ro15,		ro14		;
input	ro13,		ro12,		ro11,		ro10,		ro9,		ro8		;
input	ro7,		ro6,		ro5,		ro4,		ro3,		ro2		;
input	ro1,		ro0										;
input	dro11,		dro10,		dro9								;
input	dro8,		dro7,		dro6,		dro5,		dro4,		dro3		;
input	dro2,		dro1,		dro0								;

output  rdclkp1,	progi,		fclk,		fclk2,		vceq,		exa		;
output	seldfl,		tcwee,		tlowspy								;
output  [19:0]	af											;
output  [31:0]	dw											;
output	[7:0]	flwhh,	flwhl,	flwlh,	flwll,	flaplh,	flsedlh						;
output	[7:0]	flrhh,	flrhl,	flrlh,	flrll								;
output	[7:0]	flapll,	flsedll										;
output	[5:0]	flwe,	edw,	flre									; 
output	[3:0]	flaph,	flsedh										;

wire	[31:0]	dw											;
wire	[19:0]	ad											;	
wire    [5:0]	ecc,	ecceout										;
wire	[3:0]	eccout, eccdout										;
wire	rdclkp1,	progi,		fclk,		vceq,		vceq_p,		flren		;

reg		fsctl6,	fsctl3,	fsctl2,	fsctl1,	fsctl0,	seldfl				;
reg	[15:0]	flrh,	flrl							;
reg	[7:0]	flaplh,	flsedlh, flwhh,	flwhl, flwlh, flwll			;
reg	[7:0]	flapll, flsedll							;
reg	[5:0]	flwe,	flre,	edw						;
reg	[3:0]	flaph,	flsedh							;
reg	[2:0]	fsctl7								;
reg	[19:0]	af								;
reg	exa									;

wire  [7:0] flrhh = flrh[15:8] ;
wire  [7:0] flrhl = flrh[7:0] ;
wire  [7:0] flrlh = flrl[15:8] ;
wire  [7:0] flrll = flrl[7:0] ;

wire  [7:0] dhin = { dhin7, dhin6, dhin5, dhin4, dhin3,	dhin2, dhin1, dhin0 } ;
wire  [7:0] din  = { din7,  din6,  din5,  din4,  din3,	din2,  din1,  din0  } ;
wire  [19:0]	aluout = { 
	aluout19,	aluout18,	aluout17,	aluout16,	aluout15,	aluout14,
	aluout13,	aluout12,	aluout11,	aluout10,	aluout9,	aluout8,
	aluout7,	aluout6,	aluout5,	aluout4,	aluout3,	aluout2,  
	aluout1,	aluout0 	};

wire [37:0] ro = {
	ro37,		ro36,		ro35,		ro34,		ro33,		ro32,
	ro31,		ro30,		ro29,		ro28,		ro27,		ro26,
	ro25,		ro24,		ro23,		ro22,		ro21,		ro20,
	ro19,		ro18,		ro17,		ro16,		ro15,		ro14,
	ro13,		ro12,		ro11,		ro10,		ro9,		ro8,
	ro7,		ro6,		ro5,		ro4,		ro3,		ro2,
	ro1,		ro0	}	;

wire [11:0] dro = { 
	dro11,		dro10,		dro9,
	dro8,		dro7,		dro6,		dro5,		dro4,		dro3,
	dro2,		dro1,		dro0 } ;

wire [15:0]  romain = seldfl ? {8'h00, dro[7:0]} : ro[15:0] ;
wire [5:0]  roecc  = seldfl ? {2'b00, dro[11:8]} : ro[37:32] ; 
wire [19:10]    sectad ;
wire [37:0]     vcmpb ;


wire		vcmpmd,	tcwee,	tlowspy	;

// FLARS register
always @( posedge pclk or negedge resz)	begin
		if(~resz)		exa <= 1'b0 	;
		else if ( flrst)	exa <= 1'b0	;
		else if ( we_flars ) 	exa <= dhin0	;
		else if ( we_flars_escb)exa <= din_escb[0] ;
		else 			exa <= exa	;
	end

// FLAP register
always @( posedge pclk or negedge resz)	begin
		if(~resz)
					flapll[7:0] <= 8'h00 		;
		else if ( flrst	)	flapll[7:0] <= 8'h00		;
		else if ( we_flapll ) 	flapll[7:0] <= din[7:0]		;
		else if ( we_flap_escb) flapll[7:0] <= {din_escb[7:2], 2'b00}	;
		else 			flapll[7:0] <= flapll[7:0]	;
		end

always @( posedge pclk or negedge resz) begin
		if(~resz)		flaplh[7:0] <= 8'h00 		;
		else if ( flrst )	flaplh[7:0] <= 8'h00		; 
		else if ( we_flaplh ) 	flaplh[7:0] <= dhin[7:0]	;
		else if ( we_flap_escb) flaplh[7:0] <= din_escb[15:8]	;
		else 			flaplh[7:0] <= flaplh[7:0]	;
		end

always @( posedge pclk or negedge resz) begin
		if(~resz)		flaph[3:0] <= 4'h0 			;
		else if ( flrst    )	flaph[3:0] <= 4'h0			;
		else if ( we_flaph )	flaph[3:0] <= din[3:0]			;
		else if ( we_flap_escb) flaph[3:0] <= din_escb[19:16]		;
		else 			flaph[3:0] <= flaph[3:0]		;
		end

// FLSED register
always @( posedge pclk or negedge resz) begin
		if(~resz)		flsedll[7:0] <= 8'h00 			;
		else if ( flrst )	flsedll[7:0] <= 8'h00			;
		else if ( we_flsedll ) 	flsedll[7:0] <= din[7:0]		;
		else if ( we_flsed_escb)flsedll[7:0] <= {din_escb[7:2], 2'b00}	;
		else 			flsedll[7:0] <= flsedll[7:0]		;
		end

always @( posedge pclk or negedge resz) begin
		if(~resz)		flsedlh[7:0] <= 8'h00 			;
		else if ( flrst )	flsedlh[7:0] <= 8'h00			;
		else if ( we_flsedlh ) 	flsedlh[7:0] <= dhin[7:0]		;
		else if ( we_flsed_escb)flsedlh[7:0] <= din_escb[15:8]		;
		else 			flsedlh[7:0] <= flsedlh[7:0]		;
		end

always @( posedge pclk or negedge resz) begin
		if(~resz)		flsedh[3:0] <= 4'h0 			;
		else if ( flrst ) 	flsedh[3:0] <= 4'h0			;
		else if ( we_flsedh ) 	flsedh[3:0] <= din[3:0]			;
		else if ( we_flsed_escb)flsedh[3:0] <= din_escb[19:16]		;
		else 			flsedh[3:0] <= flsedh[3:0]		;
		end

// AF
	assign ad[19:0] = { flaph[3:0], flaplh[7:0], flapll[7:0] } ;
	assign sectad[19:10] = ad[19:10];
// DataFlash
	always@(sectad[19:10]) begin
	 	if(sectad >= 10'h3c4 ) 			seldfl = 1'b1 ;
		else					seldfl = 1'b0 ;
	end


	wire [13:12]	dadpp= ad[13:12] ;
	reg [13:12] dadp;
	always@(dadpp[13:12])begin
		case(dadpp[13:12])
		2'b01:		dadp[13:12] = 2'b00 ;
		2'b10:		dadp[13:12] = 2'b01 ;
		2'b11:		dadp[13:12] = 2'b10 ;
		default:	dadp[13:12] = 2'b11 ;
		endcase
	end

	wire[15:12] dad  = seldfl ? {2'b00, dadp[13:12] } : ad[15:12] ;
	
always @( posedge pclk or negedge resz ) begin
		if(~resz)		 af[19:0] <= 20'h00000	 			;
		else if(~tesman&flmemtes)af[19:0] <= {ad[19:16], dad[15:12], ad[11:0]}  ;
		else if(afsel & safen) 	 af[19:0] <= {aluout[19:0]}			;
		else if(safen) 		 af[19:0] <= {ad[19:16], dad[15:12], ad[11:0]}	;
		else if(sinafen) 	 af[9:0]  <= 10'h000				;
		else 		  	 af[19:0] <= af[19:0] 				;
		end


// FLW register
always @( posedge pclk or negedge resz ) begin
                if( ~resz )       	flwhh[7:0] <= 8'h00			;
		else if (flrst)		flwhh[7:0] <= 8'h00			;
                else if ( we_flwhh ) 	flwhh[7:0] <= dhin[7:0]			;
		else if ( sflwen )  	flwhh[7:0] <= ro[31:24]			;
		else if ( we_flw_escb)	flwhh[7:0] <= din_escb[31:24]		;
		else			flwhh[7:0] <= flwhh[7:0]  		;
                end

// FLW register
always @( posedge pclk or negedge resz ) begin
                if( ~resz )       	flwhl[7:0] <= 8'h00			;
		else if ( flrst )	flwhl[7:0] <= 8'h00			;
                else if ( we_flwhl ) 	flwhl[7:0] <= din[7:0]			;
		else if ( sflwen )  	flwhl[7:0] <= ro[23:16]			;
		else if ( we_flw_escb)	flwhl[7:0] <= din_escb[23:16]		;
		else			flwhl[7:0] <= flwhl[7:0]  		;
                end

always @( posedge pclk or negedge resz ) begin
                if( ~resz )       	flwlh[7:0] <= 8'h00			;
		else if ( flrst )	flwlh[7:0] <= 8'h00			;
                else if ( we_flwlh ) 	flwlh[7:0] <= dhin[7:0]			;
		else if ( sflwen ) 	flwlh[7:0] <= ro[15:8]			;
		else if ( we_flw_escb)	flwlh[7:0] <= din_escb[15:8]		;
		else			flwlh[7:0] <= flwlh[7:0]  		;
                end

always @( posedge pclk or negedge resz ) begin
                if( ~resz )       	flwll[7:0] <= 8'h00			;
		else if ( flrst )	flwll[7:0] <= 8'h00			;
                else if ( we_flwll ) 	flwll[7:0] <= din[7:0] 			;
		else if ( sflwen ) 	flwll[7:0] <= romain[7:0]		;
		else if ( we_flw_escb)	flwll[7:0] <= din_escb[7:0]		;
		else			flwll[7:0] <= flwll[7:0]  		;
                end

always @( posedge pclk or negedge resz ) begin
                if( ~resz )       	flwe[5:0] <= 6'h00			;
		else if ( we_flwe ) 	flwe[5:0] <= din[5:0] 			;
		else if ( sflwen  ) 	flwe[5:0] <= roecc[5:0]			;
		else if ( we_flwe_escb) flwe[5:0] <= din_escb[5:0]		; 
		else			flwe[5:0] <= flwe[5:0]  		;
                end

//  DW
	assign	dw[31:0]	= { flwhh[7:0], flwhl[7:0], flwlh[7:0], flwll[7:0] } ;

	QLK0RFCBM3SF1V1_ECCE eccenc ( .eout( ecceout ), .din(dw[31:0]) ) ;
	QLK0RFCBM3SF1V1_ECCDE eccdenc ( .eout ( eccdout), .din(dw[7:0] ) ) ;

       assign   eccout[3:0]  = seldfl ? eccdout[3:0] : ecceout[3:0] 			;
       assign   ecc[5:0]     = (dclr|iv) ? flwe[5:0] : { ecceout[5:4], eccout[3:0] }  	;

	always @( posedge pclk or negedge resz )
		if( ~resz)	edw[5:0]	<= 6'h00			;
		else		edw[5:0]	<= ecc[5:0]			;


// VCMP
	assign 	vcmpmd = decce | cecce | icenoecc | iv_ecc	;
	assign  vcmpb[37:0] = { (edw[5] | sflw1en), (edw[4] | sflw1en), (edw[3] | sflw1en),
				(edw[2] | sflw1en), (edw[1] | sflw1en), (edw[0] | sflw1en),
				(dw[31] | sflw1en), (dw[30] | sflw1en), (dw[29] | sflw1en),
				(dw[28] | sflw1en), (dw[27] | sflw1en), (dw[26] | sflw1en),
				(dw[25] | sflw1en), (dw[24] | sflw1en), (dw[23] | sflw1en),
				(dw[22] | sflw1en), (dw[21] | sflw1en), (dw[20] | sflw1en),
				(dw[19] | sflw1en), (dw[18] | sflw1en), (dw[17] | sflw1en),
				(dw[16] | sflw1en), (dw[15] | sflw1en), (dw[14] | sflw1en),
				(dw[13] | sflw1en), (dw[12] | sflw1en), (dw[11] | sflw1en),
				(dw[10] | sflw1en), (dw[9]  | sflw1en), (dw[8]  | sflw1en),
				(dw[7]  | sflw1en), (dw[6]  | sflw1en), (dw[5]  | sflw1en),
				(dw[4]  | sflw1en), (dw[3]  | sflw1en), (dw[2]  | sflw1en),
				(dw[1]  | sflw1en), (dw[0]  | sflw1en) } ;

	QLK0RFCBM3SF1V1_VCMP vcmp ( .vcmpa( {flre[5:0], flrh[15:0], flrl[15:0]} ), 
				    .vcmpb( vcmpb[37:0] ), 
					.vceq( vceq_p ), .vcmpmd( vcmpmd ), .seldfl( seldfl ) );
	assign	vceq =  vceq_p & ~iceflerr ;

	assign flren = sflren | (~tesman & flmemtes) ;
// FLR register
always @( posedge pclk or negedge resz ) begin
                if( ~resz )       	flrh[15:0] <= 16'h0000		;
                else if ( flren ) 	flrh[15:0] <= ro[31:16] 	;
		else			flrh[15:0] <= flrh[15:0]  	;
                end

always @( posedge pclk or negedge resz ) begin
                if( ~resz )       	flrl[15:0] <= 16'h0000		;
                else if ( flren ) 	flrl[15:0] <= romain[15:0] 	;
		else			flrl[15:0] <= flrl[15:0]  	;
                end

always @( posedge pclk or negedge resz ) begin
                if( ~resz )       	flre[5:0] <= 6'h00			;
                else if ( flren ) 	flre[5:0] <= roecc[5:0] 	  	;
		else			flre[5:0] <= flre[5:0]  		;
                end



// FSCTL register 
always @( posedge pclk or negedge resz ) begin
                if( ~resz )     	fsctl7[2:0] <= 3'b000				;
		else if ( we_fsctl ) 	fsctl7[2:0] <= {dhin[7],dhin[7],dhin[7]} 	;
		else			fsctl7[2:0] <= fsctl7[2:0]  			;
                end

always @( posedge pclk or negedge resz ) begin
                if( ~resz )     	fsctl6 <= 1'b0	;
		else if ( we_fsctl ) 	fsctl6 <= dhin[6]	;
		else			fsctl6 <= fsctl6  	;
                end


always @( posedge pclk or negedge resz ) begin
                if( ~resz )     	fsctl3 <= 1'b0	;
		else if ( we_fsctl ) 	fsctl3 <= dhin[3]	;
		else if ( sfclk2en ) 	fsctl3 <= fclk2in 	;
		else			fsctl3 <= fsctl3  	;
                end

always @( posedge pclk or negedge resz ) begin
                if( ~resz )     	fsctl2 <= 1'b0	;
		else if ( we_fsctl ) 	fsctl2 <= dhin[2]	;
		else if ( sfclken ) 	fsctl2 <= fclkin 	;
		else			fsctl2 <= fsctl2  	;
                end

always @( posedge pclk or negedge resz ) begin
                if( ~resz )       	fsctl1 <= 1'b1	;
		else if ( we_fsctl ) 	fsctl1 <= dhin[1]	;
		else if ( sdrdclken ) 	fsctl1 <= rdclkp1in 	;
		else			fsctl1 <= fsctl1  	;
                end

always @( posedge pclk or negedge resz ) begin
                if( ~resz )       	fsctl0 <= 1'b0		;
		else if ( we_fsctl ) 	fsctl0 <= dhin[0]	;
		else if ( sprogien ) 	fsctl0 <= progin 	;
		else			fsctl0 <= fsctl0    	;
                end

assign tcwee	= MAJO ( fsctl7[2], fsctl7[1], fsctl7[0] ) ;
assign tlowspy	= fsctl6 ;
assign fclk2	= fsctl3 ;
assign fclk	= fsctl2 ;
assign rdclkp1 	= fsctl1 ;
assign progi	= fsctl0 ;	

// majority control

  function MAJO ;
        input A, B, C ;
        begin
                case({A, B, C})
                        3'b001  : MAJO = 1'b0 ;
                        3'b010  : MAJO = 1'b0 ;
                        3'b011  : MAJO = 1'b1 ;
                        3'b100  : MAJO = 1'b0 ;
                        3'b101  : MAJO = 1'b1 ;
                        3'b110  : MAJO = 1'b1 ;
                        3'b111  : MAJO = 1'b1 ;
                        default : MAJO = 1'b0 ;
                endcase
        end
  endfunction


endmodule

module QLK0RFCBM3SF1V1_VCMP ( vcmpa, vcmpb, vceq, vcmpmd, seldfl );

input	[37:0] vcmpa, vcmpb ;
input	vcmpmd, seldfl  ;
output	vceq;

	wire	[37:0]	vcmpo = ~( vcmpa ^ vcmpb );

	wire	vceq	= ((vcmpmd | seldfl) | &vcmpo[37:36]) &
			  ((vcmpmd         ) | &vcmpo[35:32]) &
			  ((         seldfl) | &vcmpo[31:8 ]) &
			  (		       &vcmpo[7:0]  )      ;

endmodule


//******************* ECC ************************

module QLK0RFCBM3SF1V1_ECCE ( eout, din );

input	[31:0]	din;
output	[5:0]	eout;

  assign eout[0] = (din[0] ^ din[5] ^ din[6] ^ din[10] ^ din[12] ^ din[15] ^ din[17] ^ din[20] ^ din[22] ^ din[23] ^ din[25] ^ din[26] ^ din[28] ^ din[30] ^ din[31] );
  assign eout[1] = (din[0] ^ din[1] ^ din[7] ^ din[11] ^ din[13] ^ din[16] ^ din[17] ^ din[18] ^ din[21] ^ din[23] ^ din[24] ^ din[26] ^ din[27] ^ din[29] ^ din[31] );
  assign eout[2] = (din[1] ^ din[2] ^ din[6] ^ din[8]  ^ din[14] ^ din[15] ^ din[18] ^ din[19] ^ din[22] ^ din[24] ^ din[25] ^ din[26] ^ din[27] ^ din[28] ^ din[30] );
  assign eout[3] = (din[2] ^ din[3] ^ din[7] ^ din[9]  ^ din[12] ^ din[16] ^ din[17] ^ din[19] ^ din[20] ^ din[23] ^ din[25] ^ din[27] ^ din[28] ^ din[29] ^ din[31] );
  assign eout[4] = (din[3] ^ din[4] ^ din[8] ^ din[10] ^ din[13] ^ din[15] ^ din[18] ^ din[20] ^ din[21] ^ din[23] ^ din[24] ^ din[26] ^ din[28] ^ din[29] ^ din[30] );
  assign eout[5] = (din[4] ^ din[5] ^ din[9] ^ din[11] ^ din[14] ^ din[16] ^ din[19] ^ din[21] ^ din[22] ^ din[24] ^ din[25] ^ din[27] ^ din[29] ^ din[30] ^ din[31] );

endmodule

module QLK0RFCBM3SF1V1_ECCDE ( eout, din ) ;

input	[7:0]	din;
output	[3:0]	eout;

	assign eout[3] = din[2] ^ din[3] ^ din[5] ^ din[6] ^ din[7] ;
	assign eout[2] = din[1] ^ din[2] ^ din[4] ^ din[5] ^ din[6] ;
	assign eout[1] = din[0] ^ din[1] ^ din[4] ^ din[5] ^ din[7] ;
	assign eout[0] = din[0] ^ din[3] ^ din[4] ^ din[6] ^ din[7] ;

endmodule
//	module name	QLK0RFCBM3SF1V1_FCB_MODE
//	verision
//	designer	Y.Terauchi


module QLK0RFCBM3SF1V1_FCB_MODE (
					pclk,		resz,		eeemd,		flspm,
					din7, 		din6, 		din5, 		din4,
                                        din3, 		din2, 		din1, 		din0,
                                        dhin7, 		dhin6, 		dhin5, 		dhin4,
                                        dhin3, 		dhin2, 		dhin1, 		dhin0,
					disin,		wwrin,		ddisin,		dwwrin,
					mrg00in,	dmrg00in,	mrg01in,	dmrg01in,
					mrg11in,	dmrg11in,	mrg12in,	dmrg12in,
					readin,		dreadin,	mrg10in,	dmrg10in,
					serin,		dserin,		cerin,		dcerin,
					wwren,		dwwren,		mrg00en,	dmrg00en,	
					mrg01en,	dmrg01en,	mrg11en,	dmrg11en,
					mrg12en,	dmrg12en,	disen,		ddisen,
					readen,		dreaden,	seren,		dseren,
					mrg10en,	dmrg10en,	ceren,		dceren,
					dis,		read,		mrg00,		mrg01,
					mrg10,		mrg11,		mrg12,		ser,
					wwr,		ddis,		dread,		dmrg00,
					dmrg01,		dmrg10,		dmrg11,		dmrg12,
					dser,		dwwr,		
					we_fltmsh,	we_fltmsl,	we_flmcl,
					we_flmch,	we_dflmch,	we_dflmcl,
					cpbt,		wdt4,		wdt3,		wdt2,
					wdt1,		rdmrgc,		rdmrg1,		rdmrg0,
					rdt,		ionchk1,	stchk,		exer,
					mswr,		modidis,	meor,
					meoc,		mutest,		saceenz,	flmemtes,
					ireft,		cpt,		extvpp2,	extvpp1,
					dcer,		cer,		we_flpmc,	scanmode,
					cwee,		testmod
) ;


input	pclk,		resz,		flspm,		eeemd,		we_flpmc,	scanmode	;
input	din7, 		din6, 		din5, 		din4,		din3, 		din2		;
input   din1, 		din0,		dhin7, 		dhin6, 		dhin5, 		dhin4         	;
input	dhin3, 		dhin2, 		dhin1, 		dhin0         					;
input	we_flmch,	we_flmcl,			we_dflmch,	we_dflmcl,	we_fltmsh	;
input	we_fltmsl,	cwee										;
input	disin,		wwrin,		mrg00in,	ddisin,		dwwrin,		dmrg00in	;
input	mrg01in,	dmrg01in,	mrg11in,	dmrg11in,	mrg12in,	dmrg12in	;
input	readin,		dreadin,	mrg10in,	dmrg10in,	serin,		dserin		;
input	cerin,		dcerin										;
input	disen,		wwren,		mrg00en,	ddisen,		dwwren,		dmrg00en	;
input	mrg01en,	dmrg01en,	mrg11en,	dmrg11en,	mrg12en,	dmrg12en	;
input	readen,		dreaden,	mrg10en,	dmrg10en,	seren,		dseren		;
input	ceren,		dceren,		flmemtes,	testmod						;

output	dis,		read,		mrg00,		mrg01,		mrg10,		mrg11		;
output	mrg12,		ser,		wwr,		ddis,		dread,		dmrg00		;
output	dmrg01,		dmrg10,		dmrg11,		dmrg12,		dwwr,		dser		;
output	cpbt,		wdt4,		wdt3,		wdt2,		wdt1,		rdmrgc		;
output	rdmrg1,		rdmrg0,		rdt,		ionchk1,	stchk,		exer		;
output	mswr,		modidis,	meor,		meoc						;
output	mutest,		saceenz,	ireft,		cpt,		extvpp2,	extvpp1		;
output	dcer,		cer										;

reg	[6:0]	flmch		;
reg	[5:0]	flmclh,	fltmsl	;
reg	[2:0]	fltmsh		;

reg	dis,	read_p,	mrg00_p,   mrg01_p,  mrg10_p,    mrg11_p,        mrg12_p,	 ser_p,	 wwr_p,	cer_p	;
reg	ddis,	dread_p, dmrg00_p, dmrg01_p, dmrg10_p,	dmrg11_p,	dmrg12_p,	dser_p,	dwwr_p,	dcer_p	;


wire	cpbt,		wdt4,		wdt3,		wdt2,		wdt1,		rdmrgc		;
wire	rdmrg1,		rdmrg0,		rdt,		ionchk1,	stchk,		exer		;
wire	mswr,		modidis,	meor,		meoc						;
wire	mutest,		saceenz,	ireft,		cpt,		extvpp2,	extvpp1		;

wire	mrg00,   mrg01,  mrg10,    mrg11,        mrg12,	 ser,	 wwr,	cer,	read ;
wire	dmrg00, dmrg01, dmrg10,	  dmrg11,	dmrg12,	dser,	dwwr,	dcer,	dread ;
wire    flmcresz									;

wire [7:0] din  =  { din7,   din6,   din5,   din4,   din3,   din2,   din1,   din0 } ;
wire [7:0] dhin =  { dhin7,  dhin6,  dhin5,  dhin4,  dhin3,  dhin2,  dhin1,  dhin0 } ;

wire	cclksel1 = ~(flspm | flmemtes) ;
wire	dclksel1 = ~(eeemd | flmemtes) ;

// DIS
always @( posedge pclk or negedge resz )
                if( ~resz )       	dis <= 1'b0		;
		else if ( we_flpmc  )	dis <= din[1]		;
		else if ( we_flmcl  )   dis <= din[0]		;
		else if ( disen ) 	dis <= disin 		;
		else if (cclksel1)	dis <= 1'b0		;
		else 			dis <= dis	  	;

// READ
always @( posedge pclk or negedge resz )
                if( ~resz )            			read_p <= 1'b1			;
		else if ( wwr_p | cer_p | ser_p ) 	read_p <= 1'b0			;
		else if ( we_flpmc  ) 			read_p <= ~din[1]		;
		else if ( we_flmcl  ) 			read_p <= din[1]		;
		else if ( readen ) 			read_p <= readin 		;
		else if (cclksel1)			read_p <= 1'b1			;
		else 					read_p <= read_p	  	;

assign read = read_p & ~( wwr_p | cer_p | ser_p ) ;

// SER
always @( posedge pclk or negedge resz )
                if( ~resz )       				ser_p <= 1'b0		;
		else if ( cclksel1| cer_p | wwr_p | read_p)	ser_p <= 1'b0		;
                else if ( we_flmcl  )   			ser_p <= dhin[2]	;
		else if ( seren ) 				ser_p <= serin 		;
		else 						ser_p <= ser_p	        ;
              

 assign ser = ser_p & cwee & ~( wwr_p | cer_p | read_p );

// CER
always @( posedge pclk or negedge resz )
                if( ~resz )       				cer_p <= 1'b0		;
		else if ( cclksel1 | ser_p | wwr_p | read_p)	cer_p <= 1'b0		;
                else if ( we_flmcl ) 				cer_p <= dhin[1]	;
		else if ( ceren ) 				cer_p <= cerin 		;
		else 						cer_p <= cer_p	  	;

 assign cer = cer_p & cwee & ~( wwr_p | ser_p | read_p ) ;


// WWR
always @( posedge pclk or negedge resz )
                if( ~resz )       				wwr_p <= 1'b0		;
		else if ( cclksel1 | ser_p | cer_p | read_p)	wwr_p <= 1'b0		;
                else if ( we_flmcl ) 				wwr_p <= din[7]		;
		else if ( wwren ) 				wwr_p <= wwrin 		;
		else 						wwr_p <= wwr_p	  	;

assign wwr = wwr_p & cwee & ~( ser_p | cer_p | read_p ) ;

//MRG12
always @( posedge pclk or negedge resz )
                if( ~resz )       		mrg12_p <= 1'b0			;
		else if ( cclksel1)		mrg12_p <= 1'b0			;
                else if ( we_flmcl )		mrg12_p <= din[6]		;
		else if ( mrg12en )     	mrg12_p <= mrg12in 		;
		else				mrg12_p <= mrg12_p	  	;
           
assign mrg12 = mrg12_p & cwee ;

//MRG11
always @( posedge pclk or negedge resz )
                if( ~resz )       		mrg11_p <= 1'b0			;
		else if ( cclksel1 )		mrg11_p <= 1'b0			;
                else if ( we_flmcl ) 		mrg11_p <= din[5]		;
		else if ( mrg11en ) 		mrg11_p <= mrg11in 		;
		else 				mrg11_p <= mrg11_p  		;
             
assign mrg11 = mrg11_p & cwee ;


//MRG10
always @( posedge pclk or negedge resz )
                if( ~resz )       		mrg10_p <= 1'b0			;
		else if ( cclksel1 )		mrg10_p <= 1'b0			;
                else if ( we_flmcl ) 		mrg10_p <= din[4]		;
		else if ( mrg10en ) 		mrg10_p <= mrg10in 		;
		else 				mrg10_p <= mrg10_p  		;
             
assign mrg10 = mrg10_p & cwee ;

//MRG01
always @( posedge pclk or negedge resz )
                if( ~resz )       		mrg01_p <= 1'b0			;
		else if ( cclksel1 )		mrg01_p <= 1'b0			;
                else if ( we_flmcl ) 		mrg01_p <= din[3]		;
		else if ( mrg01en ) 		mrg01_p <= mrg01in 		;
		else				mrg01_p <= mrg01_p	  	;
               
assign mrg01 = mrg01_p & cwee ;

//MRG00
always @( posedge pclk or negedge resz )
                if( ~resz )       		mrg00_p <= 1'b0			;
		else if ( cclksel1 )		mrg00_p <= 1'b0			;
                else if ( we_flmcl ) 		mrg00_p <= din[2]		;
		else if ( mrg00en ) 		mrg00_p <= mrg00in 		;
		else	 			mrg00_p <= mrg00_p  		;
                
assign mrg00 = mrg00_p & cwee ;

assign flmcresz = resz & testmod ;

//flmclh
always @(posedge pclk or negedge flmcresz )
		if( ~flmcresz )		flmclh[5:0] <= 6'h00			;
		else if ( we_flmcl )	flmclh[5:0] <= { dhin[7:3], dhin[0] } 	;
		else			flmclh[5:0] <= flmclh[5:0]		;

//flmch
always @(posedge pclk or negedge flmcresz )
		if( ~flmcresz )		flmch[6:0] <= 7'h00			;
		else if ( we_flmch )	flmch[6:0] <= din[6:0]		 	;
		else			flmch[6:0] <= flmch[6:0]		;

 assign cpbt   = flmch[6] ;
 assign wdt4   = flmch[5] ;
 assign wdt3   = flmch[4] ;
 assign wdt2   = flmch[3] ;
 assign wdt1   = flmch[2] ;
 assign rdmrgc = flmch[1] ;
 assign rdmrg1 = flmch[0] ; 
 assign rdmrg0 = flmclh[5] ;
 assign rdt    = flmclh[4] ;
 assign ionchk1= flmclh[3] ;
 assign stchk  = flmclh[2] ;
 assign exer   = flmclh[1] ;
 assign mswr   = flmclh[0] ;

// DDIS
always @( posedge pclk or negedge resz )
                if( ~resz )       		ddis <= 1'b1		;
		else if ( we_flpmc  ) 		ddis <= din[4]		;
		else if ( we_dflmcl )   	ddis <= din[0]		;
		else if ( ddisen ) 		ddis <= ddisin 		;
		else if(dclksel1)		ddis <= 1'b0		;
		else 				ddis <= ddis	  	;

// DREAD
always @( posedge pclk or negedge resz )
                if( ~resz )            			dread_p <= 1'b0		;
		else if ( dwwr_p | dser_p | dcer_p )	dread_p <= 1'b0 	;
		else if ( we_flpmc  )			dread_p <= ~din[4] 	;
		else if ( we_dflmcl ) 			dread_p <= din[1]	;
		else if ( dreaden ) 			dread_p <= dreadin 	;
		else if (dclksel1)			dread_p <= 1'b1		;
		else 					dread_p <= dread_p	;

assign dread = dread_p & ~( dwwr_p | dser_p | dcer_p ) ;

// DSER
always @( posedge pclk or negedge resz )
                if( ~resz )       				dser_p <= 1'b0			;
		else if ( dclksel1 | dcer_p | dwwr_p | dread_p)	dser_p <= 1'b0			;
                else if ( we_dflmch )   			dser_p <= dhin[2]		;
		else if ( dseren ) 				dser_p <= dserin 		;
		else 						dser_p <= dser_p	        ;
              
assign dser = dser_p & ~cwee & ~(dcer_p | dwwr_p | dread_p ) ; 

// DCER
always @( posedge pclk or negedge resz )
                if( ~resz )       					dcer_p <= 1'b0			;
		else if ( dclksel1 | dser_p | dwwr_p | dread_p )	dcer_p <= 1'b0			;
                else if ( we_dflmch ) 					dcer_p <= dhin[1]		;
		else if ( dceren ) 					dcer_p <= dcerin 		;
		else 							dcer_p <= dcer_p	  	;

assign dcer = dcer_p & ~cwee & ~(dser_p | dwwr_p | dread_p ) ;

// DWWR
always @( posedge pclk or negedge resz )
                if( ~resz )       					dwwr_p <= 1'b0			;
		else if ( dclksel1 | dcer_p | dser_p | dread_p )	dwwr_p <= 1'b0			;
                else if ( we_dflmcl ) 					dwwr_p <= din[7]		;
		else if ( dwwren ) 					dwwr_p <= dwwrin 		;
		else 							dwwr_p <= dwwr_p	  	;

assign dwwr = dwwr_p & ~cwee & ~(dser_p | dcer_p | dread_p) ;

//DMRG12
always @( posedge pclk or negedge resz )
                if( ~resz )       		dmrg12_p <= 1'b0		;
		else if ( dclksel1 )		dmrg12_p <= 1'b0		;
                else if ( we_dflmcl )		dmrg12_p <= din[6]		;
		else if ( dmrg12en )    	dmrg12_p <= dmrg12in 		;
		else				dmrg12_p <= dmrg12_p		;
           
assign dmrg12 = dmrg12_p & ~cwee ;

//DMRG11
always @( posedge pclk or negedge resz )
                if( ~resz )       		dmrg11_p <= 1'b0		;
		else if ( dclksel1  )		dmrg11_p <= 1'b0		;
                else if ( we_dflmcl ) 		dmrg11_p <= din[5]		;
		else if ( dmrg11en ) 		dmrg11_p <= dmrg11in 		;
		else 				dmrg11_p <= dmrg11_p	  	;
             
assign dmrg11 = dmrg11_p & ~cwee ;

//DMRG10
always @( posedge pclk or negedge resz )
                if( ~resz )       		dmrg10_p <= 1'b0		;
		else if ( dclksel1  )		dmrg10_p <= 1'b0		;
                else if ( we_dflmcl ) 		dmrg10_p <= din[4]		;
		else if ( dmrg10en ) 		dmrg10_p <= dmrg10in 		;
		else 				dmrg10_p <= dmrg10_p	  	;
             
assign dmrg10 = dmrg10_p & ~cwee ;

//DMRG01
always @( posedge pclk or negedge resz )
                if( ~resz )       		dmrg01_p <= 1'b0		;
		else if ( dclksel1 )		dmrg01_p <= 1'b0		;
                else if ( we_dflmcl ) 		dmrg01_p <= din[3]		;
		else if ( dmrg01en ) 		dmrg01_p <= dmrg01in 		;
		else				dmrg01_p <= dmrg01_p	  	;
               
assign dmrg01 = dmrg01_p & ~cwee ;

//DMRG00
always @( posedge pclk or negedge resz )
                if( ~resz )       		dmrg00_p <= 1'b0		;
		else if ( dclksel1  )		dmrg00_p <= 1'b0		;
                else if ( we_dflmcl ) 		dmrg00_p <= din[2]		;
		else if ( dmrg00en ) 		dmrg00_p <= dmrg00in 		;
		else	 			dmrg00_p <= dmrg00_p	  	;
                
assign dmrg00 = dmrg00_p & ~cwee ;

// FLTMS register
always @( posedge pclk or negedge resz )
                if( ~resz )       	fltmsh[2:0] <= 3'h0			;
		else if ( we_fltmsh ) 	fltmsh[2:0] <= { dhin[7], dhin[4:3] }	;
		else 			fltmsh[2:0] <= fltmsh[2:0]		;
  
always @( posedge pclk or negedge resz )
                if( ~resz )       	fltmsl[5:0] <= 6'h00			;
		else if ( we_fltmsl ) 	fltmsl[5:0] <= { din[6], din[4:0] }	;
		else 			fltmsl[5:0] <= fltmsl[5:0]		;
  
 assign modidis = ~scanmode & fltmsh[2] ;
 assign meoc	= fltmsh[1] ;
 assign meor	= fltmsh[0] ;
 assign mutest  = fltmsl[5] ;
 assign saceenz = ~fltmsl[4] ;
 assign ireft	= fltmsl[3] ;
 assign cpt	= fltmsl[2] ;
 assign extvpp2	= fltmsl[1] ;
 assign extvpp1 = fltmsl[0] ;


endmodule
//	module name	QLK0RFCBM3SF1V1_FCB_MSCB
//	verision
//	designer	Y.Terauchi



module QLK0RFCBM3SF1V1_FCB_MSCB(
	pclk,		resz,		
	dhin7,		dhin6,		dhin5,		dhin4,
	dhin3,		dhin2, 		dhin1, 		dhin0,		
	af19,		af18,		af17,		af16,		af15,		af14,
	af13,		af12,		af11,		af10,		af9,		af8,
	af7,		af6,		af5,		af4,		af3,		af2,
	af1,		af0,		exa,
	flsed19,	flsed18,	flsed17,	flsed16,	flsed15,	flsed14,
	flsed13,	flsed12,	flsed11,	flsed10,	flsed9,		flsed8,
	flsed7,		flsed6,		flsed5,		flsed4,		flsed3,		flsed2,
	flsed1,		flsed0,
	we_fssql,	we_fltmsh,	flrst,		fclk2in,	sfclk2en,
	rdclkp1in,	sdrdclken,	progin,		sprogien,	fclkin,		sfclken,
	disin,		wwrin,		ddisin,		dwwrin,		mrg00in,	dmrg00in,
	mrg01in,	dmrg01in,	mrg11in,	dmrg11in,	mrg12in,	dmrg12in,
	readin,		dreadin,	serin,		dserin,		mrg10in,	dmrg10in,
	cerin,		dcerin,		
	mrg01en,	dmrg01en,	mrg11en,	dmrg11en,	mrg12en,	dmrg12en,
	disen,		wwren,		ddisen,		dwwren,		mrg00en,	dmrg00en,
	readen,		dreaden,	seren,		dseren,		mrg10en,	dmrg10en,
	sflren,		ceren,		dceren,				
	safen,		afsel,		xregclr,	vceq,		iv_ecc,
	yregdin,	yregen,		xregen,		countend,	ope,		sflwen,
	eqact,		zregen,		zregoe,		xregld,
	sflw1en,	sinafen,	eq,		seldfl,		iv,
	fpwrty7,	fpwrty6,	fpwrty5,	fpwrty4,	fpwrty3,	fpwrty2,
	fpwrty1,	fpwrty0,
	fperty7,	fperty6,	fperty5,	fperty4,	fperty3,	fperty2,
	fperty1,	fperty0,
	count3us6,	count3us5,	count3us4,	count3us3,	count3us2,
	count3us1,	count3us0,
	count10us8,	count10us7,	count10us6,
	count10us5,	count10us4,	count10us3,	count10us2,	count10us1,	count10us0,
	count20us9,	count20us8,	count20us7,	count20us6,
	count20us5,	count20us4,	count20us3,	count20us2,	count20us1,	count20us0,
	count40us10,	count40us9,	count40us8,	count40us7,	count40us6,
	count40us5,	count40us4,	count40us3,	count40us2,	count40us1,	count40us0,
	counterase21,	counterase20,	counterase19,	counterase18,	counterase17,	counterase16,
	counterase15,	counterase14,	counterase13,	counterase12,	counterase11,	counterase10,
	counterase9,	counterase8,	counterase7,	counterase6,	counterase5,	counterase4,
	counterase3,	counterase2,	counterase1,	counterase0,	countwrite,
	flapsel,	lowspy,		fset4,		fset3,		fset2,		fset1,
	fset0,		fpecc1,		fpecc0,		cecce,
	fpecc3,		fpecc2,		decce,		mrg01,		mrg11,		mrg12,
	dmrg01,		dmrg11,		dmrg12,
	beu,		erer,		wrer,		iver,			
	bler,		seqer,		dclr,		drreq,		dseten,		fsstp,
	we_fssq_escb,	mdch,		mopen,		sqend,		act1,
	sqmd0,		sqmd1,		sqmd2,		sqst,		p_seqer,
	din_escb7,	din_escb6,	din_escb5,	din_escb4,	din_escb3,	din_escb2,
	din_escb1,	din_escb0,	
	count1us,	count2us
);

input	p_seqer,	exa									  ;
input   din_escb7,	din_escb6,	din_escb5,	din_escb4,	din_escb3,	din_escb2 ;
input	din_escb1,	din_escb0								  ;
input	we_fssq_escb										;
output	erer,		wrer,		iver,		bler,		seqer,		dclr	;
output	drreq,		dseten,		fsstp,		mdch,		mopen,		iv_ecc	;
output	sqend,		sqmd2,		sqmd1,		sqmd0,		sqst	;
input	dhin7, 		dhin6, 		dhin5, 		dhin4,		dhin3,		dhin2 	;
input	dhin1, 		dhin0									;
input	we_fssql,	we_fltmsh,	flrst,		fpecc1,		fpecc0			;
input	fpecc3,		fpecc2,		mrg01,		mrg11,		mrg12,		dmrg01	;
input	dmrg11,		dmrg12									;
input	pclk,		resz,		eq,		seldfl					;
input	fpwrty7,	fpwrty6,	fpwrty5,	fpwrty4,	fpwrty3,	fpwrty2 ;
input	fpwrty1,	fpwrty0									;
input	fperty7,	fperty6,	fperty5,	fperty4,	fperty3,	fperty2 ;
input	fperty1,	fperty0									;
input	count3us6,	count3us5,	count3us4,	count3us3,	count3us2			;
input	count3us1,	count3us0									;
input	count10us8,	count10us7,	count10us6							;
input	count10us5,	count10us4,	count10us3,	count10us2,	count10us1,	count10us0	;
input	count20us9,	count20us8,	count20us7,	count20us6	;
input	count20us5,	count20us4,	count20us3,	count20us2,	count20us1,	count20us0	;
input	count40us10,	count40us9,	count40us8,	count40us7,	count40us6			;
input	count40us5,	count40us4,	count40us3,	count40us2,	count40us1,	count40us0	;
input	counterase21,	counterase20,	counterase19,	counterase18,	counterase17,	counterase16	;
input	counterase15,	counterase14,	counterase13,	counterase12,	counterase11,	counterase10	;
input	counterase9,	counterase8,	counterase7,	counterase6,	counterase5,	counterase4	;
input	counterase3,	counterase2,	counterase1,	counterase0					;
input	vceq												;
input	lowspy,		fset4,		fset3,		fset2,		fset1,		fset0		;

input 	af19,		af18,		af17,		af16,		af15,		af14		;
input	af13,		af12,		af11,		af10,		af9,		af8		;
input	af7,		af6,		af5,		af4,		af3,		af2		;
input	af1,		af0										;
input	flsed19,	flsed18,	flsed17,	flsed16,	flsed15,	flsed14		;
input	flsed13,	flsed12,	flsed11,	flsed10,	flsed9,		flsed8		;
input	flsed7,		flsed6,		flsed5,		flsed4,		flsed3,		flsed2		;
input	flsed1,		flsed0									;
input	[10:0]	countwrite			;
input	[5:0]	count2us	;
input	[4:0]	count1us	;

output  [21:0]	countend									;
output  [1:0]	yregdin, ope									;
output	[2:0]	beu										;
output	rdclkp1in,	sdrdclken,	progin,		sprogien,	sfclken,	sflren	;
output	safen,		afsel,		fclk2in,	sfclk2en,	act1			;
output	sflw1en,	sinafen,	dmrg00in				;
output	disin,		wwrin,		ddisin,		dwwrin,		fclkin,		mrg00in	;
output	disen,		wwren,		ddisen,		dwwren,		mrg00en,	dmrg00en;
output	mrg01in,	dmrg01in,	mrg11in,	dmrg11in,	mrg12in,	dmrg12in;
output	mrg01en,	dmrg01en,	mrg11en,	dmrg11en,	mrg12en,	dmrg12en;
output	readin,		dreadin,	serin,		dserin,		mrg10in,	dmrg10in;
output	readen,		dreaden,	seren,		dseren,		mrg10en,	dmrg10en;
output	cerin,		dcerin,		ceren,		dceren,		flapsel,	iv	;
output	xregen,		yregen,		eqact,		zregen			;
output	zregoe,		xregld,		sflwen							;
output	cecce,		decce,		xregclr							;

wire	[7:0]	din_escbl = { din_escb7,	din_escb6,	din_escb5,	din_escb4,	din_escb3,	din_escb2,
				din_escb1,	din_escb0			} ;
wire	[19:0]  af	= {
	af19,		af18,		af17,		af16,		af15,		af14,
	af13,		af12,		af11,		af10,		af9,		af8,
	af7,		af6,		af5,		af4,		af3,		af2,	
	af1,		af0		 } ;
wire	[19:0] flsed	= { 
	flsed19,	flsed18,	flsed17,	flsed16,	flsed15,	flsed14,
	flsed13,	flsed12,	flsed11,	flsed10,	flsed9,		flsed8,
	flsed7,		flsed6,		flsed5,		flsed4,		flsed3,		flsed2,	
	flsed1,		flsed0		 } ;
wire	[7:0]	fpwrty	   =    { fpwrty7,	fpwrty6,	fpwrty5,	fpwrty4,	fpwrty3,	
				  fpwrty2,	fpwrty1,	fpwrty0		} ; 
wire	[7:0]	fperty	   =    { fperty7,	fperty6,	fperty5,	fperty4,	fperty3,	
				  fperty2,	fperty1,	fperty0		} ; 
wire	[6:0]	count3us   =	{ count3us6,	count3us5,	count3us4,	count3us3,	
				  count3us2,	count3us1,	count3us0	} ;
wire    [8:0]	count10us  =	{ count10us8,	count10us7,	count10us6,	count10us5,	
				  count10us4,	count10us3,	count10us2,	count10us1,	count10us0 } ;
wire	[9:0]	count20us  =	{ count20us9,	count20us8,	count20us7,	count20us6,	count20us5,	
				  count20us4,	count20us3,	count20us2,	count20us1,	count20us0 } ;
wire	[10:0]	count40us  =	{ count40us10,	count40us9,	count40us8,	count40us7,	
				  count40us6,	count40us5,	count40us4,	count40us3,	count40us2,	
				  count40us1,	count40us0			} ;
wire	[21:0]	counterase  = 	{ counterase21,	counterase20,	counterase19,	counterase18,	counterase17,	
				  counterase16,	counterase15,	counterase14,	counterase13,	counterase12,	
				  counterase11,	counterase10,	counterase9,	counterase8,	counterase7,	
				  counterase6,	counterase5,	counterase4,	counterase3,	counterase2,	
				  counterase1,	counterase0			} ;

wire	[10:0]	counttmsm		;
wire	[9:0]	counttmsw, counteratdis	;
wire	[8:0]	counttms2m		;
wire	[5:0]	counttdis		;
wire	[4:0]	fset	=	{ fset4,	fset3,	fset2,		fset1,	fset0	}	;

wire	erer,		wrer,		iver,		bler,		seqer,		iv_ecc	;
wire	rdclkp1in,	sdrdclken,	progin,		sprogien,	sfclken,	fclkin	;
wire	safen,		afsel,		drreq,		cmr_start				;
wire	disin,		wwrin,		ddisin,		dwwrin,		mrg00in,	dmrg00in;
wire	mrg01in,	dmrg01in,	mrg11in,	dmrg11in,	mrg12in,	dmrg12in;
wire	readin,		dreadin,	sflw1en,	fclk2in,	sfclk2en		;
wire	disen,		wwren,		ddisen,		dwwren					;
wire	mrg01en,	dmrg01en,	mrg11en,	dmrg11en,	mrg12en,	dmrg12en;
wire	readen,		dreaden,	serin,		dserin,		mrg10in,	dmrg10in;
wire	seren,		dseren,		mrg10en,	dmrg10en,	flapsel			;	
wire	sqst,		fsstp,		dclr,		iv					;
wire	dseten,		mdch,		act1,		act2,		act3,		act4	;
wire	act5,		act6,		act7,		act0					;
wire					f30,		f29,		f28,		f27	;
wire	f26,		f25,		f24,		f23,		f22,		f21	;
wire	f20,		f19,		f18,		f17,		f16,		f15	;
wire	f14,		f13,		f12,		f11,		f10,		f9	;
wire	f8,		f7,		f6,		f5,		f4,		f3	;
wire	f2,		f1									;	
wire	tms_start,	xregen,		yregen,				eqact			;
wire	stend,		fflagres,	zregen,		zregoe,		xregld,		sinafen	;
wire	sflren,		rmaxset,	xregclr,	p_cecce,	p_decce	;
wire	faddress,	subend,		ststop,		ope1,		ope0			;
wire	cfaddress,	dfaddress						;

wire [1:0]	ope = { ope1, ope0 } ;
reg [2:0]	beu,	pbeu	;
reg [2:0]	st_state ;
reg [1:0]	yregdin	 ;
reg [6:0]	s_state,	fsectad	 ;
reg [7:0]	m_state  ;
reg [21:0]       countend ;
reg [7:0]	fssq	;
reg [4:0]	fsast	;
reg		rmax,		fflag,		secdis			;
reg		mopen,		sqend,		cecce,		decce	;
reg		faddressl						;

//********************************************************
// FSSQ register
//********************************************************
always @(posedge pclk or negedge resz ) begin
	if(~resz)		fssq[7:0]	<= 8'h00				;
	else if(flrst)		fssq[7:0]	<= 8'h00				;
	else if(we_fssql)	fssq[7:0]	<= {dhin7, dhin6, dhin5, dhin4,
						    dhin3, dhin2, dhin1, dhin0} 	;
	else if(we_fssq_escb)	fssq[7:0]	<= din_escbl[7:0]			;
	else			fssq[7:0]	<= fssq[7:0]				;
end

	assign sqmd2 = fssq[2] ;
	assign sqmd1 = fssq[1] ;
	assign sqmd0 = fssq[0] ;
	

	assign sqst   = fssq[7];	assign fsstp = fssq[6] ;
	assign dclr  = fssq[5] ; 	assign dseten = fssq[4];
	assign mdch  = fssq[3] ;
	assign act1  = ( fssq[2:0] == 3'b001 );	// write
	assign act2  = ( fssq[2:0] == 3'b010 ); // iv
	assign act3  = ( fssq[2:0] == 3'b011 ); // bc
	assign act4  = ( fssq[2:0] == 3'b100 ); // se
	assign act5  = ( fssq[2:0] == 3'b101 ); // read
	assign act6  = ( fssq[2:0] == 3'b110 ); // ce
	assign act7  = ( fssq[2:0] == 3'b111 ); // seqer
	assign act0  = (p_seqer&~secdis) | ( fssq[2:0] == 3'b000 ) | act7 ;	// seqer

//**********************************************************
//**  sec dis
//**********************************************************

	always @( posedge pclk or negedge resz ) begin
		if(~resz)		secdis	<= 1'b0 	;
		else if( act7 & sqend)	secdis  <= exa 		;
		else			secdis  <= secdis 	;
	end

//**********************************************************
//  FSEL decoder
//**********************************************************
//	assign f32 = ( fset[4:0] == 5'b11111 ) ;	assign f31 = ( fset[4:0] == 5'b11110 ) ;
	assign f30 = ( fset[4:0] == 5'b11101 ) ;	assign f29 = ( fset[4:0] == 5'b11100 ) ;
	assign f28 = ( fset[4:0] == 5'b11011 ) ;	assign f27 = ( fset[4:0] == 5'b11010 ) ;
	assign f26 = ( fset[4:0] == 5'b11001 ) ;	assign f25 = ( fset[4:0] == 5'b11000 ) ;
	assign f24 = ( fset[4:0] == 5'b10111 ) ;	assign f23 = ( fset[4:0] == 5'b10110 ) ;
	assign f22 = ( fset[4:0] == 5'b10101 ) ;	assign f21 = ( fset[4:0] == 5'b10100 ) ;
	assign f20 = ( fset[4:0] == 5'b10011 ) ;	assign f19 = ( fset[4:0] == 5'b10010 ) ;
	assign f18 = ( fset[4:0] == 5'b10001 ) ;	assign f17 = ( fset[4:0] == 5'b10000 ) ;
	assign f16 = ( fset[4:0] == 5'b01111 ) ;	assign f15 = ( fset[4:0] == 5'b01110 ) ;
	assign f14 = ( fset[4:0] == 5'b01101 ) ;	assign f13 = ( fset[4:0] == 5'b01100 ) ;
	assign f12 = ( fset[4:0] == 5'b01011 ) ;	assign f11 = ( fset[4:0] == 5'b01010 ) ;
	assign f10 = ( fset[4:0] == 5'b01001 ) ;	assign f9 = ( fset[4:0] == 5'b01000 ) ;
	assign f8 = ( fset[4:0] == 5'b00111 ) ;		assign f7 = ( fset[4:0] == 5'b00110 ) ;
	assign f6 = ( fset[4:0] == 5'b00101 ) ;		assign f5 = ( fset[4:0] == 5'b00100 ) ;
	assign f4 = ( fset[4:0] == 5'b00011 ) ;		assign f3 = ( fset[4:0] == 5'b00010 ) ;
	assign f2 = ( fset[4:0] == 5'b00001 ) ;		assign f1 = ( fset[4:0] == 5'b00000 ) ;

//***************************************
//**  Parameter define
//***************************************
	parameter	M_INIT		=	8'b00000000 ;
	parameter	M_DIS		=	8'b00000001;
	parameter	M_DIS_S		=	8'b00000010;
	parameter	M_XINIT		=	8'b00000011;
	parameter	M_RESET		=	8'b00000100;
	parameter	M_PRG_RDCKL	=	8'b00000101;
	parameter	M_PRG_WAIT	=	8'b00000110;
	parameter	M_PRG_MDSET	=	8'b00000111;
	parameter	M_PRG_PRGIS	=	8'b00001000;
	parameter	M_PRG_PRGIS_6	=	8'b00001001;
	parameter	M_PRG_PRGIS_5	=	8'b00001010;
	parameter	M_PRG_PRGIS_4	=	8'b00001011;
	parameter	M_PRG_PRGIS_3	=	8'b00001100;
	parameter	M_PRG_PRGIS_2	=	8'b00001101;
	parameter	M_PRG_PRGIS_1	=	8'b00001110;
	parameter	M_PRG_PRGIR	=	8'b00001111;
	parameter	M_PRG_TMS_S	=	8'b00010000;
	parameter	M_PRG_FCLK1_S	=	8'b00010001;
	parameter	M_PRG_FCLK1R	=	8'b00010010;
	parameter	M_PRG_TWPLS_S	=	8'b00010011;
	parameter	M_PRG_FCLK2_S	=	8'b00010100;
	parameter	M_PRG_FCLK2R	=	8'b00010101;
	parameter	M_PRG_TDIS	=	8'b00010110;
	parameter	M_PRG_TDIS_S	=	8'b00010111;
	parameter	M_PRG_PVSET	=	8'b00011000;
	parameter	M_PRG_CMR_S	=	8'b00011001;
	parameter	M_PRG_VERI	=	8'b00011010;
	parameter	M_PRG_RCNTS	=	8'b00011011;
	parameter	M_PRG_RINC	=	8'b00011100;
	parameter	M_IV_FLAPS	=	8'b00011101;
	parameter	M_IV_MDSET1	=	8'b00011110;
	parameter	M_IV_TMS1_S	=	8'b00100000;
	parameter	M_IV_RDCKL1	=	8'b00100001;
	parameter	M_IV_RDCKL1_16	=	8'b00100010;
	parameter	M_IV_RDCKL1_15	=	8'b00100011;
	parameter	M_IV_RDCKL1_14	=	8'b00100100;
	parameter	M_IV_RDCKL1_13	=	8'b00100101;
	parameter	M_IV_RDCKL1_12	=	8'b00100110;
	parameter	M_IV_RDCKL1_11	=	8'b00100111;
	parameter	M_IV_RDCKL1_10	=	8'b00101000;
	parameter	M_IV_RDCKL1_9	=	8'b00101001;
	parameter	M_IV_RDCKL1_8	=	8'b00101010;
	parameter	M_IV_RDCKL1_7	=	8'b00101011;
	parameter	M_IV_RDCKL1_6	=	8'b00101100;
	parameter	M_IV_RDCKL1_5	=	8'b00101101;
	parameter	M_IV_RDCKL1_4	=	8'b00101110;
	parameter	M_IV_RDCKL1_3	=	8'b00101111;
	parameter	M_IV_RDCKL1_2	=	8'b00110000;
	parameter	M_IV_RDCKL1_1	=	8'b00110001;
	parameter	M_IV_RDCKH1	=	8'b00110010;
	parameter	M_IV_RDCKH1_16	=	8'b00110011;
	parameter	M_IV_RDCKH1_15	=	8'b00110100;
	parameter	M_IV_RDCKH1_14	=	8'b00110101;
	parameter	M_IV_RDCKH1_13	=	8'b00110110;
	parameter	M_IV_RDCKH1_12	=	8'b00110111;
	parameter	M_IV_RDCKH1_11	=	8'b00111000;
	parameter	M_IV_RDCKH1_10	=	8'b00111001;
	parameter	M_IV_RDCKH1_9	=	8'b00111010;
	parameter	M_IV_RDCKH1_8	=	8'b00111011;
	parameter	M_IV_RDCKH1_7	=	8'b00111100;
	parameter	M_IV_RDCKH1_6	=	8'b00111101;
	parameter	M_IV_RDCKH1_5	=	8'b00111110;
	parameter	M_IV_RDCKH1_4	=	8'b00111111;
	parameter	M_IV_RDCKH1_3	=	8'b01000000;
	parameter	M_IV_RDCKH1_2	=	8'b01000001;
	parameter	M_IV_RDCKH1_1	=	8'b01000010;
	parameter	M_IV_RDCKL2	=	8'b01000011;
	parameter	M_IV_FLWSET	=	8'b01000100;
	parameter	M_IV_MDSET2	=	8'b01000101;
	parameter	M_IV_MDSET3	=	8'b01000110;
	parameter	M_IV_TMS2_S	=	8'b01000111;
	parameter	M_IV_RDCKH2	=	8'b01001000;
	parameter	M_IV_RDCKL2_15	=	8'b01001001;
	parameter	M_IV_RDCKL2_14	=	8'b01001010;
	parameter	M_IV_RDCKL2_13	=	8'b01001011;
	parameter	M_IV_RDCKL2_12	=	8'b01001100;
	parameter	M_IV_RDCKL2_11	=	8'b01001101;
	parameter	M_IV_RDCKL2_10	=	8'b01001110;
	parameter	M_IV_RDCKL2_9	=	8'b01001111;
	parameter	M_IV_RDCKL2_8	=	8'b01010000;
	parameter	M_IV_RDCKL2_7	=	8'b01010001;
	parameter	M_IV_RDCKL2_6	=	8'b01010010;
	parameter	M_IV_RDCKL2_5	=	8'b01010011;
	parameter	M_IV_RDCKL2_4	=	8'b01010100;
	parameter	M_IV_RDCKL2_3	=	8'b01010101;
	parameter	M_IV_RDCKL2_2	=	8'b01010110;
	parameter	M_IV_RDCKL2_1	=	8'b01010111;
	parameter	M_IV_RDCKL3	=	8'b01011000;
	parameter	M_IV_RDCKL3_16	=	8'b01011001;
	parameter	M_IV_RDCKL3_15	=	8'b01011010;
	parameter	M_IV_RDCKL3_14	=	8'b01011011;
	parameter	M_IV_RDCKL3_13	=	8'b01011100;
	parameter	M_IV_RDCKL3_12	=	8'b01011101;
	parameter	M_IV_RDCKL3_11	=	8'b01011110;
	parameter	M_IV_RDCKL3_10	=	8'b01011111;
	parameter	M_IV_RDCKL3_9	=	8'b01100000;
	parameter	M_IV_RDCKL3_8	=	8'b01100001;
	parameter	M_IV_RDCKL3_7	=	8'b01100010;
	parameter	M_IV_RDCKL3_6	=	8'b01100011;
	parameter	M_IV_RDCKL3_5	=	8'b01100100;
	parameter	M_IV_RDCKL3_4	=	8'b01100101;
	parameter	M_IV_RDCKL3_3	=	8'b01100110;
	parameter	M_IV_RDCKL3_2	=	8'b01100111;
	parameter	M_IV_RDCKL3_1	=	8'b01101000;
	parameter	M_IV_RDCKH3	=	8'b01101001;
	parameter	M_IV_RDCKH3_16	=	8'b01101010;
	parameter	M_IV_RDCKH3_15	=	8'b01101011;
	parameter	M_IV_RDCKH3_14	=	8'b01101100;
	parameter	M_IV_RDCKH3_13	=	8'b01101101;
	parameter	M_IV_RDCKH3_12	=	8'b01101110;
	parameter	M_IV_RDCKH3_11	=	8'b01101111;
	parameter	M_IV_RDCKH3_10	=	8'b01110000;
	parameter	M_IV_RDCKH3_9	=	8'b01110001;
	parameter	M_IV_RDCKH3_8	=	8'b01110010;
	parameter	M_IV_RDCKH3_7	=	8'b01110011;
	parameter	M_IV_RDCKH3_6	=	8'b01110100;
	parameter	M_IV_RDCKH3_5	=	8'b01110101;
	parameter	M_IV_RDCKH3_4	=	8'b01110110;
	parameter	M_IV_RDCKH3_3	=	8'b01110111;
	parameter	M_IV_RDCKH3_2	=	8'b01111000;
	parameter	M_IV_RDCKH3_1	=	8'b01111001;
	parameter	M_IV_RDCKL4	=	8'b01111010;
	parameter	M_IV_FLRSET	=	8'b01111011;
	parameter	M_IV_RDCKL4_15	=	8'b01111100;
	parameter	M_IV_RDCKL4_14	=	8'b01111101;
	parameter	M_IV_RDCKL4_13	=	8'b01111110;
	parameter	M_IV_RDCKL4_12	=	8'b01111111;
	parameter	M_IV_RDCKL4_11	=	8'b10000000;
	parameter	M_IV_RDCKL4_10	=	8'b10000001;
	parameter	M_IV_RDCKL4_9	=	8'b10000010;
	parameter	M_IV_RDCKL4_8	=	8'b10000011;
	parameter	M_IV_RDCKL4_7	=	8'b10000100;
	parameter	M_IV_RDCKL4_6	=	8'b10000101;
	parameter	M_IV_RDCKL4_5	=	8'b10000110;
	parameter	M_IV_RDCKL4_4	=	8'b10000111;
	parameter	M_IV_RDCKL4_3	=	8'b10001000;
	parameter	M_IV_RDCKL4_2	=	8'b10001001;
	parameter	M_IV_VERI	=	8'b10001011;
	parameter	M_IV_MDSET4	=	8'b10001100;
	parameter	M_IV_MDSET5	=	8'b10001101;
	parameter	M_IV_TMS3_S	=	8'b10001110;
	parameter	M_IV_ACNT1	=	8'b10001111;
	parameter	M_IV_ASET1	=	8'b10010000;
	parameter	M_IV_TDIS	=	8'b10010001;
	parameter	M_IV_TDIS_S	=	8'b10010010;
	parameter	M_IV_FMDR	=	8'b10010011;
	parameter	M_BCR_VDSET	=	8'b10010100;
	parameter	M_BCR_CMR_S	=	8'b10010101;
	parameter	M_ERA_ASET	=	8'b10010110;
	parameter	M_ERA_BEUSET	=	8'b10010111;
	parameter	M_ERA_CMR0_S	=	8'b10011000;
	parameter	M_ERA_VERI0	=	8'b10011001;
	parameter	M_ERA_AERSET	=	8'b10011010;
	parameter	M_ERA_RDCKL	=	8'b10011011;
	parameter	M_ERA_MDSET	=	8'b10011100;
	parameter	M_ERA_WAIT	=	8'b10011101;
	parameter	M_ERA_TMS_S	=	8'b10011110;
	parameter	M_ERA_FCLK_S	=	8'b10011111;
	parameter	M_ERA_FCLKR	=	8'b10100000;
	parameter	M_ERA_TDIS	=	8'b10100001;
	parameter	M_ERA_TDIS_S	=	8'b10100010;
	parameter	M_ERA_VDSET	=	8'b10100011;
	parameter	M_ERA_CMR_S	=	8'b10100100;
	parameter	M_ERA_VERI	=	8'b10100101;
	parameter	M_ERA_RCNTS	=	8'b10100110;
	parameter	M_ERA_RINC	=	8'b10100111;
	parameter	M_ERA_SCNTS	=	8'b10101000;
	parameter	M_ERA_SINC	=	8'b10101001;
//	parameter	M_ERA_RSMS	=	8'b10101010;
//	parameter	M_ERA_SFSET	=	8'b10101011;
	parameter	M_LAST		=	8'b10101100;
	parameter	M_IGEN		=	8'b10101101;
	parameter	M_ICLR		=	8'b10101110;
	parameter	M_END		=	8'b10101111;


	parameter	S_INIT		=	7'b0000000 ;
	parameter	S_SSMD		=	7'b0000001 ;	
	parameter	S_TDIS		=	7'b0000010 ;
	parameter	S_TDIS_S	=	7'b0000011 ;
	parameter	S_LAST		=	7'b0000100 ;
//	parameter	S_CMR_FLAP	=	7'b0000101 ;
	parameter	S_CMR_MDSET	=	7'b0000110 ;
	parameter	S_CMR_TMS_S	=	7'b0000111 ;
	parameter	S_CMR_RDCKL1	=	7'b0001000 ;
	parameter	S_CMR_ASET1	=	7'b0001001 ;
	parameter	S_CMR_RDCKL1_16	=	7'b0001010 ;
	parameter	S_CMR_RDCKL1_15	=	7'b0001011 ;
	parameter	S_CMR_RDCKL1_14	=	7'b0001100 ;
	parameter	S_CMR_RDCKL1_13	=	7'b0001101 ;
	parameter	S_CMR_RDCKL1_12	=	7'b0001110 ;
	parameter	S_CMR_RDCKL1_11	=	7'b0001111 ;
	parameter	S_CMR_RDCKL1_10	=	7'b0010000 ;
	parameter	S_CMR_RDCKL1_9	=	7'b0010001 ;
	parameter	S_CMR_RDCKL1_8	=	7'b0010010 ;
	parameter	S_CMR_RDCKL1_7	=	7'b0010011 ;
	parameter	S_CMR_RDCKL1_6	=	7'b0010100 ;
	parameter	S_CMR_RDCKL1_5	=	7'b0010101 ;
	parameter	S_CMR_RDCKL1_4	=	7'b0010110 ;
	parameter	S_CMR_RDCKL1_3	=	7'b0010111 ;
	parameter	S_CMR_RDCKL1_2	=	7'b0011000 ;
	parameter	S_CMR_RDCKL1_W	=	7'b0011001 ;
	parameter	S_CMR_RDCKH1	=	7'b0011010 ;
	parameter	S_CMR_RDCKH1_16	=	7'b0011011 ;
	parameter	S_CMR_RDCKH1_15	=	7'b0011100 ;
	parameter	S_CMR_RDCKH1_14	=	7'b0011101 ;
	parameter	S_CMR_RDCKH1_13	=	7'b0011110 ;
	parameter	S_CMR_RDCKH1_12	=	7'b0011111 ;
	parameter	S_CMR_RDCKH1_11	=	7'b0100000 ;
	parameter	S_CMR_RDCKH1_10	=	7'b0100001 ;
	parameter	S_CMR_RDCKH1_9	=	7'b0100010 ;
	parameter	S_CMR_RDCKH1_8	=	7'b0100011 ;
	parameter	S_CMR_RDCKH1_7	=	7'b0100100 ;
	parameter	S_CMR_RDCKH1_6	=	7'b0100101 ;
	parameter	S_CMR_RDCKH1_5	=	7'b0100110 ;
	parameter	S_CMR_RDCKH1_4	=	7'b0100111 ;
	parameter	S_CMR_RDCKH1_3	=	7'b0101000 ;
	parameter	S_CMR_RDCKH1_2	=	7'b0101001 ;
//	parameter	S_CMR_RDCKH1_1	=	7'b0101010 ;
	parameter	S_CMR_RDCKL2	=	7'b0101011 ;
	parameter	S_CMR_FLRSET	=	7'b0101100 ;
	parameter	S_CMR_DSS	=	7'b0101101 ;
	parameter	S_CMR_DSC	=	7'b0101110 ;
	parameter	S_CMR_RDCKL2_16	=	7'b0110000 ;
	parameter	S_CMR_RDCKL2_15	=	7'b0110001 ;
	parameter	S_CMR_RDCKL2_14	=	7'b0110010 ;
	parameter	S_CMR_RDCKL2_13	=	7'b0110011 ;
	parameter	S_CMR_RDCKL2_12	=	7'b0110100 ;
	parameter	S_CMR_RDCKL2_11	=	7'b0110101 ;
	parameter	S_CMR_RDCKL2_10	=	7'b0110110 ;
	parameter	S_CMR_RDCKL2_9	=	7'b0110111 ;
	parameter	S_CMR_RDCKL2_8	=	7'b0111000 ;
	parameter	S_CMR_RDCKL2_7	=	7'b0111001 ;
	parameter	S_CMR_RDCKL2_6	=	7'b0111010 ;
	parameter	S_CMR_RDCKL2_5	=	7'b0111011 ;
	parameter	S_CMR_RDCKL2_4	=	7'b0111100 ;
	parameter	S_CMR_RDCKL2_3	=	7'b0111101 ;
//	parameter	S_CMR_RDCKL2_2	=	7'b0111110 ;
	parameter	S_CMR_RDCKH2	=	7'b0111111 ;
	parameter	S_CMR_ASET2	=	7'b1000011 ;
	parameter	S_CMR_VERI	=	7'b1000000 ;
	parameter	S_CMR_FMDR	=	7'b1000001 ;
	parameter	S_CMR_ASET3	=	7'b1000010 ;
	parameter	S_CMR_ADEC	=	7'b1000100 ;
	
	parameter	ST_INIT		=	3'b000 ;
	parameter	ST_REGSET	=	3'b001 ;
	parameter	ST_C_SET	=	3'b010 ;
	parameter	ST_C_COUNT	=	3'b011 ;
	parameter	ST_C_LAST	=	3'B100 ;


//*******************************************************
//**  Error signal
//*******************************************************

always @( posedge pclk or negedge resz) begin
		if( ~resz )			fsast[4:0] <= 5'h00	;
		else if(m_state==M_DIS )	fsast[4:0] <= 5'h00	;
		     else if(m_state==M_LAST) begin
						fsast[4:0] <= { (act0),
								(act3)&fflag,
								(act2)&fflag,
								(act1)&fflag,
								((act4|act6)&fflag ) } ;
						end
			else			fsast[4:0] <=	fsast[4:0]	;
	end

 assign	erer = fsast[0] ;
 assign	wrer = fsast[1] ;
 assign	iver = fsast[2] ;
 assign bler = fsast[3] ;
 assign seqer = fsast[4] ;	
//******************************************************************
// State Machine( Main )
//******************************************************************
	always @( posedge pclk or negedge resz ) begin
		if(~resz )					m_state <= M_INIT	;
		else
		case(m_state)
			M_INIT		:	if(sqst)	m_state <= M_DIS	;
						else		m_state <= M_INIT	;
			M_DIS		:			m_state <= M_DIS_S	;
			M_DIS_S		:	if(stend)	m_state <= M_XINIT	;
						else		m_state <= M_DIS_S	;
			M_XINIT		:			m_state <= M_RESET	;
			M_RESET		:	if(fsstp)	m_state <= M_LAST	;
						else if(act0)
								m_state <= M_LAST	;
						else if(act1)	m_state <= M_PRG_RDCKL	;
						else if(act2)	m_state <= M_IV_FLAPS	;
						else if(act3|act5)
								m_state <= M_BCR_VDSET	;
						else 		m_state <= M_ERA_ASET	;
// Write
			M_PRG_RDCKL	:			m_state <= M_PRG_WAIT	;
			M_PRG_WAIT	:	if(fsstp)	m_state <= M_LAST	;
						else		m_state <= M_PRG_MDSET	;
			M_PRG_MDSET	:	if(fsstp)	m_state <= M_PRG_TDIS	;
						else		m_state <= M_PRG_PRGIS	;
			M_PRG_PRGIS	:	if(fsstp)	m_state <= M_PRG_TDIS	;
						else if(f4|f3|f2|f1)
								m_state <= M_PRG_PRGIR	;
						else		m_state <= M_PRG_PRGIS_6;
			M_PRG_PRGIS_6	:	if(fsstp)	m_state <= M_PRG_TDIS	;
						else if(f9|f8|f7|f6|f5)
								m_state <= M_PRG_PRGIR	;
						else		m_state <= M_PRG_PRGIS_5;
			M_PRG_PRGIS_5	:	if(fsstp)	m_state <= M_PRG_TDIS	;
						else if(f14|f13|f12|f11|f10)
								m_state <= M_PRG_PRGIR	;
						else		m_state <= M_PRG_PRGIS_4;
			M_PRG_PRGIS_4	:	if(fsstp)	m_state <= M_PRG_TDIS	;
						else if(f19|f18|f17|f16|f15)
								m_state <= M_PRG_PRGIR	;
						else		m_state <= M_PRG_PRGIS_3;
			M_PRG_PRGIS_3	:	if(fsstp)	m_state <= M_PRG_TDIS	;
						else if(f24|f23|f22|f21|f20)
								m_state <= M_PRG_PRGIR	;
						else		m_state <= M_PRG_PRGIS_2;
			M_PRG_PRGIS_2	:	if(fsstp)	m_state <= M_PRG_TDIS	;
						else if(f29|f28|f27|f26|f25)
								m_state <= M_PRG_PRGIR	;
						else		m_state <= M_PRG_PRGIS_1;
			M_PRG_PRGIS_1	:	if(fsstp)	m_state <= M_PRG_TDIS	;
						else 		m_state <= M_PRG_PRGIR	;
			M_PRG_PRGIR	:	if(fsstp)	m_state <= M_PRG_TDIS	;
						else		m_state <= M_PRG_TMS_S	;
			M_PRG_TMS_S	:	if(fsstp&stend)
								m_state <= M_PRG_TDIS	;
						else if(stend)	m_state <= M_PRG_FCLK1_S	;
						else		m_state <= M_PRG_TMS_S	;
			M_PRG_FCLK1_S	:	if(fsstp&stend)	m_state <= M_PRG_TDIS	;
						else if(stend)	m_state <= M_PRG_FCLK1R	;
						else		m_state <= M_PRG_FCLK1_S;
			M_PRG_FCLK1R	:	if(seldfl)	m_state <= M_PRG_TDIS	;
						else		m_state <= M_PRG_TWPLS_S	;
			M_PRG_TWPLS_S	:	if(fsstp&stend)	m_state <= M_PRG_TDIS	;
						else if(stend)  m_state <= M_PRG_FCLK2_S;
						else		m_state <= M_PRG_TWPLS_S;
			M_PRG_FCLK2_S	:	if(fsstp&stend) m_state <= M_PRG_TDIS	;
						else if(stend)	m_state <= M_PRG_FCLK2R	;
						else		m_state <= M_PRG_FCLK2_S;
			M_PRG_FCLK2R	:			m_state <= M_PRG_TDIS	;
			M_PRG_TDIS	:			m_state <= M_PRG_TDIS_S	;
			M_PRG_TDIS_S	:	if(stend&fsstp) m_state <= M_LAST	;
						else if(stend)	m_state <= M_PRG_PVSET	;
						else		m_state <= M_PRG_TDIS_S	;			
			M_PRG_PVSET	:			m_state <= M_PRG_CMR_S	;
			M_PRG_CMR_S	:	if(subend)	m_state <= M_PRG_VERI	;
						else		m_state	<= M_PRG_CMR_S	;
			M_PRG_VERI	:	if(~fsstp & fflag & ~rmax) m_state <= M_PRG_RCNTS;
						else		m_state <= M_LAST	;
			M_PRG_RCNTS	:			m_state <= M_PRG_RINC	;
			M_PRG_RINC	:			m_state <= M_PRG_RDCKL	;
// IV
			M_IV_FLAPS	:			m_state <= M_IV_MDSET1	;
			M_IV_MDSET1	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else		m_state <= M_IV_TMS1_S	;
			M_IV_TMS1_S	:	if(fsstp&stend) m_state <= M_IV_TDIS	;
						else if(stend)  m_state <= M_IV_RDCKL1	;
						else		m_state <= M_IV_TMS1_S	;
			M_IV_RDCKL1	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f4|f3|f2)) | f1)
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_16;
			M_IV_RDCKL1_16	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f9|f8|f7|f6|f5))|(f3|f2))
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_15;
			M_IV_RDCKL1_15	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f14|f13|f12|f11|f10))|(f5|f4))
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_14;
			M_IV_RDCKL1_14	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f19|f18|f17|f16|f15))|(f7|f6))
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_13;
			M_IV_RDCKL1_13	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f24|f23|f22|f21|f20))|(f9|f8))
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_12;
			M_IV_RDCKL1_12	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f29|f28|f27|f26|f25))|(f11|f10))
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_11;
			M_IV_RDCKL1_11	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy)|(f13|f12))
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_10;
			M_IV_RDCKL1_10	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f15|f14)
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_9;
			M_IV_RDCKL1_9	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f17|f16)
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_8;
			M_IV_RDCKL1_8	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f19|f18)
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_7;
			M_IV_RDCKL1_7	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f21|f20)
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_6;
			M_IV_RDCKL1_6	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f23|f22)
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_5;
			M_IV_RDCKL1_5	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f25|f24)
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_4;
			M_IV_RDCKL1_4	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f27|f26)
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_3;
			M_IV_RDCKL1_3	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f29|f28)
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_2;
			M_IV_RDCKL1_2	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f30)
								m_state <= M_IV_RDCKH1	;
						else		m_state <= M_IV_RDCKL1_1;
			M_IV_RDCKL1_1	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else 		m_state <= M_IV_RDCKH1	;
			M_IV_RDCKH1	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f4|f3|f2))| f1)
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_16;
			M_IV_RDCKH1_16	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f9|f8|f7|f6|f5))|(f3|f2))
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_15;
			M_IV_RDCKH1_15	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f14|f13|f12|f11|f10))|(f5|f4))
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_14;
			M_IV_RDCKH1_14	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f19|f18|f17|f16|f15))|(f7|f6))
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_13;
			M_IV_RDCKH1_13	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f24|f23|f22|f21|f20))|(f9|f8))
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_12;
			M_IV_RDCKH1_12	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f29|f28|f27|f26|f25))|(f11|f10))
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_11;
			M_IV_RDCKH1_11	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(~lowspy|(f13|f12))
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_10;
			M_IV_RDCKH1_10	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f15|f14)
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_9;
			M_IV_RDCKH1_9	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f17|f16)
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_8;
			M_IV_RDCKH1_8	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f19|f18)
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_7;
			M_IV_RDCKH1_7	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f21|f20)
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_6;
			M_IV_RDCKH1_6	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f23|f22)
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_5;
			M_IV_RDCKH1_5	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f25|f24)
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_4;
			M_IV_RDCKH1_4	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f27|f26)
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_3;
			M_IV_RDCKH1_3	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f29|f28)
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_2;
			M_IV_RDCKH1_2	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f30)
								m_state <= M_IV_RDCKL2	;
						else		m_state <= M_IV_RDCKH1_1;
			M_IV_RDCKH1_1	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else 		m_state <= M_IV_RDCKL2	;
			M_IV_RDCKL2	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else		m_state <= M_IV_FLWSET	;
			M_IV_FLWSET	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f9|f8|f7|f6|f5|f4))|(f3|f2|f1))
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_15	;
			M_IV_RDCKL2_15	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f14|f13|f12|f11|f10))|(f5|f4))
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_14;
			M_IV_RDCKL2_14	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f19|f18|f17|f16|f15))|(f7|f6))
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_13;
			M_IV_RDCKL2_13	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f24|f23|f22|f21|f20))|(f9|f8))
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_12;
			M_IV_RDCKL2_12	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f29|f28|f27|f26|f25))|(f11|f10))
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_11;
			M_IV_RDCKL2_11	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(~lowspy|(f13|f12))
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_10;
			M_IV_RDCKL2_10	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f15|f14)
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_9;
			M_IV_RDCKL2_9	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f17|f16)
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_8;
			M_IV_RDCKL2_8	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f19|f18)
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_7;
			M_IV_RDCKL2_7	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f21|f20)
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_6;
			M_IV_RDCKL2_6	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f23|f22)
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_5;
			M_IV_RDCKL2_5	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f25|f24)
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_4;
			M_IV_RDCKL2_4	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f27|f26)
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_3;
			M_IV_RDCKL2_3	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f29|f28)
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_2;
			M_IV_RDCKL2_2	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f30)
								m_state <= M_IV_RDCKH2	;
						else		m_state <= M_IV_RDCKL2_1;
			M_IV_RDCKL2_1	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else 		m_state <= M_IV_RDCKH2	;
			
			M_IV_RDCKH2	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else		m_state <= M_IV_MDSET2  ;
			M_IV_MDSET2	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else		m_state <= M_IV_MDSET3	;
			M_IV_MDSET3	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else		m_state <= M_IV_TMS2_S	;
			M_IV_TMS2_S	:	if(fsstp&stend) m_state <= M_IV_TDIS	;
						else if(stend)	m_state <= M_IV_RDCKL3	;
						else		m_state <= M_IV_TMS2_S	;
			M_IV_RDCKL3	:	if(fsstp)	m_state	<= M_IV_TDIS	;
						else if((~lowspy&(f4|f3|f2))|f1)
								m_state <= M_IV_RDCKH3		;
						else		m_state <= M_IV_RDCKL3_16	;
			M_IV_RDCKL3_16	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f9|f8|f7|f6|f5))|(f3|f2))
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_15;
			M_IV_RDCKL3_15	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f14|f13|f12|f11|f10))|(f5|f4))
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_14;
			M_IV_RDCKL3_14	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f19|f18|f17|f16|f15))|(f7|f6))
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_13;
			M_IV_RDCKL3_13	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f24|f23|f22|f21|f20))|(f9|f8))
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_12;
			M_IV_RDCKL3_12	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f29|f28|f27|f26|f25))|(f11|f10))
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_11;
			M_IV_RDCKL3_11	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(~lowspy|(f13|f12))
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_10;
			M_IV_RDCKL3_10	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f15|f14)
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_9;
			M_IV_RDCKL3_9	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f17|f16)
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_8;
			M_IV_RDCKL3_8	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f19|f18)
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_7;
			M_IV_RDCKL3_7	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f21|f20)
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_6;
			M_IV_RDCKL3_6	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f23|f22)
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_5;
			M_IV_RDCKL3_5	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f25|f24)
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_4;
			M_IV_RDCKL3_4	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f27|f26)
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_3;
			M_IV_RDCKL3_3	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f29|f28)
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_2;
			M_IV_RDCKL3_2	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f30)
								m_state <= M_IV_RDCKH3	;
						else		m_state <= M_IV_RDCKL3_1;
			M_IV_RDCKL3_1	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else 		m_state <= M_IV_RDCKH3	;
			M_IV_RDCKH3	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f4|f3|f2))|f1)
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_16;
			M_IV_RDCKH3_16	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f9|f8|f7|f6|f5))|(f3|f2))
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_15;
			M_IV_RDCKH3_15	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f14|f13|f12|f11|f10))|(f5|f4))
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_14;
			M_IV_RDCKH3_14	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f19|f18|f17|f16|f15))|(f7|f6))
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_13;
			M_IV_RDCKH3_13	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f24|f23|f22|f21|f20))|(f9|f8))
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_12;
			M_IV_RDCKH3_12	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f29|f28|f27|f26|f25))|(f11|f10))
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_11;
			M_IV_RDCKH3_11	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(~lowspy|(f13|f12))
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_10;
			M_IV_RDCKH3_10	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f15|f14)
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_9;
			M_IV_RDCKH3_9	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f17|f16)
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_8;
			M_IV_RDCKH3_8	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f19|f18)
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_7;
			M_IV_RDCKH3_7	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f21|f20)
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_6;
			M_IV_RDCKH3_6	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f23|f22)
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_5;
			M_IV_RDCKH3_5	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f25|f24)
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_4;
			M_IV_RDCKH3_4	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f27|f26)
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_3;
			M_IV_RDCKH3_3	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f29|f28)
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_2;
			M_IV_RDCKH3_2	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f30)
								m_state <= M_IV_RDCKL4	;
						else		m_state <= M_IV_RDCKH3_1;
			M_IV_RDCKH3_1	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else 		m_state <= M_IV_RDCKL4	;
			M_IV_RDCKL4	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else		m_state <= M_IV_FLRSET	;
			M_IV_FLRSET	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f9|f8|f7|f6|f5|f4))|(f3|f2|f1))
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_15;
			M_IV_RDCKL4_15	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy&(f14|f13|f12|f11|f10))|(f5|f4))
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_14;
			M_IV_RDCKL4_14	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f19|f18|f17|f16|f15))|(f7|f6))
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_13;
			M_IV_RDCKL4_13	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f24|f23|f22|f21|f20))|(f9|f8))
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_12;
			M_IV_RDCKL4_12	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if((~lowspy &(f29|f28|f27|f26|f25))|(f11|f10))
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_11;
			M_IV_RDCKL4_11	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(~lowspy|(f13|f12))
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_10;
			M_IV_RDCKL4_10	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f15|f14)
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_9;
			M_IV_RDCKL4_9	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f17|f16)
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_8;
			M_IV_RDCKL4_8	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f19|f18)
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_7;
			M_IV_RDCKL4_7	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f21|f20)
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_6;
			M_IV_RDCKL4_6	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f23|f22)
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_5;
			M_IV_RDCKL4_5	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f25|f24)
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_4;
			M_IV_RDCKL4_4	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f27|f26)
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_3;
			M_IV_RDCKL4_3	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(f29|f28)
								m_state <= M_IV_VERI	;
						else		m_state <= M_IV_RDCKL4_2;
			M_IV_RDCKL4_2	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else 		m_state <= M_IV_VERI	;
			M_IV_VERI	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else if(~vceq)	m_state <= M_IV_FMDR	;
						else if(faddress)
								m_state <= M_IV_TDIS	;
						else		m_state <= M_IV_MDSET4	;
			M_IV_MDSET4	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else		m_state <= M_IV_MDSET5	;
			M_IV_MDSET5	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else		m_state <= M_IV_TMS3_S	;
			M_IV_TMS3_S	:	if(fsstp&stend) m_state <= M_IV_TDIS	;
						else if(stend)	m_state <= M_IV_ACNT1	;
						else		m_state <= M_IV_TMS3_S	;
			M_IV_ACNT1	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else		m_state <= M_IV_ASET1	;
			M_IV_ASET1	:	if(fsstp)	m_state <= M_IV_TDIS	;
						else		m_state <= M_IV_RDCKL1	;
			M_IV_FMDR	:			m_state <= M_IV_TDIS	;
			M_IV_TDIS	:			m_state <= M_IV_TDIS_S	;
			M_IV_TDIS_S	:	if(stend)	m_state <= M_LAST	;
						else		m_state <= M_IV_TDIS_S	;
// BC/READ
			M_BCR_VDSET	:			m_state <= M_BCR_CMR_S	;
			M_BCR_CMR_S	:	if(subend)	m_state <= M_LAST	;
						else 		m_state <= M_BCR_CMR_S	;
// Erase
			M_ERA_ASET	:			m_state	<= M_ERA_BEUSET	;
			M_ERA_BEUSET	:			m_state <= M_ERA_CMR0_S ;
//			M_ERA_VDSET0	:			m_state <= M_ERA_CMR0_S	;
			M_ERA_CMR0_S	:	if(fsstp&subend)m_state <= M_LAST	;
						else if(subend) m_state <= M_ERA_VERI0	;
						else		m_state <= M_ERA_CMR0_S	;
			M_ERA_VERI0	: 	if(fsstp) 	m_state <= M_LAST	;
						else if(~fflag&faddress)
								m_state <= M_LAST	;
						else if(~fflag)   m_state <= M_ERA_SCNTS	;
						else		m_state <= M_ERA_AERSET	;
			M_ERA_AERSET	:			m_state <= M_ERA_RDCKL	;
			M_ERA_RDCKL	:			m_state <= M_ERA_WAIT	;
			M_ERA_WAIT	:	if(fsstp)	m_state <= M_LAST	;
						else		m_state <= M_ERA_MDSET	;
			M_ERA_MDSET	:	if(fsstp)	m_state <= M_ERA_TDIS	;
						else		m_state <= M_ERA_TMS_S	;
			M_ERA_TMS_S	:	if(fsstp&stend) m_state <= M_ERA_TDIS	;
						else if(stend)	m_state <= M_ERA_FCLK_S	;
						else		m_state <= M_ERA_TMS_S	;
			M_ERA_FCLK_S	:	if(stend)	m_state <= M_ERA_FCLKR	;
						else		m_state	<= M_ERA_FCLK_S	;
			M_ERA_FCLKR	:			m_state <= M_ERA_TDIS	;
			M_ERA_TDIS	:			m_state	<= M_ERA_TDIS_S	;
			M_ERA_TDIS_S	:	if(fsstp&stend)	m_state <= M_LAST	;
						else if(stend)	m_state <= M_ERA_VDSET	;
						else		m_state <= M_ERA_TDIS_S	;
			M_ERA_VDSET	:			m_state	<= M_ERA_CMR_S	;
			M_ERA_CMR_S	:	if(subend&fsstp)	m_state <= M_LAST	;
						else if(subend)	m_state	<= M_ERA_VERI	;
						else		m_state	<= M_ERA_CMR_S	;
			M_ERA_VERI	:	if(fsstp)	m_state	<= M_LAST	;
						else if(~rmax & fflag)
								m_state	<= M_ERA_RCNTS	;
						else if(~faddress&~fflag)
								m_state <= M_ERA_SCNTS	;
						else		m_state	<= M_LAST	;
			M_ERA_RCNTS	:			m_state	<= M_ERA_RINC	;
			M_ERA_RINC	:			m_state	<= M_ERA_AERSET	;
			M_ERA_SCNTS	:			m_state	<= M_ERA_SINC	;
			M_ERA_SINC	:			m_state	<= M_ERA_BEUSET	;
//			M_ERA_RSMS	:			m_state	<= M_ERA_SFSET	;
//			M_ERA_SFSET	:			m_state	<= M_LAST	;
			M_LAST		:			m_state <= M_IGEN	;
			M_IGEN		:			m_state <= M_ICLR	;
			M_ICLR		:if(~sqst)		m_state <= M_END	;
					 else			m_state <= M_ICLR	;
			default		:			m_state <= M_INIT	;
		endcase
	end		


	assign cmr_start = ( m_state == M_PRG_CMR_S ) | ( m_state == M_BCR_CMR_S ) |
			   ( m_state == M_ERA_CMR0_S )| ( m_state == M_ERA_CMR_S )	;
	assign subend    = ( s_state == S_LAST	    )					;
	assign stend	 = ( st_state == ST_C_LAST  )					; 

// State Machine( Sub )
	always @( posedge pclk or negedge resz ) begin
		if(~resz )					s_state <= S_INIT	;
		else
		case(s_state)
			S_INIT		:	if(cmr_start)	s_state <= S_CMR_MDSET	;
						else		s_state <= S_INIT	;
			S_CMR_MDSET	:	if(fsstp)	s_state <= S_SSMD	;
						else		s_state <= S_CMR_TMS_S	;
			S_CMR_TMS_S	:	if(fsstp&stend)
								s_state <= S_SSMD	;
						else if(stend)	s_state <= S_CMR_ASET1	;
						else		s_state <= S_CMR_TMS_S	;
			S_CMR_ASET1	:	if(fsstp)	s_state <= S_SSMD	;
						else		s_state <= S_CMR_RDCKL1	;
			S_CMR_RDCKL1	:	if(fsstp)	s_state <= S_SSMD	;
						else		s_state <= S_CMR_RDCKL1_W ;
			S_CMR_RDCKL1_W  :       if(fsstp)	s_state <= S_SSMD	;
						else		s_state <= S_CMR_RDCKL1_16 ;
			S_CMR_RDCKL1_16	:	if(fsstp)	s_state	<= S_SSMD	;
						else if ((f5|f4|f3|f2|f1) | 
							(~lowspy & (f14|f13|f12|f11|f10|f9|f8|f7|f6)))
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_15 ;
			S_CMR_RDCKL1_15 :	if(fsstp)	s_state <= S_SSMD	;
						else if ((f7|f6)|(~lowspy & (f19|f18|f17|f16|f15)))
								s_state <= S_CMR_RDCKH1 ;
						else		s_state <= S_CMR_RDCKL1_14 ;
			S_CMR_RDCKL1_14 :	if(fsstp)	s_state <= S_SSMD	;
						else if ((f9|f8)|(~lowspy & (f24|f23|f22|f21|f20)))
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_13 ;
			S_CMR_RDCKL1_13	:	if(fsstp)	s_state <= S_SSMD	;
						else if ((f11|f10)|(~lowspy & (f29|f28|f27|f26|f25)))
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_12 ;
			S_CMR_RDCKL1_12	:	if(fsstp)	s_state <= S_SSMD	;
						else if ((f13|f12)|(~lowspy))
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_11 ;
			S_CMR_RDCKL1_11	:	if(fsstp)	s_state <= S_SSMD	;
						else if (f15|f14)
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_10 ;
			S_CMR_RDCKL1_10	:	if(fsstp)	s_state <= S_SSMD	;
						else if (f17|f16)
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_9 ;
			S_CMR_RDCKL1_9	:	if(fsstp)	s_state <= S_SSMD	;
						else if (f19|f18)
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_8 ;
			S_CMR_RDCKL1_8	:	if(fsstp)	s_state <= S_SSMD	;
						else if (f21|f20)
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_7 ;
			S_CMR_RDCKL1_7	:	if(fsstp)	s_state <= S_SSMD	;
						else if (f23|f22)
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_6 ;
			S_CMR_RDCKL1_6	:	if(fsstp)	s_state <= S_SSMD	;
						else if (f25|f24)
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_5 ;
			S_CMR_RDCKL1_5	:	if(fsstp)	s_state <= S_SSMD	;
						else if (f27|f26)
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_4 ;
			S_CMR_RDCKL1_4	:	if(fsstp)	s_state <= S_SSMD	;
						else if (f29|f28)
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_3 ;
			S_CMR_RDCKL1_3	:	if(fsstp)	s_state <= S_SSMD	;
						else if (f30)
								s_state <= S_CMR_RDCKH1	;
						else		s_state <= S_CMR_RDCKL1_2 ;
			S_CMR_RDCKL1_2	:	if(fsstp)	s_state <= S_SSMD	;
						else		s_state <= S_CMR_RDCKH1	;
			S_CMR_RDCKH1	:	if(fsstp)	s_state <= S_SSMD	;
						else		s_state <= S_CMR_ASET2;
			S_CMR_ASET2	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if((f3|f2|f1)|(~lowspy & f4))
								s_state <= S_CMR_RDCKL2 ;
						else		s_state <= S_CMR_RDCKH1_16 ;
			S_CMR_RDCKH1_16	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if ((f5|f4)|(~lowspy & (f14|f13|f12|f11|f10|f9|f8|f7|f6)))
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_15;
			S_CMR_RDCKH1_15	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if ((f7|f6)|(~lowspy & (f19|f18|f17|f16|f15)))
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_14;
			S_CMR_RDCKH1_14	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if ((f9|f8)|(~lowspy & (f24|f23|f22|f21|f20)))
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_13;
			S_CMR_RDCKH1_13	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if ((f11|f10)|(~lowspy & (f29|f28|f27|f26|f25)))
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_12;		
			S_CMR_RDCKH1_12	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if ((f13|f12)|(~lowspy))
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_11;
			S_CMR_RDCKH1_11	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if (f15|f14)
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_10;
			S_CMR_RDCKH1_10	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if (f17|f16)
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_9;	
			S_CMR_RDCKH1_9	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if (f19|f18)
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_8;
			S_CMR_RDCKH1_8	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if (f21|f20)
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_7;
			S_CMR_RDCKH1_7	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if (f23|f22)
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_6;
			S_CMR_RDCKH1_6	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if (f25|f24)
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_5;
			S_CMR_RDCKH1_5	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if (f27|f26)
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_4;
			S_CMR_RDCKH1_4	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if (f29|f28)
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_3;
			S_CMR_RDCKH1_3	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if (f30)
								s_state <= S_CMR_RDCKL2	;
						else		s_state <= S_CMR_RDCKH1_2;
			S_CMR_RDCKH1_2	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else		s_state <= S_CMR_RDCKL2	;
			S_CMR_RDCKL2	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else		s_state	<= S_CMR_FLRSET	;
			S_CMR_FLRSET	:	if(fsstp)	s_state	<= S_CMR_ASET3	;
						else if(act5)		s_state	<= S_CMR_DSS		;
						else			s_state <= S_CMR_RDCKL2_16	;
			S_CMR_DSS	:	if(fsstp)		s_state <= S_CMR_ASET3		;
						else if(dseten)		s_state	<= S_CMR_DSC		;
						else			s_state <= S_CMR_DSS		;
			S_CMR_DSC	:	if(fsstp)	s_state <= S_CMR_ASET3		;
						else if(~dseten)s_state	<= S_CMR_RDCKL2_16	;
						else		s_state <= S_CMR_DSC	;
			S_CMR_RDCKL2_16	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if((f7|f6|f5|f4|f3|f2|f1)|( 
							~lowspy&(f19|f18|f17|f16|f15|f14|f13|f12|f11|f10|f9|f8)))
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_15;
			S_CMR_RDCKL2_15	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if((f9|f8)|(~lowspy&(f24|f23|f22|f21|f20)))
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_14;
			S_CMR_RDCKL2_14	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if((f11|f10)|(~lowspy&(f29|f28|f27|f26|f25)))
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_13;
			S_CMR_RDCKL2_13	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if((f13|f12)|(~lowspy))
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_12;
			S_CMR_RDCKL2_12	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if(f15|f14)
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_11;
			S_CMR_RDCKL2_11	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if(f17|f16)
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_10;
			S_CMR_RDCKL2_10	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if(f19|f18)
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_9;
			S_CMR_RDCKL2_9	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if(f21|f20)
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_8;
			S_CMR_RDCKL2_8	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if(f23|f22)
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_7;
			S_CMR_RDCKL2_7	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if(f25|f24)
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_6;
			S_CMR_RDCKL2_6	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if(f27|f26)
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_5;
			S_CMR_RDCKL2_5	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if(f29|f28)
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_4;
			S_CMR_RDCKL2_4	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else if(f30)
								s_state	<= S_CMR_VERI	;
						else		s_state <= S_CMR_RDCKL2_3;
			S_CMR_RDCKL2_3	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else            s_state	<= S_CMR_VERI	;
			S_CMR_VERI	:	if(fsstp)	s_state	<= S_CMR_ASET3	;
						else if(~vceq & ~act5)	s_state <= S_CMR_FMDR	;
						else if(faddressl)
								s_state <= S_CMR_ASET3	;
						else		s_state	<= S_CMR_RDCKH2	;
			S_CMR_RDCKH2	:	if(fsstp)	s_state <= S_CMR_ASET3	;
						else		s_state <= S_CMR_ASET2	;
			S_CMR_FMDR	:			s_state <= S_CMR_ASET3	;
			S_CMR_ASET3	:			s_state <= S_CMR_ADEC	;
			S_CMR_ADEC	:			s_state <= S_SSMD	;		
// forcible stop
			S_SSMD		:			s_state <= S_TDIS	;
			S_TDIS		:			s_state <= S_TDIS_S	;
			S_TDIS_S	:	if(stend)	s_state <= S_LAST	;
						else		s_state <= S_TDIS_S	;
			default		:			s_state <= S_INIT	;
		endcase
	end


// Sub Sub state start signal
	assign tms_start = (m_state == M_PRG_FCLK1_S ) | (m_state == M_PRG_FCLK2_S ) |
			   (s_state == S_TDIS_S     )  | (s_state == S_CMR_TMS_S  )   |
			   (m_state == M_ERA_TMS_S)    | (m_state == M_ERA_FCLK_S )   |
			   (m_state == M_ERA_TDIS_S)   |
			   (m_state == M_PRG_TMS_S)    | (m_state == M_PRG_TWPLS_S )  |
			   (m_state == M_DIS_S)	       | (m_state == M_PRG_TDIS_S )   |
			   (m_state == M_IV_TMS1_S)    | (m_state == M_IV_TMS2_S  )   |
			   (m_state == M_IV_TMS3_S)    | (m_state == M_IV_TDIS_S  )   ;


	assign ststop = (fsstp) & ~((m_state==M_PRG_TDIS_S) | (m_state==M_IV_TDIS_S) | 
					 (m_state==M_ERA_TDIS_S) | (s_state==S_TDIS_S   )) ;
// State Machine (Sub Sub)
	always @( posedge pclk or negedge resz ) begin
		if( ~resz )	st_state <= ST_INIT	;
		else
		case(st_state)
			ST_INIT		: if(tms_start)	st_state <= ST_REGSET	;
					  else		st_state <= ST_INIT	;
			ST_REGSET	: if(ststop)	st_state <= ST_C_LAST	;
					  else		st_state <= ST_C_SET	;
			ST_C_SET	: if(ststop)	st_state <= ST_C_LAST	;
					  else		st_state <= ST_C_COUNT	;
			ST_C_COUNT	: if(ststop | eq)	
							st_state <= ST_C_LAST	;
					  else		st_state <= ST_C_COUNT  ;
			default		:		st_state <= ST_INIT	;
		  endcase
		end
//***************************************************************************************
//** RDCLKP1
//***************************************************************************************
	assign rdclkp1in = ~((m_state == M_PRG_RDCKL ) 	| (s_state == S_CMR_RDCKL1 ) |
			     (s_state == S_CMR_RDCKL2)  | (m_state == M_IV_RDCKL1  ) |
			     (m_state == M_IV_RDCKL2 )	| (m_state == M_IV_RDCKL3  ) |
			     (m_state == M_IV_RDCKL4 )	|(m_state == M_ERA_RDCKL )	);

	assign sdrdclken = (m_state == M_PRG_RDCKL  )	| (m_state == M_PRG_WAIT  )	|
			   (s_state == S_CMR_RDCKL1 )	| (s_state == S_CMR_RDCKH1 )	|
			   (s_state == S_CMR_RDCKH2 )	|
			   (s_state == S_CMR_RDCKL2 )	| (s_state == S_SSMD)		| 
			   (m_state == M_IV_RDCKL1  )	| (m_state == M_IV_TDIS)	|
			   (m_state == M_IV_RDCKH1  )   | (m_state == M_IV_RDCKL2  )	|
			   (m_state == M_IV_RDCKH2  )	| (m_state == M_IV_RDCKL3  )	|
			   (m_state == M_IV_RDCKH3  )	| (m_state == M_IV_RDCKL4  )	|
			   (m_state == M_IV_VERI    )   | (m_state == M_ERA_RDCKL  )	|
			   (m_state == M_ERA_WAIT  )	| (s_state == S_CMR_ASET3  )    ;
// PROGI
	assign progin	= ( m_state == M_PRG_PRGIS )					;
	assign sprogien = ( m_state == M_PRG_PRGIS ) | ( m_state == M_PRG_PRGIR ) |
			  ( m_state == M_PRG_TDIS  )					;
// FCLK
	assign fclkin	= ( m_state == M_PRG_FCLK1_S ) | ( m_state == M_ERA_FCLK_S )	;
	assign sfclken  = ( m_state == M_PRG_FCLK1_S ) | ( m_state == M_PRG_FCLK1R ) |
			  ( m_state == M_ERA_FCLK_S  ) | ( m_state == M_ERA_FCLKR  ) |
			  ( m_state == M_ERA_TDIS    ) | ( m_state == M_PRG_TDIS   )	;

	assign fclk2in	= ( m_state == M_PRG_FCLK2_S) 	;
	assign sfclk2en  = ( m_state == M_PRG_FCLK2_S ) | ( m_state == M_PRG_FCLK2R ) | ( m_state == M_PRG_TDIS );

//*******************************************************************************************
//**  Mode control
//*******************************************************************************************
	assign  readin   = ( s_state == S_CMR_MDSET ) & act5 & ~seldfl ;
	assign dreadin 	 = ( s_state == S_CMR_MDSET ) & act5 &  seldfl ;
	assign	 wwrin	 = ( m_state == M_PRG_MDSET ) & ~seldfl	; 
	assign	dwwrin	 = ( m_state == M_PRG_MDSET ) &  seldfl	;
	assign   serin	 = ( m_state == M_ERA_MDSET ) & ~seldfl & act4 ;
	assign  dserin   = ( m_state == M_ERA_MDSET ) &  seldfl & act4 ;
	assign   cerin	 = ( m_state == M_ERA_MDSET ) & ~seldfl & act6 ;
	assign  dcerin   = ( m_state == M_ERA_MDSET ) &  seldfl & act6 ;
	assign   mrg00in = ( s_state == S_CMR_MDSET ) & act1 & ~seldfl 	;
	assign  dmrg00in = ( s_state == S_CMR_MDSET ) & act1 &  seldfl 	;
	assign   mrg01in = (( m_state == M_IV_MDSET1 ) | ( m_state == M_IV_MDSET4) ) & ~seldfl  ;
	assign  dmrg01in = (( m_state == M_IV_MDSET1 ) | ( m_state == M_IV_MDSET4) ) &  seldfl  ;
	assign   mrg12in = (( m_state == M_IV_MDSET2 ) | (( s_state == S_CMR_MDSET ) & act3)) &  mdch & ~seldfl ;
	assign  dmrg12in = (( m_state == M_IV_MDSET2 ) | (( s_state == S_CMR_MDSET ) & act3)) &  mdch &  seldfl ;
	assign   mrg11in = (( m_state == M_IV_MDSET2 ) | (( s_state == S_CMR_MDSET ) & act3)) & ~mdch & ~seldfl ;
	assign  dmrg11in = (( m_state == M_IV_MDSET2 ) | (( s_state == S_CMR_MDSET ) & act3)) & ~mdch &  seldfl ;
	assign   mrg10in = ( s_state == S_CMR_MDSET ) & (act4 | act6 ) & ~seldfl ;
	assign  dmrg10in = ( s_state == S_CMR_MDSET ) & (act4 | act6 ) &  seldfl ;	
	
	assign  readen   = (( s_state == S_CMR_MDSET )|(s_state == S_TDIS)) & act5 & ~seldfl ;
	assign dreaden 	 = (( s_state == S_CMR_MDSET )|(s_state == S_TDIS)) & act5 &  seldfl ;
	assign  mrg10en  = (( s_state == S_CMR_MDSET )|(s_state == S_TDIS)) & (act4 | act6 ) & ~seldfl	;
	assign  dmrg10en = (( s_state == S_CMR_MDSET )|(s_state == S_TDIS)) & (act4 | act6 ) &  seldfl	;


	assign  mrg11en  =  ((( m_state == M_IV_MDSET2 )| (m_state == M_IV_MDSET5) | (m_state==M_IV_TDIS)) | 
			    ((( s_state == S_CMR_MDSET) | (s_state==S_TDIS)) & act3)) & ~mdch & ~seldfl ;
	assign  dmrg11en =  ((( m_state == M_IV_MDSET2 )| (m_state == M_IV_MDSET5) | (m_state==M_IV_TDIS)) | 
			    ((( s_state == S_CMR_MDSET) | (s_state==S_TDIS)) & act3)) & ~mdch &  seldfl ;
	assign  mrg12en  =  ((( m_state == M_IV_MDSET2 )| (m_state == M_IV_MDSET5) | (m_state==M_IV_TDIS)) | 
			    ((( s_state == S_CMR_MDSET) | (s_state==S_TDIS)) & act3)) &  mdch & ~seldfl ;
	assign  dmrg12en =  ((( m_state == M_IV_MDSET2 )| (m_state == M_IV_MDSET5) | (m_state==M_IV_TDIS)) | 
			    ((( s_state == S_CMR_MDSET) | (s_state==S_TDIS)) & act3)) &  mdch &  seldfl ;

	assign  wwren	= (( m_state == M_PRG_MDSET )|(m_state == M_PRG_TDIS)) & ~seldfl	;
	assign  dwwren  = (( m_state == M_PRG_MDSET )|(m_state == M_PRG_TDIS)) &  seldfl  	;
	assign  seren   = (( m_state == M_ERA_MDSET )|(m_state == M_ERA_TDIS)) & ~seldfl & act4	;
	assign  dseren  = (( m_state == M_ERA_MDSET )|(m_state == M_ERA_TDIS)) &  seldfl & act4 ;
	assign  ceren   = (( m_state == M_ERA_MDSET )|(m_state == M_ERA_TDIS)) & ~seldfl & act6	;
	assign  dceren  = (( m_state == M_ERA_MDSET )|(m_state == M_ERA_TDIS)) &  seldfl & act6 ;
	assign  mrg00en = (( s_state == S_CMR_MDSET )|(s_state == S_TDIS)) & act1 & ~seldfl ;
	assign  dmrg00en =(( s_state == S_CMR_MDSET )|(s_state == S_TDIS)) & act1 &  seldfl ;
	assign  mrg01en = (( m_state == M_IV_MDSET1 )|(m_state == M_IV_MDSET3 )| ( m_state == M_IV_MDSET4 )|
			   ( m_state == M_IV_TDIS)) & ~seldfl ;
	assign  dmrg01en = (( m_state == M_IV_MDSET1 )|(m_state == M_IV_MDSET3 )|( m_state == M_IV_MDSET4 )|
			   ( m_state == M_IV_TDIS)) & seldfl ;
	
	
	assign	disin	= ~(wwrin | mrg00in  |  mrg01in |  mrg11in | mrg12in  | serin  | cerin  | mrg10in  | readin )   ;
	assign	ddisin	= ~(dwwrin| dmrg00in | dmrg01in | dmrg11in | dmrg12in | dserin | dcerin | dmrg10in | dreadin )   ;
	assign	disen	=  ((m_state == M_DIS)      | (m_state == M_PRG_MDSET) | (m_state == M_PRG_TDIS)  | 
			   (m_state == M_IV_MDSET1) | (s_state == S_CMR_MDSET) | (s_state == S_TDIS) |
			   (m_state == M_IV_TDIS  ) | (m_state == M_ERA_MDSET) | (m_state == M_ERA_TDIS) )&~seldfl ;
	assign	ddisen	=  ((m_state == M_DIS)	    |
			   (m_state == M_PRG_MDSET) | (m_state == M_PRG_TDIS)  | 
			   (m_state == M_IV_MDSET1) | (s_state == S_CMR_MDSET) | (s_state == S_TDIS)|
			   (m_state == M_IV_TDIS  ) | (m_state == M_ERA_MDSET) | (m_state == M_ERA_TDIS) )& seldfl ;

//**************************************************************************************
//  address control
//**************************************************************************************
	assign safen	= ((s_state == S_CMR_ASET1 )&~act4)|	// There is a case of (FLAP != AF) in act4.
			  ((s_state == S_CMR_ASET2)&(~faddress))  |  
			  (m_state == M_DIS      )   | ((s_state == S_CMR_ADEC)&(~faddressl))|
			  ( m_state == M_IV_FLAPS)   | (m_state == M_IV_ASET1  )|
			  ( m_state == M_PRG_RDCKL ) | 
			  ( m_state == M_ERA_ASET)   | (m_state == M_ERA_SINC  )	;
	assign sinafen  = ( m_state == M_ERA_AERSET )					;
	assign afsel    = ( s_state == S_CMR_ASET2 ) | ( m_state == M_IV_ASET1) |
			  ( m_state == M_ERA_SINC)   | ( s_state == S_CMR_ADEC)	;
	

//**************************************************************************************
//** BEU control
//*************************************************************************************
	wire [13:12]	dflsedd= flsed[13:12] ;
	reg [13:12] dflsed;
	always@(dflsedd[13:12])begin
		case(dflsedd[13:12])
		2'b01:		dflsed[13:12] = 2'b00 ;
		2'b10:		dflsed[13:12] = 2'b01 ;
		2'b11:		dflsed[13:12] = 2'b10 ;
		default:	dflsed[13:12] = 2'b11 ;
		endcase
	end

	wire [19:10] flsedb = seldfl ? {flsed[19:16], 2'b00, dflsed[13:12], flsed[11:10]} : flsed[19:10]	;
	wire [19:10]	afb = af[19:10]		;

	always@(flsedb[19:10] or afb[19:10] ) begin
         if(flsedb[19:10] - afb[19:10] >= 10'h07f) begin    // 128K
		if(afb[16:10] == 7'b0000000) pbeu = 3'b111 	;
		else if(afb[15:10] == 6'b000000 ) pbeu = 3'b110 ;
		else if(afb[14:10] ==  5'b00000 ) pbeu = 3'b101 ;
		else if(afb[13:10] ==   4'b0000 ) pbeu = 3'b100 ;
		else if(afb[12:10] ==    3'b000 ) pbeu = 3'b011 ;
		else if(afb[11:10] ==     2'b00 ) pbeu = 3'b010 ;
		 else if(afb[10]   ==      1'b0 ) pbeu = 3'b001 ;
		else				  pbeu = 3'b000 ;
	end else if(flsedb[19:10] - afb[19:10] >= 10'h03f) begin // 64K
		if(afb[15:10] == 6'b000000) pbeu = 3'b110 	;
		else if(afb[14:10] == 5'b00000 ) pbeu = 3'b101  ;
		else if(afb[13:10] ==  4'b0000 ) pbeu = 3'b100  ;
		else if(afb[12:10] ==   3'b000 ) pbeu = 3'b011  ;
		else if(afb[11:10] ==    2'b00 ) pbeu = 3'b010  ;
		else if(afb[10] ==        1'b0 ) pbeu = 3'b001  ;
		else				 pbeu = 3'b000  ;
	end else if(flsedb[19:10] - afb[19:10] >= 10'h01f) begin  // 32K
		if(afb[14:10] == 5'b00000) pbeu = 3'b101 	;
		else if(afb[13:10] == 4'b0000 ) pbeu = 3'b100   ;
		else if(afb[12:10] ==  3'b000 ) pbeu = 3'b011   ;
		else if(afb[11:10] ==   2'b00 ) pbeu = 3'b010   ;
		else if(afb[10]    ==    1'b0 ) pbeu = 3'b001   ;
		else			        pbeu = 3'b000  ;
	end else if(flsedb[19:10] - afb[19:10] >= 10'h00f) begin  // 16K
 		if(afb[13:10] == 4'b0000)       pbeu = 3'b100 	;
		else if(afb[12:10] == 3'b000 )  pbeu = 3'b011   ;
		else if(afb[11:10] ==  2'b00 )  pbeu = 3'b010   ;
		else if(afb[10]    ==   1'b0 )  pbeu = 3'b001   ;
		else			        pbeu = 3'b000  ;
	end else if(flsedb[19:10] - afb[19:10] >= 10'h007) begin   // 8K
		if(afb[12:10] == 3'b000)        pbeu = 3'b011 	;
		else if(afb[11:10] == 2'b00 )   pbeu = 3'b010   ;
		else if(afb[10]    == 1'b0  )   pbeu = 3'b001   ;
		else			        pbeu = 3'b000  ;
	end else if(flsedb[19:10] - afb[19:10] >= 10'h003) begin  // 4K
		if(afb[11:10] == 2'b00)         pbeu = 3'b010 	;
		else if(afb[10] == 1'b0 )       pbeu = 3'b001   ;
		else			        pbeu = 3'b000   ;
        end else if(flsedb[19:10] - afb[19:10] >= 10'h001) begin  // 2K
		if(afb[10] == 1'b0)             pbeu = 3'b001 	;
		else			        pbeu = 3'b000   ;
	end else			  pbeu = 3'b000 	;
   end
	


	always @( posedge pclk or negedge resz)	begin
	  if(~resz)					beu <= 3'b000 			;
	  else if((m_state==M_ERA_BEUSET))		beu <= pbeu			;
	  else if(m_state==M_LAST)			beu <= 3'b000			;
	  else if(we_fltmsh)				beu <= {dhin2, dhin1, dhin0 }	;
	  else						beu <= beu			;
	end

//  flr register write
	assign sflren	= (s_state == S_CMR_FLRSET ) | ( m_state == M_IV_FLRSET ) ;

//**************************************************************************
//  flw register write
//**************************************************************************
	
	assign sflwen	= ( m_state == M_IV_FLWSET  )					;
	assign sflw1en	= ( m_state == M_ERA_CMR0_S ) | (m_state == M_ERA_CMR_S ) | 
			  ((m_state == M_BCR_CMR_S) & act3)	;

//**************************************************************************
//  FCPU control
//**************************************************************************
	assign xregen = (st_state == ST_C_COUNT ) | (s_state == S_CMR_RDCKH2 ) |
			(s_state == S_CMR_RDCKH1 ) | (m_state == M_PRG_RCNTS)  |
			(m_state == M_IV_ACNT1 ) | (m_state == M_ERA_RCNTS)  |
			(m_state == M_ERA_SCNTS) | (s_state == S_CMR_ASET3)	;
	assign xregclr = (st_state == ST_REGSET )| (m_state == M_XINIT)      |
			 (m_state == M_RESET)    | (m_state == M_LAST)		;
	assign xregld = (m_state == M_PRG_RCNTS	)| (m_state == M_ERA_RCNTS)  	;
	assign yregen = (st_state == ST_REGSET ) | 
			(s_state == S_CMR_RDCKH2) | (s_state == S_CMR_RDCKH1 )  |
			(m_state == M_PRG_RCNTS) | (m_state == M_IV_ACNT1 )  |
			(m_state == M_ERA_RCNTS) | (m_state == M_ERA_SCNTS)  |
			(s_state == S_CMR_ASET3) |
			(m_state == M_RESET)    | (m_state == M_LAST)		;
	assign zregoe = (m_state == M_PRG_RCNTS) | (m_state == M_ERA_RCNTS )	;
	assign zregen = (m_state == M_PRG_RINC ) | (m_state == M_ERA_RINC  ) | (m_state == M_RESET )	;
	assign ope0     = (st_state == ST_C_SET )       | (st_state == ST_C_COUNT ) | 
			 (s_state == S_CMR_ASET2 ) | (m_state == M_PRG_RINC  ) |
			 (m_state == M_IV_ASET1 )      | (m_state == M_ERA_RINC  ) |
			 (m_state == M_ERA_SINC )	;
	assign ope1	= (s_state == S_CMR_ADEC )	;
//	assign alust   = (st_state == ST_C_COUNT )	;
	assign eqact   = (st_state == ST_C_COUNT )| (m_state == M_PRG_RINC  ) | (m_state == M_ERA_RINC)	;
	assign flapsel = (s_state == S_CMR_RDCKH1 ) | (s_state == S_CMR_RDCKH2) | (s_state == S_CMR_ASET3 ) |
			 (m_state  == M_ERA_SCNTS)| (m_state == M_IV_ACNT1  )	;
 
	
	always @( st_state or m_state or seldfl)	begin
	  if(m_state == M_PRG_RCNTS)		yregdin = 2'b01 		;
	else if(m_state == M_ERA_RCNTS)		yregdin = 2'b01 		;
	else if(st_state == ST_REGSET)		yregdin = 2'b01 		;
	else					yregdin = {~seldfl, seldfl} 	;
	end


//***********************************************************
// faddress
//***********************************************************
	
	wire[16:10] aff =  af[16:10]  	;
	
	always@(beu[2:0] or aff[16:10]) begin
	case(beu[2:0])
		3'b001	:	fsectad = aff[16:10] | 7'b0000001 ; // 2Kbyte
		3'b010	:	fsectad = aff[16:10] | 7'b0000011 ; // 4Kbyte
		3'b011  :	fsectad = aff[16:10] | 7'b0000111 ; // 8Kbyte
		3'b100  :	fsectad = aff[16:10] | 7'b0001111 ; // 16Kbyte
		3'b101	:	fsectad = aff[16:10] | 7'b0011111 ; // 32Kbyte
		3'b110  :	fsectad = aff[16:10] | 7'b0111111 ; // 64Kbyte
		3'b111	:	fsectad = aff[16:10] | 7'b1111111 ; // 128Kbyte
		default	:	fsectad = aff[16:10] | 7'b0000000 ;
	endcase
	end	 	
	
        
   
	assign cfaddress = act1 | (af[19:2] == flsed[19:2]) | 
		(((m_state == M_ERA_CMR0_S) | (m_state==M_ERA_CMR_S)) & act4 &
		({fsectad[6:0], 8'hff}==af[16:2])) ; 

        assign dfaddress = act1 | (af[15:0] == {flsedb[15:10], flsed[9:0]}) |
		(((m_state == M_ERA_CMR0_S) | (m_state==M_ERA_CMR_S)) & act4 &
		({fsectad[5:0], 10'h3ff}==af[15:0])) ; 

	assign faddress = seldfl ? dfaddress : cfaddress ;

  always@(posedge pclk or negedge resz)	begin
	if(~resz)	faddressl <= 1'b0 	;
	else if((m_state==M_RESET)|(s_state==S_TDIS))	
			faddressl <= 1'b0 	;
	else if((s_state==S_CMR_RDCKH1)|(s_state==S_CMR_RDCKH2))
			faddressl <= faddress   ;
	else		faddressl <= faddressl 	;
  end

  
//************************************************************
//**   drreq
//************************************************************
	assign drreq	= (s_state == S_CMR_DSS )	;

//************************************************************
//**   sqend
//************************************************************
always @( posedge pclk or negedge resz) begin
                if( ~resz )                     sqend <= 1'b0                           ;
                else if(m_state==M_IGEN)        sqend <= 1'b1                           ;
                else if(m_state==M_ICLR)        sqend <= 1'b1                           ;
                          else                  sqend <= 1'b0                           ;
        end


//***************************************** 
//** MOPEN control    
//*****************************************

        always @( posedge pclk or negedge resz) begin
                if( ~resz )                     mopen <= 1'b0                   ;
                else if(m_state==M_END)         mopen <= 1'b0                   ;
                     else if( sqst )
                                                mopen <= 1'b1                   ;
                        else                    mopen <= mopen                  ;
        end



//************************************************************
//**      fflag set
//************************************************************
	assign fflagres = (s_state == S_CMR_MDSET) | (m_state == M_RESET) | (m_state==M_IGEN) ;
	always @( posedge pclk or negedge resz) begin
		if( ~resz )			fflag <= 1'b0				;
		else 		 		fflag <= ~fflagres &
							 (fflag | (s_state == S_CMR_FMDR ) |
								  (m_state == M_IV_FMDR)    ) ;
	end

//***********************************************************************
//**  Retry max
//************************************************************************
	assign rmaxset = (((m_state == M_PRG_RINC)|(m_state == M_ERA_RINC)) & eq ) 	;

	always @( posedge pclk or negedge resz) begin
		if( ~resz )			rmax <= 1'b0				;
		else 		 		rmax <= ~((m_state == M_LAST) | ( m_state == M_ERA_SCNTS )) 
							& ( rmax | rmaxset ) 		;            
	end


//************************************************************************
//**  ECC switch
//************************************************************************
assign iv_ecc = seldfl ? ( ~fpecc2 | ~fpecc3 ) : ( ~fpecc1 | ~fpecc0 ) ; 

assign p_cecce = ~seldfl & ((( m_state == M_BCR_CMR_S ) & act5 ) |
                            (~fpecc0 & ( (( m_state == M_PRG_CMR_S ) & rmax) | (act2 & mrg01) ))	|
	                    (~fpecc1 & ( ( (act2|act3) & (mrg11|mrg12) ) |
			                 ( m_state == M_ERA_CMR0_S) |
                                         ( ( m_state == M_ERA_CMR_S ) & rmax)))) ;

assign p_decce = seldfl & ((( m_state == M_BCR_CMR_S ) & act5 ) |
                           (~fpecc2 & ( (( m_state == M_PRG_CMR_S ) & rmax) | (act2 & dmrg01) ))|
	                   (~fpecc3 & ( ( (act2|act3) & (dmrg11|dmrg12) ) |
			                ( m_state == M_ERA_CMR0_S) |
                                        ( ( m_state == M_ERA_CMR_S ) & rmax)))) ;

	always @(posedge pclk or negedge resz ) begin
		if(~resz)	cecce <= 1'b0		;
		else		cecce <= p_cecce	;
	end

	always @(posedge pclk or negedge resz ) begin
		if(~resz)	decce <= 1'b0		;
		else		decce <= p_decce	;
	end

	
	assign iv = act2 & sqst	;
	 
// countend progim
	assign counttmsw[9:0]	= lowspy ? count20us[9:0] : {1'b0, count10us[8:0] } 	;
// countend tms for mrg
	assign counttmsm[10:0]  = lowspy ? count40us[10:0] : {2'b00, count10us[8:0] } 	  ;
 	assign counttms2m[8:0]  = lowspy ? count10us[8:0]  : { 4'b0000, count1us[4:0] }   ;
	assign counttdis[5:0]	= lowspy ? count2us[5:0]   : { 1'b0, count1us[4:0] }      ;
// countend erase_tdis
	assign counteratdis[9:0] = (act6|act4)&lowspy ? count20us[9:0] : { 1'b0, count10us[8:0]	} ;		

// countend
	always @( m_state or s_state or countwrite or fpwrty or count10us or counterase or
		   counteratdis or fperty or count3us or counttmsw or counttmsm or count1us or
			counttms2m or counttdis) begin
	if(s_state==S_CMR_TMS_S)	countend = {11'h000, counttmsm[10:0] 	}	;
	else if(s_state==S_TDIS_S)	countend = {16'h0000, counttdis[5:0]  	} 	;	// tentative
	else if(m_state==M_DIS_S)	countend = {15'h0000, count3us[6:0]  	} 	;
	else if(m_state==M_ERA_TMS_S)	countend = {13'h0000, count10us[8:0] 	}	;
	else if(m_state==M_ERA_FCLK_S)	countend = counterase[21:0]			;
	else if(m_state==M_ERA_TDIS_S)	countend = {12'h000, counteratdis[9:0]	}	;
	else if(m_state==M_PRG_TMS_S)	countend = {12'h000, counttmsw[9:0]     }	;
	else if(m_state==M_PRG_FCLK1_S)	countend = {11'h000, countwrite[10:0] 	} 	;
	else if(m_state==M_PRG_FCLK2_S) countend = {11'h000, countwrite[10:0] 	} 	;
	else if(m_state==M_PRG_TWPLS_S)  countend = {17'h00000, count1us[4:0]	}	;	// tentative
	else if(m_state==M_PRG_TDIS_S)	countend = {15'h0000, count3us[6:0]	}	;
	else if(m_state==M_PRG_RINC)	countend = {14'h0000, fpwrty[7:0] 	}	;
	else if(m_state==M_ERA_RINC)	countend = {14'h0000, fperty[7:0]	}	;
	else if(m_state==M_IV_TMS1_S)	countend = {11'h000, counttmsm[10:0]    }	;
	else if(m_state==M_IV_TMS2_S)	countend = {13'h000, counttms2m[8:0]     }	;
	else if(m_state==M_IV_TMS3_S)	countend = {13'h000, counttms2m[8:0]     }	;
	else if(m_state==M_IV_TDIS_S)	countend = {16'h0000, counttdis[5:0]	}	;
	else				countend = 22'h000000				;
	end

endmodule




module QLK0RFCBM3SF1V1_FCB_FCPU(
	af19,		af18,		af17,		af16,		af15,		af14,
	af13,		af12,		af11,		af10,		af9,		af8,
	af7,		af6,		af5,		af4,		af3,		af2,
	af1,		af0,		
	countend21,	countend20,	countend19,	countend18,
	countend17,	countend16,	countend15,	countend14,	countend13,	countend12,
	countend11,	countend10,	countend9,	countend8,	countend7,	countend6,
	countend5,	countend4,	countend3,	countend2,	countend1,	countend0,
	ope,		eqact,		xregld,		xregclr,
	eq,		sqclk,		resz,		xregen,		yregen,		
	zregoe,		zregen,		flapsel,	aluout,
	yregdin1,	yregdin0
);

 input	yregdin1,	yregdin0,	xregclr								;
 input	af19,		af18,		af17,		af16,		af15,		af14		;
 input	af13,		af12,		af11,		af10,		af9,		af8		;
 input	af7,		af6,		af5,		af4,		af3,		af2		;
 input	af1,		af0										;
 input  countend21,	countend20,	countend19,	countend18					;
 input	countend17,	countend16,	countend15,	countend14,	countend13,	countend12 	;
 input	countend11,	countend10,	countend9,	countend8,	countend7,	countend6  	;
 input	countend5,	countend4,	countend3,	countend2,	countend1,	countend0  	;
 input	eqact,		xregld,		flapsel				;
 input	sqclk,		resz,		xregen,		yregen,		zregen,		zregoe		;
 input  [1:0] ope	;
 output eq												;
 output	[19:0]	aluout		;

 wire [19:0] xregain = {
	af19,		af18,		af17,		af16,		af15,		af14,
	af13,		af12,		af11,		af10,		af9,		af8,
	af7,		af6,		af5,		af4,		af3,		af2,
	af1,		af0	 } ;

 wire [1:0] yregdin = {
	yregdin1,	yregdin0  } ;

 wire [21:0] countend = {
	countend21,	countend20,	countend19,	countend18,
	countend17,	countend16,	countend15,	countend14,	countend13,	countend12,
	countend11,	countend10,	countend9,	countend8,	countend7,	countend6,
	countend5,	countend4,	countend3,	countend2,	countend1,	countend0  	} ;

 wire [21:0]	paluout											;
 wire [19:0] 	aluout											;
 wire [21:0]	taluout											;
 wire		eq,		cmpout									;

 reg [21:0]	xreg,	xregin			;
 reg [1:0]	yreg				;  
 reg [7:0]	zreg				;  


 always @( flapsel or xregld or xregain or zreg or taluout  ) begin
	case({xregld, flapsel})
		2'b01:	xregin[21:0] = { 2'b00, xregain[19:0] }  ;
		2'b10:	xregin[21:0] = { 14'h000, zreg[7:0]   }  ;
		default:xregin[21:0] = taluout[21:0]		;
	endcase
end

	always @( posedge sqclk	or negedge resz )
		if(~resz)		xreg <= 22'h0_0000 	;
	else if (xregclr)		xreg <= 22'h0_0000 	;
  	else if (xregen)		xreg <= xregin[21:0] 	;
        else				xreg <= xreg		;

	always @( posedge sqclk	or negedge resz )
		if(~resz)		yreg <= 2'h0 		;
  	else if (yregen)		yreg <= yregdin[1:0] 	;
	else				yreg <= yreg		;

	always @( posedge sqclk	or negedge resz )
		if(~resz)		zreg <= 8'h00 		;
  	else if (zregen)		zreg <= xregin[7:0] 	;
	else				zreg <= zreg		;


 QLK0RFCBM3SF1V1_FCB_ALU alu (  .x(xreg[21:0]),  .y(yreg[1:0]),
				.s(paluout[21:0]), .ope(ope[1:0])  ) ;

	assign aluout[19:0]	= paluout[19:0]	;
	assign taluout[21:0] = zregoe ? { 14'h0000, zreg[7:0]} : paluout[21:0] ;

//********************************  alucmp input data select *************************

 QLK0RFCBM3SF1V1_FCB_ALUCMP alucmp ( .in1(taluout[21:0]), .in2(countend[21:0]), .out1(cmpout) );

 assign	eq = eqact & cmpout ;

endmodule


module QLK0RFCBM3SF1V1_FCB_ALUCMP ( in1,  in2,	out1 );

 input	[21:0] in1,	in2     ;	
 output	out1			;

 wire	[21:0]	alucmpo = { ~(in1[21] ^ in2[21]),~(in1[20] ^ in2[20]),~(in1[19] ^ in2[19]),
			    ~(in1[18] ^ in2[18]),~(in1[17] ^ in2[17]), 
			    ~(in1[16] ^ in2[16]), ~(in1[15] ^ in2[15]), ~(in1[14] ^ in2[14]), 
			    ~(in1[13] ^ in2[13]), ~(in1[12] ^ in2[12]), ~(in1[11] ^ in2[11]),
			    ~(in1[10] ^ in2[10]), ~(in1[9]  ^ in2[9] ), ~(in1[8] ^  in2[8] ),  
			    ~(in1[7]  ^ in2[7] ), ~(in1[6]  ^ in2[6] ), ~(in1[5]  ^ in2[5] ),  
			    ~(in1[4] ^  in2[4] ), ~(in1[3]  ^ in2[3] ), ~(in1[2]  ^ in2[2] ), 
			    ~(in1[1]  ^ in2[1] ), ~(in1[0] ^  in2[0] )
			     } ;
  wire		out1	= alucmpo[21] & alucmpo[20] & alucmpo[19] & alucmpo[18] & alucmpo[17] & 
			  alucmpo[16] & alucmpo[15] & alucmpo[14] & alucmpo[13] & alucmpo[12] & 
			  alucmpo[11] & alucmpo[10] & alucmpo[9]  & alucmpo[8]  & alucmpo[7]  & 
			  alucmpo[6]  & alucmpo[5]  & alucmpo[4]  & alucmpo[3]  & alucmpo[2]  &
			  alucmpo[1]  & alucmpo[0]   ;

endmodule

module QLK0RFCBM3SF1V1_FCB_ALU (  x,  y,  s, ope ) ;

input	[21:0]	x ;
input	[1:0]	y ;
input	[1:0]  ope  ;

output	[21:0]  s ;

reg	[21:0]	s ;

always@( ope[1:0] or x or y  ) begin
 case ( ope )
	2'b01 :    s[21:0] =   x[21:0] + {19'h00000, y[1], 1'b0, y[0]} ;
	2'b10 :	   s[21:0] =   x[21:0] - {19'h00000, y[1], 1'b0, y[0]} ;
	default :    s[21:0] =   x[21:0]				;
 endcase
end

endmodule

module QLK0RFCBM3SF1V1_FCB_ESCB    (  	pclk,		presetz,	sqst,		esqst,		exchen_escb,
					esqmd2,		esqmd1,		esqmd0,		exa,
					drreq,		sqend,		wrer,		onbd,
					erer,		iver,		bler,		exch,
					flwhh7,		flwhh6,		flwhh5,		flwhh4,
					flwhh3,		flwhh2,		flwhh1,		flwhh0,
					flwhl7,		flwhl6,		flwhl5,		flwhl4,
					flwhl3,		flwhl2,		flwhl1,		flwhl0,
					flwlh7,		flwlh6,		flwlh5,		flwlh4,
					flwlh3,		flwlh2,		flwlh1,		flwlh0,
					flwll7,		flwll6,		flwll5,		flwll4,
					flwll3,		flwll2,		flwll1,		flwll0,
					flrhh7,		flrhh6,		flrhh5,		flrhh4,
					flrhh3,		flrhh2,		flrhh1,		flrhh0,
					flrhl7,		flrhl6,		flrhl5,		flrhl4,
					flrhl3,		flrhl2,		flrhl1,		flrhl0,
					flrlh7,		flrlh6,		flrlh5,		flrlh4,
					flrlh3,		flrlh2,		flrlh1,		flrlh0,
					flrll7,		flrll6,		flrll5,		flrll4,
					flrll3,		flrll2,		flrll1,		flrll0,
					sec8,		sec7,
					sec6,		sec5,		sec4,		sec3,
					sec2,				
					eseqer,		secen_escb,	fswen_escb,
					esqend,		we_flap_escb,	we_flsed_escb,	we_fssq_escb,
					we_flars_escb,	we_flw_escb,	we_flwe_escb,	din_escb,
					intfl,		stdwait
);


  input		pclk,		presetz;
  input		sqst,		esqst,		esqmd2,		esqmd1,		esqmd0		;
  input		exa,		drreq,		sqend,		onbd		;
  input		wrer,		erer,		iver,		bler		;
  input		exch								;
  input		flwhh7,		flwhh6,		flwhh5,		flwhh4		;
  input		flwhh3,		flwhh2,		flwhh1,		flwhh0		;
  input		flwhl7,		flwhl6,		flwhl5,		flwhl4		;
  input		flwhl3,		flwhl2,		flwhl1,		flwhl0		;
  input		flwlh7,		flwlh6,		flwlh5,		flwlh4		;
  input		flwlh3,		flwlh2,		flwlh1,		flwlh0		;
  input		flwll7,		flwll6,		flwll5,		flwll4		;
  input		flwll3,		flwll2,		flwll1,		flwll0		;
  input		flrhh7,		flrhh6,		flrhh5,		flrhh4		;
  input		flrhh3,		flrhh2,		flrhh1,		flrhh0		;
  input		flrhl7,		flrhl6,		flrhl5,		flrhl4		;
  input		flrhl3,		flrhl2,		flrhl1,		flrhl0		;
  input		flrlh7,		flrlh6,		flrlh5,		flrlh4		;
  input		flrlh3,		flrlh2,		flrlh1,		flrlh0		;
  input		flrll7,		flrll6,		flrll5,		flrll4		;
  input		flrll3,		flrll2,		flrll1,		flrll0		;
 
  input		sec8,		sec7,		sec6,		sec5		;
  input		sec4,		sec3,		sec2				;

  output	we_flap_escb,	we_flsed_escb,	we_fssq_escb,	we_flars_escb	;
  output	we_flw_escb,	we_flwe_escb,	esqend,		eseqer		;
  output	intfl,		stdwait,	exchen_escb,	secen_escb	;
  output	fswen_escb							;

  output [31:0]	din_escb							;


  reg		we_flap_escb,	we_flsed_escb,	we_fssq_escb,	we_flars_escb	;
  reg		we_flw_escb,	we_flwe_escb,	esqend,		eseqer		;
  reg		intfl,		p_intfl,	pp_intfl,	stdwait		;

  reg	[31:0]	din_escb							;
  reg	[7:0]	ex_state							;

  wire 		secmod,		idmod,		clrmod,		clrstd		;
  wire		escberr,	acterr,		exchen_escb			;
  wire		eact5,		eact6,		edge_sqend,	p_sqend		;
  wire		secen_escb,	fswen_escb					;

  wire	[31:0]	flw  = { flwhh7,	flwhh6,		flwhh5,		flwhh4,
			flwhh3,		flwhh2,		flwhh1,		flwhh0,
			flwhl7,		flwhl6,		flwhl5,		flwhl4,
			flwhl3,		flwhl2,		flwhl1,		flwhl0,
			flwlh7,		flwlh6,		flwlh5,		flwlh4,
			flwlh3,		flwlh2,		flwlh1,		flwlh0,
			flwll7,		flwll6,		flwll5,		flwll4,
			flwll3,		flwll2,		flwll1,		flwll0	} ;

  wire [31:0]	flr = { flrhh7,		flrhh6,		flrhh5,		flrhh4,
			flrhh3,		flrhh2,		flrhh1,		flrhh0,
			flrhl7,		flrhl6,		flrhl5,		flrhl4,
			flrhl3,		flrhl2,		flrhl1,		flrhl0,
			flrlh7,		flrlh6,		flrlh5,		flrlh4,
			flrlh3,		flrlh2,		flrlh1,		flrlh0,
			flrll7,		flrll6,		flrll5,		flrll4,
			flrll3,		flrll2,		flrll1,		flrll0 } ;


parameter	EX_INIT	 	= 8'b00000000 ;
parameter	EX_RESET 	= 8'b00000001 ;
parameter	EXW_EXST0 	= 8'b00000010 ;
parameter	EXW_U0AST0	= 8'b00000011 ;
parameter	EXW_SEDSET0	= 8'b00000100 ;
parameter	EXW_EXST1	= 8'b00001110 ; 
parameter	EXW_S1AST0	= 8'b00001111 ; 
parameter	EXW_SEDSET1	= 8'b00010000 ;
parameter	EXW_BC2_M	= 8'b00010010 ;
parameter	EXW_SQCLR2	= 8'b00010011 ;
parameter	EXW_VERI2	= 8'b00010100 ;
parameter	EXW_ER0_M	= 8'b00010110 ;
parameter	EXW_SQCLR3	= 8'b00010111 ;
parameter	EXW_VERI3	= 8'b00011000 ;	
parameter	EXW_S1AST1	= 8'b00011001 ;
parameter	EXW_DSET0	= 8'b00011010 ;
parameter	EXW_WR0_M	= 8'b00011111 ;
parameter	EXW_SQCLR4	= 8'b00100000 ;
parameter	EXW_VERI4	= 8'b00100001 ;
parameter	EXW_S0AST0	= 8'b00100010 ;
parameter	EXW_SEDSET2	= 8'b00100011 ;
parameter	EXW_RD0_M	= 8'b00100101 ;
parameter	EXW_RDFLR0	= 8'b00100110 ;
parameter	EXW_DSSET0	= 8'b00101010 ;
parameter	EXW_DSCLR0	= 8'b00101011 ;
parameter	EXW_SQCLR5	= 8'b00101100 ;
parameter	EXW_S1AST2	= 8'b00101101 ;
parameter	EXW_WR1_M	= 8'b00101111 ;
parameter	EXW_SQCLR6	= 8'b00110000 ;
parameter	EXW_VERI5	= 8'b00110001 ;
parameter	EXW_S1AST3	= 8'b00110010 ;
parameter	EXW_DSET4	= 8'b00110011 ;
parameter	EXW_WR2_M	= 8'b00111000 ;
parameter	EXW_SQCLR7	= 8'b00111001 ;
parameter	EXW_VERI6	= 8'b00111010 ;
parameter	EXW_S1AST4	= 8'b00111011 ;
parameter	EXW_SEDSET5	= 8'b10000000 ;
parameter	EXW_IV0_M	= 8'b00111101 ;
parameter	EXW_SQCLR8	= 8'b00111110 ;
parameter	EXW_VERI7	= 8'b00111111 ;
parameter	EXW_S1AST7	= 8'b01001010 ;
parameter	EXW_SEDSET3	= 8'b01001011 ;
parameter	EXW_RD1_M	= 8'b01001101 ;
parameter	EXW_DSSET1	= 8'b01001110 ;
parameter	EXW_DSCLR1	= 8'b01001111 ;
parameter	EXW_SQCLR11	= 8'b01010000 ;
parameter	EXW_S1AST8	= 8'b01010001 ;
parameter	EXW_DSET8	= 8'b01010010 ;
parameter	EXW_DSET12	= 8'b01010110 ;
parameter	EXW_WR3_M	= 8'b01011000 ;
parameter	EXW_SQCLR12	= 8'b01011001 ;
parameter	EXW_VERI10	= 8'b01011010 ;
parameter	EXW_S1AST9	= 8'b01011011 ;
parameter	EXW_SEDSET9	= 8'b10000001 ;
parameter	EXW_ER1_M	= 8'b01011101 ;
parameter	EXW_SQCLR13	= 8'b01011110 ;
parameter	EXW_VERI11	= 8'b01011111 ;
parameter	EXW_S1AST10	= 8'b01100000 ;
parameter	EXW_SEDSET4	= 8'b01100001 ;
parameter	EXW_RD2_M	= 8'b01100011 ;
parameter	EXW_DSSET2	= 8'b01100100 ;
parameter	EXW_DSCLR2	= 8'b01100101 ;
parameter	EXW_SQCLR14	= 8'b01100110 ;
parameter	EXW_ERRSET	= 8'b01110100 ;
parameter	EX_REGINIT0	= 8'b01110101 ;
parameter	EX_REGINIT1	= 8'b01110110 ;
parameter	EX_ESQEND	= 8'b01110111 ;
parameter	EX_LAST		= 8'b01111000 ;

// user blank check for 1macro ( 256KB )
parameter	EXW_BC4_M	= 8'b01111010 ;
parameter	EXW_SQCLR19	= 8'b01111011 ;
parameter	EXW_VERI12	= 8'b01111100 ;

// TM2V2
parameter	EXW_S0AST11	= 8'b10000101 ;
parameter	EXW_SEDSET6	= 8'b10000110 ;
parameter       EXW_RD3_M	= 8'b10001000 ;
parameter	EXW_RDFLR4	= 8'b10001001 ;
parameter	EXW_DSSET3	= 8'b10001101 ;
parameter	EXW_DSCLR3	= 8'b10001110 ;
parameter	EXW_SQCLR22	= 8'b10001111 ;
parameter	EXW_S1AST11	= 8'b10010000 ;
parameter	EXW_WR4_M	= 8'b10010010 ;
parameter	EXW_SQCLR23	= 8'b10010011 ;
parameter	EXW_VERI14	= 8'b10010100 ;
parameter	EXW_S0AST12	= 8'b10010101 ;
parameter	EXW_SEDSET7	= 8'b10010110 ;
parameter	EXW_RD4_M	= 8'b10011000 ;
parameter	EXW_RDFLR8	= 8'b10011001 ;
parameter	EXW_DSSET4	= 8'b10011101 ;
parameter	EXW_DSCLR4	= 8'b10011110 ;
parameter	EXW_SQCLR24	= 8'b10011111 ;
parameter	EXW_S1AST12	= 8'b10100000 ;
parameter	EXW_WR5_M	= 8'b10100010 ;
parameter	EXW_SQCLR25	= 8'b10100011 ;
parameter	EXW_VERI15	= 8'b10100100 ;
parameter	EXW_S0AST13	= 8'b10100101 ;
parameter	EXW_SEDSET8	= 8'b10100110 ;
parameter	EXW_RD5_M	= 8'b10101000 ;
parameter	EXW_RDFLR12	= 8'b10101001 ;
parameter	EXW_DSSET5	= 8'b10101101 ;
parameter	EXW_DSCLR5	= 8'b10101110 ;
parameter	EXW_SQCLR26	= 8'b10101111 ;
parameter	EXW_S1AST13	= 8'b10110000 ;
parameter	EXW_WR6_M	= 8'b10110010 ;
parameter	EXW_SQCLR27	= 8'b10110011 ;
parameter	EXW_VERI16	= 8'b10110100 ;


  assign   secmod        = ~esqmd2 & ~esqmd1 &  esqmd0 ;  // 001 sec
  assign   idmod         = ~esqmd2 &  esqmd1 & ~esqmd0 ;  // 010 fsw
  assign   eact5	 = ~esqmd2 &  esqmd1 &  esqmd0 ;
  assign   eact6	 =  esqmd2 & ~esqmd1 & ~esqmd0 ;
  assign   clrmod        =  esqmd2 & ~esqmd1 &  esqmd0 ;  // 011 
  assign   acterr        =  ~( secmod | idmod | clrmod | eact5 | eact6 ) ;
  assign   escberr       =  ~exa | acterr | (~sec8 & idmod & ~onbd ) ;

        always @( posedge pclk or negedge presetz ) begin
                if ( ~presetz )     				ex_state <= EX_INIT	;
                else
                case ( ex_state )   

                        EX_INIT     : if (  esqst    )  	ex_state <= EX_RESET    ;
				      else			ex_state <= EX_INIT	;
			EX_RESET    : if (  escberr  )		ex_state <= EXW_ERRSET	; // SEQ ERROR SET
				else  if (  clrmod   )		ex_state <= EXW_EXST0	; // EXTRA WRITE3
				else  	
								ex_state <= EXW_S1AST0	; // EXTRA WRITE1/2

			// BC for User area
			EXW_EXST0   : 				ex_state <= EXW_U0AST0	;
			EXW_U0AST0  : 				ex_state <= EXW_SEDSET0	;
			EXW_SEDSET0 : 				ex_state <= EXW_BC4_M   ; 
			EXW_BC4_M   : 		if ( sqend )	ex_state <= EXW_SQCLR19 ;
				      else			ex_state <= EXW_BC4_M   ;
			EXW_SQCLR19 : 		if ( ~sqend )	ex_state <= EXW_VERI12  ;
				      else			ex_state <= EXW_SQCLR19 ;
			EXW_VERI12  : 		if ( bler  )	ex_state <= EX_REGINIT0 ;
			              else 			ex_state <= EXW_EXST1   ;

			// BC for sector1 of Extra area

			EXW_EXST1   : 				ex_state <= EXW_S1AST0  ;
			EXW_S1AST0  : 				ex_state <= EXW_SEDSET1	;
			EXW_SEDSET1 : 				ex_state <= EXW_BC2_M	;
			EXW_BC2_M   : 		if ( sqend )	ex_state <= EXW_SQCLR2	;
				      else			ex_state <= EXW_BC2_M   ;
			EXW_SQCLR2  : 		if ( ~sqend )	ex_state <= EXW_VERI2   ;
				      else			ex_state <= EXW_SQCLR2  ;
			EXW_VERI2   : 		if ( bler  )	ex_state <= EXW_ER0_M	;
				      else if ( clrmod )	ex_state <= EXW_S1AST3	;
				      else 	       		ex_state <= EXW_S1AST1	;

			// Erase for sector1 of Extra area
			EXW_ER0_M   : 		if ( sqend )	ex_state <= EXW_SQCLR3	;
				      else			ex_state <= EXW_ER0_M   ;
			EXW_SQCLR3  : 		if ( ~sqend )	ex_state <= EXW_VERI3   ;
				      else 			ex_state <= EXW_SQCLR3  ;
			EXW_VERI3   : 		if ( erer  )	ex_state <= EX_REGINIT0	;
				      else if ( clrmod )	ex_state <= EXW_S1AST3  ;
				      else	    		ex_state <= EXW_S1AST1	;

			// Main Programming
			EXW_S1AST1  : 				ex_state <= EXW_DSET0	; 
			EXW_DSET0   : 				ex_state <= EXW_WR0_M	;
			EXW_WR0_M   : 		if ( sqend )	ex_state <= EXW_SQCLR4	;
				      else			ex_state <= EXW_WR0_M   ;
			EXW_SQCLR4  : 		if ( ~sqend )	ex_state <= EXW_VERI4   ;
				      else			ex_state <= EXW_SQCLR4  ;
			EXW_VERI4   : 		if ( wrer  )	ex_state <= EX_REGINIT0	; 
				      else if ( ~eact6 )	ex_state <= EXW_S0AST0  ;
	    			      else			ex_state <= EXW_S0AST11	;

			// EOPBT1 read
			EXW_S0AST0  : 				ex_state <= EXW_SEDSET2	;
			EXW_SEDSET2 : 				ex_state <= EXW_RD0_M	;
			EXW_RD0_M   : 		if (  drreq )	ex_state <= EXW_RDFLR0	;
			              else			ex_state <= EXW_RD0_M   ;
			EXW_RDFLR0  : 				ex_state <= EXW_DSSET0	;
			EXW_DSSET0  : 		if ( ~drreq )	ex_state <= EXW_DSCLR0  ;
				      else			ex_state <= EXW_DSSET0  ;
			EXW_DSCLR0  : 		if (  sqend )	ex_state <= EXW_SQCLR5	;
				      else			ex_state <= EXW_DSCLR0  ;
			EXW_SQCLR5  : 		if ( ~sqend )	ex_state <= EXW_S1AST2  ;
				      else 			ex_state <= EXW_SQCLR5  ;

			// EOPBT1 write
			EXW_S1AST2  : 				ex_state <= EXW_WR1_M	;
			EXW_WR1_M   : 		if ( sqend  )	ex_state <= EXW_SQCLR6	;
				      else			ex_state <= EXW_WR1_M   ;
			EXW_SQCLR6  : 		if ( ~sqend )	ex_state <= EXW_VERI5   ;
				      else			ex_state <= EXW_SQCLR6  ;
			EXW_VERI5   : if ( wrer   )    	ex_state <= EX_REGINIT0	; 
				      else if ( ~eact5  ) 	ex_state <= EXW_S0AST11 ;
	    			      else			ex_state <= EXW_S0AST12	;

			// EOPBT0 read
			EXW_S0AST11  : 				ex_state <= EXW_SEDSET6	;
			EXW_SEDSET6 : 				ex_state <= EXW_RD3_M	;
			EXW_RD3_M   : 		if (  drreq )	ex_state <= EXW_RDFLR4	;
			              else			ex_state <= EXW_RD3_M   ;
			EXW_RDFLR4  : 				ex_state <= EXW_DSSET3	;
			EXW_DSSET3  : 		if ( ~drreq )	ex_state <= EXW_DSCLR3  ;
				      else			ex_state <= EXW_DSSET3  ;
			EXW_DSCLR3  : 		if (  sqend )	ex_state <= EXW_SQCLR22	;
				      else			ex_state <= EXW_DSCLR3  ;
			EXW_SQCLR22  : 		if ( ~sqend )	ex_state <= EXW_S1AST11  ;
				      else 			ex_state <= EXW_SQCLR22  ;

			// EOPBT0 write
			EXW_S1AST11  : 				ex_state <= EXW_WR4_M	;
			EXW_WR4_M   : 		if ( sqend  )	ex_state <= EXW_SQCLR23	;
				      else			ex_state <= EXW_WR4_M   ;
			EXW_SQCLR23  : 		if ( ~sqend )	ex_state <= EXW_VERI14   ;
				      else			ex_state <= EXW_SQCLR23  ;
			EXW_VERI14   : if ( wrer   )    	ex_state <= EX_REGINIT0	; 
				      else if ( ~idmod  ) 	ex_state <= EXW_S0AST12 ;
	    			      else			ex_state <= EXW_S0AST13	;

			// OCDID read
			EXW_S0AST12  : 				ex_state <= EXW_SEDSET7	;
			EXW_SEDSET7 : 				ex_state <= EXW_RD4_M	;
			EXW_RD4_M   : 		if (  drreq )	ex_state <= EXW_RDFLR8	;
			              else			ex_state <= EXW_RD4_M   ;
			EXW_RDFLR8  : 				ex_state <= EXW_DSSET4	;
			EXW_DSSET4  : 		if ( ~drreq )	ex_state <= EXW_DSCLR4  ;
				      else			ex_state <= EXW_DSSET4  ;
			EXW_DSCLR4  : 		if (  sqend )	ex_state <= EXW_SQCLR24	;
				      else			ex_state <= EXW_DSCLR4  ;
			EXW_SQCLR24  : 		if ( ~sqend )	ex_state <= EXW_S1AST12  ;
				      else 			ex_state <= EXW_SQCLR24  ;

			// EOPBT0 write
			EXW_S1AST12  : 				ex_state <= EXW_WR5_M	;
			EXW_WR5_M   : 		if ( sqend  )	ex_state <= EXW_SQCLR25	;
				      else			ex_state <= EXW_WR5_M   ;
			EXW_SQCLR25  : 		if ( ~sqend )	ex_state <= EXW_VERI15   ;
				      else			ex_state <= EXW_SQCLR25  ;
			EXW_VERI15   : if ( wrer   )    	ex_state <= EX_REGINIT0	; 
				      else if ( ~secmod  ) 	ex_state <= EXW_S0AST13 ;
	    			      else			ex_state <= EXW_S1AST3	;

			// Security read
			EXW_S0AST13  : 				ex_state <= EXW_SEDSET8	;
			EXW_SEDSET8 : 				ex_state <= EXW_RD5_M	;
			EXW_RD5_M   : 		if (  drreq )	ex_state <= EXW_RDFLR12	;
			              else			ex_state <= EXW_RD5_M   ;
			EXW_RDFLR12  : 				ex_state <= EXW_DSSET5	;
			EXW_DSSET5  : 		if ( ~drreq )	ex_state <= EXW_DSCLR5  ;
				      else			ex_state <= EXW_DSSET5  ;
			EXW_DSCLR5  : 		if (  sqend )	ex_state <= EXW_SQCLR26	;
				      else			ex_state <= EXW_DSCLR5  ;
			EXW_SQCLR26  : 		if ( ~sqend )	ex_state <= EXW_S1AST13  ;
				      else 			ex_state <= EXW_SQCLR26  ;

			// Security write
			EXW_S1AST13  : 				ex_state <= EXW_WR6_M	;
			EXW_WR6_M   : 		if ( sqend  )	ex_state <= EXW_SQCLR27	;
				      else			ex_state <= EXW_WR6_M   ;
			EXW_SQCLR27  : 		if ( ~sqend )	ex_state <= EXW_VERI16   ;
				      else			ex_state <= EXW_SQCLR27  ;
			EXW_VERI16   : if ( wrer   )    	ex_state <= EX_REGINIT0	; 
				      else			ex_state <= EXW_S1AST3	;


			// Valid flag write
			EXW_S1AST3  : 				ex_state <= EXW_DSET4	;
			EXW_DSET4   : 				ex_state <= EXW_WR2_M	;
			EXW_WR2_M   : 		if ( sqend  )	ex_state <= EXW_SQCLR7	;
				      else			ex_state <= EXW_WR2_M   ;
			EXW_SQCLR7  : 		if ( ~sqend )	ex_state <= EXW_VERI6   ;
				      else			ex_state <= EXW_SQCLR7  ;
			EXW_VERI6   : if ( wrer   )    	ex_state <= EX_REGINIT0	;
				      else	    		ex_state <= EXW_S1AST4	;

			// IV 
			EXW_S1AST4  : 				ex_state <= EXW_SEDSET5 ;	
			EXW_SEDSET5 :				ex_state <= EXW_IV0_M	;
			EXW_IV0_M   : if (  sqend )    	ex_state <= EXW_SQCLR8	;
				      else			ex_state <= EXW_IV0_M   ;
			EXW_SQCLR8  : 		if ( ~sqend )	ex_state <= EXW_VERI7   ;
				      else			ex_state <= EXW_SQCLR8  ;
			EXW_VERI7   : 		if ( iver   )	ex_state <= EX_REGINIT0	;
				      else			ex_state <= EXW_S1AST7	;

			// Valid flag read
			EXW_S1AST7  : 				ex_state <= EXW_SEDSET3	;
			EXW_SEDSET3 : 				ex_state <= EXW_RD1_M	;
			EXW_RD1_M   : 		if (  drreq )	ex_state <= EXW_DSSET1	;
				      else			ex_state <= EXW_RD1_M   ;
			EXW_DSSET1  : 		if ( ~drreq )	ex_state <= EXW_DSCLR1  ;
				      else			ex_state <= EXW_DSSET1  ;
			EXW_DSCLR1  : 		if (  sqend )	ex_state <= EXW_SQCLR11	;
				      else			ex_state <= EXW_DSCLR1  ;
			EXW_SQCLR11 : 		if ( ~sqend )	ex_state <= EXW_S1AST8  ;
				      else			ex_state <= EXW_SQCLR11 ;

			// Append write of Valid flag
			EXW_S1AST8  : 				ex_state <= EXW_DSET8	;
			EXW_DSET8   : 				ex_state <= EXW_DSET12	;
			EXW_DSET12  : 				ex_state <= EXW_WR3_M	;
			EXW_WR3_M   : 		if ( sqend  )	ex_state <= EXW_SQCLR12	;
				      else			ex_state <= EXW_WR3_M   ;
			EXW_SQCLR12 : 		if ( ~sqend )	ex_state <= EXW_VERI10  ;
				      else			ex_state <= EXW_SQCLR12 ;
			EXW_VERI10   : if ( wrer   )    	ex_state <= EX_REGINIT0	;
				      else	    		ex_state <= EXW_S1AST9	;

			// Erase for sector1 of extra area
			EXW_S1AST9  : 				ex_state <= EXW_SEDSET9	;
			EXW_SEDSET9 :				ex_state <= EXW_ER1_M	;
			EXW_ER1_M   : 		if ( sqend )	ex_state <= EXW_SQCLR13	;
				      else			ex_state <= EXW_ER1_M   ;
			EXW_SQCLR13  : 		if ( ~sqend )	ex_state <= EXW_VERI11	;
				      else			ex_state <= EXW_SQCLR13 ;
			EXW_VERI11   : 		if ( erer  )	ex_state <= EX_REGINIT0	;
				      else	    		ex_state <= EXW_S1AST10	;

			// Security flag read
			EXW_S1AST10  : 				ex_state <= EXW_SEDSET4	;
			EXW_SEDSET4 : 				ex_state <= EXW_RD2_M	;
			EXW_RD2_M   : 		if (  drreq )	ex_state <= EXW_DSSET2	;
				      else			ex_state <= EXW_RD2_M   ;
			EXW_DSSET2  : 		if ( ~drreq )	ex_state <= EXW_DSCLR2  ;
				      else			ex_state <= EXW_DSSET2  ;
			EXW_DSCLR2  : 		if (  sqend )	ex_state <= EXW_SQCLR14	;
				      else			ex_state <= EXW_DSCLR2  ;
			EXW_SQCLR14 : if ( ~sqend )		ex_state <= EX_REGINIT0	; // FSSQ set (  reset )
				      else			ex_state <= EXW_SQCLR14 ;

			// Error
			EXW_ERRSET  : 				ex_state <= EX_ESQEND	;

			// Initialize
			EX_REGINIT0 :				ex_state <= EX_REGINIT1	; // All register initialize except FLARS
			EX_REGINIT1 :				ex_state <= EX_ESQEND   ; // FLARS initialize

			// End
			EX_ESQEND  : if ( ~esqst )		ex_state <= EX_LAST	;
				     else			ex_state <= EX_ESQEND   ; 
			default    :				ex_state <= EX_INIT	;
		endcase
	end



   // Sequencer Error //
   
   always @ ( posedge pclk or negedge presetz ) begin
     if ( ~presetz )			eseqer <= 1'h0	 ;
     else if ( ex_state == EXW_ERRSET )	eseqer <= 1'h1   ;
     else if ( ex_state == EX_RESET   ) eseqer <= 1'h0   ;
     else				eseqer <= eseqer ;
   end


   // Sequencer finish //
   
   always @ ( posedge pclk or negedge presetz ) begin
	if ( ~presetz )				esqend <= 1'h0	;
	else case ( { ex_state } )  
			EX_ESQEND :		esqend <= 1'h1  ;
			default   : 		esqend <= 1'h0  ;
	     endcase 
   end


  // *****  FLAP register write signal ***** //
  always @( ex_state ) begin
      case( ex_state )    
	   EXW_U0AST0  : we_flap_escb = 1'b1 ;  
 	   EXW_S1AST0  : we_flap_escb = 1'b1 ;  
	   EXW_S1AST1  : we_flap_escb = 1'b1 ;  
	   EXW_S0AST0  : we_flap_escb = 1'b1 ;  
	   EXW_S1AST2  : we_flap_escb = 1'b1 ;  
	   EXW_S1AST3  : we_flap_escb = 1'b1 ;  
	   EXW_S1AST4  : we_flap_escb = 1'b1 ;  
	   EXW_S1AST7  : we_flap_escb = 1'b1 ;  
	   EXW_S1AST8  : we_flap_escb = 1'b1 ;  
	   EXW_S1AST9  : we_flap_escb = 1'b1 ;  
	   EXW_S1AST10 : we_flap_escb = 1'b1 ;  
	   EX_REGINIT0 : we_flap_escb = 1'b1 ; 

	   EXW_S0AST11 : we_flap_escb = 1'b1 ;
	   EXW_S1AST11 : we_flap_escb = 1'b1 ;
	   EXW_S0AST12 : we_flap_escb = 1'b1 ;
	   EXW_S1AST12 : we_flap_escb = 1'b1 ;
	   EXW_S0AST13 : we_flap_escb = 1'b1 ;
           EXW_S1AST13 : we_flap_escb = 1'b1 ;
   	   
           default    : we_flap_escb = 1'b0 ;
      endcase
   end



  // *****  FSSQ register write signal ***** //

  always @( ex_state ) begin
      case( ex_state )   

	   EXW_BC2_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR2 	:     we_fssq_escb = 1'b1 ;  

	   EXW_ER0_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR3 	:     we_fssq_escb = 1'b1 ;  

	   EXW_WR0_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR4 	:     we_fssq_escb = 1'b1 ;  

	   EXW_RD0_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_DSSET0 	:     we_fssq_escb = 1'b1 ;  
	   EXW_DSCLR0 	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR5 	:     we_fssq_escb = 1'b1 ;  

	   EXW_WR1_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR6 	:     we_fssq_escb = 1'b1 ;  

	   EXW_WR2_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR7 	:     we_fssq_escb = 1'b1 ;  

	   EXW_IV0_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR8 	:     we_fssq_escb = 1'b1 ;  

	   EXW_RD1_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_DSSET1 	:     we_fssq_escb = 1'b1 ;  
	   EXW_DSCLR1 	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR11	:     we_fssq_escb = 1'b1 ;  

	   EXW_WR3_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR12 	:     we_fssq_escb = 1'b1 ;  

	   EXW_ER1_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR13 	:     we_fssq_escb = 1'b1 ;  
	  
	   EXW_RD2_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_DSSET2 	:     we_fssq_escb = 1'b1 ;  
	   EXW_DSCLR2 	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR14	:     we_fssq_escb = 1'b1 ;  

	   EX_REGINIT0	:     we_fssq_escb = 1'b1 ;  

	   // for 1macro
	   EXW_BC4_M  	:     we_fssq_escb = 1'b1 ;  
	   EXW_SQCLR19 	:     we_fssq_escb = 1'b1 ;  

	   
	   EXW_RD3_M	:     we_fssq_escb = 1'b1 ;
	   EXW_DSSET3   :     we_fssq_escb = 1'b1 ;
	   EXW_DSCLR3   :     we_fssq_escb = 1'b1 ;
           EXW_SQCLR22  :     we_fssq_escb = 1'b1 ;
           EXW_WR4_M    :     we_fssq_escb = 1'b1 ;
	   EXW_SQCLR23  :     we_fssq_escb = 1'b1 ;
	   EXW_RD4_M	:     we_fssq_escb = 1'b1 ;
	   EXW_DSSET4   :     we_fssq_escb = 1'b1 ;
	   EXW_DSCLR4	:     we_fssq_escb = 1'b1 ;
	   EXW_SQCLR24	:     we_fssq_escb = 1'b1 ;
	   EXW_WR5_M	:     we_fssq_escb = 1'b1 ;
	   EXW_SQCLR25  :     we_fssq_escb = 1'b1 ;
	   EXW_RD5_M	:     we_fssq_escb = 1'b1 ;
	   EXW_DSSET5   :     we_fssq_escb = 1'b1 ;
	   EXW_DSCLR5   :     we_fssq_escb = 1'b1 ;
	   EXW_SQCLR26  :     we_fssq_escb = 1'b1 ;
	   EXW_WR6_M	:     we_fssq_escb = 1'b1 ;
	   EXW_SQCLR27  :     we_fssq_escb = 1'b1 ;
	   
	   default	:     we_fssq_escb = 1'b0 ;
	endcase
   end


// *****  FLSED register write Signal ***** //
  always @( ex_state ) begin
      case( ex_state )   
	   EXW_SEDSET0 :     we_flsed_escb = 1'b1 ;  // 0000_0700H write
	   EXW_SEDSET1 :     we_flsed_escb = 1'b1 ;  // 0000_07f0H write
	   EXW_SEDSET2 :     we_flsed_escb = 1'b1 ;  // 0000_0001H write
	   EXW_SEDSET3 :     we_flsed_escb = 1'b1 ;  // 0000_0000H write
	   EXW_SEDSET4 :     we_flsed_escb = 1'b1 ;  // 0000_0010H write
	   EXW_SEDSET5 :     we_flsed_escb = 1'b1 ;
	   EXW_SEDSET6 :     we_flsed_escb = 1'b1 ;
	   EXW_SEDSET7 :     we_flsed_escb = 1'b1 ;
	   EXW_SEDSET8 :     we_flsed_escb = 1'b1 ;
	   EXW_SEDSET9 :     we_flsed_escb = 1'b1 ;
	   EX_REGINIT0 :     we_flsed_escb = 1'b1 ;  // initialize
           default     :     we_flsed_escb = 1'b0 ;
      endcase
  end


// *****  FLARS register write Signal ***** //
  always @( ex_state ) begin
      case( ex_state )   
	   EXW_EXST0  :	    we_flars_escb = 1'b1 ;  // 0000_0000Hwrite
	   EXW_EXST1  :     we_flars_escb = 1'b1 ;  // 0000_0001Hwrite
	   EX_REGINIT1:	    we_flars_escb = 1'b1 ;  // 0000_0001Hwrite
           default    :     we_flars_escb = 1'b0 ;  // initialize
      endcase
  end


// *****  FLW register write Signal ***** //
  always @( ex_state ) begin
      case( ex_state )   
	   EXW_DSET0  :	    we_flw_escb = 1'b1 ;  //  Security datawrite
	   EXW_RDFLR0 :     we_flw_escb = 1'b1 ;  //  Readdatawrite
	   EXW_DSET4  :     we_flw_escb = 1'b1 ;  //  Valid Flag write
	   EXW_DSET8  :     we_flw_escb = 1'b1 ;  //  Valid Flag write2
	   EX_REGINIT0:     we_flw_escb = 1'b1 ;  // initialize
	   EXW_RDFLR4 :	    we_flw_escb = 1'b1 ;
	   EXW_RDFLR8 :     we_flw_escb = 1'b1 ;
	   EXW_RDFLR12:     we_flw_escb = 1'b1 ;
           default    :     we_flw_escb = 1'b0 ;
      endcase
  end


  // *****  FLWE register write Signal ***** //
  always @( ex_state ) begin
      case( ex_state )   
	   EXW_DSET12 :	    we_flwe_escb = 1'b1 ;  //  Append Write data
	   EX_REGINIT0:     we_flwe_escb = 1'b1 ;  // initialize
           default    :     we_flwe_escb = 1'b0 ;
      endcase
  end



  always @( ex_state or secmod or flw or sec8 or sec7 or sec6 or sec5 or sec4 or sec3 or sec2 or 
            exch or flr or eact6 or eact5 or idmod ) begin
      case ( ex_state ) 

	      EXW_EXST0   : din_escb = 32'h0000_0000 				; // FLARS  to 0000_0000H write
	      EXW_U0AST0  : din_escb = 32'h0000_0000 				; // FLAP   to 0000_0000H write
	      EXW_SEDSET0 : din_escb = 32'h0000_0ffc 				; // FLSED (4KB)
	      
	      EXW_EXST1   : din_escb = 32'h0000_0001 				; // FLARS  to 0000_0001H write
	      EXW_S1AST0  : din_escb = 32'h0000_0400 				; // FLAP   to 0000_0400H write  
	      EXW_SEDSET1 : din_escb = 32'h0000_07fc 				; // FLSED  to 0000_07f0H write
	      EXW_BC2_M   : din_escb = 32'h0000_0083 				; // FSSQ   to 0000_0083H write
	      EXW_SQCLR2  : din_escb = 32'h0000_0003 				; // FSSQ   to 0000_0003H write

	      EXW_ER0_M   : din_escb = 32'h0000_0084 				; // FSSQ   to 0000_0084H write
	      EXW_SQCLR3  : din_escb = 32'h0000_0004 				; // FSSQ   to 0000_0004H write
	   
	      EXW_S1AST1  : begin
				if ( eact6  ) 	    din_escb = 32'h0000_0410    ;
			   else if ( eact5  )	    din_escb = 32'h0000_040c    ; 
			   else if ( secmod )	    din_escb = 32'h0000_0404 	; // FLAP   to 0000_0404H write  
				else		    din_escb = 32'h0000_0408	; // FLAP   to 0000_0408H write  
			    end
              EXW_DSET0   : begin						  // FLW   to  Security /IDdatawrite
				if ( secmod )	    din_escb = { flw[31:15], flw[14] & sec8, flw[13] & sec7, flw[12] & sec6,
								flw[11] & sec5, flw[10] & sec4, flw[9] & sec3, 
								{ sec3 ? flw[8] : sec2 }, flw[7:2], flw[1:0] } ;
				else	            din_escb = flw	     ;
			    end
              EXW_WR0_M   : din_escb = 32'h0000_0081				; // FSSQ   to 0000_0081H write
	      EXW_SQCLR4  : din_escb = 32'h0000_0001				; // FSSQ   to 0000_0001H write


	      EXW_S0AST0  : din_escb = 32'h0000_0010				; // FLAP   to 0000_0010H write
	      EXW_SEDSET2 : din_escb = 32'h0000_0010 				; // FLSED  to 0000_0010H write
	      EXW_RD0_M   : din_escb = 32'h0000_0085 				; // FSSQ   to 0000_0085H write
	      EXW_RDFLR0  : din_escb = flr[31:0]				; // FLW   to  Readdatawrite
	      EXW_DSSET0  : din_escb = 32'h0000_0095 				; // FSSQ   to 0000_0095H write
	      EXW_DSCLR0  : din_escb = 32'h0000_0085 				; // FSSQ   to 0000_0085H write
	      EXW_SQCLR5  : din_escb = 32'h0000_0005 				; // FSSQ   to 0000_0005H write


	      EXW_S1AST2  : din_escb = 32'h0000_0410 				; // FLAP   to 0000_041cH write  
	      EXW_WR1_M   : din_escb = 32'h0000_0081				; // FSSQ   to 0000_0081H write
	      EXW_SQCLR6  : din_escb = 32'h0000_0001				; // FSSQ   to 0000_0001H write


	      EXW_S1AST3  : din_escb = 32'h0000_0400 				; // FLAP   to 0000_1000H write  
              EXW_DSET4   : begin
				if ( ~exch )	din_escb = 32'h5555_5555	; // FLW   to 5555_5555H write
				else 		din_escb = 32'hffff_ffff	; // FLW   to FFFF_FFFFH write
			    end
              EXW_WR2_M   : din_escb = 32'h0000_0081				; // FSSQ   to 0000_0081H write
	      EXW_SQCLR7  : din_escb = 32'h0000_0001				; // FSSQ   to 0000_0001H write


	      EXW_S1AST4  : din_escb = 32'h0000_0400				; // FLAP   to 0000_0400H write
	      EXW_SEDSET5 : din_escb = 32'h0000_0410				; // FLSED  to 0000_0410H write  
	      EXW_IV0_M   : din_escb = 32'h0000_0082				; // FSSQ   to 0000_0082H write
	      EXW_SQCLR8  : din_escb = 32'h0000_0002				; // FSSQ   to 0000_0002H write

	      
	      EXW_S1AST7  : din_escb = 32'h0000_0400				; // FLAP   to 0000_0400H write  
	      EXW_SEDSET3 : din_escb = 32'h0000_0400				; // FLSED  to 0000_0400H write
	      EXW_RD1_M   : din_escb = 32'h0000_0085 				; // FSSQ   to 0000_0085H write
	      EXW_DSSET1  : din_escb = 32'h0000_0095 				; // FSSQ   to 0000_0095H write
	      EXW_DSCLR1  : din_escb = 32'h0000_0085 				; // FSSQ   to 0000_0085H write
	      EXW_SQCLR11 : din_escb = 32'h0000_0005 				; // FSSQ   to 0000_0005H write


	      EXW_S1AST8  : din_escb = 32'h0000_0400 				; // FLAP   to 0000_0400H write  
              EXW_DSET8   : begin
				if ( ~exch  )	din_escb = 32'h0000_0000	; // FLW   to 0000_0000H write
				else		din_escb = 32'hffff_ffff	; // FLW   to FFFF_FFFFH write
			    end
              EXW_DSET12  : din_escb = 32'h0000_0000				; // FLWE   to 0000_0000H write
	      EXW_WR3_M   : begin
				if ( ~exch  ) 	din_escb = 32'h0000_00A1	; // FSSQ   to 0000_00A1H write
				else 		din_escb = 32'h0000_0081	; // FSSQ   to 0000_0081H write
			    end
	      EXW_SQCLR12 : din_escb = 32'h0000_0001				; // FSSQ   to 0000_0001H write


	      EXW_S1AST9  : din_escb = 32'h0000_0400				; // FLAP   to 0000_0400H write
	      EXW_SEDSET9 : din_escb = 32'h0000_07ff				; // FLSED  to 0000_07ffH write  
	      EXW_ER1_M   : din_escb = 32'h0000_0084 				; // FSSQ   to 0000_0084H write
	      EXW_SQCLR13 : din_escb = 32'h0000_0004 				; // FSSQ   to 0000_0004H write
 

	      EXW_S1AST10 : din_escb = {28'h0000_000, idmod, secmod, 2'b00}	; // FLAP   to 0000_0004H write
	      EXW_SEDSET4 : din_escb = {28'h0000_000, idmod, secmod, 2'b00}	; // FLSED  to 0000_0004H write
	      EXW_RD2_M   : din_escb = 32'h0000_0085 				; // FSSQ   to 0000_0085H write
	      EXW_DSSET2  : din_escb = 32'h0000_0095 				; // FSSQ   to 0000_0095H write
	      EXW_DSCLR2  : din_escb = 32'h0000_0085 				; // FSSQ   to 0000_0085H write
	      EXW_SQCLR14 : din_escb = 32'h0000_0005 				; // FSSQ   to 0000_0005H write
	      
	      EX_REGINIT1 : din_escb = 32'h0000_0001				; // FLARS  to 0000_0001H write


	      // for 1macro
	      EXW_BC4_M   : din_escb = 32'h0000_0083 				; // FSSQ   to 0000_0083H write
	      EXW_SQCLR19 : din_escb = 32'h0000_0003 				; // FSSQ   to 0000_0003H write

	      EXW_S0AST11 : din_escb = 32'h0000_000c				;
	      EXW_SEDSET6 : din_escb = 32'h0000_000c				;
	      EXW_RD3_M   : din_escb = 32'h0000_0085				;
	      EXW_RDFLR4  : din_escb = flr[31:0]				; // FLW   to  Readdatawrite
	      EXW_DSSET3  : din_escb = 32'h0000_0095 				; // FSSQ   to 0000_0095H write
	      EXW_DSCLR3  : din_escb = 32'h0000_0085 				; // FSSQ   to 0000_0085H write
	      EXW_SQCLR22 : din_escb = 32'h0000_0005 				; // FSSQ   to 0000_0005H write
	
	      EXW_S1AST11 : din_escb = 32'h0000_040c				;
	      EXW_WR4_M   : din_escb = 32'h0000_0081   			        ;
	      EXW_SQCLR23 : din_escb = 32'h0000_0001 				;

	      EXW_S0AST12 : din_escb = 32'h0000_0008				;
	      EXW_SEDSET7 : din_escb = 32'h0000_0008				;
	      EXW_RD4_M   : din_escb = 32'h0000_0085				;
	      EXW_RDFLR8  : din_escb = flr[31:0]				; // FLW   to  Readdatawrite
	      EXW_DSSET4  : din_escb = 32'h0000_0095 				; // FSSQ   to 0000_0095H write
	      EXW_DSCLR4  : din_escb = 32'h0000_0085 				; // FSSQ   to 0000_0085H write
	      EXW_SQCLR24 : din_escb = 32'h0000_0005 				; // FSSQ   to 0000_0005H write
	
	      EXW_S1AST12 : din_escb = 32'h0000_0408				;
	      EXW_WR5_M   : din_escb = 32'h0000_0081   			        ;
	      EXW_SQCLR25 : din_escb = 32'h0000_0001 				;

	      EXW_S0AST13 : din_escb = 32'h0000_0004				;
	      EXW_SEDSET8 : din_escb = 32'h0000_0004				;
	      EXW_RD5_M   : din_escb = 32'h0000_0085				;
	      EXW_RDFLR12 : din_escb = flr[31:0]				; // FLW   to  Readdatawrite
	      EXW_DSSET5  : din_escb = 32'h0000_0095 				; // FSSQ   to 0000_0095H write
	      EXW_DSCLR5  : din_escb = 32'h0000_0085 				; // FSSQ   to 0000_0085H write
	      EXW_SQCLR26 : din_escb = 32'h0000_0005 				; // FSSQ   to 0000_0005H write
	
	      EXW_S1AST13 : din_escb = 32'h0000_0404				;
	      EXW_WR6_M   : din_escb = 32'h0000_0081   			        ;
	      EXW_SQCLR27 : din_escb = 32'h0000_0001 				;

	      default     : din_escb = 32'h0000_0000 				;
	endcase
end

// exchen
	assign exchen_escb = ( ex_state == EXW_DSSET1 )	;
// secen
	assign secen_escb  = ( ex_state == EXW_DSSET2 ) & secmod ;
// fswen
	assign fswen_escb  =  ( ex_state == EXW_DSSET2 ) & idmod ;

//  intfl
	assign p_sqend	= esqst ? esqend : sqend ;
	
 always@(posedge pclk or negedge presetz) begin
	if(~presetz)	p_intfl	<= 1'b0 	;
	else 		p_intfl <= p_sqend 	;
 end

 always@(posedge pclk or negedge presetz) begin
	if(~presetz)	pp_intfl	<= 1'b0 	;
	else 		pp_intfl 	<= p_intfl 	;
 end

  	assign edge_sqend = p_intfl & ~pp_intfl ;

 always@(posedge pclk or negedge presetz) begin
	if(~presetz)	intfl	<= 1'b0 	;
	else 		intfl 	<= edge_sqend 	;
 end

   assign clrstd = esqst ? esqend : sqend ;
  always@( posedge pclk or negedge presetz ) begin
     if ( ~presetz )                     stdwait <= 1'b0 ;
     else if ( clrstd )                  stdwait <= 1'b0 ;
     else                                stdwait <= (sqst|esqst) ;
  end

endmodule










//	module name	QLK0RFCBM3SF1V1_FCB_EXPREG
//	verision
//	designer	Y.Terauchi



module QLK0RFCBM3SF1V1_FCB_EXPREG (
	pclk,		resz,		exchen,		secen,		fswen,
	rdata31,	rdata30,	rdata29,	rdata28,	rdata27,
	rdata26,	rdata25,	rdata24,	rdata23,	rdata22,
	rdata21,	rdata20,	rdata19,	rdata18,	rdata17,
	rdata16,	rdata15,	rdata14,	rdata13,	rdata12,
	rdata11,	rdata10,	rdata9,		rdata8,		rdata7,
	rdata6,		rdata5,		rdata4,		rdata3,		rdata2,
	rdata1,		rdata0,		exchen_escb,	secen_escb,	fswen_escb,
	exch,		sec,		fsws,		fswe								
);

input	fswen,		exchen_escb,	secen_escb,	fswen_escb		;
input	pclk,		resz,		exchen,		secen			;
input	rdata31,	rdata30,	rdata29,	rdata28,	rdata27	;
input	rdata26,	rdata25,	rdata24,	rdata23,	rdata22 ;
input	rdata21,	rdata20,	rdata19,	rdata18,	rdata17	;
input	rdata16,	rdata15,	rdata14,	rdata13,	rdata12	;
input	rdata11,	rdata10,	rdata9,		rdata8,		rdata7	;
input	rdata6,		rdata5,		rdata4,		rdata3,		rdata2	;
input	rdata1,		rdata0							;
output [8:2]	sec								;
output [9:0]	fswe								;
output [9:0]	fsws								;
output	exch									;

wire[31:0] rdata = {
	rdata31,	rdata30,	rdata29,	rdata28,	rdata27,
	rdata26,	rdata25,	rdata24,	rdata23,	rdata22,
	rdata21,	rdata20,	rdata19,	rdata18,	rdata17,
	rdata16,	rdata15,	rdata14,	rdata13,	rdata12,
	rdata11,	rdata10,	rdata9,		rdata8,		rdata7,
	rdata6,		rdata5,		rdata4,		rdata3,		rdata2,
	rdata1,		rdata0	} ;

wire	valid55 	;
reg [8:2]	sec 	;
reg [9:0]	fswe	;
reg [9:0]	fsws	;
reg	exch		;



// Valid flag
assign valid55 = ( rdata[31:0] == 32'h5555_5555 ) ;

always @( posedge pclk or negedge resz )
	if(~resz)			exch <= 1'b0 	;
	else if(exchen|exchen_escb)	exch <= valid55	;
	else				exch <= exch	;

// security flag
always @( posedge pclk or negedge resz )
	if(~resz)			sec[8:2] <= 7'h00 			;
	else if(secen|secen_escb)	sec[8:2] <= rdata[14:8]			;
	else				sec[8:2] <= sec[8:2]			;

// fswe
always @( posedge pclk or negedge resz )
	if(~resz)			fswe[9:0] <= 10'h000 		;
	else if(fswen|fswen_escb)	fswe[9:0] <= rdata[25:16]	;
	else				fswe[9:0] <= fswe[9:0]		;

// fsws
always @( posedge pclk or negedge resz )
	if(~resz)			fsws[9:0] <= 10'h000 	;
	else if(fswen|fswen_escb)	fsws[9:0] <= rdata[9:0]	;
	else				fsws[9:0] <= fsws[9:0]	;


	

endmodule
module QLK0RFCBM3SF1V1_FCB_SQCTL (  	sel_flpmc_p,	penable,
					sel_pfcmd,	pclk,		presetz,	pwrite,
					s_sseqbrk,	din,		we_flpmc,	psel2,
					psel1,		fprerr				
);

  input		sel_flpmc_p,	sel_pfcmd						;
  input		pclk,		presetz,	pwrite,		s_sseqbrk		;
  input		penable,	psel2,		psel1					;

  input	[7:0]	din ;

  output	we_flpmc,	fprerr						;

  wire		wr_sr_sd,	vd_a5_eq,	vd_sd_eq,	vd_bsd_eq,	flpmc_eq	;
  wire		plot_eq,	d0,		d1						;
  wire		d10,		d11,		sel_plot,	prerrset,	sdclken		;
  wire		wr_nobrk,	wr_brk,		we_flpmc_br,	we_flpmc_nbr			;
  wire		prerrres									;

  reg		fprerr ;
  reg 		selreg ;
  reg 	[7:0] 	sdbuf ;
  reg 	[1:0] 	stpcnt, stpcnt2 ;

  assign sel_plot = sel_flpmc_p ;
  assign wr_sr_sd = sel_plot & ~stpcnt[1] & stpcnt[0] & pwrite ;
  assign sdclken  = ~s_sseqbrk  &  wr_sr_sd ;

  assign wr_nobrk = pwrite & penable &  ~s_sseqbrk &  (psel2 | psel1 )  ;
  assign wr_brk   = pwrite & penable &   s_sseqbrk &  (psel2 | psel1 )  ;

   // data buffer
   
   always @( posedge pclk or negedge presetz ) begin
	if ( ~presetz )		sdbuf[7:0] <= 8'h00      ;
	else if ( sdclken )	sdbuf[7:0] <= din[7:0]   ;
	else			sdbuf[7:0] <= sdbuf[7:0] ;
   end

   // data compare
  assign  vd_a5_eq  = ( din ==  8'ha5  ) ;
  assign  vd_sd_eq  = ( din ==  sdbuf  ) ;
  assign  vd_bsd_eq = ( din == ~sdbuf  ) ;

   
   always @( posedge pclk or negedge presetz ) begin
	if ( ~presetz )		selreg <= 1'h0        ;
	else if ( sdclken )	selreg <= sel_flpmc_p ;
	else			selreg <= selreg      ;
   end

   // register compare
  assign  flpmc_eq  =  selreg & sel_flpmc_p  ;
  assign  plot_eq   =  flpmc_eq  ;

   // step counter

  assign  d0 = ( ~stpcnt[1] & ~stpcnt[0] & sel_pfcmd & vd_a5_eq ) | 
	       (  stpcnt[1] & ~stpcnt[0] & vd_bsd_eq & plot_eq )   ;

  assign  d1 = ( ~stpcnt[1] &  stpcnt[0] & sel_plot ) |
	       (  stpcnt[1] & ~stpcnt[0] & vd_bsd_eq & plot_eq )   ;

   
   always @( posedge pclk or negedge presetz ) begin
	if ( ~presetz )		stpcnt[1:0] <= 2'h0        ;
	else if ( wr_nobrk )	stpcnt[1:0] <= { d1 ,d0 }  ;
	else			stpcnt[1:0] <= stpcnt[1:0] ;
   end

	// protection errer create
   assign prerrset = ( ~stpcnt[1] & ~stpcnt[0] &  sel_plot  ) |
		 //  ( ~stpcnt[1] &  stpcnt[0] & ~sel_plot  ) |  // change to next line for coverage
		     (               stpcnt[0] & ~sel_plot  ) |  
		     (  stpcnt[1]              & ~plot_eq   ) |  // stpcnt[1:0]==2or3 & ~plot_eq
		     (  stpcnt[1] & ~stpcnt[0] & ~vd_bsd_eq ) |
		     (  stpcnt[1] &  stpcnt[0] & ~vd_sd_eq  ) 	;

   assign prerrres =  ~stpcnt[1] & ~stpcnt[0] & sel_pfcmd & vd_a5_eq ;


   
   always @( posedge pclk or negedge presetz ) begin
	if ( ~presetz )		fprerr <= 1'h0       				;
	else if ( wr_nobrk )	fprerr <= ( fprerr | prerrset ) & ~prerrres 	;
	else			fprerr <= fprerr 				;
   end


  // step counter for brake operation
  assign  d10 = ( ~stpcnt2[1] & ~stpcnt2[0] & sel_pfcmd ) | 
	        (  stpcnt2[1] & ~stpcnt2[0] & sel_plot  )   ;

  assign  d11 = ( ~stpcnt2[1] &  stpcnt2[0] & sel_plot ) |
	        (  stpcnt2[1] & ~stpcnt2[0] & sel_plot )   ;

   
   always @( posedge pclk or negedge presetz ) begin
	if ( ~presetz )		stpcnt2[1:0] <= 2'h0         ;
	else if ( ~s_sseqbrk )	stpcnt2[1:0] <= 2'h0	     ;
	else if (  wr_brk  )	stpcnt2[1:0] <= { d11 ,d10 } ;
	else			stpcnt2[1:0] <= stpcnt2[1:0] ;
   end

  // output assign
  assign  we_flpmc_nbr = flpmc_eq & stpcnt[1] & stpcnt[0] & vd_sd_eq & pwrite & penable ;
  
  assign  we_flpmc_br = sel_flpmc_p & stpcnt2[1] & stpcnt2[0] & pwrite & penable ;
  
  assign  we_flpmc = s_sseqbrk ? we_flpmc_br : we_flpmc_nbr ;
  
endmodule



module QLK0RFCBM3SF1V1_FCB_REGRW (
	pclk,		resz,		flmemtes,
	din7,		din6,		din4,		din3,		din2,		
	din1,		din0,		dhin7,		dhin2,		dhin1,		dhin0,
	we_fsse,	we_fsset,	we_flrst,	we_flpmc,	fwedis,
	eeemd,		eseqer,		cwee,		
	esqmd2,		esqmd1,		esqmd0,		esqst,		tmspmd,		tmbtsel,	lowspy_mscb,		
	fset4,		fset3,		fset2,		fset1,		fset0,		flrst,
	prdata,		pwrite,		penable,	psel2,		psel1,
	fprerr,		exa,		flaplh7,	flaplh6,	flaplh5,	flaplh4,	flaplh3,	
	flaplh2,	flaplh1,	flaplh0,	flapll7,	flapll6,	flapll5,	flapll4,
	flapll3,	flapll2,	flapll1,	flapll0,	flsedlh7,	flsedlh6,	flsedlh5,	
	flsedlh4,	flsedlh3,	flsedlh2,	flsedlh1,	flsedlh0,	flsedll7,	flsedll6,
	flsedll5,	flsedll4,	flsedll3,	flsedll2,	flsedll1,	flsedll0,
	flaph3,		flaph2,		flaph1,		flaph0,		flsedh3,	flsedh2,
	flsedh1,	flsedh0,	esqend,
	sqend,		fwepr,		drreq,		af19,		af18,		af17,
	af16,		af15,		af14,		af13,		af12,		af11,		af10,		
	af9,		af8,		af7,		af6,		af5,		af4,		af3,		
	af2,		af1,		af0,
	flwlh7,		flwlh6,		flwlh5,		flwlh4,		flwlh3,		flwlh2,		flwlh1,
	flwlh0,		flwhh7,		flwhh6,		flwhh5,		flwhh4,		flwhh3,		flwhh2,
	flwhh1,		flwhh0,		flwll7,		flwll6,		flwll5,		flwll4,		flwll3,
	flwll2,		flwll1,		flwll0,		flwhl7,		flwhl6,		flwhl5,		flwhl4,
	flwhl3,		flwhl2,		flwhl1,		flwhl0,		flwe5,		flwe4,		flwe3,
	flwe2,		flwe1,		flwe0,		flrhh7,		flrhh6,		flrhh5,		flrhh4,
	flrhh3,		flrhh2,		flrhh1,		flrhh0,		flrhl7,		flrhl6,		flrhl5,
	flrhl4,		flrhl3,		flrhl2,		flrhl1,		flrhl0,		flrlh7,		flrlh6,
	flrlh5,		flrlh4,		flrlh3,		flrlh2,		flrlh1,		flrlh0,		flrll7,
	flrll6,		flrll5,		flrll4,		flrll3,		flrll2,		flrll1,		flrll0,
	flre5,		flre4,		flre3,		flre2,		flre1,		flre0,
	modidis,	meoc,		meor,		beu2,		beu1,		beu0,
	rdmrg0,		rdt,		ionchk1,	stchk,		exer,		ser,		cer,
	mswr,		dser,		dcer,		
	mutest,		saceenz,	cpt,		extvpp2,	extvpp1,	wwr,
	mrg12,		mrg11,		mrg10,		mrg01,		mrg00,		read,		dis,
	cpbt,		wdt4,		wdt3,		wdt2,		wdt1,		rdmrgc,		rdmrg1,
	dwwr,		dmrg12,		dmrg11,		dmrg10,		dmrg01,		dmrg00,		dread,
	ddis,		sqst,		fsstp,		dclr,		dseten,		mdch,		sqmd2,
	sqmd1,		sqmd0,		ireft,
	mopen,		seqer,		bler,		iver,		wrer,		erer,		sel_pfs,
	sel_flars,	sel_flaplh,	sel_flsedlh,	sel_flrst,	sel_fsasth,	sel_flfadlh,	
	sel_flwlh,	sel_flwhh,	sel_flrlh,	sel_flrhh,	sel_fltmsh,	sel_flmch,
	sel_dflmch,	sel_flpmc,	sel_flapll,	sel_flaph,	sel_flsedll,	sel_flsedh,	sel_fssql,
	sel_fsse,	sel_fsset,	sel_fsastl,	sel_flfadll,	sel_flfadh,	sel_flwll,	sel_flwhl,
	sel_flwe,	sel_flrll,	sel_flrhl,	sel_flre,	sel_fltmsl,	sel_flmcll,	sel_flmclh,	
//	sel_dflmcl,	sel_fsctl,	sel_flsecl,	sel_flsech,	sel_flfswel,	sel_flfsweh,
	sel_dflmcl,	sel_fsctl,	sel_flsech,	sel_flfswel,	sel_flfsweh,
	sel_flfswsl,	sel_flfswsh,
	dfclk2,		dfclk1,		drdclkz,	dprogi,		dwed,		cwed,		flspm,
	sec8,		sec7,		sec6,		sec5,		sec4,		sec3,		sec2,
	fswe9,		fswe8,		fswe7,		fswe6,		fswe5,		fswe4,
	fswe3,		fswe2,		fswe1,		fswe0,
	fsws9,		fsws8,		fsws7,		fsws6,		fsws5,		fsws4,		fsws3,
	fsws2,		fsws1,		fsws0,
	seldfl,		vceq,		tcwee,		tlowspy,	lowspy );

 input	seldfl,		vceq,		tcwee,		tlowspy					;
 input	sec8,		sec7,		sec6,		sec5,		sec4,		sec3,		sec2		;
 input	fswe9,		fswe8,		fswe7,		fswe6,		fswe5,		fswe4				;
 input	fswe3,		fswe2,		fswe1,		fswe0								;
 input	fsws9,		fsws8,		fsws7,		fsws6,		fsws5,		fsws4,		fsws3		;
 input	fsws2,		fsws1,		fsws0										;	
 input	dfclk2,		dfclk1,		drdclkz,	dprogi,		eseqer						;
 input	sel_pfs,	sel_flaplh,	sel_flsedlh,	sel_flars,	sel_flrst,	sel_fsasth ;
 input	sel_flfadlh,	sel_flwlh,	sel_flwhh,	sel_flrlh,	sel_flrhh,	sel_fltmsh			;
 input	sel_flmclh,	sel_dflmch,	sel_flpmc,	sel_flapll,	sel_flaph,	sel_flsedll,	sel_flsedh	;
 input	sel_fssql,	sel_fsse,	sel_fsset,	sel_fsastl,	sel_flfadll,	sel_flfadh,	sel_flwll	;
 input	sel_flwhl,	sel_flwe,	sel_flrll,	sel_flrhl,	sel_flre,	sel_fltmsl			;
 input	sel_flmcll,	sel_flmch,	sel_dflmcl,	sel_fsctl,	sel_flsech					;
 input	sel_flfswel,	sel_flfsweh,	sel_flfswsl,	sel_flfswsh							;
 input	modidis,	meoc,		meor,		beu2,		beu1,		beu0	;
 input	rdmrg0,		rdt,		ionchk1,	stchk,		exer,		ser,		cer	;
 input	mswr,		dser,		dcer									;
 input	mutest,		saceenz,	cpt,		extvpp2,	extvpp1,	wwr			;
 input	mrg12,		mrg11,		mrg10,		mrg01,		mrg00,		read,		dis	;
 input	cpbt,		wdt4,		wdt3,		wdt2,		wdt1,		rdmrgc,		rdmrg1	;
 input	dwwr,		dmrg12,		dmrg11,		dmrg10,		dmrg01,		dmrg00,		dread	;
 input	ddis,		sqst,		fsstp,		dclr,		dseten,		mdch,		sqmd2	;
 input	sqmd1,		sqmd0,		ireft									;
 input	mopen,		seqer,		bler,		iver,		wrer,		erer			;
 input	fprerr,		exa,		flaplh7,	flaplh6,	flaplh5,	flaplh4,	flaplh3	;
 input	flaplh2,	flaplh1,	flaplh0,	flsedlh7,	flsedlh6,	flsedlh5,	flsedlh4;
 input	flsedlh3,	flsedlh2,	flsedlh1,	flsedlh0,	esqend					;
 input	flapll7,	flapll6,	flapll5,	flapll4,	flapll3,	flapll2,	flapll1 ;
 input	flapll0,	flsedll1,	flsedll0								;
 input	flsedll7,	flsedll6,	flsedll5,	flsedll4,	flsedll3,	flsedll2 		;
 input	flaph3,		flaph2,		flaph1,		flaph0					;
 input	flsedh3,	flsedh2,	flsedh1,	flsedh0					;
 input	sqend,		fwepr,		drreq,		af19,		af18,		af17	;
 input	af16,		af15,		af14,		af13,		af12,		af11,		af10	;
 input	af9,		af8,		af7,		af6,		af5,		af4,		af3	;
 input	af1,		af0											;
 input	af2,		flwhh7,		flwhh6,		flwhh5,		flwhh4,		flwhh3,		flwhh2	;
 input	flwhh1,		flwhh0,		flwhl7,		flwhl6,		flwhl5,		flwhl4,		flwhl3	;
 input	flwhl2,		flwhl1,		flwhl0,		flwlh7,		flwlh6,		flwlh5,		flwlh4	;
 input	flwlh3,		flwlh2,		flwlh1,		flwlh0,		flwll7,		flwll6,		flwll5	;
 input	flwll4,		flwll3,		flwll2,		flwll1,		flwll0,		flwe5,		flwe4	;
 input	flwe3,		flwe2,		flwe1,		flwe0,		flrhh7,		flrhh6,		flrhh5  ;
 input	flrhh4,		flrhh3,		flrhh2,		flrhh1,		flrhh0,		flrhl7,		flrhl6	;
 input	flrhl5,		flrhl4,		flrhl3,		flrhl2,		flrhl1,		flrhl0,		flrlh7	;
 input	flrlh6,		flrlh5,		flrlh4,		flrlh3,		flrlh2,		flrlh1,		flrlh0	;
 input	flrll7,		flrll6,		flrll5,		flrll4,		flrll3,		flrll2,		flrll1	;
 input	flrll0,		flre5,		flre4,		flre3,		flre2,		flre1,		flre0	;	
 input	pclk,		resz,		flmemtes								;
 input	din7,		din6,		din4,		din3,		din2,		din1,		din0	;
 input	dhin7,		dhin2,		dhin1,		dhin0							;
 input	we_fsse,	we_fsset,	we_flrst,	we_flpmc						;
 input	pwrite,		penable,	psel2,		psel1							;

 output [15:0] 		prdata											;
 output	esqst,		esqmd2,	 	esqmd1,  	esqmd0, 	tmspmd,		tmbtsel,	flrst	;
 output	lowspy_mscb,	fset4,		fset3,		fset2,		fset1,		fset0	;
 output	cwed,		dwed,		eeemd,		flspm,		cwee,		fwedis,		lowspy  ;

 reg [3:0]	fsse  	;
 reg [4:0]	fsset 	;
 reg [1:0]	fsseth	;
 reg		flrst 	;
 reg [2:0]	flpmc6, flpmc4, flpmc3, cweem	;
 reg 		flpmcl,	flpmc5, lowspy		;
 
 wire[6:0] din  = { 	din7,		din6,				din4,		
			din3,		din2,		din1,		din0  	} ; 

// wire[7:0] flaplh = {   flaplh7,	flaplh6,	flaplh5,	flaplh4,	flaplh3,	
//			flaplh2,	flaplh1,	flaplh0						} ;		

// wire[7:0] flsedlh = {   flsedlh7,	flsedlh6,	flsedlh5,	flsedlh4,	flsedlh3,	
//			flsedlh2,	flsedlh1,	flsedlh0					} ;		

 wire [15:0]	prdata		;
 wire [7:0]	dhout,	dout	;
 wire	esqst,		esqmd2,		esqmd1,		esqmd0,		tmspmd, 	tmbtsel ;
 wire	fset4, 		fset3, 		fset2, 		fset1,		fset0,		cwee	;
 wire	rstmask,	we_flrst_o,	cwee_mscb,	eeemd,		lowspy_mscb		;
 wire	fwedis,		flspm,		cwed							;
 wire	dwed,		re									;

//***********************************************
//**  FSSE register
//***********************************************
 always@( posedge pclk or negedge resz) begin
	if(~resz)	fsse[3:0]	<= 4'h0				;
	else if(flrst)	fsse[3:0]	<= 4'h0				;
	else if(we_fsse)	
			fsse[3:0]	<= {dhin7, dhin2, dhin1, dhin0 }	;
	else 		fsse[3:0]	<=	fsse[3:0]		;
end

assign esqst 	= fsse[3] ;
assign esqmd2 	= fsse[2] ;
assign esqmd1 	= fsse[1] ;
assign esqmd0 	= fsse[0] ;

//********************************************************
// FSSET register
//   tmspmd, tmbtsel must be protected by boor protection
//*******************************************************

always@( posedge pclk or negedge resz)  begin
	if(~resz)		fsset[4:0]	<= 5'h00		;
	else if(we_fsset)	fsset[4:0]	<= din[4:0] 	 	;
	else			fsset[4:0]	<= fsset[4:0]		;
end

always@( posedge pclk or negedge resz)  begin
	if(~resz)			fsseth[1:0]	<= 2'b00	;
	else if(we_fsset & sec3)	fsseth[1:0]	<= din[6:5]  	;
	else				fsseth[1:0]	<= fsseth[1:0]	;
end

	assign tmspmd  = fsseth[1] ;
	assign tmbtsel = fsseth[0] ;
	assign fset4   = fsset[4] ;
	assign fset3   = fsset[3] ;
	assign fset2   = fsset[2] ;
	assign fset1   = fsset[1] ;
	assign fset0   = fsset[0] ;

//*********************************************************
//  FLRST register
//*********************************************************

 assign rstmask = esqst ? esqend : ~(sqst & ~sqend) ;
 assign we_flrst_o = we_flrst & rstmask	;
 
 always @(posedge pclk or negedge resz ) begin
	if(~resz)		flrst	<= 1'b0		;
	else if(we_flrst_o)	flrst	<= dhin0 	;
	else			flrst	<= flrst	;
end


//*********************************************************
//** FLPMC register
//*********************************************************
   
	always @(posedge pclk or negedge resz) begin
		if (~resz) 		flpmcl	<= 1'b0		;
		else if(we_flpmc)	flpmcl	<= din[1] 	 	;
		else			flpmcl	<= flpmcl		;
	end



	always @(posedge pclk or negedge resz) begin
		if (~resz) 		flpmc5	<= 1'b0		;
		else if(we_flpmc)	flpmc5	<= din[5]	;
		else			flpmc5	<= flpmc5	;
	end

	always @(posedge pclk or negedge resz) begin
		if (~resz) 		flpmc6[2:0]	<= 3'h0		;
		else if(we_flpmc)	flpmc6[2:0]	<= {din[6], din[6], din[6]}	;
		else			flpmc6[2:0]	<= flpmc6[2:0]	;
	end

	always @(posedge pclk or negedge resz) begin
		if (~resz) 		flpmc4[2:0]	<= 3'h0		;
		else if(we_flpmc)	flpmc4[2:0]	<= {din[4], din[4], din[4]}	;
		else			flpmc4[2:0]	<= flpmc4[2:0]	;
	end

	always @(posedge pclk or negedge resz) begin
		if (~resz) 		flpmc3[2:0]	<= 3'b111		;
		else if(we_flpmc)	flpmc3[2:0]	<= {din[3], din[3], din[3]}	;
		else			flpmc3[2:0]	<= flpmc3[2:0]	;
	end



	
	assign cwee_mscb     	=  MAJO (flpmc6[2], flpmc6[1], flpmc6[0])  ;
	assign lowspy_mscb   	= flpmc5  ;
	assign eeemd    	=  MAJO (flpmc4[2], flpmc4[1], flpmc4[0] )  ;
	assign fwedis   	=  MAJO (flpmc3[2], flpmc3[1], flpmc3[0] )    ;
	assign flspm    	= flpmcl    ;
	
	always @(posedge pclk or negedge resz) begin
		if (~resz) 		lowspy	<= 1'b0				;
		else			lowspy	<= (lowspy_mscb | tlowspy )	;
	end

	always @(posedge pclk or negedge resz) begin
		if (~resz) 		cweem[2:0]	<= 3'b000								;
		else			cweem[2:0]	<= {(cwee_mscb | tcwee ), (cwee_mscb | tcwee ), (cwee_mscb | tcwee ) }  ;
	end

	assign cwee = MAJO ( cweem[2], cweem[1], cweem[0] ) ;
	assign cwed = ~flmemtes & (~fwepr|fwedis) 	;
        assign dwed = ~flmemtes & ~eeemd		;

// majority control

  function MAJO ;
        input A, B, C ;
        begin
                case({A, B, C})
                        3'b001  : MAJO = 1'b0 ;
                        3'b010  : MAJO = 1'b0 ;
                        3'b011  : MAJO = 1'b1 ;
                        3'b100  : MAJO = 1'b0 ;
                        3'b101  : MAJO = 1'b1 ;
                        3'b110  : MAJO = 1'b1 ;
                        3'b111  : MAJO = 1'b1 ;
                        default : MAJO = 1'b0 ;
                endcase
        end
  endfunction

//*********************************************************
//**   DOUT
//*********************************************************
	wire[14:12] dflfadpp = { af14, af13, af12 } ;

	reg[14:12] dflfadp ;
	always@(dflfadpp) begin
		case(dflfadpp)
		  3'b001	:	dflfadp = 3'b010 ;
		  3'b010 	:	dflfadp = 3'b011 ;
		  3'b011 	:	dflfadp = 3'b100 ;
		default 	:	dflfadp = 3'b001 ;
	endcase
	end
      
	wire[15:12] dflfad = seldfl ? { 1'b0, dflfadp[14:12] } : {af15, af14, af13, af12 } ;

	assign dhout[7:0] =  ({8{sel_pfs    }} & { 7'b0000000, 	fprerr           			    })
			    |({8{sel_flars  }} & { 7'b0000000,	exa            			    })
		|({8{sel_flaplh }} & { flaplh7, flaplh6, flaplh5, flaplh4, flaplh3, flaplh2, flaplh1, flaplh0})
		|({8{sel_flsedlh}} & { flsedlh7, flsedlh6, flsedlh5, flsedlh4, flsedlh3, flsedlh2, flsedlh1, flsedlh0})
			    |({8{sel_flrst  }} & { 7'b0000000, flrst            			    })
      			    |({8{sel_fsasth }} & { esqend, sqend, 3'b000, fwepr, drreq, 1'b0   })
			    |({8{sel_flfadlh}} & { dflfad[15:12], af11, af10, af9, af8      })
			    |({8{sel_flwlh  }} & { flwlh7, flwlh6, flwlh5, flwlh4, flwlh3, flwlh2, flwlh1, flwlh0})	  
			    |({8{sel_flwhh  }} & { flwhh7, flwhh6, flwhh5, flwhh4, flwhh3, flwhh2, flwhh1, flwhh0})	  
			    |({8{sel_flrlh  }} & { flrlh7, flrlh6, flrlh5, flrlh4, flrlh3, flrlh2, flrlh1, flrlh0})	  
			    |({8{sel_flrhh  }} & { flrhh7, flrhh6, flrhh5, flrhh4, flrhh3, flrhh2, flrhh1, flrhh0})	  
			    |({8{sel_fltmsh }} & { modidis, 2'b00, meoc, meor, beu2, beu1, beu0 		})
			    |({8{sel_flmclh }} & { rdmrg0, rdt, ionchk1, stchk, exer, ser, cer, mswr 		})
			    |({8{sel_dflmch }} & { 5'b00000, dser, dcer, 1'b0			    		}) 
			    |({8{sel_flsech }} & { 1'b0, sec8, sec7, sec6, sec5, sec4, sec3, sec2		})
			    |({8{sel_flfsweh}} & { 6'b000000, fswe9, fswe8				        })
			    |({8{sel_flfswsh}} & { 6'b000000, fsws9, fsws8					})
			    |({8{sel_flre   }} & { vceq, 1'b0, flre5, flre4, flre3, flre2, flre1, flre0		})
			    |({8{sel_fssql  }} & { sqst, fsstp, dclr, dseten, mdch, sqmd2, sqmd1, sqmd0       })
			    |({8{sel_fsctl  }} & { tcwee, tlowspy, 2'b00, dfclk2, dfclk1, drdclkz, dprogi     }) 
			    |({8{sel_fsse   }} & { esqst, 4'b0000, esqmd2, esqmd1, esqmd0		     }) ;

			    

	assign dout[7:0]  =  ({8{sel_flpmc  }}  & { cwee_mscb, lowspy_mscb, 1'b0, eeemd, fwedis, 1'b0, flspm, 1'b0 })
			    |({8{sel_flapll }} & { flapll7, flapll6, flapll5, flapll4, flapll3, flapll2, flapll1, flapll0})
			    |({8{sel_flaph  }} & { 4'b0000, flaph3, flaph2, flaph1, flaph0             })
			    |({8{sel_flsedll}} & { flsedll7, flsedll6, flsedll5, flsedll4, flsedll3, flsedll2, 
						flsedll1, flsedll0 })
			    |({8{sel_flsedh }} & { 4'b0000, flsedh3, flsedh2, flsedh1, flsedh0 	     })
			    |({8{sel_fsset  }} & { tmspmd, tmbtsel, 1'b0, fset4, fset3, fset2, fset1, fset0 })
			    |({8{sel_fsastl }} & { ~sec2, mopen, eseqer, seqer, bler, iver, wrer, erer         })
			    |({8{sel_flfadll}} & { af7, af6, af5, af4, af3, af2, af1, af0		     })
			    |({8{sel_flfadh }} & { 4'b0000, af19, af18, af17, af16			     })
			    |({8{sel_flwll  }} & { flwll7, flwll6, flwll5, flwll4, flwll3, flwll2, flwll1, flwll0 })
			    |({8{sel_flwhl  }} & { flwhl7, flwhl6, flwhl5, flwhl4, flwhl3, flwhl2, flwhl1, flwhl0 })
			    |({8{sel_flwe   }} & { 2'b00, flwe5, flwe4, flwe3, flwe2, flwe1, flwe0	     })
			    |({8{sel_flrll  }} & { flrll7, flrll6, flrll5, flrll4, flrll3, flrll2, flrll1, flrll0})
			    |({8{sel_flrhl  }} & { flrhl7, flrhl6, flrhl5, flrhl4, flrhl3, flrhl2, flrhl1, flrhl0})
			    |({8{sel_fltmsl }} & { 1'b0, mutest, 1'b0, ~saceenz, ireft, cpt, extvpp2, extvpp1   })
			    |({8{sel_flmcll }} & { wwr, mrg12, mrg11, mrg10, mrg01, mrg00, read, dis  	     })
			    |({8{sel_flmch  }} & { 1'b0, cpbt, wdt4, wdt3, wdt2, wdt1, rdmrgc, rdmrg1	     })
			    |({8{sel_dflmcl }} & { dwwr, dmrg12, dmrg11, dmrg10, dmrg01, dmrg00, dread, ddis  })
		   //         |({8{sel_flsecl }} & { 8'b00000000						     })
			    |({8{sel_flfswsl}} & { fsws7, fsws6, fsws5, fsws4, fsws3, fsws2, fsws1, fsws0    })
			    |({8{sel_flfswel}} & { fswe7, fswe6, fswe5, fswe4, fswe3, fswe2, fswe1, fswe0    });

	assign re = ~pwrite & penable & ( psel2 | psel1 );
	assign prdata[7:0] = re ? dout[7:0] : 8'h00 ;
	assign prdata[15:8] = re ? dhout[7:0] : 8'h00 ;			    
endmodule
//	module name	QLK0RFCBM3SF1V1_FCB_TIMETABLE
//	verision
//	designer	Y.Terauchi



module QLK0RFCBM3SF1V1_FCB_TIMETABLE (
	fset4,		fset3,		fset2,		fset1,		fset0,
	fpser2,		fpser1,		fpser0,		fpwwr2,		fpwwr1,		fpwwr0,
	count10us,	count20us,	count40us,			
	counterase,	countwrite,	count3us,	count2us,	count1us
);

input 		fset4, 		fset3, 		fset2, 		fset1, 		fset0 			;
input		fpser2,		fpser1,		fpser0,		fpwwr2,		fpwwr1,		fpwwr0	;
output [5:0]	count2us								;
output [4:0]    count1us								;
output [6:0]	count3us								;
output [8:0]	count10us								;
output [9:0]	count20us								;
output [10:0]	count40us						 		;
output [10:0]	countwrite								;
output [21:0]	counterase								;

reg[5:0]	count2us								;
reg[4:0]	count1us								;
reg[6:0]	count3us								;
reg[7:0]	count5us								;
reg[8:0]	count10us,	count8us,	count12us				;
reg[9:0]	count20us								;
reg[10:0]	count40us,	count60us,	countwrite ;
reg[15:0]	count1ms ;
reg[17:0]	count5ms ;
reg[18:0]	count10ms ;
reg[19:0]	count20ms ;
reg[19:0]	count30ms ;
reg[20:0]	count40ms ;
reg[20:0]	count50ms ;
reg[21:0]	count100ms,	counterase		  ;		

// Timing control
wire [4:0] fset = { fset4, fset3, fset2, fset1, fset0 } ;

// 1us count
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count1us = 5'h1d ; // 2009.09.30
		5'b11110: count1us = 5'h1c ; // 2009.09.30 
		5'b11101: count1us = 5'h1a ; // 2009.09.30
		5'b11100: count1us = 5'h19 ; // 2009.09.30
		5'b11011: count1us = 5'h18 ; // 2009.09.30 
		5'b11010: count1us = 5'h17 ; // 2009.09.30 
		5'b11001: count1us = 5'h16 ; // 2009.09.30 
		5'b11000: count1us = 5'h15 ; // 2009.09.30 
		5'b10111: count1us = 5'h14 ; // 2009.09.30 
		5'b10110: count1us = 5'h13 ; // 2009.09.30 
		5'b10101: count1us = 5'h12 ; // 2009.09.30  
		5'b10100: count1us = 5'h11 ; // 2009.09.30 
		5'b10011: count1us = 5'h10 ; // 2009.09.30 
		5'b10010: count1us = 5'h0f ; // 2009.09.30 
		5'b10001: count1us = 5'h0e ; // 2009.09.30 
		5'b10000: count1us = 5'h0d ; // 2009.09.30 
		5'b01111: count1us = 5'h0c ; // 2009.09.30 
		5'b01110: count1us = 5'h0b ; // 2009.09.30 
		5'b01101: count1us = 5'h0a ; // 2009.09.30 
		5'b01100: count1us = 5'h09 ; // 2009.09.30 
		5'b01011: count1us = 5'h08 ; // 2009.09.30 
		5'b01010: count1us = 5'h07 ; // 2009.09.30 
		5'b01001: count1us = 5'h06 ; // 2009.09.30 
		5'b01000: count1us = 5'h05 ; // 2009.09.30 
		5'b00111: count1us = 5'h04 ; // 2009.09.30 
		5'b00110: count1us = 5'h03 ; // 2009.09.30 
		5'b00101: count1us = 5'h02 ; // 2009.09.30 
		5'b00100: count1us = 5'h01 ; // 2009.09.30
		5'b00011: count1us = 5'h01 ; // 2009.09.30 
		5'b00010: count1us = 5'h01 ; // 2009.09.30 
		5'b00001: count1us = 5'h01 ; // 2009.09.30 
		default : count1us = 5'h01 ; // 2009.09.30 
	endcase
	end

// 2us count
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count2us = 6'h3d ; // 2009.10.01
		5'b11110: count2us = 6'h3b ; // 2009.09.30 
		5'b11101: count2us = 6'h37 ; // 2009.09.30
		5'b11100: count2us = 6'h35 ; // 2009.10.02
		5'b11011: count2us = 6'h34 ; // 2009.10.02 
		5'b11010: count2us = 6'h32 ; // 2009.10.02 
		5'b11001: count2us = 6'h2f ; // 2009.10.02 
		5'b11000: count2us = 6'h2e ; // 2009.10.02 
		5'b10111: count2us = 6'h2b ; // 2009.10.02 
		5'b10110: count2us = 6'h29 ; // 2009.10.02 
		5'b10101: count2us = 6'h27 ; // 2009.10.02  
		5'b10100: count2us = 6'h25 ; // 2009.10.02 
		5'b10011: count2us = 6'h23 ; // 2009.10.02 
		5'b10010: count2us = 6'h21 ; // 2009.10.02 
		5'b10001: count2us = 6'h1f ; // 2009.10.02 
		5'b10000: count2us = 6'h1d ; // 2009.10.02 
		5'b01111: count2us = 6'h1b ; // 2009.10.02 
		5'b01110: count2us = 6'h19 ; // 2009.10.02 
		5'b01101: count2us = 6'h17 ; // 2009.10.02 
		5'b01100: count2us = 6'h15 ; // 2009.10.02 
		5'b01011: count2us = 6'h13 ; // 2009.10.02 
		5'b01010: count2us = 6'h11 ; // 2009.10.02 
		5'b01001: count2us = 6'h0f ; // 2009.10.02 
		5'b01000: count2us = 6'h0d ; // 2009.10.02 
		5'b00111: count2us = 6'h0b ; // 2009.10.02 
		5'b00110: count2us = 6'h09 ; // 2009.10.02 
		5'b00101: count2us = 6'h07 ; // 2009.10.02 
		5'b00100: count2us = 6'h05 ; // 2009.10.02
		5'b00011: count2us = 6'h03 ; // 2009.10.02 
		5'b00010: count2us = 6'h01 ; // 2009.10.02 
		5'b00001: count2us = 6'h01 ; // 2009.10.02 
		default : count2us = 6'h01 ; // 2009.10.02 
	endcase
	end


// 3us count
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count3us = 7'h65 ;
		5'b11110: count3us = 7'h61 ;
		5'b11101: count3us = 7'h5b ;
		5'b11100: count3us = 7'h59 ;	
		5'b11011: count3us = 7'h56 ;
		5'b11010: count3us = 7'h54 ;
		5'b11001: count3us = 7'h4f ;
		5'b11000: count3us = 7'h4d ;
		5'b10111: count3us = 7'h4a ;
		5'b10110: count3us = 7'h46 ;
		5'b10101: count3us = 7'h43 ;
		5'b10100: count3us = 7'h40 ;
		5'b10011: count3us = 7'h3e ;
		5'b10010: count3us = 7'h3a ;
		5'b10001: count3us = 7'h37 ;
		5'b10000: count3us = 7'h34 ;
		5'b01111: count3us = 7'h32 ;
		5'b01110: count3us = 7'h2e ;
		5'b01101: count3us = 7'h2b ;
		5'b01100: count3us = 7'h28 ;
		5'b01011: count3us = 7'h25 ;
		5'b01010: count3us = 7'h22 ;
		5'b01001: count3us = 7'h1f ;
		5'b01000: count3us = 7'h1c ;
		5'b00111: count3us = 7'h19 ;
		5'b00110: count3us = 7'h16 ;
		5'b00101: count3us = 7'h13 ;
		5'b00100: count3us = 7'h10 ;
		5'b00011: count3us = 7'h0d ;
		5'b00010: count3us = 7'h0a ;
		5'b00001: count3us = 7'h07 ;
		default:  count3us = 7'h04 ;
		endcase
		end
// 5us count
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count5us = 8'ha3	;
		5'b11110: count5us = 8'h9e	;
		5'b11101: count5us = 8'h94	;
		5'b11100: count5us = 8'h90	;
		5'b11011: count5us = 8'h8b	;
		5'b11010: count5us = 8'h87	;
		5'b11001: count5us = 8'h80	;
		5'b11000: count5us = 8'h7d	;
		5'b10111: count5us = 8'h76	;
		5'b10110: count5us = 8'h71	;
		5'b10101: count5us = 8'h6c	;
		5'b10100: count5us = 8'h67	;
		5'b10011: count5us = 8'h63	;
		5'b10010: count5us = 8'h5d	;
		5'b10001: count5us = 8'h57	; 
		5'b10000: count5us = 8'h53	;
		5'b01111: count5us = 8'h4e	;
		5'b01110: count5us = 8'h48	;
		5'b01101: count5us = 8'h44	;
		5'b01100: count5us = 8'h3e	;
		5'b01011: count5us = 8'h39	;
		5'b01010: count5us = 8'h34      ;
		5'b01001: count5us = 8'h2f	;
		5'b01000: count5us = 8'h2a	;
		5'b00111: count5us = 8'h25	;
		5'b00110: count5us = 8'h20	;
		5'b00101: count5us = 8'h1b	;
		5'b00100: count5us = 8'h16	;
		5'b00011: count5us = 8'h11	;
		5'b00010: count5us = 8'h0c	;
		5'b00001: count5us = 8'h07	;
		default: count5us = 8'h02	;
	endcase
end

//  8us count
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count8us = 9'h107 ;
		5'b11110: count8us = 9'h0ff;
		5'b11101: count8us = 9'h0ef ;
		5'b11100: count8us = 9'h0e8 ;
		5'b11011: count8us = 9'h0e1 ;
		5'b11010: count8us = 9'h0db ;
		5'b11001: count8us = 9'h0cf ;
		5'b11000: count8us = 9'h0ca ;
		5'b10111: count8us = 9'h0c0 ;
		5'b10110: count8us = 9'h0b7 ;
		5'b10101: count8us = 9'h0ae ;
		5'b10100: count8us = 9'h0a7 ;
		5'b10011: count8us = 9'h0a0 ;
		5'b10010: count8us = 9'h096 ;
		5'b10001: count8us = 9'h08e ;
		5'b10000: count8us = 9'h086 ;
		5'b01111: count8us = 9'h080 ;
		5'b01110: count8us = 9'h076 ;
		5'b01101: count8us = 9'h06f ;
		5'b01100: count8us = 9'h066 ;
		5'b01011: count8us = 9'h05e ;
		5'b01010: count8us = 9'h055 ;
		5'b01001: count8us = 9'h04d ;
		5'b01000: count8us = 9'h045 ;
		5'b00111: count8us = 9'h03e ;
		5'b00110: count8us = 9'h035 ;
		5'b00101: count8us = 9'h02d ;
		5'b00100: count8us = 9'h025 ;
		5'b00011: count8us = 9'h01d ;
		5'b00010: count8us = 9'h015 ;
		5'b00001: count8us = 9'h00d ;
		default: count8us = 9'h005 ;
	endcase
	end

// 10us count
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count10us = 9'h14a	;
		5'b11110: count10us = 9'h13f	; // 2009.10.09
		5'b11101: count10us = 9'h12c	; // 2009.10.09
		5'b11100: count10us = 9'h123	; // 2009.10.09
		5'b11011: count10us = 9'h11a	; // 2009.10.09
		5'b11010: count10us = 9'h112	; // 2009.10.09
		5'b11001: count10us = 9'h104	; // 2009.10.09
		5'b11000: count10us = 9'h0fd	; // 2009.10.09
		5'b10111: count10us = 9'h0f0	; // 2009.10.09
		5'b10110: count10us = 9'h0e5	; // 2009.10.09
		5'b10101: count10us = 9'h0db	; // 2009.10.09
		5'b10100: count10us = 9'h0d1	; // 2009.10.09
		5'b10011: count10us = 9'h0c9	; // 2009.10.09
		5'b10010: count10us = 9'h0bd	; // 2009.10.09
		5'b10001: count10us = 9'h0b2	; // 2009.10.09 
		5'b10000: count10us = 9'h0a9	; // 2009.10.09
		5'b01111: count10us = 9'h0a0	; // 2009.10.09
		5'b01110: count10us = 9'h094	; // 2009.10.09
		5'b01101: count10us = 9'h08b	; // 2009.10.09
		5'b01100: count10us = 9'h080	; // 2009.10.09
		5'b01011: count10us = 9'h076	; // 2009.10.09 
		5'b01010: count10us = 9'h06c    ; // 2009.10.09
		5'b01001: count10us = 9'h062	; // 2009.10.09
		5'b01000: count10us = 9'h057	; // 2009.10.09
		5'b00111: count10us = 9'h04e	; // 2009.10.09
		5'b00110: count10us = 9'h043	; // 2009.10.09
		5'b00101: count10us = 9'h039	; // 2009.10.09
		5'b00100: count10us = 9'h02f	; // 2009.10.09
		5'b00011: count10us = 9'h025	; // 2009.10.09
		5'b00010: count10us = 9'h01b	; // 2009.10.09
		5'b00001: count10us = 9'h011	; // 2009.10.09
		default: count10us = 9'h007	; // 2009.10.09
	endcase
end

// 12us count
	always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count12us = 9'h18c ;
		5'b11110: count12us = 9'h180 ;
		5'b11101: count12us = 9'h168 ;
		5'b11100: count12us = 9'h15d ;
		5'b11011: count12us = 9'h153 ;
		5'b11010: count12us = 9'h14a ;
		5'b11001: count12us = 9'h138 ;
		5'b11000: count12us = 9'h130 ;
		5'b10111: count12us = 9'h121 ;
		5'b10110: count12us = 9'h114 ;
		5'b10101: count12us = 9'h107 ;
		5'b10100: count12us = 9'h0fc ;
		5'b10011: count12us = 9'h0f1 ;
		5'b10010: count12us = 9'h0e3 ;
		5'b10001: count12us = 9'h0d7 ;
		5'b10000: count12us = 9'h0cb ;
		5'b01111: count12us = 9'h0c1 ;
		5'b01110: count12us = 9'h0b2 ;
		5'b01101: count12us = 9'h0a8 ;
		5'b01100: count12us = 9'h09a ;
		5'b01011: count12us = 9'h08f ;
		5'b01010: count12us = 9'h082 ;
		5'b01001: count12us = 9'h076 ;
		5'b01000: count12us = 9'h06a ;
		5'b00111: count12us = 9'h05e ;
		5'b00110: count12us = 9'h052 ;	
		5'b00101: count12us = 9'h045 ;
		5'b00100: count12us = 9'h039 ;
		5'b00011: count12us = 9'h02d ;
		5'b00010: count12us = 9'h021 ;
		5'b00001: count12us = 9'h015 ;	
		default: count12us = 9'h009 ;
		endcase
	end

// 20us count
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count20us = 10'h297	;
		5'b11110: count20us = 10'h282	;
		5'b11101: count20us = 10'h25b	;
		5'b11100: count20us = 10'h249	;
		5'b11011: count20us = 10'h238	;
		5'b11010: count20us = 10'h228	;
		5'b11001: count20us = 10'h20b	;
		5'b11000: count20us = 10'h1fd	;
		5'b10111: count20us = 10'h1e4	;
		5'b10110: count20us = 10'h1ce	;
		5'b10101: count20us = 10'h1b9	;
		5'b10100: count20us = 10'h1a6	;
		5'b10011: count20us = 10'h195	;
		5'b10010: count20us = 10'h17d	;
		5'b10001: count20us = 10'h168	; 
		5'b10000: count20us = 10'h155	;
		5'b01111: count20us = 10'h144	;
		5'b01110: count20us = 10'h12c	;
		5'b01101: count20us = 10'h11a	;
		5'b01100: count20us = 10'h104	;
		5'b01011: count20us = 10'h0f0	;
		5'b01010: count20us = 10'h0db   ;
		5'b01001: count20us = 10'h0c7	;
		5'b01000: count20us = 10'h0b2	;
		5'b00111: count20us = 10'h09f	;
		5'b00110: count20us = 10'h08a	;
		5'b00101: count20us = 10'h076	;
		5'b00100: count20us = 10'h062	;
		5'b00011: count20us = 10'h04d	;
		5'b00010: count20us = 10'h039	;
		5'b00001: count20us = 10'h025	;
		default: count20us = 10'h011	;
	endcase
end


// 40us count
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count40us = 11'h532	; // 2009.10.09
		5'b11110: count40us = 11'h507	; // 2009.10.09
		5'b11101: count40us = 11'h4b9	; // 2009.10.09
		5'b11100: count40us = 11'h495	; // 2009.10.09
		5'b11011: count40us = 11'h473	; // 2009.10.09
		5'b11010: count40us = 11'h454	; // 2009.10.09
		5'b11001: count40us = 11'h419	; // 2009.10.09
		5'b11000: count40us = 11'h3fe	; // 2009.10.09
		5'b10111: count40us = 11'h3cc	; // 2009.10.09
		5'b10110: count40us = 11'h39f	; // 2009.10.09
		5'b10101: count40us = 11'h375	; // 2009.10.09
		5'b10100: count40us = 11'h350	; // 2009.10.09
		5'b10011: count40us = 11'h32d	; // 2009.10.09
		5'b10010: count40us = 11'h2fe	; // 2009.10.09
		5'b10001: count40us = 11'h2d4	; // 2009.10.09 
		5'b10000: count40us = 11'h2ae	; // 2009.10.09
		5'b01111: count40us = 11'h28c	; // 2009.10.09
		5'b01110: count40us = 11'h25b	; // 2009.10.09
		5'b01101: count40us = 11'h238	; // 2009.10.09
 		5'b01100: count40us = 11'h20b	; // 2009.10.09
		5'b01011: count40us = 11'h1e4	; 
		5'b01010: count40us = 11'h1b9   ;
		5'b01001: count40us = 11'h191	;
		5'b01000: count40us = 11'h168	;
		5'b00111: count40us = 11'h142	;
		5'b00110: count40us = 11'h118	;
		5'b00101: count40us = 11'h0ef	;
		5'b00100: count40us = 11'h0c7	;
		5'b00011: count40us = 11'h09e	;
		5'b00010: count40us = 11'h076	;
		5'b00001: count40us = 11'h04d	;
		default: count40us = 11'h025	;
	endcase
end


// 60us count
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count60us = 11'h7cc	;
		5'b11110: count60us = 11'h78c	;
		5'b11101: count60us = 11'h717	;
		5'b11100: count60us = 11'h6e1	;
		5'b11011: count60us = 11'h6af	;
		5'b11010: count60us = 11'h67f	;
		5'b11001: count60us = 11'h627	;
		5'b11000: count60us = 11'h5ff	;
		5'b10111: count60us = 11'h5b4	;
		5'b10110: count60us = 11'h570	;
		5'b10101: count60us = 11'h532	;
		5'b10100: count60us = 11'h4f9	;
		5'b10011: count60us = 11'h4c5	;
		5'b10010: count60us = 11'h47e	;
		5'b10001: count60us = 11'h43f	; 
		5'b10000: count60us = 11'h407	;
		5'b01111: count60us = 11'h3d4	;
		5'b01110: count60us = 11'h38a	;
		5'b01101: count60us = 11'h356	;
		5'b01100: count60us = 11'h312	;
		5'b01011: count60us = 11'h2d8	;
		5'b01010: count60us = 11'h297  	;
		5'b01001: count60us = 11'h25b	;
		5'b01000: count60us = 11'h21e	;
		5'b00111: count60us = 11'h1e4	;
		5'b00110: count60us = 11'h1a6	;
		5'b00101: count60us = 11'h168	;
		5'b00100: count60us = 11'h12c	;
		5'b00011: count60us = 11'h0ef	;
		5'b00010: count60us = 11'h0b2	;
		5'b00001: count60us = 11'h076	;
		default: count60us = 11'h039	;
	endcase
end



// 1ms count
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count1ms = 16'h8232 ;
		5'b11110: count1ms = 16'h7dff ; // 2009.10.05
		5'b11101: count1ms = 16'h765c ;
		5'b11100: count1ms = 16'h72e0 ;
		5'b11011: count1ms = 16'h6f98 ;
		5'b11010: count1ms = 16'h6c7e ;
		5'b11001: count1ms = 16'h66c8 ;
		5'b11000: count1ms = 16'h6426 ;
		5'b10111: count1ms = 16'h5f43 ;
		5'b10110: count1ms = 16'h5ad4 ;
		5'b10101: count1ms = 16'h56cb ;
		5'b10100: count1ms = 16'h5319 ;
		5'b10011: count1ms = 16'h4fb5 ;
		5'b10010: count1ms = 16'h4b1b ;
		5'b10001: count1ms = 16'h4702 ;
		5'b10000: count1ms = 16'h4356 ;
		5'b01111: count1ms = 16'h4006 ;
		5'b01110: count1ms = 16'h3b2c ;
		5'b01101: count1ms = 16'h37ca ;
		5'b01100: count1ms = 16'h3362 ;
		5'b01011: count1ms = 16'h2fa0 ;
		5'b01010: count1ms = 16'h2b64 ;
		5'b01001: count1ms = 16'h2772 ;
		5'b01000: count1ms = 16'h237f ;
		5'b00111: count1ms = 16'h1fbf ;
		5'b00110: count1ms = 16'h1bb1 ;
		5'b00101: count1ms = 16'h17a9 ;
		5'b00100: count1ms = 16'h13b7 ;
		5'b00011: count1ms = 16'h0fcd ;
		5'b00010: count1ms = 16'h0bd3 ;
		5'b00001: count1ms = 16'h07e1 ;
		default: count1ms =  16'h03ef ;
	endcase
end

// 5ms count5ms
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count5ms = 18'h28b07 ;
		5'b11110: count5ms = 18'h27607 ;
		5'b11101: count5ms = 18'h24fd8 ;
		5'b11100: count5ms = 18'h23e6f ;
		5'b11011: count5ms = 18'h22e06 ;
		5'b11010: count5ms = 18'h21e85 ;
		5'b11001: count5ms = 18'h201f7 ;
		5'b11000: count5ms = 18'h1f4ca ;
		5'b10111: count5ms = 18'h1dc5c ;
		5'b10110: count5ms = 18'h1c634 ;
		5'b10101: count5ms = 18'h1b204 ;
		5'b10100: count5ms = 18'h19f8b ;
		5'b10011: count5ms = 18'h18e95 ;
		5'b10010: count5ms = 18'h17796 ;
		5'b10001: count5ms = 18'h1631a ;
		5'b10000: count5ms = 18'h150bb ;
		5'b01111: count5ms = 18'h1402c ;
		5'b01110: count5ms = 18'h127ea ;
		5'b01101: count5ms = 18'h11701 ;
		5'b01100: count5ms = 18'h100fa ;
		5'b01011: count5ms = 18'h0ee2c ;
		5'b01010: count5ms = 18'h0d900 ;
		5'b01001: count5ms = 18'h0c546 ;
		5'b01000: count5ms = 18'h0b18b ;
		5'b00111: count5ms = 18'h09ec7 ;
		5'b00110: count5ms = 18'h08a81 ;
		5'b00101: count5ms = 18'h0765c ;
		5'b00100: count5ms = 18'h062a1 ;
		5'b00011: count5ms = 18'h04f0f ;
		5'b00010: count5ms = 18'h03b2c ;
		5'b00001: count5ms = 18'h02772 ;
		default : count5ms = 18'h013b7 ;
	endcase
end

// 10ms
always @( fset[4:0] ) begin
	case(fset[4:0])
		5'b11111: count10ms = 19'h51612 ; // 2009.10.05
		5'b11110: count10ms = 19'h4ec11 ;
		5'b11101: count10ms = 19'h49fb3 ;
		5'b11100: count10ms = 19'h47ce2 ;
		5'b11011: count10ms = 19'h45c0f ;
		5'b11010: count10ms = 19'h43d0e ;
		5'b11001: count10ms = 19'h403f2 ;
		5'b11000: count10ms = 19'h3e997 ;
		5'b10111: count10ms = 19'h3b8bb ;
		5'b10110: count10ms = 19'h38c6b ;
		5'b10101: count10ms = 19'h3640b ;
		5'b10100: count10ms = 19'h33f1a ;
		5'b10011: count10ms = 19'h31d2e ;
		5'b10010: count10ms = 19'h2ef30 ;
		5'b10001: count10ms = 19'h2c637 ;
		5'b10000: count10ms = 19'h2a17a ;
		5'b01111: count10ms = 19'h2805b ;
		5'b01110: count10ms = 19'h24fd8 ;
		5'b01101: count10ms = 19'h22e06 ; // 2009.10.06
		5'b01100: count10ms = 19'h201f7 ;
		5'b01011: count10ms = 19'h1dc5c ;
		5'b01010: count10ms = 19'h1b204 ;
		5'b01001: count10ms = 19'h18a8f ; // 2009.10.06
		5'b01000: count10ms = 19'h1631a ;
		5'b00111: count10ms = 19'h13d91 ;
		5'b00110: count10ms = 19'h11506 ;
		5'b00101: count10ms = 19'h0ecbb ;
		5'b00100: count10ms = 19'h0c546 ;
		5'b00011: count10ms = 19'h09e22 ;
		5'b00010: count10ms = 19'h0765c ;
		5'b00001: count10ms = 19'h04ee7 ;
		default : count10ms = 19'h02772 ;
		endcase
	end

// 20ms
	always @( fset[4:0] ) begin
		case(fset[4:0])
		5'b11111: count20ms = 20'ha2c27 ;
		5'b11110: count20ms = 20'h9d826 ;
		5'b11101: count20ms = 20'h93f69 ;
		5'b11100: count20ms = 20'h8f9c8 ;
		5'b11011: count20ms = 20'h8b821 ;
		5'b11010: count20ms = 20'h87a20 ;
		5'b11001: count20ms = 20'h807e8 ;
		5'b11000: count20ms = 20'h7d331 ;
		5'b10111: count20ms = 20'h77179 ;
		5'b10110: count20ms = 20'h718d9 ;
		5'b10101: count20ms = 20'h6c819 ;
		5'b10100: count20ms = 20'h67e38 ;
		5'b10011: count20ms = 20'h63a60 ;
		5'b10010: count20ms = 20'h5de64 ;
		5'b10001: count20ms = 20'h58c71 ;
		5'b10000: count20ms = 20'h542f8 ;
		5'b01111: count20ms = 20'h500b9 ;
		5'b01110: count20ms = 20'h49fb3 ;
		5'b01101: count20ms = 20'h45c0f ;
		5'b01100: count20ms = 20'h403f2 ;
		5'b01011: count20ms = 20'h3b8bb ;
		5'b01010: count20ms = 20'h3640b ;
		5'b01001: count20ms = 20'h31521 ;
		5'b01000: count20ms = 20'h2c637 ;
		5'b00111: count20ms = 20'h27b26 ;
		5'b00110: count20ms = 20'h22a10 ;
		5'b00101: count20ms = 20'h1d979 ;
		5'b00100: count20ms = 20'h18a8f ;
		5'b00011: count20ms = 20'h13c48 ;
		5'b00010: count20ms = 20'h0ecbb ;
		5'b00001: count20ms = 20'h09dd1 ;
		default : count20ms = 20'h04ee7 ;
	endcase
	end

// 30ms
	always @( fset[4:0] ) begin
		case(fset[4:0])
		5'b11111: count30ms = 20'hf423c ;
		5'b11110: count30ms = 20'hec43a ;
		5'b11101: count30ms = 20'hddf1f ;
		5'b11100: count30ms = 20'hd76ad ;
		5'b11011: count30ms = 20'hd1433 ;
		5'b11010: count30ms = 20'hcb732 ;
		5'b11001: count30ms = 20'hc0bde ;
		5'b11000: count30ms = 20'hbbccb ;
		5'b10111: count30ms = 20'hb2a38 ;
		5'b10110: count30ms = 20'haa547 ;
		5'b10101: count30ms = 20'ha2c27 ;
		5'b10100: count30ms = 20'h9bd56 ; // 2009.10.05
		5'b10011: count30ms = 20'h95791 ;
		5'b10010: count30ms = 20'h8cd98 ;
		5'b10001: count30ms = 20'h852ab ;
		5'b10000: count30ms = 20'h7e476 ;
		5'b01111: count30ms = 20'h78118 ;
		5'b01110: count30ms = 20'h6ef8e ;
		5'b01101: count30ms = 20'h68a18 ;
		5'b01100: count30ms = 20'h605ed ;
		5'b01011: count30ms = 20'h5951a ;
		5'b01010: count30ms = 20'h51612 ;
		5'b01001: count30ms = 20'h49fb3 ;
		5'b01000: count30ms = 20'h42954 ;
		5'b00111: count30ms = 20'h3b8bb ;
		5'b00110: count30ms = 20'h33f1a ;
		5'b00101: count30ms = 20'h2c637 ;
		5'b00100: count30ms = 20'h24fd8 ;
		5'b00011: count30ms = 20'h1da6e ;
		5'b00010: count30ms = 20'h1631a ;
		5'b00001: count30ms = 20'h0ecbb ;
		default : count30ms = 20'h0765c ;
	endcase
	end

// 40ms
	always @( fset[4:0] ) begin
		case(fset[4:0])
		5'b11111: count40ms = 21'h145852 ;
		5'b11110: count40ms = 21'h13b04f ;
		5'b11101: count40ms = 21'h127ed6 ;
		5'b11100: count40ms = 21'h11f393 ;
		5'b11011: count40ms = 21'h117046 ;
		5'b11010: count40ms = 21'h10f444 ;
		5'b11001: count40ms = 21'h100fd4 ;
		5'b11000: count40ms = 21'h0fa666 ;
		5'b10111: count40ms = 21'h0ee2f6 ;
		5'b10110: count40ms = 21'h0e31b5 ;
		5'b10101: count40ms = 21'h0d9035 ;
		5'b10100: count40ms = 21'h0cfc74 ;
		5'b10011: count40ms = 21'h0c74c3 ;
		5'b10010: count40ms = 21'h0bbccb ;
		5'b10001: count40ms = 21'h0b18e5 ;
		5'b10000: count40ms = 21'h0a85f4 ;
		5'b01111: count40ms = 21'h0a0176 ;
		5'b01110: count40ms = 21'h093f69 ;
		5'b01101: count40ms = 21'h08b821 ;
		5'b01100: count40ms = 21'h0807e8 ;
		5'b01011: count40ms = 21'h077179 ;
		5'b01010: count40ms = 21'h06c819 ;
		5'b01001: count40ms = 21'h062a45 ;
		5'b01000: count40ms = 21'h058c71 ;
		5'b00111: count40ms = 21'h04f650 ;
		5'b00110: count40ms = 21'h045424 ;
		5'b00101: count40ms = 21'h03b2f5 ;
		5'b00100: count40ms = 21'h031521 ;
		5'b00011: count40ms = 21'h027894 ;
		5'b00010: count40ms = 21'h01d979 ;
		5'b00001: count40ms = 21'h013ba5 ;
		default : count40ms = 21'h009dd1 ;	
	   endcase
	end

// 50ms
	always @( fset[4:0] ) begin
		case(fset[4:0])
		5'b11111: count50ms = 21'h196e67 ;
		5'b11110: count50ms = 21'h189c64 ;
		5'b11101: count50ms = 21'h171e8c ;
		5'b11100: count50ms = 21'h167079 ;
		5'b11011: count50ms = 21'h15cc58 ;
		5'b11010: count50ms = 21'h153155 ;
		5'b11001: count50ms = 21'h1413ca ;
		5'b11000: count50ms = 21'h139000 ;
		5'b10111: count50ms = 21'h129bb5 ;
		5'b10110: count50ms = 21'h11be23 ;
		5'b10101: count50ms = 21'h10f444 ;
		5'b10100: count50ms = 21'h103b92 ;
		5'b10011: count50ms = 21'h0f91f5 ;
		5'b10010: count50ms = 21'h0eabff ;
		5'b10001: count50ms = 21'h0ddf1f ;
		5'b10000: count50ms = 21'h0d2771 ;
		5'b01111: count50ms = 21'h0c81d5 ;
		5'b01110: count50ms = 21'h0b8f44 ;
		5'b01101: count50ms = 21'h0ae62a ;
		5'b01100: count50ms = 21'h0a09e3 ;
		5'b01011: count50ms = 21'h094dd9 ;
		5'b01010: count50ms = 21'h087a20 ;
		5'b01001: count50ms = 21'h07b4d7 ;
		5'b01000: count50ms = 21'h06ef8e ;
		5'b00111: count50ms = 21'h0633e5 ;
		5'b00110: count50ms = 21'h05692e ;
		5'b00101: count50ms = 21'h049fb3 ;
		5'b00100: count50ms = 21'h03da6a ;
		5'b00011: count50ms = 21'h0316ba ;
		5'b00010: count50ms = 21'h024fd8 ;
		5'b00001: count50ms = 21'h018a8f ;
		default : count50ms = 21'h00c546 ;
	     endcase
	end


	// 100ms
	always @( fset[4:0] ) begin
		case(fset[4:0])
		5'b11111: count100ms = 22'h32dcd2 ;
		5'b11110: count100ms = 22'h3138cb ;
		5'b11101: count100ms = 22'h2e3d1c ;
		5'b11100: count100ms = 22'h2ce0f5 ;
		5'b11011: count100ms = 22'h2b98b3 ;
		5'b11010: count100ms = 22'h2a62ae ; // 2009.10.05
		5'b11001: count100ms = 22'h282797 ;
		5'b11000: count100ms = 22'h272003 ;
		5'b10111: count100ms = 22'h25376d ;
		5'b10110: count100ms = 22'h237c4a ;
		5'b10101: count100ms = 22'h21e88b ;
		5'b10100: count100ms = 22'h207728 ;
		5'b10011: count100ms = 22'h1f23ed ;
		5'b10010: count100ms = 22'h1d5801 ;
		5'b10001: count100ms = 22'h1bbe42 ;
		5'b10000: count100ms = 22'h1a4ee6 ;
		5'b01111: count100ms = 22'h1903ad ; // 2009.10.05
		5'b01110: count100ms = 22'h171e8c ;
		5'b01101: count100ms = 22'h15cc58 ;
		5'b01100: count100ms = 22'h1413ca ;
		5'b01011: count100ms = 22'h129bb5 ;
		5'b01010: count100ms = 22'h10f444 ;
		5'b01001: count100ms = 22'h0f69b2 ;
		5'b01000: count100ms = 22'h0ddf1f ;
		5'b00111: count100ms = 22'h0c67cd ;
		5'b00110: count100ms = 22'h0ad260 ; // 2009.10.6
		5'b00101: count100ms = 22'h093f69 ;
		5'b00100: count100ms = 22'h07b4d7 ;
		5'b00011: count100ms = 22'h062d77 ;
		5'b00010: count100ms = 22'h049fb3 ;
		5'b00001: count100ms = 22'h031521 ;
		default:  count100ms = 22'h018a8f ;
		endcase
	end


	always@( fpser2 or fpser1 or fpser0 or count1ms or
		count5ms  or count10ms or count20ms or count30ms or 
		count40ms or count50ms or count100ms )	begin
	case({fpser2, fpser1, fpser0})
		3'b000	:	counterase = { 6'h00, count1ms[15:0] } ;
 		3'b001  :	counterase = { 4'h0,  count5ms[17:0] } ;
		3'b010	:	counterase = { 3'h0,  count10ms[18:0] } ;
		3'b011  :	counterase = { 2'h0,  count20ms[19:0] } ;
		3'b100	:	counterase = { 2'h0,  count30ms[19:0] } ;
		3'b101	:	counterase = { 1'h0,  count40ms[20:0] } ;
		3'b110  :	counterase = { 1'h0,  count50ms[20:0] } ;
		default :	counterase = count100ms ;
	endcase
	end

	always@( fpwwr2 or fpwwr1 or fpwwr0 or count5us or
		count8us  or count10us or count12us or count20us or 
		count40us or count60us )	begin
	case({fpwwr2, fpwwr1, fpwwr0})
		3'b000	:	countwrite = {3'b000,  count5us[7:0]  }	;
		3'b001  :	countwrite = {2'b00,   count8us[8:0]  }	;
		3'b010	:	countwrite = {2'b00,   count10us[8:0] }	;
		3'b011  :	countwrite = {2'b00,   count12us[8:0] }	;
		3'b100	:	countwrite = {1'b0,    count20us[9:0] }	;
		3'b101	:	countwrite = count40us[10:0]   ;
		3'b110  :       countwrite = count60us[10:0]   ;
		default :	countwrite  =count60us[10:0]   ;
	endcase
	end

       
endmodule

module QLK0RFCBM3SF1V1_FCB_SECURE   ( 
	flap19,		flap18,		flap17,		flap16,		flap15,
	flap14,		flap13,		flap12,		flap11,		flap10,
	flap9,		flap8,		flap7,		flap6,		flap5,
	flap4,		flap3,		flap2,		flap1,		flap0,
	flsed19,	flsed18,	flsed17,	flsed16,	flsed15,
	flsed14,	flsed13,	flsed12,	flsed11,	flsed10,
	flsed9,		flsed8,		flsed7,		flsed6,		flsed5,
	flsed4,		flsed3,		flsed2,		flsed1,		flsed0,
	btbls1,		btbls0,		onbd,		flspm,		exa,
	btpr,		wrpr,		cepr,		sepr,
	fswe9,		fswe8,		fswe7,		fswe6,
	fswe5,		fswe4,		fswe3,		fswe2,		fswe1,
	fswe0,		fsws9,		fsws8,		fsws7,		fsws6,
	fsws5,		fsws4,		fsws3,		fsws2,		fsws1,
	fsws0,		seldfl,		p_seqer,	sqmd2,
	sqmd1,		sqmd0,		flmemtes,	esqst,		act1,
	eeemd
);

 input 	flap19,		flap18,		flap17,		flap16,		flap15 ;
 input	flap14,		flap13,		flap12,		flap11,		flap10 ;
 input	flap9,		flap8,		flap7,		flap6,		flap5  ;
 input	flap4,		flap3,		flap2,		flap1,		flap0  ;
 input	flsed19,	flsed18,	flsed17,	flsed16,	flsed15 ;
 input	flsed14,	flsed13,	flsed12,	flsed11,	flsed10 ;
 input	flsed9,		flsed8,		flsed7,		flsed6,		flsed5	;
 input	flsed4,		flsed3,		flsed2,		flsed1,		flsed0	;
 input	btbls1,		btbls0,		onbd,		flspm,		exa	;
 input	btpr,		wrpr,		cepr,		sepr			;
 input  fswe9,		fswe8,		fswe7,		fswe6			;
 input	fswe5,		fswe4,		fswe3,		fswe2,		fswe1	;
 input	fswe0,		fsws9,		fsws8,		fsws7,		fsws6	;
 input	fsws5,		fsws4,		fsws3,		fsws2,		fsws1	;
 input	fsws0,		seldfl,		sqmd2,		sqmd1			;
 input	sqmd0,		flmemtes,	esqst,		act1,		eeemd	;

 output	p_seqer									;

 reg uplimit, eearea ;

 wire	btar,		btpren,		ewdisz,		cedisz1,	wrdisz 	;
 wire	cedisz0,	sedisz0,	prar,		wren,		seen	;
 wire	ceen,		p_seqer,	adcheck,	prar2			;

 wire [19:0] flap = {
	flap19,		flap18,		flap17,		flap16,		flap15,
	flap14,		flap13,		flap12,		flap11,		flap10,
	flap9,		flap8,		flap7,		flap6,		flap5,
	flap4,		flap3,		flap2,		flap1,		flap0	} ;

 wire [19:0] flsed = {
	flsed19,	flsed18,	flsed17,	flsed16,	flsed15,
	flsed14,	flsed13,	flsed12,	flsed11,	flsed10,
	flsed9,		flsed8,		flsed7,		flsed6,		flsed5,
	flsed4,		flsed3,		flsed2,		flsed1,		flsed0	 } ;

 wire [9:0] fswe = {
	fswe9,		fswe8,		fswe7,		fswe6,
	fswe5,		fswe4,		fswe3,		fswe2,		fswe1,
	fswe0	} ;
 wire [9:0] fsws  = {
			fsws9,		fsws8,		fsws7,		fsws6,
	fsws5,		fsws4,		fsws3,		fsws2,		fsws1,
	fsws0  } ;

 wire [2:0] sqmd = {	sqmd2,		sqmd1,		sqmd0	};

 wire [1:0]  btbls = {	btbls1,	btbls0 } ;


//  Boot Block Craster 
//  BTAR
wire [19:12] flap_btbls = flap[19:12] ;

 always@(btbls[1:0] or flap_btbls[19:12] )begin
  	case(btbls)
		2'b10	:	uplimit = | flap_btbls[19:14] ;
		2'b01	:	uplimit = | flap_btbls[19:13] ;
		default :	uplimit = | flap_btbls[19:12] ;
	endcase
  end 

 wire[19:10] flap_fsw  = flap[19:10]  ;
 wire[19:10] flsed_fsw = act1 ? flap[19:10] : flsed[19:10] ;
 
// Flash Shild Window
 always @( fsws or fswe or flap_fsw or flsed_fsw ) begin
	if(fsws[9:0]==fswe[9:0])	eearea = 1'b0 								;
	else if(fswe[9:0]==flap_fsw[19:10]) 
					eearea = 1'b1								;
	else				eearea	= ((flap_fsw[19:10]<fsws[9:0]) | (fswe[9:0]<=flsed_fsw[19:10])) 	;
	end


  assign	btar = ~uplimit & ~exa ;

  assign	btpren = onbd  | flspm		   	;
  assign	ewdisz = btpr  | ~btpren | ~btar	;
  assign	cedisz1= btpr  | ~flspm			;
  assign	wrdisz = wrpr  | ~onbd			;
  assign	cedisz0 = cepr | ~onbd			;
  assign	sedisz0 = sepr | ~onbd			;
  assign	prar	= ~onbd & flspm & eearea &  ~seldfl ;
  assign 	prar2   = ~onbd & flspm & ~(fsws[9:0]==fswe[9:0]) &  ~seldfl ;
  assign	wren = wrdisz & ewdisz & ~prar 				;
  assign	seen = wrdisz & sedisz0 & cedisz0 & ewdisz & ~prar 	;
  assign	ceen = cedisz0 & cedisz1 & ~prar2			;
  assign	adcheck = flap[19:0] > flsed[19:0]			;
 
  assign	p_seqer = ((flspm & seldfl) | (eeemd & ~seldfl))	|
			  (~(sqmd[2:0]==3'h1) & adcheck) 		|
			  ((sqmd[2:0]==3'h1) & ~wren & ~exa & ~flmemtes)   	|
			  ((sqmd[2:0]==3'h4) & ~seen & ~exa & ~flmemtes)   	|
			  ((sqmd[2:0]==3'h6) & ~ceen & ~flmemtes)   	|
			  (((sqmd[2:0]==3'h1)|(sqmd[2:0]==3'h4)|(sqmd[2:0]==3'h6)) & (exa & ~esqst) &~flmemtes ) ;

  endmodule

//  module name ... QLK0RFCBM3SF1V1_APBIF
//  version     ... 1
//  designer    ... Y.Terauchi

module QLK0RFCBM3SF1V1_APBIF (    psel1        	, psel2		, paddr4	, paddr3       	, paddr2       	, paddr1    ,
                                  paddr0       	, pwrite       	, penable      	,
                                sel_pfcmd	, sel_pfs	, sel_flpmc	, sel_flars	, sel_flaph	,
				sel_flapll	, sel_flaplh	, sel_flsedh	, sel_flsedll	, sel_flsedlh	,
				sel_fssql	, sel_fsse	, sel_flrst	, sel_fsset	,
				sel_fsasth	, sel_fsastl	, sel_flfadh	, sel_flfadll	, sel_flfadlh	,
				sel_flwhh	, sel_flwhl	, sel_flwll	, sel_flwlh	, sel_flrhh	,
				sel_flrhl	, sel_flrll	, sel_flrlh	, sel_flwe	, sel_flre	,
				sel_fltmsh	, sel_fltmsl	, sel_flmch	, sel_flmcll	, sel_flmclh	, 
				sel_dflmcl	, sel_dflmch	, sel_fsctl	, sel_flsech	, 
				sel_flfswel	, sel_flfsweh	, sel_flfswsl	, sel_flfswsh	,
				
				we_flars	, we_flaph	,we_flapll	, we_flaplh	, we_flsedh	, 
				we_flsedll	, we_flsedlh	,we_fssql	, we_fsse	, 
				we_flrst	, we_fsset	,we_flwhh	, we_flwhl	, we_flwll	, 
				we_flwlh	, we_flwe	,we_fltmsh	, we_fltmsl	, we_flmch	, 
				we_flmcl	 		,we_dflmcl	, we_dflmch	, we_fsctl	,
				flmemtes	, flspm		,eeemd		, fwedis	, tesman
				
) ;

  //  *****  input signal define  *****
  input		psel1 ;	   // chip select
  input		psel2 ;     // chip select
  input         paddr4 ;           // address bit from APB
  input         paddr3 ;           // address bit from APB
  input         paddr2 ;           // address bit from APB
  input         paddr1 ;           // address bit from APB
  input         paddr0 ;           // address bit from APB
  input         pwrite ;           // read/write status from APB
  input		penable ;
  input		flmemtes, flspm, eeemd,	fwedis ;


  //  *****  output signal define  *****
  output	sel_pfcmd	, sel_pfs	, sel_flpmc	, sel_flars	, sel_flaph	;
  output	sel_flapll	, sel_flaplh	, sel_flsedh	, sel_flsedll	, sel_flsedlh	;
  output	sel_fssql	, sel_fsse	, sel_flrst	, sel_fsset	;
  output	sel_fsasth	, sel_fsastl	, sel_flfadh	, sel_flfadll	, sel_flfadlh	;
  output	sel_flwhh	, sel_flwhl	, sel_flwll	, sel_flwlh	, sel_flrhh	;
  output	sel_flrhl	, sel_flrll	, sel_flrlh	, sel_flwe	, sel_flre	;
  output	sel_fltmsh	, sel_fltmsl	, sel_flmch	, sel_flmcll	, sel_flmclh	;
  output	sel_dflmcl	, sel_dflmch	, sel_fsctl					;
  output	sel_flsech	, sel_flfswel	, sel_flfsweh	, sel_flfswsl			;
  output	sel_flfswsh									;
				
  output 	we_flars	, we_flaph	,we_flapll	, we_flaplh	, we_flsedh	;
  output	we_flsedll	, we_flsedlh	,we_fssql	, we_fsse	;
  output	we_flrst	, we_fsset	,we_flwhh	, we_flwhl	, we_flwll	;
  output	we_flwlh	, we_flwe	,we_fltmsh	, we_fltmsl	, we_flmch	;
  output	we_flmcl			,we_dflmcl	, we_dflmch	, we_fsctl	;
  output	tesman										;
 

  //  *****  register signal define  *****
  reg	[7:0]	sel1 ;  // for PSEL=1
  reg	[13:0]	sel2 ;  // for PSEL=2

  wire 	sel_pfcmd,	sel_pfs,	sel_flpmc,	sel_flars,	sel_flapll,	sel_flaplh 	;	
  wire	sel_flaph,	sel_flsedll,	sel_flsedlh,	sel_flsedh,	sel_fssql			;	
  wire	sel_fsse,	sel_flrst,	sel_fsastl,	sel_fsasth,	sel_fsset		   	;	
  wire	sel_flfadll,	sel_flfadlh,	sel_flfadh,	sel_flwhl,	sel_flwhh,	sel_flwll  	;		
  wire	sel_flwlh,	sel_flrhl,	sel_flrhh,	sel_flrll,	sel_flrlh,	sel_flwe   	;		
  wire	sel_flre,	sel_fltmsl,	sel_fltmsh,	sel_flmch,	sel_flmclh 			;
  wire	sel_flmcll,	sel_dflmcl,	sel_dflmch,	sel_fsctl,	sel_flsech			;
  wire	sel_flfswel,	sel_flfsweh,	sel_flfswsl,	sel_flfswsh				  	;
 
  wire	we_flars,	we_flapll,	we_flaplh,	we_flaph,	we_flsedll,	we_flsedlh 	;	 
  wire	we_flsedh,	we_fssql,	we_fsse,	we_flrst,	we_fsset  	;	
  wire	we_flwhl,	we_flwhh,	we_flwll,	we_flwlh,	we_flwe,	we_fltmsl	;
  wire	we_fltmsh,	we_flmcl,			we_flmch,	we_dflmcl,	we_dflmch	;
  wire	we_fsctl   	;	
  wire	flmod,		fssqen,		fsseen,		tesman						;


  //  *****  Address Data Latch  *****
  always @( psel2 or psel1 or paddr4 or paddr3 or paddr2 or paddr1 ) begin
    if( {psel2, psel1} != 2'b01 )
      sel1[7:0] = 8'h00 ;
    else
      case ( { paddr4, paddr3 , paddr2 , paddr1 } ) 
          4'b0000 : sel1[7:0] = 8'h01 ;
          4'b0001 : sel1[7:0] = 8'h02 ;
          4'b0010 : sel1[7:0] = 8'h04 ;
          4'b0011 : sel1[7:0] = 8'h08 ;
          4'b0100 : sel1[7:0] = 8'h10 ;
          4'b0101 : sel1[7:0] = 8'h20 ;
          4'b0110 : sel1[7:0] = 8'h40 ;
          4'b0111 : sel1[7:0] = 8'h80 ;
	  default : sel1[7:0] = 8'h00 ;
      endcase
  end

  always @( psel2 or psel1 or paddr4 or paddr3 or paddr2 or paddr1 ) begin
    if( {psel2, psel1} != 2'b10 ) 
      sel2[13:0] = 14'h0000 ;
    else
      case ( { paddr4, paddr3 , paddr2 , paddr1 } ) 
          4'b0000 : sel2[13:0] = 14'h0001 ;
          4'b0001 : sel2[13:0] = 14'h0002 ;
          4'b0010 : sel2[13:0] = 14'h0004 ;
          4'b0011 : sel2[13:0] = 14'h0008 ;
          4'b0100 : sel2[13:0] = 14'h0010 ;
          4'b0101 : sel2[13:0] = 14'h0020 ;
          4'b0110 : sel2[13:0] = 14'h0040 ;
          4'b0111 : sel2[13:0] = 14'h0080 ;
          4'b1000 : sel2[13:0] = 14'h0100 ;
          4'b1001 : sel2[13:0] = 14'h0200 ;
          4'b1010 : sel2[13:0] = 14'h0400 ;
          4'b1011 : sel2[13:0] = 14'h0800 ;
          4'b1100 : sel2[13:0] = 14'h1000 ;
          4'b1101 : sel2[13:0] = 14'h2000 ;
	  default : sel2[13:0] = 14'h0000 ;
      endcase
  end

	
  //  *****  SFR Register Read/Write Select   *****
  assign sel_flpmc	= sel1[0]  & ~paddr0 ; // 8 bits (l)
  assign sel_flars	= sel1[0]  &  paddr0 ; // 8 bits (h)
  assign sel_flapll	= sel1[1]  & ~paddr0 ; // 16 bits
  assign sel_flaplh	= sel1[1]  & ~paddr0 ;
  assign sel_flaph	= sel1[2]  & ~paddr0 ; // 8 bits (l)
  assign sel_fssql	= sel1[2]  &  paddr0 ; // 8 bits (h)
  assign sel_flsedll	= sel1[3]  & ~paddr0 ; // 16 bits
  assign sel_flsedlh	= sel1[3]  & ~paddr0 ;
  assign sel_flsedh	= sel1[4]  & ~paddr0 ; // 8 bits (l)
  assign sel_flrst	= sel1[4]  &  paddr0 ; // 8 bits (h)
  assign sel_fsastl	= sel1[5]  & ~paddr0 ; // 8 bits (l)
  assign sel_fsasth	= sel1[5]  &  paddr0 ; // 8 bits (h)
  assign sel_flwll	= sel1[6]  & ~paddr0 ; // 16 bits
  assign sel_flwlh	= sel1[6]  & ~paddr0 ;
  assign sel_flwhl	= sel1[7]  & ~paddr0 ; // 16 bits
  assign sel_flwhh	= sel1[7]  & ~paddr0 ;

  assign sel_pfcmd	= sel2[0]  & ~paddr0 & pwrite & penable ; // 8 bits (l)
  assign sel_pfs	= sel2[0]  &  paddr0 ; // 8 bits (h)
  assign sel_flrll	= sel2[1]  & ~paddr0 ; // 16 bits
  assign sel_flrlh	= sel2[1]  & ~paddr0 ;
  assign sel_flrhl	= sel2[2]  & ~paddr0 ; // 16 bits
  assign sel_flrhh	= sel2[2]  & ~paddr0 ;
  assign sel_flwe	= sel2[3]  & ~paddr0 ; // 8 bits (l)
  assign sel_flre	= sel2[3]  &  paddr0 ; // 8 bits (h)
  assign sel_fltmsl	= sel2[4]  & ~paddr0 ; // 16 bits
  assign sel_fltmsh	= sel2[4]  & ~paddr0 ;
  assign sel_dflmcl	= sel2[5]  & ~paddr0 ; // 16 bits
  assign sel_dflmch	= sel2[5]  & ~paddr0 ;
  assign sel_flmcll	= sel2[6]  & ~paddr0 ; // 16 bits
  assign sel_flmclh	= sel2[6]  & ~paddr0 ;
  assign sel_flmch	= sel2[7]  & ~paddr0 ; // 8 bits (l)
  assign sel_fsctl	= sel2[7]  &  paddr0 ; // 8 bits (h)
//  assign sel_flsecl	= sel2[8]  & ~paddr0 ; // 16 bits
  assign sel_flsech	= sel2[8]  & ~paddr0 ;
  assign sel_flfswsl	= sel2[9]  & ~paddr0 ; // 16 bits
  assign sel_flfswsh	= sel2[9]  & ~paddr0 ;
  assign sel_flfswel	= sel2[10] & ~paddr0 ; // 16 bits
  assign sel_flfsweh	= sel2[10] & ~paddr0 ;
  assign sel_fsset	= sel2[11] & ~paddr0 ; // 8 bits (l)
  assign sel_fsse	= sel2[11] &  paddr0 ; // 8 bits (h)
  assign sel_flfadll	= sel2[12] & ~paddr0 ; // 16 bits
  assign sel_flfadlh	= sel2[12] & ~paddr0 ;
  assign sel_flfadh	= sel2[13] & ~paddr0 ; // 8 bits (l)
 

  //  *****  SFR Register Read/Write Select   *****
  assign tesman		=	      flspm  | eeemd    ;
  assign flmod 		= flmemtes |  tesman	 	;
  assign fssqen		= flmemtes | (flspm & ~fwedis | eeemd)		;
  assign fsseen		= flspm & ~fwedis		;

  assign we_flars	= sel1[0]  & pwrite & penable &  paddr0 & flmod;     // 8 bits (h)
  assign we_flapll	= sel1[1]  & pwrite & penable & ~paddr0 & flmod;     // 16 bits
  assign we_flaplh	= sel1[1]  & pwrite & penable & ~paddr0 & flmod;
  assign we_flaph	= sel1[2]  & pwrite & penable & ~paddr0 & flmod;     // 8 bits (l)
  assign we_fssql	= sel1[2]  & pwrite & penable &  paddr0 & fssqen;    // 8 bits (h)
  assign we_flsedll	= sel1[3]  & pwrite & penable & ~paddr0 & flmod;     // 16 bits
  assign we_flsedlh	= sel1[3]  & pwrite & penable & ~paddr0 & flmod;
  assign we_flsedh	= sel1[4]  & pwrite & penable & ~paddr0 & flmod;     // 8 bits (l)
  assign we_flrst	= sel1[4]  & pwrite & penable &  paddr0 ;            // 8 bits (h)
  assign we_flwll	= sel1[6]  & pwrite & penable & ~paddr0 & flmod;     // 16 bits
  assign we_flwlh	= sel1[6]  & pwrite & penable & ~paddr0 & flmod;
  assign we_flwhl	= sel1[7]  & pwrite & penable & ~paddr0 & flmod;     // 16 bits
  assign we_flwhh	= sel1[7]  & pwrite & penable & ~paddr0 & flmod;

  assign we_flwe	= sel2[3]  & pwrite & penable & ~paddr0 & flmod;     // 8 bits (l)
  assign we_fltmsl	= sel2[4]  & pwrite & penable & ~paddr0 & flmemtes ; // 16 bits
  assign we_fltmsh	= sel2[4]  & pwrite & penable & ~paddr0 & flmemtes ;
  assign we_dflmcl	= sel2[5]  & pwrite & penable & ~paddr0 & flmemtes ; // 16bits
  assign we_dflmch	= sel2[5]  & pwrite & penable & ~paddr0 & flmemtes ;
  assign we_flmcl	= sel2[6]  & pwrite & penable & ~paddr0 & flmemtes ; // 16 bits
  assign we_flmch	= sel2[7]  & pwrite & penable & ~paddr0 & flmemtes ; // 8 bits (l)
  assign we_fsctl	= sel2[7]  & pwrite & penable &  paddr0 & flmemtes ; // 8 bits (h)
  assign we_fsset	= sel2[11] & pwrite & penable & ~paddr0 & flmod;     // 8 bits (l)
  assign we_fsse	= sel2[11] & pwrite & penable &  paddr0 & fsseen;    // 8 bits (h)
  
 

endmodule

