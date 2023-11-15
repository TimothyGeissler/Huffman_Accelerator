`timescale 1ns / 1ns

module QueueSlot
  (input clk,
   input ctrl_wrQueuePos,
   input ctrl_wrAscii,
   input ctrl_wrFreq,
   input ctrl_wrHead,
   input ctrl_reset,
   input [7:0] wrQueuePos, // queue_pos 
   input [7:0] wrAscii,
   input [31:0] wrFreq, //may need to adjust max frequency value
   input wrHead,
   output [7:0] rdQueuePos,
   output [7:0] rdAscii,
   output [31:0] rdFreq,
   output rdHead
   );

   reg [47:0] queue_slot;

   assign rdAscii = queue_slot[47:40];
   assign rdHead = queue_slot[39];
   assign rdQueuePos = queue_slot[38:32];
   assign rdFreq = queue_slot[31:0];

   always @(posedge clk) begin
      if (ctrl_reset) begin
         queue_slot <= 48'b0;
      end else begin
         if (ctrl_wrQueuePos) begin
            queue_slot[38:32] <= wrQueuePos;
         end
         if (ctrl_wrAscii) begin
            queue_slot[47:40] <= wrAscii;
         end
        if (ctrl_wrFreq) begin
            queue_slot[31:0] <= wrFreq;
        end
        if (ctrl_wrHead) begin
            queue_slot[39] <= wrHead;
         end
      end
   end
endmodule