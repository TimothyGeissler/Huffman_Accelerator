`define INIT 4'b111
`define INITIAL_ROUNDKEY 4'b100
`define SUB 4'b000
`define SHIFT 4'b001
`define MIX 4'b010
`define ADD_ROUND_KEY 4'b011
`define FINISH_ROUND 4'b101
`define FINISH 4'b110

`include "sub_box/s_box.v"
`include "key_expander/key_expander.v"
`include "matrix_multiplier/matrix_mult.v"

module enc_aes(
    input clk,
    input [0:127] inStream,
    input [0:127] key,
    output reg [127:0] outStream
);

    // MISC components
    reg [3:0] state = `INIT; // Start at init stage
    reg lastRound = 1'b0; // flag for whether this is the last round
    reg [31:0] row[3:0];
    integer i, j;

    // SUB stage components
    reg [7:0] inputSub;
    wire [7:0] outputSub;

    // Instantiate substitution table
    s_box sub_table (
    .clk(clk),
    .inByte(inputSub),
    .subByte(outputSub)
    );

    // MIX stage components
    reg [31:0] row_copy[0:3];
    reg [31:0] row_copy2[0:3];

    Mixer Mixer(
        .a0(row_copy[0]),
        .a1(row_copy[1]),
        .a2(row_copy[2]),
        .a3(row_copy[3]),
        .result_a0(row_copy2[0]),
        .result_a1(row_copy2[1]),
        .result_a2(row_copy2[2]),
        .result_a3(row_copy2[3])
    );

    // ROUND_KEY stage components
    reg [127:0] round_key[10:0];
    reg [3:0] round_num;
    reg [127:0] key_in;
    reg [127:0] key_out;
    key_expander key_expander(clk, round_num, key_in, key_out);

    always @(posedge clk) begin
        case (state)
            `INIT: begin
                // Unpack array into matrix
                $display("instream=%h", inStream);
                for (i = 0; i < 4; i = i + 1) begin
                    row[i] = inStream[i*32 +: 32];
                end
                key_in = key;
                round_num = 1;
                state = `INITIAL_ROUNDKEY; //Goto next stage
                
            end
            `INITIAL_ROUNDKEY: begin
                for (i = 0; i < 4; i = i + 1) begin
                    row[3-i] ^= key_in[i*32 +: 32];
                end
                state = `SUB; //Goto next stage

            end
            `SUB: begin
                // Iterate through the matrix
                for (i = 0; i < 4; i = i + 1) begin
                    for (j = 0 ; j < 4; j = j + 1) begin
                        inputSub = row[i][j*8 +: 8];
                        #1 // Wait for some gate delay
                        row[i][j*8 +: 8] = outputSub;
                    end
                end
                state = `SHIFT; //Goto next stage
            end
            `SHIFT: begin
                row_copy[0] = {row[0][31:24], row[1][23:16], row[2][15:8], row[3][7:0]};
                // Row 2 lshift = 1
                row_copy[1] = {row[1][31:24], row[2][23:16], row[3][15:8], row[0][7:0]};

                row_copy[2] = {row[2][31:24], row[3][23:16], row[0][15:8], row[1][7:0]};

                row_copy[3] = {row[3][31:24], row[0][23:16], row[1][15:8], row[2][7:0]};
                state = `MIX; //Goto next stage
            end
            `MIX: begin
                state = `ADD_ROUND_KEY; //Goto next stage
            end
            `ADD_ROUND_KEY: begin
                // Unpack array into matrix
                if(lastRound==1'b1) begin
                    for (i = 0; i < 4; i = i + 1) begin
                    row[3-i] = row_copy[3-i]^key_out[i*32 +: 32];
                    end
                end
                else begin
                    for (i = 0; i < 4; i = i + 1) begin
                    row[3-i] = row_copy2[3-i]^key_out[i*32 +: 32];
                    end
                end
                state = `FINISH_ROUND; //Goto next stage
            end
            `FINISH_ROUND: begin
                $display("##FINISH_ROUND##\nround_num=%h", round_num);
                $display("##FINISH_ROUND##\nrow0=%h\nrow1=%h\nrow2=%h\nrow3=%h", row[0], row[1], row[2], row[3]);
                round_num = round_num + 1;
                key_in = key_out;
                if (round_num == 10) begin
                    lastRound = 1'b1; //Goto next stage
                end
                else begin
                    lastRound=1'b0;
                end
                if(round_num == 11) begin
                    state = `FINISH;
                end
                else begin
                    state = `SUB;
                end
            end
            `FINISH: begin
                $display("##FINISH##\nrow0=%h\nrow1=%h\nrow2=%h\nrow3=%h", row[0], row[1], row[2], row[3]);
                outStream = {row[0], row[1], row[2], row[3]};
            end
        endcase
    end
endmodule