// ALU with registered output
module test_alu(
    input clk,
    input [7:0] a,
    input [7:0] b,
    input [2:0] op,
    output [7:0] result,
    output zero
);
    wire [7:0] sum;
    wire [7:0] diff;
    wire [7:0] and_result;
    wire [7:0] alu_out;
    reg [7:0] result_reg;
    
    assign sum = a + b;
    assign diff = a - b;
    assign and_result = a & b;
    
    assign alu_out = (op == 3'd0) ? sum :
                     (op == 3'd1) ? diff :
                     (op == 3'd2) ? (a | b) :
                     (op == 3'd3) ? (a ^ b) :
                     (op == 3'd4) ? and_result :
                     (op == 3'd5) ? (a << 1'd1) :
                     (op == 3'd6) ? (a >> 1'd1) : 8'd0;
    
    assign result = result_reg;
    assign zero = (result_reg == 8'd0) ? 1'd1 : 1'd0;
    
    always @(posedge clk) result_reg <= alu_out;
endmodule
