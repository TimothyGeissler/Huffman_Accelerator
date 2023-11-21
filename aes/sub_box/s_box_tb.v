`timescale 1ns / 1ns

module s_box_tb;

  // Inputs
  reg clk;
  reg [7:0] inputByte;

  // Outputs
  wire [7:0] outputByte;

  // Instantiate YourModule
  s_box uut (
    .clk(clk),
    .inByte(inputByte),
    .subByte(outputByte)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus generation
  initial begin
    // Apply inputs and wait for some time
    inputByte = 8'h9a; // Replace with your test values
    #10
    assert (outputByte == 8'hb8) $display ("TEST PASSED");
    inputByte = 8'h9f;
    #10 
    assert (outputByte == 8'hdb) $display ("TEST PASSED");
    inputByte = 8'h06;
    #10
    assert (outputByte == 8'h6f) $display ("TEST PASSED");

    // End simulation after some time
    #100 $finish;
  end


endmodule
