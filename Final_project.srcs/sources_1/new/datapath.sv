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
    input logic [31:0] prevInstruction,
    input logic [3:0] aluControl,
    input logic regWrite,
    input logic [2:0] memWrite,//
    input logic branch,
    input logic [1:0] aSel,
    input logic [1:0] bSel,
    input logic [1:0] wSel,
    input logic [2:0] extSel,
    input logic increment,//
    input logic counterEn,//
    input logic memWsel,//
    input logic dataregWrite,//
    
    output logic beq,
    output logic blt,
    output logic [31:0] dataW,
    output logic [31:0] aluOut,
    output logic [1:0] diff,//
    output logic [1:0] ilt//
    );
    
    logic [31:0] dataA, dataB, op1, op2, memOut, imm, immediate , extOut,cnt, cntPlus4,datamwrite,extIn,dataReg, instruction;
//    logic [2:0] extCon;
    logic isZero;
    logic [4:0] addA, addB, addW;
    
    
    
    register_memory reg_mem(clk, rst, regWrite, addW, addA, addB, dataW, dataA, dataB);
    alu alu(aluControl, op1, op2, aluOut, isZero);
    data_memory dMem(clk, memWrite, aluOut, datamwrite, memOut);
    imm_gen immg(instruction, imm);
    data_extract de(memOut, extSel, extOut);
    branch_comp bc(branch, dataA, dataB, beq, blt);
    cycle_counter cc(increment, counterEn, cnt, cntPlus4);
    
    always_ff @(negedge clk)begin
        if(dataregWrite)
            dataReg <= memOut;
    end

    always_ff @(posedge clk)
        instruction <= prevInstruction;
    
    
    always_comb begin
        addA = instruction[19 : 15];
        addB = instruction[24:20];
        addW = instruction[11:7];
    end
    
    always_comb begin
        if(bSel == 1)
            op2 = imm;
        else if(bSel == 2)
            op2 = 0;
        else if(bSel == 3)
            op2  = cnt;
        else
            op2 = dataB;
        
        if(aSel == 1)
            op1 = PC;
        else if(aSel == 2)
            op1 = 0;
        else if(aSel ==3)
            op1  = cnt;
        else
            op1 = dataA;
        
        case(wSel) 
            0: dataW = aluOut;
            1: dataW = extOut;
            2: dataW = nextPC;
            3: dataW = imm;
            default: dataW = 0;
        endcase
            
        if(memWsel)
            datamwrite = dataReg;
         else
            datamwrite = dataB;
    end
            
            
    //count comparator
    always_comb begin 
        // ilt[0] = $unsigned(imm) < $unsigned(cntPlus4);
        ilt[0] = $unsigned(imm) < $unsigned(cntPlus4);
        ilt[1] = imm == cnt;
        diff = $unsigned(cntPlus4[1:0]) - $unsigned(imm[1:0]);
    end
    //extSel, extCon

endmodule
