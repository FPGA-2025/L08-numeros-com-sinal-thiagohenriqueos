module numeros_com_sinal (
    input  signed [7:0] entrada_signed_1,
    input  signed [3:0] entrada_signed_2,
    input         [7:0] entrada_unsigned_1,
    input         [3:0] entrada_unsigned_2,
    input         [1:0] codigo,
    output signed [7:0] saida
);

    // Extensão de sinal: transforma os 4 bits de entrada_signed_2 em 8 bits com sinal
    wire signed [7:0] signed2_ext = { {4{entrada_signed_2[3]}}, entrada_signed_2 };

    // Extensão com zero: transforma os 4 bits de entrada_unsigned_2 em 8 bits sem sinal
    wire        [7:0] unsigned2_ext = { 4'b0000, entrada_unsigned_2 };

    // Resultado para código 00: signed_1 + signed_2
    wire signed [7:0] resultado_00 = entrada_signed_1 + signed2_ext;

    // Resultado para código 01: unsigned_1 + unsigned_2, ambos convertidos para signed
    wire signed [7:0] resultado_01 = $signed(entrada_unsigned_1) + $signed(unsigned2_ext);

    // Resultado para código 10: unsigned_1 (convertido) + signed_1
    wire signed [7:0] resultado_10 = $signed(entrada_unsigned_1) + entrada_signed_1;

    // Resultado para código 11: unsigned_1 (convertido) + unsigned_2 (convertido)
    wire signed [7:0] resultado_11 = $signed(entrada_unsigned_1) + $signed(unsigned2_ext);

    // Seletor da operação com base no código de entrada
    assign saida = (codigo == 2'b00) ? resultado_00 :
                   (codigo == 2'b01) ? resultado_01 :
                   (codigo == 2'b10) ? resultado_10 :
                   resultado_11; // default: código == 11

endmodule
