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
    input logic [1:0] pcSel,
    input logic  [DATA_WIDTH-1:0] aluOut,
    output logic [DATA_WIDTH-1:0] instruction,
    output logic [DATA_WIDTH-1:0] nextPC,
    output logic [DATA_WIDTH-1:0] PC
    );

logic [DATA_WIDTH-1:0] aluAddress;

Instruction_memory instruction_memory_inst(
    .clk(clk),
    .address(PC),
    .instruction(instruction)
    );



always_comb 
    nextPC = PC + 4;

always_ff @(negedge clk) begin
    if(rst) begin
        PC = 0;
    end
    else begin
        if(pcSel == 2'b01)
            PC <= aluAddress;
        else if(pcSel == 2'b10)
            PC <= PC;
        else 
            PC <= nextPC;
    end
end

// always_ff @(posedge clk) begin
//     aluAddress <= aluOut;
// end

assign aluAddress = aluOut;


endmodule
