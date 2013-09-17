/* ============================================================================================================	*/
/* K0R IECUBE ICE Macro												*/
/* Other Macro (for eva_top)                        								*/
/* �ȥåפǷҤ��ؤ���ɬ�פʿ��桢ü�ҽ�����make_chip�к��ʤ�							*/
/* Version control by Mercurial(hg command)									*/
/* ============================================================================================================	*/
module	evatop_other (
		      ADDRTD144, ADDRTD143, ADDRTD142, ADDRTD141, ADDRTD140, ADDRTD139, ADDRTD138, ADDRTD137, 
		      ADDRTD136, ADDRTD135, ADDRTD134, ADDRTD133, ADDRTD132, ADDRTD131, ADDRTD130, ADDRTD129, 
		      ADDRTD128, ADDRTD127, ADDRTD126, ADDRTD125, ADDRTD124, ADDRTD123, ADDRTD122, ADDRTD121, 
		      ADDRTD120, ADDRTD119, ADDRTD118, ADDRTD117, ADDRTD116, ADDRTD115, ADDRTD114, ADDRTD113, 
		      ADDRTD112, ADDRTD111, ADDRTD110, ADDRTD109, ADDRTD108, ADDRTD107, ADDRTD106, ADDRTD105, 
		      ADDRTD104, ADDRTD103, ADDRTD102, ADDRTD101, ADDRTD100, ADDRTD99, ADDRTD98, ADDRTD97, 
		      ADDRTD96, ADDRTD95, ADDRTD94, ADDRTD93, ADDRTD92, ADDRTD91, ADDRTD90, ADDRTD89, 
		      ADDRTD88, ADDRTD87, ADDRTD86, ADDRTD85, ADDRTD84, ADDRTD83, ADDRTD82, ADDRTD81, 
		      ADDRTD80, ADDRTD79, ADDRTD78, ADDRTD77, ADDRTD76, ADDRTD75, ADDRTD74, ADDRTD73, 
		      ADDRTD72, ADDRTD71, ADDRTD70, ADDRTD69, ADDRTD68, ADDRTD67, ADDRTD66, ADDRTD65, 
		      ADDRTD64, ADDRTD63, ADDRTD62, ADDRTD61, ADDRTD60, ADDRTD59, ADDRTD58, ADDRTD57, 
		      ADDRTD56, ADDRTD55, ADDRTD54, ADDRTD53, ADDRTD52, ADDRTD51, ADDRTD50, ADDRTD49, 
		      ADDRTD48, ADDRTD47, ADDRTD46, ADDRTD45, ADDRTD44, ADDRTD43, ADDRTD42, ADDRTD41, 
		      ADDRTD40, ADDRTD39, ADDRTD38, ADDRTD37, ADDRTD36, ADDRTD35, ADDRTD34, ADDRTD33, 
		      ADDRTD32, ADDRTD31, ADDRTD30, ADDRTD29, ADDRTD28, ADDRTD27, ADDRTD26, ADDRTD25, 
		      ADDRTD24, ADDRTD23, ADDRTD22, ADDRTD21, ADDRTD20, ADDRTD19, ADDRTD18, ADDRTD17, 
		      ADDRTD16, ADDRTD15, ADDRTD14, ADDRTD13, ADDRTD12, ADDRTD11, ADDRTD10, ADDRTD9, 
		      ADDRTD8, ADDRTD7, ADDRTD6, ADDRTD5, ADDRTD4, ADDRTD3, ADDRTD2, ADDRTD1, 
		      ADDRPINRD, ADDRPINMD, ADDRPINLV, ICEDI0, 
		      ICEWR,
		      PSEUDOON31, PSEUDOON30, PSEUDOON28, PSEUDOON27, PSEUDOON26, PSEUDOON25, PSEUDOON24, 
		      PSEUDOON23, PSEUDOON22, PSEUDOON21, PSEUDOON20, PSEUDOON19, PSEUDOON18, PSEUDOON17, PSEUDOON16, 
		      PSEUDOON15, PSEUDOON14, PSEUDOON13, PSEUDOON12, PSEUDOON11, PSEUDOON10, PSEUDOON9, PSEUDOON8,
                      PSEUDOANI19, PSEUDOANI18, PSEUDOANI17, PSEUDOANI16, PSEUDOANI15, PSEUDOANI14, PSEUDOANI13,
                      PSEUDOANI12, PSEUDOANI11, PSEUDOANI10, PSEUDOANI09, PSEUDOANI08, PSEUDOANI07, PSEUDOANI06,
                      PSEUDOANI05, PSEUDOANI04, PSEUDOANI03, PSEUDOANI02, PSEUDOANI01, PSEUDOANI00,
		      ICEMSKRETRY, ICEMSKTRAP, ICEMSKWAIT,
                      RDCLKP1_OUT, EXA_OUT, WWR_OUT, CER_OUT, SER_OUT, EXER_OUT,
                      MRG00_OUT, MRG01_OUT, MRG10_OUT, MRG11_OUT, MRG12_OUT,
                      DIS_OUT, READ_OUT, FCLK_OUT, PROGI_OUT, BFA_OUT,
		      IDVER31, IDVER30, IDVER29, IDVER28, IDVER27, IDVER26, IDVER25, IDVER24, 
		      IDVER23, IDVER22, IDVER21, IDVER20, IDVER19, IDVER18, IDVER17, IDVER16, 
		      IDVER15, IDVER14, IDVER13, IDVER12, IDVER11, IDVER10, IDVER9, IDVER8, 
		      IDVER7, IDVER6, IDVER5, IDVER4, IDVER3, IDVER2, IDVER1, IDVER0,
		      CPURCLK1, CPURCLK2,
		      SOFTBRK, OCDMOD, SBANDOCD,
		      CLK60MHZLOCK,
		      DCER_OUT, DDIS_OUT, DFCLK_OUT, DMRG00_OUT, DMRG01_OUT, DMRG10_OUT,
		      DMRG11_OUT, DMRG12_OUT, DRDCLKP1_OUT, DREAD_OUT, DSER_OUT, DWWR_OUT,
		      LVISEL,
		      SEL_TCCONNECT_B, FPGA_TCCONNECT_B,
		      DISEMVDD, DISEMEVDD,
                      ICEREG
		      );
   /* ----- �ƥ����ѳ�ĥ���� ----- */
   // make_chip�Υ�˥��к��Ѥ����ϤΤߡ�
   input	ADDRTD144, ADDRTD143, ADDRTD142, ADDRTD141, ADDRTD140, ADDRTD139, ADDRTD138, ADDRTD137, 
		ADDRTD136, ADDRTD135, ADDRTD134, ADDRTD133, ADDRTD132, ADDRTD131, ADDRTD130, ADDRTD129, 
		ADDRTD128, ADDRTD127, ADDRTD126, ADDRTD125, ADDRTD124, ADDRTD123, ADDRTD122, ADDRTD121, 
		ADDRTD120, ADDRTD119, ADDRTD118, ADDRTD117, ADDRTD116, ADDRTD115, ADDRTD114, ADDRTD113, 
		ADDRTD112, ADDRTD111, ADDRTD110, ADDRTD109, ADDRTD108, ADDRTD107, ADDRTD106, ADDRTD105, 
		ADDRTD104, ADDRTD103, ADDRTD102, ADDRTD101, ADDRTD100, ADDRTD99, ADDRTD98, ADDRTD97, 
		ADDRTD96, ADDRTD95, ADDRTD94, ADDRTD93, ADDRTD92, ADDRTD91, ADDRTD90, ADDRTD89, 
		ADDRTD88, ADDRTD87, ADDRTD86, ADDRTD85, ADDRTD84, ADDRTD83, ADDRTD82, ADDRTD81, 
		ADDRTD80, ADDRTD79, ADDRTD78, ADDRTD77, ADDRTD76, ADDRTD75, ADDRTD74, ADDRTD73, 
		ADDRTD72, ADDRTD71, ADDRTD70, ADDRTD69, ADDRTD68, ADDRTD67, ADDRTD66, ADDRTD65, 
		ADDRTD64, ADDRTD63, ADDRTD62, ADDRTD61, ADDRTD60, ADDRTD59, ADDRTD58, ADDRTD57, 
		ADDRTD56, ADDRTD55, ADDRTD54, ADDRTD53, ADDRTD52, ADDRTD51, ADDRTD50, ADDRTD49, 
		ADDRTD48, ADDRTD47, ADDRTD46, ADDRTD45, ADDRTD44, ADDRTD43, ADDRTD42, ADDRTD41, 
		ADDRTD40, ADDRTD39, ADDRTD38, ADDRTD37, ADDRTD36, ADDRTD35, ADDRTD34, ADDRTD33, 
		ADDRTD32, ADDRTD31, ADDRTD30, ADDRTD29, ADDRTD28, ADDRTD27, ADDRTD26, ADDRTD25, 
		ADDRTD24, ADDRTD23, ADDRTD22, ADDRTD21, ADDRTD20, ADDRTD19, ADDRTD18, ADDRTD17, 
		ADDRTD16, ADDRTD15, ADDRTD14, ADDRTD13, ADDRTD12, ADDRTD11, ADDRTD10, ADDRTD9, 
		ADDRTD8, ADDRTD7, ADDRTD6, ADDRTD5, ADDRTD4, ADDRTD3, ADDRTD2, ADDRTD1, 
		ADDRPINRD, ADDRPINMD, ADDRPINLV, ICEDI0, ICEWR;

   /* ----- �ƥ����ѳ�ĥ���� ----- */
   // make_chip�Υ�˥��к��Ѥ����ϤΤߡ�
   input	PSEUDOON31, PSEUDOON30, PSEUDOON28, PSEUDOON27, PSEUDOON26, PSEUDOON25, PSEUDOON24, 
		PSEUDOON23, PSEUDOON22, PSEUDOON21, PSEUDOON20, PSEUDOON19, PSEUDOON18, PSEUDOON17, PSEUDOON16, 
		PSEUDOON15, PSEUDOON14, PSEUDOON13, PSEUDOON12, PSEUDOON11, PSEUDOON10, PSEUDOON9, PSEUDOON8;
   input        PSEUDOANI19, PSEUDOANI18, PSEUDOANI17, PSEUDOANI16, PSEUDOANI15, PSEUDOANI14, PSEUDOANI13,
                PSEUDOANI12, PSEUDOANI11, PSEUDOANI10, PSEUDOANI09, PSEUDOANI08, PSEUDOANI07, PSEUDOANI06,
                PSEUDOANI05, PSEUDOANI04, PSEUDOANI03, PSEUDOANI02, PSEUDOANI01, PSEUDOANI00;

   /* ----- �ƥ����ѳ�ĥ���� ----- */
   // make_chip�Υ�˥��к��Ѥ����ϤΤߡ�
   input	ICEMSKRETRY, ICEMSKTRAP, ICEMSKWAIT;

   /* ----- For Firm Debug ----- */
   input        RDCLKP1_OUT, EXA_OUT, WWR_OUT, CER_OUT, SER_OUT, EXER_OUT,
                MRG00_OUT, MRG01_OUT, MRG10_OUT, MRG11_OUT, MRG12_OUT,
                DIS_OUT, READ_OUT, FCLK_OUT, PROGI_OUT, BFA_OUT;

   /* ----- ID Info., Ver Info. ----- */
   output	IDVER31, IDVER30, IDVER29, IDVER28, IDVER27, IDVER26, IDVER25, IDVER24, 
		IDVER23, IDVER22, IDVER21, IDVER20, IDVER19, IDVER18, IDVER17, IDVER16, 
		IDVER15, IDVER14, IDVER13, IDVER12, IDVER11, IDVER10, IDVER9, IDVER8, 
		IDVER7, IDVER6, IDVER5, IDVER4, IDVER3, IDVER2, IDVER1, IDVER0;

   /* ----- for Clock Block ----- */
   input	CPURCLK1, CPURCLK2;

   /* ----- for OCD ----- */
   input	SOFTBRK, OCDMOD;
   output	SBANDOCD;
   
   /*-------------------------*/
   input 	CLK60MHZLOCK;
   
   /* ----- for Dflash Debug Pin ----- */
   input	DCER_OUT, DDIS_OUT, DFCLK_OUT, DMRG00_OUT, DMRG01_OUT, DMRG10_OUT;
   input	DMRG11_OUT, DMRG12_OUT, DRDCLKP1_OUT, DREAD_OUT, DSER_OUT, DWWR_OUT;

   /* ----- for SG2 ----- */
   output	LVISEL;
   
   /* ----- for TCCONNECT ----- */
   input 	SEL_TCCONNECT_B;
   inout 	FPGA_TCCONNECT_B;
   
   /* ----- for EMVDD discharge ----- */
   output	DISEMVDD, DISEMEVDD ;

   /* ----- for Inspection ----- */
   output	ICEREG ;

   /* --------------------------------------------------------------------- */
   
   /* ----- for OCD ----- */
   assign	SBANDOCD = SOFTBRK & ~OCDMOD;

   /* ----- for SG2 ----- */
   assign	LVISEL = 1'b0 ;
   
   /* ----- for TCCONNECT ----- */
   assign	FPGA_TCCONNECT_B = (SEL_TCCONNECT_B) ? 1'bz : 1'b0 ;

   /* ----- for EMVDD discharge ----- */
   assign	DISEMVDD = (PSEUDOON31) ? 1'b0 : 1'bz ;
   assign	DISEMEVDD = (PSEUDOON31) ? 1'b0 : 1'bz ;

   /* ----- for Inspection ----- */
   assign	ICEREG = PSEUDOON30;

   /* ----- ID Info., Ver Info. ----- */
   assign 	{
		 IDVER31, IDVER30, IDVER29, IDVER28, IDVER27, IDVER26, IDVER25, IDVER24,
		 IDVER23, IDVER22, IDVER21, IDVER20, IDVER19, IDVER18, IDVER17, IDVER16,
		 IDVER15, IDVER14, IDVER13, IDVER12, IDVER11, IDVER10, IDVER9,  IDVER8,
		 IDVER7,  IDVER6,  IDVER5,  IDVER4,  IDVER3,  IDVER2,  IDVER1,  IDVER0
		 } = 32'h3100_0014;
   //                ^^^^^^^^^^^^^ : ID,Version
   
endmodule
