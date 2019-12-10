// Pipeline register for IF/ID
module IF_ID(
    clk_i,
    rst_i,
    start_i,
    stall_i,
    flush_i,
    pc_i,
    instr_i,
    pc_o,
    instr_o
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;
input               stall_i;
input               flush_i;
input       [31:0]  pc_i;
input       [31:0]  instr_i;
output      [31:0]  pc_o;
output      [31:0]  instr_o;

reg         [31:0]  reg_pc_o;
reg         [31:0]  reg_instr_o;

assign pc_o    = reg_pc_o;
assign instr_o = reg_instr_o;

initial begin
#(`CYCLE_TIME/10)
    reg_pc_o    = 32'b0;
    reg_instr_o = 32'b0;
end

always@(posedge clk_i) begin
    if(stall_i) begin
        reg_pc_o <= pc_o;
        reg_instr_o <= instr_o;
    end
    else if(flush_i) begin
        reg_pc_o <= 32'b0;
        reg_instr_o <= 32'b0;
    end
    else begin
        reg_pc_o <= pc_i;
        reg_instr_o <= instr_i;
    end
end

endmodule
