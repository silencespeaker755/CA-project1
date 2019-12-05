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
input                   clk_i;
input       [31:0]      ALUResult_i;
input       [31:0]      RS2data_i;
input                   Zero_i;
input       [31:0]      pc_branch_i;
input                   Branch_i;
input                   MemRead_i;
input                   MemtoReg_i;
input                   MemWrite_i;
input                   RegWrite_i;
output  reg [31:0]      ALUResult_o;
output  reg [31:0]      RS2data_o;
output  reg             Zero_o;
output  reg [31:0]      pc_branch_o;
output  reg             Branch_o;
output  reg             MemRead_o;
output  reg             MemtoReg_o;
output  reg             MemWrite_o;
output  reg             RegWrite_o;

// Assignment
always@(posedge clk_i) begin
    ALUResult_o     =   ALUResult_i;
    RS2data_o       =   RS2data_i;
    Zero_o          =   Zero_i;
    pc_branch_o     =   pc_branch_i;
    Branch_o        =   Branch_i;
    MemRead_o       =   MemRead_i;
    MemtoReg_o      =   MemtoReg_i;
    MemWrite_o      =   MemWrite_i;
    RegWrite_o      =   RegWrite_i;
end

endmodule
