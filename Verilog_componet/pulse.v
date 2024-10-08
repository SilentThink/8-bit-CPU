module pulse(
    input CLK,
    input CLRn,
    output reg T0, T1, T2, T3, T4, T5, T6, T7
    );
    
    always @(posedge CLK or negedge CLRn) begin
        if (!CLRn) begin
            T0 <= 1'b1;  // 初始状态下T0为1，其它位为0
            T1 <= 1'b0;
            T2 <= 1'b0;
            T3 <= 1'b0;
            T4 <= 1'b0;
            T5 <= 1'b0;
            T6 <= 1'b0;
            T7 <= 1'b0;
        end else begin
            T0 <= T7;    // 环形移位
            T1 <= T0;
            T2 <= T1;
            T3 <= T2;
            T4 <= T3;
            T5 <= T4;
            T6 <= T5;
            T7 <= T6;
        end
    end
endmodule

