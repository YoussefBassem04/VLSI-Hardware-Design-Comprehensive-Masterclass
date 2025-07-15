module half_adder_behavioral(input a,b, output reg s,c);

always @(*) begin
    s = a ^ b;
    c = a & b;
end

endmodule