`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2020 06:01:38 PM
// Design Name: 
// Module Name: Mux8To1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux8To1(out, inA, inB, inC, inD, inE, inF, inG, inH, sel);

    output reg [31:0] out;
    
    input [31:0] inA, inB, inC, inD, inE, inF, inG, inH;
    input [2:0]  sel;

    always @ (*) begin
        case (sel)
            3'b000: out <= inA;
            3'b001: out <= inB;
            3'b010: out <= inC;
            3'b011: out <= inD;     
            3'b100: out <= inE;
            3'b101: out <= inF;
            3'b110: out <= inG;
            3'b111: out <= inH;
        endcase
    end

endmodule
