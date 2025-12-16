// Example: Invalid - multiple drivers for same signal

module bad_multi_driver (
    input a,
    input b,
    output y
);

    assign y = a;
    assign y = b;   // ERROR: y already has a driver

endmodule
