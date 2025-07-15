module mux_4to1_df3(input [3:0] I, input [1:0] sel,
output y);

assign y = ~|sel? I[0] :
           & sel? I[3] :
          sel[0]? I[1] : I[2];

endmodule