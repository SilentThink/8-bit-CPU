`timescale 1ns / 1ps
module CPU8_tb;
reg CLK,CLRn;
wire T0,T1,T2,T3,T4,T5,T6,T7;
wire HALT,ADD_A,ADD_B,ADD_AB,ADD_BA,
          SUB_A,SUB_B,SUB_AB,SUB_BA,
          MUL_A,MUL_B,MUL_AB,MUL_BA,
          DIV_A,DIV_B,DIV_AB,DIV_BA,
          SHL_A,SHL_B,SHL_AB,SHL_BA,
          SHR_A,SHR_B,SHR_AB,SHR_BA,
          LD_A,LD_B,
          ST,JMP;
wire [7:0] Q_PC,ABUS;
wire [7:0] DBUS,Dout_ACC,Dout_B,abus,dbus,cbus,operand;
wire An,Bn;
wire EDR,IDR,IPC,IMARn,IAn,EAn,IBn,EBn,ESRn,ISTn,ISUMn,ISUBn,IMULn,IDIVn,ISHLn,ISHRn,IJMPn,IIRn;
wire EAR,ECR;

CPU8 DUT(
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
   .LD_A(LD_A),
   .LD_B(LD_B),
   .ST(ST),
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
   .SHL_A(SHL_A),
   .SHL_B(SHL_B),
   .SHL_AB(SHL_AB),
   .SHL_BA(SHL_BA),
   .SHR_A(SHR_A),
   .SHR_B(SHR_B),
   .SHR_AB(SHR_AB),
   .SHR_BA(SHR_BA),
   .JMP(JMP),
   .Q_PC(Q_PC),
   .ABUS(ABUS),
   .DBUS(DBUS),
   .Dout_ACC(Dout_ACC),
   .Dout_B(Dout_B),
   .abus(abus),
   .dbus(dbus),
   .cbus(cbus),
   .operand(operand),
   .An(An),
   .Bn(Bn),
   .EDR(EDR),
   .IDR(IDR),
   .IPC(IPC),
   .IMARn(IMARn),
   .IAn(IAn),
   .EAn(EAn),
   .IBn(IBn),
   .EBn(EBn),
   .ESRn(ESRn),
   .ISTn(ISTn),
   .ISUMn(ISUMn),
   .ISUBn(ISUBn),
   .IMULn(IMULn),
   .IDIVn(IDIVn),
   .ISHLn(ISHLn),
   .ISHRn(ISHRn),
   .IJMPn(IJMPn),
   .IIRn(IIRn),
    .EAR(EAR),
    .ECR(ECR)
);

initial begin
    CLK = 1;
    CLRn = 1;
    #15
    CLRn = 0;
    #15
    CLRn = 1;
end

always #10 CLK = ~CLK;

initial begin
    #3000 $finish;
end
endmodule
