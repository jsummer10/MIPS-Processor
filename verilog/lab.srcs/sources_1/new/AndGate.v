`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : AndGate.v
// Description      : Compares and returns the 'and' of two values
////////////////////////////////////////////////////////////////////////////////

module AndGate(InA, InB, Out);
    input InA, InB;
    output Out;
    
    assign Out = InA & InB;
endmodule
