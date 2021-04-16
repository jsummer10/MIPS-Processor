`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : WBStage_tb.v
// Description      : Test bench for the WBStage
////////////////////////////////////////////////////////////////////////////////

module WBStage_tb();

    reg [1:0] MemToReg;
    reg [31:0] ALUResult, MemReadData, PCAdder;

    wire [31:0] MemToReg_Out;

    WBStage     WBStage_Test(
        // --- Inputs ---
        MemToReg,       // Control Signal    
        ALUResult, MemReadData, PCAdder, 
        
        // --- Outputs ---         
        MemToReg_Out    // Write Back Data
        );


endmodule