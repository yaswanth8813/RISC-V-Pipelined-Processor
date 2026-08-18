`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.08.2026 15:45:50
// Design Name: 
// Module Name: branch_prediction
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


module branch_prediction(
    input clk,
    input reset,

    // ==========================
    // FETCH STAGE
    // ==========================
    input  [31:0] PCF,
    output       PredictedTakenF,
    output  reg [31:0] PredictedTargetF,

    // ==========================
    // EXECUTE STAGE
    // ==========================
    input         BranchE,
    input         JumpE,
    input  [31:0] PCE,
    input         BranchTakenE,
    input  [31:0] PCTargetE
);
 wire [4:0]indexF,indexE;
 assign indexF=PCF[6:2];
 assign indexE=PCE[6:2];
// BTB memory 
reg BTB_valid[0:31];
reg [31:0]BTB_tag[0:31];
reg [31:0]BTB_target[0:31];

always @(*)
begin
  if(BTB_valid[indexF]==1'b1 && BTB_tag[indexF]==PCF)
   begin
      PredictedTargetF=BTB_target[indexF];
   end
   else
     PredictedTargetF=32'b0;
end

reg [1:0]PHT[0:31];
assign PredictedTakenF = PHT[indexF][1];

//BTB AND PHT UPDATION
integer i;
always @(posedge clk or negedge reset)
begin
 if(!reset)
    begin
      for(i=0;i<32;i=i+1)
        begin
          PHT[i]<=2'b01;
          BTB_valid[i]<=1'b0;
        end
    end
  else if(BranchE || JumpE)
           begin
        BTB_valid[indexE] <=1'b1;
       BTB_tag[indexE] <= PCE;
       BTB_target[indexE] <= PCTargetE;
        if(JumpE)
              PHT[indexE] <= 2'b11;
        if(BranchTakenE) 
          begin
              if(PHT[indexE] !=2'b11)
               PHT[indexE] <= PHT[indexE]+1'b1;
          end
        else
           begin
              if(PHT[indexE] !=2'b00)
              PHT[indexE] <= PHT[indexE]-1'b1;
           end
     end
end
endmodule
