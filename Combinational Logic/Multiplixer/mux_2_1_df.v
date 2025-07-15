module mux_2to1_df(input [1:0] I, input sel,
output y);

assign y = sel? I[1] : I[0];

endmodule