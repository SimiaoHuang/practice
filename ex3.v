module ex3 (
input A, B;
input clk;
input rst_n;
output reg X, Y;
);
    
parameter sta1 = 2'b00, sta2 = 2'b01, sta3 = 2'b10; //设置状态
reg [1:0] state, nstate;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
      state <= sta1; 
    else
      state <= nstate;
end

always @(*) begin
    A = 1'b0; B = 1'b0; X = 1'b0; Y = 1'b0;

    case (state)
        
        sta1: begin
        if (A=1'b0 && B=1'b1)
        nstate = sta2;
        else nstate = sta1;
        end

        sta2: begin
        if (A=1'b1 && B=1'b1)// {A,B} = 2'b11
        nstate = sta3;
        else if (A=1'b1 && B=1'b0) begin
        X = 1'b1;
        nstate = sta1;end
        end

        sta3: begin
        if (A=1'b0 && B=1'b0) begin
        Y = 1'b1;
        nstate = sta1;
        end
        else nstate = sta1;
        end
        default: nstate = sta1;

    endcase
    
end


endmodule
