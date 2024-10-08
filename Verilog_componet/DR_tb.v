`timescale 1ns/1ps

module DR_tb;
reg [7:0] DBUS;
reg CLK,EDR,EAR,ECR,IDR;
wire [7:0] dbus,abus,cbus;

DR DUT(
    .CLK(CLK),
    .DBUS(DBUS),
    .EDR(EDR),
    .EAR(~EAR),
    .ECR(ECR),
    .IDR(IDR),
    .dbus(dbus),
    .abus(abus),
    .cbus(cbus)
);
initial begin
    CLK = 1'b0;
    IDR = 1'b1;
    EDR = 1'b1;
    EAR = 1;
    ECR = 1;
    DBUS = 8'h00;
    #25 DBUS = 8'h07;
    #20 DBUS = 8'h05;
    #20 DBUS = 8'h76;
    #20 DBUS = 8'hc0;
    #20 DBUS = 8'h80;
end

initial begin
    #40 EDR = 1'b0;
    #20 EDR = 1;EAR = 0;
    #20 EAR = 1;ECR = 0;
    #20 ECR = 1;EDR = 0;
    #20 EDR = 1;
end

always #10 CLK = ~CLK;

initial begin
    #1000 $finish;
end
endmodule
