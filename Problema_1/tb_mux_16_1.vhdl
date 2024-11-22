library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Necessaria per conversioni tra intero e std_logic_vector

entity tb_mux_161 is
-- Nessuna porta, è solo per simulazione.
end tb_mux_161;

architecture behavior of tb_mux_161 is
    -- Component da testare
    component mux_161 is
        port (
            x: in std_logic_vector(0 to 15);
            c: in std_logic_vector(3 downto 0);
            u: out std_logic
        );
    end component;

    -- Segnali per il test
    signal x: std_logic_vector(0 to 15);
    signal c: std_logic_vector(3 downto 0);
    signal u: std_logic;

begin
    -- Instanziazione del DUT (Device Under Test)
    uut: mux_161
        port map (
            x => x,
            c => c,
            u => u
        );

    -- Processo per il test
    stimulus: process
    begin
        -- Test ogni combinazione di x e c
        for i in 0 to 65535 loop -- Tutte le combinazioni per x (16 bit)
            x <= std_logic_vector(to_unsigned(i, 16));
            for sel in 0 to 15 loop -- Tutte le combinazioni per c (4 bit)
                c <= std_logic_vector(to_unsigned(sel, 4)); -- Imposta il selettore
                wait for 10 ns;

                -- Controlla l'uscita attesa
                assert (u = x(to_integer(unsigned(c))))
                report "Test failed for x=" & integer'image(i) & " c=" & integer'image(sel)
                severity error;
            end loop;
        end loop;

        -- Fine del test
        report "All test cases passed successfully!" severity note;
        wait;
    end process;
end behavior;
