`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/21 17:46:52
// Design Name: 
// Module Name: systemSimulation
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


module systemSimulation(
    output reg CLK,
    output reg RST
    );
    
    //ʵ������ʵ����Ƶ�����΢������
    SYSTEM wholeSysModule(CLK,RST);
    
    //ʱ������
    parameter PERIOD = 10;
    always begin
      CLK = 1'b0;
      #(PERIOD/2) CLK = 1'b1;
      #(PERIOD/2);
    end
    //��λ�ź�����
    initial begin
    RST = 1;
    #10 RST = 0;
    end	
    
endmodule
