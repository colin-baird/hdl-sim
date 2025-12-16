// Test counter with reset
module test_counter(
    input clk,
    input rst,
    output [7:0] count
);
    reg [7:0] count_reg;
    
    assign count = count_reg;
    
    always @(posedge clk) count_reg <= rst ? 8'd0 : count_reg + 8'd1;
endmodule
