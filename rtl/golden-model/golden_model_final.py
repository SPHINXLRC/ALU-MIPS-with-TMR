import random


def calculo_ula(c_ula, operando_a, operando_b, bit_width):
    max_val = 2 ** bit_width
    mask = max_val - 1
    zero = 0

    if c_ula == '0':  # AND
        ula_value = operando_a & operando_b
        print(operando_a)
        print(operando_b)
        print(ula_value)

    elif c_ula == '1':  # OR
        ula_value = operando_a | operando_b

    elif c_ula == '2':  # SOMA
        ula_value = (operando_a + operando_b) & mask

    elif c_ula == '6':  # SUBTRAÇÃO
        ula_value = (operando_a - operando_b) & mask
        if ula_value == 0:
            zero = 1

    elif c_ula == '7':  # SET ON LESS THAN
        ula_value = 1 if operando_a < operando_b else 0
    else:
        ula_value = 0

    return {'resultado': ula_value, 'sinal_zero': zero}


def gerar_estimulos(filename, n_valores=50, c_ula_width=3, bit_width=32, result_width=32):
    with open(filename, 'w') as f:
        for n in range(n_valores):
            valores = ['0', '1', '2', '6', '7']
            c_ula = random.choice(valores)
            operando_a = random.randint(0, 2 ** bit_width - 1)
            operando_b = random.randint(0, 2 ** bit_width - 1)

            ula_value_zero = calculo_ula(c_ula, operando_a, operando_b, bit_width)
            resultado = ula_value_zero['resultado']
            zero = ula_value_zero['sinal_zero']
            erro = 0

            c_ula_bin = f'{int(c_ula):0{c_ula_width}b}'
            operando_a_bin = f'{operando_a:0{bit_width}b}'
            operando_b_bin = f'{operando_b:0{bit_width}b}'
            resultado_bin = f'{resultado:0{result_width}b}'
            print(operando_a_bin)
            print(operando_b_bin)
            print(resultado_bin)

            f.write(f'{operando_a_bin} {operando_b_bin} {c_ula_bin} {resultado_bin} {zero} {erro}\n')


# Gerar o arquivo de estímulos
gerar_estimulos('estimulos.dat', n_valores=50, c_ula_width=3, bit_width=32, result_width=32)
