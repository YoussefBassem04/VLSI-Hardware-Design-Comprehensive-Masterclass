module half_adder_dataflow(input a,b, output s,c);

assign {c,s} = a + b;

endmodule