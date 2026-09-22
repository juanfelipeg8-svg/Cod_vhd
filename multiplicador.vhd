LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multiplicador IS
    PORT (
        A, B : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        P    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE structural OF multiplicador IS
    SIGNAL pp0, pp1, pp2, pp3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL row0, row1, row2, row3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL sum1, sum2, sum3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL c1, c2, c3 : STD_LOGIC;
BEGIN
    g_pp0: FOR i IN 0 TO 3 GENERATE
        pp0(i) <= A(i) AND B(0);
    END GENERATE;

    g_pp1: FOR i IN 0 TO 3 GENERATE
        pp1(i) <= A(i) AND B(1);
    END GENERATE;

    g_pp2: FOR i IN 0 TO 3 GENERATE
        pp2(i) <= A(i) AND B(2);
    END GENERATE;

    g_pp3: FOR i IN 0 TO 3 GENERATE
        pp3(i) <= A(i) AND B(3);
    END GENERATE;

    row0 <= "000" & pp0;
    row1 <= "00" & pp1 & '0';
    row2 <= "0" & pp2 & "00";
    row3 <= pp3 & "000";

    FA1: ENTITY work.full_adder
        GENERIC MAP(n_bits => 7)
        PORT MAP(
            A_SUM => row0,
            B_SUM => row1,
            C_SUM => '0',
            S_SUM => sum1,
            C_OUT => c1
        );

    FA2: ENTITY work.full_adder
        GENERIC MAP(n_bits => 7)
        PORT MAP(
            A_SUM => sum1,
            B_SUM => row2,
            C_SUM => '0',
            S_SUM => sum2,
            C_OUT => c2
        );

    FA3: ENTITY work.full_adder
        GENERIC MAP(n_bits => 7)
        PORT MAP(
            A_SUM => sum2,
            B_SUM => row3,
            C_SUM => '0',
            S_SUM => sum3,
            C_OUT => c3
        );

    P <= sum3;
END ARCHITECTURE;