`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : WBStage.v
// Description      : This file is the top level file for the WB stage.
////////////////////////////////////////////////////////////////////////////////


module WBStage(

    // --- Inputs ---
    MemToReg,       // Control Signal    
    ALUResult, MemReadData, PCAdder, 
    
    // --- Outputs ---         
    MemToReg_Out    // Write Back Data   
    );             
          
    //--------------------------------
    // Inputs
    //--------------------------------
          
    // Control Signal     
    input [1:0] MemToReg;
    
    input [31:0] ALUResult, MemReadData, PCAdder;
    
    //--------------------------------
    // Outputs
    //--------------------------------
    
    // Register Data
    output wire [31:0] MemToReg_Out;

    //--------------------------------
    // Hardware Components
    //--------------------------------

    Mux32Bit3To1    MemToRegMux(.out(MemToReg_Out), 
                                .inA(MemReadData), 
                                .inB(PCAdder), 
                                .inC(ALUResult), 
                                .sel(MemToReg));

endmodule
