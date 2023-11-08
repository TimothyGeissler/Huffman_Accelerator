`timescale 1ns/100ps
module table_tb;
    //module inputs
    reg clock, ctrl_write, ctrl_reset;
    reg [6:0] wrAscii, wrCodeLength, rdAscii;
    reg [127:0] wrCode;

    //expected module outputs
    reg [127:0] exp_rdCode;
    reg [6:0] exp_rdCodeLength;

    //module outputs
    wire [127:0] data_rdCode;
    wire [6:0] data_rdCodeLength;

    //instantiate the table
    TranslationTable tester (clock, ctrl_write, ctrl_reset, wrAscii, wrCode, wrCodeLength, rdAscii, data_rdCode, data_rdCodeLength);

    initial begin
        clock = 0;
        ctrl_write = 1;
        ctrl_reset = 0;
        wrAscii = 7'b1;
        wrCode = 128'b1;
        wrCodeLength = 7'd2;
        rdAscii = 7'b1;
        exp_rdCode = 128'b1;
        exp_rdCodeLength = 7'd2;
        $display("Initial values set:", data_rdCode, data_rdCodeLength);
        #10;
        $display("Expected values:", exp_rdCode, exp_rdCodeLength);
        $display("Actual values:", data_rdCode, data_rdCodeLength);
        #10 $finish;
    end

    always #5 clock = !clock;



endmodule