`include "ALU_Decoder.v"
`include "Main_Decoder.v"

module Ctrl_Unit (Op, RegWrt, ImmSrc, ALUSrc, MemWrt, ResultSrc, Branch, funct3, funct7, ALUControl);

    input [6:0] Op, funct7;
    input [2:0] funct3;
    output RegWrt, ALUSrc, MemWrt, ResultSrc, Branch;
    output [1:0] ImmSrc;
    output [2:0] ALUControl;

    wire [1:0] ALUOp;

    Main_Decoder Main_Decoder(
                .Op(Op),
                .RegWrt(RegWrt),
                .ImmSrc(ImmSrc),
                .MemWrt(MemWrt),
                .ResultSrc(ResultSrc),
                .Branch(Branch),
                .ALUSrc(ALUSrc),
                .ALUOp(ALUOp)
    );

    ALU_decoder alu_decoder(
                            .ALUOp(ALUOp),
                            .funct3(funct3),
                            .funct7(funct7),
                            .op(Op),
                            .ALUControl(ALUControl)
    );
    
endmodule