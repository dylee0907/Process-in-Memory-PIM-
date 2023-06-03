module top(
    input clk, read, write,
    input signed [5:0] data_in0,
    input signed [5:0] data_in1,
    input signed [5:0] data_in2,
    input signed [5:0] data_in3,
    output signed [15:0] data_out
);

wire [5:0] bits0;
wire [5:0] bits1;
wire [5:0] bits2;
wire [5:0] bits3;

wire [5:0] Mux_bit_pos0;
wire [5:0] Mux_bit_pos1;
wire [5:0] Mux_bit_pos2;
wire [5:0] Mux_bit_pos3; 
wire [5:0] Mux_bit_neg0;
wire [5:0] Mux_bit_neg1;
wire [5:0] Mux_bit_neg2;
wire [5:0] Mux_bit_neg3; 

wire [13:0] data_pos;
wire [13:0] data_neg;

wire [5:0] DAC_bits0;
wire [5:0] DAC_bits1;
wire [5:0] DAC_bits2;
wire [5:0] DAC_bits3;


//LUT
twiddle_LUT lut(
    .enable(clk),
    .twiddle_bits0(bits0), 
    .twiddle_bits1(bits1), 
    .twiddle_bits2(bits2), 
    .twiddle_bits3(bits3)
);

//XOR
XOR xor0(
    .input_sign(data_in0[5]), 
    .twiddle_sign(bits0[5]), 
    .xor_out(sel0)
);
XOR xor1(
    .input_sign(data_in1[5]), 
    .twiddle_sign(bits1[5]), 
    .xor_out(sel1)
);
XOR xor2(
    .input_sign(data_in2[5]), 
    .twiddle_sign(bits2[5]), 
    .xor_out(sel2)
);
XOR xor3(
    .input_sign(data_in3[5]), 
    .twiddle_sign(bits3[5]), 
    .xor_out(sel3)
);

//DAC
DAC #(
    .Data_width_DAC(5), 
    .DAC_constant(2)
) dac0 (
    .DAC_in(data_in0[4:0]),
    .DAC_out(DAC_bits0)  
);
DAC #(
    .Data_width_DAC(5), 
    .DAC_constant(2)
) dac1 (
    .DAC_in(data_in1[4:0]),
    .DAC_out(DAC_bits1)  
);
DAC #(
    .Data_width_DAC(5), 
    .DAC_constant(2)
) dac2 (
    .DAC_in(data_in2[4:0]),
    .DAC_out(DAC_bits2)  
);
DAC #(
    .Data_width_DAC(5), 
    .DAC_constant(2)
) dac3 (
    .DAC_in(data_in3[4:0]),
    .DAC_out(DAC_bits3)  
);

//Demux
demux #(
    .Data_width_demux(6)
) demux0 (
    .sel(sel0),
    .Mux_in(DAC_bits0),
    .Mux_out_pos(Mux_bit_pos0),
    .Mux_out_neg(Mux_bit_neg0)
);
demux #(
    .Data_width_demux(6)
) demux1 (
    .sel(sel1),
    .Mux_in(DAC_bits1),
    .Mux_out_pos(Mux_bit_pos1),
    .Mux_out_neg(Mux_bit_neg1)
);
demux #(
    .Data_width_demux(6)
) demux2 (
    .sel(sel2),
    .Mux_in(DAC_bits2),
    .Mux_out_pos(Mux_bit_pos2),
    .Mux_out_neg(Mux_bit_neg2)
);
demux #(
    .Data_width_demux(6)
) demux3 (
    .sel(sel3),
    .Mux_in(DAC_bits3),
    .Mux_out_pos(Mux_bit_pos3),
    .Mux_out_neg(Mux_bit_neg3)
);

SRAM #(
    .Data_width_SRAM(14)
) sram (
    .enable(clk),
    .read(read),
    .write(write),
    .data_in0_pos(Mux_bit_pos0),
    .data_in1_pos(Mux_bit_pos1),
    .data_in2_pos(Mux_bit_pos2),
    .data_in3_pos(Mux_bit_pos3),
    .data_in0_neg(Mux_bit_neg0),
    .data_in1_neg(Mux_bit_neg1),
    .data_in2_neg(Mux_bit_neg2),
    .data_in3_neg(Mux_bit_neg3),
    .twiddle_in0(bits0[4:0]),
    .twiddle_in1(bits1[4:0]),
    .twiddle_in2(bits2[4:0]),
    .twiddle_in3(bits3[4:0]),
    .data_out_pos(data_pos),
    .data_out_neg(data_neg)
);

Final_addition #(
    .Data_width_addition(14)
) fin_add (
    .pos_in(data_pos),
    .neg_in(data_neg),
    .result(data_out)
);
endmodule