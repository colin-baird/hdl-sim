// Example: Invalid - blocking assignment in always @(posedge clk)
// Only nonblocking (<= ) should be allowed in sequential blocks

module bad_blocking (
    input clk,
    input a,
    output y
);

    reg y_reg;

    always @(posedge clk) y_reg = a;    // ERROR: should use <= not =

endmodule
