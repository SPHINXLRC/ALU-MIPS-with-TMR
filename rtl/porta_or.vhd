LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity porta_or is
generic(N: POSITIVE := 32);

port(
			A,B: in std_logic_vector((N-1) downto 0);
			S: out std_logic_vector((N-1) downto 0)
);
end entity;

architecture ori of porta_or is
begin

S <= A or B;

end ori;