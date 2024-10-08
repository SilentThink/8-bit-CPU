module DR(
input wire CLK,
input wire EDR,
input wire EAR,
input wire ECR,
input wire IDR,
input wire [7:0] DBUS,
output wire [7:0] dbus,
output wire [7:0] cbus,
output wire [7:0] abus
);

wire LE;
assign LE = CLK&IDR;

LS373 u0(
    .LE(LE&(~DBUS[7])),
    .OEn(EDR),
    .D(DBUS),
    .Q(dbus)
);

LS373 u1(
    .LE(LE&DBUS[7]),
    .OEn(ECR),
    .D(DBUS),
    .Q(cbus)
);

LS373 u2(
    .LE(LE),
    .OEn(~EAR),
    .D(DBUS),
    .Q(abus)
);

//LS373 u0(
//    .LE(LE&(DBUS<=8'b00001111)),
//    .OEn(EDR),
//    .D(DBUS),
//    .Q(dbus)
//);

//LS373 u1(
//    .LE(LE&(DBUS>8'b00001111)),
//    .OEn(0),
//    .D(DBUS),
//    .Q(cbus)
//);



endmodule
