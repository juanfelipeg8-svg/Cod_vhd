LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY encoder_error IS
    PORT(
        A   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        C   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        D   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        N   : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        S_1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        S_2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        S_3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        S_4 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE structural OF encoder_error IS
BEGIN
    -- Corrección del módulo original: se elimina PROCESS.
    -- N="00" = sin error; cualquier otro valor = mostrar EEEE.
    S_1 <= A WHEN N = "00" ELSE "1110";
    S_2 <= B WHEN N = "00" ELSE "1110";
    S_3 <= C WHEN N = "00" ELSE "1110";
    S_4 <= D WHEN N = "00" ELSE "1110";
END ARCHITECTURE;
