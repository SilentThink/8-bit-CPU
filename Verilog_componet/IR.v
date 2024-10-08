module IR(
input wire CLK,
input wire IIRn,
input wire [7:0] Din,
output wire LD_A,
output wire LD_B,
output wire ADD_A,
output wire ADD_B,
output wire ADD_AB,
output wire ADD_BA,
output wire SUB_A,
output wire SUB_B,
output wire SUB_AB,
output wire SUB_BA,
output wire MUL_A,
output wire MUL_B,
output wire MUL_AB,
output wire MUL_BA,
output wire DIV_A,
output wire DIV_B,
output wire DIV_AB,
output wire DIV_BA,
output wire SHL_A,
output wire SHL_B,
output wire SHL_AB,
output wire SHL_BA,
output wire SHR_A,
output wire SHR_B,
output wire SHR_AB,
output wire SHR_BA,
output wire ST,
output wire JMP,
output wire HALT);
wire Q7, Q6, Q5, Q4, Q3, Q2, Q1, Q0;
assign LD_A = Q7&~Q6&~Q5&Q4&~Q3&~Q2&~Q1&~Q0; // LD_A:10010000
assign LD_B = Q7&~Q6&~Q5&Q4&~Q3&~Q2&~Q1&Q0;   // LD_B:10010001

assign ADD_A = Q7&~Q6&~Q5&Q4&~Q3&~Q2&Q1&~Q0;  // ADD_A:10010010
assign ADD_B = Q7&~Q6&~Q5&Q4&~Q3&~Q2&Q1&Q0;  // ADD_B:10010011
assign ADD_AB =Q7&~Q6&~Q5&Q4&~Q3&Q2&~Q1&~Q0;  // ADD_AB:10010100
assign ADD_BA =Q7&~Q6&~Q5&Q4&~Q3&Q2&~Q1&Q0;  // ADD_BA:10010101

assign SUB_A = Q7&~Q6&~Q5&Q4&~Q3&Q2&Q1&~Q0;   // SUB_A:10010110
assign SUB_B = Q7&~Q6&~Q5&Q4&~Q3&Q2&Q1&Q0;   // SUB_B:10010111
assign SUB_AB =Q7&~Q6&~Q5&Q4&Q3&~Q2&~Q1&~Q0;   // SUB_AB:10011000
assign SUB_BA =Q7&~Q6&~Q5&Q4&Q3&~Q2&~Q1&Q0;   // SUB_BA:10011001

assign MUL_A = Q7&~Q6&~Q5&Q4&Q3&~Q2&Q1&~Q0;  // MUL_A:10011010
assign MUL_B = Q7&~Q6&~Q5&Q4&Q3&~Q2&Q1&Q0;  // MUL_B:10011011
assign MUL_AB = Q7&~Q6&~Q5&Q4&Q3&Q2&~Q1&~Q0; // MUL_AB:10011100
assign MUL_BA = Q7&~Q6&~Q5&Q4&Q3&Q2&~Q1&Q0; // MUL_BA:10011101

assign DIV_A =Q7&~Q6&~Q5&Q4&Q3&Q2&Q1&~Q0; // DIV_A:10011110
assign DIV_B =Q7&~Q6&~Q5&Q4&Q3&Q2&Q1&Q0; // DIV_B:10011111
assign DIV_AB =Q7&~Q6&Q5&~Q4&~Q3&~Q2&~Q1&~Q0; // DIV_AB:10100000
assign DIV_BA =Q7&~Q6&Q5&~Q4&~Q3&~Q2&~Q1&Q0; // DIV_BA:10100001

assign SHL_A =Q7&~Q6&Q5&~Q4&~Q3&~Q2&Q1&~Q0; // SHL_A:10100010
assign SHL_B =Q7&~Q6&Q5&~Q4&~Q3&~Q2&Q1&Q0; // SHL_B:10100011
assign SHL_AB=Q7&~Q6&Q5&~Q4&~Q3&Q2&~Q1&~Q0; // SHL_AB:10100100
assign SHL_BA=Q7&~Q6&Q5&~Q4&~Q3&Q2&~Q1&Q0; // SHL_BA:10100101

assign SHR_A =Q7&~Q6&Q5&~Q4&~Q3&Q2&Q1&~Q0; // SHR_A:10100110
assign SHR_B =Q7&~Q6&Q5&~Q4&~Q3&Q2&Q1&Q0; // SHR_B:10100111
assign SHR_AB=Q7&~Q6&Q5&~Q4&Q3&~Q2&~Q1&~Q0; // SHR_AB:10101000
assign SHR_BA=Q7&~Q6&Q5&~Q4&Q3&~Q2&~Q1&Q0; // SHR_BA:10101001

assign ST =  Q7&Q6&~Q5&~Q4&~Q3&~Q2&~Q1&~Q0;   // ST:11000000
assign JMP = Q7&Q6&~Q5&~Q4&~Q3&~Q2&~Q1&Q0;  // JMP: 11000001
assign HALT =Q7&Q6&Q5&Q4&Q3&Q2&Q1&Q0;   // HALT:11111111

LS377ir u0(
    .CLK(CLK),
    .EN(IIRn),
    .D(Din),
    .Q7(Q7),
    .Q6(Q6),
    .Q5(Q5),
    .Q4(Q4),
    .Q3(Q3),
    .Q2(Q2),
    .Q1(Q1),
    .Q0(Q0)
);
endmodule
