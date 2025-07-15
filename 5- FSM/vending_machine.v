module vendig_machine(
    input start,rst,clk,choice, // chock = 0, drink = 1
    input [1:0] coins,
    output reg done,
    output reg [1:0] product, change
);

// Vending Machine State Machine
localparam [3:0] s0 = 0, s1 = 1, chock = 2, drink = 3, s2 = 4, s3 = 5, s4 = 6, s5 = 7;
reg [3:0] ps,ns;


always @(posedge clk, negedge rst) begin
    if (!rst)  
        ps <= s0;
    else
        ps <= ns;

end

always @(coins,choice,start,ps) begin
    case (ps)
        s0: ns = (start == 1)? s1 : s0;
        s1: ns = (choice) ? drink : chock;
        chock: ns = (coins == 0)? s2 : s0;
        drink: ns = (coins == 0)? s3 : ((coins == 1)? s5: s0);
        s2: ns = s0;
        s3: ns = (coins == 0)? s4 : s0;
        s4: ns = s0;
        s5: ns = s0;
        default: ns = s0;
    endcase
end

always @(*) begin
    case (ps)
        s0,s1,chock,drink: begin done = 0; product = 0; change = 0; end 
        s2: begin
            done = 1; product = 1;
            change = (coins == 0)? 0 : ((coins == 1)? 1 : 4);
        end
        s3: begin
            done = (coins == 0)? 0 : 1;
            product = (coins == 0)? 0 : 2;
            change = (coins == 0 || coins == 1)? 0 : 3;
        end
        s4: begin
            done = 1; product = 2;
            change = (coins == 0)? 0 : ((coins == 1)? 1 : 4);
        end
        s5: begin
            done = 1; product = 2;
            change = (coins == 0)? 0 : ((coins == 1)? 1 : 4);
        end
        default: begin done = 0; product = 0; change = 0; end
    endcase
end

endmodule