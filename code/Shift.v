// Multiply imm with 2 to get branch offset
module Shift(
    data_i,
    data_o
);

// Ports
input   [31:0]  data_i;
output  [31:0]  data_o;

// Assignment
assign data_o = data_i << 1;

endmodule
