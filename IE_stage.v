`include "ALU.v"
`include "MUX.v"
`include "PC_add.v"

module execute_stage (clk, rst, RegWrtEx, ALUSrcEx, MemWrtEx, ResultSrcEx, BranchEx, ALUControlEx, RD1Ex, RD2Ex, Imm_ExtEx, RDEx, PCEx, PCplus4Ex, PCSrcEx, PCTargetEx, RegWrtMem, MemWrtMem, ResultSrcMem, RD_Mem, PCplus4Mem, WriteDataMem, ALU_ResultMem, ResultW, ForwardAEx, ForwardBEx);
  
    // Declaration I/Os
    input clk, rst, RegWrtEx, ALUSrcEx, MemWrtEx, ResultSrcEx, BranchEx;
    input [2:0] ALUControlEx;
    input [31:0] RD1Ex, RD2Ex, Imm_ExtEx;
    input [4:0] RDEx;
    input [31:0] PCEx, PCplus4Ex;
    input [31:0] ResultW;
    input [1:0] ForwardAEx, ForwardBEx;

    output PCSrcEx, RegWrtMem, MemWrtMem, ResultSrcMem;
    output [4:0] RD_Mem; 
    output [31:0] PCplus4Mem, WriteDataMem, ALU_ResultMem;
    output [31:0] PCTargetEx;

    //------Wires------//
    wire [31:0] Src_A, Src_B_interim, Src_B;
    wire [31:0] ResultEx;
    wire ZeroEx;

    //------Registers------//
    reg RegWrtEx_r, MemWrtEx_r, ResultSrcEx_r;
    reg [4:0] RDEx_r;
    reg [31:0] PCplus4Ex_r, RD2Ex_r, ResultEx_r;

    //------Modules------//

    // Mux for A
    Mux_3_by_1 srca_mux (
                        .a(RD1Ex),
                        .b(ResultW),
                        .c(ALU_ResultMem),
                        .sel(ForwardAEx),
                        .d(Src_A)
                        );

    // Mux for B
    Mux_3_by_1 srcb_mux (
                        .a(RD2Ex),
                        .b(ResultW),
                        .c(ALU_ResultMem),
                        .sel(ForwardBEx),
                        .d(Src_B_interim)
                        );
    
    // ALU Src Mux
    MUX alu_src_mux (
            .a(RD2Ex),
            .b(Imm_ExtEx),
            .sel(ALUSrcEx),
            .c(Src_B)
            );

    // ALU 
    ALU alu (
            .A(Src_A),
            .B(Src_B),
            .Result(ResultEx),
            .ALUControl(ALUControlEx),
            .Zero(ZeroEx)
            );

    // Adder
    PC_adder branch_adder (
            .a(PCEx),
            .b(Imm_ExtEx),
            .c(PCTargetEx)
            );

    // Register Logic
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            RegWrtEx_r <= 1'b0;
            MemWrtEx_r <= 1'b0;
            ResultSrcEx_r <= 1'b0;
            RDEx_r <= 5'h0000000;
            PCplus4Ex_r <= 32'h00000000;
            RD2Ex_r <= 32'h00000000;
            ResultEx_r <= 32'h00000000;
        end 
        else begin
            RegWrtEx_r <= RegWrtEx;
            MemWrtEx_r <= MemWrtEx;
            ResultSrcEx_r <= ResultSrcEx;
            RDEx_r <= RDEx;
            PCplus4Ex_r <= PCplus4Ex;
            RD2Ex_r <= RD2Ex;
            ResultEx_r <= ResultEx;
        end
    end

    // Output Logic

    assign PCSrcEx = ZeroEx & BranchEx;
    assign RegWrtMem = RegWrtEx;
    assign MemWrtMem = MemWrtEx;
    assign ResultSrcMem = ResultSrcEx;
    assign RD_Mem = RDEx;
    assign PCplus4Mem = PCplus4Ex;
    assign WriteDataMem = RD2Ex;
    assign ALU_ResultMem = ResultEx;
    
endmodule