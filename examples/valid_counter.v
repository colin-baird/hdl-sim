// Example: Valid sequential logic with posedge clk
// Tests: always @(posedge clk) with nonblocking assignment

module counter (
    input clk,
    input rst,
    input [7:0] load_val,
    output [7:0] count
);

    reg [7:0] count_reg;
    
    assign count = count_reg;
    
    always @(posedge clk) count_reg <= rst ? 8'd0 : count_reg + 8'd1;

endmodule
