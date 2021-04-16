`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Student(s) Name and Last Name: Diego Moscoso, Fausto Sanchez, Jake Summerville
//
// Module           : EXMEMRegister.v
// Description      : 
//
// INPUTS
//
// OUTPUTS
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////

module EXMEMRegister(

    Clock, 
    In_ControlSignal, In_ALUZero, In_ALUResult, In_RegRTData, In_RegDst32, In_PCAdder, 
    Out_ControlSignal, Out_ALUZero, Out_ALUResult, Out_RegRTData, Out_RegDst, Out_PCAdder
    
);
	
	input Clock, In_ALUZero;
	input [31:0] In_RegDst32;
    input [31:0] In_ControlSignal, In_ALUResult, In_RegRTData, In_PCAdder;
	
	output reg        Out_ALUZero;
	output reg [4:0]  Out_RegDst;
	output reg [31:0] Out_ControlSignal, Out_ALUResult, Out_RegRTData, Out_PCAdder;

    initial begin
        Out_ALUZero       <= 1'd0;
	    Out_RegDst        <= 5'd0;
        Out_ControlSignal <= 32'd0;
        Out_ALUResult     <= 32'd0;
        Out_RegRTData     <= 32'd0;
        Out_PCAdder       <= 32'd0;
    end
	
	always @(posedge Clock) begin
		Out_ALUZero       <= In_ALUZero;
	    Out_RegDst        <= In_RegDst32[4:0];
        Out_ControlSignal <= In_ControlSignal;
        Out_ALUResult     <= In_ALUResult;
        Out_RegRTData     <= In_RegRTData;
        Out_PCAdder       <= In_PCAdder;
	end

endmodule
