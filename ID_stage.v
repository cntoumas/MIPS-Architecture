
module decode_stage (clk, rst, InstrDe, PCDe, PCplus4De, RegWriteW, RDW, ResultW, RegWrtEx, ALUSrcEx, MemWrtEx, ResultSrcEx, BranchEx, ALUControlEx, RD1Ex, RD2Ex, Imm_ExtEx, RDEx, PCEx, PCplus4Ex, RS1Ex, RS2Ex);


    input clk, rst, RegWriteW;
    input [4:0] RDW;
    input [31:0] InstrDe, PCDe, PCplus4De, ResultW;

    output RegWrtEx, ALUSrcEx, MemWrtEx, ResultSrcEx, BranchEx;
    output [2:0] ALUControlEx;
    output [31:0] RD1Ex, RD2Ex, Imm_ExtEx;
    output [4:0] RS1Ex, RS2Ex, RDEx;
    output [31:0] PCEx, PCplus4Ex;

    //------Wires------//
    wire RegWrtDe, ALUSrcDe, MemWrtDe, ResultSrcDe, BranchDe;
    wire [1:0] ImmSrcDe;
    wire [2:0] ALUControlDe;
    wire [31:0] RD1De, RD2De, Imm_ExtDe;

    //------Registers------//
    reg RegWrtDe_r, ALUSrcDe_r, MemWrtDe_r, ResultSrcDe_r, BranchDe_r;
    reg [2:0] ALUControlDe_r;
    reg [31:0] RD1De_r, RD2De_r, Imm_ExtDe_r;
    reg [4:0] RDDe_r, RS1De_r, RS2De_r;
    reg [31:0] PCDe_r, PCplus4De_r;

    //------Modules------//

    // Control Unit

    Ctrl_Unit control_unit (
        .Op(InstrDe[6:0]),
        .RegWrt(RegWrtDe),
        .ImmSrc(ImmSrcDe),
        .ALUSrc(ALUSrcDe),
        .MemWrt(MemWrtDe),
        .ResultSrc(ResultSrcDe),
        .Branch(BranchDe),
        .funct3(InstrDe[14:12]),
        .funct7(InstrDe[31:25]),
        .ALUControl(ALUControlDe)
    );

    // Register File    

    Register_File rf (
        .clk(clk),
        .rst(rst),
        .WEx3(RegWriteW),
        .WDe3(ResultW),
        .A1(InstrDe[19:15]),
        .A2(InstrDe[24:20]),
        .A3(RDW),
        .RD1(RD1De),
        .RD2(RD2De)
    );

    // Sign Extension

    Sign_Extend extension (
        .In(InstrDe[31:0]),
        .Imm_Ext(Imm_ExtDe),
        .ImmSrc(ImmSrcDe)
    );

    //------Register Logic------//

    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            RegWrtDe_r <= 1'b0;
            ALUSrcDe_r <= 1'b0;
            MemWrtDe_r <= 1'b0;
            ResultSrcDe_r <= 1'b0;
            BranchDe_r <= 1'b0;
            ALUControlDe_r <= 3'b000;
            RD1De_r <= 32'h00000000;
            RD2De_r <= 32'h00000000;
            Imm_ExtDe_r <= 32'h00000000;
            RDDe_r <= 5'h00;
            PCDe_r <= 32'h00000000;
            PCplus4De_r <= 32'h00000000;
            RS1De_r <= 5'h00;
            RS2De_r <= 5'h00;
        end 
        else begin
            RegWrtDe_r <= RegWrtDe;
            ALUSrcDe_r <= ALUSrcDe;
            MemWrtDe_r <= MemWrtDe;
            ResultSrcDe_r <= ResultSrcDe;
            BranchDe_r <= BranchDe;
            ALUControlDe_r <= ALUControlDe;
            RD1De_r <= RD1De;
            RD2De_r <= RD2De;
            Imm_ExtDe_r <= Imm_ExtDe;
            RDDe_r <= InstrDe[11:7];
            RS1De_r <= InstrDe[19:15];
            RS2De_r <= InstrDe[24:20];
            PCDe_r <= PCDe;
            PCplus4De_r <= PCplus4De; 
        end
    end
    //------Output Logic------//
    assign RegWrtEx = RegWrtDe_r;
    assign ALUSrcEx = ALUSrcDe_r;
    assign MemWrtEx = MemWrtDe_r;
    assign ResultSrcEx = ResultSrcDe_r;
    assign BranchEx = BranchDe_r;
    assign ALUControlEx = ALUControlDe_r;
    assign RD1Ex = RD1De_r;
    assign RD2Ex = RD2De_r;
    assign Imm_ExtEx = Imm_ExtDe_r;
    assign RDEx = RDDe_r;
    assign PCEx = PCDe_r;
    assign PCplus4Ex = PCplus4De_r;
    assign RS1Ex = RS1De_r;
    assign RS2Ex = RS2De_r;
endmodule



            
