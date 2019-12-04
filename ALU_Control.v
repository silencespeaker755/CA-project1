// Send control signal to ALU_Control
module ALU_Control(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);

// Ports
input   [9:0]   funct_i;
input   [1:0]   ALUOp_i;
output  [2:0]   ALUCtrl_o;

// Wires and Registers
wire    [6:0]   funct7;
wire    [2:0]   funct3;
assign  {funct7, funct3} = funct_i;

// Assignments
assign  ALUCtrl_o = (ALUOp_i == `R_OP && funct3 == 3'b000 && funct7 == 7'b0000000)?  `ADD:
                    (ALUOp_i == `R_OP && funct3 == 3'b000 && funct7 == 7'b0100000)?  `SUB:
                    (ALUOp_i == `R_OP && funct3 == 3'b000 && funct7 == 7'b0000001)?  `MUL:
                    (ALUOp_i == `R_OP && funct3 == 3'b110)?                          `OR:
                    (ALUOp_i == `R_OP && funct3 == 3'b111)?                          `AND:`ADD;

endmodule
