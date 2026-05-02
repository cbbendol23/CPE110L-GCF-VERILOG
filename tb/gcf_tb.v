`timescale 1ns / 1ps

module gcf_tb;

    reg clk;
    reg reset;
    reg start;
    reg [15:0] data_in;
    wire done;

    // Instantiate the Top Module
    GCF_Top uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .data_in(data_in),
        .done(done)
    );

    // Generate a clock (10ns period)
    always #5 clk = ~clk;

    initial begin
        // GTKWave Setup
        $dumpfile("gcf_sim.vcd");
        $dumpvars(0, gcf_tb);

        // 1. Initialize System
        clk = 0;
        reset = 1;
        start = 0;
        data_in = 0;

        // 2. Release Reset
        #10 reset = 0;

        // 3. Pulse the Start button
        #10 start = 1;

        // 4. Feed Input A (Wait for FSM to enter State 1)
        #10 data_in = 16'd24; 

        // 5. Feed Input B (Wait for FSM to enter State 2)
        #10 data_in = 16'd36; 
        
        // Turn off start switch so it doesn't loop infinitely
        #10 start = 0;        

        // 6. Wait for the 'done' signal to go HIGH
        wait(done == 1);
        
        // Let it run for just a tiny bit longer to see the final result clearly
        #20;
        
        $display("GCF Calculation Complete!");
        $finish;
    end

endmodule