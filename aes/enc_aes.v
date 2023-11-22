`define INIT 3'b111
`define SUB 3'b000
`define SHIFT 3'b001
`define MIX 3'b010
`define ROUND 3'b011
`define FINISH 3'b110

`include "sub_box/s_box.v"

module enc_aes(
    input clk,
    input [127:0] inStream,
    output reg [127:0] outStream
);

    // MISC components
    reg [2:0] state = `INIT; // Start at init stage
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

    always @(posedge clk) begin
        case (state)
            `INIT: begin
                // Unpack array into matrix
                $display("instream=%h", inStream);
                for (i = 0; i < 4; i = i + 1) begin
                    row[i] = inStream[i*32 +: 31];
                end
                $display("##INPUT##\nrow0=%h\nrow1=%h\nrow2=%h\nrow3=%h", row[0], row[1], row[2], row[3]);
                state = `SUB; //Goto next stage
            end
            `SUB: begin
                // Iterate through the matrix
                for (i = 0; i < 4; i = i + 1) begin
                    for (j = 0 ; j < 4; j = j + 1) begin
                        inputSub = row[i][j*8 +: 8];
                        #1 // Wait for some gate delay
                        row[i][j*8 +: 7] = outputSub;
                    end
                    //$display("Substituted row=%h", row[i]);
                    
                end
                state = `FINISH; //`SHIFT; //Goto next stage
            end
            `SHIFT: begin
                // Row 2 lshift = 1
                row[1] = {row[1][6:0], row[1][7]};
                // Row 3 lshift = 2
                row[2] = {row[2][5:0], row[2][7:6]};
                // Row 4 lshift = 3
                row[3] = {row[3][4:0], row[3][7:5]};
                state = `MIX; //Goto next stage
            end
            `MIX: begin
                state = `ROUND; //Goto next stage
            end
            `ROUND: begin
                state = `FINISH; // Goto next stage
            end
            `FINISH: begin
                // Pack matrix back into array
                for (i = 0; i < 4; i = i + 1) begin
                    $display("Substituted row=%h", row[i]);
                    outStream[i*32 +: 31] = row[i];
                end
            end
        endcase

    end

endmodule