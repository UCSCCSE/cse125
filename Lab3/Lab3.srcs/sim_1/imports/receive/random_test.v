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


module random_test#( WIDTH=32

    );
    reg [WIDTH-1:0] test_data [0:1000];
    reg clk, res_n, shift_in, shift_out, rmsi, rmso;
    reg [WIDTH-1:0] data_in;
    wire[WIDTH-1:0] data_out;
    wire full, empty;
    integer outfile, infile;
    integer i, j;
    integer f1, f2, a, b;
    reg [WIDTH-1:0] answer;
    reg [WIDTH-1:0] expect;
    fifo dut(.clk(clk), .res_n(res_n), .shift_in(shift_in), .shift_out(shift_out), .data_in(data_in), .full(full), .empty(empty), .data_out(data_out));
    
    always 
        #5 clk = !clk;
        
    initial begin
        
        //$readmemb("randominput.txt", test_data);
        infile = $fopen("D:\\Programming\\Git\\cse125\\Lab3\\Lab3.srcs\\sim_1\\imports\\receive\\randominput.txt", "w");
        for(j = 0; j<1000; j=j+1)
        begin
            $fwrite(infile, "%b\n", {$random} % 2000);
        end
        $fclose(infile);
        outfile = $fopen("D:\\Programming\\Git\\cse125\\Lab3\\randomoutput.txt", "w");
        $readmemb("randominput", test_data);
        clk = 0;
        res_n = 0;
        @(posedge clk); @(posedge clk); #1 res_n = 1;
        @(posedge clk);
        data_in = 0;
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        for(i=0;i<1000;i=i+1)begin
            data_in = test_data[i][WIDTH-1:0];
            shift_out = {$random+9} % 2;
            shift_in = {$random} % 2;
            if(full)
                shift_in = 1'b0;
            rmsi = shift_in;
            rmso = shift_out;
            if((shift_in == 1'b1) && (full != 1'b1))
            begin
                //data_in = test_data[i][WIDTH-1:0];
            end
            else
            begin
                i = i-1;
            end
            @(posedge clk);
            shift_out = 1'b0;
            shift_in = 1'b0;
            //@(posedge clk);
            if((rmso == 1'b1) && (empty != 1'b1))
            $fdisplay(outfile, "%b", data_out);
            @(posedge clk);
        end
        while(empty != 1'b1)
        begin
            shift_out = 1'b1;
            shift_in = 1'b0;
            @(posedge clk);
            shift_out = 1'b0;
            shift_in = 1'b0;  
            $fdisplay(outfile, "%b", data_out);
            @(posedge clk);
        end 
        $fclose(outfile); 
        f1 = $fopen("D:\\Programming\\Git\\cse125\\Lab3\\Lab3.srcs\\sim_1\\imports\\receive\\randominput.txt", "r");
        f2 = $fopen("D:\\Programming\\Git\\cse125\\Lab3\\randomoutput.txt", "r");
        while(!$feof(f1) || !$feof(f2))begin
            a = $fscanf(f1," %b ", expect);
            b = $fscanf(f2," %b ", answer);
            if(answer != expect) begin
                $display("answer is :%b, expect:%b", answer, expect);
            end
        end
        $display("test done");
        $fclose(f1);
        $fclose(f2);
        #100;
        $stop;
    end
endmodule
