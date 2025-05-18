`include "MUX.v"
`include "PC_add.v"
`include "InstrMem.v"
`include "ProgrammCounter.v"

module fetch_stage(clk, rst, PCsrcEx, PCtrgEx, InstrDe, PCDe, PCplus4De);
    input clk, rst;
    input PCsrcEx;
    input [31:0] PCtrgEx;
    output [31:0] InstrDe;
    output [31:0] PCDe, PCplus4De;

    //------Wires------//
    wire [31:0] PC_Fe, PCFe, PCplus4Fe;
    wire [31:0] InstrFe;

    //------Registers------//
    reg [31:0] InstrFe_reg;
    reg [31:0] PCFe_reg, PCplus4Fe_reg; 

    //------Modules------//

    // PC Mux

    MUX PC_MUX (
        .a(PCplus4Fe),
        .b(PCtrgEx),
        .sel(PCsrcEx),
        .c(PC_F)
    );

    // PC Counter   

    Program_Counter ProgramCounter (
        .clk(clk),
        .rst(rst),
        .PC(PCFe),
        .PC_Next(PC_Fe)
    );

    // Instruction Memory

    Instruction_Memory IMEM (
        .rst(rst),
        .A(PCFe),
        .RD(InstrFe)
    );

    // PC adder

    PC_adder PC_Adder (
        .a(PCFe),
        .b(32'h00000004),
        .c(PCplus4Fe)
    );

    //------Fetch Stage Register Logic------//

    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            InstrFe_reg <= 32'h00000000;
            PCFe_reg <= 32'h00000000;
            PCplus4Fe_reg <= 32'h00000000;
        end
        else begin
            InstrFe_reg <= InstrFe;
            PCFe_reg <= PCFe;
            PCplus4Fe_reg <= PCplus4Fe;
        end
    end

    //------Assigning Registers Value to the Output port------//
    assign  InstrDe = (rst == 1'b0) ? 32'h00000000 : InstrFe_reg;
    assign  PCFe = (rst == 1'b0) ? 32'h00000000 : PCFe_reg;
    assign  PCplus4De = (rst == 1'b0) ? 32'h00000000 : PCplus4Fe_reg;

endmodule