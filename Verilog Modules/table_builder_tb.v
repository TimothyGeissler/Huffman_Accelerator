`timescale 1ns/100ps
module table_builder_tb;
    //module inputs
    reg clock, ctrl_start;
    reg ctrl_wrAscii [0:5];
    reg [7:0] wrAscii [0:5];

    TableBuilder tester(.clk(clock), .ctrl_wrAscii(ctrl_wrAscii), .ctrl_start(ctrl_start), .wrAscii(wrAscii));
    initial begin
        $dumpfile("table_builder_tb.vcd");
        $dumpvars(0, table_builder_tb);
        clock = 0;
        ctrl_start = 0;
        #2;
        
        ctrl_wrAscii[0] = 1;
        ctrl_wrAscii[1] = 1;
        ctrl_wrAscii[2] = 1;
        ctrl_wrAscii[3] = 1;
        ctrl_wrAscii[4] = 1;
        ctrl_wrAscii[5] = 1;

        wrAscii[0] = 8'b1;
        wrAscii[1] = 8'd2;
        wrAscii[2] = 8'd3;
        wrAscii[3] = 8'd4;
        wrAscii[4] = 8'd5;
        wrAscii[5] = 8'd6;
        
        ctrl_start = 1;

        #4;
        ctrl_start = 0;

        
        
        #200;
        $finish;
    end

    always #5 clock = !clock;

endmodule