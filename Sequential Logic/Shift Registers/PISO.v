module piso_SR(input [3:0] parallel_in, 
               input clk,rst,load_shift,
               output reg serial_out);

reg [3:0] shift_reg;
always @(posedge clk,negedge rst) begin
    if (!rst) begin
        shift_reg <= 0;
        serial_out <= 0;
    end
    else if (load_shift) begin
      shift_reg <= parallel_in;
    end
    else begin
        serial_out <= shift_reg[0];
        shift_reg <= shift_reg >> 1;
    end
end

endmodule