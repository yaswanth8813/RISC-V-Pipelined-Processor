`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2026 16:24:00
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(clk,A1,A2,A3,WD3,WE3,RD1,RD2
    );
 input [4:0] A1,A2,A3;
 input [31:0]WD3;
 input WE3,clk;
 output [31:0] RD1,RD2;
 reg [31:0]registermem[0:31];
 assign RD1=registermem[A1];
 assign RD2=registermem[A2];
 //assign registermem[A3]= WE3 ? WD3 : registermem[A3] ;
   always @(negedge clk)
    begin
        if (WE3)
            registermem[A3] <= WD3;
    end
    
    initial begin
    $readmemh("register_mem.mem",registermem);
  end
endmodule
