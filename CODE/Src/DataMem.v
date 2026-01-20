`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  n/a
// Engineer: Kirby Burke Jr.
// 
// Create Date: 03/08/2024 03:38:43 PM
// Design Name: Data Memory
// Module Name: DataMem
// Project Name: 32-Bit RISC-V Single-Cycle Processor
// Target Devices: Digilent Cmod A7-35T(xc7z35tcpg236-1)
// Tool Versions: Vivado v2023.2 (64-bit)
// Description: Performs memory load and store operations, based on
//     control signals.
// 
// Dependencies: Mem_Read, Mem_Write, ALU_Result, and Reg2 input signals
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DataMem(mem_read, mem_write, addr, write_data, read_data);

    /** I/O Signals **/
    input mem_read;
    input mem_write;
    input [8:0] addr;
    input [31:0] write_data;
    output reg [31:0] read_data;

    reg [31:0] memory [127:0];

    /** Module Behavior **/

    /* Read data */
    always @(*) begin
        if (mem_read)
            read_data <= memory[addr[8:2]];
        else if (mem_write)
            read_data <= 32'b0;
    end

    /* Write data */
    always @(mem_write) begin
        if (mem_write)
            memory[addr[8:2]] <= write_data;
    end
        
endmodule // DataMem