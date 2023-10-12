`timescale 1ns / 1ps

module controller(
    input logic clk,
    input logic [31:0] instruction,
    input logic beq,
    input logic blt,
    output logic [3:0] immSel,
    output logic [3:0] aluControl,
    output logic pcSel, //0:pc+4, 1:aluOut
    output logic regWrite, 
    output logic memWrite, 
    output logic branch, //0:beq, 1:blt
    output logic aSel, //0:rs1, 1:pc
    output logic bSel, //0:rs2, 1:imm
    output logic [1:0] wSel //0:aluOut, 1:memOut, 2: PC+4
    );

    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [3:0] aluOp;

    always_comb 
    begin
        opcode = instruction[6:0];
        funct3 = instruction[14:12];
        funct7 = instruction[31:25];
    end

    aluDecoder aluDecoder(aluOp, funct3, funct7, aluControl);
//      aluDecoder aluDecoder(aluOp, instruction[14:12], instruction[31:25], aluControl);
      

    logic [6:0] R_TYPE, LW, SW, ITYPE_ADD, BR, JALR, JAL,AUIPC,LUI;
    assign  BR     = 7'b1100011;
    assign  R_TYPE = 7'b0110011;
    assign  LW     = 7'b0000011;
    assign  SW     = 7'b0100011;
    assign  ITYPE_ADD = 7'b0010011; //addi,ori,andi
    assign  JAL = 7'b1101111;
    assign  JALR = 7'b1100111;
    assign  AUIPC = 7'b0010111;
    assign  LUI = 7'b0110111;

     
    assign pcSel = (opcode == BR && (beq || blt)) || opcode == JAL ||opcode == JALR; // not finished
    assign regWrite = (opcode==R_TYPE || opcode==LW || opcode == ITYPE_ADD || opcode == JALR || opcode == JAL);
    assign memWrite = opcode == SW;
    assign branch = opcode == BR;
    assign aSel = (opcode == AUIPC || opcode == JALR || opcode == JAL);
    // invert bSel to use less logic - optimize
    assign bSel = (opcode == ITYPE_ADD || opcode == LW || opcode == SW || opcode == JALR || opcode == JAL || opcode == AUIPC || opcode == LUI);

    always_comb
    begin
        if(opcode == SW)
            wSel = 2'b01;
        else if(opcode == JAL || opcode == JALR)
            wSel = 2'b10;
        else
            wSel = 2'b00;
    end

    always_comb
    begin
        if(opcode == R_TYPE)
        begin
            aluOp = 4'b0000;
//            $dispaly("I ran at alu control", funct3, funct7);
        end
        else if(opcode == ITYPE_ADD)
            aluOp = 4'b0001;
        else if(opcode == SW)
            aluOp = 4'b0010;
        else if(opcode == BR)
            aluOp = 4'b0011;
        else if(opcode == JALR)// edit below
            aluOp = 4'b0100;
        else if(opcode == JAL)
            aluOp = 4'b0101;
        else if(opcode == AUIPC)
            aluOp = 4'b0110;
        else if(opcode == LUI)
            aluOp = 4'b0111;
        else
            aluOp = 4'b1000;
    end




    
endmodule