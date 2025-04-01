module top (
    input wire clk,
    input wire reset
);

    // Wires to connect IF and ID stages
    wire [31:0] instr_if;
    wire [31:0] pc_if;
    wire [31:0] rs1_data, rs2_data;
    wire [4:0] rd;
    wire [31:0] imm;
    wire [31:0] pc_id_to_ex;

    // Pipeline registers between IF and ID
    reg [31:0] instr_if_id;
    reg [31:0] pc_if_id;

    // IF stage
    if_stage if_stage_inst (
        .clk(clk),
        .reset(reset),
        .pc_in(32'b0), // Placeholder for branch/jump (not used yet)
        .instr(instr_if),
        .pc_out(pc_if)
    );

    // Pipeline register update (IF to ID)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            instr_if_id <= 32'b0;
            pc_if_id <= 32'b0;
        end else begin
            instr_if_id <= instr_if;
            pc_if_id <= pc_if;
        end
    end

    // ID stage
    id_stage id_stage_inst (
        .clk(clk),
        .reset(reset),
        .instr(instr_if_id), // Use pipelined instruction
        .pc_in(pc_if_id),    // Use pipelined PC
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .rd(rd),
        .imm(imm),
        .pc_out(pc_id_to_ex)
    );

endmodule