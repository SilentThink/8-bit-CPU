module LS377ir(
    input wire CLK,         // ʱ���ź�
    input wire EN,          // ʹ���ź�
    input wire [7:0] D,     // 8-bit ��������
    output reg Q7=0,Q6=0,Q5=0,Q4=0,Q3=0,Q2=0,Q1=0,Q0=0   // 8-bit �������
    );

    always @(posedge CLK) begin
        if (~EN) begin
            {Q7,Q6,Q5,Q4,Q3,Q2,Q1,Q0} <= D;         // ���ʹ���ź���Ч����ʱ�������ؽ�D�������浽Q���
        end
    end
endmodule
