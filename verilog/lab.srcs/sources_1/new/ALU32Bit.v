`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : ALU32Bit.v
// Description  : 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS
// ALUControl   : N-Bit input control bits to select an ALU operation.
// A            : 32-Bit input port A.
// B            : 32-Bit input port B.
//
// OUTPUTS
// ALUResult    : 32-Bit ALU result output.
// ZERO         : 1-Bit output flag. 
//
// FUNCTIONALITY
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
// The 'ALUResult' will output the corresponding result of the operation 
// based on the 32-Bit inputs, 'A', and 'B'. 
// The 'Zero' flag is high when 'ALUResult' is '0'. 
// The 'ALUControl' signal should determine the function of the ALU 
// You need to determine the bitwidth of the ALUControl signal based on the number of 
// operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, Shamt, ALUResult, Zero, RegWrite, RegWrite_Out, HiLoReg, HiLoNewData, HiLoEnable);

    input        RegWrite;
    input [5:0]  ALUControl;        // control bits for ALU operation
    input [4:0]  Shamt;             // Shift amount
	input [31:0] A, B;	            // inputs
	
	input [63:0] HiLoReg;	        // Current HiLo Data
	
	output reg HiLoEnable;          // Enable HiLo Writing
	output reg [63:0] HiLoNewData;  // Data to be written to the HiLo Register

	output reg [31:0] ALUResult;	// result
	output reg Zero;	            // Zero=1 if ALUResult == 0

    output reg RegWrite_Out;
    
    reg RegWriteClear;
    reg [31:0] temp;

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
                     ROTR   = 6'd27,   // ROTR
                     SRA    = 6'd28,   // SRA 
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
        HiLoEnable    <= 1'b0;
        HiLoNewData   <= 64'd0;
        ALUResult     <= 32'd0;
        Zero          <= 1'b0;
        RegWriteClear <= 1'b0;
        temp          <= 32'd0;
    end
    
    always @ (*) begin
    
        RegWriteClear = 0;
    
        Zero       <= 0;
        HiLoEnable <= 0;
    
        case (ALUControl)
        
            //------------
            // Arithmetic
            //------------
            
            ADD  : ALUResult <= $signed(A) + $signed(B);     // add
            ADDU : ALUResult <= A + B;                       // add unsigned
            SUB  : ALUResult <= A - B;                       // sub
            MUL  : ALUResult <= A * B;                       // mul
            
            MULT : begin                                    // mult
                HiLoNewData <= $signed(A) * $signed(B);
                HiLoEnable  <= 1;
                ALUResult   <= 0;
            end
            
            MULTU: begin                                    // multu
                HiLoNewData <= A * B;
                HiLoEnable  <= 1;
                ALUResult   <= 0;
            end
            
            MADD : begin                                    // madd
                HiLoNewData <= $signed(HiLoReg) + $signed(($signed(A) * $signed(B)));
                HiLoEnable  <= 1;
                ALUResult   <= 0;
            end
            
            MSUB : begin                                    // msub
                HiLoNewData <= $signed(HiLoReg) - $signed(($signed(A) * $signed(B)));
                HiLoEnable  <= 1;
                ALUResult   <= 0;
            end
            
            //------------
            // Branch
            //------------
            
            BGEZ : ALUResult <= $signed(A) >= 0;             // bgez
            BEQ  : ALUResult <= $signed(A) == $signed(B);    // beq
            BNE  : ALUResult <= $signed(A) != $signed(B);    // bne
            BGTZ : ALUResult <= $signed(A) > 0;              // bgtz
            BLEZ : ALUResult <= $signed(A) <= 0;             // blez
            BLTZ : ALUResult <= $signed(A) < 0;              // bltz
            JUMP : ALUResult <= 0;                           // j
            
            //------------
            // Data
            //------------
            
            LUI  : ALUResult <= B << 16;    // lui
            
            //------------
            // Logical
            //------------
            
            AND  : ALUResult <= A & B;                      // and   
            OR   : ALUResult <= A | B;                      // or
            NOR  : ALUResult <= ~(A | B);                   // nor 
            XOR  : ALUResult <= A ^ B;                      // xor
            
            SEH  : begin                                    // seh 
                if (B[15] == 0) ALUResult <= {16'b0, B[15:0]};
                else ALUResult <= {16'hffff, B[15:0]};
            end

            SLL  : ALUResult <= B << Shamt;                             // sll
            SLLV : ALUResult <= B << A;                                 // sllv
            SRL  : ALUResult <= B >> Shamt;                             // srl
            SRLV : ALUResult <= B >> A;                                 // srlv
            ROTR : ALUResult <= ((B >> Shamt) | (B << (32 - Shamt)));   // rotr
            ROTRV: ALUResult <= ((B >> A) | (B << (32 - A)));           // rotrv
            SRA  : ALUResult[31:0] <= B >>> Shamt;                      // sra
            SRAV : ALUResult <= B >>> A;                                // srav
            
            MOVN : begin
                if (B != 0) ALUResult <= A;                          // movn
                else begin
                    ALUResult <= 0;
                    RegWriteClear = 1;
                end
            end
            
            MOVZ : begin
                if (B == 0) ALUResult <= A;                          // movz
                else begin
                    ALUResult <= 0;
                    RegWriteClear = 1;
                end
            end
            
            SEB  : begin                                    // seb
                if (B[7] == 0) ALUResult <= {24'b0, B[7:0]};
                else ALUResult <= {24'hFFFFFF, B[7:0]};                     
            end
            
            SLT  : ALUResult <= ($signed(A) < $signed(B));  // slt
            SLTU : ALUResult <= (A < B) ;                   // sltu
            
            MTHI : begin
                HiLoNewData <= {A, HiLoReg[31:0]};   // mthi
                HiLoEnable  <= 1;
                ALUResult   <= 0;
            end
            
            MTLO : begin
                HiLoNewData <= {HiLoReg[63:32], A};  // mtlo
                HiLoEnable  <= 1;
                ALUResult   <= 0;
            end
            
            MFHI : ALUResult <= HiLoReg[63:32];      // mfhi
            MFLO : ALUResult <= HiLoReg[31:0];       // mflo
          
            EH : begin
                case(Shamt)
                    5'b00000 : ALUResult <= A[15:00];  
                    5'b00001 : ALUResult <= A[31:16];  
                endcase
            end
            
            IH : begin
                case(Shamt)
                    5'b00000 : ALUResult <= A + 1;  
                    5'b00001 : begin
                        temp = {16'h00, A[31:16]}; 
                        temp = temp + 1;
                        ALUResult <= {temp[15:00], A[15:00]}; 
                    end  
                endcase
            end
            
            DH : begin
                case(Shamt)
                    5'b00000 : begin
                        temp = {16'h00, A[15:00]}; 
                        temp = temp - 1;
                        ALUResult <= {A[31:16], temp[15:00]}; 
                    end
                    5'b00001 : begin
                        temp = {16'h00, A[31:16]}; 
                        temp = temp - 1;
                        ALUResult <= {temp[15:00], A[15:00]}; 
                    end  
                endcase
            end
            
            EB : begin
                case(Shamt)
                    5'b00000 : ALUResult <= A[07:00];  
                    5'b00001 : ALUResult <= A[15:08];  
                    5'b00010 : ALUResult <= A[23:16];  
                    5'b00011 : ALUResult <= A[31:24];  
                endcase
            end
            
            IB : begin
                case(Shamt)
                    5'b00000 : ALUResult <= A + 1;  
  
                    5'b00001 : begin
                        temp = {24'h000, A[15:08]}; 
                        temp = temp + 1;
                        ALUResult <= {A[31:16], temp[07:00], A[07:00]}; 
                    end 
                      
                    5'b00010 : begin
                        temp = {24'h000, A[23:16]}; 
                        temp = temp + 1;
                        ALUResult <= {A[31:24], temp[07:00], A[15:00]}; 
                    end 
                     
                    5'b00011 : begin
                        temp = {24'h000, A[31:24]}; 
                        temp = temp + 1;
                        ALUResult <= {temp[07:00], A[23:00]}; 
                    end 
                      
                endcase
            end
          
            ABS : ALUResult <= ($signed(A) < 0) ? -A : A;
          
            default: begin
                HiLoEnable <= 0;
                ALUResult  <= 0;
            end
          
            LA : ALUResult <= {8'H0, B[23:00]};
          
        endcase
        
        if (RegWriteClear == 1) begin
            RegWrite_Out  <= 1'b0;
        end
        else 
            RegWrite_Out <= RegWrite;
        
        if (ALUResult == 0) 
            Zero <= 1;

    end

endmodule

