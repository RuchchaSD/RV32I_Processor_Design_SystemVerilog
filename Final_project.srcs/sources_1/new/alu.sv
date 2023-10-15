`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2023 12:38:58 PM
// Design Name: 
// Module Name: alu
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

module alu(
    input logic [3:0] aluControl,
    input logic [31:0] op1, op2,
    output logic [31:0] aluOut,
    output logic isZero
);

    always_comb 
        case (aluControl)
            4'h1: aluOut <= $signed(op1) + $signed(op2); //ADD
            4'h2: aluOut <= op1 - op2; //SUB
            4'h3: aluOut <= op1 << op2; //SLL
            4'h4: aluOut <= $signed(op1) < $signed(op2); //SLT
            4'h5: aluOut <= op1 < op2; //SLTU
            4'h6: aluOut <= op1 ^ op2; //XOR
            4'h7: aluOut <= $signed(op1) >>> op2; //SRA
            4'h8: aluOut <= op1 >> op2; //SRL
            4'h9: aluOut <= op1 | op2; //OR
            4'ha: aluOut <= op1 & op2; //AND
            4'hb: aluOut <= op1 == op2; //BEQ
            4'hc: aluOut <= op1 != op2; //BNE
            4'hd: aluOut <= $signed(op1) >= $signed(op2); //BGE
            4'he: aluOut <= op1 >= op2; //BGEU
            default: aluOut <= 31'b0; //NOP
        endcase

    assign isZero = ~|aluOut;        

endmodule