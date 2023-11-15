// T. Geissler
// Compile with iverilog -o encoder.vvp encoder.v encoder_tb.v 
// need to modify for new size that will be used

module Tallier (
    input [5:0] inBits,
    output reg [7:0] outBits
);

integer i;

always @(*) begin
    outBits = 0;
    
    for (i = 0; i < 6; i = i + 1) begin
        if (inBits[i] == 1'b1) begin
            outBits = outBits + 1;
        end
    end

end

endmodule