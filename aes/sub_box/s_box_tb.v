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
    #10 inputByte = 8'h63; // Replace with your test values
    #10 inputByte = 8'h7C;
    #10 inputByte = 8'hF2;
    // Add more test cases as needed

    // End simulation after some time
    #100 $finish;
  end

  // Display results
  always @(posedge clk) begin
    $display("Time=%0t inputByte=%h outputByte=%h", $time, inputByte, outputByte);
  end

endmodule
