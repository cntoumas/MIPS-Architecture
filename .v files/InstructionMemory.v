module instruction_memory(rst, A, RD);
    input rst;
    input [31:0] A;
    output [31:0] RD;

    reg [31:0] memory[1023:0];

    initial begin
        $readmemh("memfile.hex", memory);
    end

    assign RD = (rst == 1'b0) ? {32{1'b0}} : memory[A[31:2]];

    
    
endmodule

    
