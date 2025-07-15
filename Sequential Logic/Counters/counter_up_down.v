module counter_up_down(input up_down,rst,clk, output reg [7:0] count);

always @(posedge clk, negedge rst) begin
    if (!rst) begin
        count <= 0;
    end
    else if (up_down && count != 8'hff) begin
        count <= count + 1;
    end
    else if (!up_down && count != 0) begin
        count <= count - 1;
    end
    else begin
        count <= count;
    end
end

endmodule