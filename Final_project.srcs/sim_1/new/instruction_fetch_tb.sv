`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2023 11:02:21 AM
// Design Name: 
// Module Name: instruction_fetch_tb
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


module instruction_fetch_tb;

    reg clk;
    reg rst;
    reg pcSel;
    reg [31:0] aluOut;
    wire [31:0] instruction;
    wire [31:0] PC;

    // Instantiate the module under test
    instruction_fetch #(32) uut (
        .clk(clk),
        .rst(rst),
        .pcSel(pcSel),
        .aluOut(aluOut),
        .instruction(instruction),
        .PC(PC)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Testbench logic
    initial begin
        clk = 0;
        rst = 1;
        pcSel = 0;
        aluOut = 0;
        #10;
        // Reset and wait for a few clock cycles
        rst = 0;
        #10;

        // Test scenario for 5 clock cycles
        // PC starts at 0 and increments by 4 each cycle
        for (int i = 0; i < 5; i = i + 1) begin
            // Provide the aluOut value and select PC increment mode
            aluOut = i * 4;
            pcSel = 0;

            #5; // Wait for one clock cycle

            // Check the output values
            if (instruction !== 32'h0 || PC !== i * 4) begin
                $display("Test failed at cycle %d", i);
                $stop;
            end

            // Toggle pcSel for the next cycle
            pcSel = 1;
            
            #5; // Wait for one clock cycle
        end

        $display("Test passed!");
        $finish;
    end

endmodule

