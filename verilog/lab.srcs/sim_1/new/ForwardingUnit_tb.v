`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : ForwardingUnit_tb.v
// Description      : Test bench for the ForwardingUnit
////////////////////////////////////////////////////////////////////////////////

module ForwardingUnit_tb();

    reg       RegWrite_EXMEM, RegWrite_MEMWB;
    reg [4:0] RegRD_EXMEM, RegRD_MEMWB;
    reg [4:0] RegRS_IDEX, RegRT_IDEX;
    
    wire [1:0] ForwardMuxA, ForwardMuxB;
    
    ForwardingUnit Forwarding_Test(
        // --- Inputs ---
        RegWrite_EXMEM, RegWrite_MEMWB,     // RegWrite Control Signals
        RegRD_EXMEM, RegRD_MEMWB,           // RegDst Control Signals
        RegRS_IDEX, RegRT_IDEX,             
        
        // --- Outputs --- 
        ForwardMuxA, ForwardMuxB);
    
    
    initial begin 
    
        // Zero
        RegRS_IDEX <= 5'd8; RegRT_IDEX <= 5'd9;
        RegWrite_EXMEM <= 1'd0; RegRD_EXMEM <= 5'd0; RegWrite_MEMWB <= 1'd0; RegRD_MEMWB <= 5'd0;
    
        // EXMEM Forwarding
        #100 RegWrite_EXMEM <= 1'd1; RegRD_EXMEM <= 5'd8; RegWrite_MEMWB <= 1'd0; RegRD_MEMWB <= 5'd0;  // ForwardMuxA = 1
        #100 RegWrite_EXMEM <= 1'd1; RegRD_EXMEM <= 5'd9; RegWrite_MEMWB <= 1'd0; RegRD_MEMWB <= 5'd0;  // ForwardMuxB = 1
        #100 RegWrite_EXMEM <= 1'd0; RegRD_EXMEM <= 5'd8; RegWrite_MEMWB <= 1'd0; RegRD_MEMWB <= 5'd0;  // ForwardMuxA = 0
        #100 RegWrite_EXMEM <= 1'd0; RegRD_EXMEM <= 5'd9; RegWrite_MEMWB <= 1'd0; RegRD_MEMWB <= 5'd0;  // ForwardMuxB = 0
    
        // MEMWB Forwarding
        #100 RegWrite_EXMEM <= 1'd0; RegRD_EXMEM <= 5'd0; RegWrite_MEMWB <= 1'd1; RegRD_MEMWB <= 5'd8;  // ForwardMuxA = 2
        #100 RegWrite_EXMEM <= 1'd0; RegRD_EXMEM <= 5'd0; RegWrite_MEMWB <= 1'd1; RegRD_MEMWB <= 5'd9;  // ForwardMuxB = 2
        #100 RegWrite_EXMEM <= 1'd0; RegRD_EXMEM <= 5'd0; RegWrite_MEMWB <= 1'd0; RegRD_MEMWB <= 5'd8;  // ForwardMuxA = 0
        #100 RegWrite_EXMEM <= 1'd0; RegRD_EXMEM <= 5'd0; RegWrite_MEMWB <= 1'd0; RegRD_MEMWB <= 5'd9;  // ForwardMuxB = 0
        
        // Combo
        #100 RegWrite_EXMEM <= 1'd1; RegRD_EXMEM <= 5'd8; RegWrite_MEMWB <= 1'd1; RegRD_MEMWB <= 5'd9;  // ForwardMuxA = 1, ForwardMuxB = 2
        #100 RegWrite_EXMEM <= 1'd1; RegRD_EXMEM <= 5'd9; RegWrite_MEMWB <= 1'd1; RegRD_MEMWB <= 5'd8;  // ForwardMuxA = 2, ForwardMuxB = 1
    
        // Zero
        #100 RegRS_IDEX <= 5'd0; RegRT_IDEX <= 5'd0;
        RegWrite_EXMEM <= 1'd0; RegRD_EXMEM <= 5'd0; RegWrite_MEMWB <= 1'd0; RegRD_MEMWB <= 5'd0;
    
    end
    
endmodule
