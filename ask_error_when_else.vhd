LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ask_error_when_else IS
    PORT(
        A : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        E : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE structural OF ask_error_when_else IS
BEGIN
    -- E(0): error en A
    -- E(1): error en B
    -- En modo BCD los operandos válidos son 0000 a 1001.
    E(0) <= '1' WHEN A > "1001" ELSE '0';
    E(1) <= '1' WHEN B > "1001" ELSE '0';
END ARCHITECTURE;
