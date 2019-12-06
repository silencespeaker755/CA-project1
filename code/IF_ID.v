// Pipeline register for IF/ID
module IF_ID(
    clk_i,
    rst_i,
    start_i,
    pc_i,
    instr_i,
    pc_o,
    instr_o
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;
input       [31:0]  pc_i;
input       [31:0]  instr_i;
output  reg [31:0]  pc_o;
output  reg [31:0]  instr_o;

// Assignment
always@(posedge clk_i or negedge rst_i) begin
    if(~rst_i) begin
        pc_o <= 32'b0;
        instr_o <= 32'b0;
    end
    else begin
        if(start_i) begin
            pc_o <= pc_i;
            instr_o <= instr_i;
        end
        else begin
            pc_o <= 32'b0;
            instr_o <= 32'b0;
        end
    end
end

endmodule
