`timescale 1ns / 1ns

module Queue(
   input clk,
   input ctrl_wrQueuePos [0:5],
   input ctrl_wrAscii [0:5],
   input ctrl_wrFreq [0:5],
   input ctrl_wrHead [0:5],
   input ctrl_reset,
   input [7:0] wrQueuePos [0:5], // queue_pos 
   input [7:0] wrAscii [0:5],
   input [31:0] wrFreq [0:5], //may need to adjust max frequency value
   input wrHead [0:5],
   output [7:0] rdQueuePos [0:5],
   output [7:0] rdAscii [0:5],
   output [31:0] rdFreq [0:5],
   output rdHead [0:5]
);
    QueueSlot A_slot(.clk(clk), .ctrl_wrQueuePos(ctrl_wrQueuePos[0]), .ctrl_wrAscii(ctrl_wrAscii[0]), .ctrl_wrFreq(ctrl_wrFreq[0]), .ctrl_wrHead(ctrl_wrHead[0]), .ctrl_reset(ctrl_reset), .wrQueuePos(wrQueuePos[0]), .wrAscii(wrAscii[0]), .wrFreq(wrFreq[0]), .wrHead(wrHead[0]), .rdQueuePos(rdQueuePos[0]), .rdAscii(rdAscii[0]), .rdFreq(rdFreq[0]), .rdHead(rdHead[0]));
    QueueSlot B_slot(.clk(clk), .ctrl_wrQueuePos(ctrl_wrQueuePos[1]), .ctrl_wrAscii(ctrl_wrAscii[1]), .ctrl_wrFreq(ctrl_wrFreq[1]), .ctrl_wrHead(ctrl_wrHead[1]), .ctrl_reset(ctrl_reset), .wrQueuePos(wrQueuePos[1]), .wrAscii(wrAscii[1]), .wrFreq(wrFreq[1]), .wrHead(wrHead[1]), .rdQueuePos(rdQueuePos[1]), .rdAscii(rdAscii[1]), .rdFreq(rdFreq[1]), .rdHead(rdHead[1]));
    QueueSlot C_slot(.clk(clk), .ctrl_wrQueuePos(ctrl_wrQueuePos[2]), .ctrl_wrAscii(ctrl_wrAscii[2]), .ctrl_wrFreq(ctrl_wrFreq[2]), .ctrl_wrHead(ctrl_wrHead[2]), .ctrl_reset(ctrl_reset), .wrQueuePos(wrQueuePos[2]), .wrAscii(wrAscii[2]), .wrFreq(wrFreq[2]), .wrHead(wrHead[2]), .rdQueuePos(rdQueuePos[2]), .rdAscii(rdAscii[2]), .rdFreq(rdFreq[2]), .rdHead(rdHead[2]));
    QueueSlot D_slot(.clk(clk), .ctrl_wrQueuePos(ctrl_wrQueuePos[3]), .ctrl_wrAscii(ctrl_wrAscii[3]), .ctrl_wrFreq(ctrl_wrFreq[3]), .ctrl_wrHead(ctrl_wrHead[3]), .ctrl_reset(ctrl_reset), .wrQueuePos(wrQueuePos[3]), .wrAscii(wrAscii[3]), .wrFreq(wrFreq[3]), .wrHead(wrHead[3]), .rdQueuePos(rdQueuePos[3]), .rdAscii(rdAscii[3]), .rdFreq(rdFreq[3]), .rdHead(rdHead[3]));
    QueueSlot E_slot(.clk(clk), .ctrl_wrQueuePos(ctrl_wrQueuePos[4]), .ctrl_wrAscii(ctrl_wrAscii[4]), .ctrl_wrFreq(ctrl_wrFreq[4]), .ctrl_wrHead(ctrl_wrHead[4]), .ctrl_reset(ctrl_reset), .wrQueuePos(wrQueuePos[4]), .wrAscii(wrAscii[4]), .wrFreq(wrFreq[4]), .wrHead(wrHead[4]), .rdQueuePos(rdQueuePos[4]), .rdAscii(rdAscii[4]), .rdFreq(rdFreq[4]), .rdHead(rdHead[4]));
    QueueSlot F_slot(.clk(clk), .ctrl_wrQueuePos(ctrl_wrQueuePos[5]), .ctrl_wrAscii(ctrl_wrAscii[5]), .ctrl_wrFreq(ctrl_wrFreq[5]), .ctrl_wrHead(ctrl_wrHead[5]), .ctrl_reset(ctrl_reset), .wrQueuePos(wrQueuePos[5]), .wrAscii(wrAscii[5]), .wrFreq(wrFreq[5]), .wrHead(wrHead[5]), .rdQueuePos(rdQueuePos[5]), .rdAscii(rdAscii[5]), .rdFreq(rdFreq[5]), .rdHead(rdHead[5]));

endmodule