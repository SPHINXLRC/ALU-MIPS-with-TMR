LIBRARY IEEE;
USE IEEE.Std_Logic_1164.all;
USE IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity logica is 
generic(N: integer := 32);
port(
		c0: in std_logic;
		A, B: in std_logic_vector((N-1) downto 0);
		S: out std_logic_vector((N-1) downto 0)
);
end entity;

architecture log of logica is
signal saida_porta_and, saida_porta_or: std_logic_vector((N-1) downto 0);

component porta_and is
generic(N: integer := N);
	port(
			A, B: in std_logic_vector((N-1) downto 0);
			S: out std_logic_vector((N-1) downto 0)
		  );
end component;

component porta_or is
generic(N: integer := N);
	port(
			A,B: in std_logic_vector((N-1) downto 0);
			S: out std_logic_vector((N-1) downto 0)
		  );
end component;

begin
	process(c0)
	begin
	if (c0 = '1') then
			S <= saida_porta_or;
	else
			S <= saida_porta_and;
	end if;
	end process;

porta_andi: porta_and 
generic map(N => N)
port map(
										A => A,
										B => B,
										S => saida_porta_and
										);

porta_ori: porta_or 
generic map(N => N)
port map(
									 A => A,
									 B => B,
									 S => saida_porta_or
									 );
									 
end architecture;