`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/17 17:01:50
// Design Name: 
// Module Name: mainCTRL_sim
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


module mainCTRL_sim(
    output reg CLK,
    output [31:0] INSTR,
    output Jump,
    output RegWriteDataSrc,
    output MemWriteEN,
    output Branch,
    output [2:0] AluCtrl,
    output AluSrc,
    output RegWriteSrc,
    output RegWriteEN
    );
    reg[4:0] simAddr;
    //ʵ����ָ��洢��
    INSTR_ROM rom(simAddr,INSTR,CLK);
    //ʵ������������
    mainController mainCtrl(AluCtrl,
            RegWriteDataSrc,MemWriteEN,
            Branch,AluSrc,
            RegWriteSrc,RegWriteEN,
            Jump,
            INSTR[31:26],INSTR[5:0]);
    
    initial
    begin
        simAddr = 0; //��ʼ����ַΪ0
    end
    
   parameter PERIOD = 10;
   always begin     //ʱ������ģ��
      CLK = 1'b1;
      #(PERIOD/2) CLK = 1'b0;
      #(PERIOD/2);
   end
   
    always @(negedge CLK)  //ʱ���½��ظı��ַ
    begin
        simAddr = simAddr+1; //��ַ����
        if(simAddr == 12) simAddr = 0;  //��ַ���
    end
endmodule
