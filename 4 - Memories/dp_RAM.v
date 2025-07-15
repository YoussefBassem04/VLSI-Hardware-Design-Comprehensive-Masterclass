module dual_port_ram #(parameter WIDTH = 8, DEPTH = 16, N = 4)(
    input we_a,we_b,clk,rst,
    input [WIDTH - 1:0] din_a,din_b,
    input [N - 1:0] addr_a,addr_b,
    output reg [WIDTH - 1:0] dout_a,dout_b
);

reg [WIDTH - 1:0] ram [0 : DEPTH - 1];
integer i;
always @(posedge clk) begin
    if (rst) begin
        for (i = 0;i < DEPTH;i = i + 1) begin
            ram[i] <= 0;
        end
    end
    if (we_a) 
        ram[addr_a] <= din_a;
    dout_a <= ram[addr_a];

    if (we_b)
        ram[addr_b] <= din_b;
    dout_b <= ram[addr_b]; 
    
end


endmodule