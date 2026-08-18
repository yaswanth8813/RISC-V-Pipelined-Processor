`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2026 17:41:28
// Design Name: 
// Module Name: mux
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


module mux2_1(a,b,s,y
    );
input [31:0]a,b;
input s;
output [31:0]y;
assign y= s?a:b;
endmodule



module mux3_1(a,b,c,s,y
     );
input [31:0]a,b,c;
input [1:0]s;
output reg [31:0]y;

always @(*)
begin
case(s)
  2'b00:y=a;
  2'b01:y=b;
  2'b10:y=c;
  default: y=32'h000;
endcase
end   
endmodule




