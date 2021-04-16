`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : MEMStage.v
// Description      : This file is the top level file for the MEM stage.
////////////////////////////////////////////////////////////////////////////////


module MEMStage(

    // --- Inputs ---
    Clock,               // System Inputs
    MemWrite, MemRead, ByteSig, // Control Signals
    ALUResult,                  // ALU Outputs 
    RegRTData,                  // Register Data
    
    // --- Outputs ---         
    MemReadData         // Memory Output     
    );             
          
    //--------------------------------
    // Inputs
    //--------------------------------
          
    // System Inputs
    input Clock;
          
    // Control Signals     
    input MemWrite, MemRead;
    input [1:0] ByteSig;
    
    // ALU Outputs
    input [31:0] ALUResult;
    
    // Memory Write Data
    input [31:0] RegRTData;
    
    //--------------------------------
    // Outputs
    //--------------------------------
    
    // Register Data
    output wire [31:0] MemReadData;

    //--------------------------------
    // Hardware Components
    //--------------------------------

    DataMemory      DataMem(.Address(ALUResult), 
                            .WriteData(RegRTData), 
                            .Clock(Clock), 
                            .MemWrite(MemWrite), 
                            .MemRead(MemRead), 
                            .ReadData(MemReadData),
                            .ByteSig(ByteSig));

endmodule
