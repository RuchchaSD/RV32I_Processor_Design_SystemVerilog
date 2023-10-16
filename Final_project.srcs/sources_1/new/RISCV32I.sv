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

    logic beq,blt,regWrite,branch,increment, counterEn, memWsel, dataregWrite;
    logic regWriten,branchn,incrementn, counterEnn, memWseln, dataregWriten; //
    logic [1:0] pcSel,wSel,memWrite,aSel,bSel,diff,ilt;
    logic [1:0] pcSeln,wSeln,memWriten,aSeln,bSeln,diffn,iltn; // 
    logic [3:0] immSel;
    logic [3:0] immSeln;//
    logic [3:0] aluControl;
    logic [3:0] aluControln;//
    logic [31:0] instruction,nextPC,PC;
    logic [2:0] extSel;
    logic [2:0] extSeln;//

    instruction_fetch ins(clk,rst, pcSel,aluOut,instruction,nextPC,PC);
    // controller c(clk, instruction, beq, blt,diff,ilt, immSel, aluControl, pcSel, regWrite, memWrite, branch,aSel,bSel,wSel, extSel,increment, counterEn, memWsel, dataregWrite);
    datapath d(clk, rst, nextPC, PC, instruction, immSel, aluControl, regWrite, memWrite, branch, aSel, bSel, wSel,extSel,increment, counterEn, memWsel, dataregWrite, beq, blt, dataW, aluOut,diff,ilt);
    newController nc(clk, rst, instruction, beq, blt,diff,ilt,immSel, aluControl, pcSel, regWrite, memWrite, branch,aSel,bSel,wSel, extSel,increment, counterEn, memWsel, dataregWrite);
endmodule
