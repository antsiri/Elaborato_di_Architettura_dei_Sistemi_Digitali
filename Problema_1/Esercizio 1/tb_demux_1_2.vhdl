library IEEE;
use IEEE.std_logic_1164.all;

entity tb_demux_12 is
-- Nessuna porta in un testbench.
end tb_demux_12;

architecture behavior of tb_demux_12 is
    -- Dichiarazione del componente da testare
    component demux_12
        port(
            i: in std_logic;
            s: in std_logic;
            u0: out std_logic;
            u1: out std_logic
        );
    end component;

    -- Segnali per collegare il DUT (Design Under Test)
    signal i_tb: std_logic := '0';
    signal s_tb: std_logic := '0';
    signal u0_tb: std_logic;
    signal u1_tb: std_logic;

begin
    -- Istanza del DUT
    uut: demux_12
        port map(
            i => i_tb,
            s => s_tb,
            u0 => u0_tb,
            u1 => u1_tb
        );

    -- Processo di stimolo
    stim_proc: process
    begin
        -- Test 1: i=0, s=0
        i_tb <= '0';
        s_tb <= '0';
        wait for 10 ns;

        -- Test 2: i=1, s=0
        i_tb <= '1';
        s_tb <= '0';
        wait for 10 ns;

        -- Test 3: i=0, s=1
        i_tb <= '0';
        s_tb <= '1';
        wait for 10 ns;

        -- Test 4: i=1, s=1
        i_tb <= '1';
        s_tb <= '1';
        wait for 10 ns;

        -- Fine della simulazione
        wait;
    end process;

end behavior;
