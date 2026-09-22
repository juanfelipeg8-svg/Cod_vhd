LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux2_1 IS
    PORT (
        A  : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
        B  : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
        SW : IN  STD_LOGIC;
        Y  : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
END mux2_1;

ARCHITECTURE Behavioral OF mux2_1 IS
BEGIN
    Y <= B WHEN SW = '1' ELSE A;
END Behavioral;