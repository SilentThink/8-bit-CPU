module LS161(
input wire CLK,
input wire CLRn,
input wire LDn,
input wire ENP,
input wire ENT,
input wire [3:0] D,
output wire [3:0] Q,
output wire RCO);

wire DA,DB,DC,DD,ENA;
reg QF0,QF1,QF2,QF3;
assign Q = {QF3,QF2,QF1,QF0};
assign RCO = QF1&QF2&QF3&QF0&ENT;
assign ENA = ENT&ENP&LDn;
assign DA = (QF0&LDn)^((D[0]&~LDn)|ENA);
assign DB = (QF1&LDn)^((D[1]&~LDn)|(ENA&QF0));
assign DC = (QF2&LDn)^((D[2]&~LDn)|(ENA&QF0&QF1));
assign DD = (QF3&LDn)^((D[3]&~LDn)|(ENA&QF0&QF1&QF2));
//assign DA = LDn ? (ENA ^ QF0) : D[0];
//assign DB = LDn ? (ENA & QF0 ^ QF1) : D[1];
//assign DC = LDn ? (ENA & QF0 & QF1 ^ QF2) : D[2];
//assign DD = LDn ? (ENA & QF0 & QF1 & QF2 ^ QF3) : D[3];

always @ (posedge CLK or negedge CLRn) begin
if(~CLRn) {QF3,QF2,QF1,QF0} <= 4'b0000;
else {QF3,QF2,QF1,QF0} <= {DD,DC,DB,DA};

end
endmodule
