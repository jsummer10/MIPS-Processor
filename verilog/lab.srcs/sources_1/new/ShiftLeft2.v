`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Student(s) Name and Last Name: Diego Moscoso, Fausto Sanchez, Jake Summerville
//
// Module           : ShiftLeft2.v
// Description      : 
//
// INPUTS
//
// OUTPUTS
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////

module ShiftLeft2(inputNum, outputNum);

    input [31:0] inputNum;
    output reg [31:0] outputNum;
    
    always @(inputNum) begin
        outputNum = inputNum << 2;
    end

endmodule
