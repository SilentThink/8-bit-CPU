// ����ģ��
module left_shifter(
    input [7:0] a,
    input [2:0] shift_amount, // ����λ��
    output [7:0] shifted
);
    assign shifted = a << shift_amount;
endmodule