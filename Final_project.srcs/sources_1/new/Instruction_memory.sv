`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2023 02:24:45 PM
// Design Name: 
// Module Name: Instruction_memory
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


module Instruction_memory#(
    parameter add_length = 9, 
    parameter width = 32
)(
    input clk,
    input logic [ add_length - 1 : 0 ] address,
    output logic [ width - 1 : 0] instruction
    
    );
    logic  [width - 1:0] imem[ 2**(add_length-2) - 1:0];
    //add instructions in here
    initial begin
    
        for (int i=0; i < (2**(add_length-2) - 1); ++i) begin
            imem[i] = 0;
        end
//Itype
        imem[0] = 32'h7F710213; // addi x4 <=23 + x2
        imem[1] = 32'h81712293; // slti x5 <= 4019 > x2 := 1
        imem[2] = 32'h01716313; // ori x6 <= x2 or 10111
        imem[3] = 32'h00311393; //slli x7 <= x2 << 3
        imem[4] = 32'h00315413; //srli x8 <=x2 >> 3
        imem[5] = 32'h40315493; //srai x9 <= 3 >> x2
//Rtype
        imem[6] = 32'h001101B3;// add x3 <= x2 + x1 add
        imem[7] = 32'h401101B3;// sub x3 <= x2 - x1 sub

//SType 
//        imem[8]  = 32'h004425A3;
        imem[8]  = 32'h00441623;
        imem[9]  = 32'h00440A23;
        imem[10] = 32'h004421A3;
//        imem[12] =

//I type Load
        imem[11] = 32'hFFD40583;
        imem[12] = 32'hFFD41603;
        imem[13] = 32'hFFD42683;
        imem[14] = 32'hFFD44703;
        imem[15] = 32'hFFD45783;
        
//LUI
        imem[16] = 32'h00016837;
//AUIPC
        imem[17] = 32'h00016897;
//JAL
        imem[18] = 32'h0030096F;
//JALR
        imem[21] = 32'h052109E7;
//BR
//        imem[26] = 32'hFEB588E3;//BEQ
//        imem[26] = 32'h02B11663;//BNE
//        imem[27] = 32'h02B14663;//BLT
//        imem[26] = 32'h02B15663;//BGE
        imem[26] = 32'h02B16663;//BLTU
        imem[27] = 32'h02B17663; //BGEU
        
 
        // imem[2]  =32'  ;


    end

    
    
    assign instruction = imem[address[add_length - 1 : 2]];
endmodule
