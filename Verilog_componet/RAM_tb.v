`timescale 1ns / 1ps

module RAM_tb;
reg CLK,WR,CS;
reg [7:0] DIN;
reg [7:0] ADDR;
wire [7:0] DOUT;

RAM DUT(
    .CLK(CLK),
    .WR(WR),
    .CS(CS),
    .DIN(DIN),
    .ADDR(ADDR),
    .DOUT(DOUT)
);

initial begin
    CLK = 1'b0;
    CS = 1'b1;
    WR = 1'b1;
    ADDR = 8'b00000000;
    DIN = 8'b00001111;
    #20
    CS = 1'b0;
    #20
    ADDR = 8'b00000010;
    #20
    WR = 1'b0;
    #50
    WR = 1'b1;
end

always #10 CLK = ~CLK;

initial begin
    #500 $stop;
end
endmodule
