module encryptor_tb();
    reg clk;
    reg [127:0] test_input;
    wire [127:0] test_output;

    // Instantiate the module under test
    enc_aes uut (clk, test_input, test_output);

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("gtk_encryptor_dump.vcd");
        $dumpvars(0, uut);

        test_input = 128'h11111111000000001111111100000000;
        #100
        $display("Output=%h", test_output);
        $finish;
    end

endmodule