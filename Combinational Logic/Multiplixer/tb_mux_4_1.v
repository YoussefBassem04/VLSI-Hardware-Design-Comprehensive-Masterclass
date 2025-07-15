module mux_4to1_DUT;

reg [3:0] I;
reg [1:0] sel;
wire y;


//mux_4to1_bh uut (I,sel,y);
//mux_4to1_df uut (I,sel,y);
//mux_4to1_df2 uut (I,sel,y);
//mux_4to1_df3 uut (I,sel,y);
mux_4to1_st uut (I,sel,y);



 

initial begin
    I = 2'b00; sel = 0;
    #10
    repeat (20) begin
        I = $random ;#10
        sel = $random % 4;#10;
    end
    $finish;
end

initial begin
    $monitor("I = %b\tsel = %b\tY = %b",I,sel,y);
end

endmodule