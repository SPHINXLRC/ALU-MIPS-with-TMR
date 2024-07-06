LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.math_real.all;
use ieee.numeric_std.all; 

ENTITY bloco_controlador IS
	GENERIC (
		N : INTEGER := 32;
		B : INTEGER := 16;
		P : INTEGER := 4 
	);
	PORT (
		clk : IN STD_LOGIC;
		iniciar : IN STD_LOGIC;
		reset : IN STD_LOGIC; 
		pronto : OUT STD_LOGIC;
		cpA, cpB, cR, cULA, c_red: OUT STD_LOGIC
		);
END ENTITY;

ARCHITECTURE arch OF bloco_controlador IS
TYPE STATES IS (S0,S1,S2,S3);
SIGNAL EA, PE: STATES;
		
BEGIN
	REG: process(CLK,reset)
	begin
		if reset='1' then
			EA <= S0;
		elsif (CLK'event AND CLK = '1') then
			EA <= PE;
		end if;
	end process;

	COMB: process(EA, iniciar)
	begin
		case EA is	  
		  when S0 => 
				if iniciar = '1' then
					PE <= S1;
				else
					PE <= S0;
				end if;
				
		  when S1 =>
				PE <= S2;
				
		  when S2 => 
				PE <= S3;
				
		  when S3 =>
				PE <= S0;
				
		end case;
	end process;
	
	pronto <= '1' when EA = S0 else '0';
	cpA <= '1' when EA = S2 else '0';
	cpB <= '1' when EA = S2 else '0';
	cULA <= '1' when EA = S1 else '0';
	cR <= '1' when EA = S3 else '0';
	c_red <= '1' when EA = S3 else '0';
	
END ARCHITECTURE; 