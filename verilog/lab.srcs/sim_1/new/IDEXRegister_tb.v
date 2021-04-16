`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : IDEXRegister_tb.v
// Description      : Test bench for the IDEXRegister
////////////////////////////////////////////////////////////////////////////////

module IDEXRegister_tb();

    reg        Clock;
    reg [4:0]  In_RegRT, In_RegRD, In_RegRS;
    reg [31:0] In_ControlSignal, In_ReadData1, In_ReadData2, In_SignExtend, In_PCAdder;
    
    wire [4:0]  Out_RegRT, Out_RegRD, Out_RegRS;
    wire [31:0] Out_ControlSignal, Out_ReadData1, Out_ReadData2, Out_SignExtend, Out_PCAdder;

    IDEXRegister    IDEXRegister_Test(
        Clock,
        In_ControlSignal, In_ReadData1, In_ReadData2, In_SignExtend, In_PCAdder,
        In_RegRT, In_RegRD, In_RegRS,
        
        Out_ControlSignal, Out_ReadData1, Out_ReadData2, Out_SignExtend, Out_PCAdder,
        Out_RegRT, Out_RegRD, Out_RegRS
    );
    
    always begin  
      
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
        
    end
    
    initial begin
    
        #100 In_RegRT <= 5'd1; In_RegRD <= 5'd2; In_RegRS <= 5'd3;
        In_ControlSignal <= 32'd10; In_ReadData1 <= 32'd11; In_ReadData2 <= 32'd12; 
        In_SignExtend <= 32'd13; In_PCAdder <= 32'd14;
        
        #100 In_RegRT <= 5'd5; In_RegRD <= 5'd6; In_RegRS <= 5'd7;
        In_ControlSignal <= 32'd20; In_ReadData1 <= 32'd21; In_ReadData2 <= 32'd22; 
        In_SignExtend <= 32'd23; In_PCAdder <= 32'd24;
    
    end

endmodule