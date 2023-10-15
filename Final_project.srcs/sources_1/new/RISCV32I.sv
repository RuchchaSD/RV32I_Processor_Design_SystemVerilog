`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2023 10:51:54 AM
// Design Name: 
// Module Name: RISCV32I
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


module RISCV32I#(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32
)(
    input clk,
    input rst,
    output logic [31:0] dataW, aluOut
    );

    logic pcSel,beq,blt,regWrite,branch,aSel,bSel;
    logic [1:0] wSel,memWrite;
    logic [3:0] immSel;
    logic [3:0] aluControl;
    logic [31:0] instruction,nextPC,PC;
    logic [2:0] extSel;

    instruction_fetch ins(clk,rst, pcSel,aluOut,instruction,nextPC,PC);
    controller c(clk, instruction, beq, blt, immSel, aluControl, pcSel, regWrite, memWrite, branch,aSel,bSel,wSel, extSel);
    datapath d(clk, rst, nextPC, PC, instruction, immSel, aluControl, regWrite, memWrite, branch, aSel, bSel, wSel,extSel, beq, blt, dataW, aluOut);

endmodule
