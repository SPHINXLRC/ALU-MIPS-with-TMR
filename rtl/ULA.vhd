LIBRARY IEEE;
USE IEEE.Std_Logic_1164.all;
--USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.all;

-- Adicionar lógica do set on less then

entity ULA is 
generic(N: integer := 32);
port(
		-- Entradas
		A: in std_logic_vector((N-1) downto 0); 
		B: in std_logic_vector((N-1) downto 0);	
		C: in std_logic_vector(2 downto 0);
		--logico_um, logico_dois : in std_logic;
		
		-- Saídas
		Zero: out std_logic := '0';
		S: out std_logic_vector((N-1) downto 0)
		--saida_som: out std_logic_vector(32 downto 0);
		--saida_sub: out std_logic_vector(31 downto 0)
		--saida_and, saida_or, saida_solt: out std_logic

);
end entity;

architecture arc of ULA is

signal saida_logica, saida_aritimetica,saida_solt, saida_mux1: std_logic_vector((N-1) downto 0);
signal ov, slt: std_logic;

component aritimetica is
generic(N: integer := N);
		PORT (
				c2: in std_logic;
				A: in std_logic_vector((N-1) downto 0);
				B: in std_logic_vector((N-1) downto 0);
				S: out std_logic_vector((N-1) downto 0);
				overflow: out std_logic;
				Zero: out std_logic
		);
end component;

component logica is
generic(N: integer := N);
	port(
			c0: in std_logic;
			A, B: in std_logic_vector((N-1) downto 0);
			S: out std_logic_vector((N-1) downto 0)
		  );
end component;



component mux2para1 is
generic(N: integer := N);
	port(
		   sel : IN STD_LOGIC;
			a, b : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
			y : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0)
	
		  );		
end component;

component SOLT is
generic(N: integer := N);
	port(
		  ov : IN STD_LOGIC;
	     C: IN STD_LOGIC_VECTOR(2 downto 0);
		  A,B : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
	     saida_solt : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0)
		  );
end component;

begin
	process(C)
	begin
		if (C = "111") then
			slt <= '1';
		else
			slt <= '0';
		end if;
	end process;
			
mux1: mux2para1 
generic map(N => N)
port map(
								sel => C(1),
								a => saida_logica,
								b => saida_aritimetica,
								y => saida_mux1
								 );
								 
mux2: mux2para1
generic map(N => N)
port map(
								 sel => slt,
								 a => saida_mux1,
								 b => saida_solt,
								 y => S
								 );
								
log: logica 
generic map(N => N)
port map(
							c0 => C(0),
							A => A,
							B => B,
							S => saida_logica
							);
		
ari: aritimetica 
generic map(N => N)
port map(
									c2 => C(2),
									A => A,
									B => B,
									S => saida_aritimetica,
									overflow => ov,
									Zero => Zero);
									
solti: SOLT
generic map(N => N)
port map(
							ov => ov,
							C => C,
							A => A,
							B => B,
							saida_solt => saida_solt);
									
end architecture;
