// Generated by XMLtoVerilog 1.2.6 at Undefined
/* [FromXML] xml version="1.0" encoding="UTF-8"*/
/* [FromXML] Generated by VerilogToXML 1.4.6 at 2012-07-13 11:47:09 */
/* [FromXML] included ".//home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk/test/FMake/tp/1767.v" */
    
module TOP_EVA (clk, rst, D, Q1, Q2, DOUT, peri_o, AD_O, P80, dummy1, dummy2, CapOut, X1, X2, BG2ADSEL, 
    Q3, cspf_Q3, fpga_pio, PTTL06, PTTL07, DADATA_Term, PTTL08, RESETB, FF3_O);
    wire FMakeWire_cspf_wrapper_cspf_bus_add_ff_VIMDS0;
    wire FMakeWire_cspf_wrapper_cspf_bus_add_ff_VIMDS1;
    wire FMakeWire_ice_top_clk_out;
    wire wire001;
    wire FMakeWire_add_ff_CLK30MHz;
    wire FMakeWire_ice_top_SYSRSOUTB;
    wire FMakeWire_cspf_wrapper_cspf_mc200_add_ff2_PUONOUT;
    wire FMakeWire_add_ff_CLK60MHZ;
    wire [2:0] FMakeWire_add_ff_clk_bus_1777;
    wire FMakeWire_add_ff_clk_1777;
    wire cibc_ce0;
    wire FMakeWire_cspf_wrapper_cspf_mc200_CON_BUS0;
    wire FMakeWire_cspf_wrapper_cspf_mc200_CON_BUS1;
    wire connect_1718;
    wire test_wire;
    wire FMakeWire_cspf_wrapper_cspf_ocd_SVSTOP;
    wire FMakeWire_svmodif_SVSTOPICE;
    output FF3_O;
    wire FF3_O;
    output RESETB;
    wire RESETB;
    input PTTL08;
    wire PTTL08;
    wire P80;
    output [1:0] DADATA_Term;
    wire [1:0] DADATA_Term;
    input PTTL07;
    wire PTTL07;
    input PTTL06;
    wire PTTL06;
    output [7:0] fpga_pio;
    wire [7:0] fpga_pio;
    output cspf_Q3;
    wire cspf_Q3;
    output Q3;
    wire Q3;
    wire D;
    wire rst;
    output BG2ADSEL;
    wire BG2ADSEL;
    input clk;
    input rst;
    input D, X2;
    output Q1;
    output Q2;
    wire [3:0] D_Bus;
    wire [1:0] connect_bus_1718;
    output DOUT;
    wire [2:0] addr_a;
    output peri_o;
    output AD_O;
    inout P80;
    output dummy1, dummy2;
    input X1;
    wire rst_res_n;
    wire SVSTOP;
    wire [1:0] cap_out;
    wire pulldown_wire;
    output CapOut;
    wire a1, a0;
    ICE_TOP_test ice_top (.clk(clk), .rst(rst), .D(D), .Q(Q1), .D_Bus(D_Bus), .test_clk(test_clk), .test_wire(test_wire), 
        .connect_1718(connect_1718), .CE0(cibc_ce0), .A0(addr_a[0]), .A1(addr_a[1]), .A2(addr_a[2]), 
        .wire001(wire001), .X1(X1), .a1(a1), .a0(a0), .connect_bus_1718_1(FMakeWire_cspf_wrapper_cspf_mc200_CON_BUS1), 
        .connect_bus_1718_0(FMakeWire_cspf_wrapper_cspf_mc200_CON_BUS0), .clka_1777(FMakeWire_add_ff_clk_1777), 
        .ICECK60M(FMakeWire_add_ff_CLK60MHZ), .SYSRSOUTB(FMakeWire_ice_top_SYSRSOUTB), .clk_out(FMakeWire_ice_top_clk_out));
    CSPF_wrapper cspf_wrapper (.Q(Q2), .D_Bus_Out(D_Bus), .test_clk(test_clk), .connect_bus_1718(connect_bus_1718), 
        .DOUT(DOUT), .addr(addr_a), .bg2adsel(bg2adsel), .dummy1(dummy1), .dummy2(dummy2), .SVSTOP(SVSTOP), 
        .BG2ADSEL(BG2ADSEL), .rst(rst), .D(D), .fpga_pio(fpga_pio[7:0]), .PTTL06(PTTL06), .PTTL07(PTTL07), 
        .DADATA_Term(DADATA_Term[1:0]), .P80(P80), .PTTL08(PTTL08), .RESETB(RESETB), .FMakeWire_cspf_svmodif_SVSTOPICE(FMakeWire_svmodif_SVSTOPICE), 
        .FMakeWire_cspf_ocd_SVSTOP(FMakeWire_cspf_wrapper_cspf_ocd_SVSTOP), .test_wire(test_wire), .connect_1718(connect_1718), 
        .FMakeWire_cspf_mc200_CON_BUS1(FMakeWire_cspf_wrapper_cspf_mc200_CON_BUS1), .FMakeWire_cspf_mc200_CON_BUS0(FMakeWire_cspf_wrapper_cspf_mc200_CON_BUS0), 
        .cibc_ce0(cibc_ce0), .FMakeWire_cspf_add_ff_clk_1777(FMakeWire_add_ff_clk_1777), .FMakeWire_cspf_add_ff_clk_bus_1777(FMakeWire_add_ff_clk_bus_1777[2:0]), 
        .FMakeWire_add_ff_CLK60MHZ(FMakeWire_add_ff_CLK60MHZ), .cspf_Q3(cspf_Q3), .FMakeWire_cspf_mc200_add_ff2_PUONOUT(FMakeWire_cspf_wrapper_cspf_mc200_add_ff2_PUONOUT), 
        .iceck30m(FMakeWire_add_ff_CLK30MHz), .FMakeWire_ice_top_SYSRSOUTB(FMakeWire_ice_top_SYSRSOUTB), 
        .FMakeWire_cspf_mc200_add_ff2_clk(FMakeWire_ice_top_clk_out), .FMakeWire_cspf_mc200_add_ff2_CLK60M(FMakeWire_add_ff_CLK60MHZ), 
        .rst_res_n(rst_res_n), .FMakeWire_cspf_bus_add_ff_VIMDS1(FMakeWire_cspf_wrapper_cspf_bus_add_ff_VIMDS1), 
        .FMakeWire_cspf_bus_add_ff_VIMDS0(FMakeWire_cspf_wrapper_cspf_bus_add_ff_VIMDS0));
    pulldown_cell_pf pulldown_cell0 (.y(pulldown_wire), .x(wire001));
    pericore pericore (.rst_res_n(rst_res_n), .peri_o(peri_o), .AD_O(AD_O), .SVSTOP(SVSTOP), .cap_out(cap_out), 
        .a1(a1), .a0(a0), .bg2adsel(BG2ADSEL), .FF3_O(FF3_O), .FMakeWire_svmodif_SVSTOPICE(FMakeWire_svmodif_SVSTOPICE), 
        .FMakeWire_add_ff_RESB(rst_res_n), .FMakeWire_add_ff_VIMDS1(FMakeWire_cspf_wrapper_cspf_bus_add_ff_VIMDS1), 
        .FMakeWire_add_ff_VIMDS0(FMakeWire_cspf_wrapper_cspf_bus_add_ff_VIMDS0));
    CAP_wrapper cap_wrapper (.cap_out(cap_out), .CapOut(CapOut));
    svmodif svmodif (.SVSTOPICE(FMakeWire_svmodif_SVSTOPICE), .SVSTOP(FMakeWire_cspf_wrapper_cspf_ocd_SVSTOP));
    add_ff add_ff (.rst(rst), .D(D), .Q3(Q3), .RESB(test_wire), .wire_connect_1718(connect_1718), .CON_BUS1(FMakeWire_cspf_wrapper_cspf_mc200_CON_BUS1), 
        .CON_BUS0(FMakeWire_cspf_wrapper_cspf_mc200_CON_BUS0), .CE0(cibc_ce0), .clk_1777(FMakeWire_add_ff_clk_1777), 
        .clk_bus_1777(FMakeWire_add_ff_clk_bus_1777[2:0]), .ff2_Q(cspf_Q3), .PUONOUT(FMakeWire_cspf_wrapper_cspf_mc200_add_ff2_PUONOUT), 
        .CPURSOUTB(FMakeWire_ice_top_SYSRSOUTB), .CLK30MHz(FMakeWire_add_ff_CLK30MHz), .wire002(wire001), 
        .clk(FMakeWire_ice_top_clk_out), .CLK60MHZ(FMakeWire_add_ff_CLK60MHZ));
