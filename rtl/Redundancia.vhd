LIBRARY IEEE;
USE IEEE.Std_Logic_1164.all;
USE IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity Redundancia is
generic(N: integer := 4);
port(
			-- Entradas
		A: in std_logic_vector((N-1) downto 0); 
		B: in std_logic_vector((N-1) downto 0);	
		C: in std_logic_vector(2 downto 0);
		c_red: in std_logic;
		--logico_um, logico_dois : in std_logic;
		
		-- Saídas
		Zero: out std_logic;
		S: out std_logic_vector((N-1) downto 0);
		error: out std_logic
		--res1, res2, res3: out std_logic_vector(N-1 downto 0)
		--zeroa, zerob, zeroc: out std_logic
	  );
end entity;
  
architecture red of Redundancia is 

signal Resultado1, Resultado2, Resultado3: std_logic_vector (N-1 downto 0);
signal RegC1, RegC2, RegC3: std_logic_vector (2 downto 0);
signal Zero1, Zero2, Zero3, error1, error2: std_logic;
signal temp: std_logic := '0';
signal tempor: std_logic_vector(N-1 downto 0) := "00100000000000000000000000000000";


--signal tempor: std_logic_vector(N-1 downto 0) := "1000";

component ULA
generic(N: integer := N);
port(
		-- Entradas
		A: in std_logic_vector((N-1) downto 0); 
		B: in std_logic_vector((N-1) downto 0);	
		C: in std_logic_vector(2 downto 0);
		
		-- Saídas
		Zero: out std_logic;
		S: out std_logic_vector((N-1) downto 0)
		
);
end component;

begin
	process(c_red)
	begin
	
		-- lógica de redundancia do Zero
		if (Zero1 = Zero2) and (Zero3 = Zero1) then
			error1 <= '0';
			Zero <= Zero1;
		elsif (Zero1 = Zero2) and (Zero3 /= Zero1) then
			Zero <= Zero1;
			error1 <= '1';
		elsif (Zero1 = Zero3) and (Zero2 /= Zero1) then
			Zero <= Zero1;
			error1 <= '1';
		else
			Zero <= Zero2;
			error1 <= '1';
		end if;
		
		-- lógica de redundancia do S
		
		if (resultado1 = tempor) and (resultado3 = resultado1) and (c_red = '1') then
			S <= resultado1;
			error2 <= '0';
		elsif (resultado1 = resultado3) and (resultado3 /= tempor) and (c_red='1') then
			S <= resultado1;
			error2 <= '1';
		elsif (tempor = resultado3) and (tempor /= resultado1) and (c_red='1') then
			S <= tempor;
			error2 <= '1';
		elsif (c_red = '0') then
			error2 <= '0';
		else
			S <= tempor;
			error2 <= '1';
		end if;

	end process;

error <= error1 or error2;
--zeroa <= zero1;
--zerob <= zero2;
--zeroc <= zero3;
--res1 <=	resultado1;
--res2 <= resultado2;
--res3 <= resultado3;


ULA1: ULA
generic map(N => N)
	port map(
		A => A,
		B => B,
		C => C,
		Zero => Zero1,
		S => Resultado1);

ULA2: ULA
generic map(N => N)
	port map(
		A => A,
		B => B,
		C => C,
		Zero => Zero2,
		S => Resultado2);
		
ULA3: ULA
generic map(N => N)
	port map(
		A => A,
		B => B,
		C => C,
		Zero => Zero3,
		S => Resultado3);
		
end architecture;