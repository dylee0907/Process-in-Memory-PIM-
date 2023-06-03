module demux #(
    parameter Data_width_demux=6    
)(
    input sel,
    input [Data_width_demux-1:0] Mux_in,
    output [Data_width_demux-1:0] Mux_out_pos,
    output [Data_width_demux-1:0] Mux_out_neg
);

assign Mux_out_pos=(sel==1'b0) ? Mux_in : 1'b0;
assign Mux_out_neg=(sel==1'b1) ? Mux_in : 1'b0;

endmodule