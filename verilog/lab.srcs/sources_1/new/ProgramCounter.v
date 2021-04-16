`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : ProgramCounter.v
// Description  : 
//
// INPUTS
//
// OUTPUTS
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter(PC_In, PCResult, Enable, Reset, Clock);

	input [31:0] PC_In;
	input Reset, Clock, Enable;

	output reg [31:0] PCResult;
    
//    (* mark_debug = "true" *) reg NewSadLoop, FirstSadComplete;
//    (* mark_debug = "true" *) reg [31:0] SadLoops;
    
    initial begin
        PCResult <= 32'h0000000;
//        SadLoops <= 32'd0;
    end
    
    always @(posedge Clock, posedge Reset) begin
    
        if(Reset)
            PCResult <= 32'h0000000;
        else if (Enable)
            PCResult <= PC_In;
 
//        if (PC_In == 32'd600) NewSadLoop <= 1'b1;
//        else NewSadLoop <= 1'b0;
 
//        if (PC_In == 32'd600) SadLoops <= SadLoops + 1;
//        else if (PC_In == 32'd708) SadLoops <= 0;
 
//        if (PC_In == 32'd264) FirstSadComplete <= 1'b1;
//        else FirstSadComplete <= 1'b0;
 
    end

endmodule

