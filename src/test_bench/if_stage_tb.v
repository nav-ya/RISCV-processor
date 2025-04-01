module if_stage_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] pc_in;

    // Outputs
    wire [31:0] instr;
    wire [31:0] pc_out;

    // Instantiate the IF stage
    if_stage uut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .instr(instr),
        .pc_out(pc_out)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns period

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        pc_in = 0;

        // Reset the module
        #10;
        reset = 0;

        // Run for a few cycles
        #50;

        // Finish simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | reset=%b | PC=%h | Instruction=%h", $time, reset, pc_out, instr);
    end

endmodule