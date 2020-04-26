`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2020 04:38:52 PM
// Design Name: 
// Module Name: fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo #(parameter WIDTH =64, parameter DEPTH = 8)(
    input clk,
    input res_n,
    input shift_in,
    input shift_out,
    input [WIDTH-1:0] data_in,
    input full,
    output empty,
    output reg [WIDTH-1:0] data_out
    );
    wire [WIDTH-1:0] pre_out[DEPTH-1:0];
    wire [WIDTH-1:0] hold_data[DEPTH-1:0];
    wire [WIDTH-1:0] cur_out[DEPTH-1:0];
    reg [1:0]select;
    
    //assign select = full | empty | shift_in | shift_out; 
    assign pre_out[0]= cur_out[DEPTH-1];
    genvar j;
    generate
        for(j=1;j<DEPTH;j=j+1)begin: DATA_OUT_CONNECT       
            assign pre_out[j]=cur_out[j-1];
        end
    endgenerate
          
    genvar i;
    generate
        for(i =0; i<DEPTH;i=i+1)begin: cur_hold
            assign hold_data[i]=cur_out[i];
        end
    endgenerate
    
    
    generate
        for(i =0; i<DEPTH;i=i+1)begin: FIFO
            fifo_stage FS0(.clk(clk), .si(data_in),.hold(hold_data[i]), .so(pre_out[i]), .select(select), .out(cur_out[i]));
        
        end
    endgenerate
    
    
endmodule





module fifo_stage #(parameter WIDTH = 64)(
input clk,
input [WIDTH-1:0]si,
input [WIDTH-1:0]hold,
input [WIDTH-1:0]so,
input [1:0]select,
output reg [WIDTH-1:0]out
);

wire [WIDTH-1:0] D_in;
reg  [1:0] current_state;
reg  [1:0] next_state;
parameter STATE_HOLD  = 2'b00;
parameter STATE_SI    = 2'b10;
parameter STATE_SO    = 2'b01;
parameter STATE_SI_SO = 2'b11;


always @(posedge clk)begin
    case (select)
        STATE_HOLD:out = hold;
        STATE_SI  :out = si;
        STATE_SO  :out = so;
        
    endcase
end


endmodule