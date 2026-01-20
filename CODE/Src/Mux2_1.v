`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  n/a
// Engineer: Kirby Burke Jr.
// 
// Create Date: 01/23/2024 02:45:55 PM
// Design Name: 2-to-1 Multiplexer
// Module Name: Mux2_1
// Project Name: 32-Bit RISC-V Single-Cycle Processor
// Target Devices: Digilent Cmod A7-35T(xc7z35tcpg236-1)
// Tool Versions: Vivado v2023.2 (64-bit)
// Description: Selects one of two outputs based on its control signal. The
//   DataPath module contains two instances of the Mux2_1 module. 
// 
// Dependencies:
//     Instance #1: ALU_Src, Reg2, and Ext_Imm input signals
//     Instance #2: Mem_to_Reg, ALU_Result, and DataMem_Read input signals
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux2_1(s, d0, d1, y);

    /** I/O Signals **/
    input         s;
    input  [31:0] d0;
    input  [31:0] d1;
	
    output [31:0] y;
    
    /** Module Behavior **/
    assign y = s ? d1 : d0;

endmodule // Mux2_1