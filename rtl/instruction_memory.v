`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2026 19:04:02
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(reset,address,data
    );
    
parameter Bus_width=10;
parameter word_length=8;
input reset;
input [31:0]address;
output [31:0]data;
reg[word_length-1:0]memory[0:1023];

assign  data={memory[address[Bus_width-1:0]+3],
        memory[address[Bus_width-1:0]+2],
        memory[address[Bus_width-1:0]+1],
        memory[address[Bus_width-1:0]]
        };
        
  initial begin
    $readmemh("memfile.mem",memory);
  end
endmodule
