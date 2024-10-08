module LS377ir(
    input wire CLK,         // 时钟信号
    input wire EN,          // 使能信号
    input wire [7:0] D,     // 8-bit 数据输入
    output reg Q7=0,Q6=0,Q5=0,Q4=0,Q3=0,Q2=0,Q1=0,Q0=0   // 8-bit 数据输出
    );

    always @(posedge CLK) begin
        if (~EN) begin
            {Q7,Q6,Q5,Q4,Q3,Q2,Q1,Q0} <= D;         // 如果使能信号有效，在时钟上升沿将D数据锁存到Q输出
        end
    end
endmodule
