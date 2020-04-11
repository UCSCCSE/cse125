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
        if(!res_n && clk)
            product <= 32'd0;
        else if(res_n && start)
            for( i = 0 ; i < arg2 ; i = i + 1 ) begin
                product = product + arg1;
            end
            done <= 1;
    end
                
        
    
endmodule
