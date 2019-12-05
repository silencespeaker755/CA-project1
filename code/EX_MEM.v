// EX/MEM pipeline registers
module EX_MEM(
    clk_i,
    ALUResult_i,
    RS2data_i,
    Zero_i,
    pc_branch_i,
    Branch_i,
    MemRead_i,
    MemtoReg_i,
    MemWrite_i,
    RegWrite_i,
    ALUResult_o,
    RS2data_o,
    Zero_o,
    pc_branch_o,
    Branch_o,
    MemRead_o,
    MemtoReg_o,
    MemWrite_o,
    RegWrite_o,
);

// Ports
input               clk_i;
input   [31:0]      ALUResult_i;
input   [31:0]      RS2data_i;
input               Zero_i;
input   [31:0]      pc_branch_i;
input               Branch_i;
input               MemRead_i;
input               MemtoReg_i;
input               MemWrite_i;
input               RegWrite_i;
output  [31:0]      ALUResult_o;
output  [31:0]      RS2data_o;
output              Zero_o;
output  [31:0]      pc_branch_o;
output              Branch_o;
output              MemRead_o;
output              MemtoReg_o;
output              MemWrite_o;
output              RegWrite_o;
// Wires and Registers
// Assignment

endmodule
