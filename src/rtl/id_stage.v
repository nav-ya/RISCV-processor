module id_stage (
    input wire clk,              // Clock signal
    input wire reset,            // Reset signal
    input wire [31:0] instr,     // Instruction from IF stage
    input wire [31:0] pc_in,     // PC from IF stage
    output reg [31:0] rs1_data,  // Data from register rs1
    output reg [31:0] rs2_data,  // Data from register rs2
    output reg [4:0] rd,         // Destination register
    output reg [31:0] imm,       // Immediate value
    output reg [31:0] pc_out     // PC to next stage
);

    // Register file (32 registers, 32-bit each)
    reg [31:0] reg_file [0:31];

    // Instruction fields
    wire [6:0] opcode;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;

    // Extract instruction fields
    assign opcode = instr[6:0];
    assign rd     = instr[11:7];
    assign rs1    = instr[19:15];
    assign rs2    = instr[24:20];
    assign funct3 = instr[14:12];
    assign funct7 = instr[31:25];

    // Immediate generation (simplified for I-type instructions)
    wire [31:0] imm_i_type;
    assign imm_i_type = {{20{instr[31]}}, instr[31:20]}; // Sign-extend 12-bit immediate

    // Initialize register file (for testing)
    initial begin
        reg_file[0] = 32'h0;      // x0 is always 0
        reg_file[1] = 32'h5;      // x1 = 5
        reg_file[2] = 32'hA;      // x2 = 10
        // Add more initial values as needed
    end

    // Sequential logic: Decode instruction and read register file
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            rs1_data <= 32'b0;
            rs2_data <= 32'b0;
            rd       <= 5'b0;
            imm      <= 32'b0;
            pc_out   <= 32'b0;
        end else begin
            // Read register file
            rs1_data <= reg_file[rs1];
            rs2_data <= reg_file[rs2];

            // Ensure x0 is always 0
            if (rs1 == 5'b0) rs1_data <= 32'h0;
            if (rs2 == 5'b0) rs2_data <= 32'h0;

            // Pass through rd and PC
            rd <= rd;
            pc_out <= pc_in;

            // Generate immediate (simplified for I-type for now)
            case (opcode)
                7'b0010011: imm <= imm_i_type; // I-type (e.g., addi)
                default: imm <= 32'b0;         // Others (to be expanded)
            endcase
        end
    end

endmodule