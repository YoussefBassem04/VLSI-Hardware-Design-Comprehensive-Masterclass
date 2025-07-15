module fifo #(parameter DATA_WIDTH = 8, DEPTH = 8)(
    input clk,rst,r_en,w_en,
    input [DATA_WIDTH - 1:0] data_in,
    output reg [DATA_WIDTH - 1:0] data_out,
    output full,empty
);

localparam PTR_WIDTH = $clog2(DEPTH);
reg [PTR_WIDTH:0] w_ptr,r_ptr;

reg [DATA_WIDTH - 1:0] my_fifo [0 : DEPTH - 1];

assign empty = (w_ptr == r_ptr);
assign full = ((w_ptr[PTR_WIDTH] != r_ptr[PTR_WIDTH]) &&
              (w_ptr[PTR_WIDTH - 1:0] == r_ptr[PTR_WIDTH - 1:0]));

integer i;
always @(posedge clk) begin
    if (!rst) begin
        for (i = 0;i < DEPTH;i = i + 1) begin
            my_fifo[i] <= 0;
        end
        w_ptr <= 0;
        r_ptr <= 0;
        data_out <= 0;
    end
    else if (!full && w_en) begin
        my_fifo[w_ptr[PTR_WIDTH-1:0]] <= data_in;
        w_ptr <= w_ptr + 1;
    end
    else if (!empty && r_en) begin
        data_out <= my_fifo[r_ptr[PTR_WIDTH-1:0]];
        r_ptr <= r_ptr + 1;
    end
end

endmodule