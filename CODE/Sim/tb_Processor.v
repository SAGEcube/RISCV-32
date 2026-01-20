`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  n/a
// Engineer: Kirby Burke Jr.
// 
// Create Date: 03/19/2024 06:06:30 PM
// Design Name: Processor Test Bench
// Module Name: tb_Processor
// Project Name: 32-Bit RISC-V Single-Cycle Processor
// Target Devices: Digilent Cmod7 A7-35t(xc7z35tcpg236-1)
// Tool Versions: Vivado v2023.2 (64-bit)
// Description: Testing simulation for Processor module.
// 
// Dependencies: Processor module and its dependencies.
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_Processor();

  /** I/O Ports **/
  reg clk;
  reg rst;
  
  wire[31:0] result_tb;
  wire[31:0] test_value;

  /** Port Mapping **/
  Processor Processor_inst (
    .clock(clk),
    .reset(rst),
    .result(result_tb)
  );

  /** Initialize Test Values **/

  /* Set clock */
  always begin
    #10;
    clk = ~clk;
  end

  /* Apply reset signal */
  initial
    begin
      clk = 0;
      @( posedge clk );
        rst = 1;
      @( posedge clk );
        rst = 0;
    end

    integer point = 0; // Count for successful tests
 
    assign test_value = 32'h4d244893;
 
  /** Test Cases: Test each of the 20 InstrMem instruction codes **/ 
    always @(*) begin
    
        #20;
        if (result_tb == 32'h00000000) point = point + 1;
		else $display("FAIL! memory[0] = %h", result_tb);
           
        #20;
        if (result_tb == 32'h00000001) point = point + 1;
		else $display("FAIL! memory[1] = %h", result_tb);

        #20;
        if (result_tb == 32'h00000002) point = point + 1;
		else $display("FAIL! memory[2] = %h", result_tb);

        #20;
        if (result_tb == 32'h00000004) point = point + 1;
		else $display("FAIL! memory[3] = %h", result_tb);

        #20;
        if (result_tb == 32'h00000005) point = point + 1;
		else $display("FAIL! memory[4] = %h", result_tb);

        #20;
        if (result_tb == 32'h00000007) point = point + 1;
		else $display("FAIL! memory[5] = %h", result_tb);

        #20;
        if (result_tb == 32'h00000008) point = point + 1;
		else $display("FAIL! memory[6] = %h", result_tb);

        #20;
        if (result_tb == 32'h0000000b) point = point + 1;
		else $display("FAIL! memory[7] = %h", result_tb);

        #20;
        if (result_tb == 32'h00000003) point = point + 1;
		else $display("FAIL! memory[8] = %h", result_tb);
            
        #20;
        if (result_tb == 32'hfffffffe) point = point + 1;
		else $display("FAIL! memory[9] = %h", result_tb);

        #20;
        if (result_tb == 32'h00000000) point = point + 1;
		else $display("FAIL! memory[10] = %h", result_tb);

        #20;
        if (result_tb == 32'h00000005) point = point + 1;
		else $display("FAIL! memory[11] = %h", result_tb);
 
        #20;
        if (result_tb == 32'h00000001) point = point + 1;
		else $display("FAIL! memory[12] = %h", result_tb);

        #20;
        if (result_tb == 32'hfffffff4) point = point + 1;
		else $display("FAIL! memory[13] = %h", result_tb);

        #20;
        if (result_tb == 32'h000004D2) point = point + 1;
		else $display("FAIL! memory[14] = %h", result_tb);
 
        #20;
        if (result_tb == 32'hfffff8d7) point = point + 1;
		else $display("FAIL! memory[15] = %h", result_tb);
            
        #20;
        if (result_tb == 32'h00000001) point = point + 1;
		else $display("FAIL! memory[16] = %h", result_tb);

        #20;
        if (result_tb == 32'hfffffb2c) point = point + 1;
		else $display("FAIL! memory[17] = %h", result_tb);
 
        #20;
        if (result_tb == 32'h00000030) point = point + 1;
		else $display("FAIL! memory[18] = %h", result_tb);

        #20;
        if (result_tb == 32'h00000030) point = point + 1;
		else $display("FAIL! memory[19] = %h", result_tb);
 
		/* Summary message */
        $display ("%s%0d","Number of correct test cases: ", point);
      end

  /* End simulation after 430ns */
  initial
    begin
      #430;
      $finish;
    end

endmodule // tb_Processor