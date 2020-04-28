`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2020 01:06:14 AM
// Design Name: 
// Module Name: directed_test
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


module directed_test #(parameter WIDTH=16,parameter DEPTH=8
    );
    reg [WIDTH-1:0] test_data [0:20];
    reg clk, res_n, shift_in, shift_out;
    reg [WIDTH-1:0] data_in;
    wire[WIDTH-1:0] data_out;
    wire full, empty;
    integer outfile;
    integer i, j;
    
    fifo dut(.clk(clk), .res_n(res_n), .shift_in(shift_in), .shift_out(shift_out), .data_in(data_in), .full(full), .empty(empty), .data_out(data_out));
    
    always 
        #5 clk = !clk;
        
    initial begin
        
        $readmemb("testfile.txt", test_data);
        outfile = $fopen("D:\\Programming\\Git\\cse125\\Lab3\\out.txt", "w");
        clk = 0;
        res_n = 0;
        @(posedge clk); @(posedge clk); #1 res_n = 1;
        //first case shiftout empty
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        //second case shiftin and out empty
        data_in = test_data[0][WIDTH-1:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b1;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //third case shift in
        data_in = test_data[1][WIDTH-1:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        //$fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //fourth case shift in
        data_in = test_data[2][WIDTH-1:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        //$fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //fifth case shift out
        data_in = test_data[3][WIDTH-1:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
         //$fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        shift_out = 1'b1;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //sixth case shift in
        data_in = test_data[4][WIDTH-1:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
         shift_out = 1'b0;
        shift_in = 1'b0;
//        for(i=0;i<1;i=i+1)begin
//            @(posedge clk);
//            shift_out = 1'b0;
//            if(shift_in == 1'b1)begin
//                shift_in = 1'b0;
//            end
//            else begin
//                shift_in = 1'b1;
//            end
//        end
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        //$fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //seven case shift in
        data_in = test_data[5][WIDTH-1:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        //$fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //eight case shift in
        data_in = test_data[6][WIDTH-1:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        //$fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //ninth case shift in
        data_in = test_data[7][WIDTH-1:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        //$fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //tenth case shift in
        data_in = test_data[8][WIDTH-1:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        //$fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //11th case shift in
        data_in = test_data[9][WIDTH-1:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        //$fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //12th case shift out
        shift_out = 1'b1;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //13th case shift in and out
        data_in = test_data[10][WIDTH-1:0];
        shift_out = 1'b1;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //14th case shift in and out
        data_in = test_data[11][WIDTH-1:0];
        shift_out = 1'b1;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //15th case shift in
        data_in = test_data[12][WIDTH-1:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        //$fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        //shift out all
        for(j=0;j<6;j=j+1)begin
            shift_out = 1'b1;
            shift_in = 1'b0;
            @(posedge clk);
            shift_out = 1'b0;
            shift_in = 1'b0;
            @(posedge clk);
            $fdisplay(outfile, "%b", data_out);
            @(posedge clk);
        end
        
        
         @(posedge clk);
        //12th case shift out
        shift_out = 1'b1;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%b", data_out);
        @(posedge clk);
         @(posedge clk);
        //12th case shift out
        shift_out = 1'b1;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%b", data_out);
        @(posedge clk);
        $fclose(outfile); 
        #100;
        $stop;
    end
        
endmodule
