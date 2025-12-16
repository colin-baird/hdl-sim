// Example: Invalid - x/z digits not allowed
// This should fail at lexer time

module bad_xz (
    input a,
    output y
);

    assign y = 8'bxxxx_0000;   // ERROR: x digits not allowed

endmodule
