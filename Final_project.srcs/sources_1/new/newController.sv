`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 10:19:36 AM
// Design Name: 
// Module Name: newController
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


module newController(
//inputs
    input logic clk,
    input logic rst,
    input logic [31:0] instruction,
    input logic beq,
    input logic blt,
    input logic [1:0] diff, //0:rs1, 1:pc
    input logic [1:0] ilt,
//outputs
    output logic [3:0] immSel,// not needed
    output logic [3:0] aluControl,
    output logic [1:0] pcSel, //0:pc+4, 1:aluOut
    output logic regWrite, 
    output logic [1:0] memWrite, 
    output logic branch, //0:beq, 1:blt
    output logic [1:0] aSel, //0:rs1, 1:pc
    output logic [1:0] bSel, //0:rs2, 1:imm
    output logic [1:0] wSel, //0:aluOut, 1:memOut, 2: PC+4
    output logic [2:0] extSel, //0:sign extend, 1:zero extend, 2:shift left 1, 3:shift left 12
    output logic increment, counterEn, memWsel, dataregWrite
    );
    
    logic [6:0] opcode;
    logic [1:0] pccon;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [3:0] aluOp;
    logic isBranch;
    logic [31:0] microIns;
    logic [7:0] microOp,insmicroOp,_;
    logic [7:0] nextOp;
    
    
    
    logic  [31 :0] Control[ 255:0];
    
    initial begin
        Control[0] = 32'b00000000000000000000000000000000;
        Control[1] = 32'b00000000000100100000000011100000;
        Control[2] = 32'b00000000001000100000000011100000;
        Control[3] = 32'b00000000001100100000000011100000;
        Control[5] = 32'b00000000010000100000000011100000;
        Control[7] = 32'b00000000010100100000000011100000;
        Control[9] = 32'b00000000011000100000000011100000;
        Control[11] = 32'b00000000100000100000000011100000;
        Control[12] = 32'b00000000011100100000000011100000;
        Control[13] = 32'b00000000100100100000000011100000;
        Control[15] = 32'b00000000101000100000000011100000;
        Control[10] = 32'b00000000111100100000000011100000;

        //LUI
        Control[17] = 32'b00000000000000100000011111100000;
        //AUIPC
        Control[129] = 32'b00000000000100100001010011100000;

        //JALR
        Control[33] = 32'b00000000000110100000011011100000;
        //Itype Arith
        Control[49] = 32'b00000000000100100000010011100000;
        Control[53] = 32'b00000000010000100000010011100000;
        Control[55] = 32'b00000000010100100000010011100000;
        Control[57] = 32'b00000000011000100000010011100000;
        Control[61] = 32'b00000000100100100000010011100000;
        Control[63] = 32'b00000000101000100000010011100000;
        Control[51] = 32'b00000000001100100000010011100000;
        Control[59] = 32'b00000000100000100000010011100000;
        Control[60] = 32'b00000000011100100000010011100000;

        //I type load
        Control[65] = 32'b00000000000100100000010100000000;
        Control[67] = 32'b00000000000100100000010100100000;
        Control[69] = 32'b00000000000100100000010101000000;
        Control[73] = 32'b00000000000100100000010110000000;
        Control[75] = 32'b00000000000100100000010110100000;

        //Stype
        Control[81] = 32'b00000000000100011000010011100000;
        Control[83] = 32'b00000000000100010000010011100000;
        Control[85] = 32'b00000000000100001000010011100000;

        //sb type
        Control[97] = 32'b00000000000101000001010011100000;
        Control[99] = 32'b00000000000101000001010011100000;
        Control[105] = 32'b00000000000101000001010011100000;
        Control[107] = 32'b00000000000101000001010011100000;
        Control[109] = 32'b00000000000101000101010011100000;
        Control[111] = 32'b00000000000101000101010011100000;

        //Jtype
        Control[113] = 32'b00000000000110100001011011100000;

    end


    
    
//decode
    always_comb 
    begin
        opcode = instruction[6:0];
        funct3 = instruction[14:12];
        funct7 = instruction[31:25];
        
        nextOp = microIns[31:24];
        aluControl = microIns[23:20];
        pccon = microIns[19:18];
        regWrite = microIns[17];
        memWrite = microIns[16:15];
        branch = microIns[14];
        aSel = microIns[13:12];
        bSel = microIns[11:10];
        wSel = microIns[9:8];
        extSel = microIns[7:5];
        memWsel = microIns[4];
        increment = microIns[3];
        counterEn = microIns[2];
        memWsel = microIns[1];
        dataregWrite = microIns[0];
    end
    
   
    
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
    assign MEMCOPY = 7'b1101011;
    
    always_comb
        case(opcode)
            R_TYPE : begin
                // _[7:4] = 4'b0000;
                // _[3:1] = funct3;
                // _[0] = funct7[5];
                insmicroOp ={4'b0000, funct3, funct7[5]};
                // insmicroOp = _ +1;
            end
            LUI : begin 
                insmicroOp = 16; 
                // insmicroOp = _ +1;
    
            end
            JALR : begin
                insmicroOp = 32;
                // insmicroOp = _ +1;
            end
            ITYPE_ADD : begin
                insmicroOp[7:4] = 4'b0011;
                insmicroOp[3:1] = funct3;
                if(funct3 == 3'b101)
                    insmicroOp[0] = funct7[5];
                else
                    insmicroOp[0] = 0;
                
                insmicroOp = {4'b0011, funct3, funct3 == 3'b101 ? funct7[5] : 1'b0};
                // insmicroOp = _ +1;
                    
            end
            LW : begin 
                // _ = 4'b0100;
                // _[3:1] = funct3;
                // _[0] = 0;
                insmicroOp = {4'b0100, funct3, 1'b0};
                // insmicroOp = _ +1;
            end
            SW : begin
                // _ = 4'b0101;
                // _[3:1] = funct3;
                // _[0] = 0;
                insmicroOp = {4'b0101, funct3, 1'b0};
                // insmicroOp = _ +1;
            end
            BR : begin
                // _ = 4'b0110;
                // _[3:1] = funct3;
                // _[0] = 0;
                insmicroOp = {4'b0110, funct3, 1'b0}; 
                // insmicroOp = _ +1;
            end
            JAL : begin
                insmicroOp = 112;
                // insmicroOp = _ +1;
            end
            AUIPC : begin
                insmicroOp = 128;
                // insmicroOp = _ +1;
            end
            MEMCOPY : begin
                insmicroOp = 4'b1001;
                // insmicroOp = _ +1;
            end
            default:
                insmicroOp = -1;
        endcase
    
    //get microinstruction from control memory
    always_comb begin

        if(nextOp != 8'b00000000)
            microOp = nextOp;
        else
            microOp = insmicroOp + 1 ;

        if(rst)
            microOp = 0;

        microIns = Control[microOp] ;
    end



    
     //pcSel //beq,blt
    always_comb begin
        if(pccon == 1)
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
        else if(pccon == 2)
            pcSel = 1;
        else if(pccon == 3)
            pcSel = 2;
        else
            pcSel = 0;
        end
    
    
//if(microOP == )begin
//   if(something)
         

//end

endmodule
