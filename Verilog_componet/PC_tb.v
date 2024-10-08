`timescale 1ns/1ps

module PC_tb;
reg CLK,CLRn,LDn,IPC;
reg [7:0] D;
wire [7:0] Q;

PC DUT(
    .CLK(CLK),
    .CLRn(CLRn),
    .LDn(LDn),
    .IPC(IPC),
    .D(D),
    .Q(Q)
);
initial begin
    CLK = 1'b0;
    CLRn = 1'b1;
    LDn = 1'b1;
    IPC = 1'b1;
    D = 8'b00001111;
    #5 CLRn = 1'b0;
    #15 CLRn = 1'b1;
    #100 LDn = 1'b0;
    #20 LDn = 1'b1;
end

always #10 CLK = ~CLK;

initial begin
    #1000 $finish;
end
endmodule