module control(
input wire LD_A,
input wire LD_B,
input wire ST,
input wire ADD_A,
input wire ADD_B,
input wire ADD_AB,
input wire ADD_BA,
input wire SUB_A,
input wire SUB_B,
input wire SUB_AB,
input wire SUB_BA,
input wire MUL_A,
input wire MUL_B,
input wire MUL_AB,
input wire MUL_BA,
input wire DIV_A,
input wire DIV_B,
input wire DIV_AB,
input wire DIV_BA,
input wire SHR_A,
input wire SHR_B,
input wire SHR_AB,
input wire SHR_BA,
input wire SHL_A,
input wire SHL_B,
input wire SHL_AB,
input wire SHL_BA,
input wire JMP,
input wire T0,T1,T2,T3,T4,T5,T6,T7,
output wire IMARn,
output wire IIRn,
output wire IAn,
output wire EAn,
output wire IBn,
output wire EBn,
output wire IDR,
output wire IPC,
output wire ISUMn,
output wire ISUBn,
output wire IMULn,
output wire IDIVn,
output wire ISHLn,
output wire ISHRn,
output wire ISTn,
output wire IJMPn,
output wire An,
output wire Bn,

output wire ESRn,
output wire EDR,
output wire EAR,
output wire ECR
);
assign IPC = T2 | 
            T5&(LD_A|LD_B|ADD_A|ADD_B|SUB_A|SUB_B|MUL_A|MUL_B|DIV_A|DIV_B|SHR_A|SHR_B|SHL_A|SHL_B|ST|JMP);
assign IMARn = ~(T0|
                T3&(LD_A|LD_B|ADD_A|ADD_B|SUB_A|SUB_B|MUL_A|MUL_B|DIV_A|DIV_B|SHR_A|SHR_B|SHL_A|SHL_B|ST|JMP));
assign IDR = T1 | T4&LD_A |T4&LD_B | T4&ADD_A | T4&ADD_B|T4&SUB_A| T4&SUB_B | T4&MUL_A| T4&MUL_B | T4&DIV_A| T4&DIV_B | T4&SHR_A| T4&SHR_B | T4&SHL_A| T4&SHL_B |T4&ST |T4&JMP;
assign EDR =T6&ADD_A|T7&ADD_A|T6&ADD_B|T7&ADD_B|T6&ADD_AB|T7&ADD_AB|T6&ADD_BA|T7&ADD_BA|
            T6&SUB_A|T7&SUB_A|T6&SUB_B|T7&SUB_B|T6&SUB_AB|T7&SUB_AB|T6&SUB_BA|T7&SUB_BA|
            T6&MUL_A|T7&MUL_A|T6&MUL_B|T7&MUL_B|T6&MUL_AB|T7&MUL_AB|T6&MUL_BA|T7&MUL_BA|
            T6&DIV_A|T7&DIV_A|T6&DIV_B|T7&DIV_B|T6&DIV_AB|T7&DIV_AB|T6&DIV_BA|T7&DIV_BA|
            T6&SHR_A|T7&SHR_A|T6&SHR_B|T7&SHR_B|T6&SHR_AB|T7&SHR_AB|T6&SHR_BA|T7&SHR_BA|
            T6&SHL_A|T7&SHL_A|T6&SHL_B|T7&SHL_B|T6&SHL_AB|T7&SHL_AB|T6&SHL_BA|T7&SHL_BA|
            
            T5&(ADD_AB|ADD_BA|SUB_AB|SUB_BA|MUL_AB|MUL_BA|DIV_AB|DIV_BA|SHL_AB|SHL_BA|SHR_AB|SHR_BA);  
            
assign EAR = T5&ST;
assign ECR = 0;    
                                                                                                                                                                                                                                          
assign IAn = ~(T6&(LD_A|ADD_A|ADD_AB|SUB_A|SUB_AB|MUL_A|MUL_AB|DIV_A|DIV_AB|SHR_A|SHR_AB|SHL_A|SHL_AB));
assign EAn = ~(T7&(ADD_A|ADD_AB|SUB_A|SUB_AB|MUL_A|MUL_AB|DIV_A|DIV_AB|SHR_A|SHR_AB|SHL_A|SHL_AB)|
                T5&(ADD_BA|SUB_BA|MUL_BA|DIV_BA|SHL_BA|SHR_BA));

assign IBn = ~(T6&(LD_B|ADD_B|ADD_BA|SUB_B|SUB_BA|MUL_B|MUL_BA|DIV_B|DIV_BA|SHR_B|SHR_BA|SHL_B|SHL_BA));
assign EBn = ~(T7&(ADD_B|ADD_BA|SUB_B|SUB_BA|MUL_B|MUL_BA|DIV_B|DIV_BA|SHR_B|SHR_BA|SHL_B|SHL_BA)|
                T5&(ADD_AB|SUB_AB|MUL_AB|DIV_AB|SHL_AB|SHR_AB));

assign ISUMn = ~(T5&(ADD_A|ADD_B|ADD_AB|ADD_BA));   
assign ISUBn = ~(T5&(SUB_A|SUB_B|SUB_AB|SUB_BA));
assign IMULn = ~(T5&(MUL_A|MUL_B|MUL_AB|MUL_BA));    // ³Ë·¨
assign IDIVn = ~(T5&(DIV_A|DIV_B|DIV_AB|DIV_BA));    // ³ý·¨
assign ISHLn = ~(T5&(SHL_A|SHL_B|SHL_AB|SHL_BA));    // Âß¼­×óÒÆ
assign ISHRn = ~(T5&(SHR_A|SHR_B|SHR_AB|SHR_BA));    // Âß¼­ÓÒÒÆ
assign ISTn = ~(T5&ST);
assign IJMPn = ~(T5&JMP);

assign ESRn = ~(T6&(ADD_A|ADD_B|ADD_AB|ADD_BA)|
                T6&(SUB_A|SUB_B|SUB_AB|SUB_BA)|
                T6&(MUL_A|MUL_B|MUL_AB|MUL_BA)| 
                T6&(DIV_A|DIV_B|DIV_AB|DIV_BA)|
                T6&(SHR_A|SHR_B|SHR_AB|SHR_BA)|
                T6&(SHL_A|SHL_B|SHL_AB|SHL_BA));
assign IIRn = ~T2;

assign An = ~(LD_A|ADD_A|SUB_A|MUL_A|DIV_A|SHR_A|SHL_A|ADD_AB|SUB_AB|MUL_AB|DIV_AB|SHR_AB|SHL_AB);
assign Bn = ~(LD_B|ADD_B|SUB_B|MUL_B|DIV_B|SHR_B|SHL_B|ADD_BA|SUB_BA|MUL_BA|DIV_BA|SHR_BA|SHL_BA);
endmodule
