module mod47_DUT;

reg clk, rst;
wire [7:0] count;

counter_mod47_up uut (clk,rst,count);

initial clk = 0;
always #10 clk = ~clk;

initial begin
    rst = 0;
    #15
    rst = 1;
    repeat (100) @ (posedge clk);
    $stop;
end


initial begin
    $monitor ("count = %d",count);
end
endmodule