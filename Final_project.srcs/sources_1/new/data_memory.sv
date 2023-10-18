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
    parameter ADDRESS_LENGTH = 6, 
    parameter width = 32
)(
    input clk,
    input logic [2:0] memWrite, // 1 = sw, 2 = sh 3 = sb 
   // input logic memRead, // active high
    input logic [ADDRESS_LENGTH - 1:0] addRW,
    input logic [width - 1:0] dataW,
    output logic[width - 1:0] dataOut
    );
    
//    logic  [width - 1:0] DMEM[ 2**(ADDRESS_LENGTH-2) :0];
      logic [7 : 0] DMEM[2**ADDRESS_LENGTH - 1 : 0];    

initial begin
    for(int i = 0; i < 2**ADDRESS_LENGTH; i++)
        DMEM[i] = 0;
        
    // DMEM[0] = 32'hff;
    // DMEM[1] = 32'hff;
    // DMEM[2] = 32'hff;
    // DMEM[3] = 32'hff;

//    DMEM[33] = 32'hff;
//    DMEM[34] = 32'hff;
//    DMEM[35] = 32'hff;
//    DMEM[36] = 32'hff;
//    DMEM[25] = 32'hff;
//    DMEM[18] = 32'h66;
//    DMEM[19] = 32'h77;
//    DMEM[20] = 32'h88;
    
end






    assign dataOut[31:24] = DMEM[addRW];
    assign dataOut[23:16] = DMEM[addRW+1];
    assign dataOut[15:8] = DMEM[addRW+2];
    assign dataOut[7:0] = DMEM[addRW+3];

    always_ff @(posedge clk)
//        if(memWrite)
//            DMEM[addRW] <= dataW ;
        case(memWrite)
            1   :
                begin
                    DMEM[addRW]     <= dataW[31 : 24];
                    DMEM[addRW + 1] <= dataW[23 :16];
                    DMEM[addRW + 2] <= dataW[15 : 8];
                    DMEM[addRW + 3] <= dataW[7  : 0];
                end
            2   :
                begin
                    DMEM[addRW]     <= dataW[15 : 8];
                    DMEM[addRW + 1] <= dataW[7  : 0];
                end
            3   :
                begin
                    DMEM[addRW] <= dataW[7:0];
                end
            4   :
                begin
                    DMEM[addRW]     <= dataW[31 : 24];
                end
            5   :
                begin
                    DMEM[addRW]     <= dataW[31 : 24];
                    DMEM[addRW + 1] <= dataW[23 :16];
                end
            6   :
                begin
                    DMEM[addRW]     <= dataW[31 : 24];
                    DMEM[addRW + 1] <= dataW[23 :16];
                    DMEM[addRW + 2] <= dataW[15 : 8];
                end
        endcase
    
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
