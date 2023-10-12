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
        imem[0] = 32'h01710213; // addi x4 <=23 + x2
        imem[1] = 32'h81712293; // slti x5 <= 4019 > x2 := 1
        imem[2] = 32'h01716313; // ori x6 <= x2 or 10111
        imem[3] = 32'h00311393; //slli x7 <= x2 << 3
        imem[4] = 32'h00315413; //srli x8 <=x2 >> 3
        imem[5] = 32'h40315493; //srai x9 <= 3 >> x2
        imem[6] = 32'h001101B3;// add x3 <= x2 + x1 add
        imem[7] = 32'h401101B3;// sub x3 <= x2 - x1 sub
        // imem[2]  =32'  ;
        for (int i=8; i < (2**(add_length-2) - 1); ++i) begin
            imem[i] = 0;
        end

    end

    
    
    assign instruction = imem[address[add_length-1 : 2]];
endmodule
