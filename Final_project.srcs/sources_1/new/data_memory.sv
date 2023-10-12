`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2023 02:00:13 AM
// Design Name: 
// Module Name: data_memory
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


module data_memory#(
    parameter ADDRESS_LENGTH = 9, 
    parameter width = 32
)(
    input clk,
    input logic memWrite, // active high
   // input logic memRead, // active high
    input logic [ADDRESS_LENGTH - 1:0] addRW,
    input logic [width - 1:0] dataW,
    output logic[width - 1:0] dataOut
    );
    
    logic  [width - 1:0] DMEM[ 2**(ADDRESS_LENGTH-2) :0];
    

    assign dataOut = DMEM[addRW];

    always_ff @(posedge clk)
        if(memWrite)
            DMEM[addRW] <= dataW ;
    
// implemented bounds checking and error handeling  
//    always_ff @(posedge clk) begin
//        if (memWrite && addRW < 2**(ADDRESS_LENGTH-2)) begin
//            DMEM[addRW] <= dataW;
//        end
//    end

//    always_comb begin
//        if (memRead && addRW < 2**(ADDRESS_LENGTH-2)) begin
//            dataOut = DMEM[addRW];
//        end
//        else begin
//            // Default value when read is not enabled or address is out of bounds
//            dataOut = '0;
//        end
//    end

endmodule
