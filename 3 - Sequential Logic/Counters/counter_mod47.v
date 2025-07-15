module counter_mod47_up(input clk,rst, output reg [7:0] count);

always @(posedge clk, negedge rst) begin
    if (!rst || count == 8'd46) begin
        count <= 0;
    end
    else begin
        count <= count + 1; 
    end
end

endmodule