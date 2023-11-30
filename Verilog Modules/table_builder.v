`timescale 1ns / 1ns

module TableBuilder(
    input clk,
    input ctrl_wrAscii [0:5],
    input [7:0] wrAscii [0:5],
   
    input ctrl_start
);

reg [1:0] next_step;
reg [31:0] freq0;
reg [31:0] freq1;
wire [31:0] combined_freq;

reg ctrl_wrHead [0:5];
wire ctrl_reset;
reg wrHead [0:5];
reg ctrl_wrFreq [0:5];
reg [31:0] wrFreq [0:5];
reg ctrl_wrQueuePos [0:5];
reg [7:0] wrQueuePos [0:5];

wire [7:0] rdQueuePos [0:5];
wire [7:0] rdAscii [0:5];
wire [31:0] rdFreq [0:5];
wire rdHead [0:5];

wire [7:0] tally;
wire [5:0] compBits;

Queue queue(.clk(clk), .ctrl_wrQueuePos(ctrl_wrQueuePos), .ctrl_wrAscii(ctrl_wrAscii), .ctrl_wrFreq(ctrl_wrFreq), .ctrl_wrHead(ctrl_wrHead), .ctrl_reset(ctrl_reset), .wrQueuePos(wrQueuePos), .wrAscii(wrAscii), .wrFreq(wrFreq), .wrHead(wrHead), .rdQueuePos(rdQueuePos), .rdAscii(rdAscii), .rdFreq(rdFreq), .rdHead(rdHead));
Tallier tallier(.inBits(compBits), .outBits(tally));

assign combined_freq = freq0 + freq1;
assign ctrl_reset = 0;

genvar i;
generate
    for (i = 0; i < 6 ; i = i+1) begin
        assign compBits[i]= (combined_freq>rdFreq[i]) & (rdHead[i]==1);
    end
endgenerate

integer index;
//before process has begun
always @(posedge ctrl_start) begin
    next_step <= 2'b1; 
    freq0 <= 32'd5;
    freq1 <= 32'd9;
    //set all the nodes to be heads
    for(index=0; index<6;index=index+1) begin 
        ctrl_wrHead[index] <= 1;
        wrHead[index] <= 1;
    end
    //set all the nodes to the proper queue position--only for this test
    ctrl_wrFreq[0] <= 1;
    ctrl_wrFreq[1] <= 1;
    ctrl_wrFreq[2] <= 1;
    ctrl_wrFreq[3] <= 1;
    ctrl_wrFreq[4] <= 1;
    ctrl_wrFreq[5] <= 1;

    wrFreq[0] <= 32'd5;
    wrFreq[1] <= 32'd9;
    wrFreq[2] <= 32'd12;
    wrFreq[3] <= 32'd13;
    wrFreq[4] <= 32'd16;
    wrFreq[5] <= 32'd45;

    ctrl_wrQueuePos[0] <= 1;
    ctrl_wrQueuePos[1] <= 1;
    ctrl_wrQueuePos[2] <= 1;
    ctrl_wrQueuePos[3] <= 1;
    ctrl_wrQueuePos[4] <= 1;
    ctrl_wrQueuePos[5] <= 1;

    wrQueuePos[0] <= 8'd0;
    wrQueuePos[1] <= 8'd1;
    wrQueuePos[2] <= 8'd2;
    wrQueuePos[3] <= 8'd3;
    wrQueuePos[4] <= 8'd4;
    wrQueuePos[5] <= 8'd5;
end


always @(negedge clk) begin
    if (!ctrl_start && next_step == 2'b1) begin
        next_step <= 2'd3;
        for(index=0; index<6; index=index+1) begin
            if (rdQueuePos[index] == 8'b0) begin
                ctrl_wrFreq[index] <= 1;
                ctrl_wrQueuePos[index] <= 0;
                ctrl_wrHead[index] <= 0;
                wrFreq[index] <= combined_freq;
            end else if(rdQueuePos[index] == 8'b1) begin
                ctrl_wrQueuePos[index] <= 1;
                ctrl_wrFreq[index] <= 1;
                ctrl_wrHead[index] <= 1;
                wrQueuePos[index] <= 8'b0;
                wrFreq[index] <= combined_freq;
                wrHead[index] <= 0;
            end else begin
                ctrl_wrQueuePos[index]<=0;
                ctrl_wrFreq[index]<=0;
                ctrl_wrHead[index]<=0;
            end
        end 
    end else if(next_step==2'd2)begin 
        next_step <= 2'd3;
    end
    else if (!ctrl_start && next_step == 2'd3) begin
        next_step <= 2'd1;
        for(index=0; index<6; index=index+1) begin
            ctrl_wrQueuePos[index]<=1;
            ctrl_wrFreq[index]<=0;
            ctrl_wrHead[index]<=0;
            if(rdQueuePos[index]==8'b0)begin
                wrQueuePos[index]<=rdQueuePos[index]+tally;
                if(rdQueuePos[index]+tally==8'b0 && rdHead[index]==1)begin
                    freq0<=rdFreq[index];
                end
                if(rdQueuePos[index]+tally==8'b1 && rdHead[index]==1)begin
                    freq1<=rdFreq[index];
                end
            end 
            else if (combined_freq>rdFreq[index]) begin
                wrQueuePos[index]=rdQueuePos[index]-8'd2;
                if(rdQueuePos[index]-256'd2==8'b0 && rdHead[index]==1)begin
                    freq0<=rdFreq[index];
                end
                if(rdQueuePos[index]-256'd2==8'b1 && rdHead[index]==1)begin
                    freq1<=rdFreq[index];
                end
            end else begin
                wrQueuePos[index]=rdQueuePos[index]-8'd1;
                if(rdQueuePos[index]-256'd1==8'b0 && rdHead[index]==1)begin
                    freq0<=rdFreq[index];
                end
                if(rdQueuePos[index]-256'd1==8'b1 && rdHead[index]==1)begin
                    freq1<=rdFreq[index];
                end
            end
                
        end
    end else if(next_step<=2'd0)begin
        next_step<=2'd1;
    end
end

endmodule