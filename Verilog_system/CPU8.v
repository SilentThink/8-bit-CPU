module CPU8(
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
output reg [7:0] operand,
output wire An,Bn,
output wire EDR,IDR,IPC,IMARn,IAn,EAn,IBn,EBn,ESRn,ISTn,ISUMn,ISUBn,IMULn,IDIVn,ISHLn,ISHRn,IJMPn,IIRn,
output wire EAR,ECR
);




wire [7:0] Dsrin;

wire CLK1HZ;
// 添加门控逻辑来控制时钟信号的传递
wire gated_CLK1HZ;
assign gated_CLK1HZ = HALT ? 1'b0 : CLK1HZ;

always @ (posedge T5) begin
    if(~DBUS[7])
        operand <= DBUS;
    else
        operand <= 8'bzzzzzzzz;
end

always @ (cbus) begin
    operand <= 8'bzzzzzzzz;
end

// 50MHZ 转 1HZ模块
clock_1HZ u0(
    .CLK(CLK),
    .CLRn(1'b1),
    .clk_1HZ(CLK1HZ)
);

PC u1(
    .CLK(gated_CLK1HZ),
    .IPC(IPC),
    .LDn(IJMPn),
    .D(dbus),
    .CLRn(CLRn),
    .Q(Q_PC)
);
MAR u2(
    .CLK(gated_CLK1HZ),
    .IMARn(IMARn),
    .D(Q_PC),
    .ABUS(ABUS)
);

RAM u3(
    .CLK(CLK),
    .CS(1'b0),
    .WR(ISTn),
    .DIN(Dout_ACC),
    .ADDR(ISTn?ABUS:abus),
    .DOUT(DBUS)
);

DR u4(
    .CLK(gated_CLK1HZ),
    .EDR(EDR),
    .EAR(EAR),
    .ECR(ECR),
    .IDR(IDR),
    .DBUS(DBUS),
    .dbus(dbus),
    .cbus(cbus),
    .abus(abus)
);
pulse u5(
    .CLK(gated_CLK1HZ),
    .CLRn(CLRn),
    .T0(T0),
    .T1(T1),
    .T2(T2),
    .T3(T3),
    .T4(T4),
    .T5(T5),
    .T6(T6),
    .T7(T7)
);
control u6(
    .LD_A(LD_A),
    .LD_B(LD_B),
    .ST(ST),
    .ADD_A(ADD_A),
    .ADD_B(ADD_B),
    .ADD_AB(ADD_AB),
    .ADD_BA(ADD_BA),
    .SUB_A(SUB_A),
    .SUB_B(SUB_B),
    .SUB_AB(SUB_AB),
    .SUB_BA(SUB_BA),
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
    .JMP(JMP),
    .T0(T0),
    .T1(T1),
    .T2(T2),
    .T3(T3),
    .T4(T4),
    .T5(T5),
    .T6(T6),
    .T7(T7),
    .IMARn(IMARn),
    .IIRn(IIRn),
    .IAn(IAn),
    .EAn(EAn),
    .IBn(IBn),
    .EBn(EBn),
    .IDR(IDR),
    .IPC(IPC),
    .ISUMn(ISUMn),
    .ISUBn(ISUBn),
    .IMULn(IMULn),
    .IDIVn(IDIVn),
    .ISHLn(ISHLn),
    .ISHRn(ISHRn),
    .ISTn(ISTn),
    .IJMPn(IJMPn),
    .ESRn(ESRn),
    .EDR(EDR),
    .EAR(EAR),
    .ECR(ECR),
    .An(An),
    .Bn(Bn)
);



ACC u7(
    .CLK(gated_CLK1HZ),
    .IAn(IAn),
    .EAn(EAn),
    .IBn(IBn),
    .EBn(EBn),
    .DinA(dbus),
    .Dout(dbus),
    .QA(Dout_ACC),
    .QB(Dout_B)
);

ALU u8(
    .ISUMn(ISUMn),
    .ISUBn(ISUBn),
    .IMULn(IMULn),
    .IDIVn(IDIVn),
    .ISHLn(ISHLn),
    .ISHRn(ISHRn),
    .Din(dbus),
    .DinA(Dout_ACC),
    .DinB(Dout_B),
    .Dout(Dsrin),
    .An(An),
    .Bn(Bn)
);

SR u9(
    .CLK(gated_CLK1HZ),
    .ISUMn(ISUMn),
    .ISUBn(ISUBn),
    .IMULn(IMULn),
    .IDIVn(IDIVn),
    .ISHLn(ISHLn),
    .ISHRn(ISHRn),
    .ESRn(ESRn),
    .Dsrin(Dsrin),
    .Dout(dbus)
);

IR u10(
    .CLK(gated_CLK1HZ),
    .IIRn(IIRn),
    .Din(cbus),
    .LD_A(LD_A),
    .LD_B(LD_B),
    .ST(ST),
    .ADD_A(ADD_A),
    .ADD_B(ADD_B),
    .ADD_AB(ADD_AB),
    .ADD_BA(ADD_BA),
    .SUB_A(SUB_A),
    .SUB_B(SUB_B),
    .SUB_AB(SUB_AB),
    .SUB_BA(SUB_BA),
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
    .JMP(JMP),
    .HALT(HALT)
);
endmodule
