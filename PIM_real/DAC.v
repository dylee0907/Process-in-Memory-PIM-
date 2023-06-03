module DAC #(
    parameter Data_width_DAC=5,
    parameter DAC_constant=2
)(
    input [Data_width_DAC-1: 0] DAC_in,
    output [Data_width_DAC : 0] DAC_out 
);

assign DAC_out=DAC_in * DAC_constant;
endmodule