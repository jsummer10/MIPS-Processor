`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : BranchPrediction_tb.v
// Description      : Test bench for the Branch Prediction unit
////////////////////////////////////////////////////////////////////////////////

module BranchPrediction_tb();

    reg Branch, Clock;
    reg PredictCorrect, Update;   
    
    wire Prediction;

    BranchPrediction    BranchPrediction_Test(Clock, Branch, Update, PredictCorrect, Prediction);

    always begin  
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
    end
    
    initial begin
    
        // Initialize
        Branch <= 1'd0; Update <= 1'd0; PredictCorrect <= 1'd0;
    
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 0000 -> NT
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd0; // T
        
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 0001 -> NT
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd0; // T
        
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 0011 -> NT
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd1; // NT
        
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 0110 -> NT
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd0; // T
        
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 1101 -> NT
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd0; // T
        
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 1011 -> NT
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd1; // NT
        
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 0110 -> NT
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd0; // T
        
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 1101 -> NT
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd0; // T
        
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 1011 -> NT
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd1; // NT
       
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 0110 -> T
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd1; // T
        
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 1101 -> T
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd1; // T
        
        #100 Branch <= 1'd1; Update <= 1'd0; PredictCorrect <= 1'd0; // 1011 -> NT
        #100 Branch <= 1'd0; Update <= 1'd1; PredictCorrect <= 1'd1; // NT
        
        // Reset
        #100 Branch <= 1'd0; Update <= 1'd0; PredictCorrect <= 1'd0;
        
    end
    

endmodule
