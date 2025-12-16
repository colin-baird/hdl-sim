// Example: Invalid - begin/end blocks are not allowed
// This should fail at parse time

module bad_begin_end (
    input a,
    input b,
    output y
);

    // begin/end at module level - rejected
    begin    // ERROR: begin/end not allowed
        assign y = a & b;
    end

endmodule
