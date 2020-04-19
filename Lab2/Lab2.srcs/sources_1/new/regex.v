`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2020 12:19:18 AM
// Design Name: 
// Module Name: regex
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


module regex(
    input clk,
    input res_n,
    input [1:0] simbol_in,
    input last_simbol,
    output result,
    output done
    );
    parameter IDLE       = 4'b0000;
    parameter COM_IDLE   = 4'b0001;
    parameter COM_STATE0 = 4'b0010;
    parameter COM_STATE1 = 4'b0011;
    parameter COM_STATE2 = 4'b0100;
    parameter COM_STATE3 = 4'b0101;
    parameter COM_END    = 4'b0110;
    parameter COM_OVER   = 4'b0111;
    parameter DONE       = 4'b1000;
    
    
endmodule
