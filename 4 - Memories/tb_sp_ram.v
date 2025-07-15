module single_port_ram_tb;
parameter ADDR_WIDTH = 4; parameter ADDR_DEPTH = 16; parameter DATA_WIDTH = 8;
reg clk;
reg reset;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] din;
wire [DATA_WIDTH-1:0] dout;
integer i;
single_port_ram #(.N(ADDR_WIDTH), .DEPTH(ADDR_DEPTH), .DATA_WIDTH(DATA_WIDTH)) Dut (
.clk(clk),.rst(reset),.we(we),.addr(addr),.data_in(din),.data_out(dout));
// Memory initialization
reg [DATA_WIDTH-1:0] memory [0:ADDR_DEPTH-1];
// Clock generation
always #5 clk = ~clk;
initial begin
    clk = 0; reset = 0; we = 0; addr = 0; din = 0;
    // Load memory from file
    $readmemh("memory_init.txt", memory);
    // Apply reset
    #10 reset = 1;
    // Write values from file into RAM
    for (i = 0; i < ADDR_DEPTH; i = i + 1) begin
        #10; we = 1;
        addr = i;
        din = memory[i];
        #10;
        if (Dut.ram[i] == memory[i])
            $display("Write SUCCESS: Addr=%0d, Data=%h", i, memory[i]);
        else
            $display("Write FAILED: Addr=%0d, Expected=%h, Got=%h", i, memory[i], Dut.ram[i]);
    end
    memory[0] = 8'hff;
    // Read back the values
    #10 we = 0;
    for (i = 0; i < ADDR_DEPTH; i = i + 1) begin
        #10;
        addr = i;
        #10;
        if (dout == memory[i])
            $display("Read SUCCESS: Addr=%0d, Data=%h", i, dout);
        else
            $display("Read FAILED: Addr=%0d, Expected=%h, Got=%h", i, memory[i], dout);
    end
    $writememh("memory_hex.txt",memory);
    #20; $stop;
    end
endmodule