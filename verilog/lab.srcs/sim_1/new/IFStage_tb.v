`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : IFStage_tb.v
// Description      : Test bench for the IFStage
////////////////////////////////////////////////////////////////////////////////

module IFStage_tb();
    
    reg Clock, Reset, JumpControl, BranchControl;
    reg PCWrite;
    
    reg [31:0] JumpAddress, BranchAddress;
    
    wire [31:0] Instruction, PCAdder_Out;
    
    IFStage     IFStage_Test(Clock, Reset, JumpControl, BranchControl, PCWrite,                    
                             JumpAddress, BranchAddress, Instruction, PCAdder_Out);
    
    always begin    
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
    end
    
    initial begin
        #100 BranchControl <= 1'b0; JumpControl <= 1'b0; PCWrite <= 1'b1; JumpAddress <= 32'd0; BranchAddress <= 32'd0; 
    
        Reset <= 1;
        @(posedge Clock);
        #100 Reset <= 0; 
        
        @(posedge Clock);
        #500 BranchControl <= 1'b1; JumpControl <= 1'b0; PCWrite <= 1'b1; JumpAddress <= 32'd0; BranchAddress <= 32'd24;  
        #100 BranchControl <= 1'b0; JumpControl <= 1'b0; PCWrite <= 1'b1; JumpAddress <= 32'd0; BranchAddress <= 32'd0; 

        @(posedge Clock);        
        #500 BranchControl <= 1'b0; JumpControl <= 1'b1; PCWrite <= 1'b1; JumpAddress <= 32'd48; BranchAddress <= 32'd0;  
        #100 BranchControl <= 1'b0; JumpControl <= 1'b0; PCWrite <= 1'b1; JumpAddress <= 32'd0; BranchAddress <= 32'd0; 
              
    end 

endmodule