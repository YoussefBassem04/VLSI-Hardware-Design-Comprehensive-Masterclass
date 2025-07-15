module f_div_2_DUT;

reg clk,rst;
wire clk_2;

freq_div_2 uut (clk,rst,clk_2);

localparam T = 10 ;
initial clk = 0;
always #(T/2) clk = ~clk;

initial begin
    rst = 0;
    #15
    rst = 1;
    #(4*T);
    $stop;
end


endmodule