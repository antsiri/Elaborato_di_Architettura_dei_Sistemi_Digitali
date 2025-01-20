library IEEE;
use IEEE.std_logic_1164.all;

entity tb_demux_14 is
-- Nessuna porta necessaria per il testbench
end tb_demux_14;

architecture behavior of tb_demux_14 is

    -- Component da testare
    component demux_14
        port(
            i: in std_logic;
            s: in std_logic_vector(1 downto 0);
            u: out std_logic_vector(0 to 3)
        );
    end component;

    -- Segnali per collegare gli ingressi e le uscite
    signal i_tb: std_logic := '0';
    signal s_tb: std_logic_vector(1 downto 0) := "00";
    signal u_tb: std_logic_vector(0 to 3);

begin
    -- Istanza del DUT (Design Under Test)
    uut: demux_14
        port map(
            i => i_tb,
            s => s_tb,
            u => u_tb
        );

    -- Processo di stimolo
    stim_proc: process
    begin
        -- Test 1: i=0, s="00"
        i_tb <= '0'; s_tb <= "00";
        wait for 10 ns;
        assert u_tb = "0000" report "Test 1 failed: u_tb /= 0000" severity error;

        -- Test 2: i=1, s="00"
        i_tb <= '1'; s_tb <= "00";
        wait for 10 ns;
        assert u_tb = "1000" report "Test 2 failed: u_tb /= 1000" severity error;

        -- Test 3: i=1, s="01"
        i_tb <= '1'; s_tb <= "01";
        wait for 10 ns;
        assert u_tb = "0100" report "Test 3 failed: u_tb /= 0100" severity error;

        -- Test 4: i=1, s="10"
        i_tb <= '1'; s_tb <= "10";
        wait for 10 ns;
        assert u_tb = "0010" report "Test 4 failed: u_tb /= 0010" severity error;

        -- Test 5: i=1, s="11"
        i_tb <= '1'; s_tb <= "11";
        wait for 10 ns;
        assert u_tb = "0001" report "Test 5 failed: u_tb /= 0001" severity error;

        -- Fine della simulazione
        wait;
    end process;

end behavior;
