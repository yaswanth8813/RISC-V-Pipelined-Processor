`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2026 20:45:03
// Design Name: 
// Module Name: memory_cycle
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


module memory_cycle(clk,reset,funct3M,AlucontrolM,RegWriteM,ResultSrcM,MemWriteM,ALUResultM,WriteDataM,RdM,PCPlus4M,
               RegWriteW,ResultSrcW,ALUResultW,RdW,PCPlus4W,ReadDataW,RdM_x,RegWriteM_x,ALUResultM_x
    );
input clk,reset;
input RegWriteM,MemWriteM;
input [1:0]ResultSrcM;
input [31:0] ALUResultM,WriteDataM,PCPlus4M;
input [4:0] RdM;
input [2:0]funct3M,AlucontrolM;
output [31:0]ALUResultM_x;
output [4:0]RdM_x;
output RegWriteM_x;
output  reg RegWriteW;
output reg [1:0]ResultSrcW;
output reg [31:0] ALUResultW,PCPlus4W,ReadDataW;
output reg [4:0] RdW;

assign RegWriteM_x=RegWriteM;
assign RdM_x=RdM;
assign ALUResultM_x=ALUResultM;
wire [31:0]ReadDataM;
Data_Memory D1(.funct3M(funct3M),.AlucontrolM(AlucontrolM),.A(ALUResultM),.WD(WriteDataM),.clk(clk),.WE(MemWriteM),.RD(ReadDataM));

always @(posedge clk or negedge reset)
begin
  if(!reset)
      begin
       RegWriteW<=0;
       ResultSrcW<=0;
       ALUResultW<=0;
       RdW<=0;
       PCPlus4W<=0;
       ReadDataW<=0;
      end
  else
     begin
       RegWriteW<=RegWriteM;
       ResultSrcW<=ResultSrcM;
       ALUResultW<=ALUResultM;
       RdW<=RdM;
       PCPlus4W<=PCPlus4M;
       ReadDataW<=ReadDataM;
     end
 end
endmodule
