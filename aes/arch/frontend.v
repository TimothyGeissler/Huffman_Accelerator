`include "test_enc.v"

module frontend(
    input clk,
    input [4095:0] inBus, //32 parallel encryptors
    output [4095:0] outBus
);

genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : INST_LOOP
            test_enc enc_inst (
                .clk(clk),
                .inStream(inBus[i*128 +: 128]),
                .outStream(outBus[i*128 +: 128])
            );
        end
    endgenerate



endmodule