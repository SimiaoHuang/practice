module round_robin_arb_tb();
logic clk;
logic rst_n;
logic [3:0] request;
logic [3:0] grant;
logic [1:0] index;

round_robin_arb rra1(.clk(clk), .rst_n(rst_n), .request(request), .grant(grant), .index(index));

initial begin
clk = 0;
rst_n= 0;
request = 4'h0;
#19 rst_n = 1;
request = 4'b1101;
#10
request = 4'b0001;
#10
request = 4'b0010;
#10
request = 4'b0000;
#100;
$stop;

end

always #5 clk = !clk;

endmodule
