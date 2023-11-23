module test_enc(
    input clk,
    input [127:0] inStream,
    output reg [127:0] outStream
);

    always @(posedge clk) begin
        outStream <= '1; // std verilog: {128{1'b1}}
    end

endmodule