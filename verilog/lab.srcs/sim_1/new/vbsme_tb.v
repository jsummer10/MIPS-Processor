`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : Vbsme_tb.v
// Description      : Test bench for the Vbsme
////////////////////////////////////////////////////////////////////////////////

module Vbsme_tb();

    reg Clock;
    reg Control1, Control2, Control3, Control4;
    reg [31:0] Address1, Address2, Address3, Address4;

    wire [31:0] SAD1_1, SAD2_1, SAD3_1, SAD4_1, SAD5_1, SAD6_1, SAD7_1, SAD8_1, SAD9_1, 
                SAD10_1, SAD11_1, SAD12_1, SAD13_1, SAD14_1, SAD15_1, SAD16_1;
    
    wire [31:0] SAD1_2, SAD2_2, SAD3_2, SAD4_2, SAD5_2, SAD6_2, SAD7_2, SAD8_2, SAD9_2, 
                SAD10_2, SAD11_2, SAD12_2, SAD13_2, SAD14_2, SAD15_2, SAD16_2;
   
    wire [31:0] SAD1_3, SAD2_3, SAD3_3, SAD4_3, SAD5_3, SAD6_3, SAD7_3, SAD8_3, SAD9_3, 
                SAD10_3, SAD11_3, SAD12_3, SAD13_3, SAD14_3, SAD15_3, SAD16_3;
              
    wire [31:0] SAD1_4, SAD2_4, SAD3_4, SAD4_4, SAD5_4, SAD6_4, SAD7_4, SAD8_4, SAD9_4, 
                SAD10_4, SAD11_4, SAD12_4, SAD13_4, SAD14_4, SAD15_4, SAD16_4;

    reg [31:0] SADGroupA1, SADGroupA2, SADGroupA3, SADGroupA4;
    reg [31:0] SADGroupB1, SADGroupB2, SADGroupB3, SADGroupB4;
    reg [31:0] SADGroupC1, SADGroupC2, SADGroupC3, SADGroupC4;
    reg [31:0] SADGroupD1, SADGroupD2, SADGroupD3, SADGroupD4;
    
    wire [31:0] SmallestSAD;

    VbsmeRead   VbsmeRead_Thread1(Clock, Address1, Control1,
                                  SAD1_1, SAD2_1, SAD3_1, SAD4_1, SAD5_1, SAD6_1, SAD7_1, SAD8_1, SAD9_1, 
                                  SAD10_1, SAD11_1, SAD12_1, SAD13_1, SAD14_1, SAD15_1, SAD16_1);
    
    VbsmeRead   VbsmeRead_Thread2(Clock, Address2, Control2,
                                  SAD1_2, SAD2_2, SAD3_2, SAD4_2, SAD5_2, SAD6_2, SAD7_2, SAD8_2, SAD9_2, 
                                  SAD10_2, SAD11_2, SAD12_2, SAD13_2, SAD14_2, SAD15_2, SAD16_2);
                                  
    VbsmeRead   VbsmeRead_Thread3(Clock, Address3, Control3,
                                  SAD1_3, SAD2_3, SAD3_3, SAD4_3, SAD5_3, SAD6_3, SAD7_3, SAD8_3, SAD9_3, 
                                  SAD10_3, SAD11_3, SAD12_3, SAD13_3, SAD14_3, SAD15_3, SAD16_3);                          

    VbsmeRead   VbsmeRead_Thread4(Clock, Address4, Control4,
                                  SAD1_4, SAD2_4, SAD3_4, SAD4_4, SAD5_4, SAD6_4, SAD7_4, SAD8_4, SAD9_4, 
                                  SAD10_4, SAD11_4, SAD12_4, SAD13_4, SAD14_4, SAD15_4, SAD16_4);

    VbsmeAnalysis   Vbsme(Clock, 
                          {SAD1_1, SAD2_1, SAD3_1, SAD4_1}, {SAD5_1, SAD6_1, SAD7_1, SAD8_1}, {SAD9_1, SAD10_1, SAD11_1, SAD12_1}, {SAD13_1, SAD14_1, SAD15_1, SAD16_1},
                          {SAD1_2, SAD2_2, SAD3_2, SAD4_2}, {SAD5_2, SAD6_2, SAD7_2, SAD8_2}, {SAD9_2, SAD10_2, SAD11_2, SAD12_2}, {SAD13_2, SAD14_2, SAD15_2, SAD16_2},
                          {SAD1_3, SAD2_3, SAD3_3, SAD4_3}, {SAD5_3, SAD6_3, SAD7_3, SAD8_3}, {SAD9_3, SAD10_3, SAD11_3, SAD12_3}, {SAD13_3, SAD14_3, SAD15_3, SAD16_3},
                          {SAD1_4, SAD2_4, SAD3_4, SAD4_4}, {SAD5_4, SAD6_4, SAD7_4, SAD8_4}, {SAD9_4, SAD10_4, SAD11_4, SAD12_4}, {SAD13_4, SAD14_4, SAD15_4, SAD16_4},
                          SmallestSAD);

    reg [31:0] i, k, j;

    always begin    
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
    end

    initial begin
    
        k <= 0; j <= 0;
        
        Control1 <= 1; Control2 <= 1; Control3 <= 1; Control4 <= 1;
    
        for (i=0; i <= 15600; i = i+16) begin
            #100 Address1 <= i; Address2 <= i+4; Address3 <= i+8; Address4 <= i+12;
            
            if (k == 60) i=i+3;
            else k=k+1;
            
            j = j+1;
        end
    
        Control1 <= 0; Control2 <= 0; Control3 <= 0; Control4 <= 0;
    
    end

endmodule
