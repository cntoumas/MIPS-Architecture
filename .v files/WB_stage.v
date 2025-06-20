
module writeback_stage (clk, rst, ResultSrcW, PCPlus4W, ALU_ResultW, ReadDataW, ResultW);

    input clk, rst, ResultSrcW;
    input [31:0] PCPlus4W, ALU_ResultW, ReadDataW;

    output [31:0] ResultW;

 //--------Modules------//

     Mux final_mux (
        .a(ALU_ResultW),
        .b(ReadDataW),
        .sel(ResultSrcW),
        .c(ResultW)
      );  
      
endmodule
