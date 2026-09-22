LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Módulo para obtener el complemento a 2 de un número
ENTITY Complemento_A2 IS
    GENERIC (
        bits : INTEGER := 4
    );
    PORT(
        B      : IN  STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
        SEL    : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        SALIDA : OUT STD_LOGIC_VECTOR(bits-1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE structural OF Complemento_A2 IS
    CONSTANT N_BITS : INTEGER := bits;

    -- Señales internas para el acarreo, complemento y resultado
    SIGNAL C        : STD_LOGIC_VECTOR(N_BITS DOWNTO 0);
    SIGNAL NB       : STD_LOGIC_VECTOR(N_BITS-1 DOWNTO 0);
    SIGNAL A2       : STD_LOGIC_VECTOR(N_BITS-1 DOWNTO 0);
    SIGNAL SAL_TMP  : STD_LOGIC_VECTOR(N_BITS-1 DOWNTO 0);

BEGIN

    -- Se obtiene el complemento a 1 de B
    NB <= NOT B;

    -- Se suma 1 para obtener el complemento a 2
    C(0) <= '1';

    -- Arreglo de Full Adders para realizar la suma
    gen_full_adders : FOR i IN 0 TO N_BITS-1 GENERATE
        fa_inst : ENTITY work.FullAdder_Mux2_1
            PORT MAP(
                A    => '0',
                B    => NB(i),
                Cin  => C(i),
                AB   => A2(i),
                Cout => C(i+1)
            );
    END GENERATE;

    -- Selección entre B y su complemento a 2
    gen_output : FOR i IN 0 TO N_BITS-1 GENERATE
        SAL_TMP(i) <= A2(i) WHEN SEL = "010" ELSE B(i);
    END GENERATE;

    -- Conexión de la salida
    SALIDA <= SAL_TMP;

END ARCHITECTURE;