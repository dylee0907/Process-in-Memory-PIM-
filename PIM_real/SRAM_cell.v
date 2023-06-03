module SRAM_cell #(
    parameter Data_width_SRAM_cell=9
)(
    input twiddle_bit,
    input [Data_width_SRAM_cell-1:0] data_bits_beta,
    output [Data_width_SRAM_cell-1:0] cell_out
);

assign cell_out=data_bits_beta * twiddle_bit;
endmodule