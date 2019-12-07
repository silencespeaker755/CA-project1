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
    rst_i,
    start_i
);

// Ports
input           clk_i;
input           rst_i;
input           start_i;

parameter instr_length = 32'b100;
// Wires and Registers
// PC
wire            PCWrite;
wire            PCSrc;
wire    [31:0]  pc_IF;
wire    [31:0]  pc_ID;
wire    [31:0]  pc_EX;
wire    [31:0]  pc_next;
wire    [31:0]  pc_branch_ID;

wire    [31:0]  pc_plus_four;
// Instr
wire    [31:0]  instr_IF;
wire    [31:0]  instr_ID;
wire    [6:0]   Op;
wire    [4:0]   RS1addr_ID;
wire    [4:0]   RS1addr_EX;
wire    [4:0]   RS2addr_ID;
wire    [4:0]   RS2addr_EX;
wire    [4:0]   RDaddr_ID;
wire    [4:0]   RDaddr_EX;
wire    [4:0]   RDaddr_MEM;
wire    [4:0]   RDaddr_WB;
wire    [9:0]   funct_ID;
wire    [9:0]   funct_EX;
// Parsing instr
assign  Op              =   instr_ID[6:0];
assign  RS1addr         =   instr_ID[19:15];
assign  RS2addr         =   instr_ID[24:20];
assign  RDaddr_ID       =   instr_ID[11:7];
assign  funct_ID        =   {instr_ID[31:25], instr_ID[14:12]};
// Control
wire            Branch_ID;
wire            Branch_ID_Control;
wire            MemRead_ID;
wire            MemRead_ID_Control;
wire            MemRead_EX;
wire            MemRead_MEM;
wire            MemtoReg_ID;
wire            MemtoReg_ID_Control;
wire            MemtoReg_EX;
wire            MemtoReg_MEM;
wire            MemtoReg_WB;
wire    [1:0]   ALUOp_ID;
wire    [1:0]   ALUOp_ID_Control;
wire    [1:0]   ALUOp_EX;
wire            MemWrite_ID;
wire            MemWrite_ID_Control;
wire            MemWrite_EX;
wire            MemWrite_MEM;
wire            ALUSrc_ID;
wire            ALUSrc_ID_Control;
wire            ALUSrc_EX;
wire            RegWrite_ID;
wire            RegWrite_ID_Control;
wire            RegWrite_EX;
wire            RegWrite_MEM;
wire            RegWrite_WB;
// Register and Immediate
wire    [31:0]  RS1data_ID;
wire    [31:0]  RS1data_EX;
wire    [31:0]  RS2data_ID;
wire    [31:0]  RS2data_EX;
wire    [31:0]  RS2data_MEM;
wire    [31:0]  RDdata;
wire    [31:0]  imm_ID;
wire    [31:0]  imm_EX;
wire    [31:0]  RS2data_imm;
// Shift
wire    [31:0]  branch_offset;
// ALU
wire            Zero_ID;
wire    [1:0]  ALU_src1_select_EX;
wire    [1:0]  ALU_src2_select_EX;
wire    [2:0]   ALUCtrl;
wire    [31:0]  ALU_src1_EX;
wire    [31:0]  ALU_src2_EX;
wire    [31:0]  ALUResult_EX;
wire    [31:0]  ALUResult_MEM;
wire    [31:0]  ALUResult_WB;
// Data Memory
wire    [31:0]  Memdata_MEM;
wire    [31:0]  Memdata_WB;
// Hazard Detection
wire            PCupdate_HD;
wire            Hazard_HD;
wire            stall_HD;

// without pipeline
assign PCWrite = 1;


// Module declaration
// IF stage

PC PC(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        ((start_i && PCupdate_HD)),        // TODO
    .PCWrite_i      (PCWrite),      // TODO
    .pc_i           (pc_next),
    .pc_o           (pc_IF)
);

Adder Adder1(
    .data1_in       (pc_IF),
    .data2_in       (instr_length),
    .data_o         (pc_plus_four)
);

MUX32 PC_MUX32(
    .data1_i        (pc_plus_four),
    .data2_i        (pc_branch_ID),
    .select_i       (Branch_ID),
    .data_o         (pc_next)
);

Instruction_Memory Instruction_Memory(
    .addr_i         (pc_IF),
    .instr_o        (instr_IF)
);
// IF/ID pipeline register
IF_ID IF_ID(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        (start_i),
    .stall_i        (stall_HD),
    .flush_i        (Branch_ID),
    .pc_i           (pc_IF),
    .instr_i        (instr_IF),
    .pc_o           (pc_ID),
    .instr_o        (instr_ID)
);
// ID stage

