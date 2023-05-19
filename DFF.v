module nand3(output y, input a, input b, input c);
    assign y = !(a & b & c);
endmodule

module DFF (input clk, input set, input rst, input d, output q, output q_bar);
    wire set_bar, rst_bar;
    wire sl_o0, sl_o1, rl_o0, rl_o1;

    not not_0(set_bar, set);
    not not_1(rst_bar, rst);

    // SET Latch
    nand3 nand_0(.y(sl_o0), .a(set_bar), .b(rl_o1), .c(sl_o1));
    nand3 nand_1(.y(sl_o1), .a(sl_o0),   .b(clk),   .c(rst_bar));

    // RESET Latch
    nand3 nand_2(.y(rl_o0), .a(sl_o1), .b(clk), .c(rl_o1));
    nand3 nand_3(.y(rl_o1), .a(rl_o0), .b(d),   .c(rst_bar));

    // Latch
    nand3 nand_4(.y(q), .a(set_bar), .b(sl_o1), .c(q_bar));
    nand3 nand_5(.y(q_bar), .a(q),    .b(rl_o0), .c(rst_bar));  
endmodule