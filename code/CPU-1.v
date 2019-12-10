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
// Instr
wire    [6:0]   Op_ID;
wire    [4:0]   RS1addr_ID;
wire    [4:0]   RS2addr_ID;
wire    [4:0]   RDaddr_ID;
wire    [9:0]   funct_ID;
// Parsing instr
assign  Op_ID           =   IF_ID.instr_o[6:0];
assign  RS1addr_ID      =   IF_ID.instr_o[19:15];
assign  RS2addr_ID      =   IF_ID.instr_o[24:20];
assign  RDaddr_ID       =   IF_ID.instr_o[11:7];
assign  funct_ID        =   {IF_ID.instr_o[31:25], IF_ID.instr_o[14:12]};

// Module declaration
// IF stage
PC PC(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        (start_i),
    .PCWrite_i      (HazardDetection.PCWrite_o),
    .pc_i           (PC_MUX32.data_o),
    .pc_o           ()
);

Adder Adder1(
    .data1_in       (PC.pc_o),
    .data2_in       (instr_length),
    .data_o         ()
);

MUX32 PC_MUX32(
    .data1_i        (Adder1.data_o),
    .data2_i        (Adder2.data_o),
    .select_i       (MUX7.Branch_o),
    .data_o         ()
);

Instruction_Memory Instruction_Memory(
    .addr_i         (PC.pc_o),
    .instr_o        ()
);
// IF/ID pipeline register
IF_ID IF_ID(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        (start_i),
    .IF_IDWrite_i   (HazardDetection.IF_IDWrite_o),
    .flush_i        (HazardDetection.IF_IDflush_o),
    .pc_i           (PC.pc_o),
    .instr_i        (Instruction_Memory.instr_o),
    .pc_o           (),
    .instr_o        ()
);
// ID stage

HazardDetection HazardDetection(
    .MemRead_EX_i   (ID_EX.MemRead_o),
    .RS1addr_ID_i   (RS1addr_ID),
    .RS2addr_ID_i   (RS2addr_ID),
    .RDaddr_EX_i    (ID_EX.RDaddr_o),
    .Branch_i       (Control.Branch_o),
    .stall_o        (),
    .PCWrite_o      (),
    .IF_IDWrite_o   (),
    .IDflush_o      (),
    .IF_IDflush_o   ()
);

Registers Registers(
    .clk_i          (clk_i),
    .RS1addr_i      (RS1addr_ID),
    .RS2addr_i      (RS2addr_ID),
    .RDaddr_i       (MEM_WB.RDaddr_o),
    .RDdata_i       (ALU_MEM_MUX32.data_o),
    .RegWrite_i     (MEM_WB.RegWrite_o),
    .RS1data_o      (),
    .RS2data_o      ()
);

Equal Equal(
    .data1_i(Registers.RS1data_o),
    .data2_i(Registers.RS2data_o),
    .Zero_o()
);

Imm_Gen Imm_Gen(
    .data_i         (IF_ID.instr_o),
    .data_o         ()
);

Shift Shift(
    .data_i         (Imm_Gen.data_o),
    .data_o         ()
);

Adder Adder2(
    .data1_in       (IF_ID.pc_o),
    .data2_in       (Shift.data_o),
    .data_o         ()
);

Control Control(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        (start_i),
    .Op_i           (Op_ID),
    .Zero_i         (Equal.Zero_o),
    .Branch_o       (),
    .MemRead_o      (),
    .MemtoReg_o     (),
    .ALUOp_o        (),
    .MemWrite_o     (),
    .ALUSrc_o       (),
    .RegWrite_o     ()
);

MUX7 MUX7(
    .flush_i        (HazardDetection.IDflush_o),
    .Branch_i       (Control.Branch_o),
    .MemRead_i      (Control.MemRead_o),
    .MemtoReg_i     (Control.MemtoReg_o),
    .ALUOp_i        (Control.ALUOp_o),
    .MemWrite_i     (Control.MemWrite_o),
    .ALUSrc_i       (Control.ALUSrc_o),
    .RegWrite_i     (Control.RegWrite_o),
    .Branch_o       (),
    .MemRead_o      (),
    .MemtoReg_o     (),
    .ALUOp_o        (),
    .MemWrite_o     (),
    .ALUSrc_o       (),
    .RegWrite_o     ()
);

