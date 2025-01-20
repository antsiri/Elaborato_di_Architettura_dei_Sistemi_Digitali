library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
  Port ( 
        CLK, RST: in STD_LOGIC; 
        load_s, load_m, load_h: in STD_LOGIC;
        value_in: in STD_LOGIC_VECTOR(5 downto 0);
        sec_out, min_out: out STD_LOGIC_VECTOR(5 downto 0);
        h_out: out STD_LOGIC_VECTOR(4 downto 0)
  );
end control_unit;

architecture Behavioral of control_unit is

signal sec_val, min_val: STD_LOGIC_VECTOR(5 downto 0);
signal h_val: STD_LOGIC_VECTOR(4 downto 0);

begin

sec_out <= sec_val;
min_out <= min_val;
h_out <= h_val;

main: process(CLK)
begin
    if (CLK'event AND CLK = '0') then
        if (RST = '1') then
            sec_val <= (others => '0');
            min_val <= (others => '0');
            h_val <= (others => '0');
        else
            if (load_s = '1') then
                sec_val <= value_in;
            elsif (load_m = '1') then
                min_val <= value_in;
            elsif (load_h = '1') then
                h_val <= value_in(4 downto 0);
            end if;
            end if;
            end if;
 end process;
                

end Behavioral;
