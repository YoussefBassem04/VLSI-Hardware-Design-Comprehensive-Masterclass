module comparator_bh(input [3:0] A,B, output reg Gt,Sm,Eq);
always @(*) begin
    {Gt,Sm,Eq} = {A>B,A<B,A==B};
end
endmodule