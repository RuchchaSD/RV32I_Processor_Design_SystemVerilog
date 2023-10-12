`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2023 10:48:08 AM
// Design Name: 
// Module Name: data_memory_tb
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

//change this to your preference when testing 
module data_memory_tb;

    // Parameters for data memory
    parameter ADD_LENGTH = 9;
    parameter WIDTH = 32;

    // Declare signals for the testbench
    reg clk;
    reg dmem_w_en;
    reg dmem_r_en;
    reg [ADD_LENGTH - 1:0] dmem_rw_add;
    reg [WIDTH - 1:0] dmem_w_data;
    wire [WIDTH - 1:0] dmem_r_data;

    // Instantiate the data memory module
    data_memory #(
        .ADD_LENGTH(ADD_LENGTH),
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .dmem_w_en(dmem_w_en),
        .dmem_r_en(dmem_r_en),
        .dmem_rw_add(dmem_rw_add),
        .dmem_r_data(dmem_r_data),
        .dmem_w_data(dmem_w_data)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Testbench stimulus
    initial begin
        clk = 0;
        dmem_w_en = 0;
        dmem_r_en = 0;
        dmem_rw_add = 0;
        dmem_w_data = 0;

        // Write data to memory location 2
        dmem_w_en = 0; // Active low
        dmem_rw_add = 2;
        dmem_w_data = 32'hAABBCCDD;
        #10;

        // Read data from memory location 2
        dmem_w_en = 1; // Deactivate write
        dmem_r_en = 0; // Active low
        dmem_rw_add = 2;
        #10;

        // Add more test scenarios as needed

        // Assertions
        // Verify that the data read matches what was written
        if (dmem_r_data !== dmem_w_data) begin
            $display("Test failed: Data read does not match data written.");
            $stop;
        end else begin
            $display("Test passed: Data read matches data written.");
            $stop;
        end
    end

endmodule
