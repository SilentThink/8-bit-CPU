module ALU(
input ISUMn,    // ¼Ó·¨
input ISUBn,    // ¼õ·¨
input IMULn,    // ³Ë·¨
input IDIVn,    // ³ý·¨
input ISHLn,    // Âß¼­×óÒÆ
input ISHRn,    // Âß¼­ÓÒÒÆ
input An,
input Bn,

input [7:0] DinA,
input [7:0] DinB,
input [7:0] Din,
output reg [7:0] Dout);

wire [7:0] num1,num2;
assign num1 = (~An)?DinA:DinB;
assign num2 = Din;

wire [7:0] Dout_add,Dout_sub,Dout_mul,Dout_div,Dout_lshift,Dout_rshift;
always @(*) begin
    if(ISUMn==0) Dout <= Dout_add;
    else if (ISUBn==0) Dout <= Dout_sub;
    else if (IMULn==0) Dout <= Dout_mul;
    else if (IDIVn==0) Dout <= Dout_div;
    else if (ISHLn==0) Dout <= Dout_lshift;
    else if (ISHRn==0) Dout <= Dout_rshift;
    else Dout <= 8'h00;
end
// adder
adder u1(
    .a(num1),
    .b(num2),
    .sum(Dout_add)
);
// subtractor
subtractor u2(
    .a(num1),
    .b(num2),
    .diff(Dout_sub)
);
// multiplier
multiplier u3(
    .a(num1),
    .b(num2),
    .product(Dout_mul)
);
// divider
divider u4(
    .a(num1),
    .b(num2),
    .quotient(Dout_div)
);
// logical left shift
left_shifter u5(
    .a(num1),
    .shift_amount(num2[3:0]),
    .shifted(Dout_lshift)
);
// logical right shift
right_shifter u6(
    .a(num1),
    .shift_amount(num2[3:0]),
    .shifted(Dout_rshift)
);

endmodule
