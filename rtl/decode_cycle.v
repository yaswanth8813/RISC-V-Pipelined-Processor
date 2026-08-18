`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2026 13:27:59
// Design Name: 
// Module Name: decode_cycle
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
//module fetch_cycle(reset,PC_input,clk,start, InstrD,PCD,PCPlus4D);

module decode_cycle(PredictedTakenD,FlushE,clk,reset,InstrD,PCD,PCPlus4D, A3, WE3, WD3,
                   RegWriteE,ResultSrcE,MemWriteE,JumpE,BranchE,ALUSrcE,ALUControlE,
                   RD1E,RD2E,
                   PCE,PCPlus4E,RdE,ImmExIE,
                   funct7E,funct3E,PredictedTakenE,Rs1E,Rs2E,Rs1D,Rs2D
    );
input [31:0]InstrD,PCD,PCPlus4D;
input clk,reset,PredictedTakenD,FlushE;
input [4:0]A3;
input WE3;
input [31:0]WD3;
output reg RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE,funct7E,PredictedTakenE;
output reg[2:0]funct3E,ALUControlE;
output reg [31:0] ImmExIE,RD1E,RD2E,PCE ,PCPlus4E;
output reg [4:0]RdE,Rs1E,Rs2E;
output reg [1:0]ResultSrcE;
output [4:0]Rs1D,Rs2D;
wire RegWriteD,MemWriteD,JumpD,BranchD,ALUSrcD;
wire [1:0]ResultSrcD,ALUoperD;
wire [2:0]ImmSrcD;
wire [31:0]ImmExID;
wire [31:0] RD1,RD2,PCD;
//module RegisterFile(clk,A1,A2,A3,WD3,WE3,RD1,RD2);
assign Rs1D = InstrD[19:15];
assign Rs2D = InstrD[24:20];
RegisterFile R1(.clk(clk),.A1(InstrD[19:15]),.A2(InstrD[24:20]),.A3(A3),.WD3(WD3),.WE3(WE3),.RD1(RD1),.RD2(RD2));
//module Extend(imm,immSrcD,immExID);
Extend ex(.imm(InstrD),.immSrcD(ImmSrcD),.immExID(ImmExID));
//module ControlUnit(op,RegWriteD,ResultSrcD,MemWriteD,JumpD,BranchD,ALUSrcD,ImmSrcD);
ControlUnit control(.op(InstrD[6:0]),.RegWriteD(RegWriteD),.ResultSrcD(ResultSrcD),.MemWriteD(MemWriteD),.JumpD(JumpD),.BranchD(BranchD),.ALUSrcD(ALUSrcD),.ImmSrcD(ImmSrcD));


//register_pipo IF_ID_InstrD(.clk(clk),.in(InstrF),.reset(reset),.out(InstrD));
//register_pipo ID_IE_PCD(.clk(clk),.in(PCD),.reset(reset),.out(PCE));
always @(posedge clk or negedge reset)
begin
  if(!reset | FlushE)
      begin
        RegWriteE<=0;
        MemWriteE<=0;
        JumpE<=0;
        BranchE<=0;
        ALUSrcE<=0;
        funct7E<=0;
        funct3E<=0;
        RdE<=0;
        ResultSrcE<=0;
        ALUControlE<=0;
        PCE<=0;
        PCPlus4E<=0;
        ImmExIE<=0;
        RD1E<=0;
        RD2E<=0;
        PredictedTakenE<=0;
        Rs1E<=0;
        Rs2E<=0;
      end
    else
      begin
        RegWriteE<=RegWriteD;
        MemWriteE<=MemWriteD;
        JumpE<=JumpD;
        BranchE<=BranchD;
        ALUSrcE<=ALUSrcD;
        funct7E<=InstrD[30];
        funct3E<=InstrD[14:12];
        RdE<=InstrD[11:7];
        ResultSrcE<=ResultSrcD;
        ALUControlE<=ImmSrcD;
        PCE<=PCD;
        PCPlus4E<=PCPlus4D;
        ImmExIE<=ImmExID;
        RD1E<=RD1;
        RD2E<=RD2;
        PredictedTakenE<=PredictedTakenD;
        Rs1E <= InstrD[19:15];
        Rs2E <= InstrD[24:20];
      end
end


//register_pipo ID_IE_PCPlus4D(.clk(clk),.in(PCPlus4D),.reset(reset),.out(PCPlus4E));
//register_pipo ID_IE_PCPlus4D(.clk(clk),.in(PCPlus4D),.reset(reset),.out(PCPlus4E));
//register_pipo ID_IE_ImmExID(.clk(clk),.in(ImmExID),.reset(reset),.out(ImmExIE));


//register_pipo ID_IE_RD1(.clk(clk),.in(RD1),.reset(reset),.out(RD1E));
//register_pipo ID_IE_RD2(.clk(clk),.in(RD2),.reset(reset),.out(RD2E));

endmodule






