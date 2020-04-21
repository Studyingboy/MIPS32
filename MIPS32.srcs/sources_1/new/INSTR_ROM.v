`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 09:51:47
// Design Name: 
// Module Name: INSTR_ROM
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


module INSTR_ROM(
    input [4:0] addr,   //��ַ��
    output reg[31:0] data,  //32λ������
    input CLK   //ͬ��ʱ��
    );
    reg[31:0] ROM [0:31];   //32*32�洢��Ԫ
    
    always@(posedge CLK)    //��ʱ�������ض�������orָ��
    begin
        data = ROM[addr];
    end
    
    integer i;
    initial
    begin
        for(i=0;i<32;i=i+1) //Ĭ�ϳ�ʼ���洢��Ԫ����Ϊ��ַ
            ROM[i]=i;
            
        //��ʼ���洢��Ԫ�����ָ���ļ�
        $readmemh("D:/CollegeHomework/MIPS32/executeCode.txt",ROM);
    end
endmodule
