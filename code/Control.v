// Control unit sending control signals
module Control(
    Op_i,
    Zero_i,
    Branch_o,
    MemRead_o,
    MemtoReg_o,
    ALUOp_o,
    MemWrite_o,
    ALUSrc_o,
    RegWrite_o
);

// Ports
input           [6:0]   Op_i;
input                   Zero_i;
output  reg             Branch_o;
output  reg             MemRead_o;
output  reg             MemtoReg_o;
output  reg     [1:0]   ALUOp_o;
output  reg             MemWrite_o;
output  reg             ALUSrc_o;
output  reg             RegWrite_o;

// Assignment
always@(Op_i) begin
    Branch_o    =   ((Op_i == `BRANCH_TYPE) && Zero_i)?  1:0;
    MemRead_o   =   (Op_i == `LOAD_TYPE)?    1:0;
    MemtoReg_o  =   (Op_i == `LOAD_TYPE)?    `MEM:`REG;
    ALUOp_o     =   (Op_i == `R_TYPE)?       `R_OP:
                    (Op_i == `BRANCH_TYPE)?  `B_OP:
                    `OTHER_OP;
    MemWrite_o  =   (Op_i == `STORE_TYPE)?   1:0;
    ALUSrc_o    =   (Op_i == `R_TYPE)?       `REG:
                    (Op_i == `I_TYPE)?       `IMM:
                    (Op_i == `LOAD_TYPE)?    `IMM:
                    (Op_i == `STORE_TYPE)?   `IMM:
                    (Op_i == `BRANCH_TYPE)?  `REG:0;
    RegWrite_o  =   (Op_i == `R_TYPE)?       1:
                    (Op_i == `I_TYPE)?       1:
                    (Op_i == `LOAD_TYPE)?    1:0;
end

endmodule
