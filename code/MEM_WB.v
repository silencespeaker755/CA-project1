// MEM/WB pipeline register
module MEM_WB(
    clk_i,
    rst_i,
    start_i,
    RegWrite_i,
    Memdata_i,
    ALUResult_i,
    MemtoReg_i,
    RDaddr_i,

    RegWrite_o,
    Memdata_o,
    ALUResult_o,
    MemtoReg_o,
    RDaddr_o
);
// Ports
input                   clk_i;
input                   rst_i;
input                   start_i;
input                   RegWrite_i;
input       [31:0]      Memdata_i;
input       [31:0]      ALUResult_i; 
input                   MemtoReg_i;
input       [4:0]       RDaddr_i;

output  reg             RegWrite_o;
output  reg [31:0]      Memdata_o;
output  reg [31:0]      ALUResult_o;
output  reg             MemtoReg_o;
output  reg [4:0]       RDaddr_o;

// Assignment
always@(posedge clk_i or negedge rst_i) begin
    if(start_i && rst_i) begin
        RegWrite_o      <=   RegWrite_i;
        Memdata_o       <=   Memdata_i;
        ALUResult_o     <=   ALUResult_i;
        MemtoReg_o      <=   MemtoReg_i;
        RDaddr_o        <=   RDaddr_i;
    end
    else begin
        RegWrite_o      <=   1'b0;
        Memdata_o       <=   32'b0;
        ALUResult_o     <=   32'b0;
        MemtoReg_o      <=   1'b0;
        RDaddr_o        <=   5'b0;
    end
end

endmodule
