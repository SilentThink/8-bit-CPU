// MAR.v
module MAR(
input wire CLK,
input wire [7:0] D,
input wire IMARn,
output wire [7:0] ABUS);

wire [7:0] D377,Q377;
assign D377 = D;
assign ABUS = Q377;

LS377 u0(
    .CLK(CLK),
    .D(D377),
    .EN(IMARn),
    .Q(Q377)
);
endmodule
