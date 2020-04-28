`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/27 20:40:12
// Design Name: 
// Module Name: random_test
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


module random_test(

    );
    reg [WIDTH-1:0] test_data [0:1000];
    reg clk, res_n, shift_in, shift_out;
    reg [WIDTH-1:0] data_in;
    wire[WIDTH-1:0] data_out;
    wire full, empty;
    integer outfile;
    integer i;
    integer f1, f2, a, b;
    reg [WIDTH-1:0] answer;
    reg [WIDTH-1:0] expect;
    fifo dut(.clk(clk), .res_n(res_n), .shift_in(shift_in), .shift_out(shift_out), .data_in(data_in), .full(full), .empty(empty), .data_out(data_out));
    
    always 
        #5 clk = !clk;
        
    initial begin
        
        $readmemb("randominput.txt", test_data);
        outfile = $fopen("D:\\CSE125\\cse125\\Lab3\\randomout.txt", "w");
        clk = 0;
        res_n = 0;
        @(posedge clk); @(posedge clk); #1 res_n = 1;
        for(i=0;i<1000;i=i+1)begin
            shift_out = {$random} % 2;
            shift_in = {$random} % 2;
            if((shift_in == 1'b1) && (full != 1'b1))
            begin
                data_in = test_data[i][WIDTH-1:0];
            end
            if((shift_out == 1'b1) && (shift_in == 1'b0))
            begin
                i = i-1;
            end
            @(posedge clk);
            shift_out = 1'b0;
            shift_in = 1'b0;
            @(posedge clk);
            $fdisplay(outfile, "%b", data_out);
            @(posedge clk);
        end
        $fclose(outfile); 
        f1 = $fopen("D:\\CSE125\\cse125\\Lab3\\randominput.txt", "r");
        f2 = $fopen("D:\\CSE125\\cse125\\Lab3\\randomout.txt", "r");
        while(!$feof(f1) || !$feof(f2))begin
            a = $fscanf(f1," %d ", answer);
            b = $fscanf(f2," %d ", expect);
            if(answer != expect) begin
                $display("value is :%b, expect:%b", answer, expect);
            end
        end
        $display("test done");
        $fclose(f1);
        $fclose(f2);
        #100;
        $stop;
    end
endmodule
