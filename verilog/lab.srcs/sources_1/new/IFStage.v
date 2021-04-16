`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : IFStage.v
// Description      : This file is the top level file for the IF stage.
////////////////////////////////////////////////////////////////////////////////


module IFStage(

    // --- Inputs ---
    Clock, Reset,               // System Inputs
    JumpControl, BranchControl, // Control Signal
    PCWrite,                    // Hazard Signal
    JumpAddress, BranchAddress,
    PrevBP, Update_BP,   
    BP_ID,      
    PCAdder_ID,           
    
    // --- Outputs ---         
    Instruction, PCAdder_Out, PCResult, BP             
    );             
          
    //--------------------------------
    // Inputs
    //--------------------------------
          
    // System Inputs
    input Clock, Reset;
          
    // Control Signal 
    input JumpControl, BranchControl;
    
    // Hazard Signals
    input PCWrite;
    
    input [31:0] JumpAddress, BranchAddress;
    
    // Branch Prediction
    input PrevBP, Update_BP, BP_ID;
    input [31:0] PCAdder_ID;
    
    //--------------------------------
    // Outputs
    //--------------------------------
    
    output wire BP;
    output wire [31:0] Instruction, PCAdder_Out, PCResult;
    
    //--------------------------------
    // Wires                        
    //--------------------------------
    
    wire Branch;
    wire [31:0] PCInput, ScheduledPC, TargetOffset, TargetAddress, ShiftedOffset; 
    
    //--------------------------------
    // Hardware Components
    //--------------------------------
    
    ProgramCounter      PC(.PC_In(PCInput), 
                           .PCResult(PCResult), 
                           .Enable(PCWrite), 
                           .Reset(Reset), 
                           .Clock(Clock));
                           
    InstructionMemory   InstructionMemory1(.Address(PCResult), 
                                           .Instruction(Instruction),
                                           .TargetOffset(TargetOffset),
                                           .Branch(Branch));
    
    Adder               PCAdder(.A(PCResult), 
                                .B(32'd4), 
                                .AddResult(PCAdder_Out));
    
    Mux8To1             PCSrcMux(.out(ScheduledPC), 
                                 .inA(PCAdder_Out),     // Nothing
                                 .inB(JumpAddress),     // Jump
                                 .inC(BranchAddress),   // Branch, mispredict not taken
                                 .inD(PCAdder_Out),     
                                 .inE(PCAdder_ID),      // No Branch, mispredict taken
                                 .inF(PCAdder_Out),
                                 .inG(PCAdder_Out),
                                 .inH(PCAdder_Out),
                                 .sel({BP_ID, BranchControl, JumpControl}));
    
    //-------------------
    // Branch Prediction
    //-------------------
    
    ShiftLeft2          BPShift(.inputNum(TargetOffset), 
                                .outputNum(ShiftedOffset));
    
    Adder               BPAdder(.A(PCAdder_Out), 
                                .B(ShiftedOffset), 
                                .AddResult(TargetAddress));
    
    BranchPrediction    BranchPredict(.Clock(Clock), 
                                      .Branch(Branch), 
                                      .Update(Update_BP), 
                                      .PredictWrong(PrevBP), 
                                      .Prediction(BP));
    
    Mux32Bit2To1        BPMux(.out(PCInput), 
                              .inA(ScheduledPC), 
                              .inB(TargetAddress), 
                              .sel(BP));

endmodule
