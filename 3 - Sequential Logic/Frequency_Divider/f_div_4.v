module freq_div_4(input clk,rst,output reg clk_4);

reg clk_2;
always @(posedge clk,negedge rst) begin
    if (!rst) 
        clk_2 <= 0;
    else
        clk_2 <= ~clk_2;
end

always @(posedge clk_2,negedge rst) begin
    if (!rst) 
        clk_4 <= 0;
    else
        clk_4 <= ~clk_4;
end

endmodule