// MEM/WB pipeline register
module MEM_WB(
    clk_i,
    RegWrite_i,
    Memdata_i,
    ALUResult_i,
    MemtoReg_i,
    RegWrite_o,
    Memdata_o,
    ALUResult_o,
    MemtoReg_o,
);
// Ports
input               clk_i;
input               RegWrite_i;
input   [31:0]      Memdata_i;
input   [31:0]      ALUResult_i; 
input               MemtoReg_i;
output              RegWrite_o;
output  [31:0]      Memdata_o;
output  [31:0]      ALUResult_o;
output              MemtoReg_o;

// Wires and Registers
// Assignment

endmodule
