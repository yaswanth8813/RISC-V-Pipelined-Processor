`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2026 16:52:42
// Design Name: 
// Module Name: execute_cycle
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

/*module decode_cycle(clk,reset,InstrD,PCD,PCPlus4D, A3, WE3, WD3,
                   RegWriteE,ResultSrcE,MemWriteE,JumpE,BranchE,ALUSrcE,ALUControlE,
                   RD1E,RD2E,
                   PCE,PCPlus4E,RdE,ImmExIE,
                   funct7E,funct3E
    );*/
module execute_cycle(ForwardA,ForwardB,ALUResultM_b,ResultW,PredictedTakenE,Rs1E,Rs2E,clk,reset,RegWriteE,ResultSrcE,MemWriteE,JumpE,BranchE,ALUSrcE,ALUControlE,
                     RD1E,RD2E,
                     PCE,PCPlus4E,RdE,ImmExIE,
                     funct7E,funct3E,
                     RegWriteM,ResultSrcM,MemWriteM,ALUResultM,WriteDataM,RdM,PCPlus4M,start,
                     PCTargetIE,funct3M,AlucontrolM,BranchTakenE,JumpE_b,BranchE_b,PCE_b,Rs1E_b,Rs2E_b,RdE_b,ResultSrcE_b,PCTargetIE_x       
    );
input clk,reset,RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE,funct7E,PredictedTakenE;
input[2:0]funct3E,ALUControlE;
input[31:0] ImmExIE,RD1E,RD2E,PCE ,PCPlus4E,ALUResultM_b,ResultW;
input [4:0]RdE,Rs1E,Rs2E;
input [1:0]ResultSrcE,ForwardA,ForwardB;
output start;
output reg [2:0]funct3M,AlucontrolM;
output  reg RegWriteM,MemWriteM;
output reg [1:0]ResultSrcM;
output reg [31:0] ALUResultM,WriteDataM,PCPlus4M;
output reg [4:0] RdM;
output [31:0]PCTargetIE,PCTargetIE_x,PCE_b;
output BranchTakenE,JumpE_b,BranchE_b;
output [4:0]Rs1E_b,Rs2E_b,RdE_b;
output [1:0]ResultSrcE_b;
assign Rs1E_b=Rs1E;
assign Rs2E_b=Rs2E;
assign RdE_b=RdE;
assign ResultSrcE_b=ResultSrcE;
assign JumpE_b=JumpE;
assign BranchE_b=BranchE;
assign PCE_b=PCE;
wire [31:0]SrcBE,SrcBE_x,SrcAE,ALUResultE,PCTargetIE;
wire ZeroE;
//module ALU(funct7,funct3,ALUControlE,SrcAE,SrcBE,ALUResultE,ZeroE);
ALU A1(.funct7(funct7E),.funct3(funct3E),.ALUControlE(ALUControlE),.SrcAE(SrcAE),.SrcBE(SrcBE),.ALUResultE(ALUResultE),.ZeroE(ZeroE));

//module add_cond(PCE,ImmExIE,out);
add_cond add(.PCE(PCE),.ImmExIE(ImmExIE),.out(PCTargetIE_x));

//module mux2_1(a,b,s,y);
mux2_1 m3(.b(SrcBE_x),.a(ImmExIE),.s(ALUSrcE),.y(SrcBE));
//module mux3_1(a,b,c,s,y);
mux3_1 m1(.a(RD1E),.b(ResultW),.c(ALUResultM_b),.s(ForwardA),.y(SrcAE));
mux3_1 m2(.a(RD2E),.b(ResultW),.c(ALUResultM_b),.s(ForwardB),.y(SrcBE_x));

wire address_select;
mux2_1 address(.b(PCTargetIE_x),.a(PCPlus4E),.s(PredictedTakenE),.y(PCTargetIE));

assign BranchTakenE = ZeroE & BranchE;
assign start= ((BranchTakenE ^ PredictedTakenE)|(JumpE & (~PredictedTakenE)));
always @(posedge clk or negedge reset)
begin
  if(!reset)
      begin
        RegWriteM<=0;
        ResultSrcM<=0;
        MemWriteM<=0;
        ALUResultM<=0;
        WriteDataM<=0;
        RdM<=0;
        PCPlus4M<=0;
        funct3M<=0;
        AlucontrolM<=0;
      end
   else
       begin
          RegWriteM<=RegWriteE;
          ResultSrcM<=ResultSrcE;
          MemWriteM<=MemWriteE;
          ALUResultM<=ALUResultE;
          WriteDataM<=SrcBE_x;
          RdM<=RdE;
          PCPlus4M<=PCPlus4E;
          funct3M<=funct3E; 
          AlucontrolM<=ALUControlE;
       end
end
endmodule
