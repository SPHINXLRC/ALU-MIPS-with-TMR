LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY somadornbits IS
	 generic(N: POSITIVE := 32);
    PORT (
			 cin : IN STD_LOGIC;
          a, b : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
          s : OUT STD_LOGIC_VECTOR (N DOWNTO 0)
);
END somadornbits;

ARCHITECTURE comportamento OF somadornbits IS
    SIGNAL c : STD_LOGIC_VECTOR(N DOWNTO 0);
    COMPONENT Somador1bit
          PORT (cin, a, b : IN  STD_LOGIC;
                        s, cout : OUT  STD_LOGIC);
    END COMPONENT;
	 
BEGIN
	scs: for i in 0 to N - 1 generate
		sc_internal: if i = 0 generate
		sc : somador1bit PORT MAP(cin, a(i), b(i), s(i), c(i + 1));
		elsif i = N - 1 generate
		sc : somador1bit PORT MAP(c(i), a(i), b(i), s(i), c(i+1));
		else generate
		sc : somador1bit PORT MAP(c(i), a(i), b(i), s(i), c(i+1));
		end generate sc_internal;
	end generate scs;


END comportamento;