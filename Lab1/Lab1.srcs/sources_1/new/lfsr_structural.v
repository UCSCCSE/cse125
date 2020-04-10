`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/09 15:40:32
// Design Name: 
// Module Name: lfsr_structural
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


module lfsr_structural(
    input clk,
    input res_n,
    input [7:0] data_in,
    output [7:0] data_out
    );
    FDRE #(.INIT(1'b1) ) ff_q0 (.C(clk), .R(1'b0), .CE(1'b1), .D((data_out[7] & res_n) | (data_in[0] & ~res_n)), .Q(data_out[0]));
    FDRE #(.INIT(1'b0) ) ff_q1 (.C(clk), .R(1'b0), .CE(1'b1), .D((data_out[0] & res_n) | (data_in[1] & ~res_n)), .Q(data_out[1]));
    FDRE #(.INIT(1'b0) ) ff_q2 (.C(clk), .R(1'b0), .CE(1'b1), .D(((data_out[1] ^ data_out[7]) & res_n) | (data_in[2] & ~res_n)), .Q(data_out[2]));
    FDRE #(.INIT(1'b0) ) ff_q3 (.C(clk), .R(1'b0), .CE(1'b1), .D(((data_out[2] ^ data_out[7]) & res_n) | (data_in[3] & ~res_n)), .Q(data_out[3]));
    FDRE #(.INIT(1'b0) ) ff_q4 (.C(clk), .R(1'b0), .CE(1'b1), .D(((data_out[3] ^ data_out[7]) & res_n) | (data_in[4] & ~res_n)), .Q(data_out[4]));
    FDRE #(.INIT(1'b0) ) ff_q5 (.C(clk), .R(1'b0), .CE(1'b1), .D((data_out[4] & res_n) | (data_in[5] & ~res_n)), .Q(data_out[5]));
    FDRE #(.INIT(1'b0) ) ff_q6 (.C(clk), .R(1'b0), .CE(1'b1), .D((data_out[5] & res_n) | (data_in[6] & ~res_n)), .Q(data_out[6]));
    FDRE #(.INIT(1'b0) ) ff_q7 (.C(clk), .R(1'b0), .CE(1'b1), .D((data_out[6] & res_n) | (data_in[7] & ~res_n)), .Q(data_out[7]));
endmodule
