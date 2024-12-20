library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux_41 is
end entity;

architecture behavior of tb_mux_41 is
    -- Dichiarazione dei segnali per il testbench
    signal i : std_logic_vector(0 to 3);
    signal y : std_logic_vector(1 downto 0);
    signal output : std_logic;

    -- Istanza del MUX
    component mux_41
        port (
            i : in std_logic_vector(0 to 3);
            y : in std_logic_vector(1 downto 0);
            output : out std_logic
        );
    end component;

begin
    -- Istanza del MUX nel testbench
    uut: mux_41
        port map (
            i => i,
            y => y,
            output => output
        );

    -- Stimolo per il test
    stim_proc: process
    begin
        -- Test caso per ogni combinazione dei selettori y
        i <= "0001"; y <= "00"; -- output deve essere i(0) = '0'
        wait for 10 ns;

        i <= "0001"; y <= "01"; -- output deve essere i(1) = '0'
        wait for 10 ns;

        i <= "0001"; y <= "10"; -- output deve essere i(2) = '0'
        wait for 10 ns;

        i <= "0001"; y <= "11"; -- output deve essere i(3) = '1'
        wait for 10 ns;

        -- Test con valori diversi di i
        i <= "1101"; y <= "00"; -- output deve essere i(0) = '1'
        wait for 10 ns;

        i <= "1101"; y <= "01"; -- output deve essere i(1) = '1'
        wait for 10 ns;

        i <= "1101"; y <= "10"; -- output deve essere i(2) = '0'
        wait for 10 ns;

        i <= "1101"; y <= "11"; -- output deve essere i(3) = '1'
        wait for 10 ns;

        -- Test con valori invalidi
        i <= "1010"; y <= "ZZ"; -- output deve essere '-'
        wait for 10 ns;

        -- Finiti i test
        wait;
    end process;
end architecture;
