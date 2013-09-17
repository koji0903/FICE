module TOP();
   PERICORE pericore(.p12_eni2());   
endmodule // TOP

module PERICORE(p12_eni2);
   output p12_eni2;   
//   wire p12eni_2,p12_eni1,p12_eni0;
   
   P12 p12(.eni({p12eni_2,p12eni_1,p12_eni0}));
   P12_IOBUF p12_iobuf(.eni({p12eni_2,p12eni_1,p12_eni0}));   
endmodule // PERICORE

module P12(eni);
   output [2:0] eni;   
endmodule // PORTTOP

module P12_IOBUF(eni);
   input [2:0] eni;   
endmodule // P12
