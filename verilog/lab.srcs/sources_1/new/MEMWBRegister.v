`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Student(s) Name and Last Name: Diego Moscoso, Fausto Sanchez, Jake Summerville
//
// Module           : MEMWBRegister.v
// Description      : 
//
// INPUTS
//
// OUTPUTS
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////

module MEMWBRegister(

    Clock, 
    In_ControlSignal, In_MemReadData, In_ALUResult, In_RegDst, In_PCAdder, 
    Out_ControlSignal, Out_MemReadData, Out_ALUResult, Out_RegDst, Out_PCAdder
    
);
	
	input Clock;
	input [4:0]  In_RegDst;
    input [31:0] In_ControlSignal, In_MemReadData, In_ALUResult, In_PCAdder;
	
	output reg [4:0]  Out_RegDst;
	output reg [31:0] Out_ControlSignal, Out_MemReadData, Out_ALUResult, Out_PCAdder;

    initial begin
        Out_MemReadData   <= 32'd0;
	    Out_RegDst        <= 5'd0;
        Out_ControlSignal <= 32'd0;
        Out_ALUResult     <= 32'd0;
        Out_PCAdder       <= 32'd0;
    end
	
	always @(posedge Clock) begin
		Out_MemReadData   <= In_MemReadData;
	    Out_RegDst        <= In_RegDst;
        Out_ControlSignal <= In_ControlSignal;
        Out_ALUResult     <= In_ALUResult;
        Out_PCAdder       <= In_PCAdder;
	end
	
endmodule
