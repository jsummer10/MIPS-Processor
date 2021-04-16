`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : MEMStage_tb.v
// Description      : Test bench for the MEMStage_tb
////////////////////////////////////////////////////////////////////////////////

module MEMStage_tb();

    reg        Clock, Reset, MemWrite, MemRead;
    reg [1:0]  ByteSig;
    reg [31:0] ALUResult, RegRTData;
    
    wire [31:0] MemReadData;
    
    MEMStage    MEMStage_Test(
    
        // --- Inputs ---
        Clock, Reset,               // System Inputs
        MemWrite, MemRead, ByteSig, // Control Signals
        ALUResult,                  // ALU Outputs 
        RegRTData,                  // Register Data
        
        // --- Outputs ---         
        MemReadData         // Memory Output     
        );       

    always begin    
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
    end
    
    initial begin
    
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd0; RegRTData <= 32'd0; ByteSig <= 2'd0; 
    
        Reset <= 1;
        @(posedge Clock);
        #100 Reset <= 0; 
        
        // Write Memory
        #100 MemWrite <= 1'b1; MemRead <= 1'b0; ALUResult <= 32'd00; RegRTData <= 32'd05; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b1; MemRead <= 1'b0; ALUResult <= 32'd04; RegRTData <= 32'd10; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b1; MemRead <= 1'b0; ALUResult <= 32'd08; RegRTData <= 32'd15; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b1; MemRead <= 1'b0; ALUResult <= 32'd12; RegRTData <= 32'd20; ByteSig <= 2'd1; // sh - lower
        #100 MemWrite <= 1'b1; MemRead <= 1'b0; ALUResult <= 32'd14; RegRTData <= 32'd21; ByteSig <= 2'd1; // sh - upper
        #100 MemWrite <= 1'b1; MemRead <= 1'b0; ALUResult <= 32'd16; RegRTData <= 32'd25; ByteSig <= 2'd2; // sb - Byte 0
        #100 MemWrite <= 1'b1; MemRead <= 1'b0; ALUResult <= 32'd17; RegRTData <= 32'd26; ByteSig <= 2'd2; // sb - Byte 1
        #100 MemWrite <= 1'b1; MemRead <= 1'b0; ALUResult <= 32'd18; RegRTData <= 32'd27; ByteSig <= 2'd2; // sb - Byte 2
        #100 MemWrite <= 1'b1; MemRead <= 1'b0; ALUResult <= 32'd19; RegRTData <= 32'd28; ByteSig <= 2'd2; // sb - Byte 3
        #100 MemWrite <= 1'b1; MemRead <= 1'b0; ALUResult <= 32'd48; RegRTData <= 32'd50; ByteSig <= 2'd0;
        
        // Don't Write Memory
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd00; RegRTData <= 32'd95; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd04; RegRTData <= 32'd90; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd08; RegRTData <= 32'd85; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd12; RegRTData <= 32'd80; ByteSig <= 2'd0; 
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd16; RegRTData <= 32'd75; ByteSig <= 2'd0;
        
        // Read Memory
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd00; RegRTData <= 32'd00; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd04; RegRTData <= 32'd00; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd08; RegRTData <= 32'd00; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd12; RegRTData <= 32'd00; ByteSig <= 2'd1; // lh - lower
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd14; RegRTData <= 32'd00; ByteSig <= 2'd1; // lh - upper
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd16; RegRTData <= 32'd00; ByteSig <= 2'd2; // lb - Byte 0
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd17; RegRTData <= 32'd00; ByteSig <= 2'd2; // lb - Byte 1
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd18; RegRTData <= 32'd00; ByteSig <= 2'd2; // lb - Byte 2
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd19; RegRTData <= 32'd00; ByteSig <= 2'd2; // lb - Byte 3
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd12; RegRTData <= 32'd00; ByteSig <= 2'd0; // 12 = 1376276
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd16; RegRTData <= 32'd00; ByteSig <= 2'd0; // 16 = 471538201
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd48; RegRTData <= 32'd00; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b0; MemRead <= 1'b1; ALUResult <= 32'd12; RegRTData <= 32'd00; ByteSig <= 2'd3; // lui
        
        // Don't Read Memory
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd00; RegRTData <= 32'd00; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd04; RegRTData <= 32'd00; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd08; RegRTData <= 32'd00; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd12; RegRTData <= 32'd00; ByteSig <= 2'd0;
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd16; RegRTData <= 32'd00; ByteSig <= 2'd0;      
 
        // Zero
        #100 MemWrite <= 1'b0; MemRead <= 1'b0; ALUResult <= 32'd00; RegRTData <= 32'd00; ByteSig <= 2'd0;
    end

endmodule