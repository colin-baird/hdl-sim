// Example: Invalid - negedge not allowed
// This should fail at parse time

module bad_sensitivity (
    input clk,
    input a,
    output y
);

    reg y_reg;

    always @(negedge clk)    // ERROR: negedge not supported
        y_reg <= a;

endmodule
