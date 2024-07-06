LIBRARY IEEE;
USE IEEE.Std_Logic_1164.all;
USE IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity bloco_operativo is 
generic(N: integer := 32);
port(
		-- Entradas
		A: in std_logic_vector((N-1) downto 0); 
		B: in std_logic_vector((N-1) downto 0);	
		C: in std_logic_vector(2 downto 0);
		clk: in std_logic;
		cULA, cpA, cpB, cR,c_red: in std_logic;
		--logico_um, logico_dois : in std_logic;
		
		-- Saídas
		Zero, error: out std_logic := '0';
		S: out std_logic_vector((N-1) downto 0)
);
end entity;

architecture bo of bloco_operativo is

signal RegA, RegB, Resultado, resul_false: std_logic_vector (N-1 downto 0);
signal RegC: std_logic_vector (2 downto 0);
signal zero1: std_logic;

component registrador 
GENERIC (N: INTEGER := 32);
	PORT (
	clk, carga: IN STD_LOGIC;
	D: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
	Q: OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0)
	);
end component;


component Redundancia
generic(N: integer := 32);
	port(
			-- entradas
			A: in std_logic_vector((N-1) downto 0); 
			B: in std_logic_vector((N-1) downto 0);	
			C: in std_logic_vector(2 downto 0);
			c_red: in std_logic;
			
			-- Saídas
			Zero: out std_logic := '0';
			S: out std_logic_vector((N-1) downto 0);
			error: out std_logic
	  );
end component;

begin

--error <= error1 and error2;

pA: registrador
generic map(N => 32)
    port map(
        clk => clk,
        carga => cpA,
        D => A,
        Q => RegA);
		  
pB: registrador
generic map(N => 32)
    port map(
        clk => clk,
        carga => cpB,
        D => B,
        Q => RegB);
		  
pcULA: registrador
generic map(N => 3)
    port map(
        clk => clk,
        carga => cULA,
        D => C,
        Q => RegC);
		  
redun: Redundancia
	port map(
		A => RegA,
		B => RegB,
		C => RegC,
		c_red => c_red,
		zero => zero,
		S => Resultado,
		error => error);
		
pR: registrador
generic map(N => 32)
    port map(
        clk => clk,
        carga => cR,
        D => Resultado,
        Q => S);
end architecture;