endmodule 
    
module pulldown_cell_pf (y, x);
    output y;
    output x;
    assign y = 1'b0;
    assign x = 1'b0;
endmodule 
    
module pericore (rst_res_n, peri_o, bg2adsel, AD_O, SVSTOP, cap_out, a1, a0, FF3_O, FMakeWire_svmodif_SVSTOPICE, 
    FMakeWire_add_ff_RESB, FMakeWire_add_ff_VIMDS1, FMakeWire_add_ff_VIMDS0);
    input FMakeWire_add_ff_VIMDS0;
    wire FMakeWire_add_ff_VIMDS0;
    input FMakeWire_add_ff_VIMDS1;
    wire FMakeWire_add_ff_VIMDS1;
    input FMakeWire_add_ff_RESB;
    wire FMakeWire_add_ff_RESB;
    input FMakeWire_svmodif_SVSTOPICE;
    wire FMakeWire_svmodif_SVSTOPICE;
    output FF3_O;
    wire FF3_O;
    input rst_res_n;
    output peri_o;
    input bg2adsel;
    output AD_O;
    input SVSTOP;
    output [1:0] cap_out;
    output a1, a0;
    cap cap (.rst_res_n(rst_res_n), .peri_o(peri_o), .Out1(cap_out[1]), .Out0(cap_out[0]), .A({a1, a0}), 
        .SVSTOP(FMakeWire_svmodif_SVSTOPICE));
    ad ad (.BG2ADSEL(bg2adsel), .O(AD_O));
    m1767_ff3 add_ff (.O(FF3_O), .RESB(FMakeWire_add_ff_RESB), .VIMDS1(FMakeWire_add_ff_VIMDS1), .VIMDS0(FMakeWire_add_ff_VIMDS0));
