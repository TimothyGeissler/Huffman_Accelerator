// T. Geissler
// Compile with iverilog -o encoder.vvp encoder.v encoder_tb.v 

module encoder (
    input [127:0] inBits,
    output reg [6:0] outBits
);

integer i;

always @(*) begin
    outBits = 0;
    
    for (i = 0; i < 128; i = i + 1) begin
        if (inBits[i] == 1'b1) begin
            outBits = outBits + 1;
        end
    end

end

endmodule