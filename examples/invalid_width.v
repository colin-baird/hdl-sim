// Example: Invalid - width mismatch in assignment

module bad_width (
    input [7:0] a,
    output [3:0] y
);

    assign y = a;   // ERROR: 8 bits assigned to 4 bits

endmodule
