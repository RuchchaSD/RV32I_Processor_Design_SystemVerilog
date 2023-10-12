`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2023 11:10:32 AM
// Design Name: 
// Module Name: instruction_fetch
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
module instruction_fetch#(
        parameter DATA_WIDTH = 32
)(
    input clk,
    input logic rst,
    input logic pcSel,
    input logic  [DATA_WIDTH-1:0] aluOut,
    output logic [DATA_WIDTH-1:0] instruction,
    output logic [DATA_WIDTH-1:0] PC
    );

Instruction_memory instruction_memory_inst(
    .clk(clk),
    .address(PC),
    .instruction(instruction)
    );

always_ff @(posedge clk) begin
    if(rst) begin
        PC = 0;
    end
    else begin
        if(pcSel)
            PC <= aluOut;
        else 
            PC <= PC + 4;
    end
end



endmodule
