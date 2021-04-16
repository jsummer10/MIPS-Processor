`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2020 10:03:13 AM
// Design Name: 
// Module Name: SadAdder_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Cre`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : SadAdder_tb.v
// Description      : Test bench for the SadAdder file
////////////////////////////////////////////////////////////////////////////////

module SadAdder_tb();

    reg Clock;
    reg [31:0] Frame1, Frame2, Frame3, Frame4, Frame5, Frame6, Frame7, Frame8, Frame9, 
               Frame10, Frame11, Frame12, Frame13, Frame14, Frame15, Frame16;
    
    wire [31:0] Sum;

    SadAdder   SadAdder_Test(Frame1, Frame2, Frame3, Frame4, Frame5, Frame6, Frame7, Frame8, Frame9, 
                             Frame10, Frame11, Frame12, Frame13, Frame14, Frame15, Frame16,
                             Sum);

    always begin    
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
    end

    initial begin
        Frame1 <= 8'd0; Frame2 <= 8'd0; Frame3 <= 8'd0; Frame4 <= 8'd0; 
        Frame5 <= 8'd0; Frame6 <= 8'd0; Frame7 <= 8'd0; Frame8 <= 8'd0; 
        Frame9 <= 8'd0; Frame10 <= 8'd0; Frame11 <= 8'd0; Frame12 <= 8'd0; 
        Frame13 <= 8'd0; Frame14 <= 8'd0; Frame15 <= 8'd0; Frame16 <= 8'd0;
        
        #100;

        Frame1 <= 8'd5; Frame2 <= 8'd5; Frame3 <= 8'd5; Frame4 <= 8'd5; 
        Frame5 <= 8'd5; Frame6 <= 8'd5; Frame7 <= 8'd5; Frame8 <= 8'd5; 
        Frame9 <= 8'd5; Frame10 <= 8'd5; Frame11 <= 8'd5; Frame12 <= 8'd5; 
        Frame13 <= 8'd5; Frame14 <= 8'd5; Frame15 <= 8'd5; Frame16 <= 8'd5;

        #100;

        Frame1 <= 8'd242; Frame2 <= 8'd3; Frame3 <= 8'd42; Frame4 <= 8'd75; 
        Frame5 <= 8'd74; Frame6 <= 8'd104; Frame7 <= 8'd186; Frame8 <= 8'd214; 
        Frame9 <= 8'd47; Frame10 <= 8'd95; Frame11 <= 8'd5; Frame12 <= 8'd117; 
        Frame13 <= 8'd142; Frame14 <= 8'd61; Frame15 <= 8'd235; Frame16 <= 8'd156;

    end

endmodule
