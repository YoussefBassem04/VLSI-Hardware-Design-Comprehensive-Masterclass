module color_balls_box(
    input [1:0] in, // Red = 0, Blue = 1, Green = 2
    input clk,rst,
    output reg det
);

localparam [2:0] s0 = 0, R = 1, B = 2, G = 3, GB = 4, RG = 5, RB = 6, GBR = 7;

reg [2:0] ps ,ns;

// state memory
always @(posedge clk, negedge rst) begin
    if (!rst)
        ps <= s0;
    else
        ps <= ns;
end

// ns logic
always @(in,ps) begin
    case (ps)
        s0: ns = (in == 0)? R : ((in == 1)? B : G);
        R:  ns = (in == 1)? RB :((in == 2)? RG : R); 
        B:  ns = (in == 0)? RB :((in == 2)? GB : B); 
        G:  ns = (in == 0)? RG :((in == 1)? GB : G); 
        RG: ns = (in == 1)? GBR : ((in == 0)? RG : s0); 
        RB: ns = (in == 2)? GBR : ((in == 0)? RB : s0); 
        GB: ns = (in == 0)? GBR : ((in == 2)? GB : s0); 
        default: ns = s0;
    endcase
end

// output logic
always @(in,rst) begin
    case (ps)
        RG: det = (in == 1);
        RB: det = (in == 2);
        GB: det = (in == 0);
        default: det = 0;
    endcase   
end

endmodule