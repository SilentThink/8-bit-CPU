module LS244 (
    input wire [3:0] A,     // 第一个4位输入
    input wire [3:0] B,     // 第二个4位输入
    input wire GAn,         // 第一个缓冲器使能信号，低电平有效
    input wire GBn,         // 第二个缓冲器使能信号，低电平有效
    output reg [3:0] YA,    // 第一个4位输出
    output reg [3:0] YB     // 第二个4位输出
);

// YA 输出控制
always @(*) begin
    if (~GAn)
        YA = A;            // 如果 GAn 为低电平，则输出 A 到 YA
    else
        YA = 4'hz;         // 否则输出高阻态
end

// YB 输出控制
always @(*) begin
    if (~GBn)
        YB = B;            // 如果 GBn 为低电平，则输出 B 到 YB
    else
        YB = 4'hz;         // 否则输出高阻态
end

endmodule

