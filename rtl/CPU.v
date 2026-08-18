`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2026 09:54:21
// Design Name: 
// Module Name: CPU
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


module CPU(

input reset,
input clk
    );

wire PredictedTakenF;
wire [31:0] PredictedTargetF;
branch_prediction branch(clk,reset,PCF_b, PredictedTakenF,PredictedTargetF,BranchE,JumpE,PCE, BranchTakenE,PCTargetIE_x);

wire [1:0] ForwardAE, ForwardBE ;
wire StallF, StallD,FlushD ,FlushE;
Hazard_Unit hazard(Rs1D,Rs2D,Rs1E,Rs2E,RdE,RdM,RegwriteM,A3,WE3,ResultSrcE_b,start,ForwardAE,ForwardBE, StallF,StallD,FlushD,FlushE);

wire [31:0] InstrD;
wire [31:0] PCD;
wire [31:0] PCPlus4D,PCF_b;
wire PCSrcE,PredictedTakenD;

//assign PCSrcE = (ZeroE & BranchE)| JumpE;
//module fetch_cycle(StallF,StallD,FlushD,PredictedTargetF,PredictedTakenF,reset,PC_input,clk,start, InstrD,PCD,PCPlus4D,PredictedTakenD,PCF_b);
fetch_cycle fetch(.StallF(StallF),.StallD(StallD),.FlushD(FlushD),.PredictedTargetF(PredictedTargetF),
                    .PredictedTakenF(PredictedTakenF),.reset(reset),.PC_input(PCTargetIE),.clk(clk),
                  .start(start),.InstrD(InstrD),.PCD(PCD),.PCPlus4D(PCPlus4D),.PredictedTakenD(PredictedTakenD),.PCF_b(PCF_b));


wire  RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE,funct7E,PredictedTakenE;
wire [2:0]funct3E,ALUControlE;
wire [31:0] ImmExIE,RD1E,RD2E,PCE ,PCPlus4E;
wire [4:0]RdE;
wire [1:0]ResultSrcE;
wire [4:0]Rs1D,Rs2D,Rs1E,Rs2E;
/*module decode_cycle(PredictedTakenD,FlushE,clk,reset,InstrD,PCD,PCPlus4D, A3, WE3, WD3,
                   RegWriteE,ResultSrcE,MemWriteE,JumpE,BranchE,ALUSrcE,ALUControlE,
                   RD1E,RD2E,
                   PCE,PCPlus4E,RdE,ImmExIE,
                   funct7E,funct3E,PredictedTakenE,Rs1E,Rs2E,Rs1D,Rs2D
    );*/
 decode_cycle decode(PredictedTakenD,FlushE,clk,reset,InstrD,PCD,PCPlus4D, A3, WE3, ResultW,
                   RegWriteE,ResultSrcE,MemWriteE,JumpE,BranchE,ALUSrcE,ALUControlE,
                   RD1E,RD2E,
                   PCE,PCPlus4E,RdE,ImmExIE,
                   funct7E,funct3E,PredictedTakenE,Rs1E,Rs2E,Rs1D,Rs2D
    );

wire start;
wire RegWriteM,MemWriteM,BranchTakenE;
wire [1:0]ResultSrcM,ResultSrcE_b;
wire [31:0] ALUResultM,WriteDataM,PCPlus4M;
wire [4:0] RdM,Rs1E_b,Rs2E_b,RdE_b;
wire [31:0]PCTargetIE;
wire [2:0]funct3M,AlucontrolM;
wire JumpE_b,BranchE_b;
wire [31:0]PCE_b,PCTargetIE_x;
/*module execute_cycle(ForwardA,ForwardB,ALUResultM_b,ResultW,PredictedTakenE,Rs1E,Rs2E,clk,reset,RegWriteE,ResultSrcE,MemWriteE,JumpE,BranchE,ALUSrcE,ALUControlE,
                     RD1E,RD2E,
                     PCE,PCPlus4E,RdE,ImmExIE,
                     funct7E,funct3E,
                     RegWriteM,ResultSrcM,MemWriteM,ALUResultM,WriteDataM,RdM,PCPlus4M,start,
                     PCTargetIE,funct3M,AlucontrolM,BranchTakenE,JumpE_b,BranchE_b,PCE_b,Rs1E_b,Rs2E_b,RdE_b,ResultSrcE_b,PCTargetIE_x       
    );*/
execute_cycle execute(ForwardAE,ForwardBE,ALUResultM_x,ResultW,PredictedTakenE,Rs1E,Rs2E,clk,reset,RegWriteE,ResultSrcE,MemWriteE,JumpE,BranchE,ALUSrcE,ALUControlE,
                     RD1E,RD2E,
                     PCE,PCPlus4E,RdE,ImmExIE,
                     funct7E,funct3E,
                     RegWriteM,ResultSrcM,MemWriteM,ALUResultM,WriteDataM,RdM,PCPlus4M,start,
                     PCTargetIE,funct3M,AlucontrolM,BranchTakenE,JumpE_b,BranchE_b,PCE_b,Rs1E_b,Rs2E_b,RdE_b,ResultSrcE_b,PCTargetIE_x       
    );

wire RegWriteW;
wire [1:0]ResultSrcW;
wire [31:0] ALUResultW,PCPlus4W,ReadDataW;
wire [4:0] RdW;
wire [31:0]ALUResultM_x;
wire [4:0]RdM_x;
wire RegWriteM_x;
/* module memory_cycle(clk,reset,funct3M,AlucontrolM,RegWriteM,ResultSrcM,MemWriteM,ALUResultM,WriteDataM,RdM,PCPlus4M,
               RegWriteW,ResultSrcW,ALUResultW,RdW,PCPlus4W,ReadDataW,RdM_x,RegWriteM_x,ALUResultM_x
    );*/
memory_cycle memory(clk,reset,funct3M,AlucontrolM,RegWriteM,ResultSrcM,MemWriteM,ALUResultM,WriteDataM,RdM,PCPlus4M,
               RegWriteW,ResultSrcW,ALUResultW,RdW,PCPlus4W,ReadDataW,RdM_x,RegWriteM_x,ALUResultM_x
    );

wire WE3;
wire [31:0]ResultW;
wire [4:0]A3;
/*module writeback_cycle(RegWriteW,ResultSrcW,ALUResultW,RdW,PCPlus4W,ReadDataW,
                     WE3,ResultW,A3
    );*/
writeback_cycle writeback(RegWriteW,ResultSrcW,ALUResultW,RdW,PCPlus4W,ReadDataW,
                     WE3,ResultW,A3
    );
endmodule
