`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : BranchPrediction.v
// Description      : This file is responsible for the branch prediction
//                    Implements a correlating branch predictor (2,2)
////////////////////////////////////////////////////////////////////////////////


module BranchPrediction(Clock, Branch, Update, PredictWrong, Prediction);

    input Branch, Clock;
    input PredictWrong, Update;   
    
    output reg Prediction;
    
    reg [3:0] Shift;
    
    reg [31:0] BTB_PC [0:15];
    reg [31:0] BTB_Prediction [0:15];
    
    localparam PREDICT_NT = 1'b0;
    localparam PREDICT_T  = 1'b1;
    
    localparam [1:0] SNT = 2'd0,   // Strongly Not Taken
                     WNT = 2'd1,   // Weakly Not Taken
                     WT  = 2'd2,   // Weakly Taken
                     ST  = 2'd3;   // Strongly Taken

    integer i;
        
    initial begin
        // Initialize branch history table to 0
        for (i=0; i <= 127; i = i+1) begin
            BTB_PC[i]         <= 32'd0;
            BTB_Prediction[i] <= ST;
        end
        
        Shift      <= 4'b0000;
        Prediction <= 1'b0;
    end
    
    always @(Branch, Shift) begin
        
        //-------------------
        // Branch Prediction
        //-------------------
        
        if (Branch) begin
            case (BTB_Prediction[Shift])
                SNT: Prediction <= PREDICT_NT;   // Strongly Not Taken -> Predict: Not Taken
                WNT: Prediction <= PREDICT_NT;   // Weakly Not Taken   -> Predict: Not Taken
                WT:  Prediction <= PREDICT_T;    // Weakly Taken       -> Predict: Taken
                ST:  Prediction <= PREDICT_T;    // Strongly Taken     -> Predict: Taken
                default: Prediction <= PREDICT_NT;
            endcase
        end
        
        else Prediction <= 1'b0;

    end

    always @(posedge Clock) begin

        //-------------------
        //   Update State
        //-------------------

        if (Update) begin
        
            // Correct previous prediction
            if(!PredictWrong) begin
                case (BTB_Prediction[Shift])
                
                    SNT: begin
                        BTB_Prediction[Shift] <= SNT;   // Strongly Not Taken -> Stay
                        Shift <= Shift << 1;            // Inject 0 into shift
                    end
                    
                    WNT: begin
                        BTB_Prediction[Shift] <= SNT;   // Weakly Not Taken   -> Strongly Not Taken
                        Shift <= Shift << 1;            // Inject 0 into shift
                    end
                    
                    WT: begin
                        BTB_Prediction[Shift] <= ST;    // Weakly Taken       -> Strongly Taken
                        Shift <= (Shift << 1) | 1'b1;   // Inject 1 into shift
                    end
                    
                    ST: begin  
                        BTB_Prediction[Shift] <= ST;    // Strongly Taken     -> Stay
                        Shift <= (Shift << 1) | 1'b1;   // Inject 1 into shift
                    end
                    
                    default: begin end
                    
                endcase
            end
            
            // Incorrect previous prediction
            else begin
                case (BTB_Prediction[Shift])
                
                    SNT: begin 
                        BTB_Prediction[Shift] <= WNT;   // Strongly Not Taken -> Weakly Not Taken
                        Shift <= (Shift << 1) | 1'b1;   // Inject 1 into shift
                    end
                    
                    WNT: begin
                        BTB_Prediction[Shift] <= WT;    // Weakly Not Taken   -> Weakly Taken
                        Shift <= (Shift << 1) | 1'b1;   // Inject 1 into shift
                    end
                    
                    WT: begin
                        BTB_Prediction[Shift] <= WNT;   // Weakly Taken       -> Weakly Not Taken
                        Shift <= Shift << 1;            // Inject 0 into shift
                    end
                    
                    ST: begin
                        BTB_Prediction[Shift] <= WT;    // Strongly Taken     -> Weakly Taken
                        Shift <= Shift << 1;            // Inject 0 into shift
                    end
                    
                    default: begin end
                    
                endcase
            end
        end

    end
    
endmodule
