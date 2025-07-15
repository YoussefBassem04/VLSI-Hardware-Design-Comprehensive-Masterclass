module f_div_4_DUT;

reg clk,rst;
wire clk_4;

freq_div_4 uut (clk,rst,clk_4);

localparam T = 10 ;
initial clk = 0;
always #(T/2) clk = ~clk;

initial begin
    rst = 0;
    #15
    rst = 1;
    #(10*T);
    $stop;
end


endmodule