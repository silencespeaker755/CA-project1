// Pipeline register for IF/ID
module IF_ID(
    clk_i,
    rst_i,
    start_i,
    pc_i,
    instr_i,
    pc_o,
    instr_o
);

// Ports
input           clk_i;
input           rst_i;
input           start_i;
input   [31:0]  pc_i;
input   [31:0]  instr_i;
output  [31:0]  pc_o;
output  [31:0]  instr_o;

endmodule
