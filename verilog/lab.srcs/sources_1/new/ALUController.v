`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Group Members    : Diego Moscoso, Fausto Sanchez, Jake Summerville
// Percent Effort   : 33.3% - 33.3% - 33.3%
//
// Module           : ALUController.v
// Description      : This file analyzes the ALUOp code from the controller
//                    and sends the corresponding ALUControl code to the ALU
////////////////////////////////////////////////////////////////////////////////

module ALUController(Funct, ALUOp, ALUControl);
         
    input [5:0] ALUOp;    // ALUOp From the Controller         
    input [5:0] Funct;    // Funct code from the instruction
    
    output reg [5:0] ALUControl;    // Control signal to ALU
    
    // OpCodes From ALU
    localparam [5:0] ALUOP_ZERO    = 6'd00,  // ZERO
                     ALUOP_ADDIU   = 6'd01,  // ADDIU
                     ALUOP_ADDI    = 6'd02,  // ADDI
                     ALUOP_MUL     = 6'd03,  // MUL, MADD, MSUB
                     ALUOP_LUI     = 6'd04,  // LUI
                     ALUOP_BLTZ    = 6'd05,  // BLTZ
                     ALUOP_BEQ     = 6'd06,  // BEQ
                     ALUOP_BNE     = 6'd07,  // BNE
                     ALUOP_BGTZ    = 6'd08,  // BGTZ
                     ALUOP_BLEZ    = 6'd09,  // BLEZ
                     ALUOP_BGEZ    = 6'd10,  // BGEZ
                     ALUOP_JUMP    = 6'd11,  // J, JAL, JR
                     ALUOP_ANDI    = 6'd12,  // ANDI
                     ALUOP_ORI     = 6'd13,  // ORI
                     ALUOP_XORI    = 6'd14,  // XORI
                     ALUOP_SEB     = 6'd15,  // SEB
                     ALUOP_SLTI    = 6'd16,  // SLTI
                     ALUOP_SLTIU   = 6'd17,  // SLTIU
                     ALUOP_SRL     = 6'd18,  // SRL
                     ALUOP_ROTR    = 6'd19,  // ROTR
                     ALUOP_SRLV    = 6'd20,  // SRLV
                     ALUOP_SEH     = 6'd21,  // SEH
                     ALUOP_ROTRV   = 6'd22,  // ROTRV
                     ALUOP_EXI     = 6'd23,  // EH, IH, DH, EB, IB, ABS
                     ALUOP_LA      = 6'd24;       // LA
                     
                        
    // Func Codes from Instruction       
    localparam [5:0] FUNC_ADD       =  6'b100000,   // ADD  
                     FUNC_ADDU      =  6'b100001,   // ADDU
                     FUNC_AND       =  6'b100100,   // AND 
                     FUNC_JR        =  6'b001000,   // JR  
                     FUNC_MADD      =  6'b000000,   // MADD 
                     FUNC_MFHI      =  6'b010000,   // MFHI 
                     FUNC_MFLO      =  6'b010010,   // MFLO 
                     FUNC_MOVN      =  6'b001011,   // MOVN 
                     FUNC_MOVZ      =  6'b001010,   // MOVZ  
                     FUNC_MSUB      =  6'b000100,   // MSUB 
                     FUNC_MTHI      =  6'b010001,   // MTHI 
                     FUNC_MTLO      =  6'b010011,   // MTLO
                     FUNC_MUL       =  6'b000010,   // MUL  
                     FUNC_MULT      =  6'b011000,   // MULT 
                     FUNC_MULTU     =  6'b011001,   // MULTU
                     FUNC_NOR       =  6'b100111,   // NOR 
                     FUNC_OR        =  6'b100101,   // OR 
                     FUNC_ROTR      =  6'b000010,   // ROTR
                     FUNC_ROTRV     =  6'b000110,   // ROTRV
                     FUNC_SEB       =  6'b100000,   // SEB, SEH 
                     FUNC_SLL       =  6'b000000,   // SLL  
                     FUNC_SLLV      =  6'b000100,   // SLLV 
                     FUNC_SLT       =  6'b101010,   // SLT 
                     FUNC_SLTU      =  6'b101011,   // SLTU    
                     FUNC_SRA       =  6'b000011,   // SRA  
                     FUNC_SRAV      =  6'b000111,   // SRAV 
                     FUNC_SRL       =  6'b000010,   // SRL 
                     FUNC_SRLV      =  6'b000110,   // SRLV 
                     FUNC_SUB       =  6'b100010,   // SUB  
                     FUNC_XOR       =  6'b100110,   // XOR  
                     FUNC_EH        =  6'b011000,   // EH
                     FUNC_IH        =  6'b010100,   // IH
                     FUNC_DH        =  6'b011100,   // DH
                     FUNC_EB        =  6'b010010,   // EB
                     FUNC_IB        =  6'b011010,   // IB
                     FUNC_ABS       =  6'b011001;   // ABS
                                              
     
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
                     SRAV   = 6'd15,   // SRAV
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
                     ROTR   = 6'd27,   // ROTR, ROTRV
                     SRA    = 6'd28,   // SRA, SRAV
                     SEB    = 6'd29,   // SEB
                     SLT    = 6'd30,   // SLT, SLTI 
                     SLTU   = 6'd31,   // SLTU, SLTIU 
                     MTHI   = 6'd32,   // MTHI
                     MTLO   = 6'd33,   // MTLO
                     MFHI   = 6'd34,   // MFHI
                     MFLO   = 6'd35,   // MFLO
                     SLLV   = 6'd36,   // SLLV
                     SRLV   = 6'd37,   // SRLV
                     EH     = 6'd38,   // EH
                     IH     = 6'd39,   // IH
                     DH     = 6'd40,   // DH
                     EB     = 6'd41,   // EB
                     IB     = 6'd42,   // IB
                     ABS    = 6'd43,   // ABS
                     LA     = 6'd44;   // LA

    initial begin
        ALUControl <= 6'b000000;
    end
    
    always @(*) begin
        
        case(ALUOp)

            ALUOP_ZERO: begin 
                case(Funct)
                    FUNC_SLL  : ALUControl <= SLL;
                    FUNC_SRA  : ALUControl <= SRA;
                    FUNC_SLLV : ALUControl <= SLLV; 
                    FUNC_SRAV : ALUControl <= SRAV;
                    FUNC_ADD  : ALUControl <= ADD;
                    FUNC_ADDU : ALUControl <= ADDU;
                    FUNC_SUB  : ALUControl <= SUB;
                    FUNC_AND  : ALUControl <= AND;
                    FUNC_OR   : ALUControl <= OR;
                    FUNC_XOR  : ALUControl <= XOR;
                    FUNC_NOR  : ALUControl <= NOR;
                    FUNC_SLT  : ALUControl <= SLT;
                    FUNC_SLTU : ALUControl <= SLTU;
                    FUNC_MOVZ : ALUControl <= MOVZ;
                    FUNC_MOVN : ALUControl <= MOVN;
                    FUNC_MULT : ALUControl <= MULT;
                    FUNC_MULTU: ALUControl <= MULTU;
                    FUNC_MTHI : ALUControl <= MTHI;
                    FUNC_MTLO : ALUControl <= MTLO;
                    FUNC_MFHI : ALUControl <= MFHI;
                    FUNC_MFLO : ALUControl <= MFLO;
                    default   : ALUControl <= 6'd0;
                endcase
            end
            
            ALUOP_ADDIU: ALUControl <= ADDU;
            ALUOP_ADDI : ALUControl <= ADD;
            
            ALUOP_MUL: begin
                case (Funct)
                    FUNC_MUL : ALUControl <= MUL;
                    FUNC_MADD: ALUControl <= MADD;
                    FUNC_MSUB: ALUControl <= MSUB;
                endcase
            end
            
            ALUOP_LUI  : ALUControl <= LUI;
            ALUOP_BLTZ : ALUControl <= BLTZ;
            ALUOP_BGEZ : ALUControl <= BGEZ;
            ALUOP_BEQ  : ALUControl <= BEQ;
            ALUOP_BNE  : ALUControl <= BNE;
            ALUOP_BGTZ : ALUControl <= BGTZ;
            ALUOP_BLEZ : ALUControl <= BLEZ;
            ALUOP_JUMP : ALUControl <= JUMP;           
            ALUOP_ANDI : ALUControl <= AND;
            ALUOP_ORI  : ALUControl <= OR;
            ALUOP_XORI : ALUControl <= XOR;                    
            ALUOP_SEB  : ALUControl <= SEB;
            ALUOP_SEH  : ALUControl <= SEH;
            ALUOP_SLTI : ALUControl <= SLT;
            ALUOP_SLTIU: ALUControl <= SLTU;
            ALUOP_SRL  : ALUControl <= SRL;
            ALUOP_SRLV : ALUControl <= SRLV;
            ALUOP_ROTR : ALUControl <= ROTR;
            
            ALUOP_LA   : ALUControl <= LA;
            
            ALUOP_EXI  : begin
                case (Funct) 
                    FUNC_EH  : ALUControl <= EH;
                    FUNC_IH  : ALUControl <= IH;
                    FUNC_DH  : ALUControl <= DH;
                    FUNC_EB  : ALUControl <= EB;
                    FUNC_IB  : ALUControl <= IB;
                    FUNC_ABS : ALUControl <= ABS;
                endcase
            end
            
            default    : ALUControl <= 6'd0;
            
        endcase
    end
endmodule