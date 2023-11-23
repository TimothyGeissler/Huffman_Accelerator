module test_enc(
    input clk,
    input [127:0] inStream,
    output reg [127:0] outStream
);

    // Dummy encryptor - replace input with all 1s
    always @(posedge clk) begin
        outStream <= '1; // std verilog: {128{1'b1}}
    end

endmodule