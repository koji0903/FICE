module svmodif2(SVSTOP,SVSTOPICE,CPUWR,ADCHSEL1,ADCHSEL0);
   output SVSTOP;
   input SVSTOPICE;
   input CPUWR;
   input ADCHSEL1;
   input ADCHSEL0;
   
   assign SVSTOP = SVSTOPICE;   
endmodule