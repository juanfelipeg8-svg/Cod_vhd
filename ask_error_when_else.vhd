LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ask_error_when_else IS
    PORT(
        A : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        E : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE Behavioral OF ask_error_when_else IS
BEGIN
    -- Sin error
    E <= "00";
END Behavioral;