`timescale 1ns / 1ps
module pulse_tb;

reg CLK,CLRn;
wire T0,T1,T2,T3,T4,T5,T6,T7;

pulse dut(
   .CLK(CLK),
   .CLRn(CLRn),
   .T0(T0),
   .T1(T1),
   .T2(T2),
   .T3(T3),
   .T4(T4),
   .T5(T5),
   .T6(T6),
   .T7(T7)
    );

initial begin
    CLK = 0;
    CLRn = 0;
    #10 CLRn = 1;
    forever #10 CLK = ~CLK;
    #500 $finish;
end
endmodule
