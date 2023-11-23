//iverilog -g2005-sv -o arch frontend.v frontend_tb.v
module frontend_tb();

    reg clk;
    reg [4095:0] test_input;
    wire [4095:0] test_output;

    frontend uut(clk, test_input, test_output);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Check if frontend splits input & stitches output
    initial begin
        test_input = 4096'b0;
        $display("%h", test_input);
        #10
        assert(test_output == '1) $display("TEST PASSED");
        $finish;
    end

endmodule