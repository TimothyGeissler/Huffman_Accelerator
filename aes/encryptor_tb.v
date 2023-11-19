module encryptor_tb();
    reg clk;
    reg [1023:0] test_input;
    wire [1023:0] test_output;

    // Instantiate the module under test
    enc_aes uut (clk, test_input, test_output);

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        test_input = 1024'b0;
        #100
        //$display("%b", test_output);
        $finish;
    end

endmodule