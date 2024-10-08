// 8位D触发器
module LS377(
    input wire CLK,         // 时钟信号
    input wire EN,          // 使能信号
    input wire [7:0] D,     // 8-bit 数据输入
    output reg [7:0] Q      // 8-bit 数据输出
);
    always @(posedge CLK) begin
        if (~EN) begin
            Q <= D;         // 如果使能信号有效，在时钟上升沿将D数据锁存到Q输出
        end
    end

endmodule
