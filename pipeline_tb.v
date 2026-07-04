`timescale 1ns/1ps

module pipeline_tb;

reg clk;
reg reset;

pipeline_processor uut(
    .clk(clk),
    .reset(reset)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;

    #10;
    reset = 0;

    #100;

    $finish;
end

endmodule
