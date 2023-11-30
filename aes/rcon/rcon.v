module rcon_table(
    input clk,
    input [3:0] roundNumber,
    output reg [7:0] rcon
);

always @(*) begin
  case(roundNumber)
        4'd0: rcon <= 8'h01;
        4'd1: rcon <= 8'h02;
        4'd2: rcon <= 8'h04;
        4'd3: rcon <= 8'h08;
        4'd4: rcon <= 8'h10;
        4'd5: rcon <= 8'h20;
        4'd6: rcon <= 8'h40;
        4'd7: rcon <= 8'h80;
        4'd8: rcon <= 8'h1b;
        4'd9: rcon <= 8'h36;  
  endcase
end

endmodule