`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : InstructionMemory.v
// Description  : 32-Bit wide instruction memory.
//
// INPUTS
// Address      : 32-Bit address input port.
//
// OUTPUTS
// Instruction  : 32-Bit instruction output port.
//
// FUNCTIONALITY
//
////////////////////////////////////////////////////////////////////////////////


module InstructionMemory(Address, Instruction, TargetOffset, Branch);

    input [31:0] Address;
    
    output reg [31:0] Instruction;
    output reg [31:0] TargetOffset;
    output reg Branch;

    reg [31:0] memory [0:512];

    initial begin
        $readmemh("Instruction_memory.mem", memory);    // Provided public test code
    end

    always @ * begin
        Instruction = memory[Address[11:2]];
        
        // Branch Instruction
        if (Instruction[31:26] == 6'b000100 || Instruction[31:26] == 6'b000001 ||
            Instruction[31:26] == 6'b000111 || Instruction[31:26] == 6'b000110 ||
            Instruction[31:26] == 6'b000101) begin
           
            Branch <= 1'b1;
            if (Instruction[15] == 1) 
                TargetOffset <= {16'hFFFF, Instruction[15:0]};
            else  
                TargetOffset <= {16'h0000, Instruction[15:0]};
            
        end
        else begin
            Branch <= 1'b0;
            TargetOffset <= 32'd0;
        end
        
    end 

endmodule
