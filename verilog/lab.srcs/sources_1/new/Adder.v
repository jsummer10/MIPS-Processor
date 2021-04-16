`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : Adder.v
// Description  : 
//
// INPUTS
//
// OUTPUTS
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////

module Adder(A, B, AddResult);

    input [31:0] A, B;

    output reg [31:0] AddResult;

    always@ (A,B) begin
        AddResult <= A + $signed(B);
    end
    
endmodule
