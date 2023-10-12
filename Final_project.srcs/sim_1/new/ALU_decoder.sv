`timescale 1ns / 1ps

module ALU_decoder_tb;

    // Inputs
    reg [3:0] aluOp;
    reg [6:0] func7;
    reg [2:0] func3;

    // Outputs
    wire [3:0] aluControl;

    // Instantiate the aluDecoder module
    aluDecoder dut (
        .aluOp(aluOp),
        .func7(func7),
        .func3(func3),
        .aluControl(aluControl)
    );

    // Test vectors
    initial begin
        $display("Test | aluOp | func7 | func3 | aluControl");
        $display("----------------------------------------");

        // Test case 1 - R type, add
        aluOp = 4'b0000;
        func7 = 7'b0000000;
        func3 = 3'b000;
        #10;
        $display("  1  |  %b   |  %b   |  %b   |   %b", aluOp, func7, func3, aluControl);

        // Test case 2 - R type, sll
        aluOp = 4'b0000;
        func7 = 7'b0100000;
        func3 = 3'b000;
        #10;
        $display("  2  |  %b   |  %b   |  %b   |   %b", aluOp, func7, func3, aluControl);

        // Test case 3 - R type, add
        aluOp = 4'b0000;
        func7 = 7'b0000000;
        func3 = 3'b001;
        #10;
        $display("  1  |  %b   |  %b   |  %b   |   %b", aluOp, func7, func3, aluControl);

        // Test case 2 - R type, sll
        aluOp = 4'b0000;
        func7 = 7'b0000000;
        func3 = 3'b010;
        #10;
        $display("  2  |  %b   |  %b   |  %b   |   %b", aluOp, func7, func3, aluControl);
        
        $finish;
    end

endmodule
