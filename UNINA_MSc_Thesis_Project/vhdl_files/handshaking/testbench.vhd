library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_AplusB is
    -- Nessuna porta, e' un testbench
end tb_AplusB;

architecture Behavioral of tb_AplusB is
    -- Component instanziato
    component AplusB
        Port (
            CLK_A, CLK_B, RST: in STD_LOGIC;
            START: in STD_LOGIC;
            X: out STD_LOGIC_VECTOR(7 downto 0);
            Y: out STD_LOGIC_VECTOR(7 downto 0);
            result: out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Segnali interni del testbench
    signal CLK_A, CLK_B, RST, START: STD_LOGIC := '0';
    signal X, Y, result: STD_LOGIC_VECTOR(7 downto 0);

    -- Parametri per clock
    constant CLK_PERIOD_A: time := 10 ns; -- Periodo del clock A
    constant CLK_PERIOD_B: time := 10 ns; -- Periodo del clock B
begin
    -- Instanza del DUT (Device Under Test)
    DUT: AplusB
        Port map(
            CLK_A => CLK_A,
            CLK_B => CLK_B,
            RST => RST,
            START => START,
            X => X,
            Y => Y,
            result => result
        );

    -- Generazione del clock A
    process
    begin
        CLK_A <= '0';
        wait for CLK_PERIOD_A / 2;
        CLK_A <= '1';
        wait for CLK_PERIOD_A / 2;
    end process;

    -- Generazione del clock B
    process
    begin
        CLK_B <= '0';
        wait for CLK_PERIOD_B / 2;
        CLK_B <= '1';
        wait for CLK_PERIOD_B / 2;
    end process;

    -- Processo di stimolo
    process
    begin
        -- Reset iniziale
        RST <= '1';
        START <= '0';
        wait for 50 ns; -- Attesa per stabilizzare il reset
        RST <= '0';
        wait for 50 ns;

        -- Avvio della somma
        START <= '1';
        wait for 20 ns;
        START <= '0'; -- Disattiva il segnale START

        -- Attendi un po' per consentire al protocollo di completarsi
        wait for 200 ns;

        -- Termina la simulazione
        wait;
    end process;

end Behavioral;
