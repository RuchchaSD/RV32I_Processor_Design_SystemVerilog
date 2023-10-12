`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2023 11:37:50 PM
// Design Name: 
// Module Name: aluDecoder
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


module aluDecoder(
    input logic [3:0] aluOp,
    input logic [2:0] func3,
    input logic [6:0] func7,
    output logic [3:0] aluControl
    );

    always_comb    
        case(aluOp)
            4'b0000: // R type
            begin
                case(func3)
                    3'b000: // add and sub
                    begin
//                        $dispaly("I ran at add and sub", func3, func7);
                        if(func7[5] == 0)
                        begin
                            aluControl = 4'b0001;
                            
                        end
                        else if(func7[5] == 1)
                            aluControl = 4'b0010;
                        else
                            aluControl = 4'b0000;
                    end
                    3'b001: // sll
                    begin
                        aluControl = 4'h3;
                    end
                    3'b010: // slt
                    begin
                        aluControl = 4'h4;
                    end
                    3'b011: // sltu
                    begin
                        aluControl = 4'h5;
                    end
                    3'b100: // xor
                    begin
                        aluControl = 4'h6;
                    end
                    3'b101: // srl and sra
                    begin
                        if(func7[5] == 0)
                            aluControl = 4'h8; // srl
                        else if(func7[5] == 1)
                            aluControl = 4'h7; // sra
                        else
                            aluControl = 4'b0000;
                    end
                    3'b110: // or
                    begin
                        aluControl = 4'h9;
                    end
                    3'b111: // and
                    begin
                        aluControl = 4'hA;
                    end
                    default: // error
                    begin
                        aluControl = 0;
                    end
                endcase

            end
            4'b0001: // I type   
            begin
                case(func3)
                    3'b000: // addi
                    begin
                        aluControl = 4'h1;
                    end
                    3'b001: // slli
                    begin
                        aluControl = 4'h3;
                    end
                    3'b010: // slti
                    begin
                        aluControl = 4'h4;
                    end
                    3'b011: // sltiu
                    begin
                        aluControl = 4'h5;
                    end
                    3'b100: // xori
                    begin
                        aluControl = 4'h6;
                    end
                    3'b101: // srl and sra
                    begin
                        if(func7[5] == 0)
                            aluControl = 4'h8; // srl
                        else if(func7[5] == 1)
                            aluControl = 4'h7; // sra
                        else
                            aluControl = 4'b0000;
                    end
                    3'b110: // ori
                    begin
                        aluControl = 4'h9;
                    end
                    3'b111: // andi
                    begin
                        aluControl = 4'hA;
                    end
                    default: // error
                    begin
                        aluControl = 0;
                    end
                endcase
            end
            4'b0010: // S type
            begin
                aluControl = 0;
            end
            4'b0011: // SB type
            begin
                aluControl = 0;
            end
            4'b0100: // U type
            begin
                aluControl = 0;
            end
            4'b0101: // UJ type
            begin
                aluControl = 0;
            end
            default: // error
            begin
                aluControl = 0;
            end
        endcase


endmodule