HazardDetection HazardDetection(
    .MemRead_EX_i   (MemRead_EX),
    .RS1addr_ID_i   (RS1addr_ID),
    .RS2addr_ID_i   (RS2addr_ID),
    .RDaddr_EX_i    (RDaddr_EX),
    .PCupdate_o     (PCupdate_HD),
    .Hazard_o       (Hazard_HD),
    .stall_o        (stall_HD)
);

Registers Registers(
    .clk_i          (clk_i),
    .RS1addr_i      (RS1addr_ID),
    .RS2addr_i      (RS2addr_ID),
    .RDaddr_i       (RDaddr_WB),
    .RDdata_i       (RDdata),
    .RegWrite_i     (RegWrite_WB),
    .RS1data_o      (RS1data_ID),
    .RS2data_o      (RS2data_ID)
);

Equal Equal(
    .RS1_i(RS1data_ID),
    .RS2_i(RS2data_ID),
    .Zero_o(Zero_ID)
);

Imm_Gen Imm_Gen(
    .data_i         (instr_ID),
    .data_o         (imm_ID)
);

Shift Shift(
    .data_i         (imm_ID),
    .data_o         (branch_offset)
);

Adder Adder2(
    .data1_in       (pc_ID),
    .data2_in       (branch_offset),
    .data_o         (pc_branch_ID)
);

Control Control(
    .Op_i           (Op),
    .Zero_i         (Zero_ID),
    .Branch_o       (Branch_ID_Control),
    .MemRead_o      (MemRead_ID_Control),
    .MemtoReg_o     (MemtoReg_ID_Control),
    .ALUOp_o        (ALUOp_ID_Control),
    .MemWrite_o     (MemWrite_ID_Control),
    .ALUSrc_o       (ALUSrc_ID_Control),
    .RegWrite_o     (RegWrite_ID_Control)
);

MUX7 MUX7(
<<<<<<< HEAD
    .IsHazard_i       (Hazard_HD),                     //TODO
=======
    .IsHazard_i     (Hazard_HD),                     //TODO
>>>>>>> 34be60b833b0c0dc4d687da1b8fbc0bf9aa18261
    .Branch_i       (Branch_ID_Control),
    .MemRead_i      (MemRead_ID_Control),
    .MemtoReg_i     (MemtoReg_ID_Control),
    .ALUOp_i        (ALUOp_ID_Control),
    .MemWrite_i     (MemWrite_ID_Control),
    .ALUSrc_i       (ALUSrc_ID_Control),
    .RegWrite_i     (RegWrite_ID_Control),
    .Branch_o       (Branch_ID),
    .MemRead_o      (MemRead_ID),
    .MemtoReg_o     (MemtoReg_ID),
    .ALUOp_o        (ALUOp_ID),
    .MemWrite_o     (MemWrite_ID),
    .ALUSrc_o       (ALUSrc_ID),
    .RegWrite_o     (RegWrite_ID)
);

// ID/EX pipeline register
ID_EX ID_EX(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        (start_i),
    .pc_i           (pc_ID),
    .MemRead_i      (MemRead_ID),
    .MemtoReg_i     (MemtoReg_ID),
    .ALUOp_i        (ALUOp_ID),
    .MemWrite_i     (MemWrite_ID),
    .ALUSrc_i       (ALUSrc_ID),
    .RegWrite_i     (RegWrite_ID),
    .RS1data_i      (RS1data_ID),
    .RS2data_i      (RS2data_ID),
    .imm_i          (imm_ID),
    .funct_i        (funct_ID),
    .RDaddr_i       (RDaddr_ID),
    .RS1addr_i      (RS1addr_ID),
    .RS2addr_i      (RS2addr_ID),

    .pc_o           (pc_EX),
    .MemRead_o      (MemRead_EX),
    .MemtoReg_o     (MemtoReg_EX),
    .ALUOp_o        (ALUOp_EX),
    .MemWrite_o     (MemWrite_EX),
    .ALUSrc_o       (ALUSrc_EX),
    .RegWrite_o     (RegWrite_EX),
    .RS1data_o      (RS1data_EX),
    .RS2data_o      (RS2data_EX),
    .imm_o          (imm_EX),
    .funct_o        (funct_EX),
    .RDaddr_o       (RDaddr_EX),
    .RS1addr_o      (RS1addr_EX),
    .RS2addr_o      (RS2addr_EX)
);
// forwarding input : RS1addr_EX, RS2addr_EX
// EX stage

