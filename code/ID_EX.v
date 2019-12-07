// ID/EX pipeline register
module ID_EX(
    clk_i,
    rst_i,
    start_i,
    pc_i,
    MemRead_i,
    MemtoReg_i,
    ALUOp_i,
    MemWrite_i,
    ALUSrc_i,
    RegWrite_i,
    RS1data_i, 
    RS2data_i, 
    imm_i,
    funct_i,
    RDaddr_i,
    RS1addr_i,
    RS2addr_i,

    pc_o,
    MemRead_o,
    MemtoReg_o,
    ALUOp_o,
    MemWrite_o,
    ALUSrc_o,
    RegWrite_o,
    RS1data_o, 
    RS2data_o, 
    imm_o,
    funct_o,
    RDaddr_o,
    RS1addr_o,
<<<<<<< HEAD
    RS2addr_o,
=======
    RS2addr_o
>>>>>>> 34be60b833b0c0dc4d687da1b8fbc0bf9aa18261
);
// Port
input               clk_i;
input               rst_i;
input               start_i;
input       [31:0]  pc_i;
input               MemRead_i;
input               MemtoReg_i;
input       [1:0]   ALUOp_i;
input               MemWrite_i;
input               ALUSrc_i;
input               RegWrite_i;
input       [9:0]   funct_i;
input       [31:0]  RS1data_i;
input       [31:0]  RS2data_i;
input       [31:0]  imm_i;
input       [4:0]   RDaddr_i;
input       [4:0]   RS1addr_i;
input       [4:0]   RS2addr_i;

output  reg [31:0]  pc_o;
output  reg         MemRead_o;
output  reg         MemtoReg_o;
output  reg [1:0]   ALUOp_o;
output  reg         MemWrite_o;
output  reg         ALUSrc_o;
output  reg         RegWrite_o;
output  reg [9:0]   funct_o;
output  reg [31:0]  RS1data_o;
output  reg [31:0]  RS2data_o;
output  reg [31:0]  imm_o;
output  reg [4:0]   RDaddr_o;
output  reg [4:0]   RS1addr_o;
output  reg [4:0]   RS2addr_o;

// Assignment
always@(posedge clk_i or negedge rst_i) begin
    if(~rst_i) begin
        pc_o        <=   32'b0;
        MemRead_o   <=   1'b0;
        MemtoReg_o  <=   1'b0;
        ALUOp_o     <=   2'b0;
        MemWrite_o  <=   1'b0;
        ALUSrc_o    <=   1'b0;
        RegWrite_o  <=   1'b0;
        funct_o     <=   10'b0;
        RS1data_o   <=   32'b0;
        RS2data_o   <=   32'b0;
        imm_o       <=   32'b0;
        RDaddr_o    <=   5'b0;
        RS1addr_o   <=   5'b0;
        RS2addr_o   <=   5'b0;
    end
    else begin
        if(start_i) begin
            pc_o        <=   pc_i;
            MemRead_o   <=   MemRead_i;
            MemtoReg_o  <=   MemtoReg_i;
            ALUOp_o     <=   ALUOp_i;
            MemWrite_o  <=   MemWrite_i;
            ALUSrc_o    <=   ALUSrc_i;
            RegWrite_o  <=   RegWrite_i;
            funct_o     <=   funct_i;
            RS1data_o   <=   RS1data_i;
            RS2data_o   <=   RS2data_i;
            imm_o       <=   imm_i;
            RDaddr_o    <=   RDaddr_i;
            RS1addr_o   <=   RS1addr_i;
<<<<<<< HEAD
            RS2addr_o   <=   RS1addr_i;
=======
            RS2addr_o   <=   RS2addr_i;
>>>>>>> 34be60b833b0c0dc4d687da1b8fbc0bf9aa18261
        end
        else begin
            pc_o        <=   32'b0;
            MemRead_o   <=   1'b0;
            MemtoReg_o  <=   1'b0;
            ALUOp_o     <=   2'b0;
            MemWrite_o  <=   1'b0;
            ALUSrc_o    <=   1'b0;
            RegWrite_o  <=   1'b0;
            funct_o     <=   10'b0;
            RS1data_o   <=   32'b0;
            RS2data_o   <=   32'b0;
            imm_o       <=   32'b0;
            RDaddr_o    <=   5'b0;
            RS1addr_o   <=   5'b0;
            RS2addr_o   <=   5'b0;
        end
    end
end

endmodule
