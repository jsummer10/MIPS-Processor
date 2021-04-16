`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Student(s) Name and Last Name: Diego Moscoso, Fausto Sanchez, Jake Summerville
//
// Module           : IFIDRegister.v
// Description      : 
//
// INPUTS
//
// OUTPUTS
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////

module IFIDRegister(Clock, Flush, Enable, In_Instruction, Out_Instruction, 
                    In_PCAdder, Out_PCAdder, Out_PrevPCAdder, In_BP, Out_BP);

    input        Clock, Flush, Enable;
    input        In_BP;
    input [31:0] In_Instruction;
    input [31:0] In_PCAdder;
    
    output reg        Out_BP;
    output reg [31:0] Out_Instruction;
    output reg [31:0] Out_PrevPCAdder;
    output reg [31:0] Out_PCAdder;

    initial begin
        Out_Instruction <= 32'b0;
        Out_PCAdder     <= 32'b0;
        Out_BP          <= 1'b0;
    end

    always @(posedge Clock) begin
        if (Flush) begin
            Out_Instruction = 32'd0;
            Out_PCAdder     = 32'd0;
            Out_BP          = 1'd0;
        end
        else if (Enable) begin
            Out_Instruction = In_Instruction;
            Out_PCAdder     = In_PCAdder;
            Out_BP          = In_BP;
            Out_PrevPCAdder = In_PCAdder;
        end
    end

endmodule
