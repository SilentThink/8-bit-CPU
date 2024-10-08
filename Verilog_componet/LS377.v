// 8λD������
module LS377(
    input wire CLK,         // ʱ���ź�
    input wire EN,          // ʹ���ź�
    input wire [7:0] D,     // 8-bit ��������
    output reg [7:0] Q      // 8-bit �������
);
    always @(posedge CLK) begin
        if (~EN) begin
            Q <= D;         // ���ʹ���ź���Ч����ʱ�������ؽ�D�������浽Q���
        end
    end

endmodule
