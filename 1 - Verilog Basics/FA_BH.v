module full_adder_behavioral(input a,b,cin, output reg cout, s);

always @(*) begin
    {cout, s} = a + b + cin;
end

endmodule