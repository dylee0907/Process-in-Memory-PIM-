module XOR(
    input input_sign,
    input twiddle_sign,
    output xor_out
);

assign xor_out=input_sign ^ twiddle_sign;
endmodule