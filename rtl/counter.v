`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2026 18:34:55
// Design Name: 
// Module Name: counter
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


module counter(clk,reset,count
    );
input clk;
parameter N=16;
input reset;
output reg[N-1:0]count;
always @(posedge clk)
begin
 if(reset)
     out<= 0;
 else
     count<=count+1;
end
endmodule
