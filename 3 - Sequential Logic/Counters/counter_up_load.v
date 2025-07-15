module counter_up_load(input [7:0] data, input clk,load,rst, output reg [7:0] count);

always @(posedge clk,negedge rst) begin
    if (!rst) begin
        count <= 0;
    end
    else if (load) begin
        count <= data;
    end
    else begin
        count <= count + 1;
    end
end

endmodule