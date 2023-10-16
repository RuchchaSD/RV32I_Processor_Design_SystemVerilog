`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2023 03:14:40 PM
// Design Name: 
// Module Name: data_extract
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


module data_extract(
    input logic [31:0] memOut,
    input logic [2:0] extSel,
    output logic [31:0] extOut
//    output logic [15:0] extOut_h,
//    output logic [7:0] extout_b
    );
    
    always_comb 
        case(extSel)
            //3'b000: extOut = memOut[31:24];
            3'b010  : // lw
                extOut = memOut;
            3'b001  : // lh
                extOut = {memOut[31] ? {16{memOut[31]}} : 16'b0, memOut[31:16] };
            3'b000  : // lb
                extOut = {memOut[31] ? {24{memOut[31]}} : 24'b0, memOut[31:24] };
            3'b101  : // lhu
                extOut = {16'b0, memOut[31:16] };
            3'b100  : // lbu
                extOut = {24'b0, memOut[31:24] };
            // 3'b110  : //SB
            //     extOut_h = memOut[15:0];
            // 3'b111  : //SH
            //     extOut_b = memOut[7:0];
            default :
                extOut = 0;
        endcase
    
    
    
    
endmodule
