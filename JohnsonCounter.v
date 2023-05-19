`include "DFF.v"

module JohnsonCounter(input clk, input rst, output [5:0] q);

    wire out0, out1, out2, out3, out4, out5;
    wire ivt5;

    DFF DFF_0(.clk(clk), .set(1'b0), .rst(rst), .d(ivt5), .q(out0), .q_bar());
    DFF DFF_1(.clk(clk), .set(1'b0), .rst(rst), .d(out0), .q(out1), .q_bar());
    DFF DFF_2(.clk(clk), .set(1'b0), .rst(rst), .d(out1), .q(out2), .q_bar());
    DFF DFF_3(.clk(clk), .set(1'b0), .rst(rst), .d(out2), .q(out3), .q_bar());
    DFF DFF_4(.clk(clk), .set(1'b0), .rst(rst), .d(out3), .q(out4), .q_bar());
    DFF DFF_5(.clk(clk), .set(1'b0), .rst(rst), .d(out4), .q(out5), .q_bar(ivt5));

    assign q = {out5, out4, out3, out2, out1, out0};    

endmodule