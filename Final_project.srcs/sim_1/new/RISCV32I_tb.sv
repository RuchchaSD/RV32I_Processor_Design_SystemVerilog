`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2023 08:19:55 AM
// Design Name: 
// Module Name: RISCV32I_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISCV32I_tb;

  // Define constants
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 32;

  //Define Registers
  logic [31:0] dataW,aluOut;
  logic clk;
  logic rst = 0;
  // Instantiate the module
  RISCV32I #(DATA_WIDTH,ADDR_WIDTH) dut (clk, rst, dataW,aluOut);

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;
    #10;
    rst = 0;
    #400;
    $finish;
  end

  // Monitor for displaying aluOut
//  initial begin
//    $display("Time\t\taluOut");
//    $display("-------------------------");
//    #10;
//    $monitor("%0t\t\t%h", $time, aluOut);
//    #5;
//    $monitor("%0t\t\t%h", $time, aluOut);
//    #5;
//    $monitor("%0t\t\t%h", $time, aluOut);
//    #5;
//    $monitor("%0t\t\t%h", $time, aluOut);
//    #25; 
//    $finish;
//  end

endmodule
