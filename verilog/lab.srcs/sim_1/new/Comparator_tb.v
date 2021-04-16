`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : Comparator_tb.v
// Description      : Test bench for the Comparator
////////////////////////////////////////////////////////////////////////////////

module Comparator_tb();

    reg [2:0] Control;
    reg [31:0] InA, InB;
    
    wire Result;
    
    Comparator Comparator_Test(InA, InB, Result, Control);

    // Control Signals
    // BEQ  = 0
    // BGEZ = 1
    // BGTZ = 2
    // BLEZ = 3
    // BLTZ = 4
    // BNE  = 5

    initial begin
    
        // BEQ
        #50 InA <= 32'd5; InB <= 32'd5; Control <= 3'd1; // A = B  -> Result: 1
        #50 InA <= 32'd5; InB <= 32'd2; Control <= 3'd1; // A = B  -> Result: 0
        
        // BGEZ
        #50 InA <= 32'd5; InB <= 32'd1; Control <= 3'd2; // A >= 0 -> Result: 1
        #50 InA <= 32'd0; InB <= 32'd1; Control <= 3'd2; // A >= 0 -> Result: 1
        #50 InA <= -5;    InB <= 32'd1; Control <= 3'd2; // A >= 0 -> Result: 0
        
        // BGTZ
        #50 InA <= 32'd5; InB <= 32'd0; Control <= 3'd3; // A > 0  -> Result: 1
        #50 InA <= 32'd0; InB <= 32'd0; Control <= 3'd3; // A > 0  -> Result: 0
        #50 InA <= -5;    InB <= 32'd0; Control <= 3'd3; // A > 0  -> Result: 0
        
        // BLEZ
        #50 InA <= 32'd5; InB <= 32'd0; Control <= 3'd4; // A <= 0 -> Result: 0 
        #50 InA <= 32'd0; InB <= 32'd0; Control <= 3'd4; // A <= 0 -> Result: 1
        #50 InA <= -5;    InB <= 32'd0; Control <= 3'd4; // A <= 0 -> Result: 1
        
        // BLTZ
        #50 InA <= 32'd5; InB <= 32'd0; Control <= 3'd5; // A < 0  -> Result: 0
        #50 InA <= 32'd0; InB <= 32'd0; Control <= 3'd5; // A < 0  -> Result: 0
        #50 InA <= -5;    InB <= 32'd0; Control <= 3'd5; // A < 0  -> Result: 1
        
        // BNE
        #50 InA <= 32'd5; InB <= 32'd5; Control <= 3'd6; // A != B -> Result: 0
        #50 InA <= 32'd5; InB <= 32'd2; Control <= 3'd6; // A != B -> Result: 1
       
    end

endmodule
