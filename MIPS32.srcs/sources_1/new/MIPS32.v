`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 11:22:46
// Design Name: 
// Module Name: MIPS32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MIPS32(
    output [31:0] ALURes,
    output [31:0] MemWriteData,
    output MemWriteEN,
    output [31:0] PC,
    input [31:0] ReadData,
    input [31:0] Instr,
    input CLK,
    input RST
    );
  wire RegWriteDataSrc,Branch,ALUSrc,Zero,RegWriteEN,RegWriteAddrSrc,PCSrc,Jump;
  wire[2:0] ALUCtrl;
  wire[4:0] RegWriteAddr;
  wire[31:0] Rs,Rt,RegWriteData;
  wire[31:0] SignImm;
  
  //ʵ������������
  assign PCSrc = Branch & Zero;
  mainController mainCtrl(ALUCtrl,RegWriteDataSrc,MemWriteEN,Branch,
                    ALUSrc,RegWriteAddrSrc,RegWriteEN,Jump,
                    Instr[31:26],Instr[5:0]);
  
    //ʵ����ͨ�üĴ���
    assign RegWriteData = RegWriteDataSrc ? ReadData : ALURes;
    assign RegWriteAddr = RegWriteAddrSrc ? Instr[15:11] : Instr[20:16];
    assign MemWriteData = Rt;
    GPR32 generalPurposeRegister(Rs,Rt,   
            RegWriteData,RegWriteAddr,
            Instr[25:21],Instr[20:16],
            RegWriteEN,CLK,RST);
            
    //ʵ�����з�������չ��
    signExt signedDataExtender(SignImm,Instr[15:0]);
    //ʵ�����з�����������
    wire[31:0] signedExtShift2Bits;
    signedShiftLeft #(2,32) signedShiftLeft2Bits(signedExtShift2Bits,SignImm);
    
    //ʵ����PC�Ĵ���
    wire[31:0] nextPC,PCbranch,PCplus4;
    PCReg pcRegister(PC,nextPC,CLK,RST);
    //ʵ����PC�Ե���
    assign PCplus4 = PC + 4;
    //ʵ����ֱ����ת��ַ������
    wire[27:0] directJumpAddr;
    assign directJumpAddr = {PCplus4[31:28],Instr[25:0],2'b00};
    //ʵ����nextPCԴ�����߼�
    assign PCbranch = PCplus4 + signedExtShift2Bits;
    assign nextPC = Jump ? directJumpAddr :(PCSrc ? PCbranch : PCplus4);
    
    //ʵ����ALU
    wire[31:0] ALU_data2;
    assign ALU_data2 = ALUSrc? SignImm : Rt;
    ALU alu(ALURes,Zero,
            Rs,ALU_data2,ALUCtrl);
    
endmodule

module PCReg #(parameter width=32)
          (output reg[width-1:0] Q, input[width-1:0] D, input CLK, Reset);
  always @(negedge CLK, posedge Reset) //ָ��ָ�����½����޸�
    if (Reset) Q <= 0;
    else       Q <= D;
endmodule
