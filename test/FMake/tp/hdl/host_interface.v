
// $Id: host_interface.v,v 1.11 2010-01-28 02:09:30 snisimu Exp $

module HOST_INTERFACE (
	
	ICESYSRES_B, CLK60MHZ,
	USBCLK,
	USBA21, USBA20, USBA19,
	USBA4, USBA3, USBA2, USBA1,
	USBD15, USBD14, USBD13, USBD12,
	USBD11, USBD10, USBD9, USBD8,
	USBD7, USBD6, USBD5, USBD4,
	USBD3, USBD2, USBD1, USBD0,
	USBRD_B, USBWR0_B, USBWAIT_B,
	EROMWAIT,
	
	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28,
	ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
	ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20,
	ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
	ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12,
	ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
	ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4,
	ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0,
	
	ICEDOA31, ICEDOA30, ICEDOA29, ICEDOA28,
	ICEDOA27, ICEDOA26, ICEDOA25, ICEDOA24,
	ICEDOA23, ICEDOA22, ICEDOA21, ICEDOA20,
	ICEDOA19, ICEDOA18, ICEDOA17, ICEDOA16,
	ICEDOA15, ICEDOA14, ICEDOA13, ICEDOA12,
	ICEDOA11, ICEDOA10, ICEDOA9, ICEDOA8,
	ICEDOA7, ICEDOA6, ICEDOA5, ICEDOA4,
	ICEDOA3, ICEDOA2, ICEDOA1, ICEDOA0,
	
	ICEDOB31, ICEDOB30, ICEDOB29, ICEDOB28,
	ICEDOB27, ICEDOB26, ICEDOB25, ICEDOB24,
	ICEDOB23, ICEDOB22, ICEDOB21, ICEDOB20,
	ICEDOB19, ICEDOB18, ICEDOB17, ICEDOB16,
	ICEDOB15, ICEDOB14, ICEDOB13, ICEDOB12,
	ICEDOB11, ICEDOB10, ICEDOB9, ICEDOB8,
	ICEDOB7, ICEDOB6, ICEDOB5, ICEDOB4,
	ICEDOB3, ICEDOB2, ICEDOB1, ICEDOB0,
	
	ICEDOC31, ICEDOC30, ICEDOC29, ICEDOC28,
	ICEDOC27, ICEDOC26, ICEDOC25, ICEDOC24,
	ICEDOC23, ICEDOC22, ICEDOC21, ICEDOC20,
	ICEDOC19, ICEDOC18, ICEDOC17, ICEDOC16,
	ICEDOC15, ICEDOC14, ICEDOC13, ICEDOC12,
	ICEDOC11, ICEDOC10, ICEDOC9, ICEDOC8,
	ICEDOC7, ICEDOC6, ICEDOC5, ICEDOC4,
	ICEDOC3, ICEDOC2, ICEDOC1, ICEDOC0,
	
	ICEDOD31, ICEDOD30, ICEDOD29, ICEDOD28,
	ICEDOD27, ICEDOD26, ICEDOD25, ICEDOD24,
	ICEDOD23, ICEDOD22, ICEDOD21, ICEDOD20,
	ICEDOD19, ICEDOD18, ICEDOD17, ICEDOD16,
	ICEDOD15, ICEDOD14, ICEDOD13, ICEDOD12,
	ICEDOD11, ICEDOD10, ICEDOD9, ICEDOD8,
	ICEDOD7, ICEDOD6, ICEDOD5, ICEDOD4,
	ICEDOD3, ICEDOD2, ICEDOD1, ICEDOD0,
	
	ICEDOE31, ICEDOE30, ICEDOE29, ICEDOE28,
	ICEDOE27, ICEDOE26, ICEDOE25, ICEDOE24,
	ICEDOE23, ICEDOE22, ICEDOE21, ICEDOE20,
	ICEDOE19, ICEDOE18, ICEDOE17, ICEDOE16,
	ICEDOE15, ICEDOE14, ICEDOE13, ICEDOE12,
	ICEDOE11, ICEDOE10, ICEDOE9, ICEDOE8,
	ICEDOE7, ICEDOE6, ICEDOE5, ICEDOE4,
	ICEDOE3, ICEDOE2, ICEDOE1, ICEDOE0,
	
	ICEDOF31, ICEDOF30, ICEDOF29, ICEDOF28,
	ICEDOF27, ICEDOF26, ICEDOF25, ICEDOF24,
	ICEDOF23, ICEDOF22, ICEDOF21, ICEDOF20,
	ICEDOF19, ICEDOF18, ICEDOF17, ICEDOF16,
	ICEDOF15, ICEDOF14, ICEDOF13, ICEDOF12,
	ICEDOF11, ICEDOF10, ICEDOF9, ICEDOF8,
	ICEDOF7, ICEDOF6, ICEDOF5, ICEDOF4,
	ICEDOF3, ICEDOF2, ICEDOF1, ICEDOF0,
	
	ICEDOG31, ICEDOG30, ICEDOG29, ICEDOG28,
	ICEDOG27, ICEDOG26, ICEDOG25, ICEDOG24,
	ICEDOG23, ICEDOG22, ICEDOG21, ICEDOG20,
	ICEDOG19, ICEDOG18, ICEDOG17, ICEDOG16,
	ICEDOG15, ICEDOG14, ICEDOG13, ICEDOG12,
	ICEDOG11, ICEDOG10, ICEDOG9, ICEDOG8,
	ICEDOG7, ICEDOG6, ICEDOG5, ICEDOG4,
	ICEDOG3, ICEDOG2, ICEDOG1, ICEDOG0,
	
	ICEDOH31, ICEDOH30, ICEDOH29, ICEDOH28,
	ICEDOH27, ICEDOH26, ICEDOH25, ICEDOH24,
	ICEDOH23, ICEDOH22, ICEDOH21, ICEDOH20,
	ICEDOH19, ICEDOH18, ICEDOH17, ICEDOH16,
	ICEDOH15, ICEDOH14, ICEDOH13, ICEDOH12,
	ICEDOH11, ICEDOH10, ICEDOH9, ICEDOH8,
	ICEDOH7, ICEDOH6, ICEDOH5, ICEDOH4,
	ICEDOH3, ICEDOH2, ICEDOH1, ICEDOH0,
	
	ICEDOJ31, ICEDOJ30, ICEDOJ29, ICEDOJ28,
	ICEDOJ27, ICEDOJ26, ICEDOJ25, ICEDOJ24,
	ICEDOJ23, ICEDOJ22, ICEDOJ21, ICEDOJ20,
	ICEDOJ19, ICEDOJ18, ICEDOJ17, ICEDOJ16,
	ICEDOJ15, ICEDOJ14, ICEDOJ13, ICEDOJ12,
	ICEDOJ11, ICEDOJ10, ICEDOJ9, ICEDOJ8,
	ICEDOJ7, ICEDOJ6, ICEDOJ5, ICEDOJ4,
	ICEDOJ3, ICEDOJ2, ICEDOJ1, ICEDOJ0,
	
	ICEDOK31, ICEDOK30, ICEDOK29, ICEDOK28,
	ICEDOK27, ICEDOK26, ICEDOK25, ICEDOK24,
	ICEDOK23, ICEDOK22, ICEDOK21, ICEDOK20,
	ICEDOK19, ICEDOK18, ICEDOK17, ICEDOK16,
	ICEDOK15, ICEDOK14, ICEDOK13, ICEDOK12,
	ICEDOK11, ICEDOK10, ICEDOK9, ICEDOK8,
	ICEDOK7, ICEDOK6, ICEDOK5, ICEDOK4,
	ICEDOK3, ICEDOK2, ICEDOK1, ICEDOK0,
	
	ICEDOL31, ICEDOL30, ICEDOL29, ICEDOL28,
	ICEDOL27, ICEDOL26, ICEDOL25, ICEDOL24,
	ICEDOL23, ICEDOL22, ICEDOL21, ICEDOL20,
	ICEDOL19, ICEDOL18, ICEDOL17, ICEDOL16,
	ICEDOL15, ICEDOL14, ICEDOL13, ICEDOL12,
	ICEDOL11, ICEDOL10, ICEDOL9, ICEDOL8,
	ICEDOL7, ICEDOL6, ICEDOL5, ICEDOL4,
	ICEDOL3, ICEDOL2, ICEDOL1, ICEDOL0,
	
	ICEDOM31, ICEDOM30, ICEDOM29, ICEDOM28,
	ICEDOM27, ICEDOM26, ICEDOM25, ICEDOM24,
	ICEDOM23, ICEDOM22, ICEDOM21, ICEDOM20,
	ICEDOM19, ICEDOM18, ICEDOM17, ICEDOM16,
	ICEDOM15, ICEDOM14, ICEDOM13, ICEDOM12,
	ICEDOM11, ICEDOM10, ICEDOM9, ICEDOM8,
	ICEDOM7, ICEDOM6, ICEDOM5, ICEDOM4,
	ICEDOM3, ICEDOM2, ICEDOM1, ICEDOM0,
	
	ICEDON31, ICEDON30, ICEDON29, ICEDON28,
	ICEDON27, ICEDON26, ICEDON25, ICEDON24,
	ICEDON23, ICEDON22, ICEDON21, ICEDON20,
	ICEDON19, ICEDON18, ICEDON17, ICEDON16,
	ICEDON15, ICEDON14, ICEDON13, ICEDON12,
	ICEDON11, ICEDON10, ICEDON9, ICEDON8,
	ICEDON7, ICEDON6, ICEDON5, ICEDON4,
	ICEDON3, ICEDON2, ICEDON1, ICEDON0,
	
	ICEDOP31, ICEDOP30, ICEDOP29, ICEDOP28,
	ICEDOP27, ICEDOP26, ICEDOP25, ICEDOP24,
	ICEDOP23, ICEDOP22, ICEDOP21, ICEDOP20,
	ICEDOP19, ICEDOP18, ICEDOP17, ICEDOP16,
	ICEDOP15, ICEDOP14, ICEDOP13, ICEDOP12,
	ICEDOP11, ICEDOP10, ICEDOP9, ICEDOP8,
	ICEDOP7, ICEDOP6, ICEDOP5, ICEDOP4,
	ICEDOP3, ICEDOP2, ICEDOP1, ICEDOP0,
	
	ICEDOQ31, ICEDOQ30, ICEDOQ29, ICEDOQ28,
	ICEDOQ27, ICEDOQ26, ICEDOQ25, ICEDOQ24,
	ICEDOQ23, ICEDOQ22, ICEDOQ21, ICEDOQ20,
	ICEDOQ19, ICEDOQ18, ICEDOQ17, ICEDOQ16,
	ICEDOQ15, ICEDOQ14, ICEDOQ13, ICEDOQ12,
	ICEDOQ11, ICEDOQ10, ICEDOQ9, ICEDOQ8,
	ICEDOQ7, ICEDOQ6, ICEDOQ5, ICEDOQ4,
	ICEDOQ3, ICEDOQ2, ICEDOQ1, ICEDOQ0,
	
	ICEDOR31, ICEDOR30, ICEDOR29, ICEDOR28,
	ICEDOR27, ICEDOR26, ICEDOR25, ICEDOR24,
	ICEDOR23, ICEDOR22, ICEDOR21, ICEDOR20,
	ICEDOR19, ICEDOR18, ICEDOR17, ICEDOR16,
	ICEDOR15, ICEDOR14, ICEDOR13, ICEDOR12,
	ICEDOR11, ICEDOR10, ICEDOR9, ICEDOR8,
	ICEDOR7, ICEDOR6, ICEDOR5, ICEDOR4,
	ICEDOR3, ICEDOR2, ICEDOR1, ICEDOR0,
	
	ICEDOS31, ICEDOS30, ICEDOS29, ICEDOS28,
	ICEDOS27, ICEDOS26, ICEDOS25, ICEDOS24,
	ICEDOS23, ICEDOS22, ICEDOS21, ICEDOS20,
	ICEDOS19, ICEDOS18, ICEDOS17, ICEDOS16,
	ICEDOS15, ICEDOS14, ICEDOS13, ICEDOS12,
	ICEDOS11, ICEDOS10, ICEDOS9, ICEDOS8,
	ICEDOS7, ICEDOS6, ICEDOS5, ICEDOS4,
	ICEDOS3, ICEDOS2, ICEDOS1, ICEDOS0,
	
	ICEDOT31, ICEDOT30, ICEDOT29, ICEDOT28,
	ICEDOT27, ICEDOT26, ICEDOT25, ICEDOT24,
	ICEDOT23, ICEDOT22, ICEDOT21, ICEDOT20,
	ICEDOT19, ICEDOT18, ICEDOT17, ICEDOT16,
	ICEDOT15, ICEDOT14, ICEDOT13, ICEDOT12,
	ICEDOT11, ICEDOT10, ICEDOT9, ICEDOT8,
	ICEDOT7, ICEDOT6, ICEDOT5, ICEDOT4,
	ICEDOT3, ICEDOT2, ICEDOT1, ICEDOT0,
	
	ICEDOU31, ICEDOU30, ICEDOU29, ICEDOU28,
	ICEDOU27, ICEDOU26, ICEDOU25, ICEDOU24,
	ICEDOU23, ICEDOU22, ICEDOU21, ICEDOU20,
	ICEDOU19, ICEDOU18, ICEDOU17, ICEDOU16,
	ICEDOU15, ICEDOU14, ICEDOU13, ICEDOU12,
	ICEDOU11, ICEDOU10, ICEDOU9, ICEDOU8,
	ICEDOU7, ICEDOU6, ICEDOU5, ICEDOU4,
	ICEDOU3, ICEDOU2, ICEDOU1, ICEDOU0,
	
	ICEDI31, ICEDI30, ICEDI29, ICEDI28,
	ICEDI27, ICEDI26, ICEDI25, ICEDI24,
	ICEDI23, ICEDI22, ICEDI21, ICEDI20,
	ICEDI19, ICEDI18, ICEDI17, ICEDI16,
	ICEDI15, ICEDI14, ICEDI13, ICEDI12,
	ICEDI11, ICEDI10, ICEDI9, ICEDI8,
	ICEDI7, ICEDI6, ICEDI5, ICEDI4,
	ICEDI3, ICEDI2, ICEDI1, ICEDI0,
	
	ICERD, ICEWR,
	
	ICEIFA_PRE31, ICEIFA_PRE30, ICEIFA_PRE29, ICEIFA_PRE28,
	ICEIFA_PRE27, ICEIFA_PRE26, ICEIFA_PRE25, ICEIFA_PRE24,
	ICEIFA_PRE23, ICEIFA_PRE22, ICEIFA_PRE21, ICEIFA_PRE20,
	ICEIFA_PRE19, ICEIFA_PRE18, ICEIFA_PRE17, ICEIFA_PRE16,
	ICEIFA_PRE15, ICEIFA_PRE14, ICEIFA_PRE13, ICEIFA_PRE12,
	ICEIFA_PRE11, ICEIFA_PRE10, ICEIFA_PRE9, ICEIFA_PRE8,
	ICEIFA_PRE7, ICEIFA_PRE6, ICEIFA_PRE5, ICEIFA_PRE4,
	ICEIFA_PRE3, ICEIFA_PRE2, ICEIFA_PRE1, ICEIFA_PRE0,
	
	ICEDI_PRE31, ICEDI_PRE30, ICEDI_PRE29, ICEDI_PRE28,
	ICEDI_PRE27, ICEDI_PRE26, ICEDI_PRE25, ICEDI_PRE24,
	ICEDI_PRE23, ICEDI_PRE22, ICEDI_PRE21, ICEDI_PRE20,
	ICEDI_PRE19, ICEDI_PRE18, ICEDI_PRE17, ICEDI_PRE16,
	ICEDI_PRE15, ICEDI_PRE14, ICEDI_PRE13, ICEDI_PRE12,
	ICEDI_PRE11, ICEDI_PRE10, ICEDI_PRE9, ICEDI_PRE8,
	ICEDI_PRE7, ICEDI_PRE6, ICEDI_PRE5, ICEDI_PRE4,
	ICEDI_PRE3, ICEDI_PRE2, ICEDI_PRE1, ICEDI_PRE0,
	
	ICERD_PRE, ICEWR_PRE,
	
	CPURESETB, BASECK,
	SVMOD, ALT1,
	SLMEM,
	ES3, ES2, ES1, ES0,
	MA15, MA14, MA13, MA12,
	MA11, MA10, MA9, MA8,
	MA7, MA6, MA5, MA4,
	MA3, MA2, MA1, MA0,
	MDW15, MDW14, MDW13, MDW12,
	MDW11, MDW10, MDW9, MDW8,
	MDW7, MDW6, MDW5, MDW4,
	MDW3, MDW2, MDW1, MDW0,
	MDR15, MDR14, MDR13, MDR12,
	MDR11, MDR10, MDR9, MDR8,
	MDR7, MDR6, MDR5, MDR4,
	MDR3, MDR2, MDR1, MDR0,
	CPUWR, CPURD, WDOP,
	
	VDDLEV7, VDDLEV6, VDDLEV5, VDDLEV4,
	VDDLEV3, VDDLEV2, VDDLEV1, VDDLEV0,
	USBIFWR,
	
	ICECSGREGU,
	
	PC19, PC18, PC17, PC16,
	PC15, PC14, PC13, PC12,
	PC11, PC10, PC9, PC8,
	PC7, PC6, PC5, PC4,
	PC3, PC2, PC1, PC0
	
);
	
	input	ICESYSRES_B;
	input	CLK60MHZ;
	
	input	USBCLK;
	input	USBA21, USBA20, USBA19, USBA4, USBA3, USBA2, USBA1;
	inout	USBD15, USBD14, USBD13, USBD12, USBD11, USBD10, USBD9, USBD8,
			USBD7, USBD6, USBD5, USBD4, USBD3, USBD2, USBD1, USBD0;
	input	USBRD_B, USBWR0_B;
	output	USBWAIT_B;
	input	EROMWAIT;
	
	output	ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
			ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0;
	
	input	ICEDOA31, ICEDOA30, ICEDOA29, ICEDOA28, ICEDOA27, ICEDOA26, ICEDOA25, ICEDOA24,
			ICEDOA23, ICEDOA22, ICEDOA21, ICEDOA20, ICEDOA19, ICEDOA18, ICEDOA17, ICEDOA16,
			ICEDOA15, ICEDOA14, ICEDOA13, ICEDOA12, ICEDOA11, ICEDOA10, ICEDOA9, ICEDOA8,
			ICEDOA7, ICEDOA6, ICEDOA5, ICEDOA4, ICEDOA3, ICEDOA2, ICEDOA1, ICEDOA0,
			ICEDOB31, ICEDOB30, ICEDOB29, ICEDOB28, ICEDOB27, ICEDOB26, ICEDOB25, ICEDOB24,
			ICEDOB23, ICEDOB22, ICEDOB21, ICEDOB20, ICEDOB19, ICEDOB18, ICEDOB17, ICEDOB16,
			ICEDOB15, ICEDOB14, ICEDOB13, ICEDOB12, ICEDOB11, ICEDOB10, ICEDOB9, ICEDOB8,
			ICEDOB7, ICEDOB6, ICEDOB5, ICEDOB4, ICEDOB3, ICEDOB2, ICEDOB1, ICEDOB0,
			ICEDOC31, ICEDOC30, ICEDOC29, ICEDOC28, ICEDOC27, ICEDOC26, ICEDOC25, ICEDOC24,
			ICEDOC23, ICEDOC22, ICEDOC21, ICEDOC20, ICEDOC19, ICEDOC18, ICEDOC17, ICEDOC16,
			ICEDOC15, ICEDOC14, ICEDOC13, ICEDOC12, ICEDOC11, ICEDOC10, ICEDOC9, ICEDOC8,
			ICEDOC7, ICEDOC6, ICEDOC5, ICEDOC4, ICEDOC3, ICEDOC2, ICEDOC1, ICEDOC0,
			ICEDOD31, ICEDOD30, ICEDOD29, ICEDOD28, ICEDOD27, ICEDOD26, ICEDOD25, ICEDOD24,
			ICEDOD23, ICEDOD22, ICEDOD21, ICEDOD20, ICEDOD19, ICEDOD18, ICEDOD17, ICEDOD16,
			ICEDOD15, ICEDOD14, ICEDOD13, ICEDOD12, ICEDOD11, ICEDOD10, ICEDOD9, ICEDOD8,
			ICEDOD7, ICEDOD6, ICEDOD5, ICEDOD4, ICEDOD3, ICEDOD2, ICEDOD1, ICEDOD0,
			ICEDOE31, ICEDOE30, ICEDOE29, ICEDOE28, ICEDOE27, ICEDOE26, ICEDOE25, ICEDOE24,
			ICEDOE23, ICEDOE22, ICEDOE21, ICEDOE20, ICEDOE19, ICEDOE18, ICEDOE17, ICEDOE16,
			ICEDOE15, ICEDOE14, ICEDOE13, ICEDOE12, ICEDOE11, ICEDOE10, ICEDOE9, ICEDOE8,
			ICEDOE7, ICEDOE6, ICEDOE5, ICEDOE4, ICEDOE3, ICEDOE2, ICEDOE1, ICEDOE0,
			ICEDOF31, ICEDOF30, ICEDOF29, ICEDOF28, ICEDOF27, ICEDOF26, ICEDOF25, ICEDOF24,
			ICEDOF23, ICEDOF22, ICEDOF21, ICEDOF20, ICEDOF19, ICEDOF18, ICEDOF17, ICEDOF16,
			ICEDOF15, ICEDOF14, ICEDOF13, ICEDOF12, ICEDOF11, ICEDOF10, ICEDOF9, ICEDOF8,
			ICEDOF7, ICEDOF6, ICEDOF5, ICEDOF4, ICEDOF3, ICEDOF2, ICEDOF1, ICEDOF0,
			ICEDOG31, ICEDOG30, ICEDOG29, ICEDOG28, ICEDOG27, ICEDOG26, ICEDOG25, ICEDOG24,
			ICEDOG23, ICEDOG22, ICEDOG21, ICEDOG20, ICEDOG19, ICEDOG18, ICEDOG17, ICEDOG16,
			ICEDOG15, ICEDOG14, ICEDOG13, ICEDOG12, ICEDOG11, ICEDOG10, ICEDOG9, ICEDOG8,
			ICEDOG7, ICEDOG6, ICEDOG5, ICEDOG4, ICEDOG3, ICEDOG2, ICEDOG1, ICEDOG0,
			ICEDOH31, ICEDOH30, ICEDOH29, ICEDOH28, ICEDOH27, ICEDOH26, ICEDOH25, ICEDOH24,
			ICEDOH23, ICEDOH22, ICEDOH21, ICEDOH20, ICEDOH19, ICEDOH18, ICEDOH17, ICEDOH16,
			ICEDOH15, ICEDOH14, ICEDOH13, ICEDOH12, ICEDOH11, ICEDOH10, ICEDOH9, ICEDOH8,
			ICEDOH7, ICEDOH6, ICEDOH5, ICEDOH4, ICEDOH3, ICEDOH2, ICEDOH1, ICEDOH0,
			ICEDOJ31, ICEDOJ30, ICEDOJ29, ICEDOJ28, ICEDOJ27, ICEDOJ26, ICEDOJ25, ICEDOJ24,
			ICEDOJ23, ICEDOJ22, ICEDOJ21, ICEDOJ20, ICEDOJ19, ICEDOJ18, ICEDOJ17, ICEDOJ16,
			ICEDOJ15, ICEDOJ14, ICEDOJ13, ICEDOJ12, ICEDOJ11, ICEDOJ10, ICEDOJ9, ICEDOJ8,
			ICEDOJ7, ICEDOJ6, ICEDOJ5, ICEDOJ4, ICEDOJ3, ICEDOJ2, ICEDOJ1, ICEDOJ0,
			ICEDOK31, ICEDOK30, ICEDOK29, ICEDOK28, ICEDOK27, ICEDOK26, ICEDOK25, ICEDOK24,
			ICEDOK23, ICEDOK22, ICEDOK21, ICEDOK20, ICEDOK19, ICEDOK18, ICEDOK17, ICEDOK16,
			ICEDOK15, ICEDOK14, ICEDOK13, ICEDOK12, ICEDOK11, ICEDOK10, ICEDOK9, ICEDOK8,
			ICEDOK7, ICEDOK6, ICEDOK5, ICEDOK4, ICEDOK3, ICEDOK2, ICEDOK1, ICEDOK0,
			ICEDOL31, ICEDOL30, ICEDOL29, ICEDOL28, ICEDOL27, ICEDOL26, ICEDOL25, ICEDOL24,
			ICEDOL23, ICEDOL22, ICEDOL21, ICEDOL20, ICEDOL19, ICEDOL18, ICEDOL17, ICEDOL16,
			ICEDOL15, ICEDOL14, ICEDOL13, ICEDOL12, ICEDOL11, ICEDOL10, ICEDOL9, ICEDOL8,
			ICEDOL7, ICEDOL6, ICEDOL5, ICEDOL4, ICEDOL3, ICEDOL2, ICEDOL1, ICEDOL0,
			ICEDOM31, ICEDOM30, ICEDOM29, ICEDOM28, ICEDOM27, ICEDOM26, ICEDOM25, ICEDOM24,
			ICEDOM23, ICEDOM22, ICEDOM21, ICEDOM20, ICEDOM19, ICEDOM18, ICEDOM17, ICEDOM16,
			ICEDOM15, ICEDOM14, ICEDOM13, ICEDOM12, ICEDOM11, ICEDOM10, ICEDOM9, ICEDOM8,
			ICEDOM7, ICEDOM6, ICEDOM5, ICEDOM4, ICEDOM3, ICEDOM2, ICEDOM1, ICEDOM0,
			ICEDON31, ICEDON30, ICEDON29, ICEDON28, ICEDON27, ICEDON26, ICEDON25, ICEDON24,
			ICEDON23, ICEDON22, ICEDON21, ICEDON20, ICEDON19, ICEDON18, ICEDON17, ICEDON16,
			ICEDON15, ICEDON14, ICEDON13, ICEDON12, ICEDON11, ICEDON10, ICEDON9, ICEDON8,
			ICEDON7, ICEDON6, ICEDON5, ICEDON4, ICEDON3, ICEDON2, ICEDON1, ICEDON0,
			ICEDOP31, ICEDOP30, ICEDOP29, ICEDOP28, ICEDOP27, ICEDOP26, ICEDOP25, ICEDOP24,
			ICEDOP23, ICEDOP22, ICEDOP21, ICEDOP20, ICEDOP19, ICEDOP18, ICEDOP17, ICEDOP16,
			ICEDOP15, ICEDOP14, ICEDOP13, ICEDOP12, ICEDOP11, ICEDOP10, ICEDOP9, ICEDOP8,
			ICEDOP7, ICEDOP6, ICEDOP5, ICEDOP4, ICEDOP3, ICEDOP2, ICEDOP1, ICEDOP0,
			ICEDOQ31, ICEDOQ30, ICEDOQ29, ICEDOQ28, ICEDOQ27, ICEDOQ26, ICEDOQ25, ICEDOQ24,
			ICEDOQ23, ICEDOQ22, ICEDOQ21, ICEDOQ20, ICEDOQ19, ICEDOQ18, ICEDOQ17, ICEDOQ16,
			ICEDOQ15, ICEDOQ14, ICEDOQ13, ICEDOQ12, ICEDOQ11, ICEDOQ10, ICEDOQ9, ICEDOQ8,
			ICEDOQ7, ICEDOQ6, ICEDOQ5, ICEDOQ4, ICEDOQ3, ICEDOQ2, ICEDOQ1, ICEDOQ0,
			ICEDOR31, ICEDOR30, ICEDOR29, ICEDOR28, ICEDOR27, ICEDOR26, ICEDOR25, ICEDOR24,
			ICEDOR23, ICEDOR22, ICEDOR21, ICEDOR20, ICEDOR19, ICEDOR18, ICEDOR17, ICEDOR16,
			ICEDOR15, ICEDOR14, ICEDOR13, ICEDOR12, ICEDOR11, ICEDOR10, ICEDOR9, ICEDOR8,
			ICEDOR7, ICEDOR6, ICEDOR5, ICEDOR4, ICEDOR3, ICEDOR2, ICEDOR1, ICEDOR0,
			ICEDOS31, ICEDOS30, ICEDOS29, ICEDOS28, ICEDOS27, ICEDOS26, ICEDOS25, ICEDOS24,
			ICEDOS23, ICEDOS22, ICEDOS21, ICEDOS20, ICEDOS19, ICEDOS18, ICEDOS17, ICEDOS16,
			ICEDOS15, ICEDOS14, ICEDOS13, ICEDOS12, ICEDOS11, ICEDOS10, ICEDOS9, ICEDOS8,
			ICEDOS7, ICEDOS6, ICEDOS5, ICEDOS4, ICEDOS3, ICEDOS2, ICEDOS1, ICEDOS0,
			ICEDOT31, ICEDOT30, ICEDOT29, ICEDOT28, ICEDOT27, ICEDOT26, ICEDOT25, ICEDOT24,
			ICEDOT23, ICEDOT22, ICEDOT21, ICEDOT20, ICEDOT19, ICEDOT18, ICEDOT17, ICEDOT16,
			ICEDOT15, ICEDOT14, ICEDOT13, ICEDOT12, ICEDOT11, ICEDOT10, ICEDOT9, ICEDOT8,
			ICEDOT7, ICEDOT6, ICEDOT5, ICEDOT4, ICEDOT3, ICEDOT2, ICEDOT1, ICEDOT0,
			ICEDOU31, ICEDOU30, ICEDOU29, ICEDOU28, ICEDOU27, ICEDOU26, ICEDOU25, ICEDOU24,
			ICEDOU23, ICEDOU22, ICEDOU21, ICEDOU20, ICEDOU19, ICEDOU18, ICEDOU17, ICEDOU16,
			ICEDOU15, ICEDOU14, ICEDOU13, ICEDOU12, ICEDOU11, ICEDOU10, ICEDOU9, ICEDOU8,
			ICEDOU7, ICEDOU6, ICEDOU5, ICEDOU4, ICEDOU3, ICEDOU2, ICEDOU1, ICEDOU0;
	
	output	ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24, // HOST data write  bus
			ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
			ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
			ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0;
	
	output	ICERD, ICEWR;
	
			// $B"-(BCPU$B$,=i4|2=$5$l$F$$$J$/$F$b%[%9%H$+$i%i%$%H$G$-$k%P%9(B($B2#<h$jA0$N%P%9(B)
	output	ICEIFA_PRE31, ICEIFA_PRE30, ICEIFA_PRE29, ICEIFA_PRE28, ICEIFA_PRE27, ICEIFA_PRE26, ICEIFA_PRE25, ICEIFA_PRE24,
			ICEIFA_PRE23, ICEIFA_PRE22, ICEIFA_PRE21, ICEIFA_PRE20, ICEIFA_PRE19, ICEIFA_PRE18, ICEIFA_PRE17, ICEIFA_PRE16,
			ICEIFA_PRE15, ICEIFA_PRE14, ICEIFA_PRE13, ICEIFA_PRE12, ICEIFA_PRE11, ICEIFA_PRE10, ICEIFA_PRE9, ICEIFA_PRE8,
			ICEIFA_PRE7, ICEIFA_PRE6, ICEIFA_PRE5, ICEIFA_PRE4, ICEIFA_PRE3, ICEIFA_PRE2, ICEIFA_PRE1, ICEIFA_PRE0;
	output	ICEDI_PRE31, ICEDI_PRE30, ICEDI_PRE29, ICEDI_PRE28, ICEDI_PRE27, ICEDI_PRE26, ICEDI_PRE25, ICEDI_PRE24,
			ICEDI_PRE23, ICEDI_PRE22, ICEDI_PRE21, ICEDI_PRE20, ICEDI_PRE19, ICEDI_PRE18, ICEDI_PRE17, ICEDI_PRE16,
			ICEDI_PRE15, ICEDI_PRE14, ICEDI_PRE13, ICEDI_PRE12, ICEDI_PRE11, ICEDI_PRE10, ICEDI_PRE9, ICEDI_PRE8,
			ICEDI_PRE7, ICEDI_PRE6, ICEDI_PRE5, ICEDI_PRE4, ICEDI_PRE3, ICEDI_PRE2, ICEDI_PRE1, ICEDI_PRE0;
	
	output	ICERD_PRE, ICEWR_PRE;
	
	input	CPURESETB; // CPU and peripheral reset (except RESF)
	input	BASECK; // CPU base clock
	input	SVMOD, ALT1;
	input	SLMEM;
	input	ES3, ES2, ES1, ES0;
	input	MA15, MA14, MA13, MA12;
	input	MA11, MA10, MA9, MA8;
	input	MA7, MA6, MA5, MA4;
	input	MA3, MA2, MA1, MA0;
	input	MDW15, MDW14, MDW13, MDW12;
	input	MDW11, MDW10, MDW9, MDW8;
	input	MDW7, MDW6, MDW5, MDW4;
	input	MDW3, MDW2, MDW1, MDW0;
	output	MDR15, MDR14, MDR13, MDR12;
	output	MDR11, MDR10, MDR9, MDR8;
	output	MDR7, MDR6, MDR5, MDR4;
	output	MDR3, MDR2, MDR1, MDR0;
	input	CPUWR, CPURD, WDOP;
	
	output	VDDLEV7, VDDLEV6, VDDLEV5, VDDLEV4;
	output	VDDLEV3, VDDLEV2, VDDLEV1, VDDLEV0;
	output	USBIFWR;
	
	output	ICECSGREGU;
	
	input	PC19, PC18, PC17, PC16;
	input	PC15, PC14, PC13, PC12, PC11, PC10, PC9, PC8;
	input	PC7, PC6, PC5, PC4, PC3, PC2, PC1, PC0;
	
	wire	[21:0]	USBA;
	wire	[31:0]	ICEIFA, ICEDI, ICEDO;
	wire	[31:0]	ICEIFA_PRE, ICEDI_PRE;
	wire	[3:0]	ES;
	wire	[15:0]	MA, MDW, MDR;
	reg		[7:0]	VDDLEV;
	wire	[19:0]	PC;
	
	wire	[2:0]	usbifa;
	wire	[31:0]	usbifdi, usbifdo;
	wire	usbifrd, usbifwr;
	wire 	[31:0]	icedoa, icedob, icedoc, icedod, icedoe, icedof, icedog, icedoh, icedoj;
	wire 	[31:0]	icedok, icedol, icedom, icedon, icedop, icedoq, icedor, icedos, icedot, icedou;
	wire 	[31:0]	icedopc;
	
	// Buses
	
		assign USBA = {
				USBA21, USBA20, USBA19, 1'b0, 1'b0, 1'b0,
				1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,
				1'b0, 1'b0, 1'b0, USBA4, USBA3, USBA2, USBA1, 1'b0
		};
		assign {
			ICEIFA31, ICEIFA30, ICEIFA29, ICEIFA28, ICEIFA27, ICEIFA26, ICEIFA25, ICEIFA24,
			ICEIFA23, ICEIFA22, ICEIFA21, ICEIFA20, ICEIFA19, ICEIFA18, ICEIFA17, ICEIFA16,
			ICEIFA15, ICEIFA14, ICEIFA13, ICEIFA12, ICEIFA11, ICEIFA10, ICEIFA9, ICEIFA8,
			ICEIFA7, ICEIFA6, ICEIFA5, ICEIFA4, ICEIFA3, ICEIFA2, ICEIFA1, ICEIFA0
		} = ICEIFA;
		assign {
			ICEDI31, ICEDI30, ICEDI29, ICEDI28, ICEDI27, ICEDI26, ICEDI25, ICEDI24,
			ICEDI23, ICEDI22, ICEDI21, ICEDI20, ICEDI19, ICEDI18, ICEDI17, ICEDI16,
			ICEDI15, ICEDI14, ICEDI13, ICEDI12, ICEDI11, ICEDI10, ICEDI9, ICEDI8,
			ICEDI7, ICEDI6, ICEDI5, ICEDI4, ICEDI3, ICEDI2, ICEDI1, ICEDI0
		} = ICEDI;
		assign 	{
			ICEIFA_PRE31, ICEIFA_PRE30, ICEIFA_PRE29, ICEIFA_PRE28,
			ICEIFA_PRE27, ICEIFA_PRE26, ICEIFA_PRE25, ICEIFA_PRE24,
			ICEIFA_PRE23, ICEIFA_PRE22, ICEIFA_PRE21, ICEIFA_PRE20,
			ICEIFA_PRE19, ICEIFA_PRE18, ICEIFA_PRE17, ICEIFA_PRE16,
			ICEIFA_PRE15, ICEIFA_PRE14, ICEIFA_PRE13, ICEIFA_PRE12,
			ICEIFA_PRE11, ICEIFA_PRE10, ICEIFA_PRE9, ICEIFA_PRE8,
			ICEIFA_PRE7, ICEIFA_PRE6, ICEIFA_PRE5, ICEIFA_PRE4,
			ICEIFA_PRE3, ICEIFA_PRE2, ICEIFA_PRE1, ICEIFA_PRE0
		} = ICEIFA_PRE;
		assign	{
			ICEDI_PRE31, ICEDI_PRE30, ICEDI_PRE29, ICEDI_PRE28,
			ICEDI_PRE27, ICEDI_PRE26, ICEDI_PRE25, ICEDI_PRE24,
			ICEDI_PRE23, ICEDI_PRE22, ICEDI_PRE21, ICEDI_PRE20,
			ICEDI_PRE19, ICEDI_PRE18, ICEDI_PRE17, ICEDI_PRE16,
			ICEDI_PRE15, ICEDI_PRE14, ICEDI_PRE13, ICEDI_PRE12,
			ICEDI_PRE11, ICEDI_PRE10, ICEDI_PRE9, ICEDI_PRE8,
			ICEDI_PRE7, ICEDI_PRE6, ICEDI_PRE5, ICEDI_PRE4,
			ICEDI_PRE3, ICEDI_PRE2, ICEDI_PRE1, ICEDI_PRE0
		} = ICEDI_PRE;
		assign ES = {ES3, ES2, ES1, ES0};
		assign MA = {
				MA15, MA14, MA13, MA12, MA11, MA10, MA9, MA8,
				MA7, MA6, MA5, MA4, MA3, MA2, MA1, MA0
			};
		assign MDW = {
				MDW15, MDW14, MDW13, MDW12, MDW11, MDW10, MDW9, MDW8,
				MDW7, MDW6, MDW5, MDW4, MDW3, MDW2, MDW1, MDW0
			};
		assign {
			MDR15, MDR14, MDR13, MDR12, MDR11, MDR10, MDR9, MDR8,
			MDR7, MDR6, MDR5, MDR4, MDR3, MDR2, MDR1, MDR0
		} = MDR;
		assign {
				VDDLEV7, VDDLEV6, VDDLEV5, VDDLEV4,
				VDDLEV3, VDDLEV2, VDDLEV1, VDDLEV0
		} = VDDLEV;
		assign PC = {
			PC19, PC18, PC17, PC16,
			PC15, PC14, PC13, PC12, PC11, PC10, PC9, PC8,
			PC7, PC6, PC5, PC4, PC3, PC2, PC1, PC0
		};
	
	// ICEDO from each blocks
	
		assign icedoa ={
			ICEDOA31, ICEDOA30, ICEDOA29, ICEDOA28, ICEDOA27, ICEDOA26, ICEDOA25, ICEDOA24,
			ICEDOA23, ICEDOA22, ICEDOA21, ICEDOA20, ICEDOA19, ICEDOA18, ICEDOA17, ICEDOA16,
			ICEDOA15, ICEDOA14, ICEDOA13, ICEDOA12, ICEDOA11, ICEDOA10, ICEDOA9, ICEDOA8,
			ICEDOA7, ICEDOA6, ICEDOA5, ICEDOA4, ICEDOA3, ICEDOA2, ICEDOA1, ICEDOA0
		};
		assign icedob ={
			ICEDOB31, ICEDOB30, ICEDOB29, ICEDOB28, ICEDOB27, ICEDOB26, ICEDOB25, ICEDOB24,
			ICEDOB23, ICEDOB22, ICEDOB21, ICEDOB20, ICEDOB19, ICEDOB18, ICEDOB17, ICEDOB16,
			ICEDOB15, ICEDOB14, ICEDOB13, ICEDOB12, ICEDOB11, ICEDOB10, ICEDOB9, ICEDOB8,
			ICEDOB7, ICEDOB6, ICEDOB5, ICEDOB4, ICEDOB3, ICEDOB2, ICEDOB1, ICEDOB0
		};
		assign icedoc ={
			ICEDOC31, ICEDOC30, ICEDOC29, ICEDOC28, ICEDOC27, ICEDOC26, ICEDOC25, ICEDOC24,
			ICEDOC23, ICEDOC22, ICEDOC21, ICEDOC20, ICEDOC19, ICEDOC18, ICEDOC17, ICEDOC16,
			ICEDOC15, ICEDOC14, ICEDOC13, ICEDOC12, ICEDOC11, ICEDOC10, ICEDOC9, ICEDOC8,
			ICEDOC7, ICEDOC6, ICEDOC5, ICEDOC4, ICEDOC3, ICEDOC2, ICEDOC1, ICEDOC0
		};
		assign icedod ={
			ICEDOD31, ICEDOD30, ICEDOD29, ICEDOD28, ICEDOD27, ICEDOD26, ICEDOD25, ICEDOD24,
			ICEDOD23, ICEDOD22, ICEDOD21, ICEDOD20, ICEDOD19, ICEDOD18, ICEDOD17, ICEDOD16,
			ICEDOD15, ICEDOD14, ICEDOD13, ICEDOD12, ICEDOD11, ICEDOD10, ICEDOD9, ICEDOD8,
			ICEDOD7, ICEDOD6, ICEDOD5, ICEDOD4, ICEDOD3, ICEDOD2, ICEDOD1, ICEDOD0
		};
		assign icedoe ={
			ICEDOE31, ICEDOE30, ICEDOE29, ICEDOE28, ICEDOE27, ICEDOE26, ICEDOE25, ICEDOE24,
			ICEDOE23, ICEDOE22, ICEDOE21, ICEDOE20, ICEDOE19, ICEDOE18, ICEDOE17, ICEDOE16,
			ICEDOE15, ICEDOE14, ICEDOE13, ICEDOE12, ICEDOE11, ICEDOE10, ICEDOE9, ICEDOE8,
			ICEDOE7, ICEDOE6, ICEDOE5, ICEDOE4, ICEDOE3, ICEDOE2, ICEDOE1, ICEDOE0
		};
		assign icedof ={
			ICEDOF31, ICEDOF30, ICEDOF29, ICEDOF28, ICEDOF27, ICEDOF26, ICEDOF25, ICEDOF24,
			ICEDOF23, ICEDOF22, ICEDOF21, ICEDOF20, ICEDOF19, ICEDOF18, ICEDOF17, ICEDOF16,
			ICEDOF15, ICEDOF14, ICEDOF13, ICEDOF12, ICEDOF11, ICEDOF10, ICEDOF9, ICEDOF8,
			ICEDOF7, ICEDOF6, ICEDOF5, ICEDOF4, ICEDOF3, ICEDOF2, ICEDOF1, ICEDOF0
		};
		assign icedog ={
			ICEDOG31, ICEDOG30, ICEDOG29, ICEDOG28, ICEDOG27, ICEDOG26, ICEDOG25, ICEDOG24,
			ICEDOG23, ICEDOG22, ICEDOG21, ICEDOG20, ICEDOG19, ICEDOG18, ICEDOG17, ICEDOG16,
			ICEDOG15, ICEDOG14, ICEDOG13, ICEDOG12, ICEDOG11, ICEDOG10, ICEDOG9, ICEDOG8,
			ICEDOG7, ICEDOG6, ICEDOG5, ICEDOG4, ICEDOG3, ICEDOG2, ICEDOG1, ICEDOG0
		};
		assign icedoh ={
			ICEDOH31, ICEDOH30, ICEDOH29, ICEDOH28, ICEDOH27, ICEDOH26, ICEDOH25, ICEDOH24,
			ICEDOH23, ICEDOH22, ICEDOH21, ICEDOH20, ICEDOH19, ICEDOH18, ICEDOH17, ICEDOH16,
			ICEDOH15, ICEDOH14, ICEDOH13, ICEDOH12, ICEDOH11, ICEDOH10, ICEDOH9, ICEDOH8,
			ICEDOH7, ICEDOH6, ICEDOH5, ICEDOH4, ICEDOH3, ICEDOH2, ICEDOH1, ICEDOH0
		};
		assign icedoj ={
			ICEDOJ31, ICEDOJ30, ICEDOJ29, ICEDOJ28, ICEDOJ27, ICEDOJ26, ICEDOJ25, ICEDOJ24,
			ICEDOJ23, ICEDOJ22, ICEDOJ21, ICEDOJ20, ICEDOJ19, ICEDOJ18, ICEDOJ17, ICEDOJ16,
			ICEDOJ15, ICEDOJ14, ICEDOJ13, ICEDOJ12, ICEDOJ11, ICEDOJ10, ICEDOJ9, ICEDOJ8,
			ICEDOJ7, ICEDOJ6, ICEDOJ5, ICEDOJ4, ICEDOJ3, ICEDOJ2, ICEDOJ1, ICEDOJ0
		};
		assign icedok ={
			ICEDOK31, ICEDOK30, ICEDOK29, ICEDOK28, ICEDOK27, ICEDOK26, ICEDOK25, ICEDOK24,
			ICEDOK23, ICEDOK22, ICEDOK21, ICEDOK20, ICEDOK19, ICEDOK18, ICEDOK17, ICEDOK16,
			ICEDOK15, ICEDOK14, ICEDOK13, ICEDOK12, ICEDOK11, ICEDOK10, ICEDOK9, ICEDOK8,
			ICEDOK7, ICEDOK6, ICEDOK5, ICEDOK4, ICEDOK3, ICEDOK2, ICEDOK1, ICEDOK0
		};
		assign icedol ={
			ICEDOL31, ICEDOL30, ICEDOL29, ICEDOL28, ICEDOL27, ICEDOL26, ICEDOL25, ICEDOL24,
			ICEDOL23, ICEDOL22, ICEDOL21, ICEDOL20, ICEDOL19, ICEDOL18, ICEDOL17, ICEDOL16,
			ICEDOL15, ICEDOL14, ICEDOL13, ICEDOL12, ICEDOL11, ICEDOL10, ICEDOL9, ICEDOL8,
			ICEDOL7, ICEDOL6, ICEDOL5, ICEDOL4, ICEDOL3, ICEDOL2, ICEDOL1, ICEDOL0
		};
		assign icedom ={
			ICEDOM31, ICEDOM30, ICEDOM29, ICEDOM28, ICEDOM27, ICEDOM26, ICEDOM25, ICEDOM24,
			ICEDOM23, ICEDOM22, ICEDOM21, ICEDOM20, ICEDOM19, ICEDOM18, ICEDOM17, ICEDOM16,
			ICEDOM15, ICEDOM14, ICEDOM13, ICEDOM12, ICEDOM11, ICEDOM10, ICEDOM9, ICEDOM8,
			ICEDOM7, ICEDOM6, ICEDOM5, ICEDOM4, ICEDOM3, ICEDOM2, ICEDOM1, ICEDOM0
		};
		assign icedon ={
			ICEDON31, ICEDON30, ICEDON29, ICEDON28, ICEDON27, ICEDON26, ICEDON25, ICEDON24,
			ICEDON23, ICEDON22, ICEDON21, ICEDON20, ICEDON19, ICEDON18, ICEDON17, ICEDON16,
			ICEDON15, ICEDON14, ICEDON13, ICEDON12, ICEDON11, ICEDON10, ICEDON9, ICEDON8,
			ICEDON7, ICEDON6, ICEDON5, ICEDON4, ICEDON3, ICEDON2, ICEDON1, ICEDON0
		};
		assign icedop ={
			ICEDOP31, ICEDOP30, ICEDOP29, ICEDOP28, ICEDOP27, ICEDOP26, ICEDOP25, ICEDOP24,
			ICEDOP23, ICEDOP22, ICEDOP21, ICEDOP20, ICEDOP19, ICEDOP18, ICEDOP17, ICEDOP16,
			ICEDOP15, ICEDOP14, ICEDOP13, ICEDOP12, ICEDOP11, ICEDOP10, ICEDOP9, ICEDOP8,
			ICEDOP7, ICEDOP6, ICEDOP5, ICEDOP4, ICEDOP3, ICEDOP2, ICEDOP1, ICEDOP0
		};
		assign icedoq ={
			ICEDOQ31, ICEDOQ30, ICEDOQ29, ICEDOQ28, ICEDOQ27, ICEDOQ26, ICEDOQ25, ICEDOQ24,
			ICEDOQ23, ICEDOQ22, ICEDOQ21, ICEDOQ20, ICEDOQ19, ICEDOQ18, ICEDOQ17, ICEDOQ16,
			ICEDOQ15, ICEDOQ14, ICEDOQ13, ICEDOQ12, ICEDOQ11, ICEDOQ10, ICEDOQ9, ICEDOQ8,
			ICEDOQ7, ICEDOQ6, ICEDOQ5, ICEDOQ4, ICEDOQ3, ICEDOQ2, ICEDOQ1, ICEDOQ0
		};
		assign icedor ={
			ICEDOR31, ICEDOR30, ICEDOR29, ICEDOR28, ICEDOR27, ICEDOR26, ICEDOR25, ICEDOR24,
			ICEDOR23, ICEDOR22, ICEDOR21, ICEDOR20, ICEDOR19, ICEDOR18, ICEDOR17, ICEDOR16,
			ICEDOR15, ICEDOR14, ICEDOR13, ICEDOR12, ICEDOR11, ICEDOR10, ICEDOR9, ICEDOR8,
			ICEDOR7, ICEDOR6, ICEDOR5, ICEDOR4, ICEDOR3, ICEDOR2, ICEDOR1, ICEDOR0
		};
		assign icedos ={
			ICEDOS31, ICEDOS30, ICEDOS29, ICEDOS28, ICEDOS27, ICEDOS26, ICEDOS25, ICEDOS24,
			ICEDOS23, ICEDOS22, ICEDOS21, ICEDOS20, ICEDOS19, ICEDOS18, ICEDOS17, ICEDOS16,
			ICEDOS15, ICEDOS14, ICEDOS13, ICEDOS12, ICEDOS11, ICEDOS10, ICEDOS9, ICEDOS8,
			ICEDOS7, ICEDOS6, ICEDOS5, ICEDOS4, ICEDOS3, ICEDOS2, ICEDOS1, ICEDOS0
		};
		assign icedot ={
			ICEDOT31, ICEDOT30, ICEDOT29, ICEDOT28, ICEDOT27, ICEDOT26, ICEDOT25, ICEDOT24,
			ICEDOT23, ICEDOT22, ICEDOT21, ICEDOT20, ICEDOT19, ICEDOT18, ICEDOT17, ICEDOT16,
			ICEDOT15, ICEDOT14, ICEDOT13, ICEDOT12, ICEDOT11, ICEDOT10, ICEDOT9, ICEDOT8,
			ICEDOT7, ICEDOT6, ICEDOT5, ICEDOT4, ICEDOT3, ICEDOT2, ICEDOT1, ICEDOT0
		};
		assign icedou ={
			ICEDOU31, ICEDOU30, ICEDOU29, ICEDOU28, ICEDOU27, ICEDOU26, ICEDOU25, ICEDOU24,
			ICEDOU23, ICEDOU22, ICEDOU21, ICEDOU20, ICEDOU19, ICEDOU18, ICEDOU17, ICEDOU16,
			ICEDOU15, ICEDOU14, ICEDOU13, ICEDOU12, ICEDOU11, ICEDOU10, ICEDOU9, ICEDOU8,
			ICEDOU7, ICEDOU6, ICEDOU5, ICEDOU4, ICEDOU3, ICEDOU2, ICEDOU1, ICEDOU0
		};
	
	// [$B%P%9JQ49(B]
	
		USB2USBIF usb2usbif (
			.ICESYSRES_B(ICESYSRES_B),
			.USBCLK(USBCLK), .USBA(USBA),
			.USBD({
				USBD15, USBD14, USBD13, USBD12, USBD11, USBD10, USBD9, USBD8,
				USBD7, USBD6, USBD5, USBD4, USBD3, USBD2, USBD1, USBD0
			}),
			.USBRD_B(USBRD_B), .USBWR0_B(USBWR0_B), .USBWAIT_B(USBWAIT_B),
			.EROMWAIT(EROMWAIT),
			.usbifa(usbifa), .usbifdi(usbifdi), .usbifdo(usbifdo),
			.usbifrd(usbifrd), .usbifwr(usbifwr)
		);
		
		USBIF2ICE usbif2ice (
			.ICESYSRES_B(ICESYSRES_B), .CLK60MHZ(CLK60MHZ),
			.usbifa(usbifa), .usbifdi(usbifdi), .usbifdo(usbifdo),
			.usbifrd(usbifrd), .usbifwr(usbifwr),
			.iceifa(ICEIFA_PRE), .icedi(ICEDI_PRE), .icedo(ICEDO),
			.icerd(ICERD_PRE), .icewr(ICEWR_PRE)
		);
	
	// [TVDD$BEE05JQ49(B]
	
		wire sel_tvdd = (usbifa[2:0] == 3'b111) ? 1'b1 : 1'b0;
		always @(negedge usbifwr or negedge ICESYSRES_B) begin
			if (!ICESYSRES_B) begin
				VDDLEV <= 8'hFF;
			end else begin
				if (sel_tvdd) begin
					VDDLEV <= usbifdi[7:0];
				end
			end
		end
		assign USBIFWR = usbifwr;
	
	// [$B%[%9%H6u4V%j!<%I(B]
	
		assign ICEDO = (
			icedoa | icedob | icedoc | icedod | icedoe | icedof | icedog | icedoh |
			icedoj | icedok | icedol | icedom | icedon | icedop | icedoq | icedor |
			icedos | icedot | icedou | icedopc
		);
	
	// [$B%P%92#<h$j(B], [$B%[%9%H6u4V%i%$%H(B]
	
		SNATCH snatch (
			.ICEIFA_PRE(ICEIFA_PRE), .ICEDI_PRE(ICEDI_PRE),
			.ICERD_PRE(ICERD_PRE), .ICEWR_PRE(ICEWR_PRE),
			.ICEIFA(ICEIFA), .ICEDI(ICEDI), .ICEDO(ICEDO),
			.ICERD(ICERD), .ICEWR(ICEWR),
			.CPURESETB(CPURESETB), .BASECK(BASECK),
			.SVMOD(SVMOD), .ALT1(ALT1),
			.SLMEM(SLMEM), .ES(ES), .MA(MA), .MDW(MDW), .MDR(MDR),
			.CPUWR(CPUWR), .CPURD(CPURD), .WDOP(WDOP)
		);
	
	// [$BHFMQ%l%8%9%?%j!<%I(B]
	
		assign ICECSGREGU = (
			ICEIFA[24] &
			(({ICEIFA[23:5], 5'b0_0000} == 24'h13FB80) ? 1'b1 : 1'b0)
		); // 0113_FB80H-0113_FB9CH
	
	// [PC$B%j!<%I(B]
	
		wire sel_pc = (
			ICEIFA[27] & ICEIFA[23] & ICEIFA[14] &
			(({ICEIFA[11:2], 2'b00} == 12'h004) ? 1'b1 : 1'b0)
		); // 0880_4004H
		assign icedopc = (sel_pc) ? {12'b0, PC} : 32'h0000_0000;
	
endmodule

// Sub modules

	module USB2USBIF ( // USBxx$B%P%9"+"*(BUSBIFxx$B%P%9$NJQ49(B
		ICESYSRES_B,
		USBCLK, USBA, USBD,
		USBRD_B, USBWR0_B, USBWAIT_B,
		EROMWAIT,
		usbifa, usbifdi, usbifdo,
		usbifrd, usbifwr
	);
		
		input	ICESYSRES_B;
		input	USBCLK;
		input	[21:0]	USBA;
		inout	[15:0]	USBD;
		input	USBRD_B, USBWR0_B;
		output	USBWAIT_B;
		input	EROMWAIT;
		output	[2:0]	usbifa;
		output	[31:0]	usbifdi;
		input	[31:0]	usbifdo;
		output	usbifrd, usbifwr;
		
		// 16bit <-> 32bit
		
			wire sel_icemacro, hi_adr, low_adr, hi_wr, low_wr, hi_rd, low_rd;
			reg [15:0] hi_write_data, hi_read_data;
			
			assign sel_icemacro = (USBA[21:19] == 3'b100) ? 1'b1 : 1'b0;
			assign hi_adr = USBA[1];   /* A1$B$,(B1$B$J$i>e0L%"%I%l%9%"%/%;%9(B */
			assign low_adr = ~USBA[1]; /* A1$B$,(B0$B$J$i2<0L%"%I%l%9%"%/%;%9(B */
			assign hi_wr  = sel_icemacro & ~USBWR0_B & hi_adr;  /* $B>e0L%i%$%H?.9f(B */
			assign low_wr = sel_icemacro & ~USBWR0_B & low_adr; /* $B2<0L%i%$%H?.9f(B */
			assign hi_rd  = sel_icemacro & ~USBRD_B & hi_adr;   /* $B>e0L%"%I%l%9%j!<%I(B */
			assign low_rd = sel_icemacro & ~USBRD_B & low_adr;  /* $B2<0L%"%I%l%9%j!<%I(B */
			
			always @(negedge hi_wr) begin
				hi_write_data = USBD;
			end
			
			always @(negedge low_rd) begin
				hi_read_data <= usbifdo[31:16];
			end
			
			assign usbifa = USBA[4:2];
			assign usbifdi = {hi_write_data, USBD};
			assign USBD = (low_rd) ? usbifdo[15:0] : (hi_rd) ? hi_read_data : 16'bz;
			assign usbifrd = low_rd;
			assign usbifwr = low_wr;
		
		// USBWAIT
		
			reg	[1:0]	wait_count;
			always @(posedge USBCLK or negedge ICESYSRES_B) begin
				if (!ICESYSRES_B) wait_count <= 2'b10;
				else if (low_rd | low_wr) begin
					if (EROMWAIT) wait_count <= 2'b10;
					else if (wait_count != 2'b00) wait_count <= wait_count - 1;
				end
				else wait_count <= 2'b10;
			end
			assign USBWAIT_B = !((low_rd | low_wr) & (wait_count[1] | wait_count[0]));
		
	endmodule
	
	module USBIF2ICE ( // USBIFxx$B%P%9"+"*(BICExx$B%P%9$NJQ49(B
		ICESYSRES_B, CLK60MHZ,
		usbifa, usbifdi, usbifdo,
		usbifrd, usbifwr,
		iceifa, icedo, icedi, icerd, icewr
	);
		
		input	ICESYSRES_B, CLK60MHZ;
		input	[2:0]	usbifa;
		input	[31:0]	usbifdi;
		output	[31:0]	usbifdo;
		input	usbifrd, usbifwr;
		output	[31:0]	iceifa;
		output	[31:0]	icedi;
		input	[31:0]	icedo;
		output	icerd, icewr;
		
		wire	sel_adr, sel_data, sel_autoinc;
		reg		[31:0]	iceifa;
		
		// Decoder
		
			assign {sel_data, sel_adr, sel_autoinc} = (
				(usbifa[2:0] == 3'b001) ? 3'b101 : // 1h : Data(auto increment)
				(usbifa[2:0] == 3'b100) ? 3'b100 : // 4h : Data
				(usbifa[2:0] == 3'b110) ? 3'b010 : // 6h : Address
				3'b000
			);
		
		// Generate ICEIFA
		
			reg [31:0] iceifa_prebuf;
			wire iceifaclk; // address count up clock for auto increment(active level inverted)
			reg iceifaclk_d1, iceifaclk_d2;
			
			assign iceifaclk = usbifrd | usbifwr; // address count up clock for auto increment
			
			always @( negedge iceifaclk or negedge ICESYSRES_B) begin
				if (!ICESYSRES_B) begin
					iceifa_prebuf <= 32'hFFFF_0000; // $B"+=i4|CM$O(Bauto_inc$BESCf$G%j%;%C%H2r=|$7$F$b(B
				end                              // $B!!%G!<%?$r2u$5$J$$$h$&$K(BFFFF0000$B$K$7$?(B
				else begin
					if (sel_adr) begin // address write
						iceifa_prebuf <= usbifdi;
					end
					else if (sel_autoinc) begin
						iceifa_prebuf <= iceifa + 32'h0000_0004;
					end
				end
			end
			
			always @(posedge CLK60MHZ) iceifaclk_d1 <= iceifaclk;
			always @(posedge CLK60MHZ) iceifaclk_d2 <= iceifaclk_d1;
			always @(negedge iceifaclk_d2 or negedge ICESYSRES_B ) begin
				if (!ICESYSRES_B ) iceifa <= 32'hffff_0000;
				else               iceifa <= iceifa_prebuf; // $B"+%*!<%H%$%s%/%j%a%s%H;~$K%"%I%l%9%[!<%k%I;~4V$r2T$0!#(B
			end                                             // $B!!?t(Bns$B$GNI$$$,0l1~(B60MHz$B$N#1%/%m%C%/!A#2%/%m%C%/(B
		
		assign icedi = usbifdi;
		assign usbifdo = (sel_adr) ? iceifa : icedo;
		assign icerd = (usbifrd & sel_data);
		assign icewr = (usbifwr & sel_data);
		
	endmodule
	
	module SNATCH ( // [$B%P%92#<h$j(B]
		ICEIFA_PRE, ICEDI_PRE,
		ICERD_PRE, ICEWR_PRE,
		ICEIFA, ICEDI, ICEDO,
		ICERD, ICEWR,
		CPURESETB, BASECK,
		SVMOD, ALT1,
		SLMEM, ES, MA, MDW, MDR,
		CPUWR, CPURD, WDOP
	);
		
		input	[31:0] ICEIFA_PRE, ICEDI_PRE;
		input	ICERD_PRE, ICEWR_PRE;
		output	[31:0] ICEIFA, ICEDI;
		input	[31:0] ICEDO;
		output	ICERD, ICEWR;
		
		input	CPURESETB; // CPU and peripheral reset (except RESF)
		input	BASECK; // CPU base clock
		input	SVMOD, ALT1;
		input	SLMEM;
		input	[3:0] ES;
		input	[15:0] MA, MDW;
		output	[15:0] MDR;
		input	CPUWR, CPURD, WDOP;
		
		wire sel_cpu_hostif;
		wire sel_cpu_0h, sel_cpu_2h, sel_cpu_4h, sel_cpu_6h, sel_cpu_8h;
		reg [15:0] hostaca1, hostaca0, hostacd1, hostacd0;
		reg cpu_read, cpu_write, en_snatch_pre;
		reg en_snatch;
		
		// Selector
		
			assign sel_cpu_hostif = CPURESETB & SVMOD & ~ALT1 & SLMEM & (({ES, MA[15:4], 4'h0} == 20'hFC050) ? 1'b1 : 1'b0);
			assign sel_cpu_0h = sel_cpu_hostif & WDOP & (({MA[3:1], 1'b0} == 4'h0) ? 1'b1 : 1'b0);
			assign sel_cpu_2h = sel_cpu_hostif & WDOP & (({MA[3:1], 1'b0} == 4'h2) ? 1'b1 : 1'b0);
			assign sel_cpu_4h = sel_cpu_hostif & WDOP & (({MA[3:1], 1'b0} == 4'h4) ? 1'b1 : 1'b0);
			assign sel_cpu_6h = sel_cpu_hostif & WDOP & (({MA[3:1], 1'b0} == 4'h6) ? 1'b1 : 1'b0);
			assign sel_cpu_8h = sel_cpu_hostif & (({MA[3:1], 1'b0} == 4'h8) ? 1'b1 : 1'b0);
		
		// Read registers
		
			assign MDR = (
				(CPURD & sel_cpu_0h) ? hostaca0 :
				(CPURD & sel_cpu_2h) ? hostaca1 :
				(CPURD & sel_cpu_4h) ? ICEDO[15:0] :
				(CPURD & sel_cpu_6h) ? ICEDO[31:16] :
				(CPURD & sel_cpu_8h) ? {12'b0, en_snatch_pre, en_snatch, cpu_write, cpu_read} :
				16'h0000
			);
		
		// Write regigsters
		
			always @(posedge BASECK or negedge CPURESETB) begin // HOSTACA0
				if (!CPURESETB) begin
					hostaca0 <= 16'h0000;
				end
				else begin
					if (CPUWR & sel_cpu_0h) begin
						hostaca0 <= MDW;
					end
				end
			end
			
			always @(posedge BASECK or negedge CPURESETB) begin // HOSTACA1
				if (!CPURESETB) begin
					hostaca1 <= 16'h0000;
				end
				else begin
					if (CPUWR & sel_cpu_2h) begin
						hostaca1 <= MDW;
					end
				end
			end
			
			always @(posedge BASECK or negedge CPURESETB) begin // HOSTACD0
				if (!CPURESETB) begin
					hostacd0 <= 16'h0000;
				end
				else begin
					if (CPUWR & sel_cpu_4h) begin
						hostacd0 <= MDW;
					end
				end
			end
			
			always @(posedge BASECK or negedge CPURESETB) begin // HOSTACD1
				if (!CPURESETB) begin
					hostacd1 <= 16'h0000;
				end
				else begin
					if (CPUWR & sel_cpu_6h) begin
						hostacd1 <= MDW;
					end
				end
			end
			
			always @(posedge BASECK or negedge CPURESETB) begin // HOSTACC
				if (!CPURESETB) begin
					en_snatch_pre <= 1'b0;
					cpu_write     <= 1'b0;
					cpu_read      <= 1'b0;
				end
				else begin
					if (CPUWR & sel_cpu_8h) begin
						en_snatch_pre <= MDW[3];
						cpu_write     <= MDW[1];
						cpu_read      <= MDW[0];
					end
				end
			end
		
		always @(posedge BASECK or negedge CPURESETB) begin
			if (!CPURESETB) begin
				en_snatch <= 1'b0;
			end else begin
				if (!en_snatch_pre) begin
					en_snatch <= 1'b0;
				end else begin
					if (!ICEWR_PRE) begin
						en_snatch <= 1'b1; // $B"+2#<h$j(BEnable($B%i%$%HCf$O@Z$jBX$o$i$J$$(B)
					end
				end
			end
		end
		
		assign ICEIFA = (en_snatch) ? {hostaca1, hostaca0} : ICEIFA_PRE;
		assign ICEDI = (en_snatch) ? {hostacd1, hostacd0} : ICEDI_PRE;
		assign ICERD = (en_snatch) ? cpu_read : ICERD_PRE;
		assign ICEWR = (en_snatch) ? cpu_write : ICEWR_PRE;
		
	endmodule

