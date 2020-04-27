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
    output reg full,
    output reg empty,
    output reg [WIDTH-1:0] data_out
    );
    wire [WIDTH-1:0] pre_out[DEPTH-1:0];
    wire [WIDTH-1:0] hold_data[DEPTH-1:0];
    wire [WIDTH-1:0] data_output[DEPTH-1:0];
    reg [WIDTH-1:0] data_input[DEPTH-1:0];
    integer ptr_shift_in=0;
    integer ptr_shift_out=0;
    reg [WIDTH-1:0] ptr_diff;
    reg [1:0]select;
    reg choose;
    reg can_hold, can_shift_in,can_shift_out,invalid;
    xor (chose, shift_in&&empty , shifit_out&&empty);
    always @(posedge clk or negedge res_n )begin
        if(!res_n)begin
            data_out <=0;
            ptr_shift_in <=0;
            ptr_shift_out<=0;
            ptr_diff<=0;
        end
        else begin
        if(shift_in && ~full)begin
            select  = 2'b10;
            data_input[ptr_shift_in] <= data_in;
            ptr_shift_in<=ptr_shift_in+1;
            ptr_diff <= ptr_diff+1;
        end
        else if(shift_out&& ~empty)begin
            select   <= 2'b01;
            data_out<= data_output[ptr_shift_out];
            ptr_shift_out <= ptr_shift_out+1;
            ptr_diff <= ptr_diff-1;
        end
        else if(~shift_in && ~shift_out)begin
            select   <= 2'b00;
        end
        else if(shift_in && shift_out)begin
            select   <= 2'b11;
        end
        
        
        if(ptr_shift_in ==0)begin
            data_input[0] <= data_in;
        end
        else begin
            data_input[ptr_shift_in] <= data_in;
        end
        
        if(ptr_diff == 0)begin
            empty <=1;
        end
        else if(ptr_diff == DEPTH-1)begin
            full <= 1;
        end
        end
    end
    
   
    
    //assign select = full | empty | shift_in | shift_out; 
   // assign pre_out[0]= data_output[DEPTH-1];
    genvar j; 

    generate
        for(j=1;j<DEPTH;j=j+1)begin: DATA_OUT_CONNECT       
            assign pre_out[j]=data_output[j-1];
        end
    endgenerate
          
    genvar i;
    generate
        for(i =0; i<DEPTH;i=i+1)begin: cur_hold
            assign hold_data[i]=data_output[i];
        end
    endgenerate
    
    
    generate
        for(i =0; i<DEPTH;i=i+1)begin: FIFO
               
                   
            fifo_stage FS0(.clk(clk), .si(data_input[i]),.hold(hold_data[i]), .so(pre_out[i]), .select(select), .out(data_output[i]));
        
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
        STATE_HOLD:out <= hold;
        STATE_SI  :out <= si;
        STATE_SO  :out <= so;
        
    endcase
end


endmodule