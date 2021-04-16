`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : IDStage.v
// Description      : This file is the top level file for the ID stage.
////////////////////////////////////////////////////////////////////////////////


module IDStage(

    // --- Inputs ---
    Clock, Reset,               // System Inputs
    RegWrite, MemRead_IDEX,     // Control Signals
    WriteRegister, WriteData,   // Write data
    Instruction, 
    RegRT_IDEX, RegRD_IDEX, RegDst_IDEX,
    RegWrite_IDEX, RegWrite_EXMEM,
    RegisterDst_EXMEM,
    ForwardData_EXMEM,
    PCAdder,  
    BP,   
    ForwardMuxASel,
    ForwardMuxBSel,       
    
    // --- Outputs ---         
    ControlSignal_Out, JumpControl, BranchControl, // Control Signals
    ReadData1, ReadData2,       // Register Data
    ImmediateValue,             // Immediate value
    PCWrite, IFIDWrite,         // Hazard Signals    
    BranchAddress, JumpAddress, Flush_IF,
    BP_Correct, Update_BP,
    V0, V1 //V0 and V1
    );             
          
    //--------------------------------
    // Inputs
    //--------------------------------
          
    // System Inputs
    input Clock, Reset;
          
    // Branch Prediction
    input BP;
          
    // Control Signals     
    input RegWrite, MemRead_IDEX;
    input RegWrite_IDEX, RegWrite_EXMEM;
    
    input ForwardMuxASel, ForwardMuxBSel;
    
    input [1:0] RegDst_IDEX; 
    
    // Data
    input [31:0] Instruction, PCAdder;
    
    input [4:0] RegRT_IDEX, RegRD_IDEX;
    
    input [4:0] RegisterDst_EXMEM;
    
    input [31:0] ForwardData_EXMEM;
    
    // Write Register Data
    input [4:0]  WriteRegister;
    input [31:0] WriteData;
    
    //--------------------------------
    // Outputs
    //--------------------------------
    
    // Branch Prediction
    output wire BP_Correct;
    output wire Update_BP;
    
    // Control Signal
    output wire JumpControl, BranchControl;
    output wire [31:0] ControlSignal_Out;
    
    // Register Data
    output wire [31:0] ReadData1, ReadData2;
    
    // Immediate value
    output wire [31:0] ImmediateValue;
    
    // Hazard Signals
    output wire PCWrite, IFIDWrite;
    
    // Flush Register
    output wire Flush_IF;
    
    // PC Addresses
    output wire [31:0] BranchAddress, JumpAddress;
    
    //V0 and V1 Data
    output wire [31:0] V0, V1;

    //--------------------------------
    // Wires                        
    //--------------------------------
    
    // Hazard Signals
    wire ControlStall;
    
    wire JumpFlush;
    
    wire BPUpdateEn;
    wire BPUpdateControl;
    wire BranchFlush;
    wire JBPFlush;
    
    wire       JumpMuxSel;
    wire [2:0] BranchComp;
    
    wire [31:0] ImmediateShift, ShiftedJumpAddress;
    
    // Execute
    wire       ALUBMux_Control;
    wire [1:0] RegDst_Control;
    wire [5:0] ALUOp_Control;
    
    // Memory
    wire MemWrite_Control, MemRead_Control;
    wire [1:0] ByteSig_Control;   
    
    // Write Back
    wire       RegWrite_Control;
    wire [1:0] MemToReg_Control;
    
    // Forwarding Mux
    wire [31:0] ReadData1Forward, ReadData2Forward;
    
    wire [31:0] SignExtend_Out;
    wire LaMux;
    
    //--------------------------------
    // Hardware Components
    //--------------------------------
    
    HazardDetectionUnit     HazardDetection(.OpCode(Instruction[31:26]), 
                                            .Func(Instruction[5:0]),
                                            .RegRS_IFID(Instruction[25:21]), 
                                            .RegRT_IFID(Instruction[20:16]),

                                            .RegRT_IDEX(RegRT_IDEX), 
                                            .RegRD_IDEX(RegRD_IDEX),
                                            .RegWrite_IDEX(RegWrite_IDEX),
                                            .MemRead_IDEX(MemRead_IDEX),
                                            .RegDst_IDEX(RegDst_IDEX),            
                                            .RegisterDst_EXMEM(RegisterDst_EXMEM), 
                                            .RegWrite_EXMEM(RegWrite_EXMEM),
                                            .PCWrite(PCWrite), 
                                            .IFIDWrite(IFIDWrite), 
                                            .ControlStall(ControlStall),
                                            .BPUpdateEn(BPUpdateEn),
                                            .BranchFlush(BranchFlush));
    
    Controller              Control(.Instruction(Instruction),
                                    .ALUBMux(ALUBMux_Control), .RegDst(RegDst_Control), 
                                    .ALUOp(ALUOp_Control), .MemWrite(MemWrite_Control), 
                                    .MemRead(MemRead_Control), .ByteSig(ByteSig_Control),
                                    .RegWrite(RegWrite_Control), .MemToReg(MemToReg_Control),  
                                    .JumpMuxSel(JumpMuxSel), 
                                    .JumpControl(JumpControl), 
                                    .BranchComp(BranchComp),
                                    .Flush_IF(JumpFlush),
                                    .Update_BP(BPUpdateControl),
                                    .LaMux(LaMux));
    
    AndGate                 BPUpdateAnd(.InA(BPUpdateControl),
                                        .InB(BPUpdateEn),
                                        .Out(Update_BP));
    
    Mux32Bit2To1            ControlMux(.out(ControlSignal_Out), 
                                       .inA({14'd0, ALUOp_Control[5:0], ALUBMux_Control, RegDst_Control[1:0], 
                                             ByteSig_Control[1:0], MemWrite_Control, MemRead_Control, 2'd0, 
                                             RegWrite_Control, MemToReg_Control[1:0]}),
                                       .inB(32'd0), 
                                       .sel(ControlStall));
    
    RegisterFile            Registers(.ReadRegister1(Instruction[25:21]), // rs
                                      .ReadRegister2(Instruction[20:16]), // rt 
                                      .WriteRegister(WriteRegister), 
                                      .WriteData(WriteData), 
                                      .RegWrite(RegWrite), 
                                      .Clock(Clock), 
                                      .ReadData1(ReadData1), 
                                      .ReadData2(ReadData2),
                                      .V0(V0),
                                      .V1(V1));
    
    Mux32Bit2To1            ForwardMuxA_ID(.out(ReadData1Forward), 
                                           .inA(ReadData1),
                                           .inB(ForwardData_EXMEM), 
                                           .sel(ForwardMuxASel));
                                    
    Mux32Bit2To1            ForwardMuxB_ID(.out(ReadData2Forward), 
                                           .inA(ReadData2),
                                           .inB(ForwardData_EXMEM), 
                                           .sel(ForwardMuxBSel));
    
    Comparator              BranchCompare(.InA(ReadData1Forward), 
                                          .InB(ReadData2Forward), 
                                          .Result(BranchControl), 
                                          .Control(BranchComp));
    
    XORGate                 BPXOR(.InA(BP), 
                                  .InB(BranchControl), 
                                  .Out(BP_Correct));
    
    OrGate                  FlushOr(.InA(BP_Correct), 
                                    .InB(JumpFlush), 
                                    .Out(JBPFlush));
    
    AndGate                 BranchHDUOr(.InA(JBPFlush),
                                        .InB(BranchFlush),
                                        .Out(Flush_IF));
    
    SignExtension           ImmSignExtend(.in(Instruction[15:0]), 
                                          .out(SignExtend_Out));
    
    Mux32Bit2To1            LoadAddressMux(.out(ImmediateValue), 
                                           .inA(SignExtend_Out),
                                           .inB({16'd0, Instruction[15:0]}), 
                                           .sel(LaMux));
    
    ShiftLeft2              AdderShift(.inputNum(SignExtend_Out), 
                                       .outputNum(ImmediateShift));
    
    Adder                   BranchAdder(.A(PCAdder), 
                                        .B(ImmediateShift), 
                                        .AddResult(BranchAddress));

    ShiftLeft2              JumpShift(.inputNum({6'b0, Instruction[25:0]}), 
                                      .outputNum(ShiftedJumpAddress));

    Mux32Bit2To1            JumpMux(.out(JumpAddress), 
                                    .inA({PCAdder[31:28], ShiftedJumpAddress[27:0]}),
                                    .inB(ReadData1), 
                                    .sel(JumpMuxSel));

endmodule
