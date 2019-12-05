// ID/EX pipeline register
module ID_EX(
    pc_i,
    Branch_i,
    MemRead_i,
    MemtoReg_i,
    ALUOp_i,
    MemWrite_i,
    ALUSrc_i,
    RegWrite_i,
    funct_i,
    RS1data_i, 
    RS2data_i, 
    imm_i,

    pc_o,
    Branch_o,
    MemRead_o,
    MemtoReg_o,
    ALUOp_o,
    MemWrite_o,
    ALUSrc_o,
    RegWrite_o,
    funct_o,
    RS1data_o, 
    RS2data_o, 
    imm_o,
);
// Port
input   [31:0]  pc_i;
input           Branch_i;
input           MemRead_i;
input           MemtoReg_i;
input   [1:0]   ALUOp_i;
input           MemWrite_i;
input           ALUSrc_i;
input           RegWrite_i;
input   [9:0]   funct_i;
input   [31:0]  RS1data_i;
input   [31:0]  RS2data_i;
input   [31:0]  imm_i;

output  [31:0]  pc_o;
output          Branch_o;
output          MemRead_o;
output          MemtoReg_o;
output  [1:0]   ALUOp_o;
output          MemWrite_o;
output          ALUSrc_o;
output          RegWrite_o;
output  [9:0]   funct_o;
output  [31:0]  RS1data_o;
output  [31:0]  RS2data_o;
output  [31:0]  imm_o;
// Wires and Registers
// Assignment
endmodule
