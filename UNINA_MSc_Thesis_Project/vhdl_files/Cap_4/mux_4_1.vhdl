library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_41 is
    port
    (
        i: in std_logic_vector(0 to 3);
        y: in std_logic_vector(1 downto 0);
        output: out std_logic
    );
end entity;

architecture Behavioral of mux_41 is
begin
    process(y, i)
    begin
        case y is
            when "00" => 
                output <= i(0);
            when "01" => 
                output <= i(1);
            when "10" => 
                output <= i(2);
            when "11" => 
                output <= i(3);
            when others =>
                output <= '-';
        end case;
    end process;
end architecture;