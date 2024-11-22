library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Libreria necessaria per to_unsigned e to_integer

entity tb_mux_41 is
-- Nessuna porta, è solo per simulazione.
end tb_mux_41;

architecture behavior of tb_mux_41 is
    -- Component da testare
    component mux_41 is
        port (
            b: in std_logic_vector(0 to 3);
            c1: in std_logic_vector(1 downto 0);
            f: out std_logic
        );
    end component;

    -- Segnali per il test
    signal b: std_logic_vector(0 to 3);
    signal c1: std_logic_vector(1 downto 0);
    signal f: std_logic;

begin
    -- Instanziazione del DUT (Device Under Test)
    uut: mux_41
        port map (
            b => b,
            c1 => c1,
            f => f
        );

    -- Processo per il test
    stimulus: process
    begin
        -- Test ogni combinazione di b e c1
        for i in 0 to 15 loop
            b <= std_logic_vector(to_unsigned(i, 4)); -- Assegna i valori binari a b
            for sel in 0 to 3 loop
                c1 <= std_logic_vector(to_unsigned(sel, 2)); -- Seleziona uno dei 4 ingressi
                wait for 10 ns;

                -- Controlla l'uscita attesa
                assert (f = b(to_integer(unsigned(c1))))
                report "Test failed for b=" & integer'image(i) & " c1=" & integer'image(sel)
                severity error;
            end loop;
        end loop;

        -- Fine del test
        report "All test cases passed successfully!" severity note;
        wait;
    end process;
end behavior;
