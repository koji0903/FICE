//////////////////////////////////////////////////
//
// Fixed Pin module for g13_64
//   Generated by FICE(mkPin) ver 1.2.326
//   time : Thu Mar 03 20:48:19 +0900 2011
//
//////////////////////////////////////////////////

// [File information]
// Port File : CN1-5.csv (Fri Feb 18 21:14:17 +0900 2011)
// Pull File : PullUp.csv (Fri Feb 18 21:14:20 +0900 2011)
// CT   File : CT4.csv (Fri Feb 18 21:14:23 +0900 2011)

module g13_64_FixedPin (
		// from CN1-5.csv
		fixL_AJ14,
		fixL_AH15,
		fixH_AK14,
		fixH_AJ15,
		fixL_AJ16,
		fixL_AH17,
		fixL_AJ17,
		fixL_AK16,
		fixH_AL20,
		fixH_AL21,
		fixH_AG18,
		fixH_AH18,
		fixL_AL14,
		fixH_AE11,
		fixL_AF20,
		fixL_AF19,
		fixL_AE18,
		fixL_AF18,
		fixH_AN30,
		fixH_AM30,
		fixH_AP30,
		fixH_AP31,
		fixL_AP29,
		fixL_AN29,
		fixL_AP27,
		fixL_AN27,
		fixL_AN28,
		fixL_AM28,
		fixH_AM26,
		fixH_AL26,
		fixH_AP26,
		fixH_AP25,
		fixH_AL25,
		fixH_AL24,
		fixL_AM23,
		fixL_AN20,
		fixL_AP20,
		fixH_AP21,
		fixH_AN19,
		fixH_AP19,
		fixL_AD9,
		fixL_AC9,
		fixL_AG8,
		fixL_AH8,
		fixL_AE8,
		fixL_AF8,
		fixL_AC10,
		fixL_AD10,
		fixH_AK6,
		fixH_AK7,
		fixH_AE9,
		fixH_AF9,
		fixH_AH9,
		fixH_AJ9,
		fixH_AF10,
		fixH_AG10,
		fixL_H7,
		fixL_H8,
		fixL_K7,
		fixL_J7,
		fixL_G6,
		fixL_G7,
		fixL_M8,
		fixL_M7,
		fixH_P7,
		fixH_N7,
		fixH_N9,
		fixH_N10,
		fixH_P9,
		fixH_N8,
		fixH_P11,
		fixH_P10,
		fixL_J5,
		fixL_H5,
		fixL_E4,
		fixL_F4,
		fixH_M5,
		fixH_L5,
		fixH_K4,
		fixH_L4,
		fixL_U8,
		fixL_T8,
		fixL_R11,
		fixL_T10,
		fixL_U10,
		fixL_T9,
		fixL_U11,
		fixH_A15,
		fixH_A14,
		fixH_C14,
		fixH_C13,
		fixH_B15,
		fixH_C15,
		fixH_B13,
		fixL_B16,
		fixL_A16,
		fixL_B12,
		fixL_C12,
		fixL_B17,
		fixL_C17,
		fixL_A11,
		fixH_D11,
		fixH_D10,
		fixH_A10,
		fixH_A9,
		fixH_B8,
		fixH_A8,
		fixH_B10,
		fixL_A5,
		fixL_A6,
		fixL_B6,
		fixL_B7,
		fixL_B5,
		fixL_A4,
		fixL_C8,
		fixL_C7,
		fixH_C4,
		fixH_C5,
		fixH_D9,
		fixH_C9,
		fixH_D5,
		fixH_D4,
		fixH_D6,
		fixH_D7,
		fixH_A31,
		fixH_E19,
		fixH_E16,
		fixH_F16,
		fixH_D21,
		fixH_D20,
		fixH_G18,
		fixH_G17,
		fixH_E14,
		fixH_D22,
		fixH_E23,
		fixH_G15,
		fixH_F14,
		fixH_E22,
		fixH_F23,
		fixL_AE2,
		fixL_AD2,
		fixL_AN7,
		fixL_AM6,
		fixL_AM8,
		fixL_AM7,
		fixL_AN9,
		fixL_AN8,
		// from CT4.csv
		fixH_AE23,
		fixH_AF15,
		fixH_AE14,
		fixH_AF23,
		fixH_AE13,
		fixH_AE12
	);

	// from CN1-5.csv
	output fixL_AJ14;
	assign fixL_AJ14 = 1'b0;  // P56 Low fix

	output fixL_AH15;
	assign fixL_AH15 = 1'b0;  // P57 Low fix

	output fixH_AK14;
	assign fixH_AK14 = 1'b1;  // PIO56 High fix

	output fixH_AJ15;
	assign fixH_AJ15 = 1'b1;  // PIO57 High fix

	output fixL_AJ16;
	assign fixL_AJ16 = 1'b0;  // P142 Low fix

	output fixL_AH17;
	assign fixL_AH17 = 1'b0;  // P143 Low fix

	output fixL_AJ17;
	assign fixL_AJ17 = 1'b0;  // P144 Low fix

	output fixL_AK16;
	assign fixL_AK16 = 1'b0;  // P145 Low fix

	output fixH_AL20;
	assign fixH_AL20 = 1'b1;  // PIO142 High fix

	output fixH_AL21;
	assign fixH_AL21 = 1'b1;  // PIO143 High fix

	output fixH_AG18;
	assign fixH_AG18 = 1'b1;  // PIO144 High fix

	output fixH_AH18;
	assign fixH_AH18 = 1'b1;  // PIO145 High fix

	output fixL_AL14;
	assign fixL_AL14 = 1'b0;  // P07 Low fix

	output fixH_AE11;
	assign fixH_AE11 = 1'b1;  // PIO07 High fix

	output fixL_AF20;
	assign fixL_AF20 = 1'b0;  // P44 Low fix

	output fixL_AF19;
	assign fixL_AF19 = 1'b0;  // P45 Low fix

	output fixL_AE18;
	assign fixL_AE18 = 1'b0;  // P46 Low fix

	output fixL_AF18;
	assign fixL_AF18 = 1'b0;  // P47 Low fix

	output fixH_AN30;
	assign fixH_AN30 = 1'b1;  // PIO44 High fix

	output fixH_AM30;
	assign fixH_AM30 = 1'b1;  // PIO45 High fix

	output fixH_AP30;
	assign fixH_AP30 = 1'b1;  // PIO46 High fix

	output fixH_AP31;
	assign fixH_AP31 = 1'b1;  // PIO47 High fix

	output fixL_AP29;
	assign fixL_AP29 = 1'b0;  // P32 Low fix

	output fixL_AN29;
	assign fixL_AN29 = 1'b0;  // P33 Low fix

	output fixL_AP27;
	assign fixL_AP27 = 1'b0;  // P34 Low fix

	output fixL_AN27;
	assign fixL_AN27 = 1'b0;  // P35 Low fix

	output fixL_AN28;
	assign fixL_AN28 = 1'b0;  // P36 Low fix

	output fixL_AM28;
	assign fixL_AM28 = 1'b0;  // P37 Low fix

	output fixH_AM26;
	assign fixH_AM26 = 1'b1;  // PIO32 High fix

	output fixH_AL26;
	assign fixH_AL26 = 1'b1;  // PIO33 High fix

	output fixH_AP26;
	assign fixH_AP26 = 1'b1;  // PIO34 High fix

	output fixH_AP25;
	assign fixH_AP25 = 1'b1;  // PIO35 High fix

	output fixH_AL25;
	assign fixH_AL25 = 1'b1;  // PIO36 High fix

	output fixH_AL24;
	assign fixH_AL24 = 1'b1;  // PIO37 High fix

	output fixL_AM23;
	assign fixL_AM23 = 1'b0;  // P125 Low fix

	output fixL_AN20;
	assign fixL_AN20 = 1'b0;  // P126 Low fix

	output fixL_AP20;
	assign fixL_AP20 = 1'b0;  // P127 Low fix

	output fixH_AP21;
	assign fixH_AP21 = 1'b1;  // PIO125 High fix

	output fixH_AN19;
	assign fixH_AN19 = 1'b1;  // PIO126 High fix

	output fixH_AP19;
	assign fixH_AP19 = 1'b1;  // PIO127 High fix

	output fixL_AD9;
	assign fixL_AD9 = 1'b0;  // P90 Low fix

	output fixL_AC9;
	assign fixL_AC9 = 1'b0;  // P91 Low fix

	output fixL_AG8;
	assign fixL_AG8 = 1'b0;  // P92 Low fix

	output fixL_AH8;
	assign fixL_AH8 = 1'b0;  // P93 Low fix

	output fixL_AE8;
	assign fixL_AE8 = 1'b0;  // P94 Low fix

	output fixL_AF8;
	assign fixL_AF8 = 1'b0;  // P95 Low fix

	output fixL_AC10;
	assign fixL_AC10 = 1'b0;  // P96 Low fix

	output fixL_AD10;
	assign fixL_AD10 = 1'b0;  // P97 Low fix

	output fixH_AK6;
	assign fixH_AK6 = 1'b1;  // PIO90 High fix

	output fixH_AK7;
	assign fixH_AK7 = 1'b1;  // PIO91 High fix

	output fixH_AE9;
	assign fixH_AE9 = 1'b1;  // PIO92 High fix

	output fixH_AF9;
	assign fixH_AF9 = 1'b1;  // PIO93 High fix

	output fixH_AH9;
	assign fixH_AH9 = 1'b1;  // PIO94 High fix

	output fixH_AJ9;
	assign fixH_AJ9 = 1'b1;  // PIO95 High fix

	output fixH_AF10;
	assign fixH_AF10 = 1'b1;  // PIO96 High fix

	output fixH_AG10;
	assign fixH_AG10 = 1'b1;  // PIO97 High fix

	output fixL_H7;
	assign fixL_H7 = 1'b0;  // P110 Low fix

	output fixL_H8;
	assign fixL_H8 = 1'b0;  // P111 Low fix

	output fixL_K7;
	assign fixL_K7 = 1'b0;  // P112 Low fix

	output fixL_J7;
	assign fixL_J7 = 1'b0;  // P113 Low fix

	output fixL_G6;
	assign fixL_G6 = 1'b0;  // P114 Low fix

	output fixL_G7;
	assign fixL_G7 = 1'b0;  // P115 Low fix

	output fixL_M8;
	assign fixL_M8 = 1'b0;  // P116 Low fix

	output fixL_M7;
	assign fixL_M7 = 1'b0;  // P117 Low fix

	output fixH_P7;
	assign fixH_P7 = 1'b1;  // PIO110 High fix

	output fixH_N7;
	assign fixH_N7 = 1'b1;  // PIO111 High fix

	output fixH_N9;
	assign fixH_N9 = 1'b1;  // PIO112 High fix

	output fixH_N10;
	assign fixH_N10 = 1'b1;  // PIO113 High fix

	output fixH_P9;
	assign fixH_P9 = 1'b1;  // PIO114 High fix

	output fixH_N8;
	assign fixH_N8 = 1'b1;  // PIO115 High fix

	output fixH_P11;
	assign fixH_P11 = 1'b1;  // PIO116 High fix

	output fixH_P10;
	assign fixH_P10 = 1'b1;  // PIO117 High fix

	output fixL_J5;
	assign fixL_J5 = 1'b0;  // P64 Low fix

	output fixL_H5;
	assign fixL_H5 = 1'b0;  // P65 Low fix

	output fixL_E4;
	assign fixL_E4 = 1'b0;  // P66 Low fix

	output fixL_F4;
	assign fixL_F4 = 1'b0;  // P67 Low fix

	output fixH_M5;
	assign fixH_M5 = 1'b1;  // PIO64 High fix

	output fixH_L5;
	assign fixH_L5 = 1'b1;  // PIO65 High fix

	output fixH_K4;
	assign fixH_K4 = 1'b1;  // PIO66 High fix

	output fixH_L4;
	assign fixH_L4 = 1'b1;  // PIO67 High fix

	output fixL_U8;
	assign fixL_U8 = 1'b0;  // P150 Low fix

	output fixL_T8;
	assign fixL_T8 = 1'b0;  // P151 Low fix

	output fixL_R11;
	assign fixL_R11 = 1'b0;  // P152 Low fix

	output fixL_T10;
	assign fixL_T10 = 1'b0;  // P153 Low fix

	output fixL_U10;
	assign fixL_U10 = 1'b0;  // P154 Low fix

	output fixL_T9;
	assign fixL_T9 = 1'b0;  // P155 Low fix

	output fixL_U11;
	assign fixL_U11 = 1'b0;  // P156 Low fix

	output fixH_A15;
	assign fixH_A15 = 1'b1;  // PIO150 High fix

	output fixH_A14;
	assign fixH_A14 = 1'b1;  // PIO151 High fix

	output fixH_C14;
	assign fixH_C14 = 1'b1;  // PIO152 High fix

	output fixH_C13;
	assign fixH_C13 = 1'b1;  // PIO153 High fix

	output fixH_B15;
	assign fixH_B15 = 1'b1;  // PIO154 High fix

	output fixH_C15;
	assign fixH_C15 = 1'b1;  // PIO155 High fix

	output fixH_B13;
	assign fixH_B13 = 1'b1;  // PIO156 High fix

	output fixL_B16;
	assign fixL_B16 = 1'b0;  // P100 Low fix

	output fixL_A16;
	assign fixL_A16 = 1'b0;  // P101 Low fix

	output fixL_B12;
	assign fixL_B12 = 1'b0;  // P102 Low fix

	output fixL_C12;
	assign fixL_C12 = 1'b0;  // P103 Low fix

	output fixL_B17;
	assign fixL_B17 = 1'b0;  // P104 Low fix

	output fixL_C17;
	assign fixL_C17 = 1'b0;  // P105 Low fix

	output fixL_A11;
	assign fixL_A11 = 1'b0;  // P106 Low fix

	output fixH_D11;
	assign fixH_D11 = 1'b1;  // PIO100 High fix

	output fixH_D10;
	assign fixH_D10 = 1'b1;  // PIO101 High fix

	output fixH_A10;
	assign fixH_A10 = 1'b1;  // PIO102 High fix

	output fixH_A9;
	assign fixH_A9 = 1'b1;  // PIO103 High fix

	output fixH_B8;
	assign fixH_B8 = 1'b1;  // PIO104 High fix

	output fixH_A8;
	assign fixH_A8 = 1'b1;  // PIO105 High fix

	output fixH_B10;
	assign fixH_B10 = 1'b1;  // PIO106 High fix

	output fixL_A5;
	assign fixL_A5 = 1'b0;  // P80 Low fix

	output fixL_A6;
	assign fixL_A6 = 1'b0;  // P81 Low fix

	output fixL_B6;
	assign fixL_B6 = 1'b0;  // P82 Low fix

	output fixL_B7;
	assign fixL_B7 = 1'b0;  // P83 Low fix

	output fixL_B5;
	assign fixL_B5 = 1'b0;  // P84 Low fix

	output fixL_A4;
	assign fixL_A4 = 1'b0;  // P85 Low fix

	output fixL_C8;
	assign fixL_C8 = 1'b0;  // P86 Low fix

	output fixL_C7;
	assign fixL_C7 = 1'b0;  // P87 Low fix

	output fixH_C4;
	assign fixH_C4 = 1'b1;  // PIO80 High fix

	output fixH_C5;
	assign fixH_C5 = 1'b1;  // PIO81 High fix

	output fixH_D9;
	assign fixH_D9 = 1'b1;  // PIO82 High fix

	output fixH_C9;
	assign fixH_C9 = 1'b1;  // PIO83 High fix

	output fixH_D5;
	assign fixH_D5 = 1'b1;  // PIO84 High fix

	output fixH_D4;
	assign fixH_D4 = 1'b1;  // PIO85 High fix

	output fixH_D6;
	assign fixH_D6 = 1'b1;  // PIO86 High fix

	output fixH_D7;
	assign fixH_D7 = 1'b1;  // PIO87 High fix

	output fixH_A31;
	assign fixH_A31 = 1'b1;  // PSSC6 High fix

	output fixH_E19;
	assign fixH_E19 = 1'b1;  // PORTEN_B8 High fix

	output fixH_E16;
	assign fixH_E16 = 1'b1;  // PORTEN_B9 High fix

	output fixH_F16;
	assign fixH_F16 = 1'b1;  // PORTEN_B10 High fix

	output fixH_D21;
	assign fixH_D21 = 1'b1;  // PORTEN_B11 High fix

	output fixH_D20;
	assign fixH_D20 = 1'b1;  // PORTEN_B12 High fix

	output fixH_G18;
	assign fixH_G18 = 1'b1;  // PORTEN_B13 High fix

	output fixH_G17;
	assign fixH_G17 = 1'b1;  // PORTEN_B14 High fix

	output fixH_E14;
	assign fixH_E14 = 1'b1;  // PORTEN_B20 High fix

	output fixH_D22;
	assign fixH_D22 = 1'b1;  // PORTEN_B21 High fix

	output fixH_E23;
	assign fixH_E23 = 1'b1;  // PORTEN_B22 High fix

	output fixH_G15;
	assign fixH_G15 = 1'b1;  // PORTEN_B23 High fix

	output fixH_F14;
	assign fixH_F14 = 1'b1;  // PORTEN_B24 High fix

	output fixH_E22;
	assign fixH_E22 = 1'b1;  // PORTEN_B25 High fix

	output fixH_F23;
	assign fixH_F23 = 1'b1;  // PORTEN_B26 High fix

	output fixL_AE2;
	assign fixL_AE2 = 1'b0;  // CVRSV0 Low fix

	output fixL_AD2;
	assign fixL_AD2 = 1'b0;  // CVRSV1 Low fix

	output fixL_AN7;
	assign fixL_AN7 = 1'b0;  // PSSC0 Low fix

	output fixL_AM6;
	assign fixL_AM6 = 1'b0;  // PSSC1 Low fix

	output fixL_AM8;
	assign fixL_AM8 = 1'b0;  // PSSC2 Low fix

	output fixL_AM7;
	assign fixL_AM7 = 1'b0;  // PSSC3 Low fix

	output fixL_AN9;
	assign fixL_AN9 = 1'b0;  // PSSC4 Low fix

	output fixL_AN8;
	assign fixL_AN8 = 1'b0;  // PSSC5 Low fix

	// from CT4.csv
	output fixH_AE23;
	assign fixH_AE23 = 1'b1;  // EP1_DACKB High fix

	output fixH_AF15;
	assign fixH_AF15 = 1'b1;  // EP1_RDB High fix

	output fixH_AE14;
	assign fixH_AE14 = 1'b1;  // EP1_TCB High fix

	output fixH_AF23;
	assign fixH_AF23 = 1'b1;  // EP2_DACKB High fix

	output fixH_AE13;
	assign fixH_AE13 = 1'b1;  // EP2_TCB High fix

	output fixH_AE12;
	assign fixH_AE12 = 1'b1;  // EP2_WRB High fix


endmodule
