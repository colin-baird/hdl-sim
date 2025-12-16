// Example: Invalid - combinational cycle
// a depends on b, b depends on a

module bad_cycle (
    input x,
    output y
);

    wire a, b;
    
    assign a = b & x;
    assign b = a | x;
    assign y = b;

endmodule
