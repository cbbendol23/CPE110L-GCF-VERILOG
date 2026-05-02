module GCF_controller (
    input clk, reset, start,
    input lt, gt, eq,
    output reg ldA, ldB, sel1, sel2, sel_in,
    output reg done
);
    // Define states using localparam for clarity
    localparam S0 = 3'b000, // Wait for start
               S1 = 3'b001, // Load A
               S2 = 3'b010, // Load B
               S3 = 3'b011, // Compare and Select Path
               S4 = 3'b100, // Update A (A = A - B)
               S5 = 3'b101, // Update B (B = B - A)
               S6 = 3'b110; // Done

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            case (state)
                S0: if (start) state <= S1;
                S1: state <= S2;
                S2: state <= S3;
                S3: begin
                    if (eq) state <= S6;
                    else if (lt) state <= S5; // B is bigger
                    else if (gt) state <= S4; // A is bigger
                end
                S4: state <= S3; // Return to compare
                S5: state <= S3; // Return to compare
                S6: if (!start) state <= S0;
                default: state <= S0;
            endcase
        end
    end

    // Control Logic (Outputs based on current state)
    always @(*) begin
        // Default values to avoid latches
        ldA = 0; ldB = 0; sel1 = 0; sel2 = 0; sel_in = 0; done = 0;
        
        case (state)
            S1: begin ldA = 1; sel_in = 1; end // Initial Load A from data_in
            S2: begin ldB = 1; sel_in = 1; end // Initial Load B from data_in
            S4: begin // A = A - B
                sel1 = 0; // Select Aout
                sel2 = 1; // Select Bout
                ldA = 1;  // Load result into A
                sel_in = 0; // Take result from Subtractor
            end
            S5: begin // B = B - A
                sel1 = 1; // Select Bout
                sel2 = 0; // Select Aout
                ldB = 1;  // Load result into B
                sel_in = 0; // Take result from Subtractor
            end
            S6: done = 1;
        endcase
    end
endmodule