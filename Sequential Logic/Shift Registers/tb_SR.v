
module sr_DUT;

reg clk, rst, serial_in;
wire serial_out;

// Instantiate the Design Under Test
siso_SR uut (
    .serial_in(serial_in),
    .clk(clk),
    .rst(rst),
    .serial_out(serial_out)
);

// Clock generation
localparam T = 20;
initial clk = 0;
always #(T/2) clk = ~clk;

integer i;
reg [3:0] input_sequence = 4'b1101; // Example serial data stream

initial begin
    // Step 1: Initialize all
    serial_in = 0;
    rst = 0;
    #15; // Hold reset low for some time

    // Step 2: Release reset
    rst = 1;
    #T;

    // Step 3: Feed in serial data bit-by-bit
    for (i = 3; i >= 0; i = i - 1) begin
        serial_in = input_sequence[i]; // MSB-first
        #(T);
    end

    // Step 4: Wait a few cycles to observe output
    repeat (10) @(posedge clk);

    $stop;
end

initial begin
    $display("Time\tSI\tSO\tShift_Reg_State (MSB first)");
    $monitor("%0t\t%b\t%b\t", $time, serial_in, serial_out);
end

endmodule
