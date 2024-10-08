module SLED7(
    input [3:0] QT,
    input CLK50M,
    output an,
    output bn,
    output cn,
    output dn,
    output en,
    output fn,
    output gn);

reg [6:0] seg=7'b0;
assign {an,bn,cn,dn,en,fn,gn}=seg;

// ÒëÂëÆ÷
always @ (*) begin
    case (QT)
        4'b0000: seg = 7'b1111110; // 0        
        4'b0001: seg = 7'b0110000; // 1        
        4'b0010: seg = 7'b1101101; // 2        
        4'b0011: seg = 7'b1111001; // 3  
        4'b0100: seg = 7'b0110011; // 4        
        4'b0101: seg = 7'b1011011; // 5        
        4'b0110: seg = 7'b1011111; // 6        
        4'b0111: seg = 7'b1110000; // 7        
        4'b1000: seg = 7'b1111111; // 8        
        4'b1001: seg = 7'b1110011; // 9        
        4'b1010: seg = 7'b1110111; // A        
        4'b1011: seg = 7'b0011111; // B        
        4'b1100: seg = 7'b0001101; // C        
        4'b1101: seg = 7'b0111101; // D        
        4'b1110: seg = 7'b1001111; // E        
        4'b1111: seg = 7'b1000111; // F                
    endcase
end
endmodule
