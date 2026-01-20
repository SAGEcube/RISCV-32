`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  n/a
// Engineer: Kirby Burke Jr.
// 
// Create Date: 02/24/2024 04:09:14 PM
// Design Name: Register File
// Module Name: RegFile
// Project Name: 32-Bit RISC-V Single-Cycle Processor
// Target Devices: Digilent Cmod A7-35T(xc7z35tcpg236-1)
// Tool Versions: Vivado v2023.2 (64-bit)
// Description: Manages the reading and writing of values from/to a specific
//   register address.
// 
// Dependencies:
//   Input Signals: Multiple subsets of the Instruction signal (see I/O Signal
//     comments below for details) and Write_Back_Data. 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RegFile(clk, reset, rg_wrt_en,
    rg_rd_addr1, rg_rd_addr2, rg_wrt_addr, rg_wrt_data,
    rg_rd_data1, rg_rd_data2);

    /** I/O Signals **/
    input clk, reset, rg_wrt_en;
    input [4:0] rg_wrt_addr; // Instruction [11:7]
    input [4:0] rg_rd_addr1; // Instruction [19:15]
    input [4:0] rg_rd_addr2; // Instruction [24:20]
    input [31:0] rg_wrt_data;
    output reg [31:0] rg_rd_data1;
    output reg [31:0] rg_rd_data2;

    integer i;
    reg [31:0] register_file [0:31];
    
    /** Module Behavior **/
    
    /* Reset */
    always @(posedge clk or posedge reset) begin 
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                register_file[i] <= 0;
            end
        end

    /* Write data */
        else if (rg_wrt_en) begin
            register_file[rg_wrt_addr] <= rg_wrt_data;
        end
    end    
    
    /* Read data */
    always @(*) begin
        rg_rd_data1 <= register_file[rg_rd_addr1];
        rg_rd_data2 <= register_file[rg_rd_addr2];
    end
endmodule // RegFile