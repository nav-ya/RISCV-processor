module top_tb;

    // Inputs
    reg clk;
    reg reset;

    // Instantiate the top module
    top uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns period

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Reset the module
        #10;
        reset = 0;

        // Run for a few cycles
        #50;

        // Finish simulation
        $finish;
    end

    // Monitor outputs (you can add more signals to monitor)
    initial begin
        $monitor("Time=%0t | reset=%b | PC=%h | Instruction=%h | rs1_data=%h | rs2_data=%h | rd=%h | imm=%h", 
                 $time, reset, uut.pc_if_to_id, uut.if_stage_inst.instr, 
                 uut.id_stage_inst.rs1_data, uut.id_stage_inst.rs2_data, 
                 uut.id_stage_inst.rd, uut.id_stage_inst.imm);
    end

endmodule