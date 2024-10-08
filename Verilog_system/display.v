module display(
    input wire reset_btn,
    input wire CLK,     // 50MHZ
    input wire CLRn,
    output wire T0,
    output wire T1,
    output wire T2,
    output wire T3,
    output wire T4,
    output wire T5,
    output wire T6,
    output wire T7,
    output wire HALT,
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
    output wire SHR_A,
    output wire SHR_B,
    output wire SHR_AB,
    output wire SHR_BA,
    output wire SHL_A,
    output wire SHL_B,
    output wire SHL_AB,
    output wire SHL_BA,
    output wire LD_A,
    output wire LD_B,
    output wire ST,
    output wire JMP,
    output wire [7:0] Q_PC,
    output wire [7:0] ABUS,
    output wire [7:0] DBUS,
    output wire [7:0] Dout_ACC,
    output wire [7:0] Dout_B,
    output wire [7:0] abus,
    output wire [7:0] dbus,
    output wire [7:0] cbus,
    output wire [7:0] operand,
    output wire An,Bn,
    
    output [6:0] LED7_1,
    output [6:0] LED7_2,
    
    output wire [2:0] video_red,    
    output wire [2:0] video_green,  
    output wire [1:0] video_blue,   
    output wire       video_hsync,  
    output wire       video_vsync,  
    output wire       video_clk,   
    output wire       video_de
    );
     
 
 CPU8 cpu8(
    .CLK(CLK),
    .CLRn(CLRn),
    .T0(T0),
    .T1(T1),
    .T2(T2),
    .T3(T3),
    .T4(T4),
    .T5(T5),
    .T6(T6),
    .T7(T7),
    .HALT(HALT),
    .SUB_A(SUB_A),
    .SUB_B(SUB_B),
    .SUB_AB(SUB_AB),
    .SUB_BA(SUB_BA),
    .ADD_A(ADD_A),
    .ADD_B(ADD_B),
    .ADD_AB(ADD_AB),
    .ADD_BA(ADD_BA),
    .MUL_A(MUL_A),
    .MUL_B(MUL_B),
    .MUL_AB(MUL_AB),
    .MUL_BA(MUL_BA),
    .DIV_A(DIV_A),
    .DIV_B(DIV_B),
    .DIV_AB(DIV_AB),
    .DIV_BA(DIV_BA),
    .SHR_A(SHR_A),
    .SHR_B(SHR_B),
    .SHR_AB(SHR_AB),
    .SHR_BA(SHR_BA),
    .SHL_A(SHL_A),
    .SHL_B(SHL_B),
    .SHL_AB(SHL_AB),
    .SHL_BA(SHL_BA),
    .LD_A(LD_A),
    .LD_B(LD_B),
    .ST(ST),
    .JMP(JMP),
    .Q_PC(Q_PC),
    .ABUS(ABUS),
    .DBUS(DBUS),
    .Dout_ACC(Dout_ACC),
    .Dout_B(Dout_B),
    .dbus(dbus),
    .cbus(cbus),
    .abus(abus),
    .operand(operand),
    .An(An),
    .Bn(Bn)
 );
    
SLED7 sled7_1(
    .QT(Q_PC[3:0]),
    .CLK50M(CLK),
    .an(LED7_1[0]),
    .bn(LED7_1[1]),
    .cn(LED7_1[2]),
    .dn(LED7_1[3]),
    .en(LED7_1[4]),
    .fn(LED7_1[5]),
    .gn(LED7_1[6]));

SLED7 sled7_2(
    .QT(Q_PC[7:4]),
    .CLK50M(CLK),
    .an(LED7_2[0]),
    .bn(LED7_2[1]),
    .cn(LED7_2[2]),
    .dn(LED7_2[3]),
    .en(LED7_2[4]),
    .fn(LED7_2[5]),
    .gn(LED7_2[6]));

