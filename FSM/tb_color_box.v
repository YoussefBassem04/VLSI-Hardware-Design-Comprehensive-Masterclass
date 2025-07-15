`timescale 1ns / 1ps

module tb_color_balls_box;

reg [1:0] in; // Color input: 0 = Red, 1 = Blue, 2 = Green
reg clk, rst;
wire det;

color_balls_box uut (
    .in(in),
    .clk(clk),
    .rst(rst),
    .det(det)
);

// Clock generation
initial clk = 0;
always #5 clk = ~clk; // 10ns period

// Task to apply a single color input
task apply_color(input [1:0] color);
begin
    @(negedge clk);
    in = color;
    @(posedge clk); // wait for FSM transition
    #1;              // wait for output to update
    //print_color(color);
    //$display("\tdet = %b", det);
end
endtask


// Task to display human-readable output
task print_color(input [1:0] color);
    case (color)
        2'b00: $write("Red   ");
        2'b01: $write("Blue  ");
        2'b10: $write("Green ");
        default: $write("Unknown ");
    endcase
endtask

initial begin
    // Initialization
    in = 0;
    rst = 0;
    #10;
    rst = 1;

    $display("\n--- Test 1: R -> G -> B ---");
    apply_color(2'b00); print_color(2'b00); $display("\tdet = %b", det);
    //@(negedge clk);
    apply_color(2'b10); print_color(2'b10); $display("\tdet = %b", det);
    //@(negedge clk);
    apply_color(2'b01); print_color(2'b01); $display("\tdet = %b", det); // should detect

    // Wait and reset
    #10; rst = 0; #10; rst = 1;

    $display("\n--- Test 2: B -> R -> G ---");
    apply_color(2'b01); print_color(2'b01); $display("\tdet = %b", det);
    //@(negedge clk);
    apply_color(2'b00); print_color(2'b00); $display("\tdet = %b", det);
    //@(negedge clk);
    apply_color(2'b10); print_color(2'b10); $display("\tdet = %b", det); // should detect

    #10; rst = 0; #10; rst = 1;

    $display("\n--- Test 3: G -> B -> R ---");
    apply_color(2'b10); print_color(2'b10); $display("\tdet = %b", det);
    //@(negedge clk);
    apply_color(2'b01); print_color(2'b01); $display("\tdet = %b", det);
    //@(negedge clk);
    apply_color(2'b00); print_color(2'b00); $display("\tdet = %b", det); // should detect

    #10; rst = 0; #10; rst = 1;

    $display("\n--- Test 4: Repeating R Only ---");
    apply_color(2'b00); print_color(2'b00); $display("\tdet = %b", det);
    //@(negedge clk);
    apply_color(2'b00); print_color(2'b00); $display("\tdet = %b", det);
    //@(negedge clk);
    apply_color(2'b00); print_color(2'b00); $display("\tdet = %b", det); // never detect

    #10; rst = 0; #10; rst = 1;

    $display("\n--- Test 5: R -> G -> R -> B (non-overlapping) ---");
    apply_color(2'b00); print_color(2'b00); $display("\tdet = %b", det);
    //@(negedge clk);
    apply_color(2'b10); print_color(2'b10); $display("\tdet = %b", det);
    //@(negedge clk);
    apply_color(2'b00); print_color(2'b00); $display("\tdet = %b", det);
    //@(negedge clk);
    apply_color(2'b01); print_color(2'b01); $display("\tdet = %b", det); // should detect

    #10;
    $display("\n--- Testbench Finished ---");
    $finish;
end

endmodule
