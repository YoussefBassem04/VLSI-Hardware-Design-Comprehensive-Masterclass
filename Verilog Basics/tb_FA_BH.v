module full_adder_DUT;


reg a,b,cin;
wire s,cout;

full_adder_structural uut(a,b,cin,cout,s);


initial begin
    $monitor("cout = %d sum = %d",cout, s);
    a = 0; b = 0; cin = 0;
    #10
    a = 1; b = 0; cin = 1;
    #10
    a = 1; b = 1; cin = 1;
    #10 
    a = 1; b = 1; cin = 0;
    #10
    $stop;


end

endmodule