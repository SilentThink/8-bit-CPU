`timescale 1ns / 1ps
module IR_tb;
reg CLK,IIRn;
reg [7:0] Din;
wire LD_A,LD_B,ADD_A,ADD_B,ADD_AB,ADD_BA,
    SUB_A,SUB_B,SUB_AB,SUB_BA,
    MUL_A,MUL_B,MUL_AB,MUL_BA,
    DIV_A,DIV_B,DIV_AB,DIV_BA,
    SHL_A,SHL_B,SHL_AB,SHL_BA,
    SHR_A,SHR_B,SHR_AB,SHR_BA,
    ST,JMP,HALT;

IR DUT(
    .CLK(CLK),
    .IIRn(IIRn),
    .Din(Din),
    .LD_A(LD_A),
    .LD_B(LD_B),
    .ADD_A(ADD_A),
    .ADD_B(ADD_B),
    .ADD_AB(ADD_AB),
    .ADD_BA(ADD_BA),
    .SUB_A(SUB_A),
    .SUB_B(SUB_B),
    .SUB_AB(SUB_AB),
    .SUB_BA(SUB_BA),
    .MUL_A(MUL_A),
    .MUL_B(MUL_B),
    .MUL_AB(MUL_AB),
    .MUL_BA(MUL_BA),
    .DIV_A(DIV_A),
    .DIV_B(DIV_B),
    .DIV_AB(DIV_AB),
    .DIV_BA(DIV_BA),
    .SHL_A(SHL_A),
    .SHL_B(SHL_B),
    .SHL_AB(SHL_AB),
    .SHL_BA(SHL_BA),
    .SHR_A(SHR_A),
    .SHR_B(SHR_B),
    .SHR_AB(SHR_AB),
    .SHR_BA(SHR_BA),
    .ST(ST),
    .JMP(JMP),
    .HALT(HALT)
);

initial begin
    CLK = 0;
    IIRn = 0;
    Din = 8'h90;
    #40 Din = 8'h91;
    #40 Din = 8'h92;
    #40 Din = 8'h93;
    #40 Din = 8'h94;
    #40 Din = 8'h95;
    #40 Din = 8'h96;
    #40 Din = 8'h97;
    #40 Din = 8'h98;
    #40 Din = 8'h99;
    #40 Din = 8'h9a;
    #40 Din = 8'h9b;
    #40 Din = 8'h9c;
    #40 Din = 8'h9d;
    #40 Din = 8'h9e;
    #40 Din = 8'h9f;
    #40 Din = 8'ha0;
    #40 Din = 8'ha1;
    #40 Din = 8'ha2;
    #40 Din = 8'ha3;
    #40 Din = 8'ha4;
    #40 Din = 8'ha5;
    #40 Din = 8'ha6;
    #40 Din = 8'ha7;
    #40 Din = 8'ha8;
    #40 Din = 8'ha9;
    #40 Din = 8'hc0;
    #40 Din = 8'hc1;
    #40 Din = 8'hff;
end

always #10 CLK = ~CLK;

initial begin
    #500 $stop;
end
endmodule
