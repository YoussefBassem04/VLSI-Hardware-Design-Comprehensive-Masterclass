module comparator_df2(input [3:0] A,B, output Gt,Sm,Eq);
assign {Gt,Sm,Eq} = {A>B,A<B,A==B};
endmodule