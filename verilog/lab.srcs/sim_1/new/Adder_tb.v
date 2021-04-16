`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : Adder_tb.v
// Description  : Adder testbench
//
// INPUTS
//
// OUTPUTS
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////


module Adder_tb();

    reg [31:0] PCResult;

    wire [31:0] AddResult;

    Adder AdderTest(
        .A(PCResult),
        .B({29'd0, 3'd4}), 
        .AddResult(AddResult)
    );

	initial begin
	
        #200
        PCResult = 0;
        
        #200
        PCResult = 4;
        
        #200
        PCResult = 6;
    
	end

endmodule