endmodule 
    
module cap (rst_res_n, peri_o, SVSTOP, Out1, Out0, A);
    input rst_res_n;
    output peri_o;
    input SVSTOP;
    output Out1;
    output Out0;
    output A;
    assign peri_o = rst_res_n;
endmodule 
    
module ad (BG2ADSEL, O);
    input BG2ADSEL;
    output O;
    assign O = BG2ADSEL;
endmodule 
    
module CAP_wrapper (cap_out, CapOut);
    input [1:0] cap_out;
    output CapOut;
    cap_in cap_in (.In1(cap_out[1]), .In0(cap_out[0]), .CapOut(CapOut));
endmodule 
    
module ICE_TOP_test (clk, rst, D, Q, clk_out, D_Bus, test_clk, test_wire, connect_1718, connect_bus_1718_0, 
    connect_bus_1718_1, CE0, A0, A1, A2, clka_1777, SYSRSOUTB, ICECK60M, wire001, X1, a1, a0);
    input clk;
    input rst;
    input D;
    input [3:0] D_Bus;
    input X1;
    output Q;
    output clk_out;
    input test_clk;
    input test_wire;
    input connect_1718;
    input connect_bus_1718_0;
    input connect_bus_1718_1;
    input CE0;
    input A0, A1, A2;
    input clka_1777;
    output SYSRSOUTB;
    input ICECK60M;
    input wire001;
    input a1, a0;
    reg Q;
    assign clk_out = clk;
    assign SYSRSOUTB = clk;
    always @(posedge clk or posedge rst) begin 
        if (rst) Q <= 1'b0;
        else Q <= (((((((((((D & (| D_Bus)) & test_clk) & test_wire) & connect_1718) & connect_bus_1718_0) & 
        connect_bus_1718_1) & CE0) & A0) & A1) & A2) & clka_1777);
    end 
endmodule 
    
module cap_in (In1, In0, CapOut);
    input In1;
    input In0;
    output CapOut;
    assign CapOut = (In1 & In0);
endmodule 
    
