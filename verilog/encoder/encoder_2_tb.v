`timescale 1ns / 1ns

module encoder_2_tb;

  // Inputs
  reg clk;
  reg [7:0] inBits;
  reg [263:0] inTable [255:0];

  // Outputs
  wire [255:0] outBits;

  // Instantiate the encoder_2 module
  encoder_2 myEncoder (
    .clk(clk),
    .inBits(inBits),
    .inTable(inTable),
    .outBits(outBits)
  );

  integer i;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus generation
  initial begin
    inBits = 8'b00000000; // Set your input values here

    // Initialize inTable with some values
    for (i = 0; i < 256; i = i + 1) begin
      inTable[i] = {i, 8'b1};
      //$display("inTable[%d]: %b", i, {i, 8'b1});
    end

    // Apply inputs and wait for some time
    #10 inBits = 8'b00000001;
    #10 inBits = 8'b00000010;
    #10 inBits = 8'b00000011;
    // Add more test cases as needed

    // End simulation after some time
    #100 $finish;
  end

  // Display results
  always @(posedge clk) begin
    $display("inBits=%b outBits=%h", inBits, outBits);
  end

endmodule
