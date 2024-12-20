library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg is 
    port 
    (
        data_in:    in  std_logic;
        en:         in  std_logic;
        clk:        in  std_logic;
        rst:        in  std_logic;
        data_out:   out std_logic
    );
end entity;

architecture Behavioral of reg is
begin
    process(clk)
    begin
        if(rising_edge(clk))then
            if (rst = '1') then
                data_out <= '0';
            end if;
            
            if (en = '1') then
                data_out <= data_in;
            end if;
        end if;
    end process;
end architecture;