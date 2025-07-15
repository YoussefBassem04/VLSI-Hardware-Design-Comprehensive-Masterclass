module decoder_2to4_df(input en, input [1:0] I, output [3:0] y);

assign y = ~en? 4'b0 : {(I[0] & I[1]),
            (I[0] & ~I[1]),
            (~I[0] & I[1]),
            (~I[0] & ~I[0])};

endmodule