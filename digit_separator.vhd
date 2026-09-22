LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY digit_separator IS
    PORT (
        N        : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
        DECENAS  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        UNIDADES : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE STRUCTURAL OF digit_separator IS

    -- señales de restos y carries
    SIGNAL r70, r40, r20, r10, r7, r4, r2, r1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL c70, c40, c20, c10, c7, c4, c2, c1 : STD_LOGIC;
    SIGNAL s40, s20, s10, s7, s4, s2, s1     : STD_LOGIC_VECTOR(6 DOWNTO 0);

    -- señales intermedias para sumadores de decenas y unidades
    SIGNAL d_sum0, d_sum1, d_sum2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL u_sum0, u_sum1, u_sum2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL bD_sum0, bD_sum1, bD_sum2, bD_sum3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL bU_sum0, bU_sum1, bU_sum2, bU_sum3 : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

  
    -- Resta N - 70

    FA70: ENTITY work.full_adder
        GENERIC MAP (n_bits => 7)
        PORT MAP (
            A_SUM => N,
            B_SUM => "0111001",  
            C_SUM => '1',
            S_SUM => r70,
            C_OUT => c70
        );

    s40 <= r70 WHEN c70='1' ELSE N;

    -- Resta N - 40

    FA40: ENTITY work.full_adder
        GENERIC MAP (n_bits => 7)
        PORT MAP (
            A_SUM => s40,
            B_SUM => "1010111",  
            C_SUM => '1',
            S_SUM => r40,
            C_OUT => c40
        );

    s20 <= r40 WHEN c40='1' ELSE s40;


    -- Resta N - 20

    FA20: ENTITY work.full_adder
        GENERIC MAP (n_bits => 7)
        PORT MAP (
            A_SUM => s20,
            B_SUM => "1101011",
            C_SUM => '1',
            S_SUM => r20,
            C_OUT => c20
        );

    s10 <= r20 WHEN c20='1' ELSE s20;


    -- Resta - 10
 
    FA10: ENTITY work.full_adder
        GENERIC MAP (n_bits => 7)
        PORT MAP (
            A_SUM => s10,
            B_SUM => "1110101",
            C_SUM => '1',
            S_SUM => r10,
            C_OUT => c10
        );

    s7 <= r10 WHEN c10='1' ELSE s10;


    -- Resta - 7

    FA7: ENTITY work.full_adder
        GENERIC MAP (n_bits => 7)
        PORT MAP (
            A_SUM => s7,
            B_SUM => "1111000",  -- -7
            C_SUM => '1',
            S_SUM => r7,
            C_OUT => c7
        );

    s4 <= r7 WHEN c7='1' ELSE s7;


    -- Resta  - 4
   
    FA4: ENTITY work.full_adder
        GENERIC MAP (n_bits => 7)
        PORT MAP (
            A_SUM => s4,
            B_SUM => "1111011",  -- -4
            C_SUM => '1',
            S_SUM => r4,
            C_OUT => c4
        );

    s2 <= r4 WHEN c4='1' ELSE s4;

  
    -- Resta  - 2
 
    FA2: ENTITY work.full_adder
        GENERIC MAP (n_bits => 7)
        PORT MAP (
            A_SUM => s2,
            B_SUM => "1111101",  -- -2
            C_SUM => '1',
            S_SUM => r2,
            C_OUT => c2
        );

    s1 <= r2 WHEN c2='1' ELSE s2;

    -- Resta  - 1

    FA1: ENTITY work.full_adder
        GENERIC MAP (n_bits => 7)
        PORT MAP (
            A_SUM => s1,
            B_SUM => "1111110",  -- -1
            C_SUM => '1',
            S_SUM => r1,
            C_OUT => c1
        );


	--mondaa por la que modelsim molesta, pero aqui no
  
    bD_sum0 <= (c70 & c70 & c70 & c70) AND "0111";
    bD_sum1 <= (c40 & c40 & c40 & c40) AND "0100";
    bD_sum2 <= (c20 & c20 & c20 & c20) AND "0010";
    bD_sum3 <= (c10 & c10 & c10 & c10) AND "0001";
	 
    -- Decenas
    D0: ENTITY work.full_adder
        GENERIC MAP (n_bits => 4)
        PORT MAP (
            A_SUM => "0000",
            B_SUM => bD_sum0,
            C_SUM => '0',
            S_SUM => d_sum0,
            C_OUT => OPEN
        );

    D1: ENTITY work.full_adder
        GENERIC MAP (n_bits => 4)
        PORT MAP (
            A_SUM => d_sum0,
            B_SUM => bD_sum1,
            C_SUM => '0',
            S_SUM => d_sum1,
            C_OUT => OPEN
        );

    D2: ENTITY work.full_adder
        GENERIC MAP (n_bits => 4)
        PORT MAP (
            A_SUM => d_sum1,
            B_SUM => bD_sum2,
            C_SUM => '0',
            S_SUM => d_sum2,
            C_OUT => OPEN
        );

    D3: ENTITY work.full_adder
        GENERIC MAP (n_bits => 4)
        PORT MAP (
            A_SUM => d_sum2,
            B_SUM => bD_sum3,
            C_SUM => '0',
            S_SUM => DECENAS,
            C_OUT => OPEN
        );


 --la misma mondaa pero en las unidades xD   

    bU_sum0 <= (c7 & c7 & c7 & c7) AND "0111";
    bU_sum1 <= (c4 & c4 & c4 & c4) AND "0100";
    bU_sum2 <= (c2 & c2 & c2 & c2) AND "0010";
    bU_sum3 <= (c1 & c1 & c1 & c1) AND "0001";
	 
 -- Unidades
    U0: ENTITY work.full_adder
        GENERIC MAP (n_bits => 4)
        PORT MAP (
            A_SUM => "0000",
            B_SUM => bU_sum0,
            C_SUM => '0',
            S_SUM => u_sum0,
            C_OUT => OPEN
        );

    U1: ENTITY work.full_adder
        GENERIC MAP (n_bits => 4)
        PORT MAP (
            A_SUM => u_sum0,
            B_SUM => bU_sum1,
            C_SUM => '0',
            S_SUM => u_sum1,
            C_OUT => OPEN
        );

    U2: ENTITY work.full_adder
        GENERIC MAP (n_bits => 4)
        PORT MAP (
            A_SUM => u_sum1,
            B_SUM => bU_sum2,
            C_SUM => '0',
            S_SUM => u_sum2,
            C_OUT => OPEN
        );

    U3: ENTITY work.full_adder
        GENERIC MAP (n_bits => 4)
        PORT MAP (
            A_SUM => u_sum2,
            B_SUM => bU_sum3,
            C_SUM => '0',
            S_SUM => UNIDADES,
            C_OUT => OPEN
        );

END ARCHITECTURE STRUCTURAL;