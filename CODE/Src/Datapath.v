`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  n/a
// Engineer: Kirby Burke Jr.
// 
// Create Date: 03/08/2024 04:41:51 PM
// Design Name: Datapath
// Module Name: Datapath
// Project Name: 32-Bit RISC-V Single-Cycle Processor
// Target Devices: Digilent Cmod A7-35T(xc7z35tcpg236-1)
// Tool Versions: Vivado v2023.2 (64-bit)
// Description: Encapsulates all Datapath submodules that compute and pass results
//     based on input and control signals.
// 
// Dependencies: 
//     Submodules: ALU, DataMem, FlipFlop, HalfAdder, ImmGen, InstrMem,
//         Mux2_1 (2 instances), and RegFile
//     Input Signals: Clock, Reset, Reg_Write, ALU_Src, ALU_CC, Mem_Read,
//         Mem_Write, and Mem_to_Reg
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Datapath #(
    /** Macros for signal bit counts **/
    parameter PC_W = 8,      // PC width
    parameter INSTR_W = 32,  // Instruction width
    parameter DATA_W = 32,   // Data width
    parameter DM_ADDR_W = 9, // DataMem width
    parameter ALU_CC_W = 4   // ALU_CC width
    )(
	
    /** I/O Signals **/
    input                Clock,      // to FlipFlop and RegFile
    input                Reset,      // to FlipFlop and RegFile
    input                Reg_Write,  // to RegFile
    input                ALU_Src,    // to Mux_EX
    input [ALU_CC_W-1:0] ALU_CC,     // to ALU
    input                Mem_Read,   // to DataMem
    input                Mem_Write,  // to DataMem
    input                Mem_to_Reg, // to Mux_WB
        
    output        [2:0] Funct3,         // from InstrMem
    output        [6:0] Funct7,         // from InstrMem
    output        [6:0] Opcode,         // from InstrMem
    output [DATA_W-1:0] Datapath_Result // from ALU
    );
 
    /** Submodule Signals **/
    wire    [PC_W-1:0] PC;              // FlipFlop to InstMem and HalfAdder
    wire    [PC_W-1:0] PC_Next;         // HalfAdder to FlipFlop
    wire [INSTR_W-1:0] Instruction;     // InstMem to ImmGen and RegFile
    wire  [DATA_W-1:0] Ext_Imm;         // ImmGen to Mux_EX
    wire  [DATA_W-1:0] Reg1;            // RegFile to ALU
    wire  [DATA_W-1:0] Reg2;            // RegFile to Mux_EX and DataMem
    wire  [DATA_W-1:0] Src_B;           // Mux_EX to ALU
    wire  [DATA_W-1:0] ALU_Result;      // ALU to DataMem and Mux_WB
    wire  [DATA_W-1:0] DataMem_Read;    // DataMem to Mux_WB
    wire  [DATA_W-1:0] Write_Back_Data; // Mux_WB to RegFile
    
    /** Submodule Instances and Port Mapping **/
    ALU ALU_inst (
        .alu_sel(ALU_CC),
        .a_in(Reg1),
        .b_in(Src_B),
        .alu_out(ALU_Result),
        .carry_out(),
        .zero(),
        .overflow()
    );

    DataMem DataMem_inst (
        .mem_read(Mem_Read),
        .mem_write(Mem_Write),
        .addr(ALU_Result[DM_ADDR_W-1:0]),
        .write_data(Reg2),
        .read_data(DataMem_Read)
    );
        
    FlipFlop FlipFlop_inst (
        .clk(Clock),
        .reset(Reset),
        .d(PC_Next),
        .q(PC)
    );

    HalfAdder HalfAdder_inst(
        .a(PC),
        .b(8'd4), // Shift PC by 8 bits
        .c_out(),
        .sum(PC_Next)
    );

    ImmGen ImmGen_inst (
        .instr_code(Instruction),
        .imm_out(Ext_Imm)
    );
                
    InstrMem InstrMem_inst (
        .addr(PC),
        .instr_out(Instruction)
    );

    /* 2:1 Multiplexer for Execution stage */
    Mux2_1 Mux_EX (
        .s(ALU_Src),
        .d0(Reg2),
        .d1(Ext_Imm),
        .y(Src_B)
    ); 

    /* 2:1 Multiplexer for Write Back stage */
    Mux2_1 Mux_WB (
        .s(Mem_to_Reg),
        .d0(ALU_Result),
        .d1(DataMem_Read),
        .y(Write_Back_Data)
    );    
        
    RegFile RegFile_inst (
        .clk(Clock),     
        .reset(Reset),
        .rg_wrt_en(Reg_Write),
        .rg_wrt_addr(Instruction[11:7]),
        .rg_rd_addr1(Instruction[19:15]),
        .rg_rd_addr2(Instruction[24:20]),
        .rg_wrt_data(Write_Back_Data),
        .rg_rd_data1(Reg1),
        .rg_rd_data2(Reg2)
    );

    /** Assign Output Signals **/
    assign Datapath_Result = ALU_Result;
    assign Opcode = Instruction[6:0];
    assign Funct3 = Instruction[14:12];
    assign Funct7 = Instruction[31:25];

endmodule // Datapath