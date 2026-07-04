`timescale 1ns/1ps

module alu_tb;

reg [3:0] A, B;
reg [2:0] Sel;
wire [3:0] Result;

alu uut(
    .A(A),
    .B(B),
    .Sel(Sel),
    .Result(Result)
);

initial begin
    A = 4'b1010;
    B = 4'b0011;

    Sel = 3'b000; #10; // ADD
    Sel = 3'b001; #10; // SUB
    Sel = 3'b010; #10; // AND
    Sel = 3'b011; #10; // OR
    Sel = 3'b100; #10; // NOT

    $finish;
end

endmodule
