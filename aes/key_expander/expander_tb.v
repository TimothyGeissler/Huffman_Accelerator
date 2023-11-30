module expander_tb();
    reg clk;
    reg [3:0] round_num;
    reg [127:0] test_input;
    reg [127:0] previous_key;
    wire [127:0] test_output;

    // Instantiate the module under test
    key_expander uut (clk, round_num, test_input, test_output);

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("gtk_expander_dump.vcd");
        $dumpvars(0, uut);
        test_input = 128'h1b7c140922ae01a64bf41b8803ba4f4a;
        #500;
        round_num = 4'd1;
        $display("Output=%h", test_output);
        #50
        round_num = 4'd2;
        $display("Output=%h", test_output);
        #50
        round_num = 4'd3;
        $display("Output=%h", test_output);
        #50
        round_num = 4'd4;
        $display("Output=%h", test_output);
        #50
        round_num = 4'd5;
        $display("Output=%h", test_output);
        #50
        round_num = 4'd6;
        $display("Output=%h", test_output);
        #50
        round_num = 4'd7;
        $display("Output=%h", test_output);
        $finish;
    end

endmodule