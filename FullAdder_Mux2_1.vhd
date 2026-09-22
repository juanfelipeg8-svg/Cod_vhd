LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FullAdder_Mux2_1 IS
    PORT(A    : IN  STD_LOGIC;
         B    : IN  STD_LOGIC;
         Cin  : IN  STD_LOGIC;
			AB   : OUT STD_LOGIC;
         Cout : OUT STD_LOGIC);
END ENTITY FullAdder_Mux2_1;

ARCHITECTURE functional OF FullAdder_Mux2_1 IS
      SIGNAL X : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
		X <= A & B & Cin;
      WITH X SELECT
		AB <= '0' WHEN "000",
		      '1' WHEN "001",
			   '1' WHEN "010",
			   '0' WHEN "011",
			   '1' WHEN "100",
			   '0' WHEN "101",
			   '0' WHEN "110",
			   '1' WHEN "111",
			   '0' WHEN OTHERS;
		
		WITH X SELECT
		Cout <= '0' WHEN "000",
			     '0' WHEN "001",
			     '0' WHEN "010",
			     '1' WHEN "011",
			     '0' WHEN "100",
			     '1' WHEN "101",
			     '1' WHEN "110",
			     '1' WHEN "111",
			     '0' WHEN OTHERS;	
		
END ARCHITECTURE functional;