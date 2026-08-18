`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2026 19:55:31
// Design Name: 
// Module Name: fetch_cycle
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


module fetch_cycle(StallF,StallD,FlushD,PredictedTargetF,PredictedTakenF,reset,PC_input,clk,start,InstrD,PCD,PCPlus4D,PredictedTakenD,PCF_b
    );
input reset,start;
input clk,PredictedTakenF;
input StallF,StallD,FlushD;
input [31:0]PC_input,PredictedTargetF;
output reg [31:0] InstrD,PCD,PCPlus4D;
output reg PredictedTakenD;
output [31:0]PCF_b;
reg [31:0]PCF;
wire [31:0] PCPlus4F,InstrF,PCF_in,mux_out;
assign PCF_b=PCF;
//module register_pipo(clk,in,reset,out);
//register_pipo pc(.clk(clk),.in(PCF_in),.reset(reset),.out(PCF));
//module instruction_memory(reset,address,data);
instruction_memory mem(.reset(reset),.address(PCF),.data(InstrF));
//module addplus4( address,out );
addplus4 add(.address(PCF),.out(PCPlus4F));
//module mux2_1(a,b,s,y);
mux2_1 mux1(.a(PC_input),.b(mux_out),.s(start),.y(PCF_in));
mux2_1 mux2(.a(PredictedTargetF),.b(PCPlus4F),.s(PredictedTakenF),.y(mux_out));
always @(posedge clk or negedge reset)
begin
  if(!reset)
      begin
       PCF<=0;
       InstrD<=0;
       PCD<=0;
       PCPlus4D<=0;
       PredictedTakenD<=0;
      end
   else 
     begin
       if(!StallF)
       begin
        PCF<=PCF_in;
       end
       
       if(FlushD)
        begin
       InstrD<=0;
       PCD<=0;
       PCPlus4D<=0;
       PredictedTakenD<=0;        
        end
      else if(!StallD)
       begin
         InstrD<=InstrF;
         PCD<=PCF;
         PCPlus4D<=PCPlus4F;
         PredictedTakenD<=PredictedTakenF;
      end
     end
  end
//register_pipo IF_ID_InstrD(.clk(clk),.in(InstrF),.reset(reset),.out(InstrD));
//register_pipo IF_ID_PCF(.clk(clk),.in(PCF),.reset(reset),.out(PCD));
//register_pipo IF_ID_PCPlus4F(.clk(clk),.in(PCPlus4F),.reset(reset),.out(PCPlus4D));
endmodule
