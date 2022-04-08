//64 bytes of data to transferred
//4 transfers ie awlen is 3;
// 16 bytes per transfer
typedef enum {IDLE, ADDR_WAIT,DATA_WAIT_DATA_WAIT_LAST,RESPONSE_SEND] state;
module axi slave();
parameter ADDR_WIDTH = 8;
parementer DATA_WIDTH =16;
parameter  STROBE_WIDTH =16;
input [ADDR_WIDTH -1:0]awaddr;
input awvalid;
output reg awready;
input awburst;
input [7:0]awlen;
input [2:0] awsize;
input aclk;
input wvalid;
output reg wready;
input wlast;
input [STROBE_WIDTH -1:0] wstrb;
input [DATA_WIDTH-1:0] wdata;
logic [DATA_WIDTH-1:0]mem[ADDR_WIDTH-1:0];
always(@posedge aclk)begin
case(state):begin
IDLE:begin
if(awvalid && awready)
state <= ADDR_WAIT;
else
state <= IDLE;
ADDR_WAIT:begin
if(wvalid && wready)
state <= DATA_WAIT;
else 
state <= ADDR_WAIT;
end
DATA_WAIT:begin
  if(wready && wvalid && (awburst == 2b'10))begin
  awaddr =awaddr + 1;
  mem[awaddr] = (wdata and wsrtb);
  awlen =awlen -1;
  if(awlen==1)
  state <= DATA_WAIT_LAST;
  end
  else
  state <= DATA_WAIT;
  end
  end
  DATA_WAIT_LAST: begin
  if(wlast)
  state < =RESPONSE_SEND;
  else
  state<=DATA_WAIT_LAST;
  end
  RESPONSE_SEND: begin
  if(bready)
  wait(bvalid ==1 && bresp ==1)
  if(bresp && bvalid)
  state <IDLE;
  else 
  state <=RESPONSE_SEND;
  end
 end
 
  
  
