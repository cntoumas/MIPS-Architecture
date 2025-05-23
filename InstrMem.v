module Instruction_Memory(rst, A, RD);
    input rst;
    input [31:0] A;
    output [31:0] RD;

    reg [31:0] memory[1023:0];

    assign RD = (rst == 1'b0) ? 32'h00000000 : memory[A[31:2]];

    initial begin
        $readmemh("memfile.hex", memory);
    end
endmodule

    
