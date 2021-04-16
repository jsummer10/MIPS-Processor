`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : ALUController_tb.v
// Description      : Test bench for the ALUController
////////////////////////////////////////////////////////////////////////////////

module ALUController_tb();
    
    reg [5:0] ALUOp;
    reg [5:0] Funct;
    
    wire [5:0] ALUControl;
    
    ALUController  ALUControlTest(Funct, ALUOp, ALUControl);
    
    initial begin
    
        #50 ALUOp <= 6'd00; Funct <= 6'b100000;  // ADD   -> ALUControl: 00
        #50 ALUOp <= 6'd02; Funct <= 6'b000000;  // ADDI  -> ALUControl: 00
        #50 ALUOp <= 6'd00; Funct <= 6'b100001;  // ADDU  -> ALUControl: 01
        #50 ALUOp <= 6'd01; Funct <= 6'b000000;  // ADDIU -> ALUControl: 01
        #50 ALUOp <= 6'd00; Funct <= 6'b100010;  // SUB   -> ALUControl: 02
        #50 ALUOp <= 6'd03; Funct <= 6'b000010;  // MUL   -> ALUControl: 03
        #50 ALUOp <= 6'd00; Funct <= 6'b011000;  // MULT  -> ALUControl: 04
        #50 ALUOp <= 6'd00; Funct <= 6'b011001;  // MULTU -> ALUControl: 05
        #50 ALUOp <= 6'd03; Funct <= 6'b000000;  // MADD  -> ALUControl: 06
        #50 ALUOp <= 6'd03; Funct <= 6'b000100;  // MSUB  -> ALUControl: 07
        #50 ALUOp <= 6'd10; Funct <= 6'b000000;  // BGEZ  -> ALUControl: 08
        #50 ALUOp <= 6'd06; Funct <= 6'b000000;  // BEQ   -> ALUControl: 09
        #50 ALUOp <= 6'd07; Funct <= 6'b000000;  // BNE   -> ALUControl: 10
        #50 ALUOp <= 6'd08; Funct <= 6'b000000;  // BGTZ  -> ALUControl: 11
        #50 ALUOp <= 6'd09; Funct <= 6'b000000;  // BLEZ  -> ALUControl: 12
        #50 ALUOp <= 6'd05; Funct <= 6'b000000;  // BLTZ  -> ALUControl: 13
        #50 ALUOp <= 6'd11; Funct <= 6'b000000;  // J     -> ALUControl: 14
        #50 ALUOp <= 6'd11; Funct <= 6'b000000;  // JAL   -> ALUControl: 14
        #50 ALUOp <= 6'd11; Funct <= 6'b001000;  // JR    -> ALUControl: 14
        #50 ALUOp <= 6'd04; Funct <= 6'b000000;  // LUI   -> ALUControl: 17
        #50 ALUOp <= 6'd00; Funct <= 6'b100100;  // AND   -> ALUControl: 18
        #50 ALUOp <= 6'd12; Funct <= 6'b000000;  // ANDI  -> ALUControl: 18
        #50 ALUOp <= 6'd00; Funct <= 6'b100101;  // OR    -> ALUControl: 19
        #50 ALUOp <= 6'd13; Funct <= 6'b000000;  // ORI   -> ALUControl: 19
        #50 ALUOp <= 6'd00; Funct <= 6'b100111;  // NOR   -> ALUControl: 20
        #50 ALUOp <= 6'd00; Funct <= 6'b100110;  // XOR   -> ALUControl: 21
        #50 ALUOp <= 6'd14; Funct <= 6'b000000;  // XORI  -> ALUControl: 21
        #50 ALUOp <= 6'd21; Funct <= 6'b100000;  // SEH   -> ALUControl: 22
        #50 ALUOp <= 6'd00; Funct <= 6'b000000;  // SLL   -> ALUControl: 23
        #50 ALUOp <= 6'd18; Funct <= 6'b000010;  // SRL   -> ALUControl: 24
        #50 ALUOp <= 6'd00; Funct <= 6'b001011;  // MOVN  -> ALUControl: 25
        #50 ALUOp <= 6'd00; Funct <= 6'b001010;  // MOVZ  -> ALUControl: 26
        #50 ALUOp <= 6'd19; Funct <= 6'b000010;  // ROTR  -> ALUControl: 27
        #50 ALUOp <= 6'd19; Funct <= 6'b000110;  // ROTRV -> ALUControl: 27
        #50 ALUOp <= 6'd00; Funct <= 6'b000011;  // SRA   -> ALUControl: 28
        #50 ALUOp <= 6'd00; Funct <= 6'b000111;  // SRAV  -> ALUControl: 28
        #50 ALUOp <= 6'd15; Funct <= 6'b100000;  // SEB   -> ALUControl: 29
        #50 ALUOp <= 6'd00; Funct <= 6'b101010;  // SLT   -> ALUControl: 30
        #50 ALUOp <= 6'd16; Funct <= 6'b000000;  // SLTI  -> ALUControl: 30
        #50 ALUOp <= 6'd17; Funct <= 6'b000000;  // SLTIU -> ALUControl: 31
        #50 ALUOp <= 6'd00; Funct <= 6'b101011;  // SLTU  -> ALUControl: 31
        #50 ALUOp <= 6'd00; Funct <= 6'b010001;  // MTHI  -> ALUControl: 32
        #50 ALUOp <= 6'd00; Funct <= 6'b010011;  // MTLO  -> ALUControl: 33
        #50 ALUOp <= 6'd00; Funct <= 6'b010000;  // MFHI  -> ALUControl: 34
        #50 ALUOp <= 6'd00; Funct <= 6'b010010;  // MFLO  -> ALUControl: 35
        #50 ALUOp <= 6'd00; Funct <= 6'b000100;  // SLLV  -> ALUControl: 36
        #50 ALUOp <= 6'd20; Funct <= 6'b000110;  // SRLV  -> ALUControl: 37

    end
endmodule