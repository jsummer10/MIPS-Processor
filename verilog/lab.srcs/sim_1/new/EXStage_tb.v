`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : EXStage_tb.v
// Description      : Test bench for the EXStage
////////////////////////////////////////////////////////////////////////////////

module EXStage_tb();

    reg        Clock, Reset, ALUBMuxSel;
    reg [1:0]  RegDst, ForwardMuxASel, ForwardMuxBSel;
    reg [4:0]  RegRT, RegRD;
    reg [5:0]  ALUOp;
    reg [31:0] ALUResult_MEM, MemToReg_WB, ReadData1, ReadData2, SignExtend;
    
    wire        ALUZero;
    wire [31:0] RegDst32_Out;
    wire [31:0] ALUResult, ALURT;
    

    EXStage     EXStage_Test(
        // --- Inputs ---
        Clock, Reset,                     // System Inputs
        ALUBMuxSel, ALUOp, RegDst,        // Control Signals
        ForwardMuxASel, ForwardMuxBSel,   // Forward Signals
        ReadData1, ReadData2, SignExtend, // ALU Inputs
        RegRT, RegRD,                     // Write Back Registers
        ALUResult_MEM, MemToReg_WB,       // Forwarding Data
        Shamt,                            // Shift Amount
          
        // --- Outputs ---         
        ALUZero, ALUResult,               // ALU Outputs     
        RegDst32_Out,                     // Write Back Register
        ALURT);

    always begin    
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
    end
    
    initial begin
        
        // ------------------------------------------------------------------------------
        SignExtend <= 32'd0; ALUOp <= 6'd0; // ALU Signals
        ForwardMuxASel <= 2'd0; ForwardMuxBSel <= 2'd0; ALUBMuxSel <= 1'd0; // Muxes
        ReadData1 <= 32'd0; ReadData2 <= 32'd0; ALUResult_MEM <= 32'd0; MemToReg_WB <= 32'd0;   // ALU Data
        RegRT <= 5'd0; RegRD <= 5'd0; RegDst <= 2'd0;   // Write Register
        // ------------------------------------------------------------------------------
        
        Reset <= 1;
        @(posedge Clock);
        #100 Reset <= 0; 
        
        //----------------------------------
        // Write Register Tests
        //----------------------------------
        
        #100 RegRT <= 5'd9; RegRD <= 5'd10; RegDst <= 2'd0;  // Write -> 9
        #100 RegRT <= 5'd9; RegRD <= 5'd10; RegDst <= 2'd1;  // Write -> 10
        #100 RegRT <= 5'd9; RegRD <= 5'd10; RegDst <= 2'd2;  // Write -> 31
        
        #100 RegRT <= 5'd0; RegRD <= 5'd0; RegDst <= 2'd0;   // Zero
        
        //----------------------------------
        // Mux Tests
        //----------------------------------
        
        #200;
         
        #100 ReadData1 <= 32'd10; ReadData2 <= 32'd20; ALUResult_MEM <= 32'd30; MemToReg_WB <= 32'd40;
         
        // Forward Mux A
        #100 ForwardMuxASel <= 2'd0; // ALUA: 10
        #100 ForwardMuxASel <= 2'd1; // ALUA: 30
        #100 ForwardMuxASel <= 2'd2; // ALUA: 40
         
        #100 ForwardMuxASel <= 2'd0; // Zero
         
        // Forward Mux B
        #100 ForwardMuxBSel <= 2'd0; ALUBMuxSel <= 1'd0; // ALUB: 20
        #100 ForwardMuxBSel <= 2'd1; ALUBMuxSel <= 1'd0; // ALUB: 30
        #100 ForwardMuxBSel <= 2'd2; ALUBMuxSel <= 1'd0; // ALUB: 40
         
        #100 ForwardMuxBSel <= 2'd0; ALUBMuxSel <= 1'd0; // Zero
         
        // Mux B
        #100 ForwardMuxBSel <= 2'd0; ALUBMuxSel <= 1'd0; SignExtend <= 32'd50;  // ALUB: 20
        #100 ForwardMuxBSel <= 2'd0; ALUBMuxSel <= 1'd1; SignExtend <= 32'd50;  // ALUB: 50
        
        // Zero 
        #100 ReadData2 <= 32'd0; ALUResult_MEM <= 32'd0; MemToReg_WB <= 32'd0; ForwardMuxBSel <= 2'd0;
             ReadData1 <= 32'd0; ForwardMuxASel <= 2'd0; SignExtend <= 32'd0; ALUBMuxSel <= 1'd0;
         
        //----------------------------------
        // ALU Tests
        //----------------------------------
        #200;
        
        // Add Both Registers
        #100 ReadData1 <= 32'd5; ReadData2 <= 32'd7; ALUBMuxSel <= 1'd0; SignExtend <= 32'b100000; ALUOp <= 6'd0; // ADD  = 12
        
        // Add Register to Immediate
        #100 ReadData1 <= 32'd6; ReadData2 <= 32'd0; ALUBMuxSel <= 1'd1; SignExtend <= 32'd2; ALUOp <= 6'b001000; // ADDI = 08
        
        // MTHI, MFHI : t1 -> rd
        #100 ReadData1 <= 32'd26; ReadData2 <= 32'd0; ALUBMuxSel <= 1'd0; SignExtend <= 32'b010000; ALUOp <= 6'd0; // MTHI = 00
        #100 ReadData1 <= 32'd0; ReadData2 <= 32'd0; ALUBMuxSel <= 1'd0; SignExtend <= 32'b010001; ALUOp <= 6'd0;  // rd = 26
        
        // ------------------------------------------------------------------------------
        SignExtend <= 32'd0; ALUOp <= 6'd0; // ALU Signals
        ForwardMuxASel <= 2'd0; ForwardMuxBSel <= 2'd0; ALUBMuxSel <= 1'd0; // Muxes
        ReadData1 <= 32'd0; ReadData2 <= 32'd0; ALUResult_MEM <= 32'd0; MemToReg_WB <= 32'd0;   // ALU Data
        RegRT <= 5'd0; RegRD <= 5'd0; RegDst <= 2'd0;   // Write Register
        // ------------------------------------------------------------------------------
        
    end 

endmodule