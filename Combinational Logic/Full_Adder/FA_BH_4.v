module full_adder_4bit_bh(input [3:0] a, b, 
input cin, output reg [3:0]s, 
output reg cout);

always @(*) begin
    {cout,s} = a + b + cin;
end

endmodule