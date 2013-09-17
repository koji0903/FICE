module TOP();
   wire pull_down000;
   wire pull_down001;
   
   SubA sub0(pull_down000);
   TBCLL pulldown0(pull_down000);
   
   SubA sub1(.In(pull_down001));
   TBCLL pulldown1(.Out(pull_down001));

endmodule // TOP

module SubA(In);
   input In;
endmodule // SubA

module TBCLL(Out);
   output Out;
   assign Out = 1'b0;   
endmodule // TBCLH
