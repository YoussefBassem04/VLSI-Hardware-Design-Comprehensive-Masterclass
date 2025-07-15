module f_div_3_DUT;

reg clk,rst;
wire clk_3;

freq_div_3 uut (clk,rst,clk_3);

localparam T = 10;
initial clk = 0;
always #(T/2) clk = ~clk;

initial begin
    rst = 1;
    #15
    rst = 0;
    repeat (20) @(posedge clk);
    $stop;
end


endmodule