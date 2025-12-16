// Example: Valid simple module
// Tests: basic structure, port declarations, simple assign

module mux2 (
    input a,
    input b,
    input sel,
    output y
);

    assign y = sel ? b : a;

endmodule
