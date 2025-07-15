module ALU(
    input [3:0] A,B,
    input cin, pass_A,pass_B,
    input [1:0] opcode,
    output reg [3:0] out,
    output reg cout
);

always @(*) begin
    if (pass_A) begin
        out = A;
        cout = 0;
    end
    else if (pass_B) begin
        out = B;
        cout = 0;
    end
    else begin
        case (opcode)
            2'b00: begin out = A & B; cout = 0; end
            2'b01: {cout,out} = A + B + cin;
            2'b10: {cout,out} = A - B;
            2'b11: begin out = ^B; cout = 0; end
            default: begin out = 0; cout = 0; end
        endcase
    end
end

endmodule