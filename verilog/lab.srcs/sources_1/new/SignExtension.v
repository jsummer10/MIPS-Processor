`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : SignExtension.v
// Description  : Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out);

    /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
    // Sign extend with correct upper bits
    always @(in) begin
    if (in[15] == 1) 
        out <= {16'hFFFF, in};
    else 
        out <= {16'h0000, in};
    end

endmodule
