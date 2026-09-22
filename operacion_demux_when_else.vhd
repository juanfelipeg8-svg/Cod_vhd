LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY operacion_demux_when_else IS
    PORT(
        Add : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
        Mul : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
        S   : IN  STD_LOGIC;
        Res : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE Behavioral OF operacion_demux_when_else IS
BEGIN
    Res <= Add WHEN S = '0' ELSE Mul;
END Behavioral;