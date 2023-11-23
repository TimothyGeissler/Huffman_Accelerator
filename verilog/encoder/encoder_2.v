module encoder_2(
    input clk,
    input [7:0] inBits,
    input [263:0] inTable [255:0],
    output reg [255:0] outBits
);

integer i;

initial begin
    for (i = 0; i < 256; i = i + 1) begin
      $display("inTable[%d]: %b", i, inTable[i]);
    end
end

reg rdCode;
reg rdCodeLength;

    always @(posedge clk) begin
        rdCode = inTable[inBits][134:7];
        rdCodeLength = inTable[inBits][6:0];
        outBits = rdCode;
        $display("Code: %b, Len: %b", rdCode, rdCodeLength);
    end



endmodule