module GCF_datapath (
    output wire lt, gt, eq,          
    input wire [15:0] data_in,       
    input wire ldA, ldB,             
    input wire sel1, sel2, sel_in,   
    input wire clk
);

    // Internal wires
    wire [15:0] Aout, Bout;
    wire [15:0] x, y;
    wire [15:0] Subout;
    wire [15:0] bus_in;

    MUX MUX_load (
        .out(bus_in), 
        .in0(Subout), 
        .in1(data_in), 
        .sel(sel_in)
    );

    PIPO Reg_A (
        .data_out(Aout), 
        .data_in(bus_in), 
        .load(ldA), 
        .clk(clk)
    );
    
    PIPO Reg_B (
        .data_out(Bout), 
        .data_in(bus_in), 
        .load(ldB), 
        .clk(clk)
    );

    MUX MUX_IN1 (
        .out(x), 
        .in0(Aout), 
        .in1(Bout), 
        .sel(sel1)
    );
    
    MUX MUX_IN2 (
        .out(y), 
        .in0(Aout), 
        .in1(Bout), 
        .sel(sel2)
    );

    COMPARE COMP (
        .lt(lt), 
        .gt(gt), 
        .eq(eq), 
        .data1(Aout), 
        .data2(Bout)
    );

    SUB SB (
        .out(Subout), 
        .in1(x), 
        .in2(y)
    );

endmodule