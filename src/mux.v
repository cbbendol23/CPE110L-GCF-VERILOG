module MUX (
    output [15:0] out,
    input [15:0] in0,
    input [15:0] in1,
    input sel
);
    // If sel is 0, output in0. If sel is 1, output in1.
    assign out = sel ? in1 : in0;
endmodule