
module PC_module (clk, rst, PC, PC_Next);

    input clk, rst;
    input [31:0] PC_Next;
    output [31:0] PC;
    reg [31:0] PC;

    always @(posedge clk or negedge rst)
    begin
        if(!rst)
            PC <= 0;
        else
            PC <= PC_Next;
    end
    
endmodule
