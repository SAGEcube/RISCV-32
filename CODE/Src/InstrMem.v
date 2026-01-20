`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  n/a
// Engineer: Kirby Burke Jr.
// 
// Create Date: 02/24/2024 04:09:37 PM
// Design Name: Instruction Memory
// Module Name: InstrMem
// Project Name: 32-Bit RISC-V Single-Cycle Processor
// Target Devices: Digilent Cmod A7-35T(xc7z35tcpg236-1)
// Tool Versions: Vivado v2023.2 (64-bit)
// Description: Returns the instruction corresponding to the input address from
//   its list of pre-programmed instructions.
// 
// Dependencies: PC input signal
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module InstrMem(addr, instr_out);

    /** I/O Signals **/
    input [7:0] addr;
    output wire [31:0] instr_out;

    reg [31:0] memory [0:63];

    /** Instruction Codes **/
    initial begin
		memory[0]  = 32'b00000000000000000111000000110011; // and  x0,  x0, x0 = 32'h00000000
		memory[1]  = 32'b00000000000100000000000010010011; // addi x1,  x0,  1 = 32'h00000001
		memory[2]  = 32'b00000000001000000000000100010011; // addi x2,  x0,  2 = 32'h00000002
		memory[3]  = 32'b00000000001100001000000110010011; // addi x3,  x1,  3 = 32'h00000004
		memory[4]  = 32'b00000000010000001000001000010011; // addi x4,  x1,  4 = 32'h00000005
		memory[5]  = 32'b00000000010100010000001010010011; // addi x5,  x2,  5 = 32'h00000007
		memory[6]  = 32'b00000000011000010000001100010011; // addi x6,  x2,  6 = 32'h00000008
		memory[7]  = 32'b00000000011100011000001110010011; // addi x7,  x3,  7 = 32'h0000000b
		memory[8]  = 32'b00000000001000001000010000110011; // add  x8,  x1, x2 = 32'h00000003
		memory[9]  = 32'b01000000010001000000010010110011; // sub  x9,  x8, x4 = 32'hfffffffe
		memory[10] = 32'b00000000001100010111010100110011; // and  x10, x2, x3 = 32'h00000000
		memory[11] = 32'b00000000010000011110010110110011; // or   x11, x3, x4 = 32'h00000005
		memory[12] = 32'b00000000010000011010011000110011; // slt  x12, x3, x4 = 32'h00000001
		memory[13] = 32'b00000000011100110100011010110011; // nor  x13, x6, x7 = 32'hfffffff4
		memory[14] = 32'b01001101001101001111011100010011; // andi x14, x9,  4d3 = 32'h000004d2
		memory[15] = 32'b10001101001101011110011110010011; // ori  x15, x11, 8d3 = 32'hfffff8d7
		memory[16] = 32'b01001101001001101010100000010011; // slt  x16, x13, 4d2 = 32'h00000001
		memory[17] = 32'b01001101001001000100100010010011; // nori x17,  x8, 4d2 = 32'hfffffb2c
		memory[18] = 32'b00000010101100000010100000100011; // sw   x11, 48(x0) = 32'h00000030
		memory[19] = 32'b00000011000000000010011000000011; // lw   x12, 48(x0) = 32'h00000030, x12 = 32'h00000005
    end

    assign instr_out = memory[addr[7:2]]; // addr bits 0 and 1 not used in memory index value

endmodule // InsrtMem
