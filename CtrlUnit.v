`include "ALU_Decoder.v"
`include "Decoder.v"

module Ctrl_Unit (Op, RegWrt, ImmSrc, ALUSrc, MemWrt, ResultSrc, Branch, funct3, funct7, ALUControl);

    input [6:0] Op, funct7;
    input [2:0] funct3;
    output RegWrt, ALUSrc, MemWrt, ResultSrc, Branch;
    output [1:0] ImmSrc;
    output [2:0] ALUControl;

    wire [1:0] ALUOp;

    decoder Main_Decoder(
                .Op(Op),
                .RegWrt(RegWrt),
                .ImmSrc(ImmSrc),
                .MemWrt(MemWrt),
                .ResultSrc(ResultSrc),
                .Branch(Branch),
                .ALUSrc(ALUSrc),
                .ALUOp(ALUOp)
    );

    ALU_Decoder ALU_Decoder(
                            .ALUOp(ALUOp),
                            .funct3(funct3),
                            .funct7(funct7),
                            .op(Op),
                            .ALUControl(ALUControl)
    );
endmodule