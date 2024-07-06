LIBRARY IEEE;
USE IEEE.Std_Logic_1164.all;
USE IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity aritimetica is
generic(N: integer := 32);
port(
		c2: in std_logic;
		A: in std_logic_vector((N-1) downto 0);
		B: in std_logic_vector((N-1) downto 0);
		S: out std_logic_vector((N-1) downto 0);
		overflow: out std_logic;
		Zero: out std_logic
		);
end entity;

architecture arc of aritimetica is

signal saida_somador: std_logic_vector(N downto 0);
signal saida_subtrator: std_logic_vector((N-1) downto 0);

component somadornbits is
generic(N: integer := N);
		PORT (
				cin : IN STD_LOGIC;
            a, b : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
            s : OUT STD_LOGIC_VECTOR (N DOWNTO 0)
		);
end component;

component subtratornbits is
generic(N: integer := N);
		port(
				sub1 : in std_logic_vector ((N-1) downto 0);
				sub2 : in std_logic_vector ((N-1) downto 0);
				saida : out signed ((N-1) downto 0)
		);
end component;

begin
	process(c2)
	begin
	if c2 = '1' then
		S <= saida_subtrator;
			if (saida_subtrator /= "0000") then
				Zero <= '0';
			else 
				Zero <= '1';
			end if;
	else
			S <= saida_somador((N-1) downto 0);
			if(saida_somador = "0000") then
				Zero <= '1';
			else 
				Zero <= '0';
			end if;
	end if;
	end process;

somador: somadornbits 
generic map(N => N)
port map(
										 cin => '0',
										 a => A,
										 b => B,
										 s => saida_somador
										);
										
subtrator: subtratornbits 
generic map(N => N)
port map(
											  sub1 => A,
											  sub2 => B,
											  std_logic_vector(saida) => saida_subtrator
											  );
											  
end architecture;