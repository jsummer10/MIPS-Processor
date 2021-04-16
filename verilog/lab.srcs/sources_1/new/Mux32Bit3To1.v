`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : Mux32Bit3To1.v
// Description  : Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit3To1(out, inA, inB, inC, sel);

    output reg [31:0] out;
    
    input [31:0] inA, inB, inC;
    input [1:0]  sel;

    always @ (inA, inB, inC, sel) begin
        case (sel)
            2'b00: out <= inA;
            2'b01: out <= inB;
            2'b10: out <= inC;
            default: out <= 0;
        endcase
    end

endmodule