module CSPF_wrapper (D, Q, D_Bus_Out, test_clk, test_wire, connect_1718, connect_bus_1718, cibc_ce0, 
    DOUT, addr, rst_res_n, bg2adsel, P80, dummy1, dummy2, SVSTOP, iceck30m, BG2ADSEL, rst, cspf_Q3, fpga_pio, 
    PTTL06, PTTL07, DADATA_Term, PTTL08, RESETB, FMakeWire_cspf_svmodif_SVSTOPICE, FMakeWire_cspf_ocd_SVSTOP, 
    FMakeWire_cspf_mc200_CON_BUS1, FMakeWire_cspf_mc200_CON_BUS0, FMakeWire_cspf_add_ff_clk_1777, FMakeWire_cspf_add_ff_clk_bus_1777, 
    FMakeWire_add_ff_CLK60MHZ, FMakeWire_cspf_mc200_add_ff2_PUONOUT, FMakeWire_ice_top_SYSRSOUTB, FMakeWire_cspf_mc200_add_ff2_clk, 
    FMakeWire_cspf_mc200_add_ff2_CLK60M, FMakeWire_cspf_bus_add_ff_VIMDS1, FMakeWire_cspf_bus_add_ff_VIMDS0);
    output FMakeWire_cspf_bus_add_ff_VIMDS0;
    wire FMakeWire_cspf_bus_add_ff_VIMDS0;
    output FMakeWire_cspf_bus_add_ff_VIMDS1;
    wire FMakeWire_cspf_bus_add_ff_VIMDS1;
    wire rst_res_n;
    input FMakeWire_cspf_mc200_add_ff2_CLK60M;
    wire FMakeWire_cspf_mc200_add_ff2_CLK60M;
    input FMakeWire_cspf_mc200_add_ff2_clk;
    wire FMakeWire_cspf_mc200_add_ff2_clk;
    input FMakeWire_ice_top_SYSRSOUTB;
    wire FMakeWire_ice_top_SYSRSOUTB;
    output FMakeWire_cspf_mc200_add_ff2_PUONOUT;
    wire FMakeWire_cspf_mc200_add_ff2_PUONOUT;
    input FMakeWire_add_ff_CLK60MHZ;
    wire FMakeWire_add_ff_CLK60MHZ;
    input [2:0] FMakeWire_cspf_add_ff_clk_bus_1777;
    wire [2:0] FMakeWire_cspf_add_ff_clk_bus_1777;
    input FMakeWire_cspf_add_ff_clk_1777;
    wire FMakeWire_cspf_add_ff_clk_1777;
    output FMakeWire_cspf_mc200_CON_BUS0;
    wire FMakeWire_cspf_mc200_CON_BUS0;
    output FMakeWire_cspf_mc200_CON_BUS1;
    wire FMakeWire_cspf_mc200_CON_BUS1;
    wire connect_1718;
    wire test_wire;
    output FMakeWire_cspf_ocd_SVSTOP;
    wire FMakeWire_cspf_ocd_SVSTOP;
    input FMakeWire_cspf_svmodif_SVSTOPICE;
    wire FMakeWire_cspf_svmodif_SVSTOPICE;
    output RESETB;
    wire RESETB;
    input PTTL08;
    wire PTTL08;
    wire P80;
    output [1:0] DADATA_Term;
    wire [1:0] DADATA_Term;
    input PTTL07;
    wire PTTL07;
    input PTTL06;
    wire PTTL06;
    output [7:0] fpga_pio;
    wire [7:0] fpga_pio;
    output cspf_Q3;
    wire cspf_Q3;
    wire D;
    input rst;
    wire rst;
    output BG2ADSEL;
    wire BG2ADSEL;
    input D;
    output Q;
    output [3:0] D_Bus_Out;
    output test_clk;
    output test_wire;
    output connect_1718;
    output [1:0] connect_bus_1718;
    output cibc_ce0;
    wire cibc_ce0;
    output DOUT;
    output [2:0] addr;
    output rst_res_n;
    output bg2adsel;
    inout P80;
    output dummy1, dummy2;
    output SVSTOP;
    input iceck30m;
    wire [1:0] da_data;
    CSPF cspf (.Q(Q), .D_Bus_Out(D_Bus_Out), .test_clk(test_clk), .connect_bus_1718(connect_bus_1718), 
        .addr(addr), .rst_res_n(rst_res_n), .dummy1(dummy1), .dummy2(dummy2), .SVSTOP(SVSTOP), .DADATA(da_data), 
        .rst(rst), .D(D), .fpga_pio(fpga_pio[7:0]), .PTTL06(PTTL06), .PTTL07(PTTL07), .P80(P80), .PTTL08(PTTL08), 
        .RESETB(RESETB), .FMakeWire_svmodif_SVSTOPICE(FMakeWire_cspf_svmodif_SVSTOPICE), .FMakeWire_ocd_SVSTOP(FMakeWire_cspf_ocd_SVSTOP), 
        .DADATA_Term(DADATA_Term[1:0]), .test_wire(test_wire), .connect_1718(connect_1718), .FMakeWire_mc200_CON_BUS1(FMakeWire_cspf_mc200_CON_BUS1), 
        .FMakeWire_mc200_CON_BUS0(FMakeWire_cspf_mc200_CON_BUS0), .cibc_ce0(cibc_ce0), .FMakeWire_add_ff_clk_1777(FMakeWire_cspf_add_ff_clk_1777), 
        .FMakeWire_add_ff_clk_bus_1777(FMakeWire_cspf_add_ff_clk_bus_1777[2:0]), .cspf_Q3(cspf_Q3), .FMakeWire_mc200_add_ff2_PUONOUT(FMakeWire_cspf_mc200_add_ff2_PUONOUT), 
        .FMakeWire_mc200_add_ff2_clk(FMakeWire_cspf_mc200_add_ff2_clk), .FMakeWire_mc200_add_ff2_CLK60M(FMakeWire_cspf_mc200_add_ff2_CLK60M), 
        .FMakeWire_bus_add_ff_VIMDS1(FMakeWire_cspf_bus_add_ff_VIMDS1), .FMakeWire_bus_add_ff_VIMDS0(FMakeWire_cspf_bus_add_ff_VIMDS0));
    flash_code flash_code (.CE0(cibc_ce0), .DOUT(DOUT), .A0(addr[0]), .A1(addr[1]), .A2(addr[2]), .bg2adsel(bg2adsel), 
        .mod_scanen(mod_scanen), .BG2ADSEL(BG2ADSEL), .SCANCLK(1'b0), .ICECK60M(FMakeWire_add_ff_CLK60MHZ), 
        .rst_sysrsout_n(FMakeWire_ice_top_SYSRSOUTB), .rst_res_n(rst_res_n));
    da_ICE da (.da_data(DADATA_Term[1:0]));
endmodule 
    
module flash_code (CE0, DOUT, A0, A1, A2, ICECK60M, rst_sysrsout_n, rst_res_n, bg2adsel, SCANCLK, mod_scanen, 
    BG2ADSEL);
    wire rst_res_n;
    output BG2ADSEL;
    wire BG2ADSEL;
    input CE0;
    output DOUT;
    input A0, A1, A2;
    input ICECK60M;
    input rst_sysrsout_n;
    output rst_res_n;
    output bg2adsel;
    input SCANCLK;
    output mod_scanen;
    assign DOUT = (((((CE0 & A0) & A1) & A2) & ICECK60M) & rst_sysrsout_n);
    assign RESB = A0;
    dummyOut dOut (.BG2ADSEL(BG2ADSEL), .RESB(rst_res_n));
endmodule 
    
module dummyOut (RESB, BG2ADSEL);
    output RESB;
    output BG2ADSEL;
endmodule 
    
module CSPF (D, Q, D_Bus_Out, test_clk, test_wire, connect_1718, connect_bus_1718, cibc_ce0, addr, rst_res_n, 
    P80, dummy1, dummy2, SVSTOP, DADATA, rst, cspf_Q3, fpga_pio, PTTL06, PTTL07, DADATA_Term, PTTL08, 
    RESETB, FMakeWire_svmodif_SVSTOPICE, FMakeWire_ocd_SVSTOP, FMakeWire_mc200_CON_BUS1, FMakeWire_mc200_CON_BUS0, 
    FMakeWire_add_ff_clk_1777, FMakeWire_add_ff_clk_bus_1777, FMakeWire_mc200_add_ff2_PUONOUT, FMakeWire_mc200_add_ff2_clk, 
    FMakeWire_mc200_add_ff2_CLK60M, FMakeWire_bus_add_ff_VIMDS1, FMakeWire_bus_add_ff_VIMDS0);
    output FMakeWire_bus_add_ff_VIMDS0;
    wire FMakeWire_bus_add_ff_VIMDS0;
    output FMakeWire_bus_add_ff_VIMDS1;
    wire FMakeWire_bus_add_ff_VIMDS1;
    input FMakeWire_mc200_add_ff2_CLK60M;
    wire FMakeWire_mc200_add_ff2_CLK60M;
    input FMakeWire_mc200_add_ff2_clk;
    wire FMakeWire_mc200_add_ff2_clk;
    output FMakeWire_mc200_add_ff2_PUONOUT;
    wire FMakeWire_mc200_add_ff2_PUONOUT;
    input [2:0] FMakeWire_add_ff_clk_bus_1777;
    wire [2:0] FMakeWire_add_ff_clk_bus_1777;
    input FMakeWire_add_ff_clk_1777;
    wire FMakeWire_add_ff_clk_1777;
    wire cibc_ce0;
    output FMakeWire_mc200_CON_BUS0;
    wire FMakeWire_mc200_CON_BUS0;
    output FMakeWire_mc200_CON_BUS1;
    wire FMakeWire_mc200_CON_BUS1;
    wire connect_1718;
    wire test_wire;
    output FMakeWire_ocd_SVSTOP;
    wire FMakeWire_ocd_SVSTOP;
    input FMakeWire_svmodif_SVSTOPICE;
    wire FMakeWire_svmodif_SVSTOPICE;
    output RESETB;
    wire RESETB;
    input PTTL08;
    wire PTTL08;
    wire P80;
    output [1:0] DADATA_Term;
    wire [1:0] DADATA_Term;
    input PTTL07;
    wire PTTL07;
    input PTTL06;
    wire PTTL06;
    output [7:0] fpga_pio;
    wire [7:0] fpga_pio;
    output cspf_Q3;
    wire cspf_Q3;
    wire D;
    input rst;
    wire rst;
    input D;
    output Q;
    output [3:0] D_Bus_Out;
    output test_clk;
    output test_wire;
    output connect_1718;
    output [1:0] connect_bus_1718;
    output cibc_ce0;
    output [2:0] addr;
    input rst_res_n;
    inout P80;
    output dummy1, dummy2;
    output SVSTOP;
    output [1:0] DADATA;
    wire [1:0] vimds;
    MC200 mc200 (.Q(Q), .test_clk(test_clk), .reset_b(reset_b), .DADATA(DADATA), .rst(rst), .D(D), .fpga_pio(fpga_pio[7:0]), 
        .PTTL06(PTTL06), .PTTL07(PTTL07), .P80(P80), .PTTL08(PTTL08), .RESETB(RESETB), .DADATA_Term(DADATA_Term[1:0]), 
        .test_wire(test_wire), .wire_1718(connect_1718), .CON_BUS1(FMakeWire_mc200_CON_BUS1), .CON_BUS0(FMakeWire_mc200_CON_BUS0), 
        .cspf_Q3(cspf_Q3), .FMakeWire_add_ff2_PUONOUT(FMakeWire_mc200_add_ff2_PUONOUT), .FMakeWire_add_ff2_clk(FMakeWire_mc200_add_ff2_clk), 
        .FMakeWire_add_ff2_CLK60M(FMakeWire_mc200_add_ff2_CLK60M), .VIMDS1(FMakeWire_bus_add_ff_VIMDS1), 
        .VIMDS0(FMakeWire_bus_add_ff_VIMDS0));
    BUS bus (.test_clk(test_clk), .D3(D_Bus_Out[3]), .D2(D_Bus_Out[2]), .D1(D_Bus_Out[1]), .D0(D_Bus_Out[0]), 
        .wire_1718(connect_1718), .A0(addr[0]), .A1(addr[1]), .A2(addr[2]), .rst_res_n(rst_res_n), .RESETB(RESETB), 
        .CON_BUS1(FMakeWire_mc200_CON_BUS1), .CON_BUS0(FMakeWire_mc200_CON_BUS0), .CE0(cibc_ce0), .clkb_1777(FMakeWire_add_ff_clk_1777), 
        .clkb_bus_1777(FMakeWire_add_ff_clk_bus_1777), .VIMDS1(FMakeWire_bus_add_ff_VIMDS1), .VIMDS0(FMakeWire_bus_add_ff_VIMDS0));
    OCD ocd (.dummy(D), .SVSTOP(FMakeWire_ocd_SVSTOP));
    CPU cpu (.dummy(dummy1), .SVSTOP(FMakeWire_svmodif_SVSTOPICE));
    DMA dma (.dummy(dummy2), .SVSTOP(FMakeWire_svmodif_SVSTOPICE));
endmodule 
    
module OCD (SVSTOP, dummy);
    input dummy;
    output SVSTOP;
    assign SVSTOP = dummy;
endmodule 
    
module CPU (SVSTOP, dummy);
    input SVSTOP;
    output dummy;
    assign dummy = SVSTOP;
endmodule 
    
module DMA (SVSTOP, dummy);
    input SVSTOP;
    output dummy;
    assign dummy = SVSTOP;
endmodule 
    
module BUS (test_clk, D3, D2, D1, D0, wire_1718, CON_BUS1, CON_BUS0, CE0, A0, A1, A2, clkb_1777, clkb_bus_1777, 
    RESETB, rst_res_n, VIMDS1, VIMDS0);
    input test_clk;
    output D3, D2, D1, D0;
    input wire_1718;
    input CON_BUS1;
    input CON_BUS0;
    output CE0;
    output A0, A1, A2;
    input clkb_1777;
    input [2:0] clkb_bus_1777;
    input RESETB;
    input rst_res_n;
    output VIMDS1, VIMDS0;
    assign D3 = test_clk;
    assign D2 = wire_1718;
    assign D1 = CON_BUS1;
    assign D0 = CON_BUS0;
    assign CE0 = wire_1718;
    assign A0 = wire_1718;
    assign A1 = wire_1718;
    assign A2 = (((clkb_1777 & (^ clkb_bus_1777)) & RESETB) & rst_res_n);
    assign VIMDS1 = rst_res_n;
    assign VIMDS0 = rst_res_n;
endmodule 
    
module MC200 (D, Q, test_clk, test_wire, wire_1718, CON_BUS1, CON_BUS0, reset_b, P80, DADATA, VIMDS1, 
    VIMDS0, rst, cspf_Q3, fpga_pio, PTTL06, PTTL07, DADATA_Term, PTTL08, RESETB, FMakeWire_add_ff2_PUONOUT, 
    FMakeWire_add_ff2_clk, FMakeWire_add_ff2_CLK60M);
    input FMakeWire_add_ff2_CLK60M;
    wire FMakeWire_add_ff2_CLK60M;
    input FMakeWire_add_ff2_clk;
    wire FMakeWire_add_ff2_clk;
    output FMakeWire_add_ff2_PUONOUT;
    wire FMakeWire_add_ff2_PUONOUT;
    output RESETB;
    wire RESETB;
    input PTTL08;
    wire PTTL08;
    wire P80;
    output [1:0] DADATA_Term;
    wire [1:0] DADATA_Term;
    input PTTL07;
    wire PTTL07;
    input PTTL06;
    wire PTTL06;
    output [7:0] fpga_pio;
    wire [7:0] fpga_pio;
    output cspf_Q3;
    wire cspf_Q3;
    wire D;
    input rst;
    wire rst;
    input D;
    output Q;
    output test_clk;
    output test_wire;
    output wire_1718;
    output CON_BUS1;
    output CON_BUS0;
    output reset_b;
    inout P80;
    output [1:0] DADATA;
    input VIMDS1, VIMDS0;
    wire out;
    assign Q = D;
    assign test_clk = D;
    assign test_wire = D;
    assign wire_1718 = D;
    assign CON_BUS1 = D;
    assign CON_BUS0 = D;
    Dummy dummy (.PUONOUT(), .I(out));
    port7 port7 (.O(out), .PTTL(PTTL07), .rstb(RESETB), .DADATA(DADATA_Term));
    port8_ICE port8 (.SPAD(P80), .PTTL(P80), .PTTL2(PTTL08), .rst_b(RESETB));
    add_ff2 add_ff2 (.OUT_OPEN(), .NoConnectInPin(), .ADINLP5V(), .rst(rst), .D(D), .FixedPin_Single(1'b0), 
        .FixedPin_Bus(3'b111), .fpga_pio(fpga_pio[7:0]), .PTTL(PTTL06), .Q3(cspf_Q3), .PUONOUT(FMakeWire_add_ff2_PUONOUT), 
        .clk(FMakeWire_add_ff2_clk), .CLK60M(FMakeWire_add_ff2_CLK60M));
endmodule 
    
module Dummy (PUONOUT, I);
    inout PUONOUT;
    input I;
endmodule 
    
module port7 (O, PTTL, rstb, DADATA);
    output O;
    input PTTL;
    input rstb;
    output [1:0] DADATA;
    assign O = (PTTL & rstb);
endmodule 
