`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2023 04:39:27 PM
// Design Name: 
// Module Name: datapath
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


module datapath(
    input clk,
    input rst,
    input logic [31:0] nextPC,
    input logic [31:0] PC,
    input logic [31:0] instruction,
    input logic [3:0] immSel,
    input logic [3:0] aluControl,
    input logic regWrite,
    input logic [1:0] memWrite,
    input logic branch,
    input logic aSel,
    input logic bSel,
    input logic [1:0] wSel,
    input logic [2:0] extSel,
    
    output logic beq,
    output logic blt,
    output logic [31:0] dataW,
    output logic [31:0] aluOut
    );
    
    logic [31:0] dataA, dataB, op1, op2, memOut, imm , extOut;
    logic isZero;
    logic [4:0] addA, addB, addW;
    
    register_memory reg_mem(clk, rst, regWrite, addW, addA, addB, dataW, dataA, dataB);
    alu alu(aluControl, op1, op2, aluOut, isZero);
    data_memory dMem(clk, memWrite, aluOut, dataB, memOut);
    imm_gen immg(instruction, imm);
    data_extract de(memOut, extSel, extOut);
    branch_comp bc(branch, dataA, dataB, beq, blt);
    
    
    
    always_comb begin
        addA = instruction[19 : 15];
        addB = instruction[24:20];
        addW = instruction[11:7];
    end
    
    always_comb begin
        if(bSel)
            op2 = imm;
        else
            op2 = dataB;
        
        if(aSel)
            op1 = PC;
        else
            op1 = dataA;
        
        case(wSel) 
            0: dataW = aluOut;
            1: dataW = extOut;
            2: dataW = nextPC;
            3: dataW = imm;
            default: dataW = 0;
        endcase
    end

endmodule
