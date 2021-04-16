`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : VbsmeAnalysis_tb.v
// Description      : Test bench for the VbsmeAnalysis file
////////////////////////////////////////////////////////////////////////////////

module VbsmeAnalysis_tb();

    reg Clock;
    reg [31:0] FrameA1, FrameA2, FrameA3, FrameA4;
    reg [31:0] FrameB1, FrameB2, FrameB3, FrameB4;
    reg [31:0] FrameC1, FrameC2, FrameC3, FrameC4;
    reg [31:0] FrameD1, FrameD2, FrameD3, FrameD4;
    
    wire [31:0] SmallestSAD;

    VbsmeAnalysis   VbsmeAnalysis_Test(Clock, 
                                       FrameA1, FrameA2, FrameA3, FrameA4,
                                       FrameB1, FrameB2, FrameB3, FrameB4,
                                       FrameC1, FrameC2, FrameC3, FrameC4,
                                       FrameD1, FrameD2, FrameD3, FrameD4,
                                       SmallestSAD);

    always begin    
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
    end

    initial begin
        FrameA1 <= {8'd20, 8'd20, 8'd20, 8'd20}; FrameA2 <= {8'd20, 8'd20, 8'd20, 8'd20};
        FrameA3 <= {8'd20, 8'd20, 8'd20, 8'd20}; FrameA4 <= {8'd20, 8'd20, 8'd20, 8'd20};
        
        FrameB1 <= {8'd10, 8'd10, 8'd10, 8'd10}; FrameB2 <= {8'd10, 8'd10, 8'd10, 8'd10};
        FrameB3 <= {8'd10, 8'd10, 8'd10, 8'd10}; FrameB4 <= {8'd10, 8'd10, 8'd10, 8'd10};
        
        FrameC1 <= {8'd30, 8'd30, 8'd30, 8'd30}; FrameC2 <= {8'd30, 8'd30, 8'd30, 8'd30};
        FrameC3 <= {8'd30, 8'd30, 8'd30, 8'd30}; FrameC4 <= {8'd30, 8'd30, 8'd30, 8'd30};
        
        FrameD1 <= {8'd40, 8'd40, 8'd40, 8'd40}; FrameD2 <= {8'd40, 8'd40, 8'd40, 8'd40};
        FrameD3 <= {8'd40, 8'd40, 8'd40, 8'd40}; FrameD4 <= {8'd40, 8'd40, 8'd40, 8'd40};
    
        #100;
        
        FrameA1 <= {8'd50, 8'd50, 8'd50, 8'd50}; FrameA2 <= {8'd50, 8'd50, 8'd50, 8'd50};
        FrameA3 <= {8'd50, 8'd50, 8'd50, 8'd50}; FrameA4 <= {8'd50, 8'd50, 8'd50, 8'd50};
        
        FrameB1 <= {8'd80, 8'd80, 8'd80, 8'd80}; FrameB2 <= {8'd80, 8'd80, 8'd80, 8'd80};
        FrameB3 <= {8'd80, 8'd80, 8'd80, 8'd80}; FrameB4 <= {8'd80, 8'd80, 8'd80, 8'd80};
        
        FrameC1 <= {8'd60, 8'd60, 8'd60, 8'd60}; FrameC2 <= {8'd60, 8'd60, 8'd60, 8'd60};
        FrameC3 <= {8'd60, 8'd60, 8'd60, 8'd60}; FrameC4 <= {8'd60, 8'd60, 8'd60, 8'd60};
        
        FrameD1 <= {8'd70, 8'd70, 8'd70, 8'd70}; FrameD2 <= {8'd70, 8'd70, 8'd70, 8'd70};
        FrameD3 <= {8'd70, 8'd70, 8'd70, 8'd70}; FrameD4 <= {8'd70, 8'd70, 8'd70, 8'd70};
       
    end

endmodule
