// ³ý·¨Æ÷Ä£¿é
module divider(
    input [7:0] a,
    input [7:0] b,
    output [7:0] quotient
);
    assign quotient = a / b;
endmodule