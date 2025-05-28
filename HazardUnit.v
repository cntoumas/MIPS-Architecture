module hazard_unit(rst, RegWrtMem, RegWriteW, RD_Mem, RD_W, RS1Ex, RS2Ex, ForwardAEx, ForwardBEx);

    input rst, RegWrtMem, RegWriteW;
    input [4:0] RD_Mem, RD_W, RS1Ex, RS2Ex;
    output [1:0] ForwardAEx, ForwardBEx;

    assign ForwardAEx = (rst == 1'b0) ? 2'b00 : 
                       ((RegWrtMem == 1'b1) & (RD_Mem != 5'h00) & (RD_Mem == RS1Ex)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS1Ex)) ? 2'b01 : 2'b00;
                       
    assign ForwardBEx = (rst == 1'b0) ? 2'b00 : 
                       ((RegWrtMem == 1'b1) & (RD_Mem != 5'h00) & (RD_Mem == RS2Ex)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS2Ex)) ? 2'b01 : 2'b00; 

endmodule