Forwarding Forwarding(
    .EX_MEM_RegWrite      (MemtoReg_MEM),
    .MEM_WB_RegWrite      (MemtoReg_WB),
    .ID_EX_RS1addr_i      (RS1addr_EX),
    .ID_EX_RS2addr_i      (RS2addr_EX),
    .EX_MEM_RDaddr_i      (RDaddr_MEM),
    .MEM_WB_RDaddr_i      (RDaddr_WB),
    .ALU_src1_select_o    (ALU_src1_select_EX),
    .ALU_src2_select_o    (ALU_src2_select_EX)
);

<<<<<<< HEAD
MUX32_forwarding MUX32_forwarding1(
=======
MUX32_forwarding RS1_forwarding_MUX(
>>>>>>> 34be60b833b0c0dc4d687da1b8fbc0bf9aa18261
    .data_EX_i      (RS1data_EX),
    .ALUreult_MEM_i (ALUResult_MEM),
    .RDdata_WB_i    (RDdata),
    .select_i       (ALU_src1_select_EX),
    .data_o         (ALU_src1_EX)
);

<<<<<<< HEAD
MUX32_forwarding MUX32_forwarding2(
=======
MUX32_forwarding RS2_forwarding_MUX(
>>>>>>> 34be60b833b0c0dc4d687da1b8fbc0bf9aa18261
    .data_EX_i      (RS2data_EX),
    .ALUreult_MEM_i (ALUResult_MEM),
    .RDdata_WB_i    (RDdata),
    .select_i       (ALU_src2_select_EX),
    .data_o         (ALU_src2_EX)
);

MUX32 RS2_IMM_MUX32(
    .data1_i        (ALU_src2_EX),
    .data2_i        (imm_EX),
    .select_i       (ALUSrc_EX),
    .data_o         (RS2data_imm)
);

ALU_Control ALU_Control(
    .funct_i        (funct_EX),
    .ALUOp_i        (ALUOp_EX),
    .ALUCtrl_o      (ALUCtrl)
);

ALU ALU(
    .data1_i        (ALU_src1_EX),
    .data2_i        (RS2data_imm),
    .ALUCtrl_i      (ALUCtrl),
    .data_o         (ALUResult_EX)
);

// EX_MEM pipeline register
EX_MEM EX_MEM(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        (start_i),
    .ALUResult_i    (ALUResult_EX),
    .RS2data_i      (ALU_src2_EX),
    .MemRead_i      (MemRead_EX),
    .MemtoReg_i     (MemtoReg_EX),
    .MemWrite_i     (MemWrite_EX),
    .RegWrite_i     (RegWrite_EX),
    .RDaddr_i       (RDaddr_EX),

    .ALUResult_o    (ALUResult_MEM),
    .RS2data_o      (RS2data_MEM),
    .MemRead_o      (MemRead_MEM),
    .MemtoReg_o     (MemtoReg_MEM),
    .MemWrite_o     (MemWrite_MEM),
    .RegWrite_o     (RegWrite_MEM),
    .RDaddr_o       (RDaddr_MEM)
);


// MEM stage
Data_Memory Data_Memory(
    .clk_i          (clk_i),
    .addr_i         (ALUResult_MEM),
    .MemWrite_i     (MemWrite_MEM),
    .data_i         (RS2data_MEM),
    .data_o         (Memdata_MEM)
);

// MEM_WB pipeline register
MEM_WB MEM_WB(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        (start_i),
    .RegWrite_i     (RegWrite_MEM),
    .Memdata_i      (Memdata_MEM),
    .ALUResult_i    (ALUResult_MEM),
    .MemtoReg_i     (MemtoReg_MEM),
    .RDaddr_i       (RDaddr_MEM),

    .RegWrite_o     (RegWrite_WB),
    .Memdata_o      (Memdata_WB),
    .ALUResult_o    (ALUResult_WB),
    .MemtoReg_o     (MemtoReg_WB),
    .RDaddr_o       (RDaddr_WB)
);

// WB stage
MUX32 ALU_MEM_MUX32(
    .data1_i        (ALUResult_WB),
    .data2_i        (Memdata_WB),
    .select_i       (MemtoReg_WB),
    .data_o         (RDdata)
);

endmodule

