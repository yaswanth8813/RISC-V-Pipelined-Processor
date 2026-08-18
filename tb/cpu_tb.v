`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2026 15:42:58
// Design Name: 
// Module Name: cpu_tb
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
//module CPU(input reset,input clk);

module cpu_tb();

reg reset, clk;

CPU dut(
    .reset(reset),
    .clk(clk)
);
initial  
clk   = 1'b0;
// Clock: 10 ns period
always #5 clk = ~clk;

initial
begin
  
    reset = 1'b0;

    // Reset
    #20;
    reset = 1'b1;

    // Let CPU execute
    #300;
    $finish;
end

initial
begin
    $monitor("Time=%0t InstrD=%h",
             $time, dut.fetch.InstrF);
end

endmodule
