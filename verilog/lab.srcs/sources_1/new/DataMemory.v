`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : DataMemory.v
// Description  : 32-Bit wide data memory.
//
// INPUTS
// Address      : 32-Bit address input port.
// WriteData    : 32-Bit input port.
// Clk          : 1-Bit Input clock signal.
// MemWrite     : 1-Bit control signal for memory write.
// MemRead      : 1-Bit control signal for memory read.
//
// OUTPUTS
// ReadData     : 32-Bit registered output port.
//
// FUNCTIONALITY
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clock, MemWrite, MemRead, ReadData, ByteSig); 

    input [31:0] Address;       // Input Address 
    input [31:0] WriteData;     // Data that needs to be written into the address 
    input Clock;
    input MemWrite;             // Control signal for memory write 
    input MemRead;              // Control signal for memory read 
    input [1:0] ByteSig;

    output reg[31:0] ReadData;  // Contents of memory location at Address
    
    reg [31:0] memory [0:13600];    // Reminder: Update stack pointer
    
    // ByteSig
    // | 00 |            Full            | lw/sw |
    // | 01 |            Half            | sh/lh |
    // | 10 |            Byte            | sb/lb |
    
    initial begin
        $readmemh("Data_memory.mem", memory);    // Provided public test code
    end
    
    // store
    always @ (posedge Clock) begin
    
        if (MemWrite == 1'b1)
    
            // Word - sw
            if (ByteSig == 2'b00) memory[Address[31:2]] <= WriteData;
            
            // Half Word - sh
            else if (ByteSig == 2'b01) begin 
                if      (Address[1:0] == 2'b00) memory[Address[31:2]][15:00] <= WriteData; // Half 0
                else if (Address[1:0] == 2'b10) memory[Address[31:2]][31:16] <= WriteData; // Half 1
            end
            
            // Byte - sb
            else if (ByteSig == 2'b10) begin 
                if      (Address[1:0] == 2'b00) memory[Address[31:2]][07:00] <= WriteData; // Byte 0
                else if (Address[1:0] == 2'b01) memory[Address[31:2]][15:08] <= WriteData; // Byte 1
                else if (Address[1:0] == 2'b10) memory[Address[31:2]][23:16] <= WriteData; // Byte 2
                else if (Address[1:0] == 2'b11) memory[Address[31:2]][31:24] <= WriteData; // Byte 3
            end
            
    end 
    
    // load
    always @ (*) begin
     
        ReadData <= 32'b0;
     
        if (MemRead == 1'b1)
        
            // Word - lw
            if (ByteSig == 2'b00) ReadData <= memory[Address[31:2]];
            
            // Half Word - lh
            else if (ByteSig == 2'b01) begin 
                if      (Address[1:0] == 2'b00) 
                    ReadData <= {{16{memory[Address[31:2]][15]}}, memory[Address[31:2]][15:00]}; // Half 0, Sign Extended
                else if (Address[1:0] == 2'b10) 
                    ReadData <= memory[Address[31:2]][31:16]; // Half 1
            end
            
            // Byte - lb
            else if (ByteSig == 2'b10) begin 
                if      (Address[1:0] == 2'b00) 
                    ReadData <= {{24{memory[Address[31:2]][07]}}, memory[Address[31:2]][07:00]}; // Byte 0, Sign Extended
                else if (Address[1:0] == 2'b01) 
                    ReadData <= {{16{memory[Address[31:2]][15]}}, memory[Address[31:2]][15:08]}; // Byte 1, Sign Extended
                else if (Address[1:0] == 2'b10) 
                    ReadData <= {{8{memory[Address[31:2]][23]}},  memory[Address[31:2]][23:16]}; // Byte 2, Sign Extended
                else if (Address[1:0] == 2'b11) 
                    ReadData <= memory[Address[31:2]][31:24]; // Byte 3
            end
            
            else begin
                ReadData <= 32'b0;
            end
            
    end
   
endmodule
