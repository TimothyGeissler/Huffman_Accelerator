`timescale 1ns/1ps

module MixSingleColumn_tb;

    reg [7:0] a0, a1, a2, a3;
    wire [7:0] result_a0, result_a1, result_a2, result_a3;

    MixSingleColumn uut (
        .in({a0, a1, a2, a3}),
        .out({result_a0, result_a1, result_a2, result_a3})
    );

    // Initial block for test stimulus
    initial begin
        // Test case 1
        a0 = 8'h7c;
        a1 = 8'h7b;
        a2 = 8'h76;
        a3 = 8'hd2;

        #10; // Wait for 10 time units

        $display("result_a0=%h", result_a0);
        $display("result_a1=%h", result_a1);
        $display("result_a2=%h", result_a2);
        $display("result_a3=%h", result_a3);
        // Check the results
        if ((result_a0 === 8'hd1) &&
            (result_a1 === 8'hc2) &&
            (result_a2 === 8'h86) &&
            (result_a3 === 8'h36))
            
            $display("Test case 1 passed");
        else
            $display("Test case 1 failed");

        // You can add more test cases as needed

        // End simulation
        $finish;
    end

endmodule
