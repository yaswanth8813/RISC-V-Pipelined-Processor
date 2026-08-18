`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2026 17:49:39
// Design Name: 
// Module Name: register
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


module register_pipo(clk,in,reset,out);
input clk;
input [31:0]in;
input reset;
output reg [31:0]out;
always @(posedge clk or negedge reset)
begin
if(!reset)
   out<=0;
else
    out<=in;
end
endmodule









