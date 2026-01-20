`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  n/a
// Engineer: Kirby Burke Jr.
// 
// Create Date: 02/24/2024 12:10:59 PM
// Design Name: Immediate Generator
// Module Name: ImmGen
// Project Name: 32-Bit RISC-V Single-Cycle Processor
// Target Devices: Digilent Cmod A7-35T(xc7z35tcpg236-1)
// Tool Versions: Vivado v2023.2 (64-bit)
// Description: Outputs immediate values requested by instruction signal.
// 
// Dependencies: Instruction input signal
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ImmGen (instr_code, imm_out);

    /** I/O Signals **/
    input [31:0] instr_code;
    output reg [31:0] imm_out;

    /** Module Behavior **/
    always @(instr_code) begin
        case (instr_code[6:0])
            7'b0000011: // I-type: Load
                imm_out = {instr_code[31] ? {20{1'b1}} : 20'b0 , 
				    instr_code[31:20]};
            
            7'b0010011: // I-type: Non-Load
                imm_out = {instr_code[31] ? {20{1'b1}} : 20'b0 , 
				    instr_code[31:20]};
            
            7'b0100011: // S-type: Store
                imm_out = {instr_code[31] ? {20{1'b1}} : 20'b0 , 
				    instr_code[31:25], instr_code[11:7]};
            
            7'b0010111: // U-type
                imm_out = {instr_code [31:12], 12'b0};
                
            default: // Default: No output
                imm_out = {32'b0};
                
        endcase
    end
endmodule // ImmGen
