`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : IDStage_tb.v
// Description      : Test bench for the ForwardingUnit
////////////////////////////////////////////////////////////////////////////////

module IDStage_tb();
    
    // System Inputs
    reg Clock, Reset;
          
    // Control Signals     
    reg RegWrite, MemRead_IDEX;
    reg RegWrite_IDEX, RegWrite_EXMEM;
    
    reg [1:0] RegDst_IDEX; 
    
    // Data
    reg [31:0] Instruction, PCAdder;
    
    reg [4:0] RegRT_IDEX, RegRD_IDEX;
    
    reg [4:0] RegisterDst_EXMEM;
    
    // Write Register Data
    reg [4:0]  WriteRegister;
    reg [31:0] WriteData;
    
    //--------------------------------
    // Outputs
    //--------------------------------
    
    // Control Signal
    wire JumpControl, BranchControl;
    wire [31:0] ControlSignal_Out;
    
    // Register Data
    wire [31:0] ReadData1, ReadData2;
    
    // Immediate value
    wire [31:0] SignExtend_Out;
    
    // Hazard Signals
    wire PCWrite, IFIDWrite;
    
    // Flush Register
    wire Flush_IF;
    
    // PC Addresses
    wire [31:0] BranchAddress, JumpAddress;
    
    IDStage     IDStage_Test(
    
        // --- Inputs ---
        Clock, Reset,               // System Inputs
        RegWrite, MemRead_IDEX,     // Control Signals
        WriteRegister, WriteData,   // Write data
        Instruction, 
        RegRT_IDEX, RegRD_IDEX, RegDst_IDEX,
        RegWrite_IDEX, RegWrite_EXMEM,
        RegisterDst_EXMEM,
        PCAdder,            
        
        // --- Outputs ---         
        ControlSignal_Out, JumpControl, BranchControl, // Control Signals
        ReadData1, ReadData2,       // Register Data
        SignExtend_Out,             // Immediate value
        PCWrite, IFIDWrite,         // Hazard Signals    
        BranchAddress, JumpAddress, Flush_IF
        
    );
    
    always begin    
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
    end
    
    initial begin
    
        // ------------------------------------------------------------------------------
        Instruction <= 32'b0; PCAdder <= 32'd0;                         // From IF
        RegWrite <= 1'b0; WriteRegister <= 5'd0; WriteData <= 32'd0;    // Write Back 
        MemRead_IDEX <= 1'b0; RegRT_IDEX <= 5'd0;                         // Hazard Control
        // ------------------------------------------------------------------------------
         
        Reset <= 1;
        @(posedge Clock);
        #100 Reset <= 0; 
           
        //----------------------------------
        // Write Register Tests
        //----------------------------------
        
        // Write Data
        #100 RegWrite <= 1'b1; WriteRegister <= 5'd09; WriteData <= 32'd09;  // t1 = 09
        #100 RegWrite <= 1'b1; WriteRegister <= 5'd10; WriteData <= 32'd10;  // t2 = 10
        #100 RegWrite <= 1'b1; WriteRegister <= 5'd11; WriteData <= 32'd11;  // t3 = 11
        #100 RegWrite <= 1'b1; WriteRegister <= 5'd12; WriteData <= 32'd12;  // t4 = 12
        #100 RegWrite <= 1'b1; WriteRegister <= 5'd13; WriteData <= 32'd13;  // t5 = 13
        
        // Don't Write Data
        #100 RegWrite <= 1'b0; WriteRegister <= 5'd09; WriteData <= 32'd99;  // t1 = 99
        #100 RegWrite <= 1'b0; WriteRegister <= 5'd10; WriteData <= 32'd98;  // t2 = 98
        #100 RegWrite <= 1'b0; WriteRegister <= 5'd11; WriteData <= 32'd97;  // t3 = 97
        #100 RegWrite <= 1'b0; WriteRegister <= 5'd12; WriteData <= 32'd96;  // t4 = 96
        #100 RegWrite <= 1'b0; WriteRegister <= 5'd13; WriteData <= 32'd95;  // t5 = 95
          
        // Zero
        #100 RegWrite <= 1'b0; WriteRegister <= 5'd0; WriteData <= 32'd0;    // reset to zero
         
        //----------------------------------
        // Instruction Tests
        //----------------------------------

        #400 PCAdder <= 32'd4; Instruction <= 32'h012A5820;  // ADD  : 11 = 9 + 10      ; Control Signal : 518
        #100 PCAdder <= 32'd8; Instruction <= 32'h21490004;  // ADDI : 11 = 9 + addi(4) ; Control Signal : 10246
 
        #100 PCAdder <= 32'd0; Instruction <= 32'h0;         // Zero
 
        //----------------------------------
        // Hazard Tests
        //----------------------------------
        
        // Stall
        #400 PCAdder <= 32'd12; Instruction <= 32'h012A5820;  // ADD : 11 = 9 + 10
        MemRead_IDEX <= 1'b1; RegRT_IDEX <= 5'd9;     // lw -> 9
        
        #100 PCAdder <= 32'd16; Instruction <= 32'h012A5820;  // ADD : 11 = 9 + 10
        MemRead_IDEX <= 1'b1; RegRT_IDEX <= 5'd10;    // lw -> 10
 
        // No Stall
        #100 PCAdder <= 32'd20; Instruction <= 32'h012A5820;  // ADD : 11 = 9 + 10
        MemRead_IDEX <= 1'b0; RegRT_IDEX <= 5'd9;     // lw -> 9
        
        #100 PCAdder <= 32'd24; Instruction <= 32'h012A5820;  // ADD : 11 = 9 + 10
        MemRead_IDEX <= 1'b0; RegRT_IDEX <= 5'd10;    // lw -> 10
        
        #100 PCAdder <= 32'd28; Instruction <= 32'h012A5820;  // ADD : 11 = 9 + 10
        MemRead_IDEX <= 1'b1; RegRT_IDEX <= 5'd12;    // lw -> 12
 
        #100 PCAdder <= 32'd32; Instruction <= 32'h012A5820;  // ADD : 11 = 9 + 10
        MemRead_IDEX <= 1'b1; RegRT_IDEX <= 5'd11;    // lw -> 11
        
        // Zero
        #100 PCAdder <= 32'd0; Instruction <= 32'h0;
        MemRead_IDEX <= 1'b0; RegRT_IDEX <= 5'd0; 
        
        //----------------------------------
        // Jump Tests
        //----------------------------------
        
        #400 PCAdder <= 32'd36; Instruction <= 32'h8000004;  // j   0x04
        #100 PCAdder <= 32'd40; Instruction <= 32'h03E00008; // jr  ra
        #100 PCAdder <= 32'd44; Instruction <= 32'hC000008;  // jal 0x08
        
        // Zero
        #100 PCAdder <= 32'd0; Instruction <= 32'd0;
        
        //----------------------------------
        // Branch Tests
        //----------------------------------
        
        #100 PCAdder <= 32'd48; Instruction <= 32'h112A0012; // beq  t1 = t4 -> 0x12
        #100 PCAdder <= 32'd52; Instruction <= 32'h05210016; // bgez t1 = t4 -> 0x16
        #100 PCAdder <= 32'd56; Instruction <= 32'h1D200020; // bgtz t1 = t4 -> 0x20
        #100 PCAdder <= 32'd60; Instruction <= 32'h19200024; // blez t1 = t4 -> 0x24
        #100 PCAdder <= 32'd64; Instruction <= 32'h05200028; // bltz t1 = t4 -> 0x28
        #100 PCAdder <= 32'd68; Instruction <= 32'h152A0032; // bne  t1 = t4 -> 0x32
        
        // ------------------------------------------------------------------------------
        // Return to zero
        #100 Instruction <= 32'b0; PCAdder <= 32'd0;                    // From IF
        RegWrite <= 1'b0; WriteRegister <= 5'd0; WriteData <= 32'd0;    // Write Back 
        MemRead_IDEX <= 1'b0; RegRT_IDEX <= 5'd0;                         // Hazard Control
        // ------------------------------------------------------------------------------
 
    end 

endmodule