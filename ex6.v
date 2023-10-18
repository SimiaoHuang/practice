module random_seq (clk, rst_n, out);

 input clk;
 input rst_n;
 output reg [7:0] out;

 reg [3:0] A;
 A = 4'b1111;

 always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
     out <= {4'b0,A};
    else begin
     out[7] <= out[3] + out[0];
     out[6:0] <= out[7:1];
    end
 end
    
endmodule