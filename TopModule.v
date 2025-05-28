`include "IF_stage.v"
`include "ID_stage.v"
`include "IE_stage.v"
`include "Memory_stage.v"
`include "WB_stage.v"
`include "PC_add.v"
`include "PC.v"
`include "Mux.v"
`include "InstructionMemory.v"
`include "CtrlUnit.v"
`include "RegFile.v"
`include "SignExtend.v"
`include "ALU.v"
`include "DataMem.v"
`include "HazardUnit.v"

module top_module (clk, rst);
    input clk, rst;

    wire PCsrcEx, RegWriteW, RegWrtEx, ALUSrcEx, MemWrtEx, ResultSrcEx, BranchEx, RegWrtMem, MemWrtMem, ResultSrcMem, ResultSrcW;
    wire [2:0] ALUControlEx;
    wire [4:0] RDEx, RD_Mem, RDW;
    wire [31:0] PCtrgEx, InstrDe, PCDe, PCplus4De, ResultW, RD1Ex, RD2Ex, Imm_ExtEx, PCEx, PCplus4Ex, PCplus4Mem, WriteDataMem, ALU_ResultMem, PCPlus4W, ALU_ResultW, ReadDataW;
    wire [4:0] RS1Ex, RS2Ex;
    wire [1:0] ForwardAEx, ForwardBEx;

    fetch_stage IF (
                    .clk(clk), 
                    .rst(rst), 
                    .PCsrcEx(PCsrcEx), 
                    .PCtrgEx(PCtrgEx), 
                    .InstrDe(InstrDe), 
                    .PCDe(PCDe), 
                    .PCplus4De(PCplus4De)
                    );

    decode_stage ID  (
                        .clk(clk),
                        .rst(rst),
                        .InstrDe(InstrDe), 
                        .PCDe(PCDe), 
                        .PCplus4De(PCplus4De), 
                        .RegWriteW(RegWriteW), 
                        .RDW(RDW), 
                        .ResultW(ResultW), 
                        .RegWrtEx(RegWrtEx), 
                        .ALUSrcEx(ALUSrcEx), 
                        .MemWrtEx(MemWrtEx), 
                        .ResultSrcEx(ResultSrcEx), 
                        .BranchEx(BranchEx), 
                        .ALUControlEx(ALUControlEx), 
                        .RD1Ex(RD1Ex), 
                        .RD2Ex(RD2Ex), 
                        .Imm_ExtEx(Imm_ExtEx), 
                        .RDEx(RDEx), 
                        .PCEx(PCEx), 
                        .PCplus4Ex(PCplus4Ex),
                        .RS1Ex(RS1Ex),
                        .RS2Ex(RS2Ex)
                        );
    execute_stage EX (
                        .clk(clk), 
                        .rst(rst), 
                        .RegWrtEx(RegWrtEx), 
                        .ALUSrcEx(ALUSrcEx), 
                        .MemWrtEx(MemWrtEx), 
                        .ResultSrcEx(ResultSrcEx), 
                        .BranchEx(BranchEx), 
                        .ALUControlEx(ALUControlEx), 
                        .RD1Ex(RD1Ex), 
                        .RD2Ex(RD2Ex), 
                        .Imm_ExtEx(Imm_ExtEx), 
                        .RDEx(RDEx), 
                        .PCEx(PCEx), 
                        .PCplus4Ex(PCplus4Ex),  
                        .PCSrcEx(PCsrcEx),
                        .PCTargetEx(PCtrgEx), 
                        .RegWrtMem(RegWrtMem), 
                        .MemWrtMem(MemWrtMem), 
                        .ResultSrcMem(ResultSrcMem), 
                        .RD_Mem(RD_Mem), 
                        .PCplus4Mem(PCplus4Mem), 
                        .WriteDataMem(WriteDataMem), 
                        .ALU_ResultMem(ALU_ResultMem),
                        .ResultW(ResultW), 
                        .ForwardA_Ex(ForwardAEx),
                        .ForwardB_Ex(ForwardBEx)
                        );
    
    memwrt_stage MEM (
                    .clk(clk), 
                    .rst(rst), 
                    .RegWrtMem(RegWrtMem), 
                    .MemWrtMem(MemWrtMem), 
                    .ResultSrcMem(ResultSrcMem), 
                    .RD_Mem(RD_Mem), 
                    .PCplus4Mem(PCplus4Mem), 
                    .WriteDataMem(WriteDataMem), 
                    .ALU_ResultMem(ALU_ResultMem), 
                    .RegWriteW(RegWriteW), 
                    .ResultSrcW(ResultSrcW), 
                    .RD_W(RDW), 
                    .PCPlus4W(PCPlus4W), 
                    .ALU_ResultW(ALU_ResultW), 
                    .ReadDataW(ReadDataW)
                    );
                    
    writeback_stage WB (
                    .clk(clk), 
                    .rst(rst), 
                    .ResultSrcW(ResultSrcW), 
                    .PCPlus4W(PCPlus4W), 
                    .ALU_ResultW(ALU_ResultW), 
                    .ReadDataW(ReadDataW), 
                    .ResultW(ResultW) 
                    );

    hazard_unit Forwarding (
                    .rst(rst), 
                    .RegWrtMem(RegWrtMem), 
                    .RegWriteW(RegWriteW), 
                    .RD_Mem(RD_Mem), 
                    .RD_W(RDW), 
                    .RS1Ex(RS1Ex), 
                    .RS2Ex(RS2Ex), 
                    .ForwardAEx(ForwardAEx), 
                    .ForwardBEx(ForwardBEx)
                    );
                    
    


endmodule