module SR(
input CLK,
input ISUMn,
input ISUBn,
input IMULn,
input IDIVn,
input ISHLn,
input ISHRn,
input ESRn,
input [7:0] Dsrin,
output [7:0] Dout
);

wire [7:0] Dsrout;
LS377 u1(
    .CLK(CLK),
    .EN(ISUMn&ISUBn&IMULn&IDIVn&ISHLn&ISHRn),
    .D(Dsrin),
    .Q(Dsrout)
);

LS244 u2(
    .GAn(ESRn),
    .GBn(ESRn),
    .A(Dsrout[3:0]),
    .B(Dsrout[7:4]),
    .YA(Dout[3:0]),
    .YB(Dout[7:4])
);
endmodule
