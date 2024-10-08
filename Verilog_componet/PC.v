// 程序计数器
module PC(
    input wire CLK,
    input wire IPC,
    input wire LDn,
    input wire [7:0] D,
    input wire CLRn,
    output wire [7:0] Q
    );
    wire [3:0] Q1, Q2;   // 分别表示低4位和高4位
    wire RCO1;           // 第一块 LS161 的进位信号

    // 输出 Q 是高位和低位的组合
    assign Q = {Q2, Q1};

    // 低4位计数器
    LS161 u0 (
        .CLK(CLK),
        .CLRn(CLRn),
        .LDn(LDn),
        .D(D[3:0]),      // 低4位输入
        .ENP(IPC),       // 使能
        .ENT(IPC),       // 使能计数
        .Q(Q1),          // 输出低4位
        .RCO(RCO1)       // 低位进位信号
    );

    // 高4位计数器
    LS161 u1 (
        .CLK(CLK),
        .CLRn(CLRn),
        .LDn(LDn),
        .D(D[7:4]),      // 高4位输入
        .ENP(IPC),       // 高位部分同样使能
        .ENT(RCO1),      // 由低位的进位信号决定是否递增
        .Q(Q2),          // 输出高4位
        .RCO()           // 高位的进位信号可以忽略，因为只需要8位计数
    );

endmodule
