`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2026 14:12:06
// Design Name: 
// Module Name: ALU
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


module ALU(funct7,funct3,ALUControlE,SrcAE,SrcBE,ALUResultE,ZeroE
    );
 input funct7;
 input [2:0]funct3;
 input [2:0]ALUControlE;
 input [31:0] SrcAE,SrcBE;
 output reg [31:0]ALUResultE;
 output reg ZeroE;
 always @(*)
 begin
   ZeroE = 1'b0;
 case(ALUControlE)
      
      3'b000: begin
      //Register type
                  case({funct7,funct3})
                     4'b0000: ALUResultE = SrcAE+SrcBE;//add
                     4'b1000: ALUResultE = SrcAE-SrcBE;//sub
                     4'b0001: ALUResultE = SrcAE<<SrcBE[4:0];//sll
                     4'b0010: ALUResultE = ($signed(SrcAE) < $signed(SrcBE)) ? 32'd1 : 32'd0;//slt
                     4'b0011: ALUResultE = (SrcAE<SrcBE)? 1:0;//sltu
                     4'b0100: ALUResultE = SrcAE^SrcBE;//xor
                     4'b0101: ALUResultE = SrcAE>>SrcBE[4:0];//srl
                     4'b1101: ALUResultE = $signed(SrcAE) >>> SrcBE[4:0];//sra
                     4'b0110: ALUResultE = SrcAE|SrcBE;//0r
                     4'b0111: ALUResultE = SrcAE&SrcBE;//and
                     default: ALUResultE = 32'd0;
                   endcase
         end
         
         
       //immediate type
       3'b001: begin
                 case(funct3)
                     3'b000: ALUResultE = SrcAE+SrcBE;//addi
                     3'b010: ALUResultE = SrcAE-SrcBE;//slti
                     3'b011: ALUResultE =(SrcAE<SrcBE)? 1:0;//SLTIU
                      3'b100: ALUResultE = SrcAE^SrcBE;//XORI
                      3'b110: ALUResultE = SrcAE|SrcBE;//ORI
                       3'b111: ALUResultE = SrcAE&SrcBE;//ANDI
                       3'b001: ALUResultE = SrcAE<<SrcBE[4:0];//SLLI
                       3'b101: ALUResultE = SrcAE>>SrcBE[4:0];//SRLI
                       //3'b010: ALUResultE = $signed(SrcAE) >>> SrcBE[4:0];//SRAI
                        default: ALUResultE = 32'd0;
                  endcase
         end
        
       //store type
       3'b010:  ALUResultE = SrcAE+SrcBE;
       
       //Branch type
       3'b011:
           begin
               ALUResultE = 32'd0;
              case(funct3)
                     3'b000: ZeroE = (SrcAE==SrcBE);//BEQ
                     3'b001: ZeroE = (SrcAE!=SrcBE);//BNE
                     3'b100: ZeroE = ($signed(SrcAE) < $signed(SrcBE));//BLT
                      3'b101: ZeroE =($signed(SrcAE) >= $signed(SrcBE));//BGE
                      3'b110: ZeroE = (SrcAE<SrcBE);//BLTU
                      3'b111: ZeroE = (SrcAE>=SrcBE);//BGEU
                     default: ZeroE = 1'b0;
                 endcase
             end
        //Load(immediate) type
        3'b110: 
                ALUResultE = SrcAE+SrcBE;
             
        default: 
               begin
                ALUResultE = 32'dx;
                ZeroE=1'b0;
               end
    endcase            
 end
endmodule
