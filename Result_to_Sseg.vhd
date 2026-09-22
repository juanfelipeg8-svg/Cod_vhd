LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Result_to_Sseg IS
    PORT(
        A    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        V_S  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        V_R  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Seg0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        Seg1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        Seg2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        Seg3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END ENTITY Result_to_Sseg;

ARCHITECTURE behaviour OF Result_to_Sseg IS
BEGIN
    WITH A SELECT
    Seg0 <= "1000000" WHEN "0000",
            "1111001" WHEN "0001",
            "0100100" WHEN "0010",
            "0110000" WHEN "0011",
            "0011001" WHEN "0100",
            "0010010" WHEN "0101",
            "0000010" WHEN "0110",
            "1111000" WHEN "0111",
            "0000000" WHEN "1000",
            "0010000" WHEN "1001",
            "0000110" WHEN OTHERS; -- E

    WITH B SELECT
    Seg1 <= "1000000" WHEN "0000",
            "1111001" WHEN "0001",
            "0100100" WHEN "0010",
            "0110000" WHEN "0011",
            "0011001" WHEN "0100",
            "0010010" WHEN "0101",
            "0000010" WHEN "0110",
            "1111000" WHEN "0111",
            "0000000" WHEN "1000",
            "0010000" WHEN "1001",
            "0000110" WHEN OTHERS; -- E

    WITH V_S SELECT
    Seg2 <= "1000000" WHEN "0000",
            "1111001" WHEN "0001",
            "0100100" WHEN "0010",
            "0110000" WHEN "0011",
            "0011001" WHEN "0100",
            "0010010" WHEN "0101",
            "0000010" WHEN "0110",
            "1111000" WHEN "0111",
            "0000000" WHEN "1000",
            "0010000" WHEN "1001",
            "0111111" WHEN "1010", -- signo menos
            "0000110" WHEN OTHERS; -- E

    WITH V_R SELECT
    Seg3 <= "1000000" WHEN "0000",
            "1111001" WHEN "0001",
            "0100100" WHEN "0010",
            "0110000" WHEN "0011",
            "0011001" WHEN "0100",
            "0010010" WHEN "0101",
            "0000010" WHEN "0110",
            "1111000" WHEN "0111",
            "0000000" WHEN "1000",
            "0010000" WHEN "1001",
            "0000110" WHEN OTHERS; -- E
END behaviour;