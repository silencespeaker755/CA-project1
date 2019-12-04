// Send signal PCSrc to PC_MUX32 for it determining next pc
module Branch_Gate(
    Branch_i,
    Zero_i,
    PCSrc_o
);

// Ports
input       Branch_i;
input       Zero_i;
output      PCSrc_o;

// Assignment
assign  PCSrc_o = (Branch_i == 1 && Zero_i == 1)? 1:0;

endmodule
