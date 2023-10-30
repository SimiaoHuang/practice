module round_robin_arb(clk,rst_n,request,grant, index);

input clk;
input rst_n;
input [3:0] request;
output reg[3:0] grant;
output reg[1:0] index;

wire [7:0] double_grant;
reg [3:0] pre_state; //通过将前态左移得到现态的最高优先级，one-hot

always@(posedge clk or negedge rst_n) begin
if(!rst_n)
pre_state <= 4'h1;
else
pre_state <= {grant[2:0], grant[3]}; //循环左移，前态grant位的左边是现态的最高优先级
end

assign double_grant = {request, request} & ~({request, request} - {4'b0, pre_state}); //从最高级向左起寻找第一个不是0的来借1。防止不够减（有效request位出现在最高级位右侧），需要将request复制扩展。
assign grant = double_grant[7:4] | double_grant[3:0];

always @(*) begin
    case(grant)
        4'b0001: index = 2'b00;
        4'b0010: index = 2'b01;
        4'b0100: index = 2'b10;
        4'b1000: index = 2'b11;
        default: index = 2'b00;
    endcase
end

endmodule
