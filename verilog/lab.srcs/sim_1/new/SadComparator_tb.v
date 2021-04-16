`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2020 11:07:34 AM
// Design Name: 
// Module Name: SadComparator_tb
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


module SadComparator_tb();
    
    reg Clock;
    reg [31:0] A, B, C, D, Prev;
    wire [2:0] OutSel;
    
    SadComparator   SadCompare_Test(A, B, C, D, Prev, OutSel);
    
    always begin    
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
    end
    
    initial begin
    
        A <= 32'd5; B <= 32'd10; C <= 32'd15; D <= 32'd20; Prev <= 32'd25;
        
        #100 A <= 32'd25; B <= 32'd20; C <= 32'd15; D <= 32'd10; Prev <= 32'd5;
        #100 A <= 32'd5; B <= 32'd50; C <= 32'd40; D <= 32'd30; Prev <= 32'd10;
        #100 A <= 32'd50; B <= 32'd5; C <= 32'd40; D <= 32'd30; Prev <= 32'd10;
        #100 A <= 32'd50; B <= 32'd40; C <= 32'd5; D <= 32'd30; Prev <= 32'd10;
        #100 A <= 32'd50; B <= 32'd30; C <= 32'd40; D <= 32'd5; Prev <= 32'd10;
        
        #100 A <= 32'd0; B <= 32'd0; C <= 32'd0; D <= 32'd0; Prev <= 32'd0;
    end
    
endmodule
