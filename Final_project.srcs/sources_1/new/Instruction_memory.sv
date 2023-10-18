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
        
        
////////////////////////////////////////////////////////olds
////Itype
//        imem[0] = 32'h7F710213; // addi x4 <=23 + x2
//        imem[1] = 32'h81712293; // slti x5 <= 4019 > x2 := 1
//        imem[2] = 32'h01716313; // ori x6 <= x2 or 10111
//        imem[3] = 32'h00311393; //slli x7 <= x2 << 3
//        imem[4] = 32'h00315413; //srli x8 <=x2 >> 3
//        imem[5] = 32'h40315493; //srai x9 <= 3 >> x2
////Rtype
//        imem[6] = 32'h001101B3;// add x3 <= x2 + x1 add
//        imem[7] = 32'h401101B3;// sub x3 <= x2 - x1 sub

////SType 
////        imem[8]  = 32'h004425A3;
//        imem[8]  = 32'h00441623;
//        imem[9]  = 32'h00440A23;
//        imem[10] = 32'h004421A3;
////        imem[12] =

////I type Load
//        imem[11] = 32'hFFD40583;
//        imem[12] = 32'hFFD41603;
//        imem[13] = 32'hFFD42683;
//        imem[14] = 32'hFFD44703;
//        imem[15] = 32'hFFD45783;
        
////LUI
//        imem[16] = 32'h00016837;
////AUIPC
//        imem[17] = 32'h00016897;
////JAL
//        imem[18] = 32'h0030096F;
////JALR
////        imem[21] = 32'h052109E7;
////BR
////        imem[26] = 32'hFEB588E3;//BEQ
//          imem[26] = 32'hFEB58EE3;//BEQ
////        imem[26] = 32'h02B11663;//BNE
////        imem[27] = 32'h02B14663;//BLT
////        imem[26] = 32'h02B15663;//BGE
////        imem[26] = 32'h02B16663;//BLTU
////        imem[27] = 32'h02B17663; //BGEU
//////////////////////////////////////////////////////
//         imem[0] = 32'h001101B3; // ADD
//         imem[1] = 32'h401101B3; // SUB
//         imem[2] = 32'h001111B3; // SLL
//         imem[3] = 32'h001121B3; // SLT
//         imem[4] = 32'h001131B3; // SLTU
//         imem[5] = 32'h001141B3; // XOR
//         imem[6] = 32'h001151B3; // SRL
//         imem[7] = 32'h401151B3; // SRA
//         imem[8] = 32'h001161B3; // OR
//         imem[9] = 32'h001171B3; // AND
//         imem[10] = 32'h401141B3; // MUL
        
        
         imem[1] = 32'h00016837; // LUI
        
         imem[2] = 32'h00019317; // AUIPC
        
        
         imem[3] = 32'h033103E7; // JALR
        
//         imem[1] = 32'hFF710213; // ADDI
//         imem[2] = 32'h01712293; // SLTI
//         imem[3] = 32'h01713193; // SLTIU
//         imem[4] = 32'h01714193; // XORI
//         imem[5] = 32'h01716313; // ORI
//         imem[6] = 32'h01717193; // ANDI
//         imem[7] = 32'h00311393; // SLLI
//         imem[8] = 32'h00315413; // SRLI
//         imem[9] = 32'h40315493; // SRAI
        
        
//         imem[1] = 32'h00810583; // LB
//         imem[2] = 32'h00811603; // LH
//         imem[3] = 32'h00812683; // LW
//         imem[4] = 32'h00814703; // LBU
//         imem[5] = 32'h00815783; // LHU
        




        
//         imem[1] = 32'h00440223; // SB
//         imem[2] = 32'h00441223; // SH
//         imem[3] = 32'h00442223; // SW
        
        
//         imem[1] = 32'h00B58463; // BEQ
//         imem[3] = 32'h00B59463; // BNE
//         imem[5] = 32'h00B14463; // BLT
//         imem[7] = 32'h00B15463; // BGE
//         imem[9] = 32'h00B16463; // BLTU
//         imem[11] = 32'h00B17463; // BGEU
         
        
         imem[14] = 32'h0088046F; // JAL
        
//        imem[1] = 32'h0020836B; // MEMCOPY


    end

    
    
    assign instruction = imem[address[add_length - 1 : 2]];
endmodule
