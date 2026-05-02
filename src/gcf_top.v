module GCF_Top (
    input clk,
    input reset,
    input start,
    input [15:0] data_in,
    output done
);

    // Internal wires acting as the "nervous system" between Brain and Body
    wire lt, gt, eq;
    wire ldA, ldB, sel1, sel2, sel_in;

    // 1. Instantiate the Brain (Controller)
    GCF_controller controller_inst (
        .clk(clk),
        .reset(reset),
        .start(start),
        .lt(lt),
        .gt(gt),
        .eq(eq),
        .ldA(ldA),
        .ldB(ldB),
        .sel1(sel1),
        .sel2(sel2),
        .sel_in(sel_in),
        .done(done)
    );

    // 2. Instantiate the Body (Datapath)
    GCF_datapath datapath_inst (
        .clk(clk),
        .data_in(data_in),
        .ldA(ldA),
        .ldB(ldB),
        .sel1(sel1),
        .sel2(sel2),
        .sel_in(sel_in),
        .lt(lt),
        .gt(gt),
        .eq(eq)
    );

endmodule