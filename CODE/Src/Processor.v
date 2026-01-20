`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  n/a
// Engineer: Kirby Burke Jr.
// 
// Create Date: 03/16/2024 01:40:03 AM
// Design Name: Processor
// Module Name: Processor
// Project Name: 32-Bit RISC-V Single-Cycle Processor
// Target Devices: Digilent Cmod A7-35T(xc7z35tcpg236-1)
// Tool Versions: Vivado v2023.2 (64-bit)
// Description: Project parent container that simulates a single-cycle RISC-V
//   processor, producing a "result" value based on instruction computations.
// 
// Dependencies:
//   - Submodules: ALUController, Controller, and Datapath
//   - Input Signals: clock and reset
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Processor(clock, reset, result);

    /** I/O Signals **/
    input         clock;
    input         reset;
    output [31:0] result;

    /** Submodule Signals **/
    wire [1:0] alu_op;
    wire       alu_src;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire       mem_read;
    wire       mem_to_reg;
    wire       mem_write;
    wire [6:0] opcode;
    wire [3:0] operation;
    wire       reg_write;

    /** Port Mapping **/
    ALUController ALUController_inst(
        .ALU_Op(alu_op),
        .Funct3(funct3),
        .Funct7(funct7),
        .Operation(operation)
    );

    Controller Controller_inst(
        .Opcode(opcode),
        .ALU_Op(alu_op),
        .Reg_Write(reg_write),
        .ALU_Src(alu_src),
        .Mem_Read(mem_read),
        .Mem_Write(mem_write),
        .Mem_to_Reg(mem_to_reg)
    );

    Datapath Datapath_inst(
        .Clock(clock),
        .Reset(reset),    
        .Reg_Write(reg_write),
        .Mem_to_Reg(mem_to_reg),
        .ALU_Src(alu_src),
        .Mem_Write(mem_write),
        .Mem_Read(mem_read),       
        .ALU_CC(operation),
        .Opcode(opcode),
        .Funct7(funct7),
        .Funct3(funct3),
        .Datapath_Result(result)
    );

endmodule // Processor