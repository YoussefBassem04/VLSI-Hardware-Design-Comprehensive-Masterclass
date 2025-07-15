module full_adder_dataflow(input a,b,cin, output cout,s);

assign {cout ,s} = a + b + cin;

endmodule