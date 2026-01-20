
# RISCV-32
# 32-bit Sequential RISC-V Processor (Vivado)

## 📌 Overview
This repository contains the **design and simulation resources** for a **32-bit sequential RISC-V processor**, developed using **Xilinx Vivado**.  
The processor executes instructions sequentially through a classic **five-stage RISC architecture**, completing all stages for one instruction before starting the next.

High-level design concepts, development notes, and architectural explanations are documented separately on the **RISC-V Single-Cycle Processor** portfolio page.

---

## ✨ Features

### 🔁 Sequential Processing
Each instruction is processed completely before the next instruction begins execution, ensuring deterministic and easy-to-debug behavior.

### 🧠 Five-Stage RISC Architecture
The processor implements the following five stages:

1. **Instruction Fetch (IF)**  
   Fetches the instruction from instruction memory and updates the program counter.

2. **Instruction Decode (ID)**  
   Decodes the instruction, reads source registers, and generates control signals.

3. **Execution (EX)**  
   Performs arithmetic and logical operations and computes memory addresses.

4. **Memory Access (MEM)**  
   Reads from or writes to data memory for load/store instructions.

5. **Write Back (WB)**  
   Writes the final result back to the register file.

---

## 🧾 Supported RISC-V Instructions

The processor supports a subset of the RISC-V ISA.  
All arithmetic operations are **signed**, and logical operations are **bitwise**.

### 🟦 R-Type Instructions
- `add`
- `sub`
- `and`
- `or`
- `nor` *(custom instruction)*
- `seq` *(set if equal – custom instruction)*
- `slt` *(set less than)*

> **Note:**  
> `nor` and `seq` are custom extensions and are not part of the standard RISC-V ISA, but they remain ISA-compatible.

---


