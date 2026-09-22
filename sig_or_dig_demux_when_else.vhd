LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sig_or_dig_demux_when_else IS
    PORT(
        Sig : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Dig : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        S   : IN  STD_LOGIC;
        SoD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE Behavioral OF sig_or_dig_demux_when_else IS
BEGIN
    SoD <= Sig WHEN S = '0' ELSE Dig;
END Behavioral;