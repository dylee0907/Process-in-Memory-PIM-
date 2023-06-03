module twiddle_LUT(
    input enable,
    output reg signed [5:0] twiddle_bits0,
    output reg signed [5:0] twiddle_bits1,
    output reg signed [5:0] twiddle_bits2,
    output reg signed [5:0] twiddle_bits3
); 

always @(posedge enable) begin
        twiddle_bits0 <= 6'b0_00_000;
        twiddle_bits1 <= 6'b0_01_101;
        twiddle_bits2 <= 6'b1_00_011;
        twiddle_bits3 <= 6'b1_01_101;
    end
endmodule