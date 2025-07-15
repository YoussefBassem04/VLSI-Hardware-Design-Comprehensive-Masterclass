module encoder_4_2_bh(
    input [3:0] I, 
    output reg [1:0]  y,
    output reg v);


always @(*) begin
    case (I)
        4'b1000: {v,y} = 3'b100;
        4'b0100: {v,y} = 3'b101; 
        4'b0010: {v,y} = 3'b110; 
        4'b0001: {v,y} = 3'b111; 
        default: {v,y} = 0;
    endcase
end

endmodule