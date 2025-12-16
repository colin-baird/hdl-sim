// Example: Sequential register with synchronous reset
// Demonstrates always @(posedge clk) with nonblocking assignment

module register (
    input clk,
    input rst,
    input [7:0] d,
    output [7:0] q
);

    reg [7:0] q_reg;
    
    assign q = q_reg;
    
    // Sequential logic: nonblocking assignment only
    always @(posedge clk) q_reg <= rst ? 8'd0 : d;

endmodule
