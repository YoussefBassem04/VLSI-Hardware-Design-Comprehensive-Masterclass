module full_adder_4bit_DUT;

reg [3:0] a, b;
reg cin;
wire [3:0]s;
wire cout;

full_adder_4bit_bh uut (a,b,cin,s,cout);
//full_adder_4bit_df uut (a,b,cin,s,cout);
//full_adder_4bit_st uut (a,b,cin,s,cout);

initial begin
    a = 0; b = 0; cin = 0;
    repeat (16) begin
        #10 a = a + 1;
        repeat (16) begin
            #10 b = b + 1;
            repeat (2) begin
              #10 cin = ~ cin;
            end
        end
    end
    $stop;
end

initial begin
    $monitor ("a = %d\tb = %d\tcin = %d\tsum = %b\tcarry = %d",a,b,cin,s,cout);
end


endmodule