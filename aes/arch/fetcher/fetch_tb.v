//iverilog -g2005-sv -o load fetch.v fetch_tb.v

module fetch_tb();

    reg clk;
    wire [4095:0] test_output;

    fetch uut(clk, test_output);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, uut);

        #100
        
        $finish;
    end

    always @(test_output) begin
        $display("data: %h", test_output);
    end

endmodule