module mux_4to1_df2(input [3:0] I, input [1:0] sel,
output y);

assign y = I[sel]; // Same delay 

endmodule