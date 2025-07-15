module vm_DUT;

reg start, rst, clk, choice;
reg [1:0] coins;
wire done;
wire [1:0] product, change;

vendig_machine uut (
    .start(start),
    .rst(rst),
    .clk(clk),
    .choice(choice),
    .coins(coins),
    .done(done),
    .product(product),
    .change(change)
);

initial clk = 0;
always #5 clk = ~clk; // Clock period of 10 time units

initial begin
    // Initialize inputs
    start = 0; rst = 0; clk = 0; choice = 0;
    coins = 2'b00; // No coins

    // Reset the system
    #10 rst = 0; // Assert reset
    #10 rst = 1; // Deassert reset

    // Test case: Start vending machine with no coins
    #10 start = 1; choice = 0; // Choose chock
    #10 start = 0;

    // Wait for a while to observe the output
    #20;

    // Test case: Insert coins and choose drink
    coins = 2'b01; // Insert one coin
    #10 choice = 1; // Choose drink
    #10 start = 1;
    
    // Wait for a while to observe the output
    #20;

    // Test case: Insert more coins and check change
    coins = 2'b10; // Insert two coins
    #10;

    // Finish simulation
    $stop;
end

initial begin
    $monitor("Time: %0t | Start: %b | Rst: %b | Clk: %b | Choice: %b | Coins: %b | Done: %b | Product: %b | Change: %b",
             $time, start, rst, clk, choice, coins, done, product, change);
end

endmodule