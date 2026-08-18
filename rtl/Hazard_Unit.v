`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2026 19:21:21
// Design Name: 
// Module Name: Hazard_Unit
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


module Hazard_Unit(
           // Decode stage
    input [4:0] Rs1D,
    input [4:0] Rs2D,

    // Execute stage
    input [4:0] Rs1E,
    input [4:0] Rs2E,
    input [4:0] RdE,

    // Memory stage
    input [4:0] RdM,
    input RegwriteM,

    // Write-back stage
    input [4:0] RdW,
    input RegwriteW,

    // Execute-stage instruction is a load
    input [1:0] ResultsrcE,

    // Branch / jump decision
    input start,

    // Outputs
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE,

    output reg StallF,
    output reg StallD,

    output reg FlushD,
    output  FlushE
);

//operator forwarding
always @(*)
begin
   if((Rs1E==RdM)& RegwriteM & Rs1E!=0)
      ForwardAE =2'b10;
   else if((Rs1E==RdW)& RegwriteW & Rs1E!=0)
      ForwardAE =2'b01;
    else
      ForwardAE =2'b00;
      
      
       if((Rs2E==RdM)& RegwriteM & Rs2E!=0)
      ForwardBE =2'b10;
   else if((Rs2E==RdW)& RegwriteW & Rs2E!=0)
      ForwardBE =2'b01;
    else
      ForwardBE =2'b00;
      
end

//load-dependency stalling
reg FlushE_1,FlushE_2;

assign FlushE = (FlushE_1 | FlushE_2);

always @(*)
begin
   if((((Rs1D==RdE)& (Rs1D!=0))| ((Rs2D==RdE)& (Rs2D!=0))) & (ResultsrcE==2'b10) )
   begin
     StallF = 1;
     StallD = 1;
     FlushE_1 =1;
   end
   else
    begin
      StallF = 0;
      StallD = 0;
      FlushE_1 =0;
    end
end

//control flush

always @(*)
begin
   if(start)
     begin
      FlushD =1;
      FlushE_2 = 1;
      end
   else
     begin
      FlushD =0;
      FlushE_2 = 0;
      end
end

endmodule
