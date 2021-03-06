`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 16:20:25
// Design Name: 
// Module Name: lfsr_behavioural
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


module lfsr_behavioural(
    input clk,
    input res_n,
    input [7:0] data_in,
    output reg [7:0] data_out
    );
    always @(posedge clk or negedge res_n) begin
        if(!res_n && clk)
        begin
            data_out[7:0] <= data_in[7:0];
        end
        else
        begin
            data_out[0] <= data_out[7];
            data_out[1] <= data_out[0];
            data_out[2] <= data_out[1] ^ data_out[7];
            data_out[3] <= data_out[2] ^ data_out[7];
            data_out[4] <= data_out[3] ^ data_out[7];
            data_out[5] <= data_out[4];
            data_out[6] <= data_out[5];
            data_out[7] <= data_out[6];
        end
    end
endmodule
