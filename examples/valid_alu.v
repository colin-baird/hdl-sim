// Example: Valid Verilog input that should parse successfully
// Tests: ports, wires, regs, assign, always @*, operators, literals, concat, ternary

module alu (
    input wire [7:0] a,
    input wire [7:0] b,
    input [2:0] op,           // implicit wire
    output wire [7:0] result,
    output zero               // implicit wire
);

    // Internal wires
    wire [7:0] sum, diff, and_result;

    // Continuous assignments
    assign sum = a + b;
    assign diff = a - b;
    assign and_result = a & b;

    // Bitwise operations
    assign result = (op == 3'd0) ? sum :
                    (op == 3'd1) ? diff :
                    (op == 3'd2) ? (a | b) :
                    (op == 3'd3) ? (a ^ b) :
                    (op == 3'd4) ? and_result :
                    (op == 3'd5) ? (a << 1) :
                    (op == 3'd6) ? (a >> 1) :
                    8'b00000000;

    // Zero flag
    assign zero = (result == 8'd0) ? 1'b1 : 1'b0;

    // Wire for alu output (was reg but that's only for sequential)
    wire [7:0] alu_out_wire;
    assign alu_out_wire = result;

endmodule
