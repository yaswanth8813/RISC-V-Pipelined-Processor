`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2026 19:19:08
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(op,RegWriteD,ResultSrcD,MemWriteD,JumpD,BranchD,ALUSrcD,ImmSrcD
    );
input [6:0]op;
output reg RegWriteD,MemWriteD,JumpD,BranchD,ALUSrcD;
output reg [1:0]ResultSrcD;
output reg [2:0]ImmSrcD;
always @(*)
begin
           RegWriteD=1'b0;
           MemWriteD=1'b0;
           JumpD=1'b0;
           BranchD=1'b0;
           ALUSrcD=1'b0;
           ResultSrcD=2'b00;
           ImmSrcD=3'b000;
case(op)
//default
    //register type    
    7'b0110011: begin
               ResultSrcD=2'b00;
               RegWriteD=1'b1;
               ImmSrcD=3'b000;
               
              /* case({func7,func3})
                     4'b0000: ALUControlD = 3'b000;//add
                     4'b1000: ALUControlD = 3'b001;//sub
                     4'b0001: ALUControlD = 3'b010;//sll
                     4'b0010: ALUControlD = 3'b010;//slt
                     4'b0011: ALUControlD = 3'b011;//sltu
                     4'b0100: ALUControlD = 3'b100;//xor
                     4'b0101: ALUControlD = 3'b101;//srl
                     4'b1101: ALUControlD = 3'b101;//sra
                     4'b0110: ALUControlD = 3'b110;//0r
                     4'b0111: ALUControlD = 3'b111;//and
                     default:  ALUControlD = 3'bxxx;
               endcase */
             end
      //IMMEDIATE type        
     7'b0010011: begin
                ImmSrcD=3'b001;
                RegWriteD=1'b1;
                ResultSrcD=2'b00;
                ALUSrcD=1'b1;
               
               /* case({func3})
                     3'b000: ALUControlD = 3'b000;//addi
                     3'b010: ALUControlD = 3'b010;//slti
                     3'b011: ALUControlD = 3'b011;//SLTIU
                      3'b100: ALUControlD = 3'b100;//XORI
                      3'b110: ALUControlD = 3'b110;//ORI
                       3'b111: ALUControlD = 3'b111;//ANDI
                       3'b001: ALUControlD = 3'b010;//SLLI
                       3'b101: ALUControlD = 3'b010;//SRLI
                       3'b010: ALUControlD = 3'b101;//SRAI
                     default:  ALUControlD = 3'bxxx;
                 endcase */
                end
    //BRANCHING type
    7'b1100011: begin
                ImmSrcD=3'b011;
                ResultSrcD=2'b00;
                BranchD=1'b1;
                ALUSrcD=1'b0;
               
                /*case({func3})
                     3'b000: ALUControlD = 3'b000;//BEQ
                     3'b001: ALUControlD = 3'b001;//BNE
                     3'b100: ALUControlD = 3'b010;//BLT
                      3'b101: ALUControlD = 3'b011;//BGE
                      3'b110: ALUControlD = 3'b100;//BLTU
                      3'b111: ALUControlD = 3'b101;//BGEU
                     default:  ALUControlD = 3'bxxx;
                 endcase */
                end
                
       //store type
     7'b0100011: begin 
           MemWriteD=1'b1;
           ALUSrcD=1'b1;
           ImmSrcD=3'b010;
          
               /* case({func3})
                     3'b000: ALUControlD = 3'b000;//SB
                     3'b001: ALUControlD = 3'b001;//SH
                     3'b010: ALUControlD = 3'b010;//SW
                     default:  ALUControlD = 3'bxxx;
                 endcase */
                end
     //load(immediate) type           
     7'b0000011: begin 
           RegWriteD=1'b1;
           ResultSrcD = 2'b01;
           ALUSrcD=1'b1;
           ImmSrcD=3'b110;
          
               /* case({func3})
                     3'b000: ALUControlD = 3'b000;//LB
                     3'b001: ALUControlD = 3'b001;//LH
                     3'b010: ALUControlD = 3'b010;//LW
                      3'b100: ALUControlD = 3'b011;//LBU
                      3'b101: ALUControlD = 3'b100;//LHU
                     default:  ALUControlD = 3'bxxx;
                 endcase */
                end
       //JUMP TYPE
       7'b1101111: begin 
           JumpD=1'b1;
           ALUSrcD=1'b1;
           ImmSrcD=3'b101;
           ResultSrcD = 2'b10;
           RegWriteD =1'b1;
               /* case({func3})
                     3'b000: ALUControlD = 3'b000;//jal
                     default:  ALUControlD = 3'bxxx;
                 endcase */
                end          
      
    default:
         begin
           RegWriteD=1'b0;
           MemWriteD=1'b0;
           JumpD=1'b0;
           BranchD=1'b0;
           ALUSrcD=1'b0;
           ResultSrcD=2'b00;
           ImmSrcD=2'b00;
      
        end
endcase
end
endmodule
