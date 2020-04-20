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
    input [1:0] symbol_in,
    input last_symbol,
    output reg result,
    output reg done
    );
    parameter IDLE       = 4'b0000;
    parameter COM_IDLE   = 4'b0001;
    parameter COM_STATE0 = 4'b0010;
    parameter COM_STATE1 = 4'b0011;
    parameter COM_STATE2 = 4'b0100;
    parameter COM_STATE3 = 4'b0101;
    parameter COM_END    = 4'b0110;
    parameter COM_OVER   = 4'b0111;
    //parameter DONE       = 4'b1000;
    
    reg[3:0] current_state, next_state;
    reg match;
    
    always @(current_state, symbol_in)
    begin
        case(current_state)
        COM_IDLE:
        begin
            if(symbol_in == 2'b00)
                next_state <= COM_STATE0;
            else if(symbol_in == 2'b11)
                next_state <= COM_END;
            else
                next_state <= COM_OVER;
        end
        COM_STATE0:
        begin
            if(symbol_in == 2'b10)
                next_state <= COM_STATE1;
            else if(symbol_in == 2'b01)
                next_state <= COM_STATE0;
            else
                next_state <= COM_OVER;
        end
        COM_STATE1:
        begin
            if(symbol_in == 2'b00)
                next_state <= COM_IDLE;
            else if(symbol_in == 2'b11)
                next_state <= COM_STATE2;
            else
                next_state <= COM_OVER;
        end
        COM_STATE2:
        begin
            if((symbol_in == 2'b01) || (symbol_in == 2'b10) || (symbol_in == 2'b11))
                next_state <= COM_STATE3;
            else
                next_state <= COM_OVER;
        end
        COM_STATE3:
        begin
            if(symbol_in == 2'b11)
                next_state <= COM_END;
            else
                next_state <= COM_OVER;
        end
        COM_END:
        begin
            if((symbol_in == 2'b01) || (symbol_in == 2'b10) || (symbol_in == 2'b11) || (symbol_in == 2'b00))
                next_state <= COM_OVER;
            else
                next_state <= COM_OVER;
        end
        COM_OVER:
        begin
            if(symbol_in == 2'b00)
                next_state <= COM_OVER;
            else
                next_state <= COM_OVER;
        end
        default:
            next_state <= COM_IDLE;
        endcase
    end
    
    always @ (posedge clk, negedge res_n)
    begin
        if (res_n == 1'b0)begin
            current_state = COM_IDLE;
            result =0;
            done =0;
        end
        else 
            current_state = next_state;
    end
    
    always @(negedge last_symbol ) begin
                done <= 1;
            end
    always @(posedge clk)
    begin
           
            if(current_state == COM_END)
            begin
                result <= 1;
            end
            else
            begin
                result <= 0;
            end
    end
endmodule
