LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY full_adder IS
    GENERIC (
        n_bits : INTEGER := 5
    );
    PORT (
        A_SUM, B_SUM : IN  STD_LOGIC_VECTOR(n_bits - 1 DOWNTO 0);
        C_SUM        : IN  STD_LOGIC;
        S_SUM        : OUT STD_LOGIC_VECTOR(n_bits - 1 DOWNTO 0);
        C_OUT        : OUT STD_LOGIC
    );
END ENTITY full_adder;

ARCHITECTURE structural OF full_adder IS
    SIGNAL carry : STD_LOGIC_VECTOR(n_bits DOWNTO 0);
BEGIN
    carry(0) <= C_SUM;

    gen_full_adders : FOR i IN 0 TO n_bits - 1 GENERATE
        fa_inst : ENTITY work.sumador
            PORT MAP (
                A    => A_SUM(i),
                B    => B_SUM(i),
                Cin  => carry(i),
                S    => S_SUM(i),
                Cout => carry(i + 1)
            );
    END GENERATE;

    C_OUT <= carry(n_bits);
END ARCHITECTURE structural;