module ALU_DUT;

reg [3:0] A,B;
reg cin, pass_A,pass_B;
reg [1:0] opcode;
wire [3:0] out;
wire cout;


ALU uut (A,B,cin,pass_A,pass_B,opcode,out,cout);


task validate;
    begin
        if (pass_A) begin
            if (out !== A) $display ("Error at time %d. Failed to pass A. out = %d",$time,out);
        end
        else if (pass_B) begin
            if (out !== B) $display ("Error at time %d. Failed to pass B. out = %d",$time,out);
        end
        else begin
            case (opcode)
                2'b00: if (out !== (A & B)) $display ("Error at time %d. Failed to AND A and B. out = %d",$time,out);
                2'b01: if ({cout,out} !== (A + B + cin)) $display ("Error at time %d. Failed to add A and B. out = %d",$time,out);
                2'b10: if ({cout,out} !== (A - B)) $display ("Error at time %d. Failed to sub A and B. out = %d",$time,out);
                2'b11: if (out !== ^B) $display ("Error at time %d. Failed to xor reduce B. out = %d",$time,out);
                default: $display("opcode error");
            endcase
        end
    end

endtask

initial begin
    A = 0; B = 0; cin = 0; pass_A = 0; pass_B = 0; opcode = 0;
    #10
    repeat (100)begin
        A = $random;
        B = $random;
        cin = $random % 2;
        pass_A = $random % 2;
        pass_B = $random % 2;
        opcode = $random % 4;
        #10
        validate();
    end
    $stop;
end
initial begin
    $monitor("A = %d\tB = %d\tcin = %b\tpass_A = %b\tpass_B = %b\topcode = %b\t out = %d\tcout = %b",
    A,B,cin,pass_A,pass_B,opcode,out,cout);
end

endmodule