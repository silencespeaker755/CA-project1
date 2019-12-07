// ALU to perform add, subtract, multiply and divide
module ALU(
    data1_i,
    data2_i,
    ALUCtrl_i,
    data_o
);

// Ports
input   [31:0]      data1_i;
input   [31:0]      data2_i;
input   [2:0]       ALUCtrl_i;
output  [31:0]      data_o;

// Wires and Registers
assign data_o  =   (ALUCtrl_i == `ADD)? data1_i + data2_i:
                   (ALUCtrl_i == `OR)?  data1_i | data2_i:
                   (ALUCtrl_i == `AND)? data1_i & data2_i:
                   (ALUCtrl_i == `SUB)? data1_i - data2_i:
                   (ALUCtrl_i == `MUL)? data1_i * data2_i:0;


endmodule
