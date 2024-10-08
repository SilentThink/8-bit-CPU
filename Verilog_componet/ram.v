//存储器
module RAM(WR, CS, DIN, DOUT, ADDR, CLK);
   input CLK;
   input        WR;//WR片选信号, CS读写控制端
   input        CS;//WR片选信号, CS读写控制端
   input [7:0]  DIN;//输入的内存内容
   input [7:0]  ADDR;//输入信号为地址信息
   output reg [7:0] DOUT;//输出的是选中地址中相应的内容
  
   
   reg [7:0]    MEM[0:28];
   initial begin
   MEM[0] = 8'b10010000;    // LD_A
   MEM[1] = 8'b00001000;    // 8
   
   MEM[2] = 8'b10010001;    // LD_B
   MEM[3] = 8'b00000100;    // 4
   
   MEM[4] = 8'b10010011;    // ADD_B
   MEM[5] = 8'b00000001;    // 1
   
   MEM[6] = 8'b10010101;    // ADD_BA
   
   MEM[7] = 8'b10011010;    // MUL_A
   MEM[8] = 8'b00000010;    // 2
   
   MEM[9] = 8'b11000000;    // ST
   MEM[10] = 8'b00001100;    // 12
   
   MEM[11] = 8'b11000001;   // JMP
   MEM[12] = 8'b00000110;   // 6
   
   MEM[13] = 8'b10010011;   // ADD_B
   MEM[14] = 8'b00000001;   // 1
   
   MEM[15] = 8'b10010101;   // ADD_BA
   
   MEM[16] = 8'b10011110;   // DIV_A
   MEM[17] = 8'b00000100;   // 4
   
   MEM[18] = 8'b10100110;   // SHR_A
   MEM[19] = 8'b00000010;   // 2
   
   MEM[20] = 8'b10010000;   // LD_A
   MEM[21] = 8'b00000010;   // 2
   
   MEM[22] = 8'b11000000;    // ST
   MEM[23] = 8'b00011001;    // 25
   
   MEM[24] = 8'b10011111;    // DIV_B
   MEM[25] = 8'b00000001;    // 1
   
   MEM[26] = 8'b11111111;   // HALT   
   end
   
   always @(CLK)
   begin
      if (CS == 1'b0)
      begin
         if (WR == 1'b0)
            MEM[(ADDR[4:0])] = DIN;//写
         else if (WR == 1'b1)
            DOUT <= MEM[(ADDR[4:0])];//读
      end
   end
    
endmodule
