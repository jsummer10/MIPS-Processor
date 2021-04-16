`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Student(s) Name and Last Name: Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : Datapath.v
// Description      : Top level datapath test bench
//
// INPUTS
//
// OUTPUTS
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////


module Datapath_tb();

    reg         Reset, Clock;

    wire [6:0] out7;
    wire [7:0] en_out;
    
    // Datapath Component
    Datapath    MainTest(.ClockIn(Clock), 
                         .Reset(Reset), 
                         .out7(out7), 
                         .en_out(en_out));
    
    always begin    
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
    end
    
    initial begin
        Reset <= 1;
        @(posedge Clock);
        #100 
        Reset <= 0; 
    end

endmodule
