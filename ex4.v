module seq_detector (clk,rst_n, sequence, flag);

    input clk;
    input rst_n;
    input sequence;
    output reg flag;

 parameter IDEL = 4'b0000,
          s1 = 4'b0001,//1
          s2 = 4'b0010,//10
          s3 = 4'b0011,//101
          s4 = 4'b0100,//1010
          s5 = 4'b0101,//10100
          s6 = 4'b0110,//101000
          s7 = 4'b0111,//1010001
          s8 = 4'b1000;//10100011
 
 reg [3:0] state, nstate;
 reg [5:0] counter;//用于计数40个周期

 always @(posedge clk or negedge rst_n) begin
        if (!rst_n) 
      state <= IDEL; 
        else
      state <= nstate;
 end

//counter
 always @(posedge clk or negedge rst_n) begin
     if (!rst_n) 
      counter <= 6'b0000000; 
        else if (counter == 6'b101000)
         counter <= 6'b0000000;
          else counter <= counter + 1'b1;
    
 end

//state machine
always @(*) begin

flag = 1'bz; //默认状态
sequence = 1'b0;

case(state)
  
  IDEL:nstate = sequence? s1: IDEL;
    s1:nstate = sequence? s1: s2;
    s2:nstate = sequence? s3: IDEL;
    s3:nstate = sequence? s1: s4;
    s4:nstate = sequence? s3: s5;
    s5:nstate = sequence? s1: s6;
    s6:nstate = sequence? s7: IDEL;
    s7:nstate = sequence? s8: s2;
    s8:begin
        flag = 1'b1;
        nstate = sequence? s1: s2;
    end
    default:nstate = IDEL;

endcase

//flag
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
     flag <= 1'bz;
     else if (flag != 1'b1 && counter = 6'b101000)
     flag <= 1'b0;
end


end

endmodule