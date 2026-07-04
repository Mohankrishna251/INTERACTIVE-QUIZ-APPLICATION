module pipeline_processor(
    input clk,
    input reset
);

reg [7:0] instruction_memory [0:7];
reg [7:0] register_file [0:3];
reg [7:0] data_memory [0:7];

// Pipeline Registers
reg [7:0] IF_ID;
reg [7:0] ID_EX;
reg [7:0] EX_WB;

reg [2:0] pc;

reg [1:0] opcode;
reg [1:0] rd;
reg [1:0] rs;

initial begin
    instruction_memory[0] = 8'b00000110; // ADD R1,R2
    instruction_memory[1] = 8'b01000110; // SUB R1,R2
    instruction_memory[2] = 8'b10010000; // LOAD R1,0
    instruction_memory[3] = 8'b00000000;

    register_file[0] = 8'd10;
    register_file[1] = 8'd20;
    register_file[2] = 8'd5;
    register_file[3] = 8'd15;

    data_memory[0] = 8'd99;
end

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        pc <= 0;
        IF_ID <= 0;
        ID_EX <= 0;
        EX_WB <= 0;
    end
    else
    begin

        // Stage 4 : Write Back
        opcode = EX_WB[7:6];
        rd = EX_WB[5:4];

        case(opcode)
            2'b00: register_file[rd] <= register_file[1] + register_file[2];
            2'b01: register_file[rd] <= register_file[1] - register_file[2];
            2'b10: register_file[rd] <= data_memory[0];
        endcase

        // Stage 3 : Execute
        EX_WB <= ID_EX;

        // Stage 2 : Decode
        ID_EX <= IF_ID;

        // Stage 1 : Fetch
        IF_ID <= instruction_memory[pc];
        pc <= pc + 1;

    end
end

endmodule
