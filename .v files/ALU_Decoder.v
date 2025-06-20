module ALU_decoder (ALUOp, funct3, funct7, op, ALUControl);
    input [1:0] ALUOp;
    input [2:0] funct3;
    input [6:0] funct7, op;
    output [2:0] ALUControl;

    assign ALUControl = 
    (ALUOp == 2'b00)           ? 3'b000 :       // addi, lw, sw
    (ALUOp == 2'b01)           ? 3'b001 :       // branch (sub)
    (ALUOp == 2'b10 && funct3 == 3'b000 && funct7[5] == 1'b0) ? 3'b000 : // add
    (ALUOp == 2'b10 && funct3 == 3'b000 && funct7[5] == 1'b1) ? 3'b001 : // sub
    (ALUOp == 2'b10 && funct3 == 3'b111) ? 3'b010 : // and
    (ALUOp == 2'b10 && funct3 == 3'b110) ? 3'b011 : // or
    (ALUOp == 2'b10 && funct3 == 3'b010) ? 3'b101 : // slt
    3'b000;

endmodule
