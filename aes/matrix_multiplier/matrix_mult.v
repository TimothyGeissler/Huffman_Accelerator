 `include "matrix_multiplier/matrix_mult_col.v"
 module Mixer(
    input wire [31:0] a0,
    input wire [31:0] a1,
    input wire [31:0] a2,
    input wire [31:0] a3,
    output reg [31:0] result_a0,
    output reg [31:0] result_a1,
    output reg [31:0] result_a2,
    output reg [31:0] result_a3
 );

    MixSingleColumn mixSingleColumn1 (
        .in(a0),
        .out(result_a0)
    );

    MixSingleColumn mixSingleColumn2 (
        .in(a1),
        .out(result_a1)
    );

    MixSingleColumn mixSingleColumn3 (
        .in(a2),
        .out(result_a2)
    );

    MixSingleColumn mixSingleColumn4 (
        .in(a3),
        .out(result_a3)
    );

 endmodule
