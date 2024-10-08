module LS373 (
    input wire [7:0] D,     // 8位数据输入
    input wire LE,          // 锁存使能信号
    input wire OEn,         // 输出使能信号，低电平有效
    output reg [7:0] Q      // 8位数据输出
);

reg [7:0] latch;  // 内部寄存器用于锁存数据

// 锁存数据过程
always @(posedge LE) begin
    latch <= D;  // 当LE为高电平时，锁存输入数据D到latch寄存器
end

// 输出控制过程
always @(*) begin
    if (~OEn)
        Q = latch;  // 当OEn为低电平时，输出锁存的数据
    else
        Q = 8'hzz;   // 当OEn为高电平时，输出高阻态
end

endmodule

