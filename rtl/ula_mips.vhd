LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula_mips IS
	GENERIC (
		N : INTEGER := 32 
	);
	PORT (
		  clk : IN STD_LOGIC; 
        iniciar : IN STD_LOGIC; 
        reset : IN STD_LOGIC; 
        A : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0); 
        B : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
		  C: IN STD_LOGIC_VECTOR (2 downto 0); 
        S : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0); 
		  Zero : OUT STD_LOGIC;
		  erro : OUT STD_LOGIC;
		  cou : OUT STD_LOGIC_VECTOR(5 downto 0);
        pronto : OUT STD_LOGIC 
		  );
		  
END ENTITY; 

ARCHITECTURE arch OF ula_mips IS
  
  --signals
  signal cpA_s: std_logic;
  signal cpB_s: std_logic;
  signal c_ULA_s: std_logic;
  signal cR_s: std_logic;
  signal c_red_s: std_logic;
  signal count: std_logic_vector(5 downto 0) := "000000"; 
  signal err: std_logic;

  
begin
--process(err)
--	begin
--	erro <= err;
--	cou <= count;

--	if (err = '1') then
--		count <= count + "000001";
--	elsif (err = '0') then
--		count <= count;
--	end if;
--end process;

  --componentes 
  -- bloco de controle
  sad_controle: entity work.bloco_controlador(arch)
    port map(
      clk => clk,
      reset => reset,
		iniciar => iniciar,
		pronto => pronto,
		cpA => cpA_s,
		cpB => cpB_s,
		cULA => c_ULA_s,
		cR => cR_s,
		c_red => c_red_s
    );


-- bloco operativo 
sad_operativo_calculo: entity work.bloco_operativo(bo)
port map(
clk => clk,
cpA => cpA_s,
cpB => cpB_s,
cULA => c_ULA_s,
cR => cR_s,
c_red => c_red_s,
A => A,
B => B,
C => C,
S => S,
Zero => Zero,
error => err
);

	
END ARCHITECTURE; 