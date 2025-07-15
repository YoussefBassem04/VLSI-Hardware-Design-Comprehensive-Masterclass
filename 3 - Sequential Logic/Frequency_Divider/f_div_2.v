module freq_div_2(input clk,rst,output reg clk_2);

 

always @(posedge clk,negedge rst) begin
    if (!rst) 
        clk_2 <= 0;
    else
        clk_2 <= ~clk_2;
end

endmodule