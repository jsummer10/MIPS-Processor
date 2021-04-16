`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : ForwardingUnit.v
// Description      : This file controls the forwarding unit
////////////////////////////////////////////////////////////////////////////////

module ForwardingUnit(
    
    // --- Inputs ---
    RegWrite_EXMEM, RegWrite_MEMWB,     // RegWrite Control Signals
    RegDst_EXMEM, RegDst_MEMWB,           // RegDst Control Signals
    RegRS_IDEX, RegRT_IDEX,         
    RegRS_IFID, RegRT_IFID,    
    
    // --- Outputs --- 
    ForwardMuxA_EX, ForwardMuxB_EX,           // Forwarding Muxes
    ForwardMuxA_ID, ForwardMuxB_ID);          
    
    //--------------------------------
    // Inputs
    //--------------------------------
    
    input       RegWrite_EXMEM, RegWrite_MEMWB;
    input [4:0] RegDst_EXMEM, RegDst_MEMWB;
    input [4:0] RegRS_IDEX, RegRT_IDEX;
    input [4:0] RegRS_IFID, RegRT_IFID;
    
    //--------------------------------
    // Outputs
    //--------------------------------
    
    output reg [1:0] ForwardMuxA_EX, ForwardMuxB_EX;
    output reg ForwardMuxA_ID, ForwardMuxB_ID;
    
    //--------------------------------
    // Forwarding Logic
    //--------------------------------
    
    initial begin
        ForwardMuxA_ID <= 1'b0;
        ForwardMuxB_ID <= 1'b0;
        ForwardMuxA_EX <= 2'b00;
        ForwardMuxB_EX <= 2'b00;
    end
    
    always @ (*) begin
        
        //-----------------
        // Forwarding - ID
        //-----------------
        
        // ForwardMuxA
        if ((RegWrite_EXMEM && (RegDst_EXMEM != 0)) && (RegDst_EXMEM == RegRS_IFID))      ForwardMuxA_ID <= 1'd1;
        else ForwardMuxA_ID <= 1'd0;
        
        // ForwardMuxB
        if ((RegWrite_EXMEM && (RegDst_EXMEM != 0)) && (RegDst_EXMEM == RegRT_IFID))      ForwardMuxB_ID <= 1'd1;
        else ForwardMuxB_ID <= 1'd0;
        
        //-----------------
        // Forwarding - EX
        //-----------------
        
        // ForwardMuxA
        if ((RegWrite_EXMEM && (RegDst_EXMEM != 0)) && (RegDst_EXMEM == RegRS_IDEX))      ForwardMuxA_EX <= 2'd1;
        else if ((RegWrite_MEMWB && (RegDst_MEMWB != 0)) && (RegDst_MEMWB == RegRS_IDEX)) ForwardMuxA_EX <= 2'd2;
        else ForwardMuxA_EX <= 2'b00;
    
        // ForwardMuxB
        if ((RegWrite_EXMEM && (RegDst_EXMEM != 0)) && (RegDst_EXMEM == RegRT_IDEX))      ForwardMuxB_EX <= 2'd1;
        else if ((RegWrite_MEMWB && (RegDst_MEMWB != 0)) && (RegDst_MEMWB == RegRT_IDEX)) ForwardMuxB_EX <= 2'd2;
        else ForwardMuxB_EX <= 2'b00;
     
    end
    
endmodule
