library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux_21 is
-- Nessuna porta, è solo per simulazione.
end tb_mux_21;

architecture behavior of tb_mux_21 is
    -- Component da testare
    component mux_21 is
        port (
            a0, a1: in std_logic;
            c0: in std_logic;
            z: out std_logic
        );
    end component;

    -- Segnali per il test
    signal a0, a1, c0, z: std_logic;

begin
    -- Instanziazione del DUT (Device Under Test)
    uut: mux_21
        port map (
            a0 => a0,
            a1 => a1,
            c0 => c0,
            z  => z
        );

    -- Processo per il test
    stimulus: process
    begin
        -- Test Case 1: c0 = '0', a0 = '0', a1 = '0'
        a0 <= '0';
        a1 <= '0';
        c0 <= '0';
        wait for 10 ns;
        assert (z = '0') report "Test Case 1 failed" severity error;

        -- Test Case 2: c0 = '0', a0 = '1', a1 = '0'
        a0 <= '1';
        a1 <= '0';
        c0 <= '0';
        wait for 10 ns;
        assert (z = '1') report "Test Case 2 failed" severity error;

        -- Test Case 3: c0 = '1', a0 = '0', a1 = '0'
        a0 <= '0';
        a1 <= '0';
        c0 <= '1';
        wait for 10 ns;
        assert (z = '0') report "Test Case 3 failed" severity error;

        -- Test Case 4: c0 = '1', a0 = '0', a1 = '1'
        a0 <= '0';
        a1 <= '1';
        c0 <= '1';
        wait for 10 ns;
        assert (z = '1') report "Test Case 4 failed" severity error;

        -- Test Case 5: c0 = '0', a0 = '1', a1 = '1'
        a0 <= '1';
        a1 <= '1';
        c0 <= '0';
        wait for 10 ns;
        assert (z = '1') report "Test Case 5 failed" severity error;

        -- Test Case 6: c0 = '1', a0 = '1', a1 = '1'
        a0 <= '1';
        a1 <= '1';
        c0 <= '1';
        wait for 10 ns;
        assert (z = '1') report "Test Case 6 failed" severity error;

        -- Fine del test
        report "All test cases passed successfully!" severity note;
        wait;
    end process;
end behavior;
