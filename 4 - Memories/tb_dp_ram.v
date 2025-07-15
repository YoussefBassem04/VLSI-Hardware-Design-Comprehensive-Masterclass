module dual_port_ram_DUT;
parameter ADDR_WIDTH = 4;
parameter ADDR_DEPTH = 16;
parameter DATA_WIDTH = 8;
reg clk,rst;
reg wren_a, wren_b;
reg [ADDR_WIDTH-1:0] addr_a, addr_b;
reg [DATA_WIDTH-1:0] din_a, din_b;
wire [DATA_WIDTH-1:0] dout_a, dout_b;
integer i;
dual_port_ram #(.N(ADDR_WIDTH), .DEPTH(ADDR_DEPTH), .WIDTH(DATA_WIDTH)) Dut (
    wren_a, wren_b,clk,rst,din_a, din_b,addr_a, addr_b,dout_a, dout_b
);
// Memory initialization file
reg [DATA_WIDTH-1:0] memory [0:ADDR_DEPTH-1];
// Clock generation
always #5 clk = ~clk;
initial begin
    clk = 0; wren_a = 0; wren_b = 0; addr_a = 0; addr_b = 0; din_a = 0; din_b = 0;
    // Load memory from file
    $readmemh("memory_hex.txt", memory);
    // Write values from file into RAM using Port A and Port B
    for (i = 0; i < ADDR_DEPTH; i = i + 2) begin
        #10;
        // Write even address using Port A
        wren_a = 1;
        addr_a = i;
        din_a = memory[i];
        // Write odd address using Port B
        wren_b = 1;
        addr_b = i+1;
        din_b = memory[i+1];
        #10;
        if (Dut.ram[i] == memory[i])
            $display("Write SUCCESS (Port A): Addr=%0d, Data=%h", i, memory[i]);
        else
            $display("Write FAILED (Port A): Addr=%0d, Expected=%h, Got=%h", i, memory[i], Dut.ram[i]);
        if (Dut.ram[i+1] == memory[i+1])
            $display("Write SUCCESS (Port B): Addr=%0d, Data=%h", i+1, memory[i+1]);
        else
            $display("Write FAILED (Port B): Addr=%0d, Expected=%h, Got=%h", i+1, memory[i+1], Dut.ram[i+1]);
    end
    wren_a = 0; wren_b = 0;

    // Read back values from both ports
    for (i = 0; i < ADDR_DEPTH; i = i + 2) begin
        #10;
        addr_a = i;
        addr_b = i+1;
        #10;
        if (dout_a == memory[i])
            $display("Read SUCCESS (Port A): Addr=%0d, Data=%h", i, dout_a);
        else
            $display("Read FAILED (Port A): Addr=%0d, Expected=%h, Got=%h", i, memory[i], dout_a);
        if (dout_b == memory[i+1])
            $display("Read SUCCESS (Port B): Addr=%0d, Data=%h", i+1, dout_b);
        else
            $display("Read FAILED (Port B): Addr=%0d, Expected=%h, Got=%h", i+1, memory[i+1], dout_b);
    end
    #20;
    $stop;
end
endmodule