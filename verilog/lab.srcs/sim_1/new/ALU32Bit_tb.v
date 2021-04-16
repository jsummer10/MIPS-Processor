`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : ALU32Bit_tb.v
// Description  : Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

    reg [5:0]  ALUControl;     // control bits for ALU operation
    reg [5:0]  Shamt;          // Shift amount
	reg [31:0] A, B;	       // inputs
	
	reg [63:0] HiLoReg;	       // Current HiLo Data

    wire HiLoEnable;           // Enable HiLo Writing
	wire [63:0] HiLoNewData;   // Data to be written to the HiLo Register

	wire [31:0] ALUResult;	   // result
	wire Zero;	               // Zero = 1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .Shamt(Shamt), 
        .ALUResult(ALUResult), 
        .Zero(Zero), 
        .HiLoReg(HiLoReg), 
        .HiLoNewData(HiLoNewData), 
        .HiLoEnable(HiLoEnable)
    );

    // ALUControl
    localparam [5:0] ADD    = 6'd00,   // ADD, ADDI      
                     ADDU   = 6'd01,   // ADDU, ADDIU     
                     SUB    = 6'd02,   // SUB      
                     MUL    = 6'd03,   // MUL  
                     MULT   = 6'd04,   // MULT 
                     MULTU  = 6'd05,   // MULTU
                     MADD   = 6'd06,   // MADD 
                     MSUB   = 6'd07,   // MSUB 
                     BGEZ   = 6'd08,   // BGEZ 
                     BEQ    = 6'd09,   // BEQ  
                     BNE    = 6'd10,   // BNE  
                     BGTZ   = 6'd11,   // BGTZ 
                     BLEZ   = 6'd12,   // BLEZ 
                     BLTZ   = 6'd13,   // BLTZ 
                     JUMP   = 6'd14,   // J, JAL, JR
                     // 15
                     ROTRV  = 6'd16,   // ROTRV 
                     LUI    = 6'd17,   // LUI  
                     AND    = 6'd18,   // AND, ANDI 
                     OR     = 6'd19,   // OR, ORI
                     NOR    = 6'd20,   // NOR
                     XOR    = 6'd21,   // XOR, XORI 
                     SEH    = 6'd22,   // SEH 
                     SLL    = 6'd23,   // SLL 
                     SRL    = 6'd24,   // SRL 
                     MOVN   = 6'd25,   // MOVN
                     MOVZ   = 6'd26,   // MOVZ
                     ROTR   = 6'd27,   // ROTR
                     SRA    = 6'd28,   // SRA, SRAV
                     SEB    = 6'd29,   // SEB
                     SLT    = 6'd30,   // SLT, SLTI 
                     SLTU   = 6'd31,   // SLTU, SLTIU 
                     MTHI   = 6'd32,   // MTHI
                     MTLO   = 6'd33,   // MTLO
                     MFHI   = 6'd34,   // MFHI
                     MFLO   = 6'd35,   // MFLO
                     SLLV   = 6'd36,   // SLLV
                     SRLV   = 6'd37;   // SRLV

    initial begin
    
        //--------------------
        // Initial Conditions
        //--------------------
        
        #200;
        ALUControl <= 6'b0000;
        A <= 0;
        B <= 0;
        Shamt <= 0;
        HiLoReg <= 0;
        
        #50; ALUControl <= ADD;   A <= 32'd5; B <= 32'd2;                       // ALUResult -> 7
        #50; ALUControl <= ADDU;  A <= 32'd6; B <= 32'd3;                       // ALUResult -> 9
        #50; ALUControl <= SUB;   A <= 32'd6; B <= 32'd2;                       // ALUResult -> 4
        #50; ALUControl <= MUL;   A <= 32'd2; B <= 32'd3;                       // ALUResult -> 6
        #50; ALUControl <= MULT;  A <= 32'd4; B <= 32'd3;                       // ALUResult -> 12
        #50; ALUControl <= MULTU; A <= 32'd5; B <= 32'd2;                       // ALUResult -> 10
        #50; ALUControl <= MADD;  A <= 32'd3; B <= 32'd2; HiLoReg <= 64'd20;    // ALUResult -> 0, HiLoNewData -> 26
        #50; ALUControl <= MSUB;  A <= 32'd2; B <= 32'd6; HiLoReg <= 64'd64;    // ALUResult -> 0, HiLoNewData -> 52
        #50; ALUControl <= BGEZ;  A <= 32'd2; B <= 32'd1;                       // ALUResult -> 1
        #50; ALUControl <= BEQ;   A <= 32'd3; B <= 32'd3;                       // ALUResult -> 1
        #50; ALUControl <= BNE;   A <= 32'd2; B <= 32'd1;                       // ALUResult -> 1
        #50; ALUControl <= BGTZ;  A <= 32'd5; B <= 32'd0;                       // ALUResult -> 1
        #50; ALUControl <= BLEZ;  A <= -5; B <= 32'd0;                          // ALUResult -> 1
        #50; ALUControl <= BLTZ;  A <= -6; B <= 32'd0;                          // ALUResult -> 1
        #50; ALUControl <= JUMP;  A <= 32'd1; B <= 32'd1;                       // ALUResult -> 0
        #50; ALUControl <= ROTRV; A <= 32'd2; B <= 32'd50;                      // ALUResult -> 2147483660
        #50; ALUControl <= LUI;   A <= 32'd0; B <= 32'd12;                      // ALUResult -> 786432
        #50; ALUControl <= AND;   A <= 32'd5; B <= 32'd9;                       // ALUResult -> 1
        #50; ALUControl <= OR;    A <= 32'd3; B <= 32'd10;                      // ALUResult -> 11
        #50; ALUControl <= NOR;   A <= 32'd12; B <= 32'd6;                      // ALUResult -> 4294967281
        #50; ALUControl <= XOR;   A <= 32'd16; B <= 32'd5;                      // ALUResult -> 21
        #50; ALUControl <= SEH;   A <= 32'd0; B <= 32'd15;                      // ALUResult -> 15
        #50; ALUControl <= SLL;   A <= 32'd0; B <= 32'd6;  Shamt <= 32'd2;      // ALUResult -> 24
        #50; ALUControl <= SRL;   A <= 32'd0; B <= 32'd16; Shamt <= 32'd2;      // ALUResult -> 4
        #50; ALUControl <= MOVN;  A <= 32'd5; B <= 32'd2;                       // ALUResult -> 5
        #50; ALUControl <= MOVZ;  A <= 32'd6; B <= 32'd0;                       // ALUResult -> 6
        #50; ALUControl <= ROTR;  A <= 32'd0; B <= 32'd15; Shamt <= 32'd3;      // ALUResult -> 3758096385
        #50; ALUControl <= SRA;   A <= 32'd0; B <= 32'd94; Shamt <= 32'd2;      // ALUResult -> 23
        #50; ALUControl <= SEB;   A <= 32'd0; B <= 32'd10;                      // ALUResult -> 10
        #50; ALUControl <= SLT;   A <= 32'd5; B <= 32'd8;                       // ALUResult -> 1
        #50; ALUControl <= SLTU;  A <= 32'd4; B <= 32'd9;                       // ALUResult -> 1
        #50; ALUControl <= MTHI;  A <= 32'd55; B <= 32'd0; HiLoReg <= 64'd0;    // ALUResult -> 0, HiLoNewData -> 
        #50; ALUControl <= MTLO;  A <= 32'd27; B <= 32'd0; HiLoReg <= 64'd0;    // ALUResult -> 0, HiLoNewData -> 
        #50; ALUControl <= MFHI;  A <= 32'd0; B <= 32'd0; HiLoReg <= 64'h2A00000000;  // ALUResult -> 42
        #50; ALUControl <= MFLO;  A <= 32'd0; B <= 32'd0; HiLoReg <= 64'd68;    // ALUResult -> 68
        #50; ALUControl <= SLLV;  A <= 32'd2; B <= 32'd6;                       // ALUResult -> 24
        #50; ALUControl <= SRLV;  A <= 32'd2; B <= 32'd11;                      // ALUResult -> 2
        
        
    end

endmodule

