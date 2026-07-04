module fir_filter(
    input clk,
    input reset,
    input signed [7:0] x_in,
    output reg signed [15:0] y_out
);

parameter h0 = 1;
parameter h1 = 2;
parameter h2 = 3;
parameter h3 = 4;

reg signed [7:0] x0, x1, x2, x3;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        x0 <= 0;
        x1 <= 0;
        x2 <= 0;
        x3 <= 0;
        y_out <= 0;
    end
    else
    begin
        x3 <= x2;
        x2 <= x1;
        x1 <= x0;
        x0 <= x_in;

        y_out <= (h0*x0) + (h1*x1) + (h2*x2) + (h3*x3);
    end
end

endmodule
