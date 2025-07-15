module single_port_ram #(parameter DATA_WIDTH = 8, DEPTH = 16, N = 4)
(input [DATA_WIDTH - 1 : 0] data_in,
 input [N - 1 : 0] addr,
 input we,clk,rst,
 output reg [DATA_WIDTH - 1 : 0] data_out   
);

reg [DATA_WIDTH - 1: 0] ram [0 : DEPTH - 1];

integer i;
always @(posedge clk,negedge rst) begin
    if (!rst) begin
        for (i = 0;i < DEPTH;i = i + 1) begin
            ram[i] <= 0;
        end
    end
    else if (we) begin
        ram[addr] <= data_in;
    end
    else begin
        data_out <= ram[addr];
    end
end


endmodule