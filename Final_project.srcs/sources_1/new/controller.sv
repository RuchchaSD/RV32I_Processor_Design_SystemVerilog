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
    output logic [1:0] memWrite, 
    output logic branch, //0:beq, 1:blt
    output logic aSel, //0:rs1, 1:pc
    output logic bSel, //0:rs2, 1:imm
    output logic [1:0] wSel, //0:aluOut, 1:memOut, 2: PC+4
    output logic [2:0] extSel //0:sign extend, 1:zero extend, 2:shift left 1, 3:shift left 12
    );

    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [3:0] aluOp;
    logic isBranch;

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

     
//    assign pcSel = (opcode == BR && (beq || blt)) || opcode == JAL ||opcode == JALR; // not finished
    assign regWrite = (opcode==R_TYPE || opcode==LW || opcode == ITYPE_ADD || opcode == JALR || opcode == JAL || opcode == AUIPC || opcode == LUI);
//    assign memWrite = opcode == SW;
    assign aSel = (opcode == AUIPC || opcode == JAL || opcode == BR);
    // invert bSel to use less logic - optimize
    assign bSel = (opcode == ITYPE_ADD || opcode == LW || opcode == SW || opcode == JALR || opcode == JAL || opcode == AUIPC || opcode == LUI || opcode == BR);

//wSel
    always_comb
    begin
        if(opcode == LW)
            wSel = 2'b01; //extOut
        else if(opcode == JAL || opcode == JALR)
            wSel = 2'b10; //nextpc
        else if(opcode == LUI)
            wSel = 2'b11; //imm
        else
            wSel = 2'b00; //aluOut
    end

//aluop
    always_comb
    begin
        if(opcode == R_TYPE)
            aluOp = 4'b0000;
        else if(opcode == ITYPE_ADD)
            aluOp = 4'b0001;
        else if(opcode == SW || opcode == LW || opcode == AUIPC || opcode == JALR || opcode == JAL || opcode == BR)
            aluOp = 4'b0010;
        else
            aluOp = 4'b1000;
    end

//extSel
    always_comb
    begin
        if(opcode == LW)
            extSel = funct3;
        else
            extSel = 3'b111;
    end

//memWrite
    always_comb
        if(opcode == SW)
            case(funct3)
                 3'b010 :
                    memWrite = 1;
                 3'b001 :
                    memWrite = 2;
                 3'b000 :
                    memWrite = 3;
            endcase
          else 
            memWrite = 0;

//branch
    always_comb 
        if(funct3 == 6 || funct3 == 7)
            branch = 1;
        else
            branch = 0;

            
            
//pcSel //beq,blt
    always_comb begin
        if(opcode == BR)
            case(funct3)
                3'b000://BEQ
                    if(beq)
                        pcSel = 1; 
                    else 
                        pcSel = 0;  
                3'b001://BNE
                    if(!beq)
                        pcSel = 1;
                    else 
                        pcSel = 0;
                3'b100://BLT
                    if(blt)
                        pcSel = 1;
                    else 
                        pcSel = 0;
                3'b101://BGE
                    if(!blt)
                        pcSel = 1;
                    else 
                        pcSel = 0;
                3'b110://BLTU
                    if(blt)
                        pcSel = 1;
                    else 
                        pcSel = 0;
                3'b111://BGEU
                    if(!blt)
                        pcSel = 1;
                    else 
                        pcSel = 0;
                default:
                     pcSel = 0;
            endcase
        else if(opcode == JAL || opcode == JALR)
            pcSel = 1;
        else
            pcSel = 0;
    end
endmodule