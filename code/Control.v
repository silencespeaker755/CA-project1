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
    RegWrite_o
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

reg             Branch = 0;
reg             MemRead = 0;
reg             MemtoReg = 0;
reg     [1:0]   ALUOp = 2'b00;
reg             MemWrite = 0;
reg             ALUSrc = 0;
reg             RegWrite = 0;

initial begin
    $display("FUCK my Life");
    Branch = 0;
    MemRead = 0;
    MemtoReg = 0;
    ALUOp = 2'b00;
    MemWrite = 0;
    ALUSrc = 0;
    RegWrite = 0;
end

assign Branch_o = Branch;
assign MemRead_o = MemRead;
assign MemtoReg_o = MemtoReg;
assign ALUOp_o = ALUOp;
assign MemWrite_o = MemWrite;
assign ALUSrc_o = ALUSrc;
assign RegWrite_o = RegWrite;

reg judge = 0;

// Assignment
always@(*) begin
    if(Op_i == `BRANCH_TYPE) begin
        judge = 1;
    end
    else begin
        judge = 0;
    end
    $display("FUCK YOUR CODE %d %d",Zero_i,judge);
    //Branch    =   ((Op_i == `BRANCH_TYPE) && Zero_i)?  1:0;
    if(Op_i == `BRANCH_TYPE) begin
        $display("FUCK MY LIFE");
        if(Zero_i == 1) begin
            $display("FUCK YOUR CODE %d",Zero_i);
            Branch = 1;
        end
        else begin
            Branch = 0;
        end
    end
    else begin
        Branch = 0;
    end
    MemRead   =   (Op_i == `LOAD_TYPE)?    1:0;
    MemtoReg  =   (Op_i == `LOAD_TYPE)?    `MEM:`REG;
    ALUOp     =   (Op_i == `R_TYPE)?       `R_OP:
                    (Op_i == `BRANCH_TYPE)?  `B_OP:
                    `OTHER_OP;
    MemWrite  =   (Op_i == `STORE_TYPE)?   1:0;
    ALUSrc    =   (Op_i == `R_TYPE)?       `REG:
                    (Op_i == `I_TYPE)?       `IMM:
                    (Op_i == `LOAD_TYPE)?    `IMM:
                    (Op_i == `STORE_TYPE)?   `IMM:
                    (Op_i == `BRANCH_TYPE)?  `REG:0;
    RegWrite  =   (Op_i == `R_TYPE)?       1:
                    (Op_i == `I_TYPE)?       1:
                    (Op_i == `LOAD_TYPE)?    1:0;
end

endmodule
