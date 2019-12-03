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

endmodule
