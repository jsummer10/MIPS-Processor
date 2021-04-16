`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : Datapath.v
// Description      : This file is the top level file for the CPU.
////////////////////////////////////////////////////////////////////////////////

module Datapath(ClockIn, Reset, out7, en_out);

    input ClockIn, Reset;
    
    output [6:0] out7;
    output [7:0] en_out;

    wire [31:0] PCResult;
    wire [31:0] WriteData_WB;
    wire [63:0] HiLoReg;
    
    wire [31:0] V0, V1;

    //--------------------------------
    // Wires
    //--------------------------------
    wire Clock;
    
    // Jump / Branch
    wire JumpControl, BranchControl;
    wire [31:0] JumpAddress, BranchAddress;
    
    // Hazard Detection
    wire Hazard_IFIDWrite, Hazard_PCWrite;
    
    // Forwarding
    wire [1:0] ForwardMuxASel_EX, ForwardMuxBSel_EX;
    wire ForwardMuxASel_ID, ForwardMuxBSel_ID;
    
    // Flush Register
    wire Flush_IF;
    
    // Instructions
    wire [31:0] Instruction_IF, Instruction_ID;
    
    // Program Counter Adder
    wire [31:0] PCAdder_IF, PCAdder_ID, PCAdder_EX, PCAdder_MEM, PCAdder_WB;
    
    // Branch Prediction
    wire PrevBP, BP_IF, BP_ID, Update_BP;
    wire [31:0] PrevPCAdder_ID;
    
    // Control Signal
    wire [31:0] ControlSignal_ID, ControlSignal_EX, ControlSignal_MEM, ControlSignal_WB;
    wire ALURegWrite;
    
    // Registers
    wire [4:0] RegRT_IDEX, RegRS_IDEX, RegRD_IDEX;
    
    // Register Data
    wire [31:0] ReadData1_ID, ReadData2_ID, ReadData1_EX, ReadData2_EX;
    
    // ALU Data
    wire ALUZero_EX, ALUZero_MEM;
    wire [31:0] ALUResult_EX, ALUResult_MEM, ALUResult_WB;

    // Sign Extend
    wire [31:0] SignExtend_ID, SignExtend_EX;
    
    // Memory Data
    wire [31:0] MemReadData_MEM, MemReadData_WB;
    wire [31:0] RegRTData_EX, RegRTData_MEM;
    
    // Write Register and Data from Write Back
    wire [4:0]  RegDst_MEM, RegDst_WB;
    wire [31:0] RegDst32_EX;
    
    //Uncomment when running Test Bench Simulations    
    assign Clock = ClockIn;
    
    //--------------------------------
    // Hardware Components
    //--------------------------------
    
    // Comment for test bench simulation
    //ClkDiv          ClockDivider(.Clk(ClockIn),    
    //                             .Rst(1'b0),        
    //                             .ClkOut(Clock));  
    
    // Instruction Fetch Stage 
    IFStage         IF_Stage(// Inputs
                       .Clock(Clock), 
                       .Reset(Reset),          
                       .JumpControl(JumpControl), 
                       .BranchControl(BranchControl), 
                       .PCWrite(Hazard_PCWrite),                
                       .JumpAddress(JumpAddress), 
                       .BranchAddress(BranchAddress),  
                       .PrevBP(PrevBP), 
                       .Update_BP(Update_BP), 
                       .BP_ID(BP_ID),      
                       .PCAdder_ID(PrevPCAdder_ID),
                    
                       // Outputs         
                       .Instruction(Instruction_IF), 
                       .PCAdder_Out(PCAdder_IF),
                       .PCResult(PCResult),
                       .BP(BP_IF));   
    
    
    // IF / ID Register
    IFIDRegister    IFID(.Clock(Clock), 
                         .Flush(Flush_IF), 
                         .Enable(Hazard_IFIDWrite), 
                         .In_Instruction(Instruction_IF), 
                         .In_PCAdder(PCAdder_IF),
                         .In_BP(BP_IF),
                         .Out_Instruction(Instruction_ID), 
                         .Out_PCAdder(PCAdder_ID),
                         .Out_PrevPCAdder(PrevPCAdder_ID),
                         .Out_BP(BP_ID));
 
    
    // Instruction Decode Stage
    IDStage         ID_Stage(// Inputs 
                       .Clock(Clock), 
                       .Reset(Reset),    
                       .RegWrite(ControlSignal_WB[2]), 
                       .MemRead_IDEX(ControlSignal_EX[5]), 
                       .WriteRegister(RegDst_WB), 
                       .WriteData(WriteData_WB), 
                       .Instruction(Instruction_ID), 
                       .RegRT_IDEX(RegRT_IDEX),
                       .RegRD_IDEX(RegRD_IDEX), 
                       .RegDst_IDEX(ControlSignal_EX[10:9]),
                       .RegWrite_IDEX(ControlSignal_EX[2]), 
                       .RegWrite_EXMEM(ControlSignal_MEM[2]),
                       .RegisterDst_EXMEM(RegDst_MEM), 
                       .ForwardData_EXMEM(ALUResult_MEM),
                       .PCAdder(PCAdder_ID), 
                       .BP(BP_ID),  
                       .ForwardMuxASel(ForwardMuxASel_ID), 
                       .ForwardMuxBSel(ForwardMuxBSel_ID),         
    
                       // Outputs          
                       .ControlSignal_Out(ControlSignal_ID), 
                       .JumpControl(JumpControl), 
                       .BranchControl(BranchControl), 
                       .ReadData1(ReadData1_ID), 
                       .ReadData2(ReadData2_ID), 
                       .ImmediateValue(SignExtend_ID),   
                       .PCWrite(Hazard_PCWrite), 
                       .IFIDWrite(Hazard_IFIDWrite),     
                       .BranchAddress(BranchAddress), 
                       .JumpAddress(JumpAddress),
                       .Flush_IF(Flush_IF),
                       .BP_Correct(PrevBP),
                       .Update_BP(Update_BP),
                       .V0(V0),
                       .V1(V1)); 
  
    // ID / EX Register
    IDEXRegister    IDEX(.Clock(Clock),
                         .In_ControlSignal(ControlSignal_ID), 
                         .In_ReadData1(ReadData1_ID), 
                         .In_ReadData2(ReadData2_ID), 
                         .In_SignExtend(SignExtend_ID), 
                         .In_PCAdder(PCAdder_ID),
                         .In_RegRT(Instruction_ID[20:16]), 
                         .In_RegRD(Instruction_ID[15:11]), 
                         .In_RegRS(Instruction_ID[25:21]),
                         .Out_ControlSignal(ControlSignal_EX), 
                         .Out_ReadData1(ReadData1_EX), 
                         .Out_ReadData2(ReadData2_EX), 
                         .Out_SignExtend(SignExtend_EX), 
                         .Out_PCAdder(PCAdder_EX),
                         .Out_RegRT(RegRT_IDEX), 
                         .Out_RegRD(RegRD_IDEX), 
                         .Out_RegRS(RegRS_IDEX));
    
    ForwardingUnit  Forwarder(.RegWrite_EXMEM(ControlSignal_MEM[2]), 
                              .RegWrite_MEMWB(ControlSignal_WB[2]),  
                              .RegDst_EXMEM(RegDst_MEM),
                              .RegDst_MEMWB(RegDst_WB),
                              .RegRS_IDEX(RegRS_IDEX), 
                              .RegRT_IDEX(RegRT_IDEX),
                              .RegRS_IFID(Instruction_ID[25:21]), 
                              .RegRT_IFID(Instruction_ID[20:16]),      
                              .ForwardMuxA_EX(ForwardMuxASel_EX), 
                              .ForwardMuxB_EX(ForwardMuxBSel_EX),
                              .ForwardMuxA_ID(ForwardMuxASel_ID), 
                              .ForwardMuxB_ID(ForwardMuxBSel_ID));

    // Execute Stage
    EXStage         EX_Stage(// Inputs 
                       .Clock(Clock), 
                       .Reset(Reset),  
                       .ALUBMuxSel(ControlSignal_EX[11]), 
                       .ALUOp(ControlSignal_EX[17:12]), 
                       .RegDst(ControlSignal_EX[10:9]),
                       .RegWrite(ControlSignal_EX[2]),      
                       .ForwardMuxASel(ForwardMuxASel_EX), 
                       .ForwardMuxBSel(ForwardMuxBSel_EX),  
                       .ReadData1(ReadData1_EX), 
                       .ReadData2(ReadData2_EX), 
                       .SignExtend(SignExtend_EX),  
                       .RegRT(RegRT_IDEX), 
                       .RegRD(RegRD_IDEX),              
                       .ALUResult_MEM(ALUResult_MEM), 
                       .MemToReg_WB(WriteData_WB),
                       .Shamt(SignExtend_EX[10:6]),      
      
                       // Outputs        
                       .ALUZero(ALUZero_EX), 
                       .ALUResult(ALUResult_EX),           
                       .RegDst32_Out(RegDst32_EX),  
                       .RegWrite_Out(ALURegWrite),                  
                       .ALURT(RegRTData_EX),
                       .HiLoReg(HiLoReg)); 
                       

    // EX / MEM Register
    EXMEMRegister   EXMEM(.Clock(Clock), 
                          .In_ControlSignal({ControlSignal_EX[31:3], ALURegWrite, ControlSignal_EX[1:0]}), 
                          .In_ALUZero(ALUZero_EX), 
                          .In_ALUResult(ALUResult_EX), 
                          .In_RegRTData(RegRTData_EX), 
                          .In_RegDst32(RegDst32_EX), 
                          .In_PCAdder(PCAdder_EX), 
                          .Out_ControlSignal(ControlSignal_MEM), 
                          .Out_ALUZero(ALUZero_MEM), 
                          .Out_ALUResult(ALUResult_MEM), 
                          .Out_RegRTData(RegRTData_MEM), 
                          .Out_RegDst(RegDst_MEM), 
                          .Out_PCAdder(PCAdder_MEM));


    // Memory Stage
    MEMStage        MEM_Stage(.Clock(Clock),     
                              .MemWrite(ControlSignal_MEM[6]), 
                              .MemRead(ControlSignal_MEM[5]),
                              .ByteSig(ControlSignal_MEM[8:7]),
                              .ALUResult(ALUResult_MEM),         
                              .RegRTData(RegRTData_MEM),
                              .MemReadData(MemReadData_MEM));    
    

    // MEM / WB Register
    MEMWBRegister   MEMWB(.Clock(Clock), 
                          .In_ControlSignal(ControlSignal_MEM), 
                          .In_MemReadData(MemReadData_MEM), 
                          .In_ALUResult(ALUResult_MEM), 
                          .In_RegDst(RegDst_MEM), 
                          .In_PCAdder(PCAdder_MEM), 
                          .Out_ControlSignal(ControlSignal_WB), 
                          .Out_MemReadData(MemReadData_WB), 
                          .Out_ALUResult(ALUResult_WB), 
                          .Out_RegDst(RegDst_WB), 
                          .Out_PCAdder(PCAdder_WB));

    
    // Write Back Stage
    WBStage         WB_Stage(// Inputs
                       .MemToReg(ControlSignal_WB[1:0]),      
                       .ALUResult(ALUResult_WB), 
                       .MemReadData(MemReadData_WB), 
                       .PCAdder(PCAdder_WB), 
    
                       // Outputs       
                       .MemToReg_Out(WriteData_WB));
                       
    //--------------------------------
    // Hardware Components
    //--------------------------------
    
    // Comment for test bench simulation
    //Two4DigitDisplay    DisplayOutPut(.Clk(ClockIn),
    //                                  .NumberA(V1[15:0]),     // Set of Digits on Right
    //                                  .NumberB(V0[15:0]),     // Set of Digits on Left
    //                                  .out7(out7),
    //                                  .en_out(en_out));

endmodule
