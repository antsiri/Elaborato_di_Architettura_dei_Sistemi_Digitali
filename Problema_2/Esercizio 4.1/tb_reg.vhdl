library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_reg is
end entity;

architecture behavior of tb_reg is
    -- Dichiarazione dei segnali per il testbench
    signal data_in : std_logic;
    signal en : std_logic;
    signal clk : std_logic;
    signal rst : std_logic;
    signal data_out : std_logic;

    -- Istanza del registro
    component reg
        port (
            data_in : in std_logic;
            en : in std_logic;
            clk : in std_logic;
            rst : in std_logic;
            data_out : out std_logic
        );
    end component;

begin
    -- Istanza del registro nel testbench
    uut: reg
        port map (
            data_in => data_in,
            en => en,
            clk => clk,
            rst => rst,
            data_out => data_out
        );

    -- Generazione del segnale di clock (periodo 10ns)
    clk_process: process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    -- Stimolo per il test
    stim_proc: process
    begin
        -- Inizializzazione
        rst <= '0';
        en <= '0';
        data_in <= '0';
        wait for 20 ns;

        -- Test con reset
        rst <= '1'; -- Attiva il reset
        wait for 10 ns;
        rst <= '0'; -- Disattiva il reset
        wait for 10 ns;

        -- Test con abilitazione disattivata
        en <= '0'; -- Disattiva abilitazione
        data_in <= '1'; -- Modifica input
        wait for 20 ns;
        assert data_out = '0' report "Test failed with data_out = '0'" severity failure;

        -- Test con abilitazione attivata
        en <= '1'; -- Attiva abilitazione
        data_in <= '1'; -- Modifica input
        wait for 20 ns;
        assert data_out = '1' report "Test failed with data_out = '1'" severity failure;

        -- Test con risveglio del clock
        en <= '1'; -- Abilitazione attivata
        data_in <= '0'; -- Modifica input
        wait for 10 ns; -- Dopo un ciclo del clock, data_out deve essere '0'
        assert data_out = '0' report "Test failed with data_out = '0'" severity failure;

        -- Test con reset e abilitazione attivata
        rst <= '1'; -- Attiva il reset
        wait for 10 ns;
        rst <= '0'; -- Disattiva il reset
        data_in <= '1'; -- Modifica input
        wait for 10 ns;
        assert data_out = '1' report "Test failed with data_out = '1'" severity failure;

        -- Test completato
        wait;
    end process;
end architecture;
