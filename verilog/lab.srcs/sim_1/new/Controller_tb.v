`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : Controller_tb.v
// Description  : Controller testbench
//
// INPUTS
//
// OUTPUTS
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////

module Controller_tb();

    reg [31:0] Instruction;
    
    wire        JumpMuxSel, JumpControl, JumpFlush;
    wire [2:0]  BranchComp;
    
    // Execute
    wire       ALUBMux_Control;
    wire [1:0] RegDst_Control;
    wire [5:0] ALUOp_Control;
    
    // Memory
    wire MemWrite_Control, MemRead_Control;
    wire [1:0] ByteSig_Control;   
    
    // Write Back
    wire       RegWrite_Control;
    wire [1:0] MemToReg_Control;

    Controller ControllerTest (.Instruction(Instruction),
                               .ALUBMux(ALUBMux_Control), .RegDst(RegDst_Control), 
                               .ALUOp(ALUOp_Control), .MemWrite(MemWrite_Control), 
                               .MemRead(MemRead_Control), .ByteSig(ByteSig_Control),
                               .RegWrite(RegWrite_Control), .MemToReg(MemToReg_Control),  
                               .JumpMuxSel(JumpMuxSel), 
                               .JumpControl(JumpControl), 
                               .BranchComp(BranchComp),
                               .Flush_IF(JumpFlush));

    initial begin

        #100 Instruction <= 32'b00000000000000000000000000000000;   // nop    -> Control Signal : 0 

        #100 Instruction <= 32'b00000000000000000000000000100000;   // add    -> Control Signal : 518         
        #100 Instruction <= 32'b00100000000000000000000000000000;   // addi   -> Control Signal : 10246       
        #100 Instruction <= 32'b00100100000000000000000000000000;   // addiu  -> Control Signal : 6150       
        #100 Instruction <= 32'b00000000000000000000000000100001;   // addu   -> Control Signal : 518          
        #100 Instruction <= 32'b01110000000000000000000000000000;   // madd   -> Control Signal : 12806          
        #100 Instruction <= 32'b01110000000000000000000000000100;   // msub   -> Control Signal : 12806          
        #100 Instruction <= 32'b01110000000000000000000000000010;   // mul    -> Control Signal : 12806         
        #100 Instruction <= 32'b00000000000000000000000000011000;   // mult   -> Control Signal : 518          
        #100 Instruction <= 32'b00000000000000000000000000011001;   // multu  -> Control Signal : 518          
        #100 Instruction <= 32'b00000000000000000000000000100010;   // sub    -> Control Signal : 518         
                                                                               
        #100 Instruction <= 32'b00010000000000000000000000000000;   // beq    -> Control Signal : 24576       
        #100 Instruction <= 32'b00000100000000010000000000000000;   // bgez   -> Control Signal : 40960       
        #100 Instruction <= 32'b00011100000000000000000000000000;   // bgtz   -> Control Signal : 32768      
        #100 Instruction <= 32'b00011000000000000000000000000000;   // blez   -> Control Signal : 36864      
        #100 Instruction <= 32'b00000100000000000000000000000000;   // bltz   -> Control Signal : 20480     
        #100 Instruction <= 32'b00010100000000000000000000000000;   // bne    -> Control Signal : 28672    
                                                                                
        #100 Instruction <= 32'b00001000000000000000000000000000;   // j      -> Control Signal : 45056   
        #100 Instruction <= 32'b00001100000000000000000000000000;   // jal    -> Control Signal : 46085      
        #100 Instruction <= 32'b00000000000000000000000000001000;   // jr     -> Control Signal : 45056     
                                                                                
        #100 Instruction <= 32'b10000000000000000000000000000000;   // lb     -> Control Signal : 10532     
        #100 Instruction <= 32'b10000100000000000000000000000000;   // lh     -> Control Signal : 10404   
        #100 Instruction <= 32'b00111100000000000000000000000000;   // lui    -> Control Signal : 18438     
        #100 Instruction <= 32'b10001100000000000000000000000000;   // lw     -> Control Signal : 10276    
        #100 Instruction <= 32'b10100000000000000000000000000000;   // sb     -> Control Signal : 10560  
        #100 Instruction <= 32'b10100100000000000000000000000000;   // sh     -> Control Signal : 10246   
        #100 Instruction <= 32'b10101100000000000000000000000000;   // sw     -> Control Signal : 10304   
                                                                               
        #100 Instruction <= 32'b00000000000000000000000000100100;   // and    -> Control Signal : 518     
        #100 Instruction <= 32'b00110000000000000000000000000000;   // andi   -> Control Signal : 51206       
        #100 Instruction <= 32'b00000000000000000000000000001011;   // movn   -> Control Signal : 518      
        #100 Instruction <= 32'b00000000000000000000000000001010;   // movz   -> Control Signal : 518      
        #100 Instruction <= 32'b00000000000000000000000000100111;   // nor    -> Control Signal : 518     
        #100 Instruction <= 32'b00000000000000000000000000100101;   // or     -> Control Signal : 518    
        #100 Instruction <= 32'b00110100000000000000000000000000;   // ori    -> Control Signal : 55302     
        #100 Instruction <= 32'b00000000001000000000000000000010;   // rotr   -> Control Signal : 518       
        #100 Instruction <= 32'b00000000000000000000000001000110;   // rotrv  -> Control Signal : 518        
        #100 Instruction <= 32'b01111100000000000000010000100000;   // seb    -> Control Signal : 518      
        #100 Instruction <= 32'b01111100000000000000011000100000;   // seh    -> Control Signal : 86534      
        #100 Instruction <= 32'b00000000000000000000000000000000;   // sll    -> Control Signal : 2566     
        #100 Instruction <= 32'b00000000000000000000000000000100;   // sllv   -> Control Signal : 518      
        #100 Instruction <= 32'b00000000000000000000000000101010;   // slt    -> Control Signal : 518     
        #100 Instruction <= 32'b00101000000000000000000000000000;   // slti   -> Control Signal : 67590       
        #100 Instruction <= 32'b00101100000000000000000000000000;   // sltiu  -> Control Signal : 71686        
        #100 Instruction <= 32'b00000000000000000000000000101011;   // sltu   -> Control Signal : 518      
        #100 Instruction <= 32'b00000000000000000000000000000011;   // sra    -> Control Signal : 518     
        #100 Instruction <= 32'b00000000000000000000000000000111;   // srav   -> Control Signal : 518      
        #100 Instruction <= 32'b00000000000000000000000000000010;   // srl    -> Control Signal : 76294      
        #100 Instruction <= 32'b00000000000000000000000000000110;   // srlv   -> Control Signal : 518       
        #100 Instruction <= 32'b00000000000000000000000000100110;   // xor    -> Control Signal : 518     
        #100 Instruction <= 32'b00111000000000000000000000000000;   // xori   -> Control Signal : 59398       
                                                                                
        #100 Instruction <= 32'b00000000000000000000000000010000;   // mfhi   -> Control Signal : 518      
        #100 Instruction <= 32'b00000000000000000000000000010010;   // mflo   -> Control Signal : 518      
        #100 Instruction <= 32'b00000000000000000000000000010001;   // mthi   -> Control Signal : 518      
        #100 Instruction <= 32'b00000000000000000000000000010011;   // mtlo   -> Control Signal : 518

    end

endmodule
