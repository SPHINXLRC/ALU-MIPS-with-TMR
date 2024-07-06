LIBRARY IEEE;
USE IEEE.Std_Logic_1164.all;
USE IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity teste is 
generic(N: integer := 32);
port(
		-- Entradas
		A: in std_logic_vector((N-1) downto 0); 
		B: in std_logic_vector((N-1) downto 0);	
		C: in std_logic_vector(2 downto 0);
		--clk: in std_logic;
		--cULA, cpA, cpB, cR: in std_logic;
		--logico_um, logico_dois : in std_logic;
		
		-- Saídas
		Zero: out std_logic;
		S: out std_logic_vector((N-1) downto 0);
		error: out std_logic
		--reso1, reso2, reso3: out std_logic_vector(N-1 downto 0)
		--zero1, zero2, zero3: out std_logic
);
end entity;

architecture bo of teste is

signal RegA, RegB, Resultado, resul_false: std_logic_vector (N-1 downto 0);
signal RegC: std_logic_vector (2 downto 0);
signal c_red : std_logic;


component Redundancia
generic(N: integer := 4);
	port(
			-- entradas
			A: in std_logic_vector((N-1) downto 0); 
			B: in std_logic_vector((N-1) downto 0);	
			C: in std_logic_vector(2 downto 0);
			c_red: in std_logic :='1';
			
			-- Saídas
			Zero: out std_logic;
			S: out std_logic_vector((N-1) downto 0);
			error: out std_logic
			--res1, res2, res3: out std_logic_vector(N-1 downto 0)
			--
	  );
end component;

begin

--error <= error1 and error2;

redun: Redundancia
	port map(
		A => A,
		B => B,
		C => C,
		c_red => c_red,
		Zero => Zero,
		S => S,
		error => error
		--res1 => reso1,
		--res2 => reso2,
		--res3 => reso3
		--zeroa => zero1,
		--zerob => zero2,
		--zeroc => zero3
		);
		
		
end architecture;