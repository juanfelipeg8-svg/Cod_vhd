LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Main_p IS
    PORT (
        A, B   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        SW     : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);

        -- Boton "="
        EQ_BTN : IN  STD_LOGIC;

        Seg0   : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        Seg1   : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        Seg2   : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        Seg3   : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END ENTITY;


ARCHITECTURE structural OF Main_p IS

    ------------------------------------------------------------
    -- Señales de la calculadora original
    ------------------------------------------------------------

    SIGNAL A_S       : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL B_S       : STD_LOGIC_VECTOR(4 DOWNTO 0);

    SIGNAL C_mul     : STD_LOGIC_VECTOR(6 DOWNTO 0);

    SIGNAL B_comp    : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL B_comp2   : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL B_aos     : STD_LOGIC_VECTOR(4 DOWNTO 0);

    SIGNAL Addr      : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL Addc      : STD_LOGIC;

    SIGNAL COM_A     : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL COO       : STD_LOGIC_VECTOR(6 DOWNTO 0);

    -- Resultado combinacional actual
    SIGNAL C_fin     : STD_LOGIC_VECTOR(6 DOWNTO 0);

    SIGNAL IS_SUB    : STD_LOGIC;
    SIGNAL IS_MUL    : STD_LOGIC;
    SIGNAL NEG_RES   : STD_LOGIC;


    ------------------------------------------------------------
    -- NUEVO:
    -- Resultado almacenado al presionar "="
    ------------------------------------------------------------

    SIGNAL C_REG     : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL NEG_REG   : STD_LOGIC;

    -- Indica si ya se ha pulsado "=" por primera vez
    SIGNAL RESULT_VALID : STD_LOGIC;


    ------------------------------------------------------------
    -- Separación decimal del resultado REGISTRADO
    ------------------------------------------------------------

    SIGNAL Div_dos   : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Div_U     : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL C_sign    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Div_d     : STD_LOGIC_VECTOR(3 DOWNTO 0);


    ------------------------------------------------------------
    -- Señales internas de displays
    ------------------------------------------------------------

    SIGNAL Seg2_INT  : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL Seg3_INT  : STD_LOGIC_VECTOR(6 DOWNTO 0);


