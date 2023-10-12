`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2023 06:24:27 AM
// Design Name: 
// Module Name: controller_tb
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


module controller_tb;

    // Inputs
    logic clk;
    logic [31:0] instruction;
    logic beq;
    logic blt;

    // Outputs
    logic [3:0] immSel;
    logic [3:0] aluControl;
    logic pcSel;
    logic regWrite;
    logic memWrite;
    logic branch;
    logic aSel;
    logic bSel;
    logic [1:0] wSel;

    // Instantiate the controller module
//    controller dut (
//        .clk(clk),
//        .instruction(instruction),
//        .beq(beq),
//        .blt(blt),
//        .immSel(immSel),
//        .aluControl(aluControl),
//        .pcSel(pcSel),
//        .regWrite(regWrite),
//        .memWrite(memWrite),
//        .branch(branch),
//        .aSel(aSel),
//        .bSel(bSel),
//        .wSel(wSel)
//    );
      
      controller dut(clk, instruction, beq, blt, immSel, aluControl, pcSel, regWrite,
                   memWrite, branch, aSel, bSel, wSel);
        

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        beq = 0;
        blt = 0;
        instruction = 32'h001101B3; // ADD
        #10;

        #10 instruction = 32'h401101B3; // SUB
        beq = 0; // Set control signals accordingly
        blt = 1;
        
        
        #10 instruction = 32'h001111B3; // SLL
        beq = 1; // Set control signals accordingly
        blt = 0;
        
        #10 instruction = 32'h01716193; // LUI
        beq = 1; // Set control signals accordingly
        blt = 0;

        #10 instruction = 32'h01716193; // AUIPC
        beq = 0; // Set control signals accordingly
        blt = 1;

        #10 instruction = 32'h01710193; // JALR
        beq = 0; // Set control signals accordingly
        blt = 1;
              
        #10 instruction = 32'h01710193; // ADDI
        beq = 0; // Set control signals accordingly
        blt = 1;
        
        #10 instruction = 32'h01712193; // SLTI
        beq = 0; // Set control signals accordingly
        blt = 1;
        
        #10 instruction = 32'h41710183; // LB
        beq = 0; // Set control signals accordingly
        blt = 1;
        
        #10 instruction = 32'h417101A3; // SB
        beq = 0; // Set control signals accordingly
        blt = 1;
        
        #10 instruction = 32'h017101E3; // BEQ
        beq = 0; // Set control signals accordingly
        blt = 1;
        
        #10 instruction = 32'h017141E3; // BLT
        beq = 0; // Set control signals accordingly
        blt = 1;
        
        #10 instruction = 32'h017161EF; // JAL
        beq = 0; // Set control signals accordingly
        blt = 1;
        // Finish simulation after all test cases
        $finish;
    end

endmodule
