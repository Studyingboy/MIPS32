`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 09:37:20
// Design Name: 
// Module Name: GPR32
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


module GPR32(
    output [31:0] RsData,
    output [31:0] RtData,
    input [31:0] WriteData,
    input [4:0] WriteAddr,
    input [4:0] RsAddr,
    input [4:0] RtAddr,
    input WriteEN,
    input CLK,
    input RST
    );
  reg[31:0] GPR[31:0];
  integer i;
  
  assign RsData = (RsAddr != 0) ? GPR[RsAddr] : 0;  //GPR[0] is $zero
  assign RtData = (RtAddr != 0) ? GPR[RtAddr] : 0;
  always @(negedge CLK) //ʱ���½���д������
    if(WriteEN) GPR[WriteAddr] <= WriteData;
  
  always @(CLK) //ʱ���������½��ض�����ͬ����λ
    if(RST)
        for(i=0;i<32;i=i+1)
            GPR[i] = i*4; //��Ӧ��ַ����
endmodule
