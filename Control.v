// Control unit sending control signals
module Control(
    Op_i,
    Branch_o,
    MemRead_o,
    MemtoReg_o,
    ALUOp_o,
    MemWrite_o,
    ALUSrc_o,
    RegWrite_o
);

// Ports
input   [6:0]   Op_i;
output          Branch_o;
output          MemRead_o;
output          MemtoReg_o;
output  [1:0]   ALUOp_o;
output          MemWrite_o;
output          ALUSrc_o;
output          RegWrite_o;

// Assignment
assign  Branch_o    =   (Op_i == BRANCH_TYPE)?   1:0;
assign  MemRead_o   =   (Op_i == LOAD_TYPE)?     1:0;

endmodule
