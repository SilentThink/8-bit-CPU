`timescale 1ns / 1ps

module ACC_tb;
reg CLK,IAn,EAn,IBn,EBn;
reg [7:0] DinA;
wire [7:0] QA,QB,Dout;

ACC DUT(
    .CLK(CLK),
    .IAn(IAn),
    .EAn(EAn),
    .IBn(IBn),
    .EBn(EBn),
    .DinA(DinA),
    .QA(QA),
    .QB(QB),
    .Dout(Dout)
);

initial begin
    CLK = 1'b0;
    IAn = 1'b0;
    EAn = 1'b1;
    IBn = 1'b1;
    EBn = 1'b1;
    DinA = 8'h07;
end

initial begin
    #65 
    IAn = 1'b1;
    EAn = 1'b0;
    IBn = 1'b0;
    DinA = 8'h06;
    #70
    IAn = 1'b0;
    EAn = 1'b1;
    IBn = 1'b1;
    EBn = 1'b0;
    DinA = 8'h05;
    #65
    IAn = 1'b1;
    EAn = 1'b1;
    IBn = 1'b1;
    EBn = 1'b1;
    DinA = 8'h04;
end

always #10 CLK = ~CLK;

initial begin
    #1000 $finish;
end
endmodule
