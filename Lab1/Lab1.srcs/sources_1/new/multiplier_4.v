`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/10 16:18:17
// Design Name: 
// Module Name: multiplier_4
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


module multiplier_4(
    input clk,
    input res_n,
    input start,
    output reg done,
    input [15:0] arg1,
    input [15:0] arg2,
    output reg [31:0] product
    );
    integer i;
    always @(posedge clk or negedge res_n) begin
        if((!res_n || start)&& clk)begin
            product <= 32'd0;
            i =0;
            done=1'b0;
        end
        else begin
             if (i< arg2)begin
                if((arg2-i)==4) begin
                    product = product + arg1 + arg1 + arg1 + arg1;
                end
                else if((arg2-i)==3) begin
                    product = product + arg1 + arg1 + arg1;
                end
                else if((arg2-i)==2) begin
                    product = product + arg1 + arg1; 
                end
                else if((arg2-i)==1) begin
                    product = product + arg1;
                end
                else begin
                    product = product + arg1 + arg1 + arg1 + arg1;
                    
                end
                i=i+4;
             end
             else begin
             done <=1'b1;
             end         
           
         end
    end
                
        
    
endmodule
