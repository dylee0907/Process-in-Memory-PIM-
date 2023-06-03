`timescale 1ns/10ps
module top_tb;

reg clk, read, write;
reg signed [5:0] data_in0, data_in1, data_in2, data_in3;
wire signed [15:0] data_out;

top dut (
    .clk(clk),
    .read(read),
    .write(write),
    .data_in0(data_in0),
    .data_in1(data_in1),
    .data_in2(data_in2),
    .data_in3(data_in3),
    .data_out(data_out)
);

initial begin
    clk <= 0;
    read <= 0;
    write <= 0;
    data_in0 <= 8;
    data_in1 <= 3;
    data_in2 <= -1;
    data_in3 <= -7;
    
    #40;
    write <= 1;
    
    #40;
    write <= 0;
    read <= 1;

    #40;
    read <= 0;
    data_in0 <= 8;
    data_in1 <= 3;
    data_in2 <= -1;
    data_in3 <= -5;

    #120
    data_in0 <= 8;
    data_in1 <= 3;
    data_in2 <= -1;
    data_in3 <= -3;

    #120
    data_in0 <= 8;
    data_in1 <= 3;
    data_in2 <= -1;
    data_in3 <= -1;

    #1000;
    $finish;
end

always #10 clk = ~clk;

endmodule
/*module tb_top();

reg tb_clk, tb_read, tb_write;
reg signed [5:0] tb_data_in0;
reg signed [5:0] tb_data_in1;
reg signed [5:0] tb_data_in2;
reg signed [5:0] tb_data_in3;
wire signed [5:0] tb_data_out; 

top top_module(
    .clk(tb_clk), 
    .read(tb_read), 
    .write(tb_write), 
    .data_in0(tb_data_in0),
    .data_in1(tb_data_in1),
    .data_in2(tb_data_in2),
    .data_in3(tb_data_in3),
    .data_out(tb_data_out)
);

initial begin
    $monitor(
        "time: %0d, tb_clk: %b, tb_read: %b, tb_data_in0: %b, tb_data_in1: %b, tb_data_in2: %b, tb_data_in3: %b, tb_data_out: %b",
         $time, tb_clk, tb_read, tb_write, tb_data_in0, tb_data_in1, tb_data_in2, tb_data_in3, tb_data_out);
    tb_clk=0;
    tb_read=0;
    tb_write=0;
    tb_data_in0=6'sd100111;
    tb_data_in1=6'sd001001;
    tb_data_in2=6'sd111001;
    tb_data_in3=6'sd010001;

    #50
    tb_write=1;
    tb_read=1;
    #100
    tb_clk=1;
    #1000
    $finish;
end
endmodule*/