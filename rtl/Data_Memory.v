`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2026 19:14:56
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(funct3M,AlucontrolM,A,WD,clk,WE,RD
    );
input [2:0]funct3M,AlucontrolM;
input [31:0]A,WD;
input clk,WE;
output  reg [31:0] RD;

parameter Bus_width=10;
parameter word_length=8;
reg[word_length-1:0]datamemory[0:1023];

always@(*)
begin
if( AlucontrolM==3'b110)
begin
case({funct3M})
                     3'b000:  RD={{24{datamemory[A[9:0]][7]}},datamemory[A[9:0]]};//LB
                     3'b001:RD={{16{datamemory[A[9:0]][7]}},datamemory[A[9:0]+1],datamemory[A[9:0]]} ;//LH
                     3'b010:RD={datamemory[A[9:0]+3],
                                   datamemory[A[9:0]+2],
                                        datamemory[A[9:0]+1],
                                             datamemory[A[9:0]]};//LW
                      3'b100: RD = {{24{1'b0}}, datamemory[A[9:0]]}; //LBU
                      3'b101: RD = {{16{1'b0}},
                                            datamemory[A[9:0] + 1],
                                            datamemory[A[9:0]]}; // LHU
                     default:  RD =0;
                 endcase 

end
end


always @(posedge clk)
begin

 if(WE && AlucontrolM ==3'b010)
 begin
 case (funct3M)

    3'b000: begin
        datamemory[A[9:0]] = WD[7:0];
    end // SB

    3'b001: begin
        datamemory[A[9:0]]     = WD[7:0];
        datamemory[A[9:0] + 1] = WD[15:8];
    end // SH

    3'b010: begin
        datamemory[A[9:0]]     = WD[7:0];
        datamemory[A[9:0] + 1] = WD[15:8];
        datamemory[A[9:0] + 2] = WD[23:16];
        datamemory[A[9:0] + 3] = WD[31:24];
    end // SW

endcase
 end
 end

initial begin
    $readmemh("data_mem.mem",datamemory);
  end
  
endmodule



