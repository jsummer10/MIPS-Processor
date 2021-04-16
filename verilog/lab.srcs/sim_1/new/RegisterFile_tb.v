`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module       : RegisterFile_tb.v
// Description  : Test the register_file
//
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();

    reg [4:0] ReadRegister1, ReadRegister2, WriteRegister;
    reg [31:0] WriteData;
    reg RegWrite, Clock;

    wire [31:0] ReadData1;
    wire [31:0] ReadData2;


    RegisterFile RegisterFileTest(
        .ReadRegister1(ReadRegister1), 
        .ReadRegister2(ReadRegister2), 
        .WriteRegister(WriteRegister), 
        .WriteData(WriteData), 
        .RegWrite(RegWrite), 
        .Clock(Clock), 
        .ReadData1(ReadData1), 
        .ReadData2(ReadData2)
    );

    always begin    
        Clock <= 1;
        #50;
        Clock <= 0;
        #50;
    end

    initial begin
    
        @(posedge Clock)
        
        WriteRegister <= 5'd8;
        WriteData <= 10;
        RegWrite <= 1;
        
        @(posedge Clock)
        
        WriteRegister <= 5'd9;
        WriteData <= 20;
        RegWrite <= 1;
        
        @(posedge Clock)
        
        WriteRegister <= 5'd10;
        WriteData <= 30;
        RegWrite <= 0;
        
        @(posedge Clock)
        
        ReadRegister1 <= 5'd8;
        ReadRegister2 <= 5'd9;
        RegWrite <= 0;
        
        @(posedge Clock)
        
        ReadRegister1 <= 5'd9;
        ReadRegister2 <= 5'd8;
        WriteRegister <= 5'd10;
        WriteData <= 40;
        RegWrite <= 1;
        
        @(posedge Clock)
        
        ReadRegister1 <= 5'd10;
        ReadRegister2 <= 5'd11;
        WriteRegister <= 5'd11;
        WriteData <= 60;
        RegWrite <= 1;
	
	end
    
endmodule
