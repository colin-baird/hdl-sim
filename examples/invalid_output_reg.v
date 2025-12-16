// Example: Invalid - output reg is not allowed
// This should fail at parse time with an error about output reg

module bad_output_reg (
    input [7:0] a,
    output reg [7:0] y   // ERROR: output reg not allowed
);

    assign y = a;

endmodule
