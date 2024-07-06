LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity porta_and is
generic(N: POSITIVE := 32);

port(
		A,B: in std_logic_vector(N-1 downto 0);
		S: out std_logic_vector(N-1 downto 0)
 );
end entity;

architecture andi of porta_and is 
begin

S <= (A and B);

end andi;