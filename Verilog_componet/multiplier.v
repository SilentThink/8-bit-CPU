// 8Î»³Ë·¨Æ÷
module multiplier(
    input [7:0] a,
    input [7:0] b,
    output [7:0] product
    );
    wire [15:0] result;
    assign result = a*b;
    assign product = result[7:0];
endmodule
