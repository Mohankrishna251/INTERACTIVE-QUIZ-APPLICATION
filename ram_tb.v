`timescale 1ns/1ps

module ram_tb;

reg clk;
reg we;
reg [3:0] addr;
reg [7:0] data_in;
wire [7:0] data_out;

ram uut(
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

// Clock Generation
always #5 clk = ~clk;

initial
begin
    clk = 0;

    // Write 25 to Address 1
    we = 1;
    addr = 4'd1;
    data_in = 8'd25;
    #10;

    // Write 50 to Address 2
    addr = 4'd2;
    data_in = 8'd50;
    #10;

    // Read Address 1
    we = 0;
    addr = 4'd1;
    #10;

    // Read Address 2
    addr = 4'd2;
    #10;

    $finish;
end

endmodule