reg [55:0] OP_display;
always @ (posedge T6) begin
    case(cbus) 
    8'b10010000: OP_display = {8'h40,8'h3f,8'h20,8'h3b,8'h20,8'h20,8'h20};  // LD_A
    8'b10010001: OP_display = {8'h40,8'h3f,8'h20,8'h3c,8'h20,8'h20,8'h20};  // LD_B
    8'b10010010: OP_display = {8'h3b,8'h3f,8'h3f,8'h20,8'h3b,8'h20,8'h20};  // ADD_A
    8'b10010011: OP_display = {8'h3b,8'h3f,8'h3f,8'h20,8'h3c,8'h20,8'h20};  // ADD_B
    8'b10010100: OP_display = {8'h3b,8'h3f,8'h3f,8'h20,8'h3b,8'h20,8'h3c};  // ADD_AB
    8'b10010101: OP_display = {8'h3b,8'h3f,8'h3f,8'h20,8'h3c,8'h20,8'h3b};  // ADD_BA
    
    8'b10010110: OP_display = {8'h41,8'h43,8'h3c,8'h20,8'h3b,8'h20,8'h20};   // SUB_A
    8'b10010111: OP_display = {8'h41,8'h43,8'h3c,8'h20,8'h3c,8'h20,8'h20};   // SUB_B
    8'b10011000: OP_display = {8'h41,8'h43,8'h3c,8'h20,8'h3b,8'h20,8'h3c};   // SUB_AB
    8'b10011001: OP_display = {8'h41,8'h43,8'h3c,8'h20,8'h3c,8'h20,8'h3b};   // SUB_BA
    
    8'b10011010: OP_display = {8'h44,8'h43,8'h40,8'h20,8'h3b,8'h20,8'h20};   // MUL_A
    8'b10011011: OP_display = {8'h44,8'h43,8'h40,8'h20,8'h3c,8'h20,8'h20};   // MUL_B
    8'b10011100: OP_display = {8'h44,8'h43,8'h40,8'h20,8'h3b,8'h20,8'h3c};   // MUL_AB
    8'b10011101: OP_display = {8'h44,8'h43,8'h40,8'h20,8'h3c,8'h20,8'h3b};   // MUL_BA
    
    8'b10011110: OP_display = {8'h3f,8'h45,8'h46,8'h20,8'h3b,8'h20,8'h20};   // DIV_A
    8'b10011111: OP_display = {8'h3f,8'h45,8'h46,8'h20,8'h3c,8'h20,8'h20};   // DIV_B
    8'b10100000: OP_display = {8'h3f,8'h45,8'h46,8'h20,8'h3b,8'h20,8'h3c};   // DIV_AB
    8'b10100001: OP_display = {8'h3f,8'h45,8'h46,8'h20,8'h3c,8'h20,8'h3b};   // DIV_BA
    
    8'b10100010: OP_display = {8'h41,8'h47,8'h40,8'h20,8'h3b,8'h20,8'h20};   // SHL_A
    8'b10100011: OP_display = {8'h41,8'h47,8'h40,8'h20,8'h3c,8'h20,8'h20};   // SHL_B
    8'b10100100: OP_display = {8'h41,8'h47,8'h40,8'h20,8'h3b,8'h20,8'h3c};   // SHL_AB
    8'b10100101: OP_display = {8'h41,8'h47,8'h40,8'h20,8'h3c,8'h20,8'h3b};   // SHL_BA
    
    8'b10100110: OP_display = {8'h41,8'h47,8'h48,8'h20,8'h3b,8'h20,8'h20};   // SHR_A
    8'b10100111: OP_display = {8'h41,8'h47,8'h48,8'h20,8'h3c,8'h20,8'h20};   // SHR_B
    8'b10101000: OP_display = {8'h41,8'h47,8'h48,8'h20,8'h3b,8'h20,8'h3c};   // SHR_AB
    8'b10101001: OP_display = {8'h41,8'h47,8'h48,8'h20,8'h3c,8'h20,8'h3b};   // SHR_BA
    
    8'b11000000: OP_display = {8'h41,8'h42,8'h20,8'h20,8'h20,8'h20,8'h20};   // ST
    8'b11000001: OP_display = {8'h49,8'h44,8'h3e,8'h20,8'h20,8'h20,8'h20};   // JMP
    8'b11111111: OP_display = {8'h47,8'h3b,8'h40,8'h42,8'h20,8'h20,8'h20};   // HALT
    
    default: OP_display = {8'h20,8'h20,8'h20,8'h20,8'h20,8'h20,8'h20};
    
    endcase
end 

reg [7:0] operand_shi,operand_ge;
always @(posedge T6) begin
    if((operand==8'bzzzzzzzz)|(cbus==8'b11000010)) begin
        operand_ge <= 8'h20;
        operand_shi<= 8'h20;
    end
    else begin
        operand_ge <= operand%10+8'h30;
        operand_shi <= operand%100/10+8'h30;
    end
end
    
lcd_top lcd_top_0(
    .clk_50M(CLK), 
    .reset_btn(reset_btn),
    .A_shi(Dout_ACC%100/10),
    .A_ge(Dout_ACC%10),
    .B_shi(Dout_B%100/10),
    .B_ge(Dout_B%10),
    .OP_display(OP_display),
    .operand_shi(operand_shi),
    .operand_ge(operand_ge),
    .video_red(video_red), 
    .video_green(video_green),
    .video_blue(video_blue),   
    .video_hsync(video_hsync),  
    .video_vsync(video_vsync), 
    .video_clk(video_clk),   
    .video_de(video_de)    
);
endmodule
