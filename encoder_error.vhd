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

ARCHITECTURE Behavioral OF encoder_error IS
BEGIN
    PROCESS(A, B, C, D, N)
    BEGIN
        IF N = "00" THEN
            -- Sin error: pasar datos tal cual
            S_1 <= A;
            S_2 <= B;
            S_3 <= C;
            S_4 <= D;
        ELSE
            -- Con error: mostrar EEEE
            S_1 <= "1110";
            S_2 <= "1110";
            S_3 <= "1110";
            S_4 <= "1110";
        END IF;
    END PROCESS;
END Behavioral;