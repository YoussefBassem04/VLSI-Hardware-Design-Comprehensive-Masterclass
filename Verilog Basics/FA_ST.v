module full_adder_structural(input a,b,cin, output cout, s);


wire c1,c2,s1;

half_adder_dataflow ha1 (a,b,s1,c1);
half_adder_dataflow ha2 (cin,s1,s,c2);
or (cout,c1,c2);

endmodule