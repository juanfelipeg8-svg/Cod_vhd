LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FF_D IS
    PORT (
        D   : IN  STD_LOGIC;
        CLK : IN  STD_LOGIC;
        Q   : OUT STD_LOGIC
    );
END ENTITY FF_D;

ARCHITECTURE rtl OF FF_D IS

    SIGNAL Q_INT : STD_LOGIC := '0';

BEGIN

    PROCESS(CLK)
    BEGIN
        -- El boton de la DE0 es activo en bajo:
        -- al presionarlo ocurre un flanco 1 -> 0
        IF falling_edge(CLK) THEN
            Q_INT <= D;
        END IF;
    END PROCESS;

    Q <= Q_INT;

END ARCHITECTURE rtl;