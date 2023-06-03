module SRAM_column #(
    parameter column_beta=2, 
    parameter n=4
)(
    input [3:0] twiddle_column, 

    input [5:0] data_in0_pos,
    input [5:0] data_in1_pos,
    input [5:0] data_in2_pos,
    input [5:0] data_in3_pos,

    input [5:0] data_in0_neg,
    input [5:0] data_in1_neg,
    input [5:0] data_in2_neg,
    input [5:0] data_in3_neg, 
    
    output [12:0] pos_data_out,
    output [12:0] neg_data_out
);
wire [9:0] data_in0_beta_pos;
wire [9:0] data_in1_beta_pos;
wire [9:0] data_in2_beta_pos;
wire [9:0] data_in3_beta_pos;

wire [9:0] data_in0_beta_neg;
wire [9:0] data_in1_beta_neg;
wire [9:0] data_in2_beta_neg;
wire [9:0] data_in3_beta_neg;

wire [9:0] pos_cell_out0;
wire [9:0] pos_cell_out1;
wire [9:0] pos_cell_out2;
wire [9:0] pos_cell_out3;

wire [9:0] neg_cell_out0;
wire [9:0] neg_cell_out1;
wire [9:0] neg_cell_out2;
wire [9:0] neg_cell_out3;

assign data_in0_beta_pos=data_in0_pos * (column_beta**n);
assign data_in1_beta_pos=data_in1_pos * (column_beta**n);
assign data_in2_beta_pos=data_in2_pos * (column_beta**n);
assign data_in3_beta_pos=data_in3_pos * (column_beta**n);

assign data_in0_beta_neg=data_in0_neg * (column_beta**n);
assign data_in1_beta_neg=data_in1_neg * (column_beta**n);
assign data_in2_beta_neg=data_in2_neg * (column_beta**n);
assign data_in3_beta_neg=data_in3_neg * (column_beta**n);

//pos
SRAM_cell #(
    .Data_width_SRAM_cell(10)
) cell0_pos (
    .twiddle_bit(twiddle_column[3]), .data_bits_beta(data_in0_beta_pos), .cell_out(pos_cell_out0)
);

SRAM_cell #(
    .Data_width_SRAM_cell(10)
) cell1_pos (
    .twiddle_bit(twiddle_column[2]), .data_bits_beta(data_in1_beta_pos), .cell_out(pos_cell_out1)
);

SRAM_cell #(
    .Data_width_SRAM_cell(10)
) cell2_pos (
    .twiddle_bit(twiddle_column[1]), .data_bits_beta(data_in2_beta_pos), .cell_out(pos_cell_out2)
);

SRAM_cell #(
    .Data_width_SRAM_cell(10)
) cell3_pos (
    .twiddle_bit(twiddle_column[0]), .data_bits_beta(data_in3_beta_pos), .cell_out(pos_cell_out3)
);

//neg
SRAM_cell #(
    .Data_width_SRAM_cell(10)
) cell0_neg (
    .twiddle_bit(twiddle_column[3]), .data_bits_beta(data_in0_beta_neg), .cell_out(neg_cell_out0)
);

SRAM_cell #(
    .Data_width_SRAM_cell(10)
) cell1_neg (
    .twiddle_bit(twiddle_column[2]), .data_bits_beta(data_in1_beta_neg), .cell_out(neg_cell_out1)
);

SRAM_cell #(
    .Data_width_SRAM_cell(10)
) cell2_neg (
    .twiddle_bit(twiddle_column[1]), .data_bits_beta(data_in2_beta_neg), .cell_out(neg_cell_out2)
);

SRAM_cell #(
    .Data_width_SRAM_cell(10)
) cell3_neg (
    .twiddle_bit(twiddle_column[0]), .data_bits_beta(data_in3_beta_neg), .cell_out(neg_cell_out3)
);

assign pos_data_out=pos_cell_out0 + pos_cell_out1 + pos_cell_out2 + pos_cell_out3;
assign neg_data_out=neg_cell_out0 + neg_cell_out1 + neg_cell_out2 + neg_cell_out3;
endmodule