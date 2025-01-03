library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROMplusM_tb is
-- Un testbench non ha porte, è un'entità vuota.
end ROMplusM_tb;

architecture behavior of ROMplusM_tb is

    -- Component declaration for the unit under test (UUT)
    component ROMplusM
        Port (
            A: in std_logic_vector(3 downto 0);
            bout: out std_logic_vector(3 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal A_tb: std_logic_vector(3 downto 0) := (others => '0'); -- Ingresso inizializzato a 0
    signal bout_tb: std_logic_vector(3 downto 0); -- Uscita

begin

    -- Instantiation of the UUT (Unit Under Test)
    uut: ROMplusM
        Port map (
            A => A_tb,
            bout => bout_tb
        );

    -- Stimulus process to provide inputs and check outputs
    stimulus_process: process
    begin
        -- Test 1: Indirizzo A = 0
        A_tb <= "0000";
        wait for 10 ns;
        
        -- Test 2: Indirizzo A = 1
        A_tb <= "0001";
        wait for 10 ns;
        
        -- Test 3: Indirizzo A = 2
        A_tb <= "0010";
        wait for 10 ns;
        
         -- Test 4: Indirizzo A = 3
        A_tb <= "0011";
        wait for 10 ns;
        
         -- Test 5: Indirizzo A = 5
        A_tb <= "0101";
        wait for 10 ns;
        
         -- Test 6: Indirizzo A = 7
        A_tb <= "0111";
        wait for 10 ns;
        
         -- Test 7: Indirizzo A = 10
        A_tb <= "1010";
        wait for 10 ns;
        
        -- Test 8: Indirizzo A = 255
        A_tb <= "1111";
        wait for 10 ns;

        -- Fine simulazione
        wait;
    end process;

end behavior;
