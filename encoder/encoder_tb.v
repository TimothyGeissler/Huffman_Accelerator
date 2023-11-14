// T. Geissler
// Compile with iverilog -o encoder.vvp encoder.v encoder_tb.v 

module encoder_tb();

  reg [127:0] test_input;
  wire [6:0] test_output;

  // Instantiate the module under test
  encoder uut (test_input, test_output);

  // Initial block for testbench
  initial begin
    // Test case 1: All bits are zero
    test_input = 128'b0;
    #10; // Wait for some simulation cycles
    $display(test_output);

    // Test case 2: All bits are one
    test_input = 128'b1;
    #10; // Wait for some simulation cycles
    $display(test_output);

    // Test case 3: Random bits (7)
    test_input = 128'b100111010101;
    #10; // Wait for some simulation cycles
    $display(test_output);

    // Test case 4: Alternate bits are one
    test_input = 128'b0101010101010101010101010101010101010101010101010101010101010101;
    #10; // Wait for some simulation cycles
    $display(test_output);

    $finish; // End simulation
  end


endmodule