module mux_4to1_st(input [3:0] I, input [1:0] sel,
output y);

wire [1:0] net;

mux_2to1_df mux1(I[1:0],sel[0],net[0]);
mux_2to1_df mux2(I[3:2],sel[0],net[1]);
mux_2to1_df mux3(net,sel[1],y);

endmodule