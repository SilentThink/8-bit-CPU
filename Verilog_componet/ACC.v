module ACC(
input wire CLK,
input wire IAn,
input wire EAn,
input wire EBn,
input wire IBn,
input [7:0] DinA,
output [7:0] QA,
output [7:0] QB,
output [7:0] Dout);
LS377 u0(
    .CLK(CLK),
    .EN(IAn),
    .D(DinA),
    .Q(QA)
);
LS377 u1(
    .CLK(CLK),
    .EN(IBn),
    .D(DinA),
    .Q(QB)
);
LS244 u2(
    .GAn(EAn),
    .GBn(EAn),
    .A(QA[3:0]),
    .B(QA[7:4]),
    .YA(Dout[3:0]),
    .YB(Dout[7:4])
);
LS244 u3(
    .GAn(EBn),
    .GBn(EBn),
    .A(QB[3:0]),
    .B(QB[7:4]),
    .YA(Dout[3:0]),
    .YB(Dout[7:4])
);
endmodule
