`timescale 1ns / 1ps

module MAR_tb;
reg CLK,IMARn;
reg [2:0] D;
wire [2:0] ABUS;

MAR DUT(
    .CLK(CLK),
    .IMARn(IMARn),
    .D(D),
    .ABUS(ABUS)
);

initial begin
    CLK = 1'b0;
    IMARn = 1'b1;
    D = 3'b000;
    #95 IMARn = 1'b0;
    #100 IMARn = 1'b1; 
end

initial begin
    #80 D = 3'b001;
    #20 D = 3'b010;
    #20 D = 3'b011;
    #20 D = 3'b100;
    #20 D = 3'b101;
    #20 D = 3'b110;
end

always #10 CLK = ~CLK;

initial begin
    #500 $stop;
end
endmodule
