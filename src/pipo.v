module PIPO (
    output reg [15:0] data_out,
    input [15:0] data_in,
    input load, 
    input clk
);
    // On the rising edge of the clock, 
    // if 'load' is high, the data is saved into the register.
    always @(posedge clk) begin
        if (load)
            data_out <= data_in;
    end
endmodule