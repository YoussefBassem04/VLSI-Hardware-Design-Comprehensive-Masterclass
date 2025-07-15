module up_load_DUT;

reg [7:0] data;
reg clk,load,rst;
wire [7:0] count;

counter_up_load uut (data,clk,load,rst,count);

initial clk = 0;
always #10 clk = ~clk;



initial begin
    load = 0; rst = 0;
    data = 8'h3e;
    #10
    rst = 1;
    repeat (30) @ (posedge clk);
    load = 1;
    @(posedge clk);
    @(posedge clk);
    load = 0;
    #100
    $stop;
end

initial begin
    $monitor ("count = %d\tload status = %b", count,load);
end

endmodule