// ID/EX pipeline register
ID_EX ID_EX(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        (start_i),
    .pc_i           (IF_ID.pc_o),
    .MemRead_i      (MUX7.MemRead_o),
    .MemtoReg_i     (MUX7.MemtoReg_o),
    .ALUOp_i        (MUX7.ALUOp_o),
    .MemWrite_i     (MUX7.MemWrite_o),
    .ALUSrc_i       (MUX7.ALUSrc_o),
    .RegWrite_i     (MUX7.RegWrite_o),
    .RS1data_i      (Registers.RS1data_o),
    .RS2data_i      (Registers.RS2data_o),
    .imm_i          (Imm_Gen.data_o),
    .funct_i        (funct_ID),
    .RDaddr_i       (RDaddr_ID),
    .RS1addr_i      (RS1addr_ID),
    .RS2addr_i      (RS2addr_ID),

    .pc_o           (),
    .MemRead_o      (),
    .MemtoReg_o     (),
    .ALUOp_o        (),
    .MemWrite_o     (),
    .ALUSrc_o       (),
    .RegWrite_o     (),
    .RS1data_o      (),
    .RS2data_o      (),
    .imm_o          (),
    .funct_o        (),
    .RDaddr_o       (),
    .RS1addr_o      (),
    .RS2addr_o      ()
);
// forwarding input : RS1addr_EX, RS2addr_EX
// EX stage

Forwarding Forwarding(
    .EX_MEM_RegWrite      (EX_MEM.RegWrite_o),
    .MEM_WB_RegWrite      (MEM_WB.RegWrite_o),
    .ID_EX_RS1addr_i      (ID_EX.RS1addr_o),
    .ID_EX_RS2addr_i      (ID_EX.RS2addr_o),
    .EX_MEM_RDaddr_i      (EX_MEM.RDaddr_o),
    .MEM_WB_RDaddr_i      (MEM_WB.RDaddr_o),
    .ALU_src1_select_o    (),
    .ALU_src2_select_o    ()
);

MUX32_forwarding RS1_forwarding_MUX(
    .data_EX_i      (ID_EX.RS1data_o),
    .ALUreult_MEM_i (EX_MEM.ALUResult_o),
    .RDdata_WB_i    (ALU_MEM_MUX32.data_o),
    .select_i       (Forwarding.ALU_src1_select_o),
    .data_o         ()
);


MUX32_forwarding RS2_forwarding_MUX(
    .data_EX_i      (ID_EX.RS2data_o),
    .ALUreult_MEM_i (EX_MEM.ALUResult_o),
    .RDdata_WB_i    (ALU_MEM_MUX32.data_o),
    .select_i       (Forwarding.ALU_src2_select_o),
    .data_o         ()
);

MUX32 RS2_IMM_MUX32(
    .data1_i        (RS2_forwarding_MUX.data_o),
    .data2_i        (ID_EX.imm_o),
    .select_i       (ID_EX.ALUSrc_o),
    .data_o         ()
);

ALU_Control ALU_Control(
    .funct_i        (ID_EX.funct_o),
    .ALUOp_i        (ID_EX.ALUOp_o),
    .ALUCtrl_o      ()
);

ALU ALU(
    .data1_i        (RS1_forwarding_MUX.data_o),
    .data2_i        (RS2_IMM_MUX32.data_o),
    .ALUCtrl_i      (ALU_Control.ALUCtrl_o),
    .data_o         ()
);

// EX_MEM pipeline register
EX_MEM EX_MEM(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        (start_i),
    .ALUResult_i    (ALU.data_o),
    .RS2data_i      (RS2_forwarding_MUX.data_o),
    .MemRead_i      (ID_EX.MemRead_o),
    .MemtoReg_i     (ID_EX.MemtoReg_o),
    .MemWrite_i     (ID_EX.MemWrite_o),
    .RegWrite_i     (ID_EX.RegWrite_o),
    .RDaddr_i       (ID_EX.RDaddr_o),

    .ALUResult_o    (),
    .RS2data_o      (),
    .MemRead_o      (),
    .MemtoReg_o     (),
    .MemWrite_o     (),
    .RegWrite_o     (),
    .RDaddr_o       ()
);


// MEM stage
Data_Memory Data_Memory(
    .clk_i          (clk_i),
    .addr_i         (EX_MEM.ALUResult_o),
    .MemWrite_i     (EX_MEM.MemWrite_o),
    .data_i         (EX_MEM.RS2data_o),
    .data_o         ()
);

// MEM_WB pipeline register
MEM_WB MEM_WB(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    .start_i        (start_i),
    .RegWrite_i     (EX_MEM.RegWrite_o),
    .Memdata_i      (Data_Memory.data_o),
    .ALUResult_i    (EX_MEM.ALUResult_o),
    .MemtoReg_i     (EX_MEM.MemtoReg_o),
    .RDaddr_i       (EX_MEM.RDaddr_o),

    .RegWrite_o     (),
    .Memdata_o      (),
    .ALUResult_o    (),
    .MemtoReg_o     (),
    .RDaddr_o       ()
);

// WB stage
MUX32 ALU_MEM_MUX32(
    .data1_i        (MEM_WB.ALUResult_o),
    .data2_i        (MEM_WB.Memdata_o),
    .select_i       (MEM_WB.MemtoReg_o),
    .data_o         ()
);

endmodule

