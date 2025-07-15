module sipo_SR_V2(input serial_in,clk,rst,output reg [3:0] parallel_out);

integer i;
always @(posedge clk,negedge rst) begin
    if (!rst) begin
        parallel_out <= 4'b0;
    end
    else begin
        parallel_out[0] <= serial_in;
        for (i = 0;i < 3 ;i = i + 1) begin
            parallel_out[i + 1] <= parallel_out[i];
        end
    end
end

endmodule