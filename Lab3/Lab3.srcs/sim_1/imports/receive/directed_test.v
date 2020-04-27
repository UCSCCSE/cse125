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


module directed_test(
    );
    reg [63:0] test_data [0:9];
    reg clk, res_n, shift_in, shift_out;
    reg [63:0] data_in;
    wire[63:0] data_out;
    wire full, empty;
    integer outfile;
    integer i;
    fifo dut(.clk(clk), .res_n(res_n), .shift_in(shift_in), .shift_out(shift_out), .data_in(data_in), .full(full), .empty(empty), .data_out(data_out));
    
    always 
        #5 clk = !clk;
        
    initial begin
        
        $readmemb("testfile.txt", test_data);
        $display(test_data);
        clk = 0;
        res_n = 0;
        @(posedge clk); @(posedge clk); #1 res_n = 1;
        
        //first case shiftout empty
        shift_out = 1'b1;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        outfile = $fopen("out.txt");
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        //second case shiftin and out empty
        data_in = test_data[0][63:0];
        shift_out = 1'b1;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        //third case shift in
        data_in = test_data[1][63:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        //fourth case shift in
        data_in = test_data[2][63:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        //fifth case shift out
        data_in = test_data[3][63:0];
        shift_out = 1'b1;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        //sixth case shift in
        data_in = test_data[4][63:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        
        
        for(i=0;i<3;i=i+1)begin
        @(posedge clk);
        shift_out = 1'b0;
        if(shift_in == 1'b1)begin
        shift_in = 1'b0;
        end
        else begin
        shift_in = 1'b1;
        end
        end
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        //seven case shift in
        data_in = test_data[5][63:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        //eight case shift in
        data_in = test_data[6][63:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        //ninth case shift in
        data_in = test_data[7][63:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        //tenth case shift in
        data_in = test_data[8][63:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        //11th case shift in
        data_in = test_data[9][63:0];
        shift_out = 1'b0;
        shift_in = 1'b1;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        //12th case shift out
        shift_out = 1'b1;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        for(i=0;i<4;i=i+1)begin
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        end
        @(posedge clk);
         shift_out = 1'b1;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        
        @(posedge clk);
         shift_out = 1'b1;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        
        @(posedge clk);
         shift_out = 1'b1;
        shift_in = 1'b0;
        @(posedge clk);
        shift_out = 1'b0;
        shift_in = 1'b0;
        @(posedge clk);
        $fdisplay(outfile, "%d", data_out);
        @(posedge clk);
        
        
        
        
    end
        
endmodule
