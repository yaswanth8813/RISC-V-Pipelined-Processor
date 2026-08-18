`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2026 17:53:38
// Design Name: 
// Module Name: Extend
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


module Extend(imm,immSrcD,immExID
    );
input [31:0] imm;
input [2:0]immSrcD;
output reg [31:0]immExID;
always @(*)
begin
case(immSrcD)
   3'b000: immExID = 32'hxxxxxxxx;
   3'b001: immExID = {{20{imm[31]}},imm[31:20]};
   3'b010: immExID = {{20{imm[31]}},imm[31:25],imm[11:7]};
   3'b011: immExID = {{19{imm[31]}},imm[31],imm[7],imm[30:25],imm[11:8],1'b0};
   3'b100: immExID = {imm[31:12],12'h000};
   3'b101: immExID = {{11{imm[31]}},imm[31],imm[19:12],imm[20],imm[30:21],1'b0};
   3'b110: immExID = {{20{imm[31]}},imm[31:20]};
   default: immExID = 32'hxxxxxxxx;
   endcase
end
endmodule





