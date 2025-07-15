module mux_4to1_df(input [3:0] I, input [1:0] sel,
output y);

assign y = (sel == 2'b00)? I[0] :
           (sel == 2'b01)? I[1] :
           (sel == 2'b10)? I[2] : I[3]; // cascaded muxes --> more delay

endmodule