`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2023 12:38:58 PM
// Design Name: 
// Module Name: register_memory
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


module register_memory#(
    parameter REGISTER_WIDTH = 32, 
    parameter DATA_WIDTH = 32
    )(
    input logic clk,
    input logic rst,
    input logic regWrite,
    input logic [4:0] addW,
    input logic [4:0] addA,
    input logic [4:0] addB,
    input logic [31:0] dataW,
    output logic [31:0]  dataA,
    output logic [31:0] dataB
    );

    logic [DATA_WIDTH-1:0] regs [REGISTER_WIDTH-1:0];

    always @(negedge clk) 
    begin
        if (rst) 
        begin
            for (int i = 0; i < REGISTER_WIDTH; i++) 
            begin
                regs[i] <= 0;
            end
        end 
        else if (regWrite) 
            begin
                regs[addW] <= dataW;
            end
    end
    
    always_comb 
    begin
        dataA = regs[addA];
        dataB = regs[addB];
    end
        
endmodule
