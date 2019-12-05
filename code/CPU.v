// Constant
// Op_i type
`define R_TYPE      7'b0110011
`define I_TYPE      7'b0010011
`define LOAD_TYPE   7'b0000011
`define STORE_TYPE  7'b0100011
`define BRANCH_TYPE 7'b1100011
// MemtoReg and ALUSrc constant
`define MEM         1'b1
`define REG         1'b0
`define IMM         1'b1
// ALUOp constant
`define R_OP        2'b10
`define B_OP        2'b01
`define OTHER_OP    2'b00
// ALUCtrl constant
`define ADD         3'b010
`define SUB         3'b110
`define MUL         3'b011
`define AND         3'b000
`define OR          3'b001

module CPU
(
    clk_i, 
    start_i
);

// Ports
input           clk_i;
input           start_i;

parameter instr_length = 32'b100;
// Wires and Registers
// PC
wire            PCWrite;
wire            PCSrc;
wire    [31:0]  pc;
wire    [31:0]  pc_next;
wire    [31:0]  pc_branch;
wire    [31:0]  pc_plus_four;
// Instr
wire    [31:0]  instr;
wire    [6:0]   Op;
wire    [4:0]   RS1addr;
wire    [4:0]   RS2addr;
wire    [4:0]   RDaddr;
wire    [9:0]   funct;
// Parsing instr
assign  Op      =   instr[6:0];
assign  RS1addr =   instr[19:15];
assign  RS2addr =   instr[24:20];
assign  RDaddr  =   instr[11:7];
assign  funct   =   {instr[31:25], instr[14:12]};
// Control
wire            Branch;
wire            MemRead;
wire            MemtoReg;
wire    [1:0]   ALUOp;
wire            MemWrite;
wire            ALUSrc;
wire            RegWrite;
// Register and Immediate
wire    [31:0]  RS1data;
wire    [31:0]  RS2data;
wire    [31:0]  RDdata;
wire    [31:0]  imm;
wire    [31:0]  RS2data_imm;
// Shift
wire    [31:0]  branch_offset;
// ALU
wire            Zero;
wire    [2:0]   ALUCtrl;
wire    [31:0]  ALUResult;
// Data Memory
wire    [31:0]  Memdata;

// without pipeline
assign PCWrite = 1;


// Module declaration
// IF stage

PC PC(
    .clk_i          (clk_i),
    .rst_i          (Reset),
    .start_i        (start_i),
    .PCWrite_i      (PCWrite),
    .pc_i           (pc_next),
    .pc_o           (pc)
);

Adder Adder1(
    .data1_in       (pc),
    .data2_in       (instr_length),
    .data_o         (pc_plus_four)
);

MUX32 PC_MUX32(
    .data1_i        (pc_plus_four),
    .data2_i        (pc_branch),
    .select_i       (PCSrc),
    .data_o         (pc_next)
);

Instruction_Memory Instruction_Memory(
    .addr_i         (pc),
    .instr_o        (instr)
);
// ID stage
Control Control(
    .Op_i           (Op),
    .Branch_o       (Branch),
    .MemRead_o      (MemRead),
    .MemtoReg_o     (MemtoReg),
    .ALUOp_o        (ALUOp),
    .MemWrite_o     (MemWrite),
    .ALUSrc_o       (ALUSrc),
    .RegWrite_o     (RegWrite)
);

Registers Registers(
    .clk_i          (clk_i),
    .RS1addr_i      (RS1addr),
    .RS2addr_i      (RS2addr),
    .RDaddr_i       (RDaddr),
    .RDdata_i       (RDdata),
    .RegWrite_i     (RegWrite),
    .RS1data_o      (RS1data),
    .RS2data_o      (RS2data)
);

Imm_Gen Imm_Gen(
    .data_i         (instr),
    .data_o         (imm)
);
// EX stage
MUX32 RS2_IMM_MUX32(
    .data1_i        (RS2data),
    .data2_i        (imm),
    .select_i       (ALUSrc),
    .data_o         (RS2data_imm)
);

ALU ALU(
    .data1_i        (RS1data),
    .data2_i        (RS2data_imm),
    .ALUCtrl_i      (ALUCtrl),
    .data_o         (ALUResult),
    .Zero_o         (Zero)
);

ALU_Control ALU_Control(
    .funct_i        (funct),
    .ALUOp_i        (ALUOp),
    .ALUCtrl_o      (ALUCtrl)
);

Shift Shift(
    .data_i(imm),
    .data_o(branch_offset)
);
Adder Adder2(
    .data1_in       (pc),
    .data2_in       (branch_offset),
    .data_o         (pc_branch)
);
// MEM stage
Data_Memory Data_Memory(
    .clk_i          (clk_i),
    .addr_i         (ALUResult),
    .MemWrite_i     (MemWrite),
    .data_i         (RS2data),
    .data_o         (Memdata)
);

Branch_Gate Branch_Gate(
    .Branch_i       (Branch),
    .Zero_i         (Zero),
    .PCSrc_o        (PCSrc)
);
// WB stage
MUX32 ALU_MEM_MUX32(
    .data1_i        (ALUResult),
    .data2_i        (Memdata),
    .select_i       (MemtoReg),
    .data_o         (RDdata)
);

endmodule

