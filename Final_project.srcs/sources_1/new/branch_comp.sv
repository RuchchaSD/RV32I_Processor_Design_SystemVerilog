`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2023 03:14:40 PM
// Design Name: 
// Module Name: branch_comp
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


module branch_comp(
    input logic branch,
    input logic [31:0] dataA,
    input logic [31:0] dataB,
    output logic beq,
    output logic blt
    );
    
    always_comb begin
        if(branch)
            blt = dataA < dataB;
        else
            blt = $signed(dataA) < $signed(dataB);
        
        beq = dataA == dataB; 
     end
    
endmodule
