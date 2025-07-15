module freq_div_3_pwm(input clk,rst,output reg clk_3);

reg [1:0] modCounter;

assign clk_3 = modCounter[1];

always @(posedge clk,negedge rst) begin
    if (!rst || modCounter == 2'b10) begin
        modCounter <= 0;
        clk_3 <= 0;
    end
    else begin
        modCounter <= modCounter + 1;
    end
end

endmodule