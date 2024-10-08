`timescale 1ns / 1ps

module ALU_tb;
reg ISUMn,ISUBn,IMULn,IDIVn,ISHLn,ISHRn;
reg An,Bn;
reg [7:0] DinA,DinB,Din;
wire [7:0] Dout;

ALU DUT(
    .ISUMn(ISUMn),
    .ISUBn(ISUBn),
    .IMULn(IMULn),
    .IDIVn(IDIVn),
    .ISHLn(ISHLn),
    .ISHRn(ISHRn),
    .An(An),
    .Bn(Bn),
    .DinA(DinA),
    .DinB(DinB),
    .Din(Din),
    .Dout(Dout)
);

initial begin
    ISUMn = 0;
    ISUBn = 1;
    IMULn = 1;
    IDIVn = 1;
    ISHLn = 1;
    ISHRn = 1;
    An = 0;
    Bn = 1;
    DinA = 8'h07;
    DinB = 8'h00;
    Din = 8'h06;
    #10 
    An = 1;
    Bn = 0;
    DinB = 8'h04;
    Din = 8'h02;
    #10
    DinB = 8'h08;
    Din = 8'h05;
    ISUBn = 0;
    ISUMn = 1;
    #10
    DinB = 8'h04;
    Din = 8'h00;
    #10
    DinB = 8'h09;
    Din = 8'h03;
    IDIVn = 0;
    ISUBn =1;
    #10
    DinB = 8'h08;
    Din = 8'h02;
    ISHRn = 0;
    IDIVn = 1;
    
    #10
    ISHLn = 0;
    ISHRn = 1;
    
    #10
    $finish;
end

endmodule
