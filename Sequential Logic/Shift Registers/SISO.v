module siso_SR(input serial_in,clk,rst,output reg serial_out);

reg [3:0] shift_reg;
always @(posedge clk, negedge rst) begin
    if (!rst) begin
        serial_out <= 0;
        shift_reg <= 0;
    end
    else begin
        shift_reg <= (shift_reg << 1) | serial_in;
        serial_out <= shift_reg[3];
    end
end


endmodule