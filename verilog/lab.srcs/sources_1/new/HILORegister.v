`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Student(s) Name and Last Name: Diego Moscoso, Fausto Sanchez, Jake Summerville
//
// Module           : HILORegister.v
// Description      : 
//
// INPUTS
//
// OUTPUTS
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////

module HILORegister(HiLoReg, Data, Enable, Clock, Reset);

    input Clock, Reset, Enable;
    input [63:0] Data;
    
    output reg [63:0] HiLoReg;
    
    initial begin
        HiLoReg <= 64'd0;
    end

    always @(negedge Clock) begin
        if (Reset) HiLoReg <= 64'd0;
        else if (Enable) HiLoReg <= Data;
    end

endmodule
