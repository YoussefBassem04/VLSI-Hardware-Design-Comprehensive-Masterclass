module up_down_DUT;

reg clk,up_down,rst;
wire [7:0] count;

counter_up_down uut (up_down,rst,clk,count);


initial clk = 0;
always #10 clk = ~clk;

initial begin
    rst = 0; up_down = 0;
    #15
    rst = 1; up_down = 1;
    repeat (70) @ (posedge clk);
    up_down = 0;
    repeat (100) @ (posedge clk);
    rst = 0;
    #10
    $stop;
    
end


initial begin
    $monitor ("count = %d\tup_down = %b", count,up_down);
end

endmodule