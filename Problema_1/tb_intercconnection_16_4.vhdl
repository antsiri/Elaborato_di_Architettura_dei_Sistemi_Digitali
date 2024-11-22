library IEEE;
use IEEE.std_logic_1164.all;

entity tb_inter_164 is
-- Nessuna porta nel testbench
end tb_inter_164;

architecture behavior of tb_inter_164 is
    -- Component sotto test
    component inter_164 is
        port
        (
            i: in std_logic_vector(0 to 15);
            s: in std_logic_vector(5 downto 0);
            u: out std_logic_vector(0 to 3)
        );
    end component;

    -- Segnali per il testbench
    signal tb_i: std_logic_vector(0 to 15);
    signal tb_s: std_logic_vector(5 downto 0);
    signal tb_u: std_logic_vector(0 to 3);

    -- Variabile per il valore atteso
    signal expected_u: std_logic_vector(0 to 3);

begin
    -- Istanziazione del componente sotto test
    uut: inter_164
        port map (
            i => tb_i,
            s => tb_s,
            u => tb_u
        );

    -- Processo di stimolo e verifica
    stim_proc: process
    begin
        -- Caso 1: Test base
        tb_i <= "0000000000000001"; -- Solo il primo bit è alto
        tb_s <= "000000"; -- Seleziona il primo ingresso
        wait for 10 ns;
        expected_u <= "0001"; -- Aspettiamo che l'uscita del demux corrisponda
        assert tb_u = expected_u
            report "Test fallito: Caso 1"
            severity error;

        -- Caso 2: Cambia selettore
        tb_i <= "0000000000000010"; -- Solo il secondo bit è alto
        tb_s <= "000001"; -- Seleziona il secondo ingresso
        wait for 10 ns;
        expected_u <= "0010"; -- Valore atteso sul demux
        assert tb_u = expected_u
            report "Test fallito: Caso 2"
            severity error;

        -- Caso 3: Cambia ingresso
        tb_i <= "0000000011110000"; -- Cambia valori di ingresso
        tb_s <= "000011"; -- Seleziona il terzo ingresso
        wait for 10 ns;
        expected_u <= "1000"; -- Valore atteso sul demux
        assert tb_u = expected_u
            report "Test fallito: Caso 3"
            severity error;

        -- Caso 4: Cambia ulteriormente il selettore
        tb_i <= "1111000000000000"; -- Cambia ingresso
        tb_s <= "100000"; -- Seleziona un altro ingresso
        wait for 10 ns;
        expected_u <= "1000"; -- Valore atteso sul demux
        assert tb_u = expected_u
            report "Test fallito: Caso 4"
            severity error;

        -- Fine del test
        report "Tutti i test sono passati con successo!" severity note;
        wait;
    end process;

end behavior;
