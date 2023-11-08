`timescale 1ns / 1ns

module TranslationTable
  (input clk,
   input ctrl_write,
   input ctrl_reset,
   input [6:0] wrAscii, // address of the register to write
   input [127:0] wrCode,
   input [6:0] wrCodeLength,
   input [6:0] rdAscii, // address of the register to read
   output [127:0] rdCode,
   output [6:0] rdCodeLength
   );

   reg [134:0] 	 codeTable [0:127]; // 128 registers (one for each ascii character), each 135 bits wide (stored code + length)

   assign rdCode = codeTable[rdAscii][134:7];
   assign rdCodeLength = codeTable[rdAscii][6:0];

   integer i;
   always @(posedge clk) begin
      if (ctrl_reset) begin
         for (i = 0; i < 128; i = i + 1) begin
            codeTable[i] <= 135'b0;
         end
      end else begin
         if (ctrl_write) begin
            codeTable[wrAscii] <= {wrCode, wrCodeLength};
         end
      end
   end
endmodule