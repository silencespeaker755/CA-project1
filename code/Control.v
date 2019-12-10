// Control unit sending control signals
module Control(
    clk_i,
    rst_i,
    start_i,
    Op_i,
    Zero_i,
    Branch_o,
    MemRead_o,
    MemtoReg_o,
    ALUOp_o,
    MemWrite_o,
    ALUSrc_o,
    RegWrite_o,
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;
input       [6:0]   Op_i;
input               Zero_i;
output              Branch_o;
output              MemRead_o;
output              MemtoReg_o;
output      [1:0]   ALUOp_o;
output              MemWrite_o;
output              ALUSrc_o;
output              RegWrite_o;

// Assignment
assign Branch_o     =   ((Op_i == `BRANCH_TYPE) && Zero_i == 1)?  1:0;
assign MemRead_o    =   (Op_i == `LOAD_TYPE)?    1:0;
assign MemtoReg_o   =   (Op_i == `LOAD_TYPE)?    `MEM:`REG;
assign ALUOp_o      =   (Op_i == `R_TYPE)?       `R_OP:
                        (Op_i == `BRANCH_TYPE)?  `B_OP:`OTHER_OP;
assign MemWrite_o   =   (Op_i == `STORE_TYPE)?   1:0;
assign ALUSrc_o     =   (Op_i == `R_TYPE)?       `REG:
                        (Op_i == `I_TYPE)?       `IMM:
                        (Op_i == `LOAD_TYPE)?    `IMM:
                        (Op_i == `STORE_TYPE)?   `IMM:
                        (Op_i == `BRANCH_TYPE)?  `REG:0;
assign RegWrite_o   =   (Op_i == `R_TYPE)?       1:
                        (Op_i == `I_TYPE)?       1:
                        (Op_i == `LOAD_TYPE)?    1:0;

endmodule
