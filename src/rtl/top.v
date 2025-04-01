module top (
    input wire clk,
    input wire reset
);

    // Wires to connect IF and ID stages
    wire [31:0] instr;
    wire [31:0] pc_if_to_id;
    wire [31:0] rs1_data, rs2_data;
    wire [4:0] rd;
    wire [31:0] imm;
    wire [31:0] pc_id_to_ex;

    // Instantiate IF stage
    if_stage if_stage_inst (
        .clk(clk),
        .reset(reset),
        .pc_in(32'b0), // Placeholder for branch/jump (not used yet)
        .instr(instr),
        .pc_out(pc_if_to_id)
    );

    // Instantiate ID stage
    id_stage id_stage_inst (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .pc_in(pc_if_to_id),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .rd(rd),
        .imm(imm),
        .pc_out(pc_id_to_ex)
    );

endmodule