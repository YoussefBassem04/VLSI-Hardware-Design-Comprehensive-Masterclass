module full_adder_4bit_st(input [3:0] a, b, 
input cin, output [3:0]s, 
output cout);

wire [2:0] carrys;

full_adder fa1(a[0],b[0],cin,s[0],carrys[0]);
full_adder fa2(a[1],b[1],carrys[0],s[1],carrys[1]);
full_adder fa3(a[2],b[2],carrys[1],s[2],carrys[2]);
full_adder fa4(a[3],b[3],carrys[2],s[3],cout);


endmodule