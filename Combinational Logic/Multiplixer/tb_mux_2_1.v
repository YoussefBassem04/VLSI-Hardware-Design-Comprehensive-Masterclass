module mux_2to1_DUT;

reg [1:0] I;
reg sel;
wire y;

//mux_2to1_df uut (I,sel,y);
mux_2to1_bh uut (I,sel,y);
 

initial begin
    I = 2'b00; sel = 0;
    #10
    repeat (20) begin
        I = {$random} % 4;#10
        sel = $random % 2;#10;
    end
    $finish;
end

initial begin
    $monitor("I = %b\tsel = %b\tY = %b",I,sel,y);
end

endmodule