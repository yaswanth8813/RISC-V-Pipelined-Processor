`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2026 16:43:00
// Design Name: 
// Module Name: add_cond
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


module add_cond(PCE,ImmExIE,out
    );
input [31:0]PCE,ImmExIE;
output [31:0]out;

assign out = PCE + ImmExIE ;

endmodule
