 `timescale 1ns / 1ps

 module imm_gen(
     input logic [31:0] instruction,
     output logic [31:0] imm
     );

//     logic [4:0] rs2;
//     logic [4:0] rs1;
//     logic [4:0] rd;
     logic [6:0] opcode;
//     logic [6:0] funct3;
//     logic [6:0] funct7;

     logic [4:0] shamt;
     assign shamt = instruction[24:20];
     assign opcode = instruction[6:0];
//     assign funct3 = instruction[14:12];
//     assign funct7 = instruction[31:25];
//     assign rs2 = instruction[24:20];
//     assign rs1 = instruction[19:15];
//     assign rd = instruction[11:7];

      always_comb
          case(instruction[6:0])
          7'b0000011 /*I-type load*/     : 
              imm = {instruction[31]? {20{1'b1}}:20'b0 , instruction[31:20]};
          7'b0010011 /*I-type addi*/     :
              begin 
              if((instruction[31:25]==7'b0100000&&instruction[14:12]==3'b101)||(instruction[14:12]==3'b001)||instruction[14:12]==3'b101)
//                  imm = {shamt[4]? {27{1'b1}}:27'b0,shamt}; check if this works
                  imm = {27'b0,shamt};
              else
                  imm = {instruction[31]? 20'b1:20'b0 , instruction[31:20]};
              end
          7'b0100011 /*S-type*/    : 
              imm = {instruction[31]? 20'b1:20'b0 , instruction[31:25], instruction[11:7]};
          7'b1100011 /*B-type*/    : 
              imm = {instruction[31]? 20'b1:20'b0 , instruction[7], instruction[30:25],instruction[11:8],1'b0};
          7'b1100111 /*JALR*/    : 
              imm = {instruction[31]? 20'b1:20'b0 , instruction[30:25], instruction[24:21], instruction[20]};
          7'b0010111 /*U-type*/    : 
              imm = {instruction[31]? 1'b1:1'b0 , instruction[30:20], instruction[19:12],12'b0};
          7'b0110111 /*LUI-type*/    : 
              imm = {instruction[31:12], 12'b0};
          7'b0110111 /*AUIPC-type*/    : 
              imm = {instruction[31:12], 12'b0};
          7'b1101111 /*JAL*/    : 
              imm = {instruction[31]? 20'b1:20'b0 , instruction[19:12], instruction[19:12],instruction[20], instruction[30:25],instruction[24:21],1'b0};
          default                    : 
              imm = {32'b0};
          endcase
    


 endmodule
