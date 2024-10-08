`timescale 1ns / 1ps
module SR_tb;
reg CLK,ISUMn,ISUBn,IMULn,IDIVn,ISHLn,ISHRn,ESRn;
reg [7:0] Dsrin;
wire [7:0] Dout;

SR DUT(
    .CLK(CLK),
   .ISUMn(ISUMn),
   .ISUBn(ISUBn),
   .IMULn(IMULn),
   .IDIVn(IDIVn),
   .ISHLn(ISHLn),
   .ISHRn(ISHRn),
   .ESRn(ESRn),
   .Dsrin(Dsrin),
   .Dout(Dout)
);
initial begin
    CLK = 0;
    ISUMn = 0;
    ISUBn = 1;
    IMULn = 1;
    IDIVn = 1;
    ISHLn = 1;
    ISHRn = 1;
    ESRn = 1;
    Dsrin = 8'h07;
    #55
    ESRn = 0;
    Dsrin = 8'h04;
    #50
    ISUMn = 1;
    ISUBn = 0;
    ESRn = 1;
    Dsrin = 8'h08;
    #50
    ESRn = 0;
    Dsrin = 8'h04;
    #45
    ISUBn = 1;
    ESRn = 1;
    Dsrin = 8'h09;
end

always #10 CLK = ~CLK;

initial begin
    #1000 $finish;
end
endmodule
