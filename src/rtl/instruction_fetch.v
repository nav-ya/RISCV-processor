module if_stage (
    input wire clk,              // Clock signal
    input wire reset,            // Reset signal
    output reg [31:0] instr,     // Instruction fetched
    output reg [31:0] pc_out,    // PC value to next stage
    input wire [31:0] pc_in      // For future branch/jump support (not used yet)
);

    reg [31:0] pc;              // Program Counter
    reg [31:0] instr_mem [0:255]; // Simple instruction memory (256 words)

    // Initialize instruction memory (for testing)
    initial begin
        instr_mem[0] = 32'h00000013; // nop (addi x0, x0, 0)
        instr_mem[1] = 32'h00108093; // addi x1, x1, 1
        instr_mem[2] = 32'h00210113; // addi x2, x2, 2
        instr_mem[3] = 32'h00318193; // addi x3, x3, 3
        instr_mem[4] = 32'h00420213; // addi x4, x4, 4
    end

    // Sequential logic: Update PC and fetch instruction
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 32'b0;        // Reset PC to 0
            instr <= 32'b0;
            pc_out <= 32'b0;
        end else begin
            pc <= pc + 4;       // Increment PC by 4
            instr <= instr_mem[pc >> 2]; // Fetch instruction (divide by 4 for word address)
            pc_out <= pc;       // Pass current PC to next stage
        end
    end

endmodule