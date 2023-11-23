// Fetch stage, reads 4KB blocks of text per cycle from "load_data.txt"
// Small blocks are padded with leading 0's

module fetch(
    input clk,
    output reg [4095:0] data
);

integer file_faults;
integer scan_faults;

initial begin
  file_faults = $fopen("load_data.txt", "r");
  if (file_faults == 0) begin
    $display("data_file handle was NULL");
    $finish;
  end
end

always @(posedge clk) begin
    if (!$feof(file_faults)) begin
        scan_faults = $fgets(data, file_faults); 
        //$display("scan_faults: %0d  data: %h", scan_faults, data);
    end else begin
        $fclose(file_faults); // Close file before finish
        $finish;
        data = '0; //Send NoOps if reached end of file
    end
    
end

endmodule