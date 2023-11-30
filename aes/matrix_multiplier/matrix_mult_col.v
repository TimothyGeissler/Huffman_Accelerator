module MixSingleColumn (
    input wire [31:0] in,
    output reg [31:0] out
);
    wire [7:0] a0, a1, a2, a3;
    reg [7:0] result_a0, result_a1, result_a2, result_a3;


    assign a0 = in[31:24];
    assign a1 = in[23:16];
    assign a2 = in[15:8];
    assign a3 = in[7:0];

    assign out[31:24] = result_a0;
    assign out[23:16] = result_a1;
    assign out[15:8] = result_a2;
    assign out[7:0] = result_a3;

    reg [7:0] t, u;

    always @* begin
        t = a0 ^ a1 ^ a2 ^ a3;
        u = a0;

        result_a0 = a0 ^ t ^ xtime(a0 ^ a1);
        result_a1 = a1 ^ t ^ xtime(a1 ^ a2);
        result_a2 = a2 ^ t ^ xtime(a2 ^ a3);
        result_a3 = a3 ^ t ^ xtime(a3 ^ u);
    end

    // xtime function
    function [7:0] xtime;
        input [7:0] a;
        begin
            if (a & 8'h80) // Check if the MSB is 1
                xtime = ((a << 1) ^ 8'h1b) & 8'hff;
            else
                xtime = a << 1;
        end
    endfunction

endmodule
