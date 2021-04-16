`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : HazardDetectionUnit.v
// Description      : This file controls the hazard detection unit
////////////////////////////////////////////////////////////////////////////////

module HazardDetectionUnit(

    // --- Inputs ---
    OpCode, Func,                   // Instruction
    RegRS_IFID, RegRT_IFID,             // Read Registers
    
    // ID/EX
    RegRT_IDEX, RegRD_IDEX,         // Registers
    RegWrite_IDEX, MemRead_IDEX,    // Signals
    RegDst_IDEX,            

    // EX/MEM
    RegisterDst_EXMEM, RegWrite_EXMEM, 
    
    // --- Outputs ---  
    PCWrite, IFIDWrite, ControlStall, BPUpdateEn, BranchFlush); // Hazard Signals

    //--------------------------------
    // Inputs
    //--------------------------------
    
    input [5:0] OpCode, Func;
    
    input MemRead_IDEX, RegWrite_EXMEM, RegWrite_IDEX;
    input [1:0] RegDst_IDEX;
    input [4:0] RegRS_IFID, RegRT_IFID;
    input [4:0] RegRT_IDEX, RegRD_IDEX; 
    input [4:0] RegisterDst_EXMEM;

    //--------------------------------
    // Outputs
    //--------------------------------

    output reg PCWrite, IFIDWrite, ControlStall, BPUpdateEn, BranchFlush;
    
    //--------------------------------
    // Local Param                        
    //--------------------------------
    
    // OpCodes
    localparam [5:0] JR     = 6'b000000,
                     BGEZ   = 6'b000001,
                     BLTZ   = 6'b000001,
                     BEQ    = 6'b000100,
                     BNE    = 6'b000101,
                     BLEZ   = 6'b000110,
                     BGTZ   = 6'b000111;

    //--------------------------------
    // Hazard Detection Logic
    //--------------------------------

    initial begin
        PCWrite      <= 1'b1;
        IFIDWrite    <= 1'b1;
        ControlStall <= 1'b0;
        BPUpdateEn   <= 1'b1;
        BranchFlush  <= 1'b1;
    end
    
    always @ (*) begin

        // Load in EX and depedency in ID 
        if (MemRead_IDEX && (( RegDst_IDEX == 2'b0 && ((RegRT_IDEX == RegRS_IFID) || (RegRT_IDEX == RegRT_IFID)) ) || 
                             ( RegDst_IDEX == 2'b1 && ((RegRD_IDEX == RegRS_IFID) || (RegRD_IDEX == RegRT_IFID)) ))) begin
            
            PCWrite      <= 1'b0;
            IFIDWrite    <= 1'b0;
            ControlStall <= 1'b1;
            BPUpdateEn   <= 1'b0;
            BranchFlush  <= 1'b1;
        
        end
        
        // Branch (rs and rt): RegWrite in EX and depedency in ID
        else if ( (OpCode == BEQ || OpCode == BNE) && 
                  RegWrite_IDEX && (( RegDst_IDEX == 2'b0 && ((RegRT_IDEX == RegRS_IFID) || (RegRT_IDEX == RegRT_IFID)) ) || 
                                    ( RegDst_IDEX == 2'b1 && ((RegRD_IDEX == RegRS_IFID) || (RegRD_IDEX == RegRT_IFID)) )) ) begin
            
            PCWrite      <= 1'b0;
            IFIDWrite    <= 1'b0;
            ControlStall <= 1'b1;
            BPUpdateEn   <= 1'b0;
            BranchFlush  <= 1'b0;
        
        end
        
        // Branch (just rs): RegWrite in EX and depedency in ID
        else if ( (OpCode == BGEZ || OpCode == BGTZ || OpCode == BLEZ || OpCode == BLTZ) && 
                  RegWrite_IDEX && (( RegDst_IDEX == 2'b0 && RegRT_IDEX == RegRS_IFID ) || 
                                    ( RegDst_IDEX == 2'b1 && RegRD_IDEX == RegRS_IFID )) ) begin
            
            PCWrite      <= 1'b0;
            IFIDWrite    <= 1'b0;
            ControlStall <= 1'b1;
            BPUpdateEn   <= 1'b0;
            BranchFlush  <= 1'b0;
        
        end
        
        // JR in ID and JAL in EX or MEM
        else if ( OpCode == JR && Func == 6'b001000 && 
                  ((RegWrite_IDEX && RegDst_IDEX == 2'b10) || (RegWrite_EXMEM && RegisterDst_EXMEM == 5'd31)) ) begin
        
            PCWrite      <= 1'b0;
            IFIDWrite    <= 1'b0;
            ControlStall <= 1'b1;
            BPUpdateEn   <= 1'b0;
            BranchFlush  <= 1'b1;
        
        end
        
        // JR in ID and lw in EX or MEM
        else if ( OpCode == JR && Func == 6'b001000 && 
                  ((RegWrite_IDEX && (RegRT_IDEX == RegRS_IFID || RegRD_IDEX == RegRS_IFID)) || 
                  (RegWrite_EXMEM && RegisterDst_EXMEM == RegRS_IFID)) ) begin
        
            PCWrite      <= 1'b0;
            IFIDWrite    <= 1'b0;
            ControlStall <= 1'b1;
            BPUpdateEn   <= 1'b0;
            BranchFlush  <= 1'b1;
        
        end
        
        else begin
        
            PCWrite      <= 1'b1;
            IFIDWrite    <= 1'b1;
            ControlStall <= 1'b0;
            BPUpdateEn   <= 1'b1;
            BranchFlush  <= 1'b1;
            
        end
		       
    end

endmodule