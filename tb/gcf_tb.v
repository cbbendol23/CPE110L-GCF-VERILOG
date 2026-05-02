`timescale 1ns / 1ps

module gcf_tb;

    // 1. Declare signals (Inputs are 'reg', Outputs are 'wire')
    reg clk;
    reg start;
    reg [15:0] data_in;
    
    wire done;
    
    // (We will instantiate the Top Module here later)

    // 2. Generate the Clock (flips every 5 nanoseconds)
    always #5 clk = ~clk;

    // 3. The actual test sequence
    initial begin
        // --- GTKWAVE SETUP ---
        $dumpfile("gcf_sim.vcd");    // Names the output file
        $dumpvars(0, gcf_tb);        // Tells GTKWave to track EVERYTHING in this testbench
        // ---------------------

        // Initialize signals
        clk = 0;
        start = 0;
        data_in = 0;

        // (We will add the actual GCF test inputs here later)

        // Stop the simulation after enough time has passed
        #1000; 
        $finish;
    end

endmodule