`timescale 1ns / 1ps
module control_tb;

reg LD_A,LD_B;
reg ADD_A,ADD_B,ADD_AB,ADD_BA;
reg SUB_A,SUB_B,SUB_AB,SUB_BA;
reg MUL_A,MUL_B,MUL_AB,MUL_BA;
reg DIV_A,DIV_B,DIV_AB,DIV_BA;
reg SHL_A,SHL_B,SHL_AB,SHL_BA;
reg SHR_A,SHR_B,SHR_AB,SHR_BA;
reg ST,JMP;
reg T0,T1,T2,T3,T4,T5,T6,T7;
wire IMARn,IIRn,IDR,IPC,ESRn,EDR,EAR,ECR;
wire IAn,EAn,IBn,EBn;
wire An,Bn;
wire ISUMn,ISUBn,IMULn,IDIVn,ISHLn,ISHRn,ISTn,IJMPn;

control DUT(
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
	.SHL_A(SHL_A),
	.SHL_B(SHL_B),
	.SHL_AB(SHL_AB),
	.SHL_BA(SHL_BA),
	.SHR_A(SHR_A),
	.SHR_B(SHR_B),
	.SHR_AB(SHR_AB),
	.SHR_BA(SHR_BA),
	.JMP(JMP),
	.ST(ST),
	.IMARn(IMARn),
	.IIRn(IIRn),
	.IAn(IAn),
    .IBn(IBn),
    .EAn(EAn),
	.EBn(EBn),
	.An(An),
	.Bn(Bn),
	.IDR(IDR),
	.IPC(IPC),
	.ISUBn(ISUBn),
	.ISUMn(ISUMn),
	.IMULn(IMULn),
	.IDIVn(IDIVn),
	.ISHLn(ISHLn),
	.ISHRn(ISHRn),
	.IJMPn(IJMPn),
	.ISTn(ISTn),
	
	.ESRn(ESRn),
	.EDR(EDR),
	.EAR(EAR),
	.ECR(ECR)
);

initial begin
    T0 = 1;
    T1 = 0;
    T2 = 0;
    T3 = 0;
    T4 = 0;
    T5 = 0;
    T6 = 0;
    T7 = 0;
    LD_A = 1;
    LD_B = 0;
    ADD_A = 0;
    ADD_B = 0;
    ADD_AB = 0;
    ADD_BA = 0;
    SUB_A = 0;
    SUB_B = 0;
    SUB_AB = 0;
    SUB_BA = 0;
    MUL_A = 0;
    MUL_B = 0;
    MUL_AB = 0;
    MUL_BA = 0;
    DIV_A = 0;
    DIV_B = 0;
    DIV_AB = 0;
    DIV_BA = 0;
    SHL_A = 0;
    SHL_B = 0;
    SHL_AB = 0;
    SHL_BA = 0;
    SHR_A = 0;
    SHR_B = 0;
    SHR_AB = 0;
    SHR_BA = 0;
    ST = 0;
    JMP = 0;
    
    #10
    T0 = 0;
    T1 = 1;
    #10
    T1 = 0;
    T2 = 1;
    #10
    T2 = 0;
    T3 = 1;
    #10
    T3 = 0;
    T4 = 1;
    #10
    T4 = 0;
    T5 = 1;
    #10
    T5 = 0;
    T6 = 1;
    #10
    T6 = 0;
    T7 = 1;
    #10
    T7 = 0;
    T0 = 1;
    LD_A = 0;
    ADD_A = 1;


    #10
    T0 = 0;
    T1 = 1;
    #10
    T1 = 0;
    T2 = 1;
    #10
    T2 = 0;
    T3 = 1;
    #10
    T3 = 0;
    T4 = 1;
    #10
    T4 = 0;
    T5 = 1;
    #10
    T5 = 0;
    T6 = 1;
    #10
    T6 = 0;
    T7 = 1;
    #10
    T7 = 0;
    T0 = 1;
    ADD_A = 0;
    SUB_B = 1;


    #10
    T0 = 0;
    T1 = 1;
    #10
    T1 = 0;
    T2 = 1;
    #10
    T2 = 0;
    T3 = 1;
    #10
    T3 = 0;
    T4 = 1;
    #10
    T4 = 0;
    T5 = 1;
    #10
    T5 = 0;
    T6 = 1;
    #10
    T6 = 0;
    T7 = 1;
    #10
    T7 = 0;
    T0 = 1;
    SUB_B = 0;
    MUL_AB = 1;
    
    
    #10
    T0 = 0;
    T1 = 1;
    #10
    T1 = 0;
    T2 = 1;
    #10
    T2 = 0;
    T3 = 1;
    #10
    T3 = 0;
    T4 = 1;
    #10
    T4 = 0;
    T5 = 1;
    #10
    T5 = 0;
    T6 = 1;
    #10
    T6 = 0;
    T7 = 1;
    #10
    T7 = 0;
    T0 = 1;
    MUL_AB = 0;
    DIV_BA = 1;
    
    
    #10
    T0 = 0;
    T1 = 1;
    #10
    T1 = 0;
    T2 = 1;
    #10
    T2 = 0;
    T3 = 1;
    #10
    T3 = 0;
    T4 = 1;
    #10
    T4 = 0;
    T5 = 1;
    #10
    T5 = 0;
    T6 = 1;
    #10
    T6 = 0;
    T7 = 1;
    #10
    T7 = 0;
    T0 = 1;
    DIV_BA = 0;
    SHL_A = 1;
    
    #10
    T0 = 0;
    T1 = 1;
    #10
    T1 = 0;
    T2 = 1;
    #10
    T2 = 0;
    T3 = 1;
    #10
    T3 = 0;
    T4 = 1;
    #10
    T4 = 0;
    T5 = 1;
    #10
    T5 = 0;
    T6 = 1;
    #10
    T6 = 0;
    T7 = 1;
    #10
    T7 = 0;
    T0 = 1;
    SHL_A = 0;
    JMP = 1;
    
    
    #10
    T0 = 0;
    T1 = 1;
    #10
    T1 = 0;
    T2 = 1;
    #10
    T2 = 0;
    T3 = 1;
    #10
    T3 = 0;
    T4 = 1;
    #10
    T4 = 0;
    T5 = 1;
    #10
    T5 = 0;
    T6 = 1;
    #10
    T6 = 0;
    T7 = 1;
    #10
    T7 = 0;
    T0 = 1;
    JMP = 0;
    ST = 1;
    
    
    #10
    T0 = 0;
    T1 = 1;
    #10
    T1 = 0;
    T2 = 1;
    #10
    T2 = 0;
    T3 = 1;
    #10
    T3 = 0;
    T4 = 1;
    #10
    T4 = 0;
    T5 = 1;
    #10
    T5 = 0;
    T6 = 1;
    #10
    T6 = 0;
    T7 = 1;
    #10
    T7 = 0;
    ST = 0;
end

initial begin
    #700 $finish;
end

endmodule

