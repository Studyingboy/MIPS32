`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/16 11:20:50
// Design Name: 
// Module Name: GPR32_sim
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


module GPR32_sim(
    output reg [4:0] addr1,
    output reg [4:0] addr2,
    output reg [4:0] addrW,
    output [31:0] data1,
    output [31:0] data2,
    output reg [31:0] dataW,
    output reg WriteEN,
    output reg CLK,
    output reg RST
    );
    //ʱ������ģ��
    parameter PERIOD = 10;
    always begin
      CLK = 1'b0;
      #(PERIOD/2) CLK = 1'b1;
      #(PERIOD/2);
    end
    //ʵ����ͨ�üĴ���ģ��
    GPR32 generalPurposeRegister(data1,data2,dataW,
        addrW,addr1,addr2,WriteEN,CLK,RST);
    
    initial
    begin //��ʼ��
        RST = 1;
        addr1 = 5;
        addr2 = 6;
        addrW = 6;
        dataW = 1;
        WriteEN = 0;
        #PERIOD RST = 0;
    end
    
    always@(posedge CLK)
    begin //ʱ���źŶ���Ƶ��Ϊдʹ��
        WriteEN <= ~WriteEN;
        //д���ݵ���
        dataW <= dataW + 1; 
        if(dataW == 7) dataW <=0;
    end
endmodule
