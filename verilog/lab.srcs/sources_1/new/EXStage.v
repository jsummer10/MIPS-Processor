`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : EXStage.v
// Description      : This file is the top level file for the EX stage.



////////////////////////////////////////////////////////////////////////////////


module EXStage(

    // --- Inputs ---
    Clock, Reset,                     // System Inputs
    ALUBMuxSel, ALUOp, RegDst,        // Control Signals
    RegWrite,     
    ForwardMuxASel, ForwardMuxBSel,   // Forward Signals
    ReadData1, ReadData2, SignExtend, // ALU Inputs
    RegRT, RegRD,                     // Write Back Registers
    ALUResult_MEM, MemToReg_WB,       // Forwarding Data
    Shamt,                            // Shift Amount
      
    // --- Outputs ---         
    ALUZero, ALUResult,               // ALU Outputs     
    RegDst32_Out,                     // Write Back Register
    RegWrite_Out,
    ALURT,
    HiLoReg
    );             
          
    //--------------------------------
    // Inputs
    //--------------------------------
          
    input       Clock, Reset;
          
    // Control Signals     
    input       ALUBMuxSel, RegWrite;
    input [1:0] RegDst;
    input [5:0] ALUOp;
    
    // Forwarding
    input [1:0]  ForwardMuxASel, ForwardMuxBSel;
    input [31:0] ALUResult_MEM, MemToReg_WB;
    
    // Write Back Registers
    input [4:0] RegRT, RegRD;
    
    // ALU Inputs
    input [4:0]  Shamt;
    input [31:0] ReadData1, ReadData2, SignExtend;
    
    //--------------------------------
    // Outputs
    //--------------------------------
    
    // ALU Outputs
    output wire         ALUZero;
    output wire [31:0]  ALUResult;
    
    // Write Back Register
    output wire [31:0] RegDst32_Out;
    
    output wire [31:0] ALURT;
    
    output wire RegWrite_Out;
    
    //HiLo Register
    output wire [63:0] HiLoReg;
    
    //--------------------------------
    // Wires                        
    //--------------------------------
    
    // ALU Inputs
    wire [31:0] ALUA, ALUB; 
    
    // ALU Control Signal
    wire [5:0] ALUControl;
    
    // HiLo Register
    wire HiLoEnable;
    wire [63:0] HiLoData;
    
    //--------------------------------
    // Hardware Components
    //--------------------------------
    
    ALUController       ALUController1(.Funct(SignExtend[5:0]), 
                                       .ALUOp(ALUOp), 
                                       .ALUControl(ALUControl));
    
    Mux32Bit3To1        ForwardMuxA(.out(ALUA), 
                                    .inA(ReadData1), 
                                    .inB(ALUResult_MEM), 
                                    .inC(MemToReg_WB), 
                                    .sel(ForwardMuxASel));
    
    Mux32Bit3To1        ForwardMuxB(.out(ALURT), 
                                    .inA(ReadData2), 
                                    .inB(ALUResult_MEM), 
                                    .inC(MemToReg_WB), 
                                    .sel(ForwardMuxBSel));
    
    Mux32Bit2To1        ALUBMux(.out(ALUB), 
                                .inA(ALURT), 
                                .inB(SignExtend), 
                                .sel(ALUBMuxSel));
    
    ALU32Bit            ALU(.ALUControl(ALUControl), 
                            .A(ALUA), 
                            .B(ALUB), 
                            .Shamt(Shamt),
                            .ALUResult(ALUResult), 
                            .Zero(ALUZero), 
                            .RegWrite(RegWrite),
                            .RegWrite_Out(RegWrite_Out),
                            .HiLoReg(HiLoReg), 
                            .HiLoNewData(HiLoData), 
                            .HiLoEnable(HiLoEnable));
    
    HILORegister        HILOReg(.HiLoReg(HiLoReg),
                                .Data(HiLoData), 
                                .Enable(HiLoEnable),
                                .Clock(Clock), 
                                .Reset(Reset));
                               
    Mux32Bit3To1        RegDstMux(.out(RegDst32_Out), 
                                  .inA({27'd0, RegRT}), 
                                  .inB({27'd0, RegRD}), 
                                  .inC(32'd31), 
                                  .sel(RegDst));
    
endmodule
