module sipo_SR(input serial_in,clk,rst,output reg [3:0] parallel_out);


always @(posedge clk,negedge rst) begin
    if (!rst)
        parallel_out <= 4'b0;
    else
        parallel_out <= {parallel_out[2:0], serial_in};
end

endmodule