BEGIN

    ------------------------------------------------------------
    -- EXTENSION DE A Y B
    ------------------------------------------------------------

    A_S <= '0' & A;
    B_S <= '0' & B;


    ------------------------------------------------------------
    -- DECODIFICACION DE OPERACION
    ------------------------------------------------------------

    IS_SUB <= '1' WHEN SW = "01" ELSE '0';
    IS_MUL <= '1' WHEN SW = "10" ELSE '0';


    ------------------------------------------------------------
    -- DETECCION DE RESULTADO NEGATIVO
    ------------------------------------------------------------

    NEG_RES <= '1'
        WHEN (IS_SUB = '1' AND Addc = '0')
        ELSE '0';


    ------------------------------------------------------------
    -- CONTROL DE COMPLEMENTO A 2
    ------------------------------------------------------------

    COM_A <= "010"
        WHEN NEG_RES = '1'
        ELSE "000";


    ------------------------------------------------------------
    -- RESULTADO DE MULTIPLICACION
    ------------------------------------------------------------

    Mul: ENTITY WORK.multiplicador
        PORT MAP (
            A => A,
            B => B,
            P => C_mul
        );


    ------------------------------------------------------------
    -- COMPLEMENTO A 2 DE B PARA LA RESTA
    ------------------------------------------------------------

    A2: ENTITY WORK.Complemento_A2
        GENERIC MAP (
            bits => 5
        )
        PORT MAP (
            B      => B_S,
            SEL    => "010",
            SALIDA => B_comp
        );


    ------------------------------------------------------------
    -- SELECCION ENTRE B Y -B
    ------------------------------------------------------------

    M2_1: ENTITY WORK.mux2_1
        PORT MAP (
            A  => B_S,
            B  => B_comp,
            SW => IS_SUB,
            Y  => B_aos
        );


    ------------------------------------------------------------
    -- SUMA / RESTA
    ------------------------------------------------------------

    Sum: ENTITY WORK.full_adder
        GENERIC MAP (
            n_bits => 5
        )
        PORT MAP (
            A_SUM => A_S,
            B_SUM => B_aos,
            C_SUM => '0',
            S_SUM => Addr,
            C_OUT => Addc
        );


    ------------------------------------------------------------
    -- SI LA RESTA ES NEGATIVA:
    -- CONVERTIR EL RESULTADO A MAGNITUD POSITIVA
    ------------------------------------------------------------

    A2_2: ENTITY WORK.Complemento_A2
        GENERIC MAP (
            bits => 5
        )
        PORT MAP (
            B      => Addr,
            SEL    => COM_A,
            SALIDA => B_comp2
        );


    ------------------------------------------------------------
    -- EXTENDER RESULTADO SUMA/RESTA A 7 BITS
    ------------------------------------------------------------

    COO <= "00" & B_comp2;


    ------------------------------------------------------------
    -- SELECCIONAR RESULTADO:
    -- SUMA/RESTA O MULTIPLICACION
    ------------------------------------------------------------

    Mux_op: ENTITY WORK.operacion_demux_when_else
        PORT MAP (
            Add => COO,
            Mul => C_mul,
            S   => IS_MUL,
            Res => C_fin
        );


    ------------------------------------------------------------
    -- NUEVO: REGISTRO DEL RESULTADO
    --
    -- Los 7 bits de C_fin quedan guardados solamente
    -- cuando se presiona EQ_BTN.
    ------------------------------------------------------------

    GEN_RESULT_FF:
    FOR i IN 0 TO 6 GENERATE

        FF_RESULT: ENTITY WORK.FF_D
            PORT MAP (
                D   => C_fin(i),
                CLK => EQ_BTN,
                Q   => C_REG(i)
            );

    END GENERATE GEN_RESULT_FF;


    ------------------------------------------------------------
    -- NUEVO:
    -- GUARDAR TAMBIEN SI EL RESULTADO ERA NEGATIVO
    ------------------------------------------------------------

    FF_SIGN: ENTITY WORK.FF_D
        PORT MAP (
            D   => NEG_RES,
            CLK => EQ_BTN,
            Q   => NEG_REG
        );


    ------------------------------------------------------------
    -- NUEVO:
    -- FLIP-FLOP QUE INDICA QUE YA SE PRESIONO "="
    --
    -- Antes de la primera pulsacion:
    -- RESULT_VALID = 0
    --
    -- Después:
    -- RESULT_VALID = 1
    ------------------------------------------------------------

    FF_VALID: ENTITY WORK.FF_D
        PORT MAP (
            D   => '1',
            CLK => EQ_BTN,
            Q   => RESULT_VALID
        );


    ------------------------------------------------------------
    -- A PARTIR DE AQUI SE USA C_REG, NO C_fin
    --
    -- Esto es lo que hace que el resultado quede congelado.
    ------------------------------------------------------------

    Sep_dig: ENTITY WORK.digit_separator
        PORT MAP (
            N        => C_REG,
            DECENAS  => Div_dos,
            UNIDADES => Div_U
        );


    ------------------------------------------------------------
    -- SIGNO NEGATIVO REGISTRADO
    ------------------------------------------------------------

    C_sign <= "1010"
        WHEN NEG_REG = '1'
        ELSE "0000";


    ------------------------------------------------------------
    -- SI ES NEGATIVO MOSTRAR "-"
    -- SI NO, MOSTRAR DECENA
    ------------------------------------------------------------

    Div_d <= C_sign
        WHEN NEG_REG = '1'
        ELSE Div_dos;


    ------------------------------------------------------------
    -- DECODIFICADOR DE 7 SEGMENTOS
    --
    -- A y B siguen mostrandose normalmente.
    -- El resultado viene de los flip-flops.
    ------------------------------------------------------------

    Sseg: ENTITY WORK.Result_to_Sseg
        PORT MAP (
            A    => A,
            B    => B,
            V_S  => Div_d,
            V_R  => Div_U,

            Seg0 => Seg0,
            Seg1 => Seg1,

            Seg2 => Seg2_INT,
            Seg3 => Seg3_INT
        );


    ------------------------------------------------------------
    -- ANTES DE PRESIONAR "=":
    -- APAGAR LOS DOS DISPLAYS DEL RESULTADO
    --
    -- Los 7 segmentos de la DE0 son activos en bajo:
    -- 1111111 = display apagado.
    ------------------------------------------------------------

    Seg2 <= Seg2_INT
        WHEN RESULT_VALID = '1'
        ELSE "1111111";

    Seg3 <= Seg3_INT
        WHEN RESULT_VALID = '1'
        ELSE "1111111";


END ARCHITECTURE structural;
