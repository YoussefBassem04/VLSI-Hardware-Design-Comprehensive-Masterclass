module mux_2to1_bh(input [1:0] I,input sel,
output reg y);

always @(*) begin
    if (sel) begin
        y = I[1];
    end
    else begin
        y = I[0];
    end
end


endmodule