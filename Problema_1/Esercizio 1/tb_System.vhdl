library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_System is
end tb_System;

architecture Behavioral of tb_System is
    -- Component da testare
    component System
        port (
            addr : in  std_logic_vector(3 downto 0);
            y    : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Segnali per la simulazione
    signal addr : std_logic_vector(3 downto 0) := (others => '0');
    signal y    : std_logic_vector(3 downto 0);

begin
    -- Istanza del DUT (Device Under Test)
    uut: System
        port map (
            addr => addr,
            y    => y
        );

    -- Processo per stimolare il DUT
    stim_proc: process
    begin
        -- Test per tutti i possibili valori di addr
        for i in 0 to 15 loop
            addr <= std_logic_vector(to_unsigned(i, 4)); -- Incrementa l'indirizzo
            wait for 10 ns; -- Aspetta 10 ns per stabilizzare l'output
        end loop;

        -- Fine simulazione
        wait;
    end process;

end Behavioral;
