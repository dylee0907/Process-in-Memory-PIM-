module Final_addition#(
    parameter Data_width_addition=14
)(
    input [Data_width_addition-1:0] pos_in,
    input [Data_width_addition-1:0] neg_in,
    output reg signed [15:0] result
);

always @(*) begin
    if(pos_in>neg_in) begin
        result = {1'b0, pos_in-neg_in};
    end
    else if(pos_in<neg_in) begin
        result = {1'b1, neg_in-pos_in};
    end
    else begin
        result = 0;
    end
end
endmodule