library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- Libreria necessaria per `to_unsigned`

entity tb_mux_161 is
end tb_mux_161;

architecture behavior of tb_mux_161 is
    -- Component declaration
    component mux_161
        port (
            i: in std_logic_vector(0 to 15);
            s: in std_logic_vector(3 downto 0);
            u: out std_logic
        );
    end component;

    -- Signals for testing
    signal i: std_logic_vector(0 to 15);
    signal s: std_logic_vector(3 downto 0);
    signal u: std_logic;

begin
    -- Instantiate the unit under test (UUT)
    uut: mux_161
        port map (
            i => i,
            s => s,
            u => u
        );

    -- Test process
    stim_proc: process
        variable expected_output: std_logic; -- Variabile per il controllo
    begin
        -- Initialize inputs
        i <= (others => '0');
        s <= "0000";
        wait for 10 ns;

        -- Apply test cases
        for sel in 0 to 15 loop
            -- Set the ith bit of i to '1'
            i <= (others => '0');
            i(sel) <= '1';

            -- Set the selector
            s <= std_logic_vector(to_unsigned(sel, 4));

            -- Aspetta che l'uscita si stabilizzi
            wait for 10 ns;

            -- Calcola l'uscita attesa
            expected_output := i(sel);

            -- Controlla se l'uscita è corretta
            if u = expected_output then
                report "Test passed for s = " & integer'image(sel) &
                       ", u = " & std_logic'image(u);
            else
                report "Test failed for s = " & integer'image(sel) &
                       ": expected = " & std_logic'image(expected_output) &
                       ", got = " & std_logic'image(u)
                       severity error;
            end if;
        end loop;

        -- Fine simulazione
        report "All tests completed";
        wait;
    end process;

end behavior;
