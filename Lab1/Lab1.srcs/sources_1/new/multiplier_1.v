`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/10 15:01:10
// Design Name: 
// Module Name: multiplier_1
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


module multiplier_1(
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
      if((!res_n || start)&& clk) begin
                   product <= 32'b0;
                   i =0;
                   done=0;
                end                 
                else begin
                     if(i<arg2) begin
                        product = product + arg1 ;
                        i=i+1;     
                     end
                     else begin
                          done<=1;
                     end
                 end
              end
        
    
endmodule
