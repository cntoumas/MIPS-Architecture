`include "RAM.v"

module memwrt_stage (clk, rst, RegWrtMem, MemWrtMem, ResultSrcMem, RD_Mem, PCplus4Mem, WriteDataMem, ALU_ResultMem);
    
    input clk, rst, RegWrtMem, MemWrtMem, ResultSrcMem;
    input [4:0] RD_Mem; 
    input [31:0] PCplus4Mem, WriteDataMem, ALU_ResultMem;

    output RegWriteW, ResultSrcW; 
    output [4:0] RD_W;
    output [31:0] PCPlus4W, ALU_ResultW, ReadDataW;

    //--------Wires------//

    wire [31:0] ReadDataMem;

    //--------Registers------//
    reg RegWrtMem_r, ResultSrcMem_r;
    reg [4:0] RDMem_r;
    reg [31:0] PCplus4Mem_r, ALU_ResultMem_r, ReadDataMem_r;

    //--------Modules------//

    // RAM Module

    RAM RAM (
        .clk(clk),
        .rst(rst),
        .WE(MemWrtMem),
        .A(ALU_ResultMem),
        .WD(WriteDataMem),
        .RD(ReadDataMem)
    );

    //Register Logic
    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            RegWrtMem_r <= 1'b0; 
            ResultSrcMem_r <= 1'b0;
            RDMem_r <= 5'h00;
            PCplus4Mem_r <= 32'h00000000; 
            ALU_ResultMem_r <= 32'h00000000; 
            ReadDataMem_r <= 32'h00000000;
        end
        else begin
            RegWrtMem_r <= RegWrtMem; 
            ResultSrcMem_r <= ResultSrcMem;
            RDMem_r <= RD_Mem;
            PCplus4Mem_r <= PCplus4Mem; 
            ALU_ResultMem_r <= ALU_ResultMem; 
            ReadDataMem_r <= ReadDataMem;
        end
    end

    //Output logic

    assign RegWriteW = RegWrtMem_r;
    assign ResultSrcW = ResultSrcMem_r;
    assign RD_W = RDMem_r;
    assign PCPlus4W = PCplus4Mem_r;
    assign ALU_ResultW = ALU_ResultMem_r;
    assign ReadDataW = ReadDataMem_r;

endmodule