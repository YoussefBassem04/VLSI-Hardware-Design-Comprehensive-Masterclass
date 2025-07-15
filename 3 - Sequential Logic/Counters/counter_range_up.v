module counter_10_to_40_up(input clk,rst,output reg [7:0] count);

always @(posedge clk, negedge clk) begin
    if (!rst || count == 8'd40) 
        count <= 8'd10;
    else
        count <= count + 1;
end

endmodule