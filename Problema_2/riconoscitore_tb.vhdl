library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  -- Libreria per std_logic

entity tb_riconoscitore is
end tb_riconoscitore;

architecture behavior of tb_riconoscitore is

    -- Dichiarazione dei segnali per il testbench
    signal i    : std_logic := '0';  -- ingresso del dato
    signal A    : std_logic := '0';  -- segnale di temporizzazione (clock)
    signal M    : std_logic := '0';  -- segnale di modalità
    signal Y    : std_logic;         -- uscita (output)

    -- Istanza della macchina riconoscitrice
    component riconoscitore
        port (
            i : in std_logic;
            A : in std_logic;
            M : in std_logic;
            Y : out std_logic
        );
    end component;

begin

    -- Istanza della macchina riconoscitrice
    uut: riconoscitore
        port map (
            i => i,
            A => A,
            M => M,
            Y => Y
        );

    -- Generatore di clock (per il segnale A)
    clock_process: process
    begin
        A <= '0';
        wait for 10 ns;
        A <= '1';
        wait for 10 ns;
    end process;

    -- Processo di stimolo
    stimulus: process
    begin
        -- Test 1: Modalità M=0, sequenza 101 in gruppi di 3
        M <= '0';
        -- Gruppo 1: 101
        i <= '1'; wait for 20 ns;
        i <= '0'; wait for 20 ns;
        i <= '1'; wait for 20 ns;
        -- La sequenza 101 dovrebbe essere riconosciuta
        wait for 40 ns;

        -- Test 2: Modalità M=1, sequenza sovrapposta 101
        M <= '1';
        -- Primo 101
        i <= '1'; wait for 20 ns;
        i <= '0'; wait for 20 ns;
        i <= '1'; wait for 20 ns;
        -- Secondo 101 sovrapposto
        i <= '1'; wait for 20 ns;
        i <= '0'; wait for 20 ns;
        i <= '1'; wait for 20 ns;
        -- Terzo 101 sovrapposto
        i <= '1'; wait for 20 ns;
        i <= '0'; wait for 20 ns;
        i <= '1'; wait for 20 ns;
        
        -- Test 3: Sequenza senza riconoscimento
        M <= '0';
        i <= '1'; wait for 20 ns;
        i <= '0'; wait for 20 ns;
        i <= '0'; wait for 20 ns;  -- Sequenza non valida, nessun riconoscimento

        -- Test 4: Sequenza 101 in modalità M=1 (sovrapposizione)
        M <= '1';
        i <= '1'; wait for 20 ns;
        i <= '0'; wait for 20 ns;
        i <= '1'; wait for 20 ns;
        -- La sequenza 101 viene riconosciuta e il sistema torna allo stato iniziale
        -- Continua a testare sequenze sovrapposte come nel caso precedente
        i <= '1'; wait for 20 ns;
        i <= '0'; wait for 20 ns;
        i <= '1'; wait for 20 ns;

        -- Terminare la simulazione
        wait;
    end process;

end behavior;
