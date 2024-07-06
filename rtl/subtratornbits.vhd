LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtratornbits is
generic (N: integer := 32);
port (
    sub1 : in std_logic_vector (N-1 downto 0);
    sub2 : in std_logic_vector (N-1 downto 0);
    saida : out signed (N-1 downto 0)
);
end subtratornbits;

architecture rtl of subtratornbits is

--signal temp1, temp2: std_logic_vector(31 downto 0);

begin

    saida <= signed(sub1) - signed(sub2);
	 
	 
--	 if temp1(31) == '1' then
--		saida <= temp1;-
--	 else
--		saida <= temp2;
	 
end rtl;