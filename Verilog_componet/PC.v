// ���������
module PC(
    input wire CLK,
    input wire IPC,
    input wire LDn,
    input wire [7:0] D,
    input wire CLRn,
    output wire [7:0] Q
    );
    wire [3:0] Q1, Q2;   // �ֱ��ʾ��4λ�͸�4λ
    wire RCO1;           // ��һ�� LS161 �Ľ�λ�ź�

    // ��� Q �Ǹ�λ�͵�λ�����
    assign Q = {Q2, Q1};

    // ��4λ������
    LS161 u0 (
        .CLK(CLK),
        .CLRn(CLRn),
        .LDn(LDn),
        .D(D[3:0]),      // ��4λ����
        .ENP(IPC),       // ʹ��
        .ENT(IPC),       // ʹ�ܼ���
        .Q(Q1),          // �����4λ
        .RCO(RCO1)       // ��λ��λ�ź�
    );

    // ��4λ������
    LS161 u1 (
        .CLK(CLK),
        .CLRn(CLRn),
        .LDn(LDn),
        .D(D[7:4]),      // ��4λ����
        .ENP(IPC),       // ��λ����ͬ��ʹ��
        .ENT(RCO1),      // �ɵ�λ�Ľ�λ�źž����Ƿ����
        .Q(Q2),          // �����4λ
        .RCO()           // ��λ�Ľ�λ�źſ��Ժ��ԣ���Ϊֻ��Ҫ8λ����
    );

endmodule
