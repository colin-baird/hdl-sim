// Example: Invalid - assignment to input

module bad_assign_input (
    input a,
    output y
);

    assign a = 1'b0;   // ERROR: cannot assign to input
    assign y = a;

endmodule
