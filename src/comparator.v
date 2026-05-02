module COMPARE (
    output lt, gt, eq,
    input [15:0] data1, 
    input [15:0] data2
);
    // Continuous assignment for simple logic checks
    assign lt = (data1 < data2);
    assign gt = (data1 > data2);
    assign eq = (data1 == data2);
endmodule