`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : ProgramCounter_tb.v
// Description  : ProgramCounter testbench
//
// INPUTS
//
// OUTPUTS
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////


module ProgramCounter_tb();

    reg [31:0] Address;
	reg Reset, Clk;

	wire [31:0] PCResult;

    ProgramCounter u0(
        .Address(Address), 
        .PCResult(PCResult), 
        .Reset(Reset), 
        .Clk(Clk)
    );

	initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end

	initial begin
	
    #100 Reset <= 1'b1; 
     
     @ (posedge Clk);
     
    #100 Reset <= 1'b0;
    #100 Address <= 32'd4;
    
    @ (posedge Clk);
    
    Address <= 32'd8;
    
    @ (posedge Clk);
    
    #100 Reset <= 1'b0;
     Address <= 32'd12;
     
    @ (posedge Clk);
    
    #100 Reset <= 1'b0; 
    Address <= 32'd16;
    
    @ (posedge Clk);
    
    #100 Reset <= 1'b0; 
    Address <= 32'h00000AA1;
    
	end

endmodule
