`timescale 1ns/1ps
module encryptor_tb();
    reg clk;
    reg [0:127] test_input;
    wire [0:127] test_output;
    reg [127:0] key;

    // Instantiate the module under test
    enc_aes uut (clk, test_input, key, test_output);

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("gtk_encryptor_dump.vcd");
        $dumpvars(0, uut);
        key = 128'h1b7c140922ae01a64bf41b8803ba4f4a;
        test_input = 128'h01071f7f01071f7f00030f3f00030f3f;
        #1000;
        $display("Output=%h", test_output);
        $finish;
    end

endmodule