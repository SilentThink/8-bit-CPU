module LS373 (
    input wire [7:0] D,     // 8λ��������
    input wire LE,          // ����ʹ���ź�
    input wire OEn,         // ���ʹ���źţ��͵�ƽ��Ч
    output reg [7:0] Q      // 8λ�������
);

reg [7:0] latch;  // �ڲ��Ĵ���������������

// �������ݹ���
always @(posedge LE) begin
    latch <= D;  // ��LEΪ�ߵ�ƽʱ��������������D��latch�Ĵ���
end

// ������ƹ���
always @(*) begin
    if (~OEn)
        Q = latch;  // ��OEnΪ�͵�ƽʱ��������������
    else
        Q = 8'hzz;   // ��OEnΪ�ߵ�ƽʱ���������̬
end

endmodule

