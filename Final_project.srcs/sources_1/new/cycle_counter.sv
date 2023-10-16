`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 07:32:30 AM
// Design Name: 
// Module Name: cycle_counter
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


module cycle_counter(
    input logic increment,
    input logic counterEn,
    output logic [31:0] cnt,
    output logic [31:0] cntPlus4
    );
    
//    initial 
//        cnt = 0;
    
    
    assign cntPlus4 = cnt + 4;
    
    always_ff @(posedge increment or negedge counterEn) begin
        if(!counterEn)
            cnt <= 0;
        else
            cnt <= cntPlus4;
    end
    
    
endmodule
