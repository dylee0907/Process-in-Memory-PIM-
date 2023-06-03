module SRAM #(
    parameter Data_width_SRAM=14
)(
    input enable, read, write,
    input [5:0] data_in0_pos,
    input [5:0] data_in1_pos,
    input [5:0] data_in2_pos,
    input [5:0] data_in3_pos,    
    
    input [5:0] data_in0_neg,
    input [5:0] data_in1_neg,
    input [5:0] data_in2_neg,
    input [5:0] data_in3_neg,    

    input [4:0] twiddle_in0,
    input [4:0] twiddle_in1,
    input [4:0] twiddle_in2,
    input [4:0] twiddle_in3,    
    output [Data_width_SRAM-1:0] data_out_pos,
    output [Data_width_SRAM-1:0] data_out_neg// 14bits
);

reg [4:0] Mem [0:3];

reg [3:0] Mem_column0;
reg [3:0] Mem_column1;
reg [3:0] Mem_column2;
reg [3:0] Mem_column3;
reg [3:0] Mem_column4;

wire [3:0] wire_Mem_column0;
wire [3:0] wire_Mem_column1;
wire [3:0] wire_Mem_column2;
wire [3:0] wire_Mem_column3;
wire [3:0] wire_Mem_column4;

wire [11:0] data_out0_pos;
wire [11:0] data_out1_pos;
wire [11:0] data_out2_pos;
wire [11:0] data_out3_pos;
wire [11:0] data_out4_pos;

wire [11:0] data_out0_neg;
wire [11:0] data_out1_neg;
wire [11:0] data_out2_neg;
wire [11:0] data_out3_neg;
wire [11:0] data_out4_neg;

assign wire_Mem_column0 = Mem_column0;
assign wire_Mem_column1 = Mem_column1;
assign wire_Mem_column2 = Mem_column2;
assign wire_Mem_column3 = Mem_column3;
assign wire_Mem_column4 = Mem_column4;


always @(posedge enable) begin
    if(write) begin //store twiddle factor
        Mem[0] <= twiddle_in0;
        Mem[1] <= twiddle_in1;
        Mem[2] <= twiddle_in2;
        Mem[3] <= twiddle_in3;
    end
    else if(read) begin
        Mem_column0 <= {Mem[0][0], Mem[1][0], Mem[2][0], Mem[3][0]};
        Mem_column1 <= {Mem[0][1], Mem[1][1], Mem[2][1], Mem[3][1]};
        Mem_column2 <= {Mem[0][2], Mem[1][2], Mem[2][2], Mem[3][2]};
        Mem_column3 <= {Mem[0][3], Mem[1][3], Mem[2][3], Mem[3][3]};
        Mem_column4 <= {Mem[0][4], Mem[1][4], Mem[2][4], Mem[3][4]};
    end
    else begin
        Mem[0] <= 0;
        Mem[1] <= 0;
        Mem[2] <= 0;
        Mem[3] <= 0;
    end
end

SRAM_column #(
    .column_beta(2),
    .n(4)
) column0 (
    .twiddle_column(Mem_column0),
    .data_in0_pos(data_in0_pos),
    .data_in1_pos(data_in1_pos),
    .data_in2_pos(data_in2_pos),
    .data_in3_pos(data_in3_pos),
    .data_in0_neg(data_in0_neg),
    .data_in1_neg(data_in1_neg),
    .data_in2_neg(data_in2_neg),
    .data_in3_neg(data_in3_neg),
    .pos_data_out(data_out0_pos),
    .neg_data_out(data_out0_neg)
);

SRAM_column #(
    .column_beta(2),
    .n(3)
) column1 (
    .twiddle_column(Mem_column1),
    .data_in0_pos(data_in0_pos),
    .data_in1_pos(data_in1_pos),
    .data_in2_pos(data_in2_pos),
    .data_in3_pos(data_in3_pos),
    .data_in0_neg(data_in0_neg),
    .data_in1_neg(data_in1_neg),
    .data_in2_neg(data_in2_neg),
    .data_in3_neg(data_in3_neg),
    .pos_data_out(data_out1_pos),
    .neg_data_out(data_out1_neg)
);

SRAM_column #(
    .column_beta(2),
    .n(2)
) column2 (
    .twiddle_column(Mem_column2),
    .data_in0_pos(data_in0_pos),
    .data_in1_pos(data_in1_pos),
    .data_in2_pos(data_in2_pos),
    .data_in3_pos(data_in3_pos),
    .data_in0_neg(data_in0_neg),
    .data_in1_neg(data_in1_neg),
    .data_in2_neg(data_in2_neg),
    .data_in3_neg(data_in3_neg),
    .pos_data_out(data_out2_pos),
    .neg_data_out(data_out2_neg)
);

SRAM_column #(
    .column_beta(2),
    .n(1)
) column3 (
    .twiddle_column(Mem_column3),
    .data_in0_pos(data_in0_pos),
    .data_in1_pos(data_in1_pos),
    .data_in2_pos(data_in2_pos),
    .data_in3_pos(data_in3_pos),
    .data_in0_neg(data_in0_neg),
    .data_in1_neg(data_in1_neg),
    .data_in2_neg(data_in2_neg),
    .data_in3_neg(data_in3_neg),
    .pos_data_out(data_out3_pos),
    .neg_data_out(data_out3_neg)
);

SRAM_column #(
    .column_beta(2),
    .n(0)
) column4 (
    .twiddle_column(Mem_column3),
    .data_in0_pos(data_in0_pos),
    .data_in1_pos(data_in1_pos),
    .data_in2_pos(data_in2_pos),
    .data_in3_pos(data_in3_pos),
    .data_in0_neg(data_in0_neg),
    .data_in1_neg(data_in1_neg),
    .data_in2_neg(data_in2_neg),
    .data_in3_neg(data_in3_neg),
    .pos_data_out(data_out4_pos),
    .neg_data_out(data_out4_neg)
);

assign data_out_pos = data_out0_pos + data_out1_pos + data_out2_pos + data_out3_pos + data_out4_pos;
assign data_out_neg = data_out0_neg + data_out1_neg + data_out2_neg + data_out3_neg + data_out4_neg; 

endmodule