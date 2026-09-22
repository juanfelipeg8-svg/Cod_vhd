LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Módulo para realizar suma o resta de dos números de 4 bits
ENTITY Add_Sustr IS
    PORT(
        SW   : IN  STD_LOGIC;
        A    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        S    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cout : OUT STD_LOGIC
    );
END ENTITY Add_Sustr;

ARCHITECTURE functional OF Add_Sustr IS
        SIGNAL D    : STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL C    : STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL Cin  : STD_LOGIC;
        SIGNAL Bsel : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
        -- Se obtiene el complemento a 1 de B
        D <= NOT B;

        -- SW selecciona B para sumar o su complemento para restar
        Bsel <= B WHEN (SW = '1') ELSE
                D;

        -- Define el acarreo inicial según la operación
        Cin <= NOT SW;

        -- Sumador del bit menos significativo
        M: ENTITY work.FullAdder_Mux2_1
            PORT MAP(
                A    => A(0),
                B    => Bsel(0),
                Cin  => Cin,
                AB   => S(0),
                Cout => C(0));

        -- Sumador del segundo bit
        N: ENTITY work.FullAdder_Mux2_1
            PORT MAP(
                A    => A(1),
                B    => Bsel(1),
                Cin  => C(0),
                AB   => S(1),
                Cout => C(1));

        -- Sumador del tercer bit
        O: ENTITY work.FullAdder_Mux2_1
            PORT MAP(
                A    => A(2),
                B    => Bsel(2),
                Cin  => C(1),
                AB   => S(2),
                Cout => C(2));

        -- Sumador del bit más significativo
        P: ENTITY work.FullAdder_Mux2_1
            PORT MAP(
                A    => A(3),
                B    => Bsel(3),
                Cin  => C(2),
                AB   => S(3),
                Cout => C(3));

        -- Acarreo final de la operación
        Cout <= C(3);

END ARCHITECTURE functional;