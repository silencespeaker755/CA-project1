// Op_i type
`define R_TYPE      7'b0110011
`define I_TYPE      7'b0010011
`define LOAD_TYPE   7'b0000011
`define STORE_TYPE  7'b0100011
`define BRANCH_TYPE 7'b1100011
// MemtoReg constant
`define MEM         1'b0
`define REG         1'b1
// ALUOp constant
`define RI_TYPE     2'b10
`define OTHER       2'b00
// ALUCtrl constant
`define ADD         3'b010
`define SUB         3'b110
`define MUL         3'b011
`define AND         3'b000
`define OR          3'b001
// ALUSrc constant
`define RS2         1'b0
`define IMM         1'b1

module CPU
(
    clk_i, 
    start_i
);

// Ports
input         clk_i;
input         start_i;

PC PC(
    .clk_i          (),
    .start_i        (),
    .PCWrite_i      (),
    .pc_i           (),
    .pc_o           ()
);

Instruction_Memory Instruction_Memory(
    .addr_i         (),
    .instr_o        ()
);

Registers Registers(
    .clk_i          (),
    .RS1addr_i      (),
    .RS2addr_i      (),
    .RDaddr_i       (),
    .RDdata_i       (),
    .RegWrite_i     (),
    .RS1data_o      (),
    .RS2data_o      ()
);

Data_Memory Data_Memory(
    .clk_i          (),

    .addr_i         (),
    .MemWrite_i     (),
    .data_i         (),
    .data_o         ()
);

endmodule

