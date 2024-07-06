LIBRARY IEEE;
USE IEEE.Std_Logic_1164.all;
USE IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.all;
use std.textio.all;

entity testbench is
end testbench;

architecture tb of testbench is

    constant N: integer := 32;
		
	 signal clk: std_logic := '0';
	 signal iniciar: std_logic := '0';
	 signal reset: std_logic := '0';
	 signal A: std_logic_vector(N - 1 downto 0):= (others => '0');
	 signal B: std_logic_vector(N - 1 downto 0):= (others => '0');
	 signal C: std_logic_vector(2 downto 0):= (others => '0');
	 signal Zero: std_logic := '0';
	 signal erro: std_logic := '0';
	 signal S: std_logic_vector(N-1 downto 0):= (others => '0');
	 signal pronto: std_logic := '0';
	 signal finished: std_logic := '0';
	 
	 constant passo : TIME := 20 ns;

begin

    clk_process : process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for passo / 2;
            clk <= '1';
            wait for passo / 2;
        end loop;
        clk <= '0';
    end process;


    DUV: entity work.ula_mips
        port map(
				clk => clk,
				iniciar => iniciar,
				reset => reset,
            A => A,
            B => B,
            C => C,
				S => S,
            Zero => Zero,
				erro => erro,
				pronto => pronto
        );

   stim: process
    file arquivo_de_estimulos : text open read_mode is "../../estimulos.dat";
    variable linha_de_estimulos: line;
    variable espaco: character;
    variable valor_de_entrada_1: bit_vector(N-1 downto 0);
    variable valor_de_entrada_2: bit_vector(N-1 downto 0);
	 variable valor_de_entrada_3: bit_vector(2 downto 0);
    variable valor_de_saida_1: bit_vector(N-1 downto 0);
	 variable valor_de_saida_2: bit;
	 variable valor_de_saida_3: bit;

begin

	 reset <= '1';
    wait for passo;
    reset <= '0';
    iniciar <= '1';

    while not endfile(arquivo_de_estimulos) loop
	 
            readline(arquivo_de_estimulos, linha_de_estimulos);
            read(linha_de_estimulos, valor_de_entrada_1);
            A <= to_stdlogicvector(valor_de_entrada_1);
            read(linha_de_estimulos, espaco);
            read(linha_de_estimulos, valor_de_entrada_2);
            B <= to_stdlogicvector(valor_de_entrada_2);
            read(linha_de_estimulos, espaco);
				read(linha_de_estimulos, valor_de_entrada_3);
				C <= to_stdlogicvector(valor_de_entrada_3);
				read(linha_de_estimulos, espaco);
            read(linha_de_estimulos, valor_de_saida_1);
				read(linha_de_estimulos, espaco);
				read(linha_de_estimulos, valor_de_saida_2);
				read(linha_de_estimulos, espaco);
				read(linha_de_estimulos, valor_de_saida_3);
				
				wait until rising_edge(clk);
				wait until pronto = '1';
				wait for passo;
				
            assert (S = to_stdlogicvector(valor_de_saida_1))
				    report "Falha na simulação: S errado."
                severity error;
					 
				assert (Zero = to_stdulogic(valor_de_saida_2))
                report "Falha na simulação: Zero errado."
                severity error;
					 
            if erro = '1' then
                report "Falha na simulação: 'Erro' sinalizado."
                severity error;
            end if;
    end loop;
	 
	 wait until rising_edge(clk);
	 finished <= '1';
    assert false report "Teste concluído."
        severity note;
    wait;
end process;
end tb;