`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2026 09:39:04
// Design Name: 
// Module Name: writeback_cycle
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


module writeback_cycle(RegWriteW,ResultSrcW,ALUResultW,RdW,PCPlus4W,ReadDataW,
                     WE3,ResultW,A3
    );
input RegWriteW;
input [1:0]ResultSrcW;
input [31:0] ALUResultW,PCPlus4W,ReadDataW;
input[4:0] RdW;
output WE3;
output [31:0]ResultW;
output [4:0]A3;
//module mux3_1(a,b,c,s,y);
assign WE3= RegWriteW;
assign A3=RdW;
mux3_1 m1(ALUResultW,ReadDataW,PCPlus4W,ResultSrcW,ResultW);
endmodule






