library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch_mult_tb is
-- Nessun porto, il testbench non ha interfaccia esterna
end switch_mult_tb;

architecture Behavioral of switch_mult_tb is

    component switch_mult is
        Port (
            en: in STD_LOGIC_VECTOR(3 downto 0);
            in0, in1, in2, in3: in STD_LOGIC_VECTOR(1 downto 0);
            destination_in0: in STD_LOGIC_VECTOR(1 downto 0);
            destination_in1: in STD_LOGIC_VECTOR(1 downto 0);
            destination_in2: in STD_LOGIC_VECTOR(1 downto 0);
            destination_in3: in STD_LOGIC_VECTOR(1 downto 0);
            out0, out1, out2, out3: out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    signal en: STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal in0, in1, in2, in3: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal destination_in0, destination_in1, destination_in2, destination_in3: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal out0, out1, out2, out3: STD_LOGIC_VECTOR(1 downto 0);

begin

    DUT: switch_mult
        port map (
            en => en,
            in0 => in0,
            in1 => in1,
            in2 => in2,
            in3 => in3,
            destination_in0 => destination_in0,
            destination_in1 => destination_in1,
            destination_in2 => destination_in2,
            destination_in3 => destination_in3,
            out0 => out0,
            out1 => out1,
            out2 => out2,
            out3 => out3
        );

    -- Test process
    test_proc: process
    begin
        en <= "0010"; 
        in0 <= "00";
        in1 <= "01"; 
        in2 <= "10";
        in3 <= "11"; 
        destination_in0 <= "00"; 
        destination_in1 <= "01";
        destination_in2 <= "10";
        destination_in3 <= "11";
        wait for 10 ns;

       
        en <= "0000"; 
        wait for 10 ns;

        en <= "0011";
        wait for 10 ns;
         
        en <= "0100"; 
        wait for 10 ns;

        en <= "0010"; 
        wait for 10 ns;

        en <= "1000";
        wait for 10 ns;
        
        en <= "1111"; 
        wait for 10 ns;

        -- Stop the simulation
        wait;
    end process;

end Behavioral;
