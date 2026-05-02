module SUB (
    output reg [15:0] out,
    input [15:0] in1,
    input [15:0] in2
);
// The (*) means this block triggers anytime in1 or in2 changes
    always @(*) begin
        out = in1 - in2;
    end
endmodule