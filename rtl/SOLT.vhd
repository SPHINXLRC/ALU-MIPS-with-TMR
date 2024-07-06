LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY SOLT IS
GENERIC (N : INTEGER := 32);
PORT (
	ov : IN STD_LOGIC;
	C: IN STD_LOGIC_VECTOR(2 downto 0);
	A,B : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
   saida_solt : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0)
);
END ENTITY;
ARCHITECTURE solti OF SOLT IS
 BEGIN
	process(C)
	begin
		if (C = "111") then
			if (A < B) then
				saida_solt <= (0 => '1',
				others => '0');
			else
				saida_solt <= (0 => '0',
				others => '0');
			end if;
		end if;
	end process;
 END solti;