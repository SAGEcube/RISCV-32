`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  n/a
// Engineer: Kirby Burke Jr.
// 
// Create Date: 08/22/2024 02:03:52 PM
// Design Name: Controller
// Module Name: Controller
// Project Name: 32-Bit RISC-V Single-Cycle Processor
// Target Devices: Digilent Cmod A7-35T(xc7z35tcpg236-1)
// Tool Versions: Vivado v2023.2 (64-bit)
// Description: Processees opcode and sends control codes to DataPath submodules
//     RegFile, Datamem, and both Multiplexers.
// 
// Dependencies: Opcode input signal
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Controller(ALU_Op, ALU_Src, Mem_Read, Mem_to_Reg, Mem_Write, Opcode, Reg_Write);

    /** I/O Signals **/
    input [6:0] Opcode;
    output reg [1:0] ALU_Op;
    output reg ALU_Src;
    output reg Mem_Read;
    output reg Mem_to_Reg;
    output reg Mem_Write;
    output reg Reg_Write;

    /** Module Behavior **/
    always @(*) begin
        case (Opcode)
            7'b0110011: begin // R-Type
                ALU_Op = 2'b10;
                ALU_Src = 0;
                Mem_Read = 0;            
                Mem_to_Reg = 0;
                Mem_Write = 0;
                Reg_Write = 1;            
            end
          
            7'b0010011: begin // I-Type, except LW
                ALU_Op = 2'b00;
                ALU_Src = 1;
                Mem_Read = 0;            
                Mem_to_Reg = 0;
                Mem_Write = 0;
                Reg_Write = 1;            
            end
          
            7'b0000011: begin // LW
                ALU_Op = 2'b01; 
                ALU_Src = 1;
                Mem_Read = 1;            
                Mem_to_Reg = 1;
                Mem_Write = 0;
                Reg_Write = 1;            
            end
          
            7'b0100011: begin // SW
                ALU_Op = 2'b01;     
                ALU_Src = 1;
                Mem_Read = 0;            
                Mem_to_Reg = 0; 
                Mem_Write = 1;
                Reg_Write = 0;            
            end
  
        endcase
    end
endmodule // Controller