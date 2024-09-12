module DSP_Filter #(parameter N=7)(
    input clk,               // Clock signal
    input rst,               // Reset signal
    input [N:0] x,      // Input 
    output reg [N:0] y   // Output 
);

localparam  H1 = 0,
            H2 = 1,
            H3 = 2,
            H4 = 3;

reg [N:0] delayed_x [3:0];

always @(posedge clk or negedge rst) begin
    if (!rst)begin
        delayed_x[0] <= 0;
    delayed_x[1] <= 0;
    delayed_x[2] <= 0;
    delayed_x [3] <= 0;
    end
    else
    begin
        delayed_x [3] <= delayed_x[2];
        delayed_x [2] <= delayed_x[1];
        delayed_x [1] <= delayed_x[0];
        delayed_x [0] <= x; 
    end
end

always @(*) begin
    // y = (delayed_x [0] >> H1) + (delayed_x [1] >> H2) +(delayed_x [2] >> H3 + (delayed_x [3] >> H4);  // have a degree of error but it is smaall
     y =  (delayed_x [0] ) + (delayed_x [1] * 0.5) +(delayed_x [2] * 0.25) + (delayed_x [3] * 0.125); // accurate but need alot of resources
end

endmodule
