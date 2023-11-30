`define INIT1 3'b111
`define INIT2 3'b100
`define SHIFT 3'b000
`define SUB 3'b001
`define XOR 3'b010
`define GEN_COL 3'b011
`define FINISH 3'b110

`include "rcon/rcon.v"

module key_expander(  //assuming 128 bit key
    input clk,
    input [3:0] index,
    input [127:0] inStream,
    output reg [127:0] outStream
);

    // MISC components
    reg [2:0] state = `INIT1; // Start at init stage
    reg [31:0] col[3:0];
    reg [3:0] roundNumber;

    // SUB stage components
    reg [7:0] inputSub;
    wire [7:0] outputSub;

    wire [7:0] rcon;

    reg [31:0] temp;
    reg [31:0] newCol[3:0];

    reg [127:0] keys[10:0];

    integer i, j;

    s_box sub_table(
    .clk(clk),
    .inByte(inputSub),
    .subByte(outputSub)
    );

    rcon_table rcon_table(
    .clk(clk),
    .roundNumber(roundNumber),
    .rcon(rcon)
    );

    assign outStream = keys[index];

    always @(posedge clk) begin
        case (state)
            `INIT1: begin
                roundNumber = 4'b0;
                keys[0] = inStream;
                for (i = 0; i < 4; i = i + 1) begin
                    col[3-i] = inStream[i*32 +: 32];
                end
                state = `SHIFT; //Goto next stage
            end
            `INIT2: begin
                for(i = 0; i < 4; i = i + 1) begin
                    col[3-i] = keys[roundNumber][i*32 +: 32];
                end
                state = `SHIFT; //Goto next stage
            end
            `SHIFT: begin
                temp = {col[3][23:0], col[3][31:24]};    
                state = `SUB; //Goto next stage           
            end
            `SUB: begin
                // Iterate through the matrix
                for (i = 0; i < 4; i = i + 1) begin
                    inputSub = temp[i*8 +: 8];
                    #1 // Wait for some gate delay
                    temp[i*8 +: 8] = outputSub;
                end
                state = `XOR; //Goto next stage
            end
            `XOR: begin
                newCol[0] =  temp^col[0]^{rcon,8'h00,8'h00,8'h00}; 
                newCol[1] = newCol[0]^col[1];
                newCol[2] = newCol[1]^col[2];
                newCol[3] = newCol[2]^col[3];
                state = `FINISH; //Goto next stage
            end
            `FINISH: begin
                roundNumber = roundNumber + 1;
                keys[roundNumber] = {newCol[0], newCol[1], newCol[2], newCol[3]};
                if(roundNumber == 10) begin
                    state = `INIT1;
                end
                else begin
                    state = `INIT2;
                end
            end
        endcase

    end

endmodule