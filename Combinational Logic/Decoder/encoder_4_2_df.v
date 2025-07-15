module encoder_4_2_df(
    input [3:0] I, 
    output [1:0] y,
    output v);


assign y = {I[3] | I[2], I[3] | I[1]};
assign v = |I;

endmodule