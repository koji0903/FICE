// Generated by XMLtoVerilog 1.2.6 at Undefined
/* [FromXML] xml version="1.0" encoding="UTF-8"*/
/* [FromXML] Generated by VerilogToXML 1.4.0 at 2012-01-24 11:28:36 */
/* [FromXML] included ".//home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk/test/FMake/tp/test_s.v" */
    
module test (CLK, RST, SEL, DIN, DIN2, DOUT, SELOUT, IO_PORT1, IO_PORT2);
    wire FMakeWire_drive_change_a_a;
    wire FMakeWire_drive_change_c_b;
    input CLK, CLK2;
    input RST;
    input SEL;
    input [3:0] DIN, DIN2;
    output [3:0] DOUT;
    output SELOUT;
    inout IO_PORT1;
    inout [8:0] IO_PORT2;
    reg reg001, reg002;
    reg [100:0] reg003, reg004;
    reg [3:0] DOUT_reg;
    reg [7:0] mem001[15:0];
    assign DOUT = DOUT_reg;
    wire wire001;
    wire [3:0] wire002, wire003;
    wire SEL_w, CLK_w;
    Buffer buf0 (.a({SEL, DIN2[0], DIN2[2:1]}), .b(SEL_w));
    Buffer buf1 (.a({SEL, DIN2[1:0], DIN2[2]}), .b(SEL_w));
    Buffer buf2 (.a(DIN2[1:0]), .b(SEL_w));
    Buffer buf3 (.a(DIN3[2]), .b(SEL_w));
    SubMod sub0 (.a(1'b1), .b(wire002), .c(wire001), .d(SEL_w));
    wire drive_change_original;
    DriveChangeA drive_change_a (.a(FMakeWire_drive_change_a_a));
    DriveChangeB drive_change_b (.a(FMakeWire_drive_change_c_b));
    DriveChangeC drive_change_c (.b(FMakeWire_drive_change_c_b), .a(FMakeWire_drive_change_a_a));
    assign CLK_w = CLK;
    always @(posedge CLK_w or negedge RST) begin 
        if ((~ RST)) begin 
            DOUT_reg <= 4'h0;
        end 
        else if (SEL_w) begin 
            DOUT_reg <= DIN;
        end 
        else begin 
            DOUT_reg <= (DOUT_reg + 1'b1);
        end 
    end 
endmodule 
    
module Buffer (a, b);
    input [3:0] a;
    output b;
    assign b = (^ a);
endmodule 
    
module SubMod (aaa, b, c, d);
    input aaa;
    input [3:0] b;
    wire drive_change_original;
    output c;
    output d;
    wire drive_change_original;
    DriveChangeA drive_change_a1 (.a(drive_change_original));
    DriveChangeB drive_change_b1 (.a(drive_change_original));
    DriveChangeC drive_change_c1 (.a(1'b1), .b());
    DriveChangeC drive_change_c2 (.a(1'b1), .b());
endmodule 
    
module DriveChangeA (a);
    output a;
    Buffer buf001 (.a(1'b1), .b());
endmodule 
    
module DriveChangeB (a);
    input a;
endmodule 
    
module DriveChangeC (a, b);
    input a;
    output b;
endmodule 