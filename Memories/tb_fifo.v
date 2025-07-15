module fifo_DUT;

parameter DATA_WIDTH = 8;
parameter DEPTH = 8;

reg clk, rst, r_en, w_en;
reg [DATA_WIDTH - 1:0] data_in;
wire [DATA_WIDTH - 1:0] data_out;
wire full, empty;

// Instantiate DUT
fifo #(DATA_WIDTH, DEPTH) uut (
    .clk(clk),
    .rst(rst),
    .r_en(r_en),
    .w_en(w_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

// Clock Generation
initial clk = 0;
always #5 clk = ~clk;  // 10ns period

// Memory to preload data
reg [DATA_WIDTH - 1:0] myfifo [0 : DEPTH - 1];
integer i;

initial begin
    // Initialize control signals
    rst = 0;
    w_en = 0;
    r_en = 0;
    data_in = 0;

    // Load values into myfifo array from memory_hex.txt
    $readmemh("memory_hex.txt", myfifo, 0, DEPTH - 1);


    // Wait a little, then assert reset
    #12;
    rst = 1;

    // STEP 1: WRITE PHASE
    for (i = 0; i < DEPTH; i = i + 1) begin
        @(negedge clk);
        if (!full) begin
            w_en = 1;
            data_in = myfifo[i];
            $display("Time %0t: WRITE -> Addr=%0d, Data=%h", $time, i, data_in);
        end else begin
            $display("Time %0t: FIFO FULL! Cannot write Addr=%0d", $time, i);
        end
    end

    // Finish write
    @(negedge clk);
    w_en = 0;
    data_in = 0;

    // Small delay before reading
    #10;
    
    
    // STEP 2: READ PHASE
    for (i = 0; i < DEPTH; i = i + 1)
        read_once(i);




    // Finish read
    @(negedge clk);
    r_en = 0;

    // Done
    #10;
    $display("FIFO Test Completed.");
    $stop;
end
task read_once(input integer index);
begin
    @(negedge clk);
    r_en = 1;
    @(negedge clk);
    r_en = 0;
    @(posedge clk);
    if (data_out === myfifo[index])
        $display("Time %0t: READ SUCCESS -> Addr=%0d, Data=%h", $time, index, data_out);
    else
        $display("Time %0t: READ FAILED  -> Addr=%0d, Expected=%h, Got=%h", $time, index, myfifo[index], data_out);
end
endtask

endmodule
