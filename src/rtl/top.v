module top (
    input clk, reset
);
    // Pipeline stages
    wire [31:0] instr, pc;
    wire [31:0] reg_data1, reg_data2, alu_result, mem_data;
    wire [4:0] rd;
    wire [6:0] opcode;

    // IF Stage
    instruction_fetch IF_stage (
        .clk(clk),
        .reset(reset),
        .pc_out(pc),
        .instr_out(instr)
    );

    // ID Stage
    instruction_decode ID_stage (
        .clk(clk),
        .instr(instr),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2),
        .opcode(opcode),
        .rd(rd)
    );

    // EX Stage
    execute EX_stage (
        .clk(clk),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2),
        .alu_result(alu_result)
    );

    // MEM Stage
    memory_access MEM_stage (
        .clk(clk),
        .alu_result(alu_result),
        .mem_data(mem_data)
    );

    // WB Stage
    write_back WB_stage (
        .clk(clk),
        .mem_data(mem_data),
        .rd(rd)
    );

endmodule
