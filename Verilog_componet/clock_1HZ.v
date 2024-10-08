module clock_1HZ(
input wire CLK,
input wire CLRn,
output reg clk_1HZ=0
    );
reg [27:0]cnt=0;
always @(posedge CLK or negedge CLRn) begin
    if(!CLRn) cnt <= 28'd0;
//    else if(cnt != 28'd23499999)
    else if(cnt != 28'd0)
        cnt <= cnt + 1'b1;
    else
        cnt <= 28'd0;
    end
always @ (posedge CLK or negedge CLRn) begin
    if(!CLRn) clk_1HZ <= 0;
    else if(cnt == 28'd0)
        clk_1HZ <= ~clk_1HZ;
    end
endmodule